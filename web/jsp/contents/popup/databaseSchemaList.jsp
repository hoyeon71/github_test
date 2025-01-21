<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/jsp/common/inc/header.jsp"%>
<%
	String jsVersion = CommonUtil.getMessage("js_version");
%>

<!DOCTYPE html>
<html>
<head><title><%=CommonUtil.getMessage("HOME.TITLE") %></title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<link href="<%=request.getContextPath() %>/css/common.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath() %>/css/custom-theme/jquery-ui.custom.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath() %>/css/custom-theme/jquery-ui.works.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath() %>/css/layout-default.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath() %>/css/ftree/ui.fancytree.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath() %>/js/SlickGrid-2.1.0/slick.grid.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath() %>/css/slick-default-theme.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath() %>/js/poshytip-1.2/tip.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="<%=request.getContextPath() %>/js/common.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/cookie.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/popup.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/xhrHandler.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.min.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery-ui.custom.min.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.resizeEnd.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.corner.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.cookie.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery-sha256.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.placeholder.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.blockUI.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.event.drag-2.2.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.dialogextend.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.layout.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.layout.slideOff.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.fancytree-all.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/SlickGrid-2.1.0/slick.core.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/SlickGrid-2.1.0/plugins/slick.autotooltips.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/SlickGrid-2.1.0/plugins/slick.checkboxselectcolumn.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/SlickGrid-2.1.0/plugins/slick.rowselectionmodel.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/SlickGrid-2.1.0/slick.dataview.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/SlickGrid-2.1.0/slick.grid.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/SlickGrid-2.1.0/slick.editors.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/poshytip-1.2/jquery.poshytip.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/works_common.js?v=<%=jsVersion %>" ></script>
</head>

<%
	Map<String, Object> paramMap = CommonUtil.collectParameters(request);
	
	String strConPro		 	= CommonUtil.isNull(paramMap.get("db_con_pro"));
	String strDbUser		 	= CommonUtil.isNull(paramMap.get("db_user"));
	String strDbNm				= CommonUtil.isNull(paramMap.get("database"));
	String strSid				= CommonUtil.isNull(paramMap.get("sid"));
	String strServiceName		= CommonUtil.isNull(paramMap.get("service_name"));
	String strDbHost			= CommonUtil.isNull(paramMap.get("db_host"));
	String strDbPort			= CommonUtil.isNull(paramMap.get("db_port"));
	String strDbType		 	= CommonUtil.isNull(paramMap.get("database_type"));
	
%>

<body style="overflow:hidden;">
<form id="frm1" name="frm1" method="post" onsubmit="return false;">

	<table style='width:98%;height:100%;border:none;'>
		<tr style='height:10px;'>
			<td style='vertical-align:top;'>
				<h1 style="float:left;font-weight:bold;color:#222;font-size:16px;line-height:33px;text-indent:10px;">
						<%=CommonUtil.getMessage("CATEGORY.POP.07") %>					
				</h1>
			</td>
		</tr>
		<tr><td height="5px;"></td></tr>
		<tr>
			<td style="text-align:right;">
<!-- 				<span id="btn_close">닫기</span>		 -->
			</td>
		</tr>
		<tr><td height="5px;"></td></tr>			
	</table>
	<div class="view_area" style="overflow:visible;">
		<h4 class="ui-widget-header ui-corner-all">		
			<div>
				<table style="width:100%;height:200px;">
					<tr>
						<td id='ly_g_in' style='vertical-align:top;' >	
							<div id="g_in" class="ui-widget-header ui-corner-all"></div>
						</td>
					</tr>
				</table>
			</div>
		</h4>
	</div>
</form>
<script>

	var g_in = {
		id : 'g_in'
		,colModel:[
			 {formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'번호',width:50,headerCssClass:'cellCenter',cssClass:'cellCenter'}
	   		,{formatter:gridCellNoneFormatter,field:'SCHEMA_NAME',id:'SCHEMA_NAME',name:'SCHEMA_NAME',width:250,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}	
	   		,{formatter:gridCellNoneFormatter,field:'CHOICE',id:'CHOICE',name:'선택',width:50,headerCssClass:'cellCenter',cssClass:'cellCenter'}
	   	]
		,rows:[]
	};

	$(document).ready(function(){

		viewGrid_1(g_in, 'ly_' + g_in.id);
		var db_con_pro = '<%=strConPro %>';
		var db_user = '<%=strDbUser %>';
		var database = '<%=strDbNm %>';
		var sid = '<%=strSid %>';
		var service_name= '<%=strServiceName %>';
		var db_host = '<%=strDbHost %>';
		var db_port = '<%=strDbPort %>';
		var database_type = '<%=strDbType %>';
		
		getSchema(db_con_pro, db_host, db_port, database, sid, service_name, db_user, database_type);

	});
	
	// 수시작업 등록 LIST 조회
	function getSchema(db_con_pro, db_host, db_port, database, sid, service_name, db_user, database_type) {
		clearGridSelected(g_in);
		
		try{viewProgBar(true);}catch(e){}
		
		var formData = new FormData();
		
		formData.append("c", 				"cData2");
		formData.append("itemGb", 			"getSchema");
		formData.append("db_con_pro", 		db_con_pro);
		formData.append("db_host", 			db_host);
		formData.append("db_port", 			db_port);
		formData.append("database", 		database);
		formData.append("sid", 				sid);
		formData.append("service_name", 	service_name);
		formData.append("db_user", 			db_user);
		formData.append("database_type", 	database_type);
		formData.append("type", 			"Database");	//kubernetes의 connection profile 목록 가져오기위해 타입 지정

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
					var schema 		= data[index].schema;
					
					rowsObj.push({
						'grid_idx':i+1
						,'SCHEMA_NAME': schema
						,'CHOICE':"<div><a href=\"javascript:goSelect('"+schema+"');\" ><font color='red'>[선택]</font></a></div>"
					});	
					++i;
				});
				var obj = null;
				obj = $("#g_in").data('gridObj');
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
	
	function goSelect(schema){
		opener.document.getElementById('schema').value = schema;
		self.close();
	}
</script>
<%@include file="/jsp/common/inc/progBar.jsp"  %>
</body>
</html>
