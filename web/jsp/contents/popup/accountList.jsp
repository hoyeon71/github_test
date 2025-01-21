<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.ghayoun.ezjobs.t.domain.*" %>

<%@include file="/jsp/common/inc/header.jsp"%>
<%@include file="/jsp/common/inc/sessionChkPopup.jsp"%> 

<%
	Map<String, Object> paramMap = CommonUtil.collectParameters(request);
	List accountList = (List)request.getAttribute("accountList");
	Account account = (Account)request.getAttribute("account");
	
	if ( accountList == null ) {
		out.println("Account 정보가 없거나 Agent 서버와의 통신이 실패되었습니다.<BR><BR>다시 접속 해 주세요.");
	} else {
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Frameset//EN" "http://www.w3.org/TR/html4/frameset.dtd">

<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>작업관리시스템</title>
<link rel="stylesheet" href="<%=sContextPath %>/css/css.css" type="text/css">

<script type="text/javascript" src="<%=sContextPath %>/js/jquery-1.9.0.min.js"></script>
<script type="text/javascript" src="<%=sContextPath %>/js/common.js" ></script>
<script type="text/javascript" src="<%=sContextPath %>/js/popup.js" ></script>

<style type="text/css">
	.hover { background-color:#e2f4f8; }
</style>
<script type="text/javascript" >
$(document).ready(function(){
	$('.trOver tr:lt(1000)').hover(
		function() { $(this).addClass('hover');},
		function() { $(this).removeClass('hover');}
	);

});
</script>

<script type="text/javascript" >
function selectAccount(num) {
	
	var list = new Array("FTP_ACCOUNT"
								, "FTP_LHOST", "FTP_LOSTYPE", "FTP_LUSER", "FTP_LPATH1", "FTP_CONNTYPE1"
								, "FTP_RHOST", "FTP_ROSTYPE", "FTP_RUSER", "FTP_RPATH1", "FTP_CONNTYPE2");
	
	var temp = document.getElementById('account' + num).textContent;
	temp = temp.replace(/[\t\s]+/g, " ");
	temp = temp.replace(/^\s+|\s+$/g, "");
	var bean = temp.split(" ");
	
	var host1 = 'HOST1 : ' + bean[1] + '  TYPE : ';
	var host2 = 'HOST2 : ' + bean[6] + '  TYPE : ';
	switch (bean[5]) {
	case '0':
		host1 = host1 + 'LOCAL';
		bean[5] = 'LOCAL';
		break;
	case '1':
		host1 = host1 + 'FTP';
		bean[5] = 'FTP';
		break;
	case '2':
		host1 = host1 + 'SFTP';
		bean[5] = 'SFTP';
		break;
	default:
		host1 = host1 + 'UNKNOWN';
		break;
	}	
	switch (bean[10]) {
	case '0':
		host2 = host2 + 'LOCAL';
		bean[10] = 'LOCAL';
		break;
	case '1':
		host2 = host2 + 'FTP';
		bean[10] = 'FTP';
		break;
	case '2':
		host2 = host2 + 'SFTP';
		bean[10] = 'SFTP';
		break;
	default:
		host2 = host2 + 'UNKNOWN';
		break;
	}
	
	top.opener.document.getElementById("host11").innerText = host1;
	top.opener.document.getElementById("host12").innerText = 'OSType : ' + bean[2] + '  User : ' + bean[3];
	top.opener.document.getElementById("host21").innerText = host2;
	top.opener.document.getElementById("host22").innerText = 'OSType : ' + bean[7] + '  User : ' + bean[8];
	
	for(var key in list) {
		top.opener.document.getElementById(list[key]).value = bean[key];
	}
	top.close();
}
</script>
</head>
<body style="background:#fff;">

<form id="frm1" name="frm1" method="post" onsubmit="return false;">
	<input type="hidden" name="popup" 			value="popup"/>
	<div class="board_area">
		<div class="lst_area">
			<!-- article -->
			<div class="tit_area">
				<span class="article">등록현황 : <%=accountList.size()%></span>
			</div>
			<!-- //article -->
			
			<!-- list -->
	
			<div class="lst_contents">
				<table class="board_lst skyblue">
				<thead>
				<tr>
					<th rowspan="2">Account Name</th>
					<th colspan="3">Host 1</th>
					<th colspan="3">Host 2</th>
				</tr>
				<tr>
					<th>Host Name</th>
					<th>User</th>
					<th>Directory</th>
					<th>Host Name</th>
					<th>User</th>
					<th>Directory</th>
				</tr>
				</thead>	
				<tbody class="trOver">
				
				<%
					if(account == null) {
						for (int i = 0; i < accountList.size(); i++) {
							Account bean = (Account) accountList.get(i);
// 		 					out.println("<tr onClick='selectAccount(i)';>");
				%>
							<tr id="account<%=i%>" onClick="selectAccount('<%=i %>');" style='padding:0px;margin:0px;cursor:pointer;' >
				<%
								out.println("<td>");
								out.println(CommonUtil.isNull(bean.getAccountName()));
								out.println("</td>");
								
								if (!CommonUtil.isNull(bean.getHost1()).equals("")) {

									out.println("<td>");
									out.println(CommonUtil.isNull(bean.getHost1().getHostName()));
									out.println("</td>");

									out.println("<td style='display:none;'>");
									out.println(CommonUtil.isNull(bean.getHost1().getOsType()));
									out.println("</td>");

									out.println("<td>");
									out.println(CommonUtil.isNull(bean.getHost1().getUser()));
									out.println("</td>");

									out.println("<td>");
									out.println(CommonUtil.isNull(bean.getHost1().getDirectory()));
									out.println("</td>");

									out.println("<td style='display:none;'>");
									out.println(CommonUtil.isNull(bean.getHost1().getConntype()));
									out.println("</td>");

								} else {
								out.println("<td>");
								out.println("</td>");

								out.println("<td>");
								out.println("</td>");

								out.println("<td style='display:none;'>");
								out.println("</td>");

								out.println("<td>");
								out.println("</td>");

								out.println("<td>");
								out.println("</td>");

								out.println("<td style='display:none;'>");
								out.println("</td>");
								}

								if (!CommonUtil.isNull(bean.getHost2()).equals("")) {
									out.println("<td>");
									out.println(CommonUtil.isNull(bean.getHost2().getHostName()));
									out.println("</td>");

									out.println("<td style='display:none;'>");
									out.println(CommonUtil.isNull(bean.getHost2().getOsType()));
									out.println("</td>");

									out.println("<td>");
									out.println(CommonUtil.isNull(bean.getHost2().getUser()));
									out.println("</td>");

									out.println("<td>");
									out.println(CommonUtil.isNull(bean.getHost2().getDirectory()));
									out.println("</td>");

									out.println("<td style='display:none;'>");
									out.println(CommonUtil.isNull(bean.getHost2().getConntype()));
									out.println("</td>");
								} else {
									out.println("<td>");
									out.println("</td>");

									out.println("<td style='display:none;'>");
									out.println("</td>");

									out.println("<td>");
									out.println("</td>");

									out.println("<td>");
									out.println("</td>");

									out.println("<td style='display:none;'>");
									out.println("</td>");
								}

								out.println("</tr>");
							}
						} else {
							out.println("<tr>");

							out.println("<td>");
							out.println(CommonUtil.isNull(account.getAccountName()));
							out.println("</td>");

							out.println("<td>");
							out.println(CommonUtil.isNull(account.getHost1().getHostName()));
							out.println("</td>");

							out.println("<td>");
							out.println(CommonUtil.isNull(account.getHost1().getUser()));
							out.println("</td>");

							out.println("<td>");
							out.println(CommonUtil.isNull(account.getHost1().getDirectory()));
							out.println("</td>");

							out.println("<td>");
							out.println(CommonUtil.isNull(account.getHost2().getHostName()));
							out.println("</td>");

							out.println("<td>");
							out.println(CommonUtil.isNull(account.getHost2().getUser()));
							out.println("</td>");

							out.println("<td>");
							out.println(CommonUtil.isNull(account.getHost2().getDirectory()));
							out.println("</td>");

							out.println("</tr>");
						}
				%>
				
				</tbody>
				</table>
			</div>
			<!-- //list -->
			
			<%@include file="/jsp/common/inc/paging.jsp"%>
			
		</div>
	</div>

</form>

</body>
</html>

<%
	}
%>