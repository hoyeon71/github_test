package com.ghayoun.ezjobs.t.repository;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import java.util.HashMap;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.ghayoun.ezjobs.comm.domain.*;
import com.ghayoun.ezjobs.common.util.CommonUtil;
import com.ghayoun.ezjobs.common.util.DefaultServiceException;
import com.ghayoun.ezjobs.common.util.TraceLogUtil;
import com.ghayoun.ezjobs.common.axis.*;
import com.ghayoun.ezjobs.t.axis.*;

public class EmJobActionDaoImpl extends SqlMapClientDaoSupport implements EmJobActionDao {

    /** Logger for this class and subclasses */
	protected final Log logger = LogFactory.getLog(getClass());
	
	public Map jobAction(Map map) throws Exception{
		/*
		T_Manager t = new T_Manager();
		map = t.jobAction(map);
        return map;        
        */
		
		String strFlag 			= CommonUtil.isNull(map.get("flag"));
		
		// API 호출 시작 로깅
		CommonUtil.ctmApiLoggingStart(map, "jobAction");

		if ( strFlag.equals("RUNNOW") ) {
			AAPI_Manager t = new AAPI_Manager();
			map = t.jobAction(map);
		}else {
			T_Manager4 t = new T_Manager4();
			map = t.jobAction(map);
		}
		
		// API 호출 종료 로깅
		CommonUtil.ctmApiLoggingEnd(map, "jobAction");
		
// 		T_Manager4 t = new T_Manager4();
//		AAPI_Manager t = new AAPI_Manager();
//		map = t.jobAction(map);
        return map;
    }
	
}
