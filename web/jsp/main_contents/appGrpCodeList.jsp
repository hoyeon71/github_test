<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/jsp/common/inc/header.jsp"%>

<%
	Map<String, Object> paramMap = CommonUtil.collectParameters(request);
	String c = CommonUtil.isNull(paramMap.get("c"));
	String gridId_1 = "g_"+c+"_1";
	String gridId_2 = "g_"+c+"_2";
	String gridId_3 = "g_"+c+"_3";
	
	String menu_gb = CommonUtil.getMessage("CATEGORY.GB.06.GB."+CommonUtil.isNull(paramMap.get("menu_gb")));
	String[] arr_menu_gb = menu_gb.split(",");
	
	String strSessionDcCode 	= S_D_C_CODE;
	if(!strSessionDcCode.equals("")) {
		String[] arr_sessionDcCode = strSessionDcCode.split(",");
		strSessionDcCode = arr_sessionDcCode[0];
	}
%>

<style type="text/css">

.filebox label{
	display: inline-block;
	padding: .5em .75em
	color: #999
	font-size: inherit;
	line-height: normal;
	vertical-align: middle;
	background-color: #fdfdfd;
	cursor: pointer;
	border: 1px solid #ebebeb;
	border-bottom-color: #e2e2e2;
	border-radius: .25em;
	width:65px;
	height:21px;
}

.filebox input[type="file"]{
	position: absolute;
	width:1px;   
	height:1px;
	padding: 0;
	margin: -1px;
	overflow: hidden;
	clip:rect(0,0,0,0);	  
	border: 0;
}
</style>

<form id="f_s" name="f_s" method="post" onsubmit="return false;">	
	<input type="hidden" name="grp_cd" id="grp_cd" />
	<input type="hidden" name="grp_parent_cd" id="grp_parent_cd"/>
</form>
<form id="frm7" name="frm7" method="post" onsubmit="return false;">	
	<input type="hidden" name="flag" 			id="flag" />
	<input type="hidden" name="grp_cd" 			id="grp_cd" />
	<input type="hidden" name="scode_cd" 		id="scode_cd" />
	<input type="hidden" name="grp_depth" 		id="grp_depth" />
	<input type="hidden" name="grp_parent_cd" 	id="grp_parent_cd" />
	<input type="hidden" name="folder_nm" 		id="folder_nm" />
	<input type="hidden" name="application_nm" 	id="application_nm" />
	<input type="hidden" name="group_nm" 		id="group_nm" />
	
	<input type="hidden" name="grp_cd_list" 		id="grp_cd_list" />
	<input type="hidden" name="folder_nm_list" 		id="folder_nm_list" />
	<input type="hidden" name="application_nm_list" id="application_nm_list" />
	<input type="hidden" name="group_nm_list" 		id="group_nm_list" />
</form>
<form id="frm9" name="frm9" method="post" onsubmit="return false;">	
	<input type="hidden" name="grp_depth" id="grp_depth" />
</form>

<table style='width:100%;height:100%;border:none;'>
	<tr style='height:10px;'>
		<td colspan="3" style='vertical-align:top;'>
			<h4 class="ui-widget-header ui-corner-all"  >
				<div id='t_<%=gridId_1 %>' class='title_area' >
					<span><%=CommonUtil.isNull(CommonUtil.getMessage("CATEGORY.GB.06"))%> > <%=CommonUtil.isNull(arr_menu_gb[0]) %></span>
				</div>
			</h4>
		</td>
	</tr>
	
	<tr><td style="height:10px;"></td></tr>
	<tr>
		<td colspan="3" style="height:15px;">	
			<b>C-M</b> : 
			<select name="main_grp_nm" id="main_grp_nm" style="width:155px;height:21px;">
				<option value="">--선택--</option>
				<c:forEach var="scodeGrpList" items="${SCODE_GRP_LIST}" varStatus="status">
					<option value="${scodeGrpList.scode_cd}" data="${scodeGrpList.scode_eng_nm}">${scodeGrpList.scode_nm}</option>
				</c:forEach>
			</select>
						
		</td>
	</tr>
	<tr><td style="height:10px;"></td></tr>
	<tr style='height:10px;'>
		<td colspan="3" style="vertical-align:top;">
			<table style="width:100%;">
				<tr>
					<td style="width:40%;text-align:left;">그룹정보&nbsp;<span id="groupInfo"></span></td>
					<td style="width:60%;text-align:right;">
						<select name="search_gubun" id="search_gubun" style="width:120px;height:21px;">
							<option value="t">전체검색</option>
							<option value="e">폴더</option>
							<option value="h">어플리케이션</option>
							<option value="L4">그룹</option>
						</select>&nbsp;
						<input type="text" name="grp_nm" id="grp_nm" style="width:150px;height:19px;"/>&nbsp;
						<span id="btn_search" style='margin:3px;'>검색</span>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td style='width:40%;'>
			<table style="width:100%;height:100%;border:none;">
				<tr>					
					<td id='ly_<%=gridId_1 %>' style='vertical-align:top;'>
						<div id="<%=gridId_1 %>" class="ui-widget-header ui-corner-all"></div>
					</td>					
				</tr>
				<tr style='height:10px;'>
					<td style='vertical-align:top;'>
						<h4 class="ui-widget-header ui-corner-all">
							<div align='right' class='btn_area'>
								<div id='ly_total_cnt_1' style='padding-top:5px;float:left;'></div>
								<span id="btn_excel_add">엑셀등록</span>
								<span id="btn_svc_cm">테이블이관</span>
								<span id="btn_host_add">수행서버일괄변경</span>
								<span id="btn_add">추가</span>
								<span id="btn_edit">수정</span>
								<span id="btn_del">삭제</span>
							</div>
						</h4>
					</td>
				</tr>
			</table>			
		</td>
		<td style='width:35%;'>
			<table style="width:100%;height:100%;border:none;">
				<tr>					
					<td id='ly_<%=gridId_2 %>' style='vertical-align:top;'>
						<div id="<%=gridId_2 %>" class="ui-widget-header ui-corner-all"></div>
					</td>					
				</tr>
				<tr style='height:10px;'>
					<td style='vertical-align:top;'>
						<h4 class="ui-widget-header ui-corner-all">
							<div align='right' class='btn_area'>
								<div id='ly_total_cnt_2' style='padding-top:5px;float:left;'></div>
								<span id="btn_app_cm">어플리케이션이관</span>
								<span id="btn_app_add">추가</span>
								<span id="btn_app_edit">수정</span>
								<span id="btn_app_del">삭제</span>
							</div>
						</h4>
					</td>
				</tr>
			</table>			
		</td>
		<td style="width:25%">
			<table style="width:100%;height:100%;border:none;">
				<tr>					
					<td id='ly_<%=gridId_3 %>' style='vertical-align:top;'>
						<div id="<%=gridId_3 %>" class="ui-widget-header ui-corner-all"></div>
					</td>					
				</tr>
				<tr style='height:10px;'>
					<td style='vertical-align:top;'>
						<h4 class="ui-widget-header ui-corner-all">
							<div align='right' class='btn_area'>
								<div id='ly_total_cnt_3' style='padding-top:5px;float:left;'></div>
								<span id="btn_sub_cm">그룹이관</span>
								<span id="btn_sub_add">추가</span>
								<span id="btn_sub_edit">수정</span>
								<span id="btn_sub_del">삭제</span>
							</div>
						</h4>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>

<script>
	
	function gridCellCustomFormatter(row,cell,value,columnDef,dataContext){
		
		var ret = "";
		var grp_cd = getCellValue(gridObj_1,row,'GRP_CD');
		var grp_nm = getCellValue(gridObj_1,row,'GRP_NM');
		var scode_cd = getCellValue(gridObj_1,row,'SCODE_CD');
		var grp_depth = getCellValue(gridObj_1,row,'GRP_DEPTH');
		var grp_eng_nm = getCellValue(gridObj_1,row,'GRP_ENG_NM');
		
		if(columnDef.id == 'USER_LIST'){
// 			ret = "<a href=\"JavaScript:getAppCodeList('"+scode_cd+"','2','"+grp_cd+"','"+grp_nm+"');\" /><font color='red'>"+value+"</font></a>";
			ret = "<a href=\"JavaScript:goUserSearch('"+grp_eng_nm+"');\" /><font color='red'>"+value+"</font></a>";
		}
		
		return ret;
	}
	
	function gridCellCustomFormatter2(row,cell,value,columnDef,dataContext){
		
		var ret = "";
		var grp_cd = getCellValue(gridObj_2,row,'GRP_CD');
		var grp_nm = getCellValue(gridObj_2,row,'GRP_NM');
		var scode_cd = getCellValue(gridObj_2,row,'SCODE_CD');
		var grp_depth = getCellValue(gridObj_2,row,'GRP_DEPTH');
				
		if(columnDef.id == 'GRP_ENG_NM'){
			ret = "<a href=\"JavaScript:getSubCodeList('"+scode_cd+"','3','"+grp_cd+"','"+grp_nm+"');\" /><font color='red'>"+value+"</font></a>";
		}
						
		return ret;
	}
	
	var gridObj_1 = {
		id : "<%=gridId_1 %>"
		,colModel:[
	   		{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'번호',width:50,headerCssClass:'cellCenter',cssClass:'cellCenter'}
// 	   		,{formatter:gridCellCustomFormatter,field:'GRP_NM',id:'GRP_NM',name:'테이블(한글)',width:150,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'GRP_ENG_NM',id:'GRP_ENG_NM',name:'폴더',minWidth:140,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'JOB_CNT',id:'JOB_CNT',name:'등록 작업',minWidth:80,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
// 	   		,{formatter:gridCellNoneFormatter,field:'GRP_USE_NM',id:'GRP_USE_NM',name:'사용구분',width:70,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'USER_DAILY',id:'USER_DAILY',name:'USER_DAILY',minWidth:100,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'CTM_USER_DAILY',id:' CTM_USER_DAILY',name:' CTM_USER_DAILY',minWidth:120,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'HOST_NM',id:'HOST_NM',name:'수행서버',minWidth:230,headerCssClass:'cellCenter',cssClass:'cellLeft'}
	   		,{formatter:gridCellNoneFormatter,field:'GRP_DESC',id:'GRP_DESC',name:'설명',minWidth:150,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
	   		,{formatter:gridCellCustomFormatter,field:'USER_LIST',id:'USER_LIST',name:'사용자',minWidth:80,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	   		
	   		,{formatter:gridCellNoneFormatter,field:'GRP_CD',id:'GRP_CD',name:'GRP_CD',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   		,{formatter:gridCellNoneFormatter,field:'SCODE_CD',id:'SCODE_CD',name:'SCODE_CD',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   		,{formatter:gridCellNoneFormatter,field:'GRP_DEPTH',id:'GRP_DEPTH',name:'GRP_DEPTH',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   		,{formatter:gridCellNoneFormatter,field:'GRP_USE_YN',id:'GRP_USE_YN',name:'GRP_USE_YN',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   		,{formatter:gridCellNoneFormatter,field:'GRP_PARENT_CD',id:'GRP_PARENT_CD',name:'GRP_PARENT_CD',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   		,{formatter:gridCellNoneFormatter,field:'HOST_CD',id:'HOST_CD',name:'HOST_CD',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   		,{formatter:gridCellNoneFormatter,field:'HOST_DESC',id:'HOST_DESC',name:'HOST_DESC',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   		,{formatter:gridCellNoneFormatter,field:'CHK_CTM_FOLDER',id:'CHK_CTM_FOLDER',name:'CHK_CTM_FOLDER',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   	]
		,rows:[]
		,vscroll:<%=S_GRID_VSCROLL%>
	};
	
	var gridObj_2 = {
		id : "<%=gridId_2 %>"
			,colModel:[
	   		{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'번호',minWidth:50,headerCssClass:'cellCenter',cssClass:'cellCenter'}
// 	   		,{formatter:gridCellCustomFormatter2,field:'GRP_NM',id:'GRP_NM',name:'어플리케이션(한글)',width:150,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}	
	   		,{formatter:gridCellNoneFormatter,field:'GRP_ENG_NM',id:'GRP_ENG_NM',name:'어플리케이션',minWidth:130,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'APP_JOB_CNT',id:'APP_JOB_CNT',name:'등록 작업',minWidth:80,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
// 		   	,{formatter:gridCellNoneFormatter,field:'GRP_USE_NM',id:'GRP_USE_NM',name:'사용구분',width:70,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
		   	,{formatter:gridCellNoneFormatter,field:'GRP_DESC',id:'GRP_DESC',name:'설명',minWidth:150,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
	   		
	   		,{formatter:gridCellNoneFormatter,field:'GRP_CD',id:'GRP_CD',name:'GRP_CD',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   		,{formatter:gridCellNoneFormatter,field:'SCODE_CD',id:'SCODE_CD',name:'SCODE_CD',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   		,{formatter:gridCellNoneFormatter,field:'GRP_DEPTH',id:'GRP_DEPTH',name:'GRP_DEPTH',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   		,{formatter:gridCellNoneFormatter,field:'GRP_USE_YN',id:'GRP_USE_YN',name:'GRP_USE_YN',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   		,{formatter:gridCellNoneFormatter,field:'GRP_PARENT_CD',id:'GRP_PARENT_CD',name:'GRP_PARENT_CD',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   		,{formatter:gridCellNoneFormatter,field:'FOLDER_NM',id:'FOLDER_NM',name:'FOLDER_NM',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   	]
		,rows:[]
		,vscroll:<%=S_GRID_VSCROLL%>
	};
	
	var gridObj_3 = {
		id : "<%=gridId_3 %>"
		,colModel:[
	   		{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'번호',width:50,headerCssClass:'cellCenter',cssClass:'cellCenter'}
// 	   		,{formatter:gridCellNoneFormatter,field:'GRP_NM',id:'GRP_NM',name:'그룹(한글)',width:150,headerCssClass:'cellCenter',cssClass:'cellLeft'}	
	   		,{formatter:gridCellNoneFormatter,field:'GRP_ENG_NM',id:'GRP_ENG_NM',name:'그룹',minWidth:130,headerCssClass:'cellCenter',cssClass:'cellLeft'}
	   		,{formatter:gridCellNoneFormatter,field:'GRP_JOB_CNT',id:'GRP_JOB_CNT',name:'등록 작업',minWidth:80,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
//	   		,{formatter:gridCellNoneFormatter,field:'HOST_NM',id:'HOST_NM',name:'수행서버',width:150,headerCssClass:'cellCenter',cssClass:'cellLeft'}
// 	   		,{formatter:gridCellNoneFormatter,field:'GRP_USE_NM',id:'GRP_USE_NM',name:'사용구분',width:70,headerCssClass:'cellCenter',cssClass:'cellCenter'}
	   		,{formatter:gridCellNoneFormatter,field:'GRP_DESC',id:'GRP_DESC',name:'설명',minWidth:150,headerCssClass:'cellCenter',cssClass:'cellLeft'}
	   		
	   		,{formatter:gridCellNoneFormatter,field:'GRP_CD',id:'GRP_CD',name:'GRP_CD',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   		,{formatter:gridCellNoneFormatter,field:'SCODE_CD',id:'SCODE_CD',name:'SCODE_CD',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   		,{formatter:gridCellNoneFormatter,field:'GRP_DEPTH',id:'GRP_DEPTH',name:'GRP_DEPTH',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   		,{formatter:gridCellNoneFormatter,field:'GRP_USE_YN',id:'GRP_USE_YN',name:'GRP_USE_YN',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   		,{formatter:gridCellNoneFormatter,field:'GRP_PARENT_CD',id:'GRP_PARENT_CD',name:'GRP_PARENT_CD',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
//	   		,{formatter:gridCellNoneFormatter,field:'HOST_CD',id:'HOST_CD',name:'HOST_CD',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
//	   		,{formatter:gridCellNoneFormatter,field:'HOST_DESC',id:'HOST_DESC',name:'HOST_DESC',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
			,{formatter:gridCellNoneFormatter,field:'FOLDER_NM',id:'FOLDER_NM',name:'FOLDER_NM',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
			,{formatter:gridCellNoneFormatter,field:'APPLICATION_NM',id:'APPLICATION_NM',name:'APPLICATION_NM',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   	]
		,rows:[]
		,vscroll:<%=S_GRID_VSCROLL%>
	};
	
	$(document).ready(function(){
		
		var session_dc_code = "<%= strSessionDcCode %>";
		
		viewGrid_1(gridObj_1,"ly_"+gridObj_1.id,{enableColumnReorder:true},'AUTO');
		viewGrid_1(gridObj_2,"ly_"+gridObj_2.id);
		viewGrid_1(gridObj_3,"ly_"+gridObj_3.id);
		
		if(session_dc_code != '') {
			$("select[name='main_grp_nm']").val(session_dc_code);
		}else{
			$("#main_grp_nm option:eq(1)").prop("selected", true);
		}
		
		$("#main_grp_nm").change(function(){
			var scode_cd = $("select[name='main_grp_nm'] option:selected").val();
			var scode_nm = $("select[name='main_grp_nm'] option:selected").text();
			$("#groupInfo").text("["+scode_nm+"]");
			
			getCodeList(scode_cd, "1");			
		});
		
		$("#btn_excel_add").button().unbind("click").click(function() {
			var scode_cd = $("select[name='main_grp_nm'] option:selected").val();
			var scode_nm = $("select[name='main_grp_nm'] option:selected").text();
			if(scode_cd == ""){
				alert("C-M을 선택해 주세요.");
				return;
			}else{
				popupExcelCode(scode_cd, 1);
			}
		})
		
		$("#btn_svc_cm").button().unbind("click").click(function() {
			popupAppGrpCodeForm("테이블",1);
		});
		
		//체크박스 설정
		//viewGridChk_2(gridObj_1,"ly_"+gridObj_1.id);
		
		$("#btn_add").button().unbind("click").click(function(){
			
			var scode_cd = $("select[name='main_grp_nm'] option:selected").val();
			var scode_nm = $("select[name='main_grp_nm'] option:selected").text();
			
			if(scode_cd == ""){
				alert("C-M을 선택해 주세요.");
				return;
			}else{
				codeInsert(scode_cd, scode_nm);
			}
		});
		
		$("#btn_edit").button().unbind("click").click(function(){
			codeEdit();
		});
		
		$("#btn_del").button().unbind("click").click(function(){
			codeDelete('1');
		});
		
		$("#btn_host_add").button().unbind("click").click(function(){
			var scode_cd = $("select[name='main_grp_nm'] option:selected").val();
			
			if(scode_cd == ""){
				alert("C-M을 선택해 주세요.");
				return;
			}else{
				hostChange();
			}
		});
		
		$("#btn_app_cm").button().unbind("click").click(function() {
			popupAppGrpCodeForm("어플리케이션",2);
		});
		
		$("#btn_app_add").button().unbind("click").click(function(){
			var scode_cd = $("select[name='main_grp_nm'] option:selected").val();
			
			if(scode_cd == ""){
				alert("C-M을 선택해 주세요.");
				return;
			}else{
				var grp_cd = $("#f_s").find("input[name='grp_cd']").val();
				if(grp_cd == "" || grp_cd == 0){
					alert("폴더를 선택해 주세요.");
					return;
				}else{
					codeAppInsert(scode_cd, grp_cd);
				}
			}
		});
		
		$("#btn_app_edit").button().unbind("click").click(function(){
			codeAppEdit();
		});
		
		$("#btn_app_del").button().unbind("click").click(function(){
			codeDelete('2');
		});
		
		$("#btn_sub_cm").button().unbind("click").click(function() {
			popupAppGrpCodeForm("그룹",3);
		});
		
		$("#btn_sub_add").button().unbind("click").click(function(){
			var scode_cd = $("select[name='main_grp_nm'] option:selected").val();
			
			if(scode_cd == ""){
				alert("C-M을 선택해 주세요.");
				return;
			}else{
				var grp_cd = $("#f_s").find("input[name='grp_parent_cd']").val();
				if(grp_cd == ""){
					alert("어플리케이션을 선택해 주세요.");
					return;
				}else{
					codeSubInsert(scode_cd, grp_cd);
				}
			}
		});
		
		$("#btn_sub_edit").button().unbind("click").click(function(){
			codeSubEdit();
		});
		
		$("#btn_sub_del").button().unbind("click").click(function(){
			codeDelete('3');
		});
		
		$("#btn_search").button().unbind("click").click(function(){
			var data_center = $("select[name='main_grp_nm'] option:selected").val();
			
			if(data_center == ""){
				alert("C-M 을 선택해 주세요.");
				return;
			}
			
			var scode_cd = $("select[name='main_grp_nm'] option:selected").val();
			var scode_nm = $("select[name='main_grp_nm'] option:selected").text();
			$("#groupInfo").text("["+scode_nm+"]");

			getCodeList(scode_cd, "1");
		});
		
		$('#grp_nm').unbind('keypress').keypress(function(e){			
			if(e.keyCode==13){	
				var data_center = $("select[name='main_grp_nm'] option:selected").val();
				
				if(data_center == ""){
					alert("C-M 을 선택해 주세요.");
					return;
				}
				
				var scode_cd = $("select[name='main_grp_nm'] option:selected").val();
				var scode_nm = $("select[name='main_grp_nm'] option:selected").text();
				$("#groupInfo").text("["+scode_nm+"]");
				
				getCodeList(scode_cd, "1");
			}
		});
		
		$('#'+gridObj_1.id).data('grid').onClick.subscribe(function (e, args) {
			var grid = $('#'+gridObj_1.id).data('grid');
			var cell = grid.getCellFromEvent(e);
			var ret = "";
			var grp_cd = getCellValue(gridObj_1,cell.row,'GRP_CD');
			var foler_nm = getCellValue(gridObj_1,cell.row,'GRP_ENG_NM');
			var scode_cd = getCellValue(gridObj_1,cell.row,'SCODE_CD');
			var grp_depth = getCellValue(gridObj_1,cell.row,'GRP_DEPTH');
			
			clearGridSelected(gridObj_2); //선택된 전체항목 해제 */
			
			getAppCodeList(scode_cd, '2', grp_cd, foler_nm);
		
		});	
		
		$('#'+gridObj_2.id).data('grid').onClick.subscribe(function (e, args) {
			var grid = $('#'+gridObj_2.id).data('grid');
			var cell = grid.getCellFromEvent(e);
			var ret = "";
			var grp_cd = getCellValue(gridObj_2,cell.row,'GRP_CD');
			var application_nm = getCellValue(gridObj_2,cell.row,'GRP_ENG_NM');
			var scode_cd = getCellValue(gridObj_2,cell.row,'SCODE_CD');
			var grp_depth = getCellValue(gridObj_2,cell.row,'GRP_DEPTH');
			var folder_nm = getCellValue(gridObj_2,cell.row,'FOLDER_NM');
			
			clearGridSelected(gridObj_3); //선택된 전체항목 해제 */
			
		    getSubCodeList(scode_cd, '3', grp_cd, application_nm, folder_nm);
		});	
	});
	
	function getCodeList(scode_cd, grp_depth){
		
		console.log("scode_cd  : " + scode_cd);
		console.log("grp_depth : " + grp_depth);
		try{viewProgBar(true);}catch(e){}
		$('#ly_total_cnt_1').html('');
		
		var search_gubun = $("select[name='search_gubun'] option:selected").val();
		var grp_nm = $("#grp_nm").val();
		
		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=appGrpList&itemGubun=2&scode_cd='+scode_cd+'&grp_depth='+grp_depth+'&search_gubun='+search_gubun+'&grp_nm='+encodeURIComponent(grp_nm);
		
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
												
						if(items.attr('cnt')=='0'){
						}else{
							items.find('item').each(function(i){						
							
								var grp_cd 			= $(this).find("GRP_CD").text();
// 								var grp_nm 			= $(this).find("GRP_NM").text();								
								var grp_eng_nm 		= $(this).find("GRP_ENG_NM").text();
								var grp_use_yn 		= $(this).find("GRP_USE_YN").text();
								var grp_desc 		= $(this).find("GRP_DESC").text();
								var scode_cd 		= $(this).find("SCODE_CD").text();
								var grp_depth 		= $(this).find("GRP_DEPTH").text();
								var grp_parent_cd 	= $(this).find("GRP_PARENT_CD").text();
								var user_daily 		= $(this).find("USER_DAILY").text();
								var ctm_user_daily	= $(this).find("CTM_USER_DAILY").text();
								var chk_ctm_folder	= $(this).find("CHK_CTM_FOLDER").text();
								var job_cnt			= $(this).find("JOB_CNT").text();
								var host_cd 		= $(this).find("HOST_CD").text();
								var arr_host_cd 	= $(this).find("ARR_HOST_CD").text();
								var arr_host_nm 	= $(this).find("ARR_HOST_NM").text();
								var arr_host_desc 	= $(this).find("ARR_HOST_DESC").text();
								var table_type 		= $(this).find("TABLE_TYPE").text();
								
								var v_grp_use_yn = "";
								if(grp_use_yn == "Y"){
									v_grp_use_yn = "사용";
								}else{
									v_grp_use_yn = "미사용";
								}	
								if(chk_ctm_folder == "NOTEXIST") {
									ctm_user_daily = "폴더없음";
								}
								var host_nm = "";
								<c:forEach var = "hostList" items="${HOST_LIST}">
									if(host_cd == "${hostList.host_cd}"){
										host_nm = "${hostList.node_nm}(${hostList.node_id})";
									}
								</c:forEach>
								
								// 스마트 폴더일 경우 왕관 표시 (2024.05.02 강명준)
								var smart_folder = "";
								if ( table_type == 2 ) {
									smart_folder = "<img src='<%=sContextPath %>/imgs/smart_folder.png' style='vertical-align:middle;' width='20' height='20'> ";
								}
																																																	
								rowsObj.push({
									'grid_idx'			:i+1
									,'GRP_CD'			: grp_cd
// 									,'GRP_NM'			: grp_nm
									,'GRP_ENG_NM'		: smart_folder + grp_eng_nm
// 									,'GRP_USE_NM'		: v_grp_use_yn									
									,'GRP_DESC'			: grp_desc		
									,'SCODE_CD'			: scode_cd
									,'GRP_DEPTH'		:grp_depth
									,'GRP_USE_YN'		: grp_use_yn
									,'GRP_PARENT_CD'	: grp_parent_cd
									,'USER_DAILY'		: user_daily
									,'CTM_USER_DAILY'	: ctm_user_daily
									,'CHK_CTM_FOLDER'	: chk_ctm_folder
									,'HOST_CD'			: arr_host_cd
									,'HOST_NM'			: arr_host_nm
									,'HOST_DESC'		: arr_host_desc
									,'JOB_CNT'			: job_cnt + "건"
									,'USER_LIST'		: "[조회]"
								});
								
							});						
						}
						var rowsObj_tmp = new Array();
						gridObj_2.rows = rowsObj_tmp;
						gridObj_3.rows = rowsObj_tmp;
						
						
						gridObj_1.rows = rowsObj;
						setGridRows(gridObj_1);
						setGridRows(gridObj_2);
						setGridRows(gridObj_3);
						
						$('body').resizeAllColumns();
						$('#ly_total_cnt_1').html('[ TOTAL : '+items.attr('cnt')+' ]');
						
					});
					try{viewProgBar(false);}catch(e){}
				}
		, null );
		
		xhr.sendRequest();
	}
	
	
	function getAppCodeList(scode_cd, grp_depth, grp_cd, foler_nm){
		
		$("#f_s").find("input[name='grp_cd']").val(grp_cd);
		
// 		if(grp_nm != "") $("#f_s").find("input[name='grp_parent_nm']").val(grp_nm);
		
// 		var v_grp_nm = "";
// 		v_grp_nm = grp_nm;
// 		if(v_grp_nm == "") v_grp_nm = $("#f_s").find("input[name='grp_parent_nm']").val();
			
// 		$("#codeInfo").text("["+v_grp_nm+"]");
		
		try{viewProgBar(true);}catch(e){}
		$('#ly_total_cnt_2').html('');
		
		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=appGrpList&itemGubun=2&scode_cd='+scode_cd+'&grp_depth='+grp_depth+'&grp_parent_cd='+grp_cd;
		
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
												
						if(items.attr('cnt')=='0'){
						}else{
							items.find('item').each(function(i){
							
								var grp_cd 			= $(this).find("GRP_CD").text();
								var grp_nm 			= $(this).find("GRP_NM").text();								
								var grp_eng_nm 		= $(this).find("GRP_ENG_NM").text();
								var grp_use_yn 		= $(this).find("GRP_USE_YN").text();
								var grp_desc 		= $(this).find("GRP_DESC").text();
								var scode_cd 		= $(this).find("SCODE_CD").text();
								var grp_depth 		= $(this).find("GRP_DEPTH").text();
								var grp_parent_cd 	= $(this).find("GRP_PARENT_CD").text();
								var app_job_cnt			= $(this).find("APP_JOB_CNT").text();
								var v_grp_use_yn 	= "";
								
								if(grp_use_yn == "Y"){
									v_grp_use_yn = "사용";
								}else{
									v_grp_use_yn = "미사용";
								}								
																																																		
								rowsObj.push({
									'grid_idx'		: i+1
									,'GRP_CD'		: grp_cd
									,'GRP_NM'		: grp_nm
									,'GRP_ENG_NM'	: grp_eng_nm
// 									,'GRP_USE_NM'	: v_grp_use_yn									
									,'GRP_DESC'		: grp_desc		
									,'SCODE_CD'		: scode_cd
									,'GRP_DEPTH'	: grp_depth
									,'GRP_USE_YN'	: grp_use_yn
									,'GRP_PARENT_CD': grp_parent_cd
									,'APP_JOB_CNT'	: app_job_cnt + "건"
									,'FOLDER_NM'	: foler_nm
								});
								
							});						
						}
						
						var rowsObj_tmp = new Array();
						gridObj_3.rows = rowsObj_tmp;

						gridObj_2.rows = rowsObj;
						setGridRows(gridObj_2);
						setGridRows(gridObj_3);
						$('#ly_total_cnt_2').html('[ TOTAL : '+items.attr('cnt')+' ]');
						$('#ly_total_cnt_3').html('');
					});
					try{viewProgBar(false);}catch(e){}
				}
		, null );
		
		xhr.sendRequest(); 
	}
	
	function getSubCodeList(scode_cd, grp_depth, grp_cd, application_nm, folder_nm){
 		
 		$("#f_s").find("input[name='grp_parent_cd']").val(grp_cd);
// 		$("#f_s").find("input[name='grp_cd']").val(grp_cd);
		
// 		if(grp_nm != "") $("#f_s").find("input[name='grp_parent_nm']").val(grp_nm);
		
// 		var v_grp_nm = "";
// 		v_grp_nm = grp_nm;
// 		if(v_grp_nm == "") v_grp_nm = $("#f_s").find("input[name='grp_parent_nm']").val();
			
// 		$("#codeInfo").text("["+v_grp_nm+"]");
		
		try{viewProgBar(true);}catch(e){}
		$('#ly_total_cnt_3').html('');
		
		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=appGrpList&itemGubun=2&scode_cd='+scode_cd+'&grp_depth='+grp_depth+'&grp_parent_cd='+grp_cd;
		
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
												
						if(items.attr('cnt')=='0'){
						}else{
							items.find('item').each(function(i){						
							
								var grp_cd 			= $(this).find("GRP_CD").text();
								var grp_nm 			= $(this).find("GRP_NM").text();								
								var grp_eng_nm 		= $(this).find("GRP_ENG_NM").text();
								var grp_use_yn 		= $(this).find("GRP_USE_YN").text();
								var grp_desc 		= $(this).find("GRP_DESC").text();
								var scode_cd 		= $(this).find("SCODE_CD").text();
								var grp_depth 		= $(this).find("GRP_DEPTH").text();
								var grp_parent_cd 	= $(this).find("GRP_PARENT_CD").text();
								var host_cd 		= $(this).find("HOST_CD").text();
								var arr_host_cd 	= $(this).find("ARR_HOST_CD").text();
								var arr_host_nm 	= $(this).find("ARR_HOST_NM").text();
								var arr_host_desc 	= $(this).find("ARR_HOST_DESC").text();
								var grp_job_cnt		= $(this).find("GRP_JOB_CNT").text();
								
								var v_grp_use_yn = "";
								if(grp_use_yn == "Y"){
									v_grp_use_yn = "사용";
								}else{
									v_grp_use_yn = "미사용";
								}
								
								var host_nm = "";
								<c:forEach var = "hostList" items="${HOST_LIST}">
									if(host_cd == "${hostList.host_cd}"){
										host_nm = "${hostList.node_nm}(${hostList.node_id})";
									}
								</c:forEach>

								rowsObj.push({
									'grid_idx':i+1
									,'GRP_CD': grp_cd
									,'GRP_NM': grp_nm
									,'GRP_ENG_NM': grp_eng_nm
// 									,'GRP_USE_NM': v_grp_use_yn									
									,'GRP_DESC': grp_desc	
									,'SCODE_CD': scode_cd
									,'GRP_DEPTH': grp_depth
									,'GRP_USE_YN': grp_use_yn
									,'GRP_PARENT_CD': grp_parent_cd
									,'HOST_CD': arr_host_cd
									,'HOST_NM': arr_host_nm
									,'HOST_DESC': arr_host_desc
									,'APPLICATION_NM': application_nm
									,'FOLDER_NM': folder_nm
									,'GRP_JOB_CNT': grp_job_cnt + "건"
								});
								
							});						
						}
						
						gridObj_3.rows = rowsObj;
						setGridRows(gridObj_3);
						$('#ly_total_cnt_3').html('[ TOTAL : '+items.attr('cnt')+' ]');
						
					});
					try{viewProgBar(false);}catch(e){}
				}
		, null );
		
		xhr.sendRequest(); 
	}
 	
	function codeInsert(scode_cd, scode_nm) {
		
		getUserDailyNmList(scode_nm);
		
		var sHtml="<div id='dl_tmp1' style='overflow:hidden;display:none;padding:0;border-top:1px solid blue;border-bottom:1px solid blue;border-left:1px solid blue;border-right:1px solid blue;'>";
		sHtml+="<form id='frm1' name='frm1' method='post' onsubmit='return false;'>";
		sHtml+="<input type='hidden' name='flag' id='flag'/>";
		sHtml+="<input type='hidden' name='scode_cd' id='scode_cd'/>";
		sHtml+="<input type='hidden' name='grp_depth' id='grp_depth' value='1'/>";
		//sHtml+="<input type='hidden' name='host_cd' id='host_cd' value=''/>";	
		sHtml+="<table style='width:100%;height:300px;border:none;'>";
		sHtml+="<tr><td style='vertical-align:top;height:90%;width:490px;' >";
		
		sHtml+="<table style='width:100%;height:80%;border:none;'>";
		sHtml+="<tr><td id='ly_g_tmp1' style='vertical-align:top;'>";
		sHtml+="<div id='g_tmp1' class='ui-widget-header ui-corner-all'></div>";
		sHtml+="</td></tr>";
		sHtml+="<tr style='height:10px;'><td style='vertical-align:top;'><h5 class='ui-widget-header ui-corner-all' >";
		sHtml+="<div align='right' class='btn_area_s'>";
		sHtml+="<span id='btn_ins'>저장</span>";
		sHtml+="</div>";
		sHtml+="</h5></td></tr></table>";
		
		sHtml+="</td></tr></table>";
		
		sHtml+="</form>";
		
		$('#dl_tmp1').remove();
		$('body').append(sHtml);
						
		var headerObj = new Array();
		var hTmp1 = "";
		var hTmp2 = "";
// 		hTmp1 += "<div class='cellTitle_1'>테이블명(한글)</div>";
// 		hTmp2 += "<div class='cellContent_1'><input type='text' name='grp_nm' id='grp_nm' style='width:100%;border:0px none;'/></div>";
		hTmp1 += "<div class='cellTitle_1'>폴더명</div>";
		hTmp2 += "<div class='cellContent_1'><input type='text' name='grp_eng_nm' id='grp_eng_nm' style='width:100%;border:0px none;'/></div>";
		hTmp1 += "<div class='cellTitle_2'>수 행 서 버</div>";
		hTmp2 += "<div class='cellContent_2'>";
		hTmp2 += "<input type='hidden' name='host_cd' id='host_cd'>";
		hTmp2 += "<input type='text' name='host_nm' id='host_nm' style='width:80%;height:21px;' readOnly />&nbsp;";
		hTmp2 += "<span id='btn_host'>검색</span>";
		hTmp1 += "<div class='cellTitle_1'>USER DAILY</div>";		
		hTmp2 += "<div class='cellContent_1'>";		
// 		hTmp2 += "<select name='user_daily_nm' id='user_daily_nm' onChange='document.frm2.user_daily.value=this.value;'>";
		hTmp2 += "<select name='user_daily_nm' id='user_daily_nm''>";
		hTmp2 += "<option value=''>--선택--</option>";		
		hTmp2 += "</select>";
// 		hTmp2 += "현재 값 : <input type='text' name='user_daily' id='user_daily' style='width:100%;height:15px;border:0px none;background-color:#EBEBE1;'/>";
		hTmp2 += "현재 값 : <input type='text' name='user_daily' id='user_daily' style='width:100%;height:15px;border:0px none;'/>";
		hTmp2 += "</div>";
		hTmp1 += "<div class='cellTitle_1'>사 용 구 분</div>";
		hTmp2 += "<div class='cellContent_1'>";
		hTmp2 += "<select name='grp_use_yn' id='grp_use_yn'>";		
		hTmp2 += "<option value='Y'>사용</option>";
		hTmp2 += "<option value='N'>미사용</option>";		
		hTmp2 += "</select>";
		hTmp2 += "</div>";
		hTmp1 += "<div class='cellTitle_1' style='height:60px;'>설    명</div>";
		hTmp2 += "<div class='cellContent_1'><textarea name='grp_desc' id='grp_desc' style='width:99%;height:60px;border:0px none;'></textarea></div>";
	
		headerObj.push({name:hTmp1,id_s:'c_1',id_e:'c_1'});
		headerObj.push({name:hTmp2,id_s:'c_2',id_e:'c_2'});
		var gridObj_s = {
			id : "g_tmp1"
			,colModel:[
		  		{formatter:gridCellNoneFormatter,field:'c_1',id:'c_1',name:'구 분',width:125,headerCssClass:'cellCenter',cssClass:'cellCenter'}
				,{formatter:gridCellNoneFormatter,field:'c_2',id:'c_2',name:'내 용',width:335,headerCssClass:'cellCenter',cssClass:'cellLeft'}
			   	
		   		,{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'grid_idx',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
		   	]
			,rows:[]
			,headerRowHeight:230
			,colspan:headerObj
			,vscroll:<%=S_GRID_VSCROLL%>
		};
		
		viewGrid_1(gridObj_s,'ly_'+gridObj_s.id);
		
		dlPop01('dl_tmp1',"폴더 등록",465,255,false);
		
		$("#frm1").find("input[name='scode_cd']").val(scode_cd);
	
		$("#btn_ins").button().unbind("click").click(function(){
			
<%-- 			if(isNullInput($('#frm1 #grp_nm'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[그룹코드명(한글)]","") %>')) return false; --%>
			if(isNullInput($('#frm1 #grp_eng_nm'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[폴더명]","") %>')) return false;
			
			if(($('#frm1 #grp_eng_nm').val()).indexOf(",") > -1){
				alert("폴더명에 ,(쉼표)를 포함할 수 없습니다.");
				return false;
			}
			
			if(($('#frm1 #grp_eng_nm').val()).indexOf("/") > -1){
				alert("폴더명에 '/'를 포함할 수 없습니다.");
				return false;
			}
			
			<%-- if($("#frm1").find("#host_cd").val() == ""){
				alert('<%=CommonUtil.getMessageSplit("ERROR.PARAM.02","[수행서버]","") %>'); 
				return false;
			} --%>
				
			var frm = document.frm1;

			if(confirm("해당 내용을 저장하시겠습니까?")){
				
				frm.flag.value = "ins";
				frm.target = "if1";
				frm.action = "<%=sContextPath %>/common.ez?c=ezAppGrp_p";
				frm.submit();
				
				dlClose('dl_tmp1');
			}
		});
		
		$("#btn_host").button().unbind("click").click(function(){
			
			getHostForm('ins');
		});
		
		//USER DAILY콤보박스에서 SYSTEM 말고 선택을 선택하면 텍스트 창의 SYSTEM 제거 2023.05.03 이상훈
		$("#user_daily_nm").change(function(){
			if($("#user_daily_nm").val() != 'SYSTEM'){
				$("#user_daily").val('');
			}
			if($("#user_daily_nm").val() == 'SYSTEM'){
				$("#user_daily").val('SYSTEM');
			}
		});
	}
	
	function codeAppInsert(scode_cd, grp_cd){
		
		var sHtml="<div id='dl_tmp1' style='overflow:hidden;display:none;padding:0;border-top:1px solid blue;border-bottom:1px solid blue;border-left:1px solid blue;border-right:1px solid blue;'>";
		sHtml+="<form id='frm2' name='frm2' method='post' onsubmit='return false;'>";
		sHtml+="<input type='hidden' name='flag' id='flag'/>";	
		sHtml+="<input type='hidden' name='scode_cd' id='scode_cd'/>";	
		sHtml+="<input type='hidden' name='grp_parent_cd' id='grp_parent_cd'/>";	
		sHtml+="<input type='hidden' name='grp_depth' id='grp_depth' value='2'/>";	
		sHtml+="<table style='width:100%;height:225px;border:none;'>";
		sHtml+="<tr><td style='vertical-align:top;height:100%;width:520px;' >";
		
		sHtml+="<table style='width:100%;height:100%;border:none;'>";
		sHtml+="<tr><td id='ly_g_tmp1' style='vertical-align:top;'>";
		sHtml+="<div id='g_tmp1' class='ui-widget-header ui-corner-all'></div>";
		sHtml+="</td></tr>";
		sHtml+="<tr style='height:10px;'><td style='vertical-align:top;'><h5 class='ui-widget-header ui-corner-all' >";
		sHtml+="<div align='right' class='btn_area_s'>";
		sHtml+="<span id='btn_ins'>저장</span>";
		sHtml+="</div>";
		sHtml+="</h5></td></tr></table>";
		
		sHtml+="</td></tr></table>";
		
		sHtml+="</form>";
		
		$('#dl_tmp1').remove();
		$('body').append(sHtml);
						
		var headerObj = new Array();
		var hTmp1 = "";
		var hTmp2 = "";
// 		hTmp1 += "<div class='cellTitle_1'>어플리케이션명(한글)</div>";
// 		hTmp2 += "<div class='cellContent_1'><input type='text' name='grp_nm' id='grp_nm' style='width:100%;border:0px none;'/></div>";
		hTmp1 += "<div class='cellTitle_1'>어플리케이션명</div>";
		hTmp2 += "<div class='cellContent_1'><input type='text' name='grp_eng_nm' id='grp_eng_nm' style='width:100%;border:0px none;'/></div>";
		hTmp1 += "<div class='cellTitle_1'>사 용 구 분</div>";
		hTmp2 += "<div class='cellContent_1'>";
		hTmp2 += "<select name='grp_use_yn' id='grp_use_yn'>";		
		hTmp2 += "<option value='Y'>사용</option>";
		hTmp2 += "<option value='N'>미사용</option>";		
		hTmp2 += "</select>";
		hTmp2 += "</div>";
		hTmp1 += "<div class='cellTitle_1' style='height:60px;'>설    명</div>";
		hTmp2 += "<div class='cellContent_1'><textarea name='grp_desc' id='grp_desc' style='width:99%;height:60px;border:0px none;'></textarea></div>";
	
		headerObj.push({name:hTmp1,id_s:'c_1',id_e:'c_1'});
		headerObj.push({name:hTmp2,id_s:'c_2',id_e:'c_2'});
		var gridObj_4 = {
			id : "g_tmp1"
			,colModel:[
		  		{formatter:gridCellNoneFormatter,field:'c_1',id:'c_1',name:'구 분',width:125,headerCssClass:'cellCenter',cssClass:'cellCenter'}
				,{formatter:gridCellNoneFormatter,field:'c_2',id:'c_2',name:'내 용',width:325,headerCssClass:'cellCenter',cssClass:'cellLeft'}
			   	
		   		,{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'grid_idx',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
		   	]
			,rows:[]
			,headerRowHeight:230
			,colspan:headerObj
			,vscroll:<%=S_GRID_VSCROLL%>
		};
		
		viewGrid_1(gridObj_4,'ly_'+gridObj_4.id);
		
		dlPop01('dl_tmp1',"어플리케이션 등록",450,235,false);
		
		$("#frm2").find("input[name='scode_cd']").val(scode_cd);
		$("#frm2").find("input[name='grp_parent_cd']").val(grp_cd);
		
		$("#btn_ins").button().unbind("click").click(function(){
			
<%-- 			if(isNullInput($('#frm2 #grp_nm'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[코드명(한글)]","") %>')) return false; --%>
			if(isNullInput($('#frm2 #grp_eng_nm'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[코드명]","") %>')) return false;
			<%-- if($("#frm2").find("select[name='host_cd']").val() == ""){
				alert('<%=CommonUtil.getMessageSplit("ERROR.PARAM.02","[수행서버]","") %>'); 
				return false;
			} --%>
			
			if(($('#frm2 #grp_eng_nm').val()).indexOf(",") > -1){
				alert("어플리케이션명에 ,(쉼표)를 포함할 수 없습니다.");
				return false;
			}
			
			var frm = document.frm2;
			if(confirm("해당 내용을 저장하시겠습니까?")){
				
				frm.flag.value = "ins";
				frm.target = "if1";
				frm.action = "<%=sContextPath %>/common.ez?c=ezAppGrp_p";
				frm.submit();
				
				dlClose('dl_tmp1');
			}
		});

	}
	
	function codeSubInsert(scode_cd, grp_cd){
		
		var sHtml="<div id='dl_tmp1' style='overflow:hidden;display:none;padding:0;border-top:1px solid blue;border-bottom:1px solid blue;border-left:1px solid blue;border-right:1px solid blue;'>";
		sHtml+="<form id='frm3' name='frm3' method='post' onsubmit='return false;'>";
		sHtml+="<input type='hidden' name='flag' id='flag'/>";	
		sHtml+="<input type='hidden' name='scode_cd' id='scode_cd'/>";	
		sHtml+="<input type='hidden' name='grp_parent_cd' id='grp_parent_cd'/>";	
		sHtml+="<input type='hidden' name='grp_depth' id='grp_depth' value='3'/>";	
		sHtml+="<table style='width:100%;height:200px;border:none;'>";
		sHtml+="<tr><td style='vertical-align:top;height:100%;width:520px;' >";
		
		sHtml+="<table style='width:100%;height:100%;border:none;'>";
		sHtml+="<tr><td id='ly_g_tmp1' style='vertical-align:top;'>";
		sHtml+="<div id='g_tmp1' class='ui-widget-header ui-corner-all'></div>";
		sHtml+="</td></tr>";
		sHtml+="<tr style='height:10px;'><td style='vertical-align:top;'><h5 class='ui-widget-header ui-corner-all' >";
		sHtml+="<div align='right' class='btn_area_s'>";
		sHtml+="<span id='btn_ins'>저장</span>";
		sHtml+="</div>";
		sHtml+="</h5></td></tr></table>";
		
		sHtml+="</td></tr></table>";
		
		sHtml+="</form>";
		
		$('#dl_tmp1').remove();
		$('body').append(sHtml);
						
		var headerObj = new Array();
		var hTmp1 = "";
		var hTmp2 = "";
// 		hTmp1 += "<div class='cellTitle_1'>그룹명(한글)</div>";
// 		hTmp2 += "<div class='cellContent_1'><input type='text' name='grp_nm' id='grp_nm' style='width:100%;border:0px none;'/></div>";
		hTmp1 += "<div class='cellTitle_1'>그룹명</div>";
		hTmp2 += "<div class='cellContent_1'><input type='text' name='grp_eng_nm' id='grp_eng_nm' style='width:100%;border:0px none;'/></div>";
//		hTmp1 += "<div class='cellTitle_2'>수 행 서 버</div>";
//		hTmp2 += "<div class='cellContent_2'>";
//		hTmp2 += "<input type='hidden' name='host_cd' id='host_cd'>";
//		hTmp2 += "<input type='text' name='host_nm' id='host_nm' style='width:80%;height:21px;' readOnly />&nbsp;";
//		hTmp2 += "<span id='btn_host'>검색</span>";
//		hTmp2 += "</div>";
		hTmp1 += "<div class='cellTitle_1'>사 용 구 분</div>";
		hTmp2 += "<div class='cellContent_1'>";
		hTmp2 += "<select name='grp_use_yn' id='grp_use_yn'>";		
		hTmp2 += "<option value='Y'>사용</option>";
		hTmp2 += "<option value='N'>미사용</option>";		
		hTmp2 += "</select>";
		hTmp2 += "</div>";
		hTmp1 += "<div class='cellTitle_1' style='height:55px;'>설    명</div>";
		hTmp2 += "<div class='cellContent_1'><textarea name='grp_desc' id='grp_desc' style='width:99%;height:55px;border:0px none;'></textarea></div>";
	
		headerObj.push({name:hTmp1,id_s:'c_1',id_e:'c_1'});
		headerObj.push({name:hTmp2,id_s:'c_2',id_e:'c_2'});
		var gridObj_4 = { 
			id : "g_tmp1"
			,colModel:[
		  		{formatter:gridCellNoneFormatter,field:'c_1',id:'c_1',name:'구 분',width:125,headerCssClass:'cellCenter',cssClass:'cellCenter'}
				,{formatter:gridCellNoneFormatter,field:'c_2',id:'c_2',name:'내 용',width:330,headerCssClass:'cellCenter',cssClass:'cellLeft'}
			   	
		   		,{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'grid_idx',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
		   	]
			,rows:[]
			,headerRowHeight:230
			,colspan:headerObj
			,vscroll:<%=S_GRID_VSCROLL%>
		};
		
		viewGrid_1(gridObj_4,'ly_'+gridObj_4.id);
		
		dlPop01('dl_tmp1',"그룹 등록",455,220,false);
		
		$("#frm3").find("input[name='scode_cd']").val(scode_cd);
		$("#frm3").find("input[name='grp_parent_cd']").val(grp_cd);
		
		$("#btn_ins").button().unbind("click").click(function(){
			
<%-- 			if(isNullInput($('#frm3 #grp_nm'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[코드명(한글)]","") %>')) return false; --%>
			if(isNullInput($('#frm3 #grp_eng_nm'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[코드명]","") %>')) return false;
<%-- 			if($("#frm3").find("select[name='host_cd']").val() == ""){
				alert('<%=CommonUtil.getMessageSplit("ERROR.PARAM.02","[수행서버]","") %>'); 
				return false;
			}
 --%>			
 
			 if(($('#frm3 #grp_eng_nm').val()).indexOf(",") > -1){
				alert("그룹명에 ,(쉼표)를 포함할 수 없습니다.");
				return false;
			}
			 
			var frm = document.frm3;
			if(confirm("해당 내용을 저장하시겠습니까?")){
				
				frm.flag.value = "ins";
				frm.target = "if1";
				frm.action = "<%=sContextPath %>/common.ez?c=ezAppGrp_p";
				frm.submit();
				
				dlClose('dl_tmp1');
				
			}
		});
		
		/* $("#btn_host").button().unbind("click").click(function(){
			
			getHostForm('ins');
		}); */
	}
	
	function codeEdit(){
		
		var cnt 			= 0;
		var grp_cd 			= "";
		var grp_nm 			= "";
		var grp_eng_nm 		= "";
		var grp_use_yn 		= "";
		var grp_desc 		= "";
		var user_daily 		= "";
		var chk_ctm_folder 	= "";
		var host_cd 		= "";
		var host_desc 		= "";
		
		var aSelRow = new Array;
		aSelRow = $('#'+gridObj_1.id).data('grid').getSelectedRows();
		if(aSelRow.length>0){
			for(var i=0;i<aSelRow.length;i++){
					
				if(i>0) grp_cd += "|";
				grp_cd += getCellValue(gridObj_1,aSelRow[i],'GRP_CD');

				// if(i>0) grp_nm += "|";
// 				grp_nm += getCellValue(gridObj_1,aSelRow[i],'GRP_NM');
				if(i>0) grp_eng_nm += "|";
				grp_eng_nm += getCellValue(gridObj_1,aSelRow[i],'GRP_ENG_NM');
				
				if(i>0) grp_use_yn += "|";
				grp_use_yn += getCellValue(gridObj_1,aSelRow[i],'GRP_USE_YN');
				
				if(i>0) grp_desc += "|";
				grp_desc += getCellValue(gridObj_1,aSelRow[i],'GRP_DESC');
				
				if(i>0) user_daily += "|";
				user_daily += getCellValue(gridObj_1,aSelRow[i],'USER_DAILY');
	
				if(i>0) host_cd += "|";
				host_cd += getCellValue(gridObj_1,aSelRow[i],'HOST_CD');
				
				if(i>0) host_desc += "|";
				host_desc += getCellValue(gridObj_1,aSelRow[i],'HOST_DESC');
				
				chk_ctm_folder = getCellValue(gridObj_1,aSelRow[i],'CHK_CTM_FOLDER');
				
				++cnt;
			}
			
			if(cnt > 1){
				alert("한개의 그룹코드만 선택해 주세요.");
				return;
			}else{
				codeEdit2(grp_cd, grp_nm, grp_eng_nm, grp_use_yn, grp_desc, user_daily, host_cd, host_desc, chk_ctm_folder);
			}
			
		}else{
			alert("수정하려는 내용을 선택해 주세요.");
			return;
		}		
		
	}
	
	function codeEdit2(grp_cd, grp_nm, grp_eng_nm, grp_use_yn, grp_desc, user_daily, host_cd, host_desc, chk_ctm_folder){
		
		var arr_host_cd = "";
		var arr_host_desc = "";
		if(host_cd != ""){
			arr_host_cd = host_cd.split(",");
			arr_host_desc = host_desc.split(",");
		}
		
		var scode_cd = $("select[name='main_grp_nm'] option:selected").val();
		var scode_nm = $("select[name='main_grp_nm'] option:selected").text();
		
		getUserDailyNmList(scode_nm);

		var sHtml="<div id='dl_tmp1' style='overflow:hidden;display:none;padding:0;border-top:1px solid blue;border-bottom:1px solid blue;border-left:1px solid blue;border-right:1px solid blue;'>";
		sHtml+="<form id='frm4' name='frm4' method='post' onsubmit='return false;'>";
		sHtml+="<input type='hidden' name='flag' id='flag'/>";	
		sHtml+="<input type='hidden' name='grp_cd' id='grp_cd'/>";	
		sHtml+="<input type='hidden' name='scode_cd' id='scode_cd'/>";	
		sHtml+="<input type='hidden' name='grp_depth' id='grp_depth' value='1'/>";
		sHtml+="<input type='hidden' name='folder_nm' id='folder_nm' />";
		sHtml+="<input type='hidden' name='orgin_nm' id='orgin_nm' />";
		sHtml+="<table style='width:100%;height:360px;border:none;'>";
		sHtml+="<tr><td style='vertical-align:top;height:100%;width:450px;' >";
		
		sHtml+="<table style='width:100%;height:100%;border:none;'>";
		sHtml+="<tr><td id='ly_g_tmp1' style='vertical-align:top;'>";
		sHtml+="<div id='g_tmp1' class='ui-widget-header ui-corner-all'></div>";
		sHtml+="</td></tr>";
		sHtml+="<tr style='height:10px;'><td style='vertical-align:top;'><h5 class='ui-widget-header ui-corner-all' >";
		sHtml+="<div align='right' class='btn_area_s'>";
		sHtml+="<span id='btn_ins'>수정</span>";
		sHtml+="</div>";
		sHtml+="</h5></td></tr></table>";
		
		sHtml+="</td></tr></table>";
		
		sHtml+="</form>";
		
		$('#dl_tmp1').remove();
		$('body').append(sHtml);
						
		var headerObj = new Array();
		var hTmp1 = "";
		var hTmp2 = "";
// 		hTmp1 += "<div class='cellTitle_1'>테이블명(한글)</div>";
// 		hTmp2 += "<div class='cellContent_1'><input type='text' name='grp_nm' id='grp_nm' style='width:100%;border:0px none;'/></div>";
		hTmp1 += "<div class='cellTitle_1'>폴더명</div>";
		hTmp2 += "<div class='cellContent_1'><input type='text' name='grp_eng_nm' id='grp_eng_nm' style='width:100%;border:0px none;'/></div>";
		hTmp1 += "<div class='cellTitle_1' style='height:110px;'>수 행 서 버</div>";
		hTmp2 += "<div class='cellContent_1' style='overflow-x:hidden;width:330px;height:110px;word-break: break-all;'>";
		hTmp2 += "<input type='hidden' name='host_cd' id='host_cd'>";
		hTmp2 += "<input type='text' name='host_nm' id='host_nm' style='width:75%;height:21px;' readOnly />&nbsp;";
		hTmp2 += "<span id='btn_host'>검색</span><br>";
		if(arr_host_cd.length > 0){
			for(var i=0;i<arr_host_cd.length;i++){
				if(i > 0) hTmp2 += "&nbsp;";
				if(i>1 && i%2 == 0) hTmp2 += "<br>";
				hTmp2 += arr_host_desc[i]+"<input type='checkbox' name='v_host_cd' id='v_host_cd' value='"+arr_host_cd[i]+"' checked>";		
			}
		}else{
			hTmp2 += "<input type='hidden' name='v_host_cd' id='v_host_cd' />";
		}
		hTmp2 += "</div>";		
		hTmp1 += "<div class='cellTitle_1''>USER DAILY</div>";
		hTmp2 += "<div class='cellContent_1'>";		
// 		hTmp2 += "<select name='user_daily_nm' id='user_daily_nm' onChange='document.frm5.user_daily.value=this.value;'>";
		hTmp2 += "<select name='user_daily_nm' id='user_daily_nm'>";
		hTmp2 += "<option value=''>--선택--</option>";		
		hTmp2 += "</select>";		
		hTmp2 += "&nbsp&nbsp현재 값 : <input type='text' name='user_daily' id='user_daily' style='width:50%;border:0px none;'/>";
		hTmp2 += "</div>";
		hTmp1 += "<div class='cellTitle_1'>사 용 구 분</div>";
		hTmp2 += "<div class='cellContent_1'>";
		hTmp2 += "<select name='grp_use_yn' id='grp_use_yn'>";	
		if(grp_use_yn == "Y"){
			hTmp2 += "<option value='Y' selected>사용</option>";
			hTmp2 += "<option value='N'>미사용</option>";	
		}else{
			hTmp2 += "<option value='Y'>사용</option>";
			hTmp2 += "<option value='N' selected>미사용</option>";	
		}
		hTmp2 += "</select>";
		hTmp2 += "</div>";
		hTmp1 += "<div class='cellTitle_1' style='height:80px;'>설    명</div>";
		hTmp2 += "<div class='cellContent_1' style='height:80px'><textarea name='grp_desc' id='grp_desc' style='width:100%;height:80px;border:0px none;'></textarea></div>";
	
		headerObj.push({name:hTmp1,id_s:'c_1',id_e:'c_1'});
		headerObj.push({name:hTmp2,id_s:'c_2',id_e:'c_2'});
		var gridObj_s = {
			id : "g_tmp1"
			,colModel:[
		  		{formatter:gridCellNoneFormatter,field:'c_1',id:'c_1',name:'구 분',width:125,headerCssClass:'cellCenter',cssClass:'cellCenter'}
				,{formatter:gridCellNoneFormatter,field:'c_2',id:'c_2',name:'내 용',width:335,headerCssClass:'cellCenter',cssClass:'cellLeft'}
			   	
		   		,{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'grid_idx',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
		   	]
			,rows:[]
			,headerRowHeight:340
			,headerRowWidth:430
			,colspan:headerObj
			,vscroll:<%=S_GRID_VSCROLL%>
		};
		
		viewGrid_1(gridObj_s,'ly_'+gridObj_s.id);
		
		dlPop01('dl_tmp1',"폴더 수정",460,370,false);
		
		$("#frm4").find("input[name='scode_cd']").val(scode_cd);
		$("#frm4").find("input[name='grp_cd']").val(grp_cd);
		$("#frm4").find("input[name='grp_nm']").val(grp_nm);
		$("#frm4").find("input[name='grp_eng_nm']").val(grp_eng_nm);
		//$("#frm4").find("select[name='grp_use_yn'] option:selected").val(grp_use_yn);
		$("#frm4").find("textarea[name='grp_desc']").val(grp_desc);
		$("#frm4").find("input[name='user_daily']").val(user_daily);
		$("#frm4").find("input[name='orgin_nm']").val($("#grp_eng_nm").val());
		$("#frm4").find("input[name='folder_nm']").val(grp_eng_nm);
		
		//CTM에 해당 폴더 존재시 테이블 USERDAILY 수정불가처리 2023.05.23 이상훈  
		if(chk_ctm_folder == 'EXIST'){
			$("#user_daily").attr("disabled",true);
			$("#user_daily_nm").attr("disabled",true);
		}
		
		setTimeout(function(){
			if(user_daily == ''){
				$("#user_daily").val("");
				$("#user_daily_nm").val("");
			}
		}, 100);
		
		$("#btn_ins").button().unbind("click").click(function(){
			
<%-- 		if(isNullInput($('#frm4 #grp_nm'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[테이블명(한글)]","") %>')) return false; --%>
			if(isNullInput($('#frm4 #grp_eng_nm'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[폴더명]","") %>')) return false;
		<%-- if($("#frm4").find("select[name='host_cd']").val() == ""){
			alert('<%=CommonUtil.getMessageSplit("ERROR.PARAM.02","[수행서버]","") %>'); 
			return false;
			} --%>
			
			var frm = document.frm4;
			if(confirm("해당 내용을 수정하시겠습니까?")){
				$("#user_daily").attr("disabled",false);
				$("#user_daily_nm").attr("disabled",false);
				frm.flag.value = "udt";
				frm.target = "if1";
				frm.action = "<%=sContextPath %>/common.ez?c=ezAppGrp_p";
				frm.submit();
				
				dlClose('dl_tmp3');
				dlClose('dl_tmp1');
				
			}
		});
		
		$("#btn_host").button().unbind("click").click(function(){
			
			getHostForm('udt');
		});
		
		//USER DAILY콤보박스에서 SYSTEM 말고 선택을 선택하면 텍스트 창의 SYSTEM 제거 2023.05.03 이상훈
		$("#user_daily_nm").change(function(){
			if($("#user_daily_nm").val() != 'SYSTEM'){
				$("#user_daily").val('');
			}
			if($("#user_daily_nm").val() == 'SYSTEM'){
				$("#user_daily").val('SYSTEM');
			}
		});
	}
	
	function codeAppEdit(){
		
		var cnt 			= 0;
		var grp_cd 			= "";
		var grp_nm 			= "";
		var grp_eng_nm 		= "";
		var grp_use_yn 		= "";
		var grp_desc 		= "";
		var grp_parent_cd 	= "";
		var host_cd 		= "";
		var host_desc 		= "";
		var folder_nm 		= "";
		
		var aSelRow = new Array;
		aSelRow = $('#'+gridObj_2.id).data('grid').getSelectedRows();
		if(aSelRow.length>0){
			for(var i=0;i<aSelRow.length;i++){
					
				if(i>0) grp_cd += "|";
				grp_cd += getCellValue(gridObj_2,aSelRow[i],'GRP_CD');
				
// 				if(i>0) grp_nm += "|";
// 				grp_nm += getCellValue(gridObj_2,aSelRow[i],'GRP_NM');
				
				if(i>0) grp_eng_nm += "|";
				grp_eng_nm += getCellValue(gridObj_2,aSelRow[i],'GRP_ENG_NM');
				
				if(i>0) grp_use_yn += "|";
				grp_use_yn += getCellValue(gridObj_2,aSelRow[i],'GRP_USE_YN');
				
				if(i>0) grp_desc += "|";
				grp_desc += getCellValue(gridObj_2,aSelRow[i],'GRP_DESC');
				
				if(i>0) grp_parent_cd += "|";
				grp_parent_cd += getCellValue(gridObj_2,aSelRow[i],'GRP_PARENT_CD');
				
				if(i>0) folder_nm += "|";
				folder_nm += getCellValue(gridObj_2,aSelRow[i],'FOLDER_NM');
				
				++cnt;
			}
			
			if(cnt > 1){
				alert("한개의 코드만 선택해 주세요.");
				return;
			}else{
				codeAppEdit2(grp_cd, grp_nm, grp_eng_nm, grp_use_yn, grp_desc, grp_parent_cd, host_cd, host_desc, folder_nm);
			}
			
		}else{
			alert("수정하려는 내용을 선택해 주세요.");
			return;
		}		
		
	}
	
	function codeAppEdit2(grp_cd, grp_nm, grp_eng_nm, grp_use_yn, grp_desc, grp_parent_cd, host_cd, host_desc, folder_nm){
		
		var scode_cd = $("select[name='main_grp_nm'] option:selected").val();

		var sHtml="<div id='dl_tmp1' style='overflow:hidden;display:none;padding:0;border-top:1px solid blue;border-bottom:1px solid blue;border-left:1px solid blue;border-right:1px solid blue;'>";
		sHtml+="<form id='frm5' name='frm5' method='post' onsubmit='return false;'>";
		sHtml+="<input type='hidden' name='flag' id='flag'/>";	
		sHtml+="<input type='hidden' name='grp_cd' id='grp_cd'/>";	
		sHtml+="<input type='hidden' name='scode_cd' id='scode_cd'/>";	
		sHtml+="<input type='hidden' name='grp_depth' id='grp_depth' value='2'/>";
		sHtml+="<input type='hidden' name='grp_parent_cd' id='grp_parent_cd' />";
		sHtml+="<input type='hidden' name='grp_parent_nm' id='grp_parent_nm' />";
		sHtml+="<input type='hidden' name='folder_nm' id='folder_nm' />";
		sHtml+="<input type='hidden' name='application_nm' id='application_nm' />";
		sHtml+="<input type='hidden' name='orgin_nm' id='orgin_nm' />";
		sHtml+="<table style='width:100%;height:225px;border:none;'>";
		sHtml+="<tr><td style='vertical-align:top;height:100%;width:490px;' >";
		
		sHtml+="<table style='width:100%;height:100%;border:none;'>";
		sHtml+="<tr><td id='ly_g_tmp1' style='vertical-align:top;'>";
		sHtml+="<div id='g_tmp1' class='ui-widget-header ui-corner-all'></div>";
		sHtml+="</td></tr>";
		sHtml+="<tr style='height:10px;'><td style='vertical-align:top;'><h5 class='ui-widget-header ui-corner-all' >";
		sHtml+="<div align='right' class='btn_area_s'>";
		sHtml+="<span id='btn_ins'>수정</span>";
		sHtml+="</div>";
		sHtml+="</h5></td></tr></table>";
		
		sHtml+="</td></tr></table>";
		
		sHtml+="</form>";
		
		$('#dl_tmp1').remove();
		$('body').append(sHtml);
						
		var headerObj = new Array();
		var hTmp1 = "";
		var hTmp2 = "";
// 		hTmp1 += "<div class='cellTitle_1'>어플리케이션명(한글)</div>";
// 		hTmp2 += "<div class='cellContent_1'><input type='text' name='grp_nm' id='grp_nm' style='width:100%;border:0px none;'/></div>";
		hTmp1 += "<div class='cellTitle_1'>어플리케이션명</div>";
		hTmp2 += "<div class='cellContent_1'><input type='text' name='grp_eng_nm' id='grp_eng_nm' style='width:100%;border:0px none;'/></div>";
		hTmp1 += "<div class='cellTitle_1'>사 용 구 분</div>";
		hTmp2 += "<div class='cellContent_1'>";
		hTmp2 += "<select name='grp_use_yn' id='grp_use_yn'>";	
		if(grp_use_yn == "Y"){
			hTmp2 += "<option value='Y' selected>사용</option>";
			hTmp2 += "<option value='N'>미사용</option>";	
		}else{
			hTmp2 += "<option value='Y'>사용</option>";
			hTmp2 += "<option value='N' selected>미사용</option>";	
		}
		hTmp2 += "</select>";
		hTmp2 += "</div>";
		hTmp1 += "<div class='cellTitle_1' style='height:55px;'>설    명</div>";
		hTmp2 += "<div class='cellContent_1' style='height:60px;'><textarea name='grp_desc' id='grp_desc' style='width:99%;height:55px;border:0px none;'></textarea></div>";
	
		headerObj.push({name:hTmp1,id_s:'c_1',id_e:'c_1'});
		headerObj.push({name:hTmp2,id_s:'c_2',id_e:'c_2'});
		var gridObj_4 = {
			id : "g_tmp1"
			,colModel:[
		  		{formatter:gridCellNoneFormatter,field:'c_1',id:'c_1',name:'구 분',width:125,headerCssClass:'cellCenter',cssClass:'cellCenter'}
				,{formatter:gridCellNoneFormatter,field:'c_2',id:'c_2',name:'내 용',width:325,headerCssClass:'cellCenter',cssClass:'cellLeft'}
			   	
		   		,{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'grid_idx',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
		   	]
			,rows:[]
			,headerRowHeight:350
			,colspan:headerObj
			,vscroll:<%=S_GRID_VSCROLL%>
		};
		
		viewGrid_1(gridObj_4,'ly_'+gridObj_4.id);
		
		dlPop01('dl_tmp1',"어플리케이션 수정",450,235,false);
		
		$("#frm5").find("input[name='scode_cd']").val(scode_cd);
		$("#frm5").find("input[name='grp_cd']").val(grp_cd);
		$("#frm5").find("input[name='grp_nm']").val(grp_nm);
		$("#frm5").find("input[name='grp_eng_nm']").val(grp_eng_nm);
		//$("#frm5").find("select[name='grp_use_yn'] option:selected").val(grp_use_yn);
		$("#frm5").find("textarea[name='grp_desc']").val(grp_desc);
		$("#frm5").find("input[name='grp_parent_cd']").val(grp_parent_cd);
		$("#frm5").find("input[name='orgin_nm']").val($("#grp_eng_nm").val());
		$("#frm5").find("input[name='folder_nm']").val(folder_nm);
		$("#frm5").find("input[name='application_nm']").val(grp_eng_nm);
				
		$("#btn_ins").button().unbind("click").click(function(){
			
<%-- 			if(isNullInput($('#frm5 #grp_nm'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[어플리케이션명(한글)]","") %>')) return false; --%>
			if(isNullInput($('#frm5 #grp_eng_nm'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[어플리케이션명]","") %>')) return false;
						
			var frm = document.frm5;
			if(confirm("해당 내용을 수정하시겠습니까?")){				
				frm.flag.value = "udt";
				frm.target = "if1";
				frm.action = "<%=sContextPath %>/common.ez?c=ezAppGrp_p";
				frm.submit();
				
				dlClose('dl_tmp1');
			}
		});
	}
	
	function codeSubEdit(){
		
		var cnt 			= 0;
		var grp_cd 			= "";
		var grp_nm 			= "";
		var grp_eng_nm 		= "";
		var grp_use_yn 		= "";
		var grp_desc 		= "";
		var grp_parent_cd 	= "";
		var host_cd 		= "";
		var host_desc 		= "";
		var folder_nm 		= "";
		var application_nm 	= "";
		
		var aSelRow = new Array;
		aSelRow = $('#'+gridObj_3.id).data('grid').getSelectedRows();
		if(aSelRow.length>0){
			for(var i=0;i<aSelRow.length;i++){
					
				if(i>0) grp_cd += "|";
				grp_cd += getCellValue(gridObj_3,aSelRow[i],'GRP_CD');
				
// 				if(i>0) grp_nm += "|";
// 				grp_nm += getCellValue(gridObj_3,aSelRow[i],'GRP_NM');
				
				if(i>0) grp_eng_nm += "|";
				grp_eng_nm += getCellValue(gridObj_3,aSelRow[i],'GRP_ENG_NM');
				
				if(i>0) grp_use_yn += "|";
				grp_use_yn += getCellValue(gridObj_3,aSelRow[i],'GRP_USE_YN');
				
				if(i>0) grp_desc += "|";
				grp_desc += getCellValue(gridObj_3,aSelRow[i],'GRP_DESC');
				
				if(i>0) grp_parent_cd += "|";
				grp_parent_cd += getCellValue(gridObj_3,aSelRow[i],'GRP_PARENT_CD');
				
				if(i>0) host_cd += "|";
				host_cd += getCellValue(gridObj_3,aSelRow[i],'HOST_CD');
				
				if(i>0) host_desc += "|";
				host_desc += getCellValue(gridObj_3,aSelRow[i],'HOST_DESC');
				
				if(i>0) folder_nm += "|";
				folder_nm += getCellValue(gridObj_3,aSelRow[i],'FOLDER_NM');
				
				if(i>0) application_nm += "|";
				application_nm += getCellValue(gridObj_3,aSelRow[i],'APPLICATION_NM');
				
				++cnt;
			}
			
			if(cnt > 1){
				alert("한개의 코드만 선택해 주세요.");
				return;
			}else{
				codeSubEdit2(grp_cd, grp_nm, grp_eng_nm, grp_use_yn, grp_desc, grp_parent_cd, host_cd, host_desc, folder_nm, application_nm);
				//codeSubEdit2(grp_cd, grp_nm, grp_eng_nm, grp_use_yn, grp_desc, grp_parent_cd);
			}
			
		}else{
			alert("수정하려는 내용을 선택해 주세요.");
			return;
		}		
		
	}
	
	function codeSubEdit2(grp_cd, grp_nm, grp_eng_nm, grp_use_yn, grp_desc, grp_parent_cd, host_cd, host_desc, folder_nm, application_nm){
			
		var arr_host_cd = "";
		var arr_host_desc = "";
		if(host_cd != ""){
			arr_host_cd = host_cd.split(",");
			arr_host_desc = host_desc.split(",");
		}
		
		var scode_cd = $("select[name='main_grp_nm'] option:selected").val();
				
		var sHtml="<div id='dl_tmp1' style='overflow:hidden;display:none;padding:0;border-top:1px solid blue;border-bottom:1px solid blue;border-left:1px solid blue;border-right:1px solid blue;'>";
		sHtml+="<form id='frm6' name='frm6' method='post' onsubmit='return false;'>";
		sHtml+="<input type='hidden' name='flag' id='flag'/>";	
		sHtml+="<input type='hidden' name='grp_cd' id='grp_cd'/>";	
		sHtml+="<input type='hidden' name='scode_cd' id='scode_cd'/>";	
		sHtml+="<input type='hidden' name='grp_depth' id='grp_depth' value='3'/>";
		sHtml+="<input type='hidden' name='grp_parent_cd' id='grp_parent_cd' />";
		sHtml+="<input type='hidden' name='grp_parent_nm' id='grp_parent_nm' />";
		sHtml+="<input type='hidden' name='group_nm' id='group_nm' />";
		sHtml+="<input type='hidden' name='folder_nm' id='folder_nm' />";
		sHtml+="<input type='hidden' name='application_nm' id='application_nm' />";
		sHtml+="<input type='hidden' name='orgin_nm' id='orgin_nm' />";
		sHtml+="<table style='width:100%;height:200px;border:none;'>";
		sHtml+="<tr><td style='vertical-align:top;height:90%;width:510px;' >";
		
		sHtml+="<table style='width:100%;height:100%;border:none;'>";
		sHtml+="<tr><td id='ly_g_tmp1' style='vertical-align:top;'>";
		sHtml+="<div id='g_tmp1' class='ui-widget-header ui-corner-all'></div>";
		sHtml+="</td></tr>";
		sHtml+="<tr style='height:10px;'><td style='vertical-align:top;'><h5 class='ui-widget-header ui-corner-all' >";
		sHtml+="<div align='right' class='btn_area_s'>";
		sHtml+="<span id='btn_ins'>수정</span>";
		sHtml+="</div>";
		sHtml+="</h5></td></tr></table>";
		
		sHtml+="</td></tr></table>";
		
		sHtml+="</form>";
		
		$('#dl_tmp1').remove();
		$('body').append(sHtml);
						
		var headerObj = new Array();
		var hTmp1 = "";
		var hTmp2 = "";
// 		hTmp1 += "<div class='cellTitle_1'>그룹명(한글)</div>";
// 		hTmp2 += "<div class='cellContent_1'><input type='text' name='grp_nm' id='grp_nm' style='width:100%;border:0px none;'/></div>";
		hTmp1 += "<div class='cellTitle_1'>그룹명</div>";
		hTmp2 += "<div class='cellContent_1'><input type='text' name='grp_eng_nm' id='grp_eng_nm' style='width:100%;border:0px none;'/></div>";
//		hTmp1 += "<div class='cellTitle_1' style='height:190px;'>수 행 서 버</div>";
//		hTmp2 += "<div class='cellContent_1' style='height:190px;'>";
//		hTmp2 += "<input type='hidden' name='host_cd' id='host_cd'>";
//		hTmp2 += "<input type='text' name='host_nm' id='host_nm' style='width:80%;height:21px;' readOnly />&nbsp;";
//		hTmp2 += "<span id='btn_host'>검색</span><br>";
//		if(arr_host_cd.length > 0){
//			for(var i=0;i<arr_host_cd.length;i++){
//				if(i > 0) hTmp2 += "&nbsp;";
//				if(i>2 && i%3 == 0) hTmp2 += "<br>";
//				hTmp2 += arr_host_desc[i]+"<input type='checkbox' name='v_host_cd' id='v_host_cd' value='"+arr_host_cd[i]+"' checked>";		
//			}
//		}else{
//			hTmp2 += "<input type='hidden' name='v_host_cd' id='v_host_cd' />";
//		}
		
//		hTmp2 += "</div>";
		hTmp1 += "<div class='cellTitle_1'>사 용 구 분</div>";
		hTmp2 += "<div class='cellContent_1'>";
		hTmp2 += "<select name='grp_use_yn' id='grp_use_yn'>";	
		if(grp_use_yn == "Y"){
			hTmp2 += "<option value='Y' selected>사용</option>";
			hTmp2 += "<option value='N'>미사용</option>";	
		}else{
			hTmp2 += "<option value='Y'>사용</option>";
			hTmp2 += "<option value='N' selected>미사용</option>";	
		}
		hTmp2 += "</select>";
		hTmp2 += "</div>";
		hTmp1 += "<div class='cellTitle_1' style='height:60px;'>설    명</div>";
		hTmp2 += "<div class='cellContent_1' style='height:60px;'><textarea name='grp_desc' id='grp_desc' style='width:99%;height:55px;border:0px none;'></textarea></div>";
	
		headerObj.push({name:hTmp1,id_s:'c_1',id_e:'c_1'});
		headerObj.push({name:hTmp2,id_s:'c_2',id_e:'c_2'});
		var gridObj_4 = {
			id : "g_tmp1"
			,colModel:[
		  		{formatter:gridCellNoneFormatter,field:'c_1',id:'c_1',name:'구 분',width:125,headerCssClass:'cellCenter',cssClass:'cellCenter'}
				,{formatter:gridCellNoneFormatter,field:'c_2',id:'c_2',name:'내 용',width:330,headerCssClass:'cellCenter',cssClass:'cellLeft'}
			   	
		   		,{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'grid_idx',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
		   	]
			,rows:[]
			,headerRowHeight:350
			,colspan:headerObj
			,vscroll:<%=S_GRID_VSCROLL%>
		};
		
		viewGrid_1(gridObj_4,'ly_'+gridObj_4.id);
		
		dlPop01('dl_tmp1',"그룹 수정",455,220,false);
		
		$("#frm6").find("input[name='scode_cd']").val(scode_cd);
		$("#frm6").find("input[name='grp_cd']").val(grp_cd);
		$("#frm6").find("input[name='grp_nm']").val(grp_nm);
		$("#frm6").find("input[name='grp_eng_nm']").val(grp_eng_nm);
		//$("#frm6").find("select[name='grp_use_yn'] option:selected").val(grp_use_yn);
		$("#frm6").find("textarea[name='grp_desc']").val(grp_desc);
		$("#frm6").find("input[name='grp_parent_cd']").val(grp_parent_cd);
		$("#frm6").find("input[name='orgin_nm']").val($("#grp_eng_nm").val());
		$("#frm6").find("input[name='group_nm']").val(grp_eng_nm);
		$("#frm6").find("input[name='folder_nm']").val(folder_nm);
		$("#frm6").find("input[name='application_nm']").val(application_nm);
				
		$("#btn_ins").button().unbind("click").click(function(){
			
<%-- 			if(isNullInput($('#frm6 #grp_nm'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[그룹명(한글)]","") %>')) return false; --%>
			if(isNullInput($('#frm6 #grp_eng_nm'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[그룹명]","") %>')) return false;
						
			var frm = document.frm6;
			
			if(confirm("해당 내용을 수정하시겠습니까?")){				
				frm.flag.value = "udt";
				frm.target = "if1";
				frm.action = "<%=sContextPath %>/common.ez?c=ezAppGrp_p";
				frm.submit();
				
				dlClose('dl_tmp3');
				dlClose('dl_tmp1');
			}
		});
		
		$("#btn_host").button().unbind("click").click(function(){
			
			getHostForm('udt');
			 
		});
	}
	
	//시스템관리 > 폴더or어플리케이션or그룹 삭제
	function codeDelete(gb){
		var grp_cd 			= "";
		var scode_cd 		= "";
		var grp_parent_cd 	= "";
		var grp_depth 		= "";
		var grp_eng_nm 		= "";
		var folder_nm 		= "";
		var application_nm 	= "";
		var group_nm 		= "";
		var cnt 			= 0;
		var aSelRow 		= new Array;
		
		var grp_cd_list 		= "";
		var group_nm_list 		= "";
		var application_nm_list = "";
		var folder_nm_list 		= "";
		var JOB_CNT				= "";
		var APP_JOB_CNT			= "";
		var GRP_JOB_CNT			= "";
		
		if(gb == "1"){
			aSelRow = $('#'+gridObj_1.id).data('grid').getSelectedRows();
			if(aSelRow.length>0){
				for(var i=0;i<aSelRow.length;i++){					
					grp_cd = getCellValue(gridObj_1,aSelRow[i],'GRP_CD');
					grp_cd_list += grp_cd + ",,";
					
					scode_cd = getCellValue(gridObj_1,aSelRow[i],'SCODE_CD');
					grp_parent_cd = getCellValue(gridObj_1,aSelRow[i],'GRP_PARENT_CD');
					grp_depth = getCellValue(gridObj_1,aSelRow[i],'GRP_DEPTH');
					
					folder_nm = getCellValue(gridObj_1,aSelRow[i],'GRP_ENG_NM');
					folder_nm_list += folder_nm + ",,";
					
					JOB_CNT	= getCellValue(gridObj_1,aSelRow[i],'JOB_CNT').replace("건","");
					++cnt;
				}
				if(JOB_CNT > 0){
					alert("등록된 작업이 존재하는 경우 삭제가 불가능합니다.");return;
				}
			}else{
				alert("삭제 하시려는 그룹코드를 선택해 주세요.");
				return;
			}
					
			//다중 삭제 생겨서 주석처리
// 			if(cnt > 1){
// 				alert("한개의 그룹코드만 선택해 주세요.");
// 				return;
// 			}			
		}else if(gb == "2"){
			aSelRow = $('#'+gridObj_2.id).data('grid').getSelectedRows();
			if(aSelRow.length>0){
				for(var i=0;i<aSelRow.length;i++){
					grp_cd = getCellValue(gridObj_2,aSelRow[i],'GRP_CD');
					grp_cd_list += grp_cd + ",,";
					
					scode_cd = getCellValue(gridObj_2,aSelRow[i],'SCODE_CD');
					grp_parent_cd = getCellValue(gridObj_2,aSelRow[i],'GRP_PARENT_CD');
					grp_depth = getCellValue(gridObj_2,aSelRow[i],'GRP_DEPTH');
					folder_nm = getCellValue(gridObj_2,aSelRow[i],'FOLDER_NM');
					
					application_nm = getCellValue(gridObj_2,aSelRow[i],'GRP_ENG_NM');
					application_nm_list += application_nm + ",,";
					
					APP_JOB_CNT	= getCellValue(gridObj_2,aSelRow[i],'APP_JOB_CNT').replace("건","");
					++cnt;
				}
				if(APP_JOB_CNT > 0){
					alert("등록된 작업이 존재하는 경우 삭제가 불가능합니다.");return;
				}
			}else{
				alert("삭제 하시려는 코드를 선택해 주세요.");
				return;
			}
			
			//다중 삭제 생겨서 주석처리
// 			if(cnt > 1){
// 				alert("한개의 코드만 선택해 주세요.");
// 				return;
// 			}			
		}else if(gb == "3"){
			aSelRow = $('#'+gridObj_3.id).data('grid').getSelectedRows();
			if(aSelRow.length>0){
				for(var i=0;i<aSelRow.length;i++){
					grp_cd 			= getCellValue(gridObj_3,aSelRow[i],'GRP_CD');
					grp_cd_list += grp_cd + ",,";
					
					scode_cd 		= getCellValue(gridObj_3,aSelRow[i],'SCODE_CD');
					grp_parent_cd 	= getCellValue(gridObj_3,aSelRow[i],'GRP_PARENT_CD');
					grp_depth 		= getCellValue(gridObj_3,aSelRow[i],'GRP_DEPTH');
					folder_nm 		= getCellValue(gridObj_3,aSelRow[i],'FOLDER_NM');
					application_nm 	= getCellValue(gridObj_3,aSelRow[i],'APPLICATION_NM');
					
					group_nm 		= getCellValue(gridObj_3,aSelRow[i],'GRP_ENG_NM');
					group_nm_list += group_nm + ",,";
					
					GRP_JOB_CNT	= getCellValue(gridObj_3,aSelRow[i],'GRP_JOB_CNT').replace("건","");
					++cnt;
				}
				if(GRP_JOB_CNT > 0){
					alert("등록된 작업이 존재하는 경우 삭제가 불가능합니다.");return;
				}
			}else{
				alert("삭제 하시려는 코드를 선택해 주세요.");
				return;
			}
			
			//다중 삭제 생겨서 주석처리
// 			if(cnt > 1){
// 				alert("한개의 코드만 선택해 주세요.");
// 				return;
// 			}			
		}
		
		if(confirm("선택된 내용을 삭제 하시겠습니까? \n(등록된 작업이 있을 경우 제외됩니다.)")){
			
			try{viewProgBar(true);}catch(e){}
			
			var frm = document.frm7;
			
			frm.flag.value 			= "del";
			frm.grp_cd.value 		= grp_cd;
			frm.scode_cd.value 		= scode_cd;
			frm.grp_parent_cd.value = grp_parent_cd;
			frm.grp_depth.value 	= grp_depth;
			frm.folder_nm.value 	= folder_nm;
			frm.application_nm.value = application_nm;
			frm.group_nm.value 		= group_nm;
			
			frm.grp_cd_list.value 			= grp_cd_list;
			frm.folder_nm_list.value 		= folder_nm_list;
			frm.application_nm_list.value 	= application_nm_list;
			frm.group_nm_list.value 		= group_nm_list;
			
			frm.target 				= "if1";
			frm.action 				= "<%=sContextPath %>/common.ez?c=ezAppGrp_p";
			frm.submit();
						
			try{viewProgBar(false);}catch(e){}
		}
	}
	
	function formClear(){
		$("#f_s").find("input[name='grp_cd']").val("0");
		$("#f_s").find("input[name='grp_parent_nm']").val("");
		$("#f_s").find("input[name='grp_parent_cd']").val("");
	}
	
	function getHostForm(flag){
		
		var sHtml2="<div id='dl_tmp3' style='overflow:hidden;display:none;padding:0;border-top:1px solid blue;border-bottom:1px solid blue;border-left:1px solid blue;border-right:1px solid blue;'>";
		sHtml2+="<form id='form3' name='form3' method='post' onsubmit='return false;'>";
		sHtml2+="<input type='hidden' name='grp_cd' 	id='grp_cd'/>";
		sHtml2+="<input type='hidden' name='flag' 		id='flag'/>";
		sHtml2+="<input type='hidden' name='host_cd' 	id='host_cd'/>";
		sHtml2+="<input type='hidden' name='scode_cd' 	id='scode_cd'/>";
		sHtml2+="<table style='width:100%;height:260px;;border:none;'><tr><td style='vertical-align:top;height:100%;width:500px;'>";
		sHtml2+="호스트명 : <input type='text' name='v_host_nm' id='v_host_nm' />&nbsp;&nbsp;<span id='btn_hostSearch'>검색</span>";
		sHtml2+="<table style='width:100%;height:100%;border:none;'>";
		sHtml2+="<tr><td id='ly_g_tmp3' style='vertical-align:top;' >";
		sHtml2+="<div id='g_tmp3' class='ui-widget-header ui-corner-all'></div>";
		sHtml2+="</td></tr>";
		sHtml2+="<tr style='height:10px;'><td style='vertical-align:top;'><h5 class='ui-widget-header ui-corner-all' >";
		sHtml2+="<div id='ly_total_cnt4' style='float:left;padding-top:5px;padding-left:5px;'></div>";
		sHtml2+="<div align='right' class='btn_area_s' style='padding-top:5px;'>";
		sHtml2+="<span id='btn_chk_add' style='display:none;'>일괄등록</span>";
		sHtml2+="<span id='btn_chk_del' style='display:none;'>일괄삭제</span>";
		sHtml2+="<span id='btn_close'>닫기</span>";
		sHtml2+="</div>";
		
		sHtml2+="</h5></td></tr></table>";
		
		sHtml2+="</td></tr></table>";
		
		sHtml2+="</form>";
		
		$('#dl_tmp3').remove();
		$('body').append(sHtml2);
		
		dlPop01('dl_tmp3',"수행서버내역",450,305,false);

		var gridObj3 = {
			id : "g_tmp3"
			,colModel:[		
				{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'번호',width:50,headerCssClass:'cellCenter',cssClass:'cellCenter'}
				,{formatter:gridCellNoneFormatter,field:'NODE_ID',id:'NODE_ID',name:'호스트명',width:120,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
				,{formatter:gridCellNoneFormatter,field:'NODE_NM',id:'NODE_NM',name:'설명',width:150,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
		   		,{formatter:gridCellNoneFormatter,field:'HOST_CD',id:'HOST_CD',name:'HOST_CD',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
		   	]
			,rows:[]
		};
		
		//viewGrid_1(gridObj3,'ly_'+gridObj3.id);
		
		if(flag == "add"){
			$("#btn_chk_add").show();
			$("#btn_chk_del").show();
			viewGridChk_2(gridObj3,"ly_"+gridObj3.id);
		}else{
			viewGrid_1(gridObj3,'ly_'+gridObj3.id);
			gridObj3.colModel.splice(3, 0, {formatter:gridCellNoneFormatter,field:'CHOICE',id:'CHOICE',name:'선택',width:80,headerCssClass:'cellCenter',cssClass:'cellCenter'});
			var grid = $('#' + gridObj3.id).data('grid');
			grid.setColumns(gridObj3.colModel);
		}
		
		$('#v_host_nm').placeholder().unbind('keypress').keypress(function(e){
			if(e.keyCode==13){				
							
				/*if($(this).val() == ""){
					alert("검색어를 입력해 주세요.");
					return;
				}*/
				getHostList($(this).val(), flag);
			}
		});
		
		$("#btn_hostSearch").button().unbind("click").click(function(){
			
			var host_nm = $("#v_host_nm").val();
			
			/*if(host_nm == ""){
				alert("검색어를 입력해 주세요.");
				return;
			}*/
			getHostList(host_nm, flag);
		});
		
		$("#btn_chk_add").button().unbind("click").click(function(){
			
			var scode_cd = $("select[name='main_grp_nm'] option:selected").val();
			var host_cd = "";
			
			var aSelRow = new Array;
			aSelRow = $('#'+gridObj3.id).data('grid').getSelectedRows();
			if(aSelRow.length>0){
				for(var i=0;i<aSelRow.length;i++){
					if(i>0) {
						host_cd += ",";
					}
					host_cd 	+= getCellValue(gridObj3,aSelRow[i],'HOST_CD');
				}
			}

			var frm = document.form3;

			frm.host_cd.value = host_cd;
			
			frm.flag.value 		= "host_udt";
			frm.scode_cd.value 	= scode_cd;
			frm.target = "if1";
			frm.action = "<%=sContextPath %>/common.ez?c=ezAppGrp_p";
			frm.submit();
			
			dlClose('dl_tmp3');
			
			getCodeList(scode_cd,'1');
		});
		
		$("#btn_chk_del").button().unbind("click").click(function(){
			
			var scode_cd = $("select[name='main_grp_nm'] option:selected").val();
			var host_cd = "";
			
			var aSelRow = new Array;
			aSelRow = $('#'+gridObj3.id).data('grid').getSelectedRows();
			if(aSelRow.length>0){
				for(var i=0;i<aSelRow.length;i++){
					if(i>0) {
						host_cd += ",";
					}
					host_cd 	+= getCellValue(gridObj3,aSelRow[i],'HOST_CD');
				}
			}

			var frm = document.form3;

			frm.host_cd.value = host_cd;
			
			frm.flag.value = "host_del";
			frm.scode_cd.value 	= scode_cd;
			frm.target = "if1";
			frm.action = "<%=sContextPath %>/common.ez?c=ezAppGrp_p";
			frm.submit();
			
			dlClose('dl_tmp3');
			
			getCodeList(scode_cd,'1');
		});
		
		$("#btn_close").button().unbind("click").click(function(){
			dlClose('dl_tmp3');
		});
		
		
		getHostList('', flag);
		
	}
	
	function getHostList(text, flag){
		
		try{viewProgBar(true);}catch(e){}
		$('#ly_total_cnt4').html('');
		
		var scode_cd = $("select[name='main_grp_nm'] option:selected").val();
		var data_center = $("select[name='main_grp_nm'] option:selected").attr("data");
		var flag = flag;
		data_center = scode_cd + "," + data_center;
		
		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=hostList&host_nm='+text+'&data_center='+data_center;
		
		var xhr = new XHRHandler( url, null
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
						
						if(items.attr('cnt')=='0'){
						}else{
							items.find('item').each(function(i){
								
								var host_cd = $(this).find("HOST_CD").text();							
								var node_id = $(this).find("NODE_ID").text();
								var node_nm = $(this).find("NODE_NM").text();
								
								if(flag == "add"){
									rowsObj.push({'grid_idx':i+1
										,'HOST_CD':host_cd
										,'NODE_ID':node_id
										,'NODE_NM':node_nm			
										//,'CHOICE':"<div><a href=\"javascript:selectHost('"+host_cd+"','"+node_id+"','"+flag+"');\" ><font color='red'>[선택]</font></a></div>"								
									});
								}else{
									rowsObj.push({'grid_idx':i+1
										,'HOST_CD':host_cd
										,'NODE_ID':node_id
										,'NODE_NM':node_nm			
										,'CHOICE':"<div><a href=\"javascript:selectHost('"+host_cd+"','"+node_id+"','"+flag+"');\" ><font color='red'>[선택]</font></a></div>"								
									});
								}
							});
							
						}
						var obj = $("#g_tmp3").data('gridObj');
						var grid = $("#g_tmp3").data('grid');
						grid.setColumns(obj.colModel);
						obj.rows = rowsObj;
						setGridRows(obj);
						
						$('#ly_total_cnt4').html('[ TOTAL : '+items.attr('cnt')+' ]');
					});
					try{viewProgBar(false);}catch(e){}
				}
		, null );
		
		xhr.sendRequest();
	}
	
	function selectHost(cd,nm,flag){

		if(flag == "ins"){
			var host_cd = $("#frm1").find("input[name='host_cd']").val();
			var host_nm = $("#frm1").find("input[name='host_nm']").val();
			
			if(host_cd == ""){
				$("#frm1").find("input[name='host_cd']").val(cd);	
				$("#frm1").find("input[name='host_nm']").val(nm);	
			}else{
				$("#frm1").find("input[name='host_cd']").val(host_cd+","+cd);	
				$("#frm1").find("input[name='host_nm']").val(host_nm+","+nm);	
			}
		}else if(flag == "udt"){
			var host_cd = $("#frm4").find("input[name='host_cd']").val();
			var host_nm = $("#frm4").find("input[name='host_nm']").val();
			
			if(host_cd == ""){
				$("#frm4").find("input[name='host_cd']").val(cd);	
				$("#frm4").find("input[name='host_nm']").val(nm);	
			}else{
				$("#frm4").find("input[name='host_cd']").val(host_cd+","+cd);	
				$("#frm4").find("input[name='host_nm']").val(host_nm+","+nm);	
			}
		}
		
		alert("추가되었습니다.");
		//dlClose('dl_tmp3');
	}
 
	// USER DAILY 가져오기
	function getUserDailyNmList(data_center) {
	
		try{viewProgBar(true);}catch(e){}
		
		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=userDailyNameList&itemGubun=2&data_center='+encodeURIComponent(data_center);
		
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
						
						if(items.attr('cnt')=='0'){
							$("select[name='user_daily_nm'] option").remove();
							$("select[name='user_daily_nm']").append("<option value=''>--선택--</option>");	
						}else{
							
							$("select[name='user_daily_nm'] option").remove();
							
							$("select[name='user_daily_nm']").append("<option value=''>--선택--</option>");
							
							items.find('item').each(function(i){
							
								var user_daily 	= $(this).find("USER_DAILY").text();
								
								$("select[name='user_daily_nm']").append("<option value='"+user_daily+"'>"+user_daily+"</option>");
							});
							
							$('#user_daily_nm').val("SYSTEM");
							$('#user_daily').val("SYSTEM");
							
						}
												
					});
					try{viewProgBar(false);}catch(e){}
				}
		, null );
		
		xhr.sendRequest();
	}
	//수행서버일괄변경
	function hostChange(){
		
		// 그리드 마지막 값 원복되는 현상 해결
		$('#'+gridObj_1.id).data('grid').getEditorLock().commitCurrentEdit();
 
		var aSelRow = new Array;
		var selected_rows			= $('#'+gridObj_1.id).data('grid').getSelectedRows();
		var rows_length				= selected_rows.length;
		if (rows_length == 0) {
			alert("수행서버를 변경할 폴더를 선택해주세요.");
			return;
		}
		
		//수행서버 변경할 폴더의 이름들
		var grp_cd			= "";
		for (var i = 0; i < rows_length; i++) {
			grp_cd += getCellValue(gridObj_1,selected_rows[i],'GRP_CD');
			if (i < rows_length-1){
				grp_cd += ",";
			}
		}
		
		getHostForm('add');
		
		$("#form3").find("input[name='grp_cd']").val(grp_cd);	
		 
	}
	
	function popupAppGrpCodeForm(title, depth) {
		var sHtml1="<div id='cmAppGrpCode' style='overflow:hidden;display:none;padding:0;border-top:1px solid blue;border-bottom:1px solid blue;border-left:1px solid blue;border-right:1px solid blue;'>";
		sHtml1+="<form id='appGrpCodeForm' name='appGrpCodeForm' method='post' onsubmit='return false;'>";
		sHtml1+="<input type='hidden' name='p_grp_depth' id='p_grp_depth' value="+depth+">";
		sHtml1+="<input type='hidden' name='p_scode_cd' id='p_scode_cd'>";
		sHtml1+="<input type='hidden' name='p_grp_eng_nm' id='p_grp_eng_nm'>";
		sHtml1+="<input type='hidden' name='p_grp_table_type' id='p_grp_table_type'>";
		sHtml1+="<input type='hidden' name='p_grp_parent_cd' id='p_grp_parent_cd'>";
		sHtml1+="<input type='hidden' name='p_user_daily' id='p_user_daily'>";
		sHtml1+="<table style='width:100%;height:100%;border:none;'>"; //table 시작
		
		sHtml1+="<tr>"; // tr
		sHtml1+="<td style='vertical-align:top;height:100%;width:500px;text-align:right;' colspan=2>";
		sHtml1+="<div class='ui-widget-header ui-corner-all'>";
		sHtml1+="C-M : <select name='app_grp_data_center' id='app_grp_data_center' style='height:21px;'>";
		sHtml1+="<option value=''>--선택--</option>";
		<c:forEach var="cm" items="${SCODE_GRP_LIST}" varStatus="status">
			sHtml1+="<option value='${cm.scode_cd}'>${cm.scode_nm}</option>"
		</c:forEach>;
		sHtml1+="</select>";
		sHtml1+="&nbsp;"+title+"명 : <input type='text' name='p_code_name' id='p_code_name' value='' />";
		sHtml1+="&nbsp;&nbsp;<span id='btn_code_search' style='height:21px'>검색</span>";
		sHtml1+="</div>";
		sHtml1+="</td>";
		sHtml1+="</tr>"; // /tr
		sHtml1+="<tr style='height:480px;'>"; // tr
		sHtml1+="<td id='ly_appGrpCodeGrid' style='vertical-align:top;' colspan=2>";
		sHtml1+="<div id='appGrpCodeGrid' class='ui-widget-header ui-corner-all'></div>";
		sHtml1+="</td>";
		sHtml1+="</tr>"; // /tr
		sHtml1+="<tr style='height:5px;'>"; // tr
		sHtml1+="<td style='vertical-align:top;'>"; // td
		sHtml1+="<h5 class='ui-corner-all' >";
		sHtml1+="<div id='ly_code_total_cnt' style='padding:5px;float:left;'></div>";
		sHtml1+="</h5>";
		sHtml1+="</td>"; // /td
		sHtml1+="<td style='vertical-align:top;'>"; // td
		sHtml1+="<div align='right' style='padding:3px;'><span id='btn_code_insert'>"+title+"이관</span><span id='btn_code_close'>닫기</span></div>";
		sHtml1+="</td>"; // /tb
		sHtml1+="</tr>"; //tr 3 끝
		sHtml1+="</table>"; //table 끝
		
		sHtml1+="</form>";
		sHtml1+="</div>";
		
		$('#cmAppGrpCode').remove();
		$('body').append(sHtml1);
		
		dlPop02('cmAppGrpCode',title+"검색",470,550,false);
		
		var gridObj = {
			id : "appGrpCodeGrid"
			,rows:[]
			,vscroll:false
		};
		
		var codeColModel = [];
		if (depth == 1) {
			codeColModel = [{formatter:gridCellNoneFormatter,field:'grp_cd_check',id:'grp_cd_check',name:'<input type="checkbox" name="checkIdxAll" id="checkIdxAll" onClick="checkAll();">',width:30,headerCssClass:'cellCenter',cssClass:'cellCenter', disabled:true}
					,{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'번호',width:50,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	   				,{formatter:gridCellNoneFormatter,field:'sched_table',id:'sched_table',name:'테이블',width:150,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
		   			,{formatter:gridCellNoneFormatter,field:'user_daily',id:'user_daily',name:'USER_DAILY',width:100,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
		   			,{formatter:gridCellNoneFormatter,field:'table_type',id:'table_type',name:'테이블종류',width:100,headerCssClass:'cellHid',cssClass:'cellHid'}];
		} else if (depth == 2) {
			codeColModel = [{formatter:gridCellNoneFormatter,field:'grp_cd_check',id:'grp_cd_check',name:'<input type="checkbox" name="checkIdxAll" id="checkIdxAll" onClick="checkAll();">',width:30,headerCssClass:'cellCenter',cssClass:'cellCenter'}
					,{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'번호',width:50,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
			   		,{formatter:gridCellNoneFormatter,field:'sched_table',id:'sched_table',name:'테이블',width:150,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
		   			,{formatter:gridCellNoneFormatter,field:'application',id:'application',name:'어플리케이션',width:150,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
		   			,{formatter:gridCellNoneFormatter,field:'p_grp_parent_cd',id:'p_grp_parent_cd',width:100,headerCssClass:'cellHid',cssClass:'cellHid',sortable:true}];
		} else if (depth == 3) {
			codeColModel = [{formatter:gridCellNoneFormatter,field:'grp_cd_check',id:'grp_cd_check',name:'<input type="checkbox" name="checkIdxAll" id="checkIdxAll" onClick="checkAll();">',width:30,headerCssClass:'cellCenter',cssClass:'cellCenter'}
					,{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'번호',width:50,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
			   		,{formatter:gridCellNoneFormatter,field:'sched_table',id:'sched_table',name:'테이블',width:150,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
		   			,{formatter:gridCellNoneFormatter,field:'application',id:'application',name:'어플리케이션',width:150,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
		   			,{formatter:gridCellNoneFormatter,field:'group_name',id:'group_name',name:'그룹',width:150,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
		   			,{formatter:gridCellNoneFormatter,field:'p_grp_parent_cd',id:'p_grp_parent_cd',width:100,headerCssClass:'cellHid',cssClass:'cellHid',sortable:true}];
		}
		
		gridObj.colModel = codeColModel;
		
		$("#app_grp_data_center").val($("#main_grp_nm option:selected").val());
		
		viewGrid_1(gridObj,"ly_"+gridObj.id);
		$("#"+gridObj.id).data('grid').setSelectionModel(new Slick.RowSelectionModel({selectActiveRow: false})); //grid 자체 selection 기능 사용 안함.
		
		$("#btn_code_search").button().unbind("click").click(function(){		
			var data_center = $("#app_grp_data_center").val();
			if (data_center == "") {
				alert("C-M 을 선택해 주세요.");
				return;
			}
			
			cmAppGrpCodeList();
		});
		
		$("#btn_code_insert").button().unbind("click").click(function(){
			var chk = $("input[name=grp_cd_check]");
			var grp_eng_nm_list = "";
			var grp_table_type_list = "";
			var grp_parent_cd_list = "";
			var user_daily_list = "";
			var chk_cnt = 0;
			
			chk.each(function(i){
				if ($(this).attr("checked")) {
					if (depth == 1) {
						grp_eng_nm_list += $("input[name=sched_table_check]").eq(i).val() + ",";
						grp_table_type_list += $("input[name=table_type]").eq(i).val() + ",";
						user_daily_list += $("input[name=user_daily]").eq(i).val() + ",";
					} else {
						grp_parent_cd_list += $("input[name=grp_parnet_check]").eq(i).val() + ",";
						if (depth == 2)
							grp_eng_nm_list += $("input[name=application_check]").eq(i).val() + ",";
						else if (depth == 3)
							grp_eng_nm_list += $("input[name=group_name_check]").eq(i).val() + ",";
					}
					chk_cnt++;
				}
			});
			
			if (chk_cnt < 1) {
				alert("이관할 항목을 선택해주세요.");
				return;
			}
			
			if (!confirm("선택한 "+title+"을(를) 모두 이관 하시겠습니까?"))
				return;

			$("#p_grp_eng_nm").val(grp_eng_nm_list);
			$("#p_grp_table_type").val(grp_table_type_list);
			$("#p_grp_parent_cd").val(grp_parent_cd_list);
			$("#p_scode_cd").val($("#app_grp_data_center").val());
			$("#p_user_daily").val(user_daily_list);
			 
			var frm = document.appGrpCodeForm;
			frm.action = '/tWorks.ez?c=cmAppGrpCodeInsert';
			frm.target = 'if1';
			frm.submit();
		});
		$("#btn_code_close").button().unbind("click").click(function(){
			dlClose('cmAppGrpCode');
		});
		
	}
	
	function checkAll() {
		var chk 	= $("input[name=grp_cd_check]");
		var chk_all = $("#checkIdxAll");
		
		chk.each(function(){
			if (chk_all.attr("checked") && !$(this).attr("disabled")) {
				$(this).attr("checked", true);
			} else {
				$(this).attr("checked", false);
			}
		});
	}
	
	function cmAppGrpCodeList() {
		
		try{viewProgBar(true);}catch(e){}
		$('#ly_code_total_cnt').html('');
		
		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=cmAppGrpCodeList&itemGubun=2';
		var depth = $("#p_grp_depth").val();
		
		var xhr = new XHRHandler(url, appGrpCodeForm, function(){
			var xmlDoc = this.req.responseXML;
			if (xmlDoc == null) {
				try{viewProgBar(false);}catch(e){}
				alert('세션이 만료되었습니다 다시 로그인해 주세요');
				return false;
			}
			
			if ($(xmlDoc).find('doc').length == 0 && $(xmlDoc).find('error').length > 0) {
				try{viewProgBar(false);}catch(e){}
				alert($(xmlDoc).find('msg_code').text());
				return false;
			}
			
			$(xmlDoc).find('doc').each(function(){
				var items = $(this).find('items');
				var rowObj = new Array();
				
				if (items.attr('cnt') == '0') {
				} else {
					items.find('item').each(function(i){
						var data_center = $(this).find("data_center").text();
						var sched_table = $(this).find("sched_table").text();
						var table_type 	= $(this).find("table_type").text();
						var user_daily 	= $(this).find("user_daily").text();
						var application = $(this).find("application").text();
						var group_name 	= $(this).find("group_name").text();
						
						var grp_cd 	= $(this).find("grp_cd").text();
						
						var state = "";
						if (depth != 1 && grp_cd == "")
							state = 'disabled';
						
						v_grp_cd_check = "<div class='gridInput_area'><input type='checkbox' name='grp_cd_check' "+state+"></div>";
						v_grp_cd_check += "<input type='hidden' name='sched_table_check' value='"+sched_table+"' >";
						v_grp_cd_check += "<input type='hidden' name='table_type' value='"+table_type+"' >";
						v_grp_cd_check += "<input type='hidden' name='application_check' value='"+application+"' >";
						v_grp_cd_check += "<input type='hidden' name='group_name_check' value='"+group_name+"' >";
						v_grp_cd_check += "<input type='hidden' name='grp_parnet_check' value='"+grp_cd+"' >";
						v_grp_cd_check += "<input type='hidden' name='user_daily' value='"+user_daily+"' >";
						
						rowObj.push({
							'grid_idx':i+1
							,'data_center': data_center
							,'sched_table': sched_table
							,'table_type': table_type
							,'user_daily': user_daily
							,'application': application
							,'group_name': group_name
							,'grp_cd_check' : v_grp_cd_check
						});
					});
				} 
				
				var obj = $("#appGrpCodeGrid").data('gridObj');
				obj.rows = rowObj;
				setGridRows(obj);
				
				$('#ly_code_total_cnt').html('[ TOTAL : '+items.attr('cnt')+' ]');
			});
			try{viewProgBar(false);}catch(e){}
		}
		, null);
		
		xhr.sendRequest();
	}
	
	function popupExcelCode(scode_cd, ins_type) {
		var scode_cd    = $("select[name='main_grp_nm'] option:selected").val();
		
		var sHtml1="<div id='dl_tmp2' style='overflow:hidden;display:none;padding:0;border-top:1px solid blue;border-bottom:1px solid blue;border-left:1px solid blue;border-right:1px solid blue;'>";
				
		sHtml1+="<form id='frm8' name='frm8' method='post' onsubmit='return false; enctype='multipart/form-data' >";
		sHtml1+="<input type='hidden' name='c' id='c' />";
		sHtml1+="<input type='hidden' name='file_nm' id='file_nm' />";		
		sHtml1+="<input type='hidden' id='doc_gb' 	name='doc_gb' 		value='05' />";
		sHtml1+="<input type='hidden' id='flag'		name='flag' 		value='' />";	
		sHtml1+="<input type='hidden' id='user_cd'	name='user_cd' />";
		sHtml1+="<input type='hidden' id='days_cal'	name='days_cal' />";
		sHtml1+="<input type='hidden' name='grp_depth'       id='grp_depth'     value=''/>"
		sHtml1+="<input type='hidden' name='scode_cd' id='scode_cd' value='"+scode_cd+"' />";
		sHtml1+="<table style='width:99%;height:99%;border:none;'>";
		sHtml1+="<tr style='height:10px;'>";
		sHtml1+="<td style='vertical-align:top;'>";
		sHtml1+="<h4 class='ui-widget-header ui-corner-all'  >";
		sHtml1+="<div id='t_<%=gridId_1 %>' class='title_area'>";
		sHtml1+="<span><%=CommonUtil.isNull(arr_menu_gb[0]) %></span>";
		sHtml1+="</div>";
		sHtml1+="</h4>";
		sHtml1+="</td>";
		sHtml1+="</tr>";
		sHtml1+="<tr>";
		sHtml1+="<td id='ly_<%=gridId_1 %>' style='vertical-align:top;'>";
		sHtml1+="<div id='<%=gridId_1 %>' class='ui-widget-header_kang ui-corner-all'>";
		sHtml1+="<table style='width:100%'>";			
		sHtml1+="<tr>";
		sHtml1+="<td valign='top'>";
		sHtml1+="<table style='width:100%;'>";
		sHtml1+="<tr>";
		sHtml1+="<td width='120px'></td>";
		sHtml1+="<td width='250px'></td>";
		sHtml1+="<td width='120px'></td>";
		sHtml1+="<td width='200px'></td>";
		sHtml1+="<td width='120px'></td>";
		sHtml1+="<td width=''></td>";
		sHtml1+="</tr>";
		sHtml1+="<tr>";
		sHtml1+="</tr>";
		sHtml1+="</table>";   
		sHtml1+="</td>";
		sHtml1+="</tr>";
		sHtml1+="</table>";
		sHtml1+="<table style='width:100%''>";
		sHtml1+="<tr>";
		sHtml1+="<td>";
		sHtml1+="<div class='cellTitle_kang'>작업 정보</div>";
		sHtml1+="</td>";	
		sHtml1+="</tr>";
		sHtml1+="<tr>";
		sHtml1+="<td valign='top'>";
		sHtml1+="<table style='width:100%;''>";
		sHtml1+="<tr>";
		sHtml1+="<td width='120px'></td>";
		sHtml1+="<td width='250px'></td>";
		sHtml1+="<td width='120px'></td>";
		sHtml1+="<td width='200px'></td>";
		sHtml1+="<td width='120px'></td>";
		sHtml1+="<td width=''></td>";
		sHtml1+="</tr>";
		
		sHtml1+="<th>";
		sHtml1+="<div class='cellTitle_kang2'><font color='red'>* </font>첨부파일</div>";
		sHtml1+="</th>";
		sHtml1+="<td colspan='5'>";
		sHtml1+="<div class='cellContent_kang'>";
		sHtml1+="<div class='filebox'>";
		sHtml1+="<input type='text' name='file_data' id='file_data' style='width:40%; height:21px;' readOnly />";
		sHtml1+="<label for='files' style='height:21px;border:1px solid;margin-left:4px;margin-bottom:4px;'>&nbsp;&nbsp;파일선택&nbsp;</label>";
		sHtml1+="<input type='file' name='files' id='files' />";
		sHtml1+="<label for='excel_load1' style='height:21px;border:1px solid;margin-left:4px;margin-bottom:4px;' onClick='load_excel("+ins_type+")'>&nbsp;&nbsp;엑셀로드&nbsp;</label>";
		sHtml1+="<input type='hidden' name='excel_load1' id='excel_load1'>";
		sHtml1+="<label for='excel_form' style='height:21px;border:1px solid;margin-left:4px;margin-bottom:4px;' onClick='excel_form_down("+ins_type+")'>&nbsp;&nbsp;양식다운&nbsp;</label>";
		sHtml1+="<font color='red'>";
		sHtml1+="※엑셀내용에 ' 를 넣으실 수 없습니다.";
		sHtml1+="</font>";
		sHtml1+="</div>";
		sHtml1+="</div>";
		sHtml1+="</td>";			
		sHtml1+="</tr>"; 
		sHtml1+="</table>";
		sHtml1+="</td>";
		sHtml1+="</tr>";
		sHtml1+="</table>";
		sHtml1+="</div>";
		sHtml1+="</td>";
		sHtml1+="</tr>";
		sHtml1+="<tr>";
		sHtml1+="<td style='height:100%;'>";
		sHtml1+="<iframe name='if2' id='if2' style='width:100%;height:520px;' scrolling='no' frameborder='0'></iframe>";
		sHtml1+="</td>";
		sHtml1+="</tr>";
		sHtml1+="</table>";
		sHtml1+="</form>";
		
		$('#dl_tmp2').remove();
		$('body').append(sHtml1);
				
		dlPop01('dl_tmp2', "엑셀일괄", 1200, 700, false);
				
				
		$("#frm8 #title").focus();
			
		$("#if2").hide();
				
				
		$("#frm8 #files").change(function(){
			$("#frm8 #file_data").val($(this).val());			
		});
	
		$("#frm8 #data_center_items").change(function(){
			if($(this).val() != ""){		
				var scode_cd = $("#frm8 select[name='data_center_items'] option:selected").val();
				$("#frm8 #data_center").val(scode_cd);
			}
		});
				
	}
	
	function load_excel(ins_type) {
		var file		= $("#frm8 #file_data").val();
		var content		= $("#frm8 #content").val();

		if(file == ''){
			alert("첨부 파일을 입력하세요");
			return;
		}
		
		if(file.indexOf('.xls') == -1){
			alert('xls형식만 업로드할 수 있습니다.');
			return;
		}
			
		
		
		var formData = new FormData();
		formData.append("c", "defJobExcelUpload");
		formData.append("random", Math.random());
		formData.append("files", $("#frm8 input[name=files]")[0].files[0]);
		try{viewProgBar(true);}catch(e){}
		
		$.ajax({
			url: "<%=sContextPath %>/tWorks.ez",
			type: "post",
			processData: false,
			contentType: false,
			dataType: "text",
			data: formData,
			cache:false,
			success: completeHandler = function(data){
									
				var file_nm = data;
				if(file_nm != ""){
					
					$("#if2").show();
					
					var frm = document.frm8;
					frm.c.value = "AppGrpExcelLoad";
					frm.file_nm.value = file_nm;
					
					if(ins_type ==  1) {
						frm.grp_depth.value = "1";
					}else if(ins_type == 2) {
						frm.grp_depth.value = "2";
					}else {
						frm.grp_depth.value = "3";
					}
					
					frm.target = "if2";											
					frm.action = "<%=sContextPath%>/tWorks.ez";
					frm.submit();
				}
			},
			error: function(data2){
				alert("error:::"+JSON.stringify(data2));	
			},
			complete: function(){
				try{viewProgBar(false);}catch(e){}		
			}
		});
	}
	
	function excel_form_down(ins_type) {
		var frm = document.frm9;
		frm.grp_depth.value = ins_type;
		frm.action = "<%=sContextPath %>/common.ez?c=ezAppGrp_excel_form";
		frm.target = "if1";
		frm.submit();
	}
	
	// 폴더에 매핑된 유저 조회
	function goUserSearch(grp_eng_nm){
		
		var sHtml2="<div id='dl_tmp3' style='overflow:hidden;display:none;padding:0;border-top:1px solid blue;border-bottom:1px solid blue;border-left:1px solid blue;border-right:1px solid blue;'>";
		sHtml2+="<form id='form3' name='form3' method='post' onsubmit='return false;'>";
		sHtml2+="<table style='width:100%;height:465px;;border:none;'><tr><td style='vertical-align:top;height:100%;width:500px;'>";
		sHtml2+="<select name='ser_gubun' id='ser_gubun' style='height:21px;'>";
		sHtml2+="<option value='user_nm'>사용자명</option>";
		sHtml2+="<option value='user_id'>아이디</option>";
		sHtml2+="<option value='dept_nm'>부서명</option>";
		sHtml2+="</select>";
		sHtml2+="<input type='text' name='ser_user_nm' id='ser_user_nm' />&nbsp;&nbsp;<span id='btn_usersearch'>검색</span>";
		sHtml2+="<table style='width:100%;height:100%;border:none;'>";
		sHtml2+="<tr><td id='ly_g_tmp4' style='vertical-align:top;' >";
		sHtml2+="<div id='g_tmp4' class='ui-widget-header ui-corner-all'></div>";
		sHtml2+="</td></tr>";
		sHtml2+="<tr style='height:10px;'><td style='vertical-align:top;'><h5 class='ui-widget-header ui-corner-all' >";
		sHtml2+="<div align='right' class='btn_area_s'>";
		sHtml2+="<div id='ly_user_total_cnt' style='padding-top:5px;float:left;'></div>";
		sHtml2+="</div>";
		sHtml2+="</h5></td></tr></table>";
		
		sHtml2+="</td></tr></table>";
		
		sHtml2+="</form>";
		
		$('#dl_tmp3').remove();
		$('body').append(sHtml2);
		
		dlPop01('dl_tmp3',"사용자내역",400,505,false);
		
		var gridObj_User = {
			id : "g_tmp4"
			,colModel:[
				
				{formatter:gridCellNoneFormatter,field:'dept_nm',id:'dept_nm',name:'부서명',width:100,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
				,{formatter:gridCellNoneFormatter,field:'duty_nm',id:'duty_nm',name:'직책',width:60,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
				,{formatter:gridCellNoneFormatter,field:'user_nm',id:'user_nm',name:'사용자명',width:80,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
				,{formatter:gridCellNoneFormatter,field:'user_id',id:'user_id',name:'아이디',width:80,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
				
		   		,{formatter:gridCellNoneFormatter,field:'user_cd',id:'user_cd',name:'user_cd',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
		   	]
			,rows:[]
		};
		
		viewGrid_1(gridObj_User,'ly_'+gridObj_User.id);
		
		$("#ser_user_nm").focus();
		
		var ser_gubun = $("select[name='ser_gubun'] option:selected").val();
		var ser_user_nm = $("#ser_user_nm").val();
			
		getFolderUserList(grp_eng_nm, ser_user_nm, ser_gubun); 
		
		$('#ser_user_nm').placeholder().unbind('keypress').keypress(function(e){
			if(e.keyCode==13 && trim($('#ser_user_nm').val())!=''){				
				var ser_gubun = $("select[name='ser_gubun'] option:selected").val();	
				var ser_user_nm = $("#ser_user_nm").val();
				
				getFolderUserList(grp_eng_nm, ser_user_nm, ser_gubun);
			}
		});
		
		
		$("#btn_usersearch").button().unbind("click").click(function(){
			var ser_gubun = $("select[name='ser_gubun'] option:selected").val();
			var ser_user_nm = $("#ser_user_nm").val();
			
			getFolderUserList(grp_eng_nm, ser_user_nm, ser_gubun);
		});
	}
	
	function getFolderUserList(grp_eng_nm, ser_user_nm, ser_gubun){
		try{viewProgBar(true);}catch(e){}
		$('#ly_user_total_cnt').html('');
		var scode_cd = $("select[name='main_grp_nm']").val();
		var data_center = "";
		<c:forEach var="scodeGrpList" items="${SCODE_GRP_LIST}" varStatus="status">
			if(scode_cd == "${scodeGrpList.scode_cd}") {
				data_center = "${scodeGrpList.scode_cd},${scodeGrpList.scode_eng_nm}";
			}
		</c:forEach>
		
		console.log("data_center : " + data_center);
		var url = "";
		url = '/common.ez?c=cData&itemGb=folderUserList&p_grp_eng_nm='+grp_eng_nm+'&p_data_center='+data_center+'&p_ser_user_nm='+ser_user_nm+'&p_ser_gubun='+ser_gubun+'&p_del_yn=N';
		var xhr = new XHRHandler( url, null
				,function(){
					var xmlDoc = this.req.responseXML;
					if(xmlDoc==null){
						try{viewProgBar(false);}catch(e){}
						alert('세션이 만료되었습니다 다시 로그인해 주세요');
						return false;
					}

					if($(xmlDoc).find('doc').length == 0 && $(xmlDoc).find('error').length > 0){
						goCommonError('','_self',$(xmlDoc).find('msg_code').text());
						return false;
					}
					$(xmlDoc).find('doc').each(function(){

						var items = $(this).find('items');
						var rowsObj = new Array();

						if(items.attr('cnt')=='0'){
						}else{
							items.find('item').each(function(i){

								var dept_nm = $(this).find("DEPT_NM").text();
								var duty_nm = $(this).find("DUTY_NM").text();
								var user_nm = $(this).find("USER_NM").text();
								var user_cd = $(this).find("USER_CD").text();
								var user_id = $(this).find("USER_ID").text();

								rowsObj.push({'grid_idx':i+1
									,'dept_nm':dept_nm
									,'duty_nm':duty_nm
									,'user_nm':user_nm
									,'user_id':user_id
									,'user_cd':user_cd
								});

							});

						}
						var obj = $("#g_tmp4").data('gridObj');
						obj.rows = rowsObj;
						setGridRows(obj);

						$('#ly_user_total_cnt').html('[ TOTAL : '+items.attr('cnt')+' ]');
					});
					try{viewProgBar(false);}catch(e){}
				}
		, null );
		xhr.sendRequest();
	}
	
</script>
