package com.ghayoun.ezjobs.comm.service;

import java.io.File;
import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.quartz.JobDataMap;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.scheduling.quartz.QuartzJobBean;
import com.ghayoun.ezjobs.comm.domain.CommonBean;
import com.ghayoun.ezjobs.comm.repository.CommonDao;
import com.ghayoun.ezjobs.comm.repository.QuartzDao;
import com.ghayoun.ezjobs.common.util.CommonUtil;
import com.ghayoun.ezjobs.common.util.SeedUtil;
import com.ghayoun.ezjobs.common.util.Ssh2Util;
import com.ghayoun.ezjobs.common.util.TelnetUtil;
import com.ghayoun.ezjobs.common.util.TraceLogUtil;

public class EzRplnJobServiceImpl extends QuartzJobBean{

	protected final Log logger = LogFactory.getLog(getClass());

	private QuartzDao quartzDao;
	private CommonDao commonDao;

	protected void executeInternal(JobExecutionContext jobExecutionContext) throws JobExecutionException {

		Map chkHostMap = CommonUtil.checkHost();
		
		JobDataMap jobDataMap = jobExecutionContext.getJobDetail().getJobDataMap();
		String strCode = jobDataMap.getString("code");

		String strHost 		= CommonUtil.isNull(chkHostMap.get("scode_host"));
		String strHostName 	= CommonUtil.isNull(chkHostMap.get("server_host"));
		Boolean chkHost 	= (Boolean) chkHostMap.get("chkHost");
		
		logger.debug("OS 호스트명 : " + strHostName);
		logger.debug("코드관리 호스트명 : " + strHost);
		logger.debug("호스트 체크 결과 : " + chkHost);
		if(chkHost) {
			try {
				ezRplnJobServiceImplCall(strCode);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

	public Map<String, Object> ezRplnJobServiceImplCall(String strCode) {

		logger.info("ezRplnJobServiceImplCall quartz start :::::::: ");

		quartzDao = (QuartzDao) CommonUtil.getSpringBean("quartzDao");
		commonDao = (CommonDao) CommonUtil.getSpringBean("commonDao");

		String strDataDir		= "EZJOBS/CTMRPLN/";
		String strShFileNm		= "forecast.sh";

		Map<String, Object> paramMap = new HashMap<String, Object>();

		// 로그 경로 가져오기.
		String strQuartzLogPath = CommonUtil.isNull(CommonUtil.getMessage("QUARTZ_LOG.PATH"));
		String strClassName	= this.getClass().getName().split("\\.")[this.getClass().getName().split("\\.").length-1];
		String strLogPath	= CommonUtil.getWebRootPath() + "/" + strQuartzLogPath + strClassName + "/";

		// 해당 폴더 없으면 생성.
		if ( !new File(strLogPath).exists() ) {
			new File(strLogPath).mkdirs();
		}

		// 해당 폴더 없으면 생성.
		if ( !new File(strDataDir).exists() ) {
			new File(strDataDir).mkdirs();
		}

		Map<String, Object> map 	= new HashMap<String, Object>();
		Map<String, Object> rMap 	= new HashMap<String, Object>();

		String strHost 				= "";
		String strAccessGubun		= "";
		int iPort 					= 0;
		String strUserId 			= "";
		String strUserPw 			= "";
		String strDataCenter		= "";
		String strCtmCode			= "";

		try {

			List<CommonBean> dataCenterList = CommonUtil.getDataCenterList();

			for(int i=0; i<dataCenterList.size(); i++){
				CommonBean bean = (CommonBean)dataCenterList.get(i);

				String strDataCenterCode 	= CommonUtil.isNull(bean.getData_center_code());

				if ( strCode.equals(strDataCenterCode) ) {
				strDataCenter = CommonUtil.isNull(bean.getData_center());
					strCtmCode		= CommonUtil.isNull(bean.getScode_cd());
				}
			}

			paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));

			// Host 정보 가져오는 서비스.
			paramMap.put("data_center"	, strCtmCode + "," + strDataCenter);
			paramMap.put("host"			, strDataCenter);
			paramMap.put("server_gubun"	, "S");

			CommonBean bean = commonDao.dGetHostInfo(paramMap);

			if ( bean != null ) {

				strHost 			= CommonUtil.isNull(bean.getNode_id());
				strAccessGubun		= CommonUtil.isNull(bean.getAccess_gubun());
				iPort 				= Integer.parseInt(CommonUtil.isNull(bean.getAccess_port()));
				strUserId 			= CommonUtil.isNull(bean.getAgent_id());
				strUserPw 			= SeedUtil.decodeStr(CommonUtil.isNull(bean.getAgent_pw()));
			}



		} catch (Exception e) {
			e.printStackTrace();
		}

		String forecast 		= "";

		try {

			if(!"".equals(strHost)){

				String cmd = strDataDir + strShFileNm +  "> /dev/null && cat " + strDataDir + "DATA/ctmrpln.dat";

				if( "S".equals(strAccessGubun) ){
					Ssh2Util su = new Ssh2Util(strHost, iPort, strUserId, strUserPw, cmd, "UTF-8");
					forecast = su.getOutput();

				}else{
					TelnetUtil tu = new TelnetUtil(strHost, iPort, strUserId, strUserPw, cmd);
					forecast = tu.getOutput();
				}
				
				// SSH 통신 오류 발생 시 로직 중단 (2023.05.18 강명준) 
				if ( forecast.indexOf("[Ssh2Util ERROR]") > -1 ) {
					rMap.put("r_msg", forecast);
					throw new Exception(forecast);
				}

				String strLine				= "";

				String[] arrForecast = null;
				//int rsCnts = 0;

				arrForecast = forecast.split("\n");

				map.put("SCHEMA",	CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));

				map.put("data_center",		strDataCenter);
				map.put("flag",		"forecast_del");
				rMap = quartzDao.dPrcQuartz(map);

				for ( int i = 0; i < arrForecast.length; i++ ) {

					if ( arrForecast[i].length() > 1 ) {
						
						try {
						
							System.out.println("arrForecast[i] : " + arrForecast[i]);
	
							String[] arrLine			= arrForecast[i].split("\\,");
	
			    			String strJobName			= arrLine[0];
	
			    			if ( !strJobName.equals("") ) {
	
			    				String strOdate				= arrLine[1].substring(0, 8);
	
				    			map.put("flag", 			"forecast");
				    			map.put("data_center_code",	strDataCenter);
				    			map.put("job_name", 		strJobName);
				    			map.put("odate", 			strOdate);
	
				    			rMap = quartzDao.dPrcQuartz(map);
			    			}
			    			
						} catch(Exception e) {
							TraceLogUtil.TraceLog(e.toString(), strLogPath, "EzRplnJobService");
							logger.error("[EzRplnJobService Exception] : " + e);
							
							// 오류 발생 시 오류 메시지 출력
							//rMap.put("r_msg", e);
						}
					}
				}

				rMap.put("r_code", "1");

			} else {

				forecast = "-1";
			}

			String rCode 	= CommonUtil.isNull(rMap.get("r_code"));
			String rMsg 	= CommonUtil.getMessage(CommonUtil.isNull(rMap.get("r_msg")));

			map.clear();
			// 이력 저장

			map.put("SCHEMA",			CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
			map.put("flag", 			"EZ_QUARTZ_LOG");
			map.put("quartz_name"	, 	"EZ_RPLNJOB"+"_"+strCode);
			map.put("trace_log_path", 	strLogPath);
			map.put("status_cd"		, 	rCode);
			map.put("status_log"	, 	rMsg);

			quartzDao.dPrcQuartz(map);

			TraceLogUtil.TraceLog("[" + rCode + "] : " + rMsg, strLogPath, "EzRplnJobService");

		} catch(Exception e) {
			TraceLogUtil.TraceLog(e.toString(), strLogPath, "EzRplnJobService");
			logger.error("[EzRplnJobService Exception] : " + e);
			
			// 오류 발생 시 오류 메시지 출력
			rMap.put("r_msg", e);

		}

		return rMap;
	}
}
