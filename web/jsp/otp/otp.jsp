<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.ghayoun.ezjobs.t.domain.*" %>

<%@include file="/jsp/common/inc/header.jsp"%>

<%
	Map<String, Object> paramMap = CommonUtil.collectParameters(request);


	String strUserCd 	= CommonUtil.isNull(paramMap.get("user_cd"));
	String strUserId 	= CommonUtil.isNull(paramMap.get("user_id"));
	String strUserPw 	= CommonUtil.isNull(paramMap.get("user_pw"));

	//js version 추가하여 캐시 새로고침
	String jsVersion 	= CommonUtil.getMessage("js_version");

	// OTP 인증 여부 확인
	String strOtpYn 		= CommonUtil.isNull(CommonUtil.getMessage("OTP_YN"));
	String strOtpLength 	= CommonUtil.isNull(CommonUtil.getMessage("OTP_LENGTH"));
	String strOtpTime 		= CommonUtil.isNull(CommonUtil.getMessage("OTP_TIME"));
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head><title>OTP 추가 인증</title>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<link rel="stylesheet" href="<%=sContextPath %>/css/css.css" type="text/css">

<link href="<%=request.getContextPath() %>/css/common.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath() %>/css/custom-theme/jquery-ui.custom.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath() %>/css/custom-theme/jquery-ui.works.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath() %>/css/layout-default.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath() %>/css/ftree/ui.fancytree.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath() %>/js/SlickGrid-2.1.0/slick.grid.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath() %>/js/SlickGrid-2.1.0/css/select2.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath() %>/css/slick-default-theme.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath() %>/js/poshytip-1.2/tip.css" rel="stylesheet" type="text/css" />

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
<script type="text/javascript" src="<%=request.getContextPath() %>/js/SlickGrid-2.1.0/plugins/slick.autocolumnsize.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/SlickGrid-2.1.0/plugins/select2.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/SlickGrid-2.1.0/slick.dataview.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/SlickGrid-2.1.0/slick.grid.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/SlickGrid-2.1.0/slick.editors.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/poshytip-1.2/jquery.poshytip.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/calendar.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery-ui.multidatespicker.js" ></script>
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

	#btn_login {
		vertical-align:middle;
		background-color: #6a89b7;
		margin:5px;
		border-radius: 10px;
		height:50px;
		width:130px;
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
		height: 32px;
		font-size: 15px;
		border: 0px;
		outline: none;
		background-color: rgb(233, 233, 233);
	}
</style>
<script type="text/javascript" >
	$(document).ready(function() {
		otp_click();
		//document.getElementById('otp').placeholder = "OTP 발송을 클릭해주세요.";

	});

</script>
</head>

<%@include file="/jsp/common/inc/progBar.jsp"  %>

<body topmargin="0" leftmargin="0"  >
<div id='ly_wrap' style='width:100%;height:100%;'>

	<form id="f_1" name="f_1" method="post" onsubmit="return false;">
		<input type='hidden' name='user_cd' 		value='<%=strUserCd%>'>
		<input type='hidden' name='user_id' 		value='<%=strUserId%>'>
		<input type='hidden' name='user_pw' 		value='<%=strUserPw%>'>

		<div id='wrap_login'>
			<table width="300" border="0" cellspacing="0" cellpadding="0" >
				<tr>
					<td style="border-bottom:1px solid #c3cfe2;" >
						<img src="<%=sContextPath %>/imgs/2차인증.png" style='height:70px;'>
					</td>
				</tr>
				<tr style="height:20px;">
					<td><span>전송된 OTP 인증 번호를 입력해 주세요.</span></td>
				</tr>
				<tr>
					<td height="40" style='vertical-align:middle;padding:20px 0px 10px 20px;'>
						<input type="text" name="user_id" id="user_id" value='<%=strUserId %>' class='ime_disabled' style='border:0px;border-radius: 15px;text-indent:10px;' disabled/>
					</td>
				</tr>
				<tr>
					<td height="40" style='vertical-align:middle;padding:0px 0px 10px 20px;'>
						<input type="password" name='otp' id="otp" tabindex='2' placeholder='인증번호 6자리' style='border:0px;border-radius: 15px;text-indent:10px;' />
					</td>
				</tr>
				<tr>
					<td><span id="time" style="padding-left:15px;height:10px;color:red;"></span></td>
				</tr>
				<tr>
					<td>
						<input type="button" name="btn_otp" id='btn_otp' onclick="otp_click()" value="OTP 재발송" style='cursor:pointer;'>
						<input type="button" name="btn_login" id='btn_login' onclick="otp_check()" value="로그인"  style='cursor:pointer;'>
					</td>
				</tr>
			</table>
		</div>
	</form>

</div>

<iframe name="prcFrame" src="" style='width:0px;height:0px;border:none;' ></iframe>

<script type="text/javascript" >

	$(window).resize(function(){
		setTimeout(function(){
			$('#wrap_login').css({'position':'absolute'}).position({
				my: "center center"
				,at: "center center"
				,of:$(window)
			});
		}, 10);

	}).trigger('resize');

	var countdownTimer; // 타이머 ID를 저장할 전역 변수

	function login() {

		var f_1 = document.f_1;

		try{top.viewProgBar(true);}catch(e){}
		f_1.action = "<%=sContextPath %>/tWorks.ez?c=ez001";
		f_1.submit();
	}

	function otp_click() {

		var user_cd = "<%=strUserCd%>";

		$.ajax({
			url: "otp_insert.jsp?user_cd="+encodeURIComponent(user_cd), 	// 호출하고자 하는 JSP의 경로
			type: "GET", 				// 또는 "POST", 요청 방식
			dataType: "html", 			// 받고자 하는 데이터 타입
			success: function(response) {
				// 성공적으로 데이터를 받아왔을 때 실행될 코드
				// 예를 들어, 받아온 HTML을 특정 <div>에 삽입
				//$('#result').html(response);
				//alert("OTP 번호를 발송하였습니다.");
				document.getElementById('otp').value = "";
			},
			error: function(xhr, status, error) {
				// 오류 발생 시 처리할 코드
				//console.error("An error occurred: " + error);
				alert("OTP 발송에 실패하였습니다.");
			}
		});

		var otpInput 	= document.getElementById('time');
		var otpTimeout 	= "<%=strOtpTime%>" * 60;

		// 이전 카운트다운이 있다면 취소
		if (countdownTimer) {
			clearTimeout(countdownTimer);
		}

		startCountdown(otpTimeout, otpInput); // 3분 카운트다운 시작
	}

	function startCountdown(duration, element) {

		var timer = duration, minutes, seconds;

		function updateCountdown() {

			minutes = parseInt(timer / 60, 10);
			seconds = parseInt(timer % 60, 10);

			minutes = minutes < 10 ? "0" + minutes : minutes;
			seconds = seconds < 10 ? "0" + seconds : seconds;

			$("#time").text("OTP 입력 (" + minutes + ":" + seconds + ")");
			element.placeholder = "OTP 입력 (" + minutes + ":" + seconds + ")";

			if (--timer < 0) {
				$("#time").text("OTP 발송을 다시 클릭해주세요.(입력 시간 초과)");
			} else {
				countdownTimer = setTimeout(updateCountdown, 1000);
			}
		}

		updateCountdown();
	}

	function otp_check() {

		if( isNullInput(document.getElementById('otp'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[OTP]","") %>') ) return;

		var user_cd = "<%=strUserCd%>";
		var otp 	= document.getElementById('otp').value;

		$.ajax({
			url: "otp_check.jsp?user_cd="+user_cd+"&otp="+encodeURIComponent(otp), 	// 호출하고자 하는 JSP의 경로
			type: "GET", 				// 또는 "POST", 요청 방식
			dataType: "html", 			// 받고자 하는 데이터 타입
			success: function(response) {

				if ( response.trim() == "성공" ) {
					login();
				} else {
					alert(response.trim());
				}
			},
			error: function(xhr, status, error) {
				alert("OTP 검증을 실패했습니다 : " + error);
			}
		});
	}

	$(document).ready(function(){

		$("#user_pw").focus();

		$( document ).disableSelection();

		$(':input').live('focus',function(){
			$(this).attr('autocomplete', 'off');
		});

		$('input, textarea').placeholder();


		initIme();
	});

</script>
</body>
</html>


