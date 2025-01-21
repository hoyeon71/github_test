package com.ghayoun.ezjobs.m.service;

import java.util.List;
import java.util.Map;

import com.ghayoun.ezjobs.comm.repository.CommonDao;
import com.ghayoun.ezjobs.m.domain.JobLogBean;
import com.ghayoun.ezjobs.m.repository.PopupJobDetailCtmDao;
import com.ghayoun.ezjobs.m.repository.PopupJobDetailDao;

public class PopupJobDetailCtmServiceImpl implements PopupJobDetailCtmService {
	

	private CommonDao commonDao;
	private PopupJobDetailDao popupJobDetailDao;
	private PopupJobDetailCtmDao popupJobDetailCtmDao;
	
	public void setCommonDao(CommonDao commonDao) {
        this.commonDao = commonDao;
    }
	
    public void setPopupJobDetailDao(PopupJobDetailDao popupJobDetailDao) {
        this.popupJobDetailDao = popupJobDetailDao;
    }
    
    public void setPopupJobDetailCtmDao(PopupJobDetailCtmDao popupJobDetailCtmDao) {
        this.popupJobDetailCtmDao = popupJobDetailCtmDao;
    }
	
	public List<JobLogBean> dGetJobLogListContent(Map map){
		return popupJobDetailCtmDao.dGetJobLogListContent(map);
	}
	
}