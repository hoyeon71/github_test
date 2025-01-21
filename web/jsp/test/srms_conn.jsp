<%@page import="com.ghayoun.ezjobs.t.service.WorksUserService"%>
<%@page import="com.ghayoun.ezjobs.t.service.WorksApprovalDocService"%>
<%@page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="org.springframework.web.context.WebApplicationContext"%>
<%@page import="com.ghayoun.ezjobs.t.controller.WorksController"%>
<%@page import="com.ghayoun.ezjobs.t.repository.WorksApprovalDocDao"%>
<%@page import="com.ghayoun.ezjobs.t.service.WorksApprovalDocServiceImpl"%>
<%@page import="com.ghayoun.ezjobs.t.repository.WorksApprovalDocDaoImpl"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@include file="/jsp/common/inc/header.jsp"%>

<%
	// 테스트 접속
	String strDbUrl			= "jdbc:oracle:thin:@10.228.21.107:1521:WPMSDB";
	String strDbUserNm		= "srms_ctm";
	String strDbPassword	= "dsmc08!#";
	
	Connection con 			= null;
	PreparedStatement pstmt = null;
	ResultSet rs 			= null;
	String sql 				= "";
	
	try {
		
		Class.forName("core.log.jdbc.driver.OracleDriver");
		
		con 		= DriverManager.getConnection(strDbUrl, strDbUserNm, strDbPassword);
		
		sql = 	"select sreq_code, sreq_title, pm_nm, sreq_planmh, sreq_resmh 	";
		//sql = 	"select count(*) 	";
		sql += 	"  from wpms.v_srlist_woori ";
		sql += 	" where sreq_code like 'L%' 		";
		
		out.println("sql : " + sql);
		out.println("<br>");
		
		try {
			
			pstmt 	= con.prepareStatement(sql);
			rs		= pstmt.executeQuery();
			
			while(rs.next()) {
			
				String sreq_code	= CommonUtil.isNull(rs.getString(1));				
				
				out.println("sreq_code : " + sreq_code);
			}

        } catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				pstmt.close();
		        con.close();
		        rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		out.println("SR 목록 테스트 완료");
		
	} catch (ClassNotFoundException e) {
		
		e.printStackTrace();
	}
%>