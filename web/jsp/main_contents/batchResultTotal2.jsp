<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/jsp/common/inc/header.jsp"%>

<%
	Map<String, Object> paramMap = CommonUtil.collectParameters(request);
	String c = CommonUtil.isNull(paramMap.get("c"));
	String gridId = "g_"+c;
	List dataCenterList = (List)request.getAttribute("dataCenterList");

	String strMenuGb = CommonUtil.isNull(paramMap.get("menu_gb"));
	String menu_gb = CommonUtil.getMessage("CATEGORY.GB.09.GB."+strMenuGb);
	String[] arr_menu_gb = menu_gb.split(",");
	
	String odate = (String)request.getAttribute("ODATE");
	odate = odate.replace("/", "");
	// 세션값 가져오기.
	String strSessionDcCode 	= S_D_C_CODE;	
	String strSessionTab	 	= S_TAB;
	String strSessionApp	 	= S_APP;
	String strSessionGrp	 	= S_GRP;
%>

<form id="f_s" name="f_s" method="post" onsubmit="return false;">
	<input type='hidden' id='data_center_code' name='data_center_code'/>
	<input type='hidden' id='data_center' name='data_center'/>
	<input type='hidden' id='active_net_name' name='active_net_name' value="${active_net_name}" />
	<input type='hidden' id='p_sched_table' name='p_sched_table'/>
	<input type='hidden' id='p_application_of_def' name='p_application_of_def'/>
	<input type='hidden' id='p_group_name_of_def' name='p_group_name_of_def'/>
	<input type='hidden' id='p_application_of_def_text' 	name='p_application_of_def_text'/>
	<input type='hidden' id='p_search_gubun' name='p_search_gubun'/>
	<input type='hidden' id='p_search_text' name='p_search_text'/>
	<input type='hidden' id='searchType' name='searchType'/>
	<input type='hidden' id='p_s_odate' name='p_s_odate'/>
	<input type='hidden' id='p_e_odate' name='p_e_odate'/>
	<input type='hidden' id='p_status' name='p_status'/>
	<input type='hidden' id='p_search_node_id' name='p_search_node_id'/>
	<input type='hidden' id='p_node_id' name='p_node_id'/>
	<input type='hidden' id='p_cyclic' name='p_cyclic'/>

	<input type="hidden" name="odate" id="odate"/>
	<input type="hidden" name="order_id" id="order_id"/>
	<input type="hidden" name="job_name" id="job_name"/>
	<input type="hidden" name="status" id="status"/>
	<input type="hidden" name="job" id="job"/>
	<input type="hidden" name="graph_depth" id="graph_depth"/>
	<input type="hidden" name="order_36_id" id="order_36_id"/>
	<input type="hidden" name="end_date" id="end_date"/>
	<input type="hidden" name="rerun_count" id="rerun_count"/>
	<input type="hidden" name="memname" id="memname"/>
	<input type="hidden" name="total_rerun_count" id="total_rerun_count"/>
	<input type="hidden" name="node_id" id="node_id"/>
	<input type="hidden" name="active_gb" id="active_gb"/>
	<input type="hidden" name="page_gubun" id="page_gubun" value="active_job_list" />	<!-- 이 항목이 있어야 수정화면이 열림 -->
	<input type="hidden" name="menu_gb" id="menu_gb" value="<%=strMenuGb %>" />
	<input type="hidden" name="p_mcode_nm" id="p_mcode_nm" />
	<input type="hidden" name="p_scode_nm" id="p_scode_nm" />
	
<!-- 	<input type="hidden" name="p_run_gubun" id="p_run_gubun" />	 -->
	
	<input type="hidden" name="p_scode_cd" id="p_scode_cd" />
	<input type="hidden" name="p_grp_depth" id="p_grp_depth" />
	<input type="hidden" name="p_app_nm" id="p_app_nm" />
	<input type="hidden" name="p_app_search_gubun" id="p_app_search_gubun" />
</form>

<table style='width:100%;height:100%;border:none;'>
	<tr style='height:10px;'>
		<td style='vertical-align:top;'>
			<h4 class="ui-widget-header ui-corner-all"  >
				<div id='t_<%=gridId %>' class='title_area' >
					<span><%=CommonUtil.isNull(CommonUtil.getMessage("CATEGORY.GB.09"))%> > <%=CommonUtil.isNull(arr_menu_gb[0]) %></span>
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
						<div class='cellContent_kang' style='width:250px;'>
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
<%-- 						<input type="text" name="s_odate" id="s_odate" value="<%=odate %>" class="input datepick" style="width:70%; height:21px;" maxlength="10" readOnly/> --%>
						<input type="text" name="s_odate" id="s_odate" value="<%=odate %>" class="input datepick" style="width:70px; height:21px;" maxlength="8" onclick="dpCalMin('s_odate','yymmdd');" />
						 ~<input type="text" name="e_odate" id="e_odate" value="<%=odate %>" class="input datepick" style="width:70px; height:21px;" maxlength="8" onclick="dpCalMin('e_odate','yymmdd');" />
						</div>
					</td>
					<th width="10%"><div class='cellTitle_kang2'>반복여부</div></th>
					<td width="25%" style="text-align:left">
						<div class='cellContent_kang'>
							<select id="cyclic" name="cyclic" style="width:120px; height:21px;">
								<option value=''>--선택--</option>
								<option value='1'>Y</option>
								<option value='0'>N</option>
							</select>
						</div>
 					</td>
				</tr>
				<tr>			
					<th><div class='cellTitle_kang2'>폴더</div></th>
					<td style="text-align:left">
						<div class='cellContent_kang'>
							<input type="text" name="table_nm" id="table_nm" style="width:120px; height:21px;" onkeydown="return false;" readonly/>&nbsp;
							<select name="sub_table_of_def" id="sub_table_of_def" style="width:120px;height:21px;display:none;">
								<option value="">전체</option>
							</select>
							<img id="btn_clear1" src="/images/sta2.png" style="width:16px;height:16px;vertical-align:middle;cursor:pointer;"/>
							<input type="hidden" name="table_of_def" id="table_of_def" />
							
<!-- 							<input type="hidden" name="table_name" id="table_name" /> -->
						</div>
					</td>
						
					<th><div class='cellTitle_kang2'>어플리케이션</div></th>
					<td style="text-align:left">
						<div class='cellContent_kang'>
							<select name="application_of_def" id="application_of_def" style="width:120px;height:21px;">
								<option value="">--선택--</option>
							</select>
<!-- 							<input type='hidden' id='application' name='application' value='' /> -->
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
						<span id="btn_search" style='display:none;margin:3px;'>검 색</span>
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
					{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'번호',minWidth:20,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
					,{formatter:gridCellNoneFormatter,field:'data_center',id:'data_center',name:'C-M',minWidth:100,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
					,{formatter:gridCellNoneFormatter,field:'table_name',id:'table_name',name:'폴더',minWidth:120,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
					,{formatter:gridCellNoneFormatter,field:'application',id:'application',name:'어플리케이션',minWidth:120,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
			   		,{formatter:gridCellNoneFormatter,field:'group_name',id:'group_name',name:'그룹',minWidth:120,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
			   		,{formatter:gridCellNoneFormatter,field:'odate',id:'odate',name:'ODATE',minWidth:100,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
			   		,{formatter:gridCellNoneFormatter,field:'ok_cnt',id:'ok_cnt',name:'성공',minWidth:80,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
			   		,{formatter:gridCellNoneFormatter,field:'not_ok_cnt',id:'not_ok_cnt',name:'오류',minWidth:80,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
			   		,{formatter:gridCellNoneFormatter,field:'exec_cnt',id:'exec_cnt',name:'수행중',minWidth:80,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
			   		,{formatter:gridCellNoneFormatter,field:'wait_user_cnt',id:'wait_user_cnt',name:'대기_USER',minWidth:80,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
			   		,{formatter:gridCellNoneFormatter,field:'wait_resource_cnt',id:'wait_resource_cnt',name:'대기_RESOURCE',minWidth:80,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
			   		,{formatter:gridCellNoneFormatter,field:'wait_host_cnt',id:'wait_host_cnt',name:'대기_HOST',minWidth:80,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
			   		,{formatter:gridCellNoneFormatter,field:'wait_condition_cnt',id:'wait_condition_cnt',name:'대기_CONDITION',minWidth:80,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
// 			   		,{formatter:gridCellNoneFormatter,field:'wait_time_cnt',id:'wait_time_cnt',name:'대기_TIME',width:75,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
			   		,{formatter:gridCellNoneFormatter,field:'delete_cnt',id:'delete_cnt',name:'삭제',minWidth:75,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
					,{formatter:gridCellNoneFormatter,field:'total_cnt',id:'RUNNING_CNT',name:'TOTAL',minWidth:80,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}


			   	]
		,rows:[]
		,vscroll:false
	};
	
	$(document).ready(function(){
		
		var session_dc_code	= "<%=strSessionDcCode%>";
		var table_name		= "<%=strSessionTab%>";
		var application		= "<%=strSessionApp%>";
		var group_name		= "<%=strSessionGrp%>";
		
		$("#btn_search").show();
						
		var frm = document.frm1;
		var data_center = "";
// 		if( null != document.getElementById('data_center_items') ){
// 			var sTmp = document.getElementById('data_center_items').value ;
// 			var aTmp = sTmp.split(",");
						
// 			$("#f_s").find("input[name='data_center_code']").val(aTmp[0]);
// 			$("#f_s").find("input[name='data_center']").val(aTmp[1]);
// 			$("#f_s").find("input[name='active_net_name']").val(aTmp[2]);
// 			data_center = aTmp[1];
// 		}
		
		//TAB
		//setSelectItemList('<%=sContextPath %>/common.ez?c=cData&itemType=select&itemGb=searchItemList&searchType=application_of_defList&data_center='+data_center);
		
		viewGrid_1(gridObj,"ly_"+gridObj.id,{enableColumnReorder:true},'AUTO');
		
		//batchResultTotal();
		
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
		
		$("#data_center_items").change(function(){
			
			//초기화
			$("#table_nm").val("");
			$("#table_of_def").val("");

			$("select[name='application_of_def'] option").remove();
			$("select[name='application_of_def']").append("<option value=''>--선택--</option>");
			
			$("select[name='group_name_of_def'] option").remove();
			$("select[name='group_name_of_def']").append("<option value=''>--선택--</option>");
			
			$("#data_center").val($(this).val());	
		});
		
		$("#btn_search").button().unbind("click").click(function(){
			var data_center_items = $("select[name='data_center_items'] option:selected").val();
			if(data_center_items == ""){
				alert("C-M 을 선택해 주세요.");
				return;
			}
			$("#f_s").find("input[name='p_s_odate']").val($("#frm1").find("input[name='s_odate']").val());
			$("#f_s").find("input[name='p_e_odate']").val($("#frm1").find("input[name='e_odate']").val());

			$("#f_s").find("input[name='p_cyclic']").val($("select[name='cyclic'] option:selected").val());
			
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
				batchResultTotal();
			}, 1000);

		});
		
		// 어플리케이션 엔터
		$('#application_of_def_text').unbind('keypress').keypress(function(e) {
			if(e.keyCode==13){
				$("#btn_search").trigger("click");
			}
		});
		
// 		$("#s_odate").addClass("ime_readonly").unbind('click').click(function(){
// 			dpCalMin(this.id,'yymmdd');
// 		});
		
		/* $("#app_nm").click(function(){
			var data_center = $("select[name='data_center_items'] option:selected").val();
			
			if(data_center == ""){
				alert("C-M 을 선택해 주세요.");
				return;
			}else{
				searchPoeAppForm();
			}		
		});
		
		$("#data_center_items").change(function(){		//C-M
			setSearchItemList('sched_tableList', 'data_center_items');	
		}); */
		
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
		
		$("#btn_down").button().unbind("click").click(function(){
			var data_center_items = $("select[name='data_center_items'] option:selected").val();
			if(data_center_items == ""){
				alert("C-M 을 선택해 주세요.");
				return;
			}
			goExcel();
		});
		
		$("#odate").addClass("ime_readonly").unbind('click').click(function(){
			dpCalMin(this.id,'yymmdd');
		});
		
		$("#btn_clear1").unbind("click").click(function(){
			$("#f_s").find("input[name='p_sched_table']").val("");
			$("#f_s").find("input[name='p_application_of_def']").val("");
			$("#f_s").find("input[name='p_group_name_of_def']").val("");

			$("#frm1").find("input[name='table_nm']").val("");
			$("#frm1").find("input[name='table_of_def']").val("");
			
			$("#f_s").find("input[name='p_application_of_def_text']").val("");
			
			$("#frm1").find("input[name='application_of_def_text']").val("");

			$("select[name='application_of_def'] option").remove();
			$("select[name='application_of_def']").append("<option value=''>--선택--</option>");
			
			$("select[name='group_name_of_def'] option").remove();
			$("select[name='group_name_of_def']").append("<option value=''>--선택--</option>");
			
			$("select[name='sub_table_of_def'] option").remove();
			$("select[name='sub_table_of_def']").append("<option value=''>--선택--</option>");
			
			document.getElementById('sub_table_of_def').style.display = 'none';
			
		});
		
		$('#application_of_def_text').on('keyup', function(event) {
			var app_text = $(this).val().replace(/ /gi, '');
			$('#p_application_of_def_text').val(app_text);
		});
		
		/* $("#btn_clear2").unbind("click").click(function(){
			$("#frm1").find("input[name='search_text']").val("");
		});
		$("#btn_clear3").unbind("click").click(function(){
			$("#frm1").find("input[name='scode_nm']").val("");
		}); */
	});
	
	function selectTable(eng_nm, desc, user_daily, grp_cd, task_type, table_id){
		
		$("#table_nm").val(eng_nm);
		$("#table_of_def").val(eng_nm);
		
		dlClose("dl_tmp1");

		//$("#f_s").find("input[name='p_sched_table']").val("'"+eng_nm+"'");
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
		
		$("select[name='group_name_of_def'] option").remove();
		$("select[name='group_name_of_def']").append("<option value=''>--선택--</option>");
		
	}
	
	/* function selectApplication(eng_nm, desc){
		
		$("#app_nm").val(desc);
		$("#application_of_def").val(eng_nm);	
		
		dlClose("dl_tmp1");
		
		//검색의 애플리케이션에 값을 셋
		$("#f_s").find("input[name='p_application_of_def']").val("'"+eng_nm+"'");
		$("#f_s").find("input[name='p_group_name_of_def']").val("");
		
		//그룹을 검색		
		getAppGrpCodeList("", "2", "", "group_name_of_def","'"+eng_nm+"'");
		
	} */
	
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
	
	function setSearchItemList(type, nm) {

		var frm = document.frm1;
		var data_center = "";
		var item_id = "";
		
		if( null != document.getElementById('data_center_items') ) {
			var sTmp = document.getElementById('data_center_items').value ;
			var aTmp = sTmp.split(",");
			
			$("#f_s").find("input[name='data_center_code']").val(aTmp[0]);
			$("#f_s").find("input[name='data_center']").val(aTmp[1]);
			$("#f_s").find("input[name='active_net_name']").val(aTmp[2]);
			
			data_center = aTmp[1];
		}

		$("#f_s").find("input[name='searchType']").val(type);
	
		//TAB
		var sched_table = $("#frm1").find("select[name='sched_table'] option:selected").val();
		var application_of_def = $("#frm1").find("select[name='application_of_def'] option:selected").val();
		
		//alert(nm);
		if(nm == "application_of_def"){
			setSelectItemList('<%=sContextPath %>/common.ez?c=cData&itemType=select&itemGb=searchItemList&searchType='+type+'&application_of_def='+application_of_def+'&data_center='+data_center);
		}else{
			setSelectItemList('<%=sContextPath %>/common.ez?c=cData&itemType=select&itemGb=searchItemList&searchType='+type+'&data_center='+data_center);
		}
	}
	
	function batchResultTotal(){
		
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
		
		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=batchResultTotalList2&itemGubun=2';
		
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
								
// 								var gubun 				= $(this).find("gubun").text();
								var data_center			= $(this).find("data_center").text();
								var table_name 			= $(this).find("table_name").text();
								var application			= $(this).find("application").text();
								var group_name 			= $(this).find("group_name").text();
								var odate 				= $(this).find("odate").text();
// 								var order_date 			= $(this).find("order_date").text();
								var total_cnt			= $(this).find("total_cnt").text();
								var ok_cnt 				= $(this).find("ok_cnt").text();
								var not_ok_cnt 			= $(this).find("not_ok_cnt").text();
								var exec_cnt 			= $(this).find("exec_cnt").text();
								var wait_user_cnt 		= $(this).find("wait_user_cnt").text();
								var wait_resource_cnt 	= $(this).find("wait_resource_cnt").text();
								var wait_host_cnt 		= $(this).find("wait_host_cnt").text();
								var wait_condition_cnt 	= $(this).find("wait_condition_cnt").text();
// 								var wait_time_cnt 		= $(this).find("wait_time_cnt").text();
								var delete_cnt 			= $(this).find("delete_cnt").text();								
								var smart_job_yn		= $(this).find("smart_job_yn").text();
								
								var smart_folder = "";
								if ( smart_job_yn == "Y" ) {
									smart_folder = "<img src='/imgs/smart_folder.png' style='vertical-align:middle;' width='20' height='20'> ";
								}
								
								rowsObj.push({
									'grid_idx':i+1
// 									,'gubun': gubun
									,'data_center': data_center
									,'table_name': smart_folder + table_name
									,'application': application
									,'group_name': group_name
									,'odate': odate
// 									,'order_date': order_date
									,'total_cnt': total_cnt
									,'ok_cnt': ok_cnt
									,'not_ok_cnt': not_ok_cnt
									,'exec_cnt': exec_cnt
									,'wait_user_cnt': wait_user_cnt
									,'wait_resource_cnt': wait_resource_cnt
									,'wait_host_cnt': wait_host_cnt
									,'wait_condition_cnt': wait_condition_cnt
// 									,'wait_time_cnt': wait_time_cnt
									,'delete_cnt': delete_cnt
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

	function goExcel(){
		
		var frm = document.f_s;
		
		try{viewProgBar(true);}catch(e){}
		
		frm.action = "<%=sContextPath %>/mEm.ez?c=ez044_excel";
		frm.target = "if1";
		frm.submit();
		
		try{viewProgBar(false);}catch(e){}
	}
	
</script>
