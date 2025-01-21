<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,java.util.*,java.text.*" %>
<%@ page import="com.ghayoun.ezjobs.common.util.*" %>

<%
	out.println("<script type='text/javascript'>");
	out.println("alert('"+CommonUtil.getMessage("ERROR.13")+"');");
	out.println("top.location.href='"+request.getContextPath()+"/index.jsp';");
	out.println("</script>");
	out.flush();
	return;
	
	
%>