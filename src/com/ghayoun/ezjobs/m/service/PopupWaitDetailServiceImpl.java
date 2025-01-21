package com.ghayoun.ezjobs.m.service;

import java.util.List;
import java.util.Map;

import com.ghayoun.ezjobs.comm.repository.CommonDao;
import com.ghayoun.ezjobs.m.domain.WaitDetailBean;
import com.ghayoun.ezjobs.m.repository.PopupWaitDetailDao;

public class PopupWaitDetailServiceImpl implements PopupWaitDetailService {
	

	private CommonDao commonDao;
	private PopupWaitDetailDao popupWaitDetailDao;
	
	public void setCommonDao(CommonDao commonDao) {
        this.commonDao = commonDao;
    }
	
    public void setPopupWaitDetailDao(PopupWaitDetailDao popupWaitDetailDao) {
        this.popupWaitDetailDao = popupWaitDetailDao;
    }
	
    
    
	public List<WaitDetailBean> dGetWaitConditionDetail(Map map){
		return popupWaitDetailDao.dGetWaitConditionDetail(map);
	}

	public List<WaitDetailBean> dGetWaitTimeDetail(Map map){
		return popupWaitDetailDao.dGetWaitTimeDetail(map);
	}
	
}