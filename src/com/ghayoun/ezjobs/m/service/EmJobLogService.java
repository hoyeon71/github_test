package com.ghayoun.ezjobs.m.service;

import java.io.Serializable;
import java.util.List;
import java.util.Map;
import com.ghayoun.ezjobs.comm.domain.CommonBean;
import com.ghayoun.ezjobs.m.domain.DefJobBean;
import com.ghayoun.ezjobs.m.domain.JobLogBean;
import com.ghayoun.ezjobs.m.domain.JobOpBean;
import com.ghayoun.ezjobs.m.domain.TotalJobStatus;


public interface EmJobLogService extends Serializable{

	public JobLogBean dGetJobLogListCnt(Map map);
	public List<JobLogBean> dGetJobLogList(Map map);
	
	public JobLogBean dGetJobLogHistoryListCnt(Map map);
	public List<JobLogBean> dGetJobLogHistoryList(Map map);
	
	public CommonBean dGetJobOpListCnt(Map map);
	public List<JobOpBean> dGetJobOpList(Map map);
	public List<TotalJobStatus> dGetJobOpListReport(Map map);
	public List<JobLogBean> dGetJobOpReportList(Map map);	
	
	public CommonBean dGetHistoryDayCnt(Map map);
	
	public CommonBean dGetTimeOverJobLogListCnt(Map map);
	public List<JobLogBean> dGetTimeOverJobLogList(Map map);
	
	public CommonBean dGetJobGroupListCnt(Map map);
	public List<JobLogBean> dGetJobGroupList(Map map);
	
	public List<JobLogBean> dGetJobGroupInfoList(Map map);
	
	public List<JobLogBean> dGetJobOpStatsReportList(Map map);
	public JobLogBean dGetJobOpReportInfo(Map map);

	public JobLogBean dGetJobSysout(Map map);
}
