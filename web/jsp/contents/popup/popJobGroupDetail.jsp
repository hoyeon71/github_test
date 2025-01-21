<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@include file="/jsp/common/inc/header.jsp"%>
<%@include file="/jsp/common/inc/sessionChkPopup.jsp"%>

<%
	Map<String, Object> paramMap = CommonUtil.collectParameters(request);
	String c = CommonUtil.isNull(paramMap.get("c"));
	String aGb[] = null;
	
	String order_ymd 	= CommonUtil.isNull(paramMap.get("s_order_ymd"));
	String job_id 		= CommonUtil.isNull(paramMap.get("s_job_id"));
	
	
	String group_id      = CommonUtil.isNull(paramMap.get("jobgroup_id"));
	String group_nm      = CommonUtil.isNull(paramMap.get("jobgroup_nm"));
	String group_content = CommonUtil.isNull(paramMap.get("jobgroup_content"));
	String group_order   = CommonUtil.isNull(paramMap.get("group_order"));
// 	String schema        = CommonUtil.isNull(paramMap.get("SCHEMA"));
	String strSessionDcCode 	= S_D_C_CODE;
	String strSessionTab	 	= S_TAB;
	String strSessionApp	 	= S_APP;
	String strSessionGrp	 	= S_GRP;
	
// 	String strDcCode = strSessionDcCode.substring(strSessionDcCode.lastIndexOf(",")+1);
	String strPagingNum			= CommonUtil.getMessage("PAGING.NUM");
	
%>

<form id="f_s" name="f_s" method="post" onsubmit="return false;">
	<input type='hidden' id='user_nm' name='user_nm' />
	<input type='hidden' id='user_cd' name='user_cd' />
	
	<input type='hidden' id='data_center' 				name='data_center'/>
	<input type='hidden' id='p_search_gubun' 			name='p_search_gubun'/>
	<input type='hidden' id='p_search_gubun2' 			name='p_search_gubun2'/>
	<input type='hidden' id='p_search_text' 			name='p_search_text'/>
	<input type='hidden' id='p_search_text2' 			name='p_search_text2'/>
	
	<input type='hidden' id='p_sched_table' 			name='p_sched_table'/>
	<input type='hidden' id='p_application_of_def' 		name='p_application_of_def'/>
	<input type='hidden' id='p_group_name_of_def' 		name='p_group_name_of_def'/>
	<input type="hidden" id="p_mcode_nm"				name="p_mcode_nm"  />
	<input type="hidden" id="p_scode_nm"				name="p_scode_nm"  />
	<input type='hidden' id='p_moneybatchjob' 			name='p_moneybatchjob'/>
	<input type='hidden' id='p_critical' 				name='p_critical'/>
	
	<input type='hidden' id='p_application_of_def_text' name='p_application_of_def_text'/>
	<input type='hidden' id='p_group_name_of_def_text' 	name='p_group_name_of_def_text'/>
	
	<input type="hidden" id="startRowNum" 				name="startRowNum" 	value="0" />
	<input type="hidden" id="pagingNum" 				name="pagingNum" 	value="<%=strPagingNum%>" />
	
	<input type='hidden' id='S_USER_NM' 				name='S_USER_NM' value="<%=S_USER_NM%>"/>
	
	<!-- 그룹 작업 관련 -->
	<input type='hidden' id="p_jobgroup_id" 			name="p_jobgroup_id" value="<%=group_id%>"/>
	
	<input type="hidden" id="p_scode_cd"				name="p_scode_cd"  />
	<input type="hidden" id="p_grp_depth"				name="p_grp_depth"  />
	<input type="hidden" id="p_app_nm"					name="p_app_nm"  />
	<input type="hidden" id="p_app_search_gubun"		name="p_app_search_gubun"  />
	
	<!-- 그룹에 추가된 리스트 조회용 -->
	<input type='hidden' id='p_search_gubun_out' 			name='p_search_gubun_out'/>
	<input type='hidden' id='p_search_text_out' 			name='p_search_text_out'/>
	<input type='hidden' id='p_sched_table_out' 			name='p_sched_table_out'/>
	<input type='hidden' id='p_application_of_def_out' 		name='p_application_of_def_out'/>
	<input type='hidden' id='p_group_name_of_def_out' 		name='p_group_name_of_def_out'/>
	
</form>


<form id='DetailInsertFrom' name='DetailInsertFrom' method='post' onsubmit='return false;'>
	<input type='hidden' name='flag' 				id='flag' 				value='' />	
	<input type='hidden' name='check_table_ids' 	id='check_table_ids' />
	<input type='hidden' name='check_job_ids' 		id='check_job_ids' />
	<input type='hidden' name='check_data_centers' 	id='check_data_centers' />
	<input type='hidden' name='check_job_names' 	id='check_job_names' />
	<input type='hidden' name='check_table_names' 	id='check_table_names' />
	<input type='hidden' name='check_applications' 	id='check_applications' />
	<input type='hidden' name='check_group_names' 	id='check_group_names' />
	<input type='hidden' name='jobgroup_id' 		id='jobgroup_id' />
	<input type="hidden" name="jobgroup_name" 		id="jobgroup_name"		value="<%=group_nm%>"/>
	<input type="hidden" name="content" 			id="content"			value="<%=group_content%>"/>
</form>

<table style='width:100%;height:100%;border:none;' class='myOrder' >
	<tr style='height:10px;'>
		<td style='vertical-align:top; ' name='order'>
			<form name="frm1" id="frm1" method="post">
			<h4  class="ui-widget-header ui-corner-all" style="display:grid; height:77px; grid-template-columns: 1fr 1fr" >
				<div class='title_area'>
					C-M
					<select id="data_center_items" name="data_center_items" style="width:120px; height:21px;">
						<option value="">--선택--</option>
							<c:forEach var="cm" items="${cm}" varStatus="status">
								<option value="${cm.scode_cd},${cm.scode_eng_nm}">${cm.scode_nm}</option>
							</c:forEach>
					</select>
					<input type="hidden" id="data_center" name="data_center"  />
				</div>
				<div class='title_area'>
					조건
							<select name="search_gubun" id="search_gubun" style="width:120px;height:21px;min-width:120px">
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
							<input type="text" name="search_text" value="<%=S_USER_NM %>" id="search_text" style="width:150px;height:17px;min-width:100px;font-size:11px" />
				</div>
				<div class='title_area'>
					조건2
					<select name="search_gubun2" id="search_gubun2" style="width:120px;height:21px;">
							<option value="job_name">작업명</option>
							<option value="description">작업설명</option>
					</select>
					<input type="text" name="search_text2" value="" id="search_text2" style="width:150px;height:17px;"  />
				</div>
				<div class='title_area'>
					폴더
					<input type="text" name="table_nm" id="table_nm" style="width:120px; height:21px;" onkeydown="return false;" readonly/>&nbsp;<img id="btn_clear1" src="/images/sta2.png" style="width:16px;height:16px;vertical-align:middle;cursor:pointer;"/>
					<input type="hidden" name="table_of_def" id="table_of_def" />
				</div>
				
				<div class='title_area'>
					어플리케이션
					<select name="application_of_def" id="application_of_def" style="width:100px;height:21px;min-width:100px;">
						<option value="">--선택--</option>
					</select>
<!-- 					<input type='text' id='application_of_def_text' name='application_of_def_text' style="width:100px; height:17px; min-width:100px;"/>  -->
				</div>
				<div class='title_area'>
					그룹
					<select id="group_name_of_def" name="group_name_of_def" style="width:120px; height:21px;">
						<option value=''>--선택--</option>  
					</select>
<!-- 					<input type='text' id='group_name_of_def_text' name='group_name_of_def_text' style="width:110px; height:17px;"/> -->
					
					<input type='button' class='btn_blue_h20' value='조회' onclick="fn_search_list();" />
					
				</div>
			</h4>
			</form>
		</td>
		<td style='vertical-align:top;' >
			<form name="frm2" id="frm2" method="post">
				<h4  class="ui-widget-header ui-corner-all" style="display:grid; height:77px; grid-template-columns: 1fr 1fr" >
					<div class='title_area' >
						그룹명 : <%= group_nm %>
					</div>
					<div id='t_out' class='title_area' >
						비&nbsp;&nbsp;&nbsp;고 : <%= group_content %>
					</div>
					<div class='title_area'>
						조건
						<select name="search_gubun_out" id="search_gubun_out" style="width:120px;height:21px;">
								<option value="job_name">작업명</option>
								<option value="description">작업설명</option>
						</select>
						<input type="text" name="search_text_out" value="" id="search_text_out" style="width:150px;height:17px;"  />
					</div>
					<div class='title_area'>
						폴더
						<input type="text" name="table_nm_out" id="table_nm_out" style="width:120px; height:21px;" onkeydown="return false;" readonly/>&nbsp;<img id="btn_clear2" src="/images/sta2.png" style="width:16px;height:16px;vertical-align:middle;cursor:pointer;"/>
						<input type="hidden" name="table_of_def_out" id="table_of_def_out" />
					</div>
					
					<div class='title_area'>
						어플리케이션
						<select name="application_of_def_out" id="application_of_def_out" style="width:100px;height:21px;min-width:100px;">
							<option value="">--선택--</option>
						</select>
	<!-- 					<input type='text' id='application_of_def_text' name='application_of_def_text' style="width:100px; height:17px; min-width:100px;"/>  -->
					</div>
					<div class='title_area'>
						그룹
						<select id="group_name_of_def_out" name="group_name_of_def_out" style="width:120px; height:21px;">
							<option value=''>--선택--</option>  
						</select>
	<!-- 					<input type='text' id='group_name_of_def_text' name='group_name_of_def_text' style="width:110px; height:17px;"/> -->
						
						<input type='button' class='btn_blue_h20' value='조회' onclick="fn_search_list_out();" />
						
					</div>
				</h4>
			</form>
		</td>
	</tr>
	<tr>
		<td style='vertical-align:top;width:50%;' name="order">
			<table class='sub_table' style='width:100%;border:none;'>
				<tr>
					<td id='ly_g_in' style='vertical-align:top;' >	
						<div id="g_in" class="ui-widget-header ui-corner-all" ></div>
					</td>
				</tr>
				<tr style='height:10px;'>
					<td colspan='2' style='vertical-align:top;'>
						<h4  class="ui-widget-header ui-corner-all" >
							<div id='ly_in_total_cnt' style='padding-top:5px;float:left;'></div>
							<div align='right' class='btn_area' >
								<span id='btn_ins'>추가</span>
							</div>
						</h4>
					</td>
				</tr>
			</table>
		</td>

		<td style='vertical-align:top;width:50%;' >
			<table class='sub_table' style='width:100%;border:none;'>
				<tr>
					<td id='ly_g_out' style='vertical-align:top;' >
						<div id='g_out' class='ui-widget-header ui-corner-all'  ></div>
					</td>
				</tr>
				<tr style='height:10px;'>
					<td colspan='2' style='vertical-align:top;'>
						<h4  class="ui-widget-header ui-corner-all" >
							<div id='ly_out_total_cnt' style='padding-top:5px;float:left;'></div>
							<div align='right' class='btn_area' >
								<span id='btn_del'>삭제</span>
							</div>
						</h4>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	
	<tr style='height:2px;'><td colspan='2'></td></tr>
</table>

<script>
	var	strDcCode	= "";
	var job_listChk = false;
	var g_in = {
		id : 'g_in'
		,colModel:[
			{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'번호',width:50,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
			,{formatter:gridCellNoneFormatter,field:'SCHED_TABLE',id:'SCHED_TABLE',name:'폴더',width:80,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
			,{formatter:gridCellNoneFormatter,field:'APPLICATION',id:'APPLICATION',name:'어플리케이션',width:100,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
			,{formatter:gridCellNoneFormatter,field:'GROUP_NAME',id:'GROUP_NAME',name:'그룹',width:80,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
			,{formatter:gridCellNoneFormatter,field:'JOB_NAME',id:'JOB_NAME',name:'작업명',width:200,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
			,{formatter:gridCellNoneFormatter,field:'DESCRIPTION',id:'DESCRIPTION',name:'작업설명',width:200,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
			,{formatter:gridCellNoneFormatter,field:'DATA_CENTER',id:'DATA_CENTER',name:'C-M',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   	]
		,rows:[]
	};

	var g_out = {
		id : 'g_out'
		,colModel:[
		{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'번호',width:50,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
		,{formatter:gridCellNoneFormatter,field:'DATA_CENTER_NM',id:'DATA_CENTER_NM',name:'C-M',width:80,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
		,{formatter:gridCellNoneFormatter,field:'SCHED_TABLE',id:'SCHED_TABLE',name:'폴더',width:80,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
		,{formatter:gridCellNoneFormatter,field:'APPLICATION',id:'APPLICATION',name:'어플리케이션',width:100,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
		,{formatter:gridCellNoneFormatter,field:'GROUP_NAME',id:'GROUP_NAME',name:'그룹',width:80,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
		,{formatter:gridCellNoneFormatter,field:'JOB_NAME',id:'JOB_NAME',name:'작업명',width:200,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
		,{formatter:gridCellNoneFormatter,field:'DESCRIPTION',id:'DESCRIPTION',name:'작업설명',width:200,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
		,{formatter:gridCellNoneFormatter,field:'DATA_CENTER',id:'DATA_CENTER',name:'C-M',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
		]
		,rows:[]
	};
	
	$(document).ready(function(){
		var session_dc_code	= "<%=strSessionDcCode%>";
		var table_name		= "<%=strSessionTab%>";
		var application		= "<%=strSessionApp%>";
		var group_name		= "<%=strSessionGrp%>";
		var user_gb			= "<%=S_USER_GB%>";
		var group_order		= "<%=group_order%>"
		var arr_dt 			= "";

		if(group_order == "") {
			viewGridChk_1(g_in, 'ly_' + g_in.id);
			viewGridChk_1(g_out,'ly_'+g_out.id);
			//스크롤 페이징
			var grid = $('#'+g_in.id).data('grid');
			grid.onScroll.subscribe(function(e, args){
				var elem = $("#g_in").children(".slick-viewport");
				if ( elem[0].scrollHeight - elem.scrollTop() - elem.css("height").replace("px", "") + 17 < 100) {
					if(job_listChk) {
						job_listChk = false;
						var startRowNum = parseInt($("#startRowNum").val());
						startRowNum += parseInt($('#pagingNum').val());
						defJobsList(startRowNum);
					}
				}
			});
		}else{
			$('table.myOrder tr td[name="order"]').attr("style", "display:none");
			viewGrid_1(g_out,'ly_'+g_out.id);
			$("#btn_del").hide();
		}

		detailGrpList();
		
		var icons = null;
		if(session_dc_code != "") { // 개인정보에 C-M이 등록되어 있을경우
			$("select[name='data_center_items']").val(session_dc_code);
			$("#f_s").find("input[name='data_center']").val(session_dc_code);
			arr_dt = session_dc_code.split(",");
			strDcCode = arr_dt[1];
		}else { // 개인정보에 C-M이 등록이 되어있지 않을경우 -> C-M 콤보박스에서 첫번째값 선택
			$("#data_center_items option:eq(1)").prop("selected", true);
			$("#f_s").find("input[name='data_center']").val($("select[name='data_center_items']").val());
			arr_dt = $("select[name='data_center_items']").val().split(",");
			strDcCode = arr_dt[1];
		}
		
		
		if(table_name != '') {
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
		}
		$('#search_text').unbind('keypress').keypress(function(e){			
			if(e.keyCode==13){	
				var data_center_items = $("select[name='data_center_items'] option:selected").val();
						
				if(data_center_items == ""){
					alert("C-M 을 선택해 주세요.");
					return;
				}
				
				$("#f_s").find("input[name='p_search_gubun']").val($("#frm1").find("select[name='search_gubun'] option:selected").val());
				$("#f_s").find("input[name='p_search_text']").val($("#frm1").find("input[name='search_text']").val());
	 			$("#f_s").find("input[name='p_search_gubun2']").val($("#frm1").find("select[name='search_gubun2'] option:selected").val());
				$("#f_s").find("input[name='p_search_text2']").val($("#frm1").find("input[name='search_text2']").val());
				
				var char_len = 0;			
				<c:choose>
					<c:when test="${USER_GB eq '99'}">
						char_len = 5;
					</c:when>
					<c:otherwise>
						char_len = byteCheck("search_text"); 
					</c:otherwise>
				</c:choose>

				defJobsList();
			}
		});
		$('#search_text2').unbind('keypress').keypress(function(e){			
			if(e.keyCode==13){	
				var data_center_items = $("select[name='data_center_items'] option:selected").val();

				if(data_center_items == ""){
					alert("C-M 을 선택해 주세요.");
					return;
				}
				
				$("#f_s").find("input[name='p_search_gubun']").val($("#frm1").find("select[name='search_gubun'] option:selected").val());
				$("#f_s").find("input[name='p_search_text']").val($("#frm1").find("input[name='search_text']").val());
	 			$("#f_s").find("input[name='p_search_gubun2']").val($("#frm1").find("select[name='search_gubun2'] option:selected").val());
				$("#f_s").find("input[name='p_search_text2']").val($("#frm1").find("input[name='search_text2']").val());
				
				defJobsList();
			}
		});
		
		$('#search_text_out').unbind('keypress').keypress(function(e){			
			if(e.keyCode==13){	
				var data_center_items = $("select[name='data_center_items'] option:selected").val();
						
				if(data_center_items == ""){
					alert("C-M 을 선택해 주세요.");
					return;
				}
				
				$("#f_s").find("input[name='p_search_gubun_out']").val($("#frm1").find("select[name='search_gubun_out'] option:selected").val());
				$("#f_s").find("input[name='p_search_text_out']").val($("#frm1").find("input[name='search_text_out']").val());
				
				var char_len = 0;			
				<c:choose>
					<c:when test="${USER_GB eq '99'}">
						char_len = 5;
					</c:when>
					<c:otherwise>
						char_len = byteCheck("search_text_out"); 
					</c:otherwise>
				</c:choose>

				detailGrpList();
			}
		});
		$( document ).click(function(e){
			$('#ly_ContextMenu_01').hide();
			
			if(!$(e.target).is('#ly_searchMenu_01 *,#icon_searchMenu_01 *')) $('#ly_searchMenu_01').hide();
		}).contextmenu(function(e){
			
		});
		
		<c:if test="${USER_GB eq '99'}">
		$("#btn_txt_down").show();
		
		// 관리자는 담당자 default 검색 조건 제거
		$('#search_text').val("");
		
		</c:if>
	
		initIme();
		
		$("#btn_ins").button().unbind("click").click(function(){
			goPrc("detail_insert");
		});
		
		$("#btn_del").button().unbind("click").click(function(){
			goPrc("detail_delete");
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
					
			var data_center_items = $(this).val();
			if($(this).val() != ""){
				$("#f_s").find("input[name='data_center']").val(data_center_items);
			}
			arr_dt = $("select[name='data_center_items']").val().split(",");
			strDcCode = arr_dt[1];
		});

		$("#application_of_def").change(function(){
			$("#group_name_of_def option").remove();
			$("#group_name_of_def").append("<option value=''>--선택--</option>");
			
			var grp_info = $(this).val().split(",");
			
			$("#p_application_of_def").val(grp_info[1]);
			$("#p_group_name_of_def").val("");
			
			if (grp_info != "")
				getAppGrpCodeList("group_name_of_def", "3", "", grp_info[0]);
		});
		
		$("#group_name_of_def").change(function(){
			var grp_info = $(this).val().split(",");
			$("#p_group_name_of_def").val(grp_info[1]);
		});
		
		$('#application_of_def_text').on('keyup', function(event) {
			$('#p_application_of_def_text').val($(this).val());
		});
		
		$('#group_name_of_def_text').on('keyup', function(event) {
			$('#p_group_name_of_def_text').val($(this).val());
		});
		
		$("#btn_clear1").unbind("click").click(function(){
			$("#f_s").find("input[name='p_sched_table']").val("");
			$("#f_s").find("input[name='p_application_of_def']").val("");
			$("#f_s").find("input[name='p_group_name_of_def']").val("");
			
			$("#frm1").find("input[name='table_nm']").val("");
			$("#frm1").find("input[name='table_of_def']").val("");

			$("select[name='application_of_def'] option").remove();
			$("select[name='application_of_def']").append("<option value=''>--선택--</option>");
					
			$("select[name='group_name_of_def'] option").remove();
			$("select[name='group_name_of_def']").append("<option value=''>--선택--</option>");
		});
		
		$("#btn_clear2").unbind("click").click(function(){
			$("#f_s").find("input[name='p_sched_table_out']").val("");
			$("#f_s").find("input[name='p_application_of_def_out']").val("");
			$("#f_s").find("input[name='p_group_name_of_def_out']").val("");
			
			$("#frm2").find("input[name='table_nm_out']").val("");
			$("#frm2").find("input[name='table_of_def_out']").val("");

			$("select[name='application_of_def_out'] option").remove();
			$("select[name='application_of_def_out']").append("<option value=''>--선택--</option>");
					
			$("select[name='group_name_of_def_out'] option").remove();
			$("select[name='group_name_of_def_out']").append("<option value=''>--선택--</option>");
		});
		
		//테이블 클릭 시
		$("#table_nm").click(function(){
			var data_center = $("select[name='data_center_items'] option:selected").val();
			var select_table = $("input[name='table_nm']").val();
			if(data_center == ""){
				alert("C-M 을 선택해 주세요.");
				return;
			}else{
				searchPoeTabForm2(select_table);
			}		
		});
		
		$("#table_nm_out").click(function(){
			var data_center = $("select[name='data_center_items'] option:selected").val();
			var select_table = $("input[name='table_nm_out']").val();
			if(data_center == ""){
				alert("C-M 을 선택해 주세요.");
				return;
			}else{
				searchPoeTabForm3(select_table);
			}		
		});
		
	});
	
	// 그룹에 추가된 등록 LIST 조회
	function detailGrpList() {
		try{viewProgBar(true);}catch(e){}
		
		var grp_info = $("#frm2").find("select[name='application_of_def_out'] option:selected").val().split(",");
		var grp_info2 = $("#frm2").find("select[name='group_name_of_def_out'] option:selected").val().split(",");
		
 		$("#f_s").find("input[name='p_search_gubun_out']").val($("#frm2").find("select[name='search_gubun_out'] option:selected").val());
 		$("#f_s").find("input[name='p_search_text_out']").val($("#frm2").find("input[name='search_text_out']").val());
 		$("#f_s").find("input[name='p_sched_table_out']").val($("#frm2").find("input[name='table_nm_out']").val());
		$("#f_s").find("input[name='p_application_of_def_out']").val(grp_info[1]);
 		$("#f_s").find("input[name='p_group_name_of_def_out']").val(grp_info2[1]);
 		
 		
		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=detailGrpList&jobgroup_id=<%= group_id %>';
		
		var xhr = new XHRHandler(url, f_s, function(){
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
				
				if(items.attr('ctn')=='0') {
				}else {
					items.find('item').each(function(i){
						
						var data_center_nm	  = "";
						var data_center		  = $(this).find("DATA_CENTER").text();
						var sched             = $(this).find("SCHED_TABLE").text();
						var app               = $(this).find("APPLICATION").text();
						var group_nm          = $(this).find("GROUP_NAME").text();
						var job_nm            = $(this).find("JOB_NAME").text();
						var description       = $(this).find("DESCRIPTION").text();
						var table_id          = $(this).find("TABLE_ID").text();
						var job_id            = $(this).find("JOB_ID").text();
						
						<c:forEach var="cm" items="${cm}" varStatus="status">
							var scode_eng_nm = "${cm.scode_eng_nm}";
							if(data_center == scode_eng_nm) {
								data_center_nm = "${cm.scode_nm}";
							}
						</c:forEach>
						
						rowsObj.push({
							'grid_idx'		  : i+1
							,'DATA_CENTER_NM' : data_center_nm
							,'DATA_CENTER'    : data_center
							,'SCHED_TABLE'    : sched
							,'APPLICATION'    : app
							,'GROUP_NAME'     : group_nm
							,'JOB_NAME'       : job_nm
							,'DESCRIPTION'    : description
							,'JOB_ID'         : job_id
							,'TABLE_ID'       : table_id
						});
					});
				}
				var obj = null;
					obj = $("#g_out").data('gridObj');
					$('#ly_out_total_cnt').html('[ TOTAL : '+items.attr('cnt')+' ]');
				obj.rows = rowsObj;
				setGridRows(obj);
				
				
				clearGridSelected(obj);
			});
			try{viewProgBar(false);}catch(e){}
		},null);
		
		xhr.sendRequest();
	}
	
	
	// 수시작업 등록 LIST 조회
	function defJobsList(startRowNum) {
		clearGridSelected(g_in);
		
		if(startRowNum != '' && startRowNum != null && startRowNum != undefined) {
			$('#startRowNum').val(startRowNum);
		} else {
			var elem = $("#g_in").children(".slick-viewport");
			elem.scrollTop(0);
			startRowNum = 0;
			$('#startRowNum').val(0);
		}
		
		try{viewProgBar(true);}catch(e){}
		var data_center 			= $("#f_s").find("input[name='data_center']").val();		
		var search_gubun 			= $("#f_s").find("input[name='p_search_gubun']").val();
		var search_gubun2 			= $("#f_s").find("input[name='p_search_gubun2']").val();
		var search_text 			= $("#f_s").find("input[name='p_search_text']").val();
		var search_text2 			= $("#f_s").find("input[name='p_search_text2']").val();
		var sched_table 			= $("#f_s").find("input[name='p_sched_table']").val();
		var application_of_def 		= $("#f_s").find("input[name='p_application_of_def']").val();
		var group_name_of_def 		= $("#f_s").find("input[name='p_group_name_of_def']").val();
		var mcode_nm 				= $("#f_s").find("input[name='p_mcode_nm']").val();
		var scode_nm 				= $("#f_s").find("input[name='p_scode_nm']").val();
		var moneybatchjob 			= $("#f_s").find("input[name='p_moneybatchjob']").val();
		var critical 				= $("#f_s").find("input[name='p_critical']").val();
		var application_of_def_text	= $("#f_s").find("input[name='p_application_of_def_text']").val();
		var group_name_of_def_text 	= $("#f_s").find("input[name='p_group_name_of_def_text']").val();
		var startRowNum				= $("#f_s").find("input[name='startRowNum']").val();
		var pagingNum 				= $("#f_s").find("input[name='pagingNum']").val();
		var jobgroup_id 			= $("#f_s").find("input[name='p_jobgroup_id']").val();
		
		var formData = new FormData();
		
		formData.append("c", 							"cData2");
		formData.append("data_center", 					data_center);
		formData.append("itemGb", 						"emJobGroupDefJobList");
		formData.append("p_search_gubun", 				search_gubun);
		formData.append("p_search_text", 				search_text);
		formData.append("p_search_gubun2", 				search_gubun2);
		formData.append("p_search_text2", 				search_text2);
		formData.append("p_sched_table",				 sched_table);
		formData.append("p_application_of_def", 		application_of_def);
		formData.append("p_group_name_of_def", 			group_name_of_def);
		formData.append("p_mcode_nm", 					mcode_nm);
		formData.append("p_scode_nm", 					scode_nm);
		formData.append("p_moneybatchjob",	 			moneybatchjob);
		formData.append("p_critical", 					critical);
		formData.append("p_application_of_def_text", 	application_of_def_text);  
		formData.append("p_group_name_of_def_text", 	group_name_of_def_text);
		formData.append("startRowNum", 					startRowNum);
		formData.append("pagingNum", 					pagingNum);
		formData.append("jobgroup_id", 					jobgroup_id);
		
		var i = 0;
		var defJobsCnt = 0;
		
		$.ajax({
			url: "<%=sContextPath %>/common.ez",
			type: "POST",
			processData: false,
			contentType: false,
			dataType: "json",
			data: formData,
			success: function(data){
				
				var rowsObj = new Array();
				
				if(startRowNum != 0) {
					rowsObj = g_in.rows;
				}
				
				$.each(data, function(index, item){
					var p_data_center		= data[index].DATA_CENTER;
					var sched_table 		= data[index].SCHED_TABLE;
					var application			= data[index].APPLICATION;
					var group_name 			= data[index].GROUP_NAME;
					var description 		= data[index].DESCRIPTION;
					var ins_date 			= data[index].INS_DATE;
					var job_id 				= data[index].JOB_ID;
					var table_id 			= data[index].TABLE_ID;
					var job_name 			= data[index].JOB_NAME;
					var prev_doc_info		= data[index].PREV_DOC_INFO;
					var user_daily			= data[index].USER_DAILY;
					defJobsCnt 				= data[index].DEFJOBCNT;
					
					rowsObj.push({
						'grid_idx':i+1+startRowNum*1
						,'DATA_CENTER': p_data_center
						,'SCHED_TABLE': sched_table
						,'APPLICATION': application
						,'GROUP_NAME': group_name
						,'JOB_NAME': job_name
						,'DESCRIPTION': description
						,'JOB_ID': job_id
						,'TABLE_ID': table_id
					});	
					++i;
				});
				var obj = null;
				obj = $("#g_in").data('gridObj');
				obj.rows = rowsObj;
				setGridRows(obj);
		
			},
			error: function(data){
				alert("Data Reading Error... ");	
			},
			complete: function(data){
				$('#ly_in_total_cnt').html('[ TOTAL : '+(g_in.rows.length)+'/'+parseInt(defJobsCnt)+' ]');
				if( parseInt(g_in.rows.length) != parseInt(defJobsCnt) ) {
					job_listChk = true;
				}else{
					job_listChk = false;
				}
				try{viewProgBar(false);}catch(e){}
			}
		});	
	}
	
	function fn_search_list() {
		var data_center_items = $("select[name='data_center_items'] option:selected").val();
		
		if(data_center_items == ""){
			alert("C-M 을 선택해 주세요.");
			return;
		}
		
		$("#f_s").find("input[name='p_search_gubun']").val($("#frm1").find("select[name='search_gubun'] option:selected").val());
		$("#f_s").find("input[name='p_search_text']").val($("#frm1").find("input[name='search_text']").val());
		$("#f_s").find("input[name='p_search_gubun2']").val($("#frm1").find("select[name='search_gubun2'] option:selected").val());
		$("#f_s").find("input[name='p_search_text2']").val($("#frm1").find("input[name='search_text2']").val());

		defJobsList();
	}
	
	function fn_search_list_out() {
		var data_center_items = $("select[name='data_center_items'] option:selected").val();
		
		if(data_center_items == ""){
			alert("C-M 을 선택해 주세요.");
			return;
		}
		
		$("#f_s").find("input[name='p_search_gubun']").val($("#frm2").find("select[name='search_gubun'] option:selected").val());
		$("#f_s").find("input[name='p_search_text']").val($("#frm2").find("input[name='search_text']").val());
		$("#f_s").find("input[name='p_search_gubun2']").val($("#frm2").find("select[name='search_gubun2'] option:selected").val());
		$("#f_s").find("input[name='p_search_text2']").val($("#frm2").find("input[name='search_text2']").val());

		detailGrpList();
	}	
	
	
	function goSearch(){
		var f_s = document.f_s;
		
		f_s.target = "_self";
		f_s.action = "<%=sContextPath %>/works.do?c=<%=c %>"; 
		f_s.submit();
	}
	
	
	function goPrc(flag){
		
		var frm = document.DetailInsertFrom;
		var gridObj = null;
		var aSelRow = null;
		if(flag=='detail_insert') {
			if(!confirm("해당 내용을 추가 하시겠습니까?")) return;
			gridObj	= $('#g_in').data('gridObj');
			aSelRow	= $('#g_in').data('grid').getSelectedRows();
			if(aSelRow.length == 0) {
				alert("선택된 그룹이 없습니다.");
				return;
			}
		} else {
			if(!confirm("해당 내용을 삭제 하시겠습니까?")) return;
			gridObj	= $('#g_out').data('gridObj');
			aSelRow	= $('#g_out').data('grid').getSelectedRows();
			if(aSelRow.length == 0) {
				alert("선택된 그룹이 없습니다.");
				return;
			}
		}
		try{viewProgBar(false);}catch(e){console.error(e);}
		
		var strFolSum 		= "";
		
		var strTableSum   = "";
		var strDcenterSum = "";
		var strJidSum    = "";
		var strJobnmSum   = "";
		var strTabnmSum   = "";
		var strApplSum   = "";
		var strGrpnmSum   = "";
		
		
		if(aSelRow.length>0){
			for(var i=0;i<aSelRow.length;i++){
				var strTable	 	= getCellValue(gridObj,aSelRow[i],'TABLE_ID');
// 				var strDcenter	 	= strDcCode;
				var strDcenter	 	= getCellValue(gridObj,aSelRow[i],'DATA_CENTER');
				var strJid	 	    = getCellValue(gridObj,aSelRow[i],'JOB_ID');
				var strJobnm	 	= getCellValue(gridObj,aSelRow[i],'JOB_NAME');
				var strTabnm	 	= getCellValue(gridObj,aSelRow[i],'SCHED_TABLE');
				var strAppl		 	= getCellValue(gridObj,aSelRow[i],'APPLICATION');
				var strGrpnm	 	= getCellValue(gridObj,aSelRow[i],'GROUP_NAME');
				
				if(strTableSum != "")   strTableSum		+= ",";
				if(strDcenterSum != "") strDcenterSum	+= ",";
				if(strJidSum != "")     strJidSum		+= ",";
				if(strJobnmSum != "")   strJobnmSum		+= ",";
				if(strTabnmSum != "")   strTabnmSum		+= ",";
				if(strApplSum != "")    strApplSum		+= ",";
				if(strGrpnmSum != "")   strGrpnmSum		+= ",";
				
				strTableSum 		+= strTable;
				strDcenterSum       += strDcenter;
				strJidSum           += strJid;
				strJobnmSum         += strJobnm;
				strTabnmSum         += strTabnm;
				strApplSum          += strAppl;
				strGrpnmSum        	+= strGrpnm;
				
				
			}
		}
		
		frm.flag.value					= flag;
		frm.check_table_ids.value		= strTableSum;
		frm.check_job_ids.value			= strJidSum;
		frm.check_data_centers.value	= strDcenterSum;
		frm.check_job_names.value		= strJobnmSum;
		frm.check_table_names.value		= strTabnmSum;
		frm.check_applications.value	= strApplSum;
		frm.check_group_names.value		= strGrpnmSum;
		frm.jobgroup_id.value			= "<%=group_id%>";
		
 		frm.target = prcFrameId;
 		if(flag == "detail_insert"){
			frm.action		= "<%=sContextPath%>/tWorks.ez?c=ez020_group_i";
 		}else{
 			frm.action		= "<%=sContextPath%>/tWorks.ez?c=ez020_group_d";
 		}
		frm.submit();
		try{viewProgBar(false);}catch(e){console.error(e);}
	}
	
	function selectTable(eng_nm, desc, user_daily, grp_cd){
		
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
	
	function selectTable2(eng_nm, desc, user_daily, grp_cd){
		
		$("#table_nm_out").val(eng_nm);
		$("#table_of_def_out").val(eng_nm);
		
		dlClose("dl_tmp1");

		$("#f_s").find("input[name='p_sched_table_out']").val(eng_nm);
		$("#f_s").find("input[name='p_application_of_def_out']").val("");
		$("#f_s").find("input[name='p_group_name_of_def_out']").val("");
		
		//어플리케이션 초기화
		$("select[name='application_of_def_out'] option").remove();
		$("select[name='application_of_def_out']").append("<option value=''>--선택--</option>");
		
		//그룹초기화
		$("select[name='group_name_of_def_out'] option").remove();
		$("select[name='group_name_of_def_out']").append("<option value=''>--선택--</option>");
		
		
		// 어플리케이션, 그룹 자동 셋팅
		if(eng_nm.indexOf(",") == -1) { // 한개의 폴더 검색일 때
			getAppGrpCodeList("application_of_def_out", "2", "", grp_cd); // 어플리케이션을 검색
			
			// 어플이 하나만 존재하면 자동 세팅
			if($("select[name='application_of_def_out'] option").length == 2){
				$("select[name='application_of_def_out'] option:eq(1)").prop("selected", true);
				
				var grp_info = $("select[name='application_of_def_out']").val().split(",");
				$("#p_application_of_def_out").val(grp_info[1]);
				
				if (grp_info != "") {
					getAppGrpCodeList("group_name_of_def_out", "3", "", grp_info[0]);
				} else {
					getAppGrpCodeList("group_name_of_def_out", "3", "", "");
				}
				
				// 그룹이 하나만 존재하면 자동 세팅
				if($("select[name='group_name_of_def_out'] option").length == 2){
					$("select[name='group_name_of_def_out'] option:eq(1)").prop("selected", true);
					grp_info = $("select[name='group_name_of_def_out']").val().split(",");
					$("#p_group_name_of_def_out").val(grp_info[1]);
				}
			}
		}
	}
	
	
</script>

