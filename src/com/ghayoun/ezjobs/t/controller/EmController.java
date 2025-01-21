package com.ghayoun.ezjobs.t.controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.servlet.ModelAndView;

import com.ghayoun.ezjobs.comm.domain.CommonBean;
import com.ghayoun.ezjobs.comm.service.CommonService;
import com.ghayoun.ezjobs.common.util.BaseController;
import com.ghayoun.ezjobs.common.util.CommonUtil;

public class EmController extends BaseController {

	protected final Log logger = LogFactory.getLog(getClass());

	private CommonService commonService;
	
	public void setCommonService(CommonService commonService) {
		this.commonService = commonService;
	}
	
	public ModelAndView ez001(HttpServletRequest req, HttpServletResponse res ) throws ServletException, IOException, Exception {
		
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		
		
		String xmlType 	= CommonUtil.isNull(paramMap.get("xmlType"));
		//폴더권한(이기준)
		paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
				
		List searchItemList	= commonService.dGetSearchItemList(paramMap);
		
		ModelAndView output = null;
		//output = new ModelAndView("ezjobs/t/setSearchItemList"+xmlType);
		output = new ModelAndView("common/setSearchItemList"+xmlType);
		output.addObject("searchItemList",searchItemList);
		
    	return output;
	}
	
	public ModelAndView ez004_master(HttpServletRequest req,
			HttpServletResponse res) throws ServletException, IOException,
			Exception {

		Map paramMap = CommonUtil.collectParameters(req);

		paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
		paramMap.put("searchType", "confirm_number_check_master");

		CommonBean commonBean = commonService.dGetSearchItemValue(paramMap);

		ModelAndView output = null;
		output = new ModelAndView("ezjobs/t/works/ajaxReturn2");
		output.addObject("commonBean", commonBean);
		return output;
	}
	
    public ModelAndView ez004_master_check(HttpServletRequest req, HttpServletResponse res)
    										throws ServletException, IOException, Exception{
    	
	    Map paramMap = CommonUtil.collectParameters(req);
	    
	    paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
	    paramMap.put("searchType", "master_check");
	    
	    CommonBean commonBean = commonService.dGetSearchItemValue(paramMap);
	    
	    ModelAndView output = null;
	    output = new ModelAndView("ezjobs/t/works/ajaxReturn2");
	    output.addObject("commonBean", commonBean);
	    return output;
	}
    
	public ModelAndView ez005(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {
		
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));

		List searchItemList = commonService.dGetSearchItemList(paramMap);

		ModelAndView output = null;
		output = new ModelAndView("ezjobs/common/itemXml");
		output.addObject("searchItemList", searchItemList);

		return output;
	}
	
	public ModelAndView ez001_popup(HttpServletRequest req, HttpServletResponse res ) throws ServletException, IOException, Exception {
		
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		List searchItemList	= commonService.dGetSearchItemList(paramMap);
		ModelAndView output = new ModelAndView("common/itemXml_ajax");
		output.addObject("searchItemList", searchItemList);
		
    	return output;
	}
	
}