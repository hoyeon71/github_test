package com.ghayoun.ezjobs.m.service;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

import com.ghayoun.ezjobs.m.domain.JobGraphBean;


public interface PopupJobGraphService extends Serializable{

	public List<JobGraphBean> dGetJobGraphList(Map map);
	
	public List<JobGraphBean> dGetJobGraphList_ez012(Map map);
}
