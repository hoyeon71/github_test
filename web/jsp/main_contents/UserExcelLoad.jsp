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
	System.out.println("excelList 11111111111111111111 : " + excelList.size());
	ArrayList hostList =  (ArrayList)request.getAttribute("hostList");
// 	List<CommonBean> hostList = (List)request.getAttribute("hostList");
	String strServerGb 		= CommonUtil.isNull(CommonUtil.getMessage("SERVER_GB"));
	List adminApprovalBtnList = (List)request.getAttribute("adminApprovalBtnList");
	
	// 세션값 가져오기.	
	String strSessionDcCode 	= S_D_C_CODE;
	String strSessionTab	 	= S_TAB;
	String strSessionApp	 	= S_APP;
	String strSessionGrp	 	= S_GRP;
	String strAdminApprovalBtn	= "";
	
	String strTitle			= CommonUtil.isNull(paramMap.get("title"));
	String strContent		= CommonUtil.isNull(paramMap.get("content"));
	String strNowDate		= DateUtil.getDay();
	String data_center		= CommonUtil.isNull(paramMap.get("data_center"));
	String strDcCode		= CommonUtil.isNull(paramMap.get("scode_cd"));
	String insert_type		= CommonUtil.isNull(paramMap.get("ins_type"));
	String strGrp_depth		= CommonUtil.isNull(paramMap.get("grp_depth"));
	
	if ( adminApprovalBtnList != null ) {		
		for ( int i = 0; i < adminApprovalBtnList.size(); i++ ) {			
			CommonBean commonBean = (CommonBean) adminApprovalBtnList.get(i);			
			strAdminApprovalBtn = CommonUtil.isNull(commonBean.getScode_nm());
		}
	}


%>
<body>
	<form name="frm2" id="frm2" method="post">
		<input type="hidden" name="excel_data" 			id="excel_data" />
		<input type="hidden" name="doc_cd" 				id="doc_cd" />
		<input type="hidden" name="doc_gb" 				id="doc_gb" />
		<input type="hidden" name="title" 				id="title" 				value="" />
		<input type="hidden" name="content" 			id="content" 			value="" />
		<input type="hidden" name="data_center" 		id="data_center" 		value="${paramMap.data_center}" />
		<%-- <input type="hidden" name="data_center_name" 	id="data_center_name" 	value="${paramMap.data_center_name}" /> --%>
		<input type="hidden" name="act_gb" 				id="act_gb" 			value="${paramMap.act_gb}" />
		<%-- <input type="hidden" name="table_name" 		id="table_name" 		value="${paramMap.table_name}" /> --%>
		<input type="hidden" name="time_group" 			id="time_group" 		value="${paramMap.time_group}" />
		<input type="hidden" name="flag" 				id="flag" 				value="temp_ins" />		
		<input type="hidden" name="file_nm" 			id="file_nm" 			value="${paramMap.file_nm}"/>
		<input type="hidden" name="save_file_nm" 		id="save_file_nm" 		value="${paramMap.file_nm}"/>	
	</form>
	
	<form name="frm3" id="frm3" method="post">
		<input type="hidden" name="flag"			id="flag" />
	
		<input type="hidden" name="user_id"			id="user_id"			value="" />
<!--  		<input type="hidden" name="user_pw"			id="user_pw"			value=""/> -->
 		<input type="hidden" name="user_nm"			id="user_nm"			value=""/>
 		<input type="hidden" name="user_gb"			id="user_gb"			value="01"/>
 		<input type="hidden" name="dept_nm"			id="dept_nm"			value=""/>
 		<input type="hidden" name="duty_nm"			id="duty_nm"			value=""/>
 		<input type="hidden" name="user_email"      id="user_email"			value=""/>
 		<input type="hidden" name="user_hp"			id="user_hp"			value=""/>
 		<input type="hidden" name="del_yn"			id="del_yn"				value="N"/>
 		<input type="hidden" name="retire_yn"		id="retire_yn"			value="N"/>
 		<input type="hidden" name="reset_yn"		id="reset_yn"			value="Y"/>
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
		
		var server_gb 			= "<%=strServerGb%>";
		var session_user_gb		= "<%=S_USER_GB%>";
		var adminApprovalBtn 	= "<%=strAdminApprovalBtn %>";
		
		$("#btn_ins").show();

		viewGrid_2(gridObj_3,"ly_"+gridObj_3.id);
		excelRead();

		$("#btn_ins").button().unbind("click").click(function(){

			dataExec("insert");
					
		});

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
		
		var user_id 	= "";
		var user_nm 	= "";
		var dept_nm 	= ""; // 부서
		var duty_nm 	= ""; // 직책
		var user_email	= "";
		var user_hp 	= "";
		
		setGridSelectedRowsAll(gridObj_3);
		var aSelRow = new Array;
		aSelRow = $('#'+gridObj_3.id).data('grid').getSelectedRows();
		
		if(cell_length != 6 ){
			alert("엑셀양식이 다릅니다. \n유저관리 > 엑셀일괄에서 양식을 다시 내려 받아주세요.");
			return;
		}
		
		if(aSelRow.length>0){
			for(var i=0;i<aSelRow.length;i++){					
				
				grid_idx += getCellValue(gridObj_3,aSelRow[i],'grid_idx');
				user_id			= user_id		+ "" + "," + getCellValue(gridObj_3,aSelRow[i],'job1');
				user_nm			= user_nm		+ "" + "," + getCellValue(gridObj_3,aSelRow[i],'job2');
				dept_nm			= dept_nm		+ "" + "," + getCellValue(gridObj_3,aSelRow[i],'job3');
				duty_nm			= duty_nm       + "" + "," + getCellValue(gridObj_3,aSelRow[i],'job4');
				user_email		= user_email	+ "" + "," + getCellValue(gridObj_3,aSelRow[i],'job5');
				user_hp			= user_hp		+ "" + "," + getCellValue(gridObj_3,aSelRow[i],'job6');
				
				if( getCellValue(gridObj_3, aSelRow[i],'job1') == "") {
					alert("["+i+"]아이디를 입력하세요.");
					return;
				}
				if( getCellValue(gridObj_3, aSelRow[i],'job2') == "") {
					alert("["+i+"]이름을 입력하세요.");
					return;
				}
				if( getCellValue(gridObj_3, aSelRow[i],'job3') == "") {
					alert("["+i+"]부서를 입력하세요.");
					return;
				}
				if( getCellValue(gridObj_3, aSelRow[i],'job4') == "") {
					alert("["+i+"]직책을 입력하세요.");
					return;
				}
				
				var now_date 	= "<%=strNowDate%>";
				var server_gb 	= "<%=strServerGb%>";
				var s_user_gb 	= "<%=S_USER_GB%>";
				 
				++cnt;
			}

		}else{
			alert("수행 할 작업을 선택해 주세요.");
			return;
		}
		
		goPrc(user_id, user_nm, dept_nm, duty_nm, user_email, user_hp, cnt);
	}
	
	function goPrc(user_id, user_nm, dept_nm, duty_nm, user_email, user_hp, cnt) {
		
		var user_pw ="";
		var frm = document.frm3;
		
		user_id		= user_id.substring(1, user_id.length);
// 		user_pw		= user_id; // 아이디와 비밀번호는 같게
		user_nm		= user_nm.substring(1, user_nm.length);
		dept_nm		= dept_nm.substring(1, dept_nm.length);
		duty_nm		= duty_nm.substring(1, duty_nm.length);
		user_email	= user_email.substring(1, user_email.length);
		user_hp		= user_hp.substring(1, user_hp.length);
		if( !confirm(cnt + " 건을 등록하시겠습니까?") ) return;
		
		frm.flag.value				= "ins";
		frm.user_id.value			= user_id;
		frm.user_nm.value			= user_nm;
		frm.dept_nm.value			= dept_nm;
		frm.duty_nm.value			= duty_nm;
		frm.user_email.value		= user_email;
		frm.user_hp.value			= user_hp;
		
		frm.target = "if1";
		frm.action = "<%=sContextPath %>/tWorks.ez?c=ez002_user_ins_excel";
		frm.submit();
		
	}
	
// 	function serverCheck() {
		
// 	}
</script>

<%@include file="/jsp/common/inc/progBar.jsp"  %>
<iframe name="if1" id="if1" width="0" height="0"></iframe>
</html>
