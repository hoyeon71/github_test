package com.ghayoun.ezjobs.t.repository;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.HashMap;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import com.ghayoun.ezjobs.comm.domain.*;
import com.ghayoun.ezjobs.common.util.CommonUtil;
import com.ghayoun.ezjobs.common.axis.*;
import com.ghayoun.ezjobs.m.domain.JobDefineInfoBean;
import com.ghayoun.ezjobs.t.domain.DefJobBean;

public class PopupDefJobDaoImpl extends SqlMapClientDaoSupport implements PopupDefJobDao {

    /** Logger for this class and subclasses */
	protected final Log logger = LogFactory.getLog(getClass());
	
	public CommonBean dGetDefJobListCnt(Map map){
		CommonBean bean =  (CommonBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.defJobListCnt",map);
		return bean;
	}
	public List<DefJobBean> dGetDefJobList(Map map){
		List<DefJobBean> beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.defJobList",map);
        return beanList;
	}
	
	public CommonBean dGetJobGroupDefJobListCnt(Map map){
		CommonBean bean =  (CommonBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.jobGroupDefJobListCnt",map);
		return bean;
	}
	public List<DefJobBean> dGetJobGroupDefJobList(Map map){
		List<DefJobBean> beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.jobGroupDefJobList",map);
        return beanList;
	}
	
	public JobDefineInfoBean dGetAjobInfo(Map map){
		
		JobDefineInfoBean bean = (JobDefineInfoBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"M.aJobInfoBasic",map);
				
		String t_general_date = "";
		
		if ( bean != null ) {
			
			t_general_date = CommonUtil.isNull(bean.getT_general_date(), "");
		

			if(!"".equals(t_general_date)){
	
				for(int i=0;i<=t_general_date.length();i=(i+4)){
					if(i==0){
						if((i+4)<=t_general_date.length()) bean.setT_general_date(t_general_date.substring(i,(i+4)));
					}else{
						if((i+4)<=t_general_date.length()) bean.setT_general_date(bean.getT_general_date()+"|"+t_general_date.substring(i,(i+4)));
					}
				}
			}
	
			List<JobDefineInfoBean> beans =  null;
		
			beans = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"M.aJobInfoSetVar",map);
			
			for(int i=0; null!=beans && i<beans.size(); i++){
				if(i==0){
					bean.setT_set(beans.get(i).getT_set());
				}else{
					bean.setT_set(bean.getT_set()+"|"+beans.get(i).getT_set());
				}
			}
			
			beans = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"M.aJobInfoConditionsIn",map);
	
			for(int i=0; null!=beans && i<beans.size(); i++){
		
				if(i==0){
					bean.setT_conditions_in(beans.get(i).getT_conditions_in());
				}else{
					bean.setT_conditions_in(bean.getT_conditions_in()+"|"+beans.get(i).getT_conditions_in());
				}
			}
	
			beans = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"M.aJobInfoConditionsOut",map);
	
			for(int i=0; null!=beans && i<beans.size(); i++){
				if(i==0){
					bean.setT_conditions_out(beans.get(i).getT_conditions_out());
				}else{
					bean.setT_conditions_out(bean.getT_conditions_out()+"|"+beans.get(i).getT_conditions_out());
				}
			}
		}
		
		return bean;
	}
	
	public JobDefineInfoBean dGetAjobHistoryInfo(Map map){
		
		JobDefineInfoBean bean = (JobDefineInfoBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"M.aJobInfoHistoryBasic",map);
		
		String t_general_date = "";
		
		if ( bean != null ) {
			
			t_general_date = CommonUtil.isNull(bean.getT_general_date(), "");
		

			if(!"".equals(t_general_date)){
	
				for(int i=0;i<=t_general_date.length();i=(i+4)){
					if(i==0){
						if((i+4)<=t_general_date.length()) bean.setT_general_date(t_general_date.substring(i,(i+4)));
					}else{
						if((i+4)<=t_general_date.length()) bean.setT_general_date(bean.getT_general_date()+"|"+t_general_date.substring(i,(i+4)));
					}
				}
			}
	
			List<JobDefineInfoBean> beans =  null;
		
			beans = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"M.aJobInfoHistorySetVar",map);
			
			for(int i=0; null!=beans && i<beans.size(); i++){
				if(i==0){
					bean.setT_set(beans.get(i).getT_set());
				}else{
					bean.setT_set(bean.getT_set()+"|"+beans.get(i).getT_set());
				}
			}
			
			beans = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"M.aJobInfoHistoryConditionsIn",map);
	
			for(int i=0; null!=beans && i<beans.size(); i++){
		
				if(i==0){
					bean.setT_conditions_in(beans.get(i).getT_conditions_in());
				}else{
					bean.setT_conditions_in(bean.getT_conditions_in()+"|"+beans.get(i).getT_conditions_in());
				}
			}
	
			beans = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"M.aJobInfoHistoryConditionsOut",map);
	
			for(int i=0; null!=beans && i<beans.size(); i++){
				if(i==0){
					bean.setT_conditions_out(beans.get(i).getT_conditions_out());
				}else{
					bean.setT_conditions_out(bean.getT_conditions_out()+"|"+beans.get(i).getT_conditions_out());
				}
			}
		}
		
		return bean;
	}
	
	public List<JobDefineInfoBean> dGetPreDateAjobInfo(Map map){
		
		List<JobDefineInfoBean> beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"M.preDateAJobInfo",map);
		
		return beanList;
	}

}
