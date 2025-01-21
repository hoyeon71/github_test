<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@include file="/jsp/common/inc/header.jsp"%>

<%
  response.setHeader("Cache-Control","no-store"); //HTTP 1.1
  response.setHeader("Pragma","no-cache"); //HTTP 1.0
  response.setDateHeader ("Expires", 0);
%>

<%
	Map<String, Object> paramMap = CommonUtil.collectParameters(request);
	
%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />

<script type="text/javascript" src="<%=sContextPath %>/js/common.js" ></script>

<script type="text/javascript" >
<!--

//-->
</script>
</head>

<body>
<%	
	out.println("<script type='text/javascript'>");
	out.println("postHref('"+sContextPath+"/index.jsp','_top');");
	out.println("</script>");

%>
</body>
</html>
