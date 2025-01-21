package com.ghayoun.ezjobs.comm.domain;

import java.io.Serializable;

import com.ghayoun.ezjobs.common.util.CommonUtil;

@SuppressWarnings("serial")
public class CommonBean implements Serializable {
	
	private int total_count 			= 0;	
	private int row_num 				= 0;
	
	private String table_id 			= "";
	private String job_id 				= "";
	
	private String odate 				= "";
	private String view_odate 			= "";
	
	private String categoryCode 		= "";
	private String categoryName 		= "";
	
	private String data_center_code 	= "";
	private String data_center 			= "";
	private String data_center_name 	= "";
	private String active_net_name 		= "";
	
	private String application 			= "";
	private String group_name 			= "";
	
	private String sched_table 			= "";
	private String application_of_def 	= "";
	private String group_name_of_def 	= "";
	
	private String calendar 			= "";
	private String node_id 				= "";
	private String node_nm 				= "";
	private String job_name 			= "";
	private String mem_name 			= "";
	private String description 			= "";
	
	private String user_daily 			= "";
	private String user_daily_system_gb = "";
	
	private String unixid 				= "";
	private String author_nm 			= "";
	private String team 				= "";
	
	private String days_1 				= "";
	private String days_2 				= "";
	
	private String table_gb 			= "";
	private String system_gb 			= "";
	private String work_gb 				= "";
	private String server_gb 			= "";
	private String file_path  			= "";
	
	private String agent_id 			= "";
	private String agent_pw 			= "";
	
	private String mcode_cd 			= "";
	private String mcode_nm   			= "";
	private String scode_cd    			= "";
	private String scode_nm    			= "";
	private String order_no    			= "";
	private String ins_date    			= "";
	
	private String ajax_return 			= "";
	private String ajax_value 			= "";
	
	private String confirm_ins_sdate 	= "";
	private String confirm_ins_edate 	= "";
	
	private String parent_table	 		= "";
	private String sub_table	 		= "";
	private String smart_table_order_id	= "";
	private String table_type			= "";
	private String order_id				= "";
	private String order_table			= "";
	private String task_type			= "";
	private String group_no				= "";
	private String hailaki				= "";
	private String check_box_yn			= "";
	private String rba					= "";
	private String grp_rba				= "";
	
	//호스트관리
	private String access_gubun			= "";
	private String access_port			= "";
	private String host_cd				= "";
	private String server_gubun			= "";
	private String server_lang			= "";
	
	private String ctm_odate			= "";
	
	private String team_cd				= "";
	private String team_nm				= "";
	
	private String mcode_desc 			= "";
	private String mcode_sub_cd			= "";
	private String scode_eng_nm 		= "";
	private String scode_desc 			= "";
	private String scode_use_yn 		= "";
	private String host_nm	 			= "";
	
	
	private String	cal_nm				= "";
	private String  days_cal			= "";
	private String	days_and_or			= "";
	private String	weeks_cal			= "";
	private String	conf_cal_m			= "";
	private String	conf_cal_d			= "";
	private String	month_cal			= "";
	private String	month_days			= "";
	private String	week_days			= "";
	private String	shift				= "";
	private String	shift_num			= "";
	private String	conf_cal 			= "";	
	private String	user_cd 			= "";
	private String	user_id 			= "";	
	private String	dates_str 			= "";	
	private String days_cnt				= "";
	private String statis 				= "";
	
	private String logdate 				= "";
	private String logtime 				= "";
	private String jobname 				= "";
	private String orderno 				= "";
	private String subsys 				= "";
	private String msgid 				= "";
	private String message 				= "";
	private String keystmp 				= "";
	private String nodeid 				= "";
	
	private String line_cd 				= "";
	private String line_grp_cd 			= "";
	private String approval_cd 			= "";
	private String approval_seq 		= "";
	private String use_yn 				= "";
	private String ins_user_cd 			= "";
	private String line_grp_nm 			= "";
	private String owner_user_cd		= "";
	private String approval_nm 			= "";
	private String owner_user_nm 		= "";
	private String duty_nm 				= "";
	private String dept_nm 				= "";
	private String approval_gb 			= "";
	
	private String agstat 				= "";
	private String hostname 			= "";
	private String version 				= "";
	private String os_name 				= "";
	private String platform 			= "";
	private String last_upd 			= "";
	private String agent_nm 			= "";
	private String agent_info 			= "";
	private String del_yn 				= "";
	private String agent 				= "";
	private String arr_host_cd 			= "";
	private String arr_host_nm 			= "";
	private String arg_eng_nm 			= "";
	private String arg_value 			= "";
	private String arg_date 			= "";
	
	private String send_cd        		= "";
	private String send_gubun     		= "";
	private String send_gubun_nm   		= "";
	private String send_date      		= "";
	private String return_code   		= "";
	private String return_number  		= "";
	private String return_date    		= "";
	private String user_nm		  		= "";
	private String user_tel		  		= "";
	private String user_hp		  		= "";
	private String user_email	  		= "";
	private String send_info	  		= "";
	
	
	private String admin_line_cd		= "";
	private String admin_line_grp_cd	= "";
	private String admin_line_grp_nm	= "";
	private String approval_type		= "";
	private String doc_gubun			= "";
	private String group_line_cd		= "";
	private String group_line_grp_cd	= "";
	private String group_line_grp_nm	= "";
	private String top_level_yn			= "";	//상위레벨	YN, 정기작업YN, 후결YN 추가(2010.05.12, 김수정)
	private String schedule_yn			= "";
	private String post_approval_yn		= "";
	
	
	private String user_cd_1            = "";
	private String user_id_1            = "";
	private String user_nm_1            = "";
	private String duty_nm_1            = "";
	private String dept_nm_1            = "";
	private String user_tel_1           = "";
	private String user_hp_1            = "";
	private String user_email_1         = "";
	private String sms_1                = "";
	private String mail_1               = "";

	private String user_cd_2            = "";
	private String user_id_2            = "";
	private String user_nm_2            = "";
	private String duty_nm_2            = "";
	private String dept_nm_2            = "";
	private String user_tel_2           = "";
	private String user_hp_2            = "";
	private String user_email_2         = "";
	private String sms_2                = "";
	private String mail_2               = "";

	private String user_cd_3            = "";
	private String user_id_3            = "";
	private String user_nm_3            = "";
	private String duty_nm_3            = "";
	private String dept_nm_3            = "";
	private String user_tel_3           = "";
	private String user_hp_3            = "";
	private String user_email_3         = "";
	private String sms_3                = "";
	private String mail_3               = "";

	private String user_cd_4            = "";
	private String user_id_4            = "";
	private String user_nm_4            = "";
	private String duty_nm_4            = "";
	private String dept_nm_4            = "";
	private String user_tel_4           = "";
	private String user_hp_4            = "";
	private String user_email_4         = "";
	private String sms_4                = "";
	private String mail_4               = "";

	private String user_cd_5            = "";
	private String user_id_5            = "";
	private String user_nm_5            = "";
	private String duty_nm_5            = "";
	private String dept_nm_5            = "";
	private String user_tel_5           = "";
	private String user_hp_5            = "";
	private String user_email_5         = "";
	private String sms_5                = "";
	private String mail_5               = "";

	private String user_cd_6            = "";
	private String user_id_6            = "";
	private String user_nm_6            = "";
	private String duty_nm_6            = "";
	private String dept_nm_6            = "";
	private String user_tel_6           = "";
	private String user_hp_6            = "";
	private String user_email_6         = "";
	private String sms_6                = "";
	private String mail_6               = "";

	private String user_cd_7            = "";
	private String user_id_7            = "";
	private String user_nm_7            = "";
	private String duty_nm_7            = "";
	private String dept_nm_7            = "";
	private String user_tel_7           = "";
	private String user_hp_7            = "";
	private String user_email_7         = "";
	private String sms_7                = "";
	private String mail_7               = "";

	private String user_cd_8            = "";
	private String user_id_8            = "";
	private String user_nm_8            = "";
	private String duty_nm_8            = "";
	private String dept_nm_8            = "";
	private String user_tel_8           = "";
	private String user_hp_8            = "";
	private String user_email_8         = "";
	private String sms_8                = "";
	private String mail_8               = "";

	private String user_cd_9            = "";
	private String user_id_9            = "";
	private String user_nm_9            = "";
	private String duty_nm_9            = "";
	private String dept_nm_9            = "";
	private String user_tel_9           = "";
	private String user_hp_9            = "";
	private String user_email_9         = "";
	private String sms_9                = "";
	private String mail_9               = "";

	private String user_cd_10            = "";
	private String user_id_10            = "";
	private String user_nm_10            = "";
	private String duty_nm_10            = "";
	private String dept_nm_10            = "";
	private String user_tel_10           = "";
	private String user_hp_10            = "";
	private String user_email_10         = "";
	private String sms_10                = "";
	private String mail_10               = "";

	private String grp_cd_1          	 = "";
	private String grp_nm_1          	 = "";
	private String grp_sms_1         	 = "";
	private String grp_mail_1        	 = "";

	private String grp_cd_2          	 = "";
	private String grp_nm_2          	 = "";
	private String grp_sms_2         	 = "";
	private String grp_mail_2        	 = "";

	private String sreq_code           	= "";
	private String sreq_title           = "";
	private String pm_nm               	= "";
	private String sreq_planmh          = "";
	private String sreq_resmh           = "";
	
	private String total_cnt           	= "";
	private String ok_cnt	           	= "";
	private String not_ok_cnt	      	= "";
	private String wait_cnt	           	= "";
	private String late_cnt	           	= "";
	private String running_cnt        	= "";
	private String delete_cnt        	= "";
	
	private String not_save	           	= "";
	private String doc_save	           	= "";
	private String approval_ing	     	= "";
	private String approval_ok	      	= "";
	private String approval_cancel     	= "";	
	private String apply_ok	           	= "";
	
	private String doc_gb	           	= "";
	private String draft_date	     	= "";
	
	private String work_cd	     		= "";
	private String work_date	     	= "";
	private String content	     		= "";	
	
	private String grpname	     		= "";
	
	private String approval_cnt1		= "";
	private String approval_cnt2		= "";
	private String approval_cnt3		= "";
	
	private String approval_cnt4		= "";
	private String approval_cnt5		= "";
	
	private String approval_user_id		= "";
	private String approval_user_nm		= "";
	private String approval_user_cd		= "";
	private String holiday_check 		= "";

	//smartforder
	private String jobs_in_group		= "";
	private String used_by				= "";
	private String sync_state			= "";
	private String sync_msg				= "";
	private String last_upload			= "";
	private String doc_cd				= "";
	
	private String late_sub_cnt			= "";
	private String late_time_cnt		= "";
	private String late_exec_cnt		= "";
	
	private String error_description	= "";
	private String jobschedgb			= "";
	
	private String dlNm					= "";
	private String email				= "";
	private String dlCd					= "";
	private String folder_auth			= "";
	
	//quartzList
	private String quartz_name			= "";
	private String trace_log_path		= "";
	private String status_cd			= "";
	private String status_log			= "";
	private String before_pw    		= "";
	
	private String tab_nm				= "";
	private String app_nm				= "";
	private String grp_nm				= "";
	private String table_nm				= "";
	
	private String group_user_group_cd	= "";
	private String group_user_group_nm	= "";
	
	private String group_user_line_cd 	= "";
	
	private String group_approval_user_cd 	= "";
	private String group_approval_user_id 	= "";
	private String group_approval_user_nm 	= "";
	private String group_approval_duty_nm 	= "";
	private String group_approval_dept_nm 	= "";
	
	private String folder_count 	= "";
	
	private String group_member_cnt 	= "";
	
	private String approval_yn 	= "";
	private String notice_yn 	= "";

	private String apply_wait	= "";
	private String apply_cancel = "";
	private String apply_fail = "";
	private String approval_total_cnt = "";
	private String apply_total_cnt = "";
	private String doc_group_id	= "";
	private String grp_eng_nm = "";

	//오라클용
	private String ctm_daily_time = "";
	private String check_time = "";

	private String from_hostTime = "";
	private String from_odate    = "";

	private String approval_user_hp = "";
	private String title = "";
	
	private String qresname 		= "";
	private String qrtotal 			= "";
	private String qrused 			= "";
	private String ins_date_hh		= "";
	
	private String task_nm_detail = "";

	private String rerun_counter	= "";
	private String avg_run			= "";
	private String send_user_cd		= "";
	private String send_user_cd2	= "";
	private String send_user_cd3	= "";
	private String send_user_cd4	= "";
	private String send_user_cd5	= "";
	private String send_user_cd6	= "";
	private String send_user_cd7	= "";
	private String send_user_cd8	= "";
	private String send_user_cd9	= "";
	private String send_user_cd10	= "";
	private String send_user_hp		= "";
	private String send_user_hp2	= "";
	private String send_user_hp3	= "";
	private String send_user_hp4	= "";
	private String send_user_hp5	= "";
	private String send_user_hp6	= "";
	private String send_user_hp7	= "";
	private String send_user_hp8	= "";
	private String send_user_hp9	= "";
	private String send_user_hp10	= "";
	private String send_sms			= "";
	private String send_sms2		= "";
	private String send_sms3		= "";
	private String send_sms4		= "";
	private String send_sms5		= "";
	private String send_sms6		= "";
	private String send_sms7		= "";
	private String send_sms8		= "";
	private String send_sms9		= "";
	private String send_sms10		= "";
	private String alarm_gubun		= "";
	private String s_start_time		= "";
	private String s_end_time		= "";
	private String start_time       = "";
	private String send_desc		= "";
	private String apply_date		= "";
	private String certify_gubun	= "";
	private String var_name			= "";
	private String var_value		= "";
	private String send_description	= "";
	
	private String absence_user_cd	  = "";
	private String absence_user_id	  = "";
	private String absence_user_nm	  = "";
	private String absence_user_ip	  = "";
	private String absence_user_hp	  = "";
	private String absence_start_date = "";
	private String absence_end_date   = "";
	private String absence_user_mail  = "";
	private String absence_reason	  = "";
	
	//cmr_nodes
	private String nodetype			= "";
	private String permhosts		= "";
	private String owner			= "";
	
	private String total_ajob_cnt	= "";
	private String matched_cnt		= "";
	
	// DB
	private String database_cd		= "";
	private String profile_name		= "";
	private String database_type	= "";
	private String database_version	= "";
	private String type				= "";
	private String database_name	= "";
	private String database_pw		= "";
	private String access_sid		= "";
	private String access_service_name		= "";
	private String year				= "";
		
	public String getSend_desc() { return send_desc; }
	public void setSend_desc(String send_desc) { this.send_desc = send_desc; }
	public String getTask_nm_detail() { return task_nm_detail; }
	public void setTask_nm_detail(String task_nm_detail) { this.task_nm_detail = task_nm_detail; }
	public String getTitle() { return title; }
	public void setTitle(String title) { this.title = title; }
	public String getApproval_user_hp() { return approval_user_hp; }
	public void setApproval_user_hp(String approval_user_hp) { this.approval_user_hp = approval_user_hp; }
	public String getFrom_hostTime() { return from_hostTime; }
	public void setFrom_hostTime(String from_hostTime) { this.from_hostTime = from_hostTime; }
	public String getFrom_odate() { return from_odate; }
	public void setFrom_odate(String from_odate) { this.from_odate = from_odate; }
	public String getDoc_group_id() { return doc_group_id; }
	public void setDoc_group_id(String doc_group_id) { this.doc_group_id = doc_group_id; }
	public String getApply_total_cnt() { return apply_total_cnt;}
	public void setApply_total_cnt(String apply_total_cnt) {		this.apply_total_cnt = apply_total_cnt;}
	public String getApproval_total_cnt() { return approval_total_cnt;}
	public void setApproval_total_cnt(String approval_total_cnt) {		this.approval_total_cnt = approval_total_cnt;}
	public String getApply_fail() { return apply_fail; }
	public void setApply_fail(String apply_fail) { this.apply_fail = apply_fail; }
	public String getApply_cancel() {  return apply_cancel; }
	public void setApply_cancel(String apply_cancel) { this.apply_cancel = apply_cancel; }
	public String getApply_wait() { return apply_wait; }
	public void setApply_wait(String apply_wait) { this.apply_wait = apply_wait; }
	public String getApproval_user_cd() { return approval_user_cd; }
	public void setApproval_user_cd(String approval_user_cd) { this.approval_user_cd = approval_user_cd; }
	public String getServer_lang() {
		return server_lang;
	}
	public void setServer_lang(String server_lang) {
		this.server_lang = server_lang;
	}
	public String getTab_nm() {
		return tab_nm;
	}
	public void setTab_nm(String tab_nm) {
		this.tab_nm = tab_nm;
	}
	public String getApp_nm() {
		return app_nm;
	}
	public void setApp_nm(String app_nm) {
		this.app_nm = app_nm;
	}
	public String getGrp_nm() {
		return grp_nm;
	}
	public void setGrp_nm(String grp_nm) {
		this.grp_nm = grp_nm;
	}
	public String getTable_nm() {
		return table_nm;
	}
	public void setTable_nm(String table_nm) {
		this.table_nm = table_nm;
	}
	public String getJobs_in_group() {
		return jobs_in_group;
	}
	public void setJobs_in_group(String jobs_in_group) {
		this.jobs_in_group = jobs_in_group;
	}
	public String getUsed_by() {
		return used_by;
	}
	public void setUsed_by(String used_by) {
		this.used_by = used_by;
	}
	public String getSync_state() {
		return sync_state;
	}
	public void setSync_state(String sync_state) {
		this.sync_state = sync_state;
	}
	public String getSync_msg() {
		return sync_msg;
	}
	public void setSync_msg(String sync_msg) {
		this.sync_msg = sync_msg;
	}
	public String getLast_upload() {
		return last_upload;
	}
	public void setLast_upload(String last_upload) {
		this.last_upload = last_upload;
	}
	public String getDoc_cd() {
		return doc_cd;
	}
	public void setDoc_cd(String doc_cd) {
		this.doc_cd = doc_cd;
	}

	
	public String getHoliday_check() {
		return holiday_check;
	}

	public void setHoliday_check(String holiday_check) {
		this.holiday_check = holiday_check;
	}

	public String getUser_nm_1() {
		return user_nm_1;
	}

	public void setUser_nm_1(String user_nm_1) {
		this.user_nm_1 = user_nm_1;
	}

	public String getUser_nm_2() {
		return user_nm_2;
	}

	public void setUser_nm_2(String user_nm_2) {
		this.user_nm_2 = user_nm_2;
	}

	public String getUser_nm_3() {
		return user_nm_3;
	}

	public void setUser_nm_3(String user_nm_3) {
		this.user_nm_3 = user_nm_3;
	}

	public String getUser_nm_4() {
		return user_nm_4;
	}

	public void setUser_nm_4(String user_nm_4) {
		this.user_nm_4 = user_nm_4;
	}

	public String getUser_cd_1() {
		return user_cd_1;
	}

	public void setUser_cd_1(String user_cd_1) {
		this.user_cd_1 = user_cd_1;
	}

	public String getUser_id_1() {
		return user_id_1;
	}

	public void setUser_id_1(String user_id_1) {
		this.user_id_1 = user_id_1;
	}

	public String getDuty_nm_1() {
		return duty_nm_1;
	}

	public void setDuty_nm_1(String duty_nm_1) {
		this.duty_nm_1 = duty_nm_1;
	}

	public String getDept_nm_1() {
		return dept_nm_1;
	}

	public void setDept_nm_1(String dept_nm_1) {
		this.dept_nm_1 = dept_nm_1;
	}

	public String getUser_tel_1() {
		return user_tel_1;
	}

	public void setUser_tel_1(String user_tel_1) {
		this.user_tel_1 = user_tel_1;
	}

	public String getUser_hp_1() {
		return user_hp_1;
	}

	public void setUser_hp_1(String user_hp_1) {
		this.user_hp_1 = user_hp_1;
	}

	public String getUser_email_1() {
		return user_email_1;
	}

	public void setUser_email_1(String user_email_1) {
		this.user_email_1 = user_email_1;
	}

	public String getSms_1() {
		return sms_1;
	}

	public void setSms_1(String sms_1) {
		this.sms_1 = sms_1;
	}

	public String getMail_1() {
		return mail_1;
	}

	public void setMail_1(String mail_1) {
		this.mail_1 = mail_1;
	}

	public String getUser_cd_2() {
		return user_cd_2;
	}

	public void setUser_cd_2(String user_cd_2) {
		this.user_cd_2 = user_cd_2;
	}

	public String getUser_id_2() {
		return user_id_2;
	}

	public void setUser_id_2(String user_id_2) {
		this.user_id_2 = user_id_2;
	}

	public String getDuty_nm_2() {
		return duty_nm_2;
	}

	public void setDuty_nm_2(String duty_nm_2) {
		this.duty_nm_2 = duty_nm_2;
	}

	public String getDept_nm_2() {
		return dept_nm_2;
	}

	public void setDept_nm_2(String dept_nm_2) {
		this.dept_nm_2 = dept_nm_2;
	}

	public String getUser_tel_2() {
		return user_tel_2;
	}

	public void setUser_tel_2(String user_tel_2) {
		this.user_tel_2 = user_tel_2;
	}

	public String getUser_hp_2() {
		return user_hp_2;
	}

	public void setUser_hp_2(String user_hp_2) {
		this.user_hp_2 = user_hp_2;
	}

	public String getUser_email_2() {
		return user_email_2;
	}

	public void setUser_email_2(String user_email_2) {
		this.user_email_2 = user_email_2;
	}

	public String getSms_2() {
		return sms_2;
	}

	public void setSms_2(String sms_2) {
		this.sms_2 = sms_2;
	}

	public String getMail_2() {
		return mail_2;
	}

	public void setMail_2(String mail_2) {
		this.mail_2 = mail_2;
	}

	public String getUser_cd_3() {
		return user_cd_3;
	}

	public void setUser_cd_3(String user_cd_3) {
		this.user_cd_3 = user_cd_3;
	}

	public String getUser_id_3() {
		return user_id_3;
	}

	public void setUser_id_3(String user_id_3) {
		this.user_id_3 = user_id_3;
	}

	public String getDuty_nm_3() {
		return duty_nm_3;
	}

	public void setDuty_nm_3(String duty_nm_3) {
		this.duty_nm_3 = duty_nm_3;
	}

	public String getDept_nm_3() {
		return dept_nm_3;
	}

	public void setDept_nm_3(String dept_nm_3) {
		this.dept_nm_3 = dept_nm_3;
	}

	public String getUser_tel_3() {
		return user_tel_3;
	}

	public void setUser_tel_3(String user_tel_3) {
		this.user_tel_3 = user_tel_3;
	}

	public String getUser_hp_3() {
		return user_hp_3;
	}

	public void setUser_hp_3(String user_hp_3) {
		this.user_hp_3 = user_hp_3;
	}

	public String getUser_email_3() {
		return user_email_3;
	}

	public void setUser_email_3(String user_email_3) {
		this.user_email_3 = user_email_3;
	}

	public String getSms_3() {
		return sms_3;
	}

	public void setSms_3(String sms_3) {
		this.sms_3 = sms_3;
	}

	public String getMail_3() {
		return mail_3;
	}

	public void setMail_3(String mail_3) {
		this.mail_3 = mail_3;
	}

	public String getUser_cd_4() {
		return user_cd_4;
	}

	public void setUser_cd_4(String user_cd_4) {
		this.user_cd_4 = user_cd_4;
	}

	public String getUser_id_4() {
		return user_id_4;
	}

	public void setUser_id_4(String user_id_4) {
		this.user_id_4 = user_id_4;
	}

	public String getDuty_nm_4() {
		return duty_nm_4;
	}

	public void setDuty_nm_4(String duty_nm_4) {
		this.duty_nm_4 = duty_nm_4;
	}

	public String getDept_nm_4() {
		return dept_nm_4;
	}

	public void setDept_nm_4(String dept_nm_4) {
		this.dept_nm_4 = dept_nm_4;
	}

	public String getUser_tel_4() {
		return user_tel_4;
	}

	public void setUser_tel_4(String user_tel_4) {
		this.user_tel_4 = user_tel_4;
	}

	public String getUser_hp_4() {
		return user_hp_4;
	}

	public void setUser_hp_4(String user_hp_4) {
		this.user_hp_4 = user_hp_4;
	}

	public String getUser_email_4() {
		return user_email_4;
	}

	public void setUser_email_4(String user_email_4) {
		this.user_email_4 = user_email_4;
	}

	public String getSms_4() {
		return sms_4;
	}

	public void setSms_4(String sms_4) {
		this.sms_4 = sms_4;
	}

	public String getMail_4() {
		return mail_4;
	}

	public void setMail_4(String mail_4) {
		this.mail_4 = mail_4;
	}

	public String getUser_tel() {
		return user_tel;
	}

	public void setUser_tel(String user_tel) {
		this.user_tel = user_tel;
	}

	public String getUser_hp() {
		return user_hp;
	}

	public void setUser_hp(String user_hp) {
		this.user_hp = user_hp;
	}

	public String getUser_email() {
		return user_email;
	}

	public void setUser_email(String user_email) {
		this.user_email = user_email;
	}

	public String getSend_gubun_nm() {
		return send_gubun_nm;
	}

	public void setSend_gubun_nm(String send_gubun_nm) {
		this.send_gubun_nm = send_gubun_nm;
	}

	public String getUser_nm() {
		return user_nm;
	}

	public void setUser_nm(String user_nm) {
		this.user_nm = user_nm;
	}

	public String getSend_cd() {
		return send_cd;
	}

	public void setSend_cd(String send_cd) {
		this.send_cd = send_cd;
	}

	public String getSend_gubun() {
		return send_gubun;
	}

	public void setSend_gubun(String send_gubun) {
		this.send_gubun = send_gubun;
	}

	public String getSend_date() {
		return send_date;
	}

	public void setSend_date(String send_date) {
		this.send_date = send_date;
	}

	public String getReturn_code() {
		return return_code;
	}

	public void setReturn_code(String return_code) {
		this.return_code = return_code;
	}

	public String getReturn_number() {
		return return_number;
	}

	public void setReturn_number(String return_number) {
		this.return_number = return_number;
	}

	public String getReturn_date() {
		return return_date;
	}

	public void setReturn_date(String return_date) {
		this.return_date = return_date;
	}

	public String getDays_cnt() {
		return days_cnt;
	}

	public void setDays_cnt(String days_cnt) {
		this.days_cnt = days_cnt;
	}

	public String getOdate() {
		return odate;
	}

	public String getHost_nm() {
		return host_nm;
	}

	public void setHost_nm(String host_nm) {
		this.host_nm = host_nm;
	}

	public void setOdate(String odate) {
		this.odate = odate;
	}

	public String getCategoryCode() {
		return categoryCode;
	}

	public void setCategoryCode(String categoryCode) {
		this.categoryCode = categoryCode;
	}

	public String getCategoryName() {
		return categoryName;
	}

	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}

	public String getData_center() {
		return data_center;
	}

	public void setData_center(String data_center) {
		this.data_center = data_center;
	}

	public String getActive_net_name() {
		return active_net_name;
	}

	public void setActive_net_name(String active_net_name) {
		this.active_net_name = active_net_name;
	}

	public int getTotal_count() {
		return total_count;
	}

	public void setTotal_count(int total_count) {
		this.total_count = total_count;
	}

	public String getData_center_code() {
		return data_center_code;
	}

	public void setData_center_code(String data_center_code) {
		this.data_center_code = data_center_code;
	}

	public String getApplication() {
		return application;
	}

	public void setApplication(String application) {
		this.application = application;
	}

	public String getGroup_name() {
		return group_name;
	}

	public void setGroup_name(String group_name) {
		this.group_name = group_name;
	}

	public String getSched_table() {
		return sched_table;
	}

	public void setSched_table(String sched_table) {
		this.sched_table = sched_table;
	}

	public String getApplication_of_def() {
		return application_of_def;
	}

	public void setApplication_of_def(String application_of_def) {
		this.application_of_def = application_of_def;
	}

	public String getGroup_name_of_def() {
		return group_name_of_def;
	}

	public void setGroup_name_of_def(String group_name_of_def) {
		this.group_name_of_def = group_name_of_def;
	}

	public String getCalendar() {
		return calendar;
	}

	public void setCalendar(String calendar) {
		this.calendar = calendar;
	}

	public String getNode_id() {
		return node_id;
	}

	public void setNode_id(String node_id) {
		this.node_id = node_id;
	}

	public String getJob_name() {
		return job_name;
	}

	public void setJob_name(String job_name) {
		this.job_name = job_name;
	}

	public String getUser_daily() {
		return user_daily;
	}

	public void setUser_daily(String user_daily) {
		this.user_daily = user_daily;
	}

	public String getDays_1() {
		return days_1;
	}

	public void setDays_1(String days_1) {
		this.days_1 = days_1;
	}

	public String getDays_2() {
		return days_2;
	}

	public void setDays_2(String days_2) {
		this.days_2 = days_2;
	}

	public String getSystem_gb() {
		return system_gb;
	}

	public void setSystem_gb(String system_gb) {
		this.system_gb = system_gb;
	}

	public String getServer_gb() {
		return server_gb;
	}

	public void setServer_gb(String server_gb) {
		this.server_gb = server_gb;
	}

	public String getFile_path() {
		return file_path;
	}

	public void setFile_path(String file_path) {
		this.file_path = file_path;
	}

	public int getRow_num() {
		return row_num;
	}

	public void setRow_num(int row_num) {
		this.row_num = row_num;
	}

	public String getNode_nm() {
		return node_nm;
	}

	public void setNode_nm(String node_nm) {
		this.node_nm = node_nm;
	}

	public String getTable_id() {
		return table_id;
	}

	public void setTable_id(String table_id) {
		this.table_id = table_id;
	}

	public String getJob_id() {
		return job_id;
	}

	public void setJob_id(String job_id) {
		this.job_id = job_id;
	}

	public String getMem_name() {
		return mem_name;
	}

	public void setMem_name(String mem_name) {
		this.mem_name = mem_name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getUser_daily_system_gb() {
		return user_daily_system_gb;
	}

	public void setUser_daily_system_gb(String user_daily_system_gb) {
		this.user_daily_system_gb = user_daily_system_gb;
	}

	public String getWork_gb() {
		return work_gb;
	}

	public void setWork_gb(String work_gb) {
		this.work_gb = work_gb;
	}

	public String getTable_gb() {
		return table_gb;
	}

	public void setTable_gb(String table_gb) {
		this.table_gb = table_gb;
	}

	public String getView_odate() {
		return view_odate;
	}

	public void setView_odate(String viewOdate) {
		view_odate = viewOdate;
	}

	public String getAgent_id() {
		return agent_id;
	}

	public void setAgent_id(String agentId) {
		agent_id = agentId;
	}

	public String getAgent_pw() {
		return agent_pw;
	}

	public void setAgent_pw(String agentPw) {
		agent_pw = agentPw;
	}

	public String getMcode_cd() {
		return mcode_cd;
	}

	public void setMcode_cd(String mcodeCd) {
		mcode_cd = mcodeCd;
	}

	public String getMcode_nm() {
		return mcode_nm;
	}

	public void setMcode_nm(String mcodeNm) {
		mcode_nm = mcodeNm;
	}

	public String getScode_cd() {
		return scode_cd;
	}

	public void setScode_cd(String scodeCd) {
		scode_cd = scodeCd;
	}

	public String getScode_nm() {
		return scode_nm;
	}

	public void setScode_nm(String scodeNm) {
		scode_nm = scodeNm;
	}

	public String getOrder_no() {
		return order_no;
	}

	public void setOrder_no(String orderNo) {
		order_no = orderNo;
	}

	public String getIns_date() {
		return ins_date;
	}

	public void setIns_date(String insDate) {
		ins_date = insDate;
	}

	public String getAjax_return() {
		return ajax_return;
	}

	public void setAjax_return(String ajaxReturn) {
		ajax_return = ajaxReturn;
	}

	public String getData_center_name() {
		return data_center_name;
	}

	public void setData_center_name(String dataCenterName) {
		data_center_name = dataCenterName;
	}

	public String getConfirm_ins_sdate() {
		return confirm_ins_sdate;
	}

	public void setConfirm_ins_sdate(String confirmInsSdate) {
		confirm_ins_sdate = confirmInsSdate;
	}

	public String getConfirm_ins_edate() {
		return confirm_ins_edate;
	}

	public void setConfirm_ins_edate(String confirmInsEdate) {
		confirm_ins_edate = confirmInsEdate;
	}

	public String getAjax_value() {
		return ajax_value;
	}

	public void setAjax_value(String ajaxValue) {
		ajax_value = ajaxValue;
	}

	public String getParent_table() {
		return parent_table;
	}

	public void setParent_table(String parentTable) {
		parent_table = parentTable;
	}

	public String getSub_table() {
		return sub_table;
	}

	public void setSub_table(String subTable) {
		sub_table = subTable;
	}

	public String getSmart_table_order_id() {
		return smart_table_order_id;
	}

	public void setSmart_table_order_id(String smartTableOrderId) {
		smart_table_order_id = smartTableOrderId;
	}

	public String getTable_type() {
		return table_type;
	}

	public void setTable_type(String tableType) {
		table_type = tableType;
	}

	public String getOrder_id() {
		return order_id;
	}

	public void setOrder_id(String orderId) {
		order_id = orderId;
	}

	public String getOrder_table() {
		return order_table;
	}

	public void setOrder_table(String orderTable) {
		order_table = orderTable;
	}

	public String getAccess_gubun() {
		return access_gubun;
	}

	public void setAccess_gubun(String accessGubun) {
		access_gubun = accessGubun;
	}

	public String getAccess_port() {
		return access_port;
	}

	public void setAccess_port(String accessPort) {
		access_port = accessPort;
	}

	public String getHost_cd() {
		return host_cd;
	}

	public void setHost_cd(String hostCd) {
		host_cd = hostCd;
	}

	public String getServer_gubun() {
		return server_gubun;
	}

	public void setServer_gubun(String serverGubun) {
		server_gubun = serverGubun;
	}

	public String getUnixid() {
		return unixid;
	}

	public void setUnixid(String unixid) {
		this.unixid = unixid;
	}

	public String getAuthor_nm() {
		return author_nm;
	}

	public void setAuthor_nm(String authorNm) {
		author_nm = authorNm;
	}

	public String getTeam() {
		return team;
	}

	public void setTeam(String team) {
		this.team = team;
	}

	public String getCtm_odate() {
		return ctm_odate;
	}

	public void setCtm_odate(String ctmOdate) {
		ctm_odate = ctmOdate;
	}

	public String getTeam_cd() {
		return team_cd;
	}

	public void setTeam_cd(String team_cd) {
		this.team_cd = team_cd;
	}

	public String getTeam_nm() {
		return team_nm;
	}

	public void setTeam_nm(String team_nm) {
		this.team_nm = team_nm;
	}

	public String getMcode_desc() {
		return mcode_desc;
	}

	public void setMcode_desc(String mcode_desc) {
		this.mcode_desc = mcode_desc;
	}

	public String getMcode_sub_cd() {
		return mcode_sub_cd;
	}

	public void setMcode_sub_cd(String mcode_sub_cd) {
		this.mcode_sub_cd = mcode_sub_cd;
	}

	public String getScode_eng_nm() {
		return scode_eng_nm;
	}

	public void setScode_eng_nm(String scode_eng_nm) {
		this.scode_eng_nm = scode_eng_nm;
	}

	public String getScode_desc() {
		return scode_desc;
	}

	public void setScode_desc(String scode_desc) {
		this.scode_desc = scode_desc;
	}

	public String getScode_use_yn() {
		return scode_use_yn;
	}

	public void setScode_use_yn(String scode_use_yn) {
		this.scode_use_yn = scode_use_yn;
	}

	public String getCal_nm() {
		return cal_nm;
	}

	public void setCal_nm(String cal_nm) {
		this.cal_nm = cal_nm;
	}

	public String getDays_cal() {
		return days_cal;
	}

	public void setDays_cal(String days_cal) {
		this.days_cal = days_cal;
	}

	public String getDays_and_or() {
		return days_and_or;
	}

	public void setDays_and_or(String days_and_or) {
		this.days_and_or = days_and_or;
	}

	public String getWeeks_cal() {
		return weeks_cal;
	}

	public void setWeeks_cal(String weeks_cal) {
		this.weeks_cal = weeks_cal;
	}

	public String getConf_cal_m() {
		return conf_cal_m;
	}

	public void setConf_cal_m(String conf_cal_m) {
		this.conf_cal_m = conf_cal_m;
	}

	public String getConf_cal_d() {
		return conf_cal_d;
	}

	public void setConf_cal_d(String conf_cal_d) {
		this.conf_cal_d = conf_cal_d;
	}

	public String getMonth_cal() {
		return month_cal;
	}

	public void setMonth_cal(String month_cal) {
		this.month_cal = month_cal;
	}

	public String getMonth_days() {
		return month_days;
	}

	public void setMonth_days(String month_days) {
		this.month_days = month_days;
	}

	public String getWeek_days() {
		return week_days;
	}

	public void setWeek_days(String week_days) {
		this.week_days = week_days;
	}

	public String getShift() {
		return shift;
	}

	public void setShift(String shift) {
		this.shift = shift;
	}

	public String getShift_num() {
		return shift_num;
	}

	public void setShift_num(String shift_num) {
		this.shift_num = shift_num;
	}

	public String getConf_cal() {
		return conf_cal;
	}

	public void setConf_cal(String conf_cal) {
		this.conf_cal = conf_cal;
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

	public String getDates_str() {
		return dates_str;
	}

	public void setDates_str(String dates_str) {
		this.dates_str = dates_str;
	}

	public String getStatis() {
		return statis;
	}

	public void setStatis(String statis) {
		this.statis = statis;
	}

	public String getLogdate() {
		return logdate;
	}

	public void setLogdate(String logdate) {
		this.logdate = logdate;
	}

	public String getLogtime() {
		return logtime;
	}

	public void setLogtime(String logtime) {
		this.logtime = logtime;
	}

	public String getJobname() {
		return jobname;
	}

	public void setJobname(String jobname) {
		this.jobname = jobname;
	}

	public String getOrderno() {
		return orderno;
	}

	public void setOrderno(String orderno) {
		this.orderno = orderno;
	}

	public String getSubsys() {
		return subsys;
	}

	public void setSubsys(String subsys) {
		this.subsys = subsys;
	}

	public String getMsgid() {
		return msgid;
	}

	public void setMsgid(String msgid) {
		this.msgid = msgid;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public String getKeystmp() {
		return keystmp;
	}

	public void setKeystmp(String keystmp) {
		this.keystmp = keystmp;
	}

	public String getNodeid() {
		return nodeid;
	}

	public void setNodeid(String nodeid) {
		this.nodeid = nodeid;
	}

	public String getLine_cd() {
		return line_cd;
	}

	public void setLine_cd(String line_cd) {
		this.line_cd = line_cd;
	}

	public String getLine_grp_cd() {
		return line_grp_cd;
	}

	public void setLine_grp_cd(String line_grp_cd) {
		this.line_grp_cd = line_grp_cd;
	}

	public String getApproval_cd() {
		return approval_cd;
	}

	public void setApproval_cd(String approval_cd) {
		this.approval_cd = approval_cd;
	}

	public String getApproval_seq() {
		return approval_seq;
	}

	public void setApproval_seq(String approval_seq) {
		this.approval_seq = approval_seq;
	}

	public String getUse_yn() {
		return use_yn;
	}

	public void setUse_yn(String use_yn) {
		this.use_yn = use_yn;
	}

	public String getIns_user_cd() {
		return ins_user_cd;
	}

	public void setIns_user_cd(String ins_user_cd) {
		this.ins_user_cd = ins_user_cd;
	}

	public String getLine_grp_nm() {
		return line_grp_nm;
	}

	public void setLine_grp_nm(String line_grp_nm) {
		this.line_grp_nm = line_grp_nm;
	}

	public String getOwner_user_cd() {
		return owner_user_cd;
	}

	public void setOwner_user_cd(String owner_user_cd) {
		this.owner_user_cd = owner_user_cd;
	}

	public String getApproval_nm() {
		return approval_nm;
	}

	public void setApproval_nm(String approval_nm) {
		this.approval_nm = approval_nm;
	}

	public String getOwner_user_nm() {
		return owner_user_nm;
	}

	public void setOwner_user_nm(String owner_user_nm) {
		this.owner_user_nm = owner_user_nm;
	}

	public String getDuty_nm() {
		return duty_nm;
	}

	public void setDuty_nm(String duty_nm) {
		this.duty_nm = duty_nm;
	}

	public String getDept_nm() {
		return dept_nm;
	}

	public void setDept_nm(String dept_nm) {
		this.dept_nm = dept_nm;
	}

	public String getApproval_gb() {
		return approval_gb;
	}

	public void setApproval_gb(String approval_gb) {
		this.approval_gb = approval_gb;
	}

	public String getAgstat() {
		return agstat;
	}

	public void setAgstat(String agstat) {
		this.agstat = agstat;
	}

	public String getHostname() {
		return hostname;
	}

	public void setHostname(String hostname) {
		this.hostname = hostname;
	}

	public String getVersion() {
		return version;
	}

	public void setVersion(String version) {
		this.version = version;
	}

	public String getOs_name() {
		return os_name;
	}

	public void setOs_name(String os_name) {
		this.os_name = os_name;
	}

	public String getPlatform() {
		return platform;
	}

	public void setPlatform(String platform) {
		this.platform = platform;
	}

	public String getLast_upd() {
		return last_upd;
	}

	public void setLast_upd(String last_upd) {
		this.last_upd = last_upd;
	}

	public String getAgent_nm() {
		return agent_nm;
	}

	public void setAgent_nm(String agent_nm) {
		this.agent_nm = agent_nm;
	}

	public String getAgent_info() {
		return agent_info;
	}

	public void setAgent_info(String agent_info) {
		this.agent_info = agent_info;
	}

	public String getDel_yn() {
		return del_yn;
	}

	public void setDel_yn(String del_yn) {
		this.del_yn = del_yn;
	}

	public String getAgent() {
		return agent;
	}

	public void setAgent(String agent) {
		this.agent = agent;
	}

	public String getArr_host_cd() {
		return arr_host_cd;
	}

	public void setArr_host_cd(String arr_host_cd) {
		this.arr_host_cd = arr_host_cd;
	}

	public String getArr_host_nm() {
		return arr_host_nm;
	}

	public void setArr_host_nm(String arr_host_nm) {
		this.arr_host_nm = arr_host_nm;
	}

	public String getArg_eng_nm() {
		return arg_eng_nm;
	}

	public void setArg_eng_nm(String arg_eng_nm) {
		this.arg_eng_nm = arg_eng_nm;
	}

	public String getArg_value() {
		return arg_value;
	}

	public void setArg_value(String arg_value) {
		this.arg_value = arg_value;
	}

	public String getArg_date() {
		return arg_date;
	}

	public void setArg_date(String arg_date) {
		this.arg_date = arg_date;
	}

	public String getAdmin_line_grp_cd() {
		return admin_line_grp_cd;
	}

	public void setAdmin_line_grp_cd(String admin_line_grp_cd) {
		this.admin_line_grp_cd = admin_line_grp_cd;
	}

	public String getAdmin_line_grp_nm() {
		return admin_line_grp_nm;
	}

	public void setAdmin_line_grp_nm(String admin_line_grp_nm) {
		this.admin_line_grp_nm = admin_line_grp_nm;
	}

	public String getAdmin_line_cd() {
		return admin_line_cd;
	}

	public void setAdmin_line_cd(String admin_line_cd) {
		this.admin_line_cd = admin_line_cd;
	}

	public String getApproval_type() {
		return approval_type;
	}

	public void setApproval_type(String approval_type) {
		this.approval_type = approval_type;
	}

	public String getDoc_gubun() {
		return doc_gubun;
	}

	public void setDoc_gubun(String doc_gubun) {
		this.doc_gubun = doc_gubun;
	}

	public String getGroup_line_cd() {
		return group_line_cd;
	}

	public void setGroup_line_cd(String group_line_cd) {
		this.group_line_cd = group_line_cd;
	}

	public String getGroup_line_grp_cd() {
		return group_line_grp_cd;
	}

	public void setGroup_line_grp_cd(String group_line_grp_cd) {
		this.group_line_grp_cd = group_line_grp_cd;
	}

	public String getGroup_line_grp_nm() {
		return group_line_grp_nm;
	}

	public void setGroup_line_grp_nm(String group_line_grp_nm) {
		this.group_line_grp_nm = group_line_grp_nm;
	}

	public String getSend_info() {
		return send_info;
	}

	public void setSend_info(String send_info) {
		this.send_info = send_info;
	}

	public String getSreq_code() {
		return sreq_code;
	}

	public void setSreq_code(String sreq_code) {
		this.sreq_code = sreq_code;
	}

	public String getSreq_title() {
		return sreq_title;
	}

	public void setSreq_title(String sreq_title) {
		this.sreq_title = sreq_title;
	}

	public String getPm_nm() {
		return pm_nm;
	}

	public void setPm_nm(String pm_nm) {
		this.pm_nm = pm_nm;
	}

	public String getSreq_planmh() {
		return sreq_planmh;
	}

	public void setSreq_planmh(String sreq_planmh) {
		this.sreq_planmh = sreq_planmh;
	}

	public String getSreq_resmh() {
		return sreq_resmh;
	}

	public void setSreq_resmh(String sreq_resmh) {
		this.sreq_resmh = sreq_resmh;
	}

	public String getTotal_cnt() {
		return total_cnt;
	}

	public void setTotal_cnt(String total_cnt) {
		this.total_cnt = total_cnt;
	}

	public String getOk_cnt() {
		return ok_cnt;
	}

	public void setOk_cnt(String ok_cnt) {
		this.ok_cnt = ok_cnt;
	}

	public String getNot_ok_cnt() {
		return not_ok_cnt;
	}

	public void setNot_ok_cnt(String not_ok_cnt) {
		this.not_ok_cnt = not_ok_cnt;
	}

	public String getWait_cnt() {
		return wait_cnt;
	}

	public void setWait_cnt(String wait_cnt) {
		this.wait_cnt = wait_cnt;
	}

	public String getDoc_save() {
		return doc_save;
	}

	public void setDoc_save(String doc_save) {
		this.doc_save = doc_save;
	}

	public String getApproval_ing() {
		return approval_ing;
	}

	public void setApproval_ing(String approval_ing) {
		this.approval_ing = approval_ing;
	}

	public String getApproval_ok() {
		return approval_ok;
	}

	public void setApproval_ok(String approval_ok) {
		this.approval_ok = approval_ok;
	}

	public String getApply_ok() {
		return apply_ok;
	}

	public void setApply_ok(String apply_ok) {
		this.apply_ok = apply_ok;
	}

	public String getApproval_cancel() {
		return approval_cancel;
	}

	public void setApproval_cancel(String approval_cancel) {
		this.approval_cancel = approval_cancel;
	}

	public String getNot_save() {
		return not_save;
	}

	public void setNot_save(String not_save) {
		this.not_save = not_save;
	}

	public String getDoc_gb() {
		return doc_gb;
	}

	public void setDoc_gb(String doc_gb) {
		this.doc_gb = doc_gb;
	}

	public String getDraft_date() {
		return draft_date;
	}

	public void setDraft_date(String draft_date) {
		this.draft_date = draft_date;
	}

	public String getWork_cd() {
		return work_cd;
	}

	public void setWork_cd(String work_cd) {
		this.work_cd = work_cd;
	}

	public String getWork_date() {
		return work_date;
	}

	public void setWork_date(String work_date) {
		this.work_date = work_date;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getLate_cnt() {
		return late_cnt;
	}

	public void setLate_cnt(String late_cnt) {
		this.late_cnt = late_cnt;
	}

	public String getGrpname() {
		return grpname;
	}

	public void setGrpname(String grpname) {
		this.grpname = grpname;
	}

	public String getApproval_cnt1() {
		return approval_cnt1;
	}

	public void setApproval_cnt1(String approval_cnt1) {
		this.approval_cnt1 = approval_cnt1;
	}

	public String getApproval_cnt2() {
		return approval_cnt2;
	}

	public void setApproval_cnt2(String approval_cnt2) {
		this.approval_cnt2 = approval_cnt2;
	}

	public String getApproval_cnt3() {
		return approval_cnt3;
	}

	public void setApproval_cnt3(String approval_cnt3) {
		this.approval_cnt3 = approval_cnt3;
	}

	public String getApproval_cnt4() {
		return approval_cnt4;
	}

	public void setApproval_cnt4(String approval_cnt4) {
		this.approval_cnt4 = approval_cnt4;
	}

	public String getApproval_cnt5() {
		return approval_cnt5;
	}

	public void setApproval_cnt5(String approval_cnt5) {
		this.approval_cnt5 = approval_cnt5;
	}

	public String getApproval_user_nm() {
		return approval_user_nm;
	}

	public void setApproval_user_nm(String approval_user_nm) {
		this.approval_user_nm = approval_user_nm;
	}
	public String getTop_level_yn() {
		return top_level_yn;
	}
	public void setTop_level_yn(String top_level_yn) {
		this.top_level_yn = top_level_yn;
	}
	public String getSchedule_yn() {
		return schedule_yn;
	}
	public void setSchedule_yn(String schedule_yn) {
		this.schedule_yn = schedule_yn;
	}
	public String getPost_approval_yn() {
		return post_approval_yn;
	}
	public void setPost_approval_yn(String post_approval_yn) {
		this.post_approval_yn = post_approval_yn;
	}
	public String getLate_sub_cnt() {
		return late_sub_cnt;
	}
	public void setLate_sub_cnt(String late_sub_cnt) {
		this.late_sub_cnt = late_sub_cnt;
	}
	public String getLate_time_cnt() {
		return late_time_cnt;
	}
	public void setLate_time_cnt(String late_time_cnt) {
		this.late_time_cnt = late_time_cnt;
	}
	public String getLate_exec_cnt() {
		return late_exec_cnt;
	}
	public void setLate_exec_cnt(String late_exec_cnt) {
		this.late_exec_cnt = late_exec_cnt;
	}
	public String getError_description() {
		return error_description;
	}
	public void setError_description(String error_description) {
		this.error_description = error_description;
	}
	public String getJobschedgb() {
		return jobschedgb;
	}
	public void setJobschedgb(String jobschedgb) {
		this.jobschedgb = jobschedgb;
	}
	public String getDlNm() {
		return dlNm;
	}
	public void setDlNm(String dlNm) {
		this.dlNm = dlNm;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getDlCd() {
		return dlCd;
	}
	public void setDlCd(String dlCd) {
		this.dlCd = dlCd;
	}
	public String getFolder_auth() {
		return folder_auth;
	}
	public void setFolder_auth(String folder_auth) {
		this.folder_auth = folder_auth;
	}
	public String getUser_cd_5() {
		return user_cd_5;
	}
	public void setUser_cd_5(String user_cd_5) {
		this.user_cd_5 = user_cd_5;
	}
	public String getUser_id_5() {
		return user_id_5;
	}
	public void setUser_id_5(String user_id_5) {
		this.user_id_5 = user_id_5;
	}
	public String getUser_nm_5() {
		return user_nm_5;
	}
	public void setUser_nm_5(String user_nm_5) {
		this.user_nm_5 = user_nm_5;
	}
	public String getDuty_nm_5() {
		return duty_nm_5;
	}
	public void setDuty_nm_5(String duty_nm_5) {
		this.duty_nm_5 = duty_nm_5;
	}
	public String getDept_nm_5() {
		return dept_nm_5;
	}
	public void setDept_nm_5(String dept_nm_5) {
		this.dept_nm_5 = dept_nm_5;
	}
	public String getUser_tel_5() {
		return user_tel_5;
	}
	public void setUser_tel_5(String user_tel_5) {
		this.user_tel_5 = user_tel_5;
	}
	public String getUser_hp_5() {
		return user_hp_5;
	}
	public void setUser_hp_5(String user_hp_5) {
		this.user_hp_5 = user_hp_5;
	}
	public String getUser_email_5() {
		return user_email_5;
	}
	public void setUser_email_5(String user_email_5) {
		this.user_email_5 = user_email_5;
	}
	public String getSms_5() {
		return sms_5;
	}
	public void setSms_5(String sms_5) {
		this.sms_5 = sms_5;
	}
	public String getMail_5() {
		return mail_5;
	}
	public void setMail_5(String mail_5) {
		this.mail_5 = mail_5;
	}
	public String getUser_cd_6() {
		return user_cd_6;
	}
	public void setUser_cd_6(String user_cd_6) {
		this.user_cd_6 = user_cd_6;
	}
	public String getUser_id_6() {
		return user_id_6;
	}
	public void setUser_id_6(String user_id_6) {
		this.user_id_6 = user_id_6;
	}
	public String getUser_nm_6() {
		return user_nm_6;
	}
	public void setUser_nm_6(String user_nm_6) {
		this.user_nm_6 = user_nm_6;
	}
	public String getDuty_nm_6() {
		return duty_nm_6;
	}
	public void setDuty_nm_6(String duty_nm_6) {
		this.duty_nm_6 = duty_nm_6;
	}
	public String getDept_nm_6() {
		return dept_nm_6;
	}
	public void setDept_nm_6(String dept_nm_6) {
		this.dept_nm_6 = dept_nm_6;
	}
	public String getUser_tel_6() {
		return user_tel_6;
	}
	public void setUser_tel_6(String user_tel_6) {
		this.user_tel_6 = user_tel_6;
	}
	public String getUser_hp_6() {
		return user_hp_6;
	}
	public void setUser_hp_6(String user_hp_6) {
		this.user_hp_6 = user_hp_6;
	}
	public String getUser_email_6() {
		return user_email_6;
	}
	public void setUser_email_6(String user_email_6) {
		this.user_email_6 = user_email_6;
	}
	public String getSms_6() {
		return sms_6;
	}
	public void setSms_6(String sms_6) {
		this.sms_6 = sms_6;
	}
	public String getMail_6() {
		return mail_6;
	}
	public void setMail_6(String mail_6) {
		this.mail_6 = mail_6;
	}
	public String getUser_cd_7() { return user_cd_7; }
	public void setUser_cd_7(String user_cd_7) {
		this.user_cd_7 = user_cd_7;
	}
	public String getUser_id_7() {
		return user_id_7;
	}
	public void setUser_id_7(String user_id_7) {
		this.user_id_7 = user_id_7;
	}
	public String getUser_nm_7() {
		return user_nm_7;
	}
	public void setUser_nm_7(String user_nm_7) {
		this.user_nm_7 = user_nm_7;
	}
	public String getDuty_nm_7() {
		return duty_nm_7;
	}
	public void setDuty_nm_7(String duty_nm_7) {
		this.duty_nm_7 = duty_nm_7;
	}
	public String getDept_nm_7() {
		return dept_nm_7;
	}
	public void setDept_nm_7(String dept_nm_7) {
		this.dept_nm_7 = dept_nm_7;
	}
	public String getUser_tel_7() {
		return user_tel_7;
	}
	public void setUser_tel_7(String user_tel_7) {
		this.user_tel_7 = user_tel_7;
	}
	public String getUser_hp_7() {
		return user_hp_7;
	}
	public void setUser_hp_7(String user_hp_7) {
		this.user_hp_7 = user_hp_7;
	}
	public String getUser_email_7() {
		return user_email_7;
	}
	public void setUser_email_7(String user_email_7) {
		this.user_email_7 = user_email_7;
	}
	public String getSms_7() {
		return sms_7;
	}
	public void setSms_7(String sms_7) {
		this.sms_7 = sms_7;
	}
	public String getMail_7() {
		return mail_7;
	}
	public void setMail_7(String mail_7) {
		this.mail_7 = mail_7;
	}
	public String getUser_cd_8() { return user_cd_8; }
	public void setUser_cd_8(String user_cd_8) {
		this.user_cd_8 = user_cd_8;
	}
	public String getUser_id_8() {
		return user_id_8;
	}
	public void setUser_id_8(String user_id_8) {
		this.user_id_8 = user_id_8;
	}
	public String getUser_nm_8() {
		return user_nm_8;
	}
	public void setUser_nm_8(String user_nm_8) {
		this.user_nm_8 = user_nm_8;
	}
	public String getDuty_nm_8() {
		return duty_nm_8;
	}
	public void setDuty_nm_8(String duty_nm_8) {
		this.duty_nm_8 = duty_nm_8;
	}
	public String getDept_nm_8() {
		return dept_nm_8;
	}
	public void setDept_nm_8(String dept_nm_8) {
		this.dept_nm_8 = dept_nm_8;
	}
	public String getUser_tel_8() {
		return user_tel_8;
	}
	public void setUser_tel_8(String user_tel_8) {
		this.user_tel_8 = user_tel_8;
	}
	public String getUser_hp_8() {
		return user_hp_8;
	}
	public void setUser_hp_8(String user_hp_8) {
		this.user_hp_8 = user_hp_8;
	}
	public String getUser_email_8() {
		return user_email_8;
	}
	public void setUser_email_8(String user_email_8) {
		this.user_email_8 = user_email_8;
	}
	public String getSms_8() {
		return sms_8;
	}
	public void setSms_8(String sms_8) {
		this.sms_8 = sms_8;
	}
	public String getMail_8() {
		return mail_8;
	}
	public void setMail_8(String mail_8) {
		this.mail_8 = mail_8;
	}
	public String getApproval_user_id() {
		return approval_user_id;
	}
	public void setApproval_user_id(String approval_user_id) {
		this.approval_user_id = approval_user_id;
	}
	public String getQuartz_name() {
		return quartz_name;
	}
	public void setQuartz_name(String quartz_name) {
		this.quartz_name = quartz_name;
	}
	public String getTrace_log_path() {
		return trace_log_path;
	}
	public void setTrace_log_path(String trace_log_path) {
		this.trace_log_path = trace_log_path;
	}
	public String getStatus_cd() {
		return status_cd;
	}
	public void setStatus_cd(String status_cd) {
		this.status_cd = status_cd;
	}
	public String getStatus_log() {
		return status_log;
	}
	public void setStatus_log(String status_log) {
		this.status_log = status_log;
	}
	public String getBefore_pw() {
		return before_pw;
	}
	public void setBefore_pw(String before_pw) {
		this.before_pw = before_pw;
	}
	public String getGroup_user_group_cd() {
		return group_user_group_cd;
	}
	public void setGroup_user_group_cd(String group_user_group_cd) {
		this.group_user_group_cd = group_user_group_cd;
	}
	public String getGroup_user_group_nm() {
		return group_user_group_nm;
	}
	public void setGroup_user_group_nm(String group_user_group_nm) {
		this.group_user_group_nm = group_user_group_nm;
	}
	public String getGroup_user_line_cd() {
		return group_user_line_cd;
	}
	public void setGroup_user_line_cd(String group_user_line_cd) {
		this.group_user_line_cd = group_user_line_cd;
	}
	public String getGroup_approval_user_nm() {
		return group_approval_user_nm;
	}
	public void setGroup_approval_user_nm(String group_approval_user_nm) {
		this.group_approval_user_nm = group_approval_user_nm;
	}
	public String getGroup_approval_duty_nm() {
		return group_approval_duty_nm;
	}
	public void setGroup_approval_duty_nm(String group_approval_duty_nm) {
		this.group_approval_duty_nm = group_approval_duty_nm;
	}
	public String getGroup_approval_dept_nm() {
		return group_approval_dept_nm;
	}
	public void setGroup_approval_dept_nm(String group_approval_dept_nm) {
		this.group_approval_dept_nm = group_approval_dept_nm;
	}
	public String getGroup_approval_user_cd() {
		return group_approval_user_cd;
	}
	public void setGroup_approval_user_cd(String group_approval_user_cd) {
		this.group_approval_user_cd = group_approval_user_cd;
	}
	public String getGroup_approval_user_id() {
		return group_approval_user_id;
	}
	public void setGroup_approval_user_id(String group_approval_user_id) {
		this.group_approval_user_id = group_approval_user_id;
	}
	public String getFolder_count() {
		return folder_count;
	}
	public void setFolder_count(String folder_count) {
		this.folder_count = folder_count;
	}
	public String getGroup_member_cnt() {
		return group_member_cnt;
	}
	public void setGroup_member_cnt(String group_member_cnt) {
		this.group_member_cnt = group_member_cnt;
	}
	public String getApproval_yn() {
		return approval_yn;
	}
	public void setApproval_yn(String approval_yn) {
		this.approval_yn = approval_yn;
	}
	public String getNotice_yn() {
		return notice_yn;
	}
	public void setNotice_yn(String notice_yn) {
		this.notice_yn = notice_yn;
	}
	public String getRunning_cnt() {
		return running_cnt;
	}
	public void setRunning_cnt(String running_cnt) {
		this.running_cnt = running_cnt;
	}
	public String getDelete_cnt() {
		return delete_cnt;
	}
	public void setDelete_cnt(String delete_cnt) {
		this.delete_cnt = delete_cnt;
	}
	public String getUser_cd_9() {
		return user_cd_9;
	}

	public void setUser_cd_9(String user_cd_9) {
		this.user_cd_9 = user_cd_9;
	}

	public String getUser_id_9() {
		return user_id_9;
	}

	public void setUser_id_9(String user_id_9) {
		this.user_id_9 = user_id_9;
	}

	public String getUser_nm_9() {
		return user_nm_9;
	}

	public void setUser_nm_9(String user_nm_9) {
		this.user_nm_9 = user_nm_9;
	}

	public String getDuty_nm_9() {
		return duty_nm_9;
	}

	public void setDuty_nm_9(String duty_nm_9) {
		this.duty_nm_9 = duty_nm_9;
	}

	public String getDept_nm_9() {
		return dept_nm_9;
	}

	public void setDept_nm_9(String dept_nm_9) {
		this.dept_nm_9 = dept_nm_9;
	}

	public String getUser_tel_9() {
		return user_tel_9;
	}

	public void setUser_tel_9(String user_tel_9) {
		this.user_tel_9 = user_tel_9;
	}

	public String getUser_hp_9() {
		return user_hp_9;
	}

	public void setUser_hp_9(String user_hp_9) {
		this.user_hp_9 = user_hp_9;
	}

	public String getUser_email_9() {
		return user_email_9;
	}

	public void setUser_email_9(String user_email_9) {
		this.user_email_9 = user_email_9;
	}

	public String getSms_9() {
		return sms_9;
	}

	public void setSms_9(String sms_9) {
		this.sms_9 = sms_9;
	}

	public String getMail_9() {
		return mail_9;
	}

	public void setMail_9(String mail_9) {
		this.mail_9 = mail_9;
	}

	public String getUser_cd_10() {
		return user_cd_10;
	}

	public void setUser_cd_10(String user_cd_10) {
		this.user_cd_10 = user_cd_10;
	}

	public String getUser_id_10() {
		return user_id_10;
	}

	public void setUser_id_10(String user_id_10) {
		this.user_id_10 = user_id_10;
	}

	public String getUser_nm_10() {
		return user_nm_10;
	}
	public void setUser_nm_10(String user_nm_10) {
		this.user_nm_10 = user_nm_10;
	}
	public String getDuty_nm_10() {
		return duty_nm_10;
	}
	public void setDuty_nm_10(String duty_nm_10) {
		this.duty_nm_10 = duty_nm_10;
	}
	public String getDept_nm_10() {
		return dept_nm_10;
	}
	public void setDept_nm_10(String dept_nm_10) {
		this.dept_nm_10 = dept_nm_10;
	}
	public String getUser_tel_10() {
		return user_tel_10;
	}
	public void setUser_tel_10(String user_tel_10) {
		this.user_tel_10 = user_tel_10;
	}
	public String getUser_hp_10() {
		return user_hp_10;
	}
	public void setUser_hp_10(String user_hp_10) {
		this.user_hp_10 = user_hp_10;
	}
	public String getUser_email_10() {
		return user_email_10;
	}
	public void setUser_email_10(String user_email_10) {
		this.user_email_10 = user_email_10;
	}
	public String getSms_10() {
		return sms_10;
	}
	public void setSms_10(String sms_10) {
		this.sms_10 = sms_10;
	}
	public String getMail_10() {
		return mail_10;
	}
	public void setMail_10(String mail_10) {
		this.mail_10 = mail_10;
	}
	public String getCtm_daily_time() {
		return ctm_daily_time;
	}
	public void setCtm_daily_time(String ctm_daily_time) {
		this.ctm_daily_time = ctm_daily_time;
	}
	public String getCheck_time() {
		return check_time;
	}
	public void setCheck_time(String check_time) {
		this.check_time = check_time;
	}
	
	public String getGrp_eng_nm() {
		return grp_eng_nm;
	}
	public void setGrp_eng_nm(String grp_eng_nm) {
		this.grp_eng_nm = grp_eng_nm;
	}

	public String getQresname() {
		return qresname;
	}
	public void setQresname(String qresname) {
		this.qresname = qresname;
	}
	public String getQrtotal() {
		return qrtotal;
	}
	public void setQrtotal(String qrtotal) {
		this.qrtotal = qrtotal;
	}
	public String getQrused() {
		return qrused;
	}
	public void setQrused(String qrused) {
		this.qrused = qrused;
	}
	public String getIns_date_hh() {
		return ins_date_hh;
	}
	public void setIns_date_hh(String ins_date_hh) {
		this.ins_date_hh = ins_date_hh;
	}
	public String getGrp_cd_1() { return grp_cd_1; }
	public void setGrp_cd_1(String grp_cd_1) { this.grp_cd_1 = grp_cd_1; }
	public String getGrp_nm_1() { return grp_nm_1; }
	public void setGrp_nm_1(String grp_nm_1) { this.grp_nm_1 = grp_nm_1; }
	public String getGrp_sms_1() { return grp_sms_1; }
	public void setGrp_sms_1(String grp_sms_1) { this.grp_sms_1 = grp_sms_1; }
	public String getGrp_mail_1() { return grp_mail_1; }
	public void setGrp_mail_1(String grp_mail_1) { this.grp_mail_1 = grp_mail_1; 	}
	public String getGrp_cd_2() { return grp_cd_2; }
	public void setGrp_cd_2(String grp_cd_2) { this.grp_cd_2 = grp_cd_2; }
	public String getGrp_nm_2() { return grp_nm_2; }
	public void setGrp_nm_2(String grp_nm_2) { this.grp_nm_2 = grp_nm_2; }
	public String getGrp_sms_2() { return grp_sms_2; }
	public void setGrp_sms_2(String grp_sms_2) { this.grp_sms_2 = grp_sms_2; }
	public String getGrp_mail_2() { return grp_mail_2; }
	public void setGrp_mail_2(String grp_mail_2) { this.grp_mail_2 = grp_mail_2; }
	public String getRerun_counter() {
		return rerun_counter;
	}
	public void setRerun_counter(String rerun_counter) {
		this.rerun_counter = rerun_counter;
	}
	public String getAvg_run() {
		return avg_run;
	}
	public void setAvg_run(String avg_run) {
		this.avg_run = avg_run;
	}
	public String getSend_user_cd() {
		return send_user_cd;
	}
	public void setSend_user_cd(String send_user_cd) {
		this.send_user_cd = send_user_cd;
	}
	public String getSend_user_cd2() {
		return send_user_cd2;
	}
	public void setSend_user_cd2(String send_user_cd2) {
		this.send_user_cd2 = send_user_cd2;
	}
	public String getSend_user_cd3() {
		return send_user_cd3;
	}
	public void setSend_user_cd3(String send_user_cd3) {
		this.send_user_cd3 = send_user_cd3;
	}
	public String getSend_user_cd4() {
		return send_user_cd4;
	}
	public void setSend_user_cd4(String send_user_cd4) {
		this.send_user_cd4 = send_user_cd4;
	}
	public String getSend_user_cd5() {
		return send_user_cd5;
	}
	public void setSend_user_cd5(String send_user_cd5) {
		this.send_user_cd5 = send_user_cd5;
	}
	public String getSend_user_cd6() {
		return send_user_cd6;
	}
	public void setSend_user_cd6(String send_user_cd6) {
		this.send_user_cd6 = send_user_cd6;
	}
	public String getSend_user_cd7() {
		return send_user_cd7;
	}
	public void setSend_user_cd7(String send_user_cd7) {
		this.send_user_cd7 = send_user_cd7;
	}
	public String getSend_user_cd8() {
		return send_user_cd8;
	}
	public void setSend_user_cd8(String send_user_cd8) {
		this.send_user_cd8 = send_user_cd8;
	}
	public String getSend_user_cd9() {
		return send_user_cd9;
	}
	public void setSend_user_cd9(String send_user_cd9) {
		this.send_user_cd9 = send_user_cd9;
	}
	public String getSend_user_cd10() {
		return send_user_cd10;
	}
	public void setSend_user_cd10(String send_user_cd10) {
		this.send_user_cd10 = send_user_cd10;
	}
	public String getSend_user_hp() {
		return send_user_hp;
	}
	public void setSend_user_hp(String send_user_hp) {
		this.send_user_hp = send_user_hp;
	}
	public String getSend_user_hp2() {
		return send_user_hp2;
	}
	public void setSend_user_hp2(String send_user_hp2) {
		this.send_user_hp2 = send_user_hp2;
	}
	public String getSend_user_hp3() {
		return send_user_hp3;
	}
	public void setSend_user_hp3(String send_user_hp3) {
		this.send_user_hp3 = send_user_hp3;
	}
	public String getSend_user_hp4() {
		return send_user_hp4;
	}
	public void setSend_user_hp4(String send_user_hp4) {
		this.send_user_hp4 = send_user_hp4;
	}
	public String getSend_user_hp5() {
		return send_user_hp5;
	}
	public void setSend_user_hp5(String send_user_hp5) {
		this.send_user_hp5 = send_user_hp5;
	}
	public String getSend_user_hp6() {
		return send_user_hp6;
	}
	public void setSend_user_hp6(String send_user_hp6) {
		this.send_user_hp6 = send_user_hp6;
	}
	public String getSend_user_hp7() {
		return send_user_hp7;
	}
	public void setSend_user_hp7(String send_user_hp7) {
		this.send_user_hp7 = send_user_hp7;
	}
	public String getSend_user_hp8() {
		return send_user_hp8;
	}
	public void setSend_user_hp8(String send_user_hp8) {
		this.send_user_hp8 = send_user_hp8;
	}
	public String getSend_user_hp9() {
		return send_user_hp9;
	}
	public void setSend_user_hp9(String send_user_hp9) {
		this.send_user_hp9 = send_user_hp9;
	}
	public String getSend_user_hp10() {
		return send_user_hp10;
	}
	public void setSend_user_hp10(String send_user_hp10) {
		this.send_user_hp10 = send_user_hp10;
	}
	public String getSend_sms() {
		return send_sms;
	}
	public void setSend_sms(String send_sms) {
		this.send_sms = send_sms;
	}
	public String getSend_sms2() {
		return send_sms2;
	}
	public void setSend_sms2(String send_sms2) {
		this.send_sms2 = send_sms2;
	}
	public String getSend_sms3() {
		return send_sms3;
	}
	public void setSend_sms3(String send_sms3) {
		this.send_sms3 = send_sms3;
	}
	public String getSend_sms4() {
		return send_sms4;
	}
	public void setSend_sms4(String send_sms4) {
		this.send_sms4 = send_sms4;
	}
	public String getSend_sms5() {
		return send_sms5;
	}
	public void setSend_sms5(String send_sms5) {
		this.send_sms5 = send_sms5;
	}
	public String getSend_sms6() {
		return send_sms6;
	}
	public void setSend_sms6(String send_sms6) {
		this.send_sms6 = send_sms6;
	}
	public String getSend_sms7() {
		return send_sms7;
	}
	public void setSend_sms7(String send_sms7) {
		this.send_sms7 = send_sms7;
	}
	public String getSend_sms8() {
		return send_sms8;
	}
	public void setSend_sms8(String send_sms8) {
		this.send_sms8 = send_sms8;
	}
	public String getSend_sms9() {
		return send_sms9;
	}
	public void setSend_sms9(String send_sms9) {
		this.send_sms9 = send_sms9;
	}
	public String getSend_sms10() {
		return send_sms10;
	}
	public void setSend_sms10(String send_sms10) {
		this.send_sms10 = send_sms10;
	}
	public String getAlarm_gubun() {
		return alarm_gubun;
	}
	public void setAlarm_gubun(String alarm_gubun) {
		this.alarm_gubun = alarm_gubun;
	}
	public String getS_start_time() {
		return s_start_time;
	}
	public void setS_start_time(String s_start_time) {
		this.s_start_time = s_start_time;
	}
	public String getS_end_time() {
		return s_end_time;
	}
	public void setS_end_time(String s_end_time) {
		this.s_end_time = s_end_time;
	}
	public String getStart_time() {
		return start_time;
	}
	public void setStart_time(String start_time) {
		this.start_time = start_time;
	}
	public String getApply_date() {
		return apply_date;
	}
	public void setApply_date(String apply_date) {
		this.apply_date = apply_date;
	}
	public String getNodetype() {
		return nodetype;
	}
	public void setNodetype(String nodetype) {
		this.nodetype = nodetype;
	}
	public String getPermhosts() {
		return permhosts;
	}
	public void setPermhosts(String permhosts) {
		this.permhosts = permhosts;
	}
	public String getOwner() {
		return owner;
	}
	public void setOwner(String owner) {
		this.owner = owner;
	}
	public String getCertify_gubun() {
		return certify_gubun;
	}
	public void setCertify_gubun(String certify_gubun) {
		this.certify_gubun = certify_gubun;
	}
	public String getAbsence_user_cd() {
		return absence_user_cd;
	}
	public void setAbsence_user_cd(String absence_user_cd) {
		this.absence_user_cd = absence_user_cd;
	}
	public String getAbsence_user_id() {
		return absence_user_id;
	}
	public void setAbsence_user_id(String absence_user_id) {
		this.absence_user_id = absence_user_id;
	}
	public String getAbsence_user_nm() {
		return absence_user_nm;
	}
	public void setAbsence_user_nm(String absence_user_nm) {
		this.absence_user_nm = absence_user_nm;
	}
	public String getAbsence_user_ip() {
		return absence_user_ip;
	}
	public void setAbsence_user_ip(String absence_user_ip) {
		this.absence_user_ip = absence_user_ip;
	}
	public String getAbsence_user_hp() {
		return absence_user_hp;
	}
	public void setAbsence_user_hp(String absence_user_hp) {
		this.absence_user_hp = absence_user_hp;
	}
	public String getAbsence_user_mail() {
		return absence_user_mail;
	}
	public void setAbsence_user_mail(String absence_user_mail) {
		this.absence_user_mail = absence_user_mail;
	}
	public String getSend_description() {
		return send_description;
	}
	public void setSend_description(String send_description) {
		this.send_description = send_description;
	}
	public String getVar_name() {
		return var_name;
	}
	public void setVar_name(String var_name) {
		this.var_name = var_name;
	}
	public String getVar_value() {
		return var_value;
	}
	public void setVar_value(String var_value) {
		this.var_value = var_value;
	}
	public String getAbsence_start_date() {
		return absence_start_date;
	}
	public void setAbsence_start_date(String absence_start_date) {
		this.absence_start_date = absence_start_date;
	}
	public String getAbsence_end_date() {
		return absence_end_date;
	}
	public void setAbsence_end_date(String absence_end_date) {
		this.absence_end_date = absence_end_date;
	}
	public String getAbsence_reason() {
		return absence_reason;
	}
	public void setAbsence_reason(String absence_reason) {
		this.absence_reason = absence_reason;
	}
	public String getTask_type() {
		return task_type;
	}
	public void setTask_type(String task_type) {
		this.task_type = task_type;
	}
	public String getGroup_no() {
		return group_no;
	}
	public void setGroup_no(String group_no) {
		this.group_no = group_no;
	}
	public String getHailaki() {
		return hailaki;
	}
	public void setHailaki(String hailaki) {
		this.hailaki = hailaki;
	}
	public String getCheck_box_yn() {
		return check_box_yn;
	}
	public void setCheck_box_yn(String check_box_yn) {
		this.check_box_yn = check_box_yn;
	}
	public String getRba() {
		return rba;
	}
	public void setRba(String rba) {
		this.rba = rba;
	}
	public String getGrp_rba() {
		return grp_rba;
	}
	public void setGrp_rba(String grp_rba) {
		this.grp_rba = grp_rba;
	}
	public String getTotal_ajob_cnt() {
		return total_ajob_cnt;
	}
	public void setTotal_ajob_cnt(String total_ajob_cnt) {
		this.total_ajob_cnt = total_ajob_cnt;
	}
	public String getMatched_cnt() {
		return matched_cnt;
	}
	public void setMatched_cnt(String matched_cnt) {
		this.matched_cnt = matched_cnt;
	}
	public String getDatabase_cd() {
		return database_cd;
	}
	public void setDatabase_cd(String database_cd) {
		this.database_cd = database_cd;
	}
	public String getProfile_name() {
		return profile_name;
	}
	public void setProfile_name(String profile_name) {
		this.profile_name = profile_name;
	}
	public String getDatabase_type() {
		return database_type;
	}
	public void setDatabase_type(String database_type) {
		this.database_type = database_type;
	}
	public String getDatabase_version() {
		return database_version;
	}
	public void setDatabase_version(String database_version) {
		this.database_version = database_version;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getDatabase_name() {
		return database_name;
	}
	public void setDatabase_name(String database_name) {
		this.database_name = database_name;
	}
	public String getAccess_sid() {
		return access_sid;
	}
	public void setAccess_sid(String access_sid) {
		this.access_sid = access_sid;
	}
	public String getDatabase_pw() {
		return database_pw;
	}
	public void setDatabase_pw(String database_pw) {
		this.database_pw = database_pw;
	}
	public String getYear() {
		return year;
	}
	public void setYear(String year) {
		this.year = year;
	}
	public String getAccess_service_name() {
		return access_service_name;
	}
	public void setAccess_service_name(String access_service_name) {
		this.access_service_name = access_service_name;
	}
	
}
