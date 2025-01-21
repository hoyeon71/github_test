package com.ghayoun.ezjobs.comm.service;

import java.io.BufferedReader;
import java.io.File;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.TreeSet;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

import com.ghayoun.ezjobs.t.axis.T_Manager5;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.json.JSONObject;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.scheduling.quartz.QuartzJobBean;
import com.bmc.ctmem.schema900.ResponseUserRegistrationType;
import com.ghayoun.ezjobs.comm.domain.CommonBean;
import com.ghayoun.ezjobs.comm.repository.CommonDao;
import com.ghayoun.ezjobs.comm.repository.QuartzDao;
import com.ghayoun.ezjobs.common.axis.ConnectionManager;
import com.ghayoun.ezjobs.common.util.AAPI_Util;
import com.ghayoun.ezjobs.common.util.CommonUtil;
import com.ghayoun.ezjobs.common.util.CommonWorksUtil;
import com.ghayoun.ezjobs.common.util.DefaultServiceException;
import com.ghayoun.ezjobs.common.util.SeedUtil;
import com.ghayoun.ezjobs.common.util.Ssh2Util;
import com.ghayoun.ezjobs.common.util.TelnetUtil;
import com.ghayoun.ezjobs.common.util.TraceLogUtil;
import com.ghayoun.ezjobs.m.domain.CtmInfoBean;
import com.ghayoun.ezjobs.m.repository.EmBatchResultTotalDao;
import com.ghayoun.ezjobs.t.domain.Doc01Bean;
import com.ghayoun.ezjobs.t.domain.Doc02Bean;
import com.ghayoun.ezjobs.t.domain.Doc03Bean;
import com.ghayoun.ezjobs.t.domain.Doc05Bean;
import com.ghayoun.ezjobs.t.domain.Doc06Bean;
import com.ghayoun.ezjobs.t.domain.Doc07Bean;
import com.ghayoun.ezjobs.t.domain.Doc08Bean;
import com.ghayoun.ezjobs.t.domain.DocInfoBean;
import com.ghayoun.ezjobs.t.repository.EmJobActionDao;
import com.ghayoun.ezjobs.t.repository.EmJobCreateDao;
import com.ghayoun.ezjobs.t.repository.EmJobDefinitionDao;
import com.ghayoun.ezjobs.t.repository.EmJobDeleteDao;
import com.ghayoun.ezjobs.t.repository.EmJobOrderDao;
import com.ghayoun.ezjobs.t.repository.EmJobUploadDao;
import com.ghayoun.ezjobs.t.repository.EmJobUploadDao;
import com.ghayoun.ezjobs.t.repository.WorksApprovalDocDao;
import com.ghayoun.ezjobs.t.service.WorksApprovalDocServiceImpl;
import com.google.gson.JsonObject;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;

public class EzJobAttemptServiceImpl extends QuartzJobBean{
	
	protected final Log logger = LogFactory.getLog(getClass());
	private static final Lock QLOCK = new ReentrantLock();

	private QuartzDao quartzDao;
	private WorksApprovalDocDao worksApprovalDocDao;
	private EmJobDefinitionDao emJobDefinitionDao;
	private EmJobCreateDao emJobCreateDao;
	private EmJobDeleteDao emJobDeleteDao;
	private EmJobOrderDao emJobOrderDao;
	private CommonDao commonDao;
	private EmBatchResultTotalDao emBatchResultTotalDao;
	private EmJobUploadDao emJobUploadDao;	 			
	private EmJobActionDao emJobActionDao;

	protected void executeInternal(JobExecutionContext jobExecutionContext) throws JobExecutionException {
		Map chkHostMap = CommonUtil.checkHost();
		
		String strHost 		= CommonUtil.isNull(chkHostMap.get("scode_host"));
		String strHostName 	= CommonUtil.isNull(chkHostMap.get("server_host"));
		Boolean chkHost 	= (Boolean) chkHostMap.get("chkHost");

		logger.debug("OS 호스트명 : " + strHostName + "| 코드관리 호스트명 : " + strHost + "| 호스트 체크 결과 : " + chkHost);
		
		// 쿼츠를 돌리지 않아 주석처리
		if(chkHost) {
			try {
				EzJobAttemptServiceImplCall(null);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
	
	public Map<String, Object> EzJobAttemptServiceImplCall(Map map) throws Exception {

		// 로그 경로 가져오기.
		String strQuartzLogPath = CommonUtil.isNull(CommonUtil.getMessage("QUARTZ_LOG.PATH"));
		String strClassName		= this.getClass().getName().split("\\.")[this.getClass().getName().split("\\.").length-1];
		String strLogPath		= CommonUtil.getWebRootPath() + "/" + strQuartzLogPath + strClassName + "/";

		// 해당 폴더 없으면 생성.
		if ( !new File(strLogPath).exists() ) {
			new File(strLogPath).mkdirs();
		}

		if(map == null){
			map = new HashMap<String, Object>();
		}
		quartzDao 		= (QuartzDao) CommonUtil.getSpringBean("quartzDao");
		emJobUploadDao 	= (EmJobUploadDao) CommonUtil.getSpringBean("tEmJobUploadDao");
		
		TraceLogUtil.TraceLog("-----재반영 시작-----", strLogPath, strClassName);
		System.out.println("strLogPath : " + strLogPath);
		
		Map<String, Object> rMap 	= new HashMap<String, Object>();
		
		map.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		map.put("data_center", CommonUtil.getDataCenterList().get(0).getScode_cd()+","+CommonUtil.getDataCenterList().get(0).getData_center());

		if(QLOCK.tryLock()) {
			try {

				String strDocList = CommonUtil.isNull(map.get("doc_cds"));
				System.out.println("::::::::strDocList::::::"+strDocList);
				String[] doc_cd_list;
				if (!strDocList.equals("")) {
					doc_cd_list = strDocList.split(",");
					map.put("doc_cd_list", doc_cd_list);
				}

				// API 호출 대상 정보 추출.
				List<DocInfoBean> apiCallJobList = quartzDao.apiCallJobList(map);

				TraceLogUtil.TraceLog("재반영 대상 목록 갯수::::: " + apiCallJobList.size(), strLogPath, strClassName);
				String strDocCds = "";
				String strTableNames = "";
				int fail_cnt = 0;
				String token = "";

				if (apiCallJobList != null) {

					//REST API 로그인
					JSONObject responseJson = null;
					JsonObject params = null;
					String getResonse = "";


					String strEmUserId = CommonUtil.isNull(CommonUtil.getMessage("EM.USER.ID"));
					String strEmUserPw = CommonUtil.isNull(CommonUtil.getMessage("EM.USER.PW"));

					params = new JsonObject();
					params.addProperty("username", strEmUserId);
					params.addProperty("password", strEmUserPw);

					String AAPI_URL = CommonUtil.isNull(CommonUtil.getMessage("AAPI_URL." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));

					// 로그인
					responseJson = AAPI_Util.restApiRun(AAPI_URL + "/session/login", "POST", params, "");

					TraceLogUtil.TraceLog("responseJson(로그인) ::::: " + responseJson, strLogPath, strClassName);

					//token 정상적으로 구해오지 못할 시 예외처리.
					if (responseJson.toString().indexOf("token") <= -1) {

						rMap.put("r_code", "-2");
						rMap.put("r_msg", responseJson);

						TraceLogUtil.TraceLog("로그인 비정상 진행 :::::" + rMap, strLogPath, strClassName);

						throw new DefaultServiceException(rMap);
					}

					token = (String) responseJson.get("token");

					for (int i = 0; i < apiCallJobList.size(); i++) {
						DocInfoBean bean = (DocInfoBean) apiCallJobList.get(i);

						String strDocCd = CommonUtil.isNull(bean.getDoc_cd());
						String strDocGb = CommonUtil.isNull(bean.getDoc_gb());
						String strTableName = CommonUtil.isNull(bean.getTable_name(), "");
						String strDataCenter = CommonUtil.isNull(bean.getData_center());
						String strJobName = CommonUtil.isNull(bean.getJob_name());

						map.put("flag", "API_CALL_STANDBY");
						map.put("doc_cd", strDocCd);

						TraceLogUtil.TraceLog("API_CALL_STANDBY ::::: " + strDocCd, strLogPath, strClassName);

						strDocCds += strDocCd + ",";

						//업로드하기 위한 테이블 정제
						if (strDocGb.equals("01") || strDocGb.equals("03") || strDocGb.equals("04") || strDocGb.equals("02")) {
							strTableNames += strDataCenter + "/" + strTableName + ",,";
						}
					}
				}

				if (apiCallJobList != null) {
					for (int i = 0; i < apiCallJobList.size(); i++) {
						DocInfoBean bean = (DocInfoBean) apiCallJobList.get(i);

						String strDocCd = CommonUtil.isNull(bean.getDoc_cd());
						String strDocGb = CommonUtil.isNull(bean.getDoc_gb());

						// 한건씩 API 콜해서 작업 적용하고, 그 결과를 DOC_MASTER에 업데이트 //
						if (strDocCds.indexOf(strDocCd) > -1) {
							bean.setUserToken(token);

							try {
								TraceLogUtil.TraceLog("API 콜 ::::: " + strDocCd, strLogPath, strClassName);
								rMap = ApiCall(bean);
							} catch (DefaultServiceException e) {
								TraceLogUtil.TraceLog("API 콜 에러 ::::: " + strDocCd, strLogPath, strClassName);

								rMap = e.getResultMap();
							}

							String rApiCode = CommonUtil.isNull(rMap.get("rCode"));
							String rApiMsg = CommonUtil.getMessage(CommonUtil.isNull(rMap.get("rMsg")));
							if (rApiMsg.equals("")) {
								rApiMsg = CommonUtil.isNull(rMap.get("rMsg"));
							}

							TraceLogUtil.TraceLog("doc_cd ::::: " + strDocCd, strLogPath, strClassName);
							TraceLogUtil.TraceLog("rApiCode ::::: " + rApiCode, strLogPath, strClassName);
							TraceLogUtil.TraceLog("rApiMsg ::::: " + rApiMsg, strLogPath, strClassName);

							map.put("doc_cd", strDocCd);

							if (rApiCode.equals("1")) {
								map.put("flag", "API_CALL_OK");
								map.put("fail_comment", "");

								TraceLogUtil.TraceLog("API_CALL_OK ::::: ", strLogPath, strClassName);

								// 테이블 업로드
								if (!strTableNames.equals("")) {

									TraceLogUtil.TraceLog("테이블 업로드 ::::: " + strTableNames, strLogPath, strClassName);

									TreeSet tset = new TreeSet();
									String[] tokens = strTableNames.split(",,");

									for (int ii = 0; ii < tokens.length; ii++) {
										tset.add(tokens[ii]);
									}

									Iterator it = tset.iterator();

									String strTempString = "";
									String strDataCenter = "";
									String strTableName = "";
									String strJobName = "";

									while (it.hasNext()) {

										strTempString = (String) it.next();
										strDataCenter = strTempString.split("/")[0];
										strTableName = strTempString.split("/")[1];

										map.put("userToken", token);
										map.put("data_center", strDataCenter);
										map.put("table_name", strTableName);

										emJobUploadDao.defUploadJobs(map);
									}
								}

							} else {
								fail_cnt++;

								map.put("flag", "API_CALL_FAIL");
								map.put("fail_comment", rApiMsg);

								TraceLogUtil.TraceLog("API_CALL_FAIL ::::: ", strLogPath, strClassName);
							}

							TraceLogUtil.TraceLog("Quartz procedure 진행 :::::", strLogPath, strClassName);

							rMap = quartzDao.dPrcQuartz(map);

							TraceLogUtil.TraceLog("----------" + i, strLogPath, strClassName);
						}
					}
				}

				rMap.put("flag", map.get("flag"));
				rMap.put("fail_comment", map.get("fail_comment"));
				rMap.put("main_doc_cd", map.get("main_doc_cd"));
				rMap.put("fail_cnt", fail_cnt);

				TraceLogUtil.TraceLog("재반영 결과 실패 카운트 ::: " + fail_cnt, strLogPath, strClassName);
				TraceLogUtil.TraceLog("main_doc_cd ::: " + map.get("main_doc_cd"), strLogPath, strClassName);

				//재반영이 모두 성공하고 그룹결재일 경우 메인 요청문서함 반영상태 업데이트
				if ((fail_cnt == 0) && (!"".equals(map.get("main_doc_cd")))) {

					TraceLogUtil.TraceLog("재반영이 모두 성공하고 그룹결재일 경우 메인 요청문서함 반영상태 업데이트", strLogPath, strClassName);
				
					Map rMap2 = new HashMap();
					rMap2.put("doc_cd", map.get("main_doc_cd"));
					rMap2.put("flag", "retry_ok");
					rMap2.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));
				
					worksApprovalDocDao.dPrcDocApproval(rMap2);
				}

				TraceLogUtil.TraceLog("-----재반영 정상 종료-----", strLogPath, strClassName);

			} catch(Exception e){
					TraceLogUtil.TraceLog("-----재반영 에러-----" + e.toString(), strLogPath, strClassName);
					logger.error("[" + strClassName + " Exception] : " + e);


					rMap.put("r_code", "-2");
					rMap.put("r_msg", e.toString());
					rMap.put("main_doc_cd", map.get("main_doc_cd"));
				} finally{
					QLOCK.unlock();
				}
			}

		map.put("flag"			, "EZ_QUARTZ_LOG");
		map.put("quartz_name"	, "EZ_API_CALL");
		map.put("trace_log_path", strLogPath);
		map.put("status_cd"		, rMap.get("rCode"));
		map.put("status_log"	, rMap.get("rMsg"));

		quartzDao.dPrcQuartz(map);

		return rMap;
	}
	
	// API 호출.
	public Map ApiCall(DocInfoBean docInfoBean) throws Exception {

		String strQuartzLogPath = CommonUtil.isNull(CommonUtil.getMessage("QUARTZ_LOG.PATH"));
		String strClassName	= this.getClass().getName().split("\\.")[this.getClass().getName().split("\\.").length-1];
		String strLogPath	= strQuartzLogPath + strClassName + "/";
		
		emJobDefinitionDao 		= (EmJobDefinitionDao) CommonUtil.getSpringBean("tEmJobDefinitionDao"); 
		emJobCreateDao 			= (EmJobCreateDao) CommonUtil.getSpringBean("tEmJobCreateDao");
		emJobDeleteDao 			= (EmJobDeleteDao) CommonUtil.getSpringBean("tEmJobDeleteDao");
		worksApprovalDocDao 	= (WorksApprovalDocDao) CommonUtil.getSpringBean("tWorksApprovalDocDao");
		emBatchResultTotalDao 	= (EmBatchResultTotalDao) CommonUtil.getSpringBean("mEmBatchResultTotalDao");
		emJobOrderDao			= (EmJobOrderDao) CommonUtil.getSpringBean("tEmJobOrderDao");
		emJobActionDao 			= (EmJobActionDao) CommonUtil.getSpringBean("tEmJobActionDao");

		TraceLogUtil.TraceLog(">>>> ApiCall 시작", strLogPath, strClassName);
		
		String strDocGb 		= CommonUtil.isNull(docInfoBean.getDoc_gb());
		Map<String, Object> map = CommonUtil.ConvertObjectToMap(docInfoBean);
		logger.info("::::::ApiCall::::" + map);
		map.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));

		Map rMap = null;

		if ( strDocGb.equals("01") ) {

			TraceLogUtil.TraceLog(">>>> 등록요청", strLogPath, strClassName);
			
			// 중복된 잡 이름이 있는지 체크.
			CommonBean bean = worksApprovalDocDao.dGetChkDefJobCnt(map);

			if( bean.getTotal_count()>0){
				Map rMap2 = new HashMap();
				rMap2.put("rCode",	"-1");
				rMap2.put("rMsg",	"중복된 JOB NAME이 존재합니다.");
				TraceLogUtil.TraceLog(">>>> 중복된 JOB NAME이 존재합니다.", strLogPath, strClassName);
				throw new DefaultServiceException(rMap2);
			}
			
			map.put("doc01", worksApprovalDocDao.dGetDoc01(map));
			
//			List alTagList = new ArrayList();
//			alTagList = worksApprovalDocDao.dGetTagsAllList(map);
//			map.put("alTagList", alTagList);
			
			TraceLogUtil.TraceLog(">>>> 등록요청(prcDefCreateJobs)", strLogPath, strClassName);
	
			rMap = CommonWorksUtil.prcDefCreateJobs(map, null);
			
			String rCode 	= CommonUtil.isNull(rMap.get("rCode"));			
			
			if( !"1".equals(rCode)){
				TraceLogUtil.TraceLog(">>>> 등록요청 에러", strLogPath, strClassName);
				rMap.put("rCode", 	"-2");
				throw new DefaultServiceException(rMap);
			}
			
			TraceLogUtil.TraceLog(">>>> 최종 반영 후 JOB_MAPPER에 등록", strLogPath, strClassName);
			
			// 최종 반영 후 JOB_MAPPER에 등록
			CommonUtil.jobMapperInsertPrc(docInfoBean.getDoc_cd(), docInfoBean.getJob_name());
			
		} else if ( strDocGb.equals("02") ) {
			
			TraceLogUtil.TraceLog(">>>> 긴급등록요청", strLogPath, strClassName);
			
			Doc01Bean doc02 = worksApprovalDocDao.dGetDoc02(map);
			
			if ( !CommonUtil.isNull(doc02.getT_general_date()).equals("") ) {
				String order_dates[] = CommonUtil.isNull(doc02.getT_general_date()).split("[|]");
				for( int i=0; i<order_dates.length; i++){
					String order_date = order_dates[i];
					
					// 일회성긴급요청서에서 특정실행날짜대로 작업 생성.
					doc02.setT_general_date(order_date);
					
					map.put("doc02", doc02);
					
					rMap = CommonWorksUtil.createJobs(map);
				}
			
			// 특정실행날짜가 존재하지 않으면 바로 올린다.
			} else {
				
				map.put("doc02", doc02);
				
				rMap = CommonWorksUtil.createJobs(map);
			}
			
			String rCode 	= CommonUtil.isNull(rMap.get("rCode"));
			
			if( !"1".equals(rCode)){
				TraceLogUtil.TraceLog(">>>> 긴급등록요청 에러", strLogPath, strClassName);
				rMap.put("r_code", "-2");
				throw new DefaultServiceException(rMap);
			}
			
			TraceLogUtil.TraceLog("최종 반영 후 JOB_MAPPER에 등록", strLogPath, strClassName);
			
			// 최종 반영 후 JOB_MAPPER에 등록
			CommonUtil.jobMapperInsertPrc(docInfoBean.getDoc_cd(), docInfoBean.getJob_name());
			
		} else if ( strDocGb.equals("03") ) {
			TraceLogUtil.TraceLog(">>>> 삭제요청 ", strLogPath, strClassName);
			map.put("doc03", worksApprovalDocDao.dGetDoc03(map));
			
			rMap = CommonWorksUtil.deleteJobs(map);
			
			String rCode 	= CommonUtil.isNull(rMap.get("rCode"));
			
			if( !"1".equals(rCode)){
				TraceLogUtil.TraceLog(">>>> 삭제요청 에러", strLogPath, strClassName);
				rMap.put("r_code", "-2");
				throw new DefaultServiceException(rMap);
			}else{
				Doc03Bean docBean		= (Doc03Bean)map.get("doc03");
				
				// 삭제 요청이 완료 되면 그룹작업안의 작업도 삭제한다.
				Map map2 = new HashMap();
				map2.put("flag", 		"delete_job_id");
				map2.put("job_name", 	CommonUtil.isNull(docBean.getJob_name()));
				map2.put("SCHEMA", 		CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
				
				TraceLogUtil.TraceLog(">>>> 삭제 요청이 완료 되면 그룹작업안의 작업도 삭제 ::::: ", strLogPath, strClassName);
				
				worksApprovalDocDao.dPrcJobGroup(map2);
			}
			
		} else if ( strDocGb.equals("04") ) {

			TraceLogUtil.TraceLog(">>>> 수정요청", strLogPath, strClassName);
			
			Doc01Bean bean04_org = worksApprovalDocDao.dGetJobModifyInfo(map);
			
			if( bean04_org == null){
				TraceLogUtil.TraceLog(">>>> 수정요청 원본이 존재하지 않지만, 삭제 후 신규 등록 진행.", strLogPath, strClassName);
//				rMap.put("r_code","-1");
//				rMap.put("r_msg","ERROR.16");
//				throw new DefaultServiceException(rMap);
			}
			
			Doc01Bean bean04 = worksApprovalDocDao.dGetDoc04(map);
			
			Doc03Bean bean03 = new Doc03Bean();
			bean03.setData_center(bean04.getData_center());				
			bean03.setJob_name(bean04.getJob_name());
			bean03.setMem_name(bean04.getMem_name());
			
			// application, table_name, group_name은 기존의 값으로 넣어줘야 삭제가 정상적으로 이뤄지므로.
			bean03.setTable_name(bean04.getBefore_table_name());
			bean03.setApplication(bean04.getBefore_application());
			bean03.setGroup_name(bean04.getBefore_group_name());

			map.put("doc03", bean03);
			
			TraceLogUtil.TraceLog(">>>> 기존 작업 삭제", strLogPath, strClassName);
			
			rMap = CommonWorksUtil.deleteJobs(map);
			
			String rCode 	= CommonUtil.isNull(rMap.get("rCode"));
			
			if( !"1".equals(rCode)){
				TraceLogUtil.TraceLog(">>>> 기존 작업 삭제 에러", strLogPath, strClassName);
				rMap.put("r_code", "-2");
				throw new DefaultServiceException(rMap);
			}else{
				Doc03Bean docBean03		= (Doc03Bean)map.get("doc03");
				
				map.put("data_center", docBean03.getData_center());
				map.put("table_name", docBean03.getTable_name());
				
				map.put("doc01", bean04);
				
				TraceLogUtil.TraceLog(">>>> 기존 작업 삭제 후 수정된 작업 신규 등록", strLogPath, strClassName);
				
				rMap = CommonWorksUtil.prcDefCreateJobs(map, bean04_org);
				
				rCode 			= CommonUtil.isNull(rMap.get("rCode"));
				String rMsg 	= CommonUtil.isNull(rMap.get("rMsg"));
				
				// 만약 신규 등록이 에러가 나면..
				if( !"1".equals(rCode)){
					
					TraceLogUtil.TraceLog(">>>> 기존 작업 삭제 후 수정된 작업 신규 등록 에러 발생 후 기존 작업 원복 ", strLogPath, strClassName);
					
					CommonUtil.beanTobean(bean04_org, bean04);
					
//					map.put("doc01", bean04_org);
					map.put("doc01", bean04);
					
					// 기존 작업 다시 신규 등록.
					rMap = CommonWorksUtil.prcDefCreateJobs(map,null);
					
					Doc01Bean docBean		= (Doc01Bean)map.get("doc01");
					
					map.put("data_center", docBean.getData_center());
					map.put("table_name", docBean.getTable_name());
					map.put("job_name", docBean.getJob_name());
					
					// 수정 등록 시 에러 -> 기존 등록본 원복 후 수정요청서 에러로 간주.
					// 수정 등록 시의 에러 메세지 뿌려준다.
					rMap.put("rCode", "-2");
					rMap.put("rMsg", rMsg);
					//throw new DefaultServiceException(rMap);
					
				}else{
					Doc01Bean docBean = (Doc01Bean)map.get("doc01");
					
					map.put("data_center", 	docBean.getData_center());
					map.put("table_name", 	docBean.getTable_name());
					map.put("job_name", 	docBean.getJob_name());
					
					String data_center = CommonUtil.isNull(docBean.getData_center());							
					if ( data_center.indexOf(",") > -1 ) {
						data_center = data_center.split(",")[1];
					}
					
					// 업로드 폴더 셋팅
					WorksApprovalDocServiceImpl.upload_sb.append(docBean.getTable_name() + "|" + data_center);
					WorksApprovalDocServiceImpl.upload_sb.append(",");
					
					// 수정 요청이 완료 되면 table_id, job_id 가 바뀐다.
					// 그룹작업안의 작업을 table_id, job_id 로 매핑하였기 때문에 해당 작업의 필드를 업데이트 해줘서 동기화 시켜준다.
					Map map2 = new HashMap();
					map2.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
					map2.put("data_center", 	data_center);
					map2.put("job_name", 		CommonUtil.isNull(docBean.getJob_name()));
					
					TraceLogUtil.TraceLog(">>>> 최종 반영 후 JOB_MAPPER에 등록", strLogPath, strClassName);
					
					// 최종 반영 후 JOB_MAPPER에 등록
					CommonUtil.jobMapperInsertPrc(docBean.getDoc_cd(), docBean.getJob_name());
					
				}
			}
			
		} else if ( strDocGb.equals("05") ) {
			
			TraceLogUtil.TraceLog(">>>> 수시작업", strLogPath, strClassName);
			String strDocGroupId = CommonUtil.isNull(map.get("doc_group_id"),"0");
			// 일반 ORDER API 호출.
			if ( strDocGroupId.equals("") || strDocGroupId.equals("0") ) {
				
				Doc01Bean bean04_org = worksApprovalDocDao.dGetJobModifyInfo(map);
				
				if( bean04_org == null){
					rMap.put("r_code","-1");
					rMap.put("r_msg","ERROR.16");
					TraceLogUtil.TraceLog(">>>> bean04_org = NULL", strLogPath, strClassName);
					throw new DefaultServiceException(rMap);
				}
			
				Doc05Bean doc05 = worksApprovalDocDao.dGetDoc05(map); 

				String strFromTime	= CommonUtil.isNull(doc05.getFrom_time());
				String strTset		= CommonUtil.isNull(doc05.getT_set());

				// 작업ORDER 시 수정항목이 존재하면 HOLD를 무조건 걸어주고, 해당 항목을 수정해야 한다.
				if ( !strFromTime.equals("") || !strTset.equals("") ) {
					doc05.setHold_yn("Y");
				}

				map.put("doc05", doc05);
		
				// ORDER 실행.
				TraceLogUtil.TraceLog(">>>> 오더 수행" + doc05.getJob_name(), strLogPath, strClassName);
				rMap = CommonWorksUtil.jobsOrder(map);
				
				String rCode 	= CommonUtil.isNull(rMap.get("rCode"));
				String rMsg 	= CommonUtil.isNull(rMap.get("rMsg"));
				String rOrderId = CommonUtil.isNull(rMap.get("rOrderId"));
			
				if( !"1".equals(rCode)){
					rMap.put("r_code", "-2");
					rMap.put("r_msg", rMsg);
					rMap.put("rMsg", rMsg);
					TraceLogUtil.TraceLog(">>>> 오더 실패" + rOrderId, strLogPath, strClassName);
					
					throw new DefaultServiceException(rMap);
				} else {
					
					map.put("seq", 				rOrderId);
					map.put("flag", 			"order_id_update_05");
					map.put("approval_comment", doc05.getJob_name());
					
					TraceLogUtil.TraceLog(">>>> 오더 성공 후 order_id 업데이트" + rOrderId, strLogPath, strClassName);

					// order 성공이면 order_id를 저장.
					// 사용중이라 map에 put은 임의의 항목으로 설정. (seq, approval_comment)
					worksApprovalDocDao.dPrcDocApproval(map);
					map.put("flag", "");
				}
				
				// 작업ORDER 시 수정항목 체크.
				if ( !strFromTime.equals("") || !strTset.equals("") ) {
					
					// API로 ORDER 한 후 바로 MAX order_id 구하면 정상적으로 못구해 온다.
					// 그래서 2000미리세컨드 후에 MAX 값 구하기.
					CommonUtil.setTimeout(2000);
					
					CommonBean commonBean 		= emBatchResultTotalDao.dGetDataCenterInfo(map);
					String strActiveNetName 	= CommonUtil.isNull(commonBean.getActive_net_name());
					map.put("active_net_name", 	strActiveNetName);
					
					// ORDER_ID 구하기.
					CommonBean commonBean2 = worksApprovalDocDao.dGetOrderId(map);
					
					map.put("order_id", 	CommonUtil.isNull(commonBean2.getOrder_id()));
					
					// UTIL로 FULLUPDATE 시 InCondition, OutCondition, 변수 3가지 항목이 유실되는 Control-M 버그가 존재.
					// 그러므로 해당 3가지 항목을 그대로 가져와서 업데이트 시 반영.
					map.put("t_conditions_in", 	CommonUtil.isNull(bean04_org.getT_conditions_in()));
					map.put("t_conditions_out", CommonUtil.isNull(bean04_org.getT_conditions_out()));
					
					// 변수를 수정해서 작업 ORDER 시에는 기존 변수는 무시.
					if ( strTset.equals("") ) {
						map.put("t_set", 			CommonUtil.isNull(bean04_org.getT_set()));
					} else {
						map.put("t_set", 			CommonUtil.isNull(strTset));
					}
					
					// 작업 ORDER 후 시작시간, command 항목이 있으면 수정.
					Map rMap2 = emPrcAjobUpdate(map);
					
					rCode 	= CommonUtil.isNull(rMap2.get("rCode"));
					
					if( !"1".equals(rCode)){
						rMap.put("r_code", "-2");
						throw new DefaultServiceException(rMap);
					}															
				}
			
			// 그룹 ORDER는 그룹한건만 일단 결재 완료.
			} else {
				
				rMap = new HashMap<>();

				rMap.put("rCode", "1");
				rMap.put("rMsg", "1");
			}
			
			TraceLogUtil.TraceLog(">>>> 오더 완료", strLogPath, strClassName);
			
//			TraceLogUtil.TraceLog("최종 반영 후 JOB_MAPPER에 등록", strLogPath, strClassName);
//			
//			// 최종 반영 후 JOB_MAPPER에 등록
//			CommonUtil.jobMapperInsertPrc(docInfoBean.getDoc_cd(), docInfoBean.getJob_name());
			
		} else if ( strDocGb.equals("06") ) {
			String rApiCode = "";
			String rApiMsg  = "";
			int fail_cnt  	= 0;

			Doc01Bean doc01 = new Doc01Bean();
			Doc06Bean doc06 = worksApprovalDocDao.dGetDoc06(map);

			doc01.setData_center(CommonUtil.isNull(doc06.getData_center()));

			String flag = CommonUtil.isNull(doc06.getAct_gb());
			map.put("flag", flag);
			map.put("doc01", doc01);

			TraceLogUtil.TraceLog("등록or수정or삭제:::::" + flag, strLogPath, strClassName);

			List<Doc06Bean> list =  worksApprovalDocDao.dGetDoc06DetailList(map);

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

							bean.setData_center(CommonUtil.isNull(doc06.getData_center()));

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
						bean.setData_center(CommonUtil.isNull(doc06.getData_center()));
						try{

							Map<String, Object> checkMap = new HashMap<>();

							checkMap.put("job_name", 	CommonUtil.isNull(bean.getJob_name()));
							checkMap.put("table_name", 	CommonUtil.isNull(bean.getTable_name()));
							checkMap.put("data_center",	CommonUtil.isNull(bean.getData_center()));
							checkMap.put("SCHEMA", 		CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));

							// 작업이 Control-M에 등록되어 있는지 확인.
							CommonBean commonBean = worksApprovalDocDao.dGetChkDefJobCnt(checkMap);

							if ( commonBean.getTotal_count() == 0 ) {
								System.out.println("::::::app" + CommonUtil.isNull(bean.getTable_name()));
								//CTM api Call
								map.put("table_name", CommonUtil.isNull(bean.getTable_name()));
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
						} catch (NullPointerException e) {
							System.out.println("Caught a NullPointerException: " + e.getMessage());
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
						bean.setData_center(CommonUtil.isNull(doc06.getData_center()));
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
								map.put("table_name", CommonUtil.isNull(bean.getTable_name()));
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

			if( !"1".equals(rApiCode)){
				rMap.put("r_code", 	"-2");
				rMap.put("r_msg", 	rApiMsg);
				rMap.put("rMsg", 	rApiMsg);
				throw new DefaultServiceException(rMap);
			}
		} else if ( strDocGb.equals("07") ) {
			TraceLogUtil.TraceLog(">>>> 상태변경 시작", strLogPath, strClassName);
			
			Doc07Bean doc07 = worksApprovalDocDao.dGetDoc07(map);
			
			map.put("doc07", 		doc07);
			map.put("order_id", 	doc07.getOrder_id());
			map.put("data_center", 	doc07.getData_center());
			map.put("flag", 		doc07.getAfter_status());
			
			// ORDER 실행(실시간수행)
			TraceLogUtil.TraceLog(">>>> " + doc07.getJob_name() + " : 오더 수행", strLogPath, strClassName);
			
			rMap = CommonWorksUtil.jobAction(map);
			
			String rCode 	= CommonUtil.isNull(rMap.get("rCode"));
			
			if( !"1".equals(rCode)){
				rMap.put("r_code", "-2");
				TraceLogUtil.TraceLog(">>>> 오더 실패", strLogPath, strClassName);
				throw new DefaultServiceException(rMap);
			}
		}
		
		TraceLogUtil.TraceLog(">>>> ApiCall 종료", strLogPath, strClassName);
		
		return rMap;
	}
	
	synchronized public Map emPrcAjobUpdate(Map map) throws Exception{
		
		commonDao			= (CommonDao) CommonUtil.getSpringBean("commonDao");
		worksApprovalDocDao 	= (WorksApprovalDocDao) CommonUtil.getSpringBean("tWorksApprovalDocDao");
		
		Map<String, Object> rMap 	= new HashMap<String, Object>();
		
		String strDataCenter 		= CommonUtil.isNull(map.get("data_center"));
		String strOrderId 			= CommonUtil.isNull(map.get("order_id"));
		String strGroupName 		= CommonUtil.isNull(map.get("group_name"));
		String strApplication 		= CommonUtil.isNull(map.get("application"));
		String strNodeId			= CommonUtil.isNull(map.get("node_id"));
		String strMemLib 			= CommonUtil.isNull(map.get("mem_lib"));
		String strMemName 			= CommonUtil.isNull(map.get("mem_name"));
		String strCommand 			= CommonUtil.isNull(map.get("command"));
		String strOwner 			= CommonUtil.isNull(map.get("owner"));
		String strRerunMax 			= CommonUtil.isNull(map.get("rerun_max"));
		String strTimeFrom 			= CommonUtil.isNull(map.get("time_from"));
		String strTimeUntil 		= CommonUtil.isNull(map.get("time_until"), ">");
		String strCyclic			= CommonUtil.isNull(map.get("cyclic"));
		String strRerunInterval		= CommonUtil.isNull(map.get("rerun_interval"));
		String strPriority 			= CommonUtil.isNull(map.get("priority"));
		String strMaxWait 			= CommonUtil.isNull(map.get("max_wait"));
		String strTconditionIn		= CommonUtil.isNull(map.get("t_conditions_in"));
		String strTconditionOut		= CommonUtil.isNull(map.get("t_conditions_out"));
		String strTset				= CommonUtil.isNull(map.get("t_set"));
		
		String strReturnMsg 		= "";
		
		String[] aTmpT				= null;
		
		StringBuffer sb 			= new StringBuffer();
	
		try {
			
			sb.append("ctmpsm -FULLUPDATE " + strOrderId);
			
			if (!strGroupName.equals("") ) {
				sb.append("\t -GROUP \t" + "'" + strGroupName + "' \\" 		+ "\n");
			}
			if (!strApplication.equals("") ) {
				sb.append("\t -APPLICATION \t" + "'" + strApplication + "' \\" 		+ "\n");
			}
			if (!strNodeId.equals("") ) {
				sb.append("\t -NODEGRP \t" + "'" + strNodeId + "' \\" 		+ "\n");
			}
			if (!strMemLib.equals("") ) {
				sb.append("\t -MEMLIB \t" + "'" + strMemLib + "' \\" 		+ "\n");
			}
			if (!strMemName.equals("") ) {
				sb.append("\t -MEMNAME \t" + "'" + strMemName + "' \\" 		+ "\n");
			}
			if (!strCommand.equals("") ) {
				sb.append("\t -CMDLINE \t" + "'" + strCommand + "' \\" 		+ "\n");
			}
			if (!strOwner.equals("") ) {
				sb.append("\t -OWNER \t" + "'" + strOwner + "' \\" 		+ "\n");
			}
			if (!strRerunMax.equals("") ) {
				sb.append("\t -MAXRERUN \t" + "'" + strRerunMax + "' \\" 		+ "\n");
			}
			if (!strTimeFrom.equals("") ) {
				sb.append("\t -TIMEFROM \t" + "'" + strTimeFrom + "' \\" 		+ "\n");
			} else {
				
				// 시작시간 TIMEFROM을 제거하면 NEWDAY 시간 구해서 밖아준다.
				CtmInfoBean ctmInfoBean = worksApprovalDocDao.dGetEmCommInfo(map);
				strTimeFrom 			= ctmInfoBean.getCtm_daily_time().substring(1, 5);
				
				sb.append("\t -TIMEFROM \t" + "'" + strTimeFrom + "' \\" 		+ "\n");
			}
			if (!strTimeUntil.equals("") ) {
				sb.append("\t -TIMEUNTIL \t" + "'" + strTimeUntil + "' \\" 		+ "\n");
			}
			if (!strCyclic.equals("") ) {
				sb.append("\t -CYCLIC \t" + "'" + CommonUtil.getMessage("JOB.CYCLIC."+strCyclic).toUpperCase().substring(0, 1)  + "' \\" 		+ "\n");
			}
			if (!strRerunInterval.equals("") ) {				
				sb.append("\t -INTERVAL \t" + "'" + strRerunInterval + "M' \\" 		+ "\n");
			}
			if (!strPriority.equals("") ) {
				sb.append("\t -PRIORITY \t" + "'" + strPriority + "' \\" 		+ "\n");
			}
			if (!strMaxWait.equals("") ) {
				sb.append("\t -MAXWAIT \t" + "'" + strMaxWait + "' \\" 		+ "\n");
			}
			if (!strTconditionIn.equals("") ) {
				aTmpT = strTconditionIn.split("[|]");
				
				for ( int t = 0; null != aTmpT && t < aTmpT.length; t++ ) {
					String[] aTmpT1 = aTmpT[t].split(",",3);					
					sb.append("\t -INCOND \t" + "'" + aTmpT1[0] + "' '" + aTmpT1[1] + "' '" + aTmpT1[2].toUpperCase() + "' \\" 		+ "\n");
				}
			}
			if (!strTconditionOut.equals("") ) {
				aTmpT = strTconditionOut.split("[|]");
				
				for ( int t = 0; null != aTmpT && t < aTmpT.length; t++ ) {
					String[] aTmpT1 = aTmpT[t].split(",",3);					
					sb.append("\t -OUTCOND \t" + "'" + aTmpT1[0] + "' '" + aTmpT1[1] + "' '" + aTmpT1[2].toUpperCase() + "' \\" 		+ "\n");
				}
			}
			
			if (!strTset.equals("") ) {
				aTmpT = strTset.split("[|]");
				
				for ( int t = 0; null != aTmpT && t < aTmpT.length; t++ ) {
					String[] aTmpT1 = aTmpT[t].split(",",2);
					
					sb.append("\t -AUTOEDIT \t" + "'%%" + aTmpT1[0] + "' '" + aTmpT1[1] + "' \\" 		+ "\n");
				}
			}
			
			/*
			if (!strTset.equals("") ) {
				sb.append("\t -AUTOEDIT \t" + "'%%PARM1' '" + strTset + "' \\" 		+ "\n");				
			}
			*/
			
			String cmd 		= sb.toString();
			String hostname = CommonUtil.getHostIp();
			
			// Host 정보 가져오는 서비스.	
			map.put("server_gubun"	, "S");
			
			CommonBean bean = commonDao.dGetHostInfo(map);
			
			String strHost 				= "";
			String strAccessGubun		= "";
			int iPort 					= 0;
			String strUserId 			= "";
			String strUserPw 			= "";
			
			if ( bean != null ) {
			
				strHost 			= CommonUtil.isNull(bean.getNode_id());
				strAccessGubun		= CommonUtil.isNull(bean.getAccess_gubun());
				iPort 				= Integer.parseInt(CommonUtil.isNull(bean.getAccess_port()));
				strUserId 			= CommonUtil.isNull(bean.getAgent_id());
				strUserPw 			= SeedUtil.decodeStr(CommonUtil.isNull(bean.getAgent_pw()));
			}
	
			if(!"".equals(strHost)){
				
				if ( hostname.toUpperCase().indexOf(strDataCenter.toUpperCase()) > -1 ) {
					
					Process proc 					= null;
					InputStream inputStream 		= null;
					BufferedReader bufferedReader 	= null;
					String[] cmd2					= null;
					String osName 					= System.getProperty("os.name");
					
					if(osName.toLowerCase().startsWith("window")) {
						cmd2 = new String[] { "cmd.exe", "/y", "/c", cmd };
					} else {
						cmd2 = new String[] { "/bin/sh", "-c", cmd };
					}
					
					proc = Runtime.getRuntime().exec(cmd2);			
					inputStream = proc.getInputStream();
					bufferedReader = new BufferedReader( new InputStreamReader( inputStream, "UTF-8"));
					
					String line 		= "";
					
					while (( line = bufferedReader.readLine()) != null ) {
						strReturnMsg += line;
						//strReturnMsg += (line + "<br>");
					}
					
					bufferedReader.close();
					inputStream.close();
					
				} else {
					
					if( "S".equals(strAccessGubun) ){
						Ssh2Util su = new Ssh2Util(strHost, iPort, strUserId, strUserPw, cmd, "UTF-8");
						System.out.println("SshUtil OK.");
						strReturnMsg = su.getOutput();
					}else{
						TelnetUtil tu = new TelnetUtil(strHost, iPort, strUserId, strUserPw, cmd);
						System.out.println("TelnetUtil OK.");
						strReturnMsg = tu.getOutput();
					}
				}
			}
			
			if ( strReturnMsg.equals("") ) {
				rMap.put("rCode", "-1");
			} else {
				rMap.put("rCode", "1");
				
				// 최종 수정 성공.
				if ( strReturnMsg.indexOf("has been saved successfully") > -1 ) {
					strReturnMsg = "처리 완료";
					
					// 실시간 작업 수정 성공 시 이력 저장					
					map.put("flag", "ajob");
					commonDao.dPrcLog(map);
					
				// 최종 수정 실패.
				} else {
					strReturnMsg = "처리 실패 : " + strReturnMsg;
				}
			}
			
		}catch(Exception e){
			
			rMap.put("r_code", "-1");
			rMap.put("r_msg", e.getMessage());
			
			throw new DefaultServiceException(rMap);			
		}
		
		String rCode 	= CommonUtil.isNull(rMap.get("rCode"));
		String rObject 	= CommonUtil.isNull(rMap.get("rObject"));
		
		if( !"1".equals(rCode)){
			rMap.put("r_code", "-1");
			throw new DefaultServiceException(rMap);
		}else{
			rMap.put("r_code", "1");
			rMap.put("r_msg", strReturnMsg);
		}
		
		return rMap;
	}
}
