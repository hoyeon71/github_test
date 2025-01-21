<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script type="text/javascript">
<!--
function viewProgBar(b){
	if(b){
		$.blockUI({
			message:$('#divProgBar').html()
			,css: { 
				width: '300px'
				,height:'40px'
			//	,top: '10px', left: '', right: '10px'
			} 
			,centerX:true
			,centerY:true
		});
		
	}else{
		$.unblockUI();
	}
}

//-->
</script>

<div id="divProgBar" style="padding-top:5px;text-align:center;display:none;">
	<div>데이터 처리중입니다. 잠시만 기다려주세요...</div>
	<div>
		<img src="<%=request.getContextPath() %>/imgs/common/prog_bar.gif" />
	</div>
</div>

