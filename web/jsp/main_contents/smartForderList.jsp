<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/jsp/common/inc/header.jsp"%>

<%
	Map<String, Object> paramMap = CommonUtil.collectParameters(request);
	String c = CommonUtil.isNull(paramMap.get("c"));
	String gridId = "g_"+c;
	String gridId_1 = "g_"+c+"_1";
	String gridId_2 = "g_"+c+"_2";
	String gridId_3 = "g_"+c+"_3";
	
	String menu_gb = CommonUtil.getMessage("CATEGORY.GB.06.GB."+CommonUtil.isNull(paramMap.get("menu_gb")));
	String[] arr_menu_gb = menu_gb.split(",");
%>

<form id="frm1" name="frm1" method="post" onsubmit="return false;">
	<input type="hidden" name="flag" 		id="flag" />
	<input type="hidden" name="task_type" 	id="task_type" />
	<input type="hidden" name="doc_cd" 		id="doc_cd" />
	<input type="hidden" name="job_name" 	id="job_name" />
	<input type="hidden" name="data_center" id="data_center" />
</form>

<form id="frm7" name="frm7" method="post" onsubmit="return false;">	
	<input type="hidden" name="flag" id="flag" />
	<input type="hidden" name="grp_cd" id="grp_cd" />
	<input type="hidden" name="scode_cd" id="scode_cd" />
	<input type="hidden" name="grp_depth" id="grp_depth" />
	<input type="hidden" name="grp_parent_cd" id="grp_parent_cd" />
</form>

<table style='width:100%;height:100%;border:none;'>
	<tr style='height:10px;'>
		<td colspan='3' style='vertical-align:top;'>
			<h4 class="ui-widget-header ui-corner-all"  >
				<div id='t_<%=gridId %>' class='title_area' >
					<span><%=CommonUtil.isNull(arr_menu_gb[0]) %></span>
				</div>
			</h4>
		</td>
	</tr>
	
	<tr style='height:10px;'>
		<td colspan='3' style='vertical-align:top;'>
			<form name="f_s" id="f_s" method="post" onsubmit="return false;">
			<input type="hidden" name="grp_cd" id="grp_cd" />
			<input type="hidden" name="grp_parent_cd" id="grp_parent_cd"/>
			<h4 class="ui-widget-header ui-corner-all">
				<table style='width:100%;'>
					<tr>
						<th width="10%"><div class='cellTitle_kang2'><b>C-M</b> :</div></th> 
						<td>	
							<select name="main_grp_nm" id="main_grp_nm" style="height:21px; width:150px">
								<option value="">--선택--</option>
								<c:forEach var="scodeGrpList" items="${SCODE_GRP_LIST}" varStatus="status">
									<option value="${scodeGrpList.scode_cd}" data="${scodeGrpList.scode_eng_nm}">${scodeGrpList.scode_nm}</option>
								</c:forEach>
							</select>
						</td>
					</tr>
					<tr>
						<th width="10%"><div class='cellTitle_kang2'>스마트폴더명</div></th>
						<td width="23%" style="text-align:left">
							<div class='cellContent_kang'>
								<input type="text" name="s_forder_text" value="" id="s_forder_text" class="input" style="width:250px; height:21px;" />
								&nbsp;<img id="btn_clear2" src="/images/sta2.png" style="width:16px;height:16px;vertical-align:middle;cursor:pointer;"/>
							</div>
						</td>					
						<td colspan="1" style="text-align:right">
							<div align='right' class='btn_area'>
								<span id="btn_search" style='display:none;margin:3px;'>검 색</span>
							</div>
						</td>
					</tr>
				</table>
			</h4>
			</form>
		</td>
	</tr>
	<tr>
		<td style='width:31%;'>
			<table style="width:100%;height:100%;border:none;">
				<tr>
					<td id='ly_<%=gridId_1 %>' style='vertical-align:top;' >
						<div id="<%=gridId_1 %>" class="ui-widget-header ui-corner-all" ></div>
					</td>
				</tr>
				<tr style='height:10px;'>
					<td style='vertical-align:top;'>
						<h4 class="ui-widget-header ui-corner-all" >
							<div align='right' class='btn_area' >
								<div id='ly_total_cnt' style='padding-top:5px;float:left;'></div>		
								<span id="btn_add">추가</span>
								<span id="btn_edit">수정</span>	
								<span id="btn_delete">삭제</span>		
							</div>
						</h4>
					</td>
				</tr>
			</table>
		</td>
		<td style='width:31%;'>
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
								<span id="btn_app_add">추가</span>
								<span id="btn_app_edit">수정</span>
								<span id="btn_app_del">삭제</span>
							</div>
						</h4>
					</td>
				</tr>
			</table>			
		</td>
		<td style="width:34%">
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
		var scode_cd = getCellValue(gridObj_1,row,'SCODE_CD');
		
		if(columnDef.id == 'PARENT_TALBE'){
			ret = "<a href=\"JavaScript:getAppCodeList('"+scode_cd+"','4','"+value+"','"+value+"');\" /><font color='red'>"+value+"</font></a>";
		}
						
		return ret;
	}
	
	function gridCellCustomFormatter2(row,cell,value,columnDef,dataContext){
		
		var ret = "";
		var grp_cd = getCellValue(gridObj_2,row,'GRP_CD');
		var grp_nm = getCellValue(gridObj_2,row,'GRP_NM');
		var scode_cd = getCellValue(gridObj_2,row,'SCODE_CD');
		var grp_depth = getCellValue(gridObj_2,row,'GRP_DEPTH');
				
		if(columnDef.id == 'GRP_NM'){
			ret = "<a href=\"JavaScript:getSubCodeList('"+scode_cd+"','5','"+grp_cd+"','"+grp_nm+"');\" /><font color='red'>"+value+"</font></a>";
		}
						
		return ret;
	}
	
	var gridObj_1 = {
		id : "<%=gridId_1 %>"
		,colModel:[
	   		{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'번호',width:50,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	   		,{formatter:gridCellCustomFormatter,field:'PARENT_TALBE',id:'PARENT_TALBE',name:'스마트폴더명',width:150,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'JOBS_IN_GROUP',id:'JOBS_IN_GROUP',name:'작업 수',width:50,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'USER_DAILY',id:'USER_DAILY',name:'ORDER_METHOD',width:100,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'SYNC_MSG',id:'SYNC_MSG',name:'CHECKED_OUT_BY',width:100,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'SYNC_STATE',id:'SYNC_STATE',name:'SYNC_STATE',width:100,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'SYNC_MSG',id:'SYNC_MSG',name:'SYNC_MSG',width:150,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'LAST_UPLOAD',id:'LAST_UPLOAD',name:'LAST_UPLOAD',width:150,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
	   		
	   		,{formatter:gridCellNoneFormatter,field:'DOC_CD',id:'DOC_CD',name:'DOC_CD',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   		,{formatter:gridCellNoneFormatter,field:'JOB_NAME',id:'JOB_NAME',name:'JOB_NAME',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   		,{formatter:gridCellNoneFormatter,field:'DATA_CENTER',id:'DATA_CENTER',name:'DATA_CENTER',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   		,{formatter:gridCellNoneFormatter,field:'SCODE_CD',id:'SCODE_CD',name:'SCODE_CD',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   	]
		
		,rows:[]
		,vscroll:<%=S_GRID_VSCROLL%>
	};
	var gridObj_2 = {
		id : "<%=gridId_2 %>"
		,colModel:[
	   		{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'번호',width:50,headerCssClass:'cellCenter',cssClass:'cellCenter'}
	   		,{formatter:gridCellCustomFormatter2,field:'GRP_NM',id:'GRP_NM',name:'어플리케이션(한글)',width:150,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}	
	   		,{formatter:gridCellNoneFormatter,field:'GRP_ENG_NM',id:'GRP_ENG_NM',name:'어플리케이션(영문)',width:150,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}	
	   		,{formatter:gridCellNoneFormatter,field:'GRP_DESC',id:'GRP_DESC',name:'설명',width:150,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}	
	   		
	   		,{formatter:gridCellNoneFormatter,field:'GRP_CD',id:'GRP_CD',name:'GRP_CD',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   		,{formatter:gridCellNoneFormatter,field:'SCODE_CD',id:'SCODE_CD',name:'SCODE_CD',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   		,{formatter:gridCellNoneFormatter,field:'GRP_DEPTH',id:'GRP_DEPTH',name:'GRP_DEPTH',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   		,{formatter:gridCellNoneFormatter,field:'GRP_USE_YN',id:'GRP_USE_YN',name:'GRP_USE_YN',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   		,{formatter:gridCellNoneFormatter,field:'GRP_PARENT_CD',id:'GRP_PARENT_CD',name:'GRP_PARENT_CD',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   	]
		,rows:[]
		,vscroll:<%=S_GRID_VSCROLL%>
	};
	
	var gridObj_3 = {
		id : "<%=gridId_3 %>"
		,colModel:[
	   		{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'번호',width:50,headerCssClass:'cellCenter',cssClass:'cellCenter'}
	   		,{formatter:gridCellNoneFormatter,field:'GRP_NM',id:'GRP_NM',name:'그룹(한글)',width:150,headerCssClass:'cellCenter',cssClass:'cellLeft'}	
	   		,{formatter:gridCellNoneFormatter,field:'GRP_ENG_NM',id:'GRP_ENG_NM',name:'그룹(영문)',width:150,headerCssClass:'cellCenter',cssClass:'cellLeft'}	
	   		,{formatter:gridCellNoneFormatter,field:'HOST_NM',id:'HOST_NM',name:'수행서버',width:150,headerCssClass:'cellCenter',cssClass:'cellLeft'}
	   		,{formatter:gridCellNoneFormatter,field:'GRP_DESC',id:'GRP_DESC',name:'설명',width:150,headerCssClass:'cellCenter',cssClass:'cellLeft'}	
	   		
	   		,{formatter:gridCellNoneFormatter,field:'GRP_CD',id:'GRP_CD',name:'GRP_CD',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   		,{formatter:gridCellNoneFormatter,field:'SCODE_CD',id:'SCODE_CD',name:'SCODE_CD',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   		,{formatter:gridCellNoneFormatter,field:'GRP_DEPTH',id:'GRP_DEPTH',name:'GRP_DEPTH',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   		,{formatter:gridCellNoneFormatter,field:'GRP_USE_YN',id:'GRP_USE_YN',name:'GRP_USE_YN',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   		,{formatter:gridCellNoneFormatter,field:'GRP_PARENT_CD',id:'GRP_PARENT_CD',name:'GRP_PARENT_CD',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   		,{formatter:gridCellNoneFormatter,field:'HOST_CD',id:'HOST_CD',name:'HOST_CD',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   		,{formatter:gridCellNoneFormatter,field:'HOST_DESC',id:'HOST_DESC',name:'HOST_DESC',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   	]
		,rows:[]
		,vscroll:<%=S_GRID_VSCROLL%>
	};
	
	$(document).ready(function(){
		
		$("#btn_search").show();
		
// 		viewGrid_1(gridObj,"ly_"+gridObj.id);
		viewGrid_1(gridObj_1,"ly_"+gridObj_1.id);
		viewGrid_1(gridObj_2,"ly_"+gridObj_2.id);
		viewGrid_1(gridObj_3,"ly_"+gridObj_3.id);
// 		sForderList();
		
		$("#btn_search").button().unbind("click").click(function(){
			
			var scode_cd = $("select[name='main_grp_nm'] option:selected").val();
			var data_center = scode_cd + ',' + $("select[name='main_grp_nm'] option:selected").attr("data");
			var forder = $("input[name='s_forder_text']").val();
			sForderList(data_center);
		});
		
		
		$("#btn_add").button().unbind("click").click(function(){
// 			sForderInsert();
			goPageInsert();
		});
		
		$("#btn_edit").button().unbind("click").click(function(){
			
			var cnt = 0;
			var table_id 	= "";
			var doc_cd	 	= "";
			var job_name 	= "";
			var aSelRow = new Array;
			aSelRow = $('#'+gridObj_1.id).data('grid').getSelectedRows();
						
			if(aSelRow.length>0){
				for(var j=0;j<aSelRow.length;j++){						
					doc_cd	 	= getCellValue(gridObj_1,aSelRow[j],'DOC_CD');	
					job_name 	= getCellValue(gridObj_1,aSelRow[j],'JOB_NAME');	
					
					++cnt;
				}
			}else{
				alert("수정 하려는 항목을 선택해 주세요.");
				return;
			}
			
			if(cnt > 1){
				alert("한개의 항목만 선택해 주세요.");
				return;
			}
			
// 			sForderUpdate(cal_cd);
			goPageUpdate(doc_cd, job_name);
		});
		
		$("#btn_delete").button().unbind("click").click(function(){
			
			var cnt = 0;
			var doc_cd			= "";
// 			var job_name 		= "";
			var data_center 	= "";
			var parent_table 	= "";
			
			var aSelRow = new Array;
			aSelRow = $('#'+gridObj_1.id).data('grid').getSelectedRows();
						
			if(aSelRow.length>0){
				for(var j=0;j<aSelRow.length;j++){						
					doc_cd			= getCellValue(gridObj_1,aSelRow[j],'DOC_CD');	
// 					job_name 		= getCellValue(gridObj_1,aSelRow[j],'JOB_NAME');	
					data_center 	= getCellValue(gridObj_1,aSelRow[j],'DATA_CENTER');
					parent_table	= getCellValue(gridObj_1,aSelRow[j],'PARENT_TALBE');
					
					++cnt;
				}
			}else{
				alert("삭제 하려는 항목을 선택해 주세요.");
				return;
			}
			
			if(cnt > 1){
				alert("한개의 항목만 선택해 주세요.");
				return;
			}
			
			if(confirm("선택된 항목을 삭제 하시겠습니까?")){
				
				var f = document.frm1;
			
				f.flag.value 		= "draft_i_admin";
				f.task_type.value	= "SMART Table";
				f.doc_cd.value 	 	= doc_cd;
				f.data_center.value = data_center;
// 				f.job_name.value 	= job_name;
// 				f.table_id.value 	= table_id;
				
				f.target = "if1";
<%-- 				f.action = "<%=sContextPath %>/tWorks.ez?c=ez004_p&doc_gb=03"; --%>
				f.action = "<%=sContextPath %>/tWorks.ez?c=ez004_p&doc_gb=03&title=test&table_name=" + parent_table;
				f.submit();
			}
		});
		
		$("#btn_app_add").button().unbind("click").click(function(){
			var scode_cd = $("select[name='main_grp_nm'] option:selected").val();
			
			if(scode_cd == ""){
				alert("C-M을 선택해 주세요.");
				return;
			}else{
				var grp_cd = $("#f_s").find("input[name='grp_cd']").val();
				if(grp_cd == ""){
					alert("테이블을 선택해 주세요.");
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
			codeDelete('4');
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
			codeDelete('5');
		});
		
		$("#btn_clear2").unbind("click").click(function(){
			$("input[name='s_forder_text']").val("");
		});
		
		$("#main_grp_nm").change(function(){
			
			var scode_cd = $("select[name='main_grp_nm'] option:selected").val();
			var data_center = scode_cd + ',' + $("select[name='main_grp_nm'] option:selected").attr("data");
			
			sForderList(data_center);		
		});
		
		
		$('#s_forder_text').unbind('keypress').keypress(function(e){			
			if(e.keyCode==13){	
				var scode_cd = $("select[name='main_grp_nm'] option:selected").val();
				var data_center = scode_cd + ',' + $("select[name='main_grp_nm'] option:selected").attr("data");
				
				if(scode_cd == ""){
					alert("C-M 을 선택해 주세요.");
					return;
				}
				sForderList(data_center);
			}
		});
	});	
	
	function sForderList(data_center){
		
		try{viewProgBar(true);}catch(e){}
		$('#ly_total_cnt').html('');
		
		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=sForderList&itemGubun=2&data_center=' + data_center;
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
								var parent_table 	= $(this).find("PARENT_TALBE").text();
								var user_daily 		= $(this).find("USER_DAILY").text();
								var used_by 		= $(this).find("USED_BY").text();
								var sync_state 		= $(this).find("SYNC_STATE").text();
								var sync_msg 		= $(this).find("SYNC_MSG").text();
								var last_upload 	= $(this).find("LAST_UPLOAD").text();
								var jobs_in_group 	= $(this).find("JOBS_IN_GROUP").text();
								var doc_cd 			= $(this).find("DOC_CD").text();
								var job_name 		= $(this).find("JOB_NAME").text();
								var data_center		= $(this).find("DATA_CENTER").text();
								var scode_cd		= data_center.split(",");
								rowsObj.push({
									'grid_idx'		: i+1
									,'PARENT_TALBE'	: parent_table
									,'USER_DAILY'	: user_daily
									,'USED_BY'		: used_by
									,'SYNC_STATE'	: sync_state
									,'SYNC_MSG'		: sync_msg
									,'LAST_UPLOAD'	: last_upload
									,'JOBS_IN_GROUP': jobs_in_group + '개'
									,'DOC_CD'		: doc_cd
									,'JOB_NAME'		: job_name
									,'DATA_CENTER'	: data_center
									,'SCODE_CD'		: scode_cd[0]
								});
							});			
						}
						
						gridObj_1.rows = rowsObj;
						setGridRows(gridObj_1);
						$('#ly_total_cnt').html('[ TOTAL : '+items.attr('cnt')+' ]');
						
					});
					try{viewProgBar(false);}catch(e){}
				}
		, null );
		
		xhr.sendRequest();
	}
	
	function getAppCodeList(scode_cd, grp_depth, grp_cd, grp_nm){
		
		$("#f_s").find("input[name='grp_cd']").val(grp_cd);
		
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
	
 	function getSubCodeList(scode_cd, grp_depth, grp_cd){
		
		$("#f_s").find("input[name='grp_parent_cd']").val(grp_cd);
		
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
							
								var grp_cd = $(this).find("GRP_CD").text();
								var grp_nm = $(this).find("GRP_NM").text();								
								var grp_eng_nm = $(this).find("GRP_ENG_NM").text();
								var grp_use_yn = $(this).find("GRP_USE_YN").text();
								var grp_desc = $(this).find("GRP_DESC").text();
								var scode_cd = $(this).find("SCODE_CD").text();
								var grp_depth = $(this).find("GRP_DEPTH").text();
								var grp_parent_cd = $(this).find("GRP_PARENT_CD").text();
								var host_cd = $(this).find("HOST_CD").text();
								var arr_host_cd = $(this).find("ARR_HOST_CD").text();
								var arr_host_nm = $(this).find("ARR_HOST_NM").text();
								var arr_host_desc = $(this).find("ARR_HOST_DESC").text();
								
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
 	
	function goPageInsert() {
			
			doc_name = "의뢰_스마트폴더";
			
			top.addTab('c', doc_name, '08', '0801', 'tWorks.ez?c=ez004_w_new&doc_gb=08');
			//top.closeTab(menu_tabId);
	}
	function goPageUpdate(doc_cd, job_name) {
		doc_name = "수정_스마트폴더";
		
		top.addTab('c', doc_name, '08', '0802', 'tWorks.ez?c=ez004_m&doc_gb=08&doc_cd='+doc_cd+'&job_name='+encodeURI(job_name));
		//top.closeTab(menu_tabId);
	}
	
	function codeAppInsert(scode_cd, grp_cd){
		
		var sHtml="<div id='dl_tmp1' style='overflow:hidden;display:none;padding:0;border-top:1px solid blue;border-bottom:1px solid blue;border-left:1px solid blue;border-right:1px solid blue;'>";
		sHtml+="<form id='frm2' name='frm2' method='post' onsubmit='return false;'>";
		sHtml+="<input type='hidden' name='flag' id='flag'/>";	
		sHtml+="<input type='hidden' name='scode_cd' id='scode_cd'/>";	
		sHtml+="<input type='hidden' name='grp_parent_cd' id='grp_parent_cd'/>";	
		sHtml+="<input type='hidden' name='grp_depth' id='grp_depth' value='4'/>";	
		sHtml+="<table style='width:100%;height:320px;border:none;'>";
		sHtml+="<tr><td style='vertical-align:top;height:90%;width:520px;' >";
		
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
		hTmp1 += "<div class='cellTitle_1'>어플리케이션명(한글)</div>";
		hTmp2 += "<div class='cellContent_1'><input type='text' name='grp_nm' id='grp_nm' style='width:100%;border:0px none;'/></div>";
		hTmp1 += "<div class='cellTitle_1'>어플리케이션명(영문)</div>";
		hTmp2 += "<div class='cellContent_1'><input type='text' name='grp_eng_nm' id='grp_eng_nm' style='width:100%;border:0px none;'/></div>";
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
				,{formatter:gridCellNoneFormatter,field:'c_2',id:'c_2',name:'내 용',width:375,headerCssClass:'cellCenter',cssClass:'cellLeft'}
			   	
		   		,{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'grid_idx',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
		   	]
			,rows:[]
			,headerRowHeight:230
			,colspan:headerObj
			,vscroll:<%=S_GRID_VSCROLL%>
		};
		
		viewGrid_1(gridObj_4,'ly_'+gridObj_4.id);
		
		dlPop01('dl_tmp1',"코드명 등록",505,265,false);
		
		$("#frm2").find("input[name='scode_cd']").val(scode_cd);
		$("#frm2").find("input[name='grp_parent_cd']").val(grp_cd);
		
		$("#btn_ins").button().unbind("click").click(function(){
			
			if(isNullInput($('#frm2 #grp_nm'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[코드명(한글)]","") %>')) return false;
			if(isNullInput($('#frm2 #grp_eng_nm'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[코드명(영문)]","") %>')) return false;
			if($("#frm2").find("select[name='host_cd']").val() == ""){
				alert('<%=CommonUtil.getMessageSplit("ERROR.PARAM.02","[수행서버]","") %>'); 
				return false;
			}
			
			var frm = document.frm2;
			if(confirm("해당 내용을 저장하시겠습니까?")){
				
				frm.flag.value = "ins";
				frm.target = "if1";
				frm.action = "<%=sContextPath %>/common.ez?c=ezAppGrp_p";
				frm.submit();
			}
			
			dlClose('dl_tmp1');
		});
	
	}
	
	function codeAppEdit(){
		
		var cnt = 0;
		var grp_cd = "";
		var grp_nm = "";
		var grp_eng_nm = "";
		var grp_use_yn = "";
		var grp_desc = "";
		var grp_parent_cd = "";
		var host_cd = "";
		var host_desc = "";
		
		var aSelRow = new Array;
		aSelRow = $('#'+gridObj_2.id).data('grid').getSelectedRows();
		if(aSelRow.length>0){
			for(var i=0;i<aSelRow.length;i++){
					
				if(i>0) grp_cd += "|";
				grp_cd += getCellValue(gridObj_2,aSelRow[i],'GRP_CD');
				
				if(i>0) grp_nm += "|";
				grp_nm += getCellValue(gridObj_2,aSelRow[i],'GRP_NM');
				
				if(i>0) grp_eng_nm += "|";
				grp_eng_nm += getCellValue(gridObj_2,aSelRow[i],'GRP_ENG_NM');
				
				if(i>0) grp_use_yn += "|";
				grp_use_yn += getCellValue(gridObj_2,aSelRow[i],'GRP_USE_YN');
				
				if(i>0) grp_desc += "|";
				grp_desc += getCellValue(gridObj_2,aSelRow[i],'GRP_DESC');
				
				if(i>0) grp_parent_cd += "|";
				grp_parent_cd += getCellValue(gridObj_2,aSelRow[i],'GRP_PARENT_CD');
				
				++cnt;
			}
			
			if(cnt > 1){
				alert("한개의 코드만 선택해 주세요.");
				return;
			}else{
				codeAppEdit2(grp_cd, grp_nm, grp_eng_nm, grp_use_yn, grp_desc, grp_parent_cd, host_cd, host_desc);
			}
			
		}else{
			alert("수정하려는 내용을 선택해 주세요.");
			return;
		}		
		
	}
	
	function codeAppEdit2(grp_cd, grp_nm, grp_eng_nm, grp_use_yn, grp_desc, grp_parent_cd, host_cd, host_desc){
		
		var scode_cd = $("select[name='main_grp_nm'] option:selected").val();
	
		var sHtml="<div id='dl_tmp1' style='overflow:hidden;display:none;padding:0;border-top:1px solid blue;border-bottom:1px solid blue;border-left:1px solid blue;border-right:1px solid blue;'>";
		sHtml+="<form id='frm5' name='frm5' method='post' onsubmit='return false;'>";
		sHtml+="<input type='hidden' name='flag' id='flag'/>";	
		sHtml+="<input type='hidden' name='grp_cd' id='grp_cd'/>";	
		sHtml+="<input type='hidden' name='scode_cd' id='scode_cd'/>";	
		sHtml+="<input type='hidden' name='grp_depth' id='grp_depth' value='4'/>";
		sHtml+="<input type='hidden' name='grp_parent_cd' id='grp_parent_cd' />";
		sHtml+="<input type='hidden' name='grp_parent_nm' id='grp_parent_nm' />";
		sHtml+="<table style='width:100%;height:275px;border:none;'>";
		sHtml+="<tr><td style='vertical-align:top;height:90%;width:490px;' >";
		
		sHtml+="<table style='width:100%;height:80%;border:none;'>";
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
		hTmp1 += "<div class='cellTitle_1'>어플리케이션명(한글)</div>";
		hTmp2 += "<div class='cellContent_1'><input type='text' name='grp_nm' id='grp_nm' style='width:100%;border:0px none;'/></div>";
		hTmp1 += "<div class='cellTitle_1'>어플리케이션명(영문)</div>";
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
		hTmp1 += "<div class='cellTitle_1' style='height:60px;'>설    명</div>";
		hTmp2 += "<div class='cellContent_1' style='height:60px;'><textarea name='grp_desc' id='grp_desc' style='width:99%;height:55px;border:0px none;'></textarea></div>";
	
		headerObj.push({name:hTmp1,id_s:'c_1',id_e:'c_1'});
		headerObj.push({name:hTmp2,id_s:'c_2',id_e:'c_2'});
		var gridObj_4 = {
			id : "g_tmp1"
			,colModel:[
		  		{formatter:gridCellNoneFormatter,field:'c_1',id:'c_1',name:'구 분',width:125,headerCssClass:'cellCenter',cssClass:'cellCenter'}
				,{formatter:gridCellNoneFormatter,field:'c_2',id:'c_2',name:'내 용',width:430,headerCssClass:'cellCenter',cssClass:'cellLeft'}
			   	
		   		,{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'grid_idx',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
		   	]
			,rows:[]
			,headerRowHeight:350
			,colspan:headerObj
			,vscroll:<%=S_GRID_VSCROLL%>
		};
		
		viewGrid_1(gridObj_4,'ly_'+gridObj_4.id);
		
		dlPop01('dl_tmp1',"코드명 수정",555,300,false);
		
		$("#frm5").find("input[name='scode_cd']").val(scode_cd);
		$("#frm5").find("input[name='grp_cd']").val(grp_cd);
		$("#frm5").find("input[name='grp_nm']").val(grp_nm);
		$("#frm5").find("input[name='grp_eng_nm']").val(grp_eng_nm);
		//$("#frm5").find("select[name='grp_use_yn'] option:selected").val(grp_use_yn);
		$("#frm5").find("textarea[name='grp_desc']").val(grp_desc);
		$("#frm5").find("input[name='grp_parent_cd']").val(grp_parent_cd);
				
		$("#btn_ins").button().unbind("click").click(function(){
			
			if(isNullInput($('#frm5 #grp_nm'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[어플리케이션명(한글)]","") %>')) return false;
			if(isNullInput($('#frm5 #grp_eng_nm'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[어플리케이션명(영문)]","") %>')) return false;
						
			var frm = document.frm5;
			if(confirm("해당 내용을 수정하시겠습니까?")){				
				frm.flag.value = "udt";
				frm.target = "if1";
				frm.action = "<%=sContextPath %>/common.ez?c=ezAppGrp_p";
				frm.submit();
			}
			
			dlClose('dl_tmp1');
		});
	}
	
	function codeSubInsert(scode_cd, grp_cd){
		
		var sHtml="<div id='dl_tmp1' style='overflow:hidden;display:none;padding:0;border-top:1px solid blue;border-bottom:1px solid blue;border-left:1px solid blue;border-right:1px solid blue;'>";
		sHtml+="<form id='frm3' name='frm3' method='post' onsubmit='return false;'>";
		sHtml+="<input type='hidden' name='flag' id='flag'/>";	
		sHtml+="<input type='hidden' name='scode_cd' id='scode_cd'/>";	
		sHtml+="<input type='hidden' name='grp_parent_cd' id='grp_parent_cd'/>";	
		sHtml+="<input type='hidden' name='grp_depth' id='grp_depth' value='5'/>";	
		sHtml+="<table style='width:100%;height:320px;border:none;'>";
		sHtml+="<tr><td style='vertical-align:top;height:90%;width:520px;' >";
		
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
		hTmp1 += "<div class='cellTitle_1'>그룹명(한글)</div>";
		hTmp2 += "<div class='cellContent_1'><input type='text' name='grp_nm' id='grp_nm' style='width:100%;border:0px none;'/></div>";
		hTmp1 += "<div class='cellTitle_1'>그룹명(영문)</div>";
		hTmp2 += "<div class='cellContent_1'><input type='text' name='grp_eng_nm' id='grp_eng_nm' style='width:100%;border:0px none;'/></div>";
		hTmp1 += "<div class='cellTitle_2'>수 행 서 버</div>";
		hTmp2 += "<div class='cellContent_2'>";
		hTmp2 += "<input type='hidden' name='host_cd' id='host_cd'>";
		hTmp2 += "<input type='text' name='host_nm' id='host_nm' style='width:80%;height:21px;' readOnly />&nbsp;";
		hTmp2 += "<span id='btn_host'>검색</span>";
		hTmp2 += "</div>";
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
				,{formatter:gridCellNoneFormatter,field:'c_2',id:'c_2',name:'내 용',width:375,headerCssClass:'cellCenter',cssClass:'cellLeft'}
			   	
		   		,{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'grid_idx',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
		   	]
			,rows:[]
			,headerRowHeight:230
			,colspan:headerObj
			,vscroll:<%=S_GRID_VSCROLL%>
		};
		
		viewGrid_1(gridObj_4,'ly_'+gridObj_4.id);
		
		dlPop01('dl_tmp1',"코드명 등록",505,265,false);
		
		$("#frm3").find("input[name='scode_cd']").val(scode_cd);
		$("#frm3").find("input[name='grp_parent_cd']").val(grp_cd);
		
		$("#btn_ins").button().unbind("click").click(function(){
			
			if(isNullInput($('#frm3 #grp_nm'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[코드명(한글)]","") %>')) return false;
			if(isNullInput($('#frm3 #grp_eng_nm'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[코드명(영문)]","") %>')) return false;
			if($("#frm3").find("select[name='host_cd']").val() == ""){
				alert('<%=CommonUtil.getMessageSplit("ERROR.PARAM.02","[수행서버]","") %>'); 
				return false;
			}
			
			var frm = document.frm3;
			if(confirm("해당 내용을 저장하시겠습니까?")){
				
				frm.flag.value = "ins";
				frm.target = "if1";
				frm.action = "<%=sContextPath %>/common.ez?c=ezAppGrp_p";
				frm.submit();
			}
			
			dlClose('dl_tmp1');
		});
		
		$("#btn_host").button().unbind("click").click(function(){
			
			getHostForm('ins');
		});
	}
	
	function codeSubEdit(){
		
		var cnt = 0;
		var grp_cd = "";
		var grp_nm = "";
		var grp_eng_nm = "";
		var grp_use_yn = "";
		var grp_desc = "";
		var grp_parent_cd = "";
		var host_cd = "";
		var host_desc = "";
		
		var aSelRow = new Array;
		aSelRow = $('#'+gridObj_3.id).data('grid').getSelectedRows();
		if(aSelRow.length>0){
			for(var i=0;i<aSelRow.length;i++){
					
				if(i>0) grp_cd += "|";
				grp_cd += getCellValue(gridObj_3,aSelRow[i],'GRP_CD');
				
				if(i>0) grp_nm += "|";
				grp_nm += getCellValue(gridObj_3,aSelRow[i],'GRP_NM');
				
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
				
				++cnt;
			}
			
			if(cnt > 1){
				alert("한개의 코드만 선택해 주세요.");
				return;
			}else{
				codeSubEdit2(grp_cd, grp_nm, grp_eng_nm, grp_use_yn, grp_desc, grp_parent_cd, host_cd, host_desc);
			}
			
		}else{
			alert("수정하려는 내용을 선택해 주세요.");
			return;
		}		
		
	}
	
	function codeSubEdit2(grp_cd, grp_nm, grp_eng_nm, grp_use_yn, grp_desc, grp_parent_cd, host_cd, host_desc){
			
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
		sHtml+="<input type='hidden' name='grp_depth' id='grp_depth' value='5'/>";
		sHtml+="<input type='hidden' name='grp_parent_cd' id='grp_parent_cd' />";
		sHtml+="<input type='hidden' name='grp_parent_nm' id='grp_parent_nm' />";
		sHtml+="<table style='width:100%;height:500px;border:none;'>";
		sHtml+="<tr><td style='vertical-align:top;height:90%;width:510px;' >";
		
		sHtml+="<table style='width:100%;height:80%;border:none;'>";
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
		hTmp1 += "<div class='cellTitle_1'>그룹명(한글)</div>";
		hTmp2 += "<div class='cellContent_1'><input type='text' name='grp_nm' id='grp_nm' style='width:100%;border:0px none;'/></div>";
		hTmp1 += "<div class='cellTitle_1'>그룹명(영문)</div>";
		hTmp2 += "<div class='cellContent_1'><input type='text' name='grp_eng_nm' id='grp_eng_nm' style='width:100%;border:0px none;'/></div>";
		hTmp1 += "<div class='cellTitle_1' style='height:190px;'>수 행 서 버</div>";
		hTmp2 += "<div class='cellContent_1' style='height:190px;'>";
		hTmp2 += "<input type='hidden' name='host_cd' id='host_cd'>";
		hTmp2 += "<input type='text' name='host_nm' id='host_nm' style='width:80%;height:21px;' readOnly />&nbsp;";
		hTmp2 += "<span id='btn_host'>검색</span><br>";
		if(arr_host_cd.length > 0){
			for(var i=0;i<arr_host_cd.length;i++){
				if(i > 0) hTmp2 += "&nbsp;";
				if(i>2 && i%3 == 0) hTmp2 += "<br>";
				hTmp2 += arr_host_desc[i]+"<input type='checkbox' name='v_host_cd' id='v_host_cd' value='"+arr_host_cd[i]+"' checked>";		
			}
		}else{
			hTmp2 += "<input type='hidden' name='v_host_cd' id='v_host_cd' />";
		}
		
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
		hTmp1 += "<div class='cellTitle_1' style='height:60px;'>설    명</div>";
		hTmp2 += "<div class='cellContent_1' style='height:60px;'><textarea name='grp_desc' id='grp_desc' style='width:99%;height:55px;border:0px none;'></textarea></div>";
	
		headerObj.push({name:hTmp1,id_s:'c_1',id_e:'c_1'});
		headerObj.push({name:hTmp2,id_s:'c_2',id_e:'c_2'});
		var gridObj_4 = {
			id : "g_tmp1"
			,colModel:[
		  		{formatter:gridCellNoneFormatter,field:'c_1',id:'c_1',name:'구 분',width:125,headerCssClass:'cellCenter',cssClass:'cellCenter'}
				,{formatter:gridCellNoneFormatter,field:'c_2',id:'c_2',name:'내 용',width:430,headerCssClass:'cellCenter',cssClass:'cellLeft'}
			   	
		   		,{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'grid_idx',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
		   	]
			,rows:[]
			,headerRowHeight:350
			,colspan:headerObj
			,vscroll:<%=S_GRID_VSCROLL%>
		};
		
		viewGrid_1(gridObj_4,'ly_'+gridObj_4.id);
		
		dlPop01('dl_tmp1',"코드명 수정",555,430,false);
		
		$("#frm6").find("input[name='scode_cd']").val(scode_cd);
		$("#frm6").find("input[name='grp_cd']").val(grp_cd);
		$("#frm6").find("input[name='grp_nm']").val(grp_nm);
		$("#frm6").find("input[name='grp_eng_nm']").val(grp_eng_nm);
		//$("#frm6").find("select[name='grp_use_yn'] option:selected").val(grp_use_yn);
		$("#frm6").find("textarea[name='grp_desc']").val(grp_desc);
		$("#frm6").find("input[name='grp_parent_cd']").val(grp_parent_cd);
				
		$("#btn_ins").button().unbind("click").click(function(){
			
			if(isNullInput($('#frm6 #grp_nm'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[그룹명(한글)]","") %>')) return false;
			if(isNullInput($('#frm6 #grp_eng_nm'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[그룹명(영문)]","") %>')) return false;
						
			var frm = document.frm6;
			if(confirm("해당 내용을 수정하시겠습니까?")){				
				frm.flag.value = "udt";
				frm.target = "if1";
				frm.action = "<%=sContextPath %>/common.ez?c=ezAppGrp_p";
				frm.submit();
			}
			
			dlClose('dl_tmp1');
		});
		
		$("#btn_host").button().unbind("click").click(function(){
			
			getHostForm('udt');
		});
	}
	
	function codeDelete(gb){
		
		var grp_cd = "";
		var scode_cd = "";
		var grp_parent_cd = "";
		var grp_depth = "";
		var cnt = 0;
		var aSelRow = new Array;
		
		/* if(gb == "1"){
			aSelRow = $('#'+gridObj_1.id).data('grid').getSelectedRows();
			if(aSelRow.length>0){
				for(var i=0;i<aSelRow.length;i++){					
					grp_cd = getCellValue(gridObj_1,aSelRow[i],'GRP_CD');
					scode_cd = getCellValue(gridObj_1,aSelRow[i],'SCODE_CD');
					grp_parent_cd = getCellValue(gridObj_1,aSelRow[i],'GRP_PARENT_CD');
					grp_depth = getCellValue(gridObj_1,aSelRow[i],'GRP_DEPTH');
					
					++cnt;
				}
			}else{
				alert("삭제 하시려는 그룹코드를 선택해 주세요.");
				return;
			}
						
			if(cnt > 1){
				alert("한개의 그룹코드만 선택해 주세요.");
				return;
			}			
			
		}else */ if(gb == "4"){
			aSelRow = $('#'+gridObj_2.id).data('grid').getSelectedRows();
			if(aSelRow.length>0){
				for(var i=0;i<aSelRow.length;i++){
					grp_cd = getCellValue(gridObj_2,aSelRow[i],'GRP_CD');
					scode_cd = getCellValue(gridObj_2,aSelRow[i],'SCODE_CD');
					grp_parent_cd = getCellValue(gridObj_2,aSelRow[i],'GRP_PARENT_CD');
					grp_depth = getCellValue(gridObj_2,aSelRow[i],'GRP_DEPTH');
					
					++cnt;
				}
			}else{
				alert("삭제 하시려는 코드를 선택해 주세요.");
				return;
			}
			
			if(cnt > 1){
				alert("한개의 코드만 선택해 주세요.");
				return;
			}			
		}else if(gb == "5"){
			aSelRow = $('#'+gridObj_3.id).data('grid').getSelectedRows();
			if(aSelRow.length>0){
				for(var i=0;i<aSelRow.length;i++){
					grp_cd = getCellValue(gridObj_3,aSelRow[i],'GRP_CD');
					scode_cd = getCellValue(gridObj_3,aSelRow[i],'SCODE_CD');
					grp_parent_cd = getCellValue(gridObj_3,aSelRow[i],'GRP_PARENT_CD');
					grp_depth = getCellValue(gridObj_3,aSelRow[i],'GRP_DEPTH');
					
					++cnt;
				}
			}else{
				alert("삭제 하시려는 코드를 선택해 주세요.");
				return;
			}
			
			if(cnt > 1){
				alert("한개의 코드만 선택해 주세요.");
				return;
			}			
		}
		
		if(confirm("선택된 내용을 삭제 하시겠습니까?")){
			
			try{viewProgBar(true);}catch(e){}
			
			var frm = document.frm7;
			
			frm.flag.value = "del";
			frm.grp_cd.value = grp_cd;
			frm.scode_cd.value = scode_cd;
			frm.grp_parent_cd.value = grp_parent_cd;
			frm.grp_depth.value = grp_depth;
			frm.target = "if1";
			frm.action = "<%=sContextPath %>/common.ez?c=ezAppGrp_p";
			frm.submit();
						
			try{viewProgBar(false);}catch(e){}
		}
	}
	
	function getHostForm(flag){
		
		var sHtml2="<div id='dl_tmp3' style='overflow:hidden;display:none;padding:0;border-top:1px solid blue;border-bottom:1px solid blue;border-left:1px solid blue;border-right:1px solid blue;'>";
		sHtml2+="<form id='form3' name='form3' method='post' onsubmit='return false;'>";
		sHtml2+="<table style='width:100%;height:260px;;border:none;'><tr><td style='vertical-align:top;height:100%;width:500px;'>";
		sHtml2+="호스트명 : <input type='text' name='v_host_nm' id='v_host_nm' />&nbsp;&nbsp;<span id='btn_hostSearch'>검색</span>";
		sHtml2+="<table style='width:100%;height:100%;border:none;'>";
		sHtml2+="<tr><td id='ly_g_tmp3' style='vertical-align:top;' >";
		sHtml2+="<div id='g_tmp3' class='ui-widget-header ui-corner-all'></div>";
		sHtml2+="</td></tr>";
		sHtml2+="<tr style='height:10px;'><td style='vertical-align:top;'><h5 class='ui-widget-header ui-corner-all' >";
		sHtml2+="<div align='right' class='btn_area_s'>";
		sHtml2+="<div id='ly_total_cnt4' style='padding-top:5px;float:left;'></div>";
		sHtml2+="</div>";
		sHtml2+="</h5></td></tr></table>";
		
		sHtml2+="</td></tr></table>";
		
		sHtml2+="</form>";
		
		$('#dl_tmp3').remove();
		$('body').append(sHtml2);
		
		dlPop01('dl_tmp3',"수행서버내역",420,295,false);
		
		var gridObj3 = {
			id : "g_tmp3"
			,colModel:[				
				{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'번호',width:50,headerCssClass:'cellCenter',cssClass:'cellCenter'}
				,{formatter:gridCellNoneFormatter,field:'NODE_ID',id:'NODE_ID',name:'호스트명',width:120,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
				,{formatter:gridCellNoneFormatter,field:'NODE_NM',id:'NODE_NM',name:'설명',width:150,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
				,{formatter:gridCellNoneFormatter,field:'CHOICE',id:'CHOICE',name:'선택',width:80,headerCssClass:'cellCenter',cssClass:'cellCenter'}
				
		   		,{formatter:gridCellNoneFormatter,field:'HOST_CD',id:'HOST_CD',name:'HOST_CD',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
		   	]
			,rows:[]
		};
		
		viewGrid_1(gridObj3,'ly_'+gridObj3.id);
		
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
		
		getHostList('', flag);
		
	}
	
	function getHostList(text, flag){
		
		try{viewProgBar(true);}catch(e){}
		$('#ly_total_cnt4').html('');
		
		var scode_cd = $("select[name='main_grp_nm'] option:selected").val();
		var data_center = $("select[name='main_grp_nm'] option:selected").attr("data");
		
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
																							
								rowsObj.push({'grid_idx':i+1
									,'HOST_CD':host_cd
									,'NODE_ID':node_id
									,'NODE_NM':node_nm									
									,'CHOICE':"<div><a href=\"javascript:selectHost('"+host_cd+"','"+node_id+"','"+flag+"');\" ><font color='red'>[선택]</font></a></div>"								
								});
								
							});
							
						}
						var obj = $("#g_tmp3").data('gridObj');
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
			var host_cd = $("#frm3").find("input[name='host_cd']").val();
			var host_nm = $("#frm3").find("input[name='host_nm']").val();
			
			if(host_cd == ""){
				$("#frm3").find("input[name='host_cd']").val(cd);	
				$("#frm3").find("input[name='host_nm']").val(nm);	
			}else{
				$("#frm3").find("input[name='host_cd']").val(host_cd+","+cd);	
				$("#frm3").find("input[name='host_nm']").val(host_nm+","+nm);	
			}
		}else if(flag == "udt"){
			var host_cd = $("#frm6").find("input[name='host_cd']").val();
			var host_nm = $("#frm6").find("input[name='host_nm']").val();
			
			if(host_cd == ""){
				$("#frm6").find("input[name='host_cd']").val(cd);	
				$("#frm6").find("input[name='host_nm']").val(nm);	
			}else{
				$("#frm6").find("input[name='host_cd']").val(host_cd+","+cd);	
				$("#frm6").find("input[name='host_nm']").val(host_nm+","+nm);	
			}
		}
		
		alert("추가되었습니다.");
	}
	
</script>
