package com.ghayoun.ezjobs.m.service;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

import com.ghayoun.ezjobs.m.domain.DefJobBean;
import com.ghayoun.ezjobs.m.domain.JobDefineInfoBean;


public interface PopupDefJobDetailService extends Serializable{

	public List<DefJobBean> dGetDefJobDetail(Map map);
	
	public JobDefineInfoBean dGetJobDefineInfo(Map map);
	
	public JobDefineInfoBean dGetJobDefineInfo_new(Map map);
	
	public List<DefJobBean> dGetDefInCondJobList(Map map);
	public List<DefJobBean> dGetDefOutCondJobList(Map map);
}
