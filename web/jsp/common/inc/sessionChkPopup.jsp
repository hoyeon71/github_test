<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,java.util.*,java.text.*" %>
<%@ page import="com.ghayoun.ezjobs.common.util.*" %>

<%
	if( !CommonUtil.isLogin(request) ){
		out.println("<script type='text/javascript'>");
		out.println("alert('"+CommonUtil.getMessage("ERROR.07")+"');");
		out.println("top.close();");
		out.println("</script>");
		out.flush();
		return;
	}
	
%>