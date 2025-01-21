<%@page import="com.ghayoun.ezjobs.common.util.SendSms"%>
<%@page import="com.ghayoun.ezjobs.common.util.SshUtil"%>
<%@page import="com.ghayoun.ezjobs.common.util.CommonUtil"%>
<%@page import="com.ghayoun.ezjobs.common.util.DateUtil"%>
<%@page import="com.ghayoun.ezjobs.common.util.SeedUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<body>
	<form name="loginForm" action="https://nss.navercorp.com/loginProcess" method="post">
	 	<input type="hidden" name="targetUrl" value="${param.targetUrl}">
	 	<input type="hidden" name="serviceId" value="${param.serviceId}">
	 	
	 <table>
	 	<tr><td><input type="text" name="user"></td></tr>
	 	<tr><td><input type="password" name="password"></td></tr>
	 </table>
	</form>
</body>