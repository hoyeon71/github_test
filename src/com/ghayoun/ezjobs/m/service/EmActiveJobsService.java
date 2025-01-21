package com.ghayoun.ezjobs.m.service;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

import com.ghayoun.ezjobs.comm.domain.*;


public interface EmActiveJobsService extends Serializable{

	public Map getActiveJobs(Map map);
	
	public List<String> getFromTimeOrderIdList(Map map);
	
	public List<String> getTotalJobStatusList(Map map);
	
	public CommonBean dGetApprovalLineCnt(Map map);
}
