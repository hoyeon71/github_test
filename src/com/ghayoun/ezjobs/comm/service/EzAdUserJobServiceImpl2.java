package com.ghayoun.ezjobs.comm.service;

import java.io.File;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.Map;
import java.util.List;
import javax.naming.Context;
import javax.naming.NamingEnumeration;
import javax.naming.NamingException;
import javax.naming.directory.Attribute;
import javax.naming.directory.Attributes;
import javax.naming.directory.BasicAttribute;
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
import com.ghayoun.ezjobs.common.util.SeedUtil;
import com.ghayoun.ezjobs.common.util.TraceLogUtil;
import com.sshtools.j2ssh.subsystem.SubsystemOutputStream;


// Active Directory 사용자 정보를 실제 EzJOBs 사용자 정보에 매핑해준다. 
public class EzAdUserJobServiceImpl2 extends QuartzJobBean{
	
	protected final Log logger = LogFactory.getLog(getClass());
	
	private QuartzDao quartzDao;
	
	public void setQuartzDao(QuartzDao quartzDao) {
        this.quartzDao = quartzDao;
    }
	
	static String strDbUrl			= "jdbc:postgresql://192.168.10.54:15433/emdb";
	static String strDbUserNm		= "emuser";
	static String strDbPassword		= "empass"; 
	
	static String strAdUserNm		= CommonUtil.isNull(CommonUtil.getMessage("AD.ID"));
	static String strAdUserPw		= CommonUtil.isNull(CommonUtil.getMessage("AD.PW"));
	static String strAdLdapDomain	= CommonUtil.isNull(CommonUtil.getMessage("AD.LDAP.DOMAIN"));
	static String strAdDistName		= CommonUtil.isNull(CommonUtil.getMessage("AD.DIST.NAME"));
	static String url				= "LDAP://"+CommonUtil.getMessage("AD.IP")+":"+CommonUtil.getMessage("AD.PORT");
	static String strLdapPathFormat = "LDAP://%s/";
	
	String path = String.format(strLdapPathFormat, strAdLdapDomain);
	String filterString = "cn=*";
	
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
			String path = String.format(strLdapPathFormat, strAdLdapDomain);

			String filterString = "cn=*";

			// LDAP Context
			DirContext context = null;

			// LDAP 접속 환경 설정
			Hashtable<String, String> properties = new Hashtable<String, String>();
			
			properties.put(Context.INITIAL_CONTEXT_FACTORY	, "com.sun.jndi.ldap.LdapCtxFactory");
			properties.put(Context.PROVIDER_URL				, path);
			properties.put(Context.SECURITY_AUTHENTICATION  , "simple");
			properties.put(Context.SECURITY_PRINCIPAL		, strAdUserNm);
			properties.put(Context.SECURITY_CREDENTIALS		, SeedUtil.decodeStr(strAdUserPw));
			
			int rsCnts = 0;

			try {
				
				context = new InitialDirContext(properties);

				// 기본 엔트리에서 시작해서 하위까지 하는거임.
				SearchControls constraints = new SearchControls();
				constraints.setSearchScope(SearchControls.SUBTREE_SCOPE);
				
//				NamingEnumeration<SearchResult> results = context.search(strAdDistName, filterString, searcher);
				NamingEnumeration<?> searchResults = context.search(strAdDistName, filterString, constraints);
				
				if (searchResults != null && searchResults.hasMore()) {
					SearchResult searchResult = (SearchResult) searchResults.next();

					if (searchResult.getAttributes() == null) {
						System.out.println("*** No attributes ***");
					} 
					else {
						//그룹의 구성원을 가져온다.
						for (NamingEnumeration enums = searchResult.getAttributes().getAll(); enums.hasMore();) {
							Attribute attribute = (Attribute) enums.next();
							if (attribute.getID().equals("member")) {
								for (NamingEnumeration namingEnum = attribute.getAll(); namingEnum.hasMore();) {
									Object member = (Object) namingEnum.next();
									System.out.println("\t        = " + member.toString());
									String strAdDistName2 = member.toString();
									
									if(!strAdDistName2.contains("OU=Staff")) {
										continue;
									}
									NamingEnumeration<?> attrs2 = context.getAttributes(strAdDistName2).getAll();
									
									List<Map<String, Object>>  tmpMap = new ArrayList<Map<String, Object>>();
									
									Map<String, Object> deptMap = new HashMap<String, Object>();
									deptMap.put("SCHEMA",	CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
									deptMap.put("flag", 	"DEPT_BATCH");
									deptMap.put("s_user_cd", "1");
					            	deptMap.put("s_user_ip", "0:0:0:0:0:0:0:1");
									
									Map<String, Object> dutyMap = new HashMap<String, Object>();
									dutyMap.put("SCHEMA",	CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
									dutyMap.put("flag", 	"DUTY_BATCH");
									dutyMap.put("s_user_cd", "1");
					            	dutyMap.put("s_user_ip", "0:0:0:0:0:0:0:1");
									
									Map<String, Object> userMap = new HashMap<String, Object>();
									userMap.put("SCHEMA",	CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
									userMap.put("flag", 	"USER_BATCH");
									userMap.put("user_gb", "01");
									userMap.put("user_pw",			CommonUtil.toSha512("ezjobs")); //기본 비밀번호 ezjobs
					            	userMap.put("s_user_cd", "1");
					            	userMap.put("s_user_ip", "0:0:0:0:0:0:0:1");
									
									while (attrs2.hasMore()) {
										BasicAttribute atribute = (BasicAttribute) attrs2.next();
							            String key = atribute.getID();
							            
							            //사용자ID
							            if(key.equals("sAMAccountName")) {
							            	userMap.put("user_id", (String) atribute.get());
							            }
							            //사용자이름
							            if(key.equals("name")) {
							            	userMap.put("user_nm", (String) atribute.get());
							            	String user_nm = (String) atribute.get();
							            	userMap.put("user_nm", user_nm.substring(0,user_nm.indexOf("(")));
							            }
							            //사용자 email
							            if(key.equals("mail")) {
							            	userMap.put("user_email", (String) atribute.get());
							            } 
							            //사용자 전화번호 
							            if(key.equals("telephoneNumber")) {
							            	userMap.put("user_tel", (String) atribute.get());
							            }
							            //핸드폰 
							            if(key.equals("mobile")) {
							            	userMap.put("user_hp", (String) atribute.get());
							            }
							         	//부서 
							            if(key.equals("department")) {
							            	userMap.put("department", (String) atribute.get());
							            	userMap.put("dept_nm", (String) atribute.get()); 
							            	deptMap.put("dept_nm", (String) atribute.get());
							            }
							          	//직책 
							            if(key.equals("title")) {
							            	userMap.put("title", (String) atribute.get());
							            	userMap.put("duty_nm", (String) atribute.get());
							            	dutyMap.put("duty_nm", (String) atribute.get());
							            }
//		 					            System.out.println(key + "  " + (String) atribute.get());
							            
							            tmpMap.add(userMap);
									}
									
								   System.out.println("tmpMap.size :::::::::  " + tmpMap.size());
								   System.out.println("tmpMap  " + tmpMap);
									
//									System.out.println("usermap :: " + userMap);  
									
									//부서연동
//									System.out.println("deptmap :: " + deptMap);
									rMap = quartzDao.dPrcDept(deptMap);
									//로그 처리
									String r_code = CommonUtil.isNull(rMap.get("r_code"));
									String r_msg = CommonUtil.isNull(rMap.get("r_msg"));
									if(!"1".equals(r_code)) {
										if ("-1".equals(r_code))
										r_msg = CommonUtil.getMessage(r_msg);
										TraceLogUtil.TraceLog("[ERROR] "+r_msg+" ", strLogPath, strClassName);
										return;
									}
									
									//직책연동
									rMap = quartzDao.dPrcDuty(dutyMap);
									//로그 처리
									r_code = CommonUtil.isNull(rMap.get("r_code"));
									String r_msg2 = CommonUtil.isNull(rMap.get("r_msg"));
									if(!"1".equals(r_code)) {
										if ("-1".equals(r_code))
										r_msg = CommonUtil.getMessage(r_msg2);
										TraceLogUtil.TraceLog("[ERROR] "+r_msg2+" ", strLogPath, strClassName);
										return;
									}
									
									//사용자연동 
									rMap = quartzDao.dPrcUser(userMap);
									//로그 처리
									r_code = CommonUtil.isNull(rMap.get("r_code"));
									String r_msg3 = CommonUtil.isNull(rMap.get("r_msg"));
									if(!"1".equals(r_code)) {
										if ("-1".equals(r_code))
											r_msg = CommonUtil.getMessage(r_msg3);
										TraceLogUtil.TraceLog("[ERROR] "+r_msg3+" ", strLogPath, strClassName);
										return;
									}
									System.out.println("111111111111" + userMap);
								}
							}
						}
					}

				}
			} catch (NamingException e) {
				e.printStackTrace();
			}
			
		} catch(Exception e) {
			TraceLogUtil.TraceLog(e.toString(), strLogPath, strClassName);
			logger.error("[" + strClassName + " Exception] : " + e);
			
		}
	}
}
