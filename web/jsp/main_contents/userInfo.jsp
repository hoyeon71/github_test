<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/jsp/common/inc/header.jsp"%>
<%@ page import="java.sql.*,java.util.*,java.io.*,java.text.*,java.net.*" %>
<%@ page import="com.ghayoun.ezjobs.m.domain.*" %>
<%
	//js version 추가하여 캐시 새로고침
	String jsVersion = CommonUtil.getMessage("js_version");
%>
<!DOCTYPE html>
<html>
<head><title><%=CommonUtil.getMessage("HOME.TITLE") %></title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<link href="<%=request.getContextPath() %>/css/common.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath() %>/css/custom-theme/jquery-ui.custom.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath() %>/css/custom-theme/jquery-ui.works.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath() %>/css/layout-default.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath() %>/css/ftree/ui.fancytree.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath() %>/js/SlickGrid-2.1.0/slick.grid.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath() %>/css/slick-default-theme.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath() %>/js/poshytip-1.2/tip.css" rel="stylesheet" type="text/css" />

<style type="text/css">
<!--
	
//-->
</style>

<script type="text/javascript" src="<%=request.getContextPath() %>/js/common.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/cookie.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/popup.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/xhrHandler.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.min.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery-ui.custom.min.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.resizeEnd.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.corner.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.cookie.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery-sha256.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.placeholder.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.blockUI.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.event.drag-2.2.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.dialogextend.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.layout.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.layout.slideOff.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.fancytree-all.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/SlickGrid-2.1.0/slick.core.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/SlickGrid-2.1.0/plugins/slick.autotooltips.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/SlickGrid-2.1.0/plugins/slick.checkboxselectcolumn.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/SlickGrid-2.1.0/plugins/slick.rowselectionmodel.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/SlickGrid-2.1.0/slick.dataview.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/SlickGrid-2.1.0/slick.grid.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/poshytip-1.2/jquery.poshytip.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/works_common.js?v=<%=jsVersion %>" ></script>
<script type="text/javascript">
<!--

//-->
</script>
</head>

<c:set var="duty_gb_cd" value="${fn:split(DUTY_GB_CD,',')}"/>
<c:set var="duty_gb_nm" value="${fn:split(DUTY_GB_NM,',')}"/>
<c:set var="dept_gb_cd" value="${fn:split(DEPT_GB_CD,',')}"/>
<c:set var="dept_gb_nm" value="${fn:split(DEPT_GB_NM,',')}"/>

<%
	Map<String, Object> paramMap = CommonUtil.collectParameters(request);
	
	String c = CommonUtil.isNull(paramMap.get("c"));
	String gridId = "g_"+c;	
	
	List dataCenterList = (List)request.getAttribute("dataCenterList");
%>

<body id='body_A01' leftmargin="0" topmargin="0" style='visibility:hidden;'>

<form id="f_s" name="f_s" method="post" onsubmit="return false;">	
</form>

<form id="frm2" name="frm2" method="post" onsubmit="return false;">	
	<input type="hidden" name="user_cd" id="user_cd">
</form>

<table style='width:99%;height:99%;border:none;'>
	<tr style='height:10px;'>
		<td style='vertical-align:top;'>
			<h4 class="ui-widget-header ui-corner-all"  >
				<div id='t_<%=gridId %>' class='title_area'>
					<span><%=CommonUtil.getMessage("POPUP.USER_INFO.TITLE") %></span>
				</div>
			</h4>
		</td>
	</tr>
	<tr>
		<td id='ly_<%=gridId %>' style='vertical-align:top;'>
			<form id="frm1" name="frm1" method="post" onsubmit="return false;" >
				<input type="hidden" name="flag" value='user_udt' />
				<input type="hidden" name="user_cd" id="user_cd"/>
				<input type="hidden" name="user_id" id="user_id"/>
				<input type="hidden" name="user_nm" id="user_nm"/>
				<input type="hidden" name="dept_cd" id="dept_cd"/>
				<input type="hidden" name="duty_cd" id="duty_cd"/>
				<input type="hidden" name="del_yn" id="del_yn"/>
				<input type="hidden" name="before_pw" id="before_pw"/>
				<input type="hidden" name="retire_yn" value="N"/>
				
				<div id="<%=gridId %>" class="ui-widget-header ui-corner-all" ></div>
			</form>
		</td>
	</tr>
	<tr style='height:10px;'>
		<td style='vertical-align:top;'>
			<h4 class="ui-widget-header ui-corner-all" >
				<div align='right' class='btn_area'>
					<span id='btn_ins'>저장</span>
				</div>
			</h4>
		</td>
	</tr>
</table>
<script>

	var arr_duty_gb_cd = new Array();
	var arr_duty_gb_nm = new Array();
	var arr_dept_gb_cd = new Array();
	var arr_dept_gb_nm = new Array();

	<c:forEach var="duty_gb_cd" items="${duty_gb_cd}" varStatus="s">
		var map_cd = {"cd":"${duty_gb_cd}"};
		arr_duty_gb_cd.push(map_cd);
	</c:forEach>
	<c:forEach var="duty_gb_nm" items="${duty_gb_nm}" varStatus="s">
		var map_nm = {"nm":"${duty_gb_nm}"};
		arr_duty_gb_nm.push(map_nm);
	</c:forEach>
	
	<c:forEach var="dept_gb_cd" items="${dept_gb_cd}" varStatus="s">
		var map_cd = {"cd":"${dept_gb_cd}"};
		arr_dept_gb_cd.push(map_cd);
	</c:forEach>
	<c:forEach var="dept_gb_nm" items="${dept_gb_nm}" varStatus="s">
		var map_nm = {"nm":"${dept_gb_nm}"};
		arr_dept_gb_nm.push(map_nm);
	</c:forEach>

	var gridObj = {
		id : "<%=gridId %>"
		,colModel:[
	   		{formatter:gridCellNoneFormatter,field:'c_1',id:'c_1',name:'구분',width:120,headerCssClass:'cellCenter',cssClass:'cellCenter'}
	   		,{formatter:gridCellNoneFormatter,field:'c_2',id:'c_2',name:'내용',width:300,headerCssClass:'cellCenter',cssClass:'cellCenter'}
	   		
	   		,{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'grid_idx',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   	]
		,rows:[]
		,vscroll : <%=S_GRID_VSCROLL%>
		,rowHeight: 32
	};
	
	$(document).ready(function(){
		
		viewGrid_1(gridObj,"ly_"+gridObj.id);
		userInsertInfo("<%=S_USER_CD%>");		
		
		$("#btn_ins").button().unbind("click").click(function(){
			 goProc();
		});
	});
	
	function userInsertInfo(user_cd){
		
		try{viewProgBar(true);}catch(e){}
		
		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=userList&user_cd='+user_cd;
		
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
						
						var user_id = "";
						var user_nm = "";
						var user_email = "";
						var user_hp = "";
						var user_tel = "";
						var dept_cd = "";
						var duty_cd = "";
						var del_yn = "";
						var no_auth = "";
						var account_lock = "";
						var user_pw = "";
						var select_dcc = "";
						var absence_user_cd = "";
						var absence_user_nm = "";
						var absence_reason = "";
						var absence_start_date = "";
						var absence_end_date = "";
						var ins_date = "";
						
						var items = $(this).find('items');
						var rowsObj = new Array();
						
						if(items.attr('cnt')=='0'){
						}else{
							items.find('item').each(function(i){						
							
								user_id = $(this).find("USER_ID").text();
								user_pw = $(this).find("USER_PW").text();
								user_nm = $(this).find("USER_NM").text();
								user_email = $(this).find("USER_EMAIL").text();
								user_hp = $(this).find("USER_HP").text();
								user_tel = $(this).find("USER_TEL").text();
								dept_cd = $(this).find("DEPT_CD").text();
								duty_cd = $(this).find("DUTY_CD").text();
								del_yn = $(this).find("DEL_YN").text();
								no_auth = $(this).find("NO_AUTH").text();
								ins_date = $(this).find("INS_DATE").text();	
								select_dcc = $(this).find("SELECT_DCC").text();
								absence_user_cd = $(this).find("ABSENCE_USER_CD").text();
								absence_user_nm = $(this).find("ABSENCE_USER_NM").text();
								absence_reason = $(this).find("ABSENCE_REASON").text();
								absence_start_date = $(this).find("ABSENCE_START_DATE").text();
								absence_end_date = $(this).find("ABSENCE_END_DATE").text();
							});						
						}
						
						
						var sTmp = "";
						
						var rowsObj = new Array();
						
						rowsObj.push({'grid_idx':rowsObj.length
							,'c_1':"아이디",'c_2':"<div class='gridInput_area' style='text-align:left;'>"+user_id+"</div>"	
						});
						
						rowsObj.push({'grid_idx':rowsObj.length
							,'c_1':"이 름",'c_2':"<div class='gridInput_area' style='text-align:left;'>"+user_nm+"</div>"	
						});
						
						rowsObj.push({'grid_idx':rowsObj.length
							,'c_1':"기존비밀번호",'c_2':"<div class='gridInput_area'><input type='password' name='user_pw' id='user_pw' style='width:100%; height:21px;'></div>"	
						});
						
						rowsObj.push({'grid_idx':rowsObj.length
							,'c_1':"신규비밀번호",'c_2':"<div class='gridInput_area'><input type='password' name='new_user_pw' id='new_user_pw' style='width:100%; height:21px;'></div>"	
						});
						
						rowsObj.push({'grid_idx':rowsObj.length
							,'c_1':"신규비밀번호확인",'c_2':"<div class='gridInput_area'><input type='password' name='re_new_user_pw' id='re_new_user_pw' style='width:100%; height:21px;'></div>"	
						});
												
						rowsObj.push({'grid_idx':rowsObj.length
							,'c_1':"이메일",'c_2':"<div class='gridInput_area'><input type='text' name='user_email' id='user_email' style='width:100%; height:21px;'></div>"	
						});
						
						rowsObj.push({'grid_idx':rowsObj.length
							,'c_1':"휴대폰번호",'c_2':"<div class='gridInput_area'><input type='text' name='user_hp' id='user_hp' style='width:100%; height:21px;'></div>"	
						});
						
						rowsObj.push({'grid_idx':rowsObj.length
							,'c_1':"내선번호",'c_2':"<div class='gridInput_area'><input type='text' name='user_tel' id='user_tel' style='width:100%; height:21px;'></div>"	
						});
						
						sTmp = "";
						sTmp += "<div class='gridInput_area' style='text-align:left;'>";
						for(var j=0;j<arr_dept_gb_cd.length;j++){
							if(dept_cd == arr_dept_gb_cd[j].cd){
								sTmp += arr_dept_gb_nm[j].nm;
							}
						}
						sTmp += "</div>";
						rowsObj.push({'grid_idx':rowsObj.length
							,'c_1':"부 서",'c_2':sTmp	
						});
						
						sTmp = "";
						sTmp += "<div class='gridInput_area' style='text-align:left;'>";
						for(var j=0;j<arr_duty_gb_cd.length;j++){
							if(duty_cd == arr_duty_gb_cd[j].cd){
								sTmp += arr_duty_gb_nm[j].nm;
							}
						}
						sTmp += "</div>";
						rowsObj.push({'grid_idx':rowsObj.length
							,'c_1':"직 책",'c_2':sTmp
						});
						
						rowsObj.push({'grid_idx':rowsObj.length
							,'c_1':"등록일",'c_2':"<div class='gridInput_area' style='text-align:left;'>"+ins_date+"</div>"	
						});
						
						rowsObj.push({'grid_idx':rowsObj.length
							,'c_1':"결재선관리",'c_2':"<div class='gridInput_area' style='text-align:left;'><span id='btn_approval'>설정</span></div>"	
						});
						
						sTmp = "";
						sTmp += "<div><select name='select_data_center_code' id='select_data_center_code' style='width:100%; height:27px;'>";
						<c:forEach items="${dataCenterList}" var="item" varStatus="status">							
							sTmp += "<option value='${item.data_center_code}'>${item.data_center_name}</option>";							
						</c:forEach>
						sTmp += "</select></div>";
						rowsObj.push({'grid_idx':rowsObj.length
							,'c_1':"CTM선택",'c_2':sTmp
						});	
						
						rowsObj.push({'grid_idx':rowsObj.length
							,'c_1':"대리결재자",'c_2':"<div class='gridInput_area'><input type='text' name='absence_user_nm' id='absence_user_nm' style='width:80%; height:21px;'><input type='hidden' name='absence_user_cd' id='absence_user_cd'>&nbsp;<span id='btn_absence_del'>삭제</span></div>"	
						});
						
						rowsObj.push({'grid_idx':rowsObj.length
							,'c_1':"대리결재사유",'c_2':"<div class='gridInput_area'><input type='text' name='absence_reason' id='absence_reason' style='width:100%; height:21px;'></div>"	
						});
						
						rowsObj.push({'grid_idx':rowsObj.length
							,'c_1':"대리결재기간",'c_2':"<div class='gridInput_area'><input type='text' name='absence_start_date' id='absence_start_date' class='input datepick' style='width:25%; height:21px;' readOnly>&nbsp;<span id='a_start_date'>설정</span>&nbsp;&nbsp;~&nbsp;&nbsp;<input type='text' name='absence_end_date' id='absence_end_date' class='input datepick' style='width:25%; height:21px;' readOnly>&nbsp;<span id='a_end_date'>설정</span></div>"	
						});
						
						
						gridObj.rows = rowsObj;
						setGridRows(gridObj);
					
						initIme();
						
						$("#user_cd").val(user_cd);
						$("#user_id").val(user_id);
						$("#user_nm").val(user_nm);
						$("#dept_cd").val(dept_cd);
						$("#duty_cd").val(duty_cd);
						$("#del_yn").val(del_yn);
						$("#before_pw").val(user_pw);
						$("#user_email").val(user_email);
						$("#user_hp").val(user_hp);
						$("#user_tel").val(user_tel);
						$("#select_data_center_code").val(select_dcc);
						$("#absence_user_cd").val(absence_user_cd);
						$("#absence_user_nm").val(absence_user_nm);
						$("#absence_reason").val(absence_reason);
						$("#absence_start_date").val(absence_start_date);
						$("#absence_end_date").val(absence_end_date);
						
						$("#btn_approval").button().unbind("click").click(function(){
						
							popupApprovalLine(user_cd);
						});
						
						$("#absence_start_date").addClass("ime_readonly").unbind('click').click(function(){
							dpCalMin(this.id,'yymmdd');
						});
						
						$("#absence_end_date").addClass("ime_readonly").unbind('click').click(function(){
							dpCalMin(this.id,'yymmdd');
						});
						
						$("#a_start_date").button().unbind("click").click(function(){
							dpCalMin('absence_start_date','yymmdd');
						});
						$("#a_end_date").button().unbind("click").click(function(){
							dpCalMin('absence_end_date','yymmdd');
						});
						
						$("#btn_absence_del").button().unbind("click").click(function(){
							
							var frm = document.frm1;
							frm.absence_user_nm.value = "";
							frm.absence_user_cd.value = "";
							
						});
						
						$('#absence_user_nm').unbind('keypress').keypress(function(e){
							if(e.keyCode==13 && trim($(this).val())!=''){
								getUserList($(this).val());
							}
						}).unbind('keyup').keyup(function(e){
							if($('#absence_user_cd').val()!='' && $(this).data('sel_v') != $(this).val()){
								$('#absence_user_cd').val('');
								$(this).removeClass('input_complete');
							}
							
						});		
					});
					
					try{viewProgBar(false);}catch(e){}
				}
		, null );
		
		xhr.sendRequest();	
	}
	
	function getUserList(absence_user_nm){
		
		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=userList&popup=1&p_search_gubun=user_nm&p_search_text='+encodeURIComponent(absence_user_nm);
		
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
										,label:'['+$(this).find('DEPT_NM').text()+']'+'['+$(this).find('DUTY_NM').text()+']'+$(this).find('USER_NM').text()
										,user_cd:$(this).find('USER_CD').text()
										,dept_nm:$(this).find('DEPT_NM').text()
										,dept_cd:$(this).find('DEPT_CD').text()
										});
						});
					}
					
					try{ $("#absence_user_nm").autocomplete("destroy"); }catch(e){};
					
					$("#absence_user_nm").autocomplete({
						source: aTags
						,autoFocus: false
						,focus: function(event, ui) {
									
								}
						,select: function(event, ui) {
									$(this).val(ui.item.value);
									$("#absence_user_cd").val(ui.item.user_cd);
									
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
	
	function popupApprovalLine(user_cd){
		
		var frm = document.frm2;
		
		frm.user_cd.value = user_cd;	
		openPopupCenter("about:blank","popupApprovalLine",640, 310);	
		frm.target = "popupApprovalLine";		
		frm.action = "<%=sContextPath%>/tWorks.ez?c=ez002_approval_line";
	
		frm.submit();
	}
	
	function goProc(){
		
		var frm = document.frm1;
		
		if(isNullInput(document.getElementById('user_pw'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[기존비밀번호]","") %>') ) return;
		
		if((document.getElementById('new_user_pw').value != "" && document.getElementById('re_new_user_pw').value == "") ||
			(document.getElementById('new_user_pw').value == "" && document.getElementById('re_new_user_pw').value != "")	) {
						
			alert("신규비밀번호를 확인해 주세요.");
			document.getElementById('new_user_pw').focus();
			return;
		}
		
		if(frm.new_user_pw.value != ""){
			if(isPw(frm.new_user_pw.value) == false){
				alert("신규비밀번호를 형식에 맞게 입력해 주세요.\n비밀번호는 영소문자,숫자,특수문자 조합 8자 이상이어야 합니다.");
				document.getElementById('new_user_pw').focus();
				return;
			}
		}
		
		if(document.getElementById('new_user_pw').value != document.getElementById('re_new_user_pw').value ) {
			alert("신규비밀번호가 일치하지 않습니다.");
			document.getElementById('new_user_pw').focus();
			return;
		}
		
		if(frm.absence_user_cd.value != ""){
			if(frm.absence_start_date.value == "" || frm.absence_end_date.value == ""){
				alert("대리결재 기간을 입력해 주세요.");
				return;
			}
		}
				
		frm.user_pw.value = $.sha256(frm.user_pw.value);
		if(frm.new_user_pw.value != ""){
			frm.new_user_pw.value = $.sha256(frm.new_user_pw.value);
		}
		frm.user_cd.value = "<%=S_USER_CD%>";
		frm.target = "if1";
		frm.action = "<%=sContextPath%>/tWorks.ez?c=ez002_info_p";
		frm.submit();
	}
	
</script>
<script type="text/javascript" >
<!--
	var prcFrameId= "prcFrameA01";
	$(window).load(function(){
		$('body').css({'visibility':'visible'});
	});
	
//-->
</script>
<%@include file="/jsp/common/inc/progBar.jsp"  %>
<iframe name="if1" id="if1" width="0" height="0"></iframe>
</body>
</html>