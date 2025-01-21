package com.ghayoun.ezjobs.m.repository;

import com.ghayoun.ezjobs.comm.domain.CommonBean;
import com.ghayoun.ezjobs.common.util.CommonUtil;
import com.ghayoun.ezjobs.m.domain.CtmInfoBean;
import com.ghayoun.ezjobs.t.domain.DefJobBean;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;
import java.util.List;
import java.util.Map;

public class CtmInfoDaoImpl extends SqlMapClientDaoSupport implements CtmInfoDao {
	
	

    /** Logger for this class and subclasses */
	protected final Log logger = LogFactory.getLog(getClass());
	
	
	public List<CtmInfoBean> dGetAgentList(Map map){
		List<CtmInfoBean> beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"M.agentList",map);
        return beanList;
	}
	
	public CommonBean dGetJobCondListCnt(Map map){
		CommonBean bean =  (CommonBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"M.jobCondListCnt",map);
		return bean;
	}
	
	public List<CtmInfoBean> dGetJobCondList(Map map){
		List<CtmInfoBean> beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"M.jobCondList",map);
        return beanList;
	}
	
	public List<CommonBean> dGetCmsNodGrpList(Map map){
		List<CommonBean> beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"CTM.cmsNodGrpList",map);
        return beanList;
	}
	
	public List<CommonBean> dGetCmsNodGrpNodeList(Map map) {
		List<CommonBean> beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"CTM.cmsNodGrpNodeList",map);
        return beanList;
	}
	
	public List<CommonBean> dGetResourceList(Map map) {
		
		return getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"CTM.resourceList", map);
	}
	
	public List<CommonBean> dGetUsedJobList(Map map) {
		
		return getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"CTM.usedJobList", map);
	}
	
	public List<CommonBean> dGetCtmHost(Map map) {
		
		return getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"CTM.ctmHostList", map);
	}
	
	//connection profile Host 리스트
	public List<DefJobBean> dGetHostList(Map map) {
		return getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"CTM.hostList", map);
	}
	
	public CtmInfoBean dGetExcutingJob(Map map) {
		CtmInfoBean bean =  (CtmInfoBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"CTM.excutingJobList",map);
		return bean;
	}
	
}
