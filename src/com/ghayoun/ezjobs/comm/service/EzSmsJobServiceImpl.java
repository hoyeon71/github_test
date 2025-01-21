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
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.scheduling.quartz.QuartzJobBean;
import com.ghayoun.ezjobs.a.domain.AlertBean;
import com.ghayoun.ezjobs.comm.domain.CommonBean;
import com.ghayoun.ezjobs.comm.repository.CommonDao;
import com.ghayoun.ezjobs.comm.repository.QuartzDao;
import com.ghayoun.ezjobs.common.util.CommonUtil;
import com.ghayoun.ezjobs.common.util.SendMail;
import com.ghayoun.ezjobs.common.util.SendSmsDb;
import com.ghayoun.ezjobs.common.util.SendUc;
import com.ghayoun.ezjobs.common.util.TraceLogUtil;
import com.ghayoun.ezjobs.m.domain.JobGraphBean;

public class EzSmsJobServiceImpl extends QuartzJobBean{

	protected final Log logger = LogFactory.getLog(getClass());

	private QuartzDao quartzDao;
	private CommonDao commonDao;

	protected void executeInternal(JobExecutionContext jobExecutionContext) throws JobExecutionException {
		Map chkHostMap = CommonUtil.checkHost();
		
		String strHost 		= CommonUtil.isNull(chkHostMap.get("scode_host"));
		String strHostName 	= CommonUtil.isNull(chkHostMap.get("server_host"));
		Boolean chkHost 	= (Boolean) chkHostMap.get("chkHost");

		logger.debug("OS 호스트명 : " + strHostName + "| 코드관리 호스트명 : " + strHost + "| 호스트 체크 결과 : " + chkHost);
		
		if(chkHost) {
			try {
				ezSmsJobServiceImplCall();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

	public Map<String, Object> ezSmsJobServiceImplCall() {

		logger.info("EzSmsJobServiceImpl START");

		quartzDao = (QuartzDao) CommonUtil.getSpringBean("quartzDao");
		commonDao = (CommonDao) CommonUtil.getSpringBean("commonDao");

		String strQuartzLogPath = CommonUtil.isNull(CommonUtil.getMessage("QUARTZ_LOG.PATH"));
		String strServerGb 		= CommonUtil.isNull(CommonUtil.getMessage("SERVER_GB"));
		String strServerGbMent	= "";

		String rCode 	= "1";
		String rMsg 	= "처리완료";

		// 로그 경로 가져오기.
		String strClassName	= this.getClass().getName().split("\\.")[this.getClass().getName().split("\\.").length-1];
		String strLogPath	= CommonUtil.getWebRootPath() + "/" + strQuartzLogPath + strClassName + "/";

		// 해당 폴더 없으면 생성.
		if ( !new File(strLogPath).exists() ) {
			new File(strLogPath).mkdirs();
		}

		Map<String, Object> map 	= new HashMap<String, Object>();
		Map<String, Object> rMap 	= new HashMap<String, Object>();
		Map<String, Object> rMap2 	= new HashMap<String, Object>();

		List userGroup1List = null;
		List userGroup2List = null;
		List userGroup3List = null;
		List userGroup4List = null;
		List userGroup5List = null;
		List userGroup6List = null;

		map.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		
		String strCtmDailyTime 		= "";
		String strCheckTime 		= "";
		String strDataCenterList 	= "";
		String strActiveNetNameList = "";

		try {

			// AJOB 정보 가져오기
			map.put("searchType", "dataCenterList");
			map.put("mcode_cd", "M6");
			List dataCenterList = commonDao.dGetSearchItemList(map);
			
			ArrayList<Map> data_center_items = new ArrayList();
			for (int i = 0; i < dataCenterList.size(); i++) {
				CommonBean bean = (CommonBean) dataCenterList.get(i);	
			
				Map<String, Object> hm = new HashMap();
				hm.put("data_center_code", bean.getData_center_code());
				hm.put("data_center", bean.getData_center());
				hm.put("active_net_name", bean.getActive_net_name());
				data_center_items.add(hm);
				
				strCtmDailyTime 		+=  CommonUtil.isNull(bean.getCtm_daily_time()) + ",";
				strCheckTime			+=  CommonUtil.isNull(bean.getCheck_time()) + ",";
				strDataCenterList 		+=  CommonUtil.isNull(bean.getData_center()) + ",";
				strActiveNetNameList 	+=  CommonUtil.isNull(bean.getActive_net_name()) + ",";
			}
			
			map.put("data_center_items", data_center_items);
			
			// ALARM 정보 추출.
			List smsAlarmList = quartzDao.smsAlarmList(map);
			
			TraceLogUtil.TraceLog("EZ_ALARM 건 수 : " + smsAlarmList.size(), strLogPath, strClassName);

			if ( smsAlarmList != null && smsAlarmList.size() > 0 ) {

				// ALARM -> EZ_ALARM으로 저장.
				map.put("flag", "EZ_ALARM");

				map.put("CTM_DAILY_TIME", strCtmDailyTime);
				map.put("CHECK_TIME", strCheckTime);
				map.put("DATA_CENTER_LIST", strDataCenterList);
				map.put("ACTIVE_NET_NAME_LIST", strActiveNetNameList);

				rMap = quartzDao.dPrcQuartzSms(map);

				rCode 	= CommonUtil.isNull(rMap.get("r_code"));
				String rCnt 	= CommonUtil.isNull(rMap.get("r_cnt"));
				rMsg		= "";

				if ( rCode.equals("-2") ) {
					rMsg 	= CommonUtil.isNull(rMap.get("r_msg"));
				} else {
					rMsg 	= CommonUtil.getMessage(CommonUtil.isNull(rMap.get("r_msg")));
				}

				logger.info("[" + rCode + "] : " + rMsg + ", " + rCnt + "건 EZ_ALARM에 등록 완료.");

				TraceLogUtil.TraceLog("[" + rCode + "] : " + rMsg + ", " + rCnt + "건 EZ_ALARM에 등록 완료.", strLogPath, strClassName);

				// M75 : 오류 시 알림 발송 여부 체크
				Map<String, Object> paramMap 	= new HashMap<String, Object>();
				String strSendYn 				= "";

				paramMap.put("mcode_cd", 	"M75");
				paramMap.put("SCHEMA", 		CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
				List sCodeList = commonDao.dGetsCodeList(paramMap);

				if(sCodeList != null) {
					CommonBean commonBean = (CommonBean)sCodeList.get(0);
					strSendYn = CommonUtil.isNull(commonBean.getScode_eng_nm());
				}

				if(strSendYn.equals("Y")){
					for ( int i = 0; i < smsAlarmList.size(); i++ ) {
						AlertBean bean = (AlertBean)smsAlarmList.get(i);

						String strDataCenter 		= CommonUtil.isNull(bean.getData_center());
						String strOrderId 			= CommonUtil.isNull(bean.getOrder_id());
						String strSerial 			= CommonUtil.isNull(bean.getSerial());
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
						String strSms_1 			= CommonUtil.isNull(bean.getSms_1());
						String strSms_2 			= CommonUtil.isNull(bean.getSms_2());
						String strSms_3 			= CommonUtil.isNull(bean.getSms_3());
						String strSms_4 			= CommonUtil.isNull(bean.getSms_4());
						String strSms_5 			= CommonUtil.isNull(bean.getSms_5());
						String strSms_6 			= CommonUtil.isNull(bean.getSms_6());
						String strSms_7 			= CommonUtil.isNull(bean.getSms_7());
						String strSms_8 			= CommonUtil.isNull(bean.getSms_8());
						String strSms_9 			= CommonUtil.isNull(bean.getSms_9());
						String strSms_10 			= CommonUtil.isNull(bean.getSms_10());
						String strMail_1 			= CommonUtil.isNull(bean.getMail_1());
						String strMail_2 			= CommonUtil.isNull(bean.getMail_2());
						String strMail_3 			= CommonUtil.isNull(bean.getMail_3());
						String strMail_4 			= CommonUtil.isNull(bean.getMail_4());
						String strMail_5 			= CommonUtil.isNull(bean.getMail_5());
						String strMail_6 			= CommonUtil.isNull(bean.getMail_6());
						String strMail_7 			= CommonUtil.isNull(bean.getMail_7());
						String strMail_8 			= CommonUtil.isNull(bean.getMail_8());
						String strMail_9 			= CommonUtil.isNull(bean.getMail_9());
						String strMail_10 			= CommonUtil.isNull(bean.getMail_10());
						String strJobName 			= CommonUtil.isNull(bean.getJob_name());
						String strDescription		= CommonUtil.isNull(bean.getDescription());
						String strMessage			= CommonUtil.isNull(bean.getMessage());
						String strRunCounter		= CommonUtil.isNull(bean.getRun_counter());
						String strErrorDescription	= CommonUtil.isNull(bean.getError_description());
						String strStartTime			= CommonUtil.isNull(CommonUtil.getDateFormat(1,CommonUtil.isNull(bean.getStart_time())),"-");
						String strEndTime			= CommonUtil.isNull(CommonUtil.getDateFormat(1,CommonUtil.isNull(bean.getEnd_time())),"-");
						String strOdate				= CommonUtil.isNull(bean.getOdate());
						String strScript			= CommonUtil.isNull(bean.getScript());
						String strOrderTable		= CommonUtil.isNull(bean.getOrder_table());
						String strGroupName			= CommonUtil.isNull(bean.getGroup_name());
						String strMsg				= CommonUtil.isNull(bean.getMsg());
						String strNodeId			= CommonUtil.isNull(bean.getNode_id());
						String strCritical			= CommonUtil.isNull(bean.getCritical());
						String strGrpCd1			= CommonUtil.isNull(bean.getGrp_cd_1());
						String strGrpCd2			= CommonUtil.isNull(bean.getGrp_cd_2());
						String strGrpSms1			= CommonUtil.isNull(bean.getGrp_sms_1());
						String strGrpSms2			= CommonUtil.isNull(bean.getGrp_sms_2());
						String strGrpMail1			= CommonUtil.isNull(bean.getGrp_mail_1());
						String strGrpMail2			= CommonUtil.isNull(bean.getGrp_mail_2());

						String strTitle				= "";
						String strGubun				= "";
		//					String strSysout			= "";
						String strOutCond			= "";
						String strMailContent		= "";
						String strOutCondDataCenter = "";

						String strUserInfo		 	= "";
						String strCriticalInfo 		= "";

						ArrayList<String> user_cds  		= new ArrayList<String>();
						ArrayList<String> mail_user_cds 	= new ArrayList<String>();

						if ( strServerGb.equals("D") ) {
							strServerGbMent = "[작업관리시스템-개발] ";
						} else if ( strServerGb.equals("T") ) {
							strServerGbMent = "[작업관리시스템-테스트] ";
						} else if ( strServerGb.equals("P") ) {
							strServerGbMent = "[작업관리시스템-운영] ";
						}

						if ( strMessage.equals("Ended not OK") ) {
							strGubun = " ★실패★";

							strMailContent 	= "";
							strMailContent	+= "작업명 : " + strJobName + 			"<br><br>";
							strMailContent 	+= "작업 설명 : " + strDescription + 	"<br><br>";

							logger.debug("strMailContent : " + strMailContent);

						} else if ( strMessage.equals("Ended OK") ) {
							strGubun = " ★정상종료★";
						} else if ( strMessage.equals("LATE_SUB") ) {
							strGubun = " ★시작임계시간 초과★";
						} else if ( strMessage.equals("LATE_TIME") ) {
							strGubun = " ★종료임계시간 초과★";
						} else if ( strMessage.equals("LATE_EXEC") ) {
							strGubun = " ★수행임계시간 초과★";
						}

						strTitle = 	strServerGbMent + strGubun + " 작업명: " + strJobName + "\n";
						strTitle += "작업 설명: " + strDescription;

						if(strSendYn.equals("Y")){
							// 메일 전송-userId가 메일주소인 case
							if (!strUserCd1.equals("") && strMail_1.equals("Y")) {
								sendEmail(strUserId1, strJobName, strDescription, strDataCenter, strUserCd1, strOrderId, strTitle, strMailContent, strMessage);
								mail_user_cds.add(strUserCd1);
							}
							if (!strUserCd2.equals("") && strMail_2.equals("Y")) {
								sendEmail(strUserId2, strJobName, strDescription, strDataCenter, strUserCd2, strOrderId, strTitle, strMailContent, strMessage);
								mail_user_cds.add(strUserCd2);
							}
							if (!strUserCd3.equals("") && strMail_3.equals("Y")) {
								sendEmail(strUserId3, strJobName, strDescription, strDataCenter, strUserCd3, strOrderId, strTitle, strMailContent, strMessage);
								mail_user_cds.add(strUserCd3);
							}
							if (!strUserCd4.equals("") && strMail_4.equals("Y")) {
								sendEmail(strUserId4, strJobName, strDescription, strDataCenter, strUserCd4, strOrderId, strTitle, strMailContent, strMessage);
								mail_user_cds.add(strUserCd4);
							}
							if (!strUserCd5.equals("") && strMail_5.equals("Y")) {
								sendEmail(strUserId5, strJobName, strDescription, strDataCenter, strUserCd5, strOrderId, strTitle, strMailContent, strMessage);
								mail_user_cds.add(strUserCd5);
							}
							if (!strUserCd6.equals("") && strMail_6.equals("Y")) {
								sendEmail(strUserId6, strJobName, strDescription, strDataCenter, strUserCd6, strOrderId, strTitle, strMailContent, strMessage);
								mail_user_cds.add(strUserCd6);
							}
							if (!strUserCd7.equals("") && strMail_7.equals("Y")) {
								sendEmail(strUserId7, strJobName, strDescription, strDataCenter, strUserCd7, strOrderId, strTitle, strMailContent, strMessage);
								mail_user_cds.add(strUserCd7);
							}
							if (!strUserCd8.equals("") && strMail_8.equals("Y")) {
								sendEmail(strUserId8, strJobName, strDescription, strDataCenter, strUserCd8, strOrderId, strTitle, strMailContent, strMessage);
								mail_user_cds.add(strUserCd8);
							}
							if (!strUserCd9.equals("") && strMail_9.equals("Y")) {
								sendEmail(strUserId9, strJobName, strDescription, strDataCenter, strUserCd9, strOrderId, strTitle, strMailContent, strMessage);
								mail_user_cds.add(strUserCd9);
							}
							if (!strUserCd10.equals("") && strMail_10.equals("Y")) {
								sendEmail(strUserId10, strJobName, strDescription, strDataCenter, strUserCd10, strOrderId, strTitle, strMailContent, strMessage);
								mail_user_cds.add(strUserCd10);
							}
							//그룹 메일 전송
							if(!strGrpCd1.equals("") && strGrpMail1.equals("Y")) {
								rMap2.put("group_user_group_cd", strGrpCd1);
								rMap2.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
								userGroup5List = commonDao.dGetGroupUserLine(rMap2);

								for ( int ii = 0; ii < userGroup5List.size(); ii++ ) {
									CommonBean bean2 = (CommonBean)userGroup5List.get(ii);
									String group_user_cd 		= CommonUtil.isNull(bean2.getUser_cd());
									String group_user_id 		= CommonUtil.isNull(bean2.getUser_id());
									String group_user_hp		= CommonUtil.isNull(bean2.getUser_hp());

									if ( !(mail_user_cds.indexOf(group_user_cd) > -1) ) {
										sendEmail(group_user_id, strJobName, strDescription, strDataCenter, group_user_cd, strOrderId, strTitle, strMailContent, strMessage);
										mail_user_cds.add(group_user_cd);
									}else{
										logger.info("그룹1_중복유저::"+group_user_id);
									}
								}
							}
							if(!strGrpCd2.equals("") && strGrpMail2.equals("Y")) {
								rMap2.put("group_user_group_cd", strGrpCd2);
								rMap2.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
								userGroup6List = commonDao.dGetGroupUserLine(rMap2);

								for ( int ii = 0; ii < userGroup6List.size(); ii++ ) {
									CommonBean bean2 = (CommonBean)userGroup6List.get(ii);
									String group_user_cd 		= CommonUtil.isNull(bean2.getUser_cd());
									String group_user_id 		= CommonUtil.isNull(bean2.getUser_id());
									String group_user_hp		= CommonUtil.isNull(bean2.getUser_hp());

									if ( !(mail_user_cds.indexOf(group_user_cd) > -1) ) {
										sendEmail(group_user_id, strJobName, strDescription, strDataCenter, group_user_cd, strOrderId, strTitle, strMailContent, strMessage);
										mail_user_cds.add(group_user_cd);
									}else{
										logger.info("그룹2_중복유저::"+group_user_id);
									}
								}
							}

							// SMS 전송
							if (!strUserCd1.equals("") && !strUserHp1.equals("") && strSms_1.equals("Y")) {
								sendSmsDb(strUserHp1, strJobName, strDescription, strDataCenter, strUserCd1, strOrderId, strTitle, strMessage);
								user_cds.add(strUserCd1);
							}
							if (!strUserCd2.equals("") && !strUserHp2.equals("") && strSms_2.equals("Y")) {
								sendSmsDb(strUserHp2, strJobName, strDescription, strDataCenter, strUserCd2, strOrderId, strTitle, strMessage);
								user_cds.add(strUserCd2);
							}
							if (!strUserCd3.equals("") && !strUserHp3.equals("") && strSms_3.equals("Y")) {
								sendSmsDb(strUserHp3, strJobName, strDescription, strDataCenter, strUserCd3, strOrderId, strTitle, strMessage);
								user_cds.add(strUserCd3);
							}
							if (!strUserCd4.equals("") && !strUserHp4.equals("") && strSms_4.equals("Y")) {
								sendSmsDb(strUserHp4, strJobName, strDescription, strDataCenter, strUserCd4, strOrderId, strTitle, strMessage);
								user_cds.add(strUserCd4);
							}
							if (!strUserCd5.equals("") && !strUserHp5.equals("") && strSms_5.equals("Y")) {
								sendSmsDb(strUserHp5, strJobName, strDescription, strDataCenter, strUserCd5, strOrderId, strTitle, strMessage);
								user_cds.add(strUserCd5);
							}
							if (!strUserCd6.equals("") && !strUserHp6.equals("") && strSms_6.equals("Y")) {
								sendSmsDb(strUserHp6, strJobName, strDescription, strDataCenter, strUserCd6, strOrderId, strTitle, strMessage);
								user_cds.add(strUserCd6);
							}
							if (!strUserCd7.equals("") && !strUserHp7.equals("") && strSms_7.equals("Y")) {
								sendSmsDb(strUserHp7, strJobName, strDescription, strDataCenter, strUserCd7, strOrderId, strTitle, strMessage);
								user_cds.add(strUserCd7);
							}
							if (!strUserCd8.equals("") && !strUserHp8.equals("") && strSms_8.equals("Y")) {
								sendSmsDb(strUserHp8, strJobName, strDescription, strDataCenter, strUserCd8, strOrderId, strTitle, strMessage);
								user_cds.add(strUserCd8);
							}
							if (!strUserCd9.equals("") && !strUserHp9.equals("") && strSms_9.equals("Y")) {
								sendSmsDb(strUserHp9, strJobName, strDescription, strDataCenter, strUserCd9, strOrderId, strTitle, strMessage);
								user_cds.add(strUserCd9);
							}
							if (!strUserCd10.equals("") && !strUserHp10.equals("") && strSms_10.equals("Y")) {
								sendSmsDb(strUserHp10, strJobName, strDescription, strDataCenter, strUserCd10, strOrderId, strTitle, strMessage);
								user_cds.add(strUserCd10);
							}

							// 담당자그룹 SMS 전송
							if(!strGrpCd1.equals("") && strGrpSms1.equals("Y")){
								rMap2.put("group_user_group_cd", strGrpCd1);
								rMap2.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
								userGroup1List = commonDao.dGetGroupUserLine(rMap2);

								for ( int ii = 0; ii < userGroup1List.size(); ii++ ) {
									CommonBean bean2 = (CommonBean)userGroup1List.get(ii);
									String group_user_cd 		= CommonUtil.isNull(bean2.getUser_cd());
									String group_user_id 		= CommonUtil.isNull(bean2.getUser_id());
									String group_user_hp		= CommonUtil.isNull(bean2.getUser_hp());

									if (!group_user_hp.equals("") && !(user_cds.indexOf(group_user_cd) > -1)) {
										sendSmsDb(group_user_hp, strJobName, strDescription, strDataCenter, group_user_cd, strOrderId, strTitle, strMessage);
										user_cds.add(group_user_cd);
									}else{
										logger.info("그룹1_중복유저::"+group_user_id);
									}
								}
							}
							if(!strGrpCd2.equals("") && strGrpSms2.equals("Y")){
								rMap2.put("group_user_group_cd", strGrpCd2);
								rMap2.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
								userGroup1List = commonDao.dGetGroupUserLine(rMap2);

								for ( int ii = 0; ii < userGroup1List.size(); ii++ ) {
									CommonBean bean2 = (CommonBean)userGroup1List.get(ii);
									String group_user_cd 		= CommonUtil.isNull(bean2.getUser_cd());
									String group_user_id 		= CommonUtil.isNull(bean2.getUser_id());
									String group_user_hp		= CommonUtil.isNull(bean2.getUser_hp());

									if (!group_user_hp.equals("") && !(user_cds.indexOf(group_user_cd) > -1)) {
										sendSmsDb(group_user_hp, strJobName, strDescription, strDataCenter, group_user_cd, strOrderId, strTitle, strMessage);
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

			map.put("flag"			, "EZ_QUARTZ_LOG");
			map.put("quartz_name"	, "EZ_ALARM");
			map.put("trace_log_path", strLogPath);
			map.put("status_cd"		, rCode);
			map.put("status_log"	, rMsg);

			quartzDao.dPrcQuartz(map);

		} catch(Exception e) {
			TraceLogUtil.TraceLog(e.toString(), strLogPath, strClassName);
			logger.error("[" + strClassName+" Exception] : " + e);

		}

		logger.info("EzSmsJobServiceImpl END");

		return rMap;
	}

	// UC 메신저 전송.
	private void sendUc(String strSerial, String strUserId, String strJobName, String strDescription, String strDataCenter, String strUserCd, String strOrderId) {

		try {

			logger.info("UC Send Start =================");

			String strTitle 		= "[EzJOBs알림]" + strJobName + " 작업수행실패<오류>";

			String strReturnMessage = SendUc.sendUc(strSerial, strUserId, strJobName, strDescription);

			String returnCode 		= "";

			if ( strReturnMessage.equals("true") ) {
				strReturnMessage 	= "성공";
				returnCode 			= "00";
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
			sendMap.put("order_id", 	strOrderId);
			sendMap.put("send_gubun", 	"U");
			sendMap.put("message", 		strTitle);
			sendMap.put("send_info", 	strUserId);
			sendMap.put("send_user_cd", strUserCd);
			sendMap.put("return_code", 	returnCode);

			commonDao.dPrcLog(sendMap);

			logger.info("UC Send End =================");

		} catch (Exception e) {

			logger.info(e.toString());
		}
	}

	// SMS 전송. (DB INSERT)
	private void sendSmsDb(String strUserHp, String strJobName, String strDescription, String strDataCenter, String strUserCd, String strOrderId, String strTitle, String strSendDesc) {

		try {

			logger.info("SMS Send Start =================");

			//String fullMsg = strTitle + "[작업명:"+ strJobName +"][작업설명: " + strDescription + "]" + strUserInfo;
			//String fullMsg = strTitle + strUserInfo + "/" + strJobName + ":" + strDescription;
			String fullMsg = strTitle;
			
			//fullMsg = CommonUtil.subStrBytes(fullMsg, 90);
			
			logger.info("fullMsg : " + fullMsg);

			int iReturnCode = SendSmsDb.sendSmsDb(strUserHp, fullMsg);

			String strReturnMessage	= "";
			String returnCode 		= "";

			if ( iReturnCode == 1 ) {
				strReturnMessage 	= "성공";
				returnCode 			= "00";
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
			sendMap.put("order_id", 	strOrderId);
			sendMap.put("send_gubun", 	"S");	// 코드관리 M51 참고하여 수정 필요
			sendMap.put("message", 		fullMsg);
			sendMap.put("send_info", 	strUserHp);
			sendMap.put("send_user_cd", strUserCd);
			sendMap.put("return_code", 	returnCode);
			sendMap.put("send_desc", 	strSendDesc);

			Map<String, Object> rMap = new HashMap<String, Object>();
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

	// 메일 전송.
	private void sendEmail(String strToMail, String strJobName, String strDescription, String strDataCenter, String strUserCd, String strOrderId, String strTitle, String strContent, String strSendDesc) {

		try {

			logger.info("Email Send Start =================");

			strToMail				= "CP" + strToMail + "@" + CommonUtil.isNull(CommonUtil.getMessage("MAIL.AT"));

			//int iSuccess			= SendMail.senderMail(strToMail, strToMail, strTitle, strContent, "배치관리자");
			String strReturnMessage = "";
			String returnCode 		= "";

			if ( 1 == 1 ) {
				strReturnMessage 	= "성공";
				returnCode 			= "00";
			} else {
				strReturnMessage 	= "실패";
				returnCode 			= "01";
			}

			logger.info(strContent);
			logger.info("strReturnMessage : "  + strReturnMessage);

			// 이력 저장
			Map<String, Object> sendMap = new HashMap<String, Object>();
			sendMap.put("flag", 		"send");
			sendMap.put("SCHEMA",		CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
			sendMap.put("data_center", 	strDataCenter);
			sendMap.put("job_name", 	strJobName);
			sendMap.put("order_id", 	strOrderId);
			sendMap.put("send_gubun", 	"M");			// 코드관리 M51 참고하여 수정 필요
			sendMap.put("message", 		strTitle);
			sendMap.put("send_info", 	strToMail);
			sendMap.put("send_user_cd", strUserCd);
			sendMap.put("send_desc", 	strSendDesc);

			Map<String, Object> rMap = new HashMap<String, Object>();
			try {
				rMap = 	commonDao.dPrcLog(sendMap);
			}catch (Exception e) {
				logger.info("Email dPrcLog Exception========"+e.getMessage());
			}

			logger.info("Email sms End =================");

		} catch (Exception e) {

			logger.info(e.toString());
		}
	}
}
