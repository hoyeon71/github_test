package com.ghayoun.ezjobs.t.repository;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.HashMap;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import com.ghayoun.ezjobs.m.domain.CtmInfoBean;
import com.ghayoun.ezjobs.t.domain.*;
import com.ghayoun.ezjobs.a.domain.AlertBean;
import com.ghayoun.ezjobs.comm.domain.AppGrpBean;
import com.ghayoun.ezjobs.comm.domain.CommonBean;
import com.ghayoun.ezjobs.common.util.CommonUtil;
import com.ghayoun.ezjobs.common.axis.*;

public class WorksApprovalDocDaoImpl extends SqlMapClientDaoSupport implements WorksApprovalDocDao {
	
	

    /** Logger for this class and subclasses */
	protected final Log logger = LogFactory.getLog(getClass());
	
	@SuppressWarnings("unchecked")
	public List<ApprovalInfoBean> dGetApprovalInfoList(Map map){
		List<ApprovalInfoBean> beanList = null;
    	
		beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.approvalInfoList",map);  
		return beanList;
	}
	

	public CommonBean dGetAllDocInfoListCnt(Map map){
		CommonBean bean =  (CommonBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.allDocInfoListCnt",map);
		return bean;
	}
	public List<DocInfoBean> dGetAllDocInfoList(Map map){
		List<DocInfoBean> beanList = null;
    	
		beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.allDocInfoList",map);
		return beanList;
	}
	
	
	public CommonBean dGetMyDocInfoListCnt(Map map){
		CommonBean bean =  (CommonBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.myDocInfoListCnt",map);
		return bean;
	}
	public List<DocInfoBean> dGetMyDocInfoList(Map map){
		List<DocInfoBean> beanList = null;
    	
		beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.myDocInfoList",map);
		return beanList;
	}
	
	public CommonBean dGetApprovalDocInfoListCnt(Map map){
		CommonBean bean =  (CommonBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.approvalDocInfoListCnt",map);
		return bean;
	}
	public List<DocInfoBean> dGetApprovalDocInfoList(Map map){
		List<DocInfoBean> beanList = null;
    	
		beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.approvalDocInfoList",map);
		return beanList;
	}
	
	
	public DefJobBean dGetDefJobListCnt(Map map){
		DefJobBean bean =  (DefJobBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.defJobListCnt",map);
		return bean;
	}
	public List<DefJobBean> dGetDefJobList(Map map){
		List<DefJobBean> beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.defJobList",map);
        return beanList;
	}
	
	
	public ActiveJobBean dGetActiveJobListCnt(Map map){
		System.out.println("map ::: " + map );
		ActiveJobBean bean =  (ActiveJobBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.activeJobListCnt",map);
		return bean;
	}
	public List<ActiveJobBean> dGetActiveJobList(Map map){
		List<ActiveJobBean> beanList = null;
		beanList =  getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.activeJobList",map);
		return beanList;
	}

	public List<ActiveJobBean> dGetActiveJobCntList(Map map){
		List<ActiveJobBean> beanList = null;
		beanList =  getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.activeJobCntList",map);
		return beanList;
	}

	public Doc01Bean dGetDoc01(Map map){
		Doc01Bean bean =  (Doc01Bean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.doc01",map);
		return bean;
	}
	public Doc01Bean dGetDoc02(Map map){
		Doc01Bean bean =  (Doc01Bean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.doc02",map);
		return bean;
	}
	public Doc03Bean dGetDoc03(Map map){
		Doc03Bean bean =  (Doc03Bean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.doc03",map);
		return bean;
	}
	public Doc01Bean dGetDoc04(Map map){
		Doc01Bean bean =  (Doc01Bean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.doc04",map);
		return bean;
	}
	public Doc01Bean dGetDoc04_original(Map map){
		Doc01Bean bean =  (Doc01Bean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.doc04_original",map);
		return bean;
	}
	public Doc05Bean dGetDoc05(Map map){
		Doc05Bean bean =  (Doc05Bean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.doc05",map);
		return bean;
	}
	public Doc07Bean dGetDoc07(Map map){
		Doc07Bean bean =  (Doc07Bean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.doc07",map);
		return bean;
	}
	public Doc08Bean dGetDoc08(Map map){
		Doc08Bean bean =  (Doc08Bean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.doc08",map);
		return bean;
	}
	public Doc01Bean dGetDoc09(Map map){
		Doc01Bean bean =  (Doc01Bean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.doc09_gb",map);
		return bean;
	}
	public Doc01Bean dGetDoc10(Map map){
		Doc01Bean bean =  (Doc01Bean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.doc10",map);
		return bean;
	}
	public Doc05Bean dGetGroupDoc05(Map map){
		Doc05Bean bean =  (Doc05Bean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.groupDoc05",map);
		return bean;
	}
	public Doc01Bean dGetJobModifyInfo(Map map){
		Doc01Bean bean = (Doc01Bean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.jobModifyInfoBasic",map);
		
		if( bean != null){
//			String t_general_date = CommonUtil.isNull(bean.getT_general_date());
//			if(!"".equals(t_general_date)){
//				for(int i=0;i<=t_general_date.length();i=(i+4)){
//					if(i==0){
//						if((i+4)<=t_general_date.length()) bean.setT_general_date(t_general_date.substring(i,(i+4)));
//					}else{
//						if((i+4)<=t_general_date.length()) bean.setT_general_date(bean.getT_general_date()+"|"+t_general_date.substring(i,(i+4)));
//					}
//				}
//			}
			
			List<Doc01Bean> beans =  null;
			
			beans = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.jobModifyInfoConditionsIn",map);
			for(int i=0; null!=beans && i<beans.size(); i++){
				if(i==0){
					bean.setT_conditions_in(beans.get(i).getT_conditions_in());
				}else{
					bean.setT_conditions_in(bean.getT_conditions_in()+"|"+beans.get(i).getT_conditions_in());
				}
			}
			beans = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.jobModifyInfoConditionsOut",map);
			for(int i=0; null!=beans && i<beans.size(); i++){
				if(i==0){
					bean.setT_conditions_out(beans.get(i).getT_conditions_out());
				}else{
					bean.setT_conditions_out(bean.getT_conditions_out()+"|"+beans.get(i).getT_conditions_out());
				}
			}
			beans = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.jobModifyInfoResourcesQ",map);
			for(int i=0; null!=beans && i<beans.size(); i++){
				if(i==0){
					bean.setT_resources_q(beans.get(i).getT_resources_q());
				}else{
					bean.setT_resources_q(bean.getT_resources_q()+"|"+beans.get(i).getT_resources_q());
				}
			}
			beans = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.jobModifyInfoResourcesC",map);
			for(int i=0; null!=beans && i<beans.size(); i++){
				if(i==0){
					bean.setT_resources_c(beans.get(i).getT_resources_c());
				}else{
					bean.setT_resources_c(bean.getT_resources_c()+"|"+beans.get(i).getT_resources_c());
				}
			}
			beans = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.jobModifyInfoSetVar",map);
			for(int i=0; null!=beans && i<beans.size(); i++){
				if(i==0){
					bean.setT_set(beans.get(i).getT_set());
				}else{
					bean.setT_set(bean.getT_set()+"|"+beans.get(i).getT_set());
				}
			}
			beans = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.jobModifyInfoStep",map);
			for(int i=0; null!=beans && i<beans.size(); i++){
				if(i==0){
					bean.setT_steps(beans.get(i).getT_steps());
				}else{
					bean.setT_steps(bean.getT_steps()+"|"+beans.get(i).getT_steps());
				}
			}
			beans = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.jobModifyInfoShout",map);
			for(int i=0; null!=beans && i<beans.size(); i++){
				if(i==0){
					bean.setT_postproc(beans.get(i).getT_postproc());
				}else{
					bean.setT_postproc(bean.getT_postproc()+"|"+beans.get(i).getT_postproc());
				}
			}
			
			/*
			beans = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.jobModifyInfoTags",map);
			for(int i=0; null!=beans && i<beans.size(); i++){
				if(i==0){
					bean.setT_postproc(beans.get(i).getT_postproc());
				}else{
					bean.setT_postproc(bean.getT_postproc()+"|"+beans.get(i).getT_postproc());
				}
			}
			*/
		}
		
		return bean;
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<AppGrpBean> dGetAppGrpCodeList(Map map) {
		
		return getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.appGrpCodeList", map);
	}
	
	//procedure
	public Map dPrcDoc01(Map map){
		getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.spDoc01Prc",map);
		return map;
	}
	public Map dPrcDoc02(Map map){
		getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.spDoc02Prc",map);
		return map;
	}
	public Map dPrcDoc03(Map map){
		getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.spDoc03Prc",map);
		return map;
	}
	public Map dPrcDoc04(Map map){
		getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.spDoc04Prc",map);
		return map;
	}
	public Map dPrcDoc07(Map map){
		getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.spDoc07Prc",map);
		return map;
	}
	public Map dPrcDoc10(Map map){
		getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.spDoc10Prc",map);
		return map;
	}
	
	public Map dPrcDocSetvar(Map map){
		getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.spDocSetvarPrc",map);
		return map;
	}
	
	public Map dPrcDocApproval(Map map){
		getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.spDocApprovalPrc",map);
		return map;
	}
	

	public Map dPrcDefJobsFile(Map map){
		getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.spDefJobsFilePrc",map);
		return map;
	}
	
	public CommonBean dGetChkDefJobCnt(Map map){
		CommonBean bean;
		
		if(CommonUtil.isNull(map.get("NewOrNot")).equals("Y")) {
			bean =  (CommonBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.NewChkDefJobCnt",map);
		}else {
			bean =  (CommonBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.chkDefJobCnt",map);
		}
		
		return bean;
	}
	
	public CommonBean dGetChkDoc03Cnt(Map map){
		CommonBean bean =  (CommonBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.chkDoc03Cnt",map);
		return bean;
	}
	
	public CommonBean dGetChkDoc03Cnt2(Map map){
		CommonBean bean =  (CommonBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.chkDoc03Cnt2",map);
		return bean;
	}
	
	public CommonBean dGetChkDoc04Cnt(Map map){
		CommonBean bean =  (CommonBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.chkDoc04Cnt",map);
		return bean;
	}
	
	public CommonBean dGetChkDoc04Cnt2(Map map){
		CommonBean bean =  (CommonBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.chkDoc04Cnt2",map);
		return bean;
	}
	
	public CommonBean dGetChkDoc06JobCnt(Map map){
		CommonBean bean =  (CommonBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.chkDoc06JobCnt",map);
		return bean;
	}
	
	public CommonBean dGetChkDeptCnt(Map map){
		CommonBean bean =  (CommonBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.chkDeptCnt",map);
		return bean;
	}
	
	public Map dPrcDocGroupApproval(Map map){
		getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.spDocApprovalPrc",map);
		return map;
	}
	
	public Doc01Bean dGetDefJobInfo(Map map){
		Doc01Bean bean =  (Doc01Bean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.defJobInfo",map);
		return bean;
	}
	
	public CommonBean dGetJobGroupListCnt(Map map){
		CommonBean bean =  (CommonBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.jobGroupListCnt",map);
		return bean;
	}
	
	public List<JobGroupBean> dGetJobGroupList(Map map){
		List<JobGroupBean> beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.jobGroupList",map);
        return beanList;
	}
	
	public JobGroupBean dGetJobGroupDetail(Map map){
		JobGroupBean bean =  (JobGroupBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.jobGroupDetail",map);
		return bean;
	}
	
	public CommonBean dGetJobGroupDetailListCnt(Map map){
		CommonBean bean =  (CommonBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.jobGroupDetailListCnt",map);
		return bean;
	}
	
	public List<DefJobBean> dGetJobGroupDetailList(Map map){
		List<DefJobBean> beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.jobGroupDetailList",map);
        return beanList;
	}
	
	public CommonBean dGetChkGroupJobCnt(Map map){
		CommonBean bean = (CommonBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.chkGroupJobCnt",map);
        return bean;
	}
	
	public Map dPrcJobGroup(Map map){
		getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.spJobGroupPrc",map);
		return map;
	}
	
	public JobGroupBean dGetJobGroupDetailId(Map map){
		JobGroupBean bean =  (JobGroupBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.jobGroupDetailId",map);
		return bean;
	}
	
	public Map dPrcDoc05(Map map){
		getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.spDoc05Prc",map);
		return map;
	}
	
	public JobGroupBean dGetJobGroupId(Map map){
		JobGroupBean bean =  (JobGroupBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.jobGroupId",map);
		return bean;
	}
	
	public JobGroupBean dGetJobGroupMainCd(Map map){
		JobGroupBean bean =  (JobGroupBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.jobGroupMainCd",map);
		return bean;
	}
	
	public List<Doc05Bean> dGetJobGroupDetailApprovalList(Map map){
		List<Doc05Bean> beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.jobGroupDetailApprovalList",map);
        return beanList;
	}
	
	public CommonBean dGetChkApprovalLineCnt(Map map){
		CommonBean bean =  (CommonBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.chkApprovalLineCnt",map);
		return bean;
	}
	
	public ApprovalInfoBean dGetApprovalMentInfo(Map map){
		ApprovalInfoBean bean =  (ApprovalInfoBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.approvalMentInfo",map);
		return bean;
	}
	
	public CommonBean dGetGeneralApprovalLineCnt(Map map){
		CommonBean bean =  (CommonBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.generalApprovalLineCnt",map);
		return bean;
	}
	
	public List<TagsBean> dGetTagsAllList(Map map){
		List<TagsBean> beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.tagsAllList",map);
        return beanList;
	}
	
	public CommonBean dGetChkAjobTableCnt(Map map){
		CommonBean bean =  (CommonBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.ajobTableCnt",map);
		return bean;
	}
	
	public Map dPrcDocFile(Map map){
		getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.spDocFilePrc",map);
		return map;
	}
	
	public CommonBean dGetOrderId(Map map){
		CommonBean bean =  (CommonBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.getOrderId",map);
		return bean;
	}
	
	public CtmInfoBean dGetEmCommInfo(Map map){
		CtmInfoBean bean =  (CtmInfoBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.emCommInfo",map);
		return bean;
	}
	
	
	
	public Map dPrcDoc06(Map map){		
		getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.spDoc06Prc",map);
		return map;
	}
	
	public Doc06Bean dGetDoc06(Map map){
		Doc06Bean bean =  (Doc06Bean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.doc06",map);
		return bean;
	}
	
	public List<Doc06Bean> dGetDoc06DetailList(Map map){
		List<Doc06Bean> beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.doc06DetailList",map);
        return beanList;
	}
	public List<Doc06Bean> dGetDoc06DetailList2(Map map){
		List<Doc06Bean> beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.doc06DetailList2",map);
		return beanList;
	}
	
	
	
	public List<Doc01Bean> dGetDocSetList(Map map){
		List<Doc01Bean> beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.docSetList",map);
        return beanList;  
	}
	
	public DefJobBean dGetUserCd(Map map){
		DefJobBean bean =  (DefJobBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.getUserCd",map);
		return bean;
	}
	public CommonBean dGetGroupUserCd(Map map){
		CommonBean bean =  (CommonBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.getGroupUserCd",map);
		return bean;
	}
	public DefJobBean dGetUserCd_NM(Map map){
		DefJobBean bean =  (DefJobBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.getUserCd_NM",map);
		return bean;
	}
	
	public ActiveJobBean dGetAjobStatus(Map map){
		ActiveJobBean bean =  (ActiveJobBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.getAjobStatus",map);
		return bean;
	}
	
	public CommonBean dGetActiveGroupJobListCnt(Map map){
		CommonBean bean =  (CommonBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.activeGroupJobListCnt",map);
		return bean;
	}
	public List<ActiveJobBean> dGetActiveGroupJobList(Map map){
		List<ActiveJobBean> beanList = null;
		beanList =  getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.activeGroupJobList",map);
		return beanList;
	}
	
	public CommonBean dGetMainDocInfoListCnt(Map map){
		CommonBean bean =  (CommonBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.mainDocInfoListCnt",map);
		return bean;
	}
	public List<DocInfoBean> dGetMainDocInfoList(Map map){
		List<DocInfoBean> beanList = null;
    	
		beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.mainDocInfoList",map);
		return beanList;
	}
	public List<DocInfoBean> dGetMainDocInfoList2(Map map){
		List<DocInfoBean> beanList = null;
		
		beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.mainDocInfoList2",map);
		return beanList;
	}
	
	public List<DocInfoBean> dGetApprovalLineInfoList(Map map){
		List<DocInfoBean> beanList = null;
    	
		beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.approvalLineInfoList",map);
		return beanList;
	}
	
	public CommonBean dGetChkSchedTableCnt(Map map){
		CommonBean bean =  (CommonBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.chkSchedTableCnt",map);
		return bean;
	}
	
	public CommonBean dGetOrderJobCnt(Map map){
		CommonBean bean =  (CommonBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.orderJobCnt",map);
		return bean;
	}
	
	public CommonBean dGetFailLastSerial(Map map){
		CommonBean bean =  (CommonBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.failLastSerial",map);
		return bean;
	}
	
	public CommonBean dGetChkDoc01JobCnt(Map map){
		CommonBean bean =  (CommonBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.chkDoc01JobCnt",map);
		return bean;
	}
	
	public CommonBean dGetChkApprovalDocDelCnt(Map map){
		CommonBean bean =  (CommonBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.chkApprovalDocDelCnt",map);
		return bean;
	}
	
	
	public List<DefJobBean> dGetQrList(Map map){
		List<DefJobBean> beanList = null;
		beanList =  getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.qrList",map);
		return beanList;
	}

	public Map dPrcDoc09(Map map){
		getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.spDoc09Prc",map);
		return map;
	}

	public Doc01Bean dGetGroupDocInfo(Map map){
		Doc01Bean bean = (Doc01Bean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.groupDocInfo",map);
		return bean;
	}
	
	public CommonBean dGetCheckCalendarOrderDate(Map map){
		CommonBean bean =  (CommonBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.checkCalendarOrderDate",map);
		return bean;
	}

	public CommonBean dGetScodeDesc(Map map){
		CommonBean bean =  (CommonBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.scodeDesc",map);
		return bean;
	}
	
	public Doc02Bean dGetDoc02_tmp(Map map){
		Doc02Bean bean =  (Doc02Bean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.doc02_tmp",map);
		return bean;
	}
	
	public List<Doc02Bean> dGetDoc02List(Map map){
		List<Doc02Bean> beanList = null;
		beanList =  getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.doc02List",map);
		return beanList;
	}
	
	@Override
	public List<Doc02Bean> dGetDoc02List2(Map<String, Object> map) {
		
		return getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.doc02List2",map);
	}
	
	@Override
	public List<Doc02Bean> dGetDoc02JobList2(Map<String, Object> map) {
	
		return getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.doc02JobList2",map);
	}
	
	@Override
	public int dPrcReRunDoc(Map<String, Object> map) {
		
		return getSqlMapClientTemplate().update(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.reRunDoc",map);
	}
	
	public Map dPrcMyWork(Map map){
		getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.spMyWorkPrc",map);
		return map;
	}
	public CommonBean dGetInsUserMail(Map map){
		CommonBean bean =  (CommonBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.insUserMail",map);
		return bean;
	}
	public CommonBean dGetApprovalUserMail(Map map){
		CommonBean bean =  (CommonBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.approvalUserMail",map);
		return bean;
	}
	public List<CommonBean> dGetApprovalAdminGroupMailList(Map map){
		return getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.approvalAdminGroupMailList",map);
	}
	
	public CommonBean dGetDocApprovalStartCnt(Map map){
		CommonBean bean =  (CommonBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.docApprovalStartCnt",map);
		return bean;
	}
	//중복 결재 체크로직
	public CommonBean dGetDocApprovalStartChk(Map map){
		CommonBean bean =  (CommonBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.docApprovalStartChk",map);
		return bean;
	}
	
	public CommonBean dGetCurApprovalCnt(Map map){
		CommonBean bean =  (CommonBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.curApprovalCnt",map);
		return bean;
	}
	
	public CommonBean dGetChkDefTablesLockCnt(Map map){
		CommonBean bean =  (CommonBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.chkDefTablesLockCnt",map);
		return bean;
	}
	
	public CommonBean dGetChkPostApprovalLineCnt(Map map){
		CommonBean bean =  (CommonBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.chkPostApprovalLineCnt",map);
		return bean;
	}
	
	public Map dPrcDoc08(Map map){
		getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.spDoc08Prc",map);
		return map;
	}
	
	public List<DocInfoBean> dGetForecastDocList(Map map){
		List<DocInfoBean> beanList = null;
    	
		beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.forecastDocList",map);
		return beanList;
	}
	
	public Map dPrcWorkGroup(Map map){
		getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.spWorkGroupPrc",map);
		return map;
	}
	
	public CommonBean dGetWorkGroupDetail(Map map){
		CommonBean bean =  (CommonBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.workGroupDetail",map);
		return bean;
	}
	
	public List<DefJobBean> dGetFolderGroupList(Map map){
		List<DefJobBean> beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.folderGroupList",map);
        return beanList;
	}
	
	public CommonBean dGetChkForecastJobCnt(Map map){
		CommonBean bean =  (CommonBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.chkForecastJobCnt",map);
		return bean;
	}
	
	public DocInfoBean dGetChkApprovalStatus(Map map){
		DocInfoBean bean =  (DocInfoBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.chkApprovalStatus",map);
		return bean;
	}

	public Doc01Bean dGetJobDefCheck(Map map){
		Doc01Bean bean =  (Doc01Bean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.jobDefCheck",map);
		return bean;
	}

	public List<Doc01Bean> dGetJobDefCheckList(Map map){
		List<Doc01Bean> beanList =  getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.jobDefCheck",map);
		return beanList;
	}

	public DocInfoBean dGetApprovalNotiInfo(Map map){
		DocInfoBean bean =  (DocInfoBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.approvalNotiInfo",map);
		return bean;
	}

	public CommonBean dGetDocApprovalAlreadyCnt(Map map){
		CommonBean bean =  (CommonBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.docApprovalAlreadyCnt",map);
		return bean;
	}
	
	public Map dPrcDocMFT(Map map){
		getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.spDocSetvarPrc",map);
		return map;
	}
}
