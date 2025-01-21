package com.ghayoun.ezjobs.t.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.security.SecureRandom;

import javax.mail.Flags.Flag;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.ghayoun.ezjobs.comm.domain.CommonBean;
import com.ghayoun.ezjobs.comm.repository.CommonDao;
import com.ghayoun.ezjobs.common.util.CommonUtil;
import com.ghayoun.ezjobs.common.util.DefaultServiceException;
import com.ghayoun.ezjobs.common.util.SeedUtil;
import com.ghayoun.ezjobs.t.domain.CompanyBean;
import com.ghayoun.ezjobs.t.domain.JobMapperBean;
import com.ghayoun.ezjobs.t.domain.UserBean;
import com.ghayoun.ezjobs.t.repository.WorksCompanyDao;
import com.ghayoun.ezjobs.t.repository.WorksUserDao;


public class WorksUserServiceImpl implements WorksUserService {
	
	protected final Log logger = LogFactory.getLog(getClass());
	
	private CommonDao commonDao;	
	private WorksUserDao worksUserDao;
	private WorksCompanyDao worksCompanyDao;
    
	public void setCommonDao(CommonDao commonDao) {
        this.commonDao = commonDao;
    }
	
    public void setWorksUserDao(WorksUserDao worksUserDao) {
        this.worksUserDao = worksUserDao;
    }
    
    public void setWorksCompanyDao(WorksCompanyDao worksCompanyDao) {
        this.worksCompanyDao = worksCompanyDao;
    }
	
    
	public UserBean dGetUserLogin(Map map) throws Exception {
		
		// 계정관리코드 : M3 : 패스워드주기
		map.put("mcode_cd", "M3");
		List sCodeList = commonDao.dGetsCodeList(map);
		
		String strSCodeNm = "";
		
		for( int i=0; null!=sCodeList && i<sCodeList.size(); i++ ){
			CommonBean bean = (CommonBean)sCodeList.get(i);
			
			strSCodeNm = CommonUtil.E2K(CommonUtil.isNull(bean.getScode_nm(), ""));
		}
		
		String strPwUpdateCycle = strSCodeNm;
		map.put("pw_update_cycle", strPwUpdateCycle);
		
		UserBean userBean = worksUserDao.dGetUserLogin(map);
		
		String strAccountLock 		= "";
		String strUserPw 			= "";	
		String strUserGb 			= "";	
		String strUserCd 			= "";
		String strMaxLoginCnt 		= "";	
		String strDisconnectCnt		= "";
		String strInsertPw 			= CommonUtil.toSha512(CommonUtil.isNull(map.get("user_pw"))).replace("&lt;","<").replace("&gt;",">").replace("&amp;","&");
		
		if ( userBean  != null ) {
			strAccountLock 		= CommonUtil.isNull(userBean.getAccount_lock());
			strUserPw 			= CommonUtil.isNull(userBean.getUser_pw());		
			strUserGb			= CommonUtil.isNull(userBean.getUser_gb());		
			strUserCd			= CommonUtil.isNull(userBean.getUser_cd());
			strMaxLoginCnt		= CommonUtil.isNull(userBean.getMax_login_cnt());
			strDisconnectCnt	= CommonUtil.isNull(userBean.getDisconnect_cnt(), "90");

			map.put("user_cd", strUserCd);
		
			// 아이디는 존재하는데 패스워드가 틀릴 경우 PW_FAIL_CNT '1' 증가.
			if ( !strUserPw.equals("") && !strInsertPw.equals(strUserPw) && !strUserGb.equals("99")) {
				map.put("flag", "pw_fail");
				worksUserDao.dPrcUser(map);
			} else if ( !strAccountLock.equals("Y") && !strUserPw.equals("") && strInsertPw.equals(strUserPw) ) {
				map.put("flag", "pw_ok");
				worksUserDao.dPrcUser(map);
			}

			// 장기 미사용 접속자 잠금 처리
			if ( !strMaxLoginCnt.equals("") && !strAccountLock.equals("U") ) {
				if ( Integer.parseInt(strMaxLoginCnt) > Integer.parseInt(strDisconnectCnt)) {
					map.put("flag", "account_lock_max");
					worksUserDao.dPrcUser(map);
				}
			}
		}

		// PW 관련 정보 가져오기.
		UserBean userPwBean = worksUserDao.dGetUserPwInfo(map);
		
		if ( userPwBean != null ) {
			
			String strPwFailCnt = CommonUtil.isNull(userPwBean.getPw_fail_cnt(), "0");
			
			if ( userBean  != null ) {			
				userBean.setPw_fail_cnt(strPwFailCnt);
				userBean.setPw_update_cycle(strPwUpdateCycle);
			}
			
			// 5회이상 틀리면 계정 잠금.
			if ( Integer.parseInt(strPwFailCnt) >= 5 ) {
				map.put("flag", "account_lock");
				worksUserDao.dPrcUser(map);
			}
		}
		
		return userBean;
	}
	
	public CommonBean dGetUserListCnt(Map map){
    	return worksUserDao.dGetUserListCnt(map);
    }
	public List<UserBean> dGetUserList(Map map){
		return worksUserDao.dGetUserList(map);
	}
	public List<UserBean> dGetFolderUserList(Map map){
		return worksUserDao.dGetFolderUserList(map);
	}
	public List<UserBean> dGetUserHistoryList(Map map){
		return worksUserDao.dGetUserHistoryList(map);
	}
	public List<UserBean> dGetLoginHistoryList(Map map){
		return worksUserDao.dGetLoginHistoryList(map);
	}
	public List<UserBean> dGetUserBatchList(Map map){
		return worksUserDao.dGetUserBatchList(map);
	}
	//담당자정보
	public JobMapperBean dGetJobMapperInfo(Map map){
		return worksUserDao.dGetJobMapperInfo(map);
	}
	public JobMapperBean dGetJobMapperOriInfo(Map map){
		return worksUserDao.dGetJobMapperOriInfo(map);
	}
	public JobMapperBean dGetJobMapperDocInfo(Map map){
    	return worksUserDao.dGetJobMapperDocInfo(map);
    }
	
	public JobMapperBean dGetJobMapperDocNowInfo(Map map){
    	return worksUserDao.dGetJobMapperDocNowInfo(map);
    }
	
	public JobMapperBean dGetJobMapperDocPrevInfo(Map map){
    	return worksUserDao.dGetJobMapperDocPrevInfo(map);
    }
	
	public JobMapperBean dGetPrevDocInfo(Map map){
    	return worksUserDao.dGetPrevDocInfo(map);
    }
	
	public JobMapperBean dGetNowDocInfo(Map map){
    	return worksUserDao.dGetNowDocInfo(map);
    }
	
	//폴더권한(이기준)
	public List<UserBean> dGetUserAuthList(Map map){
		return worksUserDao.dGetUserAuthList(map);
	}
	
	//폴더권한복사(김은희)
	@Override
	public List<CommonBean> dGetUserFolAuthList(Map map) {
        return worksUserDao.dGetUserFolAuthList(map);
    }
	
	//procedure
	@SuppressWarnings({ "rawtypes", "unchecked", "unused" })
	public Map dPrcUser(Map map) throws Exception {
		
		String strFlag 				= CommonUtil.isNull(map.get("flag"));
		String strFlag2 			= CommonUtil.isNull(map.get("flag2"));
		String strUserId 			= CommonUtil.isNull(map.get("user_id"));
		String strUserPw 			= CommonUtil.isNull(map.get("user_pw")).replace("&lt;","<").replace("&gt;",">").replace("&amp;","&");
		String strBeforePassword 	= CommonUtil.isNull(map.get("before_pw"));
		String strNewPassword 		= CommonUtil.isNull(map.get("new_user_pw")).replace("&lt;","<").replace("&gt;",">").replace("&amp;","&");
		String strReNewPassword 	= CommonUtil.isNull(map.get("re_new_user_pw")).replace("&lt;","<").replace("&gt;",">").replace("&amp;","&");
		String v_user_pw 			= CommonUtil.isNull(map.get("v_user_pw")).replace("&lt;","<").replace("&gt;",">").replace("&amp;","&");
		String strPwChk 			= CommonUtil.isNull(map.get("pw_chk"));
		
		map.put("select_table_name", CommonUtil.isNull(map.get("table_nm")));
		
		//어플리케이션,그룹명을 코드 기반 조회로 변경하면서 이름 값을 다른 요소에 받아옴.
		map.put("select_application", CommonUtil.isNull(map.get("application")));
		map.put("select_group_name", CommonUtil.isNull(map.get("group_name")));
		Map rMap = null;
		
		map.put("v_user_pw", v_user_pw);
		logger.debug("map : " + map);
		
		//유저관리
		if (strFlag.equals("ins")) { //1. 새로운 사용자 입력
			
			map.put("user_pw", CommonUtil.passwordEncrypt(map, strUserPw));
			
		}else if(strFlag.equals("del")) { //2. 사용자 삭제 (del_yn = 'Y')
			
			String[] delUserList = CommonUtil.isNull(map.get("delUserList")).split(",");
			
			rMap = null;
			
			for(String user : delUserList) {
				map.put("user_cd", CommonUtil.isNull(user));
				rMap = worksUserDao.dPrcUser(map);
				if( !"1".equals(CommonUtil.isNull(rMap.get("r_code"))) ) throw new DefaultServiceException(rMap);
			}
			
			return rMap;
			
		}else if(strFlag.equals("del_user")){//삭제된 유저 재 등록
			
			map.put("user_pw", CommonUtil.passwordEncrypt(map, strUserPw));
			
		} else { //3. 기존 사용자 정보 업데이트
			
			if(strFlag.equals("udt")) {
				if(!v_user_pw.equals("")) {
					map.put("user_pw", CommonUtil.passwordEncrypt(map, v_user_pw));
				}else {
					map.put("user_pw", strUserPw);
				}
			}
			
			UserBean userPwBean = worksUserDao.dGetUserPwInfo(map); //PW 관련 정보 가져오기.
			
			String strUserPasswd 	= "";
			String strBeforePasswd 	= "";
		
			if(!strNewPassword.equals("") ){
				
				//직전패스워드 체크	
				this.beforePwCheck(map);
				//사용자 패스워드 유효성 검증
				CommonUtil.passwordValid(map);
				
				if(strFlag.equals("udt")) {
					strNewPassword = v_user_pw;
				}
				
				strNewPassword = CommonUtil.passwordEncrypt(map, strNewPassword);
				
			}
			if ( userPwBean != null ) {
				strUserPasswd 	= CommonUtil.isNull(userPwBean.getUser_pw());
				strBeforePasswd = CommonUtil.isNull(userPwBean.getBefore_pw());
			}
			
			if(!strBeforePasswd.equals("")) {
				String v_befor_pw = "";
				logger.debug("strBeforePasswd : " + strBeforePasswd.split(",").length);
				if(strBeforePasswd.split(",").length >= 5) {
					for(int i=0; i<strBeforePasswd.split(",").length; i++) {
						
						logger.debug("i : " + i);
						if(i!=0) {//직전패스워드 컬럼에 바로 직전 패스워드 추가
							v_befor_pw +=strBeforePasswd.split(",")[i]+",";	
						}
						
					}
					
					map.put("before_pw", 	v_befor_pw+CommonUtil.isNull(map.get("user_pw")));
					
				}else {
					
					map.put("before_pw", 	strBeforePasswd+","+CommonUtil.isNull(map.get("user_pw")));
					
					logger.debug("before_pw : " + map.get("before_pw"));
				}
			}else if(strBeforePasswd.equals("")) {
				map.put("before_pw", 	strUserPasswd);
			}
			
			
		}
		rMap = null;
		if(strFlag.equals("del_user")) {
			worksUserDao.dDelUserJobMapper(map);
			rMap = worksUserDao.dPrcUser(map);
			map.put("flag", "ins");
		}
		rMap = worksUserDao.dPrcUser(map);
		logger.debug("rMap : " + rMap);
		if( !"1".equals(CommonUtil.isNull(rMap.get("r_code"))) ) throw new DefaultServiceException(rMap);
		
		CommonUtil.userSelectSessionSet(map);
		
		return rMap;		
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked", "unused" })
	public Map dPrcUserExcel(Map map) throws Exception {
		//test
		Map rMap = null;
		boolean compareDept;
		boolean compareDuty;
		
		String strDeptNm 				= CommonUtil.isNull(map.get("dept_nm"));
		String strDutyNm 				= CommonUtil.isNull(map.get("duty_nm"));
		
		String[] arr_strUserId			= CommonUtil.isNull(map.get("user_id")).split(",");
		String[] arr_strUserPw 			= CommonUtil.isNull(map.get("user_id")).split(",");
		String[] arr_strUserNm 			= CommonUtil.isNull(map.get("user_nm")).split(",");
		String[] arr_strDeptNm 			= CommonUtil.isNull(map.get("dept_nm")).split(",");
		String[] arr_strDutyNm 			= CommonUtil.isNull(map.get("duty_nm")).split(",");
		String[] arr_strUserEmail 		= CommonUtil.isNull(map.get("user_email")).split(",", -1);
		String[] arr_strUserHp 			= CommonUtil.isNull(map.get("user_hp")).split(",", -1);
		
		
		List deptList = CommonUtil.getDeptList();
		List dutyList = CommonUtil.getDutyList();
		
		String dept_cd = ""; 
		String dept_nm = "";
		String duty_cd = "";
		String duty_nm = "";  
		
		// Dept(부서) 존재여부 비교 -> 존재하지 않을경우 새롭게 추가
		for(int i = 0; i < arr_strDeptNm.length; i++) {
			compareDept = false;
			map.put("dept_nm", arr_strDeptNm[i]);
			for(int j = 0; j < deptList.size(); j++) {
				CompanyBean bean = (CompanyBean) deptList.get(j);
				dept_nm = CommonUtil.isNull(bean.getDept_nm());
				if(arr_strDeptNm[i].equals(dept_nm)) compareDept = true;
			}
			if(!compareDept) rMap = worksCompanyDao.dPrcDept(map);
		}
		
		// Duty(직책) 존재여부 비교 -> 존재하지 않을경우 새롭게 추가 
		for(int i = 0; i < arr_strDutyNm.length; i++) {
			compareDuty = false;
			map.put("duty_nm", arr_strDutyNm[i]);
			for(int j = 0; j <dutyList.size(); j++) {
				CompanyBean bean = (CompanyBean) dutyList.get(j);
				duty_nm = CommonUtil.isNull(bean.getDuty_nm());
				if(arr_strDutyNm[i].equals(duty_nm)) compareDuty = true;
			}
			if(!compareDuty) rMap = worksCompanyDao.dPrcDuty(map);
		}
		
		
		// 추가된 부서, 직책 데이터 조회
		deptList = CommonUtil.getDeptList();
		dutyList = CommonUtil.getDutyList();
		for(int i = 0; i < arr_strUserId.length; i++) {
			map.put("flag", 		"user_excel_insert");
			map.put("user_id", 		arr_strUserId[i]);
			map.put("user_pw", 		CommonUtil.toSha512(arr_strUserPw[i]+CommonUtil.isNull(map.get("user_id"))+CommonUtil.getMessage("SERVER_GB")));
			map.put("user_nm", 		arr_strUserNm[i]);
			map.put("dept_nm", 		arr_strDeptNm[i]);
			map.put("duty_nm", 		arr_strDutyNm[i]);
			map.put("user_email", 	arr_strUserEmail[i]);
			map.put("user_hp", 		arr_strUserHp[i]);
			map.put("user_gb", 		"01");
			
			compareDept = false;
			for(int j = 0; j <deptList.size(); j++) {
				CompanyBean bean = (CompanyBean) deptList.get(j);
				
				if( arr_strDeptNm[i].equals(CommonUtil.isNull(bean.getDept_nm())) && !compareDept ) {
					dept_nm = CommonUtil.isNull(bean.getDept_nm());
					dept_cd = CommonUtil.isNull(bean.getDept_cd());
					compareDept = true;
				}
			}
			if( compareDept ) {
				map.put("dept_nm", arr_strDeptNm[i]);
				map.put("dept_cd", dept_cd);
			}
		
			compareDuty = false;
			for(int j = 0; j <dutyList.size(); j++) {
				CompanyBean bean = (CompanyBean) dutyList.get(j);
				
				if( arr_strDutyNm[i].equals(CommonUtil.isNull(bean.getDuty_nm())) && !compareDuty ) {
					duty_nm = CommonUtil.isNull(bean.getDuty_nm());
					duty_cd = CommonUtil.isNull(bean.getDuty_cd());
					compareDuty = true;
				}
			}
			if( compareDuty ) {
				map.put("duty_nm", arr_strDutyNm[i]);
				map.put("duty_cd", duty_cd);
			}
			rMap = null;
			rMap = worksUserDao.dPrcUser(map);
			if( !"1".equals(CommonUtil.isNull(rMap.get("r_code"))) ) throw new DefaultServiceException(rMap);
		}
		  
		return rMap;
	}
	
	public Map dPrcJobMapper(Map map) throws Exception {
		
		String strFlag = CommonUtil.isNull(map.get("flag"));
		
		System.out.println("mapper_gubun : " + map.get("mapper_gubun"));
		System.out.println("mapper_gubun : " + map.get("mapper_gubun_2"));
		
		Map rMap = null;
		
		if ( strFlag.equals("batch_update") ) {
			String data_center = CommonUtil.isNull(map.get("data_center"));
			map.put("data_center", data_center);
			
			String[] job_names = CommonUtil.isNull(map.get("job_names")).split(",");
			for (int i = 0; i < job_names.length; i++) {
				map.put("job", job_names[i]);
				rMap = worksUserDao.dPrcJobMapper(map);
			}
		//작업 이관
		} else if (strFlag.equals("job_insert")) {
			
			map.put("data_center", 	CommonUtil.isNull(map.get("job_data_center")));
			
			// 작업 설명이 없을 경우에도 인덱스를 접근할 수 있게 개선 (2024.03.15 강명준)
			String[] job_insert_arr 	= CommonUtil.isNull(map.get("job_insert_arr")).split(",", -1);
			String[] desc_insert_arr 	= CommonUtil.isNull(map.get("desc_insert_arr")).split(",", -1);
			String[] late_subs 		= CommonUtil.isNull(map.get("late_subs")).split(",", -1);
			String[] late_times 		= CommonUtil.isNull(map.get("late_times")).split(",", -1);
			String[] late_execs 		= CommonUtil.isNull(map.get("late_execs")).split(",", -1);
			String[] success_sms_yns 	= CommonUtil.isNull(map.get("success_sms_yns")).split(",", -1);

			for (int i = 0; i < job_insert_arr.length; i++) {

				map.put("job", 				CommonUtil.isNull(job_insert_arr[i]));
				map.put("description", 		CommonUtil.isNull(desc_insert_arr[i]));
				map.put("late_sub", 		CommonUtil.replaceStrXml(CommonUtil.isNull(late_subs[i])));
				map.put("late_time", 		CommonUtil.replaceStrXml(CommonUtil.isNull(late_times[i])));
				map.put("late_exec", 		CommonUtil.replaceStrXml(CommonUtil.isNull(late_execs[i])));
				map.put("success_sms_yn", 	CommonUtil.replaceStrXml(CommonUtil.isNull(success_sms_yns[i])));

				rMap = worksUserDao.dPrcJobMapper(map);
			}
		} else {
			rMap = worksUserDao.dPrcJobMapper(map);
		}
		
		if( !"1".equals(CommonUtil.isNull(rMap.get("r_code"))) ) throw new DefaultServiceException(rMap);
		
		return rMap;
	}
	
	public List dGetSmsAdminList(Map map) {
        return worksUserDao.dGetSmsAdminList(map);
    }
	public CommonBean dGetJobUserInfo(Map map) {
        return worksUserDao.dGetJobUserInfo(map);
    }
	
	public List dGetApprovalGroupUserList(Map map) {
        return worksUserDao.dGetApprovalGroupUserList(map);
    }
	
	public List dGetApprovalUserList(Map map) {
        return worksUserDao.dGetApprovalUserList(map);
    }
	
	public List dGetApprovalAdminUserList(Map map) {
        return worksUserDao.dGetApprovalAdminUserList(map);
    }
	
	public List<CommonBean> dGetSendLogList(Map map) {
        return worksUserDao.dGetSendLogList(map);
    }
	
	public Map dPrcAllUser(Map map) throws Exception {
		
		Map<String, Object> rSingleMap 	= new HashMap<String, Object>();
		Map<String, Object> rMap 		= new HashMap<String, Object>();
		
		String strReturnMsg		= "";

		StringBuffer sb 		= new StringBuffer();
	
		String strUserCds 	= CommonUtil.isNull(map.get("user_cds"));
		String arrUserCd[] 	= CommonUtil.isNull(strUserCds).split(",");
		
		for ( int i = 0; i < arrUserCd.length; i++) {
			
			map.put("flag", 	"udt_all");
			map.put("user_cd", 	arrUserCd[i]);
			
			rSingleMap = worksUserDao.dPrcUser(map);
			
			if ( rSingleMap.get("r_code").equals("1") ) {
				sb.append("");
			} else {
				sb.append((i+1) + "번째 [" + arrUserCd[i] + "] 처리 에러" );
			}
		}

		if ( sb.toString().equals("") ) {
			strReturnMsg = "DEBUG.03";
		} else {
			strReturnMsg = sb.toString();
		}	
		
		rMap.put("r_code", "1");		
		rMap.put("r_msg", strReturnMsg);
		
		return rMap;	
	}

	public CommonBean dGetDocUserInfo(Map map) {
        return worksUserDao.dGetDocUserInfo(map);
    }
	public JobMapperBean dGetSrJobOrderInfo(Map map){
    	return worksUserDao.dGetSrJobOrderInfo(map);
    }

	public List<UserBean> dGetWorkGroup(Map map){
		return worksUserDao.dGetWorkGroup(map);
	}

	public List<UserBean> dGetAlarmInfo(Map map){
		return worksUserDao.dGetAlarmInfo(map);
	}

	// 알림설정관리 추가&수정&삭제
	public Map dPrcAlarmInfo(Map map) throws Exception{
		Map rMap = null;
		rMap = worksUserDao.dPrcAlarmInfo(map);
		if( !"1".equals(CommonUtil.isNull(rMap.get("r_code"))) ) throw new DefaultServiceException(rMap);
		
		return rMap;
	}
	
	
	
	/* 2024. 05. 21 (이기준)
	 * 패스워드 소스 리펙토링 관련
	 * 직전 패스워드 체크
	 * */
	public void beforePwCheck(Map map) throws Exception {
		String strNewPassword 		= CommonUtil.isNull(map.get("new_user_pw"));
		
		boolean bBeforePwChk = false; 
		Map rMap = null;
		// 직전 패스워드 확인
		//map.put("before_pw", SeedUtil.encodeStr(strNewPassword));
		CommonBean userBean = worksUserDao.dGetUserBeforePwChk(map);
		String strBeforePws = "";
		if ( userBean != null ) {
			strBeforePws = CommonUtil.isNull(userBean.getBefore_pw());
			logger.debug("strBeforePws : " + strBeforePws);
			String arrBeforePw[] = CommonUtil.isNull(strBeforePws).split(",");
			if ( arrBeforePw.length >= 5 ) {
				for ( int z = arrBeforePw.length-1; z >= arrBeforePw.length - 5; z-- ) {
					logger.debug("arrBeforePw[z]1 : " + arrBeforePw[z]);
					
					if ( arrBeforePw[z].equals(CommonUtil.passwordEncrypt(map, strNewPassword)) ) {
						bBeforePwChk = true;
					}
				}
			} else {
				for ( int z = 0; z < arrBeforePw.length; z++ ) {
					logger.debug("arrBeforePw[z]2 : " + arrBeforePw[z]);
					if ( arrBeforePw[z].equals(CommonUtil.passwordEncrypt(map, strNewPassword)) ) {
						bBeforePwChk = true;
					}
				}
			}
		}
		
		logger.debug("bBeforePwChk:::::::::::::::::::::::"+bBeforePwChk);
		if ( bBeforePwChk ) {					
			rMap = new HashMap();
			rMap.put("r_code",	"-1");
			rMap.put("r_msg",	"ERROR.58");
			throw new DefaultServiceException(rMap);
		}
	}
	
	
	//procedure
	/*
	 * 24.05.27 이기준
	 * 패스워드 소스 리펙토링 관련 
	 * 사용자 권한 관련 
	*/
	@SuppressWarnings({ "rawtypes", "unchecked", "unused" })
	public Map dPrcUserAuth(Map map) throws Exception {
		String strFlag 				= CommonUtil.isNull(map.get("flag"));
		
		Map rMap = null;
		
		//폴더권한 및 폴더권한복사 
		if(strFlag.equals("folder_auth") || strFlag.equals("ins_copy") || strFlag.equals("all_folder_auth")) {
			rMap = null;
			
			String[] user_cds =  CommonUtil.isNull(map.get("user_cd")).split(",");
			String[] data_centers =  CommonUtil.isNull(map.get("data_center")).split("[|]");
			
			String strFolderAuth = CommonUtil.isNull(map.get("folder_auth"));
			String[] folderAuthArr = strFolderAuth.split(",");
			
			map.put("flag", "folder_auth");
			
			rMap = null;
			
			for(int k=0; k<folderAuthArr.length; k++) {
				logger.debug("folderAuthArr[k] : "+ folderAuthArr[k]);
				map.put("folder_auth", folderAuthArr[k]);
				
				if(user_cds.length > 1) {
					for(int i=0; i<user_cds.length; i++) {
						map.put("user_cd", user_cds[i]);
						rMap = worksUserDao.dPrcUser(map);
					}
				}else {
					rMap = worksUserDao.dPrcUser(map);
				}
				
				if( !"1".equals(CommonUtil.isNull(rMap.get("r_code"))) ) throw new DefaultServiceException(rMap);
			}
		}else if(strFlag.equals("user_folder_auth_delete")){ // 사용자 폴더권한 삭제
			String[] user_cds =  CommonUtil.isNull(map.get("user_cd")).split(",");
			String[] data_centers =  CommonUtil.isNull(map.get("data_center")).split("[|]");

			String strFolderAuth = CommonUtil.isNull(map.get("folder_auth"));
			String[] folderAuthArr = strFolderAuth.split(",");
			
			rMap = null;
			
			for(int k=0; k<folderAuthArr.length; k++) {
				logger.debug("folderAuthArr[k] : "+ folderAuthArr[k]);
				map.put("folder_auth", folderAuthArr[k]);
				
				if(user_cds.length > 1) {
					for(int i=0; i<user_cds.length; i++) {
						map.put("user_cd", user_cds[i]);
						rMap = worksUserDao.dPrcUser(map);
					}
				}else {
					rMap = worksUserDao.dPrcUser(map);
				}
				
				if( !"1".equals(CommonUtil.isNull(rMap.get("r_code"))) ) throw new DefaultServiceException(rMap);
			}
		}else if(strFlag.equals("del_copy")) {
			
			String strFolderAuth = CommonUtil.isNull(map.get("folder_auth"));
			String[] data_centers =  CommonUtil.isNull(map.get("data_center")).split("[|]");
			String[] folderAuthArr = strFolderAuth.split(",");
			
			map.put("flag", "user_folder_auth_delete");
			
			rMap = null;
			
			for(int k=0; k<folderAuthArr.length; k++) {
				logger.debug("folderAuthArr[k] : "+ folderAuthArr[k]);
				
				map.put("folder_auth", folderAuthArr[k]);
				rMap = worksUserDao.dPrcUser(map);
				
				if( !"1".equals(CommonUtil.isNull(rMap.get("r_code"))) ) throw new DefaultServiceException(rMap);
			
			}
		//메뉴제한권한
		}else if (strFlag.equals("udt_auth")) {
			
			String[] user_cds =  CommonUtil.isNull(map.get("user_cd")).split(",");
			
			if(user_cds.length > 1) {
				for(int i=0; i<user_cds.length; i++) {
					map.put("user_cd", user_cds[i]);
					rMap = worksUserDao.dPrcUser(map);
				}
			}else {
				rMap = worksUserDao.dPrcUser(map);
			}
			
			if( !"1".equals(CommonUtil.isNull(rMap.get("r_code"))) ) throw new DefaultServiceException(rMap);
		
		}

		return rMap;
	}
	//procedure
	/*
	 * 24.05.27 이기준
	 * 패스워드 소스 리펙토링 관련
	 * 사용자 초기화 관련 
	*/
	@SuppressWarnings({ "rawtypes", "unchecked", "unused" })
	public Map dPrcUserInit(Map map) throws Exception {
		String strFlag 				= CommonUtil.isNull(map.get("flag"));
		
		map.put("select_table_name", CommonUtil.isNull(map.get("table_nm")));
		
		//어플리케이션,그룹명을 코드 기반 조회로 변경하면서 이름 값을 다른 요소에 받아옴.
		map.put("select_application", CommonUtil.isNull(map.get("application")));
		map.put("select_group_name", CommonUtil.isNull(map.get("group_name")));
		
		Map rMap = null;
		if(strFlag.equals("pw_init")) {
			
			// 패스워드 초기화 시 아이디 값으로 초기화 하고, 사용자가 패스워드 변경 시 기존 패스워드 필수 입력으로 변경 (2023.04.04 강명준)
			map.put("user_pw", CommonUtil.passwordEncrypt(map, CommonUtil.isNull(map.get("user_id"))));
			
		//일괄 패스워드 초기화
		}else if(strFlag.equals("pw_all_init")) {
			
			String[] user_cds =  CommonUtil.isNull(map.get("user_cd")).split(",");
			String[] user_ids =  CommonUtil.isNull(map.get("user_id")).split(",");
			if(user_cds.length > 1) {
				for(int i=0; i<user_cds.length; i++) {
					map.put("user_cd", user_cds[i]);
					map.put("user_id", user_ids[i]);
					
					// 패스워드 초기화 시 아이디 값으로 초기화 하고, 사용자가 패스워드 변경 시 기존 패스워드 필수 입력으로 변경 (2023.04.04 강명준)
					map.put("user_pw", CommonUtil.passwordEncrypt(map, CommonUtil.isNull(user_ids[i])));
					rMap = worksUserDao.dPrcUser(map);
				}
				
			}else {
				
				// 패스워드 초기화 시 아이디 값으로 초기화 하고, 사용자가 패스워드 변경 시 기존 패스워드 필수 입력으로 변경 (2023.04.04 강명준)
				map.put("user_pw", CommonUtil.passwordEncrypt(map, CommonUtil.isNull(map.get("user_id"))));
			}
		//일괄 잠금 해제
		}else if(strFlag.equals("account_lock_init")) {
			
			String[] user_cds =  CommonUtil.isNull(map.get("user_cd")).split(",");
			String[] user_ids =  CommonUtil.isNull(map.get("user_id")).split(",");
			String[] account_locks =  CommonUtil.isNull(map.get("account_lock")).split(",");
			
			if(user_ids.length > 1) {
				
				for(int i=0; i<user_ids.length; i++) {
					map.put("user_cd", user_cds[i]);
					map.put("user_id", user_ids[i]);
					map.put("account_lock", account_locks[i]);
					rMap = worksUserDao.dPrcUser(map);
				}
				
			}else {
				map.put("user_cd",  CommonUtil.isNull(map.get("user_cd")));
				map.put("user_id",  CommonUtil.isNull(map.get("user_id")));
				map.put("account_lock",  CommonUtil.isNull(map.get("account_lock")));
			}
		}
		
		rMap = null;
		rMap = worksUserDao.dPrcUser(map);
		
		if( !"1".equals(CommonUtil.isNull(rMap.get("r_code"))) ) throw new DefaultServiceException(rMap);
		
		CommonUtil.userSelectSessionSet(map);
		
		return rMap;
	}
	//procedure
	/*
	 * 24.05.27 이기준
	 * 패스워드 소스 리펙토링 관련
	 * 사용자 패스워드 변경 관련 
	*/
	@SuppressWarnings({ "rawtypes", "unchecked", "unused" })
	public Map dPrcUserPwChange(Map map) throws Exception {
		
		String strFlag 				= CommonUtil.isNull(map.get("flag"));
		String strUserPw 			= CommonUtil.isNull(map.get("user_pw")).replace("&lt;","<").replace("&gt;",">").replace("&amp;","&");
		String strBeforePassword 	= CommonUtil.isNull(map.get("before_pw"));
		String strNewPassword 		= CommonUtil.isNull(map.get("new_user_pw"));
		
		map.put("select_table_name", CommonUtil.isNull(map.get("table_nm")));
		
		//어플리케이션,그룹명을 코드 기반 조회로 변경하면서 이름 값을 다른 요소에 받아옴.
		map.put("select_application", CommonUtil.isNull(map.get("application")));
		map.put("select_group_name", CommonUtil.isNull(map.get("group_name")));
		
		Map rMap = null;
		
		// 패스워드 변경 시 기존 패스워드 필수 체크 (2023.04.04 강명준)
		if ( strFlag.equals("pw_change") || strFlag.equals("pw_date_over") ) {
			
			map.put("user_pw", CommonUtil.passwordEncrypt(map, strUserPw));
			CommonBean commonBean = worksUserDao.dGetUserPwChk(map);
			
			if ( commonBean.getTotal_count() == 0 ) {
				Map rPwMap = new HashMap();
				rPwMap.put("r_code",	"-1");
				rPwMap.put("r_msg",		"ERROR.05");
				throw new DefaultServiceException(rPwMap);
			}
			
			if(strFlag.equals("pw_date_over")) {
				
				strFlag = "pw_change";
				map.put("flag", "pw_change");
				
			}
			
		}

		UserBean userPwBean = worksUserDao.dGetUserPwInfo(map); //PW 관련 정보 가져오기.
		
		String strUserPasswd 	= "";
		String strBeforePasswd 	= "";
		
		if(!strNewPassword.equals("") ){
			
			//직전패스워드 체크	
			this.beforePwCheck(map);
			
			//사용자 패스워드 유효성 검증
			CommonUtil.passwordValid(map);
			strNewPassword = strNewPassword.replace("&lt;","<").replace("&gt;",">").replace("&amp;","&");
			strNewPassword = CommonUtil.passwordEncrypt(map, strNewPassword);
			
			if(strFlag.equals("pw_change")) { //유저관리화면 - 수정
				map.put("user_pw", strNewPassword);
			} 
			
		}
		
		if ( userPwBean != null ) {
			strUserPasswd 	= CommonUtil.isNull(userPwBean.getUser_pw());
			strBeforePasswd = CommonUtil.isNull(userPwBean.getBefore_pw());
		}
		if(!strBeforePasswd.equals("")) {
			
			String v_befor_pw = "";
			logger.debug("strBeforePasswd : " + strBeforePasswd.split(",").length);
			if(strBeforePasswd.split(",").length >= 5) {
				
				for(int i=0; i<strBeforePasswd.split(",").length; i++) {
					logger.debug("i : " + i);
					if(i!=0) {
						v_befor_pw +=strBeforePasswd.split(",")[i]+",";	
					}
				}
				
				if(strFlag.equals("pw_change")) {
					map.put("before_pw", 	v_befor_pw+strNewPassword);
				}else {
					map.put("before_pw", 	v_befor_pw+CommonUtil.isNull(map.get("user_pw")));
				}
				
			}else {
				
				if(strFlag.equals("pw_change")) {
					map.put("before_pw", 	strBeforePasswd+","+strNewPassword);
				}else {
					map.put("before_pw", 	strBeforePasswd+","+CommonUtil.isNull(map.get("user_pw")));
				}
				
				logger.debug("before_pw : " + map.get("before_pw"));
			}
		}else if(strBeforePasswd.equals("")) {
			map.put("before_pw", 	strUserPasswd);
		}
		
		rMap = worksUserDao.dPrcUser(map);
		if( !"1".equals(CommonUtil.isNull(rMap.get("r_code"))) ) throw new DefaultServiceException(rMap);
		
		CommonUtil.userSelectSessionSet(map);
		
		return rMap;
	}
	
	public Map dPrcCreateTempPassword(Map map) throws Exception {
		
		// 계정관리코드 : M3 : 패스워드주기
//		map.put("mcode_cd", "M3");
//		List sCodeList = commonDao.dGetsCodeList(map);
		
//		String strSCodeNm = "";
		
//		for( int i=0; null!=sCodeList && i<sCodeList.size(); i++ ){
//			CommonBean bean = (CommonBean)sCodeList.get(i);
//			
//			strSCodeNm = CommonUtil.E2K(CommonUtil.isNull(bean.getScode_nm(), ""));
//		}
//		
//		String strPwUpdateCycle = strSCodeNm;
//		map.put("pw_update_cycle", strPwUpdateCycle);
		
//		UserBean userBean = worksUserDao.dGetUserLogin(map);
		
		String temp_pw 	  		   = "";
		String characters 		   = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*()";
        SecureRandom random 	   = new SecureRandom();
        StringBuilder tempPassword = new StringBuilder();
        
		Map rMap = new HashMap();
		// 사용자 아이디 존재 여부 체크
//		if(userBean == null) {
//			rMap.put("r_code",	"-1");
//			rMap.put("r_msg",	"ERROR.04");
//			throw new DefaultServiceException(rMap);
//		}
		
		// 임시비밀번호 10자리 생성
		for (int i = 0; i < 10; i++) {
            int randomIndex = random.nextInt(characters.length());
            tempPassword.append(characters.charAt(randomIndex));
        }
		
		temp_pw = tempPassword.toString();
		
		System.out.println("temp_pw          : " + temp_pw);
		System.out.println("temp_pw encoding : " + SeedUtil.encodeStr(temp_pw));
		
		map.put("flag", "udt_temp_pw");
		map.put("temp_pw", temp_pw);
		
		rMap = worksUserDao.dPrcUser(map);
//		rMap.put("r_msg",	"DEBUG.01");
		System.out.println("rMap : " + rMap);
		return rMap;
	}
}