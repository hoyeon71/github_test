package com.ghayoun.ezjobs.t.domain;

import java.io.Serializable;

public class Doc02Bean implements Serializable {
	
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
	private String data_center_name	      = "";
	private String table_name             = "";
	private String application            = "";
	private String group_name             = "";
	private String mem_name               = "";
	private String job_name               = "";
	private String description            = "";
	private String owner                  = "";
	private String priority               = "";
	private String critical               = "";
	private String task_type              = "";
	private String cyclic                 = "";
	private String node_id                = "";
	private String rerun_interval         = "";
	private String rerun_interval_time    = "";
	private String mem_lib                = "";
	private String command                = "";
	private String confirm_flag           = "";
	private String max_wait               = "";
	private String rerun_max              = "";
	private String time_from              = "";
	private String time_until             = "";
	private String count_cyclic_from      = "";
	private String time_zone              = "";
	private String multiagent             = "";
	private String in_conditions_opt      = "";
	
	private String t_conditions_in 			= "";
	private String t_conditions_out 		= "";
	private String t_resources_q 			= "";
	private String t_resources_c 			= "";
	private String t_set 					= "";
	private String t_steps 					= "";
	private String t_postproc 				= "";
	private String t_tag_name	 			= "";
	
	private String cyclic_type	 			= "";	
	private String interval_sequence		= "";
	private String tolerance				= "";	
	private String specific_times			= "";	
	
	private String file_nm				= "";
	private String save_file_nm			= "";
	private String file_path			= "";
	
	private String t_general_date		= "";
	
	private String s_apply_date			= "";
	private String e_apply_date			= "";
	private String apply_cd				= "";
	private String cancel_comment		= "";
	private String fail_comment			= "";
	
	private String late_sub				= "";
	private String late_time			= "";
	private String late_exec			= "";
	
	private String sr_code				= "";
	private String author = "";
	private String batchjobGrade = "";
	private String error_description = "";
	private String user_cd_2 = "";
	private String user_cd_3 = "";
	private String user_cd_4 = "";
	private String globalcond_yn = "";
	private String online_impect_yn = "";
	private String user_impect_yn = "";
	private String concerned = "";
	private String update_detail = "";
	private String data_destination = "";
	private String end_user = "";

	private String user_nm2 = "";
	private String user_nm3 = "";
	private String user_nm4 = "";
	
	private String susitype = "";
	private String attach_file = "";	
	private String job_cnt = "";
	private String state_nm = "";
	private String draft_date = "";
	private String approval_date = "";
	private String argument = "";
	private String act_gb = "";
	
	private String status 		= "";
	private String ajob_status 	= "";
	
	private String apply_date 	= "";
	
	private String systemgb 	= "";
	private String susitype_nm 	= "";
	
	private String money_batch_yn 		= "";
	private String job_grade	 		= "";
	private String job_grade_nm	 		= "";
	private String systemgb_nm	 		= "";
	
	public String getSr_code() {
		return sr_code;
	}
	public void setSr_code(String sr_code) {
		this.sr_code = sr_code;
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
	public String getTask_type() {
		return task_type;
	}
	public void setTask_type(String task_type) {
		this.task_type = task_type;
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
	public String getMem_lib() {
		return mem_lib;
	}
	public void setMem_lib(String mem_lib) {
		this.mem_lib = mem_lib;
	}
	public String getCommand() {
		return command;
	}
	public void setCommand(String command) {
		this.command = command;
	}
	public String getConfirm_flag() {
		return confirm_flag;
	}
	public void setConfirm_flag(String confirm_flag) {
		this.confirm_flag = confirm_flag;
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
	public String getIn_conditions_opt() {
		return in_conditions_opt;
	}
	public void setIn_conditions_opt(String in_conditions_opt) {
		this.in_conditions_opt = in_conditions_opt;
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
	public String getT_tag_name() {
		return t_tag_name;
	}
	public void setT_tag_name(String tTagName) {
		t_tag_name = tTagName;
	}
	public String getCyclic_type() {
		return cyclic_type;
	}
	public void setCyclic_type(String cyclicType) {
		cyclic_type = cyclicType;
	}
	public String getInterval_sequence() {
		return interval_sequence;
	}
	public void setInterval_sequence(String intervalSequence) {
		interval_sequence = intervalSequence;
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
	public void setSpecific_times(String specificTimes) {
		specific_times = specificTimes;
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
	public String getT_general_date() {
		return t_general_date;
	}
	public void setT_general_date(String tGeneralDate) {
		t_general_date = tGeneralDate;
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
	public String getFail_comment() {
		return fail_comment;
	}
	public void setFail_comment(String failComment) {
		fail_comment = failComment;
	}
	public String getS_apply_date() {
		return s_apply_date;
	}
	public void setS_apply_date(String sApplyDate) {
		s_apply_date = sApplyDate;
	}
	public String getE_apply_date() {
		return e_apply_date;
	}
	public void setE_apply_date(String eApplyDate) {
		e_apply_date = eApplyDate;
	}
	public String getLate_sub() {
		return late_sub;
	}
	public void setLate_sub(String lateSub) {
		late_sub = lateSub;
	}
	public String getLate_time() {
		return late_time;
	}
	public void setLate_time(String lateTime) {
		late_time = lateTime;
	}
	public String getLate_exec() {
		return late_exec;
	}
	public void setLate_exec(String lateExec) {
		late_exec = lateExec;
	}
	public String getAuthor() {
		return author;
	}
	public void setAuthor(String author) {
		this.author = author;
	}
	public String getBatchjobGrade() {
		return batchjobGrade;
	}
	public void setBatchjobGrade(String batchjobGrade) {
		this.batchjobGrade = batchjobGrade;
	}
	public String getError_description() {
		return error_description;
	}
	public void setError_description(String error_description) {
		this.error_description = error_description;
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
	public String getGlobalcond_yn() {
		return globalcond_yn;
	}
	public void setGlobalcond_yn(String globalcond_yn) {
		this.globalcond_yn = globalcond_yn;
	}
	public String getOnline_impect_yn() {
		return online_impect_yn;
	}
	public void setOnline_impect_yn(String online_impect_yn) {
		this.online_impect_yn = online_impect_yn;
	}
	public String getUser_impect_yn() {
		return user_impect_yn;
	}
	public void setUser_impect_yn(String user_impect_yn) {
		this.user_impect_yn = user_impect_yn;
	}
	public String getConcerned() {
		return concerned;
	}
	public void setConcerned(String concerned) {
		this.concerned = concerned;
	}
	public String getUpdate_detail() {
		return update_detail;
	}
	public void setUpdate_detail(String update_detail) {
		this.update_detail = update_detail;
	}
	public String getData_destination() {
		return data_destination;
	}
	public void setData_destination(String data_destination) {
		this.data_destination = data_destination;
	}
	public String getEnd_user() {
		return end_user;
	}
	public void setEnd_user(String end_user) {
		this.end_user = end_user;
	}
	public String getUser_nm2() {
		return user_nm2;
	}
	public void setUser_nm2(String user_nm2) {
		this.user_nm2 = user_nm2;
	}
	public String getUser_nm3() {
		return user_nm3;
	}
	public void setUser_nm3(String user_nm3) {
		this.user_nm3 = user_nm3;
	}
	public String getUser_nm4() {
		return user_nm4;
	}
	public void setUser_nm4(String user_nm4) {
		this.user_nm4 = user_nm4;
	}

	public String getSusitype() {
		return susitype;
	}
	public void setSusitype(String susitype) {
		this.susitype = susitype;
	}
	public String getAttach_file() {
		return attach_file;
	}
	public void setAttach_file(String attach_file) {
		this.attach_file = attach_file;
	}
	public String getJob_cnt() {
		return job_cnt;
	}
	public void setJob_cnt(String job_cnt) {
		this.job_cnt = job_cnt;
	}
	public String getState_nm() {
		return state_nm;
	}
	public void setState_nm(String state_nm) {
		this.state_nm = state_nm;
	}
	public String getDraft_date() {
		return draft_date;
	}
	public void setDraft_date(String draft_date) {
		this.draft_date = draft_date;
	}
	public String getApproval_date() {
		return approval_date;
	}
	public void setApproval_date(String approval_date) {
		this.approval_date = approval_date;
	}
	public String getArgument() {
		return argument;
	}
	public void setArgument(String argument) {
		this.argument = argument;
	}
	public String getAct_gb() {
		return act_gb;
	}
	public void setAct_gb(String act_gb) {
		this.act_gb = act_gb;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getAjob_status() {
		return ajob_status;
	}
	public void setAjob_status(String ajob_status) {
		this.ajob_status = ajob_status;
	}
	public String getApply_date() {
		return apply_date;
	}
	public void setApply_date(String apply_date) {
		this.apply_date = apply_date;
	}
	public String getSystemgb() {
		return systemgb;
	}
	public void setSystemgb(String systemgb) {
		this.systemgb = systemgb;
	}
	public String getSusitype_nm() {
		return susitype_nm;
	}
	public void setSusitype_nm(String susitype_nm) {
		this.susitype_nm = susitype_nm;
	}
	public String getMoney_batch_yn() {
		return money_batch_yn;
	}
	public void setMoney_batch_yn(String money_batch_yn) {
		this.money_batch_yn = money_batch_yn;
	}
	public String getJob_grade() {
		return job_grade;
	}
	public void setJob_grade(String job_grade) {
		this.job_grade = job_grade;
	}
	public String getJob_grade_nm() {
		return job_grade_nm;
	}
	public void setJob_grade_nm(String job_grade_nm) {
		this.job_grade_nm = job_grade_nm;
	}
	public String getSystemgb_nm() {
		return systemgb_nm;
	}
	public void setSystemgb_nm(String systemgb_nm) {
		this.systemgb_nm = systemgb_nm;
	}
	
}
