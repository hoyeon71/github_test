package com.ghayoun.ezjobs.common.util;
import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.Reader;
import java.net.ConnectException;
import java.net.Socket;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;

public class SendUc {

	public static String sendUc(String strSerial, String strUserId, String strJobName, String strDescription) throws Exception {
		
		// UC 메신저 서버정보.
		String strUcUrl			= CommonUtil.isNull(CommonUtil.getMessage("UC.URL"));
		
		String strRetrunMessage = "";
		
		BufferedWriter bw 	= null;
		BufferedReader br 	= null;
		OutputStream os 	= null; 
		
		try {
			
			URL url 			= new URL(strUcUrl);
			URLConnection conn 	= url.openConnection();
			
			conn.setDoOutput(true);
			conn.setUseCaches(false);
			conn.setRequestProperty("content-type","application/x-www-form-urlencoded");
			
			String strEncoded = "msgType=" 				+ "1" +
								"&userId=" 				+ "EZJOBS" +
								"&rcvId=" 				+ URLEncoder.encode(strUserId) +
								"&msg=" 				+ strJobName + "(" + strDescription + ")" + " 실행중 오류가 발생하였습니다.<br>확인 후 조치 바랍니다." +
								"&Chnl_type_clcd=" 		+ "JBB";
			
			os = conn.getOutputStream();

			bw = new BufferedWriter(new OutputStreamWriter(os));
			bw.write(strEncoded);

			bw.flush();
			bw.close();
			
			br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			
			
			while((strRetrunMessage = br.readLine()) != null){
				System.out.println("strRetrunMessage : " + strRetrunMessage);
			}
			
			os.close();
			br.close();
			
		} catch (Exception e) {
			
			System.out.println(e.toString());
			
		} finally {
			
			try{ if(bw != null) bw.close(); } catch(Exception e){}
			try{ if(br != null) br.close(); } catch(Exception e){}
			try{ if(os != null) os.close(); } catch(Exception e){}
		}
		
		return strRetrunMessage;
	}
}