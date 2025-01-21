<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="java.sql.*,java.util.*,java.io.*,java.text.*,java.net.*" %>
<%@ page import="javax.servlet.http.HttpServletRequest" %>
<%@ page import="javax.servlet.http.HttpServletResponse" %>
<%@ page import="com.ghayoun.ezjobs.common.util.*" %>
<%@ page import="com.ghayoun.ezjobs.comm.domain.*" %>
<%@ page import="com.ghayoun.ezjobs.m.domain.*" %>

<%
	String sContextPath = request.getContextPath();

	String S_USER_CD 		= CommonUtil.isNull(request.getSession().getAttribute("USER_CD"));
	String S_USER_ID 		= CommonUtil.isNull(request.getSession().getAttribute("USER_ID")); 
	String S_USER_NM 		= CommonUtil.isNull(request.getSession().getAttribute("USER_NM"));
	String S_USER_GB 		= CommonUtil.isNull(request.getSession().getAttribute("USER_GB"));
	String S_USER_EMAIL 	= CommonUtil.isNull(request.getSession().getAttribute("USER_EMAIL"));
	String S_USER_HP 		= CommonUtil.isNull(request.getSession().getAttribute("USER_HP"));
	String S_DEPT_CD 		= CommonUtil.isNull(request.getSession().getAttribute("DEPT_CD"));
	String S_DEPT_NM 		= CommonUtil.isNull(request.getSession().getAttribute("DEPT_NM"));
	String S_DUTY_CD 		= CommonUtil.isNull(request.getSession().getAttribute("DUTY_CD"));
	String S_DUTY_NM 		= CommonUtil.isNull(request.getSession().getAttribute("DUTY_NM"));
	String S_PART_CD 		= CommonUtil.isNull(request.getSession().getAttribute("PART_CD"));
	String S_PART_NM 		= CommonUtil.isNull(request.getSession().getAttribute("PART_NM"));
	String S_NO_AUTH 		= CommonUtil.isNull(request.getSession().getAttribute("NO_AUTH"));
	String S_L_GUBUN 		= CommonUtil.isNull(request.getSession().getAttribute("LOGIN_GUBUN"));
	String S_D_C_CODE 		= CommonUtil.isNull(request.getSession().getAttribute("SELECT_DATA_CENTER_CODE"));	
	String S_D_CENTER		= CommonUtil.isNull(request.getSession().getAttribute("SELECT_DATA_CENTER"));
	String S_TAB			= CommonUtil.isNull(request.getSession().getAttribute("SELECT_TABLE_NAME"));
	String S_APP			= CommonUtil.isNull(request.getSession().getAttribute("SELECT_APPLICATION"));
	String S_GRP			= CommonUtil.isNull(request.getSession().getAttribute("SELECT_GROUP_NAME"));
	//상태변경권한 추가(23.04.04 신한캐피탈)
	String S_ACTIVE_AUTH 	= CommonUtil.isNull(request.getSession().getAttribute("ACTIVE_AUTH"));

	String S_USER_IP 		= CommonUtil.isNull(request.getSession().getAttribute("USER_IP"));
	String S_DEFAULT_PAGING = CommonUtil.isNull(request.getSession().getAttribute("DEFAULT_PAGING"));
	String S_ALERT_CNT 		= CommonUtil.isNull(request.getSession().getAttribute("ALERT_CNT"));
	String S_ALERT_CLOSE 	= CommonUtil.isNull(request.getSession().getAttribute("ALERT_CLOSE"));
	String S_GRID_VSCROLL = "true";
	
	String SS_PUBKEY_MOD 	= CommonUtil.isNull(request.getSession().getAttribute("SS_PUBKEY_MOD"));
	String SS_PUBKEY_EXP 	= CommonUtil.isNull(request.getSession().getAttribute("SS_PUBKEY_EXP"));
	//최초 로그인 여부 체크로직(23.11.03)
	String S_LOGIN_CHK 		= CommonUtil.isNull(request.getSession().getAttribute("LOGIN_CHK"));

%>