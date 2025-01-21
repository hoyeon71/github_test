<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/jsp/common/inc/header.jsp"%>
<%
	//js version 추가하여 캐시 새로고침
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
<link href="<%=request.getContextPath() %>/css/tree-layout.css" rel="stylesheet" type="text/css" />

<style type="text/css">
<!--
	
//-->
</style>

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
<script type="text/javascript" src="<%=request.getContextPath() %>/js/SlickGrid-2.1.0/plugins/slick.checkboxselectcolumn2.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/SlickGrid-2.1.0/plugins/slick.rowselectionmodel.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/SlickGrid-2.1.0/slick.dataview.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/SlickGrid-2.1.0/slick.grid.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/SlickGrid-2.1.0/slick.editors.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/poshytip-1.2/jquery.poshytip.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/works_common.js?v=<%=jsVersion %>" ></script>
</head>
<%
	Map<String, Object> paramMap 	= CommonUtil.collectParameters(request);
	String c = CommonUtil.isNull(paramMap.get("c"));
	
// 	String referer = CommonUtil.isNull(request.getHeader("referer"));
	
	String strDataCenter = CommonUtil.isNull(paramMap.get("data_center"));
	String strOdate 	 = CommonUtil.isNull(paramMap.get("odate"));
	String strTaskType 	 = CommonUtil.isNull(paramMap.get("task_type"));
	String strRba 		 = CommonUtil.isNull(paramMap.get("rba"));
	String strJob_name	 = CommonUtil.isNull(paramMap.get("job_name"));
	String strOrderId	 = CommonUtil.isNull(paramMap.get("order_id"));
	

// 	List smartTreeList = (List)request.getAttribute("smartTreeList");
	
	String strServerGb 		= CommonUtil.isNull(CommonUtil.getMessage("SERVER_GB"));
	
	// 세션값 가져오기.
	String strSessionUserGb	= S_USER_GB;	
	
%>

<body>

<form id="f_s" name="f_s" method="post" onsubmit="return false;">
	<input type="hidden" name="data_center" id="data_center" 		value="<%=strDataCenter%>"/>
	<input type="hidden" name="job_name" 	id="job_name" 			value="<%=strJob_name%>"/>
	<input type="hidden" name="odate" 		id="odate" 				value="<%=strOdate%>"/>
	<input type="hidden" name="task_type" 	id="task_type" 			value="<%=strTaskType%>"/>
	<input type="hidden" name="rba" 		id="rba" 				value="<%=strRba%>"/>
</form>

<form id='frm1' name='frm1' method='post' onsubmit='return false;'>
	
	
<table style='width:99%;height:100%;border:none;padding-left:15px; overflow-x:hidden;overflow-y:hidden;'>
	<tr style='height:10px;'>
		<td style='vertical-align:top;'>
			<h4 class="ui-widget-header ui-corner-all">
				<div class='title_area' style="width:100%; text-align:left;">
					<span><%=CommonUtil.getMessage("POPUP.SMART_JOB_INFO.TITLE") %></span>
				</div>				
			</h4>
		</td>
	</tr>
	<tr>
		<td>
			<div id='smart_tree_grid' class='treeContent_kang'>
			</div>
		</td>
	</tr>
</table>
</form>

<%@include file="/jsp/common/inc/progBar.jsp"  %>
<iframe name="if1" id="if1" width="0" height="0"></iframe>
</body>

<script>
	
	$(document).ready(function(){	
		window.focus();
		
		smartTreeInfoList();
		
		
		// 선택된 작업 텍스트 굵게 강조
		var select_order_id = "0" + "<%=strOrderId%>";
		var element_order_id = document.getElementById(select_order_id);
		if(element_order_id != null) {
			var textValue = element_order_id.outerHTML; // 선택된 작업의 요소와 자식 요소를 포함한 html 파편
			var changeTextFont = element_order_id.firstChild.nodeValue.trim(); // 선택된 작업의 텍스트를 뽑아냄 
			var modifyElement = textValue.replace(changeTextFont, "<strong>" + changeTextFont +"</strong>");
			
			element_order_id.outerHTML = modifyElement;
		}
		
	});
	
	
	function smartTreeInfoList(){
		
		var arr_job_name  = new Array();
		var arr_order_id  = new Array();
		var arr_rba       = new Array();
		var arr_grp_rba   = new Array();
		
		try{viewProgBar(true);}catch(e){}

		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=smartTreeInfoList';

		var xhr = new XHRHandler( url, f_s
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
						dlClose('dl_tmp3');
						return;
					}
					$(xmlDoc).find('doc').each(function(){

						var items = $(this).find('items');

						if(items.attr('cnt')=='0'){
						}else{
							items.find('item').each(function(i){
								var job_name 	 = $(this).find("JOB_NAME").text();
								var odate 		 = $(this).find("ODATE").text();
								var order_id 	 = $(this).find("ORDER_ID").text();
								var rba 	 	 = $(this).find("RBA").text();
								var grp_rba 	 = $(this).find("GRP_RBA").text();
								var task_type 	 = $(this).find("TASK_TYPE").text();
								
								job_name = job_name + " (" + order_id + ")";
								
								if(task_type == "SMART Table"){
									job_name = "[SMART] " + job_name
								}else if(task_type == "Sub-Table"){
									job_name = "[SUB] " + job_name
								}
								
								arr_job_name.push(job_name);
								arr_order_id.push(order_id);
								arr_rba.push(rba);
								arr_grp_rba.push(grp_rba);
								
							});
						}
					});
					try{viewProgBar(false);}catch(e){}
				}
		, null );
		
		xhr.sendRequestSync();
		
		renderTree(arr_job_name, arr_order_id, arr_rba, arr_grp_rba, "");
		
		// 트리 생성 시 New옵션은 가려준다.
		var new_li = document.getElementById("New");
		new_li.style.display = "none";
		
	}

</script>
</html>