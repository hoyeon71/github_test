<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*, java.lang.*, java.text.*" %>
<%@ page import="com.ghayoun.ezjobs.common.util.*" %>

<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%
  response.setHeader("Cache-Control","no-store"); //HTTP 1.1
  response.setHeader("Pragma","no-cache"); //HTTP 1.0
  response.setDateHeader ("Expires", 0);
%>
<%
	Map<String, Object> paramMap = CommonUtil.collectParameters(request);
	String pop_if = CommonUtil.isNull(paramMap.get("pop_if"));
	
	//js version 추가하여 캐시 새로고침
	String jsVersion = CommonUtil.getMessage("js_version");
%>

<!DOCTYPE html>
<html>
<head><title><%=CommonUtil.getMessage("HOME.TITLE") %></title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=Edge">

<link href="<%=request.getContextPath() %>/css/common.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath() %>/css/custom-theme/jquery-ui.custom.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath() %>/css/custom-theme/jquery-ui.works.css" rel="stylesheet" type="text/css" />

<link href="<%=request.getContextPath() %>/css/layout-default.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath() %>/css/ftree/ui.fancytree.css" rel="stylesheet" type="text/css" />

<link href="<%=request.getContextPath() %>/js/SlickGrid-2.1.0/slick.grid.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath() %>/css/slick-default-theme.css" rel="stylesheet" type="text/css" />

<link href="<%=request.getContextPath() %>/js/poshytip-1.2/tip.css" rel="stylesheet" type="text/css" />

<style type="text/css">
<!--
	
//-->
</style>

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
<script type="text/javascript" src="<%=request.getContextPath() %>/js/SlickGrid-2.1.0/slick.dataview.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/SlickGrid-2.1.0/slick.grid.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/SlickGrid-2.1.0/plugins/slick.autocolumnsize.js" ></script>

<script type="text/javascript" src="<%=request.getContextPath() %>/js/poshytip-1.2/jquery.poshytip.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/circles/circles.js" ></script>

<script type="text/javascript" src="<%=request.getContextPath() %>/js/base64.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/d3/d3.min.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/d3/graphlib-dot.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/d3/dagre-d3.js" ></script>

<script type="text/javascript" src="<%=request.getContextPath() %>/js/works_common.js?v=<%=jsVersion %>" ></script>

<script type="text/javascript" src="<%=request.getContextPath()%>/js/jsbn/jsbn.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jsbn/rsa.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jsbn/prng4.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jsbn/rng.js"></script>


<script type="text/javascript">
<!--

//-->
</script>
</head>

<body leftmargin="0" topmargin="0" style='visibility:hidden;' >

<div id='ly_body'   style='width:100%;height:100%;display: inline-block'>
	<tiles:insertAttribute name="body" />
</div>

<%@include file="/jsp/common/inc/progBar.jsp"  %>
<iframe id="prcFrame<%=pop_if %>" name="prcFrame<%=pop_if %>" src="" style='width:0px;height:0px;border:none;' ></iframe>	

<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.keyfilter-1.7.min.js" ></script>
<script type="text/javascript" >
<!--
	var prcFrameId = "prcFrame<%=pop_if %>"; 
	$(window).load(function(){
		$('body').css({'visibility':'visible'});
	});
	
	$(document).ready(function(){
		$( document ).click(function(e){
			parent.dlFrontView('dl_p<%=pop_if.substring(1) %>');
		});
		
		initIme();
		
		$(':input').live('focus',function(){
			$(this).attr('autocomplete', 'off');
		});
		
		var reSubTableHeight = function(){
			$('.sub_table').each(function(){
				var sub = $(this);
				sub.height(0);
				setTimeout(function(){
					sub.height(sub.parent().height());
				},1);
				
			});
		};
		if($('.sub_table').length > 0 ){
			$(window).unbind('resizestop',reSubTableHeight).bind('resizestop',reSubTableHeight);
			reSubTableHeight.call();
		}
		
		if($('#f_s').length==1) $('#f_s').append("<input type='hidden' id='pop_if' name='pop_if' value='<%=pop_if %>' />");
	});
	
	
//-->
</script>
</body>
</html>



