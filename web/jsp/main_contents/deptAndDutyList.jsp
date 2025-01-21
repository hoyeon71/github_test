<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/jsp/common/inc/header.jsp"%>

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
	<input type="hidden" name="flag" />
	<input type="hidden" name="gb" />
	
	<input type="hidden" name="dept_cd" />
	<input type="hidden" name="dept_nm" />
	
	<input type="hidden" name="duty_cd" />
	<input type="hidden" name="duty_nm" />

</form>

<table style='width:100%;height:100%;border:none;'>
	<tr style='height:10px;'>
		<td style='vertical-align:top;' colspan="2">
			<h4 class="ui-widget-header ui-corner-all"  >
				<div id='t_<%=gridId_1 %>' class='title_area' >
					<span><%=CommonUtil.isNull(CommonUtil.getMessage("CATEGORY.GB.06"))%> > <%=CommonUtil.isNull(arr_menu_gb[0]) %></span>
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

	var gridObj_1 = {
		id : "<%=gridId_1 %>"
		,colModel:[
	   		{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'번호',width:50,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'DEPT_NM',id:'DEPT_NM',name:'부서명',width:150,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}	 
	   		,{formatter:gridCellNoneFormatter,field:'INS_DATE',id:'INS_DATE',name:'등록일',width:130,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}	 
	   		,{formatter:gridCellNoneFormatter,field:'PROC',id:'PROC',name:'설정',width:150,headerCssClass:'cellCenter',cssClass:'cellCenter'}	   		
	   		   			   			   		
	   		,{formatter:gridCellNoneFormatter,field:'DEPT_CD',id:'DEPT_CD',name:'DEPT_CD',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   	]
		,rows:[]
		,vscroll:<%=S_GRID_VSCROLL%>
	};
	
	var gridObj_2 = {
			id : "<%=gridId_2 %>"
			,colModel:[
		   		{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'번호',width:50,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
		   		,{formatter:gridCellNoneFormatter,field:'DUTY_NM',id:'DUTY_NM',name:'직책명',width:150,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}	 
		   		,{formatter:gridCellNoneFormatter,field:'INS_DATE',id:'INS_DATE',name:'등록일',width:130,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}	 
		   		,{formatter:gridCellNoneFormatter,field:'PROC',id:'PROC',name:'설정',width:150,headerCssClass:'cellCenter',cssClass:'cellCenter'}	   		
		   		   			   			   		
		   		,{formatter:gridCellNoneFormatter,field:'DUTY_CD',id:'DUTY_CD',name:'DUTY_CD',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
		   	]
			,rows:[]
			,vscroll:<%=S_GRID_VSCROLL%>
		};
	
	$(document).ready(function(){
			
		viewGrid_1(gridObj_1,"ly_"+gridObj_1.id);
		deptList();
		
		viewGrid_1(gridObj_2,"ly_"+gridObj_2.id);
		dutyList();
		
	});
	
	function dutyList(){
		
		try{viewProgBar(true);}catch(e){}
		$('#ly_total_cnt_2').html('');
		
		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=dutyList';
		
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
						
						var v_duty_nm = "<div class='gridInput_area'><input type='text' name='duty_nm0' id='duty_nm0' style='width:100%;'/></div>";
						var v_proc = "<div><a href=\"javascript:goDutyPrc('ins','0');\"><font color='red'>[추가]</font></a></div>";
						
						rowsObj.push({
							'grid_idx':''
							,'DUTY_CD':''
							,'DUTY_NM': v_duty_nm
							,'INS_DATE':''
							,'PROC': v_proc
						});	
						
						if(items.attr('cnt')=='0'){
						}else{
							items.find('item').each(function(i){						
							
								var duty_cd = $(this).find("DUTY_CD").text();
								var duty_nm = $(this).find("DUTY_NM").text();
								var ins_date = $(this).find("INS_DATE").text();
								var proc = "";
								
								var v_duty_nm = "<div class='gridInput_area'><input type='text' name='duty_nm"+duty_cd+"' id='duty_nm"+duty_cd+"' style='width:100%;' value='"+duty_nm+"'/></div>";
								var v_proc = "<div><a href=\"javascript:goDutyPrc('udt','"+duty_cd+"');\"><font color='red'>[수정]</font></a>&nbsp;&nbsp;<a href=\"javascript:goDutyPrc('del','"+duty_cd+"');\"><font color='red'>[삭제]</font></a></div>";
								
								rowsObj.push({
									'grid_idx':i+1
									,'DUTY_CD': duty_cd
									,'DUTY_NM': v_duty_nm
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
	
	function deptList(){
		
		try{viewProgBar(true);}catch(e){}
		$('#ly_total_cnt_1').html('');
		
		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=deptList';
		
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
						
						var v_dept_nm = "<div class='gridInput_area'><input type='text' name='dept_nm0' id='dept_nm0' style='width:100%;'/></div>";
						var v_proc = "<div><a href=\"javascript:goDeptPrc('ins','0');\"><font color='red'>[추가]</font></a></div>";
						
						rowsObj.push({
							'grid_idx':''
							,'DEPT_CD':''
							,'DEPT_NM': v_dept_nm
							,'INS_DATE':''
							,'PROC': v_proc
						});	
						
						if(items.attr('cnt')=='0'){
						}else{
							items.find('item').each(function(i){						
							
								var dept_cd = $(this).find("DEPT_CD").text();
								var dept_nm = $(this).find("DEPT_NM").text();
								var ins_date = $(this).find("INS_DATE").text();
								var proc = "";
								
								var v_dept_nm = "<div class='gridInput_area'><input type='text' name='dept_nm"+dept_cd+"' id='dept_nm"+dept_cd+"' style='width:100%;' value='"+dept_nm+"'/></div>";
								var v_proc = "<div><a href=\"javascript:goDeptPrc('udt','"+dept_cd+"');\"><font color='red'>[수정]</font></a>&nbsp;&nbsp;<a href=\"javascript:goDeptPrc('del','"+dept_cd+"');\"><font color='red'>[삭제]</font></a></div>";
								
															
								rowsObj.push({
									'grid_idx':i+1
									,'DEPT_CD': dept_cd
									,'DEPT_NM': v_dept_nm
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
	
	function goDeptPrc(flag,dept_cd){
		
		var frm = document.frm1;
		
		if( flag=='del'){
			if( !confirm('<%=CommonUtil.getMessage("DEBUG.07") %>') ) return;
		}else{
			if( isNullInput(document.getElementById('dept_nm'+dept_cd),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[부서명]","") %>') ) return;
		}
		
		frm.gb.value = "dept";
		frm.flag.value = flag;
		frm.dept_cd.value = dept_cd;
		frm.dept_nm.value = document.getElementById('dept_nm'+dept_cd).value;
		
		frm.target = "if1";
		frm.action = "<%=sContextPath%>/tWorks.ez?c=ez008_p";
		frm.submit();
	}
	
	function goDutyPrc(flag,duty_cd){
		var frm = document.frm1;
		
		if( flag=='del'){
			if( !confirm('<%=CommonUtil.getMessage("DEBUG.07") %>') ) return;
		}else{
			if( isNullInput(document.getElementById('duty_nm'+duty_cd),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[직책명]","") %>') ) return;
		}
		
		frm.gb.value = "duty";
		frm.flag.value = flag;
		frm.duty_cd.value = duty_cd;
		frm.duty_nm.value = document.getElementById('duty_nm'+duty_cd).value;
		
		frm.target = "if1";
		frm.action = "<%=sContextPath%>/tWorks.ez?c=ez008_p";
		frm.submit();		
	}
</script>
