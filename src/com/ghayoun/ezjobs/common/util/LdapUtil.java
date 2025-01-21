package com.ghayoun.ezjobs.common.util;

import java.util.Hashtable;

import javax.naming.Context;
import javax.naming.NamingEnumeration;
import javax.naming.NamingException;
import javax.naming.directory.Attributes;
import javax.naming.directory.DirContext;
import javax.naming.directory.InitialDirContext;
import javax.naming.directory.SearchControls;
import javax.naming.directory.SearchResult;

import org.omg.CORBA.CTX_RESTRICT_SCOPE;

public class LdapUtil {
	
	static String strAdLdapDomain	= CommonUtil.isNull(CommonUtil.getMessage("AD.LDAP.DOMAIN"));
	static String strAdDistName		= CommonUtil.isNull(CommonUtil.getMessage("AD.DIST.NAME"));
	static String strLdapPathFormat = "LDAP://%s/";

	/**
	 * LDAP 계정과 암호를 이용한 사용자 인증
	 * 
	 * @param userId
	 *            계정명
	 * @param password
	 *            암호
	 * @return 인증 여부 (ID / PASS 가 일치하는지 아닌지를 확인함)
	 */
	public static boolean isAuthenticatedUser(String userId, String password) {
		
		boolean isAuthenticated = false;
		String strFullUserId	= "";
		
		String path = String.format(strLdapPathFormat, strAdLdapDomain);
		
		if (password != null && password != "") {
			
			strFullUserId = "CN="+userId+","+strAdDistName;
		
			Hashtable<String, String> properties = new Hashtable<String, String>();
			
			properties.put(Context.INITIAL_CONTEXT_FACTORY, "com.sun.jndi.ldap.LdapCtxFactory");
			properties.put(Context.PROVIDER_URL, 			path);
			properties.put(Context.SECURITY_AUTHENTICATION, "simple");
			properties.put(Context.SECURITY_PRINCIPAL, 		strFullUserId);
			properties.put(Context.SECURITY_CREDENTIALS, 	password);
			
			try {
				DirContext con = new InitialDirContext(properties);
				isAuthenticated = true;
				con.close();
			} catch (NamingException e) {
			}
		}
		return isAuthenticated;
	}
}
