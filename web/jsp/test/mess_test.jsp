<%@page import="com.ghayoun.ezjobs.common.util.SendMessenger"%>
<%@page import="com.ghayoun.ezjobs.common.util.CommonUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%	
	//(String ReceiverId, String SenderId, String SenderNm, String Content
	out.println("메신저 발송 결과 : " + SendMessenger.sendMessenger("195368", "195368", "EZJOBS", "배치 에러 발생"));
%>