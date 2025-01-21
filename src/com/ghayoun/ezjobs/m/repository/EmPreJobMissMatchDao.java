package com.ghayoun.ezjobs.m.repository;

import java.util.List;
import java.util.Map;

import com.ghayoun.ezjobs.comm.domain.CommonBean;
import com.ghayoun.ezjobs.m.domain.*;

public interface EmPreJobMissMatchDao {
	
	public CommonBean dGetPreJobMissMatchListCnt(Map map);
	public List<PreJobMissMatchBean> dGetPreJobMissMatchList(Map map);
	
}