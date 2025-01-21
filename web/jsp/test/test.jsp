<%@page import="com.ghayoun.ezjobs.common.util.CommonUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	String cmd = "개발:에러-관리자,미설정/EZ_20230407_001:김선중 수정 테스트입니다. 한글 테스트를 위해 작업 설명을 길게 설정 합니다. 양해 부탁드리겠습니다.";
	
	System.out.println("after : " + cmd);
	out.println("before : " + cmd);

	cmd = CommonUtil.subStrBytes(cmd, 90);
	
	//cmd = CommonUtil.lpad(cmd, 1000, "2");
	
	out.println("after : " + cmd);
%>