package com.ghayoun.ezjobs.m.service;

import java.util.List;
import java.util.Map;
import com.ghayoun.ezjobs.comm.domain.CommonBean;
import com.ghayoun.ezjobs.comm.repository.CommonDao;
import com.ghayoun.ezjobs.m.domain.BatchResultTotalBean;
import com.ghayoun.ezjobs.m.domain.TotalJobStatus;
import com.ghayoun.ezjobs.m.repository.EmBatchResultTotalDao;

public class EmBatchResultTotalServiceImpl implements EmBatchResultTotalService {
	

	private CommonDao commonDao;
	private EmBatchResultTotalDao emBatchResultTotalDao;
	
	public void setCommonDao(CommonDao commonDao) {
        this.commonDao = commonDao;
    }
	
    public void setEmBatchResultTotalDao(EmBatchResultTotalDao emBatchResultTotalDao) {
        this.emBatchResultTotalDao = emBatchResultTotalDao;
    }
    
	public List<BatchResultTotalBean> dGetBatchResultTotalList(Map map){
		return emBatchResultTotalDao.dGetBatchResultTotalList(map);
	}
	
	public List<BatchResultTotalBean> dGetNodeList(Map map){
		return emBatchResultTotalDao.dGetNodeList(map);
	}
	
    public List<BatchResultTotalBean> dGetNodeTimeList(Map map){
		return emBatchResultTotalDao.dGetNodeTimeList(map);
	}
    
    public List<BatchResultTotalBean> dGetMonthBatchResultTotalList(Map map){
		return emBatchResultTotalDao.dGetMonthBatchResultTotalList(map);
	}
    
    public CommonBean dGetDataCenterInfo(Map map){
    	return emBatchResultTotalDao.dGetDataCenterInfo(map);
    }
    
    public CommonBean dGetDataCenterInfoAjob(Map map){
    	return emBatchResultTotalDao.dGetDataCenterInfoAjob(map);
    }
    
    public List<CommonBean> dGetJobNameList(Map map){
		return commonDao.dGetJobNameList(map);
	}
    
    public List<BatchResultTotalBean> dGetBatchResultTotalList2(Map map){
		return emBatchResultTotalDao.dGetBatchResultTotalList2(map);
	}
    
    public List<BatchResultTotalBean> dGetBatchResultTotalList3(Map map){
		return emBatchResultTotalDao.dGetBatchResultTotalList3(map);
	}
    public List<BatchResultTotalBean> dGetBatchResultAppList3(Map map){
    	return emBatchResultTotalDao.dGetBatchResultAppList3(map);
    }
    public List<BatchResultTotalBean> dGetBatchResultStatusList3(Map map){
    	return emBatchResultTotalDao.dGetBatchResultStatusList3(map);
    }
    public List<BatchResultTotalBean> dGetHistoryFailJobList(Map map){
		return emBatchResultTotalDao.dGetHistoryFailJobList(map);
	}
    
    public List<CommonBean> dGetResourceNMList(Map map){
    	return emBatchResultTotalDao.dGetResourceNMList(map);
    }
    public List<CommonBean> dGetResourceHHList(Map map){
    	return emBatchResultTotalDao.dGetResourceHHList(map);
    }
    public List<CommonBean> dGetResourceTimeList(Map map){
    	return emBatchResultTotalDao.dGetResourceTimeList(map);
    }
    
    public List<BatchResultTotalBean> dGetBatchReport(Map map){
		return emBatchResultTotalDao.dGetBatchReport(map);
	}
}