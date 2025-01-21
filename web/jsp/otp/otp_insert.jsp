
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
	String strUserCd		= CommonUtil.isNull(request.getParameter("user_cd"));
	String strSql			= "";
	

	com.ghayoun.ezjobs.common.util.CryptoDataSource ds = CommonUtil.getDataSourceWorks();
	conn = DbUtil.getConnection(ds);
	
	try {
		
		if ( strDbGubun.equals("ORACLE") ) {
			strSql = 	"INSERT INTO " + strDbSchema + ".ez_otp (otp_cd, otp, otp_time, ins_date, ins_user_cd, ins_user_ip) 			";
			strSql += 	"VALUES ((SELECT NVL(MAX(otp_cd), 0) + 1 FROM " + strDbSchema + ".ez_otp), ?, ?, ?, ?, ?) 						";	
		} else {
			strSql = 	"INSERT INTO " + strDbSchema + ".ez_otp (otp_cd, otp, otp_time, ins_date, ins_user_cd, ins_user_ip) 			";
			strSql += 	"VALUES ((SELECT " + strDbSchema + ".NVL(MAX(otp_cd), 0) + 1 FROM " + strDbSchema + ".ez_otp), ?, ?, ?, ?, ?) 	";	
		}
		
		ps = conn.prepareStatement(strSql);

		// 랜덤 숫자 발행
		int digitCount 	= Integer.parseInt(CommonUtil.isNull(CommonUtil.getMessage("OTP_LENGTH"))); // 원하는 자릿수 설정
        int min 		= (int) Math.pow(10, digitCount - 1);
        int max 		= (int) Math.pow(10, digitCount) - 1;
        int randomNum 	= (int) (Math.random() * (max - min + 1)) + min;
		System.out.println(randomNum);
        String strRandomNumEnc = SeedUtil.encodeStr(Integer.toString(randomNum));
        
        // 현재 날짜
        Timestamp timestamp = new Timestamp(System.currentTimeMillis());

		ps.setString(1, 	strRandomNumEnc);
		ps.setString(2, 	CommonUtil.isNull(CommonUtil.getMessage("OTP_TIME")));
		ps.setTimestamp(3, 	timestamp);
		ps.setInt(4, 		Integer.parseInt(strUserCd));
		ps.setString(5, 	CommonUtil.getRemoteIp(request));

		ps.executeUpdate();
			
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