<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/jsp/common/inc/header.jsp"%>

<%
	Map<String, Object> paramMap = CommonUtil.collectParameters(request);
	String c = CommonUtil.isNull(paramMap.get("c"));
	String gridId = "g_"+c;

	String strMenuGb = CommonUtil.isNull(paramMap.get("menu_gb"));
	String menu_gb = CommonUtil.getMessage("CATEGORY.GB.09.GB."+strMenuGb);
	String[] arr_menu_gb = menu_gb.split(",");
	
	String odate = (String)request.getAttribute("ODATE");
	odate = odate.replace("/", "");
	
	//스크롤 페이징
	String strPagingNum			= CommonUtil.getMessage("PAGING.NUM");
%>

<form id="f_s" name="f_s" method="post" onsubmit="return false;">
	<input type="hidden" id="menu_gb" 		name="menu_gb" value="<%= strMenuGb%>" />
	
	<input type='hidden' id='p_s_odate' 	name='p_s_odate'/>
	<input type='hidden' id='p_e_odate' 	name='p_e_odate'/>
	
	<input type='hidden' id='data_center' 	name='data_center'/>
	<input type='hidden' id='p_dept_nm' 	name='p_dept_nm'/>
	
	<input type="hidden" 	id="startRowNum"				name="startRowNum"		value="0" />
	<input type="hidden" 	id="pagingNum"					name="pagingNum"	 	value="<%=strPagingNum%>" />
</form>

<table style='width:100%;height:100%;border:none;'>
	<tr style='height:10px;'>
		<td style='vertical-align:top;'>
			<h4 class="ui-widget-header ui-corner-all"  >
				<div id='t_<%=gridId %>' class='title_area' >
					<span><%=CommonUtil.isNull(CommonUtil.getMessage("CATEGORY.GB.09"))%> > <%=CommonUtil.isNull(arr_menu_gb[0]) %></span>
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
					<th width="10%"><div class='cellTitle_kang2' style='min-width:120px;'>C-M</div></th>
					<td width="20%" style="text-align:left">
						<div class='cellContent_kang' style='width:200px;'>
						<select id="data_center_items" name="data_center_items" style="width:150px; height:21px;">
							<option value="">--선택--</option>
							<c:forEach var="cm" items="${cm}" varStatus="status">
								<option value="${cm.scode_cd},${cm.scode_eng_nm}">${cm.scode_nm}</option>
							</c:forEach>
						</select>
						</div>
					</td>
									
					<th width="10%"><div class='cellTitle_kang2' style='min-width:120px;'>발생일자</div></th>
					<td width="20%" style="text-align:left">
						<div class='cellContent_kang' style='width:200px;'>
						<input type="text" name="s_odate" id="s_odate" value="<%=odate %>" class="input datepick" style="width:70px; height:21px;" maxlength="8" onclick="dpCalMin('s_odate','yymmdd');" />
						 ~<input type="text" name="e_odate" id="e_odate" value="<%=odate %>" class="input datepick" style="width:70px; height:21px;" maxlength="8" onclick="dpCalMin('e_odate','yymmdd');" />
						</div>
					</td>
					<th width="10%"><div class='cellTitle_kang2' style='min-width:50px;'>부서</div></th>
					<td width="20%" style="text-align:left"><div class='cellContent_kang'>
						<input type="text" name="dept_nm" id="dept_nm" style="width:150px; height:21px;"/>
					</div></td>
					<td style="text-align:right;">
						<span id="btn_search" style='margin:3px;'>검 색</span>
					</td>
				</tr>
			</table>
			</h4>
			</form>
		</td>
	</tr>
	<tr>
		<td id='ly_<%=gridId %>' style='vertical-align:top;' >
			<div id="<%=gridId %>" class="ui-widget-header ui-corner-all" ></div>
		</td>
	</tr>
	<tr style='height:10px;'>
		<td style='vertical-align:top;'>
			<h4 class="ui-widget-header ui-corner-all" >
				<div align='right' class='btn_area' >
					<div id='ly_total_cnt' style='padding-top:5px;float:left;'></div>
					<span id="btn_excel">엑셀다운</span>
				</div>
			</h4>
		</td>
	</tr>
</table>

<script>
	var listChk = false;
	
	var gridObj = {
		id : "<%=gridId %>"
		,colModel:[
					{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'번호',minWidth:30,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
					,{formatter:gridCellNoneFormatter,field:'jobschedgb',id:'jobschedgb',name:'작업종류',minWidth:80,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
					,{formatter:gridCellNoneFormatter,field:'job_name',id:'job_name',name:'작업명',minWidth:200,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
					,{formatter:gridCellNoneFormatter,field:'host_time',id:'host_time',name:'발생시간',minWidth:150,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
					,{formatter:gridCellNoneFormatter,field:'action_date',id:'action_date',name:'조치시간',minWidth:130,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
					,{formatter:gridCellNoneFormatter,field:'udt_user_nm',id:'udt_user_nm',name:'조치자',minWidth:100,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
					,{formatter:gridCellNoneFormatter,field:'error_description',id:'error_description',name:'원인 및 조치내용',minWidth:250,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
					,{formatter:gridCellNoneFormatter,field:'message',id:'message',name:'메시지',minWidth:120,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
					,{formatter:gridCellNoneFormatter,field:'dept_nm',id:'dept_nm',name:'부서',minWidth:90,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
					,{formatter:gridCellNoneFormatter,field:'duty_nm',id:'duty_nm',name:'직급',minWidth:90,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
					,{formatter:gridCellNoneFormatter,field:'user_nm',id:'user_nm',name:'담당자',minWidth:100,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}

			   	]
		,rows:[]
		,vscroll:false
	};
	
	$(document).ready(function(){
		
		viewGrid_1(gridObj,"ly_"+gridObj.id,{enableColumnReorder:true},'AUTO');
		
		//버튼
		$("#btn_search").button().unbind("click").click(function(){
			var data_center = $("#data_center_items").val();
			if (data_center == "") {
				alert("C-M 을 선택해 주세요.");
				return;
			}
			
			$("#p_s_odate").val($("#s_odate").val());
			$("#p_e_odate").val($("#e_odate").val());
			$("#p_dept_nm").val($("#dept_nm").val());
			
			if ( $("#s_odate").val() != "" && $("#e_odate").val() != "" ) {
				
				// 날짜 기간 체크
				if ( $("#s_odate").val() > $("#e_odate").val() ) {
					alert("일자의 FROM ~ TO를 확인해 주세요.");
					return;
				}
				
				// 날짜 정합성 체크
				if(!isValidDate($("#s_odate").val()) || !isValidDate($("#e_odate").val())){ 
					alert("잘못된 날짜입니다."); 
					return;
				}
			}
			setTimeout(function(){
				errorLogTotal();
			}, 1000);
		});
		
		// 부서 엔터
		$('#dept_nm').unbind('keypress').keypress(function(e) {
			if(e.keyCode==13){
				$("#btn_search").trigger("click");
			}
		});
		
		$("#btn_excel").button().unbind("click").click(function(){
			var data_center = $("#data_center_items").val();
			if (data_center == "") {
				alert("C-M 을 선택해 주세요.");
				return;
			}
			
			goExcel();
		});

		var S_D_C_CODE 		= "<%=S_D_C_CODE%>"; 	//사용자의 select_data_center
		
		//C-M 세팅
		if(S_D_C_CODE != "") { // 개인정보에 C-M이 등록되어 있을경우
			$("#data_center_items").val(S_D_C_CODE);
			$("#data_center").val(S_D_C_CODE);
		}else { // 개인정보에 C-M이 등록이 되어있지 않을경우 -> C-M 콤보박스에서 첫번째값 선택
			$("#data_center_items option:eq(1)").prop("selected", true);
			$("#data_center").val($("select[name='data_center_items']").val());
		}
		
		$("#data_center_items").change(function(){
			$("#data_center").val($(this).val());
		});
		
		//스크롤 페이징
		var grid = $('#'+gridObj.id).data('grid');
		grid.onScroll.subscribe(function(e, args){
			var elem = $("#g_errorLogTotal").children(".slick-viewport"); 
			if ( elem[0].scrollHeight - elem.scrollTop() - elem.css("height").replace("px", "") + 17 < 100) {
				if(listChk) {
					listChk = false;
					var startRowNum = parseInt($("#startRowNum").val());
					startRowNum += parseInt($('#pagingNum').val());
					errorLogTotal(startRowNum);
				}
			}
		});
	})
	
	function errorLogTotal(startRowNum) {
		
		//페이징 처리
		if(startRowNum != '' && startRowNum != null && startRowNum != undefined) {
			$('#startRowNum').val(startRowNum);
		} else {
			var elem = $("#g_errorLogTotal").children(".slick-viewport");
			elem.scrollTop(0);
			startRowNum = 0;
			$('#startRowNum').val(0);
		}
		
		try{viewProgBar(true);}catch(e){}
		
		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=errorLogTotal&itemGubun=2';
		
		var xhr = new XHRHandler(url, f_s, function(){
			
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
						
						var jobschedgb			= $(this).find("jobschedgb").text();
						var job_name 			= $(this).find("job_name").text();
						var host_time			= $(this).find("host_time").text();
						var action_date			= $(this).find("action_date").text();
						var udt_user_nm			= $(this).find("udt_user_nm").text();
						var error_description 	= $(this).find("error_description").text();
						var message				= $(this).find("message").text();
						var dept_nm				= $(this).find("dept_nm").text();
						var duty_nm 			= $(this).find("duty_nm").text();
						var user_nm 			= $(this).find("user_nm").text();
						
						rowsObj.push({
// 							'grid_idx':i+1
							'grid_idx'	: i+1+startRowNum
							,'jobschedgb': jobschedgb
							,'job_name': job_name
							,'host_time': host_time
							,'action_date': action_date
							,'udt_user_nm' : udt_user_nm
							,'error_description': error_description
							,'message': message
							,'dept_nm': dept_nm
							,'duty_nm': duty_nm
							,'user_nm': user_nm
						});
					});						
				}
				
				gridObj.rows = rowsObj;
				setGridRows(gridObj);
				$('body').resizeAllColumns();
				
				// 페이징처리
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
	
	function goExcel() {
		var frm = document.f_s;
		
		try{viewProgBar(true);}catch(e){}
		
		frm.action = "<%=sContextPath %>/tWorks.ez?c=errorLogTotalExcel";
		frm.target = "if1";
		frm.submit();
		
		try{viewProgBar(false);}catch(e){}
	}
</script>