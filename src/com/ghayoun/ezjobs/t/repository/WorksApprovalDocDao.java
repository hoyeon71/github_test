package com.ghayoun.ezjobs.t.repository;

import java.util.List;
import java.util.Map;

import com.ghayoun.ezjobs.t.domain.*;
import com.ghayoun.ezjobs.t.domain.ActiveJobBean;
import com.ghayoun.ezjobs.t.domain.DefJobBean;
import com.ghayoun.ezjobs.a.domain.AlertBean;
import com.ghayoun.ezjobs.comm.domain.AppGrpBean;
import com.ghayoun.ezjobs.comm.domain.CommonBean;
import com.ghayoun.ezjobs.m.domain.*;

public interface WorksApprovalDocDao {
	
	public List<ApprovalInfoBean> dGetApprovalInfoList(Map map);
	
	public CommonBean dGetAllDocInfoListCnt(Map map);
	public List<DocInfoBean> dGetAllDocInfoList(Map map);
	
	public CommonBean dGetMyDocInfoListCnt(Map map);
	public List<DocInfoBean> dGetMyDocInfoList(Map map);

	public CommonBean dGetApprovalDocInfoListCnt(Map map);
	public List<DocInfoBean> dGetApprovalDocInfoList(Map map);  
	
	
	public ActiveJobBean dGetActiveJobListCnt(Map map);
	public List<ActiveJobBean> dGetActiveJobList(Map map);
	public List<ActiveJobBean> dGetActiveJobCntList(Map map);
	
	public DefJobBean dGetDefJobListCnt(Map map);
	public List<DefJobBean> dGetDefJobList(Map map);
	
	public Doc01Bean dGetDoc01(Map map);
	public Doc01Bean dGetDoc02(Map map);
	public Doc03Bean dGetDoc03(Map map);
	public Doc01Bean dGetDoc04(Map map);
	public Doc01Bean dGetDoc04_original(Map map);
	public Doc05Bean dGetDoc05(Map map);
	public Doc05Bean dGetGroupDoc05(Map map); 
	public Doc01Bean dGetJobModifyInfo(Map map);
	
	public Doc07Bean dGetDoc07(Map map);
	public Doc08Bean dGetDoc08(Map map);
	public Doc01Bean dGetDoc09(Map map);

	Doc01Bean dGetDoc10(Map map);
	public List<AppGrpBean> dGetAppGrpCodeList(Map map);
	
	//procedure
	public Map dPrcDoc01(Map map);
	public Map dPrcDoc02(Map map);
	public Map dPrcDoc03(Map map);
	public Map dPrcDoc04(Map map);
	public Map dPrcDoc07(Map map);
	public Map dPrcDoc10(Map map);
	
	public Map dPrcDocApproval(Map map);
	
	public Map dPrcDefJobsFile(Map map);
	
	public CommonBean dGetChkDefJobCnt(Map map);
	
	public CommonBean dGetChkDoc03Cnt(Map map);
	public CommonBean dGetChkDoc03Cnt2(Map map);
	
	public CommonBean dGetChkDoc04Cnt(Map map);
	public CommonBean dGetChkDoc04Cnt2(Map map);
	
	public CommonBean dGetChkDoc06JobCnt(Map map);
	
	public Map dPrcDocGroupApproval(Map map);
	
	public Doc01Bean dGetDefJobInfo(Map map);
	
	public CommonBean dGetJobGroupListCnt(Map map);
	
	public List<JobGroupBean> dGetJobGroupList(Map map);
	
	public JobGroupBean dGetJobGroupDetail(Map map);
	
	public CommonBean dGetJobGroupDetailListCnt(Map map);
	
	public List<DefJobBean> dGetJobGroupDetailList(Map map);
	
	public CommonBean dGetChkGroupJobCnt(Map map);
	
	public Map dPrcJobGroup(Map map);
	
	public JobGroupBean dGetJobGroupDetailId(Map map);
	
	public Map dPrcDoc05(Map map);
	
	public JobGroupBean dGetJobGroupId(Map map);
	
	public JobGroupBean dGetJobGroupMainCd(Map map);
	
	public List<Doc05Bean> dGetJobGroupDetailApprovalList(Map map);
	
	public CommonBean dGetChkApprovalLineCnt(Map map);
	
	public ApprovalInfoBean dGetApprovalMentInfo(Map map);
	
	public CommonBean dGetGeneralApprovalLineCnt(Map map);
	
	public List<TagsBean> dGetTagsAllList(Map map);
	
	public CommonBean dGetChkAjobTableCnt(Map map);
	
	public Map dPrcDocFile(Map map);
	
	public CommonBean dGetOrderId(Map map);
	
	public CtmInfoBean dGetEmCommInfo(Map map);
	
	public Map dPrcDoc06(Map map);
	
	public Doc06Bean dGetDoc06(Map map);
	
	public List<Doc06Bean> dGetDoc06DetailList(Map map);
	public List<Doc06Bean> dGetDoc06DetailList2(Map map);
	
	
	
	public List<Doc01Bean> dGetDocSetList(Map map);
	
	public DefJobBean dGetUserCd(Map map);
	public CommonBean dGetGroupUserCd(Map map);
	
	public DefJobBean dGetUserCd_NM(Map map);
	
	public ActiveJobBean dGetAjobStatus(Map map);
	
	public CommonBean dGetActiveGroupJobListCnt(Map map);
	public List<ActiveJobBean> dGetActiveGroupJobList(Map map);
	
	public CommonBean dGetMainDocInfoListCnt(Map map);
	public List<DocInfoBean> dGetMainDocInfoList(Map map);
	public List<DocInfoBean> dGetMainDocInfoList2(Map map);
	
	public List<DocInfoBean> dGetApprovalLineInfoList(Map map);
	
	public CommonBean dGetChkSchedTableCnt(Map map);
	
	public List<DefJobBean> dGetQrList(Map map);

	public Map dPrcDoc09(Map map);
	public Doc01Bean dGetGroupDocInfo(Map map);
	public CommonBean dGetOrderJobCnt(Map map);
	
	public CommonBean dGetFailLastSerial(Map map);
	
	public CommonBean dGetChkDoc01JobCnt(Map map);
	
	public CommonBean dGetChkApprovalDocDelCnt(Map map);
	
	public CommonBean dGetCheckCalendarOrderDate(Map map);
		
	public CommonBean dGetChkDeptCnt(Map map);
	
	public CommonBean dGetScodeDesc(Map map);
	public Doc02Bean dGetDoc02_tmp(Map map);
	
	public List<Doc02Bean> dGetDoc02List(Map map);
	
	public List<Doc02Bean> dGetDoc02List2(Map<String, Object> map);
	public List<Doc02Bean> dGetDoc02JobList2(Map<String, Object> map);

	public int dPrcReRunDoc(Map<String,Object> map);	
	
	public Map dPrcMyWork(Map map);
	public CommonBean dGetInsUserMail(Map map);
	public CommonBean dGetApprovalUserMail(Map map);
	public List<CommonBean> dGetApprovalAdminGroupMailList(Map map);
	
	public CommonBean dGetDocApprovalStartCnt(Map map);

	public CommonBean dGetDocApprovalStartChk(Map map);
	public CommonBean dGetCurApprovalCnt(Map map);
	
	public CommonBean dGetChkDefTablesLockCnt(Map map);
	
	public CommonBean dGetChkPostApprovalLineCnt(Map map);
	
	public Map dPrcDoc08(Map map);
	
	public List<DocInfoBean> dGetForecastDocList(Map map);
	
	public Map dPrcWorkGroup(Map map);
	
	public CommonBean dGetWorkGroupDetail(Map map);
	
	public List<DefJobBean> dGetFolderGroupList(Map map);
	
	public CommonBean dGetChkForecastJobCnt(Map map);
	
	public DocInfoBean dGetChkApprovalStatus(Map map);

	public Doc01Bean dGetJobDefCheck(Map map);
	public List<Doc01Bean> dGetJobDefCheckList(Map map);

	public DocInfoBean dGetApprovalNotiInfo(Map map);

	public CommonBean dGetDocApprovalAlreadyCnt(Map map);

	public Map dPrcDocSetvar(Map map);
	
}