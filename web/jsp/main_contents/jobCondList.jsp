<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/jsp/common/inc/header.jsp"%>

<%
	Map<String, Object> paramMap = CommonUtil.collectParameters(request);
	String c = CommonUtil.isNull(paramMap.get("c"));
	String gridId = "g_"+c;
	
	List dataCenterList = (List)request.getAttribute("dataCenterList");
	
	String menu_gb = CommonUtil.getMessage("CATEGORY.GB.06.GB."+CommonUtil.isNull(paramMap.get("menu_gb")));
	
	String[] arr_menu_gb = menu_gb.split(",");
	
	// 세션값 가져오기.
	String strSessionDcCode 	= S_D_C_CODE;
		
%>

<form id="f_s" name="f_s" method="post" onsubmit="return false;">	

	<input type='hidden' id='data_center_code' name='data_center_code'/>
	<input type='hidden' id='data_center' name='data_center'/>
	<input type='hidden' id='p_data_center' name='p_data_center'/>
	<input type='hidden' id='active_net_name' name='active_net_name'/>
	<input type='hidden' id='p_application_of_def' name='p_application_of_def'/>
	<input type='hidden' id='p_group_name_of_def' name='p_group_name_of_def'/>
	<input type='hidden' id='p_s_cond_name' name='p_s_cond_name'/>
	<input type='hidden' id='p_s_cond_date' name='p_s_cond_date'/>
	<input type='hidden' id='p_e_cond_date' name='p_e_cond_date'/>
	
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
			<input type='hidden' id='odate' name='odate'/>
			<input type='hidden' id='condition' name='condition'/>
			<input type='hidden' id='data_center' name='data_center'/>
			<h4 class="ui-widget-header ui-corner-all">
			<table style='width:100%;'>
				<tr>
					<th width="10%"><div class='cellTitle_kang2'>C-M</div></th>
					<td width="20%" style="text-align:left">
						<div class='cellContent_kang'>
						<select id="data_center_items" name="data_center_items" style="width:50%; height:21px;">
							<option value="">--선택--</option>
							<c:forEach var="cm" items="${cm}" varStatus="status">
								<option value="${cm.scode_cd},${cm.scode_eng_nm}">${cm.scode_nm}</option>
							</c:forEach>
						</select>
						</div>
					</td>
									
					<th width="10%"><div class='cellTitle_kang2'>날짜</div></th>
					<td width="20%" style="text-align:left">
						<div class='cellContent_kang'>
						<input type="text" name="s_cond_date" id="s_cond_date" value="${ODATE}" class="input datepick" style="width:75px; height:21px;" maxlength="10" readOnly/> ~
						<input type="text" name="e_cond_date" id="e_cond_date" value="${ODATE}" class="input datepick" style="width:75px; height:21px;" maxlength="10" readOnly/>
						</div>
					</td>
					
					<th width="10%"><div class='cellTitle_kang2'>컨디션명</div></th>
					<td width="29%" style="text-align:left">
						<div class='cellContent_kang'>
						<input type="text" name="s_cond_name" id="s_cond_name" value="" class="input" style="width:150px; height:21px;"/>
						</div>
					</td>
				</tr>
				<tr>				
					<td style="text-align:right" colspan="6">
						<span id="btn_search" style='display:none;'>검색</span>
<%-- 						<img id="btn_search" src='<%=sContextPath%>/imgs/btn_SRC.gif' style='border:0;vertical-align:top;cursor:pointer;' /> --%>
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
					<span id="btn_delete">삭제</span>
					<span id="btn_delete_history">삭제 이력</span>
					<span id="btn_down">엑셀다운</span>
				</div>
			</h4>
		</td>
	</tr>
</table>
<script>
		
	var gridObj = {
		id : "<%=gridId %>"
		,colModel:[
	   		{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'번호',width:50,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'COND_NAME',id:'COND_NAME',name:'컨디션명',width:300,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'COND_DATE',id:'COND_DATE',name:'날짜',width:150,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	   	]
		,rows:[]
		,vscroll:<%=S_GRID_VSCROLL%>
	};
	
	$(document).ready(function(){
		
		var session_dc_code	= "<%=strSessionDcCode%>";
		
		$("#btn_search").show();
			
		var frm = document.frm1;
		var data_center = "";
		if( null != document.getElementById('data_center_items') ){
			var sTmp = document.getElementById('data_center_items').value ;
			var aTmp = sTmp.split(",");
						
			$("#f_s").find("input[name='data_center_code']").val(aTmp[0]);
			$("#f_s").find("input[name='data_center']").val(aTmp[1]);
			$("#f_s").find("input[name='active_net_name']").val(aTmp[2]);
			
			data_center = aTmp[1];
		}
		
		$("#f_s").find("input[name='p_s_cond_name']").val($("#frm1").find("input[name='s_cond_name']").val());
		$("#f_s").find("input[name='p_s_cond_date']").val("${ODATE}");
		$("#f_s").find("input[name='p_e_cond_date']").val("${ODATE}");
				
<%-- 		setSelectItemList('<%=sContextPath %>/common.ez?c=cData&itemType=select&itemGb=searchItemList&searchType=application_of_defList&data_center='+data_center); --%>
				
		viewGridChk_1(gridObj,"ly_"+gridObj.id);
		
		//초기 검색조건 - C-M, 폴더, 어플리케이션, 그룹
		if(session_dc_code != "") { // 개인정보에 C-M이 등록되어 있을경우
			$("select[name='data_center_items']").val(session_dc_code);
			$("#f_s").find("input[name='data_center']").val(session_dc_code);
		}else { // 개인정보에 C-M이 등록이 되어있지 않을경우 -> C-M 콤보박스에서 첫번째값 선택
			$("#data_center_items option:eq(1)").prop("selected", true);
			$("#f_s").find("input[name='data_center']").val($("select[name='data_center_items']").val());
		}
		
		jobCondList();
		
		$("#btn_search").button().unbind("click").click(function(){
			
			$("#f_s").find("input[name='p_search_gubun']").val($("#frm1").find("select[name='search_gubun'] option:selected").val());
			$("#f_s").find("input[name='p_search_text']").val($("#frm1").find("input[name='search_text']").val());
			$("#f_s").find("input[name='p_application_of_def']").val($("#frm1").find("select[name='application_of_def'] option:selected").val());
			$("#f_s").find("input[name='p_group_name_of_def']").val($("#frm1").find("select[name='group_name_of_def'] option:selected").val());
			$("#f_s").find("input[name='p_s_ins_date']").val($("#frm1").find("input[name='s_ins_date']").val());
			$("#f_s").find("input[name='p_e_ins_date']").val($("#frm1").find("input[name='e_ins_date']").val());
			
			jobCondList();
		});
		
		
		$('#s_cond_name').unbind('keypress').keypress(function(e){			
			if(e.keyCode==13){	
				$("#f_s").find("input[name='p_search_gubun']").val($("#frm1").find("select[name='search_gubun'] option:selected").val());
				$("#f_s").find("input[name='p_search_text']").val($("#frm1").find("input[name='search_text']").val());
				$("#f_s").find("input[name='p_application_of_def']").val($("#frm1").find("select[name='application_of_def'] option:selected").val());
				$("#f_s").find("input[name='p_group_name_of_def']").val($("#frm1").find("select[name='group_name_of_def'] option:selected").val());
				$("#f_s").find("input[name='p_s_ins_date']").val($("#frm1").find("input[name='s_ins_date']").val());
				$("#f_s").find("input[name='p_e_ins_date']").val($("#frm1").find("input[name='e_ins_date']").val());
				
				jobCondList();
			}
		});
		
		$("#data_center_items").change(function(){		//C-M
			$("#f_s").find("input[name='p_data_center']").val($("select[name='data_center_items'] option:selected").val());
// 			setSearchItemList('sched_tableList', 'data_center_items');	
		});
				
		$("#application_of_def").change(function(){		//GRP
					
			setSearchItemList('group_name_of_defList', 'application_of_def');
		});
		
		$("#btn_down").button().unbind("click").click(function(){
			goExcel();
		});
		
		$("#btn_delete").button().unbind("click").click(function(){
			goPrc();
		});
		
		$("#btn_delete_history").button().unbind("click").click(function(){
			popupcondHistory();
		});
		
		$("#s_cond_date").addClass("ime_readonly").unbind('click').click(function(){
			dpCalMin(this.id,'mmdd');
		});
		
		$("#e_cond_date").addClass("ime_readonly").unbind('click').click(function(){
			dpCalMin(this.id,'mmdd');
		});
	
		
	});
			
	function jobCondList(){
		
		$("#f_s").find("input[name='p_s_cond_name']").val($("#frm1").find("input[name='s_cond_name']").val());
		$("#f_s").find("input[name='p_s_cond_date']").val($("#frm1").find("input[name='s_cond_date']").val());
		$("#f_s").find("input[name='p_e_cond_date']").val($("#frm1").find("input[name='e_cond_date']").val());
		$("#f_s").find("input[name='p_data_center']").val($("select[name='data_center_items'] option:selected").val());
		var data_center = $("select[name='data_center_items'] option:selected").val();
		
		if ( $("#p_s_cond_date").val() != "" && $("#p_e_cond_date").val() != "" ) {
			
			// 날짜 기간 체크
			if ( $("#p_s_cond_date").val() > $("#p_e_cond_date").val() ) {
				alert("일자의 FROM ~ TO를 확인해 주세요.");
				return;
			}
		}
		
		if(data_center == ""){
			alert("C-M 을 선택해 주세요.");
			return;
		}				
		try{viewProgBar(true);}catch(e){}
		$('#ly_total_cnt').html('');
		
		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=jobCondList';
		
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
															
								var cond_name = $(this).find("COND_NAME").text();
								var cond_date = $(this).find("COND_DATE").text();
																																														
								rowsObj.push({
									'grid_idx':i+1
									,'COND_NAME': cond_name
									,'COND_DATE': cond_date
									
								});
								
							});						
						}
						
						gridObj.rows = rowsObj;
						setGridRows(gridObj);
						$('#ly_total_cnt').html('[ TOTAL : '+items.attr('cnt')+' ]');
						
					});
					try{viewProgBar(false);}catch(e){}
				}
		, null );
		
		xhr.sendRequest();
	}
	
	function goExcel(){
		var frm = document.f_s;
		
		frm.action = "<%=sContextPath %>/mEm.ez?c=ez019_excel";
		frm.target = "if1";
		frm.submit();
	}
	
	function goPrc() {
		var frm = document.frm1;
		
		var total_cnt 				= 0;
		frm.data_center.value 		= $("#f_s").find("input[name='data_center']").val().split(',')[1];
				

		var odate 		= "";
		var job_name 	= "";
		
		var aSelRow = new Array;
		aSelRow = $('#'+gridObj.id).data('grid').getSelectedRows();
		if(aSelRow.length>0){
			for(var i=0;i<aSelRow.length;i++){
				
				if(i>0) {
					odate += ",";
					job_name += ",";
				}
				odate 		+= getCellValue(gridObj,aSelRow[i],'COND_DATE');
				job_name 	+= getCellValue(gridObj,aSelRow[i],'COND_NAME');
				
				total_cnt++;
			}
			frm.condition.value		= job_name;
			frm.odate.value			= odate;
		}else{
			alert("삭제할 컨디션을 선택(검색) 해주세요.");
			return;
		}


		if(total_cnt == 0) {
			alert("삭제할 컨디션을 선택(검색) 해주세요.");
			return;
		}


		if(!confirm(total_cnt + "건을 삭제 하시겠습니까?") ) return;

		try{viewProgBar(true);}catch(e){}
		
		frm.action = "<%=sContextPath %>/mEm.ez?c=ez019_p";
		frm.target = "if1";
		frm.submit();
		
		clearGridSelected(gridObj);
		
	}
	
	function gocondHistory(){
		var frm = document.frm1;
		frm.action = "<%=sContextPath %>/mEm.ez?c=ez019_condition_history";
		frm.target = "if1";
		frm.submit();
	}
	
	function popupcondHistory() {
		
		var sHtml1="<div id='condHistory' style='overflow:hidden;display:none;padding:0;border-top:1px solid blue;border-bottom:1px solid blue;border-left:1px solid blue;border-right:1px solid blue;'>";
		sHtml1+="<form id='condHistoryForm' name='condHistoryForm' method='post' onsubmit='return false;'>";
		sHtml1+="<table style='width:100%;height:100%;border:none;'>"; //table 시작
		sHtml1+="<tr>"; // tr
		sHtml1+="<td style='vertical-align:top;height:100%;width:500px;text-align:right;' colspan=2>";
		sHtml1+="<div class='ui-widget-header ui-corner-all'>";
		sHtml1+="삭제일자 : ";
		sHtml1+="<input tpye='text' name='p_search_s_date' id='p_search_s_date' class='input datepick' style='width:80px;height:21px;' maxlength='8'> ~ ";
		sHtml1+="<input tpye='text' name='p_search_e_date' id='p_search_e_date' class='input datepick' style='width:80px;height:21px;margin-right:25px;' maxlength='8'>";
		sHtml1+="&nbsp;컨디션명 : ";
		sHtml1+="<input type='text' name='p_search_text' id='p_search_text' style='width:120px;'/>"
		sHtml1+="&nbsp;&nbsp;<span id='btn_search' >검색</span>";
		sHtml1+="</div>";
		sHtml1+="</td>";
		sHtml1+="</tr>"; // /tr
		sHtml1+="<tr style='height:480px;'>"; // tr
		sHtml1+="<td id='ly_condHistoryGrid' style='vertical-align:top;' colspan=2>";
		sHtml1+="<div id='condHistoryGrid' class='ui-widget-header ui-corner-all'></div>";
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
		
		$('#condHistory').remove();
		$('body').append(sHtml1);
		
		dlPop02('condHistory',"컨디션 이력",690,560,false);
				
		var gridObj = {
			id : "condHistoryGrid"
			,rows:[]
			,vscroll:false
		};
		
		var codeColModel = [];
			codeColModel = [
	   				{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'번호',width:50,minWidth:50,headerCssClass:'cellCenter',cssClass:'cellCenter'}
					,{formatter:gridCellNoneFormatter,field:'COND_NAME',id:'COND_NAME',name:'컨디션명',width:250,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
					,{formatter:gridCellNoneFormatter,field:'COND_DATE',id:'COND_DATE',name:'날짜',width:80,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
					,{formatter:gridCellNoneFormatter,field:'USER_NM',id:'USER_NM',name:'처리자',width:80,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	   				,{formatter:gridCellNoneFormatter,field:'INS_DATE',id:'INS_DATE',name:'삭제일자',width:200,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
		   			];
		gridObj.colModel = codeColModel;
		
		
		viewGrid_1(gridObj,"ly_"+gridObj.id);
		
		
		$("#condHistoryForm").find("#btn_search").button().unbind("click").click(function(){
			if($("#p_search_s_date").val() != "" && $("#p_search_e_date").val() != "" ) {
				// 날짜 기간 체크
				if( parseInt($("#p_search_s_date").val()) > parseInt($("#p_search_e_date").val()) ) {
					alert("삭제 일자의 FROM ~ TO를 확인해 주세요.");
					return;
				}
				
				if( !isValidDate($("#p_search_s_date").val()) || !isValidDate($("#p_search_e_date").val()) ){
					alert("잘못된 날짜입니다."); 
					return;
				}
			}
			
			condHsitoryList();
		});
		
		$("#condHistoryForm").find('#p_search_text').unbind('keypress').keypress(function(e){			
			if(e.keyCode==13){	
				if($("#p_search_s_date").val() != "" && $("p_search_e_date").val() != "" ) {
					// 날짜 기간 체크
					if( parseInt($("#p_search_s_date").val()) > parseInt($("#p_search_e_date").val()) ) {
						alert("삭제 일자의 FROM ~ TO를 확인해 주세요.");
						return;
					}
					if( !isValidDate($("#p_search_s_date").val()) || !isValidDate($("#p_search_e_date").val()) ){
						alert("잘못된 날짜입니다."); 
						return;
					}
				}
				condHsitoryList();
			}
		});
		
		$("#p_search_s_date").addClass("text_input").unbind('click').click(function(){
			dpCalMin(this.id,'yymmdd');
		});
		
		$("#p_search_e_date").addClass("text_input").unbind('click').click(function(){
			dpCalMin(this.id,'yymmdd');
		});
		
		$("#condHistoryForm").find("#btn_excel").button().unbind("click").click(function(){
			
			var frm = document.condHistoryForm;
			frm.action = "<%=sContextPath %>/mEm.ez?c=ez019_history_excel";
			frm.target = "if1";
			frm.submit();
		});
		
	}
	
	function condHsitoryList(){
		
		try{viewProgBar(true);}catch(e){}
		$('#ly_total_cnt').html('');
		
		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=jobCondHistoryList';
		
		var rows = [];
		
		var xhr = new XHRHandler(url, condHistoryForm
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
															
								var cond_name = $(this).find("COND_NAME").text();
								var cond_date = $(this).find("COND_DATE").text();
								var user_nm   = $(this).find("USER_NM").text();
								var ins_date  = $(this).find("INS_DATE").text();
																																														
								rowsObj.push({
									'grid_idx':i+1
									,'COND_NAME': cond_name
									,'COND_DATE': cond_date
									,'USER_NM': user_nm
									,'INS_DATE': ins_date
									
								});
								
							});						
						}
						

						condHistoryGrid.rows = rowsObj;
						
						setGridRows(condHistoryGrid);
						var grid = $('#condHistoryGrid').data('grid');
						grid.setSelectedRows(rows);
						$('#ly_total_cnt_1').html('[ TOTAL : ' + items.attr('cnt') + ' ]');
						
					});
					try{viewProgBar(false);}catch(e){}
				}
		, null );
		
		xhr.sendRequest();
	}
	
</script>
