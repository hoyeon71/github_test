package com.ghayoun.ezjobs.comm.service;

import java.io.File;
import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.quartz.JobDataMap;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.scheduling.quartz.QuartzJobBean;

import com.ghayoun.ezjobs.a.domain.AlertBean;
import com.ghayoun.ezjobs.comm.domain.CommonBean;
import com.ghayoun.ezjobs.comm.repository.CommonDao;
import com.ghayoun.ezjobs.comm.repository.QuartzDao;
import com.ghayoun.ezjobs.common.util.CommonUtil;
import com.ghayoun.ezjobs.common.util.SendSmsDb;
import com.ghayoun.ezjobs.common.util.TraceLogUtil;
import com.ghayoun.ezjobs.m.domain.CtmInfoBean;
import com.ghayoun.ezjobs.m.repository.CtmInfoDao;
import com.ghayoun.ezjobs.t.domain.UserBean;
import com.ghayoun.ezjobs.t.service.WorksApprovalDocService;

public class EzDeletedJobServiceImpl extends QuartzJobBean{
	
	protected final Log logger = LogFactory.getLog(getClass());
	
	private QuartzDao quartzDao;
	private CommonDao commonDao;
	private WorksApprovalDocService worksApprovalDocService;

	protected void executeInternal(JobExecutionContext jobExecutionContext) throws JobExecutionException {

		Map chkHostMap = CommonUtil.checkHost();
		
		JobDataMap jobDataMap = jobExecutionContext.getJobDetail().getJobDataMap();
		String strCode = jobDataMap.getString("code");

		String strHost 		= CommonUtil.isNull(chkHostMap.get("scode_host"));
		String strHostName 	= CommonUtil.isNull(chkHostMap.get("server_host"));
		Boolean chkHost 	= (Boolean) chkHostMap.get("chkHost");
		
		logger.debug("OS 호스트명 : " + strHostName + "| 코드관리 호스트명 : " + strHost + "| 호스트 체크 결과 : " + chkHost);

		if(chkHost) {
			try {
				ezDeletedJobServiceImplCall();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
	
	public Map<String, Object> ezDeletedJobServiceImplCall() {
		
		logger.info("EzDeletedJobServiceImpl START");
		
		quartzDao = (QuartzDao) CommonUtil.getSpringBean("quartzDao");
		commonDao = (CommonDao) CommonUtil.getSpringBean("commonDao");
		
		Map<String, Object> map 	= new HashMap<String, Object>();
		Map<String, Object> map2 	= new HashMap<String, Object>();
		Map<String, Object> rMap 	= new HashMap<String, Object>();
		Map<String, Object> rMap2 	= new HashMap<String, Object>();
		
		List userGroup1List = null;
		
		String strQuartzLogPath = CommonUtil.isNull(CommonUtil.getMessage("QUARTZ_LOG.PATH"));
		String strServerGb 		= CommonUtil.isNull(CommonUtil.getMessage("SERVER_GB"));
		String strServerGbMent	= "";

		// 로그 경로 가져오기.
		String strClassName	= this.getClass().getName().split("\\.")[this.getClass().getName().split("\\.").length-1];
		String strLogPath	= CommonUtil.getWebRootPath() + "/" + strQuartzLogPath + strClassName + "/";
		
		// 해당 폴더 없으면 생성.
		if ( !new File(strLogPath).exists() ) {
			new File(strLogPath).mkdirs();
		}
		
		String rCode 	= "1";
		String rMsg 	= "처리완료";
		
		try {
			
			map.put("SCHEMA", 		CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
			
			List alarmJobList = quartzDao.deletedJobAlarmList(map);
			
			if( alarmJobList != null && alarmJobList.size() > 0 ) {
								
				// M98 : 선행 작업 삭제 알림 발송 여부 체크
				Map<String, Object> paramMap 	= new HashMap<String, Object>();
				String alarmYn 					= "";

				paramMap.put("mcode_cd", 	"M98");
				paramMap.put("SCHEMA", 		CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
				List sCodeList = commonDao.dGetsCodeList(paramMap);

				if(sCodeList != null) {
					CommonBean commonBean = (CommonBean)sCodeList.get(0);
					alarmYn = CommonUtil.isNull(commonBean.getScode_eng_nm());
				}
				
				
				if( alarmYn.equals("Y") ) {
					for ( int j = 0; j < alarmJobList.size(); j++ ) {
					AlertBean bean = (AlertBean)alarmJobList.get(j);
					
					String strDataCenter 		= CommonUtil.isNull(bean.getData_center());
					String strUserId1 			= CommonUtil.isNull(bean.getUser_id());
					String strUserId2 			= CommonUtil.isNull(bean.getUser_id2());
					String strUserId3 			= CommonUtil.isNull(bean.getUser_id3());
					String strUserId4 			= CommonUtil.isNull(bean.getUser_id4());
					String strUserId5 			= CommonUtil.isNull(bean.getUser_id5());
					String strUserId6 			= CommonUtil.isNull(bean.getUser_id6());
					String strUserId7 			= CommonUtil.isNull(bean.getUser_id7());
					String strUserId8 			= CommonUtil.isNull(bean.getUser_id8());
					String strUserId9 			= CommonUtil.isNull(bean.getUser_id9());
					String strUserId10 			= CommonUtil.isNull(bean.getUser_id10());
					String strUserCd1 			= CommonUtil.isNull(bean.getUser_cd());
					String strUserCd2 			= CommonUtil.isNull(bean.getUser_cd_2());
					String strUserCd3 			= CommonUtil.isNull(bean.getUser_cd_3());
					String strUserCd4 			= CommonUtil.isNull(bean.getUser_cd_4());
					String strUserCd5 			= CommonUtil.isNull(bean.getUser_cd_5());
					String strUserCd6 			= CommonUtil.isNull(bean.getUser_cd_6());
					String strUserCd7 			= CommonUtil.isNull(bean.getUser_cd_7());
					String strUserCd8 			= CommonUtil.isNull(bean.getUser_cd_8());
					String strUserCd9 			= CommonUtil.isNull(bean.getUser_cd_9());
					String strUserCd10 			= CommonUtil.isNull(bean.getUser_cd_10());
					String strUserHp1			= CommonUtil.isNull(bean.getUser_hp());
					String strUserHp2 			= CommonUtil.isNull(bean.getUser_hp2());
					String strUserHp3 			= CommonUtil.isNull(bean.getUser_hp3());
					String strUserHp4 			= CommonUtil.isNull(bean.getUser_hp4());
					String strUserHp5 			= CommonUtil.isNull(bean.getUser_hp5());
					String strUserHp6 			= CommonUtil.isNull(bean.getUser_hp6());
					String strUserHp7 			= CommonUtil.isNull(bean.getUser_hp7());
					String strUserHp8 			= CommonUtil.isNull(bean.getUser_hp8());
					String strUserHp9 			= CommonUtil.isNull(bean.getUser_hp9());
					String strUserHp10 			= CommonUtil.isNull(bean.getUser_hp10());
					String strUserEmail1 		= CommonUtil.isNull(bean.getUser_email());
					String strUserEmail2 		= CommonUtil.isNull(bean.getUser_email2());
					String strUserEmail3 		= CommonUtil.isNull(bean.getUser_email3());
					String strUserEmail4 		= CommonUtil.isNull(bean.getUser_email4());
					String strUserEmail5 		= CommonUtil.isNull(bean.getUser_email5());
					String strUserEmail6 		= CommonUtil.isNull(bean.getUser_email6());
					String strUserEmail7 		= CommonUtil.isNull(bean.getUser_email7());
					String strUserEmail8 		= CommonUtil.isNull(bean.getUser_email8());
					String strUserEmail9 		= CommonUtil.isNull(bean.getUser_email9());
					String strUserEmail10 		= CommonUtil.isNull(bean.getUser_email10());
					String strJobName 			= CommonUtil.isNull(bean.getJob_name());
					String strGrpCd1			= CommonUtil.isNull(bean.getGrp_cd_1());
					String strGrpCd2			= CommonUtil.isNull(bean.getGrp_cd_2());
					
					String strTitle				= "";
					
					ArrayList<String> user_cds  		= new ArrayList<String>();
					ArrayList<String> mail_user_cds 	= new ArrayList<String>();
					
					if ( strServerGb.equals("D") ) {
						strServerGbMent = "[작업관리시스템-개발] ";
					} else if ( strServerGb.equals("T") ) {
						strServerGbMent = "[작업관리시스템-테스트] ";
					} else if ( strServerGb.equals("P") ) {
						strServerGbMent = "[작업관리시스템-운영] ";
					}
					
					strTitle = 	strServerGbMent + "\n 작업명: " + strJobName + "의 선행 작업이 삭제 되었습니다. 확인 바랍니다.";
					
						if( alarmYn.equals("Y") ) {
							
							// SMS 전송
							if (!strUserCd1.equals("") && !strUserHp1.equals("") ) {
								sendSmsDb(strUserHp1, strJobName, strDataCenter, strUserCd1, strTitle);
								user_cds.add(strUserCd1);
							}
							if (!strUserCd2.equals("") && !strUserHp2.equals("") ) {
								sendSmsDb(strUserHp2, strJobName, strDataCenter, strUserCd2, strTitle);
								user_cds.add(strUserCd2);
							}
							if (!strUserCd3.equals("") && !strUserHp3.equals("") ) {
								sendSmsDb(strUserHp3, strJobName, strDataCenter, strUserCd3, strTitle);
								user_cds.add(strUserCd3);
							}
							if (!strUserCd4.equals("") && !strUserHp4.equals("") ) {
								sendSmsDb(strUserHp4, strJobName, strDataCenter, strUserCd4, strTitle);
								user_cds.add(strUserCd4);
							}
							if (!strUserCd5.equals("") && !strUserHp5.equals("") ) {
								sendSmsDb(strUserHp5, strJobName, strDataCenter, strUserCd5, strTitle);
								user_cds.add(strUserCd5);
							}
							if (!strUserCd6.equals("") && !strUserHp6.equals("") ) {
								sendSmsDb(strUserHp6, strJobName, strDataCenter, strUserCd6, strTitle);
								user_cds.add(strUserCd6);
							}
							if (!strUserCd7.equals("") && !strUserHp7.equals("") ) {
								sendSmsDb(strUserHp7, strJobName, strDataCenter, strUserCd7, strTitle);
								user_cds.add(strUserCd7);
							}
							if (!strUserCd8.equals("") && !strUserHp8.equals("") ) {
								sendSmsDb(strUserHp8, strJobName, strDataCenter, strUserCd8, strTitle);
								user_cds.add(strUserCd8);
							}
							if (!strUserCd9.equals("") && !strUserHp9.equals("") ) {
								sendSmsDb(strUserHp9, strJobName, strDataCenter, strUserCd9, strTitle);
								user_cds.add(strUserCd9);
							}
							if (!strUserCd10.equals("") && !strUserHp10.equals("") ) {
								sendSmsDb(strUserHp10, strJobName, strDataCenter, strUserCd10, strTitle);
								user_cds.add(strUserCd10);
							}

							// 담당자그룹 SMS 전송
							if(!strGrpCd1.equals("") ){
								rMap2.put("group_user_group_cd", strGrpCd1);
								rMap2.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
								userGroup1List = commonDao.dGetGroupUserLine(rMap2);

								for ( int ii = 0; ii < userGroup1List.size(); ii++ ) {
									CommonBean bean2 = (CommonBean)userGroup1List.get(ii);
									String group_user_cd 		= CommonUtil.isNull(bean2.getUser_cd());
									String group_user_id 		= CommonUtil.isNull(bean2.getUser_id());
									String group_user_hp		= CommonUtil.isNull(bean2.getUser_hp());

									if (!group_user_hp.equals("") && !(user_cds.indexOf(group_user_cd) > -1)) {
										sendSmsDb(group_user_hp, strJobName, strDataCenter, group_user_cd, strTitle);
										user_cds.add(group_user_cd);
									}else{
										logger.info("그룹1_중복유저::"+group_user_id);
									}
								}
							}
							if(!strGrpCd2.equals("") ){
								rMap2.put("group_user_group_cd", strGrpCd2);
								rMap2.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
								userGroup1List = commonDao.dGetGroupUserLine(rMap2);

								for ( int ii = 0; ii < userGroup1List.size(); ii++ ) {
									CommonBean bean2 = (CommonBean)userGroup1List.get(ii);
									String group_user_cd 		= CommonUtil.isNull(bean2.getUser_cd());
									String group_user_id 		= CommonUtil.isNull(bean2.getUser_id());
									String group_user_hp		= CommonUtil.isNull(bean2.getUser_hp());

									if (!group_user_hp.equals("") && !(user_cds.indexOf(group_user_cd) > -1)) {
										sendSmsDb(group_user_hp, strJobName, strDataCenter, group_user_cd, strTitle);
										user_cds.add(group_user_cd);
									}else{
										logger.info("그룹2_중복유저::"+group_user_id);
									}
								}
							}
						}
					}
				}
			}
			
			
			map.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));

			TraceLogUtil.TraceLog("[" + rCode + "] : " + rMsg, strLogPath, "EzDeletedJobServiceImpl");
			
			map.put("flag"			, "EZ_QUARTZ_LOG");
			map.put("quartz_name"	, "EZ_DELETED_JOB_ALARM");
			map.put("trace_log_path", strLogPath);
			map.put("status_cd"		, rCode);
			map.put("status_log"	, rMsg);
			
			quartzDao.dPrcQuartz(map);
			
			
		} catch(Exception e) {
			TraceLogUtil.TraceLog(e.toString(), strLogPath, "EzDeletedJobServiceImpl");
			logger.error("[EzDeletedJobServiceImpl Exception] : " + e);
			
		}
		
		logger.info("EzDeletedJobServiceImpl END");
		
		return rMap;
	}
	
	// SMS 전송. (DB INSERT)
	private void sendSmsDb(String strUserHp, String strJobName, String strDataCenter, String strUserCd, String strTitle) {

		try {
			
			Map<String, Object> rMap = new HashMap<String, Object>();
			Map<String, Object> rMap2 = new HashMap<String, Object>();
			commonDao = (CommonDao) CommonUtil.getSpringBean("commonDao");

			logger.info("SMS Send Start =================");

			String fullMsg = strTitle;
			
			logger.info("fullMsg : " + fullMsg);
			
			//사무실에서는 성공 처리
//			int iReturnCode = SendSmsDb.sendSmsDb(strUserHp, fullMsg);
			
			int iReturnCode = 1;

			String strReturnMessage	= "";
			String returnCode 		= "";
			String strDelSms 		= "";

			if ( iReturnCode == 1 ) {
				strReturnMessage 	= "성공";
				returnCode 			= "00";
				
				rMap2.put("SCHEMA",		CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
				rMap2.put("job_name",   strJobName);
				
				int delUpdate = commonDao.delSmsUpdate(rMap2);
				
				if(delUpdate > 1) {
					strDelSms = "삭제 알림 발송 성공";
				} else {
					strDelSms = "삭제 알림 발송 실패";
				}
				
				
			} else {
				strReturnMessage 	= "실패";
				returnCode 			= "01";
			}

			logger.info("strReturnMessage : "  + strReturnMessage);

			// 이력 저장
			Map<String, Object> sendMap = new HashMap<String, Object>();
			sendMap.put("flag", 		"send");
			sendMap.put("SCHEMA",		CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
			sendMap.put("data_center", 	strDataCenter);
			sendMap.put("job_name", 	strJobName);
			sendMap.put("order_id", 	"");
			sendMap.put("send_gubun", 	"S");	// 코드관리 M51 참고하여 수정 필요
			sendMap.put("message", 		fullMsg);
			sendMap.put("send_info", 	strUserHp);
			sendMap.put("send_user_cd", strUserCd);
			sendMap.put("return_code", 	returnCode);
			sendMap.put("send_desc", 	strDelSms);

			
			try {
				rMap = 	commonDao.dPrcLog(sendMap);
			}catch (Exception e) {
				logger.info("EzSmsJobServiceImpl sms dPrcLog Exception========"+e.getMessage());
			}
			logger.info("EzSmsJobServiceImpl sms End =================");

		} catch (Exception e) {

			logger.info(e.toString());
		}
	}
	
}
