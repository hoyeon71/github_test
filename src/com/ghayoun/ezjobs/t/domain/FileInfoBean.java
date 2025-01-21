package com.ghayoun.ezjobs.t.domain;

import java.io.Serializable;

public class FileInfoBean implements Serializable {
	
	private static final long serialVersionUID = 6344239370608592308L;
	
	private String file_path;
	private String file_name;
	private String file_desc;
	
	public String getFile_path() {
		return file_path;
	}
	public void setFile_path(String file_path) {
		this.file_path = file_path;
	}
	public String getFile_name() {
		return file_name;
	}
	public void setFile_name(String file_name) {
		this.file_name = file_name;
	}
	public String getFile_desc() {
		return file_desc;
	}
	public void setFile_desc(String file_desc) {
		this.file_desc = file_desc;
	}
	
}
