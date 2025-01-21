package com.ghayoun.ezjobs.comm.service;

import java.io.File;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
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
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.scheduling.quartz.QuartzJobBean;
import com.ghayoun.ezjobs.comm.repository.QuartzDao;
import com.ghayoun.ezjobs.common.util.CommonUtil;
import com.ghayoun.ezjobs.common.util.TraceLogUtil;

// Active Directory 사용자 정보를 실제 EzJOBs 사용자 정보에 매핑해준다. 
public class EzAdUserJobServiceImpl_NAVER extends QuartzJobBean{
	
	protected final Log logger = LogFactory.getLog(getClass());
	
	private QuartzDao quartzDao;
	
	public void setQuartzDao(QuartzDao quartzDao) {
        this.quartzDao = quartzDao;
    }
	
	static String strDbUrl			= "jdbc:oracle:thin:@(DESCRIPTION=(FAILOVER=ON)(LOAD_BALANCE=ON)(ADDRESS=(PROTOCOL=TCP)(HOST=192.168.23.95)(PORT=15000))(ADDRESS=(PROTOCOL=TCP)(HOST=192.168.23.96)(PORT=15000))(CONNECT_DATA=(SERVICE_NAME=CTRLM)(FAILOVER_MODE=(TYPE=SELECT)(METHOD=BASIC))))";
	static String strDbUserNm		= "ezuser";
	static String strDbPassword		= "ezpass";
	
	static String strAdUserNm		= CommonUtil.isNull(CommonUtil.getMessage("AD.USER.ID"));
	static String strAdUserPw		= CommonUtil.isNull(CommonUtil.getMessage("AD.USER.PW"));
	static String strAdLdapDomain	= CommonUtil.isNull(CommonUtil.getMessage("AD.LDAP.DOMAIN"));
	static String strAdDistName		= CommonUtil.isNull(CommonUtil.getMessage("AD.DIST.NAME"));
	static String strLdapPathFormat = "LDAP://%s/";
	
	protected void executeInternal(JobExecutionContext jobExecutionContext) throws JobExecutionException {
		
		// 로그 경로 가져오기.
		String strQuartzLogPath = CommonUtil.isNull(CommonUtil.getMessage("QUARTZ_LOG.PATH"));
		String strClassName		= this.getClass().getName().split("\\.")[this.getClass().getName().split("\\.").length-1];
		String strLogPath		= CommonUtil.getWebRootPath() + "/" + strQuartzLogPath + strClassName + "/";
		
		// 해당 폴더 없으면 생성.
		if ( !new File(strLogPath).exists() ) {					
			new File(strLogPath).mkdirs();
		}

		Map<String, Object> map 	= new HashMap<String, Object>();
		Map<String, Object> rMap 	= new HashMap<String, Object>();
		map.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		
		try {
			
			// AD 인사 정보를 템프 테이블에 등록.
			// DB CONNECTION.
			Connection con 	= dbConnect();
			
			// TRUNCATE.
			PreparedStatement trunc_pstmt 	= null;
			String trunc_sql 				= " TRUNCATE TABLE EZUSER.EZ_USER_AD ";
			trunc_pstmt 					= con.prepareStatement(trunc_sql);
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
			properties.put(Context.SECURITY_CREDENTIALS, 	strAdUserPw);
			
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
						strMaxCdSql = "(SELECT NVL(MAX(user_cd), 1) + 1 FROM EZUSER.EZ_USER)";
					} else {
						strMaxCdSql = "(SELECT NVL(MAX(user_cd), 1) + 1 FROM EZUSER.EZ_USER_AD)";
					}
					
					PreparedStatement pstmt 	= null;
					String sql 					= 	" INSERT INTO EZUSER.EZ_USER_AD (USER_CD, USER_ID, USER_NM, DEPT_NM, DUTY_NM, USER_EMAIL, USER_HP) VALUES ";
					sql							+= 	" (" + strMaxCdSql + ", ?, ?, ?, ?, ?, ?) ";
					pstmt 						= con.prepareStatement(sql);
	
					pstmt.setString(1, CommonUtil.isNull(attrs.get("Name")).replace("name: ", ""));
					pstmt.setString(2, CommonUtil.isNull(attrs.get("displayName")).replace("displayName: ", ""));
					pstmt.setString(3, CommonUtil.isNull(attrs.get("Department")).replace("department: ", ""));
					pstmt.setString(4, CommonUtil.isNull(attrs.get("title")).replace("title: ", ""));
					pstmt.setString(5, CommonUtil.isNull(attrs.get("mail")).replace("mail: ", ""));
					pstmt.setString(6, CommonUtil.isNull(attrs.get("mobile")).replace("mobile: ", ""));
					
					pstmt.executeUpdate();
					
					rsCnts++;
	    			//pstmt.addBatch();
				}
			} catch (NamingException e) {
				e.printStackTrace();
			}
			
			System.out.println("rsCnts.length : " + rsCnts + "건 완료");
			TraceLogUtil.TraceLog(rsCnts + "건 완료", strLogPath, strClassName);
			
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
			
			TraceLogUtil.TraceLog("[" + rCode + "] : " + rMsg, strLogPath, strClassName);

		} catch(Exception e) {
			TraceLogUtil.TraceLog(e.toString(), strLogPath, strClassName);
			logger.error("[" + strClassName + " Exception] : " + e);
			
		}
	}
	
	private static Connection dbConnect() throws SQLException {		

		String strUrl		= strDbUrl;
		String strUserNm	= strDbUserNm;
		String strPassword	= strDbPassword;
		
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
