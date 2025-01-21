package com.ghayoun.ezjobs.a.service;

import java.util.*;

import com.ghayoun.ezjobs.a.domain.*;
import com.ghayoun.ezjobs.comm.domain.*;
import com.ghayoun.ezjobs.comm.repository.CommonDao;
import com.ghayoun.ezjobs.common.util.CommonUtil;
import com.ghayoun.ezjobs.a.repository.EmAlertDao;

public class EmAlertServiceImpl implements EmAlertService {
	

	private CommonDao commonDao;
	private EmAlertDao emAlertDao;
	
	public void setCommonDao(CommonDao commonDao) {
        this.commonDao = commonDao;
    }
	
    public void setEmAlertDao(EmAlertDao emAlertDao) {
        this.emAlertDao = emAlertDao;
    }
	
    public CommonBean dGetAlertListCnt(Map map){
    	return emAlertDao.dGetAlertListCnt(map);
	}
	public List<AlertBean> dGetAlertList(Map map){
		return emAlertDao.dGetAlertList(map);
	}
	
	public CommonBean dGetAlertErrorListCnt(Map map){
		 return emAlertDao.dGetAlertErrorListCnt(map);
	}
	
	@SuppressWarnings("unchecked")
	public List<AlertBean> dGetAlertErrorList(Map map){
		
		String from_odate = CommonUtil.isNull(map.get("p_from_odate"));
		String to_odate = CommonUtil.isNull(map.get("p_to_odate"));
		String search_start_time1 = CommonUtil.isNull(map.get("p_search_start_time1"));
		String search_end_time1 = CommonUtil.isNull(map.get("p_search_end_time1"));

		if(!from_odate.equals("")) {
			from_odate = from_odate + " " + search_start_time1;
		}
		
		if(!to_odate.equals("")) {
			to_odate = to_odate + " " + search_end_time1;
		}
		
		map.put("p_from_odate", from_odate);
		map.put("p_to_odate", to_odate);
		
		return emAlertDao.dGetAlertErrorList(map);
	}
	
	public AlertBean dGetAlert(Map map){
		return emAlertDao.dGetAlert(map);
	}
	
	public Map prcChangeAlertStatus(Map map){
		return emAlertDao.prcChangeAlertStatus(map);
	}
	
	public CommonBean dGetAlertLastSerial(Map map){
    	return emAlertDao.dGetAlertLastSerial(map);
	}
	
	public Map dPrcAlarm(Map map){
		
		Map rMap = null;
		
		if( map.get("alarm_cd").getClass().isArray() ){
			
			String[] alarm_cd 				= (String[])map.get("alarm_cd");
			String[] user_cd 				= (String[])map.get("user_cd");
			String[] user_nm 				= (String[])map.get("user_nm");
			String[] action_yn 				= (String[])map.get("action_yn");
			String[] confirm_yn 			= (String[])map.get("confirm_yn");
			String[] action_gubun 			= (String[])map.get("action_gubun");
			String[] recur_yn 				= (String[])map.get("recur_yn");
			String[] error_gubun 			= (String[])map.get("error_gubun");
			String[] error_description 		= (String[])map.get("error_description");
			String[] solution_description 	= (String[])map.get("solution_description");			
			String[] udt_yn 				= (String[])map.get("udt_yn");
			
			for(int i=0;i<alarm_cd.length;i++){
				
				if(!"Y".equals(udt_yn[i])) continue;
				
				map.put("alarm_cd", 			alarm_cd[i]);
				map.put("user_cd", 				user_cd[i]);
				map.put("user_nm", 				CommonUtil.K2E(user_nm[i]));
				map.put("action_yn", 			action_yn[i]);
				map.put("confirm_yn", 			confirm_yn[i]);
				map.put("action_gubun",	 		action_gubun[i]);
				map.put("recur_yn", 			recur_yn[i]);
				map.put("error_gubun", 			CommonUtil.K2E(error_gubun[i]));
				map.put("error_description", 	CommonUtil.K2E(error_description[i]));
				map.put("solution_description", CommonUtil.K2E(solution_description[i]));
				
				rMap = emAlertDao.dPrcAlarm(map);
			}
			
		}else{
			rMap = emAlertDao.dPrcAlarm(map);
		}
		
		return rMap;
	}
	
	public CommonBean dGetJobErrorLogListCnt(Map map){
    	return emAlertDao.dGetJobErrorLogListCnt(map);
	}
	public List<AlertBean> dGetJobErrorLogList(Map map){
		return emAlertDao.dGetJobErrorLogList(map);
	}
	
}