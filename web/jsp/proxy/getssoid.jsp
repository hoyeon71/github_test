﻿<%@page import="com.ghayoun.ezjobs.common.util.CommonUtil"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Random"%>
<%@page import="java.util.Enumeration"%>
<%@page import="java.net.URLEncoder"%>
<%@include file="/jsp/common/inc/header.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="encrypt.jsp" %>

<%
  response.setHeader("Cache-Control","no-store"); //HTTP 1.1
  response.setHeader("Pragma","no-cache"); //HTTP 1.0
  response.setDateHeader ("Expires", 0);
%>

<%
	Map<String, Object> paramMap = CommonUtil.collectParameters(request);	
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!-- ============================================== 
*. 본 페이지는 SSO 연동을 하기위한 ProxyServer의 게이트웨이 역할을 하며
   Header 에서 SSO ID를 취득 후 업무 서버로 인증 정보를 전달한다.
=================================================-->
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
		<title>Reverse Proxy OHS</title>
	</head>
<%
/*******************************************************
**  업무서버에서 선언해야 할 변수- Start
**  필수 전달 Parameter 에 넘겨줘야 할 변수 선언 부
*******************************************************/
	String actionUrl = "http://wjscapp.woorifg.com/jsp/proxy/app_login_exec.jsp";  // 암호화된 SSO ID 를 받아 복호화 실행하는 URL'
/*******************************************************
**  업무서버에서 선언해야 할 변수- End
*******************************************************/
	String userID = "" ;
	String rand = "";
	String SSOUserID = request.getHeader("USER_ID") ;
	if (SSOUserID == null || "".equals(SSOUserID)) {
		SSOUserID = request.getHeader("user_id");
	}
	String ENT_CODE = request.getHeader("ENT_CODE") ; //계열사 코드
	if (ENT_CODE == null || "".equals(ENT_CODE)) {
		ENT_CODE = request.getHeader("ent_code");
	}
	String UNIT_CODE = request.getHeader("UNIT_CODE") ; //부서 코드
	if (UNIT_CODE == null || "".equals(UNIT_CODE)) {
		UNIT_CODE = request.getHeader("unit_code");
	}
	if ( SSOUserID == null || SSOUserID.equals("") ) {
		System.out.println("[SSO_PROXY_ERROR][" + request.getRequestURL() + "] Header에서 사용자 ID를 얻어올 수 없습니다.");
		out.println("[SSO_PROXY_ERROR][" + request.getRequestURL() + "] Header에서 사용자 ID를 얻어올 수 없습니다.");
		//response.sendRedirect("");	
	} else {
		String xKeyValue = request.getHeader("x-forwarded-for").toString();
		if(xKeyValue != null && !xKeyValue.equals("") ){
			if(xKeyValue.contains(":")){
				xKeyValue = xKeyValue.substring(0,xKeyValue.indexOf(":"));
			}
		}else{
			System.out.println("[SSO_PROXY_ERROR][" + request.getRequestURL() + "] Header에서 client IP Address 를 얻어올 수 없습니다.");
			out.println("[SSO_PROXY_ERROR][" + request.getRequestURL() + "] Header에서 client IP Address 를 얻어올 수 없습니다.");
			//response.sendRedirect("");	
		}
		Random ran = new Random();
		int tmpMax = 999999999;
		rand = String.valueOf(ran.nextInt(tmpMax));
		
		try {
			String encryptionKey = getEncryptionKey(xKeyValue, rand);
			userID = encryptAES(SSOUserID, encryptionKey);
		} catch (Exception ex) {
			System.out.println("[SSO_PROXY_ERROR][" + request.getRequestURL() + "] 사용자 ID 암호화에 실패했습니다.");
		}
		System.out.println("[SSO_PROXY_INFO]["+request.getRequestURL()+"] ENC_USERID==>" + userID) ;
	}
	%> 
	<body>
		<form name="ssoSample" method="post" target="_self" action="<%=actionUrl%>">  
	<%
	/********************************************************************
	** Proxy 에서 얻어온 헤더 정보를 Parameter로 넘겨주기 위한 설정
	** w_userid 는 평문값이므로 제외토록한다.
	** 본 페이지는 Sample 이므로 모든 헤더 값을 Parameter 로 넘긴다.
	** 실제 업무에서는 필요 정보만 Parameter로 넘기도록 한다.
	********************************************************************/
	Enumeration enumer = request.getHeaderNames();
	while(enumer.hasMoreElements()){
		String key = enumer.nextElement().toString();
		String value = request.getHeader(key);
	
		if(key.equals("w_userid")) continue;
	%>
			<input type="hidden" name="<%=key %>" value="<%=value%>"/>
	<%	
	}
	%>
<%-- 필수 전달 Parameter Start --%>
		<input type="hidden" name="userID" value="<%=userID%>"/>
		<input type="hidden" name="ENT_CODE" value="<%=ENT_CODE%>"/>
		<input type="hidden" name="UNIT_CODE" value="<%=UNIT_CODE%>"/>
		<input type="hidden" name="rand" value="<%=rand%>"/>
<%-- 필수 전달 Parameter End --%>
	</form>
	<script type="text/javascript">
		document.ssoSample.submit();
	</script>
</body>
</html>