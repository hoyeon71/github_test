package com.ghayoun.ezjobs.common.util;
import java.sql.*;
import java.io.*;
import java.util.*;
import java.util.Date;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;
import java.text.*;
import java.net.*;

import javax.naming.AuthenticationException;
import javax.naming.Context;
import javax.naming.NamingEnumeration;
import javax.naming.directory.SearchControls;
import javax.naming.ldap.InitialLdapContext;
import javax.naming.ldap.LdapContext;
import javax.servlet.http.HttpServletRequest;

import org.json.JSONObject;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public class Scb {
	private static final Scb scb = new Scb();
	
	protected final Log logger = LogFactory.getLog(getClass());
	
	private Scb(){
		
	}
	
	public static Scb getInstance(){
		return scb;
	}
	
	public Object isAuthenticatedUser(String user_id, String user_pw, String user_nm) throws Exception {
		
		/*
		1. 10.61.12.127~30 443
		*/
		String ntUserId		= CommonUtil.getMessage("AD.ID");
		String ntPasswd		= CommonUtil.getMessage("AD.PW");
		String url			= "LDAP://"+CommonUtil.getMessage("AD.IP")+":"+CommonUtil.getMessage("AD.PORT");
		String rs_msg		= "";
		
		System.out.println("ntUserId : " + ntUserId);
		System.out.println("ntPasswd : " + SeedUtil.decodeStr(ntPasswd));
		System.out.println("url : " + url);
		
		JSONObject jo		= new JSONObject();
		boolean isAdCheck	= false;
		
		try {
			
			String userId		= user_id;
			String userPw		= user_pw;
//			String baseRdn 		= "CN=Users,DC=ghayoun,DC=pe,DC=kr";
//			String baseRdn 		= "CN=SRE팀_RE파트-G,OU=SRE팀_RE파트,OU=SRE팀,OU=기술플랫폼실,OU=KAKAOPAY,DC=payad,DC=kakaopaycorp,DC=net";
//			String baseRdn 		= "OU=SRE팀_RE파트,OU=SRE팀,OU=기술플랫폼실,OU=KAKAOPAY,DC=payad,DC=kakaopaycorp,DC=net";
//			String baseRdn 		= "OU=KAKAOPAY,DC=payad,DC=kakaopaycorp,DC=net";
			
			String baseRdn 		= "CN=payall,OU=KAKAOPAY,DC=payad,DC=kakaopaycorp,DC=net";
			
			
			System.out.println("userPw : " + userPw);
			
			userPw = userPw.replaceAll("&amp;", "&");
			userPw = userPw.replaceAll("&apos;", "'");
			userPw = userPw.replaceAll("&quot;", "\"");
			userPw = userPw.replaceAll("&lt;", "<");
			userPw = userPw.replaceAll("&gt;", ">");
			userPw = userPw.replaceAll("&#42;", "*");
			
			System.out.println("userPwdecoding : " + userPw);
			
			
			Hashtable<String, String> prop = new Hashtable<String, String>();
			
			prop.put(Context.INITIAL_CONTEXT_FACTORY,	"com.sun.jndi.ldap.LdapCtxFactory");
			prop.put(Context.PROVIDER_URL,				url);
			prop.put(Context.SECURITY_AUTHENTICATION,	"simple");
			prop.put(Context.SECURITY_PRINCIPAL,		ntUserId);
			prop.put(Context.SECURITY_CREDENTIALS,		SeedUtil.decodeStr(ntPasswd));
			
			System.out.println("1");
			
			LdapContext ctx = new InitialLdapContext(prop, null);
			
			System.out.println("Active Directory Connection :: connected");
			
			SearchControls ctls = new SearchControls();
			
			ctls.setSearchScope(SearchControls.SUBTREE_SCOPE);
			ctls.setReturningAttributes(new String[] {"cn"});
			
			String searchFilter = String.format("(cn=%s)", userId);
			NamingEnumeration rs = ctx.search(baseRdn, searchFilter, ctls);
			
			Hashtable<String, String> userProp = new Hashtable<String, String>();
			
			userProp.put(Context.INITIAL_CONTEXT_FACTORY,	"com.sun.jndi.ldap.LdapCtxFactory");
			userProp.put(Context.PROVIDER_URL,				url);
			userProp.put(Context.SECURITY_AUTHENTICATION,	"simple");
//			userProp.put(Context.SECURITY_PRINCIPAL,		String.format("%s=%s,%s", "cn", user_nm+"("+userId+")", baseRdn)); 
			userProp.put(Context.SECURITY_PRINCIPAL,		String.format("%s=%s,%s", "cn", userId, baseRdn));
			
			System.out.println("7");
			
			userProp.put(Context.SECURITY_CREDENTIALS,		userPw);
			
			System.out.println("userId : " + userId);
			System.out.println("userPw : " + userPw);
			
			new InitialLdapContext(userProp, null);
			
			isAdCheck = true;
			System.out.println("ad연동 성공");
		
		} catch(AuthenticationException e) {
			e.printStackTrace();
			String msg = e.getMessage();
			
			if(msg.indexOf("data 525") > 0) {
				rs_msg = "[AD 메시지]사용자를 찾을 수 없습니다.";
			} else if(msg.indexOf("data 773") > 0) {
				rs_msg = "[AD 메시지]사용자는 암호를 재설정해야합니다.";
			} else if(msg.indexOf("data 52e") > 0) {
				rs_msg = "[AD 메시지]ID와 PW가 일치하지 않습니다.";
			} else if(msg.indexOf("data 533") > 0) {
				rs_msg = "[AD 메시지]입력한 ID는 비활성화 상태입니다.";
			} else if(msg.indexOf("data 532") > 0) {
				rs_msg = "[AD 메시지]암호가 만료되었습니다.";
			} else if(msg.indexOf("data 701") > 0) {
				rs_msg = "[AD 메시지]AD에서 계정이 만료되었습니다.";
			} else {
				rs_msg = "[AD 메시지]인증오류발생";
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		jo.put("result", isAdCheck);
		jo.put("msg", rs_msg);
		return jo;
	}
}
