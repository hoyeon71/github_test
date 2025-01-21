package com.ghayoun.ezjobs.t.domain;

import java.io.Serializable;

public class Doc12Bean implements Serializable {
	
	private String doc_cd             = "";
	private String title              = "";
	private String content            = "";
	private String ins_date           = "";
	private String seq                = "";
	private String data_center        = "";
	private String apply_date         = "";
	private String approval_date      = "";
	private String susi_title         = "";
	private String susi_content       = "";
	private String job_name           = "";
	private String dept_user_nm       = "";
	private String admin_user_nm      = "";
	private String dept_user_cd       = "";
	private String admin_user_cd      = "";
	private String data_center_name   = "";
	private String status   		  = "";
	
	private String ok_cnt   		  = "";
	private String notok_cnt   		  = "";
	private String wait_cnt   		  = "";
	private String etc_cnt   		  = "";
	private String total_cnt   		  = "";
	
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
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
	public String getIns_date() {
		return ins_date;
	}
	public void setIns_date(String ins_date) {
		this.ins_date = ins_date;
	}
	public String getSeq() {
		return seq;
	}
	public void setSeq(String seq) {
		this.seq = seq;
	}
	public String getData_center() {
		return data_center;
	}
	public void setData_center(String data_center) {
		this.data_center = data_center;
	}
	public String getApply_date() {
		return apply_date;
	}
	public void setApply_date(String apply_date) {
		this.apply_date = apply_date;
	}
	public String getApproval_date() {
		return approval_date;
	}
	public void setApproval_date(String approval_date) {
		this.approval_date = approval_date;
	}
	public String getSusi_title() {
		return susi_title;
	}
	public void setSusi_title(String susi_title) {
		this.susi_title = susi_title;
	}
	public String getSusi_content() {
		return susi_content;
	}
	public void setSusi_content(String susi_content) {
		this.susi_content = susi_content;
	}
	public String getJob_name() {
		return job_name;
	}
	public void setJob_name(String job_name) {
		this.job_name = job_name;
	}
	public String getDept_user_cd() {
		return dept_user_cd;
	}
	public void setDept_user_cd(String dept_user_cd) {
		this.dept_user_cd = dept_user_cd;
	}
	public String getAdmin_user_cd() {
		return admin_user_cd;
	}
	public void setAdmin_user_cd(String admin_user_cd) {
		this.admin_user_cd = admin_user_cd;
	}
	public String getDept_user_nm() {
		return dept_user_nm;
	}
	public void setDept_user_nm(String dept_user_nm) {
		this.dept_user_nm = dept_user_nm;
	}
	public String getAdmin_user_nm() {
		return admin_user_nm;
	}
	public void setAdmin_user_nm(String admin_user_nm) {
		this.admin_user_nm = admin_user_nm;
	}
	public String getData_center_name() {
		return data_center_name;
	}
	public void setData_center_name(String data_center_name) {
		this.data_center_name = data_center_name;
	}
	public String getOk_cnt() {
		return ok_cnt;
	}
	public void setOk_cnt(String ok_cnt) {
		this.ok_cnt = ok_cnt;
	}
	public String getNotok_cnt() {
		return notok_cnt;
	}
	public void setNotok_cnt(String notok_cnt) {
		this.notok_cnt = notok_cnt;
	}
	public String getWait_cnt() {
		return wait_cnt;
	}
	public void setWait_cnt(String wait_cnt) {
		this.wait_cnt = wait_cnt;
	}
	public String getEtc_cnt() {
		return etc_cnt;
	}
	public void setEtc_cnt(String etc_cnt) {
		this.etc_cnt = etc_cnt;
	}
	public String getTotal_cnt() {
		return total_cnt;
	}
	public void setTotal_cnt(String total_cnt) {
		this.total_cnt = total_cnt;
	}
	
	
	
}
