package com.ghayoun.ezjobs.m.repository;

import com.ghayoun.ezjobs.common.util.CommonUtil;
import com.ghayoun.ezjobs.m.domain.JobLogBean;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import java.util.List;
import java.util.Map;

public class PopupJobDetailCtmDaoImpl extends SqlMapClientDaoSupport implements PopupJobDetailCtmDao {
	
	

    /** Logger for this class and subclasses */
	protected final Log logger = LogFactory.getLog(getClass());
	
	public List<JobLogBean> dGetJobLogListContent(Map map){
		List<JobLogBean> beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"M.jobLogContentList",map);
        return beanList;
	}
}
