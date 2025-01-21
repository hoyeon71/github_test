<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/jsp/common/inc/header.jsp"%>

<%
	Map<String, Object> paramMap = CommonUtil.collectParameters(request);
	String c = CommonUtil.isNull(paramMap.get("c"));
	String gridId = "g_"+c;
	String gridId_1 = "g_"+c+"_1";
	
	String menu_gb = CommonUtil.getMessage("CATEGORY.GB.06.GB."+CommonUtil.isNull(paramMap.get("menu_gb")));
	String[] arr_menu_gb = menu_gb.split(",");
	String strSessionDcCode 	= S_D_C_CODE;
	
%>

<form id="f_s" name="f_s" method="post" onsubmit="return false;">
	<input type="hidden" name="data_center" 	id="data_center"/>	
	<input type="hidden" name="p_search_gubun" 	id="p_search_gubun"/>
	<input type="hidden" name="p_search_text" 	id="p_search_text"/>
</form>

<form id="frm2" name="frm2" method="post" onsubmit="return false;">
	<input type="hidden" name="flag" 			id="flag"/>
	<input type="hidden" name="database_cd" 	id="database_cd"/>
</form>

<form id="frm3" name="frm3" method="post" onsubmit="return false;">
	<input type="hidden" name="user_nm" 		id="user_nm"/>
	<input type="hidden" name="database_type" 	id="database_type"/>
	<input type="hidden" name="database_pw" 	id="database_pw"/>
	<input type="hidden" name="database_name" 	id="database_name"/>
	<input type="hidden" name="access_sid" 		id="access_sid"/>
	<input type="hidden" name="access_service_name" 		id="access_service_name"/>
	<input type="hidden" name="access_port" 	id="access_port"/>
	<input type="hidden" name="host_nm" 		id="host_nm"/>
</form>



<table style='width:100%;height:100%;border:none;'>
	<tr style='height:10px;'>
		<td style='vertical-align:top;'>
			<h4 class="ui-widget-header ui-corner-all"  >
				<div id='t_<%=gridId %>' class='title_area' >
					<span><%=CommonUtil.isNull(CommonUtil.getMessage("CATEGORY.GB.06"))%> > <%=CommonUtil.isNull(arr_menu_gb[0]) %></span>
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
					<td width="35%" style="text-align:left">
						<div class='cellContent_kang'>
						<select id="data_center_items" name="data_center_items" style="width:120px; height:21px;">
							<option value="">--선택--</option>
							<c:forEach var="cm" items="${cm}" varStatus="status">
								<option value="${cm.scode_cd},${cm.scode_eng_nm}">${cm.scode_nm}</option>
							</c:forEach>
						</select>
						</div>
					</td>
					
					<th width="10%"><div class='cellTitle_kang2'>조건</div></th>
					<td width="35%" style="text-align:left">
						<div class='cellContent_kang'>
						<select name="search_gubun" id="search_gubun" style="width:120px%; height:21px;">
							<option value="profile">Profile</option>
						</select>&nbsp;
						<input type="text" name="search_text" value="" id="search_text" style="width:150px; height:21px;" />
						</div>					
					</td>
					<td style="text-align:right">
						<span id="btn_search" style='display:none;margin:3px;'>검 색</span>
					</td>
				</tr>
			</table>
			</h4>
			</form>
		</td>
	</tr>
	<tr style="height:100%">
		<td id='ly_<%=gridId %>' style='vertical-align:top;'>
			<div id="<%=gridId %>" class="ui-widget-header ui-corner-all"></div>
		</td>
	</tr>
	<tr style='height:10px;'>
		<td style='vertical-align:top;'>
			<h4 class="ui-widget-header ui-corner-all">
				<div align='right' class='btn_area'>
					<div id='ly_total_cnt' style='padding-top:5px;float:left;'></div>
					<span id="btn_DatabaseTakeOver">DB이관</span>
					<span id="btn_update">수정</span>
					<span id="btn_delete">삭제</span>
				</div>
			</h4>
		</td>
	</tr>
</table>

<div id="dl_p01" style='overflow:hidden;display:none;padding:0;'>
	<iframe id='if_p01' name='if_p01' src='about:blank' width='0px' height='0px' scrolling='no'  frameborder="0"  ></iframe>
</div>

<script>
		
	function gridCellCustomFormatter(row,cell,value,columnDef,dataContext){
		
		var ret = "";
		var user_nm 		= getCellValue(gridObj,row,'USER_NM');
		var database_type 	= getCellValue(gridObj,row,'DATABASE_TYPE');
		var database_pw 	= getCellValue(gridObj,row,'DATABASE_PW');
		var database_name 	= getCellValue(gridObj,row,'DATABASE_NAME');
		var access_sid		= getCellValue(gridObj,row,'ACCESS_SID');
		var access_service_name		= getCellValue(gridObj,row,'ACCESS_SERVICE_NAME');
		var access_port		= getCellValue(gridObj,row,'ACCESS_PORT');
		var host_nm			= getCellValue(gridObj,row,'HOST_NM');
		
		if(columnDef.id == 'CONNECT'){
			ret = "<a href=\"JavaScript:fn_access('"+user_nm+"','"+database_type+"','"+database_pw+"','"+database_name+"','"+access_sid+"','"+access_service_name+"','"+access_port+"','"+host_nm+"');\" /><font color='red'>"+value+"</font></a>";
		}
		
		return ret;
	}
	
	var gridObj = {
		id : "<%=gridId %>"
		,colModel:[
	   		{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'번호',width:50,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}	   		
	   		,{formatter:gridCellNoneFormatter,field:'DATA_CENTER_NAME',id:'DATA_CENTER_NAME',name:'C-M',width:100,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'PROFILE_NAME',id:'PROFILE_NAME',name:'PROFILE_NAME',width:150,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}	 
	   		,{formatter:gridCellNoneFormatter,field:'DATABASE_TYPE',id:'DATABASE_TYPE',name:'DATABASE_TYPE',width:150,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}	   		
	   		,{formatter:gridCellNoneFormatter,field:'DATABASE_VERSION',id:'DATABASE_VERSION',name:'DATABASE_VERSION',width:150,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}	   		
	   		,{formatter:gridCellNoneFormatter,field:'TYPE',id:'TYPE',name:'TYPE',width:280,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'HOST_NM',id:'HOST_NM',name:'HOST',width:100,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'ACCESS_PORT',id:'ACCESS_PORT',name:'PORT',width:100,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'DATABASE_NAME',id:'DATABASE_NAME',name:'DATABASE_NAME',width:150,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'ACCESS_SID',id:'ACCESS_SID',name:'SID',width:100,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'ACCESS_SERVICE_NAME',id:'ACCESS_SERVICE_NAME',name:'SERVICE_NAME',width:100,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	   		,{formatter:gridCellCustomFormatter,field:'CONNECT',id:'CONNECT',name:'접속',width:100,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	   		
	   		,{formatter:gridCellNoneFormatter,field:'USER_NM',id:'USER_NM',name:'USER_NM',width:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   		,{formatter:gridCellNoneFormatter,field:'DATABASE_PW',id:'DATABASE_PW',name:'DATABASE_PW',width:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   		,{formatter:gridCellNoneFormatter,field:'DATABASE_CD',id:'DATABASE_CD',name:'DATABASE_CD',width:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   	]
		,rows:[]
		,vscroll:<%=S_GRID_VSCROLL%>
	};
	
	var profile_name_list = [];
	
	$(document).ready(function(){
		var session_dc_code	= "<%=strSessionDcCode%>";
		
		$("#btn_search").show();
		
		if(session_dc_code != "") { // 개인정보에 C-M이 등록되어 있을경우
			$("select[name='data_center_items']").val(session_dc_code);
			$("#f_s").find("input[name='data_center']").val(session_dc_code);
		}else { // 개인정보에 C-M이 등록이 되어있지 않을경우 -> C-M 콤보박스에서 첫번째값 선택
			$("#data_center_items option:eq(1)").prop("selected", true);
			$("#f_s").find("input[name='data_center']").val($("select[name='data_center_items']").val());
		}
		

		viewGrid_1(gridObj,"ly_"+gridObj.id);
		databaseList();
		

		$("#data_center_items").change(function(){
			var data_center_items = $("select[name='data_center_items'] option:selected").val();
			var arr_dt = data_center_items.split(",");

			$("#f_s").find("input[name='data_center']").val(data_center_items);
			$("#f_s").find("input[name='p_search_gubun']").val($("#frm1").find("select[name='search_gubun'] option:selected").val());
			$("#f_s").find("input[name='p_search_text']").val($("#frm1").find("input[name='search_text']").val());

			databaseList();
		});

		$("#btn_search").button().unbind("click").click(function(){
			
			var data_center_items = $("select[name='data_center_items'] option:selected").val();
			var arr_dt = data_center_items.split(",");
			
			//$("#f_s").find("input[name='data_center']").val(arr_dt[1]);
			$("#f_s").find("input[name='data_center']").val(data_center_items);
			$("#f_s").find("input[name='p_search_gubun']").val($("#frm1").find("select[name='search_gubun'] option:selected").val());
			$("#f_s").find("input[name='p_search_text']").val($("#frm1").find("input[name='search_text']").val());

			databaseList();
		});
		
		$('#search_text').unbind('keypress').keypress(function(e){			
			if(e.keyCode==13){	
				
				var data_center_items = $("select[name='data_center_items'] option:selected").val();
				var arr_dt = data_center_items.split(",");
				
				//$("#f_s").find("input[name='data_center']").val(arr_dt[1]);
				$("#f_s").find("input[name='data_center']").val(data_center_items);
				$("#f_s").find("input[name='p_search_gubun']").val($("#frm1").find("select[name='search_gubun'] option:selected").val());
				$("#f_s").find("input[name='p_search_text']").val($("#frm1").find("input[name='search_text']").val());
				
				databaseList();
			}
		});
		
			
		$("#btn_delete").button().unbind("click").click(function(){
			dbDelete();
		});
		
		$("#btn_update").button().unbind("click").click(function(){
			
			var cnt = 0;
			var database_cd = "";
			var aSelRow = new Array;
			aSelRow = $('#'+gridObj.id).data('grid').getSelectedRows();
			if(aSelRow.length>0){
				for(var i=0;i<aSelRow.length;i++){
					database_cd = getCellValue(gridObj,aSelRow[i],'DATABASE_CD');
					
					++cnt;
				}
				
				if(cnt > 1){
					alert("한개의 호스트만 선택해 주세요.");
					return;
				}else{
					dbUpdate(database_cd);
				}
				
			}else{
				alert("수정하려는 호스트를 선택해 주세요.");
				return;
			}
		});
		
		// DB 이관
		$("#btn_DatabaseTakeOver").button().unbind("click").click(function(){
			popTakeOverForm("DB", "Database");
		});
		
		
	});
		
	function databaseList(){
		
		$("#f_s").find("input[name='p_search_gubun']").val($("#frm1").find("select[name='search_gubun'] option:selected").val());
		$("#f_s").find("input[name='p_search_text']").val($("#frm1").find("input[name='search_text']").val());
				
		try{viewProgBar(true);}catch(e){}
		$('#ly_total_cnt').html('');
		
		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=databaseList';
		
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
						
						profile_name_list.splice(0, profile_name_list.length);
						
						if(items.attr('cnt')=='0'){
						}else{
							items.find('item').each(function(i){						
							
								var database_cd			= $(this).find("DATABASE_CD").text();
								var data_center_name 	= $(this).find("DATA_CENTER_NAME").text();
								var profile_name 		= $(this).find("PROFILE_NAME").text();
								var database_version 	= $(this).find("DATABASE_VERSION").text();
								var type 				= $(this).find("TYPE").text();
								var host_nm 			= $(this).find("HOST_NM").text();
								var database_type_ment	= type.split(":")[2];
								var database_name 		= $(this).find("DATABASE_NAME").text();
								var access_port 		= $(this).find("ACCESS_PORT").text();
								var access_sid 			= $(this).find("ACCESS_SID").text();
								var access_service_name = $(this).find("ACCESS_SERVICE_NAME").text();
								var user_nm				= $(this).find("USER_NM").text();
								var database_pw			= $(this).find("DATABASE_PW").text();
								var connect 			= "<div>[접속]</div>";
								
								profile_name_list.push(profile_name);
								
								rowsObj.push({
									'grid_idx':i+1
									,'DATABASE_CD': database_cd
									,'DATA_CENTER_NAME': data_center_name
									,'PROFILE_NAME': profile_name
									,'DATABASE_TYPE': database_type_ment
									,'DATABASE_VERSION': database_version
									,'TYPE': type
									,'HOST_NM': host_nm
									,'DATABASE_NAME': database_name
									,'ACCESS_PORT': access_port
									,'ACCESS_SID': access_sid
									,'ACCESS_SERVICE_NAME': access_service_name
									,'USER_NM': user_nm
									,'DATABASE_PW': database_pw
									,'CONNECT': connect
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
	
	
	function dbUpdate(database_cd){	
		
		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=databaseList&database_cd='+database_cd;
		
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
						
						var database_cd			= "";
						var data_center			= "";
						var profile_name 		= "";
						var database_version 	= "";
						var type 				= "";
						var database_type_ment	= "";
						var database_name 		= "";
						var access_port 		= "";
						var access_sid 			= "";
						var access_service_name	= "";
						var user_nm 			= "";
						
						if(items.attr('cnt')=='0'){
						}else{
							items.find('item').each(function(i){						
							
								database_cd			= $(this).find("DATABASE_CD").text();
								data_center			= $(this).find("DATA_CENTER").text();
								profile_name 		= $(this).find("PROFILE_NAME").text();
								database_version 	= $(this).find("DATABASE_VERSION").text();
								type 				= $(this).find("TYPE").text();
								database_type_ment	= type.split(":")[2];
								database_name 		= $(this).find("DATABASE_NAME").text();
								database_pw 		= $(this).find("DATABASE_PW").text();
								host_nm		 		= $(this).find("HOST_NM").text();
								access_port 		= $(this).find("ACCESS_PORT").text();
								access_sid 			= $(this).find("ACCESS_SID").text();
								access_service_name	= $(this).find("ACCESS_SERVICE_NAME").text();
								user_nm 			= $(this).find("USER_NM").text();
							});						
						}
						
						
						var sHtml="<div id='dl_tmp2' style='overflow:hidden;display:none;padding:0;border-top:1px solid blue;border-bottom:1px solid blue;border-left:1px solid blue;border-right:1px solid blue;'>";
						sHtml+="<form id='form2' name='form2' method='post' onsubmit='return false;'>";
						sHtml+="<input type='hidden' name='flag' id='flag'/>";
						sHtml+="<input type='hidden' name='data_center' id='data_center'/>";	
						sHtml+="<input type='hidden' name='database_cd' id='database_cd'/>";	
						sHtml+="<input type='hidden' name='database_pw' id='database_pw' />";	
						sHtml+="<table style='width:100%;height:405px;border:none;'>";
						sHtml+="<tr><td style='vertical-align:top;height:100%;width:490px;' >";
						
						sHtml+="<table style='width:100%;height:95%;border:none;'>";
						sHtml+="<tr><td id='ly_g_tmp2' style='vertical-align:top;'>";
						sHtml+="<div id='g_tmp2' class='ui-widget-header ui-corner-all'></div>";
						sHtml+="</td></tr>";
						sHtml+="<tr style='height:10px;'><td style='vertical-align:top;'><h5 class='ui-widget-header ui-corner-all' >";
						sHtml+="<div align='right' class='btn_area_s'>";
						sHtml+="<span id='btn_udt'>저장</span>";
						sHtml+="</div>";
						sHtml+="</h5></td></tr></table>";
						
						sHtml+="</td></tr></table>";
						
						sHtml+="</form>";
						
						$('#dl_tmp2').remove();
						$('body').append(sHtml);
										
						var headerObj = new Array();
						var hTmp1 = "";
						var hTmp2 = "";
						hTmp1 += "<div class='cellTitle_1'>C-M</div>";
						hTmp2 += "<div class='cellContent_1'>";
						hTmp2 += "<select name='data_center_items' id='data_center_items' disabled>";
						<c:forEach var="cm" items="${cm}" varStatus="status">
							hTmp2 +="<option value='${cm.scode_cd},${cm.scode_eng_nm}'>${cm.scode_nm}</option>";
						</c:forEach>
						hTmp2 += "</select>";
						hTmp2 += "</div>";
						hTmp1 += "<div class='cellTitle_1'>PROFILE_NAME</div>";
						hTmp2 += "<div class='cellContent_1'><input type='text' name='profile_name' id='profile_name' style='width:98%;border:0px none;background-color:#EBEBE4;' readOnly /></div>";
						
						hTmp1 += "<div class='cellTitle_1'>DATABASE_TYPE</div>";
						hTmp2 += "<div class='cellContent_1'><input type='text' name='database_type' id='database_type' style='width:98%;border:0px none;background-color:#EBEBE4;' readOnly /></div>";
						
						hTmp1 += "<div class='cellTitle_1'>VERSION</div>";
						hTmp2 += "<div class='cellContent_1'><input type='text' name='database_version' id='database_version' style='width:98%;border:0px none;background-color:#EBEBE4;' readOnly /></div>";
						
						hTmp1 += "<div class='cellTitle_1'>HOST</div>";
						hTmp2 += "<div class='cellContent_1'><input type='text' name='host' id='host' style='width:98%;border:0px none;background-color:#EBEBE4;' readOnly /></div>";
						
						hTmp1 += "<div class='cellTitle_1'>PORT</div>";
						hTmp2 += "<div class='cellContent_1'><input type='text' name='port' id='port' style='width:98%;border:0px none;background-color:#EBEBE4;' readOnly /></div>";
						
						if(database_type_ment == "PostgreSQL") {
							hTmp1 += "<div class='cellTitle_1'>DATABASE_NAME</div>";
							hTmp2 += "<div class='cellContent_1'><input type='text' name='database_name' id='database_name' style='width:98%;border:0px none;background-color:#EBEBE4;' readOnly /></div>";
						}else if(database_type_ment == "Oracle") {
							hTmp1 += "<div class='cellTitle_1'>SID</div>";
							hTmp2 += "<div class='cellContent_1'><input type='text' name='sid' id='sid' style='width:98%;border:0px none;background-color:#EBEBE4;' readOnly /></div>";
							hTmp1 += "<div class='cellTitle_1'>SERVICE_NAME</div>";
							hTmp2 += "<div class='cellContent_1'><input type='text' name='service_name' id='service_name' style='width:98%;border:0px none;background-color:#EBEBE4;' readOnly /></div>";
						}
						
						hTmp1 += "<div class='cellTitle_1'>USER</div>";
						hTmp2 += "<div class='cellContent_1'><input type='text' name='user_nm' id='user_nm' style='width:98%;border:0px none;background-color:#EBEBE4;' readOnly /></div>";
						
						hTmp1 += "<div class='cellTitle_1'>PASSWORD</div>";
						hTmp2 += "<div class='cellContent_1'><input type='password' name='v_database_pw' id='v_database_pw' style='width:98%;border:0px none;'/></div>";
						
						hTmp1 += "<div class='cellTitle_1'>TYPE</div>";
						hTmp2 += "<div class='cellContent_1'><input type='text' name='type' id='type' style='width:98%;border:0px none;background-color:#EBEBE4;' readOnly /></div>";
						
								
						headerObj.push({name:hTmp1,id_s:'c_1',id_e:'c_1'});
						headerObj.push({name:hTmp2,id_s:'c_2',id_e:'c_2'});
						var gridObj_s = {
							id : "g_tmp2"
							,colModel:[
						  		{formatter:gridCellNoneFormatter,field:'c_1',id:'c_1',name:'구 분',width:110,headerCssClass:'cellCenter',cssClass:'cellCenter'}
								,{formatter:gridCellNoneFormatter,field:'c_2',id:'c_2',name:'내 용',width:300,headerCssClass:'cellCenter',cssClass:'cellLeft'}
							   	
						   		,{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'grid_idx',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
						   	]
							,rows:[]
							,headerRowHeight:700
							,colspan:headerObj
							,vscroll:false
						};
						
						viewGrid_1(gridObj_s,'ly_'+gridObj_s.id);
						$("#form2").find("select[name='data_center_items']").val(data_center);
						$("#form2").find("input[name='data_center']").val(data_center);
						
						var f = document.form2;
						f.database_cd.value = database_cd;
						f.profile_name.value = profile_name;
						f.database_type.value = database_type_ment;
						f.database_version.value = database_version;
						f.database_pw.value = database_pw;
						f.host.value = host_nm;
						
						if(database_type_ment == "PostgreSQL") {
							f.database_name.value = database_name;
						}else if(database_type_ment == "Oracle") {
							f.sid.value = access_sid;
							f.service_name.value = access_service_name;
						}
						
						f.port.value = access_port;
						f.user_nm.value = user_nm;
						f.type.value = type;
						
						
						dlPop01('dl_tmp2',"DB정보수정",415,395,false);
						
						
						$("#btn_udt").button().unbind("click").click(function(){
							
							if($("#form2").find("select[name='data_center']").val() == ""){
								alert('<%=CommonUtil.getMessageSplit("ERROR.PARAM.02","[CTM]","") %>'); 
								return false;
							}
							
							if($("#form2").find("input[name='database_type']").val() == "PostgreSQL"){
								if(isNullInput($('#form2 #database_name'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[DATABASE_NAME]","") %>')) return false;
							}else if($("#form2").find("input[name='database_type']").val() == "Oracle"){
								
							}
							
							if(isNullInput($('#form2 #port'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[PORT]","") %>')) return false;
							
							if(isNullInput($('#form2 #user_nm'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[USER]","") %>')) return false;
							
										
							if(confirm("해당 내용을 변경 하시겠습니까?")){
								var f = document.form2;
								
								try{viewProgBar(true);}catch(e){}
								
								f.flag.value = "udt";
								f.target = "if1";
								f.action = "<%=sContextPath %>/tWorks.ez?c=ez045_p"; 
								f.submit();
								
								try{viewProgBar(false);}catch(e){}
								
								dlClose('dl_tmp2');
							}
						});												
					});
					try{viewProgBar(false);}catch(e){}
				}
		, null );
		
		xhr.sendRequest();	
	}

	
	function dbDelete(){
		
		var cnt = 0;
		var database_cd = "";
		
		var aSelRow = new Array;
		aSelRow = $('#'+gridObj.id).data('grid').getSelectedRows();
		if(aSelRow.length>0){
			for(var i=0;i<aSelRow.length;i++){
					
				if(i > 0) host_cd += ",";
				database_cd += getCellValue(gridObj,aSelRow[i],'DATABASE_CD');
				
				++cnt;
			}
		}else{
			alert("삭제할 항목을 선택해 주세요.");
			return;
		}
		
		if(cnt > 1){
			alert("한개의 항목만 선택해 주세요.");
			return;
		}
		
		if(confirm("관련된 하위 데이터도 모두 삭제됩니다. 진행하시겠습니까?")){
			var f = document.frm2;		
			
			f.flag.value = "del";
			f.database_cd.value = database_cd;
			f.target = "if1";
			f.action = "<%=sContextPath %>/tWorks.ez?c=ez045_p"; 
			f.submit();			
		}
	}
	
	// DB 이관
	function popTakeOverForm(title, gb, host_cd){
		
		var sHtml1="<div id='popDbProfileInfo' style='overflow:hidden;display:none;padding:0;border-top:1px solid blue;border-bottom:1px solid blue;border-left:1px solid blue;border-right:1px solid blue;'>";
		sHtml1+="<form id='dbProfileForm' name='dbProfileForm' method='post' onsubmit='return false;'>";
		
		var host_cd = $("#takeOver_host_cd").val();
		
      	sHtml1 += "<input type='hidden' name='flag' value='database_takeOver' />";
      	sHtml1 += "<input type='hidden' name='profile_name_arr' 	id='profile_name_arr'/>";
      	sHtml1 += "<input type='hidden' name='database_type_arr'	id='database_type_arr'/>";
      	sHtml1 += "<input type='hidden' name='database_version_arr' id='database_version_arr'/>";
      	sHtml1 += "<input type='hidden' name='type_arr' 			id='type_arr'/>";
      	sHtml1 += "<input type='hidden' name='user_arr' 			id='user_arr'/>";
      	sHtml1 += "<input type='hidden' name='port_arr' 			id='port_arr'/>";
      	sHtml1 += "<input type='hidden' name='sid_arr' 				id='sid_arr'/>";
      	sHtml1 += "<input type='hidden' name='service_name_arr' 	id='service_name_arr'/>";
      	sHtml1 += "<input type='hidden' name='database_name_arr' 	id='database_name_arr'/>";
      	sHtml1 += "<input type='hidden' name='host_arr' 			id='host_arr'/>";
      	sHtml1 += "<input type='hidden' name='target_ctm_arr' 		id='target_ctm_arr'/>";
      	sHtml1 += "<input type='hidden' name='target_agent_arr' 	id='target_agent_arr'/>";
        	
		
		sHtml1+="<table style='width:100%;height:100%;border:none;'>"; //table 시작
		
		sHtml1+="<tr style='height:15px;'>"; // tr         
		sHtml1+="<td style='height:100%;width:100%;text-align:right;'>"; 
		
		sHtml1+="<div>";
		sHtml1+="<b>host : </b><select name='db_host_list' id='db_host_list' style='height:23px;'>"; 
		sHtml1+="<option value=''>--선택--</option>";
		<c:forEach var="db_host" items="${db_host}" varStatus="status">
			sHtml1+="<option value='${db_host.nodeid}'>${db_host.nodeid}</option>"
		</c:forEach>;
		sHtml1+="</select>";
		sHtml1+="&nbsp;&nbsp;<span id='btn_code_search' style='height:21px'>검색</span>";
		sHtml1+="</div>";
		sHtml1+="</td>";
		sHtml1+="</tr>"; // /tr
		
		sHtml1+="<tr style='height:300px;'>";
		sHtml1+="<td id='ly_dbProfileGrid' style='vertical-align:top;' colspan=2>";
		sHtml1+="<div id='dbProfileGrid' class='ui-widget-header ui-corner-all'></div>";
		sHtml1+="</td>";
		sHtml1+="</tr>"; // /tr
		sHtml1+="<tr style='height:5px;'>"; // tr
		sHtml1+="<td style='vertical-align:top;'>"; // td
		sHtml1+="<div align='right' style='padding:3px;'><span id='btn_code_insert'>"+title+"이관</span><span id='btn_code_close'>닫기</span></div>";
		sHtml1+="</td>"; // /tb
		sHtml1+="</tr>"; //tr 3 끝
		sHtml1+="</table>"; //table 끝
		
		sHtml1+="</form>";
		sHtml1+="</div>";
		
		$('#popDbProfileInfo').remove();
		$('body').append(sHtml1);
		
		if(gb == 'Database'){
			dlPop02('popDbProfileInfo',title+"검색",1000,380,true);  
		}
		
		var gridObj = {
			id : "dbProfileGrid"
			,rows:[]
			,vscroll:false
		};
		
		var codeColModel = [
			{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'번호',width:50,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
			,{formatter:gridCellNoneFormatter,field:'PROFILE_NAME',id:'PROFILE_NAME',name:'profile_name',width:150,headerCssClass:'cellCenter',cssClass:'cellCenter'}
			,{formatter:gridCellNoneFormatter,field:'DATABASE_TYPE',id:'DATABASE_TYPE',name:'database_type',width:150,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
			,{formatter:gridCellNoneFormatter,field:'DATABASE_VERSION',id:'DATABASE_VERSION',name:'database_version',width:150,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
			,{formatter:gridCellNoneFormatter,field:'TYPE',id:'TYPE',name:'type',width:280,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	
			,{formatter:gridCellNoneFormatter,field:'USER',id:'USER',name:'user',width:0,headerCssClass:'cellHid',cssClass:'cellHid',sortable:true}
			,{formatter:gridCellNoneFormatter,field:'PORT',id:'PORT',name:'port',width:0,headerCssClass:'cellHid',cssClass:'cellHid',sortable:true}
			,{formatter:gridCellNoneFormatter,field:'SID',id:'SID',name:'sid',width:0,headerCssClass:'cellHid',cssClass:'cellHid',sortable:true}
			,{formatter:gridCellNoneFormatter,field:'SERVICE_NAME',id:'SERVICE_NAME',name:'service_name',width:0,headerCssClass:'cellHid',cssClass:'cellHid',sortable:true}
			,{formatter:gridCellNoneFormatter,field:'DATABASE_NAME',id:'DATABASE_NAME',name:'database_name',width:0,headerCssClass:'cellHid',cssClass:'cellHid',sortable:true}
			,{formatter:gridCellNoneFormatter,field:'HOST',id:'HOST',name:'host',width:0,headerCssClass:'cellHid',cssClass:'cellHid',sortable:true}
			,{formatter:gridCellNoneFormatter,field:'TARGET_CTM',id:'TARGET_CTM',name:'target_ctm',width:0,headerCssClass:'cellHid',cssClass:'cellHid',sortable:true}
			,{formatter:gridCellNoneFormatter,field:'TARGET_AGENT',id:'TARGET_AGENT',name:'target_agent',width:0,headerCssClass:'cellHid',cssClass:'cellHid',sortable:true}
		];
		
		gridObj.colModel = codeColModel;
		
		
		viewGridChk_1(gridObj,"ly_"+gridObj.id);
		$("#"+gridObj.id).data('grid').setSelectionModel(new Slick.RowSelectionModel({selectActiveRow: false})); //grid 자체 selection 기능 사용 안함.
		
		$("#btn_search").show();
		
		$("#btn_code_search").button().unbind("click").click(function(){
			var select_db_host = $("select[name='db_host_list'] option:selected").val();
			if(select_db_host == "") {
				alert("호스트를 선택해주세요.");
				return;
			}
			getConPro(select_db_host);
		});
		
		
		
		$("#btn_code_insert").button().unbind("click").click(function(){
			var profile_name_list 		= "";
			var database_type_list 		= "";
			var database_version_list 	= "";
			var type_list 				= "";
			var user_list 				= "";
			var port_list 				= "";
			var sid_list 				= "";
			var service_name_list		= "";
			var database_name_list	 	= "";
			var host_list	 			= "";
			var target_ctm_list 		= "";
			var target_agent_list 		= "";
			
			gridObj	= $('#dbProfileGrid').data('gridObj');
			var aSelRow = $('#dbProfileGrid').data('grid').getSelectedRows();
			if(aSelRow.length == 0) {
				alert("이관할 항목을 선택해주세요.");
				return;
			}
			
			if(aSelRow.length > 0){
				for(var i=0;i<aSelRow.length;i++){
					
					profile_name_list 		+= getCellValue(gridObj,aSelRow[i],'PROFILE_NAME') + ",";
					database_type_list 		+= getCellValue(gridObj,aSelRow[i],'DATABASE_TYPE') + ",";
					database_version_list 	+= getCellValue(gridObj,aSelRow[i],'DATABASE_VERSION') + ",";
					type_list 				+= getCellValue(gridObj,aSelRow[i],'TYPE') + ",";
					user_list 				+= getCellValue(gridObj,aSelRow[i],'USER') + ",";
					port_list 				+= getCellValue(gridObj,aSelRow[i],'PORT') + ",";
					sid_list 				+= getCellValue(gridObj,aSelRow[i],'SID') + ",";
					service_name_list 		+= getCellValue(gridObj,aSelRow[i],'SERVICE_NAME') + ",";
					database_name_list	 	+= getCellValue(gridObj,aSelRow[i],'DATABASE_NAME') + ",";
					host_list 				+= getCellValue(gridObj,aSelRow[i],'HOST') + ",";
					target_ctm_list 		+= getCellValue(gridObj,aSelRow[i],'TARGET_CTM') + "|";
					target_agent_list 		+= getCellValue(gridObj,aSelRow[i],'TARGET_AGENT') + ",";
				}
				
				profile_name_list 		= profile_name_list.substring(0, profile_name_list.length - 1);
				database_type_list 		= database_type_list.substring(0, database_type_list.length - 1);
				database_version_list 	= database_version_list.substring(0, database_version_list.length - 1);
				type_list 				= type_list.substring(0, type_list.length - 1);
				user_list 				= user_list.substring(0, user_list.length - 1);
				port_list 				= port_list.substring(0, port_list.length - 1);
				sid_list 				= sid_list.substring(0, sid_list.length - 1);
				service_name_list 		= service_name_list.substring(0, service_name_list.length - 1);
				database_name_list 		= database_name_list.substring(0, database_name_list.length - 1);
				host_list 				= host_list.substring(0, host_list.length - 1);
				target_ctm_list 		= target_ctm_list.substring(0, target_ctm_list.length - 1);
				target_agent_list 		= target_agent_list.substring(0, target_agent_list.length - 1);
			}
			
			if (!confirm("선택한 "+title+"을(를) 모두 이관 하시겠습니까?"))
			
				
			var frm = null;
			frm = document.dbProfileForm;
			
			
			frm.profile_name_arr.value 		= profile_name_list;
			frm.database_type_arr.value 	= database_type_list;
			frm.database_version_arr.value 	= database_version_list;
			frm.type_arr.value 				= type_list;
			frm.user_arr.value 				= user_list;
			frm.port_arr.value 				= port_list;
			frm.sid_arr.value 				= sid_list;
			frm.service_name_arr.value 		= service_name_list;
			frm.database_name_arr.value 	= database_name_list;
			frm.host_arr.value 				= host_list;
			frm.target_ctm_arr.value 		= target_ctm_list;
			frm.target_agent_arr.value 		= target_agent_list;
			
			frm.action = '/tWorks.ez?c=ez045_p';
	        frm.target = 'if1';
	        frm.submit();
			
			return;


		});
		
		$("#btn_code_close").button().unbind("click").click(function(){
			dlClose('popDbProfileInfo');
		});
	}
	
	
	function getConPro(db_host) {

		try{viewProgBar(true);}catch(e){}
		
		var formData = new FormData();
		var data_center = $("select[name='data_center_items'] option:selected").val();
		
		formData.append("c", 		"cData2");
		formData.append("itemGb", 	"getConPro");
		formData.append("host", 	db_host);
		formData.append("type", 	"Database");	//kubernetes의 connection profile 목록 가져오기위해 타입 지정

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

				$.each(data, function(index, item){
					var profile_name 		= data[index].PROFILE_NAME;
					var database_type 		= data[index].Type;
					var database_version 	= data[index].DatabaseVersion;
					var type 				= database_type;
					var database_type_ment 	= database_type.split(":")[2];
					
					var user		 		= data[index].User;
					var port 				= data[index].Port;
					var sid 				= data[index].SID;
					var service_name		= data[index].ServiceName;
					var database_name 		= data[index].DatabaseName;
					var host		 		= data[index].Host;
					var password 			= data[index].Password;
					var target_ctm			= data[index].TargetCTM;
					var target_agent		= data[index].TargetAgent;
					
					<c:forEach var="cm" items="${cm}" varStatus="status">
						if("${cm.scode_eng_nm}" == target_ctm){ target_ctm = "${cm.scode_cd},${cm.scode_eng_nm}"; }
					</c:forEach>
					
					// ez_database 테이블에 등록되어있는 데이터는 노출 X
					var toggle = true;
					for(var j = 0; j < profile_name_list.length; j++) {
						if(profile_name_list[j] == profile_name && data_center == target_ctm ) {
							toggle = false;
							break;
						}
					}
					
					if(toggle) {
						rowsObj.push({
							'grid_idx':i+1
							,'PROFILE_NAME': profile_name
							,'DATABASE_TYPE': database_type_ment
							,'DATABASE_VERSION': database_version
							,'TYPE': type
							,'USER': user
							,'PORT': port
							,'SID': sid
							,'SERVICE_NAME': service_name
							,'DATABASE_NAME': database_name
							,'HOST': host
							,'PASSWORD': password
							,'TARGET_CTM': target_ctm
							,'TARGET_AGENT': target_agent
						});
						++i;
					}
				});
				var obj = null;
				obj = $("#dbProfileGrid").data('gridObj');
				obj.rows = rowsObj;
				setGridRows(obj);
		
			},
			error: function(data){
				alert("Data Reading Error... ");	
			},
			complete: function(data){
				try{viewProgBar(false);}catch(e){}
			}
		});	
	}
	
	function fn_access(user_nm, database_type, database_pw, database_name, access_sid, access_service_name, access_port, host_nm) {
		
		if(database_pw == '') {
			alert("패스워드가 설정되어 있지 않습니다.\n설정 후 다시 시도해주세요.");
			return;
		}
		
		try{viewProgBar(true);}catch(e){}
		
		var f = document.frm3;		
		
		f.user_nm.value 	  = user_nm;
		f.database_type.value = database_type;
		f.database_pw.value   = database_pw;
		f.database_name.value = database_name;
		f.access_sid.value 	  = access_sid;
		f.access_service_name.value 	  = access_service_name;
		f.access_port.value   = access_port;
		f.host_nm.value 	  = host_nm;
		
		f.target = "if1";
		
		f.action = "<%=sContextPath %>/tWorks.ez?c=ez045_access"; 
		f.submit();
		
		return;
	}
	
</script>
