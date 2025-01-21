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
import com.ghayoun.ezjobs.common.util.TraceLogUtil;
import com.ghayoun.ezjobs.common.axis.*;
import com.ghayoun.ezjobs.t.axis.*;

public class EmJobDefinitionDaoImpl extends SqlMapClientDaoSupport implements EmJobDefinitionDao {

    /** Logger for this class and subclasses */
	protected final Log logger = LogFactory.getLog(getClass());
	
	public Map prcDefCreateJobs(Map map) throws Exception{
		
		// API 호출 시작 로깅
		CommonUtil.ctmApiLoggingStart(map, "prcDefCreateJobs");

		//aapi
//		AAPI_Manager t = new AAPI_Manager();
		
		//emapi
		T_Manager4 t = new T_Manager4();		

		map = t.defCreateJobs(map);
		
		// API 호출 종료 로깅
		CommonUtil.ctmApiLoggingEnd(map, "prcDefCreateJobs");
		
        return map;
    }
}
