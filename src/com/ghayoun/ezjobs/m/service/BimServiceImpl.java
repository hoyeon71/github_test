package com.ghayoun.ezjobs.m.service;

import java.util.Map;
import com.ghayoun.ezjobs.comm.repository.CommonDao;
import com.ghayoun.ezjobs.m.repository.BimDao;

public class BimServiceImpl implements BimService {
	

	private CommonDao commonDao;
	private BimDao bimDao;
	
	public void setCommonDao(CommonDao commonDao) {
        this.commonDao = commonDao;
    }
	
    public void setBimDao(BimDao bimDao) {
        this.bimDao = bimDao;
    }
	
	public Map getServiceList(Map map){
		return bimDao.getServiceList(map);
	}
	
}