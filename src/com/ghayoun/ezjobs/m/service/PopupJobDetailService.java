package com.ghayoun.ezjobs.m.service;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

import com.ghayoun.ezjobs.comm.domain.CommonBean;
import com.ghayoun.ezjobs.m.domain.ActiveJobBean;
import com.ghayoun.ezjobs.m.domain.JobDetailBean;
import com.ghayoun.ezjobs.m.domain.JobLogBean;
import com.ghayoun.ezjobs.m.domain.JobMemoBean;
import com.ghayoun.ezjobs.t.domain.JobBasicInfo;


public interface PopupJobDetailService extends Serializable{

	public JobDetailBean dGetJobDetail(Map map);
	
	public CommonBean dGetJobMemoListCnt(Map map);
	public List<JobMemoBean> dGetJobMemoList(Map map);
	
	
	//procedure
	public Map dPrcJobMemo(Map map);
	
	public List<JobLogBean> dGetJobLogListContent(Map map);
	
	public List<ActiveJobBean> dGetJobAvgInfoList(Map map);

	public JobBasicInfo dGetJobBasicInfo(Map<String, Object> paramMap);
	
	public List<JobBasicInfo> dGetJobapprovalInfo(Map<String, Object> paramMap);

	public void modifyJobBasicInfo(Map<String, Object> paramMap);
	
	
	public List<JobLogBean> dGetOutCondList(Map<String, Object> paramMap);
	
	
	
}
