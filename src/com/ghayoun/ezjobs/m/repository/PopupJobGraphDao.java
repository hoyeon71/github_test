package com.ghayoun.ezjobs.m.repository;

import java.util.List;
import java.util.Map;

import com.ghayoun.ezjobs.m.domain.JobGraphBean;

public interface PopupJobGraphDao {
	
	public List<JobGraphBean> dGetJobGraphList(Map map);
	
	public List<JobGraphBean> dGetJobGraphList_ez012(Map map);
	
	public List<JobGraphBean> dGetJobGraphHistoryList(Map map);

}