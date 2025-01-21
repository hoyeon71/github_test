<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/jsp/common/inc/header.jsp"%>
<%@ page import="java.sql.*,java.util.*,java.io.*,java.text.*,java.net.*" %>
<%@ page import="com.ghayoun.ezjobs.m.domain.*" %>
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

<style type="text/css">

.filebox label{
	display: inline-block;
	padding: .5em .75em
	color: #999
	font-size: inherit;
	line-height: normal;
	vertical-align: middle;
	background-color: #fdfdfd;
	cursor: pointer;
	border: 1px solid #ebebeb;
	border-bottom-color: #e2e2e2;
	border-radius: .25em;
	width:65px;
	height:21px;
}

.filebox input[type="file"]{
	position: absolute;
	width:1px;   
	height:1px;
	padding: 0;
	margin: -1px;
	overflow: hidden;
	clip:rect(0,0,0,0);	  
	border: 0;
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
<script type="text/javascript" src="<%=request.getContextPath() %>/js/SlickGrid-2.1.0/slick.dataview.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/SlickGrid-2.1.0/slick.grid.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/SlickGrid-2.1.0/slick.editors.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/SlickGrid-2.1.0/plugins/slick.autocolumnsize.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/poshytip-1.2/jquery.poshytip.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/works_common.js?v=<%=jsVersion %>" ></script>

<script type="text/javascript">

</script>
</head>
<%
	Map<String, Object> paramMap = CommonUtil.collectParameters(request);
	
	String c 		= CommonUtil.isNull(paramMap.get("c"));
	String gridId 	= "g_"+c;
	String gridId_4 = "g_"+c+"_4";
	
	String state_cd 				= CommonUtil.isNull(paramMap.get("state_cd"));
	String approval_cd 				= CommonUtil.isNull(paramMap.get("approval_cd"));
	String doc_cd 					= CommonUtil.isNull(paramMap.get("doc_cd"));
	String rc 						= CommonUtil.isNull(paramMap.get("rc"));
	String flag 					= CommonUtil.isNull(paramMap.get("flag"));

	// 목록 화면 검색 파라미터.
	String search_data_center 		= CommonUtil.isNull(paramMap.get("search_data_center"));
	// 결재목록에서 넘어온 값
	String search_approval_cd 		= CommonUtil.isNull(paramMap.get("search_approval_cd"));
	// 의뢰목록에서 넘어온 값
	String search_state_cd 			= CommonUtil.isNull(paramMap.get("search_state_cd"));
	String search_apply_cd			= CommonUtil.isNull(paramMap.get("search_apply_cd"));
	String search_gb 				= CommonUtil.isNull(paramMap.get("search_gb"));
	String search_text 				= CommonUtil.isNull(paramMap.get("search_text"));
	String search_date_gubun 		= CommonUtil.isNull(paramMap.get("search_date_gubun"));
	String search_s_search_date 	= CommonUtil.isNull(paramMap.get("search_s_search_date"));
	String search_e_search_date 	= CommonUtil.isNull(paramMap.get("search_e_search_date"));
	String search_s_search_date2 	= CommonUtil.isNull(paramMap.get("search_s_search_date2"));
	String search_e_search_date2 	= CommonUtil.isNull(paramMap.get("search_e_search_date2"));
	String search_task_nm 			= CommonUtil.isNull(paramMap.get("search_task_nm"));
	String search_critical			= CommonUtil.isNull(paramMap.get("search_critical"));
	String search_approval_state 	= CommonUtil.isNull(paramMap.get("search_approval_state"));
	String search_check_approval_yn	= CommonUtil.isNull(paramMap.get("search_check_approval_yn"));

	String tabId					= CommonUtil.isNull(paramMap.get("tabId"));
	String doc_cnt					= CommonUtil.isNull(paramMap.get("doc_cnt"));
	String apply_fail_cnt			= CommonUtil.isNull(paramMap.get("apply_fail_cnt"));

	String search_param 			= "&search_data_center="+search_data_center+"&search_approval_cd="+search_approval_cd+"&search_state_cd="+search_state_cd+"&search_apply_cd="+search_apply_cd;
	search_param 					+=	"&search_gb="+search_gb+"&search_text="+search_text+"&search_date_gubun="+search_date_gubun+"&search_approval_state="+search_approval_state;
	search_param 					+=	"&search_s_search_date="+search_s_search_date+"&search_e_search_date="+search_e_search_date+"&search_s_search_date2="+search_s_search_date2+"&search_e_search_date2="+search_e_search_date2;
	search_param 					+=	"&search_task_nm="+search_task_nm+"&search_critical="+search_critical+"&tabId="+tabId+"&doc_cnt="+doc_cnt+"&search_check_approval_yn="+search_check_approval_yn;

	List approvalInfoList			= (List)request.getAttribute("approvalInfoList");
	List approvalLineList			= (List)request.getAttribute("approvalLineList");
	Doc06Bean docBean				= (Doc06Bean)request.getAttribute("doc06");
	List<Doc06Bean> doc06DetailList	= (List<Doc06Bean>)request.getAttribute("doc06DetailList");
	List adminApprovalBtnList 		= (List)request.getAttribute("adminApprovalBtnList");
	List smsDefaultList				= (List)request.getAttribute("smsDefaultList");
	List mailDefaultList			= (List)request.getAttribute("mailDefaultList");

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
	
	String cur_approval_seq		= CommonUtil.isNull(request.getAttribute("cur_approval_seq"));
	String cur_approval_gb		= CommonUtil.isNull(request.getAttribute("cur_approval_gb"));
	String strTitle				= "";
	String strContent			= "";
	String strFileNm			= "";
	String strDataCenter		= "";
	String strDataCenterName	= "";
	String strTableName			= "";	
	String strActGb				= "";	
	String strDoc_cd 			= "";
	String strStateCd 			= "";
	String strApplyCd 			= "";
	String strBatchResult		= "";
	String strAdminApprovalBtn		= "";
	
	if ( adminApprovalBtnList != null ) {		
		for ( int i = 0; i < adminApprovalBtnList.size(); i++ ) {			
			CommonBean commonBean = (CommonBean) adminApprovalBtnList.get(i);			
			strAdminApprovalBtn = CommonUtil.isNull(commonBean.getScode_nm());
		}
	}
	
	String[] aTmp = null;
	
	if ( docBean != null ) {
		strTitle 			= CommonUtil.isNull(CommonUtil.E2K(docBean.getTitle()), "");
		strContent 			= CommonUtil.isNull(CommonUtil.E2K(docBean.getContent()), "");
		strFileNm 			= CommonUtil.isNull(CommonUtil.E2K(docBean.getFile_nm()), "");
		strTableName		= CommonUtil.isNull(CommonUtil.E2K(docBean.getTable_name()), "");
		strDoc_cd 			= CommonUtil.isNull(docBean.getDoc_cd());				
		strDataCenter		= CommonUtil.isNull(CommonUtil.E2K(docBean.getData_center()), "");
		strDataCenterName	= CommonUtil.isNull(CommonUtil.E2K(docBean.getData_center_name()), "");
		strActGb			= CommonUtil.isNull(CommonUtil.E2K(docBean.getAct_gb()), "");
		strStateCd			= CommonUtil.isNull(CommonUtil.E2K(docBean.getState_cd()), "");
		strApplyCd			= CommonUtil.isNull(CommonUtil.E2K(docBean.getApply_cd()), "");
		
		if(strActGb.equals("C")){
			strActGb = "신규";
		}else if(strActGb.equals("D")){
			strActGb = "삭제";
		}else if(strActGb.equals("U")){
			strActGb = "수정";
		}
	}
	
	String strApplyCheck	= "";
	
	int iErrorCnt 			= 0;
	int iWaitCnt 			= 0;
	int rerunCnt			= 0;
	
	for( int i=0; null!=doc06DetailList && i<doc06DetailList.size(); i++ ){
		Doc06Bean bean = (Doc06Bean)doc06DetailList.get(i);
		
		strApplyCheck 	= CommonUtil.isNull(bean.getApply_check());
		strBatchResult	= CommonUtil.isNull(bean.getBatch_result());
		
		if ( strApplyCheck.equals("E") ) {
			iErrorCnt++;
		}

		if ( strApplyCheck.equals("") ) {
			iWaitCnt++;
		}
		
		if ( strBatchResult.equals("재작업") ) {
			rerunCnt++;
		}
	}	
	
	String strServerGb 		= CommonUtil.isNull(CommonUtil.getMessage("SERVER_GB"));
	
	// 의뢰자 정보
	String strInsUserNm = CommonUtil.isNull(docBean.getUser_nm());
	String strInsDeptNm = CommonUtil.isNull(docBean.getDept_nm());
	String strInsDutyNm = CommonUtil.isNull(docBean.getDuty_nm());

	String strUserInfo = "["+S_DEPT_NM+"] ["+S_DUTY_NM+"] "+S_USER_NM;
	if ( !strInsUserNm.equals("") ) {
		strUserInfo = "["+strInsDeptNm+"] ["+strInsDutyNm+"] "+strInsUserNm;
	}
	
	//특정실행날짜
	String t_general_date 	= CommonUtil.isNull(docBean.getT_general_date());

	// 반영일
	String strApplyDate 	  = CommonUtil.isNull(docBean.getApply_date());
%>	
<body>
<form id="userFrm" name="userFrm" method="post" onsubmit="return false;">	
	<input type="hidden" name="data_center" 	id="data_center" 	value="<%=strDataCenter %>"/>
	<input type="hidden" name="doc_gb" 			id="doc_gb" 		value="06" />
	<input type="hidden" name="state_cd" 		id="state_cd" 		value="<%=state_cd %>" />
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
	<input type="hidden" name="search_critical"			id="search_critical" 		value="<%=search_critical%>" />
	<input type="hidden" name="search_approval_state"	id="search_approval_state" 	value="<%=search_approval_state%>" />
	<input type="hidden" name="search_check_approval_yn"	id="search_check_approval_yn" 	value="<%=search_check_approval_yn%>" />
	<input type="hidden" name="tabId"					id="tabId"					value="<%=tabId%>" />
	<input type="hidden" name="doc_cnt"					id="doc_cnt"				value="<%=doc_cnt%>" />
</form>
<!-- 재반영 버튼 클릭시 파라미터 담아서 넘기는 form -->
<form id="f_a" name="f_a" method="post" onsubmit="return false;">
	<input type="hidden" id="doc_cds" 		name="doc_cds" 	/>
	<input type="hidden" id="doc_gbs"		name="doc_gbs"	/>
	<input type="hidden" id="main_doc_cd"	name="main_doc_cd"	/>
</form>
<form id="frm1" name="frm1" method="post" onsubmit="return false;">
	<input type="hidden" id="flag"			name="flag"	/>	
	<input type="hidden" id="doc_seq"		name="doc_seq" />
	<input type="hidden" id="doc_gb"		name="doc_gb" 		value="06" />
	<input type="hidden" id="doc_cd"		name="doc_cd" 		value="<%=strDoc_cd%>" />
	<input type="hidden" id="data_center"	name="data_center" 	value="<%=strDataCenter%>" />
	
	<input type="hidden" id="approval_cd"		name="approval_cd" />
	<input type="hidden" id="approval_seq"		name="approval_seq" />
	<input type="hidden" id="approval_comment"	name="approval_comment" />

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
	<input type="hidden" name="search_critical"			id="search_critical" 		value="<%=search_critical%>" />

	<!-- 그룹결재구성원 결재권/알림권 설정 -->
	<input type="hidden" name="grp_approval_userList" 		id="grp_approval_userList"/>
	<input type="hidden" name="grp_alarm_userList" 			id="grp_alarm_userList"/>

	<input type="hidden" name="post_approval_yn" 			id="post_approval_yn"/>

	<input type="hidden" name="title"						id="title"					value="" />
	<input type="hidden" name="doc_cnt"						id="doc_cnt"				value="<%=doc_cnt%>" />
	<input type="hidden" name="p_apply_date"				id="p_apply_date"			value=""<%=strApplyDate%>/>

</form>

	<table style='width:100%;height:100%;border:none;'>
		<tr style='height:10px;'>
			<td style='vertical-align:top;'>
				<h4 class="ui-widget-header ui-corner-all"  >
					<div id='t_<%=gridId %>' class='title_area'>
						<span><%=CommonUtil.getMessage("CATEGORY.GB.03.SB.0306") %></span>
					</div>
				</h4>
			</td>
		</tr>
		<tr style="height:10px;">
			<td style='vertical-align:top;'>
				<table style="width:100%">
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
									String strApprovalTypeNm	= "";
									if(strApprovalType.equals("03")) strApprovalTypeNm = "[후결]";

									if(!strApprovalGb.equals("")) {
										strApprovalGbMent = CommonUtil.getMessage("USER.APPR.GB."+strApprovalGb);
									}else {
										strApprovalGbMent = "즉시 결재자";
									}

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
									String strLineGb			= CommonUtil.isNull(bean.getLine_gb());

									String userInfo				= "";
									String strAbsenceInfo		= "";
									
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
											<%
												if ( !CommonUtil.E2K(docBean.getState_cd()).equals("00") ) {
											%>
												<%=strApplyDate%>
											<%
												} else {
											%>
												<input type="text" name="apply_date" id="apply_date" class="input datepick" value="<%=strApplyDate%>" style="width:75px; height:21px;" maxlength="8" autocomplete="off" />
											<%
												}
											%>
										</td>
									</tr>
									<tr>
										<td style="vertical-align:top;">
											<div class='cellTitle_ez_right'>요청 사유</div>
										</td>
										<td colspan="5" style="vertical-align:top;">
											<div class='cellContent_kang' style='height:auto;'><%=strTitle%></div>
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
								<div class='cellTitle_kang5'>작업 정보 [문서정보 : <%=strDoc_cd%>]</div>
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
										<th>
											<div class='cellTitle_ez_right'>C-M</div>
										</th>
										<td>
											<div class='cellContent_kang'>
												<%=strDataCenterName %>
											</div>
										</td>
										<%-- <th>
											<div class='cellTitle_kang2'>폴더</div>
										</th>
										<td>
											<div class='cellContent_kang'>
												<%=strTableName %>
											</div>
										</td> --%>
										<th>
											<div class='cellTitle_ez_right'>구분</div>
										</th>
										<td>
											<div class='cellContent_kang'>
												<%=strActGb %>
											</div>
										</td>
									</tr>
								</table>
							</td>
						</tr>
					</table>

			</td>
		</tr>
		<tr>
			<td style="vertial-align:top;">
				<table style="width:100%; height:100%;">
					<tr>
						<td id='ly_<%=gridId_4 %>' style='vertical-align:top;'>
							<div id="<%=gridId_4 %>" class="ui-widget-header ui-corner-all"></div>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr style='height:10px;'>
			<td style='vertical-align:top;'>
				<h4 class="ui-widget-header ui-corner-all" >
					<div align='right' class='btn_area' >
					<%
						String strCurApprovalSeq	= "";
						String strStateCd2			= "";
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
							strStateCd2					= CommonUtil.isNull(bean.getState_cd());
							strInsUserCd				= CommonUtil.isNull(bean.getIns_user_cd());

							String strAbsenceInfo		= "";
						}

						if ( !cur_approval_seq.equals("") ) {
					%>
							<input type="hidden" name="seq" id="seq" value="<%=cur_approval_seq%>"/>

							결재자 의견 : <input type="text" name="app_comment" id="app_comment" maxlength="100" style="width:150px;height:21px;">
							<span id='btn_approval'>결재</span>

							<%	// 후결상태변경 및 반영완료는 반려 처리 불가.
							if ( !strApplyCd.equals("02") ) {
							%>
								<%
								if(!cur_approval_gb.equals("04")){
							%>
							<span id='btn_reject'>반려</span>
							<%
								}
							}
							%>

					<%
						}
					%>

						<span id="btn_draft" style='display:none;'>승인요청</span>
						<span id="btn_admin" style='display:none;'>관리자 즉시결재</span>
						<span id="btn_def_cancel" style='display:none;'>반영취소</span>
						<span id="btn_excel" style="display:none;">작업에러 건 엑셀다운</span>
						<span id="btn_del" style='display:none;'>삭제</span>
					<%
						// 1차결재자 미결이면 기안자 승인취소 가능
						if ( strCurApprovalSeq.equals("1") && strStateCd2.equals("01") && S_USER_CD.equals(strInsUserCd) ) {
					%>
							<span id='btn_cancel'>승인취소</span>
					<%
						}
					%>

						<span id="btn_admin_approval" style='display:none;'>재반영</span>
						<span id='btn_close' style='display:none;'>닫기</span>

					</div>
				</h4>
			</td>
		</tr>

	</table>

<script>

	var strSms  = "<%=strSms%>";
	var strMail = "<%=strMail%>";

	var gridObj_4 = {
			id : "<%=gridId_4 %>"
			,colModel:[
				{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'번호',width:50,minWidth:50,headerCssClass:'cellCenter',cssClass:'cellCenter'}
				,{formatter:gridCellNoneFormatter,field:'TASK_TYPE',id:'TASK_TYPE',name:'작업타입',width:120,minWidth:120,headerCssClass:'cellCenter',cssClass:'cellCenter'}
				,{formatter:gridCellNoneFormatter,field:'TABLE_NAME',id:'TABLE_NAME',name:'폴더',width:120,minWidth:120,headerCssClass:'cellCenter',cssClass:'cellCenter'}
				,{formatter:gridCellNoneFormatter,field:'APPLICATION',id:'APPLICATION',name:'어플리케이션',width:120,minWidth:120,headerCssClass:'cellCenter',cssClass:'cellCenter'}
				,{formatter:gridCellNoneFormatter,field:'GROUP_NAME',id:'GROUP_NAME',name:'그룹',width:120,minWidth:120,headerCssClass:'cellCenter',cssClass:'cellCenter'}
				,{formatter:gridCellNoneFormatter,field:'NODE_ID',id:'NODE_ID',name:'수행서버',width:120,minWidth:120,headerCssClass:'cellCenter',cssClass:'cellCenter'}
				,{formatter:gridCellNoneFormatter,field:'OWNER',id:'OWNER',name:'계정명',width:120,minWidth:120,headerCssClass:'cellCenter',cssClass:'cellCenter'}
				,{formatter:gridCellNoneFormatter,field:'MAX_WAIT',id:'MAX_WAIT',name:'최대대기일',width:120,minWidth:120,headerCssClass:'cellCenter',cssClass:'cellCenter'}
				,{formatter:gridCellNoneFormatter,field:'JOB_NAME',id:'JOB_NAME',name:'작업명',width:120,minWidth:120,headerCssClass:'cellCenter',cssClass:'cellCenter'}
				,{formatter:gridCellNoneFormatter,field:'DESCRIPTION',id:'DESCRIPTION',name:'작업설명',width:120,minWidth:120,headerCssClass:'cellCenter',cssClass:'cellCenter'}
				,{formatter:gridCellNoneFormatter,field:'MEM_LIB',id:'MEM_LIB',name:'프로그램 위치',width:120,minWidth:120,headerCssClass:'cellCenter',cssClass:'cellCenter'}
 				,{formatter:gridCellNoneFormatter,field:'MEM_NAME',id:'MEM_NAME',name:'프로그램 명',width:120,minWidth:120,headerCssClass:'cellCenter',cssClass:'cellCenter'}	
				,{formatter:gridCellNoneFormatter,field:'COMMAND',id:'COMMAND',name:'작업수행명령',width:120,minWidth:120,headerCssClass:'cellCenter',cssClass:'cellCenter'}
				,{formatter:gridCellNoneFormatter,field:'TIME_FROM',id:'TIME_FROM',name:'작업시작시간',width:120,minWidth:120,headerCssClass:'cellCenter',cssClass:'cellCenter'}
				,{formatter:gridCellNoneFormatter,field:'TIME_UNTIL',id:'TIME_UNTIL',name:'작업종료시간',width:120,minWidth:120,headerCssClass:'cellCenter',cssClass:'cellCenter'}
				,{formatter:gridCellNoneFormatter,field:'LATE_SUB',id:'LATE_SUB',name:'시작임계시간',width:120,minWidth:120,headerCssClass:'cellCenter',cssClass:'cellCenter'}
				,{formatter:gridCellNoneFormatter,field:'LATE_TIME',id:'LATE_TIME',name:'종료임계시간',width:120,minWidth:120,headerCssClass:'cellCenter',cssClass:'cellCenter'}
				,{formatter:gridCellNoneFormatter,field:'LATE_EXEC',id:'LATE_EXEC',name:'수행임계시간',width:120,minWidth:120,headerCssClass:'cellCenter',cssClass:'cellCenter'}
				,{formatter:gridCellNoneFormatter,field:'CYCLIC',id:'CYCLIC',name:'반복작업',width:120,minWidth:120,headerCssClass:'cellCenter',cssClass:'cellCenter'}
				,{formatter:gridCellNoneFormatter,field:'CYCLIC_TYPE',id:'CYCLIC_TYPE',name:'반복구분',width:120,minWidth:120,headerCssClass:'cellCenter',cssClass:'cellCenter'}				
				,{formatter:gridCellNoneFormatter,field:'RERUN_INTERVAL',id:'RERUN_INTERVAL' ,name:'반복주기',width:120,minWidth:120,headerCssClass:'cellCenter',cssClass:'cellCenter'}
				,{formatter:gridCellNoneFormatter,field:'INTERVAL_SEQUENCE',id:'INTERVAL_SEQUENCE' ,name:'반복주기(불규칙)',width:120,minWidth:120,headerCssClass:'cellCenter',cssClass:'cellCenter'}
				,{formatter:gridCellNoneFormatter,field:'SPECIFIC_TIMES',id:'SPECIFIC_TIMES' ,name:'반복주기(시간지정)',width:120,minWidth:120,headerCssClass:'cellCenter',cssClass:'cellCenter'}
				,{formatter:gridCellNoneFormatter,field:'IND_CYCLIC',id:'IND_CYCLIC' ,name:'반복기준',width:120,minWidth:120,headerCssClass:'cellCenter',cssClass:'cellCenter'}
				,{formatter:gridCellNoneFormatter,field:'TOLERANCE',id:'TOLERANCE' ,name:'허용오차(분)',width:120,minWidth:120,headerCssClass:'cellCenter',cssClass:'cellCenter'}
				,{formatter:gridCellNoneFormatter,field:'RERUN_MAX',id:'RERUN_MAX',name:'최대반복횟수',width:120,minWidth:120,headerCssClass:'cellCenter',cssClass:'cellCenter'}
				,{formatter:gridCellNoneFormatter,field:'COUNT_CYCLIC_FROM',id:'COUNT_CYCLIC_FROM',name:'COUNT_CYCLIC_FROM',width:120,minWidth:120,headerCssClass:'cellCenter',cssClass:'cellCenter'}
				,{formatter:gridCellNoneFormatter,field:'CONFIRM_FLAG',id:'CONFIRM_FLAG',name:'Confirm Flag',width:120,minWidth:120,headerCssClass:'cellCenter',cssClass:'cellCenter'}
				,{formatter:gridCellNoneFormatter,field:'PRIORITY',id:'PRIORITY',name:'우선순위',width:120,minWidth:120,headerCssClass:'cellCenter',cssClass:'cellCenter'}
				,{formatter:gridCellNoneFormatter,field:'SUCCESS_SMS_YN',id:'SUCCESS_SMS_YN',name:'성공 시 알람 발송',width:100,minWidth:100,headerCssClass:'cellCenter',cssClass:'cellCenter'}
				,{formatter:gridCellNoneFormatter,field:'CRITICAL',id:'CRITICAL',name:'중요작업',width:100,minWidth:100,headerCssClass:'cellCenter',cssClass:'cellCenter'}
				
				
				//,{formatter:gridCellNoneFormatter,field:'CALENDAR_NM',id:'CALENDAR_NM',name:'작업주기/시기',width:120,headerCssClass:'cellCenter',cssClass:'cellCenter'}
				,{formatter:gridCellNoneFormatter,field:'MONTH_DAYS', id:'MONTH_DAYS',name:'실행날짜',width:120,minWidth:120,headerCssClass:'cellCenter',cssClass:'cellCenter'}
				,{formatter:gridCellNoneFormatter,field:'DAYS_CAL', id:'DAYS_CAL',name:'월캘린더',width:120,minWidth:120,headerCssClass:'cellCenter',cssClass:'cellCenter'}
				,{formatter:gridCellNoneFormatter,field:'CONF_CAL',id:'CONF_CAL',name:'CONF_CAL',width:120,headerCssClass:'cellCenter',cssClass:'cellCenter'}
				,{formatter:gridCellNoneFormatter,field:'SHIFT',id:'SHIFT',name:'POLICY',width:120,headerCssClass:'cellCenter',cssClass:'cellCenter'}
				,{formatter:gridCellNoneFormatter,field:'SHIFT_NUM',id:'SHIFT_NUM',name:'SHIFT_NUM',width:120,headerCssClass:'cellCenter',cssClass:'cellCenter'}
				,{formatter:gridCellNoneFormatter,field:'ACTIVE_DAY', id:'ACTIVE_DAY',name:'수행 범위일',width:120,minWidth:120,headerCssClass:'cellCenter',cssClass:'cellCenter'}
				,{formatter:gridCellNoneFormatter,field:'MONTH_1', id:'MONTH_1',name:'1월',width:120,minWidth:120,headerCssClass:'cellCenter',cssClass:'cellCenter'}
				,{formatter:gridCellNoneFormatter,field:'MONTH_2', id:'MONTH_2',name:'2월',width:120,minWidth:120,headerCssClass:'cellCenter',cssClass:'cellCenter'}
				,{formatter:gridCellNoneFormatter,field:'MONTH_3', id:'MONTH_3',name:'3월',width:120,minWidth:120,headerCssClass:'cellCenter',cssClass:'cellCenter'}
				,{formatter:gridCellNoneFormatter,field:'MONTH_4', id:'MONTH_4',name:'4월',width:120,minWidth:120,headerCssClass:'cellCenter',cssClass:'cellCenter'}
				,{formatter:gridCellNoneFormatter,field:'MONTH_5', id:'MONTH_5',name:'5월',width:120,minWidth:120,headerCssClass:'cellCenter',cssClass:'cellCenter'}
				,{formatter:gridCellNoneFormatter,field:'MONTH_6', id:'MONTH_6',name:'6월',width:120,minWidth:120,headerCssClass:'cellCenter',cssClass:'cellCenter'}
				,{formatter:gridCellNoneFormatter,field:'MONTH_7', id:'MONTH_7',name:'7월',width:120,minWidth:120,headerCssClass:'cellCenter',cssClass:'cellCenter'}
				,{formatter:gridCellNoneFormatter,field:'MONTH_8', id:'MONTH_8',name:'8월',width:120,minWidth:120,headerCssClass:'cellCenter',cssClass:'cellCenter'}
				,{formatter:gridCellNoneFormatter,field:'MONTH_9', id:'MONTH_9',name:'9월',width:120,minWidth:120,headerCssClass:'cellCenter',cssClass:'cellCenter'}
				,{formatter:gridCellNoneFormatter,field:'MONTH_10', id:'MONTH_10',name:'10월',width:120,minWidth:120,headerCssClass:'cellCenter',cssClass:'cellCenter'}
				,{formatter:gridCellNoneFormatter,field:'MONTH_11', id:'MONTH_11',name:'11월',width:120,minWidth:120,headerCssClass:'cellCenter',cssClass:'cellCenter'}
				,{formatter:gridCellNoneFormatter,field:'MONTH_12', id:'MONTH_12',name:'12월',width:120,minWidth:120,headerCssClass:'cellCenter',cssClass:'cellCenter'}
				,{formatter:gridCellNoneFormatter,field:'SCHEDULE_AND_OR', id:'SCHEDULE_AND_OR',name:'schedule_and_or',width:120,minWidth:120,headerCssClass:'cellCenter',cssClass:'cellCenter'}
				,{formatter:gridCellNoneFormatter,field:'WEEK_DAYS', id:'WEEK_DAYS',name:'실행요일',width:120,minWidth:120,headerCssClass:'cellCenter',cssClass:'cellCenter'}
				,{formatter:gridCellNoneFormatter,field:'WEEKS_CAL', id:'WEEKS_CAL',name:'일캘린더',width:120,minWidth:120,headerCssClass:'cellCenter',cssClass:'cellCenter'}
				,{formatter:gridCellNoneFormatter,field:'T_GENERAL_DATE', id:'T_GENERAL_DATE',name:'특정실행날짜',width:120,minWidth:120,headerCssClass:'cellCenter',cssClass:'cellCenter'}
				
				,{formatter:gridCellNoneFormatter,field:'T_CONDITIONS_IN',id:'T_CONDITIONS_IN',name:'IN_CONDITION',width:120,minWidth:120,headerCssClass:'cellCenter',cssClass:'cellCenter'}
				,{formatter:gridCellNoneFormatter,field:'T_CONDITIONS_OUT',id:'T_CONDITIONS_OUT',name:'OUT_CONDITION',width:120,minWidth:120,headerCssClass:'cellCenter',cssClass:'cellCenter'}
				,{formatter:gridCellNoneFormatter,field:'AUTHOR',id:'AUTHOR',name:'담당자1',width:120,minWidth:120,headerCssClass:'cellCenter',cssClass:'cellCenter'}
				,{formatter:gridCellNoneFormatter,field:'SMS_1',id:'SMS_1',name:'담당자1 '+strSms,width:100,minWidth:100,headerCssClass:'cellCenter',cssClass:'cellCenter'}
				,{formatter:gridCellNoneFormatter,field:'MAIL_1',id:'MAIL_1',name:'담당자1 '+strMail,width:100,minWidth:100,headerCssClass:'cellCenter',cssClass:'cellCenter'}
				,{formatter:gridCellNoneFormatter,field:'USER_ID_2',id:'USER_ID_2',name:'담당자2',width:120,minWidth:120,headerCssClass:'cellCenter',cssClass:'cellCenter'}
				,{formatter:gridCellNoneFormatter,field:'SMS_2',id:'SMS_2',name:'담당자2 '+strSms,width:100,minWidth:100,headerCssClass:'cellCenter',cssClass:'cellCenter'}
				,{formatter:gridCellNoneFormatter,field:'MAIL_2',id:'MAIL_2',name:'담당자2 '+strMail,width:100,minWidth:100,headerCssClass:'cellCenter',cssClass:'cellCenter'}
				,{formatter:gridCellNoneFormatter,field:'USER_ID_3',id:'USER_ID_3',name:'담당자3',width:120,minWidth:120,headerCssClass:'cellCenter',cssClass:'cellCenter'}
				,{formatter:gridCellNoneFormatter,field:'SMS_3',id:'SMS_3',name:'담당자3 '+strSms,width:100,minWidth:100,headerCssClass:'cellCenter',cssClass:'cellCenter'}
				,{formatter:gridCellNoneFormatter,field:'MAIL_3',id:'MAIL_3',name:'담당자3 '+strMail,width:100,minWidth:100,headerCssClass:'cellCenter',cssClass:'cellCenter'}
				,{formatter:gridCellNoneFormatter,field:'USER_ID_4',id:'USER_ID_4',name:'담당자4',width:120,minWidth:120,headerCssClass:'cellCenter',cssClass:'cellCenter'}
				,{formatter:gridCellNoneFormatter,field:'SMS_4',id:'SMS_4',name:'담당자4 '+strSms,width:100,minWidth:100,headerCssClass:'cellCenter',cssClass:'cellCenter'}
				,{formatter:gridCellNoneFormatter,field:'MAIL_4',id:'MAIL_4',name:'담당자4 '+strMail,width:100,minWidth:100,headerCssClass:'cellCenter',cssClass:'cellCenter'}
				,{formatter:gridCellNoneFormatter,field:'USER_ID_5',id:'USER_ID_5',name:'담당자5',width:120,minWidth:120,headerCssClass:'cellCenter',cssClass:'cellCenter'}
				,{formatter:gridCellNoneFormatter,field:'SMS_5',id:'SMS_5',name:'담당자5 '+strSms,width:100,minWidth:100,headerCssClass:'cellCenter',cssClass:'cellCenter'}
				,{formatter:gridCellNoneFormatter,field:'MAIL_5',id:'MAIL_5',name:'담당자5 '+strMail,width:100,minWidth:100,headerCssClass:'cellCenter',cssClass:'cellCenter'}
				,{formatter:gridCellNoneFormatter,field:'USER_ID_6',id:'USER_ID_6',name:'담당자6',width:120,minWidth:120,headerCssClass:'cellCenter',cssClass:'cellCenter'}
				,{formatter:gridCellNoneFormatter,field:'SMS_6',id:'SMS_6',name:'담당자6 '+strSms,width:100,headerCssClass:'cellCenter',cssClass:'cellCenter'}
				,{formatter:gridCellNoneFormatter,field:'MAIL_6',id:'MAIL_6',name:'담당자6 '+strMail,width:100,minWidth:100,headerCssClass:'cellCenter',cssClass:'cellCenter'}
				,{formatter:gridCellNoneFormatter,field:'USER_ID_7',id:'USER_ID_7',name:'담당자7',width:120,minWidth:120,headerCssClass:'cellCenter',cssClass:'cellCenter'}
				,{formatter:gridCellNoneFormatter,field:'SMS_7',id:'SMS_7',name:'담당자7 '+strSms,width:100,minWidth:100,headerCssClass:'cellCenter',cssClass:'cellCenter'}
				,{formatter:gridCellNoneFormatter,field:'MAIL_7',id:'MAIL_7',name:'담당자7 '+strMail,width:100,minWidth:100,headerCssClass:'cellCenter',cssClass:'cellCenter'}
				,{formatter:gridCellNoneFormatter,field:'USER_ID_8',id:'USER_ID_8',name:'담당자8',width:120,minWidth:120,headerCssClass:'cellCenter',cssClass:'cellCenter'}
				,{formatter:gridCellNoneFormatter,field:'SMS_8',id:'SMS_8',name:'담당자8 '+strSms,width:100,minWidth:100,headerCssClass:'cellCenter',cssClass:'cellCenter'}
				,{formatter:gridCellNoneFormatter,field:'MAIL_8',id:'MAIL_8',name:'담당자8 '+strMail,width:100,minWidth:100,headerCssClass:'cellCenter',cssClass:'cellCenter'}
				,{formatter:gridCellNoneFormatter,field:'USER_ID_9',id:'USER_ID_9',name:'담당자9',width:120,minWidth:120,headerCssClass:'cellCenter',cssClass:'cellCenter'}
				,{formatter:gridCellNoneFormatter,field:'SMS_9',id:'SMS_9',name:'담당자9 '+strSms,width:100,minWidth:100,headerCssClass:'cellCenter',cssClass:'cellCenter'}
				,{formatter:gridCellNoneFormatter,field:'MAIL_9',id:'MAIL_9',name:'담당자9 '+strMail,width:100,minWidth:100,headerCssClass:'cellCenter',cssClass:'cellCenter'}
				,{formatter:gridCellNoneFormatter,field:'USER_ID_10',id:'USER_ID_10',name:'담당자10',width:120,minWidth:120,headerCssClass:'cellCenter',cssClass:'cellCenter'}
				,{formatter:gridCellNoneFormatter,field:'SMS_10',id:'SMS_10',name:'담당자10 '+strSms,width:100,minWidth:100,headerCssClass:'cellCenter',cssClass:'cellCenter'}
				,{formatter:gridCellNoneFormatter,field:'MAIL_10',id:'MAIL_10',name:'담당자10 '+strMail,width:100,minWidth:100,headerCssClass:'cellCenter',cssClass:'cellCenter'}
				,{formatter:gridCellNoneFormatter,field:'GRP_NM_1',id:'GRP_NM_1',name:'그룹1',width:120,minWidth:120,headerCssClass:'cellCenter',cssClass:'cellCenter'}
				,{formatter:gridCellNoneFormatter,field:'GRP_SMS_1',id:'GRP_SMS_1',name:'그룹1 '+strSms,width:100,minWidth:100,headerCssClass:'cellCenter',cssClass:'cellCenter'}
				,{formatter:gridCellNoneFormatter,field:'GRP_MAIL_1',id:'GRP_MAIL_1',name:'그룹1 '+strMail,width:100,minWidth:100,headerCssClass:'cellCenter',cssClass:'cellCenter'}
				,{formatter:gridCellNoneFormatter,field:'GRP_NM_2',id:'GRP_NM_2',name:'그룹2',width:120,minWidth:120,headerCssClass:'cellCenter',cssClass:'cellCenter'}
				,{formatter:gridCellNoneFormatter,field:'GRP_SMS_2',id:'GRP_SMS_2',name:'그룹2 '+strSms,width:100,minWidth:100,headerCssClass:'cellCenter',cssClass:'cellCenter'}
				,{formatter:gridCellNoneFormatter,field:'GRP_MAIL_2',id:'GRP_MAIL_2',name:'그룹2 '+strMail,width:100,minWidth:100,headerCssClass:'cellCenter',cssClass:'cellCenter'}
				,{formatter:gridCellNoneFormatter,field:'T_RESOURCES_Q',id:'T_RESOURCES_Q',name:'Resource',width:120,minWidth:120,headerCssClass:'cellCenter',cssClass:'cellCenter'}
				,{formatter:gridCellNoneFormatter,field:'T_SET',id:'T_SET',name:'변수',width:120,minWidth:120,headerCssClass:'cellCenter',cssClass:'cellCenter'}
				,{formatter:gridCellNoneFormatter,field:'T_STEPS',id:'T_STEPS',name:'STEP',width:120,minWidth:120,headerCssClass:'cellCenter',cssClass:'cellCenter'}
				,{formatter:gridCellNoneFormatter,field:'BATCHRESULT',id:'BATCHRESULT',name:'반영 결과',width:120,minWidth:120,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
				,{formatter:gridCellNoneFormatter,field:'R_MSG',id:'R_MSG',name:'리턴 메시지',width:250,minWidth:250,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
				,{formatter:gridCellNoneFormatter,field:'SEQ',id:'SEQ',name:'SEQ',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
				,{formatter:gridCellNoneFormatter,field:'STATE_CD',id:'STATE_CD',name:'STATE_CD',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
				
// 				,{formatter:gridCellNoneFormatter,field:'MEM_LIB',id:'MEM_LIB',name:'프로그램 위치',width:120,headerCssClass:'cellCenter',cssClass:'cellCenter'}
// 				,{formatter:gridCellNoneFormatter,field:'MEM_NAME',id:'MEM_NAME',name:'프로그램 명',width:120,headerCssClass:'cellCenter',cssClass:'cellCenter'}				

// 				,{formatter:gridCellNoneFormatter,field:'MAX_WAIT',id:'MAX_WAIT',name:'MAX_WAIT',width:120,headerCssClass:'cellCenter',cssClass:'cellCenter'}
				
				
				
// 				,{formatter:gridCellNoneFormatter,field:'T_RESOURCES_C',id:'T_RESOURCES_C',name:'Control_Resource',width:120,headerCssClass:'cellCenter',cssClass:'cellCenter'}				
// 				,{formatter:gridCellNoneFormatter,field:'T_POSTPROC',id:'T_POSTPROC',name:'PostProc',width:120,headerCssClass:'cellCenter',cssClass:'cellCenter'}
				
// 				,{formatter:gridCellNoneFormatter,field:'CHARGEPMNM',id:'CHARGEPMNM',name:'담당PM',width:120,headerCssClass:'cellCenter',cssClass:'cellCenter'}
				//,{formatter:gridCellNoneFormatter,field:'USER_CD_2',id:'USER_CD_2',name:'담당자2',width:120,headerCssClass:'cellCenter',cssClass:'cellCenter'}
				//,{formatter:gridCellNoneFormatter,field:'USER_CD_3',id:'USER_CD_3',name:'담당자3',width:120,headerCssClass:'cellCenter',cssClass:'cellCenter'}
				//,{formatter:gridCellNoneFormatter,field:'USER_CD_4',id:'USER_CD_4',name:'담당자4',width:120,headerCssClass:'cellCenter',cssClass:'cellCenter'}
				
				
				
				
		   	]
			,rows:[]
			,vscroll:<%=S_GRID_VSCROLL%>
		};
	
	
	$(document).ready(function() {
		
		var doc_cd 		= '<%=doc_cd%>';
		
		$("#btn_close").show();
		
		var state_cd 			= "<%=strStateCd%>";
		var apply_cd 			= "<%=strApplyCd%>";
		var error_cnt 			= "<%=iErrorCnt%>";
		var wait_cnt 			= "<%=iWaitCnt%>";
		var server_gb			= "<%=strServerGb%>";
		var session_user_gb		= "<%=S_USER_GB%>";
		var rerun_cnt 			= "<%=rerunCnt%>";
		var adminApprovalBtn 	= "<%=strAdminApprovalBtn %>";
		var apply_fail_cnt		= "<%=apply_fail_cnt %>";

		if ( state_cd == "00" ) {
			$("#btn_del").show();
			
			//if ( server_gb == "P" ) {
			$("#btn_draft").show();
			//}
			
			if( adminApprovalBtn == "Y" || (session_user_gb == "99" || session_user_gb == "03") ){
					$("#btn_admin").show();
			} else {
				$("#btn_admin").hide();
			}
		}

		if ( session_user_gb == "99" || session_user_gb == "02" ) {
			$("#btn_del").show();
		}

		if ( apply_cd == "02" && wait_cnt > 0 ) {
			//$("#btn_def_cancel").show();
		}
		
		if ( error_cnt > 0 ) {
			$("#btn_admin_approval").show();
			$("#btn_excel").show();

		}		
				
		viewGrid_1(gridObj_4,"ly_"+gridObj_4.id,{enableColumnReorder:true},'AUTO');
		setTimeout(function(){
			doc06DetailList("<%=doc_cd%>");
		}, 500);
		
		//체크박스
		viewGridChk_1(gridObj_4,"ly_"+gridObj_4.id,{enableColumnReorder:true},'AUTO');
		
		$("#btn_admin_approval").button().unbind("click").click(function(){			
			UpdateFlag();		
		});
		
		$("#btn_def_cancel").button().unbind("click").click(function(){			
			UpdateFlag2();
		});
		
		$("#btn_admin").button().unbind("click").click(function(){
			goPrc4('draft_admin');
		});
		$("#btn_del").button().unbind("click").click(function(){
			goPrc4('del');
		});
		
		$("#btn_excel").button().unbind("click").click(function(){
			doc06DetailExcelList("<%=doc_cd%>");
		});
		
		$("#btn_cancel").button().unbind("click").click(function(){
			goCancel();
		});
		
		$("#btn_draft").button().unbind("click").click(function(){
			getAdminLineGrpCd('draft', '01');
		});
		
		$("#btn_approval").button().unbind("click").click(function(){		
			goPrc3('02', $("#seq").val(), '결재');
		});
		
		$("#btn_reject").button().unbind("click").click(function(){
			goPrc3('04', $("#seq").val(), '반려');
		});
		
		$("#btn_close").button().unbind("click").click(function(){
			top.closeTabs('tabs-'+doc_cd);
		});

		//반영일
		$("#apply_date").addClass("text_input").unbind('click').click(function(){
			dpCalMinMax(this.id,'yymmdd','0','90');
		});

	});

	function doc06DetailList(doc_cd){
		
		try{viewProgBar(true);}catch(e){}
		$('#ly_total_cnt').html('');
				
		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=doc06DetailList&itemGubun=2&doc_cd='+doc_cd;
		
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
								var doc_cd 				= $(this).find("DOC_CD").text();
								var table_name	 		= $(this).find("TABLE_NAME").text();
								var application 		= $(this).find("APPLICATION").text();
								var group_name 			= $(this).find("GROUP_NAME").text();
								var job_name 			= $(this).find("JOB_NAME").text();
								var desc 				= $(this).find("DESC").text();
								var mem_name 			= $(this).find("MEM_NAME").text();
								var mem_lib 			= $(this).find("MEM_LIB").text();
								var author 				= $(this).find("AUTHOR").text();
								var owner 				= $(this).find("OWNER").text();
								var task_type 			= $(this).find("TASK_TYPE").text();
								var node_id 			= $(this).find("NODE_ID").text();
								var priority 			= $(this).find("PRIORITY").text();
								var critical 			= $(this).find("CRITICAL").text();
								var cyclic 				= $(this).find("CYCLIC").text();
								var rerun_inerval 		= $(this).find("RERUN_INTERVAL").text();
								var rerun_max 			= $(this).find("RERUN_MAX").text();
								var count_cyclic_from 	= $(this).find("COUNT_CYCLIC_FROM").text();
								var command 			= $(this).find("COMMAND").text();
								var confirm_flag 		= $(this).find("CONFIRM_FLAG").text();
								var max_wait 			= $(this).find("MAX_WAIT").text();
								var time_from 			= $(this).find("TIME_FROM").text();
								var time_until 			= $(this).find("TIME_UNTIL").text();
								var cond_in 			= $(this).find("T_CONDITIONS_IN").text();
								var cond_out 			= $(this).find("T_CONDITIONS_OUT").text();
								var resource_c 			= $(this).find("T_RESOURCES_C").text();
								var resource_q 			= $(this).find("T_RESOURCES_Q").text();
								var set 				= $(this).find("T_SET").text();
								var steps 				= $(this).find("T_STEPS").text();
								var postproc 			= $(this).find("T_POSTPROC").text();
								var calendar_nm 		= $(this).find("CALENDAR_NM").text();

								var month_days          = $(this).find("MONTH_DAYS").text();
								var days_cal            = $(this).find("DAYS_CAL").text();
								var conf_cal 			= $(this).find("CONF_CAL").text();
								var shift 				= $(this).find("SHIFT").text();
								var shift_num 			= $(this).find("SHIFT_NUM").text();
								
								var month_1             = $(this).find("MONTH_1").text();
								var month_2             = $(this).find("MONTH_2").text();
								var month_3             = $(this).find("MONTH_3").text();
								var month_4             = $(this).find("MONTH_4").text();
								var month_5             = $(this).find("MONTH_5").text();
								var month_6             = $(this).find("MONTH_6").text();
								var month_7             = $(this).find("MONTH_7").text();
								var month_8             = $(this).find("MONTH_8").text();
								var month_9             = $(this).find("MONTH_9").text();
								var month_10            = $(this).find("MONTH_10").text();
								var month_11            = $(this).find("MONTH_11").text();
								var month_12            = $(this).find("MONTH_12").text();
								var schedule_and_or     = $(this).find("SCHEDULE_AND_OR").text();
								var week_days           = $(this).find("WEEK_DAYS").text();
								var weeks_cal           = $(this).find("WEEKS_CAL").text();
								var t_general_date      = $(this).find("T_GENERAL_DATE").text();
								var active_from      	= $(this).find("ACTIVE_FROM").text();
								var active_till		    = $(this).find("ACTIVE_TILL").text();
								var active_day			= "";
								
								var late_sub 			= $(this).find("LATE_SUB").text();
								var late_time 			= $(this).find("LATE_TIME").text();
								var late_exec 			= $(this).find("LATE_EXEC").text();
								var error_desc 			= $(this).find("ERROR_DESC").text();
								var user2 				= $(this).find("USER_CD_2").text();
								var user3 				= $(this).find("USER_CD_3").text();
								var user4 				= $(this).find("USER_CD_4").text();
								var user5 				= $(this).find("USER_CD_5").text();
								var user6 				= $(this).find("USER_CD_6").text();
								var user7 				= $(this).find("USER_CD_7").text();
								var user8 				= $(this).find("USER_CD_8").text();
								var user9 				= $(this).find("USER_CD_9").text();
								var user10 				= $(this).find("USER_CD_10").text();
								var batchResult 		= $(this).find("BATCHRESULT").text();
								var r_msg 				= $(this).find("R_MSG").text();
								var seq 				= $(this).find("SEQ").text();
								var state_cd 			= $(this).find("STATE_CD").text();

								var success_sms_yn 		= $(this).find("SUCCESS_SMS_YN").text();
								
								var user_id_2	 		= $(this).find("USER_ID_2").text();
								var user_id_3	 		= $(this).find("USER_ID_3").text();
								var user_id_4 			= $(this).find("USER_ID_4").text();
								var user_id_5	 		= $(this).find("USER_ID_5").text();
								var user_id_6	 		= $(this).find("USER_ID_6").text();
								var user_id_7 			= $(this).find("USER_ID_7").text();
								var user_id_8 			= $(this).find("USER_ID_8").text();
								var user_id_9 			= $(this).find("USER_ID_9").text();
								var user_id_10 			= $(this).find("USER_ID_10").text();

								var interval_sequence 	= $(this).find("INTERVAL_SEQUENCE").text();
								var specific_times 		= $(this).find("SPECIFIC_TIMES").text();
								var cyclic_type 		= $(this).find("CYCLIC_TYPE").text();
								var ind_cyclic			= $(this).find("IND_CYCLIC").text();
								var tolerance 			= $(this).find("TOLERANCE").text();
								
								var sms_1 				= $(this).find("SMS_1").text();
								var mail_1 				= $(this).find("MAIL_1").text();
								var sms_2 				= $(this).find("SMS_2").text();
								var mail_2 				= $(this).find("MAIL_2").text();
								var sms_3 				= $(this).find("SMS_3").text();
								var mail_3 				= $(this).find("MAIL_3").text();
								var sms_4 				= $(this).find("SMS_4").text();
								var mail_4 				= $(this).find("MAIL_4").text();
								var sms_5				= $(this).find("SMS_5").text();
								var mail_5 				= $(this).find("MAIL_5").text();
								var sms_6				= $(this).find("SMS_6").text();
								var mail_6 				= $(this).find("MAIL_6").text();
								var sms_7				= $(this).find("SMS_7").text();
								var mail_7 				= $(this).find("MAIL_7").text();
								var sms_8				= $(this).find("SMS_8").text();
								var mail_8 				= $(this).find("MAIL_8").text();
								var sms_9				= $(this).find("SMS_9").text();
								var mail_9 				= $(this).find("MAIL_9").text();
								var sms_10				= $(this).find("SMS_10").text();
								var mail_10				= $(this).find("MAIL_10").text();

								var grp_nm_1	 		= $(this).find("GRP_NM_1").text();
								var grp_nm_2	 		= $(this).find("GRP_NM_2").text();
								var grp_sms_1 			= $(this).find("GRP_SMS_1").text();
								var grp_mail_1 			= $(this).find("GRP_MAIL_1").text();
								var grp_sms_2 			= $(this).find("GRP_SMS_2").text();
								var grp_mail_2 			= $(this).find("GRP_MAIL_2").text();

								if(task_type == "job"){
									task_type = "script";
								}
								
								if(active_from != "" && active_till != ""){
									active_day = active_from + "~" + active_till;
								}

								var doc_cd_c               	= "";
								var systemGb_c 				= "";
								var jobTypeGb_c				= "";
								var table_name_c			= "";
								var application_c          	= "";
								var group_name_c           	= "";
								var job_name_c             	= "";
								var desc_c                 	= "";
								var mem_name_c             	= "";
								var mem_lib_c              	= "";
								var author_c               	= "";
								var owner_c                	= "";
								var batchjobgrade_c        	= "";
								var task_type_c            	= "";
								var node_id_c              	= "";
								var priority_c             	= "";
								var critical_c             	= "";
								var cyclic_c               	= "";
								var rerun_inerval_c        	= "";
								var rerun_max_c            	= "";
								var count_cyclic_from_c    	= "";
								var command_c              	= "";
								var confirm_flag_c         	= "";
								var max_wait_c             	= "";
								var time_from_c            	= "";
								var time_until_c           	= "";
								var cond_in_c              	= "";
								var cond_out_c             	= "";
								var resource_c_c           	= "";
								var resource_q_c           	= "";
								var set_c                  	= "";
								var steps_c                	= "";
								var postproc_c             	= "";
								var calendar_nm_c          	= "";
								
								var month_days_c            = "";
								var days_cal_c              = "";
								var month_1_c               = "";
								var month_2_c               = "";
								var month_3_c               = "";
								var month_4_c               = "";
								var month_5_c               = "";
								var month_6_c               = "";
								var month_7_c               = "";
								var month_8_c               = "";
								var month_9_c               = "";
								var month_10_c              = "";
								var month_11_c              = "";
								var month_12_c              = "";
								var schedule_and_or_c       = "";
								var week_days_c             = "";
								var weeks_cal_c             = "";
								var t_general_date_c        = "";
								var active_day_c       		= "";
								
								var conf_cal_c 				= "";
								var shift_c 				= "";
								var shift_num_c 			= "";
								
								var late_sub_c             	= "";
								var late_time_c            	= "";
								var late_exec_c            	= "";
								var batchjobgrade_c        	= "";
								var error_desc_c           	= "";
								var user2_c                	= "";
								var user3_c               	= "";
								var user4_c                	= "";
								var user5_c                	= "";
								var user6_c                	= "";
								var user7_c                	= "";
								var user8_c                	= "";
								var user9_c                	= "";
								var user10_c               	= "";
								var batchResult_c 		   	= "";
								var r_msg_c 			   	= "";
								var seq_c		 		   	= "";
								var state_cd_c		 	   	= "";

								var success_sms_yn_c		= "";
								
								var user_id_2_c				= "";
								var user_id_3_c				= "";
								var user_id_4_c				= "";
								var user_id_5_c				= "";
								var user_id_6_c				= "";
								var user_id_7_c				= "";
								var user_id_8_c				= "";
								var user_id_9_c				= "";
								var user_id_10_c			= "";

								var interval_sequence_c		= "";
								var specific_times_c		= "";
								var cyclic_type_c			= "";
								var ind_cyclic_c			= "";
								var tolerance_c				= "";
								
								var sms_1_c					= "";
								var mail_1_c				= "";
								var sms_2_c					= "";
								var mail_2_c				= "";
								var sms_3_c					= "";
								var mail_3_c				= "";
								var sms_4_c					= "";
								var mail_4_c				= "";
								var sms_5_c					= "";
								var mail_5_c				= "";
								var sms_6_c					= "";
								var mail_6_c				= "";
								var sms_7_c					= "";
								var mail_7_c				= "";
								var sms_8_c					= "";
								var mail_8_c				= "";
								var sms_9_c					= "";
								var mail_9_c				= "";
								var sms_10_c				= "";
								var mail_10_c				= "";

								var grp_nm_1_c	 			=  "";
								var grp_nm_2_c	 			=  "";
								var grp_sms_1_c 			=  "";
								var grp_mail_1_c 			=  "";
								var grp_sms_2_c 			=  "";
								var grp_mail_2_c 			=  "";

								if(batchResult == '작업에러') {
									doc_cd_c               	= "<font color='red'>"+doc_cd+"</font>";
									table_name_c          	= "<font color='red'>"+table_name+"</font>";
									application_c          	= "<font color='red'>"+application+"</font>";
									group_name_c           	= "<font color='red'>"+group_name+"</font>";
									job_name_c             	= "<font color='red'>"+job_name+"</font>";
									desc_c                 	= "<font color='red'>"+desc+"</font>";
									mem_name_c             	= "<font color='red'>"+mem_name+"</font>";
									mem_lib_c              	= "<font color='red'>"+mem_lib+"</font>";
									author_c               	= "<font color='red'>"+author+"</font>";
									owner_c                	= "<font color='red'>"+owner+"</font>";
									task_type_c            	= "<font color='red'>"+task_type+"</font>";
									node_id_c              	= "<font color='red'>"+node_id+"</font>";
									priority_c             	= "<font color='red'>"+priority+"</font>";
									critical_c             	= "<font color='red'>"+critical+"</font>";
									cyclic_c               	= "<font color='red'>"+cyclic+"</font>";
									rerun_inerval_c        	= "<font color='red'>"+rerun_inerval+"</font>";
									rerun_max_c            	= "<font color='red'>"+rerun_max+"</font>";
									count_cyclic_from_c    	= "<font color='red'>"+count_cyclic_from+"</font>";
									command_c              	= "<font color='red'>"+command+"</font>";
									confirm_flag_c         	= "<font color='red'>"+confirm_flag+"</font>";
									max_wait_c             	= "<font color='red'>"+max_wait+"</font>";
									time_from_c            	= "<font color='red'>"+time_from+"</font>";
									time_until_c           	= "<font color='red'>"+time_until+"</font>";
									cond_in_c              	= "<font color='red'>"+cond_in+"</font>";
									cond_out_c             	= "<font color='red'>"+cond_out+"</font>";
									resource_c_c           	= "<font color='red'>"+resource_c+"</font>";
									resource_q_c           	= "<font color='red'>"+resource_q+"</font>";
									set_c                  	= "<font color='red'>"+set+"</font>";
									steps_c                	= "<font color='red'>"+steps+"</font>";
									postproc_c             	= "<font color='red'>"+postproc+"</font>";
									calendar_nm_c          	= "<font color='red'>"+calendar_nm+"</font>";
									month_days_c            = "<font color='red'>"+month_days+"</font>";
									days_cal_c              = "<font color='red'>"+days_cal+"</font>";
									conf_cal_c       		= "<font color='red'>"+conf_cal+"</font>";
									shift_c             	= "<font color='red'>"+shift+"</font>";
									shift_num_c             = "<font color='red'>"+shift_num+"</font>";
									month_1_c               = "<font color='red'>"+month_1+"</font>";
									month_2_c               = "<font color='red'>"+month_2+"</font>";
									month_3_c               = "<font color='red'>"+month_3+"</font>";
									month_4_c               = "<font color='red'>"+month_4+"</font>";
									month_5_c               = "<font color='red'>"+month_5+"</font>";
									month_6_c               = "<font color='red'>"+month_6+"</font>";
									month_7_c               = "<font color='red'>"+month_7+"</font>";
									month_8_c               = "<font color='red'>"+month_8+"</font>";
									month_9_c               = "<font color='red'>"+month_9+"</font>";
									month_10_c              = "<font color='red'>"+month_10+"</font>";
									month_11_c              = "<font color='red'>"+month_11+"</font>";
									month_12_c              = "<font color='red'>"+month_12+"</font>";
									schedule_and_or_c       = "<font color='red'>"+schedule_and_or+"</font>";
									week_days_c             = "<font color='red'>"+week_days+"</font>";
									weeks_cal_c             = "<font color='red'>"+weeks_cal+"</font>";
									t_general_date_c        = "<font color='red'>"+t_general_date_c+"</font>";
									active_day_c        	= "<font color='red'>"+active_day_c+"</font>";
									late_sub_c             	= "<font color='red'>"+late_sub+"</font>";
									late_time_c            	= "<font color='red'>"+late_time+"</font>";
									late_exec_c            	= "<font color='red'>"+late_exec+"</font>";
									error_desc_c           	= "<font color='red'>"+error_desc+"</font>";
									user2_c                	= "<font color='red'>"+user2+"</font>";
									user3_c                	= "<font color='red'>"+user3+"</font>";
									user4_c                	= "<font color='red'>"+user4+"</font>";
									user5_c                	= "<font color='red'>"+user5+"</font>";
									user6_c                	= "<font color='red'>"+user6+"</font>";
									user7_c                	= "<font color='red'>"+user7+"</font>";
									user8_c                	= "<font color='red'>"+user8+"</font>";
									user9_c                	= "<font color='red'>"+user9+"</font>";
									user10_c                = "<font color='red'>"+user10+"</font>";
									batchResult_c 		   	= "<font color='red'>"+batchResult+"</font>";
									r_msg_c 			   	= "<font color='red'>"+r_msg+"</font>";
									seq_c 			  	   	= "<font color='red'>"+seq_c+"</font>";
									state_cd_c 		       	= "<font color='red'>"+state_cd_c+"</font>";
									success_sms_yn_c 		= "<font color='red'>"+success_sms_yn_c+"</font>";

									user_id_2_c 			= "<font color='red'>"+user_id_2+"</font>";
									user_id_3_c 			= "<font color='red'>"+user_id_3+"</font>";
									user_id_4_c 			= "<font color='red'>"+user_id_4+"</font>";
									user_id_5_c 			= "<font color='red'>"+user_id_5+"</font>";
									user_id_6_c 			= "<font color='red'>"+user_id_6+"</font>";
									user_id_7_c 			= "<font color='red'>"+user_id_7+"</font>";
									user_id_8_c 			= "<font color='red'>"+user_id_8+"</font>";
									user_id_9_c 			= "<font color='red'>"+user_id_9+"</font>";
									user_id_10_c 			= "<font color='red'>"+user_id_10+"</font>";

									interval_sequence_c 	= "<font color='red'>"+interval_sequence+"</font>";
									specific_times_c 		= "<font color='red'>"+specific_times+"</font>";
									cyclic_type_c 			= "<font color='red'>"+cyclic_type+"</font>";
									ind_cyclic_c 			= "<font color='red'>"+ind_cyclic+"</font>";
									tolerance_c 			= "<font color='red'>"+tolerance+"</font>";

									sms_1_c 				= "<font color='red'>"+sms_1+"</font>";
									mail_1_c 				= "<font color='red'>"+mail_1+"</font>";
									sms_2_c 				= "<font color='red'>"+sms_2+"</font>";
									mail_2_c 				= "<font color='red'>"+mail_2+"</font>";
									sms_3_c 				= "<font color='red'>"+sms_3+"</font>";
									mail_3_c 				= "<font color='red'>"+mail_3+"</font>";
									sms_4_c 				= "<font color='red'>"+sms_4+"</font>";
									mail_4_c 				= "<font color='red'>"+mail_4+"</font>";
									sms_5_c 				= "<font color='red'>"+sms_5+"</font>";
									mail_5_c 				= "<font color='red'>"+mail_5+"</font>";
									sms_6_c 				= "<font color='red'>"+sms_6+"</font>";
									mail_6_c 				= "<font color='red'>"+mail_6+"</font>";
									sms_7_c 				= "<font color='red'>"+sms_7+"</font>";
									mail_7_c 				= "<font color='red'>"+mail_7+"</font>";
									sms_8_c 				= "<font color='red'>"+sms_8+"</font>";
									mail_8_c 				= "<font color='red'>"+mail_8+"</font>";
									sms_9_c 				= "<font color='red'>"+sms_9+"</font>";
									mail_9_c 				= "<font color='red'>"+mail_9+"</font>";
									sms_10_c 				= "<font color='red'>"+sms_10+"</font>";
									mail_10_c 				= "<font color='red'>"+mail_10+"</font>";

									grp_nm_1_c				= "<font color='red'>"+grp_nm_1+"</font>";
									grp_sms_1_c 			= "<font color='red'>"+grp_sms_1+"</font>";
									grp_mail_1_c 			= "<font color='red'>"+grp_mail_1+"</font>";
									grp_nm_2_c				= "<font color='red'>"+grp_nm_2+"</font>";
									grp_sms_2_c 			= "<font color='red'>"+grp_sms_2+"</font>";
									grp_mail_2_c 			= "<font color='red'>"+grp_mail_2+"</font>";

								}else{
									doc_cd_c               	= doc_cd;
									table_name_c			= table_name;
									application_c          	= application;
									group_name_c           	= group_name;
									job_name_c             	= job_name;
									desc_c                 	= desc;
									mem_name_c             	= mem_name;
									mem_lib_c              	= mem_lib;
									author_c               	= author;
									owner_c                	= owner;
									task_type_c            	= task_type;
									node_id_c              	= node_id;
									priority_c             	= priority;
									critical_c             	= critical;
									cyclic_c               	= cyclic;
									rerun_inerval_c        	= rerun_inerval;
									rerun_max_c            	= rerun_max;
									count_cyclic_from_c    	= count_cyclic_from;
									command_c              	= command;
									confirm_flag_c         	= confirm_flag;
									max_wait_c             	= max_wait;
									time_from_c            	= time_from;
									time_until_c           	= time_until;
									cond_in_c              	= cond_in;
									cond_out_c             	= cond_out;
									resource_c_c           	= resource_c;
									resource_q_c           	= resource_q;
									set_c                  	= set;
									steps_c                	= steps;
									postproc_c             	= postproc;
									calendar_nm_c          	= calendar_nm;

									month_days_c            = month_days;
									days_cal_c              = days_cal;
									conf_cal_c 				= conf_cal;
									shift_c 				= shift;
									shift_num_c 			= shift_num;
									month_1_c               = month_1;
									month_2_c               = month_2;
									month_3_c               = month_3;
									month_4_c               = month_4;
									month_5_c               = month_5;
									month_6_c               = month_6;
									month_7_c               = month_7;
									month_8_c               = month_8;
									month_9_c               = month_9;
									month_10_c              = month_10;
									month_11_c              = month_11;
									month_12_c              = month_12;
									schedule_and_or_c       = schedule_and_or;
									week_days_c             = week_days;
									weeks_cal_c             = weeks_cal;
									t_general_date_c        = t_general_date;
									active_day_c        	= active_day;

									late_sub_c             	= late_sub;
									late_time_c            	= late_time;
									late_exec_c            	= late_exec;
									error_desc_c           	= error_desc;
									user2_c                	= user2;
									user3_c                	= user3;
									user4_c                	= user4;
									user5_c                	= user5;
									user6_c                	= user6;
									user7_c                	= user7;
									user8_c                	= user8;
									user9_c                	= user9;
									user10_c                = user10;
									batchResult_c 		   	= batchResult;
									r_msg_c 			   	= r_msg;
									seq_c				   	= seq;
									state_cd_c			   	= state_cd;
									success_sms_yn_c		= success_sms_yn;

									user_id_2_c				= user_id_2;
									user_id_3_c				= user_id_3;
									user_id_4_c				= user_id_4;
									user_id_5_c				= user_id_5;
									user_id_6_c				= user_id_6;
									user_id_7_c				= user_id_7;
									user_id_8_c				= user_id_8;
									user_id_9_c				= user_id_9;
									user_id_10_c			= user_id_10;

									interval_sequence_c		= interval_sequence;
									specific_times_c		= specific_times;
									cyclic_type_c			= cyclic_type;
									ind_cyclic_c			= ind_cyclic;
									tolerance_c				= tolerance;

									sms_1_c					= sms_1;
									mail_1_c				= mail_1;
									sms_2_c					= sms_2;
									mail_2_c				= mail_2;
									sms_3_c					= sms_3;
									mail_3_c				= mail_3;
									sms_4_c					= sms_4;
									mail_4_c				= mail_4;
									sms_5_c					= sms_5;
									mail_5_c				= mail_5;
									sms_6_c					= sms_6;
									mail_6_c				= mail_6;
									sms_7_c					= sms_7;
									mail_7_c				= mail_7;
									sms_8_c					= sms_8;
									mail_8_c				= mail_8;
									sms_9_c					= sms_9;
									mail_9_c				= mail_9;
									sms_10_c				= sms_10;
									mail_10_c				= mail_10;

									grp_nm_1_c				= grp_nm_1;
									grp_sms_1_c 			= grp_sms_1;
									grp_mail_1_c 			= grp_mail_1;
									grp_nm_2_c				= grp_nm_2;
									grp_sms_2_c 			= grp_sms_2;
									grp_mail_2_c 			= grp_mail_2;

								}
								rowsObj.push({
									'grid_idx':i+1
									,'DOC_CD': doc_cd_c
									,'TABLE_NAME': table_name_c
									,'APPLICATION': application_c
									,'GROUP_NAME': group_name_c
									,'JOB_NAME': job_name_c
									,'DESCRIPTION': desc_c
									,'MEM_NAME': mem_name_c
									,'MEM_LIB': mem_lib_c
									,'AUTHOR': author_c
									,'OWNER': owner_c
									,'TASK_TYPE': task_type_c
									,'NODE_ID': node_id_c
									,'PRIORITY': priority_c
									,'CRITICAL': critical_c
									,'CYCLIC': cyclic_c
									,'RERUN_INTERVAL': rerun_inerval_c
									,'RERUN_MAX': rerun_max_c
									,'COUNT_CYCLIC_FROM': count_cyclic_from_c
									,'COMMAND': command_c
									,'CONFIRM_FLAG': confirm_flag_c
									,'MAX_WAIT': max_wait_c
									,'TIME_FROM': time_from_c
									,'TIME_UNTIL': time_until_c
									,'T_CONDITIONS_IN': cond_in_c
									,'T_CONDITIONS_OUT': cond_out_c
									,'T_RESOURCES_C': resource_c_c
									,'T_RESOURCES_Q': resource_q_c
									,'T_SET': set_c
									,'T_STEPS': steps_c
									,'T_POSTPROC': postproc_c
									,'CALENDAR_NM': calendar_nm_c
									,'MONTH_DAYS': month_days_c
									,'DAYS_CAL': days_cal_c
									,'CONF_CAL':conf_cal_c
									,'SHIFT':shift_c
									,'SHIFT_NUM':shift_num_c
									,'MONTH_1': month_1_c
									,'MONTH_2': month_2_c
									,'MONTH_3': month_3_c
									,'MONTH_4': month_4_c
									,'MONTH_5': month_5_c
									,'MONTH_6': month_6_c
									,'MONTH_7': month_7_c
									,'MONTH_8': month_8_c
									,'MONTH_9': month_9_c
									,'MONTH_10': month_10_c
									,'MONTH_11': month_11_c
									,'MONTH_12': month_12_c
									,'SCHEDULE_AND_OR': schedule_and_or_c
									,'WEEK_DAYS': week_days_c
									,'WEEKS_CAL': weeks_cal_c
									,'T_GENERAL_DATE': t_general_date_c
									,'ACTIVE_DAY': active_day
									,'LATE_SUB': late_sub_c
									,'LATE_TIME': late_time_c
									,'LATE_EXEC': late_exec_c
									,'USER_CD_2': user2_c
									,'USER_CD_3': user3_c
									,'USER_CD_4': user4_c
									,'USER_CD_5': user5_c
									,'USER_CD_6': user6_c
									,'USER_CD_7': user7_c
									,'USER_CD_8': user8_c
									,'USER_CD_9': user9_c
									,'USER_CD_10': user10_c
									,'BATCHRESULT': batchResult_c
									,'R_MSG':  r_msg_c
									,'SEQ':  seq
									,'STATE_CD':  state_cd

									,'SUCCESS_SMS_YN': success_sms_yn_c

									,'USER_ID_2': user_id_2_c
									,'USER_ID_3': user_id_3_c
									,'USER_ID_4': user_id_4_c
									,'USER_ID_5': user_id_5_c
									,'USER_ID_6': user_id_6_c
									,'USER_ID_7': user_id_7_c
									,'USER_ID_8': user_id_8_c
									,'USER_ID_9': user_id_9_c
									,'USER_ID_10': user_id_10_c

									,'INTERVAL_SEQUENCE': interval_sequence_c
									,'SPECIFIC_TIMES': specific_times_c
									,'CYCLIC_TYPE': cyclic_type_c
									,'IND_CYCLIC': ind_cyclic_c
									,'TOLERANCE': tolerance_c

									,'SMS_1': sms_1_c
									,'MAIL_1': mail_1_c
									,'SMS_2': sms_2_c
									,'MAIL_2': mail_2_c
									,'SMS_3': sms_3_c
									,'MAIL_3': mail_3_c
									,'SMS_4': sms_4_c
									,'MAIL_4': mail_4_c
									,'SMS_5': sms_5_c
									,'MAIL_5': mail_5_c
									,'SMS_6': sms_6_c
									,'MAIL_6': mail_6_c
									,'SMS_7': sms_7_c
									,'MAIL_7': mail_7_c
									,'SMS_8': sms_8_c
									,'MAIL_8': mail_8_c
									,'SMS_9': sms_9_c
									,'MAIL_9': mail_9_c
									,'SMS_10': sms_10_c
									,'MAIL_10': mail_10_c

									,'GRP_NM_1': grp_nm_1_c
									,'GRP_NM_2': grp_nm_2_c
									,'GRP_SMS_1': grp_sms_1_c
									,'GRP_SMS_2': grp_sms_2_c
									,'GRP_MAIL_1': grp_mail_1_c
									,'GRP_MAIL_2': grp_mail_2_c
								});
							});
						}

						gridObj_4.rows = rowsObj;
						setGridRows(gridObj_4);	
						
						//컬럼 자동 조정 기능
						$('body').resizeAllColumns();
						$('#ly_total_cnt').html('[ TOTAL : '+items.attr('cnt')+' ]');
						
					});
					try{viewProgBar(false);}catch(e){}
				}
		, null );
		
		xhr.sendRequest();
	}
	
	function UpdateFlag() {
		
		var cnt 		= 0;		
		var doc_cd 		= "";
		var seq 		= "";
		var	batchResult = "";
		
		var aSelRow = new Array;
		
		aSelRow = $('#'+gridObj_4.id).data('grid').getSelectedRows();
		
		if(aSelRow.length>0){
			for(var i=0;i<aSelRow.length;i++){
				
				batchResult = getCellValue(gridObj_4,aSelRow[i],'BATCHRESULT');
				
				if(batchResult != "작업에러"){					
					++cnt					
				}else{	
								
					if(i>0) doc_cd += "|";
					doc_cd += getCellValue(gridObj_4,aSelRow[i],'DOC_CD');	
					
					if(i>0) seq += "|";
					seq += getCellValue(gridObj_4,aSelRow[i],'SEQ');					
				}
			}
			
			if(cnt > 0){
				if( !confirm("에러난 작업만 재반영 합니다.\n처리하시겠습니까?") ) return;
			}
			
		}else{
			alert("재반영 하려는 내용을 선택해 주세요.");
			return;
		}
		
		if ( doc_cd != "" && doc_cd.substring(0, 1) == "|" ) {
			doc_cd = doc_cd.substring(1, doc_cd.length);
		}
		if ( seq != "" && seq.substring(0, 1) == "|" ) {
			seq = seq.substring(1, seq.length);
		}
		
		//반영 대기로 뺀뒤에 쿼츠로 반영시 필요한 함수
		//goPrc5(doc_cd, seq);
		
		var frm = document.f_a;
		
		frm.doc_cds.value 		= doc_cd;
		frm.doc_gbs.value 		= "06";
		frm.main_doc_cd.value 	= '<%=strDoc_cd %>';
		
		if(doc_cd == ""){
			alert("재반영 하려는 작업이 없습니다.");
			return;
		}
		
		if( !confirm("재반영을 요청 하시겠습니까?") ) return;

		try{viewProgBar(true);}catch(e){}

		frm.target = "if1";
		frm.action = "<%=sContextPath%>/tWorks.ez?c=ez006_attempt";
		frm.submit();	
	}	
	
	function UpdateFlag2(){
		
		var cnt 		= 0;		
		var doc_cd 		= "";
		var seq 		= "";
		var	batchResult = "";
		var	state_cd 	= "";
			
		batchResult = getCellValue(gridObj_4,0,'BATCHRESULT');
		state_cd 	= getCellValue(gridObj_4,0,'STATE_CD');
		
		if(!(batchResult == "반영대기" && state_cd == "02")){
			++cnt
		}else{	
			doc_cd = getCellValue(gridObj_4,0,'DOC_CD');	
		}
		
		if(cnt > 0){
			alert("완결된 작업중 반영대기인 작업만 반영취소 가능 합니다.");
			return;
		}
		
		goPrc2(doc_cd,seq);
	}
	
	function goPrc(flag, grp_approval_userList, grp_alarm_userList, title) {

		var frm = document.frm1;
		var post_approval_yn = "N";
		
		if(flag == 'post_draft'){
			post_approval_yn	= "Y";
		}

		$("#frm1").find("input[name='p_apply_date']").val($("#apply_date").val());

		frm.doc_gb.value 				= "06";
		frm.flag.value 					= flag;
		frm.post_approval_yn.value 		= post_approval_yn;
		frm.grp_approval_userList.value = grp_approval_userList;
		frm.grp_alarm_userList.value 	= grp_alarm_userList;
		frm.title.value 				= title;

		if( !confirm("처리 하시겠습니까?") ) return;

		try{viewProgBar(true);}catch(e){}
		
		frm.target = "if1";
		frm.action = "<%=sContextPath%>/tWorks.ez?c=ez004_p";
		frm.submit();

	}
	
	function goPrc5(doc_cd,seq){
		
		var frm = document.frm1;
		
		frm.doc_cd.value = doc_cd;
		frm.doc_seq.value = seq;
		
		if(doc_cd == "" && seq == ""){
			alert("재반영 하려는 작업이 없습니다.");
			return;
		}
		
		if( !confirm("재반영을 요청 하시겠습니까?") ) return;

		try{viewProgBar(true);}catch(e){}

		// 직전 진행했던 파라미터가 넘어가는 걸 방지하기 위해 초기화 (2023.05.25 강명준)
		frm.flag.value 	= "";

		frm.target = "if1";
		frm.action = "<%=sContextPath%>/tWorks.ez?c=ez_ReRunDoc";
		frm.submit();	
		
		$("#btn_admin_approval").hide();	
		
	}
	
	function goPrc2(doc_cd,seq){
		
		var frm = document.frm1;
		
		frm.doc_cd.value = doc_cd;
		frm.flag.value = "def_cancel";
	
		if( !confirm("반영취소 요청을 하시겠습니까?") ) return;

		try{viewProgBar(true);}catch(e){}

		frm.target = "if1";
		frm.action = "<%=sContextPath%>/tWorks.ez?c=ez006_state_update";
		frm.submit();
	}
	
	function goPrc3(approval_cd, approval_seq, appproval_nm) {
		
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
	
	function goPrc4(flag) {
		
		var frm = document.frm1;
		
		frm.flag.value = flag;
	
		if( !confirm("처리 하시겠습니까?") ) return;

		try{viewProgBar(true);}catch(e){}

		// 직전 진행했던 파라미터가 넘어가는 걸 방지하기 위해 초기화 (2023.05.25 강명준)
		frm.approval_cd.value 	= "";

		frm.target = "if1";
		frm.action = "<%=sContextPath%>/tWorks.ez?c=ez004_p";
		frm.submit();
	}
	
	function goCancel() {
		
		var frm = document.frm1;
		
		if( !confirm("[승인취소] 하시겠습니까?") ) return;
		
		// 직전 진행했던 파라미터가 넘어가는 걸 방지하기 위해 초기화 (2023.05.25 강명준)
		frm.approval_cd.value 	= "";

		try{viewProgBar(true);}catch(e){}

		frm.flag.value 	= "def_cancel";
		frm.target 		= "if1";
		frm.action 		= "<%=sContextPath%>/tWorks.ez?c=ez006_p";
		
		frm.submit();
	}
	
	function doc06DetailExcelList(){
		
		var frm = document.frm1;
		
		try{viewProgBar(true);}catch(e){}
		
		frm.action = "<%=sContextPath %>/tWorks.ez?c=ez006_excel";
		frm.target = "if1";
		frm.submit();
		
		try{viewProgBar(false);}catch(e){}
	}
	
</script>
<%@include file="/jsp/common/inc/progBar.jsp"  %>
<iframe name="if1" id="if1" width="0" height="0"></iframe>
</body>
</html>