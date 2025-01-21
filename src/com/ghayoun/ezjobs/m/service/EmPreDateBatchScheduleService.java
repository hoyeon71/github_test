package com.ghayoun.ezjobs.m.service;

import java.io.Serializable;
import java.util.List;
import java.util.Map;
import com.ghayoun.ezjobs.comm.domain.CommonBean;
import com.ghayoun.ezjobs.m.domain.PreDateBatchScheduleBean;

public interface EmPreDateBatchScheduleService extends Serializable{

	public CommonBean dGetPreDateBatchScheduleListCnt(Map map);
	public List<PreDateBatchScheduleBean> dGetPreDateBatchScheduleList(Map map);
	public List<PreDateBatchScheduleBean> dGetPreDateBatchScheduleOrderList(Map map);
	public List<PreDateBatchScheduleBean> dGetRelForecastTableList(Map<String, Object> paramMap);
}
