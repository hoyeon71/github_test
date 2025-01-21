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
	
	String strNodeId		 	= CommonUtil.isNull(paramMap.get("node_id"));
	String strFlag				= CommonUtil.isNull(paramMap.get("flag"));
	
	List dbHostList				= (List)request.getAttribute("dbHostList");
%>

<body style="overflow:hidden;">
<form id="frm1" name="frm1" method="post" onsubmit="return false;">

	<table style='width:98%;height:100%;border:none;'>
		<tr style='height:10px;'>
			<td style='vertical-align:top;'>
				<h1 style="float:left;font-weight:bold;color:#222;font-size:16px;line-height:33px;text-indent:10px;">
						<%=CommonUtil.getMessage("CATEGORY.POP.06") %>					
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
			<div style="overflow:visible;height:auto;padding:5px">
	
				<table style="width:50%;">
				<tr>
					<td style="width:12%;">
						<div class='cellTitle_ez_right'>Host</div>
					</td>
					<td>
						<div class='cellContent_kang'>
							<select id='db_host' name='db_host' style="width:40%;height:21px;">
								<option value="">--선택--</option>
								<%
									for ( int i = 0; i < dbHostList.size(); i++ ) {
										DefJobBean bean = (DefJobBean)dbHostList.get(i);

								%>
								<option value="<%=CommonUtil.E2K(bean.getNodeid())%>"><%=bean.getNodeid()%></option>
								<%
									}
								%>
							</select>
						</div>
					</td>
				</tr>
				</table>
			</div>
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
	   		,{formatter:gridCellNoneFormatter,field:'PROFILE_NAME',id:'PROFILE_NAME',name:'PROFILE NAME',width:150,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}	
	   		,{formatter:gridCellNoneFormatter,field:'DATABASE_TYPE',id:'DATABASE_TYPE',name:'DATABASE TYPE',width:150,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'DATABASE_VERSION',id:'DATABASE_VERSION',name:'DATABASE VERSION',width:150,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'TYPE',id:'TYPE',name:'TYPE',width:100,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'CHOICE',id:'CHOICE',name:'선택',width:50,headerCssClass:'cellCenter',cssClass:'cellCenter'}
	   		,{formatter:gridCellNoneFormatter,field:'DATABASE_NAME',id:'DATABASE_NAME',name:'DATABASE NAME',width:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   		,{formatter:gridCellNoneFormatter,field:'HOST',id:'HOST',name:'HOST',width:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   		,{formatter:gridCellNoneFormatter,field:'PORT',id:'PORT',name:'PORT',width:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   		,{formatter:gridCellNoneFormatter,field:'USER',id:'USER',name:'USER',width:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   		,{formatter:gridCellNoneFormatter,field:'PASSWORD',id:'PASSWORD',name:'PASSWORD',width:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   		,{formatter:gridCellNoneFormatter,field:'TARGET_CTM',id:'TARGET_CTM',name:'TARGET CTM',width:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   		,{formatter:gridCellNoneFormatter,field:'TARGET_AGENT',id:'TARGET_AGENT',name:'TARGET AGENT',width:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   	]
		,rows:[]
	};

	$(document).ready(function(){
		
// 		$("#btn_close").button().unbind("click").click(function(){
// 			self.close();
// 		});
		
		viewGrid_1(g_in, 'ly_' + g_in.id);
		
		$("#db_host").change(function(){
			var db_host = $(this).val();
			
			if(db_host != ""){
				getConPro(db_host);
			}
		});

	});
	
	// 수시작업 등록 LIST 조회
	function getConPro(db_host) {
		clearGridSelected(g_in);
		
		try{viewProgBar(true);}catch(e){}
		
		var formData = new FormData();
		
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
					var message 			= data[index].message;
					if(message){
						alert(message);
						try{viewProgBar(false);}catch(e){};
						return;
					}
					
					var profile_name 		= data[index].PROFILE_NAME;
					var database_type 		= data[index].Type;
					var database_version 	= data[index].DatabaseVersion;
					var type 				= database_type.split(":")[1];
					var database_type_ment 	= database_type.split(":")[2];
					
					
					var user		 		= data[index].User;
					var port 				= data[index].Port;
					var database_name 		= data[index].DatabaseName;
					var host		 		= data[index].Host;
					var password 			= data[index].Password;
					var target_ctm			= data[index].TargetCTM;
					var target_agent		= data[index].TargetAgent;
					var service_name		= data[index].ServiceName;
					var sid					= data[index].SID;
					
					
					rowsObj.push({
						'grid_idx':i+1
						,'PROFILE_NAME': profile_name
						,'DATABASE_TYPE': database_type_ment
						,'DATABASE_VERSION': database_version
						,'TYPE': type
						,'USER': user
						,'PORT': port
						,'DATABASE_NAME': database_name
						,'HOST': host
						,'PASSWORD': password
						,'TARGET_CTM': target_ctm
						,'TARGET_AGENT': target_agent
						,'CHOICE':"<div><a href=\"javascript:goSelect('"+profile_name+"', '"+database_name+"', '"+user+"', '"+port+"', '"+host+"', '"+password+"', '"+target_ctm+"', '"+target_agent+"','"+database_type_ment+"','"+sid+"','"+service_name+"');\" ><font color='red'>[선택]</font></a></div>"
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
	
	function goSelect(profile_name, database_name, user, port, host, password, target_ctm, target_agent, database_type, sid, service_name){
		opener.document.getElementById('db_con_pro').value = profile_name;
		if(database_name != 'undefined'){
			opener.document.getElementById('database').value = database_name;	
		}else{
			if(sid != 'undefined'){
				opener.document.getElementById('database').value = sid;	
			}else if(service_name != 'undefined'){
				opener.document.getElementById('database').value = service_name;	
			}
		}
		
		opener.document.getElementById('db_user').value = user;
		opener.document.getElementById('db_port').value = port;
		opener.document.getElementById('db_host').value = host;3
		opener.document.getElementById('database_type').value = database_type;
		opener.document.getElementById('sid').value = sid;
		opener.document.getElementById('service_name').value = service_name;
		opener.document.getElementById('schema').value = '';
		opener.document.getElementById('sp_name').value = '';
		opener.document.getElementById('query').value = '';
		
		self.close();
	}
</script>
<%@include file="/jsp/common/inc/progBar.jsp"  %>
</body>
</html>
