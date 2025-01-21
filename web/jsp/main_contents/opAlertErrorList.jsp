<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/jsp/common/inc/header.jsp"%>

<%
	Map<String, Object> paramMap = CommonUtil.collectParameters(request);
	String c = CommonUtil.isNull(paramMap.get("c"));
	String gridId = "g_"+c;

	String menu_gb = CommonUtil.getMessage("CATEGORY.GB.04.GB."+CommonUtil.isNull(paramMap.get("menu_gb")));
	String[] arr_menu_gb = menu_gb.split(",");

	// 세션값 가져오기.
	String strSessionUserCd	 	= S_USER_CD;
	String strSessionDcCode 	= S_D_C_CODE;
	String strSessionTab	 	= S_TAB;
	String strSessionApp        = S_APP;
	String strSessionGrp        = S_GRP;
	String session_user_gb 		= S_USER_GB;

	String strMessage			= CommonUtil.isNull(paramMap.get("message"));
	String strFromDate			= CommonUtil.isNull(paramMap.get("from_date"));
	String strToDate			= CommonUtil.isNull(paramMap.get("to_date"));
	String strODate				= CommonUtil.isNull(paramMap.get("odate"));

	List strOpApprovalList		= (List)request.getAttribute("opApprovalList");

	String strOpApprovalYn		= "";

	if(strOpApprovalList != null) {
		for ( int i = 0; i < strOpApprovalList.size(); i++ ) {
			CommonBean commonBean = (CommonBean) strOpApprovalList.get(i);
			strOpApprovalYn		= commonBean.getScode_eng_nm();
		}
	}

	String strFrom_hostTime		= CommonUtil.isNull(paramMap.get("from_hostTime"));
	String strFrom_odate		= CommonUtil.isNull(paramMap.get("from_odate"));

	//스크롤 페이징
	String strPagingNum			= CommonUtil.getMessage("PAGING.NUM");

	//상단의 오류건수 클릭 여부 확인
	String strTopMenu			= CommonUtil.isNull(paramMap.get("top_menu"));

	String strServerGb 		= CommonUtil.isNull(CommonUtil.getMessage("SERVER_GB"));

	//즉시결재노출 여부 확인
	List adminApprovalBtnList = (List)request.getAttribute("adminApprovalBtnList");
	String strAdminApprovalBtn		= "";
	if ( adminApprovalBtnList != null ) {
		for ( int i = 0; i < adminApprovalBtnList.size(); i++ ) {
			CommonBean commonBean = (CommonBean) adminApprovalBtnList.get(i);
			strAdminApprovalBtn = CommonUtil.isNull(commonBean.getScode_nm());
		}
	}

%>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/SlickGrid-2.1.0/slick.editors.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/SlickGrid-2.1.0/slick.formatters.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/SlickGrid-2.1.0/plugins/slick.autocolumnsize.js" ></script>


<form id="f_s" name="f_s" method="post" onsubmit="return false;">
	<input type='hidden' 	id='data_center_code' 			name='data_center_code'/>
	<input type='hidden' 	id='data_center' 				name='data_center'/>
	<input type='hidden' 	id='active_net_name' 			name='active_net_name' value="${active_net_name}"/>
	<input type='hidden' 	id='p_sched_table' 				name='p_sched_table'/>
	<input type='hidden' 	id='p_application_of_def' 		name='p_application_of_def'/>
	<input type='hidden' 	id='p_group_name_of_def' 		name='p_group_name_of_def'/>
	<input type='hidden' 	id='p_application_of_def_text' name='p_application_of_def_text'/>
	<input type='hidden' 	id='p_search_gubun' 			name='p_search_gubun'/>
	<input type='hidden' 	id='p_search_text' 				name='p_search_text'/>
	<input type='hidden' 	id='p_search_gubun2' 			name='p_search_gubun2'/>
	<input type='hidden' 	id='p_search_text2' 			name='p_search_text2'/>
	<input type='hidden' 	id='searchType' 				name='searchType'/>
	<input type='hidden' 	id='S_USER_NM' 					name='S_USER_NM' 			value="<%=S_USER_NM%>"/>
	<input type="hidden" 	id="p_from_odate" 				name="p_from_odate"/>
	<input type="hidden" 	id="p_to_odate" 				name="p_to_odate"/>
	<input type="hidden" 	id="p_severity" 				name="p_severity"/>
	<input type="hidden" 	id="p_search_action_yn" 		name="p_search_action_yn"/>
	<input type="hidden" 	id="p_search_approval_yn" 		name="p_search_approval_yn"/>
	<input type="hidden" 	id="p_alarm_cd" 				name="p_alarm_cd"/>
	<input type="hidden" 	id="menu_gb"					name="menu_gb"  			value="${paramMap.menu_gb}" />
	<input type="hidden" 	id="p_hold_yn"					name="p_hold_yn"  />

	<input type="hidden" 	name="p_scode_cd" 				id="p_scode_cd" />
	<input type="hidden" 	name="p_message" 				id="p_message" />
	<input type="hidden" 	name="p_grp_depth" 				id="p_grp_depth" />
	<input type="hidden" 	name="p_app_nm" 				id="p_app_nm" />
	<input type="hidden" 	name="p_app_search_gubun" 		id="p_app_search_gubun" />
	<input type="hidden" 	name="p_chk_app"				id="p_chk_app"value = "N"/>
	<input type="hidden" 	name="op_gubun" 				id="op_gubun" value="op"/>
	<input type="hidden" 	name="order_id" 				id="order_id"/>
	<input type="hidden" 	name="date_gubun" 				id="date_gubun"/>

	<input type='hidden' 	name='flag' 					id='flag'/>
	<input type="hidden" 	name="rerun_count" 				id="rerun_count"/>
	<input type="hidden" 	name="end_date" 				id="end_date"/>
	<input type="hidden" 	name="memname" 					id="memname"/>
	<input type="hidden" 	name="node_id" 					id="node_id"/>
	<input type="hidden" 	name="job_name" 				id="job_name"/>
	<input type="hidden" 	name="total_rerun_count" 		id="total_rerun_count"/>
	<input type='hidden' 	name='grp_doc_gb' 				id='grp_doc_gb'/>

	<input type="hidden" 	id="startRowNum"				name="startRowNum"		value="0" />
	<input type="hidden" 	id="pagingNum"					name="pagingNum"	 	value="<%=strPagingNum%>" />
</form>

<form id="form2" name="form2" method="post" onsubmit="return false;">
	<input type='hidden' name='flag' 				id='flag'/>
	<input type="hidden" name="data_center" 		id="data_center"/>
	<input type="hidden" name="user_cd" 			id="user_cd" />
	<input type="hidden" name="action_yn" 			id="action_yn" />
	<input type="hidden" name="confirm_yn" 		id="confirm_yn" />
	<input type="hidden" name="action_gubun" 		id="action_gubun" />
	<input type="hidden" name="error_description" 	id="error_description" />
	<input type="hidden" name="title" 				id="title" />
	<input type="hidden" name="job_name" 			id="job_name" />
	<input type="hidden" name="doc_gb" 			id="doc_gb" 			value="10"/>
	<input type="hidden" name="alarm_cd" 			id="alarm_cd"/>
	<input type="hidden" name="post_approval_yn" 	id="post_approval_yn"/>
	<input type='hidden' name='grp_doc_gb' 		id='grp_doc_gb'			value="10"/>

	<!-- 그룹결재구성원 결재권/알림수신여부	 -->
	<input type="hidden" 	name="grp_approval_userList"  id="grp_approval_userList" />
	<input type="hidden" 	name="grp_alarm_userList"  	  id="grp_alarm_userList" />

	<input type="hidden" 	name="doc_cnt"				  id="doc_cnt"	  			value="0" />
	<input type="hidden" 	name="group_yn"				  id="group_yn"	  			value="" />

</form>

<form id="form3" name="form3" method="post" onsubmit="return false;">
	<input type='hidden' name='data_center' id='data_center'/>
	<input type="hidden" name="order_id" 	id="order_id"/>
</form>

<form id="form4" name="form4" method="post" onsubmit="return false;">
	<input type='hidden' name='data_center' 		id='data_center'/>
	<input type="hidden" name="order_id" 			id="order_id"/>
	<input type="hidden" name="total_rerun_count" 	id="total_rerun_count"/>
	<input type="hidden" name="rerun_count" 		id="rerun_count"/>
	<input type="hidden" name="memname" 			id="memname"/>
	<input type="hidden" name="node_id" 			id="node_id"/>
	<input type="hidden" name="job_name" 			id="job_name"/>
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
							<td width="25%" style="text-align:left">
								<div class='cellContent_kang' style='width:280px;'>
									<select id="data_center_items" name="data_center_items" style="width:120px; height:21px;">
										<option value="">전체</option>
										<c:forEach var="cm" items="${cm}" varStatus="status">
											<option value="${cm.scode_cd},${cm.scode_eng_nm}">${cm.scode_nm}</option>
										</c:forEach>
									</select>
								</div>
							</td>

							<th width="10%"><div class='cellTitle_kang2' style='min-width:120px;'>일자</div></th>
							<td width="25%" style="text-align:left;">
								<div class='cellContent_kang' >
									<select style="width:120px; height:21px;" name="date_gubun" id="date_gubun">
										<option value="odate">ODATE</option>
										<option value="hostTime">발생시간</option>
									</select>
									<input type="text" name="from_odate" id="from_odate" value="${FROM_ODATE}" class="input datepick" style="width:60px; height:21px;" maxlength="8" />
									~<input type="text" name="to_odate" id="to_odate" value="${TO_ODATE}" class="input datepick" style="width:60px; height:21px;" maxlength="8" />
								</div>
							</td>

							<th width="10%"><div class='cellTitle_kang2' style='min-width:120px;'>메세지</div></th>
							<td width="20%" style="text-align:left">
								<div class='cellContent_kang'>
									<select id="message" name="message" style="width:120px; height:21px;">
										<option value=''>--선택--</option>
										<option value="ended not ok">Ended not OK</option>
										<option value="late_sub">LATE_SUB</option>
										<option value="late_time">LATE_TIME</option>
										<option value="late_exec">LATE_EXEC</option>
									</select>
								</div>
							</td>
						</tr>

						<tr>
							<th><div class='cellTitle_kang2'>폴더</div></th>
							<td style="text-align:left">
								<div class='cellContent_kang'>
									<input type="text" name="table_nm" id="table_nm" style="width:114px; height:21px;" onkeydown="return false;" readonly/>&nbsp;
									<select name="sub_table_of_def" id="sub_table_of_def" style="width:120px;height:21px;display:none;">
										<option value="">전체</option>
									</select>
									<img id="btn_clear1" src="/images/sta2.png" style="width:16px;height:16px;vertical-align:middle;cursor:pointer;"/>
									<input type="hidden" name="table_of_def" id="table_of_def" />
								</div>
							</td>

							<th><div class='cellTitle_kang2'>어플리케이션</div></th>
							<td style="text-align:left">
								<div class='cellContent_kang'>
									<select name="application_of_def" id="application_of_def" style="width:120px;height:21px;">
										<option value="">--선택--</option>
									</select>
									<!-- 							<input type='text' id='application_of_def_text' name='application_of_def_text' style="width:115px; height:21px;"/> -->
									<!-- 							제외:<input type='checkbox' id='chk_app' name='chk_app' value = "N" />&nbsp;&nbsp; -->
								</div>
							</td>

							<th width="10%"><div class='cellTitle_kang2'>그룹</div></th>
							<td width="15%" style="text-align:left">
								<div class='cellContent_kang'>
									<select id="group_name_of_def" name="group_name_of_def" style="width:120px; height:21px;">
										<option value=''>--선택--</option>
									</select>
								</div>
							</td>
						</tr>

						<tr>
							<th width="10%"><div class='cellTitle_kang2'>조건1</div></th>
							<td width="20%" style="text-align:left">
								<div class='cellContent_kang'>
									<select name="search_gubun" id="search_gubun" style="width:120px; height:21px;">
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
									<input type="text" name="search_text" value="" id="search_text" class="input" style="width:150px; height:21px;"/>
								</div>
							</td>

							<th width="10%"><div class='cellTitle_kang2'>조건2</div></th>
							<td width="20%" style="text-align:left">
								<div class='cellContent_kang'>
									<select name="search_gubun2" id="search_gubun2" style="width:120px; height:21px;">
										<option value="job_name">작업명</option>
										<option value="error_description">오류 조치</option>
									</select>
									<input type="text" name="search_text2" value="" id="search_text2" class="input" style="width:150px; height:21px;"/>
								</div>
							</td>
							<% if ( !strOpApprovalYn.equals("N")) { %>
							<th width="10%"><div class='cellTitle_kang2'>결재여부</div></th>
							<td width="15%" style="text-align:left">
								<div class='cellContent_kang'>
									<select name="search_approval_yn" style="width:120px; height:21px;">
										<option value="">--선택--</option>
										<option value="Y">Y</option>
										<option value="N">N</option>
									</select>
									<span id='btn_search' style='float:right;margin:3px;'>검 색</span>
								</div>
							</td>
							<% } else {%>
							<th width="10%"><div class='cellTitle_kang2'>처리여부</div></th>
							<td width="15%" style="text-align:left">
								<div class='cellContent_kang'>
									<select name="search_action_yn" style="width:120px; height:21px;">
										<option value="">--선택--</option>
										<option value="Y">Y</option>
										<option value="N">N</option>
									</select>
									<span id='btn_search' style='float:right;margin:3px;'>검 색</span>
								</div>
							</td>
							<% } %>
						</tr>
					</table>
				</h4>
			</form>
		</td>
	</tr>
	<tr style="height:10px;">
		<td style="text-align:left;">
				<span style='float:right;font-weight: bold'>
					Cycle제거 <input type='checkbox' name='hold_yn' id='hold_yn'>
					자동 리프레쉬 <input type='checkbox' name='refresh_yn' id='refresh_yn' checked>
                </span>
			</div>
		</td>
	</tr>
	<tr>
		<td id='ly_<%=gridId %>' style='vertical-align:top;' >
			<div id="<%=gridId %>" class="ui-widget-header ui-corner-all" ></div>
		</td>
	</tr>
	<tr style='height:10px;'>
		<td style='vertical-align:top;'>
			<h4 class="ui-widget-header ui-corner-all" >
				<div align='right' class='btn_area' >
					<div id='ly_total_cnt' style='padding-top:5px;float:left;'></div>
					<span id="btn_draft" style='display:none;'>승인요청</span>
					<span id="btn_draft_admin" style='display:none;'>관리자즉시결재</span>
					<span id="btn_all_udt" style='display:none;'>오류처리</span>
					<span id="btn_down">엑셀다운</span>
				</div>
			</h4>
		</td>
	</tr>
</table>
<script>

	var listChk = false;

	function gridCellCustomFormatter(row,cell,value,columnDef,dataContext){

		var ret 			= "";
		var session_dc_code = "";
		var arr_dt 			= "";

		var alarm_cd 		= getCellValue(gridObj,row,'ALARM_CD');
		var job_name 		= getCellValue(gridObj,row,'JOB_NAME');
		var ori_error_gubun = getCellValue(gridObj,row,'ORI_ERROR_GUBUN');
		var order_id 		= getCellValue(gridObj,row,'ORDER_ID');
		var run_counter 	= getCellValue(gridObj,row,'RUN_COUNTER');
		var order_id 		= getCellValue(gridObj,row,'ORDER_ID');
		var mem_name 		= getCellValue(gridObj,row,'MEM_NAME');
		var node_id 		= getCellValue(gridObj,row,'NODE_ID');
		var job_name 		= getCellValue(gridObj,row,'JOB_NAME');
		var approval_yn		= getCellValue(gridObj,row,'APPROVAL_YN');

		if(columnDef.id == 'JOB_NAME'){
			ret = "<a href=\"JavaScript:alertErrorDetail('"+alarm_cd+"','"+job_name+"','"+ori_error_gubun+"','"+approval_yn+"');\" /><font color='red'>"+value+"</font></a>";
		}

		return ret;
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

	var gridObj = {
		id : "<%=gridId %>"
		,colModel:[
			{formatter:gridCellNoneFormatter,field:'check_idx',id:'check_idx',name:'<input type="checkbox" name="checkIdxAll" id="checkIdxAll" onClick="checkAll();">',width:30,minWidth:30,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:false}
			,{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'번호',width:50,minWidth:50,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
			,{formatter:gridCellNoneFormatter,field:'JOBSCHEDGB',id:'JOBSCHEDGB',name:'작업종류',width:70,minWidth:70,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
			,{formatter:gridCellNoneFormatter,field:'ODATE',id:'ODATE',name:'ODATE',minWidth:80,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
			,{formatter:gridCellNoneFormatter,field:'ORDER_TABLE',id:'ORDER_TABLE',name:'폴더',width:150,minWidth:150,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
			,{formatter:gridCellCustomFormatter,field:'JOB_NAME',id:'JOB_NAME',name:'작업명',width:200,minWidth:200,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
			,{formatter:gridCellNoneFormatter,field:'RUN_COUNTER',id:'RUN_COUNTER',name:'수행횟수',width:70,minWidth:70,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
			,{formatter:gridCellNoneFormatter,field:'CYCLIC',id:'CYCLIC',name:'반복여부',width:80,minWidth:80,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
			,{formatter:gridCellNoneFormatter,field:'HOST_TIME',id:'HOST_TIME',name:'발생시간',width:150,minWidth:150,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
			,{formatter:gridCellNoneFormatter,field:'MESSAGE',id:'MESSAGE',name:'메세지',width:150,minWidth:150,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
			,{formatter:gridCellNoneFormatter,field:'USER_NM',id:'USER_NM',name:'담당자',width:100,minWidth:100,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
			<% if ( !strOpApprovalYn.equals("N")) { %>
				,{formatter:gridCellNoneFormatter,field:'APPROVAL_YN',id:'APPROVAL_YN',name:'결재여부',width:60,minWidth:60,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
			<% }else{ %>
				,{formatter:gridCellNoneFormatter,field:'ACTION_YN',id:'ACTION_YN',name:'처리여부',width:60,minWidth:60,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
			<% } %>
			,{formatter:gridCellNoneFormatter,field:'UPDATE_USER_NM',id:'UPDATE_USER_NM',name:'처리자',width:100,minWidth:100,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
			,{formatter:gridCellNoneFormatter,field:'UPDATE_TIME',id:'UPDATE_TIME',name:'처리시간',width:150,minWidth:150,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
// 	   		,{formatter:gridCellNoneFormatter,field:'ACTION_GUBUN',id:'ACTION_GUBUN',name:'ACTION',width:60,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
			,{formatter:gridCellNoneFormatter,field:'ERROR_DESCRIPTION',id:'ERROR_DESCRIPTION',name:'오류 조치',width:150,minWidth:150,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}

			,{formatter:gridCellNoneFormatter,field:'RECUR_YN',id:'RECUR_YN',name:'재발가능성',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
			,{formatter:gridCellNoneFormatter,field:'ERROR_GUBUN',id:'ERROR_GUBUN',name:'오류구분',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
			,{formatter:gridCellNoneFormatter,field:'SOLUTION_DESCRIPTION',id:'SOLUTION_DESCRIPTION',name:'오류원인 및 해결방안',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}

			,{formatter:gridCellNoneFormatter,field:'ALARM_CD',id:'ALARM_CD',name:'ALARM_CD',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
			,{formatter:gridCellNoneFormatter,field:'USER_CD',id:'USER_CD',name:'USER_CD',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
			,{formatter:gridCellNoneFormatter,field:'ORI_ERROR_GUBUN',id:'ORI_ERROR_GUBUN',name:'ORI_ERROR_GUBUN',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
			,{formatter:gridCellNoneFormatter,field:'ORDER_ID',id:'ORDER_ID',name:'ORDER_ID',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
			,{formatter:gridCellNoneFormatter,field:'MEM_NAME',id:'MEM_NAME',name:'MEM_NAME',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
			,{formatter:gridCellNoneFormatter,field:'NODE_ID',id:'NODE_ID',name:'NODE_ID',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
			//,{formatter:gridCellNoneFormatter,field:'JOB_NAME',id:'JOB_NAME',name:'JOB_NAME',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
		]
		,rows:[]
		,vscroll:<%=S_GRID_VSCROLL%>
	};

	$(document).ready(function(){

		var session_dc_code		= "<%=strSessionDcCode%>";
		var table_name			= "<%=strSessionTab%>";
		var application			= "<%=strSessionApp%>";
		var group_name			= "<%=strSessionGrp%>";
		var message				= "<%=strMessage%>";
		var from_odate			= "<%=strFromDate%>";
		var to_odate			= "<%=strToDate%>";
		//var odate				= "<%=strODate%>";
		var Strfrom_hostTime	= "<%=strFrom_hostTime%>";
		var server_gb 			= "<%=strServerGb%>";
		var Strfrom_odate		= "<%=strFrom_odate%>";
		var opApprovalYn		= "<%=strOpApprovalYn%>";
		var session_user_gb 	= "<%=session_user_gb%>";
		var adminApprovalBtn 	= "<%=strAdminApprovalBtn %>";

		//관리자이거나 코드관리(M80) 즉시결재버튼노출 여부가 Y일 경우에 관리자즉시결재 버튼 노출
		if ((session_user_gb == "99" || adminApprovalBtn == "Y") && opApprovalYn == "Y") {
			$("#btn_draft_admin").show();
		} else {
			$("#btn_draft_admin").hide();
		}

		$("#btn_search").show();

		//코드관리 > M92 오류처리 결재여부가 Y일 경우에만 결재진행가능
		if(opApprovalYn == "Y") {
			$("#btn_draft").show();
		}else{
			$("#btn_all_udt").show();
		}
		//$("#btn_all_confirm").show();

		$("#f_s").find("input[name='p_severity']").val($("#frm1").find("input:radio[name='severity']:checked").val());
		$("#f_s").find("input[name='p_search_gubun']").val($("#frm1").find("select[name='search_gubun'] option:selected").val());
		$("#f_s").find("input[name='p_search_gubun2']").val($("#frm1").find("select[name='search_gubun2'] option:selected").val());
		$("#f_s").find("input[name='p_search_text']").val($("#frm1").find("input[name='search_text']").val());
		$("#f_s").find("input[name='p_search_text2']").val($("#frm1").find("input[name='search_text2']").val());
		$("#f_s").find("input[name='p_from_odate']").val($("#frm1").find("input[name='from_odate']").val());
		$("#f_s").find("input[name='p_to_odate']").val($("#frm1").find("input[name='to_odate']").val());
		$("#f_s").find("input[name='p_search_action_yn']").val($("#frm1").find("select[name='search_action_yn'] option:selected").val());
		$("#f_s").find("input[name='p_search_approval_yn']").val($("#frm1").find("select[name='search_approval_yn'] option:selected").val());
		$("#f_s").find("input[name='p_message']").val($("#frm1").find("select[name='message'] option:selected").val());

		viewGrid_1(gridObj,"ly_"+gridObj.id,{enableColumnReorder:true},'AUTO');

		//초기 검색조건 - C-M, 폴더, 어플리케이션, 그룹
		if(session_dc_code != "") {
			arr_dt = session_dc_code.split(",");
			$("select[name='data_center_items']").val(session_dc_code);
			$("#f_s").find("input[name='data_center']").val(arr_dt[1]);
		}else {
			$("#data_center_items option:eq(1)").prop("selected", true);
			arr_dt = $("select[name='data_center_items']").val().split(",");
			$("#f_s").find("input[name='data_center']").val(arr_dt[1]);
		}

		$("select[name='message']").val(message);
		$("#f_s").find("input[name='p_message']").val(message);

		//메인화면의 오류 현황 ODATE 적용
		if(to_odate != '' && from_odate != '') {
			$("input[name='to_odate']").val(to_odate);
			$("#f_s").find("input[name='p_to_odate']").val(to_odate);

			$("input[name='from_odate']").val(from_odate);
			$("#f_s").find("input[name='p_from_odate']").val(from_odate);
		}

		//메인화면의 오류건수 클릭으로 인한 탭이동 from_HostTime, from_ODATE 적용
		if(Strfrom_hostTime != '' && Strfrom_odate != '') {

			$("input[name='from_odate']").val(Strfrom_hostTime);
			$("#f_s").find("input[name='p_from_odate']").val(Strfrom_hostTime);

			$("input[name='to_odate']").val(Strfrom_odate);
			$("#f_s").find("input[name='to_odate']").val(Strfrom_odate);

			$("input[name='search_text']").val("<%=S_USER_NM%>");

			$("select[name=search_action_yn]").val("N");
			$("select[name=search_approval_yn]").val("N");
		}

		if('<%=strTopMenu%>' == 'Y'){
			$("input[name='search_text']").val("<%=S_USER_NM%>");
			$("select[name=search_action_yn]").val("N");
			$("select[name=search_approval_yn]").val("N");
			table_name = "";
		}

		// 개인정보 설정에 폴더 값이 셋팅되어 있을 경우 (2024-11-05 김선중)
		if(table_name != '') {
			var data_center_items = $("select[name='data_center_items'] option:selected").val();
			$("input[name='table_nm']").val(table_name);
			
			if(table_name.indexOf(",") == -1) {
				// 폴더에 매핑되어 있는 어플리케이션, 그룹 목록을 조회 후, 설정 값에 따라 검색필터에 세팅 
				getAppGrpCodeList("application_of_def", "2", application, "", table_name);
				setTimeout(function(){
					var selected_app_grp_cd	= $("#application_of_def option:selected").val().split(",")[0]; //그룹 조회 파라미터.
					if (selected_app_grp_cd != "")
						getAppGrpCodeList("group_name_of_def", "3", group_name, selected_app_grp_cd); //어플리케이션 코드로 그룹 조회 및 그룹 선택.
				}, 1000);
			}
			
			// 작업을 조회할 폴더, 어플리케이션, 그룹 값 세팅
			$("#f_s").find("input[name='p_sched_table']").val(table_name);
			$("#f_s").find("input[name='p_application_of_def']").val(application);
            $("#f_s").find("input[name='p_group_name_of_def']").val(group_name);

			if(!data_center_items == ""){
				setTimeout(function(){
					alertErrorList();
				}, 1000);
			}
		}else{
			var data_center_items 		= $("select[name='data_center_items'] option:selected").val();
			if(!data_center_items == ""){
				setTimeout(function(){
					alertErrorList();
				}, 1000);
			}
		}

		if($("select[name='data_center_items'] option:selected").val()!=''){
			alertErrorList();
		}

		$("#btn_search").button().unbind("click").click(function(){
			setTimeout(function(){
				alertErrorList();
			}, 1000);
		});

		$('#search_text').unbind('keypress').keypress(function(e){
			if(e.keyCode==13){
				alertErrorList();
			}
		});

		//조건2(작업명/작업설명) 분리
		$('#search_text2').unbind('keypress').keypress(function(e){
			if(e.keyCode==13){
				alertErrorList();
			}
		});

		$("#data_center_items").change(function(){

			//초기화
			$("#table_nm").val("");
			$("#table_of_def").val("");

			$("#f_s").find("input[name='p_sched_table']").val("");
			$("#f_s").find("input[name='p_application_of_def']").val("");
			$("#f_s").find("input[name='p_group_name_of_def']").val("");

			$("select[name='application_of_def'] option").remove();
			$("select[name='application_of_def']").append("<option value=''>--선택--</option>");

			$("select[name='group_name_of_def'] option").remove();
			$("select[name='group_name_of_def']").append("<option value=''>--선택--</option>");

			var data_center_items = $(this).val();
			var arr_dt = data_center_items.split(",");
// 			if($(this).val() != ""){
			$("#f_s").find("input[name='data_center']").val(arr_dt[1]);
			//getAppGrpCodeList(arr_dt[0], "1", "", "application_of_def","");
// 			}
		});
		
		$("#date_gubun").change(function(){
			var date_gubun = $(this).val();
			$("#f_s").find("input[name='date_gubun']").val(date_gubun);
		});

		$("#btn_down").button().unbind("click").click(function(){
			goExcel();
		});

		$("#from_odate").addClass("text_input").unbind('click').click(function(){
			dpCalMin(this.id,'yymmdd');
		});

		$("#to_odate").addClass("text_input").unbind('click').click(function(){
			dpCalMin(this.id,'yymmdd');
		});

		$("#btn_all_udt").button().unbind("click").click(function(){
			valid_chk('udt_all');
		});

		$("#btn_draft_admin").button().unbind("click").click(function(){
			valid_chk('draft_admin');
		});

		$("#btn_draft").button().unbind("click").click(function(){
			valid_chk('draft');
		});

		$("#btn_all_confirm").button().unbind("click").click(function(){

			if(confirm("해당 내용을 일괄 확인 하시겠습니까?")){

				var f = document.form2;
				var alarm_cd 	= "";
				var user_cd 	= "";
				var aSelRow = new Array;
				aSelRow = $('#'+gridObj.id).data('grid').getSelectedRows();

				if(aSelRow.length>0){
					for(var i=0;i<aSelRow.length;i++){
						alarm_cd 	= alarm_cd  + "," + getCellValue(gridObj,aSelRow[i],'ALARM_CD');
						user_cd 	= user_cd  + "," + getCellValue(gridObj,aSelRow[i],'USER_CD');
					}

				}else{
					alert("작업을 선택해 주세요.");
					return;
				}

				alarm_cd 	 	= alarm_cd.substring(1, alarm_cd.length);
				user_cd 	 	= user_cd.substring(1, user_cd.length);

				f.alarm_cd.value 			= alarm_cd;
				f.user_cd.value 			= user_cd;
				f.confirm_yn.value 			= $('#all_confirm_yn').val();
				f.error_description.value 	= $('#error_description').val();

				try{viewProgBar(true);}catch(e){}

				f.flag.value = "confirm_all";
				f.target = "if1";
				f.action = "<%=sContextPath %>/aEm.ez?c=ez003_p_all";
				f.submit();
				clearGridSelected(gridObj);		//선택된 전체항목 해제 */
				try{viewProgBar(false);}catch(e){}

			}
		});

		//테이블 클릭 시
		$("#table_nm").click(function(){
			var data_center = $("select[name='data_center_items'] option:selected").val();
			var select_table = $("input[name='table_nm']").val();

// 			if(data_center == ""){
// 				alert("C-M 을 선택해 주세요.");
// 				return;
// 			}else{
// 				searchPoeTabForm();
// 			}
			searchPoeTabForm(select_table);
		});

		$("#application_of_def").change(function(){
			$("#group_name_of_def option").remove();
			$("#group_name_of_def").append("<option value=''>--선택--</option>");

			var grp_info = $(this).val().split(",");

			$("#p_application_of_def").val(grp_info[1]);
			$("#p_group_name_of_def").val("");

			if (grp_info != "")
				getAppGrpCodeList("group_name_of_def", "3", "", grp_info[0]);

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

		$("#btn_clear1").unbind("click").click(function(){

			$("#f_s").find("input[name='p_sched_table']").val("");
			$("#f_s").find("input[name='p_application_of_def']").val("");
			$("#f_s").find("input[name='p_group_name_of_def']").val("");

			$("#frm1").find("input[name='table_nm']").val("");
			$("#frm1").find("input[name='table_of_def']").val("");

			$("#f_s").find("input[name='p_application_of_def_text']").val("");
			$("#f_s").find("input[name='p_group_name_of_def_text']").val("");

			$("#frm1").find("input[name='application_of_def_text']").val("");
			$("#frm1").find("input[name='group_name_of_def_text']").val("");

			$("select[name='application_of_def'] option").remove();
			$("select[name='application_of_def']").append("<option value=''>--선택--</option>");

			$("select[name='group_name_of_def'] option").remove();
			$("select[name='group_name_of_def']").append("<option value=''>--선택--</option>");
			
			$("select[name='sub_table_of_def'] option").remove();
			$("select[name='sub_table_of_def']").append("<option value=''>--선택--</option>");
			
			document.getElementById('sub_table_of_def').style.display = 'none';

		});

		$("#btn_clear2").unbind("click").click(function(){
			$("#frm1").find("input[name='search_text']").val("");
		});

		$('#application_of_def_text').on('keyup', function(event) {
			var app_text = $(this).val().replace(/ /gi, '');
			$('#p_application_of_def_text').val(app_text);
		});
		$('#group_name_of_def_text').on('keyup', function(event) {
			var app_text = $(this).val().replace(/ /gi, '');
			$('#p_group_name_of_def_text').val(app_text);
		});

		setInterval(function(){
			var data_center_items 		= $("select[name='data_center_items'] option:selected").val();
			var refresh_yn 				= $("input[name='refresh_yn']:checked").val();

			//alertErrorList();

			if ( refresh_yn == "on"  && !data_center_items == "" ) {
				alertErrorList();
			}

		}, 60000);

		//스크롤 페이징
		var grid = $('#'+gridObj.id).data('grid');
		grid.onScroll.subscribe(function(e, args){
			var elem = $("#g_ez003_op").children(".slick-viewport");
			if ( elem[0].scrollHeight - elem.scrollTop() - elem.css("height").replace("px", "") + 17 < 100) {
				if(listChk) {
					listChk = false;
					var startRowNum = parseInt($("#startRowNum").val());
					startRowNum += parseInt($('#pagingNum').val());
					alertErrorList(startRowNum);
				}
// 				alert(elem[0].scrollHeight - elem.scrollTop() - elem.css("height").replace("px", "") + 17);
			}
		});

		alertErrorList();
	});

	function alertErrorList(startRowNum){

		var data_center_items = $("select[name='data_center_items'] option:selected").val();

// 		if(data_center_items == ""){
// 			alert("C-M 을 선택해 주세요.");
// 			return;
// 		}

		$("input[name='hold_yn']").each(function(i){
			if($(this).is(':checked')){
				$("input[name='hold_yn']").eq(i).val('Y');
			}else{
				$("input[name='hold_yn']").eq(i).val('');
			}
		});

		$("#f_s").find("input[name='p_severity']").val($("#frm1").find("input:radio[name='severity']:checked").val());
		$("#f_s").find("input[name='p_search_gubun']").val($("#frm1").find("select[name='search_gubun'] option:selected").val());
		$("#f_s").find("input[name='p_search_gubun2']").val($("#frm1").find("select[name='search_gubun2'] option:selected").val());
		$("#f_s").find("input[name='p_search_text']").val($("#frm1").find("input[name='search_text']").val());
		$("#f_s").find("input[name='p_search_text2']").val($("#frm1").find("input[name='search_text2']").val());
		$("#f_s").find("input[name='p_from_odate']").val($("#frm1").find("input[name='from_odate']").val());
		$("#f_s").find("input[name='p_to_odate']").val($("#frm1").find("input[name='to_odate']").val());
		$("#f_s").find("input[name='p_search_action_yn']").val($("#frm1").find("select[name='search_action_yn'] option:selected").val());
		$("#f_s").find("input[name='p_search_approval_yn']").val($("#frm1").find("select[name='search_approval_yn'] option:selected").val());
		$("#f_s").find("input[name='p_message']").val($("#frm1").find("select[name='message'] option:selected").val());
		$("#f_s").find("input[name='p_hold_yn']").val($("input:checkbox[name='hold_yn']:checked").val());
		$("#f_s").find("input[name='date_gubun']").val($("#frm1").find("select[name='date_gubun'] option:selected").val());

		if ( $("#from_odate").val() != "" && $("#to_odate").val() != "" ) {

			// 날짜 기간 체크
			if ( $("#from_odate").val() > $("#to_odate").val() ) {
				alert("일자의 FROM ~ TO를 확인해 주세요.");
				return;
			}

			// 날짜 정합성 체크
			if(!isValidDate($("#from_odate").val()) || !isValidDate($("#to_odate").val())){
				alert("잘못된 날짜입니다.");
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
			var elem = $("#g_ez003_op").children(".slick-viewport");
			elem.scrollTop(0);
			startRowNum = 0;
			$('#startRowNum').val(0);
		}

		try{viewProgBar(true);}catch(e){}
		$('#ly_total_cnt').html('');

		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=alertErrorList';

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

						if(items.attr('cnt')=='0'){
						}else{
							items.find('item').each(function(i){

								var host_time 			= $(this).find("HOST_TIME").text();
								var data_center 		= $(this).find("DATA_CENTER").text();
								var job_name 			= $(this).find("JOB_NAME").text();
								var run_counter 		= $(this).find("RUN_COUNTER").text();
								var dept_nm 			= $(this).find("DEPT_NM").text();
								var duty_nm 			= $(this).find("DUTY_NM").text();
								var user_nm 			= $(this).find("USER_NM").text();
								var action_yn 			= $(this).find("ACTION_YN").text();
								var approval_yn 		= $(this).find("APPROVAL_YN").text();
								var update_time 		= $(this).find("UPDATE_TIME").text();
// 								var action_gubun 		= $(this).find("ACTION_GUBUN").text();
								var recur_yn 			= $(this).find("RECUR_YN").text();
								var error_gubun 		= $(this).find("ERROR_GUBUN").text();
								var error_desc 			= $(this).find("ERROR_DESCRIPTION").text();
								var solution_desc 		= $(this).find("SOLUTION_DESCRIPTION").text();
								var alarm_cd 			= $(this).find("ALARM_CD").text();
								var user_cd 			= $(this).find("USER_CD").text();
								var message 			= $(this).find("MESSAGE").text();
								/* var critical 			= $(this).find("CRITICAL").text(); */
								var update_user_nm 		= $(this).find("UPDATE_USER_NM").text();
// 								var status 				= $(this).find("STATUS").text();
								var state_result		= $(this).find("STATE_RESULT").text();
								var jobschedgb 			= $(this).find("JOBSCHEDGB").text();
								var user_daily_yn 		= $(this).find("USER_DAILY_YN").text();
								var order_table 		= $(this).find("ORDER_TABLE").text();
								var confirm_yn 			= $(this).find("CONFIRM_YN").text();
								var confirm_user_nm 	= $(this).find("CONFIRM_USER_NM").text();
								var confirm_time 		= $(this).find("CONFIRM_TIME").text();
								var order_id			= $(this).find("ORDER_ID").text();
								var mem_name			= $(this).find("MEM_NAME").text();
								var node_id				= $(this).find("NODE_ID").text();
								var cyclic				= $(this).find("CYCLIC").text();
								var odate 				= $(this).find("ODATE").text();
								var smart_job_yn		= $(this).find("SMART_JOB_YN").text();

								var v_error_gubun 	= "";

								<c:forEach var="codeList" items="${sCodeList}" varStatus="s">
								if(error_gubun == "${codeList.scode_cd}"){
									v_error_gubun = "${codeList.scode_nm}";
								}
								</c:forEach>
								
								var smart_folder = "";
								if ( smart_job_yn == "Y" ) {
									smart_folder = "<img src='/imgs/smart_folder.png' style='vertical-align:middle;' width='20' height='20'> ";
								}

								if(recur_yn == ""){
									recur_yn = "N";
								}
								if(cyclic=='0'){
									cyclic = "N";
								}else{
									cyclic = "Y";
								}

								error_desc = decodeHtmlEntities(error_desc);

								// 정기, 수시 가져오기 (2020.07.20. 강명준)
								// 정기, 비정기 가져오기(2022.11.02. 강명준)
								var jobschedgb_ment		= "";
								var jobschedgb_config	= "<%=CommonUtil.getMessage("USER_DAILY.SYSTEM.GB")%>";
								var jobschedgb_arr 		= jobschedgb_config.split(",");

								for ( var ii = 0; ii < jobschedgb_arr.length; ii++ ) {
									if ( jobschedgb_arr[ii].split("|")[0] == user_daily_yn ) {
										jobschedgb_ment = jobschedgb_arr[ii].split("|")[1];
									}
								}

								//오류처리 state_cd에 따라 처리여부/결재여부 노출 및 체크박스
								var v_check_idx = "";

								if (approval_yn != "Y" && "<%=strOpApprovalYn%>" == "Y" || action_yn != "Y" && "<%=strOpApprovalYn%>" == "N" ) {
									v_check_idx = "<div class='gridInput_area'><input type='checkbox' name='check_idx' value='" + i + 1 + startRowNum + "' ></div>";
									v_check_idx += "<input type='hidden' name='check_data_center_idx' value='" + data_center_items + "' >";
									v_check_idx += "<input type='hidden' name='check_alarm_cd_idx' value='" + alarm_cd + "' >";
									v_check_idx += "<input type='hidden' name='check_user_cd_idx' value='" + user_cd + "' >";
									v_check_idx += "<input type='hidden' name='check_job_name_idx' value='" + job_name + "' >";
								}

								rowsObj.push({
// 									'grid_idx'					: i+1
									'check_idx'					: v_check_idx
									,'grid_idx'					: i+1+startRowNum
									,'HOST_TIME'				: host_time
									,'JOB_NAME'					: job_name
									,'RUN_COUNTER'				: run_counter
									,'USER_NM'					: user_nm
									,'DEPT_NM'					: dept_nm
									,'DUTY_NM'					: duty_nm
									,'ACTION_YN'				: action_yn
									,'APPROVAL_YN'				: approval_yn
									,'RECUR_YN'					: recur_yn
									,'ERROR_GUBUN'				: v_error_gubun
									,'ERROR_DESCRIPTION'		: error_desc
									,'SOLUTION_DESCRIPTION'		: solution_desc
									,'ALARM_CD'					: alarm_cd
									,'USER_CD'					: user_cd
									,'ORI_ERROR_GUBUN'			: error_gubun
// 									,'ACTION_GUBUN'				: action_gubun.toUpperCase()
									,'UPDATE_TIME'  			: update_time
									,'MESSAGE'  				: message
									/* ,'CRITICAL'  				: critical */
									,'UPDATE_USER_NM'			: update_user_nm
// 									,'STATUS'					: state_result
									,'JOBSCHEDGB'				: jobschedgb_ment
									,'ORDER_TABLE'				: smart_folder + order_table
									,'ORDER_ID'					: order_id
									,'MEM_NAME'					: mem_name
									,'NODE_ID'					: node_id
									,'CYCLIC'					: cyclic
									,'ODATE'					: odate

								});
							});
						}

						gridObj.rows = rowsObj;
						setGridRows(gridObj);

						//컬럼 자동 조정 기능
						$('body').resizeAllColumns();
// 						$('#ly_total_cnt').html('[ TOTAL : '+items.attr('cnt')+' ]');

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

	function alertErrorDetail(alarm_cd, job_name, ori_error_gubun, approval_yn) {

		try{viewProgBar(true);}catch(e){}

		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=alertErrorList&gubun=udt';
		$("#f_s").find("input[name='p_alarm_cd']").val(alarm_cd);

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

						var items 	= $(this).find('items');
						var rowsObj = new Array();

						var host_time 		= "";
						var job_name 		= "";
						var action_yn 		= "";
						var approval_yn 	= "";
						var recur_yn 		= "";
						var error_gubun 	= "";
						var error_desc 		= "";
						var solution_desc 	= "";
						var alarm_cd 		= "";
						var user_cd 		= "";
						var user_nm 		= "";

						var user_cd1 		= "";
						var user_nm1	 	= "";
						var user_cd2 		= "";
						var user_nm2 		= "";
						var user_cd3 		= "";
						var user_nm3 		= "";
						var user_cd4 		= "";
						var user_nm4 		= "";
						var user_cd5 		= "";
						var user_nm5 		= "";
						var user_cd6 		= "";
						var user_nm6 		= "";
						var user_cd7 		= "";
						var user_nm7 		= "";
						var user_cd8 		= "";
						var user_nm8 		= "";
						var user_cd9 		= "";
						var user_nm9 		= "";
						var user_cd10 		= "";
						var user_nm10		= "";
						var grp_cd1 		= "";
						var grp_nm1 		= "";
						var grp_cd2 		= "";
						var grp_nm2 		= "";

						var dept_nm 		= "";
						var dept_cd 		= "";
						var duty_nm 		= "";
						var duty_cd 		= "";
						var host_date 		= "";
						var update_time 	= "";
						var application 	= "";

						var order_id 		= "";
						var group_nm		= "";
						var description		= "";
						var mem_nm			= "";
						var node_id			= "";
						var order_table		= "";
						var mem_lib			= "";
						var owner			= "";
						var task_type		= "";

						var owner			= "";
						var task_type		= "";
						var command			= "";
						var max_wait		= "";
						var rerun_max		= "";
						var cyclic			= "";

						var time_from		= "";
						var time_until		= "";
						var cyclic_type		= "";
						var run_cnt			= "";
						var update_user_nm  = "";

						if(items.attr('cnt')=='0'){
						}else{
							items.find('item').each(function(i){

								job_name 			= $(this).find("JOB_NAME").text();
								run_counter 		= $(this).find("RUN_COUNTER").text();
								dept_nm 			= $(this).find("DEPT_NM").text();
								duty_nm 			= $(this).find("DUTY_NM").text();
								user_nm 			= $(this).find("USER_NM").text();
								approval_yn 		= $(this).find("APPROVAL_YN").text();
								action_yn 			= $(this).find("ACTION_YN").text();
								update_time 		= $(this).find("UPDATE_TIME").text();
								recur_yn 			= $(this).find("RECUR_YN").text();
								error_gubun 		= $(this).find("ERROR_GUBUN").text();
								error_desc 			= $(this).find("ERROR_DESCRIPTION").text();
								solution_desc 		= $(this).find("SOLUTION_DESCRIPTION").text();
								alarm_cd		 	= $(this).find("ALARM_CD").text();
								user_cd 			= $(this).find("USER_CD").text();
								user_nm 			= $(this).find("USER_NM").text();

								user_cd1 			= $(this).find("USER_CD1").text();
								user_nm1 			= $(this).find("USER_NM1").text();
								user_cd2 			= $(this).find("USER_CD2").text();
								user_nm2 			= $(this).find("USER_NM2").text();
								user_cd3 			= $(this).find("USER_CD3").text();
								user_nm3 			= $(this).find("USER_NM3").text();
								user_cd4 			= $(this).find("USER_CD4").text();
								user_nm4 			= $(this).find("USER_NM4").text();
								user_cd5 			= $(this).find("USER_CD5").text();
								user_nm5 			= $(this).find("USER_NM5").text();
								user_cd6 			= $(this).find("USER_CD6").text();
								user_nm6 			= $(this).find("USER_NM6").text();
								user_cd7 			= $(this).find("USER_CD7").text();
								user_nm7 			= $(this).find("USER_NM7").text();
								user_cd8 			= $(this).find("USER_CD8").text();
								user_nm8 			= $(this).find("USER_NM8").text();
								user_cd9 			= $(this).find("USER_CD9").text();
								user_nm9 			= $(this).find("USER_NM9").text();
								user_cd10 			= $(this).find("USER_CD10").text();
								user_nm10			= $(this).find("USER_NM10").text();
								grp_cd1 			= $(this).find("GRP_CD1").text();
								grp_nm1 			= $(this).find("GRP_NM1").text();
								grp_cd2 			= $(this).find("GRP_CD2").text();
								grp_nm2 			= $(this).find("GRP_NM2").text();

								dept_nm 			= $(this).find("DEPT_NM").text();
								dept_cd 			= $(this).find("DEPT_CD").text();
								duty_cd 			= $(this).find("DUTY_CD").text();
								duty_nm 			= $(this).find("DUTY_NM").text();
								host_date 			= $(this).find("HOST_TIME2").text();
								application 		= $(this).find("APPLICATION").text();


								order_id 			= $(this).find("ORDER_ID").text();
								group_nm			= $(this).find("GROUP_NAME").text();
								description			= $(this).find("DESCRIPTION").text();
								mem_nm				= $(this).find("MEM_NAME").text();
								node_id				= $(this).find("NODE_ID").text();
								order_table			= $(this).find("ORDER_TABLE").text();
								mem_lib				= $(this).find("MEM_LIB").text();
								owner				= $(this).find("OWNER").text();
								task_type			= $(this).find("TASK_TYPE").text();

								owner				= $(this).find("OWNER").text();
								task_type			= $(this).find("TASK_TYPE").text();
								command				= $(this).find("COMMAND").text();
								max_wait			= $(this).find("MAX_WAIT").text();
								rerun_max			= $(this).find("RERUN_MAX").text();
								cyclic				= $(this).find("CYCLIC").text();
								time_from			= $(this).find("TIME_FROM").text();
								time_until			= $(this).find("TIME_UNTIL").text();
								cyclic_type			= $(this).find("CYCLIC_TYPE").text();
								rerun_interval		= $(this).find("RERUN_INTERVAL").text();
								specific_time		= $(this).find("SPECIFIC_TIMES").text();
								run_cnt				= $(this).find("RUN_CNT").text();
								update_user_nm		= $(this).find("UPDATE_USER_NM").text();

								if (run_cnt == "") {
									run_cnt = "0";
								}

								if(task_type == "Job"){
									task_type == "script";
								}

								error_desc = decodeHtmlEntities(error_desc);

							});
						}

						var sHtml = "";

						sHtml+="<div id='dl_tmp1' style='overflow:auto;display:none;padding:0;overflow-x:hidden'>";
						sHtml+="<form id='form1' name='form1' method='post' onsubmit='return false;'>";
						sHtml+="<input type='hidden' name='alarm_cd' 	id='alarm_cd' 		value='"+alarm_cd+"'/>";
						sHtml+="<input type='hidden' name='flag' 		id='flag'/>";
						sHtml+="<input type='hidden' name='flag2' 		id='flag2'/>";
						sHtml+="<input type='hidden' name='dept_cd' 	id='dept_cd'/>";
						sHtml+="<input type='hidden' name='duty_cd' 	id='duty_cd'/>";
						sHtml+="<input type='hidden' name='p_title'	 	id='p_title' />";
						sHtml+="<input type='hidden' name='p_host_date'	id='p_host_date' />";

						sHtml+="<table style='width:100%;height:200px;border:none;'>";

						sHtml+="<tr>";
						sHtml += "<th width='20%'><div class='cellTitle_ez_right'>작업명</div></th>";
						sHtml += "<td><div class='cellContent_kang'>" + job_name + "<input type='hidden' name='job_name' id='job_name' value='" + job_name + "'></div></td>";
						sHtml+="</tr>";

						sHtml+="<tr>";
						sHtml += "<th width='20%'><div class='cellTitle_ez_right'>작업 설명</div></th>";
						sHtml += "<td colspan='3'><div class='cellContent_kang' style='height:auto;'>" + description + "<input type='hidden' name='description' id='description' value=''></div></td>";
						sHtml+="</tr>";

						sHtml+="<tr>";
						sHtml += "<th width='20%'><div class='cellTitle_ez_right'>폴더</div></th>";
						sHtml += "<td width='30%'><div class='cellContent_kang'>" + order_table + "<input type='hidden' name='table_name' id='table_name' value=''></div></td>";
						sHtml += "<th width='20%'><div class='cellTitle_ez_right'>작업타입</div></th>";
						sHtml += "<td width='30%'><div class='cellContent_kang'>" + task_type + "<input type='hidden' name='task_type' id='task_type' value=''></div></td>";
						sHtml+="</tr>";

						sHtml+="<tr>";
						sHtml += "<th width='20%'><div class='cellTitle_ez_right'>어플리케이션</div></th>";
						sHtml += "<td><div class='cellContent_kang'>" + application + "<input type='hidden' name='application' id='application' value=''></div></td>";
						sHtml += "<th width='20%'><div class='cellTitle_ez_right'>그룹</div></th>";
						sHtml += "<td><div class='cellContent_kang'>" + group_nm + "<input type='hidden' name='group_nm' id='group_nm' value=''></div></td>";
						sHtml+="</tr>";

						sHtml+="<tr>";
						sHtml += "<th width='20%'><div class='cellTitle_ez_right'>수행서버</div></th>";
						sHtml += "<td><div class='cellContent_kang'>" + node_id + "</div></td>";
						sHtml += "<th width='20%'><div class='cellTitle_ez_right'>계정명</div></th>";
						sHtml += "<td><div class='cellContent_kang'>" + owner + "<input type='hidden' name='owner' id='table_name' value=''></div></td>";
						sHtml+="</tr>";

						sHtml+="<tr>";
						sHtml += "<th width='20%'><div class='cellTitle_ez_right'>시작 및 종료시간</div></th>";
						sHtml+="<td>";
						sHtml += "<div class='cellContent_kang'>" + time_from + " to " + time_until + "</div>";
						sHtml+="</td>";
						sHtml += "<th width='20%'><div class='cellTitle_ez_right'>최대대기일</div></th>";
						sHtml += "<td><div class='cellContent_kang'>" + max_wait + "<input type='hidden' name='max_wait' id='max_wait' value=''></div></td>";
						sHtml+="</tr>";

						sHtml+="<tr>";
						sHtml += "<th width='20%'><div class='cellTitle_ez_right'>작업수행명령</div></th>";
						sHtml+="<td colspan='3'><div style='width:90%;word-break:break-all;'>"+command+"</div></td>";
						sHtml+="</tr>";

						var strcyclMent 	= "";
						var strCycleMent	= "";
						var strCyclicMent	= "";
						var strMentValue	= "";

						if ( cyclic == "0" || cyclic == "" ) {
							strCyclicMent = "N";
						} else {
							strCyclicMent = "Y";
						}

						if ( cyclic_type == "C" ) {
							strCycleMent = "반복주기 : " + rerun_interval + " (분단위) ";
						} else if ( cyclic_type == "V" ) {
// 							strCycleMent = "반복주기(불규칙) : " + strIntervalSequence + " (분단위) ";
						} else if ( cyclic_type == "S" ) {
							strCycleMent = "시간지정 : " + specific_time + " (HHMM) ";
						}

						strcyclMent = strCyclicMent;
						if(strCyclicMent == "Y"){
							strcyclMent = strCyclicMent +" "+strCycleMent;
						}

						if(strcyclMent.length > 30){
							if(strCyclicMent == "Y"){
								strMentValue = strcyclMent.substring(0, 30);
							}else{
								strMentValue = strCyclicMent;
							}
						}else{
							strMentValue = strCyclicMent;
							if(strCyclicMent == "Y"){
								strMentValue = strCycleMent;
							}
						}

						sHtml+="<tr>";
						sHtml += "<th width='20%'><div class='cellTitle_ez_right'>반복작업</div></th>";
						sHtml += "<td><div class='cellContent_kang'>" + strCyclicMent + "</div></td>";

// 						sHtml += "<th width='20%'><div class='cellTitle_ez_right'>최대 반복 횟수</div></th>";
// 						sHtml += "<td><div class='cellContent_kang'>" + rerun_max + "<input type='hidden' name='' id='' value=''></div></td>";
// 						sHtml+="</tr>";
						sHtml+="</table>";


						sHtml+="<table style='width:100%;height:200px;border:none;'>";

						sHtml+="<tr>";
						sHtml += "<th width='20%'><div class='cellTitle_ez_right'>오류 처리 담당자</div></th>";
						sHtml += "<td colspan='3'><div class='cellContent_kang'><input type='text' name='user_nm' id='user_nm' style='width:78%;border:0px; none;' readOnly/><input type='hidden' name='user_cd' id='user_cd' /></div></td>";
						sHtml+="</tr>";

						sHtml+="<tr>";
						sHtml += "<th width='20%'><div class='cellTitle_ez_right'>오류 조치</div></th>";
						sHtml += "<td colspan='3'><div class='cellContent_kang' ><input type='text' name='error_desc' id='error_desc' style='width:78%;border:0px none;' readOnly/></div></td>";
						sHtml += "</tr>";
						sHtml+="</tr>";

						sHtml+="<tr>";
						sHtml+="<th width='20%'><div class='cellTitle_ez_right'>담당자1</div></th>";
						sHtml+="<td width='30%'><div class='cellContent_kang'><input type='text' name='user_nm1' id='user_nm1' style='width:78%;border:0px none;' readOnly/><input type='hidden' name='user_cd1' id='user_cd1' /></div></td>";
						sHtml+="<th width='20%'><div class='cellTitle_ez_right'>담당자2</div></th>";
						sHtml+="<td width='30%'><div class='cellContent_kang'><input type='text' name='user_nm2' id='user_nm2' style='width:78%;border:0px none;' readOnly/><input type='hidden' name='user_cd2' id='user_cd2' /></div></td>";
						sHtml+="</tr>";

						sHtml+="<tr>";
						sHtml+="<th width='20%'><div class='cellTitle_ez_right'>담당자3</div></th>";
						sHtml+="<td width='30%'><div class='cellContent_kang'><input type='text' name='user_nm3' id='user_nm3' style='width:78%;border:0px none;' readOnly/><input type='hidden' name='user_cd3' id='user_cd3' /></div></td>";
						sHtml+="<th width='20%'><div class='cellTitle_ez_right'>담당자4</div></th>";
						sHtml+="<td width='30%'><div class='cellContent_kang'><input type='text' name='user_nm4' id='user_nm4' style='width:78%;border:0px none;' readOnly/><input type='hidden' name='user_cd4' id='user_cd4' /></div></td>";
						sHtml+="</tr>";

						sHtml+="<tr>";
						sHtml+="<th width='20%'><div class='cellTitle_ez_right'>담당자5</div></th>";
						sHtml+="<td ><div class='cellContent_kang'><input type='text' name='user_nm5' id='user_nm5' style='width:78%;border:0px none;' readOnly/><input type='hidden' name='user_cd5' id='user_cd5' /></div></td>";
						sHtml+="<th width='20%'><div class='cellTitle_ez_right'>담당자6</div></th>";
						sHtml+="<td><div class='cellContent_kang'><input type='text' name='user_nm6' id='user_nm6' style='width:78%;border:0px none;' readOnly/><input type='hidden' name='user_cd6' id='user_cd6' /></div></td>";
						sHtml+="</tr>";

						sHtml+="<tr>";
						sHtml += "<th width='20%'><div class='cellTitle_ez_right'>담당자7</div></th>";
						sHtml += "<td><div class='cellContent_kang'><input type='text' name='user_nm7' id='user_nm7' style='width:78%;border:0px none;' readOnly/><input type='hidden' name='user_cd7' id='user_cd7' /></div></td>";
						sHtml += "<th width='20%'><div class='cellTitle_ez_right'>담당자8</div></th>";
						sHtml += "<td><div class='cellContent_kang'><input type='text' name='user_nm8' id='user_nm8' style='width:78%;border:0px none;' readOnly/><input type='hidden' name='user_cd8' id='user_cd8' /></div></td>";
						sHtml+="</tr>";

						sHtml+="<tr>";
						sHtml += "<th width='20%'><div class='cellTitle_ez_right'>담당자9</div></th>";
						sHtml += "<td ><div class='cellContent_kang'><input type='text' name='user_nm9' id='user_nm9' style='width:78%;border:0px none;' readOnly/><input type='hidden' name='user_cd9' id='user_cd9' /></div></td>";
						sHtml += "<th width='20%'><div class='cellTitle_ez_right'>담당자10</div></th>";
						sHtml += "<td><div class='cellContent_kang'><input type='text' name='user_nm10' id='user_nm10' style='width:78%;border:0px none;' readOnly/><input type='hidden' name='user_cd10' id='user_cd10' /></div></td>";
						sHtml+="</tr>";
						sHtml+="</tr>";

						<% if ( !strOpApprovalYn.equals("N")) { %>
							sHtml+="<tr>";
							sHtml+="<th width='20%'><div class='cellTitle_ez_right'>결재여부</div></th>";
							sHtml +="<td><div class='cellContent_kang'><input type='text' name='approval_yn' id='approval_yn' style='width:78%;border:0px none;' readOnly/><input type='hidden' name='approval_yn' id='approval_yn' /></div></td>";
							sHtml+="</td>";
							sHtml+="</tr>";
						<% }else{ %>
							sHtml+="<tr>";
							sHtml+="<th width='20%'><div class='cellTitle_ez_right'>처리여부</div></th>";
							sHtml +="<td><div class='cellContent_kang'><input type='text' name='action_yn' id='action_yn' style='width:78%;border:0px none;' readOnly/><input type='hidden' name='action_yn' id='action_yn' /></div></td>";
							sHtml+="</td>";
							sHtml+="</tr>";
						<% } %>

						sHtml+="</table>";
						sHtml+="</form>";

						$('#dl_tmp1').remove();
						$('body').append(sHtml);

						$("input[name='duty_cd']").val(duty_cd);
						$("input[name='dept_cd']").val(dept_cd);
						$("input[name='user_nm']").val(update_user_nm);
						/* $("input[name='user_cd']").val(user_cd); */

						$("input[name='user_nm1']").val(user_nm1);
						$("input[name='user_cd1']").val(user_cd1);

						$("input[name='user_nm2']").val(user_nm2);
						$("input[name='user_cd2']").val(user_cd2);

						$("input[name='user_nm3']").val(user_nm3);
						$("input[name='user_cd3']").val(user_cd3);

						$("input[name='user_nm4']").val(user_nm4);
						$("input[name='user_cd4']").val(user_cd4);

						$("input[name='user_nm5']").val(user_nm5);
						$("input[name='user_cd5']").val(user_cd5);

						$("input[name='user_nm6']").val(user_nm6);
						$("input[name='user_cd6']").val(user_cd6);

						$("input[name='user_nm7']").val(user_nm7);
						$("input[name='user_cd7']").val(user_cd7);

						$("input[name='user_nm8']").val(user_nm8);
						$("input[name='user_cd8']").val(user_cd8);

						$("input[name='user_nm9']").val(user_nm9);
						$("input[name='user_cd9']").val(user_cd9);

						$("input[name='user_nm10']").val(user_nm10);
						$("input[name='user_cd10']").val(user_cd10);

						$("input[name='grp_nm1']").val(grp_nm1);
						$("input[name='grp_cd1']").val(grp_cd1);
						$("input[name='grp_nm2']").val(grp_nm2);
						$("input[name='grp_cd2']").val(grp_cd2);

						$("input[name='error_desc']").val(error_desc);
						//$("input[name='error_description']").val(error_desc);

						$("input[name='approval_yn']").val(approval_yn);

						$("input[name='action_yn']").val(action_yn);
// 						$("select[name='action_gubun']").val(action_gubun);
						$("select[name='recur_yn']").val(recur_yn);
						$("select[name='error_gubun']").val(error_gubun);
						dlPop01('dl_tmp1', "오류관리", 700, 500, false);

					});
					try{viewProgBar(false);}catch(e){}
				}
				, null );

		xhr.sendRequest();
	}

	function goUserSeqSelect(cd, nm, btn){

		var frm1 = document.form1;

		if(btn == "1"){
			frm1.user_nm.value = nm;
			frm1.user_cd.value = cd;
		}

		dlClose('dl_tmp3');
	}

	function goExcel(){

		var frm = document.f_s;

		try{viewProgBar(true);}catch(e){}

		frm.action = "<%=sContextPath %>/aEm.ez?c=ez003_op_excel";
		frm.target = "if1";
		frm.submit();

		try{viewProgBar(false);}catch(e){}
	}

	function selectTable(eng_nm, desc, user_daily, grp_cd, task_type, table_id){

		$("#table_nm").val(eng_nm);
		$("#table_of_def").val(eng_nm);

		dlClose("dl_tmp1");

		$("#f_s").find("input[name='p_sched_table']").val(eng_nm);
		$("#f_s").find("input[name='p_application_of_def']").val("");
		$("#f_s").find("input[name='p_group_name_of_def']").val("");

		$("#f_s").find("input[name='p_application_of_def_text']").val("");
		$("#f_s").find("input[name='p_group_name_of_def_text']").val("");

		$("#frm1").find("input[name='application_of_def_text']").val("");
		$("#frm1").find("input[name='group_name_of_def_text']").val("");

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
    	
    	// 어플리케이션, 그룹 자동 셋팅
		if(eng_nm.indexOf(",") == -1) { // 한개의 폴더 검색일 때
			getAppGrpCodeList("application_of_def", "2", "", grp_cd); // 어플리케이션을 검색

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
		}
	}

	function valid_chk(flag) {

		// 그리드 마지막 값 원복되는 현상 해결
		$('#'+gridObj.id).data('grid').getEditorLock().commitCurrentEdit();

		var admin_line_grp_cd = '';
		var post_val = 'N';

		var data_center_items = $("select[name='data_center_items'] option:selected").val();

		var f = document.form2;
		var check_idx = document.getElementsByName("check_idx");
		var check_cnt = 0;

		var check_data_center_idx = document.getElementsByName("check_data_center_idx");
		var data_center = "";
		var check_data_center = "";

		var check_alarm_cd_idx = document.getElementsByName("check_alarm_cd_idx");
		var alarm_cd = "";
		var check_alarm_cd = "";

		var check_user_cd_idx = document.getElementsByName("check_user_cd_idx");
		var user_cd = "";
		var check_user_cd = "";

		var check_job_name_idx = document.getElementsByName("check_job_name_idx");
		var job_name = "";
		var check_job_name = "";

		var check_doc_gb_idx = "10";
		var doc_gb = "";
		var check_doc_gb = "";

		var group_yn = "N";
		var doc_gb = "";
		for (var i = 0; i < check_idx.length; i++) {
			if (check_idx.item(i).checked) {

				alarm_cd = check_alarm_cd_idx.item(i).value;
				check_alarm_cd = check_alarm_cd + "|" + alarm_cd;

				data_center = check_data_center_idx.item(i).value;
				check_data_center = check_data_center + "|" + data_center;

				user_cd = check_user_cd_idx.item(i).value;
				if(check_user_cd_idx.item(i).value == ''){
					user_cd = <%=strSessionUserCd%>;
				}

				check_user_cd = check_user_cd + "|" + user_cd;

				job_name = check_job_name_idx.item(i).value;
				check_job_name = check_job_name + "|" + job_name;

				doc_gb = check_doc_gb_idx;
				check_doc_gb = check_doc_gb + "|" + doc_gb;

				check_cnt++;
			}
		}

		if (check_cnt == 0) {
			alert("작업을 선택해 주세요.");
			return;
		}

		if(check_cnt > 1) {
			group_yn = "Y";
		}

		if(check_idx.length != 0){
			alarm_cd = check_alarm_cd.substring(1, check_alarm_cd.length);
			data_center = check_data_center.substring(1, check_data_center.length);
			user_cd = check_user_cd.substring(1, check_user_cd.length);
			job_name = check_job_name.substring(1, check_job_name.length);
			doc_gb = check_doc_gb.substring(1, check_doc_gb.length);

			f.alarm_cd.value = alarm_cd;
			f.data_center.value = data_center;
			f.job_name.value = job_name;
			f.doc_gb.value = doc_gb;
			f.user_cd.value = user_cd;
			f.group_yn.value = group_yn;

		}

		if(flag == 'draft_admin' ||  flag == 'udt_all') {
			popAdminTitleInput(flag, '10');
		}else if(flag == 'draft'){
			getAdminLineGrpCd(flag, '10');
		}
	}

	function goPrc(flag, grp_approval_userList, grp_alarm_userList, title) {

		var f = document.form2;

		f.grp_approval_userList.value = grp_approval_userList;
		f.grp_alarm_userList.value = grp_alarm_userList;
		f.title.value = title;
		f.error_description.value = title;

		if ( flag == "draft_admin" ) {
			if( !confirm("즉시반영[관리자결재] 하시겠습니까?") ) return;
		} else if ( flag == "draft" ) {
			if( !confirm("승인요청 하시겠습니까?") ) return;
		} else if ( flag == "post_draft" ) {
			if( !confirm("[후결]승인요청 하시겠습니까?") ) return;
		}

		try { viewProgBar(true) } catch (e) { }

		//오류처리 결재여부(M92)에 따라 타는 로직 분기처리
		var action = "/tWorks.ez?c=ez036";
		if(flag == "udt_all"){
			action = "/aEm.ez?c=ez003_p_all";
		}

		f.flag.value = flag;
		f.target = "if1";
		f.action = "<%=sContextPath%>" + action;
		f.submit();

		try { viewProgBar(false); } catch (e) { }

		clearGridSelected(gridObj);		//선택된 전체항목 해제 */
	}

</script>
