package com.ghayoun.ezjobs.m.repository;

import java.util.List;
import java.util.Map;
import com.ghayoun.ezjobs.m.domain.DefJobBean;
import com.ghayoun.ezjobs.m.domain.JobDefineInfoBean;

public interface PopupDefJobDetailDao {
	
	public List<DefJobBean> dGetDefJobDetail(Map map);	
	
	public JobDefineInfoBean dGetJobDefineInfo(Map map);
	
	public JobDefineInfoBean dGetJobDefineInfo_new(Map map);
	
	public List<DefJobBean> dGetDefInCondJobList(Map map);	
	public List<DefJobBean> dGetDefOutCondJobList(Map map);	
}