package com.ghayoun.ezjobs.m.domain;

import java.io.Serializable;

public class DocApprovalTotalBean implements Serializable {

	private String data_center;
	private String dept_nm;
	private String table_name;
	private String doc_new_cnt;
	private String doc_mod_cnt;
	private String doc_del_cnt;
	private String doc_ord_cnt;
	private String doc_excel_cnt;
	private String doc_chg_cond_cnt;
	private String doc_urg_cnt;
	private String total_cnt;
	private String smart_job_yn;

	public String getData_center() {
		return data_center;
	}
	public void setData_center(String data_center) {
		this.data_center = data_center;
	}
	public String getDept_nm() {
		return dept_nm;
	}
	public void setDept_nm(String dept_nm) {
		this.dept_nm = dept_nm;
	}
	public String getTable_name() {
		return table_name;
	}
	public void setTable_name(String table_name) {
		this.table_name = table_name;
	}
	public String getDoc_new_cnt() {
		return doc_new_cnt;
	}
	public void setDoc_new_cnt(String doc_new_cnt) {
		this.doc_new_cnt = doc_new_cnt;
	}
	public String getDoc_mod_cnt() {
		return doc_mod_cnt;
	}
	public void setDoc_mod_cnt(String doc_mod_cnt) {
		this.doc_mod_cnt = doc_mod_cnt;
	}
	public String getDoc_del_cnt() {
		return doc_del_cnt;
	}
	public void setDoc_del_cnt(String doc_del_cnt) {
		this.doc_del_cnt = doc_del_cnt;
	}
	public String getDoc_ord_cnt() {
		return doc_ord_cnt;
	}
	public void setDoc_ord_cnt(String doc_ord_cnt) {
		this.doc_ord_cnt = doc_ord_cnt;
	}
	public String getDoc_excel_cnt() {
		return doc_excel_cnt;
	}
	public void setDoc_excel_cnt(String doc_excel_cnt) {
		this.doc_excel_cnt = doc_excel_cnt;
	}
	public String getDoc_chg_cond_cnt() {
		return doc_chg_cond_cnt;
	}
	public void setDoc_chg_cond_cnt(String doc_chg_cond_cnt) {
		this.doc_chg_cond_cnt = doc_chg_cond_cnt;
	}
	public String getTotal_cnt() {
		return total_cnt;
	}
	public void setTotal_cnt(String total_cnt) {
		this.total_cnt = total_cnt;
	}
	public String getDoc_urg_cnt() {
		return doc_urg_cnt;
	}
	public void setDoc_urg_cnt(String doc_urg_cnt) {
		this.doc_urg_cnt = doc_urg_cnt;
	}
	public String getSmart_job_yn() {
		return smart_job_yn;
	}
	public void setSmart_job_yn(String smart_job_yn) {
		this.smart_job_yn = smart_job_yn;
	}
	
}
