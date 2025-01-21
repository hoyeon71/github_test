package com.ghayoun.ezjobs.t.repository;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.HashMap;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import com.ghayoun.ezjobs.comm.domain.*;
import com.ghayoun.ezjobs.common.util.CommonUtil;
import com.ghayoun.ezjobs.common.util.DefaultServiceException;
import com.ghayoun.ezjobs.common.util.TraceLogUtil;
import com.ghayoun.ezjobs.common.axis.*;
import com.ghayoun.ezjobs.t.axis.*;

public class EmJobCreateDaoImpl extends SqlMapClientDaoSupport implements EmJobCreateDao {

    /** Logger for this class and subclasses */
	protected final Log logger = LogFactory.getLog(getClass());
	
	public Map createJobs(Map map) throws Exception{
		/*
		T_Manager t = new T_Manager();
		map = t.createJobs(map);
        return map;
        */
		
		// API 호출 시작 로깅
		CommonUtil.ctmApiLoggingStart(map, "createJobs");
		
		T_Manager4 t = new T_Manager4();
		map = t.createJobs(map);
		
		// API 호출 종료 로깅
		CommonUtil.ctmApiLoggingEnd(map, "createJobs");
		
        return map;
    }
}
