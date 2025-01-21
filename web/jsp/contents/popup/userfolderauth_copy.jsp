<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.ghayoun.ezjobs.t.domain.*" %>

<%@include file="/jsp/common/inc/header.jsp"%>
<%@include file="/jsp/common/inc/sessionChkPopup.jsp"%>

<%
	Map<String, Object> paramMap = CommonUtil.collectParameters(request);
	String c = CommonUtil.isNull(paramMap.get("c"));
	String gridId_1 = "g_"+c+"_1";
	String gridId = "g_"+c;
	
	List userAuthList		= (List)request.getAttribute("userAuthList");
	List schedTableList		= (List)request.getAttribute("schedTableList");
	String ALL_GB			= (String)request.getAttribute("ALL_GB");
	List dataCenterList 	= (List)request.getAttribute("dataCenterList");
		
	String user_cd 			= CommonUtil.isNull(paramMap.get("user_cd"));
	String user_id 			= CommonUtil.isNull(paramMap.get("user_id"));
	String user_nm 			= CommonUtil.isNull(paramMap.get("user_nm"));
	String scode_cd 		= CommonUtil.isNull(paramMap.get("scode_cd"));
	
	String arr_user_cd 		= CommonUtil.isNull(paramMap.get("arr_user_cd"));
	String arr_user_id 		= CommonUtil.isNull(paramMap.get("arr_user_id"));
	
	String strSessionTab	= S_TAB;
	String strSessionDcCode = S_D_C_CODE;
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Frameset//EN" "http://www.w3.org/TR/html4/frameset.dtd">

<script type="text/javascript" src="<%=request.getContextPath() %>/js/SlickGrid-2.1.0/slick.formatters.js" ></script>

<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>EzJOBs 통합배치모니터링 시스템</title>
<link rel="stylesheet" href="<%=sContextPath %>/css/css.css" type="text/css">
<link href="<%=request.getContextPath() %>/css/common.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath() %>/css/custom-theme/jquery-ui.custom.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath() %>/css/custom-theme/jquery-ui.works.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="<%=sContextPath %>/js/jquery-1.9.0.min.js"></script>
<script type="text/javascript" src="<%=sContextPath %>/js/jquery-ui.custom.min.js"></script>
<script type="text/javascript" src="<%=sContextPath %>/js/common.js" ></script>
<script type="text/javascript" src="<%=sContextPath %>/js/popup.js" ></script>
<script type="text/javascript" src="<%=sContextPath %>/js/works_common.js" ></script>

<style type="text/css">
	.hover { background-color:#e2f4f8; }
</style>
<script type="text/javascript" >

function gridCellCustomFormatter(row,cell,value,columnDef,dataContext){
	var ret = "";
	var job_id = getCellValue(gridObj,row,'JOB_ID');
	var job_name = getCellValue(gridObj,row,'JOB_NAME');
	var table_id = getCellValue(gridObj,row,'TABLE_ID');
	
	if(columnDef.id == 'JOB_NAME'){
		ret = "<a href=\"JavaScript:popupDefJobDetail('"+encodeURIComponent(job_name)+"','"+table_id+"','"+job_id+"');\" /><font color='red'>"+value+"</font></a>";
	}
	
	return ret;
}

var gridObj = {
		id : "<%=gridId %>"
		,colModel:[			
	   		{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'번호',width:50,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'SCHED_TABLE',id:'SCHED_TABLE',name:'폴더',width:150,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'APPLICATION',id:'APPLICATION',name:'어플리케이션',width:150,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}	 
	   		,{formatter:gridCellNoneFormatter,field:'GROUP_NAME',id:'GROUP_NAME',name:'그룹',width:150,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}	
	   		,{formatter:gridCellNoneFormatter,field:'JOBSCHEDGB',id:'JOBSCHEDGB',name:'작업종류',width:100,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}	
	   		,{formatter:gridCellCustomFormatter,field:'JOB_NAME',id:'JOB_NAME',name:'작업명',width:250,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'DESCRIPTION',id:'DESCRIPTION',name:'작업설명',width:250,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'T_SET',id:'T_SET',name:'변수 입력란',width:150,headerCssClass:'cellCenter',cssClass:'cellCenter',editor:Slick.Editors.Text}
	   		
	   		,{formatter:gridCellNoneFormatter,field:'FORCE',id:'FORCE',name:'FORCE',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   		,{formatter:gridCellNoneFormatter,field:'JOB_ID',id:'JOB_ID',name:'JOB_ID',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   		,{formatter:gridCellNoneFormatter,field:'TABLE_ID',id:'TABLE_ID',name:'TABLE_ID',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   	]
		
		,rows:[]
		,vscroll:false
	};

$(document).ready(function(){
	
	var table_name		= "<%=strSessionTab%>";
	var session_dc_code = "<%= strSessionDcCode %>";
		
	$("#btn_search").show();
	
	$('.trOver tr:lt(1000)').hover(
		function() { $(this).addClass('hover');},
		function() { $(this).removeClass('hover');}
	);

	$(window).resize(function() {
         $('div.lst_header > table > thead > tr:first').children().each(function(i,v){
                    $(this).width($('div.lst_contents > table > tbody > tr > td:eq('+ i +')').width());
         }); 
	}).resize();
	 
	$("#btn_insert").button().unbind("click").click(function(){
		goPrc();
	});
	
	$("#btn_close").button().unbind("click").click(function(){
		self.close();
	});
	
	$("#btn_clear1").unbind("click").click(function(){
		$("#f_s").find("input[name='p_sched_table']").val("");
		$("#frm1").find("input[name='table_nm']").val("");
		$("#frm1").find("input[name='table_of_def']").val("");		
	});
	
	$("#btn_search").button().unbind("click").click(function(){
		var data_center = $("select[name='data_center_items'] option:selected").val();
		
		if(data_center == ""){
			alert("C-M 을 선택해 주세요.");
			return;
		}
		/* 
		$("#f_s").find("input[name='p_table_nm']").val($("#frm1").find("select[name='table_nm']").val());
	
		readJobList(); */
	});
	
	poeTabForm();
});
</script>

<script type="text/javascript" >
	function goPrc() {
		
		var frm = document.frm1;
		
		var obj = document.getElementsByName('checkIdx');
		var folder_auth = "";
		for(var i=0; i<obj.length; i++ ){
			if(obj[i].checked){
				if(folder_auth==""){
					folder_auth = obj[i].value;
				}else{
					folder_auth += (","+obj[i].value);
				}
			}
		}
		
		if( !confirm('선택한 Folder의 권한을 등록하시겠습니까?') ) return;

		frm.folder_auth.value = folder_auth;
		//frm.target = "prcFrame";
		frm.action = "<%=sContextPath%>/tWorks.ez?c=ez002_p";
		frm.submit();
	}	
	
function poeTabForm() {
		
		var sHtml1="<div id='dl_tmp1' style='overflow:hidden;display:none;padding:0;border-top:1px solid blue;border-bottom:1px solid blue;border-left:1px solid blue;border-right:1px solid blue;'>";
		sHtml1+="<form id='common_form1' name='common_form1' method='post' onsubmit='return false;'>";		
		sHtml1+="<table style='width:100%;height:650px;border:none;'><tr><td style='vertical-align:top;height:100%;width:900px;text-align:right;'>";
		sHtml1+="<select name='app_search_gubun' id='app_search_gubun' style='height:21px;'>";
		sHtml1+="<option value='e'>폴더</option>";
		sHtml1+="</select>&nbsp;";
		sHtml1+="<input type='text' name='grp_nm' id='grp_nm' style='ime-mode:active;'/>&nbsp;&nbsp;<span id='btn_app_search'>검색</span>";
		sHtml1+="<table style='width:100%;height:100%;border:none;'>";
		sHtml1+="<tr><td id='ly_g_tmp1' style='vertical-align:top;' >";
		sHtml1+="<div id='g_tmp1' class='ui-widget-header ui-corner-all'></div>";
		sHtml1+="</td></tr>";
		sHtml1+="<tr style='height:10px;'><td style='vertical-align:top;'><h5 class='ui-widget-header ui-corner-all' >";
		sHtml1+="<div align='right' class='btn_area_s'>";
		sHtml1+="<div id='ly_total_cnt_10' style='padding-top:5px;float:left;'></div>";
		sHtml1+="</div>";
		sHtml1+="</h5></td></tr></table>";
		
		sHtml1+="</td></tr></table>";
		
		sHtml1+="</form>";
		
		$('#dl_tmp1').remove();
		$('#dl_tmp1').append(sHtml1);
		
		dlPop01('dl_tmp1', "폴더 검색", 770, 700, false);
				
		var gridObj = {
			id : "g_tmp1"
			,colModel:[
		   		{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'번호',width:50,headerCssClass:'cellCenter',cssClass:'cellCenter'}	   		
		   		,{formatter:gridCellNoneFormatter,field:'GRP_ENG_NM',id:'GRP_ENG_NM',name:'폴더',width:150,headerCssClass:'cellCenter',cssClass:'cellLeft'}
		   		,{formatter:gridCellNoneFormatter,field:'GRP_DESC',id:'GRP_DESC',name:'설명',width:400,headerCssClass:'cellCenter',cssClass:'cellLeft'}	 
		   		,{formatter:gridCellNoneFormatter,field:'CHOICE',id:'CHOICE',name:'선택',width:50,headerCssClass:'cellCenter',cssClass:'cellCenter'}
		   		
		   		,{formatter:gridCellNoneFormatter,field:'GRP_CD',id:'GRP_CD',name:'GRP_CD',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
		   		,{formatter:gridCellNoneFormatter,field:'GRP_ENG_NM',id:'GRP_ENG_NM',name:'GRP_ENG_NM',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
		   		,{formatter:gridCellNoneFormatter,field:'USER_DAILY',id:'USER_DAILY',name:'USER_DAILY',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
		   	]
			,rows:[]
			,vscroll: true
		};

		viewGrid_1(gridObj,'ly_'+gridObj.id);
		
		$("#grp_nm").focus();
		popTabList2('', '');
		
		$('#grp_nm').placeholder().unbind('keypress').keypress(function(e){
			if(e.keyCode==13 && trim($('#grp_nm').val())!=''){
				var app_search_gubun = $("select[name='app_search_gubun'] option:selected").val();
				var tab_search_gubun = $("select[name='tab_search_gubun'] option:selected").val();
				popTabList2($(this).val(), app_search_gubun, tab_search_gubun);
			}
		});
		
		$("#tab_search_gubun").change(function(){
			var grp_nm = $("#common_form1").find("input[name='grp_nm']").val();
			var app_search_gubun = $("select[name='app_search_gubun'] option:selected").val();
			popTabList2(grp_nm, app_search_gubun, $(this).val());
		});
		
		$("#btn_app_search").button().unbind("click").click(function(){
			var grp_nm = $("#common_form1").find("input[name='grp_nm']").val();
			var app_search_gubun = $("select[name='app_search_gubun'] option:selected").val();
			var tab_search_gubun = $("select[name='tab_search_gubun'] option:selected").val();
			
			popTabList2(grp_nm, app_search_gubun, tab_search_gubun);
		});
		
	}
	
	function dlPop01(id,nm,w,h,bResize){
		$("#" + id).dialog({
			title: nm
			,modal: false
			,width: w+2
			,height: h+32
			,position: "center"
			,resizable: bResize
			,show :'fadeIn'
			
			,close : function( event, ui ) {
				$(this).dialog( "destroy" );
			}
		});
	}
</script>
</head>
<body style="background:#fff;">

<form id="f_s" name="f_s" method="post" onsubmit="return false;">
	<input type='hidden' id='user_nm' 				name='user_nm' />
	<input type='hidden' id='user_cd' 				name='user_cd' />
	<input type='hidden' id='user_id' 				name='user_id' />
	
	<input type='hidden' id='data_center' 			name='data_center'/>
	<input type='hidden' id='p_table_nm' 			name='p_table_nm'/>
	<input type="hidden" id="p_scode_cd"			name="p_scode_cd"  />
	<input type="hidden" id="p_grp_depth"			name="p_grp_depth"  />
</form>

<form id="frm1" name="frm1" method="post" onsubmit="return false;">
	
	<input type="hidden" name="flag" 			value='folder_auth' />
	<input type="hidden" name="user_cd" 		value='<%=user_cd %>'/>
	<input type="hidden" name="user_id" 		value='<%=user_id%>'/>
	<input type="hidden" name="arr_user_cd" 	value='<%=arr_user_cd %>'/>
	<input type="hidden" name="arr_user_id" 	value='<%=arr_user_id %>'/>
	<input type="hidden" name="folder_auth" />
	<input type="hidden" name="ALL_GB" 			value='<%=ALL_GB %>'/>
	<input type="hidden" name="table_nm" />

	<div class="view_area">
		<!-- title -->
		<div class="tit_area">
			<h1><span class="icon"><img src="<%=sContextPath %>/images/icon_sgnb6.png" alt="" /></span>Folder 권한 등록</h1>
			<div class="btn">
				<span id="btn_insert">저장</span>
				<span id="btn_close">닫기</span>
			</div>			
		</div>
		<table style='width:100%;height:20px;border:none'>
			<tr><td style="height:10px;"></td></tr>
			<tr>
				<td colspan="3" style="height:15px;">	
					<b>C-M</b> : 
					<select id="data_center_items" name="data_center_items" style="width:120px; height:21px;">
						<option value="">--선택--</option>
							<c:forEach var="cm" items="${cm}" varStatus="status">
								<option value="${cm.scode_cd},${cm.scode_eng_nm}">${cm.scode_nm}</option>
							</c:forEach>
					</select>
					<input type="hidden" id="data_center" name="data_center"  />
				</td>			
				<td colspan="3" style="vertical-align:top;">
					<table>
						<tr>
							<th>폴더 : </th>
							<td style="width:50%;text-align:left;">								
								<input type="text" name="table_nm" id="table_nm" style="width:120px; height:21px;"/>&nbsp;<img id="btn_clear1" src="/images/sta2.png" style="width:16px;height:16px;vertical-align:middle;cursor:pointer;"/>
								<input type="hidden" name="table_of_def" id="table_of_def" />								
							</td>
							<td width="30%" style="text-align:right;">
								<img id="btn_search" src='<%=sContextPath%>/imgs/btn_SRC.gif' style='border:0;vertical-align:top;cursor:pointer;' />
							</td>
						</tr>
					</table>
				</td>
			</tr>			
		</table>
	</div>	
	<div class="board_area">
		<div class="lst_area">	
		
		<table class='board_lst gray'>
		<colgroup>
			<col width="10px" />
			<col width="100px" />
		</colgroup>
		<tr >
			<%if(!ALL_GB.equals("Y")){%>
				<th colspan='2' ><%=user_nm%>[<%=user_id%>]</th> 	
			<%}%>
		</tr>
		<tr>
			<th width='10px'><input name='checkIdxAll' type='checkbox' onClick="chkAll('checkIdx');"></th>
			<th width='100px'>폴더<font color='red'>(권한 등록할 Folder 선택)</font></th>
		</tr>
		<tr>
		<td id='ly_<%=gridId %>' style='vertical-align:top;' >
			<div id="<%=gridId %>" class="ui-widget-header ui-corner-all" ></div>
		</td>
	</tr>
		<!-- <div id="dl_tmp1" style="overflow:hidden;display:none;padding:0;border-top:1px solid blue;border-bottom:1px solid blue;border-left:1px solid blue;border-right:1px solid blue;">
		<form id="common_form1" name="common_form1" method="post" onsubmit="return false;">	
				<table style="width:100%;height:650px;border:none;">
					<tr>
						<td style="vertical-align:top;height:100%;width:900px;text-align:right;">
							<select name='app_search_gubun' id='app_search_gubun' style='height:21px;'>
								<option value='e'>폴더</option>
							</select>&nbsp;
				<input type='text' name='grp_nm' id='grp_nm' style='ime-mode:active;'/>&nbsp;&nbsp;<span id='btn_app_search'>검색</span>
							<table style='width:100%;height:100%;border:none;'>
								<tr>
									<td id="ly_g_tmp1" style='vertical-align:top;' >
										<div id="g_tmp1" class='ui-widget-header ui-corner-all'></div>
									</td>
								</tr>
								<tr style='height:10px;'>
									<td style='vertical-align:top;'>
										<h5 class='ui-widget-header ui-corner-all' >
											<div align='right' class='btn_area_s'>
												<div id="ly_total_cnt_10" style='padding-top:5px;float:left;'></div>
											</div>
										</h5>
									</td>
								</tr>
							</table>		
						</td>
					</tr>
				</table>
			</form>
			</div> -->
		</table>		
		</div>
	</div>
</form>

</body>
</html>