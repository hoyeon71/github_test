package com.ghayoun.ezjobs.m.service;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

import com.ghayoun.ezjobs.m.domain.TimeInfoBean;


public interface PopupTimeInfoService extends Serializable{

	public List<TimeInfoBean> dGetAtiveStartTimeList(Map map);
	public List<TimeInfoBean> dGetTimeInfoList(Map map);
	public List<TimeInfoBean> dGetEndTimeInfoList(Map map);
}
