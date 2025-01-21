package com.ghayoun.ezjobs.m.service;

import java.util.List;
import java.util.Map;
import com.ghayoun.ezjobs.comm.domain.CommonBean;
import com.ghayoun.ezjobs.comm.repository.CommonDao;
import com.ghayoun.ezjobs.m.domain.PreDateBatchScheduleBean;
import com.ghayoun.ezjobs.m.repository.EmPreDateBatchScheduleDao;

public class EmPreDateBatchScheduleServiceImpl implements EmPreDateBatchScheduleService {
	

	private CommonDao commonDao;
	private EmPreDateBatchScheduleDao emPreDateBatchScheduleDao;
	
	public void setCommonDao(CommonDao commonDao) {
        this.commonDao = commonDao;
    }
	
    public void setEmPreDateBatchScheduleDao(EmPreDateBatchScheduleDao emPreDateBatchScheduleDao) {
        this.emPreDateBatchScheduleDao = emPreDateBatchScheduleDao;
    }
	
    public CommonBean dGetPreDateBatchScheduleListCnt(Map map){
    	return emPreDateBatchScheduleDao.dGetPreDateBatchScheduleListCnt(map);
    }
	public List<PreDateBatchScheduleBean> dGetPreDateBatchScheduleList(Map map){
		return emPreDateBatchScheduleDao.dGetPreDateBatchScheduleList(map);
	}
	public List<PreDateBatchScheduleBean> dGetPreDateBatchScheduleOrderList(Map map){
		return emPreDateBatchScheduleDao.dGetPreDateBatchScheduleOrderList(map); 
	}
	@Override
	public List<PreDateBatchScheduleBean> dGetRelForecastTableList(Map<String, Object> paramMap) {
		return emPreDateBatchScheduleDao.dGetRelForecastTableList(paramMap);
	}
	
}