package com.ghayoun.ezjobs.comm.service;

import java.io.File;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

import javax.servlet.http.HttpServletRequest;

import org.quartz.JobDataMap;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.scheduling.quartz.QuartzJobBean;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.context.support.WebApplicationContextUtils;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.ghayoun.ezjobs.a.domain.AlertBean;
import com.ghayoun.ezjobs.comm.domain.CommonBean;
import com.ghayoun.ezjobs.comm.repository.CommonDao;
import com.ghayoun.ezjobs.comm.repository.QuartzDao;
import com.ghayoun.ezjobs.common.util.CommonUtil;
import com.ghayoun.ezjobs.common.util.SeedUtil;
import com.ghayoun.ezjobs.common.util.SendSms;
import com.ghayoun.ezjobs.common.util.Ssh2Util;
import com.ghayoun.ezjobs.common.util.SshUtil;
import com.ghayoun.ezjobs.common.util.TelnetUtil;
import com.ghayoun.ezjobs.common.util.TraceLogUtil;
import com.ghayoun.ezjobs.m.repository.CtmInfoDao;

public class EzResourceJobServiceImpl extends QuartzJobBean{

	protected final Log logger = LogFactory.getLog(getClass());
	private static final Lock QLOCK = new ReentrantLock();

	private QuartzDao quartzDao;
	private CommonDao commonDao;
	private CtmInfoDao ctmInfoDao;
	
	public void setQuartzDao(QuartzDao quartzDao) {
        this.quartzDao = quartzDao;
    }
	public void setCommonDao(CommonDao commonDao) {
        this.commonDao = commonDao;
    }
	public void setCtmInfoDao(CtmInfoDao ctmInfoDao) {
        this.ctmInfoDao = ctmInfoDao;
    }

	protected void executeInternal(JobExecutionContext jobExecutionContext) throws JobExecutionException {

		Map chkHostMap = CommonUtil.checkHost();

		String strHost 		= CommonUtil.isNull(chkHostMap.get("scode_host"));
		String strHostName 	= CommonUtil.isNull(chkHostMap.get("server_host"));
		Boolean chkHost 	= (Boolean) chkHostMap.get("chkHost");

		logger.debug("OS 호스트명1 : " + strHostName);
		logger.debug("코드관리 호스트명1 : " + strHost);
		logger.debug("호스트 체크 결과1 : " + chkHost);


		if(chkHost) {
			try {
				ezResourceJobServiceImplCall();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

	}

	public Map<String, Object> ezResourceJobServiceImplCall(){
		logger.info("#EzResourceJobServiceImplCall | Start~~~");

		String strServerGb 		= CommonUtil.isNull(CommonUtil.getMessage("SERVER_GUBUN"));
		String strCmSchema 		= CommonUtil.isNull(CommonUtil.getMessage("CM_SCHEMA"));
		String strSLogPath		= "";
		if ( strServerGb.equals("D") ) {
			strSLogPath = "/ezjobs_test/log_files/";
		} else {
			strSLogPath = "/ezjobs/log_files/";
		}

		// 로그 경로 가져오기.

		String strQuartzLogPath = CommonUtil.isNull(CommonUtil.getMessage("QUARTZ_LOG.PATH"));
		String strClassName	= this.getClass().getName().split("\\.")[this.getClass().getName().split("\\.").length-1];
		String strLogPath	= CommonUtil.getWebRootPath() + "/" + strQuartzLogPath + strClassName + "/";

		// 해당 폴더 없으면 생성.
		if ( !new File(strLogPath).exists() ) {
			new File(strLogPath).mkdirs();
		}

		Map<String, Object> map 	= new HashMap<String, Object>();
		Map<String, Object> logMap 	= new HashMap<String, Object>();
		Map<String, Object> rMap 	= new HashMap<String, Object>();


		try {
			List resourceList2 = new ArrayList();
			map.put("searchType", "dataCenterList");
			map.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
			map.put("CTMSVR_SCHEMA", CommonUtil.getMessage("CTMSVR.SCHEMA"));
			map.put("mcode_cd", "M6");
			List dataCenterList = commonDao.dGetSearchItemList(map);
			String aTmp[] = strCmSchema.split("[|]");
			if ( dataCenterList != null ) {
				for ( int i = 0; i < dataCenterList.size(); i++ ) {

					CommonBean bean = (CommonBean)dataCenterList.get(i);
					String strDataCenter 		= CommonUtil.isNull(bean.getData_center());
					String strDataCenterCode 	= CommonUtil.isNull(bean.getData_center_code());
					for(int p=0; p<aTmp.length; p++) {
						String aTmp1[] = aTmp[p].split(",");
						String cm_schema_code = aTmp1[0];
						String cm_schema = aTmp1[1];
						if(strDataCenterCode.equals(cm_schema_code)) {

							// 리소스 사용량 적재할 필요 없음 (온튠 모니터링 시스템에서 로그 파일을 모니터링. 2023.08.14 강명준)
							map.put("ctmuser", cm_schema);
							
							resourceList2 = ctmInfoDao.dGetResourceList(map);
							// DATA_CENTER 조회 후 List만큼 호출
							map.put("data_center", strDataCenter);
							System.out.println("strDataCenter : " + strDataCenter);
							map.put("data_center", strDataCenter);
							// ALARM -> EZ_ALARM으로 저장.
							if(cm_schema_code.equals("001")) {
								map.put("flag", "EZ_RESOURCE1");
							}else if(cm_schema_code.equals("002")) {
								map.put("flag", "EZ_RESOURCE2");
							}
							rMap = quartzDao.dPrcQuartz(map);
							String rCode 	= CommonUtil.isNull(rMap.get("r_code"));
							String rMsg		= "";

							if ( rCode.equals("-2") ) {
								rMsg 	= CommonUtil.isNull(rMap.get("r_msg"));
								TraceLogUtil.TraceLog("[" + rCode + "] : " + rMsg + ", EZ_RESOURCE에 등록 실패.", strLogPath, strClassName);
							} else {
								rMsg 	= CommonUtil.getMessage(CommonUtil.isNull(rMap.get("r_msg")));
								TraceLogUtil.TraceLog("[" + rCode + "] : " + rMsg + ", " + resourceList2.size() + "건 EZ_RESOURCE에 등록 완료.", strLogPath, strClassName);
							}

							//리소스 초과량
							String strResourceOverPer = "";
							CommonService commonService = (CommonService)CommonUtil.getSpringBean("commonService");
							map.clear();
//							map.put("mcode_cd", CommonUtil.getMessage("RESOURCE.PER.CODE"));
							map.put("mcode_cd", "M83");
							map.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
							List<CommonBean> codeList = commonService.dGetsCodeList(map);
							if( !codeList.isEmpty() ) {
								CommonBean codeBean = codeList.get(0);
								strResourceOverPer = CommonUtil.isNull(codeBean.getScode_nm());
							}

							int resourceOverPer = 999;
							if( !strResourceOverPer.equals("") ) {
								resourceOverPer = Integer.parseInt(strResourceOverPer);
							}
							//리소스 초과량

							//리소스 로그 경로
							String strResourceLogPath = "";
							map.clear();
//							map.put("mcode_cd", CommonUtil.getMessage("RESOURCE.LOG.CODE"));
							map.put("mcode_cd", "M84");
							map.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
							codeList = commonService.dGetsCodeList(map);
							if( !codeList.isEmpty() ) {
								CommonBean codeBean = codeList.get(0);
								strResourceLogPath = CommonUtil.isNull(codeBean.getScode_nm());
							}

							if( strResourceLogPath.equals("") ) {
								strResourceLogPath = strLogPath;
							}
							//리소스 로그 경로
							map.clear();
							map.put("ctmuser", cm_schema);
							map.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
							map.put("CTMSVR_SCHEMA", CommonUtil.getMessage("CTMSVR.SCHEMA"));
							
							List resourceList = ctmInfoDao.dGetResourceList(map);
							for(int k=0; k<resourceList.size(); k++) {
								CommonBean reSourceBean = (CommonBean)resourceList.get(k);
								String strQresname 	= CommonUtil.isNull(reSourceBean.getQresname());
								String strAgentId	= CommonUtil.isNull(reSourceBean.getAgent_id());
								String strQrTotal 	= CommonUtil.isNull(reSourceBean.getQrtotal(), "0");
								String strQrUsed 	= CommonUtil.isNull(reSourceBean.getQrused(), "0");

								double reSourcePer = (Double.parseDouble(strQrUsed)/Double.parseDouble(strQrTotal))*100;

								//reSourcePer = 81;
								if( (int)Math.round(reSourcePer) > resourceOverPer ) {

									System.out.println("[" + strQresname + "@" + strAgentId +"] 최대 리소스 : " + strQrTotal + "개 | 현재 리소스 : " + strQrUsed + "개 "+ reSourcePer + "% 사용중");

									//TraceLogUtil.TraceLog("[" + strQresname + "] 현재 " + reSourcePer + "%, " + resourceOverPer + "%를 초과 하였습니다.", strResourceLogPath, strClassName);
									TraceLogUtil.TraceLog("[" + strQresname + "@" + strAgentId +"] 최대 리소스 : " + strQrTotal + "개 | 현재 리소스 : " + strQrUsed + "개 "+ reSourcePer + "% 사용중", strResourceLogPath, strClassName);
									/*
									 * List userMgList = commonDao.dGetUserMgList(map); for(int j=0;
									 * j<userMgList.size(); j++) { CommonBean userBean =
									 * (CommonBean)userMgList.get(i);
									 *
									 * String strUserCd = CommonUtil.isNull(userBean.getUser_cd()); String strUserHp
									 * = CommonUtil.isNull(userBean.getUser_hp()); //리소스 발송을 막기위해 주석처리
									 * //smsSend(strUserHp, strUserCd, strQresname, data_center); }
									 */
								}

							}

							map.put("flag"			, "EZ_QUARTZ_LOG");
							map.put("quartz_name"	, "EZ_RESOURCE");
							map.put("trace_log_path", strLogPath);
							map.put("status_cd"		, rCode);
							map.put("status_log"	, rMsg);

							quartzDao.dPrcQuartz(map);
						}

					}


				}
			}
			logger.info("#EzResourceJobServiceImplCall | End~~~");
		} catch(Exception e) {
			TraceLogUtil.TraceLog(e.toString(), strLogPath, strClassName);
			logger.error("[" + strClassName+" Exception] : " + e);

		}
		return map;
	}
	// SMS 전송
	private void smsSend(String strUserHp, String strUserCd, String strQresname, String strDataCenter) {

		String strReturnMessage = "";
		try {

			System.out.println("SMS 발송 시도");
			String strTitle = strQresname+" Defined Resource의 80% 초과되었습니다.\n확인부탁드립니다.";
//			strReturnMessage = SendSms.smsCall(strUserHp, strTitle);
			//strReturnMessage = "발송 성공";

			System.out.println("strReturnMessage : " + strReturnMessage);
			String returnCode = "";

			if(strReturnMessage.indexOf("발송 성공") > -1){
				returnCode = "00";
			}else{
				returnCode = "01";
			}
			// 이력 저장
			Map<String, Object> sendMap = new HashMap<String, Object>();

			sendMap.put("flag", 		"send");
			sendMap.put("SCHEMA",		CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
			sendMap.put("data_center", 	strDataCenter);
			sendMap.put("job_name", 	strQresname);
			sendMap.put("order_id", 	"00000");
			sendMap.put("send_gubun", 	"S");
			sendMap.put("message", 		strTitle);
			sendMap.put("send_info", 	strUserHp);
			sendMap.put("send_user_cd", strUserCd);
			sendMap.put("return_code", returnCode);
			commonDao.dPrcLog(sendMap);
		} catch (Exception e) {

			System.out.println(e.toString());
		}
	}
}
