package com.ghayoun.ezjobs.m.domain;

import java.io.Serializable;

public class JobOpBean implements Serializable {
	
	private int 	row_num 		= 0;
	private String start_time		= "";
	private String end_time         = "";
	private String rerun_counter    = "";
	private String order_table      = "";
	private String application      = "";
	private String group_name       = "";
	private String job_name         = "";
	private String memname          = "";
	private String state_result     = "";
	private String holdflag         = "";
	private String order_id         = "";
	private String status           = "";
	private String odate            = "";
	private String state            = "";
	private String job_id           = "";
	private String critical_yn      = "";
	private String memo             = "";
	private String description     	= "";
	
	public int getRow_num() {
		return row_num;
	}
	public void setRow_num(int row_num) {
		this.row_num = row_num;
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
	public String getCritical_yn() {
		return critical_yn;
	}
	public void setCritical_yn(String critical_yn) {
		this.critical_yn = critical_yn;
	}
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
}
