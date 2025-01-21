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

public class SendAutoCall {

	public static String autoCall(String job_name, String description, String phoneNo, String strTitle) throws Exception {
		
		String strSmsResult 	= "";
		
		String strAutoCallHost	= CommonUtil.isNull(CommonUtil.getMessage("AUTOCALL.HOST"));
		String strAutoCallPort	= CommonUtil.isNull(CommonUtil.getMessage("AUTOCALL.PORT"));
		Socket socket 			= new Socket(strAutoCallHost, Integer.parseInt(strAutoCallPort));
		DataInputStream in		= new DataInputStream(new BufferedInputStream(socket.getInputStream()));
		DataOutputStream out	= new DataOutputStream(new BufferedOutputStream(socket.getOutputStream()));
		
		socket.setKeepAlive(true);
		
		try {
			
			String strServerGb 		= CommonUtil.isNull(CommonUtil.getMessage("SERVER_GB"));
			String strServerGbMent	= "";
			
			String fullMsg 		= strTitle + "작업명:"+ job_name +"작업설명:" + description + "";
			String currentTime 	= new SimpleDateFormat("yyyyMMddHHmmss").format(new java.util.Date());
			String strResult 	= "";
			
			String KEY_NUMBER	= appendSpace("4700", 4);
			String SEND_TIME	= appendSpace(currentTime, 14);
			String RETURN_CODE	= appendSpace("", 2);
			String CALL_KEY 	= appendSpace("EZJOBS", 10);
			String PHONE_SET	= appendSpace("01", 2);
			String PHONE1 		= appendSpace(phoneNo, 12);
			String PHONE2 		= appendSpace("", 12);
			String PHONE3 		= appendSpace("", 12);
			String PHONE4 		= appendSpace("", 12);
			String PHONE5 		= appendSpace("", 12);
			String DUMMY 		= appendSpace("", 10);
			String DATA_LENGTH 	= appendSpace(Integer.toString(fullMsg.length()), 4);
			String DATA		 	= appendSpace(fullMsg, fullMsg.length());
			
			String strBody 		= KEY_NUMBER + SEND_TIME + RETURN_CODE + CALL_KEY + PHONE_SET + PHONE1 + PHONE2 + PHONE3
					 			+ PHONE4 + PHONE5 + DUMMY + DATA_LENGTH + DATA;
			
			String strTotalContent = strBody;
			
			System.out.println("autoCall start");
			System.out.println("autoCall : " + strTotalContent);

			out.write(strTotalContent.getBytes("EUC-KR"));
			
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
				strResult = StrAckReturn.substring(18, 20);
				strResult = CommonUtil.isNull(CommonUtil.getMessage("ERROR.AUTOCALL." + strResult));
			}
			
			System.out.println("autoCall end");
			System.out.println("autoCall : " + strResult);
			
			socket.close();
			in.close();
			out.close();
			
			// 오토콜 서버의 키 값 [currentTime, 핸드폰 번호]
			strResult = strResult + currentTime;
			
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
			socket.close();
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