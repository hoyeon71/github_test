package com.ghayoun.ezjobs.m.domain;

import java.io.Serializable;

public class PreJobMissMatchBean implements Serializable {

	private int grid_idx 		= 0;
	private int row_num 		= 0;
	private String sn 			= "";
	private String odate 		= "";
	private String order_table 	= "";
	private String application 	= "";
	private String group_name 	= "";
	private String job_name 	= "";
	private String memname 		= "";
	private String condition 	= "";
	private String sched_table 	= "";
	
	public int getRow_num() {
		return row_num;
	}
	public void setRow_num(int row_num) {
		this.row_num = row_num;
	}
	public String getOdate() {
		return odate;
	}
	public void setOdate(String odate) {
		this.odate = odate;
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
	public String getJob_name() {
		return job_name;
	}
	public void setJob_name(String job_name) {
		this.job_name = job_name;
	}
	public String getCondition() {
		return condition;
	}
	public void setCondition(String condition) {
		this.condition = condition;
	}
	public String getMemname() {
		return memname;
	}
	public void setMemname(String memname) {
		this.memname = memname;
	}
	public String getSn() {
		return sn;
	}
	public void setSn(String sn) {
		this.sn = sn;
	}
	public String getSched_table() {
		return sched_table;
	}
	public void setSched_table(String sched_table) {
		this.sched_table = sched_table;
	}
	public int getGrid_idx() {
		return grid_idx;
	}
	public void setGrid_idx(int grid_idx) {
		this.grid_idx = grid_idx;
	}
	
}
