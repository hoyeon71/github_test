package com.ghayoun.ezjobs.m.repository;

import com.ghayoun.ezjobs.comm.domain.CommonBean;
import com.ghayoun.ezjobs.common.util.CommonUtil;
import com.ghayoun.ezjobs.m.domain.ActiveJobBean;
import com.ghayoun.ezjobs.m.domain.JobDetailBean;
import com.ghayoun.ezjobs.m.domain.JobLogBean;
import com.ghayoun.ezjobs.m.domain.JobMemoBean;
import com.ghayoun.ezjobs.t.domain.JobBasicInfo;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import java.util.List;
import java.util.Map;

public class PopupJobDetailDaoImpl extends SqlMapClientDaoSupport implements PopupJobDetailDao {
	
	

    /** Logger for this class and subclasses */
	protected final Log logger = LogFactory.getLog(getClass());
	
	public JobDetailBean dGetJobDetail(Map map){
		JobDetailBean bean = (JobDetailBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"M.jobDetail",map);
        return bean;
	}
	
	public CommonBean dGetJobMemoListCnt(Map map){
		CommonBean bean =  (CommonBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"M.jobMemoListCnt",map);
		return bean;
	}
	public List<JobMemoBean> dGetJobMemoList(Map map){
		List<JobMemoBean> beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"M.jobMemoList",map);
        return beanList;
	}
	
	//procedure
	public Map dPrcJobMemo(Map map){
		getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"M.spJobMemoPrc",map);
		return map;
	}
	
	public List<JobLogBean> dGetJobLogListContent(Map map){
		List<JobLogBean> beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"M.jobLogContentList",map);
        return beanList;
	}
	
	public List<ActiveJobBean> dGetJobAvgInfoList(Map map){
		List<ActiveJobBean> beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"M.jobAvgInfoList",map);
        return beanList;
	}

	@Override
	public JobBasicInfo dGetJobBasicInfo(Map<String, Object> paramMap) {
		JobBasicInfo jobBasicInfoList = (JobBasicInfo) getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"M.jobBasicInfo", paramMap);
		return jobBasicInfoList;
	}
	
	public List<JobBasicInfo> dGetJobapprovalInfo(Map<String, Object> paramMap) {
		List<JobBasicInfo> jobBasicInfoList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"M.jobapprovalInfo", paramMap);
		return jobBasicInfoList;
	}
	
	public List<JobLogBean> dGetOutCondList(Map map){
		List<JobLogBean> beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"M.outCondList",map);
        return beanList;
	}
	
	
}
