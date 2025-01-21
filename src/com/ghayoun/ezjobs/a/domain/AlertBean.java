package com.ghayoun.ezjobs.a.domain;

import java.io.Serializable;
import java.sql.Timestamp;

public class AlertBean implements Serializable {

	private int row_num 			= 0;
	private String memname			= "";
	private String application      = "";
	private String group_name       = "";
	private String message          = "";
	private String handled          = "";
	private String handled_name     = "";
	private String job_name         = "";
	private String severity         = "";
	private String order_id         = "";
	private String user_id          = "";
	private String node_id          = "";
	private String host_time		= "";
	private String host_date		= "";
	private String host_time2       = "";
	private String changed_by       = "";
	private String upd_time         = "";
	private String notes            = "";
	private String data_center      = "";
	private String data_center_name = "";
	private Integer serial          = 0;
	private String type             = "";
	private String closed_from_em   = "";
	private String ticket_number    = "";
	private Integer run_counter     = 0;
	private String developer      	= "";
	private String contact      	= "";
	private String description      = "";
	private Integer user_cd      	= 0;
	private String user_nm      	= "";
	private Integer user_cd1      	= 0;
	private String user_nm1      	= "";
	private Integer user_cd2      	= 0;
	private String user_nm2      	= "";
	private Integer user_cd3      	= 0;
	private String user_nm3      	= "";
	private Integer user_cd4      	= 0;
	private String user_nm4      	= "";
	private Integer user_cd5      	= 0;
	private String user_nm5     	= "";
	private Integer user_cd6      	= 0;
	private String user_nm6      	= "";
	private Integer user_cd7      	= 0;
	private String user_nm7      	= "";
	private Integer user_cd8      	= 0;
	private String user_nm8      	= "";
	private Integer user_cd9      	= 0;
	private String user_nm9      	= "";
	private Integer user_cd10      	= 0;
	private String user_nm10      	= "";
	private Integer grp_cd1      	= 0;
	private String grp_nm1      	= "";
	private Integer grp_cd2      	= 0;
	private String grp_nm2     		= "";
	
	private String dept_nm      	= "";
	private String duty_nm      	= "";
	private String part_nm      	= "";
	private Integer alarm_cd      	= 0;
	private String action_yn      	= "";
	private String action_gubun      	= "";
	private String action_date     	= "";
	private String recur_yn     	= "";
	private String error_gubun     	= "";
	private String error_gubun_nm  	= "";
	private String error_description     	= "";
	private String solution_description  	= "";
	private String gubun  					= "";
	private String log_gubun  				= "";
	private String day_gubun  				= "";
	private String end_date 				= "";
	private String host_time_mm 			= "";
	private String host_time_dd 			= "";	
	private String update_time 				= "";
	private String update_user_nm 			= "";	
	
	private String critical_yn = "";
	private String day_cnt     	= "";
	private String month_cnt     	= "";
	private String m4_s7_cnt = "";
	private String m4_s8_cnt = "";
	private String m4_s9_cnt = "";
	private String m4_s10_cnt = "";
	private String m4_s11_cnt = "";
	private String m4_s58_cnt = "";
	
	private String user_id2 	= "";
	private String user_id3 	= "";
	private String user_id4 	= "";
	private String user_id5 	= "";
	private String user_id6 	= "";
	private String user_id7 	= "";
	private String user_id8 	= "";
	private String user_id9 	= "";
	private String user_id10 	= "";
	private String user_hp2	 	= "";
	private String user_hp3	 	= "";
	private String user_hp4	 	= "";
	private String user_hp5	 	= "";
	private String user_hp6	 	= "";
	private String user_hp7	 	= "";
	private String user_hp8	 	= "";
	private String user_hp9	 	= "";
	private String user_hp10	= "";
	private String sms_1	 	= "";
	private String sms_2	 	= "";
	private String sms_3	 	= "";
	private String sms_4	 	= "";
	private String sms_5	 	= "";
	private String sms_6	 	= "";
	private String sms_7	 	= "";
	private String sms_8	 	= "";
	private String sms_9	 	= "";
	private String sms_10	 	= "";
	private String mail_1	 	= "";
	private String mail_2	 	= "";
	private String mail_3	 	= "";
	private String mail_4	 	= "";
	private String mail_5	 	= "";
	private String mail_6	 	= "";
	private String mail_7	 	= "";
	private String mail_8	 	= "";
	private String mail_9	 	= "";
	private String mail_10	 	= "";
	private String user_email	= "";
	private String user_email2 	= "";
	private String user_email3 	= "";
	private String user_email4 	= "";
	private String user_email5 	= "";
	private String user_email6 	= "";
	private String user_email7 	= "";
	private String user_email8 	= "";
	private String user_email9 	= "";
	private String user_email10	= "";
	private String send_gubun	= "";
	
	private String user_hp	 	= "";
	private String sched_table	= "";
	
	private String late_sub		= "";
	private String late_time	= "";
	private String late_exec	= "";
	
	private String user_cd_1	= "";
	private String user_cd_2	= "";
	private String user_cd_3	= "";
	private String user_cd_4	= "";
	private String user_cd_5	= "";
	private String user_cd_6	= "";
	private String user_cd_7	= "";
	private String user_cd_8	= "";
	private String user_cd_9	= "";
	private String user_cd_10	= "";

	private String grp_cd_1    	= "";
	private String grp_cd_2    	= "";
	private String grp_sms_1   	= "";
	private String grp_sms_2   	= "";
	private String grp_mail_1   = "";
	private String grp_mail_2   = "";

	private String moneybatchjob	= "";
	private String online_impect_yn	= "";
	private String critical	 		= "";
	private String status	 		= "";
	private String state_result		= "";
	private String state_result2	= "";
	private String holdflag			= "";
	private String jobschedgb		= "";
	
	private String start_time		= "";
	private String end_time			= "";
	private String odate			= "";
	private String script			= "";
	private String order_table		= "";
	private String msg				= "";
	private String user_daily_yn	= "";
	private String confirm_user_nm	= "";
	private String confirm_yn		= "";
	private String confirm_time		= "";

	private String mem_lib			= "";
	private String task_type		= "";
	private String owner			= "";
	private String command			= "";
	
	private String rerun_max		= "";
	private String max_wait			= "";
	private String cyclic			= "";
	
	private String time_from            = "";
	private String time_until           = "";
	private String cyclic_type	 		= "";
	
	private String rerun_interval       = "";
	private String interval_sequence	= "";
	private String specific_times		= "";
	private String rerun_counter    	= "";
	private String approval_yn	    	= "";
	
	private String smart_job_yn			= "";

	public String getApproval_yn() {return approval_yn;}
	public void setApproval_yn(String approval_yn) {this.approval_yn = approval_yn;}
	public Integer getGrp_cd1() { return grp_cd1; }
	public void setGrp_cd1(Integer grp_cd1) { this.grp_cd1 = grp_cd1; }
	public String getGrp_nm1() { return grp_nm1; }
	public void setGrp_nm1(String grp_nm1) { this.grp_nm1 = grp_nm1; }
	public Integer getGrp_cd2() { return grp_cd2; }
	public void setGrp_cd2(Integer grp_cd2) { this.grp_cd2 = grp_cd2; }
	public String getGrp_nm2() { return grp_nm2; }
	public void setGrp_nm2(String grp_nm2) { this.grp_nm2 = grp_nm2; }
	public Integer getUser_cd9() { return user_cd9; }
	public void setUser_cd9(Integer user_cd9) { this.user_cd9 = user_cd9; }
	public String getUser_nm9() { return user_nm9; }
	public void setUser_nm9(String user_nm9) { this.user_nm9 = user_nm9; }
	public Integer getUser_cd10() { return user_cd10; }
	public void setUser_cd10(Integer user_cd10) { this.user_cd10 = user_cd10; }
	public String getUser_nm10() { return user_nm10; }
	public void setUser_nm10(String user_nm10) { this.user_nm10 = user_nm10; }
	public String getUser_cd_9() { return user_cd_9; }
	public void setUser_cd_9(String user_cd_9) { this.user_cd_9 = user_cd_9; }
	public String getUser_cd_10() { return user_cd_10; }
	public void setUser_cd_10(String user_cd_10) { this.user_cd_10 = user_cd_10; }

	public String getHoldflag() {
		return holdflag;
	}
	public void setHoldflag(String holdflag) {
		this.holdflag = holdflag;
	}
	public String getState_result2() {
		return state_result2;
	}
	public void setState_result2(String state_result2) {
		this.state_result2 = state_result2;
	}
	
	public String getState_result() {
		return state_result;
	}
	public void setState_result(String state_result) {
		this.state_result = state_result;
	}
	public Integer getUser_cd1() {
		return user_cd1;
	}
	public void setUser_cd1(Integer user_cd1) {
		this.user_cd1 = user_cd1;
	}
	public String getUser_nm1() {
		return user_nm1;
	}
	public void setUser_nm1(String user_nm1) {
		this.user_nm1 = user_nm1;
	}
	public Integer getUser_cd2() {
		return user_cd2;
	}
	public void setUser_cd2(Integer user_cd2) {
		this.user_cd2 = user_cd2;
	}
	public String getUser_nm2() {
		return user_nm2;
	}
	public void setUser_nm2(String user_nm2) {
		this.user_nm2 = user_nm2;
	}
	public Integer getUser_cd3() {
		return user_cd3;
	}
	public void setUser_cd3(Integer user_cd3) {
		this.user_cd3 = user_cd3;
	}
	public String getUser_nm3() {
		return user_nm3;
	}
	public void setUser_nm3(String user_nm3) {
		this.user_nm3 = user_nm3;
	}
	public Integer getUser_cd4() {
		return user_cd4;
	}
	public void setUser_cd4(Integer user_cd4) {
		this.user_cd4 = user_cd4;
	}
	public String getUser_nm4() {
		return user_nm4;
	}
	public void setUser_nm4(String user_nm4) {
		this.user_nm4 = user_nm4;
	}
	public String getAction_gubun() {
		return action_gubun;
	}
	public void setAction_gubun(String action_gubun) {
		this.action_gubun = action_gubun;
	}
	public String getHost_date() {
		return host_date;
	}
	public void setHost_date(String host_date) {
		this.host_date = host_date;
	}
	public String getData_center_name() {
		return data_center_name;
	}
	public void setData_center_name(String data_center_name) {
		this.data_center_name = data_center_name;
	}
	public String getHost_time() {
		return host_time;
	}
	public void setHost_time(String host_time) {
		this.host_time = host_time;
	}
	public String getLate_sub() {
		return late_sub;
	}
	public void setLate_sub(String late_sub) {
		this.late_sub = late_sub;
	}
	public String getLate_time() {
		return late_time;
	}
	public void setLate_time(String late_time) {
		this.late_time = late_time;
	}
	public String getLate_exec() {
		return late_exec;
	}
	public void setLate_exec(String late_exec) {
		this.late_exec = late_exec;
	}
	public String getMemname() {
		return memname;
	}
	public void setMemname(String memname) {
		this.memname = memname;
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
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public String getHandled() {
		return handled;
	}
	public void setHandled(String handled) {
		this.handled = handled;
	}
	public String getHandled_name() {
		return handled_name;
	}
	public void setHandled_name(String handled_name) {
		this.handled_name = handled_name;
	}
	public String getJob_name() {
		return job_name;
	}
	public void setJob_name(String job_name) {
		this.job_name = job_name;
	}
	public String getSeverity() {
		return severity;
	}
	public void setSeverity(String severity) {
		this.severity = severity;
	}
	public String getOrder_id() {
		return order_id;
	}
	public void setOrder_id(String order_id) {
		this.order_id = order_id;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getNode_id() {
		return node_id;
	}
	public void setNode_id(String node_id) {
		this.node_id = node_id;
	}
	public String getChanged_by() {
		return changed_by;
	}
	public void setChanged_by(String changed_by) {
		this.changed_by = changed_by;
	}
	public String getUpd_time() {
		return upd_time;
	}
	public void setUpd_time(String upd_time) {
		this.upd_time = upd_time;
	}
	public String getNotes() {
		return notes;
	}
	public void setNotes(String notes) {
		this.notes = notes;
	}
	public String getData_center() {
		return data_center;
	}
	public void setData_center(String data_center) {
		this.data_center = data_center;
	}
	
	public Integer getSerial() {
		return serial;
	}
	public void setSerial(Integer serial) {
		this.serial = serial;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getClosed_from_em() {
		return closed_from_em;
	}
	public void setClosed_from_em(String closed_from_em) {
		this.closed_from_em = closed_from_em;
	}
	public String getTicket_number() {
		return ticket_number;
	}
	public void setTicket_number(String ticket_number) {
		this.ticket_number = ticket_number;
	}
	
	public Integer getRun_counter() {
		return run_counter;
	}
	public void setRun_counter(Integer run_counter) {
		this.run_counter = run_counter;
	}
	public int getRow_num() {
		return row_num;
	}
	public void setRow_num(int row_num) {
		this.row_num = row_num;
	}
	public String getDeveloper() {
		return developer;
	}
	public void setDeveloper(String developer) {
		this.developer = developer;
	}
	public String getContact() {
		return contact;
	}
	public void setContact(String contact) {
		this.contact = contact;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getUser_nm() {
		return user_nm;
	}
	public void setUser_nm(String userNm) {
		user_nm = userNm;
	}
	public String getDept_nm() {
		return dept_nm;
	}
	public void setDept_nm(String deptNm) {
		dept_nm = deptNm;
	}
	public String getDuty_nm() {
		return duty_nm;
	}
	public void setDuty_nm(String dutyNm) {
		duty_nm = dutyNm;
	}
	
	public Integer getAlarm_cd() {
		return alarm_cd;
	}
	public void setAlarm_cd(Integer alarm_cd) {
		this.alarm_cd = alarm_cd;
	}
	
	public Integer getUser_cd() {
		return user_cd;
	}
	public void setUser_cd(Integer user_cd) {
		this.user_cd = user_cd;
	}
	public String getAction_yn() {
		return action_yn;
	}
	public void setAction_yn(String actionYn) {
		action_yn = actionYn;
	}
	public String getAction_date() {
		return action_date;
	}
	public void setAction_date(String actionDate) {
		action_date = actionDate;
	}
	public String getRecur_yn() {
		return recur_yn;
	}
	public void setRecur_yn(String recurYn) {
		recur_yn = recurYn;
	}
	public String getError_gubun() {
		return error_gubun;
	}
	public void setError_gubun(String errorGubun) {
		error_gubun = errorGubun;
	}
	public String getError_description() {
		return error_description;
	}
	public void setError_description(String errorDescription) {
		error_description = errorDescription;
	}
	public String getSolution_description() {
		return solution_description;
	}
	public void setSolution_description(String solutionDescription) {
		solution_description = solutionDescription;
	}
	public String getError_gubun_nm() {
		return error_gubun_nm;
	}
	public void setError_gubun_nm(String errorGubunNm) {
		error_gubun_nm = errorGubunNm;
	}
	public String getLog_gubun() {
		return log_gubun;
	}
	public void setLog_gubun(String logGubun) {
		log_gubun = logGubun;
	}
	public String getEnd_date() {
		return end_date;
	}
	public void setEnd_date(String endDate) {
		end_date = endDate;
	}
	public String getGubun() {
		return gubun;
	}
	public void setGubun(String gubun) {
		this.gubun = gubun;
	}
	public String getDay_gubun() {
		return day_gubun;
	}
	public void setDay_gubun(String dayGubun) {
		day_gubun = dayGubun;
	}
	public String getHost_time_mm() {
		return host_time_mm;
	}
	public void setHost_time_mm(String hostTimeMm) {
		host_time_mm = hostTimeMm;
	}
	public String getHost_time_dd() {
		return host_time_dd;
	}
	public void setHost_time_dd(String hostTimeDd) {
		host_time_dd = hostTimeDd;
	}
	public String getUpdate_time() {
		return update_time;
	}
	public void setUpdate_time(String updateTime) {
		update_time = updateTime;
	}
	public String getUpdate_user_nm() {
		return update_user_nm;
	}
	public void setUpdate_user_nm(String updateUserNm) {
		update_user_nm = updateUserNm;
	}
	public String getHost_time2() {
		return host_time2;
	}
	public void setHost_time2(String hostTime2) {
		host_time2 = hostTime2;
	}
	public String getCritical_yn() {
		return critical_yn;
	}
	public void setCritical_yn(String criticalYn) {
		critical_yn = criticalYn;
	}
	public String getMonth_cnt() {
		return month_cnt;
	}
	public void setMonth_cnt(String monthCnt) {
		month_cnt = monthCnt;
	}
	public String getM4_s7_cnt() {
		return m4_s7_cnt;
	}
	public void setM4_s7_cnt(String m4S7Cnt) {
		m4_s7_cnt = m4S7Cnt;
	}
	public String getM4_s8_cnt() {
		return m4_s8_cnt;
	}
	public void setM4_s8_cnt(String m4S8Cnt) {
		m4_s8_cnt = m4S8Cnt;
	}
	public String getM4_s9_cnt() {
		return m4_s9_cnt;
	}
	public void setM4_s9_cnt(String m4S9Cnt) {
		m4_s9_cnt = m4S9Cnt;
	}
	public String getM4_s10_cnt() {
		return m4_s10_cnt;
	}
	public void setM4_s10_cnt(String m4S10Cnt) {
		m4_s10_cnt = m4S10Cnt;
	}
	public String getM4_s11_cnt() {
		return m4_s11_cnt;
	}
	public void setM4_s11_cnt(String m4S11Cnt) {
		m4_s11_cnt = m4S11Cnt;
	}
	public String getDay_cnt() {
		return day_cnt;
	}
	public void setDay_cnt(String dayCnt) {
		day_cnt = dayCnt;
	}
	public String getM4_s58_cnt() {
		return m4_s58_cnt;
	}
	public void setM4_s58_cnt(String m4S58Cnt) {
		m4_s58_cnt = m4S58Cnt;
	}
	public String getUser_hp() {
		return user_hp;
	}
	public void setUser_hp(String userHp) {
		user_hp = userHp;
	}
	public String getUser_id2() {
		return user_id2;
	}
	public void setUser_id2(String userId2) {
		user_id2 = userId2;
	}
	public String getUser_hp2() {
		return user_hp2;
	}
	public void setUser_hp2(String userHp2) {
		user_hp2 = userHp2;
	}
	public String getSms_1() {
		return sms_1;
	}
	public void setSms_1(String sms_1) {
		this.sms_1 = sms_1;
	}
	public String getSms_2() {
		return sms_2;
	}
	public void setSms_2(String sms_2) {
		this.sms_2 = sms_2;
	}
	public String getMail_1() {
		return mail_1;
	}
	public void setMail_1(String mail_1) {
		this.mail_1 = mail_1;
	}
	public String getMail_2() {
		return mail_2;
	}
	public void setMail_2(String mail_2) {
		this.mail_2 = mail_2;
	}
	public String getUser_email() {
		return user_email;
	}
	public void setUser_email(String userEmail) {
		user_email = userEmail;
	}
	public String getUser_email2() {
		return user_email2;
	}
	public void setUser_email2(String userEmail2) {
		user_email2 = userEmail2;
	}
	public String getSend_gubun() {
		return send_gubun;
	}
	public void setSend_gubun(String sendGubun) {
		send_gubun = sendGubun;
	}
	public String getPart_nm() {
		return part_nm;
	}
	public void setPart_nm(String partNm) {
		part_nm = partNm;
	}
	public String getSched_table() {
		return sched_table;
	}
	public void setSched_table(String sched_table) {
		this.sched_table = sched_table;
	}
	public String getSms_3() {
		return sms_3;
	}
	public void setSms_3(String sms_3) {
		this.sms_3 = sms_3;
	}
	public String getSms_4() {
		return sms_4;
	}
	public void setSms_4(String sms_4) {
		this.sms_4 = sms_4;
	}
	public String getUser_hp3() {
		return user_hp3;
	}
	public void setUser_hp3(String userHp3) {
		user_hp3 = userHp3;
	}
	public String getUser_hp4() {
		return user_hp4;
	}
	public void setUser_hp4(String userHp4) {
		user_hp4 = userHp4;
	}
	public String getUser_email3() {
		return user_email3;
	}
	public void setUser_email3(String userEmail3) {
		user_email3 = userEmail3;
	}
	public String getUser_email4() {
		return user_email4;
	}
	public void setUser_email4(String userEmail4) {
		user_email4 = userEmail4;
	}
	public String getUser_id3() {
		return user_id3;
	}
	public void setUser_id3(String userId3) {
		user_id3 = userId3;
	}
	public String getUser_id4() {
		return user_id4;
	}
	public void setUser_id4(String userId4) {
		user_id4 = userId4;
	}
	public String getMail_3() {
		return mail_3;
	}
	public void setMail_3(String mail_3) {
		this.mail_3 = mail_3;
	}
	public String getMail_4() {
		return mail_4;
	}
	public void setMail_4(String mail_4) {
		this.mail_4 = mail_4;
	}
	public String getUser_id5() {
		return user_id5;
	}
	public void setUser_id5(String userId5) {
		user_id5 = userId5;
	}
	public String getUser_id6() {
		return user_id6;
	}
	public void setUser_id6(String userId6) {
		user_id6 = userId6;
	}
	public String getUser_id7() {
		return user_id7;
	}
	public void setUser_id7(String userId7) {
		user_id7 = userId7;
	}
	public String getUser_id8() {
		return user_id8;
	}
	public void setUser_id8(String userId8) {
		user_id8 = userId8;
	}
	public String getUser_id9() {
		return user_id9;
	}
	public void setUser_id9(String userId9) {
		user_id9 = userId9;
	}
	public String getUser_id10() {
		return user_id10;
	}
	public void setUser_id10(String userId10) {
		user_id10 = userId10;
	}
	public String getUser_hp5() {
		return user_hp5;
	}
	public void setUser_hp5(String userHp5) {
		user_hp5 = userHp5;
	}
	public String getUser_hp6() {
		return user_hp6;
	}
	public void setUser_hp6(String userHp6) {
		user_hp6 = userHp6;
	}
	public String getUser_hp7() {
		return user_hp7;
	}
	public void setUser_hp7(String userHp7) {
		user_hp7 = userHp7;
	}
	public String getUser_hp8() {
		return user_hp8;
	}
	public void setUser_hp8(String userHp8) {
		user_hp8 = userHp8;
	}
	public String getUser_hp9() {
		return user_hp9;
	}
	public void setUser_hp9(String userHp9) {
		user_hp9 = userHp9;
	}
	public String getUser_hp10() {
		return user_hp10;
	}
	public void setUser_hp10(String userHp10) {
		user_hp10 = userHp10;
	}
	public String getSms_5() {
		return sms_5;
	}
	public void setSms_5(String sms_5) {
		this.sms_5 = sms_5;
	}
	public String getSms_6() {
		return sms_6;
	}
	public void setSms_6(String sms_6) {
		this.sms_6 = sms_6;
	}
	public String getSms_7() {
		return sms_7;
	}
	public void setSms_7(String sms_7) {
		this.sms_7 = sms_7;
	}
	public String getSms_8() {
		return sms_8;
	}
	public void setSms_8(String sms_8) {
		this.sms_8 = sms_8;
	}
	public String getSms_9() {
		return sms_9;
	}
	public void setSms_9(String sms_9) {
		this.sms_9 = sms_9;
	}
	public String getSms_10() {
		return sms_10;
	}
	public void setSms_10(String sms_10) {
		this.sms_10 = sms_10;
	}
	public String getMail_5() {
		return mail_5;
	}
	public void setMail_5(String mail_5) {
		this.mail_5 = mail_5;
	}
	public String getMail_6() {
		return mail_6;
	}
	public void setMail_6(String mail_6) {
		this.mail_6 = mail_6;
	}
	public String getMail_7() {
		return mail_7;
	}
	public void setMail_7(String mail_7) {
		this.mail_7 = mail_7;
	}
	public String getMail_8() {
		return mail_8;
	}
	public void setMail_8(String mail_8) {
		this.mail_8 = mail_8;
	}
	public String getMail_9() {
		return mail_9;
	}
	public void setMail_9(String mail_9) {
		this.mail_9 = mail_9;
	}
	public String getMail_10() {
		return mail_10;
	}
	public void setMail_10(String mail_10) {
		this.mail_10 = mail_10;
	}
	public String getUser_email5() {
		return user_email5;
	}
	public void setUser_email5(String userEmail5) {
		user_email5 = userEmail5;
	}
	public String getUser_email6() {
		return user_email6;
	}
	public void setUser_email6(String userEmail6) {
		user_email6 = userEmail6;
	}
	public String getUser_email7() {
		return user_email7;
	}
	public void setUser_email7(String userEmail7) {
		user_email7 = userEmail7;
	}
	public String getUser_email8() {
		return user_email8;
	}
	public void setUser_email8(String userEmail8) {
		user_email8 = userEmail8;
	}
	public String getUser_email9() {
		return user_email9;
	}
	public void setUser_email9(String userEmail9) {
		user_email9 = userEmail9;
	}
	public String getUser_email10() {
		return user_email10;
	}
	public void setUser_email10(String userEmail10) {
		user_email10 = userEmail10;
	}
	public String getUser_cd_1() {
		return user_cd_1;
	}
	public void setUser_cd_1(String user_cd_1) {
		this.user_cd_1 = user_cd_1;
	}
	public String getUser_cd_2() {
		return user_cd_2;
	}
	public void setUser_cd_2(String user_cd_2) {
		this.user_cd_2 = user_cd_2;
	}
	public String getUser_cd_3() {
		return user_cd_3;
	}
	public void setUser_cd_3(String user_cd_3) {
		this.user_cd_3 = user_cd_3;
	}
	public String getUser_cd_4() {
		return user_cd_4;
	}
	public void setUser_cd_4(String user_cd_4) {
		this.user_cd_4 = user_cd_4;
	}
	public String getMoneybatchjob() {
		return moneybatchjob;
	}
	public void setMoneybatchjob(String moneybatchjob) {
		this.moneybatchjob = moneybatchjob;
	}
	public String getOnline_impect_yn() {
		return online_impect_yn;
	}
	public void setOnline_impect_yn(String online_impect_yn) {
		this.online_impect_yn = online_impect_yn;
	}
	public String getCritical() {
		return critical;
	}
	public void setCritical(String critical) {
		this.critical = critical;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getJobschedgb() {
		return jobschedgb;
	}
	public void setJobschedgb(String jobschedgb) {
		this.jobschedgb = jobschedgb;
	}
	public String getUser_cd_5() {
		return user_cd_5;
	}
	public void setUser_cd_5(String user_cd_5) {
		this.user_cd_5 = user_cd_5;
	}
	public String getUser_cd_6() {
		return user_cd_6;
	}
	public void setUser_cd_6(String user_cd_6) {
		this.user_cd_6 = user_cd_6;
	}
	public String getUser_cd_7() {
		return user_cd_7;
	}
	public void setUser_cd_7(String user_cd_7) {
		this.user_cd_7 = user_cd_7;
	}
	public String getUser_cd_8() {
		return user_cd_8;
	}
	public void setUser_cd_8(String user_cd_8) {
		this.user_cd_8 = user_cd_8;
	}
	public String getStart_time() {
		return start_time;
	}
	public void setStart_time(String start_time) {
		this.start_time = start_time;
	}
	public String getEnd_time() {
		return end_time;
	}
	public void setEnd_time(String end_time) {
		this.end_time = end_time;
	}
	public Integer getUser_cd5() {
		return user_cd5;
	}
	public void setUser_cd5(Integer user_cd5) {
		this.user_cd5 = user_cd5;
	}
	public String getUser_nm5() {
		return user_nm5;
	}
	public void setUser_nm5(String user_nm5) {
		this.user_nm5 = user_nm5;
	}
	public Integer getUser_cd6() {
		return user_cd6;
	}
	public void setUser_cd6(Integer user_cd6) {
		this.user_cd6 = user_cd6;
	}
	public String getUser_nm6() {
		return user_nm6;
	}
	public void setUser_nm6(String user_nm6) {
		this.user_nm6 = user_nm6;
	}
	public Integer getUser_cd7() {
		return user_cd7;
	}
	public void setUser_cd7(Integer user_cd7) {
		this.user_cd7 = user_cd7;
	}
	public String getUser_nm7() {
		return user_nm7;
	}
	public void setUser_nm7(String user_nm7) {
		this.user_nm7 = user_nm7;
	}
	public Integer getUser_cd8() {
		return user_cd8;
	}
	public void setUser_cd8(Integer user_cd8) {
		this.user_cd8 = user_cd8;
	}
	public String getUser_nm8() {
		return user_nm8;
	}
	public void setUser_nm8(String user_nm8) {
		this.user_nm8 = user_nm8;
	}
	public String getOdate() {
		return odate;
	}
	public void setOdate(String odate) {
		this.odate = odate;
	}
	public String getScript() {
		return script;
	}
	public void setScript(String script) {
		this.script = script;
	}
	public String getOrder_table() {
		return order_table;
	}
	public void setOrder_table(String order_table) {
		this.order_table = order_table;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public String getUser_daily_yn() {
		return user_daily_yn;
	}
	public void setUser_daily_yn(String user_daily_yn) {
		this.user_daily_yn = user_daily_yn;
	}
	public String getConfirm_user_nm() {
		return confirm_user_nm;
	}
	public void setConfirm_user_nm(String confirm_user_nm) {
		this.confirm_user_nm = confirm_user_nm;
	}
	public String getConfirm_yn() {
		return confirm_yn;
	}
	public void setConfirm_yn(String confirm_yn) {
		this.confirm_yn = confirm_yn;
	}
	public String getConfirm_time() {
		return confirm_time;
	}
	public void setConfirm_time(String confirm_time) {
		this.confirm_time = confirm_time;
	}

	
	public String getMem_lib() {
		return mem_lib;
	}
	public void setMem_lib(String mem_lib) {
		this.mem_lib = mem_lib;
	}
	
	public String getTask_type() {
		return task_type;
	}
	public void setTask_type(String task_type) {
		this.task_type = task_type;
	}
	
	public String getOwner() {
		return owner;
	}
	public void setOwner(String owner) {
		this.owner = owner;
	}
	
	public String getCommand() {
		return command;
	}
	public void setCommand(String command) {
		this.command = command;
	}
	
	public String getRerun_max() {
		return rerun_max;
	}
	public void setRerun_max(String rerun_max) {
		this.rerun_max = rerun_max;
	}
	
	public String getMax_wait() {
		return max_wait;
	}
	public void setMax_wait(String max_wait) {
		this.max_wait = max_wait;
	}
	
	public String getCyclic() {
		return cyclic;
	}
	public void setCyclic(String cyclic) {
		this.cyclic = cyclic;
	}
	public String getTime_from() {
		return time_from;
	}
	public void setTime_from(String time_from) {
		this.time_from = time_from;
	}
	public String getTime_until() {
		return time_until;
	}
	public void setTime_until(String time_until) {
		this.time_until = time_until;
	}
	public String getCyclic_type() {
		return cyclic_type;
	}
	public void setCyclic_type(String cyclicType) {
		cyclic_type = cyclicType;
	}
	public String getRerun_interval() {
		return rerun_interval;
	}
	public void setRerun_interval(String rerun_interval) {
		this.rerun_interval = rerun_interval;
	}
	public String getInterval_sequence() {
		return interval_sequence;
	}
	public void setInterval_sequence(String intervalSequence) {
		interval_sequence = intervalSequence;
	}
	public String getSpecific_times() {
		return specific_times;
	}
	public void setSpecific_times(String specificTimes) {
		specific_times = specificTimes;
	}
	public String getRerun_counter() {
		return rerun_counter;
	}
	public void setRerun_counter(String rerun_counter) {
		this.rerun_counter = rerun_counter;
	}
	public String getGrp_cd_1() {
		return grp_cd_1;
	}
	public void setGrp_cd_1(String grp_cd_1) {
		this.grp_cd_1 = grp_cd_1;
	}
	public String getGrp_cd_2() {
		return grp_cd_2;
	}
	public void setGrp_cd_2(String grp_cd_2) {
		this.grp_cd_2 = grp_cd_2;
	}
	public String getGrp_sms_1() {
		return grp_sms_1;
	}
	public void setGrp_sms_1(String grp_sms_1) {
		this.grp_sms_1 = grp_sms_1;
	}
	public String getGrp_sms_2() {
		return grp_sms_2;
	}
	public void setGrp_sms_2(String grp_sms_2) {
		this.grp_sms_2 = grp_sms_2;
	}
	public String getGrp_mail_1() {
		return grp_mail_1;
	}
	public void setGrp_mail_1(String grp_mail_1) {
		this.grp_mail_1 = grp_mail_1;
	}
	public String getGrp_mail_2() {
		return grp_mail_2;
	}
	public void setGrp_mail_2(String grp_mail_2) {
		this.grp_mail_2 = grp_mail_2;
	}
	public String getSmart_job_yn() {
		return smart_job_yn;
	}
	public void setSmart_job_yn(String smart_job_yn) {
		this.smart_job_yn = smart_job_yn;
	}
        
}
