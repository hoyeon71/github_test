<%@page import="com.ghayoun.ezjobs.t.domain.ActiveJobBean"%>
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
		if(itemGb.equals("emDefJobs")){
			List<com.ghayoun.ezjobs.m.domain.DefJobBean> itemList = (List)request.getAttribute("itemList");
			if( !(null!=itemList && 0<itemList.size()) ){
				out.println("<items cnt='0' msg='"+CommonUtil.getMessage("DEBUG.06")+"' ></items>");
			}else{
				out.println("<items cnt='"+itemList.size()+"' >");
				
				for( int i=0; i<itemList.size(); i++ ){
					com.ghayoun.ezjobs.m.domain.DefJobBean bean = itemList.get(i);
					
					out.println("<item>");
					
					out.println("<SCHED_TABLE><![CDATA["+CommonUtil.isNull(bean.getSched_table())+"]]></SCHED_TABLE>");
					out.println("<APPLICATION><![CDATA["+CommonUtil.isNull(bean.getApplication())+"]]></APPLICATION>");
					out.println("<GROUP_NAME><![CDATA["+CommonUtil.isNull(bean.getGroup_name())+"]]></GROUP_NAME>");
					out.println("<JOB_NAME><![CDATA["+CommonUtil.isNull(bean.getJob_name())+"]]></JOB_NAME>");
					out.println("<MEM_NAME><![CDATA["+CommonUtil.isNull(bean.getMemname())+"]]></MEM_NAME>");
					out.println("<USER_NM><![CDATA["+CommonUtil.isNull(bean.getUser_nm())+"]]></USER_NM>");
					out.println("<MANAGER_NM><![CDATA["+CommonUtil.isNull(bean.getUser_nm_2())+"]]></MANAGER_NM>");
					out.println("<NODE_GRP><![CDATA["+CommonUtil.isNull(bean.getNode_grp())+"]]></NODE_GRP>");
					out.println("<CYCLIC><![CDATA["+CommonUtil.isNull(bean.getCyclic())+"]]></CYCLIC>");
					out.println("<FROM_TIME><![CDATA["+CommonUtil.isNull(bean.getFrom_time())+"]]></FROM_TIME>");
					out.println("<ERROR_DESCRIPTION><![CDATA["+CommonUtil.isNull(bean.getError_description())+"]]></ERROR_DESCRIPTION>");
					out.println("<DESCRIPTION><![CDATA["+CommonUtil.isNull(bean.getDescription())+"]]></DESCRIPTION>");
					out.println("<INS_DATE><![CDATA["+CommonUtil.isNull(bean.getIns_date())+"]]></INS_DATE>");
					out.println("<JOB_ID><![CDATA["+CommonUtil.isNull(bean.getJob_id())+"]]></JOB_ID>");
					out.println("<TABLE_ID><![CDATA["+CommonUtil.isNull(bean.getTable_id())+"]]></TABLE_ID>");
					out.println("<AUTHOR><![CDATA["+CommonUtil.isNull(bean.getAuthor())+"]]></AUTHOR>");
					out.println("<TASK_TYPE><![CDATA["+CommonUtil.isNull(bean.getTask_type())+"]]></TASK_TYPE>");
					out.println("<JOBSCHEDGB><![CDATA["+CommonUtil.isNull(bean.getJobSchedGb())+"]]></JOBSCHEDGB>");
					out.println("<WHEN_COND><![CDATA["+CommonUtil.isNull(bean.getWhen_cond())+"]]></WHEN_COND>");
					out.println("<SHOUT_TIME><![CDATA["+CommonUtil.isNull(bean.getShout_time())+"]]></SHOUT_TIME>");
														
					out.println("</item>");
				}
				out.println("</items>");				
			}
		}else if(itemGb.equals("preJobMissMatch")){
			List<PreJobMissMatchBean> itemList = (List)request.getAttribute("itemList");
			if( !(null!=itemList && 0<itemList.size()) ){
				out.println("<items cnt='0' msg='"+CommonUtil.getMessage("DEBUG.06")+"' ></items>");
			}else{
				out.println("<items cnt='"+itemList.size()+"' >");
				
				for( int i=0; i<itemList.size(); i++ ){
					PreJobMissMatchBean bean = itemList.get(i);
					
					out.println("<item>");
					
					out.println("<ORDER_TABLE><![CDATA["+CommonUtil.isNull(bean.getOrder_table())+"]]></ORDER_TABLE>");
					out.println("<APPLICATION><![CDATA["+CommonUtil.isNull(bean.getApplication())+"]]></APPLICATION>");
					out.println("<GROUP_NAME><![CDATA["+CommonUtil.isNull(bean.getGroup_name())+"]]></GROUP_NAME>");					
					out.println("<JOB_NAME><![CDATA["+CommonUtil.E2K(bean.getJob_name(), bean.getMemname())+"]]></JOB_NAME>");
					out.println("<MEM_NAME><![CDATA["+CommonUtil.isNull(bean.getMemname())+"]]></MEM_NAME>");
					out.println("<CONDITION><![CDATA["+CommonUtil.E2K(bean.getCondition(),"&nbsp;")+"]]></CONDITION>");
																			
					out.println("</item>");
				}
				out.println("</items>");
				
			}
		}else if(itemGb.equals("preDateBatchScheduleList")){
			List<PreDateBatchScheduleBean> itemList = (List)request.getAttribute("itemList");
			if( !(null!=itemList && 0<itemList.size()) ){
				out.println("<items cnt='0' msg='"+CommonUtil.getMessage("DEBUG.06")+"' ></items>");
			}else{
				out.println("<items cnt='"+itemList.size()+"' >");
				
				for( int i=0; i<itemList.size(); i++ ){
					PreDateBatchScheduleBean bean = itemList.get(i);
					
					out.println("<item>");
					out.println("<DATA_CENTER_NAME><![CDATA["+CommonUtil.isNull(bean.getData_center_name())+"]]></DATA_CENTER_NAME>");
					out.println("<DEVELOPER><![CDATA["+CommonUtil.isNull(bean.getDeveloper())+"]]></DEVELOPER>");
					out.println("<SCHED_TABLE><![CDATA["+CommonUtil.isNull(bean.getSched_table())+"]]></SCHED_TABLE>");
					out.println("<APPLICATION><![CDATA["+CommonUtil.isNull(bean.getApplication())+"]]></APPLICATION>");
					out.println("<GROUP_NAME><![CDATA["+CommonUtil.isNull(bean.getGroup_name())+"]]></GROUP_NAME>");					
					out.println("<JOB_NAME><![CDATA["+CommonUtil.isNull(bean.getJob_name())+"]]></JOB_NAME>");
					out.println("<DAYS_CAL><![CDATA["+CommonUtil.isNull(bean.getDays_cal())+"]]></DAYS_CAL>");
					out.println("<FROM_TIME><![CDATA["+CommonUtil.isNull(bean.getFrom_time())+"]]></FROM_TIME>");
					out.println("<ODATE><![CDATA["+CommonUtil.isNull(bean.getOdate())+"]]></ODATE>");
					out.println("<DESCRIPTION><![CDATA["+CommonUtil.E2K(bean.getDescription(),"&nbsp;")+"]]></DESCRIPTION>");
					out.println("<GUBUN><![CDATA["+CommonUtil.isNull(bean.getGubun())+"]]></GUBUN>");
					out.println("<ORDER_ID><![CDATA["+CommonUtil.isNull(bean.getOrder_id())+"]]></ORDER_ID>");
					out.println("<SMART_JOB_YN><![CDATA["+CommonUtil.isNull(bean.getSmart_job_yn())+"]]></SMART_JOB_YN>");

					out.println("</item>");
				}
				out.println("</items>");
				
			}
		}else if(itemGb.equals("preDateBatchScheduleOrder2")){
			List<PreDateBatchScheduleBean> itemList = (List)request.getAttribute("itemList");
			if( !(null!=itemList && 0<itemList.size()) ){
				out.println("<items cnt='0' msg='"+CommonUtil.getMessage("DEBUG.06")+"' ></items>");
			}else{
				out.println("<items cnt='"+itemList.size()+"' >");
				
				for( int i=0; i<itemList.size(); i++ ){
					PreDateBatchScheduleBean bean = itemList.get(i);
					
					out.println("<item>");
					out.println("<DATA_CENTER><![CDATA["+CommonUtil.isNull(bean.getData_center_name())+"]]></DATA_CENTER>");
					out.println("<JOB_NAME><![CDATA["+CommonUtil.isNull(bean.getJob_name())+"]]></JOB_NAME>");
					out.println("<ODATE><![CDATA["+CommonUtil.isNull(bean.getOdate())+"]]></ODATE>");
					out.println("</item>");
				}
				out.println("</items>");
				
			}
		}else if(itemGb.equals("jobLogList")){
			List<JobLogBean> itemList = (List)request.getAttribute("itemList");
			if( !(null!=itemList && 0<itemList.size()) ){
				out.println("<items cnt='0' msg='"+CommonUtil.getMessage("DEBUG.06")+"' ></items>");
			}else{
				out.println("<items cnt='"+itemList.size()+"' >");
				
				for( int i=0; i<itemList.size(); i++ ){
					JobLogBean bean = itemList.get(i);
					
					String from_time = CommonUtil.isNull(bean.getFrom_time());
					if(!from_time.equals("")){
						from_time = from_time.substring(0,2)+":"+from_time.substring(2,4);
					}
					
					String end_time = CommonUtil.isNull(CommonUtil.getDateFormat(1,CommonUtil.isNull(bean.getEnd_time())),"-");
					String end_date = end_time.length() > 8 ? end_time.substring(0,8) : end_time;
					
					String pop_gb = "";
					String color = CommonUtil.getMessage("JOB_STATUS_COLOR."+CommonUtil.isNull(bean.getState_result()).replaceAll(" ","_"));
					String state_result = "";
					String state_result2 = "";
					if(CommonUtil.isNull(bean.getHoldflag()).equals("Y")){
						state_result2 += "<span style='color:red'>[HOLD]</span>";
					}
										
					if( CommonUtil.isNull(bean.getActive_gb()).equals("1") && CommonUtil.isNull(bean.getState_result(), "").equals("Wait Condition") || CommonUtil.isNull(bean.getState_result(), "").equals("Wait Time") ){
						state_result += "<font color='"+color+"'>"+CommonUtil.getMessage("JOB_STATUS."+CommonUtil.isNull(bean.getState_result()).replaceAll(" ","_"))+"</font>";
						state_result += state_result2;
						pop_gb = "wait";
					}else{
						state_result += "<font color='"+color+"'>"+CommonUtil.getMessage("JOB_STATUS."+CommonUtil.isNull(bean.getState_result()).replaceAll(" ","_"))+"</font>";
						state_result += state_result2;
						pop_gb = "job";
					}
					
					String mem_name = "";
					if(CommonUtil.isNull(bean.getMemname()).equals("")){
						mem_name = "CMD";
					}else{
						mem_name = CommonUtil.isNull(bean.getMemname());
					}
					
					String strOrderTable	= CommonUtil.isNull(bean.getOrder_table());
					String strApplication 	= CommonUtil.isNull(bean.getApplication());
					String strGroupName 	= CommonUtil.isNull(bean.getGroup_name());
					String strDeptNm 		= CommonUtil.isNull(bean.getDept_nm());
					String strJobschedgb	= CommonUtil.isNull(bean.getJobschedgb());
					
					System.out.println("strGroupName : " + strGroupName);
					
					out.println("<item>");
					
					out.println("<ODATE><![CDATA["+CommonUtil.getDateFormat(1,"20"+CommonUtil.isNull(bean.getOdate()))+"]]></ODATE>");
					out.println("<START_TIME><![CDATA["+CommonUtil.isNull(CommonUtil.getDateFormat(1,CommonUtil.isNull(bean.getStart_time())),"-")+"]]></START_TIME>");
					out.println("<END_TIME><![CDATA["+CommonUtil.isNull(CommonUtil.getDateFormat(1,CommonUtil.isNull(bean.getEnd_time())),"-")+"]]></END_TIME>");					
					out.println("<RUN_TIME><![CDATA["+CommonUtil.isNull(CommonUtil.getDiffTime( CommonUtil.getDateFormat(1, bean.getStart_time()), CommonUtil.getDateFormat(1,bean.getEnd_time())))+"]]></RUN_TIME>");
					out.println("<DIFF_TIME><![CDATA["+CommonUtil.isNull(bean.getAvg_run_time())+"]]></DIFF_TIME>");
					out.println("<RUN_CNT><![CDATA["+CommonUtil.isNull(bean.getRerun_counter(),"0")+"]]></RUN_CNT>");
					out.println("<USER_NM><![CDATA["+CommonUtil.isNull(bean.getUser_nm())+"]]></USER_NM>");
					out.println("<JOB_NAME><![CDATA["+CommonUtil.isNull(bean.getJob_name())+"]]></JOB_NAME>");
					out.println("<DESCRIPTION><![CDATA["+CommonUtil.isNull(bean.getDescription())+"]]></DESCRIPTION>");
					out.println("<NODE_ID><![CDATA["+CommonUtil.isNull(bean.getNode_id())+"]]></NODE_ID>");
					out.println("<NODE_GROUP><![CDATA["+CommonUtil.isNull(bean.getNode_group())+"]]></NODE_GROUP>");
					out.println("<STATE_RESULT><![CDATA["+state_result+"]]></STATE_RESULT>");
					out.println("<FROM_TIME><![CDATA["+from_time+"]]></FROM_TIME>");
					out.println("<ORDER_ID><![CDATA["+CommonUtil.isNull(bean.getOrder_id())+"]]></ORDER_ID>");
					out.println("<HOLD_FLAG><![CDATA["+CommonUtil.isNull(bean.getHoldflag())+"]]></HOLD_FLAG>");
					out.println("<ACTIVE_GB><![CDATA["+CommonUtil.isNull(bean.getActive_gb())+"]]></ACTIVE_GB>");
					out.println("<MEM_NAME><![CDATA["+mem_name+"]]></MEM_NAME>");
					out.println("<ORI_STATE_RESULT><![CDATA["+CommonUtil.isNull(bean.getState_result())+"]]></ORI_STATE_RESULT>");
					out.println("<POP_GB><![CDATA["+pop_gb+"]]></POP_GB>");
					out.println("<END_DATE><![CDATA["+end_date+"]]></END_DATE>");
					out.println("<TABLE_NAME><![CDATA["+strOrderTable+"]]></TABLE_NAME>");
					out.println("<APPLICATION><![CDATA["+strApplication+"]]></APPLICATION>");
					out.println("<GROUP_NAME><![CDATA["+strGroupName+"]]></GROUP_NAME>");
					out.println("<DEPT_NM><![CDATA["+strDeptNm+"]]></DEPT_NM>");
					out.println("<JOBSCHEDGB><![CDATA["+strJobschedgb+"]]></JOBSCHEDGB>");
																							
					out.println("</item>");
				}
				out.println("</items>");
				
			}
		}else if(itemGb.equals("resourceList")){
			List<CommonBean> itemList = (List)request.getAttribute("itemList");
			if( !(null!=itemList && 0<itemList.size()) ){
				out.println("<items cnt='0' msg='"+CommonUtil.getMessage("DEBUG.06")+"' ></items>");
			}else{
				out.println("<items cnt='"+itemList.size()+"' >");
				
				for( int i=0; i<itemList.size(); i++ ){
					CommonBean bean = itemList.get(i);
															
					out.println("<item>");
					
					out.println("<QRSNAME><![CDATA["+CommonUtil.isNull(bean.getQresname())+"]]></QRSNAME>");
					out.println("<TOTAL><![CDATA["+CommonUtil.isNull(bean.getQrtotal())+"]]></TOTAL>");
					out.println("<USED><![CDATA["+CommonUtil.isNull(bean.getQrused(), "0")+"]]></USED>"); 
					
					out.println("</item>");
				}
				out.println("</items>");
				
			}
		}else if(itemGb.equals("activeJobList")){
			
			List<com.ghayoun.ezjobs.t.domain.ActiveJobBean> itemList = (List)request.getAttribute("itemList");
			if( !(null!=itemList && 0<itemList.size()) ){
				out.println("<items cnt='0' msg='"+CommonUtil.getMessage("DEBUG.06")+"' ></items>");
			}else{
				out.println("<items cnt='"+(itemList.size()-1)+"' total='"+itemList.get(itemList.size()-1)+"'  >");
				//out.println("<items total='"+itemList.get(itemList.size()-1)+"' >");
				for( int i=0; i<itemList.size()-1; i++ ){
					com.ghayoun.ezjobs.t.domain.ActiveJobBean bean = itemList.get(i);
										
					String end_time 		= CommonUtil.isNull(CommonUtil.getDateFormat(1,CommonUtil.isNull(bean.getEnd_time())),"-");
					String end_date		 	= end_time.length() > 8 ? end_time.substring(0,8) : end_time;
					String from_time 		= CommonUtil.isNull(bean.getTime_from());
					String strDeptNm 		= CommonUtil.isNull(bean.getDept_nm());
					String strJobschedgb 	= CommonUtil.isNull(bean.getJobschedgb());
					
					String pop_gb = "";

					String color = CommonUtil.getMessage("JOB_STATUS_COLOR."+CommonUtil.isNull(bean.getState_result()).replaceAll(" ","_"));
					String state_result = "";
					String state_result2 = "";
					String state_result3 = CommonUtil.getMessage("JOB_STATUS."+CommonUtil.isNull(bean.getStatus()).replaceAll(" ","_"));
					//if(CommonUtil.isNull(bean.getHoldflag()).equals("Y")){
						//state_result2 += "<img src='/imgs/icon/hold.png' width='13'>["+CommonUtil.isNull(bean.getState_result2())+"]";
					//}

					if( CommonUtil.isNull(bean.getState_result(), "").equals("Wait Condition") || CommonUtil.isNull(bean.getState_result(), "").equals("Wait Time") ){
						state_result += "<font color='"+color+"'>"+CommonUtil.getMessage("JOB_STATUS."+CommonUtil.isNull(bean.getState_result()).replaceAll(" ","_"))+"</font>";
						pop_gb = "wait";
					}else{
						state_result += "<font color='"+color+"'>"+CommonUtil.getMessage("JOB_STATUS."+CommonUtil.isNull(bean.getState_result()).replaceAll(" ","_"))+"</font>";
						pop_gb = "job";
					}

					if(CommonUtil.isNull(bean.getHoldflag()).equals("Y")){
						color = CommonUtil.getMessage("JOB_STATUS_COLOR."+CommonUtil.isNull(bean.getStatus()).replaceAll(" ","_"));
						state_result2 = "<font color='"+color+"'>"+CommonUtil.getMessage("JOB_STATUS."+CommonUtil.isNull(bean.getStatus().replaceAll(" ","_")))+"</font>";
						state_result = "<img src='/imgs/icon/hold.png' width='13'> "+state_result2 ;
					}

					String mem_name = "";
					if(CommonUtil.isNull(bean.getMemname()).equals("")){
						mem_name = "CMD";
					}else{
						mem_name = CommonUtil.isNull(bean.getMemname());
					}

					if(!from_time.equals("")){
						from_time = from_time.substring(0,2)+":"+from_time.substring(2,4);
					}

					out.println("<item>");

					out.println("<ODATE><![CDATA["+CommonUtil.getDateFormat(1,"20"+CommonUtil.isNull(bean.getOdate()))+"]]></ODATE>");
					out.println("<START_TIME><![CDATA["+CommonUtil.isNull(CommonUtil.getDateFormat(1,CommonUtil.isNull(bean.getStart_time())),"-")+"]]></START_TIME>");
					out.println("<END_TIME><![CDATA["+CommonUtil.isNull(CommonUtil.getDateFormat(1,CommonUtil.isNull(bean.getEnd_time())),"-")+"]]></END_TIME>");
					out.println("<RUN_TIME><![CDATA["+CommonUtil.isNull(CommonUtil.getDiffTime( CommonUtil.getDateFormat(1, bean.getStart_time()), CommonUtil.getDateFormat(1,bean.getEnd_time())))+"]]></RUN_TIME>");
					out.println("<DIFF_TIME><![CDATA["+CommonUtil.isNull(CommonUtil.getDiffTime( CommonUtil.getDateFormat(1, bean.getStart_time()), CommonUtil.getDateFormat(1,bean.getEnd_time())))+"]]></DIFF_TIME>");
					out.println("<RUN_CNT><![CDATA["+CommonUtil.isNull(bean.getRerun_counter(),"0")+"]]></RUN_CNT>");
					out.println("<JOB_NAME><![CDATA["+CommonUtil.isNull(bean.getJob_name())+"]]></JOB_NAME>");
					out.println("<USER_NM><![CDATA["+CommonUtil.isNull(bean.getUser_nm())+"]]></USER_NM>");
					out.println("<DESCRIPTION><![CDATA["+CommonUtil.isNull(bean.getDescription())+"]]></DESCRIPTION>");
					out.println("<CYCLIC><![CDATA["+CommonUtil.isNull(bean.getCyclic())+"]]></CYCLIC>");
					out.println("<TASK_TYPE><![CDATA["+CommonUtil.isNull(bean.getTask_type())+"]]></TASK_TYPE>");
					out.println("<RBA><![CDATA["+CommonUtil.isNull(bean.getRba())+"]]></RBA>");
					out.println("<NODE_ID><![CDATA["+CommonUtil.isNull(bean.getNode_id())+"]]></NODE_ID>");
					out.println("<CALENDAR_NM><![CDATA["+CommonUtil.isNull(bean.getCalendar_nm())+"]]></CALENDAR_NM>");
					out.println("<STATE_RESULT><![CDATA["+state_result+"]]></STATE_RESULT>");
					out.println("<STATE_RESULT3><![CDATA["+state_result3+"]]></STATE_RESULT3>");
					out.println("<ORDER_ID><![CDATA["+CommonUtil.isNull(bean.getOrder_id())+"]]></ORDER_ID>");
					out.println("<HOLD_FLAG><![CDATA["+CommonUtil.isNull(bean.getHoldflag())+"]]></HOLD_FLAG>");
					out.println("<MEM_NAME><![CDATA["+mem_name+"]]></MEM_NAME>");
					out.println("<ORI_STATE_RESULT><![CDATA["+CommonUtil.isNull(bean.getState_result())+"]]></ORI_STATE_RESULT>");
					out.println("<POP_GB><![CDATA["+pop_gb+"]]></POP_GB>");
					out.println("<END_DATE><![CDATA["+end_date+"]]></END_DATE>");
					out.println("<TABLE_NAME><![CDATA["+CommonUtil.isNull(bean.getOrder_table())+"]]></TABLE_NAME>");
					out.println("<APPLICATION><![CDATA["+CommonUtil.E2K(bean.getApplication())+"]]></APPLICATION>");
					out.println("<GROUP_NAME><![CDATA["+CommonUtil.E2K(bean.getGroup_name())+"]]></GROUP_NAME>");
					out.println("<FROM_TIME><![CDATA["+from_time+"]]></FROM_TIME>");
					out.println("<DEPT_NM><![CDATA["+strDeptNm+"]]></DEPT_NM>");
					out.println("<STATE><![CDATA["+CommonUtil.getMessage("JOB_STATUS."+CommonUtil.isNull(bean.getState_result()).replaceAll(" ","_"))+"]]></STATE>");
					out.println("<JOBSCHEDGB><![CDATA["+strJobschedgb+"]]></JOBSCHEDGB>");
					out.println("<USER_DAILY><![CDATA["+CommonUtil.E2K(bean.getUser_daily())+"]]></USER_DAILY>");
					out.println("<SET_VALUE><![CDATA["+CommonUtil.E2K(bean.getSet_value())+"]]></SET_VALUE>");
					out.println("<AVG_RUN_TIME><![CDATA["+CommonUtil.E2K(bean.getAvg_run_time())+"]]></AVG_RUN_TIME>");
					out.println("<LATE_EXEC><![CDATA["+CommonUtil.E2K(bean.getLate_exec())+"]]></LATE_EXEC>");

					out.println("<USER_ID1><![CDATA["+CommonUtil.isNull(bean.getUser_id())+"]]></USER_ID1>");
					out.println("<USER_ID2><![CDATA["+CommonUtil.isNull(bean.getUser_id2())+"]]></USER_ID2>");
					out.println("<USER_ID3><![CDATA["+CommonUtil.isNull(bean.getUser_id3())+"]]></USER_ID3>");
					out.println("<USER_ID4><![CDATA["+CommonUtil.isNull(bean.getUser_id4())+"]]></USER_ID4>");
					out.println("<USER_ID5><![CDATA["+CommonUtil.isNull(bean.getUser_id5())+"]]></USER_ID5>");
					out.println("<USER_ID6><![CDATA["+CommonUtil.isNull(bean.getUser_id6())+"]]></USER_ID6>");
					out.println("<USER_ID7><![CDATA["+CommonUtil.isNull(bean.getUser_id7())+"]]></USER_ID7>");
					out.println("<USER_ID8><![CDATA["+CommonUtil.isNull(bean.getUser_id8())+"]]></USER_ID8>");
					//out.println("<TOTAL_CNT><![CDATA["+CommonUtil.isNull(bean.getTotal_cnt())+"]]></TOTAL_CNT>");
					
					out.println("<SUSI_CNT><![CDATA["+CommonUtil.isNull(bean.getSusi_cnt())+"]]></SUSI_CNT>");
					/* out.println("<INS_NM1><![CDATA["+CommonUtil.isNull(bean.getIns_nm1())+"]]></INS_NM1>");
					out.println("<APPROVAL_NM1><![CDATA["+CommonUtil.isNull(bean.getApproval_nm1())+"]]></APPROVAL_NM1>");
					out.println("<APPROVAL_NM2><![CDATA["+CommonUtil.isNull(bean.getApproval_nm2())+"]]></APPROVAL_NM2>"); */
					out.println("<APPL_TYPE><![CDATA["+CommonUtil.isNull(bean.getAppl_type())+"]]></APPL_TYPE>");
					out.println("<APPL_FORM><![CDATA["+CommonUtil.isNull(bean.getAppl_form())+"]]></APPL_FORM>");
					out.println("<SMART_JOB_YN><![CDATA["+CommonUtil.isNull(bean.getSmart_job_yn())+"]]></SMART_JOB_YN>");
					
					out.println("</item>");
				}
				
				out.println("</items>");
				
			}
		
		}else if(itemGb.equals("activeJobCntList")){
			
			List<com.ghayoun.ezjobs.t.domain.ActiveJobBean> itemList = (List)request.getAttribute("itemList");
			System.out.println("itemList : ===" + itemList.size());
			if( !(null!=itemList && 0<itemList.size()) ){
				out.println("<items cnt='0' msg='"+CommonUtil.getMessage("DEBUG.06")+"' ></items>");
			}else{
				out.println("<items cnt='"+itemList.size()+"' >"); 
				int cntTotal = 0;
				int runningTotal = 0;
				int waitTotal = 0;
				int successTotal = 0;
				int failTotal = 0;
				
				for( int i=0; i<itemList.size(); i++ ){
					com.ghayoun.ezjobs.t.domain.ActiveJobBean bean = itemList.get(i);
										
					out.println("<item>");
					
					out.println("<SYSTEM_GB><![CDATA["+CommonUtil.isNull(bean.getSystem_gb())+"]]></SYSTEM_GB>");
					out.println("<MCODE_NM><![CDATA["+CommonUtil.isNull(bean.getMcode_nm())+"]]></MCODE_NM>");
					out.println("<TOTAL_CNT><![CDATA["+CommonUtil.isNull(bean.getTotal_cnt())+"]]></TOTAL_CNT>");					
					out.println("<RUNNING_CNT><![CDATA["+CommonUtil.isNull(bean.getRunning_cnt())+"]]></RUNNING_CNT>");
					out.println("<WAIT_CNT><![CDATA["+CommonUtil.isNull(bean.getWait_cnt())+"]]></WAIT_CNT>");
					out.println("<SUCCESS_CNT><![CDATA["+CommonUtil.isNull(bean.getSuccess_cnt())+"]]></SUCCESS_CNT>");
					out.println("<FAIL_CNT><![CDATA["+CommonUtil.isNull(bean.getFail_cnt())+"]]></FAIL_CNT>");
					cntTotal += Integer.parseInt(bean.getTotal_cnt()); 
					runningTotal += Integer.parseInt(bean.getRunning_cnt());
					waitTotal += Integer.parseInt(bean.getWait_cnt());
					successTotal += Integer.parseInt(bean.getSuccess_cnt());
					failTotal += Integer.parseInt(bean.getFail_cnt());
					
					out.println("</item>");
				}
				out.println("<item>");
				out.println("<SYSTEM_GB><![CDATA[[TOTAL]]]></SYSTEM_GB>");
				out.println("<MCODE_NM><![CDATA[-]]></MCODE_NM>");
				out.println("<TOTAL_CNT><![CDATA["+CommonUtil.isNull(cntTotal)+"]]></TOTAL_CNT>");					
				out.println("<RUNNING_CNT><![CDATA["+CommonUtil.isNull(runningTotal)+"]]></RUNNING_CNT>");
				out.println("<WAIT_CNT><![CDATA["+CommonUtil.isNull(waitTotal)+"]]></WAIT_CNT>");
				out.println("<SUCCESS_CNT><![CDATA["+CommonUtil.isNull(successTotal)+"]]></SUCCESS_CNT>");
				out.println("<FAIL_CNT><![CDATA["+CommonUtil.isNull(failTotal)+"]]></FAIL_CNT>");
				out.println("</item>");
				out.println("</items>");
				
			}
		}else if(itemGb.equals("activeJobLogList")){
			List<com.ghayoun.ezjobs.t.domain.ActiveJobBean> itemList = (List)request.getAttribute("itemList");
			if( !(null!=itemList && 0<itemList.size()) ){
				out.println("<items cnt='0' msg='"+CommonUtil.getMessage("DEBUG.06")+"' ></items>");
			}else{
				out.println("<items cnt='"+itemList.size()+"' >");
				
				for( int i=0; i<itemList.size(); i++ ){
					com.ghayoun.ezjobs.t.domain.ActiveJobBean bean = itemList.get(i);
															
					out.println("<item>");
					
					out.println("<JOB_NAME><![CDATA["+CommonUtil.E2K(bean.getJob_name())+"]]></JOB_NAME>");
					out.println("<DESCRIPTION><![CDATA["+CommonUtil.E2K(bean.getDescription())+"]]></DESCRIPTION>");
					out.println("<ORDER_TABLE><![CDATA["+CommonUtil.E2K(bean.getOrder_table())+"]]></ORDER_TABLE>");
					out.println("<APPLICATION><![CDATA["+CommonUtil.E2K(bean.getApplication())+"]]></APPLICATION>");
					out.println("<GROUP_NAME><![CDATA["+CommonUtil.E2K(bean.getGroup_name())+"]]></GROUP_NAME>");
					out.println("<BEFORE_STATUS><![CDATA["+CommonUtil.isNull(bean.getBefore_status())+"]]></BEFORE_STATUS>");
					out.println("<AFTER_STATUS><![CDATA["+CommonUtil.isNull(bean.getAfter_status())+"]]></AFTER_STATUS>");
					out.println("<INS_DATE><![CDATA["+CommonUtil.isNull(bean.getIns_date())+"]]></INS_DATE>");
					out.println("<USER_NM><![CDATA["+CommonUtil.E2K(bean.getUser_nm())+"]]></USER_NM>");
																												
					out.println("</item>");
				}
				out.println("</items>");
				
			}
		}else if(itemGb.equals("jobCondList")){
			List<CtmInfoBean> itemList = (List)request.getAttribute("itemList");
			if( !(null!=itemList && 0<itemList.size()) ){
				out.println("<items cnt='0' msg='"+CommonUtil.getMessage("DEBUG.06")+"' ></items>");
			}else{
				out.println("<items cnt='"+itemList.size()+"' >");
				
				for( int i=0; i<itemList.size(); i++ ){
					CtmInfoBean bean = itemList.get(i);
															
					out.println("<item>");
					
					out.println("<COND_NAME><![CDATA["+CommonUtil.isNull(bean.getCondname())+"]]></COND_NAME>");
					out.println("<COND_DATE><![CDATA["+CommonUtil.isNull(bean.getConddate())+"]]></COND_DATE>");
																												
					out.println("</item>");
				}
				out.println("</items>");
				
			}
		}else if(itemGb.equals("jobCondHistoryList")){
			List<CtmInfoBean> itemList = (List)request.getAttribute("itemList");
			if( !(null!=itemList && 0<itemList.size()) ){
				out.println("<items cnt='0' msg='"+CommonUtil.getMessage("DEBUG.06")+"' ></items>");
			}else{
				out.println("<items cnt='"+itemList.size()+"' >");
				
				for( int i=0; i<itemList.size(); i++ ){
					CtmInfoBean bean = itemList.get(i);
															
					out.println("<item>");
					
					out.println("<COND_NAME><![CDATA["+CommonUtil.isNull(bean.getCondname())+"]]></COND_NAME>");
					out.println("<COND_DATE><![CDATA["+CommonUtil.isNull(bean.getConddate())+"]]></COND_DATE>");
					out.println("<USER_NM><![CDATA["+CommonUtil.isNull(bean.getUser_nm())+"]]></USER_NM>");
					out.println("<INS_DATE><![CDATA["+CommonUtil.isNull(bean.getIns_date())+"]]></INS_DATE>");
																												
					out.println("</item>");
				}
				out.println("</items>");
				
			}
		}else if(itemGb.equals("userList")){
			List<UserBean> itemList = (List)request.getAttribute("itemList");
			if( !(null!=itemList && 0<itemList.size()) ){
				out.println("<items cnt='0' msg='"+CommonUtil.getMessage("DEBUG.06")+"' ></items>");
			}else{
// 				out.println("<items cnt='"+itemList.size()+"' >");
				out.println("<items cnt='"+(itemList.size()-1)+"' total='"+itemList.get(itemList.size()-1)+"'  >");
				for( int i=0; i<itemList.size()-1; i++ ){
					UserBean bean = itemList.get(i);
															
					out.println("<item>");
					
					out.println("<USER_ID><![CDATA["+CommonUtil.isNull(bean.getUser_id())+"]]></USER_ID>");
					out.println("<USER_NM><![CDATA["+CommonUtil.isNull(bean.getUser_nm())+"]]></USER_NM>");
					out.println("<USER_PW><![CDATA["+CommonUtil.isNull(bean.getUser_pw())+"]]></USER_PW>");
					out.println("<USER_GB><![CDATA["+CommonUtil.isNull(bean.getUser_gb())+"]]></USER_GB>");
					out.println("<USER_EMAIL><![CDATA["+CommonUtil.isNull(bean.getUser_email())+"]]></USER_EMAIL>");
					out.println("<USER_HP><![CDATA["+CommonUtil.isNull(bean.getUser_hp())+"]]></USER_HP>");
					out.println("<USER_TEL><![CDATA["+CommonUtil.isNull(bean.getUser_tel())+"]]></USER_TEL>");
					out.println("<DEPT_CD><![CDATA["+CommonUtil.isNull(bean.getDept_cd())+"]]></DEPT_CD>");
					out.println("<DEPT_NM><![CDATA["+CommonUtil.isNull(bean.getDept_nm())+"]]></DEPT_NM>");
					out.println("<DUTY_CD><![CDATA["+CommonUtil.isNull(bean.getDuty_cd())+"]]></DUTY_CD>");
					out.println("<DUTY_NM><![CDATA["+CommonUtil.isNull(bean.getDuty_nm())+"]]></DUTY_NM>");
					out.println("<USER_APPR_GB><![CDATA["+CommonUtil.isNull(bean.getUser_appr_gb())+"]]></USER_APPR_GB>");
					out.println("<DEL_YN><![CDATA["+CommonUtil.isNull(bean.getDel_yn())+"]]></DEL_YN>");
					out.println("<NO_AUTH><![CDATA["+CommonUtil.isNull(bean.getNo_auth())+"]]></NO_AUTH>");
					out.println("<ACCOUNT_LOCK><![CDATA["+CommonUtil.isNull(bean.getAccount_lock())+"]]></ACCOUNT_LOCK>");
					out.println("<INS_DATE><![CDATA["+CommonUtil.isNull(bean.getIns_date())+"]]></INS_DATE>");
					out.println("<USER_CD><![CDATA["+CommonUtil.isNull(bean.getUser_cd())+"]]></USER_CD>");		
					out.println("<SELECT_DCC><![CDATA["+CommonUtil.isNull(bean.getSelect_data_center_code())+"]]></SELECT_DCC>");		
					out.println("<SELECT_TAB><![CDATA["+CommonUtil.isNull(bean.getSelect_table_name())+"]]></SELECT_TAB>");
					out.println("<SELECT_APP><![CDATA["+CommonUtil.isNull(bean.getSelect_application())+"]]></SELECT_APP>");
					out.println("<SELECT_GRP><![CDATA["+CommonUtil.isNull(bean.getSelect_group_name())+"]]></SELECT_GRP>");
					out.println("<ABSENCE_USER_CD><![CDATA["+CommonUtil.isNull(bean.getAbsence_user_cd())+"]]></ABSENCE_USER_CD>");
					out.println("<ABSENCE_USER_NM><![CDATA["+CommonUtil.isNull(bean.getAbsence_user_nm())+"]]></ABSENCE_USER_NM>");
					out.println("<ABSENCE_START_DATE><![CDATA["+CommonUtil.isNull(bean.getAbsence_start_date())+"]]></ABSENCE_START_DATE>");
					out.println("<ABSENCE_END_DATE><![CDATA["+CommonUtil.isNull(bean.getAbsence_end_date())+"]]></ABSENCE_END_DATE>");
					out.println("<ABSENCE_REASON><![CDATA["+CommonUtil.isNull(bean.getAbsence_reason())+"]]></ABSENCE_REASON>");
					out.println("<SELECT_TABLE_NAME><![CDATA["+CommonUtil.isNull(bean.getSelect_table_name())+"]]></SELECT_TABLE_NAME>");
					out.println("<USER_IP><![CDATA["+CommonUtil.isNull(bean.getUser_ip())+"]]></USER_IP>"); 
					out.println("<MAX_LOGIN_DATE><![CDATA["+CommonUtil.isNull(bean.getMax_login_date())+"]]></MAX_LOGIN_DATE>");
																												
					out.println("</item>");
				}
				out.println("</items>");
				
			}
		}else if(itemGb.equals("deptList")){
			List<CompanyBean> itemList = (List)request.getAttribute("itemList");
			if( !(null!=itemList && 0<itemList.size()) ){
				out.println("<items cnt='0' msg='"+CommonUtil.getMessage("DEBUG.06")+"' ></items>");
			}else{
				out.println("<items cnt='"+itemList.size()+"' >");
				
				for( int i=0; i<itemList.size(); i++ ){
					CompanyBean bean = itemList.get(i);
															
					out.println("<item>");
					
					out.println("<DEPT_CD><![CDATA["+CommonUtil.isNull(bean.getDept_cd())+"]]></DEPT_CD>");
					out.println("<DEPT_NM><![CDATA["+CommonUtil.isNull(bean.getDept_nm())+"]]></DEPT_NM>");
					out.println("<INS_DATE><![CDATA["+CommonUtil.isNull(bean.getIns_date())+"]]></INS_DATE>");
																																	
					out.println("</item>");
				}
				out.println("</items>");
				
			}
		}else if(itemGb.equals("dutyList")){
			List<CompanyBean> itemList = (List)request.getAttribute("itemList");
			if( !(null!=itemList && 0<itemList.size()) ){
				out.println("<items cnt='0' msg='"+CommonUtil.getMessage("DEBUG.06")+"' ></items>");
			}else{
				out.println("<items cnt='"+itemList.size()+"' >");
				
				for( int i=0; i<itemList.size(); i++ ){
					CompanyBean bean = itemList.get(i);
															
					out.println("<item>");
					
					out.println("<DUTY_CD><![CDATA["+CommonUtil.isNull(bean.getDuty_cd())+"]]></DUTY_CD>");
					out.println("<DUTY_NM><![CDATA["+CommonUtil.isNull(bean.getDuty_nm())+"]]></DUTY_NM>");
					out.println("<INS_DATE><![CDATA["+CommonUtil.isNull(bean.getIns_date())+"]]></INS_DATE>");
																																	
					out.println("</item>");
				}
				out.println("</items>");
				
			}
		}else if(itemGb.equals("hostList")){
			List<CommonBean> itemList = (List)request.getAttribute("itemList");
			if( !(null!=itemList && 0<itemList.size()) ){
				out.println("<items cnt='0' msg='"+CommonUtil.getMessage("DEBUG.06")+"' ></items>");
			}else{
				out.println("<items cnt='"+itemList.size()+"' >");
				
				for( int i=0; i<itemList.size(); i++ ){
					CommonBean bean = itemList.get(i);
															
					out.println("<item>");
					
					out.println("<HOST_CD><![CDATA["+CommonUtil.isNull(bean.getHost_cd())+"]]></HOST_CD>");
					out.println("<DATA_CENTER><![CDATA["+CommonUtil.isNull(bean.getData_center())+"]]></DATA_CENTER>");
					out.println("<DATA_CENTER_NAME><![CDATA["+CommonUtil.isNull(bean.getData_center_name())+"]]></DATA_CENTER_NAME>");
					out.println("<NODE_ID><![CDATA["+CommonUtil.isNull(bean.getNode_id())+"]]></NODE_ID>");
					out.println("<NODE_NM><![CDATA["+CommonUtil.isNull(bean.getNode_nm())+"]]></NODE_NM>");
					out.println("<AGENT_ID><![CDATA["+CommonUtil.isNull(bean.getAgent_id())+"]]></AGENT_ID>");
					out.println("<AGENT_PW><![CDATA["+CommonUtil.isNull(bean.getAgent_pw())+"]]></AGENT_PW>");
					out.println("<ACCESS_GUBUN><![CDATA["+CommonUtil.isNull(bean.getAccess_gubun())+"]]></ACCESS_GUBUN>");
					out.println("<ACCESS_PORT><![CDATA["+CommonUtil.isNull(bean.getAccess_port())+"]]></ACCESS_PORT>");
					out.println("<FILE_PATH><![CDATA["+CommonUtil.isNull(bean.getFile_path())+"]]></FILE_PATH>");
					out.println("<SERVER_GUBUN><![CDATA["+CommonUtil.isNull(bean.getServer_gubun())+"]]></SERVER_GUBUN>");
					out.println("<SERVER_LANG><![CDATA["+CommonUtil.isNull(bean.getServer_lang())+"]]></SERVER_LANG>");
					out.println("<CERTIFY_GUBUN><![CDATA["+CommonUtil.isNull(bean.getCertify_gubun())+"]]></CERTIFY_GUBUN>");
					
					out.println("</item>");
				}
				out.println("</items>");
				
			}
		}else if(itemGb.equals("databaseList")){
			List<CommonBean> itemList = (List)request.getAttribute("itemList");
			if( !(null!=itemList && 0<itemList.size()) ){
				out.println("<items cnt='0' msg='"+CommonUtil.getMessage("DEBUG.06")+"' ></items>");
			}else{
				out.println("<items cnt='"+itemList.size()+"' >");
				
				for( int i=0; i<itemList.size(); i++ ){
					CommonBean bean = itemList.get(i);
															
					out.println("<item>");
					
					out.println("<DATABASE_CD><![CDATA["+CommonUtil.isNull(bean.getDatabase_cd())+"]]></DATABASE_CD>");
					out.println("<DATA_CENTER><![CDATA["+CommonUtil.isNull(bean.getData_center())+"]]></DATA_CENTER>");
					out.println("<DATA_CENTER_NAME><![CDATA["+CommonUtil.isNull(bean.getData_center_name())+"]]></DATA_CENTER_NAME>");
					out.println("<PROFILE_NAME><![CDATA["+CommonUtil.isNull(bean.getProfile_name())+"]]></PROFILE_NAME>");
					out.println("<DATABASE_TYPE><![CDATA["+CommonUtil.isNull(bean.getDatabase_type())+"]]></DATABASE_TYPE>");
					out.println("<DATABASE_VERSION><![CDATA["+CommonUtil.isNull(bean.getDatabase_version())+"]]></DATABASE_VERSION>");
					out.println("<TYPE><![CDATA["+CommonUtil.isNull(bean.getType())+"]]></TYPE>");
					out.println("<HOST_NM><![CDATA["+CommonUtil.isNull(bean.getHost_nm())+"]]></HOST_NM>");
					out.println("<DATABASE_NAME><![CDATA["+CommonUtil.isNull(bean.getDatabase_name())+"]]></DATABASE_NAME>");
					out.println("<ACCESS_PORT><![CDATA["+CommonUtil.isNull(bean.getAccess_port())+"]]></ACCESS_PORT>");
					out.println("<ACCESS_SID><![CDATA["+CommonUtil.isNull(bean.getAccess_sid())+"]]></ACCESS_SID>");
					out.println("<ACCESS_SERVICE_NAME><![CDATA["+CommonUtil.isNull(bean.getAccess_service_name())+"]]></ACCESS_SERVICE_NAME>");
					out.println("<USER_NM><![CDATA["+CommonUtil.isNull(bean.getUser_nm())+"]]></USER_NM>");
					out.println("<DATABASE_PW><![CDATA["+CommonUtil.isNull(bean.getDatabase_pw())+"]]></DATABASE_PW>");
					
					out.println("</item>");
				}
				out.println("</items>");
				
			}
		}else if(itemGb.equals("sendLogList")){
			List<CommonBean> itemList = (List)request.getAttribute("itemList");
			if( !(null!=itemList && 0<itemList.size()) ){
				out.println("<items cnt='0' msg='"+CommonUtil.getMessage("DEBUG.06")+"' ></items>");
			}else{
				out.println("<items cnt='"+itemList.size()+"' >");
				
				for( int i=0; i<itemList.size(); i++ ){
					CommonBean bean = itemList.get(i);
					
					String strJobschedgb	= CommonUtil.isNull(bean.getJobschedgb());

					String send_desc		= CommonUtil.isNull(bean.getSend_desc());
					String strSend_desc 	= CommonUtil.getMessage("JOB_SEND_STATUS."+send_desc);
					String strSendDescription 	= CommonUtil.isNull(bean.getSend_description());

					out.println("<item>");
					
					out.println("<SEND_CD><![CDATA["+CommonUtil.isNull(bean.getSend_cd())+"]]></SEND_CD>");
					out.println("<DATA_CENTER><![CDATA["+CommonUtil.isNull(bean.getData_center())+"]]></DATA_CENTER>");
					out.println("<DATA_CENTER_NAME><![CDATA["+CommonUtil.isNull(bean.getData_center_name())+"]]></DATA_CENTER_NAME>");
					out.println("<JOB_NAME><![CDATA["+CommonUtil.isNull(bean.getJob_name())+"]]></JOB_NAME>");
					out.println("<ORDER_ID><![CDATA["+CommonUtil.isNull(bean.getOrder_id())+"]]></ORDER_ID>");
					out.println("<SEND_GUBUN><![CDATA["+CommonUtil.isNull(bean.getSend_gubun())+"]]></SEND_GUBUN>");
					out.println("<SEND_GUBUN_NM><![CDATA["+CommonUtil.isNull(bean.getSend_gubun_nm())+"]]></SEND_GUBUN_NM>");
					out.println("<MESSAGE><![CDATA["+CommonUtil.isNull(bean.getMessage())+"]]></MESSAGE>");
					out.println("<USER_NM><![CDATA["+CommonUtil.isNull(bean.getUser_nm())+"]]></USER_NM>");
					out.println("<SEND_DATE><![CDATA["+CommonUtil.isNull(bean.getSend_date())+"]]></SEND_DATE>");
					out.println("<RETURN_CODE><![CDATA["+CommonUtil.isNull(CommonUtil.getMessage("SEND.RETURN."+bean.getReturn_code()))+"]]></RETURN_CODE>");
					//out.println("<RETURN_NUMBER><![CDATA["+CommonUtil.isNull(bean.getReturn_number())+"]]></RETURN_NUMBER>");
					out.println("<RETURN_DATE><![CDATA["+CommonUtil.isNull(bean.getReturn_date())+"]]></RETURN_DATE>");
					out.println("<SEND_INFO><![CDATA["+CommonUtil.isNull(bean.getSend_info())+"]]></SEND_INFO>");
					out.println("<JOBSCHEDGB><![CDATA["+strJobschedgb+"]]></JOBSCHEDGB>");
					out.println("<SEND_DESC><![CDATA["+strSend_desc+"]]></SEND_DESC>");
					out.println("<SEND_DESCRIPTION><![CDATA["+strSendDescription+"]]></SEND_DESCRIPTION>");

					out.println("</item>");
				}
				out.println("</items>");
				
			}
		}else if(itemGb.equals("allDocInfoList")){
			List<DocInfoBean> itemList = (List)request.getAttribute("itemList");
			if( !(null!=itemList && 0<itemList.size()) ){
				out.println("<items cnt='0' msg='"+CommonUtil.getMessage("DEBUG.06")+"' ></items>");
			}else{
				out.println("<items cnt='"+itemList.size()+"' >");
				
				for( int i=0; i<itemList.size(); i++ ){
					DocInfoBean bean = itemList.get(i);
					
					String main_doc_cd_ment = "";
					if(!CommonUtil.isNull(bean.getMain_doc_cd()).equals("")){
						main_doc_cd_ment = "[일괄요청서]";
					}
					
					out.println("<item>");
					
					out.println("<DOC_GROUP_ID><![CDATA["+CommonUtil.isNull(bean.getDoc_group_id())+"]]></DOC_GROUP_ID>");
					out.println("<TASK_TYPE><![CDATA["+CommonUtil.isNull(bean.getTask_type())+"]]></TASK_TYPE>");
					out.println("<MAIN_DOC_CD><![CDATA["+CommonUtil.isNull(bean.getMain_doc_cd())+"]]></MAIN_DOC_CD>");
					out.println("<DOC_CD><![CDATA["+CommonUtil.isNull(bean.getDoc_cd())+"]]></DOC_CD>");
					//out.println("<DOC_GB><![CDATA["+main_doc_cd_ment+CommonUtil.isNull(CommonUtil.getMessage("DOC.GB."+bean.getDoc_gb()))+"]]></DOC_GB>");
					out.println("<DOC_GB><![CDATA["+main_doc_cd_ment+"]]></DOC_GB>");
					out.println("<TITLE><![CDATA["+CommonUtil.isNull(bean.getTitle())+"]]></TITLE>");
					out.println("<JOB_NAME><![CDATA["+CommonUtil.isNull(bean.getJob_name())+"]]></JOB_NAME>");
					out.println("<DESCRIPTION><![CDATA["+CommonUtil.isNull(bean.getDescription())+"]]></DESCRIPTION>");
					out.println("<STATE_CD><![CDATA["+CommonUtil.isNull(bean.getState_cd())+"]]></STATE_CD>");
					out.println("<STATE_NM><![CDATA["+CommonUtil.getMessage("DOC.STATE."+CommonUtil.isNull(bean.getState_cd()))+"]]></STATE_NM>");
					out.println("<DRAFT_DATE><![CDATA["+CommonUtil.getDateFormat(1,CommonUtil.isNull(bean.getDraft_date()),"&nbsp;")+"]]></DRAFT_DATE>");
					out.println("<DEPT_NM><![CDATA["+CommonUtil.isNull(bean.getDept_nm())+"]]></DEPT_NM>");
					out.println("<DEPT_CD><![CDATA["+CommonUtil.isNull(bean.getDept_cd())+"]]></DEPT_CD>");
					out.println("<DUTY_NM><![CDATA["+CommonUtil.isNull(bean.getDuty_nm())+"]]></DUTY_NM>");
					out.println("<DUTY_CD><![CDATA["+CommonUtil.isNull(bean.getDuty_cd())+"]]></DUTY_CD>");
					out.println("<USER_NM><![CDATA["+CommonUtil.isNull(bean.getUser_nm())+"]]></USER_NM>");
					out.println("<USER_CD><![CDATA["+CommonUtil.isNull(bean.getUser_cd())+"]]></USER_CD>");
					
					out.println("</item>");
				}
				
				out.println("</items>");
				
			}
		}else if(itemGb.equals("alertList")){
			List<AlertBean> itemList = (List)request.getAttribute("itemList");
			if( !(null!=itemList && 0<itemList.size()) ){
				out.println("<items cnt='0' msg='"+CommonUtil.getMessage("DEBUG.06")+"' ></items>");
			}else{
				out.println("<items cnt='"+itemList.size()+"' >");
				
				for( int i=0; i<itemList.size(); i++ ){
					AlertBean bean = itemList.get(i);
										
					out.println("<item>");
					
					out.println("<JOB_NAME><![CDATA["+CommonUtil.isNull(bean.getJob_name())+"]]></JOB_NAME>");
					out.println("<MEM_NAME><![CDATA["+CommonUtil.isNull(bean.getMemname())+"]]></MEM_NAME>");
					out.println("<HANDLED_NAME><![CDATA["+CommonUtil.isNull(bean.getHandled_name())+"]]></HANDLED_NAME>");
					out.println("<APPLICATION><![CDATA["+CommonUtil.isNull(bean.getApplication())+"]]></APPLICATION>");
					out.println("<GROUP_NAME><![CDATA["+CommonUtil.isNull(bean.getGroup_name())+"]]></GROUP_NAME>");
					out.println("<SERIAL><![CDATA["+CommonUtil.isNull(bean.getSerial())+"]]></SERIAL>");
					out.println("<CHANGED_BY><![CDATA["+CommonUtil.isNull(bean.getChanged_by())+"]]></CHANGED_BY>");
					out.println("<DESCRIPTION><![CDATA["+CommonUtil.isNull(bean.getDescription())+"]]></DESCRIPTION>");
					out.println("<MESSAGE><![CDATA["+CommonUtil.isNull(bean.getMessage())+"]]></MESSAGE>");
					out.println("<NOTES><![CDATA["+CommonUtil.isNull(bean.getNotes())+"]]></NOTES>");
					out.println("<HOST_TIME><![CDATA["+CommonUtil.isNull(bean.getHost_time())+"]]></HOST_TIME>");
					out.println("<UPD_TIME><![CDATA["+CommonUtil.isNull(bean.getUpd_time())+"]]></UPD_TIME>");
					out.println("<USER_NM><![CDATA["+CommonUtil.isNull(bean.getUser_nm())+"]]></USER_NM>");
					
					out.println("</item>");
				}
				
				out.println("</items>");
				
			}
		}else if(itemGb.equals("alertErrorList")){
			List<AlertBean> itemList = (List)request.getAttribute("itemList");
			if( !(null!=itemList && 0<itemList.size()) ){
				out.println("<items cnt='0' msg='"+CommonUtil.getMessage("DEBUG.06")+"' ></items>");
			}else{
// 				out.println("<items cnt='"+itemList.size()+"' >");
				out.println("<items cnt='"+(itemList.size()-1)+"' total='"+itemList.get(itemList.size()-1)+"'  >");
				
// 				for( int i=0; i<itemList.size(); i++ ){
				for( int i=0; i<itemList.size()-1; i++ ){
					AlertBean bean = itemList.get(i);
						
					String pop_gb = "";
					String color = CommonUtil.getMessage("JOB_STATUS_COLOR."+CommonUtil.isNull(bean.getState_result()).replaceAll(" ","_"));
					String state_result = "";
					String state_result2 = "";
					if(CommonUtil.isNull(bean.getHoldflag()).equals("Y")){
						state_result2 += "<span style='color:red'>["+CommonUtil.isNull(bean.getState_result2())+"]</span>";
					}
										
					if( CommonUtil.isNull(bean.getState_result(), "").equals("Wait Condition") || CommonUtil.isNull(bean.getState_result(), "").equals("Wait Time") ){
						state_result += "<font color='"+color+"'>"+CommonUtil.getMessage("JOB_STATUS."+CommonUtil.isNull(bean.getState_result()).replaceAll(" ","_"))+"</font>";
						state_result += state_result2;
						pop_gb = "wait";
					}else{
						state_result += "<font color='"+color+"'>"+CommonUtil.getMessage("JOB_STATUS."+CommonUtil.isNull(bean.getState_result()).replaceAll(" ","_"))+"</font>";
						state_result += state_result2;
						pop_gb = "job";
					}
					
					String strJobschedgb	= CommonUtil.isNull(bean.getJobschedgb());
					
					out.println("<item>");
					
					out.println("<ALARM_CD><![CDATA["+CommonUtil.isNull(bean.getAlarm_cd())+"]]></ALARM_CD>");
					out.println("<DATA_CENTER><![CDATA["+CommonUtil.isNull(bean.getData_center())+"]]></DATA_CENTER>");
					out.println("<DATA_CENTER_NAME><![CDATA["+CommonUtil.isNull(bean.getData_center_name())+"]]></DATA_CENTER_NAME>");
					out.println("<HOST_TIME><![CDATA["+CommonUtil.isNull(bean.getHost_time())+"]]></HOST_TIME>");
					out.println("<HOST_TIME2><![CDATA["+CommonUtil.isNull(bean.getHost_time2())+"]]></HOST_TIME2>");
					out.println("<APPLICATION><![CDATA["+CommonUtil.isNull(bean.getApplication())+"]]></APPLICATION>");
					out.println("<GROUP_NAME><![CDATA["+CommonUtil.isNull(bean.getGroup_name())+"]]></GROUP_NAME>");
					out.println("<JOB_NAME><![CDATA["+CommonUtil.isNull(CommonUtil.E2K(bean.getJob_name()), CommonUtil.E2K(bean.getMemname()))+"]]></JOB_NAME>");
					out.println("<MEM_NAME><![CDATA["+CommonUtil.isNull(CommonUtil.E2K(bean.getMemname()))+"]]></MEM_NAME>");
					out.println("<RUN_COUNTER><![CDATA["+CommonUtil.isNull(bean.getRun_counter())+"]]></RUN_COUNTER>");
					out.println("<USER_CD><![CDATA["+CommonUtil.isNull(bean.getUser_cd())+"]]></USER_CD>");
					out.println("<USER_NM><![CDATA["+CommonUtil.isNull(bean.getUser_nm())+"]]></USER_NM>");
					
					out.println("<USER_CD1><![CDATA["+CommonUtil.isNull(bean.getUser_cd1())+"]]></USER_CD1>");
					out.println("<USER_NM1><![CDATA["+CommonUtil.isNull(bean.getUser_nm1())+"]]></USER_NM1>");
					
					out.println("<USER_CD2><![CDATA["+CommonUtil.isNull(bean.getUser_cd2())+"]]></USER_CD2>");
					out.println("<USER_NM2><![CDATA["+CommonUtil.isNull(bean.getUser_nm2())+"]]></USER_NM2>");
					
					out.println("<USER_CD3><![CDATA["+CommonUtil.isNull(bean.getUser_cd3())+"]]></USER_CD3>");
					out.println("<USER_NM3><![CDATA["+CommonUtil.isNull(bean.getUser_nm3())+"]]></USER_NM3>");
					
					out.println("<USER_CD4><![CDATA["+CommonUtil.isNull(bean.getUser_cd4())+"]]></USER_CD4>");
					out.println("<USER_NM4><![CDATA["+CommonUtil.isNull(bean.getUser_nm4())+"]]></USER_NM4>");
					
					out.println("<USER_CD5><![CDATA["+CommonUtil.isNull(bean.getUser_cd5())+"]]></USER_CD5>");
					out.println("<USER_NM5><![CDATA["+CommonUtil.isNull(bean.getUser_nm5())+"]]></USER_NM5>");
					
					out.println("<USER_CD6><![CDATA["+CommonUtil.isNull(bean.getUser_cd6())+"]]></USER_CD6>");
					out.println("<USER_NM6><![CDATA["+CommonUtil.isNull(bean.getUser_nm6())+"]]></USER_NM6>");
					
					out.println("<USER_CD7><![CDATA["+CommonUtil.isNull(bean.getUser_cd7())+"]]></USER_CD7>");
					out.println("<USER_NM7><![CDATA["+CommonUtil.isNull(bean.getUser_nm7())+"]]></USER_NM7>");
					
					out.println("<USER_CD8><![CDATA["+CommonUtil.isNull(bean.getUser_cd8())+"]]></USER_CD8>");
					out.println("<USER_NM8><![CDATA["+CommonUtil.isNull(bean.getUser_nm8())+"]]></USER_NM8>");
					
					out.println("<USER_CD9><![CDATA["+CommonUtil.isNull(bean.getUser_cd9())+"]]></USER_CD9>");
					out.println("<USER_NM9><![CDATA["+CommonUtil.isNull(bean.getUser_nm9())+"]]></USER_NM9>");

					out.println("<USER_CD10><![CDATA["+CommonUtil.isNull(bean.getUser_cd10())+"]]></USER_CD10>");
					out.println("<USER_NM10><![CDATA["+CommonUtil.isNull(bean.getUser_nm10())+"]]></USER_NM10>");

					out.println("<GRP_CD1><![CDATA["+CommonUtil.isNull(bean.getGrp_cd1())+"]]></GRP_CD1>");
					out.println("<GRP_CD2><![CDATA["+CommonUtil.isNull(bean.getGrp_cd2())+"]]></GRP_CD2>");
					out.println("<GRP_NM1><![CDATA["+CommonUtil.isNull(bean.getGrp_nm1())+"]]></GRP_NM1>");
					out.println("<GRP_NM2><![CDATA["+CommonUtil.isNull(bean.getGrp_nm2())+"]]></GRP_NM2>");

					out.println("<DEPT_NM><![CDATA["+CommonUtil.isNull(bean.getDept_nm())+"]]></DEPT_NM>");
					out.println("<DUTY_NM><![CDATA["+CommonUtil.isNull(bean.getDuty_nm())+"]]></DUTY_NM>");
					out.println("<CONTACT><![CDATA["+CommonUtil.isNull(bean.getContact())+"]]></CONTACT>");
					out.println("<MESSAGE><![CDATA["+CommonUtil.isNull(bean.getMessage())+"]]></MESSAGE>");
					out.println("<DESCRIPTION><![CDATA["+CommonUtil.isNull(bean.getDescription())+"]]></DESCRIPTION>");
					out.println("<ACTION_YN><![CDATA["+CommonUtil.isNull(bean.getAction_yn(),"N")+"]]></ACTION_YN>");
					out.println("<ACTION_GUBUN><![CDATA["+CommonUtil.isNull(bean.getAction_gubun())+"]]></ACTION_GUBUN>");
					out.println("<UPDATE_TIME><![CDATA["+CommonUtil.isNull(bean.getUpdate_time())+"]]></UPDATE_TIME>");
					out.println("<UPDATE_USER_NM><![CDATA["+CommonUtil.isNull(bean.getUpdate_user_nm())+"]]></UPDATE_USER_NM>");
					out.println("<ACTION_DATE><![CDATA["+CommonUtil.isNull(bean.getAction_date())+"]]></ACTION_DATE>");
					out.println("<RECUR_YN><![CDATA["+CommonUtil.isNull(bean.getRecur_yn(),"N")+"]]></RECUR_YN>");
					out.println("<ERROR_GUBUN><![CDATA["+CommonUtil.isNull(bean.getError_gubun())+"]]></ERROR_GUBUN>");
					out.println("<ERROR_DESCRIPTION><![CDATA["+CommonUtil.isNull(bean.getError_description())+"]]></ERROR_DESCRIPTION>");
					out.println("<SOLUTION_DESCRIPTION><![CDATA["+CommonUtil.isNull(bean.getSolution_description())+"]]></SOLUTION_DESCRIPTION>");
					out.println("<HOST_TIME_MM><![CDATA["+CommonUtil.isNull(bean.getHost_time_mm())+"]]></HOST_TIME_MM>");
					out.println("<HOST_TIME_DD><![CDATA["+CommonUtil.isNull(bean.getHost_time_dd())+"]]></HOST_TIME_DD>");
					out.println("<ORDER_ID><![CDATA["+CommonUtil.isNull(bean.getOrder_id())+"]]></ORDER_ID>");
					
					out.println("<CRITICAL><![CDATA["+CommonUtil.isNull(bean.getCritical())+"]]></CRITICAL>");
					out.println("<STATUS><![CDATA["+CommonUtil.isNull(bean.getStatus())+"]]></STATUS>");
					out.println("<STATE_RESULT><![CDATA["+CommonUtil.isNull(state_result)+"]]></STATE_RESULT>");
					out.println("<JOBSCHEDGB><![CDATA["+strJobschedgb+"]]></JOBSCHEDGB>");
					out.println("<USER_DAILY_YN><![CDATA["+CommonUtil.isNull(bean.getUser_daily_yn())+"]]></USER_DAILY_YN>");
					out.println("<ORDER_TABLE><![CDATA["+CommonUtil.isNull(bean.getOrder_table())+"]]></ORDER_TABLE>");
					out.println("<CONFIRM_TIME><![CDATA["+CommonUtil.isNull(bean.getConfirm_time())+"]]></CONFIRM_TIME>");
					out.println("<CONFIRM_USER_NM><![CDATA["+CommonUtil.isNull(bean.getConfirm_user_nm())+"]]></CONFIRM_USER_NM>");
					out.println("<CONFIRM_YN><![CDATA["+CommonUtil.isNull(bean.getConfirm_yn())+"]]></CONFIRM_YN>");

					out.println("<NODE_ID><![CDATA["+CommonUtil.isNull(bean.getNode_id())+"]]></NODE_ID>");
					out.println("<MEM_LIB><![CDATA["+CommonUtil.isNull(bean.getMem_lib())+"]]></MEM_LIB>");
					
					out.println("<OWNER><![CDATA["+CommonUtil.isNull(bean.getOwner())+"]]></OWNER>");
					out.println("<TASK_TYPE><![CDATA["+CommonUtil.isNull(bean.getTask_type())+"]]></TASK_TYPE>");
					out.println("<COMMAND><![CDATA["+CommonUtil.isNull(bean.getCommand())+"]]></COMMAND>");
					out.println("<RERUN_MAX><![CDATA["+CommonUtil.isNull(bean.getRerun_max())+"]]></RERUN_MAX>");
					out.println("<MAX_WAIT><![CDATA["+CommonUtil.isNull(bean.getMax_wait())+"]]></MAX_WAIT>");
					out.println("<CYCLIC><![CDATA["+CommonUtil.isNull(bean.getCyclic())+"]]></CYCLIC>");
					
					out.println("<TIME_FROM><![CDATA["+CommonUtil.isNull(bean.getTime_from())+"]]></TIME_FROM>");
					out.println("<TIME_UNTIL><![CDATA["+CommonUtil.isNull(bean.getTime_until())+"]]></TIME_UNTIL>");
					out.println("<CYCLIC_TYPE><![CDATA["+CommonUtil.isNull(bean.getCyclic_type())+"]]></CYCLIC_TYPE>");
					out.println("<RERUN_INTERVAL><![CDATA["+CommonUtil.isNull(bean.getRerun_interval())+"]]></RERUN_INTERVAL>");
					out.println("<SPECIFIC_TIMES><![CDATA["+CommonUtil.isNull(bean.getSpecific_times())+"]]></SPECIFIC_TIMES>");
					out.println("<RUN_CNT><![CDATA["+CommonUtil.isNull(bean.getRerun_counter())+"]]></RUN_CNT>");
					out.println("<ODATE><![CDATA["+CommonUtil.getDateFormat(1,"20"+CommonUtil.isNull(bean.getOdate()))+"]]></ODATE>");

					out.println("<APPROVAL_YN><![CDATA["+CommonUtil.isNull(bean.getApproval_yn())+"]]></APPROVAL_YN>");
					out.println("<SMART_JOB_YN><![CDATA["+CommonUtil.isNull(bean.getSmart_job_yn())+"]]></SMART_JOB_YN>");

					out.println("</item>");
				}
				
				out.println("</items>");
				
			}
		}else if(itemGb.equals("batchResultTotal")){
			List<BatchResultTotalBean> itemList = (List)request.getAttribute("itemList");
			if( !(null!=itemList && 0<itemList.size()) ){
				out.println("<items cnt='0' msg='"+CommonUtil.getMessage("DEBUG.06")+"' ></items>");
			}else{
				out.println("<items cnt='"+itemList.size()+"' >");
				
				for( int i=0; i<itemList.size(); i++ ){
					BatchResultTotalBean bean = itemList.get(i);
										
					out.println("<item>");
					
					out.println("<GROUP_NAME><![CDATA["+CommonUtil.isNull(bean.getGroup_name())+"]]></GROUP_NAME>");
					out.println("<SYSTEM_GB><![CDATA["+CommonUtil.getMessage("USER_DAILY.SYSTEM.GB."+CommonUtil.isNull(bean.getUser_daily_system_gb()))+"]]></SYSTEM_GB>");
					out.println("<TOTAL><![CDATA["+CommonUtil.isNull(bean.getTotal())+"]]></TOTAL>");
					out.println("<ENDED_OK><![CDATA["+CommonUtil.isNull(bean.getEnded_ok())+"]]></ENDED_OK>");
					out.println("<ENDED_NOT_OK><![CDATA["+CommonUtil.isNull(bean.getEnded_not_ok())+"]]></ENDED_NOT_OK>");
					out.println("<EXECUTING><![CDATA["+CommonUtil.isNull(bean.getExecuting())+"]]></EXECUTING>");
					out.println("<WAIT_CONDITION><![CDATA["+CommonUtil.isNull(bean.getWait_condition())+"]]></WAIT_CONDITION>");
					out.println("<WAIT_TIME><![CDATA["+CommonUtil.isNull(bean.getWait_time())+"]]></WAIT_TIME>");
					out.println("<WAIT_CONFIRM><![CDATA["+CommonUtil.isNull(bean.getWait_confirm())+"]]></WAIT_CONFIRM>");
					out.println("<WAIT_RESOURCE><![CDATA["+CommonUtil.isNull(bean.getWait_resource())+"]]></WAIT_RESOURCE>");
					out.println("<ETC><![CDATA["+CommonUtil.isNull(bean.getEtc())+"]]></ETC>");
					out.println("<UNKNOWN><![CDATA["+CommonUtil.isNull(bean.getUnknown())+"]]></UNKNOWN>");
					out.println("<HOLD><![CDATA["+CommonUtil.isNull(bean.getHold())+"]]></HOLD>");
					out.println("<DELETES><![CDATA["+CommonUtil.isNull(bean.getDeletes())+"]]></DELETES>");
					
					out.println("</item>");
				}
				
				out.println("</items>");
				
			}

		}else if(itemGb.equals("mCodeList")){
			List<CommonBean> itemList = (List)request.getAttribute("itemList");
			if( !(null!=itemList && 0<itemList.size()) ){
				out.println("<items cnt='0' msg='"+CommonUtil.getMessage("DEBUG.06")+"' ></items>");
			}else{
				out.println("<items cnt='"+itemList.size()+"' >");
				
				for( int i=0; i<itemList.size(); i++ ){
					CommonBean bean = itemList.get(i);
										
					out.println("<item>");
					
					out.println("<MCODE_CD><![CDATA["+CommonUtil.isNull(bean.getMcode_cd())+"]]></MCODE_CD>");
					out.println("<MCODE_NM><![CDATA["+CommonUtil.isNull(bean.getMcode_nm())+"]]></MCODE_NM>");
					out.println("<INS_DATE><![CDATA["+CommonUtil.isNull(bean.getIns_date())+"]]></INS_DATE>");
					out.println("<MCODE_DESC><![CDATA["+CommonUtil.isNull(bean.getMcode_desc())+"]]></MCODE_DESC>");
					out.println("<DEL_YN><![CDATA["+CommonUtil.isNull(bean.getDel_yn())+"]]></DEL_YN>");
										
					out.println("</item>");
				}
				
				out.println("</items>");
				
			}
		}else if(itemGb.equals("sCodeList")){
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
					out.println("<INS_DATE><![CDATA["+CommonUtil.isNull(bean.getIns_date())+"]]></INS_DATE>");
					out.println("<ORDER_NO><![CDATA["+CommonUtil.isNull(bean.getOrder_no())+"]]></ORDER_NO>");
					out.println("<SCODE_ENG_NM><![CDATA["+CommonUtil.isNull(bean.getScode_eng_nm())+"]]></SCODE_ENG_NM>");
					out.println("<SCODE_DESC><![CDATA["+CommonUtil.isNull(bean.getScode_desc())+"]]></SCODE_DESC>");
					out.println("<SCODE_USE_YN><![CDATA["+CommonUtil.isNull(bean.getScode_use_yn())+"]]></SCODE_USE_YN>");
					out.println("<HOST_CD><![CDATA["+CommonUtil.isNull(bean.getHost_cd())+"]]></HOST_CD>");
					out.println("<HOST_NM><![CDATA["+CommonUtil.isNull(bean.getHost_nm())+"]]></HOST_NM>");
					out.println("<MCODE_CD><![CDATA["+CommonUtil.isNull(bean.getMcode_cd())+"]]></MCODE_CD>");
					
					out.println("</item>");
				}
				
				out.println("</items>");
				
			}
		}else if(itemGb.equals("approvalLine")){
			List<ApprovalLineBean> itemList = (List)request.getAttribute("itemList");
			if( !(null!=itemList && 0<itemList.size()) ){
				out.println("<items cnt='0' msg='"+CommonUtil.getMessage("DEBUG.06")+"' ></items>");
			}else{
				out.println("<items cnt='"+itemList.size()+"' >");
				
				for( int i=0; i<itemList.size(); i++ ){
					ApprovalLineBean bean = itemList.get(i);
										
					out.println("<item>");
					
					out.println("<SEQ><![CDATA["+CommonUtil.isNull(bean.getSeq())+"]]></SEQ>");
					out.println("<USER_CD><![CDATA["+CommonUtil.isNull(bean.getUser_cd())+"]]></USER_CD>");
					out.println("<USER_ID><![CDATA["+CommonUtil.isNull(bean.getUser_id())+"]]></USER_ID>");
					out.println("<USER_NM><![CDATA["+CommonUtil.isNull(bean.getUser_nm())+"]]></USER_NM>");
					out.println("<DUTY_NM><![CDATA["+CommonUtil.isNull(bean.getDuty_nm())+"]]></DUTY_NM>");
					out.println("<DUTY_CD><![CDATA["+CommonUtil.isNull(bean.getDuty_cd())+"]]></DUTY_CD>");
					out.println("<DEPT_NM><![CDATA["+CommonUtil.isNull(bean.getDept_nm())+"]]></DEPT_NM>");
					out.println("<DEPT_CD><![CDATA["+CommonUtil.isNull(bean.getDept_cd())+"]]></DEPT_CD>");
					out.println("<INS_DATE><![CDATA["+CommonUtil.isNull(bean.getIns_date())+"]]></INS_DATE>");
					out.println("<DOC_GB><![CDATA["+CommonUtil.isNull(bean.getDoc_gb())+"]]></DOC_GB>");
					out.println("<ORI_DOC_GB><![CDATA["+CommonUtil.isNull(bean.getOri_doc_gb())+"]]></ORI_DOC_GB>");
					out.println("<APPROVAL_LINE_CD><![CDATA["+CommonUtil.isNull(bean.getApproval_line_cd())+"]]></APPROVAL_LINE_CD>");
					out.println("<STATUS><![CDATA["+CommonUtil.isNull(bean.getStatus())+"]]></STATUS>");
										
					out.println("</item>");
				}
				
				out.println("</items>");
				
			}
		}else if(itemGb.equals("myDocInfoList")){
			List<DocInfoBean> itemList = (List)request.getAttribute("itemList");
			if( !(null!=itemList && 0<itemList.size()) ){
				out.println("<items cnt='0' msg='"+CommonUtil.getMessage("DEBUG.06")+"' ></items>");
			}else{
// 				out.println("<items cnt='"+itemList.size()+"' >");
				out.println("<items cnt='"+(itemList.size()-1)+"' total='"+itemList.get(itemList.size()-1)+"'  >");
				for( int i=0; i<itemList.size()-1; i++ ){
					DocInfoBean bean = itemList.get(i);

					String doc_gb = CommonUtil.isNull(bean.getDoc_gb());
					String task_detail = "";
					String task_nm = "";

					if(CommonUtil.isNull(bean.getDoc_gb()).equals("05") && !CommonUtil.isNull(bean.getDoc_group_id()).equals("")){
						doc_gb 		= doc_gb + "G";
						task_nm    	= CommonUtil.getMessage("DOC.GB."+doc_gb);
					}else if(CommonUtil.isNull(bean.getDoc_gb()).equals("06")||CommonUtil.isNull(bean.getDoc_gb()).equals("09")){
						task_nm    	= CommonUtil.getMessage("DOC.GB." + doc_gb + CommonUtil.isNull(bean.getTask_nm_detail()));
					}else {
						task_nm 	= CommonUtil.getMessage("DOC.GB."+doc_gb);
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

					out.println("<DATA_CENTER><![CDATA["+CommonUtil.isNull(bean.getData_center())+"]]></DATA_CENTER>");
					out.println("<DATA_CENTER_NAME><![CDATA["+CommonUtil.isNull(bean.getData_center_name())+"]]></DATA_CENTER_NAME>");

					out.println("<TABLE_ID><![CDATA["+CommonUtil.isNull(bean.getTable_id())+"]]></TABLE_ID>");
					out.println("<JOB_ID><![CDATA["+CommonUtil.isNull(bean.getJob_id())+"]]></JOB_ID>");

					out.println("<S_CNT><![CDATA["+CommonUtil.isNull(bean.getS_cnt())+"]]></S_CNT>");
					out.println("<E_CNT><![CDATA["+CommonUtil.isNull(bean.getE_cnt())+"]]></E_CNT>");
					out.println("<R_CNT><![CDATA["+CommonUtil.isNull(bean.getR_cnt())+"]]></R_CNT>");
					out.println("<W_CNT><![CDATA["+CommonUtil.isNull(bean.getW_cnt())+"]]></W_CNT>");
					out.println("<TOTAL_CNT><![CDATA["+CommonUtil.isNull(bean.getTotal_cnt())+"]]></TOTAL_CNT>");
					out.println("<FAIL_CNT><![CDATA["+CommonUtil.isNull(bean.getFail_cnt())+"]]></FAIL_CNT>");


					out.println("<APPLY_FAIL_COUNT><![CDATA["+CommonUtil.isNull(bean.getApply_fail_cnt())+"]]></APPLY_FAIL_COUNT>");
					out.println("<APPLICATION><![CDATA["+CommonUtil.isNull(bean.getApplication())+"]]></APPLICATION>"); 
					out.println("<SCHED_TABLE><![CDATA["+CommonUtil.isNull(bean.getSched_table())+"]]></SCHED_TABLE>");

					out.println("<APPLY_EXE_DATE><![CDATA["+CommonUtil.isNull(bean.getApply_exe_date())+"]]></APPLY_EXE_DATE>");
					out.println("<APPLY_NM><![CDATA["+CommonUtil.getMessage("APPLY.STATE."+CommonUtil.isNull(bean.getApply_cd()))+"]]></APPLY_NM>");
					out.println("<APPLY_CD><![CDATA["+CommonUtil.isNull(bean.getApply_cd())+"]]></APPLY_CD>");
					out.println("<S_APPLY_DATE><![CDATA["+CommonUtil.isNull(bean.getS_apply_date())+"]]></S_APPLY_DATE>");
					
					out.println("<LINE_APPROVAL><![CDATA["+CommonUtil.isNull(bean.getLine_approval())+"]]></LINE_APPROVAL>");	
					out.println("<RETURN_LINE_APPROVAL><![CDATA["+CommonUtil.isNull(bean.getReturn_line_approval())+"]]></RETURN_LINE_APPROVAL>");

					out.println("<ODATE><![CDATA["+CommonUtil.isNull(bean.getOdate())+"]]></ODATE>");
					
					out.println("<JOBSCHEDGB><![CDATA["+CommonUtil.isNull(bean.getJobschedgb())+"]]></JOBSCHEDGB>");
					out.println("<APPROVAL_USER_NM><![CDATA["+CommonUtil.isNull(bean.getApproval_user_nm())+"]]></APPROVAL_USER_NM>");
					out.println("<APPROVAL_DATE><![CDATA["+CommonUtil.isNull(bean.getApproval_date())+"]]></APPROVAL_DATE>");
					out.println("<REJECT_USER_NM><![CDATA["+CommonUtil.isNull(bean.getReject_user_nm())+"]]></REJECT_USER_NM>");
					out.println("<REJECT_COMMENT><![CDATA["+CommonUtil.isNull(bean.getReject_comment())+"]]></REJECT_COMMENT>");
					out.println("<REJECT_DATE><![CDATA["+CommonUtil.isNull(bean.getReject_date())+"]]></REJECT_DATE>");
					
					out.println("<USER_DAILY><![CDATA["+CommonUtil.isNull(bean.getUser_daily())+"]]></USER_DAILY>");
					out.println("<POST_APPROVAL_YN><![CDATA["+CommonUtil.isNull(bean.getPost_approval_yn())+"]]></POST_APPROVAL_YN>");
					out.println("<DETAIL_STATUS><![CDATA["+CommonUtil.isNull(bean.getDetail_status())+"]]></DETAIL_STATUS>");
					out.println("<ALARM_USER><![CDATA["+CommonUtil.isNull(bean.getAlarm_user())+"]]></ALARM_USER>");
					out.println("<DOC_GROUP_ID><![CDATA["+CommonUtil.isNull(bean.getDoc_group_id())+"]]></DOC_GROUP_ID>");

					out.println("<DOC_CNT><![CDATA["+CommonUtil.isNull(bean.getDoc_cnt())+"]]></DOC_CNT>");
					out.println("<ORI_DOC_GB><![CDATA["+CommonUtil.isNull(bean.getOri_doc_gb())+"]]></ORI_DOC_GB>");
					out.println("<TASK_TYPE><![CDATA["+CommonUtil.isNull(bean.getTask_type())+"]]></TASK_TYPE>");

					out.println("</item>");
				}
				
				out.println("</items>");
				
			}
		
		} else if(itemGb.equals("groupMailList")) {
			
			List<CommonBean> itemList = (List)request.getAttribute("itemList");
			
			if( !(null!=itemList && 0<itemList.size()) ){
				out.println("<items cnt='0' msg='"+CommonUtil.getMessage("DEBUG.06")+"' ></items>");
			}else{
				out.println("<items cnt='"+itemList.size()+"' >");
				
				for( int i=0; i<itemList.size(); i++ ){
					CommonBean bean = itemList.get(i);
															
					out.println("<item>");
					
					out.println("<DLNM><![CDATA["+CommonUtil.isNull(bean.getDlNm())+"]]></DLNM>");
					out.println("<EMAIL><![CDATA["+CommonUtil.isNull(bean.getEmail())+"]]></EMAIL>");
					out.println("<DLCD><![CDATA["+CommonUtil.isNull(bean.getDlCd())+"]]></DLCD>");
																																	
					out.println("</item>");
				}
				out.println("</items>");
				
			}
		} else if(itemGb.equals("quartzList") || itemGb.equals("popupQuartzList")){
			List<CommonBean> itemList = (List)request.getAttribute("itemList");
			if( !(null!=itemList && 0<itemList.size()) ){
				out.println("<items cnt='0' msg='"+CommonUtil.getMessage("DEBUG.06")+"' ></items>");
			}else{
				out.println("<items cnt='"+itemList.size()+"' >");
				
				for( int i=0; i<itemList.size(); i++ ){
					CommonBean bean = itemList.get(i);
					
					out.println("<item>");
					
					out.println("<QUARTZ_NAME><![CDATA["+CommonUtil.isNull(bean.getQuartz_name())+"]]></QUARTZ_NAME>");
					out.println("<TRACE_LOG_PATH><![CDATA["+CommonUtil.isNull(bean.getTrace_log_path())+"]]></TRACE_LOG_PATH>");
					out.println("<STATUS_CD><![CDATA["+CommonUtil.isNull(bean.getStatus_cd())+"]]></STATUS_CD>");
					out.println("<STATUS_LOG><![CDATA["+CommonUtil.isNull(bean.getStatus_log())+"]]></STATUS_LOG>");
					out.println("<INS_DATE><![CDATA["+CommonUtil.isNull(bean.getIns_date())+"]]></INS_DATE>");
					out.println("</item>");
				}
				out.println("</items>");
			}
		} else if(itemGb.equals("folderAppGrpList")) {
			List<CommonBean> folderAppGrpList 	= (List)request.getAttribute("folderAppGrpList");
			List<CommonBean> itemList 			= (List)request.getAttribute("itemList");
			
			int authIdx = 0;
			out.println("<items cnt='"+itemList.size()+"' >");
			for( int i=0;folderAppGrpList!=null && i<folderAppGrpList.size(); i++){
				CommonBean bean = folderAppGrpList.get(i);
				System.out.println("strFolder" + CommonUtil.isNull(bean.getSched_table()));
				String strFolder 	= CommonUtil.isNull(bean.getSched_table());
				System.out.println("strFolder" + strFolder);
				String strApp			= CommonUtil.isNull(bean.getApplication());
				String strGrp 			= CommonUtil.isNull(bean.getGroup_name());
				String strTab_nm		= CommonUtil.isNull(bean.getTab_nm());
				String strApp_nm		= CommonUtil.isNull(bean.getApp_nm());
				String strGrp_nm		= CommonUtil.isNull(bean.getGrp_nm());
				String strScodeCd		= CommonUtil.isNull(bean.getScode_cd());
				String strScodeNm		= CommonUtil.isNull(bean.getScode_nm());
				String strDataCenter	= CommonUtil.isNull(bean.getData_center());
				
				out.println("<item>");
				out.println("<FOLDER><![CDATA["+strFolder+"]]></FOLDER>");
				out.println("<APPLICATION><![CDATA["+strApp+"]]></APPLICATION>");
				out.println("<GROUP_NAME><![CDATA["+strGrp+"]]></GROUP_NAME>");
				out.println("<SCODE_CD><![CDATA["+strScodeCd+"]]></SCODE_CD>");
				out.println("<SCODE_NM><![CDATA["+strScodeNm+"]]></SCODE_NM>");
				out.println("<DATA_CENTER><![CDATA["+strDataCenter+"]]></DATA_CENTER>");
				out.println("<TAB_NM><![CDATA["+strTab_nm+"]]></TAB_NM>");
				out.println("<APP_NM><![CDATA["+strApp_nm+"]]></APP_NM>");  
				out.println("<GRP_NM><![CDATA["+strGrp_nm+"]]></GRP_NM>");

				for(int j=0; null!=itemList && j<itemList.size(); j++) {
					CommonBean bean2 = (CommonBean)itemList.get(j);
					
					String strUserFolder 	= CommonUtil.isNull(bean2.getSched_table());
					String strUserApp 		= CommonUtil.isNull(bean2.getApplication());
					String strUserGrp 		= CommonUtil.isNull(bean2.getGroup_name());
					String strUserScodeCd	= CommonUtil.isNull(bean2.getScode_cd());
// 					out.println("<SCODE_CD><![CDATA["+strUserScodeCd+"]]></SCODE_CD>");
					
					if(strUserFolder.equals(strFolder)) {
						out.println("<AUTHIDX><![CDATA["+(authIdx)+"]]></AUTHIDX>");
					}
				}
				out.println("</item>");
				authIdx++;
			}
			out.println("</items>");
		} else if(itemGb.equals("authList")) {
			String noAuth = CommonUtil.isNull(paramMap.get("no_auth"));
// 			String []arrNoAuth = null;
// 			if(!no_auth.equals("")) {
// 				arrNoAuth = no_auth.split(",");
// 			}
			
			out.println("<items cnt='1' >");
			int CategoryIdx = 1;
			int CategorySubIdx = 0;
			String aCategory[] = CommonUtil.getMessage("CATEGORY.GB").split(",");
			for( int i=0;aCategory!=null && i<aCategory.length; i++){
				if(i!=0)CategorySubIdx++;
				String aTmp1 = CommonUtil.getMessage("CATEGORY.GB." + aCategory[i]);
				if("6".equals(aCategory[i])) continue;
				out.println("<item>");
				out.println("<CATEGORY><![CDATA["+aTmp1+"]]></CATEGORY>");
				out.println("<CATEGORYIDX><![CDATA["+(CategoryIdx)+"]]></CATEGORYIDX>");
				out.println("</item>");
				
				String aCategorySub[] = CommonUtil.getMessage("CATEGORY.GB." + aCategory[i] + ".GB").split(",");
				for( int j=0;aCategorySub!=null && j<aCategorySub.length; j++){
					CategoryIdx++;CategorySubIdx++;
					String aTmp2 = CommonUtil.getMessage("CATEGORY.GB." + aCategory[i] + ".GB." + aCategorySub[j]);
					out.println("<item>");
					out.println("<CATEGORY><![CDATA["+aTmp2.split(",")[0]+"]]></CATEGORY>");
					out.println("<CATEGORYNUM><![CDATA["+aCategorySub[j]+"]]></CATEGORYNUM>");
					if(noAuth.contains(aCategorySub[j])) {
						out.println("<CATEGORYSUBIDX><![CDATA["+CategorySubIdx+"]]></CATEGORYSUBIDX>");
					}
					out.println("</item>");
				}
			}
			out.println("</items>");
		} else if(itemGb.equals("forecastDocList")){
			List<DocInfoBean> itemList = (List)request.getAttribute("itemList");
			if( !(null!=itemList && 0<itemList.size()) ){
				out.println("<items cnt='0' msg='"+CommonUtil.getMessage("DEBUG.06")+"' ></items>");
			}else{
				out.println("<items cnt='"+itemList.size()+"' >");
				
				for( int i=0; i<itemList.size(); i++ ){
					DocInfoBean bean = itemList.get(i);
					
					out.println("<item>");
					
					out.println("<DOC_CD><![CDATA["+CommonUtil.isNull(bean.getDoc_cd())+"]]></DOC_CD>");
					out.println("<TITLE><![CDATA["+CommonUtil.isNull(bean.getTitle())+"]]></TITLE>");
					out.println("<JOB_NAME><![CDATA["+CommonUtil.isNull(bean.getJob_name())+"]]></JOB_NAME>");
					out.println("<DESCRIPTION><![CDATA["+CommonUtil.isNull(bean.getDescription())+"]]></DESCRIPTION>");
					out.println("<STATE_CD><![CDATA["+CommonUtil.isNull(bean.getState_cd())+"]]></STATE_CD>");
					out.println("<STATE_NM><![CDATA["+CommonUtil.getMessage("DOC.STATE."+CommonUtil.isNull(bean.getState_cd()))+"]]></STATE_NM>");
					out.println("<DRAFT_DATE><![CDATA["+CommonUtil.getDateFormat(1,CommonUtil.isNull(bean.getDraft_date()),"&nbsp;")+"]]></DRAFT_DATE>");
					out.println("<USER_NM><![CDATA["+CommonUtil.isNull(bean.getUser_nm())+"]]></USER_NM>");
					out.println("<DEPT_NM><![CDATA["+CommonUtil.isNull(bean.getDept_nm())+"]]></DEPT_NM>");
					out.println("<INS_DATE><![CDATA["+CommonUtil.isNull(bean.getIns_date())+"]]></INS_DATE>");
					out.println("<DATA_CENTER><![CDATA["+CommonUtil.isNull(bean.getData_center())+"]]></DATA_CENTER>");
					out.println("<DATA_CENTER_NAME><![CDATA["+CommonUtil.isNull(bean.getData_center_name())+"]]></DATA_CENTER_NAME>");
					out.println("<TABLE_NAME><![CDATA["+CommonUtil.isNull(bean.getTable_name())+"]]></TABLE_NAME>");
					out.println("<APPLICATION><![CDATA["+CommonUtil.isNull(bean.getApplication())+"]]></APPLICATION>"); 
					out.println("<GROUP_NAME><![CDATA["+CommonUtil.isNull(bean.getGroup_name())+"]]></GROUP_NAME>");
					
					String from_time = CommonUtil.isNull(bean.getFrom_time());
					
					out.println("<FROM_TIME><![CDATA["+from_time.substring(0,2)+":"+from_time.substring(2)+"]]></FROM_TIME>");
					out.println("<AFTER_STATUS><![CDATA["+CommonUtil.isNull(bean.getAfter_status())+"]]></AFTER_STATUS>");
					out.println("<APPLY_CD><![CDATA["+CommonUtil.isNull(bean.getApply_cd())+"]]></APPLY_CD>");
					out.println("<APPLY_NM><![CDATA["+CommonUtil.getMessage("APPLY.STATE."+CommonUtil.isNull(bean.getApply_cd()))+"]]></APPLY_NM>");
					out.println("<APPLY_DATE><![CDATA["+CommonUtil.isNull(bean.getApply_date())+"]]></APPLY_DATE>");
					
					out.println("<ODATE><![CDATA["+CommonUtil.isNull(bean.getOdate())+"]]></ODATE>");
					
					out.println("<REJECT_USER_NM><![CDATA["+CommonUtil.isNull(bean.getReject_user_nm())+"]]></REJECT_USER_NM>");
					out.println("<REJECT_COMMENT><![CDATA["+CommonUtil.isNull(bean.getReject_comment())+"]]></REJECT_COMMENT>");
					out.println("<REJECT_DATE><![CDATA["+CommonUtil.isNull(bean.getReject_date())+"]]></REJECT_DATE>");
					out.println("<APPROVAL_USER_NM><![CDATA["+CommonUtil.isNull(bean.getApproval_user_nm())+"]]></APPROVAL_USER_NM>");
					out.println("<APPROVAL_DATE><![CDATA["+CommonUtil.isNull(bean.getApproval_date())+"]]></APPROVAL_DATE>");
					
// 					out.println("<USER_DAILY><![CDATA["+CommonUtil.isNull(bean.getUser_daily())+"]]></USER_DAILY>");
					
					out.println("</item>");
				}
				
				out.println("</items>");
				
			}
		}else if(itemGb.equals("adminApprovalLineCd")){
			List<CommonBean> itemList = (List)request.getAttribute("itemList");
			if( !(null!=itemList && 0<itemList.size()) ){
				out.println("<items cnt='0' msg='"+CommonUtil.getMessage("DEBUG.06")+"' ></items>");
			}else{
				out.println("<items cnt='"+itemList.size()+"' >");
				
				for( int i=0; i<itemList.size(); i++ ){
					CommonBean bean = itemList.get(i);
					out.println("<item>");
					out.println("<ADMIN_LINE_GRP_CD><![CDATA["+CommonUtil.isNull(bean.getAdmin_line_grp_cd())+"]]></ADMIN_LINE_GRP_CD>");
					out.println("</item>");
				}
				out.println("</items>");
				
			}
		} else if(itemGb.equals("adminApprovalLineList")){
			List<CommonBean> itemList = (List)request.getAttribute("itemList");
			if( !(null!=itemList && 0<itemList.size()) ){
				out.println("<items cnt='0' msg='"+CommonUtil.getMessage("DEBUG.06")+"' ></items>");
			}else{
				out.println("<items cnt='"+itemList.size()+"' >");
				
				String approval_user_nm = "";
				String approval_grp_nm = "";
				
				for( int i=0; i<itemList.size(); i++ ){
					CommonBean bean = itemList.get(i);
					out.println("<item>");
					out.println("<ADMIN_LINE_GRP_CD><![CDATA["+CommonUtil.isNull(bean.getAdmin_line_grp_cd())+"]]></ADMIN_LINE_GRP_CD>");
					 
					if(!CommonUtil.isNull(bean.getGroup_line_grp_nm()).equals("")){
						approval_grp_nm = CommonUtil.isNull(bean.getGroup_line_grp_nm()) + " - " + CommonUtil.isNull(bean.getGroup_approval_user_nm());
					}else{
						approval_grp_nm = "";
					}
					out.println("<APPROVAL_SEQ><![CDATA["+CommonUtil.isNull(bean.getApproval_seq())+"]]></APPROVAL_SEQ>");
					out.println("<GROUP_LINE_USER_CD><![CDATA["+CommonUtil.isNull(bean.getGroup_approval_user_cd())+"]]></GROUP_LINE_USER_CD>"); 
					out.println("<GROUP_LINE_USER_ID><![CDATA["+CommonUtil.isNull(bean.getGroup_approval_user_id())+"]]></GROUP_LINE_USER_ID>"); 
					out.println("<GROUP_LINE_USER_NM><![CDATA["+CommonUtil.isNull(bean.getGroup_approval_user_nm())+"]]></GROUP_LINE_USER_NM>");
					out.println("<GROUP_LINE_GRP_NM><![CDATA["+approval_grp_nm+"]]></GROUP_LINE_GRP_NM>");
					out.println("<GROUP_LINE_DUTY_NM><![CDATA["+CommonUtil.isNull(bean.getGroup_approval_duty_nm())+"]]></GROUP_LINE_DUTY_NM>");
					out.println("<GROUP_LINE_DEPT_NM><![CDATA["+CommonUtil.isNull(bean.getGroup_approval_dept_nm())+"]]></GROUP_LINE_DEPT_NM>");
					out.println("<APPROVAL_TYPE><![CDATA["+CommonUtil.isNull(bean.getApproval_type())+"]]></APPROVAL_TYPE>");
					out.println("<GROUP_LINE_GRP_CD><![CDATA["+CommonUtil.isNull(bean.getGroup_line_grp_cd())+"]]></GROUP_LINE_GRP_CD>");
					out.println("<APPROVAL_NM><![CDATA["+CommonUtil.isNull(bean.getApproval_nm())+"]]></APPROVAL_NM>");
					out.println("<GROUP_MEMBER_CNT><![CDATA["+CommonUtil.isNull(bean.getGroup_member_cnt())+"]]></GROUP_MEMBER_CNT>");
					out.println("<GROUP_NM><![CDATA["+CommonUtil.isNull(bean.getGroup_line_grp_nm())+"]]></GROUP_NM>");
					
					out.println("</item>");
				}
				out.println("</items>");
				
			}
		}else if(itemGb.equals("workGroup")){
			List<UserBean> itemList = (List)request.getAttribute("itemList");
			if( !(null!=itemList && 0<itemList.size()) ){
				out.println("<items cnt='0' msg='"+CommonUtil.getMessage("DEBUG.06")+"' ></items>");
			}else{
				out.println("<items cnt='"+itemList.size()+"' >");
				
				for( int i=0; i<itemList.size(); i++ ){
					UserBean bean = itemList.get(i);
															
					out.println("<item>");
					
					out.println("<FINAL_USER_NM><![CDATA["+CommonUtil.isNull(bean.getUdt_user_nm())+"]]></FINAL_USER_NM>");
					out.println("<FINAL_UDT_DATE><![CDATA["+CommonUtil.isNull(bean.getUdt_date())+"]]></FINAL_UDT_DATE>");	
					out.println("<FOLDER_COUNT><![CDATA["+CommonUtil.isNull(bean.getFolder_count())+"]]></FOLDER_COUNT>");
																												
					out.println("</item>");
				}
				out.println("</items>");
				
			}
		}else if(itemGb.equals("folderGroupList")){

			List<com.ghayoun.ezjobs.t.domain.DefJobBean> itemList = (List)request.getAttribute("itemList");

			if( !(null!=itemList && 0<itemList.size()) ){
				out.println("<items cnt='0' msg='"+CommonUtil.getMessage("DEBUG.06")+"' ></items>");
			}else{
				out.println("<items cnt='"+itemList.size()+"' >");

				for( int i=0; i<itemList.size(); i++ ){

					com.ghayoun.ezjobs.t.domain.DefJobBean bean = itemList.get(i);

					out.println("<item>");

					out.println("<GRP_ENG_NM><![CDATA["+CommonUtil.isNull(bean.getGrp_eng_nm())+"]]></GRP_ENG_NM>");
// 					out.println("<INS_DATE><![CDATA["+CommonUtil.isNull(bean.getIns_date())+"]]></INS_DATE>");
					out.println("<GRP_CD><![CDATA["+CommonUtil.isNull(bean.getGrp_cd())+"]]></GRP_CD>");
					out.println("<USER_DAILY><![CDATA["+CommonUtil.isNull(bean.getUser_daily())+"]]></USER_DAILY>");
					out.println("<ARR_HOST_NM><![CDATA["+CommonUtil.isNull(bean.getArr_host_nm())+"]]></ARR_HOST_NM>");
					out.println("<ARR_HOST_DESC><![CDATA["+CommonUtil.isNull(bean.getArr_host_desc())+"]]></ARR_HOST_DESC>");
					out.println("<GRP_DESC><![CDATA["+CommonUtil.isNull(bean.getGrp_desc())+"]]></GRP_DESC>");
					out.println("<GRP_DEPTH><![CDATA["+CommonUtil.isNull(bean.getGrp_depth())+"]]></GRP_DEPTH>");
					out.println("<GRP_USE_YN><![CDATA["+CommonUtil.isNull(bean.getGrp_use_yn())+"]]></GRP_USE_YN>");
// 					out.println("<GRP_PARENT_CD><![CDATA["+CommonUtil.isNull(bean.getGrp_cd())+"]]></GRP_PARENT_CD>");
					out.println("<HOST_CD><![CDATA["+CommonUtil.isNull(bean.getHost_cd())+"]]></HOST_CD>");
					out.println("<SCODE_CD><![CDATA["+CommonUtil.isNull(bean.getScode_cd())+"]]></SCODE_CD>");

					out.println("</item>");
				}
				out.println("</items>");

			}
		}else if(itemGb.equals("jobGroupList")){
			
			List<JobGroupBean> itemList = (List)request.getAttribute("itemList");
			
			if( !(null!=itemList && 0<itemList.size()) ){
				out.println("<items cnt='0' msg='"+CommonUtil.getMessage("DEBUG.06")+"' ></items>");
			}else{
				out.println("<items cnt='"+itemList.size()+"' >");
				
				for( int i=0; i<itemList.size(); i++ ){
					
					JobGroupBean bean = itemList.get(i);
															
					out.println("<item>");

					out.println("<JOBGROUP_ID><![CDATA["+CommonUtil.isNull(bean.getJobgroup_id())+"]]></JOBGROUP_ID>");
					out.println("<JOBGROUP_NAME><![CDATA["+CommonUtil.isNull(bean.getJobgroup_name())+"]]></JOBGROUP_NAME>");
					out.println("<JOBGROUP_CONTENT><![CDATA["+CommonUtil.isNull(bean.getContent())+"]]></JOBGROUP_CONTENT>");
					out.println("<JOBGROUP_UDT_USER_NM><![CDATA["+CommonUtil.isNull(bean.getUdt_user_nm())+"]]></JOBGROUP_UDT_USER_NM>");
					out.println("<JOBGROUP_UDT_DATE><![CDATA["+CommonUtil.isNull(bean.getUdt_date())+"]]></JOBGROUP_UDT_DATE>");
					out.println("<JOBGROUP_DETAIL_CNT><![CDATA["+CommonUtil.isNull(bean.getGrp_detail_cnt())+"]]></JOBGROUP_DETAIL_CNT>");
					out.println("<CONTENT><![CDATA["+CommonUtil.isNull(bean.getContent())+"]]></CONTENT>");
					out.println("<COUNT><![CDATA["+CommonUtil.isNull(bean.getCount())+"]]></COUNT>");

					out.println("</item>");
				}
				out.println("</items>");
				
			}
		}else if(itemGb.equals("detailGrpList")){

			List<com.ghayoun.ezjobs.t.domain.DefJobBean> itemList = (List)request.getAttribute("itemList");

			if( !(null!=itemList && 0<itemList.size()) ){
				out.println("<items cnt='0' msg='"+CommonUtil.getMessage("DEBUG.06")+"' ></items>");
			}else{
				out.println("<items cnt='"+itemList.size()+"' >");

				for( int i=0; i<itemList.size(); i++ ){

					com.ghayoun.ezjobs.t.domain.DefJobBean bean = itemList.get(i);

					out.println("<item>");

					out.println("<JOB_ID><![CDATA["+CommonUtil.isNull(bean.getJob_id())+"]]></JOB_ID>");
					out.println("<JOB_NAME><![CDATA["+CommonUtil.isNull(bean.getJob_name())+"]]></JOB_NAME>"); // 작업명
					out.println("<GROUP_NAME><![CDATA["+CommonUtil.isNull(bean.getGroup_name())+"]]></GROUP_NAME>"); // 그룹
					out.println("<APPLICATION><![CDATA["+CommonUtil.isNull(bean.getApplication())+"]]></APPLICATION>"); // 어플리케이션
					out.println("<TABLE_ID><![CDATA["+CommonUtil.isNull(bean.getTable_id())+"]]></TABLE_ID>");
					out.println("<SCHED_TABLE><![CDATA["+CommonUtil.isNull(bean.getSched_table())+"]]></SCHED_TABLE>");
					out.println("<DESCRIPTION><![CDATA["+CommonUtil.isNull(bean.getDescription())+"]]></DESCRIPTION>");
// 					out.println("<JOBGROUP_UDT_USER_NM><![CDATA["+CommonUtil.isNull(bean.getUdt_user_nm())+"]]></JOBGROUP_UDT_USER_NM>");
// 					out.println("<JOBGROUP_UDT_DATE><![CDATA["+CommonUtil.isNull(bean.getUdt_date())+"]]></JOBGROUP_UDT_DATE>");
					out.println("<DATA_CENTER><![CDATA["+CommonUtil.isNull(bean.getData_center())+"]]></DATA_CENTER>");

					out.println("</item>");
				}
				out.println("</items>");

			}
		}else if(itemGb.equals("finalApprovalLineList")) {
			List<CommonBean> itemList = (List)request.getAttribute("itemList");

			if( !(null!=itemList && 0<itemList.size()) ){
				out.println("<items cnt='0' msg='"+CommonUtil.getMessage("DEBUG.06")+"' ></items>");
			}else{
				out.println("<items cnt='"+itemList.size()+"' >");

				String approval_user_nm = "";
				String approval_grp_nm 	= "";

				for( int i=0; i<itemList.size(); i++ ){

					CommonBean bean = itemList.get(i);

					out.println("<item>");

					out.println("<ADMIN_LINE_GRP_CD><![CDATA["+CommonUtil.isNull(bean.getAdmin_line_grp_cd())+"]]></ADMIN_LINE_GRP_CD>");

					if(!CommonUtil.isNull(bean.getGroup_line_grp_nm()).equals("")){
						approval_grp_nm = CommonUtil.isNull(bean.getGroup_line_grp_nm()) + " - " + CommonUtil.isNull(bean.getGroup_approval_user_nm());
					}else{
						approval_grp_nm = "";
					}
					out.println("<APPROVAL_SEQ><![CDATA["+CommonUtil.isNull(bean.getApproval_seq())+"]]></APPROVAL_SEQ>");
					out.println("<GROUP_LINE_USER_CD><![CDATA["+CommonUtil.isNull(bean.getGroup_approval_user_cd())+"]]></GROUP_LINE_USER_CD>");
					out.println("<GROUP_LINE_USER_ID><![CDATA["+CommonUtil.isNull(bean.getGroup_approval_user_id())+"]]></GROUP_LINE_USER_ID>");
					out.println("<GROUP_LINE_USER_NM><![CDATA["+CommonUtil.isNull(bean.getGroup_approval_user_nm())+"]]></GROUP_LINE_USER_NM>");
					out.println("<GROUP_LINE_GRP_NM><![CDATA["+approval_grp_nm+"]]></GROUP_LINE_GRP_NM>");
					out.println("<GROUP_LINE_DUTY_NM><![CDATA["+CommonUtil.isNull(bean.getGroup_approval_duty_nm())+"]]></GROUP_LINE_DUTY_NM>");
					out.println("<GROUP_LINE_DEPT_NM><![CDATA["+CommonUtil.isNull(bean.getGroup_approval_dept_nm())+"]]></GROUP_LINE_DEPT_NM>");
					out.println("<APPROVAL_TYPE><![CDATA["+CommonUtil.isNull(bean.getApproval_type())+"]]></APPROVAL_TYPE>");
					out.println("<GROUP_LINE_GRP_CD><![CDATA["+CommonUtil.isNull(bean.getGroup_line_grp_cd())+"]]></GROUP_LINE_GRP_CD>");
					out.println("<APPROVAL_NM><![CDATA["+CommonUtil.isNull(bean.getApproval_nm())+"]]></APPROVAL_NM>");
					out.println("<GROUP_MEMBER_CNT><![CDATA["+CommonUtil.isNull(bean.getGroup_member_cnt())+"]]></GROUP_MEMBER_CNT>");

					out.println("</item>");
				}
				out.println("</items>");

			}
		}else if(itemGb.equals("userLoginHistoryList")){

			List<UserBean> itemList = (List)request.getAttribute("itemList");

			if( !(null!=itemList && 0<itemList.size()) ){
				out.println("<items cnt='0' msg='"+CommonUtil.getMessage("DEBUG.06")+"' ></items>");
			}else{
				out.println("<items cnt='"+itemList.size()+"' >");

				for( int i=0; i<itemList.size(); i++ ){

					UserBean bean = itemList.get(i);
					out.println("<item>");
					out.println("<INS_USER_IP><![CDATA["+CommonUtil.isNull(bean.getIns_user_ip())+"]]></INS_USER_IP>");
					out.println("<INS_DATE><![CDATA["+CommonUtil.isNull(bean.getIns_date())+"]]></INS_DATE>");
					out.println("<USER_ID><![CDATA["+CommonUtil.isNull(bean.getUser_id())+"]]></USER_ID>"); 
					out.println("<USER_NM><![CDATA["+CommonUtil.isNull(bean.getUser_nm())+"]]></USER_NM>");
					
					out.println("</item>");
				}
				out.println("</items>");

			}
		}else if(itemGb.equals("folderUserList")){

			List<UserBean> itemList = (List)request.getAttribute("itemList");

			if( !(null!=itemList && 0<itemList.size()) ){
				out.println("<items cnt='0' msg='"+CommonUtil.getMessage("DEBUG.06")+"' ></items>");
			}else{
				out.println("<items cnt='"+itemList.size()+"' >");

				for( int i=0; i<itemList.size(); i++ ){

					UserBean bean = itemList.get(i);
					out.println("<item>");
					
					out.println("<DEPT_NM><![CDATA["+CommonUtil.isNull(bean.getDept_nm())+"]]></DEPT_NM>");
					out.println("<DUTY_NM><![CDATA["+CommonUtil.isNull(bean.getDuty_nm())+"]]></DUTY_NM>"); 
					out.println("<USER_NM><![CDATA["+CommonUtil.isNull(bean.getUser_nm())+"]]></USER_NM>");
					out.println("<USER_ID><![CDATA["+CommonUtil.isNull(bean.getUser_id())+"]]></USER_ID>");
					
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
					out.println("<ROW_NUM><![CDATA["+CommonUtil.isNull(bean.getRow_num())+"]]></ROW_NUM>");
					out.println("<ALARM_SEQ><![CDATA["+CommonUtil.isNull(bean.getAlarm_seq())+"]]></ALARM_SEQ>");
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
		}else if(itemGb.equals("smartTableTreeList")){
			List<CommonBean> itemList = (List)request.getAttribute("itemList");
			if( !(null!=itemList && 0<itemList.size()) ){
				out.println("<items cnt='0' msg='"+CommonUtil.getMessage("DEBUG.06")+"' ></items>");
			}else{
				out.println("<items cnt='"+itemList.size()+"' >");
				
				for( int i=0; i<itemList.size(); i++ ){
					CommonBean bean = itemList.get(i);
															
					out.println("<item>");
					out.println("<JOB_NAME><![CDATA["+CommonUtil.isNull(bean.getJob_name())+"]]></JOB_NAME>");
					out.println("<ODATE><![CDATA["+CommonUtil.isNull(bean.getOdate())+"]]></ODATE>");
					out.println("<ORDER_ID><![CDATA["+CommonUtil.isNull(bean.getOrder_id())+"]]></ORDER_ID>");
					out.println("<TASK_TYPE><![CDATA["+CommonUtil.isNull(bean.getTask_type())+"]]></TASK_TYPE>");
					out.println("<GROUP_NO><![CDATA["+CommonUtil.isNull(bean.getGroup_no())+"]]></GROUP_NO>");
					out.println("<HAILAKI><![CDATA["+CommonUtil.isNull(bean.getHailaki())+"]]></HAILAKI>");
					out.println("<CHECK_BOX_YN><![CDATA["+CommonUtil.isNull(bean.getCheck_box_yn())+"]]></CHECK_BOX_YN>");
					out.println("<RBA><![CDATA["+CommonUtil.isNull(bean.getRba())+"]]></RBA>");
					out.println("<GRP_RBA><![CDATA["+CommonUtil.isNull(bean.getGrp_rba())+"]]></GRP_RBA>");
																												
					out.println("</item>");
				}
				out.println("</items>");
				
			}
		}else if(itemGb.equals("smartTreeInfoList")){
			List<CommonBean> itemList = (List)request.getAttribute("itemList");
			if( !(null!=itemList && 0<itemList.size()) ){
				out.println("<items cnt='0' msg='"+CommonUtil.getMessage("DEBUG.06")+"' ></items>");
			}else{
				out.println("<items cnt='"+itemList.size()+"' >");
				
				for( int i=0; i<itemList.size(); i++ ){
					CommonBean bean = itemList.get(i);
															
					out.println("<item>");
					out.println("<JOB_NAME><![CDATA["+CommonUtil.isNull(bean.getJob_name())+"]]></JOB_NAME>");
					out.println("<ODATE><![CDATA["+CommonUtil.isNull(bean.getOdate())+"]]></ODATE>");
					out.println("<ORDER_ID><![CDATA["+CommonUtil.isNull(bean.getOrder_id())+"]]></ORDER_ID>");
					out.println("<RBA><![CDATA["+CommonUtil.isNull(bean.getRba())+"]]></RBA>");
					out.println("<GRP_RBA><![CDATA["+CommonUtil.isNull(bean.getGrp_rba())+"]]></GRP_RBA>");
					out.println("<TASK_TYPE><![CDATA["+CommonUtil.isNull(bean.getTask_type())+"]]></TASK_TYPE>");
																												
					out.println("</item>");
				}
				out.println("</items>");
				
			}
		}else if(itemGb.equals("jobHistoryInfo")){
			List<CommonBean> itemList = (List)request.getAttribute("itemList");
			if( !(null!=itemList && 0<itemList.size()) ){
				out.println("<items cnt='0' msg='"+CommonUtil.getMessage("DEBUG.06")+"' ></items>");
			}else{
				out.println("<items cnt='"+itemList.size()+"' >");
// 				out.println("<items cnt='"+(itemList.size()-1)+"' total='"+itemList.get(itemList.size()-1)+"'  >");
// 				for( int i=0; i<itemList.size()-1; i++ ){
				for( int i=0; i<itemList.size(); i++ ){
					CommonBean bean = itemList.get(i);

					String doc_gb = CommonUtil.isNull(bean.getDoc_gb());
					String task_detail = "";
					String task_nm = "";

					if(CommonUtil.isNull(bean.getDoc_gb()).equals("05") && !CommonUtil.isNull(bean.getDoc_group_id()).equals("")){
						doc_gb 		= doc_gb + "G";
						task_nm    	= CommonUtil.getMessage("DOC.GB."+doc_gb);
					}else if(CommonUtil.isNull(bean.getDoc_gb()).equals("06")||CommonUtil.isNull(bean.getDoc_gb()).equals("09")){
						task_nm    	= CommonUtil.getMessage("DOC.GB." + doc_gb + CommonUtil.isNull(bean.getTask_nm_detail()));
					}else {
						task_nm 	= CommonUtil.getMessage("DOC.GB."+doc_gb);
					}

					String title = CommonUtil.isNull(bean.getTitle());
					if(CommonUtil.isNull(bean.getDoc_gb()).equals("07") && !CommonUtil.isNull(bean.getPost_approval_yn()).equals("A")) {
						task_detail   = "[" + CommonUtil.isNull(bean.getTask_nm_detail()) + "]";
						title = task_detail + title;
					}

					out.println("<item>");
					
					out.println("<DOC_CD><![CDATA["+CommonUtil.isNull(bean.getDoc_cd())+"]]></DOC_CD>");
					out.println("<DOC_GB><![CDATA["+CommonUtil.isNull(bean.getDoc_gb())+"]]></DOC_GB>");
					out.println("<TASK_NM><![CDATA["+task_nm+"]]></TASK_NM>");
					out.println("<TASK_NM_DETAIL><![CDATA["+CommonUtil.isNull(bean.getTask_nm_detail())+"]]></TASK_NM_DETAIL>");
					out.println("<TITLE><![CDATA["+CommonUtil.isNull(bean.getTitle())+"]]></TITLE>");
					out.println("<JOB_NAME><![CDATA["+CommonUtil.isNull(bean.getJob_name())+"]]></JOB_NAME>");
					out.println("<DATA_CENTER><![CDATA["+CommonUtil.isNull(bean.getData_center())+"]]></DATA_CENTER>");
					out.println("<DATA_CENTER_NAME><![CDATA["+CommonUtil.isNull(bean.getData_center_name())+"]]></DATA_CENTER_NAME>");
					out.println("<APPLY_DATE><![CDATA["+CommonUtil.isNull(bean.getApply_date())+"]]></APPLY_DATE>");

					out.println("</item>");
				}
				
				out.println("</items>");
				
			}
		}
		
	}
%> 

</doc>

