package com.ghayoun.ezjobs.t.service;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

import com.ghayoun.ezjobs.comm.domain.CommonBean;
import com.ghayoun.ezjobs.t.domain.CompanyBean;
import com.ghayoun.ezjobs.t.domain.TagsBean;


public interface WorksCompanyService extends Serializable{

	public List<CompanyBean> dGetDeptList(Map map);
	public List<CompanyBean> dGetDutyList(Map map);

	//procedure
	public Map dPrcDept(Map map) throws Exception;
	public Map dPrcDuty(Map map) throws Exception;
	public Map dPrcPart(Map map) throws Exception;
	
	public List<CommonBean> dGetMCodeList(Map map);	
	public List<CommonBean> dGetSCodeList(Map map);	
	//procedure
	public Map dPrcCode(Map map) throws Exception;
	
	public Map dPrcTags(Map map) throws Exception;
	
	public List<TagsBean> dGetTagsList(Map map);
	
	public TagsBean dGetTagsSchedInfo(Map map);
	
	public List<TagsBean> dGetDefTagsList(Map map);
	
	public TagsBean dGetDefTagsSchedInfo(Map map);
	
	public CommonBean dGetTableInfo(Map map);
	
	public List<TagsBean> dGetDefTagsList2(Map map);
	
	public TagsBean dGetTagsInfo(Map map);
}

