<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.ghayoun.ezjobs.m.domain.*" %>

<%@include file="/jsp/common/inc/header.jsp"%>
<%@include file="/jsp/common/inc/sessionChkPopup.jsp"%>

<%
	Map<String, Object> paramMap = CommonUtil.collectParameters(request);
	
	List timeInfoList		= (List)request.getAttribute("timeInfoList");
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
	.hover { background-color:#f9f0e1; }
</style>
<script type="text/javascript" >
$(document).ready(function(){
	$('.trOver tr:lt(1000)').hover(
		function() { $(this).addClass('hover');},
		function() { $(this).removeClass('hover');}
	);

	 $(window).resize(function() {
         $('div.lst_header > table > thead > tr:first').children().each(function(i,v){
                    $(this).width($('div.lst_contents > table > tbody > tr > td:eq('+ i +')').width());
         }); 
}).resize();
});
</script>

</head>
<body style="background:#fff;">

<form id="frm1" name="frm1" method="post" onsubmit="return false;">
	
	<div class="view_area">
		<!-- title -->
		<div class="tit_area">
			<h1><span class="icon"><img src="<%=sContextPath %>/images/icon_sgnb2.png" alt="" /></span>시작 시간 정보</h1>
			<div class="btn">
				<a href="JavaScript:self.close();" class="btn_modify">닫기</a>
			</div>
		</div>
	</div>
	
	<div class="board_area">
		<div class="lst_area">
			
			<!-- list -->
			<div class="lst_header" style="table-layout:fixed">
				<table class="board_lst orange">
				
				<thead>
				<tr>
					<th>순번</th>
					<th>ODATE</th>
					<th>STARTRUN</th>
					<th>ENDRUN</th>
					<th>수행시간</th>
					<th></th>
				</tr>
				</thead>
				</table>
			</div>
			<div class="lst_contents" style="height:430px">
				<table class="board_lst orange">
				<colgroup>
					<col width="40" />
					<col width="80" />
					<col width="150" />
					<col width="150" />
					<col width="" />					
				</colgroup>
				<tbody class="trOver">
				
				<%
					for( int i=0; null!=timeInfoList && i<timeInfoList.size(); i++ ){
						TimeInfoBean bean = (TimeInfoBean)timeInfoList.get(i);
						
						String strOdate			= CommonUtil.isNull(bean.getOdate());
						String strStartTime		= CommonUtil.isNull(bean.getStart_time());
						String strEndTime 		= CommonUtil.isNull(bean.getEnd_time());
						
						String strOdateMent		= strOdate.substring(0, 2) + "/" + strOdate.substring(2, 4) + "/" + strOdate.substring(4, 6);
						String strStartTimeMent	= CommonUtil.getDateFormat(1, strStartTime);
						String strEndTimeMent	= CommonUtil.getDateFormat(1, strEndTime);
						
						String strDiffTime		= CommonUtil.getDiffTime(CommonUtil.getDateFormat(1, strStartTime), CommonUtil.getDateFormat(1, strEndTime));
				%>
					<tr>
						<td><%=(i+1)%></td>
						<td><%=strOdateMent%></td>
						<td><%=strStartTimeMent%></td>
						<td><%=strEndTimeMent%></td>
						<td><%=strDiffTime%></td>
					</tr>
				<%
					}
				%>
				
				</tbody>
				</table>
			</div>
			<!-- //list -->
			
		</div>
	</div>

</form>

</body>
</html>