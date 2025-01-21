package com.ghayoun.ezjobs.m.domain;

import java.io.Serializable;

public class ErrorLogTotalBean implements Serializable {

	private String jobschedgb;
	private String job_name;
	private String host_time;
	private String action_date;
	private String udt_user_nm;
	private String error_description;
	private String message;
	private String dept_nm;
	private String duty_nm;
	private String user_nm;
	
	public String getJobschedgb() {
		return jobschedgb;
	}
	public void setJobschedgb(String jobschedgb) {
		this.jobschedgb = jobschedgb;
	}
	public String getJob_name() {
		return job_name;
	}
	public void setJob_name(String job_name) {
		this.job_name = job_name;
	}
	public String getHost_time() {
		return host_time;
	}
	public void setHost_time(String host_time) {
		this.host_time = host_time;
	}
	public String getAction_date() {
		return action_date;
	}
	public void setAction_date(String action_date) {
		this.action_date = action_date;
	}
	public String getUdt_user_nm() {
		return udt_user_nm;
	}
	public void setUdt_user_nm(String udt_user_nm) {
		this.udt_user_nm = udt_user_nm;
	}
	public String getError_description() {
		return error_description;
	}
	public void setError_description(String error_description) {
		this.error_description = error_description;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
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
	public String getUser_nm() {
		return user_nm;
	}
	public void setUser_nm(String user_nm) {
		this.user_nm = user_nm;
	}
	
}
