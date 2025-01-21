package com.ghayoun.ezjobs.m.domain;

import java.io.Serializable;

public class JobGraphBean implements Serializable {

	private String job_name = "";
	private String order_id = "";
	private String ref_order_id = "";
	private String start_time = "";
	private String end_time = "";
	private String rerun_counter = "";
	private String state = "";
	private String odate = "";
	private String developer = "";
	private String contact = "";
	private String description = "";
	private String descript = "";
	private String state_result = "";
	private String holdflag = "";
	
	private String table_id 	= "";
	private String job_id 		= "";	
	private String ref_table_id = "";
	private String ref_job_id 	= "";
	
	public String getJob_name() {
		return job_name;
	}
	public void setJob_name(String job_name) {
		this.job_name = job_name;
	}
	public String getOrder_id() {
		return order_id;
	}
	public void setOrder_id(String order_id) {
		this.order_id = order_id;
	}
	public String getRef_order_id() {
		return ref_order_id;
	}
	public void setRef_order_id(String ref_order_id) {
		this.ref_order_id = ref_order_id;
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
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getOdate() {
		return odate;
	}
	public void setOdate(String odate) {
		this.odate = odate;
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
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getDescript() {
		return descript;
	}
	public void setDescript(String descript) {
		this.descript = descript;
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
	public String getRef_table_id() {
		return ref_table_id;
	}
	public void setRef_table_id(String refTableId) {
		ref_table_id = refTableId;
	}
	public String getRef_job_id() {
		return ref_job_id;
	}
	public void setRef_job_id(String refJobId) {
		ref_job_id = refJobId;
	}
	
}
