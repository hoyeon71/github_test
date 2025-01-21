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
import com.ghayoun.ezjobs.common.axis.*;
import com.ghayoun.ezjobs.t.axis.*;

public class EmJobUploadDaoImpl extends SqlMapClientDaoSupport implements EmJobUploadDao {

    /** Logger for this class and subclasses */
	protected final Log logger = LogFactory.getLog(getClass());
	
	public Map defUploadJobs(Map map) throws Exception{
		
		/*
		T_Manager t = new T_Manager();
		map = t.defUploadjobs(map);
		return map;
		*/
		
		T_Manager4 t = new T_Manager4();
		map = t.defUploadjobs(map);
		return map;
    }
}
