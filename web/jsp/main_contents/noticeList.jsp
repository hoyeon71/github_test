<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/jsp/common/inc/header.jsp"%>

<%
	Map<String, Object> paramMap = CommonUtil.collectParameters(request);
	String c = CommonUtil.isNull(paramMap.get("c"));
	String gridId = "g_"+c;
	
	String menu_gb = CommonUtil.getMessage("CATEGORY.GB.06.GB."+CommonUtil.isNull(paramMap.get("menu_gb")));
	String[] arr_menu_gb = menu_gb.split(",");
%>
<style type="text/css">
<!--

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
	width:50px;
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

//-->
</style>
<form id="f_s" name="f_s" method="post" onsubmit="return false;">	
	<input type="hidden" name="p_search_gubun" id="p_search_gubun"/>
	<input type="hidden" name="p_search_text" id="p_search_text"/>
	<input type="hidden" name="p_s_date" id="p_s_date" />
	<input type="hidden" name="p_e_date" id="p_e_date" />
</form>
<form id="frm1" name="frm1" method="post" onsubmit="return false;">
	<input type="hidden" name="flag" id="flag" />
	<input type="hidden" name="board_cd" id="board_cd" />
</form>

<table style='width:100%;height:100%;border:none;'>
	<tr style='height:10px;'>
		<td style='vertical-align:top;'>
			<h4 class="ui-widget-header ui-corner-all"  >
				<div id='t_<%=gridId %>' class='title_area' >
					<span><%=CommonUtil.isNull(CommonUtil.getMessage("CATEGORY.GB.06"))%> > <%=arr_menu_gb[0] %></span>
				</div>
			</h4>
		</td>
	</tr>
	<tr style='height:10px;'>
		<td style='vertical-align:top;'>		
			<h4 class="ui-widget-header ui-corner-all">
			<table style='width:100%;'>
				<tr>
					<th width="10%"><div class='cellTitle_kang2' style='min-width:50px;'>일자</div></th>
					<td width="35%" style='min-width:250px;'>
						<div class='cellContent_kang'>&nbsp;							
							<input type="text" name="s_date" id="s_date" value="${S_DATE}" class="input datepick" style="width:75px; height:21px;" maxlength="8" />
							&nbsp;~&nbsp;
							<input type="text" name="e_date" id="e_date" value="${E_DATE}" class="input datepick" style="width:75px; height:21px;" maxlength="8" />
						</div>						
					</td>
					
					<th width="10%"><div class='cellTitle_kang2' style='min-width:100px;'>검색구분</div></th>
					<td width="35%" style='min-width:300px;'>
						<div class='cellContent_kang'>&nbsp;
							<select name="search_gubun" id="search_gubun" style="width:120px ;height:21px;">
								<option value="title">제목</option>
								<option value="content">내용</option>							
							</select>&nbsp;
							<input type="text" name="search_text" value="" id="search_text" style="width:150px; height:21px;" />
						</div>						
					</td>
					
					<td style="text-align:right" colspan="4">
						<span id="btn_search" style='display:none;margin:3px;'>검 색</span>
					</td>
				</tr>
			</table>
			</h4>			
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
					<span id="btn_insert">추가</span>
					<span id="btn_update">수정</span>
					<span id="btn_delete">삭제</span>
				</div>
			</h4>
		</td>
	</tr>
</table>
<script>

	function gridCellCustomFormatter(row,cell,value,columnDef,dataContext){
		
		var ret = "";
		var board_cd = getCellValue(gridObj,row,'BOARD_CD');
	
		if(columnDef.id == 'TITLE'){			
			ret = "<a href=\"JavaScript:noticeUpdate('"+board_cd+"');\" /><font color='red'>"+value+"</font></a>";			
		}
		
		return ret;
	}

	var gridObj = {
		id : "<%=gridId %>"
		,colModel:[
	   		{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'번호',width:50,minWidth:50,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	   		,{formatter:gridCellCustomFormatter,field:'TITLE',id:'TITLE',name:'제목',width:250,minWidth:250,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}	 
	   		,{formatter:gridCellNoneFormatter,field:'STATUS',id:'STATUS',name:'노출여부',width:80,minWidth:80,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'SEQ',id:'SEQ',name:'노출순서',width:80,minWidth:80,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'INS_DATE',id:'INS_DATE',name:'등록일',width:130,minWidth:130,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}	   		
	   			   			   			   		
	   		,{formatter:gridCellNoneFormatter,field:'BOARD_CD',id:'BOARD_CD',name:'BOARD_CD',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}	   		
	   	]
		,rows:[]
		,vscroll: <%=S_GRID_VSCROLL%>
	};
	
	$(document).ready(function(){

		viewGridChk_1(gridObj,"ly_"+gridObj.id,{enableColumnReorder:true},'AUTO');
		setTimeout(function(){
			noticeList();
		}, 1000);

		
		$("#btn_search").button().unbind("click").click(function(){
			if ( $("#s_date").val() != "" && $("#e_date").val() != "" ) {
				
				// 날짜 기간 체크
				if ( $("#s_date").val() > $("#e_date").val() ) {
					alert("일자의 FROM ~ TO를 확인해 주세요.");
					return;
				}
				
				// 날짜 정합성 체크
				if(!isValidDate($("#s_date").val()) || !isValidDate($("#e_date").val())){ 
					alert("잘못된 날짜입니다."); 
					return;
				}
			}
			
			noticeList();
		});
		
		$('#search_text').unbind('keypress').keypress(function(e){
			if(e.keyCode==13){
			
				noticeList();
			}
		});
		
		$("#btn_insert").button().unbind("click").click(function(){
			noticeInsert();
		});
		$("#btn_update").button().unbind("click").click(function(){
			
			var cnt = 0;
			var board_cd = "";
			
			var aSelRow = new Array;
			aSelRow = $('#'+gridObj.id).data('grid').getSelectedRows();
			if(aSelRow.length>0){
				for(var i=0;i<aSelRow.length;i++){
					board_cd = getCellValue(gridObj,aSelRow[i],'BOARD_CD');
					
					++cnt;
				}
				
				if(cnt > 1){
					alert("한개의 내용만 선택해 주세요.");
					return;
				}else{
					noticeUpdate(board_cd);
				}
				
			}else{
				alert("수정하려는 내용을 선택해 주세요.");
				return;
			}		
			
		});
		$("#btn_delete").button().unbind("click").click(function(){
			
			var board_cd = "";
			var aSelRow = new Array;
			aSelRow = $('#'+gridObj.id).data('grid').getSelectedRows();
			if(aSelRow.length>0){
				for(var i=0;i<aSelRow.length;i++){
					
					if(i > 0) board_cd += "|";
					board_cd += getCellValue(gridObj,aSelRow[i],'BOARD_CD');										
				}			
				
			}else{
				alert("삭제 하려는 내용을 선택해 주세요.");
				return;
			}
			
			noticeDelete(board_cd);
			clearGridSelected(gridObj);
		});
		
		$("#s_date").addClass("text_input").unbind('click').click(function(){
			dpCalMin(this.id,'yymmdd');
		});
		
		$("#e_date").addClass("text_input").unbind('click').click(function(){
			dpCalMax(this.id,'yymmdd');
		});
		
	});
	
	function noticeList(){
		
		var gb = $("select[name='search_gubun'] option:selected").val();
		var word = $("input[name='search_text']").val();
		var s_date = $("input[name='s_date']").val();
		var e_date = $("input[name='e_date']").val();
		
		$("#f_s").find("input[name='p_search_gubun']").val(gb);
		$("#f_s").find("input[name='p_search_text']").val(word);
		$("#f_s").find("input[name='p_s_date']").val(s_date);
		$("#f_s").find("input[name='p_e_date']").val(e_date);
		
		try{viewProgBar(true);}catch(e){}
		$('#ly_total_cnt').html('');
		
		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=noticeList&itemGubun=2';
		
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
							
								var board_cd 	= $(this).find("BOARD_CD").text();
								var title 		= $(this).find("TITLE").text();
								var status 		= $(this).find("STATUS").text();
								var ins_date 	= $(this).find("INS_DATE").text();
								var seq 		= $(this).find("SEQ").text();
								var v_status 	= "";
								
								if(status == "01"){
									v_status = "노출";
								}else if(status == "02"){
									v_status = "미노출";
								}
								
								rowsObj.push({
									'grid_idx':i+1
									,'BOARD_CD': board_cd
									,'TITLE': title
									,'STATUS': v_status
									,'INS_DATE': ins_date
									,'SEQ': seq
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
	
	function noticeInsert(){
		
		var sHtml="<div id='dl_tmp1' style='overflow:hidden;display:none;padding:0;border-top:1px solid blue;border-bottom:1px solid blue;border-left:1px solid blue;border-right:1px solid blue;'>";
		sHtml+="<form id='form1' name='form1' method='post' onsubmit='return false;' enctype='multipart/form-data'>";
		sHtml+="<input type='hidden' name='flag' id='flag'/>";		
		sHtml+="<input type='hidden' name='board_gb' id='board_gb' value='01' />";
		sHtml+="<table style='width:100%;height:495px;border:none;'>";
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
		hTmp1 += "<div class='cellTitle_1'>제목</div>";
		hTmp2 += "<div class='cellContent_1'><input type='text' name='title' id='title' style='width:100%;border:0px none;'/></div>";
		hTmp1 += "<div class='cellTitle_1' style='height:150px;'>내용</div>";
		hTmp2 += "<div class='cellContent_1' style='height:150px;'><textarea name='content' id='content' style='width:100%; height:140px;'></textarea></div>";
		hTmp1 += "<div class='cellTitle_1'>첨부파일</div>";
		hTmp2 += "<div class='cellContent_1'><div class='filebox'><input type='text' name='file_nm' id='file_nm' style='width:85%;border:0px none;' readOnly/><label for='files'>파일선택</label><input type='file' name='files' id='files' /></div></div>";
		hTmp1 += "<div class='cellTitle_1'>노출여부</div>";
		hTmp2 += "<div class='cellContent_1'>";
		hTmp2 += "<select name='status' id='status' style='width:100px'>";
		hTmp2 += "<option value='01'>노출</option>";
		hTmp2 += "<option value='02'>비노출</option>";
		hTmp2 += "</select>";
		hTmp2 += "</div>";
		hTmp1 += "<div class='cellTitle_1'>노출순서</div>";
		hTmp2 += "<div class='cellContent_1'><input type='text' name='seq' id='seq' style='width:20%;border:1px none;'/></div>";
		hTmp1 += "<div class='cellTitle_1'>팝업여부</div>";
		hTmp2 += "<div class='cellContent_1'>";
		hTmp2 += "<select name='popup_yn' id='popup_yn' style='width:100px'>";
		hTmp2 += "<option value='N'>N</option>";
		hTmp2 += "<option value='Y'>Y</option>";
		hTmp2 += "</select>";
		hTmp2 += "</div>";
		hTmp1 += "<div class='cellTitle_1'>팝업기간</div>";
		hTmp2 += "<div class='cellContent_1'>";
		hTmp2 += "<input type='text' name='popup_s_date' id='popup_s_date' class='input datepick' style='width:75px; height:21px;' readOnly>&nbsp;&nbsp; ~ &nbsp;&nbsp;";
		hTmp2 += "<input type='text' name='popup_e_date' id='popup_e_date' class='input datepick' style='width:75px; height:21px;' readOnly>";
		hTmp2 += "</div>";
		
		headerObj.push({name:hTmp1,id_s:'c_1',id_e:'c_1'});
		headerObj.push({name:hTmp2,id_s:'c_2',id_e:'c_2'});
		var gridObj_s = {
			id : "g_tmp1"
			,colModel:[
		  		{formatter:gridCellNoneFormatter,field:'c_1',id:'c_1',name:'구 분',width:80,headerCssClass:'cellCenter',cssClass:'cellCenter'}
				,{formatter:gridCellNoneFormatter,field:'c_2',id:'c_2',name:'내 용',width:380,headerCssClass:'cellCenter',cssClass:'cellLeft'}
			   	
		   		,{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'grid_idx',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
		   	]
			,rows:[]
			,headerRowHeight:480
			,colspan:headerObj
			,vscroll:<%=S_GRID_VSCROLL%>
		};
		
		viewGrid_1(gridObj_s,'ly_'+gridObj_s.id);
		
		dlPop01('dl_tmp1', "공지사항등록", 465, 405, false);
		
		$("#files").change(function(){
			$("#file_nm").val($(this).val());
		});
		
		$("#popup_s_date").addClass("ime_readonly").unbind('click').click(function(){
			dpCalMin(this.id,'yymmdd');
		});
		
		$("#popup_e_date").addClass("ime_readonly").unbind('click').click(function(){
			dpCalMax(this.id,'yymmdd');
		});
		
		$("#btn_ins").button().unbind("click").click(function(){
			
			if(isNullInput($('#form1 #title'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[제목]","") %>')) return false;
			if(isNullInput($('#form1 #content'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[내용]","") %>')) return false;
			
			// 노출순서 값 없을 경우 0으로 강제 셋팅
			var seq = $("#seq").val();
	        if (seq==null||seq=="") $("#seq").val(0);
			
			if(confirm("해당 내용을 등록 하시겠습니까?")){
				var f = document.form1;
				
				try{viewProgBar(true);}catch(e){}
				
				f.flag.value = "ins";
				f.target = "if1";				
				f.action = "<%=sContextPath %>/common.ez?c=ezBoardPrc"; 
				f.submit();
				
				try{viewProgBar(false);}catch(e){}
				
				dlClose('dl_tmp1');
			}
		});
	}
	
	function noticeUpdate(board_cd){
		
		try{viewProgBar(true);}catch(e){}
				
		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=noticeDetail&itemGubun=2&board_gb=01&board_cd='+board_cd;
		
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
						
						var title 			= "";
						var content 		= "";
						var status 			= "";
						var file_nm 		= "";
						var seq				= "";
						var popup_yn		= "";
						var popup_s_date	= "";
						var popup_e_date	= "";
						
						var h 		= 0;
						var h2 		= 0;
						
						if(items.attr('cnt')=='0'){
						}else{
							items.find('item').each(function(i){						
															
								title 			= $(this).find("TITLE").text();
								content 		= $(this).find("CONTENT").text();
								status 			= $(this).find("STATUS").text();
								file_nm 		= $(this).find("FILE_NM").text();
								seq 			= $(this).find("SEQ").text();
								popup_yn 		= $(this).find("POPUP_YN").text();
								popup_s_date 	= $(this).find("POPUP_S_DATE").text();
								popup_e_date 	= $(this).find("POPUP_E_DATE").text();
							});						
						}
						
						if(file_nm != ""){
							h = 420;
							h2 = 520;
						}else{
							h = 405;	
							h2 = 500;
						}
						
						var sHtml="<div id='dl_tmp1' style='overflow:hidden;display:none;padding:0;border-top:1px solid blue;border-bottom:1px solid blue;border-left:1px solid blue;border-right:1px solid blue;'>";
						sHtml+="<form id='form1' name='form1' method='post' onsubmit='return false;' enctype='multipart/form-data'>";
						sHtml+="<input type='hidden' name='flag' id='flag'/>";		
						sHtml+="<input type='hidden' name='board_gb' id='board_gb' value='01' />";	
						sHtml+="<input type='hidden' name='board_cd' id='board_cd' value='"+board_cd+"' />";		
						sHtml+="<table style='width:100%;height:"+h2+"px;border:none;'>";
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
						hTmp1 += "<div class='cellTitle_1'>제목</div>";
						hTmp2 += "<div class='cellContent_1'><input type='text' name='title' id='title' style='width:100%;border:0px none;'/></div>";
						hTmp1 += "<div class='cellTitle_1' style='height:150px;'>내용</div>";
						hTmp2 += "<div class='cellContent_1' style='height:150px;'><textarea name='content' id='content' style='width:100%; height:140px;'></textarea></div>";
						
						if(file_nm != ""){
							hTmp1 += "<div class='cellTitle_1' style='height:50px;'>첨부파일</div>";
							hTmp2 += "<div class='cellContent_1' style='white-space:normal;height:50px;'><div id='filelink'><a href='javascript:download("+board_cd+");'>"+file_nm+"</a>&nbsp;<img id='btn_clear' src='/images/sta2.png' style='width:16px;height:16px;vertical-align:middle;cursor:pointer;'/></div><div class='filebox'><input type='text' name='file_nm' id='file_nm' style='width:85%;border:1px;' readOnly/><label for='files'>파일선택</label><input type='file' name='files' id='files' /></div></div>";
							hTmp2 += "<input type='hidden' name='attach_file' id='attach_file' value='"+file_nm+"'/>";
							hTmp2 += "<input type='hidden' name='del_file' id='del_file' value=''/>";
						}else{
							hTmp1 += "<div class='cellTitle_1'>첨부파일</div>";
							hTmp2 += "<div class='cellContent_1'><div class='filebox'><input type='text' name='file_nm' id='file_nm' style='width:85%;border:0px none;' readOnly/><label for='files'>파일선택</label><input type='file' name='files' id='files' /></div></div>";
						}
						hTmp1 += "<div class='cellTitle_1'>노출여부</div>";
						hTmp2 += "<div class='cellContent_1'>";
						hTmp2 += "<select name='status' id='status'>";
						hTmp2 += "<option value='01'>노출</option>";
						hTmp2 += "<option value='02'>비노출</option>";
						hTmp2 += "</select>";
						hTmp2 += "</div>";
						hTmp1 += "<div class='cellTitle_1'>노출순서</div>";
						hTmp2 += "<div class='cellContent_1'><input type='text' name='seq' id='seq' style='width:20%;border:1px none;'/></div>";
						hTmp1 += "<div class='cellTitle_1'>팝업여부</div>";
						hTmp2 += "<div class='cellContent_1'>";
						hTmp2 += "<select name='popup_yn' id='popup_yn' style='width:100px'>";
						hTmp2 += "<option value='N'>N</option>";
						hTmp2 += "<option value='Y'>Y</option>";
						hTmp2 += "</select>";
						hTmp2 += "</div>";
						hTmp1 += "<div class='cellTitle_1'>팝업기간</div>";
						hTmp2 += "<div class='cellContent_1'>";
						hTmp2 += "<input type='text' name='popup_s_date' id='popup_s_date' class='input datepick' style='width:75px; height:21px;' readOnly>&nbsp;&nbsp; ~ &nbsp;&nbsp;";
						hTmp2 += "<input type='text' name='popup_e_date' id='popup_e_date' class='input datepick' style='width:75px; height:21px;' readOnly>";
						hTmp2 += "</div>";
						
						headerObj.push({name:hTmp1,id_s:'c_1',id_e:'c_1'});
						headerObj.push({name:hTmp2,id_s:'c_2',id_e:'c_2'});
						
						var gridObj_s = {
							id : "g_tmp1"
							,colModel:[
						  		{formatter:gridCellNoneFormatter,field:'c_1',id:'c_1',name:'구 분',width:80,headerCssClass:'cellCenter',cssClass:'cellCenter'}
								,{formatter:gridCellNoneFormatter,field:'c_2',id:'c_2',name:'내 용',width:500,headerCssClass:'cellCenter',cssClass:'cellLeft'}
							   	
						   		,{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'grid_idx',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
						   	]
							,rows:[]
							,headerRowHeight:480
							,colspan:headerObj
							,vscroll:<%=S_GRID_VSCROLL%>
						};
						
						viewGrid_1(gridObj_s,'ly_'+gridObj_s.id);
						
						dlPop01('dl_tmp1', "공지사항수정", 580, h, false);
						
						$("#title").val(title);
						$("#content").val(content);
						$("select[name='status']").val(status);
						
						$("#files").change(function(){
							if(file_nm != ""){
								$("#del_file").val(file_nm);
							}
							$("#file_nm").val($(this).val());
						});
						
						$("#seq").val(seq);
						$("#popup_yn").val(popup_yn);
						$("#popup_s_date").val(popup_s_date);
						$("#popup_e_date").val(popup_e_date);
						
						$("#popup_s_date").addClass("ime_readonly").unbind('click').click(function(){
							dpCalMin(this.id,'yymmdd');
						});
						
						$("#popup_e_date").addClass("ime_readonly").unbind('click').click(function(){
							dpCalMax(this.id,'yymmdd');
						});
						$("#btn_clear").unbind('click').click(function(){
							$("#filelink").hide();
							$("#attach_file").val("");
						});
						
						$("#btn_ins").button().unbind("click").click(function(){
							
							if(isNullInput($('#form1 #title'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[제목]","") %>')) return false;
							if(isNullInput($('#form1 #content'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[내용]","") %>')) return false;
							
							// 노출순서 값 없을 경우 0으로 강제 셋팅
							var seq = $("#seq").val();
					        if (seq==null||seq=="") $("#seq").val(0);
													
							if(confirm("해당 내용을 수정 하시겠습니까?")){
								var f = document.form1;
								
								try{viewProgBar(true);}catch(e){}
								
								f.flag.value = "udt";
								f.target = "if1";
								f.file_nm.value = $("#attach_file").val();
								f.action = "<%=sContextPath %>/common.ez?c=ezBoardPrc"; 
								f.submit();
								
								try{viewProgBar(false);}catch(e){}
								
								dlClose('dl_tmp1');
							}
						});
						
						
					});
					try{viewProgBar(false);}catch(e){}
				}
		, null );
		
		xhr.sendRequest();
	}
	
	function noticeDelete(board_cd){
		var f = document.frm1;
		
		try{viewProgBar(true);}catch(e){}
		
		if(confirm("선택된 내용을 삭제 하시겠습니까?")){
			f.flag.value = "del";
			f.board_cd.value = board_cd;
			f.target = "if1";				
			f.action = "<%=sContextPath %>/common.ez?c=ezBoardPrc"; 
			f.submit();
		}
		try{viewProgBar(false);}catch(e){}
	}
	
	function download(board_cd){
		
		var f = document.form1;		
		
		f.flag.value = "board";
		f.target = "if1";				
		f.action = "<%=sContextPath %>/common.ez?c=fileDownload"; 
		f.submit();
	
	}
</script>
