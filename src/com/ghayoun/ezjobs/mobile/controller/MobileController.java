package com.ghayoun.ezjobs.mobile.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.servlet.ModelAndView;

import com.ghayoun.ezjobs.a.service.EmAlertService;
import com.ghayoun.ezjobs.comm.domain.CommonBean;
import com.ghayoun.ezjobs.comm.service.CommonService;
import com.ghayoun.ezjobs.common.util.BaseController;
import com.ghayoun.ezjobs.common.util.CommonUtil;
import com.ghayoun.ezjobs.common.util.Paging;
import com.ghayoun.ezjobs.common.util.Ssh2Util;
import com.ghayoun.ezjobs.common.util.TelnetUtil;
import com.ghayoun.ezjobs.m.domain.JobDetailBean;
import com.ghayoun.ezjobs.m.service.BimService;
import com.ghayoun.ezjobs.m.service.EmActiveJobsService;
import com.ghayoun.ezjobs.m.service.EmBatchResultTotalService;
import com.ghayoun.ezjobs.m.service.EmCtmInfoService;
import com.ghayoun.ezjobs.m.service.EmDefJobsService;
import com.ghayoun.ezjobs.m.service.EmJobLogService;
import com.ghayoun.ezjobs.m.service.EmPreDateBatchScheduleService;
import com.ghayoun.ezjobs.m.service.EmPreJobMissMatchService;
import com.ghayoun.ezjobs.m.service.PopupDefJobDetailService;
import com.ghayoun.ezjobs.m.service.PopupJobDetailService;
import com.ghayoun.ezjobs.m.service.PopupJobGraphService;
import com.ghayoun.ezjobs.m.service.PopupTimeInfoService;
import com.ghayoun.ezjobs.m.service.PopupWaitDetailService;
import com.ghayoun.ezjobs.t.domain.UserBean;
import com.ghayoun.ezjobs.t.service.WorksApprovalDocService;
import com.ghayoun.ezjobs.t.service.WorksApprovalLineService;
import com.ghayoun.ezjobs.t.service.WorksCompanyService;
import com.ghayoun.ezjobs.t.service.WorksUserService;

public class MobileController extends BaseController {

	protected final Log logger = LogFactory.getLog(getClass());
	
	private CommonService commonService;
	private EmActiveJobsService emActiveJobsService;
	private EmDefJobsService emDefJobsService;
	private EmPreJobMissMatchService emPreJobMissMatchService;
	private EmBatchResultTotalService emBatchResultTotalService;
	private EmPreDateBatchScheduleService emPreDateBatchScheduleService;
	private EmJobLogService emJobLogService;
	private EmCtmInfoService emCtmInfoService;
	
	private PopupJobGraphService popupJobGraphService;
	private PopupTimeInfoService popupTimeInfoService;
	private PopupJobDetailService popupJobDetailService;
	private PopupDefJobDetailService popupDefJobDetailService;
	private PopupWaitDetailService popupWaitDetailService;
	
	private BimService bimService;
	
	private WorksCompanyService worksCompanyService;
	private WorksUserService worksUserService;
	private WorksApprovalLineService worksApprovalLineService;
	private WorksApprovalDocService worksApprovalDocService;
	
	private EmAlertService emAlertService;
	
	
	public void setCommonService(CommonService commonService) {
		this.commonService = commonService;
	}
	public void setEmActiveJobsService(EmActiveJobsService emActiveJobsService) {
		this.emActiveJobsService = emActiveJobsService;
	}
	public void setEmDefJobsService(EmDefJobsService emDefJobsService) {
		this.emDefJobsService = emDefJobsService;
	}
	public void setEmPreJobMissMatchService(EmPreJobMissMatchService emPreJobMissMatchService) {
		this.emPreJobMissMatchService = emPreJobMissMatchService;
	}
	public void setEmBatchResultTotalService(EmBatchResultTotalService emBatchResultTotalService) {
		this.emBatchResultTotalService = emBatchResultTotalService;
	}
	public void setEmPreDateBatchScheduleService(EmPreDateBatchScheduleService emPreDateBatchScheduleService) {
		this.emPreDateBatchScheduleService = emPreDateBatchScheduleService;
	}
	public void setEmJobLogService(EmJobLogService emJobLogService) {
		this.emJobLogService = emJobLogService;
	}
	public void setEmCtmInfoService(EmCtmInfoService emCtmInfoService) {
		this.emCtmInfoService = emCtmInfoService;
	}
	
	public void setPopupJobGraphService(PopupJobGraphService popupJobGraphService) {
		this.popupJobGraphService = popupJobGraphService;
	}
	public void setPopupTimeInfoService(PopupTimeInfoService popupTimeInfoService) {
		this.popupTimeInfoService = popupTimeInfoService;
	}
	public void setPopupJobDetailService(PopupJobDetailService popupJobDetailService) {
		this.popupJobDetailService = popupJobDetailService;
	}
	public void setPopupDefJobDetailService(PopupDefJobDetailService popupDefJobDetailService) {
		this.popupDefJobDetailService = popupDefJobDetailService;
	}
	public void setPopupWaitDetailService(PopupWaitDetailService popupWaitDetailService) {
		this.popupWaitDetailService = popupWaitDetailService;
	}
	
	public void setBimService(BimService bimService) {
		this.bimService = bimService;
	}
	
	public void setWorksCompanyService(WorksCompanyService worksCompanyService) {
		this.worksCompanyService = worksCompanyService;
	}
	public void setWorksUserService(WorksUserService worksUserService) {
		this.worksUserService = worksUserService;
	}
	public void setWorksApprovalLineService(WorksApprovalLineService worksApprovalLineService) {
		this.worksApprovalLineService = worksApprovalLineService;
	}
	public void setWorksApprovalDocService(WorksApprovalDocService worksApprovalDocService) {
		this.worksApprovalDocService = worksApprovalDocService;
	}
	
	public void setEmAlertService(EmAlertService emAlertService) {
		this.emAlertService = emAlertService;
	}
	
	
	private void autoLogin(HttpServletRequest req, String user_id)
										throws ServletException, IOException, Exception{
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		
		paramMap.put("user_id", user_id);
		
		UserBean bean = worksUserService.dGetUserLogin(paramMap);
		
		if( bean != null ){
			req.getSession().setAttribute("USER_CD",bean.getUser_cd());
			req.getSession().setAttribute("USER_ID",bean.getUser_id());
			req.getSession().setAttribute("USER_NM",CommonUtil.E2K(bean.getUser_nm()));
			req.getSession().setAttribute("USER_GB",CommonUtil.isNull(bean.getUser_gb()));
			req.getSession().setAttribute("DEPT_CD",CommonUtil.isNull(bean.getDept_cd()));
			req.getSession().setAttribute("DEPT_NM",CommonUtil.E2K(bean.getDept_nm()));
			req.getSession().setAttribute("DUTY_CD",CommonUtil.isNull(bean.getDuty_cd()));
			req.getSession().setAttribute("DUTY_NM",CommonUtil.E2K(bean.getDuty_nm()));
			req.getSession().setAttribute("NO_AUTH",CommonUtil.isNull(bean.getNo_auth()));
			
			req.getSession().setAttribute("USER_IP",req.getLocalAddr());
		}
		
	}

	public ModelAndView ez000(HttpServletRequest req, HttpServletResponse res ) 
										throws ServletException, IOException, Exception{
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		Map<String, Object> rMap 	= new HashMap<String, Object>();
		
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
		
		String odate = CommonUtil.isNull(paramMap.get("odate"));
		if("".equals(odate)) paramMap.put("odate",((CommonBean)odateList.get(0)).getOdate());
		
		ArrayList<Map> data_center_items = new ArrayList();
		for(int i=0; i<dataCenterList.size(); i++){
			CommonBean bean = (CommonBean)dataCenterList.get(i);
			
			Map<String,Object> hm = new HashMap();
			hm.put("data_center_code", bean.getData_center_code());
			hm.put("data_center", bean.getData_center());
			hm.put("active_net_name", bean.getActive_net_name());
			data_center_items.add(hm);
		}
		paramMap.put("data_center_items", data_center_items);
		
		List totalJobStatusList = emActiveJobsService.getTotalJobStatusList(paramMap);
		
		ModelAndView output = null;
		output = new ModelAndView("ezjobs_mobile/m/em/dashBoard");
		output.addObject("totalJobStatusList",totalJobStatusList);
		output.addObject("odateList",odateList);
		
    	return output;
    	
	}
	
	public ModelAndView ez001(HttpServletRequest req, HttpServletResponse res ) 
										throws ServletException, IOException, Exception{
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		Map<String, Object> rMap 	= new HashMap<String, Object>();
		
		UserBean userBean = worksUserService.dGetUserLogin(paramMap);
		
		ModelAndView output = null;
		output = new ModelAndView("ezjobs_mobile/login");
		output.addObject("userBean",userBean);
		
    	return output;
    	
	}


	public ModelAndView ez002(HttpServletRequest req, HttpServletResponse res ) 
										throws ServletException, IOException, Exception{
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		
		String tabCode = CommonUtil.isNull(paramMap.get("tabCode"));
		
		ModelAndView output = null;
		output = new ModelAndView("ezjobs_mobile/search");
		
		if( "0103".equals(tabCode) || "0601".equals(tabCode) ){
			paramMap.put("searchType", "dataCenterList");
			List dataCenterList = commonService.dGetSearchItemList(paramMap);
			
			output.addObject("dataCenterList",dataCenterList);
		}else if("0106".equals(tabCode)){
			paramMap.put("searchType", "odatePostList");
			List odateList 		= commonService.dGetSearchItemList(paramMap);
			paramMap.put("searchType", "dataCenterList");
			List dataCenterList = commonService.dGetSearchItemList(paramMap);
			
			output.addObject("odateList",odateList);
			output.addObject("dataCenterList",dataCenterList);
		}else{
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
			
			output.addObject("odateList",odateList);
			output.addObject("dataCenterList",dataCenterList);
		}
		
		return output;
	}

	public ModelAndView ez003(HttpServletRequest req, HttpServletResponse res ) 
										throws ServletException, IOException, Exception{
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		
		List searchItemList 		= commonService.dGetSearchItemList(paramMap);
		
		ModelAndView output = null;
		output = new ModelAndView("ezjobs_mobile/setSearchItemList");
		output.addObject("searchItemList",searchItemList);
		
		return output;
	}

	public ModelAndView ez004(HttpServletRequest req, HttpServletResponse res ) 
										throws ServletException, IOException, Exception{
		
		/*
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		
		String currentPage = CommonUtil.isNull(paramMap.get("currentPage"));
		
		int rowSize 	= Integer.parseInt(CommonUtil.getMessage("MOBILE.PAGING.ROWSIZE.BASIC"));
		int pageSize 	= Integer.parseInt(CommonUtil.getMessage("MOBILE.PAGING.PAGESIZE.BASIC"));
		
		CommonBean bean = emDefJobsService.dGetDefJobListCnt(paramMap);
    	Paging paging = new Paging(bean.getTotal_count(),rowSize,pageSize,currentPage);
    	
    	String conditionNums[] = new String[70];
    	for(int i=0; i<conditionNums.length; i++){
    		conditionNums[i]= (i+1)+"";
    	}
    	paramMap.put("conditionNums", conditionNums);
    	
    	paramMap.put("startRowNum", paging.getStartRowNum());
    	paramMap.put("endRowNum", paging.getEndRowNum());
    	List defJobList = emDefJobsService.dGetDefJobList(paramMap);
    	
		ModelAndView output = null;
		output = new ModelAndView("ezjobs_mobile/m/em/defJobs");
		output.addObject("Paging",paging);
		output.addObject("totalCount",paging.getTotalRowSize());
		output.addObject("defJobList",defJobList);
		
    	return output;
    	*/
		
		ModelAndView output = null;
		return output;
	}
	

	public ModelAndView ez004_info(HttpServletRequest req, HttpServletResponse res ) 
										throws ServletException, IOException, Exception{
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		
		String data_center 	= CommonUtil.isNull(paramMap.get("data_center"));
		String sched_table = CommonUtil.isNull(paramMap.get("_sched_table"));
		String job_name = CommonUtil.isNull(paramMap.get("_job_name"));
		
		paramMap.put("sched_table", sched_table);
		paramMap.put("job_name", job_name);
		
		String info_gb = CommonUtil.isNull(paramMap.get("info_gb"));
		
		ModelAndView output = null;
		output = new ModelAndView("ezjobs_mobile/m/em/defJobInfo");
		if( "1".equals(info_gb) ){
			output.addObject("defJob",popupDefJobDetailService.dGetDefJobDetail(paramMap));
		}else if( "2".equals(info_gb) ){
			String host = CommonUtil.isNull(CommonUtil.getMessage("CM.TERMINAL."+data_center.toUpperCase()+".HOST") );
			int port = Integer.parseInt(CommonUtil.isNull(CommonUtil.getMessage("CM.TERMINAL."+data_center.toUpperCase()+".PORT"),"22" ));
			String user = CommonUtil.isNull(CommonUtil.getMessage("CM.TERMINAL."+data_center.toUpperCase()+".USER") );
			String pw = CommonUtil.isNull(CommonUtil.getMessage("CM.TERMINAL."+data_center.toUpperCase()+".PW") );
			
			String sOut = "";
			String cmd = "ctmrpln YJ Y  "+sched_table+" "+job_name+" "+CommonUtil.getCurDate("Y")+" | perl -ne 'print if 29..45' ";
			if(!"".equals(host)){
				if( "SSH".equals(CommonUtil.isNull(CommonUtil.getMessage("CM.TERMINAL."+data_center.toUpperCase()+".GB"))) ){
					Ssh2Util su = new Ssh2Util(host, port, user, pw, cmd, "UTF-8");
					sOut = su.getOutput();
				}else{
					TelnetUtil tu = new TelnetUtil(host,port,user,pw,cmd);
					sOut = tu.getOutput();
				}
			}else{
				sOut = CommonUtil.getMessage("ERROR.09");
			}
			
			output.addObject("sOut",sOut);
		}
		
		
    	return output;
	}


	public ModelAndView ez005(HttpServletRequest req, HttpServletResponse res ) 
										throws ServletException, IOException, Exception{
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		
		String currentPage = CommonUtil.isNull(paramMap.get("currentPage"));
		
		int rowSize 	= Integer.parseInt(CommonUtil.getMessage("MOBILE.PAGING.ROWSIZE.BASIC"));
		int pageSize 	= Integer.parseInt(CommonUtil.getMessage("MOBILE.PAGING.PAGESIZE.BASIC"));
		
		String active_net_names = CommonUtil.isNull(paramMap.get("active_net_names"));
		
		paramMap.put("active_net_names",active_net_names.split(",") );
		
		CommonBean bean = emPreJobMissMatchService.dGetPreJobMissMatchListCnt(paramMap);
    	Paging paging = new Paging(bean.getTotal_count(),rowSize,pageSize,currentPage);
    	
    	paramMap.put("startRowNum", paging.getStartRowNum());
    	paramMap.put("endRowNum", paging.getEndRowNum());
    	List preJobMissMatchList = emPreJobMissMatchService.dGetPreJobMissMatchList(paramMap);
    	
		ModelAndView output = null;
		output = new ModelAndView("ezjobs_mobile/m/em/preJobMissMatch");
		output.addObject("Paging",paging);
		output.addObject("totalCount",paging.getTotalRowSize());
		output.addObject("preJobMissMatchList",preJobMissMatchList);
		
    	return output;
	}
	

	public ModelAndView ez006(HttpServletRequest req, HttpServletResponse res ) 
										throws ServletException, IOException, Exception{
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		
		List batchResultTotalList = emBatchResultTotalService.dGetBatchResultTotalList(paramMap);
    	
		ModelAndView output = null;
		output = new ModelAndView("ezjobs_mobile/m/em/batchResultTotal");
		output.addObject("batchResultTotalList",batchResultTotalList);
		
    	return output;
	}
	
	public ModelAndView ez007(HttpServletRequest req, HttpServletResponse res ) 
										throws ServletException, IOException, Exception{
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		
		String currentPage = CommonUtil.isNull(paramMap.get("currentPage"));
		
		int rowSize 	= Integer.parseInt(CommonUtil.getMessage("MOBILE.PAGING.ROWSIZE.BASIC"));
		int pageSize 	= Integer.parseInt(CommonUtil.getMessage("MOBILE.PAGING.PAGESIZE.BASIC"));
		
		CommonBean bean = emPreDateBatchScheduleService.dGetPreDateBatchScheduleListCnt(paramMap);
    	Paging paging = new Paging(bean.getTotal_count(),rowSize,pageSize,currentPage);
    	
    	paramMap.put("startRowNum", paging.getStartRowNum());
    	paramMap.put("endRowNum", paging.getEndRowNum());
    	List preDateBatchScheduleList = emPreDateBatchScheduleService.dGetPreDateBatchScheduleList(paramMap);
    	
		ModelAndView output = null;
		output = new ModelAndView("ezjobs_mobile/m/em/preDateBatchSchedule");
		output.addObject("Paging",paging);
		output.addObject("totalCount",paging.getTotalRowSize());
		output.addObject("preDateBatchScheduleList",preDateBatchScheduleList);
		
    	return output;
	}
	

	public ModelAndView ez008(HttpServletRequest req, HttpServletResponse res ) 
										throws ServletException, IOException, Exception{
		
		/*
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		
		String currentPage = CommonUtil.isNull(paramMap.get("currentPage"));
		
		int rowSize 	= Integer.parseInt(CommonUtil.getMessage("MOBILE.PAGING.ROWSIZE.BASIC"));
		int pageSize 	= Integer.parseInt(CommonUtil.getMessage("MOBILE.PAGING.PAGESIZE.BASIC"));
		
		CommonBean bean = emJobLogService.dGetJobLogListCnt(paramMap);
    	Paging paging = new Paging(bean.getTotal_count(),rowSize,pageSize,currentPage);
    	
    	paramMap.put("startRowNum", paging.getStartRowNum());
    	paramMap.put("endRowNum", paging.getEndRowNum());
    	List jobLogList = emJobLogService.dGetJobLogList(paramMap);
    	
		ModelAndView output = null;
		output = new ModelAndView("ezjobs_mobile/m/em/jobLogList");
		output.addObject("Paging",paging);
		output.addObject("totalCount",paging.getTotalRowSize());
		output.addObject("jobLogList",jobLogList);
		
    	return output;
    	*/
		
		ModelAndView output = null;
		return output;
	}


	public ModelAndView ez008_info(HttpServletRequest req, HttpServletResponse res ) 
										throws ServletException, IOException, Exception{
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		
		String key = CommonUtil.isNull(paramMap.get("key"));
		if( !"".equals(key) ){
			this.autoLogin( req, CommonUtil.isNull(paramMap.get("user_id")) );
		}
		
		
		paramMap.put("job_name", CommonUtil.isNull(paramMap.get("_job_name")));
		
		String info_gb = CommonUtil.isNull(paramMap.get("info_gb"));
		String data_center = CommonUtil.isNull(paramMap.get("data_center"));
		String order_id = CommonUtil.isNull(paramMap.get("order_id"));
		
		if("".equals(CommonUtil.isNull(paramMap.get("active_net_name"))) ){
			paramMap.put("searchType", "dataCenterList");
			List dataCenterList = commonService.dGetSearchItemList(paramMap);
			String active_net_names = "";
			for(int i=0; i<dataCenterList.size(); i++){
				CommonBean bean = (CommonBean)dataCenterList.get(i);
				if( data_center.equals(bean.getData_center()) ){
					paramMap.put("active_net_name", bean.getActive_net_name());
					paramMap.put("data_center_code", bean.getData_center_code());
				}
			}
		}
		
		ModelAndView output = null;
		output = new ModelAndView("ezjobs_mobile/m/em/jobLogInfo");
		if( "1".equals(info_gb) ){
			output.addObject("timeInfoList",popupTimeInfoService.dGetTimeInfoList(paramMap));
		}else if( "2".equals(info_gb) ){
			String userNums[] = new String[4];
	    	for(int i=0; i<userNums.length; i++){
	    		userNums[i]= (i+1)+"";
	    	}
	    	paramMap.put("userNums", userNums);
			JobDetailBean jobDetail = popupJobDetailService.dGetJobDetail(paramMap);
			
			output.addObject("jobDetail",jobDetail);
			
		}else{
			String host = CommonUtil.isNull(CommonUtil.getMessage("CM.TERMINAL."+data_center.toUpperCase()+".HOST") );
			int port = Integer.parseInt(CommonUtil.isNull(CommonUtil.getMessage("CM.TERMINAL."+data_center.toUpperCase()+".PORT"),"22" ));
			String user = CommonUtil.isNull(CommonUtil.getMessage("CM.TERMINAL."+data_center.toUpperCase()+".USER") );
			String pw = CommonUtil.isNull(CommonUtil.getMessage("CM.TERMINAL."+data_center.toUpperCase()+".PW") );
			
			String sOut = "";
			String cmd = "";
			if(!"".equals(host)){
				if( "3".equals(info_gb) ) cmd = "ctmlog listord "+order_id+" '*' ";
				else if( "4".equals(info_gb) ) cmd = " ctmpsm -LISTSYSOUT "+order_id+" ";
				else if( "5".equals(info_gb) ) cmd = "ctmwhy "+order_id+" ";
				
				if( "SSH".equals(CommonUtil.isNull(CommonUtil.getMessage("CM.TERMINAL."+data_center.toUpperCase()+".GB"))) ){
					Ssh2Util su = new Ssh2Util(host, port, user, pw, cmd, "UTF-8");
					sOut = su.getOutput();
				}else{
					TelnetUtil tu = new TelnetUtil(host,port,user,pw,cmd);
					sOut = tu.getOutput();
				}
			}else{
				sOut = CommonUtil.getMessage("ERROR.09");
			}
			
			output.addObject("sOut",sOut);
		}
		
    	return output;
	}


	public ModelAndView ez008_p(HttpServletRequest req, HttpServletResponse res ) 
										throws ServletException, IOException, Exception{
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
		paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
		
		Map<String, Object> rMap 	= new HashMap<String, Object>();
		
		try{
			CommonUtil.emLogin(req);
			paramMap.put("userToken", CommonUtil.isNull(req.getSession().getAttribute("USER_TOKEN")));
			
			rMap = worksApprovalDocService.emPrcJobAction(paramMap);
		}catch(Exception e){
			rMap.put("r_code","-1");
			rMap.put("r_msg","ERROR.01");
		}
		
		ModelAndView output = null;
		output = new ModelAndView("ezjobs_mobile/t/result");
		output.addObject("rMap",rMap);
		
    	return output;
    	
	}
	
	
	public ModelAndView ez031(HttpServletRequest req, HttpServletResponse res ) 
										throws ServletException, IOException, Exception{
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		Map<String, Object> rMap 	= new HashMap<String, Object>();
		
		CommonUtil.emLogin(req);
		paramMap.put("userToken", CommonUtil.isNull(req.getSession().getAttribute("USER_TOKEN")));
		
		rMap = bimService.getServiceList(paramMap);
		
		ModelAndView output = null;
		output = new ModelAndView("ezjobs_mobile/m/bim/serviceList");
		output.addObject("rMap",rMap);
		
    	return output;
    	
	}
	

	public ModelAndView ez051(HttpServletRequest req, HttpServletResponse res ) 
										throws ServletException, IOException, Exception{
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
		paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
		
		String currentPage = CommonUtil.isNull(paramMap.get("currentPage"));
		
		int rowSize 	= Integer.parseInt(CommonUtil.getMessage("MOBILE.PAGING.ROWSIZE.BASIC"));
		int pageSize 	= Integer.parseInt(CommonUtil.getMessage("MOBILE.PAGING.PAGESIZE.BASIC"));
		
		CommonBean bean = worksApprovalDocService.dGetMyDocInfoListCnt(paramMap);
    	Paging paging = new Paging(bean.getTotal_count(),rowSize,pageSize,currentPage);
    	
    	paramMap.put("startRowNum", paging.getStartRowNum());
    	paramMap.put("endRowNum", paging.getEndRowNum());
    	List myDocInfoList = worksApprovalDocService.dGetMyDocInfoList(paramMap);
    	
		ModelAndView output = null;
		output = new ModelAndView("ezjobs_mobile/t/works/myDocInfoList");
		output.addObject("Paging",paging);
		output.addObject("totalCount",paging.getTotalRowSize());
		output.addObject("myDocInfoList",myDocInfoList);
		
    	return output;
	}
	

	public ModelAndView ez052(HttpServletRequest req, HttpServletResponse res ) 
										throws ServletException, IOException, Exception{
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
		paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
		
		String currentPage = CommonUtil.isNull(paramMap.get("currentPage"));
		
		int rowSize 	= Integer.parseInt(CommonUtil.getMessage("PAGING.ROWSIZE.BASIC"));
		int pageSize 	= Integer.parseInt(CommonUtil.getMessage("PAGING.PAGESIZE.BASIC"));
		
		CommonBean bean = worksApprovalDocService.dGetApprovalDocInfoListCnt(paramMap);
    	Paging paging = new Paging(bean.getTotal_count(),rowSize,pageSize,currentPage);
    	
    	paramMap.put("startRowNum", paging.getStartRowNum());
    	paramMap.put("endRowNum", paging.getEndRowNum());
    	List approvalDocInfoList = worksApprovalDocService.dGetApprovalDocInfoList(paramMap);
    	
		ModelAndView output = null;
		output = new ModelAndView("ezjobs_mobile/t/works/approvalDocInfoList");
		output.addObject("Paging",paging);
		output.addObject("totalCount",paging.getTotalRowSize());
		output.addObject("approvalDocInfoList",approvalDocInfoList);
		
    	return output;
	}
	
	
	public ModelAndView ez053(HttpServletRequest req, HttpServletResponse res ) 
										throws ServletException, IOException, Exception{
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		
		String key = CommonUtil.isNull(paramMap.get("key"));
		if( !"".equals(key) ){
			this.autoLogin( req, CommonUtil.isNull(paramMap.get("user_id")) );
		}
		
		
		paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
		paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
		
		String doc_gb = CommonUtil.isNull(paramMap.get("doc_gb"));
		
		List approvalInfoList = worksApprovalDocService.dGetApprovalInfoList(paramMap);
		
		ModelAndView output = null;
		output = new ModelAndView("ezjobs_mobile/t/works/doc"+doc_gb+"Approval");
		output.addObject("approvalInfoList",approvalInfoList);
		
		if( "01".equals(doc_gb) ){
			output.addObject("doc01",worksApprovalDocService.dGetDoc01(paramMap));
		}else if( "02".equals(doc_gb) ){
			output.addObject("doc02",worksApprovalDocService.dGetDoc02(paramMap));
		}else if( "03".equals(doc_gb) ){
			output.addObject("doc03",worksApprovalDocService.dGetDoc03(paramMap));
		}else if( "04".equals(doc_gb) ){
			output.addObject("doc04",worksApprovalDocService.dGetDoc04(paramMap));
		}
		
    	return output;
	}
	

	public ModelAndView ez053_p(HttpServletRequest req, HttpServletResponse res ) 
										throws ServletException, IOException, Exception{
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
		paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
		
		Map<String, Object> rMap 	= new HashMap<String, Object>();
		
		try{
			CommonUtil.emLogin(req);
			paramMap.put("userToken", CommonUtil.isNull(req.getSession().getAttribute("USER_TOKEN")));
			
			rMap = worksApprovalDocService.dPrcDocApproval(paramMap);			
			
		}catch(Exception e){
			
			rMap.put("r_code","-1");
			rMap.put("r_msg","ERROR.01");
		}
		
		ModelAndView output = null;
		output = new ModelAndView("ezjobs_mobile/t/result");
		output.addObject("rMap",rMap);
		
    	return output;
    	
	}
	
	
	public ModelAndView ez061(HttpServletRequest req, HttpServletResponse res ) 
										throws ServletException, IOException, Exception{
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		Map<String, Object> rMap 	= new HashMap<String, Object>();
		
		String currentPage = CommonUtil.isNull(paramMap.get("currentPage"));
		
		int rowSize 	= Integer.parseInt(CommonUtil.getMessage("MOBILE.PAGING.ROWSIZE.BASIC"));
		int pageSize 	= Integer.parseInt(CommonUtil.getMessage("MOBILE.PAGING.PAGESIZE.BASIC"));
		
		CommonBean bean = emAlertService.dGetAlertListCnt(paramMap);
    	Paging paging = new Paging(bean.getTotal_count(),rowSize,pageSize,currentPage);
    	
    	paramMap.put("startRowNum", paging.getStartRowNum());
    	paramMap.put("endRowNum", paging.getEndRowNum());
		
		List alertList = emAlertService.dGetAlertList(paramMap);
		
		List alertHandled0List 	= commonService.getCategoryList(paramMap,"ALERT.HANDLED.0");
		List alertHandled1List 	= commonService.getCategoryList(paramMap,"ALERT.HANDLED.1");
		List alertHandled2List 	= commonService.getCategoryList(paramMap,"ALERT.HANDLED.2");
		
		ModelAndView output = null;
		output = new ModelAndView("ezjobs_mobile/a/em/alertList");
		output.addObject("Paging",paging);
		output.addObject("totalCount",paging.getTotalRowSize());
		output.addObject("alertList",alertList);
		output.addObject("alertHandled0List",alertHandled0List);
		output.addObject("alertHandled1List",alertHandled1List);
		output.addObject("alertHandled2List",alertHandled2List);
		
		return output;
    	
	}
	
	
}