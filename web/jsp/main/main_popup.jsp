<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@include file="/jsp/common/inc/header.jsp"%>
<%@include file="/jsp/common/inc/progBar.jsp"%>

<%
	Map<String, Object> paramMap = CommonUtil.collectParameters(request);

	String sc 			= CommonUtil.isNull(paramMap.get("sc"));

	String type 				= CommonUtil.isNull(paramMap.get("type"));
	String idx 					= CommonUtil.isNull(paramMap.get("idx"));
	String num 					= CommonUtil.isNull(paramMap.get("num"));
	String gubun 				= CommonUtil.isNull(paramMap.get("gubun"));
	String arg 					= CommonUtil.isNull(paramMap.get("arg"));
	String s_dept_cd 			= CommonUtil.isNull(paramMap.get("s_dept_cd"));
	
	String order_id 			= CommonUtil.isNull(paramMap.get("order_id"));
	String data_center_code 	= CommonUtil.isNull(paramMap.get("data_center_code"));
	String data_center 			= CommonUtil.isNull(paramMap.get("data_center"));
	String active_net_name 		= CommonUtil.isNull(paramMap.get("active_net_name"));
	
	String jobgroup_id			= CommonUtil.isNull(paramMap.get("jobgroup_id"));
	
	String relation_cd			= CommonUtil.isNull(paramMap.get("relation_cd"));
	String sr_code				= CommonUtil.isNull(paramMap.get("sr_code"));
	String s_doc_gb				= CommonUtil.isNull(paramMap.get("s_doc_gb"));
	
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Frameset//EN" "http://www.w3.org/TR/html4/frameset.dtd">
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>EzJOBs 통합배치모니터링 시스템</title>
<link rel="stylesheet" href="<%=sContextPath %>/css/css.css" type="text/css">
<script src="<%=sContextPath %>/js/jquery-1.9.0.min.js"></script>
<script type="text/javascript">
   viewProgBar(true);
   $(document).ready(function(){
      $("iframe[name=list]").load( function(){
         viewProgBar(false);
       });
   });
</script>
</head>

<body>

<div class="content" style="overflow: hidden">

	<%
		if ( sc.equals("jobAvgInfoPopupList") ) { 
	%>
			<iframe name="search" 	scrolling="no" frameborder="0" border="0" width="100%" height="85px" src="<%=sContextPath%>/common.ez?c=ez005_6&search_page=search_jobAvgInfoPopupList&order_id=<%=order_id%>&data_center_code=<%=data_center_code%>&data_center=<%=data_center%>&active_net_name=<%=active_net_name%>"></iframe>
	<%
		} else if ( sc.equals("jobGroupDefJobPopupList") ) { 
	%>
			<iframe name="search" 	scrolling="no" frameborder="0" border="0" width="100%" height="120px" src="<%=sContextPath%>/common.ez?c=ez005_1&search_page=search_jobGroupDefJobPopupList&jobgroup_id=<%=jobgroup_id%>"></iframe>
	<%	
		} else if ( sc.equals("docList") ) {
	%>
			<iframe name="search" 	scrolling="no" frameborder="0" border="0" width="100%" height="85px" src="<%=sContextPath %>/mPopup.ez?c=findDocList&s_doc_gb=<%=s_doc_gb%>"></iframe>
	<%
		}
	%>

<!-- 	<iframe name="list" 	scrolling="no" frameborder="0" border="0" width="100%" height="100%" style="min-height:550px;*height:550px;"></iframe> -->
	<iframe name="list" 	scrolling="yes" frameborder="0" border="0" width="100%" style="min-height:460px;*height:650px;"></iframe>
		
	<iframe name="prcFrame" src="#" scrolling="no"  width="0" height="0" noresize />
	
</div>

</body>
</html>