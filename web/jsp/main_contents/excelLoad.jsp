<%@page import="com.ghayoun.ezjobs.t.domain.UserBean"%>
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
<script type="text/javascript" src="<%=request.getContextPath() %>/js/SlickGrid-2.1.0/plugins/slick.autocolumnsize.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/poshytip-1.2/jquery.poshytip.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/works_common.js?v=<%=jsVersion %>" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/calendar.js" ></script>
<script type="text/javascript">
</script>
</head>
<%
	Map<String, Object> paramMap = CommonUtil.collectParameters(request);
	String c = CommonUtil.isNull(paramMap.get("c"));
	String gridId_3 = "g_"+c+"_3";
	
	ArrayList excelList = (ArrayList)request.getAttribute("excelList");
	
	String strServerGb 		= CommonUtil.isNull(CommonUtil.getMessage("SERVER_GB"));

	List adminApprovalBtnList = (List)request.getAttribute("adminApprovalBtnList");

	String strAdminApprovalBtn		= "";

	if ( adminApprovalBtnList != null ) {
		for ( int i = 0; i < adminApprovalBtnList.size(); i++ ) {
			CommonBean commonBean = (CommonBean) adminApprovalBtnList.get(i);
			strAdminApprovalBtn = CommonUtil.isNull(commonBean.getScode_nm());
		}
	}

	//폴더권한 체크
	List userAuthList 			= (List)request.getAttribute("userAuthList");
	String strUserAuthList				= "";
	
	if ( userAuthList != null ) {
		for ( int i = 0; i < userAuthList.size(); i++ ) {
			UserBean bean = (UserBean)userAuthList.get(i);
			if(i > 0) strUserAuthList += ",";
			strUserAuthList += CommonUtil.isNull(bean.getFolder_auth());
		}
	}
	
	//사용자의 폴더 권한 사용 여부
	List sCodeUserFolderAuthList = (List)request.getAttribute("sCodeUserFolderAuthList");
	String userFolderAuth_yn = "Y";
	if(sCodeUserFolderAuthList != null) {
		for ( int i = 0; i < sCodeUserFolderAuthList.size(); i++ ) {
			CommonBean commonBean = (CommonBean) sCodeUserFolderAuthList.get(i);
			
			userFolderAuth_yn = commonBean.getScode_eng_nm();
		}
	}
	
	String strVerify			= CommonUtil.isNull(paramMap.get("verify"));
%>
<body>
	<form name="frm2" id="frm2" method="post">
		<input type="hidden" name="excel_data" 			id="excel_data" />
		<input type="hidden" name="doc_cd" 				id="doc_cd" />
		<input type="hidden" name="doc_gb" 				id="doc_gb" />
		<input type="hidden" name="title" 				id="title" 				value="" />
		<input type="hidden" name="content" 			id="content" 			value="${paramMap.content}" />
		<input type="hidden" name="data_center" 		id="data_center" 		value="${paramMap.data_center}" />
		<%-- <input type="hidden" name="data_center_name" 	id="data_center_name" 	value="${paramMap.data_center_name}" /> --%>
		<input type="hidden" name="act_gb" 				id="act_gb" 			value="${paramMap.act_gb}" />
		<%-- <input type="hidden" name="table_name" 		id="table_name" 		value="${paramMap.table_name}" /> --%>
		<input type="hidden" name="time_group" 			id="time_group" 		value="${paramMap.time_group}" />
		<input type="hidden" name="flag" 				id="flag" 				value="temp_ins" />		
		<input type="hidden" name="file_nm" 			id="file_nm" 			value="${paramMap.file_nm}"/>
		<input type="hidden" name="save_file_nm" 		id="save_file_nm" 		value="${paramMap.file_nm}"/>
		<input type="hidden" name="p_apply_date" 		id="p_apply_date" 		value="${paramMap.apply_date}" />

		<!-- 그룹결재구성원 결재권/알림권 설정 -->
		<input type="hidden" name="grp_approval_userList" 		id="grp_approval_userList"/>
		<input type="hidden" name="grp_alarm_userList" 			id="grp_alarm_userList"/>

		<!-- 체크로직에서 date_center 를 사용할 수 있어서 파라미터 셋팅 (2023.08.08 강명준) -->
		<input type="hidden" name="scode_cd" 		id="scode_cd"/>

		<input type="hidden" name="post_approval_yn" 		id="post_approval_yn"/>
		<input type="hidden" name="doc_cnt"					id="doc_cnt"				value="0" />
	</form>
	<form name="frm3" id="frm3" method="post">
		<input type="hidden" name="excel_data" 			id="excel_data" />
		<input type="hidden" name="doc_cd" 				id="doc_cd" />
		<input type="hidden" name="doc_gb" 				id="doc_gb" />
		<input type="hidden" name="title" 				id="title" 				value="" />
		<input type="hidden" name="content" 			id="content" 			value="${paramMap.content}" />
		<input type="hidden" name="data_center" 		id="data_center" 		value="${paramMap.data_center}" />
		<%-- <input type="hidden" name="data_center_name" 	id="data_center_name" 	value="${paramMap.data_center_name}" /> --%>
		<input type="hidden" name="act_gb" 				id="act_gb" 			value="${paramMap.act_gb}" />
		<%-- <input type="hidden" name="table_name" 		id="table_name" 		value="${paramMap.table_name}" /> --%>
		<input type="hidden" name="time_group" 			id="time_group" 		value="${paramMap.time_group}" />
		<input type="hidden" name="flag" 				id="flag" 				value="v_temp_ins" />		
		<input type="hidden" name="file_nm" 			id="file_nm" 			value="${paramMap.file_nm}"/>
		<input type="hidden" name="save_file_nm" 		id="save_file_nm" 		value="${paramMap.file_nm}"/>
		<input type="hidden" name="p_apply_date" 		id="p_apply_date" 		value="${paramMap.apply_date}" />

		<!-- 그룹결재구성원 결재권/알림권 설정 -->
		<input type="hidden" name="grp_approval_userList" 		id="grp_approval_userList"/>
		<input type="hidden" name="grp_alarm_userList" 			id="grp_alarm_userList"/>

		<!-- 체크로직에서 date_center 를 사용할 수 있어서 파라미터 셋팅 (2023.08.08 강명준) -->
		<input type="hidden" name="scode_cd" 		id="scode_cd"/>

		<input type="hidden" name="post_approval_yn" 		id="post_approval_yn"/>
		<input type="hidden" name="doc_cnt"					id="doc_cnt"				value="0" />
	</form>
	<form id="f_s" name="f_s" method="post" onsubmit="return false;">
		<input type="hidden" name="week_days_text" 		id="week_days_text"/>
		<input type="hidden" name="week_days" 			id="week_days"/>
		<input type="hidden" name="month_days" 			id="month_days"/>
		<input type="hidden" name="weeks_cal" 			id="weeks_cal"/>
		<input type="hidden" name="days_cal" 			id="days_cal"/>
		<input type="hidden" name="t_general_date" 		id="t_general_date"/>
		<input type="hidden" name="data_center" 		id="data_center" 		value="${paramMap.data_center}" />
	</form>
	
	<form name="f_tmp" id="f_tmp" method="post" onsubmit="return false;">
		<input type="hidden" name="ori_con" 		id="ori_con"/>
		<input type="hidden" name="new_con" 		id="new_con"/>
	</form>
	<table style="width:99%;height:99%;" align="center" id="excel_load_tb">
	<tr style='height:10px;'>
		<td style='vertical-align:top;'>
			<h4 class="ui-widget-header ui-corner-all">
				<div align='right' class='btn_area'>
					<font color="red">
						※ 최초 [엑셀로드]한 그리드 내용에 한해서 더블 클릭 후 수정이 가능합니다.
					</font>
					<div id='ly_total_cnt' style='padding-top:5px;float:left;'></div>
					<%
					if(strVerify.equals("Y")){
					%>
					<span id="btn_verify" style='display:none;'>검증</span>
					<span id="btn_v_save" style='display:none;'>검증</span>
					<%
					}
					%>
					<%
					if(!strVerify.equals("Y")){
					%>
					<span id="btn_save" style='display:none;'>저장</span>
					<span id="btn_draft" style='display:none;'>승인요청</span>
					<span id="btn_draft_admin" style='display:none;'>관리자 즉시결재</span>
					<span id="btn_del" style='display:none;'>삭제</span>
					<%
					}
					%>
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
	<table style='width:99%;height:99%;border:none;display:none;' id="v_excel_load_tb">
		<tr style='height:10px;'>
			<td style='vertical-align:top;'>
				<h4  class="ui-widget-header ui-corner-all"  >
					<div  class='title_area' >
						<span>검증결과</span>
					</div>
				</h4>
			</td>
		</tr>
		<tr>
			<td id='ly_g_ret' style='vertical-align:top;width:100%;height:450px;' ></td>
		</tr>
		<tr style='height:10px;'>
			<td style='vertical-align:top;'>
				<!-- div id='ly_g_ret_c' style='height:80px;overflow-y:hidden;display:none;' ></div-->
				<h4 class="ui-widget-header ui-corner-all" >
					<div align='right' class='btn_area' >
						<div id='v_ly_total_cnt' style='float:left;'></div>
					</div>
				</h4>
			</td>
		</tr>
	</table>
</body>
<script>

	function gridCellCustomFormatter(row,cell,value,columnDef,dataContext){

		var ret = "";
		//var job_name = getCellValue(gridObj,row,'JOB_NAME');
		if(columnDef.id == 'FORECAST'){
			ret = "<a href=\"JavaScript:fn_sch_forecast('"+row+"');\" /><font color='red'><img src='<%=sContextPath %>/images/icon_lst1.png' border='0' width='20' height='20'></font></a>";
		}

		return ret;
	}

	var gridObj_3 = {
		id : "<%=gridId_3 %>"
		,colModel:[
			{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'번호',width:50,minWidth:50,headerCssClass:'cellCenter',cssClass:'cellCenter'}
			,{formatter:gridCellCustomFormatter,field:'FORECAST',id:'FORECAST',name:'FORECAST',width:70,minWidth:70,headerCssClass:'cellCenter',cssClass:'cellCenter'}
		<%
			String[] arr_list = (String[])excelList.get(0);
			for(int i=0;i<arr_list.length;i++){
				String col_title = "job"+(i+1); 
				String col = CommonUtil.isNull(arr_list[i]);
				
				// 특정 항목은 그리드에서 변경 불가
		%>
				,{formatter:gridCellNoneFormatter,field:'<%=col_title%>',id:'<%=col_title%>',name:'<%=col%>',width:120,minWidth:120,headerCssClass:'cellCenter',cssClass:'cellLeft',editor:Slick.Editors.Text}
		<%		    
			}
		%>   		

	   	]
		,rows:[]
		,vscroll:true
		,hscroll:true
	};

	$(document).ready(function(){
		
		$("#btn_save").show();
		$("#btn_v_save").show();
		$("#btn_verify").hide();
		$("#btn_draft").hide();
		$("#btn_draft_admin").hide();
		$("#btn_del").hide();
		
		var session_user_gb	= "<%=S_USER_GB%>";
		var userAuthList = "<%=strUserAuthList%>";
		var userFolderAuth_yn = "<%=userFolderAuth_yn%>";

		$("#btn_save").button().unbind("click").click(function(){
			 
			// 그리드 마지막 값 원복되는 현상 해결
			$('#'+gridObj_3.id).data('grid').getEditorLock().commitCurrentEdit();
		
			var data_center 		= parent.document.frm1.data_center.value;
			//var data_center_name 	= parent.document.frm1.data_center_name.value;
			var act_gb 				= parent.document.frm1.act_gb.value;
			var apply_date 			= parent.document.frm1.apply_date.value;
			//var table_name		= parent.document.frm1.table_name.value;
 
			$("#data_center").val(data_center);
			//$("#data_center_name").val(data_center_name);
			$("#act_gb").val(act_gb);
			$("#apply_date").val(apply_date);

			setGridSelectedRowsAll(gridObj_3);
			
			var merge = "";
			var aSelRow = new Array;
			aSelRow = $('#'+gridObj_3.id).data('grid').getSelectedRows();
			
			if(aSelRow.length>0){
				for(var i=0;i<aSelRow.length;i++){
					
					var job_nm = getCellValue(gridObj_3,aSelRow[i],'job8');
					
					const hasLeadingSpace = job_nm.startsWith(" ");
					const hasTrailingSpace = job_nm.endsWith(" ");
					
					if( !isJobName(job_nm,1) ){
						alert(i+1 + " 행 : 작업명에는 한글 및 특수 문자( \\ , $ , / , * , ?, ')를 입력 할 수 없습니다.");
						alert(i+1 + " 행 : 작업명에는 한글 및 특수 문자( \\ , $ , / , * , ( , ) , ? , ')를 입력 할 수 없습니다.");
						return;
					}
					
				    if (hasLeadingSpace || hasTrailingSpace) {
				    	alert(i+1 + " 행 : 작업명 앞 또는 뒤에 공백은 사용 불가합니다.");
				    	return; 
				    }
					
					// 엑셀일괄 등록/수정/삭제 폴더권한 체크 2023.10.10 이상훈
					var ArrUserAuthList = userAuthList.split(',');
					
					// 엑셀 저장시 사용자만 폴더권한 체크 2023.10.27 최호연
					if ( session_user_gb == "01" ) {
						var table_name = getCellValue(gridObj_3,aSelRow[i],'job2');
						
						if(table_name.indexOf("/") > -1 ) {
							table_name = table_name.substring(0, table_name.indexOf("/"));
						}
						if(ArrUserAuthList.indexOf(table_name) == -1 && userFolderAuth_yn == "Y") {
							alert(getCellValue(gridObj_3,aSelRow[i],'job2') + ' 해당 폴더에 대한 권한이 없습니다. \n관리자에게 문의 부탁드립니다.');
							return;
						}
					}
					
<%
					String[] arr_excelList = (String[])excelList.get(0);
						for(int j=0;j<arr_excelList.length;j++){
							String col_title = "job"+(j+1);
							String new_line = "N";
						if((j+1) == arr_excelList.length) new_line = "Y";
%>
						if("<%=j%>" > 0) merge += "★";
						
						merge += getCellValue(gridObj_3,aSelRow[i],'<%=col_title%>');
						
						if(getCellValue(gridObj_3,aSelRow[i],'job16') == '0'){
							setCellValue(gridObj_3,aSelRow[i],'job17', '');
							setCellValue(gridObj_3,aSelRow[i],'job18', '');
							setCellValue(gridObj_3,aSelRow[i],'job19', '');
							setCellValue(gridObj_3,aSelRow[i],'job20', '');
							setCellValue(gridObj_3,aSelRow[i],'job21', '');
							setCellValue(gridObj_3,aSelRow[i],'job22', '');
							setCellValue(gridObj_3,aSelRow[i],'job23', '');
							//setCellValue(gridObj_3,aSelRow[i],'job23', '');
							 
							//return;
						}
						if("<%=new_line%>" == "Y") merge += "★☆END☆★";
 
<%
						}
%>					
					merge = replaceAll(merge, "||", "\n");
 	
				}
			}
			
			clearGridSelected(gridObj_3)		//선택된 전체항목 해제
			 if( !confirm('처리하시겠습니까?\n\n반복작업이 0(N) 일 경우 반복옵션 항목은 초기화 됩니다.\n반복작업이 1(Y) 일 경우 반영 시점에 최대대기일은 0이 됩니다.\n\nValidation 체크를 진행해서 시간이 걸릴 수 있습니다.\n(약 100건 당 20초)') ) return;
 
			try{viewProgBar(true);}catch(e){}
			
			//alert("act_gb:::"+$("#frm2").find("input[name='act_gb']").val());
			$("#frm2").find("input[name='excel_data']").val(merge);	
			$("#frm2").find("input[name='doc_gb']").val("06");
			$("#frm2").find("input[name='scode_cd']").val(data_center.split(",")[0]);
			$("#frm2").attr("target", "if1");
			$("#frm2").attr("action", "/tWorks.ez?c=ez004_p");	
			$("#frm2").submit();
					
		});		
		
		$("#btn_v_save").button().unbind("click").click(function(){
			 
			// 그리드 마지막 값 원복되는 현상 해결
			$('#'+gridObj_3.id).data('grid').getEditorLock().commitCurrentEdit();
		
			var data_center 		= parent.document.frm1.data_center.value;
			//var data_center_name 	= parent.document.frm1.data_center_name.value;
			var act_gb 				= parent.document.frm1.act_gb.value;
			//var table_name			= parent.document.frm1.table_name.value;
 
			$("#data_center").val(data_center);
			//$("#data_center_name").val(data_center_name);
			$("#act_gb").val(act_gb);
 
			setGridSelectedRowsAll(gridObj_3);
			
			var merge = "";
			var aSelRow = new Array;
			aSelRow = $('#'+gridObj_3.id).data('grid').getSelectedRows();
			
			if(aSelRow.length>0){
				for(var i=0;i<aSelRow.length;i++){
					
					var job_nm = getCellValue(gridObj_3,aSelRow[i],'job8');
					
					const hasLeadingSpace = job_nm.startsWith(" ");
					const hasTrailingSpace = job_nm.endsWith(" ");
					
					if( !isJobName(job_nm,1) ){
						alert(i+1 + " 행 : 작업명에는 한글 및 특수 문자( \\ , $ , / , * , ( , ) , ? , ')를 입력 할 수 없습니다.");
						return;
					}
					
				    if (hasLeadingSpace || hasTrailingSpace) {
				    	alert(i+1 + " 행 : 작업명 앞 또는 뒤에 공백은 사용 불가합니다.");
				    	return; 
				    }
					
					// 엑셀일괄 등록/수정/삭제 폴더권한 체크 2023.10.10 이상훈
					var ArrUserAuthList = userAuthList.split(',');
					
					// 엑셀 저장시 사용자만 폴더권한 체크 2023.10.27 최호연
					if ( session_user_gb == "01" ) {
						var table_name = getCellValue(gridObj_3,aSelRow[i],'job2');
						
						if(table_name.indexOf("/") > -1 ) {
							table_name = table_name.substring(0, table_name.indexOf("/"));
						}
						if(ArrUserAuthList.indexOf(table_name) == -1 && userFolderAuth_yn == "Y") {
							alert(getCellValue(gridObj_3,aSelRow[i],'job2') + ' 해당 폴더에 대한 권한이 없습니다. \n관리자에게 문의 부탁드립니다.');
							return;
						}
					}
					
<%
					String[] v_arr_excelList = (String[])excelList.get(0);
						for(int j=0;j<v_arr_excelList.length;j++){
							String col_title = "job"+(j+1);
							String new_line = "N";
						if((j+1) == v_arr_excelList.length) new_line = "Y";
%>
						if("<%=j%>" > 0) merge += "★";
						
						merge += getCellValue(gridObj_3,aSelRow[i],'<%=col_title%>');
						
						if(getCellValue(gridObj_3,aSelRow[i],'job16') == '0'){
							setCellValue(gridObj_3,aSelRow[i],'job17', '');
							setCellValue(gridObj_3,aSelRow[i],'job18', '');
							setCellValue(gridObj_3,aSelRow[i],'job19', '');
							setCellValue(gridObj_3,aSelRow[i],'job20', '');
							setCellValue(gridObj_3,aSelRow[i],'job21', '');
							setCellValue(gridObj_3,aSelRow[i],'job22', '');
							setCellValue(gridObj_3,aSelRow[i],'job23', '');
							//setCellValue(gridObj_3,aSelRow[i],'job23', '');
							 
							//return;
						}
						if("<%=new_line%>" == "Y") merge += "★☆END☆★";
 
<%
						}
%>					
					merge = replaceAll(merge, "||", "\n");
 	
				}
			}
			
			clearGridSelected(gridObj_3)		//선택된 전체항목 해제
			 if( !confirm('처리하시겠습니까?\n\n반복작업이 0(N) 일 경우 반복옵션 항목은 초기화 됩니다.\n반복작업이 1(Y) 일 경우 최대대기일은 0이 됩니다.\n\nValidation 체크를 진행해서 시간이 걸릴 수 있습니다.\n(약 100건 당 20초)') ){
				try{viewProgBar(false);}catch(e){} 
	   		 	return;
			 }
				 
			try{viewProgBar(true);}catch(e){}
			
			//alert("act_gb:::"+$("#frm2").find("input[name='act_gb']").val());
			$("#frm3").find("input[name='excel_data']").val(merge);	
			$("#frm3").find("input[name='doc_gb']").val("06");
			$("#frm3").find("input[name='scode_cd']").val(data_center.split(",")[0]);
			$("#frm3").attr("target", "if1");
			$("#frm3").attr("action", "/tWorks.ez?c=ez004_p");	
			$("#frm3").submit();
					
		});	
		
		viewGrid_2(gridObj_3,"ly_"+gridObj_3.id,{enableColumnReorder:true},'AUTO');
		
		setTimeout(function(){
			excelRead();
		}, 450);
		
		$("#btn_draft").button().unbind("click").click(function(){
			getAdminLineGrpCd('draft', '01');
		});
		$("#btn_verify").button().unbind("click").click(function(){
			try{viewProgBar(true);}catch(e){}
			
			if( !confirm('처리하시겠습니까?') ) return;
				
			$("#frm2").find("input[name='doc_gb']").val("06");
			$("#frm2").find("input[name='flag']").val("verify");
			$("#frm2").attr("target", "if1");			
			$("#frm2").attr("action", "/tWorks.ez?c=excel_verify");	
			$("#frm2").submit();
		});
	
		$("#btn_draft_admin").button().unbind("click").click(function(){

			try{viewProgBar(true);}catch(e){}
			
			if( !confirm('처리하시겠습니까?') ) return;
				
			$("#frm2").find("input[name='doc_gb']").val("06");
			$("#frm2").find("input[name='flag']").val("draft_admin");
			$("#frm2").attr("target", "if1");			
			$("#frm2").attr("action", "/tWorks.ez?c=ez004_p");	
			$("#frm2").submit();
					
		});
				
		$("#btn_del").button().unbind("click").click(function(){

			try{viewProgBar(true);}catch(e){}
			
			clearGridSelected(gridObj_3)		//선택된 전체항목 해제
			
			if( !confirm('처리하시겠습니까?') ) return;
				
			$("#frm2").find("input[name='doc_gb']").val("06");
			$("#frm2").find("input[name='flag']").val("del");
			$("#frm2").attr("target", "if1");			
			$("#frm2").attr("action", "/tWorks.ez?c=ez004_p");	
			$("#frm2").submit();
					
		});
		
		
	});

	function changeBtn(doc_cd) {

		var server_gb 		= "<%=strServerGb%>";
		var session_user_gb	= "<%=S_USER_GB%>";
		var adminApprovalBtn = "<%=strAdminApprovalBtn %>";

		$("#doc_cd").val(doc_cd);

		$("#btn_save").hide();
		//$("#btn_verify").show();
		$("#btn_draft").show();

		if( adminApprovalBtn == "Y" || (session_user_gb == "99" || session_user_gb == "03") ){
			$("#btn_draft_admin").show();
		} else {
			$("#btn_draft_admin").hide();
		}

		$("#btn_del").show();

	}
	function v_changeBtn(doc_cd) {

		var server_gb 		= "<%=strServerGb%>";
		var session_user_gb	= "<%=S_USER_GB%>";
		var adminApprovalBtn = "<%=strAdminApprovalBtn %>";

		$("#doc_cd").val(doc_cd);

		$("#btn_save").hide();
		$("#btn_v_save").hide();
		$("#btn_verify").show();
		$("#btn_draft").hide();

		if( adminApprovalBtn == "Y" || (session_user_gb == "99" || session_user_gb == "03") ){
			$("#btn_draft_admin").hide();
		} else {
			$("#btn_draft_admin").hide();
		}

		//$("#btn_del").show();
		
		$("#frm2").find("input[name='doc_gb']").val("06");
		$("#frm2").find("input[name='flag']").val("verify");
		$("#frm2").attr("target", "if1");			
		$("#frm2").attr("action", "/tWorks.ez?c=excel_verify");	
		$("#frm2").submit();

	}
	
	function contentsCompare(xmlDocStr) {
		console.log(xmlDocStr);
	    var parser = new DOMParser();
	    var xmlDoc = parser.parseFromString(xmlDocStr, "text/xml");

	    $('#excel_load_tb').hide();
	    $('#v_excel_load_tb').show();
	    $('#ly_g_ret_c').hide();
	    $('#btn_excel').hide();
	    $('#v_ly_total_cnt').html('');
	    $('#ly_g_ret').empty();
	    $('#ly_g_ret').append("<div id='g_ret' class='ui-widget-header ui-corner-all' ></div>");

	    try { viewProgBar(false); } catch (e) {}

	    if (xmlDoc == null) {
	        try { viewProgBar(false); } catch (e) {}
	        return false;
	    }

	    if ($(xmlDoc).find('doc').length == 0 && $(xmlDoc).find('error').length > 0) {
	        goCommonError('<%=sContextPath %>', '_self', $(xmlDoc).find('msg_code').text());
	        return false;
	    }

	    $(xmlDoc).find('doc').each(function () {
	        var items = $(this).find('items');

	        if (items.find('error').length > 0) {
	            $('#g_ret').width($('#ly_g_ret').width());
	            $('#g_ret').height($('#ly_g_ret').height());
	            $('#g_ret').css({ 'overflow': 'auto' });
	            $('#g_ret').html($(this).text());
	            return false;
	        }

	        var rowsObj = $.parseJSON(items.find('json').text());
	        var colsObj = [];
	        var gridObj = {
	            id: "g_ret",
	            colModel: [],
	            rows: [],
	            vscroll: true,
	            hscroll: true
	        };

	        // 순번 컬럼 추가
	        colsObj.push({ formatter: gridCellNoneFormatter, field: 'row_num', id: 'row_num', name: '순번', width: 80, headerCssClass: 'cellCenter', cssClass: 'cellCenter' });
	        
	        var headerArr = [];
	        items.find('item').each(function (i) {
	            var headerText = $(this).text();
	            headerArr.push(headerText); // 헤더 순서에 따라 배열에 추가
	        });

	        var hiddenColumns = new Set();
			
	        // 각 헤더를 순회하며 값이 같거나 빈 값이 있으면 컬럼을 숨김, 하지만 Job은 제외
	        headerArr.forEach(function (header, colIndex) {
			    if (header === "Job") return; // Job 컬럼은 숨기지 않음
			
			    var hasDifference = false;
			
			    rowsObj.forEach(function (row) {
			        var colValue = (row["col" + colIndex] || "").replace(/\s+/g, ' ').trim();
			        if (header === "When") {
			            colValue = colValue.replace(/,"RuleBasedCalendars":\{\}/g, "").replace(/"RuleBasedCalendars":\{\},?/g, "");
			        }
			        var regex = /(.+)↔(.+)/;
			        var match = colValue.match(regex);
			
			        if (match) {
			            var outerValue = match[1].trim();
			            var innerValue = match[2].trim();
						/*if(header==="Description"){
							alert(outerValue);
							alert(innerValue);
							alert(innerValue===outerValue);
						}*/
			            if (outerValue !== innerValue) {
			                hasDifference = true;
			            }
			        } else {
			            if (colValue.trim() !== "") {
			                hasDifference = true;
			            }
			        }
			    });
			    if (!hasDifference) {
			        hiddenColumns.add(header);
			    }
			});

	        // 숨기지 않은 헤더 추가
	        headerArr.forEach(function (header, colIndex) {
	            if (!hiddenColumns.has(header)) {
	                colsObj.push({
	                    formatter: gridCellNoneFormatter,
	                    field: 'col' + (colIndex + 1),
	                    id: 'col' + (colIndex + 1),
	                    name: header,
	                    width: 100,
	                    headerCssClass: 'cellCenter',
	                    cssClass: 'cellLeft'
	                });
	            }
	        });

	        colsObj.push({ formatter: gridCellNoneFormatter, field: 'grid_idx', id: 'grid_idx', name: 'grid_idx', width: 0, minWidth: 0, headerCssClass: 'cellHid', cssClass: 'cellHid' });

	        gridObj.colModel = colsObj;
	        viewGrid_1(gridObj, "ly_" + gridObj.id, { enableColumnReorder: true }, 'AUTO');

	        var orderedRows = [];
	        var sequentialRowNum = 1;  // 순번을 순차적으로 증가시킬 변수

	        // 각 행이 모든 컬럼에서 동일한 값을 갖는지 확인하며 행을 추가
	        rowsObj.forEach(function (row, index) {
			    var allValuesSame = true;
			    var orderedRow = {
			        id: index + 1,
			        row_num: sequentialRowNum,  // 순번을 순차적으로 증가하도록 설정
			        grid_idx: row.grid_idx || index,
			        Job: row["Job"] ? row["Job"].replace(/\r?\n/g, ' ').trim() : "" // Job 컬럼의 줄바꿈을 공백으로 변환 후 trim()
			    };
			
			    headerArr.forEach(function (header, colIndex) {
			        if (!hiddenColumns.has(header)) {
			            var colValue = (row["col" + colIndex] || "").replace(/\s+/g, ' ').trim();
			            if (header === "When") {
			                colValue = colValue.replace(/,"RuleBasedCalendars":\{\}/g, "").replace(/"RuleBasedCalendars":\{\},?/g, "");
			            }
			            var displayValue = colValue;
			
			            var regex = /(.+)↔(.+)/;
			            var match = colValue.match(regex);
			
			            if (match) {
			                var outerValue = match[1].trim();
			                var innerValue = match[2].trim();
			
			                if (outerValue === innerValue) {
			                    displayValue = outerValue; // 값이 같으면 앞의 값만 출력
			                } else {
			                    displayValue = outerValue + '↔<span style="color: red;">' + innerValue + '</span>';
			                    allValuesSame = false;
			                }
			            } else {
			                if (colValue.trim() !== "") {
			                    allValuesSame = false;
			                }
			            }
			
			            orderedRow["col" + (colIndex + 1)] = displayValue;
			        }
			    });
			
			    if (!allValuesSame || orderedRow.Job) {
			        orderedRow.row_num = sequentialRowNum++;  // 표시된 순번만 증가
			        orderedRows.push(orderedRow); // 재배열된 행을 추가
			    }
			});

	        gridObj.rows = orderedRows;
	        setGridRows(gridObj);

	        $('#v_ly_total_cnt').html('[ TOTAL : ' + orderedRows.length + ' ]');

	        setTimeout(function () {
	            $('body').resizeAllColumns();
	        }, 450);
	        
	        if(orderedRows.length === 0){
	        	alert("변경된 항목이 존재하지 않습니다.");
	        }
	    });

	    try { viewProgBar(false); } catch (e) {}
	}


	//고쳐야한다
	function goPrc(flag, grp_approval_userList, grp_alarm_userList, title){

		var post_approval_yn = "";
		
		try{viewProgBar(true);}catch(e){}
		 
		if( !confirm('처리하시겠습니까?') ) return;
		setGridSelectedRowsAll(gridObj_3);

		if(flag == 'post_draft'){
			post_approval_yn	= "Y";
		}else{
			post_approval_yn	= "N";
		}
		
		$("#frm2").find("input[name='doc_gb']").val("06");
		$("#frm2").find("input[name='flag']").val(flag);
		$("#frm2").find("input[name='grp_approval_userList']").val(grp_approval_userList);
		$("#frm2").find("input[name='grp_alarm_userList']").val(grp_alarm_userList);
		$("#frm2").find("input[name='post_approval_yn']").val(post_approval_yn);
		$("#frm2").find("input[name='title']").val(title);
		$("#frm2").attr("target", "if1");			
		$("#frm2").attr("action", "/tWorks.ez?c=ez004_p");	
		$("#frm2").submit();

		try{viewProgBar(false);}catch(e){}

	}

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
				if(col.indexOf("\\") > -1){
 					col =  col.replaceAll("\\\\", "\\\\\\\\");
				}
				if(col.indexOf("\'") > -1){
					col =  col.replaceAll("\'", "\\\\'");
				}
%>				
				,'<%=col_title%>': '<%=col%>'
<%
			}
%>
			,'FORECAST':<%=i%>
		});
		
		++cnt;
<%
	}
%>
		
		gridObj_3.rows = rowsObj_job3;
		setGridRows(gridObj_3);	
		
		//컬럼 자동 조정 기능
		$('body').resizeAllColumns();
		
		$('#ly_total_cnt').html('[ TOTAL : '+cnt+' ]');
		try{viewProgBar(false);}catch(e){}
		
	}
	//엑셀로드 FORCAST
	function fn_sch_forecast(row) {
		var frm = document.f_s;

		var sched_table = getCellValue(gridObj_3,row,'job2');
		var job_name = getCellValue(gridObj_3,row,'job8');
		var obj = null;

		var s = "";
		var week_days_text = getCellValue(gridObj_3,row,'job45');

		if ( s == "" ) {
			s = week_days_text;
		} else {
			s = s + "," + week_days_text;
		}

		// 중복된 실행요일은 빼기 위해.
		if ( s != "" && s.indexOf(",")>-1 ) {

			var arrS = s.split(",");
			arrS.sort();

			var i = -1, j = arrS.length;

			while (++i < j-1) {
				if (arrS[i] == arrS[i+1]) {
					arrS[i] = '';
				}
			}

			s = arrS.toString();

			s = replaceAll(s, ",,", ",");
		}

		frm.week_days.value = s;

		//-- 작업스케줄 체크 Start. --//
		var cell_month_days = getCellValue(gridObj_3,row,'job30');
		var cell_days_cal 	= getCellValue(gridObj_3,row,'job31');
		frm.month_days.value = cell_month_days;
		frm.days_cal.value = cell_days_cal;

		var month_days 	= document.getElementById('month_days');
		var days_cal 	= document.getElementById('days_cal');

		// 실행날짜 및 월캘린더 체크.(calendar.js)
		if ( fn_check_days(month_days, days_cal) == false ) {
			return;
		}

		var week_days 	= frm.week_days;
		var cell_weeks_cal 	= getCellValue(gridObj_3,row,'job46');
		frm.weeks_cal.value = cell_weeks_cal;

		var weeks_cal 	= document.getElementById('weeks_cal');
		// 실행요일 및 일캘린더 체크.(calendar.js)
		if ( fn_check_weeks(week_days, weeks_cal) == false ) {
			return;
		}

		var cell_t_general_date 	= getCellValue(gridObj_3,row,'job47');
		frm.t_general_date.value 	= cell_t_general_date;
		//-- 작업스케줄 체크 End. --//

		openPopupCenter2("about:blank", "fn_sch_forecast", 1000, 500);

		frm.action = "<%=sContextPath %>/tWorks.ez?c=ez033";
		frm.target = "fn_sch_forecast";
		frm.submit();
	}

</script>

<%@include file="/jsp/common/inc/progBar.jsp"  %>
<iframe name="if1" id="if1" width="0" height="0"></iframe>
<div id="dl_p01" style='overflow:hidden;display:none;padding:0;'>
	<iframe id='if_p01' name='if_p01' src='about:blank' width='0px' height='0px' scrolling='no'  frameborder="0"  ></iframe>
</div>
</html>
