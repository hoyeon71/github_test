package com.ghayoun.ezjobs.m.repository;

import com.ghayoun.ezjobs.comm.domain.CommonBean;
import com.ghayoun.ezjobs.common.util.CommonUtil;
import com.ghayoun.ezjobs.m.domain.DefJobBean;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;
import java.util.List;
import java.util.Map;

public class EmDefJobsDaoImpl extends SqlMapClientDaoSupport implements EmDefJobsDao {
	
	
    /** Logger for this class and subclasses */
	protected final Log logger = LogFactory.getLog(getClass());
	
	public DefJobBean dGetDefJobListCnt(Map map){
		DefJobBean bean =  (DefJobBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"M.defJobListCnt",map);
		return bean;
	}
	public List<DefJobBean> dGetDefJobList(Map map){
		List<DefJobBean> beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"M.defJobList",map);
        return beanList;
	}
	
	public List<DefJobBean> dGetDefJobExcelList(Map map){
		List<DefJobBean> beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"M.defJobExcelList",map);
        return beanList;
	}
	
	public List<DefJobBean> dGetInCondJobList(Map map){
		List<DefJobBean> beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"M.inCondJobList",map);
        return beanList;
	}
	
	public DefJobBean dGetJobDefInfo(Map map){
		DefJobBean bean =  (DefJobBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"M.jobDefInfo",map);
		return bean;
	}
	
	public List<DefJobBean> dGetJobGroupDefJobList(Map map){
		List<DefJobBean> beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"M.jobGroupDefJobList",map);
        return beanList;
	}
	
	public DefJobBean dGetJobGroupDefJobListCnt(Map map){
		DefJobBean bean =  (DefJobBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"M.jobGroupDefJobListCnt",map);
		return bean;
	}
	
	public DefJobBean dGetActiveJobListCnt(Map map){
		DefJobBean bean =  (DefJobBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"M.activeJobListCnt",map);
		return bean;
	}

}
