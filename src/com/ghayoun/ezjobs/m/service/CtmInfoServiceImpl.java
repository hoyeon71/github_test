package com.ghayoun.ezjobs.m.service;

import java.util.List;
import java.util.Map;
import com.ghayoun.ezjobs.comm.domain.CommonBean;
import com.ghayoun.ezjobs.comm.repository.CommonDao;
import com.ghayoun.ezjobs.m.domain.CtmInfoBean;
import com.ghayoun.ezjobs.m.repository.CtmInfoDao;

public class CtmInfoServiceImpl implements CtmInfoService {
	

	private CommonDao commonDao;
	private CtmInfoDao ctmInfoDao;
	
	public void setCommonDao(CommonDao commonDao) {
        this.commonDao = commonDao;
    }
	
    public void setCtmInfoDao(CtmInfoDao ctmInfoDao) {
        this.ctmInfoDao = ctmInfoDao;
    }
	
    
    public List<CtmInfoBean> dGetAgentList(Map map){
		return ctmInfoDao.dGetAgentList(map);
	}
    
    public CommonBean dGetJobCondListCnt(Map map){
    	return ctmInfoDao.dGetJobCondListCnt(map);
    }
    
    public List<CtmInfoBean> dGetJobCondList(Map map){
		return ctmInfoDao.dGetJobCondList(map);
		
	}
    
    public List<CommonBean> dGetCmsNodGrpList(Map map){
		return ctmInfoDao.dGetCmsNodGrpList(map);
	}
    
    public List<CommonBean> dGetCmsNodGrpNodeList(Map map){
		return ctmInfoDao.dGetCmsNodGrpNodeList(map);
	}
}