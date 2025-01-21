package com.ghayoun.ezjobs.m.service;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

import com.ghayoun.ezjobs.comm.domain.*;
import com.ghayoun.ezjobs.m.domain.PreJobMissMatchBean;


public interface EmPreJobMissMatchService extends Serializable{

	public CommonBean dGetPreJobMissMatchListCnt(Map map);
	public List<PreJobMissMatchBean> dGetPreJobMissMatchList(Map map);
	
}
