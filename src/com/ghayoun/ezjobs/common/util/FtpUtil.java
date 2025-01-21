package com.ghayoun.ezjobs.common.util;

import java.io.*;

import org.apache.commons.net.ftp.*;

public class FtpUtil {

	FTPClient ftp;
	private String FTP_SERVER 	= "";
	private int FTP_PORT 		= 0;
	private String FTP_ID 		= "";
	private String FTP_PW 		= "";
	private String FTP_DIR 		= "";
	
	public FtpUtil() {
		try {
			ftp = new FTPClient();
			
			FTPClientConfig ftp_config = new FTPClientConfig(FTPClientConfig.SYST_NT);  
			//ftp_config.setServerLanguageCode("ko");
			ftp.configure(ftp_config);
			//ftp.setControlEncoding("EUC-KR");
			
		} catch (Exception e) {
			e.printStackTrace();
		}
    }
   
	public boolean connect(String ftp_server, int ftp_port) {
		try {
			ftp.connect(ftp_server, ftp_port);
			int reply;

			reply = ftp.getReplyCode();
			ftp.setSoTimeout(100000);  
			if(!FTPReply.isPositiveCompletion(reply)){
				ftp.disconnect();
			}else{
				return true;
			}
             
		}catch (Exception e) {
			if(ftp.isConnected()) {
				try{
					ftp.disconnect();
				}catch(Exception e1) {
					e1.printStackTrace();
				}
			}
			e.printStackTrace();	
		}
		return false;
	}

	public boolean login(String ftp_id, String ftp_pw, boolean passiveMode){
		try {
			if( !ftp.login(ftp_id, ftp_pw) ) return false;
			if(passiveMode) ftp.enterLocalPassiveMode();
			
			return true;
		}catch (Exception e){
			e.printStackTrace();
		}
		return false;
	}

	public boolean upFile( String ftp_path, File up_file){
		
		String file_name 	= "";
		InputStream is = null;
		try {
			file_name = up_file.getName();
			is = new FileInputStream(up_file);
			
			if( !"".equals(ftp_path) ) if( !ftp.changeWorkingDirectory(ftp_path) ) return false;
			if( !ftp.storeFile( file_name, is) ) return false;
			
			return true;
		}catch(Exception e) {
			e.printStackTrace();
		}finally{
			if( is != null ) try{ is.close(); }catch(Exception e){};	
		}
		return false;
	}
	
	public boolean downFile(String ftp_path, String ftp_file_name, String local_file_name, String local_path){
		
		OutputStream os = null;
		try {
			
			System.out.println("ftp_path : " + ftp_path);
			
			if( !"".equals(ftp_path) ) if( !ftp.changeWorkingDirectory(ftp_path) ) return false;
			
			System.out.println("local_path+File.separator+local_file_name : " + local_path+File.separator+local_file_name);
			
			os = new FileOutputStream(local_path+File.separator+local_file_name);
			
			System.out.println("ftp_file_name : " + ftp_file_name);
			
			if( !ftp.retrieveFile(ftp_file_name, os) ) return false;
			
			return true;
		}catch(Exception e) {
			e.printStackTrace();
		}finally{
			if( os != null ) try{ os.close(); }catch(Exception e){};	
		}
		return false;
	}

	public boolean changeWorkingDirectory(String ftp_path){
		
		try{
			return ftp.changeWorkingDirectory(ftp_path);
		
		}catch(Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	public String[] listNames(){
		
		try{
			return ftp.listNames();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public boolean sendSiteCommand(String cmd){
		
		try{
			return ftp.sendSiteCommand(cmd);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return false;
	}


	public boolean delFile(String file_name) {
		try {
			return ftp.deleteFile(file_name);
		}catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	
	public boolean logout() {
		try {
			return ftp.logout();
		}catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	public void disconnect() {
		try {
			ftp.disconnect();
		}catch (Exception e) {
			e.printStackTrace();	
		}
	}
	
	
}
