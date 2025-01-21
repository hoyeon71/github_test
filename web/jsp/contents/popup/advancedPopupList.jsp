<%@page import="com.ghayoun.ezjobs.t.domain.JobMapperMFTBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file="/jsp/common/inc/header.jsp"%>
<%@include file="/jsp/common/inc/sessionChk.jsp"%>

<%
	Map<String, Object> paramMap = CommonUtil.collectParameters(request);
	
	String FTP_LHOST 		= CommonUtil.isNull(paramMap.get("FTP_LHOST"));
	String FTP_RHOST 		= CommonUtil.isNull(paramMap.get("FTP_RHOST"));

	Map rMap 				= (Map)request.getAttribute("rMap");
	String advanced_num 	= CommonUtil.isNull(rMap.get("advanced_num"));
	String FTP_CONNTYPE1 	= CommonUtil.isNull(rMap.get("FTP_CONNTYPE1"));
	String FTP_CONNTYPE2 	= CommonUtil.isNull(rMap.get("FTP_CONNTYPE2"));
	
// 	List accountList = (List)request.getAttribute("accountList");
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Advanced</title>

<link rel="stylesheet" href="<%=sContextPath %>/css/css.css" type="text/css">
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.min.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery-ui.custom.min.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.resizeEnd.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.corner.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.cookie.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery-sha256.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.placeholder.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.blockUI.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.event.drag-2.2.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/common.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/cookie.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/popup.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/xhrHandler.js" ></script>

<script type="text/javascript" >
$(document).ready(function() {

	var frm = document.frm1;
	
	var advancedlist = new Array("FTP_SRCOPT", "FTP_NEWNAME", "FTP_SRC_ACT_FAIL", "FTP_IF_EXIST",
			"FTP_DSTOPT", "FTP_DEST_NEWNAME", "FTP_EMPTY_DEST_FILE_NAME",
			"FTP_FILE_PFX", "FTP_CONT_EXE", "FTP_DEL_DEST_ON_FAILURE",
			"FTP_POSTCMD_ON_FAILURE", "FTP_RECURSIVE", "FTP_ENCRYPTION1", "FTP_COMPRESSION1", "FTP_ENCRYPTION2", "FTP_COMPRESSION2",
			"FTP_PRESERVE_ATTR", "FTP_PRECOMM1", "FTP_PREPARAM11", "FTP_PREPARAM12", "FTP_POSTCOMM1",
			"FTP_POSTPARAM11", "FTP_POSTPARAM12", "FTP_PRECOMM2", "FTP_PREPARAM21", "FTP_PREPARAM22",
			"FTP_POSTCOMM2", "FTP_POSTPARAM21", "FTP_POSTPARAM22", "FTP_PGP_ENABLE", "FTP_PGP_TEMPLATE_NAME",
			"FTP_PGP_KEEP_FILES", "FTP_EXCLUDE_WILDCARD");
	
	var input = null;
	var tempvalue = null;
	var num = "<%=advanced_num%>";
<%-- 	var ac = '<%=accountList.size()%>'; --%>
	var type1 = "<%=FTP_CONNTYPE1%>";
	var type2 = "<%=FTP_CONNTYPE2%>";
	
	///////sftp 비활성화
	if(type1 == 'ftp' || type1 == 'FTP') {
		eval('frm.FTP_ENCRYPTION1' + num + '.disabled = true');
		eval('frm.FTP_COMPRESSION1' + num + '.disabled = true');
		eval('frm.FTP_PRESERVE_ATTR' + num + '.disabled = true');
		$('#FTP_ENCRYPTION1' + num).css("background-color", "#e2e2e2");
		$('#FTP_COMPRESSION1' + num).css("background-color", "#e2e2e2");
	}
	if(type2 == 'ftp' || type2 == 'FTP') {
		eval('frm.FTP_ENCRYPTION2' + num + '.disabled = true');
		eval('frm.FTP_COMPRESSION2' + num + '.disabled = true');
		eval('frm.FTP_PRESERVE_ATTR' + num + '.disabled = true');
		$('#FTP_ENCRYPTION2' + num).css("background-color", "#e2e2e2");
		$('#FTP_COMPRESSION2' + num).css("background-color", "#e2e2e2");
	}
	//////
	
	/* if(ac != 0) {
		for(var key in advancedlist) {
			input = advancedlist[key] + num;
			
			<c:forEach var="account" items="${accountList}" varStatus="vs">
			
			if(input == "${account.mft_name}") {
				input = '#' + input;
				tempvalue = "${account.mft_value}";
				
				if($('input:radio[name=' + advancedlist[key] + num + ']').length > 0) {
			    	$('input:radio[name=' + advancedlist[key] + num + ']:input[value=' + tempvalue + ']').attr("checked", true);
				} else if($(input).attr("type") == 'checkbox') {
					if(tempvalue == 1) {
						$(input).attr("checked", true);
					} else {
						$(input).attr("checked", false);
					}
				} else {
					$(input).val(tempvalue);
					
					if(advancedlist[key] == "FTP_EMPTY_DEST_FILE_NAME" || advancedlist[key] == "FTP_FILE_PFX") {
						if(tempvalue != '' && tempvalue != null) {
							$('#' + advancedlist[key] + '_CHECKBOX' + num).attr("checked", true);
						} else {
							$('#' + advancedlist[key] + '_CHECKBOX' + num).attr("checked", false);
						}
					}
				}
			}
			</c:forEach>
		}
	} else  */
	if($('#FTP_SRCOPT' + num, opener.document).length > 0) {
		for(var key in advancedlist) {
 			input = '#' + advancedlist[key] + num;
 			if(eval("opener.document.frm1."+advancedlist[key] + num)) {
			tempvalue = eval("opener.document.frm1."+advancedlist[key] + num+".value");
			
			if($('input:radio[name=' + advancedlist[key] + num + ']').length > 0) {
		    	$('input:radio[name=' + advancedlist[key] + num + ']:input[value=' + tempvalue + ']').attr("checked", true);
			} else if($(input).attr("type") == 'checkbox') {
				if(tempvalue == 1) {
					$(input).attr("checked", true);
				} else {
					$(input).attr("checked", false);
				}
			} else {
				$(input).val(tempvalue);
				if(advancedlist[key] == "FTP_EMPTY_DEST_FILE_NAME" || advancedlist[key] == "FTP_FILE_PFX") {
					if(tempvalue != '' && tempvalue != null) {
						$('#' + advancedlist[key] + '_CHECKBOX' + num).attr("checked", true);
					} else {
						$('#' + advancedlist[key] + '_CHECKBOX' + num).attr("checked", false);
					}
				}
			}
 			}
		}
	}
	
	if(opener.document.frm1.FTP_ACCOUNT.disabled == true) {
		eval('frm.FTP_EMPTY_DEST_FILE_NAME_CHECKBOX' + num + '.disabled = true;');
		eval('frm.FTP_FILE_PFX_CHECKBOX' + num + '.disabled= true;'); 
		for(var key in advancedlist) {
			if(advancedlist[key] == 'FTP_SRCOPT' || advancedlist[key] == 'FTP_IF_EXIST' || advancedlist[key]  == 'FTP_DSTOPT') {
				$("input[name=" + advancedlist[key] + num + "]").attr("disabled", "disabled");
			} else {
				eval("frm." + advancedlist[key] + num + ".disabled = true;");
			}
		}
	} else {
		ftp_srcopt_check(num);
		ftp_if_exist_check(num);
		ftp_dstopt_check(num);
		ftp_empty_dest_file_name_check(num);
		ftp_file_pfx_check(num);
		ftp_precomm1_change(num);
		ftp_postcomm1_change(num);
		ftp_precomm2_change(num);
		ftp_postcomm2_change(num);
	}
});
</script>

<script type="text/javascript" >

	function ftp_srcopt_check(num) {
		var name = 'FTP_SRCOPT' + num;
		name = document.getElementsByName(name);
		
		var len = name.length;
		var ftp_newname = 'document.frm1.FTP_NEWNAME' + num;
		ftp_newname = eval(ftp_newname);
		
		var ftp_src_act_fail = 'document.frm1.FTP_SRC_ACT_FAIL' + num;
		ftp_src_act_fail = eval(ftp_src_act_fail);
		
		if (name[0].checked == true) {
			ftp_newname.disabled = true;
			ftp_newname.value = '';
			ftp_newname.style.backgroundColor = '#e2e2e2';
			ftp_src_act_fail.disabled = true;
		} else {
			ftp_src_act_fail.disabled = false;
			if(name[1].checked == true) {
				ftp_newname.disabled = true;
				ftp_newname.value = '';
				ftp_newname.style.backgroundColor = '#e2e2e2';
			} else {
				ftp_newname.disabled = false;
				ftp_newname.style.backgroundColor = 'white';
			}
		}
	}
	

	function ftp_if_exist_check(num) {
		var name = 'FTP_IF_EXIST' + num;
		name = document.getElementsByName(name);
		
		var ftp_file_pfx_checkbox = 'document.frm1.FTP_FILE_PFX_CHECKBOX' + num;
		ftp_file_pfx_checkbox = eval(ftp_file_pfx_checkbox);
		
		var ftp_file_pfx = 'document.frm1.FTP_FILE_PFX' + num;
		ftp_file_pfx = eval(ftp_file_pfx);
		
		if (name[1].checked == true) {
			ftp_file_pfx_checkbox.disabled = true;
			ftp_file_pfx_checkbox.checked = false;
			ftp_file_pfx.disabled = true;
			ftp_file_pfx.value = '';
			ftp_file_pfx.style.backgroundColor = '#e2e2e2';
		} else {
			ftp_file_pfx_checkbox.disabled = false;
			ftp_file_pfx.style.backgroundColor = 'white';
			ftp_file_pfx_check(num);
		}
	}

	function ftp_dstopt_check(num) {
		var name = 'FTP_DSTOPT' + num;
		name = document.getElementsByName(name);

		var option = "document.frm1.FTP_DEST_NEWNAME" + num;
		option = eval(option);

		if (name[0].checked == true) {
			option.disabled = true;
			option.value = '';
			option.style.backgroundColor = '#e2e2e2';
		} else {
			option.disabled = false;
			option.style.backgroundColor = 'white';
		}
	}
	
	function ftp_empty_dest_file_name_check(num) {
		var name = 'FTP_EMPTY_DEST_FILE_NAME_CHECKBOX' + num;
		name = document.getElementsByName(name);

		var ftp_empty_dest_file_name = "document.frm1.FTP_EMPTY_DEST_FILE_NAME" + num;
		ftp_empty_dest_file_name = eval(ftp_empty_dest_file_name);
		
		if (name[0].checked == true) {
			ftp_empty_dest_file_name.disabled = false;
			ftp_empty_dest_file_name.style.backgroundColor = 'white';
		} else {
			ftp_empty_dest_file_name.disabled = true;
			ftp_empty_dest_file_name.value = '';
			ftp_empty_dest_file_name.style.backgroundColor = '#e2e2e2';
		}
	}

	function ftp_file_pfx_check(num) {
		var name = 'FTP_FILE_PFX_CHECKBOX' + num;
		name = document.getElementsByName(name);

		var ftp_file_pfx = "document.frm1.FTP_FILE_PFX" + num;
		ftp_file_pfx = eval(ftp_file_pfx);
		
		if (name[0].checked == true) {
			ftp_file_pfx.disabled = false;
			ftp_file_pfx.style.backgroundColor = 'white';
		} else {
			ftp_file_pfx.disabled = true;
			ftp_file_pfx.value = '';
			ftp_file_pfx.style.backgroundColor = '#e2e2e2';
		}
	}
	
	function ftp_precomm1_change(num) {
		var name = 'FTP_PRECOMM1' + num;
		name = document.getElementsByName(name);
		
		var ftp_preparam11 = "document.frm1.FTP_PREPARAM11" + num;
		ftp_preparam11 = eval(ftp_preparam11);

		var ftp_preparam12 = "document.frm1.FTP_PREPARAM12" + num;
		ftp_preparam12 = eval(ftp_preparam12);
		
		switch (name[0].value) {
		case "chmod":
		case "rename":
			ftp_preparam11.disabled = false;
			ftp_preparam11.style.backgroundColor = 'white';
			ftp_preparam12.disabled = false;
			ftp_preparam12.style.backgroundColor = 'white';
			break;
		case "mkdir":
		case "rm":
		case "rmdir":
			ftp_preparam11.disabled = false;
			ftp_preparam11.style.backgroundColor = 'white';
			ftp_preparam12.disabled = true;
			ftp_preparam12.value = '';
			ftp_preparam12.style.backgroundColor = '#e2e2e2';
			break;
		default:
			ftp_preparam11.disabled = true;
			ftp_preparam11.value = '';
			ftp_preparam11.style.backgroundColor = '#e2e2e2';
			ftp_preparam12.disabled = true;
			ftp_preparam12.value = '';
			ftp_preparam12.style.backgroundColor = '#e2e2e2';
			break;
		}
	}
	
	function ftp_postcomm1_change(num) {
		var name = 'FTP_POSTCOMM1' + num;
		name = document.getElementsByName(name);
		
		var ftp_postparam11 = "document.frm1.FTP_POSTPARAM11" + num;
		ftp_postparam11 = eval(ftp_postparam11);

		var ftp_postparam12 = "document.frm1.FTP_POSTPARAM12" + num;
		ftp_postparam12 = eval(ftp_postparam12);
		
		switch (name[0].value) {
		case "chmod":
		case "rename":
			ftp_postparam11.disabled = false;
			ftp_postparam11.style.backgroundColor = 'white';
			ftp_postparam12.disabled = false;
			ftp_postparam12.style.backgroundColor = 'white';
			break;
		case "mkdir":
		case "rm":
		case "rmdir":
			ftp_postparam11.disabled = false;
			ftp_postparam11.style.backgroundColor = 'white';
			ftp_postparam12.disabled = true;
			ftp_postparam12.value = '';
			ftp_postparam12.style.backgroundColor = '#e2e2e2';
			break;
		default:
			ftp_postparam11.disabled = true;
			ftp_postparam11.value = '';
			ftp_postparam11.style.backgroundColor = '#e2e2e2';
			ftp_postparam12.disabled = true;
			ftp_postparam12.value = '';
			ftp_postparam12.style.backgroundColor = '#e2e2e2';
			break;
		}
	}
	
	function ftp_precomm2_change(num) {
		var name = 'FTP_PRECOMM2' + num;
		name = document.getElementsByName(name);
		
		var ftp_preparam21 = "document.frm1.FTP_PREPARAM21" + num;
		ftp_preparam21 = eval(ftp_preparam21);

		var ftp_preparam22 = "document.frm1.FTP_PREPARAM22" + num;
		ftp_preparam22 = eval(ftp_preparam22);
		
		switch (name[0].value) {
		case "chmod":
		case "rename":
			ftp_preparam21.disabled = false;
			ftp_preparam21.style.backgroundColor = 'white';
			ftp_preparam22.disabled = false;
			ftp_preparam22.style.backgroundColor = 'white';
			break;
		case "mkdir":
		case "rm":
		case "rmdir":
			ftp_preparam21.disabled = false;
			ftp_preparam21.style.backgroundColor = 'white';
			ftp_preparam22.disabled = true;
			ftp_preparam22.value = '';
			ftp_preparam22.style.backgroundColor = '#e2e2e2';
			break;
		default:
			ftp_preparam21.disabled = true;
			ftp_preparam21.value = '';
			ftp_preparam21.style.backgroundColor = '#e2e2e2';
			ftp_preparam22.disabled = true;
			ftp_preparam22.value = '';
			ftp_preparam22.style.backgroundColor = '#e2e2e2';
			break;
		}
	}
	
	function ftp_postcomm2_change(num) {
		var name = 'FTP_POSTCOMM2' + num;
		name = document.getElementsByName(name);
		
		var ftp_postparam21 = "document.frm1.FTP_POSTPARAM21" + num;
		ftp_postparam21 = eval(ftp_postparam21);

		var ftp_postparam22 = "document.frm1.FTP_POSTPARAM22" + num;
		ftp_postparam22 = eval(ftp_postparam22);
		
		switch (name[0].value) {
		case "chmod":
		case "rename":
			ftp_postparam21.disabled = false;
			ftp_postparam21.style.backgroundColor = 'white';
			ftp_postparam22.disabled = false;
			ftp_postparam22.style.backgroundColor = 'white';
			break;
		case "mkdir":
		case "rm":
		case "rmdir":
			ftp_postparam21.disabled = false;
			ftp_postparam21.style.backgroundColor = 'white';
			ftp_postparam22.disabled = true;
			ftp_postparam22.value = '';
			ftp_postparam22.style.backgroundColor = '#e2e2e2';
			break;
		default:
			ftp_postparam21.disabled = true;
			ftp_postparam21.value = '';
			ftp_postparam21.style.backgroundColor = '#e2e2e2';
			ftp_postparam22.disabled = true;
			ftp_postparam22.value = '';
			ftp_postparam22.style.backgroundColor = '#e2e2e2';
			break;
		}
	}
	
	function recursive_check(num) {
		var frm = document.frm1;
		if(eval('frm.FTP_RECURSIVE' + num + '.checked') && eval('frm.FTP_EXCLUDE_WILDCARD' + num + '.checked')) {
			alert("please fix the following errors: \n --------------------------------- \n\n 1: Recursive transfer is not supported in exclude wildcard mode");
			eval('frm.FTP_RECURSIVE' + num + '.checked = false');
		}
	}
	function wildcard_check(num) {
		var frm = document.frm1;
		if(eval('frm.FTP_RECURSIVE' + num + '.checked') && eval('frm.FTP_EXCLUDE_WILDCARD' + num + '.checked')) {
			alert("please fix the following errors: \n --------------------------------- \n\n 1: Recursive transfer is not supported in exclude wildcard mode");
			eval('frm.FTP_EXCLUDE_WILDCARD' + num + '.checked = false');
		}
	}
	
	function goPrc(num) {

// 		isValid_C_M();
		
// 		if ( document.getElementById('is_valid_flag').value == "false" ) {
// 			document.getElementById('is_valid_flag').value = "";
// 			return;
// 		}
		var disabledcheck = eval("document.frm1.FTP_SRCOPT" + num + "[0].disabled");
		if(disabledcheck) {
			top.close();
		}

		//////////// 필수 값 확인
		if($('input:radio[name=FTP_SRCOPT' + num + ']:checked').val() > 1 && $('#FTP_NEWNAME' + num).val() == '') {
			alert("텍스트를 입력하세요");
			$('#FTP_NEWNAME' + num).focus();
			return;
		}
		if($('input:radio[name=FTP_DSTOPT' + num + ']:checked').val() > 0 && $('#FTP_DEST_NEWNAME' + num).val() == '') {
			alert("텍스트를 입력하세요");
			$('#FTP_DEST_NEWNAME' + num).focus();
			return;
		}
		if(document.getElementById('FTP_EMPTY_DEST_FILE_NAME_CHECKBOX' + num).checked == true && $('#FTP_EMPTY_DEST_FILE_NAME' + num).val() == '') {
			alert("텍스트를 입력하세요");
			$('#FTP_EMPTY_DEST_FILE_NAME' + num).focus();
			return;
		}
		if(document.getElementById('FTP_FILE_PFX_CHECKBOX' + num).checked == true && $('#FTP_FILE_PFX' + num).val() == ''){
			alert("텍스트를 입력하세요");
			$('#FTP_FILE_PFX' + num).focus();
			return;
		}
		
		for(var i=1; i < 3; i++) {
			var FTP_PRECOMM = '#FTP_PRECOMM' + i;
			var FTP_PREPARAM1 = '#FTP_PREPARAM' + i + 1;
			var FTP_PREPARAM2 = '#FTP_PREPARAM' + i + 2;
			

			var FTP_POSTCOMM = '#FTP_POSTCOMM' + i;
			var FTP_POSTPARAM1 = '#FTP_POSTPARAM' + i + 1;
			var FTP_POSTPARAM2 = '#FTP_POSTPARAM' + i + 2;
			
			switch ($(FTP_PRECOMM + num).val()) {
			case "":
				break;
			case "chmod":
			case "rename":
				if($(FTP_PREPARAM1 + num).val() == '') {
					alert("텍스트를 입력하세요");
					$(FTP_PREPARAM1 + num).focus();
					return;
				}
				if($(FTP_PREPARAM2 + num).val() == '') {
					alert("텍스트를 입력하세요");
					$(FTP_PREPARAM2 + num).focus();
					return;
				}
				break;
			default:
				if($(FTP_PREPARAM1 + num).val() == '') {
					alert("텍스트를 입력하세요");
					$(FTP_PREPARAM1 + num).focus();
					return;
				}
				break;
			}
			
			switch ($(FTP_POSTCOMM + num).val()) {
			case "":
				break;
			case "chmod":
			case "rename":
				if($(FTP_POSTPARAM1 + num).val() == '') {
					alert("텍스트를 입력하세요");
					$(FTP_POSTPARAM1 + num).focus();
					return;
				}
				if($(FTP_POSTPARAM2 + num).val() == '') {
					alert("텍스트를 입력하세요");
					$(FTP_POSTPARAM2 + num).focus();
					return;
				}
				break;
			default:
				if($(FTP_POSTPARAM1 + num).val() == '') {
					alert("텍스트를 입력하세요");
					$(FTP_POSTPARAM1 + num).focus();
					return;
				}
				break;
			}
		}
		
		//////////// end 필수 값 확인
		
		var list = new Array("FTP_SRCOPT", "FTP_NEWNAME", "FTP_SRC_ACT_FAIL", "FTP_IF_EXIST",
			"FTP_DSTOPT", "FTP_DEST_NEWNAME", "FTP_EMPTY_DEST_FILE_NAME",
			"FTP_FILE_PFX", "FTP_CONT_EXE", "FTP_DEL_DEST_ON_FAILURE",
			"FTP_POSTCMD_ON_FAILURE", "FTP_RECURSIVE", "FTP_ENCRYPTION1", "FTP_COMPRESSION1", "FTP_ENCRYPTION2", "FTP_COMPRESSION2",
			"FTP_PRESERVE_ATTR", "FTP_PRECOMM1", "FTP_PREPARAM11", "FTP_PREPARAM12", "FTP_POSTCOMM1",
			"FTP_POSTPARAM11", "FTP_POSTPARAM12", "FTP_PRECOMM2", "FTP_PREPARAM21", "FTP_PREPARAM22",
			"FTP_POSTCOMM2", "FTP_POSTPARAM21", "FTP_POSTPARAM22", "FTP_PGP_ENABLE", "FTP_PGP_TEMPLATE_NAME",
			"FTP_PGP_KEEP_FILES", "FTP_EXCLUDE_WILDCARD");

		var target = top.opener.document.getElementById('advanced');
 		for(var name in list) {
			var temp = "document.frm1." + list[name]  + num;
			if(eval(temp).checked == false && $('#' + list[name] + num).attr('type') != 'text') {
				$(target).attr(list[name], '');
			} else if($('input:radio[name=' + list[name] + num + ']').length > 0) {
				$(target).attr(list[name], $('input:radio[name=' + list[name] + num + ']:checked').val());
			} else {
	 			$(target).attr(list[name], eval(temp).value);
			}
		}
		top.opener.advanced_data(num, list);
		
		top.close();
	}
	
</script>

<style>
hr {
display : block;
}

select {
size	: 15px
}
</style>


</head>
<body>

<form id="frm1" name="frm1" method="post" onsubmit="return false;" enctype="multipart/form-data" >
<div class="content" >
	<div class="write_area" >
		<div class="board_area">
			<div class="tab_view blue">
				<ul>
					<li rid="0" class="current"><a style="cursor:pointer">General</a></li>
					<li rid="1" class=""><a style="cursor:pointer">SFTP Options</a></li>
					<li rid="2" class=""><a style="cursor:pointer">Commands</a></li>
				</ul>
			</div>
			
			<div class="detail_view">
			<table class="tLeft" style="border: 5px solid gray; border-style: double; width: 480px; height: 520px;">
				<caption>general</caption>
				<tbody>
				<tr>
					<td>
						&nbsp;
						After the completion of a sucessful file transfer the source file will be : <br /><br />
						&emsp;
						<input type="radio" name="FTP_SRCOPT<%=advanced_num%>"  value="0" onclick="ftp_srcopt_check('<%=advanced_num%>')" checked="checked">Left as is &emsp;
						<input type="radio" name="FTP_SRCOPT<%=advanced_num%>"  value="1" onclick="ftp_srcopt_check('<%=advanced_num%>')">Deleted &emsp;
						<input type="radio" name="FTP_SRCOPT<%=advanced_num%>"  value="2" onclick="ftp_srcopt_check('<%=advanced_num%>')">Renamed &emsp;
						<input type="radio" name="FTP_SRCOPT<%=advanced_num%>"  value="3" onclick="ftp_srcopt_check('<%=advanced_num%>')">Moved <br /><br />
						&nbsp;
						File name: <input class='input' type='text' id='FTP_NEWNAME<%=advanced_num%>' name='FTP_NEWNAME<%=advanced_num%>' style="width: 300px; background-color: #e2e2e2;" placeholder='(1-256 char)' disabled="disabled" />
						<br /><br />
						<label for='FTP_SRC_ACT_FAIL<%=advanced_num%>'><input type='checkbox' name='FTP_SRC_ACT_FAIL<%=advanced_num%>' id='FTP_SRC_ACT_FAIL<%=advanced_num%>' value='1' disabled="disabled" />FailTransferWhenSourceFailed</label>
						<br /><br /><hr /> 
					</td>
				</tr>
				<tr>
					<td>
						&nbsp;
						If a file of the same name as the destination file already exists : <br /><br />
						&emsp;
						<input type="radio" name="FTP_IF_EXIST<%=advanced_num%>" value="0" onclick="ftp_if_exist_check('<%=advanced_num%>')" checked="checked">Overwrite &emsp;
						<input type="radio" name="FTP_IF_EXIST<%=advanced_num%>" value="1" onclick="ftp_if_exist_check('<%=advanced_num%>')">Append &emsp;
						<input type="radio" name="FTP_IF_EXIST<%=advanced_num%>" value="2" onclick="ftp_if_exist_check('<%=advanced_num%>')">Abort &emsp;
						<input type="radio" name="FTP_IF_EXIST<%=advanced_num%>" value="3" onclick="ftp_if_exist_check('<%=advanced_num%>')">Skip
						<br /><br /><hr /> 
					</td>
				</tr>
				<tr>
					<td>
						&nbsp;
						After the completion of a successful file transfer the destination file will be : <br /><br />
						&emsp;
						<input type="radio" name="FTP_DSTOPT<%=advanced_num%>" value="0" onclick="ftp_dstopt_check('<%=advanced_num%>')" checked="checked">Left as is &emsp;
						<input type="radio" name="FTP_DSTOPT<%=advanced_num%>" value="1" onclick="ftp_dstopt_check('<%=advanced_num%>')">Renamed &emsp;
						<input type="radio" name="FTP_DSTOPT<%=advanced_num%>" value="2" onclick="ftp_dstopt_check('<%=advanced_num%>')">Moved
						<br /><br />
						&nbsp;
						File name: <input class='input' type='text' id='FTP_DEST_NEWNAME<%=advanced_num%>' name='FTP_DEST_NEWNAME<%=advanced_num%>' value='' style="width: 300px" disabled="disabled"/>
						<br /><br /><hr />
					</td>
				</tr>
				<tr>
					<td>
						&nbsp;
						<label for='FTP_EMPTY_DEST_FILE_NAME_CHECKBOX<%=advanced_num%>'><input type='checkbox' name='FTP_EMPTY_DEST_FILE_NAME_CHECKBOX<%=advanced_num%>' id='FTP_EMPTY_DEST_FILE_NAME_CHECKBOX<%=advanced_num%>' value='1' onclick="ftp_empty_dest_file_name_check('<%=advanced_num%>')" /> Create Empty File</label>
						&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&nbsp;
						<input class='input' type='text' id='FTP_EMPTY_DEST_FILE_NAME<%=advanced_num%>' name='FTP_EMPTY_DEST_FILE_NAME<%=advanced_num%>' style="width: 200px;" placeholder='(File name)' disabled="disabled"/>
						<br /><br />
						
						&nbsp;
						<label for='FTP_FILE_PFX_CHECKBOX<%=advanced_num%>'><input type='checkbox' name='FTP_FILE_PFX_CHECKBOX<%=advanced_num%>' id='FTP_FILE_PFX_CHECKBOX<%=advanced_num%>' value='1'  onclick="ftp_file_pfx_check('<%=advanced_num%>')" /> Use temporary file prefix</label>
						&emsp;&emsp;&emsp;&nbsp;
						<input class='input' type='text' id='FTP_FILE_PFX<%=advanced_num%>' name='FTP_FILE_PFX<%=advanced_num%>' style="width: 200px;" placeholder='(Temporary file prefix 99 char)' disabled="disabled"/>
						<br /><br />
						
						&nbsp;
						<label for='FTP_CONT_EXE<%=advanced_num%>'><input type='checkbox' name='FTP_CONT_EXE<%=advanced_num%>' id='FTP_CONT_EXE<%=advanced_num%>' value='1' /> Continue on failure</label>
						&emsp;&emsp;&emsp;&emsp;&emsp;&nbsp;&nbsp;
						<label for='FTP_POSTCMD_ON_FAILURE<%=advanced_num%>'><input type='checkbox' name='FTP_POSTCMD_ON_FAILURE<%=advanced_num%>' id='FTP_POSTCMD_ON_FAILURE<%=advanced_num%>' value='1' /> Do post AFT command on failure</label>
						<br /><br />
						
						&nbsp;
						<label for='FTP_DEL_DEST_ON_FAILURE<%=advanced_num%>'><input type='checkbox' name='FTP_DEL_DEST_ON_FAILURE<%=advanced_num%>' id='FTP_DEL_DEST_ON_FAILURE<%=advanced_num%>' value='1' /> Delete Destination file on failure</label>
						<br /><br />
						
						&nbsp;
						<label for='FTP_RECURSIVE<%=advanced_num%>'><input type='checkbox' name='FTP_RECURSIVE<%=advanced_num%>' id='FTP_RECURSIVE<%=advanced_num%>' value='1'  onclick="recursive_check('<%=advanced_num%>')" /> Recursive: (directory will be transferred with all its sub-directories.)</label>
						<br /><br />
						
						&nbsp;
						<label for='FTP_EXCLUDE_WILDCARD<%=advanced_num%>'><input type='checkbox' name='FTP_EXCLUDE_WILDCARD<%=advanced_num%>' id='FTP_EXCLUDE_WILDCARD<%=advanced_num%>' value='1'  onclick="wildcard_check('<%=advanced_num%>')" /> Exclude files: (Files will be transferred if not match the pattern.)</label>
					</td>
				</tr>
				
				</tbody>
			</table>
			</div>
			<!-- //general -->
			
						<!-- sftp -->
			<div class="detail_view" style="display:none;">
			<table class="tLeft" style="border: 5px solid gray; border-style: double; width: 500px; height: 200px;">
				<caption>SFTP Options</caption>
				<tbody>
				<tr>
					<td>
						&nbsp;
						Security Option <%=FTP_LHOST%> :<br /><br />
						&nbsp;
						Encryption Algorithm:
						<select name="FTP_ENCRYPTION1<%=advanced_num%>" id="FTP_ENCRYPTION1<%=advanced_num%>">
							<option value="">Use Default</option>
							<option value="3DES">3DES</option>
							<option value="AES">AES</option>
							<option value="Afcfour">Afcfour</option>
							<option value="Blowfish">Blowfish</option>
							<option value="DES">DES</option>
						</select>&nbsp;
						<br />&nbsp;
						Compression:
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<select name="FTP_COMPRESSION1<%=advanced_num%>" id="FTP_COMPRESSION1<%=advanced_num%>" style="margin-left:1px;">
							<option value="">Use Default</option>
							<option value="No">No</option>
							<option value="Yes">Yes</option>
						</select>&nbsp;
						<br /><br />
						&nbsp;
						Security Option <%=FTP_RHOST%> :<br />
						&nbsp;
						Encryption Algorithm: 
						<select name="FTP_ENCRYPTION2<%=advanced_num%>" id="FTP_ENCRYPTION2<%=advanced_num%>">
							<option value="">Use Default</option>
							<option value="3DES">3DES</option>
							<option value="AES">AES</option>
							<option value="Afcfour">Afcfour</option>
							<option value="Blowfish">Blowfish</option>
							<option value="DES">DES</option>
						</select>&nbsp;
						<br />&nbsp;
						Compression:
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<select name="FTP_COMPRESSION2<%=advanced_num%>" id="FTP_COMPRESSION2<%=advanced_num%>" style="margin-left:1px;">
							<option value="">Use Default</option>
							<option value="No">No</option>
							<option value="Yes">Yes</option>
						</select>&nbsp;
						<br /><br />
						&nbsp;
						<label for='FTP_PRESERVE_ATTR<%=advanced_num%>'><input type='checkbox' name='FTP_PRESERVE_ATTR<%=advanced_num%>' id='FTP_PRESERVE_ATTR<%=advanced_num%>' value='1' /> Preserve the File Attributes and Timestamps</label>
					</td>
				</tr>
				</tbody>
			</table>
			</div>
		<!-- //sftp -->
		
		
		<!-- commands -->
			<div class="detail_view" style="display:none;">
			<table class="tLeft" style="border: 5px solid gray; border-style: double; width: 500px; height: 450px;">
				<caption>Command</caption>
				<tbody>
				<tr>
					<td>
						&nbsp;
						Commands HOST1:	<%=FTP_LHOST %>				
						<br /><br />
						&nbsp;
						FTP Pre Command:&nbsp;
						<select name="FTP_PRECOMM1<%=advanced_num%>" id="FTP_PRECOMM1<%=advanced_num%>" onchange="ftp_precomm1_change('<%=advanced_num%>')">
							<option value=""></option>
							<option value="chmod">chmod</option>
							<option value="mkdir">mkdir</option>
							<option value="rename">rename</option>
							<option value="rm">rm</option>
							<option value="rmdir">rmdir</option>
						</select>&nbsp;
						<input class='input' type='text' id='FTP_PREPARAM11<%=advanced_num%>' name='FTP_PREPARAM11<%=advanced_num%>' disabled="disabled"/>
						&nbsp;
						<input class='input' type='text' id='FTP_PREPARAM12<%=advanced_num%>' name='FTP_PREPARAM12<%=advanced_num%>' disabled="disabled"/>
						<br /><br />
						&nbsp;
						FTP Post Command:
						<select name="FTP_POSTCOMM1<%=advanced_num%>" id="FTP_POSTCOMM1<%=advanced_num%>" onchange="ftp_postcomm1_change('<%=advanced_num%>')">
							<option value=""></option>
							<option value="chmod">chmod</option>
							<option value="mkdir">mkdir</option>
							<option value="rename">rename</option>
							<option value="rm">rm</option>
							<option value="rmdir">rmdir</option>
						</select>&nbsp;
						<input class='input' type='text' id='FTP_POSTPARAM11<%=advanced_num%>' name='FTP_POSTPARAM11<%=advanced_num%>' disabled="disabled"/>
						&nbsp;
						<input class='input' type='text' id='FTP_POSTPARAM12<%=advanced_num%>' name='FTP_POSTPARAM12<%=advanced_num%>' disabled="disabled"/>
						<br /><br /><hr /><hr />
					</td>
				</tr>
				<tr>
					<td>
						&nbsp;
						Commands HOST2:	<%=FTP_RHOST %>
						<br /><br />
						&nbsp;
						FTP Pre Command:&nbsp;
						<select name="FTP_PRECOMM2<%=advanced_num%>" id="FTP_PRECOMM2<%=advanced_num%>" onchange="ftp_precomm2_change('<%=advanced_num%>')">
							<option value=""></option>
							<option value="chmod">chmod</option>
							<option value="mkdir">mkdir</option>
							<option value="rename">rename</option>
							<option value="rm">rm</option>
							<option value="rmdir">rmdir</option>
						</select>&nbsp;
						<input class='input' type='text' id='FTP_PREPARAM21<%=advanced_num%>' name='FTP_PREPARAM21<%=advanced_num%>' disabled="disabled"/>
						&nbsp;
						<input class='input' type='text' id='FTP_PREPARAM22<%=advanced_num%>' name='FTP_PREPARAM22<%=advanced_num%>' disabled="disabled"/>
						<br /><br />
						&nbsp;
						FTP Post Command:
						<select name="FTP_POSTCOMM2<%=advanced_num%>" id="FTP_POSTCOMM2<%=advanced_num%>" onchange="ftp_postcomm2_change('<%=advanced_num%>')">
							<option value=""></option>
							<option value="chmod">chmod</option>
							<option value="mkdir">mkdir</option>
							<option value="rename">rename</option>
							<option value="rm">rm</option>
							<option value="rmdir">rmdir</option>
						</select>&nbsp;
						<input class='input' type='text' id='FTP_POSTPARAM21<%=advanced_num%>' name='FTP_POSTPARAM21<%=advanced_num%>' disabled="disabled"/>
						&nbsp;
						<input class='input' type='text' id='FTP_POSTPARAM22<%=advanced_num%>' name='FTP_POSTPARAM22<%=advanced_num%>' disabled="disabled"/>
						<br /><br /><hr /><hr />
					</td>
				</tr>
				<%
				if(FTP_CONNTYPE1.equals("1") && FTP_CONNTYPE2.equals("1")) {
				%>
				<tr>
					<td>
						&nbsp;
						<label for='FTP_PGP_ENABLE<%=advanced_num%>'><input type='checkbox' name='FTP_PGP_ENABLE<%=advanced_num%>' id='FTP_PGP_ENABLE<%=advanced_num%>' value='1' onclick="ftp_pgp_enable_check('<%=advanced_num%>')"/>
						Enable PGP encryption</label>
						<br /><br />
						&nbsp;
						Template Name: <input class='input' type='text' id='FTP_PGP_TEMPLATE_NAME<%=advanced_num%>' name='FTP_PGP_TEMPLATE_NAME<%=advanced_num%>' />
						<br /><br />
						&nbsp;
						<label for='FTP_PGP_KEEP_FILES<%=advanced_num%>'><input type='checkbox' name='FTP_PGP_KEEP_FILES<%=advanced_num%>' id='FTP_PGP_KEEP_FILES<%=advanced_num%>' value='1' />
						Keep encrypted files</label>
					</td>
				</tr>
				<%
				} else {
				%>
					<input type="hidden" id="FTP_PGP_ENABLE<%=advanced_num%>" name="FTP_PGP_ENABLE<%=advanced_num%>" />
					<input type="hidden" id="FTP_PGP_TEMPLATE_NAME<%=advanced_num%>" name="FTP_PGP_TEMPLATE_NAME<%=advanced_num%>" />
					<input type="hidden" id="FTP_PGP_KEEP_FILES<%=advanced_num%>" name="FTP_PGP_KEEP_FILES<%=advanced_num%>" />
				<%	
				}
				%>
				</tbody>
			</table>
			</div>
			
			<div style='clear:both;text-align:right;padding:12px 10px 0px 0px;' >
				<a  class="btn_white_h24" 	href="Javascript:goPrc('<%=advanced_num%>');" >OK</a>
				<a  class="btn_white_h24" 	href="Javascript:top.close();" >CANCEL</a>
			</div>
		</div>
	</div>
</div>
		<!-- //commands -->
</form>

<script type="text/javascript">
	$(".tab_view li").click(function(){
		$('.tab_view li').removeClass('current');
		$(this).addClass('current');

		$('.detail_view').css("display","none");
		var thumImg = $(this).attr("rid");
		$('.detail_view:eq('+(thumImg)+')').css("display","block");
	});
</script>

</body>
</html>