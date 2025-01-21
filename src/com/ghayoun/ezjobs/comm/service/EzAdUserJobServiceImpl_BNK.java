package com.ghayoun.ezjobs.comm.service;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.Map;
import javax.naming.Context;
import javax.naming.NamingEnumeration;
import javax.naming.NamingException;
import javax.naming.directory.Attributes;
import javax.naming.directory.DirContext;
import javax.naming.directory.InitialDirContext;
import javax.naming.directory.SearchControls;
import javax.naming.directory.SearchResult;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.scheduling.quartz.QuartzJobBean;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import com.ghayoun.ezjobs.comm.repository.QuartzDao;
import com.ghayoun.ezjobs.common.util.CommonUtil;
import com.ghayoun.ezjobs.common.util.SeedUtil;

// Active Directory 사용자 정보를 실제 EzJOBs 사용자 정보에 매핑해준다. 
public class EzAdUserJobServiceImpl_BNK extends QuartzJobBean{
	
	protected final Log logger = LogFactory.getLog(getClass());
	
	private QuartzDao quartzDao;
	
	public void setQuartzDao(QuartzDao quartzDao) {
        this.quartzDao = quartzDao;
    }
	
	static String strDbUrl			= "jdbc:oracle:thin:@(DESCRIPTION = (ADDRESS= (PROTOCOL = TCP)(HOST = dctmap1)(PORT=1621))(CONNECT_DATA = (SERVER=DEDICATED) (SID=DCTMDB)) )";
	static String strDbUserNm		= "emuser";
	static String strDbPassword		= "ZW1wYXNz";
	
	static String strAdUserNm		= "cs";
	static String strAdUserPw		= "Z2hheW91bjEh";
	static String strAdLdapDomain	= "ghayoun.pe.kr";
//	static String strAdDistName		= "CN=Users,DC=ghayoun,DC=pe,DC=kr";
	static String strAdDistName 	= "CN=전략사업부,CN=Users,DC=ghayoun,DC=pe,DC=kr";
	static String strLdapPathFormat = "LDAP://%s/";
	
	protected void executeInternal(JobExecutionContext jobExecutionContext) throws JobExecutionException {

		String strClassName	= this.getClass().getName().split("\\.")[this.getClass().getName().split("\\.").length-1];

		Map<String, Object> map 	= new HashMap<String, Object>();
		Map<String, Object> rMap 	= new HashMap<String, Object>();
		
		try {
			// AD 인사 정보를 템프 테이블에 등록.
			// DB CONNECTION.
			Connection con 	= dbConnect();
			
			// TRUNCATE.
			PreparedStatement trunc_pstmt 	= null;
			//String trunc_sql 				= " TRUNCATE TABLE ezjobs.EZ_USER_AD ";
			String trunc_sql 				= "{call EZJOBS.SP_EZJOBS_TRUNCATE('EZ_USER_AD')}";
			trunc_pstmt 					= con.prepareCall(trunc_sql);
			trunc_pstmt.execute();
			
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
			properties.put(Context.SECURITY_CREDENTIALS, 	SeedUtil.decodeStr(strAdUserPw));
			
			int rsCnts = 0;

			try {
				
				context = new InitialDirContext(properties);
				SearchControls searcher = new SearchControls();

				// 기본 엔트리에서 시작해서 하위까지 하는거임.
				searcher.setSearchScope(SearchControls.SUBTREE_SCOPE);
				
				NamingEnumeration<SearchResult> results = context.search(strAdDistName, filterString, searcher);
				
				while (results.hasMore()) {
					SearchResult result = results.next();
					Attributes attrs = result.getAttributes();
					
					String strMaxCdSql = "";
					if ( rsCnts == 0) {
						strMaxCdSql = "(SELECT NVL(MAX(user_cd), 1) + 1 FROM ezjobs.EZ_USER)";
					} else {
						strMaxCdSql = "(SELECT NVL(MAX(user_cd), 1) + 1 FROM ezjobs.EZ_USER_AD)";
					}
					
					PreparedStatement pstmt 	= null;
					String sql 					= 	" INSERT INTO ezjobs.EZ_USER_AD (USER_CD, USER_ID, USER_PW, USER_NM, DEPT_NM, DUTY_NM, USER_EMAIL, USER_HP, INS_DATE) VALUES ";
					sql							+= 	" ( " + strMaxCdSql + ", ?, ?, ?, ?, ?, ?, ?, sysdate) ";
					pstmt 						= con.prepareStatement(sql);
	
					pstmt.setString(1, CommonUtil.isNull(attrs.get("Name")).replace("name: ", ""));
					pstmt.setString(2, SeedUtil.encodeStr(CommonUtil.isNull(attrs.get("Name")).replace("name: ", "")));
					pstmt.setString(3, CommonUtil.isNull(attrs.get("displayName")).replace("displayName: ", ""));
					pstmt.setString(4, CommonUtil.isNull(attrs.get("Department")).replace("department: ", ""));
					pstmt.setString(5, CommonUtil.isNull(attrs.get("title")).replace("title: ", ""));
					pstmt.setString(6, CommonUtil.isNull(attrs.get("mail")).replace("mail: ", ""));
					pstmt.setString(7, CommonUtil.isNull(attrs.get("mobile")).replace("mobile: ", ""));
					
					pstmt.executeUpdate();
					
					rsCnts++;
	    			//pstmt.addBatch();
				}
			} catch (NamingException e) {
				e.printStackTrace();
			}
			
			System.out.println("rsCnts.length : " + rsCnts + "건 EZ_USER_AD 저장 완료");
			
			// AD 인사 정보와 EzJOBs 사용자 정보 동기화.
			map.put("flag", "EZ_USER_AD");
			rMap = quartzDao.dPrcQuartz(map);
			
			String rCode 	= CommonUtil.isNull(rMap.get("r_code"));
			String rMsg 	= CommonUtil.getMessage(CommonUtil.isNull(rMap.get("r_msg")));
			String rCnt		= CommonUtil.isNull(rMap.get("r_cnt"));
			
			if ( rCode.equals("-2") ) {
				rMsg 	= CommonUtil.isNull(rMap.get("r_msg"));
			} else {
				rMsg 	= CommonUtil.getMessage(CommonUtil.isNull(rMap.get("r_msg")));
			}
			
			System.out.println("rCnt.length : " + rCnt + "건 EZ_USER MERGE 완료");

		} catch(Exception e) {
			logger.error("[" + strClassName + " Exception] : " + e);			
		}
	}
	
	private static Connection dbConnect() throws Exception {		

		String strUrl		= strDbUrl;
		String strUserNm	= strDbUserNm;
		String strPassword	= SeedUtil.decodeStr(strDbPassword);
		
		Connection con 		= null;
	
		try {
			
			Class.forName("oracle.jdbc.driver.OracleDriver");
			
			con = DriverManager.getConnection(strUrl, strUserNm, strPassword);
			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return con;
	}
}
