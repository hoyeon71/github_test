package com.ghayoun.ezjobs.t.repository;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.HashMap;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import com.ghayoun.ezjobs.common.util.CommonUtil;
import com.ghayoun.ezjobs.common.util.DefaultServiceException;
import com.ghayoun.ezjobs.common.util.TraceLogUtil;
import com.ghayoun.ezjobs.t.axis.*;

public class EmJobDeleteDaoImpl extends SqlMapClientDaoSupport implements EmJobDeleteDao {
	
	

    /** Logger for this class and subclasses */
	protected final Log logger = LogFactory.getLog(getClass());
	
	public Map deleteJobs(Map map) throws Exception{
		/*
		T_Manager t = new T_Manager();
		map = t.deleteJobs(map);
		*/
		
		// API 호출 시작 로깅
		CommonUtil.ctmApiLoggingStart(map, "deleteJobs");
		
		T_Manager4 t = new T_Manager4();
		map = t.deleteJobs(map);
				
		// API 호출 종료 로깅
		CommonUtil.ctmApiLoggingEnd(map, "deleteJobs");
		
		return map;
    }
}
