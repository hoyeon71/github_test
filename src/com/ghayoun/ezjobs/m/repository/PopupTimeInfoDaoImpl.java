package com.ghayoun.ezjobs.m.repository;

import com.ghayoun.ezjobs.common.util.CommonUtil;
import com.ghayoun.ezjobs.m.domain.TimeInfoBean;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import java.util.List;
import java.util.Map;

public class PopupTimeInfoDaoImpl extends SqlMapClientDaoSupport implements PopupTimeInfoDao {
	
	

    /** Logger for this class and subclasses */
	protected final Log logger = LogFactory.getLog(getClass());
	
	public List<TimeInfoBean> dGetAtiveStartTimeList(Map map){
		List<TimeInfoBean> beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"M.activeStartTimeList",map);
        return beanList;
	}
	
	public List<TimeInfoBean> dGetTimeInfoList(Map map){
		List<TimeInfoBean> beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"M.timeInfoList",map);
        return beanList;
	}

	public List<TimeInfoBean> dGetEndTimeInfoList(Map map){
		List<TimeInfoBean> beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"M.EndTimeInfoList",map);
		return beanList;
	}
}
