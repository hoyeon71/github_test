package com.ghayoun.ezjobs.m.domain;

import java.io.Serializable;

public class BatchResultTotalBean implements Serializable {

	private String table_name 			= "";
	private String application 			= "";
	private String group_name 			= "";
	private String job_name 			= "";
	private String description 			= "";
	private String rerun_counter		= "";
	private String status				= "";
	private String final_status			= "";
	private String user_daily_system_gb = "";
	private String total 				= "";
	private String wait_confirm 		= "";
	private String wait_condition 		= "";
	private String wait_resource 		= "";
	private String hold 				= "";
	private String executing 			= "";
	private String ended_ok 			= "";
	private String ended_not_ok 		= "";
	private String unknown 				= "";
	private String deletes 				= "";
	private String etc 					= "";
	private String wait_time 			= "";
	
	private String to_ymd 				= "";
	private String from_time 			= "";
	private String to_time 				= "";
	private String nodegroup 			= "";
	private String job_cnt 				= "";
	
	private String odate 				= "";
	private String cnt 					= "";
	private String result 				= "";
	private String state_result 		= "";
	private String content		 		= "";
	private String wait_host	 		= "";
	
	private String gubun	 			= "";
	private String order_date	 		= "";
	private String ok_cnt	 			= "";
	private String not_ok_cnt	 		= "";
	private String exec_cnt	 			= "";
	private String wait_cnt	 			= "";
	private String wait_user_cnt	 	= "";
	private String wait_resource_cnt	= "";
	private String wait_host_cnt	 	= "";
	private String wait_condition_cnt	= "";
	private String wait_time_cnt	 	= "";
	private String delete_cnt		 	= "";
	private String total_cnt	 		= "";
	
	private String data_center	 		= "";
	
	private String failJobList	 		= "";
	private String cyclic		 		= "";
	
	private String smart_job_yn			= "";
	
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
	public String getTotal() {
		return total;
	}
	public void setTotal(String total) {
		this.total = total;
	}
	public String getWait_confirm() {
		return wait_confirm;
	}
	public void setWait_confirm(String wait_confirm) {
		this.wait_confirm = wait_confirm;
	}
	public String getWait_condition() {
		return wait_condition;
	}
	public void setWait_condition(String wait_condition) {
		this.wait_condition = wait_condition;
	}
	public String getWait_resource() {
		return wait_resource;
	}
	public void setWait_resource(String wait_resource) {
		this.wait_resource = wait_resource;
	}
	public String getHold() {
		return hold;
	}
	public void setHold(String hold) {
		this.hold = hold;
	}
	public String getExecuting() {
		return executing;
	}
	public void setExecuting(String executing) {
		this.executing = executing;
	}
	public String getEnded_ok() {
		return ended_ok;
	}
	public void setEnded_ok(String ended_ok) {
		this.ended_ok = ended_ok;
	}
	public String getEnded_not_ok() {
		return ended_not_ok;
	}
	public void setEnded_not_ok(String ended_not_ok) {
		this.ended_not_ok = ended_not_ok;
	}
	public String getUnknown() {
		return unknown;
	}
	public void setUnknown(String unknown) {
		this.unknown = unknown;
	}
	public String getDeletes() {
		return deletes;
	}
	public void setDeletes(String deletes) {
		this.deletes = deletes;
	}
	public String getEtc() {
		return etc;
	}
	public void setEtc(String etc) {
		this.etc = etc;
	}
	public String getWait_time() {
		return wait_time;
	}
	public void setWait_time(String wait_time) {
		this.wait_time = wait_time;
	}
	public String getTo_ymd() {
		return to_ymd;
	}
	public void setTo_ymd(String to_ymd) {
		this.to_ymd = to_ymd;
	}
	public String getFrom_time() {
		return from_time;
	}
	public void setFrom_time(String from_time) {
		this.from_time = from_time;
	}
	public String getTo_time() {
		return to_time;
	}
	public void setTo_time(String to_time) {
		this.to_time = to_time;
	}
	public String getJob_cnt() {
		return job_cnt;
	}
	public void setJob_cnt(String job_cnt) {
		this.job_cnt = job_cnt;
	}
	public String getNodegroup() {
		return nodegroup;
	}
	public void setNodegroup(String nodegroup) {
		this.nodegroup = nodegroup;
	}
	public String getUser_daily_system_gb() {
		return user_daily_system_gb;
	}
	public void setUser_daily_system_gb(String user_daily_system_gb) {
		this.user_daily_system_gb = user_daily_system_gb;
	}
	public String getOdate() {
		return odate;
	}
	public void setOdate(String odate) {
		this.odate = odate;
	}
	public String getState_result() {
		return state_result;
	}
	public void setState_result(String stateResult) {
		state_result = stateResult;
	}
	public String getResult() {
		return result;
	}
	public void setResult(String result) {
		this.result = result;
	}
	public String getCnt() {
		return cnt;
	}
	public void setCnt(String cnt) {
		this.cnt = cnt;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getWait_host() {
		return wait_host;
	}
	public void setWait_host(String wait_host) {
		this.wait_host = wait_host;
	}
	public String getGubun() {
		return gubun;
	}
	public void setGubun(String gubun) {
		this.gubun = gubun;
	}
	public String getOrder_date() {
		return order_date;
	}
	public void setOrder_date(String order_date) {
		this.order_date = order_date;
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
	public String getExec_cnt() {
		return exec_cnt;
	}
	public void setExec_cnt(String exec_cnt) {
		this.exec_cnt = exec_cnt;
	}
	public String getWait_user_cnt() {
		return wait_user_cnt;
	}
	public void setWait_user_cnt(String wait_user_cnt) {
		this.wait_user_cnt = wait_user_cnt;
	}
	public String getWait_resource_cnt() {
		return wait_resource_cnt;
	}
	public void setWait_resource_cnt(String wait_resource_cnt) {
		this.wait_resource_cnt = wait_resource_cnt;
	}
	public String getWait_host_cnt() {
		return wait_host_cnt;
	}
	public void setWait_host_cnt(String wait_host_cnt) {
		this.wait_host_cnt = wait_host_cnt;
	}
	public String getWait_condition_cnt() {
		return wait_condition_cnt;
	}
	public void setWait_condition_cnt(String wait_condition_cnt) {
		this.wait_condition_cnt = wait_condition_cnt;
	}
	public String getWait_time_cnt() {
		return wait_time_cnt;
	}
	public void setWait_time_cnt(String wait_time_cnt) {
		this.wait_time_cnt = wait_time_cnt;
	}
	public String getTotal_cnt() {
		return total_cnt;
	}
	public void setTotal_cnt(String total_cnt) {
		this.total_cnt = total_cnt;
	}
	public String getDelete_cnt() {
		return delete_cnt;
	}
	public void setDelete_cnt(String delete_cnt) {
		this.delete_cnt = delete_cnt;
	}
	public String getWait_cnt() {
		return wait_cnt;
	}
	public void setWait_cnt(String wait_cnt) {
		this.wait_cnt = wait_cnt;
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
	public String getRerun_counter() {
		return rerun_counter;
	}
	public void setRerun_counter(String rerun_counter) {
		this.rerun_counter = rerun_counter;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getFinal_status() {
		return final_status;
	}
	public void setFinal_status(String final_status) {
		this.final_status = final_status;
	}
	public String getFailJobList() {
		return failJobList;
	}
	public void setFailJobList(String failJobList) {
		this.failJobList = failJobList;
	}
	public String getCyclic() {
		return cyclic;
	}
	public void setCyclic(String cyclic) {
		this.cyclic = cyclic;
	}
	public String getSmart_job_yn() {
		return smart_job_yn;
	}
	public void setSmart_job_yn(String smart_job_yn) {
		this.smart_job_yn = smart_job_yn;
	}
	
}
