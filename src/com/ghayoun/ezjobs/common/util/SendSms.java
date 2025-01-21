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
import java.text.SimpleDateFormat;

//import com.initech.util.BufferedInputStream;
//import com.initech.util.BufferedOutputStream;

public class SendSms {

	public static String smsCall(String job_name, String description, String phoneNo, String strTitle, String strDataCenter, String strOrderId, String strNum, String strNum2, String deptCode) throws Exception {
		
		String strSendResult 	= "";
		
		String strSmsHost		= CommonUtil.isNull(CommonUtil.getMessage("SMS.HOST"));
		String strSmsPort		= CommonUtil.isNull(CommonUtil.getMessage("SMS.PORT"));
		Socket socket 			= new Socket(strSmsHost, Integer.parseInt(strSmsPort));
		DataInputStream in		= new DataInputStream(new BufferedInputStream(socket.getInputStream()));
		DataOutputStream out	= new DataOutputStream(new BufferedOutputStream(socket.getOutputStream()));
		
		socket.setKeepAlive(true);
		
		try {
			
			strSendResult = wbSend(socket, in, out, job_name, description, phoneNo, strTitle, strDataCenter, strOrderId, strNum, strNum2, deptCode);
			
			//socket.close();
			//in.close();
			//out.close();
			
		} catch (Exception e) {
			strSendResult = "시스템 에러";
			e.printStackTrace();
			
			//socket.close();
			//in.close();
			//out.close();
			
		} finally {
			//socket.close();
			//in.close();
			//out.close();
		}
		
		return strSendResult;
	}
	
	public static String wbSend(Socket socket, DataInputStream in, DataOutputStream out, String job_name, String description, String phoneNo, String strTitle, String strDataCenter, String strOrderId, String strNum, String strNum2, String deptCode) throws Exception {

		try {
			
			String strSysout 	= "";
			String strBindId	= "WBTS0008";
			String strBindPwd	= "WBTS0008";
			
			socket.setKeepAlive(true);
			
			/*
			// 성공 or 실패일 경우 sysout 마지막 한 줄 추가해서 발송
			if ( strTitle.indexOf("배치에러") > -1 || strTitle.indexOf("배치성공") > -1 ) {
				strSysout 	= CommonUtil.activeSysoutView(strDataCenter, strOrderId, strRunCounter);
				description	= description + " SYSOUT:" + strSysout;
			}
			*/
			
			String fullMsg = strTitle + "[작업명:"+ job_name +"][작업설명: " + description + "]";
			
			if ( fullMsg.getBytes().length > 80 ) {
				strBindId 	= "WBTS0009";
				strBindPwd 	= "WBTS0009";
			}
			
			String strSmsHost		= CommonUtil.isNull(CommonUtil.getMessage("SMS.HOST"));
			String strSmsPort		= CommonUtil.isNull(CommonUtil.getMessage("SMS.PORT"));
			String strBindResult	= "";
			String strSmsResult		= "";
			
			String MSGLEN 			= appendSpace("68", 10);
			String MSGTYPE 			= appendSpace("0001", 4);
			
			strBindId				= appendSpace(strBindId, 16);
			strBindPwd				= appendSpace(strBindPwd, 16);
			String strLineType 		= appendSpace("S", 1);
			String strVersion 		= appendSpace("", 31);
				
			String strHeader 		= MSGLEN + MSGTYPE;
			String strBody 			= strBindId + strBindPwd + strLineType + strVersion;
			String strTotalContent 	= strHeader + strBody;
			
			System.out.println("strNum : " + strNum);
			System.out.println("strNum2 : " + strNum2);
			
			//if ( strNum.equals("1") && strNum2.equals("1") ) {
			
				in		= new DataInputStream(new BufferedInputStream(socket.getInputStream()));			
				
				System.out.println("Bind start");
				System.out.println("Bind : " + strTotalContent);
	
				out.write(strTotalContent.getBytes());
				out.flush();
				
				int iAckSize 		= 56;
				String StrAckReturn = "";
				byte[] BUFFER 		= new byte[iAckSize];
						
				while (StrAckReturn.length() < iAckSize) {
					in.read(BUFFER);
					StrAckReturn = new String(BUFFER, "UTF-8");
			    }
				
				System.out.println("StrAckReturn : "  + StrAckReturn);
				
				// ACK 처리.
				if ( !StrAckReturn.equals("") && StrAckReturn.length() == 56 ) {
					strBindResult = StrAckReturn.substring(14, 18);
				}
				
				System.out.println("Bind strBindResult : " + strBindResult);
				System.out.println("Bind end");
			
			
			// 접속 성공.
			if ( strBindResult.equals("0000") ) {
				
				String strDeliverResult = wbDeliverSms(socket, in, out, phoneNo, fullMsg, strTitle, strNum, deptCode);
				
				// 발송 실패.
				if ( !strDeliverResult.equals("0000") ) {
					strSmsResult = CommonUtil.isNull(CommonUtil.getMessage("ERROR.DELIVER." + strDeliverResult));
				} else {
					strSmsResult = "발송 성공";
				}
				
			} else {
				System.out.println("바인드 실패로 재호출");
				in.close();
				out.close();
				return smsCall(job_name, description, phoneNo, strTitle, strDataCenter, strOrderId, strNum, strNum2, deptCode);
			}
			in.close();
			out.close();
			return strSmsResult;			

		}catch(ConnectException e){
		    e.printStackTrace();
		    throw e;
		}catch(IOException e){
		    e.printStackTrace();
		    throw e;
		}catch(Exception e){
		    e.printStackTrace();
		    throw e;
		} finally {
			in.close();
			out.close();
		}
	}
	
	
	public static String wbDeliverSms(Socket socket, DataInputStream in, DataOutputStream out, String phoneNo, String fullMsg, String strTitle, String strNum, String deptCode) throws Exception {
		
		try {
			
			String strServerGb 		= CommonUtil.isNull(CommonUtil.getMessage("SERVER_GB"));
			String strServerGbMent	= "";
			
			String strMsgType 		= "0002";
			
			if ( fullMsg.getBytes().length > 80 ) {
				strMsgType = "0003";
			}
			
			String currentTime 		= new SimpleDateFormat("yyyyMMddHHmmss").format(new java.util.Date());
			
			// 중복 SN를 방지하기 위해 핸드폰 번호 가운데 4자리 추출해서 SN에 셋팅
			String strRandomNum	= "";
			if ( phoneNo.length() > 7 ) {
				//strRandomNum = phoneNo.substring(3, 6) + strNum;
				strRandomNum = phoneNo.substring(3, 7);
			}
			
			String strSmsHost		= CommonUtil.isNull(CommonUtil.getMessage("SMS.HOST"));
			String strSmsPort		= CommonUtil.isNull(CommonUtil.getMessage("SMS.PORT"));
			String strSmsUserId		= CommonUtil.isNull(CommonUtil.getMessage("SMS.USER_ID"));
			String strSmsUserField4	= CommonUtil.isNull(CommonUtil.getMessage("SMS.USER_FIELD4"));
			String strResult 		= "";
			
			String MSGLEN			= "";
			
			if ( fullMsg.getBytes().length > 80 ) {			
				MSGLEN 			= appendSpace("2834", 10);
			} else {
				MSGLEN 			= appendSpace("757", 10);
			}
			
			String MSGTYPE 			= appendSpace(strMsgType, 4);

			String SN 				= appendSpace("EZ" + strRandomNum + currentTime, 20);
			String USER_ID 			= appendSpace(strSmsUserId, 20);
			String COMP_CD 			= appendSpace("001001", 6);
			String PLACE_CD 		= appendSpace(deptCode, 10);
			String BIZ_ID1 			= appendSpace("BATCH_JOB", 10);
			String BIZ_ID2 			= appendSpace("JOB_ERROR", 10);
			String CUST_ID 			= appendSpace("", 20);
			String COMP_KEY 		= appendSpace("", 40);
			String PLACE_PCD 		= appendSpace("", 10);
			String DESTADDR 		= appendSpace(phoneNo, 16);
			String CALLBACK 		= appendSpace("0231515160", 16);
			String SMS_TYPE 		= appendSpace("0", 1);
			String SEND_TIME 		= appendSpace("", 14);
			String TEXT 			= appendSpace(fullMsg, 160);
			String USER_FIELD1 		= appendSpace("", 100);
			String USER_FIELD2 		= appendSpace("", 100);
			String USER_FIELD3 		= appendSpace("", 100);
			String USER_FIELD4 		= appendSpace(strSmsUserField4 + "|Y", 100);
			
			String SUBJECT	 		= appendSpace(strTitle, 160);
			String CONTENTS_CNT		= appendSpace("1", 4);
			String CONTENTS_TYPE	= appendSpace("TXT", 4);
			String CONTENTS_NAME	= appendSpace("EZJOBS.TXT", 60);
			String CONTENTS_LEN		= appendSpace(Integer.toString(fullMsg.getBytes().length), 10);
			String CONTENTS_DATA	= appendSpace(fullMsg, 2000);
			
			String strHeader 		= MSGLEN + MSGTYPE;
			String strBody			= "";
			
			if ( fullMsg.getBytes().length > 80 ) {
				strBody = SN + USER_ID + COMP_CD + PLACE_CD + BIZ_ID1 + BIZ_ID2 + CUST_ID + COMP_KEY
				 		+ PLACE_PCD + DESTADDR + CALLBACK + SEND_TIME
				 		+ USER_FIELD1 + USER_FIELD2 + USER_FIELD3 + USER_FIELD4
				 		+ SUBJECT + CONTENTS_CNT + CONTENTS_TYPE + CONTENTS_NAME + CONTENTS_LEN + CONTENTS_DATA;
			} else {
				strBody = SN + USER_ID + COMP_CD + PLACE_CD + BIZ_ID1 + BIZ_ID2 + CUST_ID + COMP_KEY
				 		+ PLACE_PCD + DESTADDR + CALLBACK + SMS_TYPE + SEND_TIME + TEXT
				 		+ USER_FIELD1 + USER_FIELD2 + USER_FIELD3 + USER_FIELD4;
			}
			 
			String strTotalContent 	= strHeader + strBody;
			
			in		= new DataInputStream(new BufferedInputStream(socket.getInputStream()));			
			
			System.out.println("wbDeliverSms start");
			System.out.println("wbDeliverSms : " + strTotalContent);

			out.write(strTotalContent.getBytes("EUC-KR"));
			
			out.flush();
			
			int iAckSize 		= 186;
			String StrAckReturn	= "";
			byte[] BUFFER 		= new byte[iAckSize];
					
			while (StrAckReturn.length() < iAckSize) {
				in.read(BUFFER);
				StrAckReturn = new String(BUFFER, "UTF-8");
		    }
			
			System.out.println("StrAckReturn : "  + StrAckReturn);
			
			// ACK 처리.
			if ( !StrAckReturn.equals("") && StrAckReturn.length() == 186 ) {
				strResult = StrAckReturn.substring(14, 18);
			}
			
			System.out.println("strResult : "  + strResult);
			
			//out.close();
			
			System.out.println("wbDeliverSms end");
			
			in.close();
			out.close();
			
			return strResult;

		}catch(ConnectException e){
		    e.printStackTrace();
		    throw e;
		}catch(IOException e){
		    e.printStackTrace();
		    throw e;
		}catch(Exception e){
		    e.printStackTrace();
		    throw e;
		} finally {
			in.close();
			out.close();
		}	
	}
	
	public static String appendSpace(String str, int len) {
		
		int strLength = str.getBytes().length;
		String tempStr = str;
		
		if ( strLength < len ) {
			int endCount = len - strLength;
			
			for ( int i = 0; i < endCount; i++ ) {
				str = str + " ";
			}
		} else if ( strLength > len ) {
			byte[] temp = new byte[len];
			System.arraycopy(str.getBytes(), 0, temp, 0, len);
			
			str = new String(temp);
		} else {
			
		}
		
		if ( str.length() == 0 ) {
			byte[] temp = new byte[len];
			System.arraycopy(tempStr.getBytes(), 0, temp, 0, len - 1);
			str = new String(temp);
		}
		
		return str;
	}
}