package com.ghayoun.ezjobs.m.service;

import java.util.List;
import java.util.Map;

import com.ghayoun.ezjobs.comm.domain.CommonBean;
import com.ghayoun.ezjobs.comm.repository.CommonDao;
import com.ghayoun.ezjobs.m.domain.PreJobMissMatchBean;
import com.ghayoun.ezjobs.m.repository.EmPreJobMissMatchDao;

public class EmPreJobMissMatchServiceImpl implements EmPreJobMissMatchService {
	

	private CommonDao commonDao;
	private EmPreJobMissMatchDao emPreJobMissMatchDao;
	
	public void setCommonDao(CommonDao commonDao) {
        this.commonDao = commonDao;
    }
	
    public void setEmPreJobMissMatchDao(EmPreJobMissMatchDao emPreJobMissMatchDao) {
        this.emPreJobMissMatchDao = emPreJobMissMatchDao;
    }
	
    public CommonBean dGetPreJobMissMatchListCnt(Map map){
    	return emPreJobMissMatchDao.dGetPreJobMissMatchListCnt(map);
    }
	public List<PreJobMissMatchBean> dGetPreJobMissMatchList(Map map){
		return emPreJobMissMatchDao.dGetPreJobMissMatchList(map);
	}
	
}