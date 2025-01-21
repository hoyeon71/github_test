package com.ghayoun.ezjobs.t.domain;

import java.io.Serializable;
import java.util.Date;

public class DocFileInfoBean extends FileInfoBean implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -8558190287268118990L;
	private String doc_cd;
	private Integer seq;
	private String order_id;
	private Integer order_seq;
	private Date check_date;
	private String job_name;
	
	public String getJob_name() {
		return job_name;
	}
	public void setJob_name(String job_name) {
		this.job_name = job_name;
	}
	public String getDoc_cd() {
		return doc_cd;
	}
	public void setDoc_cd(String doc_cd) {
		this.doc_cd = doc_cd;
	}
	public Integer getSeq() {
		return seq;
	}
	public void setSeq(Integer seq) {
		this.seq = seq;
	}
	public String getOrder_id() {
		return order_id;
	}
	public void setOrder_id(String order_id) {
		this.order_id = order_id;
	}
	public Integer getOrder_seq() {
		return order_seq;
	}
	public void setOrder_seq(Integer order_seq) {
		this.order_seq = order_seq;
	}
	public Date getCheck_date() {
		return check_date;
	}
	public void setCheck_date(Date check_date) {
		this.check_date = check_date;
	}
	
}
