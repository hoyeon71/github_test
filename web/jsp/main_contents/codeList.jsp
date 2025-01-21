<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/jsp/common/inc/header.jsp"%>

<%
	Map<String, Object> paramMap = CommonUtil.collectParameters(request);
	String c = CommonUtil.isNull(paramMap.get("c"));
	String gridId_1 = "g_"+c+"_1";
	String gridId_2 = "g_"+c+"_2";
%>

<form id="f_s" name="f_s" method="post" onsubmit="return false;">	
</form>

<form id="frm1" name="frm1" method="post" onsubmit="return false;">	
	<input type="hidden" name="flag" id="flag"/>
	<input type="hidden" name="code_gubun" id="code_gubun"/>
	<input type="hidden" name="gb" id="gb"/>
	<input type="hidden" name="mcode_cd" id="mcode_cd"/>
	<input type="hidden" name="mcode_nm" id="mcode_nm"/>
	<input type="hidden" name="scode_cd" id="scode_cd"/>
	<input type="hidden" name="scode_nm" id="scode_nm"/>
	<input type="hidden" name="order_no" id="order_no"/>
</form>

<table style='width:100%;height:100%;border:none;'>
	<tr style='height:10px;'>
		<td style='vertical-align:top;' colspan="2">
			<h4 class="ui-widget-header ui-corner-all"  >
				<div id='t_<%=gridId_1 %>' class='title_area' >
					<span><%=CommonUtil.getMessage("CATEGORY.0711") %></span>
				</div>
			</h4>
		</td>
	</tr>	
	<tr>
		<td style="width:49%">
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
		<td style="width:49%">
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
	   		,{formatter:gridCellCustomFormatter,field:'MCODE_CD',id:'MCODE_CD',name:'대메뉴코드',width:100,headerCssClass:'cellCenter',cssClass:'cellCenter'}	 
	   		,{formatter:gridCellNoneFormatter,field:'MCODE_NM',id:'MCODE_NM',name:'대메뉴명',width:180,headerCssClass:'cellCenter',cssClass:'cellLeft'}	
	   		,{formatter:gridCellNoneFormatter,field:'INS_DATE',id:'INS_DATE',name:'등록일',width:100,headerCssClass:'cellCenter',cssClass:'cellCenter'}	 
	   		,{formatter:gridCellNoneFormatter,field:'PROC',id:'PROC',name:'설정',width:100,headerCssClass:'cellCenter',cssClass:'cellCenter'}	   		
	   	]
		,rows:[]
		,vscroll:<%=S_GRID_VSCROLL%>
	};
	
	var gridObj_2 = {
			id : "<%=gridId_2 %>"
			,colModel:[
		   		{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'번호',width:50,headerCssClass:'cellCenter',cssClass:'cellCenter'}
		   		,{formatter:gridCellNoneFormatter,field:'SCODE_CD',id:'SCODE_CD',name:'소메뉴코드',width:100,headerCssClass:'cellCenter',cssClass:'cellCenter'}	 
		   		,{formatter:gridCellNoneFormatter,field:'SCODE_NM',id:'SCODE_NM',name:'소메뉴명',width:180,headerCssClass:'cellCenter',cssClass:'cellLeft'}
		   		,{formatter:gridCellNoneFormatter,field:'ORDER_NO',id:'ORDER_NO',name:'순서',width:80,headerCssClass:'cellCenter',cssClass:'cellCenter'}	 
		   		,{formatter:gridCellNoneFormatter,field:'INS_DATE',id:'INS_DATE',name:'등록일',width:100,headerCssClass:'cellCenter',cssClass:'cellCenter'}	 
		   		,{formatter:gridCellNoneFormatter,field:'PROC',id:'PROC',name:'설정',width:100,headerCssClass:'cellCenter',cssClass:'cellCenter'}	   		
		   		
		   	]
			,rows:[]
			,vscroll:<%=S_GRID_VSCROLL%>
		};
	
	$(document).ready(function(){
			
		viewGrid_1(gridObj_1,"ly_"+gridObj_1.id);
		mCodeList();
		
		viewGrid_1(gridObj_2,"ly_"+gridObj_2.id);
		//sCodeList("");
		
	});
	
	function mCodeList(){
		
		try{viewProgBar(true);}catch(e){}
		$('#ly_total_cnt_1').html('');
		
		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=mCodeList';
		
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
						var v_proc = "<div><a href=\"javascript:goCodePrc('M','ins','0','');\"><font color='red'>[추가]</font></a></div>";
						
						rowsObj.push({
							'grid_idx':''
							,'MCODE_CD':''
							,'MCODE_NM': v_mcode_nm
							,'INS_DATE':''
							,'PROC': v_proc
						});	
						
						if(items.attr('cnt')=='0'){
						}else{
							items.find('item').each(function(i){						
							
								var mcode_cd = $(this).find("MCODE_CD").text();
								var mcode_nm = $(this).find("MCODE_NM").text();
								var ins_date = $(this).find("INS_DATE").text();
								var proc = "";
								
								var v_mcode_nm = "<div class='gridInput_area'><input type='text' name='mcode_nm"+mcode_cd+"' id='mcode_nm"+mcode_cd+"' style='width:100%;' value='"+mcode_nm+"'/></div>";
								var v_proc = "<div><a href=\"javascript:goCodePrc('M','udt','"+mcode_cd+"','');\"><font color='red'>[수정]</font></a>&nbsp;&nbsp;<a href=\"javascript:goCodePrc('M','del','"+mcode_cd+"','');\"><font color='red'>[삭제]</font></a></div>";
								
															
								rowsObj.push({
									'grid_idx':i+1
									,'MCODE_CD': mcode_cd
									,'MCODE_NM': v_mcode_nm
									,'INS_DATE': ins_date
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
	}
	
	function sCodeList(mcode_cd){
		
		try{viewProgBar(true);}catch(e){}
		$('#ly_total_cnt_2').html('');
		
		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=sCodeList&mcode_cd='+mcode_cd;
		
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
						var v_order_no = "<div class='gridInput_area'><input type='text' name='order_no0' id='order_no0' style='width:100%;'/></div>";
						var v_proc = "<div><a href=\"javascript:goCodePrc('S','ins','0','"+mcode_cd+"');\"><font color='red'>[추가]</font></a></div>";
						
						rowsObj.push({
							'grid_idx':''
							,'SCODE_CD':''
							,'SCODE_NM': v_scode_nm
							,'ORDER_NO': v_order_no
							,'INS_DATE':''
							,'PROC': v_proc
						});	
						
						if(items.attr('cnt')=='0'){
						}else{
							items.find('item').each(function(i){						
							
								var scode_cd = $(this).find("SCODE_CD").text();
								var scode_nm = $(this).find("SCODE_NM").text();
								var order_no = $(this).find("ORDER_NO").text();
								var ins_date = $(this).find("INS_DATE").text();
								var proc = "";
								
								var v_scode_nm = "<div class='gridInput_area'><input type='text' name='scode_nm"+scode_cd+"' id='scode_nm"+scode_cd+"' style='width:100%;' value='"+scode_nm+"'/></div>";
								var v_order_no = "<div class='gridInput_area'><input type='text' name='order_no"+scode_cd+"' id='order_no"+scode_cd+"' value='"+order_no+"' size='3'/></div>";
								var v_proc = "<div><a href=\"javascript:goCodePrc('S','udt','"+scode_cd+"','"+mcode_cd+"');\"><font color='red'>[수정]</font></a>&nbsp;&nbsp;<a href=\"javascript:goCodePrc('S','del','"+scode_cd+"','"+mcode_cd+"');\"><font color='red'>[삭제]</font></a></div>";
								
								rowsObj.push({
									'grid_idx':i+1
									,'SCODE_CD': scode_cd
									,'SCODE_NM': v_scode_nm
									,'ORDER_NO': v_order_no
									,'INS_DATE': ins_date
									,'PROC': v_proc
								});
								
							});						
						}
						
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
		
		frm.flag.value = flag;
		frm.code_gubun.value = gubun;
		frm.gb.value = gubun;
		
		if(flag == "ins"){
			if(gubun == "M"){
				frm.mcode_nm.value = document.getElementById('mcode_nm'+code_cd).value;
				if(isNullInput(document.getElementById('mcode_nm'+code_cd),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[대메뉴명]","") %>') ) return;
			}else if(gubun == "S"){
				frm.mcode_cd.value = code_cd2;
				frm.scode_nm.value = document.getElementById('scode_nm'+code_cd).value;
				frm.order_no.value = document.getElementById('order_no'+code_cd).value;
				if( isNullInput(document.getElementById('scode_nm'+code_cd),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[소메뉴명]","") %>') ) return;
				if( isNullInput(document.getElementById('order_no'+code_cd),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[순서]","") %>') ) return;
			}			
			
		}else if(flag == "udt"){
			if(gubun == "M"){
				frm.mcode_cd.value = code_cd
				frm.mcode_nm.value = document.getElementById('mcode_nm'+code_cd).value;
			}else if(gubun == "S"){				
				frm.scode_cd.value = code_cd;
				frm.mcode_cd.value = code_cd2;
				frm.order_no.value = document.getElementById('order_no'+code_cd).value;
				frm.scode_nm.value = document.getElementById('scode_nm'+code_cd).value;
			}
			
			if(!confirm('<%=CommonUtil.getMessage("DEBUG.14") %>') ) return;
		}else if(flag == "del"){
			if(gubun == "M"){
				frm.mcode_cd.value = code_cd				
			}else if(gubun == "S"){
				frm.scode_cd.value = code_cd;		
				frm.mcode_cd.value = code_cd2;
			}
			
			if(!confirm('<%=CommonUtil.getMessage("DEBUG.07") %>') ) return;
		}
		
		frm.target = "if1";
		frm.action = "<%=sContextPath%>/tWorks.ez?c=ez014_p";
		frm.submit();
	}
	
	function goCodeList(mcode_cd){
		sCodeList(mcode_cd);
	}
		
</script>
