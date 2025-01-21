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
import com.ghayoun.ezjobs.t.domain.DocInfoBean;
import com.ghayoun.ezjobs.t.repository.EmJobCreateDao;
import com.ghayoun.ezjobs.t.repository.EmJobDefinitionDao;
import com.ghayoun.ezjobs.t.repository.EmJobDeleteDao;
import com.ghayoun.ezjobs.t.repository.EmJobOrderDao;
import com.ghayoun.ezjobs.t.repository.EmJobUploadDao;
import com.ghayoun.ezjobs.t.repository.WorksApprovalDocDao;

public class EzApiCallJobServiceImpl extends QuartzJobBean{
	
	protected final Log logger = LogFactory.getLog(getClass());
	
	private QuartzDao quartzDao;
	private WorksApprovalDocDao worksApprovalDocDao;
	private EmJobDefinitionDao emJobDefinitionDao;
	private EmJobCreateDao emJobCreateDao;
	private EmJobDeleteDao emJobDeleteDao;
	private EmJobOrderDao emJobOrderDao;
	private CommonDao commonDao;
	private EmBatchResultTotalDao emBatchResultTotalDao;
	private EmJobUploadDao emJobUploadDao;	
	
	public void setQuartzDao(QuartzDao quartzDao) {
        this.quartzDao = quartzDao;
    }
	public void setWorksApprovalDocDao(WorksApprovalDocDao worksApprovalDocDao) {
        this.worksApprovalDocDao = worksApprovalDocDao;
    }
	public void setEmJobDefinitionDao(EmJobDefinitionDao emJobDefinitionDao) {
        this.emJobDefinitionDao = emJobDefinitionDao;
    }
	public void setEmJobCreateDao(EmJobCreateDao emJobCreateDao) {
        this.emJobCreateDao = emJobCreateDao;
    }
	public void setEmJobDeleteDao(EmJobDeleteDao emJobDeleteDao) {
        this.emJobDeleteDao = emJobDeleteDao;
    }
	public void setEmJobOrderDao(EmJobOrderDao emJobOrderDao) {
        this.emJobOrderDao = emJobOrderDao;
    }
	public void setCommonDao(CommonDao commonDao) {
        this.commonDao = commonDao;
    }
	public void setEmBatchResultTotalDao(EmBatchResultTotalDao emBatchResultTotalDao) {
        this.emBatchResultTotalDao = emBatchResultTotalDao;
    }
	public void setEmJobUploadDao(EmJobUploadDao emJobUploadDao) {
        this.emJobUploadDao = emJobUploadDao;
    }
	
	protected void executeInternal(JobExecutionContext jobExecutionContext) throws JobExecutionException {
		
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
		
		if( "1".equals(rLoginCode) ){
			ResponseUserRegistrationType t = (ResponseUserRegistrationType)rTokenMap.get("rObject");
			rToken = t.getUserToken();
		}
		
		try {
			
			// API 호출 대상 정보 추출.
			List apiCallJobList = quartzDao.apiCallJobList(map);
			
			String strDocCds 		= "";
			String strTableNames 	= "";
			
			if ( apiCallJobList != null ) {
				for ( int i = 0; i < apiCallJobList.size(); i++ ) {
					DocInfoBean bean = (DocInfoBean)apiCallJobList.get(i);
					
					String strDocCd			= CommonUtil.isNull(bean.getDoc_cd());
					String strDocGb			= CommonUtil.isNull(bean.getDoc_gb());
					String strTableName		= CommonUtil.isNull(bean.getTable_name());
					String strDataCenter	= CommonUtil.isNull(bean.getData_center());
					String strJobName		= CommonUtil.isNull(bean.getJob_name());
					
					map.put("flag", 		"API_CALL_STANDBY");
					rMap = quartzDao.dPrcQuartz(map);
	
					strDocCds += strDocCd + ",";
					
					if ( strDocGb.equals("01") || strDocGb.equals("03") || strDocGb.equals("04") || strDocGb.equals("06") ) {
						strTableNames += strDataCenter + "/" + strTableName + ",";
					}
				}
			}
			
			if ( apiCallJobList != null ) {
				for ( int i = 0; i < apiCallJobList.size(); i++ ) {
					DocInfoBean bean = (DocInfoBean)apiCallJobList.get(i);
					
					String strDocCd			= CommonUtil.isNull(bean.getDoc_cd());					
					
					// 한건씩 API 콜해서 작업 적용하고, 그 결과를 DOC_MASTER에 업데이트 //
					if ( strDocCds.indexOf(strDocCd) > -1 ) {
						bean.setUserToken(rToken);
						
						try {	
							rMap = ApiCall(bean);
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
							
							if ( rApiCode.equals("-1") ) {
								rApiMsg = CommonUtil.isNull(CommonUtil.getMessage(rApiMsg));
							}
							
							map.put("fail_comment", rApiMsg);
						}
							
						rMap = quartzDao.dPrcQuartz(map);
					}
				}
			}
			
			// 테이블 업로드
			if ( !strTableNames.equals("") ) {
				
				TreeSet tset = new TreeSet();
				String[] tokens = strTableNames.split(",");
			    for(int i = 0; i < tokens.length; i++) {
			    	tset.add(tokens[i]);
			    }
			     
			    Iterator it = tset.iterator();
			    
			    String strTempString 	= "";
			    String strDataCenter 	= "";
			    String strTableName 	= "";
			    String strJobName 		= "";
			    
	            while ( it.hasNext() ) {	            	
	            	
	            	strTempString = (String)it.next();
	            	
	            	strDataCenter 	= strTempString.split("/")[0];
	            	strTableName 	= strTempString.split("/")[1];
	            	
	            	map.put("userToken", 	rToken);
	            	map.put("data_center", 	strDataCenter);
					map.put("table_name", 	strTableName);
					
					emJobUploadDao.defUploadJobs(map);
	            }			 
			}
			
		} catch(Exception e) {
			TraceLogUtil.TraceLog(e.toString(), strLogPath, strClassName);
			logger.error("[" + strClassName+" Exception] : " + e);
		}
	}
	
	// API 호출.
	private Map ApiCall(DocInfoBean docInfoBean) throws Exception {
		
		String strDocGb 		= CommonUtil.isNull(docInfoBean.getDoc_gb());
		
		Map<String, Object> map = CommonUtil.ConvertObjectToMap(docInfoBean);
		
		map.put("userToken", map.get("usertoken"));
		
		Map rMap = null;

		if ( strDocGb.equals("01") ) {

			// 중복된 잡 이름이 있는지 체크.
			CommonBean bean = worksApprovalDocDao.dGetChkDefJobCnt(map);
			
			if( bean.getTotal_count()>0){
				Map rMap2 = new HashMap();
				rMap2.put("rCode",	"-1");
				rMap2.put("rMsg",	"ERROR.17");
				throw new DefaultServiceException(rMap2);
			}
			
			map.put("doc01", worksApprovalDocDao.dGetDoc01(map));
			
			List alTagList = new ArrayList();
			alTagList = worksApprovalDocDao.dGetTagsAllList(map);
			map.put("alTagList", alTagList);
	
			rMap = emJobDefinitionDao.prcDefCreateJobs(map);
			
			String rCode 	= CommonUtil.isNull(rMap.get("rCode"));			
			
			if( !"1".equals(rCode)){
				rMap.put("rCode", 	"-2");
				throw new DefaultServiceException(rMap);
			}
			
		} else if ( strDocGb.equals("02") ) {
			
			Doc01Bean doc02 = worksApprovalDocDao.dGetDoc02(map);
			
			if ( !CommonUtil.isNull(doc02.getT_general_date()).equals("") ) {
				String order_dates[] = CommonUtil.isNull(doc02.getT_general_date()).split("[|]");
				for( int i=0; i<order_dates.length; i++){
					String order_date = order_dates[i];
					
					// 일회성긴급요청서에서 특정실행날짜대로 작업 생성.
					doc02.setT_general_date(order_date);
					
					map.put("doc02", doc02);
					
					rMap = emJobCreateDao.createJobs(map);
				}
			
			// 특정실행날짜가 존재하지 않으면 바로 올린다.
			} else {
				
				map.put("doc02", doc02);
				
				rMap = emJobCreateDao.createJobs(map);
			}
			
			String rCode 	= CommonUtil.isNull(rMap.get("rCode"));
			
			if( !"1".equals(rCode)){
				rMap.put("r_code", "-2");
				throw new DefaultServiceException(rMap);
			}
			
		} else if ( strDocGb.equals("03") ) {
			
			map.put("doc03", worksApprovalDocDao.dGetDoc03(map));
			
			rMap = emJobDeleteDao.deleteJobs(map);
			
			String rCode 	= CommonUtil.isNull(rMap.get("rCode"));
			
			if( !"1".equals(rCode)){
				rMap.put("r_code", "-2");
				throw new DefaultServiceException(rMap);
			}else{
				Doc03Bean docBean		= (Doc03Bean)map.get("doc03");
				
				// 삭제 요청이 완료 되면 그룹작업안의 작업도 삭제한다.
				Map map2 = new HashMap();
				map2.put("flag", 		"delete_job_id");
				map2.put("table_id", 	CommonUtil.isNull(docBean.getTable_id()));
				map2.put("job_id", 		CommonUtil.isNull(docBean.getJob_id()));
				
				worksApprovalDocDao.dPrcJobGroup(map2);
			}
			
		} else if ( strDocGb.equals("04") ) {
			
			Doc01Bean bean04_org = worksApprovalDocDao.dGetJobModifyInfo(map);
			
			if( bean04_org == null){
				rMap.put("r_code","-1");
				rMap.put("r_msg","ERROR.16");
				throw new DefaultServiceException(rMap);
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
			rMap = emJobDeleteDao.deleteJobs(map);
			
			String rCode 	= CommonUtil.isNull(rMap.get("rCode"));
			
			if( !"1".equals(rCode)){
				rMap.put("r_code", "-2");
				throw new DefaultServiceException(rMap);
			}else{
				Doc03Bean docBean03		= (Doc03Bean)map.get("doc03");
				
				map.put("data_center", docBean03.getData_center());
				map.put("table_name", docBean03.getTable_name());
			
				map.put("doc01", bean04);
				
				rMap = emJobDefinitionDao.prcDefCreateJobs(map);
				
				rCode 			= CommonUtil.isNull(rMap.get("rCode"));
				String rMsg 	= CommonUtil.isNull(rMap.get("rMsg"));
				
				// 만약 신규 등록이 에러가 나면..
				if( !"1".equals(rCode)){
					
					map.put("doc01", bean04_org);
					
					// 기존 작업 다시 신규 등록.
					rMap = emJobDefinitionDao.prcDefCreateJobs(map);
					
					Doc01Bean docBean		= (Doc01Bean)map.get("doc01");
					
					map.put("data_center", docBean.getData_center());
					map.put("table_name", docBean.getTable_name());
					map.put("job_name", docBean.getJob_name());
					
					// 수정 등록 시 에러 -> 기존 등록본 원복 후 수정요청서 에러로 간주.
					// 수정 등록 시의 에러 메세지 뿌려준다.
					rMap.put("r_code", "-2");
					rMap.put("r_msg", rMsg);
					throw new DefaultServiceException(rMap);
				}else{
					Doc01Bean docBean		= (Doc01Bean)map.get("doc01");
					
					// 수정 요청이 완료 되면 table_id, job_id 가 바뀐다.
					// 그룹작업안의 작업을 table_id, job_id 로 매핑하였기 때문에 해당 작업의 필드를 업데이트 해줘서 동기화 시켜준다.
					Map map2 = new HashMap();
					map2.put("flag", 			"update_job_id");
					map2.put("data_center", 	CommonUtil.isNull(docBean.getData_center()));
					map2.put("job_name", 		CommonUtil.isNull(docBean.getJob_name()));
					
					worksApprovalDocDao.dPrcJobGroup(map2);
				}
			}
			
		} else if ( strDocGb.equals("05") ) {
			
			String strDocGroupId = CommonUtil.isNull(map.get("doc_group_id"));
			
			// 일반 ORDER API 호출.
			if ( strDocGroupId.equals("") || strDocGroupId.equals("0") ) { 
				
				Doc01Bean bean04_org = worksApprovalDocDao.dGetJobModifyInfo(map);
				
				if( bean04_org == null){
					rMap.put("r_code","-1");
					rMap.put("r_msg","ERROR.16");
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
				System.out.println(doc05.getJob_name() + " : 오더 수행");
				rMap = emJobOrderDao.jobsOrder(map);
				
				String rCode 	= CommonUtil.isNull(rMap.get("rCode"));
			
				if( !"1".equals(rCode)){
					rMap.put("r_code", "-2");
					throw new DefaultServiceException(rMap);
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
				
				Doc05Bean doc05 = worksApprovalDocDao.dGetGroupDoc05(map);
				
				map.put("doc05", doc05);
				
				String rCode = "1";
			}
			
		} else if ( strDocGb.equals("06") ) {
			
			Doc01Bean doc01 = new Doc01Bean();
			Doc06Bean doc06 = worksApprovalDocDao.dGetDoc06(map);
			
			doc01.setData_center(CommonUtil.isNull(doc06.getData_center()));
			doc01.setTable_name(CommonUtil.isNull(doc06.getTable_name()));
			
			map.put("doc01", doc01);
			
			List alDocList = new ArrayList();
			alDocList = worksApprovalDocDao.dGetDoc06DetailList(map);
			map.put("alDocList", alDocList);
	
			rMap = emJobDefinitionDao.prcDefCreateJobs(map);
			
			String rCode 	= CommonUtil.isNull(rMap.get("rCode"));
			String rMsg 	= CommonUtil.isNull(rMap.get("rMsg"));
			
			if( !"1".equals(rCode)){
				rMap.put("r_code", 	"-2");
				rMap.put("r_msg", 	rMsg);
				throw new DefaultServiceException(rMap);
			}
		}
		
		return rMap;
	}
	
	synchronized public Map emPrcAjobUpdate(Map map) throws Exception{
		
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
