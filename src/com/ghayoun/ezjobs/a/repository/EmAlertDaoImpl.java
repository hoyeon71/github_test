package com.ghayoun.ezjobs.a.repository;

import com.ghayoun.ezjobs.a.domain.AlertBean;
import com.ghayoun.ezjobs.comm.domain.CommonBean;
import com.ghayoun.ezjobs.common.util.CommonUtil;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import java.util.List;
import java.util.Map;

public class EmAlertDaoImpl extends SqlMapClientDaoSupport implements EmAlertDao {
	
	

    /** Logger for this class and subclasses */
	protected final Log logger = LogFactory.getLog(getClass());
	
	public CommonBean dGetAlertListCnt(Map map){
		CommonBean bean =  (CommonBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"A.alertListCnt",map);
		return bean;
	}
	public List<AlertBean> dGetAlertList(Map map){
		List<AlertBean> beanList = null;
    	beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"A.alertList",map);
        return beanList;
    }
	
	public AlertBean dGetAlert(Map map){
		AlertBean bean = null;
		bean = (AlertBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"A.alert",map);
        return bean;
    }
	
	public Map prcChangeAlertStatus(Map map){
		//A_Manager a = new A_Manager();
		//map = a.changeAlertStatus(map);
        return map;
    }
	
	public CommonBean dGetAlertLastSerial(Map map){
		CommonBean bean =  (CommonBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"A.alertLastSerial",map);
		return bean;
	}
	
	public CommonBean dGetAlertErrorListCnt(Map map){
		CommonBean bean =  (CommonBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"A.alertErrorListCnt",map);
		return bean;
	}
	public List<AlertBean> dGetAlertErrorList(Map map){
		List<AlertBean> beanList = null;
    	beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"A.alertErrorList",map);
        return beanList;
    }
	
	public Map dPrcAlarm(Map map){
		getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"A.spAlarmPrc",map);
		return map;
	}
	
	public CommonBean dGetJobErrorLogListCnt(Map map){
		CommonBean bean =  (CommonBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"A.jobErrorLogListCnt",map);
		return bean;
	}
	public List<AlertBean> dGetJobErrorLogList(Map map){
		List<AlertBean> beanList = null;
    	beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"A.jobErrorLogList",map);
        return beanList;
    }
}
