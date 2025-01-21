package com.ghayoun.ezjobs.t.repository;

import java.util.List;
import java.util.Map;

import org.json.simple.JSONObject;

import com.ghayoun.ezjobs.comm.domain.CommonBean;
import com.ghayoun.ezjobs.common.util.DefaultServiceException;
import com.ghayoun.ezjobs.t.domain.*;

public interface EmConnectionProfileDao {
	
	
	public org.json.JSONObject prcConnectionProfileDao(Map map) throws Exception;;
}