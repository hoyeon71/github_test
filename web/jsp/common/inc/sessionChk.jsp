<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,java.util.*,java.text.*" %>
<%@ page import="com.ghayoun.ezjobs.common.util.*" %>

<%
	String prvSession 	= CommonUtil.isNull((request.getSession().getAttribute("prvSession")));

	if( !CommonUtil.isLogin(request) ){
		out.println("<script type='text/javascript'>");
		out.println("alert('"+CommonUtil.getMessage("ERROR.07")+"');");
		out.println("top.location.href='"+request.getContextPath()+"/index.jsp';");
		//out.println("self.close();");
		out.println("</script>");
		out.flush();
		return;
	//이중로그인 체크로직 추가
	}else if(!prvSession.equals("")){
		request.getSession().invalidate();
		out.println("<script type='text/javascript'>");
		//out.println("alert('" + CommonUtil.getMessage("ERROR.69") + "');");
		//out.println("top.location.href='"+request.getContextPath()+"/index.jsp';");
		//out.println("self.close();");
		out.println("</script>");
		out.flush();

	}
	
%>