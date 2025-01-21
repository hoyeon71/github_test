package com.ghayoun.ezjobs.m.controller;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.io.StringReader;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.bind.JAXBContext;
import javax.xml.bind.Unmarshaller;

import com.ghayoun.ezjobs.t.domain.*;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.servlet.ModelAndView;

import com.ghayoun.ezjobs.comm.domain.CommonBean;
import com.ghayoun.ezjobs.comm.repository.CommonDao;
import com.ghayoun.ezjobs.comm.service.CommonService;
import com.ghayoun.ezjobs.common.util.BaseController;
import com.ghayoun.ezjobs.common.util.CommonUtil;
import com.ghayoun.ezjobs.common.util.DefaultServiceException;
import com.ghayoun.ezjobs.common.util.FtpUtil;
import com.ghayoun.ezjobs.common.util.Paging;
import com.ghayoun.ezjobs.common.util.SeedUtil;
import com.ghayoun.ezjobs.common.util.SftpUtil;
import com.ghayoun.ezjobs.common.util.Ssh2Util;
import com.ghayoun.ezjobs.common.util.SshUtil;
import com.ghayoun.ezjobs.common.util.TelnetUtil;
import com.ghayoun.ezjobs.m.domain.JobDefineInfoBean;
import com.ghayoun.ezjobs.m.domain.JobDetailBean;
import com.ghayoun.ezjobs.m.domain.JobGraphBean;
import com.ghayoun.ezjobs.m.domain.JobLogBean;
import com.ghayoun.ezjobs.m.domain.RelTableBean;
import com.ghayoun.ezjobs.m.service.EmJobLogService;
import com.ghayoun.ezjobs.m.service.PopupDefJobDetailService;
import com.ghayoun.ezjobs.m.service.PopupJobDetailCtmService;
import com.ghayoun.ezjobs.m.service.PopupJobDetailService;
import com.ghayoun.ezjobs.m.service.PopupJobGraphService;
import com.ghayoun.ezjobs.m.service.PopupTimeInfoService;
import com.ghayoun.ezjobs.m.service.PopupWaitDetailService;
import com.ghayoun.ezjobs.t.service.WorksApprovalDocService;
import com.ghayoun.ezjobs.t.service.WorksApprovalLineService;
import com.ghayoun.ezjobs.t.service.WorksCompanyService;
import com.ghayoun.ezjobs.t.service.WorksUserService;
import com.jcraft.jsch.Session;

public class PopupController extends BaseController {

	protected final Log logger = LogFactory.getLog(getClass());   

	private CommonService commonService;
	private PopupJobGraphService popupJobGraphService;
	private PopupTimeInfoService popupTimeInfoService;
	private PopupJobDetailService popupJobDetailService;
	private PopupJobDetailCtmService popupJobDetailCtmService;
	private PopupDefJobDetailService popupDefJobDetailService;
	private PopupWaitDetailService popupWaitDetailService;
	private WorksUserService worksUserService;                               
	private WorksCompanyService worksCompanyService;
	private EmJobLogService emJobLogService;
	private WorksApprovalLineService worksApprovalLineService;
	private WorksApprovalDocService worksApprovalDocService;
	private CommonDao commonDao;
	
	public void setWorksApprovalDocService(WorksApprovalDocService worksApprovalDocService) {
		this.worksApprovalDocService = worksApprovalDocService;
	}
	public void setWorksApprovalLineService(WorksApprovalLineService worksApprovalLineService) {
		this.worksApprovalLineService = worksApprovalLineService;
	}
	
	public void setCommonService(CommonService commonService) {
		this.commonService = commonService;
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
	public void setPopupJobDetailCtmService(PopupJobDetailCtmService popupJobDetailCtmService) {
		this.popupJobDetailCtmService = popupJobDetailCtmService;
	}
	public void setPopupDefJobDetailService(PopupDefJobDetailService popupDefJobDetailService) {
		this.popupDefJobDetailService = popupDefJobDetailService;
	}
	public void setPopupWaitDetailService(PopupWaitDetailService popupWaitDetailService) {
		this.popupWaitDetailService = popupWaitDetailService;
	}
	public void setWorksUserService(WorksUserService worksUserService) {
		this.worksUserService = worksUserService;
	}
	public void setWorksCompanyService(WorksCompanyService worksCompanyService) {
		this.worksCompanyService = worksCompanyService;
	}
	public void setEmJobLogService(EmJobLogService emJobLogService) {
		this.emJobLogService = emJobLogService;
	}

	public ModelAndView ez002(HttpServletRequest req, HttpServletResponse res ) 
										throws ServletException, IOException, Exception{
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		
		paramMap.put("type1", "O");
		paramMap.put("type2", "I");
		List jobGraphPreList = popupJobGraphService.dGetJobGraphList(paramMap);
		jobGraphPreList = toJobGraphList(paramMap, jobGraphPreList, new ArrayList());
		
		paramMap.put("compare_num", "0");
		paramMap.put("order_id", req.getParameter("order_id"));
		paramMap.put("type1", "I");
		paramMap.put("type2", "O");
		List jobGraphNextList = popupJobGraphService.dGetJobGraphList(paramMap);
		jobGraphNextList = toJobGraphList(paramMap, jobGraphNextList, new ArrayList());
		
		ModelAndView output = null;
		output = new ModelAndView("ezjobs/m/popup/jobGraph_applet");
		output.addObject("jobGraphPreList",jobGraphPreList);
		output.addObject("jobGraphNextList",jobGraphNextList);
		
    	return output;
	}
	
	@SuppressWarnings("unchecked")
	public ModelAndView ez002_d3(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));

		logger.debug("#PopupController | ez002_d2 | data_center :::"+CommonUtil.isNull(paramMap.get("data_center")));
		
		String strDataCenter = CommonUtil.isNull(paramMap.get("data_center"));
		
		if ( !strDataCenter.equals("") && strDataCenter.indexOf(",") > -1 ) {
			strDataCenter = strDataCenter.split(",")[1];
		}
		
		List<CommonBean> dataCenterList = CommonUtil.getDataCenterList();
		
		for(int i=0;i<dataCenterList.size();i++){
			CommonBean bean = dataCenterList.get(i);
			
			if(strDataCenter.equals(bean.getData_center())){
				paramMap.put("active_net_name", bean.getActive_net_name());
				paramMap.put("data_center_code", bean.getData_center_code());
				
				break;
			}    				
		}
		
		logger.debug("#PopupController | ez002_d2 | active_net_name :::"+CommonUtil.isNull(paramMap.get("active_net_name")));
		
		ModelAndView output = null;
		//output = new ModelAndView("ezjobs/m/popup/jobGraph_d3");
		output = new ModelAndView("contents/popup/jobGraph_d3");
		output.addObject("paramMap", paramMap);

		return output;
	}

	public ModelAndView ez002_d3_xml(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {
		
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));

		paramMap.put("type1", "O");
		paramMap.put("type2", "I");
		List jobGraphPreList = popupJobGraphService.dGetJobGraphList(paramMap);
		jobGraphPreList = toJobGraphList(paramMap, jobGraphPreList, new ArrayList());

		paramMap.put("compare_num", "0");
		paramMap.put("order_id", req.getParameter("order_id"));
		paramMap.put("type1", "I");
		paramMap.put("type2", "O");
		List jobGraphNextList = popupJobGraphService.dGetJobGraphList(paramMap);
		jobGraphNextList = toJobGraphList(paramMap, jobGraphNextList, new ArrayList());

		ModelAndView output = null;
		//output = new ModelAndView("ezjobs/common/itemXml");
		output = new ModelAndView("common/itemXml");
		output.addObject("jobGraphPreList", 	jobGraphPreList);
		output.addObject("jobGraphNextList", 	jobGraphNextList);

		return output;
	}
	
	private List toJobGraphList(Map paramMap, List inList, List outList) {
		
		int iGraphDepth = Integer.parseInt(CommonUtil.isNull(paramMap.get("graph_depth"), "0"));
		int iCompareNum = Integer.parseInt(CommonUtil.isNull(paramMap.get("compare_num"), "0"));
		
		if ( inList != null && inList.size() > 0 ) {
			outList.addAll(inList);
		}
		
		for ( int i = 0; inList != null && i < inList.size(); i++ ) {
			
			JobGraphBean bean = (JobGraphBean)inList.get(i);
			
			if ( iCompareNum == iGraphDepth && iGraphDepth > 0 ) {
				bean.setRef_order_id("");				
			}
			
			int iChk = 0;
			
			for ( int j = 0; outList != null && j < outList.size(); j++ ) {
				
				JobGraphBean bean2 = (JobGraphBean)outList.get(j);
				
				if( bean2.getOrder_id().equals(bean.getRef_order_id()) || CommonUtil.isNull(bean.getRef_order_id()).equals("") ) {
					iChk++;
				}
			}
			
			if ( iChk > 0 ) continue;
			
			paramMap.put("order_id", bean.getRef_order_id());
			
			List l = popupJobGraphService.dGetJobGraphList(paramMap);

			if ( l != null && l.size() > 0 ) {
				iCompareNum++;
				paramMap.put("compare_num", iCompareNum);
				
				toJobGraphList(paramMap, l, outList);
			}
		}
		
    	return outList;
	}
	
	public ModelAndView ez003(HttpServletRequest req, HttpServletResponse res ) 
										throws ServletException, IOException, Exception{
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		
		List timeInfoList = popupTimeInfoService.dGetTimeInfoList(paramMap);
    	
		ModelAndView output = null;
		//output = new ModelAndView("ezjobs/m/popup/timeInfoList");
		output = new ModelAndView("contents/popup/timeInfoList");
		output.addObject("timeInfoList",timeInfoList);
		
    	return output;
	}

	public ModelAndView ez004(HttpServletRequest req, HttpServletResponse res ) throws ServletException, IOException, Exception {
		
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		
		String data_center_code = CommonUtil.isNull(paramMap.get("data_center_code"));
		String active_net_name = CommonUtil.isNull(paramMap.get("active_net_name"));
		String data_center = CommonUtil.isNull(paramMap.get("data_center"));
		
		logger.info("data_center_code==============>"+data_center_code +"--"+ active_net_name +"--"+ data_center);
		
		ModelAndView output = null;
		
//		output = new ModelAndView("ezjobs/m/popup/jobDetail");
		output = new ModelAndView("contents/popup/jobDetail");
		String gb 	= CommonUtil.isNull(paramMap.get("gb"));
		
		//if( "01".equals(gb) ){
			String userNums[] = new String[10];
	    	for(int i=0; i<userNums.length; i++){
	    		userNums[i]= (i+1)+"";
	    	}
	    	paramMap.put("userNums", userNums);
			JobDetailBean jobDetail = popupJobDetailService.dGetJobDetail(paramMap);
			
			output.addObject("jobDetail",jobDetail);
		//}else if( "02".equals(gb) ){
			String currentPage = CommonUtil.isNull(paramMap.get("currentPage"));
			
			int rowSize 	= Integer.parseInt(CommonUtil.getMessage("PAGING.ROWSIZE.JOB_MEMO"));
			int pageSize 	= Integer.parseInt(CommonUtil.getMessage("PAGING.PAGESIZE.JOB_MEMO"));
			
			CommonBean bean = popupJobDetailService.dGetJobMemoListCnt(paramMap);
	    	Paging paging = new Paging(bean.getTotal_count(),rowSize,pageSize,currentPage);
	    	
	    	paramMap.put("startRowNum", paging.getStartRowNum());
	    	paramMap.put("endRowNum", paging.getEndRowNum());
	    	List jobMemoList = popupJobDetailService.dGetJobMemoList(paramMap);
	    	
	    	output.addObject("Paging",paging);
			output.addObject("totalCount",paging.getTotalRowSize());
	    	output.addObject("jobMemoList",jobMemoList);
		//}
		
    	return output;
	}

	
	public ModelAndView ez004_p(HttpServletRequest req, HttpServletResponse res ) 
										throws ServletException, IOException, Exception{
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
		paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		
		Map<String, Object> rMap 	= new HashMap<String, Object>();
		
		//String gb 	= CommonUtil.isNull(paramMap.get("gb"));
		//if( "02".equals(gb) ){
			try{
				rMap = popupJobDetailService.dPrcJobMemo(paramMap);
			}catch(Exception e){
				rMap.put("r_code","-1");
				rMap.put("r_msg","ERROR.01");
				
				e.printStackTrace();
			}
		//}
		
		ModelAndView output = null;
		output = new ModelAndView("result/m_result");
		output.addObject("rMap",rMap);
		
    	return output;
    	
	}

	
	public ModelAndView ez005(HttpServletRequest req, HttpServletResponse res ) 
										throws ServletException, IOException, Exception{
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		
		List defJob = popupDefJobDetailService.dGetDefJobDetail(paramMap);
    	
		ModelAndView output = null;
		output = new ModelAndView("ezjobs/m/popup/defJobDetail");
		output.addObject("defJob",defJob);
		
    	return output;
	}
	
	@SuppressWarnings("unchecked")
	public ModelAndView ez006(HttpServletRequest req, HttpServletResponse res ) throws ServletException, IOException, Exception {
		
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		
		String strDataCenter 	= CommonUtil.isNull(paramMap.get("data_center"));
		String strOrderId 		= CommonUtil.isNull(paramMap.get("order_id"));
		String hostname 		= CommonUtil.getHostIp();
			
		// Host 정보 가져오는 서비스.
		paramMap.put("data_center"	, strDataCenter);
		paramMap.put("host"			, strDataCenter);
		paramMap.put("server_gubun"	, "S");
		
		CommonBean bean = commonService.dGetHostInfo(paramMap);
		
		String strHost 				= "";
		String strAccessGubun		= "";
		int iPort 					= 0;
		String strUserId 			= "";
		String strUserPw 			= "";
		
		if ( bean != null ) {
		
			strHost 			= CommonUtil.isNull(bean.getNode_id());
			strAccessGubun		= CommonUtil.isNull(bean.getAccess_gubun());
			iPort 				= Integer.parseInt(CommonUtil.isNull(bean.getAccess_port()));
			strUserId 			= CommonUtil.isNull(bean.getAgent_id());
			strUserPw 			= SeedUtil.decodeStr(CommonUtil.isNull(bean.getAgent_pw()));
		}		
		
		System.out.println(strHost);
		System.out.println(strAccessGubun);
		System.out.println(iPort);
		System.out.println(strUserId);
		System.out.println(strUserPw);
		
		String cmLog 	= "";
		String cmd 		= "";
		
		if(!"".equals(strHost)) {
			
			cmd = "ctmlog listord "+strOrderId+" '*' ";			
			
			if ( hostname.toUpperCase().indexOf(strDataCenter.toUpperCase()) > -1 ) {
				
				Process proc 					= null;
				InputStream inputStream 		= null;
				BufferedReader bufferedReader 	= null;
				String[] cmd2					= null;

				cmd2 = new String[] { "/bin/sh", "-c", cmd };

				proc = Runtime.getRuntime().exec(cmd2);			
				inputStream = proc.getInputStream();
				bufferedReader = new BufferedReader( new InputStreamReader( inputStream, "UTF-8"));
			
				bufferedReader.close();
				inputStream.close();
				
			} else {

				if( "S".equals(strAccessGubun) ){					
					Ssh2Util su = new Ssh2Util(strHost, iPort, strUserId, strUserPw, cmd, "UTF-8");
					cmLog = su.getOutput();
				}else{
					TelnetUtil tu = new TelnetUtil(strHost, iPort, strUserId, strUserPw, cmd);
					cmLog = tu.getOutput();
				}
			}
			
		}else{
			cmLog = CommonUtil.getMessage("ERROR.09");
		}
		
		ModelAndView output = null;
		//output = new ModelAndView("ezjobs/m/popup/cmLog");
		output = new ModelAndView("contents/popup/cmLog");
		output.addObject("cmLog",cmLog);
		
    	return output;
	}
	
	@SuppressWarnings("unchecked")
	public ModelAndView ez006_new(HttpServletRequest req, HttpServletResponse res ) throws ServletException, IOException, Exception {
		
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		
		String order_id = CommonUtil.isNull(paramMap.get("order_id"));
		logger.info("# mPopUpController | ez006_new | order_id : "+order_id);
		
		long l_order_id = Long.parseLong("0"+order_id, 36);		//36진수를 10진수로 변환을 한다.
		
		logger.info("# mPopUpController | ez006_new | long_order_id : "+l_order_id);
		
		paramMap.put("order_no", l_order_id);
		
		ModelAndView output = null;
		output = new ModelAndView("contents/popup/ctmLog");
		output.addObject("paramMap", paramMap);
		
		return output;
	}
	
	// CMLOG FTP 로그보기.
	public ModelAndView ez006_ftp(HttpServletRequest req,
			HttpServletResponse res) throws ServletException, IOException, Exception {
		
		//ModelAndView output = new ModelAndView("ezjobs/m/popup/cmLog");
		ModelAndView output = new ModelAndView("contents/popup/cmLog");
		
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));

		String strDataCenter 	= CommonUtil.isNull(paramMap.get("data_center"));
		String strOrderId	 	= CommonUtil.isNull(paramMap.get("order_id"));
		String strOdate	 		= CommonUtil.isNull(paramMap.get("odate"));
		String hostname 		= CommonUtil.getHostIp();
		
		String strCmLogContent 	= "";
		String cmd 				= "";

		// 부산은행에서 CMLOG 를 파일로 저장하고 있을지 정확히 몰라서 일단 파일 조회는 주석 처리 (2023.07.17 강명준) 
		/*String strFilePath 		= CommonUtil.getMessage("CMLOG.PATH") + strDataCenter.split(",")[1] + "/" + strOdate.replaceAll("/", "");
		String strFileName		= strOrderId;
		
		File f = new File(strFilePath, strFileName);
				
		logger.info("strFilePath : " + strFilePath);
		logger.info("strFileName : " + strFileName);
		
		// Host 정보 가져오는 서비스.
		paramMap.put("data_center"	, strDataCenter);
		paramMap.put("host"			, strDataCenter);
		paramMap.put("server_gubun"	, "S");
		
		CommonBean bean = commonService.dGetHostInfo(paramMap);
		
		String strHost 				= "";
		String strAccessGubun		= "";
		int iPort 					= 0;
		String strUserId 			= "";
		String strUserPw 			= "";
		
		if ( bean != null ) {
		
			strHost 			= CommonUtil.isNull(bean.getNode_id());
			strAccessGubun		= CommonUtil.isNull(bean.getAccess_gubun());
			iPort 				= Integer.parseInt(CommonUtil.isNull(bean.getAccess_port()));
			strUserId 			= CommonUtil.isNull(bean.getAgent_id());
			strUserPw 			= SeedUtil.decodeStr(CommonUtil.isNull(bean.getAgent_pw()));
		}
		
		// 1. 로컬 경로에서 CMLOG 파일 확인.
		if(!"".equals(strHost)) {
			
			cmd = "cat " + strFilePath + "/" + strFileName;
			
			logger.info("cmd : " + cmd);
			
			if ( hostname.toUpperCase().indexOf(strDataCenter.split(",")[1].toUpperCase()) > -1 ) {
				
				Process proc 					= null;
				InputStream inputStream 		= null;
				BufferedReader bufferedReader 	= null;
				String[] cmd2					= null;

				cmd2 = new String[] { "/bin/sh", "-c", cmd };

				proc = Runtime.getRuntime().exec(cmd2);			
				inputStream = proc.getInputStream();
				bufferedReader = new BufferedReader( new InputStreamReader( inputStream, "UTF-8"));
			
				String line 		= "";
				
				while (( line = bufferedReader.readLine()) != null ) {
					strCmLogContent += (line + "<br>");
				}
				
				bufferedReader.close();
				inputStream.close();
				
			} else {

				if( "S".equals(strAccessGubun) ){					
					Ssh2Util su = new Ssh2Util(strHost, iPort, strUserId, strUserPw, cmd, "UTF-8");
					strCmLogContent = su.getOutput();
				}else{
					TelnetUtil tu = new TelnetUtil(strHost, iPort, strUserId, strUserPw, cmd);
					strCmLogContent = tu.getOutput();
				}
			}
		}
		
		logger.info("strCmLogContent : " + strCmLogContent);*/
		
		String strDataCenterCode = "";
		
		if ( !strDataCenter.equals("") && strDataCenter.indexOf(",") > -1 ) {
			strDataCenter = strDataCenter.split(",")[1];
		}
		
		List<CommonBean> dataCenterList = CommonUtil.getDataCenterList();
		
		for(int i=0;i<dataCenterList.size();i++){
			CommonBean bean = dataCenterList.get(i);
			
			if(strDataCenter.equals(bean.getData_center())){
				strDataCenterCode = CommonUtil.isNull(bean.getData_center_code());
				
				break;
			}    				
		}
		
		// 2. DB에서 CMLOG 확인.
		paramMap.put("CTMSVR_SCHEMA", CommonUtil.getMessage("DB."+strDataCenterCode+".SCHEMA"));
		
		List jobLogList = popupJobDetailCtmService.dGetJobLogListContent(paramMap);
		
		String strKeystmp 			= "";
		String strCmLog 			= "";
		String strCmLogDbContent 	= "";
		String strTotalCmLog		= "";
		
		StringBuffer sb 		= new StringBuffer();
		StringBuffer sb2 		= new StringBuffer();
		StringBuffer sb3 		= new StringBuffer();
		StringBuffer total_sb 	= new StringBuffer();
		
		/*String[] arrCmLogContent = null;
		
		if ( !strCmLogDbContent.equals("") ) {
			sb.append("\n");
		}
		
		arrCmLogContent = strCmLogContent.split("\n");

		if ( arrCmLogContent != null ) {
		
			for (int i = 0; i < arrCmLogContent.length; i++) {
	
				String[] arrCmLogId = arrCmLogContent[i].split(",");
				
				String strCmLogId = CommonUtil.isNull(arrCmLogId[0]);
				
				// 실제 데이터
				//sb3.append(arrCmLogContent[i].substring(arrCmLogContent[i].indexOf(",")+2, arrCmLogContent[i].length()));
				sb3.append(arrCmLogContent[i]);
				sb3.append("\n");
				
				// DB CMLOG와 비교하기 위해 ID를 셋팅.
				sb2.append(strCmLogId);
				sb2.append("\n");
			}
		}*/

		for (int i = 0; i < jobLogList.size(); i++) {
			
			JobLogBean jobLogBean = (JobLogBean)jobLogList.get(i);
			
			strKeystmp 	= CommonUtil.isNull(jobLogBean.getKeystmp());
			strCmLog 	= CommonUtil.isNull(jobLogBean.getCm_log());

			// 파일로 가져온 CMLOG와 DB의 CMLOG를 비교해서 FTP에 있으면 제외한다.
			//if ( sb2.toString().indexOf(strKeystmp) == -1 ) {
				sb.append(strCmLog);
				sb.append("\n");
			//}
		}

		//strCmLogContent = sb3.toString() + sb.toString();
		strCmLogContent = sb.toString();
		
		// CMLOG 가 없을 경우.
		if ( !strCmLogContent.equals("") ) {
		
			// 실제 노출될 CMLOG를 사용자 요구사항에 맞게 한번에 가공.
			String arrTotalCmLogContent[] 	= strCmLogContent.split("\n");
			String strTotalCmLogId			= "";
			String strTotalCmLogDate		= "";
			String strTotalCmLogTime		= "";
			String strTotalCmLogMId			= "";
			String strTotalCmLogContent		= "";
			
			total_sb.append("      Date       |     Time        |       Message          ");
			total_sb.append("\n");
			total_sb.append("---------------------------------------------------------------------------------------------------------");
			total_sb.append("\n");
			
			List<String> list = new ArrayList<String>();
	
			for (int i = 0; i < arrTotalCmLogContent.length; i++) {
				
				String arrTotalCmLogCont[] 	= arrTotalCmLogContent[i].split(" , ");
				
				strTotalCmLogId 		= arrTotalCmLogCont[0];
				strTotalCmLogDate 		= arrTotalCmLogCont[1];
				strTotalCmLogTime 		= arrTotalCmLogCont[2];
				strTotalCmLogMId		= arrTotalCmLogCont[3];
				strTotalCmLogContent 	= arrTotalCmLogCont[4];
	
				strTotalCmLogDate = strTotalCmLogDate.substring(0, 4) + "년 " + strTotalCmLogDate.substring(4, 6) + "월 " + strTotalCmLogDate.substring(6, 8) + "일 ";
				strTotalCmLogTime = strTotalCmLogTime.substring(0, 2) + "시 " + strTotalCmLogTime.substring(2, 4) + "분 " + strTotalCmLogTime.substring(4, 6) + "초 ";
				
				strCmLogContent = strTotalCmLogDate + " | " + strTotalCmLogTime + " | " + strTotalCmLogContent;
	
				total_sb.append(strCmLogContent);
				total_sb.append("\n");
	 		}
			
			strTotalCmLog = total_sb.toString();
			
			//System.out.println("list 정렬전: " + list);
	
			//Collections.sort(list);
			
			//System.out.println("list 정렬후: " + list);
			
		} else {
			
			strTotalCmLog = CommonUtil.getMessage("ERROR.23");			
		}

		output.addObject("cmLog", strTotalCmLog);

		return output;
	}
	
	public ModelAndView ez006_mf(HttpServletRequest req, HttpServletResponse res ) 
										throws ServletException, IOException, Exception{
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		
		String data_center 	= CommonUtil.isNull(paramMap.get("data_center"));
		String order_id 	= CommonUtil.isNull(paramMap.get("order_id"));
		
		String job_name 	= CommonUtil.isNull(paramMap.get("job_name"));
		String odate 	= CommonUtil.isNull(paramMap.get("odate"));
		
		String host = CommonUtil.isNull(CommonUtil.getMessage("CM.FTP."+data_center.toUpperCase()+".HOST") );
		int port = Integer.parseInt(CommonUtil.isNull(CommonUtil.getMessage("CM.FTP."+data_center.toUpperCase()+".PORT"),"21" ));
		String user = CommonUtil.isNull(CommonUtil.getMessage("CM.FTP."+data_center.toUpperCase()+".USER") );
		String pw = CommonUtil.isNull(CommonUtil.getMessage("CM.FTP."+data_center.toUpperCase()+".PW") );
		
		String cmLog = "";
		if(!"".equals(host)){
			
			if( "FTP".equals(CommonUtil.isNull(CommonUtil.getMessage("CM.FTP."+data_center.toUpperCase()+".GB"))) ){
				try{
					FtpUtil fu = new FtpUtil();
					if( fu.connect(host, port) ){
						if( fu.login(user, pw, true) ){
							String local_path = getServletContext().getRealPath("/WEB-INF/files/cmlog");
							
							File f = new File(local_path,"ezjobscm.txt");
							
							String jesjobname = "EZJOBSCM";
							
							BufferedWriter bw = new BufferedWriter(new FileWriter(f));
							bw.write("//"+jesjobname+" JOB ,CLASS=A,MSGCLASS=Z,REGION=0M,MSGLEVEL=(1,1)      ");bw.newLine();
							bw.write("//*                                                                    ");bw.newLine();
							bw.write("//         JCLLIB  ORDER=BMC.IOA6220.PROCLIB                           ");bw.newLine();
							bw.write("//         INCLUDE MEMBER=IOASET                                       ");bw.newLine();
							bw.write("//*-----------------------------------------------------------------*  ");bw.newLine();
							bw.write("//         EXEC IOARKSL                                                ");bw.newLine();
							bw.write("//*-----------------------------------------------------------------*  ");bw.newLine();
							bw.write("//DAKSLOUT DD DUMMY                                                    ");bw.newLine();
							bw.write("//DACALL   DD DISP=SHR,DSN=BMC.KMS.JCL                                 ");bw.newLine();
							bw.write("//         DD DISP=SHR,DSN=BMC.IOA6220.KSL                             ");bw.newLine();
							bw.write("//DAKSLREP DD SYSOUT=X                                                 ");bw.newLine();
							bw.write("//*-----------------------------------------------------------------*  ");bw.newLine();
							bw.write("//SYSIN    DD *                                                        ");bw.newLine();
							bw.write("  TRACE OFF                                                            ");bw.newLine();
							bw.write("  MAXCOMMAND 999999                                                    ");bw.newLine();
							bw.write("  CALLMEM REPCMLOG "+job_name+" "+odate+" "+odate+"                    ");bw.newLine();
							bw.write("  END                                                                  ");bw.newLine();
							bw.write("/*                                                                  ");bw.newLine();
							bw.write("//");
							
							bw.flush();
							bw.close();
							
							fu.sendSiteCommand("quote site file=jes jesjobname="+jesjobname+" jesowner=* ");
							String[] files = fu.listNames();
							for(int i=0; null!=files&&i<files.length; i++){
								fu.delFile(files[i]);
							}
							
							if( fu.sendSiteCommand("quote site file=jes") ){
								if( fu.upFile("", f) ){
									
									fu.sendSiteCommand("quote site file=jes jesjobname="+jesjobname+" jesowner=* ");
									String file_name = "";
									int cnt=0;
									while(true){
										cnt++;
										if( null!=fu.listNames() ){
											file_name = fu.listNames()[0];
											break;
										}
										if( cnt>3)	break;
									}
									
									if( !"".equals(file_name) && fu.downFile("", file_name, file_name, local_path)){
										File f1 = new File(local_path,file_name);
										if( f1.exists() ){
											InputStream is = new FileInputStream(f1);
											BufferedReader br = new BufferedReader(new InputStreamReader(is));
											
											String line;
											while ((line = br.readLine()) != null) {
												cmLog += (line+"\r\n");
											}
											br.close();
											is.close();
											f1.delete();
										}
									}
								}else{
									throw new Exception();
								}
							}else{
								throw new Exception();
							}
						}else{
							throw new Exception();
						}
						fu.disconnect();
					}else{
						throw new Exception();
					}
				}catch(Exception e){
					cmLog = CommonUtil.getMessage("ERROR.09");
					e.printStackTrace();
				}finally{
					
				}
			}
		}else{
			cmLog = CommonUtil.getMessage("ERROR.09");
		}
    	
		ModelAndView output = null;
		output = new ModelAndView("ezjobs/m/popup/cmLog");
		output.addObject("cmLog",cmLog);
		
    	return output;
	}
	
	public ModelAndView ez007(HttpServletRequest req, HttpServletResponse res ) 
										throws ServletException, IOException, Exception{
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		
		String data_center 	= CommonUtil.isNull(paramMap.get("data_center"));
		String order_id 	= CommonUtil.isNull(paramMap.get("order_id"));
		
		String host 	= CommonUtil.isNull(CommonUtil.getMessage("CM.TERMINAL."+data_center.toUpperCase()+".HOST") );
		int port 		= Integer.parseInt(CommonUtil.isNull(CommonUtil.getMessage("CM.TERMINAL."+data_center.toUpperCase()+".PORT"),"22" ));
		String user 	= CommonUtil.isNull(CommonUtil.getMessage("CM.TERMINAL."+data_center.toUpperCase()+".USER") );
		String pw 		= CommonUtil.isNull(CommonUtil.getMessage("CM.TERMINAL."+data_center.toUpperCase()+".PW") );
		
		String sysout = "";
		
		if(!"".equals(host)){
			String cmd = " ctmpsm -LISTSYSOUT "+order_id+" ";
			
			if( "SSH".equals(CommonUtil.isNull(CommonUtil.getMessage("CM.TERMINAL."+data_center.toUpperCase()+".GB"))) ){
				Ssh2Util su = new Ssh2Util(host, port, user, pw, cmd, "UTF-8");
				sysout = su.getOutput();
			}else{
				TelnetUtil tu = new TelnetUtil(host,port,user,pw,cmd);
				sysout = tu.getOutput();
			}
		}else{
			sysout = CommonUtil.getMessage("ERROR.09");
		}
    	
		ModelAndView output = null;
		output = new ModelAndView("ezjobs/m/popup/sysout");
		output.addObject("sysout",sysout);
		
    	return output;
	}
	
	// SYSOUT 로컬 로그 및 FTP 로그보기.
	public ModelAndView ez007_ftp(HttpServletRequest req, HttpServletResponse res ) 
			throws ServletException, IOException, Exception {
		
		ModelAndView output = new ModelAndView("ezjobs/m/popup/sysout");
		
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));

		String strDataCenter 	= CommonUtil.isNull(paramMap.get("data_center"));
		String strOrderId	 	= CommonUtil.isNull(paramMap.get("order_id"));
		String strRerunCount 	= CommonUtil.isNull(paramMap.get("rerun_count"));
		String strEndDate	 	= CommonUtil.isNull(paramMap.get("end_date"));
		String strMemName	 	= CommonUtil.isNull(paramMap.get("memname"));
		String strNodeId	 	= CommonUtil.isNull(paramMap.get("node_id"));
		String strJobName	 	= CommonUtil.isNull(paramMap.get("job_name"));

		//String strFilePath 		= CommonUtil.getMessage("SYSOUT.PATH") + strDataCenter + "/" + strEndDate;
		String strFilePath 		= "ctm_agent/ctm/sysout";
		String strFileName		= strMemName + ".LOG_" + strOrderId + "_" + strRerunCount;
		
		File f = new File(strFilePath, strFileName);
		
		String strSysoutContent = "";
		
		// 일단 C-M 서버로 FTP 접근해서 파일 유무 체크.
		FtpUtil fu = new FtpUtil();
		
		String strHost 				= CommonUtil.isNull(CommonUtil.getMessage("CM.TERMINAL."+strDataCenter.toUpperCase()+".HOST") );
		int iPort 					= 21;
		String strUserId 			= CommonUtil.isNull(CommonUtil.getMessage("CM.TERMINAL."+strDataCenter.toUpperCase()+".USER") );
		String strUserPw 			= CommonUtil.isNull(CommonUtil.getMessage("CM.TERMINAL."+strDataCenter.toUpperCase()+".PW") );
		String strRemoteFilePath 	= strFilePath;

		if ( fu.connect(strHost, iPort) ) {
			
			logger.debug("SYSOUT FTP CONNECT OK.");
				
			if ( fu.login(strUserId, strUserPw, true) ) {
				
				logger.debug("SYSOUT FTP LOGIN OK.");

				// 해당 날짜 폴더 없으면 생성.
				if ( !new File(strFilePath).exists() ) {
					
					new File(strFilePath).mkdirs();
					
					// 자바에서 폴더 권한 주기.
					//String strCmd = "chmod 777 " + strFilePath; 
					//Runtime rt = Runtime.getRuntime(); 
					//Process p = rt.exec(strCmd); 
					//p.waitFor(); 						
				}					
				
				logger.debug("SYSOUT FTP GET READY.");
			
				if( fu.downFile(strRemoteFilePath, strFileName, strFileName, strFilePath)) {
					
					logger.debug("SYSOUT FTP GET OK.");
					
					if( f.exists() ) {
						
						InputStream is 		= new FileInputStream(f);
						
						//BufferedReader br	= new BufferedReader(new InputStreamReader(is));
						BufferedReader br = new BufferedReader(new InputStreamReader(is,"UTF-8"));
						
						String line;
						
						while ((line = br.readLine()) != null) {
							strSysoutContent += (line+"\r\n");
						}
						
						//strSysoutContent = CommonUtil.E2K(strSysoutContent);
						strSysoutContent = strSysoutContent;
						
						br.close();
						is.close();
						f.delete();
					}
					
					logger.debug("Sysout Ftp login End.");
					
					fu.disconnect();
					
				} else {
					
					// 로컬에 파일이 없을 경우 FTP로 접근 및 로컬로 가져와서 읽는다.					
					fu = new FtpUtil();
					
					// Host 정보 가져오는 서비스.	
					paramMap.put("data_center"	, strDataCenter);
					paramMap.put("host"			, strNodeId);
					
					CommonBean bean = commonService.dGetHostInfo(paramMap);
					
					strHost 			= "";
					iPort 				= 0;
					strUserId 			= "";
					strUserPw 			= "";
					strRemoteFilePath 	= "";
					
					if ( bean != null ) {
					
						strHost 			= bean.getNode_id();
						iPort 				= 21;
						strUserId 			= bean.getAgent_id();
						strUserPw 			= bean.getAgent_pw();
						strRemoteFilePath	= bean.getFile_path();
					}		

		 			if ( fu.connect(strHost, iPort) ) {
		 				
		 				logger.debug("SYSOUT FTP CONNECT OK.");
		 				
						if ( fu.login(strUserId, strUserPw, true) ) {
							
							logger.debug("SYSOUT FTP LOGIN OK.");
							
							//File f1 = new File(strFilePath, strFileName);
							
							// 해당 날짜 폴더 없으면 생성.
							if ( !new File(strFilePath).exists() ) {
								
								new File(strFilePath).mkdirs();
								
								// 자바에서 폴더 권한 주기.
								//String strCmd = "chmod 777 " + strFilePath; 
								//Runtime rt = Runtime.getRuntime(); 
								//Process p = rt.exec(strCmd); 
								//p.waitFor(); 						
							}					
							
							//new File(strFilePath).mkdirs();
							
							logger.debug("SYSOUT FTP GET READY.");
						
							if( fu.downFile(strRemoteFilePath, strFileName, strFileName, strFilePath)) {
								
								logger.debug("SYSOUT FTP GET OK.");
								
								if( f.exists() ) {
									
									InputStream is 		= new FileInputStream(f);
									BufferedReader br	= new BufferedReader(new InputStreamReader(is));
									
									String line;
									
									while ((line = br.readLine()) != null) {
										strSysoutContent += (line+"\r\n");
									}
									
									//strSysoutContent = CommonUtil.E2K(strSysoutContent);
									strSysoutContent = strSysoutContent;
									
									br.close();
									is.close();
									f.delete();
								}
								
								logger.debug("Sysout Ftp login End.");
								
								fu.disconnect();
								
							// 로컬, 원격 둘다 파일이 존재 하지 않음.
							} else {	
								fu.disconnect();
								f.delete();						
								strSysoutContent = CommonUtil.getMessage("ERROR.23");
							}
							
						// FTP 접근 불가.
			 			} else {	 	
			 				fu.disconnect();
			 				strSysoutContent = CommonUtil.getMessage("ERROR.19");					
						}
						
				 	// FTP 접근 불가.
		 			} else { 				
		 				strSysoutContent = CommonUtil.getMessage("ERROR.19");
		 			}					
				}
			}			
		}		
		
		output.addObject("sysout", strSysoutContent);

		// JOBMAPPER 에서 로그 정보 가져오기.
		paramMap.put("job_name", strJobName);
		output.addObject("jobMapperInfo", worksUserService.dGetJobMapperInfo(paramMap));

		return output;
	}
	
	public ModelAndView ez007_telnet(HttpServletRequest req, HttpServletResponse res ) throws ServletException, IOException, Exception {
		
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		ModelAndView output = new ModelAndView("contents/popup/sysout");
		return output;
		
	}
	
	public ModelAndView ez007_telnet_exec(HttpServletRequest req, HttpServletResponse res ) throws ServletException, IOException, Exception {
		
		ModelAndView output = new ModelAndView("contents/popup/sysout");
		
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));

		String strDataCenter 	= CommonUtil.isNull(paramMap.get("data_center"));
		String strOrderId	 	= CommonUtil.isNull(paramMap.get("order_id"));
		String strRerunCount 	= CommonUtil.isNull(paramMap.get("rerun_count"));
		String strNodeId	 	= CommonUtil.isNull(paramMap.get("node_id"));
		String strJobName	 	= CommonUtil.isNull(paramMap.get("job_name"));
		String strCmd	 		= CommonUtil.isNull(paramMap.get("cmd"));

		String strFileName		= strJobName + ".LOG_" + strOrderId + "_" + strRerunCount;
		
		String strSysoutContent = "";

		// Host 정보 가져오는 서비스.	
		paramMap.put("data_center"	, strDataCenter);
		paramMap.put("host"			, strNodeId);
		paramMap.put("server_gubun"	, "A");
		
		CommonBean bean = commonService.dGetHostInfo(paramMap);
		String strHost 				= "";
		String strAccessGubun		= "";
		int iPort 					= 0;
		String strUserId 			= "";
		String strUserPw 			= "";
		String strRemoteFilePath 	= "";

		if ( bean != null ) {
		
			strHost 			= CommonUtil.isNull(bean.getNode_id());
			strAccessGubun		= CommonUtil.isNull(bean.getAccess_gubun());
			iPort 				= Integer.parseInt(CommonUtil.isNull(bean.getAccess_port()));
			strUserId 			= CommonUtil.isNull(bean.getAgent_id());
			strUserPw 			= SeedUtil.decodeStr(CommonUtil.isNull(bean.getAgent_pw()));
			strRemoteFilePath	= CommonUtil.isNull(bean.getFile_path());
		}
		
		String cmd = (String) strCmd;

		if(!"".equals(strHost)){
			
			
			if (cmd == null || cmd.trim().length() < 1) {
				cmd = "cat " + strRemoteFilePath + strFileName;
			} else {
				cmd = cmd + " " + strRemoteFilePath + strFileName;
			}
			
			if(!cmd.equals("")) {
				cmd = cmd.replaceAll("&apos;","\'").replaceAll("&amp;quot;","\"").replaceAll("&quot;","\"");
			}
			
			if( "S".equals(strAccessGubun) ){
				//SshUtil su = new SshUtil(strHost, iPort, strUserId, strUserPw, cmd, "EUC-KR");
				Ssh2Util su = new Ssh2Util(strHost, iPort, strUserId, strUserPw, cmd, "UTF-8");
				strSysoutContent = su.getOutput();
				
				// OS LANG이 "C" 이기 때문에 한번 더 인코딩 해준다.
				//strSysoutContent = new String (strSysoutContent.getBytes("EUC-KR"), "UTF-8");
				//strSysoutContent = CommonUtil.E2K(strSysoutContent);

			}else{
				TelnetUtil tu = new TelnetUtil(strHost, iPort, strUserId, strUserPw, cmd);
				strSysoutContent = tu.getOutput();
				
				// OS LANG이 "C" 이기 때문에 한번 더 인코딩 해준다.
				//strSysoutContent = new String (strSysoutContent.getBytes("iso_8859_1"), "MS949");
				//strSysoutContent = CommonUtil.K2E(strSysoutContent);
			}
		}else{
			strSysoutContent = CommonUtil.getMessage("ERROR.09");
		}
		
		output.addObject("sysout", 		strSysoutContent);
		output.addObject("real_cmd", 	cmd);

		return output;
	}
	
	public void ez007_telnet_down(HttpServletRequest req, HttpServletResponse res ) 
			throws ServletException, IOException, Exception {
		
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		
		String strDataCenter 	= CommonUtil.isNull(paramMap.get("data_center"));
		String strOrderId	 	= CommonUtil.isNull(paramMap.get("order_id"));
		String strRerunCount 	= CommonUtil.isNull(paramMap.get("rerun_count"));
		String strNodeId	 	= CommonUtil.isNull(paramMap.get("node_id"));
		String strJobName	 	= CommonUtil.isNull(paramMap.get("job_name"));
		String strCmd	 		= CommonUtil.isNull(paramMap.get("cmd"));
		
		String strFileName		= strJobName + ".LOG_" + strOrderId + "_" + strRerunCount;
		
		String strSysoutContent = "";
		
		// Host 정보 가져오는 서비스.	
		paramMap.put("data_center"	, strDataCenter);
		paramMap.put("host"			, strNodeId);
		paramMap.put("server_gubun"	, "A");
		
		CommonBean bean = commonService.dGetHostInfo(paramMap);
		String strHost 				= "";
		String strAccessGubun		= "";
		int iPort 					= 0;
		String strUserId 			= "";
		String strUserPw 			= "";
		String strRemoteFilePath 	= "";
		
		if ( bean != null ) {
			
			strHost 			= CommonUtil.isNull(bean.getNode_id());
			strAccessGubun		= CommonUtil.isNull(bean.getAccess_gubun());
			iPort 				= Integer.parseInt(CommonUtil.isNull(bean.getAccess_port()));
			strUserId 			= CommonUtil.isNull(bean.getAgent_id());
			strUserPw 			= SeedUtil.decodeStr(CommonUtil.isNull(bean.getAgent_pw()));
			strRemoteFilePath	= CommonUtil.isNull(bean.getFile_path());
		}
		
		if(!"".equals(strHost)){
			
			String cmd = (String) strCmd;
			if (cmd == null || cmd.trim().length() < 1) {
				cmd = "cat " + strRemoteFilePath + strFileName;
			} else {
				cmd = cmd + " " + strRemoteFilePath + strFileName;
			}
			
			if(!cmd.equals("")) {
				cmd = cmd.replaceAll("&apos;","\'").replaceAll("&amp;quot;","\"").replaceAll("&quot;","\"");
			}
			
			if( "S".equals(strAccessGubun) ){
				Ssh2Util su = new Ssh2Util(strHost, iPort, strUserId, strUserPw, cmd, "UTF-8");
				strSysoutContent = su.getOutput();
			}else{
				TelnetUtil tu = new TelnetUtil(strHost, iPort, strUserId, strUserPw, cmd);
				strSysoutContent = tu.getOutput();
			}
		}else{
			strSysoutContent = CommonUtil.getMessage("ERROR.09");
		}
		
		
		res.setCharacterEncoding("UTF-8");
		res.setContentType("text/html; charset=UTF-8");
		res.setHeader("Content-Disposition", "attachment; filename=" + URLEncoder.encode(strFileName, "UTF-8") + ";");
		PrintWriter a = res.getWriter();
		a.write(strSysoutContent);
		a.flush();
		a.close();
	}
	
	// 배치로그 FTP 보기.
	public ModelAndView ez007_batch_log_ftp(HttpServletRequest req, HttpServletResponse res ) 
			throws ServletException, IOException, Exception {
		
		ModelAndView output = new ModelAndView("ezjobs/m/popup/batch_log");
		
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));

		String strLogFilePath 	= CommonUtil.isNull(paramMap.get("log_file_path"));
		String strDataCenter 	= CommonUtil.isNull(paramMap.get("data_center"));
		String strNodeId	 	= CommonUtil.isNull(paramMap.get("node_id"));
		String strFileName	 	= CommonUtil.isNull(paramMap.get("log_file_name"));
		
		String strFilePath 		= CommonUtil.getMessage("BATCHLOG.PATH");
		
		File f = new File(strFilePath, strFileName);

		String strBatchLogContent = "";
		
		FtpUtil fu = new FtpUtil();
		
		// Host 정보 가져오는 서비스.
		paramMap.put("data_center"	, strDataCenter);
		paramMap.put("host"			, strNodeId);
		
		CommonBean bean = commonService.dGetHostInfo(paramMap);
		
		String strHost 				= "";
		int iPort 					= 0;
		String strUserId 			= "";
		String strUserPw 			= "";
		String strRemoteFilePath 	= "";
		
		if ( bean != null ) {
		
			strHost 			= bean.getNode_id();
			iPort 				= 21;
			strUserId 			= bean.getAgent_id();
			strUserPw 			= bean.getAgent_pw();
			strRemoteFilePath	= strLogFilePath;
		}		

		if ( fu.connect(strHost, iPort) ) {
			
			logger.debug("BATCHLOG FTP CONNECT OK.");
			
			if ( fu.login(strUserId, strUserPw, true) ) {
				
				logger.debug("BATCHLOG FTP LOGIN OK.");
				
				// 해당 날짜 폴더 없으면 생성.
				if ( !new File(strFilePath).exists() ) {
					
					new File(strFilePath).mkdirs();
					
					// 자바에서 폴더 권한 주기.
					//String strCmd = "chmod 777 " + strFilePath; 
					//Runtime rt = Runtime.getRuntime(); 
					//Process p = rt.exec(strCmd); 
					//p.waitFor(); 						
				}
				
				logger.debug("BATCHLOG FTP GET READY.");
			
				if( fu.downFile(strRemoteFilePath, strFileName, strFileName, strFilePath)) {
					
					logger.debug("BATCHLOG FTP GET OK.");
					
					if( f.exists() ) {
						
						InputStream is 		= new FileInputStream(f);
						BufferedReader br	= new BufferedReader(new InputStreamReader(is));
						
						String line;
						
						while ((line = br.readLine()) != null) {
							strBatchLogContent += (line+"\r\n");
						}
						
						//strBatchLogContent = CommonUtil.E2K(strBatchLogContent);
						strBatchLogContent = strBatchLogContent;
						
						br.close();
						is.close();
						f.delete();
					}
					
					logger.debug("BATCHLOG Ftp login End.");
					
					fu.disconnect();
					
				// 로컬, 원격 둘다 파일이 존재 하지 않음.
				} else {	
					fu.disconnect();
					f.delete();
					strBatchLogContent = CommonUtil.getMessage("ERROR.23");
				}
				
			// FTP 접근 불가.
 			} else {	 	
 				fu.disconnect();
 				strBatchLogContent = CommonUtil.getMessage("ERROR.19");					
			}
			
	 	// FTP 접근 불가.
		} else { 				
			strBatchLogContent = CommonUtil.getMessage("ERROR.19");
		}
		
		output.addObject("batch_log", strBatchLogContent);

		return output;
	}
	
	public ModelAndView ez007_local(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {
		
		ModelAndView output = new ModelAndView("contents/popup/sysout");
		
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));

		String strDataCenter 	= CommonUtil.isNull(paramMap.get("data_center"));
		String strOrderId 		= CommonUtil.isNull(paramMap.get("order_id"));
		String strNodeId 		= CommonUtil.isNull(paramMap.get("node_id"));
		
		String strFlag 			= CommonUtil.isNull(paramMap.get("flag"));
		String strOdate 		= CommonUtil.isNull(paramMap.get("odate"));
		
		//String run_count 		= CommonUtil.isNull(paramMap.get("now_rerun_count"));
		String strRerunCount 	= CommonUtil.isNull(paramMap.get("rerun_count"));

		String strLogFromLine	= CommonUtil.isNull(paramMap.get("from_line"));
		String strLogToLine	 	= CommonUtil.isNull(paramMap.get("to_line"));
		String strLogMaxLine	= "5000";
		String sysout 			= "";
		String strServerLang 	= "";
		String memname			= CommonUtil.isNull(paramMap.get("memname"));
		String appl_type		= CommonUtil.isNull(paramMap.get("appl_type"));
		String strSysoutYn 		= CommonUtil.isNull(paramMap.get("sysout_yn"), "N");
		
		logger.info("appl_type 		::::: " + appl_type);
		logger.info("strSysoutYn 	::::: " + strSysoutYn);

		//라인 제한 수(코드관리에서 관리)
		paramMap.put("mcode_cd", "M71");
		List sCodeList = commonService.dGetsCodeList(paramMap);
		
		for (int i = 0; null != sCodeList && i < sCodeList.size(); i++) {
			CommonBean sCodeBean = (CommonBean) sCodeList.get(i);
			strLogMaxLine = CommonUtil.isNull(sCodeBean.getScode_nm()); //M71 코드가 등록이 되어있지 않으면 기본 값이 5000줄로 맞춤
		}
		
		if (strLogFromLine.equals("")) {
			strLogFromLine = "1";
		}

		if (strLogToLine.equals("")) {
			strLogToLine = Integer.parseInt(strLogFromLine) + Integer.parseInt(strLogMaxLine) - 1 + "";
		}
		output.addObject("strLogMaxLine", 	strLogMaxLine);
		output.addObject("strLogFromLine", 	strLogFromLine);
		output.addObject("strLogToLine", 	strLogToLine);
		
		//호스트 조회에 필요한 값이 없으면 화면에 메세지 뿌리고 종료.
		if (strDataCenter.equals("") || strNodeId.equals("") || strOrderId.equals("") || strRerunCount.equals("0")) {
			sysout = "호스트 정보를 찾을 수 없습니다. (strDataCenter: "+strDataCenter+", strNodeId: "+strNodeId+")";
			output.addObject("sysout", sysout);
			return output;
		}
		if(strSysoutYn.equals("N")) {
			//Host 정보.
			paramMap.put("data_center"	, strDataCenter);
			paramMap.put("host"			, strNodeId);
			
			String dGetNodeId = commonService.dGetNodeInfo(paramMap); //그룹으로 묶인 AGENT의 경우 RERUN시에 수행서버가 달라질 수 있으므로 작업의 RUNINFO HISTORY를 통해 해당 RERUN COUNT의 수행 AGENT를 조회.
			if (!CommonUtil.isNull(dGetNodeId).equals("")) {
				paramMap.put("host"			, dGetNodeId);
			}
			
			//kubernetes의 작업일 경우 sysout 경로를 C-M magager 서버의 공통경로로 설정
			if(appl_type.equals("KBN062023")) {
				paramMap.put("mcode_cd", "M6");
				sCodeList = commonService.dGetsCodeList(paramMap);
				CommonBean sCodeBean = (CommonBean) sCodeList.get(0);
				String ctmServer = CommonUtil.isNull(sCodeBean.getScode_eng_nm());

				paramMap.put("host"			, ctmServer);
				paramMap.put("node_id"		, ctmServer);
				
				if(CommonUtil.isNull(dGetNodeId).equals("")) {
					dGetNodeId = strNodeId;
				}
			}
			
			CommonBean bean = commonService.dGetHostInfo(paramMap);
			
			String strHost 				= "";
			String strPort 				= "";
			String strUserId 			= "";
			String strUserPw 			= "";
			String strAccessGubun 		= "";
	
			//수행 Agent 정보가 없으면 화면에 메세지 뿌리고 종료.
			if ( bean == null ) {
				sysout = "호스트 정보를 찾을 수 없습니다. (strDataCenter: "+strDataCenter+", strNodeId: "+strNodeId+")";
				output.addObject("sysout", sysout);
				return output;
			} else {
				strHost 			= bean.getNode_id();
				strPort 			= bean.getAccess_port();
				strUserId 			= bean.getAgent_id();
				strUserPw 			= SeedUtil.decodeStr(CommonUtil.isNull(bean.getAgent_pw()));
				strAccessGubun		= CommonUtil.isNull(bean.getAccess_gubun());
				strServerLang		= CommonUtil.isNull(bean.getServer_lang());
			}
			
			String strFileName = "";
			
			if(memname.equals("MFT") || memname.equals("Database")) {
				strFileName = strOrderId.toUpperCase() + "_" + strRerunCount;
			} else {
				//kubernetes 파일명 관련 규칙
				if(appl_type.equals("KBN062023")) {
					strFileName = strOrderId.toUpperCase() + "_" + strRerunCount;
				}else {
					//파일명 관련 규칙 (order_id는 6자리, rerun_count는 5자리)
					strOrderId 		= CommonUtil.lpad(strOrderId, 6, "0");
					strRerunCount 	= CommonUtil.lpad(strRerunCount, 5, "0");
					
					//실시간 수행의 파일명과 파일 경로
					strFileName 			= "*.LOG_" + strOrderId + "_" + strRerunCount;
				}
				
			}
			String strRemoteFilePath 	= CommonUtil.isNull(bean.getFile_path());
			
			//kubernetes의 작업일 경우 sysout 경로를 C-M magager 서버의 공통경로로 설정
			if(appl_type.equals("KBN062023")) {
				paramMap.put("mcode_cd", "M97");
				sCodeList = commonService.dGetsCodeList(paramMap);
				CommonBean sCodeBean = (CommonBean) sCodeList.get(0);
				strRemoteFilePath = CommonUtil.isNull(sCodeBean.getScode_nm()) + "/" + dGetNodeId + "/sysout";
			}
			
			logger.info("strFileName 		::::: " + strFileName);
			logger.info("strRemoteFilePath 	::::: " + strRemoteFilePath);
			
			if (!"".equals(strHost)) {
				if (Integer.parseInt(strLogToLine) - Integer.parseInt(strLogFromLine) < Integer.parseInt(strLogMaxLine)) {
					
					// sed 명령어는 큰 파일을 읽을 때 부하가 있어서, awk 로 변경 (2024.06.20 강명준)
					//String cmd = "sed -n '" + strLogFromLine + "," + strLogToLine + "p' " + strRemoteFilePath + "/" + strFileName;
					String cmd = "awk 'NR>=" + strLogFromLine + " && NR<=" + strLogToLine + "' " + strRemoteFilePath + "/" + strFileName;
					
					logger.debug("cmd : =========" + cmd);
					
					if ( strServerLang.equals("E") ) {
						strServerLang = "EUC-KR";
					} else {
						strServerLang = "UTF-8";
					}
	
					if( "S".equals(strAccessGubun) ){
						//Ssh2Util su = new Ssh2Util(strHost, Integer.parseInt(strPort), strUserId, strUserPw, cmd, "UTF-8");
						Ssh2Util su = new Ssh2Util(strHost, Integer.parseInt(strPort), strUserId, strUserPw, cmd, strServerLang);
						sysout = su.getOutput();					
					}else{
						TelnetUtil tu = new TelnetUtil(strHost, Integer.parseInt(strPort), strUserId, strUserPw, cmd);
						sysout = tu.getOutput();
					}
				} else {
					sysout = "로그 조회 범위를 초과하였습니다.";
				}
			} else {
				sysout = CommonUtil.getMessage("ERROR.09");
			}
			output.addObject("server_lang",		strServerLang);
		}else{
			Map<String, Object> sysMap = new HashMap<String, Object>();

			sysMap.put("SCHEMA", 		CommonUtil.isNull(paramMap.get("SCHEMA")));
			sysMap.put("rerun_count", 	strRerunCount);
			sysMap.put("order_id",		strOrderId);

			JobLogBean jobLogBean = emJobLogService.dGetJobSysout(sysMap);

			if ( jobLogBean != null ) {
				sysout = jobLogBean.getSysout();
			} else {
				sysout = CommonUtil.getMessage("ERROR.09");
			}
		}
		
		output.addObject("server_lang",		strServerLang);
		output.addObject("sysout", 			sysout);
		
		return output;
	}
	
	public void ez007_local_down(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {
		
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));

		String strDataCenter 	= CommonUtil.isNull(paramMap.get("data_center"));
		String strOrderId 		= CommonUtil.isNull(paramMap.get("order_id"));
		String strNodeId 		= CommonUtil.isNull(paramMap.get("node_id"));
		String strJobName 		= CommonUtil.isNull(paramMap.get("job_name"));
		
		String strFlag 			= CommonUtil.isNull(paramMap.get("flag"));
		String strOdate 		= CommonUtil.isNull(paramMap.get("odate"));
		
		//String run_count 		= CommonUtil.isNull(paramMap.get("now_rerun_count"));
		String strRerunCount 	= CommonUtil.isNull(paramMap.get("rerun_count"));

		String strLogFromLine	= CommonUtil.isNull(paramMap.get("from_line"));
		String strLogToLine	 	= CommonUtil.isNull(paramMap.get("to_line"));
		String strLogMaxLine	= "5000";
		String sysout 			= "";
		String memname			= CommonUtil.isNull(paramMap.get("memname"));
		String appl_type		= CommonUtil.isNull(paramMap.get("appl_type"));
		
		//라인 제한 수(코드관리에서 관리)
		paramMap.put("mcode_cd", "M71");
		List sCodeList = commonService.dGetsCodeList(paramMap);
		
		for (int i = 0; null != sCodeList && i < sCodeList.size(); i++) {
			CommonBean sCodeBean = (CommonBean) sCodeList.get(i);
			strLogMaxLine = CommonUtil.isNull(sCodeBean.getScode_nm()); //M71 코드가 등록이 되어있지 않으면 기본 값이 5000줄로 맞춤
		}
		
		if (strLogFromLine.equals("")) {
			strLogFromLine = "1";
		}

		if (strLogToLine.equals("")) {
			strLogToLine = Integer.parseInt(strLogFromLine) + Integer.parseInt(strLogMaxLine) - 1 + "";
		}
		
		//호스트 조회에 필요한 값이 없으면 화면에 메세지 뿌리고 종료.
		if (strDataCenter.equals("") || strNodeId.equals("") || strOrderId.equals("") || strRerunCount.equals("0")) {
			sysout = "호스트 정보를 찾을 수 없습니다. (strDataCenter: "+strDataCenter+", strNodeId: "+strNodeId+")";
		}
		
		//Host 정보.
		paramMap.put("data_center"	, strDataCenter);
		paramMap.put("host"			, strNodeId);
		
		String dGetNodeId = commonService.dGetNodeInfo(paramMap); //그룹으로 묶인 AGENT의 경우 RERUN시에 수행서버가 달라질 수 있으므로 작업의 RUNINFO HISTORY를 통해 해당 RERUN COUNT의 수행 AGENT를 조회.
		if (!CommonUtil.isNull(dGetNodeId).equals("")) {
			paramMap.put("host"			, dGetNodeId);
		}
		
		//kubernetes의 작업일 경우 sysout 경로를 C-M magager 서버의 공통경로로 설정
		if(appl_type.equals("KBN062023")) {
			paramMap.put("mcode_cd", "M6");
			sCodeList = commonService.dGetsCodeList(paramMap);
			CommonBean sCodeBean = (CommonBean) sCodeList.get(0);
			String ctmServer = CommonUtil.isNull(sCodeBean.getScode_eng_nm());

			paramMap.put("host"			, ctmServer);
			paramMap.put("node_id"		, ctmServer);
			
			if(CommonUtil.isNull(dGetNodeId).equals("")) {
				dGetNodeId = strNodeId;
			}
		}
		
		CommonBean bean = commonService.dGetHostInfo(paramMap);
		
		String strHost 				= "";
		String strPort 				= "";
		String strUserId 			= "";
		String strUserPw 			= "";
		String strAccessGubun 		= "";
		String strServerLang 		= "";

		//수행 Agent 정보가 없으면 화면에 메세지 뿌리고 종료.
		if ( bean == null ) {
			sysout = "호스트 정보를 찾을 수 없습니다. (strDataCenter: "+strDataCenter+", strNodeId: "+strNodeId+")";
		} else {
			strHost 			= bean.getNode_id();
			strPort 			= bean.getAccess_port();
			strUserId 			= bean.getAgent_id();
			strUserPw 			= SeedUtil.decodeStr(CommonUtil.isNull(bean.getAgent_pw()));
			strAccessGubun		= CommonUtil.isNull(bean.getAccess_gubun());
			strServerLang		= CommonUtil.isNull(bean.getServer_lang());
		}
		
		String strFileName = "";
		
		if(memname.equals("MFT") || memname.equals("Database")) {
			strFileName = strOrderId.toUpperCase() + "_" + strRerunCount;
		} else {
			//kubernetes 파일명 관련 규칙
			if(appl_type.equals("KBN062023")) {
				strFileName = strOrderId.toUpperCase() + "_" + strRerunCount;
			}else {
				//파일명 관련 규칙 (order_id는 6자리, rerun_count는 5자리)
				strOrderId 		= CommonUtil.lpad(strOrderId, 6, "0");
				strRerunCount 	= CommonUtil.lpad(strRerunCount, 5, "0");
				
				//실시간 수행의 파일명과 파일 경로
				strFileName 			= "*.LOG_" + strOrderId + "_" + strRerunCount;
			}
			
		}
		String strRemoteFilePath 	= CommonUtil.isNull(bean.getFile_path());
		
		//kubernetes의 작업일 경우 sysout 경로를 C-M magager 서버의 공통경로로 설정
		if(appl_type.equals("KBN062023")) {
			paramMap.put("mcode_cd", "M97");
			sCodeList = commonService.dGetsCodeList(paramMap);
			CommonBean sCodeBean = (CommonBean) sCodeList.get(0);
			strRemoteFilePath = CommonUtil.isNull(sCodeBean.getScode_nm()) + "/" + dGetNodeId + "/sysout";
		}
		
		logger.info("strFileName 		::::: " + strFileName);
		logger.info("strRemoteFilePath 	::::: " + strRemoteFilePath);
		
		if (!"".equals(strHost)) {
			if (Integer.parseInt(strLogToLine) - Integer.parseInt(strLogFromLine) < Integer.parseInt(strLogMaxLine)) {
				
				// sed 명령어는 큰 파일을 읽을 때 부하가 있어서, awk 로 변경 (2024.06.20 강명준)
				//String cmd = "sed -n '" + strLogFromLine + "," + strLogToLine + "p' " + strRemoteFilePath + "/" + strFileName;
				String cmd = "awk 'NR>=" + strLogFromLine + " && NR<=" + strLogToLine + "' " + strRemoteFilePath + "/" + strFileName;
			
				logger.debug("cmd : =========" + cmd);
				
				if ( strServerLang.equals("E") ) {
					strServerLang = "EUC-KR";
				} else {
					strServerLang = "UTF-8";
				}

				if( "S".equals(strAccessGubun) ){
					//Ssh2Util su = new Ssh2Util(strHost, Integer.parseInt(strPort), strUserId, strUserPw, cmd, "UTF-8");
					Ssh2Util su = new Ssh2Util(strHost, Integer.parseInt(strPort), strUserId, strUserPw, cmd, strServerLang);
					sysout = su.getOutput();					
				}else{
					TelnetUtil tu = new TelnetUtil(strHost, Integer.parseInt(strPort), strUserId, strUserPw, cmd);
					sysout = tu.getOutput();
				}
			} else {
				sysout = "로그 조회 범위를 초과하였습니다.";
			}
		} else {
			sysout = CommonUtil.getMessage("ERROR.09");
		}

		res.setCharacterEncoding("UTF-8");
		res.setContentType("text/html; charset=UTF-8");
		res.setHeader("Content-Disposition", "attachment; filename=" + URLEncoder.encode(strJobName + "_" + strRerunCount, "UTF-8") + ";");
		PrintWriter a = res.getWriter();
		a.write(sysout);
		a.flush();
		a.close();
	}
	
	public void ez007_local_down2(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException, Exception {
		
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));

		String strFlag 			= CommonUtil.isNull(paramMap.get("flag"));
		String strDataCenter	= CommonUtil.isNull(paramMap.get("data_center"));
		String strNodeId		= CommonUtil.isNull(paramMap.get("node_id"));
		String strOrderId	 	= CommonUtil.isNull(paramMap.get("order_id"));
		String strRerunCount 	= CommonUtil.isNull(paramMap.get("rerun_count"));
		String strOdate 		= CommonUtil.isNull(paramMap.get("odate"));
		String strJobName 		= CommonUtil.isNull(paramMap.get("job_name"));
		String memname			= CommonUtil.isNull(paramMap.get("memname"));
		String appl_type		= CommonUtil.isNull(paramMap.get("appl_type"));

		// Host 정보.
		paramMap.put("data_center"	, strDataCenter);
		paramMap.put("host"			, strNodeId);

		String dGetNodeId = commonService.dGetNodeInfo(paramMap); //그룹으로 묶인 AGENT의 경우 RERUN시에 수행서버가 달라질 수 있으므로 작업의 RUNINFO HISTORY를 통해 해당 RERUN COUNT의 수행 AGENT를 조회.
		if (!CommonUtil.isNull(dGetNodeId).equals("")) {
			paramMap.put("host"			, dGetNodeId);
		}
		
		CommonBean bean = commonService.dGetHostInfo(paramMap);
		
		String strHost 				= "";
		String strPort 				= "";
		String strUserId 			= "";
		String strUserPw 			= "";
		
		if ( bean != null ) {
			strHost 			= bean.getNode_id();
			strPort 			= bean.getAccess_port();
			strUserId 			= bean.getAgent_id();
			strUserPw 			= SeedUtil.decodeStr(CommonUtil.isNull(bean.getAgent_pw()));
		}
		
		//파일명 관련 규칙 (order_id는 6자리, rerun_count는 5자리)
		strOrderId 		= CommonUtil.lpad(strOrderId, 6, "0");
		strRerunCount 	= CommonUtil.lpad(strRerunCount, 5, "0");
		
		//실시간 수행의 파일명과 파일 경로
		String strFileName = "";

		if(memname.equals("MFT") || memname.equals("Database")) {
			strFileName = strOrderId.toUpperCase() + "_" + strRerunCount;
		} else {
			//kubernetes 파일명 관련 규칙
			if(appl_type.equals("KBN062023")) {
				strFileName = strOrderId.toUpperCase() + "_" + strRerunCount;
			}else {
				//파일명 관련 규칙 (order_id는 6자리, rerun_count는 5자리)
				strOrderId 		= CommonUtil.lpad(strOrderId, 6, "0");
				strRerunCount 	= CommonUtil.lpad(strRerunCount, 5, "0");

				//실시간 수행의 파일명과 파일 경로
				strFileName 			= "*.LOG_" + strOrderId + "_" + strRerunCount;
			}
		}

		System.out.println("strFileName : " + strFileName);
		
		String strRemoteFilePath 	= CommonUtil.isNull(bean.getFile_path());
				
		String sysout = "";

		if (!"".equals(strHost)) {
			
			InputStream in 		= null;
			SftpUtil sftputil 	= new SftpUtil();

			paramMap.put("host",	strHost);
			paramMap.put("user_id", strUserId);
			paramMap.put("user_pw", strUserPw);
			paramMap.put("port", 	Integer.parseInt(strPort));
			
			Session session = sftputil.sftpConnecting(paramMap);

			paramMap.put("REMOTE_DIR", 	strRemoteFilePath);
			paramMap.put("FILE_NAME", 	strFileName);
			
			in = sftputil.download(paramMap, session);
			
			BufferedReader br = new BufferedReader(new InputStreamReader(in));
			
			String line = "";
			while((line = br.readLine()) != null) {
				sysout += (line + "\r\n");
			}
			
			res.setCharacterEncoding("UTF-8");
			res.setContentType("text/html; charset=UTF-8");
			res.setHeader("Content-Disposition", "attachment; filename=" + URLEncoder.encode(strFileName+".txt", "UTF-8") + ";");
			PrintWriter a = res.getWriter();
			a.write(sysout);
			a.flush();
			a.close();
			
			try{
				if(session.isConnected()){
					session.disconnect();
				}
			}catch(Exception e){
				e.printStackTrace();
			}
		} else {
			sysout = CommonUtil.getMessage("ERROR.09");
		}
	}
	
	public ModelAndView ez008(HttpServletRequest req, HttpServletResponse res ) throws ServletException, IOException, Exception {
		
		commonDao = (CommonDao) CommonUtil.getSpringBean("commonDao");
		
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
		
		String strDataCenter 	= CommonUtil.isNull(paramMap.get("data_center"));
		String strOrderId 		= CommonUtil.isNull(paramMap.get("order_id"));
		
		String strGubun			= CommonUtil.isNull(paramMap.get("gubun"));
		String strInCondName	= CommonUtil.isNull(paramMap.get("in_cond_name"));
		String strInCondDate	= CommonUtil.isNull(paramMap.get("in_cond_date"));
		String[] strInCondNames;
		String[] strInCondDates;
		
		String hostname 		= CommonUtil.getHostIp();
		
		// Host 정보 가져오는 서비스.
		paramMap.put("data_center"	, strDataCenter);
		paramMap.put("host"			, strDataCenter);
		paramMap.put("server_gubun"	, "S");
		
		CommonBean bean = commonService.dGetHostInfo(paramMap);
		
		String strHost 				= "";
		String strAccessGubun		= "";
		int iPort 					= 0;
		String strUserId 			= "";
		String strUserPw 			= "";
		
		if ( bean != null ) {
		
			strHost 			= CommonUtil.isNull(bean.getNode_id());
			strAccessGubun		= CommonUtil.isNull(bean.getAccess_gubun());
			iPort 				= Integer.parseInt(CommonUtil.isNull(bean.getAccess_port()));
			strUserId 			= CommonUtil.isNull(bean.getAgent_id());
			strUserPw 			= SeedUtil.decodeStr(CommonUtil.isNull(bean.getAgent_pw()));
		}	
		
		String cmd = "";

		if ( strGubun.equals("in_cond_add") ) {			
			if(strInCondName.contains("||")) {
				strInCondNames = strInCondName.split("\\|\\|");
				strInCondDates = strInCondDate.split("\\|\\|"); 
				StringBuilder cmdBuilder = new StringBuilder();

				for (int i = 0; i < strInCondNames.length; i++) {
				    cmdBuilder.append("ctmcontb -ADD ")
				              .append(strInCondNames[i])
				              .append(" ")
				              .append(strInCondDates[i])
				              .append(";");
				}

				cmd = cmdBuilder.toString();
			}else {
				cmd = "ctmcontb -ADD " + strInCondName + " " + strInCondDate;
			}
		} else {
			cmd = "ctmwhy "+strOrderId+" ";
		}
		
		logger.info("cmd ::: " + cmd);
		
		String ctmWhy 		= "";
		
		if(!"".equals(strHost)){
			
			if ( hostname.toUpperCase().indexOf(strDataCenter.toUpperCase()) > -1 ) {

				Process proc 					= null;
				InputStream inputStream 		= null;
				BufferedReader bufferedReader 	= null;
				String[] cmd2					= null;
				String osName 					= System.getProperty("os.name");
				
				if(osName.toLowerCase().startsWith("window")) {
					cmd2 = new String[] { "cmd.exe", "/y", "/c", cmd };
				} else {
					cmd2 = new String[] { "/bin/sh", "-c", cmd };
				}
	
				proc = Runtime.getRuntime().exec(cmd2);			
				inputStream = proc.getInputStream();
				bufferedReader = new BufferedReader( new InputStreamReader( inputStream, "UTF-8"));
				
				String line 		= "";
				
				while (( line = bufferedReader.readLine()) != null ) {
					ctmWhy += (line + "<br>");				
				}
				
				bufferedReader.close();
				inputStream.close();
				
			} else {

				if( "S".equals(strAccessGubun) ){					
					Ssh2Util su = new Ssh2Util(strHost, iPort, strUserId, strUserPw, cmd, "UTF-8");
					ctmWhy = su.getOutput();
				}else{
					TelnetUtil tu = new TelnetUtil(strHost, iPort, strUserId, strUserPw, cmd);
					ctmWhy = tu.getOutput();
				}
			}
			paramMap.put("r_code", "1");
		}else{
			ctmWhy = CommonUtil.getMessage("ERROR.09");
			paramMap.put("r_code", "-2");
		}
		
		if ( strGubun.equals("in_cond_add") ) {

			logger.info("ez_cond_add_log 테이블에 이력 업데이트");
			
			paramMap.put("flag", "cond_log");
			paramMap.put("send_gubun", "ADD");
			
			if(strInCondName.contains("||")) {
				strInCondNames = strInCondName.split("\\|\\|");
				strInCondDates = strInCondDate.split("\\|\\|"); 

				for (int i = 0; i < strInCondNames.length; i++) {
					paramMap.put("t_conditions_in"	, strInCondNames[i]);
					paramMap.put("odate"		, strInCondDates[i]);
					commonDao.dPrcLog(paramMap);
				}

			}else {
				cmd = "ctmcontb -ADD " + strInCondName + " " + strInCondDate;
				paramMap.put("t_conditions_in"	, strInCondName);
				paramMap.put("odate"		, strInCondDate);
				commonDao.dPrcLog(paramMap);
			}
		}
		
		ModelAndView output = null;
		//output = new ModelAndView("ezjobs/m/popup/ctmWhy");
		if ( strGubun.equals("in_cond_add") ) {
			output = new ModelAndView("result/m_result");
			output.addObject("rMap",paramMap);
		}else {
			output = new ModelAndView("contents/popup/ctmWhy");
		}
		output.addObject("ctmWhy",ctmWhy);
		
    	return output;
	}
	
	public ModelAndView ez008_addInCond(HttpServletRequest req, HttpServletResponse res ) throws ServletException, IOException, Exception {
		
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		
		String strDataCenter 	= CommonUtil.isNull(paramMap.get("data_center"));
		String strInCondName	= CommonUtil.isNull(paramMap.get("in_cond_name"));
		String strInCondDate	= CommonUtil.isNull(paramMap.get("in_cond_date"));
		String hostname 		= CommonUtil.getHostIp();
		
		// Host 정보 가져오는 서비스.
		paramMap.put("data_center"	, strDataCenter);
		paramMap.put("host"			, strDataCenter);
		paramMap.put("server_gubun"	, "S");
		
		CommonBean bean = commonService.dGetHostInfo(paramMap);
		
		String strHost 				= "";
		String strAccessGubun		= "";
		int iPort 					= 0;
		String strUserId 			= "";
		String strUserPw 			= "";
		
		if ( bean != null ) {
		
			strHost 			= CommonUtil.isNull(bean.getNode_id());
			strAccessGubun		= CommonUtil.isNull(bean.getAccess_gubun());
			iPort 				= Integer.parseInt(CommonUtil.isNull(bean.getAccess_port()));
			strUserId 			= CommonUtil.isNull(bean.getAgent_id());
			strUserPw 			= SeedUtil.decodeStr(CommonUtil.isNull(bean.getAgent_pw()));
		}		

		String cmd 			= "ctmcontb -ADD " + strInCondName + " " + strInCondDate;		
		String ctmReturn	= "";
		
		if(!"".equals(strHost)){
			
			if ( hostname.toUpperCase().indexOf(strDataCenter.toUpperCase()) > -1 ) {
				
				Process proc 					= null;
				InputStream inputStream 		= null;
				BufferedReader bufferedReader 	= null;
				String[] cmd2					= null;
				String osName 					= System.getProperty("os.name");
				
				if(osName.toLowerCase().startsWith("window")) {
					cmd2 = new String[] { "cmd.exe", "/y", "/c", cmd };
				} else {
					cmd2 = new String[] { "/bin/sh", "-c", cmd };
				}
	
				proc = Runtime.getRuntime().exec(cmd2);			
				inputStream = proc.getInputStream();
				bufferedReader = new BufferedReader( new InputStreamReader( inputStream, "UTF-8"));
				
				String line 		= "";
				
				while (( line = bufferedReader.readLine()) != null ) {
					ctmReturn += (line + "<br>");				
				}
				
				bufferedReader.close();
				inputStream.close();
				
			} else {
		
				if( "S".equals(strAccessGubun) ){					
					Ssh2Util su = new Ssh2Util(strHost, iPort, strUserId, strUserPw, cmd, "UTF-8");
					ctmReturn = su.getOutput();
				}else{
					TelnetUtil tu = new TelnetUtil(strHost, iPort, strUserId, strUserPw, cmd);
					ctmReturn = tu.getOutput();
				}
			}
			
		}else{
			ctmReturn = CommonUtil.getMessage("ERROR.09");
		}

		ModelAndView output = null;
		//output = new ModelAndView("ezjobs/m/popup/ctmWhy");
		output = new ModelAndView("contents/popup/ctmWhy");
		output.addObject("ctmReturn",ctmReturn);
		
    	return output;
    	
	}
	

	public ModelAndView ez009(HttpServletRequest req, HttpServletResponse res ) 
										throws ServletException, IOException, Exception{
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		
		String status = CommonUtil.isNull(paramMap.get("status"));
		List waitDetail = null;
		if("Wait Condition".equals(status) ){
			waitDetail = popupWaitDetailService.dGetWaitConditionDetail(paramMap);
		}else if("Wait Time".equals(status) ){
			waitDetail = popupWaitDetailService.dGetWaitTimeDetail(paramMap);
		}
		
		ModelAndView output = null;
//		output = new ModelAndView("ezjobs/m/popup/waitDetail");
		output = new ModelAndView("contents/popup/waitDetail");
		output.addObject("waitDetail",waitDetail);
		
    	return output;
	}
	
	public ModelAndView ez010(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception{
		
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		
		String data_center 	= CommonUtil.isNull(paramMap.get("data_center"));
		String sched_table 	= CommonUtil.isNull(paramMap.get("v_sched_table"));
		String schedule_year 	= CommonUtil.isNull(paramMap.get("schedule_year"));
		String job_name 	= CommonUtil.isNull(paramMap.get("job_name"));
		String hostname 	= CommonUtil.getHostIp();
		
		// Host 정보 가져오는 서비스.	
		paramMap.put("data_center"	, data_center);
		paramMap.put("host"			, data_center);		
		paramMap.put("server_gubun"	, "S");
		
		CommonBean bean = commonService.dGetHostInfo(paramMap);
		
		String strHost 				= "";
		String strAccessGubun		= "";
		int iPort 					= 0;
		String strUserId 			= "";
		String strUserPw 			= "";
		
		if ( bean != null ) {
		
			strHost 			= CommonUtil.isNull(bean.getNode_id());
			strAccessGubun		= CommonUtil.isNull(bean.getAccess_gubun());
			iPort 				= Integer.parseInt(CommonUtil.isNull(bean.getAccess_port()));
			strUserId 			= CommonUtil.isNull(bean.getAgent_id());
			strUserPw 			= SeedUtil.decodeStr(CommonUtil.isNull(bean.getAgent_pw()));
		}
		
		//String cmd 	= "ctmrpln YJ Y  " + sched_table + " '*' " +CommonUtil.getCurDate("Y")+ "| sed '1,/Jobname:" + job_name + "$/d' | perl -ne 'print if 20..36' ";
		String cmd		= CommonUtil.getMessage("FORECAST.PATH") + "ctmrpln YJ Y " + sched_table + " " + job_name + " " + (schedule_year.equals("") ? CommonUtil.getCurDate("Y") : schedule_year) + " | sed -n '/^Year = " + (schedule_year.equals("") ? CommonUtil.getCurDate("Y") : schedule_year) + "/,/^DEC/p' ";

		// 스마트 테이블만을 명시.
		if ( sched_table.indexOf("/") > -1 ) {			
			sched_table = sched_table.substring(0, sched_table.indexOf("/"));
		}	
		
		String forecast = "";
		if(!"".equals(strHost)){
			//String cmd = "ctmrpln YJ Y  "+sched_table+" "+job_name+" "+CommonUtil.getCurDate("Y")+" | perl -ne 'print if 29..45' ";
			
			if ( hostname.toUpperCase().indexOf(data_center.toUpperCase()) > -1 ) {
				
				Process proc 					= null;
				InputStream inputStream 		= null;
				BufferedReader bufferedReader 	= null;
				String[] cmd2					= null;
				String osName 					= System.getProperty("os.name");
				
				if(osName.toLowerCase().startsWith("window")) {
					cmd2 = new String[] { "cmd.exe", "/y", "/c", cmd };
				} else {
					cmd2 = new String[] { "/bin/sh", "-c", cmd };
				}
	
				proc = Runtime.getRuntime().exec(cmd2);
				inputStream = proc.getInputStream();
				bufferedReader = new BufferedReader( new InputStreamReader( inputStream, "UTF-8"));
				
				String line 		= "";
				
				while (( line = bufferedReader.readLine()) != null ) {
					forecast += (line + "<br>");				
				}
				
				bufferedReader.close();
				inputStream.close();
				
			} else {
		
				if( "S".equals(strAccessGubun) ){
					Ssh2Util su = new Ssh2Util(strHost, iPort, strUserId, strUserPw, cmd, "UTF-8");
					forecast = su.getOutput();
				}else{
					TelnetUtil tu = new TelnetUtil(strHost, iPort, strUserId, strUserPw, cmd);
					forecast = tu.getOutput();
				}
			}

		}else{
			forecast = "-1";
		}
		List calYearList = null;
        calYearList = commonService.dGetCalendarYearList(paramMap);
		ModelAndView output = null;
		//output = new ModelAndView("ezjobs/m/popup/forecast");
		output = new ModelAndView("contents/popup/forecast");
		output.addObject("forecast",forecast);
		output.addObject("calYearList", calYearList);
		
    	return output;
	}
	
	
	
	
	public ModelAndView findJobBasicInfo(HttpServletRequest req, HttpServletResponse res ) throws Exception {
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		ModelAndView output = null;
		
		JobBasicInfo jobBasicInfo = popupJobDetailService.dGetJobBasicInfo(paramMap);
		if (jobBasicInfo != null && StringUtils.isNotEmpty(jobBasicInfo.getLate_exec())) {
			jobBasicInfo.setLate_exec(jobBasicInfo.getLate_exec().replaceAll("[^0-9]", ""));
		}
		output = new ModelAndView("contents/popup/editJobBasicInfo");
		output.addObject("jobBasicInfo", jobBasicInfo);
		output.addObject("test", "test");
		return output;
	}
	
	public ModelAndView editJobBasicInfo(HttpServletRequest req, HttpServletResponse res ) throws Exception {
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		paramMap.put("title", URLDecoder.decode((String) paramMap.get("title") ,"UTF-8"));
		paramMap.put("content", URLDecoder.decode((String) paramMap.get("content") ,"UTF-8"));
		
		if (paramMap.get("late_exec") != null && !paramMap.get("late_exec").equals("")) {
			paramMap.put("late_exec", ">" + paramMap.get("late_exec"));
		}
			
		// 매퍼 정보 가져오기.
		popupJobDetailService.modifyJobBasicInfo(paramMap);
		CommonBean bean = new CommonBean();
		
		bean.setAjax_value("true");
		ModelAndView output = new ModelAndView("common/inc/ajaxReturn2");
		output.addObject("commonBean",bean);
		
		return output;
	}

	public ModelAndView editJobBasicInfo_p(HttpServletRequest req, HttpServletResponse res ) throws ServletException, IOException, Exception {
			
			Map<String, Object> paramMap = CommonUtil.collectParameters(req);
			paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
			
			paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
			paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
			paramMap.put("flag", "one_update");
			paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		//	paramMap.put("title", CommonUtil.K2E(CommonUtil.isNull(paramMap.get("title"))));
		//	paramMap.put("content", CommonUtil.K2E(CommonUtil.isNull(paramMap.get("content"))));
		//	paramMap.put("description", CommonUtil.isNull(paramMap.get("description")));

		//	paramMap.put("data_center", "p520");
			Map<String, Object> rMap 	= new HashMap<String, Object>();
					
			try{
				
				rMap = worksUserService.dPrcJobMapper(paramMap);
				
			}catch(DefaultServiceException e){
				rMap = e.getResultMap();
				
				if("-1".equals(CommonUtil.isNull(rMap.get("r_code")))){
					logger.error(CommonUtil.isNull(rMap.get("r_msg")));
				}else{
					logger.error(e.getMessage());
				}
				
			}catch(Exception e){
				if("".equals(CommonUtil.isNull(rMap.get("r_code")))) rMap.put("r_code","-1");
				if("".equals(CommonUtil.isNull(rMap.get("r_msg")))) rMap.put("r_msg","ERROR.01");
				
				logger.error(e.getMessage());
			}
			
			ModelAndView output = null;
//			output = new ModelAndView("result/m_result");
//			output.addObject("rMap",rMap);
			
			output = new ModelAndView("common/inc/ajaxReturn2");
			
			CommonBean bean = new CommonBean();
			if (rMap.get("r_code").equals("1")) {
				bean.setAjax_value("true");
			} else {
				bean.setAjax_value("false");
			}
			output.addObject("commonBean",bean);
	    	return output;
	    	
		}

	public ModelAndView ez011(HttpServletRequest req, HttpServletResponse res ) throws ServletException, IOException, Exception {
		
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
		paramMap.put("s_user_gb", CommonUtil.isNull(req.getSession().getAttribute("USER_GB")));
		String p_sched_table =  CommonUtil.isNull(paramMap.get("p_sched_table")).replaceAll("&apos;","");
		paramMap.put("p_sched_table", p_sched_table);
		
		Map<String, Object> rMap = new HashMap<String, Object>();

		ModelAndView output = null;

		output = new ModelAndView("contents/popup/jobDefineInfo");

		try {

			JobDefineInfoBean jobDefineInfo = popupDefJobDetailService.dGetJobDefineInfo(paramMap);
			
			String s_user_gb  		= CommonUtil.isNull(req.getSession().getAttribute("USER_GB"));
			List sBatchGradeList 	= null;
			
			List dataCenterCodeList = null;
			List susiTypeList 		= null;
			List jobTypeGb 			= null;
			List jobSchedGb 		= null;
			List smsDefaultList		= null;
			List mailDefaultList	= null;
			List userFolderAuthList	= null;
	
			if (jobDefineInfo == null) {
				Map errMap = new HashMap();
				errMap.put("r_code",	"-1");
				errMap.put("r_msg",		"ERROR.75");
	
				throw new DefaultServiceException(errMap);
			}
	
			paramMap.put("mcode_cd", "M6");
			dataCenterCodeList = commonService.dGetsCodeList(paramMap);
	
			paramMap.put("mcode_cd", "M9");
			sBatchGradeList = commonService.dGetsCodeList(paramMap);
			paramMap.put("mcode_cd", "M33");
			susiTypeList = commonService.dGetsCodeList(paramMap);
			
			paramMap.put("mcode_cd", "M42");
			jobTypeGb = commonService.dGetsCodeList(paramMap);
			
			paramMap.put("mcode_cd", "M43");
			jobSchedGb = commonService.dGetsCodeList(paramMap);
			
			//SMS 기본값 설정
			paramMap.put("mcode_cd", "M87");
			smsDefaultList = commonService.dGetsCodeList(paramMap);
			
			//MAIL 기본값 설정
			paramMap.put("mcode_cd", "M88");
			mailDefaultList = commonService.dGetsCodeList(paramMap);
			
			//사용자의 폴더 권한 사용 여부
			paramMap.put("mcode_cd", "M95");
			userFolderAuthList = commonService.dGetsCodeList(paramMap);
	
			paramMap.put("job_name", jobDefineInfo.getJob_name());
			
			List jobApprovalInfo	= popupJobDetailService.dGetJobapprovalInfo(paramMap);
			
			paramMap.put("table_name", jobDefineInfo.getTable_name());
			
			List outCondList	= popupJobDetailService.dGetOutCondList(paramMap);
	
			List authList = null;
			if(!s_user_gb.equals("99")) {
				authList = worksUserService.dGetUserAuthList(paramMap);
			}
			
			String[] aTmpT = null;
			List<CommonBean> beans = new ArrayList<CommonBean>();
			
			if( CommonUtil.isNull(jobDefineInfo.getT_set()).length()>0 ){
				aTmpT = CommonUtil.E2K(jobDefineInfo.getT_set()).split("[|]");
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
			//output = new ModelAndView("ezjobs/m/popup/jobDefineInfo");
	
			output.addObject("jobDefineInfo"		, jobDefineInfo);
			output.addObject("jobApprovalInfo"		, jobApprovalInfo);
			output.addObject("authList"				, authList);
			output.addObject("sBatchGradeList"		, sBatchGradeList);
			output.addObject("jobTypeGb"			, jobTypeGb);
			output.addObject("jobSchedGb"			, jobSchedGb);
			output.addObject("outCondList"			, outCondList);
			output.addObject("mcodeList"			, CommonUtil.getMcodeList(paramMap));
			output.addObject("smsDefaultList"		, smsDefaultList);
			output.addObject("mailDefaultList"		, mailDefaultList);
			output.addObject("userFolderAuthList"	, userFolderAuthList);
		
			
			// 매퍼 정보 가져오기.
			output.addObject("jobMapperInfo", worksUserService.dGetJobMapperInfo(paramMap));
			
			// 태그 정보 가져오기.
	//		List tagsList = worksCompanyService.dGetDefTagsList(paramMap);
			
			// 후행작업 정보 가져오기.
			List defOutCondJobList = popupDefJobDetailService.dGetDefOutCondJobList(paramMap);
			
			// 추가 사항
			// 작업정보조회 시 Forecast 같이 조회 시작
			String data_center 	= CommonUtil.isNull(paramMap.get("data_center"));
			String sched_table 	= CommonUtil.isNull(jobDefineInfo.getTable_name());
			String job_name 	= CommonUtil.isNull(paramMap.get("job_name"));
			String hostname 	= CommonUtil.getHostIp();
			
			// Host 정보 가져오는 서비스.	
			paramMap.put("data_center"	, data_center);
			paramMap.put("host"			, data_center);
			paramMap.put("server_gubun"	, "S");
			
			CommonBean bean = commonService.dGetHostInfo(paramMap);
			
			String strHost 				= "";
			String strAccessGubun		= "";
			int iPort 					= 0;
			String strUserId 			= "";
			String strUserPw 			= "";  
			
			if ( bean != null ) {
			
				strHost 			= CommonUtil.isNull(bean.getNode_id());
				strAccessGubun		= CommonUtil.isNull(bean.getAccess_gubun());
				iPort 				= Integer.parseInt(CommonUtil.isNull(bean.getAccess_port()));
				strUserId 			= CommonUtil.isNull(bean.getAgent_id());
				strUserPw 			= SeedUtil.decodeStr(CommonUtil.isNull(bean.getAgent_pw()));
			}
			
			//String cmd 	= "ctmrpln YJ Y  " + sched_table + " '*' " +CommonUtil.getCurDate("Y")+ "| sed '1,/Jobname:" + job_name + "$/d' | perl -ne 'print if 20..36' ";
			String cmd		= "ctmrpln YJ Y " + sched_table + " " + job_name + " " + CommonUtil.getCurDate("Y") + " | sed -n '/^Year = " + CommonUtil.getCurDate("Y") + "/,/^DEC/p' ";
	
			// 스마트 테이블만을 명시.
			if ( sched_table.indexOf("/") > -1 ) {			
				sched_table = sched_table.substring(0, sched_table.indexOf("/"));
			}	
			
			String forecast = "";
			if(!"".equals(strHost)){
				
				if ( hostname.toUpperCase().indexOf(data_center.toUpperCase()) > -1 ) {
					
					Process proc 					= null;
					InputStream inputStream 		= null;
					BufferedReader bufferedReader 	= null;
					String[] cmd2					= null;
					String osName 					= System.getProperty("os.name");
					
					if(osName.toLowerCase().startsWith("window")) {
						cmd2 = new String[] { "cmd.exe", "/y", "/c", cmd };
					} else {
						cmd2 = new String[] { "/bin/sh", "-c", cmd };
					}
		
					proc = Runtime.getRuntime().exec(cmd2);
					inputStream = proc.getInputStream();
					bufferedReader = new BufferedReader( new InputStreamReader( inputStream, "UTF-8"));
					
					String line 		= "";
					
					while (( line = bufferedReader.readLine()) != null ) {
						forecast += (line + "<br>");				
					}
					
					bufferedReader.close();
					inputStream.close();
					
				} else {
			
					if( "S".equals(strAccessGubun) ){
						//SshUtil su = new SshUtil(strHost, iPort, strUserId, strUserPw, cmd, "UTF-8");
						//forecast = su.getOutput();
					}else{
						TelnetUtil tu = new TelnetUtil(strHost, iPort, strUserId, strUserPw, cmd);
						forecast = tu.getOutput();
					}
				}
	
			}else{
				forecast = "-1";
			}
	
			output.addObject("defOutCondJobList", 	defOutCondJobList);
			output.addObject("forecast",			forecast);
		
		} catch (DefaultServiceException e) {
			rMap = e.getResultMap();

			if ("-2".equals(CommonUtil.isNull(rMap.get("r_code")))) {
				logger.error(CommonUtil.isNull(rMap.get("r_msg")));
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

    	return output;
	}
	
	public ModelAndView ez012(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {
		
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));

		paramMap.put("type1", "O");
		paramMap.put("type2", "I");
		List jobGraphPreList = popupJobGraphService.dGetJobGraphList_ez012(paramMap);
		jobGraphPreList = toJobGraphList_ez012(paramMap, jobGraphPreList, new ArrayList());

		paramMap.put("table_id", req.getParameter("table_id"));
		paramMap.put("job_id", req.getParameter("job_id"));
		paramMap.put("type1", "I");
		paramMap.put("type2", "O");
		List jobGraphNextList = popupJobGraphService.dGetJobGraphList_ez012(paramMap);
		jobGraphNextList = toJobGraphList_ez012(paramMap, jobGraphNextList, new ArrayList());

		ModelAndView output = null;
		// output = new ModelAndView("ezjobs/m/popup/jobGraph");
		//output = new ModelAndView("ezjobs/m/popup/jobGraph_applet");
		output = new ModelAndView("contents/popup/jobGraph_applet");

		output.addObject("jobGraphPreList", jobGraphPreList);
		output.addObject("jobGraphNextList", jobGraphNextList);


		return output;
	}
	
	
	
	public ModelAndView ez012_d3(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {
		
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));

		ModelAndView output = null;
		//output = new ModelAndView("ezjobs/m/popup/jobGraph_d3");
		output = new ModelAndView("contents/popup/jobGraph_d3");

		return output;
	}

	public ModelAndView ez012_d3_xml(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		
		paramMap.put("type1", "O");
		paramMap.put("type2", "I");
		paramMap.put("order_id", paramMap.get("table_id") + "/" + paramMap.get("job_id"));
		List jobGraphPreList = popupJobGraphService.dGetJobGraphList_ez012(paramMap);
		jobGraphPreList = toJobGraphList_ez012(paramMap, jobGraphPreList, new ArrayList());

		//paramMap.put("table_id", req.getParameter("table_id"));
		//paramMap.put("job_id", req.getParameter("job_id"));
		
		paramMap.put("order_id", req.getParameter("table_id") + "/" + req.getParameter("job_id"));
		paramMap.put("type1", "I");
		paramMap.put("type2", "O");
		List jobGraphNextList = popupJobGraphService.dGetJobGraphList_ez012(paramMap);
		jobGraphNextList = toJobGraphList_ez012(paramMap, jobGraphNextList, new ArrayList());
		
		ModelAndView output = null;  
		//output = new ModelAndView("ezjobs/common/itemXml");
		output = new ModelAndView("common/itemXml");

		output.addObject("jobGraphPreList", 	jobGraphPreList);
		output.addObject("jobGraphNextList", 	jobGraphNextList);

		return output;
	}
	
	private List toJobGraphList_ez012(Map paramMap, List inList, List outList) {

		if (null != inList && inList.size() > 0)

			outList.addAll(inList);

		for (int i = 0; null != inList && i < inList.size(); i++) {
			JobGraphBean bean = (JobGraphBean) inList.get(i);

			int iChk = 0;

			for (int j = 0; null != outList && j < outList.size(); j++) {
				JobGraphBean bean2 = (JobGraphBean) outList.get(j);

				if (bean2.getOrder_id().equals(bean.getRef_order_id())
						|| "".equals(CommonUtil.isNull(bean.getRef_order_id()))) {

					iChk++;
				}
			}

			if (iChk > 0)
				continue;
			
			paramMap.put("order_id", bean.getRef_table_id() + "/" + bean.getRef_job_id());

			List l = popupJobGraphService.dGetJobGraphList_ez012(paramMap);

			if (null != l && l.size() > 0) {
				toJobGraphList_ez012(paramMap, l, outList);
			}
		}

		return outList;
	}
	
	// Alert Monitor에서 작업명 클릭 시 작업 등록 정보 팝업창 노출. 
	public ModelAndView ez013(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException, Exception {

		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		
		String p_sched_table =  CommonUtil.isNull(paramMap.get("p_sched_table")).replaceAll("&apos;","");
		paramMap.put("p_sched_table", p_sched_table);
		JobDefineInfoBean jobDefineInfo = popupDefJobDetailService.dGetJobDefineInfo_new(paramMap);

		ModelAndView output = null;
//		output = new ModelAndView("ezjobs/m/popup/jobDefineInfo");
		output = new ModelAndView("contents/popup/jobDefineInfo");
		output.addObject("jobDefineInfo", jobDefineInfo);
		

		return output;
	}
	
	public ModelAndView ez014(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));

		List jobAvgInfoList = popupJobDetailService.dGetJobAvgInfoList(paramMap);

		ModelAndView output = null;
		//output = new ModelAndView("ezjobs/m/popup/jobAvgInfoList");
		output = new ModelAndView("contents/popup/jobAvgInfoList");
		output.addObject("jobAvgInfoList", jobAvgInfoList);		

		return output;
	}
	
	public ModelAndView ez014_p(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {
		
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		
		
		paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
		paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		
		String strOrderIds 	= CommonUtil.isNull(paramMap.get("order_ids"));
		String arrOrderId[] = CommonUtil.isNull(strOrderIds).split(",");
		
		Map<String, Object> rMap = new HashMap<String, Object>();

		try {
			
			for ( int z = 0; z < arrOrderId.length; z++) {				
				paramMap.put("order_id", arrOrderId[z]);
				rMap = commonService.dPrcLog(paramMap);
			}
			
		} catch (Exception e) {
			rMap.put("r_code", "-1");
			rMap.put("r_msg", "ERROR.01");

			e.printStackTrace();
		}

		ModelAndView output = null;
		output = new ModelAndView("ezjobs/m/result");
		output.addObject("rMap", rMap);

		return output;
	}
	
	public ModelAndView ez015_d3(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {
		
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));

		ModelAndView output = null;
		output = new ModelAndView("ezjobs/m/popup/jobGraph_d3");
		
		output.addObject("gubun", "group");

		return output;
	}

	public ModelAndView ez015_d3_xml(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		paramMap.put("searchType", "dataCenterList");
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
    	
		List jobGroupInfoList = emJobLogService.dGetJobGroupInfoList(paramMap);
		
		

		paramMap.put("type1", "O");
		paramMap.put("type2", "I");
		List jobGraphPreList = popupJobGraphService.dGetJobGraphList(paramMap);
		jobGraphPreList = toJobGraphList_ez015(paramMap, jobGraphPreList, new ArrayList());

		paramMap.put("compare_num", "0");
		paramMap.put("order_id", req.getParameter("order_id"));
		paramMap.put("type1", "I");
		paramMap.put("type2", "O");
		List jobGraphNextList = popupJobGraphService.dGetJobGraphList(paramMap);
		jobGraphNextList = toJobGraphList_ez015(paramMap, jobGraphNextList, new ArrayList());
		
		ModelAndView output = null;
		output = new ModelAndView("ezjobs/common/itemXml");
		output.addObject("jobGraphPreList", jobGraphPreList);
		output.addObject("jobGraphNextList", jobGraphNextList);

		return output;
	}

	private List toJobGraphList_ez015(Map paramMap, List inList, List outList) {

		int iGraphDepth = Integer.parseInt(CommonUtil.isNull(paramMap.get("graph_depth"), "0"));
		int iCompareNum = Integer.parseInt(CommonUtil.isNull(paramMap.get("compare_num"), "0"));

		if (inList != null && inList.size() > 0) {
			outList.addAll(inList);
		}

		for (int i = 0; inList != null && i < inList.size(); i++) {

			JobGraphBean bean = (JobGraphBean) inList.get(i);

			if (iCompareNum == iGraphDepth && iGraphDepth > 0) {
				bean.setRef_order_id("");
			}

			int iChk = 0;

			for (int j = 0; outList != null && j < outList.size(); j++) {

				JobGraphBean bean2 = (JobGraphBean) outList.get(j);

				if (bean2.getOrder_id().equals(bean.getRef_order_id())
						|| CommonUtil.isNull(bean.getRef_order_id()).equals("")) {
					iChk++;
				}
			}

			if (iChk > 0)
				continue;

			paramMap.put("order_id", bean.getRef_order_id());

			List l = popupJobGraphService.dGetJobGraphList(paramMap);

			if (l != null && l.size() > 0) {
				iCompareNum++;
				paramMap.put("compare_num", iCompareNum);

				toJobGraphList_ez015(paramMap, l, outList);
			}
		}

		return outList;
	}
	
	//  통계,리포트 / 월총괄표 작업 클릭시 작업명 리스트 출력
	public ModelAndView ez016(HttpServletRequest req, HttpServletResponse res ) throws ServletException, IOException, Exception{
		
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);

		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		List jobNameList = commonService.dGetJobNameList(paramMap);
		ModelAndView output = null;
		output = new ModelAndView("contents/popup/m_status_hisList");
		output.addObject("jobNameList", jobNameList);

		return output;		

	}

	public ModelAndView findDocList(HttpServletRequest req, HttpServletResponse res ) throws Exception {
		
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		ModelAndView output = null;
		output = new ModelAndView("contents/popup/search_docList");
		
		return output;
	}

	public ModelAndView findDocList_p(HttpServletRequest req, HttpServletResponse res ) throws Exception {
		
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		
		paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
		paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
		String currentPage 	= CommonUtil.isNull(paramMap.get("currentPage"), "1");
		String rowCnt 		= CommonUtil.isNull(paramMap.get("rowCnt"), CommonUtil.isNull(req.getSession().getAttribute("DEFAULT_PAGING")));
		int rowSize 		= 0;

		if ( !rowCnt.equals("") ) {
			rowSize = Integer.parseInt(rowCnt);
		} else {
			rowSize = Integer.parseInt(CommonUtil.getMessage("PAGING.ROWSIZE.BASIC"));
		}	

		int pageSize = Integer.parseInt(CommonUtil.getMessage("PAGING.PAGESIZE.BASIC"));

		CommonBean bean = worksApprovalDocService.dGetMyDocInfoListCnt(paramMap);
		
		// 전체 페이지와 현재 갯수 체크해서 페이지 보정.
    	if ( !currentPage.equals("1") ) {
	    	if ( Math.ceil((double)bean.getTotal_count()/rowSize) < Integer.parseInt(currentPage) ) {
	    		currentPage = Integer.toString((int)Math.ceil((double)bean.getTotal_count()/rowSize));
	    	}
    	}
		
    	Paging paging = new Paging(bean.getTotal_count(),rowSize,pageSize,currentPage);

    	paramMap.put("startRowNum", paging.getStartRowNum());
    	paramMap.put("endRowNum", paging.getEndRowNum());
    	List myDocInfoList = worksApprovalDocService.dGetMyDocInfoList(paramMap);
    	
		ModelAndView output = null;
		output = new ModelAndView("contents/popup/docList");
//		output = new ModelAndView("contents/myDocInfoList");
		output.addObject("Paging",			paging);
		output.addObject("totalCount",		paging.getTotalRowSize());
		output.addObject("rowSize", 		rowSize);
		output.addObject("currentPage",		currentPage);
		output.addObject("myDocInfoList",	myDocInfoList);
		
    	return output;
    	
		
//		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
//		ModelAndView output = null;
//		output = new ModelAndView("contents/popup/docList");
//		
//		List<RelTableBean> srCodeList = relTableService.dGetRelList(paramMap);
//		output.addObject("srCodeList", srCodeList);
		
//		return output;
	}
	
	public ModelAndView jobDefineCompareInfo(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {
		
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		
		paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
		paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		
		Doc01Bean doc01Bean 		= null;
		Doc01Bean doc04Bean 		= null;
		Doc06Bean doc06Bean 		= null;
		List doc06DetailList 		= null;
		String strDocCd = "";
		String strDocGb = "";
		
		JobMapperBean jobMapperDocNowInfo = null;
		
		// DOC_GB, DOC_CD 가져오기
		
		JobMapperBean nowDocInfo = worksUserService.dGetNowDocInfo(paramMap);
		if(nowDocInfo != null){
			strDocCd = CommonUtil.isNull(nowDocInfo.getDoc_cd(),"");
			strDocGb = CommonUtil.isNull(nowDocInfo.getDoc_gb(),"");
			paramMap.put("doc_cd", strDocCd);
			paramMap.put("doc_gb", strDocGb);
			jobMapperDocNowInfo = worksUserService.dGetJobMapperDocNowInfo(paramMap);
		}
		
		if(jobMapperDocNowInfo != null){
			paramMap.put("JOB_NAME", CommonUtil.isNull(paramMap.get("job_name")));
		
			if(strDocGb.equals("01")){
				doc01Bean = worksApprovalDocService.dGetDoc01(paramMap);
				if(doc01Bean == null) {
					doc01Bean = worksApprovalDocService.dGetJobModifyInfo(paramMap);
				}
				jobMapperDocNowInfo.setSched_table(doc01Bean.getTable_name());
				jobMapperDocNowInfo.setApplication(doc01Bean.getApplication());
				jobMapperDocNowInfo.setGroup_name(doc01Bean.getGroup_name());
				jobMapperDocNowInfo.setTask_type(doc01Bean.getTask_type());
				jobMapperDocNowInfo.setNode_id(doc01Bean.getNode_id());
				jobMapperDocNowInfo.setOwner(doc01Bean.getOwner());
				jobMapperDocNowInfo.setMemname(doc01Bean.getMem_name());
				jobMapperDocNowInfo.setMem_lib(doc01Bean.getMem_lib());
				jobMapperDocNowInfo.setCreation_date(doc01Bean.getApply_date());
				jobMapperDocNowInfo.setFrom_time(doc01Bean.getTime_from());
				jobMapperDocNowInfo.setTo_time(doc01Bean.getTime_until());
				jobMapperDocNowInfo.setT_conditions_in(doc01Bean.getT_conditions_in());
				jobMapperDocNowInfo.setT_conditions_out(doc01Bean.getT_conditions_out());
				jobMapperDocNowInfo.setCyclic(doc01Bean.getCyclic());
				jobMapperDocNowInfo.setRerun_max(doc01Bean.getRerun_max());
				jobMapperDocNowInfo.setPriority(doc01Bean.getPriority());
                jobMapperDocNowInfo.setConfirm_flag(doc01Bean.getConfirm_flag());
                jobMapperDocNowInfo.setActive_from(doc01Bean.getActive_from());
                jobMapperDocNowInfo.setActive_till(doc01Bean.getActive_till());
                jobMapperDocNowInfo.setDays_cal(doc01Bean.getDays_cal());
                jobMapperDocNowInfo.setT_steps(doc01Bean.getT_steps());
                jobMapperDocNowInfo.setT_resources_q(doc01Bean.getT_resources_q());
                jobMapperDocNowInfo.setT_set(doc01Bean.getT_set());
                jobMapperDocNowInfo.setCalendar_nm(doc01Bean.getDays_cal());
                jobMapperDocNowInfo.setShift_num(doc01Bean.getShift_num());
			}else if(strDocGb.equals("04")){
				doc04Bean = worksApprovalDocService.dGetDoc04(paramMap);
				if(doc04Bean == null) {
					doc04Bean = worksApprovalDocService.dGetJobModifyInfo(paramMap);
				}
				jobMapperDocNowInfo.setSched_table(doc04Bean.getTable_name());
				jobMapperDocNowInfo.setApplication(doc04Bean.getApplication());
				jobMapperDocNowInfo.setGroup_name(doc04Bean.getGroup_name());
				jobMapperDocNowInfo.setTask_type(doc04Bean.getTask_type());
				jobMapperDocNowInfo.setNode_id(doc04Bean.getNode_id());
				jobMapperDocNowInfo.setOwner(doc04Bean.getOwner());
				jobMapperDocNowInfo.setMemname(doc04Bean.getMem_name());
				jobMapperDocNowInfo.setMem_lib(doc04Bean.getMem_lib());
				jobMapperDocNowInfo.setCreation_date(doc04Bean.getApply_date());
				jobMapperDocNowInfo.setFrom_time(doc04Bean.getTime_from());
				jobMapperDocNowInfo.setTo_time(doc04Bean.getTime_until());
				jobMapperDocNowInfo.setT_conditions_in(doc04Bean.getT_conditions_in());
				jobMapperDocNowInfo.setT_conditions_out(doc04Bean.getT_conditions_out());
				jobMapperDocNowInfo.setCyclic(doc04Bean.getCyclic());
				jobMapperDocNowInfo.setRerun_max(doc04Bean.getRerun_max());
				jobMapperDocNowInfo.setPriority(doc04Bean.getPriority());
				jobMapperDocNowInfo.setConfirm_flag(doc04Bean.getConfirm_flag());
				jobMapperDocNowInfo.setActive_from(doc04Bean.getActive_from());
                jobMapperDocNowInfo.setActive_till(doc04Bean.getActive_till());
                jobMapperDocNowInfo.setDays_cal(doc04Bean.getDays_cal());
                jobMapperDocNowInfo.setT_steps(doc04Bean.getT_steps());
                jobMapperDocNowInfo.setT_resources_q(doc04Bean.getT_resources_q());
                jobMapperDocNowInfo.setT_set(doc04Bean.getT_set());
                jobMapperDocNowInfo.setCalendar_nm(doc04Bean.getDays_cal());
                jobMapperDocNowInfo.setShift_num(doc04Bean.getShift_num());
			}else if(strDocGb.equals("06")){
				doc06Bean = worksApprovalDocService.dGetDoc06(paramMap);
				doc06DetailList = worksApprovalDocService.dGetDoc06DetailList(paramMap);
				for(int i=0; i<doc06DetailList.size(); i++){
					doc06Bean = (Doc06Bean) doc06DetailList.get(i);
					jobMapperDocNowInfo.setSched_table(doc06Bean.getTable_name());
					jobMapperDocNowInfo.setApplication(doc06Bean.getApplication());
					jobMapperDocNowInfo.setGroup_name(doc06Bean.getGroup_name());
					jobMapperDocNowInfo.setTask_type(doc06Bean.getTask_type());
					jobMapperDocNowInfo.setNode_id(doc06Bean.getNode_id());
					jobMapperDocNowInfo.setOwner(doc06Bean.getOwner());
					jobMapperDocNowInfo.setMemname(doc06Bean.getMem_name());
					jobMapperDocNowInfo.setMem_lib(doc06Bean.getMem_lib());
					jobMapperDocNowInfo.setT_set(doc06Bean.getT_set());
					jobMapperDocNowInfo.setFrom_time(doc06Bean.getTime_from());
					jobMapperDocNowInfo.setTo_time(doc06Bean.getTime_until());
					jobMapperDocNowInfo.setT_conditions_in(doc06Bean.getT_conditions_in());
					jobMapperDocNowInfo.setT_conditions_out(doc06Bean.getT_conditions_out());
					jobMapperDocNowInfo.setCyclic(doc06Bean.getCyclic());
					jobMapperDocNowInfo.setRerun_max(doc06Bean.getRerun_max());
					jobMapperDocNowInfo.setPriority(doc06Bean.getPriority());
					jobMapperDocNowInfo.setConfirm_flag(doc06Bean.getConfirm_flag());
					jobMapperDocNowInfo.setActive_from(doc06Bean.getActive_from());
	                jobMapperDocNowInfo.setActive_till(doc06Bean.getActive_till());
	                jobMapperDocNowInfo.setDays_cal(doc06Bean.getDays_cal());
	                jobMapperDocNowInfo.setT_steps(doc06Bean.getT_steps());
	                jobMapperDocNowInfo.setT_resources_q(doc06Bean.getT_resources_q());
	                jobMapperDocNowInfo.setCalendar_nm(doc06Bean.getDays_cal());
	                jobMapperDocNowInfo.setShift_num(doc06Bean.getShift_num());
				}
			}
		}
				
		// DOC_GB, DOC_CD 가져오기
		JobMapperBean prevDocInfo = worksUserService.dGetPrevDocInfo(paramMap);
		strDocCd = "";
		strDocGb = "";
		JobMapperBean jobMapperDocPrevInfo = null;
		if(prevDocInfo != null){
			strDocCd = CommonUtil.isNull(prevDocInfo.getDoc_cd(),"");
			strDocGb = CommonUtil.isNull(prevDocInfo.getDoc_gb(),"");
			paramMap.put("doc_cd", strDocCd);
			paramMap.put("doc_gb", strDocGb);
			jobMapperDocPrevInfo = worksUserService.dGetJobMapperDocPrevInfo(paramMap);
		}
		
		
		if(jobMapperDocPrevInfo != null){
			paramMap.put("JOB_NAME", CommonUtil.isNull(paramMap.get("job_name")));
		
			if(strDocGb.equals("01")){
				doc01Bean = worksApprovalDocService.dGetDoc01(paramMap);
				jobMapperDocPrevInfo.setSched_table(doc01Bean.getTable_name());
				jobMapperDocPrevInfo.setApplication(doc01Bean.getApplication());
				jobMapperDocPrevInfo.setGroup_name(doc01Bean.getGroup_name());
				jobMapperDocPrevInfo.setTask_type(doc01Bean.getTask_type());
				jobMapperDocPrevInfo.setNode_id(doc01Bean.getNode_id());
				jobMapperDocPrevInfo.setOwner(doc01Bean.getOwner());
				jobMapperDocPrevInfo.setMemname(doc01Bean.getMem_name());
				jobMapperDocPrevInfo.setMem_lib(doc01Bean.getMem_lib());
				jobMapperDocPrevInfo.setT_set(doc01Bean.getT_set());
				jobMapperDocPrevInfo.setCreation_date(doc01Bean.getApply_date());
				jobMapperDocPrevInfo.setFrom_time(doc01Bean.getTime_from());
				jobMapperDocPrevInfo.setTo_time(doc01Bean.getTime_until());
				jobMapperDocPrevInfo.setT_conditions_in(doc01Bean.getT_conditions_in());
				jobMapperDocPrevInfo.setT_conditions_out(doc01Bean.getT_conditions_out());
				jobMapperDocPrevInfo.setCyclic(doc01Bean.getCyclic());
				jobMapperDocPrevInfo.setRerun_max(doc01Bean.getRerun_max());
				jobMapperDocPrevInfo.setPriority(doc01Bean.getPriority());
                jobMapperDocPrevInfo.setConfirm_flag(doc01Bean.getConfirm_flag());
                jobMapperDocPrevInfo.setActive_from(doc01Bean.getActive_from());
                jobMapperDocPrevInfo.setActive_till(doc01Bean.getActive_till());
                jobMapperDocPrevInfo.setCmd_line(doc01Bean.getCommand());
                jobMapperDocPrevInfo.setDays_cal(doc01Bean.getDays_cal());
                jobMapperDocPrevInfo.setT_resources_q(doc01Bean.getT_resources_q());
                jobMapperDocPrevInfo.setCalendar_nm(doc01Bean.getDays_cal());
                jobMapperDocPrevInfo.setCritical(doc01Bean.getCritical());
                jobMapperDocPrevInfo.setWeeks_cal(doc01Bean.getWeeks_cal());
                jobMapperDocPrevInfo.setConf_cal(doc01Bean.getConf_cal());
                jobMapperDocPrevInfo.setShift(doc01Bean.getShift());
                jobMapperDocPrevInfo.setShift_num(doc01Bean.getShift_num());
                jobMapperDocPrevInfo.setT_general_date(doc01Bean.getT_general_date());
                jobMapperDocPrevInfo.setMonth_1(doc01Bean.getMonth_1());
                jobMapperDocPrevInfo.setMonth_2(doc01Bean.getMonth_2());
                jobMapperDocPrevInfo.setMonth_3(doc01Bean.getMonth_3());
                jobMapperDocPrevInfo.setMonth_4(doc01Bean.getMonth_4());
                jobMapperDocPrevInfo.setMonth_5(doc01Bean.getMonth_5());
                jobMapperDocPrevInfo.setMonth_6(doc01Bean.getMonth_6());
                jobMapperDocPrevInfo.setMonth_7(doc01Bean.getMonth_7());
                jobMapperDocPrevInfo.setMonth_8(doc01Bean.getMonth_8());
                jobMapperDocPrevInfo.setMonth_9(doc01Bean.getMonth_9());
                jobMapperDocPrevInfo.setMonth_10(doc01Bean.getMonth_10());
                jobMapperDocPrevInfo.setMonth_11(doc01Bean.getMonth_11());
                jobMapperDocPrevInfo.setMonth_12(doc01Bean.getMonth_12());
			}else if(strDocGb.equals("04")){
				doc04Bean = worksApprovalDocService.dGetDoc04(paramMap);
				jobMapperDocPrevInfo.setSched_table(doc04Bean.getTable_name());
				jobMapperDocPrevInfo.setApplication(doc04Bean.getApplication());
				jobMapperDocPrevInfo.setGroup_name(doc04Bean.getGroup_name());
				jobMapperDocPrevInfo.setTask_type(doc04Bean.getTask_type());
				jobMapperDocPrevInfo.setNode_id(doc04Bean.getNode_id());
				jobMapperDocPrevInfo.setOwner(doc04Bean.getOwner());
				jobMapperDocPrevInfo.setMemname(doc04Bean.getMem_name());
				jobMapperDocPrevInfo.setMem_lib(doc04Bean.getMem_lib());
				jobMapperDocPrevInfo.setT_set(doc04Bean.getT_set());
				jobMapperDocPrevInfo.setCreation_date(doc04Bean.getApply_date());
				jobMapperDocPrevInfo.setFrom_time(doc04Bean.getTime_from());
				jobMapperDocPrevInfo.setTo_time(doc04Bean.getTime_until());
				jobMapperDocPrevInfo.setT_conditions_in(doc04Bean.getT_conditions_in());
				jobMapperDocPrevInfo.setT_conditions_out(doc04Bean.getT_conditions_out());
				jobMapperDocPrevInfo.setCyclic(doc04Bean.getCyclic());
				jobMapperDocPrevInfo.setRerun_max(doc04Bean.getRerun_max());
				jobMapperDocPrevInfo.setPriority(doc04Bean.getPriority());
				jobMapperDocPrevInfo.setConfirm_flag(doc04Bean.getConfirm_flag());
				jobMapperDocPrevInfo.setActive_from(doc04Bean.getActive_from());
                jobMapperDocPrevInfo.setActive_till(doc04Bean.getActive_till());
                jobMapperDocPrevInfo.setCmd_line(doc04Bean.getCommand());
                jobMapperDocPrevInfo.setDays_cal(doc04Bean.getDays_cal());
                jobMapperDocPrevInfo.setT_resources_q(doc04Bean.getT_resources_q());
                jobMapperDocPrevInfo.setCalendar_nm(doc04Bean.getDays_cal());
                jobMapperDocPrevInfo.setCritical(doc04Bean.getCritical());
                jobMapperDocPrevInfo.setWeeks_cal(doc04Bean.getWeeks_cal());
                jobMapperDocPrevInfo.setConf_cal(doc04Bean.getConf_cal());
                jobMapperDocPrevInfo.setShift(doc04Bean.getShift());
                jobMapperDocPrevInfo.setShift_num(doc04Bean.getShift_num());
                jobMapperDocPrevInfo.setT_general_date(doc04Bean.getT_general_date());
                jobMapperDocPrevInfo.setMonth_1(doc04Bean.getMonth_1());
                jobMapperDocPrevInfo.setMonth_2(doc04Bean.getMonth_2());
                jobMapperDocPrevInfo.setMonth_3(doc04Bean.getMonth_3());
                jobMapperDocPrevInfo.setMonth_4(doc04Bean.getMonth_4());
                jobMapperDocPrevInfo.setMonth_5(doc04Bean.getMonth_5());
                jobMapperDocPrevInfo.setMonth_6(doc04Bean.getMonth_6());
                jobMapperDocPrevInfo.setMonth_7(doc04Bean.getMonth_7());
                jobMapperDocPrevInfo.setMonth_8(doc04Bean.getMonth_8());
                jobMapperDocPrevInfo.setMonth_9(doc04Bean.getMonth_9());
                jobMapperDocPrevInfo.setMonth_10(doc04Bean.getMonth_10());
                jobMapperDocPrevInfo.setMonth_11(doc04Bean.getMonth_11());
                jobMapperDocPrevInfo.setMonth_12(doc04Bean.getMonth_12());
			}else if(strDocGb.equals("06")){
				doc06Bean = worksApprovalDocService.dGetDoc06(paramMap);
				doc06DetailList = worksApprovalDocService.dGetDoc06DetailList(paramMap);
				for(int i=0; i<doc06DetailList.size(); i++){
					doc06Bean = (Doc06Bean) doc06DetailList.get(i);
					jobMapperDocPrevInfo.setSched_table(doc06Bean.getTable_name());
					jobMapperDocPrevInfo.setApplication(doc06Bean.getApplication());
					jobMapperDocPrevInfo.setGroup_name(doc06Bean.getGroup_name());
					jobMapperDocPrevInfo.setTask_type(doc06Bean.getTask_type());
					jobMapperDocPrevInfo.setNode_id(doc06Bean.getNode_id());
					jobMapperDocPrevInfo.setOwner(doc06Bean.getOwner());
					jobMapperDocPrevInfo.setMem_lib(doc06Bean.getMem_lib());
					jobMapperDocPrevInfo.setMemname(doc06Bean.getMem_name());
					jobMapperDocPrevInfo.setT_set(doc06Bean.getT_set());
					jobMapperDocPrevInfo.setCreation_date(doc06Bean.getApply_date());
					jobMapperDocPrevInfo.setFrom_time(doc06Bean.getTime_from());
					jobMapperDocPrevInfo.setTo_time(doc06Bean.getTime_until());
					jobMapperDocPrevInfo.setT_conditions_in(doc06Bean.getT_conditions_in());
					jobMapperDocPrevInfo.setT_conditions_out(doc06Bean.getT_conditions_out());
					jobMapperDocPrevInfo.setCyclic(doc06Bean.getCyclic());
					jobMapperDocPrevInfo.setRerun_max(doc06Bean.getRerun_max());
					jobMapperDocPrevInfo.setPriority(doc06Bean.getPriority());
					jobMapperDocPrevInfo.setConfirm_flag(doc06Bean.getConfirm_flag());
					jobMapperDocPrevInfo.setActive_from(doc06Bean.getActive_from());
	                jobMapperDocPrevInfo.setActive_till(doc06Bean.getActive_till());
	                jobMapperDocPrevInfo.setCmd_line(doc06Bean.getCommand());
	                jobMapperDocPrevInfo.setDays_cal(doc06Bean.getDays_cal());
	                jobMapperDocPrevInfo.setT_resources_q(doc06Bean.getT_resources_q());
	                jobMapperDocPrevInfo.setCalendar_nm(doc06Bean.getDays_cal());
	                jobMapperDocPrevInfo.setCritical(doc06Bean.getCritical());
	                jobMapperDocPrevInfo.setWeeks_cal(doc06Bean.getWeeks_cal());
	                jobMapperDocPrevInfo.setConf_cal(doc06Bean.getConf_cal());
	                jobMapperDocPrevInfo.setShift(doc06Bean.getShift());
	                jobMapperDocPrevInfo.setShift_num(doc06Bean.getShift_num());
	                jobMapperDocPrevInfo.setT_general_date(doc06Bean.getT_general_date());
	                jobMapperDocPrevInfo.setMonth_1(doc06Bean.getMonth_1());
	                jobMapperDocPrevInfo.setMonth_2(doc06Bean.getMonth_2());
	                jobMapperDocPrevInfo.setMonth_3(doc06Bean.getMonth_3());
	                jobMapperDocPrevInfo.setMonth_4(doc06Bean.getMonth_4());
	                jobMapperDocPrevInfo.setMonth_5(doc06Bean.getMonth_5());
	                jobMapperDocPrevInfo.setMonth_6(doc06Bean.getMonth_6());
	                jobMapperDocPrevInfo.setMonth_7(doc06Bean.getMonth_7());
	                jobMapperDocPrevInfo.setMonth_8(doc06Bean.getMonth_8());
	                jobMapperDocPrevInfo.setMonth_9(doc06Bean.getMonth_9());
	                jobMapperDocPrevInfo.setMonth_10(doc06Bean.getMonth_10());
	                jobMapperDocPrevInfo.setMonth_11(doc06Bean.getMonth_11());
	                jobMapperDocPrevInfo.setMonth_12(doc06Bean.getMonth_12());
				}
			}
		}
		
		ModelAndView output = null;
		output = new ModelAndView("contents/popup/jobDefineCompareInfo");	
		
		output.addObject("jobMapperDocNowInfo", jobMapperDocNowInfo);
		output.addObject("jobMapperDocPrevInfo", jobMapperDocPrevInfo);
		output.addObject("doc01Bean", doc01Bean);
		output.addObject("doc04Bean", doc04Bean);
		output.addObject("doc06Bean", doc06Bean);
		output.addObject("doc06DetailList", doc06DetailList);
		output.addObject("docCompareInfo", "N");
		return output;
	}
	
	public ModelAndView jobDocCompareInfo(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {
		
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		
		paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
		paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		paramMap.put("job_name", paramMap.get("job"));
		paramMap.put("data_center", paramMap.get("p_data_center"));
		
		// 요청서 정보 가져오기.
		Doc01Bean doc04 = worksApprovalDocService.dGetDoc04(paramMap);		
		JobMapperBean jobMapperDocInfo = worksUserService.dGetJobMapperDocInfo(paramMap);

		if(jobMapperDocInfo != null){
			doc04.setData_center_name(CommonUtil.isNull(jobMapperDocInfo.getData_center_name()));
			
			doc04.setUser_nm_1(CommonUtil.isNull(jobMapperDocInfo.getUser_nm_1()));
			doc04.setDept_nm_1(CommonUtil.isNull(jobMapperDocInfo.getDept_nm_1()));
			doc04.setDuty_nm_1(CommonUtil.isNull(jobMapperDocInfo.getDuty_nm_1()));
			doc04.setUser_tel_1(CommonUtil.isNull(jobMapperDocInfo.getUser_tel_1()));
			doc04.setUser_hp_1(CommonUtil.isNull(jobMapperDocInfo.getUser_hp_1()));
			doc04.setUser_email_1(CommonUtil.isNull(jobMapperDocInfo.getUser_email_1()));
	
			doc04.setUser_nm_2(CommonUtil.isNull(jobMapperDocInfo.getUser_nm_2()));
			doc04.setDept_nm_2(CommonUtil.isNull(jobMapperDocInfo.getDept_nm_2()));
			doc04.setDuty_nm_2(CommonUtil.isNull(jobMapperDocInfo.getDuty_nm_2()));
			doc04.setUser_tel_2(CommonUtil.isNull(jobMapperDocInfo.getUser_tel_2()));
			doc04.setUser_hp_2(CommonUtil.isNull(jobMapperDocInfo.getUser_hp_2()));
			doc04.setUser_email_2(CommonUtil.isNull(jobMapperDocInfo.getUser_email_2()));
	        
			doc04.setUser_nm_3(CommonUtil.isNull(jobMapperDocInfo.getUser_nm_3()));
			doc04.setDept_nm_3(CommonUtil.isNull(jobMapperDocInfo.getDept_nm_3()));
			doc04.setDuty_nm_3(CommonUtil.isNull(jobMapperDocInfo.getDuty_nm_3()));
			doc04.setUser_tel_3(CommonUtil.isNull(jobMapperDocInfo.getUser_tel_3()));
			doc04.setUser_hp_3(CommonUtil.isNull(jobMapperDocInfo.getUser_hp_3()));
			doc04.setUser_email_3(CommonUtil.isNull(jobMapperDocInfo.getUser_email_3()));
			
			doc04.setUser_nm_4(CommonUtil.isNull(jobMapperDocInfo.getUser_nm_4()));
			doc04.setDept_nm_4(CommonUtil.isNull(jobMapperDocInfo.getDept_nm_4()));
			doc04.setDuty_nm_4(CommonUtil.isNull(jobMapperDocInfo.getDuty_nm_4()));
			doc04.setUser_tel_4(CommonUtil.isNull(jobMapperDocInfo.getUser_tel_4()));
			doc04.setUser_hp_4(CommonUtil.isNull(jobMapperDocInfo.getUser_hp_4()));
			doc04.setUser_email_4(CommonUtil.isNull(jobMapperDocInfo.getUser_email_4()));
			
			doc04.setUser_nm_5(CommonUtil.isNull(jobMapperDocInfo.getUser_nm_5()));
			doc04.setUser_nm_6(CommonUtil.isNull(jobMapperDocInfo.getUser_nm_6()));
			doc04.setUser_nm_7(CommonUtil.isNull(jobMapperDocInfo.getUser_nm_7()));
			doc04.setUser_nm_8(CommonUtil.isNull(jobMapperDocInfo.getUser_nm_8()));
			doc04.setUser_nm_9(CommonUtil.isNull(jobMapperDocInfo.getUser_nm_9()));
			doc04.setUser_nm_10(CommonUtil.isNull(jobMapperDocInfo.getUser_nm_10()));
			doc04.setGrp_nm_1(CommonUtil.isNull(jobMapperDocInfo.getGrp_nm_1()));
			doc04.setGrp_nm_2(CommonUtil.isNull(jobMapperDocInfo.getGrp_nm_2()));

			doc04.setBatchJobGrade(CommonUtil.isNull(jobMapperDocInfo.getBatchJobGrade()));
			doc04.setDraft_date(CommonUtil.isNull(jobMapperDocInfo.getDraft_date()));
			doc04.setApply_date(CommonUtil.isNull(jobMapperDocInfo.getApply_date()));
			doc04.setFrom_time(CommonUtil.isNull(doc04.getTime_from()));
			doc04.setTo_time(CommonUtil.isNull(doc04.getTime_until()));
			
			doc04.setRef_table(CommonUtil.isNull(jobMapperDocInfo.getRef_table()));
			doc04.setSuccess_sms_yn(CommonUtil.isNull(jobMapperDocInfo.getSuccess_sms_yn()));

		}
		// 작업 정보 가져오기.
		//JobDefineInfoBean jobDefineInfo = popupDefJobDetailService.dGetJobDefineInfo(paramMap);
		Doc01Bean doc04_original = worksApprovalDocService.dGetDoc04_original(paramMap);
		JobMapperBean jobMapperOriInfo = worksUserService.dGetJobMapperOriInfo(paramMap);
		
		if(jobMapperOriInfo != null && doc04_original != null){
			doc04_original.setData_center_name(CommonUtil.isNull(jobMapperOriInfo.getData_center_name()));
			
			doc04_original.setUser_nm_1(CommonUtil.isNull(jobMapperOriInfo.getUser_nm_1()));
			doc04_original.setDept_nm_1(CommonUtil.isNull(jobMapperOriInfo.getDept_nm_1()));
			doc04_original.setDuty_nm_1(CommonUtil.isNull(jobMapperOriInfo.getDuty_nm_1()));
			doc04_original.setUser_tel_1(CommonUtil.isNull(jobMapperOriInfo.getUser_tel_1()));
			doc04_original.setUser_hp_1(CommonUtil.isNull(jobMapperOriInfo.getUser_hp_1()));
			doc04_original.setUser_email_1(CommonUtil.isNull(jobMapperOriInfo.getUser_email_1()));
	        
			doc04_original.setUser_nm_2(CommonUtil.isNull(jobMapperOriInfo.getUser_nm_2()));
			doc04_original.setDept_nm_2(CommonUtil.isNull(jobMapperOriInfo.getDept_nm_2()));
			doc04_original.setDuty_nm_2(CommonUtil.isNull(jobMapperOriInfo.getDuty_nm_2()));
			doc04_original.setUser_tel_2(CommonUtil.isNull(jobMapperOriInfo.getUser_tel_2()));
			doc04_original.setUser_hp_2(CommonUtil.isNull(jobMapperOriInfo.getUser_hp_2()));
			doc04_original.setUser_email_2(CommonUtil.isNull(jobMapperOriInfo.getUser_email_2()));
	        
			doc04_original.setUser_nm_3(CommonUtil.isNull(jobMapperOriInfo.getUser_nm_3()));
			doc04_original.setDept_nm_3(CommonUtil.isNull(jobMapperOriInfo.getDept_nm_3()));
			doc04_original.setDuty_nm_3(CommonUtil.isNull(jobMapperOriInfo.getDuty_nm_3()));
			doc04_original.setUser_tel_3(CommonUtil.isNull(jobMapperOriInfo.getUser_tel_3()));
			doc04_original.setUser_hp_3(CommonUtil.isNull(jobMapperOriInfo.getUser_hp_3()));
			doc04_original.setUser_email_3(CommonUtil.isNull(jobMapperOriInfo.getUser_email_3()));
	        
			doc04_original.setUser_nm_4(CommonUtil.isNull(jobMapperOriInfo.getUser_nm_4()));
			doc04_original.setDept_nm_4(CommonUtil.isNull(jobMapperOriInfo.getDept_nm_4()));
			doc04_original.setDuty_nm_4(CommonUtil.isNull(jobMapperOriInfo.getDuty_nm_4()));
			doc04_original.setUser_tel_4(CommonUtil.isNull(jobMapperOriInfo.getUser_tel_4()));
			doc04_original.setUser_hp_4(CommonUtil.isNull(jobMapperOriInfo.getUser_hp_4()));
			doc04_original.setUser_email_4(CommonUtil.isNull(jobMapperOriInfo.getUser_email_4()));
			
			doc04_original.setUser_nm_5(CommonUtil.isNull(jobMapperOriInfo.getUser_nm_5()));
			doc04_original.setUser_nm_6(CommonUtil.isNull(jobMapperOriInfo.getUser_nm_6()));
			doc04_original.setUser_nm_7(CommonUtil.isNull(jobMapperOriInfo.getUser_nm_7()));
			doc04_original.setUser_nm_8(CommonUtil.isNull(jobMapperOriInfo.getUser_nm_8()));
			doc04_original.setUser_nm_9(CommonUtil.isNull(jobMapperOriInfo.getUser_nm_9()));
			doc04_original.setUser_nm_10(CommonUtil.isNull(jobMapperOriInfo.getUser_nm_10()));
			doc04_original.setGrp_nm_1(CommonUtil.isNull(jobMapperOriInfo.getGrp_nm_1()));
			doc04_original.setGrp_nm_2(CommonUtil.isNull(jobMapperOriInfo.getGrp_nm_2()));

			doc04_original.setBatchJobGrade(CommonUtil.isNull(jobMapperOriInfo.getBatchJobGrade()));
			doc04_original.setDraft_date(CommonUtil.isNull(jobMapperOriInfo.getDraft_date()));
			doc04_original.setApply_date(CommonUtil.isNull(jobMapperOriInfo.getApply_date()));
			
			doc04_original.setFrom_time(doc04_original.getTime_from());
			doc04_original.setTo_time(doc04_original.getTime_until());
			
			doc04_original.setLate_exec(CommonUtil.isNull(jobMapperOriInfo.getLate_exec()));
			doc04_original.setLate_sub(CommonUtil.isNull(jobMapperOriInfo.getLate_sub()));
			doc04_original.setLate_time(CommonUtil.isNull(jobMapperOriInfo.getLate_time()));
			
			doc04_original.setRef_table(CommonUtil.isNull(jobMapperOriInfo.getRef_table()));
			doc04_original.setSuccess_sms_yn(CommonUtil.isNull(jobMapperOriInfo.getSuccess_sms_yn()));
		}
		ModelAndView output = null;
		output = new ModelAndView("contents/popup/jobDocCompareInfo");	
		
		output.addObject("jobMapperDocNowInfo", doc04);
		output.addObject("jobMapperDocPrevInfo", doc04_original);
		return output;
	}
	
	public ModelAndView popupUsedJobList(HttpServletRequest req, HttpServletResponse res ) 
			throws ServletException, IOException, Exception{
		Map<String, Object> paramMap = CommonUtil.collectParametersK2E(req);
	
		List usedJobList = commonService.dGetUsedJobList(paramMap);
	
		ModelAndView output = null;
		output = new ModelAndView("contents/popup/usedJobList");
		output.addObject("usedJobList",usedJobList);
	
		return output;
	}
	
	public ModelAndView docCompareInfo(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {
		
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		
		paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
		paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		
		Doc01Bean doc01Bean 	= null;
		Doc01Bean doc04Bean 	= null;
		Doc06Bean doc06Bean 	= null;
		Doc01Bean doc09Bean 	= null;
		List doc06DetailList 	= null;
		String strDocCd 		= CommonUtil.isNull(paramMap.get("doc_cd"));
		String strDocGb 		= CommonUtil.isNull(paramMap.get("doc_gb"));
		
		JobMapperBean jobMapperDocNowInfo = null;
		paramMap.put("JOB_NAME", CommonUtil.isNull(paramMap.get("job_name")));
		
		logger.debug("strDocGb : " + strDocGb);
		logger.debug("JOB_NAME : " + CommonUtil.isNull(paramMap.get("job_name")));
		
		if(strDocGb.equals("09")) {
			doc09Bean = worksApprovalDocService.dGetDoc09(paramMap);
			paramMap.put("doc_gb", doc09Bean.getDoc_gb());
			strDocGb = doc09Bean.getDoc_gb();
			
			logger.debug("바뀐 strDocGb : " + doc09Bean.getDoc_gb());
		}
		
		jobMapperDocNowInfo = worksUserService.dGetJobMapperDocPrevInfo(paramMap);
		
		if(jobMapperDocNowInfo != null){
			logger.debug("문서번호 추가 :::" + strDocCd);
			jobMapperDocNowInfo.setDoc_cd(strDocCd);
			
			if(strDocGb.equals("01")){
				doc01Bean = worksApprovalDocService.dGetDoc01(paramMap);
				if(doc01Bean == null) {
					doc01Bean = worksApprovalDocService.dGetJobModifyInfo(paramMap);
				}
				jobMapperDocNowInfo.setSched_table(doc01Bean.getTable_name());
				jobMapperDocNowInfo.setApplication(doc01Bean.getApplication());
				jobMapperDocNowInfo.setGroup_name(doc01Bean.getGroup_name());
				jobMapperDocNowInfo.setTask_type(doc01Bean.getTask_type());
				jobMapperDocNowInfo.setNode_id(doc01Bean.getNode_id());
				jobMapperDocNowInfo.setOwner(doc01Bean.getOwner());
				jobMapperDocNowInfo.setMemname(doc01Bean.getMem_name());
				jobMapperDocNowInfo.setMem_lib(doc01Bean.getMem_lib());
				jobMapperDocNowInfo.setCreation_date(doc01Bean.getApply_date());
				jobMapperDocNowInfo.setFrom_time(doc01Bean.getTime_from());
				jobMapperDocNowInfo.setTo_time(doc01Bean.getTime_until());
				jobMapperDocNowInfo.setT_conditions_in(doc01Bean.getT_conditions_in());
				jobMapperDocNowInfo.setT_conditions_out(doc01Bean.getT_conditions_out());
				jobMapperDocNowInfo.setCyclic(doc01Bean.getCyclic());
				jobMapperDocNowInfo.setRerun_max(doc01Bean.getRerun_max());
				jobMapperDocNowInfo.setPriority(doc01Bean.getPriority());
	            jobMapperDocNowInfo.setConfirm_flag(doc01Bean.getConfirm_flag());
	            jobMapperDocNowInfo.setActive_from(doc01Bean.getActive_from());
	            jobMapperDocNowInfo.setActive_till(doc01Bean.getActive_till());
	            jobMapperDocNowInfo.setCmd_line(doc01Bean.getCommand());
	            jobMapperDocNowInfo.setDays_cal(doc01Bean.getDays_cal());
	            jobMapperDocNowInfo.setT_steps(doc01Bean.getT_steps());
	            jobMapperDocNowInfo.setT_resources_q(doc01Bean.getT_resources_q());
	            jobMapperDocNowInfo.setT_set(doc01Bean.getT_set());
	            jobMapperDocNowInfo.setCalendar_nm(doc01Bean.getDays_cal());
	            jobMapperDocNowInfo.setDescription(doc01Bean.getDescription());
	            jobMapperDocNowInfo.setCritical(doc01Bean.getCritical());
			}else if(strDocGb.equals("04")){
				doc04Bean = worksApprovalDocService.dGetDoc04(paramMap);
				if(doc04Bean == null) {
					doc04Bean = worksApprovalDocService.dGetJobModifyInfo(paramMap);
				}
				jobMapperDocNowInfo.setSched_table(doc04Bean.getTable_name());
				jobMapperDocNowInfo.setApplication(doc04Bean.getApplication());
				jobMapperDocNowInfo.setGroup_name(doc04Bean.getGroup_name());
				jobMapperDocNowInfo.setTask_type(doc04Bean.getTask_type());
				jobMapperDocNowInfo.setNode_id(doc04Bean.getNode_id());
				jobMapperDocNowInfo.setOwner(doc04Bean.getOwner());
				jobMapperDocNowInfo.setMemname(doc04Bean.getMem_name());
				jobMapperDocNowInfo.setMem_lib(doc04Bean.getMem_lib());
				jobMapperDocNowInfo.setCreation_date(doc04Bean.getApply_date());
				jobMapperDocNowInfo.setFrom_time(doc04Bean.getTime_from());
				jobMapperDocNowInfo.setTo_time(doc04Bean.getTime_until());
				jobMapperDocNowInfo.setT_conditions_in(doc04Bean.getT_conditions_in());
				jobMapperDocNowInfo.setT_conditions_out(doc04Bean.getT_conditions_out());
				jobMapperDocNowInfo.setCyclic(doc04Bean.getCyclic());
				jobMapperDocNowInfo.setRerun_max(doc04Bean.getRerun_max());
				jobMapperDocNowInfo.setPriority(doc04Bean.getPriority());
				jobMapperDocNowInfo.setConfirm_flag(doc04Bean.getConfirm_flag());
				jobMapperDocNowInfo.setActive_from(doc04Bean.getActive_from());
	            jobMapperDocNowInfo.setActive_till(doc04Bean.getActive_till());
	            jobMapperDocNowInfo.setCmd_line(doc04Bean.getCommand());
	            jobMapperDocNowInfo.setDays_cal(doc04Bean.getDays_cal());
	            jobMapperDocNowInfo.setT_steps(doc04Bean.getT_steps());
	            jobMapperDocNowInfo.setT_resources_q(doc04Bean.getT_resources_q());
	            jobMapperDocNowInfo.setT_set(doc04Bean.getT_set());
	            jobMapperDocNowInfo.setCalendar_nm(doc04Bean.getDays_cal());
	            jobMapperDocNowInfo.setDescription(doc04Bean.getDescription());
	            jobMapperDocNowInfo.setCritical(doc04Bean.getCritical());
			}else if(strDocGb.equals("06")){
				doc06Bean = worksApprovalDocService.dGetDoc06(paramMap);
				doc06DetailList = worksApprovalDocService.dGetDoc06DetailList(paramMap);
				for(int i=0; i<doc06DetailList.size(); i++){
					doc06Bean = (Doc06Bean) doc06DetailList.get(i);
					jobMapperDocNowInfo.setSched_table(doc06Bean.getTable_name());
					jobMapperDocNowInfo.setApplication(doc06Bean.getApplication());
					jobMapperDocNowInfo.setGroup_name(doc06Bean.getGroup_name());
					jobMapperDocNowInfo.setTask_type(doc06Bean.getTask_type());
					jobMapperDocNowInfo.setNode_id(doc06Bean.getNode_id());
					jobMapperDocNowInfo.setOwner(doc06Bean.getOwner());
					jobMapperDocNowInfo.setMemname(doc06Bean.getMem_name());
					jobMapperDocNowInfo.setMem_lib(doc06Bean.getMem_lib());
					jobMapperDocNowInfo.setT_set(doc06Bean.getT_set());
					jobMapperDocNowInfo.setFrom_time(doc06Bean.getTime_from());
					jobMapperDocNowInfo.setTo_time(doc06Bean.getTime_until());
					jobMapperDocNowInfo.setT_conditions_in(doc06Bean.getT_conditions_in());
					jobMapperDocNowInfo.setT_conditions_out(doc06Bean.getT_conditions_out());
					jobMapperDocNowInfo.setCyclic(doc06Bean.getCyclic());
					jobMapperDocNowInfo.setRerun_max(doc06Bean.getRerun_max());
					jobMapperDocNowInfo.setPriority(doc06Bean.getPriority());
					jobMapperDocNowInfo.setConfirm_flag(doc06Bean.getConfirm_flag());
					jobMapperDocNowInfo.setActive_from(doc06Bean.getActive_from());
	                jobMapperDocNowInfo.setActive_till(doc06Bean.getActive_till());
	                jobMapperDocNowInfo.setCmd_line(doc06Bean.getCommand());
	                jobMapperDocNowInfo.setDays_cal(doc06Bean.getDays_cal());
	                jobMapperDocNowInfo.setT_steps(doc06Bean.getT_steps());
	                jobMapperDocNowInfo.setT_resources_q(doc06Bean.getT_resources_q());
	                jobMapperDocNowInfo.setCalendar_nm(doc06Bean.getDays_cal());
	                jobMapperDocNowInfo.setDescription(doc06Bean.getDescription());
	                jobMapperDocNowInfo.setCritical(doc06Bean.getCritical());
				}
			}
		}
				
		// DOC_GB, DOC_CD 가져오기
		strDocCd = CommonUtil.isNull(paramMap.get("doc_cd_old"));
		strDocGb = CommonUtil.isNull(paramMap.get("doc_gb_old"));
		
		JobMapperBean jobMapperDocPrevInfo = null;
		paramMap.put("doc_cd", strDocCd);
		paramMap.put("doc_gb", strDocGb);
		paramMap.put("JOB_NAME", CommonUtil.isNull(paramMap.get("job_name")));
		
		logger.debug("strDocGb : " + strDocGb);
		logger.debug("JOB_NAME : " + CommonUtil.isNull(paramMap.get("job_name")));

		if(strDocGb.equals("09")) {
			doc09Bean = worksApprovalDocService.dGetDoc09(paramMap);
			paramMap.put("doc_gb", doc09Bean.getDoc_gb());
			strDocGb = doc09Bean.getDoc_gb();
			
			logger.debug("바뀐 strDocGb : " + doc09Bean.getDoc_gb());
		}
		
		jobMapperDocPrevInfo = worksUserService.dGetJobMapperDocPrevInfo(paramMap);
		
		if(jobMapperDocPrevInfo != null){
			logger.debug("문서번호 추가 :::" + strDocCd);
			jobMapperDocPrevInfo.setDoc_cd(strDocCd);
			
			if(strDocGb.equals("01")){
				doc01Bean = worksApprovalDocService.dGetDoc01(paramMap);
				jobMapperDocPrevInfo.setSched_table(doc01Bean.getTable_name());
				jobMapperDocPrevInfo.setApplication(doc01Bean.getApplication());
				jobMapperDocPrevInfo.setGroup_name(doc01Bean.getGroup_name());
				jobMapperDocPrevInfo.setTask_type(doc01Bean.getTask_type());
				jobMapperDocPrevInfo.setNode_id(doc01Bean.getNode_id());
				jobMapperDocPrevInfo.setOwner(doc01Bean.getOwner());
				jobMapperDocPrevInfo.setMemname(doc01Bean.getMem_name());
				jobMapperDocPrevInfo.setMem_lib(doc01Bean.getMem_lib());
				jobMapperDocPrevInfo.setT_set(doc01Bean.getT_set());
				jobMapperDocPrevInfo.setCreation_date(doc01Bean.getApply_date());
				jobMapperDocPrevInfo.setFrom_time(doc01Bean.getTime_from());
				jobMapperDocPrevInfo.setTo_time(doc01Bean.getTime_until());
				jobMapperDocPrevInfo.setT_conditions_in(doc01Bean.getT_conditions_in());
				jobMapperDocPrevInfo.setT_conditions_out(doc01Bean.getT_conditions_out());
				jobMapperDocPrevInfo.setCyclic(doc01Bean.getCyclic());
				jobMapperDocPrevInfo.setRerun_max(doc01Bean.getRerun_max());
				jobMapperDocPrevInfo.setPriority(doc01Bean.getPriority());
	            jobMapperDocPrevInfo.setConfirm_flag(doc01Bean.getConfirm_flag());
	            jobMapperDocPrevInfo.setActive_from(doc01Bean.getActive_from());
	            jobMapperDocPrevInfo.setActive_till(doc01Bean.getActive_till());
	            jobMapperDocPrevInfo.setCmd_line(doc01Bean.getCommand());
	            jobMapperDocPrevInfo.setDays_cal(doc01Bean.getDays_cal());
	            jobMapperDocPrevInfo.setT_resources_c(doc01Bean.getT_resources_c());
	            jobMapperDocPrevInfo.setT_resources_q(doc01Bean.getT_resources_q());
	            jobMapperDocPrevInfo.setCalendar_nm(doc01Bean.getDays_cal());
	            jobMapperDocPrevInfo.setDescription(doc01Bean.getDescription());
	            jobMapperDocPrevInfo.setCritical(doc01Bean.getCritical());
			}else if(strDocGb.equals("04")){
				doc04Bean = worksApprovalDocService.dGetDoc04(paramMap);
				jobMapperDocPrevInfo.setSched_table(doc04Bean.getTable_name());
				jobMapperDocPrevInfo.setApplication(doc04Bean.getApplication());
				jobMapperDocPrevInfo.setGroup_name(doc04Bean.getGroup_name());
				jobMapperDocPrevInfo.setTask_type(doc04Bean.getTask_type());
				jobMapperDocPrevInfo.setNode_id(doc04Bean.getNode_id());
				jobMapperDocPrevInfo.setOwner(doc04Bean.getOwner());
				jobMapperDocPrevInfo.setMemname(doc04Bean.getMem_name());
				jobMapperDocPrevInfo.setMem_lib(doc04Bean.getMem_lib());
				jobMapperDocPrevInfo.setT_set(doc04Bean.getT_set());
				jobMapperDocPrevInfo.setCreation_date(doc04Bean.getApply_date());
				jobMapperDocPrevInfo.setFrom_time(doc04Bean.getTime_from());
				jobMapperDocPrevInfo.setTo_time(doc04Bean.getTime_until());
				jobMapperDocPrevInfo.setT_conditions_in(doc04Bean.getT_conditions_in());
				jobMapperDocPrevInfo.setT_conditions_out(doc04Bean.getT_conditions_out());
				jobMapperDocPrevInfo.setCyclic(doc04Bean.getCyclic());
				jobMapperDocPrevInfo.setRerun_max(doc04Bean.getRerun_max());
				jobMapperDocPrevInfo.setPriority(doc04Bean.getPriority());
				jobMapperDocPrevInfo.setConfirm_flag(doc04Bean.getConfirm_flag());
				jobMapperDocPrevInfo.setActive_from(doc04Bean.getActive_from());
	            jobMapperDocPrevInfo.setActive_till(doc04Bean.getActive_till());
	            jobMapperDocPrevInfo.setCmd_line(doc04Bean.getCommand());
	            jobMapperDocPrevInfo.setDays_cal(doc04Bean.getDays_cal());
	            jobMapperDocPrevInfo.setT_resources_c(doc04Bean.getT_resources_c());
	            jobMapperDocPrevInfo.setT_resources_q(doc04Bean.getT_resources_q());
	            jobMapperDocPrevInfo.setCalendar_nm(doc04Bean.getDays_cal());
	            jobMapperDocPrevInfo.setDescription(doc04Bean.getDescription());
	            jobMapperDocPrevInfo.setCritical(doc04Bean.getCritical());
			}else if(strDocGb.equals("06")){
				doc06Bean = worksApprovalDocService.dGetDoc06(paramMap);
				doc06DetailList = worksApprovalDocService.dGetDoc06DetailList(paramMap);
				for(int i=0; i<doc06DetailList.size(); i++){
					doc06Bean = (Doc06Bean) doc06DetailList.get(i);
					jobMapperDocPrevInfo.setSched_table(doc06Bean.getTable_name());
					jobMapperDocPrevInfo.setApplication(doc06Bean.getApplication());
					jobMapperDocPrevInfo.setGroup_name(doc06Bean.getGroup_name());
					jobMapperDocPrevInfo.setTask_type(doc06Bean.getTask_type());
					jobMapperDocPrevInfo.setNode_id(doc06Bean.getNode_id());
					jobMapperDocPrevInfo.setOwner(doc06Bean.getOwner());
					jobMapperDocPrevInfo.setMem_lib(doc06Bean.getMem_lib());
					jobMapperDocPrevInfo.setMemname(doc06Bean.getMem_name());
					jobMapperDocPrevInfo.setT_set(doc06Bean.getT_set());
					jobMapperDocPrevInfo.setCreation_date(doc06Bean.getApply_date());
					jobMapperDocPrevInfo.setFrom_time(doc06Bean.getTime_from());
					jobMapperDocPrevInfo.setTo_time(doc06Bean.getTime_until());
					jobMapperDocPrevInfo.setT_conditions_in(doc06Bean.getT_conditions_in());
					jobMapperDocPrevInfo.setT_conditions_out(doc06Bean.getT_conditions_out());
					jobMapperDocPrevInfo.setCyclic(doc06Bean.getCyclic());
					jobMapperDocPrevInfo.setRerun_max(doc06Bean.getRerun_max());
					jobMapperDocPrevInfo.setPriority(doc06Bean.getPriority());
					jobMapperDocPrevInfo.setConfirm_flag(doc06Bean.getConfirm_flag());
					jobMapperDocPrevInfo.setActive_from(doc06Bean.getActive_from());
	                jobMapperDocPrevInfo.setActive_till(doc06Bean.getActive_till());
	                jobMapperDocPrevInfo.setCmd_line(doc06Bean.getCommand());
	                jobMapperDocPrevInfo.setDays_cal(doc06Bean.getDays_cal());
	                jobMapperDocPrevInfo.setT_resources_c(doc06Bean.getT_resources_c());
	                jobMapperDocPrevInfo.setT_resources_q(doc06Bean.getT_resources_q());
	                jobMapperDocPrevInfo.setCalendar_nm(doc06Bean.getDays_cal());
	                jobMapperDocPrevInfo.setDescription(doc06Bean.getDescription());
	                jobMapperDocPrevInfo.setCritical(doc06Bean.getCritical());
				}
			}
		}
		
		ModelAndView output = null;
		output = new ModelAndView("contents/popup/jobDefineCompareInfo");	
		
		output.addObject("jobMapperDocNowInfo", jobMapperDocNowInfo);
		output.addObject("jobMapperDocPrevInfo", jobMapperDocPrevInfo);
		output.addObject("docCompareInfo", "Y");
		return output;
	}
	
	public ModelAndView ezQuartzLogView(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		
		
		ModelAndView output = null;
		output = new ModelAndView("contents/popup/popQuartzLogView");
		output.addObject("trace_log_file", CommonUtil.isNull(paramMap.get("trace_log_file")));
		output.addObject("trace_log_path", CommonUtil.isNull(paramMap.get("trace_log_path")));
		
		return output;
		
	}
	
	public ModelAndView executionLog(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {
		
		ModelAndView output = new ModelAndView("contents/popup/executionLog");
		
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));

		String strDataCenter 	= CommonUtil.isNull(paramMap.get("data_center"));
		String strOrderId 		= CommonUtil.isNull(paramMap.get("order_id"));
		String strNodeId 		= CommonUtil.isNull(paramMap.get("node_id"));
		
		String strFlag 			= CommonUtil.isNull(paramMap.get("flag"));
		String strOdate 		= CommonUtil.isNull(paramMap.get("odate"));
		
		String strRerunCount 	= CommonUtil.isNull(paramMap.get("rerun_count"));
		String search_text 		= CommonUtil.isNull(paramMap.get("search_text"));
		String search_gubun 	= CommonUtil.isNull(paramMap.get("search_gubun"));
		String strLogFromLine	= CommonUtil.isNull(paramMap.get("from_line"));
		String strLogToLine	 	= CommonUtil.isNull(paramMap.get("to_line"));
		String strLogMaxLine	= "5000";
		String executionLog 	= "";
		
		List<CustomerLogEntry> customerLogEntries 	= new ArrayList<>();
		JAXBContext  jContext 		= null;
		
		//라인 제한 수(코드관리에서 관리)
		paramMap.put("mcode_cd", "M71");
		List sCodeList = commonService.dGetsCodeList(paramMap);

		for (int i = 0; null != sCodeList && i < sCodeList.size(); i++) {
			CommonBean sCodeBean = (CommonBean) sCodeList.get(i);
			strLogMaxLine = CommonUtil.isNull(sCodeBean.getScode_nm()); //M71 코드가 등록이 되어있지 않으면 기본 값이 5000줄로 맞춤
		}
		
		if (strLogFromLine.equals("")) {
			strLogFromLine = "1";
		}

		if (strLogToLine.equals("")) {
			strLogToLine = Integer.parseInt(strLogFromLine) + Integer.parseInt(strLogMaxLine) - 1 + "";
		}
		output.addObject("strLogMaxLine", 	strLogMaxLine);
		output.addObject("strLogFromLine", 	strLogFromLine);
		output.addObject("strLogToLine", 	strLogToLine);

		//호스트 조회에 필요한 값이 없으면 화면에 메세지 뿌리고 종료.
//		if (strDataCenter.equals("") || strNodeId.equals("") || strOrderId.equals("") || strRerunCount.equals("0")) {
//			executionLog = "호스트 정보를 찾을 수 없습니다. (strDataCenter: "+strDataCenter+", strNodeId: "+strNodeId+")";
//			output.addObject("executionLog", executionLog);
//			return output;
//		}

		//Host 정보.
		paramMap.put("data_center"	, strDataCenter);
		paramMap.put("host"			, strNodeId);
		
		String dGetNodeId = commonService.dGetNodeInfo(paramMap); //그룹으로 묶인 AGENT의 경우 RERUN시에 수행서버가 달라질 수 있으므로 작업의 RUNINFO HISTORY를 통해 해당 RERUN COUNT의 수행 AGENT를 조회.
		
		paramMap.put("mcode_cd", "M6");
		sCodeList = commonService.dGetsCodeList(paramMap);
		CommonBean sCodeBean = (CommonBean) sCodeList.get(0);
		String ctmServer = CommonUtil.isNull(sCodeBean.getScode_eng_nm());

		paramMap.put("host"			, ctmServer);
		paramMap.put("node_id"		, ctmServer);
		
		if(CommonUtil.isNull(dGetNodeId).equals("")) {
			dGetNodeId = strNodeId;
		}

		CommonBean commonBean = commonService.dGetHostInfo(paramMap);
		
		String strHost 				= "";
		String strPort 				= "";
		String strUserId 			= "";
		String strUserPw 			= "";
		String strAccessGubun 		= "";
		String strServerLang 		= "";
		String strExecutionLog		= "";

		//수행 Agent 정보가 없으면 화면에 메세지 뿌리고 종료.
		if ( commonBean == null ) {
			executionLog = "호스트 정보를 찾을 수 없습니다. (strDataCenter: "+strDataCenter+", strNodeId: "+strNodeId+")";
			output.addObject("executionLog", executionLog);
			return output;
		} else {
			strHost 			= commonBean.getNode_id();
			strPort 			= commonBean.getAccess_port();
			strUserId 			= commonBean.getAgent_id();
			strUserPw 			= SeedUtil.decodeStr(CommonUtil.isNull(commonBean.getAgent_pw()));
			strAccessGubun		= CommonUtil.isNull(commonBean.getAccess_gubun());
			strServerLang		= CommonUtil.isNull(commonBean.getServer_lang());
		}
		
		//파일명 관련 규칙 (order_id는 6자리, rerun_count는 5자리)
		strOrderId 		= CommonUtil.lpad(strOrderId, 5, "0");
		strRerunCount 	= CommonUtil.lpad(strRerunCount, 5, "0");
		
		logger.info("order id ::::: " + strOrderId);
		logger.info("rerun count ::::: " + strRerunCount);
		
		//실시간 수행의 파일명과 파일 경로 (kubernetes의 경우 해당 경로를 다시 잡아줘야함)
		String strFileName 			= "customer_log_" + strOrderId + "_" + strRerunCount + ".xml";
		String strRemoteFilePath 	= "";

		//sysout 경로를 C-M magager 서버의 공통경로로 설정
		paramMap.put("mcode_cd", "M97");
		sCodeList = commonService.dGetsCodeList(paramMap);
		sCodeBean = (CommonBean) sCodeList.get(0);
		strRemoteFilePath = CommonUtil.isNull(sCodeBean.getScode_nm()) + "/" + dGetNodeId + "/cm/AI/CustomerLogs/";
		
		logger.info("strFileName 		::::: " + strFileName);
		logger.info("strRemoteFilePath 	::::: " + strRemoteFilePath);
		
		if ( strServerLang.equals("E") ) {
			strServerLang = "EUC-KR";
		} else {
			strServerLang = "UTF-8";
		}
		
		try {
			
			// @XmlRootElement를 정의한 클래스를 인자로 넣어 준다.
			jContext = JAXBContext.newInstance(CustomerLog.class);
			Unmarshaller unmarshaller = jContext.createUnmarshaller();
			
			String cmd = "cat " + strRemoteFilePath + "/" + strFileName;
			
			if( "S".equals(strAccessGubun) ){
				Ssh2Util su = new Ssh2Util(strHost, Integer.parseInt(strPort), strUserId, strUserPw, cmd, strServerLang);
				strExecutionLog = su.getOutput();

			}else{
				TelnetUtil tu = new TelnetUtil(strHost, Integer.parseInt(strPort), strUserId, strUserPw, cmd);
				strExecutionLog = tu.getOutput();
			}
			
			logger.info("strExecutionLog 	::::: " + strExecutionLog);
			
			//strExecutionLog를 List화 해야함
			// XML 데이터를 StringReader로 변환
		    StringReader reader = new StringReader(strExecutionLog);

		    // XML 데이터를 CustomerLog 객체로 변환
		    CustomerLog customerLog = (CustomerLog) unmarshaller.unmarshal(reader);

		    // CustomerLogEntry 리스트를 가져오기
		    customerLogEntries = customerLog.getCustomerLogEntries(); // getEntries는 CustomerLog 클래스의 메서드로 가정

		}catch (Exception e) {
			e.printStackTrace();
		}
		
		output.addObject("server_lang",		strServerLang);
		output.addObject("executionLog", 	executionLog);
		output.addObject("customerLogEntries", 	customerLogEntries);
		return output;
	}
}
