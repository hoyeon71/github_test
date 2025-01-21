<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

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
<script type="text/javascript" src="<%=request.getContextPath() %>/js/poshytip-1.2/jquery.poshytip.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/works_common.js" ></script>


<script type="text/javascript">

$(document).ready(function() {
	
	var s_time_h = "15";
	var s_time_m = "00";
	
	var s_time = s_time_h + s_time_m;
	
	if ( s_time > "0830" && s_time < "1540" ) {
		alert("DBA 결재 설정");
	} else {
		alert("일반 결재 설정");
	}
	
	/*
	if ( parseInt(s_time_h) < 15 && parseInt(s_time_h) > 8 ) {
		
		alert("DBA 결재 설정");
		
	} else if ( parseInt(s_time_h) == 8 && parseInt(s_time_m) > 30 ) {
		
		alert("DBA 결재 설정");
		
	} else if ( parseInt(s_time_h) == 15 && parseInt(s_time_m) < 40 ) {
		
		alert("DBA 결재 설정");
		
	} else {
		
		alert("일반 결재 설정");
	}
	*/
	
	/*
	if ( parseInt(s_time_h) < 16 && parseInt(s_time_h) > 6 ) {
		
		alert("DBA 결재 설정");
		
	} else if ( parseInt(s_time_h) == 7 && parseInt(s_time_m) > 30 ) {
		
		alert("DBA 결재 설정");
		
	} else if ( parseInt(s_time_h) == 15 && parseInt(s_time_m) < 40 ) {
		
		alert("DBA 결재 설정");
		
	} else {
		
		alert("일반 결재 설정");
	}
	*/
	
});

</script>