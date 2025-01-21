package com.ghayoun.ezjobs.m.repository;

import com.ghayoun.ezjobs.common.util.CommonUtil;
import com.ghayoun.ezjobs.m.domain.WaitDetailBean;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import java.util.List;
import java.util.Map;

public class PopupWaitDetailDaoImpl extends SqlMapClientDaoSupport implements PopupWaitDetailDao {
	
	

    /** Logger for this class and subclasses */
	protected final Log logger = LogFactory.getLog(getClass());
	
	public List<WaitDetailBean> dGetWaitConditionDetail(Map map){
		List<WaitDetailBean> beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"M.waitConditionDetail",map);
        return beanList;
	}
	
	public List<WaitDetailBean> dGetWaitTimeDetail(Map map){
		List<WaitDetailBean> beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"M.waitTimeDetail",map);
        return beanList;
	}
}
