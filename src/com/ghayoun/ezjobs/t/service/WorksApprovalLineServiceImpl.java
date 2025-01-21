package com.ghayoun.ezjobs.t.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.ghayoun.ezjobs.comm.domain.CommonBean;
import com.ghayoun.ezjobs.comm.repository.CommonDao;
import com.ghayoun.ezjobs.t.domain.ApprovalLineBean;
import com.ghayoun.ezjobs.t.repository.WorksApprovalLineDao;

public class WorksApprovalLineServiceImpl implements WorksApprovalLineService {
	
	private CommonDao commonDao;
	private WorksApprovalLineDao worksApprovalLineDao;
    
	public void setCommonDao(CommonDao commonDao) {
        this.commonDao = commonDao;
    }
	
    public void setWorksApprovalLineDao(WorksApprovalLineDao worksApprovalLineDao) {
        this.worksApprovalLineDao = worksApprovalLineDao;
    }

	public List<ApprovalLineBean> dGetApprovalLineList(Map map){
		return worksApprovalLineDao.dGetApprovalLineList(map);
	}
	public List<ApprovalLineBean> dGetUserApprovalLineList(Map map){
		return worksApprovalLineDao.dGetUserApprovalLineList(map);
	}
	
	//procedure
	public Map dPrcApprovalLine(Map map) throws Exception{
		
		Map m = new HashMap();
		
		map.put("flag", "del");
		worksApprovalLineDao.dPrcApprovalLine(map);
		
		map.put("flag", "ins");
		String[] user_cds = ((String)map.get("user_cds")).split(",");
		for(int i=0; i<user_cds.length; i++){
			map.put("user_cd", user_cds[i]);
			m = worksApprovalLineDao.dPrcApprovalLine(map);
		}
		
		return m;
	}
	
	//procedure
	public Map dPrcApprovalLine_new(Map map) throws Exception{
		
		Map m = new HashMap();
		
		map.put("flag", "del");
		worksApprovalLineDao.dPrcApprovalLine_new(map);
		
		map.put("flag", "ins");
		String[] user_cds = ((String)map.get("user_cds")).split(",");
		for(int i=0; i<user_cds.length; i++){
			map.put("user_cd", user_cds[i]);
			m = worksApprovalLineDao.dPrcApprovalLine_new(map);
		}
		
		return m;
	}
	
	//procedure
	public Map dPrcApprovalLine_general(Map map) throws Exception{
		
		Map m = new HashMap();		
		m = worksApprovalLineDao.dPrcApprovalLine_general(map);	
		
		return m;
	}
	
	public List<ApprovalLineBean> dGetFinalAppList(Map map){
		return worksApprovalLineDao.dGetFinalAppList(map);
	}
	
	
	public List<ApprovalLineBean> dGetDeptAppList(Map map){
		return worksApprovalLineDao.dGetDeptAppList(map);
	}
	
	//procedure
	public Map dPrcFinalApp(Map map) throws Exception{
		
		Map m = new HashMap();		
		m = worksApprovalLineDao.dPrcFinalApp(map);		
		
		return m;
	}
	
	public CommonBean dGetApprovalLineCnt(Map map){
    	return worksApprovalLineDao.dGetApprovalLineCnt(map);
	}
	
	public List<ApprovalLineBean> dGetGroupAppList(Map map){
		return worksApprovalLineDao.dGetGroupAppList(map);
	}
	public CommonBean dGetApprovalLineCnt_pop(Map map){
    	return worksApprovalLineDao.dGetApprovalLineCnt_pop(map);
	}
	
}