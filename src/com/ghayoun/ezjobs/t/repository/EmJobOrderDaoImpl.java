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

public class EmJobOrderDaoImpl extends SqlMapClientDaoSupport implements EmJobOrderDao {

    /** Logger for this class and subclasses */
	protected final Log logger = LogFactory.getLog(getClass());
	
	public Map jobsOrder(Map map) throws Exception{
		
		// API 호출 시작 로깅
		CommonUtil.ctmApiLoggingStart(map, "jobsOrder");
		
		//emapi
		T_Manager4 t = new T_Manager4();
		
//		aapi
//		AAPI_Manager t = new AAPI_Manager();
		
		map = t.jobsOrder(map);
		
		// API 호출 종료 로깅
		CommonUtil.ctmApiLoggingEnd(map, "jobsOrder");
		
		return map;
    }
}
