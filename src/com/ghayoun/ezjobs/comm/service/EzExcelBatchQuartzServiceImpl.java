package com.ghayoun.ezjobs.comm.service;

import java.io.File;
import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.poi.util.SystemOutLogger;
import org.json.JSONObject;
import org.quartz.JobDataMap;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.scheduling.quartz.QuartzJobBean;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.bmc.ctmem.schema900.ResponseUserRegistrationType;
import com.ghayoun.ezjobs.comm.domain.CommonBean;
import com.ghayoun.ezjobs.comm.repository.QuartzDao;
import com.ghayoun.ezjobs.common.axis.ConnectionManager;
import com.ghayoun.ezjobs.common.util.AAPI_Util;
import com.ghayoun.ezjobs.common.util.CommonUtil;
import com.ghayoun.ezjobs.common.util.DefaultServiceException;
import com.ghayoun.ezjobs.common.util.TraceLogUtil;
import com.ghayoun.ezjobs.t.axis.T_Manager5;
import com.ghayoun.ezjobs.t.domain.Doc01Bean;
import com.ghayoun.ezjobs.t.domain.Doc06Bean;
import com.ghayoun.ezjobs.t.domain.JobMapperBean;
import com.ghayoun.ezjobs.t.repository.WorksApprovalDocDao;
import com.ghayoun.ezjobs.t.repository.WorksUserDao;
import com.ghayoun.ezjobs.t.service.WorksApprovalDocServiceImpl;
import com.google.gson.JsonObject;

public class EzExcelBatchQuartzServiceImpl extends QuartzJobBean{

	private static final Log logger = LogFactory.getLog(CtmIoaLogQuartzServiceImpl.class);
	private static final Lock QLOCK = new ReentrantLock();
	
	private WorksApprovalDocDao worksApprovalDocDao;	
	private QuartzDao quartzDao;
	
	public void setWorksApprovalDocDao(WorksApprovalDocDao worksApprovalDocDao) {
        this.worksApprovalDocDao = worksApprovalDocDao;
    }
	public void setQuartzDao(QuartzDao quartzDao) {
        this.quartzDao = quartzDao;
    }
		
	/*
	 * FLAG : C -> INSERT
	 * FLAG : U-> UPDATE
	 * FLAG : D-> DELETE
	 * 
	 */
	
	protected void executeInternal(JobExecutionContext jobExecutionContext) throws JobExecutionException {
		
		Map chkHostMap = CommonUtil.checkHost();
		
		String strHost 		= CommonUtil.isNull(chkHostMap.get("scode_host"));
		String strHostName 	= CommonUtil.isNull(chkHostMap.get("server_host"));
		Boolean chkHost 	= (Boolean) chkHostMap.get("chkHost");
		
		logger.debug("OS 호스트명 : " + strHostName);
		logger.debug("코드관리 호스트명 : " + strHost);
		logger.debug("호스트 체크 결과 : " + chkHost);
		
//		if(chkHost) {
//			try {
//				ezExcelBatchQuartzServiceImplCall();
//			} catch (Exception e) {
//				e.printStackTrace();
//			}
//		}
	}
	
	public Map<String, Object> ezExcelBatchQuartzServiceImplCall(Map map) {
		
//		Map<String, Object> map = new HashMap<String, Object>();
		map.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));

		quartzDao 			= (QuartzDao) CommonUtil.getSpringBean("quartzDao");
		worksApprovalDocDao = (WorksApprovalDocDao) CommonUtil.getSpringBean("tWorksApprovalDocDao");

		// 로그 경로 가져오기.
		String strQuartzLogPath = CommonUtil.isNull(CommonUtil.getMessage("QUARTZ_LOG.PATH"));
		String strClassName	= this.getClass().getName().split("\\.")[this.getClass().getName().split("\\.").length-1];
		String strLogPath	= CommonUtil.getWebRootPath() + "/" + strQuartzLogPath + strClassName + "/";

		// 해당 폴더 없으면 생성.
		if ( !new File(strLogPath).exists() ) {
			new File(strLogPath).mkdirs();
		}
		
		TraceLogUtil.TraceLog("-----엑셀일괄 재반영 시작-----" + map.get("main_doc_cd"), strLogPath, strClassName);

		map.put("flag", "");

		Map<String, Object> rMap = new HashMap<>();
		Map<String, Object> rTokenMap 	= new HashMap<String, Object>();

		String rApiCode = "";
		String rApiMsg  = "";
		int fail_cnt  	= 0;
		
//		if(QLOCK.tryLock()){
			try{
				
				List<Doc06Bean> dt_list = quartzDao.dGetExcelBatchExecuteGroup(map);
				if(dt_list.size() > 0){
					
					//emapi 로그인
					//ConnectionManager cm = new ConnectionManager();
					//rTokenMap = cm.login(map);

					//String rLoginCode = CommonUtil.isNull(rTokenMap.get("rCode"));
					//String rToken = "";
					
					//if("1".equals(rLoginCode)){
						//ResponseUserRegistrationType t = (ResponseUserRegistrationType)rTokenMap.get("rObject");
						//rToken = t.getUserToken();
						
						//map.put("userToken",CommonUtil.isNull(rToken));
					//}	
					
					//REST API 로그인
					JSONObject responseJson = null;
					JsonObject params 		= null;
					
					String strEmUserId = CommonUtil.isNull(CommonUtil.getMessage("EM.USER.ID"));
					String strEmUserPw = CommonUtil.isNull(CommonUtil.getMessage("EM.USER.PW"));
					
					params = new JsonObject();
					params.addProperty("username", strEmUserId);
					params.addProperty("password", strEmUserPw);
					
					String AAPI_URL = CommonUtil.isNull(CommonUtil.getMessage("AAPI_URL."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));

					// 로그인
				    responseJson = AAPI_Util.restApiRun(AAPI_URL + "/session/login", "POST", params, "");
				    
				    TraceLogUtil.TraceLog("responseJson(로그인) ::::: " + responseJson, strLogPath, strClassName);
				    
				    //token 정상적으로 구해오지 못할 시 예외처리.
				    if ( responseJson.toString().indexOf("token") <= -1 ) {
				    	
						rMap.put("r_code",	"-2");
						rMap.put("r_msg",	responseJson);
						
						TraceLogUtil.TraceLog("로그인 비정상 진행 :::::" + rMap, strLogPath, strClassName);
						
						throw new DefaultServiceException(rMap);
				    }
				    
				    String token = (String)responseJson.get("token");
				    
				    map.put("userToken", token);
					
					for(int h=0;h<dt_list.size();h++){						
						Doc06Bean dt_bean = dt_list.get(h);
						
						//그룹별로 처리 대상 데이터를 읽어 온다.
						map.put("data_center", 	dt_bean.getData_center());
						map.put("table_name", 	dt_bean.getTable_name());
						
						String flag = CommonUtil.isNull(dt_bean.getAct_gb());
						map.put("flag", flag);
						
						TraceLogUtil.TraceLog("등록or수정or삭제:::::" + flag, strLogPath, strClassName);
						
						//EZJOBS 4.0 이전 버전일 경우 flag가 없으므로 null 체크로직 추가
						if ( !flag.equals("") ) {
							
							List<Doc06Bean> list = quartzDao.dGetExcelBatchList(map);
							
							int list_cnt = 0;
							list_cnt = list.size();
							
							if(list_cnt > 0){
								
								T_Manager5 t = new T_Manager5();
															
								if(flag.equals("D")){			//삭제일경우
									
									StringBuffer sb 	= new StringBuffer();
									
									TraceLogUtil.TraceLog("재반영 갯수:::::" + list_cnt, strLogPath, strClassName);
									
									for(int i=0;i<list_cnt;i++){
										Doc06Bean bean = list.get(i);
										
										try{
											
											Map<String, Object> delMap = new HashMap<>();
											
											delMap.put("job_name", 		CommonUtil.isNull(bean.getJob_name()));
											delMap.put("table_name", 	CommonUtil.isNull(bean.getTable_name()));
											delMap.put("application", 	CommonUtil.isNull(bean.getApplication()));
											delMap.put("group_name", 	CommonUtil.isNull(bean.getGroup_name()));
											delMap.put("SCHEMA", 		CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
											
											//CTM api Call
											map.put("doc06", bean);										
											rMap = t.deleteJobs(map);
											
											rApiCode 	= CommonUtil.isNull(rMap.get("rCode"));
											rApiMsg 	= CommonUtil.isNull(rMap.get("rMsg"));
											
											TraceLogUtil.TraceLog("#EzExcelBatchQuartzServiceImpl | DELETE |job_name ::"+CommonUtil.isNull(bean.getJob_name()), strLogPath, strClassName);
											TraceLogUtil.TraceLog("#EzExcelBatchQuartzServiceImpl | DELETE |rApiCode ::"+rApiCode, strLogPath, strClassName);
											TraceLogUtil.TraceLog("#EzExcelBatchQuartzServiceImpl | DELETE |rApiMsg ::"+rApiMsg, strLogPath, strClassName);
											
											String strUploadDataCenter = CommonUtil.isNull(bean.getData_center());
											if ( strUploadDataCenter.indexOf(",") > -1 ) {
												strUploadDataCenter = strUploadDataCenter.split(",")[1];
											}
											
											// 업로드 테이블 추출
											sb.append(bean.getTable_name() + "|" + strUploadDataCenter);
											sb.append(",");
											
											// EZ_DOC_06_DETAIL 플래그 업데이트
											if(rApiCode.equals("1")){									
												if(bean.getAct_gb().equals("U")){		//act_gb:U 일경우 apply_check:R 로 
													map.put("apply_check", 	"R");
													map.put("r_msg", 		"삭제성공");
												}else{
													map.put("apply_check", 	"Y");
													map.put("r_msg", 		"성공");
												}
												
												map.put("doc_cd", 			bean.getDoc_cd());
												map.put("seq", 				bean.getSeq());			
												quartzDao.dPrcExcelBatchApplyUpdate(map);											
												
											}else{
												
												// 삭제실패(삭제할 대상이 없을 경우가 대부분일 듯)											
												if(bean.getAct_gb().equals("U")){		//act_gb:U 일경우 apply_check:R 로 
													map.put("apply_check", 	"R");
													map.put("r_msg", 		rApiMsg);
												}else{
													map.put("apply_check", 	"Y");
													map.put("r_msg", 		rApiMsg);
												}											
	
												map.put("doc_cd", 			bean.getDoc_cd());
												map.put("seq", 				bean.getSeq());
												quartzDao.dPrcExcelBatchApplyUpdate(map);
											}
										}catch(Exception e){
											TraceLogUtil.TraceLog("#EzExcelBatchQuartzServiceImpl | deleteJobs | Execute| Error :::"+e.getMessage(), strLogPath, strClassName);
											rApiCode = "0";
											rApiMsg	 = e.getMessage();
											fail_cnt ++;
										}
									}
									
									// 추출한 테이블 업로드
									String strUploadTable = CommonUtil.dupStringCheck(sb.toString());
									
									if ( !strUploadTable.equals("") ) {
										
										String arrUploadTable[] = CommonUtil.isNull(strUploadTable).split(",");
										
										for ( int j = 0; j < arrUploadTable.length; j++ ) {
											
											map.put("table_name", 	arrUploadTable[j].split("[|]")[0]);
											map.put("data_center", 	arrUploadTable[j].split("[|]")[1]);
										
											// 실제 업로드 수행
											t.defUploadjobs(map);
										}
									}
									
								}else if(flag.equals("C")){			//등록일경우
									
									StringBuffer sb 	= new StringBuffer();
									
									TraceLogUtil.TraceLog("재반영 갯수:::::" + list_cnt, strLogPath, strClassName);
									
									for(int i=0;i<list_cnt;i++){
										Doc06Bean bean = list.get(i);
										
										try{
											
											Map<String, Object> checkMap = new HashMap<>();
											
											checkMap.put("job_name", 	CommonUtil.isNull(bean.getJob_name()));
											checkMap.put("data_center",	CommonUtil.isNull(bean.getData_center()));
											checkMap.put("SCHEMA", 		CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
											
											// 작업이 Control-M에 등록되어 있는지 확인.
											CommonBean commonBean = worksApprovalDocDao.dGetChkDefJobCnt(checkMap);
											
											if ( commonBean.getTotal_count() == 0 ) {
											
												//CTM api Call
												map.put("doc06", bean);
												rMap = t.defCreateJobs(map);
											
												rApiCode = CommonUtil.isNull(rMap.get("rCode"));
												rApiMsg 	= CommonUtil.isNull(rMap.get("rMsg"));
												
												TraceLogUtil.TraceLog("#EzExcelBatchQuartzServiceImpl | CREATE |job_name ::"+CommonUtil.isNull(bean.getJob_name()), strLogPath, strClassName);
												TraceLogUtil.TraceLog("#EzExcelBatchQuartzServiceImpl | CREATE |rApiCode ::"+rApiCode, strLogPath, strClassName);
												TraceLogUtil.TraceLog("#EzExcelBatchQuartzServiceImpl | CREATE |rApiMsg ::"+rApiMsg, strLogPath, strClassName);
												
												String strUploadDataCenter = CommonUtil.isNull(bean.getData_center());
												if ( strUploadDataCenter.indexOf(",") > -1 ) {
													strUploadDataCenter = strUploadDataCenter.split(",")[1];
												}
												
												// 업로드 테이블 추출
												sb.append(bean.getTable_name() + "|" + strUploadDataCenter);
												sb.append(",");
		
												// EZ_DOC_06_DETAIL 플래그 업데이트
												if(rApiCode.equals("1")){
													map.put("apply_check", 	"Y");
													map.put("r_msg", 		"등록성공");
													map.put("doc_cd", 		bean.getDoc_cd());
													map.put("seq", 			bean.getSeq());
													quartzDao.dPrcExcelBatchApplyUpdate(map);
													
													// 최종 반영 후 JOB_MAPPER에 등록
													CommonUtil.jobMapperInsertPrc(bean.getDoc_cd(), CommonUtil.isNull(bean.getJob_name()));
													
												}else{
													
													map.put("r_msg", 		rApiMsg);										
													map.put("doc_cd", 		bean.getDoc_cd());
													map.put("seq", 			bean.getSeq());											
													quartzDao.dGetExcelBatchErrMsgUpdate(map);
													
													TraceLogUtil.TraceLog("#EzExcelBatchQuartzServiceImpl | CREATE |ERRORLOG ::"+map.get("r_msg"), strLogPath, strClassName);
												}
											} else {
												
												map.put("r_msg", 		"중복 작업 존재");
												map.put("doc_cd", 		bean.getDoc_cd());
												map.put("seq", 			bean.getSeq());											
												quartzDao.dGetExcelBatchErrMsgUpdate(map);
												fail_cnt ++;
												
												TraceLogUtil.TraceLog("#EzExcelBatchQuartzServiceImpl | CREATE |ERRORLOG ::"+map.get("r_msg"), strLogPath, strClassName);
											}
											
										}catch(Exception e) {
											
											TraceLogUtil.TraceLog("#EzExcelBatchQuartzServiceImpl | CREATE | Execute | Error :::"+e.getMessage(), strLogPath, strClassName);
											
											rApiCode = "0";
											rApiMsg	 = e.getMessage();
											fail_cnt ++;
										}
									}
									
									// 추출한 테이블 업로드
									String strUploadTable = CommonUtil.dupStringCheck(sb.toString());
									
									if ( !strUploadTable.equals("") ) {
										
										String arrUploadTable[] = CommonUtil.isNull(strUploadTable).split(",");
										
										for ( int j = 0; j < arrUploadTable.length; j++ ) {
											
											map.put("table_name", 	arrUploadTable[j].split("[|]")[0]);
											map.put("data_center", 	arrUploadTable[j].split("[|]")[1]);
										
											// 실제 업로드 수행
											t.defUploadjobs(map);
										}
									}
									
								}else if(flag.equals("U")){
									
									StringBuffer sb 	= new StringBuffer();
									
									TraceLogUtil.TraceLog("재반영 갯수:::::" + list_cnt, strLogPath, strClassName);
									
									for(int i=0;i<list_cnt;i++){
										Doc06Bean bean = list.get(i);
									
										// 수정 요청 시 테이블명이 변경되는 것을 대비해서 기존 테이블, 변경 테이블 셋팅.
										String strAfterTableName = CommonUtil.isNull(bean.getTable_name());
										String strAfterApplication = CommonUtil.isNull(bean.getApplication());
										String strAfterGroupName = CommonUtil.isNull(bean.getGroup_name());
										
										try{
											
											Map<String, Object> delMap = new HashMap<>();
											
											delMap.put("job_name", 		CommonUtil.isNull(bean.getJob_name()));
											delMap.put("SCHEMA", 		CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
	
											CommonBean quartz_List = quartzDao.dGetExcelBatchDelTable(delMap);
											//bean.setTable_name(CommonUtil.isNull(before_table));
	
											if ( quartz_List != null ) {
												bean.setTable_name(CommonUtil.isNull(quartz_List.getSched_table()));
												bean.setApplication(CommonUtil.isNull(quartz_List.getApplication()));
												bean.setGroup_name(CommonUtil.isNull(quartz_List.getGroup_name()));
											}
	
											// CTM api Call 
											map.put("doc06", bean); 
											rMap = t.deleteJobs(map);
			  
											rApiCode = CommonUtil.isNull(rMap.get("rCode"));
											rApiMsg 	= CommonUtil.isNull(rMap.get("rMsg"));
			  
											TraceLogUtil.TraceLog("#EzExcelBatchQuartzServiceImpl | UPDATE-DELETE |job_name ::" + CommonUtil.isNull(bean.getJob_name()), strLogPath, strClassName);
											TraceLogUtil.TraceLog("#EzExcelBatchQuartzServiceImpl | UPDATE-DELETE |rApiCode ::" + rApiCode, strLogPath, strClassName);
											TraceLogUtil.TraceLog("#EzExcelBatchQuartzServiceImpl | UPDATE-DELETE |rApiMsg ::" + rApiMsg, strLogPath, strClassName);
											
											String strUploadDataCenter = CommonUtil.isNull(bean.getData_center()); 
											
											if (strUploadDataCenter.indexOf(",") > -1 ) {
												strUploadDataCenter = strUploadDataCenter.split(",")[1];
											}
											
											// 업로드 테이블 추출 
											sb.append(bean.getTable_name() + "|" + strUploadDataCenter); 
											sb.append(",");
			  
											// 수정 요청서 폴더/어플리케이션/그룹 변경 대비해 다시 셋팅해줌
											bean.setTable_name(strAfterTableName);
											bean.setApplication(strAfterApplication);
											bean.setGroup_name(strAfterGroupName);
											
											Map<String, Object> checkMap = new HashMap<>();
											
											checkMap.put("job_name", 	CommonUtil.isNull(bean.getJob_name()));
											checkMap.put("data_center",	CommonUtil.isNull(bean.getData_center()));
											checkMap.put("SCHEMA", 		CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
											
											//작업이 Control-M에 등록되어 있는지 확인.
											CommonBean commonBean = worksApprovalDocDao.dGetChkDefJobCnt(checkMap);
	
											if ( commonBean.getTotal_count() == 0 ) {
											
												//CTM api Call
												map.put("doc06", bean);
												rMap = t.defCreateJobs(map);
											
												rApiCode = CommonUtil.isNull(rMap.get("rCode"));
												rApiMsg 	= CommonUtil.isNull(rMap.get("rMsg"));
												
												TraceLogUtil.TraceLog("#EzExcelBatchQuartzServiceImpl | UPDATE-CREATE |job_name ::"+CommonUtil.isNull(bean.getJob_name()), strLogPath, strClassName);
												TraceLogUtil.TraceLog("#EzExcelBatchQuartzServiceImpl | UPDATE-CREATE |rApiCode ::"+rApiCode, strLogPath, strClassName);
												TraceLogUtil.TraceLog("#EzExcelBatchQuartzServiceImpl | UPDATE-CREATE |rApiMsg ::" + rApiMsg, strLogPath, strClassName);
												
												strUploadDataCenter = CommonUtil.isNull(bean.getData_center());
												if ( strUploadDataCenter.indexOf(",") > -1 ) {
													strUploadDataCenter = strUploadDataCenter.split(",")[1];
												}
												
												// 업로드 테이블 추출
												sb.append(bean.getTable_name() + "|" + strUploadDataCenter);
												sb.append(",");
												
												// EZ_DOC_06_DETAIL 플래그 업데이트
												if (rApiCode.equals("1")) {
													
													map.put("apply_check", 	"Y");
													map.put("r_msg", 		"수정성공");
													map.put("doc_cd", 		bean.getDoc_cd());
													map.put("seq", 			bean.getSeq());
													quartzDao.dPrcExcelBatchApplyUpdate(map);
													
													// 최종 반영 후 JOB_MAPPER에 등록
													CommonUtil.jobMapperInsertPrc(bean.getDoc_cd(), CommonUtil.isNull(bean.getJob_name()));
													
												} else {
													
													rApiMsg = "삭제성공 이후 등록실패 : " + rApiMsg;
													
													map.put("r_msg", 	rApiMsg);										
													map.put("doc_cd", 	bean.getDoc_cd());
													map.put("seq", 		bean.getSeq());		
													quartzDao.dGetExcelBatchErrMsgUpdate(map);
													fail_cnt ++;
													TraceLogUtil.TraceLog("#EzExcelBatchQuartzServiceImpl | UPDATE-CREATE |ERRORLOG ::"+map.get("r_msg"), strLogPath, strClassName);
												}
											} else {
												
												map.put("r_msg", 		"삭제실패 : 중복 작업 존재");
												map.put("doc_cd", 		bean.getDoc_cd());
												map.put("seq", 			bean.getSeq());											
												quartzDao.dGetExcelBatchErrMsgUpdate(map);
												fail_cnt ++;
												TraceLogUtil.TraceLog("#EzExcelBatchQuartzServiceImpl | UPDATE-CREATE |ERRORLOG ::"+map.get("r_msg"), strLogPath, strClassName);
											}
										}catch(Exception e){
											rApiCode = "0";
											rApiMsg	 = e.getMessage();
											fail_cnt ++;
											TraceLogUtil.TraceLog("#EzExcelBatchQuartzServiceImpl | UPDATE-CREATE | Execute | Error :::"+e.getMessage(), strLogPath, strClassName);
										}
									}
									
									// 추출한 테이블 업로드
									String strUploadTable = CommonUtil.dupStringCheck(sb.toString());
									
									if ( !strUploadTable.equals("") ) {
										
										String arrUploadTable[] = CommonUtil.isNull(strUploadTable).split(",");
										
										for ( int j = 0; j < arrUploadTable.length; j++ ) {
											
											map.put("table_name", 	arrUploadTable[j].split("[|]")[0]);
											map.put("data_center", 	arrUploadTable[j].split("[|]")[1]);
										
											// 실제 업로드 수행
											t.defUploadjobs(map);
										}
									}
								}
							}
						}
					}
				}
				rApiCode = "1";
				rApiMsg	 = "처리완료";
				map.put("fail_cnt", fail_cnt);
			}catch(Exception e){
				TraceLogUtil.TraceLog("#EzExcelBatchQuartzServiceImpl | Error :::"+e.getMessage(), strLogPath, strClassName);

				rApiCode = "0";
				rApiMsg	 = e.getMessage();
			}finally{
//				QLOCK.unlock();
			}
		
//		}

		//수동으로 돌리는 것이기 때문에 쿼츠 로그에 저장할 필요 없을것으로 판단
//		map.put("SCHEMA", 		CommonUtil.getMessage("DB.SCHEMA"));
//		map.put("flag"			, "EZ_QUARTZ_LOG");
//		map.put("quartz_name"	, "EZ_EXCEL_BATCH");
//		map.put("trace_log_path", strLogPath);
//		map.put("status_cd"		, rApiCode);
//		map.put("status_log"	, rApiMsg);
//
//		quartzDao.dPrcQuartz(map);
		TraceLogUtil.TraceLog("#EzExcelBatchQuartzServiceImpl | End~~~", strLogPath, strClassName);
//		return rMap;
		return map;
		
	}
}
