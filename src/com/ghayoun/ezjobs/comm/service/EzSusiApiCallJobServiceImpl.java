package com.ghayoun.ezjobs.comm.service;

import java.io.BufferedReader;
import java.io.File;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
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
import com.ghayoun.ezjobs.common.util.DateUtil;
import com.ghayoun.ezjobs.common.util.DefaultServiceException;
import com.ghayoun.ezjobs.common.util.TraceLogUtil;
import com.ghayoun.ezjobs.m.repository.EmBatchResultTotalDao;
import com.ghayoun.ezjobs.t.domain.Doc02Bean;
import com.ghayoun.ezjobs.t.domain.DocInfoBean;
import com.ghayoun.ezjobs.t.repository.EmJobCreateDao;
import com.ghayoun.ezjobs.t.repository.WorksApprovalDocDao;

public class EzSusiApiCallJobServiceImpl extends QuartzJobBean{
	
	protected final Log logger = LogFactory.getLog(getClass());
	
	private QuartzDao quartzDao;
	private WorksApprovalDocDao worksApprovalDocDao;	
	private EmJobCreateDao emJobCreateDao;
	private EmBatchResultTotalDao emBatchResultTotalDao;
	private CommonDao commonDao;
	
	public void setQuartzDao(QuartzDao quartzDao) {
        this.quartzDao = quartzDao;
    }
	public void setWorksApprovalDocDao(WorksApprovalDocDao worksApprovalDocDao) {
        this.worksApprovalDocDao = worksApprovalDocDao;
    }	
	public void setEmJobCreateDao(EmJobCreateDao emJobCreateDao) {
        this.emJobCreateDao = emJobCreateDao;
    }
	public void setEmBatchResultTotalDao(EmBatchResultTotalDao emBatchResultTotalDao) {
        this.emBatchResultTotalDao = emBatchResultTotalDao;
    }
	public void setCommonDao(CommonDao commonDao) {
        this.commonDao = commonDao;
    }
	
	protected void executeInternal(JobExecutionContext jobExecutionContext) throws JobExecutionException {
		
		String strQuartzLogPath = CommonUtil.isNull(CommonUtil.getMessage("QUARTZ_LOG.PATH"));

		// 로그 경로 가져오기.
		String strClassName	= this.getClass().getName().split("\\.")[this.getClass().getName().split("\\.").length-1];
		String strLogPath	= CommonUtil.getWebRootPath() + "/" + strQuartzLogPath + strClassName + "/";

		// 해당 폴더 없으면 생성.
		if ( !new File(strLogPath).exists() ) {
			new File(strLogPath).mkdirs();
		}
		
		Map<String, Object> map 		= new HashMap<String, Object>();
		Map<String, Object> rTokenMap 	= new HashMap<String, Object>();
		Map<String, Object> rMap 		= new HashMap<String, Object>();
		
		ConnectionManager cm = new ConnectionManager();
		rTokenMap = cm.login(map);

		String rLoginCode 	= CommonUtil.isNull(rTokenMap.get("rCode"));
		String rToken		= "";
		String strDocCd		= "";
		
		if( "1".equals(rLoginCode) ){
			ResponseUserRegistrationType t = (ResponseUserRegistrationType)rTokenMap.get("rObject");
			rToken = t.getUserToken();
		}
		
		try {
			
			map.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
			
			// API 호출 대상 정보 추출.
			List susiApiCallJobList = quartzDao.susiApiCallJobList(map);
			
			if ( susiApiCallJobList != null ) {
				for ( int i = 0; i < susiApiCallJobList.size(); i++ ) {
					DocInfoBean bean = (DocInfoBean)susiApiCallJobList.get(i);
					
					strDocCd = CommonUtil.isNull(bean.getDoc_cd());
					
					// 한 건씩 API 콜해서 작업 적용
					// 결과 DOC_MASTER에 업데이트
					bean.setUserToken(rToken);
						
					//try {	
						rMap = ApiCall(bean);
					//} catch (DefaultServiceException e) {
						//rMap = e.getResultMap();
					//}
					
					// 반영이 완료되면 반영완료 상태로 변경
					map.put("flag", 	"API_CALL_END");
					map.put("doc_cd", 	strDocCd);
					rMap = quartzDao.dPrcQuartz(map);
				}
			}
			
		} catch(Exception e) {
			TraceLogUtil.TraceLog(e.toString(), strLogPath, strClassName);
			logger.error("[" + strClassName+" Exception] : " + e);
		}
	}
	
	// API 호출.
	private Map ApiCall(DocInfoBean docInfoBean) throws Exception {
		
		Map<String, Object> map = CommonUtil.ConvertObjectToMap(docInfoBean);
		
		map.put("userToken", 	docInfoBean.getUserToken());
		map.put("SCHEMA", 		CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		map.put("data_center",	CommonUtil.isNull(docInfoBean.getData_center()));
		
		CommonBean dataCenterInfoBean 	= emBatchResultTotalDao.dGetDataCenterInfo(map);
		String strActiveNetName 		= CommonUtil.isNull(dataCenterInfoBean.getActive_net_name());
		map.put("active_net_name", strActiveNetName);
		map.put("gubun", "susi_api_batch");
		
		Map<String, Object> rMap = new HashMap<String, Object>();
		
		String strDummyApplication 	= "";
		String strDummyGroupName 	= "";
		String strDummyOdate	 	= "";
		
		List<Doc02Bean> doc02List = worksApprovalDocDao.dGetDoc02List(map);
		
		for(int d = 0 ; null!=doc02List && d<doc02List.size(); d++){

			Doc02Bean bean = doc02List.get(d);
		
			StringBuffer stringB = new StringBuffer();
		
			String strCommand 		= CommonUtil.isNull(bean.getCommand());
			String strDocCd 		= CommonUtil.isNull(bean.getDoc_cd());
			String strJobName 		= CommonUtil.isNull(bean.getJob_name());
			
			strDummyApplication 	= CommonUtil.isNull(bean.getApplication());
			strDummyGroupName 		= CommonUtil.isNull(bean.getGroup_name());
			strDummyOdate	 		= CommonUtil.isNull(bean.getT_general_date());
			
			if(!strCommand.equals("")){
				strCommand = strCommand.replaceAll("&apos;","\'").replace("&amp;quot;","\"").replace("&quot;","\"").replace("&lt;","<").replace("&gt;",">");
			}
			bean.setCommand(strCommand);
			
			// 선행 조건에 DUMMY 추가.
			String strInCondition = CommonUtil.isNull(bean.getT_conditions_in());
			
			if ( strInCondition.equals("") ) {
				strInCondition = strDocCd + "_DUMMY,ODAT,and";
			} else {
				strInCondition = strInCondition + "|" + strDocCd + "_DUMMY,ODAT,and";
			}
			
			bean.setT_conditions_in(strInCondition);
			// 선행 조건에 DUMMY 추가.
			
			map.put("doc02", bean);
			
			try {
			
				rMap = emJobCreateDao.createJobs(map);
				
			} catch (Exception e) {
				rMap.put("rMsg", e.getMessage());
			}
			
			String rApiCode = CommonUtil.isNull(rMap.get("rCode"));
			String rApiMsg 	= CommonUtil.isNull(rMap.get("rMsg"));
			String rOrderId = CommonUtil.isNull(rMap.get("rOrderId"));
			
			map.put("doc_cd", 	strDocCd);
			map.put("job_name", strJobName);
				
			if ( rApiCode.equals("1") ) {
				map.put("flag", "SUSI_API_CALL_OK");
			} else {
				map.put("flag", "SUSI_API_CALL_FAIL");
				
				if ( rApiCode.equals("-1") ) {
					rApiMsg = CommonUtil.isNull(CommonUtil.getMessage(rApiMsg));
				}
				
				map.put("fail_comment", rApiMsg);						
			}
				
			rMap = quartzDao.dPrcQuartz(map);			
			
			if( !"1".equals(rApiCode)){
				//rMap.put("r_code", "-1");
				//throw new DefaultServiceException(rMap); 
			} else {
				
				map.put("job_name", CommonUtil.isNull(bean.getJob_name()));
				map.put("doc_cd", 	CommonUtil.isNull(bean.getDoc_cd()));
				
				// API로 ORDER 한 후 바로 MAX order_id 구하면 정상적으로 못구해 온다.
				// 그래서 2000미리세컨드 후에 MAX 값 구하기.
				/*
				CommonUtil.setTimeout(2000);
				
				// ORDER_ID 구하기.
				CommonBean commonBean2 = worksApprovalDocDao.dGetOrderId(map);
				*/
				
				
				map.put("seq", 				rOrderId);
				map.put("flag", 			"order_id_update_02");
				map.put("approval_comment", bean.getJob_name());

				// createJobs가 성공이면 order_id를 저장.
				// 사용중이라 map에 put은 임의의 항목으로 설정. (seq, approval_comment)
				worksApprovalDocDao.dPrcDocApproval(map);
				
				// 최종 반영 후 JOB_MAPPER에 등록
				CommonUtil.jobMapperInsertPrc(strDocCd, bean.getJob_name());
			}
		}
		
		map.put("data_center"	, CommonUtil.isNull(docInfoBean.getData_center()));
		map.put("server_gubun"	, "S");
		
		CommonBean bean = commonDao.dGetHostInfo(map);
		
		String strHost = "";	
		
		if ( bean != null ) {						
			strHost = CommonUtil.isNull(bean.getNode_id());							
		}
		
		// DUMMY 작업 생성.
		Map<String, Object> dummyMap = new HashMap<String, Object>();
		
		Doc02Bean doc02bean = new Doc02Bean();
		
		String strDocCd = CommonUtil.isNull(docInfoBean.getDoc_cd());
		
		doc02bean.setData_center(CommonUtil.isNull(docInfoBean.getData_center()));
		doc02bean.setJob_name(strDocCd + "_DUMMY");
		doc02bean.setOwner("dummy");
		doc02bean.setTask_type("dummy");
		doc02bean.setNode_id(strHost);
		doc02bean.setTable_name(strDummyApplication + "_SUSI");
		doc02bean.setApplication(strDummyApplication);
		doc02bean.setGroup_name(strDummyGroupName);
		doc02bean.setT_general_date(strDummyOdate);
		doc02bean.setT_conditions_out(strDocCd + "_DUMMY,ODAT,add");
		
		dummyMap.put("doc02", 		doc02bean);
		dummyMap.put("userToken", 	CommonUtil.isNull(map.get("userToken")));
		
		emJobCreateDao.createJobs(dummyMap);
		
		return rMap;
	}
}
