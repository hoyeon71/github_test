package com.ghayoun.ezjobs.m.repository;

import java.util.List;
import java.util.Map;
import com.ghayoun.ezjobs.comm.domain.CommonBean;

public interface EmActiveJobsDao {
	
	public Map getActiveJobs(Map map);
	
	public List getFromTimeOrderIdList(Map map);
	
	public List<String> getTotalJobStatusList(Map map);
	
	public CommonBean dGetApprovalLineCnt(Map map);
	
}