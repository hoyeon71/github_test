package com.ghayoun.ezjobs.t.repository;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import com.ghayoun.ezjobs.comm.domain.CommonBean;
import com.ghayoun.ezjobs.t.domain.*;
import com.ghayoun.ezjobs.common.util.DefaultServiceException;

public interface EmJobActionDao {
	
	public Map jobAction(Map map) throws DefaultServiceException, IOException, Exception;
	
}