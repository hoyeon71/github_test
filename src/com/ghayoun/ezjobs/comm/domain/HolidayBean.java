package com.ghayoun.ezjobs.comm.domain;

import java.io.Serializable;

@SuppressWarnings("serial")
public class HolidayBean implements Serializable{

	private String yyyymmdd = "";
	private String title = "";
	private String ins_user_cd = "";
	private String ins_user_nm = "";
	private String ins_date = "";
	private String total_cnt = "";
	private int row_num = 0;
	
	public String getYyyymmdd() {
		return yyyymmdd;
	}
	public void setYyyymmdd(String yyyymmdd) {
		this.yyyymmdd = yyyymmdd;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
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
	public String getIns_date() {
		return ins_date;
	}
	public void setIns_date(String ins_date) {
		this.ins_date = ins_date;
	}
	public String getTotal_cnt() {
		return total_cnt;
	}
	public void setTotal_cnt(String total_cnt) {
		this.total_cnt = total_cnt;
	}
	public int getRow_num() {
		return row_num;
	}
	public void setRow_num(int row_num) {
		this.row_num = row_num;
	}
	
}
