<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/jsp/common/inc/header.jsp"%>

<%
	Map<String, Object> paramMap = CommonUtil.collectParameters(request);
	String c 		= CommonUtil.isNull(paramMap.get("c"));
	String gridId 	= "g_"+c;
	String gridId_1 = "g_"+c+"_1";
	
	String menu_gb = CommonUtil.getMessage("CATEGORY.GB.06.GB."+CommonUtil.isNull(paramMap.get("menu_gb")));
	String[] arr_menu_gb = menu_gb.split(",");	
%>

<form id="f_s" name="f_s" method="post" onsubmit="return false;">
	<input type="hidden" name="data_center" 	id="data_center"/>	
	<input type="hidden" name="p_search_gubun" 	id="p_search_gubun"/>
	<input type="hidden" name="p_search_text" 	id="p_search_text"/>
</form>

<form id="frm4" name="frm4" method="post" onsubmit="return false;">	
	<input type="hidden" name="flag" 		id="flag"/>
	<input type="hidden" name="data_center" id="data_center"/>
	<input type="hidden" name="grpname" 	id="grpname"/>
	<input type="hidden" name="nodeid" 		id="nodeid"/>
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
					<th width="10%"><div class='cellTitle_kang2'>Control-M Server</div></th>
					<td width="25%" style="text-align:left">
						<div class='cellContent_kang'>
						<select id="data_center_items" name="data_center_items" style="width:50%; height:21px;">
							<option value="">--선택--</option>
							<c:forEach var="cm" items="${cm}" varStatus="status">
								<option value="${cm.data_center}">${cm.data_center}</option>
							</c:forEach>
						</select>
						</div>
					</td>
					
					<th width="10%"><div class='cellTitle_kang2'>조건</div></th>
					<td width="25%" style="text-align:left">
						<div class='cellContent_kang'>
						<select name="search_gubun" id="search_gubun" style="width:30%; height:21px;">
							<option value="agent">GRPNAME</option>
						</select>&nbsp;
						<input type="text" name="search_text" value="" id="search_text" style="width:80px; height:21px;" />
						</div>					
					</td>					
				</tr>
				<tr>					
					<td colspan="4" style="text-align:right">
						<span id="btn_search" style='display:none;'>검색</span>
					</td>
				</tr>
			</table>
			</h4>
			</form>
		</td>
	</tr>
	<tr style="height:70%">
		<td id='ly_<%=gridId %>' style='vertical-align:top;'>
			<div id="<%=gridId %>" class="ui-widget-header ui-corner-all"></div>
		</td>
	</tr>	
	<tr><td style="height:1%"></td></tr>	
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
				</div>
			</h4>
		</td>
	</tr>
</table>
<script>
		
	function gridCellCustomFormatter(row, cell, value, columnDef, dataContext) {
		
		var ret 		= "";
		var data_center = getCellValue(gridObj,row,'DATA_CENTER');
		var grpname 	= getCellValue(gridObj,row,'GRPNAME');
		if(columnDef.id == 'GRPNAME'){
			ret = "<a href=\"JavaScript:grpNodeList('"+grpname+"');\" /><font color='red'>"+value+"</font></a>";
		}
				
		return ret;
	}
	
	var gridObj = {
		id : "<%=gridId %>"
		,colModel:[
	   		{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'번호',width:50,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'DATA_CENTER',id:'DATA_CENTER',name:'Control-M Server',width:120,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	   		,{formatter:gridCellCustomFormatter,field:'GRPNAME',id:'GRPNAME',name:'Host Group Name',width:150,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'PROC',id:'PROC',name:'설정',width:60,headerCssClass:'cellCenter',cssClass:'cellCenter'}
	   	]
		,rows:[]
		,vscroll:<%=S_GRID_VSCROLL%>
	};
	
	var gridObj_1 = {
		id : "<%=gridId_1 %>"
		,colModel:[
			{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'번호',width:50,headerCssClass:'cellCenter',cssClass:'cellCenter'}				 
			,{formatter:gridCellNoneFormatter,field:'NODEID',id:'NODEID',name:'Associated Hosts',width:180,headerCssClass:'cellCenter',cssClass:'cellLeft'}
			,{formatter:gridCellNoneFormatter,field:'PROC',id:'PROC',name:'설정',width:60,headerCssClass:'cellCenter',cssClass:'cellCenter'}			
	   	]
		,rows:[]
		,vscroll:<%=S_GRID_VSCROLL%>
	};
	
	$(document).ready(function(){
		
		$("#btn_search").show();
		
		var data_center_items = $("select[name='data_center_items'] option:selected").val();
		
		viewGrid_1(gridObj,"ly_"+gridObj.id);
		//hostGrpList();
		
		viewGrid_1(gridObj_1,"ly_"+gridObj_1.id);
		
		$("#btn_search").button().unbind("click").click(function(){
			
			var data_center_items = $("select[name='data_center_items'] option:selected").val();
			
			if ( data_center_items == "" ) {
				alert("Control-M Server를 선택해 주세요.");
				return;
			}
			
			$("#f_s").find("input[name='data_center']").val(data_center_items);
			$("#f_s").find("input[name='p_search_gubun']").val($("#frm1").find("select[name='search_gubun'] option:selected").val());
			$("#f_s").find("input[name='p_search_text']").val($("#frm1").find("input[name='search_text']").val());
						
			hostGrpList();
		});
		
		$('#search_text').unbind('keypress').keypress(function(e){
			if(e.keyCode==13){
				
				var data_center_items = $("select[name='data_center_items'] option:selected").val();
				
				if ( data_center_items == "" ) {
					alert("Control-M Server를 선택해 주세요.");
					return;
				}
				
				$("#f_s").find("input[name='data_center']").val(data_center_items);
				$("#f_s").find("input[name='p_search_gubun']").val($("#frm1").find("select[name='search_gubun'] option:selected").val());
				$("#f_s").find("input[name='p_search_text']").val($("#frm1").find("input[name='search_text']").val());
				
				hostGrpList();
			}
		});		
	});
		
	function hostGrpList(){
		
		$("#f_s").find("input[name='p_search_gubun']").val($("#frm1").find("select[name='search_gubun'] option:selected").val());
		$("#f_s").find("input[name='p_search_text']").val($("#frm1").find("input[name='search_text']").val());
				
		try{viewProgBar(true);}catch(e){}
		$('#ly_total_cnt').html('');
		
		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=hostGrpList&itemGubun=2';
		
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
						
						var v_grpname 	= "<div class='gridInput_area'><input type='text' name='grpname0' id='grpname0' style='width:100%;'/></div>";
						var v_proc 		= "<div><a href=\"javascript:goGrpPrc('ins', '');\"><font color='red'>[추가]</font></a></div>";
// 						var v_proc 		= "<div><a href=\"javascript:goGrpPrc('grp_ins', '');\"><font color='red'>[추가]</font></a></div>";
// 						var v_proc 		= "<div><a href=\"javascript:grpNodeList(document.getElementById('grpname0').value);\"><font color='red'>[추가]</font></a></div>";
// 						var v_proc		= "";
						
						rowsObj.push({
							'grid_idx':''
							,'DATA_CENTER': ''
							,'GRPNAME': v_grpname
							,'PROC': v_proc
						});	
						
						if(items.attr('cnt')=='0'){
						}else{
							items.find('item').each(function(i){
								
								var data_center = $(this).find("DATA_CENTER").text();
								var grpname 	= $(this).find("GRPNAME").text();
								var v_proc 		= "<div><a href=\"javascript:goGrpPrc('grp_del', '"+grpname+"');\"><font color='red'>[삭제]</font></a></div>";
								
								rowsObj.push({
									'grid_idx':i+1
									,'DATA_CENTER': data_center
									,'GRPNAME': grpname		
									,'PROC': v_proc
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
	
	function grpNodeList(grpname){
		
		try{viewProgBar(true);}catch(e){}
		$('#ly_total_cnt_2').html('');
		
		var data_center = $("#f_s").find("input[name='data_center']").val();
		$("#frm4").find("input[name='data_center']").val(data_center);
		
		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=grpNodeList&itemGubun=2&grpname='+grpname+'&data_center='+data_center;
		
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
						
						var v_nodeid 	= "<div class='gridInput_area'><input type='text' name='nodeid0' id='nodeid0' style='width:100%;'/></div>";
						var v_proc 		= "<div><a href=\"javascript:goNodeidPrc('ins', '', '"+grpname+"');\"><font color='red'>[추가]</font></a></div>";
						
						rowsObj.push({
							'grid_idx':''
							,'NODEID': v_nodeid
							,'PROC': v_proc
						});	
						
						if(items.attr('cnt')=='0'){
						}else{
							items.find('item').each(function(i){						
							
								var nodeid 	= $(this).find("NODEID").text();
								var v_proc = "<div><a href=\"javascript:goNodeidPrc('del', '"+nodeid+"', '"+grpname+"');\"><font color='red'>[삭제]</font></a></div>";
																																					
								rowsObj.push({
									'grid_idx':i+1
									,'NODEID': nodeid
									,'PROC': v_proc
								});
								
							});						
						}
						
						gridObj_1.rows = rowsObj;
						setGridRows(gridObj_1);
						$('#ly_total_cnt_2').html('[ TOTAL : '+items.attr('cnt')+' ]');
						
					});
					try{viewProgBar(false);}catch(e){}
				}
		, null );
		
		xhr.sendRequest();
	}
	
	function goGrpPrc(flag, grpname) { 
		
		var frm = document.frm4;
		var msg = "";
		
		frm.flag.value 		= flag;
				
		if(flag == "ins"){
		
			frm.grpname.value = document.getElementById('grpname0').value;
			
			if(isNullInput(document.getElementById('grpname0'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[Host Group Name]","") %>') ) return;
			
			if(!confirm('<%=CommonUtil.getMessage("DEBUG.15") %>') ) return;
			
		}else if(flag == "grp_del"){
			
			frm.grpname.value = grpname;
			
			if(!confirm('<%=CommonUtil.getMessage("DEBUG.07") %>') ) return;
		}
		
		frm.target = "if1";
		frm.action = "<%=sContextPath%>/tWorks.ez?c=ez013_grp_p";
		frm.submit();
	}
	
	function goNodeidPrc(flag, nodeid, grpname) {
			
		var frm = document.frm4;
		var msg = "";
		
		if ( grpname == "" ) {
			grpname = document.getElementById('grpname0').value;
		}
		
		if ( grpname == "" ) {
			alert("Host Group Name을 선택해 주세요.");
			return
		}
		
		frm.flag.value 		= flag;
		frm.grpname.value	= grpname;

		if(flag == "ins"){
		
			frm.nodeid.value = document.getElementById('nodeid0').value;
			
			if(isNullInput(document.getElementById('nodeid0'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[Associated Hosts]","") %>') ) return;
			
			if(!confirm('<%=CommonUtil.getMessage("DEBUG.15") %>') ) return;
			
		}else if(flag == "del"){
			
			frm.nodeid.value = nodeid;
			
			if(!confirm('<%=CommonUtil.getMessage("DEBUG.07") %>') ) return;
		}		
		
		frm.target = "if1";
		frm.action = "<%=sContextPath%>/tWorks.ez?c=ez013_grp_p";
		frm.submit();
	}
</script>
