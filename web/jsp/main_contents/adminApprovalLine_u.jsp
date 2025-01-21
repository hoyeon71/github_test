<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/jsp/common/inc/header.jsp"%>

<%
	Map<String, Object> paramMap = CommonUtil.collectParameters(request);

	String c 		= CommonUtil.isNull(paramMap.get("c"));
	String gridId 	= "g_"+c;
	String gridId_1 = "g_"+c+"_1";
	String gridId_2 = "g_"+c+"_2";
	
	String menu_gb 			= CommonUtil.getMessage("CATEGORY.GB.08.GB.0803");
	String[] arr_menu_gb 	= menu_gb.split(",");

	// 세션값 가져오기.
	String strSessionDcCode 	= S_D_C_CODE;
%>
<c:set var="approval_type_cd" 		value="${fn:split(APPROVAL_TYPE_CD,',')}"/>
<c:set var="approval_type_nm" 		value="${fn:split(APPROVAL_TYPE_NM,',')}"/>
<c:set var="user_appr_gb_cd" 		value="${fn:split(USER_APPR_GB_CD,',')}"/>
<c:set var="user_appr_gb_nm" 		value="${fn:split(USER_APPR_GB_NM,',')}"/>
<c:set var="approval_seq_cd" 		value="${fn:split(APPROVAL_ORDER_CD,',')}"/>

<form id="f_s" name="f_s" method="post" onsubmit="return false;">
</form>

<form name="frm1" id="frm1" method="post" onsubmit="return false;">
	<input type="hidden" name="flag" 				id="flag" />
	<input type="hidden" name="admin_line_grp_cd" 	id="admin_line_grp_cd" />
	<input type="hidden" name="admin_line_grp_nm" 	id="admin_line_grp_nm" />
</form>

<table style='width:100%;height:100%;border:none;'>
	<tr style='height:10px;'>
		<td style='vertical-align:top;' colspan="2">
			<h4 class="ui-widget-header ui-corner-all"  >
				<div id='t_<%=gridId %>' class='title_area' >
					<span><%=CommonUtil.isNull(arr_menu_gb[0]) %></span>
				</div>
			</h4>
		</td>
	</tr>
	<tr>
		<!-- 왼쪽그리드 -->
		<td style='vertical-align:top; width:30%;'>
			<table style="width:100%;height:100%;">
				<tr><!-- 왼쪽그리드 컬럼이름 -->
					<td id='ly_<%=gridId_1 %>' style='vertical-align:top;' >
						<div id="<%=gridId_1 %>" class="ui-widget-header ui-corner-all"></div>
					</td>					
				</tr>
			</table>
		</td>
		<!-- 오른쪽그리드 -->
		<td style='vertical-align:top; width:74%;'>
			<table style="width:100%;height:100%;">
				<tr>					
					<td id='ly_<%=gridId_2 %>' style='vertical-align:top;' >
						<form name="frm2" id="frm2" method="post" onsubmit="return false;">
							<input type="hidden" name="flag" 				id="flag"/>
							<input type="hidden" name="admin_line_cd" 		id="admin_line_cd" />
							<input type="hidden" name="admin_line_grp_cd" 	id="admin_line_grp_cd" />
							<input type="hidden" name="approval_cd" 		id="approval_cd" />
							<input type="hidden" name="group_line_grp_cd" 	id="group_line_grp_cd" />
							<input type="hidden" name="approval_seq" 		id="approval_seq" />
							<input type="hidden" name="user_appr_gb" 		id="user_appr_gb" />
							<input type="hidden" name="approval_type" 		id="approval_type" />
														
							<div id="<%=gridId_2 %>" class="ui-widget-header ui-corner-all"></div>
						
						</form>
					</td>
				</tr>
				<tr style='height:10px;'>
					<td style='vertical-align:top;'>
						<h4 class="ui-widget-header ui-corner-all" >
							<div align='right' class='btn_area' >						
								<div id='ly_total_cnt' style='padding-top:5px;float:left;'></div>		
							</div>
						</h4>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>

<script>

	var arr_approval_seq_cd 		= new Array();
	var arr_approval_type_cd 		= new Array();
	var arr_approval_type_nm 		= new Array();
	var arr_user_appr_gb_cd 	= new Array();
	var arr_user_appr_gb_nm 	= new Array();
	
	<c:forEach var="approval_seq_cd" items="${approval_seq_cd}" varStatus="s">
		var map_cd = {"cd":"${approval_seq_cd}"};
		arr_approval_seq_cd.push(map_cd);
	</c:forEach>
	
	<c:forEach var="approval_type_cd" items="${approval_type_cd}" varStatus="s">
		var map_cd = {"cd":"${approval_type_cd}"};
		arr_approval_type_cd.push(map_cd);
	</c:forEach>
	<c:forEach var="approval_type_nm" items="${approval_type_nm}" varStatus="s">
		var map_nm = {"nm":"${approval_type_nm}"};
		arr_approval_type_nm.push(map_nm);
	</c:forEach>
	
	<c:forEach var="user_appr_gb_cd" items="${user_appr_gb_cd}" varStatus="s">
		var map_cd = {"cd":"${user_appr_gb_cd}"};
		arr_user_appr_gb_cd.push(map_cd);
	</c:forEach>
	<c:forEach var="user_appr_gb_nm" items="${user_appr_gb_nm}" varStatus="s">
		var map_nm = {"nm":"${user_appr_gb_nm}"};
		arr_user_appr_gb_nm.push(map_nm);
	</c:forEach>

	function gridCellCustomFormatter(row,cell,value,columnDef,dataContext){
		
		var ret = "";
		var admin_line_grp_cd = getCellValue(gridObj_1,row,'ADMIN_LINE_GRP_CD');		
		
		if(columnDef.id == 'SELECT'){
			ret = "<a href=\"JavaScript:adminApprovalLineList('"+admin_line_grp_cd+"');\" /><font color='red'>"+value+"</font></a>";	
		}
				
		return ret;
	}

	var gridObj_1 = {
		id : "<%=gridId_1 %>"
		,colModel:[ 
	   		{formatter:gridCellCustomFormatter,field:'SELECT',id:'SELECT',name:'',width:50,headerCssClass:'cellCenter',cssClass:'cellCenter'}
	   		,{formatter:gridCellNoneFormatter,field:'ADMIN_LINE_GRP_NM',id:'ADMIN_LINE_GRP_NM',name:'결재그룹명',width:150,headerCssClass:'cellCenter',cssClass:'cellLeft'}
	   		,{formatter:gridCellNoneFormatter,field:'ADMIN_LINE_GRP_CD',id:'ADMIN_LINE_GRP_CD',name:'ADMIN_LINE_GRP_CD',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   		,{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'grid_idx',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   	]
		,rows:[]
		,vscroll:<%=S_GRID_VSCROLL%>
	};
	
	var gridObj_2 = {
		id : "<%=gridId_2 %>"
		,colModel:[
	   		{formatter:gridCellNoneFormatter,field:'APPROVAL_SEQ',id:'APPROVAL_SEQ',name:'결재순서',width:60,headerCssClass:'cellCenter',cssClass:'cellCenter'}
	   		,{formatter:gridCellNoneFormatter,field:'APPROVAL_ID',id:'APPROVAL_ID',name:'결재자',width:300,headerCssClass:'cellCenter',cssClass:'cellLeft'}
	   		,{formatter:gridCellNoneFormatter,field:'GROUP_LINE_GRP_NM',id:'GROUP_LINE_GRP_NM',name:'결재그룹',width:150,headerCssClass:'cellCenter',cssClass:'cellLeft'}
	   		,{formatter:gridCellNoneFormatter,field:'APPROVAL_TYPE',id:'APPROVAL_TYPE',name:'결재유형',width:80,headerCssClass:'cellCenter',cssClass:'cellLeft'}
// 	   		,{formatter:gridCellNoneFormatter,field:'USER_APPR_GB',id:'USER_APPR_GB',name:'결재구분',width:100,headerCssClass:'cellCenter',cssClass:'cellLeft'}
	   		,{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'grid_idx',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   		,{formatter:gridCellNoneFormatter,field:'ADMIN_LINE_CD',id:'ADMIN_LINE_CD',name:'ADMIN_LINE_CD',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   		,{formatter:gridCellNoneFormatter,field:'ADMIN_LINE_GRP_CD',id:'ADMIN_LINE_GRP_CD',name:'ADMIN_LINE_GRP_CD',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   		,{formatter:gridCellNoneFormatter,field:'APPROVAL_CD',id:'APPROVAL_CD',name:'APPROVAL_CD',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   		,{formatter:gridCellNoneFormatter,field:'GROUP_LINE_GRP_CD',id:'GROUP_LINE_GRP_CD',name:'GROUP_LINE_GRP_CD',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   	]
		,rows:[]
		,vscroll:<%=S_GRID_VSCROLL%>
	};
	
	$(document).ready(function(){
		viewGrid_1(gridObj_1,"ly_"+gridObj_1.id);
		adminApprovalGroupList();
		
		viewGrid_1(gridObj_2,"ly_"+gridObj_2.id);
	});
	
	function adminApprovalGroupList(){
		

		try{viewProgBar(true);}catch(e){}
		$('#ly_total_cnt').html('');
		
		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=adminApprovalGroup&itemGubun=2';
		
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
						
						items.find('item').each(function(i){						
						
							var admin_line_grp_cd 	= $(this).find("ADMIN_LINE_GRP_CD").text();
							var admin_line_grp_nm 	= $(this).find("ADMIN_LINE_GRP_NM").text();
							
							var v_admin_line_grp_nm 	= "<div class='gridInput_area' name='admin_line_grp_nm"+admin_line_grp_cd+"' id='admin_line_grp_nm"+admin_line_grp_cd+"' style='width:100%;'/>"+admin_line_grp_nm+"</div>";

							rowsObj.push({
								'grid_idx':i
								,'SELECT': "[선택]"
								,'ADMIN_LINE_GRP_CD': admin_line_grp_cd
								,'ADMIN_LINE_GRP_NM': v_admin_line_grp_nm
							});
							
						});						
						
						gridObj_1.rows = rowsObj;
						setGridRows(gridObj_1);
												
					});
					try{viewProgBar(false);}catch(e){}
				}
		, null );
		
		xhr.sendRequest();
	}
	
	function adminApprovalLineList(admin_line_grp_cd){
		
		try{viewProgBar(true);}catch(e){}
		$('#ly_total_cnt').html('');
		
		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=adminApprovalLine_u&itemGubun=2&admin_line_grp_cd='+admin_line_grp_cd;
		
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
						
						items.find('item').each(function(i){
						
							var admin_line_cd 		= $(this).find("ADMIN_LINE_CD").text();
							var admin_line_grp_cd 	= $(this).find("ADMIN_LINE_GRP_CD").text();								
							var approval_cd 		= $(this).find("APPROVAL_CD").text();
							var approval_nm 		= $(this).find("APPROVAL_NM").text();
							var admin_line_grp_id 	= $(this).find("ADMIN_LINE_GRP_ID").text();
							var group_line_grp_cd 	= $(this).find("GROUP_LINE_GRP_CD").text();
							var group_line_grp_nm 	= $(this).find("GROUP_LINE_GRP_NM").text();
							var duty_nm 			= $(this).find("DUTY_NM").text(); 
							var dept_nm 			= $(this).find("DEPT_NM").text(); 
							var user_info 			= admin_line_grp_id == "" ? "" : approval_nm+"["+admin_line_grp_id+"]["+dept_nm+"]"+"["+duty_nm+"]";
							var approval_seq 		= $(this).find("APPROVAL_SEQ").text();
							var approval_type 		= $(this).find("APPROVAL_TYPE").text();
							var user_appr_gb 		= $(this).find("APPROVAL_GB").text(); //ez_admin_approval_line테이블에서는'결재구분' 컬럼이 approval_gb(ez_user테이블에서는 user_appr_gb).
							
							var v_approval_cd = "<input type='hidden' id='approval_cd"+admin_line_cd+"' name='approval_cd"+admin_line_cd+"' value='"+approval_cd+"' />";
							
							var v_group_line_grp_cd = "<input type='hidden' id='group_line_grp_cd"+admin_line_cd+"' name='group_line_grp_cd"+admin_line_cd+"' value='"+group_line_grp_cd+"' />";
							
							var v_approval_seq = "<div class='gridInput_area' id='approval_seq"+admin_line_cd+"' name='approval_seq"+admin_line_cd+"' style='width:100%;text-align:center;'>"+approval_seq+"</div>";
							
							if ( group_line_grp_nm != "" ) {
								user_info = "";
							}
							
							v_user_info = "<div class='gridInput_area' id='user_info"+admin_line_cd+"' name='user_info"+admin_line_cd+"' >"+user_info+"</div>";
							
							v_group_line_grp_nm = "<div class='gridInput_area'>"+group_line_grp_nm+"</div>";
							
							var v_user_appr_gb = "<div class='gridInput_area' id='user_appr_gb"+admin_line_cd+"' name='user_appr_gb"+admin_line_cd+"' style='width:100%;text-align:center;'>";
							for(var j=0;j<arr_user_appr_gb_cd.length;j++){
								if(user_appr_gb == arr_user_appr_gb_cd[j].cd)										
									v_user_appr_gb += arr_user_appr_gb_nm[j].nm+"</div>";
							}
							
							var v_approval_type = "<div class='gridInput_area' id='approval_type"+admin_line_cd+"' name='approval_type"+admin_line_cd+"' style='width:100%;text-align:center;'>";
							for(var j=0;j<arr_approval_type_cd.length;j++){
								if(approval_type == arr_approval_type_cd[j].cd)										
									v_approval_type += arr_approval_type_nm[j].nm+"</div>";
							}
							
							rowsObj.push({
								'grid_idx':i
								,'ADMIN_LINE_CD': admin_line_cd
								,'ADMIN_LINE_GRP_CD': admin_line_grp_cd
								,'APPROVAL_ID': v_user_info
								,'APPROVAL_CD': v_approval_cd
								,'GROUP_LINE_GRP_NM': v_group_line_grp_nm
								,'GROUP_LINE_GRP_CD': v_group_line_grp_cd									
								,'APPROVAL_SEQ': v_approval_seq
								,'APPROVAL_TYPE': v_approval_type
// 								,'USER_APPR_GB': v_user_appr_gb
							});
							
						});						
						
						gridObj_2.rows = rowsObj;
						setGridRows(gridObj_2);
						$('#ly_total_cnt').html('[ TOTAL : '+items.attr('cnt')+' ]');
						
					});
					try{viewProgBar(false);}catch(e){}
				}
		, null );
		
		xhr.sendRequest();
	}
	
</script>