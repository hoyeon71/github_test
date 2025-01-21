package com.ghayoun.ezjobs.m.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.servlet.ModelAndView;

import com.ghayoun.ezjobs.a.service.EmAlertService;
import com.ghayoun.ezjobs.comm.domain.CommonBean;
import com.ghayoun.ezjobs.comm.repository.CommonDao;
import com.ghayoun.ezjobs.comm.service.CommonService;
import com.ghayoun.ezjobs.comm.service.EzRplnJobServiceImpl;
import com.ghayoun.ezjobs.common.util.BaseController;
import com.ghayoun.ezjobs.common.util.CommonUtil;
import com.ghayoun.ezjobs.common.util.DateUtil;
import com.ghayoun.ezjobs.common.util.DefaultServiceException;
import com.ghayoun.ezjobs.common.util.FileUtil;
import com.ghayoun.ezjobs.common.util.Paging;
import com.ghayoun.ezjobs.common.util.SeedUtil;
import com.ghayoun.ezjobs.common.util.Ssh2Util;
import com.ghayoun.ezjobs.common.util.SshUtil;
import com.ghayoun.ezjobs.common.util.TelnetUtil;
import com.ghayoun.ezjobs.m.domain.BatchResultTotalBean;
import com.ghayoun.ezjobs.m.domain.CtmInfoBean;
import com.ghayoun.ezjobs.m.domain.DefJobBean;
import com.ghayoun.ezjobs.m.domain.JobLogBean;
import com.ghayoun.ezjobs.m.domain.TotalJobStatus;
import com.ghayoun.ezjobs.m.service.CtmInfoService;
import com.ghayoun.ezjobs.m.service.EmActiveJobsService;
import com.ghayoun.ezjobs.m.service.EmBatchResultTotalService;
import com.ghayoun.ezjobs.m.service.EmCtmInfoService;
import com.ghayoun.ezjobs.m.service.EmDefJobsService;
import com.ghayoun.ezjobs.m.service.EmJobLogService;
import com.ghayoun.ezjobs.m.service.EmPreDateBatchScheduleService;
import com.ghayoun.ezjobs.m.service.EmPreJobMissMatchService;
import com.ghayoun.ezjobs.m.service.PopupDefJobDetailService;
import com.ghayoun.ezjobs.t.service.WorksApprovalDocService;

public class EmController extends BaseController {

	protected final Log logger = LogFactory.getLog(getClass());

	private CommonService commonService;
	private EmActiveJobsService emActiveJobsService;
	private EmDefJobsService emDefJobsService;
	private EmPreJobMissMatchService emPreJobMissMatchService;
	private EmBatchResultTotalService emBatchResultTotalService;
	private EmPreDateBatchScheduleService emPreDateBatchScheduleService;
	private EmJobLogService emJobLogService;
	private EmCtmInfoService emCtmInfoService;
	private PopupDefJobDetailService popupDefJobDetailService;
	private CtmInfoService ctmInfoService;
	private WorksApprovalDocService worksApprovalDocService;

	public void setCommonService(CommonService commonService) {
		this.commonService = commonService;
	}

	public void setEmActiveJobsService(EmActiveJobsService emActiveJobsService) {
		this.emActiveJobsService = emActiveJobsService;
	}

	public void setEmDefJobsService(EmDefJobsService emDefJobsService) {
		this.emDefJobsService = emDefJobsService;
	}

	public void setEmPreJobMissMatchService(
			EmPreJobMissMatchService emPreJobMissMatchService) {
		this.emPreJobMissMatchService = emPreJobMissMatchService;
	}

	public void setEmBatchResultTotalService(
			EmBatchResultTotalService emBatchResultTotalService) {
		this.emBatchResultTotalService = emBatchResultTotalService;
	}

	public void setEmPreDateBatchScheduleService(
			EmPreDateBatchScheduleService emPreDateBatchScheduleService) {
		this.emPreDateBatchScheduleService = emPreDateBatchScheduleService;
	}

	public void setEmJobLogService(EmJobLogService emJobLogService) {
		this.emJobLogService = emJobLogService;
	}

	public void setEmCtmInfoService(EmCtmInfoService emCtmInfoService) {
		this.emCtmInfoService = emCtmInfoService;
	}
	
	public void setPopupDefJobDetailService(PopupDefJobDetailService popupDefJobDetailService) {
		this.popupDefJobDetailService = popupDefJobDetailService;
	}
	
	public void setCtmInfoService(CtmInfoService ctmInfoService) {
		this.ctmInfoService = ctmInfoService;
	}

	public void setWorksApprovalDocService(WorksApprovalDocService worksApprovalDocService) {
		this.worksApprovalDocService = worksApprovalDocService;
	}
	private Map<String, Object> replaceStatus(Map<String, Object> rMap,
			Map<String, Object> paramMap) {

		String rCode = CommonUtil.isNull(rMap.get("rCode"));
		String rOriType = CommonUtil.isNull(rMap.get("rOriType"));
		String rType = CommonUtil.isNull(rMap.get("rType"));

		String status = CommonUtil.isNull(paramMap.get("status"));
		
		/*

		if ("1".equals(rCode)) {
			if ("response_act_retrieve_jobs".equals(rOriType)) {
				if ("response_act_retrieve_jobs".equals(rType)) {

					String active_net_names = CommonUtil.isNull(paramMap
							.get("active_net_names"));
					paramMap.put("active_net_names", active_net_names
							.split(","));
					List fromTimeOrderIdList = emActiveJobsService
							.getFromTimeOrderIdList(paramMap);

					Response_act_retrieve_jobs_type t = (Response_act_retrieve_jobs_type) rMap
							.get("rObject");
					Response_job_act_retrieve_jobs_type[] t2 = t.getJobs();

					List<Response_job_act_retrieve_jobs_type> l = new ArrayList(
							Arrays.asList(t2));

					for (int i = 0; null != l && i < l.size(); i++) {
						Response_job_data_act_retrieve_jobs_type t3 = l.get(i)
								.getJob_data();

						if (CommonUtil.isNull(t3.getJob_state()).indexOf(
								"Deleted") > -1) {
							t3.setJob_status("Deleted");
						} else if (CommonUtil.isNull(t3.getJob_state())
								.indexOf("Held") > -1) {
							t3.setJob_status("Held");
						} else if ("Wait Condition".equals(CommonUtil.isNull(t3
								.getJob_status()))
								&& null != fromTimeOrderIdList
								&& fromTimeOrderIdList
										.indexOf(t3.getOrder_id()) > -1) {
							t3.setJob_status("Wait Time");
						}

						l.get(i).setJob_data(t3);

						if ("Wait Time".equals(status)) {
							if ("Wait Condition".equals(t3.getJob_status())) {
								l.remove(i);
								i--;
							}
						} else if ("Wait Condition".equals(status)) {
							if ("Wait Time".equals(t3.getJob_status())) {
								l.remove(i);
								i--;
							}
						}

					}

					t.setJobs(l
							.toArray(new Response_job_act_retrieve_jobs_type[l
									.size()]));
					rMap.put("rObject", t);
				}
			}
		}
		*/

		return rMap;
	}

	/*
	 * public ModelAndView ez000(HttpServletRequest req, HttpServletResponse res
	 * ) throws ServletException, IOException, Exception{ Map<String, Object>
	 * paramMap = CommonUtil.collectParameters(req); Map<String, Object> rMap
	 * = new HashMap<String, Object>();
	 * 
	 * paramMap.put("userToken",
	 * CommonUtil.isNull(req.getSession().getAttribute("USER_TOKEN")));
	 * 
	 * paramMap.put("searchType", "dataCenterList"); List dataCenterList =
	 * commonService.dGetSearchItemList(paramMap);
	 * 
	 * paramMap.put("searchType", "odateList"); List odateList =
	 * commonService.dGetSearchItemList(paramMap);
	 * paramMap.put("odate",((CommonBean)odateList.get(0)).getOdate()); rMap =
	 * emActiveJobsService.getActiveJobs(paramMap);
	 * 
	 * String active_net_names = ""; for(int i=0; i<dataCenterList.size(); i++){
	 * CommonBean bean = (CommonBean)dataCenterList.get(i); if(
	 * "".equals(active_net_names) ) active_net_names =
	 * bean.getActive_net_name(); else active_net_names +=
	 * (","+bean.getActive_net_name()); } paramMap.put("active_net_names",
	 * active_net_names); rMap = this.replaceStatus(rMap, paramMap);
	 * 
	 * ModelAndView output = null; output = new
	 * ModelAndView("ezjobs/m/em/dashBoard");
	 * output.addObject("odate",paramMap.get("odate"));
	 * output.addObject("dataCenterList",dataCenterList);
	 * output.addObject("rMap",rMap);
	 * 
	 * return output;
	 * 
	 * }
	 */


	public ModelAndView ez000(HttpServletRequest req, HttpServletResponse res)
		throws ServletException, IOException, Exception {
		
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		Map<String, Object> rMap = new HashMap<String, Object>();
		
		paramMap.put("searchType", "dataCenterList");
		paramMap.put("mcode_cd", "dataCenterList");
		
		List dataCenterList = commonService.dGetSearchItemList(paramMap);

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
		
		List totalJobStatusList = emActiveJobsService.getTotalJobStatusList(paramMap);
		
		paramMap.put("user_id", CommonUtil.isNull(req.getSession().getAttribute("USER_ID")));
		
		// 결재라인 갯수.(하나도 없으면 메인화면에서 결재선지정 팝업 노출시키기 위해.)
		CommonBean bean = emActiveJobsService.dGetApprovalLineCnt(paramMap);
		String approval_line_count = CommonUtil.isNull(bean.getTotal_count(), "0");
		
		ModelAndView output = null;
		output = new ModelAndView("contents/dashBoard");
		//output = new ModelAndView("ezjobs/m/em/dashBoard2");
		output.addObject("totalJobStatusList"	, totalJobStatusList);
		output.addObject("dataCenterList"		, dataCenterList);
		output.addObject("approval_line_count"	, approval_line_count);
		output.addObject("ErrorList"			, emCtmInfoService.dGetDashBoard_errList(paramMap));

		return output;
		
	}
		

	public ModelAndView ez001(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException, Exception {
		
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		
		Map<String, Object> rMap = new HashMap<String, Object>();

		CommonUtil.emLogin(req);
		paramMap.put("userToken", CommonUtil.isNull(req.getSession()
				.getAttribute("USER_TOKEN")));

		rMap = emActiveJobsService.getActiveJobs(paramMap);

		rMap = this.replaceStatus(rMap, paramMap);

		ModelAndView output = null;
		output = new ModelAndView("ezjobs/m/em/activeJobs");
		output.addObject("rMap", rMap);

		return output;

	}

	@SuppressWarnings("unchecked")
	public ModelAndView ez003(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {
		
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		
		paramMap.put("s_user_cd", 	CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
		paramMap.put("SCHEMA", 		CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		
		String conditionNums[] = new String[70];
		for (int i = 0; i < conditionNums.length; i++) {
			conditionNums[i] = (i + 1) + "";
		}
		paramMap.put("conditionNums", conditionNums);
				
		List<CommonBean> odateList = CommonUtil.getOdateList();
		int odate_cnt = odateList.size();
		
		ModelAndView output = null;
		output = new ModelAndView("works/C02/main_contents/defJobs");
		output.addObject("paramMap", paramMap);
		output.addObject("cm", CommonUtil.getComScodeList(paramMap));
		
		// 대분류 검색 화면
		paramMap.put("mcode_search", "Y");
		output.addObject("mcodeList", CommonUtil.getMcodeList(paramMap));
		
		if(odate_cnt > 0){
			for(int i=0;i<odate_cnt;i++){
				CommonBean bean = (CommonBean) odateList.get(0);		
				String odate = bean.getView_odate().replaceAll("/", "");
				output.addObject("ODATE", odate);				
			}
		}else{
			output.addObject("ODATE", "");		
		}
		
		return output;
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	public ModelAndView ez003_excel2(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));

		String conditionNums[] = new String[70];
		for (int i = 0; i < conditionNums.length; i++) {
			conditionNums[i] = (i + 1) + "";
		}
		paramMap.put("conditionNums", conditionNums);
		
		paramMap.put("p_sched_table", 			CommonUtil.isNull(paramMap.get("p_sched_table")).replaceAll("&apos;","\'"));
		paramMap.put("p_application_of_def", 	CommonUtil.isNull(paramMap.get("p_application_of_def")).replaceAll("&apos;","\'"));
		paramMap.put("p_scode_nm", 				CommonUtil.isNull(paramMap.get("p_scode_nm")).replaceAll("&apos;","\'"));
		paramMap.put("s_user_cd", 				CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
		paramMap.put("s_user_gb", 				CommonUtil.isNull(req.getSession().getAttribute("USER_GB")));
		paramMap.put("s_dept_cd", 				CommonUtil.isNull(req.getSession().getAttribute("DEPT_CD")));
		
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
				System.out.println(text);
				p_search_job_name_list.add(text);
			}
			int totalElements = p_search_job_name_list.size();
			paramMap.put("p_search_job_name_list", p_search_job_name_list);
		}

		paramMap.put("pagingNum", "");
		
		List defJobList = emDefJobsService.dGetDefJobList(paramMap);

		ModelAndView output = null;
		output = new ModelAndView("contents/defJobsExcel2");
		output.addObject("defJobList", defJobList);

		return output;
	}
	
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public ModelAndView ez003_excel_doc(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {
		
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));

		String conditionNums[] = new String[70];
		for (int i = 0; i < conditionNums.length; i++) {
			conditionNums[i] = (i + 1) + "";
		}
		
		List smsDefaultList		= null;
		List mailDefaultList	= null;
		//SMS 기본값 설정
		paramMap.put("mcode_cd", "M87");
		smsDefaultList = commonService.dGetsCodeList(paramMap);
		
		//MAIL 기본값 설정
		paramMap.put("mcode_cd", "M88");
		mailDefaultList = commonService.dGetsCodeList(paramMap);
		
		paramMap.put("conditionNums", conditionNums);
		
		String p_sched_table =  CommonUtil.isNull(paramMap.get("p_sched_table")).replaceAll("&apos;","\'");
		paramMap.put("p_sched_table", p_sched_table);
		paramMap.put("s_user_cd", 				CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
		paramMap.put("s_user_gb", 				CommonUtil.isNull(req.getSession().getAttribute("USER_GB")));
		
		String p_application_of_def =  CommonUtil.isNull(paramMap.get("p_application_of_def")).replaceAll("&apos;","\'");
		paramMap.put("p_application_of_def", p_application_of_def);
		
		paramMap.put("p_scode_nm", CommonUtil.isNull(paramMap.get("p_scode_nm")).replaceAll("&apos;","\'"));
		
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
				System.out.println(text);
				p_search_job_name_list.add(text);
			}
			int totalElements = p_search_job_name_list.size();
			paramMap.put("p_search_job_name_list", p_search_job_name_list);
		}

		DefJobBean defJobListCnt = emDefJobsService.dGetDefJobListCnt(paramMap);
		String defJobCnt = String.valueOf(defJobListCnt.getTotal_cnt());
		paramMap.put("pagingNum", "");
		
		List defJobList = emDefJobsService.dGetDefJobExcelList(paramMap);

		ModelAndView output = null;
		//output = new ModelAndView("ezjobs/m/em/defJobsExcel2");
		String p_flag = CommonUtil.isNull(paramMap.get("flag"));
		if(p_flag.equals("user_change")) {
			output = new ModelAndView("contents/userChangeExcel");
		}else {
			output = new ModelAndView("contents/defJobsExcel_doc");
		}
		output.addObject("defJobList", defJobList);
		output.addObject("smsDefaultList", 	smsDefaultList);
		output.addObject("mailDefaultList", mailDefaultList);
		return output;
	}
	
	public void ez003_txt18(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {
		
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));

		String conditionNums[] = new String[70];
		for (int i = 0; i < conditionNums.length; i++) {
			conditionNums[i] = (i + 1) + "";
		}
		paramMap.put("conditionNums", conditionNums);

		List defJobList = emDefJobsService.dGetDefJobExcelList(paramMap);
		
		Date dt = new Date();
		SimpleDateFormat sf = new SimpleDateFormat("yyyyMMddHHmm");
		String ymdh = sf.format(dt);
		
		String file_nm = "작업정보조회_"+CommonUtil.isNull(req.getSession().getAttribute("USER_CD"))+"_"+ymdh+".txt";
		String file_path = req.getRealPath(CommonUtil.getMessage("MENUAL_FILE.PATH"))+"/txt_down";
				
		File file = new File(file_path);
		if(!file.exists()){
			file.mkdirs();
		}
		
		String full_path = file_path+"/"+file_nm;
				
		FileUtil.defJobListWrite(full_path, defJobList);
		
		file = new File(full_path);
		res.setContentType("application/x-msdownload;");
		res.setHeader("Content-Type", "application/octet-stream; charset=UTF-8");
		res.setHeader("Content-Disposition", "attachment; filename="+java.net.URLEncoder.encode(file_nm,"UTF-8").replaceAll("\\+","%20"));
		
		OutputStream out = res.getOutputStream();
		FileInputStream fis = null;
		
		try{
			
			fis = new FileInputStream(file);
			FileCopyUtils.copy(fis, out);
			
		}finally{
			try{ if(fis != null) fis.close(); } catch(Exception e){}			
			try{ if(out != null) out.flush(); } catch(Exception e){}
			try{ if(out != null) out.close(); } catch(Exception e){}
			//try{ file.delete();	}catch(Exception e){}
		}		
		
	}

	@SuppressWarnings({ "unchecked", "unused" })
	public ModelAndView ez004(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {
		
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
						
		List<CommonBean> odateList = CommonUtil.getCtmOdateList();
		int odate_cnt = odateList.size();
		
		ModelAndView output = null;
		output = new ModelAndView("works/C01/main_contents/preJobMissMatchList");
		output.addObject("paramMap", paramMap);
		output.addObject("cm", CommonUtil.getComScodeList(paramMap));
		
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

	@SuppressWarnings({ "unchecked", "rawtypes" })
	public ModelAndView ez004_excel(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {
		
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));

		String active_net_name = CommonUtil.isNull(paramMap.get("active_net_name"));
		paramMap.put("active_net_names", active_net_name.split(","));

		List preJobMissMatchList = emPreJobMissMatchService.dGetPreJobMissMatchList(paramMap);

		ModelAndView output = null;
//		output = new ModelAndView("ezjobs/m/em/preJobMissMatchExcel");
		output = new ModelAndView("contents/preJobMissMatchExcel");
		output.addObject("preJobMissMatchList", preJobMissMatchList);

		return output;
	}
	
	@SuppressWarnings({ "unchecked", "unused" })
	public ModelAndView ez006_forecastOrder(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {
		
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		
//		String data_center_name = CommonUtil.isNull(paramMap.get("data_center_name"));
		
		Map<String, Object> rMap = new HashMap<String, Object>();
		
		EzRplnJobServiceImpl EzRplnJobServiceImpl = new EzRplnJobServiceImpl();
		rMap = EzRplnJobServiceImpl.ezRplnJobServiceImplCall(METHOD_GET);
		
		ModelAndView output = null;
		
		output = new ModelAndView("result/t_result");
		output.addObject("rMap",rMap);
		
    	return output;
	}

	@SuppressWarnings({ "unchecked", "unused" })
	public ModelAndView ez005(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {
		
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));		
		paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
		paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
		
		List<CommonBean> odateList = CommonUtil.getCtmOdateList();
		int odate_cnt = odateList.size();
		
		ModelAndView output = null;
		
		output = new ModelAndView("works/C05/main_contents/batchResultTotal");
		output.addObject("dataCenterList", CommonUtil.getDataCenterList());
		output.addObject("cm", CommonUtil.getComScodeList(paramMap));
		output.addObject("hostList", CommonUtil.getHostList());
		
		// 대분류 검색 화면
		paramMap.put("mcode_search", "Y");
		output.addObject("mcodeList", CommonUtil.getMcodeList(paramMap));

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

	@SuppressWarnings({ "unchecked", "rawtypes" })
	public ModelAndView ez005_excel(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {
		
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));

		List batchResultTotalList = emBatchResultTotalService.dGetBatchResultTotalList(paramMap);

		ModelAndView output = null;
		output = new ModelAndView("contents/batchResultTotalExcel");
		output.addObject("batchResultTotalList", batchResultTotalList);

		return output;
	}

	@SuppressWarnings({ "unchecked", "unused" })
	public ModelAndView ez006(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {
		
		String s_user_gb = CommonUtil.isNull(req.getSession().getAttribute("USER_GB"));
		
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		
		List<CommonBean> quartzList = commonService.dGetQuartzList(paramMap);
		List<CommonBean> odateList = CommonUtil.getOdateList();
		int odate_cnt = odateList.size();
		String odate = "";
		String ins_date = "";
		String latestDate = null;
		
		if(odate_cnt > 0){
			for(int i=0;i<odate_cnt;i++){
				CommonBean bean = odateList.get(0);		
				odate = bean.getView_odate();
			}
		}

		// Forecast는 마지막 ODATE 다음날을 Default로 셋팅.
		if(!odate.equals("") ) { 
			odate = DateUtil.add(odate, 2, +1).replaceAll("-", "");
		}
		
		for (int j = 0; j < quartzList.size(); j++) {
		    CommonBean bean = quartzList.get(j);

		    if (bean.getQuartz_name().indexOf("EZ_RPLNJOB") > -1) {
		        String currentDate = bean.getIns_date().substring(0, 10);
		        
		        if (latestDate == null || currentDate.compareTo(latestDate) > 0) {
		            latestDate = currentDate;
		        }
		    }
		}

		if (latestDate != null) {
		    ins_date = latestDate;
		}

		ModelAndView output = null;
		output = new ModelAndView("works/C02/main_contents/preDateBatchScheduleList");
		
		output.addObject("paramMap", 	paramMap);
		output.addObject("cm", 			CommonUtil.getComScodeList(paramMap));
		output.addObject("ODATE", 		odate);
		output.addObject("INS_DATE", 	ins_date);
		
		return output;
	}

	public ModelAndView ez006_excel(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {
		
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		paramMap.put("pagingNum", "");
		
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

		List preDateBatchScheduleList = emPreDateBatchScheduleService.dGetPreDateBatchScheduleList(paramMap);

		ModelAndView output = null;
		output = new ModelAndView("contents/preDateBatchScheduleExcel");
		output.addObject("preDateBatchScheduleList", preDateBatchScheduleList);

		return output;
	}
	
	// Forecast(일별오더목록) 결재요청.
	public ModelAndView ez006_w(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

		Map<String, Object> paramMap 	= CommonUtil.collectParameters(req);
		
		Map<String, Object> rMap 		= new HashMap<String, Object>();
		
		paramMap.put("s_user_cd", 	CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
		paramMap.put("s_user_gb", 	CommonUtil.isNull(req.getSession().getAttribute("USER_GB")));
		paramMap.put("s_user_ip", 	CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
		paramMap.put("SCHEMA", 		CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
				
		String strFlag 	= CommonUtil.isNull(paramMap.get("flag"));
		String strDocGb = "08";
		
		CommonUtil.emLogin(req);
		paramMap.put("userToken", CommonUtil.isNull(req.getSession().getAttribute("USER_TOKEN")));
		
		ModelAndView output = new ModelAndView("result/t_result");
		
		String mainDocCd = null;

		try {
			if ( "draft_admin".equals(strFlag) ) {
				rMap = worksApprovalDocService.dPrcDoc08Admin(paramMap);
			}else{
				
				rMap = worksApprovalDocService.dPrcDoc08(paramMap);
				
				// 승인 후 결재자에게 메일 전송
//				if ( (strFlag.equals("insert") || strFlag.equals("insert_post_approval")) && CommonUtil.isNull(rMap.get("r_code")).equals("1") ) {
//					String job_name = CommonUtil.isNull(paramMap.get("job_name"));
//					
//					int iSendResult = CommonUtil.sendApprovalSendMail(CommonUtil.isNull(rMap.get("r_doc_cd")), strDocGb, job_name);
//					System.out.println("메일 전송 결과 : " + iSendResult);
//				}
				
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
		output.addObject("rMap", rMap);

		return output;
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	public ModelAndView ez007(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {
		
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		
		// successCallback을 호출 하기 위해서 cookie 설정을 꼭 해줘야 한다.
		res.setHeader("Set-Cookie", "fileDownload=true; path=/");
		
		paramMap.put("s_user_cd", 	CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
		paramMap.put("s_user_ip", 	CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
		paramMap.put("SCHEMA", 		CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		
		List dataCenterList = CommonUtil.getDataCenterList();		
		List odateList = CommonUtil.getCtmOdateList();
		
		int odate_cnt = odateList.size();
				
		String active_net_names = "";
		for(int i=0; i<dataCenterList.size(); i++){
			CommonBean bean = (CommonBean)dataCenterList.get(i);
			if( "".equals(active_net_names) ) active_net_names = bean.getActive_net_name();
			else active_net_names += (","+bean.getActive_net_name());
		}
		paramMap.put("active_net_names",active_net_names.split(",") );
		
		ModelAndView output = null;
		output = new ModelAndView("works/C02/main_contents/jobLogList");
		output.addObject("paramMap", paramMap);
		output.addObject("cm", CommonUtil.getComScodeList(paramMap));
		output.addObject("hostList", CommonUtil.getHostList());
		
		// 대분류 검색 화면
		paramMap.put("mcode_search", "Y");
		output.addObject("mcodeList", CommonUtil.getMcodeList(paramMap));
		
		if(odate_cnt > 0){
			for(int i=0;i<odate_cnt;i++){
				CommonBean bean = (CommonBean) odateList.get(0);	
				String odate = DateUtil.getCurDateMinus(bean.getView_odate().replaceAll("/", ""), -1);
				output.addObject("ODATE", odate);
				//output.addObject("active_net_name", CommonUtil.getCtmActiveNetName(paramMap));
			}
		}else{
			output.addObject("ODATE", "");
			output.addObject("active_net_name", "");
		}
	
		return output;
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	public ModelAndView ez007_excel(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {
		
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));

		paramMap.put("active_net_name", 		CommonUtil.getCtmActiveNetName(paramMap));
		paramMap.put("p_sched_table", 			CommonUtil.isNull(paramMap.get("p_sched_table")).replaceAll("&apos;","\'"));
//		paramMap.put("p_application_of_def", 	CommonUtil.isNull(paramMap.get("p_application_of_def")).replaceAll("&apos;","\'"));
		paramMap.put("p_scode_nm", 				CommonUtil.isNull(paramMap.get("p_scode_nm")).replaceAll("&apos;","\'"));
		paramMap.put("s_user_cd", 				CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
		paramMap.put("s_user_gb", 				CommonUtil.isNull(req.getSession().getAttribute("USER_GB")));
		
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

		paramMap.put("pagingNum", "");
		
		List jobLogList = emJobLogService.dGetJobLogList(paramMap);

		ModelAndView output = null;
		output = new ModelAndView("contents/jobLogListExcel");
		output.addObject("jobLogList", jobLogList);

		return output;
	}

	public void ez007_txt(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {
		
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));

		String startRowNum	= CommonUtil.isNull(paramMap.get("startRowNum"));
		String pagingNum	= CommonUtil.isNull(paramMap.get("pagingNum"));
		
		paramMap.put("startRowNum", "0");
		paramMap.put("pagingNum", Integer.parseInt(startRowNum) + Integer.parseInt(pagingNum));
		
		List jobLogList = emJobLogService.dGetJobLogList(paramMap);

		Date dt = new Date();
		SimpleDateFormat sf = new SimpleDateFormat("yyyyMMddHHmm");
		String ymdh = sf.format(dt);
		
		String file_nm = "과거작업수행현황_"+CommonUtil.isNull(req.getSession().getAttribute("USER_CD"))+"_"+ymdh+".txt";
		String file_path = req.getRealPath(CommonUtil.getMessage("MENUAL_FILE.PATH"))+"/txt_down";
				
		File file = new File(file_path);
		if(!file.exists()){
			file.mkdirs();
		}
		
		String full_path = file_path+"/"+file_nm;
				
		FileUtil.jobLogListWrite(full_path, jobLogList, paramMap);
		
		file = new File(full_path);
		res.setContentType("application/x-msdownload;");
		res.setHeader("Content-Type", "application/octet-stream; charset=UTF-8");
		res.setHeader("Content-Disposition", "attachment; filename="+java.net.URLEncoder.encode(file_nm,"UTF-8").replaceAll("\\+","%20"));
		
		OutputStream out = res.getOutputStream();
		FileInputStream fis = null;
		
		try{
			
			fis = new FileInputStream(file);
			FileCopyUtils.copy(fis, out);
			
		}finally{
			try{ if(fis != null) fis.close(); } catch(Exception e){}			
			try{ if(out != null) out.flush(); } catch(Exception e){}
			try{ if(out != null) out.close(); } catch(Exception e){}
			//try{ file.delete();	}catch(Exception e){}
		}		
		
	}

	@SuppressWarnings("unchecked")
	public ModelAndView ez007_chart(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {
		
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		
		
		ArrayList<Map> data_center_items = new ArrayList();
		Map<String, Object> hm = new HashMap();
		hm.put("data_center_code", paramMap.get("data_center_code"));
		hm.put("data_center", paramMap.get("data_center"));
		hm.put("active_net_name", paramMap.get("active_net_name"));
		data_center_items.add(hm);
		paramMap.put("data_center_items", data_center_items);

		List totalJobStatusList = emActiveJobsService
				.getTotalJobStatusList(paramMap);

		ModelAndView output = null;
		output = new ModelAndView("ezjobs/m/state/jobLogListChart");
		output.addObject("totalJobStatusList", totalJobStatusList);

		return output;
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	public ModelAndView ez007_history(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {
		
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		
		paramMap.put("s_user_cd", 	CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
		paramMap.put("s_user_ip", 	CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
		paramMap.put("SCHEMA", 		CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		
		List dataCenterList = CommonUtil.getDataCenterList();		
		List odateList = CommonUtil.getCtmOdateList();
		
		int odate_cnt = odateList.size();
				
		String active_net_names = "";
		for(int i=0; i<dataCenterList.size(); i++){
			CommonBean bean = (CommonBean)dataCenterList.get(i);
			if( "".equals(active_net_names) ) active_net_names = bean.getActive_net_name();
			else active_net_names += (","+bean.getActive_net_name());
		}
		paramMap.put("active_net_names",active_net_names.split(",") );
		
		ModelAndView output = null;
		output = new ModelAndView("works/C02/main_contents/jobLogHistoryList");
		output.addObject("paramMap", paramMap);
		output.addObject("cm", CommonUtil.getComScodeList(paramMap));
		output.addObject("hostList", CommonUtil.getHostList());
		
		// 대분류 검색 화면
		paramMap.put("mcode_search", "Y");
		output.addObject("mcodeList", CommonUtil.getMcodeList(paramMap));
		
		if(odate_cnt > 0){
			for(int i=0;i<odate_cnt;i++){
				CommonBean bean = (CommonBean) odateList.get(0);	
				String odate = DateUtil.getCurDateMinus(bean.getView_odate().replaceAll("/", ""), -1);
				output.addObject("ODATE", odate);
				//output.addObject("active_net_name", CommonUtil.getCtmActiveNetName(paramMap));
			}
		}else{
			output.addObject("ODATE", "");
			output.addObject("active_net_name", "");
		}
	
		return output;
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public ModelAndView ez007_history_excel(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {
		
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));

		paramMap.put("active_net_name", 		CommonUtil.getCtmActiveNetName(paramMap));
		paramMap.put("p_sched_table", 			CommonUtil.isNull(paramMap.get("p_sched_table")).replaceAll("&apos;","\'"));
//		paramMap.put("p_application_of_def", 	CommonUtil.isNull(paramMap.get("p_application_of_def")).replaceAll("&apos;","\'"));
		paramMap.put("p_scode_nm", 				CommonUtil.isNull(paramMap.get("p_scode_nm")).replaceAll("&apos;","\'"));
		paramMap.put("s_user_cd", 				CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
		paramMap.put("s_user_gb", 				CommonUtil.isNull(req.getSession().getAttribute("USER_GB")));
		
		// 멀티 상태 선택
		String p_status = CommonUtil.isNull(paramMap.get("p_status"));
		ArrayList<String> statusList = new ArrayList<>(Arrays.asList(p_status.split("\\s*,\\s*")));
		paramMap.put("statusList", statusList);
		
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
		
		// 콤마 어플리케이션 입력
		String p_application_of_def_text = CommonUtil.isNull(paramMap.get("p_application_of_def_text"));
		if ( p_application_of_def_text.indexOf(",") > -1 ) {
			ArrayList<String> applicationList = new ArrayList<>(Arrays.asList(p_application_of_def_text.split("\\s*,\\s*")));
			paramMap.put("applicationList", applicationList);
		}
		
		// 콤마 그룹 입력
		String p_group_name_of_def_text = CommonUtil.isNull(paramMap.get("p_group_name_of_def_text"));
		if ( p_group_name_of_def_text.indexOf(",") > -1 ) {
			ArrayList<String> groupNameList = new ArrayList<>(Arrays.asList(p_group_name_of_def_text.split("\\s*,\\s*")));
			paramMap.put("groupNameList", groupNameList);
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
		
		JobLogBean jobLogHistoryListCnt = emJobLogService.dGetJobLogHistoryListCnt(paramMap);
		String jobLogCnt = String.valueOf(jobLogHistoryListCnt.getTotal_count());
		
		paramMap.put("startRowNum", "0");
		paramMap.put("pagingNum", jobLogCnt);
		
		List jobLogList = emJobLogService.dGetJobLogHistoryList(paramMap);

		ModelAndView output = null;
		output = new ModelAndView("contents/jobLogHistoryListExcel");
		output.addObject("jobLogList", jobLogList);

		return output;
	}
	
	public ModelAndView ez009(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException, Exception {
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));

		paramMap.put("searchType", "dataCenterList");
		List dataCenterList = commonService.dGetSearchItemList(paramMap);

		ModelAndView output = null;
//		output = new ModelAndView("ezjobs/m/em/nodeTimeChart");
		output = new ModelAndView("contents/nodeTimeChart");
		output.addObject("dataCenterList", dataCenterList);

		return output;
	}
	
	public ModelAndView ez009_xml(HttpServletRequest req,
			HttpServletResponse res) throws ServletException, IOException,
			Exception {

		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		
		List nodeList 			= emBatchResultTotalService.dGetNodeList(paramMap);
		List nodeTimeList 		= emBatchResultTotalService.dGetNodeTimeList(paramMap);
		
		CommonBean commonbean 	= emBatchResultTotalService.dGetDataCenterInfo(paramMap);

		ModelAndView output = null;
//		output = new ModelAndView("ezjobs/m/em/nodeTimeChartXml");
		output = new ModelAndView("contents/nodeTimeChartXml");
		
		output.addObject("nodeList", 		nodeList);
		output.addObject("nodeTimeList", 	nodeTimeList);
		output.addObject("commonbean", 		commonbean);

		return output;
	}

	@SuppressWarnings("unchecked")
	public ModelAndView ez009_excel(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {
		
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));

		List nodeTimeList = emBatchResultTotalService.dGetNodeTimeList(paramMap);

		ModelAndView output = null;
		output = new ModelAndView("ezjobs/m/em/nodeTimeListExcel");
		output.addObject("nodeTimeList", nodeTimeList);

		return output;
	}

	public ModelAndView ez010(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {
		
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));

		List emCommonList = emCtmInfoService.dGetEmCommonList(paramMap);
		//List emDbList = emCtmInfoService.dGetEmDbList(paramMap);
		List ccmPocessList = emCtmInfoService.dGetCcmPocessList(paramMap);
		List emProcessList = emCtmInfoService.dGetEmProcessList(paramMap);
		List emProcessDetailList = emCtmInfoService.dGetEmProcessDetailList(paramMap);
		// List agentList = emCtmInfoService.dGetAgentList(paramMap);
		
		List agentList = ctmInfoService.dGetAgentList(paramMap);

		ModelAndView output = null;
//		output = new ModelAndView("ezjobs/m/em/ctmInfo");
		output = new ModelAndView("works/C06/main_contents/ctmInfo");
		output.addObject("emCommonList", emCommonList);
		//output.addObject("emDbList", emDbList);
		output.addObject("ccmPocessList", ccmPocessList);
		output.addObject("emProcessList", emProcessList);
		output.addObject("emProcessDetailList", emProcessDetailList);
		output.addObject("agentList",agentList);

		return output;
	}

	@SuppressWarnings({ "unchecked" })
	public ModelAndView ez011(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {
		
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);	
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));

		String strMonthDate = CommonUtil.isNull(paramMap.get("month_date"), CommonUtil.getCurDate("YM").substring(2,6));		
		paramMap.put("month_date", strMonthDate);
		
		String data_center_code = CommonUtil.isNull(paramMap.get("data_center_code"));
		String active_net_name = CommonUtil.isNull(paramMap.get("active_net_name"));
		String application_of_def = CommonUtil.isNull(paramMap.get("application_of_def"));
		String group_name_of_def = CommonUtil.isNull(paramMap.get("group_name_of_def"));
		
		List<CommonBean> dataCenterList = CommonUtil.getDataCenterList();
		
		for(int i=0; i<dataCenterList.size(); i++){
			CommonBean bean = (CommonBean)dataCenterList.get(i);
			
			if(data_center_code.equals("")) paramMap.put("data_center_code", bean.getData_center_code());
			//paramMap.put("data_center", bean.getData_center());
			if(active_net_name.equals("")) paramMap.put("active_net_name", bean.getActive_net_name());
		}
				
		List<BatchResultTotalBean> monthBatchResultTotalList = emBatchResultTotalService.dGetMonthBatchResultTotalList(paramMap);	
				
		ModelAndView output = null;
		output = new ModelAndView("works/C05/main_contents/monthBatchResultTotal");
		output.addObject("monthBatchResultTotalList", monthBatchResultTotalList);
		output.addObject("dataCenterList",  dataCenterList);
		output.addObject("group_name_of_def", group_name_of_def);
		output.addObject("application_of_def", application_of_def);

		return output;
	}
	
	public ModelAndView ez041(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException, Exception {
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));

		String currentPage 	= CommonUtil.isNull(paramMap.get("currentPage"));
		String rowCnt 		= CommonUtil.isNull(paramMap.get("rowCnt"), CommonUtil.isNull(req.getSession().getAttribute("DEFAULT_PAGING")));
		int rowSize 		= 0;

		if ( !rowCnt.equals("") ) {
			rowSize = Integer.parseInt(rowCnt);
		} else {
			rowSize = Integer.parseInt(CommonUtil.getMessage("PAGING.ROWSIZE.BASIC"));
		}	

		int pageSize = Integer.parseInt(CommonUtil.getMessage("PAGING.PAGESIZE.BASIC"));

		CommonBean bean = emJobLogService.dGetJobOpListCnt(paramMap);
		Paging paging = new Paging(bean.getTotal_count(), rowSize, pageSize, currentPage);

		paramMap.put("startRowNum", paging.getStartRowNum());
		paramMap.put("endRowNum", paging.getEndRowNum());
		List jobOpList = emJobLogService.dGetJobOpList(paramMap);
		
		paramMap.clear();
		
		paramMap.put("searchType", "odateList");
		List odateList 		= commonService.dGetSearchItemList(paramMap);

		ModelAndView output = null;
		output = new ModelAndView("ezjobs/m/em/jobOpList");
		output.addObject("Paging", 		paging);
		output.addObject("totalCount", 	paging.getTotalRowSize());
		output.addObject("rowSize", 	rowSize);
		output.addObject("jobOpList", 	jobOpList);
		output.addObject("odateList", 	odateList);

		return output;
	}

	public ModelAndView ez041_excel(HttpServletRequest req,
			HttpServletResponse res) throws ServletException, IOException,
			Exception {
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));

		List jobOpList = emJobLogService.dGetJobOpList(paramMap);

		ModelAndView output = null;
		output = new ModelAndView("ezjobs/m/em/jobOpListExcel");
		output.addObject("jobOpList", jobOpList);

		return output;
	}
	
	public ModelAndView ez041_report(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {
		
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		System.out.println("paramMap : " + paramMap);
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		String strDataCenter = CommonUtil.isNull(paramMap.get("data_center"));
		if ( !strDataCenter.equals("") ) {
			
			// C-M 정보 가져오기
			paramMap.put("data_center", strDataCenter);
			CommonBean commonbean 	= emBatchResultTotalService.dGetDataCenterInfoAjob(paramMap);
							
			if ( commonbean != null ) {
				paramMap.put("data_center_code", CommonUtil.isNull(commonbean.getData_center_code()));
				paramMap.put("active_net_name", 	CommonUtil.isNull(commonbean.getActive_net_name()));
			}
		}
		
		JobLogBean jobOpReportInfo 	= emJobLogService.dGetJobOpReportInfo(paramMap);
		List jobOpStatsReportList 	= emJobLogService.dGetJobOpStatsReportList(paramMap);
		
		// 비정기성 작업
		paramMap.put("job_gubun", "");
		paramMap.put("job_gubun2", "");
		List jobOpReportList = emJobLogService.dGetJobOpReportList(paramMap);
		
		// 정기성 작업
		paramMap.put("job_gubun", "SYSTEM");
		paramMap.put("job_gubun2", "");
		List jobOpReportList2 = emJobLogService.dGetJobOpReportList(paramMap);
		
		// 월초 작업
		paramMap.put("job_gubun", "BEGIN");
		paramMap.put("job_gubun2", "EDW_BEGIN_END");
		List jobOpReportList3 = emJobLogService.dGetJobOpReportList(paramMap);
		
		// 월말 작업
		paramMap.put("job_gubun", "END");
		paramMap.put("job_gubun2", "EDW_BEGIN_END");
		List jobOpReportList4 = emJobLogService.dGetJobOpReportList(paramMap);
		
		
		
		// EDW 비정기성 작업
		paramMap.put("job_gubun", "");
		paramMap.put("job_gubun2", "EDW");
		List jobOpReportEdwList = emJobLogService.dGetJobOpReportList(paramMap);
		
		// EDW 정기성 작업
		paramMap.put("job_gubun", "SYSTEM");
		paramMap.put("job_gubun2", "EDW");
		List jobOpReportEdwList2 = emJobLogService.dGetJobOpReportList(paramMap);
		
		// EDW 월초 작업
		paramMap.put("job_gubun", "SYSTEM_BEGIN_END");
		paramMap.put("job_gubun2", "BEGIN");
		List jobOpReportEdwList3 = emJobLogService.dGetJobOpReportList(paramMap);
		
		// EDW 월말 작업
		paramMap.put("job_gubun", "SYSTEM_BEGIN_END");
		paramMap.put("job_gubun2", "END");
		List jobOpReportEdwList4 = emJobLogService.dGetJobOpReportList(paramMap);
		
		
		
		// IFRS 비정기성 작업
		paramMap.put("job_gubun", "");
		paramMap.put("job_gubun2", "IFRS");
		List jobOpReportIfrsList = emJobLogService.dGetJobOpReportList(paramMap);
		
		// IFRS 정기성 작업
		paramMap.put("job_gubun", "SYSTEM");
		paramMap.put("job_gubun2", "IFRS");
		List jobOpReportIfrsList2 = emJobLogService.dGetJobOpReportList(paramMap);
		
		// IFRS 월초 작업
		paramMap.put("job_gubun", "SYSTEM_BEGIN_END");
		paramMap.put("job_gubun2", "BEGIN_IFRS");
		List jobOpReportIfrsList3 = emJobLogService.dGetJobOpReportList(paramMap);
		
		// IFRS 월말 작업
		paramMap.put("job_gubun", "SYSTEM_BEGIN_END");
		paramMap.put("job_gubun2", "END_IFRS");
		List jobOpReportIfrsList4 = emJobLogService.dGetJobOpReportList(paramMap);
		
		
		
		// AIS 비정기성 작업
		paramMap.put("job_gubun", "");
		paramMap.put("job_gubun2", "AIS");
		List jobOpReportAisList = emJobLogService.dGetJobOpReportList(paramMap);
		
		// AIS 정기성 작업
		paramMap.put("job_gubun", "SYSTEM");
		paramMap.put("job_gubun2", "AIS");
		List jobOpReportAisList2 = emJobLogService.dGetJobOpReportList(paramMap);
		
		// AIS 월초 작업
		paramMap.put("job_gubun", "SYSTEM_BEGIN_END");
		paramMap.put("job_gubun2", "BEGIN_AIS");
		List jobOpReportAisList3 = emJobLogService.dGetJobOpReportList(paramMap);
		
		// AIS 월말 작업
		paramMap.put("job_gubun", "SYSTEM_BEGIN_END");
		paramMap.put("job_gubun2", "END_AIS");
		List jobOpReportAisList4 = emJobLogService.dGetJobOpReportList(paramMap);
		
		
		
		
		// ALM 비정기성 작업
		paramMap.put("job_gubun", "");
		paramMap.put("job_gubun2", "ALM");
		List jobOpReportAlmList = emJobLogService.dGetJobOpReportList(paramMap);
		
		// ALM 정기성 작업
		paramMap.put("job_gubun", "SYSTEM");
		paramMap.put("job_gubun2", "ALM");
		List jobOpReportAlmList2 = emJobLogService.dGetJobOpReportList(paramMap);
		
		// ALM 월초 작업
		paramMap.put("job_gubun", "SYSTEM_BEGIN_END");
		paramMap.put("job_gubun2", "BEGIN_ALM");
		List jobOpReportAlmList3 = emJobLogService.dGetJobOpReportList(paramMap);
		
		// ALM 월말 작업
		paramMap.put("job_gubun", "SYSTEM_BEGIN_END");
		paramMap.put("job_gubun2", "END_ALM");
		List jobOpReportAlmList4 = emJobLogService.dGetJobOpReportList(paramMap);
		
		
		
		// NEW_RDM 비정기성 작업
		paramMap.put("job_gubun", "");
		paramMap.put("job_gubun2", "NEW_RDM");
		List jobOpReportNewRdmList = emJobLogService.dGetJobOpReportList(paramMap);
		
		// NEW_RDM 정기성 작업
		paramMap.put("job_gubun", "SYSTEM");
		paramMap.put("job_gubun2", "NEW_RDM");
		List jobOpReportNewRdmList2 = emJobLogService.dGetJobOpReportList(paramMap);
		
		// NEW_RDM 월초 작업
		paramMap.put("job_gubun", "SYSTEM_BEGIN_END");
		paramMap.put("job_gubun2", "BEGIN_NEW_RDM");
		List jobOpReportNewRdmList3 = emJobLogService.dGetJobOpReportList(paramMap);
		
		// NEW_RDM 월말 작업
		paramMap.put("job_gubun", "SYSTEM_BEGIN_END");
		paramMap.put("job_gubun2", "END_NEW_RDM");
		List jobOpReportNewRdmList4 = emJobLogService.dGetJobOpReportList(paramMap);
		
		
		
		// RBA 비정기성 작업
		paramMap.put("job_gubun", "");
		paramMap.put("job_gubun2", "RBA");
		List jobOpReportRbaList = emJobLogService.dGetJobOpReportList(paramMap);
		
		// RBA 정기성 작업
		paramMap.put("job_gubun", "SYSTEM");
		paramMap.put("job_gubun2", "RBA");
		List jobOpReportRbaList2 = emJobLogService.dGetJobOpReportList(paramMap);
		
		// RBA 월초 작업
		paramMap.put("job_gubun", "SYSTEM_BEGIN_END");
		paramMap.put("job_gubun2", "BEGIN_RBA");
		List jobOpReportRbaList3 = emJobLogService.dGetJobOpReportList(paramMap);
		
		// RBA 월말 작업
		paramMap.put("job_gubun", "SYSTEM_BEGIN_END");
		paramMap.put("job_gubun2", "END_RBA");
		List jobOpReportRbaList4 = emJobLogService.dGetJobOpReportList(paramMap);
		
		
		
		// CRS 비정기성 작업
		paramMap.put("job_gubun", "");
		paramMap.put("job_gubun2", "CRS");
		List jobOpReportCrsList = emJobLogService.dGetJobOpReportList(paramMap);
		
		// CRS 정기성 작업
		paramMap.put("job_gubun", "SYSTEM");
		paramMap.put("job_gubun2", "CRS");
		List jobOpReportCrsList2 = emJobLogService.dGetJobOpReportList(paramMap);
		
		// CRS 월초 작업
		paramMap.put("job_gubun", "SYSTEM_BEGIN_END");
		paramMap.put("job_gubun2", "BEGIN_CRS");
		List jobOpReportCrsList3 = emJobLogService.dGetJobOpReportList(paramMap);
		
		// CRS 월말 작업
		paramMap.put("job_gubun", "SYSTEM_BEGIN_END");
		paramMap.put("job_gubun2", "END_CRS");
		List jobOpReportCrsList4 = emJobLogService.dGetJobOpReportList(paramMap);
		
		

		ModelAndView output = null;
		output = new ModelAndView("contents/jobOpListReport");
		
		output.addObject("jobOpReportInfo", 		jobOpReportInfo);
		output.addObject("jobOpStatsReportList", 	jobOpStatsReportList);
		output.addObject("jobOpReportList", 		jobOpReportList);
		output.addObject("jobOpReportList2", 		jobOpReportList2);
		output.addObject("jobOpReportList3", 		jobOpReportList3);
		output.addObject("jobOpReportList4", 		jobOpReportList4);
		output.addObject("jobOpReportEdwList", 		jobOpReportEdwList);
		output.addObject("jobOpReportEdwList2", 	jobOpReportEdwList2);
		output.addObject("jobOpReportEdwList3", 	jobOpReportEdwList3);
		output.addObject("jobOpReportEdwList4", 	jobOpReportEdwList4);
		output.addObject("jobOpReportIfrsList", 	jobOpReportIfrsList);
		output.addObject("jobOpReportIfrsList2", 	jobOpReportIfrsList2);
		output.addObject("jobOpReportIfrsList3", 	jobOpReportIfrsList3);
		output.addObject("jobOpReportIfrsList4", 	jobOpReportIfrsList4);
		output.addObject("jobOpReportAisList", 		jobOpReportAisList);
		output.addObject("jobOpReportAisList2", 	jobOpReportAisList2);
		output.addObject("jobOpReportAisList3", 	jobOpReportAisList3);
		output.addObject("jobOpReportAisList4", 	jobOpReportAisList4);
		output.addObject("jobOpReportAlmList", 		jobOpReportAlmList);
		output.addObject("jobOpReportAlmList2", 	jobOpReportAlmList2);
		output.addObject("jobOpReportAlmList3", 	jobOpReportAlmList3);
		output.addObject("jobOpReportAlmList4", 	jobOpReportAlmList4);
		output.addObject("jobOpReportNewRdmList", 	jobOpReportNewRdmList);
		output.addObject("jobOpReportNewRdmList2", 	jobOpReportNewRdmList2);
		output.addObject("jobOpReportNewRdmList3", 	jobOpReportNewRdmList3);
		output.addObject("jobOpReportNewRdmList4", 	jobOpReportNewRdmList4);
		output.addObject("jobOpReportRbaList", 	jobOpReportRbaList);
		output.addObject("jobOpReportRbaList2", 	jobOpReportRbaList2);
		output.addObject("jobOpReportRbaList3", 	jobOpReportRbaList3);
		output.addObject("jobOpReportRbaList4", 	jobOpReportRbaList4);
		output.addObject("jobOpReportCrsList", 	jobOpReportCrsList);
		output.addObject("jobOpReportCrsList2", 	jobOpReportCrsList2);
		output.addObject("jobOpReportCrsList3", 	jobOpReportCrsList3);
		output.addObject("jobOpReportCrsList4", 	jobOpReportCrsList4);

		return output;
	}

	public ModelAndView ez015_history(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {
		
		Map<String, Object> paramMap = CommonUtil.collectParametersK2E(req);

		CommonBean commonBean = emJobLogService.dGetHistoryDayCnt(paramMap);

		ModelAndView output = null;
		output = new ModelAndView("ezjobs/t/works/ajaxReturn2");
		output.addObject("commonBean", commonBean);

		return output;
	}
	
	public ModelAndView ez016(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {
		
		Map<String, Object> paramMap = CommonUtil.collectParametersK2E(req);

		String currentPage = CommonUtil.isNull(paramMap.get("currentPage"));

		int rowSize = Integer.parseInt(CommonUtil
				.getMessage("PAGING.ROWSIZE.BASIC"));
		int pageSize = Integer.parseInt(CommonUtil
				.getMessage("PAGING.PAGESIZE.BASIC"));

		CommonBean bean = emJobLogService.dGetTimeOverJobLogListCnt(paramMap);
		Paging paging = new Paging(bean.getTotal_count(), rowSize, pageSize, currentPage);

		paramMap.put("startRowNum", paging.getStartRowNum());
		paramMap.put("endRowNum", paging.getEndRowNum());
		List jobLogList = emJobLogService.dGetTimeOverJobLogList(paramMap);

		ModelAndView output = null;
		output = new ModelAndView("ezjobs/m/em/timeOverJobLogList");
		output.addObject("Paging", paging);
		output.addObject("totalCount", paging.getTotalRowSize());
		output.addObject("jobLogList", jobLogList);

		return output;
	}

	@SuppressWarnings({ "unchecked", "rawtypes", "unused" })
	public ModelAndView ez019(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {
		
		Map<String, Object> paramMap = CommonUtil.collectParametersK2E(req);
		String s_user_gb = CommonUtil.isNull(req.getSession().getAttribute("USER_GB"));
						
		List odateList = CommonUtil.getCtmOdateList();
		int odate_cnt = odateList.size();
		
		ModelAndView output = null;
		output = new ModelAndView("works/C02/main_contents/jobCondList");
		output.addObject("paramMap", paramMap);
		output.addObject("cm", CommonUtil.getComScodeList(paramMap));
		
		if(odate_cnt > 0){
			for(int i=0;i<odate_cnt;i++){
				CommonBean bean = (CommonBean) odateList.get(0);
				output.addObject("ODATE", bean.getView_odate().replaceAll("/", "").substring(4, 8));
			}
		}else{
			output.addObject("ODATE", "");
		}
		
		return output;
	}

	@SuppressWarnings("unchecked")
	public ModelAndView ez019_excel(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {
		
		Map<String, Object> paramMap = CommonUtil.collectParametersK2E(req);
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		paramMap.put("CTM_SCHEMA", CommonUtil.getMessage("DB.CTMSVR.SCHEMA"));
		List<CtmInfoBean> jobCondList = ctmInfoService.dGetJobCondList(paramMap);
		
		ModelAndView output = null;
		output = new ModelAndView("contents/jobCondListExcel");
		output.addObject("jobCondList", jobCondList);
		
		return output;
	}
	
	@SuppressWarnings("unchecked")
	public ModelAndView ez019_history_excel(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {
		
		Map<String, Object> paramMap = CommonUtil.collectParametersK2E(req);
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		
		List<CtmInfoBean> jobCondHistoryList = emCtmInfoService.dGetJobCondHistoryList(paramMap);
		
		ModelAndView output = null;
		output = new ModelAndView("contents/jobCondHistoryListExcel");
		output.addObject("jobCondHistoryList", jobCondHistoryList);
		
		return output;
	}
	
	public ModelAndView ez019_popup(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {
		
		Map<String, Object> paramMap = CommonUtil.collectParametersK2E(req);

		List<DefJobBean> inCondJobList = emDefJobsService.dGetInCondJobList(paramMap);
		
		ModelAndView output = null;
//		output = new ModelAndView("ezjobs/m/popup/inCondJobList");
		output = new ModelAndView("contents/popup/inCondJobList");
		output.addObject("inCondJobList", inCondJobList);
		
		return output;
	}
	
	public ModelAndView ez019_p(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {
		
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		int rtn = 0;
		Map<String, Object> rMap = new HashMap<String, Object>();
		
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
		paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
		
		rMap = worksApprovalDocService.deleteCondition(paramMap);
		ModelAndView output = null;
		
		rMap.put("c"           , paramMap.get("c"));
		output = new ModelAndView("result/t_result");
		output.addObject("rMap",rMap);
		
    	return output;
	}
	
	public ModelAndView ez020(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {
		
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		
		String currentPage 	= CommonUtil.isNull(paramMap.get("currentPage"));
		String rowCnt 		= CommonUtil.isNull(paramMap.get("rowCnt"), CommonUtil.isNull(req.getSession().getAttribute("DEFAULT_PAGING")));
		int rowSize 		= 0;
		
		if ( !rowCnt.equals("") ) {
			rowSize = Integer.parseInt(rowCnt);
		} else {
			rowSize = Integer.parseInt(CommonUtil.getMessage("PAGING.ROWSIZE.BASIC"));
		}
		
		int pageSize = Integer.parseInt(CommonUtil.getMessage("PAGING.PAGESIZE.BASIC"));
		
		CommonBean bean = emJobLogService.dGetJobGroupListCnt(paramMap);
		
    	Paging paging 	= new Paging(bean.getTotal_count(), rowSize, pageSize, currentPage);
    	
    	paramMap.put("startRowNum", paging.getStartRowNum());
    	paramMap.put("endRowNum", 	paging.getEndRowNum());
    	
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
    	
		List jobGroupList = emJobLogService.dGetJobGroupList(paramMap);
		
		ModelAndView output = null;
		output = new ModelAndView("ezjobs/m/em/jobGroupList");
		output.addObject("Paging", 			paging);
		output.addObject("totalCount", 		paging.getTotalRowSize());
		output.addObject("rowSize", 		rowSize);
		output.addObject("jobGroupList",	jobGroupList);

		return output;
	}
	
	public ModelAndView ez021(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {
		
		ModelAndView output = new ModelAndView("ezjobs/m/em/delayBatch");
		
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));

		String strDataCenter 	= CommonUtil.isNull(paramMap.get("data_center"));
		String strOrderId	 	= CommonUtil.isNull(paramMap.get("order_id"));
		String strRerunCount 	= CommonUtil.isNull(paramMap.get("rerun_count"));
		String strEndDate	 	= CommonUtil.isNull(paramMap.get("end_date"));
		String strMemName	 	= CommonUtil.isNull(paramMap.get("memname"));
		String strNodeId	 	= CommonUtil.isNull(paramMap.get("node_id"));
		String strJobName	 	= CommonUtil.isNull(paramMap.get("job_name"));
		
		String strSysoutContent = "";

		// Host 정보 가져오는 서비스.	
		paramMap.put("data_center"	, strDataCenter);
		paramMap.put("host"			, strNodeId);
		paramMap.put("server_gubun"	, "S");
		
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
		
		strRemoteFilePath 	= "/";
		String strFileName	= "websm.script";

		if(!"".equals(strHost)){
			
			String cmd = "cat " + strRemoteFilePath + strFileName;
			
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
		
		output.addObject("sysout", strSysoutContent);

		return output;
	}
	
	public ModelAndView ez022(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {
		
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		
		String strTableId 	= "0";
		String strJobId 	= "0";
		
		// 작업 정보 가져오기.
		DefJobBean defJobBean = emDefJobsService.dGetJobDefInfo(paramMap);
		
		if ( defJobBean != null ) {
			strTableId 	= CommonUtil.isNull(defJobBean.getTable_id());
			strJobId 	= CommonUtil.isNull(defJobBean.getJob_id());
		}
		
		paramMap.put("table_id", 	strTableId);
		paramMap.put("job_id", 		strJobId);
		
		// 선행작업 정보 가져오기.
		List defInCondJobList = popupDefJobDetailService.dGetDefInCondJobList(paramMap);

		// 후행작업 정보 가져오기.
		List defOutCondJobList = popupDefJobDetailService.dGetDefOutCondJobList(paramMap);
		
		ModelAndView output = null;
		output = new ModelAndView("ezjobs/m/em/inAndOutCondList");
		
		output.addObject("defInCondJobList",	defInCondJobList);
		output.addObject("defOutCondJobList",	defOutCondJobList);
		

		return output;
	}

	/**
	 * 연관테이블 예측정보 
	 * @param req
	 * @param res
	 * @return
	 * @throws ServletException
	 * @throws IOException
	 * @throws Exception
	 */
	public ModelAndView ez043(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {
		
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));

		List forecastRelTableList = emPreDateBatchScheduleService.dGetRelForecastTableList(paramMap);
		ModelAndView output = null;
		output = new ModelAndView("contents/forecastRelTableList");
		output.addObject("forecastRelTableList", 	forecastRelTableList);

		return output;
	}
	
	@SuppressWarnings({ "unchecked" })
	public ModelAndView summaryDetail(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {
		
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		
		ModelAndView output = null;
		output = new ModelAndView("contents/popup/summaryDetail");
		output.addObject("paramMap", paramMap);
		
		return output;
	}
	//보고_일별수행
	@SuppressWarnings({ "unchecked", "unused" })
	public ModelAndView ez044(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {
		
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		paramMap.put("mcode_gubun", "03");		//대분류,소분류 검색
		paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
		paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
		
		List<CommonBean> odateList = CommonUtil.getCtmOdateList();
		int odate_cnt = odateList.size();
		
		ModelAndView output = null;
		
		output = new ModelAndView("works/C05/main_contents/batchResultTotal2");
		
		output.addObject("dataCenterList", 	CommonUtil.getDataCenterList());
		output.addObject("cm", 				CommonUtil.getComScodeList(paramMap));
		output.addObject("mcodeList", 		CommonUtil.getMcodeList(paramMap));

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

	@SuppressWarnings({ "unchecked", "rawtypes" })
	public ModelAndView ez044_excel(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {
		
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		
		String strDataCenter = CommonUtil.isNull(paramMap.get("data_center"));
		
//		System.out.println("p_application_of_def : " + CommonUtil.isNull(paramMap.get("p_application_of_def")));

//		String p_application_of_def =  CommonUtil.isNull(paramMap.get("p_application_of_def")).replaceAll("&apos;","\'");
//		paramMap.put("p_application_of_def", p_application_of_def);
		
//		System.out.println("p_application_of_def : " + p_application_of_def);
		
		paramMap.put("p_sched_table", CommonUtil.isNull(paramMap.get("p_sched_table")).replaceAll("&apos;","\'"));
		paramMap.put("s_user_cd", 		CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
		paramMap.put("s_user_gb", 		CommonUtil.isNull(req.getSession().getAttribute("USER_GB")));
		
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

		if ( !strDataCenter.equals("") ) {
			
			// C-M 정보 가져오기
			paramMap.put("data_center", strDataCenter);
			CommonBean commonbean 	= emBatchResultTotalService.dGetDataCenterInfoAjob(paramMap);
							
			if ( commonbean != null ) {
				paramMap.put("data_center_code", CommonUtil.isNull(commonbean.getData_center_code()));
				paramMap.put("active_net_name", 	CommonUtil.isNull(commonbean.getActive_net_name()));
			}
		}

		List batchResultTotalList = emBatchResultTotalService.dGetBatchResultTotalList2(paramMap);

		ModelAndView output = null;
		output = new ModelAndView("contents/batchResultTotalExcel2");
		output.addObject("batchResultTotalList", batchResultTotalList);

		return output;
	}
	
	//보고_운영업무보고
	@SuppressWarnings({ "unchecked", "unused" })
	public ModelAndView ez045(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {
		
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		paramMap.put("mcode_gubun", "03");		//대분류,소분류 검색
		paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
		paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
		
		System.out.println("p_application_of_def : " + paramMap.get("p_application_of_def"));
		
		
		List<CommonBean> odateList = CommonUtil.getCtmOdateList();
		int odate_cnt = odateList.size();
		
		ModelAndView output = null;
		
		output = new ModelAndView("works/C05/main_contents/batchResultTotal3");
		
		output.addObject("dataCenterList", 	CommonUtil.getDataCenterList());
		output.addObject("cm", 				CommonUtil.getComScodeList(paramMap));
		output.addObject("mcodeList", 		CommonUtil.getMcodeList(paramMap));
		
		if(odate_cnt > 0){
			for(int i=0;i<odate_cnt;i++){
				CommonBean bean = (CommonBean) odateList.get(0);		
				output.addObject("ODATE", DateUtil.getCurDateMinus(bean.getView_odate().replaceAll("/", ""), -1));
			}
		}else{
			output.addObject("ODATE", "");
		}

		return output;
	}

	public ModelAndView ez013(HttpServletRequest req, HttpServletResponse res)throws ServletException, IOException, Exception {
		Map<String, Object> paramMap = CommonUtil.collectParametersK2E(req);
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		
		List odateList = CommonUtil.getCtmOdateList();
		int odate_cnt = odateList.size();
		
		ModelAndView output = null;
		output = new ModelAndView("works/C08/main_contents/resourceTimeChart");

		output.addObject("cm", CommonUtil.getComScodeList(paramMap));
		if(odate_cnt > 0){
			for(int i=0;i<odate_cnt;i++){
				CommonBean bean = (CommonBean) odateList.get(0);	
				String odate = bean.getView_odate().replaceAll("/", "");
				output.addObject("ODATE", odate);
				//output.addObject("active_net_name", CommonUtil.getCtmActiveNetName(paramMap));
			}
		}else{
			output.addObject("ODATE", "");
			output.addObject("active_net_name", "");
		}
		
		return output;
	}
	
	public ModelAndView ez013_iFrame(HttpServletRequest req, HttpServletResponse res)throws ServletException, IOException, Exception {
		Map<String, Object> paramMap = CommonUtil.collectParametersK2E(req);
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		paramMap.put("searchType", "dataCenterList");
		List dataCenterList = commonService.dGetSearchItemList(paramMap);
		List resourceNMList = emBatchResultTotalService.dGetResourceNMList(paramMap);
		List resourceHHList = emBatchResultTotalService.dGetResourceHHList(paramMap);
		List resourceTimeList = emBatchResultTotalService.dGetResourceTimeList(paramMap);
		ModelAndView output = null;
		output = new ModelAndView("works/C08/main_contents/resourceTimeChartIframe");
		output.addObject("dataCenterList", dataCenterList);
		output.addObject("resourceNMList", resourceNMList);
		output.addObject("resourceHHList", resourceHHList);
		output.addObject("resourceTimeList", resourceTimeList);

		return output;
	}
	
	public ModelAndView ez013_xml(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

		Map<String, Object> paramMap = CommonUtil.collectParametersK2E(req);
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		System.out.println("paramMap : " + paramMap);
		List resourceNMList = emBatchResultTotalService.dGetResourceNMList(paramMap);
		List resourceHHList = emBatchResultTotalService.dGetResourceHHList(paramMap);
		
		List resourceTimeList = emBatchResultTotalService.dGetResourceTimeList(paramMap);

		ModelAndView output = null;
		output = new ModelAndView("works/C08/main_contents/resourceTimeChartXml");
		
		output.addObject("resourceNMList", resourceNMList);
		output.addObject("resourceHHList", resourceHHList);
		output.addObject("resourceTimeList", resourceTimeList);

		return output;
	}
	
	//보고_마감배치보고서
	@SuppressWarnings({ "unchecked", "unused" })
	public ModelAndView ez046(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {
		
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		paramMap.put("mcode_gubun", "03");		//대분류,소분류 검색
		paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
		paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
		
		List<CommonBean> odateList = CommonUtil.getCtmOdateList();
		int odate_cnt = odateList.size();
		
		ModelAndView output = null;
		
		output = new ModelAndView("works/C05/main_contents/batchReport");
		
		output.addObject("dataCenterList", 	CommonUtil.getDataCenterList());
		output.addObject("cm", 				CommonUtil.getComScodeList(paramMap));
		output.addObject("mcodeList", 		CommonUtil.getMcodeList(paramMap));

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
	
	//보고_마감배치보고서_엑셀다운
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public ModelAndView ez046_excel(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {
		
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		
		String strDataCenter = CommonUtil.isNull(paramMap.get("data_center"));
		
		paramMap.put("p_sched_table", CommonUtil.isNull(paramMap.get("p_sched_table")).replaceAll("&apos;","\'"));
		paramMap.put("s_user_cd", 		CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
		paramMap.put("s_user_gb", 		CommonUtil.isNull(req.getSession().getAttribute("USER_GB")));
		
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

		if ( !strDataCenter.equals("") ) {
			
			// C-M 정보 가져오기
			paramMap.put("data_center", strDataCenter);
			CommonBean commonbean 	= emBatchResultTotalService.dGetDataCenterInfoAjob(paramMap);
							
			if ( commonbean != null ) {
				paramMap.put("data_center_code", CommonUtil.isNull(commonbean.getData_center_code()));
				paramMap.put("active_net_name", 	CommonUtil.isNull(commonbean.getActive_net_name()));
			}
		}

		List batchReport = emBatchResultTotalService.dGetBatchReport(paramMap);

		ModelAndView output = null;
		output = new ModelAndView("contents/batchReportExcel");
		output.addObject("batchReport", batchReport);

		return output;
	}
}