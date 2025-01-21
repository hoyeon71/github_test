<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*, java.lang.*, java.text.*" %>
<%@ page import="com.ghayoun.ezjobs.common.util.*" %>

<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%
  response.setHeader("Cache-Control","no-store"); //HTTP 1.1
  response.setHeader("Pragma","no-cache"); //HTTP 1.0
  response.setDateHeader ("Expires", 0);

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
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.fileDownload.js " ></script>
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
<script type="text/javascript" src="<%=request.getContextPath() %>/js/SlickGrid-2.1.0/slick.groupitemmetadataprovider.js" ></script>

<script type="text/javascript" src="<%=request.getContextPath() %>/js/poshytip-1.2/jquery.poshytip.js" ></script>

<script type="text/javascript" src="<%=request.getContextPath() %>/js/works_common.js?v=<%=jsVersion %>" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/chart/echarts-all.js"></script>
<script type="text/javascript">
<!--

//-->
</script>
</head>

<body id='body_M' leftmargin="0" topmargin="0" style='visibility:hidden;overflow:hidden;' >
	<table style='height:100%;width:100%;border:none;'>
			<tr style='height:50px;'>
				<td style="vertical-align:top;">
					<tiles:insertAttribute name="top" />
				</td>
			</tr>
			<tr>
				<td id='td_body' style="vertical-align:top;">
					<div id='ly_left' class="ui-layout-west" style='overflow:hidden;margin:0px;padding:0px;'>
						<tiles:insertAttribute name="left" />
					</div>
					<div id='ly_body' class="ui-layout-center" style='overflow:hidden;position:relative;'>
						<tiles:insertAttribute name="body" />
					</div>
				</td>
			</tr>
			<tr style='height:10px;'>
				<td>
					<tiles:insertAttribute name="bottom" />
				</td>
			</tr>
	</table>
</body>
<%@include file="/jsp/common/inc/progBar.jsp"  %>
	<iframe id="prcFrameM" name="prcFrameM" src="" style='width:0px;height:0px;border:none;' ></iframe>

<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.keyfilter-1.7.min.js" ></script>
<script type="text/javascript" >
<!--
	var prcFrameId= "prcFrameM";
	$(window).load(function(){
		$('body').css({'visibility':'visible'});
	});

	$(document).ready(function(){

		$(':input').live('focus',function(){
			$(this).attr('autocomplete', 'off');
		});

		var myLayout = $('#td_body').layout({
			name:"td_body"
			/*,tips: {
					Open:				""
				,	Close:				""
				,	Resize:				""
			}*/

			//	reference only - these options are NOT required because 'true' is the default
				,closable:					true	// pane can open & close
				,fxName:					"slideOffscreen"
				,fxSpeed:					300
			,	resizable:					true	// when open, pane can be resized
			,	slidable:					true	// when closed, pane can 'slide' open over other panes - closes on mouse-out
			,	livePaneResizing:			true

			//	some pane-size settings
			,	west__size:					150
			,	west__minSize:				150
			,	center__minWidth:			120

			//	enable state management
			,	stateManagement__enabled:	true // automatic cookie load & save enabled by default

			,	showDebugMessages:			false // log and/or display messages from debugging & testing code

			,onopen_end: function () {
				$(window).trigger('resize');
			}
			,onclose_end: function () {
				$(window).trigger('resize');
			}
			,ondrag_end: function () {
				$(window).trigger('resize');
			}
		});

		initIme();

		var reSubTableHeight = function(){
			setTimeout(function(){
				resizeTabContent();
			},10);
		};

		$(window).unbind('resizestop',reSubTableHeight).bind('resizestop',reSubTableHeight);

	});

window.onload = function() {
	// 브라우저 창의 높이를 가져옵니다.
	var windowHeight = window.innerHeight-65;
	var windowWidth = window.innerWidth-155;

	var leftTree_M = document.getElementById('leftTree_M');
	var ly_left = document.getElementById('ly_left');
	var ly_body = document.getElementById('ly_body');
	var tabs = document.getElementById('tabs');
	var tabs_M = document.getElementById('tabs-M');
	var td_body = document.getElementById('td_body');
	//사이드바높이조정
	var nav_links = document.getElementById('nav-links');

	// leftTree_M 요소의 높이를 브라우저 창의 높이로 설정합니다.
	leftTree_M.style.height = windowHeight-30 + 'px';
	ly_left.style.height = windowHeight-20 + 'px';
	td_body.style.height = windowHeight-15 + 'px';
	ly_body.style.height = windowHeight-15 + 'px';
	ly_body.style.width = windowWidth + 'px';
	ly_body.style.overflow = "hidden";
	tabs_M.style.height = windowHeight-12 + 'px'; /////1111111
	tabs.style.height = windowHeight-30 + 'px';  //완료
	nav_links.style.height = windowHeight-22 + 'px';
	nav_links.style.overflow = "auto";
	resizeTabContent();
	// 브라우저 창의 크기가 변경될 때마다 leftTree_M 요소의 높이를 업데이트
  window.onresize = function() {
	windowHeight = window.innerHeight-60;
	windowWidth = window.innerWidth-155;

  	leftTree_M.style.height = windowHeight-30 + 'px';
  	ly_left.style.height = windowHeight-20 + 'px';
  	td_body.style.height = windowHeight-15 + 'px';
  	ly_body.style.height = windowHeight-15 + 'px';
  	ly_body.style.width = windowWidth + 'px';
  	tabs_M.style.height = windowHeight-12 + 'px'; /////1111111
  	tabs.style.height = windowHeight-30 + 'px';  //완료
  	nav_links.style.height = windowHeight-22 + 'px';
	resizeTabContent();
	}
}
//-->
</script>
</body>
</html>
