package com.ghayoun.ezjobs.t.controller;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpStatus;
import org.apache.commons.httpclient.methods.PostMethod;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.ghayoun.ezjobs.a.service.EmAlertService;
import com.ghayoun.ezjobs.comm.domain.BoardBean;
import com.ghayoun.ezjobs.comm.domain.CommonBean;
import com.ghayoun.ezjobs.comm.service.CommonService;
import com.ghayoun.ezjobs.common.util.BaseController;
import com.ghayoun.ezjobs.common.util.CommonUtil;
import com.ghayoun.ezjobs.common.util.DateUtil;
import com.ghayoun.ezjobs.common.util.DefaultServiceException;
import com.ghayoun.ezjobs.common.util.ExcelFormat;
import com.ghayoun.ezjobs.common.util.ExcelUtil;
import com.ghayoun.ezjobs.common.util.FileUtil;
import com.ghayoun.ezjobs.common.util.JsUtil;
import com.ghayoun.ezjobs.common.util.Paging;
import com.ghayoun.ezjobs.common.util.SeedUtil;
import com.ghayoun.ezjobs.common.util.Ssh2Util;
import com.ghayoun.ezjobs.common.util.SshUtil;
import com.ghayoun.ezjobs.common.util.TelnetUtil;
import com.ghayoun.ezjobs.m.domain.DocApprovalTotalBean;
import com.ghayoun.ezjobs.t.domain.CompanyBean;
import com.ghayoun.ezjobs.t.domain.DefJobBean;
import com.ghayoun.ezjobs.t.domain.Doc01Bean;
import com.ghayoun.ezjobs.t.domain.Doc02Bean;
import com.ghayoun.ezjobs.t.domain.Doc03Bean;
import com.ghayoun.ezjobs.t.domain.Doc05Bean;
import com.ghayoun.ezjobs.t.domain.Doc07Bean;
import com.ghayoun.ezjobs.t.domain.Doc09Bean;
import com.ghayoun.ezjobs.t.domain.DocInfoBean;
import com.ghayoun.ezjobs.t.domain.JobGroupBean;
import com.ghayoun.ezjobs.t.domain.JobMapperBean;
import com.ghayoun.ezjobs.t.domain.TagsBean;
import com.ghayoun.ezjobs.t.domain.UserBean;
import com.ghayoun.ezjobs.t.service.PopupDefJobService;
import com.ghayoun.ezjobs.t.service.WorksApprovalDocService;
import com.ghayoun.ezjobs.t.service.WorksApprovalLineService;
import com.ghayoun.ezjobs.t.service.WorksCompanyService;
import com.ghayoun.ezjobs.t.service.WorksUserService;

import net.sf.json.JSONObject;

@Controller
public class ExternalCallController extends BaseController {

	protected final Log logger = LogFactory.getLog(getClass());
	
	private CommonService commonService; 
	private WorksCompanyService worksCompanyService;
	private WorksUserService worksUserService;
	private WorksApprovalLineService worksApprovalLineService;
	private WorksApprovalDocService worksApprovalDocService;
	private PopupDefJobService popupDefJobService;
	private EmAlertService emAlertService;

	public void setCommonService(CommonService commonService) {
		this.commonService = commonService;
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
	public void setPopupDefJobService(PopupDefJobService popupDefJobService) {
		this.popupDefJobService = popupDefJobService;
	}	
	public void setEmAlertService(EmAlertService emAlertService) {
		this.emAlertService = emAlertService;
	}

	public ModelAndView jobOrder(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {
		
		Map<String, Object> paramMap = CommonUtil.collectParameters(req);
		
		paramMap.put("s_user_cd", 	CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
		paramMap.put("s_user_ip", 	CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
		paramMap.put("SCHEMA", 		CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		
		String sr_code = CommonUtil.isNull(paramMap.get("sr_code"));

		System.out.println("sr_code : " + sr_code);
		
		JSONObject jObj = this.api("jobOrder", sr_code);
		
		ModelAndView output = new ModelAndView();
		output.setViewName("jsonView");
		output.addObject(jObj);

		return output;
	}
	
	private JSONObject api(String gb, String sr_code) {
		
		System.out.println("gb : " + gb);
		
		HttpClient hc 	= new HttpClient();
		JSONObject rObj = new JSONObject();
		PostMethod pm 	= null;
			
		rObj.put("r_code", "-1");
		
		String strEzJOBsUrl = CommonUtil.isNull(CommonUtil.getMessage("EZJOBS_URL"));

		try{
			
			pm = new PostMethod(strEzJOBsUrl + "/common.ez?c=ez000&a=common.api.api_site");
			pm.addParameter("req_gb", 		gb);
			pm.addParameter("sr_code", 		sr_code);
			
			int ret_code = hc.executeMethod(pm);
			
			
			System.out.println("ret_code : " + ret_code);
			
			if(ret_code == HttpStatus.SC_OK) {

				rObj = JSONObject.fromObject(CommonUtil.isNull(pm.getResponseBodyAsString()));
				
				//if(!"1".equals(rObj.get("r_code"))) throw new Exception(CommonUtil.isNull(rObj.get("r_msg")));
					
				//jObj.put("r_code", 	"1");
				//jObj.put("r_msg", 	CommonUtil.isNull(rObj.get("r_msg")));
				
			}else{
				throw new Exception("http error(code:"+ret_code+").");
			}
			
			
		}catch(Exception e){
			rObj.put("r_msg", e.getMessage());
		}finally{
			if(pm!=null) pm.releaseConnection();
		}
		
		return rObj;
	}
}