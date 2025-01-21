package com.ghayoun.ezjobs.t.repository;

import java.util.List;
import java.util.Map;

import com.ghayoun.ezjobs.comm.domain.CommonBean;
import com.ghayoun.ezjobs.t.domain.*;

public interface EmJobCondDao {
	
	public Map condAControl(Map map);
	
	public Map condDControl(Map map);
}