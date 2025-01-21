package com.ghayoun.ezjobs.a.service;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

import com.ghayoun.ezjobs.a.domain.AlertBean;
import com.ghayoun.ezjobs.comm.domain.*;


public interface EmAlertService extends Serializable{
	
	public CommonBean dGetAlertListCnt(Map map);
	public List<AlertBean> dGetAlertList(Map map);
	
	public CommonBean dGetAlertErrorListCnt(Map map);
	public List<AlertBean> dGetAlertErrorList(Map map);

	public AlertBean dGetAlert(Map map);
	
	public Map prcChangeAlertStatus(Map map);
	
	public CommonBean dGetAlertLastSerial(Map map);
	
	public Map dPrcAlarm(Map map) throws Exception;
	
	public CommonBean dGetJobErrorLogListCnt(Map map);
	public List<AlertBean> dGetJobErrorLogList(Map map);
}
