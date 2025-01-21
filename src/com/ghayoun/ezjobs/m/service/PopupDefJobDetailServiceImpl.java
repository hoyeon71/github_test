package com.ghayoun.ezjobs.m.service;

import java.util.List;
import java.util.Map;

import com.ghayoun.ezjobs.comm.repository.CommonDao;
import com.ghayoun.ezjobs.m.domain.DefJobBean;
import com.ghayoun.ezjobs.m.domain.JobDefineInfoBean;
import com.ghayoun.ezjobs.m.repository.PopupDefJobDetailDao;

public class PopupDefJobDetailServiceImpl implements PopupDefJobDetailService {
	

	private CommonDao commonDao;
	private PopupDefJobDetailDao popupDefJobDetailDao;
	
	public void setCommonDao(CommonDao commonDao) {
        this.commonDao = commonDao;
    }
	
    public void setPopupDefJobDetailDao(PopupDefJobDetailDao popupDefJobDetailDao) {
        this.popupDefJobDetailDao = popupDefJobDetailDao;
    }
	
	public List<DefJobBean> dGetDefJobDetail(Map map){
		return popupDefJobDetailDao.dGetDefJobDetail(map);
	}
	
	
	public JobDefineInfoBean dGetJobDefineInfo(Map map){
		return popupDefJobDetailDao.dGetJobDefineInfo(map);
	}
	
	public JobDefineInfoBean dGetJobDefineInfo_new(Map map){
		return popupDefJobDetailDao.dGetJobDefineInfo_new(map);
	}
	
	public List<DefJobBean> dGetDefInCondJobList(Map map){
		return popupDefJobDetailDao.dGetDefInCondJobList(map);
	}
	public List<DefJobBean> dGetDefOutCondJobList(Map map){
		return popupDefJobDetailDao.dGetDefOutCondJobList(map);
	}
}