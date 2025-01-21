package com.ghayoun.ezjobs.m.service;

import java.util.List;
import java.util.Map;
import com.ghayoun.ezjobs.comm.domain.CommonBean;
import com.ghayoun.ezjobs.comm.repository.CommonDao;
import com.ghayoun.ezjobs.m.domain.CtmInfoBean;
import com.ghayoun.ezjobs.m.repository.EmCtmInfoDao;

public class EmCtmInfoServiceImpl implements EmCtmInfoService {
	

	private CommonDao commonDao;
	private EmCtmInfoDao emCtmInfoDao;
	
	public void setCommonDao(CommonDao commonDao) {
        this.commonDao = commonDao;
    }
	
    public void setEmCtmInfoDao(EmCtmInfoDao emCtmInfoDao) {
        this.emCtmInfoDao = emCtmInfoDao;
    }
	
    
    public List<CtmInfoBean> dGetEmCommonList(Map map){
		return emCtmInfoDao.dGetEmCommonList(map);
	}
    
    public List<CtmInfoBean> dGetEmDbList(Map map){
		return emCtmInfoDao.dGetEmDbList(map);
	}
    
    public List<CtmInfoBean> dGetEmProcessList(Map map){
		return emCtmInfoDao.dGetEmProcessList(map);
	}
    
    public List<CtmInfoBean> dGetEmProcessDetailList(Map map){
		return emCtmInfoDao.dGetEmProcessDetailList(map);
	}
    
    public List<CtmInfoBean> dGetCcmPocessList(Map map){
		return emCtmInfoDao.dGetCcmPocessList(map);
	}
    
    public List<CtmInfoBean> dGetAgentList(Map map){
		return emCtmInfoDao.dGetAgentList(map);
	}
    
    public CommonBean dGetJobCondListCnt(Map map){
    	return emCtmInfoDao.dGetJobCondListCnt(map);
    }
    
    public List<CtmInfoBean> dGetJobCondList(Map map){
		return emCtmInfoDao.dGetJobCondList(map);
		
	}
    
    public List<CtmInfoBean> dGetDashBoard_appList(Map map){
        return emCtmInfoDao.dGetDashBoard_appList(map);
    }
    public List<CtmInfoBean> dGetDashBoard_grpList(Map map){
        return emCtmInfoDao.dGetDashBoard_grpList(map);
    }
    public List<CtmInfoBean> dGetDashBoard_nodeList(Map map){
        return emCtmInfoDao.dGetDashBoard_nodeList(map);
    }
    public List<CtmInfoBean> dGetDashBoard_errList(Map map){
        return emCtmInfoDao.dGetDashBoard_errList(map);
    }
    
    public List<CtmInfoBean> dGetJobCondHistoryList(Map map){
        return emCtmInfoDao.dGetJobCondHistoryList(map);
    }
}