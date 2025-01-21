import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.ConnectException;
import java.net.Socket;
import java.text.SimpleDateFormat;
import java.util.Date;

import com.ghayoun.ezjobs.common.util.CommonUtil;

public class sms_test {

	public static void main(String[] args) {
		
		try {
			smsCall("1", "1", "01094511611", "1");
		} catch (Exception e) {
			e.printStackTrace();
		}

	}
	
	
	
	
	public static String smsCall(String job_name, String description, String phoneNo, String message) throws Exception {
		
		BufferedOutputStream out 	= null;
		BufferedInputStream in 		= null;
		BufferedReader br 			= null;
		Socket socket				= null;
		
		System.out.println("111");
		
		try {
			
			String strServerGb 	= "D";
			String strSmsHost	= "10.225.205.21";
			String strSmsPort	= "3000";
			String strResult 	= "";
			String strTitle		= "";
			
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
			
			String fullMsg = strTitle + "[" + job_name + "][" + description + "]";
			
			if ( fullMsg.length() > 80 ) {
				fullMsg.substring(0, 80);
			}
			
			String currentTime = new SimpleDateFormat("yyyyMMddHHmmss").format(new java.util.Date());
		
			String MSGLEN 			= appendSpace("557", 10);
			String MSGTYPE 			= "0002";
			
			String strHeader = 	MSGLEN + MSGTYPE;

			String SN 			= appendSpace("ABCDEFG123456789", 20);
			String USER_ID 		= appendSpace("90148345", 20);
			String COMP_CD 		= appendSpace("010001", 6);
			String PLACE_CD 	= appendSpace("B1F25", 10);
			String BIZ_ID1 		= appendSpace("BATCH_JOB", 10);
			String BIZ_ID2 		= appendSpace("JOB_ERROR", 10);
			String CUST_ID 		= appendSpace("", 20);
			String COMP_KEY 	= appendSpace("", 40);
			String PLACE_PCD 	= appendSpace("", 10);
			String DESTADDR 	= appendSpace("02-3151-5160", 16);
			String CALLBACK 	= appendSpace("02-3151-5160", 16);
			String SMS_TYPE 	= appendSpace("0", 1);
			String SEND_TIME 	= appendSpace("", 14);
			String TEXT 		= appendSpace(message, 160);
			String USER_FIELD1 	= appendSpace("", 100);
			String USER_FIELD2 	= appendSpace("", 100);
			String USER_FIELD3 	= appendSpace("", 100);
			
			String strBody = SN + USER_ID + COMP_CD + PLACE_CD + BIZ_ID1 + BIZ_ID2 + CUST_ID + COMP_KEY
					 		+ PLACE_PCD + DESTADDR + CALLBACK + SMS_TYPE + SEND_TIME + TEXT
					 		+ USER_FIELD1 + USER_FIELD2 + USER_FIELD3;
			
			String strTotalContent = strHeader + strBody;
			
			socket 	= new Socket(strSmsHost, Integer.parseInt(strSmsPort));
			
			in		= new BufferedInputStream(socket.getInputStream());
			out 	= new BufferedOutputStream(socket.getOutputStream());
			
			System.out.println("SMS 메세지 : " + strTotalContent);
			
			System.out.println("SMS connect start..");

			//out.write(header);
			//out.write(body);
			
			
			
			out.write(strTotalContent.getBytes());
			
			System.out.println("1");
			
			out.flush();
			
			String line = "";
					
			System.out.println("2");
			
			
			line += (char) in.read();
			
			
			System.out.println("aaaaaaaa : "  + line);
			
			out.close();
			
			
			
			System.out.println("SMS connect end...");
			
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
	
	public static byte[] setBytes(int startLength, int endLength, byte[] mainByte, byte[] srcBytes) {
		
		byte [] totalByte = new byte[endLength];
		
		System.arraycopy(srcBytes, 0, totalByte, 0, srcBytes.length);
		System.arraycopy(totalByte, 0, mainByte, startLength, endLength);
		
		System.out.println("mainByte : " + new String(mainByte));
		
		return mainByte;		
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
