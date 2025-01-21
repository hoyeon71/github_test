package com.ghayoun.ezjobs.t.service;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

import com.ghayoun.ezjobs.a.domain.AlertBean;
import com.ghayoun.ezjobs.comm.domain.CommonBean;
import com.ghayoun.ezjobs.t.domain.ActiveJobBean;
import com.ghayoun.ezjobs.t.domain.ApprovalInfoBean;
import com.ghayoun.ezjobs.t.domain.DefJobBean;
import com.ghayoun.ezjobs.t.domain.DefJobsFileBean;
import com.ghayoun.ezjobs.t.domain.Doc01Bean;
import com.ghayoun.ezjobs.t.domain.Doc02Bean;
import com.ghayoun.ezjobs.t.domain.Doc03Bean;
import com.ghayoun.ezjobs.t.domain.Doc05Bean;
import com.ghayoun.ezjobs.t.domain.Doc06Bean;
import com.ghayoun.ezjobs.t.domain.Doc07Bean;
import com.ghayoun.ezjobs.t.domain.Doc08Bean;
import com.ghayoun.ezjobs.t.domain.Doc09Bean;
import com.ghayoun.ezjobs.t.domain.Doc12Bean;
import com.ghayoun.ezjobs.t.domain.DocInfoBean;
import com.ghayoun.ezjobs.t.domain.JobGroupBean;


public interface WorksApprovalDocService extends Serializable{

	
	
	public List<ApprovalInfoBean> dGetApprovalInfoList(Map map);
	
	public CommonBean dGetAllDocInfoListCnt(Map map);
    public List<DocInfoBean> dGetAllDocInfoList(Map map); 
	
	public CommonBean dGetMyDocInfoListCnt(Map map);
    public List<DocInfoBean> dGetMyDocInfoList(Map map);
    
    public CommonBean dGetApprovalDocInfoListCnt(Map map);
    public List<DocInfoBean> dGetApprovalDocInfoList(Map map);
    public ActiveJobBean dGetAjobStatus(Map map);
    
    public ActiveJobBean dGetActiveJobListCnt(Map map);
    public List<ActiveJobBean> dGetActiveJobList(Map map);

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

	public Doc01Bean dGetDoc10(Map map);
	public Map dPrcDoc(Map map)throws Exception;
	public Map dPrcDocAdmin(Map map) throws Exception;

	public Map dPrcDocApproval(Map map) throws Exception;
	
	public Map dPrcDocApprovalStateUpdate(Map map) throws Exception;
	
	public Map emPrcJobAction(Map map) throws Exception;
	public Map emPrcJobOrder(Map map) throws Exception;

	public Map dPrcDefJobsFile(Map map) throws Exception;
	
	public Doc01Bean dGetDefJobInfo(Map map);
	
	public CommonBean dGetJobGroupListCnt(Map map);
	
	public List<JobGroupBean> dGetJobGroupList(Map map);
	
	public JobGroupBean dGetJobGroupDetail(Map map);
	
	public CommonBean dGetJobGroupDetailListCnt(Map map);
	
	public List<DefJobBean> dGetJobGroupDetailList(Map map);

	public CommonBean dGetChkGroupJobCnt(Map map);
	
	public Map dPrcJobGroup(Map map)throws Exception;
	
	public JobGroupBean dGetJobGroupDetailId(Map map);
	
	/*public Map dPrcDoc05(Map map)throws Exception;*/
	public Map dPrcDocGroup(Map map)throws Exception;
	/*public Map dPrcDocGroup05(Map map)throws Exception;*/
	/*public Map dPrcDoc05Admin(Map map)throws Exception;*/
	/*public Map dPrcDocGroup05Admin(Map map)throws Exception;*/
	
	public JobGroupBean dGetJobGroupId(Map map);
	public JobGroupBean dGetJobGroupMainCd(Map map);
	
	public List<Doc05Bean> dGetJobGroupDetailApprovalList(Map map); 
	
	public ApprovalInfoBean dGetApprovalMentInfo(Map map);
	
	public CommonBean dGetGeneralApprovalLineCnt(Map map);
	
	public Map dPrcApprovalDocUserUpdate(Map map);
	
	public Map emPrcAjobUpdate(Map map) throws Exception;
	
	public Map dJobSchForecast(Map map) throws Exception;
	
	/*public Map dPrcJobStatus(Map map) throws Exception;*/
	
	
	public Map dPrcDoc06(Map map)throws Exception;
	public Map dPrcDoc06Admin(Map map) throws Exception;
	public Doc06Bean dGetDoc06(Map map);
	public List<Doc06Bean> dGetDoc06DetailList(Map map);
	public List<Doc06Bean> dGetDoc06DetailList2(Map map);
	
	
	public List<Doc01Bean> dGetDocSetList(Map map);
	
	public CommonBean dGetActiveGroupJobListCnt(Map map);
    public List<ActiveJobBean> dGetActiveGroupJobList(Map map);

    public CommonBean dGetMainDocInfoListCnt(Map map);
    public List<DocInfoBean> dGetMainDocInfoList(Map map);
 	public List<DocInfoBean> dGetMainDocInfoList2(Map map);

    public Map dPrcUploadTable(Map map)throws Exception;
    
    public List<DocInfoBean> dGetApprovalLineInfoList(Map map);
    
    public Map dSchedTableJob(Map map)throws Exception;
    
    public List<DefJobBean> dGetQrList(Map map);
    
    public Map dQrResource(Map map)throws Exception;
	public Map dPrcDoc09(Map map)throws Exception;
	public Doc01Bean dGetGroupDocInfo(Map map)throws Exception;
	
	public CommonBean dGetScodeDesc(Map map);
	
	public List<Doc02Bean> dGetDoc02List(Map map);
	
	
	public int dGetChkDefJobCnt(Map map);
	
	public List<Doc02Bean> dGetDoc02List2(Map<String, Object> map);
	public List<Doc02Bean> dGetDoc02JobList2(Map<String, Object> map);
	
	
	public Map<String, Object> dPrcReRunDoc(Map<String, Object> map);
	
	/*public Map dPrcDoc07(Map map)throws Exception;*/
	/*public Map dPrcDoc07Admin(Map map) throws Exception;*/
	
	public Map dPrcMyWork(Map map) throws Exception;
	public CommonBean dGetInsUserMail(Map map);
	public CommonBean dGetApprovalUserMail(Map map);
	public List<CommonBean> dGetApprovalAdminGroupMailList(Map map);
	
	public Map dPrcDocApprovalFlagUpdate(Map map) throws Exception;
	public Map deleteCondition(Map map) throws Exception;
	
	public CommonBean dGetDocApprovalStartCnt(Map map);

	public CommonBean dGetDocApprovalStartChk(Map map);
	public CommonBean dGetCurApprovalCnt(Map map);
	
	public Map dPrcDoc08(Map map)throws Exception;
	public Map dPrcDoc08Admin(Map map)throws Exception;
	
	public List<DocInfoBean> dGetForecastDocList(Map map);
	
	public Map dPrcWorkGroup(Map map)throws Exception;
	
	public CommonBean dGetWorkGroupDetail(Map map);
	
	public List<DefJobBean> dGetFolderGroupList(Map map);
	
	public DocInfoBean dGetChkApprovalStatus(Map map);

	public DocInfoBean dGetApprovalNotiInfo(Map map);
	
	public Map dPrcExcelUserChange(Map map)throws Exception;

	public CommonBean dGetDocApprovalAlreadyCnt(Map map);

	public Map excel_verify(Map map) throws Exception;
}
