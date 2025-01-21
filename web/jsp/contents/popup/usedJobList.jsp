<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.ghayoun.ezjobs.m.domain.*" %>

<%@include file="/jsp/common/inc/header.jsp"%>
<%@include file="/jsp/common/inc/sessionChkPopup.jsp"%>

<%
	Map<String, Object> paramMap = CommonUtil.collectParameters(request);

	List usedJobList		= (List)request.getAttribute("usedJobList");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head><title><%=CommonUtil.getMessage("POPUP.USED_JOB.TITLE") %></title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link href="<%=sContextPath %>/css/common.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="<%=sContextPath %>/js/common.js" ></script>
<script type="text/javascript" >
	
	

</script>

</head>

<body style='padding-left:10;padding-right:10;padding-top:20;'>

<form id="frm1" name="frm1" method="post" onsubmit="return false;">



<table width='100%' border='0' >
	<tr >
		<td width='80'>
			<img src="<%=sContextPath %>/imgs/popup/pop_title_icon.gif" />
		</td>
		<td style='font-size:16px;font-weight:bold;'>
			<%=CommonUtil.getMessage("POPUP.USED_JOB.TITLE") %>
		</td>
	</tr>
</table>

	
<%	
	
	out.println("<table width='100%' border='0' cellpadding='1' cellspacing='1' bgcolor='#dcdcdc' >");
	out.println("<tr class='tbl_list_title' >");
	
	out.println("<td>작업명</td>");
	out.println("<td>작업설명</td>");
	out.println("<td>수행서버</td>");
	out.println("<td>시작일시</td>");
	
	out.println("</tr>");
	
	for( int i=0; null!=usedJobList && i<usedJobList.size(); i++ ){
		CommonBean bean = (CommonBean)usedJobList.get(i);
		
		out.println("<tr "+( ((i%2)==0)? " class='tbl_list' " : "class='tbl_list_bg'" )+" >");
		
		out.println("<td>"+CommonUtil.isNull(bean.getJobname(),"&nbsp;")+"</td>");
		out.println("<td>"+CommonUtil.isNull(bean.getDescription(),"&nbsp;")+"</td>");
		out.println("<td>"+CommonUtil.isNull(bean.getNodeid(),"&nbsp;")+"</td>");
		out.println("<td>"+CommonUtil.isNull(bean.getStart_time(),"&nbsp;")+"</td>");
		out.println("</tr>");
	}
	
	if( !(null!=usedJobList && 0<usedJobList
			.size()) ) out.println("<tr  bgcolor='#ffffff' ><td colspan='50' height='30' align='center'>"+CommonUtil.getMessage("DEBUG.06")+"</td></tr>");
	out.println("</table>");
%>

</form>
</body>
</html>
