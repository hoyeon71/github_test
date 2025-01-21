<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/jsp/common/inc/header.jsp"%>

<%
	Map<String, Object> paramMap = CommonUtil.collectParameters(request);
	String c = CommonUtil.isNull(paramMap.get("c"));
	String gridId = "g_"+c;
	
	// 세션값 가져오기.
	String strSessionDcCode 	= S_D_C_CODE;	
	String strSessionTab	 	= S_TAB;
	String strSessionApp        = S_APP;
	String strSessionGrp        = S_GRP;
	String session_user_gb 		= S_USER_GB;
	String session_user_id		= S_USER_ID;
%>

<form id="f_s" name="f_s" method="post" onsubmit="return false;">	
	<input type='hidden' id='data_center_code' 			name='data_center_code'/>
	<input type='hidden' id='data_center' 				name='data_center'/>
	<input type='hidden' id='active_net_name' 			name='active_net_name'/>
	
	<input type='hidden' id='p_sched_table' 			name='p_sched_table'/>
	<input type='hidden' id='p_application_of_def' 		name='p_application_of_def'/>
	<input type='hidden' id='p_group_name_of_def' 		name='p_group_name_of_def'/>
	<input type='hidden' id='p_application_of_def_text'	name='p_application_of_def_text'/>
	<input type='hidden' id='p_group_name_of_def_text'	name='p_group_name_of_def_text'/>
	<input type='hidden' id='p_search_select' 			name='p_search_select'/>
	<input type='hidden' id='p_search_name' 			name='p_search_name'/>
	<input type='hidden' id='searchType' 				name='searchType'/>
	<input type='hidden' id='p_s_odate' 				name='p_s_odate'/>
	<input type='hidden' id='p_e_odate' 				name='p_e_odate'/>
	<input type="hidden" id="p_scode_cd" 				name="p_scode_cd" />
	<input type="hidden" id="p_grp_depth"				name="p_grp_depth" />
	<input type="hidden" id="p_app_nm"					name="p_app_nm" />
	<input type="hidden" id="p_app_search_gubun" 		name="p_app_search_gubun" />
	
	<input type='hidden' id='p_search_gubun2' 			name='p_search_gubun2'/>
	<input type='hidden' id='p_search_text2' 			name='p_search_text2'/>
</form>

<table style='width:100%;height:100%;border:none;'>
	<tr style='height:10px;'>
		<td style='vertical-align:top;'>
			<h4 class="ui-widget-header ui-corner-all"  >
				<div id='t_<%=gridId %>' class='title_area' >
					<span><%=CommonUtil.isNull(CommonUtil.getMessage("CATEGORY.GB.04"))%> > <%=CommonUtil.getMessage("CATEGORY.0106") %></span>
				</div>
			</h4>
		</td>
	</tr>
	<tr style='height:10px;'>
		<td style='vertical-align:top;'>
		
			<form name="frm1" id="frm1" method="post">
			<input type='hidden' id='data_center_name' name='data_center_name'/>
			
			<h4 class="ui-widget-header ui-corner-all">
			<table style='width:100%;'>
				<tr>
					<th width="10%"><div class='cellTitle_kang2' style='min-width:100px;'>C-M</div></th>
					<td width="15%" style="text-align:left; width:300px;">
						<div class='cellContent_kang' style='width:300px;'>
						<select id="data_center_items" name="data_center_items" style="width:120px; height:21px;">
							<option value="">--선택--</option>
							<c:forEach var="cm" items="${cm}" varStatus="status">
								<option value="${cm.scode_cd},${cm.scode_eng_nm}">${cm.scode_nm}</option>
							</c:forEach>
						</select>
						</div>
					</td>
					<th width="10%"><div class='cellTitle_kang2'>ODATE</div></th>
					<td width="20%" style="text-align:left;min-width:250px;">
						<div class='cellContent_kang'>
						<input type="text" name="s_odate" id="s_odate" value="${ODATE}" class="input datepick" style="width:75px; height:21px;" maxlength="10" readOnly/> ~
						<input type="text" name="e_odate" id="e_odate" value="${ODATE}" class="input datepick" style="width:75px; height:21px;" maxlength="10" readOnly/>
						</div>
					</td>
					<th width="10%"><div class='cellTitle_kang2'style='min-width:50px;'>조건</div></th>
					<td width="30%" style="text-align:left;min-width:350px;">
						<div class='cellContent_kang'>
							<select name="search_gubun2" id="search_gubun2" style="width:120px;height:21px;">
								<option value="job_name">작업명</option>	
								<option value="description">작업설명</option>
							</select>
							<input type="text" name="search_text2" value="" id="search_tefxt2" style="width:150px; height:21px;"/>
						</div>
					</td>
					<td width="5%"></td>
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
						
					<th><div class='cellTitle_kang2' style='min-width:150px;'>어플리케이션</div></th>
					<td style="text-align:left">
						<div class='cellContent_kang'>
							<select name="application_of_def" id="application_of_def" style="width:115px;height:21px;">
								<option value="">--선택--</option>
							</select>
						</div>
					</td>
					<th><div class='cellTitle_kang2'>그룹</div></th>
					<td style="text-align:left">
						<div class='cellContent_kang'>
							<select id="group_name_of_def" name="group_name_of_def" style="width:120px; height:21px;">
								<option value=''>--선택--</option>
							</select>

						</div>
					</td>
					<td>
						<span id='btn_search' style='float:right;margin:3px;'>검 색</span>
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
					최종 수행일 : ${INS_DATE} &nbsp;
					<span id="btn_down">엑셀다운</span>
				</div>
			</h4>
		</td>
	</tr>
</table>
<script>
	
	var gridObj = {
		id : "<%=gridId %>"
		,colModel:[
	   		{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'번호',width:50,minWidth:50,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'DATA_CENTER_NAME',id:'DATA_CENTER_NAME',name:'C-M',width:120,minWidth:120,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'ODATE',id:'ODATE',name:'ODATE',width:120,minWidth:120,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'SCHED_TABLE',id:'SCHED_TABLE',name:'폴더',width:110,minWidth:110,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'APPLICATION',id:'APPLICATION',name:'어플리케이션',width:110,minWidth:110,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'GROUP_NAME',id:'GROUP_NAME',name:'그룹',width:110,minWidth:110,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}	   		
	   		,{formatter:gridCellNoneFormatter,field:'JOB_NAME',id:'JOB_NAME',name:'작업명',width:200,minWidth:200,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'DESCRIPTION',id:'DESCRIPTION',name:'작업설명',width:250,minWidth:250,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'DEVELOPER',id:'DEVELOPER',name:'담당자',width:80,minWidth:80,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'FROM_TIME',id:'FROM_TIME',name:'시작시간',width:80,minWidth:80,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	   	]
		,rows:[]
		,vscroll:<%=S_GRID_VSCROLL%>
	};
	
	$(document).ready(function() {
		
		var session_user_gb = "<%=session_user_gb%>";
		var session_dc_code	= "<%=strSessionDcCode%>";
		var table_name		= "<%=strSessionTab%>";
		var application		= "<%=strSessionApp%>";
		var group_name		= "<%=strSessionGrp%>";		
		var session_user_id = "<%=session_user_id%>";
		
		$("#btn_search, #btn_forecast").show();
		
		$("#f_s").find("input[name='p_search_gubun2']").val($("#frm1").find("select[name='search_gubun2'] option:selected").val());
		$("#f_s").find("input[name='p_search_text2']").val($("#frm1").find("input[name='search_text2']").val());
		$("#f_s").find("input[name='p_s_odate']").val("${ODATE}");
		$("#f_s").find("input[name='p_e_odate']").val("${ODATE}");
		
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
				
		viewGrid_1(gridObj,"ly_"+gridObj.id,{enableColumnReorder:true},'AUTO');
		
		$("#btn_forecast").button().unbind("click").click(function(){
			preDateBatchScheduleOrder();
		});
		
		$("#btn_search").button().unbind("click").click(function(){
			
			var application_of_def = $("select[name='application_of_def'] option:selected").val();
			var data_center = $("select[name='data_center_items'] option:selected").val();
			
			if(data_center == ""){
				alert("C-M 을 선택해 주세요.");
				return;
			}
			
			$("#f_s").find("input[name='p_search_gubun2']").val($("#frm1").find("select[name='search_gubun2'] option:selected").val());
			$("#f_s").find("input[name='p_search_text2']").val($("#frm1").find("input[name='search_text2']").val());
			$("#f_s").find("input[name='p_s_odate']").val($("#frm1").find("input[name='s_odate']").val());
			$("#f_s").find("input[name='p_e_odate']").val($("#frm1").find("input[name='e_odate']").val());
			$("#f_s").find("input[name='data_center']").val(data_center);
			
			if ( $("#p_s_odate").val() != "" && $("#p_e_odate").val() != "" ) {
				
				// 날짜 기간 체크
				if ( $("#p_s_odate").val() > $("#p_e_odate").val() ) {
					alert("ODATE 일자의 FROM ~ TO를 확인해 주세요.");
					return;
				}
			}
			
			
			setTimeout(function(){
				preDateBatchScheduleList();
			}, 1000);
		});
		
		$('#search_name').unbind('keypress').keypress(function(e){			
			if(e.keyCode==13){	
				
				var application_of_def = $("select[name='application_of_def'] option:selected").val();
				var data_center = $("select[name='data_center_items'] option:selected").val();
				
				if(data_center == ""){
					alert("C-M 을 선택해 주세요.");
					return;
				}
				
				$("#f_s").find("input[name='p_search_gubun2']").val($("#frm1").find("select[name='search_gubun2'] option:selected").val());
				$("#f_s").find("input[name='p_search_text2']").val($("#frm1").find("input[name='search_text2']").val());
				$("#f_s").find("input[name='p_s_odate']").val($("#frm1").find("input[name='s_odate']").val());
				$("#f_s").find("input[name='p_e_odate']").val($("#frm1").find("input[name='e_odate']").val());
				$("#f_s").find("input[name='data_center']").val(data_center);
				
				preDateBatchScheduleList();
			}
		});
		
		$("#data_center_items").change(function(){	
			
			$("#application_of_def").val("");
			
			$("select[name='group_name_of_def'] option").remove();
			$("select[name='group_name_of_def']").append("<option value=''>--선택--</option>");	
			
			var data_center_items = $(this).val();
			var arr_dt = data_center_items.split(",");
			if($(this).val() != ""){
				$("#f_s").find("input[name='data_center']").val(data_center_items);
				//getAppGrpCodeList(arr_dt[0], "1", "", "application_of_def","");	
			}
		});
		
		$("#btn_down").button().unbind("click").click(function(){
			goExcel();
		});
		
		$("#s_odate").addClass("ime_readonly").unbind('click').click(function(){
			dpCalMin(this.id,'yymmdd','-90');
		});
		$("#e_odate").addClass("ime_readonly").unbind('click').click(function(){
			dpCalMin(this.id,'yymmdd','-90');
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
			
			$("select[name='sub_table_of_def'] option").remove();
			$("select[name='sub_table_of_def']").append("<option value=''>--선택--</option>");
			
			document.getElementById('sub_table_of_def').style.display = 'none';
		});
	});
		
	function preDateBatchScheduleList(){
		
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
		
		try{viewProgBar(true);}catch(e){}
		$('#ly_total_cnt').html('');
		
		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=preDateBatchScheduleList';
		
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
							
								var sched_table 		= $(this).find("SCHED_TABLE").text();
								var application 		= $(this).find("APPLICATION").text();
								var group_name  		= $(this).find("GROUP_NAME").text();
								var job_name    		= $(this).find("JOB_NAME").text();
								var days_cal    		= $(this).find("DAYS_CAL").text();
								var user_nm     		= $(this).find("DEVELOPER").text();
								var from_time   		= $(this).find("FROM_TIME").text();
								var odate       		= $(this).find("ODATE").text();
								var description 		= $(this).find("DESCRIPTION").text();
								var data_center_name 	= $(this).find("DATA_CENTER_NAME").text();
								var smart_job_yn		= $(this).find("SMART_JOB_YN").text();
								
								if ( from_time != "") {
									from_time = from_time.substring(0,2) +":"+ from_time.substring(2,4)
								}
								
								var smart_folder = "";
								if ( smart_job_yn == "Y" ) {
									smart_folder = "<img src='/imgs/smart_folder.png' style='vertical-align:middle;' width='20' height='20'> ";
								}
																	
								rowsObj.push({
									'grid_idx':i+1
									,'DATA_CENTER_NAME' 	:   data_center_name
									,'SCHED_TABLE' 			:   smart_folder + sched_table
									,'APPLICATION' 			:   application
									,'GROUP_NAME' 			:   group_name 
									,'JOB_NAME' 			:   job_name   
									,'DAYS_CAL' 			:   days_cal   
									,'DEVELOPER' 			:   user_nm  
									,'FROM_TIME' 			:   from_time
									,'ODATE' 				:   odate      
									,'DESCRIPTION'  		:   description					
								});
							});						
						}
						
						gridObj.rows = rowsObj;
						setGridRows(gridObj);
						$('body').resizeAllColumns();
						$('#ly_total_cnt').html('[ TOTAL : '+items.attr('cnt')+' ]');
						
					});
					try{viewProgBar(false);}catch(e){}
				}
		, null );
		
		xhr.sendRequest();
	}
	
	function preDateBatchScheduleOrder(){
		
		var data_center = $("select[name='data_center_items'] option:selected").val();
		
		if(data_center == ""){
			alert("C-M 을 선택해 주세요.");
			return;
		}
		
		if(confirm("진행 하시겠습니까?")){
			var frm = document.frm1;
			
			frm.data_center_name.value = data_center.split(",")[1]; 
			
			try{viewProgBar(true);}catch(e){}
			
			frm.action = "<%=sContextPath %>/mEm.ez?c=ez006_forecastOrder";
			frm.target = "if1";
			frm.submit();
			
			try{viewProgBar(false);}catch(e){}
		}
	}
	
	function goExcel(){
		
		var frm = document.f_s;
		
		try{viewProgBar(true);}catch(e){}
		
		frm.action = "<%=sContextPath %>/mEm.ez?c=ez006_excel";
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
	
	$('#application_of_def_text').on('keyup', function(event) {
		$('#p_application_of_def_text').val($(this).val());
	});
	
	$('#group_name_of_def_text').on('keyup', function(event) {
		$('#p_group_name_of_def_text').val($(this).val());
	});
	
	$('#search_text2').unbind('keypress').keypress(function(e){
		
		if(e.keyCode==13){	
		
			var data_center_items = $("select[name='data_center_items'] option:selected").val();
			
			if(data_center_items == ""){
				alert("C-M 을 선택해 주세요.");
				return;
			}
			
			$("#f_s").find("input[name='p_search_gubun2']").val($("#frm1").find("select[name='search_gubun2'] option:selected").val());
			$("#f_s").find("input[name='p_search_text2']").val($("#frm1").find("input[name='search_text2']").val());
			$("#f_s").find("input[name='p_s_odate']").val($("#frm1").find("input[name='s_odate']").val());
			$("#f_s").find("input[name='p_e_odate']").val($("#frm1").find("input[name='e_odate']").val());
			
			preDateBatchScheduleList();
		}
	});
	
	
	
</script>
