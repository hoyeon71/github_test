<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/jsp/common/inc/header.jsp"%>

<c:set var="mcode_gb_cd" value="${fn:split(MCODE_GB_CD,',')}"/>
<c:set var="mcode_gb_nm" value="${fn:split(MCODE_GB_NM,',')}"/>

<%
	Map<String, Object> paramMap = CommonUtil.collectParameters(request);
	String c = CommonUtil.isNull(paramMap.get("c"));
	String gridId_1 = "g_"+c+"_1";
	String gridId_2 = "g_"+c+"_2";
	
	String menu_gb = CommonUtil.getMessage("CATEGORY.GB.06.GB."+CommonUtil.isNull(paramMap.get("menu_gb")));
	String[] arr_menu_gb = menu_gb.split(",");
%>

<form id="f_s" name="f_s" method="post" onsubmit="return false;">	
</form>

<form id="frm1" name="frm1" method="post" onsubmit="return false;">	
	<input type="hidden" name="flag" id="flag"/>
	<input type="hidden" name="code_gubun" id="code_gubun"/>
	<input type="hidden" name="mcode_cd" id="mcode_cd"/>
	<input type="hidden" name="mcode_nm" id="mcode_nm"/>
	<input type="hidden" name="mcode_desc" id="mcode_desc"/>
	<input type="hidden" name="del_yn" id="del_yn" />
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
				<div id='t_<%=gridId_1 %>' class='title_area' >
					<span><%=CommonUtil.isNull(CommonUtil.getMessage("CATEGORY.GB.06"))%> > <%=CommonUtil.isNull(arr_menu_gb[0]) %></span>
				</div>
			</h4>
		</td>
	</tr>	
	<tr><td style="height:1%"></td></tr>
	<tr>
		<td>그룹정보</td>
	</tr>
	<tr style="height:40%">
		<td style='vertical-align:top;'>
			<table style="width:100%;height:100%;border:none;">
				<tr>					
					<td id='ly_<%=gridId_1 %>' style='vertical-align:top;'>
						<div id="<%=gridId_1 %>" class="ui-widget-header ui-corner-all"></div>
					</td>					
				</tr>
				<tr style='height:10px;'>
					<td style='vertical-align:top;'>
						<h4 class="ui-widget-header ui-corner-all">
							<div align='right' class='btn_area'>
								<div id='ly_total_cnt_1' style='padding-top:5px;float:left;'></div>
							</div>
						</h4>
					</td>
				</tr>
			</table>			
		</td>
	</tr>
	<tr><td style="height:1%"></td></tr>
	<tr>
		<td>코드정보</td>
	</tr>
	<tr style="height:60%">
		<td style='vertical-align:top;'>
			<table style="width:100%;height:100%;border:none;">
				<tr>					
					<td id='ly_<%=gridId_2 %>' style='vertical-align:top;'>
						<div id="<%=gridId_2 %>" class="ui-widget-header ui-corner-all"></div>
					</td>					
				</tr>
				<tr style='height:10px;'>
					<td style='vertical-align:top;'>
						<h4 class="ui-widget-header ui-corner-all">
							<div align='right' class='btn_area'>
								<span id="btn_add">저장</span>
								<div id='ly_total_cnt_2' style='padding-top:5px;float:left;'></div>
							</div>
						</h4>
					</td>
				</tr>
			</table>
		</td>
	</tr>	
</table>

<script>

	var arr_mcode_gb_cd = new Array();
	var arr_mcode_gb_nm = new Array();
	
	var select_mcode_cd = "";
	
	<c:forEach var="mcode_gb_cd" items="${mcode_gb_cd}" varStatus="s">
		var map_cd = {"cd":"${mcode_gb_cd}"};
		arr_mcode_gb_cd.push(map_cd);
	</c:forEach>
	<c:forEach var="mcode_gb_nm" items="${mcode_gb_nm}" varStatus="s">
		var map_nm = {"nm":"${mcode_gb_nm}"};
		arr_mcode_gb_nm.push(map_nm);
	</c:forEach>

	function gridCellCustomFormatter(row,cell,value,columnDef,dataContext){
		
		var ret = "";
		var mcode_cd = getCellValue(gridObj_1,row,'MCODE_CD');
				
		if(columnDef.id == 'MCODE_CD'){
			ret = "<a href=\"JavaScript:goCodeList('"+mcode_cd+"');\" /><font color='red'>"+value+"</font></a>";
		}
		
		return ret;
	}

	var gridObj_1 = {
		id : "<%=gridId_1 %>"
		,colModel:[
	   		{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'번호',width:50,headerCssClass:'cellCenter',cssClass:'cellCenter'}
	   		,{formatter:gridCellCustomFormatter,field:'MCODE_CD',id:'MCODE_CD',name:'그룹코드',width:80,headerCssClass:'cellCenter',cssClass:'cellCenter'}	 
	   		,{formatter:gridCellNoneFormatter,field:'MCODE_NM',id:'MCODE_NM',name:'그룹코드명',width:180,headerCssClass:'cellCenter',cssClass:'cellLeft'}	
	   			 
	   		,{formatter:gridCellNoneFormatter,field:'MCODE_DESC',id:'MCODE_DESC',name:'설명',width:200,headerCssClass:'cellCenter',cssClass:'cellLeft'}	
	   		,{formatter:gridCellNoneFormatter,field:'PROC',id:'PROC',name:'설정',width:100,headerCssClass:'cellCenter',cssClass:'cellCenter'}	
	   		,{formatter:gridCellNoneFormatter,field:'DEL_YN',id:'DEL_YN',name:'사용구분',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   		
	   	]
		,rows:[]
		,vscroll:<%=S_GRID_VSCROLL%>
	};
	
	var gridObj_2 = {
			id : "<%=gridId_2 %>"
			,colModel:[
		   		{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'번호',width:50,headerCssClass:'cellCenter',cssClass:'cellCenter'}
		   		,{formatter:gridCellNoneFormatter,field:'SCODE_CD',id:'SCODE_CD',name:'코드',width:80,headerCssClass:'cellCenter',cssClass:'cellCenter'}
		   		,{formatter:gridCellNoneFormatter,field:'SCODE_ENG_NM',id:'SCODE_ENG_NM',name:'코드명(KEY)',width:180,headerCssClass:'cellCenter',cssClass:'cellLeft'}
		   		,{formatter:gridCellNoneFormatter,field:'SCODE_NM',id:'SCODE_NM',name:'코드명(VALUE)',width:180,headerCssClass:'cellCenter',cssClass:'cellLeft'}
		   		,{formatter:gridCellNoneFormatter,field:'ORDER_NO',id:'ORDER_NO',name:'순서',width:80,headerCssClass:'cellCenter',cssClass:'cellCenter'}	
		   			 
		   		,{formatter:gridCellNoneFormatter,field:'SCODE_DESC',id:'SCODE_DESC',name:'설명',width:250,headerCssClass:'cellCenter',cssClass:'cellLeft'}	 	 
		   		,{formatter:gridCellNoneFormatter,field:'PROC',id:'PROC',name:'설정',width:100,headerCssClass:'cellCenter',cssClass:'cellCenter'}
		   		,{formatter:gridCellNoneFormatter,field:'SCODE_USE_YN',id:'SCODE_USE_YN',name:'사용구분',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
		   		
		   	]
			,rows:[]
			,vscroll:<%=S_GRID_VSCROLL%>
		};
	
	$(document).ready(function(){
		
		$("#btn_add").button().unbind("click").click(function(){
			var str_scode_cd	 = "";
			
			for(var i = 0; i < gridObj_2.rows.length; i++) {
				if( i == 0){
					if($("input[name=scode_nm0]").val() != "" || $("input[name=scode_eng_nm0]").val() != ""){ // 코드명(한글, 영문)이 입력되었을 때 
						str_scode_cd += ",0";
					}
				}else {
					var scode_cd = getCellValue(gridObj_2, i, "SCODE_CD");
					str_scode_cd += "," + scode_cd;
				}
			}
			
			// 첫번째 컴마 제거
			str_scode_cd = str_scode_cd.substr(1);
			
			if(gridObj_2.rows.length == 1) { // 코드정보가 비어있을 경우
				str_scode_cd = "0";
			}
			goCodePrc("S", "group_udt", str_scode_cd, select_mcode_cd);
		});
			
		viewGrid_1(gridObj_1,"ly_"+gridObj_1.id);
		mCodeList();
		
		viewGrid_1(gridObj_2,"ly_"+gridObj_2.id);
				
	});
	
	function mCodeList(){
		$("#btn_add").hide();
		select_mcode_cd = "";
		
		try{viewProgBar(true);}catch(e){}
		$('#ly_total_cnt_1').html('');
		
		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=mCodeList&admin=Y';
		
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
						
						var v_mcode_nm = "<div class='gridInput_area'><input type='text' name='mcode_nm0' id='mcode_nm0' style='width:100%;'/></div>";
						var v_mcode_desc = "<div class='gridInput_area'><input type='text' name='mcode_desc0' id='mcode_desc0' style='width:100%;'/></div>";
						//var v_mcode_sub_cd = "<div class='gridInput_area'><input type='text' name='mcode_sub_cd0' id='mcode_sub_cd0' style='width:60%;'/>&nbsp;</div>";
						var v_proc = "<div><a href=\"javascript:goCodePrc('M','ins','0','');\"><font color='red'>[추가]</font></a></div>";
						var v_del_yn = "";
						v_del_yn += "<div class='gridInput_area'><select name='del_yn0' id='del_yn0' style='width:100%;'>";
						v_del_yn += "<option value='N'>사용</option>";
						v_del_yn += "<option value='Y'>미사용</option>";
						v_del_yn += "</select></div>";
						
						rowsObj.push({
							'grid_idx':''
							,'MCODE_CD':''
							,'MCODE_NM': v_mcode_nm
							,'MCODE_DESC': v_mcode_desc
							,'DEL_YN': v_del_yn
							,'PROC': v_proc
						});	
						
						if(items.attr('cnt')=='0'){
						}else{
							items.find('item').each(function(i){						
							
								var mcode_cd = $(this).find("MCODE_CD").text();
								var mcode_nm = $(this).find("MCODE_NM").text();
								var del_yn = $(this).find("DEL_YN").text();
								var mcode_desc = $(this).find("MCODE_DESC").text();			
								//var mcode_sub_cd = $(this).find("MCODE_SUB_CD").text();		
								var proc = "";
								
								var v_mcode_nm = "<div class='gridInput_area'><input type='text' name='mcode_nm"+mcode_cd+"' id='mcode_nm"+mcode_cd+"' style='width:100%;' value='"+mcode_nm+"'/></div>";
								//var v_proc = "<div><a href=\"javascript:goCodePrc('M','udt','"+mcode_cd+"','');\"><font color='red'>[수정]</font></a></div>";
								var v_proc = "<div><a href=\"javascript:goCodePrc('M','udt','"+mcode_cd+"','');\"><font color='red'>[수정]</font></a>&nbsp;&nbsp;<a href=\"javascript:goCodePrc('M','del','"+mcode_cd+"','');\"><font color='red'>[삭제]</font></a></div>";
								var v_mcode_desc = "<div class='gridInput_area'><input type='text' name='mcode_desc"+mcode_cd+"' id='mcode_desc"+mcode_cd+"' style='width:100%;' value='"+mcode_desc+"'/></div>";
								//var v_mcode_sub_cd = "<div class='gridInput_area'><input type='hidden' name='mcode_sub_cd"+mcode_cd+"' id='mcode_sub_cd"+mcode_cd+"' style='width:100%;' value='"+mcode_sub_cd+"'/></div>";
								
								v_del_yn = "";
								v_del_yn += "<div class='gridInput_area'><select name='del_yn"+mcode_cd+"' id='del_yn"+mcode_cd+"' style='width:100%;'>";
								
								if(del_yn == "N"){
									v_del_yn += "<option value='N' selected>사용</option>";
									v_del_yn += "<option value='Y'>미사용</option>";	
								}else{
									v_del_yn += "<option value='N'>사용</option>";
									v_del_yn += "<option value='Y' selected>미사용</option>";	
								}
								
								v_del_yn += "</select></div>";								
								//$("#del_yn"+mcode_cd).val(del_yn);
								
								rowsObj.push({
									'grid_idx':i+1
									,'MCODE_CD': mcode_cd
									,'MCODE_NM': v_mcode_nm
									,'MCODE_DESC': v_mcode_desc
									,'DEL_YN': v_del_yn									
									,'PROC': v_proc
								});
								
							});						
						}
						
						gridObj_1.rows = rowsObj;
						setGridRows(gridObj_1);
						$('#ly_total_cnt_1').html('[ TOTAL : '+items.attr('cnt')+' ]');
						
					});
					try{viewProgBar(false);}catch(e){}
				}
		, null );
		
		xhr.sendRequest();
		
		clearSlickGridData(gridObj_2); 
	}
	
	function sCodeList(mcode_cd){
		
		select_mcode_cd = mcode_cd;
		
		try{viewProgBar(true);}catch(e){}
		$('#ly_total_cnt_2').html('');
		
		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=sCodeList&admin=Y&host_eng_nm=N&mcode_cd='+mcode_cd;
		
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
						var v_proc = "<div><a href=\"javascript:goCodePrc('S','ins','0','"+mcode_cd+"');\"><font color='red'>[추가]</font></a></div>";
						var v_scode_use_yn = "";
						v_scode_use_yn += "<div><select name='scode_use_yn0' id='scode_use_yn0' style='width:50px;'>";
						v_scode_use_yn += "<option value='Y'>사용</option>";
						v_scode_use_yn += "<option value='N'>미사용</option>";
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
								var proc = "";
								
								var v_scode_nm = "<div class='gridInput_area'><input type='text' name='scode_nm"+scode_cd+"' id='scode_nm"+scode_cd+"' style='width:100%;' value='"+scode_nm+"'/></div>";
								var v_scode_eng_nm = "<div class='gridInput_area'><input type='text' name='scode_eng_nm"+scode_cd+"' id='scode_eng_nm"+scode_cd+"' style='width:100%;' value='"+scode_eng_nm+"'/></div>";
								var v_order_no = "<div class='gridInput_area'><input type='text' name='order_no"+scode_cd+"' id='order_no"+scode_cd+"' value='"+order_no+"' size='3'/></div>";
								var v_scode_desc = "<div class='gridInput_area'><input type='text' name='scode_desc"+scode_cd+"' id='scode_desc"+scode_cd+"' value='"+scode_desc+"' style='width:100%;'/></div>";
								
								var v_proc = "<div><a href=\"javascript:goCodePrc('S','udt','"+scode_cd+"','"+mcode_cd+"');\"><font color='red'>[수정]</font></a>&nbsp;&nbsp;<a href=\"javascript:goCodePrc('S','del','"+scode_cd+"','"+mcode_cd+"');\"><font color='red'>[삭제]</font></a></div>";
								var v_scode_use_yn = "";
								v_scode_use_yn += "<div><select name='scode_use_yn"+scode_cd+"' id='scode_use_yn"+scode_cd+"' style='width:50px;'>";
								
								if(scode_use_yn == "Y"){
									v_scode_use_yn += "<option value='Y' selected>사용</option>";
								}else{
									v_scode_use_yn += "<option value='Y'>사용</option>";
								}
								if(scode_use_yn == "N"){
									v_scode_use_yn += "<option value='N' selected>미사용</option>";
								}else{
									v_scode_use_yn += "<option value='N'>미사용</option>";
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
								});
								
							});						
						}
						$("#btn_add").show();
						gridObj_2.rows = rowsObj;
						setGridRows(gridObj_2);
						$('#ly_total_cnt_2').html('[ TOTAL : '+items.attr('cnt')+' ]');
						
					});
					try{viewProgBar(false);}catch(e){}
				}
		, null );
		
		xhr.sendRequest();
	}
	
	function goCodePrc(gubun,flag,code_cd,code_cd2){
		
		var frm = document.frm1;
		var msg = "";
		
		frm.flag.value = flag;
		frm.code_gubun.value = gubun;
				
		if(flag == "ins"){
			if(gubun == "M"){
				frm.mcode_nm.value = document.getElementById('mcode_nm'+code_cd).value;
				frm.mcode_desc.value = document.getElementById('mcode_desc'+code_cd).value;
				//frm.mcode_sub_cd.value = document.getElementById('mcode_sub_cd'+code_cd).value;
				
				var v_del_yn = document.getElementById('del_yn'+code_cd);				
				frm.del_yn.value = v_del_yn.options[v_del_yn.selectedIndex].value;
				
				if(isNullInput(document.getElementById('mcode_nm'+code_cd),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[그룹코드명]","") %>') ) return;
				if(document.getElementById('del_yn'+code_cd).value == ""){
					alert('<%=CommonUtil.getMessageSplit("ERROR.PARAM.02","[사용구분]","") %>'); 
					return;
				}
			}else if(gubun == "S"){
				frm.mcode_cd.value = code_cd2;
				frm.scode_nm.value = document.getElementById('scode_nm'+code_cd).value;
				frm.order_no.value = document.getElementById('order_no'+code_cd).value;
				frm.scode_eng_nm.value = document.getElementById('scode_eng_nm'+code_cd).value;
				frm.scode_desc.value = document.getElementById('scode_desc'+code_cd).value;
				
				var v_scode_use_yn = document.getElementById('scode_use_yn'+code_cd);
				frm.scode_use_yn.value = v_scode_use_yn.options[v_scode_use_yn.selectedIndex].value;
				
				if(isNullInput(document.getElementById('scode_eng_nm'+code_cd),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[코드명(KEY)]","") %>') ) return;
				if(isNullInput(document.getElementById('scode_nm'+code_cd),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[코드명(VALUE)]","") %>') ) return;
				if(isNullInput(document.getElementById('order_no'+code_cd),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[순서]","") %>') ) return;
				if(document.getElementById('scode_use_yn'+code_cd).value == ""){
					alert('<%=CommonUtil.getMessageSplit("ERROR.PARAM.02","[사용구분]","") %>'); 
					return;
				}
			}
			
			if(!confirm('<%=CommonUtil.getMessage("DEBUG.15") %>') ) return;
			
		}else if(flag == "udt"){
			if(gubun == "M"){
				frm.mcode_cd.value = code_cd
				frm.mcode_nm.value = document.getElementById('mcode_nm'+code_cd).value;
				frm.mcode_desc.value = document.getElementById('mcode_desc'+code_cd).value;
				//frm.mcode_sub_cd.value = document.getElementById('mcode_sub_cd'+code_cd).value;
				var v_del_yn = document.getElementById('del_yn'+code_cd);				
				//frm.del_yn.value = v_del_yn.options[v_del_yn.selectedIndex].value;
				frm.del_yn.value = document.getElementById('del_yn'+code_cd).value;
				
			}else if(gubun == "S"){				
				frm.scode_cd.value = code_cd;
				frm.mcode_cd.value = code_cd2;
				frm.order_no.value = document.getElementById('order_no'+code_cd).value;
				frm.scode_nm.value = document.getElementById('scode_nm'+code_cd).value;
				frm.scode_eng_nm.value = document.getElementById('scode_eng_nm'+code_cd).value;
				frm.scode_desc.value = document.getElementById('scode_desc'+code_cd).value;
				
				var v_scode_use_yn = document.getElementById('scode_use_yn'+code_cd);
				frm.scode_use_yn.value = v_scode_use_yn.options[v_scode_use_yn.selectedIndex].value;
				
			}
			
			if(!confirm('<%=CommonUtil.getMessage("DEBUG.14") %>') ) return;
			
		}else if(flag == "del"){
			if(gubun == "M"){
				frm.mcode_cd.value = code_cd
				frm.mcode_nm.value = document.getElementById('mcode_nm'+code_cd).value;
				frm.del_yn.value = "Y";
				
				if(!confirm('관련된 하위 데이터도 모두 삭제됩니다. 진행하시겠습니까?') ) return;
			}else if(gubun == "S"){
				frm.scode_cd.value = code_cd;		
				frm.mcode_cd.value = code_cd2;
				if(!confirm('<%=CommonUtil.getMessage("DEBUG.07") %>') ) return;
			}
			
		}else if(flag == "group_udt") {
			if(gubun == "S") {
				var arr_scode_cd   	 = code_cd.split(",");
				var arr_order_no	 = "";
				var arr_scode_nm	 = "";
				var arr_scode_eng	 = "";
				var arr_scode_desc	 = "";
				var arr_scode_use_yn = "";
				
				for(var i = 0; i < arr_scode_cd.length; i++){
					if(arr_scode_cd[i] == "0"){
						if(isNullInput(document.getElementById('scode_eng_nm0'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[코드명(KEY)]","") %>') ) return;
						if(isNullInput(document.getElementById('scode_nm0'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[코드명(VALUE)]","") %>') ) return;
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
				frm.scode_use_yn.value = arr_scode_use_yn.substr(1);
				
				if(!confirm('일괄 저장하시겠습니까?') ) return;
			}
		}
		
		frm.target = "if1";
		frm.action = "<%=sContextPath%>/common.ez?c=ezComCode_p";
		frm.submit();
		
	}
	
	function goCodeList(mcode_cd){
		sCodeList(mcode_cd);
	}
		
</script>

<script type="text/javascript" >
<!--
	var prcFrameId= "prcFrameA01";
	$(window).load(function(){
		$('body').css({'visibility':'visible'});
	});
	
//-->
</script>
<%@include file="/jsp/common/inc/progBar.jsp"  %>
<iframe name="if1" id="if1" width="0" height="0"></iframe>
</body>
</html>
