package com.ghayoun.ezjobs.common.util;

import com.sshtools.j2ssh.SshClient;
import com.sshtools.j2ssh.authentication.AuthenticationProtocolState;
import com.sshtools.j2ssh.authentication.PasswordAuthenticationClient;
import com.sshtools.j2ssh.authentication.PublicKeyAuthenticationClient;
import com.sshtools.j2ssh.transport.IgnoreHostKeyVerification;
import com.sshtools.j2ssh.transport.publickey.SshPrivateKey;
import com.sshtools.j2ssh.transport.publickey.SshPrivateKeyFile;
import com.sshtools.j2ssh.session.*;
import com.sshtools.j2ssh.connection.*;
import com.sshtools.j2ssh.io.*;
import java.io.*;
 
public class SshUtil {
   
	private String output = "";
	
	public SshUtil(String hostname, int port, String username, String password, String cmd, String lang) {
		
		InputStream in 					= null;
		BufferedReader br 				= null;
		SshClient conn 					= null;
		SessionChannelClient session 	= null;
		
		int result = 0;
		
		try {
			
			conn = new SshClient();
			conn.setSocketTimeout(20000);
			conn.connect(hostname,port, new IgnoreHostKeyVerification());
			
			String strServerGb = CommonUtil.isNull(CommonUtil.getMessage("SERVER_GB"));
			
			//if ( strServerGb.equals("P") ) {
				// 키 인증
				PublicKeyAuthenticationClient authClient = new PublicKeyAuthenticationClient();
				authClient.setUsername(username);
				SshPrivateKeyFile file = SshPrivateKeyFile.parse(new File("/user/mwadm/.ssh/id_rsa"));
				SshPrivateKey privateKey = file.toPrivateKey(null);
				authClient.setKey(privateKey);
				
				result = conn.authenticate(authClient);
				
			//} else {
				// 패스워드 인증
//				PasswordAuthenticationClient authClient = null;
//				
//				authClient = new PasswordAuthenticationClient();
//				authClient.setUsername(username);
//				authClient.setPassword(password);
//				
//				result = conn.authenticate(authClient);
			//}
			
            // AuthenticationProtocolState.CANCELLED : 5
            // AuthenticationProtocolState.COMPLETE : 4
            // AuthenticationProtocolState.PARTIAL : 3
            // AuthenticationProtocolState.FAILED : 2
            // AuthenticationProtocolState.READY : 1

            if (result == AuthenticationProtocolState.COMPLETE) {
            	
            	session =  conn.openSessionChannel();
            	
            	session.requestPseudoTerminal("dumb", 80, 24, 0, 0, "");
            	session.startShell();
            	
            	// 실제 명령
            	session.getOutputStream().write((cmd+"\n").getBytes(lang));
            	
            	// getOutputStream으로 명령어를 수행 후 InputStreamReader으로 받았음에도 불구하고, readLine()의 while문이 정상적으로 종료 안된다.
            	// 그래서 아래의 명령어를 강제적으로 붙여주고, while문 수행 시 종료 조건으로 사용. ( 2014.02.06 강명준 ) 
            	session.getOutputStream().write(("echo sysout log end \n").getBytes(lang));
                
                in = session.getInputStream();
	    		br = new BufferedReader(new InputStreamReader(in, lang));
	    
	    	    String line = "";
	    	    int i 		= 0;
	    	    
	    	    while ( true ) {
	    	    	
	    	    	line = br.readLine();
	    	    	
	    	    	if ( line.indexOf("sysout log end") > -1 ) {
	    	    		i++;
	    	    		
	    	    		if ( i > 1 ) {
	    	    			break;
	    	    		}
	    	    	}
	    	    	
	    	    	if ( line.indexOf("echo sysout log end") == -1 ) {
	    	    		output += (line+"\r\n");
	    	    	}
	    		}
	    	    
	    	    br.close();
	    	    in.close();
	    		session.close();
	    		conn.disconnect();
            
	         // 로그인 실패.
	        } else {
	        	output = "SSH 로그인 실패입니다.";
	        	
	        	br.close();
	    	    in.close();
	    		session.close();
	    		conn.disconnect();
	        }
		
		} catch (Exception e) {
			output += "Error : " + e.toString();
			e.printStackTrace();
		} finally {
			try {
				br.close();
	    	    in.close();
	    		session.close();
	    		conn.disconnect();
			} catch(Exception e) {} 
		}
	}
 
	public String getOutput() {
		return output;
	}
	
}