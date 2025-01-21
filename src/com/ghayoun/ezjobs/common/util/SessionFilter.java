package com.ghayoun.ezjobs.common.util;

import java.io.IOException;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public class SessionFilter implements Filter {

	protected final Log logger = LogFactory.getLog(getClass());
	private static final String EXCEPT_URL = "/tWorks.ez";
	private static final String EXCEPT_URL2 = "/external.ez";
	private static final String EXCEPT_PARAM = "ez001";
	private static final String EXCEPT_PARAM2 = "ez001_sso";
	private static final String EXCEPT_PARAM3 = "ez002_pw_change";
	private static final String EXCEPT_PARAM4 = "ez002_pw_change_ui";

	private static final String AUTH_FAIL_URL 	= "/jsp/common/inc/auth_fail.jsp";
	private static final String LOGOUT_URL = "/jsp/common/inc/sessionChk.jsp";
	private static final String LOGIN_URL = "/login.jsp";
	private static final String SSO_ID_URL = "/jsp/config.jsp";
	private static final String SSO_EXEC_URL = "/jsp/login_exec.jsp";
	private static final String PARAM_EXEC_URL = "/jsp/param/app_login_exec.jsp";
	private static final String SSO_LOGIN_URL = "/jsp/login.jsp";
	private static final String MAIN_URL = "/";
	private static final String INDEX_URL = "/index.jsp";
	private static final String INDEX2_URL = "/index2.jsp";
	private static final String OTP_URL = "/otp/";
	private static final String TEST_URL = "/test/";
	private static final String SITE_URL = "api_site";
	private static final String SYSADMIN = "/sysadmin.jsp";
	private static final String SYSADMIN2 = "/sysadmin2.jsp";
	private static final String FOL_CPAY = "ez002_folappgrp_copy";
	private static final String TEMPPASSWORD = "ez001_tempPassword";
	
	@Override
	public void destroy() {
	}

	@Override
	public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain)
			throws IOException, ServletException {

		HttpServletRequest httpServletRequest 	= (HttpServletRequest) servletRequest;
		HttpServletResponse httpServletResponse = (HttpServletResponse) servletResponse;
		
		String pageUrl 	= httpServletRequest.getRequestURI();
		String user_id 	= CommonUtil.isNull((httpServletRequest.getSession().getAttribute("USER_ID")));
		String user_gb 			= CommonUtil.isNull((httpServletRequest.getSession().getAttribute("USER_GB")));
		String prvSession = CommonUtil.isNull((httpServletRequest.getSession().getAttribute("prvSession")));
		String a 		= CommonUtil.isNull(httpServletRequest.getParameter("a"));
		String c 				= CommonUtil.isNull(httpServletRequest.getParameter("c"));
		String admin_menu_gb 	= CommonUtil.isNull(CommonUtil.getMessage("CATEGORY.GB.06.GB"));
		boolean isGet		= httpServletRequest.getMethod().equals("GET");

		logger.debug("pageUrl : " + pageUrl);
		logger.debug("a : " + a);
		logger.debug("prvSession : " + prvSession);
		logger.debug("c : " + CommonUtil.isNull(httpServletRequest.getParameter("c")));
		logger.debug("isGet : " + isGet);
		logger.debug("user_id : " + user_id);
		
		if (LOGOUT_URL.equals(pageUrl) || LOGIN_URL.equals(pageUrl) || INDEX_URL.equals(pageUrl) || INDEX2_URL.equals(pageUrl) || pageUrl.indexOf(OTP_URL) > -1 || MAIN_URL.equals(pageUrl) || pageUrl.indexOf(TEST_URL) > -1 || SSO_ID_URL.equals(pageUrl) || SSO_EXEC_URL.equals(pageUrl) || SSO_LOGIN_URL.equals(pageUrl) || PARAM_EXEC_URL.equals(pageUrl) || SYSADMIN.equals(pageUrl) || SYSADMIN2.equals(pageUrl) || EXCEPT_URL2.equals(pageUrl)) {			
			// pass
		} else if ( EXCEPT_URL.equals(pageUrl) && (EXCEPT_PARAM.equals(CommonUtil.isNull(httpServletRequest.getParameter("c"))) || EXCEPT_PARAM2.equals(CommonUtil.isNull(httpServletRequest.getParameter("c"))) || EXCEPT_PARAM3.equals(CommonUtil.isNull(httpServletRequest.getParameter("c"))) || FOL_CPAY.equals(CommonUtil.isNull(httpServletRequest.getParameter("c"))))) {
			// pass

		} else if ( EXCEPT_PARAM4.equals(CommonUtil.isNull(httpServletRequest.getParameter("c"))) || "contents.userPwChange".equals(a) ) {

			// 패스워드 변경 화면을 POST 방식으로 접근하면 pass
			if ( isGet ) {
				//user_id = "";
				//httpServletRequest.getSession(true).getServletContext().getRequestDispatcher(LOGOUT_URL).forward(httpServletRequest, httpServletResponse);
				httpServletResponse.sendRedirect(INDEX_URL);
			}

		// 그룹웨어 건수
		} else if ("/mEm.ez".equals(pageUrl) && "ez019".equals(CommonUtil.isNull(httpServletRequest.getParameter("c")))) {
			// pass

		} else if ("/common.ez".equals(pageUrl) && "ez000".equals(CommonUtil.isNull(httpServletRequest.getParameter("c")))) {
			//if ("index".equals(a) || "contents.userPwChange".equals(a) || !"".equals(user_id) || a.indexOf(SITE_URL) > -1 ) {
			if ("index".equals(a) || !"".equals(user_id) || a.indexOf(SITE_URL) > -1 ) {
				// pass
			} else {
				httpServletRequest.getSession(true).getServletContext().getRequestDispatcher(LOGOUT_URL).forward(httpServletRequest, httpServletResponse);  
				//httpServletResponse.sendRedirect(LOGOUT_URL);
			}
		} else if ("".equals(user_id) && !c.equals(TEMPPASSWORD)) {
			httpServletRequest.getSession(true).getServletContext().getRequestDispatcher(LOGOUT_URL).forward(httpServletRequest, httpServletResponse);
			//httpServletResponse.sendRedirect(LOGOUT_URL);
		//이중로그인 체크로직 추가
		} else if(!"".equals(prvSession)){
			httpServletRequest.getSession(true).getServletContext().getRequestDispatcher(LOGOUT_URL).forward(httpServletRequest, httpServletResponse);
		}
		
		// 일반 사용자의 관리자 페이지 이동 체크
		if ( !user_gb.equals("") && !user_gb.equals("99") ) {
			System.out.println("admin_menu_gb : " + admin_menu_gb);
			String[] arr_admin_menu_gb = admin_menu_gb.split(",");
			int authCnt = 0;
			String extractedString = "";
			for (int i = 0; i < arr_admin_menu_gb.length; i++ ) {
				String menu_gb = CommonUtil.getMessage("CATEGORY.GB.06.GB." + arr_admin_menu_gb[i]);

				String patternString = "c=([^,|&]+)(?:,|&menu_gb=)";
		        // 패턴 컴파일
		        Pattern pattern = Pattern.compile(patternString);
		        Matcher matcher1 = pattern.matcher(menu_gb);
		        if (matcher1.find()) {
		            // 추출된 문자열
		            extractedString = matcher1.group(1);
		            System.out.println("Extracted String from input1: " + extractedString);
		        }

		        // 두 번째 입력 문자열에 대해 매칭 확인
		        Matcher matcher2 = pattern.matcher(menu_gb);
		        if (matcher2.find()) {
		            // 추출된 문자열
		            extractedString = matcher2.group(1);
		            System.out.println("Extracted String from input2: " + extractedString);
		        }

				if(extractedString.equals(c)) {
					if(!menu_gb.split(",")[2].equals(user_gb) && !user_gb.equals("") && !c.equals("")) {
						if ( menu_gb.split(",")[1].indexOf(pageUrl.substring(1, pageUrl.length()) + "?c=" + c) > -1 ) {
							if ( menu_gb.split(",")[1].indexOf("_grp") > -1 ) {
								if(!menu_gb.split(",")[2].equals(user_gb)) {
									if(menu_gb.split(",")[2].equals("02") && (!user_gb.equals("99") && !user_gb.equals("02"))) {
										httpServletResponse.sendRedirect(AUTH_FAIL_URL);
									}else if(menu_gb.split(",")[2].equals("99") && !user_gb.equals("99")) {
										httpServletResponse.sendRedirect(AUTH_FAIL_URL);
									}
								}
							}else if (!user_gb.equals("99") && menu_gb.split(",")[1].equals("tWorks.ez?c=ez013&menu_gb=0604")) {
								//httpServletResponse.sendRedirect(AUTH_FAIL_URL);
								httpServletRequest.getSession(true).getServletContext().getRequestDispatcher(AUTH_FAIL_URL).forward(httpServletRequest, httpServletResponse);
							}else {
								System.out.println("menu_gb : " + menu_gb);
								System.out.println("menu_gb : " + menu_gb.split(",")[2]);
								if(!menu_gb.split(",")[2].equals(user_gb)) {
									if(menu_gb.split(",")[2].equals("02") && (!user_gb.equals("99") && !user_gb.equals("02"))) {
									httpServletResponse.sendRedirect(AUTH_FAIL_URL);
									}else if(menu_gb.split(",")[2].equals("99") && !user_gb.equals("99")) {
									httpServletResponse.sendRedirect(AUTH_FAIL_URL);
									}
								}
							}

						}
					}
				}
			}
		}

		filterChain.doFilter(servletRequest, servletResponse);
	}

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
	}

}
