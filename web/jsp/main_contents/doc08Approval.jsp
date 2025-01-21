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
	String doc_gb 			= "08";
	
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
	String search_moneybatchjob		= CommonUtil.isNull(paramMap.get("search_moneybatchjob"));
	String search_critical			= CommonUtil.isNull(paramMap.get("search_critical"));
	String search_approval_state 	= CommonUtil.isNull(paramMap.get("search_approval_state"));
	String search_check_approval_yn	= CommonUtil.isNull(paramMap.get("search_check_approval_yn"));

	String tabId					= CommonUtil.isNull(paramMap.get("tabId"));

	List approvalInfoList			= (List)request.getAttribute("approvalInfoList");
	Doc08Bean docBean				= (Doc08Bean)request.getAttribute("doc08");
	
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
	String strFrom_time				= "";
	String strAfterStatus			= "";
	
	String strInsUserNm				= "";
	String strInsDutyNm				= "";
	String strInsDeptNm				= "";
	
	String strDescription			= "";
	String strFailComment			= "";
	String strApplyCd				= "";
	String strApplyDate				= "";
	String strApplyNm				= "";
	
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
// 		strOrderId			= CommonUtil.isNull(CommonUtil.E2K(docBean.getOrder_id()), "");
		strOdate			= CommonUtil.isNull(CommonUtil.E2K(docBean.getOrder_date()), "");		
		strDataCenter		= CommonUtil.isNull(CommonUtil.E2K(docBean.getData_center()), "");		
		strTableName		= CommonUtil.isNull(CommonUtil.E2K(docBean.getTable_name()), "");
		strApplication		= CommonUtil.isNull(CommonUtil.E2K(docBean.getApplication()), "");
		strGroupName		= CommonUtil.isNull(CommonUtil.E2K(docBean.getGroup_name()), "");		
		strJobName			= CommonUtil.isNull(CommonUtil.E2K(docBean.getJob_name()), "");
		strFrom_time		= CommonUtil.isNull(CommonUtil.E2K(docBean.getFrom_time()), "");
		strFrom_time		= strFrom_time.substring(0, 2) + ":" + strFrom_time.substring(2);
		strAfterStatus		= CommonUtil.isNull(CommonUtil.E2K(docBean.getAfter_status()), "");
		strDescription		= CommonUtil.isNull(CommonUtil.E2K(docBean.getDescription()), "");
		strFailComment		= CommonUtil.isNull(CommonUtil.E2K(docBean.getFail_comment()), "");
		strApplyCd			= CommonUtil.isNull(CommonUtil.E2K(docBean.getApply_cd()), "");
		strApplyDate		= CommonUtil.isNull(CommonUtil.E2K(docBean.getApply_date()), "");
		strApplyNm			= CommonUtil.getMessage("APPLY.STATE."+strApplyCd);
	}
	
	// 세션값 가져오기.
	String strSessionUserId = S_USER_ID;
	String strSessionUserNm = S_USER_NM;
	
	String strServerGb 		= CommonUtil.isNull(CommonUtil.getMessage("SERVER_GB"));
	
	String strUserInfo 		= "";
	String strPostUserInfo 	= "";
	
	// 의뢰자 정보
	strUserInfo = "["+strDeptNm+"] ["+strDutyNm+"] "+strUserNm;
	
	// 후결 조치자 정보
	strPostUserInfo = "["+strInsDeptNm+"] ["+strInsDutyNm+"] "+strInsUserNm;	
%>	

<div style="width:100%; height:100%; overflow-x:hidden; overflow-y:scroll;">
<form id="f_s" name="f_s" method="post" onsubmit="return false;">
	<input type="hidden" id="data_center" 		name="data_center" 		value="<%=strDataCenter %>" />
</form>
<form id="userFrm" name="userFrm" method="post" onsubmit="return false;">
</form>
<form id="frm1" name="frm1" method="post" onsubmit="return false;" enctype="multipart/form-data" >

<input type="hidden" id="file_nm"		name="file_nm" />	
<input type="hidden" id="doc_cd" 		name="doc_cd" 		value="<%=doc_cd %>" />
<input type="hidden" id="doc_gb" 		name="doc_gb" 		value="<%=doc_gb %>" />
<input type="hidden" id="data_center" 	name="data_center" 	value="<%=strDataCenter %>" />
<input type="hidden" id="job_name" 		name="job_name" />	
<input type="hidden" id="sched_table"	name="sched_table" />
<input type="hidden" id="flag"			name="flag" />
<input type="hidden" id="user_cd"		name="user_cd" />
<input type="hidden" id="days_cal"		name="days_cal" />

<input type="hidden" id="approval_cd"		name="approval_cd" />
<input type="hidden" id="approval_seq"		name="approval_seq" />
<input type="hidden" id="approval_comment"	name="approval_comment" />

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
							<div class='cellTitle_kang'>결재 정보</div>
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

									String strApprovalCdMent 	= CommonUtil.getMessage("DOC.APPROVAL."+strApprovalCd);
									
									String strApprovalCdMent2	= "";
									if ( !strApprovalCd.equals("00") && !strApprovalCd.equals("01") ) {
										strApprovalCdMent2 = strGroupApprovalUser + ":" + strApprovalDate;
									}									
							%>
									<td width="200"> 
										<div class='cellTitle_kang2' style='min-width:30%; min-height:30px;' >
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
							<div class='cellTitle_kang'>요청 정보</div>
						</td>
					</tr>
					<tr>
						<td valign="top">
							<table style="width:100%;">
							<tr>
								<td width="120px"></td>								
								<td width=""></td>
							</tr>
							<%
								if ( strTitle.indexOf("[후결]") > -1 ) {
							%>
									<tr>
										<td>
											<div class='cellTitle_kang2'>후결 조치자</div>
										</td>									
										<td>
											<div class='cellContent_kang'>
												<font color="black"><%=strPostUserInfo %></font>
											</div>
										</td>
									</tr>
							<%
								}
							%>
							<tr>
								<td>
									<div class='cellTitle_kang2'>의 뢰 자</div>
								</td>									
								<td>
									<div class='cellContent_kang'>
										<a href="JavaScript:docUserInfo('<%=doc_cd %>');" style="text-decoration:underline;"><font color="black"><%=strUserInfo %></font></a>
									</div>
								</td>
							</tr>
							<tr>
								<td style="vertical-align:top;">
									<div class='cellTitle_kang2'>의뢰 사유</div>
								</td>
								<td colspan="5" style="vertical-align:top;">
									<div class='cellContent_kang' style='height:auto;'><%= CommonUtil.E2K(docBean.getTitle()) %></div>
								</td>
							</tr>
							</table>
						</td>
					</tr>
					
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
								<td width="180px"></td>
								<td width="120px"></td>
								<td width="180px"></td>
								<td width="120px"></td>
								<td width="180px"></td>
							</tr>		
							<tr>
								<td>
									<div class='cellTitle_kang2'>폴더</div>
								</td>									
								<td>
									<div class='cellContent_kang'><%=strTableName%></div>
								</td>
								<td>
									<div class='cellTitle_kang2'>어플리케이션</div>
								</td>
								<td>
									<div class='cellContent_kang'><%=strApplication%></div>
								</td>
								<td>
									<div class='cellTitle_kang2'>그룹</div>
								</td>
								<td>
									<div class='cellContent_kang'><%=strGroupName%></div>
								</td>
							</tr>
						
							<tr>
								<td>
									<div class='cellTitle_kang2'>ODATE</div>
								</td>
								<td>
									<div class='cellContent_kang'><%=strOdate%></div>
								</td>
								<td>
									<div class='cellTitle_kang2'>작업명</div>
								</td>
								<td>
									<div class='cellContent_kang'><%=strJobName%></div>
								</td>
								<td>
									<div class='cellTitle_kang2'>예약 시간</div>
								</td>
								<td>
									<div class='cellContent_kang'><%=strFrom_time%></div>
								</td>
							</tr>
							<tr>
								<td>
									<div class='cellTitle_kang2'>변경 상태</div>
								</td>
								<td>
									<div class='cellContent_kang'><%=strAfterStatus%></div>
								</td>
								<td>
									<div class='cellTitle_kang2'>반영 상태</div>
								</td>
								<td>
									<div class='cellContent_kang'><%=strApplyNm%></div>
								</td>
								<td>
									<div class='cellTitle_kang2'>반영일</div>
								</td>
								<td>
									<div class='cellContent_kang'><%=strApplyDate%></div>
								</td>
							</tr>
							<tr>
								<td>
									<div class='cellTitle_kang2'>작업 설명</div>
								</td>
								<td colspan="5">
									<div class='cellContent_kang' style='height:auto;'><%=strDescription%></div>
								</td>
							</tr>
							<%if(strApplyCd.equals("04")){ %>
								<tr>
									<td>
										<div class='cellTitle_kang2'>실패 사유</div>
									</td>
									<td>
										<div class='cellContent_kang' Style="height:100%;"><%=strFailComment%></div>
									</td>
								</tr>
							<%} %>
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
						
						<%	// 후결상태변경은 반려 처리 불가.
							if ( CommonUtil.E2K(docBean.getTitle()).indexOf("[후결]") < 0 ) {
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
						<span id='btn_cancel'>승인취소</span> 
					<%
					}
					%>
					
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
		goPrc2("del");
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

		try{viewProgBar(true);}catch(e){}

		frm.target = "if1";
		frm.action = "<%=sContextPath%>/tWorks.ez?c=ez006_p";
		frm.submit();
	}

	function goPrc2(flag) {

		var frm = document.frm1;

		var state_cd 			= '<%=state_cd%>';
		frm.flag.value 			= flag;

		if( !confirm("삭제하시겠습니까?") ) return;

		try{viewProgBar(true);}catch(e){}
		frm.target = "if1";
		frm.action = "<%=sContextPath%>/tWorks.ez?c=ez004_p";
		frm.submit();

	}
	
	function goCancel() { 
		
		var frm = document.frm1;
		
		if( !confirm("해당 문서는 삭제됩니다.\n[승인취소]하시겠습니까?") ) return;
		
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