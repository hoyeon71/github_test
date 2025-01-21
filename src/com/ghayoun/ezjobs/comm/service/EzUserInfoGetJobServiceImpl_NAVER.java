package com.ghayoun.ezjobs.comm.service;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.scheduling.quartz.QuartzJobBean;

import com.ghayoun.ezjobs.comm.domain.CommonBean;
import com.ghayoun.ezjobs.comm.repository.CommonDao;
import com.ghayoun.ezjobs.comm.repository.QuartzDao;
import com.ghayoun.ezjobs.common.util.CommonUtil;
import com.ghayoun.ezjobs.common.util.DateUtil;
import com.ghayoun.ezjobs.common.util.DefaultServiceException;
import com.ghayoun.ezjobs.common.util.TraceLogUtil;
import com.ghayoun.ezjobs.t.domain.CompanyBean;
import com.ghayoun.ezjobs.t.domain.UserBean;
import com.ghayoun.ezjobs.t.repository.WorksUserDao;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;


public class EzUserInfoGetJobServiceImpl_NAVER extends QuartzJobBean{
	
	protected final Log logger = LogFactory.getLog(getClass());
	
	private QuartzDao quartzDao;
	private WorksUserDao worksUserDao;
	private CommonDao commonDao;

	public void setQuartzDao(QuartzDao quartzDao) {
        this.quartzDao = quartzDao;
    }
	public void setWorksUserDao(WorksUserDao worksUserDao) {
        this.worksUserDao = worksUserDao;
    }
	public void setCommonDao(CommonDao commonDao) {
        this.commonDao = commonDao;
    }

	protected void executeInternal(JobExecutionContext jobExecutionContext) throws JobExecutionException {
		
		System.out.println("EzUserInfoGetJobService ========== start");
		
		// 로그 경로 가져오기.
		String strQuartzLogPath = CommonUtil.isNull(CommonUtil.getMessage("QUARTZ_LOG.PATH"));
		String strClassName		= this.getClass().getName().split("\\.")[this.getClass().getName().split("\\.").length-1];
		String strLogPath		= CommonUtil.getWebRootPath() + "/" + strQuartzLogPath + strClassName + "/";
		
		// 해당 폴더 없으면 생성.
		if ( !new File(strLogPath).exists() ) {
			new File(strLogPath).mkdirs();
		}
		
		Connection con 			= null;
		ResultSet rs			= null;
		
		Map<String, Object> map 	= new HashMap<String, Object>();
		Map<String, Object> rMap 	= new HashMap<String, Object>();		
		
		// DATA CENTER 정보 가져오기
		map.put("searchType", 		"dataCenterList");
		map.put("mcode_cd", 		"M6");
		map.put("SCHEMA",			CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		List dataCenterList = commonDao.dGetSearchItemList(map);
		
		String strDataCenter 	= "";
		String strScodeCd 		= "";
		
		if ( dataCenterList != null ) {
			strDataCenter		= ((CommonBean)dataCenterList.get(0)).getData_center();
			strScodeCd 			= ((CommonBean)dataCenterList.get(0)).getScode_cd();
		}
		
		try {
			
			/** RELAY 테이블 INSERT *//*
			map.put("SCHEMA", 	CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));

			//EZ_DEPT_RELAY 관리
			map.put("flag", 	"DEPT_RELAY_INSERT");
			boolean result = insertDeptRelay(map, strLogPath, strClassName);
			if (!result) return;
			
			// USER RELAY 관리			
			map.put("flag", 	"USER_RELAY_INSERT");
			result = insertUserRelay(map, strLogPath, strClassName);
			if (!result) return;
			
			// DUTY RELAY 관리 : EZ_USER_RELAY 테이블에 있는 duty_cd, duty_nm을 GROUP BY 해서 저장 (프로시저 내에서 EZ_USER_RELAY 조회 후 INSERT)
			map.put("flag", 	"DUTY_RELAY_INSERT");
			result = insertDutyRelay(map, strLogPath, strClassName);
			if (!result) return;*/
			
						
			// RELAY 테이블 기존 테이블과 MERGE
			String str_user_cd 	= "1";
			String str_user_ip 	= "127.0.0.1";
			
			// EZ_DEPT 테이블과 MERGE
			List<UserBean> relayDeptList = quartzDao.dGetDeptRelay(map);
			if (relayDeptList.size() > 0) {
				TraceLogUtil.TraceLog("EZ_DEPT ========== 시작", strLogPath, strClassName);
				
				Map<String, Object> deptMap = new HashMap<String, Object>();
				deptMap.put("SCHEMA",	CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
				deptMap.put("flag", 	"DEPT_BATCH");
				for (UserBean deptBean : relayDeptList) {
					String str_org_cd = CommonUtil.isNull(deptBean.getOrg_cd());
					deptMap.put("s_user_cd", 	str_user_cd);
					deptMap.put("s_user_ip", 	str_user_ip);
					deptMap.put("dept_id",		str_org_cd);
					deptMap.put("dept_nm",		CommonUtil.isNull(deptBean.getOrg_nm()));
					rMap = quartzDao.dPrcDept(deptMap);
					
					//로그 처리
					String r_code = CommonUtil.isNull(rMap.get("r_code"));
					String r_msg = CommonUtil.isNull(rMap.get("r_msg"));
					if(!"1".equals(r_code)) {
						if ("-1".equals(r_code))
							r_msg = CommonUtil.getMessage(r_msg);
						TraceLogUtil.TraceLog("[ERROR] "+r_msg+" (org_cd: "+str_org_cd+")", strLogPath, strClassName);
						return;
					}
				}
				
				TraceLogUtil.TraceLog("EZ_DEPT ========== 정상 종료", strLogPath, strClassName);
			}
			
			// EZ_DUTY 테이블과 MERGE
			List<UserBean> relayDutyList = quartzDao.dGetDutyRelay(map);
			if (relayDutyList.size() > 0) {
				TraceLogUtil.TraceLog("EZ_DUTY ========== 시작", strLogPath, strClassName);
				
				Map<String, Object> dutyMap = new HashMap<String, Object>();
				dutyMap.put("SCHEMA",	CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
				dutyMap.put("flag",		"DUTY_BATCH");
				for (UserBean DutyBean : relayDutyList) {
					String str_duty_cd = CommonUtil.isNull(DutyBean.getDuty_cd());
					dutyMap.put("s_user_cd", 		str_user_cd);
					dutyMap.put("s_user_ip", 		str_user_ip);
					dutyMap.put("duty_id",			str_duty_cd);
					dutyMap.put("duty_nm",			CommonUtil.isNull(DutyBean.getDuty_nm(), "이름 없음"));
					rMap = quartzDao.dPrcDuty(dutyMap);
					
					//로그 처리
					String r_code = CommonUtil.isNull(rMap.get("r_code"));
					String r_msg = CommonUtil.isNull(rMap.get("r_msg"));
					if(!"1".equals(r_code)) {
						if ("-1".equals(r_code))
							r_msg = CommonUtil.getMessage(r_msg);
						TraceLogUtil.TraceLog("[ERROR] "+r_msg+" (duty_cd: "+str_duty_cd+")", strLogPath, strClassName);
						return;
					}
				}
				
				TraceLogUtil.TraceLog("EZ_DUTY ========== 정상 종료", strLogPath, strClassName);
			}
			
			// EZ_USER 테이블과 MERGE
			List<UserBean> relayUserList = quartzDao.dGetUserReplay(map);
			if (relayUserList.size() > 0) {
				TraceLogUtil.TraceLog("EZ_USER ========== 시작", strLogPath, strClassName);
				
				Map<String, Object> userMap = new HashMap<String, Object>();
				userMap.put("SCHEMA",	CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
				userMap.put("flag", 	"USER_BATCH");
				int i = 0;
				for (UserBean UserBean : relayUserList) {
					String str_emp_no = CommonUtil.isNull(UserBean.getEmp_no());
					userMap.put("user_id",			str_emp_no);
					userMap.put("user_nm",			CommonUtil.isNull(UserBean.getEmp_nm()));
					userMap.put("user_pw",			CommonUtil.toSha512("ezjobs")); //기본 비밀번호 ezjobs
					userMap.put("user_gb",			"01"); //기본 사용자 구분 01
					userMap.put("dept_cd",			CommonUtil.isNull(UserBean.getDept_cd(), "9999")); // 부서가 없을 경우 9999로 설정
					userMap.put("duty_cd",			CommonUtil.isNull(UserBean.getDuty_cd(), "9999")); // 직책이 없을 경우 9999로 설정
					String state_cd = CommonUtil.isNull(UserBean.getState_cd());
					String del_yn = "N";
					String retire_yn = "N";
					if (state_cd.equals("003")) { //퇴사
						retire_yn = "Y";
					} else if (state_cd.equals("002")) { //휴직
						retire_yn = "M";
					}
					userMap.put("del_yn",								del_yn);
					userMap.put("retire_yn",							retire_yn);
					userMap.put("user_email",						CommonUtil.isNull(UserBean.getIn_email()));
					
					userMap.put("select_data_center_code",		strScodeCd + "," + strDataCenter);
					//userMap.put("select_table_name",				CommonUtil.isNull(UserBean.getDept_nm()));
					
					userMap.put("s_user_cd", 						str_user_cd);
					userMap.put("s_user_ip", 							str_user_ip);
					rMap = quartzDao.dPrcUser(userMap);
					
					//로그 처리
					String r_code = CommonUtil.isNull(rMap.get("r_code"));
					String r_msg = CommonUtil.isNull(rMap.get("r_msg"));
					if(!"1".equals(r_code)) {
						if ("-1".equals(r_code))
							r_msg = CommonUtil.getMessage(r_msg);
						TraceLogUtil.TraceLog("[ERROR] "+r_msg+" (emp_no: "+str_emp_no+")", strLogPath, strClassName);
						return;
					}
				}
				
				
				TraceLogUtil.TraceLog("EZ_USER ========== 정상 종료", strLogPath, strClassName);
			}
			
	        
		} catch (Exception e) {
			TraceLogUtil.TraceLog("[Exception] "+ e, strLogPath, strClassName);
			e.printStackTrace();
		} finally {
			try {				
		        con.close();
		        rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	private boolean insertDeptRelay(Map map, String logPath, String className) {
		
		Map<String, Object> rMap 	= new HashMap<String, Object>();
		
		int singleCh 		= 0;
		String json_string 	= "";
		String r_code		= "";
		String r_msg		= "";		
		
		TraceLogUtil.TraceLog("EZ_DEPT_RELAY ========== 시작", logPath, className);
		
		try {
		
	//		File file 				= new File("D:\\project\\EZJOBS_NAVER\\workspace\\EZJOBS_NAVER\\dept.txt");
			
			/*
			File file 				= new File("C:\\workspace_div\\ezjobs\\NAVER\\EZJOBS_NAVER\\dept.txt");
			FileReader filereader 	= new FileReader(file);
	
			while((singleCh = filereader.read()) != -1){
	            json_string += (char)singleCh;
	        }
	        */	       
			
			String strHrDeptUrl = CommonUtil.isNull(CommonUtil.getMessage("HR_DEPT_URL"));
			
			URL obj = new URL(strHrDeptUrl + "?baseYmd=" + DateUtil.getDay(0));
			HttpURLConnection conn = (HttpURLConnection) obj.openConnection();
			
			conn.setRequestMethod("GET");
			conn.setDoOutput(true);
			
			BufferedReader br 	= null;

			br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
			
			String line 		= "";
			
			while ((line = br.readLine()) != null) {				
				json_string = line;
			}
			
			
			
	
	//		System.out.println("json_string : " + json_string);
	
			JsonParser jsonParser = new JsonParser();
			JsonArray jsonArray = (JsonArray) jsonParser.parse(json_string);
			
			for (int i = 0; i < jsonArray.size(); i++) {
				
				JsonObject object = (JsonObject) jsonArray.get(i);
				
				String org_cd 		= CommonUtil.isNull(object.get("org_cd").getAsString());
				String org_nm 		= CommonUtil.isNull(object.get("org_nm").getAsString());
				String org_nm_eng 	= CommonUtil.isNull(object.get("org_nm_eng").getAsString());
				String bos_emp_no 	= CommonUtil.isNull(object.get("boss_emp_no").getAsString());
				
				// 부서명에 , 가 있으면 화면에서 split 할 때 오류 발생  
				org_nm = org_nm.replaceAll(",", " ");
				
	//			System.out.println("org_cd : " + org_cd);
	//			System.out.println("org_nm : " + org_nm);
	//			System.out.println("org_nm_eng : " + org_nm_eng);
	//			System.out.println("bos_emp_no : " + bos_emp_no);
	
				if ( i == 0 ) {
					// DEPT RELAY 테이블 삭제
					map.put("flag", 	"DEPT_RELAY_DELETE");
					map.put("SCHEMA", 	CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
					rMap = quartzDao.dPrcQuartz(map);
					
					r_msg = CommonUtil.isNull(rMap.get("r_msg")); 
					
					//로그 처리
					if(!"1".equals(CommonUtil.isNull(rMap.get("r_code")))) {
						TraceLogUtil.TraceLog("[ERROR] EZ_DEPT_RELAY 데이터 삭제 실패." + r_msg, logPath, className);
						return false;
					}
				}
				
				// DEPT RELAY 테이블 저장
				map.put("flag", 		"DEPT_RELAY_INSERT");
				map.put("SCHEMA", 		CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
				map.put("org_cd", 		org_cd);
				map.put("org_nm", 		org_nm);
				map.put("org_nm_eng", 	org_nm_eng);
				map.put("bos_emp_no", 	bos_emp_no);
				rMap = quartzDao.dPrcQuartz(map);
				
				//로그 처리 (에러 발생한 부서의 부서 코드와 에러메시지)
				r_code 	= CommonUtil.isNull(rMap.get("r_code"));
				r_msg 	= CommonUtil.isNull(rMap.get("r_msg"));
				
				if(!"1".equals(r_code)) {
					if("-1".equals(r_code))
						r_msg = CommonUtil.getMessage(r_msg);
					TraceLogUtil.TraceLog("[ERROR] "+r_msg+" (org_cd: "+org_cd+")", logPath, className);
					return false;
				}
			}
			
			br.close();
			conn.disconnect();
			
		} catch (Exception e) {
			TraceLogUtil.TraceLog("[Exception] "+ e, logPath, className);
			e.printStackTrace();
		}
		
		TraceLogUtil.TraceLog("EZ_DEPT_RELAY ========== 정상 종료", logPath, className);
		return true;
	}
	
	private boolean insertDutyRelay(Map map, String logPath, String className) {
		
		Map<String, Object> rMap 	= new HashMap<String, Object>();
		
		TraceLogUtil.TraceLog("EZ_DUTY_RELAY ========== 시작", logPath, className);
		
		try {
			
			// DUTY RELAY 테이블 삭제
			map.put("flag", 	"DUTY_RELAY_DELETE");
			rMap = quartzDao.dPrcQuartz(map);
			
			//로그 처리
			if(!"1".equals(CommonUtil.isNull(rMap.get("r_code")))) {
				TraceLogUtil.TraceLog("[ERROR] EZ_DUTY_RELAY 데이터 삭제 실패.", logPath, className);
				return false;
			}
			
			// DUTY RELAY 테이블 저장(프로시저 내에서 select insert)
			map.put("flag", 	"DUTY_RELAY_INSERT");
			rMap = quartzDao.dPrcQuartz(map);
			
			//로그 처리
			if(!"1".equals(CommonUtil.isNull(rMap.get("r_code")))) {
				TraceLogUtil.TraceLog("[ERROR] EZ_DUTY_RELAY 데이터 삽입 실패.", logPath, className);
				return false;
			}
			
		} catch (Exception e) {
			TraceLogUtil.TraceLog("[Exception] "+ e, logPath, className);
			e.printStackTrace();
		}
		
		TraceLogUtil.TraceLog("EZ_DUTY_RELAY ========== 정상 종료", logPath, className);
		return true;
	}
	
	private boolean insertUserRelay(Map map, String logPath, String className) {
		
		Map<String, Object> rMap 	= new HashMap<String, Object>();
		
		int singleCh 		= 0;
		String json_string 	= "";
		
		TraceLogUtil.TraceLog("EZ_USER_RELAY ========== 시작", logPath, className);
		
		try {
			
			/*
			File file 				= new File("C:\\workspace_div\\ezjobs\\NAVER\\EZJOBS_NAVER\\user.txt");
			FileReader filereader 	= new FileReader(file);

			while((singleCh = filereader.read()) != -1){
                json_string += (char)singleCh;
            }
            */
			
			String strHrUserUrl = CommonUtil.isNull(CommonUtil.getMessage("HR_USER_URL"));
			
			URL obj = new URL(strHrUserUrl);
			HttpURLConnection conn = (HttpURLConnection) obj.openConnection();
			
			conn.setRequestMethod("GET");
			conn.setDoOutput(true);
			
			BufferedReader br 	= null;

			br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
			
			String line 		= "";
			
			while ((line = br.readLine()) != null) {				
				json_string = line;
			}
			
			//TraceLogUtil.TraceLog("json_string : " + json_string, logPath, className);

			JsonParser jsonParser = new JsonParser();
			JsonArray jsonArray = (JsonArray) jsonParser.parse(json_string);
			
			TraceLogUtil.TraceLog("jsonArray.size() : " + jsonArray.size(), logPath, className);
			
			for (int i = 0; i < jsonArray.size(); i++) {
				JsonObject object = (JsonObject) jsonArray.get(i);
				
				String duty_cd 		= "";
				String duty_nm 		= "";
				
				String emp_no 		= CommonUtil.isNull(object.get("emp_no").getAsString());
				String emp_nm 		= CommonUtil.isNull(object.get("emp_nm").getAsString());
				String org_cd 		= CommonUtil.isNull(object.get("org_cd").getAsString());
				String state_cd 	= CommonUtil.isNull(object.get("state_cd").getAsString());
				String in_email 	= CommonUtil.isNull(object.get("in_email").getAsString());
				
				if ( !object.get("duty_cd").isJsonNull() ) {
					duty_cd 		= CommonUtil.isNull(object.get("duty_cd").getAsString());
				}
				
				if ( !object.get("duty_nm").isJsonNull() ) {
					duty_nm 		= CommonUtil.isNull(object.get("duty_nm").getAsString());
				}
				
				String sta_ymd 		= CommonUtil.isNull(object.get("sta_ymd").getAsString());
				String end_ymd 		= CommonUtil.isNull(object.get("end_ymd").getAsString());
				String relation_cd	= CommonUtil.isNull(object.get("relation_cd").getAsString());

				if ( i == 0 ) {
					// USER RELAY 테이블 삭제
					map.put("flag", 	"USER_RELAY_DELETE");
					rMap = quartzDao.dPrcQuartz(map);
					
					//로그 처리
					if(!"1".equals(CommonUtil.isNull(rMap.get("r_code")))) {
						TraceLogUtil.TraceLog("[ERROR] EZ_USER_RELAY 데이터 삭제 실패.", logPath, className);
						return false;
					}
				}
				
				// relation_cd : 주부서 겸직부서 구분이며, 주부서만 필요한 경우  'MAIN' 값의 데이타만 사용하세요.
				if ( relation_cd.equals("MAIN") ) {
				 
					// USER RELAY 테이블 저장
					map.put("flag", 		"USER_RELAY_INSERT");
	    			map.put("emp_no", 		emp_no);
	    			map.put("emp_nm", 		emp_nm);
	    			map.put("org_cd", 		org_cd);
	    			map.put("state_cd", 	state_cd);
	    			map.put("in_email", 	in_email);
	    			map.put("duty_cd", 		duty_cd);
	    			map.put("duty_nm", 		duty_nm);
	    			map.put("sta_ymd", 		sta_ymd);
	    			map.put("end_ymd", 		end_ymd);
	    			rMap = quartzDao.dPrcQuartz(map);
	    			
	    			//로그 처리 (에러 발생한 직원의 사번과 에러메시지)
					String r_code = CommonUtil.isNull(rMap.get("r_code"));
					String r_msg = CommonUtil.isNull(rMap.get("r_msg"));
					if(!"1".equals(r_code)) {
						if("-1".equals(r_code))
							r_msg = CommonUtil.getMessage(r_msg);
						TraceLogUtil.TraceLog("[ERROR] "+r_msg+" ("+emp_no+")", logPath, className);
						return false;
					}
				}
			}
			
			//filereader.close();
			br.close();
			conn.disconnect();
			
		} catch (Exception e) {
			TraceLogUtil.TraceLog("[Exception] "+ e, logPath, className);
			e.printStackTrace();
		}
		
		TraceLogUtil.TraceLog("EZ_USER_RELAY ========== 정상 종료", logPath, className);
		return true;
	}
}
