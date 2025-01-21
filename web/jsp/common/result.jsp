<%@page import="com.bmc.ctmem.schema900.ResponseUserRegistrationType"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@include file="/jsp/common/inc/header.jsp"%>

<%
  response.setHeader("Cache-Control","no-store"); //HTTP 1.1
  response.setHeader("Pragma","no-cache"); //HTTP 1.0
  response.setDateHeader ("Expires", 0);
%>

<%
	Map<String, Object> paramMap = CommonUtil.collectParameters(request);

	String userId = CommonUtil.isNull(paramMap.get("userId"));
	
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
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
<%	Map rMap 		= (Map)request.getAttribute("rMap");
	String rCode 	= CommonUtil.isNull(rMap.get("rCode"));
	String rOriType = CommonUtil.isNull(rMap.get("rOriType"));
	String rType 	= CommonUtil.isNull(rMap.get("rType"));

	if( "".equals(rCode) || "-1".equals(rCode) ){
		out.println("<script type='text/javascript'>");
		out.println("alert('"+CommonUtil.getMessage("ERROR.06")+"');");
		out.println("</script>");
	}else if( "0".equals(rCode) ){
		
		/*
		if( "fault_type".equals(rType) ){
			Fault_type t = (Fault_type)rMap.get("rObject");
			
			Error_type[] error = t.getError_list();
			String errorMsg = "";
			if (error != null){
				for (int i=0; i< error.length ; i++){
					errorMsg += ( ("".equals(errorMsg))? error[i].getError_message():" "+error[i].getError_message() );
				}
			}
			
			if( "407".equals(error[0].getMajor()) && "3".equals(error[0].getMinor())) errorMsg = CommonUtil.getMessage("ERROR.08");
			
			out.println("<script type='text/javascript'>");
			out.println("alert('"+errorMsg+"');");
			out.println("</script>");
		}
		*/
		
	}else if( "1".equals(rCode) ){
		if( "response_unregister".equals(rOriType) ){
			request.getSession().invalidate();
			
			out.println("<script type='text/javascript'>");
			out.println("alert('"+CommonUtil.getMessage("DEBUG.05")+"');");
			out.println("top.location.href='"+sContextPath+"/index.jsp';");
			out.println("</script>");
		}else if( "response_register".equals(rOriType) ){
			if( "response_register".equals(rType) ){
				ResponseUserRegistrationType t = (ResponseUserRegistrationType)rMap.get("rObject");
				
				if( "OK".equals(t.getStatus()) ){
					request.getSession().setAttribute("USER_ID",userId);
					request.getSession().setAttribute("USER_TOKEN",t.getUserToken());
					
					out.println("<script type='text/javascript'>");
					//out.println("alert('"+CommonUtil.getMessage("DEBUG.04")+"');");
					out.println("top.location.href='"+sContextPath+"/common.ez?c=ez000&a=ezjobs.frame';");
					out.println("</script>");
				}else{
					out.println("<script type='text/javascript'>");
					out.println("alert('"+CommonUtil.getMessage("ERROR.08")+"');");
					out.println("</script>");
				}
			}
		}
	
	}
%>
</body>
</html>
