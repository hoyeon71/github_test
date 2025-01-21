package com.ghayoun.ezjobs.m.repository;

import com.ghayoun.ezjobs.comm.domain.CommonBean;
import com.ghayoun.ezjobs.common.util.CommonUtil;
import com.ghayoun.ezjobs.m.domain.DefJobBean;
import com.ghayoun.ezjobs.m.domain.JobLogBean;
import com.ghayoun.ezjobs.m.domain.JobOpBean;
import com.ghayoun.ezjobs.m.domain.TotalJobStatus;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import java.util.List;
import java.util.Map;

public class EmJobLogDaoImpl extends SqlMapClientDaoSupport implements EmJobLogDao {
	
	

    /** Logger for this class and subclasses */
	protected final Log logger = LogFactory.getLog(getClass());
	
	public JobLogBean dGetJobLogListCnt(Map map){
		JobLogBean bean =  (JobLogBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"M.jobLogListCnt",map);
		return bean;
	}
	public List<JobLogBean> dGetJobLogList(Map map){
		List<JobLogBean> beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"M.jobLogList",map);
        return beanList;
	}

	public List<JobLogBean> dGetJobLogInfoList(Map map){
		List<JobLogBean> beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"M.jobLogInfoList",map);
		return beanList;
	}

	public JobLogBean dGetJobLogHistoryListCnt(Map map){
		JobLogBean bean =  (JobLogBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"M.jobLogHistoryListCnt",map);
		return bean;
	}
	public List<JobLogBean> dGetJobLogHistoryList(Map map){
		List<JobLogBean> beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"M.jobLogHistoryList",map);
        return beanList;
	}

	public CommonBean dGetJobOpListCnt(Map map){
		CommonBean bean =  (CommonBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"M.jobOpListCnt",map);
		return bean;
	}
	public List<JobOpBean> dGetJobOpList(Map map){
		List<JobOpBean> beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"M.jobOpList",map);
        return beanList;
	}
	public List<TotalJobStatus> dGetJobOpListReport(Map map){
		List<TotalJobStatus> beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"M.jobOpListReport",map);
        return beanList;
	}
	public List<JobLogBean> dGetJobOpReportList(Map map){
		List<JobLogBean> beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"M.jobOpReportList",map);
        return beanList;
	}

	public CommonBean dGetHistoryDayCnt(Map map){
		CommonBean bean =  (CommonBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"M.historyDayCnt",map);
		return bean;
	}
	
	public CommonBean dGetTimeOverJobLogListCnt(Map map){
		CommonBean bean =  (CommonBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"M.timeOverJobLogListCnt",map);
		return bean;
	}
	public List<JobLogBean> dGetTimeOverJobLogList(Map map){
		List<JobLogBean> beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"M.timeOverJobLogList",map);
        return beanList;
	}
	
	public CommonBean dGetJobGroupListCnt(Map map){
		CommonBean bean =  (CommonBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"M.jobGroupListCnt",map);
		return bean;
	}
	public List<JobLogBean> dGetJobGroupList(Map map){
		List<JobLogBean> beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"M.jobGroupList",map);
        return beanList;
	}
	
	public List<JobLogBean> dGetJobGroupInfoList(Map map){
		List<JobLogBean> beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"M.jobGroupInfoList",map);
        return beanList;
	}
	
	public List<JobLogBean> dGetJobOpStatsReportList(Map map){
		List<JobLogBean> beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"M.jobOpStatsReportList",map);
        return beanList;
	}
	
	public JobLogBean dGetJobOpReportInfo(Map map){
		JobLogBean bean =  (JobLogBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"M.jobOpReportInfo",map);
		return bean;
	}

	public JobLogBean dGetJobSysout(Map map){
		JobLogBean bean =  (JobLogBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"M.jobSysout",map);
		return bean;
	}
}
