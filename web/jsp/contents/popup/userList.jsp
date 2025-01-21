<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.ghayoun.ezjobs.t.domain.*" %>

<%@include file="/jsp/common/inc/header.jsp"%>
<%@include file="/jsp/common/inc/sessionChkPopup.jsp"%>

<%
	Map<String, Object> paramMap = CommonUtil.collectParameters(request);
	
	List userList		= (List)request.getAttribute("userList");
	
	String currentPage 	= CommonUtil.isNull(paramMap.get("currentPage"), "1");
	
	String type 			= CommonUtil.isNull(paramMap.get("type"));
	String idx 				= CommonUtil.isNull(paramMap.get("idx"));
	String num 				= CommonUtil.isNull(paramMap.get("num"));
	String gubun			= CommonUtil.isNull(paramMap.get("gubun"));
	String arg				= CommonUtil.isNull(paramMap.get("arg"));
	String s_dept_cd		= CommonUtil.isNull(paramMap.get("s_dept_cd"));
	
	String strSearchText 	= CommonUtil.isNull(paramMap.get("search_text"));
	String strSearchGubun 	= CommonUtil.isNull(paramMap.get("search_gubun"));
	
	int totalCount 			= Integer.parseInt(CommonUtil.isNull(request.getAttribute("totalCount"),"0"));
	int rowSize 			= Integer.parseInt(CommonUtil.isNull(request.getAttribute("rowSize")));
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Frameset//EN" "http://www.w3.org/TR/html4/frameset.dtd">

<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>EzJOBs 통합배치모니터링 시스템</title>
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
<!--
	function goPage(currentPage) {

		var frm = document.frm1;
		
		frm.currentPage.value = currentPage;
		frm.action = "<%=sContextPath %>/tWorks.ez?c=ez002";
		frm.target = "list";
		frm.submit();
	}

	function fn_changeRowCnt() {

		var frm = document.frm1;
	
		// 검색 버튼을 클릭 시에도 RowCnt를 따라가기 위해.
		top.search.document.frm1.rowCnt.value = frm.rowCnt.value;
	
		frm.action = "<%=sContextPath %>/tWorks.ez?c=ez002";
		frm.target = "list";
		frm.submit();
	}

	function setType01(idx, num, user_cd, user_nm) {

		top.opener.document.getElementById('user_cd_'+num+'_'+idx).value = user_cd;

		top.opener.document.getElementById('user_nm_'+num+'_'+idx).value = user_nm;

		if ( top.opener.document.getElementById('sms_'+num+'_'+idx) ) {
			top.opener.document.getElementById('sms_'+num+'_'+idx).checked = true;
		}
		
		top.close();
	}

	function setType02(idx, user_cd, user_nm) {
		
		top.opener.document.getElementById('user_cd_'+idx).value = user_cd;
		top.opener.document.getElementById('user_nm_'+idx).value = user_nm;
		
		top.close();
	}

	function setType03(idx, user_cd, user_nm) {

		var gubun = "<%=gubun%>";

		top.opener.document.getElementById('user_cd_'+gubun+idx).value = user_cd;
		top.opener.document.getElementById('user_nm_'+gubun+idx).value = user_nm;
		
		top.close();
	}

	function setType04(user_cd, user_nm) {

		var gubun = "<%=gubun%>";

		top.opener.document.getElementById(gubun+'_cd').value = user_cd;
		top.opener.document.getElementById(gubun+'_nm').value = user_nm;
		
		top.close();
	}

	function setType05(idx,num,user_id,user_nm){

		top.opener.document.getElementById('user_id_'+num+'_'+idx).value = user_id;
		top.opener.document.getElementById('user_nm_'+num+'_'+idx).value = user_nm;

		top.close();
	}
	function setType06(num,user_id,user_nm){

		top.opener.document.getElementById('user_cd_'+num).value = user_id;
		top.opener.document.getElementById('user_nm_'+num).value = user_nm;

		top.close();
	}
//-->
</script>

</head>
<body style="background:#fff;">

<form id="frm1" name="frm1" method="post" onsubmit="return false;">
	<input type="hidden" name="popup" 			value="popup"/>
	
	<input type="hidden" name="type" 			value="<%=type%>"/>
	<input type="hidden" name="idx" 			value="<%=idx%>"/>
	<input type="hidden" name="num" 			value="<%=num%>"/>
	<input type="hidden" name="gubun" 			value="<%=gubun%>"/>
	<input type="hidden" name="arg" 			value="<%=arg%>"/>
	<input type="hidden" name="s_dept_cd" 		value="<%=s_dept_cd%>"/>
	
	<div class="board_area">
		<div class="lst_area">
			<!-- article -->
			<div class="tit_area">
				<span class="article">등록현황 : <%=totalCount%></span>
			</div>
			<!-- //article -->
			
			<!-- list -->
	
			<div class="lst_contents">
				<table class="board_lst skyblue">
				<colgroup>
					<col width="40" />
					<col width="150" />
					<col width="100" />			
					<col width="100" />	
					<col width="150" />	
					<col width="" />				
				</colgroup>
					<thead>
				<tr>
					<th>순번</th>
					<th>부서</th>
					<th>직책</th>
					<th>아이디</th>
					<th>이름</th>				
					<th></th>
				</tr>
				</thead>	
				<tbody class="trOver">
				
				<%
					for( int i=0; null!=userList && i<userList.size(); i++ ){
						UserBean bean = (UserBean)userList.get(i);
						
						// 게시판 순번 계산.
						int row_num = i + ((Integer.parseInt(currentPage)-1) * rowSize) + 1;
						
						String strUserCd 		= CommonUtil.isNull(bean.getUser_cd());
						String strUserId 		= CommonUtil.isNull(bean.getUser_id());
						String strUserNm 		= CommonUtil.isNull(bean.getUser_nm());
						String strDeptNm 		= CommonUtil.isNull(bean.getDept_nm());
						String strDutyNm 		= CommonUtil.isNull(bean.getDuty_nm());						
				
						if ( type.equals("01") ) {
				%>
							<tr onClick="setType01('<%=idx%>', '<%=num%>', '<%=strUserCd%>', '<%=strUserNm%>');" style="cursor:pointer;">
				<%
		 				} else if ( type.equals("02") ) { 
				%>
							<tr onClick="setType02('<%=idx%>', '<%=strUserCd%>', '<%=strUserNm%>');" style="cursor:pointer;">
				<%
		 				} else if ( type.equals("06") ) { 
				%>
							<tr onClick="setType06('<%=num%>', '<%=strUserCd%>', '<%=strUserNm%>');" style="cursor:pointer;">
				<%
						} else if ( type.equals("03") ) { 
				%>
							<tr onClick="setType03('<%=idx%>', '<%=strUserCd%>', '<%=strUserNm%>');" style="cursor:pointer;">
				<%
						} else if ( type.equals("04") ) { 
				%>
							<tr onClick="setType04('<%=strUserCd%>', '<%=strUserNm%>');" style="cursor:pointer;">
				<%
						} else if ( type.equals("05") ) {
				%>
							<tr onClick="setType05('<%=idx%>', '<%=num%>', '<%=strUserCd%>', '<%=strUserNm%>');" style="cursor:pointer;">
				<%
						}
				%>			
						<td><%=row_num%></td>
						<td><%=strDeptNm%></td>
						<td><%=strDutyNm%></td>
						<td><%=strUserId%></td>
						<td><%=strUserNm%></td>
					</tr>
				<%
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