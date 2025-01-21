package com.ghayoun.ezjobs.t.domain;

import java.io.Serializable;

public class DefJobBean implements Serializable {
	
	private int row_num 		= 0;
	
	private String table_id             = "";
	private String job_id               = "";
	private String data_center          = "";
	private String sched_table          = "";
	private String application          = "";
	private String group_name           = "";
	private String memname            	= "";
	private String job_name             = "";
	private String description          = "";
	private String node_id              = "";
	
	private String task_type          	= "";
	private String user_daily           = "";
	private String author               = "";
	private String owner               	= "";
	private String mem_lib              = "";
	private String command              = "";
	private String in_condition         = "";
	private String out_condition        = "";
	private String user_cd        		= "";
	
	private String jobgroup_id     		= "";
	private String in_cond_cnt     		= "";
	private String approval_cnt    		= "";
	private String from_time    		= "";
	private String cmd_line2    		= "";
	
	private String qresname    			= "";
	private String qtype    			= "";
	private String qrtotal    			= "";
	private String rsrvno    			= "";
	private String qrused    			= "";

	private String priority    			= "";
	private String rerun_max    		= "";
	private String rerun_interval    	= "";
	private String count_cyclic_from    = "";

	private String mapper_data_center  	= "";
	private String error_description  	= "";
	
	private String total_cnt			= "";
	private String prev_doc_info		= "";
	
	private String grp_eng_nm			= "";
	private String grp_cd				= "";
	private String arr_host_desc		= "";
	private String arr_host_nm			= "";
	private String grp_depth			= "";
	private String grp_desc				= "";
	private String grp_use_yn			= "";
	private String scode_cd				= "";
	private String host_cd				= "";

	private String user_nm				= "";
	private String user_id 	        	= "";
	private String user_id2 	        = "";
	private String user_id3 	        = "";
	private String user_id4 	        = "";
	private String user_id5 	        = "";
	private String user_id6 	        = "";
	private String user_id7 	        = "";
	private String user_id8 	        = "";
	private String user_id9 	        = "";
	private String user_id10 	        = "";

	private String smart_job_yn			= "";

	public String getUser_nm() { return user_nm; }
	public void setUser_nm(String user_nm) { this.user_nm = user_nm; }
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
	public String getUser_id5() { return user_id5; }
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
	public void setUser_id8(String user_id8) {
		this.user_id8 = user_id8;
	}
	public String getUser_id9() {
		return user_id9;
	}
	public void setUser_id9(String user_id9) {
		this.user_id9 = user_id9;
	}
	public String getUser_id10() {
		return user_id10;
	}
	public void setUser_id10(String user_id10) {
		this.user_id10 = user_id10;
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
	public String getMemname() {
		return memname;
	}
	public void setMemname(String memname) {
		this.memname = memname;
	}
	public String getNode_id() {
		return node_id;
	}
	public void setNode_id(String node_id) {
		this.node_id = node_id;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
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
	public String getAuthor() {
		return author;
	}
	public void setAuthor(String author) {
		this.author = author;
	}
	public String getOwner() {
		return owner;
	}
	public void setOwner(String owner) {
		this.owner = owner;
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
	public String getUser_cd() {
		return user_cd;
	}
	public void setUser_cd(String userCd) {
		user_cd = userCd;
	}
	public String getJobgroup_id() {
		return jobgroup_id;
	}
	public void setJobgroup_id(String jobgroupId) {
		jobgroup_id = jobgroupId;
	}
	public String getIn_cond_cnt() {
		return in_cond_cnt;
	}
	public void setIn_cond_cnt(String inCondCnt) {
		in_cond_cnt = inCondCnt;
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
	public String getQresname() {
		return qresname;
	}
	public void setQresname(String qresname) {
		this.qresname = qresname;
	}
	public String getQtype() {
		return qtype;
	}
	public void setQtype(String qtype) {
		this.qtype = qtype;
	}
	public String getQrtotal() {
		return qrtotal;
	}
	public void setQrtotal(String qrtotal) {
		this.qrtotal = qrtotal;
	}
	public String getRsrvno() {
		return rsrvno;
	}
	public void setRsrvno(String rsrvno) {
		this.rsrvno = rsrvno;
	}
	public String getQrused() {
		return qrused;
	}
	public void setQrused(String qrused) {
		this.qrused = qrused;
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
	public String getMapper_data_center() {
		return mapper_data_center;
	}
	public void setMapper_data_center(String mapper_data_center) {
		this.mapper_data_center = mapper_data_center;
	}
	public String getError_description() {
		return error_description;
	}
	public void setError_description(String error_description) {
		this.error_description = error_description;
	}
	public String getGrp_eng_nm() {
		return grp_eng_nm;
	}
	public void setGrp_eng_nm(String grp_eng_nm) {
		this.grp_eng_nm = grp_eng_nm;
	}
	public String getGrp_cd() {
		return grp_cd;
	}
	public void setGrp_cd(String grp_cd) {
		this.grp_cd = grp_cd;
	}
	public String getArr_host_desc() {
		return arr_host_desc;
	}
	public void setArr_host_desc(String arr_host_desc) {
		this.arr_host_desc = arr_host_desc;
	}
	public String getArr_host_nm() {
		return arr_host_nm;
	}
	public void setArr_host_nm(String arr_host_nm) {
		this.arr_host_nm = arr_host_nm;
	}
	public String getGrp_depth() {
		return grp_depth;
	}
	public void setGrp_depth(String grp_depth) {
		this.grp_depth = grp_depth;
	}
	public String getGrp_desc() {
		return grp_desc;
	}
	public void setGrp_desc(String grp_desc) {
		this.grp_desc = grp_desc;
	}
	public String getGrp_use_yn() {
		return grp_use_yn;
	}
	public void setGrp_use_yn(String grp_use_yn) {
		this.grp_use_yn = grp_use_yn;
	}
	public String getScode_cd() {
		return scode_cd;
	}
	public void setScode_cd(String scode_cd) {
		this.scode_cd = scode_cd;
	}
	public String getHost_cd() {
		return host_cd;
	}
	public void setHost_cd(String host_cd) {
		this.host_cd = host_cd;
	}
	public String getSmart_job_yn() {
		return smart_job_yn;
	}
	public void setSmart_job_yn(String smart_job_yn) {
		this.smart_job_yn = smart_job_yn;
	}
}
