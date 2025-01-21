package com.ghayoun.ezjobs.m.repository;

import com.ghayoun.ezjobs.comm.domain.CommonBean;
import com.ghayoun.ezjobs.common.util.CommonUtil;
import com.ghayoun.ezjobs.m.domain.BatchResultTotalBean;
import com.ghayoun.ezjobs.m.domain.TotalJobStatus;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;
import java.util.List;
import java.util.Map;

public class EmBatchResultTotalDaoImpl extends SqlMapClientDaoSupport implements EmBatchResultTotalDao {
	
	

    /** Logger for this class and subclasses */
	protected final Log logger = LogFactory.getLog(getClass());
	
	public List<BatchResultTotalBean> dGetBatchResultTotalList(Map map){
		List<BatchResultTotalBean> beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"M.batchResultTotalList",map);
        return beanList;
	}
	
	public List<BatchResultTotalBean> dGetNodeList(Map map){
		List<BatchResultTotalBean> beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"M.nodeList",map);
        return beanList;
	}
	
	public List<BatchResultTotalBean> dGetNodeTimeList(Map map){
		List<BatchResultTotalBean> beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"M.nodeTimeList",map);
        return beanList;
	}
	
	public List<BatchResultTotalBean> dGetMonthBatchResultTotalList(Map map){
		List<BatchResultTotalBean> beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"M.monthBatchResultTotalList",map);
        return beanList;
	}
	
	public CommonBean dGetDataCenterInfo(Map map){
		CommonBean bean =  (CommonBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.dataCenterInfo",map);
		return bean;
	}
	
	public CommonBean dGetDataCenterInfoAjob(Map map){
		CommonBean bean =  (CommonBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.dataCenterInfoAjob",map);
		return bean;
	}
	public List<BatchResultTotalBean> dGetBatchResultTotalList2(Map map){
		List<BatchResultTotalBean> beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"M.batchResultTotalList2",map);
        return beanList;
	}
	
	public List<BatchResultTotalBean> dGetBatchResultTotalList3(Map map){
		List<BatchResultTotalBean> beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"M.batchResultTotalList3",map);
        return beanList;
	}
	public List<BatchResultTotalBean> dGetBatchResultAppList3(Map map){
		List<BatchResultTotalBean> beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"M.batchResultAppList3",map);
		return beanList;
	}
	public List<BatchResultTotalBean> dGetBatchResultStatusList3(Map map){
		List<BatchResultTotalBean> beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"M.batchResultStatusList3",map);
		return beanList;
	}
	public List<BatchResultTotalBean> dGetHistoryFailJobList(Map map){
		List<BatchResultTotalBean> beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"M.historyFailJobList",map);
        return beanList;
	}
	public List<CommonBean> dGetResourceNMList(Map map){
		List<CommonBean> beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"M.resourceNMList",map);
		return beanList;
	}
	public List<CommonBean> dGetResourceHHList(Map map){
		List<CommonBean> beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"M.resourceHHList",map);
		return beanList;
	}
	public List<CommonBean> dGetResourceTimeList(Map map){
		List<CommonBean> beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"M.resourceTimeList",map);
		return beanList;
	}
	public List<BatchResultTotalBean> dGetBatchReport(Map map){
		List<BatchResultTotalBean> beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"M.batchReport",map);
        return beanList;
	}
}
