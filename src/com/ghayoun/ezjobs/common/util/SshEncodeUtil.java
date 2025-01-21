package com.ghayoun.ezjobs.common.util;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Base64;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

import com.ghayoun.ezjobs.comm.domain.CommonBean;
import com.ghayoun.ezjobs.comm.service.CommonService;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.jcraft.jsch.Channel;
import com.jcraft.jsch.ChannelExec;
import com.jcraft.jsch.JSch;
import com.jcraft.jsch.JSchException;
import com.jcraft.jsch.Logger;

public class SshEncodeUtil {
	
	private static final Log logger = LogFactory.getLog(SshEncodeUtil.class);
	
	private String output = "";
	
	public SshEncodeUtil(String hostname, int port, String username, String password, String cmd, String lang) throws IOException {
		
		InputStream in						= null;
		com.jcraft.jsch.Session jschsess 	= null;
		JSch jsch 							= null;
		Channel channel 					= null;
		
		// 키 파일
		String privateKey = CommonUtil.isNull(CommonUtil.getMessage("SSH.KEY_FILE"));
		
		try {
			
			CommonService commonService 	= (CommonService)CommonUtil.getSpringBean("commonService");
			Map<String, Object> paramMap 	= new HashMap<String, Object>();
			
			paramMap.put("SCHEMA", 			CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
			paramMap.put("host"	, 			hostname);
			
			CommonBean bean = commonService.dGetHostInfo(paramMap);
			
			String strCertifyGubun 		= "";
			
			if ( bean != null ) {
			
				strCertifyGubun 			= bean.getCertify_gubun();
			}
			
			
			jsch		= new JSch();
			Properties conf = new Properties();
			
			conf.put("StrictHostKeyChecking", "no");
			
			jschsess = jsch.getSession(username, hostname);
			jschsess.setConfig(conf);
			jschsess.setPort(port);
			
			// 키 파일이 있으면 키 인증
			if ( strCertifyGubun.equals("K") ) {
				//키 인증
				jsch.addIdentity(privateKey);
			} else {
				//패스워드 인증
				jschsess.setPassword(password);
			}
			
			// 타임아웃 설정 (10초)
			jschsess.setTimeout(10000);
			jschsess.setDaemonThread(true);
			jschsess.connect();

			logger.info("cmd : " + cmd);
			
			//cmd = "echo START;" + cmd;
		
			//cmd = cmd + " | base64";
			cmd = SeedUtil.encodeStr(cmd);
			cmd = "echo " + cmd +  " | base64 --decode | iconv -f EUC-KR -t UTF-8 | sh";
			
			logger.info("cmd : " + cmd);
			
			channel = jschsess.openChannel("exec");
			((ChannelExec)channel).setPty(true);
			((ChannelExec)channel).setCommand(cmd);

			in = channel.getInputStream();
			
			channel.connect();
				
			byte[] tmp 	= new byte[1024];
			
			long startTime = System.currentTimeMillis();
			long nowTime;
			
			logger.info("======SSH 접속 성공 후 명령어 실행=====");
			
			while (true) {
				
				// 응답 없이 while 문 루핑 시간 체크 시작
				nowTime = System.currentTimeMillis();
				
				if ( (nowTime - startTime) - 10000 > 0 ) {
					output = "[Ssh2Util ERROR] 서버 응답이 지연되었습니다. 다시 시도 부탁드립니다.";
					break;
				}
				
				while (in.available() > 0) {
					int i = in.read(tmp, 0, 1024);
					
					if ( i < 0 ) break;
					
					output += new String(tmp, 0, i, lang);
				}
				
				if ( channel.isClosed() ) {
					
					if ( in.available() > 0 ) {
						int i = in.read(tmp, 0, 1024);
						
						output += new String(tmp, 0, i, lang);
						output += "</br>";
					}
					
					break;
				}
				
				try {
					
					Thread.sleep(1000);
					
					if ( output.startsWith("START") ) {
						startTime = System.currentTimeMillis();
					}
					
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			
			logger.info("======SSH 접속 종료 완료=====");
			
			logger.info("output1 : " + output);
			//output = output.substring(5, output.length());
			//logger.info("output2 : " + output);
			
			try {
				
				//output = output.replaceAll("\\s+", "");
			
	            //byte[] decodedBytes = Base64.getDecoder().decode(output);
	            //String result = new String(decodedBytes, "UTF-8");  // UTF-8로 디코딩
	            //output = new String(decodedBytes, lang);  // UTF-8로 디코딩
			
	            logger.info("output : " + output);
	            
			} catch (Exception e) {
				logger.error("[Ssh2Util ERROR] Base64 decode Error : " + e.toString());
			}
			
			if ( output.startsWith("START") ) {
				output = output.replace("START", "");
			}
			
			try{ if(in != null) in.close(); } catch(Exception e){}
			try{ if(channel != null) channel.disconnect(); } catch(Exception e){}
			try{ if(jschsess != null) jschsess.disconnect(); } catch(Exception e){}
			
		} catch (JSchException je) {
			output += "[Ssh2Util ERROR] JSchException Error : " + je.toString();
		} catch (IOException ie) {
			output += "[Ssh2Util ERROR] IOException Error : " + ie.toString();
		}catch (Exception e) {
			output += "[Ssh2Util ERROR] Exception Error : " + e.toString();
		}finally{
			try{ if(in != null) in.close(); } catch(Exception e){}
 			try{ if(channel != null) channel.disconnect(); } catch(Exception e){}
 			try{ if(jschsess != null) jschsess.disconnect(); } catch(Exception e){}
		}
	}
	
	public String getOutput() {
		return output;
	}

}
