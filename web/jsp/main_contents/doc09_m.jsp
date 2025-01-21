<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/jsp/common/inc/header.jsp"%>
<%@ page import="java.sql.*,java.util.*,java.io.*,java.text.*,java.net.*" %>
<%@ page import="com.ghayoun.ezjobs.m.domain.*" %>
<%@ page import="com.ghayoun.ezjobs.t.domain.*" %>

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
	<script type="text/javascript" src="<%=request.getContextPath() %>/js/SlickGrid-2.1.0/plugins/slick.autocolumnsize.js" ></script>
	<script type="text/javascript" src="<%=request.getContextPath() %>/js/poshytip-1.2/jquery.poshytip.js" ></script>
	<script type="text/javascript" src="<%=request.getContextPath() %>/js/works_common.js" ></script>

	<script type="text/javascript">

	</script>
</head>
<%
	Map<String, Object> paramMap = CommonUtil.collectParameters(request);

	String menu_gb 			= CommonUtil.getMessage("CATEGORY.GB.02.GB."+CommonUtil.isNull(paramMap.get("menu_gb")));
	String[] arr_menu_gb 	= menu_gb.split(",");

	String c 				= CommonUtil.isNull(paramMap.get("c"));
	String gridId 			= "g_"+c;

	String gridId_1 		= "g_"+c+"_1";
	String gridId_2 		= "g_"+c+"_2";
	String gridId_3 		= "g_"+c+"_3";

	//정기작업수시등록
	String doc_gb = "05";

	String s_gb 					= CommonUtil.isNull(paramMap.get("s_gb"));
	String s_text 					= CommonUtil.isNull(paramMap.get("s_text"));
	String s_state_cd 				= CommonUtil.isNull(paramMap.get("s_state_cd"));

	String state_cd 				= CommonUtil.isNull(paramMap.get("state_cd"));
	String approval_cd 				= CommonUtil.isNull(paramMap.get("approval_cd"));
	String doc_cd 					= CommonUtil.isNull(paramMap.get("doc_cd"));
	String rc 						= CommonUtil.isNull(paramMap.get("rc"));
	String doc_group_id 			= CommonUtil.isNull(paramMap.get("doc_group_id"),"");

	// 목록 화면 검색 파라미터.
	String search_data_center 		= CommonUtil.isNull(paramMap.get("search_data_center"));
	// 결재목록에서 넘어온 값
	String search_approval_cd 	= CommonUtil.isNull(paramMap.get("search_approval_cd"));
	// 의뢰목록에서 넘어온 값
	String search_state_cd 		= CommonUtil.isNull(paramMap.get("search_state_cd"));
	String search_apply_cd		= CommonUtil.isNull(paramMap.get("search_apply_cd"));
	String search_gb 				= CommonUtil.isNull(paramMap.get("search_gb"));
	String search_text 				= CommonUtil.isNull(paramMap.get("search_text"));
	String search_date_gubun 		= CommonUtil.isNull(paramMap.get("search_date_gubun"));
	String search_s_search_date 	= CommonUtil.isNull(paramMap.get("search_s_search_date"));
	String search_e_search_date 	= CommonUtil.isNull(paramMap.get("search_e_search_date"));
	String search_s_search_date2 	= CommonUtil.isNull(paramMap.get("search_s_search_date2"));
	String search_e_search_date2 	= CommonUtil.isNull(paramMap.get("search_e_search_date2"));
	String search_task_nm 			= CommonUtil.isNull(paramMap.get("search_task_nm"));
	String search_moneybatchjob		= CommonUtil.isNull(paramMap.get("search_moneybatchjob"));
	String search_critical			= CommonUtil.isNull(paramMap.get("search_critical"));
	String search_approval_state 	= CommonUtil.isNull(paramMap.get("search_approval_state"));
	String search_check_approval_yn	= CommonUtil.isNull(paramMap.get("search_check_approval_yn"));
	String strDoc_cnt 				= CommonUtil.isNull(paramMap.get("doc_cnt"));

	String tabId					= CommonUtil.isNull(paramMap.get("tabId"));

	String search_param 				= "&search_data_center="+search_data_center+"&search_approval_cd="+search_approval_cd+"&search_state_cd="+search_state_cd+"&search_apply_cd="+search_apply_cd;
	search_param 						+=	"&search_gb="+search_gb+"&search_text="+search_text+"&search_date_gubun="+search_date_gubun+"&search_approval_state="+search_approval_state;
	search_param 						+=	"&search_s_search_date="+search_s_search_date+"&search_e_search_date="+search_e_search_date+"&search_s_search_date2="+search_s_search_date2+"&search_e_search_date2="+search_e_search_date2;
	search_param 						+=	"&search_task_nm="+search_task_nm+"&search_moneybatchjob="+search_moneybatchjob+"&search_critical="+search_critical+"&tabId="+tabId+"&search_check_approval_yn="+search_check_approval_yn;

	List approvalInfoList			= (List)request.getAttribute("approvalInfoList");
	List sCodeList					= (List)request.getAttribute("sCodeList");
	Doc01Bean docBean				= (Doc01Bean)request.getAttribute("doc01");
	JobMapperBean jobMapperBean		= (JobMapperBean)request.getAttribute("jobMapperInfo");

	String cur_approval_seq		= CommonUtil.isNull(request.getAttribute("cur_approval_seq"));
	String cur_approval_gb		= CommonUtil.isNull(request.getAttribute("cur_approval_gb"));
	String strDutyNm		= "";
	String strDeptNm		= "";
	String strUserNm		= "";
	String strDataCenter	= "";
	String strDocCd			= "";
	String strTitle			= "";
	String strContent		= "";
	String strJobName		= "";
	String strApplication	= "";
	String strGroupName		= "";
	String strSchedTable	= "";
	String strCmdLine		= "";
	String strOwner			= "";
	String strDescription   = "";
	String strNodeId		= "";
	String strOrderDate   	= "";
	String strEOrderDate   	= "";
	String strHoldYn   		= "";
	String strHoldMent   	= "";
	String strForceYn   	= "";
	String strForceMent   	= "";
	String strWaitForOdateYn 	= "";
	String strWaitForOdateMent 	= "";
	String strWaitYn  	 	= "";
	String strWaitMent   	= "";
	String strJobgroupName 	= "";
	String strUdtUserNm   	= "";
	String strUdtDate   	= "";
	String strGroupContent 	= "";
	String strTable_Id 		= "";
	String strJob_Id		= "";
	String strFromTime		= "";
	String strCmdLine2		= "";
	String strTset			= "";

	String strUserNm1			= "";
	String strUserNm2			= "";
	String strUserNm3			= "";
	String strUserNm4 			= "";
	String strSms1 				= "";
	String strSms2 				= "";
	String strSms3 				= "";
	String strSms4 				= "";
	String strMail1 			= "";
	String strMail2 			= "";
	String strMail3 			= "";
	String strMail4 			= "";
	String strErrorDescription	= "";
	String strLogName1			= "";
	String strLogName2			= "";
	String strLogPath1			= "";
	String strLogPath2			= "";
	String strLateSub			= "";
	String strLateTime			= "";
	String strLateExec			= "";
	String strBatchJobGrade		= "";
	String strMoneyBatchJob		= "";
	String strRefTable			= "";
	String strAttach_file		= "";
	String strGlobalCond_yn		= "";
	String strCalendar_nm		= "";

	String strSrNo				= "";
	String strChargePmNm			= "";
	String strProjectManMonth		= "";
	String strProjectNm			= "";
	String strSrNonAttachedReason	= "";

	String strCall1 				= "";
	String strCall2 				= "";
	String strCall3 				= "";
	String strCall4 				= "";
	String strMsg1 			= "";
	String strMsg2 			= "";
	String strMsg3 			= "";
	String strMsg4 			= "";

	String post_approval_yn		= "";

	String strInsUserNm 		= "";
	String strInsDeptNm 		= "";

	String strApplyCd			= "";
	String strUserInfo 			= "";
	String strPostUserInfo 		= "";
	String strInsDutyNm 		= "";

	if ( docBean != null ) {
		strDutyNm 			= CommonUtil.isNull(CommonUtil.E2K(docBean.getDuty_nm()), "");
		strDeptNm 			= CommonUtil.isNull(CommonUtil.E2K(docBean.getDept_nm()), "");
		strUserNm 			= CommonUtil.isNull(CommonUtil.E2K(docBean.getUser_nm()), "");
		strDataCenter		= CommonUtil.isNull(CommonUtil.E2K(docBean.getData_center()), "");
		strDocCd			= CommonUtil.isNull(CommonUtil.E2K(docBean.getDoc_cd()), "");
		strTitle			= CommonUtil.isNull(CommonUtil.E2K(docBean.getTitle()), "");
		strJobName			= CommonUtil.isNull(CommonUtil.E2K(docBean.getJob_name()), "");
		strDescription		= CommonUtil.isNull(CommonUtil.E2K(docBean.getDescription()), "");

		// 의뢰자 정보
		strInsUserNm = CommonUtil.isNull(docBean.getUser_nm());
		strInsDeptNm = CommonUtil.isNull(docBean.getDept_nm());
		strInsDutyNm = CommonUtil.isNull(docBean.getDuty_nm());

		//후결유무
		post_approval_yn 	= CommonUtil.isNull(docBean.getPost_approval_yn());

		// 의뢰자 정보
		strUserInfo = "["+S_DEPT_NM+"] ["+S_DUTY_NM+"] "+S_USER_NM;

		if ( !strInsUserNm.equals("") ) {
			strUserInfo = "["+strInsDeptNm+"] ["+strInsDutyNm+"] "+strInsUserNm;
		}

		// 후결 조치자 정보
		strPostUserInfo = "["+strInsDeptNm+"] ["+strInsDutyNm+"] "+strInsUserNm;
		strApplyCd		= CommonUtil.isNull(docBean.getApply_cd());

	}else{
		String menu_gb_c = "";
		String menu_nm = "";

		if(tabId.equals("0390")){
			menu_gb_c = "ez005";
			menu_nm = "결재문서함";
		}else if( (tabId.equals("0399") || tabId.equals("99999")) ){
			menu_gb_c = "ez004";
			menu_nm = "요청문서함";
		}
		out.println("<script type='text/javascript'>");
		out.println("alert('" + CommonUtil.getMessage("DEBUG.06") + "');");
		out.println("top.closeTabsAndAddTab('tabs-" + tabId + "|tabs-" + doc_cd + "', 'c','" + menu_nm + "','01','" + tabId + "','tWorks.ez?c=" + menu_gb_c + "&menu_gb=" + tabId + "&doc_gb=99&"+search_param+"');");
		out.println("</script>");
		return;
	}

	if ( strOrderDate.length() == 8 ) {
		strOrderDate = strOrderDate.substring(0, 4) + "-" + strOrderDate.substring(4, 6) + "-" + strOrderDate.substring(6, 8);
	}

	JobGroupBean jobGroupBean 	= (JobGroupBean)request.getAttribute("jobGroupBean");
	int totalCount 				= Integer.parseInt(CommonUtil.isNull(request.getAttribute("totalCount"),"0"));
	List jobGroupDetailList		= (List)request.getAttribute("jobGroupDetailList");

	ApprovalInfoBean bean2 = (ApprovalInfoBean)request.getAttribute("bean2");

	String strApprovalMent = "";

	if ( bean2 != null ) {
		strApprovalMent = CommonUtil.isNull(CommonUtil.E2K(bean2.getApproval_ment()), "");
	}

	List mainDocInfoList = (List)request.getAttribute("mainDocInfoList");

	if ( jobMapperBean != null ) {

	}

	//SMS 발송 , 메일 발송, auto CALL 발송 , 메신져 발송 처리
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
		strSms1Ment = "[SMS]";
	}

	if ( strSms2.equals("Y") && !strUserNm2.equals("") ) {
		strSms2Ment = "[SMS]";
	}

	if ( strSms3.equals("Y") && !strUserNm3.equals("") ) {
		strSms3Ment = "[SMS]";
	}

	if ( strSms4.equals("Y") && !strUserNm4.equals("") ) {
		strSms4Ment = "[SMS]";
	}
	if ( strMail1.equals("Y") && !strUserNm1.equals("") ) {
		strMail1Ment = "[메일]";
	}

	if ( strMail2.equals("Y") && !strUserNm2.equals("") ) {
		strMail2Ment = "[메일]";
	}

	if ( strMail3.equals("Y") && !strUserNm3.equals("") ) {
		strMail3Ment = "[메일]";
	}

	if ( strMail4.equals("Y") && !strUserNm4.equals("") ) {
		strMail4Ment = "[메일]";
	}

	if ( bean2 != null ) {
		strApprovalMent = CommonUtil.isNull(CommonUtil.E2K(bean2.getApproval_ment()), "");
	}

	String strJobGubun	= CommonUtil.isNull(paramMap.get("job_gubun"));

	// 세션값 가져오기.
	String strSessionUserId = S_USER_ID;
	String strSessionUserNm = S_USER_NM;

%>

<div style="width:100%; height:100%; overflow-x:hidden; overflow-y:scroll;">
	<form id="f_s" name="f_s" method="post" onsubmit="return false;">
		<input type="hidden" id="data_center" 		name="data_center" 		value="<%=strDataCenter %>" />
		<input type="hidden" id="doc_cnt"			name="doc_cnt"			value="<%=strDoc_cnt%>" />
	</form>
	<form id="userFrm" name="userFrm" method="post" onsubmit="return false;">
		<input type="hidden" name="data_center" 	id="data_center" 	value="<%=strDataCenter %>"/>
		<input type="hidden" name="doc_gb" 			id="doc_gb" 		value="<%=doc_gb %>" />
		<input type="hidden" name="state_cd" 		id="state_cd" 		value="<%=state_cd %>" />
		<input type="hidden" name="job_name" 		id="job_name" 		value="<%=strJobName %>" />
		<!-- 목록 화면 검색 파라미터 -->
		<input type="hidden" name="search_data_center"		id="search_data_center" 	value="<%=search_data_center%>" />
		<input type="hidden" name="search_state_cd"			id="search_state_cd" 		value="<%=search_state_cd%>" />
		<input type="hidden" name="search_apply_cd"			id="search_apply_cd" 		value="<%=search_apply_cd%>" />
		<input type="hidden" name="search_approval_cd"		id="search_approval_cd" 	value="<%=search_approval_cd%>" />
		<input type="hidden" name="search_gb"				id="search_gb" 				value="<%=search_gb%>" />
		<input type="hidden" name="search_text"				id="search_text" 			value="<%=search_text%>" />
		<input type="hidden" name="search_date_gubun"		id="search_date_gubun" 		value="<%=search_date_gubun%>" />
		<input type="hidden" name="search_s_search_date"	id="search_s_search_date" 	value="<%=search_s_search_date%>" />
		<input type="hidden" name="search_e_search_date"	id="search_e_search_date" 	value="<%=search_e_search_date%>" />
		<input type="hidden" name="search_s_search_date2"	id="search_s_search_date2" 	value="<%=search_s_search_date2%>" />
		<input type="hidden" name="search_e_search_date2"	id="search_e_search_date2" 	value="<%=search_e_search_date2%>" />
		<input type="hidden" name="search_task_nm"			id="search_task_nm" 		value="<%=search_task_nm%>" />
		<input type="hidden" name="search_moneybatchjob"	id="search_moneybatchjob" 	value="<%=search_moneybatchjob%>" />
		<input type="hidden" name="search_critical"			id="search_critical" 		value="<%=search_critical%>" />
		<input type="hidden" name="search_approval_state"	id="search_approval_state" 	value="<%=search_approval_state%>" />
		<input type="hidden" name="search_check_approval_yn"	id="search_check_approval_yn" 	value="<%=search_check_approval_yn%>" />
		<input type="hidden" name="tabId"					id="tabId"					value="<%=tabId%>" />
	</form>
	<form id="frm1" name="frm1" method="post" onsubmit="return false;" enctype="multipart/form-data" >

		<input type="hidden" id="file_nm"		name="file_nm" />
		<input type="hidden" id="doc_cd" 		name="doc_cd" 		value="<%=doc_cd %>" />
		<input type="hidden" id="doc_gb" 		name="doc_gb" 		value="<%=doc_gb %>" />
		<input type="hidden" id="data_center" 	name="data_center" 	value="<%=strDataCenter %>" />
		<input type="hidden" id="job_name" 		name="job_name" />
		<%-- <input type="hidden" id="job_id" 		name="job_id"		value="<%=strJob_Id%>" />	 --%>
		<%-- <input type="hidden" id="table_id" 		name="table_id"		value="<%=strTable_Id%>" />	 --%>
		<input type="hidden" id="job_id" 		name="job_id"		value="" />
		<input type="hidden" id="table_id" 		name="table_id"		value="" />
		<input type="hidden" id="sched_table"	name="sched_table" />
		<input type="hidden" id="sched_table"	name="sched_table" />
		<input type="hidden" id="flag"			name="flag" />
		<input type="hidden" id="user_cd"		name="user_cd" />
		<input type="hidden" id="days_cal"		name="days_cal" />

		<input type="hidden" id="approval_cd"		name="approval_cd" />
		<input type="hidden" id="approval_seq"		name="approval_seq" />
		<input type="hidden" id="approval_comment"	name="approval_comment" />

		<input type="hidden" id="doc_group_id"		name="doc_group_id"	value="<%=doc_group_id %>" />
		<input type="hidden" name="post_approval_yn" 	id="post_approval_yn" 		value="<%=post_approval_yn%>" />

		<!-- 목록 화면 검색 파라미터 -->
		<input type="hidden" name="search_data_center"		id="search_data_center" 	value="<%=search_data_center%>" />
		<input type="hidden" name="search_state_cd"			id="search_state_cd" 		value="<%=search_state_cd%>" />
		<input type="hidden" name="search_apply_cd"			id="search_apply_cd" 		value="<%=search_apply_cd%>" />
		<input type="hidden" name="search_approval_cd"		id="search_approval_cd" 	value="<%=search_approval_cd%>" />
		<input type="hidden" name="search_gb"				id="search_gb" 				value="<%=search_gb%>" />
		<input type="hidden" name="search_text"				id="search_text" 			value="<%=search_text%>" />
		<input type="hidden" name="search_date_gubun"		id="search_date_gubun" 		value="<%=search_date_gubun%>" />
		<input type="hidden" name="search_s_search_date"	id="search_s_search_date" 	value="<%=search_s_search_date%>" />
		<input type="hidden" name="search_e_search_date"	id="search_e_search_date" 	value="<%=search_e_search_date%>" />
		<input type="hidden" name="search_s_search_date2"	id="search_s_search_date2" 	value="<%=search_s_search_date2%>" />
		<input type="hidden" name="search_e_search_date2"	id="search_e_search_date2" 	value="<%=search_e_search_date2%>" />
		<input type="hidden" name="search_task_nm"			id="search_task_nm" 		value="<%=search_task_nm%>" />
		<input type="hidden" name="search_moneybatchjob"	id="search_moneybatchjob" 	value="<%=search_moneybatchjob%>" />
		<input type="hidden" name="search_critical"			id="search_critical" 		value="<%=search_critical%>" />
		<input type="hidden" name="search_approval_state"	id="search_approval_state" 	value="<%=search_approval_state%>" />
		<input type="hidden" name="search_check_approval_yn"	id="search_check_approval_yn" 	value="<%=search_check_approval_yn%>" />
		<input type="hidden" name="tabId"					id="tabId"					value="<%=tabId%>" />

		<input type="hidden" name="check_doc_cd" />
		<input type="hidden" name="check_data_center" />
		<table style='width:99%;height:99%;border:none;'>
			<tr style='height:10px;'>
				<td style='vertical-align:top;'>
					<h4 class="ui-widget-header ui-corner-all"  >
						<div id='t_<%=gridId %>' class='title_area'>
							<span><%=CommonUtil.isNull(arr_menu_gb[0]) %></span>
						</div>
					</h4>
				</td>
			</tr>

			<tr>
				<td id='ly_<%=gridId %>' style='vertical-align:top;'>
					<div id="<%=gridId %>" class="ui-widget-header_kang ui-corner-all">
						<table style="width:100%">
							<tr>
								<td>
									<div class='cellTitle_kang'>요청 정보 [문서정보 : <%=doc_cd %>]</div>
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
												<div class='cellTitle_kang2'>의 뢰 자</div>
											</td>
											<td colspan="5">
												<div class='cellContent_kang'>
													<%-- 										<a href="JavaScript:docUserInfo('<%=doc_cd %>');" style="text-decoration:underline;"><font color="black"><%=strUserInfo %></font></a> --%>
													<a href="JavaScript:docUserInfo('<%=doc_cd %>');" style="text-decoration:underline;cursor:pointer;"><b><%=strUserInfo %></b></a>
												</div>
											</td>
										</tr>
										<tr>
											<td style="vertical-align:top;">
												<div class='cellTitle_kang2'>요청 사유</div>
											</td>
											<td colspan="3" style="vertical-align:top;">
												<div class='cellContent_kang' style='height:auto;'><%= CommonUtil.E2K(docBean.getTitle()) %></div>
											</td>
										</tr>
									</table>
								</td>
							</tr>

						</table>
					</div>
				</td>
			</tr>

			<tr>
				<td id='ly_<%=gridId_3 %>' style='vertical-align:top;'>
					<div id="<%=gridId_3 %>" class="ui-widget-header ui-corner-all"></div>
				</td>
			</tr>


		</table>

		<iframe name="if2" id="if2" style="width:99%;height:300px;" scrolling="no" frameborder="0"></iframe>

	</form>




	<script>

		function gridCellCustomFormatter(row,cell,value,columnDef,dataContext){

			var ret = "";
			var doc_cd = getCellValue(gridObj_3,row,'DOC_CD');
			var doc_gb = getCellValue(gridObj_3,row,'DOC_GB');
			var task_type = getCellValue(gridObj_3,row,'TASK_TYPE');
			var title 	  = getCellValue(gridObj_3,row,'TITLE');
			var job_name = getCellValue(gridObj_3,row,'JOB_NAME');
			var description = getCellValue(gridObj_3,row,'DESCRIPTION');
			var state_nm = getCellValue(gridObj_3,row,'STATE_NM');
			var draft_date = getCellValue(gridObj_3,row,'DRAFT_DATE');
			var ins_date = getCellValue(gridObj_3,row,'INS_DATE');
			var job_id = getCellValue(gridObj_3,row,'JOB_ID');
			var table_id = getCellValue(gridObj_3,row,'TABLE_ID');


			if(columnDef.id == 'JOB_NAME' || columnDef.id == 'TITLE'){

				ret = "<a href=\"JavaScript:goView('"+doc_cd+"','"+job_name+"','"+job_id+"','"+table_id+"');\" /><font color='red'>"+value+"</font></a>";
			}

			return ret;
		}

		var gridObj_3 = {
			id : "<%=gridId_3 %>"
			,colModel:[
				{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'번호',width:50,minWidth:50,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
				,{formatter:gridCellNoneFormatter,field:'DOC_CD',id:'DOC_CD',name:'문서번호',width:110,minWidth:110,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
				,{formatter:gridCellNoneFormatter,field:'DOC_GB',id:'DOC_GB',name:'문서구분',width:130,minWidth:130,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
				//,{formatter:gridCellNoneFormatter,field:'TASK_TYPE',id:'TASK_TYPE',name:'작업구분',width:80,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
				,{formatter:gridCellCustomFormatter,field:'TITLE',id:'TITLE',name:'의뢰사유',width:200,minWidth:200,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
				,{formatter:gridCellCustomFormatter,field:'JOB_NAME',id:'JOB_NAME',name:'작업명',width:150,minWidth:150,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
				,{formatter:gridCellNoneFormatter,field:'STATE_NM',id:'STATE_NM',name:'문서상태',width:70,minWidth:70,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
				,{formatter:gridCellNoneFormatter,field:'APPLY_NM',id:'APPLY_NM',name:'반영상태',width:90,minWidth:90,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
				,{formatter:gridCellNoneFormatter,field:'STATUS',id:'STATUS',name:'작업상태',width:100,minWidth:100,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
				,{formatter:gridCellNoneFormatter,field:'DRAFT_DATE',id:'DRAFT_DATE',name:'의뢰일자',width:120,minWidth:120,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
				,{formatter:gridCellNoneFormatter,field:'INS_DATE',id:'INS_DATE',name:'등록일자',width:120,minWidth:120,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
				,{formatter:gridCellNoneFormatter,field:'JOB_ID',id:'JOB_ID',name:'JOB_ID',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
				,{formatter:gridCellNoneFormatter,field:'TABLE_ID',id:'TABLE_ID',name:'TABLE_ID',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
			]
			,rows:[]
			,vscroll:<%=S_GRID_VSCROLL%>
		};



		$(document).ready(function() {

			var doc_cd 		= '<%=doc_cd%>';
			var session_user_gb	= "<%=S_USER_GB%>";

			if ( session_user_gb == "99" || session_user_gb == "02" ) {
				$("#btn_del").show();
			}

			var apply_cd = '<%=strApplyCd%>';

			$("#btn_approval").button().unbind("click").click(function(){
				goPrc('02', $("#seq").val(), '결재');
			});

			$("#btn_reject").button().unbind("click").click(function(){
				goPrc('04', $("#seq").val(), '반려');
			});

			$("#btn_cancel").button().unbind("click").click(function(){
				goCancel();
			});

			$("#btn_close").button().unbind("click").click(function(){
				top.closeTabs('tabs-'+doc_cd);
			});
			$("#btn_capy").button().unbind("click").click(function(){
				alert("복사");
			});
			$("#btn_del").button().unbind("click").click(function(){
				goPrc2('del');
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
					top.addTab('c', '수시작업의뢰결재', '01', '0102', 'tWorks.ez?c=ez005&menu_gb=0102&doc_gb=02'+search_param);
				} else {
					top.addTab('c', '수시작업의뢰조회', '03', '0302', 'tWorks.ez?c=ez004&menu_gb=0302&doc_gb=02'+search_param);
				}

				top.closeTab('tabs-99999');
			});


			viewGrid_1(gridObj_3,"ly_"+gridObj_3.id,{enableColumnReorder:true},'AUTO');

			setTimeout(function(){
				mainDocInfoList("<%=doc_cd%>");
			}, 1000);

		});


		function mainDocInfoList(doc_cd){

			try{viewProgBar(true);}catch(e){}
			$('#ly_total_cnt').html('');

			var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=mainDocInfoList&itemGubun=2&doc_cd='+doc_cd;

			var xhr = new XHRHandler(url, f_s
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

									var doc_group_id 	= $(this).find("DOC_GROUP_ID").text();
									var task_type 		= $(this).find("TASK_TYPE").text();
									var main_doc_cd 	= $(this).find("MAIN_DOC_CD").text();
									var doc_cd 			= $(this).find("DOC_CD").text();
									var doc_gb 			= $(this).find("DOC_GB").text();
									var title 			= $(this).find("TITLE").text();
									var job_name 		= $(this).find("JOB_NAME").text();

									var state_cd 		= $(this).find("STATE_CD").text();
									var state_nm 		= $(this).find("STATE_NM").text();
									var draft_date 		= $(this).find("DRAFT_DATE").text();
									var ins_date 		= $(this).find("INS_DATE").text();
									var status 			= $(this).find("STATUS").text();
									var ajob_status 	= $(this).find("AJOB_STATUS").text();
									var table_id 		= $(this).find("TABLE_ID").text();
									var job_id		 	= $(this).find("JOB_ID").text();
									var batch_result 	= $(this).find("BATCH_RESULT").text();
									var fail_comment 	= $(this).find("FAIL_COMMENT").text();

									// 실시간 작업 정보에 해당 작업의 상태가 존재하면 그걸 뿌려주고, 없다면 DOC 테이블의 status를 뿌려준다.
									if ( ajob_status != "" ) {
										status = ajob_status;
									}

									if ( fail_comment != "" ) {
										batch_result = batch_result + ": " + fail_comment;
										batch_result = "<font color='red'>"+batch_result+"</font>"
									}

									rowsObj.push({
										'grid_idx':i+1
										,'DOC_GROUP_ID': doc_group_id
										,'TASK_TYPE': task_type
										,'MAIN_DOC_CD': main_doc_cd
										,'DOC_CD': doc_cd
										,'DOC_GB': doc_gb
										,'TITLE': title
										,'JOB_NAME': job_name

										,'STATE_CD': state_cd
										,'STATE_NM': state_nm
										,'APPLY_NM': batch_result
										,'DRAFT_DATE': draft_date
										,'INS_DATE': ins_date
										,'STATUS': status
										,'TABLE_ID': table_id
										,'JOB_ID' : job_id
									});

								});
							}

							gridObj_3.rows = rowsObj;
							setGridRows(gridObj_3);
							$('body').resizeAllColumns();
							$('#ly_total_cnt').html('[ TOTAL : '+items.attr('cnt')+' ]');

						});
						try{viewProgBar(false);}catch(e){}
					}
					, null );

			xhr.sendRequest();
		}


		function goView(doc_cd,job_name,job_id,table_id) {
			var frm = document.frm1;
			frm.job_name.value = job_name;
			frm.job_id.value = job_id;
			frm.table_id.value = table_id;

			openPopupCenter1("about:blank","popupDefJobDetail",1200,800);

			frm.action = "<%=sContextPath %>/mPopup.ez?c=ez011";
			frm.target = "popupDefJobDetail";
			frm.submit();
		}

		function goPrc(approval_cd, approval_seq, appproval_nm) {

			var frm = document.frm1;

			frm.approval_cd.value 	= approval_cd;
			frm.approval_seq.value 	= approval_seq;

			var app_comment = $("#app_comment").val();
			frm.approval_comment.value = app_comment;

			// 반려일 경우 결재자 의견 필수
			if ( approval_cd == "04" && app_comment == "" ) {
				alert("반려는 결재자 의견이 필수입니다.");
				$("#app_comment").focus();
				return;
			}

			if( !confirm("["+appproval_nm+"] 하시겠습니까?") ) return;

			// 직전 진행했던 파라미터가 넘어가는 걸 방지하기 위해 초기화 (2023.05.25 강명준)
			frm.flag.value 	= "";

			var doc_group_id = "<%=doc_group_id%>";
			// 단건 결재.
			if ( doc_group_id == "" || doc_group_id == "0" ) {
				c = "ez006_p";

				// 그룹 결재.
			} else {
				c = "ez006_order_p";
			}

			try{viewProgBar(true);}catch(e){}

			frm.target = "if1";
			frm.action = "<%=sContextPath%>/tWorks.ez?c="+c;
			frm.submit();
		}

		function goPrc2(flag) {

			var frm = document.frm1;

			frm.flag.value 			= flag;

			if( !confirm("삭제하시겠습니까?") ) return;

			// 직전 진행했던 파라미터가 넘어가는 걸 방지하기 위해 초기화 (2023.05.25 강명준)
			frm.approval_cd.value 	= "";

			try{viewProgBar(true);}catch(e){}
			frm.target = "if1";
			frm.action = "<%=sContextPath%>/tWorks.ez?c=ez004_p";
			frm.submit();

		}

		function goCancel() {

			var frm = document.frm1;

			if( !confirm("해당 문서는 삭제됩니다.\n[승인취소]하시겠습니까?") ) return;

			//if( !confirm("해당 문서는 삭제됩니다. 진행하시겠습니까?") ) return;

			try{viewProgBar(true);}catch(e){}

			frm.flag.value 	= "def_cancel";
			frm.target 		= "if1";
			frm.action 		= "<%=sContextPath%>/tWorks.ez?c=ez006_p";

			frm.submit();
		}

	</script>
	<%@include file="/jsp/common/inc/progBar.jsp"  %>
	<iframe name="if1" id="if1" width="0" height="0"></iframe>
	</body>
</div>
</html>