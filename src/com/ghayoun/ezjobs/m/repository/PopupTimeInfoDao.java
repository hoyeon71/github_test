package com.ghayoun.ezjobs.m.repository;

import java.util.List;
import java.util.Map;
import com.ghayoun.ezjobs.m.domain.TimeInfoBean;

public interface PopupTimeInfoDao {
	
	public List<TimeInfoBean> dGetAtiveStartTimeList(Map map);
	public List<TimeInfoBean> dGetTimeInfoList(Map map);
	public List<TimeInfoBean> dGetEndTimeInfoList(Map map);

}