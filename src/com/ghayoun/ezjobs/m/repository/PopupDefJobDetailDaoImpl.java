package com.ghayoun.ezjobs.m.repository;

import com.ghayoun.ezjobs.common.util.CommonUtil;
import com.ghayoun.ezjobs.m.domain.DefJobBean;
import com.ghayoun.ezjobs.m.domain.JobDefineInfoBean;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import java.util.List;
import java.util.Map;

public class PopupDefJobDetailDaoImpl extends SqlMapClientDaoSupport implements PopupDefJobDetailDao {
	
	

    /** Logger for this class and subclasses */
	protected final Log logger = LogFactory.getLog(getClass());
	
	public List<DefJobBean> dGetDefJobDetail(Map map){
		List<DefJobBean> beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"M.defJobDetail",map);
        return beanList;
	}
	
	

	public JobDefineInfoBean dGetJobDefineInfo(Map map){
		JobDefineInfoBean bean = (JobDefineInfoBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"M.jobDefineInfoBasic",map);
		if (bean !=null )
		{
//			String t_general_date = CommonUtil.isNull(bean.getT_general_date());
	
//			if(!"".equals(t_general_date)){
//	
//				for(int i=0;i<=t_general_date.length();i=(i+4)){
//					if(i==0){
//						if((i+4)<=t_general_date.length()) bean.setT_general_date(t_general_date.substring(i,(i+4)));
//					}else{
//						if((i+4)<=t_general_date.length()) bean.setT_general_date(bean.getT_general_date()+"|"+t_general_date.substring(i,(i+4)));
//					}
//				}
//			}
		
			List<JobDefineInfoBean> beans =  null;
			
			beans = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"M.jobDefineInfoConditionsIn",map);
	
			for(int i=0; null!=beans && i<beans.size(); i++){
		
				if(i==0){
					bean.setT_conditions_in(beans.get(i).getT_conditions_in());
				}else{
					bean.setT_conditions_in(bean.getT_conditions_in()+"|"+beans.get(i).getT_conditions_in());
				}
			}
	
			beans = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"M.jobDefineInfoConditionsOut",map);
	
			for(int i=0; null!=beans && i<beans.size(); i++){
				if(i==0){
					bean.setT_conditions_out(beans.get(i).getT_conditions_out());
				}else{
					bean.setT_conditions_out(bean.getT_conditions_out()+"|"+beans.get(i).getT_conditions_out());
				}
			}
	
			beans = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"M.jobDefineInfoResourcesQ",map);
		
			for(int i=0; null!=beans && i<beans.size(); i++){
				if(i==0){
					bean.setT_resources_q(beans.get(i).getT_resources_q());
				}else{
					bean.setT_resources_q(bean.getT_resources_q()+"|"+beans.get(i).getT_resources_q());
				}
			}
			
			beans = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"M.jobDefineInfoResourcesC",map);
			for(int i=0; null!=beans && i<beans.size(); i++){
				if(i==0){
					bean.setT_resources_c(beans.get(i).getT_resources_c());
				}else{
					bean.setT_resources_c(bean.getT_resources_c()+"|"+beans.get(i).getT_resources_c());
				}
			}
			
			beans = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"M.jobDefineInfoSetVar",map);
			for(int i=0; null!=beans && i<beans.size(); i++){
				if(i==0){
					bean.setT_set(beans.get(i).getT_set());
				}else{
					bean.setT_set(bean.getT_set()+"|"+beans.get(i).getT_set());
				}
			}
	
			beans = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"M.jobDefineInfoStep",map);
			for(int i=0; null!=beans && i<beans.size(); i++){
				if(i==0){
					bean.setT_steps(beans.get(i).getT_steps());
				}else{
					bean.setT_steps(bean.getT_steps()+"|"+beans.get(i).getT_steps());
				}
			}
			
			beans = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"M.jobDefineInfoShout",map);
			for(int i=0; null!=beans && i<beans.size(); i++){
				if(i==0){
					bean.setT_postproc(beans.get(i).getT_postproc());
				}else{
					bean.setT_postproc(bean.getT_postproc()+"|"+beans.get(i).getT_postproc());
				}
			}
			
			String strTaskType = CommonUtil.isNull(bean.getTask_type());		
			map.put("task_type", strTaskType);
			
			beans = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"M.jobDefineInfoTags",map);
			for(int i=0; null!=beans && i<beans.size(); i++){
				if(i==0){
					bean.setT_tag_name(beans.get(i).getT_tag_name());
				}else{
					bean.setT_tag_name(bean.getT_tag_name()+"|"+beans.get(i).getT_tag_name());
				}
			}
		}
		return bean;
	}
	
	public JobDefineInfoBean dGetJobDefineInfo_new(Map map){
		
		JobDefineInfoBean bean = (JobDefineInfoBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"M.jobDefineInfoBasic_new",map);
		
		/* 작업명이 존재하지 않는 경우 대비 */
		try{
//			String t_general_date = CommonUtil.isNull(bean.getT_general_date(), "");
//	
//			if(!"".equals(t_general_date)){
//	
//				for(int i=0;i<=t_general_date.length();i=(i+4)){
//					if(i==0){
//						if((i+4)<=t_general_date.length()) bean.setT_general_date(t_general_date.substring(i,(i+4)));
//					}else{
//						if((i+4)<=t_general_date.length()) bean.setT_general_date(bean.getT_general_date()+"|"+t_general_date.substring(i,(i+4)));
//					}
//				}
//			}
	
			List<JobDefineInfoBean> beans =  null;
			
			beans = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"M.jobDefineInfoConditionsIn_new",map);
	
			for(int i=0; null!=beans && i<beans.size(); i++){
		
				if(i==0){
					bean.setT_conditions_in(beans.get(i).getT_conditions_in());
				}else{
					bean.setT_conditions_in(bean.getT_conditions_in()+"|"+beans.get(i).getT_conditions_in());
				}
			}
	
			beans = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"M.jobDefineInfoConditionsOut_new",map);
	
			for(int i=0; null!=beans && i<beans.size(); i++){
				if(i==0){
					bean.setT_conditions_out(beans.get(i).getT_conditions_out());
				}else{
					bean.setT_conditions_out(bean.getT_conditions_out()+"|"+beans.get(i).getT_conditions_out());
				}
			}
	
			beans = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"M.jobDefineInfoResourcesQ_new",map);
		
			for(int i=0; null!=beans && i<beans.size(); i++){
				if(i==0){
					bean.setT_resources_q(beans.get(i).getT_resources_q());
				}else{
					bean.setT_resources_q(bean.getT_resources_q()+"|"+beans.get(i).getT_resources_q());
				}
			}
			
			beans = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"M.jobDefineInfoResourcesC_new",map);
			for(int i=0; null!=beans && i<beans.size(); i++){
				if(i==0){
					bean.setT_resources_c(beans.get(i).getT_resources_c());
				}else{
					bean.setT_resources_c(bean.getT_resources_c()+"|"+beans.get(i).getT_resources_c());
				}
			}
			
			beans = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"M.jobDefineInfoSetVar_new",map);
			for(int i=0; null!=beans && i<beans.size(); i++){
				if(i==0){
					bean.setT_set(beans.get(i).getT_set());
				}else{
					bean.setT_set(bean.getT_set()+"|"+beans.get(i).getT_set());
				}
			}
	
			beans = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"M.jobDefineInfoStep_new",map);
			for(int i=0; null!=beans && i<beans.size(); i++){
				if(i==0){
					bean.setT_steps(beans.get(i).getT_steps());
				}else{
					bean.setT_steps(bean.getT_steps()+"|"+beans.get(i).getT_steps());
				}
			}
			
			beans = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"M.jobDefineInfoShout_new",map);
			for(int i=0; null!=beans && i<beans.size(); i++){
				if(i==0){
					bean.setT_postproc(beans.get(i).getT_postproc());
				}else{
					bean.setT_postproc(bean.getT_postproc()+"|"+beans.get(i).getT_postproc());
				}
			}
		}
		catch (NullPointerException e)
		{
			e.printStackTrace();
		}
		
		return bean;
	}
	
	public List<DefJobBean> dGetDefInCondJobList(Map map){
		List<DefJobBean> beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"M.defInCondJobList",map);
        return beanList;
	}
	public List<DefJobBean> dGetDefOutCondJobList(Map map){
		List<DefJobBean> beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"M.defOutCondJobList",map);
        return beanList;
	}
}
