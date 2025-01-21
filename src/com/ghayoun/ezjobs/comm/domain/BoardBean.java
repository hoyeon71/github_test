package com.ghayoun.ezjobs.comm.domain;

import java.io.Serializable;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

@SuppressWarnings("serial")
public class BoardBean implements Serializable{

	private int row_num 				= 0;
	private String board_cd 			= "";
	private String title 				= "";
	private String content 				= "";
	private String status 				= "";
	private String ins_user_cd 			= "";
	private String app_user_cd 			= "";
	private String ins_date 			= "";
	private List<MultipartFile> files 	= null;
	private String ins_user_nm 			= "";
	private String app_user_nm 			= "";
	private String file_nm 				= "";
	private String file_path	 		= "";
	private String noti_yn 				= "";
	private String del_yn 				= "";
	private String board_gb 			= "";
	private String seq 					= "";
	private String popup_yn 			= "";
	private String popup_s_date 		= "";
	private String popup_e_date 		= "";
	
	private List<MultipartFile> files2 = null;
	private List<MultipartFile> files3 = null;
	private List<MultipartFile> errfiles = null;
	
	public int getRow_num() {
		return row_num;
	}
	public void setRow_num(int row_num) {
		this.row_num = row_num;
	}
	public String getBoard_cd() {
		return board_cd;
	}
	public void setBoard_cd(String board_cd) {
		this.board_cd = board_cd;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getIns_user_cd() {
		return ins_user_cd;
	}
	public void setIns_user_cd(String ins_user_cd) {
		this.ins_user_cd = ins_user_cd;
	}
	public String getApp_user_cd() {
		return app_user_cd;
	}
	public void setApp_user_cd(String app_user_cd) {
		this.app_user_cd = app_user_cd;
	}
	public String getIns_date() {
		return ins_date;
	}
	public void setIns_date(String ins_date) {
		this.ins_date = ins_date;
	}
	public List<MultipartFile> getFiles() {
		return files;
	}
	public void setFiles(List<MultipartFile> files) {
		this.files = files;
	}
	public String getIns_user_nm() {
		return ins_user_nm;
	}
	public void setIns_user_nm(String ins_user_nm) {
		this.ins_user_nm = ins_user_nm;
	}
	public String getApp_user_nm() {
		return app_user_nm;
	}
	public void setApp_user_nm(String app_user_nm) {
		this.app_user_nm = app_user_nm;
	}
	public String getFile_nm() {
		return file_nm;
	}
	public void setFile_nm(String file_nm) {
		this.file_nm = file_nm;
	}
	public String getFile_path() {
		return file_path;
	}
	public void setFile_path(String file_path) {
		this.file_path = file_path;
	}
	public String getNoti_yn() {
		return noti_yn;
	}
	public void setNoti_yn(String noti_yn) {
		this.noti_yn = noti_yn;
	}
	public String getDel_yn() {
		return del_yn;
	}
	public void setDel_yn(String del_yn) {
		this.del_yn = del_yn;
	}
	public String getBoard_gb() {
		return board_gb;
	}
	public void setBoard_gb(String board_gb) {
		this.board_gb = board_gb;
	}
	public List<MultipartFile> getFiles2() {
		return files2;
	}
	public void setFiles2(List<MultipartFile> files2) {
		this.files2 = files2;
	}
	public List<MultipartFile> getFiles3() {
		return files3;
	}
	public void setFiles3(List<MultipartFile> files3) {
		this.files3 = files3;
	}
	public List<MultipartFile> getErrfiles() {
		return errfiles;
	}
	public void setErrfiles(List<MultipartFile> errfiles) {
		this.errfiles = errfiles;
	}
	public String getSeq() {
		return seq;
	}
	public void setSeq(String seq) {
		this.seq = seq;
	}
	public String getPopup_yn() {
		return popup_yn;
	}
	public void setPopup_yn(String popup_yn) {
		this.popup_yn = popup_yn;
	}
	public String getPopup_s_date() {
		return popup_s_date;
	}
	public void setPopup_s_date(String popup_s_date) {
		this.popup_s_date = popup_s_date;
	}
	public String getPopup_e_date() {
		return popup_e_date;
	}
	public void setPopup_e_date(String popup_e_date) {
		this.popup_e_date = popup_e_date;
	}	
		
}