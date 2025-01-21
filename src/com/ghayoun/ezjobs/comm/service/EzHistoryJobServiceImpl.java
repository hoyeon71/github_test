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
import com.ghayoun.ezjobs.comm.repository.QuartzDao;
import com.ghayoun.ezjobs.common.util.CommonUtil;
import com.ghayoun.ezjobs.common.util.TraceLogUtil;
import com.ghayoun.ezjobs.m.domain.CtmInfoBean;
import com.ghayoun.ezjobs.m.repository.CtmInfoDao;
import com.ghayoun.ezjobs.t.domain.UserBean;

public class EzHistoryJobServiceImpl extends QuartzJobBean{
	
	protected final Log logger = LogFactory.getLog(getClass());
	
	private QuartzDao quartzDao;
	private CtmInfoDao ctmInfoDao;

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
				ezHistoryJobServiceImplCall(strCode);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
	
	public Map<String, Object> ezHistoryJobServiceImplCall(String strCode) {
		
		logger.info("EzHistoryJobServiceImpl START");
		
		quartzDao = (QuartzDao) CommonUtil.getSpringBean("quartzDao");
		ctmInfoDao = (CtmInfoDao) CommonUtil.getSpringBean("mCtmInfoDao");
		
		String strServerGubun 	= CommonUtil.isNull(CommonUtil.getMessage("SERVER_GB"));
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
			
			String strActiveNetName = "A______" + strCode + "%JOB";
			
			// AJOB 정보 추출.
			map.put("active_net_name", strActiveNetName);
			List aJobList = quartzDao.aJobList(map);
			
			if ( aJobList != null ) {
				for ( int i = 0; i < aJobList.size(); i++ ) {
					CommonBean bean = (CommonBean)aJobList.get(i);
					
					// HISTORY를 NEW_DAY 후에 한번만 돌린다.
		        	// 현재 테이블명의 바로 전 테이블이 NEW_DAY 전의 정확한 테이블이다.
					if ( i == 1 ) {
						strActiveNetName = CommonUtil.isNull(bean.getActive_net_name());
						
						map.put("flag", 			"EZ_HISTORY");
						map.put("data_center_code", strCode);
						map.put("active_net_name", 	strActiveNetName);
						CommonBean EZ_HISTORY_CNT = quartzDao.EZ_HISTORY_CNT(map);
						
						String total_ajob_cnt = EZ_HISTORY_CNT.getTotal_ajob_cnt();
						String matched_cnt = EZ_HISTORY_CNT.getMatched_cnt();
						
						logger.info("total_ajob_cnt : " + total_ajob_cnt);
						logger.info("matched_cnt : " + matched_cnt);
						
						if (!total_ajob_cnt.equals(matched_cnt)) {

							rMap = quartzDao.dPrcQuartz(map);
	
							rCode 	= CommonUtil.isNull(rMap.get("r_code"));
	
							if ( rCode.equals("-2") ) {
								rMsg 	= CommonUtil.isNull(rMap.get("r_msg"));
							} else {
								rMsg 	= CommonUtil.getMessage(CommonUtil.isNull(rMap.get("r_msg")));
								if(rMsg.equals("")){
									rMsg 	= CommonUtil.isNull(rMap.get("r_msg"));
								}
							}
							
							
						}
						//작업상태 사후처리. 2024.11.15 이상훈
						List EmExcutingJobList = quartzDao.emExcutingJobList(map);
						if(EmExcutingJobList.size() > 0) {
							for ( int j = 0; j < EmExcutingJobList.size(); j++ ) {
								
								CommonBean emBean = (CommonBean)EmExcutingJobList.get(j);
								
								Map<String, Object> emMap 	= new HashMap<String, Object>();
								Map<String, Object> ctmMap 	= new HashMap<String, Object>();
								
								String strOdate = CommonUtil.isNull(emBean.getOdate());
								int odate = Integer.parseInt(strOdate);
								odate += 1;
								String nextOdate = Integer.toString(odate);
								
								emMap.put("job_name", CommonUtil.isNull(emBean.getJob_name()));
								emMap.put("jobdate",  nextOdate);
								emMap.put("runcount", CommonUtil.isNull(emBean.getRerun_counter()));
								
								CtmInfoBean ctmExcutingJob = ctmInfoDao.dGetExcutingJob(emMap);
								
								//cmr_jobinf에 데이터 없으면 pass
								if (ctmExcutingJob == null ) continue; 
								
								ctmMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
								ctmMap.put("job_name", CommonUtil.isNull(ctmExcutingJob.getJobname()));
								ctmMap.put("jobdate", CommonUtil.isNull(ctmExcutingJob.getJobdate()).substring(2));
								ctmMap.put("runcount", CommonUtil.isNull(ctmExcutingJob.getRuncount()));
								ctmMap.put("oscompstat", CommonUtil.isNull(ctmExcutingJob.getOscompstat()));
								
								Map<String, Object> rtnMap = new HashMap<>();
								int rtn = 0;
								
								//CTM 데이터 기반으로 Ez_history_001.status UPDATE.
								rtn = quartzDao.dPrcUpdateStatusHistory(ctmMap);
							}
						}
					}
					
		        	// 현재 테이블도 필요 (오늘 자 테이블을 프로시저나 함수에서 사용할 일이 있음. 2024.09.24 강명준)
					// 스마트 폴더를 찾는 Function 은 오늘자 AJOB 에 SELECT 권한이 있어야 접근 가능 (get_vr_group_rba)
					if ( i == 0 ) {
						strActiveNetName = CommonUtil.isNull(bean.getActive_net_name());
						
						map.put("flag", 			"EZ_HISTORY");
						map.put("data_center_code", strCode);
						map.put("active_net_name", 	strActiveNetName);
						

						rMap = quartzDao.dPrcQuartz(map);

						rCode 	= CommonUtil.isNull(rMap.get("r_code"));

						if ( rCode.equals("-2") ) {
							rMsg 	= CommonUtil.isNull(rMap.get("r_msg"));
						} else {
							rMsg 	= CommonUtil.getMessage(CommonUtil.isNull(rMap.get("r_msg")));
							if(rMsg.equals("")){
								rMsg 	= CommonUtil.isNull(rMap.get("r_msg"));
							}
						}
					}
				}
			}
			
			/*
			map.put("flag", 			"EZ_HISTORY");
			map.put("data_center_code", strCode);
			map.put("active_net_name", 	strActiveNetName);

			rMap = quartzDao.dPrcQuartz(map);

			rCode 	= CommonUtil.isNull(rMap.get("r_code"));

			if ( rCode.equals("-2") ) {
				rMsg 	= CommonUtil.isNull(rMap.get("r_msg"));
			} else {
				rMsg 	= CommonUtil.getMessage(CommonUtil.isNull(rMap.get("r_msg")));
				if(rMsg.equals("")){
					rMsg 	= CommonUtil.isNull(rMap.get("r_msg"));
				}
			}
			*/

			Map<String, Object> logMap 	= new HashMap<String, Object>();

			logMap.put("SCHEMA", 			CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
			logMap.put("active_net_name", 	strActiveNetName);

			TraceLogUtil.TraceLog("[" + rCode + "] : " + rMsg, strLogPath, "EzHistoryJobServiceImpl");
			
			map.put("flag"			, "EZ_QUARTZ_LOG");
			map.put("quartz_name"	, "EZ_HISTORY"+"_"+strCode);
			map.put("trace_log_path", strLogPath);
			map.put("status_cd"		, rCode);
			map.put("status_log"	, rMsg);
			
			CommonBean EZ_HISTORY_CNT = quartzDao.EZ_HISTORY_CNT(map);
			
			String total_ajob_cnt = EZ_HISTORY_CNT.getTotal_ajob_cnt();
			String matched_cnt = EZ_HISTORY_CNT.getMatched_cnt();
			
			if (!total_ajob_cnt.equals(matched_cnt)) {
			
				quartzDao.dPrcQuartz(map);
			}
			
			logger.info("EzHistoryJobServiceImpl END");
			
		} catch(Exception e) {
			TraceLogUtil.TraceLog(e.toString(), strLogPath, "EzHistoryJobServiceImpl");
			logger.error("[EzHistoryJobService Exception] : " + e);
			
		}
		return rMap;
	}
}
