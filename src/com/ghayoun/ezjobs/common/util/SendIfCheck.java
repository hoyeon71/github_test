package com.ghayoun.ezjobs.common.util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.ConnectException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.*;

public class SendIfCheck {

	public static List SendIfCheck(String ifName) throws Exception {
    
		BufferedReader br = null;
		
		try {
			
			//URL obj = new URL("http://weimst.woorifg.com/inf/callContMIntfChk.do");
			URL obj = new URL("http://weimsp.woorifg.com/inf/callContMIntfChk.do");
			
			HttpURLConnection conn = (HttpURLConnection) obj.openConnection();
			
			conn.setRequestMethod("POST");			
			conn.setDoOutput(true);
			
			OutputStream out = conn.getOutputStream();
			
			out.write(("INTFID=" + URLEncoder.encode(ifName, "UTF-8")).getBytes());
			
			br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
			
			String line 	= "";
			String ifReturn = "";
			
			while ((line = br.readLine()) != null) {
				ifReturn = URLDecoder.decode(line, "UTF-8");				
			}
			
			List list = new ArrayList();
			list.add(ifReturn);
			
			return list;

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
			if ( br != null ) {
				br.close();
			}
		}
	}
}

