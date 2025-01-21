package com.ghayoun.ezjobs.common.util;

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

import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.Multipart;
import javax.activation.*;
import java.util.*;
import com.ghayoun.ezjobs.common.util.MessageUtil;

public class SendMail {

	private static final Log logger = LogFactory.getLog(CommonUtil.class);
	
	public static int senderMail(	String fAddress,                                      
									String tAddress,                                      
									String title,                                         
									String content,
									String fUserNm) throws Exception {
		
		int iReturnCnt = 0;
    
		try{

			String strMailHost		= CommonUtil.isNull(CommonUtil.getMessage("MAIL.HOST"));

			Properties props = new Properties();
			Transport transport = null;
			InternetAddress add		= new InternetAddress();
			MyAuthenticator auth 	= new MyAuthenticator ("", "");

			props.put("mail.MailTransport.protocol", 	"smtp");
			props.put("mail.smtp.starttls.enable", 		"true");
			props.put("mail.smtp.host", 			strMailHost);
			props.put("mail.smtp.auth", 			"true");
			 
			Session MailSession = Session.getInstance(props, auth);
			Message mailMessage = new MimeMessage(MailSession);

			add.setAddress(fAddress);
			add.setPersonal(fUserNm, "UTF-8");

		    mailMessage.setFrom(add);  
			mailMessage.setRecipient(Message.RecipientType.TO, new InternetAddress(tAddress));
			mailMessage.setSentDate(new Date());
			mailMessage.setContent(content, "text/html;charset=UTF-8");
			mailMessage.setSubject(title);
	
			Multipart multipart = new MimeMultipart();    
			MimeBodyPart mbp1 = new MimeBodyPart();

			mbp1.setText(title);
			multipart.addBodyPart(mbp1);  

			transport = MailSession.getTransport("smtp");
			transport.send(mailMessage);
			transport.close();
			
			iReturnCnt = 1;
	      		                                                                              
		}catch (MessagingException e){
			
			logger.error("e.getMessage() : " + e.getMessage());
			e.printStackTrace();
		}
		
		return iReturnCnt;
	}	
	
	public static int senderMail(	String fAddress,
									String tAddress,
									String title,
									String content,
									String fUsernm, 
									String authId, 
									String authpwd ) throws Exception {
		
		int iReturnCnt = 0;
		
		System.out.println("메일제목: " + title);
		System.out.println("메일내용: " + content);
		
	    try{
	    	
	    	String strMailHost		= CommonUtil.isNull(CommonUtil.getMessage("MAIL.HOST"));
	    	
			MyAuthenticator auth = new MyAuthenticator (authId,authpwd);
			Properties props = new Properties();
			Transport transport = null;
			props.put("mail.MailTransport.protocol", "smtp");
			props.put("mail.smtp.starttls.enable", 	"true");
			props.put("mail.smtp.host", strMailHost);
			props.put("mail.smtp.auth", "true");
			Session MailSession = Session.getInstance(props, auth);
			Message mailMessage = new MimeMessage(MailSession);
			InternetAddress add=new InternetAddress();
			add.setAddress(fAddress);
			add.setPersonal(fUsernm, "UTF-8"); 
		    mailMessage.setFrom(add);
			mailMessage.setRecipient(Message.RecipientType.TO, new InternetAddress(tAddress));
			mailMessage.setSentDate(new Date());
			mailMessage.setContent(content,"text/html;charset=UTF-8");
			mailMessage.setSubject(title);
	
			Multipart multipart = new MimeMultipart();
			MimeBodyPart mbp1 = new MimeBodyPart();
			//mbp1.setText(new String(title.getBytes("8859_1"),"UTF-8"));
			mbp1.setText(title);
			multipart.addBodyPart(mbp1);
			transport = MailSession.getTransport("smtp");
			//transport.connect(strMailHost, authId, authpwd);
			transport.send(mailMessage);
			transport.close();
			
			iReturnCnt = 1;
	
	   	}catch (MessagingException e){

	   		logger.error("e.getMessage() : " + e.getMessage());

	   		e.printStackTrace();
	    }
    
	    return iReturnCnt;
	}

	public static void senderMailFile(	String fAddress,
									String tAddress,
									String title,
									String content,String filename , String mailhost ,String authId , String authpwd  ) throws Exception {
		try{
			Properties props = System.getProperties();
			props.put("mail.smtp.host", mailhost);
			Session session = Session.getInstance(props, null);
			Message message = new MimeMessage(session);
			message.setFrom(new InternetAddress(fAddress));
			message.addRecipient(Message.RecipientType.TO, new InternetAddress(tAddress));

			message.setSubject(title);
			BodyPart messageBodyPart = new MimeBodyPart();
			messageBodyPart.setText(content);

			Multipart multipart = new MimeMultipart();
			multipart.addBodyPart(messageBodyPart);
			messageBodyPart = new MimeBodyPart();
			DataSource source = new FileDataSource(filename);
			messageBodyPart.setDataHandler(new DataHandler(source));
			//messageBodyPart.setFileName(new String(filename.getBytes("8859_1"),"KSC5601"));
			messageBodyPart.setFileName(filename);
			multipart.addBodyPart(messageBodyPart);
			message.setContent(multipart);
			message.setSentDate(new Date());
			Transport.send(message);

        }catch (MessagingException e){

        	logger.error("e.getMessage() : " + e.getMessage());

			e.printStackTrace();

        }

}

}

class MyAuthenticator extends javax.mail.Authenticator
{
	String smtpUsername = null;
	String smtpPassword = null;


	public MyAuthenticator(String username, String password)
	{
		smtpUsername = username;
		smtpPassword = password;
	}


	protected javax.mail.PasswordAuthentication getPasswordAuthentication()
	{
		return new javax.mail.PasswordAuthentication(smtpUsername,smtpPassword);
	}


}

