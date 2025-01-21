package com.ghayoun.ezjobs.m.repository;

import java.util.List;
import java.util.Map;

import com.ghayoun.ezjobs.m.domain.WaitDetailBean;

public interface PopupWaitDetailDao {
	
	public List<WaitDetailBean> dGetWaitConditionDetail(Map map);
	
	public List<WaitDetailBean> dGetWaitTimeDetail(Map map);
	
}