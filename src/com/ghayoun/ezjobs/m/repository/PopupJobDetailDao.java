package com.ghayoun.ezjobs.m.repository;

import java.util.List;
import java.util.Map;

import com.ghayoun.ezjobs.comm.domain.CommonBean;
import com.ghayoun.ezjobs.m.domain.*;
import com.ghayoun.ezjobs.t.domain.JobBasicInfo;


public interface PopupJobDetailDao {
	
	public JobDetailBean dGetJobDetail(Map map);
	
	public CommonBean dGetJobMemoListCnt(Map map);

	public List<JobMemoBean> dGetJobMemoList(Map map);
	
	//procedure
	public Map dPrcJobMemo(Map map);
	
	public List<JobLogBean> dGetJobLogListContent(Map map);
	
	public List<ActiveJobBean> dGetJobAvgInfoList(Map map);

	public JobBasicInfo dGetJobBasicInfo(Map<String, Object> paramMap);
	
	public List<JobBasicInfo> dGetJobapprovalInfo(Map<String, Object> paramMap);
	
	public List<JobLogBean> dGetOutCondList(Map map);

}