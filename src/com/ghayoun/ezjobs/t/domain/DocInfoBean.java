package com.ghayoun.ezjobs.t.domain;

import java.io.Serializable;

public class DocInfoBean implements Serializable {
	
	private int row_num 					= 0;
	
	private String doc_cd					= "";
	private String doc_gb					= "";
	private String user_cd					= "";
	private String user_id					= "";
	private String user_nm					= "";
	private String dept_cd					= "";
	private String dept_nm					= "";
	private String duty_cd					= "";
	private String duty_nm					= "";
	private String part_nm					= "";
	private String cur_approval_seq		= "";
	private String state_cd				= "";
	private String draft_date       		= "";
	private String approval_cd				= "";
	private String approval_date			= "";
	
	private String title					= "";
	private String job_name				= "";

	private String del_yn       			= "";
	private String ins_date    			= "";
	private String ins_user_cd  			= "";
	private String ins_user_ip  			= "";
	private String udt_date     			= "";
	private String udt_user_cd  			= "";
	private String udt_user_ip  			= "";
	
	private String description				= "";
	
	private String data_center				= "";
	private String data_center_name		= "";
	
	private String table_id				= "";
	private String job_id					= "";

	private String doc_group_id			= "";
	
	private String task_type				= "";
	private String apply_cd				= "";
	private String apply_date				= "";
	private String apply_check				= "";
	private String cancel_comment			= "";
	private String fail_comment			= "";
	private String userToken				= "";
	private String table_name				= "";
	private String s_apply_date			= "";
	private String e_apply_date			= "";
	private String ctm_odate				= "";
	private String main_doc_cd				= "";

	private String line_user_nm1			= "";
	private String line_user_nm2			= "";
	private String line_user_nm3			= "";

	private String sr_code 					= "";
	
	private String post_approval_yn 		= "";
	
	private String s_cnt 					= "";
	private String e_cnt 					= "";
	private String w_cnt 					= "";
	private String r_cnt 					= "";
	private String total_cnt 				= "";
	private String fail_cnt 				= "";

	private String status 					= "";
	private String ajob_status 				= "";
	private String application 				= "";
	private String sched_table 				= "";
	private String group_name 				= "";
	private String job_count 				= "";
	
	private String moneybatchjob    		= "";
	private String batchjobgrade    		= "";
	private String time_from       			= "";
	private String money_batch_yn   		= "";
	private int	   batchjobgradecnt 		= 0;
	private String first_batchjobgrade   	= "";
	private String all_batchjobgrade   		= "";
	private String line_approval   			= "";
	private String return_line_approval   	= "";
	private String critical		   			= "";
	private String odate		   			= "";
	private String search_apply_date		= "";
	
	//2020.08.04 조회화면에 작업종류,결재자,결재일자,반려자,반려일자 컬럼 추가(approval_date는 기존 컬럼 사용)
	private String jobschedgb				= "";
	private String approval_user_nm			= "";
	private String reject_user_nm			= "";
	private String reject_date				= "";
	private String reject_comment			= "";

	//정기,비정기 정의 컬럼 추가(전북은행 22.11.03)
	private String user_daily				= "";
	
	private String after_status				= "";
	private String from_time				= "";
	private String order_id					= "";
	
	private String user_hp					= "";
	
	private String detail_status			= "";
	private String alarm_user				= "";
	private String task_nm_detail			= "";

	private String apply_fail_cnt			= "";
	private String apply_success_cnt		= "";
	//main_doc_cd 내의 문서 카운트하기 위해 추가
	private String doc_cnt					= "";
	//일괄요청서 파라미터 추가
	private String hold_yn					= "";
	private String force_yn					= "";
	private String t_set					= "";
	private String order_date				= "";
	private String before_status			= "";
	private String ori_doc_gb				= "";

	//오류처리요청서 파라미터 추가
	private String alarm_cd					= "";
	private String error_description		= "";

	//임계시간 관련 파라미터 추가
	private String when_cond				= "";
	private String shout_time				= "";
	private String apply_exe_date			= "";

	public String getApply_exe_date() { return apply_exe_date; }
	public void setApply_exe_date(String apply_exe_date) { this.apply_exe_date = apply_exe_date; }
	public String getWhen_cond() { return when_cond; }
	public void setWhen_cond(String when_cond) { this.when_cond = when_cond; 	}
	public String getShout_time() { return shout_time; }
	public void setShout_time(String shout_time) { this.shout_time = shout_time; }
	public String getAlarm_cd() { return alarm_cd; }
	public void setAlarm_cd(String alarm_cd) { this.alarm_cd = alarm_cd; }
	public String getError_description() { return error_description; }
	public void setError_description(String error_description) { this.error_description = error_description; }
	public String getT_set() { return t_set; }
	public void setT_set(String t_set) { this.t_set = t_set; }
	public String getOri_doc_gb() { return ori_doc_gb; }
	public void setOri_doc_gb(String ori_doc_gb) { this.ori_doc_gb = ori_doc_gb; }
	public String getForce_yn() { return force_yn; }
	public void setForce_yn(String force_yn) { this.force_yn = force_yn; }
	public String getOrder_date() { return order_date; }
	public void setOrder_date(String order_date) { this.order_date = order_date; }
	public String getBefore_status() { return before_status; }
	public void setBefore_status(String before_status) { this.before_status = before_status; }
	public String getHold_yn() { return hold_yn; }
	public void setHold_yn(String hold_yn) { this.hold_yn = hold_yn; }
	public String getDoc_cnt() { return doc_cnt; }
	public void setDoc_cnt(String doc_cnt) { this.doc_cnt = doc_cnt; }
	public String getApply_fail_cnt() { return apply_fail_cnt; }
	public void setApply_fail_cnt(String apply_fail_cnt) { this.apply_fail_cnt = apply_fail_cnt; }
	public String getApply_success_cnt() { return apply_success_cnt; }
	public void setApply_success_cnt(String apply_success_cnt) { this.apply_success_cnt = apply_success_cnt; }
	public String getAlarm_user() { return alarm_user; }
	public void setAlarm_user(String alarm_user) { this.alarm_user = alarm_user; }
	public String getUser_daily() {
		return user_daily;
	}
	public void setUser_daily(String user_daily) {
		this.user_daily = user_daily;
	}
	public String getReject_comment() {
		return reject_comment;
	}
	public void setReject_comment(String reject_comment) {
		this.reject_comment = reject_comment;
	}
	public String getReturn_line_approval() {
		return return_line_approval;
	}
	public void setReturn_line_approval(String return_line_approval) {
		this.return_line_approval = return_line_approval;
	}
	public String getLine_approval() {
		return line_approval;
	}
	public void setLine_approval(String line_approval) {
		this.line_approval = line_approval;
	}
	public int getBatchjobgradecnt() {
		return batchjobgradecnt;
	}
	public void setBatchjobgradecnt(int batchjobgradecnt) {
		this.batchjobgradecnt = batchjobgradecnt;
	}
	public String getMoney_batch_yn() {
		return money_batch_yn;
	}
	public void setMoney_batch_yn(String money_batch_yn) {
		this.money_batch_yn = money_batch_yn;
	}
	public String getMoneybatchjob() {
		return moneybatchjob;
	}
	public void setMoneybatchjob(String moneybatchjob) {
		this.moneybatchjob = moneybatchjob;
	}
	public String getBatchjobgrade() {
		return batchjobgrade;
	}
	public void setBatchjobgrade(String batchjobgrade) {
		this.batchjobgrade = batchjobgrade;
	}
	public String getTime_from() {
		return time_from;
	}
	public void setTime_from(String time_from) {
		this.time_from = time_from;
	}
	public String getJob_count() {
		return job_count;
	}
	public void setJob_count(String job_count) {
		this.job_count = job_count;
	}
	public String getSched_table() {
		return sched_table;
	}
	public void setSched_table(String sched_table) {
		this.sched_table = sched_table;
	}
	public String getApplication() {
		return application;
	}
	public void setApplication(String application) {
		this.application = application;
	}
	public String getPost_approval_yn() {
		return post_approval_yn;
	}
	public void setPost_approval_yn(String post_approval_yn) {
		this.post_approval_yn = post_approval_yn;
	}
	public String getSr_code() {
		return sr_code;
	}
	public void setSr_code(String sr_code) {
		this.sr_code = sr_code;
	}
	public int getRow_num() {
		return row_num;
	}
	public void setRow_num(int row_num) {
		this.row_num = row_num;
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
	public String getUser_cd() {
		return user_cd;
	}
	public void setUser_cd(String user_cd) {
		this.user_cd = user_cd;
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
	public String getApproval_cd() {
		return approval_cd;
	}
	public void setApproval_cd(String approval_cd) {
		this.approval_cd = approval_cd;
	}
	public String getApproval_date() {
		return approval_date;
	}
	public void setApproval_date(String approval_date) {
		this.approval_date = approval_date;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getDraft_date() {
		return draft_date;
	}
	public void setDraft_date(String draft_date) {
		this.draft_date = draft_date;
	}
	public String getDel_yn() {
		return del_yn;
	}
	public void setDel_yn(String del_yn) {
		this.del_yn = del_yn;
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
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getJob_name() {
		return job_name;
	}
	public void setJob_name(String jobName) {
		job_name = jobName;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getData_center() {
		return data_center;
	}
	public void setData_center(String dataCenter) {
		data_center = dataCenter;
	}
	public String getTable_id() {
		return table_id;
	}
	public void setTable_id(String tableId) {
		table_id = tableId;
	}
	public String getJob_id() {
		return job_id;
	}
	public void setJob_id(String jobId) {
		job_id = jobId;
	}
	public String getDoc_group_id() {
		return doc_group_id;
	}
	public void setDoc_group_id(String docGroupId) {
		doc_group_id = docGroupId;
	}
	public String getTask_type() {
		return task_type;
	}
	public void setTask_type(String taskType) {
		task_type = taskType;
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
	public String getUserToken() {
		return userToken;
	}
	public void setUserToken(String userToken) {
		this.userToken = userToken;
	}
	public String getFail_comment() {
		return fail_comment;
	}
	public void setFail_comment(String failComment) {
		fail_comment = failComment;
	}
	public String getTable_name() {
		return table_name;
	}
	public void setTable_name(String tableName) {
		table_name = tableName;
	}
	public String getApply_check() {
		return apply_check;
	}
	public void setApply_check(String applyCheck) {
		apply_check = applyCheck;
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
	public String getCtm_odate() {
		return ctm_odate;
	}
	public void setCtm_odate(String ctmOdate) {
		ctm_odate = ctmOdate;
	}
	public String getMain_doc_cd() {
		return main_doc_cd;
	}
	public void setMain_doc_cd(String mainDocCd) {
		main_doc_cd = mainDocCd;
	}
	public String getLine_user_nm1() {
		return line_user_nm1;
	}
	public void setLine_user_nm1(String lineUserNm1) {
		line_user_nm1 = lineUserNm1;
	}
	public String getLine_user_nm2() {
		return line_user_nm2;
	}
	public void setLine_user_nm2(String lineUserNm2) {
		line_user_nm2 = lineUserNm2;
	}
	public String getLine_user_nm3() {
		return line_user_nm3;
	}
	public void setLine_user_nm3(String lineUserNm3) {
		line_user_nm3 = lineUserNm3;
	}
	public String getS_cnt() {
		return s_cnt;
	}
	public void setS_cnt(String s_cnt) {
		this.s_cnt = s_cnt;
	}
	public String getE_cnt() {
		return e_cnt;
	}
	public void setE_cnt(String e_cnt) {
		this.e_cnt = e_cnt;
	}
	public String getW_cnt() {
		return w_cnt;
	}
	public void setW_cnt(String w_cnt) {
		this.w_cnt = w_cnt;
	}
	public String getR_cnt() {
		return r_cnt;
	}
	public void setR_cnt(String r_cnt) {
		this.r_cnt = r_cnt;
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
	public String getData_center_name() {
		return data_center_name;
	}
	public void setData_center_name(String data_center_name) {
		this.data_center_name = data_center_name;
	}
	public String getFirst_batchjobgrade() {
		return first_batchjobgrade;
	}
	public void setFirst_batchjobgrade(String first_batchjobgrade) {
		this.first_batchjobgrade = first_batchjobgrade;
	}
	public String getAll_batchjobgrade() {
		return all_batchjobgrade;
	}
	public void setAll_batchjobgrade(String all_batchjobgrade) {
		this.all_batchjobgrade = all_batchjobgrade;
	}
	public String getCritical() {
		return critical;
	}
	public void setCritical(String critical) {
		this.critical = critical;
	}
	public String getOdate() {
		return odate;
	}
	public void setOdate(String odate) {
		this.odate = odate;
	}
	public String getSearch_apply_date() {
		return search_apply_date;
	}
	public void setSearch_apply_date(String search_apply_date) {
		this.search_apply_date = search_apply_date;
	}
	public String getApproval_user_nm() {
		return approval_user_nm;
	}
	public void setApproval_user_nm(String approval_user_nm) {
		this.approval_user_nm = approval_user_nm;
	}
	public String getReject_user_nm() {
		return reject_user_nm;
	}
	public void setReject_user_nm(String reject_user_nm) {
		this.reject_user_nm = reject_user_nm;
	}
	public String getReject_date() {
		return reject_date;
	}
	public void setReject_date(String reject_date) {
		this.reject_date = reject_date;
	}
	public String getJobschedgb() {
		return jobschedgb;
	}
	public void setJobschedgb(String jobschedgb) {
		this.jobschedgb = jobschedgb;
	}
	public String getGroup_name() {
		return group_name;
	}
	public void setGroup_name(String group_name) {
		this.group_name = group_name;
	}
	public String getAfter_status() {
		return after_status;
	}
	public void setAfter_status(String after_status) {
		this.after_status = after_status;
	}
	public String getFrom_time() {
		return from_time;
	}
	public void setFrom_time(String from_time) {
		this.from_time = from_time;
	}
	public String getOrder_id() {
		return order_id;
	}
	public void setOrder_id(String order_id) {
		this.order_id = order_id;
	}
	public String getUser_hp() {
		return user_hp;
	}
	public void setUser_hp(String user_hp) {
		this.user_hp = user_hp;
	}
	public String getDetail_status() {
		return detail_status;
	}
	public void setDetail_status(String detail_status) {
		this.detail_status = detail_status;
	}
	public String getTask_nm_detail() {
		return task_nm_detail;
	}
	public void setTask_nm_detail(String task_nm_detail) {
		this.task_nm_detail = task_nm_detail;
	}
	public String getTotal_cnt() {
		return total_cnt;
	}
	public void setTotal_cnt(String total_cnt) {
		this.total_cnt = total_cnt;
	}
	public String getFail_cnt() {
		return fail_cnt;
	}
	public void setFail_cnt(String fail_cnt) {
		this.fail_cnt = fail_cnt;
	}
	
}
