package com.ghayoun.ezjobs.m.domain;

import java.io.Serializable;

public class TimeInfoBean implements Serializable {
	
	private String odate 			= "";
	private String start_time 		= "";
	private String end_time 		= "";
	private String diff_time 		= "";
	private String state_result		= "";
	private String rerun_counter	= "";
	private String job_name			= "";
	
	public String getOdate() {
		return odate;
	}
	public void setOdate(String odate) {
		this.odate = odate;
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
	public String getDiff_time() {
		return diff_time;
	}
	public void setDiff_time(String diff_time) {
		this.diff_time = diff_time;
	}
	public String getState_result() {
		return state_result;
	}
	public void setState_result(String state_result) {
		this.state_result = state_result;
	}
	public String getRerun_counter() {
		return rerun_counter;
	}
	public void setRerun_counter(String rerun_counter) {
		this.rerun_counter = rerun_counter;
	}
	public String getJob_name() {
		return job_name;
	}
	public void setJob_name(String job_name) {
		this.job_name = job_name;
	}
	
	
}
