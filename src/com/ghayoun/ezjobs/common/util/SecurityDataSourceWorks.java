package com.ghayoun.ezjobs.common.util;

public class SecurityDataSourceWorks extends org.apache.commons.dbcp.BasicDataSource {

	public void setPassword(String password) {
		try{
			super.setPassword(CommonUtil.toCrypDec(password));
		}catch(Exception e){
			e.printStackTrace();
		}
	}
}