package com.ghayoun.ezjobs.t.repository;

import java.util.List;
import java.util.Map;

import com.ghayoun.ezjobs.comm.domain.CommonBean;
import com.ghayoun.ezjobs.m.domain.JobDefineInfoBean;
import com.ghayoun.ezjobs.t.domain.*;

public interface PopupDefJobDao {
	
	public CommonBean dGetDefJobListCnt(Map map);
	public List<DefJobBean> dGetDefJobList(Map map);
	
	public CommonBean dGetJobGroupDefJobListCnt(Map map);
	public List<DefJobBean> dGetJobGroupDefJobList(Map map);
	
	public JobDefineInfoBean dGetAjobInfo(Map map);
	public JobDefineInfoBean dGetAjobHistoryInfo(Map map);
	
	public List<JobDefineInfoBean> dGetPreDateAjobInfo(Map map);
}