
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.ghayoun.ezjobs.common.util.CommonUtil"%>
<%@page import="com.ghayoun.ezjobs.common.util.Crypto"%>
<%@page import="com.ghayoun.ezjobs.common.util.SeedUtil"%>
<%@page import="com.ghayoun.ezjobs.common.util.DateUtil"%><%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%	
	String strDbUrl 		= "jdbc:oracle:thin:@xxxxxxx:1521/ISDDBP";
	String strDbUser 		= "xxxxxx";
	String strDbPassword 	= "xxxxxxx";
	String strSql			= "";
	
	Connection conn 		= null;
	PreparedStatement pstmt	= null;
	
	try {
		
		Class.forName("oracle.jdbc.driver.OracleDriver");
		conn = DriverManager.getConnection(strDbUrl, strDbUser, strDbPassword);
		
		strSql 	= " INSERT INTO T_SMS_SD (msg_key, callee_no, callback_no, sms_msg, save_time, send_time) 	";
		strSql += " VALUES (?, ?, ?, ?, ?, ?)																";
		
		pstmt = conn.prepareStatement(strSql);
		
		int nRand 				= new Integer(new SimpleDateFormat("HHmmssSSS").format(new Timestamp(System.currentTimeMillis()))).intValue();
		String phone			= "01031602836";
		String sender			= "1";
		String msg				= "[SMS 테스트] 배치 작업 오류 발생입니다.";
		
		java.util.Date now		= new java.util.Date();
		SimpleDateFormat format	= new SimpleDateFormat("yyyyMMddHHmmss");
		String nowStr			= format.format(now);
		
		pstmt.setInt(1, nRand);
		pstmt.setString(2, "01031602836");
		pstmt.setString(3, "027307472");
		
		//pstmt.setString(2, "01077081623");
		//pstmt.setString(3, "027307472");
		
		pstmt.setString(4, msg);
		pstmt.setString(5, nowStr);
		pstmt.setString(6, nowStr);
		
		out.println("strSql : " + strSql);
		out.println("<BR>");
		
		int cnt = pstmt.executeUpdate();
		
		out.println("cnt : " + cnt);
		
		conn.close();
		pstmt.close();
		
	} catch (Exception e) {
		out.println(e.getMessage());
		
	}finally{
		try{ if(conn != null) conn.close(); } catch(Exception ee){}
		try{ if(pstmt != null) pstmt.close(); } catch(Exception e){}
	}
%>