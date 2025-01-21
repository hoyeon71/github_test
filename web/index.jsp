<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@include file="/jsp/common/inc/header.jsp"%>

<%
  response.setHeader("Cache-Control","no-store"); //HTTP 1.1 
  response.setHeader("Pragma","no-cache"); //HTTP 1.0
  response.setDateHeader ("Expires", 0);
  
  response.setHeader("X-Frame-Options", "SAMEORIGIN"); 
  response.setHeader("X-XSS-Protection", "1; mode=block");
	
%>

<%
	Map<String, Object> paramMap = CommonUtil.collectParameters(request);

	//js version 추가하여 캐시 새로고침
	String jsVersion 		= CommonUtil.getMessage("js_version");
	String strServerGb 		= CommonUtil.isNull(CommonUtil.getMessage("SERVER_GB"));
	String strDbGubun 		= CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"));
	String strDbGubunShow	= CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN_SHOW"));
	String strTitle 		= "";
	String strColor 		= "";

	if (strServerGb.equals("D")) {
		strTitle = "개발계";
		strColor = "blue";
	}else if(strServerGb.equals("T")){
		strTitle = "테스트계";
		strColor = "#ff7f00";
	}else if(strServerGb.equals("P")){
		strTitle = "운영계";
		strColor = "red";
	}
	
	InetAddress addr = null;
	addr = InetAddress.getLocalHost();
	String strHost = addr.getHostName();

	if(strDbGubunShow.equals("Y")){
		strTitle += "_"+strDbGubun;
		strTitle += "_"+strHost;
	}


	strTitle = "<font color='"+strColor+"' size='1'>["+strTitle+"]</font>";
	
	//CommonUtil.logger("index.jsp : " + strTitle, null);
%>

<!DOCTYPE html>
<html>
<head><title><%=CommonUtil.getMessage("D.HOME.TITLE") %> </title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=Edge">

<link href="<%=request.getContextPath() %>/css/common.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath() %>/css/custom-theme/jquery-ui.custom.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath() %>/css/custom-theme/jquery-ui.works.css" rel="stylesheet" type="text/css" />

<style type="text/css">

html,body {
	overflow-x:hidden;
	overflow-y:hidden;
}

#login {
	background-color: #6a89b7;
	margin-top: 30px;
	border-radius: 10px;
	height:50px;
	width:230px;
	color:#FFFFFF;
	font-weight: bold;
	font-size:250px;
}

#temp_pw {
	background-color: #6a89b7;
	margin-top: 10px;
	border-radius: 10px;
	height:50px;
	width:230px;
	color:#FFFFFF;
	font-weight: bold;
	font-size:250px;
}

.textbox {
	width: 50%;
	border-radius: 10px;
	border: none;
	align-content: center;
}

.placeholder { color: gray; }

table,td,th,div,span{
	border-bottom:0px solid #ffffff;
	border-right:0px solid #ffffff;
	background-color: #f0f3f7;
}

input {
	width: 100%;
	padding: 10px;
	box-sizing: border-box;
	border-radius: 5px;
	border: none;
}

#login-form > label{
	color: #999999;
}

.checkbox-container {
	display: flex;
	align-items: center;
}

.toggleSwitch {
	width: 30px;
	height: 15px;
	display: block;
	position: relative;
	border-radius: 30px;
	background-color: #fff;
	box-shadow: 0 0 10px 2px rgba(0 0 0 / 10%);
	cursor: pointer;
}

/* 토글 버튼 */
.toggleSwitch .toggleButton {
	/* 버튼은 토글보다 작아야함  */
	width: 10px;
	height: 10px;
	position: absolute;
	top: 50%;
	left: 4px;
	transform: translateY(-50%);
	border-radius: 50%;
	background: #f0f3f7;
}
/* 체크박스가 체크되면 변경 이벤트 */
#chk_keep_login:checked ~ .toggleSwitch {
	background: #98b4df;
}

#chk_keep_login:checked ~ .toggleSwitch .toggleButton {
	left: calc(50%);
	background: #fff;
}

.toggleSwitch, .toggleButton {
	transition: all 0.2s ease-in;
}
</style>

<script type="text/javascript" src="<%=request.getContextPath() %>/js/common.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/cookie.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/popup.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/xhrHandler.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.min.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery-ui.custom.min.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.corner.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery-sha256.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.backstretch.min.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.placeholder.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.blockUI.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/works_common.js?v=<%=jsVersion %>" ></script>
<script type="text/javascript" >

function login(){
	var f_1 = document.f_1;
	
	if( isNullInput(f_1.user_id,"[아이디]를 입력하세요.") ) return;
	if( isNullInput(f_1.user_pw,"[비밀번호]를 입력하세요.") ) return;
	
	//$('#user_pw').val($.sha256($('#user_pw').val()));
	
	// 쿠키 저장.		
	// 아이디 저장을 체크하였을때
	if ($("#keep_login").val() == "Y") {
		setCookie("user_id", f_1.user_id.value, 7) // 쿠키이름을 id로 form.user_id.value 값을 7일동안 저장		
		
	} else{   // 아이디 저장을 체크하지 않았을때			
	 	setCookie("user_id", document.getElementById("user_id").value, 0) // 날짜를 0으로 저장하여 쿠키 삭제
	}
	
	try{top.viewProgBar(true);}catch(e){}
	//f_1.target = "prcFrame";
	f_1.action = "<%=sContextPath %>/tWorks.ez?c=ez001";
	f_1.submit();
}

function tempPassword(){
	var f_1 = document.f_1;
	
	if( isNullInput(f_1.user_id,"[아이디]를 입력하세요.") ) return;
	
	try{top.viewProgBar(true);}catch(e){}
	f_1.action = "<%=sContextPath %>/tWorks.ez?c=ez001_tempPassword";
	f_1.submit();
}

</script>
</head>

<%@include file="/jsp/common/inc/progBar.jsp"  %>

<body topmargin="0" leftmargin="0"  >
<div id='ly_wrap' style='width:100%;height:100%;'>
	
<form id="f_1" name="f_1" method="post" onsubmit="return false;">	
	<input type='hidden' name='login_gubun' value='ezjobs'>
	<input type="hidden" name="keep_login" id="keep_login" value='N' />

	<div id='wrap_login'>
		<table width="350" border="0" cellspacing="0" cellpadding="0" >
			<tr>
				<td colspan="3"  align="center" style='vertical-align:middle;padding-top:10px;padding-bottom:5px;border-bottom:1px solid #c3cfe2;'>
					<img src="<%=request.getContextPath() %>/imgs/ez_logo.png" style='height:60px;'>
					<img src="<%=request.getContextPath() %>/imgs/ezjobs_logo.png" style='height:60px;'>
					<br>
				</td>
			</tr>
			<tr>
				<td height="45" colspan="3" class="textbox" style='vertical-align:middle;padding:5px 15px 0px 15px;'>
					<span style='height:9px;font-size:9px;float:right;padding-right:5px;'><%=strTitle %></span><br>
					<input type="text" name="user_id" id="user_id" tabindex='1'   placeholder='아이디' onkeypress="if(event.keyCode==13) window.login();" class='ime_disabled' style='border-radius: 15px;font-size:14px;border:0px;width:100%;'  />
				</td>
			</tr>
			<tr>
				<td height="45" colspan="3" class="textbox" style='vertical-align:middle;padding:0px 15px 10px 15px;'>
					<input type="password" name='user_pw' id="user_pw" tabindex='2'  placeholder='비밀번호' onkeypress="if(event.keyCode==13) window.login();"  style='border-radius: 15px;font-size:14px;border:0px;width:100%;' />
				</td>
			</tr>
			<tr>
				<td width="280" align="left" style='vertical-align:middle; padding-left:20px'>
					<div class="checkbox-container">
						<input type="checkbox" id="chk_keep_login" hidden>
						<label for="chk_keep_login" class="toggleSwitch">
							<span class="toggleButton"></span>
						</label>
						<span>&nbsp아이디 저장</span>
					</div>
				</td>
			</tr>
			<tr>
				<td colspan="3" align="center">
					<input type="button" id = 'login' name = 'login' value="로그인" onclick="window.login();" style='cursor:pointer;'>
					<input type="button" id = 'temp_pw' name = 'temp_pw' value="임시비밀번호 발급" onclick="window.tempPassword();" style='cursor:pointer;'>
				</td>
			</tr>
		</table>

		<!-- div style='text-align:right;margin:-20px 15px 0px 0px;'>Copyright (C) Ghayoun I&C. EzRA Reboot Automation Solution All Rights Reserved.</div-->
	</div>

</form>

</div>

<iframe name="prcFrame" src="" style='width:0px;height:0px;border:none;' ></iframe>

<script type="text/javascript" >
<!--
	$.backstretch("<%=request.getContextPath() %>/imgs/back/back_index.jpg");

	$(window).resize(function(){
		setTimeout(function(){
			$('#wrap_login').css({'position':'absolute'}).position({
				my: "center center"
				,at: "center center"
				,of:$(window)
			});
		}, 10); 
		
	}).trigger('resize');
	
	$(document).ready(function(){
		
		$("#user_id").focus();
		
		$( document ).disableSelection();
		
		$(':input').live('focus',function(){
			$(this).attr('autocomplete', 'off');
		});

		$('input, textarea').placeholder();

		// getCookie함수로 id라는 이름의 쿠키를 불러와서 있을 경우
		if(getCookie("user_id")) {

			var id_value = getCookie("user_id").split(";")

			// input 이름이 user_id인 곳에 getCookie("id") 값을 넣어줌
		 	$("#user_id").val(id_value[0]);

			// 체크박스는 체크됨으로 셋팅
		 	$('#keep_login').val('Y');
			document.getElementById('chk_keep_login').checked = true;

			$("#user_pw").focus();
		 	
		} else {
			
			// 체크박스는 해제
		 	$('#keep_login').val('N');
			document.getElementById('chk_keep_login').checked = false;
			$("#user_id").focus();
		}

		$('#chk_keep_login').unbind('click').click(function(){

			if($('#keep_login').val()=='N'){
				$('#keep_login').val('Y');
				document.getElementById('chk_keep_login').checked = true;
			}else{
				$('#keep_login').val('N');
				document.getElementById('chk_keep_login').checked = false;
			}
		});


		initIme();
	});
	
	//쿠키에 아이디 저장
	function setCookie(name, value, expiredays) {
		
	 	var todayDate= new Date();
	 	
	 	todayDate.setDate(todayDate.getDate() + expiredays);
	 	document.cookie = name + "=" + escape(value)+"; path=/; expires=" + todayDate.toGMTString()+";"
	}
	
	// 쿠키 조회
	function getCookie(Name) {
		
		var search =Name + "=";
		
	 	if ( document.cookie.length > 0 ) {
	 	 	
	  		offset = document.cookie.indexOf(search);
	  		
	  		if (offset != -1) {
	  	  		
	  			offset += search.length;
	  			end = document.cookie.length;
	  			
	  			if(end == -1)
	   			end =document.cookie.length;
	   			
		  		return unescape(document.cookie.substring(offset,end));
	  		}
	 	}
	}
	
//-->
</script>	
</body>
</html>


