package com.ghayoun.ezjobs.t.domain;

import java.io.Serializable;

public class ConfirmBean implements Serializable {
	
	private String confirm_cd			= "";
	private String confirm_yn			= "";
	private String confirm_n_hour		= "";
	private String confirm_y_hour		= "";
	
	private String ins_date				= "";
	private String ins_user_cd			= "";
	private String ins_user_ip			= "";
	
	private String udt_date				= "";
	private String udt_user_cd			= "";
	private String udt_user_ip			= "";

	public String getConfirm_cd() {
		return confirm_cd;
	}
	public void setConfirm_cd(String confirm_cd) {
		this.confirm_cd = confirm_cd;
	}
	public String getConfirm_yn() {
		return confirm_yn;
	}
	public void setConfirm_yn(String confirm_yn) {
		this.confirm_yn = confirm_yn;
	}
	public String getConfirm_n_hour() {
		return confirm_n_hour;
	}
	public void setConfirm_n_hour(String confirm_n_hour) {
		this.confirm_n_hour = confirm_n_hour;
	}
	public String getConfirm_y_hour() {
		return confirm_y_hour;
	}
	public void setConfirm_y_hour(String confirm_y_hour) {
		this.confirm_y_hour = confirm_y_hour;
	}
	public String getIns_date() {
		return ins_date;
	}
	public void setIns_date(String ins_date) {
		this.ins_date = ins_date;
	}
	public String getIns_user_cd() {
		return ins_user_cd;
	}
	public void setIns_user_cd(String ins_user_cd) {
		this.ins_user_cd = ins_user_cd;
	}
	public String getIns_user_ip() {
		return ins_user_ip;
	}
	public void setIns_user_ip(String ins_user_ip) {
		this.ins_user_ip = ins_user_ip;
	}
	public String getUdt_date() {
		return udt_date;
	}
	public void setUdt_date(String udt_date) {
		this.udt_date = udt_date;
	}
	public String getUdt_user_cd() {
		return udt_user_cd;
	}
	public void setUdt_user_cd(String udt_user_cd) {
		this.udt_user_cd = udt_user_cd;
	}
	public String getUdt_user_ip() {
		return udt_user_ip;
	}
	public void setUdt_user_ip(String udt_user_ip) {
		this.udt_user_ip = udt_user_ip;
	}
	
}
