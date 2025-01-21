import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.ConnectException;
import java.net.Socket;
import java.text.SimpleDateFormat;
import java.util.Date;

import com.ghayoun.ezjobs.common.util.CommonUtil;

public class call_test {

	public static void main(String[] args) {
		
		try {
			autoCall("1", "1", "01031602836", "1");
		} catch (Exception e) {
			e.printStackTrace();
		}

	}
	
	
	
	
	public static String autoCall(String job_name, String description, String phoneNo, String message) throws Exception {
		
		BufferedOutputStream out 	= null;
		InputStream in 				= null;
		BufferedReader br 			= null;
		Socket socket				= null;
		
		try {

			String strSmsHost	= "10.190.161.17";
			//String strSmsHost	= "10.190.161.140";
			String strSmsPort	= "8001";
			String strResult 	= "";
			String strTitle		= "";

			String fullMsg = strTitle + "[" + job_name + "][" + description + "]";
			
			if ( fullMsg.length() > 80 ) {
				fullMsg.substring(0, 80);
			}
			
			String currentTime 	= new SimpleDateFormat("yyyyMMddHHmmss").format(new java.util.Date());

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
			String DATA_LENGTH 	= appendSpace("100", 4);
			String DATA		 	= appendSpace("ABCDE123456789", "ABCDE123456789".length());
			
			String strBody = KEY_NUMBER + SEND_TIME + RETURN_CODE + CALL_KEY + PHONE_SET + PHONE1 + PHONE2 + PHONE3
					 		+ PHONE4 + PHONE5 + DUMMY + DATA_LENGTH + DATA;
			
			String strTotalContent = strBody;
			
			socket 	= new Socket(strSmsHost, Integer.parseInt(strSmsPort));
			
			in		= new BufferedInputStream(socket.getInputStream());
			out 	= new BufferedOutputStream(socket.getOutputStream());
			br 		= new BufferedReader(new InputStreamReader(in));
			
			System.out.println("메세지 : " + strTotalContent);
			
			System.out.println("Call connect start..");
			
			out.write(strTotalContent.getBytes());			
			out.flush();
			
			String line 	= "";
			String output 	= "";
			
			Date strtTime = new Date();

    	    while ( true ) {
    	    	
    	    	Date endTime = new Date();
				long t =  endTime.getTime() - strtTime.getTime();
				
				output += br.readLine();
				//output += "</br>";
				
				System.out.println("output : " + output);
				
				//5초후 닫는다, 안하면 서버가 무한루프에 빠질수 있음~~
				if(t/1000.0 > 0.01){
					break;
				}
    		}
			
			System.out.println("결과 : "  + output);
			
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
