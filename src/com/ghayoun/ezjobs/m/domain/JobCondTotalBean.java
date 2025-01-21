package com.ghayoun.ezjobs.m.domain;

import java.io.Serializable;

public class JobCondTotalBean implements Serializable {

	private String data_center;
	private String order_table;
	private String application;
	private String group_name;
	
	private String reg_ok_cnt;
	private String reg_fail_cnt;
	private String reg_wait_cnt;
	private String reg_etc_cnt;
	private String reg_total_cnt;
	private String irreg_ok_cnt;
	private String irreg_fail_cnt;
	private String irreg_wait_cnt;
	private String irreg_etc_cnt;
	private String irreg_total_cnt;
	private String smart_job_yn;

	public String getData_center() {
		return data_center;
	}

	public void setData_center(String data_center) {
		this.data_center = data_center;
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

	public String getReg_ok_cnt() {
		return reg_ok_cnt;
	}

	public void setReg_ok_cnt(String reg_ok_cnt) {
		this.reg_ok_cnt = reg_ok_cnt;
	}

	public String getReg_fail_cnt() {
		return reg_fail_cnt;
	}

	public void setReg_fail_cnt(String reg_fail_cnt) {
		this.reg_fail_cnt = reg_fail_cnt;
	}

	public String getReg_wait_cnt() {
		return reg_wait_cnt;
	}

	public void setReg_wait_cnt(String reg_wait_cnt) {
		this.reg_wait_cnt = reg_wait_cnt;
	}

	public String getReg_etc_cnt() {
		return reg_etc_cnt;
	}

	public void setReg_etc_cnt(String reg_etc_cnt) {
		this.reg_etc_cnt = reg_etc_cnt;
	}

	public String getReg_total_cnt() {
		return reg_total_cnt;
	}

	public void setReg_total_cnt(String reg_total_cnt) {
		this.reg_total_cnt = reg_total_cnt;
	}

	public String getIrreg_ok_cnt() {
		return irreg_ok_cnt;
	}

	public void setIrreg_ok_cnt(String irreg_ok_cnt) {
		this.irreg_ok_cnt = irreg_ok_cnt;
	}

	public String getIrreg_fail_cnt() {
		return irreg_fail_cnt;
	}

	public void setIrreg_fail_cnt(String irreg_fail_cnt) {
		this.irreg_fail_cnt = irreg_fail_cnt;
	}

	public String getIrreg_wait_cnt() {
		return irreg_wait_cnt;
	}

	public void setIrreg_wait_cnt(String irreg_wait_cnt) {
		this.irreg_wait_cnt = irreg_wait_cnt;
	}

	public String getIrreg_etc_cnt() {
		return irreg_etc_cnt;
	}

	public void setIrreg_etc_cnt(String irreg_etc_cnt) {
		this.irreg_etc_cnt = irreg_etc_cnt;
	}

	public String getIrreg_total_cnt() {
		return irreg_total_cnt;
	}

	public void setIrreg_total_cnt(String irreg_total_cnt) {
		this.irreg_total_cnt = irreg_total_cnt;
	}

	public String getSmart_job_yn() {
		return smart_job_yn;
	}

	public void setSmart_job_yn(String smart_job_yn) {
		this.smart_job_yn = smart_job_yn;
	}
	
}
