package com.ghayoun.ezjobs.m.repository;

import java.util.List;
import java.util.Map;
import com.ghayoun.ezjobs.m.domain.JobLogBean;

public interface PopupJobDetailCtmDao {
	
	public List<JobLogBean> dGetJobLogListContent(Map map);
}