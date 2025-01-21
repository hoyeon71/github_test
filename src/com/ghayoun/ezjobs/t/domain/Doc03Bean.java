package com.ghayoun.ezjobs.t.domain;

import java.io.Serializable;

public class Doc03Bean implements Serializable {
	
	private String doc_cd				= "";
	private String doc_gb				= "";
	private String cur_approval_seq		= "";
	private String state_cd				= "";
	private String user_cd				= "";
	private String user_id				= "";
	private String user_nm				= "";
	private String dept_cd				= "";
	private String dept_nm				= "";
	private String duty_cd				= "";
	private String duty_nm				= "";
	private String part_nm				= "";
	private String title				= "";
	private String content				= "";
	
	private String ins_date       = "";
	private String ins_user_cd    = "";
	private String ins_user_ip    = "";
	private String udt_date       = "";
	private String udt_user_cd    = "";
	private String udt_user_ip    = "";
	
	private String table_id               = "";
	private String job_id                 = "";
	private String data_center            = "";
	private String data_center_name       = "";
	private String table_name             = "";
	private String application            = "";
	private String group_name             = "";
	private String mem_name               = "";
	private String job_name               = "";
	
	private String task_type               	= "";
	private String user_daily              	= "";
	private String description             	= "";
	private String owner               		= "";
	private String author               	= "";
	private String mem_lib               	= "";
	private String command               	= "";
	private String in_condition             = "";
	private String out_condition            = "";
	
	private String file_nm				= "";
	private String save_file_nm			= "";
	private String file_path			= "";
	
	private String apply_date			= "";
	private String apply_check			= "";
	private String apply_cd				= "";
	private String cancel_comment		= "";
	private String fail_comment			= "";
	
	private String priority             = "";
	private String critical             = "";
	private String cyclic               = "";
	private String node_id                = "";
	private String rerun_interval         = "";
	private String rerun_interval_time    = "";
	private String confirm_flag           = "";
	private String days_cal               = "";
	private String weeks_cal              = "";
	private String retro                  = "";
	private String max_wait               = "";
	private String rerun_max              = "";
	private String time_from              = "";
	private String time_until             = "";
	private String month_days             = "";
	private String month_cal             = "";
	private String week_days              = "";
	private String month_1                = "";
	private String month_2                = "";
	private String month_3                = "";
	private String month_4                = "";
	private String month_5                = "";
	private String month_6                = "";
	private String month_7                = "";
	private String month_8                = "";
	private String month_9                = "";
	private String month_10               = "";
	private String month_11               = "";
	private String month_12               = "";
	private String count_cyclic_from      = "";
	private String time_zone              = "";
	private String multiagent             = "";
	private String schedule_and_or        = "";
	private String in_conditions_opt      = "";
	private String t_general_date 			= "";
	private String t_conditions_in 			= "";
	private String t_conditions_out 		= "";
	private String t_resources_q 			= "";
	private String t_resources_c 			= "";
	private String t_set 					= "";
	private String t_steps 					= "";
	private String t_postproc 				= "";
	private String t_sfile 					= "";
	
	private String before_application 	= "";
	private String before_table_name 	= "";
	private String before_group_name 	= "";
	
	private String t_tag_name	 		= "";
	private String table_cnt	 		= "";
	private String table_type	 		= "";
	
	private String cyclic_type	 		= "";	
	private String interval_sequence	= "";
	private String tolerance			= "";	
	private String specific_times		= "";
	
	private String active_from			= "";
	private String active_till			= "";
	
	private String set_cd				= "";
	private String max_doc_cd			= "";
	
	private String late_sub				= "";
	private String late_time			= "";
	private String late_exec			= "";
	
	private String conf_cal				= "";
	private String shift				= "";
	private String shift_num			= "";
	
	private String sr_code				= "";
	
	private String monitor_time			= "";
	private String monitor_interval		= "";
	private String post_approval_yn		= "";

	public String getPost_approval_yn() { return post_approval_yn; }
	public void setPost_approval_yn(String post_approval_yn) { this.post_approval_yn = post_approval_yn; }
	
	public String getPriority() {
		return priority;
	}
	public void setPriority(String priority) {
		this.priority = priority;
	}
	public String getCritical() {
		return critical;
	}
	public void setCritical(String critical) {
		this.critical = critical;
	}
	public String getCyclic() {
		return cyclic;
	}
	public void setCyclic(String cyclic) {
		this.cyclic = cyclic;
	}
	public String getNode_id() {
		return node_id;
	}
	public void setNode_id(String node_id) {
		this.node_id = node_id;
	}
	public String getRerun_interval() {
		return rerun_interval;
	}
	public void setRerun_interval(String rerun_interval) {
		this.rerun_interval = rerun_interval;
	}
	public String getRerun_interval_time() {
		return rerun_interval_time;
	}
	public void setRerun_interval_time(String rerun_interval_time) {
		this.rerun_interval_time = rerun_interval_time;
	}
	public String getConfirm_flag() {
		return confirm_flag;
	}
	public void setConfirm_flag(String confirm_flag) {
		this.confirm_flag = confirm_flag;
	}
	public String getDays_cal() {
		return days_cal;
	}
	public void setDays_cal(String days_cal) {
		this.days_cal = days_cal;
	}
	public String getWeeks_cal() {
		return weeks_cal;
	}
	public void setWeeks_cal(String weeks_cal) {
		this.weeks_cal = weeks_cal;
	}
	public String getRetro() {
		return retro;
	}
	public void setRetro(String retro) {
		this.retro = retro;
	}
	public String getMax_wait() {
		return max_wait;
	}
	public void setMax_wait(String max_wait) {
		this.max_wait = max_wait;
	}
	public String getRerun_max() {
		return rerun_max;
	}
	public void setRerun_max(String rerun_max) {
		this.rerun_max = rerun_max;
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
	public String getMonth_days() {
		return month_days;
	}
	public void setMonth_days(String month_days) {
		this.month_days = month_days;
	}
	public String getMonth_cal() {
		return month_cal;
	}
	public void setMonth_cal(String month_cal) {
		this.month_cal = month_cal;
	}
	public String getWeek_days() {
		return week_days;
	}
	public void setWeek_days(String week_days) {
		this.week_days = week_days;
	}
	public String getMonth_1() {
		return month_1;
	}
	public void setMonth_1(String month_1) {
		this.month_1 = month_1;
	}
	public String getMonth_2() {
		return month_2;
	}
	public void setMonth_2(String month_2) {
		this.month_2 = month_2;
	}
	public String getMonth_3() {
		return month_3;
	}
	public void setMonth_3(String month_3) {
		this.month_3 = month_3;
	}
	public String getMonth_4() {
		return month_4;
	}
	public void setMonth_4(String month_4) {
		this.month_4 = month_4;
	}
	public String getMonth_5() {
		return month_5;
	}
	public void setMonth_5(String month_5) {
		this.month_5 = month_5;
	}
	public String getMonth_6() {
		return month_6;
	}
	public void setMonth_6(String month_6) {
		this.month_6 = month_6;
	}
	public String getMonth_7() {
		return month_7;
	}
	public void setMonth_7(String month_7) {
		this.month_7 = month_7;
	}
	public String getMonth_8() {
		return month_8;
	}
	public void setMonth_8(String month_8) {
		this.month_8 = month_8;
	}
	public String getMonth_9() {
		return month_9;
	}
	public void setMonth_9(String month_9) {
		this.month_9 = month_9;
	}
	public String getMonth_10() {
		return month_10;
	}
	public void setMonth_10(String month_10) {
		this.month_10 = month_10;
	}
	public String getMonth_11() {
		return month_11;
	}
	public void setMonth_11(String month_11) {
		this.month_11 = month_11;
	}
	public String getMonth_12() {
		return month_12;
	}
	public void setMonth_12(String month_12) {
		this.month_12 = month_12;
	}
	public String getCount_cyclic_from() {
		return count_cyclic_from;
	}
	public void setCount_cyclic_from(String count_cyclic_from) {
		this.count_cyclic_from = count_cyclic_from;
	}
	public String getTime_zone() {
		return time_zone;
	}
	public void setTime_zone(String time_zone) {
		this.time_zone = time_zone;
	}
	public String getMultiagent() {
		return multiagent;
	}
	public void setMultiagent(String multiagent) {
		this.multiagent = multiagent;
	}
	public String getSchedule_and_or() {
		return schedule_and_or;
	}
	public void setSchedule_and_or(String schedule_and_or) {
		this.schedule_and_or = schedule_and_or;
	}
	public String getIn_conditions_opt() {
		return in_conditions_opt;
	}
	public void setIn_conditions_opt(String in_conditions_opt) {
		this.in_conditions_opt = in_conditions_opt;
	}
	public String getT_general_date() {
		return t_general_date;
	}
	public void setT_general_date(String t_general_date) {
		this.t_general_date = t_general_date;
	}
	public String getT_conditions_in() {
		return t_conditions_in;
	}
	public void setT_conditions_in(String t_conditions_in) {
		this.t_conditions_in = t_conditions_in;
	}
	public String getT_conditions_out() {
		return t_conditions_out;
	}
	public void setT_conditions_out(String t_conditions_out) {
		this.t_conditions_out = t_conditions_out;
	}
	public String getT_resources_q() {
		return t_resources_q;
	}
	public void setT_resources_q(String t_resources_q) {
		this.t_resources_q = t_resources_q;
	}
	public String getT_resources_c() {
		return t_resources_c;
	}
	public void setT_resources_c(String t_resources_c) {
		this.t_resources_c = t_resources_c;
	}
	public String getT_set() {
		return t_set;
	}
	public void setT_set(String t_set) {
		this.t_set = t_set;
	}
	public String getT_steps() {
		return t_steps;
	}
	public void setT_steps(String t_steps) {
		this.t_steps = t_steps;
	}
	public String getT_postproc() {
		return t_postproc;
	}
	public void setT_postproc(String t_postproc) {
		this.t_postproc = t_postproc;
	}
	public String getT_sfile() {
		return t_sfile;
	}
	public void setT_sfile(String t_sfile) {
		this.t_sfile = t_sfile;
	}
	public String getBefore_application() {
		return before_application;
	}
	public void setBefore_application(String before_application) {
		this.before_application = before_application;
	}
	public String getBefore_table_name() {
		return before_table_name;
	}
	public void setBefore_table_name(String before_table_name) {
		this.before_table_name = before_table_name;
	}
	public String getBefore_group_name() {
		return before_group_name;
	}
	public void setBefore_group_name(String before_group_name) {
		this.before_group_name = before_group_name;
	}
	public String getT_tag_name() {
		return t_tag_name;
	}
	public void setT_tag_name(String t_tag_name) {
		this.t_tag_name = t_tag_name;
	}
	public String getTable_cnt() {
		return table_cnt;
	}
	public void setTable_cnt(String table_cnt) {
		this.table_cnt = table_cnt;
	}
	public String getTable_type() {
		return table_type;
	}
	public void setTable_type(String table_type) {
		this.table_type = table_type;
	}
	public String getCyclic_type() {
		return cyclic_type;
	}
	public void setCyclic_type(String cyclic_type) {
		this.cyclic_type = cyclic_type;
	}
	public String getInterval_sequence() {
		return interval_sequence;
	}
	public void setInterval_sequence(String interval_sequence) {
		this.interval_sequence = interval_sequence;
	}
	public String getTolerance() {
		return tolerance;
	}
	public void setTolerance(String tolerance) {
		this.tolerance = tolerance;
	}
	public String getSpecific_times() {
		return specific_times;
	}
	public void setSpecific_times(String specific_times) {
		this.specific_times = specific_times;
	}
	public String getActive_from() {
		return active_from;
	}
	public void setActive_from(String active_from) {
		this.active_from = active_from;
	}
	public String getActive_till() {
		return active_till;
	}
	public void setActive_till(String active_till) {
		this.active_till = active_till;
	}
	public String getSet_cd() {
		return set_cd;
	}
	public void setSet_cd(String set_cd) {
		this.set_cd = set_cd;
	}
	public String getMax_doc_cd() {
		return max_doc_cd;
	}
	public void setMax_doc_cd(String max_doc_cd) {
		this.max_doc_cd = max_doc_cd;
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
	public String getConf_cal() {
		return conf_cal;
	}
	public void setConf_cal(String conf_cal) {
		this.conf_cal = conf_cal;
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
	public String getSr_code() {
		return sr_code;
	}
	public void setSr_code(String sr_code) {
		this.sr_code = sr_code;
	}
	public String getMonitor_time() {
		return monitor_time;
	}
	public void setMonitor_time(String monitor_time) {
		this.monitor_time = monitor_time;
	}
	public String getMonitor_interval() {
		return monitor_interval;
	}
	public void setMonitor_interval(String monitor_interval) {
		this.monitor_interval = monitor_interval;
	}
	public String getDoc_cd() {
		return doc_cd;
	}
	public void setDoc_cd(String doc_cd) {
		this.doc_cd = doc_cd;
	}
	public String getDoc_gb() {
		return doc_gb;
	}
	public void setDoc_gb(String doc_gb) {
		this.doc_gb = doc_gb;
	}
	public String getCur_approval_seq() {
		return cur_approval_seq;
	}
	public void setCur_approval_seq(String cur_approval_seq) {
		this.cur_approval_seq = cur_approval_seq;
	}
	public String getState_cd() {
		return state_cd;
	}
	public void setState_cd(String state_cd) {
		this.state_cd = state_cd;
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
	public String getUser_nm() {
		return user_nm;
	}
	public void setUser_nm(String user_nm) {
		this.user_nm = user_nm;
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
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
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
	public String getData_center() {
		return data_center;
	}
	public void setData_center(String data_center) {
		this.data_center = data_center;
	}
	public String getTable_name() {
		return table_name;
	}
	public void setTable_name(String table_name) {
		this.table_name = table_name;
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
	public String getMem_name() {
		return mem_name;
	}
	public void setMem_name(String mem_name) {
		this.mem_name = mem_name;
	}
	public String getJob_name() {
		return job_name;
	}
	public void setJob_name(String job_name) {
		this.job_name = job_name;
	}
	public String getTask_type() {
		return task_type;
	}
	public void setTask_type(String taskType) {
		task_type = taskType;
	}
	public String getUser_daily() {
		return user_daily;
	}
	public void setUser_daily(String userDaily) {
		user_daily = userDaily;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getOwner() {
		return owner;
	}
	public void setOwner(String owner) {
		this.owner = owner;
	}
	public String getAuthor() {
		return author;
	}
	public void setAuthor(String author) {
		this.author = author;
	}
	public String getMem_lib() {
		return mem_lib;
	}
	public void setMem_lib(String memLib) {
		mem_lib = memLib;
	}
	public String getCommand() {
		return command;
	}
	public void setCommand(String command) {
		this.command = command;
	}
	public String getIn_condition() {
		return in_condition;
	}
	public void setIn_condition(String inCondition) {
		in_condition = inCondition;
	}
	public String getOut_condition() {
		return out_condition;
	}
	public void setOut_condition(String outCondition) {
		out_condition = outCondition;
	}
	public String getFile_nm() {
		return file_nm;
	}
	public void setFile_nm(String fileNm) {
		file_nm = fileNm;
	}
	public String getSave_file_nm() {
		return save_file_nm;
	}
	public void setSave_file_nm(String saveFileNm) {
		save_file_nm = saveFileNm;
	}
	public String getFile_path() {
		return file_path;
	}
	public void setFile_path(String filePath) {
		file_path = filePath;
	}
	public String getData_center_name() {
		return data_center_name;
	}
	public void setData_center_name(String dataCenterName) {
		data_center_name = dataCenterName;
	}
	public String getPart_nm() {
		return part_nm;
	}
	public void setPart_nm(String partNm) {
		part_nm = partNm;
	}
	public String getApply_cd() {
		return apply_cd;
	}
	public void setApply_cd(String applyCd) {
		apply_cd = applyCd;
	}
	public String getCancel_comment() {
		return cancel_comment;
	}
	public void setCancel_comment(String cancelComment) {
		cancel_comment = cancelComment;
	}
	public String getApply_date() {
		return apply_date;
	}
	public void setApply_date(String applyDate) {
		apply_date = applyDate;
	}
	public String getFail_comment() {
		return fail_comment;
	}
	public void setFail_comment(String failComment) {
		fail_comment = failComment;
	}
	public String getApply_check() {
		return apply_check;
	}
	public void setApply_check(String applyCheck) {
		apply_check = applyCheck;
	}
	
}
