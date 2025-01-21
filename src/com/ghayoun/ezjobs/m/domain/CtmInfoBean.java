package com.ghayoun.ezjobs.m.domain;

import java.io.Serializable;

public class CtmInfoBean implements Serializable {

	private String data_center 			= "";
	private String ctm_host_name 		= "";
	private String control_m_ver 		= "";
	private String time_zone 			= "";
	private String ctm_daily_time		= "";
	private String ctm_odate 			= "";
	
	private String tablespace_name    	= "";
	private String m_bytes      		= "";
	private String free        			= "";
	private String used        			= "";
	
	private String pname       	 		= "";
	private String process_type    		= "";
	private String pstate       		= "";
	private String desired_state   		= "";
	private String u_time   			= "";
	private String interval    			= "";
	private String free_text         	= "";
	
	private String machine_name       	= "";
	private String cprocess_name   		= "";
	private String cprocess_type     	= "";
	private String pid    				= "";
	private String ctlport      		= "";
	
	private String agname       		= "";
	private String agvalue   			= "";
	private String aglastup     		= "";
	
	private String condname     		= "";
	private String conddate     		= "";
	
	private String nodeid   	  		= "";
	private String agstat   	  		= "";
	private String hostname	    		= "";
	private String version     			= "";
	private String os_name     			= "";
	private String platform     		= "";
	private String last_upd     		= "";	
	
	private String application     		= "";	
	private String cnt     				= "";	
	private String group_name     		= "";	
	private String cpu_id     			= "";	
	private String job_name     		= "";	
	private String status     			= "";	
	private String user_nm     			= "";
	private String user_id     			= "";

	private int grid_idx 		= 0;
	private int row_num 		= 0;
	
	private String wait_cnt    			= "";
	private String ok_cnt     			= "";
	private String not_ok_cnt  			= "";
	private String exec_cnt  			= "";
	private String description 			= "";
	
	private String ins_date 			= "";
	private String oscompstat 			= "";
	private String runcount 			= "";
	private String jobdate 				= "";
	private String jobname     			= "";
	
	/**
	 * @return the application
	 */
	public String getApplication() {
		return application;
	}
	/**
	 * @return the cnt
	 */
	public String getCnt() {
		return cnt;
	}
	/**
	 * @return the group_name
	 */
	public String getGroup_name() {
		return group_name;
	}
	/**
	 * @return the cpu_id
	 */
	public String getCpu_id() {
		return cpu_id;
	}
	/**
	 * @return the job_name
	 */
	public String getJob_name() {
		return job_name;
	}
	/**
	 * @return the status
	 */
	public String getStatus() {
		return status;
	}
	/**
	 * @return the user_nm
	 */
	public String getUser_nm() {
		return user_nm;
	}
	/**
	 * @param application the application to set
	 */
	public void setApplication(String application) {
		this.application = application;
	}
	/**
	 * @param cnt the cnt to set
	 */
	public void setCnt(String cnt) {
		this.cnt = cnt;
	}
	/**
	 * @param groupName the group_name to set
	 */
	public void setGroup_name(String groupName) {
		group_name = groupName;
	}
	/**
	 * @param cpuId the cpu_id to set
	 */
	public void setCpu_id(String cpuId) {
		cpu_id = cpuId;
	}
	/**
	 * @param jobName the job_name to set
	 */
	public void setJob_name(String jobName) {
		job_name = jobName;
	}
	/**
	 * @param status the status to set
	 */
	public void setStatus(String status) {
		this.status = status;
	}
	/**
	 * @param userNm the user_nm to set
	 */
	public void setUser_nm(String userNm) {
		user_nm = userNm;
	}
	public String getFree() {
		return free;
	}
	public void setFree(String free) {
		this.free = free;
	}
	
	public String getPname() {
		return pname;
	}
	public void setPname(String pname) {
		this.pname = pname;
	}
	public String getU_time() {
		return u_time;
	}
	public void setU_time(String u_time) {
		this.u_time = u_time;
	}
	public String getInterval() {
		return interval;
	}
	public void setInterval(String interval) {
		this.interval = interval;
	}
	public String getMachine_name() {
		return machine_name;
	}
	public void setMachine_name(String machine_name) {
		this.machine_name = machine_name;
	}
	public String getCprocess_name() {
		return cprocess_name;
	}
	public void setCprocess_name(String cprocess_name) {
		this.cprocess_name = cprocess_name;
	}
	public String getCprocess_type() {
		return cprocess_type;
	}
	public void setCprocess_type(String cprocess_type) {
		this.cprocess_type = cprocess_type;
	}
	public String getPid() {
		return pid;
	}
	public void setPid(String pid) {
		this.pid = pid;
	}
	public String getCtlport() {
		return ctlport;
	}
	public void setCtlport(String ctlport) {
		this.ctlport = ctlport;
	}
	public String getProcess_type() {
		return process_type;
	}
	public void setProcess_type(String process_type) {
		this.process_type = process_type;
	}
	public String getDesired_state() {
		return desired_state;
	}
	public void setDesired_state(String desired_state) {
		this.desired_state = desired_state;
	}
	public String getAgname() {
		return agname;
	}
	public void setAgname(String agname) {
		this.agname = agname;
	}
	public String getAgvalue() {
		return agvalue;
	}
	public void setAgvalue(String agvalue) {
		this.agvalue = agvalue;
	}
	public String getAglastup() {
		return aglastup;
	}
	public void setAglastup(String aglastup) {
		this.aglastup = aglastup;
	}
	public String getM_bytes() {
		return m_bytes;
	}
	public void setM_bytes(String m_bytes) {
		this.m_bytes = m_bytes;
	}
	public String getData_center() {
		return data_center;
	}
	public void setData_center(String data_center) {
		this.data_center = data_center;
	}
	public String getCtm_host_name() {
		return ctm_host_name;
	}
	public void setCtm_host_name(String ctm_host_name) {
		this.ctm_host_name = ctm_host_name;
	}
	public String getControl_m_ver() {
		return control_m_ver;
	}
	public void setControl_m_ver(String control_m_ver) {
		this.control_m_ver = control_m_ver;
	}
	public String getTime_zone() {
		return time_zone;
	}
	public void setTime_zone(String time_zone) {
		this.time_zone = time_zone;
	}
	public String getCtm_daily_time() {
		return ctm_daily_time;
	}
	public void setCtm_daily_time(String ctm_daily_time) {
		this.ctm_daily_time = ctm_daily_time;
	}
	public String getCtm_odate() {
		return ctm_odate;
	}
	public void setCtm_odate(String ctm_odate) {
		this.ctm_odate = ctm_odate;
	}
	public String getUsed() {
		return used;
	}
	public void setUsed(String used) {
		this.used = used;
	}
	public String getTablespace_name() {
		return tablespace_name;
	}
	public void setTablespace_name(String tablespace_name) {
		this.tablespace_name = tablespace_name;
	}
	public String getFree_text() {
		return free_text;
	}
	public void setFree_text(String free_text) {
		this.free_text = free_text;
	}
	public String getPstate() {
		return pstate;
	}
	public void setPstate(String pstate) {
		this.pstate = pstate;
	}
	public String getCondname() {
		return condname;
	}
	public void setCondname(String condname) {
		this.condname = condname;
	}
	public String getConddate() {
		return conddate;
	}
	public void setConddate(String conddate) {
		this.conddate = conddate;
	}
	public String getAgstat() {
		return agstat;
	}
	public void setAgstat(String agstat) {
		this.agstat = agstat;
	}
	public String getHostname() {
		return hostname;
	}
	public void setHostname(String hostname) {
		this.hostname = hostname;
	}
	public String getVersion() {
		return version;
	}
	public void setVersion(String version) {
		this.version = version;
	}
	public String getOs_name() {
		return os_name;
	}
	public void setOs_name(String osName) {
		os_name = osName;
	}
	public String getPlatform() {
		return platform;
	}
	public void setPlatform(String platform) {
		this.platform = platform;
	}
	public String getLast_upd() {
		return last_upd;
	}
	public void setLast_upd(String lastUpd) {
		last_upd = lastUpd;
	}
	public String getNodeid() {
		return nodeid;
	}
	public void setNodeid(String nodeid) {
		this.nodeid = nodeid;
	}
	public int getGrid_idx() {
		return grid_idx;
	}
	public void setGrid_idx(int grid_idx) {
		this.grid_idx = grid_idx;
	}
	public int getRow_num() {
		return row_num;
	}
	public void setRow_num(int row_num) {
		this.row_num = row_num;
	}
	public String getWait_cnt() {
		return wait_cnt;
	}
	public void setWait_cnt(String waitCnt) {
		wait_cnt = waitCnt;
	}
	public String getOk_cnt() {
		return ok_cnt;
	}
	public void setOk_cnt(String okCnt) {
		ok_cnt = okCnt;
	}
	public String getNot_ok_cnt() {
		return not_ok_cnt;
	}
	public void setNot_ok_cnt(String notOkCnt) {
		not_ok_cnt = notOkCnt;
	}
	public String getExec_cnt() {
		return exec_cnt;
	}
	public void setExec_cnt(String exec_cnt) {
		this.exec_cnt = exec_cnt;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getIns_date() {
		return ins_date;
	}
	public void setIns_date(String ins_date) {
		this.ins_date = ins_date;
	}
	public String getOscompstat() {
		return oscompstat;
	}
	public void setOscompstat(String oscompstat) {
		this.oscompstat = oscompstat;
	}
	public String getRuncount() {
		return runcount;
	}
	public void setRuncount(String runcount) {
		this.runcount = runcount;
	}
	public String getJobdate() {
		return jobdate;
	}
	public void setJobdate(String jobdate) {
		this.jobdate = jobdate;
	}
	public String getJobname() {
		return jobname;
	}
	public void setJobname(String jobname) {
		this.jobname = jobname;
	}
	
}
