<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@include file="/jsp/common/inc/header.jsp"%>
<%@include file="/jsp/common/inc/sessionChkPopup.jsp"%>

<%
	Map<String, Object> paramMap = CommonUtil.collectParameters(request);
	String c = CommonUtil.isNull(paramMap.get("c"));
	
	String user_cd    	 = CommonUtil.isNull(paramMap.get("user_cd"));
	String isMoreThanTwo = CommonUtil.isNull(paramMap.get("is_more_than_two"));
	String select_dcc    = CommonUtil.isNull(paramMap.get("select_dcc"));
	System.out.println("isMoreThanTwo : " + isMoreThanTwo);
%>

<form id="f_s" name="f_s" method="post" onsubmit="return false;">
	<input type='hidden' id='p_grp_depth' 				name='p_grp_depth' 	value='1'/>
	<input type='hidden' id='flag' 						name='flag' 		value='folder_auth'/>
	<input type='hidden' id='p_scode_cd' 				name='p_scode_cd'	/>
	<input type='hidden' id='user_cd' 					name='user_cd' 		value='<%=user_cd%>'/>
	<input type='hidden' id='p_grp_eng_nm' 				name='p_grp_eng_nm' />
	<input type='hidden' id='p_grp_table_type'			name='p_grp_table_type'/>
	<input type='hidden' id='p_app_grp_data_center' 	name='p_app_grp_data_center'/>
	<input type='hidden' id='data_center' 				name='data_center'/>
	<input type='hidden' id='folder_auth' 				name='folder_auth'/>
	<input type='hidden' id='p_grp_parent_cd' 			name='p_grp_parent_cd'/>
	<input type='hidden' id='p_user_daily' 				name='p_user_daily'/>
	<input type='hidden' id='p_no_auth' 				name='p_no_auth'/>
	<input type='hidden' id='p_folder_name' 			name='p_folder_name'/>
	
	<input type='hidden' id='p_search_folder' 			name='p_search_folder'/>
	<input type='hidden' id='p_isMoreThanTwo' 			name='p_isMoreThanTwo'/>
</form>

<form id="f_s2" name="f_s2" method="post" onsubmit="return false;">
	<input type='hidden' id='p_grp_depth' 				name='p_grp_depth' 	value='1'/>
	<input type='hidden' id='flag' 						name='flag' 		value='folder_auth'/>
	<input type='hidden' id='user_cd' 					name='user_cd' 		value='<%=user_cd%>'/>
	<input type='hidden' id='p_app_grp_data_center' 	name='p_app_grp_data_center'/>
	<input type='hidden' id='data_center' 				name='data_center'/>
	<input type='hidden' id='folder_auth' 				name='folder_auth'/>
	<input type='hidden' id='p_grp_parent_cd' 			name='p_grp_parent_cd'/>
	<input type='hidden' id='p_search_folder' 			name='p_search_folder'/>
	<input type='hidden' id='p_isMoreThanTwo' 			name='p_isMoreThanTwo'/>
</form>

<table style='width:100%;height:100%;border:none;' >
	<tr style='height:10px;'>
		<td style='vertical-align:top;'>
			<h4  class="ui-widget-header ui-corner-all" >
				<div class='title_area'>
					C-M : 
					<select name='app_grp_data_center' id='app_grp_data_center' style='height:18px;'>
					<option value=''>--선택--</option>
					<c:forEach var="cm" items="${SCODE_GRP_LIST}" varStatus="status">
						<option value='${cm.scode_cd},${cm.scode_eng_nm}'>${cm.scode_nm}</option>
					</c:forEach>
					&nbsp;폴더명 : 
					<input type='text' name='search_folder' id='search_folder' value='' />&nbsp;&nbsp;
					<input type='button' class='btn_blue_h20' value='조회' onclick="fn_search_list();" />
				</div>
			</h4>
		</td>
		<%if(isMoreThanTwo.equals("N")) {%>
		<td style='vertical-align:top;'>
			<h4  class="ui-widget-header ui-corner-all" >
				<div class='title_area' >
					C-M : 
					<select name='user_app_grp_data_center' id='user_app_grp_data_center' style='height:18px;'>
					<option value=''>--선택--</option>
					<c:forEach var="cm" items="${SCODE_GRP_LIST}" varStatus="status">
						<option value='${cm.scode_cd},${cm.scode_eng_nm}'>${cm.scode_nm}</option>
					</c:forEach>
					&nbsp;폴더명 : 
					<input type='text' name='user_search_folder' id='user_search_folder' value='' />&nbsp;&nbsp;
					<input type='button' class='btn_blue_h20' value='조회' onclick="fn_search_userFolderList();" />
				</div>
			</h4>
		</td>
		<%}%>
	</tr>
	<tr style='height:10px;'>
		<td style='vertical-align:top;' >
			<h4  class="ui-widget-header ui-corner-all"  >
				<div class='title_area' >폴더 목록</div>
			</h4>
		</td>
		<%if(isMoreThanTwo.equals("N")) {%>
		<td style='vertical-align:top;' >
			<h4  class="ui-widget-header ui-corner-all"  >
				<div class='title_area' >사용자 폴더</div>
			</h4>
		</td>
		<%}%>
	</tr>
	<tr>
		<td style='vertical-align:top;width:50%;'>
			<table class='sub_table' style='width:100%;border:none;'>
				<tr style='height:480px;'>
					<td id='ly_appGrpCodeGrid_in' style='vertical-align:top;'>
						<div id='appGrpCodeGrid_in' class='ui-widget-header ui-corner-all' style='height:480px;' ></div>
					</td>
				</tr>
				<tr>
					<td  style='vertical-align:top;'>
					<%if(isMoreThanTwo.equals("N")) {%>
						<div align='right' class='ui-widget-header ui-corner-all'style='padding:3px;'>
							<span id='btn_code_insert'>추가</span>
						</div>
					<%}else{ %>
						<div align='right' class='ui-widget-header ui-corner-all'style='padding:3px;'>
							<span id='btn_code_insert'>저장</span>
						</div>
					<%} %>
					</td>
				</tr>
			</table>
		</td>
		<%if(isMoreThanTwo.equals("N")) {%>
		<td style='vertical-align:top;width:50%;'>
			<table class='sub_table' style='width:100%;border:none;'>
				<tr style='height:480px;'>
					<td id='ly_appGrpCodeGrid_out' style='vertical-align:top;'>
						<div id='appGrpCodeGrid_out' class='ui-widget-header ui-corner-all' style='height:480px;'></div>
					</td>
				</tr>
				<tr>
					<td style='vertical-align:top;' >
						<div align='right' class='ui-widget-header ui-corner-all'style='padding:3px;'>
							<span id='btn_code_delete'>삭제</span>
						</div>
					</td>
				</tr>
			</table>
		</td>
		<%}%>
	</tr>
</table>

<script>
	var appGrpCodeGrid_in = {
		id : 'appGrpCodeGrid_in'
		,colModel:[
			{formatter:gridCellNoneFormatter,field:'SCODE_NM',id:'SCODE_NM',name:'C-M',width:100,headerCssClass:'cellCenter',cssClass:'cellCenter'}
	   		,{formatter:gridCellNoneFormatter,field:'GRP_ENG_NM',id:'GRP_ENG_NM',name:'폴더',width:200,minWidth:0,headerCssClass:'cellCenter',cssClass:'cellCenter'}
	   		,{formatter:gridCellNoneFormatter,field:'DATA_CENTER',id:'DATA_CENTER',name:'DATA_CENTER',width:100,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   		,{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'grid_idx',width:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   	]
		,rows:[]
	};
	
	var appGrpCodeGrid_out = {
			id : 'appGrpCodeGrid_out'
			,colModel:[
				{formatter:gridCellNoneFormatter,field:'SCODE_NM',id:'SCODE_NM',name:'C-M',width:100,headerCssClass:'cellCenter',cssClass:'cellCenter'}
		   		,{formatter:gridCellNoneFormatter,field:'GRP_ENG_NM',id:'GRP_ENG_NM',name:'폴더',width:200,minWidth:0,headerCssClass:'cellCenter',cssClass:'cellCenter'}
		   		,{formatter:gridCellNoneFormatter,field:'DATA_CENTER',id:'DATA_CENTER',name:'DATA_CENTER',width:100,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
		   		,{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'grid_idx',width:0,headerCssClass:'cellHid',cssClass:'cellHid'}
		   	]
			,rows:[]
		};
	
	$(document).ready(function(){
		var user_cd       = "<%=user_cd%>";
		var isMoreThanTwo = "<%=isMoreThanTwo%>";
		var select_dcc    = "<%=select_dcc%>";
		
		// 기본C-M 기반 최초C-M설정 기본C-M 없을경우 계정계 셋팅
		if(select_dcc == ''){
			$("#app_grp_data_center option:eq(1)").prop("selected", true);
			$("#f_s").find("input[name='p_app_grp_data_center']").val($("select[name=app_grp_data_center]").val());
		} else {
			$("select[name='app_grp_data_center']").val(select_dcc);
			$("#f_s").find("input[name='p_app_grp_data_center']").val(select_dcc);
		}
		
		// 사용자 기본C-M 설정 기본C-M 없을경우 계정계 셋팅
		if(select_dcc == ''){
			$("#user_app_grp_data_center option:eq(1)").prop("selected", true);
			$("#f_s2").find("input[name='p_app_grp_data_center']").val($("select[name=user_app_grp_data_center]").val());
			
		} else {
			$("select[name='app_grp_data_center']").val(select_dcc);
			$("#f_s2").find("input[name='p_app_grp_data_center']").val(select_dcc);
		}

		if(isMoreThanTwo == "Y"){
			viewGridChk_1(appGrpCodeGrid_in,'ly_'+appGrpCodeGrid_in.id);
			getCodeList();
		}else{
			viewGridChk_1(appGrpCodeGrid_in,'ly_'+appGrpCodeGrid_in.id);
			viewGridChk_1(appGrpCodeGrid_out,'ly_'+appGrpCodeGrid_out.id);
			getCodeList();
			getUserCodeList(user_cd);
		}
		
		$("#btn_code_insert").button().unbind("click").click(function(){
			if(confirm("선택한 Folder의 권한을 등록하시겠습니까?")){
				var frm = document.f_s;
				var data_center = $("#app_grp_data_center").val();
				var aSelRow = $('#appGrpCodeGrid_in').data('grid').getSelectedRows();  
				
				if(aSelRow.length == 0){
					alert("한개 이상의 권한을 선택해주세요.");
					return;
				}
				
				var folder_auth 	= "";
				for(var i=0; i<aSelRow.length; i++ ){
					if(folder_auth==""){
						folder_auth = getCellValue(appGrpCodeGrid_in,aSelRow[i],'GRP_ENG_NM');
					}else{
						folder_auth += (","+getCellValue(appGrpCodeGrid_in,aSelRow[i],'GRP_ENG_NM'));
					}
				}
				try {viewProgBar(true);} catch (e) {}
				
				frm.flag.value = "all_folder_auth";
				frm.user_cd.value = user_cd;
				frm.folder_auth.value = folder_auth;
				frm.data_center.value = data_center;
				frm.p_isMoreThanTwo.value = isMoreThanTwo;
				frm.target = prcFrameId;
				frm.action = "<%=sContextPath%>/tWorks.ez?c=ez002_p";
				frm.submit();
			}
		});
		
		
		$("#btn_code_delete").button().unbind("click").click(function(){
			if(confirm("선택한 Folder의 권한을 삭제하시겠습니까?")){
				var frm = document.f_s2;
				var data_center = $("#f_s2").find("#p_app_grp_data_center").val();
				var aSelRow = $('#appGrpCodeGrid_out').data('grid').getSelectedRows();  
				
				if(aSelRow.length == 0){
					alert("한개 이상의 권한을 선택해주세요.");
					return;
				}
				
				var folder_auth 	= "";
				for(var i=0; i<aSelRow.length; i++ ){
					if(folder_auth==""){
						folder_auth = getCellValue(appGrpCodeGrid_out,aSelRow[i],'GRP_ENG_NM');
					}else{
						folder_auth += (","+getCellValue(appGrpCodeGrid_out,aSelRow[i],'GRP_ENG_NM'));
					}
				}
				try {viewProgBar(true);} catch (e) {}
				
				frm.flag.value = "user_folder_auth_delete";
				frm.user_cd.value = user_cd;
				frm.folder_auth.value = folder_auth;
				frm.data_center.value = data_center;
				frm.p_isMoreThanTwo.value = isMoreThanTwo;
				frm.target = prcFrameId;
				frm.action = "<%=sContextPath%>/tWorks.ez?c=ez002_p";
				frm.submit();
			}
		});
		
		$('#search_folder').unbind('keypress').keypress(function(e){			
			if(e.keyCode==13){
				fn_search_list();
			}
		});
		
		$('#user_search_folder').unbind('keypress').keypress(function(e){			
			if(e.keyCode==13){
				fn_search_userFolderList();
			}
		});
		
		$("#app_grp_data_center").change(function(){
			$("input[name='search_folder']").val("");
			fn_search_list();
		});
		$("#user_app_grp_data_center").change(function(){
			$("input[name='user_search_folder']").val("");
			fn_search_userFolderList();
		});
		
	});
	
	function getCodeList(){
		
		try{viewProgBar(true);}catch(e){}
		var search_folder = $("#search_folder").val();
		
		var isMoreThanTwo = "<%=isMoreThanTwo%>";
		
		var url = '';
		if(isMoreThanTwo == "Y"){
			url = '<%=sContextPath %>/common.ez?c=cData&itemGb=sched_tableList3&itemGubun=2';	
		}else{
			url = '<%=sContextPath %>/common.ez?c=cData&itemGb=sched_tableList2&itemGubun=2';				
		}
		
		var rows = [];
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
<%-- 						// goCommonError('<%=sContextPath %>','_self',$(xmlDoc).find('msg_code').text()); --%>
						return false;
					}
					$(xmlDoc)
						.find('doc')
						.each(function() {
									var items = $(this).find('items');
									var rowsObj = new Array();

									if (items.attr('cnt') == '0') {
									} else {
										items.find('item').each(
											function(i) {
												var scode_nm = $(this).find("SCODE_NM").text();
												var grp_eng_nm = $(this).find("GRP_ENG_NM").text();
												var folder_auth = $(this).find("FOLDER_AUTH").text();
												var data_center = $(this).find("DATA_CENTER").text();
												rowsObj.push({
															'grid_idx' : i + 1,
															'SCODE_NM' : scode_nm,
															'GRP_ENG_NM' : grp_eng_nm,
															'DATA_CENTER' : data_center
														});
											});
										
										};
									appGrpCodeGrid_in.rows = rowsObj;
									
									setGridRows(appGrpCodeGrid_in);
									var grid = $('#appGrpCodeGrid_in').data('grid');
									grid.setSelectedRows(rows);
									$('#ly_total_cnt_1').html(
										'[ TOTAL : '
												+ items.attr('cnt')
												+ ' ]');
									});
				try {viewProgBar(false);} catch (e) {}
			}, null);

		xhr.sendRequest();
	}
	
	function getUserCodeList(){
		
		try{viewProgBar(true);}catch(e){}
		var search_folder = $("#search_folder").val();
		
		var url = '';
		url = '<%=sContextPath %>/common.ez?c=cData&itemGb=sched_user_tableList&itemGubun=2';				
		
		var rows = [];
		var xhr = new XHRHandler(url, f_s2
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
				$(xmlDoc)
						.find('doc')
						.each(function() {
									var items = $(this).find('items');
									var rowsObj = new Array();

									if (items.attr('cnt') == '0') {
									} else {
										items.find('item').each(
											function(i) {
												var scode_nm = $(this).find("SCODE_NM").text();
												var grp_eng_nm = $(this).find("GRP_ENG_NM").text();
												var folder_auth = $(this).find("FOLDER_AUTH").text();
												var data_center = $(this).find("DATA_CENTER").text();
												rowsObj.push({
															'grid_idx' : i + 1,
															'SCODE_NM' : scode_nm,
															'GRP_ENG_NM' : grp_eng_nm,
															'DATA_CENTER' : data_center
														});
											});
										
										};
									appGrpCodeGrid_out.rows = rowsObj;
									
									setGridRows(appGrpCodeGrid_out);
									var grid = $('#appGrpCodeGrid_out').data('grid');
									grid.setSelectedRows(rows);
									$('#ly_total_cnt_1').html(
										'[ TOTAL : '
												+ items.attr('cnt')
												+ ' ]');
									});
				try {viewProgBar(false);} catch (e) {}
			}, null);

		xhr.sendRequest();
	}
	
	function fn_search_list() {
		var data_center 	= $("select[name='app_grp_data_center'] option:selected").val();
		var scode_cd 		= $("select[name='app_grp_data_center'] option:selected").val();
		var search_folder	= $("input[name='search_folder']").val();
		if (data_center == "") {
			alert("C-M 을 선택해 주세요.");
			return;
		}
		
		$("#f_s").find("input[name='p_app_grp_data_center']").val(data_center);
		$("#f_s").find("input[name='p_scode_cd']").val(scode_cd);
		$("#f_s").find("input[name='p_search_folder']").val(search_folder);
		getCodeList();
		
	}
	
	function fn_search_userFolderList() {
		var data_center 	= $("select[name='user_app_grp_data_center'] option:selected").val();
		var search_folder	= $("input[name='user_search_folder']").val();
		if (data_center == "") {
			alert("C-M 을 선택해 주세요.");
			return;
		}
		
		$("#f_s2").find("input[name='p_app_grp_data_center']").val(data_center);
		$("#f_s2").find("input[name='p_search_folder']").val(search_folder);
		
		getUserCodeList();
		
	}
	
</script>

