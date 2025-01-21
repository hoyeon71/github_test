package com.ghayoun.ezjobs.comm.service;

import java.io.File;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.TreeSet;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.scheduling.quartz.QuartzJobBean;
import com.bmc.ctmem.schema900.ResponseUserRegistrationType;
import com.ghayoun.ezjobs.comm.domain.CommonBean;
import com.ghayoun.ezjobs.comm.repository.CommonDao;
import com.ghayoun.ezjobs.comm.repository.QuartzDao;
import com.ghayoun.ezjobs.common.axis.ConnectionManager;
import com.ghayoun.ezjobs.common.util.CommonUtil;
import com.ghayoun.ezjobs.common.util.DefaultServiceException;
import com.ghayoun.ezjobs.common.util.SendSmsDb;
import com.ghayoun.ezjobs.common.util.TraceLogUtil;
import com.ghayoun.ezjobs.m.domain.JobDefineInfoBean;
import com.ghayoun.ezjobs.m.repository.EmBatchResultTotalDao;
import com.ghayoun.ezjobs.m.service.EmBatchResultTotalService;
import com.ghayoun.ezjobs.t.domain.Doc08Bean;
import com.ghayoun.ezjobs.t.domain.DocInfoBean;
import com.ghayoun.ezjobs.t.repository.EmJobActionDao;
import com.ghayoun.ezjobs.t.repository.EmJobCreateDao;
import com.ghayoun.ezjobs.t.repository.EmJobDefinitionDao;
import com.ghayoun.ezjobs.t.repository.EmJobDeleteDao;
import com.ghayoun.ezjobs.t.repository.EmJobOrderDao;
import com.ghayoun.ezjobs.t.repository.EmJobUploadDao;
import com.ghayoun.ezjobs.t.repository.PopupDefJobDao;
import com.ghayoun.ezjobs.t.repository.WorksApprovalDocDao;

public class EzPreDateBatchCallJobServiceImpl extends QuartzJobBean{
	
	protected final Log logger = LogFactory.getLog(getClass());
	
	private QuartzDao quartzDao;
	private WorksApprovalDocDao worksApprovalDocDao;
	private EmJobUploadDao emJobUploadDao;	
	private PopupDefJobDao popupDefJobsDao;
	private EmJobActionDao emJobActionDao;	
	private EmBatchResultTotalService emBatchResultTotalService;
	private CommonDao commonDao;
	
//	private EmJobDefinitionDao emJobDefinitionDao;
//	private EmJobCreateDao emJobCreateDao;
//	private EmJobDeleteDao emJobDeleteDao;
//	private EmJobOrderDao emJobOrderDao;
//	private CommonDao commonDao;
//	private EmBatchResultTotalDao emBatchResultTotalDao;
	
	protected void executeInternal(JobExecutionContext jobExecutionContext) throws JobExecutionException {
		try {
			ezPreDateBatchCallJobServiceImplCall();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public Map<String, Object> ezPreDateBatchCallJobServiceImplCall() {
		
		logger.info("forecast quartz start ");
		
		quartzDao 					= (QuartzDao) CommonUtil.getSpringBean("quartzDao");
		emJobUploadDao 				= (EmJobUploadDao) CommonUtil.getSpringBean("tEmJobUploadDao");
		popupDefJobsDao 			= (PopupDefJobDao) CommonUtil.getSpringBean("popupDefJobsDao");
		emJobActionDao 				= (EmJobActionDao) CommonUtil.getSpringBean("tEmJobActionDao");
		worksApprovalDocDao 		= (WorksApprovalDocDao) CommonUtil.getSpringBean("tWorksApprovalDocDao");
		emBatchResultTotalService 	= (EmBatchResultTotalService) CommonUtil.getSpringBean("mEmBatchResultTotalService");
		commonDao 					= (CommonDao) CommonUtil.getSpringBean("commonDao");
		
		// 로그 경로 가져오기.
		String strQuartzLogPath = CommonUtil.isNull(CommonUtil.getMessage("QUARTZ_LOG.PATH"));
		String strClassName		= this.getClass().getName().split("\\.")[this.getClass().getName().split("\\.").length-1];
		String strLogPath		= CommonUtil.getWebRootPath() + "/" + strQuartzLogPath + strClassName + "/";

		// 해당 폴더 없으면 생성.
		if ( !new File(strLogPath).exists() ) {
			new File(strLogPath).mkdirs();
		}

		Map<String, Object> map 		= new HashMap<String, Object>();
		Map<String, Object> rTokenMap 	= new HashMap<String, Object>();
		Map<String, Object> rMap 		= new HashMap<String, Object>();
		
		map.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));

		ConnectionManager cm = new ConnectionManager();
		rTokenMap = cm.login(map);
		String rLoginCode 		= CommonUtil.isNull(rTokenMap.get("rCode"));
		String rToken	= "";

		logger.info("rLoginCode : " + rLoginCode);

		if( "1".equals(rLoginCode) ){
			ResponseUserRegistrationType t = (ResponseUserRegistrationType)rTokenMap.get("rObject");
			rToken = t.getUserToken();
		}

		logger.info("rToken : " + rToken);

		try {
			
			// API 호출 대상 정보 추출.
			List preDateBatchJobList = quartzDao.preDateBatchJobList(map);
			
			String strDocCds 		= "";
			String strTableNames 	= "";
			int cnt					= 0;
			
			if ( preDateBatchJobList != null ) {
				for ( int i = 0; i < preDateBatchJobList.size(); i++ ) {
					DocInfoBean bean = (DocInfoBean)preDateBatchJobList.get(i);

					String strDocCd			= CommonUtil.isNull(bean.getDoc_cd());
					String strDocGb			= CommonUtil.isNull(bean.getDoc_gb());
					String strTableName		= CommonUtil.isNull(bean.getTable_name());
					String strDataCenter	= CommonUtil.isNull(bean.getData_center());
					String strJobName		= CommonUtil.isNull(bean.getJob_name());
					
					map.put("flag", 		"API_CALL_STANDBY");
					rMap = quartzDao.dPrcQuartz(map);
	
					strDocCds += strDocCd + ",";
					
//					if ( strDocGb.equals("01") || strDocGb.equals("03") || strDocGb.equals("04") || strDocGb.equals("06") ) {
//						strTableNames += strDataCenter + "/" + strTableName + ",";
//					}
				}
			}

			if ( preDateBatchJobList != null ) {
				for ( int i = 0; i < preDateBatchJobList.size(); i++ ) {
					DocInfoBean bean = (DocInfoBean)preDateBatchJobList.get(i);
					
					String strDocCd			= CommonUtil.isNull(bean.getDoc_cd());					

					// 한건씩 API 콜해서 작업 적용하고, 그 결과를 DOC_MASTER에 업데이트 //
					if ( strDocCds.indexOf(strDocCd) > -1 ) {
						bean.setUserToken(rToken);
						try {	
							rMap = ApiCall(bean);
							cnt ++;
						} catch (DefaultServiceException e) {
							rMap = e.getResultMap();
						}
						
						String rApiCode = CommonUtil.isNull(rMap.get("rCode"));
						String rApiMsg 	= CommonUtil.isNull(rMap.get("rMsg"));
						
						map.put("doc_cd", strDocCd);

						if ( rApiCode.equals("1") ) {
							map.put("flag", 		"API_CALL_OK");
						} else {
							map.put("flag", 		"API_CALL_FAIL");
							map.put("fail_comment", rApiMsg);
						}
							
						rMap = quartzDao.dPrcQuartz(map);
					}
				}
			}
			
			TraceLogUtil.TraceLog("일별오더목록 실행 완료 : " + cnt + "건 실행", strLogPath, "EzPreDateBatchCallJobService");
			
			map.put("flag"			, "EZ_QUARTZ_LOG");
			map.put("quartz_name"	, "EZ_PRE_DATE_BATCH");
			map.put("trace_log_path", strLogPath);
			map.put("status_cd"		, "1");
			map.put("status_log"	, "처리완료");
			
			quartzDao.dPrcQuartz(map);
			
		} catch(Exception e) {
			TraceLogUtil.TraceLog(e.toString(), strLogPath, strClassName);
			logger.error("[" + strClassName+" Exception] : " + e);
		}
		
		return rMap;
	}
	
	// API 호출.
	private Map ApiCall(DocInfoBean docInfoBean) throws Exception {

		Map<String, Object> map = CommonUtil.ConvertObjectToMap(docInfoBean);
		
		//map.put("userToken", map.get("userToken"));
		map.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		
		logger.info("userToken : " + map.get("userToken"));

		Map rMap = null;
	
		Doc08Bean doc08 = worksApprovalDocDao.dGetDoc08(map);
		
		// 오늘 자 Control-M 테이블에서 해당 작업명의 order id 를 가져온다.
		// 서비스 호출 영역
		
		String strDataCenter 	= CommonUtil.isNull(map.get("data_center"));
		String strJobName 		= CommonUtil.isNull(map.get("job_name"));
		String strDescription 	= CommonUtil.isNull(map.get("description"));
		String strUserCd 		= CommonUtil.isNull(map.get("user_cd"));
		String strUserHp 		= CommonUtil.isNull(map.get("user_hp"));
		String strDocCd 		= CommonUtil.isNull(map.get("doc_cd"));
		String strOrderId 		= CommonUtil.isNull(map.get("order_id"));
		String strFromTime		= "";
		
		String strServerGb 		= CommonUtil.isNull(CommonUtil.getMessage("SERVER_GB"));
		String strServerGbMent	= "";
		
		if ( strServerGb.equals("D") ) {
			strServerGbMent = "개발";
		} else if ( strServerGb.equals("T") ) {
			strServerGbMent = "테스트";
		} else if ( strServerGb.equals("P") ) {
			strServerGbMent = "운영";
		}
		
		String strTitle = "[" + strServerGbMent + "] 예약상태변경 ";
		
		if ( !strDataCenter.equals("") ) {
			
			// C-M 정보 가져오기 
			map.put("data_center", strDataCenter); 
			CommonBean commonbean = emBatchResultTotalService.dGetDataCenterInfoAjob(map);
			
			if ( commonbean != null ) { 
				map.put("data_center_code",		CommonUtil.isNull(commonbean.getData_center_code()));
				map.put("active_net_name",		CommonUtil.isNull(commonbean.getActive_net_name()));
				map.put("odate",		  		CommonUtil.isNull(map.get("apply_date")).substring(2));
				map.put("flag",		  			CommonUtil.isNull(map.get("after_status")));
			}
		}
		
		if (!strDataCenter.equals("") ) {
			
			if(!strOrderId.equals("")) {
				map.put("order_id", strOrderId);
				
				// ORDER 실행(실시간수행)
				logger.info(doc08.getJob_name() + " : 오더 수행" + "("+strOrderId+")");

				rMap = emJobActionDao.jobAction(map);
				
				String rCode 	= CommonUtil.isNull(rMap.get("rCode"));
				
				if( !"1".equals(rCode)){
					rMap.put("r_code", "-2");
					strTitle += "반영실패";
					sendSmsDb(strUserHp, strJobName, strDescription, strDataCenter, strUserCd, strOrderId, strTitle);
					throw new DefaultServiceException(rMap);
				}
				
				// 일별오더목록 API 호출 후 의뢰자에게 SMS 발송
				strTitle += "반영성공";
				sendSmsDb(strUserHp, strJobName, strDescription, strDataCenter, strUserCd, strOrderId, strTitle);
			}else {
				
				List getPreDateAjobInfoList =  popupDefJobsDao.dGetPreDateAjobInfo(map);
				if ( getPreDateAjobInfoList != null ) {
					for(int ii = 0;ii < getPreDateAjobInfoList.size(); ii++) {
						JobDefineInfoBean bean = (JobDefineInfoBean)getPreDateAjobInfoList.get(ii);
						strOrderId = CommonUtil.isNull(bean.getOrder_id()); 
						map.put("order_id", strOrderId);
						
						// ORDER 실행(실시간수행)
						logger.info(doc08.getJob_name() + " : 오더 수행" + "("+strOrderId+")");

						rMap = emJobActionDao.jobAction(map);
						
						String rCode 	= CommonUtil.isNull(rMap.get("rCode"));
						
						if( !"1".equals(rCode)){
							rMap.put("r_code", "-2");
							strTitle += "반영실패";
							sendSmsDb(strUserHp, strJobName, strDescription, strDataCenter, strUserCd, strOrderId, strTitle);
							throw new DefaultServiceException(rMap);
						}
						
						// 일별오더목록 API 호출 후 의뢰자에게 SMS 발송
						strTitle += "반영성공";
						sendSmsDb(strUserHp, strJobName, strDescription, strDataCenter, strUserCd, strOrderId, strTitle);
					}
				}
			}
			
			logger.info(doc08.getJob_name() + " : 오더 종료" + "("+strOrderId+")");
			
		// strDataCenter 가 존재하지 않음.
		} else {
			rMap.put("r_code", 	"-2");
			rMap.put("r_msg", 	"작업이 존재하지 않습니다.");
		}
		
		//map.put("doc08", doc08);
		
		return rMap;
	}
	
	
	// SMS 전송. (DB INSERT)
	private void sendSmsDb(String strUserHp, String strJobName, String strDescription, String strDataCenter, String strUserCd, String strOrderId, String strTitle) {

		try {

			logger.info("SMS Send Start =================");
			
			String fullMsg 	= strTitle + "[작업명:"+ strJobName +"][작업설명: " + strDescription + "]";
			
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
			sendMap.put("send_gubun", 	"S");
			sendMap.put("message", 		fullMsg); 	// 메시지
			sendMap.put("send_info", 	strUserHp); // 의뢰자 user_hp
			sendMap.put("send_user_cd", strUserCd); // 의뢰자 user_cd
			sendMap.put("return_code", 	returnCode);
			
			commonDao.dPrcLog(sendMap);

			logger.info("SMS Send End =================");

		} catch (Exception e) {

			logger.info(e.toString());
		}
	}
	
}
