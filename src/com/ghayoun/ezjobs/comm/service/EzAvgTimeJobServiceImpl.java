package com.ghayoun.ezjobs.comm.service;

import java.io.File;
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
import com.ghayoun.ezjobs.common.util.TraceLogUtil;

public class EzAvgTimeJobServiceImpl extends QuartzJobBean{
	
	protected final Log logger = LogFactory.getLog(getClass());
	
	private QuartzDao quartzDao;
	private CommonDao commonDao;
	
	protected void executeInternal(JobExecutionContext jobExecutionContext) throws JobExecutionException {
		Map chkHostMap = CommonUtil.checkHost();
		
		String strHost 		= CommonUtil.isNull(chkHostMap.get("scode_host"));
		String strHostName 	= CommonUtil.isNull(chkHostMap.get("server_host"));
		Boolean chkHost 	= (Boolean) chkHostMap.get("chkHost");
		
		logger.debug("OS 호스트명 : " + strHostName);
		logger.debug("코드관리 호스트명 : " + strHost);
		logger.debug("호스트 체크 결과 : " + chkHost);
		
		if(chkHost) {
			try {
				EzAvgTimeJobServiceImplCall();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
	
	public Map<String, Object> EzAvgTimeJobServiceImplCall() throws Exception {
		
		logger.info("EzAvgTimeJobServiceImpl START");
		
		quartzDao = (QuartzDao) CommonUtil.getSpringBean("quartzDao");
		commonDao = (CommonDao) CommonUtil.getSpringBean("commonDao");
		
		String strQuartzLogPath = CommonUtil.isNull(CommonUtil.getMessage("QUARTZ_LOG.PATH"));

		// 로그 경로 가져오기.
		String strClassName	= this.getClass().getName().split("\\.")[this.getClass().getName().split("\\.").length-1];
		String strLogPath	= CommonUtil.getWebRootPath() + "/" + strQuartzLogPath + strClassName + "/";
		
		// 해당 폴더 없으면 생성.
		if ( !new File(strLogPath).exists() ) {		
			new File(strLogPath).mkdirs();
		}

		Map<String, Object> map 	= new HashMap<String, Object>();
		Map<String, Object> rMap 	= new HashMap<String, Object>();

		String rCode 	= "";	
		String rMsg 	= "";
		
		try {
			
			map.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
			
			map.put("searchType", "dataCenterList");
			map.put("mcode_cd", "M6");
			List dataCenterList = commonDao.dGetSearchItemList(map);
			
			if ( dataCenterList != null ) {
				for ( int i = 0; i < dataCenterList.size(); i++ ) {
					CommonBean bean = (CommonBean)dataCenterList.get(i);
					String strDataCenter = CommonUtil.isNull(bean.getData_center());
					// DATA_CENTER 조회 후 List만큼 호출
					map.put("flag", 			"EZ_AVG_TIME");
					map.put("data_center", strDataCenter);

					rMap = quartzDao.dPrcQuartz(map);
					
				}
			}
			
			rCode 	= CommonUtil.isNull(rMap.get("r_code"));
			rMsg 	= CommonUtil.isNull(rMap.get("r_msg"));
			
			if ( rCode.equals("-2") ) {
				rMsg 	= CommonUtil.isNull(rMap.get("r_msg"));
			} else {
				rMsg 	= CommonUtil.getMessage(CommonUtil.isNull(rMap.get("r_msg")));
			}			
			
			TraceLogUtil.TraceLog("[" + rCode + "] : " + rMsg, strLogPath, strClassName);
			
			map.put("flag"			, "EZ_QUARTZ_LOG");
			map.put("quartz_name"	, "EZ_AVG_TIME");
			map.put("trace_log_path", strLogPath);
			map.put("status_cd"		, rCode);
			map.put("status_log"	, rMsg);

			quartzDao.dPrcQuartz(map);
			
		} catch(Exception e) {
			TraceLogUtil.TraceLog(e.toString(), strLogPath, strClassName);
			logger.error("[EzAvgTimeJobService Exception] : " + e);
			
		}
		return rMap;
	}
}
