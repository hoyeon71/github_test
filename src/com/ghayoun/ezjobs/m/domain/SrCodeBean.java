package com.ghayoun.ezjobs.m.domain;

import java.io.Serializable;

public class SrCodeBean implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -3669904905392699071L;
	private String relation_cd;
	private String db_name;
	private String user_name;
	private String table_name;
	private String relation_job_cd;
	private String data_center;
	private String job_name;
	private String relation_table;
	
	public String getRelation_table() {
		return relation_table;
	}
	public void setRelation_table(String relation_table) {
		this.relation_table = relation_table;
	}
	public String getRelation_cd() {
		return relation_cd;
	}
	public void setRelation_cd(String relation_cd) {
		this.relation_cd = relation_cd;
	}
	public String getDb_name() {
		return db_name;
	}
	public void setDb_name(String db_name) {
		this.db_name = db_name;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public String getTable_name() {
		return table_name;
	}
	public void setTable_name(String table_name) {
		this.table_name = table_name;
	}
	public String getRelation_job_cd() {
		return relation_job_cd;
	}
	public void setRelation_job_cd(String relation_job_cd) {
		this.relation_job_cd = relation_job_cd;
	}
	public String getData_center() {
		return data_center;
	}
	public void setData_center(String data_center) {
		this.data_center = data_center;
	}
	public String getJob_name() {
		return job_name;
	}
	public void setJob_name(String job_name) {
		this.job_name = job_name;
	}
	
}
