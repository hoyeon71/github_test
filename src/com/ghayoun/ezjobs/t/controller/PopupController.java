package com.ghayoun.ezjobs.t.controller;

import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
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

import com.ghayoun.ezjobs.comm.domain.CommonBean;
import com.ghayoun.ezjobs.comm.service.CommonService;
import com.ghayoun.ezjobs.common.util.BaseController;
import com.ghayoun.ezjobs.common.util.CommonUtil;
import com.ghayoun.ezjobs.common.util.DefaultServiceException;
import com.ghayoun.ezjobs.common.util.Paging;
import com.ghayoun.ezjobs.m.domain.JobDefineInfoBean;
import com.ghayoun.ezjobs.t.domain.ActiveJobBean;
import com.ghayoun.ezjobs.t.domain.DefJobBean;
import com.ghayoun.ezjobs.t.domain.JobGroupBean;
import com.ghayoun.ezjobs.t.service.PopupDefJobService;
import com.ghayoun.ezjobs.t.service.WorksApprovalDocService;
import com.ghayoun.ezjobs.t.service.WorksUserService;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

public class PopupController extends BaseController {

	protected final Log logger = LogFactory.getLog(getClass());
	
	private CommonService commonService;
	private PopupDefJobService popupDefJobService;
	private WorksApprovalDocService worksApprovalDocService;
	private WorksUserService worksUserService;
	
	public void setCommonService(CommonService commonService) {
		this.commonService = commonService;
	}
	public void setPopupDefJobService(PopupDefJobService popupDefJobService) {
		this.popupDefJobService = popupDefJobService;
	}
	public void setWorksApprovalDocService(WorksApprovalDocService worksApprovalDocService) {
		this.worksApprovalDocService = worksApprovalDocService;
	}
	public void setWorksUserService(WorksUserService worksUserService) {
		this.worksUserService = worksUserService;
	}

	public ModelAndView ez001(HttpServletRequest req, HttpServletResponse res ) 
										throws ServletException, IOException, Exception{
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		Map<String, Object> rMap 	= new HashMap<String, Object>();
		
		paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
	    paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
		
	    String currentPage 	= CommonUtil.isNull(paramMap.get("currentPage"));
	    String rowCnt 		= CommonUtil.isNull(paramMap.get("rowCnt"), CommonUtil.isNull(req.getSession().getAttribute("DEFAULT_PAGING")));
	    int rowSize 		= 0;

	    if ( !rowCnt.equals("") ) {
	    	rowSize = Integer.parseInt(rowCnt);
	    } else {
	    	rowSize = Integer.parseInt(CommonUtil.getMessage("PAGING.ROWSIZE.BASIC"));
	    }	

	    int pageSize = Integer.parseInt(CommonUtil.getMessage("PAGING.PAGESIZE.BASIC"));
		
		paramMap.put("searchType", "dataCenterList");
		List dataCenterList = commonService.dGetSearchItemList(paramMap);
		
		String StrSDC = CommonUtil.isNull(req.getSession().getAttribute("SELECT_DATA_CENTER"));
		
		String strDataCenter = CommonUtil.isNull(paramMap.get("data_center"), StrSDC);
		
		if( "".equals(strDataCenter) ){
			paramMap.put("data_center", ((CommonBean)dataCenterList.get(0)).getData_center());
		} else {
			paramMap.put("data_center", strDataCenter);
		}
	
		CommonBean bean = popupDefJobService.dGetDefJobListCnt(paramMap);
    	Paging paging = new Paging(bean.getTotal_count(),rowSize,pageSize,currentPage);
    	
    	paramMap.put("startRowNum", paging.getStartRowNum());
    	paramMap.put("endRowNum", paging.getEndRowNum());
    	List defJobList = popupDefJobService.dGetDefJobList(paramMap);
    	
		ModelAndView output = null;
//		output = new ModelAndView("ezjobs/t/popup/defJobList");
		output = new ModelAndView("contents/popup/defJobList");
		output.addObject("Paging",			paging);
		output.addObject("totalCount",		paging.getTotalRowSize());
		output.addObject("rowSize", 		rowSize);
		output.addObject("defJobList",		defJobList);
		output.addObject("dataCenterList",	dataCenterList);
		
    	return output;
    }
	
	public ModelAndView ez002(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {
		
		Map<String, Object> paramMap 	= CommonUtil.collectParameters(req);
		Map<String, Object> rMap 		= new HashMap<String, Object>();

		paramMap.put("searchType", "dataCenterList");
		List dataCenterList = commonService.dGetSearchItemList(paramMap);

		String StrSDC 			= CommonUtil.isNull(req.getSession().getAttribute("SELECT_DATA_CENTER"));
		String strDataCenter 	= CommonUtil.isNull(paramMap.get("data_center"), StrSDC);
		
		if( "".equals(strDataCenter) ){
			paramMap.put("data_center", ((CommonBean)dataCenterList.get(0)).getData_center());
		} else {
			paramMap.put("data_center", strDataCenter);
		}
		
		String currentPage 	= CommonUtil.isNull(paramMap.get("currentPage"));
		String rowCnt 		= CommonUtil.isNull(paramMap.get("rowCnt"), CommonUtil.isNull(req.getSession().getAttribute("DEFAULT_PAGING")));
		int rowSize 		= 0;
		
		if ( !rowCnt.equals("") ) {
			rowSize = Integer.parseInt(rowCnt);
		} else {
			rowSize = Integer.parseInt(CommonUtil.getMessage("PAGING.ROWSIZE.BASIC"));
		}	
		
		int pageSize = Integer.parseInt(CommonUtil.getMessage("PAGING.PAGESIZE.BASIC"));
		
		CommonBean bean 		= popupDefJobService.dGetJobGroupDefJobListCnt(paramMap);
		
		Paging paging = new Paging(bean.getTotal_count(), rowSize, pageSize, currentPage);

		paramMap.put("startRowNum", paging.getStartRowNum());
		paramMap.put("endRowNum", paging.getEndRowNum());
		
		List jobGroupDefJobList = popupDefJobService.dGetJobGroupDefJobList(paramMap);

		ModelAndView output = null;
//		output = new ModelAndView("ezjobs/t/popup/jobGroupDefJobList");
		output = new ModelAndView("contents/popup/jobGroupDefJobList");

		output.addObject("Paging", 				paging);
		output.addObject("totalCount", 			paging.getTotalRowSize());
		output.addObject("rowSize", 			rowSize);
		output.addObject("jobGroupDefJobList", 	jobGroupDefJobList);
		output.addObject("dataCenterList", 		dataCenterList);

		return output;
	}
	
	// 작업ORDER 그룹 상세 화면.
	public ModelAndView ez003(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException, Exception {

		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));

		JobGroupBean jobGroupBean = worksApprovalDocService.dGetJobGroupDetail(paramMap);

		ModelAndView output = null;
//		output = new ModelAndView("ezjobs/t/popup/jobGroupDetail");
		output = new ModelAndView("contents/popup/jobGroupDetail");
		output.addObject("jobGroupBean", jobGroupBean);
		
		CommonBean bean = worksApprovalDocService.dGetJobGroupDetailListCnt(paramMap);
	
		List jobGroupDetailList = worksApprovalDocService.dGetJobGroupDetailList(paramMap);
		
		output.addObject("jobGroupDetailList", jobGroupDetailList);
		output.addObject("totalCount",bean.getTotal_count());

		return output;
	}
	
    public ModelAndView ez004(HttpServletRequest req, HttpServletResponse res)
    							throws ServletException, IOException, Exception {
    	
	    Map paramMap = CommonUtil.collectParametersK2E(req);
	    
	    paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
	    paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
	    
	    List smsAdminList = worksUserService.dGetSmsAdminList(paramMap);
	    
	    ModelAndView output = null;
	    output = new ModelAndView("ezjobs/t/popup/smsAdminList");
	    output.addObject("smsAdminList", smsAdminList);
	    return output;
	}

	public ModelAndView ez005(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException, Exception {

		Map paramMap = CommonUtil.collectParametersK2E(req);

		paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
		paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));

		ModelAndView output = null;
//		output = new ModelAndView("ezjobs/t/popup/cyclicSet");
		output = new ModelAndView("contents/popup/cyclicSet");

		return output;
	}
	
	//kubernetes connection profile 팝업
	public ModelAndView ez006(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException, Exception {

		Map paramMap = CommonUtil.collectParametersK2E(req);
		Map<String, Object> map 	= new HashMap<String, Object>();
		
		paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
		paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
		
		map.put("appltype", "KBN062023");
		
		List<DefJobBean> hostList = popupDefJobService.dGetHostList(map);
		
		ModelAndView output = null;
		output = new ModelAndView("contents/popup/kubernetesConProSet");
		output.addObject("kuHostList", hostList);

		return output;
	}
	
	//MFT connection profile 팝업
	public ModelAndView ez007(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException, Exception {

		Map paramMap = CommonUtil.collectParametersK2E(req);
		Map<String, Object> map 	= new HashMap<String, Object>();
		
		paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
		paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
		
		map.put("appltype", "FILE_TRANS");
		
		List<DefJobBean> hostList = popupDefJobService.dGetHostList(map);
		
		ModelAndView output = null;
		output = new ModelAndView("contents/popup/mftConProSet");
		output.addObject("mftHostList", hostList);

		return output;
	}
	//kubernetes connection profile 팝업
	public ModelAndView ez008(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException, Exception {

		Map paramMap = CommonUtil.collectParametersK2E(req);
		Map<String, Object> map 	= new HashMap<String, Object>();
		
		paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
		paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
		
		map.put("appltype", "DATABASE");
		
		List<DefJobBean> hostList = popupDefJobService.dGetHostList(map);
		
		ModelAndView output = null;
		output = new ModelAndView("contents/popup/databaseConProSet");
		output.addObject("dbHostList", hostList);

		return output;
	}
	
	//kubernetes connection profile 팝업
		public ModelAndView ez008_1(HttpServletRequest req, HttpServletResponse res)
				throws ServletException, IOException, Exception {

			Map paramMap = CommonUtil.collectParametersK2E(req);
			Map<String, Object> map 	= new HashMap<String, Object>();
			
			paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
			paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
			
			ModelAndView output = null;
			output = new ModelAndView("contents/popup/databaseSchemaList");

			return output;
		}
		
		//kubernetes connection profile 팝업
		public ModelAndView ez008_2(HttpServletRequest req, HttpServletResponse res)
				throws ServletException, IOException, Exception {

			Map paramMap = CommonUtil.collectParametersK2E(req);
			Map<String, Object> map 	= new HashMap<String, Object>();
			
			paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
			paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
			
			
			ModelAndView output = null;
			output = new ModelAndView("contents/popup/databaseSpList");

			return output;
		}
	// 작업수행관리 작업명 클릭 시 작업 정보 팝업창 노출.
	public ModelAndView ez033_history(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException, Exception {

		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));

		String page_gubun 	= CommonUtil.isNull(paramMap.get("page_gubun"));
		String active_gb 		= CommonUtil.isNull(paramMap.get("active_gb"));

		List<CommonBean> dataCenterList = CommonUtil.getDataCenterList();

		String strDataCenter = CommonUtil.isNull(paramMap.get("data_center"));
		if ( !strDataCenter.equals("") && strDataCenter.indexOf(",") > -1 ) {
			strDataCenter = strDataCenter.split(",")[1];
		}

		for(int i=0;i<dataCenterList.size();i++){
			CommonBean bean = dataCenterList.get(i);

			if(strDataCenter.equals(bean.getData_center())){
				paramMap.put("active_net_name", bean.getActive_net_name());
				paramMap.put("data_center_code", bean.getData_center_code());

				break;
			}
		}

		JobDefineInfoBean aJobInfo = null;

		if ( active_gb.equals("0") ) {
			aJobInfo = popupDefJobService.dGetAjobHistoryInfo(paramMap);
		} else {
			aJobInfo = popupDefJobService.dGetAjobInfo(paramMap);
		}

		// 계정관리코드 : M2
		paramMap.put("mcode_cd", "M2");
		List sCodeList = commonService.dGetsCodeList(paramMap);
		
		ModelAndView output = null;
		output = new ModelAndView("contents/popup/aJobHistoryInfo");
		if(aJobInfo != null){
			
			String[] aTmpT = null;
			List<CommonBean> beans = new ArrayList<CommonBean>();
			System.out.println("CommonUtil.isNull(aJobInfo.getT_set()) : " + CommonUtil.isNull(aJobInfo.getT_set()));
			if( CommonUtil.isNull(aJobInfo.getT_set()).length()>0 ){
				aTmpT = CommonUtil.E2K(aJobInfo.getT_set()).split("[|]");
				for(int t=0; null!=aTmpT&&t<aTmpT.length; t++ ) {
					CommonBean bean = new CommonBean(); 
					if(aTmpT[t].contains("FTP")) {
						String[] aTmpT1 = aTmpT[t].split(",",2);
						bean.setVar_name(aTmpT1[0].replaceAll("FTP-", "FTP_"));
						bean.setVar_value(aTmpT1[1]);
						beans.add(bean);
					}else if(aTmpT[t].contains("DB")) {
						String[] aTmpT1 = aTmpT[t].split(",",2);
						bean.setVar_name(aTmpT1[0]);
						bean.setVar_value(aTmpT1[1]);
						beans.add(bean);
					}
				}
			}
			
			output.addObject("setvarList", beans);
			
			List databaseList= new ArrayList();
	        
	        for(int i=0;i<beans.size();i++) {
	        	CommonBean bean = (CommonBean) beans.get(i);
	        	System.out.println("bean : " + CommonUtil.isNull(bean.getVar_name()));
	        	if(CommonUtil.isNull(bean.getVar_name()).equals("DB-ACCOUNT")) {
		        	paramMap.put("profile_name", CommonUtil.isNull(bean.getVar_value()));
		    		paramMap.put("searchType", "databaseList");
		    		databaseList = commonService.dGetSearchItemList(paramMap);
	        	}
	        }
	        
	        output.addObject("databaseList", databaseList);
		}

		output.addObject("aJobInfo", aJobInfo);
		output.addObject("sCodeList", sCodeList);
		output.addObject("page_gubun", page_gubun);
		output.addObject("cm", CommonUtil.getComScodeList(paramMap));

		return output;
	}

	// 실시간 작업명 클릭 시 작업 정보 팝업창 노출.
	public ModelAndView ez033(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException, Exception {

		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		
		String page_gubun 	= CommonUtil.isNull(paramMap.get("page_gubun"));
		String active_gb 		= CommonUtil.isNull(paramMap.get("active_gb"));
		
		List<CommonBean> dataCenterList = CommonUtil.getDataCenterList();
		
		String strDataCenter = CommonUtil.isNull(paramMap.get("data_center"));
		if ( !strDataCenter.equals("") && strDataCenter.indexOf(",") > -1 ) {
			strDataCenter = strDataCenter.split(",")[1];
		}
				
		for(int i=0;i<dataCenterList.size();i++){
			CommonBean bean = dataCenterList.get(i);
			
			if(strDataCenter.equals(bean.getData_center())){
				paramMap.put("active_net_name", bean.getActive_net_name());
				paramMap.put("data_center_code", bean.getData_center_code());
				
				break;
			}
		}
		
		JobDefineInfoBean aJobInfo = null;

		if ( active_gb.equals("0") ) {
			aJobInfo = popupDefJobService.dGetAjobHistoryInfo(paramMap);			
		} else {
			aJobInfo = popupDefJobService.dGetAjobInfo(paramMap);	
		}
 		
		// 계정관리코드 : M2
		paramMap.put("mcode_cd", "M2");
		List sCodeList = commonService.dGetsCodeList(paramMap);
		
		// 작업명령어 수정 비활성 문자 코드
		paramMap.put("mcode_cd", "M91");
		List sInativeCmdList = commonService.dGetsCodeList(paramMap);
		
		ArrayList<String> sParmList = new ArrayList<String>();
		ArrayList<String> sCommandList = new ArrayList<String>();
		
		if(sInativeCmdList != null) {
			for(int i = 0; i < sInativeCmdList.size(); i++) {
				CommonBean bean = (CommonBean)sInativeCmdList.get(i);
				String strScodeNm = CommonUtil.isNull(bean.getScode_eng_nm());
				
				if( strScodeNm.indexOf("PARM") == 0 && strScodeNm.length() > 4) {
					String parm_num = strScodeNm.substring(4, strScodeNm.length()); // ex) PARM0, PARM1, PARM2... 
					if(parm_num.matches("[0-9.]+")) { // 문자열을 숫자변환 시 true/false 값을 반환해주는 정규표현식
						sParmList.add(strScodeNm);
					}else {
						sCommandList.add(strScodeNm);
					}
				}else {
					sCommandList.add(strScodeNm);
				}
			}
		}
		ModelAndView output = null;
		
		// 과거 상세는 선후행, 변수 등이 없어서 페이지를 나눔. 
		if ( active_gb.equals("0") ) {
			output = new ModelAndView("contents/popup/historyInfo_new");
		} else {
			output = new ModelAndView("contents/popup/aJobInfo_new");
		}
		
		if(aJobInfo != null){
			
			String[] aTmpT = null;
			List<CommonBean> beans = new ArrayList<CommonBean>();
			
			if( CommonUtil.isNull(aJobInfo.getT_set()).length()>0 ){
				aTmpT = CommonUtil.E2K(aJobInfo.getT_set()).split("[|]");
				for(int t=0; null!=aTmpT&&t<aTmpT.length; t++ ) {
					CommonBean bean = new CommonBean(); 
					if(aTmpT[t].contains("FTP")) {
						String[] aTmpT1 = aTmpT[t].split(",",2);
						bean.setVar_name(aTmpT1[0].replaceAll("FTP-", "FTP_"));
						bean.setVar_value(aTmpT1[1]);
						beans.add(bean);
					}else if(aTmpT[t].contains("DB")) {
						String[] aTmpT1 = aTmpT[t].split(",",2);
						bean.setVar_name(aTmpT1[0]);
						bean.setVar_value(aTmpT1[1]);
						beans.add(bean);
					}
				}
			}
			
			output.addObject("setvarList", beans);
			
			List databaseList= new ArrayList();
	        
	        for(int i=0;i<beans.size();i++) {
	        	CommonBean bean = (CommonBean) beans.get(i);
	        	System.out.println("bean : " + CommonUtil.isNull(bean.getVar_name()));
	        	if(CommonUtil.isNull(bean.getVar_name()).equals("DB-ACCOUNT")) {
		        	paramMap.put("profile_name", CommonUtil.isNull(bean.getVar_value()));
		    		paramMap.put("searchType", "databaseList");
		    		databaseList = commonService.dGetSearchItemList(paramMap);
	        	}
	        }
	        
	        output.addObject("databaseList", databaseList);
		}
		
		output.addObject("aJobInfo", aJobInfo);
		output.addObject("sCodeList", sCodeList);
		output.addObject("sParmList", sParmList);
		output.addObject("sCommandList", sCommandList);
		output.addObject("page_gubun", page_gubun);
		output.addObject("cm", CommonUtil.getComScodeList(paramMap));
		output.addObject("IN_COND_PAREN_S", CommonUtil.getMessage("JOB.IN_COND_PAREN_S"));
		output.addObject("IN_COND_PAREN_E", CommonUtil.getMessage("JOB.IN_COND_PAREN_E"));
		output.addObject("IN_COND_DT", CommonUtil.getMessage("JOB.IN_CONDITION_DATE"));
		output.addObject("IN_COND_AND_OR", CommonUtil.getMessage("JOB.IN_CONDITION_AND_OR2"));
		output.addObject("OUT_COND_DT", CommonUtil.getMessage("JOB.OUT_CONDITION_DATE"));
		output.addObject("OUT_COND_EFFECT", CommonUtil.getMessage("JOB.OUT_CONDITION_EFFECT2"));
		
		return output;
	}
	
	// 실시간 작업 수정. 
	public ModelAndView ez033_p(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

		Map<String, Object> paramMap 	= CommonUtil.collectParameters(req);
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		
		Map<String, Object> rMap 		= new HashMap<String, Object>();
		
		paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
		paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
			
		System.out.println("ez033_p paramMap : " + paramMap);
		try {

			  //CommonUtil.emLogin(req); 
			  //paramMap.put("userToken",CommonUtil.isNull(req.getSession().getAttribute("USER_TOKEN")));
			paramMap.put("active_net_name", CommonUtil.getCtmActiveNetName(paramMap));
			ActiveJobBean activeJobBean = worksApprovalDocService.dGetAjobStatus(paramMap);
			
			String strStatus 		= CommonUtil.isNull(activeJobBean.getStatus2());
			String strServerGb 		= CommonUtil.isNull(CommonUtil.getMessage("SERVER_GB"));
			
			// 운영 서버 적용
			// 관리자, 운영자는 변경 가능
			/*if ( strServerGb.equals("P") ) {
				if ( CommonUtil.isNull(req.getSession().getAttribute("USER_GB")).equals("01") ) {
					if((!strStatus.equals("Ended OK")) && (!strStatus.equals("Ended Not OK"))){
						rMap.put("r_code",	"-2");
						rMap.put("r_msg",	"종료된 작업만 실시간 작업 변경 가능합니다. (성공, 실패 건)");
						
						throw new DefaultServiceException(rMap);
					}
				}
			}*/
			
			if( strStatus.equals("Executing") ) {
				rMap.put("r_code",	"-2");
				rMap.put("r_msg",	"수행중인 작업은 실시간 작업 변경이 불가합니다.");

				throw new DefaultServiceException(rMap);
			}

			  rMap = worksApprovalDocService.emPrcAjobUpdate(paramMap);

		} catch (DefaultServiceException e) {
			
			rMap = e.getResultMap();

			if ("-2".equals(CommonUtil.isNull(("r_code")))) {
				logger.error(CommonUtil.isNull(("r_msg")));
			} else {
				logger.error(e.getMessage());
			}

		} catch (Exception e) {
			if ("".equals(CommonUtil.isNull(rMap.get("r_code"))))
				rMap.put("r_code", "-1");
			if ("".equals(CommonUtil.isNull(rMap.get("r_msg"))))
				rMap.put("r_msg", "ERROR.01");

			logger.error(e.getMessage());
		}

		ModelAndView output = null;
		//output = new ModelAndView("ezjobs/t/result");
		output = new ModelAndView("result/t_result");
		output.addObject("rMap", rMap);

		return output;
	}
	
	public ModelAndView ez034(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {
		
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		
		paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
		paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
		
		paramMap.put("searchType", "dataCenterList");
		List dataCenterList = commonService.dGetSearchItemList(paramMap);

		//String StrSDC 			= CommonUtil.isNull(req.getSession().getAttribute("SELECT_DATA_CENTER"));
		//String strDataCenter 	= CommonUtil.isNull(paramMap.get("data_center"), StrSDC);
		
		//if ( "".equals(strDataCenter) ) {
			paramMap.put("data_center", 		((CommonBean)dataCenterList.get(0)).getData_center());
			paramMap.put("active_net_name", 	((CommonBean)dataCenterList.get(0)).getActive_net_name());
			paramMap.put("data_center_code",	((CommonBean)dataCenterList.get(0)).getData_center_code());
		//} else {
			//paramMap.put("data_center", strDataCenter);
		//}

		String currentPage	= CommonUtil.isNull(paramMap.get("currentPage"));
		String rowCnt 		= CommonUtil.isNull(paramMap.get("rowCnt"), CommonUtil.isNull(req.getSession().getAttribute("DEFAULT_PAGING")));
		int rowSize 		= 0;

		if (!rowCnt.equals("")) {
			rowSize = Integer.parseInt(rowCnt);
		} else {
			rowSize = Integer.parseInt(CommonUtil.getMessage("PAGING.ROWSIZE.BASIC"));
		}

		int pageSize = Integer.parseInt(CommonUtil.getMessage("PAGING.PAGESIZE.BASIC"));

		CommonBean bean = worksApprovalDocService.dGetActiveGroupJobListCnt(paramMap);
		Paging paging = new Paging(bean.getTotal_count(), rowSize, pageSize, currentPage);

		paramMap.put("startRowNum", paging.getStartRowNum());
		paramMap.put("endRowNum", paging.getEndRowNum());
		
		List activeJobList = worksApprovalDocService.dGetActiveGroupJobList(paramMap);

		ModelAndView output = null;
		output = new ModelAndView("ezjobs/t/popup/activeGroupJobList");
		output.addObject("Paging", 			paging);
		output.addObject("totalCount", 		paging.getTotalRowSize());
		output.addObject("rowSize", 		rowSize);
		output.addObject("activeJobList", 	activeJobList);
		output.addObject("dataCenterList", 	dataCenterList);
		

		return output;

	}
	
	// 선후행 그래프에서 실시간 작업명 클릭 시 작업 정보 팝업창 노출. 
	public ModelAndView ez035(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		
		String page_gubun 	= CommonUtil.isNull(paramMap.get("page_gubun"));

		JobDefineInfoBean aJobInfo = popupDefJobService.dGetAjobInfo(paramMap);
		
		// 계정관리코드 : M2
		paramMap.put("mcode_cd", "M2");
		List sCodeList = commonService.dGetsCodeList(paramMap);

		ModelAndView output = null;
		output = new ModelAndView("ezjobs/m/popup/aJobInfoJobGraph");
		output.addObject("aJobInfo", aJobInfo);
		output.addObject("sCodeList", sCodeList);
		output.addObject("page_gubun", page_gubun);		
		
		return output;
	}
	
	// 스마트작업 작업 정보 팝업창 노출.
	public ModelAndView ez036(HttpServletRequest req, HttpServletResponse res)	throws ServletException, IOException, Exception {

		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		
		ModelAndView output = null;
		output = new ModelAndView("contents/popup/popSmartTreeInfo");
		
		return output;
	}
		
	
	/** 
	 * 결재화면, 결재자정보 팝업
	 * @param req
	 * @param res
	 * @return
	 * @throws ServletException
	 * @throws IOException
	 * @throws Exception
	 */
	public ModelAndView ez045(HttpServletRequest req, HttpServletResponse res ) throws ServletException, IOException, Exception{
		
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		
		ModelAndView output = null;
		output = new ModelAndView("contents/popup/approvalUserInfo");
		
		String strApprovalGubun 		= CommonUtil.isNull(paramMap.get("approvalGubun"));
		String strApprovalUser_cd 		= CommonUtil.isNull(paramMap.get("approvalUser_cd"));
		String strLine_gb 				= CommonUtil.isNull(paramMap.get("line_gb"));
		
		paramMap.put("user_cd", strApprovalUser_cd);
		
		System.out.println("user_cd : " + paramMap.get("user_cd"));
		System.out.println("strApprovalGubun : " + strApprovalGubun);
		System.out.println("strLine_gb : " + strLine_gb);
		System.out.println("approval_cd : " + CommonUtil.isNull(paramMap.get("approval_cd")));
		
		
		if(strApprovalGubun.equals("Y")){
			List approvalGroupUserList = worksUserService.dGetApprovalGroupUserList(paramMap);
			output.addObject("approvalUserList", approvalGroupUserList);
		}else if(strApprovalGubun.equals("N")){
			if(strLine_gb.equals("U")){
				List approvalUserList = worksUserService.dGetApprovalUserList(paramMap);
				output.addObject("approvalUserList", approvalUserList);
			}else if(strLine_gb.equals("F")){
				List approvalAdminUserList = worksUserService.dGetApprovalAdminUserList(paramMap);
				output.addObject("approvalUserList", approvalAdminUserList);
			}else{
				List approvalUserList = worksUserService.dGetApprovalUserList(paramMap);
				output.addObject("approvalUserList", approvalUserList);
			}
			
		}
		
		return output;		
		
	}
	
	/** 
	 * 결재화면, 결재자정보 팝업
	 * @param req
	 * @param res
	 * @return
	 * @throws ServletException
	 * @throws IOException
	 * @throws Exception
	 */
	public ModelAndView ez045_Dynamic(HttpServletRequest req, HttpServletResponse res ) throws ServletException, IOException, Exception{
		
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		
		ModelAndView output = null;
		output = new ModelAndView("contents/popup/dynamicApprovalUserInfo");
		
		String strApprovalGubun 		= CommonUtil.isNull(paramMap.get("approvalGubun"));
		String strApprovalUser_cd 		= CommonUtil.isNull(paramMap.get("approvalUser_cd"));
		String strLine_gb 				= CommonUtil.isNull(paramMap.get("line_gb"));
		String strDoc_cd 				= CommonUtil.isNull(paramMap.get("doc_cd"));
		
		paramMap.put("user_cd", strApprovalUser_cd);
		paramMap.put("doc_cd", strDoc_cd);
		
		System.out.println("user_cd : " + paramMap.get("user_cd"));
		System.out.println("strApprovalGubun : " + strApprovalGubun);
		System.out.println("strLine_gb : " + strLine_gb);
		System.out.println("approval_cd : " + CommonUtil.isNull(paramMap.get("approval_cd")));
		
		
		if(strApprovalGubun.equals("Y")){
			List approvalGroupUserList = worksUserService.dGetApprovalGroupUserList(paramMap);
			output.addObject("approvalUserList", approvalGroupUserList);
		}else if(strApprovalGubun.equals("N")){
			if(strLine_gb.equals("U")){
				List approvalUserList = worksUserService.dGetApprovalUserList(paramMap);
				output.addObject("approvalUserList", approvalUserList);
			}else if(strLine_gb.equals("F")){
				List approvalAdminUserList = worksUserService.dGetApprovalAdminUserList(paramMap);
				output.addObject("approvalUserList", approvalAdminUserList);
			}else{
				List approvalUserList = worksUserService.dGetApprovalUserList(paramMap);
				output.addObject("approvalUserList", approvalUserList);
			}
			
		}
		
		return output;		
		
	}
	
	/** 
	 * 담당자정보 팝업
	 * @param req
	 * @param res
	 * @return
	 * @throws ServletException
	 * @throws IOException
	 * @throws Exception
	 */
	public ModelAndView ez046(HttpServletRequest req, HttpServletResponse res ) throws ServletException, IOException, Exception{
		
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		
		List smsDefaultList		= null;
		List mailDefaultList	= null;

		//SMS 기본값 설정
		paramMap.put("mcode_cd", "M87");
		smsDefaultList = commonService.dGetsCodeList(paramMap);
		
		//MAIL 기본값 설정
		paramMap.put("mcode_cd", "M88");
		mailDefaultList = commonService.dGetsCodeList(paramMap);
		
		ModelAndView output = null;
		output = new ModelAndView("contents/popup/jobUserInfo");
		output.addObject("smsDefaultList", 	smsDefaultList);
		output.addObject("mailDefaultList", mailDefaultList);
		
		String strJob_name 		= CommonUtil.isNull(paramMap.get("job_name"));
		
		paramMap.put("job_name", strJob_name);
		
		CommonBean jobUserInfo = worksUserService.dGetJobUserInfo(paramMap);
		output.addObject("jobUserInfo", jobUserInfo);
		
		return output;		
	}
	
	/** 
	 * 의뢰자정보 팝업
	 * @param req
	 * @param res
	 * @return
	 * @throws ServletException
	 * @throws IOException
	 * @throws Exception
	 */
	public ModelAndView ez047(HttpServletRequest req, HttpServletResponse res ) throws ServletException, IOException, Exception{
		
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		
		ModelAndView output = null;
		output = new ModelAndView("contents/popup/docUserInfo");
		
		CommonBean docUserInfo = worksUserService.dGetDocUserInfo(paramMap);
		output.addObject("docUserInfo", docUserInfo);
		
		return output;		
		
	}
	
	//작업등록정보 > 작업 이력 조회 팝업창
	public ModelAndView ez048(HttpServletRequest req, HttpServletResponse res ) throws ServletException, IOException, Exception{
		
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		
		ModelAndView output = null;
		output = new ModelAndView("contents/popup/jobHistoryInfo");
		
		return output;		
	}
	
	public ModelAndView popSr(HttpServletRequest req, HttpServletResponse res ) throws ServletException, IOException, Exception {
		
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		
		paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
		paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
		
		String search_gubun 	= CommonUtil.isNull(paramMap.get("search_gubun"));
		String search_text 	= CommonUtil.isNull(paramMap.get("search_text"));
		
		String s_search_date 	= CommonUtil.isNull(paramMap.get("s_search_date"));
		String e_search_date 	= CommonUtil.isNull(paramMap.get("e_search_date"));
		
		String currentPage 	= CommonUtil.isNull(paramMap.get("currentPage"), "1");
		String rowCnt 		= CommonUtil.isNull(paramMap.get("rowCnt"));
		int rowSize 		= 0;

		if ( !rowCnt.equals("") ) {
			rowSize = Integer.parseInt(rowCnt);
		} else {
			rowSize = Integer.parseInt(CommonUtil.getMessage("PAGING.ROWSIZE.BASIC"));
		}	

		int pageSize = Integer.parseInt(CommonUtil.getMessage("PAGING.PAGESIZE.BASIC"));
		
		String strDbUrl 		= CommonUtil.getMessage("SR.URL");
		String strDbUser 		= CommonUtil.getMessage("SR.ID");
		String strDbPassword 	= CommonUtil.getMessage("SR.PW");
		
		String sql			= "";
		String sqlW			= "";
		
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		int cnt = 0;
		List<Map<String,String>> srList = new ArrayList<Map<String,String>>();
		Paging paging = null;
		try{
			
			/*
			String strHrDeptUrl = CommonUtil.isNull(CommonUtil.getMessage("HR_DEPT_URL"));
			
			URL obj = new URL(strHrDeptUrl + "?baseYmd=" + DateUtil.getDay(0));
			HttpURLConnection conn = (HttpURLConnection) obj.openConnection();
			
			conn.setRequestMethod("GET");
			conn.setDoOutput(true);
			
			BufferedReader br 	= null;
			
			br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
			
			String line 		= "";
			
			while ((line = br.readLine()) != null) {				
				json_string = line;
			}
			*/

			int iCnt	 		= 0;
			String json_string 	= "";

			File file 				= new File("D:\\project\\EZJOBS\\workspace\\EZJOBS_TOSS\\web\\sr.txt");
			FileReader filereader 	= new FileReader(file);
			
			while((iCnt = filereader.read()) != -1){
			    json_string += (char)iCnt;
			}
			
			
			JsonParser jsonParser 	= new JsonParser();
			JsonObject jsonObject 	= (JsonObject) jsonParser.parse(json_string);
			JsonArray jsonArray 	= jsonObject.getAsJsonArray("srItem");
			
			for (int i = 0; i < jsonArray.size(); i++) {
				cnt ++;
				JsonObject object = (JsonObject) jsonArray.get(i);
				
				String prco_state 	= CommonUtil.isNull(object.get("prco_state").getAsString());
				String req_dt 		= CommonUtil.isNull(object.get("req_dt").getAsString());
				String req_type 	= CommonUtil.isNull(object.get("req_type").getAsString());
				String req_user_nm 	= CommonUtil.isNull(object.get("req_user_nm").getAsString());
				String req_user_id 	= CommonUtil.isNull(object.get("req_user_id").getAsString());
				String sr_id 		= CommonUtil.isNull(object.get("sr_id").getAsString());
				String title 		= CommonUtil.isNull(object.get("title").getAsString());
				String work_state 	= CommonUtil.isNull(object.get("work_state").getAsString());

				System.out.println("prco_state : " + prco_state);
				System.out.println("<br>"); 
				System.out.println("req_dt : " + req_dt);
				System.out.println("<br>");
				System.out.println("req_type : " + req_type);
				System.out.println("<br>");
				System.out.println("req_user_nm : " + req_user_nm);
				System.out.println("<br>");
				System.out.println("req_user_id : " + req_user_id);
				System.out.println("<br>");
				System.out.println("sr_id : " + sr_id);
				System.out.println("<br>");
				System.out.println("title : " + title);
				System.out.println("<br>");
				System.out.println("work_state : " + work_state);
				System.out.println("<br>");
				System.out.println("<br>");
				
				Map<String,String> m = new HashMap<String,String>();
				m.put("prco_state", 	prco_state);
				m.put("req_dt", 		req_dt);
				m.put("req_type", 		req_type);
				m.put("req_user_nm", 	req_user_nm);
				m.put("req_user_id", 	req_user_id);
				m.put("sr_id", 			sr_id);
				m.put("title", 			title);
				m.put("work_state", 	work_state );
				
				srList.add(m);
			}
			
			paging = new Paging(cnt,rowSize,pageSize,currentPage);
			
		}catch(Exception e){
			logger.error("srList Error : "+e);
			paging = new Paging(cnt,rowSize,pageSize,currentPage);
		}finally{
			
		}
		
		ModelAndView output = null;
		
		output = new ModelAndView("contents/popup/srList");
		//output = new ModelAndView("works/pop/srList");
		output.addObject("srList",		srList);
		output.addObject("Paging", 		paging);
		output.addObject("totalCount", 	paging.getTotalRowSize());
		output.addObject("rowSize", 	rowSize);
		
    	return output;    	
	}
	
	public ModelAndView ez049(HttpServletRequest req, HttpServletResponse res ) throws ServletException, IOException, Exception{
		
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		
		paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
		paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
		
		String advanced_num = CommonUtil.isNull(paramMap.get("advanced_num"));
		String conn1 = CommonUtil.isNull(paramMap.get("FTP_CONNTYPE1"));
		String conn2 = CommonUtil.isNull(paramMap.get("FTP_CONNTYPE2"));
		
		Map<String, Object> rMap 	= new HashMap<String, Object>();
		rMap.put("advanced_num", advanced_num);
		rMap.put("FTP_CONNTYPE1", conn1);
		rMap.put("FTP_CONNTYPE2", conn2);
//		List<JobMapperMFTBean> jobMappermftInfolist = worksUserService.dGetJobMapperWriteMFTInfo(paramMap);

		ModelAndView output = null;
		
		output = new ModelAndView("contents/popup/advancedPopupList");
		output.addObject("rMap",rMap);
//		output.addObject("accountList",jobMappermftInfolist);
		return output;
		
	}
}