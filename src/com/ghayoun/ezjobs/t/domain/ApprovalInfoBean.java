package com.ghayoun.ezjobs.t.domain;

import java.io.Serializable;

public class ApprovalInfoBean implements Serializable {
	
	private String doc_cd			= "";
	private String seq				= "";
	private String user_cd			= "";
	private String user_id			= "";
	private String user_nm			= "";
	private String dept_cd			= "";
	private String dept_nm			= "";
	private String duty_cd			= "";
	private String duty_nm			= "";
	private String part_nm			= "";
	private String approval_cd		= "";
	private String approval_date	= "";
	private String approval_comment	= "";
	
	private String ins_date       = "";
	private String ins_user_cd    = "";
	private String ins_user_ip    = "";
	private String udt_date       = "";
	private String udt_user_cd    = "";
	private String udt_user_ip    = "";
	
	private String approval_ment  	= "";
	private String cur_approval_seq = "";
	
	private String absence_user_cd 	= "";
	private String absence_user_nm 	= "";
	private String absence_duty_nm 	= "";
	private String absence_dept_nm 	= "";
	private String absence_part_nm 	= "";
	
	private String update_user_nm 	= "";
	private String update_duty_nm 	= "";
	private String update_dept_nm 	= "";
	private String update_part_nm 	= "";
	
	private String line_gb 				= "";
	private String approval_gb 			= "";
	private String group_line_grp_nm 	= "";
	private String udt_user_nm		 	= "";
	private String group_line_ok_cnt	= "";
	private String state_cd				= "";
	private String approval_type		= "";
	
	
	public String getDoc_cd() {
		return doc_cd;
	}
	public void setDoc_cd(String doc_cd) {
		this.doc_cd = doc_cd;
	}
	public String getSeq() {
		return seq;
	}
	public void setSeq(String seq) {
		this.seq = seq;
	}
	public String getUser_cd() {
		return user_cd;
	}
	public void setUser_cd(String user_cd) {
		this.user_cd = user_cd;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getUser_nm() {
		return user_nm;
	}
	public void setUser_nm(String user_nm) {
		this.user_nm = user_nm;
	}
	public String getDept_cd() {
		return dept_cd;
	}
	public void setDept_cd(String dept_cd) {
		this.dept_cd = dept_cd;
	}
	public String getDuty_cd() {
		return duty_cd;
	}
	public void setDuty_cd(String duty_cd) {
		this.duty_cd = duty_cd;
	}
	public String getApproval_cd() {
		return approval_cd;
	}
	public void setApproval_cd(String approval_cd) {
		this.approval_cd = approval_cd;
	}
	public String getApproval_date() {
		return approval_date;
	}
	public void setApproval_date(String approval_date) {
		this.approval_date = approval_date;
	}
	public String getApproval_comment() {
		return approval_comment;
	}
	public void setApproval_comment(String approval_comment) {
		this.approval_comment = approval_comment;
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
	public String getDept_nm() {
		return dept_nm;
	}
	public void setDept_nm(String dept_nm) {
		this.dept_nm = dept_nm;
	}
	public String getDuty_nm() {
		return duty_nm;
	}
	public void setDuty_nm(String duty_nm) {
		this.duty_nm = duty_nm;
	}
	public String getApproval_ment() {
		return approval_ment;
	}
	public void setApproval_ment(String approvalMent) {
		approval_ment = approvalMent;
	}
	public String getCur_approval_seq() {
		return cur_approval_seq;
	}
	public void setCur_approval_seq(String curApprovalSeq) {
		cur_approval_seq = curApprovalSeq;
	}
	public String getAbsence_user_cd() {
		return absence_user_cd;
	}
	public void setAbsence_user_cd(String absenceUserCd) {
		absence_user_cd = absenceUserCd;
	}
	public String getAbsence_user_nm() {
		return absence_user_nm;
	}
	public void setAbsence_user_nm(String absenceUserNm) {
		absence_user_nm = absenceUserNm;
	}
	public String getAbsence_duty_nm() {
		return absence_duty_nm;
	}
	public void setAbsence_duty_nm(String absenceDutyNm) {
		absence_duty_nm = absenceDutyNm;
	}
	public String getAbsence_dept_nm() {
		return absence_dept_nm;
	}
	public void setAbsence_dept_nm(String absenceDeptNm) {
		absence_dept_nm = absenceDeptNm;
	}
	public String getUpdate_user_nm() {
		return update_user_nm;
	}
	public void setUpdate_user_nm(String updateUserNm) {
		update_user_nm = updateUserNm;
	}
	public String getUpdate_duty_nm() {
		return update_duty_nm;
	}
	public void setUpdate_duty_nm(String updateDutyNm) {
		update_duty_nm = updateDutyNm;
	}
	public String getUpdate_dept_nm() {
		return update_dept_nm;
	}
	public void setUpdate_dept_nm(String updateDeptNm) {
		update_dept_nm = updateDeptNm;
	}
	public String getPart_nm() {
		return part_nm;
	}
	public void setPart_nm(String partNm) {
		part_nm = partNm;
	}
	public String getAbsence_part_nm() {
		return absence_part_nm;
	}
	public void setAbsence_part_nm(String absencePartNm) {
		absence_part_nm = absencePartNm;
	}
	public String getUpdate_part_nm() {
		return update_part_nm;
	}
	public void setUpdate_part_nm(String updatePartNm) {
		update_part_nm = updatePartNm;
	}
	public String getLine_gb() {
		return line_gb;
	}
	public void setLine_gb(String line_gb) {
		this.line_gb = line_gb;
	}
	public String getApproval_gb() {
		return approval_gb;
	}
	public void setApproval_gb(String approval_gb) {
		this.approval_gb = approval_gb;
	}
	public String getGroup_line_grp_nm() {
		return group_line_grp_nm;
	}
	public void setGroup_line_grp_nm(String group_line_grp_nm) {
		this.group_line_grp_nm = group_line_grp_nm;
	}
	public String getUdt_user_nm() {
		return udt_user_nm;
	}
	public void setUdt_user_nm(String udt_user_nm) {
		this.udt_user_nm = udt_user_nm;
	}
	public String getGroup_line_ok_cnt() {
		return group_line_ok_cnt;
	}
	public void setGroup_line_ok_cnt(String group_line_ok_cnt) {
		this.group_line_ok_cnt = group_line_ok_cnt;
	}
	public String getState_cd() {
		return state_cd;
	}
	public void setState_cd(String state_cd) {
		this.state_cd = state_cd;
	}
	public String getApproval_type() {
		return approval_type;
	}
	public void setApproval_type(String approval_type) {
		this.approval_type = approval_type;
	}
	
	
}
