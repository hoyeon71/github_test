<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/jsp/common/inc/header.jsp"%>

<c:set var="user_gb_cd" 		value="${fn:split(USER_GB_CD,',')}"/>
<c:set var="user_gb_nm" 		value="${fn:split(USER_GB_NM,',')}"/>
<c:set var="duty_gb_cd" 		value="${fn:split(DUTY_GB_CD,',')}"/>
<c:set var="duty_gb_nm" 		value="${fn:split(DUTY_GB_NM,',')}"/>
<c:set var="dept_gb_cd" 		value="${fn:split(DEPT_GB_CD,',')}"/>
<c:set var="dept_gb_nm" 		value="${fn:split(DEPT_GB_NM,',')}"/>
<c:set var="user_appr_gb_cd" 	value="${fn:split(USER_APPR_GB_CD,',')}"/>
<c:set var="user_appr_gb_nm" 	value="${fn:split(USER_APPR_GB_NM,',')}"/>

<%
	Map<String, Object> paramMap = CommonUtil.collectParameters(request);
	String c = CommonUtil.isNull(paramMap.get("c"));
	String gridId = "g_"+c;
	
	List userAuthList	= (List)request.getAttribute("userAuthList");
	
	String cm = CommonUtil.isNull(paramMap.get("SCODE_GRP_LIST"));
	String strSessionDcCode 	= S_D_C_CODE;
	if(!strSessionDcCode.equals("")) {
		String[] arr_sessionDcCode = strSessionDcCode.split(",");
		strSessionDcCode = arr_sessionDcCode[0];
	}
	
	String strSearchStartDate 	= CommonUtil.getCurDateTo(CommonUtil.getCurDate(""), -6);
	String strSearchEndDate = CommonUtil.getCurDateTo(CommonUtil.getCurDate(""), 0);

	String menu_gb = CommonUtil.getMessage("CATEGORY.GB.06.GB."+CommonUtil.isNull(paramMap.get("menu_gb")));
	String[] arr_menu_gb = menu_gb.split(",");
	
	//스크롤 페이징
	String strPagingNum			= CommonUtil.getMessage("PAGING.NUM");
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
	<input type="hidden" name="p_search_gubun" id="p_search_gubun"/>
	<input type="hidden" name="p_search_text" 		id="p_search_text"/>
	<input type="hidden" name="p_del_yn" 			id="p_del_yn"/>
	<input type="hidden" name="p_grp_depth" 		id="p_grp_depth"/>
	<input type="hidden" name="startRowNum" 		id="startRowNum" 	value="0" />
	<input type="hidden" name="pagingNum" 			id="pagingNum" 	value="<%=strPagingNum%>" />
</form>
<form id="frm2" name="frm2" method="post" onsubmit="return false;">
	<input type="hidden" name="flag" />
	<input type="hidden" name="user_cd" />
	<input type="hidden" name="user_id" />
	<input type="hidden" name="user_nm" />
	<input type="hidden" name="user_pw" />
	<input type="hidden" name="user_gb" />
	<input type="hidden" name="user_email" />
	<input type="hidden" name="user_hp" />
	<input type="hidden" name="dept_cd" />
	<input type="hidden" name="duty_cd" />
	<input type="hidden" name="job_cd" />
	<input type="hidden" name="del_yn" />
	<input type="hidden" name="account_lock" />
	<input type="hidden" name="insa_yn" />
</form>
<form id="frm3" name="frm3" method="post" onsubmit="return false;">
	<input type="hidden" name="user_cd" />
	<input type="hidden" name="user_id" />
	<input type="hidden" name="user_nm" />
	<input type="hidden" name="authPopup" />
	<input type="hidden" name="arr_user_cd" />
	<input type="hidden" name="arr_user_id" />
</form>
<form name="form3" id="form3" method="post" onsubmit="return false;">
	<input type="hidden" name="user_cd" id="user_cd"/>
</form>
<form name="form4" id="form4" method="post" onsubmit="return false;">
	<input type="hidden" name="menu_gb" id="menu_gb" value="<%=CommonUtil.isNull(paramMap.get("menu_gb"))%>" />
</form>
<form name="form5" id="form5" method="post" onsubmit="return false;">
	<input type="hidden" name="menu_gb" id="menu_gb" value="<%=CommonUtil.isNull(paramMap.get("menu_gb"))%>" />
	<input type="hidden" name="p_search_gubun" 		id="p_search_gubun"/>
	<input type="hidden" name="p_search_text" 		id="p_search_text"/>
	<input type="hidden" name="p_del_yn" 			id="p_del_yn"/>
</form>
<form name="form6" id="form6" method="post" onsubmit="return false;">
</form>
<form name="allUdtFrm" id="allUdtFrm" method="post" onsubmit="return false;">
	<input type="hidden" name="flag2" id="flag2"/>
</form>
<form name="delFrm" id="delFrm" method="post" onsubmit="return false;">
	<input type="hidden" name="delUserList" id="delUserList"/>
	<input type="hidden" name="flag" id="flag"/>
</form>
<form name="folderFrm" id="folderFrm" method="post" onsubmit="return false;">
	<input type="hidden" name="flag" 			value='folder_auth' />
	<input type="hidden" name="user_cd" 		value=''/>
	<input type="hidden" name="user_id" 		value=''/>
	<input type="hidden" name="arr_user_cd" 	value=''/>
	<input type="hidden" name="arr_user_id" 	value=''/>
	<input type="hidden" name="folder_auth" />
</form>
<form name="f_tmp" id="f_tmp" method="post" onsubmit="return false;">
</form>
<form name="f_appgrp" id="f_appgrp" method="post" onsubmit="return false;">
	<input type="hidden" name="user_cd" 		 id="user_cd"	value='' />
	<input type="hidden" name="is_more_than_two" id="is_more_than_two"	value='' />
	<input type="hidden" name="select_dcc"		 id="select_dcc"	value='' />
</form>
<table style='width:100%;height:100%;border:none;'>
	<tr style='height:10px;'>
		<td style='vertical-align:top;'>
			<h4 class="ui-widget-header ui-corner-all"  >
				<div id='t_<%=gridId %>' class='title_area' >
					<span><%=CommonUtil.isNull(CommonUtil.getMessage("CATEGORY.GB.06"))%> > <%=CommonUtil.isNull(arr_menu_gb[0]) %></span>
				</div>
			</h4>
		</td>
	</tr>
	<tr style='height:10px;'>
		<td style='vertical-align:top;'>
			<form name="frm1" id="frm1" method="post">
				<h4 class="ui-widget-header ui-corner-all">
					<table style='width:100%;'>
						<tr>
							<th width='10%'><div class='cellTitle_kang2'>조건</div></th>
							<td width='35%'>
								<div class='cellContent_kang'>
									<select name="search_gubun" id="search_gubun" style="width:120px;height:21px;">
										<option value="all">전체</option>
										<option value="user_id">아이디</option>
										<option value="user_nm">이름</option>
										<option value="duty_nm">직책</option>
										<option value="dept_nm">부서</option>
									</select>&nbsp;
									<input type="text" name="search_text" value="" id="search_text" style="width:150px; height:21px;" />
								</div>
							</td>
							<th width='10%'><div class='cellTitle_kang2'>사용여부</div></th>
							<td width='35%'>
								<div class='cellContent_kang'>
									<select name="del_yn" id="del_yn" style="width:120px;height:21px;">
										<option value="">전체</option>
										<option value="N" selected>사용</option>
										<option value="Y">미사용</option>
									</select>
								</div>
							</td>
							<td style="text-align:right">
								<span id="btn_search" style='display:none;margin:3px;'>검 색</span>
							</td>
						</tr>
						<tr>

						</tr>
					</table>
				</h4>
			</form>
		</td>
	</tr>
	<tr>
		<td id='ly_<%=gridId %>' style='vertical-align:top;'>
			<div id="<%=gridId %>" class="ui-widget-header ui-corner-all"></div>
		</td>
	</tr>
	<tr style='height:10px;'>
		<td style='vertical-align:top;'>
			<h4 class="ui-widget-header ui-corner-all">
				<div align='right' class='btn_area'>
					<div id='ly_total_cnt' style='padding-top:5px;float:left;'></div>
					<!-- <span id="btn_pw_all_change">패스워드 일괄 변경</span> -->
					<span id="btn_insert">사용자 추가</span>
					<!-- 					<span id="btn_update">수정</span> -->
					<span id="btn_delete">사용자 삭제</span>
					<span id="btn_folappgrp_copy">폴더권한복사</span>
					<span id="btn_all_folderAuth">일괄폴더권한</span>
					<span id="btn_all_roleAuth">일괄메뉴제한</span>
					<span id="btn_all_pw_init">일괄 패스워드 초기화</span>
					<span id="btn_all_lock_init">일괄 잠금 해제</span>
					<span id="btn_login_excel">로그인 이력</span>
					<span id="btn_history_excel">관리 이력</span>
					<span id="btn_insert_excel">엑셀일괄</span>
					<span id="btn_excel">엑셀다운</span>

				</div>
			</h4>
		</td>
	</tr>
</table>

<div id="dl_p01" style='overflow:hidden;display:none;padding:0;'>
	<iframe id='if_p01' name='if_p01' src='about:blank' width='0px' height='0px' scrolling='no'  frameborder="0"  ></iframe>
</div>

<script>

	var listChk = false;

	var arr_user_gb_cd = new Array();
	var arr_user_gb_nm = new Array();
	var arr_duty_gb_cd = new Array();
	var arr_duty_gb_nm = new Array();
	var arr_dept_gb_cd = new Array();
	var arr_dept_gb_nm = new Array();
	var arr_user_appr_gb_cd = new Array();
	var arr_user_appr_gb_nm = new Array();

	<c:forEach var="user_gb_cd" items="${user_gb_cd}" varStatus="s">
	var map_cd = {"cd":"${user_gb_cd}"};
	arr_user_gb_cd.push(map_cd);
	</c:forEach>
	<c:forEach var="user_gb_nm" items="${user_gb_nm}" varStatus="s">
	var map_nm = {"nm":"${user_gb_nm}"};
	arr_user_gb_nm.push(map_nm);
	</c:forEach>

	<c:forEach var="duty_gb_cd" items="${duty_gb_cd}" varStatus="s">
	var map_cd = {"cd":"${duty_gb_cd}"};
	arr_duty_gb_cd.push(map_cd);
	</c:forEach>
	<c:forEach var="duty_gb_nm" items="${duty_gb_nm}" varStatus="s">
	var map_nm = {"nm":"${duty_gb_nm}"};
	arr_duty_gb_nm.push(map_nm);
	</c:forEach>

	<c:forEach var="dept_gb_cd" items="${dept_gb_cd}" varStatus="s">
	var map_cd = {"cd":"${dept_gb_cd}"};
	arr_dept_gb_cd.push(map_cd);
	</c:forEach>
	<c:forEach var="dept_gb_nm" items="${dept_gb_nm}" varStatus="s">
	var map_nm = {"nm":"${dept_gb_nm}"};
	arr_dept_gb_nm.push(map_nm);
	</c:forEach>
	<c:forEach var="user_appr_gb_cd" items="${user_appr_gb_cd}" varStatus="s">
	var map_nm = {"cd":"${user_appr_gb_cd}"};
	arr_user_appr_gb_cd.push(map_nm);
	</c:forEach>
	<c:forEach var="user_appr_gb_nm" items="${user_appr_gb_nm}" varStatus="s">
	var map_nm = {"nm":"${user_appr_gb_nm}"};
	arr_user_appr_gb_nm.push(map_nm);
	</c:forEach>

	function gridCellCustomFormatter(row,cell,value,columnDef,dataContext){

		var ret = "";
		var user_id = getCellValue(gridObj,row,'USER_ID');
		var user_nm = getCellValue(gridObj,row,'USER_NM');
		var user_cd = getCellValue(gridObj,row,'USER_CD');
		var user_gb = getCellValue(gridObj,row,'USER_GB');
		var no_auth = getCellValue(gridObj,row,'NO_AUTH');
		var folder_name = getCellValue(gridObj,row,'SELECT_TABLE_NAME');
		var select_dcc = getCellValue(gridObj,row,'SELECT_DCC');

		if(columnDef.id == 'AUTH'){
			if(user_gb != "99"){
				//3.0 팝업
				ret = "<a href=\"JavaScript:popupAppGrpCodeForm2('"+user_cd+"','','"+select_dcc+"');\" /><font color='red'>"+value+"</font></a>";
// 				ret = "<a href=\"JavaScript:popupFolderAuth('"+user_cd+"','"+user_id+"','"+user_nm+"');\" /><font color='red'>"+value+"</font></a>";
				//4.0 팝업
				//ret = "<a href=\"JavaScript:userFolderForm('"+user_cd+"','"+user_id+"','"+user_nm+"');\" /><font color='red'>"+value+"</font></a>";
			}else{
				ret = value;
			}
		}
		if(columnDef.id == 'NO_AUTH_GB'){
			if(user_gb != "99"){
				//3.0 팝업
				ret = "<a href=\"JavaScript:popupRoleAuth('"+user_cd+"','"+no_auth+"');\" /><font color='red'>"+value+"</font></a>";
				//4.0 팝업
				//ret = "<a href=\"JavaScript:userFolderForm('"+user_cd+"','"+user_id+"','"+user_nm+"');\" /><font color='red'>"+value+"</font></a>";
			}else{
				ret = value;
			}
		}
		
		if(columnDef.id == 'APPROVAL'){
			ret = "<a href=\"JavaScript:popupApprovalLine('"+user_cd+"');\" /><font color='red'>"+value+"</font></a>";
		}

		if(columnDef.id == 'USER_ID' || columnDef.id == 'USER_NM'){
			ret = "<a href=\"JavaScript:userUpdate('"+user_cd+"');\" /><font color='red'>"+value+"</font></a>";
		}

		return ret;
	}

	var gridObj = {
		id : "<%=gridId %>"
		,colModel:[
			{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'번호',width:50,minWidth:50,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
			,{formatter:gridCellCustomFormatter,field:'USER_ID',id:'USER_ID',name:'아이디',width:100,minWidth:100,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
			,{formatter:gridCellCustomFormatter,field:'USER_NM',id:'USER_NM',name:'이름',width:100,minWidth:100,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
			,{formatter:gridCellNoneFormatter,field:'USER_GB_NM',id:'USER_GB_NM',name:'구분',width:80,minWidth:80,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
			,{formatter:gridCellNoneFormatter,field:'USER_EMAIL',id:'USER_EMAIL',name:'메일',width:130,minWidth:130,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
			,{formatter:gridCellNoneFormatter,field:'USER_HP',id:'USER_HP',name:'휴대폰번호',width:100,minWidth:100,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
			,{formatter:gridCellNoneFormatter,field:'USER_TEL',id:'USER_TEL',name:'내선번호',width:100,minWidth:100,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
			,{formatter:gridCellNoneFormatter,field:'DEPT_NM',id:'DEPT_NM',name:'부서',width:80,minWidth:80,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
			,{formatter:gridCellNoneFormatter,field:'DUTY_NM',id:'DUTY_NM',name:'직책',width:80,minWidth:80,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
			,{formatter:gridCellNoneFormatter,field:'SELECT_DCC',id:'SELECT_DCC',name:'기본 C-M',width:100,minWidth:100,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
			,{formatter:gridCellNoneFormatter,field:'SELECT_TABLE_NAME',id:'SELECT_TABLE_NAME',name:'폴더',width:100,minWidth:100,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'USER_APPR_GB',id:'USER_APPR_GB',name:'결재구분',width:90,minWidth:90,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
			,{formatter:gridCellNoneFormatter,field:'DEL_YN',id:'DEL_YN',name:'사용여부',width:60,minWidth:60,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
			,{formatter:gridCellNoneFormatter,field:'ACCOUNT_LOCK_CHK',id:'ACCOUNT_LOCK_CHK',name:'잠금관리',width:100,minWidth:100,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
			,{formatter:gridCellCustomFormatter,field:'APPROVAL',id:'APPROVAL',name:'결재선관리',width:100,headerCssClass:'cellCenter',cssClass:'cellCenter'}
			,{formatter:gridCellCustomFormatter,field:'AUTH',id:'AUTH',name:'폴더권한',width:70,minWidth:70,headerCssClass:'cellCenter',cssClass:'cellCenter'}
			,{formatter:gridCellCustomFormatter,field:'NO_AUTH_GB',id:'NO_AUTH_GB',name:'메뉴제한',width:70,minWidth:70,headerCssClass:'cellCenter',cssClass:'cellCenter'}
			,{formatter:gridCellNoneFormatter,field:'USER_IP',id:'USER_IP',name:'아이피',width:120,minWidth:120,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
			,{formatter:gridCellNoneFormatter,field:'MAX_LOGIN_DATE',id:'MAX_LOGIN_DATE',name:'최종 접속일',width:130,minWidth:130,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
			,{formatter:gridCellNoneFormatter,field:'INS_DATE',id:'INS_DATE',name:'등록일',width:130,minWidth:130,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}

			,{formatter:gridCellNoneFormatter,field:'USER_CD',id:'USER_CD',name:'USER_CD',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
			,{formatter:gridCellNoneFormatter,field:'DEPT_CD',id:'DEPT_CD',name:'DEPT_CD',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
			,{formatter:gridCellNoneFormatter,field:'DUTY_CD',id:'DUTY_CD',name:'DUTY_CD',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
			,{formatter:gridCellNoneFormatter,field:'USER_GB',id:'USER_GB',name:'USER_GB',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
			,{formatter:gridCellNoneFormatter,field:'NO_AUTH',id:'NO_AUTH',name:'NO_AUTH',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
			,{formatter:gridCellNoneFormatter,field:'ACCOUNT_LOCK',id:'ACCOUNT_LOCK',name:'ACCOUNT_LOCK',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
		]
		,rows:[]
		,vscroll: <%=S_GRID_VSCROLL%>
	};

	$(document).ready(function() {

		var session_user_gb	= "<%=S_USER_GB%>";
		
		setTimeout(function(){
			$("#search_text").focus();
		}, 100);

		// 운영자만 버튼 display
		if ( session_user_gb != "99" ) {
			$("#btn_pw_all_clear").hide();
			$("#btn_pw_all_change").hide();
		}

		$("#btn_search").show();

		viewGrid_1(gridObj,"ly_"+gridObj.id,{enableColumnReorder:true},'AUTO');
		//userList();		//초기 전체사용자 로드
		
		$("#btn_insert_excel").button().unbind("click").click(function(){

			$("#f_s").find("input[name='p_search_gubun']").val($("#frm1").find("select[name='search_gubun'] option:selected").val());
			$("#f_s").find("input[name='p_search_text']").val($("#frm1").find("input[name='search_text']").val());
			$("#f_s").find("input[name='p_del_yn']").val($("#frm1").find("select[name='del_yn'] option:selected").val());
			popupExcelCode();
// 			userList();
		});
		
		$("#btn_search").button().unbind("click").click(function(){

			/*
			if($("#search_text").val() == ""){
				alert("검색어를 입력해 주세요.");
				return;
			}
			*/

			$("#f_s").find("input[name='p_search_gubun']").val($("#frm1").find("select[name='search_gubun'] option:selected").val());
			$("#f_s").find("input[name='p_search_text']").val($("#frm1").find("input[name='search_text']").val());
			$("#f_s").find("input[name='p_del_yn']").val($("#frm1").find("select[name='del_yn'] option:selected").val());

			setTimeout(function(){
				userList();
			}, 1000);
		});

		$("#btn_folappgrp_copy").button().unbind("click").click(function(){
			popFolAppGrpCopy();
		});

		$('#search_text').unbind('keypress').keypress(function(e){
			if(e.keyCode==13){

// 				if($(this).val() == ""){
// 					alert("검색어를 입력해 주세요.");
// 					return;
// 				}

				$("#f_s").find("input[name='p_search_gubun']").val($("#frm1").find("select[name='search_gubun'] option:selected").val());
				$("#f_s").find("input[name='p_search_text']").val($("#frm1").find("input[name='search_text']").val());
				$("#f_s").find("input[name='p_del_yn']").val($("#frm1").find("select[name='del_yn'] option:selected").val());
				userList();
			}
		});
		$("#btn_login_excel").button().unbind("click").click(function(){
			popupLoginHistory();
		});
		$("#btn_history_excel").button().unbind("click").click(function(){
			goHistoryExcel();
		});
		$("#btn_excel").button().unbind("click").click(function(){
			goExcel();
		});
		$("#btn_insert").button().unbind("click").click(function(){
			userInsert();
		});

		$("#btn_update").button().unbind("click").click(function(){

			var cnt = 0;
			var user_cd = "";
			var aSelRow = new Array;
			aSelRow = $('#'+gridObj.id).data('grid').getSelectedRows();
			if(aSelRow.length>0){
				for(var i=0;i<aSelRow.length;i++){
					user_cd = getCellValue(gridObj,aSelRow[i],'USER_CD');

					++cnt;
				}

				if(cnt > 1){
					alert("한개의 사용자만 선택해 주세요.");
					return;
				}else{
					userUpdate(user_cd);
				}

			}else{
				alert("수정하려는 사용자를 선택해 주세요.");
				return;
			}

		});

		$("#btn_delete").button().unbind("click").click(function(){
			var user_cd = "";
			var aSelRow = new Array;
			aSelRow = $('#'+gridObj.id).data('grid').getSelectedRows();

			if(aSelRow.length == 0){
				alert("삭제하려는 사용자를 선택해 주세요.");
				return;
			}

			for (var i = 0; i < aSelRow.length; i++) {
				if (getCellValue(gridObj,aSelRow[i],'DEL_YN') == 'N') {
					alert("이미 삭제된 사용자가 포함되어 있습니다.");
					return;
				}
			}

			if (!confirm("선택한 사용자를 삭제 하시겠습니까?"))
				return;

			for (var i = 0; i < aSelRow.length; i++) {
				user_cd += getCellValue(gridObj,aSelRow[i],'USER_CD');
				if (i < aSelRow.length-1)
					user_cd += ",";
			}

			var f = document.delFrm;

			try{viewProgBar(true);}catch(e){}

			f.flag.value = "del";
			f.target = "if1";
			f.delUserList.value = user_cd;
			f.action = "<%=sContextPath %>/tWorks.ez?c=ez002_p";
			f.submit();

			try{viewProgBar(false);}catch(e){}

			//그리드 선택 해제
			$('#'+gridObj.id).data('grid').getSelectionModel().setSelectedRanges([]);
		});

		//일괄 패스워드 초기화(김은희)
		$("#btn_all_pw_init").button().unbind("click").click(function(){
			var user_cd = "";
			var user_id = "";
			var aSelRow = new Array;
			aSelRow = $('#'+gridObj.id).data('grid').getSelectedRows();

			if(aSelRow.length == 0){
				alert("패스워드 초기화를 설정할 사용자를 선택해주세요.");
				return;
			}

			for (var i = 0; i < aSelRow.length; i++) {
				user_cd += getCellValue(gridObj,aSelRow[i],'USER_CD');
				if (i < aSelRow.length-1)
					user_cd += ",";
			}

			for (var i = 0; i < aSelRow.length; i++) {
				user_id += getCellValue(gridObj,aSelRow[i],'USER_ID');
				if (i < aSelRow.length-1)
					user_id += ",";
			}

			fn_pw_all_init(user_cd,user_id);
		});

		//일괄 잠금 해제(김은희)
		$("#btn_all_lock_init").button().unbind("click").click(function(){
			var user_cd = "";
			var user_id = "";
			var account_lock = "";
			var aSelRow = new Array;
			aSelRow = $('#'+gridObj.id).data('grid').getSelectedRows();

			if(aSelRow.length == 0){
				alert("계정 잠금해제를 설정할 사용자를 선택해주세요.");
				return;
			}

			for (var i = 0; i < aSelRow.length; i++) {
				user_cd += getCellValue(gridObj,aSelRow[i],'USER_CD');
				if (i < aSelRow.length-1)
					user_cd += ",";
			}

			for (var i = 0; i < aSelRow.length; i++) {
				user_id += getCellValue(gridObj,aSelRow[i],'USER_ID');
				if (i < aSelRow.length-1)
					user_id += ",";
			}

			for (var i = 0; i < aSelRow.length; i++) {
				account_lock += getCellValue(gridObj,aSelRow[i],'ACCOUNT_LOCK');
				if (i < aSelRow.length-1)
					account_lock += ",";
			}

			fn_account_lock_init(user_cd,user_id,account_lock);
		});

		$("#btn_pw_all_change").button().unbind("click").click(function(){
			goPrc('pw_all_change');
		});

		// 일괄폴더권한
		$("#btn_all_folderAuth").button().unbind("click").click(function(){
			var user_cd = "";
			var user_id = "";
			var user_nm = "";
			var isMoreThanTwo = false;
			var aSelRow = new Array;
			aSelRow = $('#'+gridObj.id).data('grid').getSelectedRows();

			if(aSelRow.length == 0){
				alert("폴더권한을 설정할 사용자를 선택해주세요.");
				return;
			}
			
			if(aSelRow.length > 0) isMoreThanTwo = true;

			for (var i = 0; i < aSelRow.length; i++) {
				user_cd += getCellValue(gridObj,aSelRow[i],'USER_CD');
				user_id += getCellValue(gridObj,aSelRow[i],'USER_ID');
				user_nm += getCellValue(gridObj,aSelRow[i],'USER_NM');
				if (i < aSelRow.length-1)
					user_cd += ",";
				user_id += ",";
				user_nm += ",";
			}

			allpopupFolderAuth(user_cd,user_id,user_nm, isMoreThanTwo);


		});

		//일괄메뉴권한
		$("#btn_all_roleAuth").button().unbind("click").click(function(){

			var user_cd = "";

			var aSelRow = new Array;
			aSelRow = $('#'+gridObj.id).data('grid').getSelectedRows();

			if(aSelRow.length == 0){
				alert("메뉴권한을 설정할 사용자를 선택해주세요.");
				return;
			}

			for (var i = 0; i < aSelRow.length; i++) {
				user_cd += getCellValue(gridObj,aSelRow[i],'USER_CD');
				if (i < aSelRow.length-1)
					user_cd += ",";
			}
			popupRoleAuth(user_cd);
		});
		
		//스크롤 페이징
		var grid = $('#'+gridObj.id).data('grid');
		grid.onScroll.subscribe(function(e, args){
			var elem = $("#g_ez002").children(".slick-viewport");
			if ( elem[0].scrollHeight - elem.scrollTop() - elem.css("height").replace("px", "") + 17 < 100) {
				if(listChk) {
					listChk = false;
					var startRowNum = parseInt($("#startRowNum").val());
					startRowNum += parseInt($('#pagingNum').val());
					userList(startRowNum);
				}
			}
		});

	});

	function userList(startRowNum){

		$("#f_s").find("input[name='p_search_gubun']").val($("#frm1").find("select[name='search_gubun'] option:selected").val());
		$("#f_s").find("input[name='p_search_text']").val($("#frm1").find("input[name='search_text']").val());
		$("#f_s").find("input[name='p_del_yn']").val($("#frm1").find("select[name='del_yn'] option:selected").val());
		
		//페이징 처리
		if(startRowNum != '' && startRowNum != null && startRowNum != undefined) {
			$('#startRowNum').val(startRowNum);
		} else {
			var elem = $("#g_ez002").children(".slick-viewport");
			elem.scrollTop(0);
			startRowNum = 0;
			$('#startRowNum').val(0);
		}
		
		try{viewProgBar(true);}catch(e){}
		$('#ly_total_cnt').html('');

		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=userList';

		var xhr = new XHRHandler(url, f_s
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
						
						if(startRowNum != '' && startRowNum != null && startRowNum != undefined) {
							rowsObj = gridObj.rows;
						}

						if(items.attr('cnt')=='0'){
						}else{
							items.find('item').each(function(i){

								var user_id 				= $(this).find("USER_ID").text();
								var user_nm 				= $(this).find("USER_NM").text();
								var user_email 				= $(this).find("USER_EMAIL").text();
								var user_gb 				= $(this).find("USER_GB").text();
								var user_hp 				= $(this).find("USER_HP").text();
								var user_tel 				= $(this).find("USER_TEL").text();
								var dept_cd 				= $(this).find("DEPT_CD").text();
								var duty_cd 				= $(this).find("DUTY_CD").text();
								var user_appr_gb 			= $(this).find("USER_APPR_GB").text();
								var del_yn		 			= $(this).find("DEL_YN").text();
								var no_auth 				= $(this).find("NO_AUTH").text();
								var account_lock 			= $(this).find("ACCOUNT_LOCK").text();
								var ins_date 				= $(this).find("INS_DATE").text();
								var user_cd 				= $(this).find("USER_CD").text();
								var select_dcc				= $(this).find("SELECT_DCC").text();
								var select_table_name 		= $(this).find("SELECT_TABLE_NAME").text();
								var user_ip 				= $(this).find("USER_IP").text();
								var max_login_date			= $(this).find("MAX_LOGIN_DATE").text();

								var user_gb_nm 				= "";
								var dept_nm 				= "";
								var duty_nm 				= "";
								var auth 					= "";
								var no_auth_gb 				= "";
								var account_lock_chk		= "";
								var approval 				= "<div>[설정]</div>";

								if(user_gb !== "99"){
									auth 		= "<div>[설정]</div>";
									no_auth_gb 	= "<div>[설정]</div>";
								}else{
									auth 		= "";
									no_auth_gb 	= "";
								}

								for(var j=0;j<arr_user_gb_cd.length;j++){
									if(arr_user_gb_cd[j].cd == user_gb){
										user_gb_nm = arr_user_gb_nm[j].nm;
									}
								}

								for(var j=0;j<arr_duty_gb_cd.length;j++){
									if(arr_duty_gb_cd[j].cd == duty_cd){
										duty_nm = arr_duty_gb_nm[j].nm;
									}
								}

								for(var j=0;j<arr_dept_gb_cd.length;j++){
									if(arr_dept_gb_cd[j].cd == dept_cd){
										dept_nm = arr_dept_gb_nm[j].nm;
									}
								}

								for(var j=0;j<arr_user_appr_gb_cd.length;j++){
									if(user_appr_gb == arr_user_appr_gb_cd[j].cd){
										user_appr_gb = arr_user_appr_gb_nm[j].nm;
									}
								}

								if(del_yn == "Y"){
									del_yn = '<%=CommonUtil.getMessage("USER_STATUS.N")%>';
								}else if(del_yn == "N"){
									del_yn = '<%=CommonUtil.getMessage("USER_STATUS.Y")%>';
								}
								
								if(account_lock == ""){
									account_lock = "N";
								}
								
								if(account_lock == "Y"){
									account_lock_chk = '<%=CommonUtil.getMessage("ACCOUNT_STATUS.Y")%>';
								}else if(account_lock == "N"){
									account_lock_chk = '<%=CommonUtil.getMessage("ACCOUNT_STATUS.N")%>';
								}else if(account_lock == "M"){
									account_lock_chk = '<%=CommonUtil.getMessage("ACCOUNT_STATUS.M")%>';
								}else if(account_lock == "U"){
									account_lock_chk = '<%=CommonUtil.getMessage("ACCOUNT_STATUS.U")%>';
								}
									
								rowsObj.push({
									'grid_idx':i+1+startRowNum
									,'USER_ID': user_id
									,'USER_NM': user_nm
									,'USER_EMAIL': user_email
									,'USER_GB_NM': user_gb_nm
									,'USER_HP': user_hp
									,'USER_TEL': user_tel
									,'DEPT_NM': dept_nm
									,'DUTY_NM': duty_nm
									,'USER_APPR_GB': user_appr_gb
									,'DEL_YN': del_yn
									,'AUTH': auth
									,'NO_AUTH': no_auth
									,'APPROVAL': approval
									,'ACCOUNT_LOCK': account_lock
									,'ACCOUNT_LOCK_CHK': account_lock_chk
									,'INS_DATE': ins_date
									,'USER_CD': user_cd
									,'SELECT_DCC': select_dcc
									,'SELECT_TABLE_NAME': select_table_name
									,'NO_AUTH_GB' : no_auth_gb
									,'USER_IP': user_ip
									,'MAX_LOGIN_DATE' : max_login_date
								});

							});
						}

						gridObj.rows = rowsObj;
						setGridRows(gridObj);
						$('body').resizeAllColumns();
// 						$('#ly_total_cnt').html('[ TOTAL : '+items.attr('cnt')+' ]');
						
						$('#ly_total_cnt').html('[ TOTAL : '+parseInt(gridObj.rows.length)+'/'+items.attr('total')+']');
						if( parseInt(gridObj.rows.length) != items.attr('total') ) {
							listChk = true;
						}else{
							listChk = false;
						}

					});
					try{viewProgBar(false);}catch(e){}
				}
				, null );

		xhr.sendRequest();
	}

	function userInsert(){

		var sHtml="<div id='dl_ins_tmp1' style='overflow:hidden;display:none;padding:0;border-top:1px solid blue;border-bottom:1px solid blue;border-left:1px solid blue;border-right:1px solid blue;'>";
		sHtml+="<form id='form1' name='form1' method='post' onsubmit='return false;'>";
		sHtml+="<input type='hidden' name='flag' id='flag'/>";
		sHtml+="<input type='hidden' name='user_cd' id='user_cd'/>";
		sHtml+="<input type='hidden' name='retire_yn' id='retire_yn' value='N'/>";
		sHtml+="<input type='hidden' name='account_lock' id='account_lock' value='N'/>";
		sHtml+="<table style='width:100%;height:630px;border:none;'>";
		sHtml+="<tr><td style='vertical-align:top;height:90%;width:510px;' >";

		sHtml+="<table style='width:100%;height:75%;border:none;'>";
		sHtml+="<tr><td id='ly_g_ins_tmp1' style='vertical-align:top;'>";
		sHtml+="<div id='g_ins_tmp1' class='ui-widget-header ui-corner-all'></div>";
		sHtml+="</td></tr>";
		sHtml+="<tr style='height:10px;'><td style='vertical-align:top;'><h5 class='ui-widget-header ui-corner-all' >";
		sHtml+="<div align='right' class='btn_area_s'>";
		sHtml+="<span id='btn_ins'>저장</span>";
		sHtml+="</div>";
		sHtml+="</h5></td></tr></table>";

		sHtml+="</td></tr></table>";

		sHtml+="</form>";

		$('#dl_udt_tmp2').remove();
		$('#dl_ins_tmp1').remove();
		$('body').append(sHtml);

		var headerObj = new Array();
		var hTmp1 = "";
		var hTmp2 = "";
		hTmp1 += "<div class='cellTitle_1'>아이디</div>";
		hTmp2 += "<div class='cellContent_1'><input type='text' name='user_id' id='user_id' style='width:95%;border:0px none;'/></div>";
		hTmp1 += "<div class='cellTitle_1'>이름</div>";
		hTmp2 += "<div class='cellContent_1'><input type='text' name='user_nm' id='user_nm' style='width:95%;border:0px none;'/></div>";
		hTmp1 += "<div class='cellTitle_1'>비밀번호</div>";
		hTmp2 += "<div class='cellContent_1'><input type='password' name='user_pw' id='user_pw' style='width:95%;border:0px none;'/></div>";
		hTmp1 += "<div class='cellTitle_1'>구분</div>";
		hTmp2 += "<div class='cellContent_1'>";
		hTmp2 += "<select name='user_gb' id='user_gb' style='width:200px'>";
		for(var j=0;j<arr_user_gb_cd.length;j++){
			hTmp2 += "<option value='"+arr_user_gb_cd[j].cd+"'>"+arr_user_gb_nm[j].nm+"</option>";
		}
		hTmp2 += "</select>";
		hTmp2 += "</div>";
		hTmp1 += "<div class='cellTitle_1'>이메일</div>";
		hTmp2 += "<div class='cellContent_1'><input type='text' name='user_email' id='user_email' style='width:95%;border:0px none;'/></div>";
		hTmp1 += "<div class='cellTitle_1'>휴대폰번호</div>";
		hTmp2 += "<div class='cellContent_1'><input type='text' name='user_hp' id='user_hp' style='width:95%;border:0px none;'/></div>";
		hTmp1 += "<div class='cellTitle_1'>내선번호</div>";
		hTmp2 += "<div class='cellContent_1'><input type='text' name='user_tel' id='user_tel' style='width:95%;border:0px none;'/></div>";
		hTmp1 += "<div class='cellTitle_1'>부서</div>";
		hTmp2 += "<div class='cellContent_1'>";
		hTmp2 += "<select name='dept_cd' id='dept_cd' style='width:200px'>";
		hTmp2 += "<option value=''>--선택--</option>";
		for(var j=0;j<arr_dept_gb_cd.length;j++){
			hTmp2 += "<option value='"+arr_dept_gb_cd[j].cd+"'>"+arr_dept_gb_nm[j].nm+"</option>";
		}
		hTmp2 += "</select>";
		hTmp2 += "</div>";
		hTmp1 += "<div class='cellTitle_1'>직책</div>";
		hTmp2 += "<div class='cellContent_1'>";
		hTmp2 += "<select name='duty_cd' id='duty_cd' style='width:200px'>";
		hTmp2 += "<option value=''>--선택--</option>";
		for(var j=0;j<arr_duty_gb_cd.length;j++){
			hTmp2 += "<option value='"+arr_duty_gb_cd[j].cd+"'>"+arr_duty_gb_nm[j].nm+"</option>";
		}
		hTmp2 += "</select>";
		hTmp2 += "</div>";

		hTmp1 += "<div class='cellTitle_1'>결재구분</div>";
		hTmp2 += "<div class='cellContent_1'>";
		hTmp2 += "<select name='user_appr_gb' id='user_appr_gb' style='width:200px'>";
		hTmp2 += "<option value=''>--선택--</option>";
		for(var j=0;j<arr_user_appr_gb_cd.length;j++) {
			hTmp2 += "<option value='"+arr_user_appr_gb_cd[j].cd+"'>"+arr_user_appr_gb_nm[j].nm+"</option>";
		}
		hTmp2 += "</select>";
		hTmp2 += "</div>";

		hTmp1 += "<div class='cellTitle_1'>사용여부</div>";
		hTmp2 += "<div class='cellContent_1'>";
		hTmp2 += "<select name='del_yn' id='del_yn' style='width:200px'>";
		hTmp2 += "<option value='N'>사용</option>";
		hTmp2 += "<option value='Y'>미사용</option>";
		hTmp2 += "</select>";
		hTmp2 += "</div>";
// 		hTmp1 += "<div class='cellTitle_1'>잠금관리</div>";
// 		hTmp2 += "<div class='cellContent_1'>";
// 		hTmp2 += "<select name='account_lock' id='account_lock' style='width:200px'>";
// 		hTmp2 += "<option value='N'>사용가능</option>";
// 		hTmp2 += "<option value='Y'>계정잠금</option>";
// 		hTmp2 += "</select>";
// 		hTmp2 += "</div>";

		hTmp1 += "<div class='cellTitle_1'>아이피</div>";
		hTmp2 += "<div class='cellContent_1'><input type='text' name='user_ip' id='user_ip' style='width:95%;border:0px none;'/></div>";

		hTmp1 += "<div class='cellTitle_1'>기본 C-M</div>";
		hTmp2 += "<div class='cellContent_1'>";
		hTmp2 += "<select name='select_data_center_code' id='select_data_center_code' style='width:200px;'>";
		hTmp2 += "<option value=''>--선택--</option>";
		hTmp2 += "<c:forEach var='cm' items='${cm}' varStatus='status'>";
		hTmp2 += "<option value='${cm.scode_cd},${cm.scode_eng_nm}'>${cm.scode_nm}</option>";
		hTmp2 += "</c:forEach>";
		hTmp2 += "</select>";
		hTmp2 += "</div>";
		
		hTmp1 += "<div class='cellTitle_1'>폴더</div>";
		hTmp2 += "<div class='cellContent_1'>";
		hTmp2 += "<input type='text' name='table_nm' id='table_nm' style='width:200px;' onClick='fn_table_search();' readonly/>&nbsp;";
		hTmp2 += "<img id='btn_clear1' src='/images/sta2.png' style='width:16px;height:16px;vertical-align:middle;cursor:pointer;' onClick='fn_table_clear();'/>";
		hTmp2 += "<input type='hidden' name='table_of_def' id='table_of_def' />";
		hTmp2 += "</div>";

		headerObj.push({name:hTmp1,id_s:'c_1',id_e:'c_1'});
		headerObj.push({name:hTmp2,id_s:'c_2',id_e:'c_2'});

		var gridObj_s = {
			id : "g_ins_tmp1"
			,colModel:[
				{formatter:gridCellNoneFormatter,field:'c_1',id:'c_1',name:'구 분',width:80,headerCssClass:'cellCenter',cssClass:'cellCenter'}
				,{formatter:gridCellNoneFormatter,field:'c_2',id:'c_2',name:'내 용',width:380,headerCssClass:'cellCenter',cssClass:'cellLeft'}

				,{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'grid_idx',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
			]
			,rows:[]
			,headerRowHeight:500
			,colspan:headerObj
			,vscroll:<%=S_GRID_VSCROLL%>
		};

		viewGrid_1(gridObj_s,'ly_'+gridObj_s.id);
		$("#select_data_center_code").change(function(){
			fn_table_clear();
		});

		dlPop01('dl_ins_tmp1', "사용자등록", 465, 485, false);
		var delUser = checkDelUserList();

		$("#btn_ins").button().unbind("click").click(function(){
			var insUser = $('#form1 #user_id').val();

			if(isNullInput($('#form1 #user_id'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[아이디]","") %>')) return false;
			if(isNullInput($('#form1 #user_nm'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[이름]","") %>')) return false;
			if(isNullInput($('#form1 #user_pw'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[비밀번호]","") %>')) return false;

			if($("#form1").find("select[name='user_gb']").val() == ""){
				alert('<%=CommonUtil.getMessageSplit("ERROR.PARAM.02","[구분]","") %>');
				return false;
			}
			if($("#form1").find("select[name='dept_cd']").val() == ""){
				alert('<%=CommonUtil.getMessageSplit("ERROR.PARAM.02","[부서]","") %>');
				return false;
			}
			if($("#form1").find("select[name='duty_cd']").val() == ""){
				alert('<%=CommonUtil.getMessageSplit("ERROR.PARAM.02","[직책]","") %>');
				return false;
			}

			if(confirm("해당 내용을 등록 하시겠습니까?")){
				var f = document.form1;
				
				try{viewProgBar(true);}catch(e){}
				
				if(delUser.includes(insUser)){ 
			    	if(confirm("삭제 처리된 아이디가 존재합니다. 그래도 추가 하시겠습니까? \n(*추가할 경우 삭제 처리된 아이디로 설정된 담당자 정보도 삭제됩니다.)")){
			    		f.flag.value = "del_user";
			    	}
			    }else{
				    	f.flag.value = "ins";	
			    }
				
				f.target = "if1";
				f.user_pw.value = f.user_pw.value;

				f.action = "<%=sContextPath %>/tWorks.ez?c=ez002_p";
				f.submit();

				try{viewProgBar(false);}catch(e){}

				dlClose('dl_ins_tmp1');
			}
		});
	}
	function goPrc(flag){
		var f = document.allUdtFrm;

		if(flag == 'pw_all_clear'){
			if(!confirm("비밀번호를 일괄 초기화 하시겠습니까?")){
				return;
			}
		}

		if(flag == 'pw_all_change'){
			if(!confirm("비밀번호를 일괄 변경 하시겠습니까?")){
				return;
			}
		}

		try{viewProgBar(true);}catch(e){}

		f.flag2.value = flag;
		f.target = "if1";
		f.action = "<%=sContextPath %>/tWorks.ez?c=ez002_p";
		f.submit();

		try{viewProgBar(false);}catch(e){}

	}

	function userUpdate(user_cd){

		try{viewProgBar(true);}catch(e){}

		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=userList&user_cd='+user_cd;

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

						var user_id 				= "";
						var user_nm 				= "";
						var user_email 				= "";
						var user_gb 				= "";
						var user_hp 				= "";
						var user_tel 				= "";
						var dept_cd 				= "";
						var duty_cd 				= "";
						var del_yn 					= "";
						var no_auth 				= "";
						var account_lock 			= "";
						var user_pw 				= "";
						var select_table_name		= "";
						var select_dcc				= "";
						var no_auth					= "";
						var absence_user_nm			= "";
						var absence_user_cd			= "";
						var absence_start_date		= "";
						var absence_end_date		= "";
						var absence_reason			= "";

						var items = $(this).find('items');
						var rowsObj = new Array();

						if(items.attr('cnt')=='0'){
						}else{
							items.find('item').each(function(i){

								user_id 					= $(this).find("USER_ID").text();
								user_pw 					= $(this).find("USER_PW").text();
								user_nm 					= $(this).find("USER_NM").text();
								user_email 					= $(this).find("USER_EMAIL").text();
								user_gb 					= $(this).find("USER_GB").text();
								user_hp 					= $(this).find("USER_HP").text();
								user_tel 					= $(this).find("USER_TEL").text();
								dept_cd 					= $(this).find("DEPT_CD").text();
								duty_cd 					= $(this).find("DUTY_CD").text();
								user_appr_gb 				= $(this).find("USER_APPR_GB").text();
								del_yn 						= $(this).find("DEL_YN").text();
								no_auth 					= $(this).find("NO_AUTH").text();
								account_lock 				= $(this).find("ACCOUNT_LOCK").text();
								ins_date 					= $(this).find("INS_DATE").text();
								select_table_name 			= $(this).find("SELECT_TABLE_NAME").text();
								select_dcc 					= $(this).find("SELECT_DCC").text();
								user_ip 					= $(this).find("USER_IP").text();
								absence_user_nm 			= $(this).find("ABSENCE_USER_NM").text();
								absence_user_cd 			= $(this).find("ABSENCE_USER_CD").text();
								absence_start_date 			= $(this).find("ABSENCE_START_DATE").text();
								absence_end_date 			= $(this).find("ABSENCE_END_DATE").text();
								absence_reason 				= $(this).find("ABSENCE_REASON").text();

								if(account_lock == "") account_lock = "N";
							});
						}

						var sHtml="<div id='dl_udt_tmp2' style='overflow:hidden;display:none;padding:0;border-top:1px solid blue;border-bottom:1px solid blue;border-left:1px solid blue;border-right:1px solid blue;'>";
						sHtml+="<form id='form2' name='form2' method='post' onsubmit='return false;'>";
						sHtml+="<input type='hidden' name='flag' id='flag'/>";
						sHtml+="<input type='hidden' name='user_cd' id='user_cd' value='"+user_cd+"'/>";
						sHtml+="<input type='hidden' name='user_id' id='user_id' value='"+user_id+"'/>";
						sHtml+="<input type='hidden' name='user_pw' id='user_pw' value='"+user_pw+"'/>";
						sHtml+="<input type='hidden' name='account_lock'       id='account_lock'       value='"+account_lock+"'/>";
						sHtml+="<input type='hidden' name='retire_yn' id='retire_yn' value='N'/>";
						sHtml+="<table style='width:100%;height:750px;border:none;'>";
						sHtml+="<tr><td style='vertical-align:top;height:90%;width:490px;' >";

						sHtml+="<table style='width:100%;height:75%;border:none;'>";
						sHtml+="<tr><td id='ly_g_udt_tmp2' style='vertical-align:top;'>";
						sHtml+="<div id='g_udt_tmp2' class='ui-widget-header ui-corner-all'></div>";
						sHtml+="</td></tr>";
						sHtml+="<tr style='height:10px;'><td style='vertical-align:top;'><h5 class='ui-widget-header ui-corner-all' >";
						sHtml+="<div align='right' class='btn_area_s'>";
						sHtml+="<span id='btn_udt'>저장</span>";
						sHtml+="</div>";
						sHtml+="</h5></td></tr></table>";

						sHtml+="</td></tr></table>";

						sHtml+="</form>";

						$('#dl_ins_tmp1').remove();
						$('#dl_udt_tmp2').remove();
						$('body').append(sHtml);

						var headerObj = new Array();
						var hTmp1 = "";
						var hTmp2 = "";
						hTmp1 += "<div class='cellTitle_1'>아이디</div>";
						hTmp2 += "<div class='cellContent_1'>"+user_id+"</div>";

						hTmp1 += "<div class='cellTitle_1'>이름</div>";
						hTmp2 += "<div class='cellContent_1'><input type='text' name='user_nm' id='user_nm' style='width:95%;border:0px none;' value='"+user_nm+"'/></div>";

						hTmp1 += "<div class='cellTitle_1'>비밀번호</div>";
						hTmp2 += "<div class='cellContent_1'><input type='password' name='v_user_pw' id='v_user_pw' style='width:95%;border:0px none;'/></div>";

						hTmp1 += "<div class='cellTitle_1'>구분</div>";
						hTmp2 += "<div class='cellContent_1'>";
						hTmp2 += "<select name='user_gb' id='user_gb' style='width:200px'>";
						for(var j=0;j<arr_user_gb_cd.length;j++){
							if(user_gb == arr_user_gb_cd[j].cd){
								hTmp2 += "<option value='"+arr_user_gb_cd[j].cd+"' selected>"+arr_user_gb_nm[j].nm+"</option>";
							}else{
								hTmp2 += "<option value='"+arr_user_gb_cd[j].cd+"'>"+arr_user_gb_nm[j].nm+"</option>";
							}
						}
						hTmp2 += "</select>";
						hTmp2 += "</div>";

						hTmp1 += "<div class='cellTitle_1'>이메일</div>";
						hTmp2 += "<div class='cellContent_1'><input type='text' name='user_email' id='user_email' style='width:95%;border:0px none;' value='"+user_email+"'/></div>";

						hTmp1 += "<div class='cellTitle_1'>휴대폰번호</div>";
						hTmp2 += "<div class='cellContent_1'><input type='text' name='user_hp' id='user_hp' style='width:95%;border:0px none;' value='"+user_hp+"'/></div>";

						hTmp1 += "<div class='cellTitle_1'>내선번호</div>";
						hTmp2 += "<div class='cellContent_1'><input type='text' name='user_tel' id='user_tel' style='width:95%;border:0px none;' value='"+user_tel+"'/></div>";

						hTmp1 += "<div class='cellTitle_1'>부서</div>";
						hTmp2 += "<div class='cellContent_1'>";
						hTmp2 += "<select name='dept_cd' id='dept_cd' style='width:200px'>";
						hTmp2 += "<option value=''>--선택--</option>";
						for(var j=0;j<arr_dept_gb_cd.length;j++){
							if(dept_cd == arr_dept_gb_cd[j].cd){
								hTmp2 += "<option value='"+arr_dept_gb_cd[j].cd+"' selected>"+arr_dept_gb_nm[j].nm+"</option>";
							}else{
								hTmp2 += "<option value='"+arr_dept_gb_cd[j].cd+"'>"+arr_dept_gb_nm[j].nm+"</option>";
							}
						}
						hTmp2 += "</select>";
						hTmp2 += "</div>";

						hTmp1 += "<div class='cellTitle_1'>직책</div>";
						hTmp2 += "<div class='cellContent_1'>";
						hTmp2 += "<select name='duty_cd' id='duty_cd' style='width:200px'>";
						hTmp2 += "<option value=''>--선택--</option>";
						for(var j=0;j<arr_duty_gb_cd.length;j++){
							if(duty_cd == arr_duty_gb_cd[j].cd){
								hTmp2 += "<option value='"+arr_duty_gb_cd[j].cd+"' selected>"+arr_duty_gb_nm[j].nm+"</option>";
							}else{
								hTmp2 += "<option value='"+arr_duty_gb_cd[j].cd+"'>"+arr_duty_gb_nm[j].nm+"</option>";
							}
						}
						hTmp2 += "</select>";
						hTmp2 += "</div>";

						hTmp1 += "<div class='cellTitle_1'>결재구분</div>";
						hTmp2 += "<div class='cellContent_1'>";
						hTmp2 += "<select name='user_appr_gb' id='user_appr_gb' style='width:200px'>";
						hTmp2 += "<option value=''>--선택--</option>";
						for(var j=0;j<arr_user_appr_gb_cd.length;j++) {
							if (user_appr_gb == arr_user_appr_gb_cd[j].cd)
								hTmp2 += "<option value='"+arr_user_appr_gb_cd[j].cd+"' selected>"+arr_user_appr_gb_nm[j].nm+"</option>";
							else
								hTmp2 += "<option value='"+arr_user_appr_gb_cd[j].cd+"'>"+arr_user_appr_gb_nm[j].nm+"</option>";
						}
						hTmp2 += "</select>";
						hTmp2 += "</div>";

						hTmp1 += "<div class='cellTitle_1'>사용여부</div>";
						hTmp2 += "<div class='cellContent_1'>";
						hTmp2 += "<select name='del_yn' id='del_yn' style='width:200px'>";
						hTmp2 += "<option value=''>--선택--</option>";
						hTmp2 += "<option value='N'>사용</option>";
						hTmp2 += "<option value='Y'>미사용</option>";
						hTmp2 += "</select>";
						hTmp2 += "</div>";

// 						hTmp1 += "<div class='cellTitle_1'>잠금관리</div>";
// 						hTmp2 += "<div class='cellContent_1'>";
// 						hTmp2 += "<select name='account_lock' id='account_lock' style='width:200px'>";
// 						hTmp2 += "<option value=''>--선택--</option>";
// 						hTmp2 += "<option value='N'>사용가능</option>";
// 						hTmp2 += "<option value='Y'>계정잠금</option>";
// 						hTmp2 += "</select>";
// 						hTmp2 += "</div>";

						hTmp1 += "<div class='cellTitle_1'>아이피</div>";
						hTmp2 += "<div class='cellContent_1'><input type='text' name='user_ip' id='user_ip' style='width:95%;border:0px none;' value='"+user_ip+"'/></div>";

						hTmp1 += "<div class='cellTitle_1'>기본 C-M</div>";
						hTmp2 += "<div class='cellContent_1'>";
						hTmp2 += "<select name='select_data_center_code' id='select_data_center_code' style='width:200px;'>";
						hTmp2 += "<option value=''>--선택--</option>";
						hTmp2 += "<c:forEach var='cm' items='${cm}' varStatus='status'>";
						hTmp2 += "<option value='${cm.scode_cd},${cm.scode_eng_nm}'>${cm.scode_nm}</option>";
						hTmp2 += "</c:forEach>";
						hTmp2 += "</select>";
						hTmp2 += "</div>";
						
						hTmp1 += "<div class='cellTitle_1'>폴더</div>";
						hTmp2 += "<div class='cellContent_1'>";
						hTmp2 += "<input type='text' name='table_nm' id='table_nm' value='"+select_table_name+"' style='width:200px;' onClick='fn_table_search();' readonly/>&nbsp;";
						hTmp2 += "<img id='btn_clear1' src='/images/sta2.png' style='width:16px;height:16px;vertical-align:middle;cursor:pointer;' onClick='fn_table_clear();'/>";
						hTmp2 += "<input type='hidden' name='table_of_def' id='table_of_def' value='"+select_table_name+"' />";
						hTmp2 += "</div>";
						
						hTmp1 += "<div class='cellTitle_1'>대리결재자</div>";
						hTmp2 += "<div class='cellContent_1'>";
						hTmp2 += "<input type='text' name='absence_user_nm' id='absence_user_nm' style='width:200px' onClick='fn_user_search();' value='"+absence_user_nm+"' readonly >";
						hTmp2 += "<input type='hidden' name='absence_user_cd' id='absence_user_cd' value='"+absence_user_cd+"'>&nbsp;";
						hTmp2 += "<img id='btn_absence_del' src='/images/sta2.png' style='width:16px;height:16px;vertical-align:middle;cursor:pointer;border:none;'/>";
						hTmp2 += "</div>";
						
						hTmp1 += "<div class='cellTitle_1'>대리결재사유</div>";
						hTmp2 += "<div class='cellContent_1'>";
						hTmp2 += "<input type='text' name='absence_reason' id='absence_reason' style='width:200px' value='"+absence_reason+"'>";
						hTmp2 += "</div>";
						
						hTmp1 += "<div class='cellTitle_1'>대리결재기간</div>";
						hTmp2 += "<div class='cellContent_1'>";
						hTmp2 += "<input type='text' name='absence_start_date' id='absence_start_date' style='width:87px' value='"+absence_start_date+"' readonly>&nbsp;&nbsp;&nbsp;~&nbsp;&nbsp;";
						hTmp2 += "<input type='text' name='absence_end_date' id='absence_end_date' style='width:87px' value='"+absence_end_date+"' readonly>";
						hTmp2 += "</div>";

						headerObj.push({name:hTmp1,id_s:'c_1',id_e:'c_1'});
						headerObj.push({name:hTmp2,id_s:'c_2',id_e:'c_2'});
						var gridObj_s = {
							id : "g_udt_tmp2"
							,colModel:[
								{formatter:gridCellNoneFormatter,field:'c_1',id:'c_1',name:'구 분',width:80,headerCssClass:'cellCenter',cssClass:'cellCenter'}
								,{formatter:gridCellNoneFormatter,field:'c_2',id:'c_2',name:'내 용',width:380,headerCssClass:'cellCenter',cssClass:'cellLeft'}

								,{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'grid_idx',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
							]
							,rows:[]
							,headerRowHeight:500
							,colspan:headerObj
							,vscroll:false
						};

						viewGrid_1(gridObj_s,'ly_'+gridObj_s.id);
						$("#select_data_center_code").change(function(){
							fn_table_clear();
						});

						$("#user_pw").val(user_pw);
						$("#form2 #del_yn").val(del_yn);
						$("#form2 #user_appr_gb").val(user_appr_gb);
						$("#account_lock").val(account_lock);
						$("#select_data_center_code").val(select_dcc);
						
						$("#btn_absence_del").button().unbind("click").click(function(){
							
							var frm = document.form2;
							frm.absence_user_nm.value = "";
							frm.absence_user_cd.value = "";
							$("#form2").find("input[name='absence_start_date']").val("");
							$("#form2").find("input[name='absence_end_date']").val("");			
							$("#form2").find("input[name='absence_reason']").val("");
						});
						
						$("#absence_start_date").addClass("ime_readonly").unbind('click').click(function(){
							dpCalMinMax(this.id,'yymmdd','0');
						});
						
						$("#absence_end_date").addClass("ime_readonly").unbind('click').click(function(){
							dpCalMinMax(this.id,'yymmdd','0');
						});

						dlPop01('dl_udt_tmp2', "사용자수정", 465, 570, false);

						$("#btn_udt").button().unbind("click").click(function(){

							if(isNullInput($('#form2 #user_nm'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[이름]","") %>')) return false;

							if($("#form2").find("select[name='user_gb']").val() == ""){
								alert('<%=CommonUtil.getMessageSplit("ERROR.PARAM.02","[구분]","") %>');
								return false;
							}
							if($("#form2").find("select[name='dept_cd']").val() == ""){
								alert('<%=CommonUtil.getMessageSplit("ERROR.PARAM.02","[부서]","") %>');
								return false;
							}
							if($("#form2").find("select[name='duty_cd']").val() == ""){
								alert('<%=CommonUtil.getMessageSplit("ERROR.PARAM.02","[직책]","") %>');
								return false;
							}
							
							if($("#form2").find("input[name='absence_user_cd']").val() != "" && $("#form2").find("input[name='absence_user_cd']").val() != "0" ){
								if($("#form2").find("input[name='absence_start_date']").val() == "" || $("#form2").find("input[name='absence_end_date']").val() == ""){
									alert("대리결재 기간을 입력해 주세요.");
									return;
								} else {
									
									// 날짜 기간 체크
									if ( $("#form2").find("input[name='absence_start_date']").val() > $("#form2").find("input[name='absence_end_date']").val() ) {
										alert("대리결재 기간의 FROM ~ TO를 확인해 주세요.");
										return;
									}
								}
							}
							

							if(confirm("해당 내용을 변경 하시겠습니까?")){
								var f = document.form2;

								try{viewProgBar(true);}catch(e){}

								if(f.v_user_pw.value != ""){
									f.v_user_pw.value = f.v_user_pw.value;
								} else {
									f.v_user_pw.value = '';
								}

								f.flag.value = "udt";
								f.target = "if1";
								f.action = "<%=sContextPath %>/tWorks.ez?c=ez002_p";
								f.submit();

								try{viewProgBar(false);}catch(e){}

								dlClose('dl_udt_tmp2');
							}
						});


					});
					try{viewProgBar(false);}catch(e){}
				}
				, null );

		xhr.sendRequest();
	}

	function popupApprovalLine(user_cd){
		var frm = document.form3;

		frm.user_cd.value = user_cd;
		openPopupCenter("about:blank","popupApprovalLine2",700,380);

		frm.target = "popupApprovalLine2";
		frm.action = "<%=sContextPath%>/tWorks.ez?c=ez002_approval_line";
		frm.submit();
	}

	function fn_table_search() {

		var data_center = $("select[name='select_data_center_code'] option:selected").val();

		if(data_center == ""){
			alert("C-M 을 선택해 주세요.");
			return;
		}else{
			poeTabForm();
		}
	}
	
	function fn_user_search() {
		goUserSearch(0);
	}
	
	//대결자 검색 팝업형태로 변경
	function goUserSeqSelect(cd, nm, btn){

		var frm = document.form2;

		frm.absence_user_nm.value = nm;
		frm.absence_user_cd.value = cd;

		dlClose('dl_tmp3');
	}

	// works_common.js에서 사용
	function selectTable(eng_nm, desc, user_daily) {

		$("#table_nm").val(eng_nm);
		$("#table_of_def").val(eng_nm);

		dlClose("dl_tmp1");
	}

	function fn_table_clear() {

		$("#table_nm").val("");
		$("#table_of_def").val("");
	}

	//폴더권한(이기준)
	function popupFolderAuth(user_cd,user_id,user_nm){
		
		/* <c:forEach var="cm" items="${SCODE_GRP_LIST}" varStatus="status">
			<option value='${cm.scode_cd}'>${cm.scode_nm}</option>"
		</c:forEach>; */
		
		/* for (var i=0; i < "${SCODE_GRP_LIST}".size(); i ++){
			CommonBean commonBean = (CommonBean) cm.get(i);
			test = CommonUtil.isNull(commonBean.getScode_nm());
			console.log('test : ' + test);
		} */
		
/* 		console.log("${SCODE_GRP_LIST}");
		
		testFolderPop("폴더", 1, "${SCODE_GRP_LIST}"); */
		
		 searchPoeTabForm();

		/*var frm = document.frm3;

		frm.user_cd.value = user_cd;
		frm.user_id.value = user_id;
		frm.user_nm.value = user_nm;
		frm.authPopup.value = "Y";

		openPopupCenter1("about:blank","popupFolderAuth",600,600);

		frm.target = "popupFolderAuth";
		frm.action = "<%=sContextPath%>/tWorks.ez?c=ez002_authFolder";
		frm.submit();*/
	}

	//일괄폴더권한
	function allpopupFolderAuth(user_cd,user_id,user_nm,isMoreThanTwo){

		<%-- var frm = document.frm3;

		frm.arr_user_cd.value = user_cd;
		frm.arr_user_id.value = user_id;
		frm.user_cd.value = user_cd;
		frm.user_id.value = user_id;
		frm.authPopup.value = "Y";

		openPopupCenter1("about:blank","popupFolderAuth",600,600);

		frm.target = "popupFolderAuth";
		frm.action = "<%=sContextPath%>/tWorks.ez?c=ez002_allAuthFolder";
		frm.submit(); --%>
		
		popupAppGrpCodeForm2(user_cd, isMoreThanTwo, '');
	}

	//폴더권한복사(김은희)
	function popFolAppGrpCopy(){
		var url = '<%=sContextPath %>/tWorks.ez?pop_if=P01&c=ez002_folappgrp_copy';

		if(dlMap.containsKey('dl_p01')) dlClose('dl_p01');
		$('#if_p01').width(900).height(400);
		dlPopIframe01('dl_p01','[폴더]권한복사',$('#if_p01').width(),$('#if_p01').height(),true,true,true);

		dlFrontView('dl_p01');
		setTimeout(function(){
			var f = document.f_tmp;

			f.target = "if_p01";
			f.action = url;
			f.submit();
		}, 300);
	}

	//App 팝업 폼
	function userFolderForm(user_cd,user_id,user_nm){

		var sHtml1="<div id='dl_tmp1' style='overflow:hidden;display:none;padding:0;border-top:1px solid blue;border-bottom:1px solid blue;border-left:1px solid blue;border-right:1px solid blue;'>";
		sHtml1+="<form id='form1' name='form1' method='post' onsubmit='return false;'>";
		sHtml1+="<table style='width:100%;height:480px;border:none;'><tr><td style='vertical-align:top;height:100%;width:900px;text-align:right;'>";
		sHtml1+="<input type='hidden' name='user_cd' value='"+user_cd+"'/>";
		sHtml1+="<input type='hidden' name='user_id' value='"+user_id+"'/>";
		sHtml1+="<input type='hidden' name='user_nm' value='"+user_nm+"'/>";
		sHtml1+="<table style='width:100%;height:100%;border:none;'>";
		sHtml1+="<tr><td id='ly_g_tmp1' style='vertical-align:top;' >";
		sHtml1+="<div id='g_tmp1' class='ui-widget-header ui-corner-all'></div>";
		sHtml1+="</td></tr>";
		sHtml1+="<tr style='height:10px;'><td style='vertical-align:top;'><h5 class='ui-widget-header ui-corner-all' >";
		sHtml1+="<div align='right' class='btn_area_s'>";
		sHtml1+="<div id='ly_total_cnt_10' style='padding-top:5px;float:left;'></div>";
		sHtml1+="<span id='btn_save'>저장</span>";
		sHtml1+="</div>";
		sHtml1+="</h5></td></tr></table>";
		sHtml1+="</td></tr></table>";

		sHtml1+="</form>";

		$('#dl_tmp1').remove();
		$('body').append(sHtml1);

		dlPop01('dl_tmp1', "<th width='100px'>폴더<font color='red'>(권한 등록할 Folder 선택)</font></th>", 300, 500, false);

		var gridObj = {
			id : "g_tmp1"
			,colModel:[
				{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'번호',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
				,{formatter:gridCellNoneFormatter,field:'FOLDER_AUTH',id:'FOLDER_AUTH',name:'폴더',width:250,headerCssClass:'cellCenter',cssClass:'cellLeft'}

			]
			,rows:[]
			,vscroll: true
		};

		viewGridChk_1(gridObj,'ly_'+gridObj.id);
		popupFolderAuthList();

		$("#btn_save").button().unbind("click").click(function(){
			var frm = document.folderFrm;
			var folder_auth = "";
			var aSelRow = new Array;

			aSelRow = $('#'+gridObj.id).data('grid').getSelectedRows();
			if(aSelRow.length>0){
				for(var i=0;i<aSelRow.length;i++){
					if(folder_auth==""){
						folder_auth = getCellValue(gridObj,aSelRow[i],'FOLDER_AUTH');
					}else{
						folder_auth += ","+getCellValue(gridObj,aSelRow[i],'FOLDER_AUTH');
					}
				}
			}

			clearGridSelected(gridObj);

			if( !confirm('선택한 Folder의 권한을 등록하시겠습니까?') ) return;
			frm.folder_auth.value = folder_auth;
			frm.user_cd.value = user_cd;
			frm.target = "if1";
			frm.action = "<%=sContextPath%>/tWorks.ez?c=ez002_p";
			frm.submit();

			dlClose('dl_tmp1');
		});

	}

	//App 팝업 내역
	function popupFolderAuthList(){

		try{viewProgBar(true);}catch(e){}
		$('#ly_total_cnt_10').html('');

		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=sched_tableList2&itemGubun=2';

		var xhr = new XHRHandler(url, form1
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
							alert("검색된 내용이 없습니다.");
							return;
						}else{
							items.find('item').each(function(i){
								var sched_table = $(this).find("sched_table").text();
								var folder_auth = $(this).find("folder_auth").text();

								if(folder_auth != ''){
									setGridSelectedRow($("#g_tmp1").data('gridObj'),i);
								}
								rowsObj.push({
									'grid_idx':i+1
									,'FOLDER_AUTH': sched_table
								});
							});
						}

						var obj = $("#g_tmp1").data('gridObj');
						obj.rows = rowsObj;
						setGridRows(obj);

						clearGridSelected(obj);

						$('#ly_total_cnt_10').html('[ TOTAL : '+items.attr('cnt')+' ]');

					});
					try{viewProgBar(false);}catch(e){}
				}
				, null );

		xhr.sendRequest();
	}

	//일괄 패스워드 초기화(김은희)
	function fn_pw_all_init(user_cd, user_id) {

		var frm = document.frm2;

		if( !confirm('일괄 패스워드 초기화를 진행하시겠습니까?') ) return;

		frm.flag.value		= "pw_all_init";
		frm.user_cd.value 	= user_cd;
		frm.user_id.value 	= user_id;

		frm.target = "if1";
		frm.action = "<%=sContextPath%>/tWorks.ez?c=ez002_pw_init";
		frm.submit();

	}
	//일괄 잠금 해제(김은희)
	function fn_account_lock_init(user_cd, user_id,account_lock) {

		var frm = document.frm2;

		if( !confirm('일괄 잠금 해제를 진행하시겠습니까?') ) return;

		frm.flag.value		= "account_lock_init";
		frm.user_cd.value 	= user_cd;
		frm.user_id.value 	= user_id;
		frm.account_lock.value 	= account_lock;

		frm.target = "if1";
		frm.action = "<%=sContextPath%>/tWorks.ez?c=ez002_account_lock_init";
		frm.submit();

	}

	function popupRoleAuth(user_cd, no_auth){

		var sHtml="<div id='dl_tmp_auth' style='overflow:hidden;display:none;padding:0;border-top:1px solid blue;border-bottom:1px solid blue;border-left:1px solid blue;border-right:1px solid blue;'>";
		sHtml+="<form id='authForm' name='authForm' method='post' onsubmit='return false;'>";
		sHtml+="<input type='hidden' name='flag' id='flag' value='udt_auth'/>";
		sHtml+="<input type='hidden' name='user_cd' id='user_cd' value='" + user_cd + "'/>";
		sHtml+="<input type='hidden' name='no_auth' id='no_auth' value='" + no_auth + "'/>";
		sHtml+="</form>";
		sHtml+="<table style='width:100%;height:550px;border:none;'>";
		sHtml+="<tr><td style='vertical-align:top;height:90%;width:510px;' >";

		sHtml+="<table style='width:100%;height:80%;border:none;'>";
		sHtml+="<tr><td id='ly_g_auth_tmp1' style='vertical-align:top;'>";
		sHtml+="<div id='g_auth_tmp1' class='ui-widget-header ui-corner-all'></div>";
		sHtml+="</td></tr>";
		sHtml+="<tr style='height:8px;'><td style='vertical-align:top;'><h5 class='ui-widget-header ui-corner-all' >";
		sHtml+="<div align='right' class='btn_area_s'>";
		sHtml+="<span id='btn_role_ins'>저장</span>";
		sHtml+="</div>";
		sHtml+="</h5></td></tr></table>";
		sHtml+="</td></tr></table>";

		$('#dl_tmp_auth').remove();
		$('body').append(sHtml);

		var gridObj_auth = {
			id : "g_auth_tmp1"
			,colModel:[
				{formatter:gridCellNoneFormatter,field:'CATEGORY',id:'CATEGORY',name:'매뉴명',width:300,headerCssClass:'cellCenter',cssClass:'cellCenter'}

				,{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'grid_idx',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
				,{formatter:gridCellNoneFormatter,field:'CATEGORYNUM',id:'CATEGORYNUM',name:'CATEGORYNUM',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
			]
			,rows:[]
			,vscroll:false
		};


		viewGridChk_1(gridObj_auth,'ly_'+gridObj_auth.id);

		dlPop01('dl_tmp_auth', "메뉴제한권한(접근을 제한하려는 메뉴 선택)", 350, 450, false);
		authList();

		$("#btn_role_ins").button().unbind("click").click(function(){

			if(confirm("해당 내용을 등록 하시겠습니까?")){
				var frm = document.authForm;

				//try{viewProgBar(false);}catch(e){console.error(e);}

				var gridObj	= $('#g_auth_tmp1').data('gridObj');
				var aSelRow = $('#g_auth_tmp1').data('grid').getSelectedRows();
				var no_auth = "";
				if(aSelRow.length>0){
					for(var i=0;i<aSelRow.length;i++){
						var categoryNum = getCellValue(gridObj,aSelRow[i],'CATEGORYNUM');
						if(no_auth != "") {
							no_auth += ",";
						}
						no_auth += categoryNum;
					}
				}
				frm.no_auth.value = no_auth;

				frm.target = "if1";
				frm.action = "<%=sContextPath%>/tWorks.ez?c=ez002_role_p";
				frm.submit();
			}
		});
	}

	function authList(){
		try{viewProgBar(false);}catch(e){console.error(e);}
		$('#ly_total_cnt_auth').html('');

		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=authList';

		var xhr = new XHRHandler(url, authForm
				,function(){
					var xmlDoc = this.req.responseXML;
					if(xmlDoc==null){
						try{viewProgBar(false);}catch(e){console.error(e);}
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
						var categoryIdxSum 		= '';
						var categoryIdxSubSum 	= '';
						if(items.attr('cnt')=='0'){
							alert("검색된 내용이 없습니다.");

						}else{
							items.find('item').each(function(i){
								var category 		= $(this).find("CATEGORY").text();
								var categoryNum 	= $(this).find("CATEGORYNUM").text();
								var categoryIdx 	= $(this).find("CATEGORYIDX").text();
								var categorySubIdx 	= $(this).find("CATEGORYSUBIDX").text();

								if(categoryIdx != '') {
									if(categoryIdxSum != '') {
										categoryIdxSum += ',';
									}
									categoryIdxSum += categoryIdx;
								}

								if(categorySubIdx != '') {
									if(categoryIdxSubSum != '') {
										categoryIdxSubSum += ',';
									}
									categoryIdxSubSum += categorySubIdx;
								}
								rowsObj.push({
									'grid_idx'		: i+1
									,'CATEGORY'		: category
									,'CATEGORYNUM' 	: categoryNum
								});
							});
						}
						var obj = $("#g_auth_tmp1").data('gridObj');
						obj.rows = rowsObj;
						setGridRows(obj);
						clearGridSelected(obj);

						while(true) {
							var len = $("#g_auth_tmp1").data('dataView').getLength();
							var chklen = $('#g_auth_tmp1').find('input[type=checkbox]').length-1;
							if(len == chklen) {
								var arrCategoryIdx = categoryIdxSum.split(",");
								for(var i=0; i<arrCategoryIdx.length; i++) {
									$('#g_auth_tmp1').find('input[type=checkbox]').eq(arrCategoryIdx[i]).parent('div').next().css('background', 'gray');
									$('#g_auth_tmp1').find('input[type=checkbox]').eq(arrCategoryIdx[i]).parent('div').html('');
								}
								var arrCategorySubIdx = categoryIdxSubSum.split(",");
								var rows = [];
								if(arrCategorySubIdx != ''){
									for(var i=0; i<arrCategorySubIdx.length; i++) {
										rows.push(arrCategorySubIdx[i]);
									}
								}
								var grid = $('#g_auth_tmp1').data('grid');
								grid.setSelectedRows(rows);
								break;
							}
						}
					});
					try{viewProgBar(false);}catch(e){console.error(e);}
				}
				, null );

		xhr.sendRequest();
	}
	
	function goExcel() {
		var frm = document.f_s;
		frm.action = "<%=sContextPath %>/tWorks.ez?c=ez002_excel";
		frm.target = "if1";
		frm.submit();
	}
	function goLoginExcel() {
		var frm = document.form6;
		frm.action = "<%=sContextPath %>/tWorks.ez?c=ez002_login_history_excel";
		frm.target = "if1";
		frm.submit();
	}
	function goHistoryExcel() {
		$("#form5").find("input[name='p_search_gubun']").val($("#frm1").find("select[name='search_gubun'] option:selected").val());
		$("#form5").find("input[name='p_search_text']").val($("#frm1").find("input[name='search_text']").val());
		$("#form5").find("input[name='p_del_yn']").val($("#frm1").find("select[name='del_yn'] option:selected").val());
		var frm = document.form5;
		frm.action = "<%=sContextPath %>/tWorks.ez?c=ez002_history_excel";
		frm.target = "if1";
		frm.submit();
	}
	function excel_form_down() {
		var frm = document.form6;
		frm.action = "<%=sContextPath %>/tWorks.ez?c=ez002_excel_form";
		frm.target = "if1";
		frm.submit();
	}
	
	function popupExcelCode() {
// 		var scode_cd    = $("select[name='main_grp_nm'] option:selected").val();
		
		var sHtml1="<div id='dl_tmp2' style='overflow:hidden;display:none;padding:0;border-top:1px solid blue;border-bottom:1px solid blue;border-left:1px solid blue;border-right:1px solid blue;'>";
				
		sHtml1+="<form id='frm8' name='frm8' method='post' onsubmit='return false; enctype='multipart/form-data' >";
		sHtml1+="<input type='hidden' name='c' id='c' />";
		sHtml1+="<input type='hidden' name='file_nm' id='file_nm' />";		
		sHtml1+="<input type='hidden' id='doc_gb' 	name='doc_gb' 		value='05' />";
		sHtml1+="<input type='hidden' id='flag'		name='flag' 		value='' />";	
		sHtml1+="<input type='hidden' id='user_cd'	name='user_cd' />";
		sHtml1+="<input type='hidden' id='days_cal'	name='days_cal' />";
		sHtml1+="<input type='hidden' name='grp_depth'       id='grp_depth'     value=''/>"
// 		sHtml1+="<input type='hidden' name='scode_cd' id='scode_cd' value='"+scode_cd+"' />";
		sHtml1+="<table style='width:99%;height:99%;border:none;'>";
		sHtml1+="<tr style='height:10px;'>";
		sHtml1+="<td style='vertical-align:top;'>";
		sHtml1+="<h4 class='ui-widget-header ui-corner-all'  >";
		sHtml1+="<div id='t_<%=gridId %>' class='title_area'>";
		sHtml1+="<span><%=CommonUtil.isNull(arr_menu_gb[0]) %></span>";
		sHtml1+="</div>";
		sHtml1+="</h4>";
		sHtml1+="</td>";
		sHtml1+="</tr>";
		sHtml1+="<tr>";
		sHtml1+="<td id='ly_<%=gridId %>' style='vertical-align:top;'>";
		sHtml1+="<div id='<%=gridId %>' class='ui-widget-header_kang ui-corner-all'>";
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
		sHtml1+="<label for='excel_load1' style='height:21px;border:1px solid;margin-left:4px;margin-bottom:4px;' onClick='load_excel()'>&nbsp;&nbsp;엑셀로드&nbsp;</label>";
		sHtml1+="<input type='hidden' name='excel_load1' id='excel_load1'>";
		sHtml1+="<label for='excel_form' style='height:21px;border:1px solid;margin-left:4px;margin-bottom:4px;' onClick='excel_form_down()'>&nbsp;&nbsp;양식다운&nbsp;</label>";
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
	
// 		$("#frm8 #data_center_items").change(function(){
// 			if($(this).val() != ""){		
// 				var scode_cd = $("#frm8 select[name='data_center_items'] option:selected").val();
// 				$("#frm8 #data_center").val(scode_cd);
// 			}
// 		});
				
	}
	
	function load_excel() {
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
					frm.c.value = "UserExcelLoad";
					frm.file_nm.value = file_nm;
					
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
	
	function popupAppGrpCodeForm2(user_cd, isMoreThanTwo, select_dcc){ 
		var url = '<%=sContextPath %>/tWorks.ez?pop_if=P01&c=ez002_appGrpCode_form';
		var v_isMoreThanTwo = "";
		
		if(isMoreThanTwo){
			v_isMoreThanTwo = "Y";
		}else {
			v_isMoreThanTwo = "N";
		}
		
		if(dlMap.containsKey('dl_p01')) dlClose('dl_p01');
		if(isMoreThanTwo){
			$('#if_p01').width(470).height(590);
		}else{
			$('#if_p01').width(940).height(590);
		}
		dlPopIframe01('dl_p01','폴더권한',$('#if_p01').width(),$('#if_p01').height(),true,true,true);
		
		dlFrontView('dl_p01');
		setTimeout(function(){
			var f = document.f_appgrp;
			f.user_cd.value				=	user_cd;
			f.is_more_than_two.value 	=	v_isMoreThanTwo; 
			f.select_dcc.value 			=	select_dcc;
			f.target = "if_p01";
			f.action = url;
			f.submit();
		}, 300);
	}
	
	function getCodeList(isMoreThanTwo){
		
		try{viewProgBar(true);}catch(e){}
		var search_folder = $("#search_folder").val();
		
		var url = '';
		if(isMoreThanTwo){
			url = '<%=sContextPath %>/common.ez?c=cData&itemGb=sched_tableList3&itemGubun=2';	
		}else{
			url = '<%=sContextPath %>/common.ez?c=cData&itemGb=sched_tableList2&itemGubun=2';				
		}
		var rows = [];
		var xhr = new XHRHandler(url, appGrpCodeForm
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
				$(xmlDoc)
						.find('doc')
						.each(function() {
									var items = $(this).find('items');
									var rowsObj = new Array();

									if (items.attr('cnt') == '0') {
									} else {
										items.find('item').each(
											function(i) {
												var scode_nm = $(this).find("SCODE_NM").text();
												var grp_eng_nm = $(this).find("GRP_ENG_NM").text();
												var folder_auth = $(this).find("FOLDER_AUTH").text();
												var data_center = $(this).find("DATA_CENTER").text();
												if(folder_auth != ''){
													rows.push(i);
												}
												rowsObj.push({
															'grid_idx' : i + 1,
															'SCODE_NM' : scode_nm,
															'GRP_ENG_NM' : grp_eng_nm,
															'DATA_CENTER' : data_center
														});
											});
										};
									appGrpCodeGrid.rows = rowsObj;
									
									setGridRows(appGrpCodeGrid);
									var grid = $('#appGrpCodeGrid').data('grid');
									grid.setSelectedRows(rows);
									$('#ly_total_cnt_1').html(
										'[ TOTAL : '
												+ items.attr('cnt')
												+ ' ]');
									});
				try {viewProgBar(false);} catch (e) {}
			}, null);

		xhr.sendRequest();
	}
	
	//검색용
	function getCodeListSearch(scode_cd, grp_depth, grp_nm){
				
			try{viewProgBar(true);}catch(e){}
			
			var search_folder = $("#search_folder").val();
							
			var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=appGrpList&itemGubun=2&scode_cd='+scode_cd+'&grp_depth='+grp_depth+' &grp_nm='+grp_nm;
			
			var xhr = new XHRHandler(url, appGrpCodeForm
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
					$(xmlDoc)
							.find('doc')
							.each(function() {
										var items = $(this).find('items');
										var rowsObj = new Array();

										if (items.attr('cnt') == '0') {
										} else {
											items.find('item').each(
												function(i) {
													var scode_nm = $(this).find("SCODE_NM").text();
													var grp_eng_nm = $(this).find("GRP_ENG_NM").text();
													
													rowsObj.push({
																'grid_idx' : i + 1,
																'SCODE_NM' : scode_nm,
																'GRP_ENG_NM' : grp_eng_nm
															});
												});
											};
										appGrpCodeGrid.rows = rowsObj;
										setGridRows(appGrpCodeGrid);
										$('#ly_total_cnt_1').html(
											'[ TOTAL : '
													+ items.attr('cnt')
													+ ' ]');
										});
					try {viewProgBar(false);} catch (e) {}
				}, null);

		xhr.sendRequest();
	}
	
	// 로그인이력 팝업
	function popupLoginHistory(user_cd, isMoreThanTwo) {
		var search_s_date = <%=strSearchStartDate%>;
		var search_e_date = <%=strSearchEndDate%>;
		
		var sHtml1="<div id='userLoginHistory' style='overflow:hidden;display:none;padding:0;border-top:1px solid blue;border-bottom:1px solid blue;border-left:1px solid blue;border-right:1px solid blue;'>";
		sHtml1+="<form id='userLoginHistoryForm' name='userLoginHistoryForm' method='post' onsubmit='return false;'>";
		sHtml1+="<table style='width:100%;height:100%;border:none;'>"; //table 시작
		sHtml1+="<tr>"; // tr
		sHtml1+="<td style='vertical-align:top;height:100%;width:500px;text-align:right;' colspan=2>";
		sHtml1+="<div class='ui-widget-header ui-corner-all'>";
		sHtml1+="로그인일자 : ";
		sHtml1+="<input tpye='text' name='p_search_s_date' id='p_search_s_date' class='input datepick' style='width:80px;height:21px;' maxlength='8'> ~ ";
		sHtml1+="<input tpye='text' name='p_search_e_date' id='p_search_e_date' class='input datepick' style='width:80px;height:21px;margin-right:25px;' maxlength='8'>";
		sHtml1+="&nbsp;조건 : ";
		sHtml1+="<select name='p_search_gubun' id='p_search_gubun' style='width:80px;'>";
		sHtml1+="<option value='user_id'>아이디</option>";
		sHtml1+="<option value='user_nm'>이름</option></select>&nbsp;";
		sHtml1+="<input type='text' name='p_search_text' id='p_search_text' style='width:120px;'/>"
		sHtml1+="&nbsp;&nbsp;<span id='btn_search' >검색</span>";
		sHtml1+="</div>";
		sHtml1+="</td>";
		sHtml1+="</tr>"; // /tr
		sHtml1+="<tr style='height:480px;'>"; // tr
		sHtml1+="<td id='ly_userLoginHistoryGrid' style='vertical-align:top;' colspan=2>";
		sHtml1+="<div id='userLoginHistoryGrid' class='ui-widget-header ui-corner-all'></div>";
		sHtml1+="</td>";
		sHtml1+="</tr>"; // /tr
		sHtml1+="<tr style='height:5px;'>"; // tr
		sHtml1+="<td style='vertical-align:top;'>"; // td
		sHtml1+="<h5 class='ui-corner-all' >";
		sHtml1+="<div id='ly_code_total_cnt' style='padding:5px;float:left;'></div>";
		sHtml1+="</h5>";
		sHtml1+="</td>"; // /td
		sHtml1+="<td style='width:100%;vertical-align:top;'>"; // td
		sHtml1+="<div style='padding:3px;'>";
		sHtml1+="<h4>";
		sHtml1+="<span id='ly_total_cnt_1' stlye='float:left;'></span>";
		sHtml1+="<span id='btn_excel' style='float:right;'>엑셀다운</span>";
		sHtml1+="</h4>";
		sHtml1+="</div>";
		sHtml1+="</td>"; // /tb
		sHtml1+="</tr>"; //tr 3 끝
		sHtml1+="</table>"; //table 끝
		sHtml1+="</form>";
		sHtml1+="</div>";
		
		$('#userLoginHistory').remove();
		$('body').append(sHtml1);
		
		dlPop02('userLoginHistory',"로그인 이력",700,560,false);
				
		var gridObj = {
			id : "userLoginHistoryGrid"
			,rows:[]
			,vscroll:false
		};
		
		var codeColModel = [];
			codeColModel = [
	   				{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'번호',width:50,minWidth:50,headerCssClass:'cellCenter',cssClass:'cellCenter'}
					,{formatter:gridCellNoneFormatter,field:'USER_ID',id:'USER_ID',name:'아이디',width:100,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
					,{formatter:gridCellNoneFormatter,field:'USER_NM',id:'USER_NM',name:'이름',width:100,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	   				,{formatter:gridCellNoneFormatter,field:'INS_DATE',id:'INS_DATE',name:'접속일자',width:200,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	   				,{formatter:gridCellNoneFormatter,field:'INS_USER_IP',id:'INS_USER_IP',name:'접속IP',width:200,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
		   			];
		gridObj.colModel = codeColModel;
		
		
		viewGrid_1(gridObj,"ly_"+gridObj.id);
		
		if(search_s_date != "") {
			$("#p_search_s_date").val(search_s_date);
		}
		
		if(search_e_date != "") {
			$("#p_search_e_date").val(search_e_date);
		}
		
		
		$("#userLoginHistoryForm").find("#btn_search").button().unbind("click").click(function(){
			
			if($("#p_search_s_date").val() != "" && $("p_search_e_date").val() != "" ) {
				// 날짜 기간 체크
				if( $("#p_search_s_date").val() > $("p_search_e_date").val() ) {
					alert("로그인 일자의 FROM ~ TO를 확인해 주세요.");
					return;
				}
				if( !isValidDate($("#p_search_s_date").val()) || !isValidDate($("#p_search_e_date").val()) ){
					alert("잘못된 날짜입니다."); 
					return;
				}
			}
			
			userLoginHistoryList();
		});
		
		$("#userLoginHistoryForm").find('#p_search_text').unbind('keypress').keypress(function(e){			
			if(e.keyCode==13){	
				
				if($("#p_search_s_date").val() != "" && $("p_search_e_date").val() != "" ) {
					// 날짜 기간 체크
					if( $("#p_search_s_date").val() > $("p_search_e_date").val() ) {
						alert("로그인 일자의 FROM ~ TO를 확인해 주세요.");
						return;
					}
					if( !isValidDate($("#p_search_s_date").val()) || !isValidDate($("#p_search_e_date").val()) ){
						alert("잘못된 날짜입니다."); 
						return;
					}
				}
				
				userLoginHistoryList();
			}
		});
		
		$("#p_search_s_date").addClass("text_input").unbind('click').click(function(){
			dpCalMin(this.id,'yymmdd');
		});
		
		$("#p_search_e_date").addClass("text_input").unbind('click').click(function(){
			dpCalMin(this.id,'yymmdd');
		});
		
		$("#userLoginHistoryForm").find("#btn_excel").button().unbind("click").click(function(){
			
			var frm = document.userLoginHistoryForm;
			frm.action = "<%=sContextPath %>/tWorks.ez?c=ez002_login_history_excel";
			frm.target = "if1";
			frm.submit();
		});
		
	}
	
	function userLoginHistoryList(){

		try{viewProgBar(true);}catch(e){}
		
		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=userLoginHistoryList';
		
		var rows = [];
		var xhr = new XHRHandler(url, userLoginHistoryForm
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
				$(xmlDoc)
						.find('doc')
						.each(function() {
									var items = $(this).find('items');
									var rowsObj = new Array();

									if (items.attr('cnt') == '0') {
									} else {
										items.find('item').each(
											function(i) {
												var user_id = $(this).find("USER_ID").text();
												var user_nm = $(this).find("USER_NM").text();
												var ins_date = $(this).find("INS_DATE").text();
												var ins_user_ip = $(this).find("INS_USER_IP").text();
												
												rowsObj.push({
													'grid_idx' : i+1
													,'USER_ID' : user_id
													,'USER_NM' : user_nm
													,'INS_DATE' : ins_date
													,'INS_USER_IP' : ins_user_ip
												});
										});
									};
									userLoginHistoryGrid.rows = rowsObj;
									
									setGridRows(userLoginHistoryGrid);
									var grid = $('#userLoginHistoryGrid').data('grid');
									grid.setSelectedRows(rows);
									$('#ly_total_cnt_1').html(
										'[ TOTAL : '
												+ items.attr('cnt')
												+ ' ]');
									});
				try {viewProgBar(false);} catch (e) {}
			}, null);

		xhr.sendRequest();
	}
	
	function checkDelUserList() {
		var delUser = [];
		var del_yn = "Y";
		
		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=userList&p_del_yn='+del_yn;
		
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
						return false;
					}
					$(xmlDoc).find('doc').each(function() {
		                var items = $(this).find('items');
		                items.find('item').each(function(i) {
		                	delUser.push($(this).find("USER_ID").text());
		                });
		            });
				}
		, null );
		console.log(delUser);
		xhr.sendRequest();	
		return delUser;
	}
		
</script>
