package com.ghayoun.ezjobs.m.repository;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;
import java.util.Map;

public class BimDaoImpl extends SqlMapClientDaoSupport implements BimDao {

    /** Logger for this class and subclasses */
	protected final Log logger = LogFactory.getLog(getClass());
	
	public Map getServiceList(Map map){
		//M_Manager m = new M_Manager();
		//map = m.bimServicesInfo(map);
        return map;
    }
}
