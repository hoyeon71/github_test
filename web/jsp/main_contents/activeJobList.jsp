
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/jsp/common/inc/header.jsp"%>

<link rel="stylesheet" type="text/css" href="/css/multiple_comboTree_style.css">
<script type="text/javascript" 	src="/js/multiple_comboTree/comboTreePlugin.js"></script>
<script type="text/javascript" 	src="/js/multiple_comboTree/icontains.js"></script>
<script type="text/javascript"  src="<%=request.getContextPath() %>/js/SlickGrid-2.1.0/plugins/slick.autocolumnsize.js" ></script>

<c:set var="job_action" value="${fn:split(JOB_ACTION,',')}"/>

<%
	Map<String, Object> paramMap = CommonUtil.collectParameters(request);
	String c 				= CommonUtil.isNull(paramMap.get("c"));
	String gridId 			= "g_"+c;

	String menu_gb 		 	= CommonUtil.getMessage("CATEGORY.GB.04.GB."+CommonUtil.isNull(paramMap.get("menu_gb")));
	String[] arr_menu_gb 	= menu_gb.split(",");

	String strServerGb 		= CommonUtil.isNull(CommonUtil.getMessage("SERVER_GB"));
	List adminApprovalBtnList = (List)request.getAttribute("adminApprovalBtnList");

	// 세션값 가져오기.
	String strSessionDcCode 	= S_D_C_CODE;
	String strSessionTab	 	= S_TAB;
	String strSessionApp        = S_APP;
	String strSessionGrp        = S_GRP;
	String session_user_gb 		= S_USER_GB;
	String session_user_id		= S_USER_ID;
	String strAdminApprovalBtn		= "";
	
	if ( adminApprovalBtnList != null ) {		
		for ( int i = 0; i < adminApprovalBtnList.size(); i++ ) {			
			CommonBean commonBean = (CommonBean) adminApprovalBtnList.get(i);			
			strAdminApprovalBtn = CommonUtil.isNull(commonBean.getScode_nm());
		}
	}

	// 작업 통제 여부
	String S_BATCH_CONTROL 		= CommonUtil.isNull(request.getSession().getAttribute("BATCH_CONTROL"));
	
	//스크롤 페이징
	String strPagingNum			= CommonUtil.getMessage("PAGING.NUM");

	String strODate				= CommonUtil.isNull(paramMap.get("odate"));
	String strStatus			= CommonUtil.isNull(paramMap.get("status"));
	String strStatus2			= "";
	if(!strStatus.equals(""))	strStatus2 = strStatus.replaceAll("_"," ");
	
	String strDataCenter		= CommonUtil.isNull(paramMap.get("dataCenter"));
	String strUserDaily			= CommonUtil.isNull(paramMap.get("user_daily"));
%>

<form id="f_s" name="f_s" method="post" onsubmit="return false;">	
	<input type='hidden' id='data_center_code' 		name='data_center_code'/>
	<input type='hidden' id='data_center' 			name='data_center'/>
	<input type='hidden' id='active_net_name' 		name='active_net_name' value="${active_net_name}" />
	<input type='hidden' id='p_sched_table' 		name='p_sched_table'/>
	<input type='hidden' id='p_application_of_def' 	name='p_application_of_def'/>
	<input type='hidden' id='p_group_name_of_def' 	name='p_group_name_of_def'/>
	<!-- <input type='hidden' id='p_application_of_def_text' 	name='p_application_of_def_text'/>
	<input type='hidden' id='p_group_name_of_def_text' 		name='p_group_name_of_def_text'/> -->
	<input type='hidden' id='p_search_gubun' 		name='p_search_gubun'/>
	<input type='hidden' id='p_search_text' 		name='p_search_text'/>
	<input type='hidden' id='p_search_gubun2' 		name='p_search_gubun2'/>
	<input type='hidden' id='p_search_text2' 		name='p_search_text2'/>
	<input type='hidden' id='searchType' 			name='searchType'/>
	<input type='hidden' id='p_s_odate' 			name='p_s_odate'/>
	<input type='hidden' id='p_e_odate' 			name='p_e_odate'/>
	<input type='hidden' id='p_s_search_odate' 		name='p_s_search_odate'/>
	<input type='hidden' id='p_e_search_odate' 		name='p_e_search_odate'/>
	<input type='hidden' id='p_s_time1'				name='p_s_time1'/>
	<input type='hidden' id='p_e_time1'				name='p_e_time1'/>
	<input type='hidden' id='p_s_time2'				name='p_s_time2'/>
	<input type='hidden' id='p_e_time2'				name='p_e_time2'/>
	<input type='hidden' id='p_status'				name='p_status'/>
	<input type='hidden' id='p_search_node_id' 		name='p_search_node_id'/>
	<input type='hidden' id='p_node_id' 			name='p_node_id'/>
	<input type='hidden' id='p_critical'			name='p_critical'/>
	<input type='hidden' id='p_search_user_daily' 	name='p_search_user_daily'/>
	
	<input type="hidden" name="odate" 				id="odate"/>
	<input type="hidden" name="order_id" 			id="order_id"/>
	<input type="hidden" name="job_name" 			id="job_name"/>
	<input type="hidden" name="status" 				id="status"/>
	<input type="hidden" name="job" 				id="job"/>
	<input type="hidden" name="graph_depth" 		id="graph_depth"/>
	<input type="hidden" name="order_36_id" 		id="order_36_id"/>
	<input type="hidden" name="end_date" 			id="end_date"/>
	<input type="hidden" name="rerun_count" 		id="rerun_count"/>
	<input type="hidden" name="memname" 			id="memname"/>
	<input type="hidden" name="total_rerun_count" 	id="total_rerun_count"/>
	<input type="hidden" name="node_id" 			id="node_id"/>
	<input type="hidden" name="active_gb" 			id="active_gb"/>
	<input type="hidden" name="task_type" 			id="task_type"/>
	<input type="hidden" name="rba" 				id="rba"/>
	<input type="hidden" name="page_gubun" 			id="page_gubun" 		value="active_job_list" />	<!-- 이 항목이 있어야 수정화면이 열림 -->
	<input type="hidden" name="menu_gb" 			id="menu_gb" 			value="${paramMap.menu_gb}" />
	<input type="hidden" name="p_mcode_nm" 			id="p_mcode_nm" /> 
	<input type="hidden" name="p_scode_nm" 			id="p_scode_nm" />
	
	<input type="hidden" name="p_scode_cd" 			id="p_scode_cd" />
	<input type="hidden" name="p_grp_depth" 		id="p_grp_depth" />
	<input type="hidden" name="p_app_nm" 			id="p_app_nm" />
	<input type="hidden" name="p_app_search_gubun" 	id="p_app_search_gubun" />
	<input type="hidden" name="flag" 				id="flag"/>
	<input type="hidden" name="p_chk_hold" 			id="p_chk_hold"  		value=""/>

	<input type="hidden" name="startRowNum"			id="startRowNum" 	 	value="0" />
	<input type="hidden" name="pagingNum"			id="pagingNum" 	 		value="<%=strPagingNum%>" />
	<input type="hidden" name="appl_type" 			id="appl_type"/>
	<input type="hidden" name="from_line"			id="from_line" 	 		value="1" />
	<input type="hidden" name="to_line"				id="to_line" 	 		value="5000" />
</form>
<form name="userFrm" id="userFrm" method="post" onsubmit="return false;">
</form>
<form name="frm2" id="frm2" method="post" onsubmit="return false;">
	<input type="hidden" name="flag" 					id="flag"/>
	<input type="hidden" name="order_ids" 				id="order_ids"/>
	<input type="hidden" name="odates" 					id="odates"/>
	<input type="hidden" name="table_name" 				id="table_name"/>
	<input type="hidden" name="application" 			id="application"/>
	<input type="hidden" name="group_name" 				id="group_name"/>
	<input type="hidden" name="job_name" 				id="job_name"/>
	<input type="hidden" name="descriptions" 			id="descriptions"/>
	<input type="hidden" name="before_statuses" 		id="before_statuses"/>
	<input type="hidden" name="group_status" 			id="group_status"/>
	<input type="hidden" name="gubun" 					id="gubun"/>
	<input type='hidden' name='data_center'				id='data_center' />
	<input type='hidden' name='data_center_code'		id='data_center_code' />
	<input type='hidden' name='active_net_name'			id='active_net_name' />
	<input type='hidden' name='post_user_cd'			id='post_user_cd' />
	<input type='hidden' name='post_user_id'			id='post_user_id' />
	<input type='hidden' name='title'					id='title' />
	<input type='hidden' name='post_approval_yn'		id='post_approval_yn' />
	<input type='hidden' name='grp_approval_userList'	id='grp_approval_userList' />
	<input type='hidden' name='grp_alarm_userList'		id='grp_alarm_userList' />
	<input type='hidden' name='group_yn'				id='group_yn' />
	<input type='hidden' name='doc_gb'					id='doc_gb' />
	<input type="hidden" name="grp_doc_gb" 				id="grp_doc_gb" 	value="07"/>
	<input type='hidden' name='doc_cnt'					id='doc_cnt'		value='0' />
	<input type='hidden' name='p_apply_date'			id='p_apply_date'	 />

</form>

<table style='width:100%;height:100%;border:none;'>
	<tr style='height:10px;'>
		<td style='vertical-align:top;'>
			<h4 class="ui-widget-header ui-corner-all"  >
				<div id='t_<%=gridId %>' class='title_area' >
					<span><%=CommonUtil.isNull(CommonUtil.getMessage("CATEGORY.GB.04"))%> > <%=CommonUtil.isNull(arr_menu_gb[0]) %></span>
				</div>
			</h4>
		</td>
	</tr>
	<tr style='height:10px;'>
		<td style='vertical-align:top;'>
			<form name="frm1" id="frm1" method="post">
			<h4 class="ui-widget-header ui-corner-all">
			<table style='width:100%;'>
				<tr>
					<th width="10%"><div class='cellTitle_kang2' style='min-width:120px;'>C-M</div></th>
					<td width="20%" style="text-align:left; width:180px;">
						<div class='cellContent_kang' style='width:180px;'>
							<select id="data_center_items" name="data_center_items" style="width:120px; height:21px;">							
								<option value="">선택</option>
								<c:forEach var="cm" items="${cm}" varStatus="status">
									<option value="${cm.scode_cd},${cm.scode_eng_nm}">${cm.scode_nm}</option>
								</c:forEach>
							</select>
						</div>
					</td>
					
					<th width="10%"><div class='cellTitle_kang2' style='min-width:120px;'>상태</div></th>
					<td width="15%" style="text-align:left;">
						<div class='cellContent_kang' style='display:flex;align-items: center;'>
							<div class="multi_combo_line" style='width:250px;'>
								<input type="text" name="multi_combo_status" id="multi_combo_status" autocomplete="off" placeholder="기본 전체 선택" onfocus="this.blur();">
								<input type="hidden" name="multi_combo_status_val" id="multi_combo_status_val">
							</div>
							&nbsp;&nbsp;
							<img src="/imgs/icon/hold.png" style="width:14px;height:14px;vertical-align:middle;cursor:pointer;"/>&nbsp
							<select id="chk_hold" name="chk_hold" style="width:50px;height:21px;">
								<option value=''>전체</option>
								<option value='Y'>Y</option>
								<option value='N'>N</option>
							</select>
						</div>
					</td>
					<th width="10%"><div class='cellTitle_kang2'>ODATE</div></th>
					<td width="20%" style="text-align:left">
						<div class='cellContent_kang'>
						<input type="text" maxlength="8" name="s_odate" id="s_odate" value="${ODATE}" class="input datepick" style="width:75px; height:21px;" /> ~
						<input type="text" maxlength="8" name="e_odate" id="e_odate" value="${ODATE}" class="input datepick" style="width:75px; height:21px;" />
						</div>
					</td>
							
				</tr>
				<tr>
					<th><div class='cellTitle_kang2'>폴더</div></th>
					<td style="text-align:left">
						<div class='cellContent_kang'>
							<input type="text" name="table_nm" id="table_nm" style="width:115px; height:21px;" onkeydown="return false;" readonly/>&nbsp;
							<select name="sub_table_of_def" id="sub_table_of_def" style="width:120px;height:21px;display:none;">
								<option value="">전체</option>
							</select>
							<img id="btn_clear1" src="/images/sta2.png" style="width:16px;height:16px;vertical-align:middle;cursor:pointer;"/>
							<input type="hidden" name="table_of_def" id="table_of_def" />
						</div>
					</td>
						
					<th><div class='cellTitle_kang2'>어플리케이션</div></th>
					<td style="text-align:left;min-width:120px;">
						<div class='cellContent_kang'>
							<select name="application_of_def" id="application_of_def" style="width:120px;height:21px;">
								<option value="">--선택--</option>
							</select>
<!-- 							<input type='text' id='application_of_def_text' name='application_of_def_text' style="width:144px; height:21px;"/> -->
<!-- 							제외:<input type='checkbox' id='chk_app' name='chk_app' value = "N" />&nbsp;&nbsp; -->
						</div>
					</td>
					
					<th width="10%"><div class='cellTitle_kang2'>그룹</div></th>
					<td width="20%" style="text-align:left">
						<div class='cellContent_kang'>
						<select id="group_name_of_def" name="group_name_of_def" style="width:120px; height:21px;">
							<option value=''>--선택--</option>
						</select>
						<!-- <input type='text' id='group_name_of_def_text' 	name='group_name_of_def_text' style="width:150px; height:21px; display:none;"/> -->
						</div>
					</td>	
				</tr>
				<tr>
					<th width="10%"><div class='cellTitle_kang2'>수행서버</div></th>
					<td width="20%" style="text-align:left">
						<div class='cellContent_kang'>
						<select id="node_id" name="node_id" style="width:120px; height:21px;">
							<option value=''>--선택--</option>						
						</select>
						</div>
					</td>
					<th ><div class='cellTitle_kang2'>시작일시</div></th>
					<td style="text-align:left;min-width:150px;" >
						<div class='cellContent_kang'>
						<input type="text" maxlength="8" name="s_date1" id="s_date1" value="" class="input datepick" style="width:60px; height:21px;" maxlength="10" onClick="fn_clear(this.id);" placeholder = "시작일자"/>
						<select id="s_hour1" name="s_hour1" style="width:50px;height:21px;" >
							  <c:forEach var="i" begin="0" end="23">
							  <c:choose>
							      <c:when test="${i lt 10 }">
							          <option value="0${i}">0${i}</option>
							      </c:when>
							      <c:otherwise>
							          <option value="${i}">${i}</option>
							      </c:otherwise>
							  </c:choose>
							  </c:forEach>
						</select> : 
						<select id="s_min1" name="s_min1" style="width:50px;height:21px;">
							  <c:forEach var="i" begin="0" end="59">
							  <c:choose>
							      <c:when test="${i lt 10 }">
							          <option value="0${i}">0${i}</option>
							      </c:when>
							      <c:otherwise>
							          <option value="${i}">${i}</option>
							      </c:otherwise>
							  </c:choose>
							  </c:forEach>
						</select> 
						~
						<input type="text" maxlength="8" name="e_date1" id="e_date1" value="" class="input datepick" style="width:60px; height:21px;" maxlength="10" onClick="fn_clear(this.id);" placeholder = "시작일자"/>
						<select id="e_hour1" name="e_hour1" style="width:50px;height:21px;">
							  <c:forEach var="i" begin="0" end="23">
							  <c:choose>
							      <c:when test="${i lt 10 }">
							          <option value="0${i}">0${i}</option>
							      </c:when>
							      <c:otherwise>
							          <option value="${i}">${i}</option>
							      </c:otherwise>
							  </c:choose>
							  </c:forEach>
						</select> :
						<select id="e_min1" name="e_min1" style="width:50px;height:21px;">
							  <c:forEach var="i" begin="0" end="59">
							  <c:choose>
							      <c:when test="${i lt 10 }">
							          <option value="0${i}">0${i}</option>
							      </c:when>
							      <c:otherwise>
							          <option value="${i}">${i}</option>
							      </c:otherwise>
							  </c:choose>
							  </c:forEach>
						</select>&nbsp;<img id="btn_clear3" src="/images/sta2.png" style="width:16px;height:16px;vertical-align:middle;cursor:pointer;"/>
						</div>
					</td>				
					<th width="10%"><div class='cellTitle_kang2'>조건</div></th>
					<td width="25%" style="text-align:left" colspan=2>
						<div class='cellContent_kang' style='min-width:300px;'>
						<select name="search_gubun" id="search_gubun" style="width:120px;height:21px;">
							<option value="user_nm">담당자(모두)</option>
							<option value="user_nm1">담당자1</option>
							<option value="user_nm2">담당자2</option>
							<option value="user_nm3">담당자3</option>
							<option value="user_nm4">담당자4</option>
							<option value="user_nm5">담당자5</option>
							<option value="user_nm6">담당자6</option>
							<option value="user_nm7">담당자7</option>
							<option value="user_nm8">담당자8</option>
							<option value="user_nm9">담당자9</option>
							<option value="user_nm10">담당자10</option>
							<option value="grp_nm1">그룹1</option>
							<option value="grp_nm2">그룹2</option>
						</select>
<%-- 						<input type="text" name="search_text" value="<%=S_USER_NM %>" id="search_text" style="width:150px; height:21px;"/> --%>
						<input type="text" name="search_text" value="" id="search_text" style="width:150px; height:21px;"/>
						</div>
					</td>
				</tr>
				<tr>	
					<th ><div class='cellTitle_kang2'>작업종류</div></th>
					<td>
						<div class='cellContent_kang'>
						<select name="search_user_daily" id="search_user_daily" style="width:120px;height:21px;">
							<option value="">--선택--</option>
							<option value="Y">정기</option>	
							<option value="N">비정기</option>
							<option value="S">수시오더</option>
						</select>
						</div>
					</td>
					<th ><div class='cellTitle_kang2'>종료일시</div></th>
					<td style="text-align:left" >
						<div class='cellContent_kang' style='min-width:405px;'>
						<input type="text" maxlength="8" name="s_date2" id="s_date2" value="" class="input datepick" style="width:60px; height:21px;" maxlength="10" onClick="fn_clear(this.id);" placeholder = "종료일자"/>
						<select id="s_hour2" name="s_hour2" style="width:50px;height:21px;" >
							  <c:forEach var="i" begin="0" end="23">
							  <c:choose>
							      <c:when test="${i lt 10 }">
							          <option value="0${i}">0${i}</option>
							      </c:when>
							      <c:otherwise>
							          <option value="${i}">${i}</option>
							      </c:otherwise>
							  </c:choose>
							  </c:forEach>
						</select> : 
						<select id="s_min2" name="s_min2" style="width:50px;height:21px;">
							  <c:forEach var="i" begin="0" end="59">
							  <c:choose>
							      <c:when test="${i lt 10 }">
							          <option value="0${i}">0${i}</option>
							      </c:when>
							      <c:otherwise>
							          <option value="${i}">${i}</option>
							      </c:otherwise>
							  </c:choose>
							  </c:forEach>
						</select> 
						~
						<input type="text" maxlength="8" name="e_date2" id="e_date2" value="" class="input datepick" style="width:60px; height:21px;" maxlength="10" onClick="fn_clear(this.id);" placeholder = "종료일자"/>
						<select id="e_hour2" name="e_hour2" style="width:50px;height:21px;">
							  <c:forEach var="i" begin="0" end="23">
							  <c:choose>
							      <c:when test="${i lt 10 }">
							          <option value="0${i}">0${i}</option>
							      </c:when>
							      <c:otherwise>
							          <option value="${i}">${i}</option>
							      </c:otherwise>
							  </c:choose>
							  </c:forEach>
						</select> :
						<select id="e_min2" name="e_min2" style="width:50px;height:21px;">
							  <c:forEach var="i" begin="0" end="59">
							  <c:choose>
							      <c:when test="${i lt 10 }">
							          <option value="0${i}">0${i}</option>
							      </c:when>
							      <c:otherwise>
							          <option value="${i}">${i}</option>
							      </c:otherwise>
							  </c:choose>
							  </c:forEach>
						</select>&nbsp;<img id="btn_clear4" src="/images/sta2.png" style="width:16px;height:16px;vertical-align:middle;cursor:pointer;"/>
						</div>
					</td>
					<th width="10%"><div class='cellTitle_kang2'>조건2</div></th>
					<td width="25%" style="text-align:left">
						<div class='cellContent_kang' style='min-width:400px;'>
						<select name="search_gubun2" id="search_gubun2" style="width:120px;height:21px;">
							<option value="job_name">작업명</option>	
							<option value="description">작업설명</option>
							<option value="command">작업수행명령</option>
							<option value="order_id">ORDER_ID</option>
						</select>
						<input type="text" name="search_text2" value="" id="search_text2" style="width:150px; height:21px;"/>
								<span id='btn_search' style='float:right;margin:3px;'>검 색</span>
							</div>
					
					</td>
					</tr>
			</table>
			</h4>
			</form>
		</td>
	</tr>
<% 
	//if ( session_user_gb.equals("01") && strServerGb.equals("P") ) {
	//} else {
%>	
	
	<tr style='height:10px;'><td></td></tr>
		
	<tr style='height:10px;'>
		<td style="vertial-align:top;">
			<span>
				<select name="job_status" id="job_status" style="height:21px;">
					<option value="">--변경할 상태 선택--</option>
				</select>
			</span>
			
			<%
				if ( !S_BATCH_CONTROL.equals("Y")) {
			%>
			
			<span id="btn_draft">승인요청</span>

			<%
				}
			%>
			
			<span id='btn_draft_admin' style="display:none;">관리자 즉시결재</span>
			<span style='float:right;font-weight: bold'>
				자동 리프레쉬 <input type='checkbox' name='refresh_yn' id='refresh_yn' >
			</span>
		</td>
	</tr>
		
	<tr style='height:5px;'><td></td></tr>
<% 
	//} 
%>
	<tr>
		<td style="vertial-align:top;">
			<table style="width:100%; height:100%;">
				<tr>
					<td id='ly_<%=gridId %>' style='vertical-align:top;' >
						<div id="<%=gridId %>" class="ui-widget-header ui-corner-all" ></div>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr style='height:10px;'>
		<td style='vertical-align:top;'>
			<h4 class="ui-widget-header ui-corner-all" >
				<div align='right' class='btn_area' >
					<div id='ly_total_cnt' style='padding-top:5px;float:left;'></div>	
					<%if(session_user_gb.equals("98")){ %>
					<input type="text" name="s_search_odate" id="s_search_odate" value="${ODATE}" class="input datepick" style="width:75px; height:21px;" maxlength="10" readOnly/> ~
					<input type="text" name="e_search_odate" id="e_search_odate" value="${ODATE}" class="input datepick" style="width:75px; height:21px;" maxlength="10" readOnly/>
					<%} %>
					<span id="btn_down">엑셀다운</span>
				</div>
			</h4>
		</td>
	</tr>
</table>
<script>
	var listChk = false;

	var arr_job_action = new Array();
	<c:forEach var="job_action" items="${job_action}" varStatus="s">
		var map_cd = {"cd":"${job_action}"};
		arr_job_action.push(map_cd);
	</c:forEach>

	function gridCellCustomFormatter(row,cell,value,columnDef,dataContext){
		
		var ret 				= "";
		var order_id 			= getCellValue(gridObj,row,'ORDER_ID');
		var run_cnt 			= getCellValue(gridObj,row,'RUN_CNT');
		var end_date 			= getCellValue(gridObj,row,'END_DATE');
		var mem_name 			= getCellValue(gridObj,row,'MEM_NAME');
		var node_id 			= getCellValue(gridObj,row,'NODE_ID');
		var job_name 			= getCellValue(gridObj,row,'JOB_NAME');
		var odate 				= getCellValue(gridObj,row,'ODATE');
		var ori_state_result 	= getCellValue(gridObj,row,'ORI_STATE_RESULT');
		var pop_gb 				= getCellValue(gridObj,row,'POP_GB');	
		var active_gb 			= getCellValue(gridObj,row,'ACTIVE_GB');
		var changeColor2		= getCellValue(gridObj,row,'changeColor2');
		var task_type			= getCellValue(gridObj,row,'TASK_TYPE');
		var rba					= getCellValue(gridObj,row,'RBA');
		var appl_type			= getCellValue(gridObj,row,'APPL_TYPE');
		
		if(columnDef.id == 'START_TIME'){
			ret = "<a href=\"JavaScript:popTimeInfoForm('"+job_name+"', '"+order_id+"');\" /><font color='red'>"+value+"</font></a>";			
		}
				
		if(columnDef.id == 'JOB_NAME'){
			if(task_type == 'SMART Table' || task_type == 'Sub-Table'){
				ret = "<a href=\"JavaScript:popupSmartTreeInfo('"+order_id+"', '"+job_name+"', '"+rba+"', '"+odate+"', '"+task_type+"');\" /><font color='red'>"+value+"</font></a>";
			}else{
				ret = "<a href=\"JavaScript:popupAjobInfo('"+order_id+"', '"+job_name+"');\" /><font color='red'>"+value+"</font></a>";
		}
		}
				
		if(columnDef.id == 'CM_LOG'){
			ret = "<a href=\"JavaScript:popupCmLog('<%=sContextPath %>','"+order_id+"');\" /><font color='red'>"+value+"</font></a>";
		}
		
		if(columnDef.id == 'SYS_OUT'){
			ret = "<a href=\"JavaScript:popupSysoutTelnet('<%=sContextPath %>','"+order_id+"','"+run_cnt+"','"+end_date+"','"+mem_name+"','"+node_id+"','"+job_name+"','active','"+appl_type+"');\" /><font color='red'>"+value+"</font></a>";
		}
		
		if(columnDef.id == 'SYS_OUT_DOWN'){
			ret = "<a href=\"JavaScript:popupSysoutTelnet_down('<%=sContextPath %>','"+order_id+"','"+run_cnt+"','"+end_date+"','"+mem_name+"','"+node_id+"','"+job_name+"','active','"+appl_type+"');\" /><font>"+value+"</font></a>";
		}

		if(columnDef.id == 'CTM_WHY'){
			ret = "<a href=\"JavaScript:popupCtmWhy('<%=sContextPath %>','"+order_id+"');\" /><font color='red'>"+value+"</font></a>";
		}
		
		if(columnDef.id == 'GRAPH'){
			ret = "<a href=\"JavaScript:popupJobGraph_d3('<%=sContextPath %>','"+odate+"','"+order_id+"','"+job_name+"','"+ori_state_result+"');\" /><font color='red'>"+value+"</font></a>";
		}
		
		if(columnDef.id == 'USER_NM'){
			ret = "<a href=\"JavaScript:jobUserInfo('"+job_name+"');\" /><font color='blue'>"+value+"</font></a>";
		}
				
		return ret;
	}

	function checkAll() {

		var chk 		= document.getElementsByName("check_idx");
		var chk_all 	= document.getElementById("checkIdxAll");
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
		
	var gridObj = {
		id : "<%=gridId %>"
		,colModel:[
			{formatter:gridCellNoneFormatter,field:'check_idx',id:'check_idx',name:'<input type="checkbox" name="checkIdxAll" id="checkIdxAll" onClick="checkAll();">',width:30,minWidth:30,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:false}
	   		,{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'번호',minWidth:50,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
			,{formatter:gridCellNoneFormatter,field:'ODATE',id:'ODATE',name:'ODATE',minWidth:80,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	   		,{formatter:gridCellCustomFormatter,field:'START_TIME',id:'START_TIME',name:'시작일시',minWidth:130,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'END_TIME',id:'END_TIME',name:'종료일시',minWidth:130,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
			,{formatter:gridCellNoneFormatter,field:'FROM_TIME',id:'FROM_TIME',name:'시작시간',minWidth:65,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
			,{formatter:gridCellNoneFormatter,field:'RUN_TIME',id:'RUN_TIME',name:'수행시간',minWidth:80,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
			,{formatter:gridCellNoneFormatter,field:'AVG_RUN_TIME',id:'AVG_RUN_TIME',name:'평균수행시간',width:100,minWidth:100,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
			,{formatter:gridCellNoneFormatter,field:'RUN_CNT',id:'RUN_CNT',name:'실행횟수',minWidth:70,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}

	   		//,{formatter:gridCellNoneFormatter,field:'DEPT_NM',id:'DEPT_NM',name:'부서',width:100,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	   		//,{formatter:gridCellNoneFormatter,field:'TASK_TYPE',id:'TASK_TYPE',name:'작업종류',width:70,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}

	   		,{formatter:gridCellCustomFormatter,field:'JOB_NAME',id:'JOB_NAME',name:'작업명',minWidth:200,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'DESCRIPTION',id:'DESCRIPTION',name:'작업설명',minWidth:200,maxWidth:450,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
			,{formatter:gridCellNoneFormatter,field:'STATE_RESULT',id:'STATE_RESULT',name:'상태',minWidth:130,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'NODE_ID',id:'NODE_ID',name:'수행서버',minWidth:80,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	   		//,{formatter:gridCellNoneFormatter,field:'CALENDAR_NM',id:'CALENDAR_NM',name:'캘린더명',width:100,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
			,{formatter:gridCellCustomFormatter,field:'USER_NM',id:'USER_NM',name:'담당자',minWidth:80,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
			,{formatter:gridCellNoneFormatter,field:'TABLE_NAME',id:'TABLE_NAME',name:'폴더',minWidth:110,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
			,{formatter:gridCellNoneFormatter,field:'APPLICATION',id:'APPLICATION',name:'어플리케이션',minWidth:110,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
			,{formatter:gridCellNoneFormatter,field:'GROUP_NAME',id:'GROUP_NAME',name:'그룹',minWidth:110,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
			,{formatter:gridCellNoneFormatter,field:'TASK_TYPE',id:'TASK_TYPE',name:'작업타입',width:0,minWidth:0,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
			,{formatter:gridCellNoneFormatter,field:'JOBSCHEDGB',id:'JOBSCHEDGB',name:'작업종류',minWidth:70,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
			/* ,{formatter:gridCellNoneFormatter,field:'INS_NM1',id:'INS_NM1',name:'의뢰자',minWidth:70,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
			,{formatter:gridCellNoneFormatter,field:'APPROVAL_NM1',id:'APPROVAL_NM1',name:'1차결재자',minWidth:70,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
			,{formatter:gridCellNoneFormatter,field:'APPROVAL_NM2',id:'APPROVAL_NM2',name:'2차결재자',minWidth:70,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true} */
			,{formatter:gridCellNoneFormatter,field:'ORDER_ID',id:'ORDER_ID',name:'ORDER_ID',minWidth:70,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
			
	   		,{formatter:gridCellCustomFormatter,field:'CM_LOG',id:'CM_LOG',name:'CTM LOG',minWidth:70,headerCssClass:'cellCenter',cssClass:'cellCenter'}
	   		,{formatter:gridCellCustomFormatter,field:'SYS_OUT',id:'SYS_OUT',name:'SYS OUT',minWidth:70,headerCssClass:'cellCenter',cssClass:'cellCenter'}
			,{formatter:gridCellCustomFormatter,field:'SYS_OUT_DOWN',id:'SYS_OUT_DOWN',name:'SYSOUT 다운',minWidth:70,headerCssClass:'cellCenter',cssClass:'cellCenter'}
			,{formatter:gridCellCustomFormatter,field:'CTM_WHY',id:'CTM_WHY',name:'CTM WHY',minWidth:70,headerCssClass:'cellCenter',cssClass:'cellCenter'}
	   		,{formatter:gridCellCustomFormatter,field:'GRAPH',id:'GRAPH',name:'GRAPH',minWidth:70,headerCssClass:'cellCenter',cssClass:'cellCenter'}
	   			   		
	   		,{formatter:gridCellNoneFormatter,field:'ACTIVE_GB',id:'ACTIVE_GB',name:'ACTIVE_GB',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   		,{formatter:gridCellNoneFormatter,field:'ORI_STATE_RESULT',id:'ORI_STATE_RESULT',name:'ORI_STATE_RESULT',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   		,{formatter:gridCellNoneFormatter,field:'POP_GB',id:'POP_GB',name:'POP_GB',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   		,{formatter:gridCellNoneFormatter,field:'END_DATE',id:'END_DATE',name:'END_DATE',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   		,{formatter:gridCellNoneFormatter,field:'MEM_NAME',id:'MEM_NAME',name:'파일명',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   		,{formatter:gridCellNoneFormatter,field:'SET_VALUE',id:'SET_VALUE',name:'파라미터',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   		,{formatter:gridCellNoneFormatter,field:'RBA',id:'RBA',name:'RBA',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   	]
		,rows:[]
		,vscroll:false
	};
	
	$(document).ready(function(){
		
		var session_user_gb 	= "<%=session_user_gb%>";
		var session_dc_code		= "<%=strSessionDcCode%>";
		var table_name			= "<%=strSessionTab%>";
		var application			= "<%=strSessionApp%>";
		var group_name			= "<%=strSessionGrp%>";
		var server_gb 			= "<%=strServerGb%>";		
		var session_user_id 	= "<%=session_user_id%>";
		var dataCenter			= "<%=strDataCenter%>";

		var odate				= "<%=strODate%>";
		var status				= "<%=strStatus%>";
		var adminApprovalBtn 	= "<%=strAdminApprovalBtn %>";
		var user_daily			= "<%=strUserDaily %>";
		
		$("#btn_search").show();
		
		<c:if test="${USER_GB eq '99'}">
			$("#btn_txt_down").show();
			
			// 관리자는 담당자 default 검색 조건 제거
			$('#search_text').val("");
			
		</c:if>
		var handle = "";
		var ref_time = "";

		$("#f_s").find("input[name='p_search_gubun']").val($("#frm1").find("select[name='search_gubun'] option:selected").val());
		$("#f_s").find("input[name='p_search_text']").val($("#frm1").find("input[name='search_text']").val());
		$("#f_s").find("input[name='p_search_gubun2']").val($("#frm1").find("select[name='search_gubun2'] option:selected").val());
		$("#f_s").find("input[name='p_search_text2']").val($("#frm1").find("input[name='search_text2']").val());
		$("#f_s").find("input[name='p_s_odate']").val("${ODATE}");
		$("#f_s").find("input[name='p_e_odate']").val("${ODATE}");
		
		$("#frm1").find("select[name='search_user_daily']").val(user_daily);
		$("#f_s").find("input[name='p_search_user_daily']").val($("#frm1").find("select[name='search_user_daily'] option:selected").val());
		var job_status = document.getElementById("job_status");
	
		job_status.innerHTML 	= "";
		job_status.options[0] 	= new Option("--변경할 상태 선택--", "");
	
		for(var j=0;j<arr_job_action.length;j++){
			job_status.options[j+1] = new Option(arr_job_action[j].cd, arr_job_action[j].cd);
		}

		if (session_user_gb == "99"  || adminApprovalBtn == "Y") {
				$("#btn_draft_admin").show();
		} else {
			$("#btn_draft_admin").hide();
		}

		//메인화면의 오류 현황 ODATE 적용
		if(odate != '') {
			odate = odate.replace(/\//gi,'');
			$("input[name='s_odate']").val(odate);
			$("#f_s").find("input[name='p_s_odate']").val(odate);

			$("input[name='e_odate']").val(odate);
			$("#f_s").find("input[name='p_e_odate']").val(odate);

		}

		if(status != ''){
			status = status.replace(/_/gi,' ');
			$("select[name='status']").val(status);

			$("#f_s").find("input[name='p_status']").val($("#frm1").find("select[name='status'] option:selected").val());
		}

		//초기 검색조건 - C-M, 폴더, 어플리케이션, 그룹
		if(session_dc_code != "") { // 개인정보에 C-M이 등록되어 있을경우
			$("select[name='data_center_items']").val(session_dc_code);
			$("#f_s").find("input[name='data_center']").val(session_dc_code);
		}else { // 개인정보에 C-M이 등록이 되어있지 않을경우 -> C-M 콤보박스에서 첫번째값 선택
			$("#data_center_items option:eq(1)").prop("selected", true);
			$("#f_s").find("input[name='data_center']").val($("select[name='data_center_items']").val());
		}
		
		if(dataCenter != ""){
			var num = $("#f_s").find("input[name='data_center']").length;
			
			<c:forEach var="cm" items="${cm}" varStatus="status">
				if("${cm.scode_eng_nm}" == dataCenter){
					$("#f_s").find("input[name='data_center']").val("${cm.scode_cd},${cm.scode_eng_nm}");
					$("select[name='data_center_items']").val("${cm.scode_cd},${cm.scode_eng_nm}");
				}
			</c:forEach>
		}

		if(table_name != '') {
			var data_center_items 		= $("select[name='data_center_items'] option:selected").val();

			$("input[name='table_nm']").val(table_name);
			$("#f_s").find("input[name='p_sched_table']").val(table_name);
			$("#p_application_of_def").val(application);
			$("#p_group_name_of_def").val(group_name);

			//검색조건 - 어플리케이션, 그룹 세팅
			getAppGrpCodeList("application_of_def", "2", application, "", table_name);
			setTimeout(function(){
				var selected_app_grp_cd	= $("#application_of_def option:selected").val().split(",")[0]; //그룹 조회 파라미터.
				if (selected_app_grp_cd != "")
					getAppGrpCodeList("group_name_of_def", "3", group_name, selected_app_grp_cd); //어플리케이션 코드로 그룹 조회 및 그룹 선택.
			}, 1000);

			//폴더에 속한 수행서버 조회
			mHostList(session_dc_code,table_name);

			if(!data_center_items == ""){
				setTimeout(function(){
					activeJobList();
				}, 1000);
				//페이지 리프레시 1000 -> 1초
				setInterval(function(){
					var refresh_yn = $("input[name='refresh_yn']:checked").val();
					
					if ( refresh_yn == "on"  && !data_center_items == "" ) {
						activeJobList();
					}
				}, 10000);
			}

		}else{
			//수행서버 전체 조회
			mHostList(session_dc_code,'');
			var data_center_items 		= $("select[name='data_center_items'] option:selected").val();
			if(!data_center_items == ""){
				setTimeout(function(){
					activeJobList();
				}, 1000);
				//페이지 리프레시 1000 -> 1초
				setInterval(function(){
					var refresh_yn 				= $("input[name='refresh_yn']:checked").val();
					
					if ( refresh_yn == "on"  && !data_center_items == "" ) {
						activeJobList();
					}
				}, 10000);
			}
		}
		
		viewGrid_color(gridObj,"ly_"+gridObj.id,{enableColumnReorder:true},'AUTO');
		
		// 멀티 콤보 박스 셋팅
		multi_combo_init();

		if($("select[name='data_center_items'] option:selected").val()!=''){
			setTimeout(function(){
				activeJobList();
			}, 1000);
		}

		$("#data_center_items").change(function(){
			//초기화
			$("#table_nm").val("");
			$("#table_of_def").val("");

			$("select[name='application_of_def'] option").remove();
			$("select[name='application_of_def']").append("<option value=''>--선택--</option>");
			
			$("select[name='group_name_of_def'] option").remove();
			$("select[name='group_name_of_def']").append("<option value=''>--선택--</option>");
			
			$("select[name='node_id'] option").remove();
			$("select[name='node_id']").append("<option value=''>--선택--</option>");

			$("#f_s").find("input[name='p_sched_table']").val("");
			$("#f_s").find("input[name='p_application_of_def']").val("");
			$("#f_s").find("input[name='p_group_name_of_def']").val("");
			
			var data_center_items = $(this).val();
			
			if($(this).val() != ""){
				$("#f_s").find("input[name='data_center']").val(data_center_items);
				mHostList(data_center_items,'');
			}
		});
		
		$("#btn_search").button().unbind("click").click(function(){

			var p_s_time1 = $("#f_s").find("input[name='p_s_time1']").val();
			var p_e_time1 = $("#f_s").find("input[name='p_e_time1']").val();
			var p_s_time2 = $("#f_s").find("input[name='p_s_time2']").val();
			var p_e_time2 = $("#f_s").find("input[name='p_e_time2']").val();
			
			if ( p_e_time1 < p_s_time1 ){
				alert("시작일시의 FROM ~ TO를 확인해 주세요.")
				return;
			}
			
			if ( p_e_time2 < p_s_time2 ){
				alert("종료일시의 FROM ~ TO를 확인해 주세요.")
				return;
			}
			
			if ( $("#s_odate").val() != "" && $("#e_odate").val() != "" ) {
				
				// 날짜 기간 체크
				if ( $("#s_odate").val() > $("#e_odate").val() ) {
					alert("일자의 FROM ~ TO를 확인해 주세요.");
					return;
				}
				
				// 날짜 정합성 체크
				if(!isValidDate($("#s_odate").val()) || !isValidDate($("#e_odate").val())){ 
					alert("잘못된 날짜입니다."); 
					return;
				}
			}
			
			activeJobList();
		});
		
		$('#search_text').unbind('keypress').keypress(function(e){			
			if(e.keyCode==13){	
				activeJobList();
			}
		});
		
		$('#search_text2').unbind('keypress').keypress(function(e){			
			if(e.keyCode==13){	
				activeJobList();
			}
		});
		
		// 어플리케이션 엔터
		/* $('#application_of_def_text').unbind('keypress').keypress(function(e) {
			if(e.keyCode==13){
				activeJobList();
			}
		}); */

		$("#btn_down").button().unbind("click").click(function(){
			goExcel();
		});
		$("#s_odate").addClass("text_input").unbind('click').click(function(){
			dpCalMin(this.id,'yymmdd');
		});
		
		$("#e_odate").addClass("text_input").unbind('click').click(function(){
			dpCalMin(this.id,'yymmdd');
		});
		
		$("#s_search_odate").addClass("ime_readonly").unbind('click').click(function(){
			dpCalMin(this.id,'yymmdd');
		});
		
		$("#e_search_odate").addClass("ime_readonly").unbind('click').click(function(){
			dpCalMin(this.id,'yymmdd');
		});
		
		$("#s_date1").addClass("text_input").unbind('click').click(function(){
			$("#frm1").find("input[name='s_date1']").val("");
			$("#f_s").find("input[name='p_s_time1']").val("");
			dpCalMin(this.id,'yymmdd');
		});
		
		$("#e_date1").addClass("text_input").unbind('click').click(function(){
			$("#frm1").find("input[name='e_date1']").val("");
			$("#f_s").find("input[name='p_e_time1']").val("");
			dpCalMin(this.id,'yymmdd');
		});
		
		$("#s_date2").addClass("text_input").unbind('click').click(function(){
			$("#frm1").find("input[name='s_date2']").val("");
			$("#f_s").find("input[name='p_s_time2']").val("");
			dpCalMin(this.id,'yymmdd');
		});
		
		$("#e_date2").addClass("text_input").unbind('click').click(function(){
			$("#frm1").find("input[name='e_date2']").val("");
			$("#f_s").find("input[name='p_e_time2']").val("");
			dpCalMin(this.id,'yymmdd');
		});
		
		//승인요청
		$("#btn_draft").button().unbind("click").click(function(){
			valid_chk("draft");
		});
		//관리자즉시결재
		$("#btn_draft_admin").button().unbind("click").click(function(){
			valid_chk("draft_admin");
		});


		//시작일시 초기화 버튼
		$("#btn_clear3").unbind("click").click(function(){
			$("#f_s").find("input[name='p_s_time1']").val("");

			$("#frm1").find("input[name='s_date1']").val("");
			 document.getElementById("s_hour1").value = '00';
			 document.getElementById("s_min1").value = '00';

			$("#f_s").find("input[name='p_e_time1']").val("");

			$("#frm1").find("input[name='e_date1']").val("");
			 document.getElementById("e_hour1").value = '00';
			 document.getElementById("e_min1").value = '00';
		});
		
		//종료일시 초기화 버튼
		$("#btn_clear4").unbind("click").click(function(){
			$("#f_s").find("input[name='p_s_time2']").val("");

			$("#frm1").find("input[name='s_date2']").val("");
			 document.getElementById("s_hour2").value = '00';
			 document.getElementById("s_min2").value = '00';

			$("#f_s").find("input[name='p_e_time2']").val("");

			$("#frm1").find("input[name='e_date2']").val("");
			 document.getElementById("e_hour2").value = '00';
			 document.getElementById("e_min2").value = '00';

		});
		
		//시작일시 
		$("#s_date1").change(function(){
			var s_date = $("#frm1").find("input[name='s_date1']").val()
			var s_hour = $("#frm1").find("select[name='s_hour1'] option:selected").val()
			var s_min = $("#frm1").find("select[name='s_min1'] option:selected").val()
			var s_time = s_date + s_hour + s_min;
		
			$("#f_s").find("input[name='p_s_time1']").val(s_time);
		});
		
		$("#s_hour1").change(function(){
			var s_date = $("#frm1").find("input[name='s_date1']").val()
			var s_hour = $("#frm1").find("select[name='s_hour1'] option:selected").val()
			var s_min = $("#frm1").find("select[name='s_min1'] option:selected").val()
			var s_time = s_date + s_hour + s_min;
		
			if(s_date == ""){
				alert("시작일자를 선택하세요.");
				return;
			}
			
			$("#f_s").find("input[name='p_s_time1']").val(s_time);
		});
		
		$("#s_min1").change(function(){
			var s_date = $("#frm1").find("input[name='s_date1']").val()
			var s_hour = $("#frm1").find("select[name='s_hour1'] option:selected").val()
			var s_min = $("#frm1").find("select[name='s_min1'] option:selected").val()
			var s_time = s_date + s_hour + s_min;
		
			if(s_date == ""){
				alert("시작일자를 선택하세요.");
				return;
			}
			if(s_hour == ""){
				alert("시작 시를 선택하세요.");
				return;
			}
			
			$("#f_s").find("input[name='p_s_time1']").val(s_time);
		});
		
		$("#e_date1").change(function(){
			var e_date 	= $("#frm1").find("input[name='e_date1']").val()
			var e_hour 	= $("#frm1").find("select[name='e_hour1'] option:selected").val()
			var e_min 	= $("#frm1").find("select[name='e_min1'] option:selected").val()
			var e_time 	= e_date + e_hour + e_min;
		
			$("#f_s").find("input[name='p_e_time1']").val(e_time);
		});
		
		$("#e_hour1").change(function(){
			var e_date = $("#frm1").find("input[name='e_date1']").val()
			var e_hour = $("#frm1").find("select[name='e_hour1'] option:selected").val()
			var e_min = $("#frm1").find("select[name='e_min1'] option:selected").val()
			var e_time = e_date + e_hour + e_min;
		
			if(e_date == ""){
				alert("종료일자를 선택하세요.");
				return;
			}
			
			$("#f_s").find("input[name='p_e_time1']").val(e_time);
		});
		
		$("#e_min1").change(function(){
			var e_date = $("#frm1").find("input[name='e_date1']").val()
			var e_hour = $("#frm1").find("select[name='e_hour1'] option:selected").val()
			var e_min = $("#frm1").find("select[name='e_min1'] option:selected").val()
			var e_time = e_date + e_hour + e_min;
		
			if(e_date == ""){
				alert("종료일자를 선택하세요.");
				return;
			}
			if(e_hour == ""){
				alert("종료 시를 선택하세요.");
				return;
			}
			
			$("#f_s").find("input[name='p_e_time1']").val(e_time);
		});
		
		//종료일시
		$("#s_date2").change(function(){
			var s_date = $("#frm1").find("input[name='s_date2']").val()
			var s_hour = $("#frm1").find("select[name='s_hour2'] option:selected").val()
			var s_min = $("#frm1").find("select[name='s_min2'] option:selected").val()
			var s_time = s_date + s_hour + s_min;
		
			$("#f_s").find("input[name='p_s_time2']").val(s_time);
		});
		
		$("#s_hour2").change(function(){
			var s_date = $("#frm1").find("input[name='s_date2']").val()
			var s_hour = $("#frm1").find("select[name='s_hour2'] option:selected").val()
			var s_min = $("#frm1").find("select[name='s_min2'] option:selected").val()
			var s_time = s_date + s_hour + s_min;
		
			if(s_date == ""){
				alert("시작일자를 선택하세요.");
				return;
			}
			
			$("#f_s").find("input[name='p_s_time2']").val(s_time);
		});
		
		$("#s_min2").change(function(){
			var s_date = $("#frm1").find("input[name='s_date2']").val()
			var s_hour = $("#frm1").find("select[name='s_hour2'] option:selected").val()
			var s_min = $("#frm1").find("select[name='s_min2'] option:selected").val()
			var s_time = s_date + s_hour + s_min;
		
			if(s_date == ""){
				alert("시작일자를 선택하세요.");
				return;
			}
			if(s_hour == ""){
				alert("시작 시를 선택하세요.");
				return;
			}
			
			$("#f_s").find("input[name='p_s_time2']").val(s_time);
		});
		
		$("#e_date2").change(function(){
			var e_date 	= $("#frm1").find("input[name='e_date2']").val()
			var e_hour 	= $("#frm1").find("select[name='e_hour2'] option:selected").val()
			var e_min 	= $("#frm1").find("select[name='e_min2'] option:selected").val()
			var e_time 	= e_date + e_hour + e_min;
		
			$("#f_s").find("input[name='p_e_time2']").val(e_time);
		});
		
		$("#e_hour2").change(function(){
			var e_date = $("#frm1").find("input[name='e_date2']").val()
			var e_hour = $("#frm1").find("select[name='e_hour2'] option:selected").val()
			var e_min = $("#frm1").find("select[name='e_min2'] option:selected").val()
			var e_time = e_date + e_hour + e_min;
		
			if(e_date == ""){
				alert("종료일자를 선택하세요.");
				return;
			}
			
			$("#f_s").find("input[name='p_e_time2']").val(e_time);
		});
		
		$("#e_min2").change(function(){
			var e_date = $("#frm1").find("input[name='e_date2']").val()
			var e_hour = $("#frm1").find("select[name='e_hour2'] option:selected").val()
			var e_min = $("#frm1").find("select[name='e_min2'] option:selected").val()
			var e_time = e_date + e_hour + e_min;
		
			if(e_date == ""){
				alert("종료일자를 선택하세요.");
				return;
			}
			if(e_hour == ""){
				alert("종료 시를 선택하세요.");
				return;
			}
			
			$("#f_s").find("input[name='p_e_time2']").val(e_time);
		});
		
		//테이블 클릭 시
		$("#table_nm").click(function(){
			var data_center = $("select[name='data_center_items'] option:selected").val();
			var select_table = $("input[name='table_nm']").val();
			if(data_center == ""){
				alert("C-M 을 선택해 주세요.");
				return;
			}else{
				searchPoeTabForm(select_table);
			}		
		});
		
		$("#application_of_def").change(function(){
			$("#group_name_of_def option").remove();
			$("#group_name_of_def").append("<option value=''>--선택--</option>");

			var grp_info = $(this).val().split(",");
			
			$("#p_application_of_def").val(grp_info[1]);
			$("#p_group_name_of_def").val("");
			
			if (grp_info != "") {
				getAppGrpCodeList("group_name_of_def", "3", "", grp_info[0]);
			} else {
				getAppGrpCodeList("group_name_of_def", "3", "", "");
			}
			
			// 세팅된 어플리케이션에 그룹이 하나일 경우 자동 세팅
			if($("select[name='group_name_of_def'] option").length == 2){
				$("select[name='group_name_of_def'] option:eq(1)").prop("selected", true);
				grp_info = $("select[name='group_name_of_def']").val().split(",");
				$("#p_group_name_of_def").val(grp_info[1]);
			}
		});
		
		$("#group_name_of_def").change(function(){
			var grp_info = $(this).val().split(",");
			$("#p_group_name_of_def").val(grp_info[1]);
		});
		
		$("#btn_txt_down").button().unbind("click").click(function(){
			goTxtDown();
		});
		
		$("#btn_clear1").unbind("click").click(function(){
			$("#f_s").find("input[name='p_sched_table']").val("");
			$("#f_s").find("input[name='p_application_of_def']").val("");
			$("#f_s").find("input[name='p_group_name_of_def']").val("");
			
			$("#frm1").find("input[name='table_nm']").val("");
			$("#frm1").find("input[name='table_of_def']").val("");

			/* $("#f_s").find("input[name='p_application_of_def_text']").val("");
			$("#f_s").find("input[name='p_group_name_of_def_text']").val(""); */

			/* $("#frm1").find("input[name='application_of_def_text']").val("");
			$("#frm1").find("input[name='group_name_of_def_text']").val(""); */


			$("select[name='application_of_def'] option").remove();
			$("select[name='application_of_def']").append("<option value=''>--선택--</option>");
			
			$("select[name='group_name_of_def'] option").remove();
			$("select[name='group_name_of_def']").append("<option value=''>--선택--</option>");
			
			$("select[name='sub_table_of_def'] option").remove();
			$("select[name='sub_table_of_def']").append("<option value=''>--선택--</option>");
			
			document.getElementById('sub_table_of_def').style.display = 'none';
			
			$("select[name='node_id'] option").remove();
			$("select[name='node_id']").append("<option value=''>--선택--</option>");

			var data_center = $("select[name='data_center_items'] option:selected").val();

			mHostList(data_center,'');
		});
		
		$("#btn_clear2").unbind("click").click(function(){
			$("#frm1").find("input[name='search_text']").val("");
		});
		
		/* $('#application_of_def_text').on('keyup', function(event) {
			var app_text = $(this).val().replace(/ /gi, '');
			$('#p_application_of_def_text').val(app_text);
		}); */

		//hold 필터 검색
		$("#chk_hold").change(function(){
			var grp_info = $(this).val();
			$("#p_chk_hold").val(grp_info);
		});

		//스크롤 페이징
		var grid = $('#'+gridObj.id).data('grid');
		grid.onScroll.subscribe(function(e, args){
			var elem = $("#g_ez009").children(".slick-viewport"); 
			if ( elem[0].scrollHeight - elem.scrollTop() - elem.css("height").replace("px", "") + 17 < 100) {
				if(listChk) {
					listChk = false;
					var startRowNum = parseInt($("#startRowNum").val());
					startRowNum += parseInt($('#pagingNum').val());
					activeJobList(startRowNum);
				}
// 				alert(elem[0].scrollHeight - elem.scrollTop() - elem.css("height").replace("px", "") + 17);
			}
		});
		
		$("#search_user_daily").change(function(){
			$("#f_s").find("input[name='p_search_user_daily']").val($("#frm1").find("select[name='search_user_daily'] option:selected").val());
		});
	});
	
	function activeJobList(startRowNum){
		
		//clearGridSelected(gridObj);

		var data_center_items 		= $("select[name='data_center_items'] option:selected").val();
		var node_id 				= $("select[name='node_id'] option:selected").val();
		var arr_node_id 			= node_id.split(",");

		if(data_center_items == ""){
			alert("C-M 을 선택해 주세요.");
			return;
		}

		$("#f_s").find("input[name='p_search_gubun']").val($("#frm1").find("select[name='search_gubun'] option:selected").val());
		$("#f_s").find("input[name='p_search_text']").val($("#frm1").find("input[name='search_text']").val());
		$("#f_s").find("input[name='p_search_gubun2']").val($("#frm1").find("select[name='search_gubun2'] option:selected").val());
		$("#f_s").find("input[name='p_search_text2']").val($("#frm1").find("input[name='search_text2']").val());
		//$("#f_s").find("input[name='p_status']").val($("#frm1").find("select[name='status'] option:selected").val());
		$("#f_s").find("input[name='p_s_odate']").val($("#frm1").find("input[name='s_odate']").val());
		$("#f_s").find("input[name='p_e_odate']").val($("#frm1").find("input[name='e_odate']").val());
		$("#f_s").find("input[name='p_node_id']").val(arr_node_id[1]);
		$("#f_s").find("input[name='order_id']").val("");
		$("#f_s").find("input[name='p_critical']").val($("#frm1").find("select[name='critical'] option:selected").val());
		$("#f_s").find("input[name='p_status']").val($("#frm1").find("input[name='multi_combo_status_val']").val());
		$("#f_s").find("input[name='p_search_user_daily']").val($("#frm1").find("select[name='search_user_daily'] option:selected").val());
		
		//odate 기간 체크
		if ( $("#p_s_odate").val() != "" && $("#p_e_odate").val() != "" ) {

			if ( $("#p_s_odate").val() > $("#p_e_odate").val() ) {
				alert("일자의 FROM ~ TO를 확인해 주세요.");
				return;
			}
		}
		
		// 스마트폴더의 서브테이블 검색 셋팅
        if( $("select[name='sub_table_of_def']").val() != "") {
        	var sched_table = $("input[name='p_sched_table']").val();
			var sub_table   = $("select[name='sub_table_of_def']").val();
			
			if(sub_table == 'search_all'){
				sub_table = "";
				var sub_table_options = document.getElementById("sub_table_of_def").options;
				for(var i = 1; i < sub_table_options.length; i++) {
					sub_table += "," + sub_table_options[i].value;
				}
				if(!sched_table.includes(sub_table)){
					$("#f_s").find("input[name='p_sched_table']").val(sched_table + sub_table);
				}
			}else {
				$("#f_s").find("input[name='p_sched_table']").val(sub_table);
			}
		}

		//페이징 처리
		if(startRowNum != '' && startRowNum != null && startRowNum != undefined) {
			$('#startRowNum').val(startRowNum);
		} else {
			var elem = $("#g_ez009").children(".slick-viewport");
			elem.scrollTop(0);
			startRowNum = 0;
			$('#startRowNum').val(0);
		}
		
		try{viewProgBar(true);}catch(e){}
		
		document.f_s.order_id.value = '';
		$('#ly_total_cnt').html('');
		
		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=activeJobList';
		
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
						if(startRowNum != '' && startRowNum != null && startRowNum != undefined) {
							rowsObj = gridObj.rows;
						}
						
						var changeColor = ''; 
						var changeColor2 = ''; 
						
						if(items.attr('cnt')=='0'){
						}else{
							items.find('item').each(function(i){		
								
								changeColor = '';
								changeColor2 = '';
							
								var from_time 		= $(this).find("FROM_TIME").text();
								var active_gb 		= $(this).find("ACTIVE_GB").text();
								var run_time 		= $(this).find("RUN_TIME").text();
								var odate 			= $(this).find("ODATE").text();
								var order_id 		= $(this).find("ORDER_ID").text();
								var start_time 		= $(this).find("START_TIME").text();
								var end_time 		= $(this).find("END_TIME").text();
								var state_result 	= $(this).find("STATE_RESULT").text();
								var user_nm 		= $(this).find("USER_NM").text();
								var job_name 		= $(this).find("JOB_NAME").text();
								var mem_name 		= $(this).find("MEM_NAME").text();
								var node_id 		= $(this).find("NODE_ID").text();
								var calendar_nm 	= $(this).find("CALENDAR_NM").text();
								var description 	= $(this).find("DESCRIPTION").text();
								var run_cnt 		= $(this).find("RUN_CNT").text();
								var diff_time 		= $(this).find("DIFF_TIME").text();
								var end_date 		= $(this).find("END_DATE").text();
								var table_name 		= $(this).find("TABLE_NAME").text();
								var application		= $(this).find("APPLICATION").text();
								var group_name 		= $(this).find("GROUP_NAME").text();
								var dept_nm 		= $(this).find("DEPT_NM").text();
								var state 			= $(this).find("STATE").text();
								var jobschedgb 		= $(this).find("JOBSCHEDGB").text();
								var user_daily 		= $(this).find("USER_DAILY").text();
								var task_type		= $(this).find("TASK_TYPE").text();
								var rba				= $(this).find("RBA").text();
								
								var file_name 		= $(this).find("FILE_NAME").text();
								var set_value		= $(this).find("SET_VALUE").text();
								var avg_run_time	= $(this).find("AVG_RUN_TIME").text();
								var state_result3	= $(this).find("STATE_RESULT3").text();
								var susi_cnt		= $(this).find("SUSI_CNT").text();
								/* var ins_nm1			= $(this).find("INS_NM1").text();
								var approval_nm1	= $(this).find("APPROVAL_NM1").text();
								var approval_nm2	= $(this).find("APPROVAL_NM2").text(); */
								var appl_type		= $(this).find("APPL_TYPE").text();
								var appl_form		= $(this).find("APPL_FORM").text();
								
								var late_exec		= $(this).find("LATE_EXEC").text();
								var smart_job_yn    = $(this).find("SMART_JOB_YN").text();
								
								var cm_log 			= "<img src='<%=sContextPath %>/images/icon_lst3.png' width='20' height='20'>";
								var ctm_why 		= "<img src='<%=sContextPath %>/images/icon_lst5.png' width='20' height='20'>";12
								var job_graph 		= "<img src='<%=sContextPath %>/images/icon_lst24.png' width='20' height='20'>";
								var sys_out 		= "<img src='<%=sContextPath %>/images/icon_lst4.png' width='20' height='20'>";
								var sys_out_down	= "[다운]";

								var job_action = "";
								
								job_action += "<div><select name='job_action' id='job_action'>";
								job_action += "<option value=''>--변경할 상태 선택--</option>";
								for(var j=0;j<arr_job_action.length;j++){
									job_action += "<option>"+arr_job_action[j].cd+"</option>";
								}
								job_action += "</select></div>";

								if(state == 'Job Fail'){
									$('.grid-canvas').children('div').eq(i).css("background","lightpink");
								}

								if(task_type == 'Job') task_type = 'Script';
								
								if(appl_type == "KBN062023") task_type = 'Kubernetes';
								
								var v_check_idx = "";
								
								v_check_idx = 	"<div class='gridInput_area'><input type='checkbox' name='check_idx' value='"+order_id+"' ></div>";
								v_check_idx	+= 	"<input type='hidden' name='check_data_center_idx' value='"+data_center_items+"' >";
								v_check_idx	+= 	"<input type='hidden' name='check_job_name_idx' value='"+job_name+"' >";
								v_check_idx	+= 	"<input type='hidden' name='check_table_name_idx' value='"+table_name+"' >";
								v_check_idx	+= 	"<input type='hidden' name='check_application_idx' value='"+application+"' >";
								v_check_idx	+= 	"<input type='hidden' name='check_group_name_idx' value='"+group_name+"' >";
								v_check_idx	+= 	"<input type='hidden' name='check_before_status_idx' value='"+state_result3+"' >";
								v_check_idx	+= 	"<input type='hidden' name='check_description_idx' value='"+description+"' >";
								v_check_idx	+= 	"<input type='hidden' name='check_odate_idx' value='"+odate+"' >";

								//작업종류
								if ( susi_cnt > 0 ) {
									jobschedgb_ment = "수시오더";
								} else {
									if (user_daily != "") { 
										jobschedgb_ment = "정기";
									} else if (user_daily == "") {
										jobschedgb_ment = "비정기";
									}
								}
								
								var smart_folder = "";
								if ( smart_job_yn == "Y" ) {
									smart_folder = "<img src='/imgs/smart_folder.png' style='vertical-align:middle;' width='20' height='20'> ";
								}
								
								var runTime = convertRunTimeToSeconds(run_time)
								var avgRunTime = convertRunTimeToSeconds(avg_run_time)
								var lateExec = convertLateExecToSeconds(late_exec);
								
									if(runTime > avgRunTime+10) {
// 								        changeColor = 'red';
// 								        changeColor2 = 'black';
// 								        start_time = start_time.replace("#FF0000", "black");
// 								        job_name = job_name.replace("#FF0000", "black");
// 								        state_result = state_result.replace("#FF0000", "black");
								    } else if (runTime > lateExec && lateExec > 0) {
								        changeColor = 'Mistyrose';
								        changeColor2 = 'red';
								    } else {
								        changeColor = 'white';
								        changeColor2 = 'red';
								    }	
// 								}

								rowsObj.push({
									'changeColor': changeColor
									,'changeColor2': changeColor2
									,'check_idx':v_check_idx
									,'grid_idx':i+1+startRowNum
									,'ODATE': odate
									,'START_TIME': start_time
									,'END_TIME': end_time
									,'RUN_TIME': run_time
									,'DIFF_TIME': diff_time
									,'RUN_CNT': run_cnt
									,'DESCRIPTION': description
									,'USER_NM' : user_nm
									,'JOB_NAME': job_name
									,'ORDER_ID': order_id
									,'STATE_RESULT': state_result
									,'JOB_ACTION': job_action
									,'CM_LOG': cm_log
									,'SYS_OUT': sys_out
									,'SYS_OUT_DOWN': sys_out_down
									,'CTM_WHY': ctm_why
									,'GRAPH': job_graph
									,'ACTIVE_GB': active_gb
									,'MEM_NAME': mem_name
									,'NODE_ID': node_id
									,'CALENDAR_NM': calendar_nm
									,'END_DATE': end_date
									,'TABLE_NAME': smart_folder + table_name
									,'APPLICATION': application
									,'GROUP_NAME': group_name
									,'FROM_TIME': from_time
									,'DEPT_NM': dept_nm
									,'JOBSCHEDGB': jobschedgb_ment
									,'SET_VALUE': set_value
									,'AVG_RUN_TIME': avg_run_time
									/* ,'INS_NM1': ins_nm1
									,'APPROVAL_NM1': approval_nm1
									,'APPROVAL_NM2': approval_nm2 */
									,'APPL_TYPE': appl_type
									,'APPL_FORM': appl_form
									,'TASK_TYPE':task_type
									,'RBA':rba
								});
								
							});						
						}
						
						gridObj.rows = rowsObj;
						setGridRows(gridObj);
						
						setTimeout(function() {
						    $('.grid-canvas').children('div').each(function(i) {
						        if (i < rowsObj.length && rowsObj[i].changeColor) {
						            $(this).css("background", rowsObj[i].changeColor);
						        }
						    });
						}, 0);
						
						//컬럼 자동 조정 기능
						$('body').resizeAllColumns();
						$('#ly_total_cnt').html('[ TOTAL : '+parseInt(gridObj.rows.length)+'/'+items.attr('total')+']');
						if( parseInt(gridObj.rows.length) != items.attr('total') ) {
							listChk = true;
						}else{
							listChk = false;
						}
					});
					try{viewProgBar(false);}catch(e){}
				}
		, null );
		
		xhr.sendRequest();
	}
	
	function convertRunTimeToSeconds(run_time) {
	    let timeParts = run_time.split(":");
	    let hours = parseInt(timeParts[0], 10);
	    let minutes = parseInt(timeParts[1], 10);
	    let seconds = parseInt(timeParts[2], 10);

	    return (hours * 3600) + (minutes * 60) + seconds;
	}

	function convertLateExecToSeconds(late_exec) {
	    return late_exec * 60;
	}
	
	function goExcel(){

		var frm = document.f_s;
		
		frm.order_id.value = "";
		
		frm.action = "<%=sContextPath %>/tWorks.ez?c=ez009_excel";
		frm.target = "if1";
		frm.submit();
	}
	function goReport(){
		
		if ( !confirm("OP보고서는 기간에 따라 부하가 있을 수 있습니다.\n진행 하시겠습니까?"))

		var frm = document.f_s;		
		frm.action = "<%=sContextPath %>/mEm.ez?c=ez041_report";
		frm.target = "if1";
		frm.submit();
	}
	function goTxtDown(){
		var frm = document.f_s;
		
		frm.action = "<%=sContextPath %>/tWorks.ez?c=ez009_txt";
		frm.target = "if1";
		frm.submit();
	}
	
	function fn_only_num(obj) {
		if ( !isOnlyNum(obj.value) && event.keyCode != 8 ) {			
			alert("숫자만 입력가능합니다.");
			obj.value = obj.value.substring(0, obj.value.length - 1);			
			eval("document.frm1."+obj.name+".focus()");
			return;
		}
	}
				
	function popupSysout(order_id){
		var frm = document.f_s;
		
		frm.order_id.value = order_id;
		
		openPopupCenter3("about:blank","popupSysout",800,500);
		
		frm.action = "<%=sContextPath %>/mPopup.ez?c=ez007";
		frm.target = "popupSysout";
		frm.submit();
	}
		
	function popupAjobInfo(order_id, job_name) {
		
		var frm = document.f_s;

		frm.order_id.value = order_id;
		frm.job_name.value = job_name;
		
		openPopupCenter("about:blank","popupAjobInfo1", 1100, 750);
		
		frm.action = "<%=sContextPath %>/tPopup.ez?c=ez033";
		frm.target = "popupAjobInfo1";
		frm.submit();
	}
	
	function popupSmartTreeInfo(order_id, job_name, rba, odate, task_type) {
		odate = odate.replace(/\//g, "");
		
		var frm = document.f_s;

		frm.order_id.value = order_id;
		frm.job_name.value = job_name;
		frm.rba.value = rba;
		frm.odate.value = odate;
		frm.task_type.value = task_type;
		
		
		openPopupCenter("about:blank","popupSmartTreeInfo", 600, 350);
		
		frm.action = "<%=sContextPath %>/tPopup.ez?c=ez036";
		frm.target = "popupSmartTreeInfo";
		frm.submit();
	}
	
	function popupTimeInfo(job_name,memname){
		var frm = document.f_s;
		frm.job_name.value = job_name;
		frm.memname.value = memname;
		
		openPopupCenter("about:blank","popupTimeInfo", 670, 550);
		
		frm.action = "<%=sContextPath %>/mPopup.ez?c=ez003";
		frm.target = "popupTimeInfo";
		frm.submit();
	}

	function popTimeInfoForm(job_name, order_id) {
		
		$("#f_s").find("input[name='job_name']").val(job_name);
		$("#f_s").find("input[name='order_id']").val(order_id);
		
		var sHtml1="<div id='dl_tmp1' style='overflow:hidden;display:none;padding:0;'>";
		sHtml1+="<form id='form1' name='form1' method='post' onsubmit='return false;'>";		
		sHtml1+="<table style='width:100%;height:480px;;border:none;'><tr><td style='vertical-align:top;height:100%;width:750px;'>";		
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
		
		dlPop01('dl_tmp1', "실행횟수 별 조회", 750, 500, false);
				
		var gridObj = {
			id : "g_tmp1"
			,colModel:[
		   		{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'번호',width:40,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
		   		,{formatter:gridCellNoneFormatter,field:'JOB_NAME',id:'JOB_NAME',name:'작업명',width:180,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
		   		,{formatter:gridCellNoneFormatter,field:'ODATE',id:'ODATE',name:'ODATE',width:80,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
		   		,{formatter:gridCellNoneFormatter,field:'START_TIME',id:'START_TIME',name:'시작일시',width:130,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
		   		,{formatter:gridCellNoneFormatter,field:'END_TIME',id:'END_TIME',name:'종료일시',width:130,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
		   		//,{formatter:gridCellNoneFormatter,field:'DIFF_TIME',id:'DIFF_TIME',name:'수행시간',width:90,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
		   		,{formatter:gridCellNoneFormatter,field:'RERUN_COUNTER',id:'RERUN_COUNTER',name:'실행횟수',width:60,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
		   		,{formatter:gridCellNoneFormatter,field:'STATE_RESULT',id:'STATE_RESULT',name:'상태',width:105,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
		   	]
			,rows:[]
			,vscroll:false
		};
		
		viewGrid_color(gridObj,'ly_'+gridObj.id);
		timeInfoList();
	
	}
	
	function timeInfoList(){
			
		try{viewProgBar(true);}catch(e){}
		$('#ly_total_cnt_1').html('');
		
		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=activeStartTimeList&itemGubun=2';
		
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
							
								var odate 			= $(this).find("ODATE").text();
								var start_time 		= $(this).find("START_TIME").text();
								var end_time 		= $(this).find("END_TIME").text();
								//var diff_time 		= $(this).find("DIFF_TIME").text();
								var state_result 	= $(this).find("STATE_RESULT").text();
								var rerun_counter 	= $(this).find("RERUN_COUNTER").text();
								var job_name	 	= $(this).find("JOB_NAME").text();
																															
								rowsObj.push({
									'grid_idx':i+1
									,'ODATE': odate
									,'START_TIME': start_time
									,'END_TIME': end_time
									//,'DIFF_TIME': diff_time
									,'STATE_RESULT': state_result
									,'RERUN_COUNTER': rerun_counter
									,'JOB_NAME': job_name
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
							$("select[name='node_id'] option").remove();
							$("select[name='node_id']").append("<option value=''>--선택--</option>");	
						}else{
							$("select[name='node_id'] option").remove();
							$("select[name='node_id']").append("<option value=''>--선택--</option>");			
							
							items.find('item').each(function(i){						
							
								var host_cd = $(this).find("HOST_CD").text();								
								var node_id = $(this).find("NODE_ID").text();
								var node_nm = $(this).find("NODE_NM").text();
								
								var all_cd = host_cd+","+node_id;
								var all_nm = node_nm+"("+node_id+")";
																
								$("select[name='node_id']").append("<option value='"+all_cd+"'>"+all_nm+"</option>");
								
							});						
						}
												
					});
					try{viewProgBar(false);}catch(e){}
				}
		, null );
		
		xhr.sendRequest();
	}
	
	//수행서버내역 가져오기 - 폴더에 권한 매핑(22.08.01 김은희)
	function mHostList(data_center, grp_nm){
	
		try{viewProgBar(true);}catch(e){}
				
		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=mHostList&itemGubun=2&data_center='+data_center+'&grp_nm='+grp_nm;
		
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
							$("select[name='node_id'] option").remove();
							$("select[name='node_id']").append("<option value=''>--선택--</option>");	
						}else{
							$("select[name='node_id'] option").remove();
							$("select[name='node_id']").append("<option value=''>--선택--</option>");			
							
							items.find('item').each(function(i){						
							
								var host_cd = $(this).find("HOST_CD").text();								
								var node_id = $(this).find("NODE_ID").text();
								var node_nm = $(this).find("NODE_NM").text();
								
								var all_cd = host_cd+","+node_id;
								var all_nm = node_nm+"("+node_id+")";
																
								$("select[name='node_id']").append("<option value='"+all_cd+"'>"+all_nm+"</option>");
								
							});						
						}
												
					});
					try{viewProgBar(false);}catch(e){}
				}
		, null );
		
		xhr.sendRequest();
	}
	
	function selectTable(eng_nm, desc, user_daily, grp_cd, task_type, table_id){
		
		$("#table_nm").val(eng_nm);
		$("#table_of_def").val(eng_nm);
		
		dlClose("dl_tmp1");
		
		$("#f_s").find("input[name='p_sched_table']").val(eng_nm);
		$("#f_s").find("input[name='p_application_of_def']").val("");
		$("#f_s").find("input[name='p_group_name_of_def']").val("");

		/* $("#f_s").find("input[name='p_application_of_def_text']").val("");
		$("#f_s").find("input[name='p_group_name_of_def_text']").val("");

		$("#frm1").find("input[name='application_of_def_text']").val("");
		$("#frm1").find("input[name='group_name_of_def_text']").val(""); */

		var data_center = $("select[name='data_center_items'] option:selected").val();
		
		//어플리케이션 초기화
		$("select[name='application_of_def'] option").remove();
		$("select[name='application_of_def']").append("<option value=''>--선택--</option>");

		//그룹초기화
		$("select[name='group_name_of_def'] option").remove();
		$("select[name='group_name_of_def']").append("<option value=''>--선택--</option>");
		
		//스마트폴더 초기화
		$("select[name='sub_table_of_def'] option").remove();
		$("select[name='sub_table_of_def']").append("<option value=''>--선택--</option>");
        
		//서브폴더 조회
		document.getElementById('sub_table_of_def').style.display = 'none';
    	var arr_task_type = task_type.split(",");
    	var arr_table_id  = table_id.split(",");
    	var smart_table_id = new Array(0);
    	
    	for(var i = 0; i < arr_task_type.length; i++) {
    		if(arr_task_type[i] == "SMART Table"){
    			smart_table_id.push(arr_table_id[i]);
    		}
    	}
    	
    	if(!eng_nm.includes(",") && smart_table_id.length == 1){ // 조회할 폴더가 스마트폴더 한개일때 서브폴더 조회 필터 활성화
    		document.getElementById('sub_table_of_def').style.display = 'inline';
			getSubTableList("sub_table_of_def", smart_table_id);
    	}else if(eng_nm.includes(",") && smart_table_id.length > 0 ){ // 조회할 폴더가 스마트폴더를 포함하고 있을때 서브폴더 조회 필터 비활성화
    		getSubTableList("sub_table_of_def", smart_table_id);
    	}
		
		$("select[name='node_id'] option").remove();
		$("select[name='node_id']").append("<option value=''>--선택--</option>");
		
		// 어플리케이션, 그룹 자동 셋팅
		if(eng_nm.indexOf(",") == -1) { // 한개의 폴더 검색일 때
			getAppGrpCodeList("application_of_def", "2", "", grp_cd); // 어플리케이션을 검색
			mHostList(data_center, eng_nm); // 수행서버 검색
			
			// 어플이 하나만 존재하면 자동 세팅
			if($("select[name='application_of_def'] option").length == 2){
				$("select[name='application_of_def'] option:eq(1)").prop("selected", true);
				
				var grp_info = $("select[name='application_of_def']").val().split(",");
				$("#p_application_of_def").val(grp_info[1]);
				
				if (grp_info != "") {
					getAppGrpCodeList("group_name_of_def", "3", "", grp_info[0]);
				} else {
					getAppGrpCodeList("group_name_of_def", "3", "", "");
				}
				
				// 그룹이 하나만 존재하면 자동 세팅
				if($("select[name='group_name_of_def'] option").length == 2){
					$("select[name='group_name_of_def'] option:eq(1)").prop("selected", true);
					grp_info = $("select[name='group_name_of_def']").val().split(",");
					$("#p_group_name_of_def").val(grp_info[1]);
				}
			}
		}else {
			mHostList(data_center,'');
		}
		
	}
	
	function selectTable2(eng_nm, desc){

		$("#table_nm").val(eng_nm);
		$("#table_of_def").val(eng_nm);	
		
		dlClose("dl_tmp1");

		$("#f_s").find("input[name='p_sched_table']").val(eng_nm);
		$("#f_s").find("input[name='p_application_of_def']").val("");
		$("#f_s").find("input[name='p_group_name_of_def']").val("");
		
		getAppGrpCodeList("", "2", "", "application_of_def", eng_nm);

		$("select[name='group_name_of_def'] option").remove();
		$("select[name='group_name_of_def']").append("<option value=''>--선택--</option>");
		
		$("select[name='node_id'] option").remove();
		$("select[name='node_id']").append("<option value=''>--선택--</option>");
		
	}
	
	//상태에 대한 멀티콤보
	function multi_combo_init() {
		
		var multi_combo_JSON = new Array();

		<%
			String job_status = CommonUtil.getMessage("JOB_STATUS");
			String[] arr_job_status = job_status.split(",");

			out.println("multi_combo_JSON.push({id : 'ALL', title : '전체'});");

			for(int i = 0; i < arr_job_status.length; i++) {
				out.println("multi_combo_JSON.push({id : '" + arr_job_status[i] + "', title : '" + CommonUtil.getMessage("JOB_STATUS."+arr_job_status[i].replaceAll(" ","_")) + "'});");
			}
		%>

        multi_combo_status = $("#multi_combo_status").comboTree({
          source : multi_combo_JSON,
    			isMultiple: true,
    			cascadeSelect: false,
    			<%if(strStatus2.equals("Wait")){%>
    				selected:['Wait Resource', 'Wait User', 'Wait Workload', 'Wait Host', 'Wait Time', 'Wait Condition']
    			<%}else{%>
                	selected:['<%=strStatus2%>']
    			<%}%>
        })
	}

	function valid_chk(flag) {

		var frm = document.frm2;
		
		frm.data_center_code.value 	= $("#f_s").find("input[name='data_center_code']").val();
		frm.active_net_name.value 	= $("#f_s").find("input[name='active_net_name']").val();

		var job_status = $("select[name='job_status'] option:selected").val();

		var doc_gb			= "";
		
		var check_idx 		= document.getElementsByName("check_idx");
		var order_id 		= "";
		var check_order_id 	= "";
		var check_cnt		= 0;
		
		var check_data_center_idx	= document.getElementsByName("check_data_center_idx");
		var data_center				= "";
		var check_data_center	 	= "";

		var check_job_name_idx		= document.getElementsByName("check_job_name_idx");
		var job_name				= "";
		var check_job_name	 		= "";
		
		var check_table_name_idx	= document.getElementsByName("check_table_name_idx");
		var table_name				= "";
		var check_table_name 		= "";

		var check_application_idx	= document.getElementsByName("check_application_idx");
		var application				= "";
		var check_application	 	= "";
		
		var check_group_name_idx	= document.getElementsByName("check_group_name_idx");
		var group_name				= "";
		var check_group_name 		= "";

		var check_before_status_idx	= document.getElementsByName("check_before_status_idx");
		var before_status			= "";
		var check_before_status 	= "";
		
		var check_description_idx	= document.getElementsByName("check_description_idx");
		var description				= "";
		var check_description 		= "";
		
		var check_odate_idx			= document.getElementsByName("check_odate_idx");
		var odate					= "";
		var check_odate 			= "";

		var apply_exe_date			= "";

		for ( var i = 0; i < check_idx.length; i++ ) {
			if(check_idx.item(i).checked) {

				order_id 			= check_idx.item(i).value;
				check_order_id		= check_order_id + "|" + order_id;
				
				data_center			= check_data_center_idx.item(i).value;
				check_data_center	= check_data_center + "|" + data_center;

				job_name			= check_job_name_idx.item(i).value;
				check_job_name		= check_job_name + "|" + job_name;
				
				table_name			= check_table_name_idx.item(i).value;
				check_table_name	= check_table_name + "|" + table_name;
				
				application			= check_application_idx.item(i).value;
				check_application	= check_application + "|" + application;

				group_name			= check_group_name_idx.item(i).value;
				check_group_name	= check_group_name + "|" + group_name;
				
				before_status		= check_before_status_idx.item(i).value;
				check_before_status	= check_before_status + "|" + before_status;

				description			= check_description_idx.item(i).value;
				check_description	= check_description + "|" + description;
				
				odate				= check_odate_idx.item(i).value;
				check_odate			= check_odate + "|" + odate.replaceAll("/","");

				doc_gb 				+= "|" + "07";
								
				check_cnt++;
			}
		}
		
		if ( check_cnt == 0 ) {
			alert("변경할 항목을 선택해 주세요.");
			return;
		}
		
		//2건 이상일 경우 일괄요청서 생성
		var noti = "";
		var group_yn = "N";

		if(	check_cnt > 1 ){
			group_yn = "Y";
			noti = "일괄";
		}

		check_order_id 		= check_order_id.substring(1, check_order_id.length);
		check_data_center	= check_data_center.substring(1, check_data_center.length);
		check_job_name 		= check_job_name.substring(1, check_job_name.length);
		check_table_name 	= check_table_name.substring(1, check_table_name.length);
		check_application 	= check_application.substring(1, check_application.length);
		check_group_name 	= check_group_name.substring(1, check_group_name.length);
		check_before_status = check_before_status.substring(1, check_before_status.length);
		check_description 	= check_description.substring(1, check_description.length);
		check_odate 		= check_odate.substring(1, check_odate.length);
		doc_gb 				= doc_gb.substring(1, doc_gb.length);
		apply_exe_date		= odate.replaceAll("/","")

		frm.order_ids.value			= check_order_id;
		frm.data_center.value		= check_data_center;
		frm.odates.value			= check_odate;
		frm.table_name.value		= check_table_name;
		frm.application.value		= check_application;
		frm.group_name.value		= check_group_name;
		frm.job_name.value			= check_job_name;
		frm.before_statuses.value	= check_before_status;
		frm.descriptions.value		= check_description;
		frm.doc_gb.value 			= doc_gb;
		frm.p_apply_date.value		= apply_exe_date;

		frm.group_status.value 		= job_status;
		frm.gubun.value 			= gubun;
		frm.group_yn.value 			= group_yn;

		if(flag == 'draft_admin'){
			goPrc(flag,'','','');
		} else {
			getAdminLineGrpCd(flag, '07');
		}
	}

	//승인요청 마지막 로직
	function goPrc(flag, grp_approval_userList, grp_alarm_userList, title){

		var frm = document.frm2;

		var post_approval_yn 	= "N";

		if ( flag == "draft_admin" ) {
			if( !confirm("즉시반영[관리자결재] 하시겠습니까?") ) return;
		} else if ( flag == "draft" ) {
			if( !confirm("승인요청 하시겠습니까?") ) return;
		} else if ( flag == "post_draft" ) {
			if( !confirm("[후결]승인요청 하시겠습니까?") ) return;
			post_approval_yn 	= "Y";
		}
		
		frm.title.value = title;
		frm.flag.value = flag;
		frm.post_approval_yn.value = post_approval_yn;
		frm.grp_approval_userList.value = grp_approval_userList;
		frm.grp_alarm_userList.value 	= grp_alarm_userList;

		try{viewProgBar(true);}catch(e){}

		clearGridSelected(gridObj);

		//frm.action = "<%=sContextPath %>/tWorks.ez?c=ez022_w";
		frm.action = "<%=sContextPath %>/tWorks.ez?c=ez036";
		frm.target = "if1";	
		frm.submit();
		
		//try{viewProgBar(false);}catch(e){}
	}

</script>

<%@include file="/jsp/common/inc/progBar.jsp"  %>
<iframe name="if1" id="if1" width="0" height="0"></iframe>