package com.ghayoun.ezjobs.m.repository;

import com.ghayoun.ezjobs.common.util.CommonUtil;
import com.ghayoun.ezjobs.m.domain.JobGraphBean;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import java.util.List;
import java.util.Map;

public class PopupJobGraphDaoImpl extends SqlMapClientDaoSupport implements PopupJobGraphDao {

    /** Logger for this class and subclasses */
	protected final Log logger = LogFactory.getLog(getClass());
	
	public List<JobGraphBean> dGetJobGraphList(Map map){
		List<JobGraphBean> beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"M.jobGraphList",map);
        return beanList;
	}
	
	public List<JobGraphBean> dGetJobGraphList_ez012(Map map){
		List<JobGraphBean> beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"M.jobGraphList_ez012",map);
        return beanList;
	}

	public List<JobGraphBean> dGetJobGraphHistoryList(Map map){
		List<JobGraphBean> beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"M.jobGraphHistoryList",map);
        return beanList;
	}
}
