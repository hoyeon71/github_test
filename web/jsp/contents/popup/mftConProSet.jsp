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
<script type="text/javascript" src="<%=request.getContextPath() %>/js/SlickGrid-2.1.0/plugins/slick.autocolumnsize.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/SlickGrid-2.1.0/slick.dataview.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/SlickGrid-2.1.0/slick.grid.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/SlickGrid-2.1.0/slick.editors.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/poshytip-1.2/jquery.poshytip.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/works_common.js?v=<%=jsVersion %>" ></script>
</head>

<%
	Map<String, Object> paramMap = CommonUtil.collectParameters(request);
	
	String strCyclicType 		= CommonUtil.isNull(paramMap.get("cyclic_type"));
	String strRerunInterval 	= CommonUtil.isNull(paramMap.get("rerun_interval"));
	String strCountCyclicFrom 	= CommonUtil.isNull(paramMap.get("count_cyclic_from"));
	String strIntervalSequence 	= CommonUtil.isNull(paramMap.get("interval_sequence"));
	String strTolerance			= CommonUtil.isNull(paramMap.get("tolerance"), "0");
	String strSpecificTimes 	= CommonUtil.isNull(paramMap.get("specific_times"));
	String strFlag				= CommonUtil.isNull(paramMap.get("flag"));
	String FTP_ACCOUNT			= CommonUtil.isNull(paramMap.get("FTP_ACCOUNT"));
	
	// 반복주기(불규칙)의 필요없는 문자 제거
	if ( !strIntervalSequence.equals("") ) {
		strIntervalSequence = strIntervalSequence.replaceAll("[+]", "").replaceAll("M", "");
	}
	
	List mftHostList			= (List)request.getAttribute("mftHostList");
%>

<body>
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
	
				<table style="width:100%;">
				<tr>
					<td style="width:3%;"> 
						<div class='cellTitle_ez_right' >Host</div> 
					</td>
					<td style="width:80%;">
						<div class='cellContent_kang' > 
							<select id='host' name='host' style="width:24%;height:21px;">
								<option value="">--선택--</option>
								<%
									for ( int i = 0; i < mftHostList.size(); i++ ) {
										DefJobBean bean = (DefJobBean)mftHostList.get(i);

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
				<table style="width:100%;height:300px;">
					<tr>
						<td id='ly_gridObj_1' style='vertical-align:top;width:350px;' >	
							<div id="gridObj_1" class="ui-widget-header ui-corner-all"></div>
						</td>
					</tr>
				</table>
			</div>
		</h4>
	</div>
</form>
<script>

	var gridObj_1 = {
		id : 'gridObj_1'
		,colModel:[
			 {formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'번호',width:50,minWidth:50,headerCssClass:'cellCenter',cssClass:'cellCenter'}
	   		,{formatter:gridCellNoneFormatter,field:'PROFILE_NAME',id:'PROFILE_NAME',name:'PROFILE NAME',width:100,minWidth:100,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'LHOST',id:'LHOST',name:'LHOST',width:100,minWidth:100,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'LUSER',id:'LUSER',name:'LUSER',width:100,minWidth:100,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'LPATH',id:'LPATH',name:'LPATH',width:100,minWidth:100,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'/',id:'/',name:'/',width:20,minWidth:20,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'RHOST',id:'RHOST',name:'RHOST',width:100,minWidth:100,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'RUSER',id:'RUSER',name:'RUSER',width:100,minWidth:100,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'RPATH',id:'RPATH',name:'RPATH',width:100,minWidth:100,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'CHOICE',id:'CHOICE',name:'선택',width:50,minWidth:50,headerCssClass:'cellCenter',cssClass:'cellLeft'}
	   		
	   		,{formatter:gridCellNoneFormatter,field:'LTYPE',id:'LTYPE',name:'LTYPE',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   		,{formatter:gridCellNoneFormatter,field:'RTYPE',id:'RTYPE',name:'RTYPE',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   		
	   	]
		,rows:[]
	};
	
	$(document).ready(function(){
		
// 		$("#btn_close").button().unbind("click").click(function(){
// 			self.close();
// 		});
		var FTP_ACCOUNT = "<%=FTP_ACCOUNT%>";
		
		viewGrid_1(gridObj_1, 'ly_' + gridObj_1.id,{enableColumnReorder:true},'AUTO');
		
		$("#host").change(function(){
			var host = $(this).val();
			
			if(host != ""){
				if(FTP_ACCOUNT != host){
					if (!confirm("데이터가 지워집니다 계속 하시겠습니까?")) {return;}
				}
				getConPro(host);
			}
		});

	});
	
	// 수시작업 등록 LIST 조회
	function getConPro(host) {
		
		clearGridSelected(gridObj_1);
		
		try{viewProgBar(true);}catch(e){}
		
		var formData = new FormData();
		
		formData.append("c", 		"cData2");
		formData.append("itemGb", 	"getConPro");
		formData.append("type", 	"FileTransfer");	//mft의 connection profile 목록 가져오기위해 타입 지정
		formData.append("host", 	host);
		
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
				var LHOST 	= new Array();
				var LUSER 	= new Array();
				var LPATH 	= new Array();
				var LTYPE 	= new Array();
				var RHOST 	= new Array();
				var RUSER 	= new Array();
				var RPATH 	= new Array();
				var RTYPE 	= new Array();
				var temp	= new Array();

				$.each(data, function(index, item) {
					
					var message 			= data[index].message;
					if(message){
						alert(message);
						try{viewProgBar(false);}catch(e){};
						return;
					}
					
					$.each(item, function(key, value) {
						
						 $.each(value,function(key2,value2){							 
							 if(key2.indexOf("Src")>-1){
								 $.each(value2,function(key3,value3){
									 
									 if(key3 == "HostName"){
										 LHOST.push(value3);
									 }else if(key3 == "User"){
										 LUSER.push(value3);
									 }else if(key3 == "HomeDirectory"){
										 LPATH.push(value3);
									 }else if(key3 == "Type"){
										 temp = value3.split(":");
										 LTYPE.push(temp[2]);
									 }
								 });
							 }
							 
							 if(key2.indexOf("Dest")>-1){
								 $.each(value2,function(key3,value3){

									 if(key3 == "HostName"){
										 RHOST.push(value3);
									 }else if(key3 == "User"){
										 RUSER.push(value3);
									 }else if(key3 == "HomeDirectory"){
										 RPATH.push(value3);
									 }else if(key3 == "Type"){
										 temp = value3.split(":");
										 RTYPE.push(temp[2]);
									 }
								 });
							 }
							 
						 });
						 
						
						 
						rowsObj.push({
							'grid_idx':i+1
							,'PROFILE_NAME': key
							,'LHOST': LHOST[i]
							,'LUSER': LUSER[i]
							,'LPATH': LPATH[i]
							,'LTYPE': LTYPE[i]
							,'/'	: ''
							,'RHOST': RHOST[i]
							,'RUSER': RUSER[i]
							,'RPATH': RPATH[i]
							,'RTYPE': RTYPE[i]
							,'CHOICE':"<div><a href=\"javascript:goSelect('"+key+"','"+LHOST[i]+"','"+LUSER[i]+"','"+LPATH[i]+"','"+LTYPE[i]+"','"+RHOST[i]+"','"+RUSER[i]+"','"+RPATH[i]+"','"+RTYPE[i]+"');\" ><font color='red'>[선택]</font></a></div>"
						});	
							
						++i;
			      });
			    });
				var obj = null;
				obj = $("#gridObj_1").data('gridObj');
				obj.rows = rowsObj;
				setGridRows(obj);
				$('body').resizeAllColumns();
		
			},
			error: function(data){
				alert("Data Reading Error... ");	
			},
			complete: function(data){
				try{viewProgBar(false);}catch(e){}
			}
		});	
	}
	
	function goSelect(profile_name, LHOST, LUSER, LPATH, LTYPE, RHOST, RUSER, RPATH, RTYPE){
				
		opener.document.getElementById('FTP_ACCOUNT').value 	= profile_name;
		
		opener.document.getElementById('FTP_LPATH1').value 		= LPATH;
		opener.document.getElementById('FTP_LHOST').value 		= LHOST;
		opener.document.getElementById('FTP_LUSER').value 		= LUSER;
		opener.document.getElementById('FTP_CONNTYPE1').value 	= LTYPE;
		
		opener.document.getElementById('FTP_RPATH1').value 		= RPATH;
		opener.document.getElementById('FTP_RHOST').value 		= RHOST;
		opener.document.getElementById('FTP_RUSER').value 		= RUSER;
		opener.document.getElementById('FTP_CONNTYPE2').value 	= RTYPE;
		
		opener.document.getElementById("host11").innerText = 'HOST : ' + LHOST + '  TYPE : ' + LTYPE + '  User : ' + LUSER;
		opener.document.getElementById("host21").innerText = 'HOST : ' + RHOST + '  TYPE : ' + RTYPE + '  User : ' + RUSER;
		
		self.close();
	}
</script>
<%@include file="/jsp/common/inc/progBar.jsp"  %>
</body>
</html>
