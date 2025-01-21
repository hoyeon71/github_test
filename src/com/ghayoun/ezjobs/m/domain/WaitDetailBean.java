package com.ghayoun.ezjobs.m.domain;

import java.io.Serializable;

public class WaitDetailBean implements Serializable {
	
	private String job_name			  = "";
	private String memname			  = "";
	private String order_id           = "";
	private String start_time         = "";
	private String end_time           = "";
	private String rerun_counter      = "";
	private String state              = "";
	private String odate              = "";
	private String description        = "";
	private String descript           = "";
	private String state_result       = "";
	private String holdflag           = "";
	private String from_time          = "";
	private String to_time            = "";
	
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
	public String getMemname() {
		return memname;
	}
	public void setMemname(String memname) {
		this.memname = memname;
	}
        
}
