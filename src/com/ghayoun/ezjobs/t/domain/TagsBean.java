package com.ghayoun.ezjobs.t.domain;

import java.io.Serializable;

public class TagsBean implements Serializable {
	
	private String doc_cd				= "";
	private String tag_cd				= "";
	private String tag_name				= "";
	private String table_id				= "";
	private String job_id				= "";
	private String tag_relation_dc_wc	= "";
	private String month_1				= "";
	private String month_2				= "";
	private String month_3				= "";
	private String month_4				= "";
	private String month_5				= "";
	private String month_6				= "";
	private String month_7				= "";
	private String month_8				= "";
	private String month_9				= "";
	private String month_10				= "";
	private String month_11				= "";
	private String month_12				= "";
	private String days_cal				= "";
	private String weeks_cal			= "";
	private String dates_str			= "";
	private String day_str				= "";
	private String w_day_str			= "";
	private String active_from			= "";
	private String active_till			= "";
	
	public String getMonth(int n){
		if(n==1) return getMonth_1();
		if(n==2) return getMonth_2();
		if(n==3) return getMonth_3();
		if(n==4) return getMonth_4();
		if(n==5) return getMonth_5();
		if(n==6) return getMonth_6();
		if(n==7) return getMonth_7();
		if(n==8) return getMonth_8();
		if(n==9) return getMonth_9();
		if(n==10) return getMonth_10();
		if(n==11) return getMonth_11();
		if(n==12) return getMonth_12();
		
		return "";
	}
	
	public String getDoc_cd() {
		return doc_cd;
	}
	public void setDoc_cd(String docCd) {
		doc_cd = docCd;
	}
	public String getTag_cd() {
		return tag_cd;
	}
	public void setTag_cd(String tagCd) {
		tag_cd = tagCd;
	}
	public String getTag_name() {
		return tag_name;
	}
	public void setTag_name(String tagName) {
		tag_name = tagName;
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
	public String getTag_relation_dc_wc() {
		return tag_relation_dc_wc;
	}
	public void setTag_relation_dc_wc(String tagRelationDcWc) {
		tag_relation_dc_wc = tagRelationDcWc;
	}
	public String getMonth_1() {
		return month_1;
	}
	public void setMonth_1(String month_1) {
		this.month_1 = month_1;
	}
	public String getMonth_2() {
		return month_2;
	}
	public void setMonth_2(String month_2) {
		this.month_2 = month_2;
	}
	public String getMonth_3() {
		return month_3;
	}
	public void setMonth_3(String month_3) {
		this.month_3 = month_3;
	}
	public String getMonth_4() {
		return month_4;
	}
	public void setMonth_4(String month_4) {
		this.month_4 = month_4;
	}
	public String getMonth_5() {
		return month_5;
	}
	public void setMonth_5(String month_5) {
		this.month_5 = month_5;
	}
	public String getMonth_6() {
		return month_6;
	}
	public void setMonth_6(String month_6) {
		this.month_6 = month_6;
	}
	public String getMonth_7() {
		return month_7;
	}
	public void setMonth_7(String month_7) {
		this.month_7 = month_7;
	}
	public String getMonth_8() {
		return month_8;
	}
	public void setMonth_8(String month_8) {
		this.month_8 = month_8;
	}
	public String getMonth_9() {
		return month_9;
	}
	public void setMonth_9(String month_9) {
		this.month_9 = month_9;
	}
	public String getMonth_10() {
		return month_10;
	}
	public void setMonth_10(String month_10) {
		this.month_10 = month_10;
	}
	public String getMonth_11() {
		return month_11;
	}
	public void setMonth_11(String month_11) {
		this.month_11 = month_11;
	}
	public String getMonth_12() {
		return month_12;
	}
	public void setMonth_12(String month_12) {
		this.month_12 = month_12;
	}
	public String getDays_cal() {
		return days_cal;
	}
	public void setDays_cal(String daysCal) {
		days_cal = daysCal;
	}
	public String getWeeks_cal() {
		return weeks_cal;
	}
	public void setWeeks_cal(String weeksCal) {
		weeks_cal = weeksCal;
	}
	public String getDates_str() {
		return dates_str;
	}
	public void setDates_str(String datesStr) {
		dates_str = datesStr;
	}
	public String getDay_str() {
		return day_str;
	}
	public void setDay_str(String dayStr) {
		day_str = dayStr;
	}
	public String getW_day_str() {
		return w_day_str;
	}
	public void setW_day_str(String wDayStr) {
		w_day_str = wDayStr;
	}

	public String getActive_from() {
		return active_from;
	}

	public void setActive_from(String activeFrom) {
		active_from = activeFrom;
	}

	public String getActive_till() {
		return active_till;
	}

	public void setActive_till(String activeTill) {
		active_till = activeTill;
	}
	
	

}
