import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.net.ConnectException;
import java.net.Socket;

import com.ghayoun.ezjobs.common.util.CommonUtil;

public class wb_test {

	public static void main(String[] args) {
		
		try {
			String strBindResult = wbBind();
			
			//strBindResult = "0001";
			
			if ( strBindResult.equals("0000") ) {
				
				String strSmsResult = wbDeliverSms();
				
				if ( strSmsResult.equals("0000") ) {
					
					System.out.println("SMS 발송 성공!!");
				}
				
			} else {
				
				System.out.println("strBindResultMent : " + CommonUtil.isNull(CommonUtil.getMessage("ERROR.BIND." + strBindResult)));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public static String wbBind() throws Exception {
		
		DataOutputStream out 	= null;
		DataInputStream in 		= null;
		Socket socket			= null;
		
		try {			
			
			//String strSmsHost		= "10.225.205.57";
			String strSmsHost		= "10.225.205.101";
			String strSmsPort		= "3000";
			String strResult 		= "";
			
			String MSGLEN 			= appendSpace("68", 10);
			String MSGTYPE 			= appendSpace("0001", 4);
			
			String strBindId		= appendSpace("WBTS0008", 16);
			String strBindPwd		= appendSpace("WBTS0008", 16);
			String strLineType 		= appendSpace("S", 1);
			String strVersion 		= appendSpace("", 31);
				
			String strHeader 		= MSGLEN + MSGTYPE;
			String strBody 			= strBindId + strBindPwd + strLineType + strVersion;
			String strTotalContent 	= strHeader + strBody;
			
			socket 	= new Socket(strSmsHost, Integer.parseInt(strSmsPort));
			
			in		= new DataInputStream(new BufferedInputStream(socket.getInputStream()));
			out 	= new DataOutputStream(new BufferedOutputStream(socket.getOutputStream()));
			
			System.out.println("Bind start");
			System.out.println("Bind : " + strTotalContent);

			out.write(strTotalContent.getBytes());
			
			out.flush();
			
			int iAckSize 		= 56;
			String StrAckReturn = "";
			byte[] BUFFER 		= new byte[iAckSize];
					
			while (StrAckReturn.length() < iAckSize) {
				in.read(BUFFER);
				StrAckReturn = new String(BUFFER, "EUC-KR");
		    }
			
			System.out.println("StrAckReturn : "  + StrAckReturn);
			
			// ACK 처리.			
			if ( !StrAckReturn.equals("") && StrAckReturn.length() == 56 ) {
				strResult = StrAckReturn.substring(14, 18);
			}
			
			out.close();
			
			System.out.println("Bind strResult : " + strResult);
			System.out.println("Bind end");
			
			socket.close();
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
			socket.close();
			in.close();
			out.close();
		}
	}
	
	
	public static String wbDeliverSms() throws Exception {
		
		DataOutputStream out 	= null;
		DataInputStream in 		= null;
		Socket socket			= null;
		
		try {			
			
			String message		= "Ended not OK";
			String strTitle		= "";
			String strServerGb 	= CommonUtil.isNull(CommonUtil.getMessage("SERVER_GB"));
			
			if ( strServerGb.equals("D") ) {
				
				if ( message.equals("Ended not OK") ) {
					strTitle = "[개발]배치에러";
				} else if ( message.equals("Ended OK") ) { 
					strTitle = "[개발]배치성공";
				} else if ( message.equals("LATE_SUB") ) { 
					strTitle = "[개발]배치시작임계시간";
				} else if ( message.equals("LATE_TIME") ) { 
					strTitle = "[개발]배치종료임계시간";
				} else if ( message.equals("LATE_EXEC") ) { 
					strTitle = "[개발]배치수행임계시간";
				}
				
			} else {
				
				if ( message.equals("Ended not OK") ) {
					strTitle = "[운영]배치에러";
				} else if ( message.equals("Ended OK") ) { 
					strTitle = "[운영]배치성공";
				} else if ( message.equals("LATE_SUB") ) { 
					strTitle = "[운영]배치시작임계시간";
				} else if ( message.equals("LATE_TIME") ) { 
					strTitle = "[운영]배치종료임계시간";
				} else if ( message.equals("LATE_EXEC") ) { 
					strTitle = "[운영]배치수행임계시간";
				}
			}
			
			String fullMsg = strTitle + "[작업명:ABCDE][작업설명:테스트작업]";
			
			if ( fullMsg.length() > 80 ) {
				fullMsg.substring(0, 80);
			}
			
			String strSmsHost		= "10.225.205.57";
			String strSmsPort		= "3000";
			String strResult 		= "";
			
			String MSGLEN 			= appendSpace("757", 10);
			String MSGTYPE 			= appendSpace("0002", 4);

			String SN 				= appendSpace("ABCDEFGTEST7", 20);
			String USER_ID 			= appendSpace("90148345", 20);
			String COMP_CD 			= appendSpace("001001", 6);
			String PLACE_CD 		= appendSpace("ADMIN", 10);
			String BIZ_ID1 			= appendSpace("BATCH_JOB", 10);
			String BIZ_ID2 			= appendSpace("JOB_ERROR", 10);
			String CUST_ID 			= appendSpace("", 20);
			String COMP_KEY 		= appendSpace("", 40);
			String PLACE_PCD 		= appendSpace("", 10);
			String DESTADDR 		= appendSpace("01085696698", 16);
			String CALLBACK 		= appendSpace("15995000", 16);
			String SMS_TYPE 		= appendSpace("0", 1);
			String SEND_TIME 		= appendSpace("", 14);
			String TEXT 			= appendSpace("[테스트]배치에러[작업명:테스트][작업설명:테스트]", 160);
			//String TEXT 			= appendSpace("[test]batch_error[job_name:test][description:test]", 160);
			String USER_FIELD1 		= appendSpace("", 100);
			String USER_FIELD2 		= appendSpace("", 100);
			String USER_FIELD3 		= appendSpace("", 100);
			String USER_FIELD4 		= appendSpace("EZJOBSTEST3|Y", 100);
			
			//TEXT = new String(TEXT.getBytes("UTF-8"), "EUC-KR");
			
			String strHeader 		= MSGLEN + MSGTYPE;
			String strBody 			= SN + USER_ID + COMP_CD + PLACE_CD + BIZ_ID1 + BIZ_ID2 + CUST_ID + COMP_KEY
								 		+ PLACE_PCD + DESTADDR + CALLBACK + SMS_TYPE + SEND_TIME + TEXT
								 		+ USER_FIELD1 + USER_FIELD2 + USER_FIELD3 + USER_FIELD4;
			String strTotalContent 	= strHeader + strBody;
			
			socket 	= new Socket(strSmsHost, Integer.parseInt(strSmsPort));
			
			in		= new DataInputStream(new BufferedInputStream(socket.getInputStream()));
			out 	= new DataOutputStream(new BufferedOutputStream(socket.getOutputStream()));
			
			System.out.println("wbDeliverSms start");
			System.out.println("wbDeliverSms : " + strTotalContent);
			
			//strTotalContent = new String(strTotalContent.getBytes("utf-8"), "euc-kr");
			//strTotalContent = new String(strTotalContent.getBytes("euc-kr"));
			//strTotalContent = new String(strTotalContent.getBytes("8859_1"));
			//strTotalContent		= new String(new String(strTotalContent.getBytes("UTF-8"), "8859_1").getBytes("8859_1"));
			
			System.out.println("strTotalContent : " + strTotalContent);
			//strTotalContent = new String(strTotalContent, "UTF-8");
			out.write(strTotalContent.getBytes("euc-kr"));
			
			out.flush();
			
			int iAckSize 		= 186;
			String StrAckReturn	= "";
			byte[] BUFFER 		= new byte[iAckSize];
					
			while (StrAckReturn.length() < iAckSize) {
				in.read(BUFFER);
				StrAckReturn = new String(BUFFER, "EUC-KR");
		    }
			
			System.out.println("StrAckReturn : "  + StrAckReturn);
			
			// ACK 처리.			
			if ( !StrAckReturn.equals("") && StrAckReturn.length() == 186 ) {
				strResult = StrAckReturn.substring(14, 18);
			}
			
			out.close();
			
			System.out.println("wbDeliverSms strResult : " + strResult);
			System.out.println("wbDeliverSms end");
			
			socket.close();
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
