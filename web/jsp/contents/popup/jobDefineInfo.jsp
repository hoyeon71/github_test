<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.ghayoun.ezjobs.m.domain.*,com.ghayoun.ezjobs.t.domain.*" %>

<%@include file="/jsp/common/inc/header.jsp"%>
<%@include file="/jsp/common/inc/sessionChkPopup.jsp"%> 
<%
	//js version 추가하여 캐시 새로고침
  	String jsVersion = CommonUtil.getMessage("js_version");
%>

<html lang="ko" >
<head><title><%=CommonUtil.getMessage("HOME.TITLE") %></title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<link href="<%=request.getContextPath() %>/css/common.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath() %>/css/custom-theme/jquery-ui.custom.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath() %>/css/custom-theme/jquery-ui.works.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath() %>/css/layout-default.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath() %>/css/ftree/ui.fancytree.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath() %>/js/SlickGrid-2.1.0/slick.grid.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath() %>/css/slick-default-theme.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath() %>/js/poshytip-1.2/tip.css" rel="stylesheet" type="text/css" />


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
<script type="text/javascript" src="<%=request.getContextPath() %>/js/SlickGrid-2.1.0/slick.dataview.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/SlickGrid-2.1.0/slick.grid.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/SlickGrid-2.1.0/slick.editors.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/poshytip-1.2/jquery.poshytip.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/works_common.js?v=<%=jsVersion %>" ></script>
</head>

<%
	Map<String, Object> paramMap = CommonUtil.collectParameters(request);

	JobDefineInfoBean docBean			= (JobDefineInfoBean)request.getAttribute("jobDefineInfo");
	List jobApprovalInfo				= (List)request.getAttribute("jobApprovalInfo");

	String currentPage 					= CommonUtil.isNull(paramMap.get("currentPage"));
	String gubun						= CommonUtil.isNull(paramMap.get("gubun"));
	String menu_gb						= CommonUtil.isNull(paramMap.get("menu_gb"));

	if( docBean==null || jobApprovalInfo==null ) {
		out.println("<script type='text/javascript'>");
		out.println("alert('" + CommonUtil.getMessage("ERROR.75") + "');");
		out.println("self.close();");
		out.println("opener.defJobsList2();");
		out.println("</script>");
		return;
	}

	JobMapperBean jobMapperBean		= (JobMapperBean)request.getAttribute("jobMapperInfo");
	List defOutCondJobList			= (List)request.getAttribute("defOutCondJobList");
	List approvalLineList			= (List)request.getAttribute("approvalLineList");
	List outCondList				= (List)request.getAttribute("outCondList");

	List jobTypeGbList				= (List)request.getAttribute("jobTypeGb");
	List sBatchGradeList			= (List)request.getAttribute("sBatchGradeList");
	List authList					= (List)request.getAttribute("authList");
	List<CommonBean> inOutList 		= new ArrayList<CommonBean>();
	List databaseList				= (List)request.getAttribute("databaseList");
	String c = CommonUtil.isNull(paramMap.get("c"));
	String gridId = "g_"+c;
	String gridId_1 = "g_"+c+"_1";
	String gridId_2 = "g_"+c+"_2";

	String s_doc_gb 	= CommonUtil.isNull(paramMap.get("s_doc_gb"));
	String s_gb 		= CommonUtil.isNull(paramMap.get("s_gb"));
	String s_text 		= CommonUtil.isNull(paramMap.get("s_text"));
	String s_state_cd 	= CommonUtil.isNull(paramMap.get("s_state_cd"));

	String state_cd 		= CommonUtil.isNull(paramMap.get("state_cd"));
	String approval_cd 		= CommonUtil.isNull(paramMap.get("approval_cd"));

	String doc_cd 			= CommonUtil.isNull(paramMap.get("doc_cd"));
	String max_doc_cd		= CommonUtil.isNull(paramMap.get("max_doc_cd"));
	String doc_gb 			= CommonUtil.isNull(paramMap.get("doc_gb"));
	String rc 				= CommonUtil.isNull(paramMap.get("rc"));


	List smsDefaultList			= (List)request.getAttribute("smsDefaultList");
	List mailDefaultList		= (List)request.getAttribute("mailDefaultList");
	List setvarList				= (List)request.getAttribute("setvarList");

	// SMS, MAIL 기본값 및 체크 유무 추가(2024.02.22)
	String strSms					= "";
	String strMail					= "";
	String smsDefault				= "";
	String mailDefault				= "";

	if(smsDefaultList != null) {
		for ( int i = 0; i < smsDefaultList.size(); i++ ) {
			CommonBean commonBean = (CommonBean) smsDefaultList.get(i);

			strSms		= commonBean.getScode_eng_nm();
			smsDefault  = commonBean.getScode_nm();
		}
	}

	if(mailDefaultList != null) {
		for ( int i = 0; i < mailDefaultList.size(); i++ ) {
			CommonBean commonBean = (CommonBean) mailDefaultList.get(i);

			strMail		= commonBean.getScode_eng_nm();
			mailDefault = commonBean.getScode_nm();
		}
	}

	// 사용자의 폴더 권한 사용여부 체크
	List userFolderAuthList		= (List)request.getAttribute("userFolderAuthList");
	String sCodeFolderAuth 		= "";

	if(userFolderAuthList != null) {
		for ( int i = 0; i < userFolderAuthList.size(); i++ ) {
			CommonBean commonBean = (CommonBean) userFolderAuthList.get(i);

			sCodeFolderAuth = commonBean.getScode_eng_nm();
		}
	}

	String[] aTmp = null;
	String[] aTmpT = null;

	String strUserNm1				= "";
	String strUserNm2				= "";
	String strUserNm3				= "";
	String strUserNm4 				= "";
	String strUserNm5				= "";
	String strUserNm6				= "";
	String strUserNm7				= "";
	String strUserNm8 				= "";
	String strUserNm9				= "";
	String strUserNm10 				= "";

	String strDescription			= "";
	String strErrorDescription		= "";

	String strSms1 					= "";
	String strSms2 					= "";
	String strSms3 					= "";
	String strSms4 					= "";
	String strSms5 					= "";
	String strSms6 					= "";
	String strSms7 					= "";
	String strSms8 					= "";
	String strSms9					= "";
	String strSms10					= "";
	String strMail1 				= "";
	String strMail2 				= "";
	String strMail3 				= "";
	String strMail4 				= "";
	String strMail5 				= "";
	String strMail6 				= "";
	String strMail7 				= "";
	String strMail8 				= "";
	String strMail9					= "";
	String strMail10				= "";

	String strGrpCd1 				= "";
	String strGrpCd2 				= "";
	String strGrpNm1				= "";
	String strGrpNm2				= "";
	String strGrpSms1				= "";
	String strGrpSms2				= "";
	String strGrpMail1				= "";
	String strGrpMail2				= "";

	String strLateSub				= "";
	String strLateTime				= "";
	String strLateExec				= "";

	String strJobTypeGb           	= "";
	String jobTypeGb             	= "";

	String strUserCd1 				= "";
	String strUserCd2 				= "";
	String strUserCd3 				= "";
	String strUserCd4 				= "";
	String strUserCd5 				= "";
	String strUserCd6 				= "";
	String strUserCd7 				= "";
	String strUserCd8 				= "";
	String strUserCd9				= "";
	String strUserCd10 				= "";

	String	strSuccessSmsYn			= "";

	String strDataCenter 			= "";
	String strDataCenterName 		= "";
	String strApplType				= "";

	if ( jobMapperBean != null ) {

		strUserCd1 				= CommonUtil.isNull(jobMapperBean.getUser_cd_1());
		strUserCd2 				= CommonUtil.isNull(jobMapperBean.getUser_cd_2());
		strUserCd3 				= CommonUtil.isNull(jobMapperBean.getUser_cd_3());
		strUserCd4 				= CommonUtil.isNull(jobMapperBean.getUser_cd_4());
		strUserCd5 				= CommonUtil.isNull(jobMapperBean.getUser_cd_5());
		strUserCd6 				= CommonUtil.isNull(jobMapperBean.getUser_cd_6());
		strUserCd7 				= CommonUtil.isNull(jobMapperBean.getUser_cd_7());
		strUserCd8 				= CommonUtil.isNull(jobMapperBean.getUser_cd_8());
		strUserCd9 				= CommonUtil.isNull(jobMapperBean.getUser_cd_9());
		strUserCd10 			= CommonUtil.isNull(jobMapperBean.getUser_cd_10());
		strUserNm1 				= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getUser_nm_1()), "");
		strUserNm2 				= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getUser_nm_2()), "");
		strUserNm3 				= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getUser_nm_3()), "");
		strUserNm4 				= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getUser_nm_4()), "");
		strUserNm5 				= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getUser_nm_5()), "");
		strUserNm6 				= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getUser_nm_6()), "");
		strUserNm7 				= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getUser_nm_7()), "");
		strUserNm8 				= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getUser_nm_8()), "");
		strUserNm9 				= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getUser_nm_9()), "");
		strUserNm10 			= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getUser_nm_10()), "");

		strDescription 			= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getDescription()), "");
		strErrorDescription 	= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getError_description()), "");

		strSms1 				= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getSms_1()), "");
		strSms2 				= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getSms_2()), "");
		strSms3 				= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getSms_3()), "");
		strSms4 				= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getSms_4()), "");
		strSms5 				= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getSms_5()), "");
		strSms6 				= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getSms_6()), "");
		strSms7 				= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getSms_7()), "");
		strSms8 				= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getSms_8()), "");
		strSms9 				= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getSms_9()), "");
		strSms10 				= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getSms_10()), "");
		strMail1 				= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getMail_1()), "");
		strMail2 				= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getMail_2()), "");
		strMail3 				= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getMail_3()), "");
		strMail4 				= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getMail_4()), "");
		strMail5 				= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getMail_5()), "");
		strMail6 				= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getMail_6()), "");
		strMail7 				= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getMail_7()), "");
		strMail8 				= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getMail_8()), "");
		strMail9 				= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getMail_9()), "");
		strMail10 				= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getMail_10()), "");

		strGrpCd1				= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getGrp_cd_1()), "");
		strGrpCd2				= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getGrp_cd_2()), "");
		strGrpNm1				= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getGrp_nm_1()), "");
		strGrpNm2				= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getGrp_nm_2()), "");
		strGrpSms1				= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getGrp_sms_1()), "");
		strGrpSms2				= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getGrp_sms_2()), "");
		strGrpMail1				= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getGrp_mail_1()), "");
		strGrpMail2				= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getGrp_mail_2()), "");

		strLateSub 				= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getLate_sub()), "");
		strLateTime				= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getLate_time()), "");
		strLateExec 			= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getLate_exec()), "");

		strSuccessSmsYn			= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getSuccess_sms_yn()), "N");

		strDataCenter			= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getData_center()), "");
		strDataCenterName		= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getData_center_name()), "");

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

		if(strUserNm5.equals("")){
			strSms5 = "";
			strMail5 = "";
		}

		if(strUserNm6.equals("")){
			strSms6 = "";
			strMail6 = "";
		}

		if(strUserNm7.equals("")){
			strSms7 = "";
			strMail7 = "";
		}

		if(strUserNm8.equals("")){
			strSms8 = "";
			strMail8 = "";
		}

		if(strUserNm9.equals("")){
			strSms9 = "";
			strMail9 = "";
		}

		if(strUserNm10.equals("")){
			strSms10 = "";
			strMail10 = "";
		}

		if(strGrpNm1.equals("")){
			strGrpSms1 = "";
			strGrpMail1 = "";
		}

		if(strGrpNm2.equals("")){
			strGrpSms2 = "";
			strGrpMail2 = "";
		}
	}

	// 작업이관 여부 체크
	String cmjob_transfer 	= CommonUtil.isNull(docBean.getCmjob_transfer());

	String strCommand = CommonUtil.replaceHtmlStr(CommonUtil.isNull(docBean.getCommand()));

	String table_id = CommonUtil.isNull(paramMap.get("table_id"));
	String job_id	= CommonUtil.isNull(paramMap.get("job_id"));
	String job_name	= CommonUtil.isNull(paramMap.get("job_name"));

	String strRerunInterval 	= CommonUtil.E2K(docBean.getRerun_interval());
	String strRerunIntervalTime	= CommonUtil.E2K(docBean.getRerun_interval_time());
	if(strRerunIntervalTime.equals("H")){
		strRerunInterval = CommonUtil.isNull((Integer.parseInt(strRerunInterval) * 60));
	}
	String strCyclicType 		= CommonUtil.E2K(docBean.getCyclic_type());
	String strIntervalSequence 	= CommonUtil.E2K(docBean.getInterval_sequence());
	String strSpecificTimes 	= CommonUtil.E2K(docBean.getSpecific_times());

	String strMonth_days 		= CommonUtil.E2K(docBean.getMonth_days());
	String strSchedule_and_or 	= CommonUtil.E2K(docBean.getSchedule_and_or());
	// 실행 요일 로직 시작.
	String strWeekDays 		= CommonUtil.E2K(docBean.getWeek_days());
	String[] arrWeekDays 	= null;
	String strTotalWeekDays	= "";
	String strTempWeekDays 		= "";
	String strTempWeekDaysComma	= "";
	String strTempWeekDays2		= "";

	if ( !strWeekDays.equals("") ) {
		arrWeekDays = strWeekDays.split(",");
		for ( int i = 0; i < arrWeekDays.length; i++ ) {
			strTempWeekDays 		= "'" + arrWeekDays[i] + "'";
			strTempWeekDaysComma 	= "'" + arrWeekDays[i] + "',";
			strTotalWeekDays = strTotalWeekDays + strTempWeekDaysComma;

			if ( !(strTempWeekDays.equals("'0'") || strTempWeekDays.equals("'1'") || strTempWeekDays.equals("'2'") || strTempWeekDays.equals("'3'") || strTempWeekDays.equals("'4'") || strTempWeekDays.equals("'5'") || strTempWeekDays.equals("'6'")) ) {
				strTempWeekDays2 = strTempWeekDays2 + strTempWeekDays + ",";
			}
		}

		strTotalWeekDays = strTotalWeekDays.substring(0, strTotalWeekDays.length()-1);
		strTotalWeekDays = strTotalWeekDays.replaceAll("'0'","일").replaceAll("'1'","월").replaceAll("'2'","화").replaceAll("'3'","수").replaceAll("'4'","목").replaceAll("'5'","금").replaceAll("'6'","토");

		strTempWeekDays2 = strTotalWeekDays.replaceAll("'", "");
	}
	String strDays_cal 			= CommonUtil.E2K(docBean.getDays_cal());
	String strWeeks_cal 			= CommonUtil.E2K(docBean.getWeeks_cal());
	String strTaskType 			= CommonUtil.E2K(docBean.getTask_type());

	if(strTaskType.equals("job")){
		strTaskType = "script";
	}

	String strCycleMent = "";
	if ( strCyclicType.equals("C") ) {
		strCycleMent = "반복주기 : " + strRerunInterval + " (분단위) ";
	} else if ( strCyclicType.equals("V") ) {
		strCycleMent = "반복주기(불규칙) : " + strIntervalSequence + " (분단위) ";
	} else if ( strCyclicType.equals("S") ) {
		strCycleMent = "시간지정 : " + strSpecificTimes + " (HHMM) ";
	}

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

	String timeUntil = CommonUtil.isNull(docBean.getTime_until());

	boolean ignoreTimeUntil = false;
	if (timeUntil.equals(">"))
		ignoreTimeUntil = true;

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

	String strCyclic = CommonUtil.isNull(docBean.getCyclic());
	String strCyclicMent = "";

	if ( strCyclic.equals("0") ) {
		strCyclicMent = "N";
	} else {
		strCyclicMent = "Y";
	}

	String strCritical = CommonUtil.isNull(docBean.getCritical());
	String strCriticalMent = "";

	if ( strCritical.equals("0") ) {
		strCriticalMent = "N";
	} else {
		strCriticalMent = "Y";
	}

	String strConfirmFlag 	= CommonUtil.isNull(docBean.getConfirm_flag());
	String strPriority 		= CommonUtil.isNull(docBean.getPriority());

	String strConfirmFlagMent = "";
	if ( strConfirmFlag.equals("0") ) {
		strConfirmFlagMent = "N";
	} else {
		strConfirmFlagMent = "Y";
	}

	String strActiveFrom	= CommonUtil.isNull(docBean.getActive_from());
	String strActiveTill	= CommonUtil.isNull(docBean.getActive_till());
	String strActiveMent	= "";
	String strActiveTime    = "";

	if(!strActiveFrom.equals("") && !strActiveTill.equals("")){
		if ( Integer.parseInt(strActiveFrom) > Integer.parseInt(strActiveTill) ) {
			strActiveMent = "Not Active";
			strActiveTime = strActiveTill + " ~ " + strActiveFrom;
		} else {
			strActiveMent = "Active";
			strActiveTime = strActiveFrom + " ~ " + strActiveTill;
		}

	}

	if(strActiveFrom.equals("") || strActiveTill.equals("")){
		strActiveMent = "Active";
		strActiveTime = strActiveFrom + " ~ " + strActiveTill;
	}

	// 작업 통제 여부
	String S_BATCH_CONTROL = CommonUtil.isNull(request.getSession().getAttribute("BATCH_CONTROL"));

	String strFolderAuth = "";
	if(authList != null && authList.size() > 0) {
		for(int l=0; l<authList.size(); l++) {
			UserBean userBean = (UserBean) authList.get(l);
			strFolderAuth += "'"+CommonUtil.isNull(userBean.getFolder_auth())+"',";
		}
		strFolderAuth = strFolderAuth.substring(0, strFolderAuth.length()-1);
	}

	//특정실행날짜
	String t_general_date 	= CommonUtil.isNull(docBean.getT_general_date());

	if(!t_general_date.equals("")){
		String temp_general_date = "";
		for(int i=4; i<=t_general_date.length();i+=4){
			temp_general_date += t_general_date.substring(i-4,i);
			temp_general_date += ", ";
		}

		if(!temp_general_date.equals("")) t_general_date = temp_general_date.substring(0,temp_general_date.length()-2);
	}

	String strWhenCond				= CommonUtil.isNull(docBean.getWhen_cond());
	String strMessage				= CommonUtil.isNull(docBean.getMessage());
	String strShoutTime			= CommonUtil.isNull(docBean.getShout_time());
	String[] whenCond_arr			= strWhenCond.split(",", -1);
	String[] shoutTime_arr			= strShoutTime.split(",", -1);
	String[] message_arr			= strMessage.split(",", -1);

	String strLateSubT				= "";
	String strLateTimeT			= "";
	String strLateExecT			= "";
	String strSuccSmsT				= "";

	if(strWhenCond.equals("")){
		if(!strLateSub.equals("")){
			strLateSubT = "(ctm : 데이터없음)";
		}
		if(!strLateTime.equals("")){
			strLateTimeT = "(ctm : 데이터없음)";
		}
		if(!strLateExec.equals("")){
			strLateExecT = "(ctm : 데이터없음)";
		}
		if(!strSuccessSmsYn.equals("") && !strSuccessSmsYn.equals("N")){
			strSuccSmsT = "(ctm : 데이터없음)";
		}

	}else if(!strWhenCond.equals("")){
		for(int j=0; j<whenCond_arr.length; j++){
			//시작임계시간
			if(whenCond_arr[j].equals("LATESUB")){
				if(!shoutTime_arr[j].equals(strLateSub)){
					strLateSubT = shoutTime_arr[j];
					strLateSubT = "(ctm : " + strLateSubT + ")";
				}else{
					strLateSubT = "";
				}
			}
			//종료임계시간
			if(whenCond_arr[j].equals("LATETIME")){
				if(!shoutTime_arr[j].equals(strLateTime)){
					strLateTimeT = shoutTime_arr[j];
					strLateTimeT = "(ctm : " + strLateTimeT + ")";
				}else{
					strLateTimeT = "";
				}
			}
			//수행임계시간
			if(whenCond_arr[j].equals("EXECTIME")){
				shoutTime_arr[j] = shoutTime_arr[j].replaceAll(">", "");
				strLateExec= strLateExec.replaceAll(">", "");

				if(Integer.parseInt(CommonUtil.isNull(strLateExec, "0")) != Integer.parseInt(shoutTime_arr[j])){
					strLateExecT = "(ctm : " + shoutTime_arr[j].replaceAll(">","") + ")";
				}else{
					strLateExecT = "";
				}
			}

			//성공시알람유무
			if(whenCond_arr[j].equals("OK")){
				if(message_arr[j].equals("Ended OK")){
					strSuccSmsT = "Y";
				}else{
					strSuccSmsT = message_arr[j];
				}

				if(!strSuccessSmsYn.equals(strSuccSmsT)){
					strSuccSmsT = "(ctm : " + strSuccSmsT + ")";
				}else{
					strSuccSmsT = "";
				}
			}
		}
	}

	//kubernetes 구분을 위해 변수 추가
	strApplType				= CommonUtil.isNull(docBean.getAppl_type());
	String con_pro			= "";
	String spec_param		= "";
	String get_pod_logs		= "";
	String job_cleanup		= "";
	String polling_interval	= "";
	String yaml_file		= "";
	String file_content		= "";
	String job_spec_type	= "";
	String os_exit_code		= "";

	if(strApplType.equals("KBN062023")){
		strTaskType = "Kubernetes";
	}
	if( null!=docBean.getT_set() && docBean.getT_set().trim().length()>0 && strTaskType.equals("Kubernetes") ){
		aTmpT = CommonUtil.E2K(docBean.getT_set()).split("[|]");
		for(int t=0; null!=aTmpT&&t<aTmpT.length; t++ ){
			String[] aTmpT1 = aTmpT[t].split(",",2);

				String var_name	= aTmpT1[0];

				if(var_name.equals("UCM-ACCOUNT")){
					con_pro 			= CommonUtil.replaceHtmlStr(aTmpT1[1]);
				}else if(var_name.equals("UCM-JOB_YAML_FILE_PARAMS")){
					spec_param 			= CommonUtil.replaceHtmlStr(aTmpT1[1]);
				}else if(var_name.equals("UCM-GET_LOGS")){
					get_pod_logs 		= CommonUtil.replaceHtmlStr(aTmpT1[1]);
				}else if(var_name.equals("UCM-CLEANUP")){
					job_cleanup 		= CommonUtil.replaceHtmlStr(aTmpT1[1]);
				}else if(var_name.equals("UCM-JOB_POLL_INTERVAL")){
					polling_interval 	= CommonUtil.replaceHtmlStr(aTmpT1[1]);
				}else if(var_name.equals("UCM-JOB_YAML_FILE")){
					yaml_file 			= CommonUtil.replaceHtmlStr(aTmpT1[1]);
				}else if(var_name.equals("UCM-JOB_YAML_FILE_N002_element")){
					file_content 		= CommonUtil.replaceHtmlStr(aTmpT1[1]);
				}else if(var_name.equals("UCM-JOB_SPEC_TYPE")){
					job_spec_type		= CommonUtil.replaceHtmlStr(aTmpT1[1]);
				}else if(var_name.equals("UCM-OS_EXIT_CODE")){
					os_exit_code 		= CommonUtil.replaceHtmlStr(aTmpT1[1]);
				}
		}
	}

	//MFT 추가
	strApplType	= CommonUtil.isNull(docBean.getAppl_type());
	String FTP_ACCOUNT	= "";
	if(strApplType.equals("FILE_TRANS")){
		strTaskType = "MFT";
	}

	if( null!=docBean.getT_set() && docBean.getT_set().trim().length()>0 && strTaskType.equals("MFT") ){
		aTmpT = CommonUtil.E2K(docBean.getT_set()).split("[|]");
		for(int t=0; null!=aTmpT&&t<aTmpT.length; t++ ){
			String[] aTmpT1 = aTmpT[t].split(",",2);

			String var_name	= aTmpT1[0];

			if(var_name.equals("FTP-ACCOUNT")){
				FTP_ACCOUNT = CommonUtil.replaceHtmlStr(aTmpT1[1]);
			}
		}
	}
		
	//Database 값 세팅
	String db_con_pro		= "";
	String database			= "";
	String database_type	= "";
	String execution_type	= "";
	String schema			= "";
	String sp_name			= "";
	String query			= "";
	String db_autocommit	= "";
	String append_log		= "";
	String append_output	= "";
	String db_output_format	= "";
	String csv_seperator	= "";
	
	if(strApplType.equals("DATABASE")){
		strTaskType = "Database";
	}
	System.out.println("strApplType : " + strApplType);
	System.out.println("strTaskType : " + strTaskType);
	if( null!=docBean.getT_set() && docBean.getT_set().trim().length()>0 && strTaskType.equals("Database") ){
		aTmpT = CommonUtil.E2K(docBean.getT_set()).split("[|]");
		for(int t=0; null!=aTmpT&&t<aTmpT.length; t++ ){
			String[] aTmpT1 = aTmpT[t].split(",",2);

			String var_name	= aTmpT1[0];

			if(var_name.equals("DB-ACCOUNT")){
				db_con_pro = CommonUtil.replaceHtmlStr(aTmpT1[1]);
			}else if(var_name.equals("DB-DB_TYPE")){
				database_type = CommonUtil.replaceHtmlStr(aTmpT1[1]);
			}else if(var_name.equals("DB-EXEC_TYPE")){
				execution_type = CommonUtil.replaceHtmlStr(aTmpT1[1]);
				if(execution_type.equals("Open Query")){
					execution_type = "Q"; 
				}else if(execution_type.equals("Stored Procedure")){
					execution_type = "P"; 
				}
			}else if(var_name.equals("DB-STP_SCHEM")){
				schema = CommonUtil.replaceHtmlStr(aTmpT1[1]);
			}else if(var_name.equals("DB-STP_NAME")){
				sp_name = CommonUtil.replaceHtmlStr(aTmpT1[1]);
			}else if(var_name.equals("DB-QTXT-N001-SUBQTXT")){
				query = CommonUtil.replaceHtmlStr(aTmpT1[1]);
				query = query.replaceAll("&amp;", "&").replaceAll("&lt;", "<").replaceAll("&gt;", ">");
				query = query.replaceAll("<br>", "\n");
			}else if(var_name.equals("DB-AUTOCOMMIT")){
				db_autocommit = CommonUtil.replaceHtmlStr(aTmpT1[1]);
			}else if(var_name.equals("DB-APPEND_LOG")){
				append_log = CommonUtil.replaceHtmlStr(aTmpT1[1]);
			}else if(var_name.equals("DB-APPEND_OUTPUT")){
				append_output = CommonUtil.replaceHtmlStr(aTmpT1[1]);
			}else if(var_name.equals("DB-OUTPUT_FORMAT")){
				db_output_format = CommonUtil.replaceHtmlStr(aTmpT1[1]);
				
				if(db_output_format.equals("Text")){
					db_output_format = "T";
				}else if(db_output_format.equals("CSV")){
					db_output_format = "C";
				}else if(db_output_format.equals("XML")){
					db_output_format = "X";
				}else if(db_output_format.equals("HTML")){
					db_output_format = "H";
				}
			}else if(var_name.equals("DB-CSV_SEPERATOR")){
				csv_seperator = CommonUtil.replaceHtmlStr(aTmpT1[1]);
			}
			
			if(var_name.startsWith("DB-STP_PARAMS-")){
				CommonBean newBean = new CommonBean();
				newBean.setVar_name(var_name);
				newBean.setVar_value(CommonUtil.replaceHtmlStr(aTmpT1[1]));
			  	inOutList.add(newBean);
			}
		}
	}

	String strConfCal 	= CommonUtil.isNull(docBean.getConf_cal());
	String strShift 	= CommonUtil.isNull(docBean.getShift());
	String strShiftNum 	= CommonUtil.isNull(docBean.getShift_num());
%>



<body id='body_A01' leftmargin="0" topmargin="0">

<div style="width:100%; height:100%; overflow-x:hidden; overflow-y:scroll;">

<form name="frm_down" id="frm_down" method="post" onsubmit="return false;">
	<input type="hidden" name="flag" id="flag" />
	<input type="hidden" name="file_gb" id="file_gb" />
	<input type="hidden" name="data_center" id="data_center" />
	<input type="hidden" name="job_nm" id="job_nm" />
</form>
<form name="frm_sch" id="frm_sch" method="post" onsubmit="return false;">
	<input type="hidden" name="data_center" 	id="data_center" 		value="<%=strDataCenter %>"/>
	<input type="hidden" name="month_days" 		id="month_days"			value="<%=CommonUtil.E2K(docBean.getMonth_days()) %>"/>
	<input type="hidden" name="week_days" 		id="week_days" 			value="<%=CommonUtil.E2K(docBean.getWeek_days()) %>"/>
	<input type="hidden" name="days_cal" 		id="days_cal" 			value="<%=CommonUtil.E2K(docBean.getDays_cal()) %>"/>
	<input type="hidden" name="weeks_cal" 		id="weeks_cal" 			value="<%=CommonUtil.E2K(docBean.getWeeks_cal()) %>"/>
	<input type="hidden" name="schedule_and_or"	id="schedule_and_or" 	value="<%=CommonUtil.E2K(docBean.getSchedule_and_or()) %>"/>
	<input type="hidden" name="month_1" 		id="month_1" 			value="<%=CommonUtil.E2K(docBean.getMonth_1()) %>"/>
	<input type="hidden" name="month_2" 		id="month_2" 			value="<%=CommonUtil.E2K(docBean.getMonth_2()) %>"/>
	<input type="hidden" name="month_3" 		id="month_3" 			value="<%=CommonUtil.E2K(docBean.getMonth_3()) %>"/>
	<input type="hidden" name="month_4" 		id="month_4"			value="<%=CommonUtil.E2K(docBean.getMonth_4()) %>"/>
	<input type="hidden" name="month_5" 		id="month_5" 			value="<%=CommonUtil.E2K(docBean.getMonth_5()) %>"/>
	<input type="hidden" name="month_6" 		id="month_6" 			value="<%=CommonUtil.E2K(docBean.getMonth_6()) %>"/>
	<input type="hidden" name="month_7" 		id="month_7" 			value="<%=CommonUtil.E2K(docBean.getMonth_7()) %>"/>
	<input type="hidden" name="month_8" 		id="month_8" 			value="<%=CommonUtil.E2K(docBean.getMonth_8()) %>"/>
	<input type="hidden" name="month_9" 		id="month_9" 			value="<%=CommonUtil.E2K(docBean.getMonth_9()) %>"/>
	<input type="hidden" name="month_10" 		id="month_10" 			value="<%=CommonUtil.E2K(docBean.getMonth_10()) %>"/>
	<input type="hidden" name="month_11" 		id="month_11" 			value="<%=CommonUtil.E2K(docBean.getMonth_11()) %>"/>
	<input type="hidden" name="month_12" 		id="month_12" 			value="<%=CommonUtil.E2K(docBean.getMonth_12()) %>"/>
	<input type="hidden" name="active_from" 	id="active_from" 		value="<%=CommonUtil.E2K(docBean.getActive_from()) %>"/>
	<input type="hidden" name="active_till" 	id="active_till" 		value="<%=CommonUtil.E2K(docBean.getActive_till()) %>"/>
	<input type="hidden" name="conf_cal" 		id="conf_cal" 			value="<%=CommonUtil.E2K(docBean.getConf_cal()) %>"/>
	<input type="hidden" name="shift_num" 		id="shift_num" 			value="<%=CommonUtil.E2K(docBean.getShift_num()) %>"/>
	<input type="hidden" name="shift" 			id="shift" 				value="<%=CommonUtil.E2K(docBean.getShift()) %>"/>
	<input type="hidden" name="t_general_date"  id="t_general_date"     value="<%=CommonUtil.E2K(docBean.getT_general_date()) %>"/>
</form>
<form id="frm1" name="frm1" method="post" onsubmit="return false;" enctype="multipart/form-data" >

	<input type="hidden" name="sched_table" id="sched_table" />
	<input type="hidden" name="job_name"  />
	<input type="hidden" name="data_center" value="<%=docBean.getData_center() %>" />
	<input type="hidden" name="flag" value="view" />
	<input type="hidden" name="table_id" value="<%=table_id%>" />
	<input type="hidden" name="job_id" value="<%=job_id%>" />


	<input type="hidden" name="flag" id="flag"/>
	<input type="hidden" name="is_valid_flag" id="is_valid_flag" />
	
	<input type="hidden" name="t_general_date" id="t_general_date" />
	<input type="hidden" name="t_conditions_in" id="t_conditions_in" />
	<input type="hidden" name="t_conditions_out" id="t_conditions_out" />
	<input type="hidden" name="t_resources_q" id="t_resources_q" />
	<input type="hidden" name="t_resources_c" id="t_resources_c" />
	<input type="hidden" name="t_set" id="t_set" />
	<input type="hidden" name="t_steps" id="t_steps" />
	<input type="hidden" name="t_postproc" id="t_postproc" />
	<input type="hidden" name="t_tag_name" id="t_tag_name"/>
	
	<input type='hidden' id='p_apply_date' name='p_apply_date'/>
	<input type='hidden' id='apply_cd' name='apply_cd'/>
	

	<input type="hidden" name="retro" id="retro"	value="0" />
	
	<!-- Cyclic 작업 셋팅 파라미터. -->
	
	<input type="hidden" name=cyclic_type 			value="<%=CommonUtil.isNull(docBean.getCyclic_type()) %>" />
	<input type="hidden" name=rerun_interval 		value="<%=CommonUtil.isNull(docBean.getRerun_interval()) %>" />
	<input type="hidden" name=count_cyclic_from 	value="<%=CommonUtil.isNull(docBean.getCount_cyclic_from()) %>" />
	<input type="hidden" name="interval_sequence" 	value="<%=CommonUtil.E2K(docBean.getInterval_sequence())%>"/>
	<input type="hidden" name="tolerance" 			value="<%=CommonUtil.E2K(docBean.getTolerance())%>"/>
	<input type="hidden" name="specific_times" 		value="<%=CommonUtil.E2K(docBean.getSpecific_times())%>"/>	
		
	<input type="hidden" name="user_cd" id="user_cd"/>		
	
	<!-- MFT 정보 -->
	<input type='hidden' name='advanced_num' 		id='advanced_num' 	value='' />
	<input type='hidden' name='advanced' 			id='advanced' 		value='' />
	<input type='hidden' name='FTP_LHOST' 			id='FTP_LHOST' 		value='' />
	<input type='hidden' name='FTP_RHOST' 			id='FTP_RHOST' 		value='' />
	<input type='hidden' name='FTP_LOSTYPE' 		id='FTP_LOSTYPE' 	value='' />
	<input type='hidden' name='FTP_ROSTYPE' 		id='FTP_ROSTYPE' 	value='' />
	<input type='hidden' name='FTP_LUSER' 			id='FTP_LUSER' 		value='' />
	<input type='hidden' name='FTP_RUSER' 			id='FTP_RUSER' 		value='' />
	<input type='hidden' name='FTP_CONNTYPE1' 		id='FTP_CONNTYPE1' 	value='' />
	<input type='hidden' name='FTP_CONNTYPE2' 		id='FTP_CONNTYPE2' 	value='' />
	
<table style='width:99%;height:99%;border:none;'>

	<%
		if ( !gubun.equals("graph") ) {
			if ( !S_BATCH_CONTROL.equals("Y") && cmjob_transfer.equals("Y") ) {
				if( !strTaskType.equals("smart table") && !strTaskType.equals("sub-table")) {
	%>
					<tr style='height:10px;'>	
						<td style='vertical-align:right;'>
							<table style='width:100%' >
								<tr>
									<td style='text-align:right;'>
										<span id='btn_copy'>등록(복사) 바로가기</span>
										<span id='btn_copy2'>긴급(복사) 바로가기</span>
	<%
										String table_name = CommonUtil.isNull(docBean.getTable_name());
										if(table_name.indexOf("/") > -1) { // 스마트폴더 체크
											table_name = table_name.substring(0, table_name.indexOf("/"));
										}
										if( strFolderAuth.indexOf(table_name) > -1 || S_USER_GB.equals("99") || sCodeFolderAuth.equals("N") ) {
	%>
											<span id='btn_modify'>수정 바로가기</span>
											<span id='btn_delete'>삭제 바로가기</span>
	<%
										}
	%>
									</td>
								</tr>		
							</table>
						</td>
					</tr>
	<%
				}
			}
		}
	%>

	<tr style='height:10px;'>
		<td style='vertical-align:top;'>
			<h4 class="ui-widget-header ui-corner-all"  >
				<div id='t_<%=gridId %>' class='title_area'>
					<span><%=CommonUtil.getMessage("CATEGORY.GB.03.SB.0310") %></span>
				
				</div>				
			</h4>
		</td>
	</tr>
	<tr>
		<td id='ly_<%=gridId %>' style='vertical-align:top;'>
			<div id="<%=gridId %>" class="ui-widget-header ui-corner-all">
				
				<table style="width:100%">
					<tr>
						<td>
							<div class='cellTitle_kang5'>작업 정보</div>
						</td>	
					</tr>
					<tr>
						<td valign="top">
							<table style="width:100%;">
								<tr>
									<td width="10%"></td>
									<td width="20%"></td>
									<td width="10%"></td>
									<td width="20%"></td>
									<td width="10%"></td>
									<td width="20%"></td>
								</tr>	
								<tr>
									<td>
										<div class='cellTitle_ez_right'>C-M</div>
									</td>									
									<td> 										
										<div class='cellContent_kang'>
											<%=strDataCenterName%>
											<input type="hidden" name="data_center" id="data_center" value="<%=strDataCenter%>" style="width:70%;height:21px;"/>
										</div>
										
									</td>
									<td>
										<div class='cellTitle_ez_right'>작업타입</div>
									</td>  
									<td> 
										<div class='cellContent_kang'>
											<%=strTaskType %>
											<input type="hidden" name="task_type" id="task_type" value="<%=strTaskType %>"/>
										</div>
									</td>
									
									
										
								</tr>	
								
								<tr>
									
									<td>  
										<div class='cellTitle_ez_right'>폴더</div>
									</td>  
									<td>
										<div class='cellContent_kang'>										
											<%=CommonUtil.isNull(docBean.getTable_name()) %>
											<input type="hidden" name="table_name" id="table_name" value="<%=CommonUtil.isNull(docBean.getTable_name()) %>"/>
										</div>
									</td>
									
									<td>  
										<div class='cellTitle_ez_right'>어플리케이션</div>
									</td>
									
									<td>
										<div class='cellContent_kang'>
											<%=CommonUtil.isNull(docBean.getApplication()) %>
											<input type="hidden" name="application" id="application" value="<%=CommonUtil.isNull(docBean.getApplication()) %>"  style= "width:70%;height:21px;"/>
										</div>
									</td>
									
									
									<td>
										<div class='cellTitle_ez_right'>그룹</div>
									</td>
									<td> 
										<div class='cellContent_kang'>
									 		<%=CommonUtil.isNull(docBean.getGroup_name()) %>
											<input type="hidden" name="group_name" id="group_name" value="<%=CommonUtil.isNull(docBean.getGroup_name()) %>"/>
										</div>
									</td>
								</tr>
								<tr>							
									<td>
										<div class='cellTitle_ez_right'>수행서버</div>
									</td>
									<td> 
										<div class='cellContent_kang'>
											<%=CommonUtil.E2K(docBean.getNode_id()) %>
											<input type="hidden" name="node_id" id="node_id" value="<%=CommonUtil.E2K(docBean.getNode_id()) %>"/>
										</div>										
									</td>
									<td>								
										<div class='cellTitle_ez_right'>계정명</div>
									</td>
									<td> 
										<div class='cellContent_kang'>
											<%=CommonUtil.E2K(docBean.getOwner()) %>
											<input type=hidden name="v_owner" id="v_owner" value= "<%=CommonUtil.E2K(docBean.getOwner()) %>"/>
										</div>
									</td>
									<td>								
										<div class='cellTitle_ez_right'>최대대기일</div>
									</td>
									<td> 
										<div class='cellContent_kang'>
											<%=CommonUtil.E2K(docBean.getMax_wait()) %>
										</div>
									</td>
								</tr>	
								<tr>
									<td>
										<div class='cellTitle_ez_right'>작업명</div>
									</td>
									<td>
										<div class='cellContent_kang'>
											<%=job_name %>
										<input type="hidden" id="job_nameChk" name="job_nameChk" value="0"/>
										<input type="hidden" id="job_name" name="job_name"/>  
											
										</div>
									</td>
									<td>
										<div class='cellTitle_ez_right'>작업 설명</div>
									</td>
	        						<td colspan="3">
	        							<div class='cellContent_kang' style='height:auto;'>
	        								<%=CommonUtil.E2K(docBean.getDescription()) %>
	        								<input type="hidden" name="description" id="description" value= "<%=CommonUtil.E2K(docBean.getDescription()) %>"  style="width:98%;height:21px;"/>
	        							</div>        			
	        					  	</td>
		        				</tr>
		        				<tr>
		        					<td>
										<div class='cellTitle_ez_right'>프로그램 명</div>
									</td>
									<td>
										<div class='cellContent_kang'>
											<%=CommonUtil.E2K(docBean.getMem_name()) %>
											<input type="hidden" name="mem_name" id="mem_name" value= "<%=CommonUtil.E2K(docBean.getMem_name()) %>"  style= "width:98%;height:21px;"/>
										</div>
									</td>
									<td>
										<div class='cellTitle_ez_right'>프로그램 위치</div>
									</td>
									
									<td colspan="3">
										<div class='cellContent_kang'>
											<%=CommonUtil.E2K(docBean.getMem_lib()) %>
											<input type="hidden" name="mem_lib" id="mem_lib" value= "<%=CommonUtil.E2K(docBean.getMem_lib()) %>"  style= "width:98%;height:21px;"/>
										</div>
									</td>
								</tr>
								<tr>
								
									<td>
										<div class='cellTitle_ez_right'>작업수행명령</div>
									</td>
									
									<td colspan="5">
										<div style="width:90%;word-break:break-all;">
											<span class='cellContent_kang' id="mem_info"><%=strCommand%></span>
											<input type="hidden" name="command" id="command" value="<%=strCommand%>" style="width:98%;height:21px;"/>
										</div>
									</td>
								</tr>
								<tr>
									<td>
										<div class='cellTitle_ez_right'>작업시작시간</div>
									</td>
									<td>
										<div class='cellContent_kang'>
											<%=fromTime %>
										</div>											
									</td>
									<td>
										<div class='cellTitle_ez_right'>작업종료시간</div>
									</td> 								
									<td>
										<div class='cellContent_kang'>
											<%=timeUntil %>
										<%--<%=timeUntil.replaceAll(">", "")%>--%>
										</div>											
									</td>
									<td>
										<div class='cellTitle_ez_right'>과거 ODATE 시간 무시</div>
									</td>
									<td>
										<div class='cellContent_kang'>
											<span style='vertical-align:middle'><input type='checkbox' id='ignore_time_until' name='ignore_time_until' style='vertical-align:middle' disabled/></span>
											<span style='vertical-align:middle'> > (체크시, 과거 ODATE의 작업은 시간 설정 무시하고 수행)</span>
										</div>
									</td>
									<!-- <td colspan="2">
                                        <div class='cellTitle_ez_right' style='text-align:left'>
                                            <input type='checkbox' id='ignore_time_until' name='ignore_time_until' style='vertical-align:middle'/>

                                        </div>
                                    </td> -->
								</tr>    
								
								<tr>
						        	<td>
										<div class='cellTitle_ez_right'>시작임계시간</div>
									</td>  
						        	<td>							        	
						        		<div class='cellContent_kang'>							        		
						        			<%=strLateSub %>&nbsp&nbsp&nbsp&nbsp<font color="red"><%=strLateSubT%></font>
										</div>
									</td>
						        	<td>
										<div class='cellTitle_ez_right'>종료임계시간</div>
									</td>  
						        	<td>
						        		<div class='cellContent_kang'>
						        			<%=strLateTime %>&nbsp&nbsp&nbsp&nbsp<font color="red"><%=strLateTimeT%></font>
										</div>
									</td>
						        	<td>
										<div class='cellTitle_ez_right'>수행임계시간</div>
									</td>  
						        	<td>
						        		<div class='cellContent_kang'>
						        			<%=strLateExec.replaceAll(">", "")%>&nbsp&nbsp&nbsp&nbsp<font color="red"><%=strLateExecT%></font>
										</div>
									</td>
					        	</tr>
		        				<tr>
		        					<td>
								 		<div class='cellTitle_ez_right'>반복작업</div>
						        	</td>
						        	<td colspan="3">
						        		<div class='cellContent_kang'>
						        			<%
							        			out.println(strCyclicMent);
												if(strCyclicMent.equals("Y")){
													out.println(strCycleMent);
												}
						        			%>
										</div>
									</td>

									<td>
								 		<div class='cellTitle_ez_right'>최대 반복 횟수</div>
						        	</td>
									<td colspan="3">
										<div class='cellContent_kang'>
											<%=CommonUtil.E2K(docBean.getRerun_max()) %>
										</div>
									</td>
		        				</tr>
		        				<tr>
		        					<td>
								 		<div class='cellTitle_ez_right'>Confirm Flag</div>
						        	</td>
						        	<td>
						        		<div class='cellContent_kang'>
						        			<%=strConfirmFlagMent%>							        																
										</div>												
									</td>
									<td>
								 		<div class='cellTitle_ez_right'>우선순위</div>
						        	</td>								
									<td>
										<div class='cellContent_kang'>
											<%=strPriority%>
										</div>
									</td>
									<td>
										<div class='cellTitle_ez_right'>성공 시 알람 발송</div>
									</td>
									<td>
										<div class='cellContent_kang'>
											<%=strSuccessSmsYn%>&nbsp&nbsp&nbsp&nbsp<font color="red"><%=strSuccSmsT%></font>
										</div>
									</td>
		        				</tr>
		        				<tr>
									<td>
										<div class='cellTitle_ez_right'>중요작업</div>
									</td>
									<td colspan="3">
										<div class='cellContent_kang'>
											<%=strCriticalMent%>
										</div>
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
				
				<table style="width:100%;" id="mftTable">
						<tr>
							<td style='width:100%'>
								<div class='cellTitle_kang5'>MFT 정보</div>									
							</td>
						</tr>
						<tr>
							<td valign="top">
								<table style="width:100%">
									<tr>
										<td width="10%"></td>
										<td width="30%"></td>
										<td width="10%"></td>
										<td width="30%"></td>
									</tr>
									<tr>
										<td><div class='cellTitle_ez_right'>Connection Profile</div></td>
										<td>
											<input class='input' type='text' id='FTP_ACCOUNT'  name='FTP_ACCOUNT' style='width:50%' onClick='accountPopupList();' readonly/>
										</td>
									</tr>
									<tr>
										<td></td>
										<td style='text-align:center;'>
											<label for='FTP_USE_DEF_NUMRETRIES' style='width:50%'>
												<input type='checkbox' name='FTP_USE_DEF_NUMRETRIES' id='FTP_USE_DEF_NUMRETRIES' value='1' onclick='ftp_use_def_numretries_check()' checked='checked'/> 
												Use default number of retries&nbsp;&nbsp;&nbsp;&nbsp;
											</label>
											Number of retries :
											<input class='input' type='text' id='FTP_NUM_RETRIES' name='FTP_NUM_RETRIES' value='5' style='background-color: #e2e2e2;' placeholder='(0~99 number)' />
										</td>
										<td style='text-align:center;'>
											<label for='FTP_RPF'>
												<input type='checkbox' name='FTP_RPF' id='FTP_RPF' value='1' onclick='checkBoxValue(this)'/> 
													Rerun from point of failure
											</label>
										</td>
										<td style='text-align:center;'>
											<label for='FTP_CONT_EXE_NOTOK'><input type='checkbox' name='FTP_CONT_EXE_NOTOK' id='FTP_CONT_EXE_NOTOK' value='1' onclick='checkBoxValue(this)'/> 
												End job NOTOK when 'Continue on failure' option is selected
											</label>
										</td>
									</tr>
									<tr>
										<th id='host11' colspan='2' style='text-align: center;'>HOST1 :   TYPE :   User : </th>
										<th id='host21' colspan='2' style='text-align: center;'>HOST2 :   TYPE :   User : </th>
									</tr>
									<tr>
										<td>
											<div class='cellTitle_ez_center'>Type</div>
										</td>
										<td>
											<div class='cellTitle_ez_center'>출발지</div>
										</td>
										<td>
											<div class='cellTitle_ez_center'>전송타입</div>
										</td>
										<td>
											<div class='cellTitle_ez_center'>도착지</div>
										</td>
									</tr>
									<%
										for(int i=1; i < 6; i++){
											out.println("<tr>");
											out.println("<td>");
											out.println("<div style='text-align:center'>");
											out.println("<select name='FTP_TYPE"+i+"' id='FTP_TYPE"+i+"' style='width:70%;height:21px;'>");
											out.println("<option value='I'>Binary</option>");
											out.println("<option value='A'>Ascii</option>");
											out.println("</select>");
											out.println("</div>");
											out.println("</td>");
											out.println("<td><input type='text' id='FTP_LPATH"+i+"' name='FTP_LPATH"+i+"' style='width:100%'/></td>");
											out.println("<td>");
											out.println("<div style='text-align:center'>");
											out.println("<select name='FTP_UPLOAD"+i+"' id='FTP_UPLOAD"+i+"' >");
											out.println("<option value='1'>--></option>");
											out.println("<option value='0'><--</option>");
											out.println("<option value='2'><-O</option>");
											out.println("<option value='3'>O-></option>");
											out.println("<option value='4'>-O-</option>");
											out.println("</select>&nbsp;");
											out.println("</div>");
											out.println("</td>");
											out.println("<td><input type='text' id='FTP_RPATH"+i+"' name='FTP_RPATH"+i+"' style='width:100%'/></td>");
											out.println("</tr>");
										}
									%>
								</table>
							</td>
						</tr>
					</table>
				
				<table style="width:100%;display:none;" id="kubernetes_yn">
					<tr>
						<td>
							<div class='cellTitle_kang5'> Kubernetes </div>
						</td>
					</tr>
					<tr>
						<td valign="top">
							<table style="width:100%;">
								<tr>
									<td width="10%"></td>
									<td width="20%"></td>
									<td width="10%"></td>
									<td width="20%"></td>
									<td width="10%"></td>
									<td width="20%"></td>
								</tr>
								<tr>
									<td>
										<div class='cellTitle_ez_right'>Connection Profile</div>
									</td>
									<td>
										<div class='cellContent_kang'>
											<%=con_pro%>
										</div>
									</td>
									<td>
										<div class='cellTitle_ez_right'>Job Spec Type</div>
									</td>
									<td>
										<div class='cellContent_kang'>
											<%=job_spec_type%>
										</div>
									</td>
									<td>
										<div class='cellTitle_ez_right'>Job Spec Yaml</div>
									</td>
									<td>	
										<div class='cellContent_kang'>
											<%=yaml_file%>
											<input type='hidden' name='file_content' id="file_content" value="<%=file_content%>"/>
										</div>
									</td>
								</tr>
								<tr>
									<td>
										<div class='cellTitle_ez_right'>Job Spec Parameter</div>
									</td>
									<td colspan="3">
										<div class='cellContent_kang'>
											<%=spec_param%>
										</div>
									</td>
									<td>
										<div class='cellTitle_ez_right'>OS Exit Code</div>
									</td>
									<td>
										<div class='cellContent_kang'>
											<%=os_exit_code%>
										</div>
									</td>
								</tr>
								<tr>
									<td>
										<div class='cellTitle_ez_right'>Get Pod Logs</div>
									</td>
									<td>
										<div class='cellContent_kang'>
											<%=get_pod_logs%>
										</div>
									</td>
									<td>
										<div class='cellTitle_ez_right'>Job Cleanup</div>
									</td>
									<td>
										<div class='cellContent_kang'>
											<%=job_cleanup%>
										</div>
									</td>
									<td>
										<div class='cellTitle_ez_right'>Polling Interval</div>
									</td>
									<td>
										<div class='cellContent_kang'>
											<%=polling_interval%>
										</div>
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
				<table style="width:100%;display:none;" id="database_tb">
					<tr>
						<td>
							<div class='cellTitle_kang5'>Database</div>
						</td>
					</tr>
					<tr>
						<td valign="top">
							<table style="width:100%;">
								<tr>
									<td width="10%"></td>
									<td width="20%"></td>
									<td width="10%"></td>
									<td width="20%"></td>
									<td width="10%"></td>
									<td width="20%"></td>
								</tr>
								<tr>
									<td>
										<div class='cellTitle_ez_right'>Connection Profile</div>
									</td>
									<td>
										<div class='cellContent_kang'>
											<%=db_con_pro %>
										</div>
									</td>
									<td>
										<div class='cellTitle_ez_right'>Database</div>
									</td>
									<td>	
										<div class='cellContent_kang'>
										<%for(int i=0;i<databaseList.size();i++){ 
											CommonBean databaseBean = (CommonBean) databaseList.get(i);
											String strDatabaseName = CommonUtil.isNull(databaseBean.getDatabase_name());
											String strSid = CommonUtil.isNull(databaseBean.getAccess_sid());
											String strServiceName = CommonUtil.isNull(databaseBean.getAccess_service_name());
											
											out.println(!strDatabaseName.equals("") ? strDatabaseName : (!strSid.equals("") ? strSid : strServiceName));
										}
										%>
											<input type='hidden' name='database_type' id="database_type" />
										</div>
									</td>
									<td>
										<div class='cellTitle_ez_right'>Execution Type</div>
									</td>
									<td>
										<div class='cellContent_kang'>
											<select id='execution_type' name='execution_type' style="width:40%;height:21px;" disabled>
												<option value="">--선택--</option>
												<option value="P">Stored Procedure</option>
												<option value="Q">Embedded Query</option>
											</select>
										</div>
									</td>
								</tr>
								<tr id="db_p_tr" style="display:none;">
									<td>
										<div class='cellTitle_ez_right'>Schema</div>
									</td>
									<td>
										<div class='cellContent_kang'>
											<%=schema %>
										</div>
									</td>
									<td>
										<div class='cellTitle_ez_right'>Name</div>
									</td>
									<td colspan="2">
										<div class='cellContent_kang'>
											<%=sp_name %>
										</div>
									</td>
								</tr>
								<tr id="param_tr" style="display:none;" >
									<td colspan="6">
										<div class='cellTitle_kang6'> Parameter </div>
									</td>
								</tr>
								<tr id="param_header_tr" style="display:none;">
									<td colspan="2" width="30%"><div class='cellTitle_ez_center'>Name</div></td>
									<td  width="10%"><div class='cellTitle_ez_center'>Data Type</div></td>
									<td  width="20%"><div class='cellTitle_ez_center'>Parameter Type</div></td>
									<td  width="10%"><div class='cellTitle_ez_center'>Value</div></td>
									<td  width="20%"><div class='cellTitle_ez_center'>Variable</div></td>
								</tr>
								<%
							  		// 데이터를 그룹화하기 위해 Map 사용
								    Map<String, Map<String, String>> groupedData = new LinkedHashMap<>();
									String s = "";
									int tagIdx = 0;
									for(int i=0;i<inOutList.size(); i++){ 
										 CommonBean commonBean = inOutList.get(i);
								        String varName = commonBean.getVar_name();
								        String varValue = commonBean.getVar_value();

								        // 키 추출 (P001, P002 등)
								        String key = varName.substring("%%DB-STP_PARAMS-".length(), varName.indexOf("-PRM"));

								        // 그룹이 존재하지 않으면 초기화
								        if (!groupedData.containsKey(key)) {
								            groupedData.put(key, new HashMap<String, String>()); // 명시적으로 타입 지정
								        }

								        // 그룹에 데이터 삽입 (PRM_NAME, PRM_TYPE, PRM_DIRECTION 등)
								        String fieldType = varName.substring(varName.indexOf("-PRM_") + 1); // PRM_NAME, PRM_TYPE 등
								        groupedData.get(key).put(fieldType, varValue);
									}
									
									// HTML 테이블 생성
								    for (Map.Entry<String, Map<String, String>> entry : groupedData.entrySet()) {
								        String key = entry.getKey();
								        Map<String, String> fields = entry.getValue();

								        // 필요한 필드 가져오기
								        String prmName = fields.getOrDefault("PRM_NAME", "");
								        String prmType = fields.getOrDefault("PRM_TYPE", "");
								        String prmDirection = fields.getOrDefault("PRM_DIRECTION", "");
								        String prmSetVar = fields.getOrDefault("PRM_SETVAR", ""); // 없으면 빈 문자열
								        String prmValue = fields.getOrDefault("PRM_VALUE", ""); // 없으면 빈 문자열
										
								        if( (prmDirection.equals("Out") || prmDirection.equals("void")) || prmType.equals("Return") ){
								        	s += "<tr>";
											s += "<td colspan='2' width='30%' style='text-align:center;'>";
											s += "<div class='cellContent_kang_center'>";
											s += prmName;
											s += "<input type='hidden' name='ret_data"+tagIdx+"' id='ret_data"+tagIdx+"'   value='"+prmType+"'>";
											s += "<input type='hidden' name='ret_name"+tagIdx+"' id='ret_name"+tagIdx+"'   value='"+prmName+"'>";
											s += "<input type='hidden' name='ret_param"+tagIdx+"' id='ret_param"+tagIdx+"' value='"+prmDirection+"'>";
											s += "</div>";
											s += "</td>";
											s += "<div id='div_param"+tagIdx+"'></div>";
											s += "<td width='10%' style='text-align:center;'><div class='cellContent_kang_center'>"+prmDirection+"</div></td>";
											s += "<td width='20%' style='text-align:center;'><div class='cellContent_kang_center'>"+prmType+"</div></td>";
											s += "<td width='10%' style='text-align:center;'><input type='hidden' class='input' name='ret_variable"+tagIdx+"' id='ret_variable"+tagIdx+"' value='"+prmSetVar+"'/></td>";
											s += "<td width='20%' style='text-align:center;'><div class='cellContent_kang_center'>"+prmSetVar+"</div></td>";
											s += "</tr>";
									        tagIdx++;
								        }else{
								        	s += "<tr>";
											s += "<td colspan='2' width='30%' style='text-align:center;'>";
											s += "<div class='cellContent_kang_center'>";
											s += prmName;
											s += "<input type='hidden' name='in_data"+tagIdx+"' id='in_data"+tagIdx+"'   value='"+prmType+"'>";
											s += "<input type='hidden' name='in_name"+tagIdx+"' id='in_name"+tagIdx+"'   value='"+prmName+"'>";
											s += "<input type='hidden' name='in_param"+tagIdx+"' id='in_param"+tagIdx+"' value='"+prmDirection+"'>";
											s += "</div>";
											s += "</td>";
											s += "<div id='div_param"+tagIdx+"'></div>";
											s += "<td width='10%' style='text-align:center;'><div class='cellContent_kang_center'>"+prmDirection+"</div></td>";
											s += "<td width='20%' style='text-align:center;'><div class='cellContent_kang_center'>"+prmType+"</div></td>";
											s += "<td width='10%' style='text-align:center;'><div class='cellContent_kang_center'>"+prmValue+"</div></td>";
											s += "<td width='20%' style='text-align:center;'><input type='hidden' class='input' name='in_value"+tagIdx+"' id='in_value"+tagIdx+"' value='"+prmValue+"'/></td>";
											s += "</tr>";
									        tagIdx++;
								        }
								    }
									out.println(s);
								%>
								<tr id="db_q_tr" style="display:none;">
									<td>
										<div class='cellTitle_ez_right' style="display: flex;justify-content: flex-end;align-items: center;height: 150px;text-align: right;">Query</div>
									</td>
									<td colspan="5">
										<div class='cellContent_kang' style="height: 150px">
											<textarea name="query" id="query" style="width:62%;height:150px;" cols="30" rows="5" readonly><%=query %></textarea>
										</div>
									</td>
								</tr>
								
								<tr id="db_o_tr">
									<td>
										<div class='cellTitle_ez_right'>추가옵션</div>
									</td>
									<td style='text-align:center;'>
										<label for='DB_AUTOCOMMIT' style='width:50%'>
										<input type='checkbox' name='chk_db_autocommit' id='chk_db_autocommit' <%=db_autocommit.equals("Y") ? "checked" : "" %> disabled/>
											Enable Auto Commit&nbsp;&nbsp;&nbsp;&nbsp;
										</label>
										<input type='hidden' name='db_autocommit' id="db_autocommit" />
									</td>
									<td style='text-align:center;'  colspan="2">
										<label for='DB_APPEND_LOG'>
										<input type='checkbox' name='chk_db_append_log' id='chk_db_append_log' <%=append_log.equals("Y") ? "checked" : "" %> disabled/>
											Append execution log to Job Output
										</label>
										<input type='hidden' name='append_log' id="append_log" />
									</td>
									<td style='text-align:center;' colspan="2">
										<label for='DB_APPEND_OUTPUT'><input type='checkbox' name='chk_db_append_output' id='chk_db_append_output' <%=append_output.equals("Y") ? "checked" : "" %> disabled/>
											Append SQL output to Job Output 
										</label>
										<input type='hidden' name='append_output' id="append_output" />
										(Output format : <select id='sel_db_output_format' name='sel_db_output_format' style="width:100px;height:21px;" disabled>
												<option value='T'>TEXT</option>
												<option value='X'>XML</option>
												<option value='C'>CSV</option>
												<option value='H'>HTML</option>
											</select>
											<input type="text" name=csv_seperator id="csv_seperator" value="<%=csv_seperator %>" style="height:21px; display:none; width:45px;" disabled/>)
									</td>
							</table>
						</td>
					</tr>
				</table>
				<table style="width:100%">
					<tr>
						<td>
							<div class='cellTitle_kang5'>스케쥴 정보
							<input type='button' name='btn_CalDetail' value='미리보기' onClick="CalDetail();" class='btn_white_h24'>
							</div>
						</td>	
					</tr>
					<tr>
						<td valign="top">
								<table style="width:100%;">
									<tr>
										<td width="11%"></td>
										<td width="22%"></td>
										<td width="11%"></td>
										<td width="22%"></td>
										<td width="11%"></td>
										<td width="22%"></td>
									</tr>
									
									<tr>
										<td>
											<div class='cellTitle_ez_right'>실행날짜</div>
										</td>
										<td>
											<div class='cellContent_kang'>
												<%=strMonth_days%>
											</div>
										</td>
										<td>
											<div class='cellTitle_ez_right'>조건</div>
										</td>
										<td>
											<div class='cellContent_kang'>
												<select id='schedule_and_or' name='schedule_and_or' style="width:100px;height:21px;" disabled>
												<%
													aTmp = CommonUtil.getMessage("JOB.AND_OR").split(",");
													for ( int i = 0; i < aTmp.length; i++ ) {
														String[] aTmp1 = aTmp[i].split("[|]");
												%>
														<option value='<%=aTmp1[0]%>' <%= ( (aTmp1[0].equals(strSchedule_and_or))? " selected ":"" ) %> ><%=aTmp1[1]%></option>
												<%
													}
												%>
												</select>
											</div>
										</td>
										<td>
											<div class='cellTitle_ez_right'>실행요일</div>
										</td>
										<td>
											<div class='cellContent_kang'>
												<%=strTempWeekDays2%>
												<%--<%=CommonUtil.E2K(docBean.getWeek_days()).replaceAll("'0'","<span style='color:red;'>일</span>").replaceAll("'1'","월").replaceAll("'2'","화").replaceAll("'3'","수").replaceAll("'4'","목").replaceAll("'5'","금").replaceAll("'6'","<span style='color:blue;'>토</span>").replaceAll("W월","<span style='color:#686667;'>W1</span>").replaceAll("W화","<span style='color:#686667;'>W2</span>").replaceAll("W수","<span style='color:#686667;'>W3</span>").replaceAll("W목","<span style='color:#686667;'>W4</span>").replaceAll("W금","<span style='color:#686667;'>W5</span>").replaceAll("W토","<span style='color:#686667;'>W6</span>").replaceAll("W일","<span style='color:#686667;'>W0</span>")%>--%>
											</div>
										</td>
									</tr>
									<tr>
										<td>
											<div class='cellTitle_ez_right'>월 캘린더</div>
										</td>
										<td>
											<div class='cellContent_kang'>
												<%=strDays_cal%>
											</div>
										</td>
										<td></td>
										<td></td>
										<td>
											<div class='cellTitle_ez_right'>일 캘린더</div>
										</td>
										<td>
											<div class='cellContent_kang'>
												<%=strWeeks_cal%>
											</div>
										</td>
									</tr>
									<tr>
										<td>
											<div class='cellTitle_ez_right'>CONF_CAL</div>
										</td>
										<td>
											<div class='cellContent_kang'>
												<%=strConfCal%>
											</div>
										</td>
										<td>
											<div class='cellTitle_ez_right'>POLICY</div>
										</td>
										<td>
											<div class='cellContent_kang'>
												<%=strShift%>
											</div>
										</td>
										<td>
											<div class='cellTitle_ez_right'>SHIFT</div>
										</td>
										<td>
											<div class='cellContent_kang'>
												<%=strShiftNum %>
											</div>
										</td>
									</tr>
									<tr>
										<td ><div class='cellTitle_ez_right'>1월~6월</div></td>
										<td colspan="2"><div class='cellContent_kang'>
										<%
											for ( int i = 0; i < 6; i++ ) {
												out.println("<select id='month_"+(i+1)+"' name='month_"+(i+1)+"' style='width:15%;height:21px;' disabled>");
												aTmp = CommonUtil.getMessage("JOB.CAL_OPT").split(",");
												for(int j=0;j<aTmp.length; j++){
													String[] aTmp1 = aTmp[j].split("[|]");
													out.println("<option value='"+aTmp1[0]+"' "+( (aTmp1[0].equals(docBean.getMonth(i+1)))? " selected ":"" )+" >"+aTmp1[1]+"</option>");
												}
												out.println("</select>");
											}
										%>
										</div></td>
										<td>
										</td>
										<td>
											<div class='cellTitle_ez_right'>수행 범위일</div>
										</td>
										<td colspan='5' >
											<div class='cellContent_kang'>
												<%=strActiveFrom%> ~ <%=strActiveTill%>
											</div>
										</td>
									</tr>
									<tr>
										<td ><div class='cellTitle_ez_right'>7월~12월</div></td>
										<td colspan="2"><div class='cellContent_kang'>
										<%
											for ( int i = 6; i < 12; i++ ) {
												out.println("<select id='month_"+(i+1)+"' name='month_"+(i+1)+"' style='width:15%;height:21px;' disabled>");
												aTmp = CommonUtil.getMessage("JOB.CAL_OPT").split(",");
												for(int j=0;j<aTmp.length; j++){
													String[] aTmp1 = aTmp[j].split("[|]");
													out.println("<option value='"+aTmp1[0]+"' "+( (aTmp1[0].equals(docBean.getMonth(i+1)))? " selected ":"" )+" >"+aTmp1[1]+"</option>");
												}
												out.println("</select>");
											}
										%>
										</div></td>
									</tr>
									<tr>
										<td ><div class='cellTitle_ez_right'>특정실행날짜</div></td>
										<td><div class='cellContent_kang'><%=t_general_date%><div></td>
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
									<div class='cellTitle_kang5'>선행작업조건</div>
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
									<div class='cellTitle_kang5'><font color="red">* </font>후행작업조건 (자기작업 CONDITION)</div>
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
						<td style="width:100%;">
							<table style="width:100%;">
							<tr>
								<td style="width:76%;height:21px;">
									<div class='cellTitle_kang5'>후행 작업정보</div>
								</td>
							</tr>
							</table>
							<table style="width:100%;height:100%;border:none;">
							<% if(outCondList.size() > 0){

        							String out_cond_name 	= "";
        							String	out_sched_table	= "";
        							String	out_application	= "";
        							String	out_group_name	= "";
        							String	out_data_center	= "";

        							for( int i=0; null!=outCondList && i<outCondList.size(); i++ ){

        								JobLogBean bean3 = (JobLogBean)outCondList.get(i);

										out_cond_name 	= CommonUtil.isNull(bean3.getJob_name());
										out_sched_table = CommonUtil.isNull(bean3.getSched_table());
										out_application = CommonUtil.isNull(bean3.getApplication());
										out_group_name 	= CommonUtil.isNull(bean3.getGroup_name());
										out_data_center = CommonUtil.isNull(bean3.getData_center());

        						%>
		        						<tr>
											<td width="11%"></td>
											<td width="33%"></td>
											<td width="11%"></td>
											<td width="33%"></td>
										</tr>
			  								<td>
												<div class='cellTitle_ez_right'>후행작업명</div>
											</td>
			  								<td>
			       								<div class='cellContent_kang'>
			       									<%=out_cond_name%>
			       								</div>
			       						    </td>
			       						    <td>
												<div class='cellTitle_ez_right'>폴더/어플리케이션/그룹</div>
											</td>
			  								<td>
			       								<div class='cellContent_kang'>
 													<%=out_sched_table%> > <%=out_application%> > <%=out_group_name%>
			       								</div>
			       						    </td>
			       						  </tr>
        							<% }%>
        						<% } %>
							</table>
						</td>
					</tr>
					</table>
				<table style="width:100%">
					<tr>
						<td>
							<div class='cellTitle_kang5'>담당자 정보</div>
						</td>
					</tr>
					<tr>
						<td valign="top">

							<input type='hidden' id='user_cd_1_0' name='user_cd_1_0' value='<%=strUserCd1%>' />
							<input type='hidden' id='user_cd_2_0' name='user_cd_2_0' value='<%=strUserCd2%>' />
							<input type='hidden' id='user_cd_3_0' name='user_cd_3_0' value='<%=strUserCd3%>' />
							<input type='hidden' id='user_cd_4_0' name='user_cd_4_0' value='<%=strUserCd4%>' />
							<input type='hidden' id='user_cd_5_0' name='user_cd_5_0' value='<%=strUserCd5%>' />
							<input type='hidden' id='user_cd_6_0' name='user_cd_6_0' value='<%=strUserCd6%>' />
							<input type='hidden' id='user_cd_7_0' name='user_cd_7_0' value='<%=strUserCd7%>' />
							<input type='hidden' id='user_cd_8_0' name='user_cd_8_0' value='<%=strUserCd8%>' />
							<input type='hidden' id='user_cd_9_0' name='user_cd_9_0' value='<%=strUserCd9%>' />
							<input type='hidden' id='user_cd_10_0' name='user_cd_10_0' value='<%=strUserCd10%>' />

							<input type='hidden' id='grp_cd_1_0' name='grp_cd_1_0' value='<%=strGrpCd1%>' />
							<input type='hidden' id='grp_cd_2_0' name='grp_cd_2_0' value='<%=strGrpCd2%>' />
							<table style="width:100%;">
								<tr>
									<td width="11%"></td>
									<td width="11%"></td>
									<td width="22%"></td>
									<td width="11%"></td>
									<td width="11%"></td>
									<td width="22%"></td>
								</tr>
								<tr>
									<td>
										<div class='cellTitle_ez_right'><font color="red">* </font>담당자1</div>
									</td>

									<td>
										<div class='cellContent_kang'>
											<%=strUserNm1 %>
										</div>
									</td>
									<td>
										<div class='cellContent_kang'>
											<%=strSms%><input type='checkbox' name='sms_1_0' id='sms_1_0' <%if(strSms1.equals("Y")){%>value='Y' checked<%}else{%>value='N'<%} %>  disabled/>
											<%=strMail%><input type='checkbox' name='mail_1_0' id='mail_1_0' <%if(strMail1.equals("Y")){%>value='Y' checked<%}else{%>value='N'<%}%> disabled/>
										</div>
									</td>
									<td>
										<div class='cellTitle_ez_right'>담당자2</div>
									</td>
									<td>
										<div class='cellContent_kang'>
											<%=strUserNm2 %>
										</div>
									</td>
									<td>
										<div class='cellContent_kang'>
											<%=strSms%><input type='checkbox' name='sms_2_0' id='sms_2_0' <%if(strSms2.equals("Y")){%>value='Y' checked<%}else{%>value='N'<%} %> disabled />
											<%=strMail%><input type='checkbox' name='mail_2_0' id='mail_2_0' <%if(strMail2.equals("Y")){%>value='Y' checked<%}else{%>value='N'<%}%> disabled />
										</div>
									</td>
								</tr>

								<tr>
									<td>
										<div class='cellTitle_ez_right'>담당자3</div>
									</td>
									<td>
										<div class='cellContent_kang'>
											<%=strUserNm3 %>
										</div>
									</td>
									<td>
										<div class='cellContent_kang'>
											<%=strSms%><input type='checkbox' name='sms_3_0' id='sms_3_0' <%if(strSms3.equals("Y")){%>value='Y' checked<%}else{%>value='N'<%} %> disabled />
											<%=strMail%><input type='checkbox' name='mail_3_0' id='mail_3_0' <%if(strMail3.equals("Y")){%>value='Y' checked<%}else{%>value='N'<%}%> disabled />
										</div>
									</td>
									<td>
										<div class='cellTitle_ez_right'>담당자4</div>
									</td>

									<td>
										<div class='cellContent_kang'>
											<%=strUserNm4 %>
										</div>
									</td>
									<td>
										<div class='cellContent_kang'>
											<%=strSms%><input type='checkbox' name='sms_4_0' id='sms_4_0' <%if(strSms4.equals("Y")){%>value='Y' checked<%}else{%>value='N'<%} %> disabled />
											<%=strMail%><input type='checkbox' name='mail_4_0' id='mail_4_0' <%if(strMail4.equals("Y")){%>value='Y' checked<%}else{%>value='N'<%}%> disabled  />
										</div>
									</td>
								</tr>
								<tr>
									<td>
										<div class='cellTitle_ez_right'>담당자5</div>
									</td>
									<td>
										<div class='cellContent_kang'>
											<%=strUserNm5 %>
										</div>
									</td>
									<td>
										<div class='cellContent_kang'>
											<%=strSms%><input type='checkbox' name='sms_5_0' id='sms_5_0' <%if(strSms5.equals("Y")){%>value='Y' checked<%}else{%>value='N'<%} %> disabled />
											<%=strMail%><input type='checkbox' name='mail_5_0' id='mail_5_0' <%if(strMail5.equals("Y")){%>value='Y' checked<%}else{%>value='N'<%}%> disabled />
										</div>
									</td>
									<td>
										<div class='cellTitle_ez_right'>담당자6</div>
									</td>

									<td>
										<div class='cellContent_kang'>
											<%=strUserNm6 %>
										</div>
									</td>
									<td>
										<div class='cellContent_kang'>
											<%=strSms%><input type='checkbox' name='sms_6_0' id='sms_6_0' <%if(strSms6.equals("Y")){%>value='Y' checked<%}else{%>value='N'<%} %> disabled />
											<%=strMail%><input type='checkbox' name='mail_6_0' id='mail_6_0' <%if(strMail6.equals("Y")){%>value='Y' checked<%}else{%>value='N'<%}%> disabled  />
										</div>
									</td>
								</tr>
								<tr>
									<td>
										<div class='cellTitle_ez_right'>담당자7</div>
									</td>
									<td>
										<div class='cellContent_kang'>
											<%=strUserNm7 %>
										</div>
									</td>
									<td>
										<div class='cellContent_kang'>
											<%=strSms%><input type='checkbox' name='sms_7_0' id='sms_7_0' <%if(strSms7.equals("Y")){%>value='Y' checked<%}else{%>value='N'<%} %> disabled />
											<%=strMail%><input type='checkbox' name='mail_7_0' id='mail_7_0' <%if(strMail7.equals("Y")){%>value='Y' checked<%}else{%>value='N'<%}%> disabled />
										</div>
									</td>
									<td>
										<div class='cellTitle_ez_right'>담당자8</div>
									</td>

									<td>
										<div class='cellContent_kang'>
											<%=strUserNm8 %>
										</div>
									</td>
									<td>
										<div class='cellContent_kang'>
											<%=strSms%><input type='checkbox' name='sms_8_0' id='sms_8_0' <%if(strSms8.equals("Y")){%>value='Y' checked<%}else{%>value='N'<%} %> disabled />
											<%=strMail%><input type='checkbox' name='mail_8_0' id='mail_8_0' <%if(strMail8.equals("Y")){%>value='Y' checked<%}else{%>value='N'<%}%> disabled  />
										</div>
									</td>
								</tr>
								<tr>
									<td>
										<div class='cellTitle_ez_right'>담당자9</div>
									</td>
									<td>
										<div class='cellContent_kang'>
											<%=strUserNm9 %>
										</div>
									</td>
									<td>
										<div class='cellContent_kang'>
											<%=strSms%><input type='checkbox' name='sms_9_0' id='sms_9_0' <%if(strSms9.equals("Y")){%>value='Y' checked<%}else{%>value='N'<%} %> disabled />
											<%=strMail%><input type='checkbox' name='mail_9_0' id='mail_9_0' <%if(strMail9.equals("Y")){%>value='Y' checked<%}else{%>value='N'<%}%> disabled />
										</div>
									</td>
									<td>
										<div class='cellTitle_ez_right'>담당자10</div>
									</td>

									<td>
										<div class='cellContent_kang'>
											<%=strUserNm10 %>
										</div>
									</td>
									<td>
										<div class='cellContent_kang'>
											<%=strSms%><input type='checkbox' name='sms_10_0' id='sms_10_0' <%if(strSms10.equals("Y")){%>value='Y' checked<%}else{%>value='N'<%} %> disabled />
											<%=strMail%><input type='checkbox' name='mail_10_0' id='mail_10_0' <%if(strMail10.equals("Y")){%>value='Y' checked<%}else{%>value='N'<%}%> disabled  />
										</div>
									</td>
								</tr>
								<tr>
									<td>
										<div class='cellTitle_ez_right'>그룹1</div>
									</td>
									<td>
										<div class='cellContent_kang'>
											<%=strGrpNm1 %>
										</div>
									</td>
									<td>
										<div class='cellContent_kang'>
											<%=strSms%><input type='checkbox' name='grp_sms_1_0' id='grp_sms_1_0' <%if(strGrpSms1.equals("Y")){%>value='Y' checked<%}else{%>value='N'<%} %> disabled />
											<%=strMail%><input type='checkbox' name='grp_mail_1_0' id='grp_mail_1_0' <%if(strGrpMail1.equals("Y")){%>value='Y' checked<%}else{%>value='N'<%}%> disabled  />
										</div>
									</td>
									<td>
										<div class='cellTitle_ez_right'>그룹2</div>
									</td>
									<td>
										<div class='cellContent_kang'>
												<%=strGrpNm2 %>
										</div>
									</td>
									<td>
										<div class='cellContent_kang'>
											<%=strSms%><input type='checkbox' name='grp_sms_2_0' id='grp_sms_2_0' value='Y' <%if(strGrpSms2.equals("Y")){%>value='Y' checked<%}else{%>value='N'<%} %> disabled />
											<%=strMail%><input type='checkbox' name='grp_mail_2_0' id='grp_mail_2_0' value='Y' <%if(strGrpMail2.equals("Y")){%>value='Y' checked<%}else{%>value='N'<%}%> disabled  />
										</div>
									</td>
								</tr>
							</table>
							<table style="width:100%;">
								<tr>
									<td colspan="6">
										<table style="width:100%;">
											<tr>
												<td colspan = "5">
													<div class='cellTitle_kang5'>RESOURCE</div>
												</td>
											</tr>
										</table>
									</td>
								</tr>
								<tr>
								<td style='width:8%'><div class='cellTitle_ez_center'>Name</div></td>
								<td style='width:86%'><div class='cellTitle_ez_left'>Required Usage</div></td>
								</tr>
							</table>

							<table style="width:100%;height:100%;border:none;" id="resQTable">
								<%
									if( null!=docBean.getT_resources_q() && docBean.getT_resources_q().trim().length()>0 ){
										aTmpT = CommonUtil.E2K(docBean.getT_resources_q()).split("[|]");
										for(int t=0; null!=aTmpT&&t<aTmpT.length; t++ ){
											String[] aTmpT1 = aTmpT[t].split(",",2);

								%>
								<tr>
									<td style='width:8%; text-align:center;word-break: break-all;'><%=aTmpT1[0] %></td>
									<td style='width:86%; text-align:left; padding-left:10px;'>
										<%=aTmpT1[1] %>
									</td>
								</tr>
								<%
										}
									}
								%>
							</table>
							<table style="width:100%;">
								<tr>
									<td colspan="6">
										<table style="width:100%;">
											<tr>
												<td colspan = "5">
													<div class='cellTitle_kang5'>변수</div>
												</td>
											</tr>
										</table>
									</td>
								</tr>
								<tr>
									<td style='width:8%;'><div class='cellTitle_ez_center'>변수 이름</div></td>
									<td style='width:86%;'><div class='cellTitle_ez_left'>변수 값</div></td>
								</tr>
							</table>

							<table style="width:100%;height:100%;border:none;" id="userVar">
								<%
									if( null!=docBean.getT_set() && docBean.getT_set().trim().length()>0 ){
										aTmpT = CommonUtil.E2K(docBean.getT_set()).split("[|]");
										for(int t=0; null!=aTmpT&&t<aTmpT.length; t++ ){
											String[] aTmpT1 = aTmpT[t].split(",",2);
											if(!(strTaskType.equals("Kubernetes") && aTmpT1[0].startsWith("UCM"))){
												if(!(strTaskType.equals("MFT") && aTmpT1[0].startsWith("FTP"))){
													if(!(strTaskType.equals("Database") && aTmpT1[0].startsWith("DB"))){
								%>
								<tr>
									<td style='width:8%;text-align:center; word-break: break-all;'><%=aTmpT1[0] %></td>
									<td style='width:86%; text-align:left; padding-left:10px; word-break: break-all;'>
										<%=CommonUtil.replaceHtmlStr(aTmpT1[1]) %>
									</td>
								</tr>
								<%
													}
												}
											}
										}
									}
								%>
							</table>
							<table style="width:100%;">
								<tr>
									<td colspan = "4">
										<div class='cellTitle_kang5'>ON/DO</div>
									</td>
								</tr>
							</table>
							<table style="width:100%;">
								<tr>
									<td style="width:6%;height:21px;">
										<div class='cellTitle_ez_center'>ON/DO</div>
									</td>
									<td style="width:6%;height:21px;">
										<div class='cellTitle_ez_center'>TYPE</div>
									</td>
									<td style="width:60%;height:21px;">
										<div class='cellTitle_ez_left'>PARAMETERS</div>
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
											out.println("<td style='width:6%;height:21px;text-align:center;'>");
											aTmp = CommonUtil.getMessage("JOB.STEP_OPT").split(",");
											for(int i=0;i<aTmp.length; i++){
												String[] aTmp1 = aTmp[i].split("[|]");
												out.println(( (aTmp1[0].equals(aTmpT1[0]))? aTmp1[1]:"" ));
											}
											out.println("</td>");
											out.println("<td style='width:6%;height:21px;text-align:center;'>");
											out.println("<div id='div_step_type"+t+"'>");
											String aTmpT2[] = aTmpT[t].split(",");
											if( "O".equals(aTmpT1[0]) ){
												aTmp = CommonUtil.getMessage("TABLE.STEP_ON_TYPE").split(",");
												String aTmpt3[] = aTmpT2[3].split(" ");
												if(aTmpT1[3].split(" ").length > 1){
													for(int i=0;i<aTmp.length; i++){
														String[] aTmp1 = aTmp[i].split("[|]");
														out.println(( (aTmp1[1].equals(aTmpt3[0]))? aTmp1[0]:"" ));
													}
												}else if(aTmpT1[3].equals("OK") || aTmpT1[3].equals("NOTOK")){
													for(int i=0;i<aTmp.length; i++){
														String[] aTmp1 = aTmp[i].split("[|]");
														out.println(( (aTmp1[1].equals(aTmpT2[3]))? aTmp1[0]:"" ));
													}
												}else{
													for(int i=0;i<aTmp.length; i++){
														String[] aTmp1 = aTmp[i].split("[|]");
														out.println(( (aTmp1[1].equals(aTmpT1[1]))? aTmpT1[1]:""));
													}
												}
											}else if( "A".equals(aTmpT1[0]) ){

												aTmp = CommonUtil.getMessage("TABLE.STEP_DO_TYPE").split(",");
												for(int i=0;i<aTmp.length; i++){
													if(aTmpT2[1].equals("SPCYC")){
														aTmp = CommonUtil.getMessage("TABLE.STEP_DO_TYPE").split(",");
														String[] aTmp1 = aTmp[i].split("[|]");
														out.println(( (aTmp1[1].equals("Stop Cyclic"))? aTmp1[0]:"" ));
													}else{
														String[] aTmp1 = aTmp[i].split("[|]");
														out.println(( (aTmp1[1].equals(aTmpT1[1]))? aTmp1[0]:"" ));
													}
												}
											}
											out.println("");

											out.println("</div></td>");
											out.println("<td style='width:60%;height:21px;text-align:left;padding-left:10px;'>");
											out.println("<div id='div_step_parameters"+t+"'>");
											if(aTmpT2[0].equals("O")){
												String aTmpt4[] = aTmpT2[3].split(" ");
												if(aTmpt4[0].equals("FAILCOUNT")){
													String aTmpt3[] = aTmpT2[3].split(" ");
													out.println(" Code : "+aTmpt3[2]);
												}else{
													if(aTmpt4[0].equals("OK") || aTmpt4[0].equals("NOTOK") || aTmpt4[0].equals("COMPSTAT") || aTmpt4[0].equals("RUNCOUNT")){
														aTmp = CommonUtil.getMessage("TABLE.STEP_ON_PARAMETERS").split(",");
														String aTmpt3[] = aTmpT2[3].split(" ");
														if(aTmpt3.length > 1){
															if(aTmpt3[2].equals("EVEN") || aTmpt3[2].equals("ODD")){
																for(int i=0;i<aTmp.length; i++){
																	String[] aTmp1 = aTmp[i].split("[|]");
																	if(aTmp1[1].equals(aTmpt3[2])){
																		out.println("Stmt : "+aTmp1[0]);
																	}

																}

															}else{
																for(int i=0;i<aTmp.length; i++){
																	String[] aTmp1 = aTmp[i].split("[|]");
																	if(aTmp1[1].equals(aTmpt3[1])){
																		out.println("Stmt : "+aTmp1[0]);
																	}
																}

																out.println(" Code : "+aTmpt3[2]);
															}
														}
													}else{
														out.println("Stmt : "+aTmpT2[2]);
														out.println("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Code : "+aTmpT2[3]);
												}

												}
											}else if(aTmpT2[0].equals("A")){
												if(aTmpT2.length > 2){
													if(aTmpT2[1].equals("Condition")){
														out.println("Name : "+aTmpT2[2]);
													    out.println(" Date : "+aTmpT2[3]);
														aTmp = CommonUtil.getMessage("JOB.STEP_SIGN").split(",");
														for(int i=0;i<aTmp.length; i++){
															String[] aTmp1 = aTmp[i].split("[|]");
															if(aTmp1[0].equals(aTmpT2[4])){
																out.println(" Sign : "+aTmp1[1]);
															}
														}

													}else if( aTmpT2[1].equals("Shout") ){
														out.println("Dest : "+aTmpT2[2]);
													    out.println(" Message : "+aTmpT2[4]);
													}else if( aTmpT2[1].equals("Mail") ){
														aTmpT1 = aTmpT[t].split(",",7);

														out.println(" To="+aTmpT1[2]+"<br/>");
														out.println(" Cc="+aTmpT1[3]+"<br/>");
														out.println(" Subject="+aTmpT1[4]+",");
														out.println(" Urgn="+CommonUtil.getMessage("JOB.STEP_URGENCY."+aTmpT1[5])+"<br/>");

														out.println(" Msg="+aTmpT1[6].replaceAll("\r\n","<br/>")+"");
													}else if( aTmpT2[1].equals("Force-Job") ){
														aTmpT1 = aTmpT[t].split(",");

														out.println(" 폴더="+aTmpT1[2]+" ");
														out.println(" 작업명="+aTmpT1[3]+" ");
														out.println(" ORDER DATE="+aTmpT1[4]);
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

</table>
</form>

<script type="text/javascript">

	var rowsObj_job1 = new Array();
	var rowsObj_job2 = new Array();
	
	//	복사, 수정, 삭제 바로가기 버튼의 노출 유무		
	var gridObj_1 = {
		id : "<%=gridId_1 %>"
		,colModel:[
			{formatter:gridCellNoneFormatter,field:'m_in_condition_parentheses_s',id:'m_in_condition_parentheses_s',name:'(',width:50,headerCssClass:'cellCenter',cssClass:'cellCenter'}
			,{formatter:gridCellNoneFormatter,field:'m_in_condition_name',id:'m_in_condition_name',name:'선행조건명',width:230,headerCssClass:'cellCenter',cssClass:'cellLeft'}
			,{formatter:gridCellNoneFormatter,field:'m_in_condition_parentheses_e',id:'m_in_condition_parentheses_e',name:')',width:50,headerCssClass:'cellCenter',cssClass:'cellCenter'}
	   		,{formatter:gridCellNoneFormatter,field:'m_in_condition_date',id:'m_in_condition_date',name:'일자유형',width:80,headerCssClass:'cellCenter',cssClass:'cellCenter'}
	   		,{formatter:gridCellNoneFormatter,field:'m_in_condition_and_or',id:'m_in_condition_and_or',name:'구분',width:80,headerCssClass:'cellCenter',cssClass:'cellCenter'}
			,{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'grid_idx',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}

	   	]
		,rows:[]
		,vscroll:false
	};

	var gridObj_2 = {
		id : "<%=gridId_2 %>"
		,colModel:[
			{formatter:gridCellNoneFormatter,field:'m_out_condition_name',id:'m_out_condition_name',name:'자기작업 CONDITION',width:320,headerCssClass:'cellCenter',cssClass:'cellLeft'}
			,{formatter:gridCellNoneFormatter,field:'m_out_condition_date',id:'m_out_condition_date',name:'일자유형',width:75,headerCssClass:'cellCenter',cssClass:'cellCenter'}
			,{formatter:gridCellNoneFormatter,field:'m_out_condition_effect',id:'m_out_condition_effect',name:'구분',width:75,headerCssClass:'cellCenter',cssClass:'cellCenter'}
			,{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'grid_idx',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
		]
		,rows:[]
		,vscroll:false
	};
	
	var accountlist = new Array("FTP_ACCOUNT"
			, "FTP_LHOST", "FTP_LOSTYPE", "FTP_LUSER", "FTP_CONNTYPE1"
			, "FTP_RHOST", "FTP_ROSTYPE", "FTP_RUSER", "FTP_CONNTYPE2"
			, "FTP_USE_DEF_NUMRETRIES", "FTP_NUM_RETRIES", "FTP_RPF", "FTP_CONT_EXE_NOTOK");

	var pathlist = new Array("FTP_LPATH", "FTP_UPLOAD", "FTP_RPATH", "FTP_TYPE");

	var advancedlist = new Array("FTP_SRCOPT", "FTP_NEWNAME", "FTP_SRC_ACT_FAIL", "FTP_IF_EXIST",
			"FTP_DSTOPT", "FTP_DEST_NEWNAME", "FTP_EMPTY_DEST_FILE_NAME",
			"FTP_FILE_PFX", "FTP_CONT_EXE", "FTP_DEL_DEST_ON_FAILURE",
			"FTP_POSTCMD_ON_FAILURE", "FTP_RECURSIVE", "FTP_ENCRYPTION1", "FTP_COMPRESSION1", "FTP_ENCRYPTION2", "FTP_COMPRESSION2",
			"FTP_PRESERVE_ATTR", "FTP_PRECOMM1", "FTP_PREPARAM11", "FTP_PREPARAM12", "FTP_POSTCOMM1",
			"FTP_POSTPARAM11", "FTP_POSTPARAM12", "FTP_PRECOMM2", "FTP_PREPARAM21", "FTP_PREPARAM22",
			"FTP_POSTCOMM2", "FTP_POSTPARAM21", "FTP_POSTPARAM22", "FTP_PGP_ENABLE", "FTP_PGP_TEMPLATE_NAME",
			"FTP_PGP_KEEP_FILES", "FTP_EXCLUDE_WILDCARD");

	$(document).ready(function(){
		
		window.focus();
		var menu_gb = "<%=menu_gb %>";

		//의뢰_수행(재작업) 화면에서 job 정보 조회시 버튼 숨김.
		if (menu_gb == "0206" || menu_gb == "") {
			$("#btn_copy").hide();
			$("#btn_copy2").hide();
			$("#btn_modify").hide();
			$("#btn_delete").hide();
		}
		
		$("#btn_copy").button().unbind("click").click(function(){
			goRefDocWrite('01','<%=CommonUtil.isNull(docBean.getJob_name()) %>');
		});
		$("#btn_copy2").button().unbind("click").click(function(){
			goRefDocWrite('02','<%=CommonUtil.isNull(docBean.getJob_name()) %>');
		});
		$("#btn_modify").button().unbind("click").click(function(){
			var jobNameChk = nameDupChk('04'); // 작업명중복체크
			if(jobNameChk == "N") {
				goRefDocWrite('04','<%=CommonUtil.isNull(docBean.getJob_name()) %>');
			}
		});
		$("#btn_delete").button().unbind("click").click(function(){
			var jobNameChk = nameDupChk('03'); // 작업명중복체크
			if(jobNameChk == "N") {
				goRefDocWrite('03','<%=CommonUtil.isNull(docBean.getJob_name()) %>');
			}
		});
		
		var taskval = $("#task_type").val();
		var mem_name = "<%=CommonUtil.E2K(docBean.getMem_name()) %>";
		var mem_lib = "<%=CommonUtil.E2K(docBean.getMem_lib()) %>";
		$('#mftTable').hide();
		//task_type이 job인 경우 프로그램위치+프로그램명 set
		if (taskval == 'job') {
			if(mem_lib.charAt(mem_lib.length-1) != '/'){ 
				$("#mem_info").text(mem_lib+'/'+mem_name);
			}
			else{
				$("#mem_info").text(mem_lib+mem_name);				
			}
		} else if( taskval == "Kubernetes" ) {
			$('#kubernetes_yn').show();
		} else if( taskval == "MFT" ) {
			$('#mftTable').show();
		}else if (taskval == "Database"){
			$('#database_tb').show();
		}

		viewGrid_1(gridObj_1,"ly_"+gridObj_1.id);
		viewGrid_1(gridObj_2,"ly_"+gridObj_2.id);
		
		//선행 추가
		<%
			if( null!=docBean.getT_conditions_in() && docBean.getT_conditions_in().trim().length()>0 ){
				aTmpT = CommonUtil.E2K(docBean.getT_conditions_in()).split("[|]");
				for(int t=0; null!=aTmpT&&t<aTmpT.length; t++ ){
					String[] aTmpT1 = aTmpT[t].split(",",3);
		%>
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
					setPreAfterJobs("<%=aTmpT[t]%>", "2", "");
		<%
				}
			}
		%>

		//시간 무시 체크 박스 추가 TO_TIME(time_until컬럼)
		var ignoreTimeUntil	= <%=ignoreTimeUntil%>;
		$("#ignore_time_until").prop("checked", ignoreTimeUntil);
		var ignore_time_until = $(this).prop("checked");
		if (ignore_time_until) {
			$("#eHour").val("");
			$("#eMin").val("");
			$("#time_until").val('>');
		}else {
			$("#time_until").val('');
		}

		if( taskval == "MFT" ) {
			var input = null;
			var tempvalue = null;
			var frm = document.frm1;
			
			for(var key in accountlist) {
				input = '#' + accountlist[key];
				$(input).attr("disabled", "disabled");
				<c:forEach var="account" items="${setvarList}" varStatus="vs">
				if($(input).attr("name") == "${account.var_name}") {
					tempvalue = "${account.var_value}";
					console.log(tempvalue);
					if($(input).attr("type") == 'checkbox') {
						if(tempvalue == 1) {
							$(input).attr("checked", true);
						} else {
							$(input).attr("checked", false);
						}
					} else {
						$(input).attr("value", tempvalue);
					}
					
					$(input).attr("disabled", true);
				}
				</c:forEach>
			}
			for(var i=0; i <= 5; i++) {
				for(var key in pathlist) {
					input = '#' + pathlist[key] + i;
	
					<c:forEach var="account" items="${setvarList}" varStatus="vs">
					if($(input).attr("name") == "${account.var_name}") {
						tempvalue = "${account.var_value}";
						$(input).val(tempvalue);
					}
					</c:forEach>
					$(input).attr("disabled", true);
				}
	
				for(var key in advancedlist) {
			
					var flag = false;
					<c:forEach var="account" items="${setvarList}" varStatus="vs">
					if(flag == false) {
						input = advancedlist[key] + i;
						if("${account.var_name}" == input) {
							input = document.createElement("input");
							$(input).attr("type","hidden");
							$(input).attr('name',advancedlist[key] + i);
							$(input).attr('id',advancedlist[key] + i);
							tempvalue = "${account.var_value}";
							$(input).attr("value", tempvalue);
							frm.appendChild(input);
							flag = true;
						}
					}
					$(input).attr("disabled", true);
					</c:forEach>
				} 
			}
	
			var host1 = 'HOST1 = ' + frm.FTP_LHOST.value; 
			var host2 = 'HOST2 = ' + frm.FTP_RHOST.value;
			
			document.getElementById("host11").innerText = host1 + '  TYPE = ' + frm.FTP_CONNTYPE1.value + ' USER = ' + frm.FTP_LUSER.value;
			document.getElementById("host21").innerText = host2 + '  TYPE = ' + frm.FTP_CONNTYPE2.value + ' USER = ' + frm.FTP_RUSER.value;
			
		}
		var execuType = '<%=execution_type%>';
		
		if(execuType == 'P'){
			$('#db_q_tr').hide();
			$('#db_p_tr').show();
			$("#param_tr").show();
			$("#param_header_tr").show();
			$('#param_header_tr').nextUntil('#db_q_tr').show();
		}else if(execuType == 'Q'){
			$('#db_q_tr').show();
			$('#db_p_tr').hide();
			$("#param_tr").hide();
			$("#param_header_tr").hide();
			$('#param_header_tr').nextUntil('#db_q_tr').remove();
		}
		
		var dbOutputFormat = '<%=db_output_format%>';
		if(dbOutputFormat == 'C'){
			$('#csv_seperator').show();
		}else {
			$('#csv_seperator').hide();
		}
		
		$("select[name='execution_type']").val("<%=execution_type%>");
		$("select[name='sel_db_output_format']").val("<%=db_output_format%>");
	});
	

	function fn_cyclic_popup() {

		var frm = document.frm1;

		openPopupCenter1("about:blank","popupCyclic",350,300);
		
		frm.action = "<%=sContextPath %>/tPopup.ez?c=ez005";
		frm.target = "popupCyclic";
		frm.submit();
	}

	function goRefDocWrite(doc_gb,job_name) {

		var table_id 	= "<%=table_id%>";		
		var job_id 		= "<%=job_id%>";
		var data_center	= "<%=strDataCenter%>";
		var sched_table	= "<%=docBean.getTable_name()%>";
		var application	= "<%=docBean.getApplication()%>";
		var task_type	= "<%=strTaskType%>";

		var param		= "table_id="+table_id+"&job_id="+job_id+"&job_name="+encodeURIComponent(job_name)+"&doc_gb="+doc_gb+"&data_center="+data_center+"&sched_table="+sched_table+"&application="+application+"&task_type="+task_type;

		opener.goWritePrc(param,doc_gb);
		
		//opener.location.href = "<%=sContextPath %>/tWorks.ez?c=ez004_w_04&flag=ref&"+encodeURIComponent(param);
		window.close();
	}
	
	function modifyBasicInfo() {
	
		$('#jobBasicKeyForm')[0].submit();
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
		var parentheses_s	= "";
		var parentheses_e	= "";

		// 등록되어 있는 선.후행 뿌려줄 경우 콤마로 구분되어 있음.
		if ( job_nm.split(",", 3) ) {
			var cond = job_nm.split(",", 3);
			job_name 	= cond[0];
			odate 		= cond[1];
			gubun 		= cond[2];
		}

		if(job_nm != ""){
			//INCONDITION  설정
			if (gb == "1") {

				if(job_name.indexOf("(") == 0) {
					job_name	= job_name.replace("(", "");
					parentheses_s = "(";
				}

				if(job_name.indexOf(")") == job_name.length-1) {
					job_name	= job_name.replace(")", "");
					parentheses_e = ")";
				}

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
					//alert("이미 등록된 내용 입니다.");
					//return;
				}else{				//중복된 내용이 없다면 (잡명)
					rowsObj_job1.push({
						'grid_idx':i
						,'m_in_condition_parentheses_s'	: parentheses_s
						,'m_in_condition_name': job_name
						,'m_in_condition_parentheses_e'	: parentheses_e
						,'m_in_condition_date': odate
						,'m_in_condition_and_or': gubun
						,'chk_condition_name': job_name
					});
					
					gridObj_1.rows = rowsObj_job1;
					setGridRows(gridObj_1);
					
					dlClose("dl_tmp1");
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
						var v_cond_nm = getCellValue(gridObj_2,aSelRow[j],'chk_condition_name');
						
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
					//alert("이미 등록된 내용 입니다.");
					//return;
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
					
					dlClose("dl_tmp1");
				}
			}
		}
	}

	function download(dt, job, file_gb){
		
		var f = document.frm_down;		
		
		f.flag.value = "job_doc01";
		f.file_gb.value = file_gb;
		f.data_center.value =  dt;
		f.job_nm.value = job;
		f.target = "if1";				
		f.action = "<%=sContextPath %>/common.ez?c=fileDownload";
		f.submit();	
	}
	
	//스케쥴 정보 미리보기
	function CalDetail() {
		var frm = document.frm_sch;
		var data_center = frm.data_center.value;
		if(data_center == ''){
			alert("이관되지 않은 작업은 스케줄 미리보기가 불가능합니다.\n이관 후 다시 시도 해주세요.");
			return;
		}
		fn_sch_forecast();
	}

	// 입력창이 아닌 조회창에서의 스케줄 미리보기
	function fn_sch_forecast() {

		var frm = document.frm_sch;

		openPopupCenter2("about:blank", "fn_sch_forecast", 1000, 500);

		frm.action = "<%=sContextPath %>/tWorks.ez?c=ez033";
		frm.target = "fn_sch_forecast";
		frm.submit();
	}
	
	//작업명중복체크
	function nameDupChk(doc_gb) {
		var result		= "N";
		var job_nm 		= '<%=CommonUtil.isNull(docBean.getJob_name()) %>';
		var data_center = "<%=strDataCenter%>";
		
		var formData = new FormData();
		formData.append("c", "JobNameDupCheck");
		formData.append("job_name", job_nm);
		formData.append("data_center", data_center);
		formData.append("doc_gb", doc_gb);

		$.ajax({
			url: "<%=sContextPath %>/tWorks.ez",
			type: "post",
			processData: false,
			contentType: false,
			dataType: "text",
			data: formData,
			async: false,
			success: completeHandler = function(data){

				result = data;

				// 앞뒤 공백 제거.
				result = result.replace(/^\s+|\s+$/g,"");

				if(result == "Y") {
					if(doc_gb == '04'){
						alert("중복된 작업명이 존재하여 수정할 수 없습니다.");						
					}else if(doc_gb == '03'){
						alert("중복된 작업명이 존재하여 삭제할 수 없습니다.");
					}
				}
			},
			error: function(data2){
				alert("error:::"+data2);
			}
		});
		return result;
	}
</script>

</body>
</html>