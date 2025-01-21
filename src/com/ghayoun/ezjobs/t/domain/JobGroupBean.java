package com.ghayoun.ezjobs.t.domain;

import java.io.Serializable;

public class JobGroupBean implements Serializable {
	
	private int row_num 			= 0;
	
	private String jobgroup_id		= "";
	private String jobgroup_name	= "";
	private String ins_user_cd    	= "";
	private String ins_user_nm    	= "";
	private String ins_date       	= "";
	private String udt_user_cd    	= "";
	private String udt_user_nm    	= "";
	private String udt_date       	= "";
	private String content       	= "";
	
	private String job_name       	= "";
	private String data_center     	= "";
	
	private String grp_detail_cnt  	= "";
	private String count		  	= "";
	
	public int getRow_num() {
		return row_num;
	}
	public void setRow_num(int rowNum) {
		row_num = rowNum;
	}
	public String getJobgroup_id() {
		return jobgroup_id;
	}
	public void setJobgroup_id(String jobgroupId) {
		jobgroup_id = jobgroupId;
	}
	public String getJobgroup_name() {
		return jobgroup_name;
	}
	public void setJobgroup_name(String jobgroupName) {
		jobgroup_name = jobgroupName;
	}
	public String getIns_user_cd() {
		return ins_user_cd;
	}
	public void setIns_user_cd(String insUserCd) {
		ins_user_cd = insUserCd;
	}
	public String getIns_date() {
		return ins_date;
	}
	public void setIns_date(String insDate) {
		ins_date = insDate;
	}
	public String getUdt_user_cd() {
		return udt_user_cd;
	}
	public void setUdt_user_cd(String udtUserCd) {
		udt_user_cd = udtUserCd;
	}
	public String getUdt_date() {
		return udt_date;
	}
	public void setUdt_date(String udtDate) {
		udt_date = udtDate;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getIns_user_nm() {
		return ins_user_nm;
	}
	public void setIns_user_nm(String insUserNm) {
		ins_user_nm = insUserNm;
	}
	public String getUdt_user_nm() {
		return udt_user_nm;
	}
	public void setUdt_user_nm(String udtUserNm) {
		udt_user_nm = udtUserNm;
	}
	public String getJob_name() {
		return job_name;
	}
	public void setJob_name(String jobName) {
		job_name = jobName;
	}
	public String getData_center() {
		return data_center;
	}
	public void setData_center(String dataCenter) {
		data_center = dataCenter;
	}
	public String getGrp_detail_cnt() { 
		return grp_detail_cnt;
	}
	public void setGrp_detail_cnt(String grpDetailCnt) {
		this.grp_detail_cnt = grpDetailCnt;
	}
	public String getCount() {
		return count;
	}
	public void setCount(String count) {
		this.count = count;
	}
}
