<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/jsp/common/inc/header.jsp"%>

<%
	Map<String, Object> paramMap = CommonUtil.collectParameters(request);
	String c = CommonUtil.isNull(paramMap.get("c"));
	String gridId = "g_"+c;
	
	String strMenuGb = CommonUtil.isNull(paramMap.get("menu_gb"));
	String menu_gb = CommonUtil.getMessage("CATEGORY.GB.09.GB."+strMenuGb);
	String[] arr_menu_gb = menu_gb.split(",");
	
	String odate = (String)request.getAttribute("ODATE");
	odate = odate.replace("/", "");
%>

<form id="f_s" name="f_s" method="post" onsubmit="return false;">
	<input type="hidden" id="menu_gb" 				name="menu_gb" value="<%= strMenuGb%>" />
	
	<input type='hidden' id='p_s_odate' 			name='p_s_odate'/>
	<input type='hidden' id='p_e_odate' 			name='p_e_odate'/>
	
	<input type='hidden' id='data_center' 			name='data_center'/>
	<input type='hidden' id='p_sched_table' 		name='p_sched_table'/>
	<input type='hidden' id='p_application_of_def' 	name='p_application_of_def'/>
	<input type='hidden' id='p_application_of_def_text'	name='p_application_of_def_text'/>
	<input type='hidden' id='p_group_name_of_def' 	name='p_group_name_of_def'/>
	
	<input type="hidden" id="p_scode_cd" 			name="p_scode_cd" />
	<input type="hidden" id="p_grp_depth" 			name="p_grp_depth" />
	<input type="hidden" id="p_app_search_gubun"	name="p_app_search_gubun" />
	<input type="hidden" id="p_app_nm"				name="p_app_nm" />
</form>

<table style='width:100%;height:100%;border:none;'>
	<tr style='height:10px;'>
		<td style='vertical-align:top;'>
			<h4 class="ui-widget-header ui-corner-all"  >
				<div id='t_<%=gridId %>' class='title_area' >
					<span><%=CommonUtil.isNull(CommonUtil.getMessage("CATEGORY.GB.09"))%> ><%=CommonUtil.isNull(arr_menu_gb[0]) %></span>
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
					<td width="20%" style="text-align:left">
						<div class='cellContent_kang'>
							<select id="data_center_items" name="data_center_items" style="width:120px; height:21px;">							
								<option value="">선택</option>
								<c:forEach var="cm" items="${cm}" varStatus="status">
									<option value="${cm.scode_cd},${cm.scode_eng_nm}">${cm.scode_nm}</option>
								</c:forEach>
							</select>

						</div>
					</td>
									
					<th width="10%"><div class='cellTitle_kang2' style='min-width:120px;'>ODATE</div></th>
					<td width="20%" style="text-align:left">
						<div class='cellContent_kang' style='width:250px;'>
						<input type="text" name="s_odate" id="s_odate" value="<%=odate %>" class="input datepick" style="width:70px; height:21px;" maxlength="8" onclick="dpCalMin('s_odate','yymmdd');" />
						 ~<input type="text" name="e_odate" id="e_odate" value="<%=odate %>" class="input datepick" style="width:70px; height:21px;" maxlength="8" onclick="dpCalMin('e_odate','yymmdd');" />
						</div>
					</td>
					<th width="10%"><div class='cellTitle_kang2'></div></th>
					<td width="20%" style="text-align:left"></td>
					<td width="10%"></td>
				</tr>
				<tr>			
					<th><div class='cellTitle_kang2'>폴더</div></th>
					<td style="text-align:left;min-width:150px;">
						<div class='cellContent_kang'>
							<input type="text" name="table_nm" id="table_nm" style="width:120px; height:21px;" onkeydown="return false;" readonly/>&nbsp;
							<select name="sub_table_of_def" id="sub_table_of_def" style="width:120px;height:21px;display:none;">
								<option value="">전체</option>
							</select>
							<img id="btn_clear1" src="/images/sta2.png" style="width:16px;height:16px;vertical-align:middle;cursor:pointer;"/>
						</div>
					</td>
						
					<th><div class='cellTitle_kang2'>어플리케이션</div></th>
					<td style="text-align:left">
						<div class='cellContent_kang'>
							<select name="application_of_def" id="application_of_def" style="width:120px;height:21px;">
								<option value="">--선택--</option>
							</select>
<!-- 							<input type='text' id='application_of_def_text' name='application_of_def_text' style="width:159px; height:21px;"/> -->
						</div>
					</td>
					
					<th><div class='cellTitle_kang2' style='min-width:120px;'>그룹</div></th>
					<td style="text-align:left">
						<div class='cellContent_kang'>
						<select id="group_name_of_def" name="group_name_of_def" style="width:120px; height:21px;">
							<option value=''>--선택--</option>
						</select>
						</div>
					</td>
					
					<td style="text-align:right;">
						<span id="btn_search" style='margin:3px;'>검 색</span>
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
					<span id="btn_excel">엑셀다운</span>
				</div>
			</h4>
		</td>
	</tr>
</table>

<script>
	var gridObj = {
		id : "<%=gridId %>"
		,colModel:[
					{formatter:gridCellNoneFormatter,field:'data_center',id:'data_center',name:'C-M',width:100,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
					,{formatter:gridCellNoneFormatter,field:'table_name',id:'table_name',name:'폴더',width:140,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
					,{formatter:gridCellNoneFormatter,field:'application',id:'application',name:'어플리케이션',width:120,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
					,{formatter:gridCellNoneFormatter,field:'group_name',id:'group_name',name:'그룹',width:120,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
			   		,{formatter:gridCellNoneFormatter,field:'reg_new_cnt',id:'reg_new_cnt',name:'정기-신규',width:80,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
			   		,{formatter:gridCellNoneFormatter,field:'reg_mod_cnt',id:'reg_mod_cnt',name:'정기-수정',width:80,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
			   		,{formatter:gridCellNoneFormatter,field:'reg_del_cnt',id:'reg_del_cnt',name:'정기-삭제',width:80,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
			   		,{formatter:gridCellNoneFormatter,field:'reg_ord_cnt',id:'reg_ord_cnt',name:'정기-수행',width:80,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
			   		,{formatter:gridCellNoneFormatter,field:'reg_chg_cond_cnt',id:'reg_chg_cond_cnt',name:'정기-상태변경',width:100,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
			   		,{formatter:gridCellNoneFormatter,field:'irreg_new_cnt',id:'irreg_new_cnt',name:'비정기-신규',width:100,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
			   		,{formatter:gridCellNoneFormatter,field:'irreg_mod_cnt',id:'irreg_mod_cnt',name:'비정기-수정',width:100,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
			   		,{formatter:gridCellNoneFormatter,field:'irreg_del_cnt',id:'irreg_del_cnt',name:'비정기-삭제',width:100,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
			   		,{formatter:gridCellNoneFormatter,field:'irreg_ord_cnt',id:'irreg_ord_cnt',name:'비정기-수행',width:100,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
			   		,{formatter:gridCellNoneFormatter,field:'irreg_chg_cond_cnt',id:'irreg_chg_cond_cnt',name:'비정기-상태변경',width:100,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
			   		,{formatter:gridCellNoneFormatter,field:'total_cnt',id:'total_cnt',name:'TOTAL',width:70,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
			   		,{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'번호',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid',sortable:true}
			   	]
		,rows:[]
		,vscroll:false
	};
	
	$(document).ready(function(){

		var S_D_C_CODE 		= "<%=S_D_C_CODE%>"; 	//사용자의 select_data_center
		var S_TAB 			= "<%=S_TAB%>";			//사용자의 select_table_name
		var S_APP			= "<%=S_APP%>"; 		//사용자의 select_application
		var S_GRP			= "<%=S_GRP%>"; 		//사용자의 select_group_name
		
		viewGrid_1(gridObj,"ly_"+gridObj.id,{enableColumnReorder:true},'AUTO');
		
		//버튼
		$("#btn_search").button().unbind("click").click(function(){
			var data_center = $("#data_center_items").val();
			if (data_center == "") {
				alert("C-M 을 선택해 주세요.");
				return;
			}
			
			$("#p_s_odate").val($("#s_odate").val());
			$("#p_e_odate").val($("#e_odate").val());
			
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
			
			setTimeout(function(){
				batchTotal();
			}, 1000);
		});
		
		// 어플리케이션 엔터
		$('#application_of_def_text').unbind('keypress').keypress(function(e) {
			if(e.keyCode==13){
				$("#btn_search").trigger("click");
			}
		});
		
		$("#btn_excel").button().unbind("click").click(function(){
			var data_center = $("#data_center_items").val();
			if (data_center == "") {
				alert("C-M 을 선택해 주세요.");
				return;
			}
			
			goExcel();
		});
		
		//C-M
		if(S_D_C_CODE != "") { // 개인정보에 C-M이 등록되어 있을경우
			$("#data_center_items").val(S_D_C_CODE);
			$("#data_center").val(S_D_C_CODE);
		}else { // 개인정보에 C-M이 등록이 되어있지 않을경우 -> C-M 콤보박스에서 첫번째값 선택
			$("#data_center_items option:eq(1)").prop("selected", true);
			$("#data_center").val($("select[name='data_center_items']").val());
		}
		
		
		$("#data_center_items").change(function(){
			//폴더 초기화
			$("#table_nm").val("");
			$("#p_sched_table").val("");

			//어플리케이션 초기화
			$("#application_of_def option").remove();
			$("#application_of_def").append("<option value=''>--선택--</option>");
			
			//그룹 초기화
			$("#group_name_of_def option").remove();
			$("#group_name_of_def").append("<option value=''>--선택--</option>");
			
			$("#data_center").val($(this).val());
		});
		
		//사용자 폴더-어플리케이션-그룹 세팅.
		if(S_TAB != '') {
			$("#table_nm").val(S_TAB);
			$("#p_sched_table").val(S_TAB);
			
			getAppGrpCodeList("application_of_def", "2", S_APP, "", S_TAB);
			setTimeout(function(){
				var selected_app_grp_cd	= $("#application_of_def option:selected").val().split(",")[0]; //그룹 조회 파라미터.
				if (selected_app_grp_cd != "")
					getAppGrpCodeList("group_name_of_def", "3", S_GRP, selected_app_grp_cd); //어플리케이션 코드로 그룹 조회 및 그룹 선택.
			}, 1000);
		}
		
		$("#table_nm").click(function(){
			var data_center = $("#data_center_items").val();
			var select_table = $("input[name='table_nm']").val();
			if (data_center == "") {
				alert("C-M 을 선택해 주세요.");
				return;
			} else {
				searchPoeTabForm(select_table);
			}
		});
		
		//폴더 삭제 아이콘
		$("#btn_clear1").unbind("click").click(function(){
			//hidden 값 초기화
			$("#p_sched_table").val("");
			$("#p_application_of_def").val("");
			$("#p_group_name_of_def").val("");

			$("#table_nm").val("");

			$("#application_of_def option").remove();
			$("#application_of_def").append("<option value=''>--선택--</option>");
			
			$("#group_name_of_def option").remove();
			$("#group_name_of_def").append("<option value=''>--선택--</option>");
			
			$("select[name='sub_table_of_def'] option").remove();
			$("select[name='sub_table_of_def']").append("<option value=''>--선택--</option>");
			
			document.getElementById('sub_table_of_def').style.display = 'none';
		});
		
		//어플리케이션
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
		
		//그룹
		$("#group_name_of_def").change(function(){
			var grp_info = $(this).val().split(",");
			$("#p_group_name_of_def").val(grp_info[1]);
		});
	})
	
	function batchTotal() {
		
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
		
		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=batchTotal&itemGubun=2';
		
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

				if(items.attr('cnt')=='0'){
				}else{
					items.find('item').each(function(i){
						
						var data_center			= $(this).find("data_center").text();
						var table_name 			= $(this).find("table_name").text();
						var application			= $(this).find("application").text();
						var group_name 			= $(this).find("group_name").text();
						var reg_new_cnt 		= $(this).find("reg_new_cnt").text();
						var reg_mod_cnt 		= $(this).find("reg_mod_cnt").text();
						var reg_del_cnt 		= $(this).find("reg_del_cnt").text();
						var reg_ord_cnt 		= $(this).find("reg_ord_cnt").text();
						var reg_chg_cond_cnt	= $(this).find("reg_chg_cond_cnt").text();
						var irreg_new_cnt 		= $(this).find("irreg_new_cnt").text();
						var irreg_mod_cnt 		= $(this).find("irreg_mod_cnt").text();
						var irreg_del_cnt 		= $(this).find("irreg_del_cnt").text();
						var irreg_ord_cnt 		= $(this).find("irreg_ord_cnt").text();
						var irreg_chg_cond_cnt	= $(this).find("irreg_chg_cond_cnt").text();
						var total_cnt			= $(this).find("total_cnt").text();
						var smart_job_yn		= $(this).find("smart_job_yn").text();
						
						var smart_folder = "";
						if ( smart_job_yn == "Y" ) {
							smart_folder = "<img src='/imgs/smart_folder.png' style='vertical-align:middle;' width='20' height='20'> ";
						}
						
						rowsObj.push({
							'grid_idx':i+1
							,'data_center': data_center
							,'table_name': smart_folder + table_name
							,'application': application
							,'group_name': group_name
							,'reg_new_cnt': reg_new_cnt
							,'reg_mod_cnt': reg_mod_cnt
							,'reg_del_cnt': reg_del_cnt
							,'reg_ord_cnt': reg_ord_cnt
							,'reg_chg_cond_cnt': reg_chg_cond_cnt
							,'irreg_new_cnt': irreg_new_cnt
							,'irreg_mod_cnt': irreg_mod_cnt
							,'irreg_del_cnt': irreg_del_cnt
							,'irreg_ord_cnt': irreg_ord_cnt
							,'irreg_chg_cond_cnt': irreg_chg_cond_cnt
							,'total_cnt': total_cnt
						});
					});						
				}
				
				gridObj.rows = rowsObj;
				setGridRows(gridObj);
				$('body').resizeAllColumns();
			});
			
			try{viewProgBar(false);}catch(e){}
		}
		, null );
		
		xhr.sendRequest();
	}
	
	function selectTable(eng_nm, desc, user_daily, grp_cd, task_type, table_id) {
		$("#table_nm").val(eng_nm);
		
		dlClose("dl_tmp1");
		
		$("#p_sched_table").val(eng_nm);
		$("#p_application_of_def").val("");
		$("#p_group_name_of_def").val("");

		//어플리케이션 초기화
		$("select[name='application_of_def'] option").remove();
		$("select[name='application_of_def']").append("<option value=''>--선택--</option>");
		
		//그룹 초기화
		$("#group_name_of_def option").remove();
		$("#group_name_of_def").append("<option value=''>--선택--</option>");
		
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
	
	function goExcel() {
		var frm = document.f_s;
		
		try{viewProgBar(true);}catch(e){}
		
		frm.action = "<%=sContextPath %>/tWorks.ez?c=batchTotalExcel";
		frm.target = "if1";
		frm.submit();
		
		try{viewProgBar(false);}catch(e){}
	}
	
</script>