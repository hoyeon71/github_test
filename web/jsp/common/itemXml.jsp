<%@ page language="java" contentType="application/xml; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,java.util.*,java.io.*,java.text.*,java.net.*" %>
<%@ page import="com.ghayoun.ezjobs.common.util.*" %>
<%@ page import="com.ghayoun.ezjobs.comm.domain.*" %>
<%@ page import="com.ghayoun.ezjobs.m.domain.*" %>

<%
  response.setHeader("Cache-Control","no-store"); //HTTP 1.1
  response.setHeader("Pragma","no-cache"); //HTTP 1.0
  response.setDateHeader ("Expires", 0);
%>

<%
	Map<String, Object> paramMap = CommonUtil.collectParameters(request);
	
	String searchType 	= CommonUtil.isNull(paramMap.get("searchType"));	
	String itemType 	= CommonUtil.isNull(paramMap.get("itemType"));
	String itemId 		= CommonUtil.isNull(paramMap.get("itemId"));
%>


<doc>

<%	
	
	if (searchType.equals("job_nameList") ) {

		List<CommonBean> searchItemList	= (List)request.getAttribute("searchItemList");

		if ( !(null!=searchItemList && 0<searchItemList.size()) ){
			out.println("<items cnt='0' msg='"+CommonUtil.getMessage("DEBUG.06")+"' ></items>");
		}else{
			out.println("<items cnt='"+searchItemList.size()+"' >");
			for( int i=0; i<searchItemList.size(); i++ ){
				CommonBean bean = searchItemList.get(i);
				
				out.println("<item>");
				out.println("<job_name>"+CommonUtil.isNull(bean.getJob_name())+"</job_name>");
				out.println("</item>");
			}
			out.println("</items>");
		}
	
	}else if (searchType.equals("jobGraphList") ) {
		List jobGraphPreList		= (List)request.getAttribute("jobGraphPreList");
		List jobGraphNextList		= (List)request.getAttribute("jobGraphNextList");

		out.println("<items >");
		
		Map<String,JobGraphBean> mNode = new HashMap<String,JobGraphBean>();
		for( int i=0; null!=jobGraphPreList && i<jobGraphPreList.size(); i++ ){
			JobGraphBean bean = (JobGraphBean)jobGraphPreList.get(i);
			
			mNode.put(bean.getOrder_id(), bean);
			
			if(!"".equals(CommonUtil.isNull(bean.getRef_order_id())) ){
				out.println("<edge>");
				out.println("<s><![CDATA["+bean.getRef_order_id()+"]]></s>");
				out.println("<t><![CDATA["+bean.getOrder_id()+"]]></t>");
				out.println("<status><![CDATA["+CommonUtil.isNull(bean.getState_result()).replaceAll(" ","_")+"]]></status>");
				out.println("</edge>");
			}
		}
		
		for( int i=0; null!=jobGraphNextList && i<jobGraphNextList.size(); i++ ){
			JobGraphBean bean = (JobGraphBean)jobGraphNextList.get(i);
			
			mNode.put(bean.getOrder_id(), bean);
			
			if(!"".equals(CommonUtil.isNull(bean.getRef_order_id())) ){
				out.println("<edge>");
				out.println("<s><![CDATA["+bean.getOrder_id()+"]]></s>");
				out.println("<t><![CDATA["+bean.getRef_order_id()+"]]></t>");
				out.println("<status><![CDATA["+CommonUtil.isNull(bean.getState_result()).replaceAll(" ","_")+"]]></status>");
				out.println("</edge>");
			}
		}
		
		Set kSet = mNode.keySet();
		
		Iterator<String> iter = kSet.iterator();
		while(iter.hasNext()){
			String key = iter.next();
			JobGraphBean bean = mNode.get(key);
			
			out.println("<node>");
			out.println("<order_id><![CDATA["+key+"]]></order_id>");
			out.println("<job_name><![CDATA["+bean.getJob_name()+"]]></job_name>");
			out.println("<status><![CDATA["+CommonUtil.isNull(bean.getState_result()).replaceAll(" ","_")+"]]></status>");
			out.println("</node>");
		}
		
		out.println("</items>");
		
	}else if(searchType.equals("dash01")){
		List<TotalJobStatus> searchItemList	= (List)request.getAttribute("searchItemList");
		
		if ( !(null!=searchItemList && 0<searchItemList.size()) ){
			out.println("<items cnt='0' msg='"+CommonUtil.getMessage("DEBUG.06")+"' ></items>");
		}else{
			out.println("<items cnt='"+searchItemList.size()+"' >");
			for( int i=0; i<searchItemList.size(); i++ ){
				TotalJobStatus bean = searchItemList.get(i);
				
				out.println("<item>");
				out.println("<total_count>"+CommonUtil.isNull(bean.getTotal_count())+"</total_count>");
				out.println("<job_success_count>"+CommonUtil.isNull(bean.getEnded_ok())+"</job_success_count>");
				out.println("<job_fail_count>"+CommonUtil.isNull(bean.getEnded_not_ok())+"</job_fail_count>");
				out.println("<running_count>"+CommonUtil.isNull(bean.getExecuting())+"</running_count>");
				out.println("<wait_time_count>"+CommonUtil.isNull(bean.getWait_time())+"</wait_time_count>");
				out.println("<wait_condition_count>"+CommonUtil.isNull(bean.getWait_condition())+"</wait_condition_count>");
				out.println("<wait_resource_count>"+CommonUtil.isNull(bean.getWait_resource())+"</wait_resource_count>");
				out.println("<wait_confirm_count>"+CommonUtil.isNull(bean.getWait_user())+"</wait_confirm_count>");
				out.println("<etc_count>"+CommonUtil.isNull(bean.getNot_in_ajf())+"</etc_count>");
				out.println("<unknown_count>"+CommonUtil.isNull(bean.getUnknown())+"</unknown_count>");
				out.println("<hold_count>"+CommonUtil.isNull(bean.getHeld())+"</hold_count>");
				out.println("<deleted_count>"+CommonUtil.isNull(bean.getDeleted())+"</deleted_count>");



				
				out.println("</item>");
			}
			out.println("</items>");
		}
	}else if(searchType.equals("dash02")){
		List<CtmInfoBean> searchItemList	= (List)request.getAttribute("searchItemList");
		
		if ( !(null!=searchItemList && 0<searchItemList.size()) ){
			out.println("<items cnt='0' msg='"+CommonUtil.getMessage("DEBUG.06")+"' ></items>");
		}else{
			out.println("<items cnt='"+searchItemList.size()+"' >");
			for( int i=0; i<searchItemList.size(); i++ ){
				CtmInfoBean bean = searchItemList.get(i);
				
				out.println("<item>");
				out.println("<application>"+CommonUtil.isNull(bean.getApplication())+"</application>");
				out.println("<wait_count>"+bean.getWait_cnt()+"</wait_count>");
				out.println("<ok_count>"+bean.getOk_cnt()+"</ok_count>");
				out.println("<not_ok_count>"+bean.getNot_ok_cnt()+"</not_ok_count>");
				System.out.println(CommonUtil.isNull(bean.getApplication()));
				System.out.println(CommonUtil.isNull(bean.getCnt()));

				out.println("</item>");
			}
			out.println("</items>");
		}
	}else if(searchType.equals("dash03")){
		List<CtmInfoBean> searchItemList	= (List)request.getAttribute("searchItemList");
		
		if ( !(null!=searchItemList && 0<searchItemList.size()) ){
			out.println("<items cnt='0' msg='"+CommonUtil.getMessage("DEBUG.06")+"' ></items>");
		}else{
			out.println("<items cnt='"+searchItemList.size()+"' >");
			for( int i=0; i<searchItemList.size(); i++ ){
				CtmInfoBean bean = searchItemList.get(i);
				
				out.println("<item>");
				out.println("<node>"+CommonUtil.isNull(bean.getCpu_id())+"</node>");
				out.println("<wait_count>"+bean.getWait_cnt()+"</wait_count>");
				out.println("<ok_count>"+bean.getOk_cnt()+"</ok_count>");
				out.println("<not_ok_count>"+bean.getNot_ok_cnt()+"</not_ok_count>");
				out.println("<exec_count>"+bean.getExec_cnt()+"</exec_count>");

				
				out.println("</item>");
			}
			out.println("</items>");
		}
	}else if(searchType.equals("dash04")){
		List<CtmInfoBean> searchItemList	= (List)request.getAttribute("searchItemList");
		
		if ( !(null!=searchItemList && 0<searchItemList.size()) ){
			out.println("<items cnt='0' msg='"+CommonUtil.getMessage("DEBUG.06")+"' ></items>");
		}else{
			out.println("<items cnt='"+searchItemList.size()+"' >");
			for( int i=0; i<searchItemList.size(); i++ ){
				CtmInfoBean bean = searchItemList.get(i);
				
				out.println("<item>");
				out.println("<job_name>"+CommonUtil.isNull(bean.getJob_name())+"</job_name>");
				out.println("<status>"+CommonUtil.isNull(bean.getStatus())+"</status>");
				out.println("<user>"+CommonUtil.isNull(bean.getUser_nm())+"</user>");
				

				out.println("</item>");
			}
			out.println("</items>");
		}
	}
		


%>
</doc>
