<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.ghayoun.ezjobs.m.domain.PreJobMissMatchBean"%>

<%@include file="/jsp/common/inc/header.jsp"%>
<%
  response.setHeader("Cache-Control","no-store"); //HTTP 1.1
  response.setHeader("Pragma","no-cache"); //HTTP 1.0
  response.setDateHeader ("Expires", 0);
%>

<%
	String fileName = "선행작업불일치";
	response.setHeader("Content-Type", "application/vnd.ms-xls;charset=UTF-8");
	response.setHeader("Content-Disposition", "attachment;filename="+URLEncoder.encode(fileName,"UTF-8")+".xls");   
	response.setHeader("Content-Description", "JSP Generated Data");
%>


<%
	Map<String, Object> paramMap = CommonUtil.collectParameters(request);
	
	List preJobMissMatchList		= (List)request.getAttribute("preJobMissMatchList");
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

	out.println("<td >순번</td>");
	out.println("<td >TABLE</td>");
	out.println("<td >APP</td>");
	out.println("<td >GRP</td>");
	out.println("<td >작업명</td>");
	out.println("<td >선행작업조건</td>");
	
	out.println("</tr>");
	
	for( int i=0; null!=preJobMissMatchList && i<preJobMissMatchList.size(); i++ ){
		PreJobMissMatchBean bean = (PreJobMissMatchBean)preJobMissMatchList.get(i);
		
		out.println("<tr align='center' >");
		
		out.println("<td >"+(i+1)+"</td>");
		out.println("<td  style='mso-number-format:\\@;'>"+CommonUtil.E2K(bean.getOrder_table(),"&nbsp;")+"</td>");
		out.println("<td  style='mso-number-format:\\@;'>"+CommonUtil.E2K(bean.getApplication(),"&nbsp;")+"</td>");
		out.println("<td  style='mso-number-format:\\@;'>"+CommonUtil.E2K(bean.getGroup_name(),"&nbsp;")+"</td>");
		out.println("<td  style='mso-number-format:\\@;'>"+CommonUtil.E2K(bean.getJob_name(),bean.getMemname())+"</td>");
		out.println("<td  style='mso-number-format:\\@;'>"+CommonUtil.E2K(bean.getCondition(),"&nbsp;")+"</td>");
		
		out.println("</tr>");
		
		out.flush();
	}
	
	out.println("</table>");
	
%>

</body>
</html>
