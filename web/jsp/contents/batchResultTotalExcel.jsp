<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.ghayoun.ezjobs.m.domain.*" %>

<%@include file="/jsp/common/inc/header.jsp"%>
<%
  response.setHeader("Cache-Control","no-store"); //HTTP 1.1
  response.setHeader("Pragma","no-cache"); //HTTP 1.0
  response.setDateHeader ("Expires", 0);
%>

<%
	String fileName = "배치결과총괄표";
	response.setHeader("Content-Type", "application/vnd.ms-xls;charset=UTF-8");
	response.setHeader("Content-Disposition", "attachment;filename="+URLEncoder.encode(fileName,"UTF-8")+".xls");   
	response.setHeader("Content-Description", "JSP Generated Data");
%>

<%
	Map<String, Object> paramMap = CommonUtil.collectParameters(request);

	List batchResultTotalList		= (List)request.getAttribute("batchResultTotalList");
	
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />

</head>

<body>

<%	
	out.println("<table border='1' >");
	out.println("<tr align='center' >");
	out.println("<td >GRP</td>");
	out.println("<td >구분</td>");
	out.println("<td >건수</td>");
	out.println("<td >"+CommonUtil.getMessage("JOB_STATUS.Ended_OK")+"</td>");
	out.println("<td >"+CommonUtil.getMessage("JOB_STATUS.Ended_Not_OK")+"</td>");
	out.println("<td >"+CommonUtil.getMessage("JOB_STATUS.Executing")+"</td>");
	out.println("<td >"+CommonUtil.getMessage("JOB_STATUS.Wait_Condition")+"</td>");
	out.println("<td >"+CommonUtil.getMessage("JOB_STATUS.Wait_Time")+"</td>");
	out.println("<td >"+CommonUtil.getMessage("JOB_STATUS.Wait_User")+"</td>");
	out.println("<td >"+CommonUtil.getMessage("JOB_STATUS.Wait_Resource")+"</td>");
	out.println("<td >"+CommonUtil.getMessage("JOB_STATUS.Etc")+"</td>");
	out.println("<td >"+CommonUtil.getMessage("JOB_STATUS.Unknown")+"</td>");
	out.println("<td >"+CommonUtil.getMessage("JOB_STATUS.Held")+"</td>");
	out.println("<td >"+CommonUtil.getMessage("JOB_STATUS.Deleted")+"</td>");
	
	out.println("</tr>");
	
	for( int i=0; null!=batchResultTotalList && i<batchResultTotalList.size(); i++ ){
		BatchResultTotalBean bean = (BatchResultTotalBean)batchResultTotalList.get(i);
		
		out.println("<tr align='center' >");
		out.println("<td style='mso-number-format:\\@;'>"+CommonUtil.E2K(bean.getGroup_name(),"&nbsp;")+"</td>");
		out.println("<td style='mso-number-format:\\@;'>"+CommonUtil.getMessage("USER_DAILY.SYSTEM.GB."+bean.getUser_daily_system_gb())+"</td>");
		out.println("<td >"+CommonUtil.isNull(bean.getTotal(),"&nbsp;")+"</td>");
		out.println("<td >"+CommonUtil.isNull(bean.getEnded_ok(),"&nbsp;")+"</td>");
		out.println("<td >"+CommonUtil.isNull(bean.getEnded_not_ok(),"&nbsp;")+"</td>");
		out.println("<td >"+CommonUtil.isNull(bean.getExecuting(),"&nbsp;")+"</td>");
		out.println("<td >"+CommonUtil.isNull(bean.getWait_condition(),"&nbsp;")+"</td>");
		out.println("<td >"+CommonUtil.isNull(bean.getWait_time(),"&nbsp;")+"</td>");
		out.println("<td >"+CommonUtil.isNull(bean.getWait_confirm(),"&nbsp;")+"</td>");
		out.println("<td >"+CommonUtil.isNull(bean.getWait_resource(),"&nbsp;")+"</td>");
		out.println("<td >"+CommonUtil.isNull(bean.getEtc(),"&nbsp;")+"</td>");
		out.println("<td >"+CommonUtil.isNull(bean.getUnknown(),"&nbsp;")+"</td>");
		out.println("<td >"+CommonUtil.isNull(bean.getHold(),"&nbsp;")+"</td>");
		out.println("<td >"+CommonUtil.isNull(bean.getDeletes(),"&nbsp;")+"</td>");
		
		out.println("</tr>");
		
		out.flush();
	}
	
	out.println("</table>");
	
%>

</body>
</html>
