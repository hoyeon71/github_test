<%@page import="net.sf.json.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.ghayoun.ezjobs.t.domain.*" %>
<%@include file="/jsp/common/inc/header.jsp"%>
<%
  response.setHeader("Cache-Control","no-store"); //HTTP 1.1
  response.setHeader("Pragma","no-cache"); //HTTP 1.0
  response.setDateHeader ("Expires", 0);
%>

<%
	Map<String, Object> paramMap = CommonUtil.collectParameters(request);

	String login_gubun 		= CommonUtil.isNull(paramMap.get("login_gubun"));
// 	String user_pw 			= CommonUtil.toSha512(CommonUtil.isNull(paramMap.get("user_pw")));	
	String user_pw 			= CommonUtil.toSha512(CommonUtil.isNull(paramMap.get("user_pw")).replace("&lt;","<").replace("&gt;",">").replace("&amp;","&")+CommonUtil.isNull(paramMap.get("user_id"))+CommonUtil.getMessage("SERVER_GB"));
	List urlLoginYnList		= (List)request.getAttribute("urlLoginYnList");	
	List urlLoginYnOkList	= (List)request.getAttribute("urlLoginYnOkList");
	
	String strUserChk		= CommonUtil.isNull(request.getAttribute("strUserChk"));
	String strloginYn 		= "";
	String strScodeNm 		= "";
	
	if ( urlLoginYnList != null ) {
	
		for(int i=0; i<urlLoginYnList.size(); i++){
			CommonBean commonBean = (CommonBean) urlLoginYnList.get(i);
			strloginYn = CommonUtil.isNull(commonBean.getScode_nm());
		}
	}
	
	// 로그인 시 왼쪽 메뉴 모두 펼침으로 기본 셋팅 요청 (2020.07.08 강명준)
	// 쿠키 설정 : fancytree는 쿠키 값으로 열고 닫는다.
	 String aGb[]   = CommonUtil.getMessage("CATEGORY.GB").split(",");
	 String strTreeCookie  = "";
	 
	 for ( int n = 0; n < aGb.length; n++ ) {
	  strTreeCookie += "tree_c_" + aGb[n] + "~";
	 }
	 
	 if ( !strTreeCookie.equals("") ) {
	  strTreeCookie = strTreeCookie.substring(0, strTreeCookie.length()-1);
	 }
	 
	 Cookie cookie = new Cookie("leftTree_Mexpanded", strTreeCookie);
	 response.addCookie(cookie);
	
	String strServerGb = CommonUtil.isNull(CommonUtil.getMessage("SERVER_GB"));
	
	// OTP 인증 여부 확인
	String strOtpYn = CommonUtil.isNull(CommonUtil.getMessage("OTP_YN"));
%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.min.js" ></script>
<script type="text/javascript" src="<%=sContextPath %>/js/common.js" ></script>
<script type="text/javascript" src="<%=sContextPath %>/js/cookie.js" ></script>
</head>
<body>
<%	
	
	UserBean bean = (UserBean)request.getAttribute("userBean");
	if (login_gubun.equals("ezjobs") ){
		
		if(bean != null){
			
			System.out.println("getUser_gb : " + CommonUtil.isNull(bean.getUser_gb()));
			System.out.println("getUser_ip : " + CommonUtil.isNull(bean.getUser_ip()));
			System.out.println("getRemoteIp : " + CommonUtil.getRemoteIp(request));
			System.out.println("Disconnect_cnt : " +  CommonUtil.isNull(bean.getDisconnect_cnt()));
			System.out.println("Max_login_cnt : " +  CommonUtil.isNull(bean.getMax_login_cnt()));
			System.out.println("getAccount_lock : " +  CommonUtil.isNull(bean.getAccount_lock()));

			// 유저관리에 아이피가 등록되어 있을 경우에만 체크 (2023.06.14 강명준)
			if ( !CommonUtil.isNull(bean.getUser_ip()).equals("") ) {
				if ( !CommonUtil.isNull(bean.getUser_ip()).equals(CommonUtil.getRemoteIp(request)) ) {
				
					out.println("<script type='text/javascript'>");
					out.println("alert('"+CommonUtil.getMessage("ERROR.68")+"');");
					out.println("location.href='"+sContextPath+"/index.jsp';");
					out.println("</script>");
				}
			}

			//계정잠금 or 사용여부 체크
			if(CommonUtil.isNull(bean.getAccount_lock()).equals("Y") || CommonUtil.isNull(bean.getDel_yn()).equals("Y")){
				
				out.println("<script type='text/javascript'>");
				out.println("alert('"+CommonUtil.getMessage("ERROR.33")+"');");
				out.println("location.href='"+sContextPath+"/index.jsp';");
				out.println("</script>");

			//패스워드 주기 만료 체크
			}else if(CommonUtil.isNull(bean.getPw_date_over()).equals("Y")){

				out.println("<form id='frm1' name='frm1' method='post' onsubmit='return false;'>");
				out.println("<input type='hidden' id='user_id' 	name='user_id' 	value='"+CommonUtil.isNull(bean.getUser_id())+"' />");
				out.println("<input type='hidden' id='user_cd' 	name='user_cd' 	value='"+CommonUtil.isNull(bean.getUser_cd())+"' />");
				out.println("<input type='hidden' id='pw_chk' 	name='pw_chk'	value='Y' />");
				out.println("<input type='hidden' id='c' 		name='c' 		value='ez002_pw_change_ui' />");
				out.println("</form>");

				out.println("<script type='text/javascript'>");
				out.println("alert('"+CommonUtil.getMessage("ERROR.34")+ " ["+ CommonUtil.isNull(bean.getPw_update_cycle()) +"일]');");
				out.println("document.frm1.action ='"+sContextPath+"/tWorks.ez';");
				out.println("document.frm1.submit();");

				//out.println("top.location.href='"+sContextPath+"/common.ez?c=ez000&a=contents.userPwChange&user_id="+bean.getUser_id()+"&user_cd="+bean.getUser_cd()+"&pw_chk=Y'");
				out.println("</script>");
				
			//퇴사여부 체크
			}else if(CommonUtil.isNull(bean.getRetire_yn()).equals("Y")){
				
				out.println("<script type='text/javascript'>");
				out.println("alert('"+CommonUtil.getMessage("ERROR.39")+"');");
				out.println("location.href='"+sContextPath+"/common.ez?c=ez000&a=index';");
				out.println("</script>");

			//패스워드 초기화대상
			}else if(CommonUtil.isNull(bean.getReset_yn()).equals("Y")){
				
				out.println("<form id='frm1' name='frm1' method='post' onsubmit='return false;'>");
				out.println("<input type='hidden' id='user_id' 	name='user_id' 	value='"+CommonUtil.isNull(bean.getUser_id())+"' />");
				out.println("<input type='hidden' id='user_cd' 	name='user_cd' 	value='"+CommonUtil.isNull(bean.getUser_cd())+"' />");
				out.println("<input type='hidden' id='c' 		name='c' 		value='ez002_pw_change_ui' />");
				out.println("</form>");

				out.println("<script type='text/javascript'>");
				out.println("alert('"+CommonUtil.getMessage("ERROR.43")+"');");
				out.println("document.frm1.action ='"+sContextPath+"/tWorks.ez';");
				out.println("document.frm1.submit();");

				//out.println("top.location.href='"+sContextPath+"/common.ez?c=ez000&a=contents.userPwChange&user_id="+bean.getUser_id()+"&user_cd="+bean.getUser_cd()+"'");
				out.println("</script>");
			
			//패스워드 사용기간 초과 체크
			}else if(!CommonUtil.isNull(bean.getMax_login_cnt()).equals("")
						&& Integer.parseInt(CommonUtil.isNull(bean.getDisconnect_cnt(), "90")) < Integer.parseInt(CommonUtil.isNull(bean.getMax_login_cnt())) 
						&& !CommonUtil.isNull(bean.getAccount_lock()).equals("U")){ 
				out.println("<script type='text/javascript'>");
				out.println("alert('"+CommonUtil.getMessage("ERROR.63")+"');");
				out.println("location.href='"+sContextPath+"/index.jsp';");
				out.println("</script>");

			//패스워드 일치여부체크
			}else if(user_pw.equals(bean.getUser_pw())){
				
				if ( strOtpYn.equals("Y") ) {
					
					out.println("<form id='frm1' name='frm1' method='post' onsubmit='return false;'>");
					out.println("<input type='hidden' id='user_cd' 	name='user_cd' 	value='"+CommonUtil.isNull(bean.getUser_cd())+"' />");
					out.println("<input type='hidden' id='user_id' 	name='user_id' 	value='"+CommonUtil.isNull(bean.getUser_id())+"' />");
					out.println("<input type='hidden' id='user_pw' 	name='user_pw' 	value='"+CommonUtil.isNull(paramMap.get("user_pw"))+"' />");
					out.println("</form>");

					out.println("<script type='text/javascript'>");
					out.println("document.frm1.action ='"+sContextPath+"/jsp/otp/otp.jsp';");
					out.println("document.frm1.submit();");
					out.println("</script>");
					
					//out.println("<script type='text/javascript'>");
					//out.println("location.href='"+sContextPath+"/otp.jsp?user_id="+bean.getUser_id()+"';");
					//out.println("</script>");
					
				} else {					

					request.getSession().setAttribute("USER_CD"						,bean.getUser_cd());
					request.getSession().setAttribute("USER_ID"						,bean.getUser_id());
					request.getSession().setAttribute("USER_NM"						,CommonUtil.E2K(bean.getUser_nm()));
					request.getSession().setAttribute("USER_GB"						,CommonUtil.isNull(bean.getUser_gb()));
					request.getSession().setAttribute("USER_EMAIL"					,CommonUtil.isNull(bean.getUser_email()));
					request.getSession().setAttribute("USER_HP"						,CommonUtil.isNull(bean.getUser_hp()));
					request.getSession().setAttribute("DEPT_CD"						,CommonUtil.isNull(bean.getDept_cd()));
					request.getSession().setAttribute("DEPT_NM"						,CommonUtil.E2K(bean.getDept_nm()));
					request.getSession().setAttribute("DUTY_CD"						,CommonUtil.isNull(bean.getDuty_cd()));
					request.getSession().setAttribute("DUTY_NM"						,CommonUtil.E2K(bean.getDuty_nm()));
					request.getSession().setAttribute("PART_CD"						,CommonUtil.isNull(bean.getPart_cd()));
					request.getSession().setAttribute("PART_NM"						,CommonUtil.E2K(bean.getPart_nm()));
					request.getSession().setAttribute("NO_AUTH"						,CommonUtil.isNull(bean.getNo_auth()));
					request.getSession().setAttribute("LOGIN_GUBUN","EZJOBS");
					request.getSession().setAttribute("USER_IP"						,CommonUtil.getRemoteIp(request));
					request.getSession().setAttribute("USER_APPR_GB"				,CommonUtil.isNull(bean.getUser_appr_gb()));
	
					request.getSession().setAttribute("SELECT_DATA_CENTER_CODE",	bean.getSelect_data_center_code());
					request.getSession().setAttribute("SELECT_DATA_CENTER",			bean.getSelect_data_center());
					request.getSession().setAttribute("SELECT_TABLE_NAME",			bean.getSelect_table_name());
					request.getSession().setAttribute("SELECT_APPLICATION",			bean.getSelect_application());
					request.getSession().setAttribute("SELECT_GROUP_NAME",			bean.getSelect_group_name());
					request.getSession().setAttribute("DEFAULT_PAGING",				bean.getDefault_paging());
					request.getSession().setAttribute("ALERT_CNT",					bean.getAlert_cnt());
					request.getSession().setAttribute("ALERT_CLOSE",				"N");
					request.getSession().setAttribute("BATCH_CONTROL",				CommonUtil.isNull(bean.getControl_flag()));
					request.getSession().setAttribute("ACTIVE_AUTH",				CommonUtil.isNull(bean.getUser_appr_gb()));
	
					request.getSession().setAttribute("alarm_chk1", 				CommonUtil.isNull(bean.getAlarm_chk1()));
					request.getSession().setAttribute("alarm_chk2", 				CommonUtil.isNull(bean.getAlarm_chk2()));
					request.getSession().setAttribute("alarm_chk3", 				CommonUtil.isNull(bean.getAlarm_chk3()));
					
					request.getSession().setAttribute("LOGIN_CHK",					"Y");
	
					//로그인 성공 후 호출
					HttpSession httpSession = request.getSession();
					MySessionManager.instance().loginProcess(bean.getUser_id(), httpSession);
							
					out.println("<script type='text/javascript'>");
					out.println("location.href='"+sContextPath+"/common.ez?c=ez00';");
					out.println("</script>");
				}

			} else {
				out.println("<script type='text/javascript'>");
				out.println("alert('" + CommonUtil.getMessage("ERROR.08") + "' + '\\n\\n실패 횟수 : ' + '"+CommonUtil.isNull(bean.getPw_fail_cnt())+"' + '/5');");
				out.println("location.href='" + sContextPath + "/index.jsp';");
				out.println("</script>");
			}
		}else{
			if(Integer.parseInt(strUserChk ) > 0){
				out.println("<script type='text/javascript'>");
				out.println("alert('"+CommonUtil.getMessage("ERROR.02")+" 관리자에게 문의해주세요.');");
				out.println("location.href='" + sContextPath + "/index.jsp';");
				out.println("</script>");
			}else{
				out.println("<script type='text/javascript'>");
				out.println("alert('"+CommonUtil.getMessage("ERROR.08")+"');");
				out.println("location.href='" + sContextPath + "/index.jsp';");
				out.println("</script>");
			}
		}
			
	//SSO 로그인
	}else{		
		if(bean != null){
			
			if (CommonUtil.isNull(bean.getAccount_lock()).equals("Y") || CommonUtil.isNull(bean.getDel_yn()).equals("Y")) {
				
				out.println("<script type='text/javascript'>");
				out.println("alert('"+CommonUtil.getMessage("ERROR.33")+"');");
				out.println("location.href='"+sContextPath+"/index.jsp';");
				out.println("</script>");				
			}
			
			request.getSession().setAttribute("LOGIN_GUBUN",				"SSO");
			request.getSession().setAttribute("USER_CD",					bean.getUser_cd());
			request.getSession().setAttribute("USER_ID",					bean.getUser_id());
			request.getSession().setAttribute("ACCOUNT_LOCK",				bean.getAccount_lock());
			request.getSession().setAttribute("USER_NM",					CommonUtil.E2K(bean.getUser_nm()));
			request.getSession().setAttribute("USER_GB",					CommonUtil.isNull(bean.getUser_gb()));
			request.getSession().setAttribute("USER_EMAIL",					CommonUtil.isNull(bean.getUser_email()));
			request.getSession().setAttribute("USER_HP",					CommonUtil.isNull(bean.getUser_hp()));
			request.getSession().setAttribute("DEPT_CD",					CommonUtil.isNull(bean.getDept_cd()));
			request.getSession().setAttribute("DEPT_NM",					CommonUtil.E2K(bean.getDept_nm()));
			request.getSession().setAttribute("DUTY_CD",					CommonUtil.isNull(bean.getDuty_cd()));
			request.getSession().setAttribute("DUTY_NM",					CommonUtil.E2K(bean.getDuty_nm()));
			request.getSession().setAttribute("PART_CD",					CommonUtil.isNull(bean.getPart_cd()));
			request.getSession().setAttribute("PART_NM",					CommonUtil.E2K(bean.getPart_nm()));
			request.getSession().setAttribute("NO_AUTH",					CommonUtil.isNull(bean.getNo_auth()));
			request.getSession().setAttribute("USER_IP", 					CommonUtil.getRemoteIp(request));
			request.getSession().setAttribute("USER_APPR_GB", 				CommonUtil.isNull(bean.getUser_appr_gb()));


			request.getSession().setAttribute("SELECT_DATA_CENTER_CODE",	bean.getSelect_data_center_code());
			request.getSession().setAttribute("SELECT_DATA_CENTER",			bean.getSelect_data_center());
			request.getSession().setAttribute("SELECT_APPLICATION",			bean.getSelect_application());
			request.getSession().setAttribute("SELECT_GROUP_NAME",			bean.getSelect_group_name());
			request.getSession().setAttribute("DEFAULT_PAGING",				bean.getDefault_paging());
			request.getSession().setAttribute("ALERT_CNT",					bean.getAlert_cnt());
			request.getSession().setAttribute("ALERT_CLOSE",				"N");
			request.getSession().setAttribute("BATCH_CONTROL",				CommonUtil.isNull(bean.getControl_flag()));
			request.getSession().setAttribute("ACTIVE_AUTH",				CommonUtil.isNull(bean.getUser_appr_gb()));

			request.getSession().setAttribute("alarm_chk1", 				CommonUtil.isNull(bean.getAlarm_chk1()));
			request.getSession().setAttribute("alarm_chk2", 				CommonUtil.isNull(bean.getAlarm_chk2()));
			request.getSession().setAttribute("alarm_chk3", 				CommonUtil.isNull(bean.getAlarm_chk3()));
			
			request.getSession().setAttribute("LOGIN_CHK",					"Y");
			
			out.println("<script type='text/javascript'>");
			out.println("location.href='"+sContextPath+"/common.ez?c=ez00';");
			out.println("</script>");
		
		}else{
			
			out.println("<script type='text/javascript'>");
			out.println("alert('"+CommonUtil.getMessage("ERROR.08")+"');");
			out.println("location.href='"+sContextPath+"/index.jsp';");
			out.println("</script>");
			
		}
	}
	
	
%>
</body>
</html>
