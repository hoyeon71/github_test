import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.ConnectException;
import java.net.ServerSocket;
import java.net.Socket;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.ghayoun.ezjobs.common.util.CommonUtil;

public class call_server_test extends Thread {

	public static void main(String[] args) {
		
		try {
			
			System.out.println("start!!");
			
			initSocket();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	private static void initSocket() throws IOException {
		
		Socket socket 				= null;
		ServerSocket serverSocket 	= new ServerSocket(8000);
		DataOutputStream out 		= null;
		DataInputStream in 			= null;
		BufferedReader br 			= null;
		
		try {
			
			while (true) {
				
				try {
				
					System.out.println("연결 요청을 기다립니다.");
					
					socket = serverSocket.accept();
					
					System.out.println(socket.getInetAddress() + " 로부터 연결 요청이 들어왔습니다.");
					
					in		= new DataInputStream(new BufferedInputStream(socket.getInputStream()));
					out 	= new DataOutputStream(new BufferedOutputStream(socket.getOutputStream()));
					br 		= new BufferedReader(new InputStreamReader(in));
					
					int iAckSize 		= 56;
					String StrAckReturn = "";
					byte[] BUFFER 		= new byte[iAckSize];
				
					while (StrAckReturn.length() < iAckSize) {
						in.read(BUFFER);
						StrAckReturn = new String(BUFFER, "UTF-8");						
				    }
					
					System.out.println("StrAckReturn : " + StrAckReturn);
					
					socket.close();
					//serverSocket.close();
					in.close();
					out.close();
					
				} catch (Exception e)  {
					socket.close();
					//serverSocket.close();
					in.close();
					out.close();
				} finally {
					socket.close();
					//serverSocket.close();
					in.close();
					out.close();
				}
 			}
			
	    } catch (IOException e) {
	    	System.out.println("AutoCall Response Server Initialized Exception.");
	    }
	}	
}
