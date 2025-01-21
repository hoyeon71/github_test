package com.ghayoun.ezjobs.m.repository;

import java.util.List;
import java.util.Map;
import com.ghayoun.ezjobs.comm.domain.CommonBean;
import com.ghayoun.ezjobs.m.domain.*;

public interface EmCtmInfoDao {
	
	public List<CtmInfoBean> dGetEmCommonList(Map map);
	
	public List<CtmInfoBean> dGetEmDbList(Map map);
	
	public List<CtmInfoBean> dGetEmProcessList(Map map);
	
	public List<CtmInfoBean> dGetCcmPocessList(Map map);
	
	public List<CtmInfoBean> dGetEmProcessDetailList(Map map);
	
	public List<CtmInfoBean> dGetAgentList(Map map);
	
	public CommonBean dGetJobCondListCnt(Map map);
	
	public List<CtmInfoBean> dGetJobCondList(Map map);
	
	public List<CtmInfoBean> dGetDashBoard_appList(Map map);
	   
	public List<CtmInfoBean> dGetDashBoard_grpList(Map map);
	   
	public List<CtmInfoBean> dGetDashBoard_nodeList(Map map);
	   
	public List<CtmInfoBean> dGetDashBoard_errList(Map map);
	
	public List<CtmInfoBean> dGetJobCondHistoryList(Map map);
}