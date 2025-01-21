package com.ghayoun.ezjobs.m.service;

import java.util.List;
import java.util.Map;

import com.ghayoun.ezjobs.comm.repository.CommonDao;
import com.ghayoun.ezjobs.m.domain.TimeInfoBean;
import com.ghayoun.ezjobs.m.repository.PopupTimeInfoDao;

public class PopupTimeInfoServiceImpl implements PopupTimeInfoService {
	

	private CommonDao commonDao;
	private PopupTimeInfoDao popupTimeInfoDao;
	
	public void setCommonDao(CommonDao commonDao) {
        this.commonDao = commonDao;
    }
	
    public void setPopupTimeInfoDao(PopupTimeInfoDao popupTimeInfoDao) {
        this.popupTimeInfoDao = popupTimeInfoDao;
    }
    
    public List<TimeInfoBean> dGetAtiveStartTimeList(Map map){
		return popupTimeInfoDao.dGetAtiveStartTimeList(map);
	}
	public List<TimeInfoBean> dGetTimeInfoList(Map map){
		return popupTimeInfoDao.dGetTimeInfoList(map);
	}
	public List<TimeInfoBean> dGetEndTimeInfoList(Map map){
		return popupTimeInfoDao.dGetEndTimeInfoList(map);
	}

}