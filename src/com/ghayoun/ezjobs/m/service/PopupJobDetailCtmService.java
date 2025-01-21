package com.ghayoun.ezjobs.m.service;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

import com.ghayoun.ezjobs.m.domain.JobLogBean;


public interface PopupJobDetailCtmService extends Serializable{
	
	public List<JobLogBean> dGetJobLogListContent(Map map);
}
