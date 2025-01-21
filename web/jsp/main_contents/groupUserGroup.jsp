<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/jsp/common/inc/header.jsp"%>

<%
	Map<String, Object> paramMap = CommonUtil.collectParameters(request);

	String c 		= CommonUtil.isNull(paramMap.get("c"));
	String gridId 	= "g_"+c;
	String gridId_1 = "g_"+c+"_1";
	String gridId_2 = "g_"+c+"_2";
	
	String menu_gb 			= CommonUtil.getMessage("CATEGORY.GB.03.GB.0320");
	String[] arr_menu_gb 	= menu_gb.split(",");
	
	// 세션값 가져오기.	
	String strSessionDcCode 	= S_D_C_CODE;	
	String strSessionTab	 	= S_TAB;
	String strSessionApp        = S_APP;
	String strSessionGrp        = S_GRP;
	String session_user_gb 		= S_USER_GB;
	String session_user_id		= S_USER_ID;
%>

<c:set var="approval_group_gb_cd" 	value="${fn:split(USER_APPR_GB_CD,',')}"/>
<c:set var="approval_group_gb_nm" 	value="${fn:split(USER_APPR_GB_NM,',')}"/>

<form id="f_s" name="f_s" method="post" onsubmit="return false;">
</form>

<form name="frm1" id="frm1" method="post" onsubmit="return false;">
	<input type="hidden" name="flag" 					id="flag" />
	<input type="hidden" name="group_user_group_cd" 	id="group_user_group_cd" />
	<input type="hidden" name="group_user_group_nm" 	id="group_user_group_nm" />
	<input type="hidden" name="use_yn" 					id="use_yn" />
</form>

<table style='width:100%;height:100%;border:none;'>
	<tr style='height:10px;'>
		<td style='vertical-align:top;' colspan="2">
			<h4 class="ui-widget-header ui-corner-all"  >
				<div id='t_<%=gridId %>' class='title_area' >
					<span><%=CommonUtil.isNull(arr_menu_gb[0]) %></span>
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
							<%if(session_user_gb.equals("99")){ %>						
								<span id="btn_add">저장</span>
								<span id="btn_del">삭제</span>
							<%} %>
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
							<input type="hidden" name="flag" 					id="flag"/>
							<input type="hidden" name="group_user_line_cd" 		id="group_user_line_cd" />
							<input type="hidden" name="group_user_group_cd" 	id="group_user_group_cd" />
							<input type="hidden" name="approval_cd" 			id="approval_cd" />
														
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
		var group_user_group_cd = getCellValue(gridObj_1,row,'GROUP_USER_GROUP_CD');		
		
		if(columnDef.id == 'SELECT'){
			if(row > 0){
				ret = "<a href=\"JavaScript:groupUserLineList('"+group_user_group_cd+"');\" /><font color='red'>"+value+"</font></a>";
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
	   		,{formatter:gridCellNoneFormatter,field:'GROUP_USER_GROUP_NM',id:'GROUP_USER_GROUP_NM',name:'그룹명',width:150,headerCssClass:'cellCenter',cssClass:'cellLeft'}
	   		//,{formatter:gridCellNoneFormatter,field:'USE_YN',id:'USE_YN',name:'사용구분',width:80,headerCssClass:'cellCenter',cssClass:'cellCenter'}
	   		
	   		,{formatter:gridCellNoneFormatter,field:'GROUP_USER_GROUP_CD',id:'GROUP_USER_GROUP_CD',name:'GROUP_USER_GROUP_CD',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   		,{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'grid_idx',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   	]
		,rows:[]
		,vscroll:<%=S_GRID_VSCROLL%>
	};
	
	var gridObj_2 = {
		id : "<%=gridId_2 %>"
		,colModel:[
	   		{formatter:gridCellNoneFormatter,field:'APPROVAL_NM',id:'APPROVAL_NM',name:'사용자',width:300,headerCssClass:'cellCenter',cssClass:'cellLeft'}
	   		<%if(session_user_gb.equals("99")){ %>
	   			,{formatter:gridCellNoneFormatter,field:'PROC',id:'PROC',name:'처리',width:100,headerCssClass:'cellCenter',cssClass:'cellLeft'}
	   		<%}%>
	   		,{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'grid_idx',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   		,{formatter:gridCellNoneFormatter,field:'GROUP_USER_LINE_CD',id:'GROUP_USER_LINE_CD',name:'GROUP_USER_LINE_CD',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   		,{formatter:gridCellNoneFormatter,field:'GROUP_USER_GROUP_CD',id:'GROUP_USER_GROUP_CD',name:'GROUP_USER_GROUP_CD',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   		,{formatter:gridCellNoneFormatter,field:'APPROVAL_CD',id:'APPROVAL_CD',name:'APPROVAL_CD',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   		,{formatter:gridCellNoneFormatter,field:'USER_CD',id:'USER_CD',name:'USER_CD',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   	]
		,rows:[]
		,vscroll:<%=S_GRID_VSCROLL%>
	};
	
	$(document).ready(function(){
		
		$("#btn_add").button().unbind("click").click(function(){
			
			var cnt 				= 0;
			var group_user_group_cd 	= 0;
			var group_user_group_nm 	= "";
			var	group_user_group_nm0  = $('#group_user_group_nm0').val();
			
			var aSelRow = new Array;
			aSelRow = $('#'+gridObj_1.id).data('grid').getSelectedRows();
			if(aSelRow.length>0){
				for(var i=0;i<aSelRow.length;i++){					
					group_user_group_cd = getCellValue(gridObj_1,aSelRow[i],"GROUP_USER_GROUP_CD");
					++cnt;
				}				
			}
			if(cnt > 1){
				alert("한개의 항목만 선택해 주세요.");
				return;			
			}
						
			if(group_user_group_cd == "") group_user_group_cd = 0;
			
			//신규결재선등록 결재그룹명 체크
			if(group_user_group_nm0 == "" && group_user_group_cd == 0) {
				alert("결재그룹명을 입력해 주세요."); 
				return;
			}
	
			for (var i = 1; i < gridObj_1.rows.length; i++) { 
				group_user_group_cd_val 	= getCellValue(gridObj_1,i,"GROUP_USER_GROUP_CD");
				group_user_group_nm	= $("#group_user_group_nm"+ group_user_group_cd_val).val();
 				
				if(group_user_group_cd == 0){ 
					if (group_user_group_nm0 == group_user_group_nm){  
						alert("[그룹명 중복] 동일한 그룹명은 사용 불가 합니다. ");
						return; 
					}	
				}
			}
			
			if( !confirm("처리하시겠습니까?") ) return;
			
			if ( group_user_group_cd == 0 ) {
				frm1.flag.value = "ins";
			} else {
				frm1.flag.value = "udt";
			}
			
			var frm = document.frm1;
			frm1.group_user_group_cd.value 	= group_user_group_cd;			
			frm1.group_user_group_nm.value 	= $("#group_user_group_nm"+group_user_group_cd).val();
			frm1.use_yn.value				= "Y";
			
			frm1.target = "if1";
			frm1.action = "<%=sContextPath%>/tWorks.ez?c=ezGroupUserGroup_p";
			frm1.submit();
			
		});
		
		$("#btn_del").button().unbind("click").click(function(){
			
			var cnt = 0;
			var group_user_group_cd = 0;
			
			var aSelRow = new Array;
			aSelRow = $('#'+gridObj_1.id).data('grid').getSelectedRows();
			if(aSelRow.length>0){
				for(var i=0;i<aSelRow.length;i++){					
					group_user_group_cd = getCellValue(gridObj_1,aSelRow[i],"GROUP_USER_GROUP_CD");
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
			frm1.group_user_group_cd.value 	= group_user_group_cd;
			frm1.target 					= "if1";
			frm1.action 					= "<%=sContextPath%>/tWorks.ez?c=ezGroupUserGroup_p";
			frm1.submit();
			
		});
		
		viewGrid_1(gridObj_1,"ly_"+gridObj_1.id);
		groupUserGroupList();
		
		viewGrid_1(gridObj_2,"ly_"+gridObj_2.id);
	});
	
	function groupUserGroupList(){
		
		try{viewProgBar(true);}catch(e){}
		$('#ly_total_cnt').html('');

		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=groupUserGroup&itemGubun=2';
		
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
						var nm 		= "<div><input type='text' name='group_user_group_nm0' id='group_user_group_nm0' style='width:100%;'/></div>"

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
							,'GROUP_USER_GROUP_CD': ""
							,'GROUP_USER_GROUP_NM': nm
							//,'USE_YN': v_use_yn
						});
						
						if(items.attr('cnt')=='0'){
						}else{
							items.find('item').each(function(i){
							
								var group_user_group_cd 	= $(this).find("GROUP_USER_GROUP_CD").text();
								var group_user_group_nm 	= $(this).find("GROUP_USER_GROUP_NM").text();
								//var use_yn 				= $(this).find("USE_YN").text();
								
								var v_group_user_group_nm 	= "<div class='gridInput_area'><input type='text' name='group_user_group_nm"+group_user_group_cd+"' id='group_user_group_nm"+group_user_group_cd+"' value='"+group_user_group_nm+"' style='width:100%;'/></div>";

								/*
								v_use_yn = "";
								v_use_yn += "<div class='gridInput_area'><select name='use_yn"+group_user_group_cd+"' id='use_yn"+group_user_group_cd+"' style='width:100%;'>";
								
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
									,'GROUP_USER_GROUP_CD': group_user_group_cd
									,'GROUP_USER_GROUP_NM': v_group_user_group_nm
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
	
	function groupUserLineList(group_user_group_cd){
		
		try{viewProgBar(true);}catch(e){}
		$('#ly_total_cnt').html('');
		
		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=groupUserLine&itemGubun=2&group_user_group_cd='+group_user_group_cd;

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
						
						var input_approval_nm = "";
						input_approval_nm += "<div class='gridInput_area'><input type='hidden' id='approval_cd0' name='approval_cd0'/><input type='hidden' id='user_cd0' name='user_cd0'/><input type='text' id='approval_nm0' name='approval_nm0' value='' style='width:100%;'/></div>";
						
						var input_prc = "";
						input_prc += "<div><a href=\"javascript:goProc('ins','"+group_user_group_cd+"','0');\"><font color='red'>[추가]</font></a></div>";						

						rowsObj.push({
							'grid_idx': 0
							,'APPROVAL_NM': input_approval_nm
							,'PROC': input_prc
							,'GROUP_USER_LINE_CD': ""
							,'GROUP_USER_GROUP_CD': ""
							,'APPROVAL_CD': input_approval_nm
						});
						
						
						if(items.attr('cnt')=='0'){
						}else{
							items.find('item').each(function(i){
							
								var group_user_line_cd 		= $(this).find("GROUP_USER_LINE_CD").text();
								var group_user_group_cd 	= $(this).find("GROUP_USER_GROUP_CD").text();
								var approval_cd 		= $(this).find("APPROVAL_CD").text();
								var approval_nm 		= $(this).find("APPROVAL_NM").text();
								var duty_nm 			= $(this).find("DUTY_NM").text();
								var dept_nm 			= $(this).find("DEPT_NM").text();
								var user_id 			= $(this).find("USER_ID").text();
								var user_info 			= user_id+"["+dept_nm+"]"+"["+duty_nm+"]";
								var user_cd 			= $(this).find("USER_CD").text();
								
								
								var v_approval_cd = "";
								v_approval_cd += "<input type='hidden' id='approval_cd"+group_user_line_cd+"' name='approval_cd"+group_user_line_cd+"' value='"+approval_cd+"' />";
								
								var v_user_cd = ""; 
								v_user_cd += "<input type='hidden' id='user_cd"+group_user_line_cd+"' name='user_cd"+group_user_line_cd+"' value='"+user_cd+"' />"; 
 								
								var v_user_info = ""; 
								<%if(session_user_gb.equals("99")){ %>
								v_user_info += "<div class='gridInput_area'>"+user_info+"<input type='text' id='approval_nm"+group_user_line_cd+"' name='approval_nm"+group_user_line_cd+"' value='' style='width:100%;'/></div>";
								<%}else{%>
								v_user_info += "<div class='gridInput_area'>"+user_info+"</div>";
								<%}%>
								var v_proc 	= "<div>";
								v_proc 		+= "<a href=\"javascript:goProc('udt','"+group_user_group_cd+"','"+group_user_line_cd+"');\"><font color='red'>[수정]</font></a> ";
								v_proc 		+= "<a href=\"javascript:goProc('del','"+group_user_group_cd+"','"+group_user_line_cd+"');\"><font color='red'>[삭제]</font></a>";
								v_proc 		+= "</div>";	
								
								rowsObj.push({
									'grid_idx':(i+1)
									,'APPROVAL_NM': v_user_info
									,'PROC': v_proc
									,'GROUP_USER_LINE_CD': group_user_line_cd
									,'GROUP_USER_GROUP_CD': group_user_group_cd
									,'APPROVAL_CD': v_approval_cd
									,'USER_CD': v_user_cd
								});
								
							});						
						}
						
						gridObj_2.rows = rowsObj;
						setGridRows(gridObj_2);
						$('#ly_total_cnt').html('[ TOTAL : '+items.attr('cnt')+' ]');
						
						$("[id^='approval_nm']").unbind('keypress').keypress(function(e){
							if(e.keyCode==13 && trim($(this).val())!=''){
								var id = $(this).attr('id');
								var group_user_line_cd = id.replace("approval_nm", "");
								getUserList($(this).val(), group_user_line_cd);
							}
						}).unbind('keyup').keyup(function(e){
							var id = $(this).attr('id');
							var group_user_line_cd = id.replace("approval_nm", "");
							if($('#approval_cd' + group_user_line_cd).val()!='' && $(this).data('sel_v') != $(this).val()){
								$('#approval_cd' + group_user_line_cd).val('');
								$('#user_cd' + user_cd).val('');
								$(this).removeClass('input_complete');
							}
						});
						
					});
					try{viewProgBar(false);}catch(e){}
				}
		, null );
		
		xhr.sendRequest();
	}	
	
	function getUserList(user_id, arg){
		
		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=userList&p_search_gubun=user_id&p_search_text='+encodeURIComponent(user_id);
		
		var xhr = new XHRHandler(url, null
			,function(){
				var xmlDoc = this.req.responseXML;
				
				$(xmlDoc).find('doc').each(function(){
					
					var items = $(this).find('items');
					
					var aTags = new Array();
					if(items.attr('cnt')=='0'){
					}else{						
						items.find('item').each(function(i){						
							aTags.push({value:$(this).find('USER_ID').text()
										,label:'['+$(this).find('USER_ID').text()+']'+'['+$(this).find('DEPT_NM').text()+']'+$(this).find('USER_NM').text()
										,user_cd:$(this).find('USER_CD').text()
										,dept_nm:$(this).find('DEPT_NM').text()
										,dept_cd:$(this).find('DEPT_CD').text()
										});
						});
					}
					
					try{ $("#approval_nm"+arg).autocomplete("destroy"); }catch(e){};
					
					$("#approval_nm"+arg).autocomplete({
						source: aTags
						,autoFocus: false
						,focus: function(event, ui) {
									
								}
						,select: function(event, ui) {
									$(this).val(ui.item.value);
									$("#approval_cd"+arg).val(ui.item.user_cd);
									
									$(this).data('sel_v',$(this).val());
									$(this).removeClass('input_complete').addClass('input_complete');
								}
						,disabled: false
						,create: function(event, ui) {
									$(this).autocomplete('search',$(this).val()); 
								}
						,close: function(event, ui) {
									$(this).autocomplete("destroy");
								}
						,open: function(){
					        setTimeout(function () {
					            $('.ui-autocomplete').css('z-index', 3000);
					        }, 10);
					    }
						
					}).data("autocomplete")._renderItem = function(ul, item) {
																return $("<li></li>" )
																	.data("item.autocomplete", item)
																	.append("<a>" + item.label + "</a>")
																	.appendTo(ul);
															};
					
				});
				
			}
		, null );
		
		xhr.sendRequest();
	}
	
	function goProc(flag, group_user_group_cd, group_user_line_cd) {
		
		var frm = document.frm2;
		var msg = "";
		
		var approval_cd 	= $("#frm2 #approval_cd" + group_user_line_cd);
		
		var std_approval_cd = $("#approval_cd0").val();
		
		for (var i = 1; i < gridObj_2.rows.length; i++) { 
			group_user_line_cd_val 	= getCellValue(gridObj_2,i,"GROUP_USER_LINE_CD"); 
			chk_user_cd			= $("#user_cd"+ group_user_line_cd_val).val();
			
			if (std_approval_cd == chk_user_cd){ 
				alert("[사용자 중복] 사용자는 한번만 사용이 가능합니다.");
				return; 
			}
		}
		

		if ( flag != "del" ) {
			if(isNullInput(approval_cd,'<%=CommonUtil.getMessageSplit("ERROR.PARAM.02","[결재자]","") %>')) return;
		}
		
		if(confirm("처리하시겠습니까?")) {
			
			frm.approval_cd.value		= approval_cd.val();
			
			frm.flag.value 				= flag;
			frm.group_user_group_cd.value = group_user_group_cd;
			frm.group_user_line_cd.value 	= group_user_line_cd
			frm.target 					= "if1";
			frm.action 					= "<%=sContextPath%>/tWorks.ez?c=ezGroupUserLine_p";
			
			frm.submit();		
		}		
	}
	
</script>