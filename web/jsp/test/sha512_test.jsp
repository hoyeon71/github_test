<%@page import="com.ghayoun.ezjobs.common.util.CommonUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	String cmd = "admin";
	
	
	out.println("before : " + cmd);
	out.println("<BR>");

	cmd = CommonUtil.toSha512(cmd);
	
	out.println("after : " + cmd);
	out.println("<BR>");
%>