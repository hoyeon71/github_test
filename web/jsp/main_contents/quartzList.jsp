<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/jsp/common/inc/header.jsp"%>

<c:set var="user_gb_cd" value="${fn:split(USER_GB_CD,',')}"/>
<c:set var="user_gb_nm" value="${fn:split(USER_GB_NM,',')}"/>
<c:set var="duty_gb_cd" value="${fn:split(DUTY_GB_CD,',')}"/>
<c:set var="duty_gb_nm" value="${fn:split(DUTY_GB_NM,',')}"/>
<c:set var="dept_gb_cd" value="${fn:split(DEPT_GB_CD,',')}"/>
<c:set var="dept_gb_nm" value="${fn:split(DEPT_GB_NM,',')}"/>

<%
	Map<String, Object> paramMap = CommonUtil.collectParameters(request);
	String c = CommonUtil.isNull(paramMap.get("c"));
	String gridId = "g_"+c;
	
	String menu_gb = CommonUtil.getMessage("CATEGORY.GB.06.GB.0611");
	String[] arr_menu_gb = menu_gb.split(",");
	
	String date = DateUtil.getDay();
%>

<form id="f_s" name="f_s" method="post" onsubmit="return false;">	
	<input type="hidden" name="p_search_text" id="p_search_text"/>
	
	<input type="hidden" name="p_search_gubun" id="p_search_gubun"/>
	<input type="hidden" name="p_s_date" id="p_s_date"/>
	<input type="hidden" name="p_e_date" id="p_e_date"/>
	
	<input type="hidden" name="flag" id="flag"/>
</form>
<form id="frm2" name="frm2" method="post" onsubmit="return false;">	
	<input type="hidden" name="trace_log_file" id="trace_log_file"/>
	<input type="hidden" name="trace_log_path" id="trace_log_path"/>
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
					<th width="10%">
						<div class='cellTitle_kang2'>배치이름</div>
					</th>
					<td>
						<div class='cellContent_kang'>
							<input type="text" name="search_text" value="" id="search_text" style="width:150px; height:21px;" />
						</div>						
					</td>
					<%-- <th width="10%"><div class='cellTitle_kang2'>날짜</div></th>
					<td width="20%" style="text-align:left">
						<div class='cellContent_kang'>
						<input type="text" name="s_odate" id="s_date" value="<%=date %>" class="input datepick" style="width:75px; height:21px;" maxlength="10" readOnly/> ~
						<input type="text" name="e_odate" id="e_date" value="<%=date %>" class="input datepick" style="width:75px; height:21px;" maxlength="10" readOnly/>
						</div>
					</td> --%>
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
	<!-- <tr style='height:10px;'>
		<td style='vertical-align:top;'>
			<h4 class="ui-widget-header ui-corner-all">
				<div align='right' class='btn_area'>
					<div id='ly_total_cnt' style='padding-top:5px;float:left;'></div>
					<span id="btn_insert">추가</span>
					<span id="btn_update">수정</span>
				</div>
			</h4>
		</td>
	</tr> -->
</table>

<div id="dl_p01" style='overflow:hidden;display:none;padding:0;'>
	<iframe id='if_p01' name='if_p01' src='about:blank' width='0px' height='0px' scrolling='no'  frameborder="0"  ></iframe>
</div>
<script>

	function gridCellCustomFormatter(row,cell,value,columnDef,dataContext){
		
		var ret = "";
		var quartz_name = getCellValue(gridObj,row,'QUARTZ_NAME');
		
		if(columnDef.id == 'BTN_LIST_SEARCH'){
			ret = "<a href=\"JavaScript:popupQuartzForm('"+quartz_name+"');\" /><font color='red'>"+value+"</font></a>";	
		}
		if(columnDef.id == 'BTN_RERUN'){
			ret = "<a href=\"JavaScript:goPrc('"+quartz_name+"');\" /><font color='red'>"+value+"</font></a>";	
		}
		
		return ret;
	}
	
	function gridCellCustomFormatter2(row,cell,value,columnDef,dataContext){
		var ret			   = "";
		var obj			   = $("#g_tmp1").data('gridObj');
		var quartz_name	   = getCellValue(obj,row,'QUARTZ_NAME');
		var status_cd 	   = getCellValue(obj,row,'STATUS_CD');
		var trace_log_file = getCellValue(obj,row,'TRACE_LOG_FILE');
		var trace_log_path = getCellValue(obj,row,'TRACE_LOG_PATH');
		
		if(columnDef.id == 'STATUS_LOG'){
			if (status_cd == 'FAIL')
				ret = "<a href=\"JavaScript:popupLongLog('"+row+"');\" /><font color='red'>"+value+"</font></a>";
			else
				ret = value;
		}
		if(columnDef.id == 'LOG_VIEW'){
			ret = "<a href=\"JavaScript:popupLogView('"+trace_log_file+"', '"+trace_log_path+"');\" /><font color='red'>"+value+"</font></a>";
		}
		return ret;
	}
	
	var gridObj = {
		id : "<%=gridId %>"
		,colModel:[
	   		{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'번호',width:50,minWidth:50,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'QUARTZ_NAME',id:'QUARTZ_NAME',name:'배치이름',width:180,minWidth:180,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'STATUS_CD',id:'STATUS_CD',name:'실행결과',width:70,minWidth:70,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'STATUS_LOG',id:'STATUS_LOG',name:'결과메세지',width:200,minWidth:200,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'TRACE_LOG_PATH',id:'TRACE_LOG_PATH',name:'로그파일위치',width:450,minWidth:450,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'INS_DATE',id:'INS_DATE',name:'최종실행일자',width:160,minWidth:160,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	   		,{formatter:gridCellCustomFormatter,field:'BTN_LIST_SEARCH',id:'BTN_LIST_SEARCH',name:'실행내역조회',width:100,minWidth:100,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	   		,{formatter:gridCellCustomFormatter,field:'BTN_RERUN',id:'BTN_RERUN',name:'재실행',width:70,minWidth:70,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	   	]
		,rows:[]
		,vscroll: <%=S_GRID_VSCROLL%>
	};
	
	$(document).ready(function(){
		
		$("#btn_search").show();
		
		viewGrid_1(gridObj,"ly_"+gridObj.id,{enableColumnReorder:true},'AUTO');
		quartzList();		//초기 전체사용자 로드
		
		$("#btn_search").button().unbind("click").click(function(){
			setTimeout(function(){
				quartzList();
			}, 1000);
		});
		
		$('#search_text').unbind('keypress').keypress(function(e){
			if(e.keyCode==13 && trim($(this).val())!=''){
				
// 				if($(this).val() == ""){
// 					alert("검색어를 입력해 주세요.");
// 					return;
// 				}

				quartzList();
			}
		});
		
		$("#BTN_LIST_SEARCH").button().unbind("click").click(function(){
		});
		
		/* $("#s_date").addClass("ime_readonly").unbind('click').click(function(){
			dpCalMin(this.id,'yymmdd');
		});
		
		$("#e_date").addClass("ime_readonly").unbind('click').click(function(){
			dpCalMin(this.id,'yymmdd');
		}); */
			
	});
		
	function quartzList(){
		
//			$("#f_s").find("input[name='p_s_odate']").val($("#frm1").find("input[name='s_odate']").val());
//			$("#f_s").find("input[name='p_e_odate']").val($("#frm1").find("input[name='e_odate']").val());
		$("#f_s").find("input[name='p_search_text']").val($("#frm1").find("input[name='search_text']").val());
		
		try{viewProgBar(true);}catch(e){}
		$('#ly_total_cnt').html('');
		
		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=quartzList';
		
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
						
						if(items.attr('cnt')=='0'){
						}else{
							items.find('item').each(function(i){						
							
								var quartz_name = $(this).find("QUARTZ_NAME").text();
								var status_cd = $(this).find("STATUS_CD").text();
								var status_log = $(this).find("STATUS_LOG").text();
								var trace_log_path = $(this).find('TRACE_LOG_PATH').text();
								var ins_date = $(this).find("INS_DATE").text();
								var search 	= "<div>[조회]</div>";
								var rerun	= "<div>[재실행]</div>";
								
								if (status_cd == "1") {
									status_cd = "OK";
								} else {
									status_cd = "FAIL";
								}
								
								rowsObj.push({
									'grid_idx'			: i+1
									,'QUARTZ_NAME'		: quartz_name
									,'STATUS_CD'		: status_cd
									,'STATUS_LOG'		: status_log
									,'TRACE_LOG_PATH'	: trace_log_path
									,'INS_DATE'			: ins_date
									,'BTN_LIST_SEARCH'	: search
									,'BTN_RERUN'		: rerun
								});
								
							});						
						}
						
						gridObj.rows = rowsObj;
						setGridRows(gridObj);
						$('body').resizeAllColumns();
						$('#ly_total_cnt').html('[ TOTAL : '+items.attr('cnt')+' ]');
						
					});
					try{viewProgBar(false);}catch(e){}
				}
		, null );
		
		xhr.sendRequest();
	}
	
	function goPrc(flag){
		
		if(!confirm("재수행 하시겠습니까?")){
			return;
		}
		var frm = document.f_s;
		
		try{viewProgBar(true);}catch(e){}

		frm.flag.value = flag;
		frm.action = "<%=sContextPath %>/common.ez?c=ezQuartzList_p";
		frm.target = "if1"
		frm.submit();
<%-- 		var url = "<%=sContextPath %>/common.ez?c=ezQuartzList_p"; --%>
// 		var xhr = new XHRHandler(url, frm, callBackSearchItemValue, null);
// 		xhr.sendRequest();
		
	}
	
	// AJAX 콜백 함수.
	function callBackSearchItemValue(){
		
		var result_text = this.req.responseText;
	
		// 앞뒤 공백 제거.
		result_text = result_text.replace(/^\s+|\s+$/g,"");
	
		try{viewProgBar(false);}catch(e){}
		alert(result_text);
	}

	function popupQuartzForm(name){
	
		var date = "<%=date %>";
		
		var sHtml1="<div id='dl_tmp1' style='overflow:hidden;display:none;padding:0;border-top:1px solid blue;border-bottom:1px solid blue;border-left:1px solid blue;border-right:1px solid blue;'>";
		sHtml1+="<form id='form1' name='form1' method='post' onsubmit='return false;'>";		
		sHtml1+="<table style='width:100%;height:50px;border:none;'>";
		sHtml1+="<tr>";
		sHtml1+="<th width='10%'><div class='cellTitle_kang2'>실행일자</div></th>";
		sHtml1+="<td width='30%' style='text-align:left'>";
		sHtml1+="<div class='cellContent_kang'>";
		sHtml1+="<input type='text' name='s_date' id='s_date' value='"+date+"' class='input datepick' style='width:75px; height:21px;' maxlength='10' readOnly/> ~";
		sHtml1+="<input type='text' name='e_date' id='e_date' value='"+date+"' class='input datepick' style='width:75px; height:21px;' maxlength='10' readOnly/>";
		sHtml1+="</div>";
		sHtml1+="</td>";
		sHtml1+="<th width='10%'><div class='cellTitle_kang2'>실행결과</div></th>";
		sHtml1+="<td width='30%' style='text-align:left'><select name='search_gubun' id='search_gubun' style='height:21px;'>";
		sHtml1+="<option value=''>전체</option>";
		sHtml1+="<option value='Y'>성공</option>";
		sHtml1+="<option value='N'>실패</option>";
		sHtml1+="</select>&nbsp;";
		sHtml1+="</td>";
		sHtml1+="<td align='right'><span id='btn_app_search'>검색</span></td>";
		sHtml1+="</tr>";
		sHtml1+="</table>";
		sHtml1+="<table style='width:100%;height:600px;border:none;'>";
		sHtml1+="<tr><td id='ly_g_tmp1' style='vertical-align:top;' >";
		sHtml1+="<div id='g_tmp1' class='ui-widget-header ui-corner-all'></div>";
		sHtml1+="</td></tr>";
		sHtml1+="<tr style='height:10px;'><td style='vertical-align:top;'><h5 class='ui-widget-header ui-corner-all' >";
		sHtml1+="<div align='right' class='btn_area_s'>";
		sHtml1+="<div id='ly_total_cnt_10' style='padding-top:5px;float:left;'></div>";
		sHtml1+="</div>";
		sHtml1+="</h5></td></tr></table>";
// 		<tr><td style='vertical-align:top;height:100%;width:900px;text-align:right;'>
// 		sHtml1+="</td></tr></table>";
		
		sHtml1+="</form>";
		
		$('#dl_tmp1').remove();
		$('body').append(sHtml1);
		
		dlPop01('dl_tmp1', "배치 검색", 1200, 650, false);
		
		var gridObj2 = {
			id : "g_tmp1"
			,colModel:[
				{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'번호',width:50,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
		   		,{formatter:gridCellNoneFormatter,field:'QUARTZ_NAME',id:'QUARTZ_NAME',name:'배치이름',width:180,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
		   		,{formatter:gridCellNoneFormatter,field:'STATUS_CD',id:'STATUS_CD',name:'실행결과',width:70,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
		   		,{formatter:gridCellCustomFormatter2,field:'STATUS_LOG',id:'STATUS_LOG',name:'결과메세지',width:200,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
		   		,{formatter:gridCellNoneFormatter,field:'TRACE_LOG_FILE',id:'TRACE_LOG_FILE',name:'로그파일명(확장자 .log)',width:250,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
		   		,{formatter:gridCellNoneFormatter,field:'INS_DATE',id:'INS_DATE',name:'실행일자',width:160,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
		   		,{formatter:gridCellCustomFormatter2,field:'LOG_VIEW',id:'LOG_VIEW',name:'로그조회',width:100,minWidth:100,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
		   		,{formatter:gridCellNoneFormatter,field:'TRACE_LOG_PATH',id:'TRACE_LOG_PATH',name:'로그파일위치',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid',sortable:true}
		   	]
			,rows:[]
			,vscroll: true
		};
		
		viewGrid_1(gridObj2,'ly_'+gridObj2.id);
// 		popupQuartzList(name);
		
		$("#btn_app_search").button().unbind("click").click(function(){
// 			var search_gubun = $("#form1").find("select[name='search_gubun']").val();
// 			var s_date = $("#form1").find("input[name='s_date']").val();
// 			var e_date = $("#form1").find("input[name='e_date']").val();
			
			$("#f_s").find("input[name='p_s_date']").val($("#form1").find("input[name='s_date']").val());
			$("#f_s").find("input[name='p_e_date']").val($("#form1").find("input[name='e_date']").val());
			$("#f_s").find("input[name='p_search_gubun']").val($("#form1").find("select[name='search_gubun']").val());
			popupQuartzList(name);
		});
		
		$("#s_date").addClass("ime_readonly").unbind('click').click(function(){
			dpCalMin(this.id,'yymmdd');
		});
		
		$("#e_date").addClass("ime_readonly").unbind('click').click(function(){
			dpCalMin(this.id,'yymmdd');
		});
	}
		
	function popupQuartzList(name){
	
		try{viewProgBar(true);}catch(e){}		
		$('#ly_total_cnt_10').html('');		

		var url = '';
		
		url = '/common.ez?c=cData&itemGb=popupQuartzList&quartz_name=' + name;
				
		var xhr = new XHRHandler(url, f_s
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
									
								var quartz_name = $(this).find("QUARTZ_NAME").text();
								var status_cd = $(this).find("STATUS_CD").text();
								var status_log = $(this).find("STATUS_LOG").text();
								var trace_log_path = $(this).find('TRACE_LOG_PATH').text();
								var ins_date = $(this).find("INS_DATE").text();
								
								if(status_cd == "1"){
									status_cd = "OK";
								}else {
									status_cd = "FAIL";
								}
								
								//파일명
								var arr_path = trace_log_path.split("/");
								var filenm = arr_path[arr_path.length-2];
								var trace_log_file = filenm+"_"+replaceAll(ins_date,"/","").substring(0,8);
								
								rowsObj.push({
									'grid_idx'			: i+1
									,'QUARTZ_NAME'		: quartz_name
									,'STATUS_CD'		: status_cd
									,'STATUS_LOG'		: status_log
									,'TRACE_LOG_FILE'	: trace_log_file
									,'TRACE_LOG_PATH'	: trace_log_path
									,'INS_DATE'			: ins_date
									,'LOG_VIEW'			: "[조회]"
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
	
	function popupLongLog(row) {
		var sHtml1="<div id='dl_tmp2' style='border-top:1px solid blue;border-bottom:1px solid blue;border-left:1px solid blue;border-right:1px solid blue;'>";
		sHtml1+="<textarea name='content' id='content' style='width:98%;height:97%;resize:none;' readOnly></textarea>";
		sHtml1+="</div>";
		
		$('#dl_tmp2').remove();
		$('body').append(sHtml1);
		
		dlPop01('dl_tmp2', "결과메세지", 600, 400, false);

		var obj = $("#g_tmp1").data('gridObj');
		var status_log = getCellValue(obj,row,'STATUS_LOG');
		$("#content").val(status_log);
	}
	
	function popupLogView(trace_log_file, trace_log_path) {
		
		if(dlMap.containsKey('dl_p01')) dlClose('dl_p01');
		$('#if_p01').width(1400).height(600);
		dlPopIframe01('dl_p01','로그조회',$('#if_p01').width(),$('#if_p01').height(),true,true,true);
		
		dlFrontView('dl_p01');
		setTimeout(function(){
			var frm = document.frm2;
			frm.trace_log_file.value = trace_log_file;
			frm.trace_log_path.value = trace_log_path;
			frm.target = "if_p01";
			frm.action = "<%=sContextPath %>/mPopup.ez?c=ezQuartzLogView";
			frm.submit();
		}, 300);
	}

</script>
