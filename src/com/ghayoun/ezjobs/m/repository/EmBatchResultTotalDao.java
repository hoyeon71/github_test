package com.ghayoun.ezjobs.m.repository;

import java.util.List;
import java.util.Map;
import com.ghayoun.ezjobs.comm.domain.CommonBean;
import com.ghayoun.ezjobs.m.domain.*;

public interface EmBatchResultTotalDao {
	
	public List<BatchResultTotalBean> dGetBatchResultTotalList(Map map);
	
	public List<BatchResultTotalBean> dGetNodeList(Map map);
	
	public List<BatchResultTotalBean> dGetNodeTimeList(Map map);
	
	public List<BatchResultTotalBean> dGetMonthBatchResultTotalList(Map map);
	
	public CommonBean dGetDataCenterInfo(Map map);
	
	public CommonBean dGetDataCenterInfoAjob(Map map);
	
	public List<BatchResultTotalBean> dGetBatchResultTotalList2(Map map);

	public List<BatchResultTotalBean> dGetBatchResultTotalList3(Map map);
	public List<BatchResultTotalBean> dGetBatchResultAppList3(Map map);
	public List<BatchResultTotalBean> dGetBatchResultStatusList3(Map map);
	public List<BatchResultTotalBean> dGetHistoryFailJobList(Map map);
	
	public List<CommonBean> dGetResourceNMList(Map map);
	public List<CommonBean> dGetResourceHHList(Map map);
	public List<CommonBean> dGetResourceTimeList(Map map);
	
	public List<BatchResultTotalBean> dGetBatchReport(Map map);
}