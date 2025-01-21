<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/jsp/common/inc/header.jsp"%>
<%@include file="/jsp/common/inc/hint.jsp"%>

<%
	Map<String, Object> paramMap = CommonUtil.collectParameters(request);

	String c 		= CommonUtil.isNull(paramMap.get("c"));
	String gridId 	= "g_"+c;
	String gridId_1 = "g_"+c+"_1";
	String gridId_2 = "g_"+c+"_2";
	
	String menu_gb 			= CommonUtil.getMessage("CATEGORY.GB.06.GB.0612");
	String[] arr_menu_gb 	= menu_gb.split(",");
%>

<c:set var="doc_gubun_cd" 			value="${fn:split(DOC_GUBUN_CD,',')}"/>
<c:set var="doc_gubun_nm" 			value="${fn:split(DOC_GUBUN_NM,',')}"/>
<c:set var="approval_type_cd" 		value="${fn:split(APPROVAL_TYPE_CD,',')}"/>
<c:set var="approval_type_nm" 		value="${fn:split(APPROVAL_TYPE_NM,',')}"/>
<!-- 결재자유형 => 결재구분 컬럼변경 -->
<c:set var="approval_admin_gb_cd" 	value="${fn:split(ADMIN_APPROVAL_GB_CD,',')}"/>
<c:set var="approval_admin_gb_nm" 	value="${fn:split(ADMIN_APPROVAL_GB_NM,',')}"/>
<c:set var="approval_seq_cd" 		value="${fn:split(APPROVAL_ORDER_CD,',')}"/>

<form id="f_s" name="f_s" method="post" onsubmit="return false;">
</form>

<form name="frm1" id="frm1" method="post" onsubmit="return false;">
	<input type="hidden" name="flag" 				id="flag" />
	<input type="hidden" name="admin_line_grp_cd" 	id="admin_line_grp_cd" />
	<input type="hidden" name="admin_line_grp_nm" 	id="admin_line_grp_nm" />
<!-- 	<input type="hidden" name="use_yn" 				id="use_yn" /> -->
	<input type="hidden" name="doc_gubun" 			id="doc_gubun" />
	<input type="hidden" name="top_level_yn" 		id="top_level_yn" />
	<input type="hidden" name="schedule_yn" 		id="schedule_yn" />
	<input type="hidden" name="post_approval_yn" 	id="post_approval_yn" />
</form>

<table style='width:100%;height:100%;border:none;'>
	<tr style='height:10px;'>
		<td style='vertical-align:top;' colspan="2">
			<h4 class="ui-widget-header ui-corner-all"  >
				<div id='t_<%=gridId %>' class='title_area' >
					<span><%=CommonUtil.isNull(CommonUtil.getMessage("CATEGORY.GB.06"))%> > <%=CommonUtil.isNull(arr_menu_gb[0]) %></span>
				</div>
			</h4>
		</td>
	</tr>
	<tr>
		<td style='vertical-align:top; width:40%;'>
			<table style="width:100%;height:100%;">
				<tr>
					<td id='ly_<%=gridId_1 %>' style='vertical-align:top;' >
						<div id="<%=gridId_1 %>" class="ui-widget-header ui-corner-all"></div>
					</td>					
				</tr>
				<tr style='height:10px;'>
					<td style='vertical-align:top;'>
						<h4 class="ui-widget-header ui-corner-all" >
							<div align='right' class='btn_area' >								
								<span id="btn_add">저장</span>		
								<span id="btn_del">삭제</span>			
							</div>
						</h4>
					</td>
				</tr>
			</table>
		</td>
		<td style='vertical-align:top; width:60%;'>
			<table style="width:100%;height:100%;">
				<tr>					
					<td id='ly_<%=gridId_2 %>' style='vertical-align:top;' >
						<form name="frm2" id="frm2" method="post" onsubmit="return false;">
							<input type="hidden" name="flag" 				id="flag"/>
							<input type="hidden" name="admin_line_cd" 		id="admin_line_cd" />
							<input type="hidden" name="admin_line_grp_cd" 	id="admin_line_grp_cd" />
							<input type="hidden" name="approval_cd" 		id="approval_cd" />
							<input type="hidden" name="group_line_grp_cd" 	id="group_line_grp_cd" />
							<input type="hidden" name="approval_seq" 		id="approval_seq" />
							<input type="hidden" name="approval_gb" 		id="approval_gb" />
							<input type="hidden" name="approval_type" 		id="approval_type" />
														
							<div id="<%=gridId_2 %>" class="ui-widget-header ui-corner-all"></div>
						
						</form>
					</td>
				</tr>
				<tr style='height:10px;'>
					<td style='vertical-align:top;'>
						<h4 class="ui-widget-header ui-corner-all" >
							<div align='right' class='btn_area' >								
								<div id='ly_total_cnt' style='padding-top:5px;float:left;'></div>
								<span id="btn_udt">저장</span>
							</div>
						</h4>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>

<script>

	var arr_approval_seq_cd 		= new Array();
	var arr_doc_gubun_cd 			= new Array();
	var arr_doc_gubun_nm 			= new Array();
	var arr_approval_type_cd 		= new Array();
	var arr_approval_type_nm 		= new Array();
	var arr_approval_admin_gb_cd 	= new Array();
	var arr_approval_admin_gb_nm 	= new Array();
	
	<c:forEach var="approval_seq_cd" items="${approval_seq_cd}" varStatus="s">
		var map_cd = {"cd":"${approval_seq_cd}"};
		arr_approval_seq_cd.push(map_cd);
	</c:forEach>
	
	<c:forEach var="doc_gubun_cd" items="${doc_gubun_cd}" varStatus="s">
		var map_cd = {"cd":"${doc_gubun_cd}"};
		arr_doc_gubun_cd.push(map_cd);
	</c:forEach>
	<c:forEach var="doc_gubun_nm" items="${doc_gubun_nm}" varStatus="s">
		var map_nm = {"nm":"${doc_gubun_nm}"};
		arr_doc_gubun_nm.push(map_nm);
	</c:forEach>
	
	<c:forEach var="approval_type_cd" items="${approval_type_cd}" varStatus="s">
		var map_cd = {"cd":"${approval_type_cd}"};
		arr_approval_type_cd.push(map_cd);
	</c:forEach>
	<c:forEach var="approval_type_nm" items="${approval_type_nm}" varStatus="s">
		var map_nm = {"nm":"${approval_type_nm}"};
		arr_approval_type_nm.push(map_nm);
	</c:forEach>
	
	<c:forEach var="approval_admin_gb_cd" items="${approval_admin_gb_cd}" varStatus="s">
		var map_cd = {"cd":"${approval_admin_gb_cd}"};
		arr_approval_admin_gb_cd.push(map_cd);
	</c:forEach>
	<c:forEach var="approval_admin_gb_nm" items="${approval_admin_gb_nm}" varStatus="s">
		var map_nm = {"nm":"${approval_admin_gb_nm}"};
		arr_approval_admin_gb_nm.push(map_nm);
	</c:forEach>

	function gridCellCustomFormatter(row,cell,value,columnDef,dataContext){
		
		var ret = "";
		var admin_line_grp_cd = getCellValue(gridObj_1,row,'ADMIN_LINE_GRP_CD');		
		
		if(columnDef.id == 'SELECT'){
			if(row > 0){
				ret = "<a href=\"JavaScript:adminApprovalLineList('"+admin_line_grp_cd+"');\" /><font color='red'>"+value+"</font></a>";	
			}else{
				ret = value;
			}
		}
				
		return ret;
	}

	var gridObj_1 = {
		id : "<%=gridId_1 %>"
		,colModel:[ 
	   		{formatter:gridCellCustomFormatter,field:'SELECT',id:'SELECT',name:'',width:50,headerCssClass:'cellCenter',cssClass:'cellCenter'}
	   		,{formatter:gridCellNoneFormatter,field:'DOC_GUBUN',id:'DOC_GUBUN',name:'문서구분',width:100,headerCssClass:'cellCenter',cssClass:'cellCenter'}
	   		,{formatter:gridCellNoneFormatter,field:'ADMIN_LINE_GRP_NM',id:'ADMIN_LINE_GRP_NM',name:'결재그룹명',width:150,headerCssClass:'cellCenter',cssClass:'cellLeft'}
// 	   		,{formatter:gridCellNoneFormatter,field:'USE_YN',id:'USE_YN',name:'사용구분',width:80,headerCssClass:'cellCenter',cssClass:'cellCenter'}
// 	   		,{formatter:gridCellNoneFormatter,field:'TOP_LEVEL_YN',id:'TOP_LEVEL_YN',name:'상위레벨',width:80,headerCssClass:'cellCenter',cssClass:'cellCenter'}
// 	   		,{formatter:gridCellNoneFormatter,field:'SCHEDULE_YN',id:'SCHEDULE_YN',name:'정기작업',width:80,headerCssClass:'cellCenter',cssClass:'cellCenter'}
	   		,{formatter:gridCellNoneFormatter,field:'POST_APPROVAL_YN',id:'POST_APPROVAL_YN',name:'후결',width:80,headerCssClass:'cellCenter',cssClass:'cellCenter'}
	   			   			   		
	   		,{formatter:gridCellNoneFormatter,field:'ADMIN_LINE_GRP_CD',id:'ADMIN_LINE_GRP_CD',name:'ADMIN_LINE_GRP_CD',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   		,{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'grid_idx',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   	]
		,rows:[]
		,vscroll:<%=S_GRID_VSCROLL%>
	};
	
	var gridObj_2 = {
		id : "<%=gridId_2 %>"
		,colModel:[
	   		{formatter:gridCellNoneFormatter,field:'APPROVAL_SEQ',id:'APPROVAL_SEQ',name:'결재순서',width:60,headerCssClass:'cellCenter',cssClass:'cellCenter'}
	   		,{formatter:gridCellNoneFormatter,field:'APPROVAL_GB',id:'APPROVAL_GB',name:'결재구분',width:140,headerCssClass:'cellCenter',cssClass:'cellLeft'}
	   		,{formatter:gridCellNoneFormatter,field:'APPROVAL_NM',id:'APPROVAL_NM',name:'결재자',width:220,headerCssClass:'cellCenter',cssClass:'cellLeft'}
	   		,{formatter:gridCellNoneFormatter,field:'GROUP_LINE_GRP_NM',id:'GROUP_LINE_GRP_NM',name:'결재그룹',width:200,headerCssClass:'cellCenter',cssClass:'cellLeft'}
	   		,{formatter:gridCellNoneFormatter,field:'APPROVAL_TYPE',id:'APPROVAL_TYPE',name:'결재유형',width:80,headerCssClass:'cellCenter',cssClass:'cellLeft'}
	   		,{formatter:gridCellNoneFormatter,field:'PROC',id:'PROC',name:'처리',width:80,headerCssClass:'cellCenter',cssClass:'cellCenter'}
	   		
	   		,{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'grid_idx',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   		,{formatter:gridCellNoneFormatter,field:'ADMIN_LINE_CD',id:'ADMIN_LINE_CD',name:'ADMIN_LINE_CD',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   		,{formatter:gridCellNoneFormatter,field:'ADMIN_LINE_GRP_CD',id:'ADMIN_LINE_GRP_CD',name:'ADMIN_LINE_GRP_CD',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   		,{formatter:gridCellNoneFormatter,field:'APPROVAL_CD',id:'APPROVAL_CD',name:'APPROVAL_CD',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   		,{formatter:gridCellNoneFormatter,field:'GROUP_LINE_GRP_CD',id:'GROUP_LINE_GRP_CD',name:'GROUP_LINE_GRP_CD',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   	]
		,rows:[]
		,vscroll:<%=S_GRID_VSCROLL%>
	};
	
	$(document).ready(function(){
		
		$("#btn_add").button().unbind("click").click(function(){
			
			var str_admin_line_grp_cd	= "";
			var str_doc_gubun 			= "";
			var str_post_approval_yn 	= "";
			var str_admin_line_grp_nm 	= "";
			
			for (var i = 0; i < gridObj_1.rows.length; i++) {
				if( i == 0 ) {
					if($("#admin_line_grp_nm0").val() != "") {
						str_admin_line_grp_cd += ",0";
						str_doc_gubun		  += "," + $("#doc_gubun0").val();
						str_post_approval_yn  += "," + $("#post_approval_yn0").val();
						str_admin_line_grp_nm += "," + $("#admin_line_grp_nm0").val();
					}
				}else {
					var admin_line_grp_cd = getCellValue(gridObj_1, i, "ADMIN_LINE_GRP_CD");
					
					str_admin_line_grp_cd += "," + admin_line_grp_cd;
					str_doc_gubun		  += "," + $("#doc_gubun" + admin_line_grp_cd ).val();
					str_post_approval_yn  += "," + $("#post_approval_yn" + admin_line_grp_cd).val();
					str_admin_line_grp_nm += "," + $("#admin_line_grp_nm" + admin_line_grp_cd).val();
				}
			}
			
			if(gridObj_1.rows.length == 1 && $("#admin_line_grp_nm0").val() == "" ){ // 등록된 결재그룹이 없을경우
				alert("결재그룹을 등록해주세요.");
				return;
			}
			
			// 앞에있는 첫번째 컴마 제거
			str_admin_line_grp_cd = str_admin_line_grp_cd.substr(1);
			str_doc_gubun 		  = str_doc_gubun.substr(1);
			str_post_approval_yn  = str_post_approval_yn.substr(1);
			str_admin_line_grp_nm = str_admin_line_grp_nm.substr(1);
			
			if( !confirm("처리하시겠습니까?") ) return;
			
			var frm = document.frm1;
			frm.flag.value					= "ins";
			frm.admin_line_grp_cd.value 	= str_admin_line_grp_cd;
			frm.doc_gubun.value 			= str_doc_gubun;
			frm.admin_line_grp_nm.value 	= str_admin_line_grp_nm
			frm.post_approval_yn.value 		= str_post_approval_yn
			frm.target = "if1";
			frm.action = "<%=sContextPath%>/tWorks.ez?c=ezAdminApprovalGroup_p";
			frm.submit();
			
		});
		
		$("#btn_del").button().unbind("click").click(function(){
			
			var cnt = 0;
			var admin_line_grp_cd = 0;

			var aSelRow = new Array;
			aSelRow = $('#'+gridObj_1.id).data('grid').getSelectedRows();
			if(aSelRow.length>0){
				for(var i=0;i<aSelRow.length;i++){					
					admin_line_grp_cd 	= getCellValue(gridObj_1,aSelRow[i],"ADMIN_LINE_GRP_CD");
					++cnt;
				}				
			}
			
			if(admin_line_grp_cd == '0' || admin_line_grp_cd == ''){ 
				alert("삭제할 결재선을 선택해 주세요.");
				return;
			}
			
			if(cnt > 1){
				alert("한개의 항목만 선택해 주세요.");
				return;
			}
			
			if( !confirm("관련된 하위 데이터도 모두 삭제됩니다. 진행하시겠습니까?") ) return;
			
			var frm = document.frm1;
			
			frm1.flag.value 				= "del";
			frm1.admin_line_grp_cd.value 	= admin_line_grp_cd;
			frm1.target 					= "if1";
			frm1.action 					= "<%=sContextPath%>/tWorks.ez?c=ezAdminApprovalGroup_p";
			frm1.submit();
			
		});
		
		$("#btn_udt").button().unbind("click").click(function(){
			var str_admin_cd		   = "";
			var str_approval_cd		   = ""; // 변경할 결재자
			var str_group_line_grp_cd  = ""; // 변경할 결재그룹
			var str_approval_gb		   = ""; // 결재구분
			var str_approval_type	   = ""; // 결재유형
			var str_approval_seq	   = ""; // 결재순서
			
			for(var i = 0; i < gridObj_2.rows.length; i++){
				if(i == 0){
					// 결재자, 결재그룹이 추가된 경우
					if($("input[id=approval_cd0]").val()       != "" ||
					   $("input[id=group_line_grp_cd0]").val() != "" ||
					   $('select[id=approval_gb0] option:selected').val() == '01') {
						
						str_admin_cd      	  += ",0";
						str_approval_cd  	  += "," + $("input[id=approval_cd0]").val();
						str_group_line_grp_cd += "," + $("input[id=group_line_grp_cd0]").val();
						str_approval_gb   	  += "," + $('select[id=approval_gb0] option:selected').val();
						str_approval_type 	  += "," + $('select[id=approval_type0] option:selected').val();
						str_approval_seq  	  += "," + $('select[id=approval_seq0] option:selected').val();
					}
				}else {
					// 추가된 결재자, 결재그룹만 변경된 경우
					var admin_line_cd = getCellValue(gridObj_2, i, "ADMIN_LINE_CD");
					
					str_admin_cd      	  += "," + admin_line_cd;
					str_approval_cd  	  += "," + $("input[id=approval_cd"+ admin_line_cd +"]").val();
					str_group_line_grp_cd += "," + $("input[id=group_line_grp_cd"+ admin_line_cd +"]").val();
					str_approval_gb   	  += "," + $('select[id=approval_gb' + admin_line_cd +'] option:selected').val();
					str_approval_type 	  += "," + $('select[id=approval_type' + admin_line_cd +'] option:selected').val();
					str_approval_seq  	  += "," + $('select[id=approval_seq' + admin_line_cd +'] option:selected').val();
				}
			}
			
			if(gridObj_2.rows.length == 1) { //결재그룹에 등록된 결재자 or 결재그룹이 없을경우
				if($("input[id=approval_cd0]").val()       == "" &&
				   $("input[id=group_line_grp_cd0]").val() == "" &&
				   $('select[id=approval_gb0] option:selected').val() != '01') {
					alert("결재자 or 결재그룹을 선택해 주세요.");
					return;
				}
			}
			
			// 앞에있는 첫번째 컴마 제거
			str_admin_cd 			= str_admin_cd.substr(1);
			str_approval_cd 		= str_approval_cd.substr(1);
			str_group_line_grp_cd 	= str_group_line_grp_cd.substr(1);
			str_approval_gb 		= str_approval_gb.substr(1);
			str_approval_type 		= str_approval_type.substr(1);
			str_approval_seq 		= str_approval_seq.substr(1);
			
			goPrc2(str_admin_cd, str_approval_cd, str_group_line_grp_cd, str_approval_gb, str_approval_type, str_approval_seq);
		});
		
		viewGrid_1(gridObj_1,"ly_"+gridObj_1.id);
		adminApprovalGroupList();
		
		viewGrid_1(gridObj_2,"ly_"+gridObj_2.id);

	});
	
	function adminApprovalGroupList(){
		
		$("#btn_udt").hide();
		
		try{viewProgBar(true);}catch(e){}
		$('#ly_total_cnt').html('');
		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=adminApprovalGroup&itemGubun=2';
		
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
						
						var inputDoc_gubun = "";
						inputDoc_gubun += "<div class='gridInput_area'><select id='doc_gubun0' name='doc_gubun0' style='width:100%;'>"
						
						for(var j=0;j<arr_doc_gubun_cd.length;j++){							
							inputDoc_gubun += "<option value='"+arr_doc_gubun_cd[j].cd+"'>"+arr_doc_gubun_nm[j].nm+"</option>";
						}						
						inputDoc_gubun += "</select></div>"
						
// 						var cd = "<div><input type='hidden' name='line_grp_cd0' id='line_grp_cd0' value='0' style='width:100%;'/></div>"
						var nm 		= "<div><input type='text' name='admin_line_grp_nm0' id='admin_line_grp_nm0' style='width:100%;'/></div>"

// 						var v_use_yn = "";
// 						v_use_yn += "<div class='gridInput_area'><select name='use_yn0' id='use_yn0' style='width:100%;'>";
// 						v_use_yn += "<option value='Y'>사용</option>";
// 						v_use_yn += "<option value='N' selected >미사용</option>";
// 						v_use_yn += "</select></div>";

						var v_top_level_yn = "";
						v_top_level_yn += "<div class='gridInput_area'><select name='top_level_yn0' id='top_level_yn0' style='width:100%;'>";
						v_top_level_yn += "<option value='Y'>상위</option>";
						v_top_level_yn += "<option value='N' selected >일반</option>";
						v_top_level_yn += "</select></div>";

						var v_schedule_yn = "";
						v_schedule_yn += "<div class='gridInput_area'><select name='schedule_yn0' id='schedule_yn0' style='width:100%;'>";
						v_schedule_yn += "<option value='Y' selected >정기</option>";
						v_schedule_yn += "<option value='N'>비정기</option>";
						v_schedule_yn += "</select></div>";

						var v_post_approval_yn = "";
						v_post_approval_yn += "<div class='gridInput_area'><select name='post_approval_yn0' id='post_approval_yn0' style='width:100%;'>";
						v_post_approval_yn += "<option value='Y'>후결</option>";
						v_post_approval_yn += "<option value='N' selected>순차</option>";
						v_post_approval_yn += "</select></div>";
						
						rowsObj.push({
							'grid_idx': ""
							,'SELECT': ""
							,'ADMIN_LINE_GRP_CD': ""
							,'DOC_GUBUN': inputDoc_gubun
							,'ADMIN_LINE_GRP_NM': nm
							,'TOP_LEVEL_YN': v_top_level_yn
							,'SCHEDULE_YN': v_schedule_yn
							,'POST_APPROVAL_YN': v_post_approval_yn
						});
						
						if(items.attr('cnt')=='0'){
						}else{
							items.find('item').each(function(i){						
							
								var admin_line_grp_cd 	= $(this).find("ADMIN_LINE_GRP_CD").text();
								var admin_line_grp_nm 	= $(this).find("ADMIN_LINE_GRP_NM").text();
								var doc_gubun		 	= $(this).find("DOC_GUBUN").text();
								var top_level_yn		= $(this).find("TOP_LEVEL_YN").text();
								var schedule_yn			= $(this).find("SCHEDULE_YN").text();
								var post_approval_yn	= $(this).find("POST_APPROVAL_YN").text();

								var v_doc_gubun = "";
								v_doc_gubun += "<div class='gridInput_area'><select name='doc_gubun"+admin_line_grp_cd+"' id='doc_gubun"+admin_line_grp_cd+"' style='width:100%;'>";
								
								
								for(var j=0;j<arr_doc_gubun_cd.length;j++){
									
									v_doc_gubun_check = "";
									
									if(doc_gubun == arr_doc_gubun_cd[j].cd){										
										v_doc_gubun_check = "selected";
									}
									
									v_doc_gubun += "<option value='"+arr_doc_gubun_cd[j].cd+"' "+v_doc_gubun_check+">"+arr_doc_gubun_nm[j].nm+"</option>";
									
								}
								
								v_doc_gubun += "</select></div>";
								
								//var v_line_grp_cd = "<div><input type='hidden' name='line_grp_cd"+line_grp_cd+"' id='line_grp_cd"+line_grp_cd+"' value='"+line_grp_cd+"' /></div>";
								var v_admin_line_grp_nm 	= "<div class='gridInput_area'><input type='text' name='admin_line_grp_nm"+admin_line_grp_cd+"' id='admin_line_grp_nm"+admin_line_grp_cd+"' value='"+admin_line_grp_nm+"' style='width:100%;'/></div>";

								v_top_level_yn = "";
								v_top_level_yn += "<div class='gridInput_area'><select name='top_level_yn"+admin_line_grp_cd+"' id='top_level_yn"+admin_line_grp_cd+"' style='width:100%;'>";
								if(top_level_yn == "Y"){
									v_top_level_yn += "<option value='Y' selected>상위</option>";
									v_top_level_yn += "<option value='N'>일반</option>";	
								}else{
									v_top_level_yn += "<option value='Y'>상위</option>";
									v_top_level_yn += "<option value='N' selected>일반</option>";	
								}
								v_top_level_yn += "</select></div>";

								v_schedule_yn = "";
								v_schedule_yn += "<div class='gridInput_area'><select name='schedule_yn"+admin_line_grp_cd+"' id='schedule_yn"+admin_line_grp_cd+"' style='width:100%;'>";
								if(schedule_yn == "Y"){
									v_schedule_yn += "<option value='Y' selected>정기</option>";
									v_schedule_yn += "<option value='N'>비정기</option>";	
								}else{
									v_schedule_yn += "<option value='Y'>정기</option>";
									v_schedule_yn += "<option value='N' selected>비정기</option>";	
								}
								v_schedule_yn += "</select></div>";

								v_post_approval_yn = "";
								v_post_approval_yn += "<div class='gridInput_area'><select name='post_approval_yn"+admin_line_grp_cd+"' id='post_approval_yn"+admin_line_grp_cd+"' style='width:100%;'>";
								if(post_approval_yn == "Y"){
									v_post_approval_yn += "<option value='Y' selected>후결</option>";
									v_post_approval_yn += "<option value='N'>순차</option>";	
								}else{
									v_post_approval_yn += "<option value='Y'>후결</option>";
									v_post_approval_yn += "<option value='N' selected>순차</option>";	
								}
								v_post_approval_yn += "</select></div>";
								
								rowsObj.push({
									'grid_idx':i+1
									,'SELECT': "[선택]"
									,'ADMIN_LINE_GRP_CD': admin_line_grp_cd
									,'ADMIN_LINE_GRP_NM': v_admin_line_grp_nm
									,'DOC_GUBUN': v_doc_gubun
									,'TOP_LEVEL_YN': v_top_level_yn
									,'SCHEDULE_YN': v_schedule_yn
									,'POST_APPROVAL_YN': v_post_approval_yn
								});
								
							});						
						}
						
						gridObj_1.rows = rowsObj;
						setGridRows(gridObj_1);
												
					});
					try{viewProgBar(false);}catch(e){}
				}
		, null );
		
		xhr.sendRequest();
		
		clearSlickGridData(gridObj_2); 
	}
	
	function adminApprovalLineList(admin_line_grp_cd){
		
		$("#frm2").find("input[name=admin_line_grp_cd]").val(admin_line_grp_cd);
		
		
		try{viewProgBar(true);}catch(e){}
		$('#ly_total_cnt').html('');
		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=adminApprovalLine&itemGubun=2&admin_line_grp_cd='+admin_line_grp_cd;
		
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
						
						var inputGroup_user = "";
						inputGroup_user += "<div class='gridInput_area'><input type='hidden' id='group_line_grp_cd0' name='group_line_grp_cd0'/><input type='text' id='group_line_grp_nm0' name='group_line_grp_nm0' value='' style='width:100%;'/></div>";
												
						var inputPrc = "";
						inputPrc += "<div><a href=\"javascript:goProc('ins','"+admin_line_grp_cd+"','0');\"><font color='red'>[추가]</font></a></div>";
						
						var inputApproval_type = "";
						inputApproval_type += "<div class='gridInput_area'><select id='approval_type0' name='approval_type0' style='width:100%;'>"
						
						for(var j=0;j<arr_approval_type_cd.length;j++){							
							inputApproval_type += "<option value='"+arr_approval_type_cd[j].cd+"'>"+arr_approval_type_nm[j].nm+"</option>";
						}						
						inputApproval_type += "</select></div>"
						
						var inputApproval_gb = "";
						inputApproval_gb += "<div class='gridInput_area'><select id='approval_gb0' name='approval_gb0' style='width:100%;'>"
						
						for(var j=0;j<arr_approval_admin_gb_cd.length;j++){							
							inputApproval_gb += "<option value='"+arr_approval_admin_gb_cd[j].cd+"'>"+arr_approval_admin_gb_nm[j].nm+"</option>";
						}
						inputApproval_gb += "</select></div>"
						
						rowsObj.push({
							'grid_idx':""
							,'ADMIN_LINE_CD': ""
							,'ADMIN_LINE_GRP_CD': ""
							,'APPROVAL_NM': inputApproval_user
							,'GROUP_LINE_GRP_NM': inputGroup_user
							,'APPROVAL_SEQ': inputApproval_seq_no
							,'APPROVAL_TYPE': inputApproval_type
							,'APPROVAL_GB': inputApproval_gb
							,'PROC':inputPrc
						});
						
						if(items.attr('cnt')=='0'){
						}else{
							items.find('item').each(function(i){
							
								var admin_line_cd 		= $(this).find("ADMIN_LINE_CD").text();
								var admin_line_grp_cd 	= $(this).find("ADMIN_LINE_GRP_CD").text();								
								var approval_cd 		= $(this).find("APPROVAL_CD").text();
								var approval_nm 		= $(this).find("APPROVAL_NM").text();
								var user_id				= $(this).find("USER_ID").text();
								var group_line_grp_cd 	= $(this).find("GROUP_LINE_GRP_CD").text();
								var group_line_grp_nm 	= $(this).find("GROUP_LINE_GRP_NM").text();
								var duty_nm 			= $(this).find("DUTY_NM").text(); 
								var dept_nm 			= $(this).find("DEPT_NM").text(); 
// 								var user_info 			= approval_nm+"["+dept_nm+"]"+"["+duty_nm+"]";
								var user_info 			= approval_nm+"["+user_id+"]["+dept_nm+"]"+"["+duty_nm+"]";
								var approval_seq 		= $(this).find("APPROVAL_SEQ").text();
								var approval_type 		= $(this).find("APPROVAL_TYPE").text();
								var approval_gb 		= $(this).find("APPROVAL_GB").text();
								
								var v_approval_cd = "";
								v_approval_cd += "<input type='hidden' id='approval_cd"+admin_line_cd+"' name='approval_cd"+admin_line_cd+"' value='"+approval_cd+"' />";
								
								var v_group_line_grp_cd = "";
								v_group_line_grp_cd += "<input type='hidden' id='group_line_grp_cd"+admin_line_cd+"' name='group_line_grp_cd"+admin_line_cd+"' value='"+group_line_grp_cd+"' />";
								
								var v_approval_seq = "";
								v_approval_seq += "<div class='gridInput_area'><select id='approval_seq"+admin_line_cd+"' name='approval_seq"+admin_line_cd+"' style='width:100%;text-align:center;'>";
								
								for(var j=0;j<arr_approval_seq_cd.length;j++){
									
									v_approval_seq_check = "";
									
									if(approval_seq == arr_approval_seq_cd[j].cd){										
										v_approval_seq_check = "selected";
									}
									
									v_approval_seq += "<option value='"+arr_approval_seq_cd[j].cd+"' "+v_approval_seq_check+">"+arr_approval_seq_cd[j].cd+"</option>";
								}
								v_approval_seq += "</select></div>";
								
								if ( group_line_grp_nm != "" ) {
									user_info = "";
								}
								
								v_user_info = ""; 
								v_user_info += "<input type='text' id='approval_nm"+admin_line_cd+"' name='approval_nm"+admin_line_cd+"' value='"+user_info+"' style='width:100%;'/>";
								
								v_group_line_grp_nm = ""; 
								v_group_line_grp_nm += "<input type='text' id='group_line_grp_nm"+admin_line_cd+"' name='group_line_grp_nm"+admin_line_cd+"' value='"+group_line_grp_nm+"' style='width:100%;'/>";
								
								var v_proc 	= "<div>";
								v_proc 		+= "<a href=\"javascript:goProc('udt','"+admin_line_grp_cd+"','"+admin_line_cd+"');\"><font color='red'>[수정]</font></a> ";
								v_proc 		+= "<a href=\"javascript:goProc('del','"+admin_line_grp_cd+"','"+admin_line_cd+"');\"><font color='red'>[삭제]</font></a>";
								v_proc 		+= "</div>";
								
								var v_approval_gb = "";
								v_approval_gb += "<div class='gridInput_area'><select id='approval_gb"+admin_line_cd+"' name='approval_gb"+admin_line_cd+"' style='width:100%;text-align:center;'>";
								
								for(var j=0;j<arr_approval_admin_gb_cd.length;j++){
									
									v_approval_gb_check = "";
									
									if(approval_gb == arr_approval_admin_gb_cd[j].cd){										
										v_approval_gb_check = "selected";
									}
									
									v_approval_gb += "<option value='"+arr_approval_admin_gb_cd[j].cd+"' "+v_approval_gb_check+">"+arr_approval_admin_gb_nm[j].nm+"</option>";
								}
								v_approval_gb += "</select></div>";
								
								
								var v_approval_type = "";
								v_approval_type += "<div class='gridInput_area'><select id='approval_type"+admin_line_cd+"' name='approval_type"+admin_line_cd+"' style='width:100%;text-align:center;'>";
								
								for(var j=0;j<arr_approval_type_cd.length;j++){
									
									v_approval_type_check = "";
									
									if(approval_type == arr_approval_type_cd[j].cd){										
										v_approval_type_check = "selected";
									}
									
									v_approval_type += "<option value='"+arr_approval_type_cd[j].cd+"' "+v_approval_type_check+">"+arr_approval_type_nm[j].nm+"</option>";
								}
								v_approval_type += "</select></div>";
								
								rowsObj.push({
									'grid_idx':i+1
									,'ADMIN_LINE_CD': admin_line_cd
									,'ADMIN_LINE_GRP_CD': admin_line_grp_cd
									,'APPROVAL_NM': v_user_info
									,'APPROVAL_CD': v_approval_cd
									,'GROUP_LINE_GRP_NM': v_group_line_grp_nm
									,'GROUP_LINE_GRP_CD': v_group_line_grp_cd									
									,'APPROVAL_SEQ': v_approval_seq
									,'APPROVAL_TYPE': v_approval_type
									,'APPROVAL_GB': v_approval_gb
									,'PROC': v_proc
								});
								
							});						
						}
						$("#btn_udt").show();
						gridObj_2.rows = rowsObj;
						setGridRows(gridObj_2);
						$('#ly_total_cnt').html('[ TOTAL : '+items.attr('cnt')+' ]&nbsp;&nbsp;');
						
						
						// 사용자 자동 검색을 최초 저장 뿐만 아니라 수정도 가능하게 해야 하는 요건.
						// 해당 row의 admin_line_cd를 가져와서 $('#approval_nm' + sel_admin_line_cd) 이런식으로 셋팅을 해놔도 마지막 row의 admin_line_cd로만 인식하는 현상이 있음.
						// 그래서 getUserList 호출할 때 다시 한번 해당 row의 admin_line_cd를 가져와서 파라미터로 넘겨준다.
						// 2018.01.31 강명준 수정
						var aSelRow 	= new Array;
						aSelRow 		= gridObj_2.rows;
						
						if ( aSelRow.length > 0 ) {
							for ( var i = 1; i < aSelRow.length; i++ ) {
								var sel_admin_line_cd = "";
								sel_admin_line_cd = getCellValue(gridObj_2, i, "ADMIN_LINE_CD");
								
								//결재구분 값에 따라 disalbed 처리 - 개인결재인 경우, 결재구분 값만 세팅
								var approval_gb = $("#approval_gb"+sel_admin_line_cd).val();
								if (approval_gb != "00") {
									$("#approval_cd"+sel_admin_line_cd).val("");
									$("#group_line_grp_cd"+sel_admin_line_cd).val("");
									$("#approval_nm"+sel_admin_line_cd).val("");
									$("#group_line_grp_nm"+sel_admin_line_cd).val("");
									
									$("#approval_nm"+sel_admin_line_cd).prop("disabled", true);
									$("#group_line_grp_nm"+sel_admin_line_cd).prop("disabled", true);
								} else {
									$("#approval_nm"+sel_admin_line_cd).prop("disabled", false);
									$("#group_line_grp_nm"+sel_admin_line_cd).prop("disabled", false);
								}
								
								//결재자
// 								$('#approval_nm' + sel_admin_line_cd).unbind('keypress').keypress(function(e){
// 									//if(e.keyCode==13 && trim($(this).val())!=''){
// 									if(e.keyCode==13){
// 										var aSelRow 	= new Array;
// 										aSelRow = $('#'+gridObj_2.id).data('grid').getSelectedRows();
// 										if(aSelRow.length>0){
// 											for(var i=0;i<aSelRow.length;i++){
// 												admin_line_cd = getCellValue(gridObj_2,aSelRow[i],"ADMIN_LINE_CD");
// 											}
// 										}
										
// 										getUserList($(this).val(), admin_line_cd);
// 									}
// 								}).unbind('keyup').keyup(function(e){
// 									if($('#approval_cd' + sel_admin_line_cd).val()!='' && $(this).data('sel_v') != $(this).val()){
// 										$('#approval_cd' + sel_admin_line_cd).val('');
// 										$(this).removeClass('input_complete');
// 									}
// 								});
								
								//결재자그룹
// 								$('#group_line_grp_nm' + sel_admin_line_cd).unbind('keypress').keypress(function(e){
// 									//if(e.keyCode==13 && trim($(this).val())!=''){
// 									if(e.keyCode==13){
// 										var aSelRow 	= new Array;
// 										aSelRow = $('#'+gridObj_2.id).data('grid').getSelectedRows();
// 										if(aSelRow.length>0){
// 											for(var i=0;i<aSelRow.length;i++){
// 												admin_line_cd = getCellValue(gridObj_2,aSelRow[i],"ADMIN_LINE_CD");
// 											}
// 										}
// 										getGroupList($(this).val(), admin_line_cd);
// 									} 
// 								}).unbind('keyup').keyup(function(e){
// 									if($('#group_line_grp_cd' + sel_admin_line_cd).val()!='' && $(this).data('sel_v') != $(this).val()){
// 										$('#group_line_grp_cd' + sel_admin_line_cd).val('');
// 										$(this).removeClass('input_complete');
// 									}
// 								});
								
								//결재구분 값에 따라 disalbed 처리 - 개인결재인 경우, 결재구분 값만 세팅
								$("#approval_gb"+sel_admin_line_cd).change(function(){
									var aSelRow 	= new Array;
									aSelRow = $('#'+gridObj_2.id).data('grid').getSelectedRows();
									if(aSelRow.length>0){
										for(var i=0;i<aSelRow.length;i++){
											admin_line_cd = getCellValue(gridObj_2,aSelRow[i],"ADMIN_LINE_CD");
										}
									}
									
									var approval_gb = $(this).val();
									if (approval_gb != "00") {
										$("#approval_cd"+admin_line_cd).val("");
										$("#group_line_grp_cd"+admin_line_cd).val("");
										$("#approval_nm"+admin_line_cd).val("");
										$("#group_line_grp_nm"+admin_line_cd).val("");
										
										$("#approval_nm"+admin_line_cd).prop("disabled", true);
										$("#group_line_grp_nm"+admin_line_cd).prop("disabled", true);
									} else {
										$("#approval_nm"+admin_line_cd).prop("disabled", false);
										$("#group_line_grp_nm"+admin_line_cd).prop("disabled", false);
									}
								});
							}
						}
						
						// 검색 팝업형태로 변경
						$('input[id^=approval_nm]').unbind('click').click(function(){
							var user_idx = $(this).attr('id').replace("approval_nm","");
							goUserSearch(user_idx,user_idx);
						}).unbind('keyup').keyup(function(e){
							if($(this).val() != '' && (this).data('sel_v') != $(this).val()){
								$('#sel_v').val();
								$(this).removeClass('input_complete');
							}
						});
						
						$('input[id^=group_line_grp_nm]').unbind('click').click(function(){
							var user_idx = $(this).attr('id').replace("group_line_grp_nm","");
							goGroupSearch(user_idx,user_idx);
						}).unbind('keyup').keyup(function(e){
							if($(this).val() != '' && (this).data('sel_v') != $(this).val()){
								$('#sel_v').val();
								$(this).removeClass('input_complete');
							}
						});
						
						//결재자 추가
						$('#approval_nm0').unbind('keypress').keypress(function(e){
							//if(e.keyCode==13 && trim($(this).val())!=''){
								
								getUserList($(this).val(), 0);
							//}
						}).unbind('keyup').keyup(function(e){
							if($('#approval_cd0').val()!='' && $(this).data('sel_v') != $(this).val()){
								$('#approval_cd0').val('');
								$(this).removeClass('input_complete');
							}
						});
						
						//결재그룹 추가
						$('#group_line_grp_nm0').unbind('keypress').keypress(function(e){
							//if(e.keyCode==13 && trim($(this).val())!=''){
								getGroupList($(this).val(), 0);
							//}
						}).unbind('keyup').keyup(function(e){
							if($('#group_line_grp_cd0').val()!='' && $(this).data('sel_v') != $(this).val()){
								$('#group_line_grp_cd0').val('');
								
								$(this).removeClass('input_complete');
							}
						});
						
						//결재구분 추가
						$("#approval_gb0").change(function(){
							var approval_gb = $(this).val();
							if (approval_gb == "01") {
								$("#approval_cd0").val("");
								$("#group_line_grp_cd0").val("");
								$("#approval_nm0").val("");
								$("#group_line_grp_nm0").val("");
								
								$("#approval_nm0").prop("disabled", true);
								$("#group_line_grp_nm0").prop("disabled", true);
							} else {
								$("#approval_nm0").prop("disabled", false);
								$("#group_line_grp_nm0").prop("disabled", false);
							}
						});
						
					});
					try{viewProgBar(false);}catch(e){}
				}
		, null );
		
		xhr.sendRequest();
	}	
	
	//유저 검색 시 팝업형태로 변경하면서 works_common.js 호출하도록 변경
// 	function getUserList(user_id, arg){
	
<%-- 		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=userList&p_search_gubun=user_id&p_del_yn=N&p_search_text='+encodeURIComponent(user_id)+'&auto_yn=Y'; --%>
		
// 		var xhr = new XHRHandler(url, null
// 			,function(){
// 				var xmlDoc = this.req.responseXML;
				
// 				$(xmlDoc).find('doc').each(function(){
					
// 					var items = $(this).find('items');
					
// 					var aTags = new Array();
// 					if(items.attr('cnt')=='0'){
// 					}else{						
// 						items.find('item').each(function(i){						
// 							aTags.push({value: $(this).find('USER_NM').text() + '['+ $(this).find('USER_ID').text() + ']'+'['+$(this).find('DEPT_NM').text()+']'+'['+$(this).find('DUTY_NM').text()+']'
// 										,label:$(this).find('USER_NM').text() +'[' + $(this).find('USER_ID').text()+']'+'['+$(this).find('DEPT_NM').text()+']'+'['+$(this).find('DUTY_NM').text()+']'
// 										,user_cd:$(this).find('USER_CD').text()
// 										,dept_nm:$(this).find('DEPT_NM').text()
// 										,dept_cd:$(this).find('DEPT_CD').text()
// 										});
// 						});
// 					}
					
// 					try{ $("#approval_nm"+arg).autocomplete("destroy"); }catch(e){};
					
// 					$("#approval_nm"+arg).autocomplete({ 
// 						minLength: 0
// 						,source: aTags
// 						,autoFocus: false
// 						,focus: function(event, ui) {
									  
// 								}
// 						,select: function(event, ui) {
// 									$(this).val(ui.item.value);
// 									$("#approval_cd"+arg).val(ui.item.user_cd);
									
// 									$(this).data('sel_v',$(this).val());
// 									$(this).removeClass('input_complete').addClass('input_complete');
// 								}
// 						,disabled: false
// 						,create: function(event, ui) {
// 									$(this).autocomplete('search',$(this).val()); 
// 								}
// 						,close: function(event, ui) {
// 									$(this).autocomplete("destroy");
// 								}
// 						,open: function(){
// 					        setTimeout(function () {
// 					            $('.ui-autocomplete').css('z-index', 3000);
// 					        }, 10);
// 					    }
						
// 					}).data("autocomplete")._renderItem = function(ul, item) {
// 																return $("<li></li>" )
// 																	.data("item.autocomplete", item)
// 																	.append("<a>" + item.label + "</a>")
// 																	.appendTo(ul);
// 															};
					
// 				});
				
// 			}
// 		, null );
		
// 		xhr.sendRequest();
		
// 		$("#group_line_grp_nm"+arg).val("");     
// 		$("#group_line_grp_cd"+arg).val("");
// 	}
	
	function getGroupList(group_nm, arg){

		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=groupApprovalGroup&itemGubun=2&p_search_text='+encodeURIComponent(group_nm);
		
		var xhr = new XHRHandler(url, null
			,function(){
				var xmlDoc = this.req.responseXML;
				
				$(xmlDoc).find('doc').each(function(){
					
					var items = $(this).find('items');
					
// 					var aTags = new Array();
// 					if(items.attr('cnt')=='0'){
// 					}else{						
// 						items.find('item').each(function(i){						
// 							aTags.push({value:$(this).find('GROUP_LINE_GRP_NM').text()
// 										,label:$(this).find('GROUP_LINE_GRP_NM').text()
// 										,group_line_grp_cd:$(this).find('GROUP_LINE_GRP_CD').text()
// 										});
// 						});
// 					}

					var rowsObj = new Array();
					
					if(items.attr('cnt')=='0'){
					}else{
						items.find('item').each(function(i){

							var group_line_grp_cd = $(this).find("GROUP_LINE_GRP_CD").text();
							var group_line_grp_nm = $(this).find("GROUP_LINE_GRP_NM").text();

							rowsObj.push({'grid_idx':i+1
								,'GROUP_LINE_GRP_CD':group_line_grp_cd
								,'GROUP_LINE_GRP_NM':group_line_grp_nm
								,'CHOICE':"<div><a href=\"javascript:goGroupSeqSelect('"+group_line_grp_cd+"', '"+group_line_grp_nm+"', '"+arg+"');\" ><font color='red'>[선택]</font></a></div>"
							});

						});

					}
					var obj = $("#g_tmp3").data('gridObj');
					obj.rows = rowsObj;
					setGridRows(obj);

					$('#ly_total_cnt3').html('[ TOTAL : '+items.attr('cnt')+' ]');
					
					try{ $("#group_line_grp_nm"+arg).autocomplete("destroy"); }catch(e){};
					
// 					$("#group_line_grp_nm"+arg).autocomplete({
// 						minLength: 0
// 						,source: aTags
// 						,autoFocus: false
// 						,focus: function(event, ui) {
									
// 								}
// 						,select: function(event, ui) {
// 									$(this).val(ui.item.value);
// 									$("#group_line_grp_cd"+arg).val(ui.item.group_line_grp_cd);
									
// 									$(this).data('sel_v',$(this).val());
// 									$(this).removeClass('input_complete').addClass('input_complete');
// 								}
// 						,disabled: false
// 						,create: function(event, ui) {
// 									$(this).autocomplete('search',$(this).val()); 
// 								}
// 						,close: function(event, ui) {
// 									$(this).autocomplete("destroy");
// 								}
// 						,open: function(){
// 					        setTimeout(function () {
// 					            $('.ui-autocomplete').css('z-index', 3000);
// 					        }, 10);
// 					    }
						
// 					}).data("autocomplete")._renderItem = function(ul, item) {
// 																return $("<li></li>" )
// 																	.data("item.autocomplete", item)
// 																	.append("<a>" + item.label + "</a>")
// 																	.appendTo(ul);
// 															};
					
				});
				
			}
		, null );
		
		xhr.sendRequest();
		
		$("#approval_cd"+arg).val("");      
		$("#approval_nm"+arg).val("");
		
		$("#group_line_grp_cd"+arg).val("");      
		$("#group_line_grp_nm"+arg).val("");
	}
	
	function goProc(flag, admin_line_grp_cd, admin_line_cd){
		
		var frm = document.frm2;
		var msg = "";
		
		var approval_cd 		= $("#frm2 #approval_cd" + admin_line_cd); // 결재자
		var group_line_grp_cd 	= $("#frm2 #group_line_grp_cd" + admin_line_cd); // 결재그룹
		var approval_seq		= $("#frm2 #approval_seq" + admin_line_cd); // 결재순서
		var approval_gb			= $("#frm2 #approval_gb" + admin_line_cd); // 결재구분
		var approval_type		= $("#frm2 #approval_type" + admin_line_cd); // 결재유형
		 
		if ( flag != "del" ) { 
			if ( flag == "ins" ) { 
				if ( approval_cd.val() != "" && group_line_grp_cd.val() != "") {
					alert("결재자 or 결재그룹을 하나만 입력 가능합니다.");  
					return;
				}
			}
			if ( approval_cd.val() == "" && group_line_grp_cd.val() == ""  && !("01" == approval_gb.val())) {
				alert("결재자 or 결재그룹을 선택해 주세요.");
				return;
			}
		}
		
		//하나의 필수결재그룹 안에 여러개의 개인결재선 등록 방지 (2021.04.05. 김수정)
		var admin_line_cd_val 	= "";
		var approval_gb_val 	= "";
		var approval_gb_cnt 	= 0;
		
		for (var i = 0; i < gridObj_2.rows.length; i++) { //입력줄 제외
			if (i == 0) {
				approval_gb_val 	= $("#approval_gb0").val();
			} else {
				admin_line_cd_val 	= getCellValue(gridObj_2,i,'ADMIN_LINE_CD');
				approval_gb_val 	= $("#approval_gb"+admin_line_cd_val).val();				
			}
			
			if ("01" == approval_gb_val)
				approval_gb_cnt++;
		}
		
		if (approval_gb_cnt > 1 && flag == "ins") {
			alert("[결재구분] 개인결재는 각 결재그룹에서 한번만 사용이 가능합니다.");
			return;
		}
		
		if(confirm("처리하시겠습니까?")) {
			
			frm.approval_cd.value		= approval_cd.val();
			frm.group_line_grp_cd.value	= group_line_grp_cd.val();
			frm.approval_seq.value		= approval_seq.val();
			frm.approval_gb.value		= approval_gb.val();
			frm.approval_type.value		= approval_type.val();
			
			frm.flag.value 				= flag;
			frm.admin_line_grp_cd.value = admin_line_grp_cd;
			frm.admin_line_cd.value 	= admin_line_cd;
			frm.target 					= "if1";
			frm.action 					= "<%=sContextPath%>/tWorks.ez?c=ezAdminApprovalLine_p";
			
			frm.submit();
		}
	}
	
	//검색 팝업형태로 변경
	function goUserSeqSelect(cd, nm, btn, sel_line_cd){
		
		$("#approval_nm"+ sel_line_cd).val(nm);
		$("#approval_cd"+ sel_line_cd).val(cd);;

		dlClose('dl_tmp3');
	}
	
	//검색 팝업형태로 변경
	function goGroupSeqSelect(cd, nm, sel_line_cd){
		
		$("#group_line_grp_nm"+ sel_line_cd).val(nm);
		$("#group_line_grp_cd"+ sel_line_cd).val(cd);;

		dlClose('dl_tmp3');
	}
	function goPrc2(admin_cd, approval_cd, group_line_grp_cd, approval_gb, approval_type, approval_seq) {
		var frm = document.frm2;
		
		
		if(confirm("처리하시겠습니까?")) {
		
			frm.flag.value 				= "group_udt";
			frm.admin_line_cd.value 	= admin_cd;
			frm.approval_cd.value 		= approval_cd;
			frm.group_line_grp_cd.value = group_line_grp_cd;
			frm.approval_seq.value 		= approval_seq;
			frm.approval_gb.value 		= approval_gb;
			frm.approval_type.value 	= approval_type;
			frm.target 				= "if1";
			frm.action 				= "<%=sContextPath%>/tWorks.ez?c=ezAdminApprovalLine_p";
			
			frm.submit();		
		}		
	}
	
</script>