package com.ghayoun.ezjobs.m.repository;

import com.ghayoun.ezjobs.comm.domain.CommonBean;
import com.ghayoun.ezjobs.common.util.CommonUtil;
import com.ghayoun.ezjobs.m.domain.PreJobMissMatchBean;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import java.util.List;
import java.util.Map;

public class EmPreJobMissMatchDaoImpl extends SqlMapClientDaoSupport implements EmPreJobMissMatchDao {
	
	

    /** Logger for this class and subclasses */
	protected final Log logger = LogFactory.getLog(getClass());
	
	public CommonBean dGetPreJobMissMatchListCnt(Map map){
		CommonBean bean =  (CommonBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"M.preJobMissMatchListCnt",map);
		return bean;
	}
	public List<PreJobMissMatchBean> dGetPreJobMissMatchList(Map map){
		List<PreJobMissMatchBean> beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"M.preJobMissMatchList",map);
        return beanList;
	}
	
}
