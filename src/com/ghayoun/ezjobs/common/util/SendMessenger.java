package com.ghayoun.ezjobs.common.util;

import java.util.Properties;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.mail.internet.MimeUtility;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.commons.net.SocketClient;

import javax.mail.BodyPart;
import javax.mail.Multipart;
import javax.activation.*;

import java.io.OutputStreamWriter;
import java.net.Socket;
import java.util.*;

public class SendMessenger {

	private static final Log logger = LogFactory.getLog(SendMessenger.class);
	
	public static boolean sendMessenger(String ReceiverId, String SenderId, String SenderNm, String Content) throws Exception {
		
		SocketClient socketClient 	= null;
		Socket socket 				= null;
		OutputStreamWriter out 		= null;
		
    
		try {
			
			String MessengerUrl  		= CommonUtil.isNull(CommonUtil.getMessage("MESSENGER_URL"));
			String MessengerPort  		= CommonUtil.isNull(CommonUtil.getMessage("MESSENGER_PORT"));
			
			char chStart			= (char)02;
			char chEnd				= (char)03;
			char chSeparator		= (char)05;
			
			if ( !ReceiverId.equals("") && !SenderId.equals("") ) {
			
				
				if ( !ReceiverId.equals("") ) {
					ReceiverId = "CP" + ReceiverId;
				}
				
				if ( !SenderId.equals("") ) {
					SenderId = "CP" + SenderId;
				}
				
				logger.debug("MessengerUrl : " + MessengerUrl);
				logger.debug("MessengerPort : " + MessengerPort);

				String total = chStart + ReceiverId + chSeparator + SenderId + chSeparator + SenderNm + chSeparator + Content + chSeparator + "" + chSeparator + "" + chEnd;
				
				logger.debug("messenger total : " + total);
				
				//socketClient = new socketClient();
				//socketClient.connect(MessengerUrl, MessengerPort);
	
				socket = new Socket(MessengerUrl , Integer.parseInt(MessengerPort));
				logger.debug("socket : " + socket.isConnected());
				out = new OutputStreamWriter( socket.getOutputStream(), "EUC-KR" );
				out.write(total.toString());
				out.flush();
				
				return true;

			} else {
				
				logger.debug("메신저 발송 아이디 오류");
				logger.debug("ReceiverId : " + ReceiverId);
				logger.debug("SenderId : " + SenderId);
			} 
			
			if ( out != null ) out.close();
			if ( socket != null ) socket.close();
			if ( socketClient != null ) socketClient.disconnect();
	      		                                                                              
		} catch (Exception e) {

			logger.error("메신저 발송 오류");
			logger.error(e.getMessage());
			
			if ( out != null ) out.close();
			if ( socket != null ) socket.close();
			if ( socketClient != null ) socketClient.disconnect();
			
			return false;

		} finally {
			
			if ( out != null ) out.close();
			if ( socket != null ) socket.close();
			if ( socketClient != null ) socketClient.disconnect();
		}
		
		return true;
	}
	
}

