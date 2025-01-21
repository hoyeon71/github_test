package com.ghayoun.ezjobs.t.repository;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.HashMap;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.json.JSONObject;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import com.ghayoun.ezjobs.comm.domain.*;
import com.ghayoun.ezjobs.common.util.CommonUtil;
import com.ghayoun.ezjobs.common.util.TraceLogUtil;
import com.ghayoun.ezjobs.common.axis.*;
import com.ghayoun.ezjobs.t.axis.*;

public class EmConnectionProfileDaoImpl extends SqlMapClientDaoSupport implements EmConnectionProfileDao {

    /** Logger for this class and subclasses */
//	protected final Log logger = LogFactory.getLog(getClass());
	
	public JSONObject prcConnectionProfileDao(Map map) throws Exception{

		// API 호출 시작 로깅
		CommonUtil.ctmApiLoggingStart(map, "getConnectionProfileDao");
		
		//aapi
		AAPI_Manager t = new AAPI_Manager();
//		map = t.defCreateJobs(map);
		JSONObject a = t.getConnectionProfileDao(map);
		
		// API 호출 종료 로깅
		CommonUtil.ctmApiLoggingEnd(map, "getConnectionProfileDao");
		
        return a;
    }
}
