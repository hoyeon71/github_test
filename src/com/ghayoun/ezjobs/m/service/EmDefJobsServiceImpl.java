package com.ghayoun.ezjobs.m.service;

import java.util.List;
import java.util.Map;
import com.ghayoun.ezjobs.comm.domain.CommonBean;
import com.ghayoun.ezjobs.comm.repository.CommonDao;
import com.ghayoun.ezjobs.m.domain.DefJobBean;
import com.ghayoun.ezjobs.m.repository.EmDefJobsDao;

public class EmDefJobsServiceImpl implements EmDefJobsService {
	

	private CommonDao commonDao;
	private EmDefJobsDao emDefJobsDao;
	
	public void setCommonDao(CommonDao commonDao) {
        this.commonDao = commonDao;
    }
	
    public void setEmDefJobsDao(EmDefJobsDao emDefJobsDao) {
        this.emDefJobsDao = emDefJobsDao;
    }
	
    public DefJobBean dGetDefJobListCnt(Map map){
    	return emDefJobsDao.dGetDefJobListCnt(map);
    }
	public List<DefJobBean> dGetDefJobList(Map map){
		return emDefJobsDao.dGetDefJobList(map);
	}
	
	public List<DefJobBean> dGetDefJobExcelList(Map map){
		return emDefJobsDao.dGetDefJobExcelList(map);
	}
	
	public List<DefJobBean> dGetInCondJobList(Map map){
		return emDefJobsDao.dGetInCondJobList(map);
	}
	
	public DefJobBean dGetJobDefInfo(Map map){
		return emDefJobsDao.dGetJobDefInfo(map);
    }
	
	public List<DefJobBean> dGetJobGroupDefJobList(Map map){
		return emDefJobsDao.dGetJobGroupDefJobList(map);
	}
	
	public DefJobBean dGetJobGroupDefJobListCnt(Map map){
    	return emDefJobsDao.dGetJobGroupDefJobListCnt(map);
    }
	
	public DefJobBean dGetActiveJobListCnt(Map map){
    	return emDefJobsDao.dGetActiveJobListCnt(map);
    }
}