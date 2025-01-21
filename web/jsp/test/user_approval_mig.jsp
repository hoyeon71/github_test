
<%@page import="com.ghayoun.ezjobs.common.util.CommonUtil"%>
<%@page import="com.ghayoun.ezjobs.common.util.Crypto"%>
<%@page import="com.ghayoun.ezjobs.common.util.SeedUtil"%>
<%@page import="com.ghayoun.ezjobs.common.util.DateUtil"%><%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%	
	String strDbUrl 		= "jdbc:postgresql://pimaap1:14692/emdb";
	String strDbUser 		= "emuser";
	String strDbPassword 	= "empass";
	String strSql			= "";
	
	Connection conn;
	Statement stmt;
	PreparedStatement pstmt	= null;
	try {
		
		Class.forName("org.postgresql.Driver");
		conn = DriverManager.getConnection(strDbUrl, strDbUser, strDbPassword);
		stmt = conn.createStatement();
		strSql = "select user_cd from ezjobs_jbb.ez_user where user_cd not in (select owner_user_cd from ezjobs_jbb.ez_user_approval_group)";
		
		ResultSet rs = stmt.executeQuery(strSql);
		while ( rs.next() ) {
			
			String strUserCd = CommonUtil.isNull(rs.getString(1));
			out.println("strUserCd : " + strUserCd);
			strSql = "insert into ezjobs_jbb.ez_user_approval_group (line_grp_cd, line_grp_nm, owner_user_cd, ins_date, ins_user_cd) values ";
			strSql += "((select max(line_grp_cd)+1 from ezjobs_jbb.ez_user_approval_group ), '개인결재선', "+strUserCd+", current_timestamp, "+strUserCd+")";
			
			pstmt = conn.prepareStatement(strSql);
			pstmt.executeUpdate();
		}
		
		
		conn.close();
		stmt.close();
		rs.close();
		pstmt.close();
		
		
		conn = DriverManager.getConnection(strDbUrl, strDbUser, strDbPassword);
		stmt = conn.createStatement();
		
		
		strSql = "select seq, user_cd, ins_user_cd from ezjobs_jbb.ez_approval_line_asis where ins_user_cd in (select owner_user_cd from ezjobs_jbb.ez_user_approval_group where owner_user_cd not in (select ins_user_cd from ezjobs_jbb.ez_user_approval_line))";
		
		ResultSet rs2 = stmt.executeQuery(strSql);
		while ( rs2.next() ) {
			String strSeq = CommonUtil.isNull(rs2.getString(1));
			String strUserCd = CommonUtil.isNull(rs2.getString(2));
			String strInsUserCd = CommonUtil.isNull(rs2.getString(3));
			out.println("strInsUserCd : " + strInsUserCd);
			strSql = "insert into ezjobs_jbb.ez_user_approval_line (line_cd, line_grp_cd, approval_cd, approval_seq, ins_date, ins_user_cd) values ";
			strSql += "((select max(line_cd)+1 from ezjobs_jbb.ez_user_approval_line ), (select line_grp_cd from ezjobs_jbb.ez_user_approval_group where owner_user_cd = '"+strInsUserCd+"'), "+strUserCd+", "+strSeq+",current_timestamp, "+strInsUserCd+")";
			
			pstmt = conn.prepareStatement(strSql);
			
			pstmt.executeUpdate();
			
		}
		
		conn.close();
		stmt.close();
		rs.close();
		rs2.close();
		pstmt.close();
		
	} catch (Exception e) {
		out.println(e.getMessage());
	}

%>