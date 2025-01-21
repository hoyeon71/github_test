package com.ghayoun.ezjobs.t.service;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

import com.ghayoun.ezjobs.comm.domain.CommonBean;
import com.ghayoun.ezjobs.t.domain.ApprovalLineBean;


public interface WorksApprovalLineService extends Serializable{

	public List<ApprovalLineBean> dGetApprovalLineList(Map map);
	public List<ApprovalLineBean> dGetUserApprovalLineList(Map map);
	
	//procedure
	public Map dPrcApprovalLine(Map map) throws Exception;
	
	//procedure
	public Map dPrcApprovalLine_new(Map map) throws Exception;
	
	//procedure
	public Map dPrcApprovalLine_general(Map map) throws Exception;
	
	public List<ApprovalLineBean> dGetFinalAppList(Map map);
	
	
	public List<ApprovalLineBean> dGetDeptAppList(Map map);
	//procedure
	public Map dPrcFinalApp(Map map) throws Exception;
	
	public CommonBean dGetApprovalLineCnt(Map map);
	
	public List<ApprovalLineBean> dGetGroupAppList(Map map);
	
	public CommonBean dGetApprovalLineCnt_pop(Map map);
}
