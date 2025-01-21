package com.ghayoun.ezjobs.t.repository;

import java.util.List;
import java.util.Map;

import com.ghayoun.ezjobs.t.domain.*;
import com.ghayoun.ezjobs.comm.domain.CommonBean;
import com.ghayoun.ezjobs.m.domain.*;

public interface WorksCompanyDao {
	
	public List<CompanyBean> dGetDeptList(Map map);
	public List<CompanyBean> dGetDutyList(Map map);	
	public List<CompanyBean> dGetTeamList(Map map);
	
	//procedure
	public Map dPrcDept(Map map);
	public Map dPrcDuty(Map map);
	public Map dPrcPart(Map map);
	public Map dPrcTeam(Map map);
	
	public List<CommonBean> dGetMCodeList(Map map);	
	public List<CommonBean> dGetSCodeList(Map map);
	//procedure
	public Map dPrcCode(Map map);
	
	public Map dPrcTags(Map map);
	
	public List<TagsBean> dGetTagsList(Map map);
	
	public TagsBean dGetTagsSchedInfo(Map map);
	
	public List<TagsBean> dGetDefTagsList(Map map);
	
	public TagsBean dGetDefTagsSchedInfo(Map map);
	
	public CommonBean dGetTableInfo(Map map);
	
	public List<TagsBean> dGetDefTagsList2(Map map);
	
	public TagsBean dGetTagsInfo(Map map);
	public int dGetDeptCnt(Map<String, Object> map);
	public int dGetDutyCnt(Map<String, Object> map);
}