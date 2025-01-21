<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/jsp/common/inc/header.jsp"%>
<%@ page import="java.sql.*,java.util.*,java.io.*,java.text.*,java.net.*" %>
<%@ page import="com.ghayoun.ezjobs.t.domain.*" %>
<c:set var="caluse_gb_cd" value="${fn:split(CALUSE_GB_CD,',')}"/>
<c:set var="caluse_gb_nm" value="${fn:split(CALUSE_GB_NM,',')}"/>

<c:set var="prio_gb_cd" value="${fn:split(PRIORITY_GB_CD,',')}"/>
<c:set var="prio_gb_nm" value="${fn:split(PRIORITY_GB_NM,',')}"/>
<%
	//js version 추가하여 캐시 새로고침
	String jsVersion = CommonUtil.getMessage("js_version");
%>
<!DOCTYPE html>
<html>
<head><title><%=CommonUtil.getMessage("HOME.TITLE") %></title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<link href="<%=request.getContextPath() %>/css/common.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath() %>/css/custom-theme/jquery-ui.custom.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath() %>/css/custom-theme/jquery-ui.works.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath() %>/css/layout-default.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath() %>/css/ftree/ui.fancytree.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath() %>/js/SlickGrid-2.1.0/slick.grid.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath() %>/js/SlickGrid-2.1.0/css/select2.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath() %>/css/slick-default-theme.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath() %>/js/poshytip-1.2/tip.css" rel="stylesheet" type="text/css" />
<style type="text/css">
	.select2-container {
		top: -3px;
		left: -6px;
	}
    .select2-container .select2-selection--single {
		height: 26px;
	}  
</style>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/common.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/cookie.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/popup.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/xhrHandler.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.min.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery-ui.custom.min.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.resizeEnd.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.corner.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.cookie.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery-sha256.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.placeholder.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.blockUI.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.event.drag-2.2.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.dialogextend.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.layout.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.layout.slideOff.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.fancytree-all.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/SlickGrid-2.1.0/slick.core.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/SlickGrid-2.1.0/plugins/slick.autotooltips.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/SlickGrid-2.1.0/plugins/slick.checkboxselectcolumn.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/SlickGrid-2.1.0/plugins/slick.rowselectionmodel.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/SlickGrid-2.1.0/plugins/select2.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/SlickGrid-2.1.0/slick.dataview.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/SlickGrid-2.1.0/slick.grid.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/SlickGrid-2.1.0/slick.editors.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/poshytip-1.2/jquery.poshytip.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/works_common.js?v=<%=jsVersion %>" ></script>

</head>


<%
	
	Map<String, Object> paramMap = CommonUtil.collectParameters(request);
	String c = CommonUtil.isNull(paramMap.get("c"));
	String gridId 	= "g_"+c;
	String gridId_1 = "g_"+c+"_1";
	String gridId_2 = "g_"+c+"_2";
	String gridId_3 = "g_"+c+"_3";
	String gridId_4 = "g_"+c+"_4";
	
	// admin_udt=Y : 관리자 수정
	String admin_udt 		= CommonUtil.isNull(paramMap.get("admin_udt"));
	
	String s_doc_gb 		= CommonUtil.isNull(paramMap.get("s_doc_gb"));
	String s_gb 			= CommonUtil.isNull(paramMap.get("s_gb"));
	String s_text 			= CommonUtil.isNull(paramMap.get("s_text"));
	String s_state_cd 		= CommonUtil.isNull(paramMap.get("s_state_cd"));
	
	String state_cd 		= CommonUtil.isNull(paramMap.get("state_cd"));
	String approval_cd 		= CommonUtil.isNull(paramMap.get("approval_cd"));
	
	String doc_cd 			= CommonUtil.isNull(paramMap.get("doc_cd"));
	String max_doc_cd		= CommonUtil.isNull(paramMap.get("max_doc_cd"));
	String doc_gb 			= CommonUtil.isNull(paramMap.get("doc_gb"));
	String rc 				= CommonUtil.isNull(paramMap.get("rc"));
	String flag				= CommonUtil.isNull(paramMap.get("flag"));
	
	// 참조기안
	if ( flag.equals("ref") ) {
		doc_cd 		= "";
	}
	
	// 목록 화면 검색 파라미터.
	String search_data_center 	= CommonUtil.isNull(paramMap.get("search_data_center"));
	String search_state_cd 		= CommonUtil.isNull(paramMap.get("search_state_cd")); 		// 의뢰목록에서 넘어온 값
	String search_approval_cd 	= CommonUtil.isNull(paramMap.get("search_approval_cd")); 	// 결재목록에서 넘어온 값 
	String search_gb 			= CommonUtil.isNull(paramMap.get("search_gb"));
	String search_text 			= CommonUtil.isNull(paramMap.get("search_text"));
	String search_date_gubun 	= CommonUtil.isNull(paramMap.get("search_date_gubun"));
	String search_s_search_date = CommonUtil.isNull(paramMap.get("search_s_search_date"));
	String search_e_search_date = CommonUtil.isNull(paramMap.get("search_e_search_date"));
	String search_task_nm 		= CommonUtil.isNull(paramMap.get("search_task_nm"));
	String search_moneybatchjob	= CommonUtil.isNull(paramMap.get("search_moneybatchjob"));
	String search_critical		= CommonUtil.isNull(paramMap.get("search_critical"));

	if ( !max_doc_cd.equals("") ) {
		doc_cd = max_doc_cd;
	}
	
	String currentPage 		= CommonUtil.isNull(paramMap.get("currentPage"));
		
	List approvalLineList		= (List)request.getAttribute("approvalLineList");	
	List dataCenterList		    = (List)request.getAttribute("dataCenterList");	
	List mainDocInfoList 		= (List)request.getAttribute("mainDocInfoList");	
	List sCodeList				= (List)request.getAttribute("sCodeList");	
	List appGrpList				= (List)request.getAttribute("appGrpList");
	List sBatchGradeList		= (List)request.getAttribute("sBatchGradeList");
	List jobTypeGbList			= (List)request.getAttribute("jobTypeGb"); 
	List systemGbList			= (List)request.getAttribute("systemGb");
	List adminApprovalBtnList 	= (List)request.getAttribute("adminApprovalBtnList");
	
	AppGrpBean appGrpBean 		= (AppGrpBean) appGrpList.get(0);
	JobMapperBean jobMapperBean	= (JobMapperBean)request.getAttribute("jobMapperInfo");	
	Doc01Bean docBean			= (Doc01Bean)request.getAttribute("doc01");
	
	// 참조기안시 작업명을 가지고 매퍼를 찾기 때문에 필요.
	String strJobName 		= CommonUtil.E2K(docBean.getJob_name());
	
	String strMonth_days 		= CommonUtil.E2K(docBean.getMonth_days());
	String strSchedule_and_or 	= CommonUtil.E2K(docBean.getSchedule_and_or());
	String strWeek_days 		= CommonUtil.E2K(docBean.getWeek_days());
	String strDays_cal 			= CommonUtil.E2K(docBean.getDays_cal());
	String strWeeks_cal 		= CommonUtil.E2K(docBean.getWeeks_cal());	
	String strMonth_data 		= CommonUtil.E2K(docBean.getMonth_cal());
	String strConf_cal 			= CommonUtil.E2K(docBean.getConf_cal());
	String strShift_num 		= CommonUtil.E2K(docBean.getShift_num());
	String strShift 			= CommonUtil.E2K(docBean.getShift());
	String strTitle 			= CommonUtil.replaceStrXml(CommonUtil.E2K(docBean.getTitle()));
	String strContent 			= CommonUtil.replaceStrXml(CommonUtil.E2K(docBean.getContent()));
	String strMemLib			= CommonUtil.E2K(docBean.getMem_lib());
	
	if(strMemLib.length() > 3 && strMemLib.substring(2, 3).equals("\\") && !strMemLib.substring(3, 4).equals("\\")){
		strMemLib = strMemLib.replaceAll("\\\\", "\\\\\\\\");
	}
	
	String strT_set 				= CommonUtil.isNull(docBean.getT_set());
	String strMonitor_time			= "";
	String strMonitor_interval		= "";
	String strFilesize_comparison	= "";
	String strNum_of_iterations		= "";
	String strStop_time				= "";
	String strAdminApprovalBtn		= "";
	
	if ( adminApprovalBtnList != null ) {		
		for ( int i = 0; i < adminApprovalBtnList.size(); i++ ) {			
			CommonBean commonBean = (CommonBean) adminApprovalBtnList.get(i);			
			strAdminApprovalBtn = CommonUtil.isNull(commonBean.getScode_nm());
		}
	}
	
	// LIBMEMSIM, FileWatch 제거 후 변수 셋팅.
// 	String strT_set_var = "";
// 	if ( !strT_set.equals("") ) {
// 		String arr_t_set[]  = strT_set.split("[|]");		
// 		for ( int i = 0; i < arr_t_set.length; i++ ) {
// 			String arr_t_set_detail[]  = arr_t_set[i].split("[,]");
			
// 			if ( arr_t_set_detail.length > 1 ) {
			
// 				if ( arr_t_set_detail[0].equals("LIBMEMSYM") || arr_t_set_detail[0].indexOf("FileWatch") > -1  ) {
					
// 				} else {
// 					strT_set_var += "|" + arr_t_set[i];
// 				}
				
// 				// FileWatch 셋팅
// 				if ( arr_t_set_detail[0].indexOf("FileWatch-INT_FILE_SEARCHES") > -1 ) {
// 					strMonitor_interval = arr_t_set_detail[1];
// 				}
// 				if ( arr_t_set_detail[0].indexOf("FileWatch-TIME_LIMIT") > -1 ) {
// 					strMonitor_time = arr_t_set_detail[1];
// 				}
// 				if ( arr_t_set_detail[0].indexOf("FileWatch-INT_FILESIZE_COMPARISON") > -1 ) {
// 					strFilesize_comparison = arr_t_set_detail[1];
// 				}
// 				if ( arr_t_set_detail[0].indexOf("FileWatch-NUM_OF_ITERATIONS") > -1 ) {
// 					strNum_of_iterations = arr_t_set_detail[1];
// 				}
// 				if ( arr_t_set_detail[0].indexOf("FileWatch-STOP_TIME") > -1 ) {
// 					strStop_time = arr_t_set_detail[1];
// 				}
// 			}
// 		}
		
// 		if ( !strT_set_var.equals("") && strT_set_var.substring(0, 1).equals("|") ) strT_set_var = strT_set_var.substring(1, strT_set_var.length());
// 	}
	
	String[] aTmp 	= null;
	String[] aTmpT 	= null;
	
	String strUserNm1				= "";
	String strUserNm2				= "";
	String strUserNm3				= "";
	String strUserNm4 				= "";
	String strDescription			= "";
	String strSms1 					= "";
	String strSms2 					= "";
	String strSms3 					= "";
	String strSms4 					= "";
	String strMail1 				= "";
	String strMail2 				= "";
	String strMail3 				= "";
	String strMail4 				= "";
	String strErrorDescription		= "";
	String strLogName1				= "";
	String strLogName2				= "";
	String strLogPath1				= "";
	String strLogPath2				= "";
	String strLateSub				= "";
	String strLateTime				= "";
	String strLateExec				= "";
	String strBatchJobGrade			= "";
	String strMoneyBatchJob			= "";
	String strRefTable				= "";
	String strGlobalCond_yn			= "";
	String	strCalendar_nm			= "";
	
	String strSrNo					= "";
	String strChargePmNm			= "";
	String strProjectManMonth		= "";
	String strProjectNm				= "";
	String strSrNonAttachedReason	= "";
	
	String strCall1 				= "";
	String strCall2 				= "";
	String strCall3 				= "";
	String strCall4 				= "";
	String strMsg1 					= "";
	String strMsg2 					= "";
	String strMsg3 					= "";
	String strMsg4 					= "";	
	
	String strJobTypeGb           	= "";
	
	String jobTypeGb             	= "";
	
	String strArgument     	 		= "";
	String strMcode_nm    	    	= "";
	String strScode_nm           	= "";
	
	String strSystemGb				= "";	
	String systemGb					= "";	
	String strUserCd1 				= "";
	String strUserCd2 				= "";
	String strUserCd3 				= "";
	String strUserCd4 				= "";
	
	String strCcYn 					= "";
	String strCcCount 				= "";
	
	String	global_yn				= "";
	String	strSuccessSmsYn			= "";
	
	String strOutYn					= "";
	String strInYn					= "";
	
	String strUmsYn					= "";
	String strVerificationYn		= "";
	
	if ( jobMapperBean != null ) {
		
		strUserCd1 				= CommonUtil.isNull(jobMapperBean.getUser_cd_1());
		strUserCd2 				= CommonUtil.isNull(jobMapperBean.getUser_cd_2());
		strUserCd3 				= CommonUtil.isNull(jobMapperBean.getUser_cd_3());
		strUserCd4 				= CommonUtil.isNull(jobMapperBean.getUser_cd_4());
		strUserNm1 				= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getUser_nm_1()), "");
		strUserNm2 				= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getUser_nm_2()), "");
		strUserNm3 				= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getUser_nm_3()), "");
		strUserNm4 				= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getUser_nm_4()), "");
		strDescription 			= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getDescription()), "");
		strSms1 				= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getSms_1()), "");
		strSms2 				= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getSms_2()), "");
		strSms3 				= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getSms_3()), "");
		strSms4 				= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getSms_4()), "");
		strMail1 				= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getMail_1()), "");
		strMail2 				= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getMail_2()), "");
		strMail3 				= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getMail_3()), "");
		strMail4 				= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getMail_4()), "");
		strErrorDescription 	= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getError_description()), "");
		strLateSub 				= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getLate_sub()), "");
		strLateTime				= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getLate_time()), "");
		strLateExec 			= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getLate_exec()), "");
		
		strBatchJobGrade 		= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getBatchJobGrade()), "");
		strRefTable		 		= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getRef_table()), "");
		strCalendar_nm			= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getCalendar_nm()), "");
		
		strCalendar_nm			= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getCalendar_nm()), "");
		
		strCcYn					= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getCc_yn()), "");
		strCcCount				= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getCc_count()), "");
		strSuccessSmsYn			= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getSuccess_sms_yn()), "N");

		if(strUserNm2.equals("")){
			strSms2 	= "";
			strMail2 	= "";
		}
		
		if(strUserNm3.equals("")){
			strSms3 	= "";
			strMail3 	= "";
		}
		
		if(strUserNm4.equals("")){
			strSms4 	= "";
			strMail4 	= "";
		}
	}  
	
	// Argument가 동기화가 안될 수 있어서 CommandLine의 파라미터를 기준으로 셋팅해준다.
	//String strCommand = CommonUtil.replaceHtmlStr(CommonUtil.isNull(docBean.getCommand()));
	String strCommand = CommonUtil.replaceStrXml(CommonUtil.isNull(docBean.getCommand()));
	if(strCommand.length() > 3 && strCommand.substring(2, 3).equals("\\") && !strCommand.substring(3, 4).equals("\\")){
		strCommand = strCommand.replaceAll("\\\\", "\\\\\\\\");
	}

	String strSms1Ment = "";
	String strSms2Ment = "";
	String strSms3Ment = "";
	String strSms4Ment = "";
	String strMail1Ment = "";
	String strMail2Ment = "";
	String strMail3Ment = "";
	String strMail4Ment = "";
	String strCall1Ment = "";
	String strCall2Ment = "";
	String strCall3Ment = "";
	String strCall4Ment = "";
	String strMsg1Ment = "";
	String strMsg2Ment = "";
	String strMsg3Ment = "";
	String strMsg4Ment = "";
	
	if ( strSms1.equals("Y") && !strUserNm1.equals("") ) {
		strSms1Ment = "[SMS발송]";
	}
	
	if ( strSms2.equals("Y") && !strUserNm2.equals("") ) {
		strSms2Ment = "[SMS발송]";
	}
	
	if ( strSms3.equals("Y") && !strUserNm3.equals("") ) {
		strSms3Ment = "[SMS발송]";
	}
	
	if ( strSms4.equals("Y") && !strUserNm4.equals("") ) {
		strSms4Ment = "[SMS발송]";
	}
	if ( strMail1.equals("Y") && !strUserNm1.equals("") ) {
		strMail1Ment = "[메일발송]";
	}
	
	if ( strMail2.equals("Y") && !strUserNm2.equals("") ) {
		strMail2Ment = "[메일발송]";
	}
	
	if ( strMail3.equals("Y") && !strUserNm3.equals("") ) {
		strMail3Ment = "[메일발송]";
	}
	
	if ( strMail4.equals("Y") && !strUserNm4.equals("") ) {
		strMail4Ment = "[메일발송]";
	}
	if ( strCall1.equals("Y") && !strUserNm1.equals("") ) {
		strCall1Ment = "[AutoCall발송]";
	}
	
	if ( strCall2.equals("Y") && !strUserNm2.equals("") ) {
		strCall2Ment = "[AutoCall발송]";
	}
	
	if ( strCall3.equals("Y") && !strUserNm3.equals("") ) {
		strCall3Ment = "[AutoCall발송]";
	}
	
	if ( strCall4.equals("Y") && !strUserNm4.equals("") ) {
		strCall4Ment = "[AutoCall발송]";
	}
	if ( strMsg1.equals("Y") && !strUserNm1.equals("") ) {
		strMsg1Ment = "[메신져발송]";
	}
	
	if ( strMsg2.equals("Y") && !strUserNm2.equals("") ) {
		strMsg2Ment = "[메신져발송]";
	}
	
	if ( strMsg3.equals("Y") && !strUserNm3.equals("") ) {
		strMsg3Ment = "[메신져발송]";
	}
	
	if ( strMsg4.equals("Y") && !strUserNm4.equals("") ) {
		strMsg4Ment = "[메신져발송]";
	}
	
	String strRerunInterval 	= CommonUtil.E2K(docBean.getRerun_interval());
	String strCyclicType 		= CommonUtil.E2K(docBean.getCyclic_type());
	String strCountCyclicFrom 	= CommonUtil.E2K(docBean.getCount_cyclic_from());
	String strIntervalSequence 	= CommonUtil.E2K(docBean.getInterval_sequence());
	String strTolerance 		= CommonUtil.E2K(docBean.getTolerance());
	String strSpecificTimes 	= CommonUtil.E2K(docBean.getSpecific_times());
	
	String strMaxWait 			= CommonUtil.isNull(docBean.getMax_wait());
	
	String strCycleMent = "";
	if ( strCyclicType.equals("C") ) {
		strCycleMent = "반복주기 : " + strRerunInterval + " (분단위) ";
	} else if ( strCyclicType.equals("V") ) {
		strCycleMent = "반복주기(불규칙) : " + strIntervalSequence + " (분단위) ";
	} else if ( strCyclicType.equals("S") ) {
		strCycleMent = "시간지정 : " + strSpecificTimes + " (HHMM) ";
	}
	
	// 반복주기(불규칙)의 필요없는 문자 제거
	if ( !strIntervalSequence.equals("") ) {
		strIntervalSequence = strIntervalSequence.replaceAll("[+]", "").replaceAll("M", "");
	}
	
	// 세션값 가져오기.
	String strSessionUserId = S_USER_ID;
	String strSessionUserNm = S_USER_NM;

	String strServerGb 		= CommonUtil.isNull(CommonUtil.getMessage("SERVER_GB"));
	
	String fromTime = CommonUtil.isNull(docBean.getTime_from()); 
	String h_fromTime = "";
	String m_fromTime = "";
	String vh_fromTime = "";
	String vm_fromTime = "";
	if ( fromTime.length() == 4 ) {
		h_fromTime = fromTime.substring(0,2);
		m_fromTime = fromTime.substring(2,4);
		vh_fromTime = fromTime.substring(0,2);
		vm_fromTime = fromTime.substring(2,4);
		
	}else{
		h_fromTime = "--선택--";
		m_fromTime = "--선택--";
		vh_fromTime = "";
		vm_fromTime = "";
	}

	String timeUntil = CommonUtil.isNull(docBean.getTime_until());
	
	String h_timeUntil = "";
	String m_timeUntil = "";
	String vh_timeUntil = "";
	String vm_timeUntil = "";
	
	if ( timeUntil.length() == 4 ) {
		h_timeUntil = timeUntil.substring(0,2);
		m_timeUntil = timeUntil.substring(2,4);
		vh_timeUntil = timeUntil.substring(0,2);
		vm_timeUntil = timeUntil.substring(2,4);
		
	}else{
		h_timeUntil = "--선택--";
		m_timeUntil = "--선택--";
		vh_timeUntil = "";
		vm_timeUntil = "";
	}
	
	String h_lateSub = "";
	String m_lateSub = "";
	String vh_lateSub = "";
	String vm_lateSub = "";

	if ( strLateSub.length() == 4 ) {
		h_lateSub = strLateSub.substring(0,2);
		m_lateSub = strLateSub.substring(2,4);
		vh_lateSub = strLateSub.substring(0,2);
	    vm_lateSub = strLateSub.substring(2,4);
		
	}else{
		h_lateSub = "--선택--";
		m_lateSub = "--선택--";
		
		vh_lateSub = "";
	    vm_lateSub = "";
		
	}

	String h_lateTime = "";
	String m_lateTime = "";
	String vh_lateTime = "";
	String vm_lateTime = "";

	if ( strLateTime.length() == 4 ) {
		h_lateTime = strLateTime.substring(0,2);
		m_lateTime = strLateTime.substring(2,4);
		vh_lateTime = strLateTime.substring(0,2);
	    vm_lateTime = strLateTime.substring(2,4);
		
	}else{
		h_lateTime = "--선택--";
		m_lateTime = "--선택--";
		
		vh_lateTime = "";
	    vm_lateTime = "";
		
	}
	
	String strConfirmFlag 	= CommonUtil.isNull(docBean.getConfirm_flag());
	String strPriority 		= CommonUtil.isNull(docBean.getPriority());
	
	// 참조기안 시 Control-M에서 정보를 가져온다.
	String strDataCenter    = "";
	//if ( state_cd.equals("") && !flag.equals("ref") ) {
	if ( CommonUtil.E2K(docBean.getData_center()).indexOf(",") > -1 ) {
		strDataCenter = CommonUtil.E2K(docBean.getData_center());
	}else{
		strDataCenter = CommonUtil.isNull(appGrpBean.getScode_cd())+","+CommonUtil.E2K(docBean.getData_center());
		
	}
	
	// 의뢰자 정보
	String strInsUserNm = CommonUtil.isNull(docBean.getUser_nm());
	String strInsDeptNm = CommonUtil.isNull(docBean.getDept_nm());
	String strInsDutyNm = CommonUtil.isNull(docBean.getDuty_nm());
	
	String strUserInfo = "["+S_DEPT_NM+"] ["+S_DUTY_NM+"] "+S_USER_NM;
	if ( !strInsUserNm.equals("") ) {
		strUserInfo = "["+strInsDeptNm+"] ["+strInsDutyNm+"] "+strInsUserNm;
	}
	
	Map<String,String> mStepHid = new HashMap<String,String>();
	mStepHid.put("statement","<input type='hidden' name='m_step_statement_stmt' /><input type='hidden' name='m_step_statement_code' />");
	mStepHid.put("set-var","<input type='hidden' name='m_step_set-var_name'  /><input type='hidden' name='m_step_set-var_value' />");
	mStepHid.put("shout","<input type='hidden' name='m_step_shout_to' /><input type='hidden' name='m_step_shout_urgn' /><input type='hidden' name='m_step_shout_msg' />");
	mStepHid.put("force-job","<input type='hidden' name='m_step_force-job_table' /><input type='hidden' name='m_step_force-job_job_name' /><input type='hidden' name='m_step_force-job_date' /><input type='hidden' name='img_step_force-job_date' />");
	mStepHid.put("sysout","<input type='hidden' name='m_step_sysout_option' /><input type='hidden' name='m_step_sysout_parm' />");
	mStepHid.put("condition","<input type='hidden' name='m_step_condition_name' /><input type='hidden' name='m_step_condition_date' /><input type='hidden' name='img_step_condition_date' /><input type='hidden' name='m_step_condition_sign' />");
	mStepHid.put("mail","<input type='hidden' name='m_step_mail_to' /><input type='hidden' name='m_step_mail_cc' /><input type='hidden' name='m_step_mail_subject' /><input type='hidden' name='m_step_mail_urgn' /><input type='hidden' name='m_step_mail_msg' />");

	String strDefaultMaxWait	= "";
	if ( strServerGb.equals("P") ) {
		strDefaultMaxWait = "1";
	} else {
		strDefaultMaxWait = "3";
	}
	
	String strScodeNm 			= "";
%>

<body id='body_A01' leftmargin="0" topmargin="0">

<div style="width:100%; height:100%; overflow-x:hidden; overflow-y:scroll;">
<form id="f_s" name="f_s" method="post" onsubmit="return false;">	
	<input type="hidden" name="p_data_center" id="p_data_center" />
	<input type="hidden" name="p_application" id="p_application" />
	<input type="hidden" name="p_group_name_of_def" id="p_group_name_of_def" />
	<input type="hidden" name="p_search_gubun" id="p_search_gubun" />
	<input type="hidden" name="p_search_text" id="p_search_text" />
	
	<input type="hidden" name="p_scode_cd" id="p_scode_cd" />
	<input type="hidden" name="p_grp_depth" id="p_grp_depth" />
	<input type="hidden" name="p_app_nm" id="p_app_nm" />
	<input type="hidden" name="p_app_search_gubun" id="p_app_search_gubun" />
</form>
<form id="userFrm" name="userFrm" method="post" onsubmit="return false;">	
</form>
<form name="frm_down" id="frm_down" method="post" onsubmit="return false;">
	<input type="hidden" name="flag" 			id="flag"/>
	<input type="hidden" name="file_gb" 		id="file_gb" />
	<input type="hidden" name="data_center" 	id="data_center" value="<%=strDataCenter %>"/>
	<input type="hidden" name="job_nm" 			id="job_nm" />
	<input type="hidden" name="doc_cd" 			id="doc_cd" />
</form>
<form id="frm1" name="frm1" method="post" onsubmit="return false;" enctype="multipart/form-data" >

	<input type="hidden" name="flag" 				id="flag"/>
	<input type="hidden" name="is_valid_flag" 		id="is_valid_flag" />
	
	<input type="hidden" name="t_general_date" 		id="t_general_date" />
	<input type="hidden" name="t_conditions_in" 	id="t_conditions_in" />
	<input type="hidden" name="t_conditions_out" 	id="t_conditions_out" />
	<input type="hidden" name="t_resources_q" 		id="t_resources_q" />
	<input type="hidden" name="t_resources_c" 		id="t_resources_c" />
	<input type="hidden" name="t_set" 				id="t_set" />
	<input type="hidden" name="t_steps" 			id="t_steps" />
	<input type="hidden" name="t_postproc" 			id="t_postproc" />
	<input type="hidden" name="t_tag_name" 			id="t_tag_name"/>
	<input type="hidden" name="month_1" 			id="month_1"/>
	<input type="hidden" name="month_2" 			id="month_2"/>
	<input type="hidden" name="month_3" 			id="month_3"/>
	<input type="hidden" name="month_4" 			id="month_4"/>
	<input type="hidden" name="month_5" 			id="month_5"/>
	<input type="hidden" name="month_6" 			id="month_6"/>
	<input type="hidden" name="month_7" 			id="month_7"/>
	<input type="hidden" name="month_8" 			id="month_8"/>
	<input type="hidden" name="month_9" 			id="month_9"/>
	<input type="hidden" name="month_10" 			id="month_10"/>
	<input type="hidden" name="month_11" 			id="month_11"/>
	<input type="hidden" name="month_12" 			id="month_12"/>
	
	<input type='hidden' id='p_apply_date' 	name='p_apply_date'/>
	<input type='hidden' id='apply_cd' 		name='apply_cd'/>
	
	<input type="hidden" name="doc_gb" 	id="doc_gb" value="" />	
	<input type="hidden" name="retro" 	id="retro"	value="0" />
	
	<!-- Cyclic 작업 셋팅 파라미터. -->
	<input type="hidden" name="rerun_interval" 		id="rerun_interval"			value="<%=strRerunInterval%>" />
	<input type="hidden" name="rerun_interval_time" id="rerun_interval_time"	value="M" />
	<input type="hidden" name="cyclic_type" 		id="cyclic_type" 			value="<%=strCyclicType%>" />
	<input type="hidden" name="count_cyclic_from" 	id="count_cyclic_from" 		value="<%=strCountCyclicFrom%>" />
	<input type="hidden" name="interval_sequence" 	id="interval_sequence" 		value="<%=strIntervalSequence%>" />
	<input type="hidden" name="tolerance" 			id="tolerance" 				value="<%=strTolerance%>" />
	<input type="hidden" name="specific_times" 		id="specific_times" 		value="<%=strSpecificTimes%>" />
	<input type="hidden" name="max_wait" 			id="max_wait"				value="<%=strMaxWait%>" />
	
	<input type="hidden" name="user_cd" id="user_cd"/>	
	
	<input type="hidden" name="host_cd" id="host_cd" />
	<input type="hidden" name="doc_cd" 	id="doc_cd" value="<%=doc_cd%>"/>
	
	<!-- 인터페이스 체크 결과 -->
	<input type="hidden" name="if_return" id="if_return"/>
	
	<!-- 스마트테이블 체크 결과 -->
	<input type="hidden" name="smart_cnt" 			id="smart_cnt"/>
	
	<!-- 선행 검색 시 data_center 비교 위해 필요 -->
	<input type="hidden" name="doc_data_center" id="doc_data_center"/>
	
	<!-- 목록 화면 검색 파라미터 -->
	<input type="hidden" name="search_data_center"		id="search_data_center" 	value="<%=search_data_center%>" />
	<input type="hidden" name="search_state_cd"			id="search_state_cd" 		value="<%=search_state_cd%>" />
	<input type="hidden" name="search_approval_cd"		id="search_approval_cd" 	value="<%=search_approval_cd%>" />
	<input type="hidden" name="search_gb"				id="search_gb" 				value="<%=search_gb%>" />
	<input type="hidden" name="search_text"				id="search_text" 			value="<%=search_text%>" />
	<input type="hidden" name="search_date_gubun"		id="search_date_gubun" 		value="<%=search_date_gubun%>" />
	<input type="hidden" name="search_s_search_date"	id="search_s_search_date" 	value="<%=search_s_search_date%>" />
	<input type="hidden" name="search_e_search_date"	id="search_e_search_date" 	value="<%=search_e_search_date%>" />
	<input type="hidden" name="search_task_nm"			id="search_task_nm" 		value="<%=search_task_nm%>" />
	<input type="hidden" name="search_moneybatchjob"	id="search_moneybatchjob" 	value="<%=search_moneybatchjob%>" />
	<input type="hidden" name="search_critical"			id="search_critical" 		value="<%=search_critical%>" />
<table style='width:99%;height:99%;border:none;'>
	<tr style='height:10px;'>
		<td style='vertical-align:top;'>
			<h4 class="ui-widget-header ui-corner-all"  >
				<div id='t_<%=gridId %>' class='title_area'>
					<span><%=CommonUtil.getMessage("CATEGORY.GB.03.SB.0301") %></span>
				</div>
			</h4>
		</td>
	</tr>
	<tr>
		<td id='ly_<%=gridId %>' style='vertical-align:top;'>			
			<div id="<%=gridId %>" class="ui-widget-header_kang ui-corner-all">
				<input type="hidden" name="title" id="title" value="스마트폴더수정"/>
				<input type="hidden" name="description" id="description" value="" />
				<table style="width:100%">
					<tr>
						<td>
							<div class='cellTitle_kang'>작업 정보 [문서정보 : <%=doc_cd %>]</div>
						</td>	
					</tr>
					<tr>
						<td valign="top">
							<table style="width:100%;">
								<tr>
									<td width="120px"></td>
									<td width="250px"></td>
									<td width="120px"></td>
									<td width="200px"></td>
									<td width="120px"></td>
									<td width=""></td>
								</tr>
								<tr>
									<td>                
										<div class='cellTitle_kang2'><font color="red">* </font>C-M</div>
									</td>									
									<td> 										
										<div class='cellContent_kang'>
											<select style="display:none;" name="data_center_items" id="data_center_items" style="width:70%;height:21px;">
												<option value="">--선택--</option>
												<option selected value="<%=strDataCenter %>"><%=CommonUtil.E2K(docBean.getData_center()) %></option>
											</select>
											<%=CommonUtil.E2K(docBean.getData_center_name()) %>
											<input type="hidden" name="data_center" id="data_center" value="<%=strDataCenter %>" style="width:70%;height:21px;"/>
											<input type="hidden" name="data_center2" id="data_center2" value="<%=strDataCenter %>" style="width:70%;height:21px;"/>
										</div>										
									</td>
									
									<td>
										<div class='cellTitle_kang2'><font color="red">* </font>시스템구분</div>  
									</td>
									<td>  
										<div class='cellContent_kang'>
											<select id="sSystemGb" name="sSystemGb" style="width:70%;height:21px;">																				
												<option value="">--선택--</option>
												<%
													for ( int i = 0; i < systemGbList.size(); i++ ) {
													CommonBean bean = (CommonBean)systemGbList.get(i);
													 
												%>											
													<option value="<%=CommonUtil.E2K(bean.getScode_eng_nm())%>"><%=bean.getScode_nm()%></option>
												<%
													}
												%>
											</select>
											<input type="hidden" name="systemGb" id="systemGb" value="<%=systemGb %>"/>
										</div>	
									</td>
										<td>
										<div class='cellTitle_kang2'><font color="red">* </font>작업유형구분</div>
									</td>  
									<td>
										<div class='cellContent_kang'>
											<select id="sJobTypeGb" name="sJobTypeGb" style="width:70%;height:21px;">																				
												<option value="">--선택--</option>
												<%
													for ( int i = 0; i < jobTypeGbList.size(); i++ ) {
													CommonBean bean = (CommonBean)jobTypeGbList.get(i);
													 
												%>											
													<option value="<%=CommonUtil.E2K(bean.getScode_eng_nm())%>"><%=bean.getScode_nm()%></option>
												<%
													}
												%>
											</select>
											
											<input type="hidden" name="jobTypeGb" id="jobTypeGb" value="<%=jobTypeGb %>"/>
										</div>
									</td>
											
								</tr>	
								
								<tr>
									<td>  
										<div class='cellTitle_kang2'><font color="red">* </font>테이블</div>
									</td> 
									<td>
										<div class='cellContent_kang'>
											<%=CommonUtil.isNull(docBean.getTable_name()) %>
											<input type="hidden" name="table_name" id="table_name" value="<%=CommonUtil.isNull(docBean.getTable_name()) %>"/>
											<input type='hidden' id='application' name='application' value='' />
											<input type='hidden' id='group_name' name='group_name' value='' />
										</div> 
									</td>
									<%-- <td>
										<div class='cellTitle_kang2'><font color="red">* </font>어플리케이션</div>
									</td>
									<td>
										<div class='cellContent_kang'>
									 		<select name="application_of_def" id="application_of_def" style="width:70%;height:21px;">
												<option value="">--선택--</option>
											</select>
											<input type='hidden' id='application' name='application' value="<%=CommonUtil.isNull(docBean.getApplication()) %>" />
										</div>
									</td>
									<td>
										<div class='cellTitle_kang2'><font color="red">* </font>그룹</div>
									</td>
									<td> 
										<div class='cellContent_kang'>
									 		<select name="group_name_of_def" id="group_name_of_def" style="width:70%;height:21px;">
												<option value="">--선택--</option>
											</select>
											<input type='hidden' id='group_name' name='group_name' value="<%=CommonUtil.isNull(docBean.getGroup_name()) %>" />
										</div>
									</td> --%>
									<td>
										<div class='cellTitle_kang2'><font color="red"></font>user_daily</div>  
									</td>
									<td>
										<div class='cellContent_kang'>
											<input type="text" name="user_daily" id="user_daily" value="<%=CommonUtil.isNull(docBean.getUser_daily()) %>" style="width:70%;height:21px;"/>
										</div>
									</td>
									<td>
										<div class='cellTitle_kang2'><font color="red">* </font>수행서버</div>
									</td>
									<td> 
										<div class='cellContent_kang'>
											<select name="host_id" id="host_id" style="width:70%;height:21px;">
												<option value="">--선택--</option>
											</select>
											<input type="hidden" name="node_id" id="node_id" value="<%=CommonUtil.E2K(docBean.getNode_id()) %>"/>
										</div>
									</td>
								</tr>
								<tr>
									<td>
										<div class='cellTitle_kang2'><font color="red">* </font>작업명</div>
									</td>
									<td>
										<div class='cellContent_kang'>
										<%=strJobName%>
										<input type="hidden" id="job_nameChk" name="job_nameChk" value="0"/>
										<input type="hidden" id="job_name" name="job_name" value="<%=strJobName %>" />
										</div>
									</td>
									
									<td>								
										<div class='cellTitle_kang2'><font color="red">* </font>계정명</div>
									</td>
									<td> 
										<div class='cellContent_kang'>
											<select name="owner" id="owner" style="width:80%;height:21px;">
												<option value="">--선택--</option>
											</select>
										</div>
										<input type=hidden name="v_owner" id="v_owner" value= "<%=CommonUtil.E2K(docBean.getOwner()) %>"/>
									</td>
									
									<td>   
										<div class='cellTitle_kang2'>작업타입</div>
									</td>
									<td>
										<div class='cellContent_kang'>
											<input type="text" name="task_type" id="task_type" value= "<%=CommonUtil.E2K(docBean.getTask_type()) %>"  style= "width:98%;height:21px;" readOnly/>			
										</div>
									</td>
								</tr>
								
								<tr>
									<td>
										<div class='cellTitle_kang2'><font color="red">* </font>프로그램 위치</div>
									</td>
									
									<td colspan="3">
										<div class='cellContent_kang'>
											<input type="text" name="mem_lib" id="mem_lib" value= "<%=strMemLib %>"  style= "width:98%;height:21px;ime-mode:disabled;" onkeyup="noSpaceBar(this)"/>
										</div>
									</td>	
									
									<td>
										<div class='cellTitle_kang2'><font color="red">* </font>프로그램 명</div>
									</td>
									<td>
										<div class='cellContent_kang'>
											<input type="text" name="mem_name" id="mem_name" value= "<%=CommonUtil.E2K(docBean.getMem_name()) %>"  style= "width:98%;height:21px;ime-mode:disabled;" onkeyup="noSpaceBar(this)"/>
										</div>
									</td>
								</tr>	
								<tr>
									<td colspan="6">									
										<div id='ctmfw' style="display:none">																	
											<table style="width:100%">
												<tr>
													<td>
														<div class='cellTitle_kang2'>모니터링 시간</div>
													</td>										
													
													<td>
														<div class='cellContent_kang'>
															<input type="text" id="monitor_time" name="monitor_time" value="<%=strMonitor_time %>" style="height:21px;"> 분
														</div>
													</td>
													<td>
														<div class='cellTitle_kang2'>모니터링 주기</div>
													</td>	
													 
													<td>
														<div class='cellContent_kang'>
															<input type="text" id="monitor_interval" name="monitor_interval" value="<%=strMonitor_interval %>" style="height:21px;"> 초
														</div>
													</td>		
													<td>
														<div class='cellTitle_kang2'>파일증감 체크주기</div>
													</td>	
													 
													<td>
														<div class='cellContent_kang'>
															<input type="text" id="filesize_comparison" name="filesize_comparison" value="<%=strFilesize_comparison%>" style="height:21px;width:50px;"> 
														</div>
													</td>
													<td>
														<div class='cellTitle_kang2'>파일멈춤 체크횟수</div>
													</td>	
													 
													<td>
														<div class='cellContent_kang'>
															<input type="text" id="num_of_iterations" name="num_of_iterations" value="<%=strNum_of_iterations%>" style="height:21px;width:50px;"> 회
														</div>
													</td>
													<td>
														<div class='cellTitle_kang2'>모니터링 종료시간</div>
													</td>	
													 
													<td>
														<div class='cellContent_kang'>
															<input type="text" id="stop_time" name="stop_time" value="<%=strStop_time%>" style="height:21px;width:50px;"> 
														</div>
													</td>											
												</tr>
											</table>
										</div>
									</td>
								</tr>
															
								<tr>  
									<td>
										<div class='cellTitle_kang2'>작업수행명령</div>
									</td>
									
									<td colspan="5">
										<div class='cellContent_kang'>
											<input type="text" name="command" id="command" value="<%=strCommand%>"  style="width:98%;height:21px;background-color:#EBEBE4;" readOnly />													
										</div>
									</td>
									
								</tr>   
							</table>
						</td>
					</tr>
				</table>
				<table style="width:100%;">
 					<tr>
						<td colspan="6"> 
							<table style="width:100%;">
  								<tr>
									<td colspan = "4">
										<div class='cellTitle_kang2'>사용자변수</div>
									</td>
									<td style="width:120px;">
										<div class='cellTitle_kang'>
											<span id='btn_addUserVar' style='vertical-align:right;'>추가</span>
										</div>
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td style='width:120px;'><div class='cellTitle_kang2'>순번</div></td>
						<td style='width:400px;'><div class='cellTitle_kang2'>Var Name</div></td>
						<td style='width:%;'><div class='cellTitle_kang2'>Value</div></td>
						<td style='width:120px;'><div class='cellTitle_kang2'>삭제란</div></td>
					</tr>
				</table>
				
				<table style="width:100%;height:100%;border:none;" id="userVar"> 
				<%
				if( null!=docBean.getT_set() && docBean.getT_set().trim().length()>0 ){
					aTmpT = CommonUtil.E2K(docBean.getT_set()).split("[|]");
					for(int t=0; null!=aTmpT&&t<aTmpT.length; t++ ){
						String[] aTmpT1 = aTmpT[t].split(",",2);
						if ( aTmpT1[0].equals("LIBMEMSYM")) {
							continue;
						}
						
						// FileWatch 셋팅
						if ( aTmpT1[0].indexOf("FileWatch-INT_FILE_SEARCHES") > -1 ) {
							strMonitor_interval = aTmpT1[1];
						}
						if ( aTmpT1[0].indexOf("FileWatch-TIME_LIMIT") > -1 ) {
							strMonitor_time = aTmpT1[1];
						}
						if ( aTmpT1[0].indexOf("FileWatch-INT_FILESIZE_COMPARISON") > -1 ) {
							strFilesize_comparison = aTmpT1[1];
						}
						if ( aTmpT1[0].indexOf("FileWatch-NUM_OF_ITERATIONS") > -1 ) {
							strNum_of_iterations = aTmpT1[1];
						}
						if ( aTmpT1[0].indexOf("FileWatch-STOP_TIME") > -1 ) {
							strStop_time = aTmpT1[1];
						}
						
						if( aTmpT1[0].indexOf("FileWatch") > -1  ) {
							continue;
						}
				%>
					<tr>
						<td style='width:120px;height:21px;'><div class='cellTitle_kang2' id='div_user_val"+idx+"'>사용자변수<%=(t + 1)%></div></td>
						<td style='width:400px;'><input type='text' class='input' name='m_var_name' value='<%=aTmpT1[0] %>' style='width:98%;height:21px;' maxlength='40'/></td>
						<td ><input type='text' class='input' name='m_var_value' value='<%=aTmpT1[1] %>' style='width:98%;height:21px;' maxlength='214'/></td>
						<td class='td2_1' width='120px'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<input type='button' name='del_set_button' value=' - ' onClick="delUserVars( getObjIdx(this, this.name))" class="btn_white_h24">
						</td>
					</tr>
				<%
					}
				}
				%>
				</table>
				
				<table style="width:100%">
					<tr>
						<td>
							<div class='cellTitle_kang'>스케쥴 정보</div>
						</td>	
					</tr>
					<tr>
						<td valign="top">
								<table style="width:100%;">
									<tr>
										<td width="120px"></td>
										<td width="250px"></td>
										<td width="120px"></td>
										<td width="200px"></td>
										<td width="120px"></td>
										<td width=""></td>
									</tr>
									<tr>
										<tr>
											<td>
												<div class='cellTitle_kang2'><font id="cal_nm_ondemand" color="red">* </font>작업주기/시기</div>
											</td>
										<td colspan="2">
											<div class='cellContent_kang'>
												<input type="text" id="cal_nm" name="cal_nm" value="<%=strCalendar_nm%>" style="width:98%; height:21px;" readonly="readonly" required="true"   title="작업주기/시기"/>																																														
												<input type="hidden" name="month_cal" id="month_cal" />
												<input type="hidden" id="tab_yn" name="tab_yn" value="0"/>
											</div>
										</td>
										
										<td colspan = "2">
											<div class='cellContent_kang'>
												<span id='btn_sched'>추가</span>
												<span id='btn_schedDel'>삭제</span>
												<span id='btn_CalDetail'>미리보기</span>
												<span id='btn_schedInfo'>스케쥴상세</span>											
											</div>									
										</td>
									</tr>  
								</table>
							
								<table style="width:100%;">
									<tr>
										<td width="120px"></td>
										<td width="250px"></td>
										<td width="120px"></td>
										<td width="200px"></td>
										<td width="120px"></td>
										<td width=""></td>
									</tr>
									<tr> 
										<td>
											<div class='cellTitle_kang2'><font id="from_tiem_ondemand" color="red"></font>작업시작시간</div>
										</td> 								
										<td>
											<div class='cellContent_kang'>
																						
												<select id='sHour' name='sHour' style="width:40%;height:21px;">													
											   		<option value="">--선택--</option>
											   		<c:forEach var="sHour" begin="0" end="23" step="1">
											   			<c:choose>
											   				<c:when test="${sHour < 10}"><option value="0${sHour}">0${sHour}</option></c:when>
											        		<c:otherwise><option value="${sHour}">${sHour}</option></c:otherwise>
											        	</c:choose>
				  								   	</c:forEach>
												</select>
												<select id='sMin' name = 'sMin' style="width:40%;height:21px;">													
												    <option value="">--선택--</option>
												   <c:forEach var="sMin" begin="0" end="59" step="1">    
												    <c:choose>
												     <c:when test="${sMin < 10}">
												     <option value="0${sMin}">0${sMin}</option></c:when>
												     <c:otherwise><option value="${sMin}">${sMin}</option></c:otherwise>
												    </c:choose>    
												   </c:forEach>
												</select>	
																						
											</div>
											
											<input type="hidden" name="time_group" id="time_group" value="<%=vh_fromTime%>" />
											<input type="hidden" name="time_from" id="time_from" value="<%=fromTime %>" />
											
										</td>
										<td>
											<div class='cellTitle_kang2'>작업종료시간</div>	
										</td> 								
										<td>
											<div class='cellContent_kang'>
												
												<select id='eHour' name='eHour' style="width:40%;height:21px;">													
											   			 <option value="">--선택--</option>
											   			<c:forEach var="eHour" begin="0" end="23" step="1">    
											   			<c:choose>
											    		<c:when test="${eHour < 10}">
											     	<option value="0${eHour}">0${eHour}</option></c:when>
											        <c:otherwise><option value="${eHour}">${eHour}</option></c:otherwise>
											        </c:choose>    
				  								   </c:forEach>
												</select>
												<select id='eMin' name = 'eMin' style="width:40%;height:21px;">													
												    <option value="">--선택--</option>
												   <c:forEach var="eMin" begin="0" end="59" step="1">    
												    <c:choose>
												     <c:when test="${eMin < 10}">
												     <option value="0${eMin}">0${eMin}</option></c:when>
												     <c:otherwise><option value="${eMin}">${eMin}</option></c:otherwise>
												    </c:choose>    
												   </c:forEach>
												</select>	
											</div>
											
											<input type="hidden" name="time_until" id="time_until" value="<%=timeUntil %>" />
										</td>
									</tr>    
									
									<tr>
							        	<td>
											<div class='cellTitle_kang2'>시작임계시간</div>	
										</td>  
							        	<td>
							        	
							        		<div class='cellContent_kang'>
							        									        		
							        		<select name='slate_sub_h' id='slate_sub_h' style="width:40%;height:21px;">
												 <option value="">--선택--</option>
										  		 <c:forEach var="slate_sub_h" begin="0" end="23" step="1">    
										   		 	<c:choose>
											  	     <c:when test="${slate_sub_h < 10}">
											  	    	 <option value="0${slate_sub_h}">0${slate_sub_h}</option></c:when>
											  		 <c:otherwise><option value="${slate_sub_h}">${slate_sub_h}</option></c:otherwise>
										 	     	</c:choose>    
										 	     </c:forEach>
											  </select>
											 
					        	    		<select name='slate_sub_m' id='slate_sub_m' style="width:40%;height:21px;">
												 <option value="">--선택--</option>
										  		 <c:forEach var="slate_sub_m" begin="0" end="59" step="1">    
											   		 <c:choose>
												  	     <c:when test="${slate_sub_m < 10}">
												  	     	<option value="0${slate_sub_m}">0${slate_sub_m}</option></c:when>
												  		 <c:otherwise><option value="${slate_sub_m}">${slate_sub_m}</option></c:otherwise>
											 	     </c:choose>    
										 	     </c:forEach>
											  </select>
							        			<input type="hidden" name="late_sub_h" id="late_sub_h" value= "<%=vh_lateSub %>" maxlength="2" style= "width:20%;height:21px;"/>
												<input type="hidden" name="late_sub_m" id="late_sub_m" value= "<%=vm_lateSub %>" maxlength="2" style= "width:20%;height:21px;"/>
												<input type="hidden" name="late_sub" id="late_sub" value= "<%=strLateSub %>" maxlength="4" style= "width:20%;height:21px;"/>
											</div>
										</td>
							        	<td>
											<div class='cellTitle_kang2'>종료임계시간</div>	
										</td>  
							        	<td>
							        									        
							        		<div class='cellContent_kang'>
							        		
							        			<select name='slate_time_h' id='slate_time_h' style="width:40%;height:21px;">													
											  		  <option value="">--선택--</option>
											  		 <c:forEach var="slate_time_h" begin="0" end="23" step="1">    
												   		 <c:choose>
													  	     <c:when test="${slate_time_h < 10}">
													  	     	<option value="0${slate_time_h}">0${slate_time_h}</option></c:when>
													  		 <c:otherwise><option value="${slate_time_h}">${slate_time_h}</option></c:otherwise>
												 	     </c:choose>    
											 	     </c:forEach>
											  </select>
					        	    			<select name='slate_time_m' id='slate_time_m' style="width:40%;height:21px;">													
											  		  <option value="">--선택--</option>
											  		 <c:forEach var="slate_time_m" begin="0" end="59" step="1">    
												   		 <c:choose>
													  	     <c:when test="${slate_time_m < 10}">
													  	     	<option value="0${slate_time_m}">0${slate_time_m}</option></c:when>
													  		 <c:otherwise><option value="${slate_time_m}">${slate_time_m}</option></c:otherwise>
												 	     </c:choose>    
											 	     </c:forEach>
											  	</select>
							        			<input type="hidden" name="late_time_h" id="late_time_h" value= "<%=vh_lateTime %>"  maxlength="2" style= "width:20%;height:21px;"/>
												<input type="hidden" name="late_time_m" id="late_time_m" value= "<%=vm_lateTime %>"   maxlength="2" style= "width:20%;height:21px;"/>
							        			<input type="hidden" name="late_time" id="late_time" value= "<%=strLateTime %>"   maxlength="4" style= "width:20%;height:21px;"/>
											</div>
										</td>
							        	<td>
											<div class='cellTitle_kang2'>수행임계시간</div>	
										</td>  
							        	<td>
							        		<div class='cellContent_kang'>
							        			<input type="text" name="late_exec" id="late_exec" value= "<%=strLateExec.replaceAll(">", "") %>"  maxlength="3" style= "width:20%;height:21px;"/>분
											</div>
										</td>
						        	</tr>
			        				<tr>
			        					<td>
									 		<div class='cellTitle_kang2'>반복작업</div>
							        	</td>
							        	<td colspan="3">
							        		<div class='cellContent_kang'>
							        			
												<select id='cyclic' name='cyclic' style="height:21px;" onChange='fn_cyclic_set(this.value);'>
												<%
													aTmp = CommonUtil.getMessage("JOB.CYCLIC").split(",");
													String[] arr_nm = {"N","Y"};
													
													for(int i=0;i<aTmp.length; i++){
														String[] aTmp1 = aTmp[i].split("[|]");
														String select = aTmp1[0].equals(docBean.getCyclic()) ? "selected" : "";
														String nm = arr_nm[i];	
														out.println("<option value='"+aTmp1[0]+"' "+select+" >"+nm+"</option>");
													}												
												%>
												</select>&nbsp;&nbsp;
													
												<span id='cyclic_ment'>
												<%
													if ( CommonUtil.getMessage("JOB.CYCLIC."+docBean.getCyclic()).equals("yes") ) {											
														out.println(strCycleMent);
													}
												%>	
												</span>												
												<span id='btn_cyclic'>반복옵션</span>	
											</div>												
										</td>
									
										<td>
									 		<div class='cellTitle_kang2'>최대 반복 횟수</div>
							        	</td>								
										<td>
											<div class='cellContent_kang'>
												<input type='text' class='input' id='rerun_max' name='rerun_max' value="<%=CommonUtil.E2K(docBean.getRerun_max()) %>" size='4' maxlength='2' onkeypress='if(event.keyCode==32 || event.keyCode==39) event.returnValue = false;' style='width:98%;height:21px;ime-mode:disabled;' readOnly />
											</div>
										</td>																		
			        				</tr>
			        				
			        				<tr>
			        					<td>
									 		<div class='cellTitle_kang2'>Confirm Flag</div>
							        	</td>
							        	<td colspan="3">
							        		<div class='cellContent_kang'>
												<select id='confirm_flag' name='confirm_flag' style="height:21px;">
													<option value="0">N</option>
										        	<option value="1">Y</option>
										        </select>
											</div>
										</td>
										<td>
									 		<div class='cellTitle_kang2'>우선순위</div>
							        	</td>
										<td>
											<div class='cellContent_kang'>
												<input type='text' class='input' id='priority' name='priority' value="<%=strPriority %>" size='4' maxlength='2' onkeypress='if(event.keyCode==32 || event.keyCode==39) event.returnValue = false;' style='width:20%;height:21px;ime-mode:disabled;' />
											</div>
										</td>
			        				</tr>
			        				<tr>
			        					<td>
									 		<div class='cellTitle_kang2'>성공 시 알람 발송</div>
							        	</td>
							        	<td colspan="3">
							        		<div class='cellContent_kang'>
												<select id='success_sms_yn' name='success_sms_yn' style="height:21px;">
													<option value="N">N</option>
										        	<option value="Y">Y</option>
										        </select>
											</div>
										</td>
										
										<td>
							           		<div class='cellTitle_kang2'>Global 컨디션</div>
										</td>
		                    			<td colspan="3">
		                    				<div class='cellContent_kang'>
												<select id='globalCond_yn' name='globalCond_yn' style="height:21px;">
													<option value="0">N</option>
										        	<option value="1">Y</option>
												</select>&nbsp;&nbsp;
												<font color="red">※ 후속작업이 다른 C-M 작업일 경우 Y 설정</font>&nbsp;<span id='global_cond'></span>
												<input type="hidden" name="globalCond" id="globalCond" value= "<%= strGlobalCond_yn %>"  maxlength="1" style="width:98%;height:21px;"/>
											</div>	                    				
										</td>													
			        				</tr>
			        				
								</table>
							</td>
						</tr>
					</table>
						
							
					<table style="width:100%">
						<tr>
							<td style="width:50%;">
								<table style="width:100%;">
									<tr>								  
										<td style="width:76%;height:21px;">
											<div class='cellTitle_kang2'>선행작업조건</div>
										</td> 
										<td style="width:12%;height:21px;">
											<div class='cellTitle_kang2'>
												<span id='btn_addConditionsIn'style='vertical-align:right;'>추가</span></th>
											</div>
										</td>
										<td style="width:12%;height:21px;">
											<div class='cellTitle_kang2'>
												<span id='btn_delConditionsIn' style='vertical-align:right;'>삭제</span></th>
											</div>
										</td>
									</tr>   
								</table> 
								<table style="width:100%;height:100%;border:none;"> 
								
									<tr>					
										<td id='ly_<%=gridId_1 %>' style='vertical-align:top;height:150px;'>
											<div id="<%=gridId_1 %>" class="ui-widget-header ui-corner-all"></div>
										</td>					
									</tr>
								</table>					
							</td>
							
							<td style="width:50%;">
								<table style="width:100%;">
									<tr>								
										<td style="width:76%;height:21px;">
											<div class='cellTitle_kang2'><font color="red">* </font>후행작업조건 (자기작업 CONDITION)</div>
										</td> 
										<td style="width:12%;height:21px;">
											<div class='cellTitle_kang2'>
												<span id='btn_addConditionsOut'style='vertical-align:right;'>추가</span></th>
											</div>
										</td>
										<td style="width:12%;height:21px;">
											<div class='cellTitle_kang'>
												<span id='btn_delConditionsOut' style='vertical-align:right;'>삭제</span></th>
											</div>
										</td>
									</tr>
								</table> 
								<table style="width:100%;height:100%;border:none;">
									<tr>					
										<td id='ly_<%=gridId_2 %>' style='vertical-align:top;height:150px;'>
											<div id="<%=gridId_2%>" class="ui-widget-header ui-corner-all"></div>
										</td>					
									</tr>											
								</table>
							</td>
						</tr>
					</table>
					<table style="width:100%">
					<tr>
						<td>
							<div class='cellTitle_kang'>부가 정보</div>
						</td>

					</tr>
					<tr>
						<td valign="top">
						
								<input type='hidden' id='user_cd_1_0' name='user_cd_1_0' value='<%=strUserCd1%>' />
								<input type='hidden' id='user_cd_2_0' name='user_cd_2_0' value='<%=strUserCd2%>' />
								<input type='hidden' id='user_cd_3_0' name='user_cd_3_0' value='<%=strUserCd3%>' />
								<input type='hidden' id='user_cd_4_0' name='user_cd_4_0' value='<%=strUserCd4%>' />
								
							<table style="width:100%;">		
								<tr>
									<td width="120px"></td>
									<td width="120px"></td>
									<td width="180px"></td>
									<td width="120px"></td>
									<td width="120px"></td>
									<td width="120px"></td>
									<td width="180px"></td>
									<td width="120px"></td>
								</tr>											
								<tr>
									<td>
										<div class='cellTitle_kang2'><font color="red">* </font>담당자</div>
									</td>
									
									<td>
										<div class='cellContent_kang'>
											<input class='input' type='text' id='user_nm_1_0' value= "<%=strUserNm1 %>" style='width:90%;height:21px;' readOnly />
											<input class='input' type='hidden' id='author' name='author' value='<%=S_USER_ID %>'/>
										</div>
									</td>
									<td>
										<div class='cellContent_kang'>
											SMS<input type='checkbox' name='sms_1_0' id='sms_1_0' value='Y' />
											MAIL<input type='checkbox' name='mail_1_0' id='mail_1_0' value='Y' />
											<!-- 메신저<input type='checkbox' name='msg_1_0' id='msg_1_0' value="Y"/> -->
										</div>
									</td>
									<td>
										<div class='cellContent_kang'>
											<span id='btn_search1'>검색</span>
											<!-- <span id='btn_del1'>삭제</span> -->
										</div>
									</td>
								   
									<td>
										<div class='cellTitle_kang2'>담당자2</div>
									</td>
									<td>
										<div class='cellContent_kang'>
											<input class='input' type='text' id='user_nm_2_0' value= "<%=strUserNm2 %>" style='width:90%;height:21px;' readOnly />
										</div>
									</td>
									<td>
										<div class='cellContent_kang'>
											SMS<input type='checkbox' name='sms_2_0' id='sms_2_0' value='Y'/>
											MAIL<input type='checkbox' name='mail_2_0' id='mail_2_0' value='Y' />										
											<!-- 메신저<input type='checkbox' name='msg_2_0' id='msg_2_0' value='Y' /> -->
										</div>
									</td>
									<td>
										<div class='cellContent_kang'>
											<span id='btn_search2'>검색</span>
											<span id='btn_del2'>삭제</span>
										</div>
									</td>
										
								</tr>
								
								<tr>
									<td>
										<div class='cellTitle_kang2'>담당자3</div>
									</td>
									<td>
										<div class='cellContent_kang'>
											<input class='input' type='text' id='user_nm_3_0' value= "<%=strUserNm3 %>" style='width:90%;height:21px;' readOnly />
										</div>
									</td>
									<td>
										<div class='cellContent_kang'>
											SMS<input type='checkbox' name='sms_3_0' id='sms_3_0' value='Y' />
											MAIL<input type='checkbox' name='mail_3_0' id='mail_3_0' value='Y' />											
											<!-- 메신저<input type='checkbox' name='msg_3_0' id='msg_3_0' value='Y' /> -->
										</div>
									</td>
									<td>
										<div class='cellContent_kang'>
											<span id='btn_search3'>검색</span>
											<span id='btn_del3'>삭제</span>
										</div>
									</td>
								
									<td>
										<div class='cellTitle_kang2'>담당자4</div>
									</td>
									
									<td>
										<div class='cellContent_kang'>
											<input class='input' type='text' id='user_nm_4_0' value= "<%=strUserNm4 %>" style='width:90%;height:21px;' readOnly />
										</div>
									</td>
									<td>
										<div class='cellContent_kang'>
											SMS<input type='checkbox' name='sms_4_0' id='sms_4_0' value='Y' />
											MAIL<input type='checkbox' name='mail_4_0' id='mail_4_0' value='Y' />										
											<!-- 메신저<input type='checkbox' name='msg_4_0' id='msg_4_0' value='Y' /> -->
										</div>
									</td>
									<td>
										<div class='cellContent_kang'>
											<span id='btn_search4'>검색</span>
											<span id='btn_del4'>삭제</span>
										</div>
									</td>
								</tr>
								<tr>
									<td>
										<div class='cellTitle_kang2'><!-- <font color="red">* </font> -->중요작업</div>
									</td>									
									 <td colspan="5">
										<div class='cellContent_kang'>													
											<select id="critical_yn" name="critical_yn" title="중요작업여부" style="width:width:98%;height:21px;">
												<!-- <option value="">--선택--</option>	 -->										       
								       		 	<option value="1">Y</option>
								       		 	<option value="0">N</option>
							     			</select>
							     			<input type="hidden" name="critical" id="critical" value= "<%=CommonUtil.isNull(docBean.getCritical())%>"  style= "width:98%;height:21px;"/>
							     		</div>
									</td>
								</tr>
							</table>
							<table style="width:100%;">
   								<tr>
   									
									<td colspan = "4">
										<div class='cellTitle_kang'>ON/DO</div>
									</td>
									<td style="width:8%;height:21px;">
										<div class='cellTitle_kang'>
											<span id='btn_addStep' style='vertical-align:right;'>추가</span>
										</div>
									</td>
									<td style="width:8%;height:21px;">
										<div class='cellTitle_kang'>
											<span id='btn_delStep' style='vertical-align:right;'>삭제</span>
										</div>
									</td>	
								</tr>
							</table>
   							<table style="width:100%;">
	   							
								<tr>	
									<td style="width:5%;height:21px;">
										<div class='cellTitle_kang2'><input type='checkbox' name="checkIdxAll" id="checkIdxAll" onClick="checkAll();"/></div>
									</td>							  
									<td style="width:7%;height:21px;">
										<div class='cellTitle_kang2'>ON/DO</div>
									</td> 
									<td style="width:13%;height:21px;">
										<div class='cellTitle_kang2'>TYPE</div>
									</td>
									<td style="width:80%;height:21px;">
										<div class='cellTitle_kang2'>PARAMETERS</div>
									</td>
									
								</tr>    
							</table> 
							<table style="width:100%;height:100%;border:none;" id="onDoTable"> 
								<%
								if( null!=docBean.getT_steps() && docBean.getT_steps().trim().length()>0 ){
									aTmpT = CommonUtil.E2K(docBean.getT_steps()).split("[|]");
									for(int t=0; null!=aTmpT&&t<aTmpT.length; t++ ){
										String[] aTmpT1 = aTmpT[t].split(",");
										out.println("<tr>");
										out.println("<td style='width:5%;height:21px;'>");
										out.println("<div class='cellContent_6'><input type='checkbox' name='check_idx'></div>");
										out.println("</td>");
										out.println("<td style='width:7%;height:21px;'>");
										out.println("<div class='cellContent_6'>");		
										
								
										out.println("<select name='m_step_opt' onchange='setStepType(this.value,getObjIdx(this,this.name));' style='width:80%;'>");
										out.println("<option value=''>--</option>");
										aTmp = CommonUtil.getMessage("JOB.STEP_OPT").split(",");
										for(int i=0;i<aTmp.length; i++){
											String[] aTmp1 = aTmp[i].split("[|]");
											
											out.println("<option value='"+aTmp1[0]+"' "+( (aTmp1[0].equals(aTmpT1[0]))? " selected ":"" )+" >"+aTmp1[1]+"</option>");
										}
										out.println("</select>");
										out.println("</div>");
										out.println("</td>");
										out.println("<td style='width:13%;height:21px;'>");
										out.println("<div class='cellContent_6' id='div_step_type"+t+"'>");
										String aTmpT2[] = aTmpT[t].split(",");
										if( "O".equals(aTmpT1[0]) ){
											out.println("<select name='m_step_type' onchange='setStepOnParameters(this.value,"+t+");' style='width:115px;'>");
											aTmp = CommonUtil.getMessage("TABLE.STEP_ON_TYPE").split(",");
											String aTmpt3[] = aTmpT2[3].split(" ");
											for(int i=0;i<aTmp.length; i++){
												String[] aTmp1 = aTmp[i].split("[|]");
												out.println("<option value='"+aTmp1[1]+"' "+( (aTmp1[1].equals(aTmpt3[0]))? " selected ":"" )+" >"+aTmp1[0]+"</option>");
											}
											out.println("</select>");
										}else if( "A".equals(aTmpT1[0]) ){
											out.println("<select name='m_step_type' onchange='setStepParameters(this.value,"+t+");' style='width:115px;'>");
											aTmp = CommonUtil.getMessage("TABLE.STEP_DO_TYPE").split(",");
											for(int i=0;i<aTmp.length; i++){
												if(aTmpT2[1].equals("SPCYC")){
												 	aTmp = CommonUtil.getMessage("TABLE.STEP_DO_TYPE").split(",");
													String[] aTmp1 = aTmp[i].split("[|]");
													out.println("<option value='"+aTmp1[1]+"' "+( (aTmp1[1].equals("Stop Cyclic"))? " selected ":"" )+" >"+aTmp1[0]+"</option>");
												}else{
													String[] aTmp1 = aTmp[i].split("[|]");
													out.println("<option value='"+aTmp1[1]+"' "+( (aTmp1[1].equals(aTmpT1[1]))? " selected ":"" )+" >"+aTmp1[0]+"</option>");
												}
											}
											out.println("</select>");
										}
										out.println("");
										
										out.println("</div></td>");
										out.println("<td style='width:80%;height:21px;'>");
										out.println("<div class='cellContent_7' id='div_step_parameters"+t+"'>");
										if(aTmpT2[0].equals("O")){
											String aTmpt4[] = aTmpT2[3].split(" ");
											if(aTmpt4[0].equals("FAILCOUNT")){
												String aTmpt3[] = aTmpT2[3].split(" ");
												out.println(" Code=<input class='input' type='text' name='m_step_statement_code"+t+"' id='m_step_statement_code"+t+"' maxlength='132' value='"+aTmpt3[2]+"'/>");
											}else{
												aTmp = CommonUtil.getMessage("TABLE.STEP_ON_PARAMETERS").split(",");
												String aTmpt3[] = aTmpT2[3].split(" ");
												System.out.println("aTmpt3 : " + aTmpt3.length);
												if(aTmpt3.length > 1){
													out.println("Stmt=<select name='m_step_statement_stmt"+t+"' id='m_step_statement_stmt"+t+"' onchange='setStepOnStmt(this.value,"+t+");' style='width:95px;'> ");
													
													out.println("<option value=''>--선택--</option>");
												
													if(aTmpt3[2].equals("EVEN") || aTmpt3[2].equals("ODD")){
														for(int i=0;i<aTmp.length; i++){
															String[] aTmp1 = aTmp[i].split("[|]");
															out.println("<option value='"+aTmp1[1]+"' "+( (aTmp1[1].equals(aTmpt3[2]))? " selected ":"" )+" >"+aTmp1[0]+"</option>");
														}
													
														out.println("</select>"); 
													}else{
														for(int i=0;i<aTmp.length; i++){
															String[] aTmp1 = aTmp[i].split("[|]");
															out.println("<option value='"+aTmp1[1]+"' "+( (aTmp1[1].equals(aTmpt3[1]))? " selected ":"" )+" >"+aTmp1[0]+"</option>");
														}
													
														out.println("</select>"); 
														out.println(" Code=<input class='input' type='text' name='m_step_statement_code"+t+"' id='m_step_statement_code"+t+"' maxlength='132' value='"+aTmpt3[2]+"'/>");
													}
												}
												
											}
										}else if(aTmpT2[0].equals("A")){
											 if(aTmpT2.length > 2){	 
												 if(aTmpT2[1].equals("Condition")){
													 out.println("Name=<input class='input' type='text' name='m_step_condition_name"+t+"' id='m_step_condition_name"+t+"' maxlength='255' value='"+aTmpT2[2]+"'/>");
													 out.println("Date=<input class='input datepick ime_readonly' type='text' name='m_step_condition_date"+t+"' id='m_step_condition_date"+t+"' maxlength='4' size='4'  value='"+aTmpT2[3]+"' onclick=\"dpCalMinMax(this.id,'mmdd')\"  onDblClick=\"this.value='ODAT';\" />");
													 out.println("Sign=<select name='m_step_condition_sign"+t+"' id='m_step_condition_sign"+t+"' style='width:55px;'>");
													 aTmp = CommonUtil.getMessage("JOB.STEP_SIGN").split(",");
													 for(int i=0;i<aTmp.length; i++){
														String[] aTmp1 = aTmp[i].split("[|]");
														out.println("<option value='"+aTmp1[0]+"' "+( (aTmp1[0].equals(aTmpT2[4]))? " selected ":"" )+" >"+aTmp1[1]+"</option>");
													 }
													 out.println("</select>");
													 
												 }else if( aTmpT2[1].equals("Shout") ){
													 out.println("Dest=<input class='input' type='text' name='m_step_dest"+t+"' id='m_step_dest"+t+"' value='"+aTmpT2[2]+"'/>");
													 out.println("Message=<input class='input' type='text' name='m_step_message"+t+"' id='m_step_message"+t+"' style='width:400px;'  value='"+aTmpT2[4]+"'/>");
												}
											 }
												 
										}
										out.println("</div></td>");
										
									}
								}
								%>
							</table>
						</td>
					</tr>
				</table>
				

			</div>			
		</td>
	</tr>
	<tr style='height:10px;'>
		<td style='vertical-align:top;'>
			<h4 class="ui-widget-header ui-corner-all" >
				<div align='right' class='btn_area'>
					<span id='btn_draft_admin'>관리자 즉시결재</span>
					<span id='btn_del'>삭제</span>		
					<span id='btn_close'>닫기</span>
				</div>
			</h4>
		</td>
	</tr>
	
</table>
<div id="<%=gridId_3 %>" class="ui-widget-header ui-corner-all" style="display:none;"></div>
<div id="<%=gridId_4 %>" class="ui-widget-header ui-corner-all" style="display:none;"></div>
</form>


<script type="text/javascript">

	var rowsObj_job1 = new Array();
	var rowsObj_job2 = new Array();
	
	var arr_caluse_gb_cd = new Array();
	var arr_caluse_gb_nm = new Array();
	
	<c:forEach var="caluse_gb_cd" items="${caluse_gb_cd}" varStatus="s">
		var map_cd = {"cd":"${caluse_gb_cd}"};
		arr_caluse_gb_cd.push(map_cd);
	</c:forEach>
	<c:forEach var="caluse_gb_nm" items="${caluse_gb_nm}" varStatus="s">
		var map_nm = {"nm":"${caluse_gb_nm}"};
		arr_caluse_gb_nm.push(map_nm);
	</c:forEach>
	
	var arr_prio_gb_cd = new Array();
	var arr_prio_gb_nm = new Array();
	
	<c:forEach var="prio_gb_cd" items="${prio_gb_cd}" varStatus="s">
		var map_cd = {"cd":"${prio_gb_cd}"};
		arr_prio_gb_cd.push(map_cd);
	</c:forEach>
	<c:forEach var="prio_gb_nm" items="${prio_gb_nm}" varStatus="s">
		var map_nm = {"nm":"${prio_gb_nm}"};
		arr_prio_gb_nm.push(map_nm);
	</c:forEach>
	
	var gridObj_1 = {
		id : "<%=gridId_1 %>"
		,colModel:[
			{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'grid_idx',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   		,{formatter:gridCellNoneFormatter,field:'m_in_condition_name',id:'m_in_condition_name',name:'선행조건명',width:320,headerCssClass:'cellCenter',cssClass:'cellLeft'}
	   		,{formatter:Select2Formatter,field:'m_in_condition_date',id:'m_in_condition_date',name:'일자유형',width:80,headerCssClass:'cellCenter',cssClass:'cellLeft', editor: Select2Editor, dataSource: in_select_type}	   		
	   		,{formatter:Select2Formatter,field:'m_in_condition_and_or',id:'m_in_condition_and_or',name:'구분',width:80,headerCssClass:'cellCenter',cssClass:'cellLeft', editor: Select2Editor, dataSource: in_select_gb}	   		
	   		
	   	]
		,rows:[]  
		,vscroll:false
	};
	
	var gridObj_2 = {
		id : "<%=gridId_2 %>"
		,colModel:[
			{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'grid_idx',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   		,{formatter:gridCellNoneFormatter,field:'m_out_condition_name',id:'m_out_condition_name',name:'자기작업 CONDITION',width:320,headerCssClass:'cellCenter',cssClass:'cellLeft'}	 
	   		,{formatter:Select2Formatter,field:'m_out_condition_date',id:'m_out_condition_date',name:'일자유형',width:75,headerCssClass:'cellCenter',cssClass:'cellLeft', editor: Select2Editor, dataSource: out_select_type}	   		
	   		,{formatter:Select2Formatter,field:'m_out_condition_effect',id:'m_out_condition_effect',name:'구분',width:75,headerCssClass:'cellCenter',cssClass:'cellLeft', editor: Select2Editor, dataSource: out_select_gb}  		
	   	]
		,rows:[]
		,vscroll:false
	};
	
	var gridObj_3 = {
		id : "<%=gridId_3 %>"
		,colModel:[
			{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'grid_idx',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   		,{formatter:gridCellNoneFormatter,field:'m_in_condition_name',id:'m_in_condition_name',name:'선행조건명',width:320,headerCssClass:'cellCenter',cssClass:'cellLeft'}	 
	   		,{formatter:gridCellNoneFormatter,field:'m_in_condition_date',id:'m_in_condition_date',name:'일자유형',width:80,headerCssClass:'cellCenter',cssClass:'cellLeft'}	   		
	   		,{formatter:gridCellNoneFormatter,field:'m_in_condition_and_or',id:'m_in_condition_and_or',name:'구분',width:80,headerCssClass:'cellCenter',cssClass:'cellLeft'}
	   		   		
	   	]
		,rows:[]  
		,vscroll:false
	};
	
	var gridObj_4 = {
		id : "<%=gridId_4 %>"
		,colModel:[
			{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'grid_idx',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   		,{formatter:gridCellNoneFormatter,field:'m_out_condition_name',id:'m_out_condition_name',name:'자기작업 CONDITION',width:320,headerCssClass:'cellCenter',cssClass:'cellLeft'}	 
	   		,{formatter:gridCellNoneFormatter,field:'m_out_condition_date',id:'m_out_condition_date',name:'일자유형',width:75,headerCssClass:'cellCenter',cssClass:'cellLeft'}	   		
	   		,{formatter:gridCellNoneFormatter,field:'m_out_condition_effect',id:'m_out_condition_effect',name:'구분',width:75,headerCssClass:'cellCenter',cssClass:'cellLeft'}  		
	   		
	   	]
		,rows:[]
		,vscroll:false
	};
	
	function PopulateSelect(select, dataSource, addBlank) {
	  var index, len, newOption;
	  if (addBlank) { select.appendChild(new Option('', '')); }
	  $.each(dataSource, function (value, text) {
	       newOption = new Option(text, value);
	      select.appendChild(newOption);
	 });
	}
			
	$(document).ready(function(){
		fn_verification_chng();
		var state_cd 			= '<%=state_cd%>';
		var server_gb			= "<%=strServerGb%>";
		var admin_udt			= "<%=admin_udt%>";
		var session_user_gb		= "<%=S_USER_GB%>";
		var flag				= "<%=flag%>";
		var doc_cd 				= '<%=CommonUtil.isNull(paramMap.get("doc_cd"))%>';
		var adminApprovalBtn 	= "<%=strAdminApprovalBtn %>";
		
		if (session_user_gb == "99"  || (server_gb == "D" || server_gb == "T") || adminApprovalBtn == "Y") {
			if(adminApprovalBtn != "Y" && session_user_gb != "99") {
				$("#btn_draft_admin").hide();
			} else {
				$("#btn_draft_admin").show();
			}
		} else {
			$("#btn_draft_admin").hide();
		}
		
		
		// 등록 참조기안 시 닫기 버튼 제거
		if ( flag == "ref" ) {
			$("#btn_close").hide();
		}
			
		
		var taskval = $("#task_type").val();
		
		if ( taskval == "command" || taskval == 'SMART Table' ) {
			$("#ctmfw").hide();			
		} else if ( taskval == "dummy" ) {
			$("#ctmfw").hide();
			
			$("#mem_lib").val("/");
			$("#mem_lib").attr("disabled", true);
			
			$("#mem_name").val("DUMMY");
			$("#mem_name").attr("disabled", true);
			
			$("#command").val("DUMMY");
		}else{
			$("#ctmfw").show();
		}
		
		<%-- var dataCenterText = '<%=CommonUtil.E2K(docBean.getData_center_name())%>';
		var systemOption = "";
		if ( dataCenterText.indexOf("WINI") > -1) {
			systemOption = '<option value="">--선택--</option>';
			<%
			
			for ( int i = 0; i < systemGbList.size(); i++ ) {
				CommonBean bean = (CommonBean)systemGbList.get(i);
				strScodeNm = CommonUtil.E2K(bean.getScode_eng_nm());
				if(!strScodeNm.equals("U") && !strScodeNm.equals("P")){
			%>											
			systemOption += '<option value="<%=CommonUtil.E2K(bean.getScode_eng_nm())%>"><%=bean.getScode_nm()%></option>';
			<%
				}
			}
			%>
			$('#sSystemGb').find('option').remove();
			$('#sSystemGb').append(systemOption);
		} else if ( dataCenterText.indexOf("EXPERT") > -1) {
			systemOption = '<option value="">--선택--</option>';
			<%
			for ( int i = 0; i < systemGbList.size(); i++ ) {
				CommonBean bean = (CommonBean)systemGbList.get(i);
				strScodeNm = CommonUtil.E2K(bean.getScode_eng_nm());
				if(strScodeNm.equals("U")){
			%>											
			systemOption += '<option value="<%=CommonUtil.E2K(bean.getScode_eng_nm())%>"><%=bean.getScode_nm()%></option>';
			<%
				}
			}
			%>
			$('#sSystemGb').find('option').remove();
			$('#sSystemGb').append(systemOption);
		} else if ( dataCenterText.indexOf("CARD") > -1) {
			systemOption = '<option value="">--선택--</option>';
			<%
			for ( int i = 0; i < systemGbList.size(); i++ ) {
				CommonBean bean = (CommonBean)systemGbList.get(i);
				strScodeNm = CommonUtil.E2K(bean.getScode_eng_nm());
				if(strScodeNm.equals("P")){
			%>											
			systemOption += '<option value="<%=CommonUtil.E2K(bean.getScode_eng_nm())%>"><%=bean.getScode_nm()%></option>';
			<%
				}
			}
			%>
			$('#sSystemGb').find('option').remove();
			$('#sSystemGb').append(systemOption);
		} --%>

// 		var data_center 	= $("#data_center").val();
		var data_center 	= $("#frm1").find("input[name='data_center']").val();
		var node_id 		= $("#node_id").val();
		var group_name 		= $("#group_name").val();
		var application 	= $("#application").val();
		var table_name 		= $("#table_name").val();
		var owner 			= $("#v_owner").val();
		var online_impect 	= $("#online_impect_yn").val();		
		var time_group 		= $("#time_group").val();
		var globalCond_yn 	= $("#globalCond").val();
		var critical_yn 	= $("#critical").val();
		var	jobTypeGb		= $("#jobTypeGb").val();
		var systemGb		= $("#systemGb").val();
		
		var confirm_flag	= "<%=strConfirmFlag%>";
		var success_sms_yn	= "<%=strSuccessSmsYn%>";

		getAppGrpCodeList("", "2", "", "application_of_def", table_name);
		
		setTimeout(function(){
			$("select[name='application_of_def']").val(application);
		}, 1000);
		
		getAppGrpCodeList("", "3", "", "group_name_of_def", application);
		
		setTimeout(function(){
			$("select[name='group_name_of_def']").val(group_name);
		}, 1000);
		
								
// 		mHostList(group_name);
		mHostList();
		setTimeout(function(){		
			$("select[name='host_id']").val(node_id);
		}, 1000);
				
		sCodeList(data_center, node_id);
		setTimeout(function(){
			$("select[name='owner']").val(owner);
		}, 1000);
		
		setTimeout(function(){
			$("select[name='sJobTypeGb']").val(jobTypeGb);
		}, 1000);

		setTimeout(function(){
			$("select[name='sSystemGb']").val(systemGb);
		}, 1000);
		
		setTimeout(function(){
			$("select[name='confirm_flag']").val(confirm_flag);
		}, 1000);
		
		setTimeout(function(){
			$("select[name='success_sms_yn']").val(success_sms_yn);
		}, 1000);
	
		$("#btn_clear1").unbind("click").click(function(){
			$("#frm1").find("input[name='scode_nm']").val("");
		});
		
		$("#btn_clear2").unbind("click").click(function(){
			$("#frm1").find("input[name='active_from']").val("");
		});
		
		$("#btn_clear3").unbind("click").click(function(){
			$("#frm1").find("input[name='active_till']").val("");
		});
		
		$("#btn_attach_del").unbind("click").click(function(){
			setAttachFile('');
		});
		$("#btn_err_del").unbind("click").click(function(){
			setErrFile('');
		});

		$("#btn_addUserVar").button().unbind("click").click(function(){
			addUserVars();
		});
		
		$("#btn_addStep").button().unbind("click").click(function(){
			addSteps();
		});
		
		$("#btn_delStep").button().unbind("click").click(function(){
			delSteps();
		});
		
		$("#application_of_def").change(function(){
			
			$("#application").val($(this).val());
			getAppGrpCodeList("", "3", "", "group_name_of_def", $(this).val());
		});
		
		$("#group_name_of_def").change(function(){
			
			$("#group_name").val($(this).val());

			$("select[name='host_id'] option").remove();
			$("select[name='host_id']").append("<option value=''>--선택--</option>");
			$("#node_id").val("");
			
			$("select[name='owner'] option").remove();
			$("select[name='owner']").append("<option value=''>--선택--</option>");
						
			mHostList($(this).val());

		});
		
		//테이블 클릭 시
		$("#table_nm").click(function(){
			var data_center = $("select[name='data_center_items'] option:selected").val();
			
			if(data_center == ""){
				alert("C-M 을 선택해 주세요.");
				return;
			}else{
				$("#p_app_eng_nm").val("");
				poeTabForm();
			}		
		});
		
		/* $("#app_nm").click(function(){
			var data_center = $("#data_center2").val();
			
			if(data_center == ""){
				alert("C-M 을 선택해 주세요.");
				return;
			}else{
				poeAppForm();
			}		
		}); */
				
		$("#host_id").change(function(){ 
			
			$("select[name='owner'] option").remove();
			$("select[name='owner']").append("<option value=''>--선택--</option>");
			$("#v_owner").val("");
						
			var data_center = $("#frm1").find("input[name='data_center']").val();
			var host_id = $("select[name='host_id'] option:selected").val();
			$("#node_id").val(host_id);
			
			sCodeList(data_center, host_id);
		});
		
		//Critical_yn 0 or 1 저장
		$("#critical_yn").change(function(){ 			
			$("#critical").val($(this).val());			
		});
		
		$("#btn_addConditionsIn").button().unbind("click").click(function(){
			popJobsForm('1');
		});
		
		$("#btn_delConditionsIn").button().unbind("click").click(function(){
			var cnt = 0;
			var row_idx = 0;
			var aSelRow = new Array;
			aSelRow = $('#'+gridObj_1.id).data('grid').getSelectedRows();		
			
			if(aSelRow.length>0){
				for(var i=0;i<aSelRow.length;i++){				
					row_idx = getCellValue(gridObj_1,aSelRow[i],'grid_idx');
					
					++cnt;
				}
			}else{
				alert("삭제하려는 항목을 선택해 주세요.");
				return;
			}
			
			if(cnt > 1){
				alert("한개의 항목만 선택해 주세요.");
				return;
			}
			
			if(cnt == 1){
				if(confirm("선택한 항목을 삭제하시겠습니까?")){
					dataDelete(row_idx, "1");
				}
			}
		});	
		
		$("#btn_addConditionsOut").button().unbind("click").click(function(){

			if ( rowsObj_job2.length > 0 ) {			
				popJobsForm('2');
			} else {
				alert("OUT_CONDITION 추가 전 작업명 확인을 클릭하세요");
				return;
			}
		});
		
		$("#btn_delConditionsOut").button().unbind("click").click(function(){
			var cnt = 0;
			var row_idx = 0;
			var aSelRow = new Array;
			aSelRow = $('#'+gridObj_2.id).data('grid').getSelectedRows();		
			
			if(aSelRow.length>0){
				for(var i=0;i<aSelRow.length;i++){				
					row_idx = getCellValue(gridObj_2,aSelRow[i],'grid_idx');
					
					++cnt;
				}
			}else{
				alert("삭제하려는 항목을 선택해 주세요.");
				return;
			}
			
			if(cnt > 1){
				alert("한개의 항목만 선택해 주세요.");
				return;
			}
			
			if (row_idx == 1) {
				alert("자기작업 CONDITION은 삭제할 수 없습니다.");
				return;
			}
			
			if(cnt == 1){
				if(confirm("선택한 항목을 삭제하시겠습니까?")){
					dataDelete(row_idx, "2");
				}
			}
		});
		
		$("#btn_argmt_add").button().unbind("click").click(function(){
			
			popArgForm("argmt");
		});
		$("#btn_parm_add").button().unbind("click").click(function(){
			
			if($("#task_type").val() != "job"){
				alert("작업 타입이 job 일때만 입력 가능 합니다.");
				return;
			}
			
			popArgForm("parm");
		});
		
		$("#btn_argmt_del").button().unbind("click").click(function(){
			getArgDel();
		});
				
		//작업명 후행 등록
		$("#btn_nameDupChk").button().unbind("click").click(function(){
			
			var job_nm = $("#job_name").val();
			
			if(job_nm == ''){
				alert("작업명 상세를 입력 하세요.");
				return;
			}
			
			var data_center = $("#data_center").val();
			
			var formData = new FormData();
			formData.append("c", "JobNameDupCheck");		
			formData.append("job_name", job_nm);
			formData.append("data_center", data_center);
			
			$.ajax({
				url: "<%=sContextPath %>/tWorks.ez",
				type: "post",
				processData: false,
				contentType: false,
				dataType: "text",
				data: formData,
				success: completeHandler = function(data){
										
					var result = data;
					
					// 앞뒤 공백 제거.
	    			result = result.replace(/^\s+|\s+$/g,"");
				
					if(result == "Y"){
						
						alert("중복된 작업명이 있습니다.\n" + job_nm );
						return;
					}else{
						
						alert("[" + job_nm + "] 사용할 수 있는 작업명 입니다.\n자기작업 CONDITION에 추가한 CONDITION목록은 초기화됩니다.");
						
						//getPreAfterJobs("2");
						$("#job_nameChk").val("1");
						
						// 이미 자기작업 CONDITION이 존재하면.
						if ( rowsObj_job2.length > 0 ) {
							
							var nm = "job_out_cond_nm1";
							
							$("#"+nm).val(job_nm);
							
							var obj2Cnt = gridObj_2.rows.length;
							var globYn = $("select[name='globalCond_yn']").val();
							if(obj2Cnt > 0){
								for(var i=0; i<obj2Cnt; i++){
									dataDelete(1, "2");
								}
							}else{
								dataDelete(1, "2");
							}
							
							setPreAfterJobs(job_nm, "2");
							
							if(globYn == '1'){
								setPreAfterJobs("GLOB-"+job_nm, "2");
								$("select[name='globalCond_yn']").val("1");
							}
						} else {
							setPreAfterJobs(job_nm, "2");
						}
												
					}
				},
				error: function(data2){
					alert("error:::"+data2);	
				}
			});			
		
		});
		
		//작업시작시간을 받아서 시간그룹을 SET 해준다.		
		$("#sHour").change(function(){
			
			$("#time_group").val("");
			
			$("#time_from").val("");
			
			var sHour = $("select[name='sHour'] option:selected").val();
			var sMin = $("select[name='sMin'] option:selected").val();
			
			if(sHour == ''){
				$("#time_from").val('');
				$("select[name='sHour']").val("");
				$("select[name='sMin']").val("");
				return;
			}
			$("#time_group").val(sHour);
			
			$("#time_from").val(sHour+sMin);
					
		});
		
		//작업시작시간의 시간, 분을 받아서 from_time을 SET 해준다.		
		$("#sMin").change(function(){
			
			$("#time_from").val("");
			
			var sHour =  $("#sHour").val();
			var sMin = $("#sMin").val();
			
			if(sHour == ''){
				alert("작업시작시간의 '시'항목을 '분' 보다 먼저 입력해 주세요");
				$("#time_from").val('');
				$("select[name='sHour']").val("");
				$("select[name='sMin']").val("");
				return;
			}
			
			if(sMin == ''){
				$("#time_from").val('');
				$("select[name='sHour']").val("");
				$("select[name='sMin']").val("");
				return;
				
			}
			
			$("#time_from").val(sHour+sMin);
					
		});		
		
		
		
		$("#eHour").change(function(){
			
			$("#time_until").val("");
			
			var eHour = $("select[name='eHour'] option:selected").val();
			var eMin = $("select[name='eMin'] option:selected").val();
			
			if(eHour == ''){
				$("#time_until").val('');
				$("select[name='eHour']").val("");
				$("select[name='eMin']").val("");
				return;
			}
			
			$("#time_until").val(eHour+eMin);
					
		});
		
		//작업종료시간의 시간, 분을 받아서 from_time을 SET 해준다.
		
		$("#eMin").change(function(){
			
			$("#time_until").val("");
			
			var eHour =  $("select[name='eHour'] option:selected").val();
			var eMin = $("select[name='eMin'] option:selected").val();
			
			if(eHour == ''){
				alert("작업종료시간의 '시' 항목을 '분' 보다 먼저 입력해 주세요");
				$("#time_until").val('');
				$("select[name='eHour']").val("");
				$("select[name='eMin']").val("");
				return;				
			}
			
			if(eMin == ''){
				$("#time_until").val('');
				$("select[name='eHour']").val("");
				$("select[name='eMin']").val("");
				return;
			}
			
			$("#time_until").val(eHour+eMin);
					
		});
		
		//시작임계시간의 시간, 분을 받아서 late_sub을 SET 해준다.		
		$("#slate_sub_h").change(function(){
			
			$("#late_sub").val("");
			
			var slate_sub_h =  $("select[name='slate_sub_h'] option:selected").val();
			var slate_sub_m = $("select[name='slate_sub_m'] option:selected").val();
			
			if(slate_sub_h == ''){
				alert("시작임계시간의 '시' 항목을 '분' 보다 먼저 입력해 주세요");
				
				$("select[name='slate_sub_h']").val("");
				$("select[name='slate_sub_m']").val("");
				$("#late_sub").val('');
				return;
			}
			
			$("#late_sub").val(slate_sub_h+slate_sub_m);
					
		});		
		
		//시작임계시간의 시간, 분을 받아서 late_sub을 SET 해준다.		
		$("#slate_sub_m").change(function(){
			
			$("#late_sub").val("");
			
			var slate_sub_h =  $("select[name='slate_sub_h'] option:selected").val();
			var slate_sub_m = $("select[name='slate_sub_m'] option:selected").val();
			
			if(slate_sub_h == ''){
				alert("시작임계시간의 '시' 항목을 '분' 보다 먼저 입력해 주세요");
				
				$("select[name='slate_sub_h']").val("");
				$("select[name='slate_sub_m']").val("");
				$("#late_sub").val('');
				return;
			}
			
			if(slate_sub_m == ''){
				
				$("select[name='slate_sub_h']").val("");
				$("select[name='slate_sub_m']").val("");
				$("#late_sub").val('');
				return;
			}
			
			$("#late_sub").val(slate_sub_h+slate_sub_m);
					
		});		
		
		//종료임계시간의 시간, 분을 받아서 late_sub을 SET 해준다.	
		$("#slate_time_h").change(function(){
			
			var slate_time_h =  $("select[name='slate_time_h'] option:selected").val();
			
			if(slate_time_h == ''){
				$("select[name='slate_time_h']").val("");
				$("select[name='slate_time_m']").val("");
				$("#late_time").val("");
				return;
			}
			$("#late_time").val(slate_time_h+slate_time_m);
		});
		
		$("#slate_time_m").change(function(){
			
			$("#late_time").val("");
			
			var slate_time_h =  $("select[name='slate_time_h'] option:selected").val();
			var slate_time_m = $("select[name='slate_time_m'] option:selected").val();
			
			if(slate_time_h == ''){
				alert("시작임계시간의 '시' 항목을 '분' 보다 먼저 입력해 주세요");
				$("select[name='slate_time_h']").val("");
				$("select[name='slate_time_m']").val("");
				$("#late_time").val("");
				return;
				
			}
			
			if(slate_time_m == ''){
				$("select[name='slate_time_h']").val("");
				$("select[name='slate_time_m']").val("");
				$("#late_time").val("");
				return;
			}
			
			$("#late_time").val(slate_time_h+slate_time_m);
					
		});
		
		// 글로벌 컨디션 발행이 'Y' 이면 후행 조건에 GLOBAL 컨디션을 입력 한다.		
		$("#globalCond_yn").change(function(){
			
			var job_nm = $("#job_name").val();
			var globalCond_yn = $("select[name='globalCond_yn'] option:selected").val();
			if(job_nm == ''){
				alert("작업명을 입력 하세요.");
				$("select[name='globalCond_yn']").val("N");
				
				return;
			}
			
			if(globalCond_yn == "0"){
				getPreAfterJobs("2");	
			}else{
				setPreAfterJobs("GLOB-"+job_nm, "2", "");	
			}
		});
		
		$("#sJobTypeGb").change(function(){
			
			// 작업유형구분에 따라 작업타입 변경.
			if ( $("#jobTypeGb").val() == "F" ) {
				
// 				$("#task_type").val("job");
				$("#ctmfw").show();
				
				$("#mem_lib").val("");
				$("#mem_lib").attr("disabled", false);
				
				$("#mem_name").val("");
				$("#mem_name").attr("disabled", false);
				
			} else if( $("#jobTypeGb").val() == "D" ) {
				
// 				$("#task_type").val("dummy");
				
				$("#ctmfw").hide();
				
				$("#mem_lib").val("/");
				$("#mem_lib").attr("disabled", true);
				
				$("#mem_name").val("DUMMY");
				$("#mem_name").attr("disabled", true);
				
				$("#command").val("DUMMY");
				
			} else {
				
// 				$("#task_type").val("command");
				$("#ctmfw").hide();
				
				$("#mem_lib").val("");
				$("#mem_lib").attr("disabled", false);
				
				$("#mem_name").val("");
				$("#mem_name").attr("disabled", false);
			}
			
		});
		
		$("#btn_ins").button().unbind("click").click(function(){
			goPrc('ins');
		});	
		$("#btn_udt").button().unbind("click").click(function(){
			goPrc('udt');
		});	
		$("#btn_draft").button().unbind("click").click(function(){
			if(state_cd == '00' || state_cd == "01"){
				goPrc('draft');
			} else {
				goPrc('draft');
			}			
		});	
		
		$("#btn_draft_admin").button().unbind("click").click(function(){
// 			if(state_cd == '00' || state_cd == "01"){
// 				goPrc('draft_admin');
// 			} else {
				goPrc('draft_admin');
// 			}
		});	

		$("#btn_srSearch").button().unbind("click").click(function(){
			popupSrForm();
		});
		
		$("#btn_srClear").button().unbind("click").click(function(){
			srClear();
		});
		
		$("#btn_search1").button().unbind("click").click(function(){
			goUserSearch("1");
		});
		$("#btn_search2").button().unbind("click").click(function(){
			goUserSearch("2");
		});
		$("#btn_search3").button().unbind("click").click(function(){
			goUserSearch("3");
		});
		$("#btn_search4").button().unbind("click").click(function(){
			goUserSearch("4");
		});
		
		$("#btn_cyclic").button().unbind("click").click(function(){
			fn_cyclic_popup();
		});
		
		$("#btn_del1").button().unbind("click").click(function(){
			if($("#user_nm_1_0").val("") == ""){
				alert("담당자 값이 없습니다.");
				return ;
			} 
			$("#user_nm_1_0").val("");
			$("#user_cd_1_0").val("");
		});
		
		$("#btn_del2").button().unbind("click").click(function(){
			if($("#user_nm_2_0").val("") == ""){
				alert("담당자2 값이 없습니다.");
				return ;
			}
			$("#user_nm_2_0").val("");
			$("#user_cd_2_0").val("");
		});

		$("#btn_del3").button().unbind("click").click(function(){
			if($("#user_nm_3_0").val("") == ""){
				alert("담당자3 값이 없습니다.");
				return ;
			}
			
			$("#user_nm_3_0").val("");
			$("#user_cd_3_0").val("");
		});

		$("#btn_del4").button().unbind("click").click(function(){
			if($("#user_nm_4_0").val("") == ""){
				alert("담당자4 값이 없습니다.");
				return ;
			}
			$("#user_nm_4_0").val("");
			$("#user_cd_4_0").val("");
		});
		
		$("#table_name").unbind("keyup").keyup(function(){
			$("#job_name").val($(this).val());	
		});
		
		$("#mem_lib").unbind("keyup").keyup(function(){
			
			var mem_name = $("#mem_name").val();
			var command = $(this).val() + mem_name;
			
			$("#command").val(command);			
		});
		
		$("#mem_name").unbind("keyup").keyup(function(e){
			
			var mem_lib = $("#mem_lib").val();
			var command =  mem_lib + $(this).val();
			
			$("#command").val(command);		
		});
		
		$("#arg_val").unbind("keyup").keyup(function(e){
			
			var mem_lib = $("#mem_lib").val();
			var mem_name = $("#mem_name").val();
			var command =  mem_lib + mem_name + " "+ $(this).val();
			
			$("#command").val(command);		
		});		

		$("#f_s").find("input[name='p_apply_date']").val("${ODATE}");
		
		$("#active_from").addClass("ime_readonly").unbind('click').click(function(){
			dpCalMinMax(this.id,'yymmdd','0','90');
		});	
		
		$("#active_till").addClass("ime_readonly").unbind('click').click(function(){
			dpCalMinMax(this.id,'yymmdd','0','90');
		});
		
		$("#btn_approval").button().unbind("click").click(function(){
			alert("결재");
		});
		
		$("#btn_wait").button().unbind("click").click(function(){
			alert("보류");
		});
		
		$("#btn_reject").button().unbind("click").click(function(){
			alert("반려");
		});
		
		$("#btn_cancel").button().unbind("click").click(function(){
			alert("승인취소");
		});
		
		$("#btn_close").button().unbind("click").click(function(){			
			top.closeTabs('tabs-'+doc_cd);
		});
		
		$("#btn_list").button().unbind("click").click(function(){
			
			var search_data_center 		= "<%=search_data_center%>";
			var search_state_cd 		= "<%=search_state_cd%>";
			var search_approval_cd 		= "<%=search_approval_cd%>";
			var search_gb 				= "<%=search_gb%>";
			var search_text 			= "<%=search_text%>";
			var search_date_gubun 		= "<%=search_date_gubun%>";
			var search_s_search_date 	= "<%=search_s_search_date%>";
			var search_e_search_date 	= "<%=search_e_search_date%>";
			var search_task_nm	 		= "<%=search_task_nm%>";
			var search_moneybatchjob	= "<%=search_moneybatchjob%>";
			var search_critical 		= "<%=search_critical%>";
			
			var search_param = "&search_data_center="+search_data_center+"&search_state_cd="+search_state_cd+"&search_approval_cd="+search_approval_cd+
							   "&search_gb="+search_gb+"&search_text="+encodeURI(search_text)+"&search_date_gubun="+search_date_gubun+
							   "&search_s_search_date="+search_s_search_date+"&search_e_search_date="+search_e_search_date+
							   "&search_task_nm="+search_task_nm+"&search_moneybatchjob="+search_moneybatchjob+"&search_critical="+search_critical;
			
			// search_state_cd가 없으면 결재목록에서 조회
			// search_approval_cd가 없으면 의뫼목록에서 조회
			if ( search_state_cd == "" ) {
				top.addTab('c', '정기작업의뢰결재', '01', '0101', 'tWorks.ez?c=ez005&menu_gb=0101&doc_gb=01'+search_param);
			} else {
				top.addTab('c', '정기작업의뢰조회', '03', '0301', 'tWorks.ez?c=ez004&menu_gb=0301&doc_gb=01'+search_param);
			}
			
			top.closeTab('tabs-99999');			
		});
		
		$("#btn_capy").button().unbind("click").click(function(){
			alert("복사");
		});
		$("#btn_del").button().unbind("click").click(function(){
// 			goPrc('draft_admin_del');
			goPrc('del');
		});
						
		$("#mem_lib").click(function(){
			alert("NT 수행서버의 구분자  '\\\\'를 입력 하셔야 합니다 \n'"+" EX : (c:\\\\test\\\\) \n"+"  NT 수행 서버가 아닌 경우 구분자는 '/' 로 입력 하셔야 합니다 \n"+"  EX: (/test/ )'");			
		});
		
		// 캘린더		
		$("#btn_sched").button().unbind("click").click(function(){
			popSchedForm();
		});
		// 캘린더 제거
		$("#btn_schedDel").button().unbind("click").click(function(){
			$("#cal_cd").val("");
			$("#cal_nm").val("");
			$("#days_cal").val("");
			$("#days_and_or").val("");
			$("#weeks_cal").val("");
			$("#week_days").val("");
			$("#use_gb").val("");
			$("#use_yn").val("");
			$("#month_cal").val("");
			$("#month_days").val("");
			$("#conf_cal").val("");
			$("#shift").val("");
			$("#shift_num").val("");
		});
		
		$("#btn_CalDetail").button().unbind("click").click(function(){
			
			var data_center = $("#frm1").find("input[name='data_center']").val();
			if(data_center == ""){
				alert("시스템을 선택해 주세요.");
				return;
			}			
			
			fn_sch_forecast();
		});
		
		$("#btn_schedInfo").button().unbind("click").click(function(){
						
			if($("#tab_yn").val() == "0"){
				
				if($("#cal_nm").val() == ""){
					alert("캘린더명을 입력하세요.");
					return;
				}	
				
				//$("#schedInfo").show();
				$("#tab_yn").val("1");
			}else{
				//$("#schedInfo").hide();
				$("#tab_yn").val("0");
			}
			
		});
		
		//form value set
		$("#scode_nm").val("<%=strScode_nm%>");
		$("#critical_yn").val("<%=CommonUtil.isNull(docBean.getCritical())%>");
		$("#batchGrade").val("<%=strBatchJobGrade%>");
		$("select[name='sHour']").val("<%=vh_fromTime%>");
		$("select[name='sMin']").val("<%=vm_fromTime%>");
		$("select[name='eHour']").val("<%=vh_timeUntil%>");
		$("select[name='eMin']").val("<%=vm_timeUntil%>");
		$("select[name='slate_sub_h']").val("<%=vh_lateSub%>");
		$("select[name='slate_sub_m']").val("<%=vm_lateSub%>");
		$("select[name='slate_time_h']").val("<%=vh_lateTime%>");
		$("select[name='slate_time_m']").val("<%=vm_lateTime%>");
		
		$("select[name='globalCond_yn']").val("<%=global_yn%>");
		
		if("<%=strSms1%>" == "Y") $("input:checkbox[name='sms_1_0']").attr("checked", true);
		//if("<%=strMsg1%>" == "Y") $("input:checkbox[name='msg_1_0']").attr("checked", true);
		if("<%=strMail1%>" == "Y") $("input:checkbox[name='mail_1_0']").attr("checked", true);
		
		if("<%=strSms2%>" == "Y") $("input:checkbox[name='sms_2_0']").attr("checked", true);
		//if("<%=strMsg2%>" == "Y") $("input:checkbox[name='msg_2_0']").attr("checked", true);
		if("<%=strMail2%>" == "Y") $("input:checkbox[name='mail_2_0']").attr("checked", true);
		
		if("<%=strSms3%>" == "Y") $("input:checkbox[name='sms_3_0']").attr("checked", true);
		//if("<%=strMsg3%>" == "Y") $("input:checkbox[name='msg_3_0']").attr("checked", true);
		if("<%=strMail3%>" == "Y") $("input:checkbox[name='mail_3_0']").attr("checked", true);
		
		if("<%=strSms4%>" == "Y") $("input:checkbox[name='sms_4_0']").attr("checked", true);
		//if("<%=strMsg4%>" == "Y") $("input:checkbox[name='msg_4_0']").attr("checked", true);
		if("<%=strMail4%>" == "Y") $("input:checkbox[name='mail_4_0']").attr("checked", true);
				
		viewGrid_2(gridObj_1,"ly_"+gridObj_1.id);
		viewGrid_2(gridObj_2,"ly_"+gridObj_2.id);
		
		viewGrid_1(gridObj_3,"ly_"+gridObj_3.id);
		viewGrid_1(gridObj_4,"ly_"+gridObj_4.id);
		
		//선행 추가
		<%
			if( null!=docBean.getT_conditions_in() && docBean.getT_conditions_in().trim().length()>0 ){				
				aTmpT = CommonUtil.E2K(docBean.getT_conditions_in()).split("[|]");
				for(int t=0; null!=aTmpT&&t<aTmpT.length; t++ ){
					String[] aTmpT1 = aTmpT[t].split(",",3);
		%>		
			//setPreAfterJobs("<%=aTmpT1[0]%>", "1", "M");
			setPreAfterJobs("<%=aTmpT[t]%>", "1", "M");
		<%
				}
			}
		%>
		
		//후행 추가
		<%
			if( null!=docBean.getT_conditions_out() && docBean.getT_conditions_out().trim().length()>0 ){
				aTmpT = CommonUtil.E2K(docBean.getT_conditions_out()).split("[|]");
				for(int t=0; null!=aTmpT&&t<aTmpT.length; t++ ){
					String[] aTmpT1 = aTmpT[t].split(",",3);
				
		%>
			//setPreAfterJobs("<%=aTmpT1[0]%>", "2", "");
			setPreAfterJobs("<%=aTmpT[t]%>", "2", "");
		<%
				}
			}
		%>
		
	});
	function fn_verification_chng(){
		var verification_yn = $('#verification_yn').val();
		
		if(verification_yn == "Y"){
			$('#sysout_font').show();
			$('#standard_sysout').attr("disabled", false); 
		}else{
			$('#sysout_font').hide();
			$('#standard_sysout').attr("disabled", true); 
		}
	}
	function checkAll() {
		
		var chk 	= document.getElementsByName("check_idx");
		var chk_all = document.getElementById("checkIdxAll");
		var cnt = 0;		

		if (cnt==0) {
			for(i = 0; i < chk.length; i++) {
				if(chk_all.checked) {				
					chk.item(i).checked ="checked";
				}else {
					chk.item(i).checked = "";					
				}
			}
			cnt++;
		}else {
			for(i = 0; i < chk.length; i++) chk.item(i).checked ="";
			cnt=0;
		}
	}
	
		
	function goUserSeqSelect(cd, nm, btn){
	
		var frm1 = document.frm1;
		
		if(btn == "1"){
			frm1.user_nm_1_0.value = nm;
			frm1.user_cd_1_0.value = cd;
			
		}else if(btn == "2"){
			frm1.user_nm_2_0.value = nm;
			frm1.user_cd_2_0.value = cd;
			
		}else if(btn == "3"){
			frm1.user_nm_3_0.value = nm;
			frm1.user_cd_3_0.value = cd;
			
		}else if(btn == "4"){
			frm1.user_nm_4_0.value = nm;
			frm1.user_cd_4_0.value = cd;
			
		}
	
		dlClose('dl_tmp3');
	}
	
	function fn_cyclic_set(cyclic_value){

		var form = document.frm1;

		if ( cyclic_value == "1" ) {
						
			form.max_wait.value = "0";

			document.getElementById('cyclic_ment').style.display = "";

			form.rerun_max.readOnly = "";

		} else {
			
			form.max_wait.value 		= "<%=strDefaultMaxWait%>";
			form.rerun_interval.value 	= "false";

			form.rerun_interval.value 		= "";
			form.rerun_interval_time.value 	= "";
			form.cyclic_type.value 			= "";
			form.count_cyclic_from.value 	= "";
			form.interval_sequence.value 	= "";
			form.tolerance.value 			= "";
			form.specific_times.value 		= "";

			document.getElementById('cyclic_ment').innerHTML		= "";
			document.getElementById('cyclic_ment').style.display 	= "none";

			form.rerun_max.value 		= "0";
			form.rerun_max.readOnly 	= "true";
		}
	}



	function fn_cyclic_popup() {

		var frm = document.frm1;

		var cyclic = document.getElementById('cyclic').value;

		if ( cyclic == "0" ) {
			if( !confirm('반복작업이 아닙니다.\n반복작업으로 설정 하시겠습니까?') ) return;
		}

		document.getElementById('cyclic').value = "1";
		fn_cyclic_set('1');		

		openPopupCenter1("about:blank","popupCyclic",450,400);
		
		frm.action = "<%=sContextPath %>/tPopup.ez?c=ez005";
		frm.target = "popupCyclic";    
		frm.submit();
	}
	
		//Step
	function getCodeList(scode_cd, grp_depth, grp_cd, val){
		
		try{viewProgBar(true);}catch(e){}
				
		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=appGrpCodeList&itemGubun=2&scode_cd='+scode_cd+'&grp_depth='+grp_depth+'&grp_cd='+grp_cd;
		
		var xhr = new XHRHandler(url, null
				,function(){
					var xmlDoc = this.req.responseXML;
					if(xmlDoc==null){
						try{viewProgBar(false);}catch(e){}
						alert('세션이 만료되었습니다 다시 로그인해 주세요');
						return false;
					}
					if($(xmlDoc).find('doc').length == 0 && $(xmlDoc).find('error').length > 0){
						try{viewProgBar(false);}catch(e){}
						alert($(xmlDoc).find('msg_code').text());
						//goCommonError('<%=sContextPath %>','_self',$(xmlDoc).find('msg_code').text());
						return false;
					}
					$(xmlDoc).find('doc').each(function(){
						
						var items = $(this).find('items');
						var rowsObj = new Array();
												
						if(items.attr('cnt')=='0'){
							$("select[name='"+val+"'] option").remove();
							$("select[name='"+val+"']").append("<option value=''>--선택--</option>");							
						}else{
							
							$("select[name='"+val+"'] option").remove();
							$("select[name='"+val+"']").append("<option value=''>--선택--</option>");			
							
							items.find('item').each(function(i){						
							
								var grp_cd = $(this).find("GRP_CD").text();
								var grp_nm = $(this).find("GRP_NM").text();								
								var grp_eng_nm = $(this).find("GRP_ENG_NM").text();
								var grp_desc = $(this).find("GRP_DESC").text();
								var grp_all_cd = grp_cd+","+grp_eng_nm;
																																																								
								$("select[name='"+val+"']").append("<option value='"+grp_all_cd+"'>"+grp_desc+"</option>");
								
							});						
						}									
						
					});
					try{viewProgBar(false);}catch(e){}
				}
		, null );
		
		xhr.sendRequest();
	}
	
	function popJobsForm(gb){
		
		var data_center = $("#frm1").find("input[name='data_center']").val();
		var application = $("#application").val();
		var group_name = $("#group_name").val();
	
		if(data_center == ""){
			alert("시스템을 선택해 주세요.");
			return;
		}
		
		/* if(application == ""){
			alert("어플리케이션(L3)을 선택해 주세요.");
			return;
		}
		
		if(group_name == ""){
			alert("어플리케이션(L4)을 선택해 주세요.");
			return;
		} */
		
		var sHtml1="<div id='dl_tmp1' style='overflow:hidden;display:none;padding:0;border-top:1px solid blue;border-bottom:1px solid blue;border-left:1px solid blue;border-right:1px solid blue;'>";
		sHtml1+="<form id='form1' name='form1' method='post' onsubmit='return false;'>";
		sHtml1+="<input type='hidden' name='search_gubun' id='search_gubun' value='job_name' />";
		sHtml1+="<table style='width:100%;height:260px;;border:none;'><tr><td style='vertical-align:top;height:100%;width:500px;text-align:right;'>";
		sHtml1+="<div class='ui-widget-header ui-corner-all'>C-M : <select name='v_data_center' id='v_data_center' style='height:21px;'>";
		sHtml1+="<option value=''>--선택--</option>";
		<c:forEach var="inCond_cm" items="${data_center}" varStatus="status">
			sHtml1+="<option value='${inCond_cm.scode_cd},${inCond_cm.scode_eng_nm}'>${inCond_cm.scode_nm}</option>"
		</c:forEach>;
		sHtml1+="</select>&nbsp;";
		sHtml1+="작업명 : <input type='text' name='pre_search_text' id='pre_search_text' value='' />&nbsp;&nbsp;<span id='btn_pre_search' style='margin:3px;'>검색</span></div>";
		sHtml1+="<table style='width:100%;height:100%;border:none;'>";
		sHtml1+="<tr><td id='ly_g_tmp1' style='vertical-align:top;' >";
		sHtml1+="<div id='g_tmp1' class='ui-widget-header ui-corner-all'></div>";
		sHtml1+="</td></tr>";
		sHtml1+="<tr style='height:10px;'><td style='vertical-align:top;'><h5 class='ui-widget-header ui-corner-all' >";
		sHtml1+="<div align='right' class='btn_area_s'>";
		sHtml1+="<div id='ly_total_cnt_1' style='padding-top:5px;float:left;'></div>";
		sHtml1+="</div>";
		sHtml1+="</h5></td></tr></table>";
		
		sHtml1+="</td></tr></table>";
		
		sHtml1+="</form>";
		
		$('#dl_tmp1').remove();
		$('body').append(sHtml1);
		
		dlPop01('dl_tmp1',"컨디션검색",570,300,false);
				
		var gridObj = {
			id : "g_tmp1"
			,colModel:[
		   		{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'번호',width:50,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}	   		
		   		,{formatter:gridCellNoneFormatter,field:'APPLICATION',id:'APPLICATION',name:'어플리케이션',width:120,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}	 
		   		,{formatter:gridCellNoneFormatter,field:'GROUP_NAME',id:'GROUP_NAME',name:'그룹',width:120,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}	   		
		   		,{formatter:gridCellNoneFormatter,field:'JOB_NAME',id:'JOB_NAME',name:'작업명',width:200,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
		   		,{formatter:gridCellNoneFormatter,field:'CHOICE',id:'CHOICE',name:'선택',width:50,headerCssClass:'cellCenter',cssClass:'cellCenter'}
		   		
		   		,{formatter:gridCellNoneFormatter,field:'JOB_ID',id:'JOB_ID',name:'JOB_ID',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
		   		,{formatter:gridCellNoneFormatter,field:'TABLE_ID',id:'TABLE_ID',name:'TABLE_ID',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
		   	]
			,rows:[]
			,vscroll:<%=S_GRID_VSCROLL%>
		};
		
		$("#v_data_center").val(data_center);
		$("#doc_data_center").val(data_center);
		$("#pre_search_text").focus();
		
		viewGrid_1(gridObj,'ly_'+gridObj.id);
		//popJobsList('',gb);
		
		$('#pre_search_text').placeholder().unbind('keypress').keypress(function(e){
			
			if(e.keyCode==13){
								
				if($(this).val() == ""){
					//popJobsList($(this).val(), gb);
					alert("작업명을 입력해주세요.");
					return;
				}else{
					var v_data_center = $("select[name='v_data_center'] option:selected").val();
					
					if(v_data_center == ""){
						alert("C-M 을 선택해 주세요.");
						return;
					}
					
					popJobsList($(this).val(), gb);
				}
			}
		});		
		
		$("#btn_pre_search").button().unbind("click").click(function(){
			
			var search_text = $("#form1").find("input[name='pre_search_text']").val();
			
			if(search_text == ""){
				//popJobsList(search_text, gb);
				alert("작업명을 입력해주세요.");
				return;
			}else{
				var v_data_center = $("select[name='v_data_center'] option:selected").val();
				
				if(v_data_center == ""){
					alert("C-M 을 선택해 주세요.");
					return;
				}
				
				popJobsList(search_text, gb);
			}
		});
		
	}
			
	function goPreJobSelect(job_nm, gb, flag){
		
		var v_job_name = "";
		
		if(flag == "direct"){
			v_job_name = document.getElementById('job_name0').value;
			if(v_job_name == ""){
				alert("직접입력에 작업명을 입력해 주세요.");
				return;
			}
		}else{
			v_job_name = job_nm;
		}
		
		setPreAfterJobs(v_job_name, gb, "");
			
		if(flag == "direct"){
			document.getElementById('job_name0').value = "";
		}
	}		
	
	//서버내역 가져오기
	function hostList(host_cd){		
		
		try{viewProgBar(true);}catch(e){}
				
		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=hostList&host_cd='+host_cd;
		
		var xhr = new XHRHandler(url, null
				,function(){
					var xmlDoc = this.req.responseXML;
					if(xmlDoc==null){
						try{viewProgBar(false);}catch(e){}
						alert('세션이 만료되었습니다 다시 로그인해 주세요');
						return false;
					}
					if($(xmlDoc).find('doc').length == 0 && $(xmlDoc).find('error').length > 0){
						try{viewProgBar(false);}catch(e){}
						alert($(xmlDoc).find('msg_code').text());
						//goCommonError('<%=sContextPath %>','_self',$(xmlDoc).find('msg_code').text());
						return false;
					}
					$(xmlDoc).find('doc').each(function(){
						
						var items = $(this).find('items');
						var rowsObj = new Array();
						
						if(items.attr('cnt')=='0'){
							$("select[name='host_id'] option").remove();
							$("select[name='host_id']").append("<option value=''>--선택--</option>");	
						}else{
							$("select[name='host_id'] option").remove();
							$("select[name='host_id']").append("<option value=''>--선택--</option>");			
							
							items.find('item').each(function(i){						
							
								var host_cd = $(this).find("HOST_CD").text();								
								var node_id = $(this).find("NODE_ID").text();
								var node_nm = $(this).find("NODE_NM").text();
								var all_cd = host_cd+","+node_id;
								var all_nm = node_nm+"("+node_id+")";
																
								$("select[name='host_id']").append("<option value='"+all_cd+"'>"+all_nm+"</option>");
								
							});						
						}
												
					});
					try{viewProgBar(false);}catch(e){}
				}
		, null );
		
		xhr.sendRequest();
	}

	//서버계정가져오기
	function sCodeList(data_center, node_id){
		
		try{viewProgBar(true);}catch(e){}
					
		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=sCodeList&user_gb=<%=S_USER_GB %>&mcode_cd=${SERVER_MCODE_CD}&data_center='+data_center+'&agent='+node_id;
		
		var xhr = new XHRHandler(url, null
				,function(){
					var xmlDoc = this.req.responseXML;
					if(xmlDoc==null){
						try{viewProgBar(false);}catch(e){}
						alert('세션이 만료되었습니다 다시 로그인해 주세요');
						return false;
					}
					if($(xmlDoc).find('doc').length == 0 && $(xmlDoc).find('error').length > 0){
						try{viewProgBar(false);}catch(e){}
						alert($(xmlDoc).find('msg_code').text());
						//goCommonError('<%=sContextPath %>','_self',$(xmlDoc).find('msg_code').text());
						return false;
					}
					$(xmlDoc).find('doc').each(function(){
						
						var items = $(this).find('items');
						var rowsObj = new Array();
											
						if(items.attr('cnt')=='0'){
							$("select[name='owner'] option").remove();
							$("select[name='owner']").append("<option value=''>--선택--</option>");	
						}else{
							
							$("select[name='owner'] option").remove();
							$("select[name='owner']").append("<option value=''>--선택--</option>");	
							
							items.find('item').each(function(i){						
							
								var scode_cd = $(this).find("SCODE_CD").text();
								var scode_nm = $(this).find("SCODE_NM").text();								
								var scode_eng_nm = $(this).find("SCODE_ENG_NM").text();							
								var host_cd = $(this).find("HOST_CD").text();
															
								$("select[name='owner']").append("<option value='"+scode_eng_nm+"'>"+scode_nm+"</option>");
							});						
						}						
					
					});
					try{viewProgBar(false);}catch(e){}
				}
		, null );
		
		xhr.sendRequest();
	}
	
	function setPreAfterJobs(job_nm, gb, flag){
		
		var m_in_condition_name 	= "";
		var m_in_condition_date 	= "";
		var m_in_condition_and_or 	= "";
		
		var m_out_condition_name 	= "";
		var m_out_condition_date 	= "";
		var m_out_condition_effect 	= "";
		
		var i 	= 0;
		var val = "";
		
		if(gb == "1"){
			i = rowsObj_job1.length+1;
			val = "_in_cond_nm"+i;
		}else if(gb == "2"){
			i = rowsObj_job2.length+1;
			val = "_out_cond_nm"+i;
		}
		
		var job_name 	= "";
		var odate 		= "";
		var gubun 		= "";
		
		// 등록되어 있는 선.후행 뿌려줄 경우 콤마로 구분되어 있음.
		if ( job_nm.split(",", 3) ) {
			var cond = job_nm.split(",", 3);
			job_name 	= cond[0];
			odate 		= cond[1];
			gubun 		= cond[2];
		}
		
		if(job_nm != ""){
			//INCONDITION  설정
			if(gb == "1"){
												
				var dup_cnt = 0;				
				setGridSelectedRowsAll(gridObj_1);		//중복체크를 위해 전체항목 선택
				
				var aSelRow = new Array;
				aSelRow = $('#'+gridObj_1.id).data('grid').getSelectedRows();
							
				if(aSelRow.length>0){
					for(var j=0;j<aSelRow.length;j++){						
						var v_cond_nm = getCellValue(gridObj_1,aSelRow[j],'chk_condition_name');		
						
						if(v_cond_nm == job_nm){
							++dup_cnt;
							break;
						}
					}
				}
								
				clearGridSelected(gridObj_1)		//선택된 전체항목 해제 */
				
				if(typeof odate == "undefined") odate = "ODAT";
				if(typeof gubun == "undefined") gubun = "and";
				
				if(dup_cnt > 0){	//중복된 내용이 있다면 (잡명)
					alert("이미 등록된 내용 입니다.");
					return;
				}else{
										
					rowsObj_job1.push({
						'grid_idx':i
						,'m_in_condition_name': job_name
						,'m_in_condition_date': odate
						,'m_in_condition_and_or': gubun	
						,'chk_condition_name': job_name
					});
				
					gridObj_1.rows = rowsObj_job1;
					setGridRows(gridObj_1);
					
					if(flag != "M"){
						alert("선택 항목이 추가 되었습니다.");
					}
				}
				
				// 일자유형 셋팅
				$("select[name='dt"+val+"']").val(odate);
				
				// 구분 셋팅
				$("select[name='gb"+val+"']").val(gubun);
			
			}else if(gb == "2"){
								
				var dup_cnt = 0;				
				setGridSelectedRowsAll(gridObj_2);		//중복체크를 위해 전체항목 선택
				
				var aSelRow = new Array;
				aSelRow = $('#'+gridObj_2.id).data('grid').getSelectedRows();
							
				if(aSelRow.length>0){
					for(var j=0;j<aSelRow.length;j++){						
						var v_cond_nm = getCellValue(gridObj_2,aSelRow[j],'m_out_condition_name');		
						
						if(v_cond_nm == job_nm){
							++dup_cnt;
							break;
						}
					}
				}
								
				clearGridSelected(gridObj_2)		//선택된 전체항목 해제 */
								
				if(typeof odate == "undefined") odate = "ODAT";
				if(typeof gubun == "undefined") gubun = "add";
				
				if(dup_cnt > 0){	//중복된 내용이 있다면 (잡명)
					alert("이미 등록된 내용 입니다.");
					return;
				}else{	
									
					rowsObj_job2.push({
						'grid_idx':i
						,'m_out_condition_name': job_name
						,'m_out_condition_date': odate
						,'m_out_condition_effect': gubun		
						,'chk_condition_name': job_name
					});
					
					gridObj_2.rows = rowsObj_job2;
					setGridRows(gridObj_2);
				}
			}
		}
	
	}
	
	function getPreAfterJobs(gb){
		
		if(gb == "1"){			
			var cnt = 0;
			var row_idx = rowsObj_job1.length;
						
			if(row_idx > 0){
				delGridRow(gridObj_1, row_idx-1);
			}			
			
		}else if(gb == "2"){
			var cnt = 0;
			var row_idx = rowsObj_job2.length;
						
			if (row_idx == 1) {
				alert("자기작업 CONDITION은 삭제할 수 없습니다.");
			} else if (row_idx > 1) {				
				for(var i=0; i<row_idx; i++){
					var outCondName = getCellValue(gridObj_2, i, "m_out_condition_name");
					if(outCondName.substring(0, 4) == "GLOB"){
						row_idx = i+1;
						dataDelete(row_idx, '2');
					}
				}
			}
		}
	}

	//입력변수 폼
	function popArgForm(flag){
				
		var sHtml1="<div id='dl_tmp1' style='overflow:hidden;display:none;padding:0;border-top:1px solid blue;border-bottom:1px solid blue;border-left:1px solid blue;border-right:1px solid blue;'>";
		sHtml1+="<form id='form1' name='form1' method='post' onsubmit='return false;'>";
		//sHtml1+="<input type='hidden' name='search_gubun' id='search_gubun' value='job_name' />";
		sHtml1+="<table style='width:100%;height:560px;;border:none;'><tr><td style='vertical-align:top;height:100%;width:500px;'>";
		//sHtml1+="날짜검색 : <input type='text' name='cur_date' id='cur_date' class='input datepick' onkeydown='return false;' readonly />&nbsp;&nbsp;<span id='btn_arg_search'>검색</span>";
		//sHtml1+="변수명 <input type='text' name='arg_eng_nm' id='arg_eng_nm' />&nbsp;&nbsp;<span id='btn_arg_search'>검색</span>";
		sHtml1+="변수명 : <input type='text' name='arg_eng_nm' id='arg_eng_nm' />&nbsp;&nbsp;날짜검색 : <input type='text' name='cur_date' id='cur_date' class='input datepick' onkeydown='return false;' readonly />&nbsp;&nbsp;<span id='btn_arg_search'>검색</span>";
		sHtml1+="<table style='width:100%;height:100%;border:none;'>";
		sHtml1+="<tr><td id='ly_g_tmp1' style='vertical-align:top;' >";
		sHtml1+="<div id='g_tmp1' class='ui-widget-header ui-corner-all'></div>";
		sHtml1+="</td></tr>";
		sHtml1+="<tr style='height:10px;'><td style='vertical-align:top;'><h5 class='ui-widget-header ui-corner-all' >";
		sHtml1+="<div align='right' class='btn_area_s'>";
		sHtml1+="<div id='ly_total_cnt' style='padding-top:5px;float:left;'></div>";
		sHtml1+="</div>";
		sHtml1+="</h5></td></tr></table>";
		
		sHtml1+="</td></tr></table>";
		
		sHtml1+="</form>";
		
		$('#dl_tmp1').remove();
		$('body').append(sHtml1);
		
		dlPop01('dl_tmp1',"입력변수내역",570,600,false);
				
		var gridObj = {
			id : "g_tmp1"
			,colModel:[
		   		{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'번호',width:50,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}	   		
		   		,{formatter:gridCellNoneFormatter,field:'SCODE_ENG_NM',id:'SCODE_ENG_NM',name:'변수명',width:120,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
		   		,{formatter:gridCellNoneFormatter,field:'SCODE_DESC',id:'SCODE_DESC',name:'설명',width:160,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}	
		   		,{formatter:gridCellNoneFormatter,field:'ARG_VALUE',id:'ARG_VALUE',name:'변환데이터',width:150,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}	 
		   		,{formatter:gridCellNoneFormatter,field:'CHOICE',id:'CHOICE',name:'선택',width:50,headerCssClass:'cellCenter',cssClass:'cellCenter'}
		   		
		   		,{formatter:gridCellNoneFormatter,field:'SCODE_CD',id:'SCODE_CD',name:'SCODE_CD',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
		   		,{formatter:gridCellNoneFormatter,field:'SCODE_NM',id:'SCODE_NM',name:'SCODE_NM',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
		   	]
			,rows:[]
			,vscroll:<%=S_GRID_VSCROLL%>
		};
		
		viewGrid_1(gridObj,'ly_'+gridObj.id);
		//argList(flag);	
		
		var dt = $("#cur_date").val();
		var arg_eng_nm 	= $("#arg_eng_nm").val();
		argumentList(arg_eng_nm, dt, flag);
		
		$("#cur_date").addClass("ime_readonly").unbind('click').click(function(){
			dpCalMinMax(this.id,'yymmdd','-365','1');
		});
		
		$("#btn_arg_search").button().unbind("click").click(function(){
			var dt = $("#cur_date").val();
			var arg_eng_nm 	= $("#arg_eng_nm").val();
			argumentList(arg_eng_nm, dt, flag);
		});
	}
	
	function argumentList(arg_eng_nm, dt){
		
		try{viewProgBar(true);}catch(e){}
		$('#ly_total_cnt').html('');
		
		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=argumentList&itemGubun=2&mcode_cd=${ARGUMENT_MCODE_CD}&cur_date='+dt+'&arg_eng_nm='+arg_eng_nm;
		
		var xhr = new XHRHandler(url, null
				,function(){
					var xmlDoc = this.req.responseXML;
					if(xmlDoc==null){
						try{viewProgBar(false);}catch(e){}
						alert('세션이 만료되었습니다 다시 로그인해 주세요');
						return false;
					}
					if($(xmlDoc).find('doc').length == 0 && $(xmlDoc).find('error').length > 0){
						try{viewProgBar(false);}catch(e){}
						alert($(xmlDoc).find('msg_code').text());
						//goCommonError('<%=sContextPath %>','_self',$(xmlDoc).find('msg_code').text());
						return false;
					}
					
					$(xmlDoc).find('doc').each(function(){
						
						var items = $(this).find('items');
						var rowsObj = new Array();
											
						if(items.attr('cnt')=='0'){						
						}else{							
							
							items.find('item').each(function(i){						
								
								var scode_cd = $(this).find("SCODE_CD").text();
								var scode_nm = $(this).find("SCODE_NM").text();								
								var scode_eng_nm = $(this).find("SCODE_ENG_NM").text();	
								var scode_desc = $(this).find("SCODE_DESC").text();
								var arg_value = $(this).find("ARG_VALUE").text();
								var use_yn = $(this).find("USE_YN").text();
								var choice = "";
								
								scode_eng_nm = scode_eng_nm.substring(2, scode_eng_nm.length);
								
								if(use_yn == "Y"){
									choice = "<div><a href=\"javascript:goSelectCommand('"+scode_nm+"','"+scode_eng_nm+"');\" ><font color='red'>[선택]</font></a></div>";
								}else{
									choice = "";
								}
								
								rowsObj.push({
									'grid_idx':i+1									
									,'SCODE_CD': scode_cd
									,'SCODE_NM': scode_nm
									,'SCODE_ENG_NM': scode_eng_nm
									,'SCODE_DESC': scode_desc	
									,'ARG_VALUE': arg_value
									,'CHOICE': choice
								});
								
							});		
						}						
					
						var obj = $("#g_tmp1").data('gridObj');
						obj.rows = rowsObj;
						setGridRows(obj);
						
						$('#ly_total_cnt').html('[ TOTAL : '+items.attr('cnt')+' ]');
						
					});
					try{viewProgBar(false);}catch(e){}
				}
		
		, null );
		
		xhr.sendRequest();
	}	
	
	//입력변수 가져오기
	function argList(flag){
		
		try{viewProgBar(true);}catch(e){}
		$('#ly_total_cnt').html('');
		
		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=sCodeList&mcode_cd=${ARGUMENT_MCODE_CD}&host_eng_nm=N';
		
		var xhr = new XHRHandler(url, null
				,function(){
					var xmlDoc = this.req.responseXML;
					if(xmlDoc==null){
						try{viewProgBar(false);}catch(e){}
						alert('세션이 만료되었습니다 다시 로그인해 주세요');
						return false;
					}
					if($(xmlDoc).find('doc').length == 0 && $(xmlDoc).find('error').length > 0){
						try{viewProgBar(false);}catch(e){}
						alert($(xmlDoc).find('msg_code').text());
						//goCommonError('<%=sContextPath %>','_self',$(xmlDoc).find('msg_code').text());
						return false;
					}
					//변수 값 세팅 -- set
					
					if(flag == "parm"){
						$(xmlDoc).find('doc').each(function(){
							
						var items = $(this).find('items');
						var rowsObj = new Array();
						
						var scode_eng_nm0 = "<div class='gridInput_area'><input type='text' name='scode_eng_nm0' id='scode_eng_nm0' style='width:100%;'/></div>";
						var scode_desc0 = "<div class='gridInput_area'><input type='text' name='scode_desc0' id='scode_desc0' style='width:100%;'/></div>";
						var v_scode_eng_nm = $("#scode_eng_nm0").val();
						var v_scode_desc = $("#scode_desc0").val();
							
						rowsObj.push({
							'grid_idx':""							
							,'SCODE_CD': ""
							,'SCODE_NM': ""
							,'SCODE_ENG_NM': scode_eng_nm0
							,'SCODE_DESC': scode_desc0
							,'CHOICE':"<div><a href=\"javascript:goSelect4();\" ><font color='red'>[선택]</font></a></div>"
						});
							
						if(items.attr('cnt')=='0'){						
						}else{							
							items.find('item').each(function(i){						
								
								var scode_cd = $(this).find("SCODE_CD").text();
								var scode_nm = $(this).find("SCODE_NM").text();								
								var scode_eng_nm = $(this).find("SCODE_ENG_NM").text();	
								var scode_desc = $(this).find("SCODE_DESC").text();
								
								rowsObj.push({
									'grid_idx':i+1									
									,'SCODE_CD': scode_cd
									,'SCODE_NM': scode_nm
									,'SCODE_ENG_NM': scode_eng_nm
									,'SCODE_DESC': scode_desc	
									,'CHOICE':"<div><a href=\"javascript:goSelect2('"+scode_nm+"','"+scode_eng_nm+"');\" ><font color='red'>[선택]</font></a></div>"
								});
								
							});		
						}
					
						
						var obj = $("#g_tmp1").data('gridObj');
						obj.rows = rowsObj;
						setGridRows(obj);
						
						$('#ly_total_cnt').html('[ TOTAL : '+items.attr('cnt')+' ]');
						
					});
					try{viewProgBar(false);}catch(e){}
					
				//Argument 값 세팅 -- command
				}else if(flag == "argmt"){
					
					$(xmlDoc).find('doc').each(function(){
						
						var items = $(this).find('items');
						var rowsObj = new Array();
											
						if(items.attr('cnt')=='0'){						
						}else{							
							items.find('item').each(function(i){						
								
								var scode_cd = $(this).find("SCODE_CD").text();
								var scode_nm = $(this).find("SCODE_NM").text();								
								var scode_eng_nm = $(this).find("SCODE_ENG_NM").text();	
								var scode_desc = $(this).find("SCODE_DESC").text();
								
								scode_eng_nm = scode_eng_nm.substring(2, scode_eng_nm.length);
								
								rowsObj.push({
									'grid_idx':i+1									
									,'SCODE_CD': scode_cd
									,'SCODE_NM': scode_nm
									,'SCODE_ENG_NM': scode_eng_nm
									,'SCODE_DESC': scode_desc	
									,'CHOICE':"<div><a href=\"javascript:goSelectCommand('"+scode_nm+"','"+scode_eng_nm+"');\" ><font color='red'>[선택]</font></a></div>"
								});
								
							});		
						}						
					
						var obj = $("#g_tmp1").data('gridObj');
						obj.rows = rowsObj;
						setGridRows(obj);
						
						$('#ly_total_cnt').html('[ TOTAL : '+items.attr('cnt')+' ]');
						
					});
					try{viewProgBar(false);}catch(e){}
				}
			}
		, null );
		
		xhr.sendRequest();
	}
	
	
	//변수 입력 받는 TEXT select 박스
	function goSelect4(){
		var scode_eng_nm = $("#scode_eng_nm0").val();
		var scode_desc = $("#scode_desc0").val();	
		
		if(scode_eng_nm != "" && scode_desc != ""){
			goSelect2(scode_eng_nm, scode_desc);
			
			//선택버튼 클릭 후 값 초기화
			$("#scode_eng_nm0").val("");
			$("#scode_desc0").val("");
						
			dlClose('dl_tmp1');
		}else{
			alert("변수명 또는 설명을 입력하세요.");
			
			//선택버튼 클릭 후 값 초기화
			$("#scode_eng_nm0").val("");
			$("#scode_desc0").val("");			
						
			return;
		}
				
	}	
		
	function goSelect2(nm, desc){
				
		var arg_var = $("#arg_var").val();
		var arg_val = $("#arg_val").val();	
		var arg_code = $("#arg_code").val();
		
		var dup_cnt = 0;
		var lst_arg_val = "";
		var desc2 = desc.replace("º","%");
		
		if(arg_var == ""){
			arg_var += desc2;	
			arg_code += nm;
			
			$("#arg_var").val(arg_var);
			$("#arg_code").val(arg_code);
			
			lst_arg_val = nm+","+desc2;
			arg_val += lst_arg_val;
			$("#arg_val").val(arg_val);
			
		}else{			
			var arr_arg_code = arg_code.split(",");
						
			for(var i in arr_arg_code){
				if(nm == arr_arg_code[i]){
					++dup_cnt;
				}
			}
						
			if(dup_cnt == 0){
				arg_var += ","+desc2;
				arg_code += ","+nm;
				
				$("#arg_var").val(arg_var);
				$("#arg_code").val(arg_code);
				
				lst_arg_val = nm+","+desc2;
				
				if(arg_val == ""){
					arg_val += lst_arg_val;
				}else{
					arg_val += "|"+lst_arg_val;
				}				
			
				$("#arg_val").val(arg_val);
			}else{
				alert("이미 추가된 항목 입니다.");
				return;
			}
		}				
	}
	
	
	function goSelectCommand(nm, desc){
		
		var command = $("#command").val();
		var arg_val = $("#arg_val").val();
		 
		
		var lst_command = "";
		//var desc2 = desc.replace("º","%");
		var desc2 = "%%" + desc;
			$("#command").val(command);
			lst_command = " " + desc2;
			command += lst_command;
			$("#command").val(command);
			$("#arg_val").val(arg_val + " " + desc2);
			
		dlClose('dl_tmp1');
			
	}

	
	

	function getArgDel(){
		$("#arg_var").val("");
		$("#arg_val").val("");
		$("#arg_code").val("");
	}
	
	
	//캘린더 팝업	
	function popSchedForm(){
		
		var sHtml1="<div id='dl_tmp1' style='overflow:hidden;display:none;padding:0;'>";
		sHtml1+="<form id='form1' name='form1' method='post' onsubmit='return false;'>";
		sHtml1+="<input type='hidden' name='search_gubun' id='search_gubun' value='job_name' />";
		sHtml1+="<table style='width:100%;height:320px;;border:none;'><tr><td style='vertical-align:top;height:100%;width:500px;'>";
		sHtml1+="<table style='width:100%'><tr><td style='text-align:right;'>";
		sHtml1+="<b>캘린더명</b>&nbsp;:&nbsp;<input type='text' name='cal_text' id='cal_text' style='height:21px;' />&nbsp;&nbsp;<span id='btn_cal_search'>검색</span>";
		sHtml1+="</td></tr></table>";
		sHtml1+="<table style='width:100%;height:100%;border:none;'>";
		sHtml1+="<tr><td id='ly_g_tmp1' style='vertical-align:top;' >";
		sHtml1+="<div id='g_tmp1' class='ui-widget-header ui-corner-all'></div>";
		sHtml1+="</td></tr>";
		sHtml1+="<tr style='height:10px;'><td style='vertical-align:top;'><h5 class='ui-widget-header ui-corner-all' >";
		sHtml1+="<div align='right' class='btn_area_s'>";
		sHtml1+="<div id='ly_total_cnt_1' style='padding-top:5px;float:left;'></div>";
		sHtml1+="</div>";
		sHtml1+="</h5></td></tr></table>";
		
		sHtml1+="</td></tr></table>";
		
		sHtml1+="</form>";
		
		$('#dl_tmp1').remove();
		$('body').append(sHtml1);
		
		dlPop01('dl_tmp1',"캘린더",900,360,false);
				
		var gridObj = {
			id : "g_tmp1"
			,colModel:[
		   		{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'번호',width:50,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
		   		,{formatter:gridCellNoneFormatter,field:'CHOICE',id:'CHOICE',name:'선택',width:60,headerCssClass:'cellCenter',cssClass:'cellCenter'}
		   		,{formatter:gridCellNoneFormatter,field:'CAL_NM',id:'CAL_NM',name:'캘린더명',width:150,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}	 
		   		,{formatter:gridCellNoneFormatter,field:'DAYS_CAL',id:'DAYS_CAL',name:'월달력',width:100,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}	 	 
		   		,{formatter:gridCellNoneFormatter,field:'DAYS_AND_OR',id:'DAYS_AND_OR',name:'조건',width:60,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}	   		
		   		,{formatter:gridCellNoneFormatter,field:'WEEKS_CAL',id:'WEEKS_CAL',name:'주간달력',width:100,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
		   		,{formatter:gridCellNoneFormatter,field:'USE_GB',id:'USE_GB',name:'구분',width:60,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
		   		,{formatter:gridCellNoneFormatter,field:'USE_YN',id:'USE_YN',name:'사용여부',width:60,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
		   		,{formatter:gridCellNoneFormatter,field:'CONF_CAL',id:'CONF_CAL',name:'승인달력',width:100,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
		   		,{formatter:gridCellNoneFormatter,field:'SHIFT',id:'SHIFT',name:'이동형태',width:80,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
		   		,{formatter:gridCellNoneFormatter,field:'SHIFT_NUM',id:'SHIFT_NUM',name:'이동수치',width:60,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}		   		
		   		   		
		   		,{formatter:gridCellNoneFormatter,field:'CAL_CD',id:'CAL_CD',name:'CAL_CD',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
		   	]
			,rows:[]
			,vscroll:<%=S_GRID_VSCROLL%>
		};
		
		viewGrid_1(gridObj,'ly_'+gridObj.id);
		popSchedList('');
		
		$('#cal_text').placeholder().unbind('keypress').keypress(function(e){
			if(e.keyCode==13){
				popSchedList($(this).val());
			}
		});		
		
		$("#btn_cal_search").button().unbind("click").click(function(){
			
			var search_text = $("#form1").find("input[name='cal_text']").val();
			popSchedList(search_text);
		});
		
	}
	
	function popSchedList(search_text){
		
		try{viewProgBar(true);}catch(e){}
		$('#ly_total_cnt_1').html('');
		
		var data_center = $("#data_center").val();
		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=calCodeList2&itemGubun=2&data_center='+data_center+'&cal_text='+encodeURIComponent(search_text);
		
		var xhr = new XHRHandler(url, null
				,function(){
					var xmlDoc = this.req.responseXML;
					if(xmlDoc==null){
						try{viewProgBar(false);}catch(e){}
						alert('세션이 만료되었습니다 다시 로그인해 주세요');
						return false;
					}
					if($(xmlDoc).find('doc').length == 0 && $(xmlDoc).find('error').length > 0){
						try{viewProgBar(false);}catch(e){}
						alert($(xmlDoc).find('msg_code').text());
						//goCommonError('<%=sContextPath %>','_self',$(xmlDoc).find('msg_code').text());
						return false;
					}
					$(xmlDoc).find('doc').each(function(){
						
						var items = $(this).find('items');
						var rowsObj = new Array();
						
						if(items.attr('cnt')=='0'){
						}else{
							items.find('item').each(function(i){						
															
								var cal_cd = $(this).find("CAL_CD").text();
								var cal_nm = $(this).find("CAL_NM").text();
								var days_cal = $(this).find("DAYS_CAL").text();
								var days_and_or = $(this).find("DAYS_AND_OR").text();
								var weeks_cal = $(this).find("WEEKS_CAL").text();
								var week_days = $(this).find("WEEK_DAYS").text();
								var use_gb = $(this).find("USE_GB").text();
								var use_yn = $(this).find("USE_YN").text();
								var month_cal = $(this).find("MONTH_CAL").text();
								var month_days = $(this).find("MONTH_DAYS").text();
								var conf_cal = $(this).find("CONF_CAL").text();						
								var shift = $(this).find("SHIFT").text();
								var shift_num = $(this).find("SHIFT_NUM").text();
								
								var v_days_and_or = "";
								var v_use_yn = "";
								var v_use_gb = "";
								
								if(days_and_or == "A"){
									v_days_and_or = "AND";
								}else if(days_and_or == "O"){
									v_days_and_or = "OR";
								}
								
								if(use_yn == "Y"){
									v_use_yn = "사용";
								}else if(use_yn = "N"){
									v_use_yn = "미사용";
								}
								
								for(var j=0;j<arr_caluse_gb_cd.length;j++){
									if(use_gb == arr_caluse_gb_cd[j].cd){
										v_use_gb = arr_caluse_gb_nm[j].nm;
									}
								}
								rowsObj.push({
									'grid_idx':i+1
									,'CAL_CD': cal_cd
									,'CAL_NM': cal_nm
									,'DAYS_CAL': days_cal
									,'DAYS_AND_OR': v_days_and_or
									,'WEEKS_CAL': weeks_cal
									,'USE_GB': v_use_gb
									,'CONF_CAL': conf_cal
									,'SHIFT': shift
									,'SHIFT_NUM': shift_num								
									,'CHOICE':"<div><a href=\"javascript:goSelect3('"+cal_nm+"','"+days_cal+"','"+days_and_or+"','"+weeks_cal+"','"+month_cal+"','"+week_days+"','"+month_days+"','"+conf_cal+"','"+shift+"','"+shift_num+"');\" ><font color='red'>[선택]</font></a></div>"
								});
							});						
						}
						
						var obj = $("#g_tmp1").data('gridObj');
						obj.rows = rowsObj;
						setGridRows(obj);
						
						$('#ly_total_cnt_1').html('[ TOTAL : '+items.attr('cnt')+' ]');
						
					});
					try{viewProgBar(false);}catch(e){}
				}
		, null );
		
		xhr.sendRequest();
	}
	
	function goSelect3(cal_nm, days_cal, days_and_or, weeks_cal, month_cal, week_days, month_days,conf_cal,shift,shift_num){
		
		$("#cal_nm").val(cal_nm);
		$("#days_cal").val(days_cal);
		$("#days_and_or").val(days_and_or);
		$("#month_days").val(month_days);
		
		if(days_and_or != null){
			if(days_and_or == 'A'){
				$("#schedule_and_or").val("1");				 
			}else{
				$("#schedule_and_or").val("0");
			}
		}
		
		$("#weeks_cal").val(weeks_cal);
		$("#month_cal").val(month_cal);
	
		
		$("#week_days").val(week_days);
		$("#shift").val(shift);
		$("#shift_num").val(shift_num);
		$("#conf_cal").val(conf_cal);
		
		
		if(month_cal != null){
			
			sTmp = month_cal.split(",");
			$("#month_1").val(sTmp[0]);
			$("#month_2").val(sTmp[1]);
			$("#month_3").val(sTmp[2]);
			$("#month_4").val(sTmp[3]);
			$("#month_5").val(sTmp[4]);
			$("#month_6").val(sTmp[5]);
			$("#month_7").val(sTmp[6]);
			$("#month_8").val(sTmp[7]);
			$("#month_9").val(sTmp[8]);
			$("#month_10").val(sTmp[9]);
			$("#month_11").val(sTmp[10]);
			$("#month_12").val(sTmp[11]);
			
			
			var monthTemp = "";
			var month_data = "";
			for(var i=0; i<sTmp.length; i++){
				
				if(i>0) monthTemp += ",";
				if(sTmp[i] == "1"){
					monthTemp += (i+1);
				}
				
			}		
			$("#month_data").val(monthTemp);
		}
		
		
		
		
		dlClose('dl_tmp1');
	}
	
	function fn_sch_forecast() {

		var frm = document.frm1;		
		
		/*
		var data_center = $("#data_center").val();
		
		if(data_center == ""){
			alert("시스템을 입력하세요"); return;
		}
		*/
		
		var obj = null;
		var s = "";

		var week_days = $("#week_days").val();
			
		s += week_days;
		
		frm.week_days.value = s;

		//-- 작업스케줄 체크 Start. --//
		
		var month_days = $("#month_days").val();
		var days_cal   = $("#days_cal").val();
		var week_days  = $("#week_days").val();
		var weeks_cal  = $("#weeks_cal").val();
		
		var shift  	   = $("#shift").val();
		var shift_num  = $("#shift_num").val();
		var conf_cal   = $("#conf_cal").val();
		
		//-- 작업스케줄 체크 End. --//
				
		openPopupCenter2("about:blank", "fn_sch_forecast", 1000, 500);
		
		frm.action = "<%=sContextPath %>/tWorks.ez?c=ez033";
		frm.target = "fn_sch_forecast";
		frm.submit();
	}

	function selectTable(eng_nm, desc, user_daily){
		
		$("#table_nm").val(eng_nm);
		$("#table_of_def").val(eng_nm);
		$("#table_name").val(eng_nm);
		$("#user_daily").val(user_daily);
		
		$("input[name='application']").val("");
		$("input[name='group_name']").val("");
		
		dlClose("dl_tmp1");

		//어플리케이션을 검색	
		getAppGrpCodeList("", "2", "", "application_of_def", eng_nm);
		//그룹 초기화
// 		getAppGrpCodeList("", "3", "", "group_name_of_def", "_");
		$("select[name='group_name_of_def'] option").remove();
		$("select[name='group_name_of_def']").append("<option value=''>--선택--</option>");
	}
		
	/* function selectApplication(eng_nm, desc){
	
		$("#app_nm").val(desc);
		$("#application_of_def").val(eng_nm);
		$("#application").val(eng_nm);
		
		$("#s_job_name").val(eng_nm.substring(0,1));
		
		$("select[name='sJobTypeGb']").val("");
		$("select[name='group_name']").val("");
		
		dlClose("dl_tmp1");
	
		//그룹을 검색		
		getAppGrpCodeList("", "2", "", "group_name_of_def",eng_nm);
		
	} */
	
	//APP/GRP 가져오기
	function getAppGrpCodeList(scode_cd, depth, grp_cd, val, eng_nm){
		
		try{viewProgBar(true);}catch(e){}
		
		if(eng_nm == "") {
			eng_nm = '_';
		}
		
		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=appGrpCodeList&itemGubun=2&p_scode_cd='+scode_cd+'&p_app_eng_nm='+encodeURIComponent(eng_nm)+'&p_grp_depth='+depth+'&p_grp_cd='+grp_cd;
						
		var xhr = new XHRHandler(url, null
				,function(){
					var xmlDoc = this.req.responseXML;
					if(xmlDoc==null){
						try{viewProgBar(false);}catch(e){}
						alert('세션이 만료되었습니다 다시 로그인해 주세요');
						return false;
					}
					if($(xmlDoc).find('doc').length == 0 && $(xmlDoc).find('error').length > 0){
						try{viewProgBar(false);}catch(e){}
						alert($(xmlDoc).find('msg_code').text());
						//goCommonError('<%=sContextPath %>','_self',$(xmlDoc).find('msg_code').text());
						return false;
					}
					$(xmlDoc).find('doc').each(function(){
						
						var items = $(this).find('items');
						var rowsObj = new Array();
												
						if(items.attr('cnt')=='0'){
							$("select[name='"+val+"'] option").remove();
							$("select[name='"+val+"']").append("<option value=''>--선택--</option>");							
						}else{
							$("select[name='"+val+"'] option").remove();
							$("select[name='"+val+"']").append("<option value=''>--선택--</option>");			
							
							items.find('item').each(function(i){						
							
								var grp_cd = $(this).find("GRP_CD").text();
								var grp_nm = $(this).find("GRP_NM").text();	
								var grp_desc = $(this).find("GRP_DESC").text();	
								var grp_eng_nm = $(this).find("GRP_ENG_NM").text();
								var arr_grp_cd = grp_cd+","+grp_eng_nm;
																																																								
								$("select[name='"+val+"']").append("<option value='"+grp_eng_nm+"'>"+grp_desc+"</option>");
								
							});						
						}									
						
					});
					try{viewProgBar(false);}catch(e){}
				}
		, null );
		
		xhr.sendRequest();
	}

	function btnShow(doc_cd){
		//alert(doc_cd);
		$("#doc_cd").val(doc_cd);
		
		$("#btn_ins").hide();
		$("#btn_draft").hide();
		if ( server_gb == "D" || server_gb == "T" || session_user_gb == "99" ) {
			$("#btn_draft_admin").show();
		}
	}
	
	//서버내역 가져오기
	function mHostList(grp_nm){		
	
		try{viewProgBar(true);}catch(e){}
				
		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=mHostList&itemGubun=2';
		
		var xhr = new XHRHandler(url, null
				,function(){
					var xmlDoc = this.req.responseXML;
					if(xmlDoc==null){
						try{viewProgBar(false);}catch(e){}
						alert('세션이 만료되었습니다 다시 로그인해 주세요');
						return false;
					}
					if($(xmlDoc).find('doc').length == 0 && $(xmlDoc).find('error').length > 0){
						try{viewProgBar(false);}catch(e){}
						alert($(xmlDoc).find('msg_code').text());
						//goCommonError('<%=sContextPath %>','_self',$(xmlDoc).find('msg_code').text());
						return false;
					}
					$(xmlDoc).find('doc').each(function(){
						
						var items = $(this).find('items');
						var rowsObj = new Array();
						
						if(items.attr('cnt')=='0'){
							$("select[name='host_id'] option").remove();
							$("select[name='host_id']").append("<option value=''>--선택--</option>");	
						}else{
							$("select[name='host_id'] option").remove();
							$("select[name='host_id']").append("<option value=''>--선택--</option>");	
							
							items.find('item').each(function(i){						
							
								var host_cd = $(this).find("HOST_CD").text();								
								var node_id = $(this).find("NODE_ID").text();
								var node_nm = $(this).find("NODE_NM").text();
								
								var all_cd = host_cd+","+node_id;
								var all_nm = node_nm+"("+node_id+")";
																
								$("select[name='host_id']").append("<option value='"+node_id+"'>"+all_nm+"</option>");
																
							});						
						}
												
					});
					try{viewProgBar(false);}catch(e){}
				}
		, null );
		
		xhr.sendRequest();
	}
	
	function goPrc(flag) {
		
		var frm = document.frm1;
		
		var serverGb 			= '<%=strServerGb%>';
		var state_cd 			= '<%=state_cd%>';
		frm.flag.value 			= flag;
		frm.systemGb.value 		= frm.sSystemGb.value;
		frm.jobTypeGb.value 	= frm.sJobTypeGb.value;
		frm.application.value 	= frm.table_name.value;
		frm.group_name.value 	= frm.table_name.value;
		
		if(flag!="del"){
		
			// 담당자 체크 
			// SMS, 오토콜 중 한개는 필수
// 			checkUserInfo();	//2024.02.26 최호연 담당자 SMS,MAIL 체크로직 제거			
		
			isValid_C_M();
			
			if ( document.getElementById('is_valid_flag').value == "false" ) {
				document.getElementById('is_valid_flag').value = "" 
				return;
			}
		
			
			if( isNullInput(document.getElementById('title'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[의뢰사유]","") %>') ) return;		
			if( isNullInput(document.getElementById('sSystemGb'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[시스템구분]","") %>') ) return;
			if( isNullInput(document.getElementById('sJobTypeGb'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[작업유형구분]","") %>') ) return;
			if( isNullInput(document.getElementById('table_name'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[테이블]","") %>') ) return;
<%-- 			if( isNullInput(document.getElementById('application'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[어플리케이션]","") %>') ) return;		 --%>
<%-- 			if( isNullInput(document.getElementById('group_name_of_def'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[그룹]","") %>') ) return; --%>
			if( isNullInput(document.getElementById('host_id'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[수행서버]","") %>') ) return;
			if( isNullInput(document.getElementById('owner'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[계정명]","") %>') ) return;
			if( isNullInput(document.getElementById('task_type'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[작업타입]","") %>') ) return;
			
			if( isNullInput(document.getElementById('mem_lib'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[프로그램 위치]","") %>') ) return;
			if( isNullInput(document.getElementById('command'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[작업수행명령]","") %>') ) return;
			
			var mem_lib_val = $("#mem_lib").val();
			var mem_lib_f_chk = false;
			var mem_lib_l_chk = false;
			
			if ( mem_lib_val != "" ) {
				if ( mem_lib_val.substring(0, 1) == "/" ) {
					mem_lib_f_chk = true;
				}
				if ( mem_lib_val.length > 3 && mem_lib_val.substring(3, 2) == "\\" ) {
					mem_lib_f_chk = true;				
				}
			}
			
			if ( mem_lib_val != "" ) {
				if ( mem_lib_val.substring(mem_lib_val.length-1, mem_lib_val.length) == "/" ) {
					mem_lib_l_chk = true;
				}
				if ( mem_lib_val.length > 3 && mem_lib_val.substring(mem_lib_val.length-2, mem_lib_val.length) == "\\\\" ) {
					mem_lib_l_chk = true;				
				}
			}
			
			if(!mem_lib_f_chk) {
				alert("프로그램 위치는 절대 경로로 입력 해야 합니다. 시작글자(/,C:\\)");
				return;
			}
			
			if(!mem_lib_l_chk) {
				alert("프로그램 위치의 마지막은 / 혹은 \\\\ 로 끝나야 합니다.");
				return;
			}
			
			if( isNullInput(document.getElementById('mem_name'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[프로그램 명]","") %>') ) return;		
			if( isNullInput(document.getElementById('job_name'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[작업명]","") %>') ) return;
<%-- 			if( isNullInput(document.getElementById('description'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[작업 설명]","") %>') ) return; --%>
					
			if($("#cyclic").val() == "1"){
				
				if ( $("#frm1").find("select[name='eHour']").val() == "" && $("#frm1").find("select[name='eMin']").val() == "" ) {
					alert("반복작업은 종료시간을 입력해 주세요.");
					return;
				}
				
				// 반복작업이면 1분 이상.
				if ( frm.rerun_interval.value == "" && frm.interval_sequence.value == "" && frm.specific_times.value == "" ) {
					alert("반복옵션을 설정해 주세요.");
					return;
				}
			
				if ( frm.cyclic_type.value == "C" && frm.rerun_interval.value != "" ) {
					if ( replaceAll(frm.rerun_interval.value, "0", "") == "" ) {
						alert("반복주기를 확인해 주세요.");
						return;
					}
				}
				
			} else if($("#cyclic").val() == "0" && ($("#frm1").find("select[name='eHour']").val() == "" && $("#frm1").find("select[name='eMin']").val() == "") ) {
			
				$("#time_until").val(">");
			}

			if( $("#late_exec").val() == "0" ) {				
				alert("수행 임계시간은 1분 이상이어야 합니다.");
				return;			
			}
			
			if($("#time_from").val() != ''){
				if($("#time_from").val().length < 4){
					alert("작업시작시간의 시, 분을 확인해주세요.");
					return;
				}
			}
			
			
			if($("#time_until").val() != '' && $("#time_until").val() != ">"){
				if($("#time_until").val().length < 4){
					alert("작업종료시간의 시, 분을 확인해주세요.");
					return;	
				}
			}
			
			if($("#late_sub").val() != ''){
				if($("#late_sub").val().length < 4){
					alert("시작임계시간의 시, 분을 확인해주세요..");
					return;
				}
			}
			
			if($("#late_time").val() != ''){
				if($("#late_time").val().length < 4){
					alert("종료임계시간의 시, 분을 확인해주세요.");
					return;
				}
			}
			
			var time_from_t = parseInt($("#time_from").val());
			var late_time_t = parseInt($("#late_time").val());
			var late_sub_t = parseInt($("#late_sub").val());		
			
			//if($("#time_group").val() == "00"){
				//alert("시작시간을 입력하세요");
			//}
			
			if( $("#late_sub").val() != "" ){
				if(time_from_t > late_sub_t){
					alert("시작 임계시간은 시작시간보다 큰 값을 입력 해야 합니다.");
					return;
				}
			}
		
			if( $("#late_time").val() != ""){
				if(time_from_t > late_time_t){
					alert("종료 임계시간은 시작시간보다 큰 값을 입력 해야 합니다.");
					return;
				}
			}
			
			if($("#late_sub").val() != "" && $("#late_time").val() != ""){
				if($("#late_sub").val() > $("#late_time").val()){
					alert("종료 임계시간은 시작임계시간보다 큰 값을 입력 해야 합니다.");
					return;
				}
			}
			
			if( isNullInput(document.getElementById('author'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[담당자]","") %>') ) return;
			if( isNullInput(document.getElementById('critical_yn'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[중요작업]","") %>') ) return;		
			if(state_cd != '00'){
// 				if($("#job_nameChk").val() == "0"){
// 					alert("작업명의 확인을 눌러 주세요 [중복체크 , 후행컨디션 세팅]");
// 					return;
// 				}
			}
			
			var all_data = "";
			var job_nm = "";
			var cond_dt = "";
			var cond_gb = "";
			setGridSelectedRowsAll(gridObj_1);			
			var aSelRow = new Array;
			aSelRow = $('#'+gridObj_1.id).data('grid').getSelectedRows();
			
			if(aSelRow.length > 0){
				for(var i=0;i<aSelRow.length;i++){
									
				
					job_nm = getCellValue(gridObj_1,aSelRow[i],"m_in_condition_name");
					cond_dt = getCellValue(gridObj_1,aSelRow[i],"m_in_condition_date");
					cond_gb = getCellValue(gridObj_1,aSelRow[i],"m_in_condition_and_or");
					
					if(i>0) all_data += "|";				
					all_data += job_nm +","+ cond_dt +","+ cond_gb;			
				}
			}
			
			clearGridSelected(gridObj_1);		
			frm.t_conditions_in.value = all_data;		
			
			var first_job_name = "";
			all_data = "";
			setGridSelectedRowsAll(gridObj_2);			
			var aSelRow = new Array;
			aSelRow = $('#'+gridObj_2.id).data('grid').getSelectedRows();
			
			if(aSelRow.length > 0){
				for(var i=0;i<aSelRow.length;i++){
					
					grid_idx = getCellValue(gridObj_2,aSelRow[i],"grid_idx");
					job_nm = getCellValue(gridObj_2,aSelRow[i],"m_out_condition_name");
					
					if(grid_idx == 1) first_job_name = job_nm;
					
					cond_dt = getCellValue(gridObj_2,aSelRow[i],"m_out_condition_date");
					cond_gb = getCellValue(gridObj_2,aSelRow[i],"m_out_condition_effect");
					
					if(i>0) all_data += "|";				
					all_data += job_nm +","+ cond_dt +","+ cond_gb;			
				}
			}
			
			clearGridSelected(gridObj_2);		
			frm.t_conditions_out.value = all_data;
								
			// 작업명 수정 후 확인 버튼을 클릭 하지 않으면 후행 조건이 동기화 안됨
			if($("#job_name").val() != first_job_name){
				alert("작업명의 확인버튼을 다시 클릭하세요.");
				return;
			}
			
			s = "";
			
			var task_type 	= $("#task_type").val(); 
			var mem_name 	= $("#mem_name").val();
			var mem_lib 	= $("#mem_lib").val();
			
			var file_nm 	= mem_lib + mem_name;
			
			obj = document.getElementsByName('m_var_name');
			if( obj!=null && obj.length>0 ){
				for( var i=0; i<obj.length; i++ ){
					if( trim(obj[i].value) != "" ){
						var sTmp = obj[i].value;					
						sTmp += (","+document.getElementsByName('m_var_value')[i].value);

						if ( document.getElementsByName('m_var_value')[i].value == "" ) {
							//alert("[변수]의 Value를 확인해 주세요.");
							//return;
						}
						
						s += (s=="")? sTmp:("|"+sTmp);
					}
				}
				frm.t_set.value = s;
			}
			var t_set_var 	= $("#t_set").val();
			
			s = "";
			var v = 0;
			obj = document.getElementsByName('m_step_opt');
			if( obj!=null && obj.length>0 ){
				for( var i=0; i<obj.length; i++ ){
					if( trim(obj[i].value) != "" ){
						var sTmp = obj[i].value;
						
						if(sTmp == 'O'){
							sTmp = sTmp+',Statement'+',*';
						}
						
						sTmp += (","+document.getElementsByName('m_step_type')[i].value);
						
						var step_type = document.getElementsByName('m_step_type')[i].value;
						
						if(step_type == 'COMPSTAT' || step_type == 'RUNCOUNT' || step_type == 'FAILCOUNT'){
							v = $('div[id^=div_step_parameters]').eq(i).prop('id').replace('div_step_parameters','');
							
							if(step_type != 'FAILCOUNT'){
								if( isNullInput(document.getElementById('m_step_statement_stmt'+v),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[Stmt]","") %>') ) return;
								var statement_stmt = document.getElementById('m_step_statement_stmt'+v).value;
							}
							
							if(statement_stmt == 'EVEN' || statement_stmt == 'ODD'){
								sTmp += (" EQ "+document.getElementById('m_step_statement_stmt'+v).value);
							}else{
								
								if( isNullInput(document.getElementById('m_step_statement_code'+v),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[Code]","") %>') ) return;
								if(step_type == 'COMPSTAT'){
									sTmp += (" "+document.getElementById('m_step_statement_stmt'+v).value+" "+document.getElementById('m_step_statement_code'+v).value);	
								}else if(step_type == 'RUNCOUNT'){
									sTmp += (" "+document.getElementById('m_step_statement_stmt'+v).value+" "+document.getElementById('m_step_statement_code'+v).value);
								}else if(step_type == 'FAILCOUNT'){
									sTmp += (" EQ "+document.getElementById('m_step_statement_code'+v).value);
								}
							}
							
						}
						
						if( step_type == 'Condition' ){
							i = $('div[id^=div_step_parameters]').eq(i).prop('id').replace('div_step_parameters','');
							
							sTmp += (","+document.getElementById('m_step_condition_name'+i).value);
							sTmp += (","+document.getElementById('m_step_condition_date'+i).value);
							sTmp += (","+document.getElementById('m_step_condition_sign'+i).value);
						}else if( step_type == 'Shout' ){
							i = $('div[id^=div_step_parameters]').eq(i).prop('id').replace('div_step_parameters','');
							
							sTmp += (","+document.getElementById('m_step_dest'+i).value);
							sTmp += (",regular");
							sTmp += (","+document.getElementById('m_step_message'+i).value);
						}
						s += (s=="")? sTmp:("|"+sTmp);
					}
				}

				frm.t_steps.value = s;
			}
			
			if(frm.t_steps.value.indexOf("A,RERUN") > -1){
				if(confirm("ON/DO의 DO-재수행을 선택하면 최대 반복 횟수:99 권장입니다.\n설정하시겠습니까?\n\n(이후 최대 반복 횟수는 수동 설정해야 합니다.)")){
					$("#rerun_max").val("99");
				}
			}
			
			if(task_type == "job") {
				
				var monitor_time 		= $("#monitor_time").val();
				var monitor_interval 	= $("#monitor_interval").val();
				var filesize_comparison = $("#filesize_comparison").val();
				var num_of_iterations 	= $("#num_of_iterations").val();
				var stop_time 			= $("#stop_time").val();
				
				if( isNullInput(document.getElementById('monitor_time'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[모니터링 시간]","") %>') ) return;
				if( isNullInput(document.getElementById('monitor_interval'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[모니터링 주기]","") %>') ) return;
				if( isNullInput(document.getElementById('filesize_comparison'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[파일증감 체크주기]","") %>') ) return;
				if( isNullInput(document.getElementById('num_of_iterations'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[파일멈춤 체크횟수]","") %>') ) return;
				if( isNullInput(document.getElementById('stop_time'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[모니터링 종료시간]","") %>') ) return;
				
				if ( t_set_var != "" ) {
					t_set_var = t_set_var + "|";
				}
				
				t_set_var += 	"%%FileWatch-FILE_PATH,"+file_nm+"|%%FileWatch-MODE,CREATE|%%FileWatch-MIN_DET_SIZE,0B|%%FileWatch-INT_FILE_SEARCHES,"+monitor_interval+
								"|%%FileWatch-INT_FILESIZE_COMPARISON,"+filesize_comparison+"|%%FileWatch-NUM_OF_ITERATIONS,"+num_of_iterations+"|%%FileWatch-FILESIZE_WILDCARD,N|%%FileWatch-TIME_LIMIT,"+monitor_time+	
								"|%%FileWatch-START_TIME,NOW|%%FileWatch-STOP_TIME,"+stop_time+"|%%FileWatch-MIN_AGE,NO_MIN_AGE|%%FileWatch-MAX_AGE,NO_MAX_AGE";
				
				frm.t_set.value = t_set_var;				
			}
			
// 			document.getElementById('table_name').value =  document.getElementById('application').value + "_" + document.getElementById('time_group').value;
			
			// 인터페이스 작업에 대한 유효성 검증기능
			if(serverGb == "P"){
				checkIfName();
			}

			frm.doc_gb.value = '04';
		} else {
			frm.doc_gb.value = '03';
			frm.flag.value	 = 'draft_admin';
		}
			
		// 스마트테이블 여부 체크
		checkSmartTableCnt();
			
		//if( !confirm(document.getElementById('command').value + "로 작업이 만들어 집니다.\n처리하시겠습니까?") ) return;
		if( !confirm("처리하시겠습니까?") ) return;
		if(flag == "draft" || flag == "draft_admin"){
			if(serverGb == "P"){
				if ( document.getElementById('if_return').value != "" ) {
					alert("인터페이스 검증 에러 발생하였습니다.\n\n"+ document.getElementById('if_return').value);
					return;
				}
			}	
		}
		
		if ( document.getElementById('smart_cnt').value > 0 ) {
			if( !confirm("스마트 테이블 작업입니다.\n\n해당 작업은 스마트 테이블의 작업주기구분을 상속받습니다.") ) return;
		}
		
		// 오픈데일리 작업은 MAX_WAIT 99 설정
		if ( $("#cyclic").val() == "0" ) {
			$("#max_wait").val("<%=strDefaultMaxWait%>");
		}
		
		frm.job_name.value = frm.table_name.value;
		
		if ( flag == "draft_admin" || flag == "draft_admin" ) {
			if( !confirm("즉시반영[관리자결재] 하시겠습니까?") ) return;
		}else{
			if( !confirm("처리하시겠습니까?") ) return;
		}
		
		try{viewProgBar(true);}catch(e){}
		frm.target = "if1";
		frm.action = "<%=sContextPath%>/tWorks.ez?c=ez004_p";
		frm.submit();
	}

	function download(dt, job, file_gb, doc_cd, file_nm) {
		
		var f = document.frm_down;		
		
		f.flag.value 		= "job_doc01";
		f.file_gb.value 	= file_gb;
		f.data_center.value = dt;
		f.job_nm.value 		= job;
		f.doc_cd.value 		= doc_cd;
		
		f.target = "if1";				
		f.action = "<%=sContextPath %>/common.ez?c=fileDownload&file_nm=" + file_nm; 
		f.submit();	
	}
	
	
	function calList(){		
		
		try{viewProgBar(true);}catch(e){}
				
		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=searchItemList&itemGubun=2&searchType=days_calList';
		
		var xhr = new XHRHandler(url, null
				,function(){
					var xmlDoc = this.req.responseXML;
					if(xmlDoc==null){
						try{viewProgBar(false);}catch(e){}
						alert('세션이 만료되었습니다 다시 로그인해 주세요');
						return false;
					}
					if($(xmlDoc).find('doc').length == 0 && $(xmlDoc).find('error').length > 0){
						try{viewProgBar(false);}catch(e){}
						alert($(xmlDoc).find('msg_code').text());
						//goCommonError('<%=sContextPath %>','_self',$(xmlDoc).find('msg_code').text());
						return false;
					}
					$(xmlDoc).find('doc').each(function(){
						
						var items = $(this).find('items');
						var rowsObj = new Array();
						
						if(items.attr('cnt')=='0'){
							$("select[name='days_cal'] option").remove();
							$("select[name='days_cal']").append("<option value=''>--선택--</option>");	
							
							$("select[name='weeks_cal'] option").remove();
							$("select[name='weeks_cal']").append("<option value=''>--선택--</option>");	
							
							$("select[name='conf_cal'] option").remove();
							$("select[name='conf_cal']").append("<option value=''>--선택--</option>");	
						}else{
							$("select[name='days_cal'] option").remove();
							$("select[name='days_cal']").append("<option value=''>--선택--</option>");	
							
							$("select[name='weeks_cal'] option").remove();
							$("select[name='weeks_cal']").append("<option value=''>--선택--</option>");	
							
							$("select[name='conf_cal'] option").remove();
							$("select[name='conf_cal']").append("<option value=''>--선택--</option>");	
							
							items.find('item').each(function(i){						
							
								var calendar = $(this).find("CALENDAR").text();								
							
								$("select[name='days_cal']").append("<option value='"+calendar+"'>"+calendar+"</option>");
								$("select[name='weeks_cal']").append("<option value='"+calendar+"'>"+calendar+"</option>");
								$("select[name='conf_cal']").append("<option value='"+calendar+"'>"+calendar+"</option>");
								
							});						
						}
												
					});
					try{viewProgBar(false);}catch(e){}
				}
		, null );
		
		xhr.sendRequest();
	}
	
	function setAttachFile(attach_file) {
		
		if ( attach_file == "" ) {
			document.getElementById('attach_file_1').style.display = "none";
			document.getElementById('attach_file_2').style.display = "";
			
			$("#attach_file").val("");
			
		} else {
			document.getElementById('attach_file_1').style.display = "";
			document.getElementById('attach_file_2').style.display = "none";
		}		
	}
	
	function setErrFile(err_file) {
		
		if ( err_file == "" ) {
			document.getElementById('err_file_1').style.display 	= "none";
			document.getElementById('err_file_2').style.display 	= "";
			
			$("#errfiles").val("");
			
		} else {
			document.getElementById('err_file_1').style.display 	= "";
			document.getElementById('err_file_2').style.display 	= "none";
		}		
	}
	
	function dataDelete(row, flag){
		
		try{viewProgBar(true);}catch(e){}
		
		if(flag == "1"){
			setGridSelectedRowsAll(gridObj_1);		
			var row_idx = row-1;		
			var aSelRow = new Array;
			aSelRow = $('#'+gridObj_1.id).data('grid').getSelectedRows();	
			
			var rowsObj_2 = new Array();
			for(var i=0;i<aSelRow.length;i++){
				rowsObj_2.push({
					'grid_idx':rowsObj_2.length+1	
					,'m_in_condition_name': getCellValue(gridObj_1,aSelRow[i],"m_in_condition_name")
					,'m_in_condition_date': getCellValue(gridObj_1,aSelRow[i],"m_in_condition_date")
					,'m_in_condition_and_or': getCellValue(gridObj_1,aSelRow[i],"m_in_condition_and_or")
				});	
			}
					
			gridObj_3.rows = rowsObj_2;					
			setGridRows(gridObj_3);		
		
			aSelRow = new Array;
			setGridSelectedRowsAll(gridObj_3);
			aSelRow = $('#'+gridObj_3.id).data('grid').getSelectedRows();
			
			rowsObj_job1 = [];		
			for(var i=0;i<aSelRow.length;i++){			
				if(i == row_idx) continue;			
				rowsObj_job1.push({
					'grid_idx':rowsObj_job1.length+1								
					,'m_in_condition_name': getCellValue(gridObj_3,aSelRow[i],"m_in_condition_name")
					,'m_in_condition_date': getCellValue(gridObj_3,aSelRow[i],"m_in_condition_date")
					,'m_in_condition_and_or': getCellValue(gridObj_3,aSelRow[i],"m_in_condition_and_or")
				});	
			}
			
			gridObj_1.rows = rowsObj_job1;					
			setGridRows(gridObj_1);		
			clearGridSelected(gridObj_1);
			
		}else if(flag == "2"){
			
			if ( $('#'+gridObj_2.id).data('grid').getSelectedRows() != "" ) {
		
				var outCondName = getCellValue(gridObj_2,$('#'+gridObj_2.id).data('grid').getSelectedRows(),"m_out_condition_name");
				outCondName = outCondName.split("-");
				
				if(outCondName[0] == 'GLOB'){
					$("select[name='globalCond_yn']").val('N');
				}
			} else {
				$("select[name='globalCond_yn']").val('N');
			}
			
			setGridSelectedRowsAll(gridObj_2);
			
			var row_idx = row-1;		
			var aSelRow = new Array;
			aSelRow = $('#'+gridObj_2.id).data('grid').getSelectedRows();	
			
			var rowsObj_2 = new Array();
			for(var i=0;i<aSelRow.length;i++){
				rowsObj_2.push({
					'grid_idx':rowsObj_2.length+1	
					,'m_out_condition_name': getCellValue(gridObj_2,aSelRow[i],"m_out_condition_name")
					,'m_out_condition_date': getCellValue(gridObj_2,aSelRow[i],"m_out_condition_date")
					,'m_out_condition_effect': getCellValue(gridObj_2,aSelRow[i],"m_out_condition_effect")
				});				
			}
			
			gridObj_4.rows = rowsObj_2;					
			setGridRows(gridObj_4);		
		
			aSelRow = new Array;
			setGridSelectedRowsAll(gridObj_4);
			aSelRow = $('#'+gridObj_4.id).data('grid').getSelectedRows();
			
			rowsObj_job2 = [];		
			for(var i=0;i<aSelRow.length;i++){			
				if(i == row_idx) continue;			
				rowsObj_job2.push({
					'grid_idx':rowsObj_job2.length+1								
					,'m_out_condition_name': getCellValue(gridObj_4,aSelRow[i],"m_out_condition_name")
					,'m_out_condition_date': getCellValue(gridObj_4,aSelRow[i],"m_out_condition_date")
					,'m_out_condition_effect': getCellValue(gridObj_4,aSelRow[i],"m_out_condition_effect")
				});	
			}
			
			gridObj_2.rows = rowsObj_job2;					
			setGridRows(gridObj_2);		
			clearGridSelected(gridObj_2);
		}
		
		try{viewProgBar(false);}catch(e){}		
	}
	
	function addUserVars(){
		var obj = document.getElementById('userVar');
		var idx=0;
		
		var lastDiv = $('div[id^=div_user_val]:last').prop('id');
		
		if(lastDiv !== undefined){
			idx = Number(lastDiv.replace('div_user_val',''))+1;
		}

		var s = "";
		s += "<tr>";
		s += "<td style='width:120px;height:21px;'><div class='cellTitle_kang2' id='div_user_val"+idx+"'>사용자변수" + (idx+1) + "</div></td>"
		s += "<td style='width:400px;'><input type='text' class='input' name='m_var_name' style='width:98%;height:21px;' maxlength='40'/></td>";
		s += "<td ><input type='text' class='input' name='m_var_value' style='width:98%;height:21px;' maxlength='214'/></td>";
		s += "<td class='td2_1' width='120px'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type='button' name='del_set_button' value=' - ' onClick=\"delUserVars( getObjIdx(this, this.name))\" class=\"btn_white_h24\"></td>";
//		s += "<td colspan='5'><div class='cellContent_kang' id='div_user_val"+idx+"'><input type='text' name='t_set_var' style='width:98%;height:21px;ime-mode:disabled;' /></div></td>";
		s += "</tr>";
					
		$(obj).append(s);
	}
	
	function delUserVars(idx){
		$('#userVar tr:nth-child(' + (idx+1) + ')').remove();
	}
				
	function addSteps(){
		var obj = document.getElementById('onDoTable');
		var idx=0;
		
		var lastDiv = $('div[id^=div_step_type]:last').prop('id');
		
		if(lastDiv !== undefined){
			idx = Number(lastDiv.replace('div_step_type',''))+1;
		}
		
		var s = "";
		s += "<tr>";
		s += "<td style='width:5%;height:21px;'>";
		s += "<div class='cellContent_6'><input type='checkbox' name='check_idx'></div>";
		s += "<input type='hidden' name='hidIdx' id='hidIdx' value='"+idx+"'/>"
		s += "</td>";
		s += "<td style='width:7%;height:21px;'>";
		s += "<div class='cellContent_6'>";
		s += "<select name='m_step_opt' onchange='setStepType(this.value,"+idx+");' style='width:80%;'>";
		s += "<option value=''>--</option>";
		<%
		aTmp = CommonUtil.getMessage("JOB.STEP_OPT").split(",");
		for(int i=0;i<aTmp.length; i++){
			String[] aTmp1 = aTmp[i].split("[|]");
		%>	
			s += "<option value='<%=aTmp1[0] %>'><%=aTmp1[1] %></option>";
		<%}%>
		s += "</select>";
		s += "</div>";
		s += "</td>";
		
		s += "<td style='width:13%;height:21px;'><div class='cellContent_6' id='div_step_type"+idx+"'>&nbsp;<input type='hidden' name='m_step_type' onchange='setStepOnParameters(this.value,"+idx+");' /></div></td>";
		s += "<td style='width:80%;height:21px;'><div class='cellContent_7' id='div_step_parameters"+idx+"'>&nbsp;</div></td>";
		s += "</tr>";
		
		$(obj).append(s);
	}

	function delSteps(){
		
		$("input:checkbox[name='check_idx']").each(function(i){
			if($(this).prop('checked')){
				$(this).parent().parent().parent().remove();
			}
		});
		
		$("input:checkbox[name='checkIdxAll']").prop('checked', false);
		
	}
	function setStepType(v,idx){
		var obj1 = document.getElementById('div_step_type'+idx);
		var obj2 = document.getElementById('div_step_parameters'+idx);
		
		var s1 = "";
		var s2 = "";
		if( v=="O" ){
			s1 += "<select name='m_step_type' onchange='setStepOnParameters(this.value,"+idx+");' style='width:115px;'>";
			<%
			aTmp = CommonUtil.getMessage("TABLE.STEP_ON_TYPE").split(",");
			for(int i=0;i<aTmp.length; i++){
				String[] aTmp1 = aTmp[i].split("[|]");
			%>	
				s1 += "<option value='<%=aTmp1[1] %>'><%=aTmp1[0] %></option>";
			<%}%>
			s1 += "</select>";
			
			/* s2 += " Stmt=<input class='input' type='text' name='m_step_statement_stmt' maxlength='132' />";
			s2 += " Code=<input class='input' type='text' name='m_step_statement_code' maxlength='132' />"; */
		}else if( v=="A" ){
			s1 += "<select name='m_step_type' onchange='setStepParameters(this.value,"+idx+");' style='width:115px;'>";
			<%
			aTmp = CommonUtil.getMessage("TABLE.STEP_DO_TYPE").split(",");
			for(int i=0;i<aTmp.length; i++){
				String[] aTmp1 = aTmp[i].split("[|]");
			%>	
				s1 += "<option value='<%=aTmp1[1] %>'><%=aTmp1[0] %></option>";
			<%}%>
			s1 += "</select>";
			s2 += "&nbsp;";
		}else{
			s1 += "&nbsp;<input type='hidden' name='m_step_type'  />";
			s2 += "&nbsp;";
		}
		
		obj1.innerHTML = s1;
		obj2.innerHTML = s2;
	}	
	

	function setStepParameters(v,idx){
		var obj = document.getElementById('div_step_parameters'+idx);
		
		var s = "";
		if(v == 'Condition'){
			s += " Name=<input class='input' type='text' name='m_step_condition_name"+idx+"' id='m_step_condition_name"+idx+"' maxlength='255' />";
			s += " Date=<input class='input datepick' type='text' name='m_step_condition_date"+idx+"' id='m_step_condition_date"+idx+"' maxlength='4' size='4'  onClick=\"this.value='';\" onDblClick=\"this.value='ODAT';\" />";
			s += " Sign=<select name='m_step_condition_sign"+idx+"' id='m_step_condition_sign"+idx+"' style='width:55px;'>";
			<%
			aTmp = CommonUtil.getMessage("JOB.STEP_SIGN").split(",");
			for(int i=0;i<aTmp.length; i++){
				String[] aTmp1 = aTmp[i].split("[|]");
			%>	
				s += "<option value='<%=aTmp1[0] %>'><%=aTmp1[1] %></option>";
			<%}%>
			s += "</select>";
			
			
		}else if(v == 'Shout'){
			s += " Dest=<input class='input' type='text' name='m_step_dest"+idx+"' id='m_step_dest"+idx+"'/>";
			s += " Message=<input class='input' type='text' name='m_step_message"+idx+"' id='m_step_message"+idx+"' style='width:400px;'/>";
			
		}
		
		$(obj).html(s);
		
		/* $("#m_step_condition_date"+idx).addClass("ime_readonly").unbind('click').click(function(){
			dpCalMinMax(this.id,'mmdd');
		}); */	
		
	}
		

	function setStepOnParameters(v,idx){
	
		var obj = document.getElementById('div_step_parameters'+idx);
		
		var s = "";
		if(v == 'COMPSTAT' || v == 'RUNCOUNT'){

			s += " Stmt=<select name='m_step_statement_stmt"+idx+"' id='m_step_statement_stmt"+idx+"' onchange='setStepOnStmt(this.value,"+idx+");' style='width:95px;'> ";
			
			s += "<option value=''>--선택--</option>";
			<%
			aTmp = CommonUtil.getMessage("TABLE.STEP_ON_PARAMETERS").split(",");
			for(int i=0;i<aTmp.length; i++){
				String[] aTmp1 = aTmp[i].split("[|]");
			%>	
				s += "<option value='<%=aTmp1[1] %>'><%=aTmp1[0] %></option>";
			<%}%>
	
			s += "</select>";
			s += " Code=<input class='input' type='text' name='m_step_statement_code"+idx+"' id='m_step_statement_code"+idx+"' maxlength='132' />";
			
		}else if(v == 'FAILCOUNT'){
			s += " Code=<input class='input' type='text' name='m_step_statement_code"+idx+"' id='m_step_statement_code"+idx+"' maxlength='132' />";
		}
		
		$(obj).html(s);
	}
	
	function setStepOnStmt(v,idx){
		
		var obj = document.getElementById('div_step_parameters'+idx);
		if(v == 'EVEN' || v == 'ODD'){
			$(obj).find('select[name=m_step_statement_stmt'+idx+']').next('input').remove();
			$(obj).html($(obj).html().replace(' Code=', ' '));
			$(obj).find('select[name=m_step_statement_stmt'+idx+']').val(v);
		}else{
			var s = "";
			
			$(obj).find('select[name=m_step_statement_stmt'+idx+']').next('input').remove();
			$(obj).html($(obj).html().replace(' Code=', ' '));
			
			var objHtml  = $(obj).html();
			$(obj).html("");
			s = " Code=<input class='input' type='text' name='m_step_statement_code"+idx+"' id='m_step_statement_code"+idx+"' maxlength='132' />";
			$(obj).html(objHtml+s);
			
			$(obj).find('select[name=m_step_statement_stmt'+idx+']').val(v);
			
			
		}
		
	}
	
</script>
<%@include file="/jsp/common/inc/progBar.jsp"  %>
<iframe name="if1" id="if1" width="0" height="0"></iframe>
</div>
</body>
</html>