<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@include file="/jsp/common/inc/header.jsp"%>

<%
  response.setHeader("Cache-Control","no-store"); //HTTP 1.1
  response.setHeader("Pragma","no-cache"); //HTTP 1.0
  response.setDateHeader ("Expires", 0);
%>

<%
response.setStatus(200);
%>
<!DOCTYPE html>
<html >
<head><title>::ERROR::</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script type="text/javascript" src="<%=request.getContextPath() %>/js/common.js" ></script>

<script type="text/javascript">
<!--
	
//-->
</script>
</head>

<body topmargin="0" leftmargin="0"   >
<%
	out.println("<script type='text/javascript'>");
	out.println("try{top.viewProgBar(false);}catch(e){}");
	out.println("try{parent.viewProgBar(false);}catch(e){}");
	out.println("try{viewProgBar(false);}catch(e){}");
	out.println("alert('"+CommonUtil.getMessage(request.getParameter("msg_code"))+"');");
	out.println("</script>");
%>
	
</body>
</html>

