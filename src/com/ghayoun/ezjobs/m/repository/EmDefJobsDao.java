package com.ghayoun.ezjobs.m.repository;

import java.util.List;
import java.util.Map;
import com.ghayoun.ezjobs.comm.domain.CommonBean;
import com.ghayoun.ezjobs.m.domain.*;

public interface EmDefJobsDao {
	
	public DefJobBean dGetDefJobListCnt(Map map);
	
	public List<DefJobBean> dGetDefJobList(Map map);
	
	public List<DefJobBean> dGetDefJobExcelList(Map map);
	
	public List<DefJobBean> dGetInCondJobList(Map map);
	
	public DefJobBean dGetJobDefInfo(Map map);
	
	public List<DefJobBean> dGetJobGroupDefJobList(Map map);
	
	public DefJobBean dGetJobGroupDefJobListCnt(Map map);
	
	public DefJobBean dGetActiveJobListCnt(Map map);
	
}