
<%@page import="java.time.LocalDateTime"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="com.ghayoun.ezjobs.common.util.SeedUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@page import="com.ghayoun.ezjobs.common.util.CommonUtil"%>
<%@page import="com.ghayoun.ezjobs.common.util.DbUtil"%>
<%@ page import="java.sql.*" %>

<%	
	Connection conn			= null;
	PreparedStatement ps 	= null;
	ResultSet rs 			= null;

	String strDbGubun		= CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"));
	String strDbSchema		= CommonUtil.isNull(CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
	String strOtp			= CommonUtil.isNull(request.getParameter("otp"));
	String strUserCd		= CommonUtil.isNull(request.getParameter("user_cd"));
	String strSql			= "";
	String strOtpResult		= "";

	com.ghayoun.ezjobs.common.util.CryptoDataSource ds = CommonUtil.getDataSourceWorks();
	conn = DbUtil.getConnection(ds);
	
	try {
		
		if ( strDbGubun.equals("ORACLE") ) {
			strSql = "SELECT otp, otp_time, TO_CHAR(ins_date, 'YYYY-MM-DD HH24:MI:SS') AS ins_date FROM " + strDbSchema + ".ez_otp WHERE otp_cd = (SELECT MAX(otp_cd) FROM " + strDbSchema + ".ez_otp WHERE ins_user_cd = ?) ";	
		} else {
			strSql = "SELECT otp, otp_time, TO_CHAR(ins_date, 'YYYY-MM-DD HH24:MI:SS') AS ins_date FROM " + strDbSchema + ".ez_otp WHERE otp_cd = (SELECT MAX(otp_cd) FROM " + strDbSchema + ".ez_otp WHERE ins_user_cd = ?) ";	
		}
		
		ps = conn.prepareStatement(strSql);
 
		ps.setInt(1, Integer.parseInt(strUserCd));

		rs = ps.executeQuery();
		
		if ( rs.next() ) {
			
            String otp 			= SeedUtil.decodeStr(CommonUtil.isNull(rs.getString("otp")));
            String otp_time 	= CommonUtil.isNull(rs.getString("otp_time"));
            String ins_date 	= CommonUtil.isNull(rs.getString("ins_date"));
            
            System.out.println("Latest OTP: " + otp);
            System.out.println("otp_time: " + otp_time);
            System.out.println("ins_date: " + ins_date);
            
            if ( otp.equals(strOtp) ) {
            	
				// DateTimeFormatter를 사용하여 문자열을 LocalDateTime 객체로 파싱
                DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
                LocalDateTime insDate = LocalDateTime.parse(ins_date, formatter);
                
                // 현재 날짜와 시간에서 otp_time을 뺀다.
                LocalDateTime nowMinusMinutes = LocalDateTime.now().minusMinutes(Integer.parseInt(otp_time));
                
                // 비교
                if (nowMinusMinutes.isAfter(insDate)) {
                	strOtpResult = "OTP 인증시간을 초과하였습니다.";
                } else {
                	strOtpResult = "성공";
                }
            	
            } else {
            	strOtpResult = "OTP 인증에 실패하였습니다.";
            }
            
        } else {
        	strOtpResult = "OTP 번호가 없습니다.";
        }
		
		out.println(strOtpResult);
			
	}catch (Exception e) {
		
		System.out.println(e.getMessage());
		
		try {if(rs!=null) rs.close();}catch(Exception ee){}
		try {if(ps!=null) ps.close();}catch(Exception ee){}
		try {if(conn!=null) conn.close();}catch(Exception ee){}
		
	}finally {
		
		try {if(rs!=null) rs.close();}catch(Exception e){}
		try {if(ps!=null) ps.close();}catch(Exception e){}
		try {if(conn!=null) conn.close();}catch(Exception e){}
	}
%>