
<%@page import="com.ghayoun.ezjobs.common.util.CommonUtil"%>
<%@page import="com.ghayoun.ezjobs.common.util.Crypto"%>
<%@page import="com.ghayoun.ezjobs.common.util.SeedUtil"%>
<%@page import="com.ghayoun.ezjobs.common.util.DateUtil"%><%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%	
	String strDbUrl 		= "jdbc:postgresql://192.168.10.54:15433/emdb";
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
		strSql = "select grp_cd from ezjobs_sc_test.ez_app_grp_code where grp_depth = '2'";
		
		ResultSet rs = stmt.executeQuery(strSql);
		int i = 1593;
		while ( rs.next() ) {
			//i = 1+i;
			out.println("rs : " + i);
			//out.println(CommonUtil.toSha512(SeedUtil.decodeStr(rs.getString(2)))+"\n");
			strSql = "insert into ezjobs_sc_test.ez_app_grp_code (grp_cd, grp_eng_nm, grp_depth, grp_parent_cd, grp_use_yn, grp_desc, grp_ins_date, grp_ins_user_cd, scode_cd, host_cd, user_daily) values ";
			strSql += "(" + i;
			strSql += ", 'Y', '3', ";
			strSql += rs.getString(1) + ", 'Y', 'Y', '20201105120000', 1, 'S54', 4, '')";
			
			out.println(strSql+"\n");
			
			pstmt = conn.prepareStatement(strSql);
			
			pstmt.executeUpdate();
			
			//stmt.executeQuery(strSql);
			
			i++;
		}
		
		conn.close();
		stmt.close();
		rs.close();
		
	} catch (Exception e) {
		out.println(e.getMessage());
	}

%>