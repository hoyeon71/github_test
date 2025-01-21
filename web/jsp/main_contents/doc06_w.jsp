<%@page import="com.ghayoun.ezjobs.t.domain.ApprovalLineBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/jsp/common/inc/header.jsp"%>
<%@include file="/jsp/common/inc/hint.jsp"%>
<%@ page import="java.sql.*,java.util.*,java.io.*,java.text.*,java.net.*" %>
<%@ page import="com.ghayoun.ezjobs.m.domain.*" %>
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
<script type="text/javascript" src="<%=request.getContextPath() %>/js/SlickGrid-2.1.0/plugins/slick.autocolumnsize.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/poshytip-1.2/jquery.poshytip.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/works_common.js?v=<%=jsVersion %>" ></script>

</head>
<%
	Map<String, Object> paramMap = CommonUtil.collectParameters(request);
	String strVerify			= CommonUtil.isNull(paramMap.get("verify"));
	String menu_gb				= "";
	if(strVerify.equals("Y")){
		menu_gb = CommonUtil.getMessage("CATEGORY.GB.06.GB."+CommonUtil.isNull(paramMap.get("menu_gb")));
	}else{
		menu_gb = CommonUtil.getMessage("CATEGORY.GB.02.GB."+CommonUtil.isNull(paramMap.get("menu_gb")));
	}
	
	String[] arr_menu_gb = menu_gb.split(",");
	
	String c = CommonUtil.isNull(paramMap.get("c"));
	String gridId = "g_"+c;	
	String gridId_1 = "g_"+c+"_1";
	String gridId_2 = "g_"+c+"_2";
	String gridId_3 = "g_"+c+"_3";
	
	List approvalLineList = (List)request.getAttribute("approvalLineList");
	
	List adminApprovalBtnList = (List)request.getAttribute("adminApprovalBtnList");

	//엑셀일괄작업등록 
	String doc_gb = CommonUtil.isNull(paramMap.get("doc_gb"));
	
	String doc_cd = "";
	String strAdminApprovalBtn		= "";
	
	if ( adminApprovalBtnList != null ) {		
		for ( int i = 0; i < adminApprovalBtnList.size(); i++ ) {			
			CommonBean commonBean = (CommonBean) adminApprovalBtnList.get(i);			
			strAdminApprovalBtn = CommonUtil.isNull(commonBean.getScode_nm());
		}
	}
	
	// 세션값 가져오기.	
	String strSessionDcCode 	= S_D_C_CODE;
	
	// 작업 통제 여부
	String S_BATCH_CONTROL 		= CommonUtil.isNull(request.getSession().getAttribute("BATCH_CONTROL"));
	// 반영일
	String strApplyDate		 	= (String) request.getAttribute("ODATE");
%>

<script type="text/javascript">
function load_excel() {
	
	var data_center 		= $("#data_center").val();
	var act_gb 				= $("#act_gb").val();
	var file				= $("#file_data").val();
	var content				= $("#content").val();
	var apply_date			= $("#apply_date").val();
	var adminApprovalBtn 	= "<%=strAdminApprovalBtn%>";
	var file_size			= $("input[name=files]")[0].files[0].size;
	
	if(title == ''){
	}
	if(data_center == ''){
		alert("C-M 을 입력하세요");
		$("#data_center_of").focus();
		return;
	}
	
	/* if(table_nm == ''){
		alert("서비스를 선택하세요");
		$("#table_nm").focus();
		return;
	} */
	
	if(act_gb == ''){
		alert("문서 구분을 입력하세요");
		$("#act_gb_of").focus();
		return;
	}

	if(file == ''){
		alert("첨부 파일을 입력하세요");
		return;
	}
	
	if(file.indexOf('.xls') == -1){
		alert('xls형식만 업로드할 수 있습니다.');
		return;
	}
	
	if(file_size > 5242880) {
		alert('파일 크기는 5MB를 넘을 수 없습니다.')
		return;
	}
		
	var formData = new FormData();
	formData.append("c", "excelUpload");
	formData.append("act_gb", act_gb);
	formData.append("apply_date", apply_date);
	formData.append("random", Math.random());
	formData.append("files", $("input[name=files]")[0].files[0]);
	
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
				
				var frm 					= document.frm1;
				frm.c.value 				= "ExcelLoad";
				frm.file_nm.value 			= file_nm;
				frm.adminApprovalBtn.value 	= adminApprovalBtn;
				frm.verify.value 			= '<%=strVerify%>';
				
				frm.target 					= "if2";											
				frm.action 					= "<%=sContextPath%>/tWorks.ez";
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
</script>

<form id="f_s" name="f_s" method="post" onsubmit="return false;">	
	<input type="hidden" name="p_mcode_nm" id="p_mcode_nm" />
	<input type="hidden" name="p_scode_nm" id="p_scode_nm" />
	
	<input type="hidden" name="p_scode_cd" 			id="p_scode_cd" />
	<input type="hidden" name="p_grp_depth" 		id="p_grp_depth" />
	<input type="hidden" name="p_app_nm" 			id="p_app_nm" />
	<input type="hidden" name="p_app_search_gubun" 	id="p_app_search_gubun" />
</form>
<form id="userFrm" name="userFrm" method="post" onsubmit="return false;">	
	<input type="hidden" id="flag"		name="flag" 		value="" />
</form>
<form id="frm1" name="frm1" method="post" onsubmit="return false;" enctype="multipart/form-data" >
	<input type="hidden" name="c" id="c" />
	<input type="hidden" name="file_nm" id="file_nm" />		
	<input type="hidden" id="doc_gb" 	name="doc_gb" 		value="<%=doc_gb %>" />
	<input type="hidden" id="flag"		name="flag" 		value="" />
	<input type="hidden" id="title"		name="title" 		value="" />
	<input type="hidden" id="user_cd"	name="user_cd" />
	<input type="hidden" id="days_cal"	name="days_cal" />
	<input type="hidden" id="adminApprovalBtn"	name="adminApprovalBtn" />
	<input type="hidden" id="verify"	name="verify" />

	<table style='width:99%;height:99%;border:none;'>
	<tr style='height:10px;'>
		<td style='vertical-align:top;'>
			<h4 class="ui-widget-header ui-corner-all"  >
				<div id='t_<%=gridId %>' class='title_area'>
					<%if(strVerify.equals("Y")){ %>
					<span><%=CommonUtil.isNull(CommonUtil.getMessage("CATEGORY.GB.06"))%> > <%=CommonUtil.isNull(arr_menu_gb[0]) %></span>
					<%}else{ %>
					<span><%=CommonUtil.isNull(CommonUtil.getMessage("CATEGORY.GB.02"))%> > <%=CommonUtil.isNull(arr_menu_gb[0]) %></span>
					<%} %>
				</div>
			</h4>
		</td>
	</tr>
	<tr>
		<td id='ly_<%=gridId %>' style='vertical-align:top;'>
			<div id="<%=gridId %>" class="ui-widget-header_kang ui-corner-all">
				<table style="width:100%">
					<tr>
						<td>
							<div class='cellTitle_kang5'>요청 정보</div>
						</td>	
					
					</tr>
					<tr>
						<td valign="top">
							<table style="width:100%;">
								<tr>
									<td width="10%"></td>
									<td width="20%"></td>
									<td width="10%"></td>
									<td width="20%"></td>
									<td width="10%"></td>
									<td width="20%"></td>
								</tr>
								<tr>
									<td>
										<div class='cellTitle_ez_right'>의 뢰 자</div>
									</td>
									<td>
										<div class='cellContent_kang'><%="["+S_DEPT_NM+"] ["+S_DUTY_NM+"] "+S_USER_NM %></div>
									</td>
									<td>
										<div class='cellTitle_ez_right' style='min-width:120px' ><font color="red">* </font>반영 예정일</div>
									</td>
									<td colspan="2">
										<input type="text" name="apply_date" id="apply_date" class="input datepick" value="<%=strApplyDate%>" style="width:75px; height:21px;" maxlength="8" autocomplete="off" />
									</td>
								</tr>
							</table>
						</td>
					</tr>
					
				</table>
				
				<table style="width:100%">
					<tr>
						<td>
							<div class='cellTitle_kang5'>
							<img src="/images/icon_lst23b.png" width="20" height="20" onClick="showHint(job_execel_div,this);" style="cursor:pointer;vertical-align:text-top;" />
							작업 정보
							</div>
						</td>	
					</tr>
					<tr>
						<td valign="top">
							<table style="width:100%;">
								<tr>
									<td width="10%"></td>
									<td width="20%"></td>
									<td width="10%"></td>
									<td width="20%"></td>
									<td width="10%"></td>
									<td width="20%"></td>
								</tr>
								<tr>
									<th>
										<div class='cellTitle_ez_right'><font color="red">* </font>C-M</div>
									</th>									
									<td> 
										<div class='cellContent_kang'>
											<select name="data_center_items" id="data_center_items" style="width:50%;height:21px;">
												<option value="">--선택--</option>
												<c:forEach var="cm" items="${cm}" varStatus="status">
													<option value="${cm.scode_cd},${cm.scode_eng_nm}">${cm.scode_nm}</option>
												</c:forEach>
											</select>
											<input type="hidden" name="data_center" id="data_center" />
										</div>
									</td>
									<%if(!strVerify.equals("Y")){ %>
									<th>
										<div class='cellTitle_ez_right'><font color="red">* </font>문서 구분</div>
									</th>
									<td>
										<div class='cellContent_kang'>
											<select id='act_gb_of' name='act_gb_of' style="width:50%;height:21px;" >
												<option value="">--선택--</option>
												<option value='C'>신규</option>
												<%if(!strVerify.equals("Y")){ %>
												<option value='U'>수정</option>
												<option value='D'>삭제</option>
												<%} %>
											</select>
											<input type="hidden" name="act_gb" id="act_gb" />
										</div>
									</td>
									<%}else{%>
									<input type="hidden" name="act_gb" id="act_gb" value="C"/>
									<%}%>
								</tr>
								<tr style="height:21px;">																	
									<th>
										<div class='cellTitle_ez_right'><font color="red">* </font>첨부파일</div>
									</th>
									<td colspan="5">
										<div class='cellContent_kang'>
										<div class="filebox"style="position:relative;">
											<input type="text" name="file_data" id="file_data" style="width:520px; height:21px;" readOnly />
											<label for="files" style="height:21px;border:1px solid">&nbsp;&nbsp;파일선택&nbsp;</label>
											<input type="file" name="files" id="files" />
											
											<% if ( !S_BATCH_CONTROL.equals("Y")) { %>
												<label for="excel_load1" style="height:21px;border:1px solid" onClick='load_excel()'>&nbsp;&nbsp;엑셀로드&nbsp;</label>
											<% } %>
<!-- 											<img src='/imgs/icon/xls.png'  onclick='download()' style='position:absolute;cursor:pointer;height:20px;top:5px;padding-left:5px;'/> -->
											<%if(!strVerify.equals("Y")){ %>
											<label onclick='download()'style="height:21px;border:1px solid">&nbsp;&nbsp;샘플파일&nbsp;</label>
											<input type='hidden' name='excel_load1' id='excel_load1'>
											<%}%>
										</div>
										</div>
									</td>			
								</tr> 
							</table>
							
						</td>
					</tr>
				</table>
				
			</div>
		</td>
	</tr>
	<tr>
		<td style="height:100%;">
			<iframe name="if2" id="if2" style="width:100vw;height:70vh;" scrolling="no" frameborder="0"></iframe>
		</td>
	</tr>
</table>
</form>

<script>

	var rowsObj_job1 = new Array();
	var rowsObj_job2 = new Array();
	
	var arr_caluse_gb_cd = new Array();
	var arr_caluse_gb_nm = new Array();
	
	$(document).ready(function() {
		
		var session_dc_code	= "<%=strSessionDcCode%>";
		
		$("#if2").hide();
		
		if(session_dc_code != "") { // 개인정보에 C-M이 등록되어 있을경우
			$("select[name='data_center_items']").val(session_dc_code);
			$("#data_center").val(session_dc_code);
		}else { // 개인정보에 C-M이 등록이 되어있지 않을경우 -> C-M 콤보박스에서 첫번째값 선택
			$("#data_center_items option:eq(1)").prop("selected", true);
			$("#data_center").val($("select[name='data_center_items']").val());
		}

		//반영일
		$("#apply_date").addClass("text_input").unbind('click').click(function(){
			dpCalMinMax(this.id,'yymmdd','0','90');
		});

		$("#btn_sched").button().unbind("click").click(function(){			
			popSchedForm();
		});
		
		$("#files").change(function(){			
			$("#file_data").val($(this).val());			
		});
		
		$("#act_gb_of").change(function(){			
			$("#act_gb").val($(this).val());			
		});
	
		$("#data_center_items").change(function(){
			
			$("#table_nm").val("");
			$("#table_of_def").val("");
			
			if($(this).val() != ""){		
				var scode_cd = $("select[name='data_center_items'] option:selected").val();
				$("#data_center").val(scode_cd);
			}
		});	
	});
	
	
	//테이블 클릭 시
	$("#table_nm").click(function(){
		
		var data_center = $("select[name='data_center_items'] option:selected").val();
		
		if(data_center == ""){
			alert("C-M 을 선택해 주세요.");
			return;
		}else{
			poeTabForm();
		}		
	});
	
	function selectTable(eng_nm, desc, user_daily){

		$("#table_nm").val(eng_nm);
		$("#table_of_def").val(eng_nm);
		$("#table_name").val(eng_nm);
		$("#user_daily").val(user_daily);
		
		dlClose("dl_tmp1");
	}

	function getCodeList(scode_cd, grp_depth, grp_cd, val){
		
		try{viewProgBar(true);}catch(e){}
				
		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=appGrpCodeList&itemGubun=2&scode_cd='+scode_cd+'&grp_depth='+grp_depth+'&grp_cd='+grp_cd;
		
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
							$("select[name='"+val+"'] option").remove();
							$("select[name='"+val+"']").append("<option value=''>--선택--</option>");							
						}else{
							
							$("select[name='"+val+"'] option").remove();
							$("select[name='"+val+"']").append("<option value=''>--선택--</option>");			
							
							items.find('item').each(function(i){						
							
								var grp_cd = $(this).find("GRP_CD").text();
								var grp_nm = $(this).find("GRP_NM").text();								
								var grp_eng_nm = $(this).find("GRP_ENG_NM").text();
								var grp_desc = $(this).find("GRP_DESC").text();
								var grp_all_cd = grp_cd+","+grp_eng_nm;   
																																																								
								$("select[name='"+val+"']").append("<option value='"+grp_all_cd+"'>"+grp_desc+"</option>");
								
							});						
						}									
						
					});
					try{viewProgBar(false);}catch(e){}
				}
		, null );
		
		xhr.sendRequest();
	}

	function popSchedForm(){
		
		var sHtml1="<div id='dl_tmp1' style='overflow:hidden;display:none;padding:0;'>";
		sHtml1+="<form id='form1' name='form1' method='post' onsubmit='return false;'>";
		sHtml1+="<input type='hidden' name='search_gubun' id='search_gubun' value='job_name' />";
		sHtml1+="<table style='width:100%;height:320px;;border:none;'><tr><td style='vertical-align:top;height:100%;width:500px;'>";
		sHtml1+="<table style='width:100%'><tr><td style='text-align:right;'>";
		sHtml1+="<b>캘린더명</b>&nbsp;:&nbsp;<input type='text' name='cal_text' id='cal_text' style='height:21px;' />&nbsp;&nbsp;<span id='btn_cal_search'>검색</span>";
		sHtml1+="</td></tr></table>";
		sHtml1+="<table style='width:100%;height:100%;border:none;'>";
		sHtml1+="<tr><td id='ly_g_tmp1' style='vertical-align:top;' >";
		sHtml1+="<div id='g_tmp1' class='ui-widget-header ui-corner-all'></div>";
		sHtml1+="</td></tr>";
		sHtml1+="<tr style='height:10px;'><td style='vertical-align:top;'><h5 class='ui-widget-header ui-corner-all' >";
		sHtml1+="<div align='right' class='btn_area_s'>";
		sHtml1+="<div id='ly_total_cnt_1' style='padding-top:5px;float:left;'></div>";
		sHtml1+="</div>";
		sHtml1+="</h5></td></tr></table>";
		
		sHtml1+="</td></tr></table>";
		
		sHtml1+="</form>";
		
		$('#dl_tmp1').remove();
		$('body').append(sHtml1);
		
		dlPop01('dl_tmp1',"캘린더",650,360,false);
				
		var gridObj = {
			id : "g_tmp1"
			,colModel:[
		   		{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'번호',width:50,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
		   		,{formatter:gridCellNoneFormatter,field:'CAL_NM',id:'CAL_NM',name:'캘린더명',width:150,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}	 
		   		,{formatter:gridCellNoneFormatter,field:'DAYS_CAL',id:'DAYS_CAL',name:'월달력',width:120,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}	 
		   		,{formatter:gridCellNoneFormatter,field:'DAYS_AND_OR',id:'DAYS_AND_OR',name:'조건',width:100,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}	   		
		   		,{formatter:gridCellNoneFormatter,field:'WEEKS_CAL',id:'WEEKS_CAL',name:'주간달력',width:120,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
		   		,{formatter:gridCellNoneFormatter,field:'USE_GB',id:'USE_GB',name:'구분',width:100,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
		   		,{formatter:gridCellNoneFormatter,field:'USE_YN',id:'USE_YN',name:'사용여부',width:60,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
		   		//,{formatter:gridCellNoneFormatter,field:'CHOICE',id:'CHOICE',name:'선택',width:60,headerCssClass:'cellCenter',cssClass:'cellCenter'}
		   		   		
		   		,{formatter:gridCellNoneFormatter,field:'CAL_CD',id:'CAL_CD',name:'CAL_CD',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
		   	]
			,rows:[]
			,vscroll:<%=S_GRID_VSCROLL%>
		};
		
		viewGrid_1(gridObj,'ly_'+gridObj.id);
		
	}

	function download(){

		var f = document.userFrm;

		f.flag.value = "excel_sample";
		f.target = "if1";
		f.action = "<%=sContextPath %>/common.ez?c=fileDownload";
		f.submit();

	}

</script>
<%@include file="/jsp/common/inc/progBar.jsp"  %>
<iframe name="if1" id="if1" width="0" height="0"></iframe>
<div id="dl_p01" style='overflow:hidden;display:none;padding:0;'>
	<iframe id='if_p01' name='if_p01' src='about:blank' width='0px' height='0px' scrolling='no'  frameborder="0"  ></iframe>
</div>
</body>
</html>