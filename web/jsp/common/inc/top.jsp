<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/jsp/common/inc/header.jsp"%>
<%@include file="/jsp/common/inc/approvalChk.jsp"%>

<%
	Map<String, Object> paramMap = CommonUtil.collectParameters(request);
	String aGb[] = null;

	CommonBean approvalLineBean	= (CommonBean)request.getAttribute("approvalLineBean");
	CommonBean errorLineBean	= (CommonBean)request.getAttribute("errorLineBean");

	int iApprovalCnt 		= 0;
	int iErrorCnt 			= 0;
	String strApprovalCnt 	= "0";
	String strErrorCnt 		= "0";
	String from_hostTime	= "";
	String from_odate		= "";

	if ( approvalLineBean != null ) {

		iApprovalCnt = approvalLineBean.getTotal_count();
		
		if ( iApprovalCnt > 0 ) {
			strApprovalCnt = "<font color='blue' size='5'><b> " + iApprovalCnt + "<b></font>";
		}
	}

	if ( errorLineBean != null ) {
		iErrorCnt = Integer.parseInt(errorLineBean.getTotal_cnt());

		if ( iErrorCnt > 0 ) {
			strErrorCnt = "<font color='blue' size='5'><b> " + iErrorCnt + "<b></font>";
		}

		from_hostTime = CommonUtil.isNull(errorLineBean.getFrom_hostTime());
		from_odate = CommonUtil.isNull(errorLineBean.getFrom_odate());

	}

	String strServerGb 			= CommonUtil.isNull(CommonUtil.getMessage("SERVER_GB"));
	String strDbGubun 			= CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"));
	String strDbGubunShow		= CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN_SHOW"));
	String strSesstionUserGb 	= S_USER_GB;
	String strTitle				= "";
	String strColor				= "";

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
	strTitle = "<font color='"+strColor+"' size='2'><b>["+strTitle+"]</b></font>";

%>

<body onload="doApprovalCntChk2();doErrorCntChk();">
<div class="top_area">
	<span id="play"></span>
	<h1>
		<a href="<%=sContextPath %>/common.ez?c=ez00">
			<%-- <img src="<%=sContextPath %>/images/toss_logo.PNG" height="25" /> --%>
			<img src="<%=sContextPath %>/imgs/ezjobs_logo.png" width="140px;" style="padding-top:5px;" />
		</a>

	</h1>
	<div class="server_gb" style="padding-top:10px;padding-left:8px;"><%=strTitle%></div>
	<div class="user_info">
		[오류 건수 : <a href="JavaScript:error_count();" id='error_count' target="_parent"><span id="error_cnt_span"><%=strErrorCnt%></span></a>건]
		[결재 건수 : <a href="JavaScript:approval_count();" id='approval_count' target="_parent"><span id="approval_cnt_span"><%=strApprovalCnt%></span></a>건]

		<span class="user"> [<%=S_USER_ID %>] <%=S_USER_NM %><%-- [<%=S_L_GUBUN%>에서 로그인]  --%></span>
 		<a href="javascript:logout();" class="btn_white_h24">로그아웃</a>
 		<!-- <a href="javascript:window.close();" class="btn_white_h24">창닫기</a> -->
	</div>
</div>
</body>
<script>

	var session_user_gb = "<%=strSesstionUserGb%>";
	
	// 사용자가 아니면 세션 10분 주기 체크
	if ( session_user_gb != "01" ) {
		
		setInterval(function(){

			var formData = new FormData();
			formData.append("c", "cData2");
			
			$.ajax({
				url: "<%=sContextPath %>/common.ez",
				type: "POST",
				processData: false,
				contentType: false,
				dataType: "json",
				data: formData,
			})
		}, 1000 * 60 * 10);
	}
		
	function logout() {
		if( !confirm('로그아웃 하시겠습니까?') ) return;	
		location.href = "<%=sContextPath %>/common.ez?c=ez002";
	}

	function popupUserInfo(){
		openPopupCenter("<%=sContextPath%>/tWorks.ez?c=ez002_edit","popupUserInfo",500, 685);
	}
	
	function approval_count()
	{
		top.closeTabsAndAddTab('tabs-0390','c', '결재문서함', '01', '0390', 'tWorks.ez?c=ez005&menu_gb=0390&doc_gb=99&itemGb=approvalList');
	}
	function error_count()
	{
		top.closeTabsAndAddTab('tabs-0402','c', '오류관리', '04', '0402', 'aEm.ez?c=ez003_op&menu_gb=0402&itemGb=alertErrorList&top_menu=Y&message=ended not ok');
	}

	$(document).ready(function(){
		doApprovalCntChk2();doErrorCntChk();
	});

</script>