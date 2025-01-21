package com.ghayoun.ezjobs.t.repository;

import java.util.List;
import java.util.Map;

import com.ghayoun.ezjobs.t.domain.*;
import com.ghayoun.ezjobs.comm.domain.CommonBean;
import com.ghayoun.ezjobs.m.domain.*;

public interface WorksApprovalLineDao {
	
	public List<ApprovalLineBean> dGetApprovalLineList(Map map);
	public List<ApprovalLineBean> dGetUserApprovalLineList(Map map);
	
	//procedure
	public Map dPrcApprovalLine(Map map);
	
	//procedure
	public Map dPrcApprovalLine_new(Map map);
	
	//procedure
	public Map dPrcApprovalLine_general(Map map);
	
	public List<ApprovalLineBean> dGetFinalAppList(Map map);
	
	public List<ApprovalLineBean> dGetDeptAppList(Map map);
	
	//procedure
	public Map dPrcFinalApp(Map map);
	
	public CommonBean dGetApprovalLineCnt(Map map);
	
	public List<ApprovalLineBean> dGetGroupAppList(Map map);
	
	public CommonBean dGetApprovalLineCnt_pop(Map map);
}