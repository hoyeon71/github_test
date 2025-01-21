package com.ghayoun.ezjobs.m.repository;

import com.ghayoun.ezjobs.comm.domain.CommonBean;
import com.ghayoun.ezjobs.common.util.CommonUtil;
import com.ghayoun.ezjobs.m.domain.CtmInfoBean;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;
import java.util.List;
import java.util.Map;

public class EmCtmInfoDaoImpl extends SqlMapClientDaoSupport implements EmCtmInfoDao {
	
	

    /** Logger for this class and subclasses */
	protected final Log logger = LogFactory.getLog(getClass());
	
	
	public List<CtmInfoBean> dGetEmCommonList(Map map){
		List<CtmInfoBean> beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"M.emCommonList",map);
        return beanList;
	}
	
	public List<CtmInfoBean> dGetEmDbList(Map map){
		List<CtmInfoBean> beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"M.emDbList",map);
        return beanList;
	}
	
	public List<CtmInfoBean> dGetEmProcessList(Map map){
		List<CtmInfoBean> beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"M.emProcessList",map);
        return beanList;
	}
	
	public List<CtmInfoBean> dGetCcmPocessList(Map map){
		List<CtmInfoBean> beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"M.ccmPocessList",map);
        return beanList;
	}
	
	public List<CtmInfoBean> dGetEmProcessDetailList(Map map){
		List<CtmInfoBean> beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"M.emProcessDetailList",map);
        return beanList;
	}
	
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
	public List<CtmInfoBean> dGetDashBoard_appList(Map map){
		List<CtmInfoBean> beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"M.dashBoard_appList",map);
       return beanList;	   
    }
	public List<CtmInfoBean> dGetDashBoard_grpList(Map map){
		List<CtmInfoBean> beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"M.dashBoard_grpList",map);
       return beanList;
    }
	public List<CtmInfoBean> dGetDashBoard_nodeList(Map map){
		List<CtmInfoBean> beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"M.dashBoard_nodeList",map);
      return beanList;	   
    }
	public List<CtmInfoBean> dGetDashBoard_errList(Map map){
		List<CtmInfoBean> beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"M.dashBoard_errList",map);
	  return beanList;
	}
	public List<CtmInfoBean> dGetJobCondHistoryList(Map map){
		List<CtmInfoBean> beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"M.jobCondHistoryList",map);
		return beanList;
	}
}
