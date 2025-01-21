package com.ghayoun.ezjobs.comm.domain;

import java.io.Serializable;

@SuppressWarnings("serial")
public class AppGrpBean implements Serializable{

	private String grp_cd 			= "";
	private String grp_nm 			= "";
	private String grp_eng_nm 		= "";
	private String grp_depth 		= "";
	private String grp_parent_cd 	= "";
	private String grp_use_yn 		= "";
	private String grp_desc 		= "";
	private String grp_ins_date 	= "";
	private String grp_ins_user_cd 	= "";
	private String grp_udt_date 	= "";
	private String grp_udt_user_cd 	= "";
	private String scode_cd 		= "";
	private String scode_nm 		= "";
	private String host_cd 			= "";
	private String arr_host_cd 		= "";
	private String arr_host_nm 		= "";
	private String arr_host_desc 	= "";
	private String user_daily 		= "";
	private String ctm_user_daily 	= "";
	
	//C-M에서 테이블/어플리케이션/그룹 이관
	private String sched_table		= "";
	private String application		= "";
	private String group_name		= "";
	private String table_type		= "";
	
	private String chk_ctm_folder	= "";

	private String job_cnt			= "";
	private String app_job_cnt		= "";
	private String grp_job_cnt		= "";
	
	private String task_type		= "";
	private String table_id			= "";
	private String sub_table_nm		= "";
	
	public String getGrp_cd() {
		return grp_cd;
	}
	public void setGrp_cd(String grp_cd) {
		this.grp_cd = grp_cd;
	}
	public String getGrp_nm() {
		return grp_nm;
	}
	public void setGrp_nm(String grp_nm) {
		this.grp_nm = grp_nm;
	}
	public String getGrp_eng_nm() {
		return grp_eng_nm;
	}
	public void setGrp_eng_nm(String grp_eng_nm) {
		this.grp_eng_nm = grp_eng_nm;
	}
	public String getGrp_depth() {
		return grp_depth;
	}
	public void setGrp_depth(String grp_depth) {
		this.grp_depth = grp_depth;
	}
	public String getGrp_parent_cd() {
		return grp_parent_cd;
	}
	public void setGrp_parent_cd(String grp_parent_cd) {
		this.grp_parent_cd = grp_parent_cd;
	}
	public String getGrp_use_yn() {
		return grp_use_yn;
	}
	public void setGrp_use_yn(String grp_use_yn) {
		this.grp_use_yn = grp_use_yn;
	}
	public String getGrp_desc() {
		return grp_desc;
	}
	public void setGrp_desc(String grp_desc) {
		this.grp_desc = grp_desc;
	}
	public String getGrp_ins_date() {
		return grp_ins_date;
	}
	public void setGrp_ins_date(String grp_ins_date) {
		this.grp_ins_date = grp_ins_date;
	}
	public String getGrp_ins_user_cd() {
		return grp_ins_user_cd;
	}
	public void setGrp_ins_user_cd(String grp_ins_user_cd) {
		this.grp_ins_user_cd = grp_ins_user_cd;
	}
	public String getGrp_udt_date() {
		return grp_udt_date;
	}
	public void setGrp_udt_date(String grp_udt_date) {
		this.grp_udt_date = grp_udt_date;
	}
	public String getGrp_udt_user_cd() {
		return grp_udt_user_cd;
	}
	public void setGrp_udt_user_cd(String grp_udt_user_cd) {
		this.grp_udt_user_cd = grp_udt_user_cd;
	}
	public String getScode_cd() {
		return scode_cd;
	}
	public void setScode_cd(String scode_cd) {
		this.scode_cd = scode_cd;
	}
	public String getHost_cd() {
		return host_cd;
	}
	public void setHost_cd(String host_cd) {
		this.host_cd = host_cd;
	}
	public String getArr_host_cd() {
		return arr_host_cd;
	}
	public void setArr_host_cd(String arr_host_cd) {
		this.arr_host_cd = arr_host_cd;
	}
	public String getArr_host_nm() {
		return arr_host_nm;
	}
	public void setArr_host_nm(String arr_host_nm) {
		this.arr_host_nm = arr_host_nm;
	}
	public String getArr_host_desc() {
		return arr_host_desc;
	}
	public void setArr_host_desc(String arr_host_desc) {
		this.arr_host_desc = arr_host_desc;
	}
	public String getUser_daily() {
		return user_daily;
	}
	public void setUser_daily(String user_daily) {
		this.user_daily = user_daily;
	}
	public String getCtm_user_daily() {
		return ctm_user_daily;
	}
	public void setCtm_user_daily(String ctm_user_daily) {
		this.ctm_user_daily = ctm_user_daily;
	}
	public String getSched_table() {
		return sched_table;
	}
	public void setSched_table(String sched_table) {
		this.sched_table = sched_table;
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
	public String getTable_type() {
		return table_type;
	}
	public void setTable_type(String table_type) {
		this.table_type = table_type;
	}
	public String getChk_ctm_folder() {
		return chk_ctm_folder;
	}
	public void setChk_ctm_folder(String chk_ctm_folder) {
		this.chk_ctm_folder = chk_ctm_folder;
	}
	public String getScode_nm() {
		return scode_nm;
	}
	public void setScode_nm(String scode_nm) {
		this.scode_nm = scode_nm;
	}
	public String getJob_cnt() {
		return job_cnt;
	}
	public void setJob_cnt(String job_cnt) {
		this.job_cnt = job_cnt;
	}
	public String getApp_job_cnt() {
		return app_job_cnt;
	}
	public void setApp_job_cnt(String app_job_cnt) {
		this.app_job_cnt = app_job_cnt;
	}
	public String getGrp_job_cnt() {
		return grp_job_cnt;
	}
	public void setGrp_job_cnt(String grp_job_cnt) {
		this.grp_job_cnt = grp_job_cnt;
	}
	public String getTask_type() {
		return task_type;
	}
	public void setTask_type(String task_type) {
		this.task_type = task_type;
	}
	public String getTable_id() {
		return table_id;
	}
	public void setTable_id(String table_id) {
		this.table_id = table_id;
	}
	public String getSub_table_nm() {
		return sub_table_nm;
	}
	public void setSub_table_nm(String sub_table_nm) {
		this.sub_table_nm = sub_table_nm;
	}
	
}
