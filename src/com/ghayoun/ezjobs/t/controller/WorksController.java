package com.ghayoun.ezjobs.t.controller;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.text.SimpleDateFormat;
import java.util.*;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.json.JSONArray;
import org.json.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.BeanUtils;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.ghayoun.ezjobs.a.service.EmAlertService;
import com.ghayoun.ezjobs.comm.domain.BoardBean;
import com.ghayoun.ezjobs.comm.domain.CommonBean;
import com.ghayoun.ezjobs.comm.service.CommonService;
import com.ghayoun.ezjobs.comm.service.EzExcelBatchQuartzServiceImpl;
import com.ghayoun.ezjobs.comm.service.EzJobAttemptServiceImpl;
import com.ghayoun.ezjobs.comm.service.EzSmsJobServiceImpl;
import com.ghayoun.ezjobs.common.util.BaseController;
import com.ghayoun.ezjobs.common.util.CommonUtil;
import com.ghayoun.ezjobs.common.util.DateUtil;
import com.ghayoun.ezjobs.common.util.DbUtil;
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
import com.ghayoun.ezjobs.t.domain.ActiveJobBean;
import com.ghayoun.ezjobs.t.domain.CompanyBean;
import com.ghayoun.ezjobs.t.domain.DefJobBean;
import com.ghayoun.ezjobs.t.domain.Doc01Bean;
import com.ghayoun.ezjobs.t.domain.Doc02Bean;
import com.ghayoun.ezjobs.t.domain.Doc03Bean;
import com.ghayoun.ezjobs.t.domain.Doc05Bean;
import com.ghayoun.ezjobs.t.domain.Doc07Bean;
import com.ghayoun.ezjobs.t.domain.Doc08Bean;
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
import com.google.gson.JsonObject;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.xml.sax.InputSource;
import java.io.StringReader;

public class WorksController extends BaseController {

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

    private void autoLogin(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException, Exception {
        Map<String, Object> paramMap = CommonUtil.collectParameters(req);

        UserBean userBean = worksUserService.dGetUserLogin(paramMap);

        req.getSession().setAttribute("USER_CD", userBean.getUser_cd());
        req.getSession().setAttribute("USER_ID", userBean.getUser_id());
        req.getSession().setAttribute("USER_NM", CommonUtil.E2K(userBean.getUser_nm()));
        req.getSession().setAttribute("USER_GB", CommonUtil.isNull(userBean.getUser_gb()));
        req.getSession().setAttribute("USER_EMAIL", CommonUtil.isNull(userBean.getUser_email()));
        req.getSession().setAttribute("USER_HP", CommonUtil.isNull(userBean.getUser_hp()));
        req.getSession().setAttribute("DEPT_CD", CommonUtil.isNull(userBean.getDept_cd()));
        req.getSession().setAttribute("DEPT_NM", CommonUtil.E2K(userBean.getDept_nm()));
        req.getSession().setAttribute("DUTY_CD", CommonUtil.isNull(userBean.getDuty_cd()));
        req.getSession().setAttribute("DUTY_NM", CommonUtil.E2K(userBean.getDuty_nm()));
        req.getSession().setAttribute("NO_AUTH", CommonUtil.isNull(userBean.getNo_auth()));

        req.getSession().setAttribute("USER_IP", req.getLocalAddr());
    }


    public ModelAndView ez001(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);
        String strUser_pw = CommonUtil.isNull(paramMap.get("user_pw")).replace("&lt;","<").replace("&gt;",">").replace("&amp;","&");

		/*HttpSession session = req.getSession();
		String ssoId = (String) session.getAttribute("SSOID");

		System.out.println("ssoId : " + ssoId);*/

        //paramMap.put("user_pw", CommonUtil.toSha512(strUser_pw));
        paramMap.put("user_pw", strUser_pw + CommonUtil.isNull(paramMap.get("user_id")) + CommonUtil.getMessage("SERVER_GB"));
        Map<String, Object> rMap = new HashMap<String, Object>();
        
        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));
        //로그인 통제여부
        List urlLoginYnList = null;

        paramMap.put("mcode_cd", "M65");
        urlLoginYnList = commonService.dGetsCodeList(paramMap);
        //로그인 통제 제외대상
        List urlLoginYnOkList = null;

        paramMap.put("mcode_cd", "M64");
        urlLoginYnOkList = commonService.dGetsCodeList(paramMap);

        UserBean userBean = worksUserService.dGetUserLogin(paramMap);

        String strUserChk = "";

        if (userBean == null) {

            paramMap.put("user_check", CommonUtil.isNull(paramMap.get("user_id")));
            CommonBean bean = worksUserService.dGetUserListCnt(paramMap);

            if (bean != null) {
                strUserChk = CommonUtil.isNull(bean.getTotal_count());
            }
        }

        ModelAndView output = null;
        output = new ModelAndView("login");
        output.addObject("userBean", userBean);
        output.addObject("strUserChk", strUserChk);
        output.addObject("urlLoginYnList", urlLoginYnList);
        output.addObject("urlLoginYnOkList", urlLoginYnOkList);

        return output;

    }

    public ModelAndView ez001_sso(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

        HttpSession session = req.getSession();

        String ssoId = (String) session.getAttribute("SSO_ID");

        logger.info("sso_id : " + ssoId);

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);

        paramMap.put("user_id", ssoId);
        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));
        UserBean userBean = worksUserService.dGetUserLogin(paramMap);

        ModelAndView output = null;
        output = new ModelAndView("login");
        output.addObject("userBean", userBean);

        return output;
    }

    public ModelAndView ez001_naver_sso(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);

        String json_string = "";
        String json_string2 = "";
        String strTokenCode = CommonUtil.isNull(paramMap.get("code"));
        String strSsoAccessUrl = CommonUtil.isNull(CommonUtil.getMessage("SSO_ACCESS_URL"));
        String strSsoInfoUrl = CommonUtil.isNull(CommonUtil.getMessage("SSO_INFO_URL"));
        String strSsoId = CommonUtil.isNull(CommonUtil.getMessage("SSO_ID"));

        System.out.println(strSsoAccessUrl + "?svcId=" + strSsoId + "&code=" + strTokenCode + "&isEnhanced=true");

        // ACCESS TOKEN
        URL obj = new URL(strSsoAccessUrl + "?svcId=" + strSsoId + "&code=" + strTokenCode + "&isEnhanced=true");
        HttpURLConnection conn = (HttpURLConnection) obj.openConnection();

        conn.setRequestMethod("GET");
        conn.setDoOutput(true);

        BufferedReader br = null;

        br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));

        String line = "";

        while ((line = br.readLine()) != null) {
            json_string = line;
        }

        String access_token = "";
        String token_type = "";
        String expires_in = "";
        String token_svcId = "";
        String error = "";
        String error_description = "";
        String user_id = "";

        JSONParser jsonParser = new JSONParser();
        org.json.simple.JSONObject jsonObject = (org.json.simple.JSONObject) jsonParser.parse(json_string);

        access_token = (String) jsonObject.get("access_token");
        token_type = (String) jsonObject.get("token_type");
        expires_in = (String) jsonObject.get("expires_in");
        token_svcId = (String) jsonObject.get("token_svcId");
        error = (String) jsonObject.get("error");
        error_description = (String) jsonObject.get("error_description");

        System.out.println(strSsoInfoUrl + "?svcId=" + strSsoId + "&access_token=" + access_token + "&isEnhanced=true");

        // TOKEN INFO
        URL obj2 = new URL(strSsoInfoUrl + "?svcId=" + strSsoId + "&access_token=" + access_token + "&isEnhanced=true");
        HttpURLConnection conn2 = (HttpURLConnection) obj2.openConnection();

        conn2.setRequestMethod("GET");
        conn2.setDoOutput(true);

        BufferedReader br2 = null;

        br2 = new BufferedReader(new InputStreamReader(conn2.getInputStream(), "UTF-8"));

        String line2 = "";

        while ((line2 = br2.readLine()) != null) {
            json_string2 = line2;
        }

        JSONParser jsonParser2 = new JSONParser();
        org.json.simple.JSONObject jsonObject2 = (org.json.simple.JSONObject) jsonParser2.parse(json_string2);

        user_id = (String) jsonObject2.get("user_id");
        error = (String) jsonObject2.get("error");
        error_description = (String) jsonObject2.get("error_description");

        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));
        paramMap.put("user_id", user_id);
        UserBean userBean = worksUserService.dGetUserLogin(paramMap);

        ModelAndView output = null;
        output = new ModelAndView("login");
        output.addObject("login_gubun", "sso");
        output.addObject("userBean", userBean);

        return output;
    }
    
    public ModelAndView ez001_tempPassword(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);
        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));
        
        Map<String, Object> rMap = new HashMap<String, Object>();
        
        rMap = worksUserService.dPrcCreateTempPassword(paramMap);
        
        System.out.println("rMap111 : " + rMap);  
        
        ModelAndView output = null;
        output = new ModelAndView("result/t_result");  
        output.addObject("rMap", rMap); 
        
        return output;

    }

    @SuppressWarnings("unchecked")
    public ModelAndView ez002(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);

        paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
        paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));
//		List userAuthList = worksUserService.dGetUserAuthList(paramMap);

        // 사용자가 결재라인 설정 할 때는 부서결재자만 조회할 수 있게 셋팅.
        String arg = CommonUtil.isNull(paramMap.get("arg"));
        paramMap.put("arg", arg);

        String popup = CommonUtil.isNull(paramMap.get("popup"));

        Paging paging = null;
        int rowSize = 0;

        if (!popup.equals("")) {
            String currentPage = CommonUtil.isNull(paramMap.get("currentPage"), "1");
            String rowCnt = CommonUtil.isNull(paramMap.get("rowCnt"), CommonUtil.isNull(req.getSession().getAttribute("DEFAULT_PAGING")));

            if (!rowCnt.equals("")) {
                rowSize = Integer.parseInt(rowCnt);
            } else {
                rowSize = Integer.parseInt(CommonUtil.getMessage("PAGING.ROWSIZE.BASIC"));
            }

            int pageSize = Integer.parseInt(CommonUtil.getMessage("PAGING.PAGESIZE.BASIC"));

            CommonBean bean = worksUserService.dGetUserListCnt(paramMap);
            paging = new Paging(bean.getTotal_count(), rowSize, pageSize, currentPage);
        }

        Map<String, Object> rMap = new HashMap<String, Object>();

        paramMap.put("popup", popup);


        List userList = null;
        List deptList;
        List dutyList;

        ModelAndView output = null;


        if ("".equals(popup)) {

            deptList = CommonUtil.getDeptList();
            dutyList = CommonUtil.getDutyList();

            output = new ModelAndView("works/C06/main_contents/userList");
            output.addObject("cm", CommonUtil.getComScodeList(paramMap));
            output.addObject("SCODE_GRP_LIST", CommonUtil.getComScodeList(paramMap));
//			output.addObject("userAuthList"  , 	userAuthList);

        } else {

            paramMap.put("startRowNum", paging.getStartRowNum());
            paramMap.put("endRowNum", paging.getEndRowNum());

            userList = worksUserService.dGetUserList(paramMap);
            deptList = CommonUtil.getDeptList();
            dutyList = CommonUtil.getDutyList();

            output = new ModelAndView("contents/popup/userList");
        }

        if (!popup.equals("")) {

            output.addObject("userList", userList);
            output.addObject("deptList", deptList);
            output.addObject("dutyList", dutyList);
            output.addObject("Paging", paging);
            output.addObject("totalCount", paging.getTotalRowSize());
            output.addObject("rowSize", rowSize);

        } else {

            String dept_cd = "";
            String dept_nm = "";
            String user_gb_cd = "";
            String[] arr_user_gb_cd = CommonUtil.getMessage("USER.GB").split(",");

            for (int i = 0; i < arr_user_gb_cd.length; i++) {
                String[] sub_user_gb_cd = arr_user_gb_cd[i].split("[|]");

                if (i == arr_user_gb_cd.length - 1) {
                    user_gb_cd += sub_user_gb_cd[0];
                } else {
                    user_gb_cd += sub_user_gb_cd[0] + ",";
                }
            }


            for (int i = 0; i < deptList.size(); i++) {
                CompanyBean bean = (CompanyBean) deptList.get(i);

                if (i == deptList.size() - 1) {
                    dept_cd += CommonUtil.isNull(bean.getDept_cd());
                    dept_nm += CommonUtil.isNull(bean.getDept_nm());
                } else {
                    dept_cd += CommonUtil.isNull(bean.getDept_cd()) + ",";
                    dept_nm += CommonUtil.isNull(bean.getDept_nm()) + ",";
                }
            }

            String duty_cd = "";
            String duty_nm = "";
            for (int i = 0; i < dutyList.size(); i++) {
                CompanyBean bean = (CompanyBean) dutyList.get(i);

                if (i == dutyList.size() - 1) {
                    duty_cd += CommonUtil.isNull(bean.getDuty_cd());
                    duty_nm += CommonUtil.isNull(bean.getDuty_nm());
                } else {
                    duty_cd += CommonUtil.isNull(bean.getDuty_cd()) + ",";
                    duty_nm += CommonUtil.isNull(bean.getDuty_nm()) + ",";
                }
            }
            output.addObject("DUTY_GB_CD", duty_cd);
            output.addObject("DUTY_GB_NM", duty_nm);
            output.addObject("DEPT_GB_CD", dept_cd);
            output.addObject("DEPT_GB_NM", dept_nm);
            output.addObject("USER_GB_CD", user_gb_cd);
            output.addObject("USER_GB_NM", CommonUtil.getUserGbNm());
            output.addObject("USER_APPR_GB_CD", CommonUtil.getMessage("USER.APPR.GB"));
            output.addObject("USER_APPR_GB_NM", CommonUtil.getGbNm("USER.APPR.GB"));
            output.addObject("cm", CommonUtil.getComScodeList(paramMap));
//			output.addObject("userAuthList"  , 	userAuthList);
        }

        return output;
    }


    @SuppressWarnings({"unchecked", "rawtypes"})
    public ModelAndView ez002_info(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);
        paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
        paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
        paramMap.put("user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD"), "0"));
        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));

        List userList = worksUserService.dGetUserList(paramMap);
        List<CompanyBean> deptList = CommonUtil.getDeptList();
        List<CompanyBean> dutyList = CommonUtil.getDutyList();

        String dept_cd = "";
        String dept_nm = "";
        String user_gb_cd = "";
        String[] arr_user_gb_cd = CommonUtil.getMessage("USER.GB").split(",");

        ModelAndView output = null;
        output = new ModelAndView("main_contents/userInfo");
        output.addObject("userList", userList);
        output.addObject("dataCenterList", CommonUtil.getDataCenterList());

        for (int i = 0; i < arr_user_gb_cd.length; i++) {
            String[] sub_user_gb_cd = arr_user_gb_cd[i].split("[|]");

            if (i == arr_user_gb_cd.length - 1) {
                user_gb_cd += sub_user_gb_cd[0];
            } else {
                user_gb_cd += sub_user_gb_cd[0] + ",";
            }
        }


        for (int i = 0; i < deptList.size(); i++) {
            CompanyBean bean = deptList.get(i);

            if (i == deptList.size() - 1) {
                dept_cd += CommonUtil.isNull(bean.getDept_cd());
                dept_nm += CommonUtil.isNull(bean.getDept_nm());
            } else {
                dept_cd += CommonUtil.isNull(bean.getDept_cd()) + ",";
                dept_nm += CommonUtil.isNull(bean.getDept_nm()) + ",";
            }
        }

        String duty_cd = "";
        String duty_nm = "";
        for (int i = 0; i < dutyList.size(); i++) {
            CompanyBean bean = dutyList.get(i);

            if (i == dutyList.size() - 1) {
                duty_cd += CommonUtil.isNull(bean.getDuty_cd());
                duty_nm += CommonUtil.isNull(bean.getDuty_nm());
            } else {
                duty_cd += CommonUtil.isNull(bean.getDuty_cd()) + ",";
                duty_nm += CommonUtil.isNull(bean.getDuty_nm()) + ",";
            }
        }

        output.addObject("DUTY_GB_CD", duty_cd);
        output.addObject("DUTY_GB_NM", duty_nm);
        output.addObject("DEPT_GB_CD", dept_cd);
        output.addObject("DEPT_GB_NM", dept_nm);
        output.addObject("USER_GB_CD", user_gb_cd);
        output.addObject("USER_GB_NM", CommonUtil.getUserGbNm());

        return output;
    }

    public ModelAndView ez002_edit(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);

        paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
        paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
        paramMap.put("user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD"), "0"));
        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));

        List userList = worksUserService.dGetUserList(paramMap);

        List<CompanyBean> deptList = CommonUtil.getDeptList();
        List<CompanyBean> dutyList = CommonUtil.getDutyList();

        String dept_cd = "";
        String dept_nm = "";
        String user_gb_cd = "";

        String[] arr_user_gb_cd = CommonUtil.getMessage("USER.GB").split(",");

        ModelAndView output = null;

        output = new ModelAndView("works/C08/main_contents/userModify");

        output.addObject("userList", userList);
        output.addObject("cm", CommonUtil.getComScodeList(paramMap));

        for (int i = 0; i < arr_user_gb_cd.length; i++) {
            String[] sub_user_gb_cd = arr_user_gb_cd[i].split("[|]");

            if (i == arr_user_gb_cd.length - 1) {
                user_gb_cd += sub_user_gb_cd[0];
            } else {
                user_gb_cd += sub_user_gb_cd[0] + ",";
            }
        }

        for (int i = 0; i < deptList.size(); i++) {
            CompanyBean bean = deptList.get(i);

            if (i == deptList.size() - 1) {
                dept_cd += CommonUtil.isNull(bean.getDept_cd());
                dept_nm += CommonUtil.isNull(bean.getDept_nm());
            } else {
                dept_cd += CommonUtil.isNull(bean.getDept_cd()) + ",";
                dept_nm += CommonUtil.isNull(bean.getDept_nm()) + ",";
            }
        }

        String duty_cd = "";
        String duty_nm = "";

        for (int i = 0; i < dutyList.size(); i++) {
            CompanyBean bean = dutyList.get(i);

            if (i == dutyList.size() - 1) {
                duty_cd += CommonUtil.isNull(bean.getDuty_cd());
                duty_nm += CommonUtil.isNull(bean.getDuty_nm());
            } else {
                duty_cd += CommonUtil.isNull(bean.getDuty_cd()) + ",";
                duty_nm += CommonUtil.isNull(bean.getDuty_nm()) + ",";
            }
        }

        output.addObject("DUTY_GB_CD", duty_cd);
        output.addObject("DUTY_GB_NM", duty_nm);
        output.addObject("DEPT_GB_CD", dept_cd);
        output.addObject("DEPT_GB_NM", dept_nm);
        output.addObject("USER_GB_CD", user_gb_cd);
        output.addObject("USER_GB_NM", CommonUtil.getUserGbNm());
        output.addObject("USER_APPR_GB_CD", CommonUtil.getMessage("USER.APPR.GB"));
        output.addObject("USER_APPR_GB_NM", CommonUtil.getGbNm("USER.APPR.GB"));

        return output;
    }

    public ModelAndView ez002_pw_change_ui(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {
        Map<String, Object> paramMap = CommonUtil.collectParameters(req);

        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));

        ModelAndView output = null;
        output = new ModelAndView("contents/userPwChange");

        return output;
    }

    public ModelAndView ez002_pw_change(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);
        paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
        paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));

        if (!CommonUtil.isNull(paramMap.get("user_pw")).equals("")) {
            //paramMap.put("user_pw", CommonUtil.toSha512(CommonUtil.isNull(paramMap.get("user_pw"))+CommonUtil.isNull(paramMap.get("user_id"))+CommonUtil.getMessage("SERVER_GB")));
        	paramMap.put("new_user_pw", CommonUtil.isNull(paramMap.get("new_user_pw")).replace("&lt;","<").replace("&gt;",">").replace("&amp;","&"));
			paramMap.put("re_new_user_pw", CommonUtil.isNull(paramMap.get("re_new_user_pw")).replace("&lt;","<").replace("&gt;",">").replace("&amp;","&"));
        }

        Map<String, Object> rMap = new HashMap<String, Object>();

        String strFlag = CommonUtil.isNull(paramMap.get("flag"));

        try {

            if (strFlag.equals("folder_auth") || strFlag.equals("ins_copy") || strFlag.equals("all_folder_auth") ||
                    strFlag.equals("user_folder_auth_delete") || strFlag.equals("del_copy") || strFlag.equals("udt_auth")) {
                rMap = worksUserService.dPrcUserAuth(paramMap);
            } else if (strFlag.equals("pw_init") || strFlag.equals("pw_all_init") || strFlag.equals("account_lock_init")) {
                rMap = worksUserService.dPrcUserInit(paramMap);
            } else if (strFlag.equals("pw_change") || strFlag.equals("pw_init_change") || strFlag.equals("pw_date_over")) {
                rMap = worksUserService.dPrcUserPwChange(paramMap);
            } else {
                rMap = worksUserService.dPrcUser(paramMap);
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
//		output = new ModelAndView("ezjobs/t/result");
        output = new ModelAndView("result/t_result");
        output.addObject("rMap", rMap);

        return output;
    }

    //폴더권한(이기준)
    public ModelAndView ez002_authFolder(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);

        paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
        paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
        paramMap.put("s_user_gb", CommonUtil.isNull(req.getSession().getAttribute("USER_GB")));
        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));
        Map<String, Object> rMap = new HashMap<String, Object>();

        List userAuthList = worksUserService.dGetUserAuthList(paramMap);

        paramMap.put("searchType", "sched_tableList2");
        List schedTableList = commonService.dGetSearchItemList(paramMap);

        ModelAndView output = null;

        output = new ModelAndView("contents/popup/userFolderAuth");

        output.addObject("userAuthList", userAuthList);
        output.addObject("schedTableList", schedTableList);
        output.addObject("ALL_GB", "N");

        return output;

    }

    public ModelAndView ez002_allAuthFolder(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);

        paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
        paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));
        Map<String, Object> rMap = new HashMap<String, Object>();

//			List userAuthList = worksUserService.dGetUserAuthList(paramMap);

        paramMap.put("searchType", "sched_tableList3");
        List schedTableList = commonService.dGetSearchItemList(paramMap);

        ModelAndView output = null;

        output = new ModelAndView("contents/popup/userFolderAuth");

//			output.addObject("userAuthList"		, userAuthList);
        output.addObject("schedTableList", schedTableList);
        output.addObject("ALL_GB", "Y");

        return output;

    }

    //폴더권한복사(김은희)
    @SuppressWarnings({"unchecked"})
    public ModelAndView ez002_folappgrp_copy(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);

        paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
        paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));

        ModelAndView output = null;
        output = new ModelAndView("works/P/contents/popup/popFolAppGrpCopy");
        output.addObject("cm", CommonUtil.getComScodeList(paramMap));
        //output.addObject("APPROVAL_DOC_NM", CommonUtil.getApprovalDocGb());

        return output;
    }

    //메뉴권한(김은희)
    @SuppressWarnings("unchecked")
    public ModelAndView ez002_role_p(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);
        paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
        paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));

        Map<String, Object> rMap = new HashMap<String, Object>();

        try {
            rMap = worksUserService.dPrcUser(paramMap);
        } catch (DefaultServiceException e) {
            rMap = e.getResultMap();

            if ("-2".equals(CommonUtil.isNull(rMap.get("r_code")))) {
                logger.error(CommonUtil.isNull(rMap.get("r_msg")));
            } else {
                logger.error(e.getMessage());
            }
            logger.error("ez002_role_p:" + rMap);
        } catch (Exception e) {
            if ("".equals(CommonUtil.isNull(rMap.get("r_code")))) rMap.put("r_code", "-1");
            if ("".equals(CommonUtil.isNull(rMap.get("r_msg")))) rMap.put("r_msg", "ERROR.01");

            logger.error(e.getMessage());
            logger.error("ez002_role_p", e);
        }

        ModelAndView output = null;
        output = new ModelAndView("result/t_result");
        output.addObject("rMap", rMap);

        return output;

    }

    @SuppressWarnings({"unchecked"})
    public ModelAndView ez002_approval_line(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);

        paramMap.put("s_user_cd", CommonUtil.isNull(paramMap.get("user_cd")));
        paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));
        paramMap.put("s_use_yn", "Y");

        List userApprovalGroup = null;
        userApprovalGroup = commonService.dGetUserApprovalGroup(paramMap);

        ModelAndView output = null;
        output = new ModelAndView("contents/popup/approvalLine");
        output.addObject("APPROVAL_ORDER_CD", CommonUtil.getMessage("APPROVAL.ORDER"));
        output.addObject("APPROVAL_DOC_CD", CommonUtil.getMessage("APPROVAL.DOC.GB"));
        output.addObject("APPROVAL_DOC_NM", CommonUtil.getApprovalDocGb());
        output.addObject("userApprovalGroup", userApprovalGroup);

        return output;
    }

    @SuppressWarnings("unchecked")
    public ModelAndView ez002_p(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);
        paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
        paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));

        Map<String, Object> rMap = new HashMap<String, Object>();

        String strFlag = CommonUtil.isNull(paramMap.get("flag"));
        
        try {

            if (strFlag.equals("folder_auth") || strFlag.equals("ins_copy") || strFlag.equals("all_folder_auth") ||
                    strFlag.equals("user_folder_auth_delete") || strFlag.equals("del_copy") || strFlag.equals("udt_auth")) {
                rMap = worksUserService.dPrcUserAuth(paramMap);
            } else if (strFlag.equals("pw_init") || strFlag.equals("pw_all_init") || strFlag.equals("account_lock_init")) {
                rMap = worksUserService.dPrcUserInit(paramMap);
            } else if (strFlag.equals("pw_change") || strFlag.equals("pw_init_change") || strFlag.equals("pw_date_over")) {
                rMap = worksUserService.dPrcUserPwChange(paramMap);
            } else {
                rMap = worksUserService.dPrcUser(paramMap);
            }


        } catch (DefaultServiceException e) {
            rMap = e.getResultMap();

            if ("-2".equals(CommonUtil.isNull(rMap.get("r_code")))) {
                logger.error(CommonUtil.isNull(rMap.get("r_msg")));
            } else {
                logger.error(e.getMessage());
            }
            logger.error("ez002_p:" + rMap);
        } catch (Exception e) {
            if ("".equals(CommonUtil.isNull(rMap.get("r_code")))) rMap.put("r_code", "-1");
            if ("".equals(CommonUtil.isNull(rMap.get("r_msg")))) rMap.put("r_msg", "ERROR.01");

            logger.error(e.getMessage());
            logger.error("ez002_p", e);
        }

        ModelAndView output = null;
        output = new ModelAndView("result/t_result");
        output.addObject("rMap", rMap);

        return output;

    }

    @SuppressWarnings("unchecked")
    public ModelAndView ez002_info_p(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);
        paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
        paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));

        logger.info(" ez002_info_p | absence_user_cd : " + CommonUtil.isNull(paramMap.get("absence_user_cd")));

        Map<String, Object> rMap = new HashMap<String, Object>();

        String strFlag = CommonUtil.isNull(paramMap.get("flag"));

        try {

            if (strFlag.equals("folder_auth") || strFlag.equals("ins_copy") || strFlag.equals("all_folder_auth") ||
                    strFlag.equals("user_folder_auth_delete") || strFlag.equals("del_copy") || strFlag.equals("udt_auth")) {
                rMap = worksUserService.dPrcUserAuth(paramMap);
            } else if (strFlag.equals("pw_init") || strFlag.equals("pw_all_init") || strFlag.equals("account_lock_init")) {
                rMap = worksUserService.dPrcUserInit(paramMap);
            } else if (strFlag.equals("pw_change") || strFlag.equals("pw_init_change") || strFlag.equals("pw_date_over")) {
                rMap = worksUserService.dPrcUserPwChange(paramMap);
            } else {
                rMap = worksUserService.dPrcUser(paramMap);
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
        output = new ModelAndView("result/t_result");
        output.addObject("rMap", rMap);

        return output;

    }

    public ModelAndView ez002_all_p(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);

        paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
        paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));

        Map<String, Object> rMap = new HashMap<String, Object>();

        String strFlag = CommonUtil.isNull(paramMap.get("flag"));

        try {

            if (strFlag.equals("folder_auth") || strFlag.equals("ins_copy") || strFlag.equals("all_folder_auth") ||
                    strFlag.equals("user_folder_auth_delete") || strFlag.equals("del_copy") || strFlag.equals("udt_auth")) {
                rMap = worksUserService.dPrcUserAuth(paramMap);
            } else if (strFlag.equals("pw_init") || strFlag.equals("pw_all_init") || strFlag.equals("account_lock_init")) {
                rMap = worksUserService.dPrcUserInit(paramMap);
            } else if (strFlag.equals("pw_change") || strFlag.equals("pw_init_change") || strFlag.equals("pw_date_over")) {
                rMap = worksUserService.dPrcUserPwChange(paramMap);
            } else {
                rMap = worksUserService.dPrcUser(paramMap);
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
        output = new ModelAndView("ezjobs/t/result");
        output.addObject("rMap", rMap);

        return output;

    }

    public ModelAndView ez002_pw_init(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);
        paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
        paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));
        Map<String, Object> rMap = new HashMap<String, Object>();

        String strFlag = CommonUtil.isNull(paramMap.get("flag"));

        try {

            if (strFlag.equals("folder_auth") || strFlag.equals("ins_copy") || strFlag.equals("all_folder_auth") ||
                    strFlag.equals("user_folder_auth_delete") || strFlag.equals("del_copy") || strFlag.equals("udt_auth")) {
                rMap = worksUserService.dPrcUserAuth(paramMap);
            } else if (strFlag.equals("pw_init") || strFlag.equals("pw_all_init") || strFlag.equals("account_lock_init")) {
                rMap = worksUserService.dPrcUserInit(paramMap);
            } else if (strFlag.equals("pw_change") || strFlag.equals("pw_init_change") || strFlag.equals("pw_date_over")) {
                rMap = worksUserService.dPrcUserPwChange(paramMap);
            } else {
                rMap = worksUserService.dPrcUser(paramMap);
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
        output = new ModelAndView("result/t_result");
        output.addObject("rMap", rMap);

        return output;

    }

    //일괄 잠금 해제
    public ModelAndView ez002_account_lock_init(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);
        paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
        paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));
        Map<String, Object> rMap = new HashMap<String, Object>();

        String strFlag = CommonUtil.isNull(paramMap.get("flag"));

        try {

            if (strFlag.equals("folder_auth") || strFlag.equals("ins_copy") || strFlag.equals("all_folder_auth") ||
                    strFlag.equals("user_folder_auth_delete") || strFlag.equals("del_copy") || strFlag.equals("udt_auth")) {
                rMap = worksUserService.dPrcUserAuth(paramMap);
            } else if (strFlag.equals("pw_init") || strFlag.equals("pw_all_init") || strFlag.equals("account_lock_init")) {
                rMap = worksUserService.dPrcUserInit(paramMap);
            } else if (strFlag.equals("pw_change") || strFlag.equals("pw_init_change") || strFlag.equals("pw_date_over")) {
                rMap = worksUserService.dPrcUserPwChange(paramMap);
            } else {
                rMap = worksUserService.dPrcUser(paramMap);
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
        output = new ModelAndView("result/t_result");
        output.addObject("rMap", rMap);

        return output;

    }

    public ModelAndView ez002_excel(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);
        paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
        paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
        paramMap.put("s_dept_cd", CommonUtil.isNull(req.getSession().getAttribute("DEPT_CD")));
        paramMap.put("s_user_gb", CommonUtil.isNull(req.getSession().getAttribute("USER_GB")));

        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));

        //String startRowNum	= CommonUtil.isNull(paramMap.get("startRowNum"));
        //String pagingNum	= CommonUtil.isNull(paramMap.get("pagingNum"));

        //paramMap.put("startRowNum", "0");
        //paramMap.put("pagingNum", Integer.parseInt(startRowNum) + Integer.parseInt(pagingNum));

//		List myDocInfoList = worksApprovalDocService.dGetMyDocInfoList(paramMap);

        String user_gb_cd = "";
        String[] arr_user_gb_cd = CommonUtil.getMessage("USER.GB").split(",");

        for (int i = 0; i < arr_user_gb_cd.length; i++) {
            String[] sub_user_gb_cd = arr_user_gb_cd[i].split("[|]");

            if (i == arr_user_gb_cd.length - 1) {
                user_gb_cd += sub_user_gb_cd[0];
            } else {
                user_gb_cd += sub_user_gb_cd[0] + ",";
            }
        }
        paramMap.put("pagingNum", "");
        List userList = worksUserService.dGetUserList(paramMap);

        ModelAndView output = null;
        output = new ModelAndView("contents/userListExcel");

        output.addObject("userList", userList);
        output.addObject("USER_GB_CD", user_gb_cd);
        output.addObject("USER_GB_NM", CommonUtil.getUserGbNm());
        output.addObject("USER_APPR_GB_CD", CommonUtil.getMessage("USER.APPR.GB"));
        output.addObject("USER_APPR_GB_NM", CommonUtil.getGbNm("USER.APPR.GB"));

        return output;

    }

    public ModelAndView ez002_excel_form(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);
        paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
        paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));
        ModelAndView output = null;

        output = new ModelAndView("contents/userListExcelForm");

        return output;

    }

    public ModelAndView ez002_history_excel(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);
        paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
        paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
        paramMap.put("s_dept_cd", CommonUtil.isNull(req.getSession().getAttribute("DEPT_CD")));
        paramMap.put("s_user_gb", CommonUtil.isNull(req.getSession().getAttribute("USER_GB")));

        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));

        //String startRowNum	= CommonUtil.isNull(paramMap.get("startRowNum"));
        //String pagingNum	= CommonUtil.isNull(paramMap.get("pagingNum"));

        //paramMap.put("startRowNum", "0");
        //paramMap.put("pagingNum", Integer.parseInt(startRowNum) + Integer.parseInt(pagingNum));

//		List myDocInfoList = worksApprovalDocService.dGetMyDocInfoList(paramMap);


        String user_gb_cd = "";
        String[] arr_user_gb_cd = CommonUtil.getMessage("USER.GB").split(",");

        for (int i = 0; i < arr_user_gb_cd.length; i++) {
            String[] sub_user_gb_cd = arr_user_gb_cd[i].split("[|]");

            if (i == arr_user_gb_cd.length - 1) {
                user_gb_cd += sub_user_gb_cd[0];
            } else {
                user_gb_cd += sub_user_gb_cd[0] + ",";
            }
        }

        List userHistoryList = worksUserService.dGetUserHistoryList(paramMap);

        ModelAndView output = null;
        output = new ModelAndView("contents/userHistoryExcel");

        output.addObject("userHistoryList", userHistoryList);
        output.addObject("USER_GB_CD", user_gb_cd);
        output.addObject("USER_GB_NM", CommonUtil.getUserGbNm());
        output.addObject("USER_APPR_GB_CD", CommonUtil.getMessage("USER.APPR.GB"));
        output.addObject("USER_APPR_GB_NM", CommonUtil.getGbNm("USER.APPR.GB"));
        return output;

    }

    public ModelAndView ez002_login_history_excel(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);
        paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
        paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));

        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));
        List userLoginHistoryList = worksUserService.dGetLoginHistoryList(paramMap);

        ModelAndView output = null;
        output = new ModelAndView("contents/userLoginHistoryExcel");

        output.addObject("userLoginHistoryList", userLoginHistoryList);
        return output;

    }

    public ModelAndView ez003_p(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException, Exception {
        Map<String, Object> paramMap = CommonUtil.collectParameters(req);
        paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
        paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));

        Map<String, Object> rMap = new HashMap<String, Object>();

        try {
            rMap = worksApprovalLineService.dPrcApprovalLine(paramMap);
        } catch (DefaultServiceException e) {
            rMap = e.getResultMap();

            if ("-2".equals(CommonUtil.isNull(rMap.get("r_code")))) {
                logger.error(CommonUtil.isNull(rMap.get("r_msg")));
            } else {
                logger.error(e.getMessage());
            }

        } catch (Exception e) {
            if ("".equals(CommonUtil.isNull(rMap.get("r_code")))) rMap.put("r_code", "-1");
            if ("".equals(CommonUtil.isNull(rMap.get("r_msg")))) rMap.put("r_msg", "ERROR.01");

            logger.error(e.getMessage());
        }

        ModelAndView output = null;
        output = new ModelAndView("ezjobs/t/result");
        output.addObject("rMap", rMap);

        return output;

    }

    public ModelAndView ez003_p_new(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);

        paramMap.put("s_user_cd", CommonUtil.isNull(paramMap.get("select_user_cd")));
        paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));

        Map<String, Object> rMap = new HashMap<String, Object>();

        try {
            rMap = worksApprovalLineService.dPrcApprovalLine_new(paramMap);
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
        output = new ModelAndView("ezjobs/t/result");
        output.addObject("rMap", rMap);

        return output;

    }

    @SuppressWarnings("unchecked")
    public ModelAndView ez004(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);

        paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
        paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));

        // 관리자 즉시결재 유무 코드 추가
        List adminApprovalBtnList = null;

        paramMap.put("mcode_cd", "M80");
        adminApprovalBtnList = commonService.dGetsCodeList(paramMap);

        ModelAndView output = null;
        output = new ModelAndView("works/C03/main_contents/myDocInfoList");

        output.addObject("STRT_DT", CommonUtil.getCurDateTo(CommonUtil.getCurDate(""), -7));
        output.addObject("END_DT", CommonUtil.getCurDateTo(CommonUtil.getCurDate(""), 0));
        output.addObject("paramMap", paramMap);
        output.addObject("cm", CommonUtil.getComScodeList(paramMap));
        output.addObject("adminApprovalBtnList", adminApprovalBtnList);

        return output;
    }

    public ModelAndView ez004_w_new(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);

        paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
        paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));

        String strTaskType = CommonUtil.isNull(paramMap.get("task_type"));
        String strJobGubun = CommonUtil.isNull(paramMap.get("job_gubun"));

        String doc_gb = CommonUtil.isNull(paramMap.get("doc_gb"));

        List approvalLineList = null;

        paramMap.put("user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));

//		approvalLineList = worksApprovalLineService.dGetApprovalLineList(paramMap);		//작업의뢰시 결재선 보이지 않도록 수정(2020.05.12, 김수정)

        List sCodeList = null;
        List sMapperCodeList = null;
        List sBatchGradeList = null;
        List dataCenterCodeList = null;
        List susiTypeList = null;
        List smsDefaultList = null;
        List mailDefaultList = null;

        // 계정관리코드 : M2
        paramMap.put("mcode_cd", "M2");
        sCodeList = commonService.dGetsCodeList(paramMap);

        // 조치방법코드 : M5
        paramMap.put("mcode_cd", "M5");
        sMapperCodeList = commonService.dGetsCodeList(paramMap);

        //배치작업등급코드
        paramMap.put("mcode_cd", "M9");
        sBatchGradeList = commonService.dGetsCodeList(paramMap);

        paramMap.put("mcode_cd", "M6");
        dataCenterCodeList = commonService.dGetsCodeList(paramMap);

        paramMap.put("mcode_cd", "M33");
        susiTypeList = commonService.dGetsCodeList(paramMap);

        List jobTypeGb = null;
        List adminApprovalBtnList = null;
        List systemGb = null;
        List resourceDefaultList = null;
        List variableDefaultList = null;

        paramMap.put("mcode_cd", "M42");
        jobTypeGb = commonService.dGetsCodeList(paramMap);

        // M43 코드를 사용안해서 제거 후 운영즉시결재노출 코드 가져올 수 있게 수정 (2023.06.16 강명준)
        paramMap.put("mcode_cd", "M80");
        adminApprovalBtnList = commonService.dGetsCodeList(paramMap);

        paramMap.put("mcode_cd", "M44");
        systemGb = commonService.dGetsCodeList(paramMap);

        // 리소스 기본값 : M81
        paramMap.put("mcode_cd", "M81");
        resourceDefaultList = commonService.dGetsCodeList(paramMap);

        // 변수 기본값 : M82
        paramMap.put("mcode_cd", "M82");
        variableDefaultList = commonService.dGetsCodeList(paramMap);

        //SMS 기본값 설정
        paramMap.put("mcode_cd", "M87");
        smsDefaultList = commonService.dGetsCodeList(paramMap);

        //MAIL 기본값 설정
        paramMap.put("mcode_cd", "M88");
        mailDefaultList = commonService.dGetsCodeList(paramMap);

        List odateList = CommonUtil.getCtmOdateList();
        int odate_cnt = odateList.size();

        ModelAndView output = null;

        output = new ModelAndView("main_contents/doc" + doc_gb + "_w");
        output.addObject("paramMap", paramMap);
        output.addObject("smsDefaultList", smsDefaultList);
        output.addObject("mailDefaultList", mailDefaultList);

        if ("01".equals(doc_gb)) {

            paramMap.put("searchType", "dataCenterList");

            output.addObject("dataCenterList", CommonUtil.getDataCenterList());
            output.addObject("hostList", CommonUtil.getHostList());
//			output.addObject("approvalLineList",			approvalLineList);		//작업의뢰시 결재선 보이지 않도록 수정(2020.05.12, 김수정)
            output.addObject("cm", CommonUtil.getComScodeList(paramMap));

            // 선행 조건
            paramMap.put("gubun", "inCond_cm");
            output.addObject("inCond_cm", CommonUtil.getComScodeList(paramMap));

        } else if ("02".equals(doc_gb)) {

            output.addObject("dataCenterList", CommonUtil.getDataCenterList());
            output.addObject("hostList", CommonUtil.getHostList());
            output.addObject("approvalLineList", approvalLineList);
            output.addObject("susiTypeList", susiTypeList);
            output.addObject("cm", CommonUtil.getComScodeList(paramMap));

            // 선행 조건
            paramMap.put("gubun", "inCond_cm");
            output.addObject("inCond_cm", CommonUtil.getComScodeList(paramMap));

        } else if ("03".equals(doc_gb) || "04".equals(doc_gb) || "07".equals(doc_gb)) {

            String currentPage = CommonUtil.isNull(paramMap.get("currentPage"));
            String rowCnt = CommonUtil.isNull(paramMap.get("rowCnt"), CommonUtil.isNull(req.getSession().getAttribute("DEFAULT_PAGING")));
            int rowSize = 0;

            if (!rowCnt.equals("")) {
                rowSize = Integer.parseInt(rowCnt);
            } else {
                rowSize = Integer.parseInt(CommonUtil.getMessage("PAGING.ROWSIZE.BASIC"));
            }

            int pageSize = Integer.parseInt(CommonUtil.getMessage("PAGING.PAGESIZE.BASIC"));

            output.addObject("dataCenterList", CommonUtil.getDataCenterList());
            output.addObject("hostList", CommonUtil.getHostList());

            String StrSDC = CommonUtil.isNull(req.getSession().getAttribute("SELECT_DATA_CENTER"));
            String strDataCenter = CommonUtil.isNull(paramMap.get("data_center"), StrSDC);

            if ("".equals(strDataCenter)) {
                paramMap.put("data_center", (CommonUtil.getDataCenterList().get(0)).getData_center());
            } else {
                paramMap.put("data_center", strDataCenter);
            }

            // 테이블은 삭제 요청서가 없다.
            //if( "03".equals(doc_gb) ) {
            //paramMap.put("s_task_type", "Job");
            //}

            DefJobBean bean = worksApprovalDocService.dGetDefJobListCnt(paramMap);
            int total_cnt = Integer.parseInt(bean.getTotal_cnt());
            Paging paging = new Paging(total_cnt, rowSize, pageSize, currentPage);

            paramMap.put("startRowNum", paging.getStartRowNum());
            paramMap.put("endRowNum", paging.getEndRowNum());
            List defJobList = worksApprovalDocService.dGetDefJobList(paramMap);

            output.addObject("Paging", paging);
            output.addObject("totalCount", paging.getTotalRowSize());
            output.addObject("rowSize", rowSize);
            output.addObject("defJobList", defJobList);
            output.addObject("dataCenterList", CommonUtil.getDataCenterList());

        } else if ("06".equals(doc_gb)) {

            output.addObject("dataCenterList", CommonUtil.getDataCenterList());
            output.addObject("approvalLineList", approvalLineList);
            output.addObject("cm", CommonUtil.getComScodeList(paramMap));

        } else if ("08".equals(doc_gb)) {
            paramMap.put("searchType", "dataCenterList");

            output.addObject("dataCenterList", CommonUtil.getDataCenterList());
            output.addObject("hostList", CommonUtil.getHostList());
            output.addObject("approvalLineList", approvalLineList);
            output.addObject("cm", CommonUtil.getComScodeList(paramMap));

            // 선행 조건
            paramMap.put("gubun", "inCond_cm");
            output.addObject("inCond_cm", CommonUtil.getComScodeList(paramMap));
        }

        output.addObject("sCodeList", sCodeList);
        output.addObject("sMapperCodeList", sMapperCodeList);
        output.addObject("sBatchGradeList", sBatchGradeList);
        output.addObject("jobTypeGb", jobTypeGb);
        output.addObject("adminApprovalBtnList", adminApprovalBtnList);
        output.addObject("resourceDefaultList", resourceDefaultList);
        output.addObject("variableDefaultList", variableDefaultList);

        output.addObject("data_center", CommonUtil.getComScodeList(paramMap));
        output.addObject("SERVER_MCODE_CD", CommonUtil.getMessage("COMCODE.SERVER.CODE"));
        output.addObject("IN_COND_DT", CommonUtil.getMessage("JOB.IN_CONDITION_DATE"));
        output.addObject("IN_COND_AND_OR", CommonUtil.getMessage("JOB.IN_CONDITION_AND_OR2"));
        output.addObject("OUT_COND_DT", CommonUtil.getMessage("JOB.OUT_CONDITION_DATE"));
        output.addObject("OUT_COND_EFFECT", CommonUtil.getMessage("JOB.OUT_CONDITION_EFFECT2"));
        output.addObject("DAYS_CAL", CommonUtil.getCTMcalenderList(paramMap));

        if (odate_cnt > 0) {
            for (int i = 0; i < odate_cnt; i++) {
                CommonBean bean = (CommonBean) odateList.get(0);
                String odate = bean.getView_odate().replaceAll("/", "");
                output.addObject("ODATE", odate);
                output.addObject("NEXT_ODATE", CommonUtil.getCurDateTo(odate, 1));
            }
        } else {
            output.addObject("ODATE", "");
            output.addObject("NEXT_ODATE", CommonUtil.toNextDate());
        }

        return output;
    }

    public ModelAndView ez004_w_04(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);

        paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
        paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));

        String doc_gb = CommonUtil.isNull(paramMap.get("doc_gb"));
        logger.debug("=============================================================" + doc_gb + "=================================================================================");
        String doc_cd = CommonUtil.isNull(paramMap.get("doc_cd"));
        logger.debug("=============================================================" + doc_cd + "=================================================================================");
        String task_type = CommonUtil.isNull(paramMap.get("task_type"));
        logger.debug("=============================================================" + task_type + "=================================================================================");
        String strJobGubun = CommonUtil.isNull(paramMap.get("job_gubun"));
        logger.debug("=============================================================" + strJobGubun + "=================================================================================");
        String strJobName = CommonUtil.isNull(paramMap.get("job_name"));
        logger.debug("=============================================================" + strJobName + "=================================================================================");
        String strTable_id = CommonUtil.isNull(paramMap.get("table_id"));
        logger.debug("=============================================================" + strTable_id + "=================================================================================");
        String strJobId = CommonUtil.isNull(paramMap.get("job_id"));
        logger.debug("=============================================================" + strJobId + "=================================================================================");
        String strApplication = CommonUtil.isNull(paramMap.get("application"));
        logger.debug("=============================================================" + strApplication + "=================================================================================");


        List sCodeList = null;
        List sMapperCodeList = null;
        List sBatchGradeList = null;
        List smsDefaultList = null;
        List mailDefaultList = null;

        List dataCenterCodeList = null;
        List susiTypeList = null;

        List resourceDefaultList = null;
        List variableDefaultList = null;

        List jobTypeGb = null;
        List jobSchedGb = null;
        List systemGb = null;

        // 관리자 즉시결재 유무 코드 추가
        List adminApprovalBtnList = null;

        paramMap.put("mcode_cd", "M80");
        adminApprovalBtnList = commonService.dGetsCodeList(paramMap);

        // 리소스 기본값 : M81
        paramMap.put("mcode_cd", "M81");
        resourceDefaultList = commonService.dGetsCodeList(paramMap);

        // 변수 기본값 : M82
        paramMap.put("mcode_cd", "M82");
        variableDefaultList = commonService.dGetsCodeList(paramMap);

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

        paramMap.put("mcode_cd", "M44");
        systemGb = commonService.dGetsCodeList(paramMap);

        //SMS 기본값 설정
        paramMap.put("mcode_cd", "M87");
        smsDefaultList = commonService.dGetsCodeList(paramMap);

        //MAIL 기본값 설정
        paramMap.put("mcode_cd", "M88");
        mailDefaultList = commonService.dGetsCodeList(paramMap);

        // 계정관리코드 : M2
        paramMap.put("mcode_cd", "M2");
        sCodeList = commonService.dGetsCodeList(paramMap);

        List odateList = CommonUtil.getCtmOdateList();
        int odate_cnt = odateList.size();

        ModelAndView output = null;
        //output = new ModelAndView("ezjobs/t/works/doc"+doc_gb+"_w_04");
        output = new ModelAndView("main_contents/doc" + doc_gb + "_w_04");

        paramMap.put("searchType", "dataCenterList");
        List dataCenterList = commonService.dGetSearchItemList(paramMap);

        String p_sched_table = CommonUtil.isNull(paramMap.get("sched_table")).replaceAll("&apos;", "");
        paramMap.put("p_sched_table", p_sched_table);
        Doc01Bean docBean = worksApprovalDocService.dGetJobModifyInfo(paramMap);

        paramMap.put("job_name", docBean.getJob_name());

        JobMapperBean jobMapperInfo = worksUserService.dGetJobMapperInfo(paramMap);

        paramMap.put("user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));
        output.addObject("cm", CommonUtil.getComScodeList(paramMap));

        // 선행 조건
        paramMap.put("gubun", "inCond_cm");
        output.addObject("inCond_cm", CommonUtil.getComScodeList(paramMap));
        output.addObject("smsDefaultList", smsDefaultList);
        output.addObject("mailDefaultList", mailDefaultList);

        output.addObject("cm", CommonUtil.getComScodeList(paramMap));
        output.addObject("IN_COND_PAREN_S", CommonUtil.getMessage("JOB.IN_COND_PAREN_S"));
        output.addObject("IN_COND_PAREN_E", CommonUtil.getMessage("JOB.IN_COND_PAREN_E"));
        output.addObject("IN_COND_DT", CommonUtil.getMessage("JOB.IN_CONDITION_DATE"));
        output.addObject("IN_COND_AND_OR", CommonUtil.getMessage("JOB.IN_CONDITION_AND_OR2"));
        output.addObject("OUT_COND_DT", CommonUtil.getMessage("JOB.OUT_CONDITION_DATE"));
        output.addObject("OUT_COND_EFFECT", CommonUtil.getMessage("JOB.OUT_CONDITION_EFFECT2"));

        List approvalLineList = null;
        paramMap.put("grp_nm", strApplication);
        List appGrpList = commonService.dGetAppGrp2List(paramMap);
        
        List databaseList= new ArrayList();
        String[] aTmpTa 	= null;
        String var_name = "";
        String var_value = "";
        
        if( null!=docBean.getT_set() && docBean.getT_set().trim().length()>0 && task_type.equals("Database") ){
        	aTmpTa = CommonUtil.E2K(docBean.getT_set()).split("[|]");
    		for(int t=0; null!=aTmpTa&&t<aTmpTa.length; t++ ){
    			String[] aTmpT1 = aTmpTa[t].split(",",2);
    			var_name	= aTmpT1[0];
    			var_value	= aTmpT1[1];
    			if(var_name.equals("DB-ACCOUNT")) {
    	        	paramMap.put("profile_name", var_value);
    	    		paramMap.put("searchType", "databaseList");
    	    		databaseList = commonService.dGetSearchItemList(paramMap);
            	}
    		}
        }

        // doc_gb가 01이면 배치등록정보에서 Define되어 있는 작업 복사
        if (doc_gb.equals("01")) {

            paramMap.put("doc_cd", "");
            List mainDocInfoList = worksApprovalDocService.dGetMainDocInfoList(paramMap);

//			output = new ModelAndView("ezjobs/t/works/doc"+doc_gb+"_m");
            output = new ModelAndView("main_contents/doc" + doc_gb + "_m");
            output.addObject("flag", "ref");
            output.addObject("doc01", docBean);
            output.addObject("appGrpList", appGrpList);
            output.addObject("mainDocInfoList", mainDocInfoList);
            output.addObject("cm", CommonUtil.getComScodeList(paramMap));
            output.addObject("resourceDefaultList", resourceDefaultList);
            output.addObject("variableDefaultList", variableDefaultList);
            output.addObject("smsDefaultList", smsDefaultList);
            output.addObject("mailDefaultList", mailDefaultList);


        } else if (doc_gb.equals("02")) {

            paramMap.put("doc_cd", "");
            List mainDocInfoList = worksApprovalDocService.dGetMainDocInfoList(paramMap);

            output = new ModelAndView("main_contents/doc" + doc_gb + "_m");
            output.addObject("flag", "ref");
            Doc02Bean doc02Bean = new Doc02Bean();
//			BeanUtils.copyProperties(docBean, doc02Bean);
            output.addObject("doc02", docBean);
            output.addObject("mainDocInfoList", mainDocInfoList);
            output.addObject("cm", CommonUtil.getComScodeList(paramMap));
            output.addObject("resourceDefaultList", resourceDefaultList);
            output.addObject("variableDefaultList", variableDefaultList);
            output.addObject("susiTypeList", susiTypeList);
            output.addObject("smsDefaultList", smsDefaultList);
            output.addObject("mailDefaultList", mailDefaultList);

        }

        //등록,긴급 복사시 MFT 추가
        if (task_type.equals("MFT")) {

            String[] aTmpT = null;
            List<CommonBean> beans = new ArrayList<CommonBean>();

            if (CommonUtil.isNull(docBean.getT_set()).length() > 0) {
                aTmpT = CommonUtil.E2K(docBean.getT_set()).split("[|]");
                for (int t = 0; null != aTmpT && t < aTmpT.length; t++) {
                    CommonBean bean = new CommonBean();
                    if (aTmpT[t].contains("FTP")) {
                        String[] aTmpT1 = aTmpT[t].split(",", 2);
                        bean.setVar_name(aTmpT1[0].replaceAll("FTP-", "FTP_"));
                        bean.setVar_value(aTmpT1[1]);
                        beans.add(bean);
                    }
                }
            }

            output.addObject("setvarList", beans);
        }

        // 스마트폴더 체크로직
        String strSmartTableNm = docBean.getTable_name();
        if (strSmartTableNm.indexOf('/') > -1) {
            strSmartTableNm = strSmartTableNm.substring(0, strSmartTableNm.indexOf("/"));
        }
        if ("01".equals(doc_gb) || "04".equals(doc_gb)) {
            paramMap.put("smart_table_nm", strSmartTableNm);
            CommonBean commonBean = commonService.dGetSmartTableChk(paramMap);
            if (commonBean.getTotal_count() > 0) {
            	paramMap.put("smart_table_id", CommonUtil.isNull(paramMap.get("table_id")));
                List subTableList = commonService.dGetSubTableList(paramMap);
                output.addObject("subTableList", subTableList);
                output.addObject("smart_yn", "Y");
            } else {
                output.addObject("smart_yn", "N");
            }
        }

        output.addObject("doc04", docBean);
//		output.addObject("approvalLineList",			approvalLineList);
        output.addObject("jobMapperInfo", jobMapperInfo);

        output.addObject("sCodeList", sCodeList);
        output.addObject("sMapperCodeList", sMapperCodeList);
        output.addObject("sBatchGradeList", sBatchGradeList);
        output.addObject("jobTypeGb", jobTypeGb);
        output.addObject("jobSchedGb", jobSchedGb);
        output.addObject("systemGb", systemGb);

        output.addObject("dataCenterList", dataCenterList);

        output.addObject("adminApprovalList", adminApprovalBtnList);

        output.addObject("data_center", CommonUtil.getComScodeList(paramMap));
        output.addObject("SERVER_MCODE_CD", CommonUtil.getMessage("COMCODE.SERVER.CODE"));
        output.addObject("IN_COND_PAREN_S", CommonUtil.getMessage("JOB.IN_COND_PAREN_S"));
        output.addObject("IN_COND_PAREN_E", CommonUtil.getMessage("JOB.IN_COND_PAREN_E"));
        output.addObject("IN_COND_DT", CommonUtil.getMessage("JOB.IN_CONDITION_DATE"));
        output.addObject("IN_COND_AND_OR", CommonUtil.getMessage("JOB.IN_CONDITION_AND_OR2"));
        output.addObject("OUT_COND_DT", CommonUtil.getMessage("JOB.OUT_CONDITION_DATE"));
        output.addObject("OUT_COND_EFFECT", CommonUtil.getMessage("JOB.OUT_CONDITION_EFFECT2"));
        output.addObject("DAYS_CAL", CommonUtil.getCTMcalenderList(paramMap));
        output.addObject("DATA_CENTER", CommonUtil.getComScodeList(paramMap));

        output.addObject("resourceDefaultList", resourceDefaultList);
        output.addObject("variableDefaultList", variableDefaultList);
        output.addObject("databaseList", databaseList);

        if (odate_cnt > 0) {
            for (int i = 0; i < odate_cnt; i++) {
                CommonBean bean = (CommonBean) odateList.get(0);
                String odate = bean.getView_odate().replaceAll("/", "");
                output.addObject("ODATE", odate);
                //output.addObject("active_net_name", CommonUtil.getCtmActiveNetName(paramMap));
            }
        } else {
            output.addObject("ODATE", "");
            output.addObject("active_net_name", "");
        }

        return output;
    }

    public ModelAndView ez004_w_07(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);

        paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
        paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));

        String doc_gb = CommonUtil.isNull(paramMap.get("doc_gb"));
        String task_type = CommonUtil.isNull(paramMap.get("task_type"));
        String strJobGubun = CommonUtil.isNull(paramMap.get("job_gubun"));

        List sCodeList = null;
        List sMapperCodeList = null;

        // 계정관리코드 : M2
        paramMap.put("mcode_cd", "M2");
        sCodeList = commonService.dGetsCodeList(paramMap);

        // 조치방법코드 : M5
        paramMap.put("mcode_cd", "M5");
        sMapperCodeList = commonService.dGetsCodeList(paramMap);

        ModelAndView output = null;
        output = new ModelAndView("ezjobs/t/works/doc02_m");

        paramMap.put("searchType", "dataCenterList");
        List dataCenterList = commonService.dGetSearchItemList(paramMap);

        Doc01Bean docBean = worksApprovalDocService.dGetJobModifyInfo(paramMap);

        paramMap.put("job_name", docBean.getJob_name());

        JobMapperBean jobMapperInfo = worksUserService.dGetJobMapperInfo(paramMap);

        paramMap.put("user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));

        Doc02Bean docBean2 = new Doc02Bean();

        CommonUtil.beanTobean(docBean, docBean2);

        paramMap.put("doc_cd", "");
        List mainDocInfoList = worksApprovalDocService.dGetMainDocInfoList(paramMap);

        output.addObject("doc02", docBean2);
        output.addObject("dataCenterList", dataCenterList);
        output.addObject("jobMapperInfo", jobMapperInfo);
        output.addObject("mainDocInfoList", mainDocInfoList);

        output.addObject("sCodeList", sCodeList);
        output.addObject("sMapperCodeList", sMapperCodeList);

        return output;
    }

    public ModelAndView ez004_w_08(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);

        paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
        paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));

        String doc_gb = CommonUtil.isNull(paramMap.get("doc_gb"));
        String task_type = CommonUtil.isNull(paramMap.get("task_type"));
        String strJobGubun = CommonUtil.isNull(paramMap.get("job_gubun"));

        List sCodeList = null;
        List sMapperCodeList = null;

        // 계정관리코드 : M2
        paramMap.put("mcode_cd", "M2");
        sCodeList = commonService.dGetsCodeList(paramMap);

        // 조치방법코드 : M5
        paramMap.put("mcode_cd", "M5");
        sMapperCodeList = commonService.dGetsCodeList(paramMap);

        ModelAndView output = null;
        output = new ModelAndView("ezjobs/t/works/doc01_m");

        paramMap.put("searchType", "dataCenterList");
        List dataCenterList = commonService.dGetSearchItemList(paramMap);

        Doc01Bean docBean = worksApprovalDocService.dGetJobModifyInfo(paramMap);

        paramMap.put("job_name", docBean.getJob_name());

        JobMapperBean jobMapperInfo = worksUserService.dGetJobMapperInfo(paramMap);

        paramMap.put("user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));

        List approvalLineList = null;

        approvalLineList = worksApprovalLineService.dGetApprovalLineList(paramMap);

        Doc01Bean docBean1 = new Doc01Bean();

        CommonUtil.beanTobean(docBean, docBean1);

        paramMap.put("doc_cd", "");
        List mainDocInfoList = worksApprovalDocService.dGetMainDocInfoList(paramMap);

        output.addObject("doc01", docBean1);
        output.addObject("dataCenterList", dataCenterList);
        output.addObject("approvalLineList", approvalLineList);
        output.addObject("jobMapperInfo", jobMapperInfo);
        output.addObject("mainDocInfoList", mainDocInfoList);

        output.addObject("sCodeList", sCodeList);
        output.addObject("sMapperCodeList", sMapperCodeList);

        return output;
    }

    public ModelAndView ez004_m(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);

        paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
        paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));

        String strTaskType = CommonUtil.isNull(paramMap.get("task_type"));
        String strJobGubun = CommonUtil.isNull(paramMap.get("job_gubun"));
        String strJobName = CommonUtil.isNull(paramMap.get("job_name"));
        String strSmartTableNm = "";

        paramMap.put("job", strJobName);
        JobMapperBean jobMapperDocInfo = worksUserService.dGetJobMapperDocInfo(paramMap);

        // EZ_JOB_MAPPER_DOC에 넣기 전의 요청서를 수정할 경우 데이터가 없다.
        if (jobMapperDocInfo == null) {
            jobMapperDocInfo = worksUserService.dGetJobMapperInfo(paramMap);
        }

        String doc_gb = CommonUtil.isNull(paramMap.get("doc_gb"));
        String flag = CommonUtil.isNull(paramMap.get("flag"));

        paramMap.put("user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));

        List sCodeList = null;
        List sMapperCodeList = null;
        List sBatchGradeList = null;
        List dataCenterCodeList = null;
        List susiTypeList = null;
        List jobTypeGb = null;
        List jobSchedGb = null;
        List systemGb = null;
        List resourceDefaultList = null;
        List variableDefaultList = null;
        List managementServerList = null;
        List smsDefaultList = null;
        List mailDefaultList = null;
        List setvarList = null;

        // 관리자 즉시결재 유무 코드 추가
        List adminApprovalBtnList = null;

        paramMap.put("mcode_cd", "M80");
        adminApprovalBtnList = commonService.dGetsCodeList(paramMap);

        // 계정관리코드 : M2
        paramMap.put("mcode_cd", "M2");
        sCodeList = commonService.dGetsCodeList(paramMap);

        // 조치방법코드 : M5
        paramMap.put("mcode_cd", "M5");
        sMapperCodeList = commonService.dGetsCodeList(paramMap);

        paramMap.put("mcode_cd", "M9");
        sBatchGradeList = commonService.dGetsCodeList(paramMap);

        paramMap.put("mcode_cd", "M6");
        dataCenterCodeList = commonService.dGetsCodeList(paramMap);

        paramMap.put("mcode_cd", "M33");
        susiTypeList = commonService.dGetsCodeList(paramMap);

        paramMap.put("mcode_cd", "M42");
        jobTypeGb = commonService.dGetsCodeList(paramMap);

        paramMap.put("mcode_cd", "M43");
        jobSchedGb = commonService.dGetsCodeList(paramMap);

        paramMap.put("mcode_cd", "M44");
        systemGb = commonService.dGetsCodeList(paramMap);

        // 리소스 기본값 : M81
        paramMap.put("mcode_cd", "M81");
        resourceDefaultList = commonService.dGetsCodeList(paramMap);

        // 변수 기본값 : M82
        paramMap.put("mcode_cd", "M82");
        variableDefaultList = commonService.dGetsCodeList(paramMap);

        //SMS 기본값 설정
        paramMap.put("mcode_cd", "M87");
        smsDefaultList = commonService.dGetsCodeList(paramMap);

        //MAIL 기본값 설정
        paramMap.put("mcode_cd", "M88");
        mailDefaultList = commonService.dGetsCodeList(paramMap);

        // 참조수시요청서일 경우 수시요청서로 변환 TODO:이 로직 상태변경에서 걸리는 부분이 있는지 확인필요.
        if (doc_gb.equals("07")) {
            doc_gb = "02";
        }

        // 참조등록요청서일 경우 등록요청서로 변환
//		if ( doc_gb.equals("08") ) {
//			doc_gb = "01";
//		}

        List mainDocInfoList = worksApprovalDocService.dGetMainDocInfoList(paramMap);

        //setvar table 조회
        setvarList = commonService.dGetSetvarList(paramMap);

        ModelAndView output = null;

//		output = new ModelAndView("main_contents/doc" + doc_gb + "_m");

        //재반영 실패시 원본이 사라질 경우 복사하여 신규 등록을 진행할 수 있도록 로직 수정
        if ("04".equals(doc_gb) && flag.equals("ref")) {
            output = new ModelAndView("main_contents/doc01_m");
        } else {
            output = new ModelAndView("main_contents/doc" + doc_gb + "_m");
        }

//		output.addObject("approvalLineList", approvalLineList);		//작업의뢰시 결재선 보이지 않도록 수정(2020.05.12, 김수정)

        // 선행 조건
        paramMap.put("gubun", "inCond_cm");
        output.addObject("inCond_cm", CommonUtil.getComScodeList(paramMap));
        output.addObject("smsDefaultList", smsDefaultList);
        output.addObject("mailDefaultList", mailDefaultList);
        output.addObject("setvarList", setvarList);
        
        List databaseList= new ArrayList();
        
        for(int i=0;i<setvarList.size();i++) {
        	CommonBean bean = (CommonBean) setvarList.get(i);
        	if(CommonUtil.isNull(bean.getVar_name()).equals("%%DB-ACCOUNT")) {
	        	paramMap.put("profile_name", CommonUtil.isNull(bean.getVar_value()));
	    		paramMap.put("searchType", "databaseList");
	    		databaseList = commonService.dGetSearchItemList(paramMap);
        	}
        }
        
        output.addObject("databaseList", databaseList);
        
        if ("01".equals(doc_gb)) {

            Doc01Bean doc01Bean = worksApprovalDocService.dGetDoc01(paramMap);
            output.addObject("doc01", doc01Bean);

            paramMap.put("searchType", "dataCenterList");
            List dataCenterList = commonService.dGetSearchItemList(paramMap);

            List appGrpList = commonService.dGetAppGrp2List(paramMap);

            strSmartTableNm = doc01Bean.getTable_name();
            if (strSmartTableNm.indexOf('/') > -1) {
                strSmartTableNm = strSmartTableNm.substring(0, strSmartTableNm.indexOf("/"));
            }

            output.addObject("appGrpList", appGrpList);
            output.addObject("dataCenterList", dataCenterList);
            output.addObject("cm", CommonUtil.getComScodeList(paramMap));

        } else if ("02".equals(doc_gb)) {

            Doc01Bean doc02Bean = worksApprovalDocService.dGetDoc02(paramMap);
            output.addObject("doc02", doc02Bean);

            output.addObject("cm", CommonUtil.getComScodeList(paramMap));

            paramMap.put("searchType", "dataCenterList");
            List dataCenterList = commonService.dGetSearchItemList(paramMap);

            output.addObject("dataCenterList", dataCenterList);

        } else if ("03".equals(doc_gb)) {
            Doc03Bean doc03Bean = worksApprovalDocService.dGetDoc03(paramMap);
            output.addObject("doc03", doc03Bean);

        } else if ("04".equals(doc_gb)) {
            Doc01Bean doc04 = worksApprovalDocService.dGetDoc04(paramMap);

            strSmartTableNm = doc04.getTable_name();
            if (strSmartTableNm.indexOf('/') > -1) {
                strSmartTableNm = strSmartTableNm.substring(0, strSmartTableNm.indexOf("/"));
            }

            // 수정요청서를 참조기안 할 경우 table_id, job_id 등의 정보가 달라질 수 있으므로.
            if (flag.equals("ref")) {

//				Map<String, Object> refMap = CommonUtil.collectParameters(req);
//
//				refMap.put("job_name", doc04.getJob_name());
//				Doc01Bean doc01Bean = worksApprovalDocService.dGetDefJobInfo(refMap);
//
//				doc04.setTable_id(doc01Bean.getTable_id());
//				doc04.setJob_id(doc01Bean.getJob_id());
//				doc04.setBefore_application(doc01Bean.getApplication());
//				doc04.setBefore_group_name(doc01Bean.getGroup_name());
//				doc04.setBefore_table_name(doc01Bean.getTable_name());

                //재반영 실패시 원본이 사라질 경우 복사하여 신규 등록을 진행할 수 있도록 로직 수정
                List appGrpList = commonService.dGetAppGrp2List(paramMap);

                output.addObject("appGrpList", appGrpList);
                output.addObject("doc01", doc04);
                output.addObject("ref_yn", "Y");
            }

            output.addObject("doc04", doc04);

            paramMap.put("searchType", "dataCenterList");
            List dataCenterList = commonService.dGetSearchItemList(paramMap);

            output.addObject("dataCenterList", dataCenterList);
            output.addObject("cm", CommonUtil.getComScodeList(paramMap));

        } else if ("06".equals(doc_gb)) {

            output.addObject("doc06", worksApprovalDocService.dGetDoc06(paramMap));

            List doc06DetailList = worksApprovalDocService.dGetDoc06DetailList(paramMap);

            paramMap.put("searchType", "dataCenterList");
            List dataCenterList = commonService.dGetSearchItemList(paramMap);

            output.addObject("dataCenterList", dataCenterList);
            output.addObject("doc06DetailList", doc06DetailList);
        } else if ("08".equals(doc_gb)) {

            Doc01Bean docBean = worksApprovalDocService.dGetDoc04(paramMap);
            if (docBean == null) {
                docBean = worksApprovalDocService.dGetDoc01(paramMap);
            }
            output.addObject("doc01", docBean);

            List appGrpList = commonService.dGetAppGrp2List(paramMap);

            paramMap.put("searchType", "dataCenterList");
            List dataCenterList = commonService.dGetSearchItemList(paramMap);
            output.addObject("appGrpList", appGrpList);
            output.addObject("dataCenterList", dataCenterList);
        }

        // 수정/삭제 작업이 그룹에 매핑되어 있나 확인하는 로직(김선중)
        if ("03".equals(doc_gb) || "04".equals(doc_gb)) {
            String data_center = CommonUtil.isNull(paramMap.get("data_center"));
            if (data_center.indexOf(",") > -1) {
                data_center = data_center.split(",")[1];
            }
            Map map2 = new HashMap();
            map2.put("SCHEMA", CommonUtil.isNull(paramMap.get("SCHEMA")));
            map2.put("data_center", data_center);
            map2.put("job_name", CommonUtil.isNull(paramMap.get("job_name")));

            CommonBean ChkBean = worksApprovalDocService.dGetChkGroupJobCnt(map2);
            if (ChkBean.getTotal_count() > 0) {
                output.addObject("grpJobChk", "Y");
            } else {
                output.addObject("grpJobChk", "N");
            }
        }
        if ("09".equals(doc_gb)) {
            Doc01Bean docBean = worksApprovalDocService.dGetGroupDocInfo(paramMap);

            output.addObject("doc01", docBean);
        }

        // 스마트폴더 체크로직
        if ("01".equals(doc_gb) || "04".equals(doc_gb)) {
            paramMap.put("smart_table_nm", strSmartTableNm);
            CommonBean commonBean = commonService.dGetSmartTableChk(paramMap);
            if (commonBean.getTotal_count() > 0) {
            	paramMap.put("smart_table_id", CommonUtil.isNull(paramMap.get("table_id")));
                List subTableList = commonService.dGetSubTableList(paramMap);
                output.addObject("subTableList", subTableList);
                output.addObject("smart_yn", "Y");
            } else {
                output.addObject("smart_yn", "N");
            }
        }

        output.addObject("data_center", CommonUtil.getComScodeList(paramMap));
        output.addObject("SERVER_MCODE_CD", CommonUtil.getMessage("COMCODE.SERVER.CODE"));
        output.addObject("IN_COND_PAREN_S", CommonUtil.getMessage("JOB.IN_COND_PAREN_S"));
        output.addObject("IN_COND_PAREN_E", CommonUtil.getMessage("JOB.IN_COND_PAREN_E"));
        output.addObject("IN_COND_DT", CommonUtil.getMessage("JOB.IN_CONDITION_DATE"));
        output.addObject("IN_COND_AND_OR", CommonUtil.getMessage("JOB.IN_CONDITION_AND_OR2"));
        output.addObject("OUT_COND_DT", CommonUtil.getMessage("JOB.OUT_CONDITION_DATE"));
        output.addObject("OUT_COND_EFFECT", CommonUtil.getMessage("JOB.OUT_CONDITION_EFFECT2"));
        output.addObject("jobMapperInfo", jobMapperDocInfo);
        output.addObject("adminApprovalBtnList", adminApprovalBtnList);
        output.addObject("resourceDefaultList", resourceDefaultList);
        output.addObject("variableDefaultList", variableDefaultList);

        output.addObject("sCodeList", sCodeList);
        output.addObject("sMapperCodeList", sMapperCodeList);
        output.addObject("sBatchGradeList", sBatchGradeList);
        output.addObject("dataCenterCodeList", dataCenterCodeList);
        output.addObject("susiTypeList", susiTypeList);
        output.addObject("jobTypeGb", jobTypeGb);
        output.addObject("jobSchedGb", jobSchedGb);
        output.addObject("systemGb", systemGb);

        return output;
    }

    public ModelAndView ez004_p(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);

        paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
        paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
        paramMap.put("s_user_id", CommonUtil.isNull(req.getSession().getAttribute("USER_ID")));
        paramMap.put("s_user_nm", CommonUtil.isNull(req.getSession().getAttribute("USER_NM")));
        paramMap.put("s_user_gb", CommonUtil.isNull(req.getSession().getAttribute("USER_GB")));
        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));

        Map<String, Object> rMap = new HashMap<String, Object>();

        String doc_gb = CommonUtil.isNull(paramMap.get("doc_gb"));
        String flag = CommonUtil.isNull(paramMap.get("flag"));
        String act_gb = CommonUtil.isNull(paramMap.get("act_gb"));
        String doc_cd = CommonUtil.isNull(paramMap.get("doc_cd"));
        String data_center = CommonUtil.isNull(paramMap.get("data_center"));
        String application = CommonUtil.isNull(paramMap.get("application"));
        String table_name = CommonUtil.isNull(paramMap.get("table_name"));
        String task_type = CommonUtil.isNull(paramMap.get("task_type"));
        String odate = CommonUtil.isNull(paramMap.get("odate"));

		List sCodeList = null;
		List sMapperCodeList = null;
		List resourceDefaultList = null;
		List variableDefaultList = null;
		
		logger.info(" ez004_p ParamMap : " + paramMap);
		
        try {
            // 수정, 삭제, 승인 등을 진행할 수 있는 상태인 지 체크. (2023.05.28 강명준)
            // 최초 저장은 doc_cd 가 없으므로 체크할 수 있는게 없다.
            if (!doc_cd.equals("")) {
                String strApprovalMessage = CommonUtil.getStatusApprovalCheck(paramMap);

                if (!strApprovalMessage.equals("")) {

                    Map rMap2 = new HashMap();
                    rMap2.put("r_code", "-1");
                    rMap2.put("r_msg", strApprovalMessage);
                    rMap2.put("rMsg", strApprovalMessage);    // 일괄 결재 시 rMsg로 설정해야 정상적으로 오류 출력
                    throw new DefaultServiceException(rMap2);
                }
            }

            rMap.put("doc_gb", doc_gb);

            // 리소스 기본값 : M81
            paramMap.put("mcode_cd", "M81");
            resourceDefaultList = commonService.dGetsCodeList(paramMap);

            // 변수 기본값 : M82
            paramMap.put("mcode_cd", "M82");
            variableDefaultList = commonService.dGetsCodeList(paramMap);

            paramMap.put("mcode_cd", "M2");
            sCodeList = commonService.dGetsCodeList(paramMap);

            String file_nm = "";
            String file_path = "";
            String save_file_nm = "";
            String err_file_nm = "";
            String r_doc_cd = "";

            if (doc_gb == "06") {
                file_nm = CommonUtil.isNull(paramMap.get("file_nm"));
                file_path = req.getRealPath(CommonUtil.getMessage("MENUAL_FILE.PATH") + "excel_tmp");
                save_file_nm = CommonUtil.isNull(paramMap.get("file_nm"));
            } else {
                file_nm = CommonUtil.isNull(paramMap.get("file_nm"));
                file_path = req.getRealPath(CommonUtil.getMessage("MENUAL_FILE.PATH") + "attach_file");
            }

            if ("01".equals(doc_gb) || "02".equals(doc_gb) || "03".equals(doc_gb) || "04".equals(doc_gb) || "09".equals(doc_gb)) {

                if ("draft_admin".equals(flag)) {

                    rMap = worksApprovalDocService.dPrcDocAdmin(paramMap);

                } else if ("del".equals(flag)) {

                    rMap = worksApprovalDocService.dPrcDocApprovalFlagUpdate(paramMap);

                } else {
                    rMap = worksApprovalDocService.dPrcDoc(paramMap);

                    // rMap 에 작업명 저장 (2023.04.03 강명준 : 수정요청서 저장 후 바로 수정 페이지로 이동할 때 필요)
                    rMap.put("job_name", CommonUtil.isNull(paramMap.get("job_name")));
                }

            } else if ("05".equals(doc_gb) || "07".equals(doc_gb)) {

                if ("del".equals(flag)) {
                    rMap = worksApprovalDocService.dPrcDocApprovalFlagUpdate(paramMap);
                }

            } else if ("06".equals(doc_gb)) {

                if ("draft_admin".equals(flag)) {

                    rMap = worksApprovalDocService.dPrcDoc06Admin(paramMap);

                } else if ("temp_ins".equals(flag)) {

                    paramMap.put("s_dept_cd", CommonUtil.isNull(req.getSession().getAttribute("DEPT_CD")));
                    paramMap.put("s_user_gb", CommonUtil.isNull(req.getSession().getAttribute("USER_GB")));
                    paramMap.put("resourceDefaultList", resourceDefaultList);
                    paramMap.put("variableDefaultList", variableDefaultList);

                    rMap = worksApprovalDocService.dPrcDoc06(paramMap);

                } else if ("del".equals(flag)) {

                    rMap = worksApprovalDocService.dPrcDocApprovalFlagUpdate(paramMap);

                } else {

                    rMap = worksApprovalDocService.dPrcDoc06(paramMap);
                }
            }

        } catch (DefaultServiceException e) {

            rMap = e.getResultMap();

            //작업수정 -> 등록 실패시 그룹잡일 경우 예외처리.
//			if(CommonUtil.isNull(rMap.get("doc_gb")).equals("04")) {
//
//				rMap.put("flag", "update_job_id");
//				rMap = worksApprovalDocService.dPrcJobGroup(rMap);
//			}

            if ("-2".equals(CommonUtil.isNull(rMap.get("r_code")))) {
                logger.error(CommonUtil.isNull(rMap.get("r_msg")));
            } else {
                logger.error(e.getMessage());
            }
            logger.error("ez004_p_rMap : " + rMap);

            //오류메세지 처리
            String r_msg = CommonUtil.getMessage(CommonUtil.isNull(rMap.get("r_msg")));
            if (r_msg.equals("")) {
                r_msg = CommonUtil.isNull(rMap.get("r_msg"));
            }
            logger.info("r_msg Result : " + r_msg);
            rMap.put("r_msg", r_msg);

        } catch (Exception e) {
            if ("".equals(CommonUtil.isNull(rMap.get("r_code")))) rMap.put("r_code", "-1");
            if ("".equals(CommonUtil.isNull(rMap.get("r_msg")))) rMap.put("r_msg", "ERROR.01");

            logger.error(e.getMessage());
            logger.error("ez004_p", e);
            logger.error("ez004_p_rMap : " + rMap);
        } finally {

            // 승인 요청은 그룹의 메인으로 결재자 알림 발송
            String sendApprovalNoti = CommonUtil.isNull(rMap.get("sendApprovalNoti"));
            if (sendApprovalNoti.equals("Y")) {
                int iSendResult = CommonUtil.sendApprovalNoti(CommonUtil.isNull(rMap.get("r_doc_cd"), doc_gb));
                logger.info("sendApprovalNoti Result : " + iSendResult);
            }

            String sendInsUserNoti = CommonUtil.isNull(rMap.get("sendInsUserNoti"));
            if (sendInsUserNoti.equals("Y")) {
                int iSendResult = CommonUtil.sendInsUserNoti(CommonUtil.isNull(rMap.get("r_doc_cd"), doc_gb));
                logger.info("sendInsUserNoti Result : " + iSendResult);
            }
        }

        ModelAndView output = null;

        output = new ModelAndView("result/t_result");
        output.addObject("rMap", rMap);

        output.addObject("sCodeList", sCodeList);
        output.addObject("sMapperCodeList", sMapperCodeList);

        return output;

    }

    @SuppressWarnings("unchecked")
    public ModelAndView ez005(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);

        paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
        paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));
        paramMap.put("s_doc_gb", CommonUtil.getMessage("s_doc_gb"));

        ModelAndView output = null;
        output = new ModelAndView("works/C03/main_contents/approvalDocInfoList");
        output.addObject("STRT_DT", CommonUtil.getCurDateTo(CommonUtil.getCurDate(""), -7));
        output.addObject("END_DT", CommonUtil.getCurDateTo(CommonUtil.getCurDate(""), 0));
        output.addObject("cm", CommonUtil.getComScodeList(paramMap));
        output.addObject("paramMap", paramMap);

        return output;
    }

    public ModelAndView ez005_excel(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);
        paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
        paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));

        List approvalDocInfoList = worksApprovalDocService.dGetApprovalDocInfoList(paramMap);

        ModelAndView output = null;
        output = new ModelAndView("contents/approvalDocInfoListExcel");

        output.addObject("approvalDocInfoList", approvalDocInfoList);

        return output;
    }

    //결재문서조회화면
    public ModelAndView ez006(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);

        paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
        paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));

        String doc_gb = CommonUtil.isNull(paramMap.get("doc_gb"));
        String approval_cd = CommonUtil.isNull(paramMap.get("approval_cd"));
        String doc_group_id = CommonUtil.isNull(paramMap.get("doc_group_id"));
        String main_doc_cd = CommonUtil.isNull(paramMap.get("main_doc_cd"));
        String popup_yn = CommonUtil.isNull(paramMap.get("popup_yn"));
        String doc_cnt = CommonUtil.isNull(paramMap.get("doc_cnt"));

        String strTaskType = CommonUtil.isNull(paramMap.get("task_type"));
        String strJobGubun = CommonUtil.isNull(paramMap.get("job_gubun"));
        String strApplyFailCnt = CommonUtil.isNull(paramMap.get("apply_fail_cnt"));

        paramMap.put("user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
        paramMap.put("main_doc_cd", main_doc_cd);

        List sBatchGradeList = null;
        List smsDefaultList = null;
        List mailDefaultList = null;
        List setvarList = null;

        //운영즉시결재노출 코드 가져올 수 있게 추가 (2023.06.21 최호연)
        List adminApprovalBtnList = null;
        paramMap.put("mcode_cd", "M80");
        adminApprovalBtnList = commonService.dGetsCodeList(paramMap);

        // 작업등급 공통코드
        paramMap.put("mcode_cd", "M9");
        sBatchGradeList = commonService.dGetsCodeList(paramMap);

        //SMS 기본값 설정
        paramMap.put("mcode_cd", "M87");
        smsDefaultList = commonService.dGetsCodeList(paramMap);

        //MAIL 기본값 설정
        paramMap.put("mcode_cd", "M88");
        mailDefaultList = commonService.dGetsCodeList(paramMap);

        List approvalInfoList = worksApprovalDocService.dGetApprovalInfoList(paramMap);

        List mainDocInfoList = worksApprovalDocService.dGetMainDocInfoList(paramMap);

        CommonBean commonBean = worksApprovalDocService.dGetCurApprovalCnt(paramMap);
        System.out.println("strTaskType : " + strTaskType);
        //task_type이 kubernetes or mft인 경우 ez_doc_setvar 테이블 조회
        //if (strTaskType.equals("Kubernetes") || strTaskType.equals("MFT") || strTaskType.equals("Database")) {
            setvarList = commonService.dGetSetvarList(paramMap);
        //}

        String strCurApprovalSeq = "";
        String strCurApprovalGb = "";
        if (commonBean != null) {
            strCurApprovalSeq = CommonUtil.isNull(commonBean.getApproval_seq());
            strCurApprovalGb = CommonUtil.isNull(commonBean.getApproval_gb());
        }

        ModelAndView output = null;
//		output = new ModelAndView("ezjobs/t/works/doc"+doc_gb+"Approval");
        output = new ModelAndView("main_contents/doc" + doc_gb + "Approval");

        output.addObject("approvalInfoList", approvalInfoList);
        output.addObject("mainDocInfoList", mainDocInfoList);
        output.addObject("SERVER_MCODE_CD", CommonUtil.getMessage("COMCODE.SERVER.CODE"));
        output.addObject("IN_COND_PAREN_S", CommonUtil.getMessage("JOB.IN_COND_PAREN_S"));
        output.addObject("IN_COND_PAREN_E", CommonUtil.getMessage("JOB.IN_COND_PAREN_E"));
        output.addObject("IN_COND_DT", CommonUtil.getMessage("JOB.IN_CONDITION_DATE"));
        output.addObject("IN_COND_AND_OR", CommonUtil.getMessage("JOB.IN_CONDITION_AND_OR2"));
        output.addObject("OUT_COND_DT", CommonUtil.getMessage("JOB.OUT_CONDITION_DATE"));
        output.addObject("OUT_COND_EFFECT", CommonUtil.getMessage("JOB.OUT_CONDITION_EFFECT2"));
        output.addObject("cur_approval_seq", strCurApprovalSeq);
        output.addObject("cur_approval_gb", strCurApprovalGb);
        output.addObject("adminApprovalBtnList", adminApprovalBtnList);
        output.addObject("applyFailCnt", strApplyFailCnt);
        output.addObject("smsDefaultList", smsDefaultList);
        output.addObject("mailDefaultList", mailDefaultList);
        output.addObject("setvarList", setvarList);
        List databaseList= new ArrayList();
        
        for(int i=0;i<setvarList.size();i++) {
        	CommonBean bean = (CommonBean) setvarList.get(i);
        	if(CommonUtil.isNull(bean.getVar_name()).equals("%%DB-ACCOUNT")) {
	        	paramMap.put("profile_name", CommonUtil.isNull(bean.getVar_value()));
	    		paramMap.put("searchType", "databaseList");
	    		databaseList = commonService.dGetSearchItemList(paramMap);
        	}
        }
        
        output.addObject("databaseList", databaseList);

        if ("01".equals(doc_gb)) {

            Doc01Bean doc01Bean = worksApprovalDocService.dGetDoc01(paramMap);
            output.addObject("doc01", doc01Bean);

            Map<String, Object> map = new HashMap<String, Object>();

            map.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));
            map.put("data_center", doc01Bean.getData_center());
            map.put("table_name", doc01Bean.getTable_name());
            map.put("job_name", doc01Bean.getJob_name());

            paramMap.put("data_center", worksApprovalDocService.dGetDoc01(paramMap).getData_center());
            paramMap.put("job_name", worksApprovalDocService.dGetDoc01(paramMap).getJob_name());

            paramMap.put("job", worksApprovalDocService.dGetDoc01(paramMap).getJob_name());
            JobMapperBean jobMapperDocInfo = worksUserService.dGetJobMapperDocInfo(paramMap);

            // EZ_JOB_MAPPER_DOC에 넣기 전의 요청서를 수정할 경우 데이터가 없다.
            if (jobMapperDocInfo == null) {
                jobMapperDocInfo = worksUserService.dGetJobMapperInfo(paramMap);
            }

            output.addObject("jobMapperInfo", jobMapperDocInfo);
            output.addObject("adminApprovalBtnList", adminApprovalBtnList);

        } else if ("02".equals(doc_gb)) {
            Doc01Bean doc02Bean = worksApprovalDocService.dGetDoc02(paramMap);
            output.addObject("doc02", doc02Bean);

            Map<String, Object> map = new HashMap<String, Object>();

            map.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));

            map.put("data_center", doc02Bean.getData_center());
            map.put("table_name", doc02Bean.getTable_name());
            map.put("job_name", doc02Bean.getJob_name());

            paramMap.put("data_center", worksApprovalDocService.dGetDoc02(paramMap).getData_center());
            paramMap.put("job_name", worksApprovalDocService.dGetDoc02(paramMap).getJob_name());

            paramMap.put("job", worksApprovalDocService.dGetDoc02(paramMap).getJob_name());
            JobMapperBean jobMapperDocInfo = worksUserService.dGetJobMapperDocInfo(paramMap);

            // EZ_JOB_MAPPER_DOC에 넣기 전의 요청서를 수정할 경우 데이터가 없다.
            if (jobMapperDocInfo == null) {
                jobMapperDocInfo = worksUserService.dGetJobMapperInfo(paramMap);
            }

            output.addObject("jobMapperInfo", jobMapperDocInfo);
            output.addObject("adminApprovalBtnList", adminApprovalBtnList);

        } else if ("03".equals(doc_gb)) {

            Map<String, Object> map = new HashMap<String, Object>();

            map.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));

            output.addObject("doc03", worksApprovalDocService.dGetDoc03(paramMap));

            paramMap.put("data_center", worksApprovalDocService.dGetDoc03(paramMap).getData_center());
            paramMap.put("job_name", worksApprovalDocService.dGetDoc03(paramMap).getJob_name());

            paramMap.put("job", worksApprovalDocService.dGetDoc03(paramMap).getJob_name());
            JobMapperBean jobMapperDocInfo = worksUserService.dGetJobMapperDocInfo(paramMap);

            // EZ_JOB_MAPPER_DOC에 넣기 전의 요청서를 수정할 경우 데이터가 없다.
            if (jobMapperDocInfo == null) {
                jobMapperDocInfo = worksUserService.dGetJobMapperInfo(paramMap);
            }

            output.addObject("jobMapperInfo", jobMapperDocInfo);
            output.addObject("adminApprovalBtnList", adminApprovalBtnList);


        } else if ("04".equals(doc_gb)) {
            Doc01Bean doc01Bean = worksApprovalDocService.dGetDoc04(paramMap);
            output.addObject("doc04", doc01Bean);
            Map<String, Object> map = new HashMap<String, Object>();
            map.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));
            map.put("data_center", doc01Bean.getData_center());
            map.put("table_name", doc01Bean.getTable_name());
            map.put("job_name", doc01Bean.getJob_name());

            paramMap.put("data_center", worksApprovalDocService.dGetDoc04(paramMap).getData_center());
            paramMap.put("job_name", worksApprovalDocService.dGetDoc04(paramMap).getJob_name());

            paramMap.put("job", worksApprovalDocService.dGetDoc04(paramMap).getJob_name());
            JobMapperBean jobMapperDocInfo = worksUserService.dGetJobMapperDocInfo(paramMap);

            // EZ_JOB_MAPPER_DOC에 넣기 전의 요청서를 수정할 경우 데이터가 없다.
            if (jobMapperDocInfo == null) {
                jobMapperDocInfo = worksUserService.dGetJobMapperInfo(paramMap);
            }

            output.addObject("jobMapperInfo", jobMapperDocInfo);
            output.addObject("adminApprovalBtnList", adminApprovalBtnList);

        } else if ("05".equals(doc_gb)) {

            Doc05Bean doc05 = null;

            // 단건 ORDER 조회.
            if (doc_cnt.equals("0")) {
                doc05 = worksApprovalDocService.dGetDoc05(paramMap);

                // 그룹 ORDER 조회.
            } else {
                doc05 = worksApprovalDocService.dGetGroupDoc05(paramMap);

                // doc_group_id 로 그룹아이디 가져오기.
                JobGroupBean jobGroupBean = worksApprovalDocService.dGetJobGroupId(paramMap);

                paramMap.put("jobgroup_id", jobGroupBean.getJobgroup_id());

                jobGroupBean = worksApprovalDocService.dGetJobGroupDetail(paramMap);

                CommonBean bean = worksApprovalDocService.dGetJobGroupDetailListCnt(paramMap);

                List jobGroupDetailList = worksApprovalDocService.dGetJobGroupDetailList(paramMap);

                output.addObject("jobGroupBean", jobGroupBean);
                output.addObject("jobGroupDetailList", jobGroupDetailList);
                output.addObject("totalCount", bean.getTotal_count());
                output.addObject("adminApprovalBtnList", adminApprovalBtnList);
            }

            output.addObject("doc05", doc05);
            output.addObject("adminApprovalBtnList", adminApprovalBtnList);

            String strDataCenter = "";
            String strJobName = "";

            if (doc05 != null) {

                strDataCenter = CommonUtil.isNull(doc05.getData_center(), "");
                strJobName = CommonUtil.isNull(doc05.getJob_name(), "");
            }

            paramMap.put("data_center", strDataCenter);
            paramMap.put("job_name", strJobName);

		} if ("06".equals(doc_gb)) {

            output.addObject("doc06", worksApprovalDocService.dGetDoc06(paramMap));

            List doc06DetailList = worksApprovalDocService.dGetDoc06DetailList(paramMap);
            output.addObject("doc06DetailList", doc06DetailList);
            output.addObject("adminApprovalBtnList", adminApprovalBtnList);

            paramMap.put("data_center", "");
            paramMap.put("job_name", "");

        } else if ("07".equals(doc_gb)) {

            Doc07Bean doc07Bean = worksApprovalDocService.dGetDoc07(paramMap);
            output.addObject("doc07", doc07Bean);
            output.addObject("adminApprovalBtnList", adminApprovalBtnList);

        } else if ("08".equals(doc_gb)) {

            Doc08Bean doc08Bean = worksApprovalDocService.dGetDoc08(paramMap);
            output.addObject("doc08", doc08Bean);
            output.addObject("adminApprovalBtnList", adminApprovalBtnList);

        } else if ("09".equals(doc_gb)) {

            Doc01Bean doc01 = null;

            doc01 = worksApprovalDocService.dGetGroupDocInfo(paramMap);

            output.addObject("doc01", doc01);
            output.addObject("adminApprovalBtnList", adminApprovalBtnList);

            String strDataCenter = "";
            String strJobName = "";

            if (doc01 != null) {

                strDataCenter = CommonUtil.isNull(doc01.getData_center(), "");
                strJobName = CommonUtil.isNull(doc01.getJob_name(), "");
            }

            paramMap.put("data_center", strDataCenter);
            paramMap.put("job_name", strJobName);

        } else if ("10".equals(doc_gb)) {

            Doc01Bean doc01Bean = worksApprovalDocService.dGetDoc10(paramMap);
            output.addObject("doc10", doc01Bean);
            output.addObject("adminApprovalBtnList", adminApprovalBtnList);

        }

        output.addObject("sBatchGradeList", sBatchGradeList);
        output.addObject("adminApprovalBtnList", adminApprovalBtnList);

        return output;
    }

    // approval 화면에서  결재.
    public ModelAndView ez006_p(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);

        Map<String, Object> rMap = new HashMap<String, Object>();
        Map<String, Object> aMap = new HashMap<String, Object>();

        paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
        paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));

        String strDoc_gb = CommonUtil.isNull(paramMap.get("doc_gb"));
        String strDocCd = CommonUtil.isNull(paramMap.get("doc_cd"));

        try {

            // 중복 결재 방지를 위해 필드 업데이트.
            aMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));
            aMap.put("flag", "approval_start");
            aMap.put("doc_cd", strDocCd);

            worksApprovalDocService.dPrcDocApprovalFlagUpdate(aMap);

            //CommonBean commonBean = worksApprovalDocService.dGetDocApprovalStartCnt(paramMap);
            //이미 결재중인 문서 체크로직('AA'일 경우 error메세지 노출)
            CommonBean commonBean = worksApprovalDocService.dGetDocApprovalStartChk(paramMap);

            if (commonBean.getDoc_cd() != null) {
                Map errMap = new HashMap();
                errMap.put("r_code", "-1");
                errMap.put("r_msg", "ERROR.49");

                throw new DefaultServiceException(errMap);
            }

            rMap = worksApprovalDocService.dPrcDocApproval(paramMap);

        } catch (DefaultServiceException e) {

            rMap = e.getResultMap();

            if ("-2".equals(CommonUtil.isNull(rMap.get("r_code")))) {
                logger.error(CommonUtil.isNull(rMap.get("r_msg")));
            } else {
                logger.error(e.getMessage());
            }

            //오류메세지 처리
            String r_msg = CommonUtil.getMessage(CommonUtil.isNull(rMap.get("r_msg")));
            if (r_msg.equals("")) {
                r_msg = CommonUtil.isNull(rMap.get("r_msg"));
            }
            logger.info("r_msg Result : " + r_msg);
            rMap.put("r_msg", r_msg);

        } catch (Exception e) {

            if ("".equals(CommonUtil.isNull(rMap.get("r_code"))))
                rMap.put("r_code", "-1");
            if ("".equals(CommonUtil.isNull(rMap.get("r_msg"))))
                rMap.put("r_msg", "ERROR.01");

            logger.error(e.getMessage());

            //오류메세지 처리
            String r_msg = CommonUtil.getMessage(CommonUtil.isNull(rMap.get("r_msg")));
            if (r_msg.equals("")) {
                r_msg = CommonUtil.isNull(rMap.get("r_msg"));
            }
            logger.info("r_msg22 Result : " + r_msg);
            rMap.put("r_msg", r_msg);
        } finally {

            // 중복 결재 방지를 위해 필드 업데이트.
            aMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));
            aMap.put("flag", "approval_end");
            aMap.put("doc_cd", strDocCd);

            worksApprovalDocService.dPrcDocApprovalFlagUpdate(aMap);

            logger.error("::::::::::r_state_cd:::::::::" + rMap);
            // 승인 요청은 그룹의 메인으로 결재자 알림 발송
            String sendApprovalNoti = CommonUtil.isNull(rMap.get("sendApprovalNoti"));
            if (sendApprovalNoti.equals("Y")) {
                int iSendResult = CommonUtil.sendApprovalNoti(strDocCd);
                logger.info("sendApprovalNoti Result : " + iSendResult);
            }

            // 승인 요청 시 반영이 된 경우 그룹의 메인으로 의뢰자 반영완료 알림 발송
            String sendInsUserNoti = CommonUtil.isNull(rMap.get("sendInsUserNoti"));
            if (sendInsUserNoti.equals("Y")) {
                int iSendResult = CommonUtil.sendInsUserNoti(strDocCd);

                logger.info("sendInsUserNoti Result : " + iSendResult);
            }
        }

        ModelAndView output = null;
        output = new ModelAndView("result/t_result");
        output.addObject("rMap", rMap);

        return output;

    }

    // approval 화면에서 상태변경.
    public ModelAndView ez006_state_update(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);

        paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
        paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));

        String currentPage = CommonUtil.isNull(paramMap.get("currentPage"));
        String approval_comment = CommonUtil.isNull(paramMap.get("inputString"));

        //결제 화면에서 반려 메시지를 담은 값

        System.out.println("approval_comment" + approval_comment);

        paramMap.put(approval_comment, approval_comment);


        Map<String, Object> rMap = new HashMap<String, Object>();

        try {
            //paramMap.put("userToken", CommonUtil.isNull(req.getSession().getAttribute("USER_TOKEN")));


            rMap = worksApprovalDocService.dPrcDocApprovalStateUpdate(paramMap);

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
//			output = new ModelAndView("ezjobs/t/result");
        output = new ModelAndView("result/t_result");
        output.addObject("rMap", rMap);

        return output;

    }

    // ORDER approval 화면에서 그룹 결재. (그룹이 아닌 단건 ORDER는 기존의 ez006_p를 탄다.)
    public ModelAndView ez006_order_p(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);

        paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
        paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));

        String currentPage = CommonUtil.isNull(paramMap.get("currentPage"));

        Map<String, Object> rMap = new HashMap<String, Object>();
        Map<String, Object> rMap2 = new HashMap<String, Object>();
        Map<String, Object> rMap3 = new HashMap<String, Object>();
        Map<String, Object> aMap = new HashMap<String, Object>();

        StringBuffer result_sb = new StringBuffer();

        int success = 0;
        String strDocCd = CommonUtil.isNull(paramMap.get("doc_cd"));
        String strDocGb = CommonUtil.isNull(paramMap.get("doc_gb"));
        String strDocCnt = CommonUtil.isNull(paramMap.get("doc_cnt"));
        String strFlag = CommonUtil.isNull(paramMap.get("flag"));
        String strApprovalDupError = "";

        try {

            // 중복 결재 방지를 위해 필드 업데이트.
            aMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));
            aMap.put("data_center", paramMap.get("data_center"));
            aMap.put("flag", "approval_start");
            aMap.put("doc_cd", strDocCd);
            worksApprovalDocService.dPrcDocApprovalFlagUpdate(aMap);

            //CommonBean commonBean = worksApprovalDocService.dGetDocApprovalStartCnt(paramMap);
            //이미 결재중인 문서 체크로직('AA'일 경우 error메세지 노출) / 결재가 아닌 삭제/승인취소 일 경우는 태우지않음
            if (strFlag.equals("approval")) {
                CommonBean commonBean = worksApprovalDocService.dGetDocApprovalStartChk(paramMap);
                if (commonBean.getDoc_cd() != null) {
                    Map errMap = new HashMap();
                    errMap.put("r_code", "-1");
                    errMap.put("r_msg", "ERROR.49");

                    // finally 에서 중복 결재 플래그만 원복하기 위해. (2023.12.04 강명준)
                    strApprovalDupError = "Y";

                    throw new DefaultServiceException(errMap);
                }

                // 이미 결재 처리되었는지를 프로시저 외 컨트롤러에서도 체크
                // 일단 그룹수시작업의뢰 시 결재차수 체크하면서 반영완료된 건을 다시 반영실패로 업데이트 해버리는 현상 있음 (2023.12.04 강명준)
                CommonBean alreadyCntBean = worksApprovalDocService.dGetDocApprovalAlreadyCnt(paramMap);

                if (alreadyCntBean.getTotal_count() >= 1) {
                    Map errMap = new HashMap();
                    errMap.put("r_code", "-1");
                    errMap.put("r_msg", "ERROR.49");

                    // finally 에서 중복 결재 플래그만 원복하기 위해. (2023.12.04 강명준)
                    strApprovalDupError = "Y";

                    throw new DefaultServiceException(errMap);
                }

            }

            try {
                if ("del".equals(strFlag) || "def_cancel".equals(strFlag)) {

                    Map Map = new HashMap();

                    Map.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));
                    Map.put("flag", strFlag);
                    Map.put("doc_cd", strDocCd);
                    Map.put("doc_gb", strDocGb);

                    //메인문서일 경우 문서 내 처리 해준다??
                    List mainDocInfoList = worksApprovalDocService.dGetMainDocInfoList(Map);

                    if (mainDocInfoList.size() == 0) {
                        rMap = worksApprovalDocService.dPrcDocApprovalFlagUpdate(Map);
                    } else {
                        rMap = worksApprovalDocService.dPrcDocApprovalFlagUpdate(Map);

                        for (int j = 0; j < mainDocInfoList.size(); j++) {

                            DocInfoBean docInfo = (DocInfoBean) mainDocInfoList.get(j);
                            String doc_cd = CommonUtil.isNull(docInfo.getDoc_cd());
                            String doc_gb = CommonUtil.isNull(docInfo.getDoc_gb());

                            Map.put("doc_cd", doc_cd);
                            Map.put("doc_gb", doc_gb);
                            Map.put("flag", "def_cancel");
                            rMap = worksApprovalDocService.dPrcDocApprovalFlagUpdate(Map);
                        }

                    }
                } else {
                    rMap = worksApprovalDocService.dPrcDocApproval(paramMap);
                }

            } catch (DefaultServiceException e) {

                rMap = e.getResultMap();

                String r_msg = CommonUtil.getMessage(CommonUtil.isNull(rMap.get("r_msg")));
                if (r_msg.equals("")) {
                    r_msg = CommonUtil.isNull(rMap.get("r_msg"));
                }

                result_sb.append(strDocCd + " : " + r_msg);
                result_sb.append("\\n");

                // 에러가 난 작업은 반영상태: 실패로 찍어준다. (2023.07.10 강명준)
                rMap3.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));
                rMap3.put("flag", "group_order_exec_fail");
                rMap3.put("doc_cd", strDocCd);
                rMap3.put("approval_comment", r_msg);

                worksApprovalDocService.dPrcDocApprovalFlagUpdate(rMap3);
            }
        } catch (DefaultServiceException e) {

            rMap = e.getResultMap();

            if ("-2".equals(CommonUtil.isNull(rMap.get("r_code")))) {
                logger.error(CommonUtil.isNull(rMap.get("r_msg")));
            } else {
                logger.error(e.getMessage());
            }

            String r_msg = CommonUtil.getMessage(CommonUtil.isNull(rMap.get("r_msg")));
            if (r_msg.equals("")) {
                r_msg = CommonUtil.isNull(rMap.get("r_msg"));
            }
            result_sb.append(r_msg);

        } catch (Exception e) {
            if ("".equals(CommonUtil.isNull(rMap.get("r_code"))))
                rMap.put("r_code", "-1");
            if ("".equals(CommonUtil.isNull(rMap.get("r_msg"))))
                rMap.put("r_msg", "ERROR.01");

            logger.error(e.getMessage());

        } finally {

            String r_msg = CommonUtil.getMessage(CommonUtil.isNull(rMap.get("r_msg")));
            if (r_msg.equals("")) {
                r_msg = CommonUtil.isNull(rMap.get("r_msg"));
            }
            result_sb.append(r_msg);

            // 중복 결재 체크 로직에 걸린 경우.
            if (strApprovalDupError.equals("Y")) {
                // 중복 결재 방지를 위해 필드 업데이트.
                aMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));
                aMap.put("flag", "approval_end");
                aMap.put("doc_cd", strDocCd);
                worksApprovalDocService.dPrcDocApprovalFlagUpdate(aMap);

            } else {

                // 중복 결재 방지를 위해 필드 업데이트.
                aMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));
                aMap.put("flag", "approval_end");
                aMap.put("doc_cd", strDocCd);
                worksApprovalDocService.dPrcDocApprovalFlagUpdate(aMap);

                // 승인 요청은 그룹의 메인으로 결재자 알림 발송
                String sendApprovalNoti = CommonUtil.isNull(rMap.get("sendApprovalNoti"));
                if (sendApprovalNoti.equals("Y")) {
                    int iSendResult = CommonUtil.sendApprovalNoti(strDocCd);
                    logger.info("sendApprovalNoti Result : " + iSendResult);
                }

                String sendInsUserNoti = CommonUtil.isNull(rMap.get("sendInsUserNoti"));
                if (sendInsUserNoti.equals("Y")) {
                    int iSendResult = CommonUtil.sendInsUserNoti(strDocCd);
                    logger.info("sendInsUserNoti Result : " + iSendResult);
                }
            }
        }

        rMap.put("r_msg", result_sb.toString().trim());
        rMap.put("r_code", "1");

        ModelAndView output = null;
        output = new ModelAndView("result/t_result");
        output.addObject("rMap", rMap);

        return output;
    }

    //일괄결재 > 재반영
    public ModelAndView ez006_attempt(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);

        paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
        paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA"));

        String doc_gb = CommonUtil.isNull(paramMap.get("doc_gbs"));

        Map<String, Object> rMap = new HashMap();

        if (doc_gb.equals("06")) {
            EzExcelBatchQuartzServiceImpl ezExcelBatchQuartzServiceImpl = new EzExcelBatchQuartzServiceImpl();
            rMap = ezExcelBatchQuartzServiceImpl.ezExcelBatchQuartzServiceImplCall(paramMap);
        } else {
            EzJobAttemptServiceImpl ezJobAttemptServiceImpl = new EzJobAttemptServiceImpl();
            rMap = ezJobAttemptServiceImpl.EzJobAttemptServiceImplCall(paramMap);
        }

        ModelAndView output = new ModelAndView("result/t_result");
        output.addObject("rMap", rMap);
        return output;
    }

    public ModelAndView ez006_excel(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);

        paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
        paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));

        paramMap.put("excel_down", "excel_down");

        List doc06DetailList = worksApprovalDocService.dGetDoc06DetailList(paramMap);

        ModelAndView output = null;

        output = new ModelAndView("contents/doc06DetailListExcel");
        output.addObject("doc06DetailList", doc06DetailList);

        return output;

    }

    public ModelAndView ez007(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);
        paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
        paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));

        ModelAndView output = null;
        output = new ModelAndView("works/C03/main_contents/allDocInfoList");
        output.addObject("STRT_DT", CommonUtil.toDate());
        output.addObject("END_DT", CommonUtil.toDate());

        return output;
    }

    public ModelAndView ez007_excel(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);
        paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
        paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));

        List allDocInfoList = worksApprovalDocService.dGetAllDocInfoList(paramMap);

        ModelAndView output = null;
//		output = new ModelAndView("ezjobs/t/works/allDocInfoListExcel");
        output = new ModelAndView("contents/allDocInfoListExcel");

        output.addObject("allDocInfoList", allDocInfoList);

        return output;
    }


    public ModelAndView ez008(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);
        paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
        paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));

        Map<String, Object> rMap = new HashMap<String, Object>();

        ModelAndView output = null;
        output = new ModelAndView("works/C06/main_contents/deptAndDutyList");

        return output;

    }


    public ModelAndView ez008_p(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException, Exception {
        Map<String, Object> paramMap = CommonUtil.collectParameters(req);
        paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
        paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));

        Map<String, Object> rMap = new HashMap<String, Object>();

        String gb = CommonUtil.isNull(paramMap.get("gb"));

        try {
            if ("dept".equals(gb)) {
                rMap = worksCompanyService.dPrcDept(paramMap);
            } else if ("duty".equals(gb)) {
                rMap = worksCompanyService.dPrcDuty(paramMap);
            } else if ("part".equals(gb)) {
                rMap = worksCompanyService.dPrcPart(paramMap);
            }

        } catch (DefaultServiceException e) {
            rMap = e.getResultMap();

            if ("-2".equals(CommonUtil.isNull(rMap.get("r_code")))) {
                logger.error(CommonUtil.isNull(rMap.get("r_msg")));
            } else {
                logger.error(e.getMessage());
            }

        } catch (Exception e) {
            if ("".equals(CommonUtil.isNull(rMap.get("r_code")))) rMap.put("r_code", "-1");
            if ("".equals(CommonUtil.isNull(rMap.get("r_msg")))) rMap.put("r_msg", "ERROR.01");

            logger.error(e.getMessage());
        }

        ModelAndView output = null;
        output = new ModelAndView("result/t_result");
        output.addObject("rMap", rMap);

        return output;

    }


    public ModelAndView ez009(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);
        paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
        paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));

        String s_user_gb = CommonUtil.isNull(req.getSession().getAttribute("USER_GB"));

        List odateList = CommonUtil.getCtmOdateList();
        int odate_cnt = odateList.size();

        //상태변경 권한 추가(23.04.04 신한캐피탈)
        List active_auth = null;

        //운영즉시결재노출 코드 가져올 수 있게 추가 (2023.06.16 최호연)
        List adminApprovalBtnList = null;
        paramMap.put("mcode_cd", "M80");
        adminApprovalBtnList = commonService.dGetsCodeList(paramMap);

        paramMap.put("mcode_cd", "M77");
        active_auth = commonService.dGetsCodeList(paramMap);

        ModelAndView output = null;
        output = new ModelAndView("works/C02/main_contents/activeJobList");
        output.addObject("paramMap", paramMap);
        //output.addObject("dataCenterList", CommonUtil.getDataCenterList());
        output.addObject("cm", CommonUtil.getComScodeList(paramMap));
        output.addObject("hostList", CommonUtil.getHostList());

        //운영즉시결재노출 코드 가져올 수 있게 추가 (2023.06.16 최호연)
        output.addObject("adminApprovalBtnList", adminApprovalBtnList);

        // 대분류 검색 화면
        paramMap.put("mcode_search", "Y");
        output.addObject("mcodeList", CommonUtil.getMcodeList(paramMap));

        // 일단 모든 권한을 개발자한테 부여
        if (s_user_gb.equals("99")) {
            output.addObject("JOB_ACTION", CommonUtil.getMessage("JOB.ACTION"));
            output.addObject("ACTIVE_AUTH", active_auth);
        } else {
            //output.addObject("JOB_ACTION", CommonUtil.getMessage("JOB.ACTION_USER"));
            output.addObject("JOB_ACTION", CommonUtil.getMessage("JOB.ACTION"));
            output.addObject("ACTIVE_AUTH", active_auth);
        }

        if (odate_cnt > 0) {
            for (int i = 0; i < odate_cnt; i++) {
                CommonBean bean = (CommonBean) odateList.get(0);
                String odate = bean.getView_odate().replaceAll("/", "");
                output.addObject("ODATE", odate);
                //output.addObject("active_net_name", CommonUtil.getCtmActiveNetName(paramMap));
            }
        } else {
            output.addObject("ODATE", "");
            output.addObject("active_net_name", "");
        }

        return output;

    }

    public ModelAndView ez009_excel(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);

        paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
        paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));

        String s_user_gb = CommonUtil.isNull(req.getSession().getAttribute("USER_GB"));

        paramMap.put("active_net_name", CommonUtil.getCtmActiveNetName(paramMap));
        String p_application_of_def = CommonUtil.isNull(paramMap.get("p_application_of_def")).replaceAll("&apos;", "\'");
        paramMap.put("p_application_of_def", p_application_of_def);
        paramMap.put("p_sched_table", CommonUtil.isNull(paramMap.get("p_sched_table")).replaceAll("&apos;", "\'"));
        paramMap.put("s_user_gb", s_user_gb);

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

        // 멀티 상태 선택
        String p_status = CommonUtil.isNull(paramMap.get("p_status"));
        ArrayList<String> statusList = new ArrayList<>(Arrays.asList(p_status.split("\\s*,\\s*")));
        paramMap.put("statusList", statusList);
//		ActiveJobBean activeJobListCnt = worksApprovalDocService.dGetActiveJobListCnt(paramMap);
//		String activeJobCnt = activeJobListCnt.getTotal_cnt();

        paramMap.put("startRowNum", "0");
//		paramMap.put("pagingNum", activeJobCnt);
        List activeJobList = worksApprovalDocService.dGetActiveJobList(paramMap);
        ModelAndView output = null;
        output = new ModelAndView("contents/activeJobListExcel");

        output.addObject("activeJobList", activeJobList);

        return output;

    }

    public void ez009_txt(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);

        paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
        paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));

        paramMap.put("active_net_name", CommonUtil.getCtmActiveNetName(paramMap));

        String startRowNum = CommonUtil.isNull(paramMap.get("startRowNum"));
        String pagingNum = CommonUtil.isNull(paramMap.get("pagingNum"));

        paramMap.put("startRowNum", "0");
        paramMap.put("pagingNum", Integer.parseInt(startRowNum) + Integer.parseInt(pagingNum));

        List activeJobList = worksApprovalDocService.dGetActiveJobList(paramMap);

        Date dt = new Date();
        SimpleDateFormat sf = new SimpleDateFormat("yyyyMMddHHmm");
        String ymdh = sf.format(dt);

        String file_nm = "실시간수행현황_" + CommonUtil.isNull(req.getSession().getAttribute("USER_CD")) + "_" + ymdh + ".txt";
        String file_path = req.getRealPath(CommonUtil.getMessage("MENUAL_FILE.PATH")) + "/txt_down";

        File file = new File(file_path);
        if (!file.exists()) {
            file.mkdirs();
        }

        String full_path = file_path + "/" + file_nm;

        FileUtil.activeJobListWrite(full_path, activeJobList);

        file = new File(full_path);
        res.setContentType("application/x-msdownload;");
        res.setHeader("Content-Type", "application/octet-stream; charset=UTF-8");
        res.setHeader("Content-Disposition", "attachment; filename=" + java.net.URLEncoder.encode(file_nm, "UTF-8").replaceAll("\\+", "%20"));

        OutputStream out = res.getOutputStream();
        FileInputStream fis = null;

        try {

            fis = new FileInputStream(file);
            FileCopyUtils.copy(fis, out);

        } finally {
			try{ if(fis != null) fis.close(); } catch(Exception e){}
			try{ if(out != null) out.flush(); } catch(Exception e){}
			try{ if(out != null) out.close(); } catch(Exception e){}
            //try{ file.delete();	}catch(Exception e){}
        }
    }

    public ModelAndView ez009_p(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);

        paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
        paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));

        paramMap.put("active_net_name", CommonUtil.getCtmActiveNetName(paramMap));


        Map<String, Object> rMap = new HashMap<String, Object>();

        try {

            //CommonUtil.emLogin(req);
            //paramMap.put("userToken",CommonUtil.isNull(req.getSession().getAttribute("USER_TOKEN")));

            rMap = worksApprovalDocService.emPrcJobAction(paramMap);

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

    public ModelAndView ez009_popup(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);

        paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
        paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));

        ActiveJobBean bean = worksApprovalDocService.dGetActiveJobListCnt(paramMap);

        ModelAndView output = null;

        output = new ModelAndView("ezjobs/t/popup/jobStatusUpdate");

        output.addObject("totalCount", Integer.parseInt(bean.getTotal_cnt()));

        return output;
    }

    public ModelAndView ez010(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);

        //운영즉시결재노출 코드 가져올 수 있게 추가 (2023.06.19 최호연)
        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));
        List adminApprovalBtnList = null;

        paramMap.put("mcode_cd", "M80");
        adminApprovalBtnList = commonService.dGetsCodeList(paramMap);

        paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
        paramMap.put("user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
        paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
        paramMap.put("s_user_gb", CommonUtil.isNull(req.getSession().getAttribute("USER_GB")));

        List<CommonBean> ctmOdateList = CommonUtil.getCtmOdateList();
        int odate_cnt = ctmOdateList.size();

        ModelAndView output = null;
        output = new ModelAndView("works/C03/main_contents/defJobList");
        output.addObject("paramMap", paramMap);
        output.addObject("cm", CommonUtil.getComScodeList(paramMap));

        output.addObject("adminApprovalBtnList", adminApprovalBtnList);

        // 대분류 검색 화면
        paramMap.put("mcode_search", "Y");
        output.addObject("mcodeList", CommonUtil.getMcodeList(paramMap));

        if (odate_cnt > 0) {
            for (int i = 0; i < odate_cnt; i++) {
                CommonBean bean = (CommonBean) ctmOdateList.get(0);
                output.addObject("ODATE", bean.getView_odate().replaceAll("/", ""));
            }
        } else {
            output.addObject("ODATE", "");
        }

        return output;
    }

    // 비정기작업 (그룹)의뢰
    public ModelAndView ez215(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);

        paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
        paramMap.put("user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
        paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
        paramMap.put("s_user_gb", CommonUtil.isNull(req.getSession().getAttribute("USER_GB")));

        //관리자 즉시결재 노출 코드
        List adminApprovalBtnList = null;
        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));
        paramMap.put("mcode_cd", "M80");
        adminApprovalBtnList = commonService.dGetsCodeList(paramMap);

        List<CommonBean> ctmOdateList = CommonUtil.getCtmOdateList();
        int odate_cnt = ctmOdateList.size();

        ModelAndView output = null;
        output = new ModelAndView("works/C03/main_contents/groupDefJobList");
        output.addObject("paramMap", paramMap);
        output.addObject("cm", CommonUtil.getComScodeList(paramMap));
        output.addObject("adminApprovalBtnList", adminApprovalBtnList);

        // 대분류 검색 화면
        paramMap.put("mcode_search", "Y");
        output.addObject("mcodeList", CommonUtil.getMcodeList(paramMap));

        if (odate_cnt > 0) {
            for (int i = 0; i < odate_cnt; i++) {
                CommonBean bean = (CommonBean) ctmOdateList.get(0);
                output.addObject("ODATE", bean.getView_odate().replaceAll("/", ""));
            }
        } else {
            output.addObject("ODATE", "");
        }

        return output;
    }

    public ModelAndView ez010_p(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException, Exception {
        Map<String, Object> paramMap = CommonUtil.collectParameters(req);
        paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
        paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));

        Map<String, Object> rMap = new HashMap<String, Object>();

        try {
            //CommonUtil.emLogin(req);
            //paramMap.put("userToken", CommonUtil.isNull(req.getSession().getAttribute("USER_TOKEN")));

            rMap = worksApprovalDocService.emPrcJobOrder(paramMap);
        } catch (DefaultServiceException e) {
            rMap = e.getResultMap();

            if ("-2".equals(CommonUtil.isNull(rMap.get("r_code")))) {
                logger.error(CommonUtil.isNull(rMap.get("r_msg")));
            } else {
                logger.error(e.getMessage());
            }

        } catch (Exception e) {
            if ("".equals(CommonUtil.isNull(rMap.get("r_code")))) rMap.put("r_code", "-1");
            if ("".equals(CommonUtil.isNull(rMap.get("r_msg")))) rMap.put("r_msg", "ERROR.01");

            logger.error(e.getMessage());
        }

        ModelAndView output = null;
        output = new ModelAndView("ezjobs/t/result");
        output.addObject("rMap", rMap);

        return output;

    }

    //담당자일괄변경 기능 팝업
    public ModelAndView ez012_popup(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);

        paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
        paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));

        List smsDefaultList = null;
        List mailDefaultList = null;

        //SMS 기본값 설정
        paramMap.put("mcode_cd", "M87");
        smsDefaultList = commonService.dGetsCodeList(paramMap);

        //MAIL 기본값 설정
        paramMap.put("mcode_cd", "M88");
        mailDefaultList = commonService.dGetsCodeList(paramMap);

        ModelAndView output = null;
        output = new ModelAndView("contents/popup/jobMapperUpdate");
        output.addObject("paramMap", paramMap);
        output.addObject("smsDefaultList", smsDefaultList);
        output.addObject("mailDefaultList", mailDefaultList);

        return output;
    }

    //담당자일괄변경 기능
    public ModelAndView ez012_popup_p(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);

        paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
        paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));

        Map<String, Object> rMap = new HashMap<String, Object>();

        try {
            logger.info("#data_center===============>" + CommonUtil.isNull(paramMap.get("data_center")));
            logger.info("#flag===============>" + CommonUtil.isNull(paramMap.get("flag")));
            logger.info("#mapper_gubun===============>" + CommonUtil.isNull(paramMap.get("mapper_gubun")));
            logger.info("#mapper_cd===============>" + CommonUtil.isNull(paramMap.get("mapper_cd")));
            logger.info("#udt_user===============>" + CommonUtil.isNull(paramMap.get("udt_user")));
            logger.info("#del_user===============>" + CommonUtil.isNull(paramMap.get("del_user")));
            logger.info("#mapper_nm===============>" + CommonUtil.isNull(paramMap.get("mapper_nm")));
            logger.info("#mapper_cd_2===============>" + CommonUtil.isNull(paramMap.get("mapper_cd_2")));
            logger.info("#mapper_nm_2===============>" + CommonUtil.isNull(paramMap.get("mapper_nm_2")));

            rMap = worksUserService.dPrcJobMapper(paramMap);

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
        output = new ModelAndView("result/t_result");
        output.addObject("rMap", rMap);

        return output;

    }

    public ModelAndView ez013(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);
        paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
        paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));

        ModelAndView output = null;
        output = new ModelAndView("works/C06/main_contents/hostList");
        output.addObject("paramMap", paramMap);
        output.addObject("cm", CommonUtil.getComScodeList(paramMap));
        output.addObject("SERVER_MCODE_CD", CommonUtil.getMessage("COMCODE.SERVER.CODE"));

        return output;
    }

    public ModelAndView ez013_access(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);

        String strDataCenter = CommonUtil.isNull(paramMap.get("data_center"));
        String strAgent = CommonUtil.isNull(paramMap.get("agent"));
        String strAgentId = CommonUtil.isNull(paramMap.get("agent_id"));
        String strAgentPw = SeedUtil.decodeStr(CommonUtil.isNull(paramMap.get("agent_pw")));
        String strAccessGubun = CommonUtil.isNull(paramMap.get("access_gubun"));
        int iAccessPort = Integer.parseInt(CommonUtil.isNull(paramMap.get("access_port"), "22"));

        String strCmd = "pwd";
        String strReturnMsg = "";

        if ("S".equals(strAccessGubun)) {
            Ssh2Util su = new Ssh2Util(strAgent, iAccessPort, strAgentId, strAgentPw, strCmd, "UTF-8");
            strReturnMsg = su.getOutput();

        } else {
            TelnetUtil tu = new TelnetUtil(strAgent, iAccessPort, strAgentId, strAgentPw, strCmd);
            strReturnMsg = tu.getOutput();
        }

//		ModelAndView output = new ModelAndView("ezjobs/t/works/ajaxReturn2");
        ModelAndView output = new ModelAndView("common/inc/ajaxReturn2");
        CommonBean commonBean = new CommonBean();
        commonBean.setAjax_value(strReturnMsg);

        output.addObject("commonBean", commonBean);

        return output;
    }


    public ModelAndView ez013_p(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);

        paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
        paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));

        String flag = CommonUtil.isNull(paramMap.get("flag"));
        String v_agent_pw = CommonUtil.isNull(paramMap.get("v_agent_pw"));
        String strAgentPw = CommonUtil.isNull(paramMap.get("agent_pw"));

        // 암호화
        if (v_agent_pw.equals("")) {
            if (flag.equals("ins")) paramMap.put("agent_pw", SeedUtil.encodeStr(strAgentPw));
        } else {
            paramMap.put("agent_pw", SeedUtil.encodeStr(v_agent_pw));
        }

        Map<String, Object> rMap = new HashMap<String, Object>();

        try {

            rMap = commonService.dPrcHost(paramMap);
        } catch (DefaultServiceException e) {
            rMap = e.getResultMap();

            if ("-2".equals(CommonUtil.isNull(rMap.get("r_code")))) {
                logger.error(CommonUtil.isNull(rMap.get("r_msg")));
            } else {
                logger.error(e.getMessage());
            }

        } catch (Exception e) {
            if ("".equals(CommonUtil.isNull(rMap.get("r_code")))) rMap.put("r_code", "-1");
            if ("".equals(CommonUtil.isNull(rMap.get("r_msg")))) rMap.put("r_msg", "ERROR.01");

            logger.error(e.getMessage());
        }

        ModelAndView output = null;
//		output = new ModelAndView("ezjobs/t/result");
        output = new ModelAndView("result/t_result");
        output.addObject("rMap", rMap);

        return output;

    }

    public ModelAndView ez013_grp(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);
        paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
        paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));

        ModelAndView output = null;
        output = new ModelAndView("works/C06/main_contents/hostGrpList");
        output.addObject("paramMap", paramMap);
        output.addObject("cm", CommonUtil.getDataCenterList());
        output.addObject("SERVER_MCODE_CD", CommonUtil.getMessage("COMCODE.SERVER.CODE"));

        return output;
    }

    public ModelAndView ez013_grp_p(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);

        paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
        paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));

        String flag = CommonUtil.isNull(paramMap.get("flag"));
        String data_center = CommonUtil.isNull(paramMap.get("data_center"));
        String grpname = CommonUtil.isNull(paramMap.get("grpname"));
        String nodeid = CommonUtil.isNull(paramMap.get("nodeid"));

        System.out.println("grpname : " + grpname);

        Map<String, Object> rMap = new HashMap<String, Object>();

        try {

            // Host 정보 가져오는 서비스.
            paramMap.put("data_center", data_center);
            paramMap.put("server_gubun", "S");
            CommonBean bean = commonService.dGetServerInfo(paramMap);

            String strHost = "";
            String strPort = "";
            String strUserId = "";
            String strUserPw = "";
            String strRemoteFilePath = "";
            String strAccessGubun = "";
            String cmd = "";
            String return_msg = "";

            if (bean != null) {

                strHost = bean.getNode_id();
                strPort = bean.getAccess_port();
                strUserId = bean.getAgent_id();
                strUserPw = SeedUtil.decodeStr(CommonUtil.isNull(bean.getAgent_pw()));
                strAccessGubun = CommonUtil.isNull(bean.getAccess_gubun());
            }

            if (flag.equals("grp_del")) {
                cmd = " ctmhostgrp -DELETE " + grpname;
            } else if (flag.equals("ins")) {
                cmd = " ctmhostgrp -EDIT -HOSTGRP " + grpname + " -APPLTYPE OS -ADD " + strHost;
//				cmd = " ctmhostgrp -EDIT -HOSTGRP " + grpname + " -APPLTYPE OS -ADD " + nodeid;
            } else if (flag.equals("del")) {
                cmd = " ctmhostgrp -EDIT -HOSTGRP " + grpname + " -APPLTYPE OS -DELETE " + nodeid;
            }

            System.out.println("cmd : " + cmd);

            if (!"".equals(strHost)) {

                if ("S".equals(strAccessGubun)) {
                    Ssh2Util su = new Ssh2Util(strHost, Integer.parseInt(strPort), strUserId, strUserPw, cmd, "UTF-8");
                    return_msg = su.getOutput();
                } else {
                    TelnetUtil tu = new TelnetUtil(strHost, Integer.parseInt(strPort), strUserId, strUserPw, cmd);
                    return_msg = tu.getOutput();
                }

            } else {
                return_msg = CommonUtil.getMessage("ERROR.09");
            }

            System.out.println("return_msg : " + return_msg);

            if (return_msg.indexOf("successfully") > -1) {
                rMap.put("r_msg", "DEBUG.01");
                rMap.put("r_code", "1");
            } else {
                rMap.put("r_msg", "ERROR.01");
                rMap.put("r_code", "-1");
            }

        } catch (Exception e) {
            if ("".equals(CommonUtil.isNull(rMap.get("r_code")))) rMap.put("r_code", "-1");
            if ("".equals(CommonUtil.isNull(rMap.get("r_msg")))) rMap.put("r_msg", "ERROR.01");

            logger.error(e.getMessage());
        }

        ModelAndView output = null;

        output = new ModelAndView("result/t_result");
        output.addObject("rMap", rMap);

        return output;
    }

    public ModelAndView ez014(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);

        ModelAndView output = new ModelAndView("main_contents/codeList");

        return output;
    }

    public ModelAndView ez014_p(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);
        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));
        String mcode_cd = CommonUtil.isNull(paramMap.get("mcode_cd"));

        Map<String, Object> rMap = new HashMap<String, Object>();

        try {

            rMap = worksCompanyService.dPrcCode(paramMap);

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

        ModelAndView output = new ModelAndView("result/t_result");
        output.addObject("rMap", rMap);

        return output;
    }

    public ModelAndView ez015(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);

//		ModelAndView output = new ModelAndView("ezjobs/t/works/sCodeList_iframe");
        ModelAndView output = new ModelAndView("contents/sCodeList_iframe");

        List sCodeList = worksCompanyService.dGetSCodeList(paramMap);

        output.addObject("sCodeList", sCodeList);

        return output;
    }

    // 결재문서함 > 일괄결재
    public ModelAndView ez016(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);

        paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
        paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));

        Map<String, Object> rMap = new HashMap<String, Object>();
        Map<String, Object> rMap2 = new HashMap<String, Object>();
        Map<String, Object> rMap3 = new HashMap<String, Object>();
        Map<String, Object> rMap4 = new HashMap<String, Object>();
        Map<String, Object> aMap = new HashMap<String, Object>();

        StringBuffer sb = new StringBuffer();
        StringBuffer sb2 = new StringBuffer();
        StringBuffer sb3 = new StringBuffer();

        String strUploadTable = "";
        String strDocCd = "";
        String strDocCds = "";
        String strApprovalDupError = "";

        String strFlag = CommonUtil.isNull(paramMap.get("flag"));

        String strApprovalCd = CommonUtil.isNull(paramMap.get("approval_cd"));
        String strApprovalComment = CommonUtil.isNull(paramMap.get("approval_comment"));
        String strCheckDocCd = CommonUtil.isNull(paramMap.get("check_doc_cd"));

        String strCheckDataCenter = CommonUtil.isNull(paramMap.get("check_data_center"));
        String strCheckApprovalSeq = CommonUtil.isNull(paramMap.get("check_approval_seq"));
        String strCheckDocCnt = CommonUtil.isNull(paramMap.get("check_doc_cnt"));
        String strCheckPostApprovalYn = CommonUtil.isNull(paramMap.get("check_post_approval_yn"));

        String arrCheckDocCd[] = CommonUtil.isNull(strCheckDocCd).split("[|]");
        String arrCheckDataCenter[] = CommonUtil.isNull(strCheckDataCenter).split("[|]");
        String arrCheckApprovalSeq[] = CommonUtil.isNull(strCheckApprovalSeq).split("[|]");
        String arrCheckDocCnt[] = CommonUtil.isNull(strCheckDocCnt).split("[|]");
        String arrCheckPostApprovalYn[] = CommonUtil.isNull(strCheckPostApprovalYn).split("[|]");

        int i = 0;
        int success = 0;
        CommonBean commonBean = null;

        try {

            // 중복 결재 방지를 위해 필드 일괄 업데이트
            aMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));
            aMap.put("flag", "batch_approval_start");
            aMap.put("doc_cd", strCheckDocCd);

            worksApprovalDocService.dPrcDocApprovalFlagUpdate(aMap);

            //이미 결재진행중인 문서들 조회('AA'일 경우 error메세지 노출)
            commonBean = worksApprovalDocService.dGetDocApprovalStartChk(aMap);

            if (commonBean.getDoc_cd() != null) {
                Map errMap = new HashMap();
                errMap.put("r_code", "-1");
                errMap.put("r_msg", "ERROR.49");

                // finally 에서 중복 결재 플래그만 원복하기 위해. (2023.12.04 강명준)
                strApprovalDupError = "Y";

                String strDocChk[] = CommonUtil.isNull(commonBean.getDoc_cd()).split(",");
                for (int t = 0; t < strDocChk.length; t++) {
                    logger.error("중복 결재 중인 문서" + strDocChk[t]);

                    //넘어온 파라미터에서 중복 결재 진행중인 데이터는 모두 삭제
                    //배열을 리스트로 변환
                    List<String> ChkDocCdList = new ArrayList<>(Arrays.asList(arrCheckDocCd));
                    List<String> ChkDataCenterList = new ArrayList<>(Arrays.asList(arrCheckDataCenter));
                    List<String> ChkApprovalSeqList = new ArrayList<>(Arrays.asList(arrCheckApprovalSeq));
                    List<String> ChkDocCntList = new ArrayList<>(Arrays.asList(arrCheckDocCnt));
                    List<String> ChkPostApprovalYnList = new ArrayList<>(Arrays.asList(arrCheckPostApprovalYn));

                    //특정 인덱스의 값을 제거하기 위해 조회된 doc_cd의 index 값 구함
                    int indexToRemove = ChkDocCdList.indexOf(strDocChk[t]);
                    if (indexToRemove != -1) {
                        logger.error("찾는 값의 인덱스: " + indexToRemove);
                    } else {
                        logger.error("::::제거할 문서 못찾음:::::");
                    }

                    //특정 인덱스의 값을 제거
                    ChkDocCdList.remove(indexToRemove);
                    ChkDataCenterList.remove(indexToRemove);
                    ChkApprovalSeqList.remove(indexToRemove);
                    ChkDocCntList.remove(indexToRemove);
                    ChkPostApprovalYnList.remove(indexToRemove);

                    // 리스트를 배열로 변환
                    arrCheckDocCd = ChkDocCdList.toArray(new String[0]);
                    arrCheckDataCenter = ChkDataCenterList.toArray(new String[0]);
                    arrCheckApprovalSeq = ChkApprovalSeqList.toArray(new String[0]);
                    arrCheckDocCnt = ChkDocCntList.toArray(new String[0]);
                    arrCheckPostApprovalYn = ChkPostApprovalYnList.toArray(new String[0]);

                    //에러 메세지에 추가해준다.
                    sb.append("\n");
                    sb.append(CommonUtil.E2K(strDocChk[t]) + " : " + CommonUtil.getMessage(CommonUtil.isNull(errMap.get("r_msg"))));

                }

                if (arrCheckDocCd.length == 0) {
                    logger.error(":::::::결재할 문서가 없으므로 끝낸다::::");
                    throw new DefaultServiceException(errMap);
                } else {
                    logger.error("::결재할 문서 목록::" + Arrays.toString(arrCheckDocCd));
                }
                //continue;
                //throw new DefaultServiceException(errMap);
            }

            logger.error(":::최종 결재 건수::: " + arrCheckDocCd.length);

            for (int z = 0; z < arrCheckDocCd.length; z++) {

                paramMap.put("doc_cd", arrCheckDocCd[z]);
                paramMap.put("data_center", arrCheckDataCenter[z]);
                paramMap.put("approval_seq", arrCheckApprovalSeq[z]);
                paramMap.put("doc_cnt", arrCheckDocCnt[z]);
                paramMap.put("post_approval_yn", arrCheckPostApprovalYn[z]);
                paramMap.put("approval_cd", strApprovalCd);
                paramMap.put("approval_comment", strApprovalComment);
                paramMap.put("flag", strFlag);
                paramMap.put("group_approval", "Y");
                paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));

                try {

                    // 중복 결재 방지를 위해 필드 업데이트.
                    /*
                    aMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
                    aMap.put("flag", "approval_start");
                    aMap.put("doc_cd", arrCheckDocCd[z]);

                    worksApprovalDocService.dPrcDocApprovalFlagUpdate(aMap);
                    */

                    //CommonBean commonBean = worksApprovalDocService.dGetDocApprovalStartCnt(paramMap);

                    // 이미 결재 처리되었는지를 프로시저 외 컨트롤러에서도 체크
                    // 일단 그룹수시작업의뢰 시 결재차수 체크하면서 반영완료된 건을 다시 반영실패로 업데이트 해버리는 현상 있음 (2023.12.04 강명준)
                    CommonBean alreadyCntBean = worksApprovalDocService.dGetDocApprovalAlreadyCnt(paramMap);

                    if (alreadyCntBean.getTotal_count() >= 1) {
                        Map errMap = new HashMap();
                        errMap.put("r_code", "-1");
                        errMap.put("r_msg", "ERROR.49");

                        // finally 에서 중복 결재 플래그만 원복하기 위해. (2023.12.04 강명준)
                        strApprovalDupError = "Y";

                        sb.append("\n");
                        sb.append(CommonUtil.E2K(arrCheckDocCd[z] + " : " + CommonUtil.getMessage(CommonUtil.isNull(errMap.get("r_msg")))));
                        continue;
                        //throw new DefaultServiceException(errMap);
                    }

                    // 1. 일괄요청서/그룹수행 문서 체크 DocCnt : 문서 내에 존재하는 작업 건 수(0 = 단 건 결재/0 != 일괄/그룹 결재)
                    if (arrCheckDocCnt[z].equals("0")) {

                        paramMap.put("group_main", "");
                        rMap = worksApprovalDocService.dPrcDocApproval(paramMap);
                        if ("1".equals(CommonUtil.isNull(rMap.get("r_code")))) success++;

                    } else {

                        try {

                            // 2. 해당 메인 문서에 속한 문서들을 구하고, FOR 문 돌려서 결재를 태운다.
                            List jobGroupDetailList = worksApprovalDocService.dGetJobGroupDetailApprovalList(paramMap);

                            for (int q = 0; q < jobGroupDetailList.size(); q++) {

                                Doc05Bean bean = (Doc05Bean) jobGroupDetailList.get(q);
                                String strJobName = CommonUtil.E2K(CommonUtil.isNull(bean.getJob_name(), ""));
                                strDocCd = CommonUtil.isNull(bean.getDoc_cd(), "");
                                String strTableId = CommonUtil.isNull(bean.getTable_id(), "");
                                String strJobId = CommonUtil.isNull(bean.getJob_id(), "");

                                rMap2.put("data_center", arrCheckDataCenter[z]);
                                rMap2.put("s_gb", paramMap.get("s_gb"));
                                rMap2.put("doc_gb", paramMap.get("doc_gb"));
                                rMap2.put("flag", paramMap.get("flag"));
                                rMap2.put("approval_seq", arrCheckApprovalSeq[z]);
                                rMap2.put("approval_cd", strApprovalCd);
                                rMap2.put("approval_comment", paramMap.get("approval_comment"));
                                rMap2.put("s_user_cd", paramMap.get("s_user_cd"));
                                rMap2.put("s_user_ip", paramMap.get("s_user_ip"));
                                rMap2.put("main_doc_cd", "");
                                rMap2.put("job_name", strJobName);
                                rMap2.put("doc_cd", strDocCd);
                                rMap2.put("table_id", strTableId);
                                rMap2.put("job_id", strJobId);
                                rMap2.put("userToken", CommonUtil.isNull(req.getSession().getAttribute("USER_TOKEN")));
                                rMap2.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));
                                rMap2.put("doc_cnt", "0");

                                // 파라미터 원복 (2023.10.26 강명준)
                                rMap2.put("group_main", "");

                                try {

                                    rMap = worksApprovalDocService.dPrcDocApproval(rMap2);
                                    if ("1".equals(CommonUtil.isNull(rMap.get("r_code")))) success++;

                                } catch (DefaultServiceException e) {

                                    rMap = e.getResultMap();

                                    String r_msg = CommonUtil.getMessage(CommonUtil.isNull(rMap.get("r_msg")));
                                    if (r_msg.equals("")) {
                                        r_msg = CommonUtil.isNull(rMap.get("r_msg"));
                                    }

                                    //그룹 내 문서에 대한 오류메세지 노출 가능?
                                    sb.append("\n");
                                    sb.append(CommonUtil.E2K(strDocCd) + " : " + r_msg);

                                    // 에러가 난 작업은 반영상태: 실패로 찍어준다. (2023.07.10 강명준)
                                    rMap3.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));
                                    rMap3.put("flag", "group_order_exec_fail");
                                    rMap3.put("doc_cd", strDocCd);
                                    //rMap3.put("approval_comment"	, CommonUtil.isNull(rMap.get("original_r_msg"), CommonUtil.getMessage(CommonUtil.isNull(rMap.get("r_msg")))));
                                    rMap3.put("approval_comment", r_msg);

                                    worksApprovalDocService.dPrcDocApprovalFlagUpdate(rMap3);

                                    // 파라미터 원복 (2023.10.26 강명준)
                                    rMap3.put("approval_comment", "");

                                }
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

                            logger.error(":::Exception:::" + e.getMessage());

                        } finally {
                            // 메인 요청서 결재 처리.
                            // group_main: Y (2023.09.20.강명준. 그룹 메인이라서 결재 후 API 호출 제외하는 용도)
                            rMap2.put("group_main", "Y");
                            rMap2.put("doc_cd", arrCheckDocCd[z]);
                            rMap = worksApprovalDocService.dPrcDocApproval(rMap2);

                            // 최종 결재 시 main_doc_cd의 apply_cd 적용시키는 구간
                            paramMap.put("flag", "group_approval_end");
                            worksApprovalDocService.dPrcDocApprovalFlagUpdate(paramMap);
                        }
                    }

                } catch (DefaultServiceException e) {

                    rMap = e.getResultMap();

                    //오류메세지 처리
                    String r_msg = CommonUtil.getMessage(CommonUtil.isNull(rMap.get("r_msg")));
                    if (r_msg.equals("")) {
                        r_msg = CommonUtil.isNull(rMap.get("r_msg"));
                    }

                    logger.info("::::ez016 DefaultServiceException::::::" + rMap);
                    sb.append("\n");
                    sb.append(CommonUtil.E2K(arrCheckDocCd[z]) + " : " + r_msg);

                } finally {

                    // 중복 결재 방지를 위해 필드 업데이트.
                    /*
                    aMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
                    aMap.put("flag", "approval_end");
                    aMap.put("doc_cd", arrCheckDocCd[z]);
                    worksApprovalDocService.dPrcDocApprovalFlagUpdate(aMap);

                    logger.info("1111");
                    */
                }

                // 업로드 대상 테이블 추출
                String strRtable = CommonUtil.isNull(rMap.get("r_table"));

                if (!strRtable.equals("")) {
                    sb3.append(strRtable);
                    sb3.append(",");
                }

                logger.info("::::strRtable::::" + strRtable);

            }

            if (!sb3.toString().equals("")) {
                strUploadTable = CommonUtil.dupStringCheck(sb3.toString());
            }

            System.out.println("strUploadTable : " + strUploadTable);

            if (!strUploadTable.equals("")) {

                // 앞 뒤 , 가 붙어 있을 경우 제거 한다.
                if (strUploadTable.substring(0, 1).equals(",")) {
                    strUploadTable = strUploadTable.substring(1, strUploadTable.length());
                }
                if (strUploadTable.substring(strUploadTable.length() - 1, strUploadTable.length()).equals(",")) {
                    strUploadTable = strUploadTable.substring(0, strUploadTable.length() - 1);
                }

                String arrUploadTable[] = CommonUtil.isNull(strUploadTable).split(",");

                for (int j = 0; j < arrUploadTable.length; j++) {

                    paramMap.put("table_name", arrUploadTable[j].split("[|]")[0]);
                    paramMap.put("data_center", arrUploadTable[j].split("[|]")[1]);

                    // 실제 업로드 수행
                    rMap4 = worksApprovalDocService.dPrcUploadTable(paramMap);
                }
            }

            // 몇건 처리완료 문구를 맨 위로 보낸다. (2023.08.29 강명준)
            if (success > 0) {
                sb.insert(0, success + "건 처리 완료\n");
            }

            // 오류 발생건이 한개라도 있으면 알림 메시지 추가 (요청서 상세에서 결재 시 상세한 오류 메시지 확인 가능)
            if (sb.toString().indexOf("EZJ") > -1) {
                sb.append("\n\n");
                sb.append("※ 요청서 상세 조회 후 결재 시 디테일한 오류 메시지 확인 가능");
            }

            rMap.put("rMsg", "");
            rMap.put("r_msg", sb.toString().trim());
            rMap.put("r_code", "1");

        } catch (DefaultServiceException e) {

            rMap = e.getResultMap();

            logger.info(":::ez016 DefaultServiceException::::" + rMap);

            if ("-2".equals(CommonUtil.isNull(rMap.get("r_code")))) {
                logger.error(CommonUtil.isNull(rMap.get("r_msg")));
            } else {
                logger.error(e.getMessage());
            }

            //오류메세지 처리
            String r_msg = CommonUtil.getMessage(CommonUtil.isNull(rMap.get("r_msg")));
            if (r_msg.equals("")) {
                r_msg = CommonUtil.isNull(rMap.get("r_msg"));
            }

            rMap.put("r_code", "-1");
            rMap.put("r_msg", r_msg);

        } catch (Exception e) {

            if ("".equals(CommonUtil.isNull(rMap.get("r_code"))))
                rMap.put("r_code", "-1");
            if ("".equals(CommonUtil.isNull(rMap.get("r_msg"))))
                rMap.put("r_msg", "ERROR.01");

            logger.info(":::ez016 Exception::::" + rMap);
            logger.error(e.getMessage());

        } finally {

            // 중복 결재 방지를 위해 필드 업데이트.
            aMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));
            aMap.put("flag", "batch_approval_end");
            aMap.put("doc_cd", strCheckDocCd);
            worksApprovalDocService.dPrcDocApprovalFlagUpdate(aMap);
        }

        logger.info("일괄결재 처리 메세지 : " + rMap.get("r_msg"));

        ModelAndView output = null;
        output = new ModelAndView("result/t_result");
        output.addObject("rMap", rMap);

        return output;
    }

    // 결재문서함 > 일괄결재
    public ModelAndView groupApproval(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);

        paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
        paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));

        Map<String, Object> rMap = new HashMap<String, Object>();
        Map<String, Object> rMap2 = new HashMap<String, Object>();
        Map<String, Object> rMap3 = new HashMap<String, Object>();
        Map<String, Object> rMap4 = new HashMap<String, Object>();
        Map<String, Object> aMap = new HashMap<String, Object>();

        StringBuffer sb = new StringBuffer();
        StringBuffer sb2 = new StringBuffer();
        StringBuffer sb3 = new StringBuffer();

        String strUploadTable = "";
        String strDocCd = "";
        String strDocCds = "";
        String strApprovalDupError = "";

        String strFlag = CommonUtil.isNull(paramMap.get("flag"));

        String strApprovalCd = CommonUtil.isNull(paramMap.get("approval_cd"));
        String strApprovalComment = CommonUtil.isNull(paramMap.get("approval_comment"));
        String strCheckDocCd = CommonUtil.isNull(paramMap.get("check_doc_cd"));

        String strCheckDataCenter = CommonUtil.isNull(paramMap.get("check_data_center"));
        String strCheckApprovalSeq = CommonUtil.isNull(paramMap.get("check_approval_seq"));
        String strCheckDocCnt = CommonUtil.isNull(paramMap.get("check_doc_cnt"));
        String strCheckPostApprovalYn = CommonUtil.isNull(paramMap.get("check_post_approval_yn"));

        String arrCheckDocCd[] = CommonUtil.isNull(strCheckDocCd).split("[|]");
        String arrCheckDataCenter[] = CommonUtil.isNull(strCheckDataCenter).split("[|]");
        String arrCheckApprovalSeq[] = CommonUtil.isNull(strCheckApprovalSeq).split("[|]");
        String arrCheckDocCnt[] = CommonUtil.isNull(strCheckDocCnt).split("[|]");
        String arrCheckPostApprovalYn[] = CommonUtil.isNull(strCheckPostApprovalYn).split("[|]");

        int i = 0;
        int success = 0;
        CommonBean commonBean = null;

        try {

            // 중복 결재 방지를 위해 필드 일괄 업데이트
            aMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));
            aMap.put("flag", "batch_approval_start");
            aMap.put("doc_cd", strCheckDocCd);

            worksApprovalDocService.dPrcDocApprovalFlagUpdate(aMap);

            //이미 결재진행중인 문서들 조회('AA'일 경우 error메세지 노출)
            commonBean = worksApprovalDocService.dGetDocApprovalStartChk(aMap);

            if (commonBean.getDoc_cd() != null) {
                Map errMap = new HashMap();
                errMap.put("r_code", "-1");
                errMap.put("r_msg", "ERROR.49");

                // finally 에서 중복 결재 플래그만 원복하기 위해. (2023.12.04 강명준)
                strApprovalDupError = "Y";

                String strDocChk[] = CommonUtil.isNull(commonBean.getDoc_cd()).split(",");
                for (int t = 0; t < strDocChk.length; t++) {
                    logger.error("중복 결재 중인 문서" + strDocChk[t]);

                    //넘어온 파라미터에서 중복 결재 진행중인 데이터는 모두 삭제
                    //배열을 리스트로 변환
                    List<String> ChkDocCdList = new ArrayList<>(Arrays.asList(arrCheckDocCd));
                    List<String> ChkDataCenterList = new ArrayList<>(Arrays.asList(arrCheckDataCenter));
                    List<String> ChkApprovalSeqList = new ArrayList<>(Arrays.asList(arrCheckApprovalSeq));
                    List<String> ChkDocCntList = new ArrayList<>(Arrays.asList(arrCheckDocCnt));
                    List<String> ChkPostApprovalYnList = new ArrayList<>(Arrays.asList(arrCheckPostApprovalYn));

                    //특정 인덱스의 값을 제거하기 위해 조회된 doc_cd의 index 값 구함
                    int indexToRemove = ChkDocCdList.indexOf(strDocChk[t]);
                    if (indexToRemove != -1) {
                        logger.error("찾는 값의 인덱스: " + indexToRemove);
                    } else {
                        logger.error("::::제거할 문서 못찾음:::::");
                    }

                    //특정 인덱스의 값을 제거
                    ChkDocCdList.remove(indexToRemove);
                    ChkDataCenterList.remove(indexToRemove);
                    ChkApprovalSeqList.remove(indexToRemove);
                    ChkDocCntList.remove(indexToRemove);
                    ChkPostApprovalYnList.remove(indexToRemove);

                    // 리스트를 배열로 변환
                    arrCheckDocCd = ChkDocCdList.toArray(new String[0]);
                    arrCheckDataCenter = ChkDataCenterList.toArray(new String[0]);
                    arrCheckApprovalSeq = ChkApprovalSeqList.toArray(new String[0]);
                    arrCheckDocCnt = ChkDocCntList.toArray(new String[0]);
                    arrCheckPostApprovalYn = ChkPostApprovalYnList.toArray(new String[0]);

                    //에러 메세지에 추가해준다.
                    sb.append("\n");
                    sb.append(CommonUtil.E2K(strDocChk[t]) + " : " + CommonUtil.getMessage(CommonUtil.isNull(errMap.get("r_msg"))));

                }

                if (arrCheckDocCd.length == 0) {
                    logger.error(":::::::결재할 문서가 없으므로 끝낸다::::");
                    throw new DefaultServiceException(errMap);
                } else {
                    logger.error("::결재할 문서 목록::" + Arrays.toString(arrCheckDocCd));
                }
                //continue;
                //throw new DefaultServiceException(errMap);
            }

            logger.error(":::최종 결재 건수::: " + arrCheckDocCd.length);

            for (int z = 0; z < arrCheckDocCd.length; z++) {

                paramMap.put("doc_cd", arrCheckDocCd[z]);
                paramMap.put("data_center", arrCheckDataCenter[z]);
                paramMap.put("approval_seq", arrCheckApprovalSeq[z]);
                paramMap.put("doc_cnt", arrCheckDocCnt[z]);
                paramMap.put("post_approval_yn", arrCheckPostApprovalYn[z]);
                paramMap.put("approval_cd", strApprovalCd);
                paramMap.put("approval_comment", strApprovalComment);
                paramMap.put("flag", strFlag);
                paramMap.put("group_approval", "Y");
                paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));

                try {

                    // 중복 결재 방지를 위해 필드 업데이트.
                    /*
                    aMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
                    aMap.put("flag", "approval_start");
                    aMap.put("doc_cd", arrCheckDocCd[z]);

                    worksApprovalDocService.dPrcDocApprovalFlagUpdate(aMap);
                    */

                    //CommonBean commonBean = worksApprovalDocService.dGetDocApprovalStartCnt(paramMap);

                    // 이미 결재 처리되었는지를 프로시저 외 컨트롤러에서도 체크
                    // 일단 그룹수시작업의뢰 시 결재차수 체크하면서 반영완료된 건을 다시 반영실패로 업데이트 해버리는 현상 있음 (2023.12.04 강명준)
                    CommonBean alreadyCntBean = worksApprovalDocService.dGetDocApprovalAlreadyCnt(paramMap);

                    if (alreadyCntBean.getTotal_count() >= 1) {
                        Map errMap = new HashMap();
                        errMap.put("r_code", "-1");
                        errMap.put("r_msg", "ERROR.49");

                        // finally 에서 중복 결재 플래그만 원복하기 위해. (2023.12.04 강명준)
                        strApprovalDupError = "Y";

                        sb.append("\n");
                        sb.append(CommonUtil.E2K(arrCheckDocCd[z] + " : " + CommonUtil.getMessage(CommonUtil.isNull(errMap.get("r_msg")))));
                        continue;
                        //throw new DefaultServiceException(errMap);
                    }

                    // 1. 일괄요청서/그룹수행 문서 체크 DocCnt : 문서 내에 존재하는 작업 건 수(0 = 단 건 결재/0 != 일괄/그룹 결재)
                    if (arrCheckDocCnt[z].equals("0")) {
                        paramMap.put("group_main", "N");
                    } else {
                        paramMap.put("group_main", "Y");
                    }

                    rMap = worksApprovalDocService.dPrcDocApproval(paramMap);
                    System.out.println("WorksController::rMap" + rMap);
                    if ("1".equals(CommonUtil.isNull(rMap.get("r_code")))) success++;
                    if (!"1".equals(CommonUtil.isNull(rMap.get("r_code")))) throw new DefaultServiceException(rMap);

					 /* else {

						try {

							// 2. 해당 메인 문서에 속한 문서들을 구하고, FOR 문 돌려서 결재를 태운다.
							List jobGroupDetailList = worksApprovalDocService.dGetJobGroupDetailApprovalList(paramMap);

							for (int q = 0; q < jobGroupDetailList.size(); q++) {

								Doc05Bean bean          = (Doc05Bean) jobGroupDetailList.get(q);
								String strJobName       = CommonUtil.E2K(CommonUtil.isNull(bean.getJob_name(), ""));
								strDocCd                = CommonUtil.isNull(bean.getDoc_cd(), "");
								String strTableId       = CommonUtil.isNull(bean.getTable_id(), "");
								String strJobId         = CommonUtil.isNull(bean.getJob_id(), "");

								rMap2.put("data_center",		arrCheckDataCenter[z]);
								rMap2.put("s_gb", 				paramMap.get("s_gb"));
								rMap2.put("doc_gb", 			paramMap.get("doc_gb"));
								rMap2.put("flag", 				paramMap.get("flag"));
								rMap2.put("approval_seq",		arrCheckApprovalSeq[z]);
								rMap2.put("approval_cd", 		strApprovalCd);
								rMap2.put("approval_comment", 	paramMap.get("approval_comment"));
								rMap2.put("s_user_cd", 			paramMap.get("s_user_cd"));
								rMap2.put("s_user_ip", 			paramMap.get("s_user_ip"));
								rMap2.put("main_doc_cd",        "");
								rMap2.put("job_name",           strJobName);
								rMap2.put("doc_cd",             strDocCd);
								rMap2.put("table_id",           strTableId);
								rMap2.put("job_id",             strJobId);
								rMap2.put("userToken",          CommonUtil.isNull(req.getSession().getAttribute("USER_TOKEN")));
								rMap2.put("SCHEMA",             CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
								rMap2.put("doc_cnt",            "0");

								// 파라미터 원복 (2023.10.26 강명준)
								rMap2.put("group_main", "");

								try {

									rMap = worksApprovalDocService.dPrcDocApproval(rMap2);
									if ("1".equals(CommonUtil.isNull(rMap.get("r_code")))) success++;

								} catch (DefaultServiceException e) {

									rMap = e.getResultMap();

									String r_msg = CommonUtil.getMessage(CommonUtil.isNull(rMap.get("r_msg")));
									if (r_msg.equals("")) {
										r_msg = CommonUtil.isNull(rMap.get("r_msg"));
									}

									//그룹 내 문서에 대한 오류메세지 노출 가능?
									sb.append("\n");
									sb.append(CommonUtil.E2K(strDocCd) + " : " + r_msg);

									// 에러가 난 작업은 반영상태: 실패로 찍어준다. (2023.07.10 강명준)
									rMap3.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
									rMap3.put("flag", "group_order_exec_fail");
									rMap3.put("doc_cd", strDocCd);
									//rMap3.put("approval_comment"	, CommonUtil.isNull(rMap.get("original_r_msg"), CommonUtil.getMessage(CommonUtil.isNull(rMap.get("r_msg")))));
									rMap3.put("approval_comment", r_msg);

									worksApprovalDocService.dPrcDocApprovalFlagUpdate(rMap3);

									// 파라미터 원복 (2023.10.26 강명준)
									rMap3.put("approval_comment", "");

								}
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

							logger.error(":::Exception:::"+e.getMessage());

						} finally {
							// 메인 요청서 결재 처리.
							// group_main: Y (2023.09.20.강명준. 그룹 메인이라서 결재 후 API 호출 제외하는 용도)
							rMap2.put("group_main", "Y");
							rMap2.put("doc_cd", 	arrCheckDocCd[z]);
							rMap = worksApprovalDocService.dPrcDocApproval(rMap2);

							// 최종 결재 시 main_doc_cd의 apply_cd 적용시키는 구간
							paramMap.put("flag", "group_approval_end");
							worksApprovalDocService.dPrcDocApprovalFlagUpdate(paramMap);
						}
					}*/

                } catch (DefaultServiceException e) {

                    rMap = e.getResultMap();

                    //오류메세지 처리
                    String r_msg = CommonUtil.getMessage(CommonUtil.isNull(rMap.get("r_msg")));
                    if (r_msg.equals("")) {
                        r_msg = CommonUtil.isNull(rMap.get("r_msg"));
                    }

                    logger.info("::::ez016 DefaultServiceException::::::" + rMap);
                    sb.append("\n");
                    sb.append(CommonUtil.E2K(arrCheckDocCd[z]) + " : " + r_msg);

                } finally {
                    // 승인 요청은 그룹의 메인으로 결재자 알림 발송
                    String sendApprovalNoti = CommonUtil.isNull(rMap.get("sendApprovalNoti"));
                    if (sendApprovalNoti.equals("Y")) {
                        int iSendResult = CommonUtil.sendApprovalNoti(arrCheckDocCd[z]);
                        logger.info("sendApprovalNoti Result : " + iSendResult);
                    }

                    String sendInsUserNoti = CommonUtil.isNull(rMap.get("sendInsUserNoti"));
                    if (sendInsUserNoti.equals("Y")) {
                        int iSendResult = CommonUtil.sendInsUserNoti(arrCheckDocCd[z]);
                        logger.info("sendInsUserNoti Result : " + iSendResult);
                    }
                }

                // 업로드 대상 테이블 추출
                String strRtable = CommonUtil.isNull(rMap.get("r_table"));

                if (!strRtable.equals("")) {
                    sb3.append(strRtable);
                    sb3.append(",");
                }

                logger.info("::::strRtable::::" + strRtable);

            }

            if (!sb3.toString().equals("")) {
                strUploadTable = CommonUtil.dupStringCheck(sb3.toString());
            }

            System.out.println("strUploadTable : " + strUploadTable);

            if (!strUploadTable.equals("")) {

                // 앞 뒤 , 가 붙어 있을 경우 제거 한다.
                if (strUploadTable.substring(0, 1).equals(",")) {
                    strUploadTable = strUploadTable.substring(1, strUploadTable.length());
                }
                if (strUploadTable.substring(strUploadTable.length() - 1, strUploadTable.length()).equals(",")) {
                    strUploadTable = strUploadTable.substring(0, strUploadTable.length() - 1);
                }

                String arrUploadTable[] = CommonUtil.isNull(strUploadTable).split(",");

                for (int j = 0; j < arrUploadTable.length; j++) {

                    paramMap.put("table_name", arrUploadTable[j].split("[|]")[0]);
                    paramMap.put("data_center", arrUploadTable[j].split("[|]")[1]);

                    // 실제 업로드 수행
                    rMap4 = worksApprovalDocService.dPrcUploadTable(paramMap);
                }
            }

            // 몇건 처리완료 문구를 맨 위로 보낸다. (2023.08.29 강명준)
            if (success > 0) {
                sb.insert(0, success + "건 처리 완료\n");
            }

            // 오류 발생건이 한개라도 있으면 알림 메시지 추가 (요청서 상세에서 결재 시 상세한 오류 메시지 확인 가능)
            if (sb.toString().indexOf("EZJ") > -1) {
                sb.append("\n\n");
                sb.append("※ 요청서 상세 조회 후 결재 시 디테일한 오류 메시지 확인 가능");
            }

            rMap.put("rMsg", "");
            rMap.put("r_msg", sb.toString().trim());
            rMap.put("r_code", "1");

        } catch (DefaultServiceException e) {

            rMap = e.getResultMap();

            logger.info(":::ez016 DefaultServiceException::::" + rMap);

            if ("-2".equals(CommonUtil.isNull(rMap.get("r_code")))) {
                logger.error(CommonUtil.isNull(rMap.get("r_msg")));
            } else {
                logger.error(e.getMessage());
            }

            //오류메세지 처리
            String r_msg = CommonUtil.getMessage(CommonUtil.isNull(rMap.get("r_msg")));
            if (r_msg.equals("")) {
                r_msg = CommonUtil.isNull(rMap.get("r_msg"));
            }

            rMap.put("r_code", "-1");
            rMap.put("r_msg", r_msg);

        } catch (Exception e) {

            if ("".equals(CommonUtil.isNull(rMap.get("r_code"))))
                rMap.put("r_code", "-1");
            if ("".equals(CommonUtil.isNull(rMap.get("r_msg"))))
                rMap.put("r_msg", "ERROR.01");

            logger.info(":::ez016 Exception::::" + rMap);
            logger.error(e.getMessage());

        } finally {

            // 중복 결재 방지를 위해 필드 업데이트.
            aMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));
            aMap.put("flag", "batch_approval_end");
            aMap.put("doc_cd", strCheckDocCd);
            worksApprovalDocService.dPrcDocApprovalFlagUpdate(aMap);

        }

        logger.info("일괄결재 처리 메세지 : " + rMap.get("r_msg"));

        ModelAndView output = null;
        output = new ModelAndView("result/t_result");
        output.addObject("rMap", rMap);

        return output;
    }

    public ModelAndView ez017(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);

        ModelAndView output = null;

        CommonBean commonbean = commonService.dGetDefJobCnt(paramMap);

        output = new ModelAndView("ezjobs/t/works/ajaxReturn");
        output = new ModelAndView("common/inc/ajaxReturn");

        output.addObject("commonbean", commonbean);

        return output;
    }

    public ModelAndView ez018(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);

        String currentPage = CommonUtil.isNull(paramMap.get("currentPage"));
        String rowCnt = CommonUtil.isNull(paramMap.get("rowCnt"), CommonUtil.isNull(req.getSession().getAttribute("DEFAULT_PAGING")));
        int rowSize = 0;

        if (!rowCnt.equals("")) {
            rowSize = Integer.parseInt(rowCnt);
        } else {
            rowSize = Integer.parseInt(CommonUtil.getMessage("PAGING.ROWSIZE.BASIC"));
        }

        int pageSize = Integer.parseInt(CommonUtil.getMessage("PAGING.PAGESIZE.BASIC"));

        CommonBean bean = worksApprovalDocService.dGetJobGroupListCnt(paramMap);

        Paging paging = new Paging(bean.getTotal_count(), rowSize, pageSize, currentPage);

        paramMap.put("startRowNum", paging.getStartRowNum());
        paramMap.put("endRowNum", paging.getEndRowNum());

        List jobGroupList = worksApprovalDocService.dGetJobGroupList(paramMap);

        ModelAndView output = null;
//		output = new ModelAndView("ezjobs/t/works/jobGroupList");
        output = new ModelAndView("contents/jobGroupList");

        output.addObject("Paging", paging);
        output.addObject("totalCount", paging.getTotalRowSize());
        output.addObject("rowSize", rowSize);
        output.addObject("jobGroupList", jobGroupList);

        return output;
    }

    // 일괄 작업 등록 리스트 엑셀 출력.
    public ModelAndView ez018_excel(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);

        paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
        paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));


        List jobGroupList = worksApprovalDocService.dGetJobGroupList(paramMap);

        ModelAndView output = null;
//		output = new ModelAndView("ezjobs/t/works/jobGroupExcel");
        output = new ModelAndView("contents/jobGroupListExcel");
        output.addObject("jobGroupList", jobGroupList);

        return output;
    }

    public ModelAndView ez019(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);
        paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
        paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));
        JobGroupBean jobGroupBean = worksApprovalDocService.dGetJobGroupDetail(paramMap);

        ModelAndView output = null;
//		output = new ModelAndView("ezjobs/t/works/jobGroupDetail");
//		output = new ModelAndView("contents/jobGroupDetail");
        output = new ModelAndView("works/P/contents/popup/popJobGroupDetail");
        output.addObject("jobGroupBean", jobGroupBean);

//		CommonBean bean = worksApprovalDocService.dGetJobGroupDetailListCnt(paramMap);
        output.addObject("jobGroupBean", jobGroupBean);
        output.addObject("cm", CommonUtil.getComScodeList(paramMap));
        List jobGroupDetailList = worksApprovalDocService.dGetJobGroupDetailList(paramMap);

        output.addObject("jobGroupDetailList", jobGroupDetailList);
//		output.addObject("totalCount",bean.getTotal_count());

        return output;
    }

    // 그룹 상세 리스트 엑셀 출력.
    public ModelAndView ez019_excel(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);

        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));
        List jobGroupDetailList = worksApprovalDocService.dGetJobGroupDetailList(paramMap);

        ModelAndView output = null;
//		output = new ModelAndView("ezjobs/t/works/jobGroupExcel");
        output = new ModelAndView("contents/jobGroupExcel");
        output.addObject("jobGroupDetailList", jobGroupDetailList);

        return output;
    }

    // 수시작업 상세 등록.
    public ModelAndView ez020_w(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);
        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));

        Map<String, Object> rMap = new HashMap<String, Object>();

//		ModelAndView output = new ModelAndView("ezjobs/t/result");
        ModelAndView output = new ModelAndView("result/t_result");


        try {

            rMap = worksApprovalDocService.dPrcJobGroup(paramMap);

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

    // 수시작업 등록.
    public ModelAndView ez020_group_i(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);

        paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));

        Map<String, Object> rMap = new HashMap<String, Object>();

//		ModelAndView output = new ModelAndView("ezjobs/t/result");
        ModelAndView output = new ModelAndView("result/t_result");

        try {
            String jobGroupName = CommonUtil.isNull(paramMap.get("jobgroup_name"));

            if (jobGroupName.getBytes().length > 52) {
                rMap.put("r_code", "-2");
                rMap.put("r_msg", "그룹명이 너무 깁니다. 한글은 26자, 영문은 52자 이내로 입력해주시기 바랍니다.");

                output.addObject("rMap", rMap);
                return output;
            }

            rMap = worksApprovalDocService.dPrcJobGroup(paramMap);

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

        // 신규 등록일 경우 저장된 그룹 아이디 값을 알아야 저장 후 바로 수정화면으로 이동할 수 있으므로.
        if (!paramMap.containsKey("jobgroup_id")) { // 그룹 리스트에 id 값이 없을경우 실행 (신규 등록일 경우)
            JobGroupBean jobGroupBean = worksApprovalDocService.dGetJobGroupDetailId(paramMap);
            rMap.put("jobgroup_id", jobGroupBean.getJobgroup_id());
        }

        output.addObject("rMap", rMap);

        return output;
    }

    // 수시작업 삭제.
    public ModelAndView ez020_group_d(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);
        paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));

        Map<String, Object> rMap = new HashMap<String, Object>();

//		ModelAndView output = new ModelAndView("ezjobs/t/result");
        ModelAndView output = new ModelAndView("result/t_result");

        try {

            rMap = worksApprovalDocService.dPrcJobGroup(paramMap);

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

    // 작업 ORDER 결재 요청 (관리자 즉시결재 포함).
    public ModelAndView ez021_w(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);

        Map<String, Object> rMap = new HashMap<String, Object>();

        Map<String, Object> ArrMap = new HashMap<String, Object>();
        Map<String, Object> ArrMap2 = new HashMap<String, Object>();

        StringBuffer result_sb = new StringBuffer();

        paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
        paramMap.put("s_user_gb", CommonUtil.isNull(req.getSession().getAttribute("USER_GB")));
        paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));

        String strFlag = CommonUtil.isNull(paramMap.get("flag"));
        String strMainDocCd = "";

        try {

            String strJobName = "";
            String strDataCenter = "";

            //1
            // 1String strFlag 				= CommonUtil.isNull(paramMap.get("flag"));
            String strTitle = CommonUtil.isNull(paramMap.get("title"));
            String s_user_gb = CommonUtil.isNull(paramMap.get("s_user_gb"));
            String strPostApprovalYn = CommonUtil.isNull(paramMap.get("post_approval_yn"));
            String hold_yn = CommonUtil.isNull(paramMap.get("hold_yn"));
            String odate = CommonUtil.isNull(paramMap.get("order_date"));
            String group_yn = CommonUtil.isNull(paramMap.get("group_yn"));

            String job_name[] = CommonUtil.isNull(paramMap.get("job_name")).split(",");
            String table_name[] = CommonUtil.isNull(paramMap.get("table_name")).split(",");
            String application[] = CommonUtil.isNull(paramMap.get("application")).split(",");
            String group_name[] = CommonUtil.isNull(paramMap.get("group_name")).split(",");
            String t_set[] = CommonUtil.isNull(paramMap.get("t_set")).split(",");
            String table_id[] = CommonUtil.isNull(paramMap.get("table_id")).split(",");
            String job_id[] = CommonUtil.isNull(paramMap.get("job_id")).split(",");
            String force_yn[] = CommonUtil.isNull(paramMap.get("force_yn")).split(",");

            int successCnt = 0;
            String r_code = "";
            String r_msg = "";

            for (int i = 0; i < job_name.length; i++) {

                try {

                    strJobName = CommonUtil.isNull(job_name[i]);
                    strDataCenter = CommonUtil.isNull(paramMap.get("data_center"));

                    ArrMap.put("SCHEMA", CommonUtil.isNull(paramMap.get("SCHEMA")));
                    ArrMap.put("s_user_cd", CommonUtil.isNull(paramMap.get("s_user_cd")));
                    ArrMap.put("s_user_gb", CommonUtil.isNull(paramMap.get("s_user_gb")));
                    ArrMap.put("s_user_ip", CommonUtil.isNull(paramMap.get("s_user_ip")));
                    ArrMap.put("data_center", strDataCenter);
                    ArrMap.put("title", strTitle);

                    ArrMap.put("flag", strFlag);
                    ArrMap.put("post_approval_yn", strPostApprovalYn);
                    ArrMap.put("grp_approval_userList", CommonUtil.isNull(paramMap.get("grp_approval_userList")));
                    ArrMap.put("grp_alarm_userList", CommonUtil.isNull(paramMap.get("grp_alarm_userList")));

                    if (i == 0 && group_yn.equals("Y")) {

                        ArrMap.put("job_name", strJobName + "외 " + (job_name.length - 1) + "건");
                        ArrMap.put("ori_doc_gb", "09");
                        ArrMap.put("doc_gb", CommonUtil.isNull(paramMap.get("doc_gb")));
                        ArrMap.put("group_main", "Y");

                        rMap = worksApprovalDocService.dPrcDoc(ArrMap);
                        if (!"1".equals(CommonUtil.isNull(rMap.get("r_code")))) throw new DefaultServiceException(rMap);

                        strMainDocCd = CommonUtil.isNull(rMap.get("r_doc_cd"));
                        ArrMap.put("main_doc_cd", strMainDocCd);
                    }

                    if (!CommonUtil.isNull(t_set[i]).equals("")) {
                        t_set[i] = CommonUtil.replaceStrHtml(t_set[i]);
                    }

                    ArrMap.put("job_name", job_name[i]);
                    ArrMap.put("table_name", table_name[i]);
                    ArrMap.put("application", application[i]);
                    ArrMap.put("group_name", group_name[i]);
                    ArrMap.put("table_id", table_id[i]);
                    ArrMap.put("job_id", job_id[i]);
                    ArrMap.put("force_yn", force_yn[i]);
                    ArrMap.put("t_set", t_set[i].equals("/") ? null : t_set[i].replaceAll("!", ","));

                    ArrMap.put("flag", strFlag);
                    ArrMap.put("order_date", odate);
                    ArrMap.put("hold_yn", hold_yn);
                    ArrMap.put("post_approval_yn", strPostApprovalYn);

                    ArrMap.put("e_order_date", CommonUtil.isNull(paramMap.get("e_order_date")));
                    ArrMap.put("force_gubun", CommonUtil.isNull(paramMap.get("force_gubun")));
                    ArrMap.put("order_cnt", CommonUtil.isNull(paramMap.get("order_cnt")));
                    ArrMap.put("doc_gb", CommonUtil.isNull(paramMap.get("doc_gb")));
                    ArrMap.put("userToken", CommonUtil.isNull(paramMap.get("userToken")));
                    ArrMap.put("check_job_names", CommonUtil.isNull(paramMap.get("check_job_names")));
                    ArrMap.put("check_job_ids", CommonUtil.isNull(paramMap.get("check_job_ids")));
                    ArrMap.put("check_sched_tables", CommonUtil.isNull(paramMap.get("check_sched_tables")));
                    ArrMap.put("active_net_name", CommonUtil.isNull(paramMap.get("active_net_name")));
                    ArrMap.put("data_center_code", CommonUtil.isNull(paramMap.get("data_center_code")));
                    ArrMap.put("check_table_ids", CommonUtil.isNull(paramMap.get("check_table_ids")));

                    ArrMap.put("days_cal", CommonUtil.isNull(paramMap.get("days_cal")));
                    ArrMap.put("doc_cnt", CommonUtil.isNull(paramMap.get("doc_cnt")));
                    ArrMap.put("group_main", "N");

                    if (odate.length() != 8) {
                        if (odate.equals("ODAT")) {

                        } else {
                            rMap.put("r_code", "-1");
                            rMap.put("r_msg", "ERROR.74");
                            throw new DefaultServiceException(rMap);
                        }
                    } else {
                        if (!odate.matches("\\d*")) {
                            rMap.put("r_code", "-1");
                            rMap.put("r_msg", "ERROR.74");
                            throw new DefaultServiceException(rMap);
                        }
                    }

                    //요청서 생성 및 API 진행
                    //if ("draft_admin".equals(strFlag) || "draft_admin".equals(strFlag)) {
                    //rMap = worksApprovalDocService.dPrcDocAdmin(ArrMap);
                    //} else {
                    //rMap = worksApprovalDocService.dPrcDoc(ArrMap);
                    //}

                    rMap = worksApprovalDocService.dPrcDoc(ArrMap);

                    r_code = CommonUtil.isNull(rMap.get("r_code"));

                    if ("1".equals(CommonUtil.isNull(rMap.get("r_code")))) successCnt++;

                    if (!"1".equals(r_code)) throw new DefaultServiceException(rMap);

                } catch (DefaultServiceException e) {

                    rMap = e.getResultMap();

                    if ("-2".equals(CommonUtil.isNull(rMap.get("r_code")))) {
                        logger.error(CommonUtil.isNull(rMap.get("r_msg")));
                        r_msg = CommonUtil.isNull(rMap.get("r_msg"));
                    } else {
                        logger.error(e.getMessage());
                        r_msg = CommonUtil.isNull(e.getMessage());
                    }

                    r_msg = CommonUtil.getMessage(CommonUtil.isNull(rMap.get("r_msg")));
                    if (r_msg.equals("")) {
                        r_msg = CommonUtil.isNull(rMap.get("r_msg"));
                    }

                    result_sb.append((i + 1) + "번째1 [" + strJobName + "] 처리 에러 : " + r_msg + "\\n");

                } catch (IOException e) {
                    if ("".equals(CommonUtil.isNull(rMap.get("r_code"))))
                        rMap.put("r_code", "-1");
                    if ("".equals(CommonUtil.isNull(rMap.get("r_msg"))))
                        rMap.put("r_msg", e.toString());
                } catch (Exception e) {
                    if ("".equals(CommonUtil.isNull(rMap.get("r_code"))))
                        rMap.put("r_code", "-1");
                    if ("".equals(CommonUtil.isNull(rMap.get("r_msg"))))
                        rMap.put("r_msg", "ERROR.01");
                    r_msg = CommonUtil.isNull(rMap.get("r_msg"));
                    logger.error(e.getMessage());

                    result_sb.append((i + 1) + "번째2 [" + strJobName + "] 처리 에러 : " + r_msg + "\\n");
                }

            }

            String group_main = "";
            String doc_cnt = "";

            //관리자즉시결재 반영하는 구간
            if ("draft_admin".equals(strFlag) && successCnt != 0) {

                if (strMainDocCd.equals("")) {
                    group_main = "N";
                    doc_cnt = "0";
                } else {
                    group_main = "Y";
                    doc_cnt = "1";
                }
                ArrMap.put("doc_cd", CommonUtil.isNull(strMainDocCd, CommonUtil.isNull(rMap.get("r_doc_cd"))));
                ArrMap.put("approval_cd", "02");
                ArrMap.put("approval_seq", "1");
                ArrMap.put("group_main", group_main);
                ArrMap.put("doc_cnt", doc_cnt);
                ArrMap.put("flag", "approval");
                rMap = worksApprovalDocService.dPrcDocApproval(ArrMap);
                r_code = CommonUtil.isNull(rMap.get("r_code"));

            }

            if (successCnt > 0) result_sb.append(job_name.length + "건의 작업 중 " + successCnt + "건 처리 완료");
            //후결 : 반영실패 시 일괄요청서 작업명 UDT
            if (job_name.length != successCnt && group_yn.equals("Y")) {
                ArrMap.put("job_name", strJobName + "외 " + (successCnt - 1) + "건");
                ArrMap.put("ori_doc_gb", "09");
                ArrMap.put("group_main", "Y");
                ArrMap.put("flag", "udt");

                rMap = worksApprovalDocService.dPrcDoc(ArrMap);
                if (!"1".equals(CommonUtil.isNull(rMap.get("r_code")))) throw new DefaultServiceException(rMap);
            }

            rMap.put("r_code", "1");
            rMap.put("r_msg", result_sb.toString());

        } catch (Exception ee) {
            if ("".equals(CommonUtil.isNull(rMap.get("r_code"))))
                rMap.put("r_code", "-1");
            if ("".equals(CommonUtil.isNull(rMap.get("r_msg"))))
                rMap.put("r_msg", "ERROR.01");

            logger.error(ee.getMessage());
        }

        ModelAndView output = new ModelAndView("result/t_result");

        output.addObject("rMap", rMap);

        return output;
    }

    // 작업 ORDER 그룹 결재요청.
    public ModelAndView ez021_jg(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);

        Map<String, Object> rMap = new HashMap<String, Object>();
        Map<String, Object> ArrMap = new HashMap<String, Object>();
        StringBuffer result_sb = new StringBuffer();

        paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
        paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
        paramMap.put("s_dept_cd", CommonUtil.isNull(req.getSession().getAttribute("DEPT_CD")));
        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));

        String strMainDocCd = "";

        String strFlag = CommonUtil.isNull(paramMap.get("flag"));
        String strJobGroupId = CommonUtil.isNull(paramMap.get("jobgroup_id"));
        String order_date = CommonUtil.isNull(paramMap.get("order_date"));
        String e_order_date = CommonUtil.isNull(paramMap.get("e_order_date"));
        String days_cal = CommonUtil.isNull(paramMap.get("days_cal"));
        String wait_yn = CommonUtil.isNull(paramMap.get("wait_yn"));
        String s_user_gb = CommonUtil.isNull(req.getSession().getAttribute("USER_GB"));
        String s_user_cd = CommonUtil.isNull(req.getSession().getAttribute("USER_CD"));

        int successCnt = 0;
        String r_code = "";
        String r_msg = "";

        // 폴더 권한 체크에 필요 (2023.09.27 강명준)
        paramMap.put("s_user_gb", s_user_gb);
        paramMap.put("user_cd", s_user_cd);

        try {

            String strDc = "";
            String strScodeCd = "";
            String strDataCenter = "";
            String strTableId = "";
            String strJobId = "";
            String strSchedTable = "";
            String strJobName = "";
            String strApplication = "";
            String strGroupName = "";

            List jobGroupDetailList = worksApprovalDocService.dGetJobGroupDetailList(paramMap);

            // 사전 작업 진행
            // DOC_GROUP 1건 등록, DOC_MASTER 미결 상태로 1건 등록, DOC_05 1건 등록
            rMap = worksApprovalDocService.dPrcDocGroup(paramMap);

            if (!"1".equals(CommonUtil.isNull(rMap.get("r_code")))) throw new DefaultServiceException(rMap);

            strMainDocCd = CommonUtil.isNull(rMap.get("r_doc_cd"));

            //List jobGroupDetailList = worksApprovalDocService.dGetJobGroupDetailList(paramMap);

            for (int i = 0; i < jobGroupDetailList.size(); i++) {

                try {

                    DefJobBean bean = (DefJobBean) jobGroupDetailList.get(i);

                    strDc = CommonUtil.isNull(bean.getData_center());
                    strScodeCd = CommonUtil.isNull(bean.getScode_cd());
                    strDataCenter = strScodeCd + "," + strDc;
                    strTableId = CommonUtil.isNull(bean.getTable_id());
                    strJobId = CommonUtil.isNull(bean.getJob_id());
                    strSchedTable = CommonUtil.isNull(bean.getSched_table());
                    strApplication = CommonUtil.isNull(bean.getApplication());
                    strGroupName = CommonUtil.isNull(bean.getGroup_name());
                    strJobName = CommonUtil.isNull(bean.getJob_name());

                    paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));
                    paramMap.put("data_center", strDataCenter);
                    paramMap.put("table_id", strTableId);
                    paramMap.put("job_id", strJobId);
                    paramMap.put("table_name", strSchedTable);
                    paramMap.put("application", strApplication);
                    paramMap.put("group_name", strGroupName);
                    paramMap.put("job_name", strJobName);
                    paramMap.put("jobgroup_id", strJobGroupId);
                    paramMap.put("main_doc_cd", strMainDocCd);
                    paramMap.put("flag", strFlag);
                    paramMap.put("order_date", order_date);
                    paramMap.put("e_order_date", e_order_date);
                    paramMap.put("days_cal", days_cal);
                    paramMap.put("doc_gb", "05");
                    paramMap.put("doc_cnt", "0");
                    paramMap.put("wait_for_odate_yn", wait_yn);

                    rMap = worksApprovalDocService.dPrcDoc(paramMap);

                    if (!"1".equals(CommonUtil.isNull(rMap.get("r_code")))) throw new DefaultServiceException(rMap);

                    successCnt++;

                } catch (DefaultServiceException e) {

                    rMap = e.getResultMap();

                    if ("-2".equals(CommonUtil.isNull(rMap.get("r_code")))) {
                        logger.error(CommonUtil.isNull(rMap.get("r_msg")));
                        r_msg = CommonUtil.isNull(rMap.get("r_msg"));
                    } else {
                        logger.error(e.getMessage());
                        r_msg = CommonUtil.isNull(e.getMessage());
                    }

                    result_sb.append((i + 1) + "번째 [" + strJobName + "] 처리 에러 : " + r_msg + "\\n");

                } catch (Exception e) {
                    if ("".equals(CommonUtil.isNull(rMap.get("r_code"))))
                        rMap.put("r_code", "-1");
                    if ("".equals(CommonUtil.isNull(rMap.get("r_msg"))))
                        rMap.put("r_msg", "ERROR.01");

                    r_msg = CommonUtil.isNull(rMap.get("r_msg"));

                    result_sb.append((i + 1) + "번째 [" + strJobName + "] 처리 에러 : " + r_msg + "\\n");
                }
            }

            if (successCnt > 0) {
                result_sb.append("그룹 안 " + jobGroupDetailList.size() + "건의 작업 중 " + successCnt + "건 처리 완료");


            }
        } catch (DefaultServiceException e) {

            rMap = e.getResultMap();

            if ("-2".equals(CommonUtil.isNull(rMap.get("r_code")))) {
                logger.error(CommonUtil.isNull(rMap.get("r_msg")));
            } else {
                logger.error(e.getMessage());
            }

            r_msg = CommonUtil.isNull(rMap.get("r_msg"));

            result_sb.append("처리 에러 : " + r_msg + "\\n");

        } catch (Exception e) {

            if ("".equals(CommonUtil.isNull(rMap.get("r_code"))))
                rMap.put("r_code", "-1");
            if ("".equals(CommonUtil.isNull(rMap.get("r_msg"))))
                rMap.put("r_msg", "ERROR.01");

            logger.error(e.getMessage());

        } finally {

            // 그룹의 메인문서도 즉시 결재 처리를 위해 결재를 한번 태운다. (2023.09.20 강명준)
            if (strFlag.equals("draft_admin")) {
                paramMap.put("doc_cd", strMainDocCd);
                paramMap.put("approval_cd", "02");
                paramMap.put("approval_seq", "1");
                paramMap.put("doc_cnt", successCnt);
                paramMap.put("group_main", "Y");
                rMap = worksApprovalDocService.dPrcDocApproval(paramMap);
            } else if (successCnt == 0) {
                // 그룹의 메인문서 apply_cd 를 적용시키는 구간
                paramMap.put("flag", "del");
                paramMap.put("doc_cd", strMainDocCd);
                rMap = worksApprovalDocService.dPrcDocApprovalFlagUpdate(paramMap);

            }

		/*	// 그룹의 메인문서 apply_cd 를 적용시키는 구간
			paramMap.put("flag", "group_approval_end");
			paramMap.put("doc_cd", strMainDocCd);
			rMap = worksApprovalDocService.dPrcDocApprovalFlagUpdate(paramMap);*/

            // 승인 요청은 그룹의 메인으로 결재자 알림 발송
            String sendApprovalNoti = CommonUtil.isNull(rMap.get("sendApprovalNoti"));
            if (sendApprovalNoti.equals("Y")) {
                int iSendResult = CommonUtil.sendApprovalNoti(strMainDocCd);
                logger.info("sendApprovalNoti Result : " + iSendResult);
            }
            String jobApplyChk = CommonUtil.isNull(rMap.get("jobApplyChk"));
            // 후결-후결일 경우 반영하기 위해 한번 더 태운다.
            if (jobApplyChk.equals("Y") && strFlag.equals("post_draft")) {

                paramMap.put("flag", "post_draft");
                paramMap.put("approval_comment", "");
                paramMap.put("doc_cd", strMainDocCd);
                paramMap.put("doc_cnt", successCnt);
                paramMap.put("group_main", "Y");
                rMap = worksApprovalDocService.dPrcDocApproval(paramMap);

            }

            String sendInsUserNoti = CommonUtil.isNull(rMap.get("sendInsUserNoti"));
            if (sendInsUserNoti.equals("Y")) {
                int iSendResult = CommonUtil.sendInsUserNoti(strMainDocCd);
                logger.info("sendInsUserNoti Result : " + iSendResult);
            }
        }

        rMap.put("r_code", "1");
        rMap.put("r_msg", result_sb.toString());

        ModelAndView output = new ModelAndView("result/t_result");
        output.addObject("rMap", rMap);

        return output;
    }

    // 상태 변경 결재 요청 (관리자 즉시결재 포함).
    public ModelAndView ez022_w(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);

        Map<String, Object> rMap = new HashMap<String, Object>();
        Map<String, Object> ArrMap = new HashMap<String, Object>();
        StringBuffer result_sb = new StringBuffer();

        paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
        paramMap.put("s_user_gb", CommonUtil.isNull(req.getSession().getAttribute("USER_GB")));
        paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));

        try {

            ArrMap.put("active_net_name", CommonUtil.getCtmActiveNetName(paramMap));

            String strOrderId = "";
            String strOdate = "";
            String strTableName = "";
            String strApplication = "";
            String strGroupName = "";
            String strJobName = "";
            String strDescription = "";
            String strBeforeStatus = "";

            String strFlag = CommonUtil.isNull(paramMap.get("flag"));
            String strDataCenter = CommonUtil.isNull(paramMap.get("data_center"));
            String strJobStatus = CommonUtil.isNull(paramMap.get("group_status"));
            String strTitle = CommonUtil.isNull(paramMap.get("title"));
            String s_user_gb = CommonUtil.isNull(paramMap.get("s_user_gb"));
            String grp_approval_userList = CommonUtil.isNull(paramMap.get("grp_approval_userList"));
            String grp_alarm_userList = CommonUtil.isNull(paramMap.get("grp_alarm_userList"));
            String strPostApprovalYn = CommonUtil.isNull(paramMap.get("post_approval_yn"));
            //일괄요청유무
            String group_yn = CommonUtil.isNull(paramMap.get("group_yn"));
            String strDocGb = CommonUtil.isNull(paramMap.get("doc_gb"));

            logger.info("::ez022_w::group_yn : " + group_yn);

            String order_id[] = CommonUtil.isNull(paramMap.get("order_ids")).split(",");
            String odate[] = CommonUtil.isNull(paramMap.get("odates")).split(",");
            String table_name[] = CommonUtil.isNull(paramMap.get("table_names")).split(",");
            String application[] = CommonUtil.isNull(paramMap.get("applications")).split(",");
            String group_name[] = CommonUtil.isNull(paramMap.get("group_names")).split(",");
            String job_name[] = CommonUtil.isNull(paramMap.get("job_names")).split(",");

            // 작업 설명이 없을 경우 split 뒤에 -1 을 안붙이면 자바 오류 발생 (2023.11.06 강명준)
            String description[] = CommonUtil.isNull(paramMap.get("descriptions")).split(",", -1);

            String before_status[] = CommonUtil.isNull(paramMap.get("before_statuses")).split(",");

            int successCnt = 0;
            String r_code = "";
            String r_msg = "";
            String strMainDocCd = "";
            String job = "";

            for (int i = 0; i < order_id.length; i++) {

                try {

                    strOrderId = CommonUtil.isNull(order_id[i]);
                    strOdate = CommonUtil.isNull(odate[i]);
                    strTableName = CommonUtil.isNull(table_name[i]);
                    strApplication = CommonUtil.isNull(application[i]);
                    strGroupName = CommonUtil.isNull(group_name[i]);
                    strJobName = CommonUtil.isNull(job_name[i]);
                    strDescription = CommonUtil.isNull(description[i]);
                    strBeforeStatus = CommonUtil.isNull(before_status[i]);

                    strOdate = strOdate.replaceAll("/", "");
                    strOdate = strOdate.substring(2, strOdate.length());

                    ArrMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));
                    ArrMap.put("s_user_cd", CommonUtil.isNull(paramMap.get("s_user_cd")));
                    ArrMap.put("s_user_gb", CommonUtil.isNull(paramMap.get("s_user_gb")));
                    ArrMap.put("s_user_ip", CommonUtil.isNull(paramMap.get("s_user_ip")));
                    ArrMap.put("data_center", strDataCenter);

                    ArrMap.put("doc_gb", strDocGb);
                    //ArrMap.put("doc_cnt", CommonUtil.isNull(paramMap.get("doc_cnt")));
                    ArrMap.put("flag", strFlag);

                    ArrMap.put("title", strTitle);
                    ArrMap.put("grp_approval_userList", grp_approval_userList);
                    ArrMap.put("grp_alarm_userList", grp_alarm_userList);
                    ArrMap.put("post_approval_yn", strPostApprovalYn);

                    //일괄요청서 생성(group_yn : 일괄요청유무)
                    if (i == 0 && group_yn.equals("Y")) {

                        ArrMap.put("job_name", strJobName + "외 " + (order_id.length - 1) + "건");
                        ArrMap.put("ori_doc_gb", "09");
                        ArrMap.put("group_main", group_yn);

                        rMap = worksApprovalDocService.dPrcDoc(ArrMap);
                        if (!"1".equals(CommonUtil.isNull(rMap.get("r_code")))) throw new DefaultServiceException(rMap);

                        strMainDocCd = CommonUtil.isNull(rMap.get("r_doc_cd"));
                        System.out.println("strMainDoc:::" + CommonUtil.isNull(rMap.get("r_msg")));
                        System.out.println("strMainDoc:::" + strMainDocCd);
                        ArrMap.put("main_doc_cd", strMainDocCd);
                    }

                    ArrMap.put("job_name", strJobName);
                    ArrMap.put("description", strDescription);
                    ArrMap.put("before_status", strBeforeStatus);
                    ArrMap.put("after_status", strJobStatus);
                    ArrMap.put("order_id", strOrderId);
                    ArrMap.put("odate", strOdate);

                    ArrMap.put("table_name", strTableName);
                    ArrMap.put("application", strApplication);
                    ArrMap.put("group_name", strGroupName);
                    ArrMap.put("group_main", "");

                    if ("draft_admin".equals(strFlag) || "draft_admin".equals(strFlag)) {

                        rMap = worksApprovalDocService.dPrcDocAdmin(ArrMap);

                    } else {

                        rMap = worksApprovalDocService.dPrcDoc(ArrMap);
                    }

                    r_code = CommonUtil.isNull(rMap.get("r_code"));

                    if ("1".equals(r_code)) {
                        successCnt++;
                        job = strJobName;
                    }
                    if (!"1".equals(r_code)) throw new DefaultServiceException(rMap);

                } catch (DefaultServiceException e) {

                    rMap = e.getResultMap();

                    if ("-2".equals(CommonUtil.isNull(rMap.get("r_code")))) {
                        logger.error(CommonUtil.isNull(rMap.get("r_msg")));
                        r_msg = CommonUtil.isNull(rMap.get("r_msg"));
                    } else {
                        logger.error(e.getMessage());
                        r_msg = CommonUtil.isNull(e.getMessage());
                    }

                    result_sb.append((i + 1) + "번째 [" + strJobName + "] 처리 에러 : " + r_msg + "\\n");

                } catch (Exception e) {
                    if ("".equals(CommonUtil.isNull(rMap.get("r_code"))))
                        rMap.put("r_code", "-1");
                    if ("".equals(CommonUtil.isNull(rMap.get("r_msg"))))
                        rMap.put("r_msg", "ERROR.01");

                    r_msg = CommonUtil.isNull(rMap.get("r_msg"));

                    logger.error(e.getMessage());

                    result_sb.append((i + 1) + "번째 [" + strJobName + "] 처리 에러 : " + r_msg + "\\n");
                }
            }

            if (successCnt > 0) result_sb.append(order_id.length + "건의 작업 중 " + successCnt + "건 처리 완료");

            if (order_id.length != successCnt) {
                String succCnt = "";
                if (successCnt > 1) {
                    succCnt = "외 " + (successCnt - 1) + "건";
                }
                paramMap.put("job_name", job + succCnt);
                paramMap.put("ori_doc_gb", "09");
                paramMap.put("group_main", "Y");
                paramMap.put("flag", "udt");
                paramMap.put("doc_cd", strMainDocCd);
                rMap = worksApprovalDocService.dPrcDoc(paramMap);
                if (!"1".equals(CommonUtil.isNull(rMap.get("r_code")))) throw new DefaultServiceException(rMap);
            }

            // 그룹의 메인문서 apply_cd 를 적용시키는 구간
            paramMap.put("flag", "group_approval_end");
            paramMap.put("doc_cd", strMainDocCd);
            rMap = worksApprovalDocService.dPrcDocApprovalFlagUpdate(paramMap);

            // 승인 요청은 그룹의 메인으로 결재자 알림 발송
            String sendApprovalNoti = CommonUtil.isNull(rMap.get("sendApprovalNoti"));
            if (sendApprovalNoti.equals("Y")) {
                int iSendResult = CommonUtil.sendApprovalNoti(strMainDocCd);
                logger.info("sendApprovalNoti Result : " + iSendResult);
            }

            String sendInsUserNoti = CommonUtil.isNull(rMap.get("sendInsUserNoti"));
            if (sendInsUserNoti.equals("Y")) {
                int iSendResult = CommonUtil.sendInsUserNoti(strMainDocCd);
                logger.info("sendInsUserNoti Result : " + iSendResult);
            }

            logger.info("result_sb.toString() " + result_sb.toString());

            rMap.put("r_code", "1");
            rMap.put("r_msg", result_sb.toString());

        } catch (Exception ee) {
            if ("".equals(CommonUtil.isNull(rMap.get("r_code"))))
                rMap.put("r_code", "-1");
            if ("".equals(CommonUtil.isNull(rMap.get("r_msg"))))
                rMap.put("r_msg", "ERROR.01");

            logger.error(ee.getMessage());
        }

        ModelAndView output = new ModelAndView("result/t_result");
        output.addObject("rMap", rMap);

        return output;
    }

    public ModelAndView ez023(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);

        paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));

        ModelAndView output = null;
        CommonBean approvalLineBean = null;

        // 결재할 작업 존재 여부.
        if (!CommonUtil.isNull(req.getSession().getAttribute("USER_CD")).equals("")) {
            approvalLineBean = worksApprovalLineService.dGetApprovalLineCnt(paramMap);
        }

//		output = new ModelAndView("ezjobs/t/works/ajaxReturn");
        output = new ModelAndView("common/inc/ajaxReturn");

        output.addObject("commonbean", approvalLineBean);

        return output;
    }

    //메인 상단 - 결재 건수 조회
    public ModelAndView ez023_pop(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);

        paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));

        ModelAndView output = null;
        CommonBean approvalLineBean = null;

        // 결재할 작업 존재 여부.
        if (!CommonUtil.isNull(req.getSession().getAttribute("USER_CD")).equals("")) {
            approvalLineBean = worksApprovalLineService.dGetApprovalLineCnt_pop(paramMap);
        }

        //최초 로그인 시에만 메인창에서 결재창 노출 시키기 위해 추가
        req.getSession().setAttribute("LOGIN_CHK", "N");

//		output = new ModelAndView("ezjobs/t/works/ajaxReturn");
        output = new ModelAndView("common/inc/ajaxReturn");

        output.addObject("commonbean", approvalLineBean);

        return output;
    }

    public ModelAndView ez024(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);

        String strApprovalCount = CommonUtil.isNull(paramMap.get("approval_count"));

        ModelAndView output = null;

//		output = new ModelAndView("ezjobs/t/popup/approvalCount");
        output = new ModelAndView("contents/popup/approvalCount");

        output.addObject("approval_count", strApprovalCount);

        return output;
    }

    public ModelAndView ez025(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);

        String strApprovalCd = CommonUtil.isNull(paramMap.get("approval_cd"));

        ModelAndView output = new ModelAndView("ezjobs/t/works/table/sched_tag_iframe");

        List tagsList = worksCompanyService.dGetTagsList(paramMap);

        output.addObject("tagsList", tagsList);
        output.addObject("approval_cd", strApprovalCd);

        return output;
    }

    public ModelAndView ez026(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);

        // 한글 GET 방식으로 넘어와서 처리.
        String strTagName = new String(CommonUtil.isNull(paramMap.get("tag_name")).getBytes("ISO-8859-1"), "utf-8");

        ModelAndView output = new ModelAndView("ezjobs/t/works/table/sched_iframe");

        TagsBean tagsBean = worksCompanyService.dGetTagsSchedInfo(paramMap);

        output.addObject("tagsBean", tagsBean);
        output.addObject("tag_name", strTagName);

        return output;
    }

    public ModelAndView ez027(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);
        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));

        Map<String, Object> rMap = new HashMap<String, Object>();

        ModelAndView output = new ModelAndView("ezjobs/t/works/table/sched_tag_iframe");

        List defTagsList = worksCompanyService.dGetDefTagsList(paramMap);

        try {

            if (defTagsList != null) {

                for (int i = 0; i < defTagsList.size(); i++) {
                    TagsBean bean = (TagsBean) defTagsList.get(i);

                    paramMap.put("flag", "def_sched_ins");
                    paramMap.put("tag_name", CommonUtil.isNull(bean.getTag_name()));

                    rMap = worksCompanyService.dPrcTags(paramMap);
                }
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

        List tagsList = worksCompanyService.dGetTagsList(paramMap);

        output.addObject("tagsList", tagsList);

        return output;
    }

    public ModelAndView ez029(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);

        ModelAndView output = new ModelAndView("common/inc/ajaxReturn2");

        CommonBean commonbean = worksCompanyService.dGetTableInfo(paramMap);

        output.addObject("commonBean", commonbean);

        return output;
    }

    public ModelAndView ez030(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);
        Map<String, Object> rMap = new HashMap<String, Object>();

        // 한글 GET 방식으로 넘어와서 처리.
        String strT_TagName = new String(CommonUtil.isNull(paramMap.get("t_tag_name")).getBytes("ISO-8859-1"), "utf-8");
        String strTableName = CommonUtil.isNull(paramMap.get("table_name"));
        String strApprovalCd = CommonUtil.isNull(paramMap.get("approval_cd"));

        ModelAndView output = new ModelAndView("ezjobs/t/works/sched_tag_iframe");

        paramMap.put("tag_name", strT_TagName);
        paramMap.put("table_name", strTableName);
        TagsBean tagsBean = worksCompanyService.dGetTagsInfo(paramMap);
        List tagsList = worksCompanyService.dGetDefTagsList2(paramMap);

        output.addObject("tagsList", tagsList);
        output.addObject("tagsBean", tagsBean);
        output.addObject("tag_name", strT_TagName);
        output.addObject("approval_cd", strApprovalCd);

        return output;
    }

    // 미결재자 수정.
    public ModelAndView ez032_p(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);

        paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
        paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));

        Map<String, Object> rMap = new HashMap<String, Object>();

        try {

            rMap = worksApprovalDocService.dPrcApprovalDocUserUpdate(paramMap);

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


    public ModelAndView ez033(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParametersForecast(req);


        paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
        paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));

        String forecast = "";
        String job_name = CommonUtil.isNull("EZ_SCH_JOB");
        String strNowSecond = DateUtil.getSecond();
        job_name = job_name + "_" + strNowSecond;

        paramMap.put("job_name", job_name);

        CommonUtil.emLogin(req);

        paramMap.put("userToken", CommonUtil.isNull(req.getSession().getAttribute("USER_TOKEN")));

        logger.debug("==================================================================forecast_write_start===========================================================");
        System.out.println("paramMap : " + paramMap);
        // [스케줄용 작업] 1. 등록->업로드 로직.
        paramMap.put("gubun", "write");
        worksApprovalDocService.dJobSchForecast(paramMap);
        logger.debug("==================================================================forecast_write_end===========================================================");

        // API로 작업 한 후 바로 Forecast 구하면 정상적으로 못구해 온다.
        // 그래서 2000미리세컨드 후에 MAX 값 구하기.
        CommonUtil.setTimeout(2000);

        forecast = CommonUtil.getForecastUtil(paramMap);

        logger.debug("==================================================================forecast_del_start===========================================================");
        // [스케줄용 작업] 2. 삭제->업로드 로직.
        paramMap.put("gubun", "delete");
        paramMap.put("table_name", "SCHED_TEST");

        worksApprovalDocService.dJobSchForecast(paramMap);
        logger.debug("==================================================================forecast_del_end===========================================================");
        List calYearList = null;
        calYearList = commonService.dGetCalendarYearList(paramMap);
        ModelAndView output = null;
        output = new ModelAndView("contents/popup/forecast");
        output.addObject("forecast", forecast);
        output.addObject("calYearList", calYearList);

        return output;
    }

    public ModelAndView ez034(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);

        String data_center = CommonUtil.isNull(paramMap.get("data_center"));
        String mem_name = CommonUtil.isNull(paramMap.get("mem_name"));
        String mem_lib = CommonUtil.isNull(paramMap.get("mem_lib"));
        String node_id = CommonUtil.isNull(paramMap.get("node_id"));
        String cmd = "cat " + mem_lib + "/" + mem_name;

        // Host 정보 가져오는 서비스.
        paramMap.put("data_center", data_center);
        paramMap.put("host", node_id);
        paramMap.put("server_gubun", "A");

        CommonBean bean = commonService.dGetHostInfo(paramMap);

        String strHost = "";
        String strAccessGubun = "";
        int iPort = 0;
        String strUserId = "";
        String strUserPw = "";
        String strRemoteFilePath = "";

        if (bean != null) {

            strHost = CommonUtil.isNull(bean.getNode_id());
            strAccessGubun = CommonUtil.isNull(bean.getAccess_gubun());
            iPort = Integer.parseInt(CommonUtil.isNull(bean.getAccess_port()));
            strUserId = CommonUtil.isNull(bean.getAgent_id());
            strUserPw = SeedUtil.decodeStr(CommonUtil.isNull(bean.getAgent_pw()));
            strRemoteFilePath = CommonUtil.isNull(bean.getFile_path());
        }

        String file_content = "";

        if ("S".equals(strAccessGubun)) {
            Ssh2Util su = new Ssh2Util(strHost, iPort, strUserId, strUserPw, cmd, "UTF-8");
            file_content = su.getOutput();
        } else {
            TelnetUtil tu = new TelnetUtil(strHost, iPort, strUserId, strUserPw, cmd);
            file_content = tu.getOutput();
        }

        ModelAndView output = null;
        output = new ModelAndView("contents/popup/file_content");
        output.addObject("file_content", file_content);

        return output;
    }

    public ModelAndView ez035(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);

        Map<String, Object> rMap = new HashMap<String, Object>();

        String doc_gb = CommonUtil.isNull(paramMap.get("doc_gb"));
        String flag = CommonUtil.isNull(paramMap.get("flag"));

        String file_path = req.getSession().getServletContext().getRealPath("/") + CommonUtil.getMessage("DOC_FILE.PATH");

        // 첨부파일의 역슬래쉬를 슬래쉬로 변경해준다.
        file_path = file_path.replaceAll("\\\\", "/");

        paramMap = CommonUtil.collectParametersMultiRandomNm(req, file_path);

        paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
        paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));

        String file_nm = "";
        String save_file_nm = "";

        List fileList = (List) paramMap.get("fileList");

        if (fileList != null && fileList.size() > 0) {

            file_nm = CommonUtil.K2E((String) fileList.get(0));
            save_file_nm = CommonUtil.K2E((String) fileList.get(1));

            paramMap.put("file_nm", file_nm);
            paramMap.put("save_file_nm", save_file_nm);
            paramMap.put("file_path", file_path);

            rMap = worksApprovalDocService.dPrcDoc06(paramMap);

        } else {

            rMap.put("r_code", "-1");
            rMap.put("r_msg", "ERROR.01");
        }

        ModelAndView output = null;
        output = new ModelAndView("ezjobs/t/doc07_w");
        output.addObject("rMap", rMap);

        return output;
    }

    // 일괄요청/수행/상태변경 결재요청
    public ModelAndView ez036(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);

        paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
        paramMap.put("s_user_gb", CommonUtil.isNull(req.getSession().getAttribute("USER_GB")));
        paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));

        Map<String, Object> rMap = new HashMap<String, Object>();
        Map<String, Object> rMap2 = new HashMap<String, Object>();
        Map<String, Object> rMap3 = new HashMap<String, Object>();
        StringBuffer result_sb = new StringBuffer();

        Map<String, Object> ArrMap = new HashMap<String, Object>();
        Map<String, Object> GrpMap = new HashMap<String, Object>();

        StringBuffer sb = new StringBuffer();
        StringBuffer sb2 = new StringBuffer();

        String strFlag = CommonUtil.isNull(paramMap.get("flag"));
        String strTitle = CommonUtil.isNull(paramMap.get("title"));
        String strPostApprovalYn = CommonUtil.isNull(paramMap.get("post_approval_yn"));

        //일괄결재 유무
        String group_yn = CommonUtil.isNull(paramMap.get("group_yn"));

        //수행의뢰 파라미터
        String hold_yn = CommonUtil.isNull(paramMap.get("hold_yn"));
        String wait_yn = CommonUtil.isNull(paramMap.get("wait_yn"));
        String force_yn = CommonUtil.isNull(paramMap.get("force_yn"));
        String order_date = CommonUtil.isNull(paramMap.get("order_date"));
        
        //상태변경 파라미터
        String strJobStatus = CommonUtil.isNull(paramMap.get("group_status"));
        String grp_doc_gb = CommonUtil.isNull(paramMap.get("grp_doc_gb"));
        String doc_cnt = CommonUtil.isNull(paramMap.get("doc_cnt"));

        String error_description = CommonUtil.isNull(paramMap.get("error_description"));

        String job_name[] = CommonUtil.isNull(paramMap.get("job_name")).split("[|]");
        String data_center[] = CommonUtil.isNull(paramMap.get("data_center")).split("[|]");
        String table_name[] = CommonUtil.isNull(paramMap.get("table_name")).split("[|]", -1);
        String application[] = CommonUtil.isNull(paramMap.get("application")).split("[|]", -1);
        String group_name[] = CommonUtil.isNull(paramMap.get("group_name")).split("[|]", -1);
        String doc_gb[] = CommonUtil.isNull(paramMap.get("doc_gb")).split("[|]", -1);
        String t_set[] = CommonUtil.isNull(paramMap.get("t_set")).split("★", -1);
        String table_id[] = CommonUtil.isNull(paramMap.get("table_id")).split("[|]", -1);
        String job_id[] = CommonUtil.isNull(paramMap.get("job_id")).split("[|]", -1);
        String doc_cd[] = CommonUtil.isNull(paramMap.get("doc_cd")).split("[|]", -1);
        String order_id[] = CommonUtil.isNull(paramMap.get("order_ids")).split("[|]", -1);
        String description[] = CommonUtil.isNull(paramMap.get("descriptions")).split("[|]", -1);
        String odate[] = CommonUtil.isNull(paramMap.get("odates")).split("[|]", -1);
        String before_status[] = CommonUtil.isNull(paramMap.get("before_statuses")).split("[|]", -1);

        String alarm_cd[] = CommonUtil.isNull(paramMap.get("alarm_cd")).split("[|]", -1);
        String user_cd[] = CommonUtil.isNull(paramMap.get("user_cd")).split("[|]", -1);

		String order_into_folder = CommonUtil.isNull(paramMap.get("order_into_folder"));

        int successCnt = 0;
        String r_code = "";
        String r_msg = "";
        String strMainDocCd = "";
        String strJobName = "";
		String strDataCenter = "";
        //그룹문서의 작업명을 업데이트할 경우 대비해서 main_job 추가
        String main_job = "";

        //일괄요청서 생성
        try {
            for (int z = 0; z < job_name.length; z++) {
                try {

                    ArrMap.put("SCHEMA", CommonUtil.isNull(paramMap.get("SCHEMA")));
                    ArrMap.put("data_center", data_center[z]);
                    ArrMap.put("s_user_cd", CommonUtil.isNull(paramMap.get("s_user_cd")));
                    ArrMap.put("s_user_gb", CommonUtil.isNull(paramMap.get("s_user_gb")));
                    ArrMap.put("s_user_ip", CommonUtil.isNull(paramMap.get("s_user_ip")));

                    ArrMap.put("flag", strFlag);
                    ArrMap.put("title", strTitle);
                    ArrMap.put("post_approval_yn", strPostApprovalYn);
                    ArrMap.put("grp_approval_userList", CommonUtil.isNull(paramMap.get("grp_approval_userList")));
                    ArrMap.put("grp_alarm_userList", CommonUtil.isNull(paramMap.get("grp_alarm_userList")));
                    ArrMap.put("apply_date", CommonUtil.isNull(paramMap.get("p_apply_date")));
                    // 일괄 요청서 신규로 껍데기 생성 후 그룹 내 문서 결재 처리
                    if (z == 0 && group_yn.equals("Y")) {

                        //GrpMap : 일괄요청서 생성위한 파라미터
                        GrpMap.put("flag", strFlag);
                        GrpMap.put("title", strTitle);
                        GrpMap.put("job_name", job_name[z] + "외 " + (job_name.length - 1) + "건");
                        GrpMap.put("ori_doc_gb", "09");
                        GrpMap.put("doc_gb", grp_doc_gb);
                        GrpMap.put("group_main", "Y");
                        GrpMap.put("apply_date", CommonUtil.isNull(paramMap.get("p_apply_date")));

                        GrpMap.put("post_approval_yn", strPostApprovalYn);
                        GrpMap.put("grp_approval_userList", CommonUtil.isNull(paramMap.get("grp_approval_userList")));
                        GrpMap.put("grp_alarm_userList", CommonUtil.isNull(paramMap.get("grp_alarm_userList")));

                        GrpMap.put("SCHEMA", CommonUtil.isNull(paramMap.get("SCHEMA")));
                        GrpMap.put("data_center", data_center[z]);
                        GrpMap.put("s_user_cd", CommonUtil.isNull(paramMap.get("s_user_cd")));
                        GrpMap.put("s_user_gb", CommonUtil.isNull(paramMap.get("s_user_gb")));
                        GrpMap.put("s_user_ip", CommonUtil.isNull(paramMap.get("s_user_ip")));

                        rMap = worksApprovalDocService.dPrcDoc(GrpMap);
                        if (!"1".equals(CommonUtil.isNull(rMap.get("r_code")))) throw new DefaultServiceException(rMap);
                        //생성 된 껍데기문서의 doc_cd 가져와서 넣어줌
                        strMainDocCd = CommonUtil.isNull(rMap.get("r_doc_cd"));
                        strDataCenter = data_center[z];
                        ArrMap.put("main_doc_cd", strMainDocCd);
                        logger.info("groupApproval || main_doc_cd ::::::: " + strMainDocCd);
                    }
                    if (!CommonUtil.isNull(paramMap.get("t_set")).equals("")) {
                        if (!t_set[z].equals("")) {
                            t_set[z] = CommonUtil.replaceStrHtml(t_set[z]);
                            ArrMap.put("t_set", t_set[z].equals("/") ? null : t_set[z].replaceAll("!", ","));
                        }
                    }

                    ArrMap.put("flag", strFlag);
                    ArrMap.put("post_approval_yn", strPostApprovalYn);
                    ArrMap.put("job_name", job_name[z]);
                    ArrMap.put("doc_gb", doc_gb[z]);
                    ArrMap.put("group_main", "N");

                    //수행/상태변경에 필요한 파라미터 분리
                    if (doc_gb[z].equals("05")) {
                        if (!order_date.equals("")) {
                            if (order_date.length() != 8) {
                                if (order_date.equals("ODAT")) {
                                } else {
                                    rMap.put("r_code", "-1");
                                    rMap.put("r_msg", "ERROR.74");
                                    throw new DefaultServiceException(rMap);
                                }
                            } else {
                                if (!order_date.matches("\\d*")) {
                                    rMap.put("r_code", "-1");
                                    rMap.put("r_msg", "ERROR.74");
                                    throw new DefaultServiceException(rMap);
                                }
                            }
                            ArrMap.put("order_date", order_date);
                        }

                        ArrMap.put("odate", order_date);
                        ArrMap.put("e_order_date", CommonUtil.isNull(paramMap.get("e_order_date")));
                        ArrMap.put("table_name", table_name[z]);
                        ArrMap.put("application", application[z]);
                        ArrMap.put("group_name", group_name[z]);

                        ArrMap.put("table_id", table_id[z]);
                        ArrMap.put("job_id", job_id[z]);
                        ArrMap.put("force_yn", force_yn);
                        ArrMap.put("hold_yn", hold_yn);
                        ArrMap.put("wait_for_odate_yn", wait_yn);

                        ArrMap.put("force_gubun", CommonUtil.isNull(paramMap.get("force_gubun")));
                        ArrMap.put("order_into_folder", order_into_folder);

                    } else if (doc_gb[z].equals("07")) {
                        if (!CommonUtil.isNull(paramMap.get("odates")).equals("")) {
                            if (!odate[z].equals("")) {
                                odate[z] = odate[z].replaceAll("/", "");

                                odate[z] = odate[z].substring(2, odate[z].length());
                            }
                        }

                        ArrMap.put("table_name", table_name[z]);
                        ArrMap.put("application", application[z]);
                        ArrMap.put("group_name", group_name[z]);
                        ArrMap.put("order_id", order_id[z]);
                        ArrMap.put("odate", odate[z]);

                        ArrMap.put("before_status", before_status[z]);
                        ArrMap.put("after_status", strJobStatus);
                        ArrMap.put("description", description[z]);
                        ArrMap.put("hold_status", before_status[z]);
                        ArrMap.put("active_net_name", CommonUtil.getCtmActiveNetName(ArrMap));

                        ActiveJobBean activeJobBean = worksApprovalDocService.dGetAjobStatus(ArrMap);
                        if (activeJobBean != null) {

                            String strStatus = CommonUtil.isNull(activeJobBean.getStatus());

                            ArrMap.put("before_status", strStatus);
                        }

                    } else if (doc_gb[z].equals("10")) {

                        ArrMap.put("error_description", error_description);
                        ArrMap.put("alarm_cd", alarm_cd[z]);
                        ArrMap.put("user_cd", user_cd[z]);

                    } else {
                        ArrMap.put("doc_cd", doc_cd[z]);
                    }

                    ArrMap.put("order_cnt", CommonUtil.isNull(paramMap.get("order_cnt")));
                    ArrMap.put("userToken", CommonUtil.isNull(paramMap.get("userToken")));
                    ArrMap.put("data_center_code", CommonUtil.isNull(paramMap.get("data_center_code")));
                    ArrMap.put("days_cal", CommonUtil.isNull(paramMap.get("days_cal")));
                    ArrMap.put("doc_cnt", CommonUtil.isNull(paramMap.get("doc_cnt")));

                    //요청서 생성 및 API 진행
                    //if ("draft_admin".equals(strFlag) || "draft_admin".equals(strFlag)) {
                    //rMap = worksApprovalDocService.dPrcDocAdmin(ArrMap);
                    //} else {
                    //rMap = worksApprovalDocService.dPrcDoc(ArrMap);
                    //}
                    //요청서 생성
                    rMap = worksApprovalDocService.dPrcDoc(ArrMap);

                    if ("1".equals(CommonUtil.isNull(rMap.get("r_code")))) {
                        successCnt++;
                        main_job = job_name[z];
                    }

                } catch (DefaultServiceException e) {
                    rMap = e.getResultMap();

                    if ("-2".equals(CommonUtil.isNull(rMap.get("r_code")))) {
                        logger.error(CommonUtil.isNull(rMap.get("r_msg")));
                        r_msg = CommonUtil.isNull(rMap.get("r_msg"));
                    } else {
                        logger.error(e.getMessage());
                        r_msg = CommonUtil.isNull(e.getMessage());
                    }

                    //오류메세지 처리
                    r_msg = CommonUtil.getMessage(CommonUtil.isNull(rMap.get("r_msg")));
                    if (r_msg.equals("")) {
                        r_msg = CommonUtil.isNull(rMap.get("r_msg"));
                    }

                    result_sb.append((z + 1) + "번째 [" + job_name[z] + "] : " + r_msg + "\\n");
                    logger.info("groupApproval || DefaultServiceException: " + rMap);
                } catch (Exception e) {
                    if ("".equals(CommonUtil.isNull(rMap.get("r_code"))))
                        rMap.put("r_code", "-1");
                    if ("".equals(CommonUtil.isNull(rMap.get("r_msg"))))
                        rMap.put("r_msg", "ERROR.01");

                    //오류메세지 처리
                    r_msg = CommonUtil.getMessage(CommonUtil.isNull(rMap.get("r_msg")));
                    if (r_msg.equals("")) {
                        r_msg = CommonUtil.isNull(rMap.get("r_msg"));
                    }

                    logger.info("groupApproval || Exception: " + rMap);
                } finally{

                }
            }

            String group_main = "";

            //관리자즉시결재 반영하는 구간
            if ("draft_admin".equals(strFlag) && successCnt != 0) {
                try {
                    //단 건 문서
                    if (strMainDocCd.equals("")) {
                        group_main = "N";
                        doc_cnt = "0";
                    //일괄 문서
                    } else {
                        group_main = "Y";
                        doc_cnt = "1";
                    }

                    GrpMap.put("SCHEMA", CommonUtil.isNull(paramMap.get("SCHEMA")));
                    GrpMap.put("SCHEMA", CommonUtil.isNull(paramMap.get("SCHEMA")));
                    GrpMap.put("data_center", strDataCenter);
                    GrpMap.put("doc_cd", CommonUtil.isNull(strMainDocCd, CommonUtil.isNull(rMap.get("r_doc_cd"))));
                    GrpMap.put("approval_cd", "02");
                    GrpMap.put("approval_seq", "1");
                    GrpMap.put("group_main", group_main);
                    GrpMap.put("doc_cnt", doc_cnt);
                    GrpMap.put("flag", "approval");
                    rMap = worksApprovalDocService.dPrcDocApproval(GrpMap);
                    r_code = CommonUtil.isNull(rMap.get("r_code"));

                } catch (DefaultServiceException e) {
                    rMap = e.getResultMap();

                    if ("-2".equals(CommonUtil.isNull(rMap.get("r_code")))) {
                        logger.error(CommonUtil.isNull(rMap.get("r_msg")));
                        r_msg = CommonUtil.isNull(rMap.get("r_msg"));
                    } else {
                        logger.error(e.getMessage());
                        r_msg = CommonUtil.isNull(e.getMessage());
                    }

                    //오류메세지 처리
                    r_msg = CommonUtil.getMessage(CommonUtil.isNull(rMap.get("r_msg")));
                    if (r_msg.equals("")) {
                        r_msg = CommonUtil.isNull(rMap.get("r_msg"));
                        rMap.put("r_msg",r_msg);
                    }
                    logger.info("groupApproval || DefaultServiceException: " + rMap);
                } catch (Exception e) {
                    if ("".equals(CommonUtil.isNull(rMap.get("r_code"))))
                        rMap.put("r_code", "-1");
                    if ("".equals(CommonUtil.isNull(rMap.get("r_msg"))))
                        rMap.put("r_msg", "ERROR.01");

                    //오류메세지 처리
                    r_msg = CommonUtil.getMessage(CommonUtil.isNull(rMap.get("r_msg")));
                    if (r_msg.equals("")) {
                        r_msg = CommonUtil.isNull(rMap.get("r_msg"));
                    }

                    logger.info("groupApproval || Exception: " + rMap);
                }
            }

            String jobApplyChk = CommonUtil.isNull(rMap.get("jobApplyChk"));
            // 후결-후결일 경우 반영하기 위해 한번 더 태운다.
            if (jobApplyChk.equals("Y") && (strFlag.equals("post_draft"))) {
                GrpMap.put("flag", "post_draft");
                GrpMap.put("approval_comment", "");
                GrpMap.put("doc_cd", strMainDocCd);
                GrpMap.put("doc_cnt", successCnt);
                GrpMap.put("group_main", "Y");
                rMap = worksApprovalDocService.dPrcDocApproval(GrpMap);

            }

            if (successCnt > 0) result_sb.append(job_name.length + "건의 작업 중 " + successCnt + "건 처리 완료");

            //후결 : 반영실패 시 일괄요청서 작업명 UDT
            if (job_name.length != successCnt && group_yn.equals("Y") && successCnt != 0) {
                String succCnt = "";
                if (successCnt > 1) {
                    succCnt = "외 " + (successCnt - 1) + "건";
                }

                GrpMap.put("job_name", main_job + succCnt);
                GrpMap.put("flag", "udt");
                GrpMap.put("doc_cd", strMainDocCd);

                rMap = worksApprovalDocService.dPrcDoc(GrpMap);
                if (!"1".equals(CommonUtil.isNull(rMap.get("r_code")))) throw new DefaultServiceException(rMap);

            } else if (successCnt == 0) {
                //GrpMap.put("flag", "del");
                //GrpMap.put("doc_cd", strMainDocCd);

                //rMap = worksApprovalDocService.dPrcDoc(GrpMap);
                //if (!"1".equals(CommonUtil.isNull(rMap.get("r_code")))) throw new DefaultServiceException(rMap);
            }

        } catch (Exception e) {

            if ("".equals(CommonUtil.isNull(rMap.get("r_code"))))
                rMap.put("r_code", "-1");
            if ("".equals(CommonUtil.isNull(rMap.get("r_msg"))))
                rMap.put("r_msg", "ERROR.01");

            logger.error(e.getMessage());

        } finally {

            // 승인 요청은 그룹의 메인으로 결재자 알림 발송
            String sendApprovalNoti = CommonUtil.isNull(rMap.get("sendApprovalNoti"));

            if (sendApprovalNoti.equals("Y")) {
                int iSendResult = CommonUtil.sendApprovalNoti(CommonUtil.isNull(strMainDocCd, rMap.get("doc_cd")));
                logger.info("sendApprovalNoti Result : " + iSendResult);
            }

            logger.error(CommonUtil.isNull(rMap.get("r_state_cd")));

            String sendInsUserNoti = CommonUtil.isNull(rMap.get("sendInsUserNoti"));
            if (sendInsUserNoti.equals("Y")) {
                int iSendResult = CommonUtil.sendInsUserNoti(CommonUtil.isNull(strMainDocCd, rMap.get("doc_cd")));
                logger.info("sendInsUserNoti Result : " + iSendResult);
            }
        }

        rMap.put("r_code", "1");
        rMap.put("r_msg", result_sb.toString());

        ModelAndView output = null;
        //output = new ModelAndView("ezjobs/t/result");
        output = new ModelAndView("result/t_result");
        output.addObject("rMap", rMap);

        return output;
    }

    public ModelAndView ez003_p_all(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);

        paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
        paramMap.put("s_user_gb", CommonUtil.isNull(req.getSession().getAttribute("USER_GB")));
        paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));

        Map<String, Object> rMap = new HashMap<String, Object>();
        Map<String, Object> rMap2 = new HashMap<String, Object>();
        Map<String, Object> rMap3 = new HashMap<String, Object>();
        StringBuffer result_sb = new StringBuffer();

        Map<String, Object> ArrMap = new HashMap<String, Object>();
        Map<String, Object> GrpMap = new HashMap<String, Object>();

        StringBuffer sb = new StringBuffer();
        StringBuffer sb2 = new StringBuffer();

        String strFlag = CommonUtil.isNull(paramMap.get("flag"));
        String strTitle = CommonUtil.isNull(paramMap.get("title"));
        String strDataCenter = CommonUtil.isNull(paramMap.get("data_center"));
        String strPostApprovalYn = CommonUtil.isNull(paramMap.get("post_approval_yn"), 'N');

        //일괄생성 유무
        String group_yn = CommonUtil.isNull(paramMap.get("group_yn"));

        String grp_doc_gb = CommonUtil.isNull(paramMap.get("grp_doc_gb"));
        String doc_cnt = CommonUtil.isNull(paramMap.get("doc_cnt"));
        String doc_gb = CommonUtil.isNull(paramMap.get("doc_gb"));

        String error_description = CommonUtil.isNull(paramMap.get("error_description"));

        String job_name[] = CommonUtil.isNull(paramMap.get("job_name")).split("[|]");
        String data_center[] = CommonUtil.isNull(paramMap.get("data_center")).split("[|]");

        String alarm_cd[] = CommonUtil.isNull(paramMap.get("alarm_cd")).split("[|]");

        int successCnt = 0;
        String r_code = "";
        String r_msg = "";
        String strMainDocCd = "";
        String strJobName = "";
        //그룹문서의 작업명을 업데이트할 경우 대비해서 main_job 추가
        String main_job = "";

        //일괄요청서 생성
        try {
            for (int z = 0; z < job_name.length; z++) {
                try {
                    ArrMap.put("SCHEMA", CommonUtil.isNull(paramMap.get("SCHEMA")));
                    ArrMap.put("data_center", data_center[z]);
                    ArrMap.put("s_user_cd", CommonUtil.isNull(paramMap.get("s_user_cd")));
                    ArrMap.put("s_user_gb", CommonUtil.isNull(paramMap.get("s_user_gb")));
                    ArrMap.put("s_user_ip", CommonUtil.isNull(paramMap.get("s_user_ip")));
                    ArrMap.put("flag", strFlag);
                    ArrMap.put("title", strTitle);
                    ArrMap.put("post_approval_yn", strPostApprovalYn);
                    ArrMap.put("grp_approval_userList", CommonUtil.isNull(paramMap.get("grp_approval_userList")));
                    ArrMap.put("grp_alarm_userList", CommonUtil.isNull(paramMap.get("grp_alarm_userList")));

                    // 일괄 요청서 신규로 껍데기 생성 후 그룹 내 문서 결재 처리
                    if (z == 0 && group_yn.equals("Y")) {

                        //GrpMap : 일괄요청서 생성위한 파라미터
                        GrpMap.put("flag", strFlag);
                        GrpMap.put("title", strTitle);
                        GrpMap.put("job_name", job_name[z] + "외 " + (job_name.length - 1) + "건");
                        GrpMap.put("ori_doc_gb", "09");
                        GrpMap.put("doc_gb", doc_gb);
                        GrpMap.put("group_main", "Y");

                        GrpMap.put("post_approval_yn", strPostApprovalYn);
                        GrpMap.put("grp_approval_userList", CommonUtil.isNull(paramMap.get("grp_approval_userList")));
                        GrpMap.put("grp_alarm_userList", CommonUtil.isNull(paramMap.get("grp_alarm_userList")));

                        GrpMap.put("SCHEMA", CommonUtil.isNull(paramMap.get("SCHEMA")));
                        GrpMap.put("data_center", data_center[z]);
                        GrpMap.put("s_user_cd", CommonUtil.isNull(paramMap.get("s_user_cd")));
                        GrpMap.put("s_user_gb", CommonUtil.isNull(paramMap.get("s_user_gb")));
                        GrpMap.put("s_user_ip", CommonUtil.isNull(paramMap.get("s_user_ip")));

                        rMap = worksApprovalDocService.dPrcDoc(GrpMap);

                        if (!"1".equals(CommonUtil.isNull(rMap.get("r_code")))) throw new DefaultServiceException(rMap);
                        //생성 된 껍데기문서의 doc_cd 가져와서 넣어줌
                        strMainDocCd = CommonUtil.isNull(rMap.get("r_doc_cd"));
                        ArrMap.put("main_doc_cd", strMainDocCd);
                        logger.info("groupApproval || main_doc_cd ::::::: " + strMainDocCd);
                    }

                    ArrMap.put("flag", strFlag);
                    ArrMap.put("post_approval_yn", strPostApprovalYn);
                    ArrMap.put("job_name", job_name[z]);
                    ArrMap.put("doc_gb", doc_gb);
                    ArrMap.put("group_main", "N");

                    ArrMap.put("data_center_code", CommonUtil.isNull(paramMap.get("data_center_code")));

                    ArrMap.put("error_description", CommonUtil.isNull(paramMap.get("title")));
                    ArrMap.put("doc_cnt", CommonUtil.isNull(paramMap.get("doc_cnt")));
                    ArrMap.put("alarm_cd", alarm_cd[z]);

                    //요청서 생성 및 API 진행
                    //if ("draft_admin".equals(strFlag) || "draft_admin".equals(strFlag)) {
                    //rMap = worksApprovalDocService.dPrcDocAdmin(ArrMap);
                    //} else {
                    //rMap = worksApprovalDocService.dPrcDoc(ArrMap);
                    //}

                    rMap = worksApprovalDocService.dPrcDoc(ArrMap);


                    if ("1".equals(CommonUtil.isNull(rMap.get("r_code")))) {
                        successCnt++;
                        main_job = job_name[z];
                    }

                } catch (DefaultServiceException e) {
                    rMap = e.getResultMap();

                    if ("-2".equals(CommonUtil.isNull(rMap.get("r_code")))) {
                        logger.error(CommonUtil.isNull(rMap.get("r_msg")));
                        r_msg = CommonUtil.isNull(rMap.get("r_msg"));
                    } else {
                        logger.error(e.getMessage());
                        r_msg = CommonUtil.isNull(e.getMessage());
                    }

                    //오류메세지 처리
                    r_msg = CommonUtil.getMessage(CommonUtil.isNull(rMap.get("r_msg")));
                    if (r_msg.equals("")) {
                        r_msg = CommonUtil.isNull(rMap.get("r_msg"));
                    }

                    result_sb.append((z + 1) + "번째 [" + job_name[z] + "] : " + r_msg + "\\n");
                    logger.info("groupApproval || DefaultServiceException: " + rMap);
                } catch (Exception e) {
                    if ("".equals(CommonUtil.isNull(rMap.get("r_code"))))
                        rMap.put("r_code", "-1");
                    if ("".equals(CommonUtil.isNull(rMap.get("r_msg"))))
                        rMap.put("r_msg", "ERROR.01");

                    //오류메세지 처리
                    r_msg = CommonUtil.getMessage(CommonUtil.isNull(rMap.get("r_msg")));
                    if (r_msg.equals("")) {
                        r_msg = CommonUtil.isNull(rMap.get("r_msg"));
                    }

                    result_sb.append((z + 1) + "번째 [" + job_name[z] + "] : " + r_msg + "\\n");
                    logger.info("groupApproval || Exception: " + rMap);
                }
            }

            String group_main = "";

            //관리자즉시결재 반영하는 구간
            if ("draft_admin".equals(strFlag) || "draft_admin".equals(strFlag)) {

                if (strMainDocCd.equals("")) {
                    group_main = "N";
                    doc_cnt = "0";
                } else {
                    group_main = "Y";
                    doc_cnt = "1";
                }
                ArrMap.put("doc_cd", CommonUtil.isNull(strMainDocCd, CommonUtil.isNull(rMap.get("r_doc_cd"))));
                ArrMap.put("approval_cd", "02");
                ArrMap.put("approval_seq", "1");
                ArrMap.put("group_main", group_main);
                ArrMap.put("doc_cnt", doc_cnt);
                ArrMap.put("flag", "approval");
                rMap = worksApprovalDocService.dPrcDocApproval(ArrMap);
                r_code = CommonUtil.isNull(rMap.get("r_code"));
            }

            if (successCnt > 0) result_sb.append(job_name.length + "건의 작업 중 " + successCnt + "건 처리 완료");

            //후결 : 반영실패 시 일괄요청서 작업명 UDT
            if (job_name.length != successCnt && group_yn.equals("Y")) {
                String succCnt = "";
                if (successCnt > 1) {
                    succCnt = "외 " + (successCnt - 1) + "건";
                }

                GrpMap.put("job_name", main_job + succCnt);
                GrpMap.put("flag", "udt");
                GrpMap.put("doc_cd", strMainDocCd);

                rMap = worksApprovalDocService.dPrcDoc(GrpMap);
                if (!"1".equals(CommonUtil.isNull(rMap.get("r_code")))) throw new DefaultServiceException(rMap);

            }

        } catch (Exception e) {

            if ("".equals(CommonUtil.isNull(rMap.get("r_code"))))
                rMap.put("r_code", "-1");
            if ("".equals(CommonUtil.isNull(rMap.get("r_msg"))))
                rMap.put("r_msg", "ERROR.01");

            logger.error(e.getMessage());

        } finally {
            // 승인 요청은 그룹의 메인으로 결재자 알림 발송
            String sendApprovalNoti = CommonUtil.isNull(rMap.get("sendApprovalNoti"));
            String jobApplyChk = CommonUtil.isNull(rMap.get("jobApplyChk"));
            if (sendApprovalNoti.equals("Y")) {
                int iSendResult = CommonUtil.sendApprovalNoti(CommonUtil.isNull(strMainDocCd, rMap.get("doc_cd")));
                logger.info("sendApprovalNoti Result : " + iSendResult);
            }

            // 후결-후결일 경우 반영하기 위해 한번 더 태운다.
            if (jobApplyChk.equals("Y") && (strFlag.equals("post_draft"))) {

                paramMap.put("flag", "post_draft");
                paramMap.put("approval_comment", "");
                paramMap.put("doc_cd", strMainDocCd);
                paramMap.put("doc_cnt", successCnt);
                paramMap.put("group_main", "Y");
                rMap = worksApprovalDocService.dPrcDocApproval(paramMap);

            }

            logger.error(CommonUtil.isNull(rMap.get("r_state_cd")));

            String sendInsUserNoti = CommonUtil.isNull(rMap.get("sendInsUserNoti"));
            if (sendInsUserNoti.equals("Y")) {
                int iSendResult = CommonUtil.sendInsUserNoti(CommonUtil.isNull(strMainDocCd, rMap.get("doc_cd")));
                logger.info("sendInsUserNoti Result : " + iSendResult);
            }
        }

        rMap.put("r_code", "1");
        rMap.put("r_msg", result_sb.toString());

        ModelAndView output = null;
        //output = new ModelAndView("ezjobs/t/result");
        output = new ModelAndView("result/t_result");
        output.addObject("rMap", rMap);

        return output;
    }

    public ModelAndView ez037(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);

        ModelAndView output = new ModelAndView("ezjobs/t/works/approvalLineInfoList");

        List approvalLineInfoList = worksApprovalDocService.dGetApprovalLineInfoList(paramMap);

        output.addObject("approvalLineInfoList", approvalLineInfoList);

        return output;
    }

    public ModelAndView ez038(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);

        paramMap.put("searchType", "dataCenterList");
        List dataCenterList = commonService.dGetSearchItemList(paramMap);

        ModelAndView output = null;
        output = new ModelAndView("ezjobs/t/works/schedTableList");
        output.addObject("dataCenterList", dataCenterList);

        return output;
    }

    public ModelAndView ez038_p(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);

        //CommonUtil.emLogin(req);

        //paramMap.put("userToken", CommonUtil.isNull(req.getSession().getAttribute("USER_TOKEN")));

        Map<String, Object> rMap = new HashMap<String, Object>();

        try {

            // 신규 테이블용 작업.
            rMap = worksApprovalDocService.dSchedTableJob(paramMap);

        } catch (DefaultServiceException e) {
            rMap = e.getResultMap();

            rMap.put("r_msg", CommonUtil.getMessage(CommonUtil.isNull(rMap.get("r_msg"))));

        } catch (Exception e) {
            if ("".equals(CommonUtil.isNull(rMap.get("r_code")))) rMap.put("r_code", "-1");
            if ("".equals(CommonUtil.isNull(rMap.get("r_msg")))) rMap.put("r_msg", "ERROR.01");

            logger.error(e.getMessage());
        }

        ModelAndView output = null;
        output = new ModelAndView("ezjobs/t/result");
        output.addObject("rMap", rMap);

        return output;
    }

    public ModelAndView ez039(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);

        paramMap.put("searchType", "dataCenterList");
        List dataCenterList = commonService.dGetSearchItemList(paramMap);

        List qrList = worksApprovalDocService.dGetQrList(paramMap);

        ModelAndView output = null;
        output = new ModelAndView("ezjobs/t/works/qrList");

        output.addObject("dataCenterList", dataCenterList);
        output.addObject("qrList", qrList);

        return output;
    }

    public ModelAndView ez039_p(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);

        //CommonUtil.emLogin(req);

        //paramMap.put("userToken", CommonUtil.isNull(req.getSession().getAttribute("USER_TOKEN")));

        Map<String, Object> rMap = new HashMap<String, Object>();

        try {

            // 리소스 UTIL.
            rMap = worksApprovalDocService.dQrResource(paramMap);

        } catch (DefaultServiceException e) {
            rMap = e.getResultMap();

            rMap.put("r_msg", CommonUtil.getMessage(CommonUtil.isNull(rMap.get("r_msg"))));

        } catch (Exception e) {
            if ("".equals(CommonUtil.isNull(rMap.get("r_code")))) rMap.put("r_code", "-1");
            if ("".equals(CommonUtil.isNull(rMap.get("r_msg")))) rMap.put("r_msg", "ERROR.01");

            logger.error(e.getMessage());
        }

        ModelAndView output = null;
        output = new ModelAndView("ezjobs/t/result");
        output.addObject("rMap", rMap);

        return output;
    }

    public ModelAndView ez010_1_excel(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);

        paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
        paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));

        String startRowNum = CommonUtil.isNull(paramMap.get("startRowNum"));
        String pagingNum = CommonUtil.isNull(paramMap.get("pagingNum"));

        paramMap.put("startRowNum", "0");
        paramMap.put("pagingNum", Integer.parseInt(startRowNum) + Integer.parseInt(pagingNum));

        List defJobList = worksApprovalDocService.dGetDefJobList(paramMap);

        logger.info("defJobList size:::" + defJobList.size());
        
        ModelAndView output = null;
        output = new ModelAndView("contents/defJobListExcel");
        output.addObject("defJobList", defJobList);

        return output;

    }

    public ModelAndView ez010_2_excel(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);

        paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
        paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
        paramMap.put("searchType", "ctmOdateList");
        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));

        List ctmOdateList = commonService.dGetSearchItemList(paramMap);
        List jobGroupList = worksApprovalDocService.dGetJobGroupList(paramMap);
        
        ModelAndView output = null;
        output = new ModelAndView("contents/groupDefJobListExcel");
        output.addObject("ctmOdateList", ctmOdateList);
        output.addObject("jobGroupList", jobGroupList);

        return output;

    }

    public ModelAndView ez004_excel(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);

        paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
        paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
        paramMap.put("s_dept_cd", CommonUtil.isNull(req.getSession().getAttribute("DEPT_CD")));
        paramMap.put("s_user_gb", CommonUtil.isNull(req.getSession().getAttribute("USER_GB")));
        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));
        paramMap.put("pagingNum", "");

        List myDocInfoList = worksApprovalDocService.dGetMyDocInfoList(paramMap);

        ModelAndView output = null;
        output = new ModelAndView("contents/myDocInfoListExcel");
        output.addObject("myDocInfoList", myDocInfoList);
        return output;

    }

    public ModelAndView ez041(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);

        ModelAndView output = new ModelAndView("contents/deptAppLineList");

        List deptList = worksCompanyService.dGetDeptList(paramMap);
        List deptAppList = worksApprovalLineService.dGetDeptAppList(paramMap);

        output.addObject("deptList", deptList);
        output.addObject("deptAppList", deptAppList);

        return output;
    }

    public ModelAndView ez041_p(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);
        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));

        Map<String, Object> rMap = new HashMap<String, Object>();

        ModelAndView output = new ModelAndView("result/t_result");

        try {

            rMap = worksApprovalLineService.dPrcFinalApp(paramMap);

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

    //메인화면 오류건수
    public ModelAndView ez044_op_pop(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);

        paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
        paramMap.put("s_user_gb", CommonUtil.isNull(req.getSession().getAttribute("USER_GB")));
        paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));

        List<CommonBean> dataCenterList = CommonUtil.getDataCenterList();
        ArrayList<Map<String, Object>> data_center_items = new ArrayList();

        for (int i = 0; i < dataCenterList.size(); i++) {
            CommonBean bean = dataCenterList.get(i);

            Map<String, Object> hm = new HashMap();
            hm.put("data_center_code", bean.getData_center_code());
            hm.put("data_center", bean.getData_center());
            hm.put("active_net_name", bean.getActive_net_name());
            data_center_items.add(hm);

            if (1 == dataCenterList.size()) {
                paramMap.put("data_center", bean.getData_center());
                paramMap.put("data_center_code", bean.getData_center_code());
                paramMap.put("active_net_name", bean.getActive_net_name());
            }
        }

        paramMap.put("data_center_items", data_center_items);

        CommonBean errorLineBean = null;

        if (!CommonUtil.isNull(req.getSession().getAttribute("USER_CD")).equals("")) {
            paramMap.put("p_search_gubun", "user_nm");
            paramMap.put("S_USER_NM", CommonUtil.isNull(req.getSession().getAttribute("USER_NM")));
            paramMap.put("S_USER_CD", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
            paramMap.put("p_search_action_yn", "N");
            paramMap.put("op_gubun", "op");
            paramMap.put("odate_yn", "Y");
            paramMap.put("p_message", "Ended not OK");
            paramMap.put("top_menu", "Y");
            errorLineBean = emAlertService.dGetAlertErrorListCnt(paramMap);
        }

        ModelAndView output = null;
        output = new ModelAndView("common/inc/ajaxReturn3");

        output.addObject("commonbean", errorLineBean);

        return output;
    }
    
    public ModelAndView ez045(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);
        paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
        paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));
        
        paramMap.put("appltype", "DATABASE");
        List<DefJobBean> hostList = popupDefJobService.dGetHostList(paramMap);
        
        ModelAndView output = null;
        output = new ModelAndView("works/C06/main_contents/databaseList");
        output.addObject("paramMap", paramMap);
        output.addObject("cm", CommonUtil.getComScodeList(paramMap));
        output.addObject("SERVER_MCODE_CD", CommonUtil.getMessage("COMCODE.SERVER.CODE"));
        output.addObject("db_host", hostList);

        return output;
    }
    
    public ModelAndView ez045_p(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);
        paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
        paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));
        
        Map<String, Object> rMap = new HashMap<String, Object>();
        
        String flag = CommonUtil.isNull(paramMap.get("flag"));
        String v_database_pw = CommonUtil.isNull(paramMap.get("v_database_pw"));
        String strDatabasePw = CommonUtil.isNull(paramMap.get("database_pw"));
        
		 // 암호화
        if (!v_database_pw.equals("")) {
        	paramMap.put("password", SeedUtil.encodeStr(v_database_pw));
        }else {
        	paramMap.put("password", strDatabasePw);
        }
        		
        try {
            rMap = commonService.dPrcDatabase(paramMap);
        } catch (DefaultServiceException e) {
            rMap = e.getResultMap();

            if ("-2".equals(CommonUtil.isNull(rMap.get("r_code")))) {
                logger.error(CommonUtil.isNull(rMap.get("r_msg")));
            } else {
                logger.error(e.getMessage());
            }

        } catch (Exception e) {
            if ("".equals(CommonUtil.isNull(rMap.get("r_code")))) rMap.put("r_code", "-1");
            if ("".equals(CommonUtil.isNull(rMap.get("r_msg")))) rMap.put("r_msg", "ERROR.01");

            logger.error(e.getMessage());
        }
        
        ModelAndView output = null;
        output = new ModelAndView("result/t_result");
        output.addObject("rMap", rMap);
        return output;
    }
    
    
    public ModelAndView ez045_access(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {
        Map<String, Object> paramMap = CommonUtil.collectParameters(req);

        String strUserNm 	   = CommonUtil.isNull(paramMap.get("user_nm"));
        String strDatabaseType = CommonUtil.isNull(paramMap.get("database_type"));
        String strDatabasePw   = SeedUtil.decodeStr(CommonUtil.isNull(paramMap.get("database_pw")));
        String strDatabaseNm   = CommonUtil.isNull(paramMap.get("database_name"));
        String strAccessSid    = CommonUtil.isNull(paramMap.get("access_sid"));
        String strAccessServiceName    = CommonUtil.isNull(paramMap.get("access_service_name"));
        String strAccessPort   = CommonUtil.isNull(paramMap.get("access_port"));
        String strHostNm   	   = CommonUtil.isNull(paramMap.get("host_nm"));
        
        String strDriver = "";
        String strDbUrl  = "";
        
        if(strDatabaseType.equals("PostgreSQL")) {
        	strDriver = "org.postgresql.Driver";
        	strDbUrl = "jdbc:postgresql://" + strHostNm + ":" + strAccessPort + "/" + strDatabaseNm;
        }else {
        	strDriver=  "oracle.jdbc.driver.OracleDriver";
        	if(!strAccessSid.equals("")) {
        		strDbUrl = "jdbc:oracle:thin:@" + strHostNm + ":" + strAccessPort +":" + strAccessSid;
        	}else {
        		strDbUrl = "jdbc:oracle:thin:@" + strHostNm + ":" + strAccessPort +"/" + strAccessServiceName;
        	}
        }
        
        Map<String, Object> rMap = new HashMap<String, Object>();
        
        Connection con 		= null;
        try {
			Class.forName(strDriver);
					
			con = DriverManager.getConnection(strDbUrl, strUserNm, strDatabasePw);
			if ("".equals(CommonUtil.isNull(rMap.get("r_code")))) rMap.put("r_code", "1");
            if ("".equals(CommonUtil.isNull(rMap.get("r_msg")))) rMap.put("r_msg", "접속확인 : 정상");
			
		}catch (Exception e) {				
			e.printStackTrace();
			if ("".equals(CommonUtil.isNull(rMap.get("r_code")))) rMap.put("r_code", "-1");
            if ("".equals(CommonUtil.isNull(rMap.get("r_msg")))) rMap.put("r_msg", e.getMessage());
		}finally {
			if (con != null) try { con.close(); } catch (Exception e) { e.printStackTrace(); }
		}
        
        
        ModelAndView output = null;
        output = new ModelAndView("result/t_result");
        output.addObject("rMap", rMap);

        return output;
    }

    public ModelAndView apiTest(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

        //CommonUtil.emLogin(req);

        ModelAndView output = new ModelAndView("result/t_result");
        return output;
    }

    public ModelAndView ez066(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);

        paramMap.put("searchType", "dataCenterList");
        List dataCenterList = commonService.dGetSearchItemList(paramMap);

        ModelAndView output = null;
        //output = new ModelAndView("ezjobs/t/works/appAndGrpList");
        output = new ModelAndView("contents/appAndGrpList");
        output.addObject("dataCenterList", dataCenterList);

        return output;
    }

    public ModelAndView ez036_p(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);

        //CommonUtil.emLogin(req);

        //paramMap.put("userToken", CommonUtil.isNull(req.getSession().getAttribute("USER_TOKEN")));

        Map<String, Object> rMap = new HashMap<String, Object>();

        try {

            // 신규 테이블용 작업.
            rMap = worksApprovalDocService.dSchedTableJob(paramMap);

        } catch (DefaultServiceException e) {
            rMap = e.getResultMap();

            rMap.put("r_msg", CommonUtil.getMessage(CommonUtil.isNull(rMap.get("r_msg"))));

        } catch (Exception e) {
            if ("".equals(CommonUtil.isNull(rMap.get("r_code")))) rMap.put("r_code", "-1");
            if ("".equals(CommonUtil.isNull(rMap.get("r_msg")))) rMap.put("r_msg", "ERROR.01");

            logger.error(e.getMessage());
        }

        ModelAndView output = null;
        output = new ModelAndView("ezjobs/t/result");
        output.addObject("rMap", rMap);

        return output;
    }

    //정기작업삭제 폼
    public ModelAndView ez0203(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);

        String doc_gb = "03";
        paramMap.put(doc_gb, doc_gb);

        ModelAndView output = null;
        output = new ModelAndView("works/C02/main_contents/defJobsList");
        output.addObject("cm", CommonUtil.getComScodeList(paramMap));

        // 대분류 검색 화면
        paramMap.put("mcode_search", "Y");
        output.addObject("mcodeList", CommonUtil.getMcodeList(paramMap));
        output.addObject("paramMap", paramMap);
        return output;
    }

    //정기작업수정 폼
    public ModelAndView ez0204(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);
        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));

        String doc_gb = "04";
        paramMap.put(doc_gb, doc_gb);

        ModelAndView output = null;
        output = new ModelAndView("works/C02/main_contents/defJobsList");
        output.addObject("cm", CommonUtil.getComScodeList(paramMap));

        // 대분류 검색 화면
        paramMap.put("mcode_search", "Y");
        output.addObject("mcodeList", CommonUtil.getMcodeList(paramMap));
        output.addObject("paramMap", paramMap);
        return output;
    }


    public ModelAndView test(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);
        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));
        String cm = CommonUtil.getMessage("DATA.CENTER.CODE");

        ExcelUtil excel = new ExcelUtil();
        String file_path = req.getRealPath(CommonUtil.getMessage("MENUAL_FILE.PATH")) + "/doc_files/sample";
        ArrayList<String[]> list = excel.getExcelRead(file_path, "EzJOBs_DefJOB_Sample.xls");

        ModelAndView output = null;
        output = new ModelAndView("main_contents/LeftMenu");
        output.addObject("cm", CommonUtil.getComScodeList(paramMap));
        output.addObject("SERVER_MCODE_CD", CommonUtil.getMessage("COMCODE.SERVER.CODE"));
        output.addObject("IN_COND_DT", CommonUtil.getMessage("JOB.IN_CONDITION_DATE"));
        output.addObject("IN_COND_AND_OR", CommonUtil.getMessage("JOB.IN_CONDITION_AND_OR2"));
        output.addObject("OUT_COND_DT", CommonUtil.getMessage("JOB.OUT_CONDITION_DATE"));
        output.addObject("OUT_COND_EFFECT", CommonUtil.getMessage("JOB.OUT_CONDITION_EFFECT2"));
        output.addObject("excelList", list);

        return output;
    }

    public void test_p(HttpServletRequest req, HttpServletResponse res, BoardBean bean) throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);

        //아래의 내용은 ServiceImpl에 넣어야 하는 내용임
        String sp_file_nm = "";
        String file_path = req.getRealPath(CommonUtil.getMessage("MENUAL_FILE.PATH") + "attach_file");
        //String file_path = CommonUtil.getMessage("COMMON.FILE.PATH")+"attach_file";
        logger.info("=================>file_path:" + file_path);

        Date dt = new Date();
        SimpleDateFormat sf = new SimpleDateFormat("yyyyMMddHHmm");
        String ymdh = sf.format(dt);

        File f = new File(file_path);
        if (!f.exists()) {
            f.mkdir();
        }

        List<MultipartFile> attach = bean.getFiles();

        if (attach != null) {
            for (MultipartFile multifile : attach) {
                if (multifile.isEmpty() == false) {
                    String ori_file_nm = multifile.getOriginalFilename();

                    //파일명 변경
                    if (ori_file_nm.lastIndexOf(".") > -1) {
                        sp_file_nm = ori_file_nm.substring(0, ori_file_nm.lastIndexOf(".")) + "_" + ymdh + ori_file_nm.substring(ori_file_nm.lastIndexOf("."), ori_file_nm.length());
                    } else {
                        sp_file_nm = ori_file_nm + "_" + ymdh;
                    }

                    logger.info("#===================>file_name :" + sp_file_nm);

                    multifile.transferTo(new File(file_path, sp_file_nm));

                }
            }
        }


        //그리드 데이터 처리
        // 기존 EzJobs 엑셀등록 로직 변경을 하지 않기 위해 기존 방식 그대로 데이터 셋하게 구성 ㅠ.ㅠ
        // 기존 EzJobs 로직이 엑셀을 읽어 컬럼별로 배열에 넣고~
        // 이 배열을 다시 ArrayList에 넣어서 작업등록 처리를 하므로 똑같은 형태로 값을 셋하게 많듬 ㅠ.ㅠ


        String excel_data = CommonUtil.isNull(paramMap.get("excel_data"));
        ArrayList<String[]> list_data = new ArrayList<>();                    //이 데이터를 가지고 엑셀일괄등록처럼 로직 처리하면 됨
        String[] split_excel_data = excel_data.split("[:]");
        String[] arr_excel_data = null;            //방개수가 몇개인지 몰라 ㅠ.ㅠ

        int row_cnt = 0;
        int col_cnt = 0;

        //총 컬럼 갯수를 구한다.
        for (int i = 0; i < split_excel_data.length; i++) {
            String data = CommonUtil.isNull(split_excel_data[i]);

            if (!data.equals("END")) {
                ++col_cnt;
            } else {
                break;
            }
        }

        logger.info("전체방수는:::" + col_cnt);

        int col = 0;
        arr_excel_data = new String[col_cnt];                //여기에서 방개수 지정 ㅎㅎ
        for (int j = 0; j < split_excel_data.length; j++) {

            String data = CommonUtil.isNull(split_excel_data[j]);

            if (!data.equals("END")) {
                arr_excel_data[col] = data;
                ++col;
            } else {
                list_data.add(arr_excel_data);                //배열에 있는 데이터를 ArrayList에 담는다

                arr_excel_data = new String[col_cnt];        //여기에서 방개수 지정 ㅎㅎ
                col = 0;
            }

        }


        // 여기는 데이터 확인용이라 안해도 됨
        //자 그럼 데이터가 정상적으로 들어갔나 보자구 ㅎㅎ
        StringBuilder sb = new StringBuilder();
        for (int k = 0; k < list_data.size(); k++) {

            String[] arr_data = list_data.get(k);
            for (int l = 0; l < col_cnt; l++) {
                if (l > 0) sb.append("---");
                sb.append(arr_data[l]);
            }
            sb.append("\n");  //하나의 row가 끝나면 다음라인부터 다시 시작 ㅎㅎ
        }

        logger.info("결과는:::" + sb.toString());
    }

    public ModelAndView test2(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);
        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));
        String cm = CommonUtil.getMessage("DATA.CENTER.CODE");

        ModelAndView output = null;
        output = new ModelAndView("main_contents/sample2");
        output.addObject("cm", CommonUtil.getComScodeList(paramMap));
        output.addObject("SERVER_MCODE_CD", CommonUtil.getMessage("COMCODE.SERVER.CODE"));
        output.addObject("IN_COND_DT", CommonUtil.getMessage("JOB.IN_CONDITION_DATE"));
        output.addObject("IN_COND_AND_OR", CommonUtil.getMessage("JOB.IN_CONDITION_AND_OR2"));
        output.addObject("OUT_COND_DT", CommonUtil.getMessage("JOB.OUT_CONDITION_DATE"));
        output.addObject("OUT_COND_EFFECT", CommonUtil.getMessage("JOB.OUT_CONDITION_EFFECT2"));

        return output;
    }

    public void test2_p(HttpServletRequest req, HttpServletResponse res, BoardBean bean) throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);
        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));

        String data_center = CommonUtil.isNull(paramMap.get("data_center"));
        String application = CommonUtil.isNull(paramMap.get("application_of_def"));

        //아래의 내용은 ServiceImpl에 넣어야 하는 내용임
        String sp_file_nm = "";
        String file_path = req.getRealPath(CommonUtil.getMessage("MENUAL_FILE.PATH") + "/excel_tmp");
        //String file_path = CommonUtil.getMessage("COMMON.FILE.PATH")+"attach_file";
        logger.info("=================>file_path:" + file_path);

        Date dt = new Date();
        SimpleDateFormat sf = new SimpleDateFormat("yyyyMMddHHmm");
        String ymdh = sf.format(dt);

        File f = new File(file_path);
        if (!f.exists()) {
            f.mkdir();
        }

        List<MultipartFile> attach = bean.getFiles();

        if (attach != null) {
            for (MultipartFile multifile : attach) {
                if (multifile.isEmpty() == false) {
                    String ori_file_nm = multifile.getOriginalFilename();

                    //파일명 변경
                    if (ori_file_nm.lastIndexOf(".") > -1) {
                        sp_file_nm = ori_file_nm.substring(0, ori_file_nm.lastIndexOf(".")) + "_" + ymdh + ori_file_nm.substring(ori_file_nm.lastIndexOf("."), ori_file_nm.length());
                    } else {
                        sp_file_nm = ori_file_nm + "_" + ymdh;
                    }

                    logger.info("#===================>file_name :" + sp_file_nm);

                    multifile.transferTo(new File(file_path, sp_file_nm));

                }
            }
        }

        JsUtil.getJsonString(sp_file_nm, res);

    }

    public void test2_data(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);
        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));

        String grid_data = CommonUtil.isNull(paramMap.get("grid_data"));

        ArrayList<String[]> list_data = new ArrayList<>();
        String[] split_grid_data = grid_data.split("[:]");
        String[] arr_grid_data = null;            //방개수가 몇개인지 몰라 ㅠ.ㅠ

        int row_cnt = 0;
        int col_cnt = 0;

        //총 컬럼 갯수를 구한다.
        for (int i = 0; i < split_grid_data.length; i++) {
            String data = CommonUtil.isNull(split_grid_data[i]);

            if (!data.equals("END")) {
                ++col_cnt;
            } else {
                break;
            }
        }

        logger.info("전체방수는:::" + col_cnt);

        int col = 0;
        arr_grid_data = new String[col_cnt];                //여기에서 방개수 지정 ㅎㅎ
        for (int j = 0; j < split_grid_data.length; j++) {

            String data = CommonUtil.isNull(split_grid_data[j]);

            if (!data.equals("END")) {
                arr_grid_data[col] = data;
                ++col;
            } else {
                list_data.add(arr_grid_data);                //배열에 있는 데이터를 ArrayList에 담는다

                arr_grid_data = new String[col_cnt];        //여기에서 방개수 지정 ㅎㅎ
                col = 0;
            }

        }

        // 여기는 데이터 확인용이라 안해도 됨
        //자 그럼 데이터가 정상적으로 들어갔나 보자구 ㅎㅎ
        StringBuilder sb = new StringBuilder();
        for (int k = 0; k < list_data.size(); k++) {

            String[] arr_data = list_data.get(k);
            for (int l = 0; l < col_cnt; l++) {
                if (l > 0) sb.append("---");
                sb.append(arr_data[l]);
            }
            sb.append("\n");  //하나의 row가 끝나면 다음라인부터 다시 시작 ㅎㅎ
        }

        logger.info("결과는:::" + sb.toString());

    }

    public ModelAndView test3(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);
        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));
        String cm = CommonUtil.getMessage("DATA.CENTER.CODE");

        ModelAndView output = null;
        output = new ModelAndView("main_contents/sample3");

        return output;
    }

    public ModelAndView test4(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);
        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));

        ModelAndView output = null;
        output = new ModelAndView("main_contents/sample5");

        return output;
    }

    public ModelAndView doc02_pastLoad(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);
        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));

        String cm = CommonUtil.getMessage("DATA.CENTER.CODE");
        String application = CommonUtil.isNull(paramMap.get("application"));
        String group_name = CommonUtil.isNull(paramMap.get("group_name"));

        logger.debug("cm :::" + cm);
        logger.debug("#T WorksController | doc02_pastLoad | application :::" + application);
        logger.debug("#T WorksController | doc02_pastLoad | group_name :::" + group_name);

        ModelAndView output = null;
        output = new ModelAndView("main_contents/doc02_pastLoad");
        output.addObject("paramMap", paramMap);
        output.addObject("cm", cm);

        return output;
    }

    public ModelAndView doc02_periodLoad(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);
        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));

        String cm = CommonUtil.getMessage("DATA.CENTER.CODE");
        String application = CommonUtil.isNull(paramMap.get("application"));
        String group_name = CommonUtil.isNull(paramMap.get("group_name"));

        logger.debug("cm :::" + cm);
        logger.debug("#T WorksController | doc02_periodLoad | application :::" + application);
        logger.debug("#T WorksController | doc02_periodLoad | group_name :::" + group_name);

        ModelAndView output = null;
        output = new ModelAndView("main_contents/doc02_periodLoad");
        output.addObject("paramMap", paramMap);
        output.addObject("cm", cm);

        return output;
    }

    public void doc02_excelLoad(HttpServletRequest req, HttpServletResponse res, BoardBean bean) throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);
        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));

        String data_center = CommonUtil.isNull(paramMap.get("data_center"));
        String application = CommonUtil.isNull(paramMap.get("application_of_def"));

        //아래의 내용은 ServiceImpl에 넣어야 하는 내용임
        String sp_file_nm = "";
        String file_path = req.getRealPath(CommonUtil.getMessage("MENUAL_FILE.PATH") + "/excel_tmp");
        //String file_path = CommonUtil.getMessage("COMMON.FILE.PATH")+"attach_file";
        logger.info(" #tWorksController | doc02_excelLoad=================>file_path:" + file_path);

        Date dt = new Date();
        SimpleDateFormat sf = new SimpleDateFormat("yyyyMMddHHmm");
        String ymdh = sf.format(dt);

        File f = new File(file_path);
        if (!f.exists()) {
            f.mkdir();
        }

        List<MultipartFile> attach = bean.getFiles();

        if (attach != null) {
            for (MultipartFile multifile : attach) {
                if (multifile.isEmpty() == false) {
                    String ori_file_nm = multifile.getOriginalFilename();

                    //파일명 변경
                    if (ori_file_nm.lastIndexOf(".") > -1) {
                        sp_file_nm = ori_file_nm.substring(0, ori_file_nm.lastIndexOf(".")) + "_" + ymdh + ori_file_nm.substring(ori_file_nm.lastIndexOf("."), ori_file_nm.length());
                    } else {
                        sp_file_nm = ori_file_nm + "_" + ymdh;
                    }

                    logger.info("#===================>file_name :" + sp_file_nm);

                    multifile.transferTo(new File(file_path, sp_file_nm));

                }
            }
        }

        JsUtil.getJsonString(sp_file_nm, res);

    }

    public ModelAndView doc02_pop(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);
        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));
        String cm = CommonUtil.getMessage("DATA.CENTER.CODE");

        String table_name = CommonUtil.isNull(paramMap.get("table_name"));
        String application = CommonUtil.isNull(paramMap.get("application"));
        String data_center = CommonUtil.isNull(paramMap.get("data_center"));
        String systemGb = CommonUtil.isNull(paramMap.get("systemGb"));

        ModelAndView output = null;
        output = new ModelAndView("main_contents/doc02_pop");
        output.addObject("systemGb", systemGb);
        output.addObject("table_name", table_name);
        output.addObject("application", application);
        output.addObject("data_center", data_center);
        output.addObject("cm", CommonUtil.getComScodeList(paramMap));
        output.addObject("SERVER_MCODE_CD", CommonUtil.getMessage("COMCODE.SERVER.CODE"));
        output.addObject("IN_COND_DT", CommonUtil.getMessage("JOB.IN_CONDITION_DATE"));
        output.addObject("IN_COND_AND_OR", CommonUtil.getMessage("JOB.IN_CONDITION_AND_OR2"));
        output.addObject("OUT_COND_DT", CommonUtil.getMessage("JOB.OUT_CONDITION_DATE"));
        output.addObject("OUT_COND_EFFECT", CommonUtil.getMessage("JOB.OUT_CONDITION_EFFECT2"));
        output.addObject("paramMap", paramMap);

        return output;
    }

    public ModelAndView doc02_modify_pop(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);

        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));

        ModelAndView output = null;
        output = new ModelAndView("main_contents/doc02_modify_pop");
        return output;
    }

    public ModelAndView ez050(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);
        paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
        paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));

        String s_user_gb = CommonUtil.isNull(req.getSession().getAttribute("USER_GB"));

        List<CommonBean> odateList = CommonUtil.getOdateList();
        int odate_cnt = odateList.size();
        String odate = "";

        if (odate_cnt > 0) {
            for (int i = 0; i < odate_cnt; i++) {
                CommonBean bean = odateList.get(0);
                odate = bean.getView_odate();
            }
        }
        if (CommonUtil.isNull(paramMap.get("odate")).equals("")) {
            paramMap.put("odate", CommonUtil.getCurDateTo(CommonUtil.getCurDate(""), -1));
        }

        //List activeJobHistory = worksApprovalDocService.dGetActiveJobHistory(paramMap);
        List approvalLineList = worksApprovalLineService.dGetApprovalLineList(paramMap);

        ModelAndView output = null;
        output = new ModelAndView("works/C03/main_contents/activeJobHistory");
        output.addObject("paramMap", paramMap);
        //output.addObject("dataCenterList", CommonUtil.getDataCenterList());
        output.addObject("cm", CommonUtil.getComScodeList(paramMap));
        output.addObject("hostList", CommonUtil.getHostList());
        output.addObject("ODATE", CommonUtil.getCurDateTo(CommonUtil.getCurDate(""), -1));

        //output.addObject("activeJobHistory",		activeJobHistory);
        output.addObject("approvalLineList", approvalLineList);

        return output;

    }

    public ModelAndView ez051(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);
        paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
        paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));

        String s_user_gb = CommonUtil.isNull(req.getSession().getAttribute("USER_GB"));

        List<CommonBean> odateList = CommonUtil.getOdateList();
        int odate_cnt = odateList.size();
        String odate = "";

        if (odate_cnt > 0) {
            for (int i = 0; i < odate_cnt; i++) {
                CommonBean bean = odateList.get(0);
                odate = bean.getView_odate();
            }
        }
        if (CommonUtil.isNull(paramMap.get("odate")).equals("")) {
            paramMap.put("odate", CommonUtil.getCurDateTo(CommonUtil.getCurDate(""), -1));
        }

        //List activeJobHistory = worksApprovalDocService.dGetActiveJobHistory(paramMap);
        List approvalLineList = worksApprovalLineService.dGetApprovalLineList(paramMap);

        ModelAndView output = null;
        output = new ModelAndView("works/C02/main_contents/systemJobHistory");
        output.addObject("paramMap", paramMap);
        //output.addObject("dataCenterList", CommonUtil.getDataCenterList());
        output.addObject("cm", CommonUtil.getComScodeList(paramMap));
        output.addObject("hostList", CommonUtil.getHostList());
        output.addObject("ODATE", CommonUtil.getCurDate(""));
//		output.addObject("ODATE", CommonUtil.getCurDateTo(CommonUtil.getCurDate(""), -1));

        //output.addObject("activeJobHistory",		activeJobHistory);
        output.addObject("approvalLineList", approvalLineList);

        return output;

    }

    public ModelAndView ez052(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);
        paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
        paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));

        String s_user_gb = CommonUtil.isNull(req.getSession().getAttribute("USER_GB"));

        List<CommonBean> odateList = CommonUtil.getOdateList();
        int odate_cnt = odateList.size();
        String odate = "";

        if (odate_cnt > 0) {
            for (int i = 0; i < odate_cnt; i++) {
                CommonBean bean = odateList.get(0);
                odate = bean.getView_odate();
            }
        }
        if (CommonUtil.isNull(paramMap.get("odate")).equals("")) {
            paramMap.put("odate", CommonUtil.getCurDateTo(CommonUtil.getCurDate(""), -1));
        }

        //List activeJobHistory = worksApprovalDocService.dGetActiveJobHistory(paramMap);
        List approvalLineList = worksApprovalLineService.dGetApprovalLineList(paramMap);

        ModelAndView output = null;
        output = new ModelAndView("works/C02/main_contents/groupJobHistory");
        output.addObject("paramMap", paramMap);
        //output.addObject("dataCenterList", CommonUtil.getDataCenterList());
        output.addObject("cm", CommonUtil.getComScodeList(paramMap));
        output.addObject("hostList", CommonUtil.getHostList());
        output.addObject("ODATE", CommonUtil.getCurDateTo(CommonUtil.getCurDate(""), -1));

        //output.addObject("activeJobHistory",		activeJobHistory);
        output.addObject("approvalLineList", approvalLineList);

        return output;

    }

    @SuppressWarnings("unchecked")
    public ModelAndView ez054(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);

        paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
        paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));

        List susiTypeList = null;
        List jobGroupList = null;
        
        paramMap.put("mcode_cd", "M33");
        susiTypeList = commonService.dGetsCodeList(paramMap);
        
        ModelAndView output = null;
        output = new ModelAndView("works/C03/main_contents/jobGroupList");
        output.addObject("STRT_DT", CommonUtil.getCurDateTo(CommonUtil.getCurDate(""), -7));
        output.addObject("END_DT", CommonUtil.getCurDateTo(CommonUtil.getCurDate(""), 0));
        output.addObject("paramMap", paramMap);
        output.addObject("cm", CommonUtil.getComScodeList(paramMap));
        output.addObject("susiTypeList", susiTypeList);
        return output;
    }

    //보고_폴더별누적배치
    public ModelAndView batchTotal(HttpServletRequest req, HttpServletResponse res) throws Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);

        ModelAndView output = new ModelAndView("works/C05/main_contents/batchTotal");

        List<CommonBean> odateList = CommonUtil.getCtmOdateList();
        int odate_cnt = odateList.size();
        if (odate_cnt > 0) {
            for (int i = 0; i < odate_cnt; i++) {
                CommonBean bean = (CommonBean) odateList.get(0);
                output.addObject("ODATE", bean.getView_odate().replaceAll("/", ""));
            }
        } else {
            output.addObject("ODATE", "");
        }
        output.addObject("cm", CommonUtil.getComScodeList(paramMap));
        return output;
    }

    public ModelAndView batchTotalExcel(HttpServletRequest req, HttpServletResponse res) throws Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);
        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));
        paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
        paramMap.put("s_user_gb", CommonUtil.isNull(req.getSession().getAttribute("USER_GB")));

        // 폴더 다중 검색(부산은행 23.10.20)
        String p_sched_table = CommonUtil.isNull(paramMap.get("p_sched_table"));
        if (!"".equals(p_sched_table)) {

            String search_text = CommonUtil.isNull(paramMap.get("p_sched_table"));

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

        List batchTotalList = commonService.dGetBatchTotal(paramMap);
        ModelAndView output = new ModelAndView("contents/batchTotalExcel");
        output.addObject("batchTotalList", batchTotalList);
        return output;
    }

    //보고_기간별의뢰결재현황
    public ModelAndView docApprovalTotal(HttpServletRequest req, HttpServletResponse res) throws Exception {
        Map<String, Object> paramMap = CommonUtil.collectParameters(req);
        ModelAndView output = new ModelAndView("works/C05/main_contents/docApprovalTotal");

        List<CommonBean> odateList = CommonUtil.getCtmOdateList();
        int odate_cnt = odateList.size();
        if (odate_cnt > 0) {
            for (int i = 0; i < odate_cnt; i++) {
                CommonBean bean = (CommonBean) odateList.get(0);
                output.addObject("ODATE", bean.getView_odate().replaceAll("/", ""));
            }
        } else {
            output.addObject("ODATE", "");
        }
        output.addObject("cm", CommonUtil.getComScodeList(paramMap));
        return output;
    }

    public ModelAndView docApprovalTotalExcel(HttpServletRequest req, HttpServletResponse res) throws Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);

        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));
        paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
        paramMap.put("s_user_gb", CommonUtil.isNull(req.getSession().getAttribute("USER_GB")));

        String s_search_date = CommonUtil.isNull(paramMap.get("p_s_pdate"));
        String e_search_date = CommonUtil.isNull(paramMap.get("p_e_pdate"));
        String p_dept_nm = CommonUtil.isNull(paramMap.get("p_dept_nm"));

        // 폴더 다중 검색(부산은행 23.10.20)
        String p_sched_table = CommonUtil.isNull(paramMap.get("p_sched_table"));
        if (!"".equals(p_sched_table)) {

            String search_text = CommonUtil.isNull(paramMap.get("p_sched_table"));

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

        paramMap.put("p_s_search_date", s_search_date);
        paramMap.put("p_e_search_date", e_search_date);
        paramMap.put("p_date_gubun", "02");            //등록일자 기준
        paramMap.put("p_s_state_cd", "05");            //문서상태 조건
        paramMap.put("p_sched_table", p_sched_table);    //폴더(테이블) 조건

        String dept_nm = CommonUtil.isNull(paramMap.get("p_dept_nm"));
        if (!dept_nm.equals("")) {
            paramMap.put("p_s_gb", "07");                //부서검색
            paramMap.put("p_s_text", dept_nm);            //부서 조건
        }

        List<DocApprovalTotalBean> docApprovalTotalList = commonService.dGetDocApprovalTotal(paramMap);

        List<DocInfoBean> docList = worksApprovalDocService.dGetMyDocInfoList(paramMap);

        ModelAndView output = new ModelAndView("contents/docApprovalTotalExcel");
        output.addObject("docApprovalTotalList", docApprovalTotalList);
        output.addObject("docList", docList);

        return output;
    }

    //보고_상세수행현황
    public ModelAndView jobCondTotal(HttpServletRequest req, HttpServletResponse res) throws Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);

        ModelAndView output = new ModelAndView("works/C05/main_contents/jobCondTotal");

        List<CommonBean> odateList = CommonUtil.getCtmOdateList();

        int odate_cnt = odateList.size();
        if (odate_cnt > 0) {
            for (int i = 0; i < odate_cnt; i++) {
                CommonBean bean = (CommonBean) odateList.get(0);
                output.addObject("ODATE", bean.getView_odate().replaceAll("/", ""));
            }
        } else {
            output.addObject("ODATE", "");
        }
        output.addObject("cm", CommonUtil.getComScodeList(paramMap));
        return output;
    }

    public ModelAndView jobCondTotalExcel(HttpServletRequest req, HttpServletResponse res) throws Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);

        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));
        paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
        paramMap.put("s_user_gb", CommonUtil.isNull(req.getSession().getAttribute("USER_GB")));

        // 폴더 다중 검색(부산은행 23.10.20)
        String p_sched_table = CommonUtil.isNull(paramMap.get("p_sched_table"));
        if (!"".equals(p_sched_table)) {

            String search_text = CommonUtil.isNull(paramMap.get("p_sched_table"));

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

        CommonBean commonbean = CommonUtil.getDataCenterList().get(0);

        if (commonbean != null) {
            paramMap.put("data_center_code", CommonUtil.isNull(commonbean.getData_center_code()));
            paramMap.put("active_net_name", CommonUtil.isNull(commonbean.getActive_net_name()));
        }

        List jobCondTotalList = commonService.dGetJobCondTotal(paramMap);

        ModelAndView output = new ModelAndView("contents/jobCondTotalExcel");
        output.addObject("jobCondTotalList", jobCondTotalList);
        return output;
    }

    //보고_에러조치내역
    public ModelAndView errorLogTotal(HttpServletRequest req, HttpServletResponse res) throws Exception {
        Map<String, Object> paramMap = CommonUtil.collectParameters(req);
        ModelAndView output = new ModelAndView("works/C05/main_contents/errorLogTotal");

        List<CommonBean> odateList = CommonUtil.getCtmOdateList();
        int odate_cnt = odateList.size();
        if (odate_cnt > 0) {
            for (int i = 0; i < odate_cnt; i++) {
                CommonBean bean = (CommonBean) odateList.get(0);
                output.addObject("ODATE", bean.getView_odate().replaceAll("/", ""));
            }
        } else {
            output.addObject("ODATE", "");
        }
        output.addObject("cm", CommonUtil.getComScodeList(paramMap));
        return output;
    }

    public ModelAndView errorLogTotalExcel(HttpServletRequest req, HttpServletResponse res) throws Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);

        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));
        paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
        paramMap.put("s_user_gb", CommonUtil.isNull(req.getSession().getAttribute("USER_GB")));
        paramMap.put("pagingNum", "");

        List errorLogTotalList = commonService.dGetErrorLogTotal(paramMap);

        ModelAndView output = new ModelAndView("contents/errorLogTotalExcel");
        output.addObject("errorLogTotalList", errorLogTotalList);
        return output;
    }

    public ModelAndView ExcelLoad(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);

        String file_nm = CommonUtil.isNull(paramMap.get("file_nm"));
        String act_gb = CommonUtil.isNull(paramMap.get("act_gb"));
        String s_user_gb = CommonUtil.isNull(req.getSession().getAttribute("USER_GB"));
        String s_user_cd = CommonUtil.isNull(req.getSession().getAttribute("USER_CD"));

        logger.debug("#WorksController | ExcelLoad | act_gb :: " + act_gb);

        ExcelUtil excel = new ExcelUtil();
        String file_path = req.getRealPath(CommonUtil.getMessage("MENUAL_FILE.PATH")) + "/excel_tmp";

        Map<String, Object> rMap = new HashMap<>();

        ArrayList<String[]> list = excel.getExcelRead(file_path, file_nm);

        ModelAndView output = null;

        List managementServerList = null;
        List userAuthList = null;

        // 사용자의 폴더 권한 사용 여부
        List sCodeUserFolderAuthList = null;

        //엑셀일괄 등록/수정/삭제 폴더권한 체크 2023.10.10 이상훈
        //관리자는 폴더권한 검색 수행 X
        if (!s_user_gb.equals("99")) {
            paramMap.put("s_user_gb", s_user_gb);
            paramMap.put("user_cd", s_user_cd);
            paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));
            userAuthList = worksUserService.dGetUserAuthList(paramMap);

            paramMap.put("mcode_cd", "M95");
            sCodeUserFolderAuthList = commonService.dGetsCodeList(paramMap);
        }

        try {

            if (list.size() > 0) {
                output = new ModelAndView("main_contents/excelLoad");
                output.addObject("paramMap", paramMap);
                output.addObject("excelList", list);
                output.addObject("userAuthList", userAuthList);
                output.addObject("sCodeUserFolderAuthList", sCodeUserFolderAuthList);
                return output;
            } else {
                Map rMap3 = new HashMap();
                rMap3.put("r_code", "-2");
                rMap3.put("r_msg", "ERROR : 문서 보안 안내\\n1. 엑셀 – 다른 이름으로 저장 – 97-2003 workbook 형식 저장\\n2. 문서보안 해제 확인");
                throw new DefaultServiceException(rMap3);
            }
        } catch (DefaultServiceException e) {

            rMap = e.getResultMap();

            if ("-2".equals(CommonUtil.isNull(rMap.get("r_code")))) {
                logger.error(CommonUtil.isNull(rMap.get("r_msg")));
            } else {
                logger.error(e.getMessage());
            }
        }

        output = new ModelAndView("result/t_result");
        output.addObject("rMap", rMap);
        return output;
    }

    public ModelAndView AppGrpExcelLoad(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);

        String file_nm = CommonUtil.isNull(paramMap.get("file_nm"));
        String act_gb = CommonUtil.isNull(paramMap.get("act_gb"));

        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));
        paramMap.put("searchType", "hostList");

        logger.debug("#WorksController | AppGrpExcelLoad | act_gb :: " + act_gb);

        ExcelUtil excel = new ExcelUtil();
        String file_path = req.getRealPath(CommonUtil.getMessage("MENUAL_FILE.PATH")) + "/excel_tmp";

        Map<String, Object> rMap = new HashMap<>();

        ArrayList<String[]> list = excel.getExcelRead(file_path, file_nm);
        List<CommonBean> host_list = commonService.dGetSearchItemList(paramMap);
        ModelAndView output = null;

        try {

            if (list.size() > 0) {
                output = new ModelAndView("main_contents/appGrpExcelLoad");
                output.addObject("paramMap", paramMap);
                output.addObject("excelList", list);
                output.addObject("hostList", host_list);
                return output;
            } else {
                Map rMap3 = new HashMap();
                rMap3.put("r_code", "-2");
                rMap3.put("r_msg", "ERROR : 문서 보안 안내\\n1. 엑셀 – 다른 이름으로 저장 – 97-2003 workbook 형식 저장\\n2. 문서보안 해제 확인");
                throw new DefaultServiceException(rMap3);
            }
        } catch (DefaultServiceException e) {

            rMap = e.getResultMap();

            if ("-2".equals(CommonUtil.isNull(rMap.get("r_code")))) {
                logger.error(CommonUtil.isNull(rMap.get("r_msg")));
            } else {
                logger.error(e.getMessage());
            }
        }

        output = new ModelAndView("result/t_result");
        output.addObject("rMap", rMap);
        return output;
    }

    public ModelAndView doc05Detail(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);

        paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
        paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));

        String doc_cd = CommonUtil.isNull(paramMap.get("doc_cd"));
        String job_name = CommonUtil.isNull(paramMap.get("job_name"));
        String data_center = CommonUtil.isNull(paramMap.get("data_center"));

        paramMap.put(job_name, job_name);
        paramMap.put(data_center, data_center);

        List mainDocInfoList = worksApprovalDocService.dGetMainDocInfoList(paramMap);

        Doc05Bean doc05 = worksApprovalDocService.dGetDoc05(paramMap);

        JobMapperBean jobMapperInfo = worksUserService.dGetJobMapperInfo(paramMap);

        String strDataCenter = "";
        String strJobName = "";

        logger.debug(doc05.getApplication());

        ModelAndView output = null;
        output = new ModelAndView("main_contents/doc05_m");
        output.addObject("doc_cd", doc_cd);
        output.addObject("doc_gb", "05");
        output.addObject("mainDocInfoList", mainDocInfoList);
        output.addObject("doc05", doc05);
        output.addObject("jobMapperInfo", jobMapperInfo);
        output.addObject("IN_COND_DT", CommonUtil.getMessage("JOB.IN_CONDITION_DATE"));
        output.addObject("IN_COND_AND_OR", CommonUtil.getMessage("JOB.IN_CONDITION_AND_OR2"));
        output.addObject("OUT_COND_DT", CommonUtil.getMessage("JOB.OUT_CONDITION_DATE"));
        output.addObject("OUT_COND_EFFECT", CommonUtil.getMessage("JOB.OUT_CONDITION_EFFECT2"));

        return output;
    }

    public void excelUpload(HttpServletRequest req, HttpServletResponse res, BoardBean bean) throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);

        double randomValue = Math.random();

        String doc_gb = CommonUtil.isNull(paramMap.get("doc_gb"));
        String act_gb = CommonUtil.isNull(paramMap.get("act_gb"));
        String table_name = CommonUtil.isNull(paramMap.get("table_name"));
        String dtAll = doc_gb + "" + act_gb + "" + table_name + "" + randomValue;

        String sp_file_nm = "";
        String file_path = req.getRealPath(CommonUtil.getMessage("MENUAL_FILE.PATH") + "excel_tmp");

        File f = new File(file_path);
        if (!f.exists()) {
            f.mkdir();
        }

        List<MultipartFile> attach = bean.getFiles();

        if (attach != null) {
            for (MultipartFile multifile : attach) {
                if (multifile.isEmpty() == false) {
                    String ori_file_nm = multifile.getOriginalFilename();

                    //파일명 변경
                    if (ori_file_nm.lastIndexOf(".") > -1) {
                        sp_file_nm = ori_file_nm.substring(0, ori_file_nm.lastIndexOf(".")) + "_" + dtAll + ori_file_nm.substring(ori_file_nm.lastIndexOf("."), ori_file_nm.length());
                    } else {
                        sp_file_nm = ori_file_nm + "_" + dtAll;
                    }

                    multifile.transferTo(new File(file_path, sp_file_nm));

                }
            }
        }
        logger.info("file_name=======================>" + sp_file_nm);

        JsUtil.getJsonString(sp_file_nm, res);
    }

    public void defJobExcelUpload(HttpServletRequest req, HttpServletResponse res, BoardBean bean) throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);

        double randomValue = Math.random();

        String doc_gb = CommonUtil.isNull(paramMap.get("doc_gb"));
        String table_name = CommonUtil.isNull(paramMap.get("table_name"));
        String dtAll = doc_gb + "" + table_name + "" + randomValue;

        String sp_file_nm = "";
        String file_path = req.getRealPath(CommonUtil.getMessage("MENUAL_FILE.PATH") + "excel_tmp");

        File f = new File(file_path);
        if (!f.exists()) {
            f.mkdir();
        }

        List<MultipartFile> attach = bean.getFiles();

        if (attach != null) {
            for (MultipartFile multifile : attach) {
                if (multifile.isEmpty() == false) {
                    String ori_file_nm = multifile.getOriginalFilename();

                    //파일명 변경
                    if (ori_file_nm.lastIndexOf(".") > -1) {
                        sp_file_nm = ori_file_nm.substring(0, ori_file_nm.lastIndexOf(".")) + "_" + dtAll + ori_file_nm.substring(ori_file_nm.lastIndexOf("."), ori_file_nm.length());
                    } else {
                        sp_file_nm = ori_file_nm + "_" + dtAll;
                    }

                    multifile.transferTo(new File(file_path, sp_file_nm));

                }
            }
        }
        logger.info("file_name=======================>" + sp_file_nm);

        JsUtil.getJsonString(sp_file_nm, res);
    }

    public ModelAndView userApprovalLine(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);
        paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
        paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
        paramMap.put("user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD"), "0"));
        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));

        ModelAndView output = null;
        output = new ModelAndView("works/C08/main_contents/userApprovalLine");
        output.addObject("APPROVAL_ORDER_CD", CommonUtil.getMessage("APPROVAL.ORDER"));
        output.addObject("APPROVAL_GB_CD", CommonUtil.getMessage("APPROVAL.GB"));
        output.addObject("APPROVAL_GB_NM", CommonUtil.getApprovalLineGb());

        return output;
    }


    @SuppressWarnings("unchecked")
    public ModelAndView ezUserApprovalGroup_p(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);
        paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));

        Map<String, Object> rMap = new HashMap<>();

        try {

            String flag = CommonUtil.isNull(paramMap.get("flag"));
            String line_grp_cd = CommonUtil.isNull(paramMap.get("line_grp_cd"));

            if (flag.equals("")) {
                if (line_grp_cd.equals("0")) {
                    flag = "ins";
                } else {
                    flag = "udt";
                }
            }

            if (flag.equals("ins")) {
                rMap = commonService.dPrcUserApprovalGroupInsert(paramMap);
            } else if (flag.equals("udt")) {
                rMap = commonService.dPrcUserApprovalGroupUpdate(paramMap);
            } else if (flag.equals("del")) {
                rMap = commonService.dPrcUserApprovalGroupDelete(paramMap);
            } else if (flag.equals("group_udt")) {
                rMap = commonService.dPrcUserApprovalGroupTotalUpdate(paramMap);
            }

        } catch (DefaultServiceException e) {

            rMap = e.getResultMap();

            if ("-2".equals(CommonUtil.isNull(rMap.get("r_code")))) {
                logger.error(CommonUtil.isNull(rMap.get("r_msg")));
            } else {
                logger.error(e.getMessage());
            }
            logger.error("ezUserApprovalGroup_p : " + rMap);
        } catch (Exception e) {
            e.getMessage();
        }

        ModelAndView output = null;
        output = new ModelAndView("result/t_result");
        output.addObject("rMap", rMap);

        return output;
    }

    @SuppressWarnings("unchecked")
    public ModelAndView ezUserApprovalLine_p(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);
        String flag = CommonUtil.isNull(paramMap.get("flag"));

        paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));

        Map<String, Object> rMap = new HashMap<>();

        try {

            String line_grp_cd = CommonUtil.isNull(paramMap.get("line_grp_cd"));

            if (flag.equals("ins")) {
                rMap = commonService.dPrcUserApprovalLineInsert(paramMap);
            } else if (flag.equals("udt")) {
                rMap = commonService.dPrcUserApprovalLineUpdate(paramMap);
            } else if (flag.equals("del")) {
                rMap = commonService.dPrcUserApprovalLineDelete(paramMap);
            } else if (flag.equals("group_udt")) {
                rMap = commonService.dPrcUserApprovalLineGroupUpdate(paramMap);
            }

            rMap.put("line_grp_cd", line_grp_cd);

        } catch (DefaultServiceException e) {

            rMap = e.getResultMap();

            if ("-2".equals(CommonUtil.isNull(rMap.get("r_code")))) {
                logger.error(CommonUtil.isNull(rMap.get("r_msg")));
            } else {
                logger.error(e.getMessage());
            }
            logger.error("ezUserApprovalLine_p rMap : " + rMap);
        } catch (Exception e) {
            e.getMessage();
        }

        ModelAndView output = null;
        output = new ModelAndView("result/t_result");
        output.addObject("rMap", rMap);

        return output;
    }


    public void JobNameDupCheck(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);
        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));

        String doc_gb = CommonUtil.isNull(paramMap.get("doc_gb"));
        int cnt = worksApprovalDocService.dGetChkDefJobCnt(paramMap);

        String chk = "N";

        // 작업등록정보 > 수정/삭제 바로가기 버튼으로 호출했을 때 작업명중복 체크
        if (doc_gb.equals("04") || doc_gb.equals("03")) { 
            if (cnt > 1) chk = "Y";
        } else {
            if (cnt > 0) chk = "Y";
        }

        JsUtil.getJsonString(chk, res);
    }

    public ModelAndView ez_ReRunDoc(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);
        paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
        paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
        paramMap.put("user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD"), "0"));
        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));

        String doc_cd = CommonUtil.isNull(paramMap.get("doc_cd"));
        String seq = CommonUtil.isNull(paramMap.get("doc_seq"));
        paramMap.put("seq", seq);

        Map<String, Object> rMap = new HashMap<String, Object>();

        rMap = worksApprovalDocService.dPrcReRunDoc(paramMap);

        logger.info("#WorksController | ez_ReRunDoc | r_code :::" + CommonUtil.isNull(rMap.get("r_code")));
        logger.info("#WorksController | ez_ReRunDoc | doc_cd :::" + CommonUtil.isNull(rMap.get("doc_cd")));

        ModelAndView output = null;
        output = new ModelAndView("result/t_result");
        output.addObject("rMap", rMap);

        return output;
    }

    public ModelAndView adminApprovalLine(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);

        paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
        paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
        paramMap.put("user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD"), "0"));
        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));

        ModelAndView output = null;

        output = new ModelAndView("works/C08/main_contents/adminApprovalLine");

        output.addObject("APPROVAL_ORDER_CD", CommonUtil.getMessage("APPROVAL.ORDER"));
//		output.addObject("APPROVAL_ADMIN_GB_CD", 	CommonUtil.getMessage("APPROVAL.ADMIN.GB"));
        output.addObject("APPROVAL_TYPE_CD", CommonUtil.getMessage("APPROVAL.TYPE"));
        output.addObject("APPROVAL_TYPE_NM", CommonUtil.getApprovalTypeNm());
        output.addObject("DOC_GUBUN_CD", CommonUtil.getMessage("DOC_GUBUN"));
        output.addObject("DOC_GUBUN_NM", CommonUtil.getDocGubunNm());
        output.addObject("ADMIN_APPROVAL_GB_CD", CommonUtil.getMessage("ADMIN.APPROVAL.GB"));
        output.addObject("ADMIN_APPROVAL_GB_NM", CommonUtil.getGbNm("ADMIN.APPROVAL.GB"));

        return output;
    }


    @SuppressWarnings("unchecked")
    public ModelAndView ezAdminApprovalGroup_p(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);

        paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));

        Map<String, Object> rMap = new HashMap<>();

        try {

            String flag = CommonUtil.isNull(paramMap.get("flag"));
            String admin_line_grp_cd = CommonUtil.isNull(paramMap.get("admin_line_grp_cd"));

            if (flag.equals("")) {
                if (admin_line_grp_cd.equals("0")) {
                    flag = "ins";
                } else {
                    flag = "udt";
                }
            }

            if (flag.equals("ins")) {
                rMap = commonService.dPrcAdminApprovalGroupInsert(paramMap);
            } else if (flag.equals("udt")) {
                rMap = commonService.dPrcAdminApprovalGroupUpdate(paramMap);
            } else if (flag.equals("del")) {
                rMap = commonService.dPrcAdminApprovalGroupDelete(paramMap);
            }

        } catch (DefaultServiceException e) {

            rMap = e.getResultMap();

            if ("-2".equals(CommonUtil.isNull(rMap.get("r_code")))) {
                logger.error(CommonUtil.isNull(rMap.get("r_msg")));
            } else {
                logger.error(e.getMessage());
            }
            logger.error("ezAdminApprovalGroup_p rMap : " + rMap);
        } catch (Exception e) {
            e.getMessage();
        }

        ModelAndView output = null;
        output = new ModelAndView("result/t_result");
        output.addObject("rMap", rMap);

        return output;
    }

    @SuppressWarnings("unchecked")
    public ModelAndView ezAdminApprovalLine_p(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);

        String flag = CommonUtil.isNull(paramMap.get("flag"));

        paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));

        Map<String, Object> rMap = new HashMap<>();

        try {

            String admin_line_grp_cd = CommonUtil.isNull(paramMap.get("admin_line_grp_cd"));

            if (flag.equals("ins")) {
                rMap = commonService.dPrcAdminApprovalLineInsert(paramMap);
            } else if (flag.equals("udt")) {
                rMap = commonService.dPrcAdminApprovalLineUpdate(paramMap);
            } else if (flag.equals("del")) {
                rMap = commonService.dPrcAdminApprovalLineDelete(paramMap);
            } else if (flag.equals("group_udt")) {
                rMap = commonService.dPrcAdminApprovalLineGroupUpdate(paramMap);
            }

            rMap.put("admin_line_grp_cd", admin_line_grp_cd);

        } catch (DefaultServiceException e) {

            rMap = e.getResultMap();

            if ("-2".equals(CommonUtil.isNull(rMap.get("r_code")))) {
                logger.error(CommonUtil.isNull(rMap.get("r_msg")));
            } else {
                logger.error(e.getMessage());
            }
            logger.error("ezAdminApprovalLine_p rMap : " + rMap);
        } catch (Exception e) {
            e.getMessage();
        }

        ModelAndView output = null;
        output = new ModelAndView("result/t_result");
        output.addObject("rMap", rMap);

        return output;
    }

    public ModelAndView groupApprovalLine(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);

        paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
        paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
        paramMap.put("user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD"), "0"));
        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));

        ModelAndView output = null;

        output = new ModelAndView("works/C08/main_contents/groupApprovalLine");

        output.addObject("APPROVAL_ORDER_CD", CommonUtil.getMessage("APPROVAL.ORDER"));
        output.addObject("USER_APPR_GB_CD", CommonUtil.getMessage("USER.APPR.GB"));
        output.addObject("USER_APPR_GB_NM", CommonUtil.getGbNm("USER.APPR.GB"));

        return output;
    }


    @SuppressWarnings("unchecked")
    public ModelAndView ezGroupApprovalGroup_p(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);

        paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));

        Map<String, Object> rMap = new HashMap<>();

        try {

            String flag = CommonUtil.isNull(paramMap.get("flag"));
            String group_line_grp_cd = CommonUtil.isNull(paramMap.get("group_line_grp_cd"));

            if (flag.equals("")) {
                if (group_line_grp_cd.equals("0")) {
                    flag = "ins";
                } else {
                    flag = "udt";
                }
            }

            if (flag.equals("ins")) {
                rMap = commonService.dPrcGroupApprovalGroupInsert(paramMap);
            } else if (flag.equals("udt")) {
                rMap = commonService.dPrcGroupApprovalGroupUpdate(paramMap);
            } else if (flag.equals("del")) {
                rMap = commonService.dPrcGroupApprovalGroupDelete(paramMap);
            }

        } catch (DefaultServiceException e) {
            rMap = e.getResultMap();

            if ("-2".equals(CommonUtil.isNull(rMap.get("r_code")))) {
                logger.error(CommonUtil.isNull(rMap.get("r_msg")));
            } else {
                logger.error(e.getMessage());
            }
            logger.error("ezGroupApprovalGroup_p rMap : " + rMap);
        } catch (Exception e) {
            e.getMessage();
        }

        ModelAndView output = null;
        output = new ModelAndView("result/t_result");
        output.addObject("rMap", rMap);

        return output;
    }

    @SuppressWarnings("unchecked")
    public ModelAndView ezGroupApprovalLine_p(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);

        String flag = CommonUtil.isNull(paramMap.get("flag"));

        paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));

        Map<String, Object> rMap = new HashMap<>();

        try {

            String group_line_grp_cd = CommonUtil.isNull(paramMap.get("group_line_grp_cd"));

            if (flag.equals("ins")) {
                rMap = commonService.dPrcGroupApprovalLineInsert(paramMap);
            } else if (flag.equals("udt")) {
                rMap = commonService.dPrcGroupApprovalLineUpdate(paramMap);
            } else if (flag.equals("del")) {
                rMap = commonService.dPrcGroupApprovalLineDelete(paramMap);
            }

            rMap.put("group_line_grp_cd", group_line_grp_cd);

        } catch (DefaultServiceException e) {

            rMap = e.getResultMap();

            if ("-2".equals(CommonUtil.isNull(rMap.get("r_code")))) {
                logger.error(CommonUtil.isNull(rMap.get("r_msg")));
            } else {
                logger.error(e.getMessage());
            }
            logger.error("ezGroupApprovalLine_p rMap : " + rMap);
        } catch (Exception e) {
            e.getMessage();
        }

        ModelAndView output = null;
        output = new ModelAndView("result/t_result");
        output.addObject("rMap", rMap);

        return output;
    }

    public ModelAndView myWork_p(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);

        paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
        paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));

        Map<String, Object> rMap = new HashMap<String, Object>();

        try {

            rMap = worksApprovalDocService.dPrcMyWork(paramMap);

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

        output = new ModelAndView("result/t_result");
        output.addObject("rMap", rMap);

        return output;

    }

    public ModelAndView adminApprovalLine_u(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {
        Map<String, Object> paramMap = CommonUtil.collectParameters(req);
        paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
        paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));

        ModelAndView output = new ModelAndView("works/C08/main_contents/adminApprovalLine_u");
        output.addObject("APPROVAL_ORDER_CD", CommonUtil.getMessage("APPROVAL.ORDER"));
        output.addObject("APPROVAL_TYPE_CD", CommonUtil.getMessage("APPROVAL.TYPE"));
        output.addObject("APPROVAL_TYPE_NM", CommonUtil.getApprovalTypeNm());
        output.addObject("USER_APPR_GB_CD", CommonUtil.getMessage("USER.APPR.GB"));
        output.addObject("USER_APPR_GB_NM", CommonUtil.getGbNm("USER.APPR.GB"));

        return output;
    }

    public ModelAndView cmAppGrpCodeInsert(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {
        Map<String, Object> paramMap = CommonUtil.collectParameters(req);
        paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
        paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));

        Map<String, Object> rMap = commonService.dPrcCmAppGrpInsert(paramMap);

        ModelAndView output = new ModelAndView("result/t_result");
        output.addObject("rMap", rMap);
        return output;
    }

    public void a1201_excel(HttpServletRequest req, HttpServletResponse res) throws Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);

        paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
        paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));

        com.ghayoun.ezjobs.common.util.CryptoDataSource ds = CommonUtil.getDataSourceWorks();

        String sql_text = CommonUtil.replaceStrHtml(CommonUtil.isNull(paramMap.get("sql_text")));
        String limit_cnt = CommonUtil.isNull(paramMap.get("limit_cnt"), "0");
        String db_gb = CommonUtil.getMessage("jdbc_em.driverClassName") + CommonUtil.getMessage("DB_GUBUN");

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        String sql = "";

        try {
            conn = DbUtil.getConnection(ds);

            String sqlLimit = "";
            if (db_gb.indexOf("oracle") > -1) {
                sqlLimit = " and rownum <= " + limit_cnt + " ";
            } else if (db_gb.indexOf("postgresql") > -1) {
                sqlLimit = " limit " + limit_cnt + " ";
            }
            sql = " select * from( \n";
            sql += sql_text + " \n";
            sql += ")T where 1=1 " + sqlLimit + " \n";

            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            ResultSetMetaData rsmd = rs.getMetaData();

            int colCnt = rsmd.getColumnCount();
            StringBuilder sb = new StringBuilder();

            ExcelFormat excelFormat = new ExcelFormat();
            String str_header = "번호";
            String[] arr_header = null;
            Map<String, Object> searchMap = new LinkedHashMap<String, Object>();

            List<ExcelFormat> sheetInfoList = new ArrayList<ExcelFormat>();
            List<Map<Integer, Object>> dataList = new ArrayList<Map<Integer, Object>>();
            Map<Integer, Object> cellMap = null;

            long cnt = 0;
            while (rs.next()) {
                cellMap = new HashMap<Integer, Object>();
                for (int i = 1; i <= colCnt; i++) {
                    cellMap.put(i - 1, CommonUtil.isNull(rs.getString(i)));
                }
                dataList.add(cellMap);
            }

            for (int i = 1; i <= colCnt; i++) {
                if (str_header.equals("")) {
                    str_header += rsmd.getColumnName(i);
                } else {
                    str_header += "," + rsmd.getColumnName(i);
                }
            }
            arr_header = str_header.split(",");

            excelFormat.setSheetName("DB_엑셀조회");
            excelFormat.setColumnHeaders(arr_header);
            excelFormat.setDataList(dataList);
            sheetInfoList.add(excelFormat);
            ExcelUtil.downloadExcel(res, "DB_엑셀", sheetInfoList);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
			try {if(rs!=null) rs.close();}catch(Exception e){}
			try {if(ps!=null) ps.close();}catch(Exception e){}
			try {if(conn!=null) conn.close();}catch(Exception e){}
        }
    }

    public ModelAndView UserExcelLoad(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);

        String file_nm = CommonUtil.isNull(paramMap.get("file_nm"));
        String act_gb = CommonUtil.isNull(paramMap.get("act_gb"));

        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));

        paramMap.put("searchType", "hostList");

        logger.debug("#WorksController | UserExcelLoad | act_gb :: " + act_gb);

        List adminApprovalBtnList = null;
        paramMap.put("mcode_cd", "M80");
        adminApprovalBtnList = commonService.dGetsCodeList(paramMap);

        ExcelUtil excel = new ExcelUtil();
        String file_path = req.getRealPath(CommonUtil.getMessage("MENUAL_FILE.PATH")) + "/excel_tmp";

        Map<String, Object> rMap = new HashMap<>();

        ArrayList<String[]> list = excel.getExcelRead(file_path, file_nm);
        List<CommonBean> host_list = commonService.dGetSearchItemList(paramMap);
        ModelAndView output = null;

        try {
            if (list.size() > 0) {
                output = new ModelAndView("main_contents/UserExcelLoad");
                output.addObject("paramMap", paramMap);
                output.addObject("excelList", list);
                output.addObject("hostList", host_list);
                output.addObject("adminApprovalBtnList", adminApprovalBtnList);
                return output;
            } else {
                Map rMap3 = new HashMap();
                rMap3.put("r_code", "-2");
                rMap3.put("r_msg", "ERROR : 문서 보안 안내\\n1. 엑셀 – 다른 이름으로 저장 – 97-2003 workbook 형식 저장\\n2. 문서보안 해제 확인");
                throw new DefaultServiceException(rMap3);
            }
        } catch (DefaultServiceException e) {
            rMap = e.getResultMap();
            if ("-2".equals(CommonUtil.isNull(rMap.get("r_code")))) {
                logger.error(CommonUtil.isNull(rMap.get("r_msg")));
            } else {
                logger.error(e.getMessage());
            }
        }

        output = new ModelAndView("result/t_result");
        output.addObject("rMap", rMap);
        output.addObject("adminApprovalBtnList", adminApprovalBtnList);

        return output;
    }

    @SuppressWarnings("unchecked")
    public ModelAndView ez002_user_ins_excel(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);
        paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
        paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));

        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));

        Map<String, Object> rMap = new HashMap<String, Object>();

        try {
            rMap = worksUserService.dPrcUserExcel(paramMap);

        } catch (DefaultServiceException e) {
            rMap = e.getResultMap();

            if ("-2".equals(CommonUtil.isNull(rMap.get("r_code")))) {
                logger.error(CommonUtil.isNull(rMap.get("r_msg")));
            } else {
                logger.error(e.getMessage());
            }
            logger.error("ez002_user_ins_excel:" + rMap);
        } catch (Exception e) {
            if ("".equals(CommonUtil.isNull(rMap.get("r_code")))) rMap.put("r_code", "-1");
            if ("".equals(CommonUtil.isNull(rMap.get("r_msg")))) rMap.put("r_msg", "ERROR.01");

            logger.error(e.getMessage());
            logger.error("ez002_user_ins_excel", e);
        }

        ModelAndView output = null;
        output = new ModelAndView("result/t_result");
        output.addObject("rMap", rMap);

        return output;
    }

    public ModelAndView ez002_appGrpCode_form(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);

        paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
        paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));

        ModelAndView output = null;
        output = new ModelAndView("works/P/contents/popup/popAppGrpCodeForm");
        output.addObject("cm", CommonUtil.getComScodeList(paramMap));
        output.addObject("SCODE_GRP_LIST", CommonUtil.getComScodeList(paramMap));
        output.addObject("user_cd", CommonUtil.isNull(paramMap.get("user_cd")));
        //output.addObject("APPROVAL_DOC_NM", CommonUtil.getApprovalDocGb());

        return output;
    }

    public ModelAndView ezSendLogList_excel(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {
        Map<String, Object> paramMap = CommonUtil.collectParameters(req);

        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));

        List sendLogList = worksUserService.dGetSendLogList(paramMap);

        ModelAndView output = null;
        output = new ModelAndView("contents/ezSendLogListExcel");

        output.addObject("sendLogList", sendLogList);

        return output;

    }

    public ModelAndView userChangeExcelLoad(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);

        String file_nm = CommonUtil.isNull(paramMap.get("file_nm"));
        String act_gb = CommonUtil.isNull(paramMap.get("act_gb"));

        logger.debug("#WorksController | ExcelLoad | act_gb :: " + act_gb);

        ExcelUtil excel = new ExcelUtil();
        String file_path = req.getRealPath(CommonUtil.getMessage("MENUAL_FILE.PATH")) + "/excel_tmp";

        Map<String, Object> rMap = new HashMap<>();

        ArrayList<String[]> list = excel.getExcelRead(file_path, file_nm);

        ModelAndView output = null;

        try {

            if (list.size() > 0) {

                output = new ModelAndView("main_contents/userChangeExcelLoad");
                output.addObject("paramMap", paramMap);
                output.addObject("excelList", list);
                return output;

            } else {

                Map rMap3 = new HashMap();
                rMap3.put("r_code", "-2");
                rMap3.put("r_msg", "ERROR : 문서 보안 안내\\n1. 엑셀 – 다른 이름으로 저장 – 97-2003 workbook 형식 저장\\n2. 문서보안 해제 확인");
                throw new DefaultServiceException(rMap3);
            }
        } catch (DefaultServiceException e) {

            rMap = e.getResultMap();

            if ("-2".equals(CommonUtil.isNull(rMap.get("r_code")))) {
                logger.error(CommonUtil.isNull(rMap.get("r_msg")));
            } else {
                logger.error(e.getMessage());
            }
        }

        output = new ModelAndView("result/t_result");
        output.addObject("rMap", rMap);

        return output;
    }

    //담당자일괄변경 기능
    public ModelAndView userChangeExcel_p(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);

        paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
        paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));

        Map<String, Object> rMap = new HashMap<String, Object>();

        try {
            rMap = worksApprovalDocService.dPrcExcelUserChange(paramMap);

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
        output = new ModelAndView("result/t_result");
        output.addObject("rMap", rMap);

        return output;

    }

    //관리자 -> 리소스모니터링.
    public ModelAndView ez057(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);

        paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
        paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
        paramMap.put("user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD"), "0"));
        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));

        ModelAndView output = null;

        output = new ModelAndView("works/C08/main_contents/resourceList");
        output.addObject("cm", CommonUtil.getComScodeList(paramMap));

        return output;
    }

    //알림설정관리
    public ModelAndView ezAlarmInfoList(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParametersK2E(req);

        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));

        Map<String, Object> rMap = new HashMap<String, Object>();

        List alarmInfo = worksUserService.dGetAlarmInfo(paramMap);

        ModelAndView output = null;
        output = new ModelAndView("works/C08/main_contents/alarmInfo");
        output.addObject("alarmInfo", alarmInfo);

        return output;
    }

    //알림설정관리 추가&수정&삭제
    public ModelAndView ezAlarmInfoList_p(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {
        Map<String, Object> paramMap = CommonUtil.collectParametersK2E(req);
        paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
        paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));

        Map<String, Object> rMap = new HashMap<String, Object>();

        try {
            rMap = worksUserService.dPrcAlarmInfo(paramMap);
        } catch (DefaultServiceException e) {
            rMap = e.getResultMap();

            if ("-2".equals(CommonUtil.isNull(rMap.get("r_code")))) {
                logger.error(CommonUtil.isNull(rMap.get("r_msg")));
            } else {
                logger.error(e.getMessage());
            }

        } catch (Exception e) {
            if ("".equals(CommonUtil.isNull(rMap.get("r_code")))) rMap.put("r_code", "-1");
            if ("".equals(CommonUtil.isNull(rMap.get("r_msg")))) rMap.put("r_msg", "ERROR.01");

            logger.error(e.getMessage());
        }

        ModelAndView output = null;
        output = new ModelAndView("result/t_result");
        output.addObject("rMap", rMap);

        return output;

    }
    
    public ModelAndView excel_verify(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

        // 요청 파라미터 수집 및 세션 정보 추가
        Map<String, Object> paramMap = CommonUtil.collectParameters(req);
        paramMap.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
        paramMap.put("s_user_ip", CommonUtil.isNull(req.getSession().getAttribute("USER_IP")));
        paramMap.put("s_user_id", CommonUtil.isNull(req.getSession().getAttribute("USER_ID")));
        paramMap.put("s_user_nm", CommonUtil.isNull(req.getSession().getAttribute("USER_NM")));
        paramMap.put("s_user_gb", CommonUtil.isNull(req.getSession().getAttribute("USER_GB")));
        paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));

        Map<String, Object> rMap = new HashMap<>();

        // 주요 파라미터 변수 설정
        String doc_gb = CommonUtil.isNull(paramMap.get("doc_gb"));
        String flag = CommonUtil.isNull(paramMap.get("flag"));
        String act_gb = CommonUtil.isNull(paramMap.get("act_gb"));
        String doc_cd = CommonUtil.isNull(paramMap.get("doc_cd"));
        String data_center = CommonUtil.isNull(paramMap.get("data_center"));
        String application = CommonUtil.isNull(paramMap.get("application"));
        String table_name = CommonUtil.isNull(paramMap.get("table_name"));
        String task_type = CommonUtil.isNull(paramMap.get("task_type"));
        String odate = CommonUtil.isNull(paramMap.get("odate"));

        List<?> sCodeList = null;
        List<?> sMapperCodeList = null;
        List<?> resourceDefaultList = null;
        List<?> variableDefaultList = null;

        logger.info("excel_verify ParamMap : " + paramMap);

        try {
            // 기본 리소스 및 변수 설정
            rMap.put("doc_gb", doc_gb);
            paramMap.put("mcode_cd", "M81");
            resourceDefaultList = commonService.dGetsCodeList(paramMap);

            paramMap.put("mcode_cd", "M82");
            variableDefaultList = commonService.dGetsCodeList(paramMap);

            paramMap.put("mcode_cd", "M2");
            sCodeList = commonService.dGetsCodeList(paramMap);

            // 파일 관련 변수 설정
            String file_nm = CommonUtil.isNull(paramMap.get("file_nm"));
            String file_path = req.getRealPath(CommonUtil.getMessage("MENUAL_FILE.PATH") + "excel_tmp");
            String save_file_nm = CommonUtil.isNull(paramMap.get("file_nm"));
            rMap = worksApprovalDocService.excel_verify(paramMap);

            // JSON 배열 파싱
            logger.debug("r_ori_con : " + CommonUtil.isNull(rMap.get("r_ori_con")));
            JSONArray jsonArray = new JSONArray(CommonUtil.isNull(rMap.get("r_ori_con")));
            logger.debug("r_new_con : " + CommonUtil.isNull(rMap.get("r_new_con")));
            JSONArray jsonVArray = new JSONArray(CommonUtil.isNull(rMap.get("r_new_con")));
           
            long cnt = 0;

            // 순서 유지와 중복 제거를 위한 LinkedHashSet 사용
            Set<String> orderedKeys = new LinkedHashSet<>();
            
            for (int i = 0; i < jsonVArray.length(); i++) {
                JSONObject jsonObject = jsonVArray.getJSONObject(i);
                CommonUtil.extractKeys(jsonObject, orderedKeys);
            }
            
            // 배열 안의 각 JSON 객체에서 키 추출
            for (int i = 0; i < jsonArray.length(); i++) {
                JSONObject jsonObject = jsonArray.getJSONObject(i);
                CommonUtil.extractKeys(jsonObject, orderedKeys); // 키를 추출하여 Set에 저장
            }
           

            // 추출한 키를 기반으로 헤더 값 생성
            String header = String.join(", ", orderedKeys);

            // XML 생성 로직
            StringBuilder sb = new StringBuilder();
            String tmpData = "<doc> \n<items > \n<json ><![CDATA[ [";
            
            String[] headerArr = header.split(",");

            // JSON 데이터를 순회하면서 처리
            for (int i = 0; i < jsonArray.length(); i++) {
                JSONObject jsonObject = jsonArray.getJSONObject(i);
                JSONObject jsonVObject = (i < jsonVArray.length()) ? jsonVArray.getJSONObject(i) : new JSONObject();

                if (jsonVObject.has("Job") && jsonVObject.get("Job") instanceof String) {
                    String jobValue = jsonVObject.getString("Job").replaceFirst("^V_", ""); // 맨 앞의 V_만 제거
                    jsonVObject.put("Job", jobValue);
                }

                // "eventsToAdd"가 jsonVObject에 있는지 확인
                if (jsonVObject.has("eventsToAdd")) {
                    JSONObject eventsToAdd = jsonVObject.getJSONObject("eventsToAdd");

                    // "Events" 배열이 있는지 확인
                    if (eventsToAdd.has("Events")) {
                        JSONArray eventsArray = eventsToAdd.getJSONArray("Events");

                        // 각 "Event"의 맨 앞 "V_" 접두사만 제거
                        for (int j = 0; j < eventsArray.length(); j++) {
                            JSONObject eventObj = eventsArray.getJSONObject(j);
                            if (eventObj.has("Event")) {
                                String eventValue = eventObj.getString("Event");
                                if (eventValue.startsWith("V_")) {
                                    eventObj.put("Event", eventValue.replaceFirst("^V_", "")); // 맨 앞의 V_만 제거
                                }
                            }
                        }
                    }
                }
                
                JsonObject jObj = new JsonObject();
                jObj.addProperty("grid_idx", cnt);
                jObj.addProperty("row_num", ++cnt);

                boolean isRowEmpty = true;

                // 헤더 순서에 맞게 JSON 객체 생성
                for (int j = 0; j < headerArr.length; j++) {
                    String key = headerArr[j].trim();

                    Object value1 = jsonObject.has(key) ? jsonObject.get(key) : "N/A";
                    Object value2 = jsonVObject.has(key) ? jsonVObject.get(key) : "N/A";

                    if ("N/A".equals(value1) && "N/A".equals(value2)) {
                        jObj.addProperty("col" + j, "");
                    } else {
                        String combinedValue = String.valueOf(value1).replace("\"", "\\\"") + "↔" + String.valueOf(value2).replace("\"", "\\\"");
                        jObj.addProperty("col" + j, combinedValue);
                        isRowEmpty = false;
                    }
                }

                if (!isRowEmpty) {
                    if (cnt > 1) sb.append(",");
                    sb.append(jObj.toString());
                }
            }

            if (sb.length() > 0) {
                tmpData += sb.toString();
            }

            tmpData += "] ]]></json> \n";
            tmpData += "<cnt ><![CDATA[" + CommonUtil.comma(cnt) + "]]></cnt> \n";

            for (String headerValue : headerArr) {
                tmpData += "<item><![CDATA[" + CommonUtil.isNull(headerValue) + "]]></item> \n";
            }

            tmpData += "</items> \n</doc> \n";

            // XML 파싱
            DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
            DocumentBuilder builder = factory.newDocumentBuilder();
            InputSource is = new InputSource(new StringReader(tmpData));
            Document document = builder.parse(is);

            // XML 데이터 및 결과 저장
            rMap.put("xmlDoc", tmpData);
            rMap.put("parsedXmlDoc", document);

        } catch (DefaultServiceException e) {
            rMap = e.getResultMap();
            if ("-2".equals(CommonUtil.isNull(rMap.get("r_code")))) {
                logger.error(CommonUtil.isNull(rMap.get("r_msg")));
            } else {
                logger.error(e.getMessage());
            }
            logger.error("excel_verify : " + rMap);

            String r_msg = CommonUtil.getMessage(CommonUtil.isNull(rMap.get("r_msg")));
            rMap.put("r_msg", r_msg.isEmpty() ? CommonUtil.isNull(rMap.get("r_msg")) : r_msg);

        } catch (Exception e) {
            if ("".equals(CommonUtil.isNull(rMap.get("r_code")))) rMap.put("r_code", "-1");
            if ("".equals(CommonUtil.isNull(rMap.get("r_msg")))) rMap.put("r_msg", "ERROR.01");

            logger.error(e.getMessage());
            logger.error("excel_verify", e);
        }

        // ModelAndView 설정
        ModelAndView output = new ModelAndView("result/t_result");
        output.addObject("rMap", rMap);
        output.addObject("sCodeList", sCodeList);
        output.addObject("sMapperCodeList", sMapperCodeList);

        return output;
    }

    
    public ModelAndView deployJobCompare(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, Exception {

        Map<String, Object> paramMap = CommonUtil.collectParameters(req);
        ModelAndView output = null;
        logger.debug("deployJobCompare paramMap : " + paramMap);
        output = new ModelAndView("works/P/contents/popup/popDeployJobCompare");

        return output;
    }

}