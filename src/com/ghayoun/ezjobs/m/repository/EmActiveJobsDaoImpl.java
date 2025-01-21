package com.ghayoun.ezjobs.m.repository;

import com.ghayoun.ezjobs.comm.domain.CommonBean;
import com.ghayoun.ezjobs.common.util.CommonUtil;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;
import java.util.List;
import java.util.Map;

public class EmActiveJobsDaoImpl extends SqlMapClientDaoSupport implements EmActiveJobsDao {
	
	

    /** Logger for this class and subclasses */
	protected final Log logger = LogFactory.getLog(getClass());
	
	public Map getActiveJobs(Map map){
		
		/*
		M_Manager m = new M_Manager();
		
		Map rMap = new HashMap();
		int iChk = 0;
		int num = 0;
		if( "".equals(CommonUtil.isNull(map.get("application"))) ){
			List<CommonBean> beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.applicationList",map);
			ArrayList<Response_job_act_retrieve_jobs_type> al = new ArrayList();
			
			for( int i=0; i<beanList.size(); i++){
				iChk++;
				CommonBean bean = beanList.get(i);
				map.put("application", CommonUtil.E2K(bean.getApplication()));
				
				Map tmpMap = new HashMap();
				
				tmpMap = m.actRetrieveJobs(map);
				String rCode 	= CommonUtil.isNull(tmpMap.get("rCode"));
				String rOriType = CommonUtil.isNull(tmpMap.get("rOriType"));
				String rType 	= CommonUtil.isNull(tmpMap.get("rType"));
				if( "1".equals(rCode) ){
					rMap.put("rCode", rCode);
					rMap.put("rOriType", rOriType);
					rMap.put("rType", rType);
					
					Response_act_retrieve_jobs_type t = (Response_act_retrieve_jobs_type)tmpMap.get("rObject");
					Response_job_act_retrieve_jobs_type[] t2 = t.getJobs();
					
					num += Integer.parseInt(t.getRetrieved_nodes_number());
					if( null!=t2 && t2.length>0) al.addAll(new ArrayList(Arrays.asList(t2)));
				}
			}
			if(al.size()>0){
				Response_act_retrieve_jobs_type t = new Response_act_retrieve_jobs_type();
				t.setRetrieved_nodes_number(num+"");
				t.setJobs(al.toArray(new Response_job_act_retrieve_jobs_type[al.size()]));
				rMap.put("rObject",t);
			}
		}
		if(iChk<1 || num <1) rMap = m.actRetrieveJobs(map);
		
		return rMap;
		*/
		
		return map;
    }
	
	public List<String> getFromTimeOrderIdList(Map map){
		List<String> beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"M.fromTimeOrderIdList",map);
        return beanList;
	}
	
	public List<String> getTotalJobStatusList(Map map){
		List<String> beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"M.totalJobStatusList",map);
        return beanList;
	}
	
	public CommonBean dGetApprovalLineCnt(Map map){
		CommonBean bean =  (CommonBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"M.approvalLineCnt",map);
		return bean;
	}
}
