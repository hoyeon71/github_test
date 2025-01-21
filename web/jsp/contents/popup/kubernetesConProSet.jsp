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
	
	String strCyclicType 		= CommonUtil.isNull(paramMap.get("cyclic_type"));
	String strRerunInterval 	= CommonUtil.isNull(paramMap.get("rerun_interval"));
	String strCountCyclicFrom 	= CommonUtil.isNull(paramMap.get("count_cyclic_from"));
	String strIntervalSequence 	= CommonUtil.isNull(paramMap.get("interval_sequence"));
	String strTolerance			= CommonUtil.isNull(paramMap.get("tolerance"), "0");
	String strSpecificTimes 	= CommonUtil.isNull(paramMap.get("specific_times"));
	String strFlag				= CommonUtil.isNull(paramMap.get("flag"));
	
	// 반복주기(불규칙)의 필요없는 문자 제거
	if ( !strIntervalSequence.equals("") ) {
		strIntervalSequence = strIntervalSequence.replaceAll("[+]", "").replaceAll("M", "");
	}
	
	List kuHostList				= (List)request.getAttribute("kuHostList");
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
<!-- 					<td> -->
					<td style="width:12%;  padding-right:5px;">
						<div class='cellTitle_ez_right' >Host</div>
					</td>
					<td>
						<div class='cellContent_kang'>
							<select id='ku_host' name='ku_host' style="width:28%;height:21px;">
								<option value="">--선택--</option>
								<%
									for ( int i = 0; i < kuHostList.size(); i++ ) {
										DefJobBean bean = (DefJobBean)kuHostList.get(i);

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
				<table style="width:100%;height:100px;">
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
	   		,{formatter:gridCellNoneFormatter,field:'PROFILE_NAME',id:'PROFILE_NAME',name:'PROFILE NAME',width:180,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}	
	   		,{formatter:gridCellNoneFormatter,field:'TYPE',id:'TYPE',name:'Type',width:100,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'CHOICE',id:'CHOICE',name:'선택',width:150,headerCssClass:'cellCenter',cssClass:'cellLeft'}
	   		
	   	]
		,rows:[]
	};

	$(document).ready(function(){
		
// 		$("#btn_close").button().unbind("click").click(function(){
// 			self.close();
// 		});
		
		viewGrid_1(g_in, 'ly_' + g_in.id);
		
		$("#ku_host").change(function(){
			var ku_host = $(this).val();
			
			if(ku_host != ""){
				getConPro(ku_host);
			}
		});

	});
	
	// 수시작업 등록 LIST 조회
	function getConPro(ku_host) {
		clearGridSelected(g_in);

		try{viewProgBar(true);}catch(e){}

		var formData = new FormData();
		
		formData.append("c", 		"cData2");
		formData.append("itemGb", 	"getConPro");
		formData.append("type", 	"Kubernetes");	//kubernetes의 connection profile 목록 가져오기위해 타입 지정

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
					var profile_name 		= data[index].PROFILE_NAME;

					rowsObj.push({
						'grid_idx':i+1
						,'PROFILE_NAME': profile_name
						,'TYPE': "Centralized"
						,'CHOICE':"<div><a href=\"javascript:goSelect('"+profile_name+"', '"+ku_host+"');\" ><font color='red'>[선택]</font></a></div>"
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
	
	function goSelect(profile_name, ku_host){
		
		var node_id = opener.document.getElementById('node_id').value;
		
		if(node_id != ku_host ){
			alert("선택하신 Host와 수행서버가 다릅니다. \n\n수행서버 : " + node_id + "\nHost : " + ku_host);
			opener.document.getElementById('con_pro').value = '';
			
			return;
		}

		opener.document.getElementById('con_pro').value = profile_name;
		
		self.close();
	}
</script>
<%@include file="/jsp/common/inc/progBar.jsp"  %>
</body>
</html>
