package com.ghayoun.ezjobs.t.repository;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.HashMap;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import com.ghayoun.ezjobs.t.domain.*;
import com.ghayoun.ezjobs.comm.domain.CommonBean;
import com.ghayoun.ezjobs.common.util.CommonUtil;
import com.ghayoun.ezjobs.common.axis.*;

public class WorksApprovalLineDaoImpl extends SqlMapClientDaoSupport implements WorksApprovalLineDao {
	
	

    /** Logger for this class and subclasses */
	protected final Log logger = LogFactory.getLog(getClass());
	
	public List<ApprovalLineBean> dGetApprovalLineList(Map map){
		List<ApprovalLineBean> beanList = null;
    	
		beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.approvalLineList",map);
		return beanList;
	}
	public List<ApprovalLineBean> dGetUserApprovalLineList(Map map){
		List<ApprovalLineBean> beanList = null;
    	
		beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.userApprovalLineList",map);
		return beanList;
	}

	//procedure
	public Map dPrcApprovalLine(Map map){
		getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.spApprovalLinePrc",map);
		return map;
	}
	
	//procedure
	public Map dPrcApprovalLine_new(Map map){
		getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.spApprovalLinePrc_new",map);
		return map;
	}
	
	//procedure
	public Map dPrcApprovalLine_general(Map map){

		getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.spApprovalLinePrc_general",map);
		return map;
	}
	
	public List<ApprovalLineBean> dGetFinalAppList(Map map){
		
		List<ApprovalLineBean> beanList = null;    	
		beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.finalAppList",map);
		
		return beanList;
	}
	
	
	public List<ApprovalLineBean> dGetDeptAppList(Map map){
			
			List<ApprovalLineBean> beanList = null;    	
			beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.deptAppList",map);
			
			return beanList;
		}
	//procedure
	public Map dPrcFinalApp(Map map){
		getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.spFinalAppPrc",map);
		return map;
	}
	
	public CommonBean dGetApprovalLineCnt(Map map){
		CommonBean bean =  (CommonBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.approvalLineCnt",map);
		return bean;
	}
	
	public List<ApprovalLineBean> dGetGroupAppList(Map map){
		
		List<ApprovalLineBean> beanList = null;    	
		beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.groupAppList",map);
		
		return beanList;
	}
	
	public CommonBean dGetApprovalLineCnt_pop(Map map){
		CommonBean bean =  (CommonBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.approvalLineCnt_pop",map);
		return bean;
	}
}
