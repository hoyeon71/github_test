<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.ghayoun.ezjobs.common.util.*" %>
<%@ page import="java.sql.*,java.util.*,java.io.*,java.text.*,java.net.*" %>
<%@ page import="javax.servlet.http.HttpServletRequest" %>
<%@ page import="javax.servlet.http.HttpServletResponse" %>

<%
	String StringContextPath = request.getContextPath();

	String S_USER_NM_1 = CommonUtil.isNull(request.getSession().getAttribute("USER_NM"));

	String USER_APPR_GB = CommonUtil.isNull(request.getSession().getAttribute("USER_APPR_GB"));
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />

<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/common.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/cookie.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/popup.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.min.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery-ui.custom.min.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.layout.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.layout.slideOff.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.fancytree-all.js" ></script>
<%-- toastr 라이브러리관련 --%>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/toastr.js"></script>
<link href="<%=request.getContextPath() %>/css/toastr.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" >

	var USER_NM = "<%=S_USER_NM_1 %>";
		var apprGb 	= "<%=USER_APPR_GB%>";

		if(apprGb == "00") {
			//60초 에 한번씩 서비스 호출.
			//결재 toast 호출
			timer = setInterval(doApprovalCntChk, 60000);
			//상단 결재 건수
			timer2 = setInterval(doApprovalCntChk2, 60000);
			//상단 오류 건수
			timer3 = setInterval(doErrorCntChk, 60000);
		}
		//팝업창 - 결재 건수 조회
		function doApprovalCntChk() {

			if(apprGb != "00") return;

			var xhr 		= "";
			var result_text = "";

			var url = "<%=StringContextPath%>/tWorks.ez?c=ez023_pop";

			if (window.ActiveXObject) {
				xhr = new ActiveXObject("Microsoft.XMLHTTP");
			} else if (window.XMLHttpRequest) {
				xhr = new XMLHttpRequest();
			}

			xhr.open("POST", url, true); // POST or GET. true : 비동기 처리용 == Ajax 스타일, false : 동기 처리용 = 일반적인 스타일

			xhr.onreadystatechange = function() // 비동기 처리용 callback 함수 : 서버에서 처리가 끝나면 불리는 함수
			{
				if(xhr.readyState == 4) {
					if(xhr.status == 200) {

						result_text = xhr.responseText; // 임의의 문자열이 전송되어 온다.
						// 앞뒤 공백 제거.
						result_text = result_text.replace(/^\s+|\s+$/g,"");

						//클릭시 결재 문서함으로 이동
						toastr.options.onclick = function(){go_approvalList()};

						//표시될 때 사운드 출력
						toastr.options.onShown = function() { toastr_sound() };

						if ( result_text == "0" ) {
							document.getElementById("approval_cnt_span").innerHTML = "<font>0</font>";
						} else {
							toastr.info( USER_NM + '님이 결재하실 작업은 총 ' + result_text + '건 입니다.','결재 요청',{timeOut: 3000});
							document.getElementById("approval_cnt_span").innerHTML = "<font color='blue' size='5'><b>" + result_text + "<b></font>";
						}
					}
				}
			};

			xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded;charset=EUC-KR"); // UTF-8

			xhr.send("");
		}

		//메인 상단 - 결재 건수 조회
		function doApprovalCntChk2() {

			var xhr 		= "";
			var result_text = "";

			var url = "<%=StringContextPath%>/tWorks.ez?c=ez023_pop";

			if (window.ActiveXObject) {
				xhr = new ActiveXObject("Microsoft.XMLHTTP");
			} else if (window.XMLHttpRequest) {
				xhr = new XMLHttpRequest();
			}

			xhr.open("POST", url, true); // POST or GET. true : 비동기 처리용 == Ajax 스타일, false : 동기 처리용 = 일반적인 스타일

			xhr.onreadystatechange = function() // 비동기 처리용 callback 함수 : 서버에서 처리가 끝나면 불리는 함수
			{
				if(xhr.readyState == 4) {
					if(xhr.status == 200) {

						result_text = xhr.responseText; // 임의의 문자열이 전송되어 온다.

						// 앞뒤 공백 제거.
						result_text = result_text.replace(/^\s+|\s+$/g,"");

						if ( result_text == "0" ) {
							document.getElementById("approval_cnt_span").innerHTML = "<font>0</font>";
						} else {
							document.getElementById("approval_cnt_span").innerHTML = "<font color='blue' size='5'><b>" + result_text + "<b></font>";
						}
					}
				}
			};

			xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded;charset=EUC-KR"); // UTF-8

			xhr.send("");
		}

		//메인 상단 - 오류 건수 조회
		function doErrorCntChk() {
			var xhr 		= "";
			var result_text = "";

			var url = "<%=StringContextPath%>/tWorks.ez?c=ez044_op_pop";

			if (window.ActiveXObject) {
				xhr = new ActiveXObject("Microsoft.XMLHTTP");
			} else if (window.XMLHttpRequest) {
				xhr = new XMLHttpRequest();
			}

			xhr.open("POST", url, true); // POST or GET. true : 비동기 처리용 == Ajax 스타일, false : 동기 처리용 = 일반적인 스타일

			xhr.onreadystatechange = function() // 비동기 처리용 callback 함수 : 서버에서 처리가 끝나면 불리는 함수
			{
				if(xhr.readyState == 4) {
					if(xhr.status == 200) {

						result_text = xhr.responseText; // 임의의 문자열이 전송되어 온다.

						// 앞뒤 공백 제거.
						result_text = result_text.replace(/^\s+|\s+$/g,"");

						if ( result_text == "0" ) {
							document.getElementById("error_cnt_span").innerHTML = "<font>0</font>";
						} else {
							document.getElementById("error_cnt_span").innerHTML = "<font color='blue' size='5'><b>" + result_text + "<b></font>";
						}
					}
				}
			};

			xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded;charset=EUC-KR"); // UTF-8

			xhr.send("");
		}

	//클릭시 결재 문서함으로 이동
	function go_approvalList() {
		top.closeTab('tabs-0390');
		top.addTab('c', '결재문서함', '01', '0390', 'tWorks.ez?c=ez005&menu_gb=0390&doc_gb=99&itemGb=approvalList');
	}

	//표시될 때 사운드 출력
	function toastr_sound() {
		document.getElementById("play").innerHTML = "<embed name=bgm src=jsp/main_contents/ringtone.wav autostart=true hidden=true loop=false >";
	}
	</script>

</head>
<body>
<form id="frm" name="frm" method="post" onsubmit="return false;">
</form>
</body>
</html>