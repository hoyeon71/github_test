<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.ghayoun.ezjobs.comm.domain.*" %>
<%@include file="/jsp/common/inc/header.jsp"%>

<%
	Map<String, Object> paramMap 	= CommonUtil.collectParameters(request);
	
	CommonBean commonBean			= (CommonBean) request.getAttribute("commonBean");
	String strAjaxValue 			= "";
	
	if ( commonBean != null ) {	
		strAjaxValue 			= CommonUtil.isNull(CommonUtil.E2K(commonBean.getAjax_value()));
	}
	
	//System.out.println("###############" + strAjaxValue); 
%>
<%=strAjaxValue%>