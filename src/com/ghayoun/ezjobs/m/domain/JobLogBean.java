package com.ghayoun.ezjobs.m.domain;

import java.io.Serializable;

public class JobLogBean implements Serializable {
	
	private int 	row_num 		= 0;
	private String active_gb		= "";
	private String start_time		= "";
	private String end_time         = "";
	private String rerun_counter    = "";
	private String order_table      = "";
	private String application      = "";
	private String group_name	  	= "";
	private String job_name         = "";
	private String memname          = "";
	private String state_result     = "";
	private String holdflag         = "";
	private String developer        = "";
	private String contact          = "";
	private String task_type        = "";
	private String order_id         = "";
	private String status           = "";
	private String odate            = "";
	private String description      = "";
	private String critical_yn      = "";
	private String state            = "";
	private String job_id           = "";
	private String node_id          = "";
	private String node_group       = "";
	private String from_time        = "";
	
	private String cm_log			= "";
	private String keystmp			= "";	 
	
	private String max_from_time	= "";
	private String avg_run_time		= "";
	private String avg_start_time	= "";
	private String avg_end_time		= "";
	private String min_run_time		= "";
	private String max_run_time		= "";
	private String min_start_time	= "";
	private String max_start_time	= "";
	private String min_end_time		= "";
	private String max_end_time		= "";	
	private String job_cnt			= "";
	
	private String s_odate			= "";
	private String e_odate			= "";
	
	private String state_result2	= "";
	
	private String jobgroup_id		= "";
	private String jobgroup_name	= "";
	private String content			= "";
	private String success			= "";
	private String fail				= "";
	private String wait				= "";
	private String running			= "";
	private String total_count		= "";
	private String user_nm			= "";
	
	private String data_center		= "";
	private String dept_nm			= "";
	private String calendar_nm		= "";
	private String jobschedgb		= "";
	private String sched_table		= "";
	
	private String user_daily		= "";
	
	private String user_id        	= "";
	private String user_id2        = "";
	private String user_id3        = "";
	private String user_id4        = "";
	private String user_id5        = "";
	private String user_id6        = "";
	private String user_id7        = "";
	private String user_id8        = "";
	private String user_id9        = "";
	private String user_id10        = "";
	
	private String set_value		= "";	
	private String gubun			= "";
	private String total_job_cnt	= "";
	private String daily_job_cnt	= "";
	private String susi_job_cnt		= "";
	private String ctm_daily_time	= "";
	
	private String total_cnt				= "";
	private String total_susi_cnt			= "";
	private String ended_ok_cnt				= "";
	private String ended_not_ok_cnt			= "";
	private String wait_cnt					= "";
	private String etc_cnt					= "";
	private String ended_ok_susi_cnt		= "";
	private String ended_not_ok_susi_cnt	= "";
	private String wait_susi_cnt			= "";
	private String etc_susi_cnt				= "";
	private String begin_month_cnt			= "";
	private String end_month_cnt			= "";
	private String begin_month_susi_cnt		= "";
	private String end_month_susi_cnt		= "";
	
	private String edw_total_cnt			= "";
	private String edw_total_susi_cnt		= "";
	private String edw_ended_ok_cnt			= "";
	private String edw_ended_not_ok_cnt		= "";
	private String edw_wait_cnt				= "";
	private String edw_etc_cnt				= "";
	private String edw_ended_ok_susi_cnt	= "";
	private String edw_ended_not_ok_susi_cnt= "";
	private String edw_wait_susi_cnt		= "";
	private String edw_etc_susi_cnt			= "";
	private String edw_begin_month_cnt		= "";
	private String edw_end_month_cnt		= "";
	private String edw_begin_month_susi_cnt	= "";
	private String edw_end_month_susi_cnt	= "";
	
	private String ifrs_total_cnt			= "";
	private String ifrs_total_susi_cnt		= "";
	private String ifrs_ended_ok_cnt			= "";
	private String ifrs_ended_not_ok_cnt		= "";
	private String ifrs_wait_cnt				= "";
	private String ifrs_etc_cnt				= "";
	private String ifrs_ended_ok_susi_cnt	= "";
	private String ifrs_ended_not_ok_susi_cnt= "";
	private String ifrs_wait_susi_cnt		= "";
	private String ifrs_etc_susi_cnt			= "";
	private String ifrs_begin_month_cnt		= "";
	private String ifrs_end_month_cnt		= "";
	private String ifrs_begin_month_susi_cnt	= "";
	private String ifrs_end_month_susi_cnt	= "";
	
	private String ais_total_cnt			= "";
	private String ais_total_susi_cnt		= "";
	private String ais_ended_ok_cnt			= "";
	private String ais_ended_not_ok_cnt		= "";
	private String ais_wait_cnt				= "";
	private String ais_etc_cnt				= "";
	private String ais_ended_ok_susi_cnt	= "";
	private String ais_ended_not_ok_susi_cnt= "";
	private String ais_wait_susi_cnt		= "";
	private String ais_etc_susi_cnt			= "";
	private String ais_begin_month_cnt		= "";
	private String ais_end_month_cnt		= "";
	private String ais_begin_month_susi_cnt	= "";
	private String ais_end_month_susi_cnt	= "";
	
	private String alm_total_cnt			= "";
	private String alm_total_susi_cnt		= "";
	private String alm_ended_ok_cnt			= "";
	private String alm_ended_not_ok_cnt		= "";
	private String alm_wait_cnt				= "";
	private String alm_etc_cnt				= "";
	private String alm_ended_ok_susi_cnt	= "";
	private String alm_ended_not_ok_susi_cnt= "";
	private String alm_wait_susi_cnt		= "";
	private String alm_etc_susi_cnt			= "";
	private String alm_begin_month_cnt		= "";
	private String alm_end_month_cnt		= "";
	private String alm_begin_month_susi_cnt	= "";
	private String alm_end_month_susi_cnt	= "";
	
	private String new_rdm_total_cnt			= "";
	private String new_rdm_total_susi_cnt		= "";
	private String new_rdm_ended_ok_cnt			= "";
	private String new_rdm_ended_not_ok_cnt		= "";
	private String new_rdm_wait_cnt				= "";
	private String new_rdm_etc_cnt				= "";
	private String new_rdm_ended_ok_susi_cnt	= "";
	private String new_rdm_ended_not_ok_susi_cnt= "";
	private String new_rdm_wait_susi_cnt		= "";
	private String new_rdm_etc_susi_cnt			= "";
	private String new_rdm_begin_month_cnt		= "";
	private String new_rdm_end_month_cnt		= "";
	private String new_rdm_begin_month_susi_cnt	= "";
	private String new_rdm_end_month_susi_cnt	= "";
	
	private String rba_total_cnt			= "";
	private String rba_total_susi_cnt		= "";
	private String rba_ended_ok_cnt			= "";
	private String rba_ended_not_ok_cnt		= "";
	private String rba_wait_cnt				= "";
	private String rba_etc_cnt				= "";
	private String rba_ended_ok_susi_cnt	= "";
	private String rba_ended_not_ok_susi_cnt= "";
	private String rba_wait_susi_cnt		= "";
	private String rba_etc_susi_cnt			= "";
	private String rba_begin_month_cnt		= "";
	private String rba_end_month_cnt		= "";
	private String rba_begin_month_susi_cnt	= "";
	private String rba_end_month_susi_cnt	= "";
	
	private String crs_total_cnt			= "";
	private String crs_total_susi_cnt		= "";
	private String crs_ended_ok_cnt			= "";
	private String crs_ended_not_ok_cnt		= "";
	private String crs_wait_cnt				= "";
	private String crs_etc_cnt				= "";
	private String crs_ended_ok_susi_cnt	= "";
	private String crs_ended_not_ok_susi_cnt= "";
	private String crs_wait_susi_cnt		= "";
	private String crs_etc_susi_cnt			= "";
	private String crs_begin_month_cnt		= "";
	private String crs_end_month_cnt		= "";
	private String crs_begin_month_susi_cnt	= "";
	private String crs_end_month_susi_cnt	= "";

	private String susi_developer			= "";
	private String susi_contact				= "";
	
	private String susi_cnt					= "";
	private String ins_nm1  				= "";
	private String approval_nm1  			= "";
	private String approval_nm2     		= "";

	private String sysout_yn 	    		= "";
	private String sysout 	    			= "";
	private String appl_type    			= "";
	
	private String late_exec				= "";
	
	private String smart_job_yn				= "";

	public String getSysout() { return sysout; }
	public void setSysout(String sysout) { this.sysout = sysout; }
	public String getSysout_yn() { return sysout_yn; }
	public void setSysout_yn(String sysout_yn) { this.sysout_yn = sysout_yn; }
	public String getUser_id9() { return user_id9; }
	public void setUser_id9(String user_id9) { this.user_id9 = user_id9; }
	public String getUser_id10() { return user_id10; }
	public void setUser_id10(String user_id10) { this.user_id10 = user_id10; }
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getUser_id2() {
		return user_id2;
	}
	public void setUser_id2(String user_id2) {
		this.user_id2 = user_id2;
	}
	public String getUser_id3() {
		return user_id3;
	}
	public void setUser_id3(String user_id3) {
		this.user_id3 = user_id3;
	}
	public String getUser_id4() {
		return user_id4;
	}
	public void setUser_id4(String user_id4) {
		this.user_id4 = user_id4;
	}
	public String getUser_id5() {
		return user_id5;
	}
	public void setUser_id5(String user_id5) {
		this.user_id5 = user_id5;
	}
	public String getUser_id6() {
		return user_id6;
	}
	public void setUser_id6(String user_id6) {
		this.user_id6 = user_id6;
	}
	public String getUser_id7() {
		return user_id7;
	}
	public void setUser_id7(String user_id7) {
		this.user_id7 = user_id7;
	}
	public String getUser_id8() {
		return user_id8;
	}
	public void setUser_id_(String user_id8) {
		this.user_id8 = user_id8;
	}
	public String getUser_daily() {
		return user_daily;
	}
	public void setUser_daily(String user_daily) {
		this.user_daily = user_daily;
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
	public String getRerun_counter() {
		return rerun_counter;
	}
	public void setRerun_counter(String rerun_counter) {
		this.rerun_counter = rerun_counter;
	}
	public String getOrder_table() {
		return order_table;
	}
	public void setOrder_table(String order_table) {
		this.order_table = order_table;
	}
	public String getApplication() {
		return application;
	}
	public void setApplication(String application) {
		this.application = application;
	}
	public String getJob_name() {
		return job_name;
	}
	public void setJob_name(String job_name) {
		this.job_name = job_name;
	}
	public String getState_result() {
		return state_result;
	}
	public void setState_result(String state_result) {
		this.state_result = state_result;
	}
	public String getHoldflag() {
		return holdflag;
	}
	public void setHoldflag(String holdflag) {
		this.holdflag = holdflag;
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
	public String getTask_type() {
		return task_type;
	}
	public void setTask_type(String task_type) {
		this.task_type = task_type;
	}
	public String getOrder_id() {
		return order_id;
	}
	public void setOrder_id(String order_id) {
		this.order_id = order_id;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getOdate() {
		return odate;
	}
	public void setOdate(String odate) {
		this.odate = odate;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getCritical_yn() {
		return critical_yn;
	}
	public void setCritical_yn(String critical_yn) {
		this.critical_yn = critical_yn;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getJob_id() {
		return job_id;
	}
	public void setJob_id(String job_id) {
		this.job_id = job_id;
	}
	public int getRow_num() {
		return row_num;
	}
	public void setRow_num(int row_num) {
		this.row_num = row_num;
	}
	public String getMemname() {
		return memname;
	}
	public void setMemname(String memname) {
		this.memname = memname;
	}
	public String getActive_gb() {
		return active_gb;
	}
	public void setActive_gb(String active_gb) {
		this.active_gb = active_gb;
	}
	public String getNode_id() {
		return node_id;
	}
	public void setNode_id(String node_id) {
		this.node_id = node_id;
	}
	public String getCm_log() {
		return cm_log;
	}
	public void setCm_log(String cmLog) {
		cm_log = cmLog;
	}
	public String getKeystmp() {
		return keystmp;
	}
	public void setKeystmp(String keystmp) {
		this.keystmp = keystmp;
	}
	public String getFrom_time() {
		return from_time;
	}
	public void setFrom_time(String fromTime) {
		from_time = fromTime;
	}
	public String getMax_from_time() {
		return max_from_time;
	}
	public void setMax_from_time(String maxFromTime) {
		max_from_time = maxFromTime;
	}
	public String getMin_run_time() {
		return min_run_time;
	}
	public void setMin_run_time(String minRunTime) {
		min_run_time = minRunTime;
	}
	public String getMax_run_time() {
		return max_run_time;
	}
	public void setMax_run_time(String maxRunTime) {
		max_run_time = maxRunTime;
	}
	public String getMin_start_time() {
		return min_start_time;
	}
	public void setMin_start_time(String minStartTime) {
		min_start_time = minStartTime;
	}
	public String getMax_start_time() {
		return max_start_time;
	}
	public void setMax_start_time(String maxStartTime) {
		max_start_time = maxStartTime;
	}
	public String getMin_end_time() {
		return min_end_time;
	}
	public void setMin_end_time(String minEndTime) {
		min_end_time = minEndTime;
	}
	public String getMax_end_time() {
		return max_end_time;
	}
	public void setMax_end_time(String maxEndTime) {
		max_end_time = maxEndTime;
	}
	public String getAvg_run_time() {
		return avg_run_time;
	}
	public void setAvg_run_time(String avgRunTime) {
		avg_run_time = avgRunTime;
	}
	public String getAvg_start_time() {
		return avg_start_time;
	}
	public void setAvg_start_time(String avgStartTime) {
		avg_start_time = avgStartTime;
	}
	public String getAvg_end_time() {
		return avg_end_time;
	}
	public void setAvg_end_time(String avgEndTime) {
		avg_end_time = avgEndTime;
	}
	public String getJob_cnt() {
		return job_cnt;
	}
	public void setJob_cnt(String jobCnt) {
		job_cnt = jobCnt;
	}
	public String getS_odate() {
		return s_odate;
	}
	public void setS_odate(String sOdate) {
		s_odate = sOdate;
	}
	public String getE_odate() {
		return e_odate;
	}
	public void setE_odate(String eOdate) {
		e_odate = eOdate;
	}
	public String getGroup_name() {
		return group_name;
	}
	public void setGroup_name(String groupName) {
		group_name = groupName;
	}
	public String getState_result2() {
		return state_result2;
	}
	public void setState_result2(String stateResult2) {
		state_result2 = stateResult2;
	}
	public String getJobgroup_id() {
		return jobgroup_id;
	}
	public void setJobgroup_id(String jobgroupId) {
		jobgroup_id = jobgroupId;
	}
	public String getJobgroup_name() {
		return jobgroup_name;
	}
	public void setJobgroup_name(String jobgroupName) {
		jobgroup_name = jobgroupName;
	}
	public String getSuccess() {
		return success;
	}
	public void setSuccess(String success) {
		this.success = success;
	}
	public String getFail() {
		return fail;
	}
	public void setFail(String fail) {
		this.fail = fail;
	}
	public String getWait() {
		return wait;
	}
	public void setWait(String wait) {
		this.wait = wait;
	}
	public String getRunning() {
		return running;
	}
	public void setRunning(String running) {
		this.running = running;
	}
	public String getTotal_count() {
		return total_count;
	}
	public void setTotal_count(String totalCount) {
		total_count = totalCount;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getUser_nm() {
		return user_nm;
	}
	public void setUser_nm(String userNm) {
		user_nm = userNm;
	}
	public String getData_center() {
		return data_center;
	}
	public void setData_center(String data_center) {
		this.data_center = data_center;
	}
	public String getDept_nm() {
		return dept_nm;
	}
	public void setDept_nm(String dept_nm) {
		this.dept_nm = dept_nm;
	}
	public String getCalendar_nm() {
		return calendar_nm;
	}
	public void setCalendar_nm(String calendar_nm) {
		this.calendar_nm = calendar_nm;
	}
	public String getJobschedgb() {
		return jobschedgb;
	}
	public void setJobschedgb(String jobschedgb) {
		this.jobschedgb = jobschedgb;
	}
	public String getSched_table() {
		return sched_table;
	}
	public void setSched_table(String sched_table) {
		this.sched_table = sched_table;
	}
	public String getSet_value() {
		return set_value;
	}
	public void setSet_value(String set_value) {
		this.set_value = set_value;
	}
	public String getGubun() {
		return gubun;
	}
	public void setGubun(String gubun) {
		this.gubun = gubun;
	}
	public String getTotal_job_cnt() {
		return total_job_cnt;
	}
	public void setTotal_job_cnt(String total_job_cnt) {
		this.total_job_cnt = total_job_cnt;
	}
	public String getDaily_job_cnt() {
		return daily_job_cnt;
	}
	public void setDaily_job_cnt(String daily_job_cnt) {
		this.daily_job_cnt = daily_job_cnt;
	}
	public String getSusi_job_cnt() {
		return susi_job_cnt;
	}
	public void setSusi_job_cnt(String susi_job_cnt) {
		this.susi_job_cnt = susi_job_cnt;
	}
	public String getCtm_daily_time() {
		return ctm_daily_time;
	}
	public void setCtm_daily_time(String ctm_daily_time) {
		this.ctm_daily_time = ctm_daily_time;
	}
	public String getTotal_cnt() {
		return total_cnt;
	}
	public void setTotal_cnt(String total_cnt) {
		this.total_cnt = total_cnt;
	}
	public String getTotal_susi_cnt() {
		return total_susi_cnt;
	}
	public void setTotal_susi_cnt(String total_susi_cnt) {
		this.total_susi_cnt = total_susi_cnt;
	}
	public String getEnded_ok_cnt() {
		return ended_ok_cnt;
	}
	public void setEnded_ok_cnt(String ended_ok_cnt) {
		this.ended_ok_cnt = ended_ok_cnt;
	}
	public String getEnded_not_ok_cnt() {
		return ended_not_ok_cnt;
	}
	public void setEnded_not_ok_cnt(String ended_not_ok_cnt) {
		this.ended_not_ok_cnt = ended_not_ok_cnt;
	}
	public String getWait_cnt() {
		return wait_cnt;
	}
	public void setWait_cnt(String wait_cnt) {
		this.wait_cnt = wait_cnt;
	}
	public String getEtc_cnt() {
		return etc_cnt;
	}
	public void setEtc_cnt(String etc_cnt) {
		this.etc_cnt = etc_cnt;
	}
	public String getEnded_ok_susi_cnt() {
		return ended_ok_susi_cnt;
	}
	public void setEnded_ok_susi_cnt(String ended_ok_susi_cnt) {
		this.ended_ok_susi_cnt = ended_ok_susi_cnt;
	}
	public String getEnded_not_ok_susi_cnt() {
		return ended_not_ok_susi_cnt;
	}
	public void setEnded_not_ok_susi_cnt(String ended_not_ok_susi_cnt) {
		this.ended_not_ok_susi_cnt = ended_not_ok_susi_cnt;
	}
	public String getWait_susi_cnt() {
		return wait_susi_cnt;
	}
	public void setWait_susi_cnt(String wait_susi_cnt) {
		this.wait_susi_cnt = wait_susi_cnt;
	}
	public String getEtc_susi_cnt() {
		return etc_susi_cnt;
	}
	public void setEtc_susi_cnt(String etc_susi_cnt) {
		this.etc_susi_cnt = etc_susi_cnt;
	}
	public String getBegin_month_cnt() {
		return begin_month_cnt;
	}
	public void setBegin_month_cnt(String begin_month_cnt) {
		this.begin_month_cnt = begin_month_cnt;
	}
	public String getEnd_month_cnt() {
		return end_month_cnt;
	}
	public void setEnd_month_cnt(String end_month_cnt) {
		this.end_month_cnt = end_month_cnt;
	}
	public String getBegin_month_susi_cnt() {
		return begin_month_susi_cnt;
	}
	public void setBegin_month_susi_cnt(String begin_month_susi_cnt) {
		this.begin_month_susi_cnt = begin_month_susi_cnt;
	}
	public String getEnd_month_susi_cnt() {
		return end_month_susi_cnt;
	}
	public void setEnd_month_susi_cnt(String end_month_susi_cnt) {
		this.end_month_susi_cnt = end_month_susi_cnt;
	}
	public String getEdw_total_cnt() {
		return edw_total_cnt;
	}
	public void setEdw_total_cnt(String edw_total_cnt) {
		this.edw_total_cnt = edw_total_cnt;
	}
	public String getEdw_total_susi_cnt() {
		return edw_total_susi_cnt;
	}
	public void setEdw_total_susi_cnt(String edw_total_susi_cnt) {
		this.edw_total_susi_cnt = edw_total_susi_cnt;
	}
	public String getEdw_ended_ok_cnt() {
		return edw_ended_ok_cnt;
	}
	public void setEdw_ended_ok_cnt(String edw_ended_ok_cnt) {
		this.edw_ended_ok_cnt = edw_ended_ok_cnt;
	}
	public String getEdw_ended_not_ok_cnt() {
		return edw_ended_not_ok_cnt;
	}
	public void setEdw_ended_not_ok_cnt(String edw_ended_not_ok_cnt) {
		this.edw_ended_not_ok_cnt = edw_ended_not_ok_cnt;
	}
	public String getEdw_wait_cnt() {
		return edw_wait_cnt;
	}
	public void setEdw_wait_cnt(String edw_wait_cnt) {
		this.edw_wait_cnt = edw_wait_cnt;
	}
	public String getEdw_etc_cnt() {
		return edw_etc_cnt;
	}
	public void setEdw_etc_cnt(String edw_etc_cnt) {
		this.edw_etc_cnt = edw_etc_cnt;
	}
	public String getEdw_ended_ok_susi_cnt() {
		return edw_ended_ok_susi_cnt;
	}
	public void setEdw_ended_ok_susi_cnt(String edw_ended_ok_susi_cnt) {
		this.edw_ended_ok_susi_cnt = edw_ended_ok_susi_cnt;
	}
	public String getEdw_ended_not_ok_susi_cnt() {
		return edw_ended_not_ok_susi_cnt;
	}
	public void setEdw_ended_not_ok_susi_cnt(String edw_ended_not_ok_susi_cnt) {
		this.edw_ended_not_ok_susi_cnt = edw_ended_not_ok_susi_cnt;
	}
	public String getEdw_wait_susi_cnt() {
		return edw_wait_susi_cnt;
	}
	public void setEdw_wait_susi_cnt(String edw_wait_susi_cnt) {
		this.edw_wait_susi_cnt = edw_wait_susi_cnt;
	}
	public String getEdw_etc_susi_cnt() {
		return edw_etc_susi_cnt;
	}
	public void setEdw_etc_susi_cnt(String edw_etc_susi_cnt) {
		this.edw_etc_susi_cnt = edw_etc_susi_cnt;
	}
	public String getEdw_begin_month_cnt() {
		return edw_begin_month_cnt;
	}
	public void setEdw_begin_month_cnt(String edw_begin_month_cnt) {
		this.edw_begin_month_cnt = edw_begin_month_cnt;
	}
	public String getEdw_end_month_cnt() {
		return edw_end_month_cnt;
	}
	public void setEdw_end_month_cnt(String edw_end_month_cnt) {
		this.edw_end_month_cnt = edw_end_month_cnt;
	}
	public String getEdw_begin_month_susi_cnt() {
		return edw_begin_month_susi_cnt;
	}
	public void setEdw_begin_month_susi_cnt(String edw_begin_month_susi_cnt) {
		this.edw_begin_month_susi_cnt = edw_begin_month_susi_cnt;
	}
	public String getEdw_end_month_susi_cnt() {
		return edw_end_month_susi_cnt;
	}
	public void setEdw_end_month_susi_cnt(String edw_end_month_susi_cnt) {
		this.edw_end_month_susi_cnt = edw_end_month_susi_cnt;
	}
	public String getIfrs_total_cnt() {
		return ifrs_total_cnt;
	}
	public void setIfrs_total_cnt(String ifrs_total_cnt) {
		this.ifrs_total_cnt = ifrs_total_cnt;
	}
	public String getIfrs_total_susi_cnt() {
		return ifrs_total_susi_cnt;
	}
	public void setIfrs_total_susi_cnt(String ifrs_total_susi_cnt) {
		this.ifrs_total_susi_cnt = ifrs_total_susi_cnt;
	}
	public String getIfrs_ended_ok_cnt() {
		return ifrs_ended_ok_cnt;
	}
	public void setIfrs_ended_ok_cnt(String ifrs_ended_ok_cnt) {
		this.ifrs_ended_ok_cnt = ifrs_ended_ok_cnt;
	}
	public String getIfrs_ended_not_ok_cnt() {
		return ifrs_ended_not_ok_cnt;
	}
	public void setIfrs_ended_not_ok_cnt(String ifrs_ended_not_ok_cnt) {
		this.ifrs_ended_not_ok_cnt = ifrs_ended_not_ok_cnt;
	}
	public String getIfrs_wait_cnt() {
		return ifrs_wait_cnt;
	}
	public void setIfrs_wait_cnt(String ifrs_wait_cnt) {
		this.ifrs_wait_cnt = ifrs_wait_cnt;
	}
	public String getIfrs_etc_cnt() {
		return ifrs_etc_cnt;
	}
	public void setIfrs_etc_cnt(String ifrs_etc_cnt) {
		this.ifrs_etc_cnt = ifrs_etc_cnt;
	}
	public String getIfrs_ended_ok_susi_cnt() {
		return ifrs_ended_ok_susi_cnt;
	}
	public void setIfrs_ended_ok_susi_cnt(String ifrs_ended_ok_susi_cnt) {
		this.ifrs_ended_ok_susi_cnt = ifrs_ended_ok_susi_cnt;
	}
	public String getIfrs_ended_not_ok_susi_cnt() {
		return ifrs_ended_not_ok_susi_cnt;
	}
	public void setIfrs_ended_not_ok_susi_cnt(String ifrs_ended_not_ok_susi_cnt) {
		this.ifrs_ended_not_ok_susi_cnt = ifrs_ended_not_ok_susi_cnt;
	}
	public String getIfrs_wait_susi_cnt() {
		return ifrs_wait_susi_cnt;
	}
	public void setIfrs_wait_susi_cnt(String ifrs_wait_susi_cnt) {
		this.ifrs_wait_susi_cnt = ifrs_wait_susi_cnt;
	}
	public String getIfrs_etc_susi_cnt() {
		return ifrs_etc_susi_cnt;
	}
	public void setIfrs_etc_susi_cnt(String ifrs_etc_susi_cnt) {
		this.ifrs_etc_susi_cnt = ifrs_etc_susi_cnt;
	}
	public String getIfrs_begin_month_cnt() {
		return ifrs_begin_month_cnt;
	}
	public void setIfrs_begin_month_cnt(String ifrs_begin_month_cnt) {
		this.ifrs_begin_month_cnt = ifrs_begin_month_cnt;
	}
	public String getIfrs_end_month_cnt() {
		return ifrs_end_month_cnt;
	}
	public void setIfrs_end_month_cnt(String ifrs_end_month_cnt) {
		this.ifrs_end_month_cnt = ifrs_end_month_cnt;
	}
	public String getIfrs_begin_month_susi_cnt() {
		return ifrs_begin_month_susi_cnt;
	}
	public void setIfrs_begin_month_susi_cnt(String ifrs_begin_month_susi_cnt) {
		this.ifrs_begin_month_susi_cnt = ifrs_begin_month_susi_cnt;
	}
	public String getIfrs_end_month_susi_cnt() {
		return ifrs_end_month_susi_cnt;
	}
	public void setIfrs_end_month_susi_cnt(String ifrs_end_month_susi_cnt) {
		this.ifrs_end_month_susi_cnt = ifrs_end_month_susi_cnt;
	}
	public String getAis_total_cnt() {
		return ais_total_cnt;
	}
	public void setAis_total_cnt(String ais_total_cnt) {
		this.ais_total_cnt = ais_total_cnt;
	}
	public String getAis_total_susi_cnt() {
		return ais_total_susi_cnt;
	}
	public void setAis_total_susi_cnt(String ais_total_susi_cnt) {
		this.ais_total_susi_cnt = ais_total_susi_cnt;
	}
	public String getAis_ended_ok_cnt() {
		return ais_ended_ok_cnt;
	}
	public void setAis_ended_ok_cnt(String ais_ended_ok_cnt) {
		this.ais_ended_ok_cnt = ais_ended_ok_cnt;
	}
	public String getAis_ended_not_ok_cnt() {
		return ais_ended_not_ok_cnt;
	}
	public void setAis_ended_not_ok_cnt(String ais_ended_not_ok_cnt) {
		this.ais_ended_not_ok_cnt = ais_ended_not_ok_cnt;
	}
	public String getAis_wait_cnt() {
		return ais_wait_cnt;
	}
	public void setAis_wait_cnt(String ais_wait_cnt) {
		this.ais_wait_cnt = ais_wait_cnt;
	}
	public String getAis_etc_cnt() {
		return ais_etc_cnt;
	}
	public void setAis_etc_cnt(String ais_etc_cnt) {
		this.ais_etc_cnt = ais_etc_cnt;
	}
	public String getAis_ended_ok_susi_cnt() {
		return ais_ended_ok_susi_cnt;
	}
	public void setAis_ended_ok_susi_cnt(String ais_ended_ok_susi_cnt) {
		this.ais_ended_ok_susi_cnt = ais_ended_ok_susi_cnt;
	}
	public String getAis_ended_not_ok_susi_cnt() {
		return ais_ended_not_ok_susi_cnt;
	}
	public void setAis_ended_not_ok_susi_cnt(String ais_ended_not_ok_susi_cnt) {
		this.ais_ended_not_ok_susi_cnt = ais_ended_not_ok_susi_cnt;
	}
	public String getAis_wait_susi_cnt() {
		return ais_wait_susi_cnt;
	}
	public void setAis_wait_susi_cnt(String ais_wait_susi_cnt) {
		this.ais_wait_susi_cnt = ais_wait_susi_cnt;
	}
	public String getAis_etc_susi_cnt() {
		return ais_etc_susi_cnt;
	}
	public void setAis_etc_susi_cnt(String ais_etc_susi_cnt) {
		this.ais_etc_susi_cnt = ais_etc_susi_cnt;
	}
	public String getAis_begin_month_cnt() {
		return ais_begin_month_cnt;
	}
	public void setAis_begin_month_cnt(String ais_begin_month_cnt) {
		this.ais_begin_month_cnt = ais_begin_month_cnt;
	}
	public String getAis_end_month_cnt() {
		return ais_end_month_cnt;
	}
	public void setAis_end_month_cnt(String ais_end_month_cnt) {
		this.ais_end_month_cnt = ais_end_month_cnt;
	}
	public String getAis_begin_month_susi_cnt() {
		return ais_begin_month_susi_cnt;
	}
	public void setAis_begin_month_susi_cnt(String ais_begin_month_susi_cnt) {
		this.ais_begin_month_susi_cnt = ais_begin_month_susi_cnt;
	}
	public String getAis_end_month_susi_cnt() {
		return ais_end_month_susi_cnt;
	}
	public void setAis_end_month_susi_cnt(String ais_end_month_susi_cnt) {
		this.ais_end_month_susi_cnt = ais_end_month_susi_cnt;
	}
	public String getAlm_total_cnt() {
		return alm_total_cnt;
	}
	public void setAlm_total_cnt(String alm_total_cnt) {
		this.alm_total_cnt = alm_total_cnt;
	}
	public String getAlm_total_susi_cnt() {
		return alm_total_susi_cnt;
	}
	public void setAlm_total_susi_cnt(String alm_total_susi_cnt) {
		this.alm_total_susi_cnt = alm_total_susi_cnt;
	}
	public String getAlm_ended_ok_cnt() {
		return alm_ended_ok_cnt;
	}
	public void setAlm_ended_ok_cnt(String alm_ended_ok_cnt) {
		this.alm_ended_ok_cnt = alm_ended_ok_cnt;
	}
	public String getAlm_ended_not_ok_cnt() {
		return alm_ended_not_ok_cnt;
	}
	public void setAlm_ended_not_ok_cnt(String alm_ended_not_ok_cnt) {
		this.alm_ended_not_ok_cnt = alm_ended_not_ok_cnt;
	}
	public String getAlm_wait_cnt() {
		return alm_wait_cnt;
	}
	public void setAlm_wait_cnt(String alm_wait_cnt) {
		this.alm_wait_cnt = alm_wait_cnt;
	}
	public String getAlm_etc_cnt() {
		return alm_etc_cnt;
	}
	public void setAlm_etc_cnt(String alm_etc_cnt) {
		this.alm_etc_cnt = alm_etc_cnt;
	}
	public String getAlm_ended_ok_susi_cnt() {
		return alm_ended_ok_susi_cnt;
	}
	public void setAlm_ended_ok_susi_cnt(String alm_ended_ok_susi_cnt) {
		this.alm_ended_ok_susi_cnt = alm_ended_ok_susi_cnt;
	}
	public String getAlm_ended_not_ok_susi_cnt() {
		return alm_ended_not_ok_susi_cnt;
	}
	public void setAlm_ended_not_ok_susi_cnt(String alm_ended_not_ok_susi_cnt) {
		this.alm_ended_not_ok_susi_cnt = alm_ended_not_ok_susi_cnt;
	}
	public String getAlm_wait_susi_cnt() {
		return alm_wait_susi_cnt;
	}
	public void setAlm_wait_susi_cnt(String alm_wait_susi_cnt) {
		this.alm_wait_susi_cnt = alm_wait_susi_cnt;
	}
	public String getAlm_etc_susi_cnt() {
		return alm_etc_susi_cnt;
	}
	public void setAlm_etc_susi_cnt(String alm_etc_susi_cnt) {
		this.alm_etc_susi_cnt = alm_etc_susi_cnt;
	}
	public String getAlm_begin_month_cnt() {
		return alm_begin_month_cnt;
	}
	public void setAlm_begin_month_cnt(String alm_begin_month_cnt) {
		this.alm_begin_month_cnt = alm_begin_month_cnt;
	}
	public String getAlm_end_month_cnt() {
		return alm_end_month_cnt;
	}
	public void setAlm_end_month_cnt(String alm_end_month_cnt) {
		this.alm_end_month_cnt = alm_end_month_cnt;
	}
	public String getAlm_begin_month_susi_cnt() {
		return alm_begin_month_susi_cnt;
	}
	public void setAlm_begin_month_susi_cnt(String alm_begin_month_susi_cnt) {
		this.alm_begin_month_susi_cnt = alm_begin_month_susi_cnt;
	}
	public String getAlm_end_month_susi_cnt() {
		return alm_end_month_susi_cnt;
	}
	public void setAlm_end_month_susi_cnt(String alm_end_month_susi_cnt) {
		this.alm_end_month_susi_cnt = alm_end_month_susi_cnt;
	}
	public String getNew_rdm_total_cnt() {
		return new_rdm_total_cnt;
	}
	public void setNew_rdm_total_cnt(String new_rdm_total_cnt) {
		this.new_rdm_total_cnt = new_rdm_total_cnt;
	}
	public String getNew_rdm_total_susi_cnt() {
		return new_rdm_total_susi_cnt;
	}
	public void setNew_rdm_total_susi_cnt(String new_rdm_total_susi_cnt) {
		this.new_rdm_total_susi_cnt = new_rdm_total_susi_cnt;
	}
	public String getNew_rdm_ended_ok_cnt() {
		return new_rdm_ended_ok_cnt;
	}
	public void setNew_rdm_ended_ok_cnt(String new_rdm_ended_ok_cnt) {
		this.new_rdm_ended_ok_cnt = new_rdm_ended_ok_cnt;
	}
	public String getNew_rdm_ended_not_ok_cnt() {
		return new_rdm_ended_not_ok_cnt;
	}
	public void setNew_rdm_ended_not_ok_cnt(String new_rdm_ended_not_ok_cnt) {
		this.new_rdm_ended_not_ok_cnt = new_rdm_ended_not_ok_cnt;
	}
	public String getNew_rdm_wait_cnt() {
		return new_rdm_wait_cnt;
	}
	public void setNew_rdm_wait_cnt(String new_rdm_wait_cnt) {
		this.new_rdm_wait_cnt = new_rdm_wait_cnt;
	}
	public String getNew_rdm_etc_cnt() {
		return new_rdm_etc_cnt;
	}
	public void setNew_rdm_etc_cnt(String new_rdm_etc_cnt) {
		this.new_rdm_etc_cnt = new_rdm_etc_cnt;
	}
	public String getNew_rdm_ended_ok_susi_cnt() {
		return new_rdm_ended_ok_susi_cnt;
	}
	public void setNew_rdm_ended_ok_susi_cnt(String new_rdm_ended_ok_susi_cnt) {
		this.new_rdm_ended_ok_susi_cnt = new_rdm_ended_ok_susi_cnt;
	}
	public String getNew_rdm_ended_not_ok_susi_cnt() {
		return new_rdm_ended_not_ok_susi_cnt;
	}
	public void setNew_rdm_ended_not_ok_susi_cnt(String new_rdm_ended_not_ok_susi_cnt) {
		this.new_rdm_ended_not_ok_susi_cnt = new_rdm_ended_not_ok_susi_cnt;
	}
	public String getNew_rdm_wait_susi_cnt() {
		return new_rdm_wait_susi_cnt;
	}
	public void setNew_rdm_wait_susi_cnt(String new_rdm_wait_susi_cnt) {
		this.new_rdm_wait_susi_cnt = new_rdm_wait_susi_cnt;
	}
	public String getNew_rdm_etc_susi_cnt() {
		return new_rdm_etc_susi_cnt;
	}
	public void setNew_rdm_etc_susi_cnt(String new_rdm_etc_susi_cnt) {
		this.new_rdm_etc_susi_cnt = new_rdm_etc_susi_cnt;
	}
	public String getNew_rdm_begin_month_cnt() {
		return new_rdm_begin_month_cnt;
	}
	public void setNew_rdm_begin_month_cnt(String new_rdm_begin_month_cnt) {
		this.new_rdm_begin_month_cnt = new_rdm_begin_month_cnt;
	}
	public String getNew_rdm_end_month_cnt() {
		return new_rdm_end_month_cnt;
	}
	public void setNew_rdm_end_month_cnt(String new_rdm_end_month_cnt) {
		this.new_rdm_end_month_cnt = new_rdm_end_month_cnt;
	}
	public String getNew_rdm_begin_month_susi_cnt() {
		return new_rdm_begin_month_susi_cnt;
	}
	public void setNew_rdm_begin_month_susi_cnt(String new_rdm_begin_month_susi_cnt) {
		this.new_rdm_begin_month_susi_cnt = new_rdm_begin_month_susi_cnt;
	}
	public String getNew_rdm_end_month_susi_cnt() {
		return new_rdm_end_month_susi_cnt;
	}
	public void setNew_rdm_end_month_susi_cnt(String new_rdm_end_month_susi_cnt) {
		this.new_rdm_end_month_susi_cnt = new_rdm_end_month_susi_cnt;
	}
	public String getRba_total_cnt() {
		return rba_total_cnt;
	}
	public void setRba_total_cnt(String rba_total_cnt) {
		this.rba_total_cnt = rba_total_cnt;
	}
	public String getRba_total_susi_cnt() {
		return rba_total_susi_cnt;
	}
	public void setRba_total_susi_cnt(String rba_total_susi_cnt) {
		this.rba_total_susi_cnt = rba_total_susi_cnt;
	}
	public String getRba_ended_ok_cnt() {
		return rba_ended_ok_cnt;
	}
	public void setRba_ended_ok_cnt(String rba_ended_ok_cnt) {
		this.rba_ended_ok_cnt = rba_ended_ok_cnt;
	}
	public String getRba_ended_not_ok_cnt() {
		return rba_ended_not_ok_cnt;
	}
	public void setRba_ended_not_ok_cnt(String rba_ended_not_ok_cnt) {
		this.rba_ended_not_ok_cnt = rba_ended_not_ok_cnt;
	}
	public String getRba_wait_cnt() {
		return rba_wait_cnt;
	}
	public void setRba_wait_cnt(String rba_wait_cnt) {
		this.rba_wait_cnt = rba_wait_cnt;
	}
	public String getRba_etc_cnt() {
		return rba_etc_cnt;
	}
	public void setRba_etc_cnt(String rba_etc_cnt) {
		this.rba_etc_cnt = rba_etc_cnt;
	}
	public String getRba_ended_ok_susi_cnt() {
		return rba_ended_ok_susi_cnt;
	}
	public void setRba_ended_ok_susi_cnt(String rba_ended_ok_susi_cnt) {
		this.rba_ended_ok_susi_cnt = rba_ended_ok_susi_cnt;
	}
	public String getRba_ended_not_ok_susi_cnt() {
		return rba_ended_not_ok_susi_cnt;
	}
	public void setRba_ended_not_ok_susi_cnt(String rba_ended_not_ok_susi_cnt) {
		this.rba_ended_not_ok_susi_cnt = rba_ended_not_ok_susi_cnt;
	}
	public String getRba_wait_susi_cnt() {
		return rba_wait_susi_cnt;
	}
	public void setRba_wait_susi_cnt(String rba_wait_susi_cnt) {
		this.rba_wait_susi_cnt = rba_wait_susi_cnt;
	}
	public String getRba_etc_susi_cnt() {
		return rba_etc_susi_cnt;
	}
	public void setRba_etc_susi_cnt(String rba_etc_susi_cnt) {
		this.rba_etc_susi_cnt = rba_etc_susi_cnt;
	}
	public String getRba_begin_month_cnt() {
		return rba_begin_month_cnt;
	}
	public void setRba_begin_month_cnt(String rba_begin_month_cnt) {
		this.rba_begin_month_cnt = rba_begin_month_cnt;
	}
	public String getRba_end_month_cnt() {
		return rba_end_month_cnt;
	}
	public void setRba_end_month_cnt(String rba_end_month_cnt) {
		this.rba_end_month_cnt = rba_end_month_cnt;
	}
	public String getRba_begin_month_susi_cnt() {
		return rba_begin_month_susi_cnt;
	}
	public void setRba_begin_month_susi_cnt(String rba_begin_month_susi_cnt) {
		this.rba_begin_month_susi_cnt = rba_begin_month_susi_cnt;
	}
	public String getRba_end_month_susi_cnt() {
		return rba_end_month_susi_cnt;
	}
	public void setRba_end_month_susi_cnt(String rba_end_month_susi_cnt) {
		this.rba_end_month_susi_cnt = rba_end_month_susi_cnt;
	}
	public String getCrs_total_cnt() {
		return crs_total_cnt;
	}
	public void setCrs_total_cnt(String crs_total_cnt) {
		this.crs_total_cnt = crs_total_cnt;
	}
	public String getCrs_total_susi_cnt() {
		return crs_total_susi_cnt;
	}
	public void setCrs_total_susi_cnt(String crs_total_susi_cnt) {
		this.crs_total_susi_cnt = crs_total_susi_cnt;
	}
	public String getCrs_ended_ok_cnt() {
		return crs_ended_ok_cnt;
	}
	public void setCrs_ended_ok_cnt(String crs_ended_ok_cnt) {
		this.crs_ended_ok_cnt = crs_ended_ok_cnt;
	}
	public String getCrs_ended_not_ok_cnt() {
		return crs_ended_not_ok_cnt;
	}
	public void setCrs_ended_not_ok_cnt(String crs_ended_not_ok_cnt) {
		this.crs_ended_not_ok_cnt = crs_ended_not_ok_cnt;
	}
	public String getCrs_wait_cnt() {
		return crs_wait_cnt;
	}
	public void setCrs_wait_cnt(String crs_wait_cnt) {
		this.crs_wait_cnt = crs_wait_cnt;
	}
	public String getCrs_etc_cnt() {
		return crs_etc_cnt;
	}
	public void setCrs_etc_cnt(String crs_etc_cnt) {
		this.crs_etc_cnt = crs_etc_cnt;
	}
	public String getCrs_ended_ok_susi_cnt() {
		return crs_ended_ok_susi_cnt;
	}
	public void setCrs_ended_ok_susi_cnt(String crs_ended_ok_susi_cnt) {
		this.crs_ended_ok_susi_cnt = crs_ended_ok_susi_cnt;
	}
	public String getCrs_ended_not_ok_susi_cnt() {
		return crs_ended_not_ok_susi_cnt;
	}
	public void setCrs_ended_not_ok_susi_cnt(String crs_ended_not_ok_susi_cnt) {
		this.crs_ended_not_ok_susi_cnt = crs_ended_not_ok_susi_cnt;
	}
	public String getCrs_wait_susi_cnt() {
		return crs_wait_susi_cnt;
	}
	public void setCrs_wait_susi_cnt(String crs_wait_susi_cnt) {
		this.crs_wait_susi_cnt = crs_wait_susi_cnt;
	}
	public String getCrs_etc_susi_cnt() {
		return crs_etc_susi_cnt;
	}
	public void setCrs_etc_susi_cnt(String crs_etc_susi_cnt) {
		this.crs_etc_susi_cnt = crs_etc_susi_cnt;
	}
	public String getCrs_begin_month_cnt() {
		return crs_begin_month_cnt;
	}
	public void setCrs_begin_month_cnt(String crs_begin_month_cnt) {
		this.crs_begin_month_cnt = crs_begin_month_cnt;
	}
	public String getCrs_end_month_cnt() {
		return crs_end_month_cnt;
	}
	public void setCrs_end_month_cnt(String crs_end_month_cnt) {
		this.crs_end_month_cnt = crs_end_month_cnt;
	}
	public String getCrs_begin_month_susi_cnt() {
		return crs_begin_month_susi_cnt;
	}
	public void setCrs_begin_month_susi_cnt(String crs_begin_month_susi_cnt) {
		this.crs_begin_month_susi_cnt = crs_begin_month_susi_cnt;
	}
	public String getCrs_end_month_susi_cnt() {
		return crs_end_month_susi_cnt;
	}
	public void setCrs_end_month_susi_cnt(String crs_end_month_susi_cnt) {
		this.crs_end_month_susi_cnt = crs_end_month_susi_cnt;
	}
	public String getSusi_developer() {
		return susi_developer;
	}
	public void setSusi_developer(String susi_developer) {
		this.susi_developer = susi_developer;
	}
	public String getSusi_contact() {
		return susi_contact;
	}
	public void setSusi_contact(String susi_contact) {
		this.susi_contact = susi_contact;
	}
	public void setUser_id8(String user_id8) {
		this.user_id8 = user_id8;
	}
	public String getSusi_cnt() {
		return susi_cnt;
	}
	public void setSusi_cnt(String susi_cnt) {
		this.susi_cnt = susi_cnt;
	}
	public String getApproval_nm1() {
		return approval_nm1;
	}
	public void setApproval_nm1(String approval_nm1) {
		this.approval_nm1 = approval_nm1;
	}
	public String getApproval_nm2() {
		return approval_nm2;
	}
	public void setApproval_nm2(String approval_nm2) {
		this.approval_nm2 = approval_nm2;
	}
	public String getIns_nm1() {
		return ins_nm1;
	}
	public void setIns_nm1(String ins_nm1) {
		this.ins_nm1 = ins_nm1;
	}
	public String getAppl_type() {
		return appl_type;
	}
	public void setAppl_type(String appl_type) {
		this.appl_type = appl_type;
	}
	public String getNode_group() {
		return node_group;
	}
	public void setNode_group(String node_group) {
		this.node_group = node_group;
	}
	public String getLate_exec() {
		return late_exec;
	}
	public void setLate_exec(String late_exec) {
		this.late_exec = late_exec;
	}
	public String getSmart_job_yn() {
		return smart_job_yn;
	}
	public void setSmart_job_yn(String smart_job_yn) {
		this.smart_job_yn = smart_job_yn;
	}
        
}
