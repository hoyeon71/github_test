package com.ghayoun.ezjobs.m.domain;

import java.io.Serializable;

public class TotalJobStatus implements Serializable {

	private String data_center_code = "";
	private String data_center = "";
	private String sub_data_center = "";
	private String active_net_name = "";

	private int total_count  		= 0;
	private int ended_ok 			= 0;
	private int ended_not_ok 		= 0;
	private int executing 			= 0;
	private int wait_condition 		= 0;
	private int wait_node 		= 0;
	private int wait_resource 		= 0;
	private int wait_user 			= 0;
	private int not_in_ajf 			= 0;
	private int unknown 			= 0;
	private int wait_time 			= 0;
	private int held 				= 0;
	private int deleted 			= 0;
	
	private String biz_gb 			= "";
	private int success 			= 0;
	private int fail 				= 0;
	private int wait 				= 0;
	private int running 			= 0;
	
	private String start_h 			= "";
	private int cnt_0 				= 0;
	private int cnt_1 				= 0;
	private int cnt_2 				= 0;
	private int cnt_3 				= 0;
	private int cnt_4 				= 0;
	private int cnt_5 				= 0;
	private int cnt_6 				= 0;
	
	private String order_table		= "";
	private String application		= "";
	private String gubun			= "";
	
	public String getData_center() {
		return data_center;
	}
	public void setData_center(String data_center) {
		this.data_center = data_center;
	}
	public int getTotal_count() {
		return total_count;
	}
	public void setTotal_count(int total_count) {
		this.total_count = total_count;
	}
	public int getEnded_ok() {
		return ended_ok;
	}
	public void setEnded_ok(int ended_ok) {
		this.ended_ok = ended_ok;
	}
	public int getEnded_not_ok() {
		return ended_not_ok;
	}
	public void setEnded_not_ok(int ended_not_ok) {
		this.ended_not_ok = ended_not_ok;
	}
	public int getExecuting() {
		return executing;
	}
	public void setExecuting(int executing) {
		this.executing = executing;
	}
	public int getWait_condition() {
		return wait_condition;
	}
	public void setWait_condition(int wait_condition) {
		this.wait_condition = wait_condition;
	}
	public int getWait_resource() {
		return wait_resource;
	}
	public void setWait_resource(int wait_resource) {
		this.wait_resource = wait_resource;
	}
	public int getWait_user() {
		return wait_user;
	}
	public void setWait_user(int wait_user) {
		this.wait_user = wait_user;
	}
	public int getNot_in_ajf() {
		return not_in_ajf;
	}
	public void setNot_in_ajf(int not_in_ajf) {
		this.not_in_ajf = not_in_ajf;
	}
	public int getUnknown() {
		return unknown;
	}
	public void setUnknown(int unknown) {
		this.unknown = unknown;
	}
	public int getWait_time() {
		return wait_time;
	}
	public void setWait_time(int wait_time) {
		this.wait_time = wait_time;
	}
	public int getHeld() {
		return held;
	}
	public void setHeld(int held) {
		this.held = held;
	}
	public int getDeleted() {
		return deleted;
	}
	public void setDeleted(int deleted) {
		this.deleted = deleted;
	}
	public String getData_center_code() {
		return data_center_code;
	}
	public void setData_center_code(String data_center_code) {
		this.data_center_code = data_center_code;
	}
	public String getActive_net_name() {
		return active_net_name;
	}
	public void setActive_net_name(String active_net_name) {
		this.active_net_name = active_net_name;
	}
	public String getSub_data_center() {
		return sub_data_center;
	}
	public void setSub_data_center(String subDataCenter) {
		sub_data_center = subDataCenter;
	}
	public String getBiz_gb() {
		return biz_gb;
	}
	public void setBiz_gb(String bizGb) {
		biz_gb = bizGb;
	}
	public int getSuccess() {
		return success;
	}
	public void setSuccess(int success) {
		this.success = success;
	}
	public int getFail() {
		return fail;
	}
	public void setFail(int fail) {
		this.fail = fail;
	}
	public int getWait() {
		return wait;
	}
	public void setWait(int wait) {
		this.wait = wait;
	}
	public int getRunning() {
		return running;
	}
	public void setRunning(int running) {
		this.running = running;
	}
	public String getStart_h() {
		return start_h;
	}
	public void setStart_h(String startH) {
		start_h = startH;
	}
	public int getCnt_0() {
		return cnt_0;
	}
	public void setCnt_0(int cnt_0) {
		this.cnt_0 = cnt_0;
	}
	public int getCnt_1() {
		return cnt_1;
	}
	public void setCnt_1(int cnt_1) {
		this.cnt_1 = cnt_1;
	}
	public int getCnt_2() {
		return cnt_2;
	}
	public void setCnt_2(int cnt_2) {
		this.cnt_2 = cnt_2;
	}
	public int getCnt_3() {
		return cnt_3;
	}
	public void setCnt_3(int cnt_3) {
		this.cnt_3 = cnt_3;
	}
	public int getCnt_4() {
		return cnt_4;
	}
	public void setCnt_4(int cnt_4) {
		this.cnt_4 = cnt_4;
	}
	public int getCnt_5() {
		return cnt_5;
	}
	public void setCnt_5(int cnt_5) {
		this.cnt_5 = cnt_5;
	}
	public int getCnt_6() {
		return cnt_6;
	}
	public void setCnt_6(int cnt_6) {
		this.cnt_6 = cnt_6;
	}
	public String getOrder_table() {
		return order_table;
	}
	public void setOrder_table(String orderTable) {
		order_table = orderTable;
	}
	public String getApplication() {
		return application;
	}
	public void setApplication(String application) {
		this.application = application;
	}
	public String getGubun() {
		return gubun;
	}
	public void setGubun(String gubun) {
		this.gubun = gubun;
	}
	public int getWait_node() {
		return wait_node;
	}
	public void setWait_node(int wait_node) {
		this.wait_node = wait_node;
	}

	
}
