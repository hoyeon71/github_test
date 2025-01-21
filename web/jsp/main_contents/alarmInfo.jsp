<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/jsp/common/inc/header.jsp"%>
<%@include file="/jsp/common/inc/hint.jsp"%>
<%@ page import="com.ghayoun.ezjobs.t.domain.*" %>

<%
	Map<String, Object> paramMap = CommonUtil.collectParameters(request);

	String c 		= CommonUtil.isNull(paramMap.get("c"));
	String gridId 	= "g_"+c;
	String gridId_1 = "g_"+c+"_1";
	
	String menu_gb 			= CommonUtil.getMessage("CATEGORY.GB.06.GB.0620");
	String[] arr_menu_gb 	= menu_gb.split(",");
	List alarmInfo			= (List)request.getAttribute("alarmInfo");
%>

<form id="frm1" name="frm1" method="post" onsubmit="return false;">
	<input type="hidden" name="flag" />
	<input type="hidden" name="alarm_seq" />
	<input type="hidden" name="row_num" />
	<input type="hidden" name="alarm_standard" />
	<input type="hidden" name="alarm_min" />
	<input type="hidden" name="alarm_max" />
	<input type="hidden" name="alarm_unit" />
	<input type="hidden" name="alarm_time" />
	<input type="hidden" name="alarm_over" />
	<input type="hidden" name="alarm_over_time" />
</form>

<table style='width:100%;height:100%;border:none;'>
	<tr style='height:10px;'>
		<td style='vertical-align:top;' colspan="2">
			<h4 class="ui-widget-header ui-corner-all"  >
				<div id='t_<%=gridId %>' class='title_area' >
					<span><%=CommonUtil.isNull(CommonUtil.getMessage("CATEGORY.GB.06"))%> > <%=CommonUtil.isNull(arr_menu_gb[0]) %></span>
				</div>
			</h4>
		</td>
	</tr>
	<tr>
		<td style='vertical-align:top; width:100%;'>
			<table style="width:100%;height:100%;">
				<tr>
					<td id='ly_<%=gridId_1 %>' style='vertical-align:top;' >
						<div id="<%=gridId_1 %>" class="ui-widget-header ui-corner-all"></div>
					</td>					
				</tr>
			</table>
		</td>
	</tr>
</table>
<iframe name="if1" id="if1" width="0" height="0" frameborder='0'></iframe>
<script> 

	var gridObj_1 = {
		id : "<%=gridId_1 %>"
		,colModel:[ 
			{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'순번',width:80,headerCssClass:'cellCenter',cssClass:'cellCenter'}
	   		,{formatter:gridCellNoneFormatter,field:'ALARM_STANDARD',id:'ALARM_STANDARD',name:'알림기준',width:200,headerCssClass:'cellCenter',cssClass:'cellCenter'}
	   		,{formatter:gridCellNoneFormatter,field:'ALARM_MIN',id:'ALARM_MIN',name:'알림기준최소',width:100,headerCssClass:'cellCenter',cssClass:'cellLeft'}
	   		,{formatter:gridCellNoneFormatter,field:'ALARM_MAX',id:'ALARM_MAX',name:'알림기준최대',width:100,headerCssClass:'cellCenter',cssClass:'cellLeft'}
	   		,{formatter:gridCellNoneFormatter,field:'ALARM_UNIT',id:'ALARM_UNIT',name:'알림기준단위',width:130,headerCssClass:'cellCenter',cssClass:'cellCenter'}
	   		,{formatter:gridCellNoneFormatter,field:'ALARM_TIME',id:'ALARM_TIME',name:'알림시기',width:130,headerCssClass:'cellCenter',cssClass:'cellCenter'}
	   		,{formatter:gridCellNoneFormatter,field:'ALARM_OVER',id:'ALARM_OVER',name:'알림OVER시간',width:130,headerCssClass:'cellCenter',cssClass:'cellCenter'}
	   		,{formatter:gridCellNoneFormatter,field:'ALARM_OVER_TIME',id:'ALARM_OVER_TIME',name:'알림OVER시간단위',width:130,headerCssClass:'cellCenter',cssClass:'cellCenter'}
	   		,{formatter:gridCellNoneFormatter,field:'SETTINGS',id:'SETTINGS',name:'설정',width:160,headerCssClass:'cellCenter',cssClass:'cellCenter'}

	   		,{formatter:gridCellNoneFormatter,field:'ROW_NUM',id:'ROW_NUM',name:'ROW_NUM',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   	]
		,rows:[]
		,vscroll:<%=S_GRID_VSCROLL%>
	};
	
	$(document).ready(function(){
		viewGrid_1(gridObj_1,"ly_"+gridObj_1.id);
		adminApprovalGroupList();
	});
	
	function adminApprovalGroupList(){
		
		try{viewProgBar(true);}catch(e){}
		$('#ly_total_cnt').html('');
		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=alarmInfo';
		
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
						return false;
					}
					$(xmlDoc).find('doc').each(function(){
						
						var items = $(this).find('items');
						var rowsObj = new Array();
						
						var inputAlarm_standard = "";
						inputAlarm_standard += "<div class='gridInput_area'>"
						inputAlarm_standard += "<input type='text' id='alarm_standard_0' name='alarm_standard_0' value='' style='width:100%;'/></div>";
						
						var inputAlarm_min = "";
						inputAlarm_min += "<div class='gridInput_area'>"
						inputAlarm_min += "<input type='text' id='alarm_min_0' name='alarm_min_0' value='' style='width:100%;'/></div>";
						
						var inputAlarm_max = "";
						inputAlarm_max += "<div class='gridInput_area'>"
						inputAlarm_max += "<input type='text' id='alarm_max_0' name='alarm_max_0' value='' style='width:100%;'/></div>";
						
						var alarm_unit = "";
						alarm_unit += "<div class='gridInput_area'><select name='alarm_unit_0' id='alarm_unit_0' style='width:100%;'>";
						alarm_unit += "<option value='min' selected>분</option>";
						alarm_unit += "<option value='hour'>시간</option>";
						alarm_unit += "</select></div>";

						var alarm_time = "";
						alarm_time += "<div class='gridInput_area'><select name='alarm_time_0' id='alarm_time_0' style='width:100%;'>";
						alarm_time += "<option value='perform' selected >수행시간</option>";
						alarm_time += "<option value='average'>평균시간</option>";
						alarm_time += "</select></div>";
						
						var inputAlarm_over = "";
						inputAlarm_over += "<div class='gridInput_area'>"
						inputAlarm_over += "<input type='text' id='alarm_over_0' name='alarm_over_0' value='' style='width:100%;'/></div>";

						var alarm_over_time = "";
						alarm_over_time += "<div class='gridInput_area'><select name='alarm_over_time_0' id='alarm_over_time_0' style='width:100%;'>";
						alarm_over_time += "<option value='min' selected>분</option>";
						alarm_over_time += "<option value='hour'>시간</option>";
						alarm_over_time += "</select></div>";
						
						var inputPrc = "";
						inputPrc += "<div><a href=\"javascript:goProc('ins','0');\"><font color='red'>[추가]</font></a></div>";
							
						rowsObj.push({
							'grid_idx': ""
							,'ALARM_STANDARD': inputAlarm_standard
							,'ALARM_MIN': inputAlarm_min
							,'ALARM_MAX': inputAlarm_max
							,'ALARM_UNIT': alarm_unit
							,'ALARM_TIME': alarm_time
							,'ALARM_OVER': inputAlarm_over
							,'ALARM_OVER_TIME': alarm_over_time
							,'SETTINGS': inputPrc
						});
						
						if(items.attr('cnt')=='0'){
						}else{
							items.find('item').each(function(i){						
								
								var alarm_seq			= $(this).find("ALARM_SEQ").text();
								var alarm_standard		= $(this).find("ALARM_STANDARD").text();
								var alarm_min	 		= $(this).find("ALARM_MIN").text();
								var alarm_max	 		= $(this).find("ALARM_MAX").text();
								var alarm_unit_chk	 	= $(this).find("ALARM_UNIT").text();
								var alarm_time_chk		= $(this).find("ALARM_TIME").text();
								var alarm_over			= $(this).find("ALARM_OVER").text();
								var alarm_over_time_chk	= $(this).find("ALARM_OVER_TIME").text();
																
								var inputAlarm_standard = "";
								inputAlarm_standard += "<div class='gridInput_area'>"
								inputAlarm_standard += "<input type='text' id='alarm_standard_"+alarm_seq+"' name='alarm_standard_"+alarm_seq+"' value='"+alarm_standard+"' style='width:100%;'/></div>";
								
								var inputAlarm_min = "";
								inputAlarm_min += "<div class='gridInput_area'>"   
								inputAlarm_min += "<input type='text' id='alarm_min_"+alarm_seq+"' name='alarm_min_"+alarm_seq+"' value='"+alarm_min+"' style='width:100%;'/></div>"; 
				
								var inputAlarm_max = "";
								inputAlarm_max += "<div class='gridInput_area'>"
								inputAlarm_max += "<input type='text' id='alarm_max_"+alarm_seq+"' name='alarm_max_"+alarm_seq+"' value='"+alarm_max+"' style='width:100%;'/></div>";

								var alarm_unit = "";
								alarm_unit += "<div class='gridInput_area'><select name='alarm_unit_"+alarm_seq+"' id='alarm_unit_"+alarm_seq+"' style='width:100%;'>";
								if(alarm_unit_chk == 'min'){
									alarm_unit += "<option value='min' selected>분</option>";
									alarm_unit += "<option value='hour'>시간</option>";
								} else {
									alarm_unit += "<option value='min'>분</option>";
									alarm_unit += "<option value='hour' selected>시간</option>";
								}
								alarm_unit += "</select></div>";
								
								var alarm_time = "";
								alarm_time += "<div class='gridInput_area'><select name='alarm_time_"+alarm_seq+"' id='alarm_time_"+alarm_seq+"' style='width:100%;'>";
								if(alarm_time_chk == 'perform'){
									alarm_time += "<option value='perform' selected >수행시간</option>";
									alarm_time += "<option value='average'>평균시간</option>";
								} else {
									alarm_time += "<option value='perform'>수행시간</option>";
									alarm_time += "<option value='average' selected>평균시간</option>";
								}
								alarm_time += "</select></div>";
								
								var inputAlarm_over = "";
								inputAlarm_over += "<div class='gridInput_area'>"
								inputAlarm_over += "<input type='text' id='alarm_over_"+alarm_seq+"' name='alarm_over_"+alarm_seq+"' value='"+alarm_over+"' style='width:100%;'/></div>";

								var alarm_over_time = "";
								alarm_over_time += "<div class='gridInput_area'><select name='alarm_over_time_"+alarm_seq+"' id='alarm_over_time_"+alarm_seq+"' style='width:100%;'>";
								if(alarm_over_time_chk == 'min'){
									alarm_over_time += "<option value='min' selected>분</option>";
									alarm_over_time += "<option value='hour'>시간</option>";
								} else {
									alarm_over_time += "<option value='min'>분</option>";
									alarm_over_time += "<option value='hour'selected>시간</option>";
								}
								alarm_over_time += "</select></div>";
																
								var alarm_prc = "";
								alarm_prc += "<div><a href=\"javascript:goProc('udt','"+alarm_seq+"');\"><font color='red'>[수정]</font></a>&nbsp;&nbsp";
								alarm_prc += "<a href=\"javascript:goProc('del','"+alarm_seq+"');\"><font color='red'>[삭제]</font></a></div>";
								
								rowsObj.push({
									'grid_idx': i+1
									,'ALARM_STANDARD': inputAlarm_standard
									,'ALARM_MIN': inputAlarm_min
									,'ALARM_MAX': inputAlarm_max
									,'ALARM_UNIT': alarm_unit
									,'ALARM_TIME': alarm_time
									,'ALARM_OVER': inputAlarm_over
									,'ALARM_OVER_TIME': alarm_over_time
									,'SETTINGS': alarm_prc
								});
								
							});						
						}
						
						gridObj_1.rows = rowsObj;
						setGridRows(gridObj_1);
												
					});
					try{viewProgBar(false);}catch(e){}
				}
		, null );
		
		xhr.sendRequest();
		
	}
	
	function goProc(flag,row_num){
		var frm = document.frm1;
		
		if( flag=='del'){
			if( !confirm('<%=CommonUtil.getMessage("DEBUG.07") %>') ) return;
		}else{
			if( flag=='udt' ){
				if( !confirm('<%=CommonUtil.getMessage("DEBUG.14") %>') ) return;
			}
		}
		
		frm.flag.value = flag;
		frm.row_num.value = row_num;
		
		frm.alarm_standard.value 	= $("#alarm_standard_"+row_num).val();
		frm.alarm_min.value 		= $("#alarm_min_"+row_num).val()
		frm.alarm_max.value 		= $("#alarm_max_"+row_num).val()
		frm.alarm_unit.value		= $("#alarm_unit_"+row_num).val()
		frm.alarm_time.value 		= $("#alarm_time_"+row_num).val()
		frm.alarm_over.value 		= $("#alarm_over_"+row_num).val()
		frm.alarm_over_time.value 	= $("#alarm_over_time_"+row_num).val()
		
		frm.target = "if1";
		frm.action = "<%=sContextPath%>/tWorks.ez?c=ezAlarmInfoList_p";
		frm.submit();
		
	}
	
</script>