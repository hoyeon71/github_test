<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.ghayoun.ezjobs.t.domain.*" %>

<%@include file="/jsp/common/inc/header.jsp"%>

<%
	Map<String, Object> paramMap = CommonUtil.collectParameters(request);

	String strUserId 	= CommonUtil.isNull(paramMap.get("user_id"));
	String strUserCd 	= CommonUtil.isNull(paramMap.get("user_cd"));
	String strPwChk  	= CommonUtil.isNull(paramMap.get("pw_chk"));
	String screenStatus	= CommonUtil.isNull(paramMap.get("screenStatus"));
	
	//js version 추가하여 캐시 새로고침
	String jsVersion 	= CommonUtil.getMessage("js_version");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head><title>패스워드 변경</title>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<link rel="stylesheet" href="<%=sContextPath %>/css/css.css" type="text/css">

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
	<style type="text/css">

		html,body {
			overflow-x:hidden;
			overflow-y:hidden;
		}

		#btn_otp {
			vertical-align:middle;
			background-color: #9fb1d7;
			margin:5px;
			border-radius: 10px;
			height:50px;
			width:130px;
			color:#FFFFFF;
			font-weight: bold;
			align-content: center;
		}

		#btn_change {
			vertical-align:middle;
			background-color: #6a89b7;
			margin-top:20px;
			border-radius: 10px;
			height:50px;
			width:200px;
			color:#FFFFFF;
			font-weight: bold;
			align-content: center;
		}

		.placeholder {
			color: gray;
			text-align: center;
		}

		table,td,th,div,span{
			border-bottom:0px solid #ffffff;
			border-right:0px solid #ffffff;
			background-color: #f0f3f7;
		}

		input {
			width: 250px;
			height: 30px;
			font-size: 15px;
			border: 0px;
			outline: none;
			background-color: rgb(233, 233, 233);
		}
	</style>
<script type="text/javascript">
$(document).ready(function() {
	
	var strPwChk = "<%=strPwChk%>";
	//패스워드 주기 만료 시 기존 패스워드 미입력
	if(strPwChk != "Y"){
		//$("#user_pw").attr("disabled",true); 
		//document.getElementById('user_pw').style.backgroundColor = '#dcdcdc';
	}else{
		document.getElementById('user_pw').focus();
	}
	
	$('#new_user_pw').unbind('keypress').keypress(function(e){			
		if(e.keyCode==13){	
			goPrc();
		}
	});
	
	$('#re_new_user_pw').unbind('keypress').keypress(function(e){			
		if(e.keyCode==13){	
			goPrc();
		}
	});
	
});
</script>

<script type="text/javascript" >


	function goPrc(){
		var frm = document.frm1;
		var strPwChk = "<%=strPwChk%>";
		
		//if(strPwChk == "Y"){
			if( isNullInput(document.getElementById('user_pw'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[기존패스워드]","") %>') ) return;
			var user_pw 		= $('#user_pw').val();
		//}
		if( isNullInput(document.getElementById('new_user_pw'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[신규 패스워드]","") %>') ) return;
		if( isNullInput(document.getElementById('re_new_user_pw'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[신규 패스워드 확인]","") %>') ) return;
		
		var new_user_pw 	= $('#new_user_pw').val();
		var re_new_user_pw 	= $('#re_new_user_pw').val();

		if ( new_user_pw != re_new_user_pw ) {
			alert("신규 패스워드가 일치하지 않습니다.");
			document.getElementById('new_user_pw').focus();
			return;
		}

		//if ( user_pw == new_user_pw && strPwChk == "Y") {
		if ( user_pw == new_user_pw ) {
			alert("기존 패스워드와 동일한 패스워드입니다.");
			document.getElementById('new_user_pw').focus();
			return;
		}

		if(isPw($('#new_user_pw').val()) == false){
			alert("신규비밀번호를 형식에 맞게 입력해 주세요.\n영문 대/소문자, 숫자, 특수문자 3가지 조합 8자 이상\n영문 대/소문자, 숫자, 특수문자 2가지 조합 10자 이상 이어야 합니다.");
			document.getElementById('new_user_pw').focus();
			return;
		}

		frm.before_pw.value = user_pw;
		//패스워드 초기화/패스워드 주기만료 flag 분리
		if(strPwChk != "Y"){
		frm.flag.value 		= "pw_change";
		}else{
		frm.flag.value		= "pw_date_over"
		}
		
		//frm.target = "_self";
		frm.action = "<%=sContextPath%>/tWorks.ez?c=ez002_pw_change";
		frm.submit();
	}
	
	
//-->
</script>
</head>

<%@include file="/jsp/common/inc/progBar.jsp"  %>


<body topmargin="0" leftmargin="0"  >
<div id='ly_wrap' style='width:100%;height:100%;'>
	<form id="frm1" name="frm1" method="post" onsubmit="return false;">
	<input type='hidden' name='user_id' 		value='<%=strUserId%>'>
	<input type='hidden' name='user_cd' 		value='<%=strUserCd%>'>
	<input type='hidden' name='before_pw' 		value=''>
	<input type='hidden' name='pw_chk' 			value='<%=strPwChk%>'>
	<input type='hidden' name='flag' 			value=''>
	<input type='hidden' name='screen_status' 	value='<%=screenStatus%>'>

		<div id='wrap_pw'>
		<table width="300" border="0" cellspacing="0" cellpadding="0" >
			<tr>
				<td style="border-bottom:1px solid #c3cfe2;" >
					<img src="<%=sContextPath %>/imgs/changPW.png" style='height:70px;'>
				</td>
			</tr>
			<tr style="height:20px;">
				<td><span>새로운 패스워드로 변경해주세요.</span></td>
			</tr>
			<tr>
				<td height="40" style='vertical-align:middle;padding:20px 0px 10px 20px;'>
					<input type="text" name="user_id" id="user_id" value='<%=strUserId %>' class='ime_disabled' style='border:0px;border-radius: 15px;text-indent:10px;' disabled/>
				</td>
			</tr>
			<tr>
				<td height="40" style='vertical-align:middle;padding:0px 0px 10px 20px;'>
					<input type="password" name='user_pw' id="user_pw" tabindex='2' placeholder='기존 패스워드' style='border:0px;border-radius: 15px;text-indent:10px;' />
				</td>
			</tr>
			<tr>
				<td height="40" style='vertical-align:middle;padding:0px 0px 10px 20px;'>
					<input type="password" name='new_user_pw' id="new_user_pw" tabindex='2' placeholder='신규 패스워드' style='border:0px;border-radius: 15px;text-indent:10px;' />
				</td>
			</tr>
			<tr>
				<td height="40" style='vertical-align:middle;padding:0px 0px 10px 20px;'>
					<input type="password" name='re_new_user_pw' id="re_new_user_pw" tabindex='2' placeholder='신규 패스워드 확인' style='border:0px;border-radius: 15px;text-indent:10px;' />
				</td>
			</tr>
			<tr>
				<td style='vertical-align:middle;text-align: center; '>
					<input type="button" name="btn_change" id='btn_change' onclick="goPrc()" value="패스워드 변경"  style='cursor:pointer;'>
				</td>
			</tr>
		</table>
		</div>
	</form>
</div>
<iframe name="prcFrame" src="" width="0" height="0" frameborder="0" ></iframe>
<script type="text/javascript" >

	$(window).resize(function(){
		setTimeout(function(){
			$('#wrap_pw').css({'position':'absolute'}).position({
				my: "center center"
				,at: "center center"
				,of:$(window)
			});
		}, 10);

	}).trigger('resize');
</script>
</body>
</html>
