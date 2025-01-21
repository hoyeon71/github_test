<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/jsp/common/inc/header.jsp"%>

<%
	Map<String, Object> paramMap = CommonUtil.collectParameters(request);

	String c             = CommonUtil.isNull(paramMap.get("c"));
	String gridId        = "g_"+c;
	
	String menu_gb       = CommonUtil.getMessage("CATEGORY.GB.03.GB."+CommonUtil.isNull(paramMap.get("menu_gb")));
	String[] arr_menu_gb = menu_gb.split(",");
%>

<form id="f_s" name="f_s" method="post" onsubmit="return false;">
	<input type="hidden" name="jobgroup_name" 		id="p_search_text"/>
</form>
<form name="delFrm" id="delFrm" method="post" onsubmit="return false;">
	<input type="hidden" name=jobgroup_id id="jobgroup_id"/>
	<input type="hidden" name="flag" id="flag"/>
</form>
<form name="f_tmp" id="f_tmp" method="post" onsubmit="return false;">
	<input type="hidden" name="jobgroup_id" 		value=''/>
	<input type="hidden" name="jobgroup_nm" 		value=''/>
	<input type="hidden" name="jobgroup_content" 	value=''/>
</form>	
<table style='width:100%;height:100%;border:none;'>
	<tr style='height:10px;'>
		<td style='vertical-align:top;'>
			<h4 class="ui-widget-header ui-corner-all"  >
				<div id='t_<%=gridId %>' class='title_area' >
					<span><%=CommonUtil.isNull(CommonUtil.getMessage("CATEGORY.GB.03"))%> > <%=CommonUtil.isNull(arr_menu_gb[0]) %></span>
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
					<th width='10%'><div class='cellTitle_kang2'>그룹명</div></th>
					<td width='35%'>
						<div class='cellContent_kang'>
						<input type="text" name="search_text" value="" id="search_text" style="width:150px; height:21px;" />
						</div>						
					</td>
					<td style="text-align:right">
						<span id="btn_search" style='display:none;margin:3px;'>검 색</span>
					</td>
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
					<span id="btn_insert">그룹등록</span>
					<span id="btn_delete">그룹삭제</span>
				</div>
			</h4>
		</td>
	</tr>
</table>

<div id="dl_p01" style='overflow:hidden;display:none;padding:0;'>
	<iframe id='if_p01' name='if_p01' src='about:blank' width='0px' height='0px' scrolling='no'  frameborder="0"  ></iframe>
</div>

<script>
	

	function gridCellCustomFormatter(row,cell,value,columnDef,dataContext){
		var ret = "";
		var group_id      = getCellValue(gridObj,row,'JOBGROUP_ID');
		var group_nm      = getCellValue(gridObj,row,'jobgroup_name');
		var group_content = getCellValue(gridObj,row,'JOBGROUP_CONTENT');
			
		if(columnDef.id == 'jobgroup_name') {
			ret = "<a href=\"JavaScript:groupUpdate('"+group_id+"', '"+group_nm+"', '"+group_content+"');\" /><font color='red'>"+value+"</font></a>";
		}
		
		if(columnDef.id == 'GROUP_DETAIL') {
			ret = "<a href=\"JavaScript:popupGroupDetail('"+group_id+"', '"+group_nm+"', '"+group_content+"');\" /><font color='red'>"+value+"</font></a>";
		}
		
		return ret;
	}
	
	var gridObj = {
		id : "<%=gridId %>"
		,colModel:[
	   		{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'번호',width:50,minWidth:50,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	   		,{formatter:gridCellCustomFormatter,field:'jobgroup_name',id:'jobgroup_name',name:'그룹명',width:370,minWidth:370,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'JOBGROUP_DETAIL_CNT',id:'JOBGROUP_DETAIL_CNT',name:'작업건수',width:80,minWidth:80,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'JOBGROUP_UDT_USER_NM',id:'JOBGROUP_UDT_USER_NM',name:'최종수정자',width:200,minWidth:200,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}	 
	   		,{formatter:gridCellNoneFormatter,field:'JOBGROUP_UDT_DATE',id:'JOBGROUP_UDT_DATE',name:'최종수정일',width:300,minWidth:300,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	   		,{formatter:gridCellCustomFormatter,field:'GROUP_DETAIL',id:'GROUP_DETAIL',name:'수시작업',width:130,minWidth:130,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	   	]
		,rows:[]
		,vscroll: <%=S_GRID_VSCROLL%>
	};
	
	$(document).ready(function() {
		
		var session_user_gb	= "<%=S_USER_GB%>";
		
		setTimeout(function(){
			jobGroupList(); // 초기 그룹명 전체 조회
		}, 1000);
		
		$("#btn_search").show();
		
		viewGrid_1(gridObj,"ly_"+gridObj.id,{enableColumnReorder:true},'AUTO');
		
		$("#btn_search").button().unbind("click").click(function(){
			jobGroupList();
		});
		
		$('#search_text').unbind('keypress').keypress(function(e){
			if(e.keyCode==13){
				$("#f_s").find("input[name='p_search_text']").val($("#frm1").find("input[name='search_text']").val());
				jobGroupList();
			}
		});
		
		$("#btn_insert").button().unbind("click").click(function(){
			groupInsert();
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
			var group_id = "";
			var aSelRow = new Array;
			aSelRow = $('#'+gridObj.id).data('grid').getSelectedRows();
			
			if(aSelRow.length == 0){
				alert("삭제하려는 그룹을 선택해 주세요.");
				return;
			}

			if (!confirm("선택한 그룹을 삭제 하시겠습니까?"))
				return;
			
			for (var i = 0; i < aSelRow.length; i++) {
				group_id += getCellValue(gridObj,aSelRow[i],'JOBGROUP_ID');
				if (i < aSelRow.length-1)
					group_id += ",";
			}
			
			var f = document.delFrm;
			
			try{viewProgBar(true);}catch(e){}
			
			f.flag.value = "group_delete";
			f.target = "if1";
			f.jobgroup_id.value = group_id;
			f.action = "<%=sContextPath %>/tWorks.ez?c=ez020_group_d"; 
			f.submit();

			try{viewProgBar(false);}catch(e){}
			
			//그리드 선택 해제
			$('#'+gridObj.id).data('grid').getSelectionModel().setSelectedRanges([]);
		});
		
	});
		
	function jobGroupList(){
		$("#f_s").find("input[name='jobgroup_name']").val($("#frm1").find("input[name='search_text']").val());
		try{viewProgBar(true);}catch(e){}
		
		$('#ly_total_cnt').html('');
		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=jobGroupList';
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
							
								var jobgroup_id 				= $(this).find("JOBGROUP_ID").text();
								var jobgroup_name 				= $(this).find("JOBGROUP_NAME").text();
								var jobgroup_content			= $(this).find("JOBGROUP_CONTENT").text();
								var jobgroup_udt_user_nm		= $(this).find("JOBGROUP_UDT_USER_NM").text();
								var jobgroup_udt_date			= $(this).find("JOBGROUP_UDT_DATE").text();
								var jobgroup_detail				= "<div>[설정]</div>";
								var jobgroup_detail_cnt         = $(this).find("JOBGROUP_DETAIL_CNT").text();
								
								rowsObj.push({
									'grid_idx': i+1
									,'jobgroup_name'		: jobgroup_name
									,'JOBGROUP_ID'			: jobgroup_id
									,'JOBGROUP_CONTENT'		: jobgroup_content
									,'JOBGROUP_UDT_USER_NM'	: jobgroup_udt_user_nm
									,'JOBGROUP_UDT_DATE'	: jobgroup_udt_date
									,'GROUP_DETAIL'			: jobgroup_detail
									,'JOBGROUP_DETAIL_CNT'	: jobgroup_detail_cnt
								});
								
							});						
						}
						
						gridObj.rows = rowsObj;
						setGridRows(gridObj);
						
						//컬럼 자동 조정 기능
						$('body').resizeAllColumns();
						$('#ly_total_cnt').html('[ TOTAL : '+items.attr('cnt')+' ]');
					});
					
					try{viewProgBar(false);}catch(e){}
				}
		, null );
		xhr.sendRequest();
	}
	
	function groupInsert(){
		
		var sHtml="<div id='dl_ins_tmp1' style='overflow:hidden;display:none;padding:0;border-top:1px solid blue;border-bottom:1px solid blue;border-left:1px solid blue;border-right:1px solid blue;'>";
		sHtml+="<form id='form1' name='form1' method='post' onsubmit='return false;'>";
		sHtml+="<input type='hidden' name='flag' id='flag'/>";	
		sHtml+="<table style='width:100%;height:160px;border:none;'>";
		sHtml+="<tr><td style='vertical-align:top;height:50%;width:510px;' >";
		
		sHtml+="<table style='width:100%;height:80%;border:none;'>";
		sHtml+="<tr><td id='ly_g_ins_tmp1' style='vertical-align:top;'>";
		sHtml+="<div id='g_ins_tmp1' class='ui-widget-header ui-corner-all'></div>";
		sHtml+="</td></tr>";
		sHtml+="<tr style='height:10px;'><td style='vertical-align:top;'><h5 class='ui-widget-header ui-corner-all' >";
		sHtml+="<div align='right' class='btn_area_s'>";
		sHtml+="<span id='btn_ins'>그룹등록</span>";
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
		hTmp1 += "<div class='cellTitle_1'>그룹명</div>";
		hTmp2 += "<div class='cellContent_1'><input type='text' name='jobgroup_name' id='jobgroup_name' style='width:100%;border:0px none;'/></div>";
		hTmp1 += "<div class='cellTitle_1'>비고</div>";
		hTmp2 += "<div class='cellContent_1'><input type='text' name='content' id='content' style='width:100%;border:0px none;'/></div>";
		
		
		headerObj.push({name:hTmp1,id_s:'c_1',id_e:'c_1'});
		headerObj.push({name:hTmp2,id_s:'c_2',id_e:'c_2'});
		
		var gridObj_s = {
			id : "g_ins_tmp1"
			,colModel:[
		  		{formatter:gridCellNoneFormatter,field:'c_1',id:'c_1',name:'구 분',width:80,headerCssClass:'cellCenter',cssClass:'cellCenter'}
				,{formatter:gridCellNoneFormatter,field:'c_2',id:'c_2',name:'그룹 정보',width:320,headerCssClass:'cellCenter',cssClass:'cellLeft'}
			   	
		   		,{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'grid_idx',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
		   	]
			,rows:[]
			,headerRowHeight:500
			,colspan:headerObj
			,vscroll:<%=S_GRID_VSCROLL%>
		};
		
		viewGrid_1(gridObj_s,'ly_'+gridObj_s.id);
		
		dlPop01('dl_ins_tmp1', "그룹JOB등록", 400, 135, false);
		
		$("#btn_ins").button().unbind("click").click(function(){
			
			if(isNullInput($('#form1 #jobgroup_name'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[그룹명]","") %>')) return false;
<%-- 			if(isNullInput($('#form1 #content'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[비고]","") %>')) return false; --%>
						
			
			if(confirm("해당 내용을 등록 하시겠습니까?")){
				var f = document.form1;
				
				try{viewProgBar(true);}catch(e){}
				
				f.flag.value = "group_insert";				
				f.target = "if1";			
				
				f.action = "<%=sContextPath %>/tWorks.ez?c=ez020_group_i"; 
				f.submit();
				
				try{viewProgBar(false);}catch(e){}
				
				dlClose('dl_ins_tmp1');
			}
		});
	}
	
	function groupUpdate(group_id, group_nm, group_content){
		var sHtml="<div id='dl_ins_tmp1' style='overflow:hidden;display:none;padding:0;border-top:1px solid blue;border-bottom:1px solid blue;border-left:1px solid blue;border-right:1px solid blue;'>";
		sHtml+="<form id='form1' name='form1' method='post' onsubmit='return false;'>";
		sHtml+="<input type='hidden' name='jobgroup_id' id='jobgroup_id'/>";
		sHtml+="<input type='hidden' name='flag' id='flag'/>";
		sHtml+="<table style='width:100%;height:160px;border:none;'>";
		sHtml+="<tr><td style='vertical-align:top;height:50%;width:510px;' >";
		
		sHtml+="<table style='width:100%;height:80%;border:none;'>";
		sHtml+="<tr><td id='ly_g_ins_tmp1' style='vertical-align:top;'>";
		sHtml+="<div id='g_ins_tmp1' class='ui-widget-header ui-corner-all'></div>";
		sHtml+="</td></tr>";
		sHtml+="<tr style='height:10px;'><td style='vertical-align:top;'><h5 class='ui-widget-header ui-corner-all' >";
		sHtml+="<div align='right' class='btn_area_s'>";
		sHtml+="<span id='btn_ins'>그룹수정</span>";
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
		hTmp1 += "<div class='cellTitle_1'>그룹명</div>";
		hTmp2 += "<div class='cellContent_1'><input type='text' name='jobgroup_name' id='jobgroup_name' value='"+group_nm+"' style='width:100%;border:0px none;'/></div>";
		hTmp1 += "<div class='cellTitle_1'>비고</div>";
		hTmp2 += "<div class='cellContent_1'><input type='text' name='content' id='content' value='"+group_content+"' style='width:100%;border:0px none;'/></div>";
		
		
		headerObj.push({name:hTmp1,id_s:'c_1',id_e:'c_1'});
		headerObj.push({name:hTmp2,id_s:'c_2',id_e:'c_2'});
		
		var gridObj_s = {
			id : "g_ins_tmp1"
			,colModel:[
		  		{formatter:gridCellNoneFormatter,field:'c_1',id:'c_1',name:'구 분',width:80,headerCssClass:'cellCenter',cssClass:'cellCenter'}
				,{formatter:gridCellNoneFormatter,field:'c_2',id:'c_2',name:'그룹 정보',width:320,headerCssClass:'cellCenter',cssClass:'cellLeft'}
			   	
		   		,{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'grid_idx',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
		   	]
			,rows:[]
			,headerRowHeight:500
			,colspan:headerObj
			,vscroll:<%=S_GRID_VSCROLL%>
		};
		
		viewGrid_1(gridObj_s,'ly_'+gridObj_s.id);
		
		dlPop01('dl_ins_tmp1', "그룹수정", 400, 135, false);
		
		$("#btn_ins").button().unbind("click").click(function(){
			
			if(isNullInput($('#form1 #jobgroup_name'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[그룹명]","") %>')) return false;
			
			if(confirm("해당 내용을 등록 하시겠습니까?")){
				var f = document.form1;
				
				try{viewProgBar(true);}catch(e){}
				
				f.flag.value = "group_update";
				f.jobgroup_id.value = group_id;
				f.target = "if1";				
				
				f.action = "<%=sContextPath %>/tWorks.ez?c=ez020_group_i"; 
				f.submit();
				
				try{viewProgBar(false);}catch(e){}
				
				dlClose('dl_ins_tmp1');
			}
		});
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
	
	function defJobGroupListMapper() {
		try{viewProgBar(true);}catch(e){}
		$('#ly_jobList_total_cnt').html('');
		
		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=defJobExceptMapper&itemGubun=2';
		
		var xhr = new XHRHandler(url, defJobExceptMapperForm, function(){
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
						var data_center			= $(this).find("data_center").text();
						var sched_table			= $(this).find("sched_table").text();
						var application_of_def	= $(this).find("application_of_def").text();
						var group_name_of_def	= $(this).find("group_name_of_def").text();
						var job_name			= $(this).find("job_name").text();
						
						rowObj.push({
							'grid_idx':i+1
							,'SCHED_TABLE': sched_table
							,'APPLICATION': application
							,'GROUP_NAME': group_name
							,'JOB_NAME': job_name
						});
					});
				}
				
				var obj = $("#jobListGrid").data('gridObj');
				obj.rows = rowObj;
				setGridRows(obj);
				
				$('#ly_jobList_total_cnt').html('[ TOTAL : '+items.attr('cnt')+' ]');
			});
			try{viewProgBar(false);}catch(e){}
		}
		, null);
		
		xhr.sendRequest();
	}
	
	// 수시작업등록 프레임 김선중
	function popupGroupDetail(group_id, group_nm, group_content){
		var url = "<%=sContextPath %>/tWorks.ez?pop_if=P01&c=ez019";
		if(dlMap.containsKey('dl_p01')) dlClose('dl_p01');
		$('#if_p01').width(1400).height(600);
		dlPopIframe01('dl_p01','수시작업 등록 LIST',$('#if_p01').width(),$('#if_p01').height(),true,true,true);
		
		dlFrontView('dl_p01');
		setTimeout(function(){
			var f = document.f_tmp;
			f.jobgroup_id.value = group_id;
			f.jobgroup_nm.value = group_nm;
			f.jobgroup_content.value = group_content;
			f.target = "if_p01";
			f.action = url; 
			f.submit();
		}, 300);
	}
	
</script>
