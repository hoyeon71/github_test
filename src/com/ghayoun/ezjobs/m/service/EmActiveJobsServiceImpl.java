package com.ghayoun.ezjobs.m.service;

import java.util.List;
import java.util.Map;
import com.ghayoun.ezjobs.comm.domain.CommonBean;
import com.ghayoun.ezjobs.comm.repository.CommonDao;
import com.ghayoun.ezjobs.m.repository.EmActiveJobsDao;

public class EmActiveJobsServiceImpl implements EmActiveJobsService {
	

	private CommonDao commonDao;
	private EmActiveJobsDao emActiveJobsDao;
	
	public void setCommonDao(CommonDao commonDao) {
        this.commonDao = commonDao;
    }
	
    public void setEmActiveJobsDao(EmActiveJobsDao emActiveJobsDao) {
        this.emActiveJobsDao = emActiveJobsDao;
    }
	
	public Map getActiveJobs(Map map){
		return emActiveJobsDao.getActiveJobs(map);
	}
	
	public List<String> getFromTimeOrderIdList(Map map){
		return emActiveJobsDao.getFromTimeOrderIdList(map);
	}
	
	public List<String> getTotalJobStatusList(Map map){
		return emActiveJobsDao.getTotalJobStatusList(map);
	}
	
	public CommonBean dGetApprovalLineCnt(Map map){
    	return emActiveJobsDao.dGetApprovalLineCnt(map);
    }
	
}