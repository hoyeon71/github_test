<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/jsp/common/inc/header.jsp"%>

<%
	Map<String, Object> paramMap = CommonUtil.collectParameters(request);
	String c = CommonUtil.isNull(paramMap.get("c"));
	String gridId = "g_"+c;
	
	String menu_gb = CommonUtil.getMessage("CATEGORY.GB.04.GB."+CommonUtil.isNull(paramMap.get("menu_gb")));
	String[] arr_menu_gb = menu_gb.split(",");
	
	// 세션값 가져오기.
	String strSessionDcCode 	= S_D_C_CODE;	
	String strSessionApp        = S_APP;
	String strSessionGrp        = S_GRP;
%>

<form id="f_s" name="f_s" method="post" onsubmit="return false;">	
	<input type='hidden' id='data_center_code' 		name='data_center_code'/>
	<input type='hidden' id='data_center' 			name='data_center'/>
	<input type='hidden' id='active_net_name' 		name='active_net_name'/>
	<input type='hidden' id='p_sched_table' 		name='p_sched_table'/>
	<input type='hidden' id='p_application_of_def' 	name='p_application_of_def'/>
	<input type='hidden' id='p_group_name_of_def' 	name='p_group_name_of_def'/>
	<input type='hidden' id='p_search_select' 		name='p_search_select'/>
	<input type='hidden' id='p_search_name' 		name='p_search_name'/>
	<input type='hidden' id='searchType' 			name='searchType'/>
	<input type='hidden' id='p_odate' 				name='p_odate'/>
	
	<input type="hidden" name="p_mcode_nm" 			id="p_mcode_nm" />
	<input type="hidden" name="p_scode_nm" 			id="p_scode_nm" />
	
	<input type="hidden" name="p_scode_cd" 			id="p_scode_cd" />
	<input type="hidden" name="p_grp_depth" 		id="p_grp_depth" />
	<input type="hidden" name="p_app_nm" 			id="p_app_nm" />
	<input type="hidden" name="p_app_search_gubun" 	id="p_app_search_gubun" />
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
					<td width="40%" style="text-align:left">
						<div class='cellContent_kang'>
						<select id="data_center_items" name="data_center_items" style="width:50%; height:21px;">
							<option value="">--선택--</option>
							<c:forEach var="cm" items="${cm}" varStatus="status">
								<option value="${cm.scode_cd},${cm.scode_eng_nm}">${cm.scode_nm}</option>
							</c:forEach>
						</select>
						</div>
					</td>
										
					<th width="10%"><div class='cellTitle_kang2'>어플리케이션(L3)</div></th>
					<td width="40%" style="text-align:left">
						<div class='cellContent_kang'>
							<input type="text" name="app_nm" id="app_nm" style="width:50%; height:21px;" readOnly/>&nbsp;<img id="btn_clear1" src="/images/sta2.png" style="width:16px;height:16px;vertical-align:middle;cursor:pointer;"/>
							<input type="hidden" name="application_of_def" id="application_of_def" />
						</div>
					</td>		
				</tr>
				<tr>
					<th><div class='cellTitle_kang2'>어플리케이션(L4)</div></th>
					<td style="text-align:left">
						<div class='cellContent_kang'>
						<select id="group_name_of_def" name="group_name_of_def" style="width:50%; height:21px;">
							<option value='' >--선택--</option>
						</select>
						</div>
					</td>
					
					<th><div class='cellTitle_kang2'>ODATE</div></th>
					<td style="text-align:left">
						<div class='cellContent_kang'>
						<input type="text" name="odate" id="odate" value="${ODATE}" class="input datepick" style="width:75px; height:21px;" maxlength="10" />
						</div>
					</td>
				</tr>
				<tr>	
					<th><div class='cellTitle_kang2'>조건</div></th>
					<td style="text-align:left" colspan="3">
						<div class='cellContent_kang'>
						<select name="search_select" id="search_select" style="height:21px;">
							<option value="job_name">작업명</option>
							<option value="condition">선행작업명</option>					
						</select>
						<input type="text" name="search_name" value= "" id="search_name" class="input" style="width:150px; height:21px;"/>
						</div>
					</td>				
				</tr>
				<tr>
					<td colspan="4" style="text-align:right;">
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
					<span id="btn_down">엑셀</span>
				</div>
			</h4>
		</td>
	</tr>
</table>
<script>
	
	var gridObj = {
		id : "<%=gridId %>"
		,colModel:[
	   		{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'번호',width:50,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	   			 
	   		,{formatter:gridCellNoneFormatter,field:'APPLICATION',id:'APPLICATION',name:'어플리케이션(L3)',width:120,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}	 
	   		,{formatter:gridCellNoneFormatter,field:'GROUP_NAME',id:'GROUP_NAME',name:'어플리케이션(L4)',width:120,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}	   		
	   		,{formatter:gridCellNoneFormatter,field:'JOB_NAME',id:'JOB_NAME',name:'작업명',width:200,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}	   		
	   		,{formatter:gridCellNoneFormatter,field:'CONDITION',id:'CONDITION',name:'선행작업조건',width:250,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'ORDER_TABLE',id:'ORDER_TABLE',name:'TAB',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   		//,{formatter:gridCellNoneFormatter,field:'JOB_ID',id:'JOB_ID',name:'JOB_ID',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   		//,{formatter:gridCellNoneFormatter,field:'TABLE_ID',id:'TABLE_ID',name:'TABLE_ID',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   	]
		,rows:[]
		,vscroll:<%=S_GRID_VSCROLL%>
	};
	
	$(document).ready(function(){
		
		var session_dc_code	= "<%=strSessionDcCode%>";
		var session_app	= "<%=strSessionApp%>";
		var session_grp	= "<%=strSessionGrp%>";
		
		$("#btn_search").show();
						
		var data_center_items = $("select[name='data_center_items'] option:selected").val();
		var application_of_def = $("select[name='application_of_def'] option:selected").val();
		
		$("#f_s").find("input[name='p_search_select']").val($("#frm1").find("select[name='search_select'] option:selected").val());
		$("#f_s").find("input[name='p_search_name']").val($("#frm1").find("input[name='search_name']").val());
		$("#f_s").find("input[name='p_odate']").val("${ODATE}");
				
		viewGrid_1(gridObj,"ly_"+gridObj.id);
		
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
			preJobMissMatchList();
		}		
		
		$("#btn_search").button().unbind("click").click(function(){
			
			var application_of_def = $("select[name='application_of_def'] option:selected").val();
			var data_center = $("select[name='data_center_items'] option:selected").val();
			
			if(data_center == ""){
				alert("C-M 을 선택해 주세요.");
				return;
			}
			
			
			$("#f_s").find("input[name='p_search_select']").val($("#frm1").find("select[name='search_select'] option:selected").val());
			$("#f_s").find("input[name='p_search_name']").val($("#frm1").find("input[name='search_name']").val());
			$("#f_s").find("input[name='p_odate']").val($("#frm1").find("input[name='odate']").val());
			
			preJobMissMatchList();
		});
		
		
		$('#search_name').unbind('keypress').keypress(function(e){			
			if(e.keyCode==13){	
				
				var application_of_def = $("select[name='application_of_def'] option:selected").val();
				var data_center = $("select[name='data_center_items'] option:selected").val();
				
				if(data_center == ""){
					alert("C-M 을 선택해 주세요.");
					return;
				}
						
				
				$("#f_s").find("input[name='p_search_select']").val($("#frm1").find("select[name='search_select'] option:selected").val());
				$("#f_s").find("input[name='p_search_name']").val($("#frm1").find("input[name='search_name']").val());
				$("#f_s").find("input[name='p_odate']").val($("#frm1").find("input[name='odate']").val());
				
				preJobMissMatchList();
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
			if($(this).val() != ""){
				$("#f_s").find("input[name='data_center']").val(data_center_items);
				//getAppGrpCodeList(arr_dt[0], "1", "", "application_of_def","");	
			}
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
			var arr_group = group_name_of_def.split(",");
			
			$("#f_s").find("input[name='p_group_name_of_def']").val(arr_group[1]);
		});
		
		$("#btn_down").button().unbind("click").click(function(){
			goExcel();
		});
		
		$("#odate").addClass("ime_readonly").unbind('click').click(function(){
			dpCalMin(this.id,'yymmdd','-90');
		});
		
		$("#btn_clear1").unbind("click").click(function(){
			$("#f_s").find("input[name='p_application_of_def']").val("");
			$("#f_s").find("input[name='p_group_name_of_def']").val("");
			
			$("#frm1").find("input[name='app_nm']").val("");
			$("#frm1").find("input[name='application_of_def']").val("");
					
			$("select[name='group_name_of_def'] option").remove();
			$("select[name='group_name_of_def']").append("<option value=''>--선택--</option>");
		});
		
	});
		
	function preJobMissMatchList(){
		
		try{viewProgBar(true);}catch(e){}
		$('#ly_total_cnt').html('');
		
		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=preJobMissMatch';
		
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
							
								var order_table = $(this).find("ORDER_TABLE").text();
								var application= $(this).find("APPLICATION").text();
								var group_name = $(this).find("GROUP_NAME").text();
								var job_name = $(this).find("JOB_NAME").text();
								var mem_name = $(this).find("MEM_NAME").text();
								var condition = $(this).find("CONDITION").text();
																							
								rowsObj.push({
									'grid_idx':i+1
									,'ORDER_TABLE': order_table
									,'APPLICATION': application
									,'GROUP_NAME': group_name
									,'JOB_NAME': job_name
									,'MEM_NAME': mem_name
									,'CONDITION': condition									
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
	
	function goExcel(){
		
		var frm = document.f_s;
		
		try{viewProgBar(true);}catch(e){}
		
		frm.action = "<%=sContextPath %>/mEm.ez?c=ez004_excel";
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
</script>
