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

<script type="text/javascript">
$(document).ready(function() {

	document.getElementById('otp').placeholder = "OTP 발송을 클릭해주세요.";
	
	$("#btn_otp").button().unbind("click").click(function(){
		otp_click();
	});	
	
	$("#btn_login").button().unbind("click").click(function(){
		otp_check();
	});	
});
</script>

<script type="text/javascript" >
<!--
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
	
		var otpInput 	= document.getElementById('otp');
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
	
	        element.placeholder = "OTP 입력 (" + minutes + ":" + seconds + ")";
	
	        if (--timer < 0) {
	            element.placeholder = 'OTP 발송을 다시 클릭해주세요.(입력 시간 초과)';
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
	
//-->
</script>
</head>

<%@include file="/jsp/common/inc/progBar.jsp"  %>

<body style='display:flex; width:100%; justify-content: center; align-items: center;'>

<form id="f_1" name="f_1" method="post" onsubmit="return false;">
<input type='hidden' name='user_cd' 		value='<%=strUserCd%>'>
<input type='hidden' name='user_id' 		value='<%=strUserId%>'>
<input type='hidden' name='user_pw' 		value='<%=strUserPw%>'>

<div class="lst_area" style='width:500px; height:154px;'>
	<table style='width:100%'>
		<tr >
			<td width='30'>
				<img src="<%=sContextPath %>/images/icon_sgnb6.png"/>
			</td>
			<td style='font-size:16px;font-weight:bold;'>
				OTP 추가 인증
			</td>
			<td style='text-align:right;'>
				<h4>
					<div align='right'>
						<span id='btn_otp' >OTP 발송</span>
						<span id='btn_login' >로그인</span>
					</div>
				</h4>
			</td>
		</tr>
	</table>
	<table class='board_lst skyblue' width='50%' border='0' cellpadding='1' cellspacing='1' bgcolor='#dcdcdc' >
		<tr>
			<th width='30%'>아이디</th>
			<td><%=strUserId %></td>
		</tr>		
		<tr>
			<th >OTP</th>
			<td ><input type='password' id='otp' name='otp' style='width:85%;'/></td>
		</tr>
	</table>
</div>
</form>

<iframe name="prcFrame" src="" width="0" height="0" frameborder="0" ></iframe>
</body>
</html>
