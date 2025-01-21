package com.ghayoun.ezjobs.comm.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.nio.charset.Charset;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Base64;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.StringTokenizer;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ghayoun.ezjobs.comm.service.*;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.servlet.ModelAndView;
import com.ghayoun.ezjobs.comm.domain.BoardBean;
import com.ghayoun.ezjobs.comm.domain.CommonBean;
import com.ghayoun.ezjobs.comm.domain.HolidayBean;
import com.ghayoun.ezjobs.comm.service.CommonService;
import com.ghayoun.ezjobs.comm.service.EzHistoryJobServiceImpl;
import com.ghayoun.ezjobs.comm.service.EzLogDeleteJobServiceImpl;
import com.ghayoun.ezjobs.comm.service.EzRplnJobServiceImpl;
import com.ghayoun.ezjobs.comm.service.EzSmsJobServiceImpl;
import com.ghayoun.ezjobs.comm.service.EzPreDateBatchCallJobServiceImpl;
import com.ghayoun.ezjobs.common.util.BaseController;
import com.ghayoun.ezjobs.common.util.CommonUtil;
import com.ghayoun.ezjobs.common.util.DbUtil;
import com.ghayoun.ezjobs.common.util.DefaultServiceException;
import com.ghayoun.ezjobs.common.util.JsUtil;
import com.ghayoun.ezjobs.common.util.Paging;
import com.ghayoun.ezjobs.common.util.SeedUtil;
import com.ghayoun.ezjobs.m.domain.DefJobBean;
import com.ghayoun.ezjobs.m.domain.JobLogBean;
import com.ghayoun.ezjobs.m.service.EmActiveJobsService;
import com.ghayoun.ezjobs.m.service.EmBatchResultTotalService;
import com.ghayoun.ezjobs.m.service.EmCtmInfoService;
import com.ghayoun.ezjobs.m.service.EmDefJobsService;
import com.ghayoun.ezjobs.m.service.EmJobLogService;
import com.ghayoun.ezjobs.t.domain.Doc06Bean;
import com.ghayoun.ezjobs.t.domain.JobMapperBean;
import com.ghayoun.ezjobs.t.repository.EmConnectionProfileDao;
import com.ghayoun.ezjobs.t.service.PopupDefJobService;
import com.ghayoun.ezjobs.t.service.WorksApprovalLineService;
import com.google.gson.JsonObject;


public class CommonController extends BaseController {

	protected final Log logger = LogFactory.getLog(getClass());

	private CommonService commonService;
	private WorksApprovalLineService worksApprovalLineService;
	private EmDefJobsService emDefJobsService;
	private EmBatchResultTotalService emBatchResultTotalService;

	public void setCommonService(CommonService commonService) {
		this.commonService = commonService;
	}
	public void setWorksApprovalLineService(WorksApprovalLineService worksApprovalLineService) { 
		this.worksApprovalLineService = worksApprovalLineService;
	}	
	public void setEmDefJobsService(EmDefJobsService emDefJobsService){
		this.emDefJobsService = emDefJobsService;
	}
	public void setEmBatchResultTotalService(EmBatchResultTotalService emBatchResultTotalService){
		this.emBatchResultTotalService = emBatchResultTotalService;
	}
	
	private EmActiveJobsService emActiveJobsService;
	public void setEmActiveJobsService(EmActiveJobsService emActiveJobsService) {
      this.emActiveJobsService = emActiveJobsService;
	}
	   
	   
    private EmCtmInfoService emCtmInfoService;
    public void setEmCtmInfoService(EmCtmInfoService emCtmInfoService) {
      this.emCtmInfoService = emCtmInfoService;
    }
    
    private PopupDefJobService popupDefJobService;
    public void setPopupDefJobService(PopupDefJobService popupDefJobService){
    	this.popupDefJobService = popupDefJobService;
    }
    
    private EmJobLogService emJobLogService;
    public void setEmJobLogService(EmJobLogService emJobLogService) {
		this.emJobLogService = emJobLogService;
	}
    
    private static EmConnectionProfileDao emConnectionProfileDao;
    
    public void batchControlSet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {
		
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);

		paramMap.put("SCHEMA", 		CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		
		paramMap.put("mcode_cd", "M72");
		List controlList = commonService.dGetsCodeList(paramMap);
		
		String strBatchControl = "";

		for(int i=0;i<controlList.size();i++){
			CommonBean bean = (CommonBean) controlList.get(i);
			
			strBatchControl = CommonUtil.isNull(bean.getScode_nm());
		}

		req.getSession().setAttribute("BATCH_CONTROL", strBatchControl);
	}
	
	@SuppressWarnings("unchecked")
	public ModelAndView ez00(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception{
		
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		
		paramMap.put("s_user_cd", 	CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
		paramMap.put("s_user_gb", 	CommonUtil.isNull(req.getSession().getAttribute("USER_GB")));
		paramMap.put("s_user_ip", 	CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
		paramMap.put("SCHEMA", 		CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		
		paramMap.put("mcode_cd", "M6");
				
		List<CommonBean> dataCenterList = CommonUtil.getDataCenterList();
		ArrayList<Map<String, Object>> data_center_items = new ArrayList();
		
		for(int i=0;i<dataCenterList.size();i++){
			CommonBean bean = dataCenterList.get(i);
			
			Map<String, Object> hm = new HashMap();
			hm.put("data_center_code", bean.getData_center_code());
			hm.put("data_center", bean.getData_center());
			hm.put("active_net_name", bean.getActive_net_name());
			data_center_items.add(hm);					
		}
		
		paramMap.put("data_center_items", data_center_items);
		
		// 수행현황
		/*
		List<CommonBean> myWorksInfo = commonService.dGetMyWorksInfo(paramMap, req);
		for(int i=0;i<myWorksInfo.size();i++){
			
			if(i == 0) paramMap.put("TOTAL_COUNT", 	myWorksInfo.get(i).getStatis());
			if(i == 1) paramMap.put("NOTOK", 		myWorksInfo.get(i).getStatis());
			if(i == 2) paramMap.put("OK", 			myWorksInfo.get(i).getStatis());
			if(i == 3) paramMap.put("EXCUTING", 	myWorksInfo.get(i).getStatis());
			if(i == 4) paramMap.put("WAIT", 		myWorksInfo.get(i).getStatis());
			if(i == 5) paramMap.put("LATE", 		myWorksInfo.get(i).getStatis());
			
		}
		*/
		
		int row = 0;
		String total_sum = CommonUtil.isNull(commonService.dGetMainAllDocInfoCnt(paramMap));
		StringTokenizer st = new StringTokenizer(total_sum,",");
		while(st.hasMoreTokens()){
			
			if(row == 0) paramMap.put("DOC_01", st.nextToken());
			if(row == 1) paramMap.put("DOC_02", st.nextToken());
			if(row == 2) paramMap.put("DOC_05", st.nextToken());
			if(row == 3) paramMap.put("DOC_06", st.nextToken());
			
			++row;
		}

		paramMap.put("gb_01", CommonUtil.getMessage("CATEGORY.GB.01.GB.0101"));
		paramMap.put("gb_02", CommonUtil.getMessage("CATEGORY.GB.01.GB.0102"));
		paramMap.put("gb_03", CommonUtil.getMessage("CATEGORY.GB.01.GB.0103"));
		paramMap.put("gb_04", CommonUtil.getMessage("CATEGORY.GB.01.GB.0104"));		
		
		// 최초 로그인시에만 로그인 이력을 쌓는다.
		String login_chk = CommonUtil.isNull(req.getSession().getAttribute("LOGIN_CHK"));
		if(login_chk.equals("Y")) {
			paramMap.put("flag", "login");
			paramMap.put("ins_user_cd", 	CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
			paramMap.put("ins_user_ip", 	CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
			commonService.dPrcLog(paramMap);

		}

		ModelAndView output = null;
		output = new ModelAndView("works/M/common/main");
		output.addObject("cm", CommonUtil.getComScodeList(paramMap));
		output.addObject("paramMap", paramMap);

    	return output;		
    }

	public ModelAndView ez000(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception{
		
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		
		paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
		paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		
		String sLink = CommonUtil.isNull(paramMap.get("a"));
		sLink = sLink.replaceAll("\\.", "/");
		
		// 로그인 성공 시 이력 저장
		paramMap.put("flag", "login");
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		commonService.dPrcLog(paramMap);		
		
		ModelAndView output = null;
		output = new ModelAndView(sLink);

    	return output;		
    }
		
	
	public ModelAndView ez001(HttpServletRequest req, HttpServletResponse res ) 
										throws ServletException, IOException, Exception{
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		Map<String, Object> rMap 	= new HashMap<String, Object>();
		
		rMap 		= commonService.emLogin(paramMap);
		
		ModelAndView output = null;
		output = new ModelAndView("ezjobs/common/result");
		output.addObject("rMap",rMap);
		
    	return output;
    	
	}
	
	public ModelAndView ez002(HttpServletRequest req, HttpServletResponse res ) throws ServletException, IOException, Exception {
		
		Map<String, Object> paramMap 	= CommonUtil.collectParameters(req);
		Map<String, Object> rMap 		= new HashMap<String, Object>();
		
		rMap.put("rOriType", "response_unregister");
		rMap.put("rCode", "1");
		
		req.getSession().invalidate();
		
		// SSO LOGOUT
		/*
		String json_string			= "";				
		String strSsoLogoutUrl 	= CommonUtil.isNull(CommonUtil.getMessage("SSO_LOGOUT_URL"));
		String strSsoReturnUrl 	= CommonUtil.isNull(CommonUtil.getMessage("SSO_RETURN_URL"));
		
		System.out.println(strSsoLogoutUrl + "?targetUrl=" + strSsoReturnUrl);
		
		// ACCESS TOKEN
		URL obj = new URL(strSsoLogoutUrl + "?targetUrl=" + strSsoReturnUrl);
		HttpURLConnection conn = (HttpURLConnection) obj.openConnection();
		
		conn.setRequestMethod("GET");
		conn.setDoOutput(true);
		*/
		
		ModelAndView output = null;
		output = new ModelAndView("common/result");
		output.addObject("rMap",rMap);

    	return output;
    	
	}
	
	public ModelAndView ez003(HttpServletRequest req, HttpServletResponse res ) 
										throws ServletException, IOException, Exception{
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		
		List categoryList 		= commonService.getCategoryList(paramMap,"CATEGORY");
		
		List category01List 	= commonService.getCategoryList(paramMap,"CATEGORY.01");
		List category0101List 	= commonService.getCategoryList(paramMap,"CATEGORY.01.01");
		List category0102List 	= commonService.getCategoryList(paramMap,"CATEGORY.01.02");
		
		List category02List 	= commonService.getCategoryList(paramMap,"CATEGORY.02");
		List category0201List 	= commonService.getCategoryList(paramMap,"CATEGORY.02.01");
		
		List category03List 	= commonService.getCategoryList(paramMap,"CATEGORY.03");
		List category0301List 	= commonService.getCategoryList(paramMap,"CATEGORY.03.01");
		
		ModelAndView output = null;
		output = new ModelAndView("ezjobs/category");
		output.addObject("categoryList",categoryList);
		
		output.addObject("category01List",category01List);
		output.addObject("category0101List",category0101List);
		output.addObject("category0102List",category0102List);
		
		output.addObject("category02List",category02List);
		output.addObject("category0201List",category0201List);
		
		output.addObject("category03List",category03List);
		output.addObject("category0301List",category0301List);
		
    	return output;
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public ModelAndView ez004(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception{
		
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		//폴더권한(이기준)
		paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
				
		List searchItemList 		= commonService.dGetSearchItemList(paramMap);
		
		ModelAndView output = null;
		//output = new ModelAndView("ezjobs/common/setSearchItemList");
		output = new ModelAndView("common/inc/setSearchItemList");
		output.addObject("searchItemList",searchItemList);
		
    	return output;
	}
	

	public ModelAndView ez005(HttpServletRequest req, HttpServletResponse res ) throws ServletException, IOException, Exception {
		
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		
		String strSearchPage = CommonUtil.isNull(paramMap.get("search_page"));
		
		paramMap.put("searchType", "dataCenterList");
		List dataCenterList = commonService.dGetSearchItemList(paramMap);
		
		String active_net_names = "";
		for(int i=0; i<dataCenterList.size(); i++){
			CommonBean bean = (CommonBean)dataCenterList.get(i);
			if( "".equals(active_net_names) ) active_net_names = bean.getActive_net_name();
			else active_net_names += (","+bean.getActive_net_name());
		}
		paramMap.put("active_net_names",active_net_names.split(",") );
		
		//paramMap.put("searchType", "odateList");
		paramMap.put("searchType", "ctmOdateList");
		List odateList 		= commonService.dGetSearchItemList(paramMap);
		
		paramMap.put("searchType", "hostList");
		List hostList = commonService.dGetSearchItemList(paramMap);
		
		CommonBean approvalLineBean = null;
		
		paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		
		// 결재할 작업 존재 여부.
		if ( !CommonUtil.isNull(req.getSession().getAttribute("USER_CD")).equals("") ) {
			approvalLineBean = worksApprovalLineService.dGetApprovalLineCnt(paramMap);
		}
		
		ModelAndView output = null;
		output = new ModelAndView("search/" + strSearchPage);
		output.addObject("odateList", odateList);
		output.addObject("dataCenterList",		dataCenterList);
		output.addObject("hostList",			hostList);
		output.addObject("approvalLineBean",	approvalLineBean);
		
		
    	return output;
	}
	
	public ModelAndView ez005_1(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {
		
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		
		String strSearchPage = CommonUtil.isNull(paramMap.get("search_page"));

		paramMap.put("searchType", "odateList");
		List odateList = commonService.dGetSearchItemList(paramMap);

		paramMap.put("searchType", "dataCenterList");
		List dataCenterList = commonService.dGetSearchItemList(paramMap);
		
		CommonBean approvalLineBean = null;
		
		paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		
		// 결재할 작업 존재 여부.
		if ( !CommonUtil.isNull(req.getSession().getAttribute("USER_CD")).equals("") ) {
			approvalLineBean = worksApprovalLineService.dGetApprovalLineCnt(paramMap);
		}

		ModelAndView output = null;
		output = new ModelAndView("search/" + strSearchPage);
		output.addObject("dataCenterList", 		dataCenterList);
		output.addObject("odateList",			odateList);
		output.addObject("approvalLineBean",	approvalLineBean);

		return output;
	}

	public ModelAndView ez005_2(HttpServletRequest req, HttpServletResponse res ) 
										throws ServletException, IOException, Exception{
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		
		String strSearchPage = CommonUtil.isNull(paramMap.get("search_page"));
		
		paramMap.put("searchType", "odatePostList");
		List odateList 		= commonService.dGetSearchItemList(paramMap);
		paramMap.put("searchType", "dataCenterList");
		List dataCenterList = commonService.dGetSearchItemList(paramMap);
		
		CommonBean approvalLineBean = null;
		
		paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		
		// 결재할 작업 존재 여부.
		if ( !CommonUtil.isNull(req.getSession().getAttribute("USER_CD")).equals("") ) {
			approvalLineBean = worksApprovalLineService.dGetApprovalLineCnt(paramMap);
		}
		
		ModelAndView output = null;
		output = new ModelAndView("search/" + strSearchPage);
		output.addObject("odateList",			odateList);
		output.addObject("dataCenterList",		dataCenterList);
		output.addObject("approvalLineBean",	approvalLineBean);
		
    	return output;
	}
	
	public ModelAndView ez005_3(HttpServletRequest req, HttpServletResponse res ) 
										throws ServletException, IOException, Exception{
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		
		paramMap.put("searchType", "dataCenterList");
		List dataCenterList = commonService.dGetSearchItemList(paramMap);
		
		String active_net_names = "";
		for(int i=0; i<dataCenterList.size(); i++){
			CommonBean bean = (CommonBean)dataCenterList.get(i);
			if( "".equals(active_net_names) ) active_net_names = bean.getActive_net_name();
			else active_net_names += (","+bean.getActive_net_name());
		}
		paramMap.put("active_net_names",active_net_names.split(",") );
		
		paramMap.put("searchType", "odateList");
		List odateList 		= commonService.dGetSearchItemList(paramMap);
		
		CommonBean approvalLineBean = null;
		
		paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		
		// 결재할 작업 존재 여부.
		if ( !CommonUtil.isNull(req.getSession().getAttribute("USER_CD")).equals("") ) {
			approvalLineBean = worksApprovalLineService.dGetApprovalLineCnt(paramMap);
		}
		
		ModelAndView output = null;
		output = new ModelAndView("ezjobs/common/inc/top");
		output.addObject("odateList",			odateList);
		output.addObject("approvalLineBean",	approvalLineBean);
		
    	return output;
	}
	

	public ModelAndView ez005_4(HttpServletRequest req, HttpServletResponse res ) 
										throws ServletException, IOException, Exception{
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		
		String strSearchPage = CommonUtil.isNull(paramMap.get("search_page"));
		
		paramMap.put("searchType", "odateList");
		List odateList 		= commonService.dGetSearchItemList(paramMap);
		
		CommonBean approvalLineBean = null;
		
		paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		
		// 결재할 작업 존재 여부.
		if ( !CommonUtil.isNull(req.getSession().getAttribute("USER_CD")).equals("") ) {
			approvalLineBean = worksApprovalLineService.dGetApprovalLineCnt(paramMap);
		}
		
		ModelAndView output = null;
		output = new ModelAndView("search/" + strSearchPage);
		output.addObject("odateList",			odateList);
		output.addObject("approvalLineBean",	approvalLineBean);
		
    	return output;
	}
	

	public ModelAndView ez005_5(HttpServletRequest req, HttpServletResponse res ) 
										throws ServletException, IOException, Exception{
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		
		paramMap.put("searchType", "odateList");
		List odateList 		= commonService.dGetSearchItemList(paramMap);
		paramMap.put("searchType", "dataCenterList");
		List dataCenterList = commonService.dGetSearchItemList(paramMap);
		
		CommonBean approvalLineBean = null;
		
		paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		
		// 결재할 작업 존재 여부.
		if ( !CommonUtil.isNull(req.getSession().getAttribute("USER_CD")).equals("") ) {
			approvalLineBean = worksApprovalLineService.dGetApprovalLineCnt(paramMap);
		}
		
		ModelAndView output = null;
		output = new ModelAndView("ezjobs/common/inc/top");
		output.addObject("odateList",			odateList);
		output.addObject("dataCenterList",		dataCenterList);
		output.addObject("approvalLineBean",	approvalLineBean);
		
    	return output;
	}
	
	public ModelAndView ez005_6(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException, Exception {
		
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		
		String strSearchPage = CommonUtil.isNull(paramMap.get("search_page"));
		
		CommonBean approvalLineBean = null;
		
		paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		
		// 결재할 작업 존재 여부.
		if ( !CommonUtil.isNull(req.getSession().getAttribute("USER_CD")).equals("") ) {
			approvalLineBean = worksApprovalLineService.dGetApprovalLineCnt(paramMap);
		}

		ModelAndView output = null;
		//output = new ModelAndView("ezjobs/common/inc/top");
		output = new ModelAndView("search/" + strSearchPage);
		
		output.addObject("approvalLineBean",	approvalLineBean);

		return output;
	}
	

	public ModelAndView ez101(HttpServletRequest req, HttpServletResponse res ) 
										throws ServletException, IOException, Exception{
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		
		CommonBean calendarDetail = commonService.dGetCalendarDetail(paramMap);
		
		ModelAndView output = null;
//		output = new ModelAndView("ezjobs/common/popup/calendarDetail");
		output = new ModelAndView("contents/popup/calendarDetail");
		output.addObject("calendarDetail",calendarDetail);
		
    	return output;
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	public ModelAndView ezItemXml(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {
		
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
	
		String searchType = CommonUtil.isNull(paramMap.get("itemGb"));
		ModelAndView output = null;
		output = new ModelAndView("itemXml");
		if("dash01".equals(searchType)){
			
			List dataCenterList = CommonUtil.getDataCenterList();
			
			ArrayList<Map> data_center_items = new ArrayList();
			for (int i = 0; i < dataCenterList.size(); i++) {
				CommonBean bean = (CommonBean) dataCenterList.get(i);

				Map<String, Object> hm = new HashMap();
				hm.put("data_center_code", bean.getData_center_code());
				hm.put("data_center", bean.getData_center());
				hm.put("active_net_name", bean.getActive_net_name());
				data_center_items.add(hm);
			}
			paramMap.put("data_center_items", data_center_items);
			
			output.addObject("searchItemList",emActiveJobsService.getTotalJobStatusList(paramMap));
		}
		if("dash02".equals(searchType)){
			
			List dataCenterList = CommonUtil.getDataCenterList();
			
			ArrayList<Map> data_center_items = new ArrayList();
			for (int i = 0; i < dataCenterList.size(); i++) {
				CommonBean bean = (CommonBean) dataCenterList.get(i);

				Map<String, Object> hm = new HashMap();
				hm.put("data_center_code", bean.getData_center_code());
				hm.put("data_center", bean.getData_center());
				hm.put("active_net_name", bean.getActive_net_name());
				data_center_items.add(hm);
				
			}
			
			paramMap.put("data_center_items", data_center_items);			
			
			output.addObject("searchItemList",emCtmInfoService.dGetDashBoard_appList(paramMap));			

		}
		if("dash03".equals(searchType)){
				
			List dataCenterList = CommonUtil.getDataCenterList();
		
			ArrayList<Map> data_center_items = new ArrayList();
			for (int i = 0; i < dataCenterList.size(); i++) {
				CommonBean bean = (CommonBean) dataCenterList.get(i);

				Map<String, Object> hm = new HashMap();
				hm.put("data_center_code", bean.getData_center_code());
				hm.put("data_center", bean.getData_center());
				hm.put("active_net_name", bean.getActive_net_name());
				data_center_items.add(hm);
			}
			paramMap.put("data_center_items", data_center_items);
			
			output.addObject("searchItemList",emCtmInfoService.dGetDashBoard_nodeList(paramMap));
		}
		
		
		
		return output;
	}
	
	
	@SuppressWarnings({ "unchecked" })
	public ModelAndView ezBoardList(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception{
		
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);		
		paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
		paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
						
		ModelAndView output = null;
		output = new ModelAndView("works/C06/main_contents/noticeList");
		output.addObject("S_DATE", CommonUtil.getCurDateTo(CommonUtil.toDate(), -90));
		output.addObject("E_DATE", CommonUtil.toDate());
						
    	return output;
	}

	@SuppressWarnings({ "unchecked" })
	public ModelAndView ezBoardInfo(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception{
		
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		
		//BoardBean board_info = commonService.dGetBoardInfo(paramMap);
		
		ModelAndView output = null;
		output = new ModelAndView("common/board/boardInsert");
		//output.addObject("boardInfo", board_info);
				
    	return output;
	}
	
	@SuppressWarnings({ "unchecked", "unused" })
	public ModelAndView ezBoardInsert(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception{
	
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		
		ModelAndView output = null;
		output = new ModelAndView("common/board/boardInsert");
				
    	return output;
	}
	
	@SuppressWarnings("unchecked")
	public ModelAndView ezBoardPrc(HttpServletRequest req, HttpServletResponse res, BoardBean board) throws ServletException, IOException, Exception{
		
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
		paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));		
		paramMap.put("ins_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		paramMap.put("title", CommonUtil.replaceStrHtml((String)CommonUtil.isNull(paramMap.get("title"))));
		paramMap.put("content", CommonUtil.replaceStrHtml((String)CommonUtil.isNull(paramMap.get("content"))));
		
		Map<String, Object> rMap = new HashMap<>();
		String flag = CommonUtil.isNull(paramMap.get("flag"));
		
		if(!flag.equals("")){
			rMap = commonService.dPrcBoard(paramMap, req, board);
		}
				
		ModelAndView output = null;
		output = new ModelAndView("result/t_result");
		output.addObject("rMap", rMap);
				
    	return output;
	}
	
	@SuppressWarnings("unchecked")
	public void ezBoardNoti(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception{
		
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		
		List<BoardBean> list = commonService.dGetBoardNoti(paramMap);
		int tot_cnt = list.size();
		
		if(tot_cnt > 0){
		
			//디비에 노티 여부 플래그 변경
			for(int i=0;i<tot_cnt;i++){
				paramMap.put("board_cd", list.get(i).getBoard_cd());
				paramMap.put("noti_yn", "Y");
								
				try{
					commonService.dPrcBoard(paramMap, req, null);
				}catch(Exception e){
					e.getMessage();
				}
			}
						
			//개수화면에 리턴
			this.returnXML("<status>"+tot_cnt+"</status>", res);
		}else{
			//개수화면에 리턴
			this.returnXML("<status>0</status>", res);
		}
		
	}
	
	@SuppressWarnings({ "unused", "unchecked" })
	public ModelAndView ezBoardNotiOpen(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception{
		
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		
		ModelAndView output = null;
		output = new ModelAndView("common/board/boardNotice");
		output.addObject("tot_cnt", "10");
		
		return output;
	}
	
	@SuppressWarnings("unchecked")
	public ModelAndView ezHolidayList(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception{
		
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		
		paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
		paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		
		String currentPage 	= CommonUtil.isNull(paramMap.get("currentPage"), "1");
		String rowCnt 		= CommonUtil.isNull(paramMap.get("rowCnt"), CommonUtil.isNull(req.getSession().getAttribute("DEFAULT_PAGING")));
		int rowSize 		= 0;

		if ( !rowCnt.equals("") ) {
			rowSize = Integer.parseInt(rowCnt);
		} else {
			rowSize = Integer.parseInt(CommonUtil.getMessage("PAGING.ROWSIZE.BASIC"));
		}	

		int pageSize = Integer.parseInt(CommonUtil.getMessage("PAGING.PAGESIZE.BASIC"));
		
		CommonBean commBean = commonService.dGetHolidayListCnt(paramMap);
		logger.info("total_cnt==============================>"+commBean.getTotal_count());
		Paging paging = new Paging(commBean.getTotal_count(), rowSize, pageSize, currentPage);
		paramMap.put("startRowNum", paging.getStartRowNum());
    	paramMap.put("endRowNum", paging.getEndRowNum());
		    	
		List<HolidayBean> holiday_list = commonService.dGetHolidayList(paramMap);
		
		Map<String, String> day_map = null;
		List<HolidayBean> dayList = commonService.dGetHolidayDayList(paramMap);
		if(dayList.size() > 0){
			day_map = new HashMap<>();
			for(int i=0;i<dayList.size();i++){
				day_map.put(dayList.get(i).getYyyymmdd(), dayList.get(i).getYyyymmdd());
			}
		}
				
		ModelAndView output = null;
		output = new ModelAndView("common/holiday/holidayList");
		output.addObject("holidayList", holiday_list);
		output.addObject("Paging", paging);
		output.addObject("totalCount", paging.getTotalRowSize());
		output.addObject("rowSize", rowSize);
		output.addObject("dayMap", day_map);
				
    	return output;
	}

	@SuppressWarnings({ "unchecked", "deprecation" })
	public void fileDownload(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception{
		
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		
		try{
			
			String file_path 	= req.getRealPath(CommonUtil.getMessage("MENUAL_FILE.PATH"));
			String flag 		= CommonUtil.isNull(paramMap.get("flag"));
			String file_gb 		= CommonUtil.isNull(paramMap.get("file_gb"));
			String data_center 	= CommonUtil.isNull(paramMap.get("data_center"));
			String doc_cd 		= CommonUtil.isNull(paramMap.get("doc_cd"));
			
			String file_nm 		= "";
			String file_nm2 	= "";
			
			if(flag.equals("board")){
				file_path += "/board_file";			
				List<BoardBean> board = commonService.dGetBoardInfo(paramMap);
				file_nm = CommonUtil.isNull(board.get(0).getFile_nm());
				
			}else if(flag.equals("job_doc01")){
				
				file_path += "/attach_file/" + doc_cd;
				JobMapperBean bean = commonService.dGetDocFileInfo(paramMap);
				
				if ( file_gb.equals("1") ) {
//					file_nm 	= CommonUtil.isNull(bean.getAttach_file());
					file_nm 	= CommonUtil.isNull(paramMap.get("file_nm"));
				} else if ( file_gb.equals("2") ) {
					//file_nm 	= CommonUtil.isNull(bean.getErrfiles());
				}
				
			}else if(flag.equals("job_doc06")){
				file_path += "/attach_file";
				Doc06Bean bean = commonService.dGetDoc06FileInfo(paramMap);
				file_nm = CommonUtil.isNull(bean.getFile_nm());
			}else if(flag.equals("susi_sample")){
				file_path += "/doc_files";
				file_nm = CommonUtil.isNull(CommonUtil.getMessage("susi.excel.sample"));
			}else if(flag.equals("defJobExport")){
				file_path += "/joblist";
				
				Date dt = new Date();
				SimpleDateFormat sf = new SimpleDateFormat("yyyyMMdd");
				String ymd = sf.format(dt);
				
				file_nm = "activejoblist_"+data_center+"_"+ymd+".txt";
			}else if(flag.equals("excel_sample")){
				file_path += "/doc_files/sample";
				file_nm = CommonUtil.isNull(CommonUtil.getMessage("excel.sample"));
			}
			
			logger.debug("#CommonController | fileDownload | file_path :::"+file_path);
			logger.debug("#CommonController | fileDownload | file_nm :::"+file_nm);
			paramMap.put("file_nm", file_nm);
			paramMap.put("file_path", file_path);			
			
			File file = null;
				
				file = new File(file_path+"/"+file_nm);
				
				res.setContentType("application/x-msdownload;");
				res.setHeader("Content-Type", "application/octet-stream; charset=UTF-8");
				res.setHeader("Content-Disposition", "attachment; filename="+java.net.URLEncoder.encode(file_nm,"UTF-8").replaceAll("\\+","%20"));
			
			OutputStream out = res.getOutputStream();
			FileInputStream fis = null;
			try{
				fis = new FileInputStream(file);
				FileCopyUtils.copy(fis, out);
			}finally{
				if(fis != null){
					try{
						fis.close();
					}catch(IOException ex){
						ex.getMessage();
					}
				}
				out.flush();
				out.close();
			}			
			
		}catch(Exception e){
			e.getMessage();
		}
		
	}
	
	public void fileCheck(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception{
		
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		
		try{
			
			String file_path = req.getRealPath(CommonUtil.getMessage("MENUAL_FILE.PATH"));
			String data_center = CommonUtil.isNull(paramMap.get("data_center"));
			String file_nm = "";
			String flag = CommonUtil.isNull(paramMap.get("flag"));
			String return_flag = "";
			
			if(flag.equals("defJobExport")){
				file_path += "/joblist";
				
				Date dt = new Date();
				SimpleDateFormat sf = new SimpleDateFormat("yyyyMMdd");
				String ymd = sf.format(dt);
				
				file_nm = "activejoblist_"+data_center+"_"+ymd+".txt";
				logger.info("#CommonController | fileCheck | file_nm :::"+file_nm);
				logger.info("#CommonController | fileCheck | file_path :::"+file_path);
				
				File file = new File(file_path, file_nm);
				if(file.exists()){
					return_flag = "Y";
				}
			}
			
			JsUtil.getJsonString(return_flag, res);			
			
		}catch(Exception e){
			e.getMessage();
		}
	}
	
	public void returnXML(String returnTags, HttpServletResponse res)
			throws Exception {
		StringBuffer result = new StringBuffer();
		result.append("<?xml version=\"1.0\" encoding=\"utf-8\" ?>");
		result.append("<ajax-response>");
		result.append("<response>");
		result.append(returnTags);
		result.append("</response>");
		result.append("</ajax-response>");
		res.setContentType("text/xml;charset=utf-8");
		// response.setCharacterEncoding("utf-8");
		res.setHeader("Cache-Control", "no-cache");
		res.getWriter().write(result.toString());

	}
	
	@SuppressWarnings({ "unchecked", "unused", "rawtypes" })
	public ModelAndView cData(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception{
		
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		String c = CommonUtil.isNull(paramMap.get("c"));
		String itemGb = CommonUtil.isNull(paramMap.get("itemGb"));
		
		String strItemGubun = CommonUtil.isNull(paramMap.get("itemGubun"));
		//세션에서 가져올 데이터가 없어보임
		paramMap.put("ss_user_ip", CommonUtil.isNull(req.getSession().getAttribute("SS_USER_IP")));
		paramMap.put("ss_user_cd", CommonUtil.isNull(req.getSession().getAttribute("SS_USER_CD")));
		//추가
		paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("S_USER_IP")));
		paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("S_USER_CD")));
		paramMap.put("s_user_gb", CommonUtil.isNull(req.getSession().getAttribute("S_USER_GB")));
		
		// 폴더 다중 검색(김선중 24.02.02)
		String p_sched_table = CommonUtil.isNull(paramMap.get("p_sched_table"));
		String p_sched_table_out = CommonUtil.isNull(paramMap.get("p_sched_table_out"));
		
		if (!"".equals(p_sched_table)) {

			String search_text = CommonUtil.isNull(paramMap.get("p_sched_table"));
			System.out.println(search_text);
			ArrayList<String> p_search_text_folder_list = new ArrayList<String>();
			for (String text : search_text.split(",")) {
				p_search_text_folder_list.add(text);

			}

			int totalElements = p_search_text_folder_list.size();
			paramMap.put("p_search_text_folder_list", p_search_text_folder_list);
		}
		
		if (!"".equals(p_sched_table_out)) {

			String search_text_out = CommonUtil.isNull(paramMap.get("p_sched_table_out"));
			System.out.println(search_text_out);
			ArrayList<String> p_search_text_folder_list = new ArrayList<String>();
			for (String text : search_text_out.split(",")) {
				p_search_text_folder_list.add(text);

			}

			int totalElements = p_search_text_folder_list.size();
			paramMap.put("p_search_text_folder_list", p_search_text_folder_list);
		}
		
		//어플리케이션 다중 검색 및 제외(신한캐피탈 23.03.29)
		String p_application_of_def_text = CommonUtil.isNull(paramMap.get("p_application_of_def_text"));

		if (!"".equals(p_application_of_def_text)) {

			String search_text = CommonUtil.isNull(paramMap.get("p_application_of_def_text"));
			System.out.println(search_text);
			ArrayList<String> p_search_text_list = new ArrayList<String>();
			for (String text : search_text.split(",")) {
				p_search_text_list.add(text);

			}

			int totalElements = p_search_text_list.size();
			paramMap.put("p_search_text_list", p_search_text_list);
		}

		// 작업명 다중 검색(부산은행 24.12.04)
		String p_search_text2 = CommonUtil.isNull(paramMap.get("p_search_text2"));
		String p_search_gubun2 = CommonUtil.isNull(paramMap.get("p_search_gubun2"));
		if (!"".equals(p_search_text2) && "job_name".equals(p_search_gubun2)) {
			System.out.println(p_search_text2);
			ArrayList<String> p_search_job_name_list = new ArrayList<String>();
			for (String text : p_search_text2.split(",")) {
				p_search_job_name_list.add(text);
			}
			int totalElements = p_search_job_name_list.size();
			paramMap.put("p_search_job_name_list", p_search_job_name_list);
		}

		Map<String, Object> rMap 	= new HashMap<String, Object>();
		
		ModelAndView output = null;
		try{
			
			paramMap.put("INS_USER_IP", CommonUtil.isNull(req.getSession().getAttribute("S_USER_IP")));
			
			String strDataCenter = CommonUtil.isNull(paramMap.get("data_center"));
			
			if ( !strDataCenter.equals("") ) {
				
				// C-M 정보 가져오기
				paramMap.put("data_center", strDataCenter);
				CommonBean commonbean 	= emBatchResultTotalService.dGetDataCenterInfoAjob(paramMap);
								
				if ( commonbean != null ) {
					paramMap.put("data_center_code", 	CommonUtil.isNull(commonbean.getData_center_code()));
					paramMap.put("active_net_name", 	CommonUtil.isNull(commonbean.getActive_net_name()));
				}
			} else if(itemGb.equals("batchResultTotalList2")) {
				paramMap.put("searchType", "dataCenterList");
				paramMap.put("mcode_cd", "M6");
				List dataCenterList = commonService.dGetSearchItemList(paramMap);

				ArrayList<Map> data_center_items = new ArrayList();
				for (int i = 0; i < dataCenterList.size(); i++) {
					CommonBean bean2 = (CommonBean) dataCenterList.get(i);

					Map<String, Object> hm = new HashMap();
					hm.put("data_center_code", bean2.getData_center_code());
					hm.put("data_center", bean2.getData_center());
					hm.put("active_net_name", bean2.getActive_net_name());
					data_center_items.add(hm);
				}

				paramMap.put("data_center_items", data_center_items);
			}
			
			List itemList = commonService.dGetItemList(paramMap, req);
			
			if(strItemGubun.equals("2")){
				output = new ModelAndView("itemXml2");
			}else{
				output = new ModelAndView("itemXml");
			}
			if(itemGb.equals("folderAppGrpList")) {
				//폴더권한복사(김은희)
				List folderAppGrpList = commonService.dGetItemList(paramMap, req);
				output.addObject("folderAppGrpList",CommonUtil.setRowNums(folderAppGrpList,null));
			}
			
			output.addObject("itemList",CommonUtil.setRowNums(itemList,null));
		}catch(Exception e){
			//logger.error("[itemGb:"+itemGb+"][Exception] : " , e);
			output = new ModelAndView("itemXmlErr");
			//output.addObject("msg_code","ERROR.500");
			output.addObject("msg_code", "[itemGb:"+itemGb+"][에러 발생]");
		}
			
    	return output;
    	
	}
	
	@SuppressWarnings("unchecked")
	public void cData2(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception{
		
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		String c = CommonUtil.isNull(paramMap.get("c"));
		String itemGb = CommonUtil.isNull(paramMap.get("itemGb"));
		
		// jobLogList를 Json 방식으로 바꾸면서 itemGb을 중복 선언해서 오류 발생.
		// itemGb2로 선언 후 itemGb으로 다시 셋팅.
		String itemGb2 = CommonUtil.isNull(paramMap.get("itemGb2"));
		
		if ( !itemGb2.equals("") ) {
			itemGb = itemGb2;
		}
		
		//세션에서 가져올 데이터가 없어보임
		paramMap.put("ss_user_ip", CommonUtil.isNull(req.getSession().getAttribute("SS_USER_IP")));
		paramMap.put("ss_user_cd", CommonUtil.isNull(req.getSession().getAttribute("SS_USER_CD")));
		//추가
		paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("S_USER_IP")));
		paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("S_USER_CD")));
		paramMap.put("s_user_gb", CommonUtil.isNull(req.getSession().getAttribute("S_USER_GB")));
		
		// 폴더 다중 검색(김선중 24.02.02)
		String p_sched_table = CommonUtil.isNull(paramMap.get("p_sched_table"));
		if (!"".equals(p_sched_table)) {

			String search_text = CommonUtil.isNull(paramMap.get("p_sched_table"));
			System.out.println(search_text);
			ArrayList<String> p_search_text_folder_list = new ArrayList<String>();
			for (String text : search_text.split(",")) {
				p_search_text_folder_list.add(text);

			}

			int totalElements = p_search_text_folder_list.size();
			paramMap.put("p_search_text_folder_list", p_search_text_folder_list);
		}
		
		//어플리케이션 다중 검색 및 제외(신한캐피탈 23.03.29)
		String p_application_of_def_text = CommonUtil.isNull(paramMap.get("p_application_of_def_text"));

		if (!"".equals(p_application_of_def_text)) {

			String search_text = CommonUtil.isNull(paramMap.get("p_application_of_def_text"));
			System.out.println(search_text);
			ArrayList<String> p_search_text_list = new ArrayList<String>();
			for (String text : search_text.split(",")) {
				p_search_text_list.add(text);

			}

			int totalElements = p_search_text_list.size();
			paramMap.put("p_search_text_list", p_search_text_list);
		}

		// 작업명 다중 검색(부산은행 24.12.04)
		String p_search_text2 = CommonUtil.isNull(paramMap.get("p_search_text2"));
		String p_search_gubun2 = CommonUtil.isNull(paramMap.get("p_search_gubun2"));
		if (!"".equals(p_search_text2) && "job_name".equals(p_search_gubun2)) {
			System.out.println(p_search_text2);
			ArrayList<String> p_search_job_name_list = new ArrayList<String>();
			for (String text : p_search_text2.split(",")) {
				p_search_job_name_list.add(text);
			}
			int totalElements = p_search_job_name_list.size();
			paramMap.put("p_search_job_name_list", p_search_job_name_list);
		}

		JSONArray arr = new JSONArray();
		JSONObject obj = null;
		
		if(itemGb.equals("emDefJobs")){
//			paramMap.put("p_sched_table", CommonUtil.isNull(paramMap.get("p_sched_table")).replaceAll("&apos;","\'"));
//			String strApplicationOfDef = CommonUtil.isNull(paramMap.get("p_application_of_def")).replaceAll("&apos;","\'");
//			paramMap.put("p_application_of_def", strApplicationOfDef);
			String strScodeNm = CommonUtil.isNull(paramMap.get("p_scode_nm")).replaceAll("&apos;","\'");
			paramMap.put("p_scode_nm", strScodeNm);
			paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
			paramMap.put("s_user_gb", CommonUtil.isNull(req.getSession().getAttribute("USER_GB")));
			paramMap.put("s_dept_cd", CommonUtil.isNull(req.getSession().getAttribute("DEPT_CD")));
			List<DefJobBean> list = emDefJobsService.dGetDefJobList(paramMap);		
			
			DefJobBean defJobListCnt = emDefJobsService.dGetDefJobListCnt(paramMap);
			String defJobCnt = String.valueOf(defJobListCnt.getTotal_cnt());
			
			for(int i=0;i<list.size();i++){
				com.ghayoun.ezjobs.m.domain.DefJobBean bean = list.get(i);
				
				String doc_state = CommonUtil.isNull(bean.getDoc_state());
				String doc_cd    = "";
				String state_cd  = "";
				if(!doc_state.equals("")) {
					String[] arr_doc_state = doc_state.split(",", -1);
					doc_cd 	 = arr_doc_state[0];
					state_cd = arr_doc_state[1];
				}
				
				
				obj = new JSONObject();
				obj.put("SCHED_TABLE", 			CommonUtil.isNull(bean.getSched_table()));
				obj.put("APPLICATION", 			CommonUtil.isNull(bean.getApplication()));
				obj.put("GROUP_NAME", 			CommonUtil.isNull(bean.getGroup_name()));
				obj.put("JOB_NAME", 			CommonUtil.isNull(bean.getJob_name()));
				obj.put("MEM_NAME", 			CommonUtil.isNull(bean.getMemname()));
				obj.put("USER_NM", 				CommonUtil.isNull(bean.getUser_nm()));
				obj.put("MANAGER_NM", 			CommonUtil.isNull(bean.getUser_nm2()));
				obj.put("NODE_GRP", 			CommonUtil.isNull(bean.getNode_grp()));
				obj.put("CYCLIC", 				CommonUtil.isNull(bean.getCyclic()));
				obj.put("FROM_TIME", 			CommonUtil.isNull(bean.getFrom_time()));
				obj.put("JOBSCHEDGB", 			CommonUtil.isNull(bean.getJobSchedGb()));
				obj.put("ERROR_DESCRIPTION", 	CommonUtil.isNull(bean.getError_description()));
				obj.put("DESCRIPTION", 			CommonUtil.isNull(bean.getDescription()));
				obj.put("INS_DATE", 			CommonUtil.isNull(bean.getIns_date()));
				obj.put("JOB_ID", 				CommonUtil.isNull(bean.getJob_id()));
				obj.put("TABLE_ID", 			CommonUtil.isNull(bean.getTable_id()));
				obj.put("AUTHOR", 				CommonUtil.isNull(bean.getAuthor()));
				obj.put("TASK_TYPE", 			CommonUtil.isNull(bean.getTask_type()));
				obj.put("PREV_DOC_INFO", 		CommonUtil.isNull(bean.getPrev_doc_info()));
				obj.put("USER_DAILY", 			CommonUtil.isNull(bean.getUser_daily()));
				obj.put("CC_COUNT", 			CommonUtil.isNull(bean.getCc_count()));
				obj.put("CMJOB_TRANSFER", 		CommonUtil.isNull(bean.getCmjob_transfer()));
				obj.put("SMART_JOB_YN", 		CommonUtil.isNull(bean.getSmart_job_yn()));
				obj.put("WHEN_COND", 			CommonUtil.isNull(bean.getWhen_cond()));
				obj.put("SHOUT_TIME", 			CommonUtil.isNull(bean.getShout_time()));
				obj.put("APPL_TYPE", 			CommonUtil.isNull(bean.getAppl_type()));
				obj.put("DOC_CD", 				doc_cd);
				obj.put("STATE_CD", 			state_cd);
				obj.put("STATE_NM", 			CommonUtil.getMessage("DOC.STATE."+state_cd));
				obj.put("DEFJOBCNT", 			defJobCnt);
				
				
				arr.add(obj);
			}		
			
		} else if(itemGb.equals("jobLogList")) {
			
			paramMap.put("active_net_name", 		CommonUtil.getCtmActiveNetName(paramMap));
			paramMap.put("p_sched_table", 			CommonUtil.isNull(paramMap.get("p_sched_table")).replaceAll("&apos;","\'"));
//			paramMap.put("p_application_of_def", 	CommonUtil.isNull(paramMap.get("p_application_of_def")).replaceAll("&apos;","\'"));
			paramMap.put("p_scode_nm", 				CommonUtil.isNull(paramMap.get("p_scode_nm")).replaceAll("&apos;","\'"));
			paramMap.put("s_user_cd", 				CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
			paramMap.put("s_user_gb", 				CommonUtil.isNull(req.getSession().getAttribute("USER_GB")));
			
			// data_center 조건에 INSTR, SUBSTR 등의 함수때문에 속도느림현상 발생
			// 해당 쿼리를 시작으로 다른 쿼리들도 data_center 조건의 변경이 필요해 보임 (2025.1.14 강명준)
			String strDataCenter = CommonUtil.isNull(paramMap.get("data_center"));
			if ( strDataCenter.contains(",") ) { 
				paramMap.put("real_data_center", strDataCenter.split(",")[1]);
			}
			
			List<JobLogBean> list = emJobLogService.dGetJobLogList(paramMap);
			
			JobLogBean jobLogListCnt = emJobLogService.dGetJobLogListCnt(paramMap);
			String jobLogCnt = String.valueOf(jobLogListCnt.getTotal_count());
			
			for(int i=0;i<list.size();i++){
				JobLogBean bean = list.get(i);
				
				String from_time = CommonUtil.isNull(bean.getFrom_time());
				if(!from_time.equals("")){
					from_time = from_time.substring(0,2)+":"+from_time.substring(2,4);
				}
				
				String end_time = CommonUtil.isNull(CommonUtil.getDateFormat(1,CommonUtil.isNull(bean.getEnd_time())),"-");
				String end_date = end_time.length() > 8 ? end_time.substring(0,8) : end_time;
				
				String pop_gb = "";
				String color = CommonUtil.getMessage("JOB_STATUS_COLOR."+CommonUtil.isNull(bean.getState_result()).replaceAll(" ","_"));
				String state_result = "";
				String state_result2 = "";
				if(CommonUtil.isNull(bean.getHoldflag()).equals("Y")){
					state_result2 += "<span style='color:red'>[HOLD]</span>";
				}
									
				if( CommonUtil.isNull(bean.getActive_gb()).equals("1") && CommonUtil.isNull(bean.getState_result(), "").equals("Wait Condition") || CommonUtil.isNull(bean.getState_result(), "").equals("Wait Time") ){
					state_result += "<font color='"+color+"'>"+CommonUtil.getMessage("JOB_STATUS."+CommonUtil.isNull(bean.getState_result()).replaceAll(" ","_"))+"</font>";
					state_result += state_result2;
					pop_gb = "wait";
				}else{
					state_result += "<font color='"+color+"'>"+CommonUtil.getMessage("JOB_STATUS."+CommonUtil.isNull(bean.getState_result()).replaceAll(" ","_"))+"</font>";
					state_result += state_result2;
					pop_gb = "job";
				}
				
				// 불필요한 로직인거 같아서 주석 처리 2023.05.28 강명준
				/*String mem_name = "";
				if(CommonUtil.isNull(bean.getMemname()).equals("")){
					mem_name = "CMD";
				}else{
					mem_name = CommonUtil.isNull(bean.getMemname());
				}*/
				
				String strApplication 	= CommonUtil.isNull(bean.getApplication());
				String strDeptNm 		= CommonUtil.isNull(bean.getDept_nm());
				String strCalendarNm 	= CommonUtil.isNull(bean.getCalendar_nm());
				String strTaskType		= CommonUtil.isNull(bean.getTask_type());
				String strOrderTable	= CommonUtil.isNull(bean.getOrder_table());
				String strGroupName 	= CommonUtil.isNull(bean.getGroup_name());
				String strJobschedgb	= CommonUtil.isNull(bean.getJobschedgb());
				String strSusiCnt		= CommonUtil.isNull(bean.getSusi_cnt());
				/*String strInsNm1		= CommonUtil.isNull(bean.getIns_nm1());
				String strApprovalNm1	= CommonUtil.isNull(bean.getApproval_nm1());
				String strApprovalNm2	= CommonUtil.isNull(bean.getApproval_nm2());*/
				
				obj = new JSONObject();
				
				obj.put("ODATE", 			CommonUtil.getDateFormat(1,"20"+CommonUtil.isNull(bean.getOdate())));
				obj.put("START_TIME", 		CommonUtil.isNull(CommonUtil.getDateFormat(1,CommonUtil.isNull(bean.getStart_time())),"-"));
				obj.put("END_TIME", 		CommonUtil.isNull(CommonUtil.getDateFormat(1,CommonUtil.isNull(bean.getEnd_time())),"-"));					
				obj.put("RUN_TIME", 		CommonUtil.isNull(CommonUtil.getDiffTime( CommonUtil.getDateFormat(1, bean.getStart_time()), CommonUtil.getDateFormat(1,bean.getEnd_time()))));
				obj.put("DIFF_TIME", 		CommonUtil.isNull(bean.getAvg_run_time()));
				obj.put("RUN_CNT", 			CommonUtil.isNull(bean.getRerun_counter(),"0"));
				obj.put("USER_NM", 			CommonUtil.isNull(bean.getUser_nm()));
				obj.put("JOB_NAME",			CommonUtil.isNull(bean.getJob_name()));
				obj.put("DESCRIPTION", 		CommonUtil.isNull(bean.getDescription()));
				obj.put("NODE_ID", 			CommonUtil.isNull(bean.getNode_id()));
				obj.put("NODE_GROUP", 		CommonUtil.isNull(bean.getNode_group()));
				obj.put("STATE_RESULT", 	state_result);
				obj.put("FROM_TIME", 		from_time);
				obj.put("ORDER_ID", 		CommonUtil.isNull(bean.getOrder_id()));
				obj.put("HOLD_FLAG", 		CommonUtil.isNull(bean.getHoldflag()));
				obj.put("ACTIVE_GB", 		CommonUtil.isNull(bean.getActive_gb()));
				obj.put("MEM_NAME", 		CommonUtil.isNull(bean.getMemname()));
				obj.put("ORI_STATE_RESULT", CommonUtil.isNull(bean.getState_result()));
				obj.put("POP_GB", 			pop_gb);
				obj.put("END_DATE", 		end_date);
				obj.put("TASK_TYPE", 		strTaskType);
				obj.put("TABLE_NAME", 		strOrderTable);
				obj.put("APPLICATION", 		strApplication);
				obj.put("GROUP_NAME", 		strGroupName);
				obj.put("DEPT_NM", 			strDeptNm);
				obj.put("CALENDAR_NM", 		strCalendarNm);
				obj.put("JOBSCHEDGB", 		strJobschedgb);
				obj.put("USER_DAILY", 		CommonUtil.isNull(bean.getUser_daily()));
				obj.put("JOBLOGCNT", 		jobLogCnt);
				obj.put("USER_ID1", 		CommonUtil.isNull(bean.getUser_id()));
				obj.put("USER_ID2", 		CommonUtil.isNull(bean.getUser_id2()));
				obj.put("USER_ID3", 		CommonUtil.isNull(bean.getUser_id3()));
				obj.put("USER_ID4", 		CommonUtil.isNull(bean.getUser_id4()));
				obj.put("USER_ID5", 		CommonUtil.isNull(bean.getUser_id5()));
				obj.put("USER_ID6", 		CommonUtil.isNull(bean.getUser_id6()));
				obj.put("USER_ID7", 		CommonUtil.isNull(bean.getUser_id7()));
				obj.put("USER_ID8", 		CommonUtil.isNull(bean.getUser_id8()));
				obj.put("JOBLOGCNT", 		jobLogCnt);
				obj.put("AVG_RUN_TIME",		CommonUtil.isNull(bean.getAvg_run_time()));
				obj.put("SUSI_CNT", 		strSusiCnt);
				/*obj.put("INS_NM1", 			strInsNm1);
				obj.put("APPROVAL_NM1", 	strApprovalNm1);
				obj.put("APPROVAL_NM2", 	strApprovalNm2);*/
				obj.put("SYSOUT_YN", 		CommonUtil.isNull(bean.getSysout_yn()));
				obj.put("APPL_TYPE", 		CommonUtil.isNull(bean.getAppl_type()));
				obj.put("LATE_EXEC", 		CommonUtil.isNull(bean.getLate_exec()));
				obj.put("SMART_JOB_YN", 	CommonUtil.isNull(bean.getSmart_job_yn()));
				
				arr.add(obj);
			}
		
		} else if(itemGb.equals("jobLogHistoryList")) {
			
			paramMap.put("active_net_name", 		CommonUtil.getCtmActiveNetName(paramMap));
			paramMap.put("p_sched_table", 			CommonUtil.isNull(paramMap.get("p_sched_table")).replaceAll("&apos;","\'"));
//			paramMap.put("p_application_of_def", 	CommonUtil.isNull(paramMap.get("p_application_of_def")).replaceAll("&apos;","\'"));
			paramMap.put("p_scode_nm", 				CommonUtil.isNull(paramMap.get("p_scode_nm")).replaceAll("&apos;","\'"));
			paramMap.put("s_user_cd", 				CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
			paramMap.put("s_user_gb", 				CommonUtil.isNull(req.getSession().getAttribute("USER_GB")));
			
			// 멀티 상태 선택
			String p_status = CommonUtil.isNull(paramMap.get("p_status"));
			if(p_status.indexOf("Held") > -1) {
				p_status = p_status.replaceAll("Held,", "");
				paramMap.put("Held", "Held");
			}
			ArrayList<String> statusList = new ArrayList<>(Arrays.asList(p_status.split("\\s*,\\s*")));
			paramMap.put("statusList", statusList);

			List<JobLogBean> list = emJobLogService.dGetJobLogHistoryList(paramMap);
			
			JobLogBean jobLogHistoryListCnt = emJobLogService.dGetJobLogHistoryListCnt(paramMap);
		
			String jobLogCnt = String.valueOf(jobLogHistoryListCnt.getTotal_cnt());
			
			for(int i=0;i<list.size();i++){
				JobLogBean bean = list.get(i);
				
				String from_time = CommonUtil.isNull(bean.getFrom_time());
				if(!from_time.equals("")){
					from_time = from_time.substring(0,2)+":"+from_time.substring(2,4);
				}
				
				String end_time = CommonUtil.isNull(CommonUtil.getDateFormat(1,CommonUtil.isNull(bean.getEnd_time())),"-");
				String end_date = end_time.length() > 8 ? end_time.substring(0,8) : end_time;
				
				String pop_gb = "";
				String color = CommonUtil.getMessage("JOB_STATUS_COLOR."+CommonUtil.isNull(bean.getState_result()).replaceAll(" ","_"));
				String state_result = "";
				String state_result2 = "";
				if(CommonUtil.isNull(bean.getHoldflag()).equals("Y")){
					state_result2 += "<span style='color:red'>[HOLD]</span>";
				}
									
				if( CommonUtil.isNull(bean.getActive_gb()).equals("1") && CommonUtil.isNull(bean.getState_result(), "").equals("Wait Condition") || CommonUtil.isNull(bean.getState_result(), "").equals("Wait Time") ){
					state_result += "<font color='"+color+"'>"+CommonUtil.getMessage("JOB_STATUS."+CommonUtil.isNull(bean.getState_result()).replaceAll(" ","_"))+"</font>";
					state_result += state_result2;
					pop_gb = "wait";
				}else{
					state_result += "<font color='"+color+"'>"+CommonUtil.getMessage("JOB_STATUS."+CommonUtil.isNull(bean.getState_result()).replaceAll(" ","_"))+"</font>";
					state_result += state_result2;
					pop_gb = "job";
				}

				if(CommonUtil.isNull(bean.getHoldflag()).equals("Y")){
					color = CommonUtil.getMessage("JOB_STATUS_COLOR."+CommonUtil.isNull(bean.getStatus()).replaceAll(" ","_"));
					state_result2 = "<font color='"+color+"'>"+CommonUtil.getMessage("JOB_STATUS."+CommonUtil.isNull(bean.getStatus().replaceAll(" ","_")))+"</font>";
					state_result = "<img src='/imgs/icon/hold.png' width='13'> "+state_result2 ;
				}

				String strTaskType		= CommonUtil.isNull(bean.getTask_type());
				String strApplication 	= CommonUtil.isNull(bean.getApplication());
				String strDeptNm 		= CommonUtil.isNull(bean.getDept_nm());
				String strCalendarNm 	= CommonUtil.isNull(bean.getCalendar_nm());
				String strOrderTable	= CommonUtil.isNull(bean.getOrder_table());
				String strGroupName 	= CommonUtil.isNull(bean.getGroup_name());
				String strJobschedgb	= CommonUtil.isNull(bean.getJobschedgb());
				String strSusiCnt		= CommonUtil.isNull(bean.getSusi_cnt());
				/*String strInsNm1		= CommonUtil.isNull(bean.getIns_nm1());
				String strApprovalNm1	= CommonUtil.isNull(bean.getApproval_nm1());
				String strApprovalNm2	= CommonUtil.isNull(bean.getApproval_nm2());*/
				
				obj = new JSONObject();
				
				obj.put("ODATE", 			CommonUtil.getDateFormat(1,"20"+CommonUtil.isNull(bean.getOdate())));
				obj.put("START_TIME", 		CommonUtil.isNull(CommonUtil.getDateFormat(1,CommonUtil.isNull(bean.getStart_time())),"-"));
				obj.put("END_TIME", 		CommonUtil.isNull(CommonUtil.getDateFormat(1,CommonUtil.isNull(bean.getEnd_time())),"-"));					
				obj.put("RUN_TIME", 		CommonUtil.isNull(CommonUtil.getDiffTime( CommonUtil.getDateFormat(1, bean.getStart_time()), CommonUtil.getDateFormat(1,bean.getEnd_time()))));
				obj.put("DIFF_TIME", 		CommonUtil.isNull(bean.getAvg_run_time()));
				obj.put("RUN_CNT", 			CommonUtil.isNull(bean.getRerun_counter(),"0"));
				obj.put("USER_NM", 			CommonUtil.isNull(bean.getUser_nm()));
				obj.put("JOB_NAME",			CommonUtil.isNull(bean.getJob_name()));
				obj.put("DESCRIPTION", 		CommonUtil.isNull(bean.getDescription()));
				obj.put("NODE_ID", 			CommonUtil.isNull(bean.getNode_id()));
				obj.put("STATE_RESULT", 	state_result);
				obj.put("FROM_TIME", 		from_time);
				obj.put("ORDER_ID", 		CommonUtil.isNull(bean.getOrder_id()));
				obj.put("HOLD_FLAG", 		CommonUtil.isNull(bean.getHoldflag()));
				obj.put("ACTIVE_GB", 		CommonUtil.isNull(bean.getActive_gb()));
				obj.put("MEM_NAME", 		CommonUtil.isNull(bean.getMemname()));
				obj.put("ORI_STATE_RESULT", CommonUtil.isNull(bean.getState_result()));
				obj.put("POP_GB", 			pop_gb);
				obj.put("END_DATE", 		end_date);
				obj.put("TASK_TYPE", 		strTaskType);
				obj.put("TABLE_NAME", 		strOrderTable);
				obj.put("APPLICATION", 		strApplication);
				obj.put("GROUP_NAME", 		strGroupName);
				obj.put("DEPT_NM", 			strDeptNm);
				obj.put("CALENDAR_NM", 		strCalendarNm);
				obj.put("JOBSCHEDGB", 		strJobschedgb);
				obj.put("USER_DAILY", 		CommonUtil.isNull(bean.getUser_daily()));
				obj.put("JOBLOGCNT", 		jobLogCnt);
				obj.put("USER_ID1", 		CommonUtil.isNull(bean.getUser_id()));
				obj.put("USER_ID2", 		CommonUtil.isNull(bean.getUser_id2()));
				obj.put("USER_ID3", 		CommonUtil.isNull(bean.getUser_id3()));
				obj.put("USER_ID4", 		CommonUtil.isNull(bean.getUser_id4()));
				obj.put("USER_ID5", 		CommonUtil.isNull(bean.getUser_id5()));
				obj.put("USER_ID6", 		CommonUtil.isNull(bean.getUser_id6()));
				obj.put("USER_ID7", 		CommonUtil.isNull(bean.getUser_id7()));
				obj.put("USER_ID8", 		CommonUtil.isNull(bean.getUser_id8()));
				obj.put("USER_ID9", 		CommonUtil.isNull(bean.getUser_id9()));
				obj.put("USER_ID10", 		CommonUtil.isNull(bean.getUser_id10()));
				obj.put("JOBLOGCNT", 		jobLogCnt);
				obj.put("CRITICAL", 		CommonUtil.isNull(bean.getCritical_yn()));
				obj.put("AVG_RUN_TIME",		CommonUtil.isNull(bean.getAvg_run_time()));
				obj.put("SUSI_CNT", 		strSusiCnt);
				/*obj.put("INS_NM1", 			strInsNm1);
				obj.put("APPROVAL_NM1", 	strApprovalNm1);
				obj.put("APPROVAL_NM2", 	strApprovalNm2);*/
				obj.put("SYSOUT_YN", 		CommonUtil.isNull(bean.getSysout_yn()));
				obj.put("APPL_TYPE", 		CommonUtil.isNull(bean.getAppl_type()));
				obj.put("SMART_JOB_YN", 	CommonUtil.isNull(bean.getSmart_job_yn()));
				
				arr.add(obj);
			}
		}else if(itemGb.equals("emJobGroupDefJobList")) {

			String strScodeNm = CommonUtil.isNull(paramMap.get("p_scode_nm")).replaceAll("&apos;","\'");
			paramMap.put("p_scode_nm", strScodeNm);
			
			paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
			paramMap.put("s_user_gb", CommonUtil.isNull(req.getSession().getAttribute("USER_GB")));
			paramMap.put("s_dept_cd", CommonUtil.isNull(req.getSession().getAttribute("DEPT_CD")));
			
			List<DefJobBean> list 				= emDefJobsService.dGetJobGroupDefJobList(paramMap);
			DefJobBean jobGroupDefJobListCnt 	= emDefJobsService.dGetJobGroupDefJobListCnt(paramMap);
			
			String defJobCnt = String.valueOf(jobGroupDefJobListCnt.getTotal_cnt());
			
			for ( int i = 0; i < list.size(); i++ ) {
				
				com.ghayoun.ezjobs.m.domain.DefJobBean bean = list.get(i);
				
				obj = new JSONObject();
				obj.put("DATA_CENTER", 			CommonUtil.isNull(bean.getData_center()));
				obj.put("SCHED_TABLE", 			CommonUtil.isNull(bean.getSched_table()));
				obj.put("APPLICATION", 			CommonUtil.isNull(bean.getApplication()));
				obj.put("GROUP_NAME", 			CommonUtil.isNull(bean.getGroup_name()));
				obj.put("JOB_NAME", 			CommonUtil.isNull(bean.getJob_name()));
				obj.put("MEM_NAME", 			CommonUtil.isNull(bean.getMemname()));
				obj.put("USER_NM", 				CommonUtil.isNull(bean.getUser_nm()));
				obj.put("NODE_GRP", 			CommonUtil.isNull(bean.getNode_grp()));
				obj.put("CYCLIC", 				CommonUtil.isNull(bean.getCyclic()));
				obj.put("FROM_TIME", 			CommonUtil.isNull(bean.getFrom_time()));
				obj.put("JOBSCHEDGB", 			CommonUtil.isNull(bean.getJobSchedGb()));
				obj.put("ERROR_DESCRIPTION", 	CommonUtil.isNull(bean.getError_description()));
				obj.put("DESCRIPTION", 			CommonUtil.isNull(bean.getDescription()));
				obj.put("INS_DATE", 			CommonUtil.isNull(bean.getIns_date()));
				obj.put("JOB_ID", 				CommonUtil.isNull(bean.getJob_id()));
				obj.put("TABLE_ID", 			CommonUtil.isNull(bean.getTable_id()));
				obj.put("AUTHOR", 				CommonUtil.isNull(bean.getAuthor()));
				obj.put("TASK_TYPE", 			CommonUtil.isNull(bean.getTask_type()));
				obj.put("PREV_DOC_INFO", 		CommonUtil.isNull(bean.getPrev_doc_info()));
				obj.put("USER_DAILY", 			CommonUtil.isNull(bean.getUser_daily()));
				obj.put("DEFJOBCNT", 			defJobCnt);
				obj.put("DAYS_CAL", 			CommonUtil.isNull(bean.getDays_cal()));
				
				arr.add(obj);
			}		
			
		} else if(itemGb.equals("getConPro")) {
			
			paramMap.put("mcode_cd", "M6");
			List dataCenterCodeList = commonService.dGetsCodeList(paramMap);
			CommonBean commonBean 	= (CommonBean) dataCenterCodeList.get(0);
			String server			= commonBean.getScode_eng_nm();
			paramMap.put("server", server);
			
			emConnectionProfileDao 	= (EmConnectionProfileDao) CommonUtil.getSpringBean("tEmConnectionProfileDao");
			org.json.JSONObject Conpro = emConnectionProfileDao.prcConnectionProfileDao(paramMap);
			
			String strType			= CommonUtil.isNull(paramMap.get("type"));
			
			logger.debug("strType ::::: " + strType);
			logger.debug("API 결과 ::::: " + Conpro.toString());
			
			//kubernetes와 mft(FileTransfer)에 따라 분기 처리
			if(strType.equals("Kubernetes")) {
				List<String> keysList = new ArrayList<>();

				Iterator<String> keys = Conpro.keys();
		        while (keys.hasNext()) {
		            String key = keys.next();
		            keysList.add(key);
		        }
				
		        for ( int i = 0; i < keysList.size(); i++ ) {
		        	obj = new JSONObject();
		        	
		        	if(!"message".equals(keysList.get(i))){
		        		obj.put("PROFILE_NAME", keysList.get(i));
		        		arr.add(obj);
		        	}
		        }
			}else if(strType.equals("FileTransfer")) {
				List<String> keysList = new ArrayList<>();

				Iterator<String> keys = Conpro.keys();
				
				String keyName = "";
//				arr.add(Conpro.get(keysList.get(i)));
				
				if (Conpro.has("errors")) {
		        	
		        	org.json.JSONArray errorsArray = Conpro.getJSONArray("errors");
		            for (int i = 0; i < errorsArray.length(); i++) {
		                arr.add(errorsArray.getJSONObject(i));
		            }
		        }else {
				
			        while (keys.hasNext()) {
			            String key = keys.next();
			            
			            //key값 message는 제외
			            if(!key.equals("message")) { 
				            String typeValue = Conpro.getJSONObject(key).getString("Type");
				            //type 중 DualEndPoint의 key 값만 리스트로 담는다. 
				            if(typeValue.indexOf("DualEndPoint") > -1) {
				            	keysList.add(key);
				            }
			            }
			        }
					
			        for ( int i = 0; i < keysList.size(); i++ ) {
			        	obj = new JSONObject();
			        	keyName = keysList.get(i);
	//		        	arr.add(Conpro.get(keysList.get(i)));
		        		obj.put(keyName, Conpro.get(keysList.get(i)));
		        		arr.add(obj);
		        		System.out.println("arr.get(i) : "+arr.get(i));
			        }
		        }
		        
			}else if(strType.equals("Database")) {
				// List 및 JSONArray 생성
		        List<String> keysList = new ArrayList<>();
		        
		        // "errors" 처리 우선
		        if (Conpro.has("errors")) {
		        
		        	System.out.println("여기탐 1111111111111111111111");
		        	
		        	
		        	org.json.JSONArray errorsArray = Conpro.getJSONArray("errors");
		        	 // "errors" 데이터를 arr에 추가
		            for (int i = 0; i < errorsArray.length(); i++) {
		                arr.add(errorsArray.getJSONObject(i));
		            }
		        }else {
		        	System.out.println("여기탐 2222222222222222222222");
			        // 최상위 키를 keysList에 추가
			        Iterator<String> keys = Conpro.keys();
			        while (keys.hasNext()) {
			            String key = keys.next();
			            keysList.add(key);
			        }
	
			        // keysList 순회하여 처리
			        for (String key : keysList) {
			            if (!"message".equals(key)) { // "message" 제외
			                obj = new JSONObject();
			                obj.put("PROFILE_NAME", key); // "PROFILE_NAME"에 현재 키 추가
			                // 내부 JSON 데이터 추가
			                if (Conpro.get(key) instanceof org.json.JSONObject) { // 내부가 JSONObject인지 확인
			                    org.json.JSONObject innerObject = Conpro.getJSONObject(key);
	
			                    // innerObject의 키-값 순회
			                    Iterator<String> innerKeys = innerObject.keys();
			                    while (innerKeys.hasNext()) {
			                        String innerKey = innerKeys.next();
			                        obj.put(innerKey, innerObject.get(innerKey)); // 내부 키-값 추가
			                    }
			                }
	
			                arr.add(obj); // 최종 객체를 JSONArray에 추가
			            }
			        }
			    }
			}
	        
		} else if(itemGb.equals("getSchema")) {
			
			List databaseList= new ArrayList();
			paramMap.put("profile_name", CommonUtil.isNull(paramMap.get("db_con_pro")));
			paramMap.put("searchType", "databaseList");
			databaseList = commonService.dGetSearchItemList(paramMap);
			
			String strDbType		= CommonUtil.isNull(paramMap.get("database_type"));
			String strDbUser		= CommonUtil.isNull(paramMap.get("db_user"));
			String strDbNm			= CommonUtil.isNull(paramMap.get("database"));
			String strSid			= CommonUtil.isNull(paramMap.get("sid"));
			String strServiceName	= CommonUtil.isNull(paramMap.get("service_name"));
			String strDbHost		= CommonUtil.isNull(paramMap.get("db_host"));
			String strDbPort		= CommonUtil.isNull(paramMap.get("db_port"));
			String strDbPassword	= "";
			
			for(int i=0; i<databaseList.size(); i++) {
				CommonBean bean = (CommonBean) databaseList.get(i);
				strDbPassword = CommonUtil.isNull(bean.getDatabase_pw());
			
				Connection con 			= null;
				PreparedStatement pstmt = null;
				ResultSet rs 			= null;
				String sql 				= "";
				String strDbUrl			= "";
				obj = new JSONObject();
	        	
				try {
					if(strDbType.equals("PostgreSQL")) {
						strDbUrl 		= "jdbc:postgresql://"+strDbHost+":"+strDbPort+"/"+strDbNm;
						Class.forName("org.postgresql.Driver");
						
						sql = 	"SELECT n.nspname AS schema_name ";
						sql += 	" FROM pg_catalog.pg_namespace n ";
						sql += 	" LEFT JOIN pg_catalog.pg_roles u ON n.nspowner = u.oid ";
						sql += 	" WHERE u.rolname = ? ";
						sql += 	" AND n.nspname NOT LIKE 'pg_%' ";
						sql += 	" AND n.nspname <> 'information_schema' ";
						sql += 	" ORDER BY n.nspname ";
						
					}else {
						Class.forName("core.log.jdbc.driver.OracleDriver");
						if(!strSid.equals("") && !strSid.equals("undefined")) {
							strDbUrl			= "jdbc:oracle:thin:@"+strDbHost+":"+strDbPort+":"+strSid;
						}else if(!strServiceName.equals("") || !strServiceName.equals("undefined")) {
							strDbUrl			= "jdbc:oracle:thin:@"+strDbHost+":"+strDbPort+"/"+strServiceName;
						}
						sql = 	"SELECT USERNAME AS schema_name ";
						sql += 	" FROM ALL_USERS ";
						sql += 	" WHERE UPPER(USERNAME) = UPPER(?) ";
						sql += 	" AND USERNAME NOT LIKE 'SYS%' ";
						sql += 	" AND USERNAME NOT IN ('SYSTEM', 'SYS') ";
						sql += 	" ORDER BY USERNAME ";
					}
					
					System.out.println("strDbUrl : " + strDbUrl);
					System.out.println("sql : " + sql);
					
					con 		= DriverManager.getConnection(strDbUrl, strDbUser, SeedUtil.decodeStr(strDbPassword));
					
					try {
						
						pstmt 	= con.prepareStatement(sql);
						pstmt.setString(1, strDbUser);
						
						rs		= pstmt.executeQuery();
						
						if (!rs.next()) {
				            logger.debug("No data found for user: " + strDbUser);
				        } else {
				            do {
				                String schema = CommonUtil.isNull(rs.getString("schema_name"));
				                
				                obj.put("schema", schema);
				        		arr.add(obj);
				        		
				            } while (rs.next());
				        }
	
			        } catch (Exception e) {
						e.printStackTrace();
					} finally {
						try {
							pstmt.close();
					        con.close();
					        rs.close();
						} catch (SQLException e) {
							e.printStackTrace();
						}
					}
					
					
				} catch (ClassNotFoundException e) {
					
					e.printStackTrace();
				}
			}
		}else if(itemGb.equals("getSpList")) {
			
			List databaseList= new ArrayList();
			paramMap.put("profile_name", CommonUtil.isNull(paramMap.get("db_con_pro")));
			paramMap.put("searchType", "databaseList");
			databaseList = commonService.dGetSearchItemList(paramMap);
			
			String strDbType		= CommonUtil.isNull(paramMap.get("database_type"));
			String strDbUser		= CommonUtil.isNull(paramMap.get("db_user"));
			String strDbNm			= CommonUtil.isNull(paramMap.get("database"));
			String strSid			= CommonUtil.isNull(paramMap.get("sid"));
			String strServiceName	= CommonUtil.isNull(paramMap.get("service_name"));
			String strDbHost		= CommonUtil.isNull(paramMap.get("db_host"));
			String strDbPort		= CommonUtil.isNull(paramMap.get("db_port"));
			String strDbPassword	= "";
			
			for(int i=0; i<databaseList.size(); i++) {
				CommonBean bean = (CommonBean) databaseList.get(i);
				strDbPassword = CommonUtil.isNull(bean.getDatabase_pw());
			
				Connection con 			= null;
				PreparedStatement pstmt = null;
				ResultSet rs 			= null;
				String sql 				= "";
				String strDbUrl			= "";
				
	        	
				try {
					if(strDbType.equals("PostgreSQL")) {
						strDbUrl 		= "jdbc:postgresql://"+strDbHost+":"+strDbPort+"/"+strDbNm;
						Class.forName("org.postgresql.Driver");
						
						sql = 	" select p.proname AS procedure, n.nspname AS schema_name, ";
						sql += 	" STRING_AGG(CASE WHEN pm.mode = 'o' THEN  pm.data_type END, ', ') AS return_value, ";
						sql += 	" STRING_AGG(CASE WHEN pm.mode = 'i' OR pm.mode IS NULL THEN pm.data_type END, ', ' ) AS in_parameters ";
						sql += 	" FROM pg_catalog.pg_proc p ";
						sql += 	" LEFT JOIN pg_catalog.pg_namespace n ON n.oid = p.pronamespace ";
						sql += 	" LEFT JOIN LATERAL ( SELECT UNNEST(p.proargmodes) AS mode, UNNEST(p.proargnames) AS name, UNNEST(STRING_TO_ARRAY(pg_catalog.pg_get_function_arguments(p.oid), ', ')) AS data_type) pm ON TRUE ";
						sql += 	" where n.nspname = ? ";
						sql += 	" AND p.prokind = 'p' ";
						sql += 	" GROUP BY p.proname, n.nspname ";
						
					}else {
						Class.forName("core.log.jdbc.driver.OracleDriver");
						if(!strSid.equals("") && !strSid.equals("undefined")) {
							strDbUrl			= "jdbc:oracle:thin:@"+strDbHost+":"+strDbPort+":"+strSid;
						}else if(!strServiceName.equals("") || !strServiceName.equals("undefined")) {
							strDbUrl			= "jdbc:oracle:thin:@"+strDbHost+":"+strDbPort+"/"+strServiceName;
						}
						
						sql = 	" SELECT  p.OBJECT_NAME AS procedure, p.OWNER AS schema_name, ";
						sql += 	" LISTAGG(CASE WHEN a.IN_OUT = 'OUT' THEN 'OUT ' || a.ARGUMENT_NAME || ' ' || a.DATA_TYPE END, ', ') WITHIN GROUP (ORDER BY a.POSITION) AS return_value, ";
						sql += 	" LISTAGG(CASE WHEN a.IN_OUT = 'IN' OR a.IN_OUT IS NULL THEN 'IN ' || a.ARGUMENT_NAME || ' ' || a.DATA_TYPE END, ', ') WITHIN GROUP (ORDER BY a.POSITION) AS in_parameters ";
						sql += 	" FROM ALL_PROCEDURES p ";
						sql += 	" LEFT JOIN ALL_ARGUMENTS a ON p.OWNER = a.OWNER AND p.OBJECT_NAME = a.OBJECT_NAME ";
						sql += 	" WHERE UPPER(p.OWNER) = UPPER(?) ";
						sql += 	" AND p.OBJECT_TYPE = 'PROCEDURE' ";
						sql += 	" GROUP BY p.OBJECT_NAME, p.OWNER ";
						sql += 	" ORDER BY p.OBJECT_NAME ";
					}
					
					con 		= DriverManager.getConnection(strDbUrl, strDbUser, SeedUtil.decodeStr(strDbPassword));
					
					try {
						
						pstmt 	= con.prepareStatement(sql);
						pstmt.setString(1, strDbUser);
						
						rs		= pstmt.executeQuery();
						
						if (!rs.next()) {
				            logger.debug("No data found for user: " + strDbUser);
				        } else {
				            do {
				            	obj = new JSONObject();
				            	
				                String procedure		= CommonUtil.isNull(rs.getString("procedure"));
				                String schema 			= CommonUtil.isNull(rs.getString("schema_name"));
				                String return_value 	= CommonUtil.isNull(rs.getString("return_value"));
				                String in_parameters 	= CommonUtil.isNull(rs.getString("in_parameters"));
				                System.out.println("procedure: " + procedure);
				                
				                obj.put("procedure", procedure);
				                obj.put("schema", schema);
				                obj.put("return_value", return_value);
				                obj.put("in_parameters", in_parameters);
				        		arr.add(obj);
				        		
				            } while (rs.next());
				        }
	
			        } catch (Exception e) {
						e.printStackTrace();
					} finally {
						try {
							pstmt.close();
					        con.close();
					        rs.close();
						} catch (SQLException e) {
							e.printStackTrace();
						}
					}
					
					
				} catch (ClassNotFoundException e) {
					
					e.printStackTrace();
				}
			}
		}
		
		JsUtil.getJsonString(arr.toJSONString(), res);
    	
	}
	
	@SuppressWarnings({ "unchecked", "unused" })
	public ModelAndView ezComCode(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception{
		
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		String c = CommonUtil.isNull(paramMap.get("c"));
				
		ModelAndView output = null;
		output = new ModelAndView("works/C06/main_contents/comCodeList");

		return output;
	}
	
	@SuppressWarnings({ "unchecked", "unused" })
	public ModelAndView ezComCode_p(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception{
		
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		String c = CommonUtil.isNull(paramMap.get("c"));
		String flag = CommonUtil.isNull(paramMap.get("flag"));
		String code_gubun = CommonUtil.isNull(paramMap.get("code_gubun"));
		String mcode_cd = CommonUtil.isNull(paramMap.get("mcode_cd"));
		String host_cd = CommonUtil.isNull(paramMap.get("host_cd"));
				
		Map<String, Object> rMap = new HashMap<>();
		
		try{
			
			paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
			rMap.put("flag", flag);
								
			if(flag.equals("ins")){
				
				if(code_gubun.equals("M")){
					rMap = commonService.dPrcMcodeInsert(paramMap);
				}else if(code_gubun.equals("S") || code_gubun.equals("H")){
					rMap = commonService.dPrcScodeInsert(paramMap);
				}
				
				rMap.put("mcode_cd", mcode_cd);		
				rMap.put("code_gubun", code_gubun);
				rMap.put("host_cd", host_cd);
			}else if(flag.equals("udt")){
				
				if(code_gubun.equals("M")){
					rMap = commonService.dPrcMcodeUpdate(paramMap);
				}else if(code_gubun.equals("S") || code_gubun.equals("H")){
					rMap = commonService.dPrcScodeUpdate(paramMap);
				}
				
				rMap.put("mcode_cd", mcode_cd);				
				rMap.put("code_gubun", code_gubun);
				rMap.put("host_cd", host_cd);
			}else if(flag.equals("del")){
				
				if(code_gubun.equals("S") || code_gubun.equals("H")){
					rMap = commonService.dPrcScodeDelete(paramMap);
				}else if(code_gubun.equals("M")){
					rMap = commonService.dPrcMcodeUpdate(paramMap);
				}
				
				rMap.put("mcode_cd", mcode_cd);				
				rMap.put("code_gubun", code_gubun);
				rMap.put("host_cd", host_cd);
			}else if(flag.equals("group_udt")) {
				if(code_gubun.equals("S") || code_gubun.equals("H")){
					rMap = commonService.dPrcScodeGroupUpdate(paramMap);
				}
				rMap.put("mcode_cd", mcode_cd);				
				rMap.put("code_gubun", code_gubun);
				rMap.put("host_cd", host_cd);
			}
		}catch(Exception e){
			e.getMessage();
		}
		
		ModelAndView output = null;
		output = new ModelAndView("result/t_result");
		output.addObject("rMap", rMap);
		
		return output;
	}
	
	@SuppressWarnings({ "unused", "unchecked" })
	public ModelAndView ezAppGrp(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception{
		
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		String c = CommonUtil.isNull(paramMap.get("c"));
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
						
		ModelAndView output = null;
		output = new ModelAndView("works/C06/main_contents/appGrpCodeList");
		output.addObject("SCODE_GRP_LIST", 		CommonUtil.getComScodeList(paramMap));
		output.addObject("HOST_LIST", 			CommonUtil.getHostList());
		
				
		return output;
	}
	
	@SuppressWarnings({ "unchecked", "unused" })
	public ModelAndView ezAppGrp_p(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception{
	
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		paramMap.put("grp_ins_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
		paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
		paramMap.put("user_gb", CommonUtil.isNull(req.getSession().getAttribute("USER_GB")));
		
		String c = CommonUtil.isNull(paramMap.get("c"));
		String flag = CommonUtil.isNull(paramMap.get("flag"));
		String grp_depth = CommonUtil.isNull(paramMap.get("grp_depth"));
		String grp_parent_cd = CommonUtil.isNull(paramMap.get("grp_parent_cd"));
		String scode_cd = CommonUtil.isNull(paramMap.get("scode_cd"));
		String host_cds = CommonUtil.isNull(paramMap.get("host_cd"));
		String[] host_cd = host_cds.split(",");

		Map<String, Object> rMap = new HashMap<>();
		
		try{
						
			if(flag.equals("ins")){
				  
				if(grp_depth.equals("1")){
					paramMap.put("grp_parent_cd", "0");
				}
				
				paramMap.put("v_host_cd", "0");
				rMap = commonService.dPrcAppGrpInsert(paramMap);
				
				if(rMap.get("r_code").equals("1")){
					rMap = commonService.dPrcGrpHostInsert(paramMap);
				}
				
			}else if(flag.equals("udt")){
				String grp_eng_nm = CommonUtil.isNull(paramMap.get("grp_eng_nm"));
				String orgin_nm = CommonUtil.isNull(paramMap.get("orgin_nm"));
				
				if(!orgin_nm.equals(grp_eng_nm)) {
					DefJobBean activeJobListCnt 	= emDefJobsService.dGetActiveJobListCnt(paramMap);
					
					int defJobCnt = Integer.parseInt(activeJobListCnt.getTotal_cnt());
					
					if(defJobCnt > 0 ) {
						rMap.put("r_code", "-1");
						rMap.put("defJobCnt", defJobCnt);
						rMap.put("r_msg", "ERROR.78");
					}else {
						String arr_host_cd = "";
						String[] v_host_cd = req.getParameterValues("v_host_cd");
						
						if(v_host_cd != null){
							if(v_host_cd.length > 0){
								for(int i=0;i<v_host_cd.length;i++){
									if(i>0) arr_host_cd += ",";
									arr_host_cd += v_host_cd[i];
								}
								
								if(!host_cds.equals("")){
									arr_host_cd = arr_host_cd.equals("") ? host_cds : arr_host_cd+","+host_cds;
								}
							}else{
								arr_host_cd = host_cds;
							}
						}else{
							arr_host_cd = host_cds;
						}
						
						paramMap.put("arr_host_cd", arr_host_cd);
						
						rMap = commonService.dPrcAppGrpUpdate(paramMap);
					}
				}else {
					String arr_host_cd = "";
					String[] v_host_cd = req.getParameterValues("v_host_cd");
					
					if(v_host_cd != null){
						if(v_host_cd.length > 0){
							for(int i=0;i<v_host_cd.length;i++){
								if(i>0) arr_host_cd += ",";
								arr_host_cd += v_host_cd[i];
							}
							
							if(!host_cds.equals("")){
								arr_host_cd = arr_host_cd.equals("") ? host_cds : arr_host_cd+","+host_cds;
							}
						}else{
							arr_host_cd = host_cds;
						}
					}else{
						arr_host_cd = host_cds;
					}
					
					paramMap.put("arr_host_cd", arr_host_cd);
					rMap = commonService.dPrcAppGrpUpdate(paramMap);
				}
			}else if(flag.equals("del")){
				Map<String, Object> rMap2 = new HashMap<>();
				rMap2.put("flag",			flag);
				rMap2.put("scode_cd", 		scode_cd);
				rMap2.put("grp_depth", 		grp_depth);
				rMap2.put("SCHEMA", 		CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
				rMap2.put("grp_ins_user_cd",CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
				rMap2.put("s_user_cd", 		CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
				rMap2.put("user_gb", 		CommonUtil.isNull(req.getSession().getAttribute("USER_GB")));
				
				//폴더 삭제
				if(grp_depth.equals("1")) {
					String[] grp_cd_list 			= CommonUtil.isNull(paramMap.get("grp_cd_list")).split(",,");
					String[] folder_nm_list 		= CommonUtil.isNull(paramMap.get("folder_nm_list")).split(",,");
					
					//선택된 폴더 만큼 삭제 for문
					for(int i=0;i<folder_nm_list.length;i++) {
						logger.debug("grp_cd 	::::: " + grp_cd_list[i]);
						logger.debug("folder_nm ::::: " + folder_nm_list[i]);
						
						rMap2.put("grp_cd", 		grp_cd_list[i]);
						rMap2.put("grp_parent_cd", 	CommonUtil.isNull(paramMap.get("grp_parent_cd")));
						rMap2.put("folder_nm", 		folder_nm_list[i]);
						
						DefJobBean activeJobListCnt 	= emDefJobsService.dGetActiveJobListCnt(rMap2);
						
						int defJobCnt = Integer.parseInt(activeJobListCnt.getTotal_cnt());
						logger.debug("등록된 작업 수 ::::: " + defJobCnt);
						
						//해당 폴더에 등록된 작업이 없을때만 삭제 진행
						if(defJobCnt == 0 ) {
							rMap = commonService.dPrcAppGrpDelete(rMap2);
						}
					}
				//어플리케이션 삭제
				}else if(grp_depth.equals("2")) {
					String[] grp_cd_list 			= CommonUtil.isNull(paramMap.get("grp_cd_list")).split(",,");
					String[] application_nm_list 	= CommonUtil.isNull(paramMap.get("application_nm_list")).split(",,");
					
					for(int i=0;i<application_nm_list.length;i++) {
						logger.debug("grp_cd		 ::::: " + grp_cd_list[i]);
						logger.debug("application_nm ::::: " + application_nm_list[i]);
						
						rMap2.put("grp_cd", 		grp_cd_list[i]);
						rMap2.put("grp_parent_cd", 	CommonUtil.isNull(paramMap.get("grp_parent_cd")));
						rMap2.put("folder_nm", 		CommonUtil.isNull(paramMap.get("folder_nm")));
						rMap2.put("application_nm", application_nm_list[i]);
						
						DefJobBean activeJobListCnt 	= emDefJobsService.dGetActiveJobListCnt(rMap2);
						
						int defJobCnt = Integer.parseInt(activeJobListCnt.getTotal_cnt());
						logger.debug("등록된 작업 수 ::::: " + defJobCnt);
						
						//등록된 작업이 없는 어플리케이션만 삭제 진행
						if(defJobCnt == 0 ) {
							rMap = commonService.dPrcAppGrpDelete(rMap2);
						}
					}
				//그룹 삭제
				}else if(grp_depth.equals("3")) {
					String[] grp_cd_list 			= CommonUtil.isNull(paramMap.get("grp_cd_list")).split(",,");
					String[] group_nm_list 			= CommonUtil.isNull(paramMap.get("group_nm_list")).split(",,");
					
					for(int i=0;i<grp_cd_list.length;i++) {
						logger.debug("grp_cd 	::::: " + grp_cd_list[i]);
						logger.debug("group_nm  ::::: " + group_nm_list[i]);
						
						rMap2.put("grp_cd", 		grp_cd_list[i]);
						rMap2.put("grp_parent_cd", 	CommonUtil.isNull(paramMap.get("grp_parent_cd")));
						rMap2.put("folder_nm", 		CommonUtil.isNull(paramMap.get("folder_nm")));
						rMap2.put("application_nm", CommonUtil.isNull(paramMap.get("application_nm")));
						rMap2.put("group_nm", 		group_nm_list[i]);
						
	//					DefJobBean activeJobListCnt 	= emDefJobsService.dGetActiveJobListCnt(paramMap);
						DefJobBean activeJobListCnt 	= emDefJobsService.dGetActiveJobListCnt(rMap2);
						
						int defJobCnt = Integer.parseInt(activeJobListCnt.getTotal_cnt());
						logger.debug("등록된 작업 수 ::::: " + defJobCnt);
						
						//등록된 작업이 없는 그룹만 삭제 진행
						if(defJobCnt == 0 ) {
							rMap = commonService.dPrcAppGrpDelete(rMap2);
						}
					}
				}
			}else if(flag.equals("host_udt")) {
			
				rMap = commonService.dPrcGrpHostUpdate(paramMap);

			}else if(flag.equals("host_del")) {
				
				rMap = commonService.dPrcGrpHostsDelete(paramMap);
				
			}

			rMap.put("flag", flag);
			rMap.put("scode_cd", scode_cd);
			rMap.put("grp_depth", grp_depth);
			rMap.put("grp_cd", grp_parent_cd);
			
		}catch(Exception e){
			e.getMessage();
		}
		
		ModelAndView output = null;
		output = new ModelAndView("result/t_result");
		output.addObject("rMap", rMap);
		
		return output;
	}
	
	@SuppressWarnings({ "unchecked", "unused" })
	public ModelAndView ezAppGrp_excel_p(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception{
	
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		
		paramMap.put("SCHEMA", 			CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		paramMap.put("s_user_cd", 		CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
		paramMap.put("user_gb", 		CommonUtil.isNull(req.getSession().getAttribute("USER_GB")));
		
		String c 				= CommonUtil.isNull(paramMap.get("c"));
		String flag 			= CommonUtil.isNull(paramMap.get("flag"));
		
		Map<String, Object> rMap = new HashMap<>();
		
		try {
			rMap = commonService.dPrcAppGrpExcelInsert(paramMap);
			
		}catch(DefaultServiceException e) {
			rMap = e.getResultMap();
		}
		ModelAndView output = null;
		output = new ModelAndView("result/t_result");
		output.addObject("rMap", rMap);
		
		return output;
	}
	
	public ModelAndView ezAppGrp_excel_form(HttpServletRequest req, HttpServletResponse res)throws ServletException, IOException, Exception {
		
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
		paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		ModelAndView output = null;
		
		output = new ModelAndView("contents/appGrpCodeListExcelForm");
		
		return output;

	}
	
	public ModelAndView ezCtmAgent(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception{
		
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		
		String c = CommonUtil.isNull(paramMap.get("c"));
		
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		
		String cm = CommonUtil.getMessage("DATA.CENTER.CODE");
						
		ModelAndView output = null;
		output = new ModelAndView("works/C06/main_contents/ctmAgentList");
		output.addObject("DATA_CENTER", CommonUtil.getComScodeList(paramMap));
										
		return output;
	}
	
	public ModelAndView ezSendLogList(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception{
		
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		List sendGb = null;
		
		String c = CommonUtil.isNull(paramMap.get("c"));
		
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		
		String cm = CommonUtil.getMessage("DATA.CENTER.CODE");
		
		paramMap.put("mcode_cd", "M51");
		sendGb = commonService.dGetsCodeList(paramMap);
						
		ModelAndView output = null;
		output = new ModelAndView("works/C06/main_contents/sendLogList");
		output.addObject("DATA_CENTER", CommonUtil.getComScodeList(paramMap));
		output.addObject("cm", CommonUtil.getComScodeList(paramMap));
		output.addObject("sendGb", sendGb);		
										
		return output;
	}
	
	@SuppressWarnings("unchecked")
	public ModelAndView ezCtmAgent_p(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception{
		
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		
		String flag = CommonUtil.isNull(paramMap.get("flag"));
	
		Map<String, Object> rMap = new HashMap<>();
		
		try{
			
			if(flag.equals("udt")){
				rMap = commonService.dPrcCtmAgentInfoUpdate(paramMap);
			}
			
		}catch(Exception e){
			e.getMessage();
		}
						
		ModelAndView output = null;
		output = new ModelAndView("result/t_result");
		output.addObject("rMap", rMap);
										
		return output;
	}
	
	public ModelAndView ezSmartForderList(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception{
		
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		
		paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
		paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		
		ModelAndView output = null;
		output = new ModelAndView("works/C06/main_contents/smartForderList");
		output.addObject("SCODE_GRP_LIST", 		CommonUtil.getComScodeList(paramMap));
		output.addObject("HOST_LIST", 			CommonUtil.getHostList());
		
		return output;
	}
	
	public ModelAndView ezQuartzList(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception{
		
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		
		paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
		paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		
		ModelAndView output = new ModelAndView("works/C06/main_contents/quartzList");
		return output;
	}
	//EzJobs배치조회 > 재실행
	public ModelAndView ezQuartzList_p(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception{

		Map<String, Object> paramMap = CommonUtil.collectParameters(req);

		paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
		paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		
		String flag = CommonUtil.isNull(paramMap.get("flag"));
		
		Map<String, Object> rMap = new HashMap();
		
		if (flag.equals("EZ_HISTORY_001")) {
			EzHistoryJobServiceImpl ezTestJobServiceImpl = new EzHistoryJobServiceImpl();
			rMap = ezTestJobServiceImpl.ezHistoryJobServiceImplCall("001");
		} else if (flag.equals("EZ_HISTORY_002")) {
			EzHistoryJobServiceImpl ezTestJobServiceImpl = new EzHistoryJobServiceImpl();
			rMap = ezTestJobServiceImpl.ezHistoryJobServiceImplCall("002");
		} else if (flag.equals("EZ_ALARM")) {
			EzSmsJobServiceImpl ezTestJobServiceImpl = new EzSmsJobServiceImpl();
			rMap = ezTestJobServiceImpl.ezSmsJobServiceImplCall();
		} else if (flag.equals("EZ_LOG_DEL")) {
			EzLogDeleteJobServiceImpl ezLogDeleteJobServiceImpl = new EzLogDeleteJobServiceImpl();
			rMap = ezLogDeleteJobServiceImpl.ezLogDeleteJobServiceImplCall();
		} else if (flag.equals("EZ_USER_INFO")) {
			EzUserInfoGetJobServiceImpl ezUserInfoGetJobServiceImpl = new EzUserInfoGetJobServiceImpl();
			rMap = ezUserInfoGetJobServiceImpl.ezUserInfoGetJobServiceImplCall();
		}else if (flag.equals("EZ_RPLNJOB_001")) {
			EzRplnJobServiceImpl ezRplnJobServiceImpl = new EzRplnJobServiceImpl();
			rMap = ezRplnJobServiceImpl.ezRplnJobServiceImplCall("001");
		} else if (flag.equals("EZ_RPLNJOB_002")) {
			EzRplnJobServiceImpl ezRplnJobServiceImpl = new EzRplnJobServiceImpl();
			rMap = ezRplnJobServiceImpl.ezRplnJobServiceImplCall("002");
		} else if (flag.equals("EZ_PRE_DATE_BATCH")) {
			EzPreDateBatchCallJobServiceImpl ezPreDateBatchCallJobServiceImpl = new EzPreDateBatchCallJobServiceImpl();
			rMap = ezPreDateBatchCallJobServiceImpl.ezPreDateBatchCallJobServiceImplCall();
		//엑셀일괄 재반영시 반영대기로 변경될경우 쿼츠로 일정 주기로 동작하게 할때 사용
//		} else if (flag.equals("EZ_EXCEL_BATCH")) {
//			EzExcelBatchQuartzServiceImpl ezExcelBatchQuartzServiceImpl = new EzExcelBatchQuartzServiceImpl();
//			rMap = ezExcelBatchQuartzServiceImpl.ezExcelBatchQuartzServiceImplCall();
		} else if (flag.equals("EZ_AVG_TIME")) {
			EzAvgTimeJobServiceImpl ezAvgTimeJobServiceImpl = new EzAvgTimeJobServiceImpl();
			rMap = ezAvgTimeJobServiceImpl.EzAvgTimeJobServiceImplCall();
		}else if (flag.equals("EZ_RESOURCE")) {
			EzResourceJobServiceImpl ezResourceJobServiceImpl = new EzResourceJobServiceImpl();
			rMap = ezResourceJobServiceImpl.ezResourceJobServiceImplCall();
		} else if (flag.equals("EZ_AVG_OVERTIME")) {
			EzAvgTimeOverJobServiceImpl ezAvgTimeOverJobServiceImplCall = new EzAvgTimeOverJobServiceImpl();
			rMap = ezAvgTimeOverJobServiceImplCall.EzAvgTimeOverJobServiceImplCall();
		} else if (flag.equals("EZ_SYS_UDT")) {
			EzJobSysServiceImpl ezJobSysServiceImpl = new EzJobSysServiceImpl();
			rMap = ezJobSysServiceImpl.ezJobSysServiceImplCall();
		//Control-M API 호출
		} else if (flag.equals("EZ_API_CALL")) {
			EzJobAttemptServiceImpl ezJobAttemptServiceImpl = new EzJobAttemptServiceImpl();
			rMap = ezJobAttemptServiceImpl.EzJobAttemptServiceImplCall(null);
		}  else if (flag.equals("EZ_DELETED_JOB_ALARM")) {
			EzDeletedJobServiceImpl ezDeletedJobServiceImpl = new EzDeletedJobServiceImpl();
			rMap = ezDeletedJobServiceImpl.ezDeletedJobServiceImplCall();
		}

		ModelAndView output = new ModelAndView("result/t_result");
		output.addObject("rMap", rMap);
		return output;
	}
	
	public ModelAndView ezDbSql(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception{
		
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		
		paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
		paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		
		ModelAndView output = new ModelAndView("works/C06/main_contents/dbSql");
		return output;
	}
	
	public void sqlRun(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception{
		
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		
		paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
		paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		
		com.ghayoun.ezjobs.common.util.CryptoDataSource ds = CommonUtil.getDataSourceWorks();
		
		String tmpData		= "";
		String sql_text		= CommonUtil.replaceStrHtml(CommonUtil.isNull(paramMap.get("sql_text")));
		String limit_cnt	= CommonUtil.isNull(paramMap.get("limit_cnt"),"0");
		String db_gb		= CommonUtil.getMessage("jdbc_em.driverClassName")+CommonUtil.getMessage("DB_GUBUN");
		
		Connection conn			= null;
		PreparedStatement ps 	= null;
		ResultSet rs 			= null;
		
		String sql = "";
		
		tmpData = "<doc> \n<items > \n";
		try{
			conn = DbUtil.getConnection(ds);
			
			String sqlLimit = "";
			if(db_gb.indexOf("oracle") > -1) {
				sqlLimit = " and rownum <= "+limit_cnt +" ";
			}else if(db_gb.indexOf("postgresql") > -1) {
				sqlLimit = " limit "+limit_cnt +" ";
			}
			
			sql = 	" select * from( \n";
			sql += 	sql_text + " \n";
			sql += 	")T where 1=1 "+sqlLimit + " \n";

			tmpData += "<sql ><![CDATA["+sql+"]]></sql> \n";
			
			//System.out.println(sql);
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();	
				
			ResultSetMetaData rsmd = rs.getMetaData();
			int colCnt = rsmd.getColumnCount();
					
			StringBuilder sb = new StringBuilder();
			tmpData += "<json ><![CDATA[ [";
			
			long cnt = 0;
			while(rs.next()){
				JsonObject jObj = new JsonObject();
				
				jObj.addProperty("grid_idx",cnt);
				jObj.addProperty("row_num",++cnt);

				for(int i=1;i<=colCnt;i++){
					if("BLOB".equals(rsmd.getColumnTypeName(i))){
						jObj.addProperty("col"+i,"binary data");
					}else{
						jObj.addProperty("col"+i,CommonUtil.isNull(rs.getString(i)));
					}
				}

				if(cnt>1) sb.append(",");
				sb.append(jObj.toString());
			}
			
			if(sb.length()>0){
				tmpData += sb.toString();
			}
			tmpData += "] ]]></json> \n";
			
			tmpData += "<cnt ><![CDATA["+CommonUtil.comma(cnt)+"]]></cnt> \n";
			
			for(int i=1;i<=colCnt;i++){
				tmpData += "<item><![CDATA[";
				tmpData += rsmd.getColumnName(i);
				tmpData += "]]></item> \n";
			}
			
		}catch (Exception e) {
			tmpData += "<error><![CDATA["+e.getMessage()+"]]></error>";
		}finally {
			try {if(rs!=null) rs.close();}catch(Exception e){}
			try {if(ps!=null) ps.close();}catch(Exception e){}
			try {if(conn!=null) conn.close();}catch(Exception e){}
		}
		tmpData += "</items> \n</doc> \n";
		
		res.setContentType("application/xml;charset=utf-8");
		res.setHeader("Cache-Control", "no-cache");
		res.setHeader("Pragma","no-cache"); //HTTP 1.0
		res.setDateHeader ("Expires", 0);	
		
		PrintWriter pw = res.getWriter();
		System.out.println("tmpData : " + tmpData);
		pw.println(tmpData);
	}
	
	@SuppressWarnings({ "unchecked", "deprecation" })
	public void yamlFileDownload(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception{
		
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		
		try{
			
			String file_nm 			= CommonUtil.isNull(paramMap.get("yaml_file"));
			String file_content 	= CommonUtil.isNull(paramMap.get("file_content"));
			String cont_encode_yn 	= CommonUtil.isNull(paramMap.get("cont_encode_yn"));
			String decodedString 	= "";
			
			if(cont_encode_yn.equals("Y")) {
				byte[] decodedBytes = Base64.getDecoder().decode(file_content);
		        decodedString = new String(decodedBytes, Charset.forName("UTF-8"));
		        decodedString = decodedString.replaceAll("&apos;","\'").replace("&amp;quot;","\"").replace("&quot;","\"").replace("&lt;","<").replace("&gt;",">");
			}else {
				decodedString = file_content;
				decodedString = decodedString.replaceAll("&apos;","\'").replace("&amp;quot;","\"").replace("&quot;","\"").replace("&lt;","<").replace("&gt;",">");
			}
			
			logger.info("file_nm ::: " + file_nm);
			logger.info("file_content ::: " + file_content);
			logger.info("cont_encode_yn ::: " + cont_encode_yn);
			logger.info("decodedString ::: " + decodedString);
			
			res.setContentType("application/x-msdownload;");
			res.setHeader("Content-Type", "application/octet-stream; charset=UTF-8");
			res.setHeader("Content-Disposition", "attachment; filename="+java.net.URLEncoder.encode(file_nm,"UTF-8").replaceAll("\\+","%20"));
			
			PrintWriter a = res.getWriter();
			a.write(decodedString);
			a.flush();
			a.close();
			
		}catch(Exception e){
			e.getMessage();
		}
		
	}
}