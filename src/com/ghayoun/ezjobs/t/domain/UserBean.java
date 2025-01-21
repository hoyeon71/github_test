package com.ghayoun.ezjobs.t.domain;

import java.io.Serializable;

public class UserBean implements Serializable {
	
	private int row_num 						= 0;
	
	private String user_cd						= "";
	private String user_id        				= "";
	private String user_nm        				= "";
	private String user_pw        				= "";
	private String user_gb        				= "";
	private String user_email        			= "";
	private String user_hp        				= "";
	private String user_tel        				= "";
	private String no_auth        				= "";
	private String dept_cd        				= "";
	private String dept_id        				= "";
	private String dept_nm        				= "";
	private String duty_cd        				= "";
	private String duty_id        				= "";
	private String duty_nm       	 			= "";
	private String user_appr_gb    	 			= "";
	private String part_cd        				= "";
	private String part_nm       	 			= "";
	private String del_yn         				= "";
	private String retire_yn       				= "";
	private String absence_start_date			= "";
	private String absence_end_date     		= "";
	private String absence_reason       		= "";
	private String absence_user_cd     	 		= "";
	private String absence_user_nm      		= "";
	private String ins_date      	 			= "";
	private String ins_user_cd    				= "";
	private String ins_user_ip    				= "";
	private String udt_date       				= "";
	private String udt_user_cd    				= "";
	private String udt_user_ip    				= "";
	private String select_data_center_code    	= ""; 
	private String select_data_center    		= "";
	
	private String pw_fail_cnt    				= "";
	private String pw_date    					= "";
	private String before_pw    				= "";
	private String account_lock    				= "";
	private String pw_date_over    				= "";
	private String pw_update_cycle 				= "";	
	private String mapper_cnt	 				= "";
	private String default_paging 				= "";
	private String alert_cnt					= "";
	private String reset_yn						= "";
	
	private String team_cd		 				= "";
	private String select_table_name	    	= "";
	private String select_application	    	= "";
	private String select_group_name		   	= "";
	
	//dept_relay
	private String org_cd						= "";
	private String org_nm						= "";
	
	//user relay
	private String emp_no						= "";
	private String emp_nm						= "";
	private String state_cd						= "";
	private String in_email						= "";
	private String sta_ymd						= "";
	private String end_ymd						= "";
	
	private String folder_auth					= "";
	
	private String control_flag					= "";
	
	private String alarm_chk1					= "";
	private String alarm_chk2   				= "";
	private String alarm_chk3   				= "";
	
	private String user_ip		   				= "";
	
	private String disconnect_cnt		   		= "";
	private String Max_login_date		   		= "";
	private String Max_login_cnt		   		= "";
	
	private String flag							= "";
	private String reg_date						= "";
	
	private String ins_user_nm    				= "";
	private String udt_user_nm    				= "";
	private String folder_count    				= "";

	//알림설정관리
	private String alarm_standard 				= "";
	private String alarm_min 					= "";
	private String alarm_max 					= "";
	private String alarm_unit 					= "";
	private String alarm_time 					= "";
	private String alarm_over 					= "";
	private String alarm_over_time 				= "";
	private String alarm_seq 					= "";

	public String getOrg_cd() {
		return org_cd;
	}
	public void setOrg_cd(String org_cd) {
		this.org_cd = org_cd;
	}
	public String getOrg_nm() {
		return org_nm;
	}
	public void setOrg_nm(String org_nm) {
		this.org_nm = org_nm;
	}
	public String getEmp_no() {
		return emp_no;
	}
	public void setEmp_no(String emp_no) {
		this.emp_no = emp_no;
	}
	public String getEmp_nm() {
		return emp_nm;
	}
	public void setEmp_nm(String emp_nm) {
		this.emp_nm = emp_nm;
	}
	public String getState_cd() {
		return state_cd;
	}
	public void setState_cd(String state_cd) {
		this.state_cd = state_cd;
	}
	public String getIn_email() {
		return in_email;
	}
	public void setIn_email(String in_email) {
		this.in_email = in_email;
	}
	public String getSta_ymd() {
		return sta_ymd;
	}
	public void setSta_ymd(String sta_ymd) {
		this.sta_ymd = sta_ymd;
	}
	public String getEnd_ymd() {
		return end_ymd;
	}
	public void setEnd_ymd(String end_ymd) {
		this.end_ymd = end_ymd;
	}
	public String getSelect_table_name() {
		return select_table_name;
	}
	public void setSelect_table_name(String select_table_name) {
		this.select_table_name = select_table_name;
	}
	public String getSelect_application() {
		return select_application;
	}
	public void setSelect_application(String select_application) {
		this.select_application = select_application;
	}
	public String getSelect_group_name() {
		return select_group_name;
	}
	public void setSelect_group_name(String select_group_name) {
		this.select_group_name = select_group_name;
	}
	public String getDept_id() {
		return dept_id;
	}
	public void setDept_id(String dept_id) {
		this.dept_id = dept_id;
	}
	public String getDuty_id() {
		return duty_id;
	}
	public void setDuty_id(String duty_id) {
		this.duty_id = duty_id;
	}
	public int getRow_num() {
		return row_num;
	}
	public void setRow_num(int row_num) {
		this.row_num = row_num;
	}
	public String getUser_cd() {
		return user_cd;
	}
	public void setUser_cd(String user_cd) {
		this.user_cd = user_cd;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getUser_pw() {
		return user_pw;
	}
	public void setUser_pw(String user_pw) {
		this.user_pw = user_pw;
	}
	public String getUser_gb() {
		return user_gb;
	}
	public void setUser_gb(String user_gb) {
		this.user_gb = user_gb;
	}
	public String getNo_auth() {
		return no_auth;
	}
	public void setNo_auth(String no_auth) {
		this.no_auth = no_auth;
	}
	public String getDel_yn() {
		return del_yn;
	}
	public void setDel_yn(String del_yn) {
		this.del_yn = del_yn;
	}
	public String getIns_date() {
		return ins_date;
	}
	public void setIns_date(String ins_date) {
		this.ins_date = ins_date;
	}
	public String getIns_user_cd() {
		return ins_user_cd;
	}
	public void setIns_user_cd(String ins_user_cd) {
		this.ins_user_cd = ins_user_cd;
	}
	public String getIns_user_ip() {
		return ins_user_ip;
	}
	public void setIns_user_ip(String ins_user_ip) {
		this.ins_user_ip = ins_user_ip;
	}
	public String getUdt_date() {
		return udt_date;
	}
	public void setUdt_date(String udt_date) {
		this.udt_date = udt_date;
	}
	public String getUdt_user_cd() {
		return udt_user_cd;
	}
	public void setUdt_user_cd(String udt_user_cd) {
		this.udt_user_cd = udt_user_cd;
	}
	public String getUdt_user_ip() {
		return udt_user_ip;
	}
	public void setUdt_user_ip(String udt_user_ip) {
		this.udt_user_ip = udt_user_ip;
	}
	public String getDept_cd() {
		return dept_cd;
	}
	public void setDept_cd(String dept_cd) {
		this.dept_cd = dept_cd;
	}
	public String getDuty_cd() {
		return duty_cd;
	}
	public void setDuty_cd(String duty_cd) {
		this.duty_cd = duty_cd;
	}
	public String getUser_nm() {
		return user_nm;
	}
	public void setUser_nm(String user_nm) {
		this.user_nm = user_nm;
	}
	public String getDept_nm() {
		return dept_nm;
	}
	public void setDept_nm(String dept_nm) {
		this.dept_nm = dept_nm;
	}
	public String getDuty_nm() {
		return duty_nm;
	}
	public void setDuty_nm(String duty_nm) {
		this.duty_nm = duty_nm;
	}
	public String getUser_appr_gb() {
		return user_appr_gb;
	}
	public void setUser_appr_gb(String user_appr_gb) {
		this.user_appr_gb = user_appr_gb;
	}
	public String getUser_email() {
		return user_email;
	}
	public void setUser_email(String user_email) {
		this.user_email = user_email;
	}
	public String getUser_hp() {
		return user_hp;
	}
	public void setUser_hp(String user_hp) {
		this.user_hp = user_hp;
	}
	public String getSelect_data_center_code() {
		return select_data_center_code;
	}
	public void setSelect_data_center_code(String selectDataCenterCode) {
		select_data_center_code = selectDataCenterCode;
	}
	public String getSelect_data_center() {
		return select_data_center;
	}
	public void setSelect_data_center(String selectDataCenter) {
		select_data_center = selectDataCenter;
	}
	public String getPw_fail_cnt() {
		return pw_fail_cnt;
	}
	public void setPw_fail_cnt(String pwFailCnt) {
		pw_fail_cnt = pwFailCnt;
	}
	public String getPw_date() {
		return pw_date;
	}
	public void setPw_date(String pwDate) {
		pw_date = pwDate;
	}
	public String getBefore_pw() {
		return before_pw;
	}
	public void setBefore_pw(String beforePw) {
		before_pw = beforePw;
	}
	public String getAccount_lock() {
		return account_lock;
	}
	public void setAccount_lock(String accountLock) {
		account_lock = accountLock;
	}
	public String getPw_date_over() {
		return pw_date_over;
	}
	public void setPw_date_over(String pwDateOver) {
		pw_date_over = pwDateOver;
	}
	public String getPw_update_cycle() {
		return pw_update_cycle;
	}
	public void setPw_update_cycle(String pwUpdateCycle) {
		pw_update_cycle = pwUpdateCycle;
	}
	public String getUser_tel() {
		return user_tel;
	}
	public void setUser_tel(String userTel) {
		user_tel = userTel;
	}
	public String getAbsence_start_date() {
		return absence_start_date;
	}
	public void setAbsence_start_date(String absenceStartDate) {
		absence_start_date = absenceStartDate;
	}
	public String getAbsence_end_date() {
		return absence_end_date;
	}
	public void setAbsence_end_date(String absenceEndDate) {
		absence_end_date = absenceEndDate;
	}
	public String getAbsence_reason() {
		return absence_reason;
	}
	public void setAbsence_reason(String absenceReason) {
		absence_reason = absenceReason;
	}
	public String getAbsence_user_cd() {
		return absence_user_cd;
	}
	public void setAbsence_user_cd(String absenceUserCd) {
		absence_user_cd = absenceUserCd;
	}
	public String getAbsence_user_nm() {
		return absence_user_nm;
	}
	public void setAbsence_user_nm(String absenceUserNm) {
		absence_user_nm = absenceUserNm;
	}
	public String getPart_cd() {
		return part_cd;
	}
	public void setPart_cd(String partCd) {
		part_cd = partCd;
	}
	public String getPart_nm() {
		return part_nm;
	}
	public void setPart_nm(String partNm) {
		part_nm = partNm;
	}
	public String getRetire_yn() {
		return retire_yn;
	}
	public void setRetire_yn(String retireYn) {
		retire_yn = retireYn;
	}
	public String getMapper_cnt() {
		return mapper_cnt;
	}
	public void setMapper_cnt(String mapperCnt) {
		mapper_cnt = mapperCnt;
	}
	public String getDefault_paging() {
		return default_paging;
	}
	public void setDefault_paging(String defaultPaging) {
		default_paging = defaultPaging;
	}
	public String getAlert_cnt() {
		return alert_cnt;
	}
	public void setAlert_cnt(String alertCnt) {
		alert_cnt = alertCnt;
	}
	public String getReset_yn() {
		return reset_yn;
	}
	public void setReset_yn(String resetYn) {
		reset_yn = resetYn;
	}
	public String getTeam_cd() {
		return team_cd;
	}
	public void setTeam_cd(String team_cd) {
		this.team_cd = team_cd;
	}
	public String getFolder_auth() {
		return folder_auth;
	}
	public void setFolder_auth(String folder_auth) {
		this.folder_auth = folder_auth;
	}
	public String getControl_flag() {
		return control_flag;
	}
	public void setControl_flag(String control_flag) {
		this.control_flag = control_flag;
	}
	public String getAlarm_chk1() {
		return alarm_chk1;
	}
	public void setAlarm_chk1(String alarm_chk1) {
		this.alarm_chk1 = alarm_chk1;
	}
	public String getAlarm_chk2() {
		return alarm_chk2;
	}
	public void setAlarm_chk2(String alarm_chk2) {
		this.alarm_chk2 = alarm_chk2;
	}
	public String getAlarm_chk3() {
		return alarm_chk3;
	}
	public void setAlarm_chk3(String alarm_chk3) {
		this.alarm_chk3 = alarm_chk3;
	}
	public String getUser_ip() {
		return user_ip;
	}
	public void setUser_ip(String user_ip) {
		this.user_ip = user_ip;
	}
	public String getFlag() {
		return flag;
	}
	public void setFlag(String flag) {
		this.flag = flag;
	}
	public String getReg_date() {
		return reg_date;
	}
	public void setReg_date(String reg_date) {
		this.reg_date = reg_date;
	}
	public String getIns_user_nm() {
		return ins_user_nm;
	}
	public void setIns_user_nm(String ins_user_nm) {
		this.ins_user_nm = ins_user_nm;
	}
	public String getUdt_user_nm() {
		return udt_user_nm;
	}
	public void setUdt_user_nm(String udt_user_nm) {
		this.udt_user_nm = udt_user_nm;
	}
	public String getFolder_count() {
		return folder_count;
	}
	public void setFolder_count(String folder_count) {
		this.folder_count = folder_count;
	}
	public String getMax_login_cnt() {
		return Max_login_cnt;
	}
	public void setMax_login_cnt(String max_login_cnt) {
		Max_login_cnt = max_login_cnt;
	}
	public String getDisconnect_cnt() {
		return disconnect_cnt;
	}
	public void setDisconnect_cnt(String disconnect_cnt) {
		this.disconnect_cnt = disconnect_cnt;
	}
	public String getMax_login_date() {
		return Max_login_date;
	}
	public void setMax_login_date(String max_login_date) {
		Max_login_date = max_login_date;
	}
	public String getAlarm_standard() {
		return alarm_standard;
	}
	public void setAlarm_standard(String alarm_standard) {
		this.alarm_standard = alarm_standard;
	}
	public String getAlarm_min() {
		return alarm_min;
	}
	public void setAlarm_min(String alarm_min) {
		this.alarm_min = alarm_min;
	}
	public String getAlarm_max() {
		return alarm_max;
	}
	public void setAlarm_max(String alarm_max) {
		this.alarm_max = alarm_max;
	}
	public String getAlarm_unit() {
		return alarm_unit;
	}
	public void setAlarm_unit(String alarm_unit) {
		this.alarm_unit = alarm_unit;
	}
	public String getAlarm_time() {
		return alarm_time;
	}
	public void setAlarm_time(String alarm_time) {
		this.alarm_time = alarm_time;
	}
	public String getAlarm_over() {
		return alarm_over;
	}
	public void setAlarm_over(String alarm_over) {
		this.alarm_over = alarm_over;
	}
	public String getAlarm_over_time() {
		return alarm_over_time;
	}
	public void setAlarm_over_time(String alarm_over_time) {
		this.alarm_over_time = alarm_over_time;
	}
	public String getAlarm_seq() {
		return alarm_seq;
	}
	public void setAlarm_seq(String alarm_seq) {
		this.alarm_seq = alarm_seq;
	}
}
