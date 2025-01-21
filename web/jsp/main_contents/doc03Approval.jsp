<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/jsp/common/inc/header.jsp"%>
<%@ page import="java.sql.*,java.util.*,java.io.*,java.text.*,java.net.*" %>
<%@ page import="com.ghayoun.ezjobs.t.domain.*" %>
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

	String c 		= CommonUtil.isNull(paramMap.get("c"));
	String gridId 	= "g_"+c;
	String gridId_1 = "g_"+c+"_1";
	String gridId_2 = "g_"+c+"_2";

	String s_doc_gb 			= CommonUtil.isNull(paramMap.get("s_doc_gb"));
	String s_gb 				= CommonUtil.isNull(paramMap.get("s_gb"));
	String s_text 				= CommonUtil.isNull(paramMap.get("s_text"));
	String s_state_cd 			= CommonUtil.isNull(paramMap.get("s_state_cd"));

	String state_cd 			= CommonUtil.isNull(paramMap.get("state_cd"));
	String approval_cd 			= CommonUtil.isNull(paramMap.get("approval_cd"));

	String doc_cd 				= CommonUtil.isNull(paramMap.get("doc_cd"));
	String max_doc_cd			= CommonUtil.isNull(paramMap.get("max_doc_cd"));
	String doc_gb 				= CommonUtil.isNull(paramMap.get("doc_gb"));
	String rc 					= CommonUtil.isNull(paramMap.get("rc"));

	// 목록 화면 검색 파라미터.
	String search_data_center 	= CommonUtil.isNull(paramMap.get("search_data_center"));
	// 결재목록에서 넘어온 값
	String search_approval_cd 	= CommonUtil.isNull(paramMap.get("search_approval_cd"));
	// 의뢰목록에서 넘어온 값
	String search_state_cd 		= CommonUtil.isNull(paramMap.get("search_state_cd"));
	String search_apply_cd		= CommonUtil.isNull(paramMap.get("search_apply_cd"));
	String search_gb 			= CommonUtil.isNull(paramMap.get("search_gb"));
	String search_text 			= CommonUtil.isNull(paramMap.get("search_text"));
	String search_date_gubun 	= CommonUtil.isNull(paramMap.get("search_date_gubun"));
	String search_s_search_date = CommonUtil.isNull(paramMap.get("search_s_search_date"));
	String search_e_search_date = CommonUtil.isNull(paramMap.get("search_e_search_date"));
	String search_s_search_date2 = CommonUtil.isNull(paramMap.get("search_s_search_date2"));
	String search_e_search_date2 = CommonUtil.isNull(paramMap.get("search_e_search_date2"));
	String search_task_nm 		= CommonUtil.isNull(paramMap.get("search_task_nm"));
	String search_moneybatchjob	= CommonUtil.isNull(paramMap.get("search_moneybatchjob"));
	String search_critical		= CommonUtil.isNull(paramMap.get("search_critical"));
	String search_approval_state 	= CommonUtil.isNull(paramMap.get("search_approval_state"));
	String search_check_approval_yn	= CommonUtil.isNull(paramMap.get("search_check_approval_yn"));

	String tabId				= CommonUtil.isNull(paramMap.get("tabId"));
	String doc_cnt 				= CommonUtil.isNull(paramMap.get("doc_cnt"), "0");
	String strPopup_yn			= CommonUtil.isNull(paramMap.get("popup_yn"));

	String search_param 				= "&search_data_center="+search_data_center+"&search_approval_cd="+search_approval_cd+"&search_state_cd="+search_state_cd+"&search_apply_cd="+search_apply_cd;
	search_param 						+=	"&search_gb="+search_gb+"&search_text="+search_text+"&search_date_gubun="+search_date_gubun+"&search_approval_state="+search_approval_state;
	search_param 						+=	"&search_s_search_date="+search_s_search_date+"&search_e_search_date="+search_e_search_date+"&search_s_search_date2="+search_s_search_date2+"&search_e_search_date2="+search_e_search_date2;
	search_param 						+=	"&search_task_nm="+search_task_nm+"&search_moneybatchjob="+search_moneybatchjob+"&search_critical="+search_critical+"&tabId="+tabId+"&search_check_approval_yn="+search_check_approval_yn;

	if ( !max_doc_cd.equals("") ) {
		doc_cd = max_doc_cd;
	}

	String currentPage 		= CommonUtil.isNull(paramMap.get("currentPage"));

	List approvalInfoList	= (List)request.getAttribute("approvalInfoList");

	JobMapperBean jobMapperBean	= (JobMapperBean)request.getAttribute("jobMapperInfo");

	Doc03Bean docBean		= (Doc03Bean)request.getAttribute("doc03");

	String cur_approval_seq		= CommonUtil.isNull(request.getAttribute("cur_approval_seq"));
	String cur_approval_gb		= CommonUtil.isNull(request.getAttribute("cur_approval_gb"));

	String menu_gb_c = "";
	String menu_nm = "";

	if ( docBean == null ) {
		if(tabId.equals("0390")){
			menu_gb_c = "ez005";
			menu_nm = "결재요청함";
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

	// 참조기안시 작업명을 가지고 매퍼를 찾기 때문에 필요.
	String strJobName 		= CommonUtil.E2K(docBean.getJob_name());

	String[] aTmp 	= null;
	String[] aTmpT 	= null;

	String strDescription		= "";

	String strMcode_nm    	    = "";
	String strScode_nm          = "";

	String	strDataCenter		= "";
	String	strDataCenterName	= "";

	if ( jobMapperBean != null ) {
		strDescription 		= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getDescription()), "");

		strDataCenter		= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getData_center()), "");
		strDataCenterName	= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getData_center_name()), "");
	}

	ApprovalInfoBean bean2 = (ApprovalInfoBean)request.getAttribute("bean2");

	String strApprovalMent = "";

	if ( bean2 != null ) {
		strApprovalMent = CommonUtil.isNull(CommonUtil.E2K(bean2.getApproval_ment()), "");
	}

	List mainDocInfoList = (List)request.getAttribute("mainDocInfoList");

	List approvalLineList		= (List)request.getAttribute("approvalLineList");

	String strJobGubun	= CommonUtil.isNull(paramMap.get("job_gubun"));

	// 세션값 가져오기.
	String strSessionUserId = S_USER_ID;
	String strSessionUserNm = S_USER_NM;

	String strServerGb 		= CommonUtil.isNull(CommonUtil.getMessage("SERVER_GB"));

	// Argument가 동기화가 안될 수 있어서 CommandLine의 파라미터를 기준으로 셋팅해준다.
	String strCommand 	= CommonUtil.replaceStrXml(CommonUtil.isNull(docBean.getCommand()));

	// 의뢰자 정보
	String strInsUserNm = CommonUtil.isNull(docBean.getUser_nm());
	String strInsDeptNm = CommonUtil.isNull(docBean.getDept_nm());
	String strInsDutyNm = CommonUtil.isNull(docBean.getDuty_nm());

	String strUserInfo = "["+S_DEPT_NM+"] ["+S_DUTY_NM+"] "+S_USER_NM;
	if ( !strInsUserNm.equals("") ) {
		strUserInfo = "["+strInsDeptNm+"] ["+strInsDutyNm+"] "+strInsUserNm;
	}
	//후결유무
	String post_approval_yn = CommonUtil.isNull(docBean.getPost_approval_yn());
	String strApplyCd		= CommonUtil.isNull(docBean.getApply_cd());

	//반영일
	String strApplyDate = CommonUtil.isNull(docBean.getApply_date());

%>

<body id='body_A01' leftmargin="0" topmargin="0">

<div style="width:100%; height:100%; overflow-x:hidden; overflow-y:scroll;">
	<form id="f_s" name="f_s" method="post" onsubmit="return false;">
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

		<input type="hidden" name="flag" 				id="flag" />
		<input type="hidden" name="doc_cd" 				id="doc_cd" value="<%=doc_cd%>" />
		<input type="hidden" name="doc_gb" 				id="doc_gb" value="<%=doc_gb %>" />
		<input type="hidden" name="approval_cd" 		id="approval_cd" />
		<input type="hidden" name="approval_seq"		id="approval_seq" />
		<input type="hidden" name="approval_comment"	id="approval_comment" />
		<input type="hidden" name="post_approval_yn" 	id="post_approval_yn" 			value="<%=post_approval_yn %>" />
		<input type="hidden" name="doc_cnt"				id="doc_cnt"					value="<%=doc_cnt%>" />


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
		
		<input type="hidden" name="doc_cds" 	id="doc_cds" 		/>
		<input type="hidden" name="doc_gbs"		id="doc_gbs"		/>

		<table style='width:99%;height:99%;border:none;'>
			<tr style='height:10px;'>
				<td style='vertical-align:top;'>
					<h4 class="ui-widget-header ui-corner-all"  >
						<div id='t_<%=gridId %>' class='title_area'>
							<span><%=CommonUtil.getMessage("CATEGORY.GB.03.SB.0303") %></span>
						</div>
					</h4>
				</td>
			</tr>
			<tr>
				<td id='ly_<%=gridId %>' style='vertical-align:top;'>
					<div id="<%=gridId %>" class="ui-widget-header_kang ui-corner-all">


							<table style="width:100%" id = "popup_ui">
							<tr>
								<td>
									<div class='cellTitle_kang5'>결재 정보</div>
								</td>
							</tr>
							<tr>
								<td valign="top">
									<table style="width:100%">
										<tr>
											<%
												for( int i=0; null!=approvalInfoList && i<approvalInfoList.size(); i++ ) {
													ApprovalInfoBean bean = (ApprovalInfoBean)approvalInfoList.get(i);

													String strLineGb			= CommonUtil.isNull(bean.getLine_gb());
													String strApprovalGb		= CommonUtil.isNull(bean.getApproval_gb());
													String strApprovalCd		= CommonUtil.isNull(bean.getApproval_cd());
													String strApprovalDate		= CommonUtil.isNull(bean.getApproval_date());
													String strApprovalComment	= CommonUtil.isNull(bean.getApproval_comment());
													String strGroupLineGrpNm	= CommonUtil.isNull(bean.getGroup_line_grp_nm());
													String strUpdateUserNm		= CommonUtil.isNull(bean.getUpdate_user_nm());
													String strApprovalType		= CommonUtil.isNull(bean.getApproval_type());

													String strApprovalGbMent 	= "";
													String strGroupApprovalUser = "";
													String strApprovalTypeNm	 = "";
													if(strApprovalType.equals("03")) strApprovalTypeNm = "[후결]";

													if(!strApprovalGb.equals("")) {
														strApprovalGbMent = CommonUtil.getMessage("USER.APPR.GB."+strApprovalGb);
													}else {
														strApprovalGbMent = "즉시 결재자";
													}
													
													strGroupApprovalUser	= "(" + strUpdateUserNm + ")";

													String strApprovalCdMent 	= CommonUtil.getMessage("DOC.APPROVAL."+strApprovalCd);

													String strApprovalCdMent2	= "";
													if ( !strApprovalCd.equals("00") && !strApprovalCd.equals("01") ) {
														strApprovalCdMent2 = strGroupApprovalUser + ":" + strApprovalDate;
													}
											%>
											<td width="200">
												<div class='cellTitle_ez_center' style='min-width:30%; min-height:30px;' >
													<%=strApprovalGbMent%>
													<%
														if ( !strApprovalComment.equals("") ) {
													%>
													<img src='<%=sContextPath%>/images/memo_icon.png' alt="<%=strApprovalComment%>" title="<%=strApprovalComment%>" />

													<%
														}
													%>
													[<%=strApprovalCdMent%><%=strApprovalCdMent2%>] <%=strApprovalTypeNm%>
												</div>
											</td>
											<%
												}
											%>
										</tr>
										<tr style='vertical-align:top;'>
										<%
											for( int i=0; null!=approvalInfoList && i<approvalInfoList.size(); i++ ) {
												ApprovalInfoBean bean = (ApprovalInfoBean)approvalInfoList.get(i);
												
												String strApprovalComment	= CommonUtil.isNull(bean.getApproval_comment());
										%>
												<td width="200"> 
														<%
														if( !strApprovalComment.equals("") ){
														%>
															<div class='cellTitle_kang3' style='display:flex;justify-content:center;padding:0 22% 0 22%; word-break: break-all;height:auto;text-align:left;'><%=strApprovalComment%></div>
														<%
															}
														%>
												</td>
										<%
											}
										%>
										</tr>
										<tr>
											<%
												for( int i=0; null!=approvalInfoList && i<approvalInfoList.size(); i++ ) {
													ApprovalInfoBean bean = (ApprovalInfoBean)approvalInfoList.get(i);

													String strApprovalCd 		= CommonUtil.isNull(bean.getApproval_cd());
													String strSeq 				= CommonUtil.isNull(bean.getSeq());
													String strApprovalUserNm	= CommonUtil.isNull(CommonUtil.E2K(bean.getUser_nm()));
													String strDutyCd			= CommonUtil.isNull(bean.getDuty_cd());
													String strUserCd			= CommonUtil.isNull(bean.getUser_cd());
												
													String strUdtUserCd			= CommonUtil.isNull(bean.getUdt_user_cd());
													String strUdtUserNm			= CommonUtil.isNull(bean.getUpdate_user_nm());
													String strUdtDeptNm			= CommonUtil.isNull(bean.getUpdate_dept_nm());
													String strUdtDutyNm			= CommonUtil.isNull(bean.getUpdate_duty_nm());

													String strAbsenceUserCd		= CommonUtil.isNull(bean.getAbsence_user_cd());
													String strAbsenceUserNm		= CommonUtil.isNull(bean.getAbsence_user_nm());
													String strAbsenceDeptNm		= CommonUtil.isNull(bean.getAbsence_dept_nm());
													String strAbsenceDutyNm		= CommonUtil.isNull(bean.getAbsence_duty_nm());

													String strGroupLineGrpNm	= CommonUtil.isNull(bean.getGroup_line_grp_nm());

													String userInfo				= "";
													String strAbsenceInfo		= "";

													String strLineGb			= CommonUtil.isNull(bean.getLine_gb());


													// 결재 시 대결자 정보가 있으면 대결자 셋팅
													if( strUdtUserCd.equals("") && !strAbsenceUserCd.equals("0") && strGroupLineGrpNm.equals("") ) {
														strAbsenceInfo = "["+CommonUtil.E2K(bean.getDept_nm())+"]["+CommonUtil.E2K(bean.getDuty_nm())+"]"+CommonUtil.E2K(bean.getUser_nm()) + " (대결자:" + strAbsenceUserNm + ")";
													}
													
													// 결재사용자코드와 업데이트한 사용자코드가 다르면 대결로 간주
													if ( !strUserCd.equals(strUdtUserCd) && !strUdtUserCd.equals("") && strGroupLineGrpNm.equals("") ) {
														strAbsenceInfo = "["+strUdtDeptNm+"]["+strUdtDutyNm+"]"+strUdtUserNm +"(대결)";
													}

													//userInfo = "["+CommonUtil.E2K(bean.getDept_nm())+"]["+CommonUtil.E2K(bean.getDuty_nm())+"]<br>"+CommonUtil.E2K(bean.getUser_nm());
													userInfo = "["+CommonUtil.E2K(bean.getDept_nm())+"]["+CommonUtil.E2K(bean.getDuty_nm())+"]"+CommonUtil.E2K(bean.getUser_nm());

													if ( !strGroupLineGrpNm.equals("") ) {
														userInfo = "[그룹]" + strGroupLineGrpNm;
														if ( !strUdtUserNm.equals("") ) {
															userInfo += "(" + strUdtUserNm + ")";
														}
													}

													// 대결
													if ( !strAbsenceInfo.equals("") ) {
														userInfo = strAbsenceInfo;
													}
											%>
											<td width="200">
												<div class='cellTitle_kang3'><a href="javascript:dynamicApprovalUserInfo('<%=sContextPath%>','<%=strUserCd%>','<%=strGroupLineGrpNm%>','<%=strLineGb %>','<%=doc_cd%>','<%=strSeq%>','<%=strApprovalCd%>')"><%=userInfo%></a></div>
											</td>
											<%
												}
											%>
										</tr>
									</table>
								</td>
							</tr>

							<tr>
								<td>
									<div class='cellTitle_kang5'>요청 정보</div>
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
												<div class='cellTitle_ez_right'>의 뢰 자</div>
											</td>
											<td>
												<div class='cellContent_kang'>
													<a href="JavaScript:docUserInfo('<%=doc_cd %>');" style="text-decoration:underline;"><font color="black"><%=strUserInfo %></font></a>
												</div>
											</td>
											<td>
												<div class='cellTitle_ez_right' style='min-width:120px' ><font color="red">* </font>반영 예정일</div>
											</td>
											<td colspan="2">
												<%=strApplyDate%>
											</td>
										</tr>
										<tr>
											<td style="vertical-align:top;">
												<div class='cellTitle_ez_right'>요청 사유</div>
											</td>
											<td colspan="5" style="vertical-align:top;">
												<div class='cellContent_kang' style='height:auto;'><%= CommonUtil.E2K(docBean.getTitle()) %></div>
											</td>
										</tr>
										<%
											if ( !CommonUtil.E2K(docBean.getFail_comment()).equals("") ) {
										%>
										<tr>
											<td style="vertical-align:top;">
												<div class='cellTitle_ez_right'><font color="red">* </font>반영실패 사유</div>
											</td>
											<td colspan="5" style="vertical-align:top;">
												<div class='cellContent_kang' style='height:auto;font-weight:bold;'><font color="red"><%=CommonUtil.E2K(docBean.getFail_comment()) %></font></div>
											</td>
										</tr>
										<%
											}
										%>
									</table>
								</td>
							</tr>

						</table>
						<table style="width:100%">
							<tr>
								<td>
									<div class='cellTitle_kang5'>작업 정보 [문서정보 : <%=doc_cd %>]</div>
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
													<%=CommonUtil.E2K(docBean.getTask_type()) %>
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
												</div>
											</td>
											<td>
												<div class='cellTitle_ez_right'>어플리케이션</div>
											</td>

											<td>
												<div class='cellContent_kang'>
													<%=CommonUtil.isNull(docBean.getApplication()) %>
												</div>
											</td>
											<td>
												<div class='cellTitle_ez_right'>그룹</div>
											</td>
											<td>
												<div class='cellContent_kang'>
													<%=CommonUtil.isNull(docBean.getGroup_name()) %>
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
												</div>
											</td>
											<td>
												<div class='cellTitle_ez_right'>계정명</div>
											</td>
											<td>
												<div class='cellContent_kang'>
													<%=CommonUtil.E2K(docBean.getOwner()) %>
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<div class='cellTitle_ez_right'>작업명</div>
											</td>
											<td >
												<div class='cellContent_kang'>
													<%=strJobName %>
												</div>
											</td>
											<td>
												<div class='cellTitle_ez_right'>작업 설명</div>
											</td>
											<td colspan="3">
												<div class='cellContent_kang' style='height:auto;'>
													<%=CommonUtil.E2K(docBean.getDescription()) %>
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<div class='cellTitle_ez_right'>작업수행명령</div>
											</td>

											<td colspan="5">
												<div class='cellContent_kang'>
													<%=strCommand%>
												</div>
											</td>

										</tr>
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
						<div align='right' class='btn_area' >
							<%
								String strCurApprovalSeq	= "";
								String strStateCd			= "";
								String strInsUserCd			= "";

								for( int i=0; null!=approvalInfoList && i<approvalInfoList.size(); i++ ) {
									ApprovalInfoBean bean = (ApprovalInfoBean)approvalInfoList.get(i);

									String strUserCd			= CommonUtil.isNull(bean.getUser_cd());
									String strUdtUserCd			= CommonUtil.isNull(bean.getUdt_user_cd());

									String strAbsenceUserCd		= CommonUtil.isNull(bean.getAbsence_user_cd());
									String strAbsenceUserNm		= CommonUtil.isNull(bean.getAbsence_user_nm());
									String strAbsenceDeptNm		= CommonUtil.isNull(bean.getAbsence_dept_nm());
									String strAbsenceDutyNm		= CommonUtil.isNull(bean.getAbsence_duty_nm());

									String strSeq				= CommonUtil.isNull(bean.getSeq());
									strCurApprovalSeq			= CommonUtil.isNull(bean.getCur_approval_seq());
									strStateCd					= CommonUtil.isNull(bean.getState_cd());
									strInsUserCd				= CommonUtil.isNull(bean.getIns_user_cd());

									String strAbsenceInfo		= "";
								}

								if ( !cur_approval_seq.equals("") && !strPopup_yn.equals("Y")) {
							%>
							<input type="hidden" name="seq" id="seq" value="<%=cur_approval_seq%>"/>

							결재자 의견 : <input type="text" name="app_comment" id="app_comment" maxlength="100" style="width:150px;height:21px;">
							<span id='btn_approval'>결재</span>

							<%	// 반영완료는 반려처리 불가.
							if ( !strApplyCd.equals("02")) {
							%>
								<%
									if(!cur_approval_gb.equals("04")){
								%>
								<span id='btn_reject'>반려</span>
								<%
									}
											%>
										<%
								}
								%>
							<%
								}

								// 1차결재자 미결이면 기안자 승인취소 가능
								if ( strCurApprovalSeq.equals("1") && strStateCd.equals("01") && S_USER_CD.equals(strInsUserCd) ) {
							%>
							<span id='btn_cancel'>승인취소</span>
							<%
								}
							%>

							<!-- <span id='btn_list'>목록</span> -->
							<span id='btn_del' style="display:none;">삭제</span>
							
							<%if (CommonUtil.E2K(docBean.getApply_cd()).equals("04") || CommonUtil.E2K(docBean.getApply_cd()).equals("05") ) {%>
							<span id="btn_admin_approval">재반영</span>
							<%}%>
							
							<span id='btn_close'>닫기</span>

						</div>
					</h4>
				</td>
			</tr>

		</table>
	</form>

	<script type="text/javascript">

		$(document).ready(function(){

			var doc_cd 		= '<%=doc_cd%>';
			var session_user_gb	= "<%=S_USER_GB%>";
			var popup_yn	= "<%=strPopup_yn%>";

			$("#btn_close").show();
			//운영자일 경우 삭제 버튼 활성화
			if ( session_user_gb == "99" || session_user_gb == "02" ) {
				$("#btn_del").show();
			}

			//일괄요청서 팝업창일 경우 버튼 제거
			if(popup_yn == "Y"){
				$("#popup_ui").hide();
				$("#btn_del").hide();
				$("#btn_approval").hide();
				$("#btn_cancel").hide();
				$("#btn_reject").hide();
				$("#app_comment").hide();
			}

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
				if(popup_yn == "Y"){
					window.close();
				}else{
				top.closeTabs('tabs-'+doc_cd);
				}
			});

			$("#btn_del").button().unbind("click").click(function(){
				goPrc2('del');
			});
			
			//재반영 버튼 클릭
	    	$("#btn_admin_approval").button().unbind("click").click(function(){			
	    		UpdateFlag();		
	    	});
		});

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

			try{viewProgBar(true);}catch(e){}

			frm.target = "if1";
			frm.action = "<%=sContextPath%>/tWorks.ez?c=ez006_p";
			frm.submit();
		}

		function goPrc2(flag) {

			var frm = document.frm1;

			if( !confirm("삭제하시겠습니까?") ) return;

			frm.flag.value 			= flag;

			// 직전 진행했던 파라미터가 넘어가는 걸 방지하기 위해 초기화 (2023.05.25 강명준)
			frm.approval_cd.value 	= "";

			try{viewProgBar(true);}catch(e){}
			frm.target = "if1";
			frm.action = "<%=sContextPath%>/tWorks.ez?c=ez004_p";
			frm.submit();
		}

		function goCancel() {

			var frm = document.frm1;

			if( !confirm("[승인취소] 하시겠습니까?") ) return;

			frm.flag.value 	= "def_cancel";

			// 직전 진행했던 파라미터가 넘어가는 걸 방지하기 위해 초기화 (2023.05.25 강명준)
			frm.approval_cd.value 	= "";

			try{viewProgBar(true);}catch(e){}
			frm.target 		= "if1";
			frm.action 		= "<%=sContextPath%>/tWorks.ez?c=ez006_p";

			frm.submit();
		}
		
		//재반영 버튼 클릭시
		function UpdateFlag() {
			
			var frm = document.frm1;
			
			frm.doc_cds.value 		= '<%=doc_cd %>';
			frm.doc_gbs.value 		= '<%=doc_gb %>';
			
			if( !confirm("재반영을 요청 하시겠습니까?") ) return;

			try{viewProgBar(true);}catch(e){}

			frm.target = "if1";
			frm.action = "<%=sContextPath%>/tWorks.ez?c=ez006_attempt";
			frm.submit();
			
		}

	</script>
	<%@include file="/jsp/common/inc/progBar.jsp"  %>
	<iframe name="if1" id="if1" width="0" height="0"></iframe>
</div>
</body>
</html>