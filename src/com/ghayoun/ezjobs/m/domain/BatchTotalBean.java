package com.ghayoun.ezjobs.m.domain;

import java.io.Serializable;

public class BatchTotalBean implements Serializable {
	
	private String data_center;
	private String table_name;
	private String application;
	private String group_name;
	private String reg_new_cnt;
	private String reg_mod_cnt;
	private String reg_del_cnt;
	private String reg_ord_cnt;
	private String reg_chg_cond_cnt;
	private String irreg_new_cnt;
	private String irreg_mod_cnt;
	private String irreg_del_cnt;
	private String irreg_ord_cnt;
	private String irreg_chg_cond_cnt;
	private String total_cnt;
	private String smart_job_yn;

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
	public String getReg_new_cnt() {
		return reg_new_cnt;
	}
	public void setReg_new_cnt(String reg_new_cnt) {
		this.reg_new_cnt = reg_new_cnt;
	}
	public String getReg_mod_cnt() {
		return reg_mod_cnt;
	}
	public void setReg_mod_cnt(String reg_mod_cnt) {
		this.reg_mod_cnt = reg_mod_cnt;
	}
	public String getReg_del_cnt() {
		return reg_del_cnt;
	}
	public void setReg_del_cnt(String reg_del_cnt) {
		this.reg_del_cnt = reg_del_cnt;
	}
	public String getReg_ord_cnt() {
		return reg_ord_cnt;
	}
	public void setReg_ord_cnt(String reg_ord_cnt) {
		this.reg_ord_cnt = reg_ord_cnt;
	}
	public String getReg_chg_cond_cnt() {
		return reg_chg_cond_cnt;
	}
	public void setReg_chg_cond_cnt(String reg_chg_cond_cnt) {
		this.reg_chg_cond_cnt = reg_chg_cond_cnt;
	}
	public String getIrreg_new_cnt() {
		return irreg_new_cnt;
	}
	public void setIrreg_new_cnt(String irreg_new_cnt) {
		this.irreg_new_cnt = irreg_new_cnt;
	}
	public String getIrreg_mod_cnt() {
		return irreg_mod_cnt;
	}
	public void setIrreg_mod_cnt(String irreg_mod_cnt) {
		this.irreg_mod_cnt = irreg_mod_cnt;
	}
	public String getIrreg_del_cnt() {
		return irreg_del_cnt;
	}
	public void setIrreg_del_cnt(String irreg_del_cnt) {
		this.irreg_del_cnt = irreg_del_cnt;
	}
	public String getIrreg_ord_cnt() {
		return irreg_ord_cnt;
	}
	public void setIrreg_ord_cnt(String irreg_ord_cnt) {
		this.irreg_ord_cnt = irreg_ord_cnt;
	}
	public String getIrreg_chg_cond_cnt() {
		return irreg_chg_cond_cnt;
	}
	public void setIrreg_chg_cond_cnt(String irreg_chg_cond_cnt) {
		this.irreg_chg_cond_cnt = irreg_chg_cond_cnt;
	}
	public String getTotal_cnt() {
		return total_cnt;
	}
	public void setTotal_cnt(String total_cnt) {
		this.total_cnt = total_cnt;
	}
	public String getSmart_job_yn() {
		return smart_job_yn;
	}
	public void setSmart_job_yn(String smart_job_yn) {
		this.smart_job_yn = smart_job_yn;
	}
}
