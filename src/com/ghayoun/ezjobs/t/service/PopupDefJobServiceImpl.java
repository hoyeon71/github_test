package com.ghayoun.ezjobs.t.service;

import java.util.List;
import java.util.Map;

import com.ghayoun.ezjobs.comm.domain.CommonBean;
import com.ghayoun.ezjobs.comm.repository.CommonDao;
import com.ghayoun.ezjobs.m.domain.JobDefineInfoBean;
import com.ghayoun.ezjobs.m.repository.CtmInfoDao;
import com.ghayoun.ezjobs.t.domain.DefJobBean;
import com.ghayoun.ezjobs.t.repository.PopupDefJobDao;

public class PopupDefJobServiceImpl implements PopupDefJobService {
	

	private CommonDao commonDao;
	private PopupDefJobDao popupDefJobsDao;
	private CtmInfoDao ctmInfoDao;
	    
    public void setCtmInfoDao(CtmInfoDao ctmInfoDao) {   
    	this.ctmInfoDao = ctmInfoDao;   
    }
	
	public void setCommonDao(CommonDao commonDao) {
        this.commonDao = commonDao;
    }
	
    public void setPopupDefJobDao(PopupDefJobDao popupDefJobsDao) {
        this.popupDefJobsDao = popupDefJobsDao;
    }
	
    public CommonBean dGetDefJobListCnt(Map map){
    	return popupDefJobsDao.dGetDefJobListCnt(map);
    }
	public List<DefJobBean> dGetDefJobList(Map map){
		return popupDefJobsDao.dGetDefJobList(map);
	}
	
	public CommonBean dGetJobGroupDefJobListCnt(Map map){
    	return popupDefJobsDao.dGetJobGroupDefJobListCnt(map);
    }
	public List<DefJobBean> dGetJobGroupDefJobList(Map map){
		return popupDefJobsDao.dGetJobGroupDefJobList(map);
	}
	
	public JobDefineInfoBean dGetAjobInfo(Map map){
		return popupDefJobsDao.dGetAjobInfo(map);
	}
	public JobDefineInfoBean dGetAjobHistoryInfo(Map map){
		return popupDefJobsDao.dGetAjobHistoryInfo(map);
	}
	
	public List<JobDefineInfoBean> dGetPreDateAjobInfo(Map map){
		return popupDefJobsDao.dGetPreDateAjobInfo(map);
	}
	
	public List<DefJobBean> dGetHostList(Map map){
		return ctmInfoDao.dGetHostList(map);
	}
}