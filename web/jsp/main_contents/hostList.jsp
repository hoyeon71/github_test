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
	<input type="hidden" name="data_center" id="data_center"/>	
	<input type="hidden" name="p_search_gubun" id="p_search_gubun"/>
	<input type="hidden" name="p_search_text" id="p_search_text"/>
</form>

<form id="frm2" name="frm2" method="post" onsubmit="return false;">
	<input type="hidden" name="flag"/>	
	<input type="hidden" name="host_cd"/>
	<input type="hidden" name="data_center" />
	<input type="hidden" name="agent" />
	<input type="hidden" name="agent_nm" />
	<input type="hidden" name="agent_id" />
	<input type="hidden" name="agent_pw" />
	<input type="hidden" name="file_path" />
	<input type="hidden" name="access_gubun" />
	<input type="hidden" name="access_port" />
	<input type="hidden" name="server_gubun" />	
	<input type="hidden" name="server_lang" />	
	<input type="hidden" name="certify_gubun" />	
</form>

<form id="frm3" name="frm3" method="post" onsubmit="return false;">
	<input type="hidden" name="flag" id="flag"/>
	<input type="hidden" name="host_cd" id="host_cd"/>
</form>

<form id="frm4" name="frm4" method="post" onsubmit="return false;">	
	<input type="hidden" name="flag" id="flag"/>
	<input type="hidden" name="code_gubun" id="code_gubun"/>
	<input type="hidden" name="mcode_cd" id="mcode_cd"/>	
	<input type="hidden" name="scode_cd" id="scode_cd"/>
	<input type="hidden" name="scode_nm" id="scode_nm"/>
	<input type="hidden" name="scode_eng_nm" id="scode_eng_nm"/>
	<input type="hidden" name="scode_desc" id="scode_desc"/>
	<input type="hidden" name="scode_use_yn" id="scode_use_yn"/>
	<input type="hidden" name="order_no" id="order_no"/>
	<input type="hidden" name="user_gb" id="user_gb" value="<%=S_USER_GB%>"/>
	<input type="hidden" name="host_cd" id="host_cd" value="0"/>
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
							<option value="agent">호스트명</option>
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
	<tr style="height:50%">
		<td id='ly_<%=gridId %>' style='vertical-align:top;'>
			<div id="<%=gridId %>" class="ui-widget-header ui-corner-all"></div>
		</td>
	</tr>
	<tr style='height:10px;'>
		<td style='vertical-align:top;'>
			<h4 class="ui-widget-header ui-corner-all">
				<div align='right' class='btn_area'>
					<div id='ly_total_cnt' style='padding-top:5px;float:left;'></div>
					<span id="btn_hostTakeOver">호스트이관</span>
					<span id="btn_OwnerTakeOver">계정이관</span>
					<span id="btn_insert">추가</span>
					<span id="btn_update">수정</span>
					<span id="btn_delete">삭제</span>
				</div>
			</h4>
		</td>
	</tr>
	<tr><td style="height:1%"></td></tr>
	<tr>
		<td>계정정보</td>
	</tr>
	<tr style="height:30%">
		<td id='ly_<%=gridId_1 %>' style='vertical-align:top;'>
			<div id="<%=gridId_1 %>" class="ui-widget-header ui-corner-all"></div>
		</td>
	</tr>
	<tr style='height:10px;'>
		<td style='vertical-align:top;'>
			<h4 class="ui-widget-header ui-corner-all">
				<div align='right' class='btn_area'>
					<div id='ly_total_cnt_2' style='padding-top:5px;float:left;'></div>
					<input type="hidden" name="takeOver_host_cd" 	id="takeOver_host_cd"/>
					<input type="hidden" name="takeOver_node_id" 	id="takeOver_node_id"/>    
					<span id="btn_group_udt" style="display:none;">저장</span>
				</div>
			</h4>
		</td>
	</tr>
</table>
<script>
	var select_host_cd = "";
		
	function gridCellCustomFormatter(row,cell,value,columnDef,dataContext){
		
		var ret = "";
		var host_cd = getCellValue(gridObj,row,'HOST_CD');
		var data_center = getCellValue(gridObj,row,'DATA_CENTER');
		var agent = getCellValue(gridObj,row,'NODE_ID');
		var agent_id = getCellValue(gridObj,row,'AGENT_ID');
		var agent_pw = getCellValue(gridObj,row,'AGENT_PW');
		var access_gubun = getCellValue(gridObj,row,'V_ACCESS_GUBUN');
		var access_port = getCellValue(gridObj,row,'ACCESS_PORT');	
		
		
		if(columnDef.id == 'NODE_ID' || columnDef.id == 'NODE_NM'){
			ret = "<a href=\"JavaScript:sCodeList('"+host_cd+"','"+agent+"');\" /><font color='red'>"+value+"</font></a>";
		}
					
		if(columnDef.id == 'CONNECT'){
			ret = "<a href=\"JavaScript:fn_access('"+data_center+"','"+agent+"','"+agent_id+"','"+agent_pw+"','"+access_gubun+"','"+access_port+"');\" /><font color='red'>"+value+"</font></a>";
		}
		
		return ret;
	}
	
	var gridObj = {
		id : "<%=gridId %>"
		,colModel:[
	   		{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'번호',width:50,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}	   		
	   		,{formatter:gridCellNoneFormatter,field:'DATA_CENTER_NAME',id:'DATA_CENTER_NAME',name:'C-M',width:100,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	   		,{formatter:gridCellCustomFormatter,field:'NODE_ID',id:'NODE_ID',name:'호스트명',width:150,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}	 
	   		,{formatter:gridCellCustomFormatter,field:'NODE_NM',id:'NODE_NM',name:'설명',width:150,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}	   		
	   		,{formatter:gridCellNoneFormatter,field:'AGENT_ID',id:'AGENT_ID',name:'접속아이디',width:120,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}	   		
	   		//,{formatter:gridCellNoneFormatter,field:'AGENT_PW',id:'AGENT_PW',name:'접속패스워드',width:120,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'ACCESS_GUBUN',id:'ACCESS_GUBUN',name:'접근구분',width:100,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'ACCESS_PORT',id:'ACCESS_PORT',name:'접근포트',width:100,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'CERTIFY_GUBUN',id:'CERTIFY_GUBUN',name:'인증구분',width:100,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'FILE_PATH',id:'FILE_PATH',name:'SYSOUT 파일경로',width:200,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'SERVER_GUBUN',id:'SERVER_GUBUN',name:'사용구분',width:100,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'SERVER_LANG',id:'SERVER_LANG',name:'CHARACTER SET',width:140,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	   		//,{formatter:gridCellNoneFormatter,field:'PROC',id:'PROC',name:'설정',width:150,headerCssClass:'cellCenter',cssClass:'cellCenter'}
	   		,{formatter:gridCellCustomFormatter,field:'CONNECT',id:'CONNECT',name:'접속',width:80,headerCssClass:'cellCenter',cssClass:'cellCenter'}
	   				   		
	   		,{formatter:gridCellNoneFormatter,field:'DATA_CENTER',id:'DATA_CENTER',name:'C-M',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'HOST_CD',id:'HOST_CD',name:'HOST_CD',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   		,{formatter:gridCellNoneFormatter,field:'AGENT_PW',id:'AGENT_PW',name:'AGENT_PW',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   		,{formatter:gridCellNoneFormatter,field:'V_ACCESS_GUBUN',id:'V_ACCESS_GUBUN',name:'V_ACCESS_GUBUN',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   	]
		,rows:[]
		,vscroll:<%=S_GRID_VSCROLL%>
	};
	
	var gridObj_1 = {
		id : "<%=gridId_1 %>"
		,colModel:[
			{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'번호',width:50,headerCssClass:'cellCenter',cssClass:'cellCenter'}
			//,{formatter:gridCellNoneFormatter,field:'SCODE_CD',id:'SCODE_CD',name:'코드',width:80,headerCssClass:'cellCenter',cssClass:'cellCenter'}	 
			,{formatter:gridCellNoneFormatter,field:'SCODE_NM',id:'SCODE_NM',name:'코드명(한글)',width:180,headerCssClass:'cellCenter',cssClass:'cellLeft'}
			,{formatter:gridCellNoneFormatter,field:'SCODE_ENG_NM',id:'SCODE_ENG_NM',name:'코드명(영문)',width:180,headerCssClass:'cellCenter',cssClass:'cellLeft'}
			,{formatter:gridCellNoneFormatter,field:'ORDER_NO',id:'ORDER_NO',name:'순서',width:80,headerCssClass:'cellCenter',cssClass:'cellCenter'}	
			,{formatter:gridCellNoneFormatter,field:'SCODE_USE_YN',id:'SCODE_USE_YN',name:'사용구분',width:100,headerCssClass:'cellCenter',cssClass:'cellCenter'}	 
			,{formatter:gridCellNoneFormatter,field:'SCODE_DESC',id:'SCODE_DESC',name:'설명',width:250,headerCssClass:'cellCenter',cssClass:'cellLeft'}	 	 
			,{formatter:gridCellNoneFormatter,field:'PROC',id:'PROC',name:'설정',width:100,headerCssClass:'cellCenter',cssClass:'cellCenter'}  
			
			,{formatter:gridCellNoneFormatter,field:'HOST_CD',id:'HOST_CD',name:'HOST_CD',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
			,{formatter:gridCellNoneFormatter,field:'SCODE_CD',id:'SCODE_CD',name:'SCODE_CD',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   	]
		,rows:[]
		,vscroll:<%=S_GRID_VSCROLL%>
	};
	
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
		
// 		var data_center_items = $("select[name='data_center_items'] option:selected").val();

		viewGrid_1(gridObj,"ly_"+gridObj.id);
		hostList();
		
		viewGrid_1(gridObj_1,"ly_"+gridObj_1.id);
// 		sCodeList(null);

		$("#data_center_items").change(function(){
			var data_center_items = $("select[name='data_center_items'] option:selected").val();
			var arr_dt = data_center_items.split(",");

			$("#f_s").find("input[name='data_center']").val(data_center_items);
			$("#f_s").find("input[name='p_search_gubun']").val($("#frm1").find("select[name='search_gubun'] option:selected").val());
			$("#f_s").find("input[name='p_search_text']").val($("#frm1").find("input[name='search_text']").val());

			hostList();
			sCodeList(null);
		});

		$("#btn_search").button().unbind("click").click(function(){
			
			var data_center_items = $("select[name='data_center_items'] option:selected").val();
			var arr_dt = data_center_items.split(",");
			
			//$("#f_s").find("input[name='data_center']").val(arr_dt[1]);
			$("#f_s").find("input[name='data_center']").val(data_center_items);
			$("#f_s").find("input[name='p_search_gubun']").val($("#frm1").find("select[name='search_gubun'] option:selected").val());
			$("#f_s").find("input[name='p_search_text']").val($("#frm1").find("input[name='search_text']").val());
						
			hostList();
			sCodeList(null);
		});
		
		$('#search_text').unbind('keypress').keypress(function(e){			
			if(e.keyCode==13){	
				
				var data_center_items = $("select[name='data_center_items'] option:selected").val();
				var arr_dt = data_center_items.split(",");
				
				//$("#f_s").find("input[name='data_center']").val(arr_dt[1]);
				$("#f_s").find("input[name='data_center']").val(data_center_items);
				$("#f_s").find("input[name='p_search_gubun']").val($("#frm1").find("select[name='search_gubun'] option:selected").val());
				$("#f_s").find("input[name='p_search_text']").val($("#frm1").find("input[name='search_text']").val());
				
				hostList();
				sCodeList(null);
			}
		});
		
		$("#btn_insert").button().unbind("click").click(function(){
			hostInsert();
		});
			
		$("#btn_delete").button().unbind("click").click(function(){
			hostDelete();
		});
		
		$("#btn_update").button().unbind("click").click(function(){
			
			var cnt = 0;
			var host_cd = "";
			var aSelRow = new Array;
			aSelRow = $('#'+gridObj.id).data('grid').getSelectedRows();
			if(aSelRow.length>0){
				for(var i=0;i<aSelRow.length;i++){
					host_cd = getCellValue(gridObj,aSelRow[i],'HOST_CD');
					
					++cnt;
				}
				
				if(cnt > 1){
					alert("한개의 호스트만 선택해 주세요.");
					return;
				}else{
					hostUpdate(host_cd);
				}
				
			}else{
				alert("수정하려는 호스트를 선택해 주세요.");
				return;
			}
		});
		
		$("#btn_hostTakeOver").button().unbind("click").click(function(){
			popTakeOverForm("호스트", "host");
		});
		
		$("#btn_group_udt").button().unbind("click").click(function(){
			var str_scode_cd	 = "";
			
			for(var i = 0; i < gridObj_1.rows.length; i++) {
				if( i == 0){
					if($("input[name=scode_nm0]").val() != "" || $("input[name=scode_eng_nm0]").val() != ""){ // 코드명(한글, 영문)이 입력되었을 때 
						str_scode_cd += ",0";
					}
				}else {
					var scode_cd = getCellValue(gridObj_1, i, "SCODE_CD");
					str_scode_cd += "," + scode_cd;
				}
			}
			
 			// 첫번째 컴마 제거
			str_scode_cd = str_scode_cd.substr(1);
			
			if(gridObj_1.rows.length == 1) { // 코드정보가 비어있을 경우
				str_scode_cd = "0";
			}
			
			goCodePrc("H", "group_udt", str_scode_cd, '${SERVER_MCODE_CD}', select_host_cd);
		});
		
	});
		
	function hostList(){
		
		$("#f_s").find("input[name='p_search_gubun']").val($("#frm1").find("select[name='search_gubun'] option:selected").val());
		$("#f_s").find("input[name='p_search_text']").val($("#frm1").find("input[name='search_text']").val());
				
		try{viewProgBar(true);}catch(e){}
		$('#ly_total_cnt').html('');
		
		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=hostList';
		
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
							
								var host_cd 			= $(this).find("HOST_CD").text();
								var data_center 		= $(this).find("DATA_CENTER").text();
								var data_center_name 	= $(this).find("DATA_CENTER_NAME").text();
								var node_id 			= $(this).find("NODE_ID").text();
								var node_nm 			= $(this).find("NODE_NM").text();
								var agent_id 			= $(this).find("AGENT_ID").text();
								var agent_pw 			= $(this).find("AGENT_PW").text();
								var access_gubun 		= $(this).find("ACCESS_GUBUN").text();
								var access_port 		= $(this).find("ACCESS_PORT").text();
								var file_path 			= $(this).find("FILE_PATH").text();
								var server_gubun 		= $(this).find("SERVER_GUBUN").text();
								var server_lang			= $(this).find("SERVER_LANG").text();
								var certify_gubun 		= $(this).find("CERTIFY_GUBUN").text();
								var proc 				= "<div>[설정]</div>";
								var connect 			= "<div>[접속]</div>";
								var v_access_gubun	 	= access_gubun;
								
								if(access_gubun == "S"){
									access_gubun = "SSH";
								}else if(access_gubun == "T"){
									access_gubun = "TELNET";
								}else{
									access_gubun = "";
								}
								
								if(server_gubun == "A"){
									server_gubun = "AGENT";
								}else if(server_gubun == "G"){
									server_gubun = "AGENT그룹";
								}else if(server_gubun == "S"){
									server_gubun = "C-M서버";
								}else{
									server_gubun = "";
								}	
								
								if(server_lang == "U"){
									server_lang = "UTF-8";
								}else if(server_lang == "E"){
									server_lang = "EUC-KR";
								}else{
									server_lang = "";
								}		
								if(certify_gubun == "P"){
									certify_gubun = "PASSWORD";
								}else if(certify_gubun == "K"){
									certify_gubun = "KEY";
								}	
								
								rowsObj.push({
									'grid_idx':i+1
									,'HOST_CD': host_cd
									,'DATA_CENTER': data_center
									,'DATA_CENTER_NAME': data_center_name
									,'NODE_ID': node_id
									,'NODE_NM': node_nm
									,'AGENT_ID': agent_id
									,'AGENT_PW': agent_pw
									,'ACCESS_GUBUN': access_gubun
									,'ACCESS_PORT': access_port
									,'CERTIFY_GUBUN': certify_gubun
									,'FILE_PATH': file_path
									,'SERVER_GUBUN': server_gubun
									,'SERVER_LANG': server_lang
									,'PROC': proc
									,'CONNECT': connect
									,'V_ACCESS_GUBUN' : v_access_gubun
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
	
	function hostInsert(){
		
		var sHtml="<div id='dl_tmp1' style='overflow:hidden;display:none;padding:0;border-top:1px solid blue;border-bottom:1px solid blue;border-left:1px solid blue;border-right:1px solid blue;'>";
		sHtml+="<form id='form1' name='form1' method='post' onsubmit='return false;'>";
		sHtml+="<input type='hidden' name='flag' id='flag'/>";	
		sHtml+="<table style='width:100%;height:450px;border:none;'>";
		sHtml+="<tr><td style='vertical-align:top;height:90%;width:490px;' >";
		
		sHtml+="<table style='width:100%;height:88%;border:none;'>";
		sHtml+="<tr><td id='ly_g_tmp1' style='vertical-align:top;'>";
		sHtml+="<div id='g_tmp1' class='ui-widget-header ui-corner-all'></div>";
		sHtml+="</td></tr>";
		sHtml+="<tr style='height:10px;'><td style='vertical-align:top;'><h5 class='ui-widget-header ui-corner-all' >";
		sHtml+="<div align='right' class='btn_area_s'>";
		sHtml+="<span id='btn_ins'>저장</span>";
		sHtml+="</div>";
		sHtml+="</h5></td></tr></table>";
		
		sHtml+="</td></tr></table>";
		
		sHtml+="</form>";
		
		$('#dl_tmp1').remove();
		$('body').append(sHtml);
						
		var headerObj = new Array();
		var hTmp1 = "";
		var hTmp2 = "";
		hTmp1 += "<div class='cellTitle_1'>C-M</div>";
		hTmp2 += "<div class='cellContent_1'>";
		hTmp2 += "<select name='data_center' id='data_center'>";
				
		<c:forEach var="cm" items="${cm}" varStatus="status">
			hTmp2 +="<option value='${cm.scode_cd},${cm.scode_eng_nm}'>${cm.scode_nm}</option>";
		</c:forEach>
	
		hTmp2 += "</select>";
		hTmp2 += "</div>";
		hTmp1 += "<div class='cellTitle_1'>호스트명</div>";
		hTmp2 += "<div class='cellContent_1'><input type='text' name='agent' id='agent' style='width:100%;border:0px none;'/></div>";
		hTmp1 += "<div class='cellTitle_1'>설명</div>";
		hTmp2 += "<div class='cellContent_1'><input type='text' name='agent_nm' id='agent_nm' style='width:100%;border:0px none;'/></div>";
		hTmp1 += "<div class='cellTitle_1'>사용구분</div>";
		hTmp2 += "<div class='cellContent_1'>";
		hTmp2 += "<select name='server_gubun' id='server_gubun'>";
		hTmp2 += "<option value=''>--선택--</option>";
		hTmp2 += "<option value='S'>C-M서버</option>";
		hTmp2 += "<option value='A'>AGENT</option>";
		hTmp2 += "<option value='G'>AGENT그룹</option>";
		hTmp2 += "</select>";
		hTmp2 += "</div>";
		hTmp1 += "<div class='cellTitle_1'>접속아이디</div>";
		hTmp2 += "<div class='cellContent_1'><input type='text' name='agent_id' id='agent_id' style='width:100%;border:0px none;'/></div>";
		hTmp1 += "<div class='cellTitle_1'>접속패스워드</div>";
		hTmp2 += "<div class='cellContent_1'><input type='password' name='agent_pw' id='agent_pw' style='width:100%;border:0px none;'/></div>";
		hTmp1 += "<div class='cellTitle_1'>접근구분</div>";
		hTmp2 += "<div class='cellContent_1'>";
		hTmp2 += "<select name='access_gubun' id='access_gubun'>";
		hTmp2 += "<option value=''>--선택--</option>";
		hTmp2 += "<option value='S'>SSH</option>";
		hTmp2 += "<option value='T'>TELNET</option>";
		hTmp2 += "</select>";
		hTmp2 += "</div>";
		hTmp1 += "<div class='cellTitle_1'>접근포트</div>";
		hTmp2 += "<div class='cellContent_1'><input type='text' name='access_port' id='access_port' style='width:100%;border:0px none;'/></div>";
		hTmp1 += "<div class='cellTitle_1'>인증구분</div>";
		hTmp2 += "<div class='cellContent_1'>";
		hTmp2 += "<select name='certify_gubun' id='certify_gubun'>";
		hTmp2 += "<option value=''>--선택--</option>";
		hTmp2 += "<option value='P'>PASSWORD</option>";
		hTmp2 += "<option value='K'>KEY</option>";
		hTmp2 += "</select>";
		hTmp2 += "</div>";
		hTmp1 += "<div class='cellTitle_1'>SYSOUT 파일경로</div>";
		hTmp2 += "<div class='cellContent_1'><input type='text' name='file_path' id='file_path' style='width:100%;border:0px none;'/></div>";
		hTmp1 += "<div class='cellTitle_1'>CHARACTER SET</div>";
		hTmp2 += "<div class='cellContent_1'>";
		hTmp2 += "<select name='server_lang' id='server_lang'>";
		hTmp2 += "<option value='U'>UTF-8</option>";
		hTmp2 += "<option value='E'>EUC-KR</option>";
		hTmp2 += "</select>";
		hTmp2 += "</div>";
				
		headerObj.push({name:hTmp1,id_s:'c_1',id_e:'c_1'});
		headerObj.push({name:hTmp2,id_s:'c_2',id_e:'c_2'});
		var gridObj_s = {
			id : "g_tmp1"
			,colModel:[
		  		{formatter:gridCellNoneFormatter,field:'c_1',id:'c_1',name:'구 분',width:110,headerCssClass:'cellCenter',cssClass:'cellCenter'}
				,{formatter:gridCellNoneFormatter,field:'c_2',id:'c_2',name:'내 용',width:300,headerCssClass:'cellCenter',cssClass:'cellLeft'}
			   	
		   		,{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'grid_idx',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
		   	]
			,rows:[]
			,headerRowHeight:420
			,colspan:headerObj
			,vscroll:false
		};
		
		viewGrid_1(gridObj_s,'ly_'+gridObj_s.id);
		
		dlPop01('dl_tmp1',"호스트등록",415,410,false);
		
		//agent 그룹일 시 다른 항목 disable
		$("#form1 #server_gubun").change(function(){
			if($("#form1").find("select[name='server_gubun']").val() == "G"){
				$("#form1 #agent_id").attr("disabled", true);
				$("#form1 #agent_pw").attr("disabled", true);
				$("#form1 #access_gubun").attr("disabled", true);
				$("#form1 #access_port").attr("disabled", true);
				$("#form1 #file_path").attr("disabled", true);
				$("#form1 #server_lang").attr("disabled", true);
			}else{
				$("#form1 #agent_id").attr("disabled", false);
				$("#form1 #agent_pw").attr("disabled", false);
				$("#form1 #access_gubun").attr("disabled", false);
				$("#form1 #access_port").attr("disabled", false);
				$("#form1 #file_path").attr("disabled", false);
				$("#form1 #server_lang").attr("disabled", false);
			}
		});
		
		$("#btn_ins").button().unbind("click").click(function(){
			
			if($("#form1").find("select[name='data_center']").val() == ""){
				alert('<%=CommonUtil.getMessageSplit("ERROR.PARAM.02","[CTM]","") %>'); 
				return false;
			}
			
			if(isNullInput($('#form1 #agent'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[호스트명]","") %>')) return false;
			if(isNullInput($('#form1 #agent_nm'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[설명]","") %>')) return false;
			
			if($("#form1").find("select[name='server_gubun']").val() == ""){
				alert('<%=CommonUtil.getMessageSplit("ERROR.PARAM.02","[사용구분]","") %>'); 
				return false;
			}
			
			if($("#form1").find("select[name='server_gubun']").val() != "G"){
				if(isNullInput($('#form1 #agent_id'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[접속아이디]","") %>')) return false;
				if($('#form1 #certify_gubun').val() == 'P'){
					if(isNullInput($('#form1 #agent_pw'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[접속패스워드]","") %>')) return false;	
				}
							
				if($("#form1").find("select[name='access_gubun']").val() == ""){
					alert('<%=CommonUtil.getMessageSplit("ERROR.PARAM.02","[접근구분]","") %>'); 
					return false;
				}
				if(isNullInput($('#form1 #access_port'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[접근포트]","") %>')) return false;
				if($("#form1").find("select[name='certify_gubun']").val() == ""){
					alert('<%=CommonUtil.getMessageSplit("ERROR.PARAM.02","[인증구분]","") %>'); 
					return false;
				}
				if(isNullInput($('#form1 #file_path'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[SYSOUT 파일경로]","") %>')) return false;
				if(isNullInput($('#form1 #server_lang'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[CHARACTER SET]","") %>')) return false;
			}
						
			if(confirm("해당 내용을 등록 하시겠습니까?")){
				var f = document.form1;
				
				try{viewProgBar(true);}catch(e){}
				
				f.flag.value = "ins";
				f.target = "if1";
				f.action = "<%=sContextPath %>/tWorks.ez?c=ez013_p"; 
				f.submit();
				
				try{viewProgBar(false);}catch(e){}
				
				dlClose('dl_tmp1');
			}
		});
	}
	
	function hostUpdate(host_cd){	
		
		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=hostList&host_cd='+host_cd;
		
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
						
						var data_center 	= "";
						var node_id 		= "";
						var node_nm 		= "";
						var agent_id 		= "";
						var agent_pw 		= "";
						var access_gubun 	= "";
						var access_port 	= "";
						var file_path 		= "";
						var server_gubun 	= "";
						var server_lang		= "";
						var certify_gubun = "";
						
						if(items.attr('cnt')=='0'){
						}else{
							items.find('item').each(function(i){						
							
								data_center 	= $(this).find("DATA_CENTER").text();
								node_id 		= $(this).find("NODE_ID").text();
								node_nm 		= $(this).find("NODE_NM").text();
								agent_id 		= $(this).find("AGENT_ID").text();
								agent_pw 		= $(this).find("AGENT_PW").text();
								access_gubun	= $(this).find("ACCESS_GUBUN").text();
								access_port 	= $(this).find("ACCESS_PORT").text();
								file_path		= $(this).find("FILE_PATH").text();
								server_gubun 	= $(this).find("SERVER_GUBUN").text();		
								server_lang 	= $(this).find("SERVER_LANG").text();	
								certify_gubun = $(this).find("CERTIFY_GUBUN").text();							
							});						
						}
						
						var sHtml="<div id='dl_tmp2' style='overflow:hidden;display:none;padding:0;border-top:1px solid blue;border-bottom:1px solid blue;border-left:1px solid blue;border-right:1px solid blue;'>";
						sHtml+="<form id='form2' name='form2' method='post' onsubmit='return false;'>";
						sHtml+="<input type='hidden' name='flag' id='flag'/>";	
						sHtml+="<input type='hidden' name='host_cd' id='host_cd'/>";	
						sHtml+="<input type='hidden' name='agent_pw' id='agent_pw'/>";	
						sHtml+="<table style='width:100%;height:450px;border:none;'>";
						sHtml+="<tr><td style='vertical-align:top;height:100%;width:490px;' >";
						
						sHtml+="<table style='width:100%;height:88%;border:none;'>";
						sHtml+="<tr><td id='ly_g_tmp2' style='vertical-align:top;'>";
						sHtml+="<div id='g_tmp2' class='ui-widget-header ui-corner-all'></div>";
						sHtml+="</td></tr>";
						sHtml+="<tr style='height:10px;'><td style='vertical-align:top;'><h5 class='ui-widget-header ui-corner-all' >";
						sHtml+="<div align='right' class='btn_area_s'>";
						sHtml+="<span id='btn_udt'>저장</span>";
						sHtml+="<span id='btn_del'>삭제</span>";
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
						hTmp2 += "<select name='data_center' id='data_center' disabled>";
						<c:forEach var="cm" items="${cm}" varStatus="status">
							hTmp2 +="<option value='${cm.scode_cd},${cm.scode_eng_nm}'>${cm.scode_nm}</option>";
						</c:forEach>
						hTmp2 += "</select>";
						hTmp2 += "</div>";
						hTmp1 += "<div class='cellTitle_1'>호스트명</div>";
						hTmp2 += "<div class='cellContent_1'><input type='text' name='agent' id='agent' style='width:100%;border:0px none;background-color:#EBEBE4;' readOnly /></div>";
						hTmp1 += "<div class='cellTitle_1'>설명</div>";
						hTmp2 += "<div class='cellContent_1'><input type='text' name='agent_nm' id='agent_nm' style='width:100%;border:0px none;'/></div>";
						hTmp1 += "<div class='cellTitle_1'>사용구분</div>";
						hTmp2 += "<div class='cellContent_1'>";
						hTmp2 += "<select name='server_gubun' id='server_gubun'>";
						hTmp2 += "<option value=''>--선택--</option>";
						hTmp2 += "<option value='S'>C-M서버</option>";
						hTmp2 += "<option value='A'>AGENT</option>";
						hTmp2 += "<option value='G'>AGENT그룹</option>";
						hTmp2 += "</select>";
						hTmp2 += "</div>";
						hTmp1 += "<div class='cellTitle_1'>접속아이디</div>";
						hTmp2 += "<div class='cellContent_1'><input type='text' name='agent_id' id='agent_id' style='width:100%;border:0px none;'/></div>";
						hTmp1 += "<div class='cellTitle_1'>접속패스워드</div>";
						hTmp2 += "<div class='cellContent_1'><input type='password' name='v_agent_pw' id='v_agent_pw' style='width:100%;border:0px none;'/></div>";
						hTmp1 += "<div class='cellTitle_1'>접근구분</div>";
						hTmp2 += "<div class='cellContent_1'>";
						hTmp2 += "<select name='access_gubun' id='access_gubun'>";
						hTmp2 += "<option value=''>--선택--</option>";
						hTmp2 += "<option value='S'>SSH</option>";
						hTmp2 += "<option value='T'>TELNET</option>";
						hTmp2 += "</select>";
						hTmp2 += "</div>";
						hTmp1 += "<div class='cellTitle_1'>접근포트</div>";
						hTmp2 += "<div class='cellContent_1'><input type='text' name='access_port' id='access_port' style='width:100%;border:0px none;'/></div>";
						hTmp1 += "<div class='cellTitle_1'>인증구분</div>";
						hTmp2 += "<div class='cellContent_1'>";
						hTmp2 += "<select name='certify_gubun' id='certify_gubun'>";
						hTmp2 += "<option value=''>--선택--</option>";
						hTmp2 += "<option value='P'>PASSWORD</option>";
						hTmp2 += "<option value='K'>KEY</option>";
						hTmp2 += "</select>";
						hTmp2 += "</div>";
						hTmp1 += "<div class='cellTitle_1'>SYSOUT 파일경로</div>";
						hTmp2 += "<div class='cellContent_1'><input type='text' name='file_path' id='file_path' style='width:100%;border:0px none;'/></div>";
						hTmp1 += "<div class='cellTitle_1'>CHARACTER SET</div>";
						hTmp2 += "<div class='cellContent_1'>";
						hTmp2 += "<select name='server_lang' id='server_lang'>";
						hTmp2 += "<option value=''>--선택--</option>";
						hTmp2 += "<option value='U'>UTF-8</option>";
						hTmp2 += "<option value='E'>EUC-KR</option>";
						hTmp2 += "</select>";
						hTmp2 += "</div>";
								
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
						
						var f = document.form2;
						f.host_cd.value = host_cd;
						f.data_center.value = data_center;
						f.agent.value = node_id;
						f.agent_nm.value = node_nm;
						f.agent_id.value = agent_id;
						f.agent_pw.value = agent_pw;
						f.file_path.value = file_path;
						f.access_gubun.value = access_gubun;
						f.access_port.value = access_port;
						f.server_gubun.value = server_gubun;
						f.server_lang.value = server_lang;
						f.certify_gubun.value = certify_gubun;
						
						//agent 그룹일 시 다른 항목 disable
						if ( server_gubun == "G" ) {
							$("#form2 #agent_id").attr("disabled", true);
							$("#form2 #v_agent_pw").attr("disabled", true);
							$("#form2 #access_gubun").attr("disabled", true);
							$("#form2 #access_port").attr("disabled", true);
							$("#form2 #file_path").attr("disabled", true);
							$("#form2 #server_lang").attr("disabled", true);
							$("#form2 #certify_gubun").attr("disabled", true);
						} else {
							$("#form2 #agent_id").attr("disabled", false);
							$("#form2 #v_agent_pw").attr("disabled", false);
							$("#form2 #access_gubun").attr("disabled", false);
							$("#form2 #access_port").attr("disabled", false);
							$("#form2 #file_path").attr("disabled", false);
							$("#form2 #server_lang").attr("disabled", false);
							$("#form2 #certify_gubun").attr("disabled", false);
						}
						
						dlPop01('dl_tmp2',"호스트정보수정",415,410,false);
						
						//agent 그룹일 시 다른 항목 disable
						$("#form2 #server_gubun").change(function(){
							if($("#form2").find("select[name='server_gubun']").val() == "G"){
								$("#form2 #agent_id").attr("disabled", true);
								$("#form2 #v_agent_pw").attr("disabled", true);
								$("#form2 #access_gubun").attr("disabled", true);
								$("#form2 #access_port").attr("disabled", true);
								$("#form2 #file_path").attr("disabled", true);
								$("#form2 #server_lang").attr("disabled", true);
								$("#form2 #certify_gubun").attr("disabled", true);
							}else{
								$("#form2 #agent_id").attr("disabled", false);
								$("#form2 #v_agent_pw").attr("disabled", false);
								$("#form2 #access_gubun").attr("disabled", false);
								$("#form2 #access_port").attr("disabled", false);
								$("#form2 #file_path").attr("disabled", false);
								$("#form2 #server_lang").attr("disabled", false);
								$("#form2 #certify_gubun").attr("disabled", false);
							}
						});
						
						$("#btn_del").button().unbind("click").click(function(){
							if(confirm("해당 내용을 삭제 하시겠습니까?")){
								var f = document.form2;
								
								try{viewProgBar(true);}catch(e){}
								
								f.flag.value = "del";
								f.target = "if1";
								f.action = "<%=sContextPath %>/tWorks.ez?c=ez013_p"; 
								f.submit();
								
								try{viewProgBar(false);}catch(e){}
								
								dlClose('dl_tmp2');
							}
						});
						
						$("#btn_udt").button().unbind("click").click(function(){
							
							if($("#form2").find("select[name='data_center']").val() == ""){
								alert('<%=CommonUtil.getMessageSplit("ERROR.PARAM.02","[CTM]","") %>'); 
								return false;
							}
							
							if(isNullInput($('#form2 #agent'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[호스트명]","") %>')) return false;
							if(isNullInput($('#form2 #agent_nm'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[설명]","") %>')) return false;
							
							if($("#form2").find("select[name='server_gubun']").val() == ""){
								alert('<%=CommonUtil.getMessageSplit("ERROR.PARAM.02","[사용구분]","") %>'); 
								return false;
							}
							//agent그룹이 아닐 시 필수체크
							if($("#form2").find("select[name='server_gubun']").val() != "G"){
								
								if(isNullInput($('#form2 #agent_id'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[접속아이디]","") %>')) return false;
								//if(isNullInput($('#form2 #v_agent_pw'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[접속패스워드]","") %>')) return false;
								
								if($("#form2").find("select[name='access_gubun']").val() == ""){
									alert('<%=CommonUtil.getMessageSplit("ERROR.PARAM.02","[접근구분]","") %>'); 
									return false;
								}
								if(isNullInput($('#form2 #access_port'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[접근포트]","") %>')) return false;
								if($("#form2").find("select[name='certify_gubun']").val() == ""){
									alert('<%=CommonUtil.getMessageSplit("ERROR.PARAM.02","[인증구분]","") %>'); 
									return false;
								}
								if(isNullInput($('#form2 #file_path'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[SYSOUT 파일경로]","") %>')) return false;
								if(isNullInput($('#form2 #server_lang'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[CHARACTER SET]","") %>')) return false;
							}	
										
							if(confirm("해당 내용을 변경 하시겠습니까?")){
								var f = document.form2;
								
								try{viewProgBar(true);}catch(e){}
								
								f.flag.value = "udt";
								f.target = "if1";
								f.action = "<%=sContextPath %>/tWorks.ez?c=ez013_p"; 
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

	function sCodeList(host_cd, agent){
		
		select_host_cd = host_cd;
		
		//계정이관 조회시 필요 파라미터.
		$("#takeOver_node_id").val(agent);
		$("#takeOver_host_cd").val(host_cd);   
		
		try{viewProgBar(true);}catch(e){}
		$('#ly_total_cnt_2').html('');
		
		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=sCodeList&user_gb=<%=S_USER_GB %>&host_cd='+host_cd+'&mcode_cd=${SERVER_MCODE_CD}';
		
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
						
						var v_scode_nm = "<div class='gridInput_area'><input type='text' name='scode_nm0' id='scode_nm0' style='width:100%;'/></div>";
						var v_scode_eng_nm = "<div class='gridInput_area'><input type='text' name='scode_eng_nm0' id='scode_eng_nm0' style='width:100%;'/></div>";
						var v_order_no = "<div class='gridInput_area'><input type='text' name='order_no0' id='order_no0' size='3' /></div>";
						
						var v_scode_desc = "<div class='gridInput_area'><input type='text' name='scode_desc0' id='scode_desc0' style='width:100%;'/></div>";
						var v_proc = "<div><a href=\"javascript:goCodePrc('H','ins','0','${SERVER_MCODE_CD}', '"+host_cd+"');\"><font color='red'>[추가]</font></a></div>";
						var v_scode_use_yn = "";
						v_scode_use_yn += "<div><select name='scode_use_yn0' id='scode_use_yn0' style='width:50px;'>";
						v_scode_use_yn += "<option value='Y'>Y</option>";
						v_scode_use_yn += "<option value='N'>N</option>";
						v_scode_use_yn += "</select></div>";
						
						rowsObj.push({
							'grid_idx':''
							,'SCODE_CD':''
							,'SCODE_NM': v_scode_nm
							,'SCODE_ENG_NM': v_scode_eng_nm
							,'ORDER_NO': v_order_no
							,'SCODE_USE_YN': v_scode_use_yn
							,'SCODE_DESC': v_scode_desc
							,'PROC': v_proc
							,'HOST_CD': ''
						});	
						
						if(items.attr('cnt')=='0'){
						}else{
							items.find('item').each(function(i){						
							
								var scode_cd = $(this).find("SCODE_CD").text();
								var scode_nm = $(this).find("SCODE_NM").text();
								var order_no = $(this).find("ORDER_NO").text();
								var scode_eng_nm = $(this).find("SCODE_ENG_NM").text();
								var scode_use_yn = $(this).find("SCODE_USE_YN").text();
								var scode_desc = $(this).find("SCODE_DESC").text();
								var host_cd = $(this).find("HOST_CD").text();
								var proc = "";
								
								var v_scode_nm = "<div class='gridInput_area'><input type='text' name='scode_nm"+scode_cd+"' id='scode_nm"+scode_cd+"' style='width:100%;' value='"+scode_nm+"'/></div>";
								var v_scode_eng_nm = "<div class='gridInput_area'><input type='text' name='scode_eng_nm"+scode_cd+"' id='scode_eng_nm"+scode_cd+"' style='width:100%;' value='"+scode_eng_nm+"'/></div>";
								var v_order_no = "<div class='gridInput_area'><input type='text' name='order_no"+scode_cd+"' id='order_no"+scode_cd+"' value='"+order_no+"' size='3'/></div>";
								var v_scode_desc = "<div class='gridInput_area'><input type='text' name='scode_desc"+scode_cd+"' id='scode_desc"+scode_cd+"' value='"+scode_desc+"' style='width:100%;'/></div>";
								
								var v_proc = "<div><a href=\"javascript:goCodePrc('H','udt','"+scode_cd+"','${SERVER_MCODE_CD}','"+host_cd+"');\"><font color='red'>[수정]</font></a>&nbsp;&nbsp;<a href=\"javascript:goCodePrc('H','del','"+scode_cd+"','${SERVER_MCODE_CD}','"+host_cd+"');\"><font color='red'>[삭제]</font></a></div>";
								var v_scode_use_yn = "";
								v_scode_use_yn += "<div><select name='scode_use_yn"+scode_cd+"' id='scode_use_yn"+scode_cd+"' style='width:50px;'>";
								
								if(scode_use_yn == "Y"){
									v_scode_use_yn += "<option value='Y' selected>Y</option>";
								}else{
									v_scode_use_yn += "<option value='Y'>Y</option>";
								}
								if(scode_use_yn == "N"){
									v_scode_use_yn += "<option value='N' selected>N</option>";
								}else{
									v_scode_use_yn += "<option value='N'>N</option>";
								}
								
								v_scode_use_yn += "</select></div>";
																																					
								rowsObj.push({
									'grid_idx':i+1
									,'SCODE_CD': scode_cd
									,'SCODE_NM': v_scode_nm
									,'SCODE_ENG_NM': v_scode_eng_nm
									,'ORDER_NO': v_order_no
									,'SCODE_USE_YN': v_scode_use_yn
									,'SCODE_DESC': v_scode_desc
									,'PROC': v_proc
									,'HOST_CD': host_cd
								});
							});						
						}
						
						gridObj_1.rows = rowsObj;
						setGridRows(gridObj_1);
						$('#ly_total_cnt_2').html('[ TOTAL : '+items.attr('cnt')+' ]');
						$("#btn_OwnerTakeOver").show(); 
						$("#btn_group_udt").show();
					});
					try{viewProgBar(false);}catch(e){}
				}
		, null );
		
		xhr.sendRequest();
	}
	
	$("#btn_OwnerTakeOver").button().unbind("click").click(function(){
		
		var host_cd = $("#takeOver_host_cd").val(); 
		
		popTakeOverForm("계정", "owner", host_cd);
	});
	
	function fn_access(data_center, agent, agent_id, agent_pw, access_gubun, access_port){
		
		var frm = document.frm2;
	
		frm.data_center.value 	= data_center;
		frm.agent.value 		= agent;
		frm.agent_id.value 		= agent_id;
		frm.agent_pw.value 		= agent_pw;
		frm.access_gubun.value 	= access_gubun;
		frm.access_port.value 	= access_port;
		
		try{viewProgBar(true);}catch(e){}
		
		var url = "<%=sContextPath%>/tWorks.ez?c=ez013_access";
		var xhr = new XHRHandler(url, frm, callBackSearchItemValue, null);
		xhr.sendRequest();
		
	}
	
	// AJAX 콜백 함수.
	function callBackSearchItemValue(){
		
		var result_text = this.req.responseText;
	
		// 앞뒤 공백 제거.
		result_text = result_text.replace(/^\s+|\s+$/g,"");
	
		if ( result_text.indexOf("/") > -1 ) {
			try{viewProgBar(false);}catch(e){}
			alert("접속 성공!\n홈 디렉토리 : " + result_text);
		} else {
			try{viewProgBar(false);}catch(e){}
			alert(result_text);
		}
	}
	
	function hostDelete(){
		
		var cnt = 0;
		var host_cd = "";
		
		var aSelRow = new Array;
		aSelRow = $('#'+gridObj.id).data('grid').getSelectedRows();
		if(aSelRow.length>0){
			for(var i=0;i<aSelRow.length;i++){
					
				if(i>0) host_cd += "|";
				host_cd += getCellValue(gridObj,aSelRow[i],'HOST_CD');
				
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
			var f = document.frm3;		
			
			f.flag.value = "del";
			f.host_cd.value = host_cd;
			f.target = "if1";
			f.action = "<%=sContextPath %>/tWorks.ez?c=ez013_p"; 
			f.submit();			
		}
	}
	
	//호스트,계정 이관
	function popTakeOverForm(title, gb, host_cd){
		
		var sHtml1="<div id='cmAppGrpCode' style='overflow:hidden;display:none;padding:0;border-top:1px solid blue;border-bottom:1px solid blue;border-left:1px solid blue;border-right:1px solid blue;'>";
		sHtml1+="<form id='appGrpCodeForm' name='appGrpCodeForm' method='post' onsubmit='return false;'>";
		
		sHtml1+="<input type='hidden' name='p_gb' id='p_gb' value="+gb+">";
		sHtml1+="<input type='hidden' name='job_data_center' id='job_data_center'/>";
		
		var host_cd = $("#takeOver_host_cd").val();
		
        if(gb == 'host'){
        	sHtml1 += "<input type='hidden' name='flag' value='host_takeOver'/>";
            sHtml1 += "<input type='hidden' name='hostname_arr' 	 id='hostname_arr'/>";
            sHtml1 += "<input type='hidden' name='description_arr'   id='description_arr'/>";
            sHtml1 += "<input type='hidden' name='server_gubun_arr'  id='server_gubun_arr'/>";
            sHtml1 += "<input type='hidden' name='agent_id_arr' 	 id='agent_id_arr'/>";
            sHtml1 += "<input type='hidden' name='agent_pw_arr' 	 id='agent_pw_arr'/>";
            sHtml1 += "<input type='hidden' name='access_gubun_arr'  id='access_gubun_arr'/>";
            sHtml1 += "<input type='hidden' name='access_port_arr' 	 id='access_port_arr'/>";
            sHtml1 += "<input type='hidden' name='certify_gubun_arr' id='certify_gubun_arr'/>";
            sHtml1 += "<input type='hidden' name='file_path_arr' 	 id='file_path_arr'/>";
            sHtml1 += "<input type='hidden' name='server_lang_arr' 	 id='server_lang_arr'/>";
        }else if(gb == 'owner'){
        	sHtml1 += "<input type='hidden' name='flag' value='owner_takeOver'/>";
        	sHtml1 += "<input type='hidden' name='host_cd_arr' 		 id='host_cd_arr'/>";
        	sHtml1 += "<input type='hidden' name='owner_arr' 		 id='owner_arr'/>";
        }
		
		sHtml1+="<table style='width:100%;height:100%;border:none;'>"; //table 시작
		
		sHtml1+="<tr style='height:15px;'>"; // tr         
		if(gb == 'host'){
			sHtml1+="<td style='vertical-align:top;height:100%;width:50%;text-align:left;'>";
			sHtml1+="<div class='btn_area' style='float:left; margin:10px;' >";    
			sHtml1+="<select style='height:20px; margin-right:5px;' id='select' name='select' ><option value=''>항목</option>";
			sHtml1+="<option value='host_name'>호스트명</option>";  
			sHtml1+="<option value='description'>설명	</option>";
			sHtml1+="<option value='agent_id'>접속아이디</option>";
			sHtml1+="<option value='agent_pw'>접속패스워드</option>";  
			sHtml1+="<option value='access_gubun'>접근구분	</option>";
			sHtml1+="<option value='access_port'>접근포트</option>";
			sHtml1+="<option value='certify_gubun'>인증구분</option>";
			sHtml1+="<option value='file_path'>SYSOUT 파일경로	</option>"; 
			sHtml1+="<option value='server_lang'>CHARACTER SET</option>";
			sHtml1+="</select>";
			sHtml1+="<input style='height:16px; margin-right:5px;' type='text' id='list' name='list' />"; 
			sHtml1+="<span id='btn_udt_2' style='height:23px'>일괄 적용</span>";
			sHtml1+="</div>"; 
			sHtml1+="</td>";
			sHtml1+="<td style='height:100%;width:50%;text-align:right;'>"; 
		}else{
			sHtml1+="<td style='height:100%;width:100%;text-align:right;'>";	  		
		}
		sHtml1+="<div>";
		sHtml1+="<b>C-M : </b><select name='app_grp_data_center' id='app_grp_data_center' style='height:23px;'>"; 
		sHtml1+="<option value=''>--선택--</option>";
		<c:forEach var="cm" items="${cm}" varStatus="status">
			sHtml1+="<option value='${cm.scode_cd},${cm.scode_eng_nm}'>${cm.scode_nm}</option>"
		</c:forEach>;
		sHtml1+="</select>";
		sHtml1+="&nbsp;<b>"+title+"명 : </b><input type='text' name='p_code_name' id='p_code_name' value='' />";
		sHtml1+="&nbsp;&nbsp;<span id='btn_code_search' style='height:21px'>검색</span>";
		sHtml1+="</div>";
		sHtml1+="</td>";
		sHtml1+="</tr>"; // /tr
		
		sHtml1+="<tr style='height:480px;'>"; // tr
		sHtml1+="<td id='ly_appGrpCodeGrid' style='vertical-align:top;' colspan=2>";
		sHtml1+="<div id='appGrpCodeGrid' class='ui-widget-header ui-corner-all'></div>";
		sHtml1+="</td>";
		sHtml1+="</tr>"; // /tr
		sHtml1+="<tr style='height:5px;'>"; // tr
		if(gb == 'host'){
			sHtml1+="<td style='vertical-align:top;'>"; // td 
			sHtml1+="<h5 class='ui-corner-all' >";
			sHtml1+="<div id='ly_code_total_cnt' style='padding:5px;float:left;'></div>";
			sHtml1+="</h5>";
			sHtml1+="</td>"; // /td
		}
		sHtml1+="<td style='vertical-align:top;'>"; // td
		sHtml1+="<div align='right' style='padding:3px;'><span id='btn_code_insert'>"+title+"이관</span><span id='btn_code_close'>닫기</span></div>";
		sHtml1+="</td>"; // /tb
		sHtml1+="</tr>"; //tr 3 끝
		sHtml1+="</table>"; //table 끝
		
		sHtml1+="</form>";
		sHtml1+="</div>";
		
		$('#cmAppGrpCode').remove();
		$('body').append(sHtml1);
		
		if(gb == 'host'){
			dlPop02('cmAppGrpCode',title+"검색",1300,580,true);  
		}else if(gb == 'owner'){
			dlPop02('cmAppGrpCode',title+"검색",400,550,true);  
		}
		
		var gridObj = {
			id : "appGrpCodeGrid"
			,rows:[]
			,vscroll:false
		};
		
		var codeColModel = [];
		if (gb == 'host') {
			codeColModel = 
				    [{formatter:gridCellNoneFormatter,field:'grp_cd_check',id:'grp_cd_check',name:'<input type="checkbox" name="checkIdxAll" id="checkIdxAll" onClick="checkAll();">',width:30,headerCssClass:'cellCenter',cssClass:'cellCenter', disabled:true}
					,{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'번호',width:50,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	   				,{formatter:gridCellNoneFormatter,field:'hostname',id:'hostname',name:'호스트명',width:120,headerCssClass:'cellCenter',cssClass:'cellCenter'}
					,{formatter:gridCellNoneFormatter,field:'description',id:'description',name:'설명',width:120,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
					,{formatter:gridCellNoneFormatter,field:'server_gubun',id:'server_gubun',name:'사용구분',width:100,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
					,{formatter:gridCellNoneFormatter,field:'agent_id',id:'agent_id',name:'접속아이디',width:100,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
					,{formatter:gridCellNoneFormatter,field:'agent_pw',id:'agent_pw',name:'접속패스워드',width:100,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
					,{formatter:gridCellNoneFormatter,field:'access_gubun',id:'access_gubun',name:'접근구분',width:100,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
					,{formatter:gridCellNoneFormatter,field:'access_port',id:'access_port',name:'접근포트',width:100,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
					,{formatter:gridCellNoneFormatter,field:'certify_gubun',id:'certify_gubun',name:'인증구분',width:100,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
					,{formatter:gridCellNoneFormatter,field:'file_path',id:'file_path',name:'SYSOUT 파일경로',width:130,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
					,{formatter:gridCellNoneFormatter,field:'server_lang',id:'server_lang',name:'CHARACTER SET',width:130,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}];
		} else if (gb == 'owner') {
			codeColModel = 
					[{formatter:gridCellNoneFormatter,field:'grp_cd_check',id:'grp_cd_check',name:'<input type="checkbox" name="checkIdxAll" id="checkIdxAll" onClick="checkAll();">',width:30,headerCssClass:'cellCenter',cssClass:'cellCenter', disabled:true}
					,{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'번호',width:50,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
					,{formatter:gridCellNoneFormatter,field:'hostname',id:'hostname',name:'호스트명',width:120,headerCssClass:'cellCenter',cssClass:'cellCenter'}
			   		,{formatter:gridCellNoneFormatter,field:'owner',id:'owner',name:'계정',width:120,headerCssClass:'cellCenter',cssClass:'cellCenter'}
					,{formatter:gridCellNoneFormatter,field:'host_cd',id:'host_cd',name:'host_cd',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}];
		} 
		
		gridObj.colModel = codeColModel;
		
		var session_dc_code	= "<%=strSessionDcCode%>";
		
		if(session_dc_code != "") { // 개인정보에 C-M이 등록되어 있을경우
			$("select[name='app_grp_data_center']").val(session_dc_code);
			$("#appGrpCodeForm").find("input[name='app_grp_data_center']").val(session_dc_code); 
		}else { // 개인정보에 C-M이 등록이 되어있지 않을경우 -> C-M 콤보박스에서 첫번째값 선택
			$("select[name='app_grp_data_center'] option:eq(1)").prop("selected", true); 
			$("#appGrpCodeForm").find("input[name='app_grp_data_center']").val($("select[name='app_grp_data_center']").val());
		}
		
		viewGrid_1(gridObj,"ly_"+gridObj.id);
		$("#"+gridObj.id).data('grid').setSelectionModel(new Slick.RowSelectionModel({selectActiveRow: false})); //grid 자체 selection 기능 사용 안함.
		
		$("#btn_search").show();
		
		$("#btn_code_search").button().unbind("click").click(function(){		
			var data_center = $("#app_grp_data_center").val();
			if (data_center == "") {
				alert("C-M 을 선택해 주세요.");
				return;
			}
			$("#job_data_center").val(data_center); //job_data_center에 값 입력(insert에 필요)
			
			cmAppGrpCodeList(gb);
		});
		
		$("#btn_udt_2" ).button().unbind('click').click(function(){
			changeList();
		});
		
        $('#p_code_name').unbind('keypress').keypress(function (e) {
            if (e.keyCode == 13) {
                var data_center = $("#app_grp_data_center").val();
                if (data_center == "") {
                    alert("C-M 을 선택해 주세요.");
                    return;
                }
                $("#job_data_center").val(data_center); //job_data_center에 값 입력(insert에 필요)

                cmAppGrpCodeList(gb);
            }
        });
		
		
		$("#btn_code_insert").button().unbind("click").click(function(){
			
			var chk = $("input[name=grp_cd_check]");
			var hostname_list 		= "";
			var description_list 	= "";
			var server_gubun_list 	= "";
			var agent_id_list 		= "";
			var agent_pw_list 		= "";
			var access_gubun_list 	= "";
			var access_port_list 	= "";
			var certify_gubun_list 	= "";
			var file_path_list 		= "";
			var server_lang_list 	= "";
			var owner_list 			= "";
			var host_cd_list		= "";
			var chk_cnt 			= 0;
			var validation_chk  	= true; 	
			
			var checked_cnt = $('input[name="grp_cd_check"]:checked').length; 
			
			if (checked_cnt < 1) {
				alert("이관할 항목을 선택해주세요.");
				return;
			}
			
			$("select[name=takeOver_server_gubun]").removeAttr('disabled'); 
			
			chk.each(function(i){
				if ($(this).attr("checked")) {
					if (gb == 'host') {
						
						if(!trim($("input[name=takeOver_hostname]").eq(i).val())){
							alert('호스트명은 필수 값입니다');
							$("input[name=takeOver_hostname]").eq(i).focus();
							validation_chk = false;
							return false;   
						}else{
							hostname_list 		+= $("input[name=takeOver_hostname]").eq(i).val() + ",";
						}
						
						if(!trim($("input[name=takeOver_description]").eq(i).val())){
							alert('설명은 필수 값입니다');
							$("input[name=takeOver_description]").eq(i).focus();
							validation_chk = false;
							return false;   
						}else{
							description_list 	+= $("input[name=takeOver_description]").eq(i).val() + ",";
						}
						
						if(!trim($("select[name=takeOver_server_gubun]").eq(i).val())){
							alert('사용구분은 필수 값입니다');
							$("select[name=takeOver_server_gubun]").eq(i).focus();
							validation_chk = false;
							return false;   
						}else{
							server_gubun_list 	+= $("select[name=takeOver_server_gubun]").eq(i).val() + ",";
						}
						
						if(!trim($("input[name=takeOver_agent_id]").eq(i).val())){
							alert('접속아이디는 필수 값입니다');
							$("input[name=takeOver_agent_id]").eq(i).focus();
							validation_chk = false;
							return false;   
						}else{
							agent_id_list 		+= $("input[name=takeOver_agent_id]").eq(i).val() + ",";
						}
						
						if(!trim($("input[name=takeOver_agent_pw]").eq(i).val()) && $("select[name=takeOver_certify_gubun]").eq(i).val() == 'P'){
							alert('접속패스워드는 필수 값입니다');
							$("input[name=takeOver_agent_pw]").eq(i).focus();
							validation_chk = false;
							return false;   
						}else{
							agent_pw_list 		+= $("input[name=takeOver_agent_pw]").eq(i).val() + ",";
						}
						
						if(!trim($("select[name=takeOver_access_gubun]").eq(i).val())){
							alert('접근구분은 필수 값입니다');
							$("select[name=takeOver_access_gubun]").eq(i).focus();
							validation_chk = false;
							return false;   
						}else{
							access_gubun_list 	+= $("select[name=takeOver_access_gubun]").eq(i).val() + ",";
						}
						
						if(!trim($("input[name=takeOver_access_port]").eq(i).val())){
							alert('접근포트는 필수 값입니다');
							$("input[name=takeOver_access_port]").eq(i).focus();
							validation_chk = false;
							return false;   
						}else{
							access_port_list 	+= $("input[name=takeOver_access_port]").eq(i).val() + ",";
						}
						
						if(!trim($("select[name=takeOver_certify_gubun]").eq(i).val())){
							alert('인증구분은 필수 값입니다');
							$("select[name=takeOver_certify_gubun]").eq(i).focus();
							validation_chk = false;
							return false;   
						}else{
							certify_gubun_list 	+= $("select[name=takeOver_certify_gubun]").eq(i).val() + ",";
						}
						
						if(!trim($("input[name=takeOver_file_path]").eq(i).val())){
							alert('SYSOUT 파일경로는 필수 값입니다');
							$("input[name=takeOver_file_path]").eq(i).focus();
							validation_chk = false;
							return false;   
						}else{
							file_path_list 		+= $("input[name=takeOver_file_path]").eq(i).val() + ",";
						}
						
						if(!trim($("select[name=takeOver_server_lang]").eq(i).val())){
							alert('CHARACTER SET은 필수 값입니다');
							$("select[name=takeOver_server_lang]").eq(i).focus();
							validation_chk = false;
							return false;   
						}else{
							server_lang_list 	+= $("select[name=takeOver_server_lang]").eq(i).val() + ",";
						}
						
					} else if(gb == 'owner'){
						owner_list 			+= $("input[name=takeOver_owner]").eq(i).val() + ",";
						host_cd_list 		+= $("input[name=hostCd]").eq(i).val() + ","; 
					}
					chk_cnt++;
					
					if(checked_cnt == chk_cnt){
						hostname_list 		= hostname_list.replace(/,$/, '');
						description_list 	= description_list.replace(/,$/, '');
						server_gubun_list 	= server_gubun_list.replace(/,$/, '');
						agent_id_list 		= agent_id_list.replace(/,$/, '');
						agent_pw_list 		= agent_pw_list.replace(/,$/, '');
						access_gubun_list 	= access_gubun_list.replace(/,$/, '');
						access_port_list 	= access_port_list.replace(/,$/, '');
						certify_gubun_list 	= certify_gubun_list.replace(/,$/, '');
						file_path_list 		= file_path_list.replace(/,$/, '');
						server_lang_list 	= server_lang_list.replace(/,$/, '');
						owner_list 			= owner_list.replace(/,$/, '');
						host_cd_list 		= host_cd_list.replace(/,$/, '');
					}
				}
			});
			
			if(!validation_chk){
				$("select[name=takeOver_server_gubun]").attr('disabled', true);
				return; 
			} 
			
			if (!confirm("선택한 "+title+"을(를) 모두 이관 하시겠습니까?"))
				return;
			
         	var frm = document.appGrpCodeForm;
         	
         	if (gb == 'host') {
         		frm.hostname_arr.value 		= hostname_list;
    	        frm.description_arr.value 	= description_list;
    	        frm.server_gubun_arr.value 	= server_gubun_list;
    	        frm.agent_id_arr.value 		= agent_id_list;
    	        frm.agent_pw_arr.value 		= agent_pw_list;
    	        frm.access_gubun_arr.value 	= access_gubun_list;
    	        frm.access_port_arr.value 	= access_port_list;
    	        frm.certify_gubun_arr.value = certify_gubun_list;
    	        frm.file_path_arr.value 	= file_path_list;
    	        frm.server_lang_arr.value 	= server_lang_list;
         	} else if(gb == 'owner'){
         		frm.owner_arr.value 		= owner_list;
         		frm.host_cd_arr.value 	    = host_cd_list;
         	}
         
         	frm.action = '/tWorks.ez?c=ez013_p';
	        frm.target = 'if1';
	        frm.submit();

		});
		
		$("#btn_code_close").button().unbind("click").click(function(){
			dlClose('cmAppGrpCode');
		});
	}
	
	function changeList(){  
		
		var chk 	= $("input[name=grp_cd_check]");
		var chk_cnt = $("input[name=grp_cd_check]:checked").length;
		
		var chgListValue = $("#list").val();
		var chgList 	 = $("#select").val();
		
		if(chgList == ""){
			alert("변경하실 항목을 선택바랍니다.");
			return;
		}
		
		if(chgListValue == ""){
			alert("변경하실 값을 입력바랍니다.");
			return;
		}
		
		if(chk_cnt < 1) {
			alert("체크된 호스트가 없습니다.");
			return;
		}
		
		//체크된 Row만 일괄수정.
		chk.each(function(i){
			if ($(this).attr("checked")) {
				if((chgList == 'server_gubun') || (chgList == 'access_gubun') || (chgList == 'server_lang') || (chgList == 'certify_gubun')){
						setSelectedText(document.getElementsByName('takeOver_'+chgList)[i], chgListValue);     
				}else{
						document.getElementsByName('takeOver_'+chgList)[i].value = chgListValue;  
				}
			}
		});
	}
	
	function checkAll() {
		var chk 	= $("input[name=grp_cd_check]");
		var chk_all = $("#checkIdxAll");
		
		chk.each(function(){
			if (chk_all.attr("checked") && !$(this).attr("disabled")) {
				$(this).attr("checked", true);
			} else {
				$(this).attr("checked", false);
			}
		});
	}
	
	//호스트, 계정 이관리스트.
	function cmAppGrpCodeList(gb){
		
		var node_id   = $("#takeOver_node_id").val(); 
		var host_cd   = $("#takeOver_host_cd").val();
		var p_code_name = $("#p_code_name").val();
		
		try{viewProgBar(true);}catch(e){}
		$('#ly_code_total_cnt').html('');
		
		if(gb == 'host'){
			var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=ctmHostList&itemGubun=2';
		}else if(gb == 'owner'){
			var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=emOwnerList&itemGubun=2&user_gb=<%=S_USER_GB %>&host_cd='+host_cd+'&node_id='+node_id+'&mcode_cd=${SERVER_MCODE_CD}';
		}
		
		var xhr = new XHRHandler(url, appGrpCodeForm, function(){
			var xmlDoc = this.req.responseXML;
			if (xmlDoc == null) {
				try{viewProgBar(false);}catch(e){}
				alert('세션이 만료되었습니다 다시 로그인해 주세요');
				return false;
			}
			
			if ($(xmlDoc).find('doc').length == 0 && $(xmlDoc).find('error').length > 0) {
				try{viewProgBar(false);}catch(e){}
				alert($(xmlDoc).find('msg_code').text());
				return false;
			}
			
			$(xmlDoc).find('doc').each(function(){
				var items = $(this).find('items');
				var rowObj = new Array();
				
				if (items.attr('cnt') == '0') {
				} else {
					items.find('item').each(function(i){
						if(gb == 'host'){
							var hostname = $(this).find("hostname").text();
							rowObj.push({
								'grid_idx':i+1
// 								,'grp_cd_check'  : "<div class='gridInput_area'><input type='checkbox' name='takeOver_grp_cd_check'></div>"
								,'grp_cd_check'  : "<div class='gridInput_area'><input type='checkbox' name='grp_cd_check'></div>"      
								,'hostname'		 : "<div class='cellContent_1'><input type='text' name='takeOver_hostname' id='"+i+"takeOver_hostname' value='"+hostname+"' style='width:100%;border:0px none;'/></div>"
								,'description'	 : "<div class='cellContent_1'><input type='text' name='takeOver_description' id='"+i+"takeOver_description' style='width:100%;border:0px none;'/></div>"
								,'server_gubun'	 : "<div class='cellContent_1'><select disabled name='takeOver_server_gubun' id='"+i+"takeOver_server_gubun'><option value='A'>AGENT</option><option value='G'>AGENT그룹</option></select></div>"
								,'agent_id'		 : "<div class='cellContent_1'><input type='text' name='takeOver_agent_id' id='"+i+"takeOver_agent_id' style='width:100%;border:0px none;'/></div>"  
								,'agent_pw'		 : "<div class='cellContent_1'><input type='password' name='takeOver_agent_pw' id='"+i+"takeOver_agent_pw' style='width:100%;border:0px none;'/></div>" 
								,'access_gubun'  : "<div class='cellContent_1'><select name='takeOver_access_gubun' id='"+i+"takeOver_access_gubun'><option value=''>--선택--</option><option value='S'>SSH</option><option value='T'>TELNET</option></select></div>"  
								,'access_port'	 : "<div class='cellContent_1'><input type='text' name='takeOver_access_port' id='"+i+"takeOver_access_port' style='width:100%;border:0px none;'/></div>"
								,'certify_gubun' : "<div class='cellContent_1'><select name='takeOver_certify_gubun' id='"+i+"takeOver_certify_gubun'><option value=''>--선택--</option><option value='P'>PASSWORD</option><option value='K'>KEY</option></select></div>"
								,'file_path'	 : "<div class='cellContent_1'><input type='text' name='takeOver_file_path' id='"+i+"takeOver_file_path' style='width:100%;border:0px none;'/></div>"
								,'server_lang'	 : "<div class='cellContent_1'><select name='takeOver_server_lang' id='"+i+"takeOver_server_lang'><option value='U'>UTF-8</option><option value='E'>EUC-KR</option></select></div>"
							});
						}else if(gb == 'owner'){
							var hostname = $(this).find("node_id").text();
							var owner 	 = $(this).find("owner").text();
							var host_cd  = $(this).find("host_cd").text();
							rowObj.push({
								'grid_idx':i+1
// 								,'grp_cd_check' : "<div class='gridInput_area'><input type='checkbox' name='takeOver_grp_cd_check'></div>"
								,'grp_cd_check' : "<div class='gridInput_area'><input type='checkbox' name='grp_cd_check'></div>"  
								,'hostname'		: "<div class='cellContent_1'><input type='text' name='hostname' id='hostname' value='"+hostname+"' style='width:100%;border:0px none;'/></div>"
								,'owner'		: "<div class='cellContent_1'><input type='text' name='takeOver_owner' id='takeOver_owner' value='"+owner+"' style='width:100%;border:0px none;'/></div>"
								,'host_cd'		: "<div class='cellContent_1'><input type='hidden' name='hostCd' id='hostCd' value='"+host_cd+"'/></div>"
							});
						}
					});
				} 
				
				var obj = $("#appGrpCodeGrid").data('gridObj');
				obj.rows = rowObj;
				setGridRows(obj);
				
				items.find('item').each(function(i){  
						var agstat   = $(this).find("agstat").text();  
						if(agstat != '') $('#'+i+'takeOver_server_gubun').val('A').prop("selected",true); 
						if(agstat == '') $('#'+i+'takeOver_server_gubun').val('G').prop("selected",true);
				}); 
				
				$('#ly_code_total_cnt').html('[ TOTAL : '+items.attr('cnt')+' ]');
			});
			try{viewProgBar(false);}catch(e){}
		}
		, null);
		
		xhr.sendRequest();
	}
	
	function grid1Clear() {
		sCodeList(null);
	}
	
	function goCodePrc(gubun,flag,code_cd,code_cd2, host_cd){
			
		var frm = document.frm4;
		var msg = "";
		
		frm.flag.value = flag;
		frm.code_gubun.value = gubun;
				
		if(flag == "ins"){
		
			frm.mcode_cd.value = code_cd2;
			frm.scode_nm.value = document.getElementById('scode_nm'+code_cd).value;
			frm.order_no.value = document.getElementById('order_no'+code_cd).value;
			frm.scode_eng_nm.value = document.getElementById('scode_eng_nm'+code_cd).value;
			frm.scode_desc.value = document.getElementById('scode_desc'+code_cd).value;
			frm.host_cd.value = host_cd;
			
			var v_scode_use_yn = document.getElementById('scode_use_yn'+code_cd);
			frm.scode_use_yn.value = v_scode_use_yn.options[v_scode_use_yn.selectedIndex].value;
			
			if(isNullInput(document.getElementById('scode_nm'+code_cd),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[코드명(한글)]","") %>') ) return;
			if(isNullInput(document.getElementById('scode_eng_nm'+code_cd),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[코드명(영문)]","") %>') ) return;
			if(isNullInput(document.getElementById('order_no'+code_cd),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[순서]","") %>') ) return;
			if(document.getElementById('scode_use_yn'+code_cd).value == ""){
				alert('<%=CommonUtil.getMessageSplit("ERROR.PARAM.02","[사용구분]","") %>'); 
				return;
			}		
			
			if(!confirm('<%=CommonUtil.getMessage("DEBUG.15") %>') ) return;
			
		}else if(flag == "udt"){
					
			frm.scode_cd.value = code_cd;
			frm.mcode_cd.value = code_cd2;
			frm.order_no.value = document.getElementById('order_no'+code_cd).value;
			frm.scode_nm.value = document.getElementById('scode_nm'+code_cd).value;
			frm.scode_eng_nm.value = document.getElementById('scode_eng_nm'+code_cd).value;
			frm.scode_desc.value = document.getElementById('scode_desc'+code_cd).value;
			frm.host_cd.value = host_cd;
			
			var v_scode_use_yn = document.getElementById('scode_use_yn'+code_cd);
			frm.scode_use_yn.value = v_scode_use_yn.options[v_scode_use_yn.selectedIndex].value;			
			
			if(!confirm('<%=CommonUtil.getMessage("DEBUG.14") %>') ) return;
			
		}else if(flag == "del"){
			frm.mcode_cd.value = code_cd2;
			frm.scode_cd.value = code_cd;		
			frm.host_cd.value = host_cd;			
			
			if(!confirm('<%=CommonUtil.getMessage("DEBUG.07") %>') ) return;
		}else if(flag == "group_udt") {
			var arr_scode_cd = code_cd.split(",");
			var arr_order_no	 = "";
			var arr_scode_nm	 = "";
			var arr_scode_eng	 = "";
			var arr_scode_desc	 = "";
			var arr_scode_use_yn = "";
			
			for(var i = 0; i < arr_scode_cd.length; i++){
				if(arr_scode_cd[i] == "0"){
					if(isNullInput(document.getElementById('scode_nm0'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[코드명(한글)]","") %>') ) return;
					if(isNullInput(document.getElementById('scode_eng_nm0'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[코드명(영문)]","") %>') ) return;
					if(isNullInput(document.getElementById('order_no0'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[순서]","") %>') ) return;
				}
				arr_order_no   += "," + document.getElementById('order_no'+arr_scode_cd[i]).value;
				arr_scode_nm   += "," + document.getElementById('scode_nm'+arr_scode_cd[i]).value;
				arr_scode_eng  += "," + document.getElementById('scode_eng_nm'+arr_scode_cd[i]).value;
				arr_scode_desc += "," + document.getElementById('scode_desc'+arr_scode_cd[i]).value;
				
				var v_scode_use_yn = document.getElementById('scode_use_yn'+arr_scode_cd[i]);
				arr_scode_use_yn  +=  "," + v_scode_use_yn.options[v_scode_use_yn.selectedIndex].value;
				
			}
			
			frm.scode_cd.value     = code_cd;
			frm.mcode_cd.value     = code_cd2;
			frm.order_no.value     = arr_order_no.substr(1);
			frm.scode_nm.value	   = arr_scode_nm.substr(1);
			frm.scode_eng_nm.value = arr_scode_eng.substr(1);
			frm.scode_desc.value   = arr_scode_desc.substr(1);
			frm.host_cd.value 	   = host_cd;
			frm.scode_use_yn.value = arr_scode_use_yn.substr(1);
			
			if(!confirm('일괄 저장하시겠습니까?') ) return;
		}		
		
		frm.target = "if1";
		frm.action = "<%=sContextPath%>/common.ez?c=ezComCode_p";
		frm.submit();
		
	}
</script>
