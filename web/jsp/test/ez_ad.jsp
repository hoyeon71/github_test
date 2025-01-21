
<%@page import="com.ghayoun.ezjobs.common.util.CommonUtil"%>
<%@page import="java.util.Hashtable"%>
<%@page import="javax.naming.Context"%>
<%@page import="javax.naming.NamingException"%>
<%@page import="javax.naming.directory.Attributes"%>
<%@page import="javax.naming.directory.SearchResult"%>
<%@page import="javax.naming.NamingEnumeration"%>
<%@page import="javax.naming.directory.SearchControls"%>
<%@page import="javax.naming.directory.InitialDirContext"%>
<%@page import="javax.naming.directory.DirContext"%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	String strAdUserNm			= "djemalsctm";
	String strAdUserPw			= "UEBzc3cwcmRDVE0=";
	String strAdLdapDomain		= "adpusan.co.kr";
	String strAdDistName		= "OU=IT본부,OU=부산은행,OU=BS금융그룹,OU=조직단위,OU=BSFNG,DC=adpusan,DC=co,DC=kr";
	String strLdapPathFormat 	= "LDAP://%s/";
	
	String path = String.format(strLdapPathFormat, strAdLdapDomain);

	String filterString = "cn=*";

	// LDAP Context
	DirContext context = null;

	// LDAP 접속 환경 설정
	Hashtable<String, String> properties = new Hashtable<String, String>();
	
	properties.put(Context.INITIAL_CONTEXT_FACTORY, "com.sun.jndi.ldap.LdapCtxFactory");
	properties.put(Context.PROVIDER_URL, 			path);
	properties.put(Context.SECURITY_AUTHENTICATION, "simple");
	properties.put(Context.SECURITY_PRINCIPAL, 		strAdUserNm);
	properties.put(Context.SECURITY_CREDENTIALS, 	strAdUserPw);
	
	int rsCnts = 0;

	try {
		
		context = new InitialDirContext(properties);
		SearchControls searcher = new SearchControls();

		// 기본 엔트리에서 시작해서 하위까지 하는거임.
		searcher.setSearchScope(SearchControls.SUBTREE_SCOPE);
		
		NamingEnumeration<SearchResult> results = context.search(strAdDistName, filterString, searcher);
		
		String strName 			= "";
		String strPw 			= "";
		String strDisplayName	= "";
		String strDepartment 	= "";
		String strTitle			= "";
		String strMail 			= "";
		String strMobile 		= "";
		
		while (results.hasMore()) {
			SearchResult result = results.next();
			Attributes attrs = result.getAttributes();

			strName		 	= CommonUtil.isNull(attrs.get("Name")).replace("name: ", "");
			strDisplayName 	= CommonUtil.isNull(attrs.get("displayName")).replace("displayName: ", "");
			strDepartment 	= CommonUtil.isNull(attrs.get("Department")).replace("department: ", "");
			strTitle 		= CommonUtil.isNull(attrs.get("title")).replace("title: ", "");
			strMail 		= CommonUtil.isNull(attrs.get("mail")).replace("mail: ", "");
			strMobile 		= CommonUtil.isNull(attrs.get("mobile")).replace("mobile: ", "");
			
			out.println("strName : " + strName);
			out.println("\n\r");
			out.println("strDisplayName : " + strDisplayName);
			out.println("\n\r");
			out.println("strDepartment : " + strDepartment);
			out.println("\n\r");
			out.println("strTitle : " + strTitle);
			out.println("\n\r");
			out.println("strMail : " + strMail);
			out.println("\n\r");
			out.println("strMobile : " + strMobile);
			out.println("\n\r");
			out.println("\n\r");
		}
	} catch (NamingException e) {
		e.printStackTrace();
	}
	
%>