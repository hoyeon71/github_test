package com.ghayoun.ezjobs.m.domain;

import java.io.Serializable;

public class ActiveJobBean implements Serializable {

	private int row_num 		= 0;
	private String from_time 	= "";
	private String to_time 		= "";
	private String control_m 	= "";
    private String order_id 	= "";
    private String rba 	= "";
    private String group_rba 	= "";
    private String application 	= "";
    private String application_type 	= "";
    private String group 	= "";
    private String job_name 	= "";
    private String mem_name 	= "";
    private String mem_lib 	= "";
    private String order_table 	= "";
    private String order_library 	= "";
    private String owner 	= "";
    private String description 	= "";
    private String task_type 	= "";
    private String time_zone 	= "";
    private String in_BIM_service 	= "";
    private String job_status 	= "";
    private String job_state 	= "";
    private String state_digits 	= "";
    private String odate 	= "";
    private String otime 	= "";
    private String next_time 	= "";
    private String rerun_counter 	= "";
    private String average_runtime 	= "";
    private String start_time 	= "";
    private String end_time 	= "";
    private String critical 	= "";
    private String cyclic 			= "";
    private String emergency 		= "";
    private String avg_run_time 	= "";
    
	public int getRow_num() {
		return row_num;
	}
	public void setRow_num(int row_num) {
		this.row_num = row_num;
	}
	public String getFrom_time() {
		return from_time;
	}
	public void setFrom_time(String from_time) {
		this.from_time = from_time;
	}
	public String getTo_time() {
		return to_time;
	}
	public void setTo_time(String to_time) {
		this.to_time = to_time;
	}
	public String getControl_m() {
		return control_m;
	}
	public void setControl_m(String control_m) {
		this.control_m = control_m;
	}
	public String getOrder_id() {
		return order_id;
	}
	public void setOrder_id(String order_id) {
		this.order_id = order_id;
	}
	public String getRba() {
		return rba;
	}
	public void setRba(String rba) {
		this.rba = rba;
	}
	public String getGroup_rba() {
		return group_rba;
	}
	public void setGroup_rba(String group_rba) {
		this.group_rba = group_rba;
	}
	public String getApplication() {
		return application;
	}
	public void setApplication(String application) {
		this.application = application;
	}
	public String getApplication_type() {
		return application_type;
	}
	public void setApplication_type(String application_type) {
		this.application_type = application_type;
	}
	public String getGroup() {
		return group;
	}
	public void setGroup(String group) {
		this.group = group;
	}
	public String getJob_name() {
		return job_name;
	}
	public void setJob_name(String job_name) {
		this.job_name = job_name;
	}
	public String getMem_name() {
		return mem_name;
	}
	public void setMem_name(String mem_name) {
		this.mem_name = mem_name;
	}
	public String getMem_lib() {
		return mem_lib;
	}
	public void setMem_lib(String mem_lib) {
		this.mem_lib = mem_lib;
	}
	public String getOrder_table() {
		return order_table;
	}
	public void setOrder_table(String order_table) {
		this.order_table = order_table;
	}
	public String getOrder_library() {
		return order_library;
	}
	public void setOrder_library(String order_library) {
		this.order_library = order_library;
	}
	public String getOwner() {
		return owner;
	}
	public void setOwner(String owner) {
		this.owner = owner;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getTask_type() {
		return task_type;
	}
	public void setTask_type(String task_type) {
		this.task_type = task_type;
	}
	public String getTime_zone() {
		return time_zone;
	}
	public void setTime_zone(String time_zone) {
		this.time_zone = time_zone;
	}
	public String getIn_BIM_service() {
		return in_BIM_service;
	}
	public void setIn_BIM_service(String in_BIM_service) {
		this.in_BIM_service = in_BIM_service;
	}
	public String getJob_status() {
		return job_status;
	}
	public void setJob_status(String job_status) {
		this.job_status = job_status;
	}
	public String getJob_state() {
		return job_state;
	}
	public void setJob_state(String job_state) {
		this.job_state = job_state;
	}
	public String getState_digits() {
		return state_digits;
	}
	public void setState_digits(String state_digits) {
		this.state_digits = state_digits;
	}
	public String getOdate() {
		return odate;
	}
	public void setOdate(String odate) {
		this.odate = odate;
	}
	public String getOtime() {
		return otime;
	}
	public void setOtime(String otime) {
		this.otime = otime;
	}
	public String getNext_time() {
		return next_time;
	}
	public void setNext_time(String next_time) {
		this.next_time = next_time;
	}
	public String getRerun_counter() {
		return rerun_counter;
	}
	public void setRerun_counter(String rerun_counter) {
		this.rerun_counter = rerun_counter;
	}
	public String getAverage_runtime() {
		return average_runtime;
	}
	public void setAverage_runtime(String average_runtime) {
		this.average_runtime = average_runtime;
	}
	public String getStart_time() {
		return start_time;
	}
	public void setStart_time(String start_time) {
		this.start_time = start_time;
	}
	public String getEnd_time() {
		return end_time;
	}
	public void setEnd_time(String end_time) {
		this.end_time = end_time;
	}
	public String getCritical() {
		return critical;
	}
	public void setCritical(String critical) {
		this.critical = critical;
	}
	public String getCyclic() {
		return cyclic;
	}
	public void setCyclic(String cyclic) {
		this.cyclic = cyclic;
	}
	public String getEmergency() {
		return emergency;
	}
	public void setEmergency(String emergency) {
		this.emergency = emergency;
	}
	public String getAvg_run_time() {
		return avg_run_time;
	}
	public void setAvg_run_time(String avgRunTime) {
		avg_run_time = avgRunTime;
	}
    
}