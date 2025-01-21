package com.ghayoun.ezjobs.m.repository;

import com.ghayoun.ezjobs.comm.domain.CommonBean;
import com.ghayoun.ezjobs.common.util.CommonUtil;
import com.ghayoun.ezjobs.m.domain.PreDateBatchScheduleBean;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import java.util.List;
import java.util.Map;

public class EmPreDateBatchScheduleDaoImpl extends SqlMapClientDaoSupport implements EmPreDateBatchScheduleDao {
	
	

    /** Logger for this class and subclasses */
	protected final Log logger = LogFactory.getLog(getClass());
	
	public CommonBean dGetPreDateBatchScheduleListCnt(Map map){
		CommonBean bean =  (CommonBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"M.preDateBatchScheduleListCnt",map);
		return bean;
	}
	public List<PreDateBatchScheduleBean> dGetPreDateBatchScheduleList(Map map){
		List<PreDateBatchScheduleBean> beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"M.preDateBatchScheduleList",map);
        return beanList;
	}
	public List<PreDateBatchScheduleBean> dGetPreDateBatchScheduleOrderList(Map map){
		List<PreDateBatchScheduleBean> beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"M.preDateBatchScheduleOrderList",map);
        return beanList;
	}
	@Override
	public List<PreDateBatchScheduleBean> dGetRelForecastTableList(Map<String, Object> paramMap) {
		List<PreDateBatchScheduleBean> beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"M.relForecastTableList", paramMap);
		return beanList;
	}
}
