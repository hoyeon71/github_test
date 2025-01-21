package com.ghayoun.ezjobs.a.controller;

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
import com.ghayoun.ezjobs.a.domain.AlertBean;
import com.ghayoun.ezjobs.a.service.EmAlertService;
import com.ghayoun.ezjobs.comm.domain.CommonBean;
import com.ghayoun.ezjobs.comm.service.CommonService;
import com.ghayoun.ezjobs.common.util.BaseController;
import com.ghayoun.ezjobs.common.util.CommonUtil;
import com.ghayoun.ezjobs.common.util.DateUtil;
import com.ghayoun.ezjobs.common.util.DefaultServiceException;
import com.ghayoun.ezjobs.common.util.Paging;

public class EmController extends BaseController {

	protected final Log logger = LogFactory.getLog(getClass());

	private CommonService commonService;
	private EmAlertService emAlertService;
	
	public void setCommonService(CommonService commonService) {
		this.commonService = commonService;
	}
	public void setEmAlertService(EmAlertService emAlertService) {
		this.emAlertService = emAlertService;
	}
	
	public ModelAndView ez001(HttpServletRequest req, HttpServletResponse res ) throws ServletException, IOException, Exception{
		
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		
		List odateList = CommonUtil.getOdateList();
		int odate_cnt = odateList.size();
		
		
		ModelAndView output = null;
		output = new ModelAndView("works/C04/main_contents/alertList");		
		output.addObject("cm", CommonUtil.getComScodeList(paramMap));
		output.addObject("sCodeList", CommonUtil.getComCodeList(paramMap));	
		if(odate_cnt > 0){
			for(int i=0;i<odate_cnt;i++){
				CommonBean bean = (CommonBean) odateList.get(0);		
				output.addObject("ODATE", bean.getView_odate().replaceAll("/", ""));
			}
		}else{
			output.addObject("ODATE", "");
		}
		
		return output;
    	
	}
	
	public ModelAndView ez001_excel(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {
		
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		
		paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
		paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		paramMap.put("pagingNum", "");
		
		String severity = CommonUtil.isNull(paramMap.get("p_severity"));
		String[] arr_severity = severity.split("_");

		List<AlertBean> alertList = new ArrayList<AlertBean>();
		
		if(arr_severity.length > 1 ) {
			for(int i = 0; i < arr_severity.length; i++) {
				paramMap.put("p_severity", arr_severity[i]);
				alertList.addAll(emAlertService.dGetAlertList(paramMap));
			}
		}else {
			alertList = emAlertService.dGetAlertList(paramMap);
		}

		List alertHandled0List 	= commonService.getCategoryList(paramMap,"ALERT.HANDLED.0");
		List alertHandled1List 	= commonService.getCategoryList(paramMap,"ALERT.HANDLED.1");
		List alertHandled2List 	= commonService.getCategoryList(paramMap,"ALERT.HANDLED.2");
		
		// MAX SERIAL.
		CommonBean alertbean2 = emAlertService.dGetAlertLastSerial(paramMap);
		
		ModelAndView output = null;
		output = new ModelAndView("contents/alertListExcel");
		
		output.addObject("alertList",			alertList);
		output.addObject("alertHandled0List",	alertHandled0List);
		output.addObject("alertHandled1List",	alertHandled1List);
		output.addObject("alertHandled2List",	alertHandled2List);
		output.addObject("max_serial",			alertbean2.getTotal_count());
		
		return output;
	}
	
	public ModelAndView ez001_p(HttpServletRequest req, HttpServletResponse res ) 
									throws ServletException, IOException, Exception{
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		Map<String, Object> rMap 	= new HashMap<String, Object>();
		
		paramMap.put("userToken", CommonUtil.isNull(req.getSession().getAttribute("USER_TOKEN")));
		
		rMap = emAlertService.prcChangeAlertStatus(paramMap);
		
		AlertBean alertBean = null;
		List alertHandled0List 	= null;
		List alertHandled1List 	= null;
		List alertHandled2List 	= null;
		if( "1".equals(CommonUtil.isNull(rMap.get("rCode"))) ){
			alertBean = emAlertService.dGetAlert(paramMap);
			
			alertHandled0List 	= commonService.getCategoryList(paramMap,"ALERT.HANDLED.0");
			alertHandled1List 	= commonService.getCategoryList(paramMap,"ALERT.HANDLED.1");
			alertHandled2List 	= commonService.getCategoryList(paramMap,"ALERT.HANDLED.2");
		}

		ModelAndView output = null;
		output = new ModelAndView("ezjobs/a/result");
		output.addObject("rMap",rMap);
		output.addObject("alertBean",alertBean);
		
		output.addObject("alertHandled0List",alertHandled0List);
		output.addObject("alertHandled1List",alertHandled1List);
		output.addObject("alertHandled2List",alertHandled2List);
		
		return output;
		
	}
	
	public ModelAndView ez002(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException, Exception {

		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));

		ModelAndView output = null;

		// MAX SERIAL.
		CommonBean alertbean2 = emAlertService.dGetAlertLastSerial(paramMap);

		//output = new ModelAndView("ezjobs/t/works/ajaxReturn");
		output = new ModelAndView("common/inc/ajaxReturn");

		output.addObject("commonbean", alertbean2);

		return output;
	}
	
	@SuppressWarnings("unchecked")
	public ModelAndView ez003(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		
		String strUserGb = CommonUtil.isNull(req.getSession().getAttribute("USER_GB"));
		String strUserCd = CommonUtil.isNull(req.getSession().getAttribute("USER_CD"));
		String strUserId = CommonUtil.isNull(req.getSession().getAttribute("USER_ID"));

		// 운영자가 아니면 본인 것만 나온다.
		if (!strUserGb.equals("02")) {
			paramMap.put("user_cd", strUserCd);
		}

		paramMap.put("s_user_id", strUserId);
		
		List<CommonBean> odateList = CommonUtil.getOdateList();
		int odate_cnt = odateList.size();
		String odate = "";
		String from_date = "";
		String to_date = "";
		
		if(odate_cnt > 0){
			for(int i=0;i<odate_cnt;i++){
				CommonBean bean = odateList.get(0);		
				odate = bean.getView_odate();
			}
		}
		
		// 일배치 에러목록은 마지막 ODATE 전날을 Default로 셋팅.
		if(!odate.equals("") ) { 
			from_date = DateUtil.add(odate, 2, -1).replaceAll("-", "");
			to_date = DateUtil.add(odate, 2, 0).replaceAll("-", "");
		}	
		System.out.println("paramMap : " + paramMap);
		paramMap.put("s_user_cd", paramMap.get("user_cd"));
		ModelAndView output = null;
		output = new ModelAndView("works/C04/main_contents/alertErrorList");	
		output.addObject("paramMap", paramMap);
		output.addObject("cm", CommonUtil.getComScodeList(paramMap));
		// 에러유형코드 : M4
		paramMap.put("mcode_cd", "M4");
		output.addObject("sCodeList", CommonUtil.getComCodeList(paramMap));	
		//output.addObject("dataCenterList", CommonUtil.getDataCenterList());
		output.addObject("FROM_ODATE", from_date);
		output.addObject("TO_ODATE", to_date);
		
		
		// 대분류 검색 화면
		paramMap.put("mcode_search", "Y");
		output.addObject("mcodeList", CommonUtil.getMcodeList(paramMap));
		
		return output;
	}
	
	@SuppressWarnings("unchecked")
	public ModelAndView ez003_op(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

		Map<String, Object> paramMap = CommonUtil.collectParametersK2E(req);
		
		String strUserGb 	= CommonUtil.isNull(req.getSession().getAttribute("USER_GB"));
		String strUserCd 	= CommonUtil.isNull(req.getSession().getAttribute("USER_CD"));
		String strUserId 	= CommonUtil.isNull(req.getSession().getAttribute("USER_ID"));
		
		String strOldOdate 	= CommonUtil.isNull(paramMap.get("old_odate"));
		String strTopMenu 	= CommonUtil.isNull(paramMap.get("top_menu"));

		// 운영자가 아니면 본인 것만 나온다.
		if (!strUserGb.equals("02")) {
			paramMap.put("user_cd", strUserCd);
		}

		paramMap.put("s_user_id", strUserId);
		
		List<CommonBean> odateList = CommonUtil.getOdateList();
		int odate_cnt = odateList.size();
		
		String odate 		= "";
		String from_date 	= "";
		String to_date 		= "";
		
		if(odate_cnt > 0){
			for(int i=0;i<odate_cnt;i++){
				CommonBean bean = odateList.get(0);		
				odate = bean.getView_odate();
			}
		}
		
		// 일배치 에러목록은 마지막 ODATE 전날을 Default로 셋팅.
		if(!odate.equals("") ) {

			if(strTopMenu.equals("Y")) {
				from_date 	= DateUtil.add(odate, 2, -7).replaceAll("-", "");
				to_date 	= DateUtil.add(odate, 2, 0).replaceAll("-", "");
			}else {
				//from_date 	= DateUtil.add(odate, 2, -2).replaceAll("-", "");
				from_date 	= DateUtil.add(odate, 2, -6).replaceAll("-", "");
				to_date 	= DateUtil.add(odate, 2, 0).replaceAll("-", "");
			}
		}

		// 관리자 즉시결재 유무 코드 추가
		List adminApprovalBtnList = null;

		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		paramMap.put("mcode_cd", "M80");
		adminApprovalBtnList = commonService.dGetsCodeList(paramMap);

		ModelAndView output = null;
		List opApprovalList = null;

		output = new ModelAndView("works/C04/main_contents/opAlertErrorList");
		
		output.addObject("paramMap", 	paramMap);
		output.addObject("cm", 			CommonUtil.getComScodeList(paramMap));
		// 에러유형코드 : M4
		paramMap.put("mcode_cd", "M4");
		output.addObject("sCodeList", 	CommonUtil.getComCodeList(paramMap));

		// 오류처리 결재여부 : M92
		paramMap.put("mcode_cd", "M92");
		opApprovalList = commonService.dGetsCodeList(paramMap);

		output.addObject("opApprovalList", 	opApprovalList);

		output.addObject("FROM_ODATE", 	from_date);
		output.addObject("TO_ODATE", 	to_date);

		output.addObject("adminApprovalBtnList", adminApprovalBtnList);

		// 최초 로그인 시 미조치 건으로 이동하는 경우라면 old_odate 셋팅
		if ( !strOldOdate.equals("") ) {
			output.addObject("FROM_ODATE", strOldOdate);
		}
		
		return output;
	}

	public ModelAndView ez003_excel(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

		Map<String, Object> paramMap = CommonUtil.collectParametersK2E(req);

		String strUserGb = CommonUtil.isNull(req.getSession().getAttribute("USER_GB"));
		String strUserCd = CommonUtil.isNull(req.getSession().getAttribute("USER_CD"));
		String strUserId = CommonUtil.isNull(req.getSession().getAttribute("USER_ID"));
		
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));

		// 운영자가 아니면 본인 것만 나온다.
		if (!strUserGb.equals("02")) {
			paramMap.put("user_cd", strUserCd);
		}
		
		paramMap.put("s_user_id", strUserId);

		String from_odate 			= CommonUtil.isNull(paramMap.get("from_odate"));
		String to_odate 			= CommonUtil.isNull(paramMap.get("to_odate"));
		
		String search_start_time1 	= CommonUtil.isNull(paramMap.get("search_start_time1"));
		String search_end_time1 	= CommonUtil.isNull(paramMap.get("search_end_time1"));

		if ( !from_odate.equals("") ) {
			from_odate 	= from_odate + " " + search_start_time1;
		}
		
		if ( !to_odate.equals("") ) {
			to_odate 	= to_odate + " " + search_end_time1;
		}
		
		paramMap.put("from_odate", 	from_odate);
		paramMap.put("to_odate", 	to_odate);
		paramMap.put("p_application_of_def", CommonUtil.isNull(paramMap.get("p_application_of_def")).replaceAll("&apos;","\'"));
		
		List<CommonBean> dataCenterList = CommonUtil.getDataCenterList();
		List<Map<String, Object>> data_center_items = new ArrayList<>();
		
		Map<String, Object> hm = null;
		
		for(int i=0;i<dataCenterList.size();i++){
			CommonBean bean = dataCenterList.get(i);
			
			hm = new HashMap();
			hm.put("data_center_code", bean.getData_center_code());
			hm.put("data_center", bean.getData_center());
			hm.put("active_net_name", bean.getActive_net_name());
			
			data_center_items.add(hm);
		}
		
		paramMap.put("data_center_items", data_center_items);

		List alertList = emAlertService.dGetAlertErrorList(paramMap);

		ModelAndView output = null;
//		output = new ModelAndView("ezjobs/a/em/alertErrorListExcel");
		output = new ModelAndView("contents/alertErrorListExcel");
		output.addObject("alertList", 	alertList);
		output.addObject("from_odate", 	from_odate);
		output.addObject("to_odate", 	to_odate);
		
		return output;
	}
	public ModelAndView ez003_op_excel(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

		Map<String, Object> paramMap = CommonUtil.collectParametersK2E(req);

		String strUserGb = CommonUtil.isNull(req.getSession().getAttribute("USER_GB"));
		String strUserCd = CommonUtil.isNull(req.getSession().getAttribute("USER_CD"));
		String strUserId = CommonUtil.isNull(req.getSession().getAttribute("USER_ID"));
		
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));

		// 운영자가 아니면 본인 것만 나온다.
		if (!strUserGb.equals("02")) {
			paramMap.put("user_cd", strUserCd);
		}
		
		paramMap.put("s_user_id", strUserId);
		
		paramMap.put("p_sched_table", 			CommonUtil.isNull(paramMap.get("p_sched_table")).replaceAll("&apos;","\'"));
		paramMap.put("p_application_of_def", 	CommonUtil.isNull(paramMap.get("p_application_of_def")).replaceAll("&apos;","\'"));
		paramMap.put("p_scode_nm", 				CommonUtil.isNull(paramMap.get("p_scode_nm")).replaceAll("&apos;","\'"));
		paramMap.put("s_user_cd", 				CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
		paramMap.put("s_user_gb", 				CommonUtil.isNull(req.getSession().getAttribute("USER_GB")));
		paramMap.put("s_dept_cd", 				CommonUtil.isNull(req.getSession().getAttribute("DEPT_CD")));
		paramMap.put("message", 				CommonUtil.isNull(paramMap.get("message")));

		paramMap.put("p_scode_nm", 				CommonUtil.isNull(paramMap.get("p_scode_nm")).replaceAll("&apos;","\'"));
		
		// 폴더 다중 검색(부산은행 23.10.20)
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

		String from_odate 			= CommonUtil.isNull(paramMap.get("from_odate"));
		String to_odate 			= CommonUtil.isNull(paramMap.get("to_odate"));
		
		String search_start_time1 	= CommonUtil.isNull(paramMap.get("search_start_time1"));
		String search_end_time1 	= CommonUtil.isNull(paramMap.get("search_end_time1"));

		if ( !from_odate.equals("") ) {
			from_odate 	= from_odate + " " + search_start_time1;
		}
		
		if ( !to_odate.equals("") ) {
			to_odate 	= to_odate + " " + search_end_time1;
		}
		
		paramMap.put("from_odate", 	from_odate);
		paramMap.put("to_odate", 	to_odate);
		List<CommonBean> dataCenterList = CommonUtil.getDataCenterList();
		List<Map<String, Object>> data_center_items = new ArrayList<>();
		
		Map<String, Object> hm = null;
		
		for(int i=0;i<dataCenterList.size();i++){
			CommonBean bean = dataCenterList.get(i);
			
			hm = new HashMap();
			hm.put("data_center_code", bean.getData_center_code());
			hm.put("data_center", bean.getData_center());
			hm.put("active_net_name", bean.getActive_net_name());
			
			data_center_items.add(hm);
		}
		
		paramMap.put("data_center_items", data_center_items);
		paramMap.put("active_net_name", dataCenterList.get(0).getActive_net_name());
		paramMap.put("data_center_code", dataCenterList.get(0).getData_center_code());
		paramMap.put("pagingNum", "");
		List alertList = emAlertService.dGetAlertErrorList(paramMap);

		ModelAndView output = null;
		output = new ModelAndView("contents/opAlertErrorListExcel");
		output.addObject("alertList", 	alertList);
		output.addObject("from_odate", 	from_odate);
		output.addObject("to_odate", 	to_odate);
		
		return output;
	}

	public ModelAndView ez003_alarm(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

		Map<String, Object> paramMap = CommonUtil.collectParametersK2E(req);

		String strUserGb = CommonUtil.isNull(req.getSession().getAttribute("USER_GB"));
		String strUserCd = CommonUtil.isNull(req.getSession().getAttribute("USER_CD"));

		// 운영자가 아니면 본인 것만 나온다.
		if (!strUserGb.equals("02")) {
			paramMap.put("user_cd", strUserCd);
		}

		String from_odate 			= CommonUtil.isNull(paramMap.get("from_odate"));
		String to_odate 			= CommonUtil.isNull(paramMap.get("to_odate"));
		String search_start_time1 	= CommonUtil.isNull(paramMap.get("search_start_time1"));
		String search_end_time1 	= CommonUtil.isNull(paramMap.get("search_end_time1"));

		if ( !from_odate.equals("") ) {
			from_odate 	= from_odate + " " + search_start_time1;
		}
		
		if ( !to_odate.equals("") ) {
			to_odate 	= to_odate + " " + search_end_time1;
		}
		
		paramMap.put("from_odate", from_odate);
		paramMap.put("to_odate", to_odate);

		CommonBean bean = emAlertService.dGetAlertErrorListCnt(paramMap);

		ModelAndView output = null;
		output = new ModelAndView("common/inc/ajaxReturn");
		
		output.addObject("commonbean", bean);

		return output;
	}

	@SuppressWarnings("unchecked")
	public ModelAndView ez003_p(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		Map<String, Object> rMap = new HashMap<String, Object>();

		String strUserCd = CommonUtil.isNull(req.getSession().getAttribute("USER_CD"));
		paramMap.put("s_user_cd", strUserCd);
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));

		try {
			System.out.println("paramMap : " + paramMap);
			rMap = emAlertService.dPrcAlarm(paramMap);

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

		ModelAndView output = null;
		output = new ModelAndView("result/a_result");
		output.addObject("rMap", rMap);

		return output;
	}
	
	@SuppressWarnings("unchecked")
	public ModelAndView ez003_p_all(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		Map<String, Object> rMap = new HashMap<String, Object>();
		Map<String, Object> ArrMap 	= new HashMap<String, Object>();
		
		String strUserCd = CommonUtil.isNull(req.getSession().getAttribute("USER_CD"));
		
		paramMap.put("s_user_cd", strUserCd);
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));

		try {

			String alarm_cd[]		= CommonUtil.isNull(paramMap.get("alarm_cd")).split("[|]");
			String user_cd[]		= CommonUtil.isNull(paramMap.get("user_cd")).split("[|]");
			
			for(int i=0; i<alarm_cd.length; i++ ){
				
				ArrMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
				
				String strAlarmCd 	= CommonUtil.isNull(alarm_cd[i]);

				ArrMap.put("flag", 				CommonUtil.isNull((paramMap).get("flag")));
				ArrMap.put("user_cd", 			CommonUtil.isNull(user_cd[i]));
				ArrMap.put("alarm_cd", 			strAlarmCd);
				ArrMap.put("s_user_cd", 		strUserCd);
				ArrMap.put("action_yn", 		"Y");
				ArrMap.put("confirm_yn", 		CommonUtil.isNull((paramMap).get("confirm_yn")));
				ArrMap.put("action_gubun",	 	CommonUtil.isNull((paramMap).get("action_gubun")));
				ArrMap.put("error_description", CommonUtil.isNull((paramMap).get("error_description")));
				
				rMap = emAlertService.dPrcAlarm(ArrMap);
			}
			
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

		ModelAndView output = null;
		output = new ModelAndView("result/a_result");
		output.addObject("rMap", rMap);

		return output;
	}

	public ModelAndView ez004(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException, Exception {

		Map<String, Object> paramMap = CommonUtil.collectParametersK2E(req);

		String currentPage = CommonUtil.isNull(paramMap.get("currentPage"));

		int rowSize = Integer.parseInt(CommonUtil
				.getMessage("PAGING.ROWSIZE.BASIC"));
		int pageSize = Integer.parseInt(CommonUtil
				.getMessage("PAGING.PAGESIZE.BASIC"));

		String strUserGb = CommonUtil.isNull(req.getSession().getAttribute(
				"USER_GB"));
		String strUserCd = CommonUtil.isNull(req.getSession().getAttribute(
				"USER_CD"));

		CommonBean bean = emAlertService.dGetJobErrorLogListCnt(paramMap);
		Paging paging = new Paging(bean.getTotal_count(), rowSize, pageSize,
				currentPage);

		paramMap.put("startRowNum", paging.getStartRowNum());
		paramMap.put("endRowNum", paging.getEndRowNum());

		List alertList = emAlertService.dGetJobErrorLogList(paramMap);

		List sCodeList = null;

		ModelAndView output = null;
		output = new ModelAndView("ezjobs/a/em/jobErrorLogList");
		output.addObject("alertList", alertList);
		output.addObject("Paging", paging);
		output.addObject("totalCount", paging.getTotalRowSize());

		return output;
	}

	public ModelAndView ez004_excel(HttpServletRequest req,
			HttpServletResponse res) throws ServletException, IOException,
			Exception {

		Map<String, Object> paramMap = CommonUtil.collectParametersK2E(req);
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));

		String strUserGb = CommonUtil.isNull(req.getSession().getAttribute(
				"USER_GB"));
		String strUserCd = CommonUtil.isNull(req.getSession().getAttribute(
				"USER_CD"));

		List alertList = emAlertService.dGetJobErrorLogList(paramMap);

		ModelAndView output = null;
		output = new ModelAndView("ezjobs/a/em/jobErrorLogListExcel");
		output.addObject("alertList", alertList);

		return output;
	}

}