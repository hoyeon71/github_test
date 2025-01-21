package com.ghayoun.ezjobs.t.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.ghayoun.ezjobs.comm.domain.CommonBean;
import com.ghayoun.ezjobs.comm.repository.CommonDao;
import com.ghayoun.ezjobs.common.util.CommonUtil;
import com.ghayoun.ezjobs.common.util.DefaultServiceException;
import com.ghayoun.ezjobs.t.domain.CompanyBean;
import com.ghayoun.ezjobs.t.domain.TagsBean;
import com.ghayoun.ezjobs.t.repository.WorksCompanyDao;

public class WorksCompanyServiceImpl implements WorksCompanyService {
	
	private CommonDao commonDao;
	private WorksCompanyDao worksCompanyDao;
    
	public void setCommonDao(CommonDao commonDao) {
        this.commonDao = commonDao;
    }
	
    public void setWorksCompanyDao(WorksCompanyDao worksCompanyDao) {
        this.worksCompanyDao = worksCompanyDao;
    }
	
	
    
	public List<CompanyBean> dGetDeptList(Map map){
		return worksCompanyDao.dGetDeptList(map);
	}
	public List<CompanyBean> dGetDutyList(Map map){
		return worksCompanyDao.dGetDutyList(map);
	}

	//procedure
	public Map dPrcDept(Map map) throws Exception{
		String flag = (String) map.get("flag");
		if(!"del".equals(flag)) {
			// 부서 중복 체크.
			int dept_cnt = worksCompanyDao.dGetDeptCnt(map);
			
			if ( dept_cnt > 0 ) {
				Map rMap = new HashMap();
				rMap.put("r_code","-1");
				rMap.put("r_msg","ERROR.83");
				throw new DefaultServiceException(rMap);
			}			
		}
		
		Map rMap = null;
		
		rMap = worksCompanyDao.dPrcDept(map);
		if( !"1".equals(CommonUtil.isNull(rMap.get("r_code"))) ) throw new DefaultServiceException(rMap);
		
		return rMap;
	}
	public Map dPrcDuty(Map map) throws Exception{
		
		String flag = (String) map.get("flag");
		if(!"del".equals(flag)) {
			// 직책 중복 체크.
			int duty_cnt = worksCompanyDao.dGetDutyCnt(map);
			
			if ( duty_cnt > 0 ) {
				Map rMap = new HashMap();
				rMap.put("r_code","-1");
				rMap.put("r_msg","ERROR.84");
				throw new DefaultServiceException(rMap);
			}
		}
		
		Map rMap = null;
		rMap = worksCompanyDao.dPrcDuty(map);
		if( !"1".equals(CommonUtil.isNull(rMap.get("r_code"))) ) throw new DefaultServiceException(rMap);
		
		return rMap;
	}
	
	public Map dPrcPart(Map map) throws Exception{
		Map rMap = null;
		rMap = worksCompanyDao.dPrcPart(map);
		if( !"1".equals(CommonUtil.isNull(rMap.get("r_code"))) ) throw new DefaultServiceException(rMap);
		
		return rMap;
	}
	
	public List<CommonBean> dGetMCodeList(Map map){
		return worksCompanyDao.dGetMCodeList(map);
	}
	
	public List<CommonBean> dGetSCodeList(Map map){
		return worksCompanyDao.dGetSCodeList(map);
	}
	
	//procedure
	public Map dPrcCode(Map map) throws Exception{
		Map rMap = null;
		rMap = worksCompanyDao.dPrcCode(map);
		if( !"1".equals(CommonUtil.isNull(rMap.get("r_code"))) ) throw new DefaultServiceException(rMap);
		
		return rMap;
	}
	
	public Map dPrcTags(Map map) throws Exception{
		Map rMap = null;
		rMap = worksCompanyDao.dPrcTags(map);
		if( !"1".equals(CommonUtil.isNull(rMap.get("r_code"))) ) throw new DefaultServiceException(rMap);
		
		return rMap;
	}
	
	public List<TagsBean> dGetTagsList(Map map){
		return worksCompanyDao.dGetTagsList(map);
	}
	
	public TagsBean dGetTagsSchedInfo(Map map){
    	return worksCompanyDao.dGetTagsSchedInfo(map);
    }
	
	public List<TagsBean> dGetDefTagsList(Map map){
		return worksCompanyDao.dGetDefTagsList(map);
	}
	
	public TagsBean dGetDefTagsSchedInfo(Map map){
    	return worksCompanyDao.dGetDefTagsSchedInfo(map);
    }
	
	public CommonBean dGetTableInfo(Map map){
    	return worksCompanyDao.dGetTableInfo(map);
    }
	
	public List<TagsBean> dGetDefTagsList2(Map map){
		return worksCompanyDao.dGetDefTagsList2(map);
	}
	
	public TagsBean dGetTagsInfo(Map map){
    	return worksCompanyDao.dGetTagsInfo(map);
    }
}