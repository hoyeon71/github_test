package com.ghayoun.ezjobs.t.domain;

import java.io.Serializable;

public class ActiveJobBean implements Serializable {
	
	private int 	row_num 		= 0;
	private String start_time		= "";
	private String end_time         = "";
	private String rerun_counter    = "";
	private String order_table      = "";
	private String application      = "";
	private String group_name	    = "";
	private String job_name         = "";
	private String memname          = "";
	private String state_result     = "";
	private String holdflag         = "";
	private String developer        = "";
	private String contact          = "";
	private String order_id         = "";
	private String status           = "";
	private String status2           = "";
	private String odate            = "";
	private String description      = "";
	private String critical_yn      = "";
	private String state            = "";
	private String job_id           = "";
	private String node_id         	= "";
	private String state_result2   	= "";
	private String user_nm		   	= "";
	
	private String before_status	= "";
	private String after_status		= "";
	private String ins_date		   	= "";
	private String ins_user_nm	   	= "";
	
	private String table_id			= "";
	private String owner   			= "";
	private String time_from   		= "";
	private String time_until   	= "";
	private String cyclic   		= "";
	private String task_type   		= "";
	private String rba   			= "";
	private String rerun_interval  	= "";
	private String rerun_max   		= "";
	private String command   		= "";
	private String ins_user_id 		= "";
	
	private String system_gb        = "";
	private String mcode_nm         = "";
	private String total_cnt        = "";
	private String running_cnt      = "";
	private String wait_cnt         = "";
	private String success_cnt      = "";
	private String fail_cnt         = "";
	private String calendar_nm		= "";
	private String dept_nm			= "";
	
	private String job_gubun        = "";
	private String c_cnt            = "";
	private String a_cnt            = "";
	private String r_cnt            = "";
	private String s_cnt            = "";
	private String d_cnt            = "";
	private String m_cnt            = "";
	private String u_cnt            = "";
	private String p_cnt            = "";
	private String etc_cnt          = "";
	
	private String w_cnt            = "";
	private String t_cnt            = "";
	private String q_cnt            = "";
	private String h_cnt            = "";
	private String y_cnt            = "";
	private String o_cnt            = "";
	private String system_gubun     = "";
	private String type_gubun       = "";
	private String scode_nm         = "";
	private String seq		        = "";
	private String grp_nm		        = "";
	
	private String draft_date		= "";
	private String data_center		= "";
	private String order_time		= "";
	private String ok_cnt		= "";
	private String not_ok_cnt		= "";
	
	private String host_time		= "";
	private String dept_cnt1		= "";
	private String dept_cnt2		= "";
	private String dept_cnt3		= "";
	private String dept_cnt4		= "";
	private String dept_cnt5		= "";
	private String dept_cnt6		= "";
	private String dept_cnt7		= "";
	private String dept_cnt8		= "";
	private String dept_cnt9		= "";
	private String dept_cnt10		= "";
	private String dept_cnt11		= "";
	private String dept_cnt12		= "";
	private String error_cnt		= "";
	private String data_center_name = "";
	private String op_description   = ""; 
	private String op_yn  			= "";
	private String cm_sysout		= "";
	private String udt_user_nm		= "";
	private String udt_date			= "";
	private String data_center_gubun= "";
	private String jobschedgb		= "";
	private String user_daily		= "";
	
	private String user_id        	= "";
	private String user_id2        	= "";
	private String user_id3        	= "";
	private String user_id4        	= "";
	private String user_id5        	= "";
	private String user_id6        	= "";
	private String user_id7        	= "";
	private String user_id8        	= "";
	private String avg_run_time    	= "";
	private String set_value       	= "";
	private String susi_cnt	       	= "";
	
	private String ins_nm1  		= "";
	private String approval_nm1  	= "";
	private String approval_nm2     = "";
	private String appl_type  		= "";
	private String appl_form	    = "";
	
	private String late_exec = "";
	
	private String smart_job_yn				= "";
	
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
	public String getData_center_gubun() {
		return data_center_gubun;
	}
	public void setData_center_gubun(String data_center_gubun) {
		this.data_center_gubun = data_center_gubun;
	}
	public String getUdt_user_nm() {
		return udt_user_nm;
	}
	public void setUdt_user_nm(String udt_user_nm) {
		this.udt_user_nm = udt_user_nm;
	}
	public String getUdt_date() {
		return udt_date;
	}
	public void setUdt_date(String udt_date) {
		this.udt_date = udt_date;
	}
	public String getCm_sysout() {
		return cm_sysout;
	}
	public void setCm_sysout(String cm_sysout) {
		this.cm_sysout = cm_sysout;
	}
	public String getOp_yn() {
		return op_yn;
	}
	public void setOp_yn(String op_yn) {
		this.op_yn = op_yn;
	}
	public String getOp_description() {
		return op_description;
	}
	public void setOp_description(String op_description) {
		this.op_description = op_description;
	}
	public String getStatus2() {
		return status2;
	}
	public void setStatus2(String status2) {
		this.status2 = status2;
	}
	public String getData_center_name() {
		return data_center_name;
	}
	public void setData_center_name(String data_center_name) {
		this.data_center_name = data_center_name;
	}
	public String getError_cnt() {
		return error_cnt;
	}
	public void setError_cnt(String error_cnt) {
		this.error_cnt = error_cnt;
	}
	public String getDraft_date() {
		return draft_date;
	}
	public void setDraft_date(String draft_date) {
		this.draft_date = draft_date;
	}
	public String getData_center() {
		return data_center;
	}
	public void setData_center(String data_center) {
		this.data_center = data_center;
	}
	public String getOrder_time() {
		return order_time;
	}
	public void setOrder_time(String order_time) {
		this.order_time = order_time;
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
	public String getHost_time() {
		return host_time;
	}
	public void setHost_time(String host_time) {
		this.host_time = host_time;
	}
	public String getDept_cnt1() {
		return dept_cnt1;
	}
	public void setDept_cnt1(String dept_cnt1) {
		this.dept_cnt1 = dept_cnt1;
	}
	public String getDept_cnt2() {
		return dept_cnt2;
	}
	public void setDept_cnt2(String dept_cnt2) {
		this.dept_cnt2 = dept_cnt2;
	}
	public String getDept_cnt3() {
		return dept_cnt3;
	}
	public void setDept_cnt3(String dept_cnt3) {
		this.dept_cnt3 = dept_cnt3;
	}
	public String getDept_cnt4() {
		return dept_cnt4;
	}
	public void setDept_cnt4(String dept_cnt4) {
		this.dept_cnt4 = dept_cnt4;
	}
	public String getDept_cnt5() {
		return dept_cnt5;
	}
	public void setDept_cnt5(String dept_cnt5) {
		this.dept_cnt5 = dept_cnt5;
	}
	public String getDept_cnt6() {
		return dept_cnt6;
	}
	public void setDept_cnt6(String dept_cnt6) {
		this.dept_cnt6 = dept_cnt6;
	}
	public String getDept_cnt7() {
		return dept_cnt7;
	}
	public void setDept_cnt7(String dept_cnt7) {
		this.dept_cnt7 = dept_cnt7;
	}
	public String getDept_cnt8() {
		return dept_cnt8;
	}
	public void setDept_cnt8(String dept_cnt8) {
		this.dept_cnt8 = dept_cnt8;
	}
	public String getDept_cnt9() {
		return dept_cnt9;
	}
	public void setDept_cnt9(String dept_cnt9) {
		this.dept_cnt9 = dept_cnt9;
	}
	public String getDept_cnt10() {
		return dept_cnt10;
	}
	public void setDept_cnt10(String dept_cnt10) {
		this.dept_cnt10 = dept_cnt10;
	}
	public String getDept_cnt11() {
		return dept_cnt11;
	}
	public void setDept_cnt11(String dept_cnt11) {
		this.dept_cnt11 = dept_cnt11;
	}
	public String getDept_cnt12() {
		return dept_cnt12;
	}
	public void setDept_cnt12(String dept_cnt12) {
		this.dept_cnt12 = dept_cnt12;
	}
	public String getGrp_nm() {
		return grp_nm;
	}
	public void setGrp_nm(String grp_nm) {
		this.grp_nm = grp_nm;
	}
	public String getSeq() {
		return seq;
	}
	public void setSeq(String seq) {
		this.seq = seq;
	}
	public String getScode_nm() {
		return scode_nm;
	}
	public void setScode_nm(String scode_nm) {
		this.scode_nm = scode_nm;
	}
	public String getW_cnt() {
		return w_cnt;
	}
	public void setW_cnt(String w_cnt) {
		this.w_cnt = w_cnt;
	}
	public String getT_cnt() {
		return t_cnt;
	}
	public void setT_cnt(String t_cnt) {
		this.t_cnt = t_cnt;
	}
	public String getQ_cnt() {
		return q_cnt;
	}
	public void setQ_cnt(String q_cnt) {
		this.q_cnt = q_cnt;
	}
	public String getH_cnt() {
		return h_cnt;
	}
	public void setH_cnt(String h_cnt) {
		this.h_cnt = h_cnt;
	}
	public String getY_cnt() {
		return y_cnt;
	}
	public void setY_cnt(String y_cnt) {
		this.y_cnt = y_cnt;
	}
	public String getO_cnt() {
		return o_cnt;
	}
	public void setO_cnt(String o_cnt) {
		this.o_cnt = o_cnt;
	}
	public String getSystem_gubun() {
		return system_gubun;
	}
	public void setSystem_gubun(String system_gubun) {
		this.system_gubun = system_gubun;
	}
	public String getType_gubun() {
		return type_gubun;
	}
	public void setType_gubun(String type_gubun) {
		this.type_gubun = type_gubun;
	}
	public String getEtc_cnt() {
		return etc_cnt;
	}
	public void setEtc_cnt(String etc_cnt) {
		this.etc_cnt = etc_cnt;
	}
	public String getJob_gubun() {
		return job_gubun;
	}
	public void setJob_gubun(String job_gubun) {
		this.job_gubun = job_gubun;
	}
	public String getC_cnt() {
		return c_cnt;
	}
	public void setC_cnt(String c_cnt) {
		this.c_cnt = c_cnt;
	}
	public String getA_cnt() {
		return a_cnt;
	}
	public void setA_cnt(String a_cnt) {
		this.a_cnt = a_cnt;
	}
	public String getR_cnt() {
		return r_cnt;
	}
	public void setR_cnt(String r_cnt) {
		this.r_cnt = r_cnt;
	}
	public String getS_cnt() {
		return s_cnt;
	}
	public void setS_cnt(String s_cnt) {
		this.s_cnt = s_cnt;
	}
	public String getD_cnt() {
		return d_cnt;
	}
	public void setD_cnt(String d_cnt) {
		this.d_cnt = d_cnt;
	}
	public String getM_cnt() {
		return m_cnt;
	}
	public void setM_cnt(String m_cnt) {
		this.m_cnt = m_cnt;
	}
	public String getU_cnt() {
		return u_cnt;
	}
	public void setU_cnt(String u_cnt) {
		this.u_cnt = u_cnt;
	}
	public String getP_cnt() {
		return p_cnt;
	}
	public void setP_cnt(String p_cnt) {
		this.p_cnt = p_cnt;
	}
	public String getCalendar_nm() {
		return calendar_nm;
	}
	public void setCalendar_nm(String calendar_nm) {
		this.calendar_nm = calendar_nm;
	}
	public String getSystem_gb() {
		return system_gb;
	}
	public void setSystem_gb(String system_gb) {
		this.system_gb = system_gb;
	}
	public String getMcode_nm() {
		return mcode_nm;
	}
	public void setMcode_nm(String mcode_nm) {
		this.mcode_nm = mcode_nm;
	}
	public String getTotal_cnt() {
		return total_cnt;
	}
	public void setTotal_cnt(String total_cnt) {
		this.total_cnt = total_cnt;
	}
	public String getRunning_cnt() {
		return running_cnt;
	}
	public void setRunning_cnt(String running_cnt) {
		this.running_cnt = running_cnt;
	}
	public String getWait_cnt() {
		return wait_cnt;
	}
	public void setWait_cnt(String wait_cnt) {
		this.wait_cnt = wait_cnt;
	}
	public String getSuccess_cnt() {
		return success_cnt;
	}
	public void setSuccess_cnt(String success_cnt) {
		this.success_cnt = success_cnt;
	}
	public String getFail_cnt() {
		return fail_cnt;
	}
	public void setFail_cnt(String fail_cnt) {
		this.fail_cnt = fail_cnt;
	}
	public String getOwner() {
		return owner;
	}
	public void setOwner(String owner) {
		this.owner = owner;
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
	public String getCyclic() {
		return cyclic;
	}
	public void setCyclic(String cyclic) {
		this.cyclic = cyclic;
	}
	public String getTask_type() {
		return task_type;
	}
	public void setTask_type(String task_type) {
		this.task_type = task_type;
	}
	public String getRba() {
		return rba;
	}
	public void setRba(String rba) {
		this.rba = rba;
	}
	public String getRerun_interval() {
		return rerun_interval;
	}
	public void setRerun_interval(String rerun_interval) {
		this.rerun_interval = rerun_interval;
	}
	public String getRerun_max() {
		return rerun_max;
	}
	public void setRerun_max(String rerun_max) {
		this.rerun_max = rerun_max;
	}
	public String getCommand() {
		return command;
	}
	public void setCommand(String command) {
		this.command = command;
	}
	public String getIns_user_id() {
		return ins_user_id;
	}
	public void setIns_user_id(String ins_user_id) {
		this.ins_user_id = ins_user_id;
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
	public String getNode_id() {
		return node_id;
	}
	public void setNode_id(String nodeId) {
		node_id = nodeId;
	}
	public String getState_result2() {
		return state_result2;
	}
	public void setState_result2(String stateResult2) {
		state_result2 = stateResult2;
	}
	public String getGroup_name() {
		return group_name;
	}
	public void setGroup_name(String groupName) {
		group_name = groupName;
	}
	public String getUser_nm() {
		return user_nm;
	}
	public void setUser_nm(String userNm) {
		user_nm = userNm;
	}
	public String getBefore_status() {
		return before_status;
	}
	public void setBefore_status(String beforeStatus) {
		before_status = beforeStatus;
	}
	public String getAfter_status() {
		return after_status;
	}
	public void setAfter_status(String afterStatus) {
		after_status = afterStatus;
	}
	public String getIns_date() {
		return ins_date;
	}
	public void setIns_date(String insDate) {
		ins_date = insDate;
	}
	public String getIns_user_nm() {
		return ins_user_nm;
	}
	public void setIns_user_nm(String insUserNm) {
		ins_user_nm = insUserNm;
	}
	public String getTable_id() {
		return table_id;
	}
	public void setTable_id(String table_id) {
		this.table_id = table_id;
	}
	public String getDept_nm() {
		return dept_nm;
	}
	public void setDept_nm(String dept_nm) {
		this.dept_nm = dept_nm;
	}
	public String getJobschedgb() {
		return jobschedgb;
	}
	public void setJobschedgb(String jobschedgb) {
		this.jobschedgb = jobschedgb;
	}
	public String getSet_value() {
		return set_value;
	}
	public void setSet_value(String set_value) {
		this.set_value = set_value;
	}
	public void setUser_id8(String user_id8) {
		this.user_id8 = user_id8;
	}
	public String getAvg_run_time() {
		return avg_run_time;
	}
	public void setAvg_run_time(String avg_run_time) {
		this.avg_run_time = avg_run_time;
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
	public String getAppl_form() {
		return appl_form;
	}
	public void setAppl_form(String appl_form) {
		this.appl_form = appl_form;
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
