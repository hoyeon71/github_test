<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/jsp/common/inc/header.jsp"%>
<link href="<%=request.getContextPath() %>/css/tree-layout.css" rel="stylesheet" type="text/css" />

<%

	if (request.getParameter("clearCache") != null) {
	    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
	    response.setHeader("Pragma", "no-cache");
	    response.setDateHeader("Expires", 0);
	}
	Map<String, Object> paramMap = CommonUtil.collectParameters(request);
	String c = CommonUtil.isNull(paramMap.get("c"));
	String gridId = "g_"+c;

	String menu_gb = CommonUtil.getMessage("CATEGORY.GB.02.GB."+CommonUtil.isNull(paramMap.get("menu_gb")));
	String[] arr_menu_gb = menu_gb.split(",");
	List adminApprovalBtnList = (List)request.getAttribute("adminApprovalBtnList");

	String strServerGb = CommonUtil.isNull(CommonUtil.getMessage("SERVER_GB"));

	// 세션값 가져오기.
	String strSessionDcCode 	= S_D_C_CODE;
	String strSessionTab	 	= S_TAB;
	String strSessionApp	 	= S_APP;
	String strSessionGrp	 	= S_GRP;
	String session_user_gb 	= S_USER_GB;

	String strNowDate = DateUtil.getDay();
	String strAdminApprovalBtn		= "";

	if ( adminApprovalBtnList != null ) {
		for ( int i = 0; i < adminApprovalBtnList.size(); i++ ) {
			CommonBean commonBean = (CommonBean) adminApprovalBtnList.get(i);
			strAdminApprovalBtn = CommonUtil.isNull(commonBean.getScode_nm());
		}
	}

	//스크롤 페이징
	String strPagingNum			= CommonUtil.getMessage("PAGING.NUM");
%>

<script type="text/javascript" src="<%=request.getContextPath() %>/js/SlickGrid-2.1.0/slick.editors.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/SlickGrid-2.1.0/slick.formatters.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/SlickGrid-2.1.0/plugins/slick.autocolumnsize.js" ></script>

<form id="f_s" name="f_s" method="post" onsubmit="return false;">
	<input type='hidden' 	id='data_center_code' 			name='data_center_code'/>
	<input type='hidden' 	id='data_center'				name='data_center'/>
	<input type='hidden' 	id='active_net_name' 			name='active_net_name'/>
	<input type='hidden' 	id='p_sched_table' 				name='p_sched_table'/>
	<input type='hidden' 	id='p_application_of_def' 		name='p_application_of_def'/>
	<input type='hidden' 	id='p_group_name_of_def' 		name='p_group_name_of_def'/>
	<input type='hidden' 	id='p_application_of_def_text' 	name='p_application_of_def_text'/>
	<input type='hidden' 	id='p_group_name_of_def_text' 	name='p_group_name_of_def_text'/>
	<input type='hidden' 	id='p_search_gubun' 			name='p_search_gubun'/>
	<input type='hidden' 	id='p_search_text' 				name='p_search_text'/>
	<input type='hidden' 	id='p_search_gubun2' 			name='p_search_gubun2'/>
	<input type='hidden' 	id='p_search_text2' 			name='p_search_text2'/>
	<input type='hidden' 	id='searchType' 				name='searchType'/>
	<input type='hidden'	id='S_USER_NM' 					name='S_USER_NM' 			value="<%=S_USER_NM%>"/>

	<input type='hidden' 	id='job_name' 					name='job_name'/>
	<input type='hidden' 	id='table_id' 					name='table_id'/>
	<input type='hidden' 	id='job_id' 					name='job_id'/>
	<input type='hidden' 	id='v_sched_table' 				name='v_sched_table'/>
	<input type="hidden" 	id="force_gubun"				name="force_gubun"  		value="yes"/>
	<input type="hidden" 	id="force_yn"					name="force_yn"  			value="Y"/>
	<input type="hidden" 	id="hold_gubun"					name="hold_gubun" 			value="yes"/>
	<input type="hidden" 	id="hold_yn"					name="hold_yn"  			value="Y"/>
	<input type="hidden" 	id="menu_gb"					name="menu_gb" 				value="${paramMap.menu_gb}" />
	<input type="hidden"	id="p_mcode_nm"					name="p_mcode_nm"  />
	<input type="hidden" 	id="p_scode_nm"					name="p_scode_nm"  />

	<input type="hidden" 	id="p_scode_cd"					name="p_scode_cd"  />
	<input type="hidden" 	id="p_grp_depth"				name="p_grp_depth"  />
	<input type="hidden" 	id="p_app_nm"					name="p_app_nm"  />
	<input type="hidden" 	id="p_app_search_gubun"			name="p_app_search_gubun"  />
	<input type="hidden" 	id="p_chk_app"  				name="p_chk_app"			value = "N"/>

	<input type="hidden" 	id="startRowNum"				name="startRowNum"			value="0" />
	<input type="hidden" 	id="pagingNum"					name="pagingNum"	 		value="<%=strPagingNum%>" />
</form>
<form id="userFrm" name="userFrm" method="post" onsubmit="return false;"></form>
<form name="frm2" id="frm2" method="post">
	<input type='hidden' 	name='data_center_code'			id='data_center_code'/>
	<input type='hidden' 	name='data_center'				id='data_center'/>
	<input type='hidden' 	name='active_net_name'			id='active_net_name'/>

	<input type="hidden" 	name="flag" 					id="flag" />
	<input type="hidden" 	name="force_gubun" 				id="force_gubun" 			value="yes"/>
	<input type="hidden" 	name="force_yn" 				id="force_yn" 				value="Y"/>
	<input type="hidden" 	name="hold_gubun" 				id="hold_gubun" 			value="yes"/>
	<input type="hidden" 	name="hold_yn" 					id="hold_yn" 				value="Y"/>
	<input type="hidden" 	name="wait_yn" 					id="wait_yn" />

	<input type="hidden" 	name="table_name" 				id="table_name" />
	<input type="hidden" 	name="application" 				id="application" />
	<input type="hidden" 	name="group_name" 				id="group_name" />
	<input type="hidden" 	name="job_name" 				id="job_name" />
	<input type="hidden" 	name="order_date" 				id="order_date" />
	<input type="hidden" 	name="t_set" 					id="t_set" />
	<input type="hidden" 	name="table_id" 				id="table_id" />
	<input type="hidden" 	name="job_id" 					id="job_id" />
	<input type="hidden" 	name="e_order_date" 			id="e_order_date" 			value="${ODATE}" />
	<input type="hidden" 	name="odate" 					id="odate" 					value="${ODATE}" />
	<!-- <input type="hidden" name="e_order_date" 			id="e_order_date" 		value="" /> -->
	<input type="hidden" 	name="order_cnt" 				id="order_cnt" 				value="0" />
	<input type="hidden" 	name="doc_gb" 					id="doc_gb" />
	<input type="hidden" 	name="grp_doc_gb" 				id="grp_doc_gb" 			value="05"/>
	<input type="hidden" 	name="post_approval_yn" 		id="post_approval_yn"/>
	<input type="hidden" 	name="title"  					id="title" />
	<input type="hidden" 	name="p_apply_date"  			id="p_apply_date" />

	<!-- 그룹결재구성원 결재권/알림수신여부	 -->
	<input type="hidden" 	name="grp_approval_userList"  id="grp_approval_userList" />
	<input type="hidden" 	name="grp_alarm_userList"  	  id="grp_alarm_userList" />

	<input type="hidden" 	name="doc_cnt"				  id="doc_cnt"	  			value="0" />
	<input type="hidden" 	name="group_yn"				  id="group_yn"	  			value="N" />
	
	<input type="hidden" 	name="order_into_folder"  	  id="order_into_folder" />
</form>

<form name="frm3" id="frm3" method="post">
	<input type="hidden" 	name="menu_gb" 					id="menu_gb" 			value="${paramMap.menu_gb}" />
	<input type='hidden' 	name='data_center' 				id='data_center'/>
	<input type="hidden" 	name="table_id" 				id="table_id" />
	<input type="hidden" 	name="job_id" 					id="job_id" />
	<input type="hidden" 	name="job_name" 				id="job_name" />
</form>

<table style='width:100%;height:100%;border:none;'>
	<tr style='height:10px;'>
		<td style='vertical-align:top;'>
			<h4 class="ui-widget-header ui-corner-all"  >
				<div id='t_<%=gridId %>' class='title_area' >
					<span><%=CommonUtil.isNull(CommonUtil.getMessage("CATEGORY.GB.02"))%> > <%=CommonUtil.isNull(arr_menu_gb[0]) %></span>
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
					<th width='10%'><div class='cellTitle_kang2' style="min-width:120px;" >C-M</div></th>
					<td width='15%' style="text-align:left; width:300px;">
						<select id="data_center_items" name="data_center_items" style="width:120px; height:21px;">
							<option value="">선택</option>
							<c:forEach var="cm" items="${cm}" varStatus="status">
								<option value="${cm.scode_cd},${cm.scode_eng_nm}">${cm.scode_nm}</option>
							</c:forEach>
						</select>
						</div>
					</td>
					<th width='10%'><div class='cellTitle_kang2' style='min-width:120px;' >조건</div></th>
					<td width='30%' style="text-align:left; min-width:120px; width:300px;">
						<div class='cellContent_kang' style="min-width:120px; " >
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
						<input type="text" name="search_text" value="" id="search_text" style="width:150px;height:21px;"/>
						</div>
					</td>
					<th width='10%'><div class='cellTitle_kang2' style='min-width:120px;'>조건2</div></th>
					<td width='30%' style="text-align:left; min-width:120px; width:300px;">
						<div class='cellContent_kang'  style='min-width:120px;'>
						<select name="search_gubun2" id="search_gubun2" style="width:120px;height:21px;">
							<option value="job_name">작업명</option>
							<option value="description">작업설명</option>
							<option value="command">작업수행명령</option>
						</select>
						<input type="text" name="search_text2" value="" id="search_text2" style="width:150px;height:21px;"  />
						</div>
					</td>
					<td width='5%'></td>
				</tr>
				<tr>
					<th><div class='cellTitle_kang2'>폴더</div></th>
					<td style="text-align:left;min-width:180px;">
						<div class='cellContent_kang'>
							<input type="text" name="table_nm" id="table_nm" style="width:120px; height:21px;" onkeydown="return false;" readonly/>&nbsp;
							<select name="sub_table_of_def" id="sub_table_of_def" style="width:120px;height:21px;display:none;">
								<option value="">전체</option>
							</select>
							<img id="btn_clear1" src="/images/sta2.png" style="width:16px;height:16px;vertical-align:middle;cursor:pointer;"/>&nbsp;
							<input type="hidden" name="table_of_def" id="table_of_def" />
						</div>
					</td>

					<th><div class='cellTitle_kang2'>어플리케이션</div></th>
					<td width='20%' style="text-align:left; min-width:120px; width:300px;">
						<div class='cellContent_kang' style="width:350px;">
							<select name="application_of_def" id="application_of_def" style="width:120px;height:21px;">
								<option value="">--선택--</option>
							</select>
<!-- 							<input type='hidden' id='application' name='application' value='' /> -->
<!-- 							<input type='text' id='application_of_def_text' name='application_of_def_text' style="width:114px; height:21px;"/> -->
<!-- 							제외:<input type='checkbox' id='chk_app' name='chk_app' value = "N" />&nbsp;&nbsp; -->
						</div>
					</td>

					<th width='10%'><div class='cellTitle_kang2' style='min-width:120px;'>그룹</div></th>
					<td width='20%' style="text-align:left">
						<div class='cellContent_kang' style="width:300px">
						<select id="group_name_of_def" name="group_name_of_def" style="width:120px; height:21px;">
							<option value=''>--선택--</option>
						</select>
						<input type='text' id='group_name_of_def_text' 	name='group_name_of_def_text' style="width:150px; height:21px;display:none;"/>
						</div>
					</td>
					<td style="text-align:right;">
						<span id='btn_search' style='float:right;'>검 색</span>
					</td>
				</tr>
			</table>
			</h4>
			</form>
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
					<span id="btn_draft_admin" style='display:none;'>관리자 즉시결재</span>

				</div>
			</h4>
		</td>
	</tr>
</table>
<script>
	var listChk = false;

	function dateFormatter(row,cell,value,columnDef,dataContext){

		var ret = "";
		ret = value.getMonth()+""+value.getDate();

		return ret;

	}

	function gridCellCustomFormatter(row,cell,value,columnDef,dataContext){
		var ret = "";
		var job_id = getCellValue(gridObj,row,'JOB_ID');
		var job_name = getCellValue(gridObj,row,'JOB_NAME');
		var table_id = getCellValue(gridObj,row,'TABLE_ID');

		if(columnDef.id == 'JOB_NAME'){
			ret = "<a href=\"JavaScript:popupDefJobDetail('"+encodeURIComponent(job_name)+"','"+table_id+"','"+job_id+"');\" /><font color='red'>"+value+"</font></a>";
		}

		if (columnDef.id == 'USER_NM') {
			ret = "<a href=\"JavaScript:jobUserInfo('" + encodeURIComponent(job_name) + "');\" /><font color='blue'>" + value + "</font></a>";
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
			,{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'번호',minWidth:50,width:50,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'SCHED_TABLE',id:'SCHED_TABLE',name:'폴더',minWidth:150,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'APPLICATION',id:'APPLICATION',name:'어플리케이션',minWidth:150,maxWidth:300,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'GROUP_NAME',id:'GROUP_NAME',name:'그룹',minWidth:150,maxWidth:300,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'JOBSCHEDGB',id:'JOBSCHEDGB',name:'작업종류',minWidth:80,maxWidth:80,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	   		,{formatter:gridCellCustomFormatter,field:'JOB_NAME',id:'JOB_NAME',name:'작업명',width:200,minWidth:200,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'DESCRIPTION',id:'DESCRIPTION',name:'작업설명',minWidth:200,maxWidth:500,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
			,{formatter:gridCellCustomFormatter,field:'USER_NM',id:'USER_NM',name:'담당자',width:100,minWidth:100,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
			,{formatter:gridCellNoneFormatter,field:'T_SET',id:'T_SET',name:'변수 입력란',minWidth:200,headerCssClass:'cellCenter',cssClass:'cellCenter',editor:Slick.Editors.Text}

	   		,{formatter:gridCellNoneFormatter,field:'FORCE',id:'FORCE',name:'FORCE',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   		,{formatter:gridCellNoneFormatter,field:'JOB_ID',id:'JOB_ID',name:'JOB_ID',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   		,{formatter:gridCellNoneFormatter,field:'TABLE_ID',id:'TABLE_ID',name:'TABLE_ID',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   	]

		,rows:[]
		,vscroll:false
	};

	$(document).ready(function(){

		var user_gb 		= "<%=S_USER_GB%>";
		var server_gb 		= "<%=strServerGb%>";
		var session_dc_code	= "<%=strSessionDcCode%>";
		var table_name		= "<%=strSessionTab%>";
		var application		= "<%=strSessionApp%>";
		var group_name		= "<%=strSessionGrp%>";
		var adminApprovalBtn = "<%=strAdminApprovalBtn %>";

		<c:if test="${USER_GB eq '99'}">
			// 관리자는 담당자 default 검색 조건 제거
			$('#search_text').val("");
		</c:if>

		if (user_gb == "99" || adminApprovalBtn == "Y") {
			$("#btn_draft_admin").show();
		} else {
			$("#btn_draft_admin").hide();
		}

		$("#btn_draft").show();
		$("#btn_search").show();

		//초기 검색조건 - C-M, 폴더, 어플리케이션, 그룹
		if(session_dc_code != "") { // 개인정보에 C-M이 등록되어 있을경우
			$("select[name='data_center_items']").val(session_dc_code);
			$("#f_s").find("input[name='data_center']").val(session_dc_code);
		}else { // 개인정보에 C-M이 등록이 되어있지 않을경우 -> C-M 콤보박스에서 첫번째값 선택
			$("#data_center_items option:eq(1)").prop("selected", true);
			$("#f_s").find("input[name='data_center']").val($("select[name='data_center_items']").val());
		}

		// 개인정보 설정에 폴더 값이 셋팅되어 있을 경우 (2024-11-05 김선중)
		if (table_name != "") {
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
		}

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

		$("#f_s").find("input[name='p_search_gubun']").val($("#frm1").find("select[name='search_gubun'] option:selected").val());
		$("#f_s").find("input[name='p_search_text']").val($("#frm1").find("input[name='search_text']").val());
		$("#f_s").find("input[name='p_search_gubun2']").val($("#frm1").find("select[name='search_gubun2'] option:selected").val());
		$("#f_s").find("input[name='p_search_text2']").val($("#frm1").find("input[name='search_text2']").val());

		//체크박스 설정
// 		viewGridChk_2(gridObj,"ly_"+gridObj.id,{enableColumnReorder:true},'AUTO');
		viewGrid_2(gridObj,"ly_"+gridObj.id,{enableColumnReorder:true},'AUTO');

		setTimeout(function(){
			defJobsList();
		}, 300);

		$("#btn_search").button().unbind("click").click(function(){
			setTimeout(function(){
				defJobsList();
			}, 300);
		});

		$('#search_text').unbind('keypress').keypress(function(e){
			if(e.keyCode==13){
				defJobsList();
			}
		});

		//조건2(작업명/작업설명) 분리
		$('#search_text2').unbind('keypress').keypress(function(e){
			if(e.keyCode==13){
				defJobsList();
			}
		});

		// 어플리케이션 엔터
		$('#application_of_def_text').unbind('keypress').keypress(function(e) {
			if(e.keyCode==13){
				defJobsList();
			}
		});

		$("#data_center_items").change(function(){		//C-M

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

			$("#f_s").find("input[name='p_application_of_def_text']").val("");
			$("#f_s").find("input[name='p_group_name_of_def_text']").val("");

			$("#frm1").find("input[name='application_of_def_text']").val("");
			$("#frm1").find("input[name='group_name_of_def_text']").val("");

			var data_center_items = $(this).val();
			if($(this).val() != ""){
				$("#f_s").find("input[name='data_center']").val(data_center_items);
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

		$("#btn_draft").button().unbind("click").click(function(){

			var check_idx = document.getElementsByName("check_idx");
			var check_cnt = 0;
			
			var check_smart_job_idx  = document.getElementsByName("check_smart_job_idx");
			var smart_gb = "";

			for (var i = 0; i < check_idx.length; i++) {
				if (check_idx.item(i).checked) {
					check_cnt++;
					
					// 승인요청할 작업목록에서 스마트폴더 작업 유무 체크
					if(check_smart_job_idx.item(i).value == "Y"){
						smart_gb = "smart";
					}
				}
			}

			if (check_cnt == 0) {
				alert("결재할 항목을 선택해 주세요.");
				return;
			}
			// 스마트폴더 작업 예외처리
			if(smart_gb == "smart") {
				var error_msg = smartJobChk();
				if(error_msg != "") {
					alert(error_msg);
					return;
				}
			}

			valid_chk('draft', smart_gb);
		});

		$("#btn_draft_admin").button().unbind("click").click(function(){
			
			var check_idx = document.getElementsByName("check_idx");
			var check_smart_job_idx  = document.getElementsByName("check_smart_job_idx");
			var smart_gb = "";
			
			for (var i = 0; i < check_idx.length; i++) {
				if (check_idx.item(i).checked) {
					
					// 승인요청할 작업목록에서 스마트폴더 작업 유무 체크
					if(check_smart_job_idx.item(i).value == "Y"){
						smart_gb = "smart";
					}
				}
			}
			
			// 스마트폴더 작업 예외처리
			if(smart_gb == "smart") {
				var error_msg = smartJobChk();
				if(error_msg != "") {
					alert(error_msg);
					return;
				}
			}
			
			valid_chk('draft_admin', smart_gb);
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

		$('#application_of_def_text').on('keyup', function(event) {
			var app_text = $(this).val().replace(/ /gi, '');
			$('#p_application_of_def_text').val(app_text);
		});

		//체크박스 버그픽스
		$('#'+gridObj.id).data('grid').onSelectedRowsChanged.subscribe(function (e, args) {
			$("input:checkbox[name^='hold_check']").unbind("click").click(function(){
				var v_hold_check = "";
				var tagId = $(this).attr('id');
				var i = tagId.replace("hold_check","");
				if($(this).prop("checked")) {
					v_hold_check = "<div class='gridInput_area'><input type='checkbox' id='"+$(this).attr('id')+"' name='"+$(this).attr('id')+"' checked/></div>";
					setCellValue(gridObj,(i-1),'HOLD', v_hold_check);
				} else {
					v_hold_check = "<div class='gridInput_area'><input type='checkbox' id='"+$(this).attr('id')+"' name='"+$(this).attr('id')+"' /></div>";
					setCellValue(gridObj,(i-1),'HOLD', v_hold_check);
				}
			});
		});

		//스크롤 페이징
		var grid = $('#'+gridObj.id).data('grid');
		grid.onScroll.subscribe(function(e, args){
			var elem = $("#g_ez010").children(".slick-viewport");
			if ( elem[0].scrollHeight - elem.scrollTop() - elem.css("height").replace("px", "") + 17 < 100) {
				if(listChk) {
					listChk = false;
					var startRowNum = parseInt($("#startRowNum").val());
					startRowNum += parseInt($('#pagingNum').val());
					defJobsList(startRowNum);
				}
// 				alert(elem[0].scrollHeight - elem.scrollTop() - elem.css("height").replace("px", "") + 17);
			}
		});
		
		
		// 변수 입력란 입력 시 체크박스 풀리는 현상 2024-07-10(김선중)
		var bIdxChecked = false;
		
		// 셀 편집이 시작될때 호출하는 함수 (현재 체크박스 상태를 저장)
		grid.onBeforeEditCell.subscribe(function (e, args) {
			var grid_idx  = args.item.grid_idx - 1;
			var check_idx = document.getElementsByName("check_idx");
			bIdxChecked = check_idx.item(grid_idx).checked;
	  	});
		// 셀 값이 변경될때 호출하는 함수 (초기화된 체크박스를 다시 체크)
		grid.onCellChange.subscribe(function (e, args) {
			if(bIdxChecked) {
				var grid_idx  = args.item.grid_idx - 1;
				var check_idx = document.getElementsByName("check_idx");
				check_idx.item(grid_idx).checked = true;
			}
	    });
	});

	function defJobsList(startRowNum){

		clearGridSelected(gridObj);

		//그리드 마지막 값 원복되는 현상 해결
		$('#'+gridObj.id).data('grid').getEditorLock().commitCurrentEdit();

		var data_center_items 		= $("select[name='data_center_items'] option:selected").val();

		if(data_center_items == ""){
			alert("C-M 을 선택해 주세요.");
			return;
		}

		$("#f_s").find("input[name='p_search_gubun']").val($("#frm1").find("select[name='search_gubun'] option:selected").val());
		$("#f_s").find("input[name='p_search_text']").val($("#frm1").find("input[name='search_text']").val());
		$("#f_s").find("input[name='p_search_gubun2']").val($("#frm1").find("select[name='search_gubun2'] option:selected").val());
		$("#f_s").find("input[name='p_search_text2']").val($("#frm1").find("input[name='search_text2']").val());

		if ( $("#f_s").find("input[name='p_sched_table']").val() == "" ) {
			$("#f_s").find("input[name='p_sched_table']").val("");
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
			var elem = $("#g_ez010").children(".slick-viewport");
			elem.scrollTop(0);
			startRowNum = 0;
			$('#startRowNum').val(0);
		}

		try{viewProgBar(true);}catch(e){}

		$('#ly_total_cnt').html('');

		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=defJobList&user_gb=<%=S_USER_GB %>&itemGubun=2';
		var odate = "${ODATE}";
		//var odate = "";

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

						if(startRowNum != '' && startRowNum != null && startRowNum != undefined ) {
							rowsObj = gridObj.rows;
						}

						if(items.attr('cnt')=='0'){
						}else{
							items.find('item').each(function(i){

								var table_id 			= $(this).find("TABLE_ID").text();
								var job_id 				= $(this).find("JOB_ID").text();
								var data_center 		= $(this).find("DATA_CENTER").text();
								var sched_table 		= $(this).find("SCHED_TABLE").text();
								var application			= $(this).find("APPLICATION").text();
								var group_name 			= $(this).find("GROUP_NAME").text();
								var job_name 			= $(this).find("JOB_NAME").text();
								var mem_name 			= $(this).find("MEM_NAME").text();
								var description 		= $(this).find("DESCRIPTION").text();
								var error_description 	= $(this).find("ERROR_DESCRIPTION").text();
								var user_daily			= $(this).find("USER_DAILY").text();
								var user_nm 			= $(this).find("USER_NM").text();

								//오더권한 있는 담당자 조회
								var user_list			= $(this).find("USER_LIST").text();
								
								var smart_job_yn		= $(this).find("SMART_JOB_YN").text();
								var smart_folder = "";
								if ( smart_job_yn == "Y" ) {
									smart_folder = "<img src='/imgs/smart_folder.png' style='vertical-align:middle;' width='20' height='20'> ";
								}

								//작업종류(2022.11.03 전북은행)
								if (user_daily != "") {
									jobschedgb = "정기";
								} else if (user_daily == "") {
									jobschedgb = "비정기";
								}

								var v_check_idx = "";

								v_check_idx = 	"<div class='gridInput_area'><input type='checkbox' name='check_idx' value='"+i+1+startRowNum+"' ></div>";
								v_check_idx	+= 	"<input type='hidden' name='check_data_center_idx' value='"+data_center_items+"' >";
								v_check_idx	+= 	"<input type='hidden' name='check_sched_table_idx' value='"+sched_table+"' >";
								v_check_idx	+= 	"<input type='hidden' name='check_application_idx' value='"+application+"' >";
								v_check_idx	+= 	"<input type='hidden' name='check_group_name_idx' value='"+group_name+"' >";
								v_check_idx	+= 	"<input type='hidden' name='check_job_name_idx' value='"+job_name+"' >";
								v_check_idx	+= 	"<input type='hidden' name='check_mem_name_idx' value='"+mem_name+"' >";
								v_check_idx	+= 	"<input type='hidden' name='check_table_id_idx' value='"+table_id+"' >";
								v_check_idx	+= 	"<input type='hidden' name='check_job_id_idx' value='"+job_id+"' >";
								v_check_idx	+= 	"<input type='hidden' name='check_smart_job_idx' value='"+smart_job_yn+"' >";


								rowsObj.push({
									'check_idx':v_check_idx
								    ,'grid_idx':i+1+startRowNum
									,'APPLICATION': application
									,'GROUP_NAME': group_name
									,'JOBSCHEDGB': jobschedgb
									,'JOB_NAME': job_name
									,'DESCRIPTION': description
									,'ODATE': odate
									,'JOB_ID': job_id
									,'TABLE_ID': table_id
									,'SCHED_TABLE': smart_folder + sched_table
									,'ERROR_DESCRIPTION': error_description
									,'USER_NM': user_nm
									,'USER_LIST': user_list
									,'SMART_JOB_YN': smart_job_yn
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

	//승인요청 시 체크로직 추가하는 구간
	function valid_chk(flag, smart_gb){

		// 그리드 마지막 값 원복되는 현상 해결
		$('#'+gridObj.id).data('grid').getEditorLock().commitCurrentEdit();

		var cnt 					= 0;
		var grid_idx 				= "";
		var t_set 					= "";
		var t_set_val				= "";
		var force_check				= "";
		var get_force_check 		= "";
		var doc_gb					= "";

		var check_idx 				= document.getElementsByName("check_idx");

		var check_data_center_idx	= document.getElementsByName("check_data_center_idx");
		var data_center 			= "";
		var check_data_center	 	= "";

		var check_sched_table_idx	= document.getElementsByName("check_sched_table_idx");
		var sched_table 			= "";
		var check_sched_table	 	= "";

		var check_application_idx	= document.getElementsByName("check_application_idx");
		var application 			= "";
		var check_application 		= "";

		var check_group_name_idx	= document.getElementsByName("check_group_name_idx");
		var group_name				= "";
		var check_group_name	 	= "";

		var check_job_name_idx		= document.getElementsByName("check_job_name_idx");
		var job_name 				= "";
		var check_job_name 			= "";

		var check_mem_name_idx		= document.getElementsByName("check_mem_name_idx");
		var mem_name 				= "";
		var check_mem_name 			= "";

		var check_table_id_idx		= document.getElementsByName("check_table_id_idx");
		var table_id 				= "";
		var check_table_id 			= "";

		var check_job_id_idx		= document.getElementsByName("check_job_id_idx");
		var job_id 					= "";
		var check_job_id 			= "";


		for ( var i = 0; i < check_idx.length; i++ ) {
			if (check_idx.item(i).checked) {

				data_center = check_data_center_idx.item(i).value;
				check_data_center = check_data_center + "|" + data_center;

				sched_table = check_sched_table_idx.item(i).value;
				check_sched_table = check_sched_table + "|" + sched_table;

				application = check_application_idx.item(i).value;
				check_application = check_application + "|" + application;

				group_name = check_group_name_idx.item(i).value;
				check_group_name = check_group_name + "|" + group_name;

				job_name = check_job_name_idx.item(i).value;
				check_job_name = check_job_name + "|" + job_name;

				mem_name = check_mem_name_idx.item(i).value;
				check_mem_name = check_mem_name + "|" + mem_name;

				table_id = check_table_id_idx.item(i).value;
				check_table_id = check_table_id + "|" + table_id;

				job_id = check_job_id_idx.item(i).value;
				check_job_id = check_job_id + "|" + job_id;

				doc_gb += "|" + "05";

				//수행 시 담당자 체크로직이 필요할때 주석 해제 필요 현재는 폴더권한 기준으로 체크
				var user_list 	= getCellValue(gridObj,i,'USER_LIST');
				var s_user_id 	= "<%=S_USER_ID%>";
				var session_user_gb = "<%=session_user_gb%>";

				//사용자일 경우에만 체크
				if(session_user_gb == "01"){
					if(( user_list.indexOf(s_user_id) == -1 )) {
						//alert("작업명 : "+job_name + "의 담당자가 아닙니다.");
						//return;
					}
				}

				t_set_val		= getCellValue(gridObj, i, 'T_SET');

				// 변수 체크 로직 추가 (2023.03.26 강명준)
				if ( t_set_val != '') {

					var arr_t_set = t_set_val.split("|");

					if ( arr_t_set.length > 0 ) {
						for ( var ii = 0; ii < arr_t_set.length; ii++ ) {
							var arr_t_set2 = arr_t_set[ii].split(",", 2);
							if ( arr_t_set2.length != 2 ) {
								alert("변수는 [변수명,변수값|변수명2,변수값2] 형식으로 사용해야 합니다.");
								$('#titleInput').remove();
								return;
							}
						}
					}
				}

				if(t_set_val != '') {

					// 변수 형태 체크 로직
					var arrTsets = t_set_val.split("|");

					for( var ii = 0; ii < arrTsets.length; ii++ ) {

						var arrTset	= arrTsets[ii].split(",", 2);

						if ( arrTset.length != 2 ) {
							alert((i+1) + "행 변수를 정확히 작성해 주세요.");
							return;
						}
					}

					t_set_val = t_set_val.replace(/,/g, "!");
				} else {
					t_set_val = "/";
				}

				// 파이프라인으로 split 하면 변수 셋팅 이슈로 별표 구분자로 변경 (2024.01.05 이기준)
				t_set 		= t_set + "★" + t_set_val;
				get_force_check = "Y";

				var now_date 	= "<%=strNowDate%>";
				var server_gb 	= "<%=strServerGb%>";
				var s_user_gb 	= "<%=S_USER_GB%>";

				++cnt;

			}
		}

		if(cnt > 1) {
			group_yn = "Y";
		}

		if ( document.getElementById("order_cnt").value != 0 ) {
			if( !confirm("해당 날짜에 이미 올라와 있습니다. 그래도 의뢰하시겠습니까?") ) return;
		}

		data_center 	= check_data_center.substring(1, check_data_center.length);
		job_name 		= check_job_name.substring(1, check_job_name.length);
		sched_table 	= check_sched_table.substring(1, check_sched_table.length);
		application 	= check_application.substring(1, check_application.length);
		group_name 		= check_group_name.substring(1, check_group_name.length);
		table_id 		= check_table_id.substring(1, check_table_id.length);
		job_id   		= check_job_id.substring(1, check_job_id.length);
// 		odate 			= odate.substring(1, odate.length);
		t_set 			= t_set.substring(1, t_set.length);
		//		hold_check 	= hold_check.substring(1, hold_check.length);
//		force_check	= force_check.substring(1, force_check.length);
		doc_gb 		= doc_gb.substring(1, doc_gb.length);

		var frm = document.frm2;

		frm.data_center.value 		= data_center;
		frm.table_name.value 		= sched_table;
		frm.application.value 		= application;
		frm.group_name.value 		= group_name;
		frm.job_name.value 			= job_name;
// 		frm.order_date.value 		= odate;
		frm.t_set.value 			= t_set;
		frm.table_id.value 			= table_id;
		frm.job_id.value 			= job_id;
		frm.doc_gb.value 			= doc_gb;
		frm.group_yn.value			= group_yn;
		frm.order_into_folder.value	= "";

		if(flag == 'draft_admin'){
			//관리자 즉시결재
			//goPrc(check_sched_table, check_application, check_group_name, check_job_name, grid_idx, check_table_id, check_job_id, t_set, hold_yn, force_check, flag, cnt, '', '' , group_yn, doc_gb);
			popAdminTitleInput(flag, '05', smart_gb);
		}else {
			getAdminLineGrpCd(flag, '05', smart_gb);
			//setDynamicApproval(check_sched_table, check_application, check_group_name, check_job_name, check_mem_name, check_table_id, check_job_id, t_set, force_check, flag, cnt, admin_line_grp_cd, group_yn, doc_gb);
		}
	}

	//function goPrc(table_name, application, group_name, job_name, idx, table_id, job_id, t_set, hold_yn,  force_check, flag, cnt, grp_approval_userList, grp_alarm_userList, group_yn, doc_gb){
	//결재권 설정 후
	function goPrc(flag, grp_approval_userList, grp_alarm_userList, title){

		var frm = document.frm2;
		var post_approval_yn = "N";
		var c = "";
		$("#frm2").find("input[name='data_center_code']").val($("#f_s").find("input[name='data_center_code']").val());
		//$("#frm2").find("input[name='data_center']").val($("#f_s").find("input[name='data_center']").val());
		
		if(grp_approval_userList) grp_approval_userList = grp_approval_userList.substring(0,grp_approval_userList.length);
		if(grp_alarm_userList) grp_alarm_userList = grp_alarm_userList.substring(0,grp_alarm_userList.length);

		var check_idx = document.getElementsByName("check_idx");
		var check_cnt = 0;

		for (var i = 0; i < check_idx.length; i++) {
			if (check_idx.item(i).checked) {
				check_cnt++;
			}
		}

		var noti = "";
		if(	check_cnt > 1){
			noti = " 일괄";
			c = "ez036";
		}else{
			c = "ez021_w";
		}

		if ( flag == "draft_admin" ) {
			if( !confirm(check_cnt + " 건을 즉시반영[관리자결재] 하시겠습니까?") ) return;
		} else if ( flag == "draft" ) {
			if( !confirm(check_cnt + " 건을 " + noti + " 승인요청 하시겠습니까?") ) return;
		} else if ( flag == "post_draft" ) {
			post_approval_yn = "Y";
			if( !confirm(check_cnt + " 건을" + noti + " [후결]승인요청 하시겠습니까?") ) return;
		}

		frm.flag.value 					= flag;
		frm.title.value					= title;
		frm.force_yn.value 				= "Y";
		frm.grp_approval_userList.value = grp_approval_userList;
		frm.grp_alarm_userList.value 	= grp_alarm_userList;
		frm.post_approval_yn.value 		= post_approval_yn;

		try{viewProgBar(true);}catch(e){}

		clearGridSelected(gridObj);

		frm.target = "if1";
		//frm.action = "<%=sContextPath%>/tWorks.ez?c=ez021_w";
		//일괄
		frm.action = "<%=sContextPath%>/tWorks.ez?c="+c;

		frm.submit();
	}

	function cal(val){
		var id = "odate"+val;

		dpCalMin(id,'yymmdd');
	}

	function selectTable(eng_nm, desc, user_daily, grp_cd, task_type, table_id){

		$("#table_nm").val(eng_nm);
		$("#table_of_def").val(eng_nm);

		dlClose("dl_tmp1");

		$("#f_s").find("input[name='p_sched_table']").val(eng_nm);
		$("#f_s").find("input[name='p_application_of_def']").val("");
		$("#f_s").find("input[name='p_group_name_of_def']").val("");

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

	function selectTable2(eng_nm, desc){

		$("#table_nm").val(eng_nm);
		$("#table_of_def").val(eng_nm);

		dlClose("dl_tmp1");

		$("#f_s").find("input[name='p_sched_table']").val(eng_nm);
		$("#f_s").find("input[name='p_application_of_def']").val("");
		$("#f_s").find("input[name='p_group_name_of_def']").val("");


		getAppGrpCodeList("", "2", "", "application_of_def", eng_nm);

		//그룹초기화
		$("select[name='group_name_of_def'] option").remove();
		$("select[name='group_name_of_def']").append("<option value=''>--선택--</option>");

	}

	function popupDefJobDetail(job_name,table_id,job_id) {

		var frm = document.frm3;

		//Job 정보를 가져오기위한 파라미터들l
		frm.job_name.value 		= job_name;
		frm.table_id.value 		= table_id;
		frm.job_id.value 		= job_id;
		frm.data_center.value	= $('#f_s').find('input[name="data_center"]').val();

		openPopupCenter1("about:blank","popupDefJobDetail",1200,800);

		frm.action = "<%=sContextPath %>/mPopup.ez?c=ez011";
		frm.target = "popupDefJobDetail";
		frm.submit();
	}
	
	// 스마트폴더 작업 체크로직
	function smartJobChk(){
		
		var error_msg = "";
		// 그리드 마지막 값 원복되는 현상 해결
		$('#'+gridObj.id).data('grid').getEditorLock().commitCurrentEdit();
		
		var check_idx = document.getElementsByName("check_idx");
		var check_sched_table_idx	= document.getElementsByName("check_sched_table_idx");
		
		var check_smart_job_idx		= document.getElementsByName("check_smart_job_idx");
		var check_smart_job 		= "";
		
		var smart_table_list = new Array();
		
		for ( var i = 0; i < check_idx.length; i++ ) {
			if (check_idx.item(i).checked) {
				var smart_job = check_smart_job_idx.item(i).value;
				
				check_smart_job = check_smart_job + "|" + smart_job;
				if(smart_job == "Y") {
					smart_table_list.push(check_sched_table_idx.item(i).value);
				}
			}
		}
		
		if(check_smart_job.includes("N") && check_smart_job.includes("Y")) {
			error_msg = "일반 작업과 스마트폴더의 작업은 동시에 수행할 수 없습니다.";
		}else if(!check_smart_job.includes("N") && check_smart_job.includes("Y")) {
			for(var i = 0; i < smart_table_list.length; i++){
				if(i == 0) {
					smart_table_nm = smart_table_list[i];
				}else if(smart_table_nm != smart_table_list[i]){
					error_msg = "상위 폴더가 다른 스마트폴더의 작업은 동시에 수행할 수 없습니다.";
				}
			}
		}
		
		return error_msg;
	}
	
	// 스마트폴더 트리 뷰 팝업
	function popSmartTreeView(flag, grp_approval_userList, grp_alarm_userList, title) {
		
		var odate = $("#order_date").val();
		
		var search_job_name = $("#frm2").find("#job_name").val();
		search_job_name = search_job_name.split("|")[0];
		
		var sHtml1="<div id='smartTreeView' style='overflow:hidden;display:none;padding:0;border-top:1px solid blue;border-bottom:1px solid blue;border-left:1px solid blue;border-right:1px solid blue;'>";
		sHtml1+="<form id='smartTreeViewForm' name='smartTreeViewForm' method='post' onsubmit='return false;'>";
		sHtml1+="<input type='hidden' name='data_center' 		id='data_center'/>";
		sHtml1+="<input type='hidden' name='job_name' 	 		id='job_name'/>";
		sHtml1+="<input type='hidden' name='p_search_odate' 	id='p_search_odate'/>";
		sHtml1+="<table style='width:100%;height:100%;border:none;'>"; //table 시작
		sHtml1+="<tr style='height:380px;'>"; // tr
		sHtml1+="<td style='width:100%;vertical-align:top;border-bottom:1px solid #b7c9e1;'>";
		sHtml1+="<div id='smart_tree_grid' class='treeContent_kang'style='height:380px;overflow:auto scroll;' ></div>";
		sHtml1+="</td>";
		sHtml1+="</tr>"; // /tr
		sHtml1+="<tr style='height:5px;'>"; // tr
		sHtml1+="<td style='width:100%;vertical-align:top;>"; // td
		sHtml1+="<div style='padding:3px;'>";
		sHtml1+="<h4>";
		sHtml1+="<span id='ly_total_cnt_11' stlye='float:left;'></span>";
		sHtml1+="<span id='button' style='float:right;'>승인요청</span>";
		sHtml1+="</h4>";
		sHtml1+="</div>";
		sHtml1+="</td>"; // /tb
		sHtml1+="</tr>"; //tr 3 끝
		sHtml1+="</table>"; //table 끝
		sHtml1+="</form>";
		sHtml1+="</div>";
		
		$('#smartTreeView').remove();
		$('body').append(sHtml1);
		
		dlPop03('smartTreeView',"스마트폴더 작업정보",520,425,false);
		
		$("#smartTreeView").find("#data_center").val($("#f_s").find("input[name='data_center']").val());
		$("#smartTreeView").find("#p_search_odate").val(odate);
		$("#smartTreeView").find("input[name='job_name']").val(search_job_name);
		
		var order_into_folder = "New";
		
		var smart_batch_cnt = smartTableTreeList();
		
		document.querySelectorAll("#smart_tree_grid input[type='checkbox']").forEach(function(checkbox) {
            checkbox.addEventListener('click', function() {
                // 체크박스가 체크되면 다른 모든 체크박스를 해제
                if (this.checked) {
                    document.querySelectorAll("#smart_tree_grid input[type='checkbox']").forEach(function(otherCheckbox) {
                        if (otherCheckbox !== checkbox) {
                            otherCheckbox.checked = false;
                        }
                    });
                }
            });
        });
		
		$("#smartTreeView").find("#button").button().unbind("click").click(function(){
			var checkboxes = document.querySelectorAll("#smart_tree_grid input[type='checkbox']");
			var check_cnt = 0;
            checkboxes.forEach(function(checkbox) {
                if(checkbox.checked) {
                	order_into_folder = checkbox.value;
                    check_cnt++;
                }
            });
            
            if(check_cnt > 0) {
            	$("#frm2").find("input[name='order_into_folder']").val(order_into_folder);
            	console.log($("#frm2").find("input[name='order_into_folder']").val());
            	goPrc(flag, grp_approval_userList, grp_alarm_userList, title);
            }else {
            	alert("등록할 폴더를 선택해 주세요");
            }
		});
		
		
		$("#p_search_s_date").addClass("text_input").unbind('click').click(function(){
			dpCalMin(this.id,'yymmdd');
		});
		
		if(smart_batch_cnt == 0) {
			dlClose('smartTreeView');
			$("#frm2").find("input[name='order_into_folder']").val(order_into_folder);
			goPrc(flag, grp_approval_userList, grp_alarm_userList, title);
		}
				
		
	}
	
	
	function smartTableTreeList(){
		
		var cnt = 0;
		
		var arr_job_name  = new Array();
		var arr_order_id  = new Array();
		var arr_rba       = new Array();
		var arr_grp_rba   = new Array();
		var arr_check_box = new Array();
		
		try{viewProgBar(true);}catch(e){}

		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=smartTableTreeList';

		var xhr = new XHRHandler( url, smartTreeViewForm
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
						dlClose('dl_tmp3');
						return;
					}
					$(xmlDoc).find('doc').each(function(){

						var items = $(this).find('items');

						if(items.attr('cnt')=='0'){
						}else{
							items.find('item').each(function(i){
								var job_name 	 = $(this).find("JOB_NAME").text();
								var odate 		 = $(this).find("ODATE").text();
								var order_id 	 = $(this).find("ORDER_ID").text();
								var task_type 	 = $(this).find("TASK_TYPE").text();
								var group_no 	 = $(this).find("GROUP_NO").text();
								var hailaki 	 = $(this).find("HAILAKI").text();
								var rba 	 	 = $(this).find("RBA").text();
								var grp_rba 	 = $(this).find("GRP_RBA").text();
								var check_box_yn = $(this).find("CHECK_BOX_YN").text();
								
								job_name = job_name + " (" + order_id + ")";
								
								if(task_type == "SMART Table"){
									job_name = "[SMART] " + job_name
								}else if(task_type == "Sub-Table"){
									job_name = "[SUB] " + job_name
								}
								
								
								arr_job_name.push(job_name);
								arr_order_id.push(order_id);
								arr_rba.push(rba);
								arr_grp_rba.push(grp_rba);
								arr_check_box.push(check_box_yn);
								cnt++;
								
							});
						}
					});
					try{viewProgBar(false);}catch(e){}
				}
		, null );
		
		xhr.sendRequestSync();
		
		renderTree(arr_job_name, arr_order_id, arr_rba, arr_grp_rba, arr_check_box);
		
		return cnt;
		
	}

</script>
