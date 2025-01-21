package com.ghayoun.ezjobs.m.service;

import java.util.List;
import java.util.Map;

import com.ghayoun.ezjobs.comm.domain.CommonBean;
import com.ghayoun.ezjobs.comm.repository.CommonDao;
import com.ghayoun.ezjobs.m.domain.ActiveJobBean;
import com.ghayoun.ezjobs.m.domain.JobDetailBean;
import com.ghayoun.ezjobs.m.domain.JobLogBean;
import com.ghayoun.ezjobs.m.domain.JobMemoBean;
import com.ghayoun.ezjobs.m.repository.PopupJobDetailCtmDao;
import com.ghayoun.ezjobs.m.repository.PopupJobDetailDao;
import com.ghayoun.ezjobs.t.domain.JobBasicInfo;

public class PopupJobDetailServiceImpl implements PopupJobDetailService {
	

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
	
	public JobDetailBean dGetJobDetail(Map map){
		return popupJobDetailDao.dGetJobDetail(map);
	}
	
	public CommonBean dGetJobMemoListCnt(Map map){
    	return popupJobDetailDao.dGetJobMemoListCnt(map);
    }
	public List<JobMemoBean> dGetJobMemoList(Map map){
		return popupJobDetailDao.dGetJobMemoList(map);
	}
	
	//procedure
	public Map dPrcJobMemo(Map map){
		return popupJobDetailDao.dPrcJobMemo(map);
	}
	
	public List<JobLogBean> dGetJobLogListContent(Map map){
		return popupJobDetailCtmDao.dGetJobLogListContent(map);
	}
	
	public List<ActiveJobBean> dGetJobAvgInfoList(Map map){
		return popupJobDetailDao.dGetJobAvgInfoList(map);
	}

	@Override
	public List<JobBasicInfo> dGetJobapprovalInfo(Map<String, Object> paramMap) {
		return popupJobDetailDao.dGetJobapprovalInfo(paramMap);
	}
	
	public JobBasicInfo dGetJobBasicInfo(Map<String, Object> paramMap) {
		return popupJobDetailDao.dGetJobBasicInfo(paramMap);
	}


	@Override
	public void modifyJobBasicInfo(Map<String, Object> paramMap) {
//		popupJobDetailDao.updateJobMapper(paramMap);
//		popupJobDetailDao.updateDoc01(paramMap);
//		popupJobDetailDao.updateDocMaster(paramMap);
	}
	
	
	public List<JobLogBean> dGetOutCondList(Map map){
		return popupJobDetailDao.dGetOutCondList(map);
	}

}