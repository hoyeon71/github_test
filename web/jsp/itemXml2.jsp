<%@ page language="java" contentType="application/xml; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,java.util.*,java.io.*,java.text.*,java.net.*"%>
<%@ page import="com.ghayoun.ezjobs.common.util.*"%>
<%@ page import="com.ghayoun.ezjobs.m.domain.*"%>
<%@ page import="com.ghayoun.ezjobs.t.domain.*"%>
<%@ page import="com.ghayoun.ezjobs.comm.domain.*"%>
<%@ page import="com.ghayoun.ezjobs.a.domain.*"%>

<%
	response.setHeader("Cache-Control","no-store"); //HTTP 1.1
	response.setHeader("Pragma","no-cache"); //HTTP 1.0
	response.setDateHeader ("Expires", 0);	
%>

<%
	Map<String, Object> paramMap = CommonUtil.collectParameters(request);
	
	String itemGb 		= CommonUtil.isNull(paramMap.get("itemGb"));	
	String itemType 	= CommonUtil.isNull(paramMap.get("itemType"));
	String itemId 		= CommonUtil.isNull(paramMap.get("itemId"));	
	String itemEtc 		= CommonUtil.isNull(paramMap.get("itemEtc"));
	String searchType 	= CommonUtil.isNull(paramMap.get("searchType"));
	String itemId2 		= searchType.replaceAll("List", "");
	
	String aGb[] = null;
	
%>
<doc> 

<%	
	if("select".equals(itemType)){
		out.println("<select id='"+itemId2+"' name='"+itemId2+"' >");
		out.println("<option value=''>--전체--</option>");
		if(itemGb.equals("searchItemList")){
			List<CommonBean> itemList = (List)request.getAttribute("itemList");
			for(int i=0;itemList != null && i<itemList.size(); i++){
				CommonBean bean = itemList.get(i);
				
				if(searchType.equals("applicationList")){
					out.println("<option value='"+CommonUtil.isNull(bean.getApplication())+"'>"+CommonUtil.isNull(bean.getApplication())+"</option>");
				}else if(searchType.equals("group_nameList")){
					out.println("<option value='"+CommonUtil.isNull(bean.getGroup_name())+"'>"+CommonUtil.isNull(bean.getGroup_name())+"</option>");
				}else if(searchType.equals("monthApplicationList")){
					out.println("<option value='"+CommonUtil.isNull(bean.getApplication())+"'>"+CommonUtil.isNull(bean.getApplication())+"</option>");
				}else if(searchType.equals("monthGroup_nameList")){
					out.println("<option value='"+CommonUtil.isNull(bean.getGroup_name())+"'>"+CommonUtil.isNull(bean.getGroup_name())+"</option>");
				}else if(searchType.equals("sched_tableList")){
					out.println("<option value='"+CommonUtil.isNull(bean.getSched_table())+"'>"+CommonUtil.isNull(bean.getSched_table())+"</option>");
				}else if(searchType.equals("application_of_defList")){
					out.println("<option value='"+CommonUtil.isNull(bean.getApplication_of_def())+"'>"+CommonUtil.isNull(bean.getApplication_of_def())+"</option>");
				}else if(searchType.equals("group_name_of_defList")){
					out.println("<option value='"+CommonUtil.isNull(bean.getGroup_name_of_def())+"'>"+CommonUtil.isNull(bean.getGroup_name_of_def())+"</option>");
				}else if(searchType.equals("sub_table_of_defList")){
					out.println("<option value='"+CommonUtil.isNull(bean.getSub_table())+"'>"+CommonUtil.isNull(bean.getSub_table())+"</option>");
				}
			}
		}
	
	}else{
		if(itemGb.equals("mainDocInfoList")){
			
			List<DocInfoBean> itemList = (List)request.getAttribute("itemList");
			if( !(null!=itemList && 0<itemList.size()) ){
				out.println("<items cnt='0' msg='"+CommonUtil.getMessage("DEBUG.06")+"' ></items>");
			}else{
				out.println("<items cnt='"+itemList.size()+"' >");

				for( int i=0; i<itemList.size(); i++ ){
					DocInfoBean bean = itemList.get(i);

					String doc_gb_org = CommonUtil.isNull(bean.getDoc_gb());

					if(CommonUtil.isNull(bean.getDoc_gb()).equals("05") && !CommonUtil.isNull(bean.getDoc_group_id()).equals("")){
						doc_gb_org = doc_gb_org + "G";
					}

					out.println("<item>");

					out.println("<TASK_TYPE><![CDATA["+CommonUtil.getMessage("DOC.GB." + doc_gb_org)+"]]></TASK_TYPE>");
					out.println("<MAIN_DOC_CD><![CDATA["+CommonUtil.isNull(bean.getMain_doc_cd())+"]]></MAIN_DOC_CD>");
					out.println("<DOC_CD><![CDATA["+CommonUtil.isNull(bean.getDoc_cd())+"]]></DOC_CD>");
					out.println("<DOC_GB><![CDATA["+CommonUtil.isNull(bean.getDoc_gb())+"]]></DOC_GB>");
					out.println("<TITLE><![CDATA["+CommonUtil.isNull(bean.getTitle())+"]]></TITLE>");
					out.println("<JOB_NAME><![CDATA["+CommonUtil.isNull(bean.getJob_name())+"]]></JOB_NAME>");
					out.println("<DESCRIPTION><![CDATA["+CommonUtil.isNull(bean.getDescription())+"]]></DESCRIPTION>");
					out.println("<STATE_CD><![CDATA["+CommonUtil.isNull(bean.getState_cd())+"]]></STATE_CD>");
					out.println("<STATE_NM><![CDATA["+CommonUtil.getMessage("DOC.STATE."+CommonUtil.isNull(bean.getState_cd()))+"]]></STATE_NM>");
					out.println("<DRAFT_DATE><![CDATA["+CommonUtil.getDateFormat(1,CommonUtil.isNull(bean.getDraft_date()),"&nbsp;")+"]]></DRAFT_DATE>");
					out.println("<INS_DATE><![CDATA["+CommonUtil.isNull(bean.getIns_date())+"]]></INS_DATE>");
					out.println("<STATUS><![CDATA["+CommonUtil.isNull(bean.getStatus())+"]]></STATUS>");
					out.println("<AJOB_STATUS><![CDATA["+CommonUtil.isNull(bean.getAjob_status())+"]]></AJOB_STATUS>");
					out.println("<TABLE_ID><![CDATA["+CommonUtil.isNull(bean.getTable_id())+"]]></TABLE_ID>");
					out.println("<JOB_ID><![CDATA["+CommonUtil.isNull(bean.getJob_id())+"]]></JOB_ID>");
					out.println("<BATCH_RESULT><![CDATA["+CommonUtil.getMessage("APPLY.STATE."+CommonUtil.isNull(bean.getApply_cd()))+"]]></BATCH_RESULT>");
					out.println("<FAIL_COMMENT><![CDATA["+CommonUtil.isNull(bean.getFail_comment())+"]]></FAIL_COMMENT>");

					out.println("<HOLD_YN><![CDATA["+CommonUtil.isNull(bean.getHold_yn())+"]]></HOLD_YN>");
					out.println("<FORCE_YN><![CDATA["+CommonUtil.isNull(bean.getForce_yn())+"]]></FORCE_YN>");
					out.println("<T_SET><![CDATA["+CommonUtil.isNull(bean.getT_set())+"]]></T_SET>");
					out.println("<ORDER_DATE><![CDATA["+CommonUtil.isNull(bean.getOrder_date())+"]]></ORDER_DATE>");
					out.println("<BEFORE_STATUS><![CDATA["+CommonUtil.isNull(bean.getBefore_status())+"]]></BEFORE_STATUS>");
					out.println("<AFTER_STATUS><![CDATA["+CommonUtil.isNull(bean.getAfter_status())+"]]></AFTER_STATUS>");
					out.println("<APPLY_CD><![CDATA["+CommonUtil.isNull(bean.getApply_cd())+"]]></APPLY_CD>");
					out.println("<APPLY_DATE><![CDATA["+CommonUtil.isNull(bean.getApply_date())+"]]></APPLY_DATE>");
					out.println("<APPLY_EXE_DATE><![CDATA["+CommonUtil.isNull(bean.getApply_exe_date())+"]]></APPLY_EXE_DATE>");

					out.println("</item>");
				}
				
				out.println("</items>");
				
			}
		}else if(itemGb.equals("approvalDocInfoList")){
			List<DocInfoBean> itemList = (List)request.getAttribute("itemList");
			if( !(null!=itemList && 0<itemList.size()) ){
				out.println("<items cnt='0' msg='"+CommonUtil.getMessage("DEBUG.06")+"' ></items>");
			}else{
				out.println("<items cnt='"+(itemList.size()-1)+"' total='"+itemList.get(itemList.size()-1)+"'  >");
				for( int i=0; i<itemList.size()-1; i++ ){
					DocInfoBean bean = itemList.get(i);

					String doc_gb = CommonUtil.isNull(bean.getDoc_gb());
					String task_detail = "";
					String task_nm = "";

					if(CommonUtil.isNull(bean.getDoc_gb()).equals("05") && !CommonUtil.isNull(bean.getDoc_group_id()).equals("")){
						doc_gb = doc_gb + "G";
						task_nm    = CommonUtil.getMessage("DOC.GB."+doc_gb);
					}else if(CommonUtil.isNull(bean.getDoc_gb()).equals("06") || CommonUtil.isNull(bean.getDoc_gb()).equals("09")){
						task_nm    	= CommonUtil.getMessage("DOC.GB." + doc_gb + CommonUtil.isNull(bean.getTask_nm_detail()));
					}else {
						task_nm = CommonUtil.getMessage("DOC.GB."+doc_gb);
					}

					String title = CommonUtil.isNull(bean.getTitle());
					if(CommonUtil.isNull(bean.getDoc_gb()).equals("07") && !CommonUtil.isNull(bean.getPost_approval_yn()).equals("A")) {
						task_detail   = "[" + CommonUtil.isNull(bean.getTask_nm_detail()) + "]";
						title = task_detail + title;
					}
					
					out.println("<item>");
					
					out.println("<TASK_NM><![CDATA["+task_nm+"]]></TASK_NM>");

					out.println("<MAIN_DOC_CD><![CDATA["+CommonUtil.isNull(bean.getMain_doc_cd())+"]]></MAIN_DOC_CD>");
					out.println("<DOC_CD><![CDATA["+CommonUtil.isNull(bean.getDoc_cd())+"]]></DOC_CD>");
					out.println("<DOC_GB><![CDATA["+CommonUtil.isNull(bean.getDoc_gb())+"]]></DOC_GB>");
					out.println("<TITLE><![CDATA["+title+"]]></TITLE>");
					out.println("<JOB_NAME><![CDATA["+CommonUtil.isNull(bean.getJob_name())+"]]></JOB_NAME>");
					out.println("<DESCRIPTION><![CDATA["+CommonUtil.isNull(bean.getDescription())+"]]></DESCRIPTION>");

					out.println("<S_APPLY_DATE><![CDATA["+CommonUtil.isNull(bean.getS_apply_date())+"]]></S_APPLY_DATE>");
					out.println("<STATE_CD><![CDATA["+CommonUtil.isNull(bean.getState_cd())+"]]></STATE_CD>");
					out.println("<STATE_NM><![CDATA["+CommonUtil.getMessage("DOC.STATE."+CommonUtil.isNull(bean.getState_cd()))+"]]></STATE_NM>");
					out.println("<DRAFT_DATE><![CDATA["+CommonUtil.getDateFormat(1,CommonUtil.isNull(bean.getDraft_date()),"&nbsp;")+"]]></DRAFT_DATE>");

					out.println("<DEPT_NM><![CDATA["+CommonUtil.isNull(bean.getDept_nm())+"]]></DEPT_NM>");
					out.println("<DEPT_CD><![CDATA["+CommonUtil.isNull(bean.getDept_cd())+"]]></DEPT_CD>");
					out.println("<DUTY_NM><![CDATA["+CommonUtil.isNull(bean.getDuty_nm())+"]]></DUTY_NM>");
					out.println("<DUTY_CD><![CDATA["+CommonUtil.isNull(bean.getDuty_cd())+"]]></DUTY_CD>");
					out.println("<USER_NM><![CDATA["+CommonUtil.isNull(bean.getUser_nm())+"]]></USER_NM>");
					out.println("<USER_CD><![CDATA["+CommonUtil.isNull(bean.getUser_cd())+"]]></USER_CD>");

					out.println("<INS_DATE><![CDATA["+CommonUtil.isNull(bean.getIns_date())+"]]></INS_DATE>");
					out.println("<APPROVAL_DATE><![CDATA["+CommonUtil.isNull(bean.getApproval_date())+"]]></APPROVAL_DATE>");
					out.println("<APPROVAL_SEQ><![CDATA["+CommonUtil.isNull(bean.getCur_approval_seq())+"]]></APPROVAL_SEQ>");

					out.println("<DATA_CENTER><![CDATA["+CommonUtil.isNull(bean.getData_center())+"]]></DATA_CENTER>");
					out.println("<DATA_CENTER_NAME><![CDATA["+CommonUtil.isNull(bean.getData_center_name())+"]]></DATA_CENTER_NAME>");

					out.println("<APPLY_NM><![CDATA["+CommonUtil.getMessage("APPLY.STATE."+CommonUtil.isNull(bean.getApply_cd()))+"]]></APPLY_NM>");
					out.println("<APPLY_CD><![CDATA["+CommonUtil.isNull(bean.getApply_cd())+"]]></APPLY_CD>");
					out.println("<POST_APPROVAL_YN><![CDATA["+CommonUtil.isNull(bean.getPost_approval_yn())+"]]></POST_APPROVAL_YN>");
					out.println("<DETAIL_STATUS><![CDATA["+CommonUtil.isNull(bean.getDetail_status())+"]]></DETAIL_STATUS>");
					out.println("<ALARM_USER><![CDATA["+CommonUtil.isNull(bean.getAlarm_user())+"]]></ALARM_USER>");

					out.println("<DOC_CNT><![CDATA["+CommonUtil.isNull(bean.getDoc_cnt())+"]]></DOC_CNT>");
					out.println("<DOC_GROUP_ID><![CDATA["+CommonUtil.isNull(bean.getDoc_group_id())+"]]></DOC_GROUP_ID>");

					out.println("<E_CNT><![CDATA["+CommonUtil.isNull(bean.getE_cnt())+"]]></E_CNT>");
					out.println("<R_CNT><![CDATA["+CommonUtil.isNull(bean.getR_cnt())+"]]></R_CNT>");
					out.println("<W_CNT><![CDATA["+CommonUtil.isNull(bean.getW_cnt())+"]]></W_CNT>");
					out.println("<APPLY_FAIL_COUNT><![CDATA["+CommonUtil.isNull(bean.getApply_fail_cnt())+"]]></APPLY_FAIL_COUNT>");

					out.println("</item>");
				}
				
				out.println("</items>");
				
			}
		}else if(itemGb.equals("appGrpList")){
			List<AppGrpBean> itemList = (List)request.getAttribute("itemList");
			if( !(null!=itemList && 0<itemList.size()) ){
				out.println("<items cnt='0' msg='"+CommonUtil.getMessage("DEBUG.06")+"' ></items>");
			}else{
				out.println("<items cnt='"+itemList.size()+"' >");
				
				for( int i=0; i<itemList.size(); i++ ){
					AppGrpBean bean = itemList.get(i);
								
					out.println("<item>");
					
					out.println("<GRP_CD><![CDATA["+CommonUtil.isNull(bean.getGrp_cd())+"]]></GRP_CD>");
					out.println("<GRP_NM><![CDATA["+CommonUtil.isNull(bean.getGrp_nm())+"]]></GRP_NM>");
					out.println("<GRP_ENG_NM><![CDATA["+CommonUtil.isNull(bean.getGrp_eng_nm())+"]]></GRP_ENG_NM>");
					out.println("<GRP_DEPTH><![CDATA["+CommonUtil.isNull(bean.getGrp_depth())+"]]></GRP_DEPTH>");
					out.println("<GRP_PARENT_CD><![CDATA["+CommonUtil.isNull(bean.getGrp_parent_cd())+"]]></GRP_PARENT_CD>");
					out.println("<GRP_USE_YN><![CDATA["+CommonUtil.isNull(bean.getGrp_use_yn())+"]]></GRP_USE_YN>");
					out.println("<GRP_DESC><![CDATA["+CommonUtil.isNull(bean.getGrp_desc())+"]]></GRP_DESC>");
					out.println("<GRP_INS_DATE><![CDATA["+CommonUtil.isNull(bean.getGrp_ins_date())+"]]></GRP_INS_DATE>");
					out.println("<GRP_INS_USER_CD><![CDATA["+CommonUtil.isNull(bean.getGrp_ins_user_cd())+"]]></GRP_INS_USER_CD>");
					out.println("<GRP_UDT_DATE><![CDATA["+CommonUtil.isNull(bean.getGrp_udt_date())+"]]></GRP_UDT_DATE>");
					out.println("<GRP_UDT_USER_CD><![CDATA["+CommonUtil.isNull(bean.getGrp_udt_user_cd())+"]]></GRP_UDT_USER_CD>");
					out.println("<SCODE_CD><![CDATA["+CommonUtil.isNull(bean.getScode_cd())+"]]></SCODE_CD>");
					out.println("<HOST_CD><![CDATA["+CommonUtil.isNull(bean.getHost_cd())+"]]></HOST_CD>");
					out.println("<ARR_HOST_CD><![CDATA["+CommonUtil.isNull(bean.getArr_host_cd())+"]]></ARR_HOST_CD>");
					out.println("<ARR_HOST_NM><![CDATA["+CommonUtil.isNull(bean.getArr_host_nm())+"]]></ARR_HOST_NM>");
					out.println("<ARR_HOST_DESC><![CDATA["+CommonUtil.isNull(bean.getArr_host_desc())+"]]></ARR_HOST_DESC>");
					out.println("<USER_DAILY><![CDATA["+CommonUtil.isNull(bean.getUser_daily())+"]]></USER_DAILY>");
					out.println("<CTM_USER_DAILY><![CDATA["+CommonUtil.isNull(bean.getCtm_user_daily())+"]]></CTM_USER_DAILY>");
					out.println("<CHK_CTM_FOLDER><![CDATA["+CommonUtil.isNull(bean.getChk_ctm_folder())+"]]></CHK_CTM_FOLDER>");
					out.println("<SCODE_NM><![CDATA["+CommonUtil.isNull(bean.getScode_nm())+"]]></SCODE_NM>");
					out.println("<JOB_CNT><![CDATA["+CommonUtil.isNull(bean.getJob_cnt())+"]]></JOB_CNT>");
					out.println("<APP_JOB_CNT><![CDATA["+CommonUtil.isNull(bean.getApp_job_cnt())+"]]></APP_JOB_CNT>");
					out.println("<GRP_JOB_CNT><![CDATA["+CommonUtil.isNull(bean.getGrp_job_cnt())+"]]></GRP_JOB_CNT>");
					out.println("<TABLE_TYPE><![CDATA["+CommonUtil.isNull(bean.getTable_type())+"]]></TABLE_TYPE>");

					out.println("</item>");
				}
				
				out.println("</items>");
				
			}
		}else if(itemGb.equals("appGrpCodeList")){
			List<AppGrpBean> itemList = (List)request.getAttribute("itemList");
			if( !(null!=itemList && 0<itemList.size()) ){
				out.println("<items cnt='0' msg='"+CommonUtil.getMessage("DEBUG.06")+"' ></items>");
			}else{
				out.println("<items cnt='"+itemList.size()+"' >");
				
				for( int i=0; i<itemList.size(); i++ ){
					AppGrpBean bean = itemList.get(i);
								
					out.println("<item>");
					
					out.println("<GRP_CD><![CDATA["+CommonUtil.isNull(bean.getGrp_cd())+"]]></GRP_CD>");
					out.println("<GRP_NM><![CDATA["+CommonUtil.isNull(bean.getGrp_nm())+"]]></GRP_NM>");
					out.println("<GRP_ENG_NM><![CDATA["+CommonUtil.isNull(bean.getGrp_eng_nm())+"]]></GRP_ENG_NM>");
					out.println("<GRP_DESC><![CDATA["+CommonUtil.isNull(bean.getGrp_desc())+"]]></GRP_DESC>");
					out.println("<HOST_CD><![CDATA["+CommonUtil.isNull(bean.getHost_cd())+"]]></HOST_CD>");
					out.println("<USER_DAILY><![CDATA["+CommonUtil.isNull(bean.getUser_daily())+"]]></USER_DAILY>");
															
					out.println("</item>");
				}
				
				out.println("</items>");
				
			}
		}else if(itemGb.equals("appGrpCodeList2")){
			List<AppGrpBean> itemList = (List)request.getAttribute("itemList");
			if( !(null!=itemList && 0<itemList.size()) ){
				out.println("<items cnt='0' msg='"+CommonUtil.getMessage("DEBUG.06")+"' ></items>");
			}else{
				out.println("<items cnt='"+itemList.size()+"' >");
				
				for( int i=0; i<itemList.size(); i++ ){
					AppGrpBean bean = itemList.get(i);
								
					out.println("<item>");
					
					out.println("<GRP_CD><![CDATA["+CommonUtil.isNull(bean.getGrp_cd())+"]]></GRP_CD>");
					out.println("<GRP_NM><![CDATA["+CommonUtil.isNull(bean.getGrp_nm())+"]]></GRP_NM>");
					out.println("<GRP_ENG_NM><![CDATA["+CommonUtil.isNull(bean.getGrp_eng_nm())+"]]></GRP_ENG_NM>");
					out.println("<GRP_DESC><![CDATA["+CommonUtil.isNull(bean.getGrp_desc())+"]]></GRP_DESC>");
					out.println("<HOST_CD><![CDATA["+CommonUtil.isNull(bean.getHost_cd())+"]]></HOST_CD>");
					out.println("<USER_DAILY><![CDATA["+CommonUtil.isNull(bean.getUser_daily())+"]]></USER_DAILY>");
					out.println("<TASK_TYPE><![CDATA["+CommonUtil.isNull(bean.getTask_type())+"]]></TASK_TYPE>"); 
					out.println("<TABLE_ID><![CDATA["+CommonUtil.isNull(bean.getTable_id())+"]]></TABLE_ID>");

					out.println("</item>");
				}
				
				out.println("</items>");
				
			}
		}else if(itemGb.equals("searchAppGrpCodeList")){
			List<AppGrpBean> itemList = (List)request.getAttribute("itemList");
			if( !(null!=itemList && 0<itemList.size()) ){
				out.println("<items cnt='0' msg='"+CommonUtil.getMessage("DEBUG.06")+"' ></items>");
			}else{
				out.println("<items cnt='"+itemList.size()+"' >");
				
				for( int i=0; i<itemList.size(); i++ ){
					AppGrpBean bean = itemList.get(i);
								
					out.println("<item>");
					
					out.println("<GRP_CD><![CDATA["+CommonUtil.isNull(bean.getGrp_cd())+"]]></GRP_CD>");
					out.println("<GRP_NM><![CDATA["+CommonUtil.isNull(bean.getGrp_nm())+"]]></GRP_NM>");
					out.println("<GRP_ENG_NM><![CDATA["+CommonUtil.isNull(bean.getGrp_eng_nm())+"]]></GRP_ENG_NM>");
					out.println("<GRP_DESC><![CDATA["+CommonUtil.isNull(bean.getGrp_desc())+"]]></GRP_DESC>");
					out.println("<HOST_CD><![CDATA["+CommonUtil.isNull(bean.getHost_cd())+"]]></HOST_CD>");
					out.println("<TASK_TYPE><![CDATA["+CommonUtil.isNull(bean.getTask_type())+"]]></TASK_TYPE>"); 
					out.println("<TABLE_ID><![CDATA["+CommonUtil.isNull(bean.getTable_id())+"]]></TABLE_ID>");

					out.println("</item>");
				}
				
				out.println("</items>");
				
			}
		}else if(itemGb.equals("subTableList")){
			List<AppGrpBean> itemList = (List)request.getAttribute("itemList");
			if( !(null!=itemList && 0<itemList.size()) ){
				out.println("<items cnt='0' msg='"+CommonUtil.getMessage("DEBUG.06")+"' ></items>");
			}else{
				out.println("<items cnt='"+itemList.size()+"' >");
				
				for( int i=0; i<itemList.size(); i++ ){
					AppGrpBean bean = itemList.get(i);
								
					out.println("<item>");
					out.println("<SUB_TABLE_NM><![CDATA["+CommonUtil.isNull(bean.getSub_table_nm())+"]]></SUB_TABLE_NM>");
					out.println("</item>");
				}
				
				out.println("</items>");
				
			}
		}else if(itemGb.equals("popDefJobList")){
			List<com.ghayoun.ezjobs.t.domain.DefJobBean> itemList = (List)request.getAttribute("itemList");
			if( !(null!=itemList && 0<itemList.size()) ){
				out.println("<items cnt='0' msg='"+CommonUtil.getMessage("DEBUG.06")+"' ></items>");
			}else{
				out.println("<items cnt='"+itemList.size()+"' >");
				
				for( int i=0; i<itemList.size(); i++ ){
					com.ghayoun.ezjobs.t.domain.DefJobBean bean = itemList.get(i);
					
					out.println("<item>");
					
					out.println("<TABLE_ID><![CDATA["+CommonUtil.isNull(bean.getTable_id())+"]]></TABLE_ID>");
					out.println("<JOB_ID><![CDATA["+CommonUtil.isNull(bean.getJob_id())+"]]></JOB_ID>");
					out.println("<DATA_CENTER><![CDATA["+CommonUtil.isNull(bean.getData_center())+"]]></DATA_CENTER>");					
					out.println("<SCHED_TABLE><![CDATA["+CommonUtil.isNull(bean.getSched_table())+"]]></SCHED_TABLE>");
					out.println("<APPLICATION><![CDATA["+CommonUtil.isNull(bean.getApplication())+"]]></APPLICATION>");
					out.println("<GROUP_NAME><![CDATA["+CommonUtil.isNull(bean.getGroup_name())+"]]></GROUP_NAME>");
					out.println("<MEM_NAME><![CDATA["+CommonUtil.isNull(bean.getMemname())+"]]></MEM_NAME>");
					out.println("<JOB_NAME><![CDATA["+CommonUtil.isNull(bean.getJob_name())+"]]></JOB_NAME>");
					out.println("<DESCRIPTION><![CDATA["+CommonUtil.isNull(bean.getDescription())+"]]></DESCRIPTION>");
					out.println("<MAPPER_DATA_CENTER><![CDATA["+CommonUtil.isNull(bean.getMapper_data_center())+"]]></MAPPER_DATA_CENTER>");
					
					out.println("</item>");
				}
				out.println("</items>");
				
			}
		}else if(itemGb.equals("calCodeList") || itemGb.equals("calCodeList2")){
			List<CalCodeBean> itemList = (List)request.getAttribute("itemList");
			if( !(null!=itemList && 0<itemList.size()) ){
				out.println("<items cnt='0' msg='"+CommonUtil.getMessage("DEBUG.06")+"' ></items>");
			}else{
				out.println("<items cnt='"+itemList.size()+"' >");
				
				for( int i=0; i<itemList.size(); i++ ){
					CalCodeBean bean = itemList.get(i);
					
					out.println("<item>");
				
					out.println("<CAL_CD><![CDATA["+CommonUtil.isNull(bean.getCal_cd())+"]]></CAL_CD>");
					out.println("<DATA_CENTER><![CDATA["+CommonUtil.isNull(bean.getData_center())+"]]></DATA_CENTER>");
					out.println("<TABLE_GB><![CDATA["+CommonUtil.isNull(bean.getTable_gb())+"]]></TABLE_GB>");
					out.println("<USE_YN><![CDATA["+CommonUtil.isNull(bean.getUse_yn())+"]]></USE_YN>");
					out.println("<USE_GB><![CDATA["+CommonUtil.isNull(bean.getUse_gb())+"]]></USE_GB>");
					out.println("<CAL_NM><![CDATA["+CommonUtil.isNull(bean.getCal_nm())+"]]></CAL_NM>");
					out.println("<DAYS_CAL><![CDATA["+CommonUtil.isNull(bean.getDays_cal())+"]]></DAYS_CAL>");
					out.println("<DAYS_AND_OR><![CDATA["+CommonUtil.isNull(bean.getDays_and_or())+"]]></DAYS_AND_OR>");
					out.println("<WEEKS_CAL><![CDATA["+CommonUtil.isNull(bean.getWeeks_cal())+"]]></WEEKS_CAL>");
					out.println("<CONF_CAL><![CDATA["+CommonUtil.isNull(bean.getConf_cal())+"]]></CONF_CAL>");
					out.println("<SHIFT><![CDATA["+CommonUtil.isNull(bean.getShift())+"]]></SHIFT>");
					out.println("<SHIFT_NUM><![CDATA["+CommonUtil.isNull(bean.getShift_num())+"]]></SHIFT_NUM>");
					out.println("<MONTH_CAL><![CDATA["+CommonUtil.isNull(bean.getMonth_cal())+"]]></MONTH_CAL>");
					out.println("<INS_DATE><![CDATA["+CommonUtil.isNull(bean.getIns_date())+"]]></INS_DATE>");
					out.println("<INS_USER_CD><![CDATA["+CommonUtil.isNull(bean.getIns_user_cd())+"]]></INS_USER_CD>");			
					out.println("<MONTH_DAYS><![CDATA["+CommonUtil.isNull(bean.getMonth_days())+"]]></MONTH_DAYS>");
					out.println("<DATES_STR><![CDATA["+CommonUtil.isNull(bean.getDates_str())+"]]></DATES_STR>");
					out.println("<WEEK_DAYS><![CDATA["+CommonUtil.isNull(bean.getWeek_days())+"]]></WEEK_DAYS>");
																								
					out.println("</item>");
				}
				out.println("</items>");
				
			}
		}else if(itemGb.equals("searchItemList")){
			List<CommonBean> itemList = (List)request.getAttribute("itemList");
			if( !(null!=itemList && 0<itemList.size()) ){
				out.println("<items cnt='0' msg='"+CommonUtil.getMessage("DEBUG.06")+"' ></items>");
			}else{
				out.println("<items cnt='"+itemList.size()+"' >");
				
				for( int i=0; i<itemList.size(); i++ ){
					CommonBean bean = itemList.get(i);
					
					out.println("<item>");
					
					if(searchType.equals("days_calList") || searchType.equals("weeks_calList")){
						out.println("<CALENDAR><![CDATA["+CommonUtil.isNull(bean.getCalendar())+"]]></CALENDAR>");
					}
																								
					out.println("</item>");
				}
				out.println("</items>");
				
			}
		}else if(itemGb.equals("timeInfoList") || itemGb.equals("endTimeInfoList") || itemGb.equals("activeStartTimeList") ){
			List<TimeInfoBean> itemList = (List)request.getAttribute("itemList");
			if( !(null!=itemList && 0<itemList.size()) ){
				out.println("<items cnt='0' msg='"+CommonUtil.getMessage("DEBUG.06")+"' ></items>");
			}else{
				out.println("<items cnt='"+itemList.size()+"' >");
				
				for( int i=0; i<itemList.size(); i++ ){
					TimeInfoBean bean = itemList.get(i);
					
					String strOdate			= CommonUtil.isNull(bean.getOdate());
					String strStartTime		= CommonUtil.isNull(bean.getStart_time());
					String strEndTime 		= CommonUtil.isNull(bean.getEnd_time());					
					String strOdateMent		= "20"+strOdate.substring(0, 2) + "/" + strOdate.substring(2, 4) + "/" + strOdate.substring(4, 6);
					String strStartTimeMent	= CommonUtil.getDateFormat(1, strStartTime);
					String strEndTimeMent	= CommonUtil.getDateFormat(1, strEndTime);					
					//String strDiffTime		= CommonUtil.getDiffTime(CommonUtil.getDateFormat(1, strStartTime), CommonUtil.getDateFormat(1, strEndTime));
					String strStateResult	= CommonUtil.isNull(bean.getState_result());
					String strRerunCounter	= CommonUtil.isNull(bean.getRerun_counter());
					String strJobName		= CommonUtil.isNull(bean.getJob_name());
					
					out.println("<item>");					
					
					out.println("<ODATE><![CDATA["+CommonUtil.isNull(strOdateMent)+"]]></ODATE>");
					out.println("<START_TIME><![CDATA["+CommonUtil.isNull(strStartTimeMent)+"]]></START_TIME>");
					out.println("<END_TIME><![CDATA["+CommonUtil.isNull(strEndTimeMent)+"]]></END_TIME>");
					//out.println("<DIFF_TIME><![CDATA["+CommonUtil.isNull(strDiffTime)+"]]></DIFF_TIME>");
					out.println("<DIFF_TIME><![CDATA["+strStateResult+"]]></DIFF_TIME>");
					out.println("<RERUN_COUNTER><![CDATA["+strRerunCounter+"]]></RERUN_COUNTER>");
					out.println("<STATE_RESULT><![CDATA["+strStateResult+"]]></STATE_RESULT>");
					out.println("<JOB_NAME><![CDATA["+strJobName+"]]></JOB_NAME>");
																								
					out.println("</item>");
				}
				out.println("</items>");
				
			}
		}else if(itemGb.equals("noticeList")){
			List<BoardBean> itemList = (List)request.getAttribute("itemList");
			if( !(null!=itemList && 0<itemList.size()) ){
				out.println("<items cnt='0' msg='"+CommonUtil.getMessage("DEBUG.06")+"' ></items>");
			}else{
				out.println("<items cnt='"+itemList.size()+"' >");
				
				for( int i=0; i<itemList.size(); i++ ){
					BoardBean bean = itemList.get(i);
										
					out.println("<item>");					
					
					out.println("<BOARD_CD><![CDATA["+CommonUtil.isNull(bean.getBoard_cd())+"]]></BOARD_CD>");
					out.println("<TITLE><![CDATA["+CommonUtil.isNull(bean.getTitle())+"]]></TITLE>");
					out.println("<CONTENT><![CDATA["+CommonUtil.isNull(bean.getContent())+"]]></CONTENT>");
					out.println("<STATUS><![CDATA["+CommonUtil.isNull(bean.getStatus())+"]]></STATUS>");
					out.println("<DEL_YN><![CDATA["+CommonUtil.isNull(bean.getDel_yn())+"]]></DEL_YN>");
					out.println("<FILE_NM><![CDATA["+CommonUtil.isNull(bean.getFile_nm())+"]]></FILE_NM>");
					out.println("<FILE_PATH><![CDATA["+CommonUtil.isNull(bean.getFile_path())+"]]></FILE_PATH>");
					out.println("<NOTI_YN><![CDATA["+CommonUtil.isNull(bean.getNoti_yn())+"]]></NOTI_YN>");
					out.println("<APP_USER_CD><![CDATA["+CommonUtil.isNull(bean.getApp_user_cd())+"]]></APP_USER_CD>");
					out.println("<APP_USER_NM><![CDATA["+CommonUtil.isNull(bean.getApp_user_nm())+"]]></APP_USER_NM>");	
					out.println("<INS_USER_CD><![CDATA["+CommonUtil.isNull(bean.getIns_user_cd())+"]]></INS_USER_CD>");
					out.println("<INS_USER_NM><![CDATA["+CommonUtil.isNull(bean.getIns_user_nm())+"]]></INS_USER_NM>");
					out.println("<INS_DATE><![CDATA["+CommonUtil.isNull(bean.getIns_date())+"]]></INS_DATE>");
					out.println("<SEQ><![CDATA["+CommonUtil.isNull(bean.getSeq())+"]]></SEQ>");
																								
					out.println("</item>");
				}
				out.println("</items>");
				
			}
		}else if(itemGb.equals("noticeDetail")){
			List<BoardBean> itemList = (List)request.getAttribute("itemList");
			if( !(null!=itemList && 0<itemList.size()) ){
				out.println("<items cnt='0' msg='"+CommonUtil.getMessage("DEBUG.06")+"' ></items>");
			}else{
				out.println("<items cnt='"+itemList.size()+"' >");
				
				for( int i=0; i<itemList.size(); i++ ){
					BoardBean bean = itemList.get(i);
										
					out.println("<item>");					
					
					out.println("<BOARD_CD><![CDATA["+CommonUtil.isNull(bean.getBoard_cd())+"]]></BOARD_CD>");
					out.println("<TITLE><![CDATA["+CommonUtil.isNull(bean.getTitle())+"]]></TITLE>");
					out.println("<CONTENT><![CDATA["+CommonUtil.isNull(bean.getContent())+"]]></CONTENT>");
					out.println("<STATUS><![CDATA["+CommonUtil.isNull(bean.getStatus())+"]]></STATUS>");
					out.println("<DEL_YN><![CDATA["+CommonUtil.isNull(bean.getDel_yn())+"]]></DEL_YN>");
					out.println("<FILE_NM><![CDATA["+CommonUtil.isNull(bean.getFile_nm())+"]]></FILE_NM>");
					out.println("<FILE_PATH><![CDATA["+CommonUtil.isNull(bean.getFile_path())+"]]></FILE_PATH>");
					out.println("<NOTI_YN><![CDATA["+CommonUtil.isNull(bean.getNoti_yn())+"]]></NOTI_YN>");
					out.println("<APP_USER_CD><![CDATA["+CommonUtil.isNull(bean.getApp_user_cd())+"]]></APP_USER_CD>");
					out.println("<APP_USER_NM><![CDATA["+CommonUtil.isNull(bean.getApp_user_nm())+"]]></APP_USER_NM>");	
					out.println("<INS_USER_CD><![CDATA["+CommonUtil.isNull(bean.getIns_user_cd())+"]]></INS_USER_CD>");
					out.println("<INS_USER_NM><![CDATA["+CommonUtil.isNull(bean.getIns_user_nm())+"]]></INS_USER_NM>");
					out.println("<INS_DATE><![CDATA["+CommonUtil.isNull(bean.getIns_date())+"]]></INS_DATE>");
					out.println("<SEQ><![CDATA["+CommonUtil.isNull(bean.getSeq())+"]]></SEQ>");
					out.println("<POPUP_YN><![CDATA["+CommonUtil.isNull(bean.getPopup_yn())+"]]></POPUP_YN>");
					out.println("<POPUP_S_DATE><![CDATA["+CommonUtil.isNull(bean.getPopup_s_date())+"]]></POPUP_S_DATE>");
					out.println("<POPUP_E_DATE><![CDATA["+CommonUtil.isNull(bean.getPopup_e_date())+"]]></POPUP_E_DATE>");
																								
					out.println("</item>");
				}
				out.println("</items>");
				
			}
		}else if(itemGb.equals("defJobList")){
			List<com.ghayoun.ezjobs.t.domain.DefJobBean> itemList = (List)request.getAttribute("itemList");
			if( !(null!=itemList && 0<itemList.size()) ){
				out.println("<items cnt='0' msg='"+CommonUtil.getMessage("DEBUG.06")+"' ></items>");
			}else{
				out.println("<items cnt='"+(itemList.size()-1)+"' total='"+itemList.get(itemList.size()-1)+"'>");
				
				for( int i=0; i<itemList.size()-1; i++ ){
					com.ghayoun.ezjobs.t.domain.DefJobBean bean = itemList.get(i);

					String user_list = CommonUtil.isNull(bean.getUser_id());
					user_list += CommonUtil.isNull(bean.getUser_id2());
					user_list += CommonUtil.isNull(bean.getUser_id3());
					user_list += CommonUtil.isNull(bean.getUser_id4());
					user_list += CommonUtil.isNull(bean.getUser_id5());
					user_list += CommonUtil.isNull(bean.getUser_id6());
					user_list += CommonUtil.isNull(bean.getUser_id7());
					user_list += CommonUtil.isNull(bean.getUser_id8());
					user_list += CommonUtil.isNull(bean.getUser_id9());
					user_list += CommonUtil.isNull(bean.getUser_id10());

					out.println("<item>");
										
					out.println("<TABLE_ID><![CDATA["+CommonUtil.isNull(bean.getTable_id())+"]]></TABLE_ID>");
					out.println("<JOB_ID><![CDATA["+CommonUtil.isNull(bean.getJob_id())+"]]></JOB_ID>");
					out.println("<DATA_CENTER><![CDATA["+CommonUtil.isNull(bean.getData_center())+"]]></DATA_CENTER>");
					out.println("<SCHED_TABLE><![CDATA["+CommonUtil.isNull(bean.getSched_table())+"]]></SCHED_TABLE>");
					out.println("<APPLICATION><![CDATA["+CommonUtil.isNull(bean.getApplication())+"]]></APPLICATION>");
					out.println("<GROUP_NAME><![CDATA["+CommonUtil.isNull(bean.getGroup_name())+"]]></GROUP_NAME>");
					out.println("<JOB_NAME><![CDATA["+CommonUtil.isNull(bean.getJob_name())+"]]></JOB_NAME>");
					out.println("<MEM_NAME><![CDATA["+CommonUtil.isNull(bean.getMemname())+"]]></MEM_NAME>");
					out.println("<TASK_TYPE><![CDATA["+CommonUtil.isNull(bean.getTask_type())+"]]></TASK_TYPE>");
					out.println("<USER_DAILY><![CDATA["+CommonUtil.isNull(bean.getUser_daily())+"]]></USER_DAILY>");
					out.println("<AUTHOR><![CDATA["+CommonUtil.isNull(bean.getAuthor())+"]]></AUTHOR>");  
					out.println("<OWNER><![CDATA["+CommonUtil.isNull(bean.getOwner())+"]]></OWNER>");
					out.println("<MEM_LIB><![CDATA["+CommonUtil.isNull(bean.getMem_lib())+"]]></MEM_LIB>");
					out.println("<COMMAND><![CDATA["+CommonUtil.isNull(bean.getCommand())+"]]></COMMAND>");
					out.println("<DESCRIPTION><![CDATA["+CommonUtil.isNull(bean.getDescription())+"]]></DESCRIPTION>"); 
					out.println("<ERROR_DESCRIPTION><![CDATA["+CommonUtil.isNull(bean.getError_description())+"]]></ERROR_DESCRIPTION>");
					out.println("<PREV_DOC_INFO><![CDATA["+CommonUtil.isNull(bean.getPrev_doc_info())+"]]></PREV_DOC_INFO>");
					out.println("<SMART_JOB_YN><![CDATA["+CommonUtil.isNull(bean.getSmart_job_yn())+"]]></SMART_JOB_YN>");

					out.println("<USER_NM><![CDATA["+CommonUtil.isNull(bean.getUser_nm())+"]]></USER_NM>");
					//오더권한 있는 담당자 리스트
					out.println("<USER_LIST><![CDATA["+user_list+"]]></USER_LIST>");

					out.println("</item>");
				}
				out.println("</items>");
				
			}

		}else if(itemGb.equals("doc06DetailList")){
			
			List<Doc06Bean> itemList = (List)request.getAttribute("itemList");
			if( !(null!=itemList && 0<itemList.size()) ){
				out.println("<items cnt='0' msg='"+CommonUtil.getMessage("DEBUG.06")+"' ></items>");
			}else{
				out.println("<items cnt='"+itemList.size()+"' >");
				
				for( int i=0; i<itemList.size(); i++ ){
					Doc06Bean bean = itemList.get(i);
					
					String strT_set = CommonUtil.isNull(bean.getT_set());
					
					String strT_set_var 			= "";
					String strMonitor_time			= "";
					String strMonitor_interval		= "";
					String strFilesize_comparison	= "";
					String strNum_of_iterations		= "";
					String strStop_time				= "";
					
					if ( !strT_set.equals("") ) {
						String arr_t_set[]  = strT_set.split("[|]");
						for ( int ii = 0; ii < arr_t_set.length; ii++ ) {
							String arr_t_set_detail[]  = arr_t_set[ii].split("[,]");
							
							if ( arr_t_set_detail.length > 1 ) {
							
								if ( arr_t_set_detail[0].equals("LIBMEMSYM") || arr_t_set_detail[0].indexOf("FileWatch") > -1  ) {
									
								} else {
									strT_set_var += "|" + arr_t_set[ii];
								}
								
								// FileWatch 셋팅
								if ( arr_t_set_detail[0].indexOf("FileWatch-INT_FILE_SEARCHES") > -1 ) {
									strMonitor_interval = arr_t_set_detail[1];
								}
								if ( arr_t_set_detail[0].indexOf("FileWatch-TIME_LIMIT") > -1 ) {
									strMonitor_time = arr_t_set_detail[1];
								}
								if ( arr_t_set_detail[0].indexOf("FileWatch-INT_FILESIZE_COMPARISON") > -1 ) {
									strFilesize_comparison = arr_t_set_detail[1];
								}
								if ( arr_t_set_detail[0].indexOf("FileWatch-NUM_OF_ITERATIONS") > -1 ) {
									strNum_of_iterations = arr_t_set_detail[1];
								}
								if ( arr_t_set_detail[0].indexOf("FileWatch-STOP_TIME") > -1 ) {
									strStop_time = arr_t_set_detail[1];
								}
							}
						}
						
						if ( !strT_set_var.equals("") && strT_set_var.substring(0, 1).equals("|") ) strT_set_var = strT_set_var.substring(1, strT_set_var.length());
					}					
					
					out.println("<item>");

					out.println("<DOC_CD><![CDATA["+CommonUtil.isNull(bean.getDoc_cd())+"]]></DOC_CD>");
					out.println("<SYSTEMGB><![CDATA["+CommonUtil.isNull(bean.getSystemgb())+"]]></SYSTEMGB>");
					out.println("<JOBTYPEGB><![CDATA["+CommonUtil.isNull(bean.getJobTypegb())+"]]></JOBTYPEGB>");
					out.println("<TABLE_NAME><![CDATA["+CommonUtil.isNull(bean.getTable_name())+"]]></TABLE_NAME>");
					out.println("<APPLICATION><![CDATA["+CommonUtil.isNull(bean.getApplication())+"]]></APPLICATION>");
					out.println("<GROUP_NAME><![CDATA["+CommonUtil.isNull(bean.getGroup_name())+"]]></GROUP_NAME>");
					out.println("<JOB_NAME><![CDATA["+CommonUtil.isNull(bean.getJob_name())+"]]></JOB_NAME>");
					out.println("<DESC><![CDATA["+CommonUtil.isNull(bean.getDescription())+"]]></DESC>");
					out.println("<MEM_NAME><![CDATA["+CommonUtil.isNull(bean.getMem_name())+"]]></MEM_NAME>");
					out.println("<MEM_LIB><![CDATA["+CommonUtil.isNull(bean.getMem_lib())+"]]></MEM_LIB>");
					out.println("<AUTHOR><![CDATA["+CommonUtil.isNull(bean.getAuthor())+"]]></AUTHOR>");
					out.println("<OWNER><![CDATA["+CommonUtil.isNull(bean.getOwner())+"]]></OWNER>");
					out.println("<TASK_TYPE><![CDATA["+CommonUtil.isNull(bean.getTask_type())+"]]></TASK_TYPE>");
					out.println("<NODE_ID><![CDATA["+CommonUtil.isNull(bean.getNode_id())+"]]></NODE_ID>");
					out.println("<PRIORITY><![CDATA["+CommonUtil.isNull(bean.getPriority())+"]]></PRIORITY>");
					out.println("<CRITICAL><![CDATA["+CommonUtil.isNull(bean.getCritical())+"]]></CRITICAL>");
					out.println("<CYCLIC><![CDATA["+CommonUtil.isNull(bean.getCyclic())+"]]></CYCLIC>");
					out.println("<RERUN_INTERVAL><![CDATA["+CommonUtil.isNull(bean.getRerun_interval())+"]]></RERUN_INTERVAL>");
					out.println("<RERUN_MAX><![CDATA["+CommonUtil.isNull(bean.getRerun_max())+"]]></RERUN_MAX>");
					out.println("<COUNT_CYCLIC_FROM><![CDATA["+CommonUtil.isNull(bean.getCount_cyclic_from())+"]]></COUNT_CYCLIC_FROM>");
					out.println("<COMMAND><![CDATA["+CommonUtil.isNull(bean.getCommand())+"]]></COMMAND>");
					out.println("<CONFIRM_FLAG><![CDATA["+CommonUtil.isNull(bean.getConfirm_flag())+"]]></CONFIRM_FLAG>");
					out.println("<MAX_WAIT><![CDATA["+CommonUtil.isNull(bean.getMax_wait())+"]]></MAX_WAIT>");
					out.println("<TIME_FROM><![CDATA["+CommonUtil.isNull(bean.getTime_from())+"]]></TIME_FROM>");
					out.println("<TIME_UNTIL><![CDATA["+CommonUtil.isNull(bean.getTime_until())+"]]></TIME_UNTIL>");
					out.println("<T_GENERAL_DATE><![CDATA["+CommonUtil.isNull(bean.getT_general_date())+"]]></T_GENERAL_DATE>");
					out.println("<T_CONDITIONS_IN><![CDATA["+CommonUtil.isNull(bean.getT_conditions_in())+"]]></T_CONDITIONS_IN>");
					out.println("<T_CONDITIONS_OUT><![CDATA["+CommonUtil.isNull(bean.getT_conditions_out())+"]]></T_CONDITIONS_OUT>");
					out.println("<T_RESOURCES_C><![CDATA["+CommonUtil.isNull(bean.getT_resources_c())+"]]></T_RESOURCES_C>");					
					out.println("<T_SET><![CDATA["+CommonUtil.isNull(bean.getT_set())+"]]></T_SET>");
					out.println("<T_STEPS><![CDATA["+CommonUtil.isNull(bean.getT_steps())+"]]></T_STEPS>");
					out.println("<T_RESOURCES_Q><![CDATA["+CommonUtil.isNull(bean.getT_resources_q())+"]]></T_RESOURCES_Q>");
					out.println("<T_POSTPROC><![CDATA["+CommonUtil.isNull(bean.getT_postproc())+"]]></T_POSTPROC>");
					out.println("<CALENDAR_NM><![CDATA["+CommonUtil.isNull(bean.getCalendar_nm())+"]]></CALENDAR_NM>");
					out.println("<MONTH_DAYS><![CDATA["+CommonUtil.isNull(bean.getMonth_days())+"]]></MONTH_DAYS>");
					out.println("<DAYS_CAL><![CDATA["+CommonUtil.isNull(bean.getDays_cal())+"]]></DAYS_CAL>"); 
					out.println("<MONTH_1><![CDATA["+CommonUtil.isNull(bean.getMonth_1())+"]]></MONTH_1>"); 
					out.println("<MONTH_2><![CDATA["+CommonUtil.isNull(bean.getMonth_2())+"]]></MONTH_2>"); 
					out.println("<MONTH_3><![CDATA["+CommonUtil.isNull(bean.getMonth_3())+"]]></MONTH_3>"); 
					out.println("<MONTH_4><![CDATA["+CommonUtil.isNull(bean.getMonth_4())+"]]></MONTH_4>"); 
					out.println("<MONTH_5><![CDATA["+CommonUtil.isNull(bean.getMonth_5())+"]]></MONTH_5>"); 
					out.println("<MONTH_6><![CDATA["+CommonUtil.isNull(bean.getMonth_6())+"]]></MONTH_6>"); 
					out.println("<MONTH_7><![CDATA["+CommonUtil.isNull(bean.getMonth_7())+"]]></MONTH_7>"); 
					out.println("<MONTH_8><![CDATA["+CommonUtil.isNull(bean.getMonth_8())+"]]></MONTH_8>"); 
					out.println("<MONTH_9><![CDATA["+CommonUtil.isNull(bean.getMonth_9())+"]]></MONTH_9>"); 
					out.println("<MONTH_10><![CDATA["+CommonUtil.isNull(bean.getMonth_10())+"]]></MONTH_10>"); 
					out.println("<MONTH_11><![CDATA["+CommonUtil.isNull(bean.getMonth_11())+"]]></MONTH_11>"); 
					out.println("<MONTH_12><![CDATA["+CommonUtil.isNull(bean.getMonth_12())+"]]></MONTH_12>"); 
					out.println("<SCHEDULE_AND_OR><![CDATA["+CommonUtil.isNull(bean.getSchedule_and_or())+"]]></SCHEDULE_AND_OR>");
					out.println("<WEEK_DAYS><![CDATA["+CommonUtil.isNull(bean.getWeek_days())+"]]></WEEK_DAYS>");
					out.println("<WEEKS_CAL><![CDATA["+CommonUtil.isNull(bean.getWeeks_cal())+"]]></WEEKS_CAL>");
					out.println("<LATE_SUB><![CDATA["+CommonUtil.isNull(bean.getLate_sub())+"]]></LATE_SUB>");
					out.println("<LATE_TIME><![CDATA["+CommonUtil.isNull(bean.getLate_time())+"]]></LATE_TIME>");					
					out.println("<LATE_EXEC><![CDATA["+CommonUtil.isNull(bean.getLate_exec())+"]]></LATE_EXEC>");
					out.println("<ERROR_DESC><![CDATA["+CommonUtil.isNull(bean.getError_description())+"]]></ERROR_DESC>");
					out.println("<USER_CD_2><![CDATA["+CommonUtil.isNull(bean.getUser_cd_2())+"]]></USER_CD_2>");					
					out.println("<USER_CD_3><![CDATA["+CommonUtil.isNull(bean.getUser_cd_3())+"]]></USER_CD_3>");
					out.println("<USER_CD_4><![CDATA["+CommonUtil.isNull(bean.getUser_cd_4())+"]]></USER_CD_4>");
					out.println("<USER_CD_5><![CDATA["+CommonUtil.isNull(bean.getUser_cd_5())+"]]></USER_CD_5>");
					out.println("<USER_CD_6><![CDATA["+CommonUtil.isNull(bean.getUser_cd_6())+"]]></USER_CD_6>"); 
					out.println("<USER_CD_7><![CDATA["+CommonUtil.isNull(bean.getUser_cd_7())+"]]></USER_CD_7>");
					out.println("<USER_CD_8><![CDATA["+CommonUtil.isNull(bean.getUser_cd_8())+"]]></USER_CD_8>");
					out.println("<USER_CD_9><![CDATA["+CommonUtil.isNull(bean.getUser_cd_9())+"]]></USER_CD_9>");
					out.println("<USER_CD_10><![CDATA["+CommonUtil.isNull(bean.getUser_cd_10())+"]]></USER_CD_10>");
					out.println("<BATCHRESULT><![CDATA["+CommonUtil.isNull(bean.getBatch_result())+"]]></BATCHRESULT>");
					out.println("<R_MSG><![CDATA["+CommonUtil.isNull(bean.getR_msg())+"]]></R_MSG>");
					out.println("<SEQ><![CDATA["+CommonUtil.isNull(bean.getSeq())+"]]></SEQ>");
					out.println("<STATE_CD><![CDATA["+CommonUtil.isNull(bean.getState_cd())+"]]></STATE_CD>");
					
					out.println("<REF_TABLE><![CDATA["+CommonUtil.isNull(bean.getRef_table())+"]]></REF_TABLE>");
					out.println("<ACTIVE_FROM><![CDATA["+CommonUtil.isNull(bean.getActive_from())+"]]></ACTIVE_FROM>");
					out.println("<ACTIVE_TILL><![CDATA["+CommonUtil.isNull(bean.getActive_till())+"]]></ACTIVE_TILL>");
					out.println("<CC_YN><![CDATA["+CommonUtil.isNull(bean.getCc_yn())+"]]></CC_YN>");
					out.println("<CC_COUNT><![CDATA["+CommonUtil.isNull(bean.getCc_count())+"]]></CC_COUNT>");
					
					out.println("<MONITOR_TIME><![CDATA["+strMonitor_time+"]]></MONITOR_TIME>");
					out.println("<MONITOR_INTERVAL><![CDATA["+strMonitor_interval+"]]></MONITOR_INTERVAL>");
					out.println("<FILESIZE_COMPARISON><![CDATA["+strFilesize_comparison+"]]></FILESIZE_COMPARISON>");
					out.println("<NUM_OF_ITERATIONS><![CDATA["+strNum_of_iterations+"]]></NUM_OF_ITERATIONS>");
					out.println("<STOP_TIME><![CDATA["+strStop_time+"]]></STOP_TIME>");
					out.println("<SUCCESS_SMS_YN><![CDATA["+CommonUtil.isNull(bean.getSuccess_sms_yn())+"]]></SUCCESS_SMS_YN>");
					out.println("<USER_ID_2><![CDATA["+CommonUtil.isNull(bean.getUser_id_2())+"]]></USER_ID_2>");
					out.println("<USER_ID_3><![CDATA["+CommonUtil.isNull(bean.getUser_id_3())+"]]></USER_ID_3>");
					out.println("<USER_ID_4><![CDATA["+CommonUtil.isNull(bean.getUser_id_4())+"]]></USER_ID_4>");
					out.println("<USER_ID_5><![CDATA["+CommonUtil.isNull(bean.getUser_id_5())+"]]></USER_ID_5>");
					out.println("<USER_ID_6><![CDATA["+CommonUtil.isNull(bean.getUser_id_6())+"]]></USER_ID_6>");
					out.println("<USER_ID_7><![CDATA["+CommonUtil.isNull(bean.getUser_id_7())+"]]></USER_ID_7>");
					out.println("<USER_ID_8><![CDATA["+CommonUtil.isNull(bean.getUser_id_8())+"]]></USER_ID_8>");
					out.println("<USER_ID_9><![CDATA["+CommonUtil.isNull(bean.getUser_id_9())+"]]></USER_ID_9>");
					out.println("<USER_ID_10><![CDATA["+CommonUtil.isNull(bean.getUser_id_10())+"]]></USER_ID_10>");

					out.println("<INTERVAL_SEQUENCE><![CDATA["+CommonUtil.isNull(bean.getInterval_sequence())+"]]></INTERVAL_SEQUENCE>");
					out.println("<SPECIFIC_TIMES><![CDATA["+CommonUtil.isNull(bean.getSpecific_times())+"]]></SPECIFIC_TIMES>");
					out.println("<CYCLIC_TYPE><![CDATA["+CommonUtil.isNull(bean.getCyclic_type())+"]]></CYCLIC_TYPE>");
					out.println("<IND_CYCLIC><![CDATA["+CommonUtil.isNull(bean.getInd_cyclic())+"]]></IND_CYCLIC>");
					out.println("<TOLERANCE><![CDATA["+CommonUtil.isNull(bean.getTolerance())+"]]></TOLERANCE>");
					
					out.println("<SMS_1><![CDATA["+CommonUtil.isNull(bean.getSms_1())+"]]></SMS_1>");
					out.println("<SMS_2><![CDATA["+CommonUtil.isNull(bean.getSms_2())+"]]></SMS_2>");
					out.println("<SMS_3><![CDATA["+CommonUtil.isNull(bean.getSms_3())+"]]></SMS_3>");
					out.println("<SMS_4><![CDATA["+CommonUtil.isNull(bean.getSms_4())+"]]></SMS_4>");
					out.println("<SMS_5><![CDATA["+CommonUtil.isNull(bean.getSms_5())+"]]></SMS_5>");
					out.println("<SMS_6><![CDATA["+CommonUtil.isNull(bean.getSms_6())+"]]></SMS_6>");
					out.println("<SMS_7><![CDATA["+CommonUtil.isNull(bean.getSms_7())+"]]></SMS_7>");
					out.println("<SMS_8><![CDATA["+CommonUtil.isNull(bean.getSms_8())+"]]></SMS_8>");
					out.println("<SMS_9><![CDATA["+CommonUtil.isNull(bean.getSms_9())+"]]></SMS_9>");
					out.println("<SMS_10><![CDATA["+CommonUtil.isNull(bean.getSms_10())+"]]></SMS_10>");
					out.println("<MAIL_1><![CDATA["+CommonUtil.isNull(bean.getMail_1())+"]]></MAIL_1>");
					out.println("<MAIL_2><![CDATA["+CommonUtil.isNull(bean.getMail_2())+"]]></MAIL_2>");
					out.println("<MAIL_3><![CDATA["+CommonUtil.isNull(bean.getMail_3())+"]]></MAIL_3>");
					out.println("<MAIL_4><![CDATA["+CommonUtil.isNull(bean.getMail_4())+"]]></MAIL_4>");
					out.println("<MAIL_5><![CDATA["+CommonUtil.isNull(bean.getMail_5())+"]]></MAIL_5>");
					out.println("<MAIL_6><![CDATA["+CommonUtil.isNull(bean.getMail_6())+"]]></MAIL_6>");
					out.println("<MAIL_7><![CDATA["+CommonUtil.isNull(bean.getMail_7())+"]]></MAIL_7>");
					out.println("<MAIL_8><![CDATA["+CommonUtil.isNull(bean.getMail_8())+"]]></MAIL_8>");
					out.println("<MAIL_9><![CDATA["+CommonUtil.isNull(bean.getMail_9())+"]]></MAIL_9>");
					out.println("<MAIL_10><![CDATA["+CommonUtil.isNull(bean.getMail_10())+"]]></MAIL_10>");

					out.println("<GRP_NM_1><![CDATA["+CommonUtil.isNull(bean.getGrp_nm_1())+"]]></GRP_NM_1>");
					out.println("<GRP_CD_1><![CDATA["+CommonUtil.isNull(bean.getGrp_cd_1())+"]]></GRP_CD_1>");
					out.println("<GRP_SMS_1><![CDATA["+CommonUtil.isNull(bean.getGrp_sms_1())+"]]></GRP_SMS_1>");
					out.println("<GRP_MAIL_1><![CDATA["+CommonUtil.isNull(bean.getGrp_mail_1())+"]]></GRP_MAIL_1>");

					out.println("<GRP_NM_2><![CDATA["+CommonUtil.isNull(bean.getGrp_nm_2())+"]]></GRP_NM_2>");
					out.println("<GRP_CD_2><![CDATA["+CommonUtil.isNull(bean.getGrp_cd_2())+"]]></GRP_CD_2>");
					out.println("<GRP_SMS_2><![CDATA["+CommonUtil.isNull(bean.getGrp_sms_2())+"]]></GRP_SMS_2>");
					out.println("<GRP_MAIL_2><![CDATA["+CommonUtil.isNull(bean.getGrp_mail_2())+"]]></GRP_MAIL_2>");
					
					out.println("<CONF_CAL><![CDATA["+CommonUtil.isNull(bean.getConf_cal())+"]]></CONF_CAL>");
					out.println("<SHIFT><![CDATA["+CommonUtil.isNull(bean.getShift())+"]]></SHIFT>");
					out.println("<SHIFT_NUM><![CDATA["+CommonUtil.isNull(bean.getShift_num())+"]]></SHIFT_NUM>");

					out.println("</item>");
				}
				out.println("</items>");
			}

		}else if(itemGb.equals("ctmLogList")){
			
			List<CommonBean> itemList = (List)request.getAttribute("itemList");
			if( !(null!=itemList && 0<itemList.size()) ){
				out.println("<items cnt='0' msg='"+CommonUtil.getMessage("DEBUG.06")+"' ></items>");
			}else{
				out.println("<items cnt='"+itemList.size()+"' >");
				
				for( int i=0; i<itemList.size(); i++ ){
					CommonBean bean = itemList.get(i);
					
					long orderno = Long.parseLong(CommonUtil.isNull(bean.getOrderno()));
					String v_orderno = "0"+CommonUtil.isNull(Long.toString(orderno, 36), "0");		//10진수를 36진수로 변환한다.
					
					out.println("<item>");					
					
					out.println("<LOGDATE><![CDATA["+CommonUtil.isNull(bean.getLogdate())+"]]></LOGDATE>");
					out.println("<LOGTIME><![CDATA["+CommonUtil.isNull(bean.getLogtime())+"]]></LOGTIME>");
					out.println("<JOBNAME><![CDATA["+CommonUtil.isNull(bean.getJobname())+"]]></JOBNAME>");
					out.println("<ORDERNO><![CDATA["+v_orderno+"]]></ORDERNO>");
					out.println("<SUBSYS><![CDATA["+CommonUtil.isNull(bean.getSubsys())+"]]></SUBSYS>");
					out.println("<MSGID><![CDATA["+CommonUtil.isNull(bean.getMsgid())+"]]></MSGID>");
					out.println("<MESSAGE><![CDATA["+CommonUtil.isNull(bean.getMessage())+"]]></MESSAGE>");
																																						
					out.println("</item>");
				}
				out.println("</items>");
				
			}
		}else if(itemGb.equals("susiExcelLoad")){
			
			List<String[]> itemList = (List)request.getAttribute("itemList");
			if( !(null!=itemList && 0<itemList.size()) ){
				out.println("<items cnt='0' msg='"+CommonUtil.getMessage("DEBUG.06")+"' ></items>");
			}else{
				out.println("<items cnt='"+itemList.size()+"' >");
				
				for( int i=0; i<itemList.size(); i++ ){
					
					if(i == 0) continue;
					
					String[] arr_excel = (String[])itemList.get(i);
									
					out.println("<item>");
					
					out.println("<NODE_ID><![CDATA["+CommonUtil.isNull(arr_excel[0])+"]]></NODE_ID>");
					out.println("<OWNER><![CDATA["+CommonUtil.isNull(arr_excel[1])+"]]></OWNER>");
					out.println("<DESCRIPTION><![CDATA["+CommonUtil.isNull(arr_excel[3])+"]]></DESCRIPTION>");					
					out.println("<JOB_NAME><![CDATA["+CommonUtil.isNull(arr_excel[2])+"]]></JOB_NAME>");
					out.println("<MEM_LIB><![CDATA["+CommonUtil.isNull(arr_excel[5])+"]]></MEM_LIB>");					
					out.println("<MEM_NAME><![CDATA["+CommonUtil.isNull(arr_excel[4])+"]]></MEM_NAME>");
					out.println("<COMMAND><![CDATA["+CommonUtil.isNull(arr_excel[6])+"]]></COMMAND>");
					out.println("<BATCHJOBGRADE><![CDATA["+CommonUtil.isNull(arr_excel[7])+"]]></BATCHJOBGRADE>");
					out.println("<TIME_FROM><![CDATA["+CommonUtil.isNull(arr_excel[8])+"]]></TIME_FROM>");
					out.println("<T_CONDITIONS_IN><![CDATA["+CommonUtil.isNull(arr_excel[9])+"]]></T_CONDITIONS_IN>");
					out.println("<USER_IMPECT_YN><![CDATA["+CommonUtil.isNull(arr_excel[10])+"]]></USER_IMPECT_YN>");
					out.println("<T_CONDITIONS_OUT><![CDATA["+CommonUtil.isNull(arr_excel[11])+"]]></T_CONDITIONS_OUT>");
					//out.println("<ARGUMENT><![CDATA["+CommonUtil.isNull(arr_excel[6])+"]]></ARGUMENT>");
					
																																																												
					out.println("</item>");
				}
				out.println("</items>");
				
			}
			
		}else if(itemGb.equals("doc02List")){
			
			List<Doc02Bean> itemList = (List)request.getAttribute("itemList");
			if( !(null!=itemList && 0<itemList.size()) ){
				out.println("<items cnt='0' msg='"+CommonUtil.getMessage("DEBUG.06")+"' ></items>");
			}else{
				out.println("<items cnt='"+itemList.size()+"' >");
				
				for( int i=0; i<itemList.size(); i++ ){
					Doc02Bean bean = itemList.get(i);
					
					out.println("<item>");
					
					out.println("<JOB_NAME><![CDATA["+CommonUtil.isNull(bean.getJob_name())+"]]></JOB_NAME>");
					out.println("<DESC><![CDATA["+CommonUtil.isNull(bean.getDescription())+"]]></DESC>");
					out.println("<MEM_NAME><![CDATA["+CommonUtil.isNull(bean.getMem_name())+"]]></MEM_NAME>");
					out.println("<MEM_LIB><![CDATA["+CommonUtil.isNull(bean.getMem_lib())+"]]></MEM_LIB>");
					out.println("<AUTHOR><![CDATA["+CommonUtil.isNull(bean.getAuthor())+"]]></AUTHOR>");
					out.println("<OWNER><![CDATA["+CommonUtil.isNull(bean.getOwner())+"]]></OWNER>");
					out.println("<NODE_ID><![CDATA["+CommonUtil.isNull(bean.getNode_id())+"]]></NODE_ID>");
					out.println("<PRIORITY><![CDATA["+CommonUtil.isNull(bean.getPriority())+"]]></PRIORITY>");
					out.println("<CRITICAL><![CDATA["+CommonUtil.isNull(bean.getCritical())+"]]></CRITICAL>");
					out.println("<COMMAND><![CDATA["+CommonUtil.isNull(bean.getCommand()).replaceAll("&apos;","\'").replace("&amp;quot;","\"").replace("&quot;","\"").replace("&lt;","<").replace("&gt;",">")+"]]></COMMAND>");
					out.println("<CONFIRM_FLAG><![CDATA["+CommonUtil.isNull(bean.getConfirm_flag())+"]]></CONFIRM_FLAG>");
					out.println("<TIME_FROM><![CDATA["+CommonUtil.isNull(bean.getTime_from())+"]]></TIME_FROM>");
					out.println("<TIME_UNTIL><![CDATA["+CommonUtil.isNull(bean.getTime_until())+"]]></TIME_UNTIL>");
					out.println("<T_CONDITIONS_IN><![CDATA["+CommonUtil.isNull(bean.getT_conditions_in())+"]]></T_CONDITIONS_IN>");
					out.println("<T_CONDITIONS_OUT><![CDATA["+CommonUtil.isNull(bean.getT_conditions_out())+"]]></T_CONDITIONS_OUT>");
					out.println("<T_RESOURCES_C><![CDATA["+CommonUtil.isNull(bean.getT_resources_c())+"]]></T_RESOURCES_C>");					
					out.println("<T_SET><![CDATA["+CommonUtil.isNull(bean.getT_set())+"]]></T_SET>");
					out.println("<T_STEPS><![CDATA["+CommonUtil.isNull(bean.getT_steps())+"]]></T_STEPS>");
					out.println("<T_POSTPROC><![CDATA["+CommonUtil.isNull(bean.getT_postproc())+"]]></T_POSTPROC>");
					out.println("<LATE_SUB><![CDATA["+CommonUtil.isNull(bean.getLate_sub())+"]]></LATE_SUB>");
					out.println("<LATE_TIME><![CDATA["+CommonUtil.isNull(bean.getLate_time())+"]]></LATE_TIME>");					
					out.println("<LATE_EXEC><![CDATA["+CommonUtil.isNull(bean.getLate_exec())+"]]></LATE_EXEC>");					
					out.println("<BATCHJOBGRADE><![CDATA["+CommonUtil.isNull(bean.getBatchjobGrade())+"]]></BATCHJOBGRADE>");
					out.println("<ERROR_DESC><![CDATA["+CommonUtil.isNull(bean.getError_description())+"]]></ERROR_DESC>");
					out.println("<USER_CD_2><![CDATA["+CommonUtil.isNull(bean.getUser_cd_2())+"]]></USER_CD_2>");					
					out.println("<USER_CD_3><![CDATA["+CommonUtil.isNull(bean.getUser_cd_3())+"]]></USER_CD_3>");
					out.println("<USER_CD_4><![CDATA["+CommonUtil.isNull(bean.getUser_cd_4())+"]]></USER_CD_4>");
					out.println("<USER_NM_1_0><![CDATA["+CommonUtil.isNull(bean.getUser_nm())+"]]></USER_NM_1_0>");
					out.println("<USER_NM_2_0><![CDATA["+CommonUtil.isNull(bean.getUser_nm2())+"]]></USER_NM_2_0>");					
					out.println("<USER_NM_3_0><![CDATA["+CommonUtil.isNull(bean.getUser_nm3())+"]]></USER_NM_3_0>");
					out.println("<USER_NM_4_0><![CDATA["+CommonUtil.isNull(bean.getUser_nm4())+"]]></USER_NM_4_0>");
					out.println("<SUSITYPE><![CDATA["+CommonUtil.isNull(bean.getUser_nm4())+"]]></SUSITYPE>");
					out.println("<ARGUMENT><![CDATA["+CommonUtil.isNull(bean.getArgument())+"]]></ARGUMENT>");
					out.println("<STATUS><![CDATA["+CommonUtil.isNull(bean.getStatus())+"]]></STATUS>");
					out.println("<AJOB_STATUS><![CDATA["+CommonUtil.isNull(bean.getAjob_status())+"]]></AJOB_STATUS>");
					out.println("<APPLY_NM><![CDATA["+CommonUtil.getMessage("APPLY.STATE."+CommonUtil.isNull(bean.getApply_cd()))+"]]></APPLY_NM>");
					out.println("<FAIL_COMMENT><![CDATA["+CommonUtil.isNull(bean.getFail_comment())+"]]></FAIL_COMMENT>");
										
					out.println("</item>");
				}
				
				out.println("</items>");
			}
		}else if(itemGb.equals("susiBeforeList")){
			
			List<Doc02Bean> itemList = (List)request.getAttribute("itemList");
			if( !(null!=itemList && 0<itemList.size()) ){
				out.println("<items cnt='0' msg='"+CommonUtil.getMessage("DEBUG.06")+"' ></items>");
			}else{
				out.println("<items cnt='"+itemList.size()+"' >");
				
				for( int i=0; i<itemList.size(); i++ ){
					Doc02Bean bean = itemList.get(i);
					
					out.println("<item>");
					
					out.println("<JOB_NAME><![CDATA["+CommonUtil.isNull(bean.getJob_name())+"]]></JOB_NAME>");
					out.println("<DESC><![CDATA["+CommonUtil.isNull(bean.getDescription())+"]]></DESC>");
					out.println("<MEM_NAME><![CDATA["+CommonUtil.isNull(bean.getMem_name())+"]]></MEM_NAME>");
					out.println("<MEM_LIB><![CDATA["+CommonUtil.isNull(bean.getMem_lib())+"]]></MEM_LIB>");
					out.println("<AUTHOR><![CDATA["+CommonUtil.isNull(bean.getAuthor())+"]]></AUTHOR>");
					out.println("<OWNER><![CDATA["+CommonUtil.isNull(bean.getOwner())+"]]></OWNER>");
					out.println("<NODE_ID><![CDATA["+CommonUtil.isNull(bean.getNode_id())+"]]></NODE_ID>");
					out.println("<PRIORITY><![CDATA["+CommonUtil.isNull(bean.getPriority())+"]]></PRIORITY>");
					out.println("<CRITICAL><![CDATA["+CommonUtil.isNull(bean.getCritical())+"]]></CRITICAL>");
					out.println("<COMMAND><![CDATA["+CommonUtil.isNull(bean.getCommand())+"]]></COMMAND>");
					out.println("<CONFIRM_FLAG><![CDATA["+CommonUtil.isNull(bean.getConfirm_flag())+"]]></CONFIRM_FLAG>");
					out.println("<TIME_FROM><![CDATA["+CommonUtil.isNull(bean.getTime_from())+"]]></TIME_FROM>");
					out.println("<TIME_UNTIL><![CDATA["+CommonUtil.isNull(bean.getTime_until())+"]]></TIME_UNTIL>");
					out.println("<T_CONDITIONS_IN><![CDATA["+CommonUtil.isNull(bean.getT_conditions_in())+"]]></T_CONDITIONS_IN>");
					out.println("<T_CONDITIONS_OUT><![CDATA["+CommonUtil.isNull(bean.getT_conditions_out())+"]]></T_CONDITIONS_OUT>");
					out.println("<T_RESOURCES_C><![CDATA["+CommonUtil.isNull(bean.getT_resources_c())+"]]></T_RESOURCES_C>");					
					out.println("<T_SET><![CDATA["+CommonUtil.isNull(bean.getT_set())+"]]></T_SET>");
					out.println("<T_STEPS><![CDATA["+CommonUtil.isNull(bean.getT_steps())+"]]></T_STEPS>");
					out.println("<T_POSTPROC><![CDATA["+CommonUtil.isNull(bean.getT_postproc())+"]]></T_POSTPROC>");
					out.println("<LATE_SUB><![CDATA["+CommonUtil.isNull(bean.getLate_sub())+"]]></LATE_SUB>");
					out.println("<LATE_TIME><![CDATA["+CommonUtil.isNull(bean.getLate_time())+"]]></LATE_TIME>");					
					out.println("<LATE_EXEC><![CDATA["+CommonUtil.isNull(bean.getLate_exec())+"]]></LATE_EXEC>");					
					out.println("<BATCHJOBGRADE><![CDATA["+CommonUtil.isNull(bean.getBatchjobGrade())+"]]></BATCHJOBGRADE>");
					out.println("<ERROR_DESC><![CDATA["+CommonUtil.isNull(bean.getError_description())+"]]></ERROR_DESC>");
					out.println("<USER_CD_2><![CDATA["+CommonUtil.isNull(bean.getUser_cd_2())+"]]></USER_CD_2>");					
					out.println("<USER_CD_3><![CDATA["+CommonUtil.isNull(bean.getUser_cd_3())+"]]></USER_CD_3>");
					out.println("<USER_CD_4><![CDATA["+CommonUtil.isNull(bean.getUser_cd_4())+"]]></USER_CD_4>");
					out.println("<USER_NM_1_0><![CDATA["+CommonUtil.isNull(bean.getUser_nm())+"]]></USER_NM_1_0>");
					out.println("<USER_NM_2_0><![CDATA["+CommonUtil.isNull(bean.getUser_nm2())+"]]></USER_NM_2_0>");					
					out.println("<USER_NM_3_0><![CDATA["+CommonUtil.isNull(bean.getUser_nm3())+"]]></USER_NM_3_0>");
					out.println("<USER_NM_4_0><![CDATA["+CommonUtil.isNull(bean.getUser_nm4())+"]]></USER_NM_4_0>");					
										
					out.println("</item>");
				}
				
				out.println("</items>");
			}
		}else if(itemGb.equals("userApprovalGroup")){
			List<CommonBean> itemList = (List)request.getAttribute("itemList");
			if( !(null!=itemList && 0<itemList.size()) ){
				out.println("<items cnt='0' msg='"+CommonUtil.getMessage("DEBUG.06")+"' ></items>");
			}else{
				out.println("<items cnt='"+itemList.size()+"' >");
				
				for( int i=0; i<itemList.size(); i++ ){
					CommonBean bean = itemList.get(i);
					
					out.println("<item>");
					
					out.println("<LINE_GRP_CD><![CDATA["+CommonUtil.isNull(bean.getLine_grp_cd())+"]]></LINE_GRP_CD>");
					out.println("<LINE_GRP_NM><![CDATA["+CommonUtil.isNull(bean.getLine_grp_nm())+"]]></LINE_GRP_NM>");
					out.println("<OWNER_USER_CD><![CDATA["+CommonUtil.isNull(bean.getOwner_user_cd())+"]]></OWNER_USER_CD>");
					out.println("<USE_YN><![CDATA["+CommonUtil.isNull(bean.getUse_yn())+"]]></USE_YN>");
										
					out.println("</item>");
				}
				
				out.println("</items>");
			}
			
		}else if(itemGb.equals("workGroupList")){
			List<CommonBean> itemList = (List)request.getAttribute("itemList");
			if( !(null!=itemList && 0<itemList.size()) ){
				out.println("<items cnt='0' msg='"+CommonUtil.getMessage("DEBUG.06")+"' ></items>");
			}else{
				out.println("<items cnt='"+itemList.size()+"' >");
				
				for( int i=0; i<itemList.size(); i++ ){
					CommonBean bean = itemList.get(i);
					
					out.println("<item>");
					
					out.println("<INS_USER_CD><![CDATA["+CommonUtil.isNull(bean.getIns_user_cd())+"]]></INS_USER_CD>");
					out.println("<INS_DATE><![CDATA["+CommonUtil.isNull(bean.getIns_date())+"]]></INS_DATE>");
					out.println("<CONTENT><![CDATA["+CommonUtil.isNull(bean.getContent())+"]]></CONTENT>");
										
					out.println("</item>");
				}
				
				out.println("</items>");
			}
			
		}else if(itemGb.equals("adminApprovalGroup")){
			List<CommonBean> itemList = (List)request.getAttribute("itemList");
			if( !(null!=itemList && 0<itemList.size()) ){
				out.println("<items cnt='0' msg='"+CommonUtil.getMessage("DEBUG.06")+"' ></items>");
			}else{
				out.println("<items cnt='"+itemList.size()+"' >");
				
				for( int i=0; i<itemList.size(); i++ ){
					CommonBean bean = itemList.get(i);
					
					out.println("<item>");
					
					out.println("<ADMIN_LINE_GRP_CD><![CDATA["+CommonUtil.isNull(bean.getAdmin_line_grp_cd())+"]]></ADMIN_LINE_GRP_CD>");
					out.println("<ADMIN_LINE_GRP_NM><![CDATA["+CommonUtil.isNull(bean.getAdmin_line_grp_nm())+"]]></ADMIN_LINE_GRP_NM>");
// 					out.println("<USE_YN><![CDATA["+CommonUtil.isNull(bean.getUse_yn())+"]]></USE_YN>");
					out.println("<DOC_GUBUN><![CDATA["+CommonUtil.isNull(bean.getDoc_gubun())+"]]></DOC_GUBUN>");
					out.println("<TOP_LEVEL_YN><![CDATA["+CommonUtil.isNull(bean.getTop_level_yn())+"]]></TOP_LEVEL_YN>");
					out.println("<SCHEDULE_YN><![CDATA["+CommonUtil.isNull(bean.getSchedule_yn())+"]]></SCHEDULE_YN>");
					out.println("<POST_APPROVAL_YN><![CDATA["+CommonUtil.isNull(bean.getPost_approval_yn())+"]]></POST_APPROVAL_YN>");

					out.println("</item>");
				}
				
				out.println("</items>");
			}
			
		}else if(itemGb.equals("groupApprovalGroup")){
			List<CommonBean> itemList = (List)request.getAttribute("itemList");
			if( !(null!=itemList && 0<itemList.size()) ){
				out.println("<items cnt='0' msg='"+CommonUtil.getMessage("DEBUG.06")+"' ></items>");
			}else{
				out.println("<items cnt='"+itemList.size()+"' >");
				
				for( int i=0; i<itemList.size(); i++ ){
					CommonBean bean = itemList.get(i);
					
					out.println("<item>");
					 
					out.println("<GROUP_LINE_GRP_CD><![CDATA["+CommonUtil.isNull(bean.getGroup_line_grp_cd())+"]]></GROUP_LINE_GRP_CD>");
					out.println("<GROUP_LINE_GRP_NM><![CDATA["+CommonUtil.isNull(bean.getGroup_line_grp_nm())+"]]></GROUP_LINE_GRP_NM>");
					out.println("<USE_YN><![CDATA["+CommonUtil.isNull(bean.getUse_yn())+"]]></USE_YN>");
										
					out.println("</item>");
				}
				
				out.println("</items>");
			}
			
		}else if(itemGb.equals("userApprovalLine")){
			List<CommonBean> itemList = (List)request.getAttribute("itemList");
			if( !(null!=itemList && 0<itemList.size()) ){
				out.println("<items cnt='0' msg='"+CommonUtil.getMessage("DEBUG.06")+"' ></items>");
			}else{
				out.println("<items cnt='"+itemList.size()+"' >");
				
				for( int i=0; i<itemList.size(); i++ ){
					CommonBean bean = itemList.get(i);
					
					out.println("<item>");
					
					out.println("<LINE_CD><![CDATA["+CommonUtil.isNull(bean.getLine_cd())+"]]></LINE_CD>");
					out.println("<LINE_GRP_CD><![CDATA["+CommonUtil.isNull(bean.getLine_grp_cd())+"]]></LINE_GRP_CD>");
					out.println("<APPROVAL_CD><![CDATA["+CommonUtil.isNull(bean.getApproval_cd())+"]]></APPROVAL_CD>");
					out.println("<APPROVAL_NM><![CDATA["+CommonUtil.isNull(bean.getApproval_nm())+"]]></APPROVAL_NM>");
					out.println("<APPROVAL_SEQ><![CDATA["+CommonUtil.isNull(bean.getApproval_seq())+"]]></APPROVAL_SEQ>");
					out.println("<APPROVAL_GB><![CDATA["+CommonUtil.isNull(bean.getApproval_gb())+"]]></APPROVAL_GB>");
					out.println("<DUTY_NM><![CDATA["+CommonUtil.isNull(bean.getDuty_nm())+"]]></DUTY_NM>");
					out.println("<DEPT_NM><![CDATA["+CommonUtil.isNull(bean.getDept_nm())+"]]></DEPT_NM>");
					out.println("<USER_ID><![CDATA["+CommonUtil.isNull(bean.getUser_id())+"]]></USER_ID>");	
					out.println("<USER_CD><![CDATA["+CommonUtil.isNull(bean.getUser_cd())+"]]></USER_CD>");

					out.println("</item>");
				}
				
				out.println("</items>");
			}
		}else if(itemGb.contains("adminApprovalLine")){ //결재선 조회화면에서도 사용 가능하도록 수정 (2020.05.11, 김수정)
			List<CommonBean> itemList = (List)request.getAttribute("itemList");
			if( !(null!=itemList && 0<itemList.size()) ){
				out.println("<items cnt='0' msg='"+CommonUtil.getMessage("DEBUG.06")+"' ></items>");
			}else{
				out.println("<items cnt='"+itemList.size()+"' >");
				
				for( int i=0; i<itemList.size(); i++ ){
					CommonBean bean = itemList.get(i);
					
					out.println("<item>");
					
					out.println("<ADMIN_LINE_CD><![CDATA["+CommonUtil.isNull(bean.getAdmin_line_cd())+"]]></ADMIN_LINE_CD>");
					out.println("<ADMIN_LINE_GRP_CD><![CDATA["+CommonUtil.isNull(bean.getAdmin_line_grp_cd())+"]]></ADMIN_LINE_GRP_CD>");
					out.println("<ADMIN_LINE_GRP_ID><![CDATA["+CommonUtil.isNull(bean.getApproval_user_id())+"]]></ADMIN_LINE_GRP_ID>");
					out.println("<APPROVAL_CD><![CDATA["+CommonUtil.isNull(bean.getApproval_cd())+"]]></APPROVAL_CD>");
					out.println("<APPROVAL_NM><![CDATA["+CommonUtil.isNull(bean.getApproval_nm())+"]]></APPROVAL_NM>");
					out.println("<APPROVAL_SEQ><![CDATA["+CommonUtil.isNull(bean.getApproval_seq())+"]]></APPROVAL_SEQ>");
					out.println("<APPROVAL_GB><![CDATA["+CommonUtil.isNull(bean.getApproval_gb())+"]]></APPROVAL_GB>");
					out.println("<APPROVAL_TYPE><![CDATA["+CommonUtil.isNull(bean.getApproval_type())+"]]></APPROVAL_TYPE>");
					out.println("<DUTY_NM><![CDATA["+CommonUtil.isNull(bean.getDuty_nm())+"]]></DUTY_NM>");
					out.println("<DEPT_NM><![CDATA["+CommonUtil.isNull(bean.getDept_nm())+"]]></DEPT_NM>");
					out.println("<GROUP_LINE_GRP_CD><![CDATA["+CommonUtil.isNull(bean.getGroup_line_grp_cd())+"]]></GROUP_LINE_GRP_CD>");
					out.println("<GROUP_LINE_GRP_NM><![CDATA["+CommonUtil.isNull(bean.getGroup_line_grp_nm())+"]]></GROUP_LINE_GRP_NM>");
					out.println("<USER_ID><![CDATA["+CommonUtil.isNull(bean.getUser_id())+"]]></USER_ID>");
										
					out.println("</item>");
				}
				
				out.println("</items>");
			}
			
		}else if(itemGb.equals("groupApprovalLine")){
			List<CommonBean> itemList = (List)request.getAttribute("itemList");
			if( !(null!=itemList && 0<itemList.size()) ){
				out.println("<items cnt='0' msg='"+CommonUtil.getMessage("DEBUG.06")+"' ></items>");
			}else{
				out.println("<items cnt='"+itemList.size()+"' >");
				
				for( int i=0; i<itemList.size(); i++ ){
					CommonBean bean = itemList.get(i);
					
					out.println("<item>");
					
					out.println("<GROUP_LINE_CD><![CDATA["+CommonUtil.isNull(bean.getGroup_line_cd())+"]]></GROUP_LINE_CD>");
					out.println("<GROUP_LINE_GRP_CD><![CDATA["+CommonUtil.isNull(bean.getGroup_line_grp_cd())+"]]></GROUP_LINE_GRP_CD>");
					out.println("<APPROVAL_CD><![CDATA["+CommonUtil.isNull(bean.getApproval_cd())+"]]></APPROVAL_CD>");
					out.println("<APPROVAL_NM><![CDATA["+CommonUtil.isNull(bean.getApproval_nm())+"]]></APPROVAL_NM>");
					out.println("<APPROVAL_SEQ><![CDATA["+CommonUtil.isNull(bean.getApproval_seq())+"]]></APPROVAL_SEQ>");					
					out.println("<DUTY_NM><![CDATA["+CommonUtil.isNull(bean.getDuty_nm())+"]]></DUTY_NM>");
					out.println("<DEPT_NM><![CDATA["+CommonUtil.isNull(bean.getDept_nm())+"]]></DEPT_NM>");	
					out.println("<USER_CD><![CDATA["+CommonUtil.isNull(bean.getUser_cd())+"]]></USER_CD>");
					out.println("<USER_ID><![CDATA["+CommonUtil.isNull(bean.getUser_id())+"]]></USER_ID>");
										
					out.println("</item>");
				}
				
				out.println("</items>");
			}
		}else if(itemGb.equals("ctmAgentList")){
			List<CommonBean> itemList = (List)request.getAttribute("itemList");
			if( !(null!=itemList && 0<itemList.size()) ){
				out.println("<items cnt='0' msg='"+CommonUtil.getMessage("DEBUG.06")+"' ></items>");
			}else{
				out.println("<items cnt='"+itemList.size()+"' >");
				
				for( int i=0; i<itemList.size(); i++ ){
					CommonBean bean = itemList.get(i);
					
					out.println("<item>");
					
					out.println("<NODEID><![CDATA["+CommonUtil.isNull(bean.getNodeid())+"]]></NODEID>");
					out.println("<AGSTAT><![CDATA["+CommonUtil.isNull(bean.getAgstat())+"]]></AGSTAT>");
					out.println("<HOSTNAME><![CDATA["+CommonUtil.isNull(bean.getHostname())+"]]></HOSTNAME>");
					out.println("<VERSION><![CDATA["+CommonUtil.isNull(bean.getVersion())+"]]></VERSION>");
					out.println("<OS_NAME><![CDATA["+CommonUtil.isNull(bean.getOs_name())+"]]></OS_NAME>");
					out.println("<PLATFORM><![CDATA["+CommonUtil.isNull(bean.getPlatform())+"]]></PLATFORM>");
					out.println("<LAST_UPD><![CDATA["+CommonUtil.isNull(bean.getLast_upd())+"]]></LAST_UPD>");
					out.println("<AGENT_NM><![CDATA["+CommonUtil.isNull(bean.getAgent_nm())+"]]></AGENT_NM>");	
					out.println("<AGENT_INFO><![CDATA["+CommonUtil.isNull(bean.getAgent_info())+"]]></AGENT_INFO>");	
										
					out.println("</item>");
				}
				
				out.println("</items>");
			}
		}else if(itemGb.equals("mHostList")){
			List<CommonBean> itemList = (List)request.getAttribute("itemList");
			if( !(null!=itemList && 0<itemList.size()) ){
				out.println("<items cnt='0' msg='"+CommonUtil.getMessage("DEBUG.06")+"' ></items>");
			}else{
				out.println("<items cnt='"+itemList.size()+"' >");
				
				for( int i=0; i<itemList.size(); i++ ){
					CommonBean bean = itemList.get(i);
															
					out.println("<item>");
					
					out.println("<HOST_CD><![CDATA["+CommonUtil.isNull(bean.getHost_cd())+"]]></HOST_CD>");
					out.println("<NODE_ID><![CDATA["+CommonUtil.isNull(bean.getNode_id())+"]]></NODE_ID>");
					out.println("<NODE_NM><![CDATA["+CommonUtil.isNull(bean.getNode_nm())+"]]></NODE_NM>");
																																	
					out.println("</item>");
				}
				out.println("</items>");
				
			}
		}else if(itemGb.equals("doc02List2")){
			List<Doc02Bean> itemList = (List)request.getAttribute("itemList");
			if( !(null!=itemList && 0<itemList.size()) ){
				out.println("<items cnt='0' msg='"+CommonUtil.getMessage("DEBUG.06")+"' ></items>");
			}else{
				out.println("<items cnt='"+itemList.size()+"' >");
				
				for( int i=0; i<itemList.size(); i++ ){
					Doc02Bean bean = itemList.get(i);
					
					out.println("<item>");
					
					out.println("<DOC_CD><![CDATA["+CommonUtil.isNull(bean.getDoc_cd())+"]]></DOC_CD>");
					out.println("<DATA_CENTER><![CDATA["+CommonUtil.isNull(bean.getData_center())+"]]></DATA_CENTER>");
					out.println("<TITLE><![CDATA["+CommonUtil.isNull(bean.getTitle())+"]]></TITLE>");
					out.println("<JOB_CNT><![CDATA["+CommonUtil.isNull(bean.getJob_cnt())+"]]></JOB_CNT>");
					out.println("<DEPT_NM><![CDATA["+CommonUtil.isNull(bean.getDept_nm())+"]]></DEPT_NM>");
					out.println("<DUTY_NM><![CDATA["+CommonUtil.isNull(bean.getDuty_nm())+"]]></DUTY_NM>");
					out.println("<USER_NM><![CDATA["+CommonUtil.isNull(bean.getUser_nm())+"]]></USER_NM>");
					out.println("<DOC_GB><![CDATA["+CommonUtil.isNull(bean.getDoc_gb())+"]]></DOC_GB>");
					out.println("<STATE_NM><![CDATA["+CommonUtil.isNull(bean.getState_nm())+"]]></STATE_NM>");
					out.println("<DRAFT_DATE><![CDATA["+CommonUtil.isNull(bean.getDraft_date())+"]]></DRAFT_DATE>");
					out.println("<APPROVAL_DATE><![CDATA["+CommonUtil.isNull(bean.getApproval_date())+"]]></APPROVAL_DATE>");
					out.println("<DATA_CENTER_NAME><![CDATA["+CommonUtil.isNull(bean.getData_center_name())+"]]></DATA_CENTER_NAME>");
															
					out.println("</item>");
				}				
				out.println("</items>");
			}
		}else if(itemGb.equals("doc02JobList2")){
			List<Doc02Bean> itemList = (List)request.getAttribute("itemList");
			if( !(null!=itemList && 0<itemList.size()) ){
				out.println("<items cnt='0' msg='"+CommonUtil.getMessage("DEBUG.06")+"' ></items>");
			}else{
				out.println("<items cnt='"+itemList.size()+"' >");
				
				for( int i=0; i<itemList.size(); i++ ){
					Doc02Bean bean = itemList.get(i);
					
					out.println("<item>");
					
					out.println("<DOC_CD><![CDATA["+CommonUtil.isNull(bean.getDoc_cd())+"]]></DOC_CD>");
					out.println("<NODE_ID><![CDATA["+CommonUtil.isNull(bean.getNode_id())+"]]></NODE_ID>");
					out.println("<OWNER><![CDATA["+CommonUtil.isNull(bean.getOwner())+"]]></OWNER>");
					out.println("<JOB_NAME><![CDATA["+CommonUtil.isNull(bean.getJob_name())+"]]></JOB_NAME>");
					out.println("<DESCRIPTION><![CDATA["+CommonUtil.isNull(bean.getDescription())+"]]></DESCRIPTION>");
					out.println("<MEM_LIB><![CDATA["+CommonUtil.isNull(bean.getMem_lib())+"]]></MEM_LIB>");
					out.println("<MEM_NAME><![CDATA["+CommonUtil.isNull(bean.getMem_name())+"]]></MEM_NAME>");
					out.println("<ARGUMENT><![CDATA["+CommonUtil.isNull(bean.getArgument())+"]]></ARGUMENT>");
					out.println("<COMMAND><![CDATA["+CommonUtil.isNull(bean.getCommand())+"]]></COMMAND>");
					out.println("<ACT_GB><![CDATA["+CommonUtil.isNull(bean.getAct_gb())+"]]></ACT_GB>");
					out.println("<TIME_FROM><![CDATA["+CommonUtil.isNull(bean.getTime_from())+"]]></TIME_FROM>");
					out.println("<T_CONDITIONS_IN><![CDATA["+CommonUtil.isNull(bean.getT_conditions_in())+"]]></T_CONDITIONS_IN>");
					out.println("<T_CONDITIONS_OUT><![CDATA["+CommonUtil.isNull(bean.getT_conditions_out())+"]]></T_CONDITIONS_OUT>");
					out.println("<BATCHJOBGRADE><![CDATA["+CommonUtil.isNull(bean.getBatchjobGrade())+"]]></BATCHJOBGRADE>");
															
					out.println("</item>");
				}
				
				out.println("</items>");
			}
		}else if(itemGb.equals("argumentList")){
			List<CommonBean> itemList = (List)request.getAttribute("itemList");
			if( !(null!=itemList && 0<itemList.size()) ){
				out.println("<items cnt='0' msg='"+CommonUtil.getMessage("DEBUG.06")+"' ></items>");
			}else{
				out.println("<items cnt='"+itemList.size()+"' >");
				
				for( int i=0; i<itemList.size(); i++ ){
					CommonBean bean = itemList.get(i);
										
					out.println("<item>");
					
					out.println("<SCODE_CD><![CDATA["+CommonUtil.isNull(bean.getScode_cd())+"]]></SCODE_CD>");
					out.println("<SCODE_NM><![CDATA["+CommonUtil.isNull(bean.getScode_nm())+"]]></SCODE_NM>");
					out.println("<SCODE_ENG_NM><![CDATA["+CommonUtil.isNull(bean.getScode_eng_nm())+"]]></SCODE_ENG_NM>");
					out.println("<SCODE_DESC><![CDATA["+CommonUtil.isNull(bean.getScode_desc())+"]]></SCODE_DESC>");				
					out.println("<ARG_VALUE><![CDATA["+CommonUtil.isNull(bean.getArg_value())+"]]></ARG_VALUE>");
					out.println("<USE_YN><![CDATA["+CommonUtil.isNull(bean.getUse_yn())+"]]></USE_YN>");
					
					out.println("</item>");
				}
				
				out.println("</items>");
				
			}
		}else if(itemGb.equals("periodList")){
			List<com.ghayoun.ezjobs.m.domain.DefJobBean> itemList = (List)request.getAttribute("itemList");
			if( !(null!=itemList && 0<itemList.size()) ){
				out.println("<items cnt='0' msg='"+CommonUtil.getMessage("DEBUG.06")+"' ></items>");
			}else{
				out.println("<items cnt='"+itemList.size()+"' >");
				
				for( int i=0; i<itemList.size(); i++ ){
					com.ghayoun.ezjobs.m.domain.DefJobBean bean = itemList.get(i);
					
					out.println("<item>");
					
					out.println("<NODE_ID><![CDATA["+CommonUtil.isNull(bean.getNode_id())+"]]></NODE_ID>");
					out.println("<OWNER><![CDATA["+CommonUtil.isNull(bean.getOwner())+"]]></OWNER>");
					out.println("<JOB_NAME><![CDATA["+CommonUtil.isNull(bean.getJob_name())+"]]></JOB_NAME>");
					out.println("<DESC><![CDATA["+CommonUtil.isNull(bean.getDescription())+"]]></DESC>");
					out.println("<MEM_LIB><![CDATA["+CommonUtil.isNull(bean.getMem_lib())+"]]></MEM_LIB>");
					out.println("<MEM_NAME><![CDATA["+CommonUtil.isNull(bean.getMemname())+"]]></MEM_NAME>");
					out.println("<ARGUMENT><![CDATA["+CommonUtil.isNull(bean.getArgument())+"]]></ARGUMENT>");
					out.println("<COMMAND><![CDATA["+CommonUtil.isNull(bean.getCmd_line())+"]]></COMMAND>");
					//out.println("<ACT_GB><![CDATA["+CommonUtil.isNull(bean.getAct_gb())+"]]></ACT_GB>");
					out.println("<TIME_FROM><![CDATA["+CommonUtil.isNull(bean.getFrom_time())+"]]></TIME_FROM>");
					out.println("<CONDITIONS_IN><![CDATA["+CommonUtil.isNull(bean.getIn_condition())+"]]></CONDITIONS_IN>");
					out.println("<CONDITIONS_OUT><![CDATA["+CommonUtil.isNull(bean.getOut_condition())+"]]></CONDITIONS_OUT>");
					out.println("<BATCHJOBGRADE><![CDATA["+CommonUtil.isNull(bean.getBatchjobGrade())+"]]></BATCHJOBGRADE>");
															
					out.println("</item>");
				}
				
				out.println("</items>");
			}

		}else if(itemGb.equals("getInCondNameList")){
			List<com.ghayoun.ezjobs.comm.domain.CommonBean> itemList = (List)request.getAttribute("itemList");
			if( !(null!=itemList && 0<itemList.size()) ){
				out.println("<items cnt='0' msg='"+CommonUtil.getMessage("DEBUG.06")+"' ></items>");
			}else{				
				out.println("<items cnt='"+itemList.size()+"' >");				
				for( int i=0; i<itemList.size(); i++ ){
					com.ghayoun.ezjobs.comm.domain.CommonBean bean = itemList.get(i);
					
					out.println("<item>");
					
					out.println("<JOB_NAME><![CDATA["+CommonUtil.isNull(bean.getJob_name())+"]]></JOB_NAME>");
					out.println("<USER_NM><![CDATA["+CommonUtil.isNull(bean.getOwner_user_nm())+"]]></USER_NM>");					
															
					out.println("</item>");
				}
				
				out.println("</items>");
			}
			
		}else if(itemGb.equals("checkIfName")){
			List itemList = (List)request.getAttribute("itemList");
			if( !(null!=itemList && 0<itemList.size()) ){
				out.println("<items cnt='0' msg='"+CommonUtil.getMessage("DEBUG.06")+"' ></items>");
			}else{				
				out.println("<items cnt='"+itemList.size()+"' >");				
				for( int i=0; i<itemList.size(); i++ ){
					String ifReturn = CommonUtil.isNull(itemList.get(i));
					
					out.println("<item>");
					
					out.println("<IF_RETURN><![CDATA["+ifReturn+"]]></IF_RETURN>");
															
					out.println("</item>");
				}
				
				out.println("</items>");
			}
			
		}else if(itemGb.equals("batchResultTotalList2")){
			List<BatchResultTotalBean> itemList = (List)request.getAttribute("itemList");
			if( !(null!=itemList && 0<itemList.size()) ){
				out.println("<items cnt='0' msg='"+CommonUtil.getMessage("DEBUG.06")+"' ></items>");
			}else{
				out.println("<items cnt='"+itemList.size()+"' >");
				
				for( int i=0; i<itemList.size(); i++ ){
					BatchResultTotalBean bean = itemList.get(i);					
					
// 					String strGubun 			= CommonUtil.isNull(bean.getGubun());
// 					String strDataCenter 		= CommonUtil.isNull(paramMap.get("data_center"));
					String strDataCenter 		= CommonUtil.isNull(bean.getData_center());
					String strTableName 		= CommonUtil.isNull(bean.getTable_name());
					String strApplication 		= CommonUtil.isNull(bean.getApplication());
					String strGroupName 		= CommonUtil.isNull(bean.getGroup_name());
					String strOdate 			= CommonUtil.isNull(bean.getOdate());
// 					String strOrderDate 		= CommonUtil.isNull(bean.getOrder_date());
					String strOkCnt 			= CommonUtil.isNull(bean.getOk_cnt());
					String strNotOkCnt 			= CommonUtil.isNull(bean.getNot_ok_cnt());
					String strExceCnt 			= CommonUtil.isNull(bean.getExec_cnt());
					String strWaitUserCnt 		= CommonUtil.isNull(bean.getWait_user_cnt());
					String strWaitResourceCnt 	= CommonUtil.isNull(bean.getWait_resource_cnt());
					String strWaitHostCnt 		= CommonUtil.isNull(bean.getWait_host_cnt());
					String strWaitConditionCnt 	= CommonUtil.isNull(bean.getWait_condition_cnt());
// 					String strWaitTimeCnt 		= CommonUtil.isNull(bean.getWait_time_cnt());
					String strDeleteCnt 		= CommonUtil.isNull(bean.getDelete_cnt());
					String strTotalCnt	 		= CommonUtil.isNull(bean.getTotal_cnt());
					String strSmartJobYn 		= CommonUtil.isNull(bean.getSmart_job_yn());

					out.println("<item>");
					
// 					out.println("<gubun><![CDATA["+strGubun+"]]></gubun>");
					out.println("<data_center><![CDATA["+strDataCenter+"]]></data_center>");
					out.println("<table_name><![CDATA["+strTableName+"]]></table_name>");
					out.println("<application><![CDATA["+strApplication+"]]></application>");
					out.println("<group_name><![CDATA["+strGroupName+"]]></group_name>");
					out.println("<odate><![CDATA["+strOdate+"]]></odate>");
// 					out.println("<order_date><![CDATA["+strOrderDate+"]]></order_date>");
					out.println("<total_cnt><![CDATA["+strTotalCnt+"]]></total_cnt>");
					out.println("<ok_cnt><![CDATA["+strOkCnt+"]]></ok_cnt>");
					out.println("<not_ok_cnt><![CDATA["+strNotOkCnt+"]]></not_ok_cnt>");
					out.println("<exec_cnt><![CDATA["+strExceCnt+"]]></exec_cnt>");
					out.println("<wait_user_cnt><![CDATA["+strWaitUserCnt+"]]></wait_user_cnt>");
					out.println("<wait_resource_cnt><![CDATA["+strWaitResourceCnt+"]]></wait_resource_cnt>");
					out.println("<wait_host_cnt><![CDATA["+strWaitHostCnt+"]]></wait_host_cnt>");
					out.println("<wait_condition_cnt><![CDATA["+strWaitConditionCnt+"]]></wait_condition_cnt>");
// 					out.println("<wait_time_cnt><![CDATA["+strWaitTimeCnt+"]]></wait_time_cnt>");
					out.println("<delete_cnt><![CDATA["+strDeleteCnt+"]]></delete_cnt>");
					out.println("<smart_job_yn><![CDATA["+strSmartJobYn+"]]></smart_job_yn>");

					out.println("</item>");
				}
				
				out.println("</items>");			
			}

		} else if(itemGb.equals("batchResultTotalList3")){
			List<BatchResultTotalBean> itemList = (List)request.getAttribute("itemList");
			if( !(null!=itemList && 0<itemList.size()) ){
				out.println("<items cnt='0' msg='"+CommonUtil.getMessage("DEBUG.06")+"' ></items>");
			}else{
				out.println("<items cnt='"+itemList.size()+"' >");
				
				for( int i=0; i<itemList.size(); i++ ){
					BatchResultTotalBean bean = itemList.get(i);					
					
// 					String strGubun 			= CommonUtil.isNull(bean.getGubun());
// 					String strDataCenter 		= CommonUtil.isNull(paramMap.get("data_center"));
					String strDataCenter 		= CommonUtil.isNull(bean.getData_center());
					String strTableName 		= CommonUtil.isNull(bean.getTable_name());
					String strApplication 		= CommonUtil.isNull(bean.getApplication());
					String strGroupName 		= CommonUtil.isNull(bean.getGroup_name());
					String strOdate 			= CommonUtil.isNull(bean.getOdate());
// 					String strOrderDate 		= CommonUtil.isNull(bean.getOrder_date());
					String strOkCnt 			= CommonUtil.isNull(bean.getOk_cnt());
					String strNotOkCnt 			= CommonUtil.isNull(bean.getNot_ok_cnt());
					String strExceCnt 			= CommonUtil.isNull(bean.getExec_cnt());
					String strWaitCnt 			= CommonUtil.isNull(bean.getWait_cnt());
					String strDeleteCnt 		= CommonUtil.isNull(bean.getDelete_cnt());
					String strTotalCnt	 		= CommonUtil.isNull(bean.getTotal_cnt());

					out.println("<item>");
					
// 					out.println("<gubun><![CDATA["+strGubun+"]]></gubun>");
					out.println("<data_center><![CDATA["+strDataCenter+"]]></data_center>");
					out.println("<table_name><![CDATA["+strTableName+"]]></table_name>");
					out.println("<application><![CDATA["+strApplication+"]]></application>");
					out.println("<group_name><![CDATA["+strGroupName+"]]></group_name>");
					out.println("<odate><![CDATA["+strOdate+"]]></odate>");
// 					out.println("<order_date><![CDATA["+strOrderDate+"]]></order_date>");
					out.println("<total_cnt><![CDATA["+strTotalCnt+"]]></total_cnt>");
					out.println("<ok_cnt><![CDATA["+strOkCnt+"]]></ok_cnt>");
					out.println("<not_ok_cnt><![CDATA["+strNotOkCnt+"]]></not_ok_cnt>");
					out.println("<exec_cnt><![CDATA["+strExceCnt+"]]></exec_cnt>");
					out.println("<wait_cnt><![CDATA["+strWaitCnt+"]]></wait_cnt>");
					out.println("<delete_cnt><![CDATA["+strDeleteCnt+"]]></delete_cnt>");

					out.println("</item>");
				}
				
				out.println("</items>");			
			}

		}else if(itemGb.equals("srList")) {
			
			List<CommonBean> itemList = (List)request.getAttribute("itemList");
			
			if( !(null!=itemList && 0<itemList.size()) ){
				out.println("<items cnt='0' msg='"+CommonUtil.getMessage("DEBUG.06")+"' ></items>");
			}else{
				out.println("<items cnt='"+itemList.size()+"' >");
				
				for( int i=0; i<itemList.size(); i++ ){
					CommonBean bean = itemList.get(i);
					
					String strSreqCode		= CommonUtil.isNull(bean.getSreq_code());
					String strSreqTitle 	= CommonUtil.isNull(bean.getSreq_title());
					String strPmNm 			= CommonUtil.isNull(bean.getPm_nm());
					String strSreqPlanmh 	= CommonUtil.isNull(bean.getSreq_planmh());
					String strSreqResmh 	= CommonUtil.isNull(bean.getSreq_resmh());
					
					out.println("<item>");
					
					out.println("<SREQ_CODE><![CDATA["+strSreqCode+"]]></SREQ_CODE>");
					out.println("<SREQ_TITLE><![CDATA["+strSreqTitle+"]]></SREQ_TITLE>");
					out.println("<PM_NM><![CDATA["+strPmNm+"]]></PM_NM>");
					out.println("<SREQ_PLANMH><![CDATA["+strSreqPlanmh+"]]></SREQ_PLANMH>");
					out.println("<SREQ_RESMH><![CDATA["+strSreqResmh+"]]></SREQ_RESMH>");
					
					out.println("</item>");
				}
				
				out.println("</items>");			
			}

		} else if(itemGb.equals("myWorksInfoList")) {
			
			List<CommonBean> itemList = (List)request.getAttribute("itemList");
			
			if( !(null!=itemList && 0<itemList.size()) ){
				out.println("<items cnt='0' msg='"+CommonUtil.getMessage("DEBUG.06")+"' ></items>");
			}else{
				out.println("<items cnt='"+itemList.size()+"' >");
				
				for( int i=0; i<itemList.size(); i++ ){
					CommonBean bean = itemList.get(i);
					
					String strDataCenterName	= CommonUtil.isNull(bean.getData_center_name());
					String strOdate 			= CommonUtil.isNull(bean.getOdate());
					String strTotalCnt			= CommonUtil.isNull(bean.getTotal_cnt());
					String strOkCnt 			= CommonUtil.isNull(bean.getOk_cnt());
					String strNotOkCnt 			= CommonUtil.isNull(bean.getNot_ok_cnt());
					String strWaitCnt 			= CommonUtil.isNull(bean.getWait_cnt());
					String strLateCnt 			= CommonUtil.isNull(bean.getLate_cnt());
					String strRunCnt 			= CommonUtil.isNull(bean.getRunning_cnt());
					String strDelCnt 			= CommonUtil.isNull(bean.getDelete_cnt());
					String strDataCenter		= CommonUtil.isNull(bean.getData_center());
					String strUserDaily			= CommonUtil.isNull(bean.getUser_daily());

					out.println("<item>");
					
					out.println("<DATA_CENTER_NAME><![CDATA["+strDataCenterName+"]]></DATA_CENTER_NAME>");
					out.println("<ODATE><![CDATA["+strOdate+"]]></ODATE>");
					out.println("<TOTAL_COUNT><![CDATA["+strTotalCnt+"]]></TOTAL_COUNT>");
					out.println("<OK><![CDATA["+strOkCnt+"]]></OK>");
					out.println("<NOTOK><![CDATA["+strNotOkCnt+"]]></NOTOK>");
					out.println("<WAIT><![CDATA["+strWaitCnt+"]]></WAIT>");
					out.println("<LATE><![CDATA["+strLateCnt+"]]></LATE>");
					out.println("<RUNNING><![CDATA["+strRunCnt+"]]></RUNNING>");
					out.println("<DEL_COUNT><![CDATA["+strDelCnt+"]]></DEL_COUNT>");
					out.println("<DATA_CENTER><![CDATA["+strDataCenter+"]]></DATA_CENTER>");
					out.println("<USER_DAILY><![CDATA["+strUserDaily+"]]></USER_DAILY>");
					
					out.println("</item>");
				}
				
				out.println("</items>");			
			}

		} else if(itemGb.equals("myDocInfoCntList")) {
			
			List<CommonBean> itemList = (List)request.getAttribute("itemList");
			
			if( !(null!=itemList && 0<itemList.size()) ){
				out.println("<items cnt='0' msg='"+CommonUtil.getMessage("DEBUG.06")+"' ></items>");
			}else{
				out.println("<items cnt='"+itemList.size()+"' >");
				
				for( int i=0; i<itemList.size(); i++ ){
					CommonBean bean = itemList.get(i);
					
					String strApplyTotalCnt		= CommonUtil.isNull(bean.getApply_total_cnt(), "0");
					String strApprovalTotalCnt	= CommonUtil.isNull(bean.getApproval_total_cnt(), "0");
					String strDocSave 			= CommonUtil.isNull(bean.getDoc_save(), "0");
					String strApprovalIng 		= CommonUtil.isNull(bean.getApproval_ing(), "0");
					String strApprovalOk 		= CommonUtil.isNull(bean.getApproval_ok(), "0");
					String strApprovalCancel	= CommonUtil.isNull(bean.getApproval_cancel(), "0");
					String strApplyOk 			= CommonUtil.isNull(bean.getApply_ok(), "0");
					String strApplyWait			= CommonUtil.isNull(bean.getApply_wait(), "0");
					String strApplyCancel		= CommonUtil.isNull(bean.getApply_cancel(), "0");
					String strApplyFail			= CommonUtil.isNull(bean.getApply_fail(), "0");

					out.println("<item>");
					
					out.println("<APPLY_TOTAL_COUNT><![CDATA["+strApplyTotalCnt+"]]></APPLY_TOTAL_COUNT>");
					out.println("<APPROVAL_TOTAL_COUNT><![CDATA["+strApprovalTotalCnt+"]]></APPROVAL_TOTAL_COUNT>");
					out.println("<DOC_SAVE><![CDATA["+strDocSave+"]]></DOC_SAVE>");
					out.println("<APPROVAL_ING><![CDATA["+strApprovalIng+"]]></APPROVAL_ING>");
					out.println("<APPROVAL_OK><![CDATA["+strApprovalOk+"]]></APPROVAL_OK>");
					out.println("<APPROVAL_CANCEL><![CDATA["+strApprovalCancel+"]]></APPROVAL_CANCEL>");
					out.println("<APPLY_OK><![CDATA["+strApplyOk+"]]></APPLY_OK>");
					out.println("<APPLY_WAIT><![CDATA["+strApplyWait+"]]></APPLY_WAIT>");
					out.println("<APPLY_FAIL><![CDATA["+strApplyFail+"]]></APPLY_FAIL>");
					out.println("<APPLY_CANCEL><![CDATA["+strApplyCancel+"]]></APPLY_CANCEL>");
					
					out.println("</item>");
				}
				
				out.println("</items>");			
			}

		} else if(itemGb.equals("myAlarmDocInfoCntList")) {
			
			List<CommonBean> itemList = (List)request.getAttribute("itemList");
			
			if( !(null!=itemList && 0<itemList.size()) ){
				out.println("<items cnt='0' msg='"+CommonUtil.getMessage("DEBUG.06")+"' ></items>");
			}else{
				out.println("<items cnt='"+itemList.size()+"' >");
				
				for( int i=0; i<itemList.size(); i++ ){
					CommonBean bean = itemList.get(i);
					
					String strTotalCnt			= CommonUtil.isNull(bean.getTotal_cnt(), "0");
					String strNotOkCnt 			= CommonUtil.isNull(bean.getNot_ok_cnt(), "0");
					String strLateSubCnt 		= CommonUtil.isNull(bean.getLate_sub_cnt(), "0");
					String strLateTimeCnt 		= CommonUtil.isNull(bean.getLate_time_cnt(), "0");
					String strLateExecCnt		= CommonUtil.isNull(bean.getLate_exec_cnt(), "0");
					String strDataCenterName	= CommonUtil.isNull(bean.getData_center_name(), "0");

					out.println("<item>");
					
					out.println("<TOTAL_COUNT><![CDATA["+strTotalCnt+"]]></TOTAL_COUNT>");
					out.println("<NOT_OK_CNT><![CDATA["+strNotOkCnt+"]]></NOT_OK_CNT>");
					out.println("<LATE_SUB_CNT><![CDATA["+strLateSubCnt+"]]></LATE_SUB_CNT>");
					out.println("<LATE_TIME_CNT><![CDATA["+strLateTimeCnt+"]]></LATE_TIME_CNT>");
					out.println("<LATE_EXEC_CNT><![CDATA["+strLateExecCnt+"]]></LATE_EXEC_CNT>");
					out.println("<DATA_CENTER_NAME><![CDATA["+strDataCenterName+"]]></DATA_CENTER_NAME>");
					
					out.println("</item>");
				}
				
				out.println("</items>");			
			}

		} else if(itemGb.equals("myApprovalDocInfoList")) {
			
			List<CommonBean> itemList = (List)request.getAttribute("itemList");
			
			if( !(null!=itemList && 0<itemList.size()) ){
				out.println("<items cnt='0' msg='"+CommonUtil.getMessage("DEBUG.06")+"' ></items>");
			}else{
				out.println("<items cnt='"+itemList.size()+"' >");
				
				for( int i=0; i<itemList.size(); i++ ){
					CommonBean bean = itemList.get(i);
					
					String strDocGb			= CommonUtil.isNull(bean.getDoc_gb());
					String strUserNm		= CommonUtil.isNull(bean.getUser_nm());
					String strDeptNm 		= CommonUtil.isNull(bean.getDept_nm());
					String strDutyNm 		= CommonUtil.isNull(bean.getDuty_nm());
					String strDraftDate		= CommonUtil.isNull(bean.getDraft_date());
					String strJobName		= CommonUtil.isNull(bean.getJob_name());
					String strTitle			= CommonUtil.isNull(bean.getTitle());
					String strDataCenter	= CommonUtil.isNull(bean.getData_center());
					String doc_group_id		= CommonUtil.isNull(bean.getDoc_group_id());

					String task_detail = "";
					String task_nm = "";

					if(CommonUtil.isNull(bean.getDoc_gb()).equals("05") && !CommonUtil.isNull(bean.getDoc_group_id()).equals("")){
						strDocGb 	= strDocGb + "G";
						task_nm    	= CommonUtil.getMessage("DOC.GB."+strDocGb);
					}else if(CommonUtil.isNull(bean.getDoc_gb()).equals("06") || CommonUtil.isNull(bean.getDoc_gb()).equals("09")){
						task_nm    	= CommonUtil.getMessage("DOC.GB." + strDocGb + CommonUtil.isNull(bean.getTask_nm_detail()));
					}else {
						task_nm 	= CommonUtil.getMessage("DOC.GB."+strDocGb);
					}
					
					String strUserInfo = "["+strDeptNm+"]"+strUserNm;
					
					out.println("<item>");
					
					out.println("<DOC_GB_CODE><![CDATA["+strDocGb+"]]></DOC_GB_CODE>");
					out.println("<DOC_GB><![CDATA["+task_nm+"]]></DOC_GB>");
					out.println("<JOB_NAME><![CDATA["+strJobName+"]]></JOB_NAME>");
					out.println("<TITLE><![CDATA["+strTitle+"]]></TITLE>");
					out.println("<USER_INFO><![CDATA["+strUserInfo+"]]></USER_INFO>");
					out.println("<DRAFT_DATE><![CDATA["+strDraftDate+"]]></DRAFT_DATE>");
					out.println("<DATA_CENTER><![CDATA["+strDataCenter+"]]></DATA_CENTER>");
					
					out.println("</item>");
				}
				
				out.println("</items>");			
			}

		} else if(itemGb.equals("execDocInfoList")) {
			
			List<CommonBean> itemList = (List)request.getAttribute("itemList");
			
			if( !(null!=itemList && 0<itemList.size()) ){
				out.println("<items cnt='0' msg='"+CommonUtil.getMessage("DEBUG.06")+"' ></items>");
			}else{
				out.println("<items cnt='"+itemList.size()+"' >");
				
				for( int i=0; i<itemList.size(); i++ ){
					CommonBean bean = itemList.get(i);
					
					String strDocGb			= CommonUtil.isNull(bean.getDoc_gb());
					String strUserNm		= CommonUtil.isNull(bean.getUser_nm());
					String strDeptNm 		= CommonUtil.isNull(bean.getDept_nm());
					String strDutyNm 		= CommonUtil.isNull(bean.getDuty_nm());
					String strDraftDate		= CommonUtil.isNull(bean.getDraft_date());
					String strJobName		= CommonUtil.isNull(bean.getJob_name());
					String strDataCenter	= CommonUtil.isNull(bean.getData_center());
					
					String strDocGbMent = "";
					if ( strDocGb.equals("01") ) {						
						strDocGbMent = "신규의뢰";
					} else if ( strDocGb.equals("02") ) {						
						strDocGbMent = "수시";
					} else if ( strDocGb.equals("03") ) {						
						strDocGbMent = "삭제의뢰";
					} else if ( strDocGb.equals("04") ) {						
						strDocGbMent = "수정의뢰";
					} else if ( strDocGb.equals("05") ) {						
						strDocGbMent = "수행";
					} else if ( strDocGb.equals("06") ) {						
						strDocGbMent = "엑셀";
					} else if ( strDocGb.equals("07") ) {						
						strDocGbMent = "상태변경";						
					} else if ( strDocGb.equals("08") ) {						
						strDocGbMent = "예약상태변경";						
					} else if ( strDocGb.equals("10") ) {						
						strDocGbMent = "담당자변경";						
					} else if ( strDocGb.equals("11") ) {						
						strDocGbMent = "오류조치";						
					} else if ( strDocGb.equals("12") ) {						
						strDocGbMent = "수시작업결과";						
					} else if ( strDocGb.equals("13") ) {						
						strDocGbMent = "수행현황";						
					}
					
					String strUserInfo = "["+strDeptNm+"]"+strUserNm;
					
					out.println("<item>");
					
					out.println("<DOC_GB_CODE><![CDATA["+strDocGb+"]]></DOC_GB_CODE>");
					out.println("<DOC_GB><![CDATA["+strDocGbMent+"]]></DOC_GB>");
					out.println("<JOB_NAME><![CDATA["+strJobName+"]]></JOB_NAME>");
					out.println("<USER_INFO><![CDATA["+strUserInfo+"]]></USER_INFO>");
					out.println("<DRAFT_DATE><![CDATA["+strDraftDate+"]]></DRAFT_DATE>");
					out.println("<DATA_CENTER><![CDATA["+strDataCenter+"]]></DATA_CENTER>");
					
					out.println("</item>");
				}
				
				out.println("</items>");			
			}

		} else if(itemGb.equals("myWorkList")) {
			
			List<CommonBean> itemList = (List)request.getAttribute("itemList");
			
			if( !(null!=itemList && 0<itemList.size()) ){
				out.println("<items cnt='0' msg='"+CommonUtil.getMessage("DEBUG.06")+"' ></items>");
			}else{
				out.println("<items cnt='"+itemList.size()+"' >");
				
				for( int i=0; i<itemList.size(); i++ ){
					CommonBean bean = itemList.get(i);
					
					String strWorkCd		= CommonUtil.isNull(bean.getWork_cd());
					String strWorkDate		= CommonUtil.isNull(bean.getWork_date());
					String strContent 		= CommonUtil.isNull(bean.getContent());
					
					String strWorkDateMent	= strWorkDate.substring(0, 4) + "/" + strWorkDate.substring(4, 6) + "/" + strWorkDate.substring(6, 8);
					
					out.println("<item>");
					
					out.println("<WORK_CD><![CDATA["+strWorkCd+"]]></WORK_CD>");
					out.println("<WORK_DATE><![CDATA["+strWorkDateMent+"]]></WORK_DATE>");
					out.println("<CONTENT><![CDATA["+strContent+"]]></CONTENT>");
					
					out.println("</item>");
				}
				
				out.println("</items>");			
			}

		} else if(itemGb.equals("hostGrpList")) {
			
			List<CommonBean> itemList = (List)request.getAttribute("itemList");
			
			if( !(null!=itemList && 0<itemList.size()) ){
				out.println("<items cnt='0' msg='"+CommonUtil.getMessage("DEBUG.06")+"' ></items>");
			}else{
				out.println("<items cnt='"+itemList.size()+"' >");
				
				for( int i=0; i<itemList.size(); i++ ){
					CommonBean bean = itemList.get(i);
					
					String strDataCenter	= CommonUtil.isNull(bean.getData_center());
					String strGrpname		= CommonUtil.isNull(bean.getGrpname());
					
					out.println("<item>");
					
					out.println("<DATA_CENTER><![CDATA["+strDataCenter+"]]></DATA_CENTER>");
					out.println("<GRPNAME><![CDATA["+strGrpname+"]]></GRPNAME>");
					
					out.println("</item>");
				}
				
				out.println("</items>");			
			}

		} else if(itemGb.equals("grpNodeList")) {
			
			List<CommonBean> itemList = (List)request.getAttribute("itemList");
			
			if( !(null!=itemList && 0<itemList.size()) ){
				out.println("<items cnt='0' msg='"+CommonUtil.getMessage("DEBUG.06")+"' ></items>");
			}else{
				out.println("<items cnt='"+itemList.size()+"' >");
				
				for( int i=0; i<itemList.size(); i++ ){
					CommonBean bean = itemList.get(i);
					
					String strNodeid	= CommonUtil.isNull(bean.getNodeid());
					
					out.println("<item>");
					
					out.println("<NODEID><![CDATA["+strNodeid+"]]></NODEID>");
					
					out.println("</item>");
				}
				
				out.println("</items>");			
			}

		} else if(itemGb.equals("checkSmartTableCnt")) {
			
			List<CommonBean> itemList = (List)request.getAttribute("itemList");
			
			if( !(null!=itemList && 0<itemList.size()) ){
				out.println("<items cnt='0' msg='"+CommonUtil.getMessage("DEBUG.06")+"' ></items>");
			}else{
				out.println("<items cnt='"+itemList.size()+"' >");
				
				for( int i=0; i<itemList.size(); i++ ){
					CommonBean bean = itemList.get(i);
					
					String strTotalCnt = CommonUtil.isNull(bean.getTotal_cnt());
					
					out.println("<item>");
					
					out.println("<TOTAL_CNT><![CDATA["+strTotalCnt+"]]></TOTAL_CNT>");
					
					out.println("</item>");
				}
				
				out.println("</items>");			
			}

		} else if(itemGb.equals("userDailyNameList")) {
			
			List<CommonBean> itemList = (List)request.getAttribute("itemList");
			
			if( !(null!=itemList && 0<itemList.size()) ){
				out.println("<items cnt='0' msg='"+CommonUtil.getMessage("DEBUG.06")+"' ></items>");
			}else{
				out.println("<items cnt='"+itemList.size()+"' >");
				
				for( int i=0; i<itemList.size(); i++ ){
					CommonBean bean = itemList.get(i);
					
					String strUserDaily = CommonUtil.isNull(bean.getUser_daily());
					
					out.println("<item>");
					
					out.println("<USER_DAILY><![CDATA["+strUserDaily+"]]></USER_DAILY>");
					
					out.println("</item>");
				}
				
				out.println("</items>");			
			}
		} else if(itemGb.equals("sForderList")) {
			
			List<CommonBean> itemList = (List)request.getAttribute("itemList");
			
			if( !(null!=itemList && 0<itemList.size()) ){
				out.println("<items cnt='0' msg='"+CommonUtil.getMessage("DEBUG.06")+"' ></items>");
			}else{
				out.println("<items cnt='"+itemList.size()+"' >");
				
				for( int i=0; i<itemList.size(); i++ ){
					CommonBean bean = itemList.get(i);

					String parent_table	 = CommonUtil.isNull(bean.getParent_table());
					String user_daily	 = CommonUtil.isNull(bean.getUser_daily());
					String used_by		 = CommonUtil.isNull(bean.getUsed_by());
					String sync_state	 = CommonUtil.isNull(bean.getSync_state());
					String sync_msg		 = CommonUtil.isNull(bean.getSync_msg());
					String last_upload	 = CommonUtil.isNull(bean.getLast_upload());
					String jobs_in_group = CommonUtil.isNull(bean.getJobs_in_group());
					String doc_cd		 = CommonUtil.isNull(bean.getDoc_cd());
					String job_name		 = CommonUtil.isNull(bean.getJob_name());
					String data_center	 = CommonUtil.isNull(bean.getData_center());
// 					String title		 = CommonUtil.isNull(bean.get);
					
					out.println("<item>");

					out.println("<PARENT_TALBE><![CDATA["+parent_table+"]]></PARENT_TALBE>");
					out.println("<USER_DAILY><![CDATA["+user_daily+"]]></USER_DAILY>");
					out.println("<USED_BY><![CDATA["+used_by+"]]></USED_BY>");
					out.println("<SYNC_STATE><![CDATA["+sync_state+"]]></SYNC_STATE>");
					out.println("<SYNC_MSG><![CDATA["+sync_msg+"]]></SYNC_MSG>");
					out.println("<LAST_UPLOAD><![CDATA["+last_upload+"]]></LAST_UPLOAD>");
					out.println("<JOBS_IN_GROUP><![CDATA["+jobs_in_group+"]]></JOBS_IN_GROUP>");
					out.println("<DOC_CD><![CDATA["+doc_cd+"]]></DOC_CD>");
					out.println("<JOB_NAME><![CDATA["+job_name+"]]></JOB_NAME>");
					out.println("<DATA_CENTER><![CDATA["+data_center+"]]></DATA_CENTER>");
// 					out.println("<TITLE><![CDATA["+data_center+"]]></TITLE>");
					
					out.println("</item>");
				}
				
				out.println("</items>");			
			}
		} else if (itemGb.equals("batchTotal")) {
			
			List<BatchTotalBean> itemList = (List)request.getAttribute("itemList");
			
			if( !(null!=itemList && 0<itemList.size()) ) {
				out.println("<items cnt='0' msg='"+CommonUtil.getMessage("DEBUG.06")+"' ></items>");
			} else {
				out.println("<items cnt='"+itemList.size()+"' >");
				
				for( int i=0; i<itemList.size(); i++ ){
					BatchTotalBean bean = itemList.get(i);					
					
					String strDataCenter 		= CommonUtil.isNull(bean.getData_center());
					String strTableName 		= CommonUtil.isNull(bean.getTable_name());
					String strApplication 		= CommonUtil.isNull(bean.getApplication());
					String strGroupName 		= CommonUtil.isNull(bean.getGroup_name());
					
					String strRegNewCnt			= CommonUtil.isNull(bean.getReg_new_cnt());
					String strRegModCnt			= CommonUtil.isNull(bean.getReg_mod_cnt());
					String strRegDelCnt			= CommonUtil.isNull(bean.getReg_del_cnt());
					String strRegOrdCnt			= CommonUtil.isNull(bean.getReg_ord_cnt());
					String strRegChgCondCnt		= CommonUtil.isNull(bean.getReg_chg_cond_cnt());
					
					String strIrregNewCnt		= CommonUtil.isNull(bean.getIrreg_new_cnt());
					String strIrregModCnt		= CommonUtil.isNull(bean.getIrreg_mod_cnt());
					String strIrregDelCnt		= CommonUtil.isNull(bean.getIrreg_del_cnt());
					String strIrregOrdCnt		= CommonUtil.isNull(bean.getIrreg_ord_cnt());
					String strIrregChgCondCnt	= CommonUtil.isNull(bean.getIrreg_chg_cond_cnt());
					String strSmartJobYn		= CommonUtil.isNull(bean.getSmart_job_yn());
					
					String strTotalCnt			= CommonUtil.isNull(bean.getTotal_cnt());
					out.println("<item>");
					
					out.println("<data_center><![CDATA["+strDataCenter+"]]></data_center>");
					out.println("<table_name><![CDATA["+strTableName+"]]></table_name>");
					out.println("<application><![CDATA["+strApplication+"]]></application>");
					out.println("<group_name><![CDATA["+strGroupName+"]]></group_name>");
					
					out.println("<reg_new_cnt><![CDATA["+strRegNewCnt+"]]></reg_new_cnt>");
					out.println("<reg_mod_cnt><![CDATA["+strRegModCnt+"]]></reg_mod_cnt>");
					out.println("<reg_del_cnt><![CDATA["+strRegDelCnt+"]]></reg_del_cnt>");
					out.println("<reg_ord_cnt><![CDATA["+strRegOrdCnt+"]]></reg_ord_cnt>");
					out.println("<reg_chg_cond_cnt><![CDATA["+strRegChgCondCnt+"]]></reg_chg_cond_cnt>");
					
					out.println("<irreg_new_cnt><![CDATA["+strIrregNewCnt+"]]></irreg_new_cnt>");
					out.println("<irreg_mod_cnt><![CDATA["+strIrregModCnt+"]]></irreg_mod_cnt>");
					out.println("<irreg_del_cnt><![CDATA["+strIrregDelCnt+"]]></irreg_del_cnt>");
					out.println("<irreg_ord_cnt><![CDATA["+strIrregOrdCnt+"]]></irreg_ord_cnt>");
					out.println("<irreg_chg_cond_cnt><![CDATA["+strIrregChgCondCnt+"]]></irreg_chg_cond_cnt>");
					out.println("<smart_job_yn><![CDATA["+strSmartJobYn+"]]></smart_job_yn>");
					
					out.println("<total_cnt><![CDATA["+strTotalCnt+"]]></total_cnt>");
					out.println("</item>");
				}
				
				out.println("</items>");			
			}
		} else if (itemGb.equals("docApprovalTotal")) {
			
			List<DocApprovalTotalBean> itemList = (List)request.getAttribute("itemList");
			
			if( !(null!=itemList && 0<itemList.size()) ){
				out.println("<items cnt='0' msg='"+CommonUtil.getMessage("DEBUG.06")+"' ></items>");
			}else{
				out.println("<items cnt='"+itemList.size()+"' >");
				
				for( int i=0; i<itemList.size(); i++ ){
					DocApprovalTotalBean bean = itemList.get(i);					
					
					String strDataCenter 		= CommonUtil.isNull(bean.getData_center());
					String strDeptNm 			= CommonUtil.isNull(bean.getDept_nm());
					String strTableName 		= CommonUtil.isNull(bean.getTable_name());
					
					String strDocNewCnt			= CommonUtil.isNull(bean.getDoc_new_cnt());
					String strDocModCnt			= CommonUtil.isNull(bean.getDoc_mod_cnt());
					String strDocDelCnt			= CommonUtil.isNull(bean.getDoc_del_cnt());
					String strDocOrdCnt			= CommonUtil.isNull(bean.getDoc_ord_cnt());
					String strDocExcelCnt		= CommonUtil.isNull(bean.getDoc_excel_cnt());
					String strDocChgCondCnt		= CommonUtil.isNull(bean.getDoc_chg_cond_cnt());
					String strDocUrgCnt			= CommonUtil.isNull(bean.getDoc_urg_cnt());
					String strTotalCnt			= CommonUtil.isNull(bean.getTotal_cnt());
					String strSmartJobYn		= CommonUtil.isNull(bean.getSmart_job_yn());

					out.println("<item>");
					
					out.println("<data_center><![CDATA["+strDataCenter+"]]></data_center>");
					out.println("<dept_nm><![CDATA["+strDeptNm+"]]></dept_nm>");
					out.println("<table_name><![CDATA["+strTableName+"]]></table_name>");
					
					out.println("<doc_new_cnt><![CDATA["+strDocNewCnt+"]]></doc_new_cnt>");
					out.println("<doc_mod_cnt><![CDATA["+strDocModCnt+"]]></doc_mod_cnt>");
					out.println("<doc_del_cnt><![CDATA["+strDocDelCnt+"]]></doc_del_cnt>");
					out.println("<doc_ord_cnt><![CDATA["+strDocOrdCnt+"]]></doc_ord_cnt>");
					out.println("<doc_excel_cnt><![CDATA["+strDocExcelCnt+"]]></doc_excel_cnt>");
					out.println("<doc_chg_cond_cnt><![CDATA["+strDocChgCondCnt+"]]></doc_chg_cond_cnt>");
					out.println("<doc_urg_cnt><![CDATA["+strDocUrgCnt+"]]></doc_urg_cnt>");
					out.println("<total_cnt><![CDATA["+strTotalCnt+"]]></total_cnt>");
					out.println("<smart_job_yn><![CDATA["+strSmartJobYn+"]]></smart_job_yn>");

					out.println("</item>");
				}
				
				out.println("</items>");			
			}
		} else if (itemGb.equals("jobCondTotal")) {
			List<JobCondTotalBean> itemList = (List)request.getAttribute("itemList");
			
			if( !(null!=itemList && 0<itemList.size()) ) {
				out.println("<items cnt='0' msg='"+CommonUtil.getMessage("DEBUG.06")+"' ></items>");
			} else {
				out.println("<items cnt='"+itemList.size()+"' >");
				
				for( int i=0; i<itemList.size(); i++ ){
					JobCondTotalBean bean = itemList.get(i);					
					
					String strDataCenter 		= CommonUtil.isNull(bean.getData_center());
					String strOrderTable 		= CommonUtil.isNull(bean.getOrder_table());
					String strApplication 		= CommonUtil.isNull(bean.getApplication());
					String strGroupName 		= CommonUtil.isNull(bean.getGroup_name());
					
					String strRegOkCnt			= CommonUtil.isNull(bean.getReg_ok_cnt());
					String strRegFailCnt		= CommonUtil.isNull(bean.getReg_fail_cnt());
					String strRegWaitCnt		= CommonUtil.isNull(bean.getReg_wait_cnt());
					String strRegEtcCnt			= CommonUtil.isNull(bean.getReg_etc_cnt());
					String strRegTotalCnt		= CommonUtil.isNull(bean.getReg_total_cnt());
					String strRegErrorCnt		= "-";
					String strSmartJobYn		= CommonUtil.isNull(bean.getSmart_job_yn());
					if (!strRegTotalCnt.equals("0"))
						strRegErrorCnt = 100 * Integer.parseInt(strRegFailCnt) / Integer.parseInt(strRegTotalCnt) + "%";
					
					String strIrregOkCnt		= CommonUtil.isNull(bean.getIrreg_ok_cnt());
					String strIrregFailCnt		= CommonUtil.isNull(bean.getIrreg_fail_cnt());
					String strIrregWaitCnt		= CommonUtil.isNull(bean.getIrreg_wait_cnt());
					String strIrregEtcCnt		= CommonUtil.isNull(bean.getIrreg_etc_cnt());
					String strIrregTotalCnt		= CommonUtil.isNull(bean.getIrreg_total_cnt());
					String strIrregErrorCnt		= "-";
					if (!strIrregTotalCnt.equals("0"))
						strIrregErrorCnt = 100 * Integer.parseInt(strIrregFailCnt) / Integer.parseInt(strIrregTotalCnt) + "%";
										
					out.println("<item>");
					
					out.println("<data_center><![CDATA["+strDataCenter+"]]></data_center>");
					out.println("<order_table><![CDATA["+strOrderTable+"]]></order_table>");
					out.println("<application><![CDATA["+strApplication+"]]></application>");
					out.println("<group_name><![CDATA["+strGroupName+"]]></group_name>");

					out.println("<reg_ok_cnt><![CDATA["+strRegOkCnt+"]]></reg_ok_cnt>");
					out.println("<reg_fail_cnt><![CDATA["+strRegFailCnt+"]]></reg_fail_cnt>");
					out.println("<reg_wait_cnt><![CDATA["+strRegWaitCnt+"]]></reg_wait_cnt>");
					out.println("<reg_etc_cnt><![CDATA["+strRegEtcCnt+"]]></reg_etc_cnt>");
					out.println("<reg_total_cnt><![CDATA["+strRegTotalCnt+"]]></reg_total_cnt>");
					out.println("<reg_error_rate><![CDATA["+strRegErrorCnt+"]]></reg_error_rate>");
					
					out.println("<irreg_ok_cnt><![CDATA["+strIrregOkCnt+"]]></irreg_ok_cnt>");
					out.println("<irreg_fail_cnt><![CDATA["+strIrregFailCnt+"]]></irreg_fail_cnt>");
					out.println("<irreg_wait_cnt><![CDATA["+strIrregWaitCnt+"]]></irreg_wait_cnt>");
					out.println("<irreg_etc_cnt><![CDATA["+strIrregEtcCnt+"]]></irreg_etc_cnt>");
					out.println("<irreg_total_cnt><![CDATA["+strIrregTotalCnt+"]]></irreg_total_cnt>");
					out.println("<irreg_error_rate><![CDATA["+strIrregErrorCnt+"]]></irreg_error_rate>");
					out.println("<smart_job_yn><![CDATA["+strSmartJobYn+"]]></smart_job_yn>");

					out.println("</item>");
				}
				
				out.println("</items>");			
			}
		} else if (itemGb.equals("errorLogTotal")) {
			List<ErrorLogTotalBean> itemList = (List)request.getAttribute("itemList");
			
			if( !(null!=itemList && 0<itemList.size()) ) {
				out.println("<items cnt='0' msg='"+CommonUtil.getMessage("DEBUG.06")+"' ></items>");
			} else {
// 				out.println("<items cnt='"+itemList.size()+"' >");
				out.println("<items cnt='"+(itemList.size()-1)+"' total='"+itemList.get(itemList.size()-1)+"'  >");
				
// 				for( int i=0; i<itemList.size(); i++ ){
				for( int i=0; i<itemList.size()-1; i++ ){
					ErrorLogTotalBean bean = itemList.get(i);					
					
					String strJobschedgb		= CommonUtil.isNull(bean.getJobschedgb());
					String strJobName	 		= CommonUtil.isNull(bean.getJob_name());
					String strHostTime	 		= CommonUtil.isNull(bean.getHost_time());
					String strActionDate 		= CommonUtil.isNull(bean.getAction_date());
					String strUdtUserNm			= CommonUtil.isNull(bean.getUdt_user_nm());
					String strErrorDescription	= CommonUtil.isNull(bean.getError_description());
					String strMessage	 		= CommonUtil.isNull(bean.getMessage());
					String strDeptNm	 		= CommonUtil.isNull(bean.getDept_nm());
					String strDutyNm			= CommonUtil.isNull(bean.getDuty_nm());
					String strUserNm	 		= CommonUtil.isNull(bean.getUser_nm());
					
										
					out.println("<item>");
					
					out.println("<jobschedgb><![CDATA["+strJobschedgb+"]]></jobschedgb>");
					out.println("<job_name><![CDATA["+strJobName+"]]></job_name>");
					out.println("<host_time><![CDATA["+strHostTime+"]]></host_time>");
					out.println("<action_date><![CDATA["+strActionDate+"]]></action_date>");
					out.println("<udt_user_nm><![CDATA["+strUdtUserNm+"]]></udt_user_nm>");
					out.println("<error_description><![CDATA["+strErrorDescription+"]]></error_description>");
					out.println("<message><![CDATA["+strMessage+"]]></message>");
					out.println("<dept_nm><![CDATA["+strDeptNm+"]]></dept_nm>");
					out.println("<duty_nm><![CDATA["+strDutyNm+"]]></duty_nm>");
					out.println("<user_nm><![CDATA["+strUserNm+"]]></user_nm>");
					
					out.println("</item>");
				}
				
				out.println("</items>");			
			}
		} else if (itemGb.equals("sched_tableList2")) {
			List<CommonBean> itemList = (List)request.getAttribute("itemList");
			
			if( !(null!=itemList && 0<itemList.size()) ) {
				out.println("<items cnt='0' msg='"+CommonUtil.getMessage("DEBUG.06")+"' ></items>");
			} else {
				out.println("<items cnt='"+itemList.size()+"' >");
				
				for( int i=0; i<itemList.size(); i++ ){
					CommonBean bean = itemList.get(i);					
					
					String strGrpEngNm		= CommonUtil.isNull(bean.getGrp_eng_nm());
					String strFolderAuth	= CommonUtil.isNull(bean.getFolder_auth());
					String strDataCenter	= CommonUtil.isNull(bean.getData_center());
					String strScodeNm		= CommonUtil.isNull(bean.getScode_nm());
					out.println("<item>");
					out.println("<GRP_ENG_NM><![CDATA["+strGrpEngNm+"]]></GRP_ENG_NM>");
					out.println("<FOLDER_AUTH><![CDATA["+strFolderAuth+"]]></FOLDER_AUTH>");
					out.println("<SCODE_NM><![CDATA["+strScodeNm+"]]></SCODE_NM>");
					out.println("<DATA_CENTER><![CDATA["+strDataCenter+"]]></DATA_CENTER>");
					out.println("</item>");
				}
				
				out.println("</items>");			
			}
		} else if (itemGb.equals("sched_tableList3")) {
			List<CommonBean> itemList = (List)request.getAttribute("itemList");

			if( !(null!=itemList && 0<itemList.size()) ) {
				out.println("<items cnt='0' msg='"+CommonUtil.getMessage("DEBUG.06")+"' ></items>");
			} else {
				out.println("<items cnt='"+itemList.size()+"' >");

				for( int i=0; i<itemList.size(); i++ ){
					CommonBean bean = itemList.get(i);

					String strGrpEngNm		= CommonUtil.isNull(bean.getGrp_eng_nm());
					String strFolderAuth	= CommonUtil.isNull(bean.getFolder_auth());
					String strDataCenter	= CommonUtil.isNull(bean.getData_center());
					String strScodeNm		= CommonUtil.isNull(bean.getScode_nm());
					out.println("<item>");
					out.println("<GRP_ENG_NM><![CDATA["+strGrpEngNm+"]]></GRP_ENG_NM>");
					out.println("<FOLDER_AUTH><![CDATA["+strFolderAuth+"]]></FOLDER_AUTH>");
					out.println("<SCODE_NM><![CDATA["+strScodeNm+"]]></SCODE_NM>");
					out.println("<DATA_CENTER><![CDATA["+strDataCenter+"]]></DATA_CENTER>");
					out.println("</item>");
				}

				out.println("</items>");
			}
		}else if (itemGb.equals("sched_user_tableList")) {
			List<CommonBean> itemList = (List)request.getAttribute("itemList");
			if( !(null!=itemList && 0<itemList.size()) ) {
				out.println("<items cnt='0' msg='"+CommonUtil.getMessage("DEBUG.06")+"' ></items>");
			} else {
				out.println("<items cnt='"+itemList.size()+"' >");
				
				for( int i=0; i<itemList.size(); i++ ){
					CommonBean bean = itemList.get(i);					
					
					String strGrpEngNm		= CommonUtil.isNull(bean.getGrp_eng_nm());
					String strFolderAuth	= CommonUtil.isNull(bean.getFolder_auth());
					String strDataCenter	= CommonUtil.isNull(bean.getData_center());
					String strScodeNm		= CommonUtil.isNull(bean.getScode_nm());
					out.println("<item>");
					out.println("<GRP_ENG_NM><![CDATA["+strGrpEngNm+"]]></GRP_ENG_NM>");
					out.println("<FOLDER_AUTH><![CDATA["+strFolderAuth+"]]></FOLDER_AUTH>");
					out.println("<SCODE_NM><![CDATA["+strScodeNm+"]]></SCODE_NM>");
					out.println("<DATA_CENTER><![CDATA["+strDataCenter+"]]></DATA_CENTER>");
					out.println("</item>");
				}
				
				out.println("</items>");
			}
		}else if (itemGb.equals("defJobExceptMapper")) {
			List<DocInfoBean> itemList = (List)request.getAttribute("itemList");
			
			if( !(null!=itemList && 0<itemList.size()) ) {
				out.println("<items cnt='0' msg='"+CommonUtil.getMessage("DEBUG.06")+"' ></items>");
			} else {
				out.println("<items cnt='"+itemList.size()+"' >");
				
				for( int i=0; i<itemList.size(); i++ ){
					DocInfoBean bean = itemList.get(i);					
					
					String strSchedTable		= CommonUtil.isNull(bean.getSched_table());
					String strApplication		= CommonUtil.isNull(bean.getApplication());
					String strGroupName			= CommonUtil.isNull(bean.getGroup_name()); 
					String strJobName	 		= CommonUtil.isNull(bean.getJob_name());
					String strDescription	 	= CommonUtil.isNull(bean.getDescription());
					String strWhenCond	 		= CommonUtil.isNull(bean.getWhen_cond());
					String strShoutTime	 	= CommonUtil.isNull(bean.getShout_time());

					out.println("<item>");
					
					out.println("<sched_table><![CDATA["+strSchedTable+"]]></sched_table>");
					out.println("<application><![CDATA["+strApplication+"]]></application>");
					out.println("<group_name><![CDATA["+strGroupName+"]]></group_name>");
					out.println("<job_name><![CDATA["+strJobName+"]]></job_name>");
					out.println("<when_cond><![CDATA["+strWhenCond+"]]></when_cond>");
					out.println("<shout_time><![CDATA["+strShoutTime+"]]></shout_time>");
					
					out.println("</item>");
				}
				
				out.println("</items>");			
			}
		} else if (itemGb.equals("cmAppGrpCodeList") || itemGb.equals("cmSmartTableList") ) {
			List<AppGrpBean> itemList = (List)request.getAttribute("itemList");
			
			if( !(null!=itemList && 0<itemList.size()) ) {
				out.println("<items cnt='0' msg='"+CommonUtil.getMessage("DEBUG.06")+"' ></items>");
			} else {
				out.println("<items cnt='"+itemList.size()+"' >");
				
				for( int i=0; i<itemList.size(); i++ ){
					AppGrpBean bean = itemList.get(i);					
					
// 					String strDataCenter		= CommonUtil.isNull(bean.getDataCenter());
					String strSchedTable		= CommonUtil.isNull(bean.getSched_table());
					String strUserDaily			= CommonUtil.isNull(bean.getUser_daily());
					String strApplication		= CommonUtil.isNull(bean.getApplication());
					String strGroupName			= CommonUtil.isNull(bean.getGroup_name());
					String strGrpCd				= CommonUtil.isNull(bean.getGrp_cd());
					String strTableType			= CommonUtil.isNull(bean.getTable_type()); 
										
					out.println("<item>");
					
					out.println("<sched_table><![CDATA["+strSchedTable+"]]></sched_table>");
					out.println("<user_daily><![CDATA["+strUserDaily+"]]></user_daily>");
					out.println("<application><![CDATA["+strApplication+"]]></application>");
					out.println("<group_name><![CDATA["+strGroupName+"]]></group_name>");
					out.println("<grp_cd><![CDATA["+strGrpCd+"]]></grp_cd>");
					out.println("<table_type><![CDATA["+strTableType+"]]></table_type>");
					
					out.println("</item>");
				}
				
				out.println("</items>");			
			}
		}else if(itemGb.equals("groupUserGroup")){
			List<CommonBean> itemList = (List)request.getAttribute("itemList");
			if( !(null!=itemList && 0<itemList.size()) ){
				out.println("<items cnt='0' msg='"+CommonUtil.getMessage("DEBUG.06")+"' ></items>");
			}else{
				out.println("<items cnt='"+itemList.size()+"' >");
				
				for( int i=0; i<itemList.size(); i++ ){
					CommonBean bean = itemList.get(i);
					
					out.println("<item>");
					 
					out.println("<GROUP_USER_GROUP_CD><![CDATA["+CommonUtil.isNull(bean.getGroup_user_group_cd())+"]]></GROUP_USER_GROUP_CD>");
					out.println("<GROUP_USER_GROUP_NM><![CDATA["+CommonUtil.isNull(bean.getGroup_user_group_nm())+"]]></GROUP_USER_GROUP_NM>");
					out.println("<USE_YN><![CDATA["+CommonUtil.isNull(bean.getUse_yn())+"]]></USE_YN>");
										
					out.println("</item>");
				}
				
				out.println("</items>");
			}
			
		}else if(itemGb.equals("groupUserLine")){
			List<CommonBean> itemList = (List)request.getAttribute("itemList");
			if( !(null!=itemList && 0<itemList.size()) ){
				out.println("<items cnt='0' msg='"+CommonUtil.getMessage("DEBUG.06")+"' ></items>");
			}else{
				out.println("<items cnt='"+itemList.size()+"' >");
				
				for( int i=0; i<itemList.size(); i++ ){
					CommonBean bean = itemList.get(i);
					
					out.println("<item>");
					
					out.println("<GROUP_USER_LINE_CD><![CDATA["+CommonUtil.isNull(bean.getGroup_user_line_cd())+"]]></GROUP_USER_LINE_CD>");
					out.println("<GROUP_USER_GROUP_CD><![CDATA["+CommonUtil.isNull(bean.getGroup_user_group_cd())+"]]></GROUP_USER_GROUP_CD>");
					out.println("<APPROVAL_CD><![CDATA["+CommonUtil.isNull(bean.getApproval_cd())+"]]></APPROVAL_CD>");
					out.println("<APPROVAL_NM><![CDATA["+CommonUtil.isNull(bean.getApproval_nm())+"]]></APPROVAL_NM>");
					out.println("<DUTY_NM><![CDATA["+CommonUtil.isNull(bean.getDuty_nm())+"]]></DUTY_NM>");
					out.println("<DEPT_NM><![CDATA["+CommonUtil.isNull(bean.getDept_nm())+"]]></DEPT_NM>");	
					out.println("<USER_CD><![CDATA["+CommonUtil.isNull(bean.getUser_cd())+"]]></USER_CD>");
					out.println("<USER_ID><![CDATA["+CommonUtil.isNull(bean.getUser_id())+"]]></USER_ID>");
					out.println("<USER_HP><![CDATA["+CommonUtil.isNull(bean.getUser_hp())+"]]></USER_HP>");

					out.println("</item>");
				}
				
				out.println("</items>");
			}
		}else if(itemGb.equals("alarmInfo")){
			List<UserBean> itemList = (List)request.getAttribute("itemList");
			if( !(null!=itemList && 0<itemList.size()) ){
				out.println("<items cnt='0' msg='"+CommonUtil.getMessage("DEBUG.06")+"' ></items>");
			}else{
				out.println("<items cnt='"+itemList.size()+"' >");
				
				for( int i=0; i<itemList.size(); i++ ){
					UserBean bean = itemList.get(i);
															
					out.println("<item>");
					
					out.println("<ALARM_STANDARD><![CDATA["+CommonUtil.isNull(bean.getAlarm_standard())+"]]></ALARM_STANDARD>");
					out.println("<ALARM_MIN><![CDATA["+CommonUtil.isNull(bean.getAlarm_min())+"]]></ALARM_MIN>");	
					out.println("<ALARM_MAX><![CDATA["+CommonUtil.isNull(bean.getAlarm_max())+"]]></ALARM_MAX>");
					out.println("<ALARM_UNIT><![CDATA["+CommonUtil.isNull(bean.getAlarm_unit())+"]]></ALARM_UNIT>");
					out.println("<ALARM_TIME><![CDATA["+CommonUtil.isNull(bean.getAlarm_time())+"]]></ALARM_TIME>");	
					out.println("<ALARM_OVER><![CDATA["+CommonUtil.isNull(bean.getAlarm_over())+"]]></ALARM_OVER>");
					out.println("<ALARM_OVER_TIME><![CDATA["+CommonUtil.isNull(bean.getAlarm_over_time())+"]]></ALARM_OVER_TIME>");
																												
					out.println("</item>");
				}
				out.println("</items>");
				
			}
		}else if (itemGb.equals("ctmHostList")) {
			List<CommonBean> itemList = (List)request.getAttribute("itemList");
			
			if( !(null!=itemList && 0<itemList.size()) ) {
				out.println("<items cnt='0' msg='"+CommonUtil.getMessage("DEBUG.06")+"' ></items>");
			} else {
				out.println("<items cnt='"+itemList.size()+"' >");
				
				for( int i=0; i<itemList.size(); i++ ){
					CommonBean bean = itemList.get(i);
					
					String strHostName			= CommonUtil.isNull(bean.getNodeid());
					String strAgstat			= CommonUtil.isNull(bean.getAgstat());
					
					out.println("<item>");
					out.println("<hostname><![CDATA["+strHostName+"]]></hostname>");
					out.println("<agstat><![CDATA["+strAgstat+"]]></agstat>");
					out.println("</item>");
				}
				
				out.println("</items>");			
			}
		}else if (itemGb.equals("emOwnerList")) {
			List<CommonBean> itemList = (List)request.getAttribute("itemList");
			
			if( !(null!=itemList && 0<itemList.size()) ) {
				out.println("<items cnt='0' msg='"+CommonUtil.getMessage("DEBUG.06")+"' ></items>");
			} else {
				out.println("<items cnt='"+itemList.size()+"' >");
				
				for( int i=0; i<itemList.size(); i++ ){
					CommonBean bean = itemList.get(i);
					
					String strNodeId	= CommonUtil.isNull(bean.getNode_id());
					String strOwner		= CommonUtil.isNull(bean.getOwner());
					String strHostCd	= CommonUtil.isNull(bean.getHost_cd());
					
					out.println("<item>");
					out.println("<node_id><![CDATA["+strNodeId+"]]></node_id>");
					out.println("<owner><![CDATA["+strOwner+"]]></owner>");
					out.println("<host_cd><![CDATA["+strHostCd+"]]></host_cd>");
					out.println("</item>");
				}
				
				out.println("</items>");			
			}
		}else if(itemGb.equals("batchReport")){
			List<BatchResultTotalBean> itemList = (List)request.getAttribute("itemList");
			if( !(null!=itemList && 0<itemList.size()) ){
				out.println("<items cnt='0' msg='"+CommonUtil.getMessage("DEBUG.06")+"' ></items>");
			}else{
				out.println("<items cnt='"+itemList.size()+"' >");
				
				for( int i=0; i<itemList.size(); i++ ){
					BatchResultTotalBean bean = itemList.get(i);					
					
					String strDataCenter 		= CommonUtil.isNull(bean.getData_center());
					String strTableName 		= CommonUtil.isNull(bean.getTable_name());
					String strApplication 		= CommonUtil.isNull(bean.getApplication());
					String strGroupName 		= CommonUtil.isNull(bean.getGroup_name());
					String strOdate 			= CommonUtil.isNull(bean.getOdate());
					String strOkCnt 			= CommonUtil.isNull(bean.getOk_cnt());
					String strNotOkCnt 			= CommonUtil.isNull(bean.getNot_ok_cnt());
					String strExceCnt 			= CommonUtil.isNull(bean.getExec_cnt());
					String strWaitUserCnt 		= CommonUtil.isNull(bean.getWait_user_cnt());
					String strWaitResourceCnt 	= CommonUtil.isNull(bean.getWait_resource_cnt());
					String strWaitHostCnt 		= CommonUtil.isNull(bean.getWait_host_cnt());
					String strWaitConditionCnt 	= CommonUtil.isNull(bean.getWait_condition_cnt());
					String strDeleteCnt 		= CommonUtil.isNull(bean.getDelete_cnt());
					String strTotalCnt	 		= CommonUtil.isNull(bean.getTotal_cnt());

					out.println("<item>");
					
					out.println("<data_center><![CDATA["+strDataCenter+"]]></data_center>");
					out.println("<table_name><![CDATA["+strTableName+"]]></table_name>");
					out.println("<application><![CDATA["+strApplication+"]]></application>");
					out.println("<group_name><![CDATA["+strGroupName+"]]></group_name>");
					out.println("<odate><![CDATA["+strOdate+"]]></odate>");
					out.println("<total_cnt><![CDATA["+strTotalCnt+"]]></total_cnt>");
					out.println("<ok_cnt><![CDATA["+strOkCnt+"]]></ok_cnt>");
					out.println("<not_ok_cnt><![CDATA["+strNotOkCnt+"]]></not_ok_cnt>");
					out.println("<exec_cnt><![CDATA["+strExceCnt+"]]></exec_cnt>");
					out.println("<wait_user_cnt><![CDATA["+strWaitUserCnt+"]]></wait_user_cnt>");
					out.println("<wait_resource_cnt><![CDATA["+strWaitResourceCnt+"]]></wait_resource_cnt>");
					out.println("<wait_host_cnt><![CDATA["+strWaitHostCnt+"]]></wait_host_cnt>");
					out.println("<wait_condition_cnt><![CDATA["+strWaitConditionCnt+"]]></wait_condition_cnt>");
					out.println("<delete_cnt><![CDATA["+strDeleteCnt+"]]></delete_cnt>");

					out.println("</item>");
				}
				
				out.println("</items>");			
			}

		}
	}
%> 

</doc>

