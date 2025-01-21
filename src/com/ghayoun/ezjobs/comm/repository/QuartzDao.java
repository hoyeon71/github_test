package com.ghayoun.ezjobs.comm.repository;

import java.util.List;
import java.util.Map;
import com.ghayoun.ezjobs.a.domain.AlertBean;
import com.ghayoun.ezjobs.comm.domain.CommonBean;
import com.ghayoun.ezjobs.m.domain.BatchResultTotalBean;
import com.ghayoun.ezjobs.m.domain.JobDefineInfoBean;
import com.ghayoun.ezjobs.t.domain.Doc06Bean;
import com.ghayoun.ezjobs.t.domain.DocInfoBean;
import com.ghayoun.ezjobs.t.domain.UserBean;

public interface QuartzDao {
	
	public List<CommonBean> aJobList(Map map);
	
	public CommonBean EZ_HISTORY_CNT(Map map);
	
	public Map dPrcQuartz(Map map);
	
	public CommonBean eaiUserCnt(Map map);
	
	public List<AlertBean> smsAlarmList(Map map);
	public List<AlertBean> deletedJobAlarmList(Map map);
	
	public CommonBean aJobCheckCnt(Map map);
	
	public List<DocInfoBean> apiCallJobList(Map map);
	public List<DocInfoBean> preDateBatchJobList(Map map);
	
	public List<DocInfoBean> susiApiCallJobList(Map map);

	public void insertEzAlram(AlertBean alertBean);
	
	public CommonBean getDataCenterInfo(Map map);    
	
	public List<BatchResultTotalBean> dGetDailyReportList(Map map);
	
	public List<UserBean> dGetDailyReportSendUserList(Map map);
	
	public List<UserBean> dGetDailyReportSendAdminList(Map map);
	
	public List<Doc06Bean> dGetExcelBatchList(Map<String, Object> map);
	public List<Doc06Bean> dGetExcelBatchVeriList(Map<String, Object> map);
	public int dPrcExcelBatchApplyUpdate(Map<String, Object> map);
	public List<Doc06Bean> dGetExcelBatchExecuteGroup(Map<String, Object> map);
	public List<Doc06Bean> dGetExcelVerifyBatchExecuteGroup(Map<String, Object> map);
	
	public int dGetExcelBatchErrMsgUpdate(Map<String, Object> map);
	
	public CommonBean dGetExcelBatchDelTable(Map<String, Object> map);
	
	public Map dPrcUser(Map map);
	
	public Map dPrcDept(Map map);
	
	public Map dPrcDuty(Map map);
	
	public List<Doc06Bean> dGetTableUploadList(Map<String, Object> map);

	public List<JobDefineInfoBean> defJobList(Map map);

	public List<UserBean> dGetDeptRelay(Map<String, Object> map);

	public List<UserBean> dGetUserReplay(Map<String, Object> map);

	public List<UserBean> dGetDutyRelay(Map<String, Object> map);

	public Map dPrcQuartzSms(Map map);
	
	public List<CommonBean> emExcutingJobList(Map map);
	
	public int dPrcUpdateStatusHistory(Map<String, Object> map);
	
}