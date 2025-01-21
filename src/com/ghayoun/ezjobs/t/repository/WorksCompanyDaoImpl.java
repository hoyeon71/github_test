package com.ghayoun.ezjobs.t.repository;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import java.util.HashMap;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.ghayoun.ezjobs.t.domain.*;
import com.ghayoun.ezjobs.comm.domain.CommonBean;
import com.ghayoun.ezjobs.common.util.CommonUtil;
import com.ghayoun.ezjobs.common.axis.*;

public class WorksCompanyDaoImpl extends SqlMapClientDaoSupport implements WorksCompanyDao {
	
	

    /** Logger for this class and subclasses */
	protected final Log logger = LogFactory.getLog(getClass());
	
	
	public List<CompanyBean> dGetDeptList(Map map){
		List<CompanyBean> beanList = null;
    	
		beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.deptList",map);
		return beanList;
	}

	public List<CompanyBean> dGetDutyList(Map map){
		List<CompanyBean> beanList = null;
    	
		beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.dutyList",map);
		return beanList;
	}
	
	public List<CompanyBean> dGetTeamList(Map map){
		List<CompanyBean> beanList = null;
    	
		beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.teamList",map);
		return beanList;
	}
	
	
	//procedure
	public Map dPrcDept(Map map){
		getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.spDeptPrc",map);
		return map;
	}
	
	public int dGetDeptCnt(Map<String, Object> map) {
		
		return (int) getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.deptCnt", map);
	}
	
	public Map dPrcDuty(Map map){
		getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.spDutyPrc",map);
		return map;
	}
	
	public int dGetDutyCnt(Map<String, Object> map) {
		
		return (int) getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.dutyCnt", map);
	}
	
	public Map dPrcPart(Map map){
		getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.spPartPrc",map);
		return map;
	}
	
	public Map dPrcTeam(Map map){
		getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.spTeamPrc",map);
		return map;
	}
	
	public List<CommonBean> dGetMCodeList(Map map){
		List<CommonBean> beanList = null;
    	
		beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.mCodeList",map);
		return beanList;
	}
	
	public List<CommonBean> dGetSCodeList(Map map){
		List<CommonBean> beanList = null;
		HttpServletRequest request 	= ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
		HttpSession	session			= request.getSession(true);
		map.put("server_gb", 	CommonUtil.isNull(CommonUtil.getMessage("SERVER_GB")));
		map.put("s_user_gb", 	CommonUtil.isNull(session.getAttribute("USER_GB")));
		beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.sCodeList",map);
		return beanList;
	}
	
	//procedure
	public Map dPrcCode(Map map){
		getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.spCodePrc",map);
		return map;
	}
	
	public Map dPrcTags(Map map){
		getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.spTagsPrc",map);
		return map;
	}
	
	public List<TagsBean> dGetTagsList(Map map){
		List<TagsBean> beanList = null;		
		beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.tagsList",map);
		return beanList;
	}
	
	public TagsBean dGetTagsSchedInfo(Map map){
		TagsBean bean =  (TagsBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.tagsSchedInfo",map);
		return bean;
	}
	
	public List<TagsBean> dGetDefTagsList(Map map){
		List<TagsBean> beanList = null;		
		beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.defTagsList",map);
		return beanList;
	}
	
	public TagsBean dGetDefTagsSchedInfo(Map map){
		TagsBean bean =  (TagsBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.defTagsSchedInfo",map);
		return bean;
	}
	
	public CommonBean dGetTableInfo(Map map){
		CommonBean bean =  (CommonBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.getTableInfo",map);
		return bean;
	}
	
	public List<TagsBean> dGetDefTagsList2(Map map){
		List<TagsBean> beanList = null;		
		beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.defTagsList2",map);
		return beanList;
	}
	
	public TagsBean dGetTagsInfo(Map map){
		TagsBean bean =  (TagsBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.getTagsInfo",map);
		return bean;
	}
}
