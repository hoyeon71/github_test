package com.ghayoun.ezjobs.common.util;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.jcraft.jsch.Channel;
import com.jcraft.jsch.ChannelSftp;
import com.jcraft.jsch.JSch;
import com.jcraft.jsch.JSchException;
import com.jcraft.jsch.Session;
import com.jcraft.jsch.SftpException;

public class SftpUtil {

	Logger logger = LoggerFactory.getLogger(this.getClass());
    Session sftp = null;
    Channel channel = null;
    
	/**
	 *  sFTP connection 
	 */
	public Session sftpConnecting(Map<String, Object> map){
		try{
			
			String host = CommonUtil.isNull(map.get("host"));
			String user_id = CommonUtil.isNull(map.get("user_id"));
			String user_pw = CommonUtil.isNull(map.get("user_pw")); 
			int port = map.get("port") == null ? 0 : Integer.parseInt(map.get("port").toString());
			
			// 키 파일
//			String privateKey = "/home/jeus/.ssh/id_rsa";
//			String privateKey = "/home/deploy/.ssh/id_rsa";
			String privateKey = "/ctm/ezjobs/.ssh/id_rsa";
			
		    JSch jsch = new JSch();
		    
		    sftp = jsch.getSession(user_id, host, port);
		    
		    if ( !privateKey.equals("") ) {
				//jsch.addIdentity(privateKey);
			}
		 
		    // 3. 패스워드를 설정한다.
		    sftp.setPassword(user_pw);
		 
		    // 4. 세션과 관련된 정보를 설정한다.
		    java.util.Properties config = new java.util.Properties();
		    // 4-1. 호스트 정보를 검사하지 않는다.
		    config.put("StrictHostKeyChecking", "no");
		    sftp.setConfig(config);
		 
		    // 5. 접속한다.
		    sftp.connect();
			
			if(sftp.isConnected() != true){
			    channel = sftp.openChannel("sftp");
			    channel.connect();
				
			    //Set some timeouts, in milliseconds:
			    sftp.setTimeout(15000);
			    sftp.setServerAliveInterval(15000);
				
			    sftp.connect();
			    if (sftp.isConnected() != true) {
			    	logger.info("Sftp Connection Fail : ");
			    }
			}
			
		}catch(Exception e){
			logger.info(e.getMessage());
			logger.info("Sftp Connection Fail ");
		}
		
		return sftp;
	}
	
	/**
	 * 단일 파일 다운로드
	 */
    public InputStream download(Map<String, Object> map, Session sftp){
    	
    	boolean success = sftp.isConnected();
    	
		String remote_dir = CommonUtil.isNull(map.get("REMOTE_DIR"));
		String file_name = CommonUtil.isNull(map.get("FILE_NAME"));
		
		InputStream in = null;
		
		if(success == true){
		 
			Channel channel;
			try{ 
				channel = sftp.openChannel("sftp");
				ChannelSftp channelSftp = (ChannelSftp) channel;
		        channelSftp.connect();
			
				channelSftp.cd(remote_dir);
				
				in = channelSftp.get(file_name);
				
			} catch(SftpException se){
				
				//in = new ByteArrayInputStream(se.getMessage().getBytes());
				in = new ByteArrayInputStream(se.toString().getBytes());
				se.printStackTrace();
				
			} catch (JSchException e) {
				
				//in = new ByteArrayInputStream(se.getMessage().getBytes());
				in = new ByteArrayInputStream(e.toString().getBytes());
				e.printStackTrace();
			}
			
		} else {
			
			in = new ByteArrayInputStream(("Sftp Connection Fail").getBytes());
		}
		
		return in;
    }

}
