<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/jsp/common/inc/header.jsp"%>

<%
	Map<String, Object> paramMap = CommonUtil.collectParameters(request);
	String c = CommonUtil.isNull(paramMap.get("c"));
	String gridId = "g_"+c;

	String menu_gb = CommonUtil.getMessage("CATEGORY.GB.02.GB."+CommonUtil.isNull(paramMap.get("menu_gb")));
	String[] arr_menu_gb = menu_gb.split(",");

	// 세션값 가져오기.
	String strSessionDcCode 	= S_D_C_CODE;
	String strSessionApp        = S_APP;
	String strSessionGrp        = S_GRP;
%>

<form id="f_s" name="f_s" method="post" onsubmit="return false;">
	<input type='hidden' id='data_center_code' name='data_center_code'/>
	<input type='hidden' id='data_center' name='data_center'/>
	<input type='hidden' id='active_net_name' name='active_net_name'/>
	<input type='hidden' id='p_application_of_def' name='p_application_of_def'/>
	<input type='hidden' id='p_group_name_of_def' name='p_group_name_of_def'/>
	<input type='hidden' id='p_search_gubun' name='p_search_gubun'/>
	<input type='hidden' id='p_search_text' name='p_search_text'/>
	<input type='hidden' id='searchType' name='searchType'/>
	<input type='hidden' id='S_USER_NM' name='S_USER_NM' value="<%=S_USER_NM%>"/>
	<input type="hidden" id="p_from_odate" name="p_from_odate"/>
	<input type="hidden" id="p_to_odate" name="p_to_odate"/>
	<input type="hidden" id="p_severity" name="p_severity"/>
	<input type="hidden" id="p_search_start_time1" name="p_search_start_time1"/>
	<input type="hidden" id="p_search_end_time1" name="p_search_end_time1"/>
	<input type="hidden" id="p_search_action_yn" name="p_search_action_yn"/>
	<input type="hidden" id="p_alarm_cd" name="p_alarm_cd"/>
	<input type="hidden" name="menu_gb" id="menu_gb" value="${paramMap.menu_gb}" />
	<input type="hidden" name="p_mcode_nm" id="p_mcode_nm" />
	<input type="hidden" name="p_scode_nm" id="p_scode_nm" />

	<input type="hidden" name="p_scode_cd" id="p_scode_cd" />
	<input type="hidden" name="p_grp_depth" id="p_grp_depth" />
	<input type="hidden" name="p_app_nm" id="p_app_nm" />
	<input type="hidden" name="p_app_search_gubun" id="p_app_search_gubun" />

	<input type="hidden" id="error_only" name="error_only" value="Y"/>
</form>
<form id="form2" name="form2" method="post" onsubmit="return false;">
	<input type='hidden' name='flag' 					id='flag'/>
	<input type='hidden' name='flag2' 					id='flag2'/>
	<input type="hidden" name="user_cd" 				id="user_cd" />
	<input type="hidden" name="recur_yn" 				id="recur_yn" />
	<input type="hidden" name="error_gubun" 			id="error_gubun" />
	<input type="hidden" name="solution_description" 	id="solution_description" />
	<input type="hidden" name="alarm_cd" 				id="alarm_cd"/>
	<input type='hidden' name='p_title'	 				id='p_title' />
	<input type='hidden' name='p_host_date'	 			id='p_host_date' />
	<input type='hidden' name='doc_gb'	 				id='doc_gb'  		value='11'/>
	<input type='hidden' name='title' 					id='title' 			/>
</form>
<table style='width:100%;height:100%;border:none;'>
	<tr style='height:10px;'>
		<td style='vertical-align:top;'>
			<h4 class="ui-widget-header ui-corner-all"  >
				<div id='t_<%=gridId %>' class='title_area' >
					<span><%=CommonUtil.isNull(arr_menu_gb[0]) %></span>
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
					<th width="10%"><div class='cellTitle_kang2'>C-M</div></th>
					<td width="25%" style="text-align:left">
						<div class='cellContent_kang'>
						<select id="data_center_items" name="data_center_items" style="width:98%; height:21px;">
							<option value="">--선택--</option>
							<c:forEach var="cm" items="${cm}" varStatus="status">
								<option value="${cm.scode_cd},${cm.scode_eng_nm}">${cm.scode_nm}</option>
							</c:forEach>
						</select>
						</div>
					</td>

					<th width="10%"><div class='cellTitle_kang2'>어플리케이션(L3)</div></th>
					<td width="20%" style="text-align:left">
						<div class='cellContent_kang'>
							<input type="text" name="app_nm" id="app_nm" style="width:80%; height:21px;" readOnly/>&nbsp;<img id="btn_clear1" src="/images/sta2.png" style="width:16px;height:16px;vertical-align:middle;cursor:pointer;"/>
							<input type="hidden" name="application_of_def" id="application_of_def" />
						</div>
					</td>

					<th width="10%"><div class='cellTitle_kang2'>어플리케이션(L4)</div></th>
					<td width="15%" style="text-align:left">
						<div class='cellContent_kang'>
						<select id="group_name_of_def" name="group_name_of_def" style="width:70%; height:21px;">
							<option value=''>--선택--</option>
						</select>
						</div>
					</td>
				</tr>
				<tr>
					<th><div class='cellTitle_kang2'>일자</div></th>
					<td style="text-align:left">
						<div class='cellContent_kang'>
						<input type="text" name="from_odate" id="from_odate" value="${FROM_ODATE}" class="input datepick" style="width:60px; height:21px;" maxlength="10" readOnly/>
						<%-- <select name="search_start_time1" id="search_start_time1" style="height:21px;">
							<%
								String strI = "";
								for(int i=0; i<25; i++){
									if (i < 10 ) {
										strI = "0" + Integer.toString(i);
									} else {
										strI = Integer.toString(i);
									}
							%>
								<option value="<%=strI%>" <%="08".equals(strI)? " selected ":""%> ><%=strI%></option>
							<%
								}
							%>
						</select> 시	  --%>
						 ~
						<input type="text" name="to_odate" id="to_odate" value="${TO_ODATE}" class="input datepick" style="width:60px; height:21px;" maxlength="10" readOnly/>
						<%-- <select name="search_end_time1" id="search_end_time1" style="height:21px;">
							<%
								for(int i=0; i<25; i++){
									if (i < 10 ) {
										strI = "0" + Integer.toString(i);
									} else {
										strI = Integer.toString(i);
									}
							%>
								<option value="<%=strI%>" <%="07".equals(strI)? " selected ":""%> ><%=strI%></option>
							<%
								}
							%>
						</select> 시 --%>
						</div>
					</td>

					<th><div class='cellTitle_kang2'>구분</div></th>
					<td style="text-align:left">
						<div class='cellContent_kang'>
						<select name="search_gubun" id="search_gubun" style="width:28%; height:21px;">
							<option value="job_name">작업명</option>
							<option value="user_nm">담당자</option>
							<option value="error_description">조치내용</option>
						</select>
						<input type="text" name="search_text" value="" id="search_text" class="input" style="width:48%; height:21px;"/>
						&nbsp;<img id="btn_clear2" src="/images/sta2.png" style="width:16px;height:16px;vertical-align:middle;cursor:pointer;"/>
						</div>
					</td>

					<th><div class='cellTitle_kang2'>조치</div></th>
					<td style="text-align:left">
						<div class='cellContent_kang'>
						<select name="search_action_yn" style="width:70%; height:21px;">
							<option value="">--선택--</option>
							<option value="Y">Y</option>
							<option value="N">N</option>
						</select>
						</div>
					</td>
				</tr>
				<tr>
					<th><div class='cellTitle_kang2'>대그룹</div></th>
					<td style="text-align:left">
						<div class='cellContent_kang'>
						<select id="mcode_nm" name="mcode_nm" style="width:98%; height:21px;">
							<option value=''>--선택--</option>
							<c:forEach var="mcode" items="${mcodeList}" varStatus="s">
								<option value="${mcode.mcode_nm}">${mcode.mcode_desc}</option>
							</c:forEach>
						</select>
						</div>
					</td>

					<th><div class='cellTitle_kang2'>소그룹</div></th>
					<td style="text-align:left">
						<div class='cellContent_kang'>
							<input type="text" name="scode_nm" id="scode_nm" style="width:85%; height:21px;" readOnly/>
							&nbsp;<img id="btn_clear3" src="/images/sta2.png" style="width:16px;height:16px;vertical-align:middle;cursor:pointer;"/>
						</div>
					</td>

					<th></th>
					<td></td>
				</tr>

				<tr>
					<td style="text-align:left;" colspan="5">
						재발가능성여부 : <select name='all_recur_yn' id='all_recur_yn'>
								<option value='N'>N</option>
								<option value='Y'>Y</option>
								</select>&nbsp;&nbsp;
						오류구분 : <select name='all_error_gubun' id='all_error_gubun'>
									<option value=''>--선택--</option>
									<c:forEach var="codeList" items="${sCodeList}" varStatus="s">
										<option value='${codeList.scode_cd}'>${codeList.scode_nm}</option>
									</c:forEach>
									</select>&nbsp;&nbsp;
						<br/>오류원인 및 해결방안 : <textarea name='all_solution_description' id='all_solution_description' style='width:30%;height:15px;'></textarea>&nbsp;&nbsp;
						<span id="btn_all_draft" style='display:none;'>일괄승인</span>
					</td>
					<td colspan="6" style="text-align:right;">
						<!-- <span id="btn_search" style='display:none;'>검색</span> -->
						<img id="btn_search" src='<%=sContextPath%>/imgs/btn_SRC.gif' style='border:0;vertical-align:top;cursor:pointer;' />
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
					<span id="btn_down">엑셀</span>
				</div>
			</h4>
		</td>
	</tr>
</table>
<script>

	function gridCellCustomFormatter(row,cell,value,columnDef,dataContext){

		var ret = "";
		var alarm_cd = getCellValue(gridObj,row,'ALARM_CD');
		var job_name = getCellValue(gridObj,row,'JOB_NAME');
		var ori_error_gubun = getCellValue(gridObj,row,'ORI_ERROR_GUBUN');

		if(columnDef.id == 'JOB_NAME'){
			ret = "<a href=\"JavaScript:alertErrorInsert('"+alarm_cd+"','"+job_name+"','"+ori_error_gubun+"');\" /><font color='red'>"+value+"</font></a>";
		}

		return ret;
	}

	var gridObj = {
		id : "<%=gridId %>"
		,colModel:[
	   		{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'번호',width:50,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	   		,{formatter:gridCellCustomFormatter,field:'JOB_NAME',id:'JOB_NAME',name:'작업명',width:200,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'RUN_COUNTER',id:'RUN_COUNTER',name:'수행횟수',width:70,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'HOST_TIME',id:'HOST_TIME',name:'발생시간',width:150,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'UPDATE_TIME',id:'UPDATE_TIME',name:'조치시간',width:150,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'ACTION_YN',id:'ACTION_YN',name:'조치',width:60,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'ERROR_DESCRIPTION',id:'ERROR_DESCRIPTION',name:'원인 및 조치내용',width:150,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'ACTION_GUBUN',id:'ACTION_GUBUN',name:'ACTION',width:60,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'DEPT_NM',id:'DEPT_NM',name:'부서',width:100,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'DUTY_NM',id:'DUTY_NM',name:'직급',width:100,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'USER_NM',id:'USER_NM',name:'담당자',width:100,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}

	   		,{formatter:gridCellNoneFormatter,field:'RECUR_YN',id:'RECUR_YN',name:'재발가능성',width:80,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'ERROR_GUBUN',id:'ERROR_GUBUN',name:'오류구분',width:450,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'SOLUTION_DESCRIPTION',id:'SOLUTION_DESCRIPTION',name:'오류원인 및 해결방안',width:150,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}

	   		,{formatter:gridCellNoneFormatter,field:'ALARM_CD',id:'ALARM_CD',name:'ALARM_CD',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   		,{formatter:gridCellNoneFormatter,field:'USER_CD',id:'USER_CD',name:'USER_CD',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   		,{formatter:gridCellNoneFormatter,field:'ORI_ERROR_GUBUN',id:'ORI_ERROR_GUBUN',name:'ORI_ERROR_GUBUN',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   		,{formatter:gridCellNoneFormatter,field:'APPLICATION',id:'APPLICATION',name:'APPLICATION',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   	]
		,rows:[]
		,vscroll:<%=S_GRID_VSCROLL%>
	};

	$(document).ready(function(){

		var session_dc_code	= "<%=strSessionDcCode%>";
		var session_app	= "<%=strSessionApp%>";
		var session_grp	= "<%=strSessionGrp%>";

		$("#btn_all_draft").show();
		$("#btn_search").show();

		var data_center_items = $("select[name='data_center_items'] option:selected").val();
		var application_of_def = $("input[name='application_of_def']").val();

		$("#f_s").find("input[name='p_severity']").val($("#frm1").find("input:radio[name='severity']:checked").val());
		$("#f_s").find("input[name='p_search_gubun']").val($("#frm1").find("select[name='search_gubun'] option:selected").val());
		$("#f_s").find("input[name='p_search_text']").val($("#frm1").find("input[name='search_text']").val());
		$("#f_s").find("input[name='p_from_odate']").val($("#frm1").find("input[name='from_odate']").val());
		$("#f_s").find("input[name='p_to_odate']").val($("#frm1").find("input[name='to_odate']").val());
		$("#f_s").find("input[name='p_search_start_time1']").val($("#frm1").find("select[name='search_start_time1'] option:selected").val());
		$("#f_s").find("input[name='p_search_end_time1']").val($("#frm1").find("select[name='search_end_time1'] option:selected").val());
		$("#f_s").find("input[name='p_search_action_yn']").val($("#frm1").find("select[name='search_action_yn'] option:selected").val());

		viewGridChk_1(gridObj,"ly_"+gridObj.id);

		$("select[name='data_center_items']").val(session_dc_code);
		$("#f_s").find("input[name='data_center']").val(session_dc_code);
		if(session_app != ''){
			$("input[name='app_nm']").val(session_app);
			$("#f_s").find("input[name='application_of_def']").val(session_app);
			selectApplication(session_app,session_app);
			setTimeout(function(){
				$("select[name='group_name_of_def']").val(session_grp).prop("seleted", true);
			}, 500);
		}

		if(data_center_items != "" && application_of_def != ""){
			alertErrorList();
		}

		$("#btn_search").button().unbind("click").click(function(){

			var data_center_items = $("select[name='data_center_items'] option:selected").val();
			var application_of_def = $("input[name='application_of_def']").val();
			var group_name_of_def = $("select[name='group_name_of_def'] option:selected").val();

			if(data_center_items == ""){
				alert("C-M 을 선택해 주세요.");
				return;
			}

			/*if(application_of_def == ""){
				alert("애플리케이션을 선택해 주세요.");
				return;
			}

			if(group_name_of_def == ""){
				alert("그룹을 선택해 주세요.");
				return;
			}*/

			$("#f_s").find("input[name='p_severity']").val($("#frm1").find("input:radio[name='severity']:checked").val());
			$("#f_s").find("input[name='p_search_gubun']").val($("#frm1").find("select[name='search_gubun'] option:selected").val());
			$("#f_s").find("input[name='p_search_text']").val($("#frm1").find("input[name='search_text']").val());
			$("#f_s").find("input[name='p_from_odate']").val($("#frm1").find("input[name='from_odate']").val());
			$("#f_s").find("input[name='p_to_odate']").val($("#frm1").find("input[name='to_odate']").val());
			$("#f_s").find("input[name='p_search_start_time1']").val($("#frm1").find("select[name='search_start_time1'] option:selected").val());
			$("#f_s").find("input[name='p_search_end_time1']").val($("#frm1").find("select[name='search_end_time1'] option:selected").val());
			$("#f_s").find("input[name='p_search_action_yn']").val($("#frm1").find("select[name='search_action_yn'] option:selected").val());

			if ( $("#p_from_odate").val() != "" && $("#p_to_odate").val() != "" ) {

				// 날짜 기간 체크
				if ( $("#p_from_odate").val() > $("#p_to_odate").val() ) {
					alert("일자의 FROM ~ TO를 확인해 주세요.");
					return;
				}
			}

			var mcode_nm = $("#frm1").find("select[name='mcode_nm'] option:selected").val();
			var arr_mcode_nm = mcode_nm.split(",");
			$("#f_s").find("input[name='p_mcode_nm']").val(arr_mcode_nm[1]);
			//$("#f_s").find("input[name='p_scode_nm']").val($("#frm1").find("input[name='scode_nm']").val());

			/*
			var char_len = 0;
			<c:choose>
				<c:when test="${USER_GB eq '99'}">
					char_len = 5;
				</c:when>
				<c:otherwise>
					char_len = byteCheck("search_text");
				</c:otherwise>
			</c:choose>
			if($("select[name='search_gubun'] option:selected").val() == "user_nm" || $("select[name='search_gubun'] option:selected").val() == "error_description"){
				if(char_len < 4){
					alert("검색어의 경우 한글은 2자이상, 영문은 4자 이상 입력해 주세요.");
					$("#search_text").focus();
					return;
				}else{
					alertErrorList();
				}
			}else if($("select[name='search_gubun'] option:selected").val() == "job_name"){
				if(char_len < 3){
					alert("검색어를 3자이상 입력해 주세요.");
					$("#search_text").focus();
					return;
				}else{
					alertErrorList();
				}
			}
			*/

			// 구분의 검색어 입력 필요없이 조회 가능하게 수정.
			alertErrorList();

		});

		$('#search_text').unbind('keypress').keypress(function(e){
			if(e.keyCode==13){

				var data_center_items = $("select[name='data_center_items'] option:selected").val();
				var application_of_def = $("input[name='application_of_def']").val();
				var group_name_of_def = $("select[name='group_name_of_def'] option:selected").val();

				if(data_center_items == ""){
					alert("C-M 을 선택해 주세요.");
					return;
				}

				/*if(application_of_def == ""){
					alert("애플리케이션을 선택해 주세요.");
					return;
				}

				if(group_name_of_def == ""){
					alert("그룹을 선택해 주세요.");
					return;
				}*/

				$("#f_s").find("input[name='p_severity']").val($("#frm1").find("input:radio[name='severity']:checked").val());
				$("#f_s").find("input[name='p_search_gubun']").val($("#frm1").find("select[name='search_gubun'] option:selected").val());
				$("#f_s").find("input[name='p_search_text']").val($("#frm1").find("input[name='search_text']").val());
				$("#f_s").find("input[name='p_from_odate']").val($("#frm1").find("input[name='from_odate']").val());
				$("#f_s").find("input[name='p_to_odate']").val($("#frm1").find("input[name='to_odate']").val());
				$("#f_s").find("input[name='p_search_start_time1']").val($("#frm1").find("select[name='search_start_time1'] option:selected").val());
				$("#f_s").find("input[name='p_search_end_time1']").val($("#frm1").find("select[name='search_end_time1'] option:selected").val());
				$("#f_s").find("input[name='p_search_action_yn']").val($("#frm1").find("select[name='search_action_yn'] option:selected").val());

				var mcode_nm = $("#frm1").find("select[name='mcode_nm'] option:selected").val();
				var arr_mcode_nm = mcode_nm.split(",");
				$("#f_s").find("input[name='p_mcode_nm']").val(arr_mcode_nm[1]);
				//$("#f_s").find("input[name='p_scode_nm']").val($("#frm1").find("input[name='scode_nm']").val());

				/*
				var char_len = 0;
				<c:choose>
					<c:when test="${USER_GB eq '99'}">
						char_len = 5;
					</c:when>
					<c:otherwise>
						char_len = byteCheck("search_text");
					</c:otherwise>
				</c:choose>
				if($("select[name='search_gubun'] option:selected").val() == "user_nm" || $("select[name='search_gubun'] option:selected").val() == "error_description"){
					if(char_len < 4){
						alert("검색어의 경우 한글은 2자이상, 영문은 4자 이상 입력해 주세요.");
						$("#search_text").focus();
						return;
					}else{
						alertErrorList();
					}
				}else if($("select[name='search_gubun'] option:selected").val() == "job_name"){
					if(char_len < 3){
						alert("검색어를 3자이상 입력해 주세요.");
						$("#search_text").focus();
						return;
					}else{
						alertErrorList();
					}
				}
				*/

				alertErrorList();
			}
		});

		$("#data_center_items").change(function(){

			//초기화
			$("#app_nm").val("");
			$("#application_of_def").val("");

			$("select[name='group_name_of_def'] option").remove();
			$("select[name='group_name_of_def']").append("<option value=''>--선택--</option>");

			var data_center_items = $(this).val();
			var arr_dt = data_center_items.split(",");
			//if($(this).val() != ""){
			$("#f_s").find("input[name='data_center']").val(data_center_items);
			$("#f_s").find("input[name='p_application_of_def']").val("");
			$("#f_s").find("input[name='p_group_name_of_def']").val("");
			//getAppGrpCodeList(arr_dt[0], "1", "", "application_of_def","");
			//}
		});

		$("#btn_down").button().unbind("click").click(function(){
			goExcel();
		});

		$("#from_odate").addClass("ime_readonly").unbind('click').click(function(){
			dpCalMin(this.id,'yymmdd');
		});

		$("#to_odate").addClass("ime_readonly").unbind('click').click(function(){
			dpCalMin(this.id,'yymmdd');
		});

		//애플리케이션 클릭시
		$("#app_nm").click(function(){
			var data_center = $("select[name='data_center_items'] option:selected").val();

			if(data_center == ""){
				alert("C-M 을 선택해 주세요.");
				return;
			}else{
				searchPoeAppForm();
			}
		});

		$("#group_name_of_def").change(function(){

			var group_name_of_def = $("select[name='group_name_of_def'] option:selected").val();

			$("#f_s").find("input[name='p_group_name_of_def']").val(group_name_of_def);
		});

		$("#mcode_nm").change(function(){
			$("#scode_nm").val("");
			$("#f_s").find("input[name='p_scode_nm']").val("");
		});

		$("#scode_nm").click(function(){

			var mcode_nm = $("select[name='mcode_nm'] option:selected").val();
			//var arr_mcode_nm = mcode_nm.split(",");
			if(mcode_nm == ""){
				alert("대그룹을 선택해 주세요.");
				return;
			}

			popScodeSearchForm(mcode_nm);
		});

		$("#btn_clear1").unbind("click").click(function(){
			$("#f_s").find("input[name='p_application_of_def']").val("");
			$("#f_s").find("input[name='p_group_name_of_def']").val("");

			$("#frm1").find("input[name='app_nm']").val("");
			$("#frm1").find("input[name='application_of_def']").val("");

			$("select[name='group_name_of_def'] option").remove();
			$("select[name='group_name_of_def']").append("<option value=''>--선택--</option>");
		});

		$("#btn_clear2").unbind("click").click(function(){
			$("#frm1").find("input[name='search_text']").val("");
		});
		$("#btn_clear3").unbind("click").click(function(){
			$("#frm1").find("input[name='scode_nm']").val("");
			$("#f_s").find("input[name='p_scode_nm']").val("");
		});


		$("#btn_all_draft").button().unbind("click").click(function(){


			if(confirm("해당 내용을 일괄 승인 하시겠습니까?")){

				var f = document.form2;
				var alarm_cd 	= "";
				var user_cd 	= "";
				var host_date   = "";
				var title   = "";
				var aSelRow = new Array;
				aSelRow = $('#'+gridObj.id).data('grid').getSelectedRows();

				if(aSelRow.length>0){
					for(var i=0;i<aSelRow.length;i++){
						alarm_cd 	= alarm_cd  + "," + getCellValue(gridObj,aSelRow[i],'ALARM_CD');
						user_cd 	= user_cd  + "," + getCellValue(gridObj,aSelRow[i],'USER_CD');
						host_date 	= host_date  + "," + getCellValue(gridObj,aSelRow[i],'HOST_TIME');
						title		= title+ ',' + "[<%=S_USER_NM%>]작업 오류 원인 및 재발 방지 대책 보고 ["+getCellValue(gridObj,aSelRow[i],'JOB_NAME')+"("+getCellValue(gridObj,aSelRow[i],'APPLICATION')+")]"
					}

				}else{
					alert("승인하려는 항목을 선택해 주세요.");
					return;
				}

				if($('#all_solution_description').val() == ''){
					alert("오류원인 및 해결방안은 필수입력 사항입니다.");
					return;
				}

				alarm_cd 	 	= alarm_cd.substring(1, alarm_cd.length);
				user_cd 	 	= user_cd.substring(1, user_cd.length);
				host_date 	 	= host_date.substring(1, host_date.length);
				title 	 		= title.substring(1, title.length);

				f.alarm_cd.value = alarm_cd;
				f.user_cd.value = user_cd;

				f.recur_yn.value = $('#all_recur_yn').val();
				f.error_gubun.value = $('#all_error_gubun').val();
				f.solution_description.value = $('#all_solution_description').val();
				f.flag2.value   					= 'user_udt';
				f.p_title.value 					= title;
				f.p_host_date.value 				= host_date;
				f.title.value = title;

				try{viewProgBar(true);}catch(e){}

				f.flag.value = "draft_all";
				f.target = "if1";
				f.action = "<%=sContextPath %>/tWorks.ez?c=ez004_p";
				f.submit();
				clearGridSelected(gridObj);		//선택된 전체항목 해제 */
				try{viewProgBar(false);}catch(e){}
				alertErrorList();
				f.recur_yn.value = "";
				$('#all_recur_yn').val("N");
				f.error_gubun.value = "";
				$('#all_error_gubun').val("");
				f.solution_description.value = "";
				$('#all_solution_description').val("");

			}
		});
	});

	function alertErrorList(){

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

						if(items.attr('cnt')=='0'){
						}else{
							items.find('item').each(function(i){

								var host_time = $(this).find("HOST_TIME").text();
								var job_name = $(this).find("JOB_NAME").text();
								var run_counter = $(this).find("RUN_COUNTER").text();
								var dept_nm = $(this).find("DEPT_NM").text();
								var duty_nm = $(this).find("DUTY_NM").text();
								var user_nm = $(this).find("USER_NM").text();
								var action_yn = $(this).find("ACTION_YN").text();
								var update_time = $(this).find("UPDATE_TIME").text();
								var action_gubun = $(this).find("ACTION_GUBUN").text();
								var recur_yn = $(this).find("RECUR_YN").text();
								var error_gubun = $(this).find("ERROR_GUBUN").text();
								var error_desc = $(this).find("ERROR_DESCRIPTION").text();
								var solution_desc = $(this).find("SOLUTION_DESCRIPTION").text();
								var alarm_cd = $(this).find("ALARM_CD").text();
								var user_cd = $(this).find("USER_CD").text();
								var application = $(this).find("APPLICATION").text();
								var v_error_gubun = "";

								<c:forEach var="codeList" items="${sCodeList}" varStatus="s">
									if(error_gubun == "${codeList.scode_cd}"){
										v_error_gubun = "${codeList.scode_nm}";
									}
								</c:forEach>

								if(recur_yn == ""){
									recur_yn = "N";
								}

								rowsObj.push({
									'grid_idx'					: i+1
									,'HOST_TIME'				: host_time
									,'JOB_NAME'					: job_name
									,'RUN_COUNTER'				: run_counter
									,'USER_NM'					: user_nm
									,'DEPT_NM'					: dept_nm
									,'DUTY_NM'					: duty_nm
									,'ACTION_YN'				: action_yn
									,'RECUR_YN'					: recur_yn
									,'ERROR_GUBUN'				: v_error_gubun
									,'ERROR_DESCRIPTION'		: error_desc
									,'SOLUTION_DESCRIPTION'		: solution_desc
									,'ALARM_CD'					: alarm_cd
									,'USER_CD'					: user_cd
									,'ORI_ERROR_GUBUN'			: error_gubun
									,'ACTION_GUBUN'				: action_gubun.toUpperCase()
									,'UPDATE_TIME'  			: update_time
									,'APPLICATION'  			: application
								});
							});
						}
						gridObj.rows = rowsObj;
						setGridRows(gridObj);
						$('#ly_total_cnt').html('[ TOTAL : '+items.attr('cnt')+' ]');

					});
					try{viewProgBar(false);}catch(e){}
				}
		, null );

		xhr.sendRequest();
	}

	function alertErrorInsert(alarm_cd){

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

						var items = $(this).find('items');
						var rowsObj = new Array();

						var host_time = "";
						var job_name = "";
						var action_yn = "";
						var recur_yn = "";
						var error_gubun = "";
						var error_desc = "";
						var solution_desc = "";
						var alarm_cd = "";
						var user_cd = "";
						var user_nm = "";
						var dept_nm = "";
						var dept_cd = "";
						var duty_nm = "";
						var duty_cd = "";
						var host_date = "";
						var action_gubun = "";
						var update_time = "";
						var application = "";

						if(items.attr('cnt')=='0'){
						}else{
							items.find('item').each(function(i){

								job_name = $(this).find("JOB_NAME").text();
								run_counter = $(this).find("RUN_COUNTER").text();
								dept_nm = $(this).find("DEPT_NM").text();
								duty_nm = $(this).find("DUTY_NM").text();
								user_nm = $(this).find("USER_NM").text();
								action_yn = $(this).find("ACTION_YN").text();
								action_gubun = $(this).find("ACTION_GUBUN").text();
								update_time = $(this).find("UPDATE_TIME").text();
								recur_yn = $(this).find("RECUR_YN").text();
								error_gubun = $(this).find("ERROR_GUBUN").text();
								error_desc = $(this).find("ERROR_DESCRIPTION").text();
								solution_desc = $(this).find("SOLUTION_DESCRIPTION").text();
								alarm_cd = $(this).find("ALARM_CD").text();
								user_cd = $(this).find("USER_CD").text();
								user_nm = $(this).find("USER_NM").text();
								dept_nm = $(this).find("DEPT_NM").text();
								dept_cd = $(this).find("DEPT_CD").text();
								duty_cd = $(this).find("DUTY_CD").text();
								duty_nm = $(this).find("DUTY_NM").text();
								host_date = $(this).find("HOST_TIME2").text();
								application = $(this).find("APPLICATION").text();

							});
						}


						var sHtml="<div id='dl_tmp1' style='overflow:hidden;display:none;padding:0;'>";
						sHtml+="<form id='form1' name='form1' method='post' onsubmit='return false;'>";
						sHtml+="<input type='hidden' name='flag' id='flag'/>";
						sHtml+="<input type='hidden' name='flag2' id='flag2'/>";
						sHtml+="<input type='hidden' name='alarm_cd' id='alarm_cd' value='"+alarm_cd+"'/>";
						sHtml+="<input type='hidden' name='dept_cd' id='dept_cd'/>";
						sHtml+="<input type='hidden' name='duty_cd' id='duty_cd'/>";
						sHtml+="<input type='hidden' name='p_title'	 				id='p_title' />";
						sHtml+="<input type='hidden' name='p_host_date'	 			id='p_host_date' />";
						sHtml+="<input type='hidden' name='doc_gb'	 				id='doc_gb'  		value='11'/>";

						sHtml+="<table style='width:100%;height:450px;border:none;'>";
						sHtml+="<tr><td style='vertical-align:top;height:90%;width:395px;'>";

						sHtml+="<table style='width:100%;height:68%;border:none;'>";
						sHtml+="<tr><td id='ly_g_tmp1' style='vertical-align:top;'>";
						sHtml+="<div id='g_tmp1' class='ui-widget-header ui-corner-all'></div>";
						sHtml+="</td></tr>";
						sHtml+="<tr style='height:10px;'><td style='vertical-align:top;'><h5 class='ui-widget-header ui-corner-all' >";
						sHtml+="<div align='right' class='btn_area_s'>";
						sHtml+="<span id='btn_draft_i'>승인요청</span>&nbsp;";
						sHtml+="<span id='btn_ins'>저장</span>";
						//sHtml+="<span id='btn_del'>삭제</span>";
						sHtml+="</div>";
						sHtml+="</h5></td></tr></table>";

						sHtml+="</td></tr></table>";
						sHtml+="</form>";

						$('#dl_tmp1').remove();
						$('body').append(sHtml);

						var headerObj = new Array();
						var hTmp1 = "";
						var hTmp2 = "";
						var v_error_gubun = "";
						hTmp1 += "<div class='cellTitle_2'>의뢰사유</div>";
						hTmp2 += "<div class='cellContent_2'><input type='text' name='title' id='title' style='width:95%;border:0px none;' value='[<%=S_USER_NM%>]작업 오류 원인 및 재발 방지 대책 보고 ["+job_name+"("+application+")]' readOnly/></div>";
						hTmp1 += "<div class='cellTitle_2'>작업명</div>";
						hTmp2 += "<div class='cellContent_2'>"+job_name+"<input type='hidden' name='job_name' id='job_name' value='"+job_name+"'></div>";
						hTmp1 += "<div class='cellTitle_2'>담당자명</div>";
						hTmp2 += "<div class='cellContent_2'><input type='text' name='user_nm' id='user_nm' style='width:78%;border:0px none;' readOnly/><input type='hidden' name='user_cd' id='user_cd' /></div>";
						hTmp1 += "<div class='cellTitle_2' style='display:none;'>조치여부</div>";
						hTmp2 += "<div class='cellContent_2' style='display:none;'>";
						hTmp2 += "<select name='action_yn' id='action_yn'>";
						hTmp2 += "<option value='N'>N</option>";
						hTmp2 += "<option value='Y'>Y</option>";
						hTmp2 += "</select>";
						hTmp2 += "</div>";
						hTmp1 += "<div class='cellTitle_2' style='display:none;'>Action 구분</div>";
						hTmp2 += "<div class='cellContent_2' style='display:none;'>";
						hTmp2 += "<select name='action_gubun' id='action_gubun'>";
						hTmp2 += "<option value=''>--선택--</option>";
						hTmp2 += "<option value='rerun'>RERUN</option>";
						hTmp2 += "<option value='skip'>SKIP</option>";
						hTmp2 += "</select>";
						hTmp2 += "</div>";
						hTmp1 += "<div class='cellTitle_2'>재발가능성여부</div>";
						hTmp2 += "<div class='cellContent_2'>";
						hTmp2 += "<select name='recur_yn' id='recur_yn'>";
						hTmp2 += "<option value='N'>N</option>";
						hTmp2 += "<option value='Y'>Y</option>";
						hTmp2 += "</select>";
						hTmp2 += "</div>";
						hTmp1 += "<div class='cellTitle_2'>오류구분</div>";
						hTmp2 += "<div class='cellContent_2'>";
						hTmp2 += "<select name='error_gubun' id='error_gubun'>";
						hTmp2 += "<option value=''>--선택--</option>";
						<c:forEach var="codeList" items="${sCodeList}" varStatus="s">
							v_error_gubun = "${codeList.scode_nm}";
							hTmp2 += "<option value='${codeList.scode_cd}'>"+v_error_gubun+"</option>";
						</c:forEach>
						hTmp2 += "</select>";
						hTmp2 += "</div>";

						hTmp1 += "<div class='cellTitle_2' style='height:53px;display:none;'>원인 및 조치내용</div>";
						hTmp2 += "<div class='cellContent_2' style='height:53px;display:none;'><textarea name='error_description' id='error_description' style='width:350px;;height:50px;border:0px none;'>"+error_desc+"</textarea></div>";
						hTmp1 += "<div class='cellTitle_2' style='height:53px;'>오류원인 및 해결방안</div>";
						hTmp2 += "<div class='cellContent_2' style='height:53px;'><textarea name='solution_description' id='solution_description' style='width:350px;height:50px;border:0px none;'>"+solution_desc+"</textarea></div>";

						headerObj.push({name:hTmp1,id_s:'c_1',id_e:'c_1'});
						headerObj.push({name:hTmp2,id_s:'c_2',id_e:'c_2'});
						var gridObj_s1 = {
							id : "g_tmp1"
							,colModel:[
						  		{formatter:gridCellNoneFormatter,field:'c_1',id:'c_1',name:'구 분',width:120,headerCssClass:'cellCenter',cssClass:'cellCenter'}
								,{formatter:gridCellNoneFormatter,field:'c_2',id:'c_2',name:'내 용',width:500,headerCssClass:'cellCenter',cssClass:'cellLeft'}

						   		,{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'grid_idx',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
						   	]
							,rows:[]
							,headerRowHeight:365
							,colspan:headerObj
							,vscroll:false
						};

						viewGrid_1(gridObj_s1,'ly_'+gridObj_s1.id);

						$("input[name='duty_cd']").val(duty_cd);
						$("input[name='dept_cd']").val(dept_cd);
						$("input[name='user_nm']").val(user_nm);
						$("input[name='user_cd']").val(user_cd);
						$("select[name='action_yn']").val(action_yn);
						$("select[name='action_gubun']").val(action_gubun);
						$("select[name='recur_yn']").val(recur_yn);
						$("select[name='error_gubun']").val(error_gubun);

						dlPop01('dl_tmp1',"일배치오류관리",600,350,false);

						$("#btn_search1").button().unbind("click").click(function(){
							goUserSearch("1");
						});

						$("#btn_ins").button().unbind("click").click(function(){

							if(confirm("해당 내용을 변경 하시겠습니까?")){

								var f = document.form1;

								try{viewProgBar(true);}catch(e){}

								f.flag.value = "user_udt";
								f.target = "if1";
								f.action = "<%=sContextPath %>/aEm.ez?c=ez003_p";
								f.submit();

								try{viewProgBar(false);}catch(e){}

							}
						});

						$("#btn_draft_i").button().unbind("click").click(function(){
							goPrc('draft_i');
						});

						$("#btn_del").button().unbind("click").click(function(){

							if(confirm("해당 내용을 삭제 하시겠습니까?")){

								var f = document.form1;

								try{viewProgBar(true);}catch(e){}

								f.flag.value = "del";
								f.target = "if1";
								f.action = "<%=sContextPath %>/aEm.ez?c=ez003_p";
								f.submit();

								try{viewProgBar(false);}catch(e){}

							}
						});
						function goPrc(flag){

							var frm = document.form1;

							if(frm.title.value == ""){
								alert("의뢰 사유는 필수 입력사항입니다.");
								$('#title').focus();
								return;
							}

							if(frm.error_gubun.value == ""){
								alert("오류구분은 필수입력 사항입니다.");
								return;
							}

							if(frm.solution_description.value == ""){
								alert("오류원인 및 해결방안은 필수입력 사항입니다.");
								return;
							}
							host_date = replaceAll(host_date,"-","");
							frm.flag.value   					= flag;
							frm.flag2.value   					= 'user_udt';
							frm.doc_gb.value 					= "11";
							frm.p_title.value 					= frm.title.value;
							frm.p_host_date.value 				= host_date;

							if( !confirm("처리하시겠습니까?") ) return;

							try{viewProgBar(true);}catch(e){}
							frm.target = "if1";
							frm.action = "<%=sContextPath%>/tWorks.ez?c=ez004_p";
							frm.submit();

							dlClose('dl_tmp1');
							alertErrorList();
						}

					});
					try{viewProgBar(false);}catch(e){}
				}
		, null );

		xhr.sendRequest();
	}

	function goUserSearch(btn){

		var sHtml2="<div id='dl_tmp3' style='overflow:hidden;display:none;padding:0;'>";
		sHtml2+="<form id='form3' name='form3' method='post' onsubmit='return false;'>";
		sHtml2+="<table style='width:100%;height:260px;;border:none;'><tr><td style='vertical-align:top;height:100%;width:500px;'>";
		sHtml2+="<input type='text' name='ser_user_nm' id='ser_user_nm' value=''/>&nbsp;&nbsp;<span id='btn_usersearch'>검색</span>";
		sHtml2+="<table style='width:100%;height:100%;border:none;'>";
		sHtml2+="<tr><td id='ly_g_tmp3' style='vertical-align:top;' >";
		sHtml2+="<div id='g_tmp3' class='ui-widget-header ui-corner-all'></div>";
		sHtml2+="</td></tr>";
		sHtml2+="<tr style='height:10px;'><td style='vertical-align:top;'><h5 class='ui-widget-header ui-corner-all' >";
		sHtml2+="<div align='right' class='btn_area_s'>";
		sHtml2+="<div id='ly_total_cnt3' style='padding-top:5px;float:left;'></div>";
		sHtml2+="</div>";
		sHtml2+="</h5></td></tr></table>";

		sHtml2+="</td></tr></table>";

		sHtml2+="</form>";

		$('#dl_tmp3').remove();
		$('body').append(sHtml2);

		dlPop01('dl_tmp3',"사용자내역",400,295,false);

		var gridObj3 = {
			id : "g_tmp3"
			,colModel:[

				{formatter:gridCellNoneFormatter,field:'dept_nm',id:'dept_nm',name:'부서명',width:100,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
				,{formatter:gridCellNoneFormatter,field:'duty_nm',id:'duty_nm',name:'직책',width:60,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
				,{formatter:gridCellNoneFormatter,field:'user_nm',id:'user_nm',name:'사용자명',width:80,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
				,{formatter:gridCellNoneFormatter,field:'user_id',id:'user_id',name:'아이디',width:80,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
				,{formatter:gridCellNoneFormatter,field:'CHOICE',id:'CHOICE',name:'선택',width:50,headerCssClass:'cellCenter',cssClass:'cellCenter'}

		   		,{formatter:gridCellNoneFormatter,field:'user_cd',id:'user_cd',name:'user_cd',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
		   	]
			,rows:[]
		};

		viewGrid_1(gridObj3,'ly_'+gridObj3.id);

		$('#ser_user_nm').placeholder().unbind('keypress').keypress(function(e){
			if(e.keyCode==13 && trim($('#ser_user_nm').val())!=''){
				getUserList('user_nm',$("#ser_user_nm").val(),btn);
			}
		});


		$("#btn_usersearch").button().unbind("click").click(function(){
			getUserList('user_nm',$("#ser_user_nm").val(),btn);
		});

	}

	function getUserList(gubun, text, btn){
		try{viewProgBar(true);}catch(e){}
		$('#ly_total_cnt3').html('');
		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=userList&p_search_gubun='+gubun+'&p_search_text='+encodeURIComponent(text);

		var xhr = new XHRHandler( url, null
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

								var dept_nm = $(this).find("DEPT_NM").text();
								var duty_nm = $(this).find("DUTY_NM").text();
								var user_nm = $(this).find("USER_NM").text();
								var user_cd = $(this).find("USER_CD").text();
								var user_id = $(this).find("USER_ID").text();

								rowsObj.push({'grid_idx':i+1
									,'dept_nm':dept_nm
									,'duty_nm':duty_nm
									,'user_nm':user_nm
									,'user_id':user_id
									,'CHOICE':"<div><a href=\"javascript:goUserSeqSelect('"+user_cd+"', '"+user_nm+"', '"+btn+"');\" ><font color='red'>[선택]</font></a></div>"
									,'user_cd':user_cd
								});

							});

						}
						var obj = $("#g_tmp3").data('gridObj');
						obj.rows = rowsObj;
						setGridRows(obj);

						$('#ly_total_cnt3').html('[ TOTAL : '+items.attr('cnt')+' ]');
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

		frm.action = "<%=sContextPath %>/aEm.ez?c=ez003_excel";
		frm.target = "if1";
		frm.submit();

		try{viewProgBar(false);}catch(e){}
	}

	function selectApplication(eng_nm, desc){

		$("#app_nm").val(desc);
		$("#application_of_def").val(eng_nm);

		dlClose("dl_tmp1");

		//검색의 애플리케이션에 값을 셋
		$("#f_s").find("input[name='p_application_of_def']").val("'"+eng_nm+"'");
		$("#f_s").find("input[name='p_group_name_of_def']").val("");

		//그룹을 검색
		getAppGrpCodeList("", "2", "", "group_name_of_def","'"+eng_nm+"'");

	}

	function selectApplication2(eng_nm, desc){
		var app_nm = $("#app_nm").val();
		if($("#application_of_def").val() == ""){
			$("#app_nm").val(desc);
			$("#application_of_def").val(eng_nm);
		}else{
			if(app_nm.indexOf("[") != -1){
				$("#app_nm").val(desc);
				$("#application_of_def").val(eng_nm);
			}else{
				$("#app_nm").val($("#app_nm").val()+", "+desc);
				$("#application_of_def").val($("#application_of_def").val()+", "+eng_nm);
			}

		}


		dlClose("dl_tmp1");

		//검색의 애플리케이션에 값을 셋

		if($("#f_s").find("input[name='p_application_of_def']").val() == ""){
			$("#f_s").find("input[name='p_application_of_def']").val(eng_nm);
			$("#f_s").find("input[name='p_group_name_of_def']").val("");
		}else{
			if(app_nm.indexOf("[") != -1){
				$("#f_s").find("input[name='p_application_of_def']").val(eng_nm);
				$("#f_s").find("input[name='p_group_name_of_def']").val("");
			}else{
				$("#f_s").find("input[name='p_application_of_def']").val($("#f_s").find("input[name='p_application_of_def']").val()+", "+eng_nm);
				$("#f_s").find("input[name='p_group_name_of_def']").val("");
				eng_nm = $("#f_s").find("input[name='p_application_of_def']").val();
			}

		}

		//그룹을 검색
		getAppGrpCodeList("", "2", "", "group_name_of_def",eng_nm);

	}

	//APP/GRP 가져오기
	function getAppGrpCodeList(scode_cd, depth, grp_cd, val, eng_nm){

		try{viewProgBar(true);}catch(e){}

		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=searchAppGrpCodeList&itemGubun=2&p_scode_cd='+scode_cd+'&p_app_eng_nm='+encodeURIComponent(eng_nm)+'&p_grp_depth='+depth+'&p_grp_cd='+grp_cd;

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
							$("select[name='"+val+"'] option").remove();
							$("select[name='"+val+"']").append("<option value=''>--선택--</option>");
						}else{

							$("select[name='"+val+"'] option").remove();
							$("select[name='"+val+"']").append("<option value=''>--선택--</option>");

							items.find('item').each(function(i){

								var grp_cd = $(this).find("GRP_CD").text();
								var grp_nm = $(this).find("GRP_NM").text();
								var grp_desc = $(this).find("GRP_DESC").text();
								var grp_eng_nm = $(this).find("GRP_ENG_NM").text();
								var arr_grp_cd = grp_cd+","+grp_eng_nm;

								$("select[name='"+val+"']").append("<option value='"+grp_eng_nm+"'>"+grp_desc+"</option>");

							});
						}

					});
					try{viewProgBar(false);}catch(e){}
				}
		, null );

		xhr.sendRequest();
	}

	function selectApplication3(scode_nm, desc){
		var s_nm = $("#scode_nm").val();
		if(s_nm == ""){
			$("#scode_nm").val(desc);
		}else{
			$("#scode_nm").val("");
			$("#scode_nm").val(desc);
		}


		dlClose("dl_tmp1");

		//검색의 애플리케이션에 값을 셋

		if($("#f_s").find("input[name='p_scode_nm']").val() == ""){
			$("#f_s").find("input[name='p_scode_nm']").val(scode_nm);
		}else{
			$("#f_s").find("input[name='p_scode_nm']").val("");
			$("#f_s").find("input[name='p_scode_nm']").val(scode_nm);
			scode_nm = $("#f_s").find("input[name='p_scode_nm']").val();
		}

	}
</script>
