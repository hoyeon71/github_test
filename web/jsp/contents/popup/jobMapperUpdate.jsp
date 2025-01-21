<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/jsp/common/inc/header.jsp"%>
<%
	//js version 추가하여 캐시 새로고침
	String jsVersion = CommonUtil.getMessage("js_version");
%>
<!DOCTYPE html>
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
	<script type="text/javascript" src="<%=request.getContextPath() %>/js/SlickGrid-2.1.0/slick.editors.js" ></script>
	<script type="text/javascript" src="<%=request.getContextPath() %>/js/poshytip-1.2/jquery.poshytip.js" ></script>
	<script type="text/javascript" src="<%=request.getContextPath() %>/js/works_common.js?v=<%=jsVersion %>" ></script>
</head>

<%
	List smsDefaultList			= (List)request.getAttribute("smsDefaultList");
	List mailDefaultList		= (List)request.getAttribute("mailDefaultList");
	
	// SMS, MAIL 기본값 및 체크 유무 추가(2024.02.22)
	String strSms					= "";
	String strMail					= "";
	String smsDefault				= "";
	String mailDefault				= "";
	
	if(smsDefaultList != null) {
		for ( int i = 0; i < smsDefaultList.size(); i++ ) {
			CommonBean commonBean = (CommonBean) smsDefaultList.get(i);
			
			strSms		= commonBean.getScode_eng_nm();
			smsDefault  = commonBean.getScode_nm();
		}
	}
	
	if(mailDefaultList != null) {
		for ( int i = 0; i < mailDefaultList.size(); i++ ) {
			CommonBean commonBean = (CommonBean) mailDefaultList.get(i);
				
			strMail		= commonBean.getScode_eng_nm();
			mailDefault = commonBean.getScode_nm();
		}
	}
%>

<script type="text/javascript" >
	function clearUser(gubun) {
		document.getElementById(gubun+'_cd').value = '';
		document.getElementById(gubun+'_nm').value = '';
	}

	function updateUser(){
		var frm = document.frm1;

		var mapper_cd_comma			= "";
		var udt_user_comma			= "";
		var del_user_comma			= "";

		var mapper_cd 				= frm.mapper_cd.value;
		var mapper_cd_2 			= frm.mapper_cd_2.value;
		var mapper_cd_3 			= frm.mapper_cd_3.value;
		var mapper_cd_4 			= frm.mapper_cd_4.value;
		var mapper_cd_5 			= frm.mapper_cd_5.value;
		var mapper_cd_6 			= frm.mapper_cd_6.value;
		var mapper_cd_7 			= frm.mapper_cd_7.value;
		var mapper_cd_8 			= frm.mapper_cd_8.value;
		var mapper_cd_9 			= frm.mapper_cd_9.value;
		var mapper_cd_10 			= frm.mapper_cd_10.value;
		var mapper_cd_11			= frm.mapper_cd_11.value;
		var mapper_cd_12 			= frm.mapper_cd_12.value;

		var udt_user_1 				= document.getElementById('mapper_gubun').checked;
		var udt_user_2 				= document.getElementById('mapper_gubun_2').checked;
		var udt_user_3 				= document.getElementById('mapper_gubun_3').checked;
		var udt_user_4 				= document.getElementById('mapper_gubun_4').checked;
		var udt_user_5 				= document.getElementById('mapper_gubun_5').checked;
		var udt_user_6 				= document.getElementById('mapper_gubun_6').checked;
		var udt_user_7 				= document.getElementById('mapper_gubun_7').checked;
		var udt_user_8 				= document.getElementById('mapper_gubun_8').checked;
		var udt_user_9 				= document.getElementById('mapper_gubun_9').checked;
		var udt_user_10				= document.getElementById('mapper_gubun_10').checked;
		var udt_user_11 			= document.getElementById('mapper_gubun_11').checked;
		var udt_user_12				= document.getElementById('mapper_gubun_12').checked;

		//var del_user				= document.getElementById('del_user_1').checked;
		var del_user_2 				= document.getElementById('del_user_2').checked;
		var del_user_3 				= document.getElementById('del_user_3').checked;
		var del_user_4 				= document.getElementById('del_user_4').checked;
		var del_user_5 				= document.getElementById('del_user_5').checked;
		var del_user_6 				= document.getElementById('del_user_6').checked;
		var del_user_7 				= document.getElementById('del_user_7').checked;
		var del_user_8 				= document.getElementById('del_user_8').checked;
		var del_user_9 				= document.getElementById('del_user_9').checked;
		var del_user_10 			= document.getElementById('del_user_10').checked;
		var del_user_11				= document.getElementById('del_user_11').checked;
		var del_user_12 			= document.getElementById('del_user_12').checked;

		if(mapper_cd == ''){
			mapper_cd_comma += "N";
		}else{
			mapper_cd_comma += mapper_cd;
		}
		
		if(mapper_cd_2 == ''){
			mapper_cd_comma += "," + "N";
		}else{
			mapper_cd_comma += "," + mapper_cd_2;
		}
		
		if(mapper_cd_3 == ''){
			mapper_cd_comma += "," + "N";
		}else{
			mapper_cd_comma += "," + mapper_cd_3;
		}
		
		if(mapper_cd_4 == ''){
			mapper_cd_comma += "," + "N";
		}else{
			mapper_cd_comma += "," + mapper_cd_4;
		}
		
		if(mapper_cd_5 == ''){
			mapper_cd_comma += "," + "N";
		}else{
			mapper_cd_comma += "," + mapper_cd_5;
		}
		
		if(mapper_cd_6 == ''){
			mapper_cd_comma += "," + "N";
		}else{
			mapper_cd_comma += "," + mapper_cd_6;
		}
		
		if(mapper_cd_7 == ''){
			mapper_cd_comma += "," + "N";
		}else{
			mapper_cd_comma += "," + mapper_cd_7;
		}
		
		if(mapper_cd_8 == ''){
			mapper_cd_comma += "," + "N";
		}else{
			mapper_cd_comma += "," + mapper_cd_8;
		}

		if(mapper_cd_9 == ''){
			mapper_cd_comma += "," + "N";
		}else{
			mapper_cd_comma += "," + mapper_cd_9;
		}

		if(mapper_cd_10 == ''){
			mapper_cd_comma += "," + "N";
		}else{
			mapper_cd_comma += "," + mapper_cd_10;
		}

		if(mapper_cd_11 == ''){
			mapper_cd_comma += "," + "N";
		}else{
			mapper_cd_comma += "," + mapper_cd_11;
		}

		if(mapper_cd_12 == ''){
			mapper_cd_comma += "," + "N";
		}else{
			mapper_cd_comma += "," + mapper_cd_12;
		}

		udt_user_comma += (udt_user_1 == true ? 'Y' : 'N');
		udt_user_comma += "," + (udt_user_2 == true ? 'Y' : 'N');
		udt_user_comma += "," + (udt_user_3 == true ? 'Y' : 'N');
		udt_user_comma += "," + (udt_user_4 == true ? 'Y' : 'N');
		udt_user_comma += "," + (udt_user_5 == true ? 'Y' : 'N');
		udt_user_comma += "," + (udt_user_6 == true ? 'Y' : 'N');
		udt_user_comma += "," + (udt_user_7 == true ? 'Y' : 'N');
		udt_user_comma += "," + (udt_user_8 == true ? 'Y' : 'N');
		udt_user_comma += "," + (udt_user_9 == true ? 'Y' : 'N');
		udt_user_comma += "," + (udt_user_10 == true ? 'Y' : 'N');
		udt_user_comma += "," + (udt_user_11 == true ? 'Y' : 'N');
		udt_user_comma += "," + (udt_user_12 == true ? 'Y' : 'N');

		del_user_comma += (del_user == true ? 'Y' : 'N');
		del_user_comma += "," + (del_user_2 == true ? 'Y' : 'N');
		del_user_comma += "," + (del_user_3 == true ? 'Y' : 'N');
		del_user_comma += "," + (del_user_4 == true ? 'Y' : 'N');
		del_user_comma += "," + (del_user_5 == true ? 'Y' : 'N');
		del_user_comma += "," + (del_user_6 == true ? 'Y' : 'N');
		del_user_comma += "," + (del_user_7 == true ? 'Y' : 'N');
		del_user_comma += "," + (del_user_8 == true ? 'Y' : 'N');
		del_user_comma += "," + (del_user_9 == true ? 'Y' : 'N');
		del_user_comma += "," + (del_user_10 == true ? 'Y' : 'N');
		del_user_comma += "," + (del_user_11 == true ? 'Y' : 'N');
		del_user_comma += "," + (del_user_12 == true ? 'Y' : 'N');

		frm.mapper_cd.value = mapper_cd_comma;
		frm.udt_user.value = udt_user_comma;
		frm.del_user.value = del_user_comma;

		if( !confirm("해당 작업의 담당자를 일괄 변경 하시겠습니까?") ) return;

		frm.target = "if_defJobs";
		frm.action = "<%=sContextPath%>/tWorks.ez?c=ez012_popup_p";
		frm.submit();

		window.close();
	}

	function chkUdt(obj){

		var udt_user_1				= document.getElementById(obj).checked;
		var udt_user_2 				= document.getElementById(obj).checked;
		var udt_user_3 				= document.getElementById(obj).checked;
		var udt_user_4 				= document.getElementById(obj).checked;
		var udt_user_5 				= document.getElementById(obj).checked;
		var udt_user_6 				= document.getElementById(obj).checked;
		var udt_user_7 				= document.getElementById(obj).checked;
		var udt_user_8 				= document.getElementById(obj).checked;
		var udt_user_9 				= document.getElementById(obj).checked;
		var udt_user_10 			= document.getElementById(obj).checked;
		var udt_user_11 			= document.getElementById(obj).checked;
		var udt_user_12 			= document.getElementById(obj).checked;
		var smsDefault				= "<%=smsDefault%>";
		var mailDefault				= "<%=mailDefault%>";
		
		if(obj == 'mapper_gubun' && !udt_user_1){
			$("#mapper_nm").val("");
			$("#mapper_cd").val("");
			$("#mapper_nm").prop("disabled",true);
			$("#sms_1").attr('disabled', true);
			$("#mail_1").attr('disabled', true);
			$("#btn_del").attr("src", "/images/sta2_disabled.png");
		}else if(obj == 'mapper_gubun' && udt_user_1){
			$("#mapper_nm").val("");
			$("#mapper_cd").val("");
			$("#mapper_nm").prop("disabled",false);
			$("#sms_1").attr('disabled', false);
			$("#mail_1").attr('disabled', false);
			if(smsDefault == "Y"){
				$("#sms_1").attr('checked', true);
			}
			if(mailDefault == "Y"){
				$("#mail_1").attr('checked', true);
			}
			$("#del_user_1").attr('checked', false);
			$("#mapper_nm").addClass('readyOnly');
			$("#btn_del").attr("src", "/images/sta2.png");
		}

		if(obj == 'mapper_gubun_2' && !udt_user_2){
			$("#mapper_nm_2").val("");
			$("#mapper_cd_2").val("");
			$("#mapper_nm_2").prop("disabled",true);
			$("#sms_2").attr('disabled', true);
			$("#mail_2").attr('disabled', true);
			$("#btn_del_2").attr("src", "/images/sta2_disabled.png");
			$("#del_user_2").attr('disabled', true);
		}else if(obj == 'mapper_gubun_2' && udt_user_2){
			$("#mapper_nm_2").val("");
			$("#mapper_cd_2").val("");
			$("#mapper_nm_2").prop("disabled",false);
			$("#sms_2").attr('disabled', false);
			$("#mail_2").attr('disabled', false);
			$("#del_user_2").attr('disabled', false);
			if(smsDefault == "Y"){
				$("#sms_2").attr('checked', true);
			}
			if(mailDefault == "Y"){
				$("#mail_2").attr('checked', true);
			}
			$("#del_user_2").attr('checked', false);
			$("#mapper_nm_2").addClass('readyOnly');
			$("#btn_del_2").attr("src", "/images/sta2.png");
		}

		if(obj == 'mapper_gubun_3' && !udt_user_3){
			$("#mapper_nm_3").val("");
			$("#mapper_cd_3").val("");
			$("#mapper_nm_3").prop("disabled",true);
			$("#sms_3").attr('disabled', true);
			$("#mail_3").attr('disabled', true);
			$("#btn_del_3").attr("src", "/images/sta2_disabled.png");
			$("#del_user_3").attr('disabled', true);
		}else if(obj == 'mapper_gubun_3' && udt_user_3){
			$("#mapper_nm_3").val("");
			$("#mapper_cd_3").val("");
			$("#mapper_nm_3").prop("disabled",false);
			$("#sms_3").attr('disabled', false);
			$("#mail_3").attr('disabled', false);
			$("#del_user_3").attr('disabled', false);
			if(smsDefault == "Y"){
				$("#sms_3").attr('checked', true);
			}
			if(mailDefault == "Y"){
				$("#mail_3").attr('checked', true);
			}
			$("#del_user_3").attr('checked', false);
			$("#btn_del_3").attr("src", "/images/sta2.png");
		}

		if(obj == 'mapper_gubun_4' && !udt_user_4){
			$("#mapper_nm_4").val("");
			$("#mapper_cd_4").val("");
			$("#mapper_nm_4").prop("disabled",true);
			$("#sms_4").attr('disabled', true);
			$("#mail_4").attr('disabled', true);
			$("#btn_del_4").attr("src", "/images/sta2_disabled.png");
			$("#del_user_4").attr('disabled', true);
		}else if(obj == 'mapper_gubun_4' && udt_user_4){
			$("#mapper_nm_4").val("");
			$("#mapper_cd_4").val("");
			$("#mapper_nm_4").prop("disabled",false);
			$("#sms_4").attr('disabled', false);
			$("#mail_4").attr('disabled', false);
			$("#del_user_4").attr('disabled', false);
			if(smsDefault == "Y"){
				$("#sms_4").attr('checked', true);
			}
			if(mailDefault == "Y"){
				$("#mail_4").attr('checked', true);
			}
			$("#del_user_4").attr('checked', false);
			$("#btn_del_4").attr("src", "/images/sta2.png");
		}

		if(obj == 'mapper_gubun_5' && !udt_user_5){
			$("#mapper_nm_5").val("");
			$("#mapper_cd_5").val("");
			$("#mapper_nm_5").prop("disabled",true);
			$("#sms_5").attr('disabled', true);
			$("#mail_5").attr('disabled', true);
			$("#btn_del_5").attr("src", "/images/sta2_disabled.png");
			$("#del_user_5").attr('disabled', true);
		}else if(obj == 'mapper_gubun_5' && udt_user_5){
			$("#mapper_nm_5").val("");
			$("#mapper_cd_5").val("");
			$("#mapper_nm_5").prop("disabled",false);
			$("#sms_5").attr('disabled', false);
			$("#mail_5").attr('disabled', false);
			$("#del_user_5").attr('disabled', false);
			if(smsDefault == "Y"){
				$("#sms_5").attr('checked', true);
			}
			if(mailDefault == "Y"){
				$("#mail_5").attr('checked', true);
			}
			$("#del_user_5").attr('checked', false);
			$("#btn_del_5").attr("src", "/images/sta2.png");
		}

		if(obj == 'mapper_gubun_6' && !udt_user_6){
			$("#mapper_nm_6").val("");
			$("#mapper_cd_6").val("");
			$("#mapper_nm_6").prop("disabled",true);
			$("#sms_6").attr('disabled', true);
			$("#mail_6").attr('disabled', true);
			$("#btn_del_6").attr("src", "/images/sta2_disabled.png");
			$("#del_user_6").attr('disabled', true);
		}else if(obj == 'mapper_gubun_6' && udt_user_6){
			$("#mapper_nm_6").val("");
			$("#mapper_cd_6").val("");
			$("#mapper_nm_6").prop("disabled",false);
			$("#sms_6").attr('disabled', false);
			$("#mail_6").attr('disabled', false);
			$("#del_user_6").attr('disabled', false);
			if(smsDefault == "Y"){
				$("#sms_6").attr('checked', true);
			}
			if(mailDefault == "Y"){
				$("#mail_6").attr('checked', true);
			}
			$("#del_user_6").attr('checked', false);
			$("#btn_del_6").attr("src", "/images/sta2.png");
		}

		if(obj == 'mapper_gubun_7' && !udt_user_7){
			$("#mapper_nm_7").val("");
			$("#mapper_cd_7").val("");
			$("#mapper_nm_7").prop("disabled",true);
			$("#sms_7").attr('disabled', true);
			$("#mail_7").attr('disabled', true);
			$("#btn_del_7").attr("src", "/images/sta2_disabled.png");
			$("#del_user_7").attr('disabled', true);
		}else if(obj == 'mapper_gubun_7' && udt_user_7){
			$("#mapper_nm_7").val("");
			$("#mapper_cd_7").val("");
			$("#mapper_nm_7").prop("disabled",false);
			$("#sms_7").attr('disabled', false);
			$("#mail_7").attr('disabled', false);
			$("#del_user_7").attr('disabled', false);
			if(smsDefault == "Y"){
				$("#sms_7").attr('checked', true);
			}
			if(mailDefault == "Y"){
				$("#mail_7").attr('checked', true);
			}
			$("#del_user_7").attr('checked', false);
			$("#btn_del_7").attr("src", "/images/sta2.png");
		}

		if(obj == 'mapper_gubun_8' && !udt_user_8){
			$("#mapper_nm_8").val("");
			$("#mapper_cd_8").val("");
			$("#mapper_nm_8").prop("disabled",true);
			$("#sms_8").attr('disabled', true);
			$("#mail_8").attr('disabled', true);
			$("#btn_del_8").attr("src", "/images/sta2_disabled.png");
			$("#del_user_8").attr('disabled', true);
		}else if(obj == 'mapper_gubun_8' && udt_user_8){
			$("#mapper_nm_8").val("");
			$("#mapper_cd_8").val("");
			$("#mapper_nm_8").prop("disabled",false);
			$("#sms_8").attr('disabled', false);
			$("#mail_8").attr('disabled', false);
			$("#del_user_8").attr('disabled', false);
			if(smsDefault == "Y"){
				$("#sms_8").attr('checked', true);
			}
			if(mailDefault == "Y"){
				$("#mail_8").attr('checked', true);
			}
			$("#del_user_8").attr('checked', false);
			$("#btn_del_8").attr("src", "/images/sta2.png");
		}

		if(obj == 'mapper_gubun_9' && !udt_user_9){
			$("#mapper_nm_9").val("");
			$("#mapper_cd_9").val("");
			$("#mapper_nm_9").prop("disabled",true);
			$("#sms_9").attr('disabled', true);
			$("#mail_9").attr('disabled', true);
			$("#btn_del_9").attr("src", "/images/sta2_disabled.png");
			$("#del_user_9").attr('disabled', true);
		}else if(obj == 'mapper_gubun_9' && udt_user_9){
			$("#mapper_nm_9").val("");
			$("#mapper_cd_9").val("");
			$("#mapper_nm_9").prop("disabled",false);
			$("#sms_9").attr('disabled', false);
			$("#mail_9").attr('disabled', false);
			$("#del_user_9").attr('disabled', false);
			if(smsDefault == "Y"){
				$("#sms_9").attr('checked', true);
			}
			if(mailDefault == "Y"){
				$("#mail_9").attr('checked', true);
			}
			$("#del_user_9").attr('checked', false);
			$("#btn_del_9").attr("src", "/images/sta2.png");
		}

		if(obj == 'mapper_gubun_10' && !udt_user_10){
			$("#mapper_nm_10").val("");
			$("#mapper_cd_10").val("");
			$("#mapper_nm_10").prop("disabled",true);
			$("#sms_10").attr('disabled', true);
			$("#mail_10").attr('disabled', true);
			$("#btn_del_10").attr("src", "/images/sta2_disabled.png");
			$("#del_user_10").attr('disabled', true);
		}else if(obj == 'mapper_gubun_10' && udt_user_10){
			$("#mapper_nm_10").val("");
			$("#mapper_cd_10").val("");
			$("#mapper_nm_10").prop("disabled",false);
			$("#sms_10").attr('disabled', false);
			$("#mail_10").attr('disabled', false);
			$("#del_user_10").attr('disabled', false);
			if(smsDefault == "Y"){
				$("#sms_10").attr('checked', true);
			}
			if(mailDefault == "Y"){
				$("#mail_10").attr('checked', true);
			}
			$("#del_user_10").attr('checked', false);
			$("#btn_del_10").attr("src", "/images/sta2.png");
		}

		if(obj == 'mapper_gubun_11' && !udt_user_11){
			$("#mapper_nm_11").val("");
			$("#mapper_cd_11").val("");
			$("#mapper_nm_11").prop("disabled",true);
			$("#grp_sms_1").attr('disabled', true);
			$("#grp_mail_1").attr('disabled', true);
			$("#btn_del_11").attr("src", "/images/sta2_disabled.png");
			$("#del_user_11").attr('disabled', true);
			document.getElementById("mapper_nm_11").setAttribute("placeholder","");
		}else if(obj == 'mapper_gubun_11' && udt_user_11){
			$("#mapper_nm_11").val("");
			$("#mapper_cd_11").val("");
			$("#mapper_nm_11").prop("disabled",false);
			$("#grp_sms_1").attr('disabled', false);
			$("#grp_mail_1").attr('disabled', false);
			$("#del_user_11").attr('disabled', false);
			if(smsDefault == "Y"){
				$("#grp_sms_1").attr('checked', true);
			}
			if(mailDefault == "Y"){
				$("#grp_mail_1").attr('checked', true);
			}
			$("#del_user_11").attr('checked', false);
			$("#btn_del_11").attr("src", "/images/sta2.png");
			document.getElementById("mapper_nm_11").setAttribute("placeholder","");
		}

		if(obj == 'mapper_gubun_12' && !udt_user_12){
			$("#mapper_nm_12").val("");
			$("#mapper_cd_12").val("");
			$("#mapper_nm_12").prop("disabled",true);
			$("#grp_sms_2").attr('disabled', true);
			$("#grp_mail_2").attr('disabled', true);
			$("#btn_del_12").attr("src", "/images/sta2_disabled.png");
			$("#del_user_12").attr('disabled', true);
			document.getElementById("mapper_nm_12").setAttribute("placeholder","");
		}else if(obj == 'mapper_gubun_12' && udt_user_12){
			$("#mapper_nm_12").val("");
			$("#mapper_cd_12").val("");
			$("#mapper_nm_12").prop("disabled",false);
			$("#grp_sms_2").attr('disabled', false);
			$("#grp_mail_2").attr('disabled', false);
			$("#del_user_12").attr('disabled', false);
			if(smsDefault == "Y"){
				$("#grp_sms_1").attr('checked', true);
			}
			if(mailDefault == "Y"){
				$("#grp_mail_1").attr('checked', true);
			}
			$("#del_user_12").attr('checked', false);
			$("#btn_del_12").attr("src", "/images/sta2.png");
			document.getElementById("mapper_nm_12").setAttribute("placeholder","");
		}
	}

	function chkDel(obj) {

		var del_user = document.getElementById(obj).checked;
		var del_user_2 = document.getElementById(obj).checked;
		var del_user_3 = document.getElementById(obj).checked;
		var del_user_4 = document.getElementById(obj).checked;
		var del_user_5 = document.getElementById(obj).checked;
		var del_user_6 = document.getElementById(obj).checked;
		var del_user_7 = document.getElementById(obj).checked;
		var del_user_8 = document.getElementById(obj).checked;
		var del_user_9 = document.getElementById(obj).checked;
		var del_user_10 = document.getElementById(obj).checked;
		var del_user_11 = document.getElementById(obj).checked;
		var del_user_12 = document.getElementById(obj).checked;
		var imgurl = "";

		if (del_user_2) {
			imgurl = "/images/sta2_disabled.png";
		} else {
			imgurl = "/images/sta2.png";
		}
		if (del_user_3) {
			imgurl = "/images/sta2_disabled.png";
		} else {
			imgurl = "/images/sta2.png";
		}
		if (del_user_4) {
			imgurl = "/images/sta2_disabled.png";
		} else {
			imgurl = "/images/sta2.png";
		}
		if (del_user_5) {
			imgurl = "/images/sta2_disabled.png";
		} else {
			imgurl = "/images/sta2.png";
		}
		if (del_user_6) {
			imgurl = "/images/sta2_disabled.png";
		} else {
			imgurl = "/images/sta2.png";
		}
		if (del_user_7) {
			imgurl = "/images/sta2_disabled.png";
		} else {
			imgurl = "/images/sta2.png";
		}
		if (del_user_8) {
			imgurl = "/images/sta2_disabled.png";
		} else {
			imgurl = "/images/sta2.png";
		}
		if (del_user_9) {
			imgurl = "/images/sta2_disabled.png";
		} else {
			imgurl = "/images/sta2.png";
		}
		if (del_user_10) {
			imgurl = "/images/sta2_disabled.png";
		} else {
			imgurl = "/images/sta2.png";
		}
		if (del_user_11) {
			imgurl = "/images/sta2_disabled.png";
		} else {
			imgurl = "/images/sta2.png";
		}
		if (del_user_12) {
			imgurl = "/images/sta2_disabled.png";
		} else {
			imgurl = "/images/sta2.png";
		}
		if (obj == 'del_user_2' && del_user_2) {
			$("#mapper_nm_2").val("");
			$("#mapper_cd_2").val("");
			$("#sms_2").attr('checked', !del_user_2);
			$("#mail_2").attr('checked', !del_user_2);
			$("#btn_del_2").attr("src", imgurl);
			document.getElementById("mapper_nm_2").setAttribute("placeholder", "담당자2 초기화");
		} else if (obj == 'del_user_2' && !del_user_2) {
			$("#mapper_nm_2").val("");
			$("#mapper_cd_2").val("");
			$("#sms_2").attr('checked', !del_user_2);
			$("#mail_2").attr('checked', !del_user_2);
			$("#btn_del_2").attr("src", imgurl);
			document.getElementById("mapper_nm_2").setAttribute("placeholder", "");
		} else if (obj == 'del_user_3' && del_user_3) {
			$("#mapper_nm_3").val("");
			$("#mapper_cd_3").val("");
			$("#sms_3").attr('checked', !del_user_3);
			$("#mail_3").attr('checked', !del_user_3);
			$("#btn_del_3").attr("src", imgurl);
			document.getElementById("mapper_nm_3").setAttribute("placeholder", "담당자3 초기화");
		} else if (obj == 'del_user_3' && !del_user_3) {
			$("#mapper_nm_3").val("");
			$("#mapper_cd_3").val("");
			$("#sms_3").attr('checked', !del_user_3);
			$("#mail_3").attr('checked', !del_user_3);
			$("#btn_del_3").attr("src", imgurl);
			document.getElementById("mapper_nm_3").setAttribute("placeholder", "");
		} else if (obj == 'del_user_4' && del_user_4) {
			$("#mapper_nm_4").val("");
			$("#mapper_cd_4").val("");
			$("#sms_4").attr('checked', !del_user_4);
			$("#mail_4").attr('checked', !del_user_4);
			$("#btn_del_4").attr("src", imgurl);
			document.getElementById("mapper_nm_4").setAttribute("placeholder", "담당자4 초기화");
		} else if (obj == 'del_user_4' && !del_user_4) {
			$("#mapper_nm_4").val("");
			$("#mapper_cd_4").val("");
			$("#sms_4").attr('checked', !del_user_4);
			$("#mail_4").attr('checked', !del_user_4);
			$("#btn_del_4").attr("src", imgurl);
			document.getElementById("mapper_nm_4").setAttribute("placeholder", "");
		} else if (obj == 'del_user_5' && del_user_5) {
			$("#mapper_nm_5").val("");
			$("#mapper_cd_5").val("");
			$("#sms_5").attr('checked', !del_user_5);
			$("#mail_5").attr('checked', !del_user_5);
			$("#btn_del_5").attr("src", imgurl);
			document.getElementById("mapper_nm_5").setAttribute("placeholder", "담당자5 초기화");
		} else if (obj == 'del_user_5' && !del_user_5) {
			$("#mapper_nm_5").val("");
			$("#mapper_cd_5").val("");
			$("#sms_5").attr('checked', !del_user_5);
			$("#mail_5").attr('checked', !del_user_5);
			$("#btn_del_5").attr("src", imgurl);
			document.getElementById("mapper_nm_5").setAttribute("placeholder", "");
		} else if (obj == 'del_user_6' && del_user_6) {
			$("#mapper_nm_6").val("");
			$("#mapper_cd_6").val("");
			$("#sms_6").attr('checked', !del_user_6);
			$("#mail_6").attr('checked', !del_user_6);
			$("#btn_del_6").attr("src", imgurl);
			document.getElementById("mapper_nm_6").setAttribute("placeholder", "담당자6 초기화");
		} else if (obj == 'del_user_6' && !del_user_6) {
			$("#mapper_nm_6").val("");
			$("#mapper_cd_6").val("");
			$("#sms_6").attr('checked', !del_user_6);
			$("#mail_6").attr('checked', !del_user_6);
			$("#btn_del_6").attr("src", imgurl);
			document.getElementById("mapper_nm_6").setAttribute("placeholder", "");
		} else if (obj == 'del_user_7' && del_user_7) {
			$("#mapper_nm_7").val("");
			$("#mapper_cd_7").val("");
			$("#sms_7").attr('checked', !del_user_7);
			$("#mail_7").attr('checked', !del_user_7);
			$("#btn_del_7").attr("src", imgurl);
			document.getElementById("mapper_nm_7").setAttribute("placeholder", "담당자7 초기화");
		} else if (obj == 'del_user_7' && !del_user_7) {
			$("#mapper_nm_7").val("");
			$("#mapper_cd_7").val("");
			$("#sms_7").attr('checked', !del_user_7);
			$("#mail_7").attr('checked', !del_user_7);
			$("#btn_del_7").attr("src", imgurl);
			document.getElementById("mapper_nm_7").setAttribute("placeholder", "");
		} else if (obj == 'del_user_8' && del_user_8) {
			$("#mapper_nm_8").val("");
			$("#mapper_cd_8").val("");
			$("#sms_8").attr('checked', !del_user_8);
			$("#mail_8").attr('checked', !del_user_8);
			$("#btn_del_8").attr("src", imgurl);
			document.getElementById("mapper_nm_8").setAttribute("placeholder", "담당자8 초기화");
		} else if (obj == 'del_user_8' && !del_user_8) {
			$("#mapper_nm_8").val("");
			$("#mapper_cd_8").val("");
			$("#sms_8").attr('checked', !del_user_8);
			$("#mail_8").attr('checked', !del_user_8);
			$("#btn_del_8").attr("src", imgurl);
			document.getElementById("mapper_nm_8").setAttribute("placeholder", "");
		} else if (obj == 'del_user_9' && del_user_9) {
			$("#mapper_nm_9").val("");
			$("#mapper_cd_9").val("");
			$("#sms_9").attr('checked', !del_user_9);
			$("#mail_9").attr('checked', !del_user_9);
			$("#btn_del_9").attr("src", imgurl);
			document.getElementById("mapper_nm_9").setAttribute("placeholder", "담당자9 초기화");
		} else if (obj == 'del_user_9' && !del_user_9) {
			$("#mapper_nm_9").val("");
			$("#mapper_cd_9").val("");
			$("#sms_9").attr('checked', !del_user_9);
			$("#mail_9").attr('checked', !del_user_9);
			$("#btn_del_9").attr("src", imgurl);
			document.getElementById("mapper_nm_9").setAttribute("placeholder", "");
		} else if (obj == 'del_user_10' && del_user_10) {
			$("#mapper_nm_10").val("");
			$("#mapper_cd_10").val("");
			$("#sms_10").attr('checked', !del_user_10);
			$("#mail_10").attr('checked', !del_user_10);
			$("#btn_del_10").attr("src", imgurl);
			document.getElementById("mapper_nm_10").setAttribute("placeholder", "담당자10 초기화");
		} else if (obj == 'del_user_10' && !del_user_10) {
			$("#mapper_nm_10").val("");
			$("#mapper_cd_10").val("");
			$("#sms_10").attr('checked', !del_user_10);
			$("#mail_10").attr('checked', !del_user_10);
			$("#btn_del_10").attr("src", imgurl);
			document.getElementById("mapper_nm_10").setAttribute("placeholder", "");
		} else if (obj == 'del_user_11' && del_user_11) {
			$("#mapper_nm_11").val("");
			$("#mapper_cd_11").val("");
			$("#grp_sms_1").attr('checked', !del_user_11);
			$("#grp_mail_1").attr('checked', !del_user_11);
			$("#btn_del_11").attr("src", imgurl);
			document.getElementById("mapper_nm_11").setAttribute("placeholder", "그룹1 초기화");
		} else if (obj == 'del_user_11' && !del_user_11) {
			$("#mapper_nm_11").val("");
			$("#mapper_cd_11").val("");
			$("#grp_sms_1").attr('checked', !del_user_11);
			$("#grp_mail_1").attr('checked', !del_user_11);
			$("#btn_del_11").attr("src", imgurl);
			document.getElementById("mapper_nm_11").setAttribute("placeholder", "");
		} else if (obj == 'del_user_12' && del_user_12) {
			$("#mapper_nm_12").val("");
			$("#mapper_cd_12").val("");
			$("#grp_sms_2").attr('checked', !del_user_12);
			$("#grp_mail_2").attr('checked', !del_user_12);
			$("#btn_del_12").attr("src", imgurl);
			document.getElementById("mapper_nm_12").setAttribute("placeholder", "그룹2 초기화");
		} else if (obj == 'del_user_12' && !del_user_12) {
			$("#mapper_nm_12").val("");
			$("#mapper_cd_12").val("");
			$("#grp_sms_2").attr('checked', !del_user_12);
			$("#grp_mail_2").attr('checked', !del_user_12);
			$("#btn_del_12").attr("src", imgurl);
			document.getElementById("mapper_nm_12").setAttribute("placeholder", "");
		}
	}
</script>
<body>
<form id="frm1" name="frm1" method="post" onsubmit="return false;">
	<input type="hidden" name="flag"  						value="batch_update" />
	<input type="hidden" name="data_center"  				value="${paramMap.data_center}" />
	<input type="hidden" name="job_names" id="job_names"	value="${paramMap.job_names}"/>
	<input type='hidden' name='del_user' id='del_user' 		value='' />
	<input type='hidden' name='udt_user' id='udt_user' 		value='' />
	<table style='width:98%;height:92%;border:none;'>
		<tr style='height:10px;'>
			<td style='vertical-align:top;'>
				<h4 class="ui-widget-header ui-corner-all">
					<div class='title_area' style="width:98%; text-align:left; padding-top:8px; padding-bottom:8px;">
						<span><%=CommonUtil.getMessage("CATEGORY.POP.03") %><font color='blue'>[총 ${paramMap.rows_length}건 일괄변경 예정]</font></span>
					</div>
				</h4>
			</td>
		</tr>
		<tr></tr>
		<td valign="top" style="height:100%;">
			<h2 class="ui-widget-header ui-corner-all">
				<table style="width:100%;">
					<tr>
						<th style="width:3%;"></th>
						<td>
							<div class='cellContent_kang'>
								<input type='checkbox' name='mapper_gubun' id='mapper_gubun' value='1' onclick="chkUdt('mapper_gubun')"/> 담당자 1&nbsp;
								<input type='hidden' id="mapper_cd" name="mapper_cd"  />
								<input type="text" name="mapper_nm" id="mapper_nm" value="" style="width:150px;height:21px;" disabled />
								<img id="btn_del" src="/images/sta2_disabled.png" style="width:14px;height:14px;vertical-align:middle;cursor:pointer;border:none;box-shadow:none;"/>
								<%=strSms%><input type='checkbox' name='sms_1' id='sms_1' value='Y' disabled />
								<%=strMail%><input type='checkbox' name='mail_1' id='mail_1' value='Y' disabled />
								<%--초기화<input type='checkbox' name='del_user_1' id='del_user_1' value='Y'  onclick="chkDel('del_user_1')"/>--%>
							</div>

							<div class='cellContent_kang'>
								<input type='checkbox' name='mapper_gubun_2' id='mapper_gubun_2' value='2' onclick="chkUdt('mapper_gubun_2')"/> 담당자 2&nbsp;
								<input type='hidden' id="mapper_cd_2" name="mapper_cd_2"  />
								<input type="text" name="mapper_nm_2" id="mapper_nm_2" value="" style="width:150px;height:21px;" disabled />
								<img id="btn_del_2" src="/images/sta2_disabled.png" style="width:14px;height:14px;vertical-align:middle;cursor:pointer;border:none;box-shadow:none;"/>
								<%=strSms%><input type='checkbox' name='sms_2' id='sms_2' value='Y' disabled />
								<%=strMail%><input type='checkbox' name='mail_2' id='mail_2' value='Y' disabled />
								초기화<input type='checkbox' name='del_user_2' id='del_user_2' value='Y' onclick="chkDel('del_user_2')" disabled/>
							</div>

							<div class='cellContent_kang'>
								<input type='checkbox' name='mapper_gubun_3' id='mapper_gubun_3' value='3' onclick="chkUdt('mapper_gubun_3')"/> 담당자 3&nbsp;
								<input type='hidden' id="mapper_cd_3" name="mapper_cd_3"  />
								<input type="text" name="mapper_nm_3" id="mapper_nm_3" value="" style="width:150px;height:21px;" disabled />
								<img id="btn_del_3" src="/images/sta2_disabled.png" style="width:14px;height:14px;vertical-align:middle;cursor:pointer;border:none;box-shadow:none;"/>
								<%=strSms%><input type='checkbox' name='sms_3' id='sms_3' value='Y' disabled />
								<%=strMail%><input type='checkbox' name='mail_3' id='mail_3' value='Y' disabled />
								초기화<input type='checkbox' name='del_user_3' id='del_user_3' value='Y' onclick="chkDel('del_user_3')" disabled/>
							</div>

							<div class='cellContent_kang'>
								<input type='checkbox' name='mapper_gubun_4' id='mapper_gubun_4' value='4' onclick="chkUdt('mapper_gubun_4')"/> 담당자 4&nbsp;
								<input type='hidden' id="mapper_cd_4" name="mapper_cd_4"  />
								<input type="text" name="mapper_nm_4" id="mapper_nm_4" value="" style="width:150px;height:21px;" disabled/>
								<img id="btn_del_4" src="/images/sta2_disabled.png" style="width:14px;height:14px;vertical-align:middle;cursor:pointer;border:none;box-shadow:none;"/>
								<%=strSms%><input type='checkbox' name='sms_4' id='sms_4' value='Y' disabled />
								<%=strMail%><input type='checkbox' name='mail_4' id='mail_4' value='Y' disabled />
								초기화<input type='checkbox' name='del_user_4' id='del_user_4' value='Y' onclick="chkDel('del_user_4')" disabled/>
							</div>

							<div class='cellContent_kang'>
								<input type='checkbox' name='mapper_gubun_5' id='mapper_gubun_5' value='5' onclick="chkUdt('mapper_gubun_5')"/> 담당자 5&nbsp;
								<input type='hidden' id="mapper_cd_5" name="mapper_cd_5"  />
								<input type="text" name="mapper_nm_5" id="mapper_nm_5" value="" style="width:150px;height:21px;" disabled />
								<img id="btn_del_5" src="/images/sta2_disabled.png" style="width:14px;height:14px;vertical-align:middle;cursor:pointer;border:none;box-shadow:none;"/>
								<%=strSms%><input type='checkbox' name='sms_5' id='sms_5' value='Y' disabled />
								<%=strMail%><input type='checkbox' name='mail_5' id='mail_5' value='Y' disabled />
								초기화<input type='checkbox' name='del_user_5' id='del_user_5' value='Y' onclick="chkDel('del_user_5')" disabled/>
							</div>

							<div class='cellContent_kang'>
								<input type='checkbox' name='mapper_gubun_6' id='mapper_gubun_6' value='6' onclick="chkUdt('mapper_gubun_6')"/> 담당자 6&nbsp;
								<input type='hidden' id="mapper_cd_6" name="mapper_cd_6"/>
								<input type="text" name="mapper_nm_6" id="mapper_nm_6" value="" style="width:150px;height:21px;" disabled />
								<img id="btn_del_6" src="/images/sta2_disabled.png" style="width:14px;height:14px;vertical-align:middle;cursor:pointer;border:none;box-shadow:none;"/>
								<%=strSms%><input type='checkbox' name='sms_6' id='sms_6' value='Y' disabled />
								<%=strMail%><input type='checkbox' name='mail_6' id='mail_6' value='Y' disabled />
								초기화<input type='checkbox' name='del_user_6' id='del_user_6' value='Y' onclick="chkDel('del_user_6')" disabled/>
							</div>

							<div class='cellContent_kang'>
								<input type='checkbox' name='mapper_gubun_7' id='mapper_gubun_7' value='7' onclick="chkUdt('mapper_gubun_7')"/> 담당자 7&nbsp;
								<input type='hidden' id="mapper_cd_7" name="mapper_cd_7"/>
								<input type="text" name="mapper_nm_7" id="mapper_nm_7" value="" style="width:150px;height:21px;" disabled />
								<img id="btn_del_7" src="/images/sta2_disabled.png" style="width:14px;height:14px;vertical-align:middle;cursor:pointer;border:none;box-shadow:none;"/>
								<%=strSms%><input type='checkbox' name='sms_7' id='sms_7' value='Y' disabled />
								<%=strMail%><input type='checkbox' name='mail_7' id='mail_7' value='Y' disabled />
								초기화<input type='checkbox' name='del_user_7' id='del_user_7' value='Y' onclick="chkDel('del_user_7')" disabled/>
							</div>

							<div class='cellContent_kang'>
								<input type='checkbox' name='mapper_gubun_8' id='mapper_gubun_8' value='8' onclick="chkUdt('mapper_gubun_8')"/> 담당자 8&nbsp;
								<input type='hidden' id="mapper_cd_8" name="mapper_cd_8"/>
								<input type="text" name="mapper_nm_8" id="mapper_nm_8" value="" style="width:150px;height:21px;" disabled />
								<img id="btn_del_8" src="/images/sta2_disabled.png" style="width:14px;height:14px;vertical-align:middle;cursor:pointer;border:none;box-shadow:none;"/>
								<%=strSms%><input type='checkbox' name='sms_8' id='sms_8' value='Y' disabled />
								<%=strMail%><input type='checkbox' name='mail_8' id='mail_8' value='Y' disabled />
								초기화<input type='checkbox' name='del_user_8'  id='del_user_8' value='Y' onclick="chkDel('del_user_8')" disabled/>
							</div>

							<div class='cellContent_kang'>
								<input type='checkbox' name='mapper_gubun_9' id='mapper_gubun_9' value='9' onclick="chkUdt('mapper_gubun_9')"/> 담당자 9&nbsp;
								<input type='hidden' id="mapper_cd_9" name="mapper_cd_9"/>
								<input type="text" name="mapper_nm_9" id="mapper_nm_9" value="" style="width:150px;height:21px;" disabled />
								<img id="btn_del_9" src="/images/sta2_disabled.png" style="width:14px;height:14px;vertical-align:middle;cursor:pointer;border:none;box-shadow:none;"/>
								<%=strSms%><input type='checkbox' name='sms_9' id='sms_9' value='Y' disabled />
								<%=strMail%><input type='checkbox' name='mail_9' id='mail_9' value='Y' disabled />
								초기화<input type='checkbox' name='del_user_9' id='del_user_9' value='Y' onclick="chkDel('del_user_9')" disabled/>
							</div>

							<div class='cellContent_kang'>
								<input type='checkbox' name='mapper_gubun_10' id='mapper_gubun_10' value='10' onclick="chkUdt('mapper_gubun_10')"/> 담당자 10
								<input type='hidden' id="mapper_cd_10" name="mapper_cd_10"/>
								<input type="text" name="mapper_nm_10" id="mapper_nm_10" value="" style="width:150px;height:21px;" disabled />
								<img id="btn_del_10" src="/images/sta2_disabled.png" style="width:14px;height:14px;vertical-align:middle;cursor:pointer;border:none;box-shadow:none;"/>
								<%=strSms%><input type='checkbox' name='sms_10' id='sms_10' value='Y' disabled />
								<%=strMail%><input type='checkbox' name='mail_10' id='mail_10' value='Y' disabled />
								초기화<input type='checkbox' name='del_user_10' id='del_user_10' value='Y' onclick="chkDel('del_user_10')" disabled/>
							</div>

							<div class='cellContent_kang'>
								<input type='checkbox' name='mapper_gubun_11' id='mapper_gubun_11' value='11' onclick="chkUdt('mapper_gubun_11')" /> 그룹 1 &nbsp;&nbsp;
								<input type='hidden' id="mapper_cd_11" name="mapper_cd_11"  />
								<input type="text" name="mapper_nm_11" id="mapper_nm_11" value="" style="width:150px;height:21px;" disabled />
								<img id="btn_del_11" src="/images/sta2_disabled.png" style="width:14px;height:14px;vertical-align:middle;cursor:pointer;border:none;box-shadow:none;"/>
								<%=strSms%><input type='checkbox' name='grp_sms_1' id='grp_sms_1' value='Y' disabled />
								<%=strMail%><input type='checkbox' name='grp_mail_1' id='grp_mail_1' value='Y' disabled />
								초기화<input type='checkbox' name='del_user_11' id='del_user_11' value='Y' onclick="chkDel('del_user_11')" disabled/>
							</div>

							<div class='cellContent_kang'>
								<input type='checkbox' name='mapper_gubun_12' id='mapper_gubun_12' value='12' onclick="chkUdt('mapper_gubun_12')" /> 그룹 2 &nbsp;&nbsp;
								<input type='hidden' id="mapper_cd_12" name="mapper_cd_12"  />
								<input type="text" name="mapper_nm_12" id="mapper_nm_12" value="" style="width:150px;height:21px;" disabled/>
								<img id="btn_del_12" src="/images/sta2_disabled.png" style="width:14px;height:14px;vertical-align:middle;cursor:pointer;border:none; box-shadow:none;"/>
								<%=strSms%><input type='checkbox' name='grp_sms_2' id='grp_sms_2' value='Y' disabled />
								<%=strMail%><input type='checkbox' name='grp_mail_2' id='grp_mail_2' value='Y' disabled />
								초기화<input type='checkbox' name='del_user_12' id='del_user_12' value='Y' onclick="chkDel('del_user_12')" disabled/>
							</div>
							<div class='cellContent_kang' >
								<br>
								* 체크박스 활성화 된 데이터에 한해서 일괄변경 진행<br>
								* 등록된 담당자를 초기화하려면 초기화 체크박스를 선택 후 저장
							</div>
						</td>
					</tr>
				</table>
			</h2>
			<tr valign="bottom">
				<td colspan="6" style="text-align:right;padding-top:5px;">
					<span id="btn_save">저장</span>
					<span id="btn_close">닫기</span>
				</td>
			</tr>
		</td>
	</table>
	<script>
		$(document).ready(function(){
			$("#btn_save").button().unbind("click").click(function(){
				updateUser();
			});

			$("#btn_close").button().unbind("click").click(function(){
				self.close();
			});

			//담당자 조회 기능
			$('input[id^=mapper_nm]').click(function(){
				var user_idx = $(this).attr('id').replace("mapper_nm","").replace("_","");
				if(user_idx == ''){
					user_idx = '1';
				}
				if(user_idx < 11) {
					goUserSearch(user_idx);
				}else{
					groupUserGroup("", user_idx);
				}
			}).unbind('keyup').keyup(function(e){
				if($(this).val() != '' && (this).data('sel_v') != $(this).val()){
					$('#sel_v').val();
					$(this).removeClass('input_complete');

				}
			});

			//담당자그룹 autocomplete 조회 기능 추가(신한캐피탈 23.02.01 김은희)
// 			$('input[id^=mapper_nm]').unbind('keypress').keypress(function(e){
// 				var user_idx = $(this).attr('id').replace("mapper_nm_","").replace("_0","");
// 				//if(e.keyCode==13 && trim($(this).val())!=''){
// 				if(e.keyCode==13 && user_idx > 10){
// 					groupUserGroup($(this).val(), user_idx);
// 				}
// 			}).unbind('keyup').keyup(function(e){
// 				if($(this).val() != '' && (this).data('sel_v') != $(this).val()){
// 					$('#sel_v').val();
// 					$(this).removeClass('input_complete');
// 				}
// 			});
			
			//신한투자증권 팝업형태로 변경
			$('input[id^=mapper_nm]').unbind('click').click(function(){
				var user_idx = $(this).attr('id').replace("mapper_nm_","");
				if(user_idx > 10) {
					goGroupSearch(user_idx,user_idx);
				}else{
					goUserSearch(user_idx,user_idx);
				}
			}).unbind('keyup').keyup(function(e){
				if($(this).val() != '' && (this).data('sel_v') != $(this).val()){
					$('#sel_v').val();
					$(this).removeClass('input_complete');
				}
			});

			//담당자그룹 삭제 버튼 시 비활성화 해제 및 배경색 변경
			$('img[id^=btn_del_]').button().unbind('click').click(function(){
				var del_idx = $(this).attr('id').replace("btn_del_","")
				$("#mapper_nm_" + del_idx).val("");
				$("#mapper_cd_" + del_idx).val("");
				$("#mapper_nm_" + del_idx).attr('disabled', false);
				$("#mapper_nm_" + del_idx).removeClass('input_complete');
			})

			$("#btn_del").button().unbind("click").click(function(){
				clearUser('mapper');
			});

		});

		function goUserSeqSelect(cd, nm, btn){

			var frm1 = document.frm1;

			if(btn == "mapper_nm"){
				frm1.mapper_nm.value = nm;
				frm1.mapper_cd.value = cd;
			}else if(btn == "2"){
				frm1.mapper_nm_2.value = nm;
				frm1.mapper_cd_2.value = cd;
			}else if(btn == "3"){
				frm1.mapper_nm_3.value = nm;
				frm1.mapper_cd_3.value = cd;
			}else if(btn == "4"){
				frm1.mapper_nm_4.value = nm;
				frm1.mapper_cd_4.value = cd;
			}else if(btn == "5"){
				frm1.mapper_nm_5.value = nm;
				frm1.mapper_cd_5.value = cd;
			}else if(btn == "6"){
				frm1.mapper_nm_6.value = nm;
				frm1.mapper_cd_6.value = cd;
			}else if(btn == "7"){
				frm1.mapper_nm_7.value = nm;
				frm1.mapper_cd_7.value = cd;
			}else if(btn == "8"){
				frm1.mapper_nm_8.value = nm;
				frm1.mapper_cd_8.value = cd;
			}else if(btn == "9"){
				frm1.mapper_nm_9.value = nm;
				frm1.mapper_cd_9.value = cd;
			}else if(btn == "10"){
				frm1.mapper_nm_10.value = nm;
				frm1.mapper_cd_10.value = cd;
			}
			dlClose('dl_tmp3');
		}

		//담당자그룹 조회
// 		function groupUserGroup(group_nm, arg){
		function getGroupList(group_nm, arg){ //신한투자증권 팝업형태로 변경
			var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=groupApprovalGroup&itemGubun=2&p_search_text='+encodeURIComponent(group_nm);

			var xhr = new XHRHandler(url, null
					,function(){
						var xmlDoc = this.req.responseXML;

						$(xmlDoc).find('doc').each(function(){

							var items = $(this).find('items');

// 							var aTags = new Array();
// 							if(items.attr('cnt')=='0'){
// 							}else{
// 								items.find('item').each(function(i){
// 									aTags.push({value:$(this).find('GROUP_LINE_GRP_NM').text()
// 										,label:$(this).find('GROUP_LINE_GRP_NM').text()
// 										,group_line_grp_cd:$(this).find('GROUP_LINE_GRP_CD').text()
// 									});
// 								});
// 							}

							var rowsObj = new Array();

							if(items.attr('cnt')=='0'){
							}else{
								items.find('item').each(function(i){

									var group_line_grp_cd = $(this).find("GROUP_LINE_GRP_CD").text();
									var group_line_grp_nm = $(this).find("GROUP_LINE_GRP_NM").text();

									rowsObj.push({'grid_idx':i+1
										,'GROUP_LINE_GRP_CD':group_line_grp_cd
										,'GROUP_LINE_GRP_NM':group_line_grp_nm
										,'CHOICE':"<div><a href=\"javascript:goGroupSeqSelect('"+group_line_grp_cd+"', '"+group_line_grp_nm+"', '"+arg+"');\" ><font color='red'>[선택]</font></a></div>"
									});

								});

							}
							var obj = $("#g_tmp3").data('gridObj');
							obj.rows = rowsObj;
							setGridRows(obj);

							$('#ly_total_cnt3').html('[ TOTAL : '+items.attr('cnt')+' ]');

							try{ $("#mapper_nm_+"+arg).autocomplete("destroy"); }catch(e){};

// 							$("#mapper_nm_"+arg).autocomplete({
// 								minLength: 0
// 								,source: aTags
// 								,autoFocus: false
// 								,focus: function(event, ui) {

// 								}
// 								,select: function(event, ui) {
// 									$(this).val(ui.item.value);
// 									$("#mapper_cd_"+arg).val(ui.item.group_line_grp_cd);

// 									$(this).data('sel_v',$(this).val());
// 									$(this).removeClass('input_complete').addClass('input_complete');
// 									//$(this).attr("disabled", true);
// 								}
// 								,disabled: false
// 								,create: function(event, ui) {
// 									$(this).autocomplete('search',$(this).val());
// 								}
// 								,close: function(event, ui) {
// 									$(this).autocomplete("destroy");
// 								}
// 								,open: function(){
// 									setTimeout(function () {
// 										$('.ui-autocomplete').css('z-index', 3000);
// 									}, 10);
// 								}

// 							}).data("autocomplete")._renderItem = function(ul, item) {
// 								return $("<li></li>" )
// 										.data("item.autocomplete", item)
// 										.append("<a>" + item.label + "</a>")
// 										.appendTo(ul);
// 							};

						});

					}
					, null );

			xhr.sendRequest();

			$("#mapper_nm_+"+arg).attr("disabled", true);
		}
		
		//신한투자증권 검색 팝업형태로 변경
		function goGroupSeqSelect(cd, nm, sel_line_cd){
			
			$("#mapper_nm_"+ sel_line_cd).val(nm);
			$("#mapper_cd_"+ sel_line_cd).val(cd);;

			dlClose('dl_tmp3');
		}
	</script>
</form>

<%@include file="/jsp/common/inc/progBar.jsp"  %>
</body>
