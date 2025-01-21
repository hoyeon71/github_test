package com.ghayoun.ezjobs.comm.service;

import com.ghayoun.ezjobs.comm.domain.CommonBean;
import com.ghayoun.ezjobs.comm.repository.CommonDao;
import com.ghayoun.ezjobs.comm.repository.QuartzDao;
import com.ghayoun.ezjobs.common.util.CommonUtil;
import com.ghayoun.ezjobs.common.util.TraceLogUtil;
import com.ghayoun.ezjobs.t.domain.UserBean;
import com.ghayoun.ezjobs.t.service.WorksUserService;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.scheduling.quartz.QuartzJobBean;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class EzAvgTimeOverJobServiceImpl extends QuartzJobBean{
	
	protected final Log logger = LogFactory.getLog(getClass());
	
	private QuartzDao quartzDao;
	private CommonDao commonDao;
	
	protected void executeInternal(JobExecutionContext jobExecutionContext) throws JobExecutionException {
		
		Map chkHostMap = CommonUtil.checkHost();
		
		String strHost 		= CommonUtil.isNull(chkHostMap.get("scode_host"));
		String strHostName 	= CommonUtil.isNull(chkHostMap.get("server_host"));
		Boolean chkHost 	= (Boolean) chkHostMap.get("chkHost");
		
		String rCode 	= "";
		String rMsg 	= "";
		
		logger.debug("OS 호스트명 : " + strHostName);
		logger.debug("코드관리 호스트명 : " + strHost);
		logger.debug("호스트 체크 결과 : " + chkHost);

		if(chkHost) {
			try {
				EzAvgTimeOverJobServiceImplCall();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

	public Map<String, Object> EzAvgTimeOverJobServiceImplCall() {
		
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
			WorksUserService worksUserService = (WorksUserService)CommonUtil.getSpringBean("tWorksUserService");
			
			List<CommonBean> dataCenterList = CommonUtil.getDataCenterList();
			
			if ( dataCenterList != null ) {
				for ( int i = 0; i < dataCenterList.size(); i++ ) {
					CommonBean bean = (CommonBean)dataCenterList.get(i);
					
					String activeNetName = CommonUtil.isNull(bean.getActive_net_name());
					map.put("active_net_name", activeNetName);
					String dataCenter = CommonUtil.isNull(bean.getData_center());
					String scode_cd = CommonUtil.isNull(bean.getScode_cd());
					map.put("data_center", scode_cd + "," + dataCenter);
					map.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
					
					List<UserBean> alarmInfoList = worksUserService.dGetAlarmInfo(map);
					for(int j = 0; j < alarmInfoList.size(); j++) {
						UserBean alarmInfoBean = alarmInfoList.get(j);
						
						String strAlarmMin		= CommonUtil.isNull(alarmInfoBean.getAlarm_min(), "0");
						String strAlarmMax		= CommonUtil.isNull(alarmInfoBean.getAlarm_max(), "0");
						String strAlarmUnit		= CommonUtil.isNull(alarmInfoBean.getAlarm_unit());
						String strAlarmTime		= CommonUtil.isNull(alarmInfoBean.getAlarm_time());
						String strAlarmTimeMent = "";
						
						if(strAlarmTime.equals("perform")) {
							strAlarmTimeMent			= "수행시간";
						}else if(strAlarmTime.equals("average")) {
							strAlarmTimeMent			= "평균시간";
						}
						
						String strAlarmOver		= CommonUtil.isNull(alarmInfoBean.getAlarm_over(), "0");
						String strAlarmOverOrg	= strAlarmOver;
						String strAlarmOverTime	= CommonUtil.isNull(alarmInfoBean.getAlarm_over_time());
						
						String strAlarmOverTimeMent	= "";
						if(strAlarmOverTime.equals("hour")) {
							strAlarmOverTimeMent = "시간";
						}else if(strAlarmOverTime.equals("min")) {
							strAlarmOverTimeMent = "분";
						}
						
						String strAlarmStandard	= CommonUtil.isNull(alarmInfoBean.getAlarm_standard());

						int alarmMin = 0;
						int alarmMax = 0;
						
						if(CommonUtil.NumberChk(strAlarmMin)) { if(strAlarmUnit.equals("hour")) {alarmMin = Integer.parseInt(strAlarmMin) * 60 * 60; } else {alarmMin = Integer.parseInt(strAlarmMin) * 60;} }
						if(CommonUtil.NumberChk(strAlarmMax)) { if(strAlarmUnit.equals("hour")) {alarmMax = Integer.parseInt(strAlarmMax) * 60 * 60; } else {alarmMax = Integer.parseInt(strAlarmMax) * 60;} }
						
						int alarmOver = 0;
						
						if(CommonUtil.NumberChk(strAlarmOver)) { if(strAlarmOverTime.equals("hour")) {alarmOver = Integer.parseInt(strAlarmOver) * 60 * 60; } else {alarmOver = Integer.parseInt(strAlarmOver) * 60;} }
						
						map.put("alarm_min"		, alarmMin);
						map.put("alarm_max"		, alarmMax);
						map.put("alarm_time"	, strAlarmTime);
						map.put("alarm_over"	, alarmOver);
						map.put("YY"			, CommonUtil.getMessage("CAL.YY"));
						
						List<CommonBean> avgTimeOverJobList = commonDao.dGetAvgTimeOverJobList(map);
						
						System.out.println("overRun 작업갯수 : " + avgTimeOverJobList.size());
						System.out.println("avgTimeOverJobList.size() : " + avgTimeOverJobList.size());

						// M75 : 오류 시 알림 발송 여부 체크
						Map<String, Object> paramMap 	= new HashMap<String, Object>();
						String strSendYn 				= "";

						paramMap.put("mcode_cd", 	"M86");
						paramMap.put("SCHEMA", 		CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
						List sCodeList = commonDao.dGetsCodeList(paramMap);

						if(sCodeList != null) {
							CommonBean commonBean = (CommonBean)sCodeList.get(0);
							strSendYn = CommonUtil.isNull(commonBean.getScode_eng_nm());
						}

						for(int k = 0; k < avgTimeOverJobList.size(); k++) {
							CommonBean avgTimeOverJobBean = avgTimeOverJobList.get(k);
							
							String strDataCenter	= CommonUtil.isNull(avgTimeOverJobBean.getData_center());
							String strOrderId		= CommonUtil.isNull(avgTimeOverJobBean.getOrder_id());
							String strJobName		= CommonUtil.isNull(avgTimeOverJobBean.getJob_name());
							String strDescription	= CommonUtil.isNull(avgTimeOverJobBean.getDescription());
							String strOdate			= CommonUtil.isNull(avgTimeOverJobBean.getOdate());
							String strRerunCounter	= CommonUtil.isNull(avgTimeOverJobBean.getRerun_counter());
							String strAvgRun		= CommonUtil.isNull(avgTimeOverJobBean.getAvg_run());
							String strStartTime		= CommonUtil.isNull(avgTimeOverJobBean.getStart_time());
							String strSendUserCd	= CommonUtil.isNull(avgTimeOverJobBean.getSend_user_cd());
							String strSendUserCd2	= CommonUtil.isNull(avgTimeOverJobBean.getSend_user_cd2());
							String strSendUserCd3	= CommonUtil.isNull(avgTimeOverJobBean.getSend_user_cd3());
							String strSendUserCd4	= CommonUtil.isNull(avgTimeOverJobBean.getSend_user_cd4());
							String strSendUserCd5	= CommonUtil.isNull(avgTimeOverJobBean.getSend_user_cd5());
							String strSendUserCd6	= CommonUtil.isNull(avgTimeOverJobBean.getSend_user_cd6());
							String strSendUserCd7	= CommonUtil.isNull(avgTimeOverJobBean.getSend_user_cd7());
							String strSendUserCd8	= CommonUtil.isNull(avgTimeOverJobBean.getSend_user_cd8());
							String strSendUserCd9	= CommonUtil.isNull(avgTimeOverJobBean.getSend_user_cd9());
							String strSendUserCd10	= CommonUtil.isNull(avgTimeOverJobBean.getSend_user_cd10());
							String strSendSms		= CommonUtil.isNull(avgTimeOverJobBean.getSend_sms());
							String strSendSms2		= CommonUtil.isNull(avgTimeOverJobBean.getSend_sms2());
							String strSendSms3		= CommonUtil.isNull(avgTimeOverJobBean.getSend_sms3());
							String strSendSms4		= CommonUtil.isNull(avgTimeOverJobBean.getSend_sms4());
							String strSendSms5		= CommonUtil.isNull(avgTimeOverJobBean.getSend_sms5());
							String strSendSms6		= CommonUtil.isNull(avgTimeOverJobBean.getSend_sms6());
							String strSendSms7		= CommonUtil.isNull(avgTimeOverJobBean.getSend_sms7());
							String strSendSms8		= CommonUtil.isNull(avgTimeOverJobBean.getSend_sms8());
							String strSendSms9		= CommonUtil.isNull(avgTimeOverJobBean.getSend_sms9());
							String strSendSms10		= CommonUtil.isNull(avgTimeOverJobBean.getSend_sms10());
							String strSendUserHp	= CommonUtil.isNull(avgTimeOverJobBean.getSend_user_hp());
							String strSendUserHp2	= CommonUtil.isNull(avgTimeOverJobBean.getSend_user_hp2());
							String strSendUserHp3	= CommonUtil.isNull(avgTimeOverJobBean.getSend_user_hp3());
							String strSendUserHp4	= CommonUtil.isNull(avgTimeOverJobBean.getSend_user_hp4());
							String strSendUserHp5	= CommonUtil.isNull(avgTimeOverJobBean.getSend_user_hp5());
							String strSendUserHp6	= CommonUtil.isNull(avgTimeOverJobBean.getSend_user_hp6());
							String strSendUserHp7	= CommonUtil.isNull(avgTimeOverJobBean.getSend_user_hp7());
							String strSendUserHp8	= CommonUtil.isNull(avgTimeOverJobBean.getSend_user_hp8());
							String strSendUserHp9	= CommonUtil.isNull(avgTimeOverJobBean.getSend_user_hp9());
							String strSendUserHp10	= CommonUtil.isNull(avgTimeOverJobBean.getSend_user_hp10());
							String strSstartTime	= CommonUtil.isNull(avgTimeOverJobBean.getS_start_time());
							String strSendTime		= CommonUtil.isNull(avgTimeOverJobBean.getS_end_time());
							String strRunTime		= CommonUtil.getDiffTime( CommonUtil.getDateFormat(1,strSstartTime),CommonUtil.getDateFormat(1,strSendTime));
							
							logger.debug("strRunTime : " + strRunTime);

							String strSendDesc = "AVG_OVERTIME";
							String send_desc_nm = CommonUtil.getMessage("JOB_SEND_STATUS."+strSendDesc);

							String strMsg = "";
							if(strAlarmTime.equals("perform")) {
								strMsg			= "[EZJOBS-"+send_desc_nm +"] 작업명 : " + strJobName + "("+strDescription+"), 평균수행시간 : " + strAvgRun + "인 작업이 현재 " + strRunTime + " 수행중입니다. (시작시간 : " + strStartTime + ") Odate : " + CommonUtil.getMessage("CAL.YY")+strOdate;
							}else if(strAlarmTime.equals("average")) {
								strMsg			= "[EZJOBS-"+send_desc_nm +"] 작업명 : " + strJobName + "("+strDescription+"), 평균수행시간 : " + strAvgRun + "인 작업이 현재 " + strRunTime + " 수행중입니다. (시작시간 : " + strStartTime + ") Odate : " + CommonUtil.getMessage("CAL.YY")+strOdate;
							}

							if(strSendYn.equals("Y")){
								if ( !strSendUserHp.equals("") && strSendSms.equals("Y") ) {
									smsSend(strJobName, strRerunCounter, strSendUserHp, strDataCenter, strSendUserCd, strOrderId, strMsg, strOdate, strSendDesc);
								}
								// 휴대폰 번호가 있는 사용자만 전송.
								if ( !strSendUserHp2.equals("") && strSendSms2.equals("Y") ) {
									smsSend(strJobName, strRerunCounter, strSendUserHp2, strDataCenter, strSendUserCd2, strOrderId, strMsg, strOdate, strSendDesc);
								}
								// 휴대폰 번호가 있는 사용자만 전송.
								if ( !strSendUserHp3.equals("") && strSendSms3.equals("Y") ) {
									smsSend(strJobName, strRerunCounter, strSendUserHp3, strDataCenter, strSendUserCd3, strOrderId, strMsg, strOdate, strSendDesc);
								}
								// 휴대폰 번호가 있는 사용자만 전송.
								if ( !strSendUserHp4.equals("") && strSendSms4.equals("Y") ) {
									smsSend(strJobName, strRerunCounter, strSendUserHp4, strDataCenter, strSendUserCd4, strOrderId, strMsg, strOdate, strSendDesc);
								}
								// 휴대폰 번호가 있는 사용자만 전송.
								if ( !strSendUserHp5.equals("") && strSendSms5.equals("Y") ) {
									smsSend(strJobName, strRerunCounter, strSendUserHp5, strDataCenter, strSendUserCd5, strOrderId, strMsg, strOdate, strSendDesc);
								}
								// 휴대폰 번호가 있는 사용자만 전송.
								if ( !strSendUserHp6.equals("") && strSendSms6.equals("Y") ) {
									smsSend(strJobName, strRerunCounter, strSendUserHp6, strDataCenter, strSendUserCd6, strOrderId, strMsg, strOdate, strSendDesc);
								}
								// 휴대폰 번호가 있는 사용자만 전송.
								if ( !strSendUserHp7.equals("") && strSendSms7.equals("Y") ) {
									smsSend(strJobName, strRerunCounter, strSendUserHp7, strDataCenter, strSendUserCd7, strOrderId, strMsg, strOdate, strSendDesc);
								}
								// 휴대폰 번호가 있는 사용자만 전송.
								if ( !strSendUserHp8.equals("") && strSendSms8.equals("Y") ) {
									smsSend(strJobName, strRerunCounter, strSendUserHp8, strDataCenter, strSendUserCd8, strOrderId, strMsg, strOdate, strSendDesc);
								}
								// 휴대폰 번호가 있는 사용자만 전송.
								if ( !strSendUserHp9.equals("") && strSendSms9.equals("Y") ) {
									smsSend(strJobName, strRerunCounter, strSendUserHp9, strDataCenter, strSendUserCd9, strOrderId, strMsg, strOdate, strSendDesc);
								}
								// 휴대폰 번호가 있는 사용자만 전송.
								if ( !strSendUserHp10.equals("") && strSendSms10.equals("Y") ) {
									smsSend(strJobName, strRerunCounter, strSendUserHp10, strDataCenter, strSendUserCd10, strOrderId, strMsg, strOdate, strSendDesc);
								}
							}
							
							// 이력 저장
							Map<String, Object> overSendMap = new HashMap<String, Object>();
							
							overSendMap.put("flag"				, "overSend");
							overSendMap.put("order_id"			, strOrderId);
							overSendMap.put("odate"				, strOdate);
							overSendMap.put("data_center"		, strDataCenter);
							overSendMap.put("job_name"			, strJobName);
							overSendMap.put("description"		, strDescription);
							overSendMap.put("avg_runtime"		, strAvgRun);
							overSendMap.put("alarm_standard"	, strAlarmStandard);
							overSendMap.put("alarm_time"		, strAlarmTime);
							overSendMap.put("alarm_over"		, strAlarmOver);
							overSendMap.put("alarm_over_time"	, strAlarmOverTime);
							overSendMap.put("send_description"	, strSendDesc);
							overSendMap.put("SCHEMA"			, CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
							
							System.out.println("overSendMap : " + overSendMap);

							try {
								commonDao.dPrcLog(overSendMap);
							}catch (Exception e) {
								logger.info("EzAvgTimeOver dPrcLog Exception========"+e.getMessage());
							}
						}
					}
				}
				rCode = "1";
				rMsg = "처리완료";
				
				map.put("flag"			, "EZ_QUARTZ_LOG");
				map.put("quartz_name"	, "EZ_AVG_OVERTIME");
				map.put("trace_log_path", strLogPath);
				map.put("status_cd"		, rCode);
				map.put("status_log"	, rMsg);

				quartzDao.dPrcQuartz(map);
			}
		} catch(Exception e) {
			TraceLogUtil.TraceLog(e.toString(), strLogPath, strClassName);
			logger.error("[" + strClassName+" Exception] : " + e);
			
		}
		return rMap;
	}
			
	
	// SMS 전송
	private void smsSend(String strJobName, String strRerunCounter, String strSendUserHp, String strDataCenter, String strSendUserCd, String strOrderId, String strMsg, String strOdate, String strSendDesc) {
		
		String strReturnMessage = "";
		try {
			WorksUserService worksUserService = (WorksUserService)CommonUtil.getSpringBean("tWorksUserService");
			System.out.println("strJobName : " + strJobName);
			System.out.println("strUserHp : " + strSendUserHp);
			System.out.println("SMS 발송 시도");
			
			String strServerGb 		= CommonUtil.isNull(CommonUtil.getMessage("SERVER_GB"));

			// 개발은 발송 X
			if ( strServerGb.equals("D") ) {
				strReturnMessage = "발송 성공";
			} else {
				//strReturnMessage = SendSms.smsCall(strSendUserHp, strMsg);
				strReturnMessage = "발송 보류";
			}

			System.out.println("strReturnMessage : " + strReturnMessage);
			String returnCode = "";
			
			if(strReturnMessage.indexOf("발송 성공") > -1){
				returnCode = "00";
			}else{
				returnCode = "01";
			}

			logger.debug("SMS 발송 후 이력 저장");

			// 이력 저장
			Map<String, Object> sendMap = new HashMap<String, Object>();
			
			sendMap.put("flag"			, "send");
			sendMap.put("SCHEMA"		, CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
			sendMap.put("data_center"	, strDataCenter);
			sendMap.put("order_id"		, strOrderId);
			sendMap.put("job_name"		, strJobName);
			sendMap.put("send_gubun"	, "S");			// 코드관리 M51 참고하여 수정 필요
			sendMap.put("message"		, strMsg);
			sendMap.put("send_info"		, strSendUserHp);
			sendMap.put("send_user_cd"	, strSendUserCd);
			sendMap.put("return_code"	, returnCode);
			sendMap.put("send_desc"		, strSendDesc);
			sendMap.put("rerun_counter"	, strRerunCounter);
			sendMap.put("send_description"	, strSendDesc);
			
			System.out.println("sendMap : " + sendMap);

			Map<String, Object> rMap = new HashMap<String, Object>();
			try {
				rMap = 	commonDao.dPrcLog(sendMap);
				System.out.println("rMap : " + rMap);
			}catch (Exception e) {
				logger.info("EzAvgTimeOver dPrcLog Exception========"+e.getMessage());
			}

		} catch (Exception e) {
			System.out.println(e.toString());
		}
	}
	
}
