package com.ghayoun.ezjobs.m.domain;

import java.io.Serializable;

public class PreDateBatchScheduleBean implements Serializable {

	private int row_num              = 0;
	private String applgroup         = "";
	private String job_name          = "";
	private String user_nm           = "";
	private String days_cal          = "";
	private String day_str           = "";
	private String w_day_str         = "";
	private String weeks_cal         = "";
	private String monthstr          = "";
	private String odate             = "";
	private String developer         = "";
	private String contact           = "";
	private String description       = "";
	
	private String table_id          = "";
	private String job_id            = "";
	private String sched_table       = "";
	private String application       = "";
	private String group_name        = "";
	private String from_time         = "";
	private String node_id           = "";
	private String data_center_name  = "";
	private String data_center       = "";

	private String rel_table		 = "";
	private String order_hour	 	 = "";
	private String strReturnMsg      = "";

	private String gubun             = "";
	private String order_id          = "";
	private String smart_job_yn		 = "";

	public String getStrReturnMsg() {
		return strReturnMsg;
	}
	public void setStrReturnMsg(String strReturnMsg) {
		this.strReturnMsg = strReturnMsg;
	}
	public String getData_center() {
		return data_center;
	}
	public void setData_center(String data_center) {
		this.data_center = data_center;
	}
	public String getData_center_name() {
		return data_center_name;
	}
	public void setData_center_name(String data_center_name) {
		this.data_center_name = data_center_name;
	}
	public String getJob_name() {
		return job_name;
	}
	public void setJob_name(String job_name) {
		this.job_name = job_name;
	}
	public String getUser_nm() {
		return user_nm;
	}
	public void setUser_nm(String user_nm) {
		this.user_nm = user_nm;
	}
	public String getOrder_hour() {
		return order_hour;
	}
	public void setOrder_hour(String order_hour) {
		this.order_hour = order_hour;
	}
	public String getRel_table() {
		return rel_table;
	}
	public void setRel_table(String rel_table) {
		this.rel_table = rel_table;
	}
	public int getRow_num() {
		return row_num;
	}
	public void setRow_num(int row_num) {
		this.row_num = row_num;
	}
	public String getApplgroup() {
		return applgroup;
	}
	public void setApplgroup(String applgroup) {
		this.applgroup = applgroup;
	}
	public String getDays_cal() {
		return days_cal;
	}
	public void setDays_cal(String days_cal) {
		this.days_cal = days_cal;
	}
	public String getDay_str() {
		return day_str;
	}
	public void setDay_str(String day_str) {
		this.day_str = day_str;
	}
	public String getW_day_str() {
		return w_day_str;
	}
	public void setW_day_str(String w_day_str) {
		this.w_day_str = w_day_str;
	}
	public String getWeeks_cal() {
		return weeks_cal;
	}
	public void setWeeks_cal(String weeks_cal) {
		this.weeks_cal = weeks_cal;
	}
	public String getMonthstr() {
		return monthstr;
	}
	public void setMonthstr(String monthstr) {
		this.monthstr = monthstr;
	}
	public String getOdate() {
		return odate;
	}
	public void setOdate(String odate) {
		this.odate = odate;
	}
	public String getDeveloper() {
		return developer;
	}
	public void setDeveloper(String developer) {
		this.developer = developer;
	}
	public String getContact() {
		return contact;
	}
	public void setContact(String contact) {
		this.contact = contact;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getTable_id() {
		return table_id;
	}
	public void setTable_id(String tableId) {
		table_id = tableId;
	}
	public String getJob_id() {
		return job_id;
	}
	public void setJob_id(String jobId) {
		job_id = jobId;
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
	public String getFrom_time() {
		return from_time;
	}
	public void setFrom_time(String from_time) {
		this.from_time = from_time;
	}
	public String getNode_id() {
		return node_id;
	}
	public void setNode_id(String node_id) {
		this.node_id = node_id;
	}
	public String getGubun() {
		return gubun;
	}
	public void setGubun(String gubun) {
		this.gubun = gubun;
	}
	public String getOrder_id() {
		return order_id;
	}
	public void setOrder_id(String order_id) {
		this.order_id = order_id;
	}
	public String getSmart_job_yn() {
		return smart_job_yn;
	}
	public void setSmart_job_yn(String smart_job_yn) {
		this.smart_job_yn = smart_job_yn;
	}
}