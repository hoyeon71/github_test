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
<script type="text/javascript" src="<%=request.getContextPath() %>/js/poshytip-1.2/jquery.poshytip.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/works_common.js?v=<%=jsVersion %>" ></script>

<script type="text/javascript">

</script>
</head>
<%
	Map<String, Object> paramMap = CommonUtil.collectParameters(request);

	String menu_gb 			= CommonUtil.getMessage("CATEGORY.GB.02.GB."+CommonUtil.isNull(paramMap.get("menu_gb")));
	String[] arr_menu_gb 	= menu_gb.split(",");
	
	String c 				= CommonUtil.isNull(paramMap.get("c"));
	String gridId 			= "g_"+c;
	
	// 상태 변경
	String doc_gb 			= "07";
	
	String s_gb 					= CommonUtil.isNull(paramMap.get("s_gb"));
	String s_text 					= CommonUtil.isNull(paramMap.get("s_text"));
	String s_state_cd 				= CommonUtil.isNull(paramMap.get("s_state_cd"));
	
	String state_cd 				= CommonUtil.isNull(paramMap.get("state_cd"));
	String approval_cd 				= CommonUtil.isNull(paramMap.get("approval_cd"));
	String doc_cd 					= CommonUtil.isNull(paramMap.get("doc_cd"));
	String rc 						= CommonUtil.isNull(paramMap.get("rc"));
	
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
	String search_s_search_date2	= CommonUtil.isNull(paramMap.get("search_s_search_date2"));
	String search_e_search_date2 	= CommonUtil.isNull(paramMap.get("search_e_search_date2"));
	String search_task_nm 			= CommonUtil.isNull(paramMap.get("search_task_nm"));
	String search_critical			= CommonUtil.isNull(paramMap.get("search_critical"));
	String search_approval_state 	= CommonUtil.isNull(paramMap.get("search_approval_state"));
	String search_check_approval_yn	= CommonUtil.isNull(paramMap.get("search_check_approval_yn"));
	String tabId					= CommonUtil.isNull(paramMap.get("tabId"));
	String doc_cnt 					= CommonUtil.isNull(paramMap.get("doc_cnt"), "0");

	String search_param 				= "&search_data_center="+search_data_center+"&search_approval_cd="+search_approval_cd+"&search_state_cd="+search_state_cd+"&search_apply_cd="+search_apply_cd;
	search_param 						+=	"&search_gb="+search_gb+"&search_text="+search_text+"&search_date_gubun="+search_date_gubun+"&search_approval_state="+search_approval_state;
	search_param 						+=	"&search_s_search_date="+search_s_search_date+"&search_e_search_date="+search_e_search_date+"&search_s_search_date2="+search_s_search_date2+"&search_e_search_date2="+search_e_search_date2;
	search_param 						+=	"&search_task_nm="+search_task_nm+"&search_critical="+search_critical+"&tabId="+tabId+"&search_check_approval_yn="+search_check_approval_yn;

	List approvalInfoList			= (List)request.getAttribute("approvalInfoList");
	Doc07Bean docBean				= (Doc07Bean)request.getAttribute("doc07");
	
	String cur_approval_seq		= CommonUtil.isNull(request.getAttribute("cur_approval_seq"));
	String cur_approval_gb		= CommonUtil.isNull(request.getAttribute("cur_approval_gb"));
	String strDutyNm				= "";
	String strDeptNm				= "";
	String strUserNm				= "";
	String strDocCd					= "";
	String strTitle					= "";
	String strContent				= "";	
	String strOrderId				= "";
	String strOdate					= "";
	String strDataCenter			= "";	
	String strTableName				= "";
	String strApplication			= "";
	String strGroupName				= "";
	String strJobName				= "";
	String strBeforeStatus			= "";
	String strAfterStatus			= "";
	
	String strInsUserNm				= "";
	String strInsDutyNm				= "";
	String strInsDeptNm				= "";
	
	String strDescription			= "";
	String post_approval_yn			= "";
	
	String strApplyCd				= "";
	String strUserInfo 				= "";
	String strPostUserInfo 			= "";

	String menu_gb_c = "";
	String menu_nm = "";

	if ( docBean != null ) {
		
		strDutyNm 			= CommonUtil.isNull(CommonUtil.E2K(docBean.getDuty_nm()), "");
		strDeptNm 			= CommonUtil.isNull(CommonUtil.E2K(docBean.getDept_nm()), "");
		strUserNm 			= CommonUtil.isNull(CommonUtil.E2K(docBean.getUser_nm()), "");
		strInsDutyNm 		= CommonUtil.isNull(CommonUtil.E2K(docBean.getIns_duty_nm()), "");
		strInsDeptNm 		= CommonUtil.isNull(CommonUtil.E2K(docBean.getIns_dept_nm()), "");
		strInsUserNm 		= CommonUtil.isNull(CommonUtil.E2K(docBean.getIns_user_nm()), "");
		strDocCd			= CommonUtil.isNull(CommonUtil.E2K(docBean.getDoc_cd()), "");
		strTitle			= CommonUtil.isNull(CommonUtil.E2K(docBean.getTitle()), "");
		strContent			= CommonUtil.isNull(CommonUtil.E2K(docBean.getContent()), "");		
		strOrderId			= CommonUtil.isNull(CommonUtil.E2K(docBean.getOrder_id()), "");
		strOdate			= CommonUtil.isNull(CommonUtil.E2K(docBean.getOdate()), "");		
		strDataCenter		= CommonUtil.isNull(CommonUtil.E2K(docBean.getData_center()), "");		
		strTableName		= CommonUtil.isNull(CommonUtil.E2K(docBean.getTable_name()), "");
		strApplication		= CommonUtil.isNull(CommonUtil.E2K(docBean.getApplication()), "");
		strGroupName		= CommonUtil.isNull(CommonUtil.E2K(docBean.getGroup_name()), "");		
		strJobName			= CommonUtil.isNull(CommonUtil.E2K(docBean.getJob_name()), "");
		strBeforeStatus		= CommonUtil.isNull(CommonUtil.E2K(docBean.getBefore_status()), "");
		strAfterStatus		= CommonUtil.isNull(CommonUtil.E2K(docBean.getAfter_status()), "");
		strDescription		= CommonUtil.isNull(CommonUtil.E2K(docBean.getDescription()), "");

		//후결유무
		post_approval_yn 	= CommonUtil.isNull(docBean.getPost_approval_yn());

	
	// 의뢰자 정보
	strUserInfo = "["+strDeptNm+"] ["+strDutyNm+"] "+strUserNm;
	
	// 후결 조치자 정보
	strPostUserInfo = "["+strInsDeptNm+"] ["+strInsDutyNm+"] "+strInsUserNm;	
		strApplyCd		= CommonUtil.isNull(docBean.getApply_cd());

	}else{
	
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

	// 세션값 가져오기.
	String strSessionUserId = S_USER_ID;
	String strSessionUserNm = S_USER_NM;

%>

<div style="width:100%; height:100%; overflow-x:hidden; overflow-y:scroll;">
<form id="f_s" name="f_s" method="post" onsubmit="return false;">
	<input type="hidden" 		name="data_center"				id="data_center" 				value="<%=strDataCenter %>" />
</form>
<form id="userFrm" name="userFrm" method="post" onsubmit="return false;">
	<input type="hidden" 		name="data_center" 				id="data_center" 				value="<%=strDataCenter %>"/>
	<input type="hidden" 		name="doc_gb" 					id="doc_gb" 					value="<%=doc_gb %>" />
	<input type="hidden" 		name="state_cd" 				id="state_cd" 					value="<%=state_cd %>" />
	<input type="hidden" 		name="job_name" 				id="job_name" 					value="<%=strJobName %>" />
	<!-- 목록 화면 검색 파라미터 -->
	<input type="hidden" 		name="search_data_center"		id="search_data_center" 		value="<%=search_data_center%>" />
	<input type="hidden" 		name="search_state_cd"			id="search_state_cd" 			value="<%=search_state_cd%>" />
	<input type="hidden" 		name="search_apply_cd"			id="search_apply_cd" 			value="<%=search_apply_cd%>" />
	<input type="hidden" 		name="search_approval_cd"		id="search_approval_cd" 		value="<%=search_approval_cd%>" />
	<input type="hidden" 		name="search_gb"				id="search_gb" 					value="<%=search_gb%>" />
	<input type="hidden" 		name="search_text"				id="search_text" 				value="<%=search_text%>" />
	<input type="hidden" 		name="search_date_gubun"		id="search_date_gubun" 			value="<%=search_date_gubun%>" />
	<input type="hidden" 		name="search_s_search_date"		id="search_s_search_date" 		value="<%=search_s_search_date%>" />
	<input type="hidden" 		name="search_e_search_date"		id="search_e_search_date" 		value="<%=search_e_search_date%>" />
	<input type="hidden" 		name="search_s_search_date2"	id="search_s_search_date2" 		value="<%=search_s_search_date2%>" />
	<input type="hidden" 		name="search_e_search_date2"	id="search_e_search_date2" 		value="<%=search_e_search_date2%>" />
	<input type="hidden" 		name="search_task_nm"			id="search_task_nm" 			value="<%=search_task_nm%>" />
	<input type="hidden" 		name="search_critical"			id="search_critical" 			value="<%=search_critical%>" />
	<input type="hidden" 		name="search_approval_state"	id="search_approval_state" 		value="<%=search_approval_state%>" />
	<input type="hidden" 		name="search_check_approval_yn"	id="search_check_approval_yn" 	value="<%=search_check_approval_yn%>" />
	<input type="hidden" 		name="tabId"					id="tabId"						value="<%=tabId%>" />
</form>
<form id="frm1" name="frm1" method="post" onsubmit="return false;" enctype="multipart/form-data" >
	<input type="hidden" 		name="file_nm" 					id="file_nm"					/>
	<input type="hidden" 		name="doc_cd" 					id="doc_cd" 					value="<%=doc_cd %>" />
	<input type="hidden" 		name="doc_gb" 					id="doc_gb" 					value="<%=doc_gb %>" />
	<input type="hidden" 		name="data_center"				id="data_center" 	 			value="<%=strDataCenter %>" />
	<input type="hidden" 		name="job_name"					id="job_name" 					value="<%=strJobName%>" />
	<input type="hidden" 		name="sched_table"				id="sched_table"	 			/>
	<input type="hidden" 		name="flag" 					id="flag"						/>
	<input type="hidden" 		name="user_cd" 					id="user_cd"		 			/>
	<input type="hidden" 		name="days_cal"					id="days_cal"					/>

	<input type="hidden" 		name="approval_cd" 				id="approval_cd"				/>
	<input type="hidden" 		name="approval_seq" 			id="approval_seq"				/>
	<input type="hidden" 		name="approval_comment"			id="approval_comment"	 		/>

	<input type="hidden" 		name="post_approval_yn"			id="post_approval_yn" 	 		value="<%=post_approval_yn %>" />
	<input type="hidden" 		name="doc_cnt"					id="doc_cnt"					value="<%=doc_cnt%>" />

	<!-- 목록 화면 검색 파라미터 -->
	<input type="hidden" 		name="search_data_center"		id="search_data_center" 		value="<%=search_data_center%>" />
	<input type="hidden" 		name="search_state_cd"			id="search_state_cd" 			value="<%=search_state_cd%>" />
	<input type="hidden" 		name="search_apply_cd"			id="search_apply_cd" 			value="<%=search_apply_cd%>" />
	<input type="hidden" 		name="search_approval_cd"		id="search_approval_cd" 		value="<%=search_approval_cd%>" />
	<input type="hidden" 		name="search_gb"				id="search_gb" 					value="<%=search_gb%>" />
	<input type="hidden" 		name="search_text"				id="search_text" 				value="<%=search_text%>" />
	<input type="hidden" 		name="search_date_gubun"		id="search_date_gubun" 			value="<%=search_date_gubun%>" />
	<input type="hidden" 		name="search_s_search_date"		id="search_s_search_date" 		value="<%=search_s_search_date%>" />
	<input type="hidden" 		name="search_e_search_date"		id="search_e_search_date" 		value="<%=search_e_search_date%>" />
	<input type="hidden" 		name="search_s_search_date2"	id="search_s_search_date2" 		value="<%=search_s_search_date2%>" />
	<input type="hidden" 		name="search_e_search_date2"	id="search_e_search_date2" 		value="<%=search_e_search_date2%>" />
	<input type="hidden" 		name="search_task_nm"			id="search_task_nm" 			value="<%=search_task_nm%>" />
	<input type="hidden" 		name="search_critical"			id="search_critical" 			value="<%=search_critical%>" />
	<input type="hidden" 		name="search_approval_state"	id="search_approval_state" 		value="<%=search_approval_state%>" />
	<input type="hidden" 		name="search_check_approval_yn"	id="search_check_approval_yn" 	value="<%=search_check_approval_yn%>" />
	<input type="hidden" 		name="tabId"					id="tabId"						value="<%=tabId%>" />


	<input type="hidden" 			name="check_doc_cd" />
	<input type="hidden" 			name="check_data_center" />
	<input type="hidden" 			name="doc_cds" 				id="doc_cds" 					/>
	<input type="hidden" 			name="doc_gbs"				id="doc_gbs"					/>

	<table style='width:100%;height:99%;border:none;'>
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
							<div class='cellTitle_kang5'>결재 정보</div>
						</td>
					</tr>
					<tr>
						<td valign="top">
							<table style="width:100%;">
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
									String strGroupLineGrpCd	= CommonUtil.isNull(bean.getGroup_line_grp_nm());
									
									String strLineGb			= CommonUtil.isNull(bean.getLine_gb());
									String userInfo				= "";
									String strAbsenceInfo		= "";
									
									// 결재 시 대결자 정보가 있으면 대결자 셋팅
									if( strUdtUserCd.equals("") && !strAbsenceUserCd.equals("0") && strGroupLineGrpNm.equals("") ) {
										strAbsenceInfo = "["+CommonUtil.E2K(bean.getDept_nm())+"]["+CommonUtil.E2K(bean.getDuty_nm())+"]"+CommonUtil.E2K(bean.getUser_nm()) + " (대결자:" + strAbsenceUserNm + ")";
									}
									
									// 결재사용자코드와 업데이트한 사용자코드가 다르면 대결로 간주
									if ( !strUserCd.equals(strUdtUserCd) && !strUdtUserCd.equals("") && strGroupLineGrpNm.equals("") ) {
// 										strAbsenceInfo = "["+strAbsenceDeptNm+"]["+strAbsenceDutyNm+"]<br>"+strAbsenceUserNm +"(대결)";
										strAbsenceInfo = "["+strUdtDeptNm+"]["+strUdtDutyNm+"]"+strUdtUserNm +"(대결)";
									}
									
// 									userInfo = "["+CommonUtil.E2K(bean.getDept_nm())+"]["+CommonUtil.E2K(bean.getDuty_nm())+"]<br>"+CommonUtil.E2K(bean.getUser_nm());
									userInfo = "["+CommonUtil.E2K(bean.getDept_nm())+"]["+CommonUtil.E2K(bean.getDuty_nm())+"]"+CommonUtil.E2K(bean.getUser_nm());
									if ( !strGroupLineGrpNm.equals("") ) {
										userInfo = "[그룹]" + strGroupLineGrpNm;
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
							<div class='cellTitle_kang5'>요청 정보 [문서정보 : <%=doc_cd %>]</div>
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
<%-- 										<a href="JavaScript:docUserInfo('<%=doc_cd %>');" style="text-decoration:underline;"><font color="black"><%=strUserInfo %></font></a> --%>
										<a href="JavaScript:docUserInfo('<%=doc_cd %>');" style="text-decoration:underline;cursor:pointer;"><b><%=strUserInfo %></b></a>
									</div>
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
									<div class='cellTitle_ez_right'>폴더</div>
								</td>									
								<td>
									<div class='cellContent_kang'><%=strTableName%></div>
								</td>
								<td>
									<div class='cellTitle_ez_right'>어플리케이션</div>
								</td>
								<td>
									<div class='cellContent_kang'><%=strApplication%></div>
								</td>
								<td>
									<div class='cellTitle_ez_right'>그룹</div>
								</td>
								<td>
									<div class='cellContent_kang'><%=strGroupName%></div>
								</td>
							</tr>
						
							<tr>
								<td>
									<div class='cellTitle_ez_right'>ODATE</div>
								</td>
								<td>
									<div class='cellContent_kang'><%=strOdate%></div>
								</td>
								<td>
									<div class='cellTitle_ez_right'>작업명</div>
								</td>
								<td>
									<div class='cellContent_kang'><%=strJobName%></div>
								</td>
								<td>
									<div class='cellTitle_ez_right'>이전 상태</div>
								</td>
								<td>
									<div class='cellContent_kang'><%=strBeforeStatus%></div>
								</td>
							</tr>
							<tr>
								<td>
									<div class='cellTitle_ez_right'>변경 상태</div>
								</td>
								<td>
									<div class='cellContent_kang'><%=strAfterStatus%></div>
								</td>
							</tr>
							<tr>
								<td >
									<div class='cellTitle_ez_right'>작업 설명</div>
								</td>
								<td colspan='4'>
									<div class='cellContent_kang' style='height:auto;'><%=strDescription%></div>
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
					String strStateCd2			= "";
				
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
							if ( !post_approval_yn.equals("Y") && !strApplyCd.equals("02")) {
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
						
				%>
					<!-- <span id='btn_list'>목록</span> -->
					<span id='btn_del' style="display:none;">삭제</span>
					
					<%
					// 1차결재자 미결이면 기안자 승인취소 가능
					if ( strCurApprovalSeq.equals("1") && strStateCd2.equals("01") && S_USER_CD.equals(strInsUserCd) ) {
					%>
						<% //작업이 반영완료일 경우 승인취소 불가
							if( !strApplyCd.equals("02") ) {
						%>
								<span id='btn_cancel'>승인취소</span>
					<%
							}
					}
					%>
					
					<%if (CommonUtil.E2K(docBean.getApply_cd()).equals("04") || CommonUtil.E2K(docBean.getApply_cd()).equals("05") ) {%>
						<span id="btn_admin_approval">재반영</span>
					<%}%>
					
					<span id='btn_close'>닫기</span>
				
				</div>
			</h4>
		</td>
	</tr>
</table>

<iframe name="if2" id="if2" style="width:99%;height:300px;" scrolling="no" frameborder="0"></iframe>	

</form>
	



<script>
	
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
		
		// 직전 진행했던 파라미터가 넘어가는 걸 방지하기 위해 초기화 (2023.05.25 강명준)
		frm.approval_cd.value 	= "";

		try{viewProgBar(true);}catch(e){}

		frm.flag.value 	= "def_cancel";
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
</body>
</div>
</html>