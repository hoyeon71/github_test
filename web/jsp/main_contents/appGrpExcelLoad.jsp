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

<style type="text/css">

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
<script type="text/javascript" src="<%=request.getContextPath() %>/js/SlickGrid-2.1.0/plugins/slick.checkboxselectcolumn.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/SlickGrid-2.1.0/plugins/slick.rowselectionmodel.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/SlickGrid-2.1.0/slick.dataview.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/SlickGrid-2.1.0/slick.grid.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/SlickGrid-2.1.0/slick.editors.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/poshytip-1.2/jquery.poshytip.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/works_common.js?v=<%=jsVersion %>" ></script>
<script type="text/javascript">
<!--

//-->
</script>
</head>
<%
	Map<String, Object> paramMap = CommonUtil.collectParameters(request);
	String c = CommonUtil.isNull(paramMap.get("c"));
	String gridId_3 = "g_"+c+"_3";
	
	ArrayList excelList = (ArrayList)request.getAttribute("excelList");
	ArrayList hostList =  (ArrayList)request.getAttribute("hostList");
	String strServerGb 		= CommonUtil.isNull(CommonUtil.getMessage("SERVER_GB"));
	
	// 세션값 가져오기.	
	String strSessionDcCode 	= S_D_C_CODE;
	String strSessionTab	 	= S_TAB;
	String strSessionApp	 	= S_APP;
	String strSessionGrp	 	= S_GRP;

	String strTitle			= CommonUtil.isNull(paramMap.get("title"));
	String strContent		= CommonUtil.isNull(paramMap.get("content"));
	String strNowDate		= DateUtil.getDay();
	String data_center		= CommonUtil.isNull(paramMap.get("data_center"));
	String strDcCode		= CommonUtil.isNull(paramMap.get("scode_cd"));
	String insert_type		= CommonUtil.isNull(paramMap.get("ins_type"));
	String strGrp_depth		= CommonUtil.isNull(paramMap.get("grp_depth"));
		
%>
<body>
	
	<form name="frm1" id="frm1" method="post">
		<input type="hidden" name="flag"				id="flag" />
	
		<input type="hidden" name="folder_nm"       	id="folder_nm"			value=""/>
		<input type="hidden" name="host_nm"         	id="host_nm"			value=""/>
		<input type="hidden" name="user_daliy"      	id="user_daliy"			value=""/>
		<input type="hidden" name="folder_desc"     	id="folder_desc"		value=""/>
		<input type="hidden" name="app_nm"          	id="app_nm"				value=""/>
		<input type="hidden" name="app_desc"        	id="app_desc"			value=""/>
		<input type="hidden" name="group_nm"        	id="group_nm"			value=""/>
		<input type="hidden" name="group_desc"      	id="group_desc"			value=""/>
		<input type="hidden" name="grp_use_yn"      	id="grp_use_yn"			value="Y"/>
		<input type="hidden" name="host_cd"     		id="host_cd"			value="0"/>
 		<input type="hidden" name="scode_cd"        	id="scode_cd"			value=<%= strDcCode %>>
 		
	</form>
	<table style="width:100%;height:99%;" align="center">
	<tr style='height:10px;'>
		<td style='vertical-align:top;'>
			<h4 class="ui-widget-header ui-corner-all">
				<div align='right' class='btn_area'>
					<font color="red">
						※ 최초 [엑셀로드]한 그리드 내용에 한해서 더블 클릭 후 수정이 가능합니다.
					</font>
					<div id='ly_total_cnt' style='padding-top:5px;float:left;'></div>
					<span id="btn_ins">등록</span>
				</div>
			</h4>
		</td>
	</tr>
	<tr>
		<td id='ly_<%=gridId_3 %>' style='vertical-align:top;'>
			<div id="<%=gridId_3 %>" class="ui-widget-header ui-corner-all"></div>
		</td>
	</tr>	
	</table>
	
</body>
<script>

	var gridObj_3 = {
		id : "<%=gridId_3 %>"
		,colModel:[
			{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'번호',width:50,headerCssClass:'cellCenter',cssClass:'cellCenter'}
		<%
			String[] arr_list = (String[])excelList.get(0);
			for(int i=0;i<arr_list.length;i++){
				String col_title = "job"+(i+1); 
				String col = CommonUtil.isNull(arr_list[i]);
				
				// 특정 항목은 그리드에서 변경 불가
		%>
				,{formatter:gridCellNoneFormatter,field:'<%=col_title%>',id:'<%=col_title%>',name:'<%=col%>',width:120,headerCssClass:'cellCenter',cssClass:'cellLeft',editor:Slick.Editors.Text}
		<%		    
			}
		%>   		
	   	]
		,rows:[]
		,vscroll:true
		,hscroll:true
	};
	
	$(document).ready(function(){
		
		var server_gb 		= "<%=strServerGb%>";
		var session_user_gb	= "<%=S_USER_GB%>";
		
		$("#btn_ins").show();

		viewGrid_2(gridObj_3,"ly_"+gridObj_3.id);
		excelRead();

		$("#btn_ins").button().unbind("click").click(function(){
			dataExec("insert");
		});


	function excelRead(){
		
		try{viewProgBar(true);}catch(e){}
		var cnt = 0;
		$('#ly_total_cnt').html('');
		
		var rowsObj_job3 = new Array();	
<%
	for(int i=1;i<excelList.size();i++){
		String[] arr_excel = (String[])excelList.get(i);	
%>
		rowsObj_job3.push({
			'grid_idx':<%=i%>
<%
			for(int j=0;j<arr_excel.length;j++){
				String col_title 	= "job"+(j+1);
				String col 			= CommonUtil.isNull(arr_excel[j]);
				col = col.replaceAll("\n", "||");
%>				
				,'<%=col_title%>': '<%=col%>'
<%
			}
%>
		});
		
		++cnt;
<%
	}
%>
		
		gridObj_3.rows = rowsObj_job3;
		setGridRows(gridObj_3);	
		
		$('#ly_total_cnt').html('[ TOTAL : '+cnt+' ]');
		try{viewProgBar(false);}catch(e){}
		
	}
	
	function dataExec(flag){
		
		// 그리드 마지막 값 원복되는 현상 해결
		$('#'+gridObj_3.id).data('grid').getEditorLock().commitCurrentEdit();
				
		var cnt 			= 0;
		var grid_idx 		= "";
		var cell_length 	= <%=arr_list.length%>;
		
		
		
		var folder_nm 	= ""; // 폴더명
		var host_nm	 	= ""; // 수행서버
		var user_daliy  = ""; // user_daily
		var folder_desc = ""; // 폴더 설명
		var app_nm 		= ""; // 어플리케이션명
		var app_desc 	= ""; // 어플리케이션 설명
		var grp_nm 		= ""; // 그룹
		var grp_desc 	= ""; // 그룹 설명
		
		
		setGridSelectedRowsAll(gridObj_3);
		var aSelRow = new Array;
		aSelRow = $('#'+gridObj_3.id).data('grid').getSelectedRows();
		if(aSelRow.length>0){
			if(cell_length != 8){
				alert("엑셀양식이 다릅니다. \n시스템관리 > 엑셀일괄에서 양식을 다시 내려 받아주세요.");
				return;
			}
			for(var i=0;i<aSelRow.length;i++){					
				
				grid_idx += getCellValue(gridObj_3,aSelRow[i],'grid_idx');
				
				folder_nm 	= folder_nm 	+ "," + getCellValue(gridObj_3,aSelRow[i],'job1');
				host_nm 	= host_nm 		+ "|" + getCellValue(gridObj_3,aSelRow[i],'job2');
				user_daliy 	= user_daliy 	+ "," + getCellValue(gridObj_3,aSelRow[i],'job3');
				folder_desc = folder_desc 	+ "," + getCellValue(gridObj_3,aSelRow[i],'job4');
				app_nm 		= app_nm 		+ "," + getCellValue(gridObj_3,aSelRow[i],'job5');
				app_desc 	= app_desc 		+ "," + getCellValue(gridObj_3,aSelRow[i],'job6');
				grp_nm 		= grp_nm 		+ "," + getCellValue(gridObj_3,aSelRow[i],'job7');
				grp_desc 	= grp_desc 		+ "," + getCellValue(gridObj_3,aSelRow[i],'job8');
				
				++cnt;
			}

		}else{
			alert("수행 할 작업을 선택해 주세요.");
			return;
		}
		
		goPrc(folder_nm, host_nm, user_daliy, folder_desc, app_nm, app_desc, grp_nm, grp_desc, cnt);
	}
	
	function goPrc(folder_nm, host_nm, user_daliy, folder_desc, app_nm, app_desc, grp_nm, grp_desc, cnt) {
		
		var frm = document.frm1;
		
		folder_nm	= folder_nm.substring(1, folder_nm.length);
		host_nm		= host_nm.substring(1, host_nm.length);
		user_daliy	= user_daliy.substring(1, user_daliy.length);
		folder_desc	= folder_desc.substring(1, folder_desc.length);
		app_nm		= app_nm.substring(1, app_nm.length);
		app_desc	= app_desc.substring(1, app_desc.length);
		grp_nm		= grp_nm.substring(1, grp_nm.length);
		grp_desc	= grp_desc.substring(1, grp_desc.length);
		
		
		if( !confirm(cnt + " 건을 등록하시겠습니까?") ) return;
		
		
		frm.flag.value        = "excel_ins";
		frm.folder_nm.value	  = folder_nm;
		frm.host_nm.value 	  = host_nm;
		frm.user_daliy.value  = user_daliy;
		frm.folder_desc.value = folder_desc;
		frm.app_nm.value	  = app_nm;
		frm.app_desc.value	  = app_desc;
		frm.group_nm.value	  = grp_nm;
		frm.group_desc.value  = grp_desc;
		
		frm.target = "if1";
		
		frm.action = "<%=sContextPath %>/common.ez?c=ezAppGrp_excel_p";
		frm.submit();
		
	}
	
</script>

<%@include file="/jsp/common/inc/progBar.jsp"  %>
<iframe name="if1" id="if1" width="0" height="0"></iframe>
</html>
