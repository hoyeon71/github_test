package com.ghayoun.ezjobs.m.domain;

import java.io.Serializable;

public class DefJobBean implements Serializable {

	private int row_num 		= 0;
	private int grid_idx 		= 0;
	
	private String sched_table 			= "";
	private String table_id 			= "";
	private String application 			= "";
	private String group_name 			= "";
	private String job_name 			= "";
	private String memname 				= "";
	private String from_time 			= "";
	private String days_cal 			= "";
	private String day_str 				= "";
	private String cmd_line 			= "";
	private String w_day_str 			= "";
	private String weeks_cal 			= "";
	private String job_id 				= "";
	private String monthstr 			= "";
	private String description 			= "";
	private String ins_date 			= "";
	private String mapper_description 	= "";
	private String critical_yn 			= "";
	
	private String owner 				= "";
	private String task_type 			= "";
	private String node_grp 			= "";
	private String mem_lib 				= "";
	private String to_time 				= "";
	private String confirm 				= "";
	private String cyclic 				= "";
	private String dates_str 			= "";
	private String incondname 			= "";
	private String outcondname 			= "";

	private String days_and_or 			= "";
	private String confirm_flag 		= "";
	private String max_wait 			= "";
	private String in_condition 		= "";
	private String out_condition 		= "";
	private String user_nm		 		= "";
	private String user_hp 				= "";
	private String user_tel 			= "";
	private String dept_nm		 		= "";
	
	private String avg_start_time 		= "";
	private String avg_run_time 		= "";
	
	private String status 				= "";
	private String in_cond_name			= "";
	private String out_cond_name		= "";
	private String not_run_odate		= "";
	
	private String author				= "";
	
	
	private String priority    			= "";
	private String rerun_max    		= "";
	private String rerun_interval    	= "";
	private String count_cyclic_from    = "";
	private String specific_times       = "";
	private String interval_sequence    = "";
	private String cyclic_type          = "";
	
	
	private String in_strOdate  		= "";
	private String out_strOdate   		= "";
	
	private String in_sign    			= "";
	private String out_sign    			= "";
	
	private String late_sub    			= "";
	private String late_time    		= "";
	private String late_exec    		= "";
	private String when_cond			= "";
	private String message				= "";
	private String shout_time			= "";
	
	private String srNo 	            = "";
	private String chargePmNm 	        = "";
	private String projectManMonth 	    = "";
	private String projectNm 	        = "";
	private String srNonAttachedReason 	= "";
	private String batchjobGrade 	    = "";
	private String error_description 	= "";
	private String user_nm_2 	        = "";
	private String user_nm_3 	        = "";
	private String user_nm_4 	        = "";
	private String user_nm_5 	        = "";
	private String user_nm_6 	        = "";
	private String user_nm_7 	        = "";
	private String user_nm_8 	        = "";
	private String user_nm_9 	        = "";
	private String user_nm_10 	        = "";
	private String user_cd_2 	        = "";
	private String user_cd_3 	        = "";
	private String user_cd_4 	        = "";
	private String user_cd_5 	        = "";
	private String user_cd_6 	        = "";
	private String user_cd_7 	        = "";
	private String user_cd_8 	        = "";
	private String user_cd_9 	        = "";
	private String user_cd_10 	        = "";
	private String user_id_2 	        = "";
	private String user_id_3 	        = "";
	private String user_id_4 	        = "";
	private String user_id_5 	        = "";
	private String user_id_6 	        = "";
	private String user_id_7 	        = "";
	private String user_id_8 	        = "";
	private String user_id_9 	        = "";
	private String user_id_10 	        = "";

	private String globalcond_yn 	    = "";
	private String online_impect_yn 	= "";
	private String user_impect_yn 	    = "";
	private String concerned 	        = "";
	private String update_detail 	    = "";
	private String end_user             = "";
	private String moneybatchjob        = "";
	private String calendar_nm          = "";
	
	private String data_destination     = "";
	
	private String	jobTypeGb 			= "";
	private String	jobSchedGb 			= "";
	private String	argument 			= "";
	private String	mcode_nm 			= "";
	private String	scode_nm			= "";				
	private String	systemGb			= "";
	
	private String	monitor_time		= "";				
	private String	monitor_interval	= "";
	private String 	node_id 			= "";
	
	private String creation_time 		= "";
	
	private String active_from		 	= "";
	private String active_till		 	= "";
	private String ref_table		 	= "";
	private String cc_yn		 		= "";
	private String cc_count		 		= "";
	private String success_sms_yn 		= "";
	
	private String out_yn 				= "";
	private String in_yn 				= "";
	private String ums_yn 				= "";
	
	private String standard_sysout		= "";
	private String verification_yn		= "";
	
	private String sms_1				= "";
	private String sms_2				= "";
	private String sms_3				= "";
	private String sms_4				= "";
	private String sms_5				= "";
	private String sms_6				= "";
	private String sms_7				= "";
	private String sms_8				= "";
	private String sms_9				= "";
	private String sms_10				= "";

	private String mail_1				= "";
	private String mail_2				= "";
	private String mail_3				= "";
	private String mail_4				= "";
	private String mail_5				= "";
	private String mail_6				= "";
	private String mail_7				= "";
	private String mail_8				= "";
	private String mail_9				= "";
	private String mail_10				= "";

	private String ind_cyclic			= "";
	private String tolerance			= "";
	
	private String month_days     	   	= "";
	private String month_1 		     	= "";
	private String month_2 		     	= "";
	private String month_3 		     	= "";
	private String month_4 		     	= "";
	private String month_5 		    	= "";
	private String month_6 		    	= "";
	private String month_7 		    	= "";
	private String month_8 		    	= "";
	private String month_9 		    	= "";
	private String month_10 		 	= "";
	private String month_11 			= "";
	private String month_12 		 	= "";
	private String schedule_and_or  	= "";
	private String week_days 		 	= "";
	private String total_cnt			= "";
	
	private String prev_doc_info		= "";
	private String user_daily			= "";

	private String user_nm2 	    	= "";
	private String data_center 			= "";
	
	private String grp_cd_1 	   		= "";
	private String grp_cd_2 	    	= "";
	private String grp_nm_1 	    	= "";
	private String grp_nm_2 	    	= "";
	private String grp_sms_1			= "";
	private String grp_sms_2			= "";
	private String grp_mail_1			= "";
	private String grp_mail_2			= "";
	
	private String cmjob_transfer		= "";
	private String smart_job_yn			= "";
	
	private String conf_cal				= "";
	private String shift				= "";
	private String shift_num			= "";
	
	private String Nodeid				= "";
	
	private String doc_state			= "";
	
	private String appl_type			= "";

	public String getUser_nm_9() { return user_nm_9; }
	public void setUser_nm_9(String user_nm_9) { this.user_nm_9 = user_nm_9; }
	public String getUser_nm_10() { return user_nm_10; }
	public void setUser_nm_10(String user_nm_10) { this.user_nm_10 = user_nm_10; }
	public String getUser_cd_9() { return user_cd_9; }
	public void setUser_cd_9(String user_cd_9) { this.user_cd_9 = user_cd_9; }
	public String getUser_cd_10() { return user_cd_10; }
	public void setUser_cd_10(String user_cd_10) { this.user_cd_10 = user_cd_10; }
	public String getSms_9() { return sms_9; }
	public void setSms_9(String sms_9) { this.sms_9 = sms_9; }
	public String getSms_10() { return sms_10; }
	public void setSms_10(String sms_10) { this.sms_10 = sms_10; 	}
	public String getMail_9() { return mail_9; }
	public void setMail_9(String mail_9) { this.mail_9 = mail_9; }
	public String getMail_10() { return mail_10; }
	public void setMail_10(String mail_10) { this.mail_10 = mail_10; }
	public String getGrp_cd_1() { return grp_cd_1; }
	public void setGrp_cd_1(String grp_cd_1) { this.grp_cd_1 = grp_cd_1; }
	public String getGrp_cd_2() { return grp_cd_2; }
	public void setGrp_cd_2(String grp_cd_2) { this.grp_cd_2 = grp_cd_2; }
	public String getGrp_nm_1() { return grp_nm_1; }
	public void setGrp_nm_1(String grp_nm_1) { this.grp_nm_1 = grp_nm_1; }
	public String getGrp_nm_2() { return grp_nm_2; }
	public void setGrp_nm_2(String grp_nm_2) { this.grp_nm_2 = grp_nm_2; }
	public String getGrp_sms_1() { return grp_sms_1; }
	public void setGrp_sms_1(String grp_sms_1) { this.grp_sms_1 = grp_sms_1; }
	public String getGrp_sms_2() { return grp_sms_2; }
	public void setGrp_sms_2(String grp_sms_2) { this.grp_sms_2 = grp_sms_2; }
	public String getGrp_mail_1() { return grp_mail_1; }
	public void setGrp_mail_1(String grp_mail_1) { this.grp_mail_1 = grp_mail_1; }
	public String getGrp_mail_2() { return grp_mail_2; }
	public void setGrp_mail_2(String grp_mail_2) { this.grp_mail_2 = grp_mail_2;}

	public String getUser_daily() {
		return user_daily;
	}
	public void setUser_daily(String user_daily) {
		this.user_daily = user_daily;
	}
	public String getPrev_doc_info() {
		return prev_doc_info;
	}
	public void setPrev_doc_info(String prev_doc_info) {
		this.prev_doc_info = prev_doc_info;
	}
	
	public String getTotal_cnt() {
		return total_cnt;
	}
	public void setTotal_cnt(String total_cnt) {
		this.total_cnt = total_cnt;
	}
	public String getSpecific_times() {
		return specific_times;
	}
	public void setSpecific_times(String specific_times) {
		this.specific_times = specific_times;
	}
	public String getInterval_sequence() {
		return interval_sequence;
	}
	public void setInterval_sequence(String interval_sequence) {
		this.interval_sequence = interval_sequence;
	}
	public String getCyclic_type() {
		return cyclic_type;
	}
	public void setCyclic_type(String cyclic_type) {
		this.cyclic_type = cyclic_type;
	}
	public String getStandard_sysout() {
		return standard_sysout;
	}
	public void setStandard_sysout(String standard_sysout) {
		this.standard_sysout = standard_sysout;
	}
	public String getVerification_yn() {
		return verification_yn;
	}
	public void setVerification_yn(String verification_yn) {
		this.verification_yn = verification_yn;
	}
	public String getIns_date() {
		return ins_date;
	}
	public void setIns_date(String ins_date) {
		this.ins_date = ins_date;
	}
	public int getRow_num() {
		return row_num;
	}
	public void setRow_num(int row_num) {
		this.row_num = row_num;
	}
	public String getSched_table() {
		return sched_table;
	}
	public void setSched_table(String sched_table) {
		this.sched_table = sched_table;
	}
	public String getTable_id() {
		return table_id;
	}
	public void setTable_id(String table_id) {
		this.table_id = table_id;
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
	public String getJob_name() {
		return job_name;
	}
	public void setJob_name(String job_name) {
		this.job_name = job_name;
	}
	public String getMemname() {
		return memname;
	}
	public void setMemname(String memname) {
		this.memname = memname;
	}
	public String getFrom_time() {
		return from_time;
	}
	public void setFrom_time(String from_time) {
		this.from_time = from_time;
	}
	public String getDays_cal() {
		return days_cal;
	}
	public void setDays_cal(String days_cal) {
		this.days_cal = days_cal;
	}
	public String getDay_str() {
		return day_str;
	}
	public void setDay_str(String day_str) {
		this.day_str = day_str;
	}
	public String getCmd_line() {
		return cmd_line;
	}
	public void setCmd_line(String cmd_line) {
		this.cmd_line = cmd_line;
	}
	public String getW_day_str() {
		return w_day_str;
	}
	public void setW_day_str(String w_day_str) {
		this.w_day_str = w_day_str;
	}
	public String getWeeks_cal() {
		return weeks_cal;
	}
	public void setWeeks_cal(String weeks_cal) {
		this.weeks_cal = weeks_cal;
	}
	public String getJob_id() {
		return job_id;
	}
	public void setJob_id(String job_id) {
		this.job_id = job_id;
	}
	public String getMonthstr() {
		return monthstr;
	}
	public void setMonthstr(String monthstr) {
		this.monthstr = monthstr;
	}
	public String getOwner() {
		return owner;
	}
	public void setOwner(String owner) {
		this.owner = owner;
	}
	public String getTask_type() {
		return task_type;
	}
	public void setTask_type(String task_type) {
		this.task_type = task_type;
	}
	public String getNode_grp() {
		return node_grp;
	}
	public void setNode_grp(String node_grp) {
		this.node_grp = node_grp;
	}
	public String getMem_lib() {
		return mem_lib;
	}
	public void setMem_lib(String mem_lib) {
		this.mem_lib = mem_lib;
	}
	public String getTo_time() {
		return to_time;
	}
	public void setTo_time(String to_time) {
		this.to_time = to_time;
	}
	public String getConfirm() {
		return confirm;
	}
	public void setConfirm(String confirm) {
		this.confirm = confirm;
	}
	public String getCyclic() {
		return cyclic;
	}
	public void setCyclic(String cyclic) {
		this.cyclic = cyclic;
	}
	public String getIncondname() {
		return incondname;
	}
	public void setIncondname(String incondname) {
		this.incondname = incondname;
	}
	public String getOutcondname() {
		return outcondname;
	}
	public void setOutcondname(String outcondname) {
		this.outcondname = outcondname;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getDates_str() {
		return dates_str;
	}
	public void setDates_str(String dates_str) {
		this.dates_str = dates_str;
	}
	public String getConfirm_flag() {
		return confirm_flag;
	}
	public void setConfirm_flag(String confirmFlag) {
		confirm_flag = confirmFlag;
	}
	public String getMax_wait() {
		return max_wait;
	}
	public void setMax_wait(String maxWait) {
		max_wait = maxWait;
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
	public String getDays_and_or() {
		return days_and_or;
	}
	public void setDays_and_or(String daysAndOr) {
		days_and_or = daysAndOr;
	}
	public String getMapper_description() {
		return mapper_description;
	}
	public void setMapper_description(String mapperDescription) {
		mapper_description = mapperDescription;
	}
	public String getUser_nm() {
		return user_nm;
	}
	public void setUser_nm(String userNm) {
		user_nm = userNm;
	}
	public String getUser_hp() {
		return user_hp;
	}
	public void setUser_hp(String userHp) {
		user_hp = userHp;
	}
	public String getCritical_yn() {
		return critical_yn;
	}
	public void setCritical_yn(String criticalYn) {
		critical_yn = criticalYn;
	}
	public String getUser_tel() {
		return user_tel;
	}
	public void setUser_tel(String userTel) {
		user_tel = userTel;
	}
	public String getAvg_start_time() {
		return avg_start_time;
	}
	public void setAvg_start_time(String avgStartTime) {
		avg_start_time = avgStartTime;
	}
	public String getAvg_run_time() {
		return avg_run_time;
	}
	public void setAvg_run_time(String avgRunTime) {
		avg_run_time = avgRunTime;
	}
	public String getDept_nm() {
		return dept_nm;
	}
	public void setDept_nm(String deptNm) {
		dept_nm = deptNm;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getOut_cond_name() {
		return out_cond_name;
	}
	public void setOut_cond_name(String outCondName) {
		out_cond_name = outCondName;
	}
	public String getNot_run_odate() {
		return not_run_odate;
	}
	public void setNot_run_odate(String notRunOdate) {
		not_run_odate = notRunOdate;
	}
	public String getIn_cond_name() {
		return in_cond_name;
	}
	public void setIn_cond_name(String inCondName) {
		in_cond_name = inCondName;
	}
	public int getGrid_idx() {
		return grid_idx;
	}
	public void setGrid_idx(int grid_idx) {
		this.grid_idx = grid_idx;
	}
	public String getPriority() {
		return priority;
	}
	public void setPriority(String priority) {
		this.priority = priority;
	}
	public String getRerun_max() {
		return rerun_max;
	}
	public void setRerun_max(String rerunMax) {
		rerun_max = rerunMax;
	}
	public String getRerun_interval() {
		return rerun_interval;
	}
	public void setRerun_interval(String rerunInterval) {
		rerun_interval = rerunInterval;
	}
	public String getCount_cyclic_from() {
		return count_cyclic_from;
	}
	public void setCount_cyclic_from(String countCyclicFrom) {
		count_cyclic_from = countCyclicFrom;
	}
	public String getAuthor() {
		return author;
	}
	public void setAuthor(String author) {
		this.author = author;
	}
	public String getIn_strOdate() {
		return in_strOdate;
	}
	public void setIn_strOdate(String inStrOdate) {
		in_strOdate = inStrOdate;
	}
	public String getOut_strOdate() {
		return out_strOdate;
	}
	public void setOut_strOdate(String outStrOdate) {
		out_strOdate = outStrOdate;
	}
	public String getIn_sign() {
		return in_sign;
	}
	public void setIn_sign(String inSign) {
		in_sign = inSign;
	}
	public String getOut_sign() {
		return out_sign;
	}
	public void setOut_sign(String outSign) {
		out_sign = outSign;
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
	public String getSrNo() {
		return srNo;
	}
	public void setSrNo(String srNo) {
		this.srNo = srNo;
	}
	public String getChargePmNm() {
		return chargePmNm;
	}
	public void setChargePmNm(String chargePmNm) {
		this.chargePmNm = chargePmNm;
	}
	public String getProjectManMonth() {
		return projectManMonth;
	}
	public void setProjectManMonth(String projectManMonth) {
		this.projectManMonth = projectManMonth;
	}
	public String getProjectNm() {
		return projectNm;
	}
	public void setProjectNm(String projectNm) {
		this.projectNm = projectNm;
	}
	public String getSrNonAttachedReason() {
		return srNonAttachedReason;
	}
	public void setSrNonAttachedReason(String srNonAttachedReason) {
		this.srNonAttachedReason = srNonAttachedReason;
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
	public String getEnd_user() {
		return end_user;
	}
	public void setEnd_user(String end_user) {
		this.end_user = end_user;
	}
	public String getMoneybatchjob() {
		return moneybatchjob;
	}
	public void setMoneybatchjob(String moneybatchjob) {
		this.moneybatchjob = moneybatchjob;
	}
	public String getCalendar_nm() {
		return calendar_nm;
	}
	public void setCalendar_nm(String calendar_nm) {
		this.calendar_nm = calendar_nm;
	}
	public String getJobTypeGb() {
		return jobTypeGb;
	}
	public void setJobTypeGb(String jobTypeGb) {
		this.jobTypeGb = jobTypeGb;
	}
	public String getJobSchedGb() {
		return jobSchedGb;
	}
	public void setJobSchedGb(String jobSchedGb) {
		this.jobSchedGb = jobSchedGb;
	}
	public String getArgument() {
		return argument;
	}
	public void setArgument(String argument) {
		this.argument = argument;
	}
	public String getMcode_nm() {
		return mcode_nm;
	}
	public void setMcode_nm(String mcode_nm) {
		this.mcode_nm = mcode_nm;
	}
	public String getScode_nm() {
		return scode_nm;
	}
	public void setScode_nm(String scode_nm) {
		this.scode_nm = scode_nm;
	}
	public String getSystemGb() {
		return systemGb;
	}
	public void setSystemGb(String systemGb) {
		this.systemGb = systemGb;
	}
	public String getData_destination() {
		return data_destination;
	}
	public void setData_destination(String data_destination) {
		this.data_destination = data_destination;
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
	public String getNode_id() {
		return node_id;
	}
	public void setNode_id(String node_id) {
		this.node_id = node_id;
	}
	public String getCreation_time() {
		return creation_time;
	}
	public void setCreation_time(String creation_time) {
		this.creation_time = creation_time;
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
	public String getRef_table() {
		return ref_table;
	}
	public void setRef_table(String ref_table) {
		this.ref_table = ref_table;
	}
	public String getCc_yn() {
		return cc_yn;
	}
	public void setCc_yn(String cc_yn) {
		this.cc_yn = cc_yn;
	}
	public String getCc_count() {
		return cc_count;
	}
	public void setCc_count(String cc_count) {
		this.cc_count = cc_count;
	}
	public String getSuccess_sms_yn() {
		return success_sms_yn;
	}
	public void setSuccess_sms_yn(String success_sms_yn) {
		this.success_sms_yn = success_sms_yn;
	}
	public String getOut_yn() {
		return out_yn;
	}
	public void setOut_yn(String out_yn) {
		this.out_yn = out_yn;
	}
	public String getIn_yn() {
		return in_yn;
	}
	public void setIn_yn(String in_yn) {
		this.in_yn = in_yn;
	}
	public String getUms_yn() {
		return ums_yn;
	}
	public void setUms_yn(String ums_yn) {
		this.ums_yn = ums_yn;
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
	public String getInd_cyclic() {
		return ind_cyclic;
	}
	public void setInd_cyclic(String ind_cyclic) {
		this.ind_cyclic = ind_cyclic;
	}
	public String getTolerance() {
		return tolerance;
	}
	public void setTolerance(String tolerance) {
		this.tolerance = tolerance;
	}
	public String getMonth_days() {
		return month_days;
	}
	public void setMonth_days(String month_days) {
		this.month_days = month_days;
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
	public String getSchedule_and_or() {
		return schedule_and_or;
	}
	public void setSchedule_and_or(String schedule_and_or) {
		this.schedule_and_or = schedule_and_or;
	}
	public String getWeek_days() {
		return week_days;
	}
	public void setWeek_days(String week_days) {
		this.week_days = week_days;
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
	public String getUser_nm_5() {
		return user_nm_5;
	}
	public void setUser_nm_5(String user_nm_5) {
		this.user_nm_5 = user_nm_5;
	}
	public String getUser_nm_6() {
		return user_nm_6;
	}
	public void setUser_nm_6(String user_nm_6) {
		this.user_nm_6 = user_nm_6;
	}
	public String getUser_nm_7() {
		return user_nm_7;
	}
	public void setUser_nm_7(String user_nm_7) {
		this.user_nm_7 = user_nm_7;
	}
	public String getUser_nm_8() {
		return user_nm_8;
	}
	public void setUser_nm_8(String user_nm_8) {
		this.user_nm_8 = user_nm_8;
	}
	public String getUser_nm2() {
		return user_nm2;
	}
	public void setUser_nm2(String user_nm2) {
		this.user_nm2 = user_nm2;
	}
	public String getWhen_cond() {
		return when_cond;
	}
	public void setWhen_cond(String when_cond) {
		this.when_cond = when_cond;
	}
	public String getShout_time() {
		return shout_time;
	}
	public void setShout_time(String shout_time) {
		this.shout_time = shout_time;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public String getData_center() {
		return data_center;
	}
	public void setData_center(String data_center) {
		this.data_center = data_center;
	}
	public String getUser_id_2() {
		return user_id_2;
	}
	public void setUser_id_2(String user_id_2) {
		this.user_id_2 = user_id_2;
	}
	public String getUser_id_3() {
		return user_id_3;
	}
	public void setUser_id_3(String user_id_3) {
		this.user_id_3 = user_id_3;
	}
	public String getUser_id_4() {
		return user_id_4;
	}
	public void setUser_id_4(String user_id_4) {
		this.user_id_4 = user_id_4;
	}
	public String getUser_id_5() {
		return user_id_5;
	}
	public void setUser_id_5(String user_id_5) {
		this.user_id_5 = user_id_5;
	}
	public String getUser_id_6() {
		return user_id_6;
	}
	public void setUser_id_6(String user_id_6) {
		this.user_id_6 = user_id_6;
	}
	public String getUser_id_7() {
		return user_id_7;
	}
	public void setUser_id_7(String user_id_7) {
		this.user_id_7 = user_id_7;
	}
	public String getUser_id_8() {
		return user_id_8;
	}
	public void setUser_id_8(String user_id_8) {
		this.user_id_8 = user_id_8;
	}
	public String getUser_id_9() {
		return user_id_9;
	}
	public void setUser_id_9(String user_id_9) {
		this.user_id_9 = user_id_9;
	}
	public String getUser_id_10() {
		return user_id_10;
	}
	public void setUser_id_10(String user_id_10) {
		this.user_id_10 = user_id_10;
	}
	public String getNodeid() {
		return Nodeid;
	}
	public void setNodeid(String nodeid) {
		Nodeid = nodeid;
	}
	public String getCmjob_transfer() {
		return cmjob_transfer;
	}
	public void setCmjob_transfer(String cmjob_transfer) {
		this.cmjob_transfer = cmjob_transfer;
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
	public String getSmart_job_yn() {
		return smart_job_yn;
	}
	public void setSmart_job_yn(String smart_job_yn) {
		this.smart_job_yn = smart_job_yn;
	}
	public String getDoc_state() {
		return doc_state;
	}
	public void setDoc_state(String doc_state) {
		this.doc_state = doc_state;
	}
	public String getAppl_type() {
		return appl_type;
	}
	public void setAppl_type(String appl_type) {
		this.appl_type = appl_type;
	}
	
	
}
