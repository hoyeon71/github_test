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
	String flag				= CommonUtil.isNull(paramMap.get("flag"));

	String table_id 			= CommonUtil.isNull(paramMap.get("table_id"));
	String job_id 			= CommonUtil.isNull(paramMap.get("job_id"));
	String job_name 			= CommonUtil.isNull(paramMap.get("job_name"));
	String sched_table 			= CommonUtil.isNull(paramMap.get("sched_table"));

	if ( !max_doc_cd.equals("") ) {
		doc_cd = max_doc_cd;
	}

	String currentPage 		= CommonUtil.isNull(paramMap.get("currentPage"));

	List approvalInfoList	= (List)request.getAttribute("approvalInfoList");
	List sCodeList			= (List)request.getAttribute("sCodeList");
	List outCondList		= (List)request.getAttribute("outCondList");

	String strApplyDate		= (String) request.getAttribute("ODATE");

	JobMapperBean jobMapperBean	= (JobMapperBean)request.getAttribute("jobMapperInfo");

	Doc01Bean docBean				= (Doc01Bean)request.getAttribute("doc04");

	List sBatchGradeList			= (List)request.getAttribute("sBatchGradeList");

	List adminApprovalBtnList 	= (List)request.getAttribute("adminApprovalBtnList");

	// 참조기안시 작업명을 가지고 매퍼를 찾기 때문에 필요.
	String strJobName 		= CommonUtil.E2K(docBean.getJob_name());

	String[] aTmp 	= null;
	String[] aTmpT 	= null;

	String strDescription		= "";
	String strMcode_nm    	    	= "";
	String strScode_nm            	= "";

	String	strDataCenter		= "";
	String	strDataCenterName	= "";

	String strAdminApprovalBtn		= "";

	if ( adminApprovalBtnList != null ) {
		for ( int i = 0; i < adminApprovalBtnList.size(); i++ ) {
			CommonBean commonBean = (CommonBean) adminApprovalBtnList.get(i);
			strAdminApprovalBtn = CommonUtil.isNull(commonBean.getScode_nm());
		}
	}

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

	// 세션값 가져오기.
	String strSessionUserId = S_USER_ID;
	String strSessionUserNm = S_USER_NM;

	String strServerGb 		= CommonUtil.isNull(CommonUtil.getMessage("SERVER_GB"));

	String strCommand = CommonUtil.replaceHtmlStr(CommonUtil.isNull(docBean.getCommand()));

	// 의뢰자 정보
	String strInsUserNm = CommonUtil.isNull(docBean.getUser_nm());
	String strInsDeptNm = CommonUtil.isNull(docBean.getDept_nm());
	String strInsDutyNm = CommonUtil.isNull(docBean.getDuty_nm());

	String strUserInfo = "["+S_DEPT_NM+"] ["+S_DUTY_NM+"] "+S_USER_NM;
	if ( !strInsUserNm.equals("") ) {
		strUserInfo = "["+strInsDeptNm+"] ["+strInsDutyNm+"] "+strInsUserNm;
	}

	String tabId				= CommonUtil.isNull(paramMap.get("tabId"));
	if ( flag.equals("ref") ) {
		tabId 		= "99999";
	}

%>

<body id='body_A01' leftmargin="0" topmargin="0">

<div style="width:100%; height:100%; overflow-x:hidden; overflow-y:scroll;">
	<form id="f_s" name="f_s" method="post" onsubmit="return false;">
	</form>
	<form id="userFrm" name="userFrm" method="post" onsubmit="return false;">
	</form>
	<form id="frm1" name="frm1" method="post" onsubmit="return false;" enctype="multipart/form-data" >

		<input type="hidden" name="flag" 	id="flag"/>
		<input type="hidden" name="title" 	id="title"/>
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
		<input type="hidden" name="month_1" id="month_1"/>
		<input type="hidden" name="month_2" id="month_2"/>
		<input type="hidden" name="month_3" id="month_3"/>
		<input type="hidden" name="month_4" id="month_4"/>
		<input type="hidden" name="month_5" id="month_5"/>
		<input type="hidden" name="month_6" id="month_6"/>
		<input type="hidden" name="month_7" id="month_7"/>
		<input type="hidden" name="month_8" id="month_8"/>
		<input type="hidden" name="month_9" id="month_9"/>
		<input type="hidden" name="month_10" id="month_10"/>
		<input type="hidden" name="month_11" id="month_11"/>
		<input type="hidden" name="month_12" id="month_12"/>


		<input type='hidden' id='table_name' name='table_name'/>
		<input type='hidden' id='table_id' name='table_id'	value="<%=table_id %>" />
		<input type='hidden' id='job_id' name='job_id' value="<%=job_id %>" />
		<input type='hidden' id='sched_table' name='sched_table' value="<%=docBean.getTable_name() %>" />

		<input type='hidden' id='p_apply_date' name='p_apply_date'/>
		<input type='hidden' id='apply_cd' name='apply_cd'/>

		<input type="hidden" name="doc_gb" id="doc_gb" value="<%=doc_gb %>" />
		<input type="hidden" name="retro" id="retro"	value="0" />

		<!-- Cyclic 작업 셋팅 파라미터. -->
		<input type="hidden" name="rerun_interval" id="rerun_interval"/>
		<input type="hidden" name="rerun_interval_time" id="rerun_interval_time" value="M" />
		<input type="hidden" name="cyclic_type" id="cyclic_type"/>
		<input type="hidden" name="count_cyclic_from" id="count_cyclic_from"/>
		<input type="hidden" name="interval_sequence" id="interval_sequence"/>
		<input type="hidden" name="tolerance" id="tolerance"/>
		<input type="hidden" name="specific_times" id="specific_times"/>
		<input type="hidden" name="max_wait" id="max_wait"	value="7" />

		<input type="hidden" name="user_cd" id="user_cd"/>

		<input type="hidden" name="host_cd" id="host_cd" />
		<input type="hidden" name="doc_cd" id="doc_cd" />

		<input type="hidden" name="in_cond_name" id="in_cond_name" />
		<input type="hidden" name="deleted_yn" 	 id="deleted_yn" />

		<!-- 그룹결재구성원 결재권/알림권 설정 -->
		<input type="hidden" name="grp_approval_userList" 		id="grp_approval_userList"/>
		<input type="hidden" name="grp_alarm_userList" 			id="grp_alarm_userList"/>
		<input type="hidden" name="tabId"						id="tabId"					value="<%=tabId%>" />

		<table style='width:99%;height:99%;border:none;'>
			<tr style='height:10px;'>
				<td style='vertical-align:top;'>
					<h4 class="ui-widget-header ui-corner-all"  >
						<div id='t_<%=gridId %>' class='title_area'>
							<span><%=CommonUtil.isNull(CommonUtil.getMessage("CATEGORY.GB.02"))%> > <%=CommonUtil.getMessage("CATEGORY.GB.03.SB.0303") %></span>
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
												<div class='cellContent_kang'><%=strUserInfo%></div>
											</td>
											<td>
												<div class='cellTitle_ez_right' style='min-width:120px' ><font color="red">* </font>반영 예정일</div>
											</td>
											<td colspan="2">
												<input type="text" name="apply_date" id="apply_date" class="input datepick" value="<%=strApplyDate%>" style="width:75px; height:21px;" maxlength="8" autocomplete="off" />
											</td>
										</tr>
									</table>
								</td>
							</tr>
						</table>

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
													<%=CommonUtil.E2K(docBean.getTask_type()) %>
													<input type="hidden" name="task_type" id="task_type" value= "<%=CommonUtil.E2K(docBean.getTask_type()) %>"  style= "width:98%;height:21px;"/>
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
													<input type="hidden" name="talbe_name" id="talbe_name" value="<%=CommonUtil.isNull(docBean.getTable_name()) %>"/>
												</div>
											</td>
											<td>
												<div class='cellTitle_ez_right'>어플리케이션</div>
											</td>
											<td>
												<div class='cellContent_kang'>
													<%=CommonUtil.isNull(docBean.getApplication()) %>
													<input type="hidden" name="application" id="application" value="<%=CommonUtil.E2K(docBean.getApplication()) %>"  style= "width:70%;height:21px;"/>
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
													<input type=hidden name="owner" id="owner" value= "<%=CommonUtil.E2K(docBean.getOwner()) %>"/>
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
													<input type="hidden" id="job_name" name="job_name" value="<%=strJobName %>" />
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
										<!--
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
								 -->
										<tr>
											<td>
												<div class='cellTitle_ez_right'>작업수행명령</div>
											</td>
											<td colspan="5">
												<div class='cellContent_kang'>
													<%=strCommand%>
													<input type="hidden" name="command" id="command" value="<%=CommonUtil.replaceHtmlStr(strCommand)%>"  style= "width:98%;height:21px;"/>
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
						<div align='right' class='btn_area'>
							<span id='btn_ins' style="display:none;">저장</span>
						</div>
					</h4>
				</td>
			</tr>


				<%
					for( int i=0; null!=approvalInfoList && i<approvalInfoList.size(); i++ ) {
						ApprovalInfoBean bean = (ApprovalInfoBean)approvalInfoList.get(i);

						String strUserCd		= CommonUtil.isNull(bean.getUser_cd());
						String strUdtUserCd		= CommonUtil.isNull(bean.getUdt_user_cd());

						String strAbsenceUserCd	= CommonUtil.isNull(bean.getAbsence_user_cd());
						String strAbsenceUserNm	= CommonUtil.isNull(bean.getAbsence_user_nm());
						String strAbsenceDeptNm	= CommonUtil.isNull(bean.getAbsence_dept_nm());
						String strAbsenceDutyNm	= CommonUtil.isNull(bean.getAbsence_duty_nm());

						String strSeq	= CommonUtil.isNull(bean.getSeq());

						String strAbsenceInfo	= "";

						%>
			<input type="hidden" name="seq" id="seq" value="<%= strSeq%>"/>
				<%
						if( (S_USER_CD.equals(bean.getUser_cd()) || S_USER_CD.equals(strAbsenceUserCd)) && !"02".equals(bean.getApproval_cd()) && !"04".equals(bean.getApproval_cd()) && bean.getSeq().equals(bean.getCur_approval_seq()) ){
							if( "01".equals(bean.getApproval_cd()) ){
								%>
			<span id='btn_approval'>결재</span>
			<span id='btn_wait'>보류</span>
			<span id='btn_reject'>반려</span>
			<span id='btn_cancel'>승인취소</span>
				<%


							}else if( "03".equals(bean.getApproval_cd()) ){

								%>
			<span id='btn_approval'>결재</span>
			<span id='btn_reject'>반려</span>
				<%
							}
							%>
			<span id='btn_list'>목록</span>
				<%
								if( ("02".equals(CommonUtil.isNull(docBean.getState_cd())) || "04".equals(CommonUtil.isNull(docBean.getState_cd())) ) && S_USER_CD.equals(CommonUtil.isNull(docBean.getUser_cd())) ) { %>
			&nbsp;
			<span id='btn_capy'>복사</span>

				<%} %>

				<%if( ("02".equals(CommonUtil.isNull(docBean.getState_cd()))||"04".equals(CommonUtil.isNull(docBean.getState_cd())) ) && ( S_USER_CD.equals(CommonUtil.isNull(docBean.getUser_cd()))||"99".equals(S_USER_GB) ) ) { %>
			&nbsp;
			<span id='btn_del'>삭제</span>
				<%} %>
				<%} %>
				<%} %>

					</div>
				</h4>
			</td>
		</tr>
	</table>
</form>

<script type="text/javascript">
	$(document).ready(function() {

		var server_gb = "<%=strServerGb%>";
		var session_user_gb = "<%=S_USER_GB%>";
		var table_name = "<%=CommonUtil.isNull(docBean.getTable_name()) %>";

		// 해당 작업을 선행으로 설정한 작업 유무
		getInCondName();

		//반영일
		$("#apply_date").addClass("text_input").unbind('click').click(function(){
			dpCalMinMax(this.id,'yymmdd','0','90');
		});

		$("#btn_ins").show();

		$("#btn_ins").button().unbind("click").click(function () {
			goPrc('ins','','','');
		});

	});

	function goPrc(flag, grp_approval_userList, grp_alarm_userList, title) {

		var frm 			= document.frm1;
		var doc_gb 			= "03";
		var in_cond_name 	= frm.in_cond_name.value;

		frm.flag.value = flag;
		frm.deleted_yn.value = "N";

		if(in_cond_name != ""){
			frm.deleted_yn.value = "Y";
		}

		isValid_C_M();

		if (document.getElementById('is_valid_flag').value == "false") {
			document.getElementById('is_valid_flag').value = ""
			return;
		}

		var table_id = frm.table_id.value;
		var job_id = frm.job_id.value;
		var data_center = frm.data_center.value;
		var sched_table = frm.sched_table.value;

		document.getElementById('table_name').value = sched_table;
		document.getElementById('job_name').value = "<%=strJobName%>";

		$("#frm1").find("input[name='p_apply_date']").val($("input[name='apply_date']").val());

		if (document.getElementById('in_cond_name').value != "") {

			if (!confirm("해당 작업을 선행으로 설정한 작업이 존재합니다.\n\n" + document.getElementById('in_cond_name').value + "\n삭제 하시겠습니까?")) return;

		}

		if (!confirm("처리하시겠습니까?")) return;

		try {viewProgBar(true);} catch (e) {}

		frm.title.value = title;
		frm.grp_approval_userList.value = grp_approval_userList;
		frm.grp_alarm_userList.value = grp_alarm_userList;

		frm.target = "if1";
		frm.action = "<%=sContextPath%>/tWorks.ez?c=ez004_p";
		frm.submit();
	}

	function getInCondName() {

		try {viewProgBar(true);} catch (e) {}

		var job_name = $("#job_name").val();
		job_name = job_name + '-OK';

		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=getInCondNameList&itemGubun=2&job_name='+encodeURI(job_name);

		var xhr = new XHRHandler(url, null
				, function () {
					var xmlDoc = this.req.responseXML;
					if (xmlDoc == null) {
						try {
							viewProgBar(false);
						} catch (e) {
						}
						alert('세션이 만료되었습니다 다시 로그인해 주세요');
						return false;
					}

					if ($(xmlDoc).find('doc').length == 0 && $(xmlDoc).find('error').length > 0) {
						try {
							viewProgBar(false);
						} catch (e) {
						}
						alert($(xmlDoc).find('msg_code').text());
						//goCommonError('<%=sContextPath %>','_self',$(xmlDoc).find('msg_code').text());
						return false;
					}

					$(xmlDoc).find('doc').each(function () {

						var items = $(this).find('items');
						var rowsObj = new Array();

						if (items.attr('cnt') == '0') {

						} else {

							var in_cond_name = "";

							items.find('item').each(function (i) {

								var job_name = $(this).find("JOB_NAME").text();
								var user_nm = $(this).find("USER_NM").text();

								in_cond_name += "작업명 : " + job_name + " 담당자 : " + user_nm + "\n";
							});
						}

						$("#in_cond_name").val(in_cond_name);
					});
					try {
						viewProgBar(false);
					} catch (e) {
					}
				}
				, null);

		xhr.sendRequest();
	}

</script>
<%@include file="/jsp/common/inc/progBar.jsp"  %>
<iframe name="if1" id="if1" width="0" height="0"></iframe>
</div>
</body>
</html>