package com.ghayoun.ezjobs.m.repository;

import java.util.List;
import java.util.Map;
import com.ghayoun.ezjobs.comm.domain.CommonBean;
import com.ghayoun.ezjobs.common.util.CommonUtil;
import com.ghayoun.ezjobs.m.domain.*;
import com.ghayoun.ezjobs.t.domain.DefJobBean;

public interface CtmInfoDao {
	
	public List<CtmInfoBean> dGetAgentList(Map map);
	
	public CommonBean dGetJobCondListCnt(Map map);
	
	public List<CtmInfoBean> dGetJobCondList(Map map);
	
	public List<CommonBean> dGetCmsNodGrpList(Map map);
	
	public List<CommonBean> dGetCmsNodGrpNodeList(Map map);
	
	public List<CommonBean> dGetResourceList(Map map);
	
	public List<CommonBean> dGetUsedJobList(Map map);
	
	public List<CommonBean> dGetCtmHost(Map map);
	
	//Connection profile host 목록
	public List<DefJobBean> dGetHostList(Map map);
	
	public CtmInfoBean dGetExcutingJob(Map map);
}