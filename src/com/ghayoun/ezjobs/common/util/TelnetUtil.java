package com.ghayoun.ezjobs.common.util;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import de.mud.telnet.TelnetWrapper;

public class TelnetUtil {
   
	private String output = "";
	
	public TelnetUtil(String hostname, int port, String username, String password, String cmd) {
		
		TelnetWrapper telnet = new TelnetWrapper();
		InputStream in = null;
		try {
			System.out.println("connect");
			telnet.connect(hostname, port);
			System.out.println("login");
			telnet.login(username, password);
			System.out.println("prompt..");
			telnet.setPrompt(username);
			System.out.println("send");
			
			// 한글 전송때문에 class 파일안에 있는 소스를 꺼내서 셋팅.
			//telnet.send(cmd);
			telnet.write((new StringBuilder(String.valueOf(cmd))).append("\r\n").toString().getBytes("utf-8"));
			
			// 계정이 앞에 붙어서 나오는 것을 방지.
			telnet.waitfor(username);
			
			System.out.println("send end");
			
			in = telnet.getInputStream();
			BufferedReader br = new BufferedReader(new InputStreamReader(in));
			
			int limit = 3000;
			String line = null;
			while((line = br.readLine())!=null)
			{
				telnet.getSocket().setSoTimeout(3000);
				output += (line+"\r\n");
				
				limit--;
				if(limit < 1) break;
			}
			
		} catch (Exception e) {
			output += "Error : " + e.toString();
		} finally {
			try {
				if(in!=null){in.close();in=null;};
				if(telnet != null){ telnet.disconnect(); telnet=null;}
			} catch(Exception e) {} 
		}
	}
 
	public String getOutput() {
		return output;
	}
}