package com.ghayoun.ezjobs.t.repository;

import java.util.List;
import java.util.Map;

import com.ghayoun.ezjobs.comm.domain.CommonBean;
import com.ghayoun.ezjobs.common.util.DefaultServiceException;
import com.ghayoun.ezjobs.t.domain.*;

public interface EmJobDeleteDao {
	
	public Map deleteJobs(Map map) throws DefaultServiceException, Exception;
}