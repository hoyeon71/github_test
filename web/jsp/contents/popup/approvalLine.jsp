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

<c:set var="approval_order_cd" value="${fn:split(APPROVAL_ORDER_CD,',')}"/>
<c:set var="approval_doc_cd" value="${fn:split(APPROVAL_DOC_CD,',')}"/>
<c:set var="approval_doc_nm" value="${fn:split(APPROVAL_DOC_NM,',')}"/>

<body id='body_A01' leftmargin="0" topmargin="0">

<%
	Map<String, Object> paramMap = CommonUtil.collectParameters(request);
	String c = CommonUtil.isNull(paramMap.get("c"));
	String gridId = "g_"+c;
	
	String user_cd = CommonUtil.isNull(paramMap.get("user_cd"));
	
	List userApprovalGroup = (List)request.getAttribute("userApprovalGroup");

	String strLineGrpCd = "";
	
	if ( userApprovalGroup != null ) {		
		for ( int i = 0; i < userApprovalGroup.size(); i++ ) {
			CommonBean commonBean = (CommonBean) userApprovalGroup.get(i);			
			strLineGrpCd = CommonUtil.isNull(commonBean.getLine_grp_cd());
		}
	}
%>
<c:set var="approval_seq_cd" 	value="${fn:split(APPROVAL_ORDER_CD,',')}"/>

<form id="f_s" name="f_s" method="post" onsubmit="return false;">	
	<input type="hidden" name="doc_gb" id="doc_gb" value="01,02,03"/>
</form>

<table style='width:99%;height:99%;border:none;'>
	<tr style='height:10px;'>
		<td style='vertical-align:top;' colspan="2">
			<h4 class="ui-widget-header ui-corner-all"  >
				<div id='t_<%=gridId %>' class='title_area' >
					<span><%=CommonUtil.getMessage("POPUP.APPROVAL.TITLE") %></span>
				</div>
			</h4>
		</td>
	</tr>	
	<tr>
		<td id='ly_<%=gridId %>' style='vertical-align:top;'>
			<form name="frm1" id="frm1" method="post" onsubmit="return false;">
				<input type="hidden" name="flag" 			id="flag" />
				<input type="hidden" name="line_cd" 		id="line_cd" />
				<input type="hidden" name="line_grp_cd" 	id="line_grp_cd" />
				<input type="hidden" name="approval_cd" 	id="approval_cd" />
				<input type="hidden" name="approval_seq" 	id="approval_seq" />
				<input type="hidden" name="line_grp_nm" 	id="line_grp_nm" />
				<input type="hidden" name="use_yn" 			id="use_yn" />
				<input type="hidden" name="approval_line_cd" id="approval_line_cd" />
				<!-- 관리자가 다른 사용자의 결재선을 관리할 경우가 있어서 셋팅. -->
				<input type="hidden" name="s_user_cd" value="<%=user_cd%>" />
	
				<div id="<%=gridId %>" class="ui-widget-header ui-corner-all" ></div>
			</form>
		</td>
	</tr>
	<tr style='height:10px;'>
		<td style='vertical-align:top;'>
			<h4 class="ui-widget-header ui-corner-all" >
				<div align='right' class='btn_area'>
					<div id='ly_total_cnt' style='padding-top:5px;float:left;'></div>
					<span id="btn_group_udt">저장</span>
				</div>
			</h4>
		</td>
	</tr>
</table>

<script>

	var arr_approval_order_cd 	= new Array();
	var arr_approval_doc_cd 	= new Array();
	var arr_approval_doc_nm 	= new Array();
	var arr_approval_seq_cd 	= new Array();
	
	<c:forEach var="approval_seq_cd" items="${approval_seq_cd}" varStatus="s">
		var	map_cd = {"cd":"${approval_seq_cd}"};
		arr_approval_seq_cd.push(map_cd);
	</c:forEach>
	
	<c:forEach var="approval_order_cd" items="${approval_order_cd}" varStatus="s">
		var map_cd = {"cd":"${approval_order_cd}"};
		arr_approval_order_cd.push(map_cd);
	</c:forEach>
	
	<c:forEach var="approval_doc_cd" items="${approval_doc_cd}" varStatus="s">
		var map_cd = {"cd":"${approval_doc_cd}"};
		arr_approval_doc_cd.push(map_cd);
	</c:forEach>
	<c:forEach var="approval_doc_nm" items="${approval_doc_nm}" varStatus="s">
		var map_nm = {"nm":"${approval_doc_nm}"};
		arr_approval_doc_nm.push(map_nm);
	</c:forEach>

// 	var gridObj = {
<%-- 		id : "<%=gridId %>" --%>
// 		,colModel:[
// 			{formatter:gridCellNoneFormatter,field:'DOC_GB',id:'DOC_GB',name:'문서구분',width:80,headerCssClass:'cellCenter',cssClass:'cellCenter'}
// 			,{formatter:gridCellNoneFormatter,field:'ORI_DOC_GB',id:'ORI_DOC_GB',name:'최종결재정보',width:90,headerCssClass:'cellCenter',cssClass:'cellCenter'}
// 			,{formatter:gridCellNoneFormatter,field:'USER_NM',id:'USER_NM',name:'결재자',width:200,headerCssClass:'cellCenter',cssClass:'cellLeft'}
// 			,{formatter:gridCellNoneFormatter,field:'ORDER_NO',id:'ORDER_NO',name:'결재순서',width:120,headerCssClass:'cellCenter',cssClass:'cellCenter'}
// 			,{formatter:gridCellNoneFormatter,field:'STATUS',id:'STATUS',name:'결재자상태',width:60,headerCssClass:'cellCenter',cssClass:'cellCenter'}
// 			,{formatter:gridCellNoneFormatter,field:'PROC',id:'PROC',name:'처리',width:60,headerCssClass:'cellCenter',cssClass:'cellCenter'}

// 			,{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'grid_idx',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
// 	   	]
// 		,rows:[]
// 		,vscroll:false
// 	};

	var gridObj = {
		id : "<%=gridId %>"
		,colModel:[
	   		{formatter:gridCellNoneFormatter,field:'APPROVAL_SEQ',id:'APPROVAL_SEQ',name:'결재순서',width:60,headerCssClass:'cellCenter',cssClass:'cellCenter'}
	   		,{formatter:gridCellNoneFormatter,field:'APPROVAL_NM',id:'APPROVAL_NM',name:'결재자',width:400,headerCssClass:'cellCenter',cssClass:'cellLeft'}
	   		,{formatter:gridCellNoneFormatter,field:'PROC',id:'PROC',name:'처리',width:80,headerCssClass:'cellCenter',cssClass:'cellCenter'}
	   		
	   		,{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'grid_idx',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   		,{formatter:gridCellNoneFormatter,field:'LINE_CD',id:'LINE_CD',name:'LINE_CD',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   		,{formatter:gridCellNoneFormatter,field:'LINE_GRP_CD',id:'LINE_GRP_CD',name:'LINE_GRP_CD',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   		,{formatter:gridCellNoneFormatter,field:'APPROVAL_CD',id:'APPROVAL_CD',name:'APPROVAL_CD',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
			,{formatter:gridCellNoneFormatter,field:'USER_CD',id:'USER_CD',name:'USER_CD',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   	]
		,rows:[]
		,vscroll:<%=S_GRID_VSCROLL%>
	};
	
	$(document).ready(function(){
			
		viewGrid_1(gridObj,"ly_"+gridObj.id);
// 		approvalLineList();
		userApprovalLineList();
		
		$("#btn_group_udt").button().unbind("click").click(function(){
			var flag = 'group_udt'
			var strLineCd 		= "";
			var strApprovalCd 	= "";
			var strApprovalSeq	= "";
			
			for(var i = 0; i < gridObj.rows.length; i++){
				if( i == 0 ){
					if($('input[id=approval_cd0]').val() != ""){
						strLineCd 	   += ",0";
						strApprovalCd  += "," + $('input[id=approval_cd0]').val();
						strApprovalSeq += "," + $('select[id=approval_seq0] option:selected').val();
					}
				}else {
					var line_cd = getCellValue(gridObj, i, "LINE_CD");
					strLineCd 	   += "," + line_cd;
					strApprovalCd  += "," + $('input[id=approval_cd' + line_cd +']').val();
					strApprovalSeq += "," + $('select[id=approval_seq' + line_cd +'] option:selected').val();
				}
			}
			
			strLineCd 		= strLineCd.substr(1);
			strApprovalCd 	= strApprovalCd.substr(1);
			strApprovalSeq 	= strApprovalSeq.substr(1);
			
			goProc2(flag, strLineCd, strApprovalCd, strApprovalSeq);
		});
		
	});
	
	function approvalLineList(){
		
		try{viewProgBar(true);}catch(e){}
		$('#ly_total_cnt').html('');
		
		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=approvalLine&user_cd=<%=user_cd %>';
		
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
						
						var tot_cnt = items.attr("cnt");
						var v_approval_order = parseInt(tot_cnt) + 1;
						
						var inputApproval_order_no = "";
						inputApproval_order_no += "<div>승인<select id='seq' name='seq' style='width:30px;'>";
						for(var j=0;j<arr_approval_order_cd.length;j++){							
							inputApproval_order_no += "<option value='"+arr_approval_order_cd[j].cd+"'>"+arr_approval_order_cd[j].cd+"</option>";
						}
						inputApproval_order_no += "</select>차 결재자</div>";
						
						var inputApproval_doc_gb = "";
						inputApproval_doc_gb += "<div><select id='doc_gb' name='doc_gb' style='width:100%;'>";
						inputApproval_doc_gb += "<option value=''>--선택--</option>";
						for(var k=0;k<arr_approval_doc_cd.length;k++){	
							inputApproval_doc_gb += "<option value='"+arr_approval_doc_cd[k].cd+"'>"+arr_approval_doc_nm[k].nm+"</option>";
						}
						inputApproval_doc_gb += "</select></div>";
						
						var inputApproval_user = "";
						inputApproval_user += "<div class='gridInput_area'><input type='hidden' id='user_cd' name='user_cd'/><input type='text' id='user_nm' name='user_nm' value='' style='width:100%;'/></div>";
												
						var inputPrc = "";
						inputPrc += "<div><a href=\"javascript:goProc('ins','');\"><font color='red'>[추가]</font></a></div>";
						
						rowsObj.push({
									'grid_idx':0
									,'DOC_GB':inputApproval_doc_gb
									,'ORI_DOC_GB':""
									,'USER_NM':inputApproval_user
									,'USER_CD':''
									,'STATUS':''
									,'ORDER_NO':inputApproval_order_no	
									,'PROC':inputPrc								
						});
						
						if(items.attr('cnt')=='0'){
						}else{
							items.find('item').each(function(i){						
								
								var approval_line_cd =  $(this).find("APPROVAL_LINE_CD").text();
								var doc_gb = $(this).find("DOC_GB").text();
								var ori_doc_gb = $(this).find("ORI_DOC_GB").text();
								var user_nm = $(this).find("USER_NM").text();
								var user_cd = $(this).find("USER_CD").text();
								var duty_nm = $(this).find("DUTY_NM").text();
								var dept_nm = $(this).find("DEPT_NM").text();
								var status = $(this).find("STATUS").text();
								var seq = $(this).find("SEQ").text();								
								var v_user_nm = "["+dept_nm+"]"+"["+duty_nm+"]"+"["+user_nm+"]";
								var v_proc = "";
								var v_doc_gb = "";
								var v_ori_doc_gb = "";
								var v_status = "";
								var v_seq = "";
																
								for(var k=0;k<arr_approval_doc_cd.length;k++){	
									if(ori_doc_gb == arr_approval_doc_cd[k].cd){
										v_ori_doc_gb = arr_approval_doc_nm[k].nm;
									}
								}
								
								if(ori_doc_gb != ""){
									v_seq = "운영"+seq+"차 결재자";
								}
								
								if(doc_gb != "00"){
								
									v_proc = "<div><a href=\"javascript:goProc('del','"+approval_line_cd+"');\"><font color='red'>[삭제]</font></a></div>"; 
									v_ori_doc_gb = "";
									
									for(var k=0;k<arr_approval_doc_cd.length;k++){	
										if(ori_doc_gb == arr_approval_doc_cd[k].cd){
											v_doc_gb = arr_approval_doc_nm[k].nm;
										}
									}
									
									v_seq = "상시"+seq+"차 결재자";
								}
																								
								if(status == "Y") v_status = "정상";
								if(status == "N") v_status = "By Pass";
								
								rowsObj.push({
									'grid_idx':i+1
									,'DOC_GB': v_doc_gb
									,'ORI_DOC_GB': v_ori_doc_gb
									,'USER_NM': v_user_nm
									,'USER_CD': user_cd
									,'STATUS' : v_status
									,'ORDER_NO': v_seq									
									,'PROC': v_proc
								});
								
							});						
						}
						
						gridObj.rows = rowsObj;
						setGridRows(gridObj);
						$('#ly_total_cnt').html('[ TOTAL : '+items.attr('cnt')+' ]');
						
						$('#user_nm').unbind('keypress').keypress(function(e){
							if(e.keyCode==13 && trim($(this).val())!=''){
								getUserList($(this).val());
							}
						}).unbind('keyup').keyup(function(e){
							if($('#user_cd').val()!='' && $(this).data('sel_v') != $(this).val()){
								$('#user_cd').val('');
								$(this).removeClass('input_complete');
							}
							
						});			
						
					});
					try{viewProgBar(false);}catch(e){}
				}
		, null );
		
		xhr.sendRequest();
	}

	function userApprovalLineList(){
		
		var strLineGrpCd = '<%=strLineGrpCd%>';
		
		if(strLineGrpCd == ''){
			alert("개인결재선의 그룹명이 없는 id입니다. 개인결재선 그룹명을 먼저 생성해주세요.");
			
			this.close();
			
			return;
		}
		
		try{viewProgBar(true);}catch(e){}
		$('#ly_total_cnt').html('');
		
		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=userApprovalLine&itemGubun=2&admin=Y&line_grp_cd='+strLineGrpCd;
		
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
						
						var tot_cnt = items.attr("cnt");
						var v_approval_seq = parseInt(tot_cnt) + 1;
						
						var inputApproval_seq_no = "";
						inputApproval_seq_no += "<div class='gridInput_area'><select id='approval_seq0' name='approval_seq0' style='width:100%;text-align:center;'>";
						for(var j=0;j<arr_approval_seq_cd.length;j++){							
							inputApproval_seq_no += "<option value='"+arr_approval_seq_cd[j].cd+"'>"+arr_approval_seq_cd[j].cd+"</option>";
						}
						inputApproval_seq_no += "</select></div>";
												
						var inputApproval_user = "";
						inputApproval_user += "<div class='gridInput_area'><input type='hidden' id='approval_cd0' name='approval_cd0'/><input type='text' id='approval_nm0' name='approval_nm0' value='' style='width:100%;'/></div>";
												
						var inputPrc = "";
						inputPrc += "<div><a href=\"javascript:goProc('ins','"+strLineGrpCd+"','0');\"><font color='red'>[추가]</font></a></div>";
						
	//						var inputApproval_gb = "";
	//						inputApproval_gb += "<div class='gridInput_area'><select id='approval_gb0' name='approval_gb0' style='width:100%;'>"
	//						for(var j=0;j<arr_approval_gb_cd.length;j++){							
	//							inputApproval_gb += "<option value='"+arr_approval_gb_cd[j].cd+"'>"+arr_approval_gb_nm[j].nm+"</option>";
	//						}
	//						inputApproval_gb += "</select></div>"
						
						rowsObj.push({
							'grid_idx':""
							,'LINE_CD': ""
							,'LINE_GRP_CD': ""
							,'APPROVAL_NM': inputApproval_user
							,'APPROVAL_SEQ': inputApproval_seq_no
	//							,'APPROVAL_GB': inputApproval_gb
							,'PROC':inputPrc
						});
						
						if(items.attr('cnt')=='0'){
						}else{
							items.find('item').each(function(i){						
							
								var line_cd 		= $(this).find("LINE_CD").text();
								var line_grp_cd 	= $(this).find("LINE_GRP_CD").text();
								var approval_cd 	= $(this).find("APPROVAL_CD").text();
								var approval_nm 	= $(this).find("APPROVAL_NM").text();
								var user_id 		= $(this).find("USER_ID").text();
								var duty_nm 		= $(this).find("DUTY_NM").text();
								var dept_nm 		= $(this).find("DEPT_NM").text();
	//								var user_info 		= approval_nm+"["+dept_nm+"]"+"["+duty_nm+"]";
								var user_info 		= approval_nm+"["+user_id+"]["+dept_nm+"]"+"["+duty_nm+"]";
								var approval_seq 	= $(this).find("APPROVAL_SEQ").text();
	//								var approval_gb 	= $(this).find("APPROVAL_GB").text();
								var user_cd 		= $(this).find("APPROVAL_CD").text();
	
								var v_approval_cd = "";
								v_approval_cd += "<input type='hidden' id='approval_cd"+line_cd+"' name='approval_cd"+line_cd+"' value='"+approval_cd+"' />";								
	
								var v_approval_seq = "";
								v_approval_seq += "<div class='gridInput_area'><select id='approval_seq"+line_cd+"' name='approval_seq"+line_cd+"' style='width:100%;text-align:center;'>";
								
								var v_user_cd = "";
								v_user_cd += "<input type='hidden' id='user_cd"+line_cd+"' name='user_cd"+line_cd+"' value='"+user_cd+"' />";
	
								for(var j=0;j<arr_approval_seq_cd.length;j++){
									
									v_approval_seq_check = "";
									
									if(approval_seq == arr_approval_seq_cd[j].cd){										
										v_approval_seq_check = "selected";
									}
									
									v_approval_seq += "<option value='"+arr_approval_seq_cd[j].cd+"' "+v_approval_seq_check+">"+arr_approval_seq_cd[j].cd+"</option>";
								}
								v_approval_seq += "</select></div>";
								
								v_user_info = ""; 
								v_user_info += "<div class='gridInput_area'>"+user_info+"<input type='text' id='approval_nm"+line_cd+"' name='approval_nm"+line_cd+"' value='' style='width:100%;'/></div>"; 
								
	//								var v_approval_gb = "";
	//								v_approval_gb += "<div class='gridInput_area'><select name='approval_gb"+line_cd+"' id='approval_gb"+line_cd+"' style='width:100%;'>";								
								
	//								for(var j=0;j<arr_approval_gb_cd.length;j++){
									
	//									v_approval_gb_check = "";
									
	//									if(approval_gb == arr_approval_gb_cd[j].cd){										
	//										v_approval_gb_check = "selected";
	//									}
									
	//									v_approval_gb += "<option value='"+arr_approval_gb_cd[j].cd+"' "+v_approval_gb_check+">"+arr_approval_gb_nm[j].nm+"</option>";									
	//								}
								
	//								v_approval_gb += "</select></div>";
								
								var v_proc 	= "<div>";
								v_proc 		+= "<a href=\"javascript:goProc('udt','"+line_grp_cd+"','"+line_cd+"');\"><font color='red'>[수정]</font></a> ";
								v_proc 		+= "<a href=\"javascript:goProc('del','"+line_grp_cd+"','"+line_cd+"');\"><font color='red'>[삭제]</font></a>";
								v_proc 		+= "</div>";
	
								/*
								var v_approval_gb 	= "";
								for(var j=0;j<arr_approval_gb_cd.length;j++){
									if(approval_gb == arr_approval_gb_cd[j].cd){
										v_approval_gb = arr_approval_gb_nm[j].nm;
									}
								}
								*/
								
								rowsObj.push({
									'grid_idx':i+1
									,'LINE_CD': line_cd
									,'LINE_GRP_CD': line_grp_cd
									,'APPROVAL_SEQ': v_approval_seq
									,'APPROVAL_NM': v_user_info
									,'APPROVAL_CD': v_approval_cd
	//									,'APPROVAL_GB': v_approval_gb
									,'PROC': v_proc
									,'USER_CD': v_user_cd
								});
								
							});						
						}
						
						gridObj.rows = rowsObj;
						setGridRows(gridObj);
						$('#ly_total_cnt').html('[ TOTAL : '+items.attr('cnt')+' ]');
					
						
						// 사용자 자동 검색을 최초 저장 뿐만 아니라 수정도 가능하게 해야 하는 요건.
						// 해당 row의 line_cd를 가져와서 $('#approval_nm' + sel_line_cd) 이런식으로 셋팅을 해놔도 마지막 row의 line_cd로만 인식하는 현상이 있음.
						// 그래서 getUserList 호출할 때 다시 한번 해당 row의 line_cd를 가져와서 파라미터로 넘겨준다.
						// 2018.01.31 강명준 수정
						var aSelRow 	= new Array;
						aSelRow 		= gridObj.rows;
						
						//신한투자증권 대결자 검색 팝업형태로 변경
	//						if ( aSelRow.length > 0 ) {
	//							for ( var i = 1; i < aSelRow.length; i++ ) {
	//								var sel_line_cd = "";
	//								sel_line_cd = getCellValue(gridObj_2, i, "LINE_CD");
								
	//								$('#approval_nm' + sel_line_cd).unbind('keypress').keypress(function(e){
	//									//if(e.keyCode==13 && trim($(this).val())!=''){
	//									if(e.keyCode==13){
	//										var aSelRow 	= new Array;
	//										aSelRow = $('#'+gridObj_2.id).data('grid').getSelectedRows();
	//										if(aSelRow.length>0){
	//											for(var i=0;i<aSelRow.length;i++){
	//												line_cd = getCellValue(gridObj_2,aSelRow[i],"LINE_CD");
	//											}
	//										}
	
	//										getUserList($(this).val(), line_cd);
	//									}
	//								}).unbind('keyup').keyup(function(e){
	//									if($('#approval_cd' + sel_line_cd).val()!='' && $(this).data('sel_v') != $(this).val()){
	//										$('#approval_cd' + sel_line_cd).val('');
	//										$(this).removeClass('input_complete');
	//									}
	//								});
								
	//							}
	//						}
							
						$('input[id^=approval_nm]').unbind('click').click(function(){
							var user_idx = $(this).attr('id').replace("approval_nm","");
							goUserSearch(99,user_idx);
						}).unbind('keyup').keyup(function(e){
							if($(this).val() != '' && (this).data('sel_v') != $(this).val()){
								$('#sel_v').val();
								$(this).removeClass('input_complete');
							}
						});
						
						//신한투자증권 대결자 검색 팝업형태로 변경
	//						$('#approval_nm0').unbind('keypress').keypress(function(e){
	//							//if(e.keyCode==13 && trim($(this).val())!=''){
	//							if(e.keyCode==13){
	//								getUserList($(this).val(), 0);
	//							}
	//						}).unbind('keyup').keyup(function(e){
	//							if($('#approval_cd0').val()!='' && $(this).data('sel_v') != $(this).val()){
	//								$('#approval_cd0').val('');
	//								$(this).removeClass('input_complete');
	//							}
	//						});
						
						
					});
					try{viewProgBar(false);}catch(e){}
				}
		, null );
		
		xhr.sendRequest();
	}	
					
	function goProc(flag, line_grp_cd, line_cd) {
		var frm = document.frm1;
		var msg = "";
		var approval_cd 	= $("#frm1 #approval_cd" + line_cd);
		var approval_seq	= $("#frm1 #approval_seq" + line_cd);
	//		var approval_gb		= $("#frm2 #approval_gb" + line_cd);
		var std_approval_cd 	= $("#approval_cd0").val();
		var std_approval_cd1 	= $("#approval_cd" + line_cd).val();
	
		for (var i = 1; i < gridObj.rows.length; i++) {
			line_cd_val 	= getCellValue(gridObj,i,"LINE_CD");
			chk_user_cd		= $("#user_cd"+ line_cd_val).val();
	
			if (std_approval_cd == chk_user_cd) {
				alert("[결재자 중복] 결재자는 한번만 사용이 가능합니다.");
				return;
			}
	
			//결재자 수정 시에 결재자 중복 체크(23.02.21 김은희)
			if ( flag == "udt" ) {
				if ( std_approval_cd1 == chk_user_cd){
					alert("[결재자 중복] 결재자는 한번만 사용이 가능합니다.");
					return;
				}
			}
		}
	
		if ( flag != "del" ) {			
			//if(isNullInput(approval_cd,'<%=CommonUtil.getMessageSplit("ERROR.PARAM.02","[결재자]","") %>')) return;
			if ( approval_cd.val() == "" ) {
				alert("결재자를 입력 및 엔터 후 선택해 주세요.");
				return;
			}
			
			if(isNullInput(approval_seq,'<%=CommonUtil.getMessageSplit("ERROR.PARAM.02","[결재순서]","") %>')) return;			
		}
		
		if(confirm("처리하시겠습니까?")) {
			
			frm.approval_cd.value	= approval_cd.val();
			frm.approval_seq.value	= approval_seq.val();
	//			frm.approval_gb.value	= approval_gb.val();
			
			frm.flag.value 			= flag;
			frm.line_grp_cd.value 	= line_grp_cd;
			frm.line_cd.value 		= line_cd;
			frm.target 				= "if1";
			frm.action 				= "<%=sContextPath%>/tWorks.ez?c=ezUserApprovalLine_p";
			
			frm.submit();		
		}
	}
	
	//신한투자증권 대결자 검색 팝업형태로 변경
	function goUserSeqSelect(cd, nm, btn, sel_line_cd){
		
		$("#approval_nm"+ sel_line_cd).val(nm);
		$("#approval_cd"+ sel_line_cd).val(cd);;
	
		dlClose('dl_tmp3');
	}
	
	// 결재자 일괄수정 기능
	function goProc2(flag, line_cd, approval_cd, approval_seq) {
		var strLineGrpCd = '<%=strLineGrpCd%>';
		
		var frm = document.frm1;
		
		if(line_cd == "") {
			alert("수정할 결재자를 등록해주세요.");
			return;
		}

		
		if(confirm("처리하시겠습니까?")) {
		
			frm.flag.value 			= flag;
			frm.line_grp_cd.value 	= strLineGrpCd;
			frm.line_cd.value 		= line_cd;
			frm.approval_cd.value 	= approval_cd;
			frm.approval_seq.value 	= approval_seq;
			
			frm.target 				= "if1";
			frm.action 				= "<%=sContextPath%>/tWorks.ez?c=ezUserApprovalLine_p";
			
			frm.submit();		
		}
	}
	
</script>

<%@include file="/jsp/common/inc/progBar.jsp"  %>
<iframe name="if1" id="if1" width="0" height="0"></iframe>
</body>
</html>
