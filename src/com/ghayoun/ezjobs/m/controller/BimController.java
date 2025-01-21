package com.ghayoun.ezjobs.m.controller;

import org.springframework.web.servlet.mvc.Controller;
import org.springframework.web.servlet.mvc.multiaction.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.beans.support.PagedListHolder;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import java.io.*;
import java.util.*;

import com.ghayoun.ezjobs.common.util.*;
import com.ghayoun.ezjobs.comm.service.*;
import com.ghayoun.ezjobs.m.service.*;

import com.ghayoun.ezjobs.comm.domain.*;

public class BimController extends BaseController {

	protected final Log logger = LogFactory.getLog(getClass());

	private CommonService commonService;
	private BimService bimService;

	public void setCommonService(CommonService commonService) {
		this.commonService = commonService;
	}
	public void setBimService(BimService bimService) {
		this.bimService = bimService;
	}
	
	public ModelAndView ez001(HttpServletRequest req, HttpServletResponse res ) 
										throws ServletException, IOException, Exception{
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		Map<String, Object> rMap 	= new HashMap<String, Object>();
		
		CommonUtil.emLogin(req);
		paramMap.put("userToken", CommonUtil.isNull(req.getSession().getAttribute("USER_TOKEN")));
		
		rMap = bimService.getServiceList(paramMap);
		
		ModelAndView output = null;
		output = new ModelAndView("ezjobs/m/bim/serviceList");
		output.addObject("rMap",rMap);
		
    	return output;
    	
	}
	
}