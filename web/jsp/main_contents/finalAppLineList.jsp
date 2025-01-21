<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/jsp/common/inc/header.jsp"%>

<c:set var="approval_order_cd" value="${fn:split(APPROVAL_ORDER_CD,',')}"/>
<c:set var="approval_doc_cd" value="${fn:split(APPROVAL_DOC_CD,',')}"/>
<c:set var="approval_doc_nm" value="${fn:split(APPROVAL_DOC_NM,',')}"/>

<%
	Map<String, Object> paramMap = CommonUtil.collectParameters(request);
	String c = CommonUtil.isNull(paramMap.get("c"));
	String gridId = "g_"+c;
	
	String menu_gb = CommonUtil.getMessage("CATEGORY.GB.06.GB."+CommonUtil.isNull(paramMap.get("menu_gb")));
	String[] arr_menu_gb = menu_gb.split(",");
%>

<form id="f_s" name="f_s" method="post" onsubmit="return false;">	
	<input type="hidden" name="doc_gb" id="doc_gb" value="01,02,03"/>
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
		<td id='ly_<%=gridId %>' style='vertical-align:top;'>
			<form name="frm1" id="frm1" method="post" onsubmit="return false;">
				<input type="hidden" name="flag" id="flag"/>
				<input type="hidden" name="final_line_cd" id="final_line_cd" />
	
				<div id="<%=gridId %>" class="ui-widget-header ui-corner-all" ></div>
			</form>
		</td>
	</tr>
	<tr style='height:10px;'>
		<td style='vertical-align:top;'>
			<h4 class="ui-widget-header ui-corner-all" >
				<div align='right' class='btn_area'>
					<div id='ly_total_cnt' style='padding-top:5px;float:left;'></div>
				</div>
			</h4>
		</td>
	</tr>
</table>

<script>

	var arr_approval_order_cd = new Array();
	var arr_approval_doc_cd = new Array();
	var arr_approval_doc_nm = new Array();
	
	<c:forEach var="approval_order_cd" items="${approval_order_cd}" varStatus="s">
		var map_cd = {"cd":"${approval_order_cd}"};
		arr_approval_order_cd.push(map_cd);
	</c:forEach>
	
	<c:forEach var="approval_doc_cd" items="${approval_doc_cd}" varStatus="s">
		var map_cd = {"cd":"${approval_doc_cd}"};
		arr_approval_doc_cd.push(map_cd);
	</c:forEach>
	<c:forEach var="approval_doc_nm" items="${approval_doc_nm}" varStatus="s">
		var map_nm = {"nm":"${approval_doc_nm}"};
		arr_approval_doc_nm.push(map_nm);
	</c:forEach>

	var gridObj = {
		id : "<%=gridId %>"
		,colModel:[
			{formatter:gridCellNoneFormatter,field:'DOC_GB',id:'DOC_GB',name:'문서구분',width:80,headerCssClass:'cellCenter',cssClass:'cellCenter'}
			,{formatter:gridCellNoneFormatter,field:'USER_NM',id:'USER_NM',name:'결재자',width:200,headerCssClass:'cellCenter',cssClass:'cellLeft'}
			,{formatter:gridCellNoneFormatter,field:'ORDER_NO',id:'ORDER_NO',name:'결재순서',width:60,headerCssClass:'cellCenter',cssClass:'cellCenter'}
			,{formatter:gridCellNoneFormatter,field:'STATUS',id:'STATUS',name:'상태',width:80,headerCssClass:'cellCenter',cssClass:'cellCenter'}
			,{formatter:gridCellNoneFormatter,field:'PROC',id:'PROC',name:'처리',width:60,headerCssClass:'cellCenter',cssClass:'cellCenter'}

			,{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'grid_idx',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   	]
		,rows:[]
		,vscroll:<%=S_GRID_VSCROLL%>
	};
	
	$(document).ready(function(){
			
		viewGrid_1(gridObj,"ly_"+gridObj.id);
		finalAppLineList();
		
	});
	
	function finalAppLineList(){
		
		try{viewProgBar(true);}catch(e){}
		$('#ly_total_cnt').html('');
		
		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=finalAppLineList';
		
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
						
						var tot_cnt = items.attr("cnt");
						var v_approval_order = parseInt(tot_cnt) + 1;
						
						var inputApproval_order_no = "";
						inputApproval_order_no += "<div><select id='order_no' name='order_no' style='width:100%;'>";
						for(var j=0;j<arr_approval_order_cd.length;j++){							
							inputApproval_order_no += "<option value='"+arr_approval_order_cd[j].cd+"'>"+arr_approval_order_cd[j].cd+"</option>";
						}
						inputApproval_order_no += "</select></div>";
						
						var inputApproval_doc_gb = "";
						inputApproval_doc_gb += "<div><select id='doc_gb' name='doc_gb' style='width:100%;'>";
						inputApproval_doc_gb += "<option value=''>--선택--</option>";
						for(var k=0;k<arr_approval_doc_cd.length;k++){	
							inputApproval_doc_gb += "<option value='"+arr_approval_doc_cd[k].cd+"'>"+arr_approval_doc_nm[k].nm+"</option>";
						}
						inputApproval_doc_gb += "</select></div>";
						
						var inputApproval_user = "";
						inputApproval_user += "<div class='gridInput_area'><input type='hidden' id='user_cd' name='user_cd'/><input type='text' id='user_nm' name='user_nm' value='' style='width:100%;'/></div>";
						
						var inputStatus = "";
						inputStatus += "<div><select id='p_status' name='p_status' style='width:100%'>";
						inputStatus += "<option value='Y'>정상</option>";
						inputStatus += "<option value='N'>By Pass</option>";
						inputStatus +="</select></div>";
						
						var inputPrc = "";
						inputPrc += "<div><a href=\"javascript:goProc('ins','');\"><font color='red'>[추가]</font></a></div>";
						
						rowsObj.push({
									'grid_idx':0
									,'DOC_GB':inputApproval_doc_gb
									,'USER_NM':inputApproval_user
									,'USER_CD':''
									,'ORDER_NO':inputApproval_order_no										
									,'STATUS':inputStatus
									,'PROC':inputPrc								
						});
						
						if(items.attr('cnt')=='0'){
						}else{
							items.find('item').each(function(i){						
								
								var final_line_cd =  $(this).find("FINAL_LINE_CD").text();
								var doc_gb = $(this).find("DOC_GB").text();
								var user_nm = $(this).find("USER_NM").text();
								var user_cd = $(this).find("USER_CD").text();
								var duty_nm = $(this).find("DUTY_NM").text();
								var dept_nm = $(this).find("DEPT_NM").text();
								var order_no = $(this).find("ORDER_NO").text();
								var status = $(this).find("STATUS").text();		
								var v_user_nm = "["+dept_nm+"]"+"["+duty_nm+"]"+"["+user_nm+"]";
								var v_proc = "<div><a href=\"javascript:goProc('del','"+final_line_cd+"');\"><font color='red'>[삭제]</font></a></div>";;
								var v_doc_gb = "";
								var v_status = "";
								
								for(var k=0;k<arr_approval_doc_cd.length;k++){	
									if(doc_gb == arr_approval_doc_cd[k].cd){
										v_doc_gb = arr_approval_doc_nm[k].nm;
									}
								}
								
								if(status == "Y") v_status = "정상";
								if(status == "N") v_status = "By Pass";
								
								rowsObj.push({
									'grid_idx':i+1
									,'DOC_GB': v_doc_gb
									,'USER_NM': v_user_nm
									,'USER_CD': user_cd
									,'ORDER_NO': order_no
									,'STATUS': v_status
									,'PROC': v_proc
								});
								
							});						
						}
						
						gridObj.rows = rowsObj;
						setGridRows(gridObj);
						$('#ly_total_cnt').html('[ TOTAL : '+items.attr('cnt')+' ]');
						
						$('#user_nm').unbind('keypress').keypress(function(e){
							if(e.keyCode==13 && trim($(this).val())!=''){
								getUserList($(this).val());
							}
						}).unbind('keyup').keyup(function(e){
							if($('#user_cd').val()!='' && $(this).data('sel_v') != $(this).val()){
								$('#user_cd').val('');
								$(this).removeClass('input_complete');
							}
							
						});			
						
					});
					try{viewProgBar(false);}catch(e){}
				}
		, null );
		
		xhr.sendRequest();
	}
	
	function getUserList(user_nm){
		
		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=userList&p_search_gubun=user_nm&p_search_text='+encodeURIComponent(user_nm)+'&auto_yn=Y';
		
		var xhr = new XHRHandler(url, null
			,function(){
				var xmlDoc = this.req.responseXML;
				
				$(xmlDoc).find('doc').each(function(){
					
					var items = $(this).find('items');
					
					var aTags = new Array();
					if(items.attr('cnt')=='0'){
					}else{						
						items.find('item').each(function(i){						
							aTags.push({value:$(this).find('USER_NM').text()
										,label:'['+$(this).find('DEPT_NM').text()+']'+$(this).find('USER_NM').text()
										,user_cd:$(this).find('USER_CD').text()
										,dept_nm:$(this).find('DEPT_NM').text()
										,dept_cd:$(this).find('DEPT_CD').text()
										});
						});
					}
					
					try{ $("#user_nm").autocomplete("destroy"); }catch(e){};
					
					$("#user_nm").autocomplete({
						source: aTags
						,autoFocus: false
						,focus: function(event, ui) {
									
								}
						,select: function(event, ui) {
									$(this).val(ui.item.value);
									$("#user_cd").val(ui.item.user_cd);
									
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
	
	function goProc(flag, final_line_cd){
		
		var frm = document.frm1;
		var msg = "";
		
		if(flag == "ins"){
			msg = "입력한 내용을 등록하시겠습니까?";
			
			if($("#frm1").find("select[name='doc_gb']").val() == ""){
				alert('<%=CommonUtil.getMessageSplit("ERROR.PARAM.02","[문서구분]","") %>'); 
				return;
			}
			
			if(isNullInput($('#frm1 #user_nm'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.02","[사용자]","") %>')) return;
			if(isNullInput($('#frm1 #user_cd'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.02","[사용자]","") %>')) return;
			
			if($("#frm1").find("select[name='order_no']").val() == ""){
				alert('<%=CommonUtil.getMessageSplit("ERROR.PARAM.02","[결재순서]","") %>'); 
				return;
			}
			
			if($("#frm1").find("select[name='p_status']").val() == ""){
				alert('<%=CommonUtil.getMessageSplit("ERROR.PARAM.02","[상태]","") %>'); 
				return;
			}
		}else if(flag == "del"){
			msg = "선택된 내용을 삭제하시겠습니까?";
		}
				
		if(confirm(msg)){
			frm.flag.value = flag;
			frm.final_line_cd.value = final_line_cd;
			frm.target = "if1";
			frm.action = "<%=sContextPath%>/tWorks.ez?c=ez022_p";
			frm.submit();		
		}
	}
	
</script>
