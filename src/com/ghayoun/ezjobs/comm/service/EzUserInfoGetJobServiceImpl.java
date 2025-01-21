package com.ghayoun.ezjobs.comm.service;

import java.io.File;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.Map;
import java.util.List;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.scheduling.quartz.QuartzJobBean;
import com.ghayoun.ezjobs.comm.repository.QuartzDao;
import com.ghayoun.ezjobs.common.util.CommonUtil;
import com.ghayoun.ezjobs.common.util.SeedUtil;
import com.ghayoun.ezjobs.common.util.TraceLogUtil;
import com.ghayoun.ezjobs.t.domain.UserBean;

public class EzUserInfoGetJobServiceImpl extends QuartzJobBean{
	
	protected final Log logger = LogFactory.getLog(getClass());
	
	private QuartzDao quartzDao;
	
	static String strDbUrl			= CommonUtil.isNull(CommonUtil.getMessage("INSA.DB.URL"));  
	static String strDbUserNm		= CommonUtil.isNull(CommonUtil.getMessage("INSA.DB.ID"));  
	static String strDbPassword		= CommonUtil.isNull(CommonUtil.getMessage("INSA.DB.PW"));
	
	protected void executeInternal(JobExecutionContext jobExecutionContext) throws JobExecutionException {
		
		Map chkHostMap = CommonUtil.checkHost();
		
		String strHost 		= CommonUtil.isNull(chkHostMap.get("scode_host"));
		String strHostName 	= CommonUtil.isNull(chkHostMap.get("server_host"));
		Boolean chkHost 	= (Boolean) chkHostMap.get("chkHost");
		
		logger.debug("OS 호스트명 : " + strHostName);
		logger.debug("코드관리 호스트명 : " + strHost);
		logger.debug("호스트 체크 결과 : " + chkHost);
		
		if(chkHost) {
			try {
				ezUserInfoGetJobServiceImplCall();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
	
	public Map<String, Object> ezUserInfoGetJobServiceImplCall() {
		
		quartzDao = (QuartzDao) CommonUtil.getSpringBean("quartzDao");
		
		// 로그 경로 가져오기.
		String strQuartzLogPath = CommonUtil.isNull(CommonUtil.getMessage("QUARTZ_LOG.PATH"));
		String strClassName		= this.getClass().getName().split("\\.")[this.getClass().getName().split("\\.").length-1];
		String strLogPath		= CommonUtil.getWebRootPath() + "/" + strQuartzLogPath + strClassName + "/";
		
		// 해당 폴더 없으면 생성.
		if ( !new File(strLogPath).exists() ) {					
			new File(strLogPath).mkdirs();
		}
		
		Map<String, Object> map 	= new HashMap<String, Object>();
		Map<String, Object> userMap	= new HashMap<String, Object>();
		Map<String, Object> deptMap = new HashMap<String, Object>();
		Map<String, Object> dutyMap = new HashMap<String, Object>();
		Map<String, Object> rMap 	= new HashMap<String, Object>();
		
		try {
			
			// DB CONNECTION.
			Connection con 	= dbConnect();
			
			String sql 	= 	"select STFNO, NM, ORGCD, ORGNM, DTYNM, DTYCD, STF_FLGCD, STF_BZ_STCD, 		";
			sql 		+= 	"       RETDT, MAIL_ID, MAIL_DOWN, HNDPH_TLANO, HNDPH_TLTNO, HNDPH_TLSNO	";
			sql 		+= 	"  from VW_STF 																";
			
			PreparedStatement pstmt 	= con.prepareStatement(sql);
			ResultSet rs				= pstmt.executeQuery();

			String r_code 	= "";
			String r_msg 	= "";
			int rsCnts 		= 0;
			
			while(rs.next()) {
			
				String STFNO			= CommonUtil.isNull(rs.getString(1));
				String NM				= CommonUtil.isNull(rs.getString(2));
				String ORGCD 			= CommonUtil.isNull(rs.getString(3));
				String ORGNM 			= CommonUtil.isNull(rs.getString(4));
				String DTYNM 			= CommonUtil.isNull(rs.getString(5));
				String DTYCD			= CommonUtil.isNull(rs.getString(6));
				String STF_FLGCD		= CommonUtil.isNull(rs.getString(7));
				String STF_BZ_STCD 		= CommonUtil.isNull(rs.getString(8));
				String RETDT 			= CommonUtil.isNull(rs.getString(9));
				String MAIL_ID 			= CommonUtil.isNull(rs.getString(10));
				String MAIL_DOWN		= CommonUtil.isNull(rs.getString(11));
				String HNDPH_TLANO 		= CommonUtil.isNull(rs.getString(12));
				String HNDPH_TLTNO 		= CommonUtil.isNull(rs.getString(13));
				String HNDPH_TLSNO 		= CommonUtil.isNull(rs.getString(14));
			
				// 모든 RELAY 테이블 삭제
				if ( rsCnts == 0 ) {
					
					userMap.put("SCHEMA",	CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
					userMap.put("flag", 	"USER_RELAY_DELETE");
					rMap = quartzDao.dPrcQuartz(userMap);
					
					if(!"1".equals(CommonUtil.isNull(rMap.get("r_code")))) {
						logger.info("[ERROR] EZ_USER_RELAY 데이터 삭제 실패.");
					}
					
					deptMap.put("SCHEMA",	CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
					deptMap.put("flag", 	"DEPT_RELAY_DELETE");
					rMap = quartzDao.dPrcQuartz(deptMap);
					
					if(!"1".equals(CommonUtil.isNull(rMap.get("r_code")))) {
						logger.info("[ERROR] EZ_DEPT_RELAY 데이터 삭제 실패.");
					}
					
					dutyMap.put("SCHEMA",	CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
					dutyMap.put("flag", 	"DUTY_RELAY_DELETE");
					rMap = quartzDao.dPrcQuartz(dutyMap);
					
					if(!"1".equals(CommonUtil.isNull(rMap.get("r_code")))) {
						logger.info("[ERROR] EZ_DUTY_RELAY 데이터 삭제 실패.");
					}
				}
				
				// USER RELAY 저장
				userMap.put("SCHEMA",		CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
				userMap.put("flag", 		"USER_RELAY_INSERT");
				userMap.put("emp_no", 		STFNO);
				userMap.put("emp_nm", 		NM);
				userMap.put("org_nm", 		ORGNM);
				userMap.put("duty_nm", 		DTYNM);
				userMap.put("in_email", 	MAIL_ID + MAIL_DOWN);
				userMap.put("result_hp", 	HNDPH_TLANO + HNDPH_TLTNO + HNDPH_TLSNO);
				rMap = quartzDao.dPrcQuartz(userMap);
				
				r_code 	= CommonUtil.isNull(rMap.get("r_code"));
				r_msg 	= CommonUtil.isNull(rMap.get("r_msg"));
				
				if(!"1".equals(r_code)) {
					logger.info("[ERROR] "+r_msg+" (사번: "+STFNO+")");
				}
				
				rsCnts++;
			}
			
			// DEPT RELAY 저장
			deptMap.put("flag", "DEPT_RELAY_INSERT");
			rMap = quartzDao.dPrcQuartz(deptMap);
			
			r_code 	= CommonUtil.isNull(rMap.get("r_code"));
			r_msg 	= CommonUtil.isNull(rMap.get("r_msg"));
			
			if(!"1".equals(r_code)) {
				r_msg = CommonUtil.getMessage(r_msg);
				logger.info("[ERROR] EZ_DEPT_RELAY 데이터 저장 실패 : " + r_msg);
			}
			
			// DUTY RELAY 저장
			dutyMap.put("flag", "DUTY_RELAY_INSERT");
			rMap = quartzDao.dPrcQuartz(dutyMap);
			
			r_code 	= CommonUtil.isNull(rMap.get("r_code"));
			r_msg 	= CommonUtil.isNull(rMap.get("r_msg"));
			
			if(!"1".equals(r_code)) {
				r_msg = CommonUtil.getMessage(r_msg);
				logger.info("[ERROR] EZ_DUTY_RELAY 데이터 저장 실패 : " + r_msg);
			}
			
			boolean bDeptBatch;
			boolean bDutyBatch;
			boolean bUserBatch;
			
			String rCode 	= "-1";
			String rMsg 	= "처리 에러";
			
			// 인사 테이블 MERGE
			bDeptBatch = deptBatch();
			bDutyBatch = dutyBatch();
			bUserBatch = userBatch();
			
			// 일단 메시지는 하드 코딩으로 셋팅 후 고객사에서 오류 메시지 어떻게 찍어줄지 고민 (2023.08.17 강명준) 
			if ( bDeptBatch && bDutyBatch && bUserBatch ) {
				rCode 	= "1";
				rMsg	= "처리 완료"; 
			}
			
			map.put("SCHEMA", 		CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
			map.put("flag"			, "EZ_QUARTZ_LOG");
			map.put("quartz_name"	, "EZ_USER_INFO");
			map.put("trace_log_path", strLogPath);
			map.put("status_cd"		, rCode);
			map.put("status_log"	, rMsg);
			
			quartzDao.dPrcQuartz(map);
			
			logger.info("EzUserInfoGetJobService END");
			
		} catch(Exception e) {
			TraceLogUtil.TraceLog(e.toString(), strLogPath, strClassName);
			logger.error("[" + strClassName + " Exception] : " + e);
			
			map.put("SCHEMA", 		CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
			map.put("flag"			, "EZ_QUARTZ_LOG");
			map.put("quartz_name"	, "EZ_USER_INFO");
			map.put("trace_log_path", strLogPath);
			map.put("status_cd"		, "-1");
			map.put("status_log"	, e.toString());
			
			quartzDao.dPrcQuartz(map);
		}
		
		return rMap;
	}
	
	private static Connection dbConnect() throws SQLException {

		Connection con 		= null;
		
		try {
			
			Class.forName("oracle.jdbc.driver.OracleDriver");
					
			con = DriverManager.getConnection(strDbUrl, strDbUserNm, SeedUtil.decodeStr(strDbPassword));
			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (Exception e) {				
			e.printStackTrace();			
		}
		
		return con;
	}
	
	private boolean deptBatch() {
		
		Map<String, Object> map 	= new HashMap<String, Object>();
		Map<String, Object> rMap 	= new HashMap<String, Object>();
		
		map.put("SCHEMA", 		CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		
		boolean bDeptBatch = true;
		
		List<UserBean> relayDeptList = quartzDao.dGetDeptRelay(map);
		
		if (relayDeptList.size() > 0) {
			
			logger.info("EZ_DEPT ========== START");
			
			map.put("flag", "DEPT_BATCH");
			
			int i = 0;
			
			for (UserBean UserBean : relayDeptList) {
				
				map.put("dept_nm",					CommonUtil.isNull(UserBean.getDept_nm()));
				map.put("s_user_cd", 				"1");
				map.put("s_user_ip", 				"0:0:0:0:0:0:0:1");
				rMap = quartzDao.dPrcDept(map);
				
				String r_code 	= CommonUtil.isNull(rMap.get("r_code"));
				String r_msg 	= CommonUtil.isNull(rMap.get("r_msg"));
				
				if(!"1".equals(r_code)) {
					logger.info("[ERROR] "+r_msg+" (부서: "+CommonUtil.isNull(UserBean.getDept_nm())+")");
					
					bDeptBatch = false;
				}
			}
			
			logger.info("EZ_DEPT ========== END >>>" + bDeptBatch);
		}
		
		return bDeptBatch;
	}
	
	private boolean dutyBatch() {
		
		Map<String, Object> map 	= new HashMap<String, Object>();
		Map<String, Object> rMap 	= new HashMap<String, Object>();
		
		map.put("SCHEMA", 			CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		
		boolean bDutyBatch = true;
		
		List<UserBean> relayDutyList = quartzDao.dGetDutyRelay(map);
		
		if (relayDutyList.size() > 0) {
			
			logger.info("EZ_DUTY ========== START");
			
			map.put("flag", 	"DUTY_BATCH");
			
			int i = 0;
			
			for (UserBean UserBean : relayDutyList) {
				
				map.put("duty_nm",					CommonUtil.isNull(UserBean.getDuty_nm()));
				map.put("s_user_cd", 				"1");
				map.put("s_user_ip", 				"0:0:0:0:0:0:0:1");
				rMap = quartzDao.dPrcDuty(map);
				
				String r_code 	= CommonUtil.isNull(rMap.get("r_code"));
				String r_msg 	= CommonUtil.isNull(rMap.get("r_msg"));
				
				if(!"1".equals(r_code)) {
					logger.info("[ERROR] "+r_msg+" (직책: "+CommonUtil.isNull(UserBean.getDuty_nm())+")");
					
					bDutyBatch = false;
				}
			}
			
			logger.info("EZ_DUTY ========== END >>>" + bDutyBatch);
		}
		
		return bDutyBatch;
	}
	
	private boolean userBatch() {
		
		Map<String, Object> map 	= new HashMap<String, Object>();
		Map<String, Object> rMap 	= new HashMap<String, Object>();
		
		map.put("SCHEMA", 		CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		
		boolean bUserBatch = true;
		
		List<UserBean> relayUserList = quartzDao.dGetUserReplay(map);
		
		if (relayUserList.size() > 0) {
			
			logger.info("EZ_USER ========== START");
			
			map.put("SCHEMA", 	CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
			map.put("flag", 	"USER_BATCH");
			
			int i = 0;
			
			for (UserBean UserBean : relayUserList) {
				
				map.put("user_id",					CommonUtil.isNull(UserBean.getUser_id()));
				map.put("user_nm",					CommonUtil.isNull(UserBean.getUser_nm()));
				map.put("user_pw",					CommonUtil.toSha512(CommonUtil.isNull(UserBean.getUser_id())+CommonUtil.isNull(UserBean.getUser_id())+CommonUtil.getMessage("SERVER_GB")));
				map.put("user_gb",					"01"); //기본 사용자 구분 01
				map.put("dept_nm",					CommonUtil.isNull(UserBean.getDept_nm(), "9999")); // 부서가 없을 경우 9999로 설정
				map.put("duty_nm",					CommonUtil.isNull(UserBean.getDuty_nm(), "9999")); // 직책이 없을 경우 9999로 설정
				map.put("del_yn",					"N");
				map.put("retire_yn",				"N");
				map.put("user_hp",					CommonUtil.isNull(UserBean.getUser_hp()));
				map.put("user_email",				CommonUtil.isNull(UserBean.getUser_email()));
				//map.put("select_data_center_code",	strScodeCd + "," + strDataCenter);				
				map.put("s_user_cd", 				"1");
				map.put("s_user_ip", 				"0:0:0:0:0:0:0:1");
				
				rMap = quartzDao.dPrcUser(map);
				
				String r_code 	= CommonUtil.isNull(rMap.get("r_code"));
				String r_msg 	= CommonUtil.isNull(rMap.get("r_msg"));
				
				if(!"1".equals(r_code)) {
					
					logger.info("[ERROR] "+r_msg+" (사번: "+CommonUtil.isNull(UserBean.getUser_id())+")");
					
					bUserBatch = false;
					
				}
			}
			
			logger.info("EZ_USER ========== END >>>" + bUserBatch);
		}
		
		return bUserBatch;
	}
}
