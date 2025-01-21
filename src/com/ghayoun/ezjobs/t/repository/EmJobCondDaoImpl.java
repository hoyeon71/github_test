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
import com.ghayoun.ezjobs.common.axis.*;
import com.ghayoun.ezjobs.t.axis.*;

public class EmJobCondDaoImpl extends SqlMapClientDaoSupport implements EmJobCondDao {

    /** Logger for this class and subclasses */
	protected final Log logger = LogFactory.getLog(getClass());
	
	public Map condAControl(Map map){
		/*
		T_Manager t = new T_Manager();
		map = t.condAControl(map);
		*/
        return map;
    }
	
	public Map condDControl(Map map){
		/*
		T_Manager t = new T_Manager();
		map = t.condDControl(map);
		*/
        return map;
    }
}
