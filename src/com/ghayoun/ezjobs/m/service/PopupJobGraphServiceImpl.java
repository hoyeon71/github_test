package com.ghayoun.ezjobs.m.service;

import java.util.List;
import java.util.Map;

import com.ghayoun.ezjobs.comm.repository.CommonDao;
import com.ghayoun.ezjobs.common.util.CommonUtil;
import com.ghayoun.ezjobs.m.domain.JobGraphBean;
import com.ghayoun.ezjobs.m.repository.PopupJobGraphDao;

public class PopupJobGraphServiceImpl implements PopupJobGraphService {
	

	private CommonDao commonDao;
	private PopupJobGraphDao popupJobGraphDao;
	
	public void setCommonDao(CommonDao commonDao) {
        this.commonDao = commonDao;
    }
	
    public void setPopupJobGraphDao(PopupJobGraphDao popupJobGraphDao) {
        this.popupJobGraphDao = popupJobGraphDao;
    }
	
	public List<JobGraphBean> dGetJobGraphList(Map map){

		String active_gb = CommonUtil.isNull(map.get("active_gb"));

		// 실시간 수행과 과거 수행의 선후행 그래프는 쿼리가 다르다. (2023.10.05 강명준)
		if ( active_gb.equals("0") ) {
			return popupJobGraphDao.dGetJobGraphHistoryList(map);
		} else {
		return popupJobGraphDao.dGetJobGraphList(map);
		}
	}

	public List<JobGraphBean> dGetJobGraphList_ez012(Map map){
		return popupJobGraphDao.dGetJobGraphList_ez012(map);
	}
	
}