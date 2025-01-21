<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/jsp/common/inc/header.jsp"%>

<%
	Map<String, Object> paramMap = CommonUtil.collectParameters(request);

	String c 		= CommonUtil.isNull(paramMap.get("c"));
	String gridId 	= "g_"+c;
	String gridId_1 = "g_"+c+"_1";
	String gridId_2 = "g_"+c+"_2";
	
	String menu_gb 			= CommonUtil.getMessage("CATEGORY.GB.06.GB.0613");
	String[] arr_menu_gb 	= menu_gb.split(",");
%>

<c:set var="approval_group_gb_cd" 	value="${fn:split(USER_APPR_GB_CD,',')}"/>
<c:set var="approval_group_gb_nm" 	value="${fn:split(USER_APPR_GB_NM,',')}"/>

<form id="f_s" name="f_s" method="post" onsubmit="return false;">
</form>

<form name="frm1" id="frm1" method="post" onsubmit="return false;">
	<input type="hidden" name="flag" 				id="flag" />
	<input type="hidden" name="group_line_grp_cd" 	id="group_line_grp_cd" />
	<input type="hidden" name="group_line_grp_nm" 	id="group_line_grp_nm" />
	<input type="hidden" name="use_yn" 				id="use_yn" />
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
		<td style='vertical-align:top; width:64%;'>
			<table style="width:100%;height:100%;">
				<tr>					
					<td id='ly_<%=gridId_2 %>' style='vertical-align:top;' >
						<form name="frm2" id="frm2" method="post" onsubmit="return false;">
							<input type="hidden" name="flag" 				id="flag"/>
							<input type="hidden" name="group_line_cd" 		id="group_line_cd" />
							<input type="hidden" name="group_line_grp_cd" 	id="group_line_grp_cd" />
							<input type="hidden" name="approval_cd" 		id="approval_cd" />
							<input type="hidden" name="approval_seq" 		id="approval_seq" />
														
							<div id="<%=gridId_2 %>" class="ui-widget-header ui-corner-all"></div>
						
						</form>
					</td>
				</tr>
				<tr style='height:10px;'>
					<td style='vertical-align:top;'>
						<h4 class="ui-widget-header ui-corner-all" >
							<div align='right' class='btn_area' >
								<div id='ly_total_cnt' style='padding-top:5px;float:left;'></div>
							</div>
						</h4>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>

<script>

	var arr_approval_group_gb_cd 	= new Array();
	var arr_approval_group_gb_nm 	= new Array();
	
	<c:forEach var="approval_group_gb_cd" items="${approval_group_gb_cd}" varStatus="s">
		var map_cd = {"cd":"${approval_group_gb_cd}"};
		arr_approval_group_gb_cd.push(map_cd);
	</c:forEach>
	<c:forEach var="approval_group_gb_nm" items="${approval_group_gb_nm}" varStatus="s">
		var map_nm = {"nm":"${approval_group_gb_nm}"};
		arr_approval_group_gb_nm.push(map_nm);
	</c:forEach>

	function gridCellCustomFormatter(row,cell,value,columnDef,dataContext){
		
		var ret = "";
		var group_line_grp_cd = getCellValue(gridObj_1,row,'GROUP_LINE_GRP_CD');		
		
		if(columnDef.id == 'SELECT'){
			if(row > 0){
				ret = "<a href=\"JavaScript:groupApprovalLineList('"+group_line_grp_cd+"');\" /><font color='red'>"+value+"</font></a>";
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
	   		,{formatter:gridCellNoneFormatter,field:'GROUP_LINE_GRP_NM',id:'GROUP_LINE_GRP_NM',name:'그룹명',width:150,headerCssClass:'cellCenter',cssClass:'cellLeft'}
	   		//,{formatter:gridCellNoneFormatter,field:'USE_YN',id:'USE_YN',name:'사용구분',width:80,headerCssClass:'cellCenter',cssClass:'cellCenter'}
	   			   			   		
	   		,{formatter:gridCellNoneFormatter,field:'GROUP_LINE_GRP_CD',id:'GROUP_LINE_GRP_CD',name:'GROUP_LINE_GRP_CD',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   		,{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'grid_idx',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   	]
		,rows:[]
		,vscroll:<%=S_GRID_VSCROLL%>
	};
	
	var gridObj_2 = {
		id : "<%=gridId_2 %>"
		,colModel:[
	   		{formatter:gridCellNoneFormatter,field:'APPROVAL_SEQ',id:'APPROVAL_SEQ',name:'번호',width:60,headerCssClass:'cellCenter',cssClass:'cellCenter'}
	   		,{formatter:gridCellNoneFormatter,field:'APPROVAL_NM',id:'APPROVAL_NM',name:'결재자',width:400,headerCssClass:'cellCenter',cssClass:'cellLeft'}
	   		,{formatter:gridCellNoneFormatter,field:'PROC',id:'PROC',name:'처리',width:100,headerCssClass:'cellCenter',cssClass:'cellLeft'}
	   		
	   		,{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'grid_idx',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   		,{formatter:gridCellNoneFormatter,field:'GROUP_LINE_CD',id:'GROUP_LINE_CD',name:'GROUP_LINE_CD',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   		,{formatter:gridCellNoneFormatter,field:'GROUP_LINE_GRP_CD',id:'GROUP_LINE_GRP_CD',name:'GROUP_LINE_GRP_CD',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   		,{formatter:gridCellNoneFormatter,field:'APPROVAL_CD',id:'APPROVAL_CD',name:'APPROVAL_CD',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   		,{formatter:gridCellNoneFormatter,field:'USER_CD',id:'USER_CD',name:'USER_CD',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   	]
		,rows:[]
		,vscroll:<%=S_GRID_VSCROLL%>
	};
	
	$(document).ready(function(){
		
		$("#btn_add").button().unbind("click").click(function(){
			
			var cnt 				= 0;
			var group_line_grp_cd 	= 0;
			var group_line_grp_nm 	= "";
			var	group_line_grp_nm0  = $('#group_line_grp_nm0').val();
			
			var aSelRow = new Array;
			aSelRow = $('#'+gridObj_1.id).data('grid').getSelectedRows();
			if(aSelRow.length>0){
				for(var i=0;i<aSelRow.length;i++){					
					group_line_grp_cd = getCellValue(gridObj_1,aSelRow[i],"GROUP_LINE_GRP_CD");
					++cnt;
				}				
			}
			if(cnt > 1){
				alert("한개의 항목만 선택해 주세요.");
				return;			
			}
						
			if(group_line_grp_cd == "") group_line_grp_cd = 0;
			
			//신규결재선등록 결재그룹명 체크
			if(group_line_grp_nm0 == "" && group_line_grp_cd == 0) {
				alert("결재그룹명을 입력해 주세요."); 
				return;
			}
	
			for (var i = 1; i < gridObj_1.rows.length; i++) { 
				group_line_grp_cd_val 	= getCellValue(gridObj_1,i,"GROUP_LINE_GRP_CD");
				group_line_grp_nm	= $("#group_line_grp_nm"+ group_line_grp_cd_val).val();
 				
				if(group_line_grp_cd == 0){ 
					if (group_line_grp_nm0 == group_line_grp_nm){  
						alert("[그룹명 중복] 동일한 그룹명은 사용 불가 합니다. ");
						return; 
					}	
				}
			}
			
			if( !confirm("처리하시겠습니까?") ) return;
			
			if ( group_line_grp_cd == 0 ) {
				frm1.flag.value = "ins";
			} else {
				frm1.flag.value = "udt";
			}
			
			var frm = document.frm1;
			frm1.group_line_grp_cd.value 	= group_line_grp_cd;			
			frm1.group_line_grp_nm.value 	= $("#group_line_grp_nm"+group_line_grp_cd).val();
			//frm1.use_yn.value 				= $("#use_yn"+group_line_grp_cd).val();
			frm1.use_yn.value				= "Y";
			
			frm1.target = "if1";
			frm1.action = "<%=sContextPath%>/tWorks.ez?c=ezGroupApprovalGroup_p";
			frm1.submit();
			
		});
		
		$("#btn_del").button().unbind("click").click(function(){
			
			var cnt = 0;
			var group_line_grp_cd = 0;
			
			var aSelRow = new Array;
			aSelRow = $('#'+gridObj_1.id).data('grid').getSelectedRows();
			if(aSelRow.length>0){
				for(var i=0;i<aSelRow.length;i++){					
					group_line_grp_cd = getCellValue(gridObj_1,aSelRow[i],"GROUP_LINE_GRP_CD");
					++cnt;
				}				
			}
			
			if(cnt > 1){
				alert("한개의 항목만 선택해 주세요.");
				return;
			}
			
			if( !confirm("처리하시겠습니까?") ) return;
			
			var frm = document.frm1;
			
			frm1.flag.value 				= "del";
			frm1.group_line_grp_cd.value 	= group_line_grp_cd;
			frm1.target 					= "if1";
			frm1.action 					= "<%=sContextPath%>/tWorks.ez?c=ezGroupApprovalGroup_p";
			frm1.submit();
			
		});
		
		viewGrid_1(gridObj_1,"ly_"+gridObj_1.id);
		groupApprovalGroupList();
		
		viewGrid_1(gridObj_2,"ly_"+gridObj_2.id);
	});
	
	function groupApprovalGroupList(){
		
		try{viewProgBar(true);}catch(e){}
		$('#ly_total_cnt').html('');

		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=groupApprovalGroup&itemGubun=2';
		
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
						
						//var cd = "<div><input type='hidden' name='line_grp_cd0' id='line_grp_cd0' value='0' style='width:100%;'/></div>"
						var nm 		= "<div><input type='text' name='group_line_grp_nm0' id='group_line_grp_nm0' style='width:100%;'/></div>"

						/*
						var v_use_yn = "";
						v_use_yn += "<div class='gridInput_area'><select name='use_yn0' id='use_yn0' style='width:100%;'>";
						v_use_yn += "<option value='Y'>사용</option>";
						v_use_yn += "<option value='N' selected >미사용</option>";
						v_use_yn += "</select></div>";
						*/
						
						rowsObj.push({
							'grid_idx': ""
							,'SELECT': ""
							,'GROUP_LINE_GRP_CD': ""
							,'GROUP_LINE_GRP_NM': nm
							//,'USE_YN': v_use_yn
						});
						
						if(items.attr('cnt')=='0'){
						}else{
							items.find('item').each(function(i){
							
								var group_line_grp_cd 	= $(this).find("GROUP_LINE_GRP_CD").text();
								var group_line_grp_nm 	= $(this).find("GROUP_LINE_GRP_NM").text();
								//var use_yn 				= $(this).find("USE_YN").text();
								
								var v_group_line_grp_nm 	= "<div class='gridInput_area'><input type='text' name='group_line_grp_nm"+group_line_grp_cd+"' id='group_line_grp_nm"+group_line_grp_cd+"' value='"+group_line_grp_nm+"' style='width:100%;'/></div>";

								/*
								v_use_yn = "";
								v_use_yn += "<div class='gridInput_area'><select name='use_yn"+group_line_grp_cd+"' id='use_yn"+group_line_grp_cd+"' style='width:100%;'>";
								
								if(use_yn == "Y"){
									v_use_yn += "<option value='Y' selected>사용</option>";
									v_use_yn += "<option value='N'>미사용</option>";	
								}else{
									v_use_yn += "<option value='Y'>사용</option>";
									v_use_yn += "<option value='N' selected>미사용</option>";	
								}
								
								v_use_yn += "</select></div>";
								*/
								
								rowsObj.push({
									'grid_idx':i+1
									,'SELECT': "[선택]"
									,'GROUP_LINE_GRP_CD': group_line_grp_cd
									,'GROUP_LINE_GRP_NM': v_group_line_grp_nm
									//,'USE_YN': v_use_yn
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
	}
	
	function groupApprovalLineList(group_line_grp_cd){
		
		try{viewProgBar(true);}catch(e){}
		$('#ly_total_cnt').html('');
		
		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=groupApprovalLine&itemGubun=2&group_line_grp_cd='+group_line_grp_cd;
		
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
						var v_approval_seq = "<input type='hidden' id='approval_seq0' name='approval_seq0' value='"+(parseInt(tot_cnt) + 1)+"' />" + (parseInt(tot_cnt) + 1);
						
						var input_approval_nm = "";
						input_approval_nm += "<div class='gridInput_area'><input type='hidden' id='approval_cd0' name='approval_cd0'/><input type='hidden' id='user_cd0' name='user_cd0'/><input type='text' id='approval_nm0' name='approval_nm0' value='' style='width:100%;'/></div>";
						
						var input_prc = "";
						input_prc += "<div><a href=\"javascript:goProc('ins','"+group_line_grp_cd+"','0');\"><font color='red'>[추가]</font></a></div>";						

						rowsObj.push({
							'grid_idx': 0
							,'APPROVAL_NM': input_approval_nm
							,'PROC': input_prc
							,'GROUP_LINE_CD': ""
							,'GROUP_LINE_GRP_CD': ""
							,'APPROVAL_CD': input_approval_nm
							,'APPROVAL_SEQ': v_approval_seq		
						});
						
						
						if(items.attr('cnt')=='0'){
						}else{
							items.find('item').each(function(i){
							
								var group_line_cd 		= $(this).find("GROUP_LINE_CD").text();
								var group_line_grp_cd 	= $(this).find("GROUP_LINE_GRP_CD").text();
								var approval_cd 		= $(this).find("APPROVAL_CD").text();
								var approval_nm 		= $(this).find("APPROVAL_NM").text();
								var duty_nm 			= $(this).find("DUTY_NM").text();
								var dept_nm 			= $(this).find("DEPT_NM").text();
								var user_id 			= $(this).find("USER_ID").text();
// 								var user_info 			= approval_nm+"["+dept_nm+"]"+"["+duty_nm+"]";
								var user_info 			= approval_nm+"["+user_id+"]["+dept_nm+"]"+"["+duty_nm+"]";
								var approval_seq 		= $(this).find("APPROVAL_SEQ").text();
								var user_cd 			= $(this).find("USER_CD").text();
								
								
								var v_approval_cd = "";
								v_approval_cd += "<input type='hidden' id='approval_cd"+group_line_cd+"' name='approval_cd"+group_line_cd+"' value='"+approval_cd+"' />";
								
								var v_approval_seq = "";
								v_approval_seq += "<input type='hidden' id='approval_seq"+group_line_cd+"' name='approval_seq"+group_line_cd+"' value='"+(i+1)+"' />" + (i+1);
								
								var v_user_cd = ""; 
								v_user_cd += "<input type='hidden' id='user_cd"+group_line_cd+"' name='user_cd"+group_line_cd+"' value='"+user_cd+"' />"; 
 								
								var v_user_info = ""; 
// 								v_user_info += "<div class='gridInput_area'>"+user_info+"</div>";
// 								v_user_info += "<input type='text' id='approval_nm"+group_line_cd+"' name='approval_nm"+group_line_cd+"' value='"+user_info+"' style='width:100%;'/>";
								v_user_info += "<div class='gridInput_area'>"+user_info+"<input type='text' id='approval_nm"+group_line_cd+"' name='approval_nm"+group_line_cd+"' value='' style='width:100%;'/></div>";
								
								var v_proc 	= "<div>";
								v_proc 		+= "<a href=\"javascript:goProc('udt','"+group_line_grp_cd+"','"+group_line_cd+"');\"><font color='red'>[수정]</font></a> ";
								v_proc 		+= "<a href=\"javascript:goProc('del','"+group_line_grp_cd+"','"+group_line_cd+"');\"><font color='red'>[삭제]</font></a>";
								v_proc 		+= "</div>";	
								
								rowsObj.push({
									'grid_idx':(i+1)
									,'APPROVAL_NM': v_user_info
									,'PROC': v_proc
									,'GROUP_LINE_CD': group_line_cd
									,'GROUP_LINE_GRP_CD': group_line_grp_cd
									,'APPROVAL_CD': v_approval_cd
									,'APPROVAL_SEQ': v_approval_seq
									,'USER_CD': v_user_cd
								});
								
							});						
						}
						
						gridObj_2.rows = rowsObj;
						setGridRows(gridObj_2);
						$('#ly_total_cnt').html('[ TOTAL : '+items.attr('cnt')+' ]');
						
						//유저 검색 시 팝업형태로 변경
// 						$("[id^='approval_nm']").unbind('keypress').keypress(function(e){
// 							//if(e.keyCode==13 && trim($(this).val())!=''){
// 							if(e.keyCode==13){
// 								var id = $(this).attr('id');
// 								var group_line_cd = id.replace("approval_nm", "");
// 								getUserList($(this).val(), group_line_cd);
// 							}
// 						}).unbind('keyup').keyup(function(e){
// 							var id = $(this).attr('id');
// 							var group_line_cd = id.replace("approval_nm", "");
// 							if($('#approval_cd' + group_line_cd).val()!='' && $(this).data('sel_v') != $(this).val()){
// 								$('#approval_cd' + group_line_cd).val('');
// 								$('#user_cd' + user_cd).val('');
// 								$(this).removeClass('input_complete');
// 							}
// 						});
						
						$('input[id^=approval_nm]').unbind('click').click(function(){
							var user_idx = $(this).attr('id').replace("approval_nm","");
							goUserSearch(user_idx,user_idx);
						}).unbind('keyup').keyup(function(e){
							if($(this).val() != '' && (this).data('sel_v') != $(this).val()){
								$('#sel_v').val();
								$(this).removeClass('input_complete');
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
// 							aTags.push({value:$(this).find('USER_NM').text()+'['+$(this).find('USER_ID').text()+']'
// 										,label:$(this).find('USER_NM').text()+'['+$(this).find('USER_ID').text()+']'+'['+$(this).find('DEPT_NM').text()+']['+$(this).find('DUTY_NM').text()+']'
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
// 	}
	
	function goProc(flag, group_line_grp_cd, group_line_cd) {
		
		var frm = document.frm2;
		var msg = "";
		
		var approval_cd 	= $("#frm2 #approval_cd" + group_line_cd);
		var approval_seq	= $("#frm2 #approval_seq" + group_line_cd);
		
		var std_approval_cd = $("#approval_cd0").val();
		var std_approval_cd1 	= $("#approval_cd" + group_line_cd).val();

		for (var i = 1; i < gridObj_2.rows.length; i++) { 
			group_line_cd_val 	= getCellValue(gridObj_2,i,"GROUP_LINE_CD"); 
			chk_user_cd			= $("#user_cd"+ group_line_cd_val).val();
			
			if (std_approval_cd == chk_user_cd){ 
				alert("[결재자 중복] 그룹결재 결재자는 한번만 사용이 가능합니다.");
				return; 
			}
			//결재자 수정 시에 결재자 중복 체크(23.02.21 김은희)
			if ( flag == "udt" ) {
				if (std_approval_cd1 == chk_user_cd){
					alert("[결재자 중복] 그룹결재 결재자는 한번만 사용이 가능합니다.");
					return;
			}
		}
		}

		if ( flag != "del" ) {
			if(isNullInput(approval_cd,'<%=CommonUtil.getMessageSplit("ERROR.PARAM.02","[결재자]","") %>')) return;
		}
		
		if(confirm("처리하시겠습니까?")) {
			
			frm.approval_cd.value		= approval_cd.val();
			frm.approval_seq.value		= approval_seq.val();
			
			frm.flag.value 				= flag;
			frm.group_line_grp_cd.value = group_line_grp_cd;
			frm.group_line_cd.value 	= group_line_cd
			frm.target 					= "if1";
			frm.action 					= "<%=sContextPath%>/tWorks.ez?c=ezGroupApprovalLine_p";
			
			frm.submit();		
		}		
	}
	
	//유저 검색 팝업형태로 변경
	function goUserSeqSelect(cd, nm, btn, sel_line_cd){
		
		$("#approval_nm"+ sel_line_cd).val(nm);
		$("#approval_cd"+ sel_line_cd).val(cd);;

		dlClose('dl_tmp3');
	}
	
</script>