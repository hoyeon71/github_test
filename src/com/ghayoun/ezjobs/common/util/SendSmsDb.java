package com.ghayoun.ezjobs.common.util;
import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.net.ConnectException;
import java.net.Socket;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.jcraft.jsch.Logger;

//import com.initech.util.BufferedInputStream;
//import com.initech.util.BufferedOutputStream;

public class SendSmsDb {

	private static final Log logger = LogFactory.getLog(SendSmsDb.class);

	public static int sendSmsDb(String strUserHp, String strFullMsg) throws Exception {
		
		int iRetrunCode = 0;
		
		// SMS 정보
		String strSmsHost		= CommonUtil.isNull(CommonUtil.getMessage("SMS.HOST"));
		String strSmsUserId		= CommonUtil.isNull(CommonUtil.getMessage("SMS.USER_ID"));
		String strSmsUserPw		= CommonUtil.isNull(CommonUtil.getMessage("SMS.USER_PW"));
		String strSendPhone		= CommonUtil.isNull(CommonUtil.getMessage("SEND_PHONE"));
		
		String strDriver 		= "oracle.jdbc.driver.OracleDriver";
		String strConnection 	= "jdbc:oracle:thin:@" + strSmsHost;
		String strUser 			= strSmsUserId;
		String strPassword 		= strSmsUserPw;
		
		strFullMsg = CommonUtil.subStrBytes(strFullMsg, 90);
		
		Connection conn 		= null;
		PreparedStatement pstmt = null;
		
		try {
		
			Class.forName(strDriver);
			
			conn = DriverManager.getConnection(strConnection, strUser, strPassword);
			
			String sql 	= 	" INSERT INTO T_SMS_SD (msg_key, callee_no, callback_no, sms_msg, save_time, send_time)	";
			sql			+=	" VALUES (?, ?, ?, ?, ?, ?) 															";
			
			pstmt = conn.prepareStatement(sql);
			
			int nRand 				= new Integer(new SimpleDateFormat("HHmmssSSS").format(new Timestamp(System.currentTimeMillis()))).intValue();
			java.util.Date now		= new java.util.Date();
			SimpleDateFormat format	= new SimpleDateFormat("yyyyMMddHHmmss");
			String nowStr			= format.format(now);

			pstmt.setInt(1, nRand);
			pstmt.setString(2, strUserHp);
			pstmt.setString(3, strSendPhone);
			pstmt.setString(4, strFullMsg);
			pstmt.setString(5, nowStr);
			pstmt.setString(6, nowStr);

			iRetrunCode = pstmt.executeUpdate();
		
			logger.info("iRetrunCode : " + iRetrunCode);

		} catch (Exception e) {
			
			System.out.println(e.toString());
			logger.error("e.toString() : " + e.toString());

		} finally {
			
			try{ if(conn != null) conn.close(); } catch(Exception e){}
			try{ if(pstmt != null) pstmt.close(); } catch(Exception e){}
		}
		
		return iRetrunCode;
	}
}