package com.ghayoun.ezjobs.m.service;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

import com.ghayoun.ezjobs.m.domain.WaitDetailBean;


public interface PopupWaitDetailService extends Serializable{


	public List<WaitDetailBean> dGetWaitConditionDetail(Map map);

	public List<WaitDetailBean> dGetWaitTimeDetail(Map map);
	
}
