<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/jsp/common/inc/header.jsp"%>

<%
	Map<String, Object> paramMap = CommonUtil.collectParameters(request);

	String c = CommonUtil.isNull(paramMap.get("c"));
	String gridId = "g_"+c;
	
	String menu_gb = CommonUtil.getMessage("CATEGORY.GB.04.GB."+CommonUtil.isNull(paramMap.get("menu_gb")));
	String[] arr_menu_gb = menu_gb.split(",");
	
	List dataCenterList = (List)request.getAttribute("dataCenterList");
	
	// 세션값 가져오기.
	String strSessionDcCode 	= S_D_C_CODE;
	String strSessionTab	 	= S_TAB;
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
					<th width="10%"><div class='cellTitle_kang2'>C-M</div></th>
					<td width="20%" style="text-align:left">
						<div class='cellContent_kang'>
						<select id="data_center_items" name="data_center_items" style="width:120px; height:21px;">
							<option value="">--선택--</option>
							<c:forEach var="cm" items="${cm}" varStatus="status">
								<option value="${cm.scode_cd},${cm.scode_eng_nm}">${cm.scode_nm}</option>
							</c:forEach>
						</select>
						</div>
					</td>
				</tr>
				<tr>
					<th width="10%"><div class='cellTitle_kang2' style='min-width:70px;'>폴더</div></th>
					<td width="20%" style="text-align:left;min-width:150px;">
						<div class='cellContent_kang'>
							<input type="text" name="table_nm" id="table_nm" style="width:120px; height:21px;" onkeydown="return false;" readonly/>&nbsp;<img id="btn_clear1" src="/images/sta2.png" style="width:16px;height:16px;vertical-align:middle;cursor:pointer;"/>
							<input type="hidden" name="table_of_def" id="table_of_def" />
<!-- 							<span>(폴더 단독 검색X)</span> -->
						</div>
					</td>
					
					
					<th width="10%"><div class='cellTitle_kang2' style='min-width:120px;'>어플리케이션</div></th>
					<td width="20%" style="text-align:left">
						<div class='cellContent_kang'>
							<select name="application_of_def" id="application_of_def" style="width:120px;height:21px;">
								<option value="">--선택--</option>
							</select>
						</div>
					</td>
					
					<th width="10%"><div class='cellTitle_kang2'>그룹</div></th>
					<td width="35%" style="text-align:left">
						<div class='cellContent_kang'>
						<select id="group_name_of_def" name="group_name_of_def" style="width:120px; height:21px;">
							<option value=''>--선택--</option>
						</select>
						</div>
					</td>						
				</tr>
				<tr>
					<th width="10%"><div class='cellTitle_kang2'>일자</div></th>
					<td width="20%" style="text-align:left">
						<div class='cellContent_kang'>
						<input type="text" name="from_odate" id="from_odate" value="${ODATE}" class="input datepick" style="width:60px; height:21px;" maxlength="10" readOnly/> ~
						<input type="text" name="to_odate" id="to_odate" value="${ODATE}" class="input datepick" style="width:60px; height:21px;" maxlength="10" readOnly/>
						</div>
					</td>
					
					<th width="10%"><div class='cellTitle_kang2'>구분</div></th>
					<td width="25%" style="text-align:left;min-width:300px;">
						<div class='cellContent_kang'>
						<select name="search_gubun" id="search_gubun" style="width:120px;height:21px;">
							<option value="job_name">작업명</option>			
							<option value="user_nm">담당자</option>
						</select>
						<input type="text" name="search_text" value= "" id="search_text" class="input" style="width:130px; height:21px;"/>
						</div>
					</td>
					
					<th width="10%"><div class='cellTitle_kang2'>Severity</div></th>
					<td width="35%" style="text-align:left;min-width:350px;">
						<div class='cellContent_kang'>
						<input type="radio" name="severity" id="severity" value="V_U_R" checked />전체&nbsp;
						<input type="radio" name="severity" id="severity" value="V" />Very Urgent&nbsp;
						<input type="radio" name="severity" id="severity" value="U" />Urgent&nbsp;
						<input type="radio" name="severity" id="severity" value="R" />Regular
							<span id='btn_search' style='float:right;margin:3px;'>검 색</span>
						</div>
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
					<div id='ly_total_cnt' style='padding-top:3px;float:left;'></div>
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
	   		,{formatter:gridCellNoneFormatter,field:'APPLICATION',id:'APPLICATION',name:'어플리케이션',width:120,minWidth:120,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}	 
	   		,{formatter:gridCellNoneFormatter,field:'GROUP_NAME',id:'GROUP_NAME',name:'그룹',width:120,minWidth:120,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}	   		
	   		,{formatter:gridCellNoneFormatter,field:'JOB_NAME',id:'JOB_NAME',name:'작업명',width:200,minWidth:200,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'HANDLED_NAME',id:'HANDLED_NAME',name:'HANDLED',width:100,minWidth:100,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'CHANGED_BY',id:'CHANGED_BY',name:'CHANGED BY',width:100,minWidth:100,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'MESSAGE',id:'MESSAGE',name:'MESSAGE',width:430,minWidth:430,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'NOTES',id:'NOTES',name:'NOTES',width:150,minWidth:150,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'HOST_TIME',id:'HOST_TIME',name:'HOST_TIME',width:150,minWidth:150,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'UPD_TIME',id:'UPD_TIME',name:'UPD_TIME',width:120,minWidth:120,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'USER_NM',id:'USER_NM',name:'담당자',width:70,minWidth:70,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	   			   		
	   	]
		,rows:[]
		,vscroll:<%=S_GRID_VSCROLL%>
	};
	
	$(document).ready(function(){
		
		var session_dc_code	= "<%=strSessionDcCode%>";
		var table_name		= "<%=strSessionTab%>";
		var application		= "<%=strSessionApp%>";
		var group_name		= "<%=strSessionGrp%>";
		
		$("#btn_search").show();
						
		var frm = document.frm1;
		var data_center = "";
		if( null != document.getElementById('data_center_items') ){
			var sTmp = document.getElementById('data_center_items').value ;
			var aTmp = sTmp.split(",");
						
			$("#f_s").find("input[name='data_center_code']").val(aTmp[0]);
			$("#f_s").find("input[name='data_center']").val(aTmp[1]);
			$("#f_s").find("input[name='active_net_name']").val(aTmp[2]);
			
			data_center = aTmp[1];
		}
		
		$("#f_s").find("input[name='p_severity']").val($("#frm1").find("input:radio[name='severity']:checked").val());
		$("#f_s").find("input[name='p_search_gubun']").val($("#frm1").find("select[name='search_gubun'] option:selected").val());
		$("#f_s").find("input[name='p_search_text']").val($("#frm1").find("input[name='search_text']").val());

		$("#f_s").find("input[name='p_from_odate']").val($("#frm1").find("input[name='from_odate']").val());
		$("#f_s").find("input[name='p_to_odate']").val($("#frm1").find("input[name='to_odate']").val());
		
		//초기 검색조건 - C-M, 폴더, 어플리케이션, 그룹
		if(session_dc_code != "") { // 개인정보에 C-M이 등록되어 있을경우
			$("select[name='data_center_items']").val(session_dc_code);
			$("#f_s").find("input[name='data_center']").val(session_dc_code);
		}else { // 개인정보에 C-M이 등록이 되어있지 않을경우 -> C-M 콤보박스에서 첫번째값 선택
			$("#data_center_items option:eq(1)").prop("selected", true);
			$("#f_s").find("input[name='data_center']").val($("select[name='data_center_items']").val());
		}

		if(table_name != '') {
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

		setTimeout(function(){
			alertList();	
		}, 1000);
		//페이지 리프레시 1000 -> 1초
		setInterval(function(){
			alertList();
		}, 10000);
		
		$("#btn_search").button().unbind("click").click(function(){
			$("#f_s").find("input[name='p_severity']").val($("#frm1").find("input:radio[name='severity']:checked").val());
			$("#f_s").find("input[name='p_search_gubun']").val($("#frm1").find("select[name='search_gubun'] option:selected").val());
			$("#f_s").find("input[name='p_search_text']").val($("#frm1").find("input[name='search_text']").val());

			$("#f_s").find("input[name='p_from_odate']").val($("#frm1").find("input[name='from_odate']").val());
			$("#f_s").find("input[name='p_to_odate']").val($("#frm1").find("input[name='to_odate']").val());
			
			var data_center_items = $("select[name='data_center_items'] option:selected").val();
			
			if(data_center_items == ""){
				alert("C-M 을 선택해 주세요.");
				return;
			}
			
			if ( $("#p_from_odate").val() != "" && $("#p_to_odate").val() != "" ) {
				
				// 날짜 기간 체크
				if ( $("#p_from_odate").val() > $("#p_to_odate").val() ) {
					alert("일자의 FROM ~ TO를 확인해 주세요.");
					return;
				}
			}
			
			
			if($("input[name='table_nm']").val() != "" && $("#application_of_def").val() == "" ) {
				var search_table = $("input[name='table_nm']").val();
				if(search_table.indexOf(",") == -1 ) {
					alert("어플리케이션을 선택해 주세요.");
				}
			}
			
			alertList();
		});
		
		$('#search_text').unbind('keypress').keypress(function(e){			
			if(e.keyCode==13){	
				$("#f_s").find("input[name='p_severity']").val($("#frm1").find("input:radio[name='severity']:checked").val());
				$("#f_s").find("input[name='p_search_gubun']").val($("#frm1").find("select[name='search_gubun'] option:selected").val());
				$("#f_s").find("input[name='p_search_text']").val($("#frm1").find("input[name='search_text']").val());

				$("#f_s").find("input[name='p_from_odate']").val($("#frm1").find("input[name='from_odate']").val());
				$("#f_s").find("input[name='p_to_odate']").val($("#frm1").find("input[name='to_odate']").val());
				
				var data_center_items = $("select[name='data_center_items'] option:selected").val();
				
				if(data_center_items == ""){
					alert("C-M 을 선택해 주세요.");
					return;
				}
				
				alertList();
			}
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
			if($(this).val() != ""){
				$("#f_s").find("input[name='data_center']").val(data_center_items);
				//getAppGrpCodeList(arr_dt[0], "1", "", "application_of_def","");	
			}
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
		
	});
	
	function selectTable(eng_nm, desc, user_daily, grp_cd){
		
		$("#table_nm").val(eng_nm);
		$("#table_of_def").val(eng_nm);
		$("#f_s").find("input[name='p_sched_table']").val(eng_nm);
		
		$("input[name='application']").val("");
		$("input[name='group_name']").val("");
		
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
		
	}

	function alertList(){
		
		try{viewProgBar(true);}catch(e){}
		$('#ly_total_cnt').html('');
		
		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=alertList';
		
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
							
								var application= $(this).find("APPLICATION").text();
								var group_name = $(this).find("GROUP_NAME").text();
								var job_name = $(this).find("JOB_NAME").text();
								var mem_name = $(this).find("MEM_NAME").text();
								var user_nm = $(this).find("USER_NM").text();
								var handled_name = $(this).find("HANDLED_NAME").text();
								var changed_by = $(this).find("CHANGED_BY").text();
								var message = $(this).find("MESSAGE").text();
								var notes = $(this).find("NOTES").text();
								var host_time = $(this).find("HOST_TIME").text();
								var upd_time = $(this).find("UPD_TIME").text();
																							
								rowsObj.push({
									'grid_idx':i+1
									,'APPLICATION': application
									,'GROUP_NAME': group_name
									,'JOB_NAME': job_name
									,'MEM_NAME': mem_name
									,'USER_NM': user_nm									
									,'HANDLED_NAME': handled_name
									,'CHANGED_BY': changed_by
									,'MESSAGE': message
									,'NOTES': notes
									,'HOST_TIME': host_time
									,'UPD_TIME': upd_time									
								});
							});						
						}
						
						gridObj.rows = rowsObj;
						setGridRows(gridObj);
						
						//컬럼 자동 조정 기능
						$('body').resizeAllColumns();
						$('#ly_total_cnt').html('[ TOTAL : '+items.attr('cnt')+' ]');
						
					});
					try{viewProgBar(false);}catch(e){}
				}
		, null );
		
		xhr.sendRequest();
	}
			
	function goExcel(){
		
		var frm = document.f_s;
		
		try{viewProgBar(true);}catch(e){}
		
		frm.action = "<%=sContextPath %>/aEm.ez?c=ez001_excel";
		frm.target = "if1";
		frm.submit();
		
		try{viewProgBar(false);}catch(e){}
	}

</script>
