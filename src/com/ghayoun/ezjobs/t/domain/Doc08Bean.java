package com.ghayoun.ezjobs.t.domain;

import java.io.Serializable;

public class Doc08Bean implements Serializable {
	
	private String doc_cd				= "";
	private String title				= "";
	private String content				= "";
	private String data_center          = "";
	private String table_name           = "";
	private String application         	= "";
	private String group_name         	= "";
	private String job_name             = "";
	private String description		    = "";
	private String order_date          	= "";
	private String from_time         	= "";
	private String before_status        = "";
	private String after_status         = "";
	
	private String user_nm	 	        = "";
	private String dept_nm		      	= "";
	private String duty_nm		        = "";
	
	private String ins_user_cd	 	   	= "";
	private String ins_user_nm	 	   	= "";
	private String ins_dept_nm		    = "";
	private String ins_duty_nm		    = "";
	private String fail_comment		    = "";
	private String apply_cd		 		= "";
	private String apply_date	 		= "";
	
	
	public String getDoc_cd() {
		return doc_cd;
	}
	public void setDoc_cd(String doc_cd) {
		this.doc_cd = doc_cd;
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
	public String getFrom_time() {
		return from_time;
	}
	public void setFrom_time(String from_time) {
		this.from_time = from_time;
	}
	public String getOrder_date() {
		return order_date;
	}
	public void setOrder_date(String order_date) {
		this.order_date = order_date;
	}
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
	public String getJob_name() {
		return job_name;
	}
	public void setJob_name(String job_name) {
		this.job_name = job_name;
	}
	public String getBefore_status() {
		return before_status;
	}
	public void setBefore_status(String before_status) {
		this.before_status = before_status;
	}
	public String getAfter_status() {
		return after_status;
	}
	public void setAfter_status(String after_status) {
		this.after_status = after_status;
	}
	public String getUser_nm() {
		return user_nm;
	}
	public void setUser_nm(String user_nm) {
		this.user_nm = user_nm;
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
	public String getIns_user_cd() {
		return ins_user_cd;
	}
	public void setIns_user_cd(String ins_user_cd) {
		this.ins_user_cd = ins_user_cd;
	}
	public String getIns_user_nm() {
		return ins_user_nm;
	}
	public void setIns_user_nm(String ins_user_nm) {
		this.ins_user_nm = ins_user_nm;
	}
	public String getIns_dept_nm() {
		return ins_dept_nm;
	}
	public void setIns_dept_nm(String ins_dept_nm) {
		this.ins_dept_nm = ins_dept_nm;
	}
	public String getIns_duty_nm() {
		return ins_duty_nm;
	}
	public void setIns_duty_nm(String ins_duty_nm) {
		this.ins_duty_nm = ins_duty_nm;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getFail_comment() {
		return fail_comment;
	}
	public void setFail_comment(String fail_comment) {
		this.fail_comment = fail_comment;
	}
	public String getApply_cd() {
		return apply_cd;
	}
	public void setApply_cd(String apply_cd) {
		this.apply_cd = apply_cd;
	}
	public String getApply_date() {
		return apply_date;
	}
	public void setApply_date(String apply_date) {
		this.apply_date = apply_date;
	}
	
	
}
