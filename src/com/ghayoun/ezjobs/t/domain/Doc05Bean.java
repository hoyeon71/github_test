package com.ghayoun.ezjobs.t.domain;

import java.io.Serializable;

public class Doc05Bean implements Serializable {
	
	private String doc_cd				= "";
	private String title				= "";
	private String content				= "";
	private String table_id         	= "";
	private String job_id              	= "";
	private String data_center          = "";
	private String table_name           = "";
	private String mem_name             = "";
	private String job_name             = "";
	private String hold_yn              = "";
	private String force_yn             = "";
	private String order_date           = "";
	
	private String state_cd				= "";
	private String dept_nm				= "";
	private String duty_nm           	= "";
	private String part_nm           	= "";
	private String user_nm           	= "";
	private String application         	= "";
	private String group_name           = "";
	private String sched_table          = "";
	private String cmd_line           	= "";
	private String owner           		= "";
	private String description     		= "";
	private String node_id		     	= "";
	
	private String jobgroup_name     	= "";
	private String udt_user_nm     		= "";
	private String udt_date     		= "";
	private String group_content     	= "";
	private String doc_group_id     	= "";
	private String task_type			= "";
	private String approval_cnt			= "";
	private String from_time			= "";
	private String cmd_line2           	= "";
	private String t_set				= "";
	
	private String apply_cd				= "";
	private String cancel_comment		= "";
	private String fail_comment			= "";
	private String apply_check			= "";
	private String wait_for_odate_yn	= "";
	private String e_order_date			= "";
	private String days_cnt				= "";

	private String late_sub    			= "";
	private String late_time    		= "";
	private String late_exec    		= "";
	
	private String batchjobGrade 	       = "";
	private String error_description 	   = "";
	private String user_cd_2 	           = "";
	private String user_cd_3 	           = "";
	private String user_cd_4 	           = "";

	private String rerun_interval			= "";
	private String cyclic_type				= "";
	private String count_cyclic_from		= "";
	private String t_conditions_in  = "";
	private String t_conditions_out = "";
	
	private String out_sign    		= "";
		
	private String days_cal			= "";
	private String status			= "";
	private String post_approval_yn	= "";

	private String order_into_folder 	= "";

	public String getPost_approval_yn() { return post_approval_yn; }
	public void setPost_approval_yn(String post_approval_yn) { this.post_approval_yn = post_approval_yn; }
	public String getDoc_cd() {
		return doc_cd;
	}
	public void setDoc_cd(String docCd) {
		doc_cd = docCd;
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
	public String getData_center() {
		return data_center;
	}
	public void setData_center(String dataCenter) {
		data_center = dataCenter;
	}
	public String getTable_name() {
		return table_name;
	}
	public void setTable_name(String tableName) {
		table_name = tableName;
	}
	public String getMem_name() {
		return mem_name;
	}
	public void setMem_name(String memName) {
		mem_name = memName;
	}
	public String getJob_name() {
		return job_name;
	}
	public void setJob_name(String jobName) {
		job_name = jobName;
	}
	public String getHold_yn() {
		return hold_yn;
	}
	public void setHold_yn(String holdYn) {
		hold_yn = holdYn;
	}
	public String getOrder_date() {
		return order_date;
	}
	public void setOrder_date(String orderDate) {
		order_date = orderDate;
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
	public String getUser_nm() {
		return user_nm;
	}
	public void setUser_nm(String userNm) {
		user_nm = userNm;
	}
	public String getState_cd() {
		return state_cd;
	}
	public void setState_cd(String stateCd) {
		state_cd = stateCd;
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
	public void setGroup_name(String groupName) {
		group_name = groupName;
	}
	public String getSched_table() {
		return sched_table;
	}
	public void setSched_table(String schedTable) {
		sched_table = schedTable;
	}
	public String getCmd_line() {
		return cmd_line;
	}
	public void setCmd_line(String cmdLine) {
		cmd_line = cmdLine;
	}
	public String getOwner() {
		return owner;
	}
	public void setOwner(String owner) {
		this.owner = owner;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getForce_yn() {
		return force_yn;
	}
	public void setForce_yn(String forceYn) {
		force_yn = forceYn;
	}
	public String getJobgroup_name() {
		return jobgroup_name;
	}
	public void setJobgroup_name(String jobgroupName) {
		jobgroup_name = jobgroupName;
	}
	public String getUdt_user_nm() {
		return udt_user_nm;
	}
	public void setUdt_user_nm(String udtUserNm) {
		udt_user_nm = udtUserNm;
	}
	public String getUdt_date() {
		return udt_date;
	}
	public void setUdt_date(String udtDate) {
		udt_date = udtDate;
	}
	public String getGroup_content() {
		return group_content;
	}
	public void setGroup_content(String groupContent) {
		group_content = groupContent;
	}
	public String getDoc_group_id() {
		return doc_group_id;
	}
	public void setDoc_group_id(String docGroupId) {
		doc_group_id = docGroupId;
	}
	public String getNode_id() {
		return node_id;
	}
	public void setNode_id(String nodeId) {
		node_id = nodeId;
	}
	public String getTask_type() {
		return task_type;
	}
	public void setTask_type(String taskType) {
		task_type = taskType;
	}
	public String getApproval_cnt() {
		return approval_cnt;
	}
	public void setApproval_cnt(String approvalCnt) {
		approval_cnt = approvalCnt;
	}
	public String getFrom_time() {
		return from_time;
	}
	public void setFrom_time(String fromTime) {
		from_time = fromTime;
	}
	public String getCmd_line2() {
		return cmd_line2;
	}
	public void setCmd_line2(String cmdLine2) {
		cmd_line2 = cmdLine2;
	}
	public String getT_set() {
		return t_set;
	}
	public void setT_set(String tSet) {
		t_set = tSet;
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
	public String getApply_check() {
		return apply_check;
	}
	public void setApply_check(String applyCheck) {
		apply_check = applyCheck;
	}
	public String getWait_for_odate_yn() {
		return wait_for_odate_yn;
	}
	public void setWait_for_odate_yn(String wait_for_odate_yn) {
		this.wait_for_odate_yn = wait_for_odate_yn;
	}
	public String getDays_cal() {
		return days_cal;
	}
	public void setDays_cal(String days_cal) {
		this.days_cal = days_cal;
	}
	public String getE_order_date() {
		return e_order_date;
	}
	public void setE_order_date(String e_order_date) {
		this.e_order_date = e_order_date;
	}
	public String getDays_cnt() {
		return days_cnt;
	}
	public void setDays_cnt(String days_cnt) {
		this.days_cnt = days_cnt;
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
	public String getOut_sign() {
		return out_sign;
	}
	public void setOut_sign(String out_sign) {
		this.out_sign = out_sign;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getOrder_into_folder() {
		return order_into_folder;
	}
	public void setOrder_into_folder(String order_into_folder) {
		this.order_into_folder = order_into_folder;
	}
	
}
