﻿<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.ghayoun.ezjobs.t.domain.*" %>

<%@include file="/jsp/common/inc/header.jsp"%>
<%@include file="/jsp/common/inc/sessionChkPopup.jsp"%>

<%
	Map<String, Object> paramMap = CommonUtil.collectParameters(request);
	List userInfoList			= (List)request.getAttribute("approvalUserList");
	
	String strApprovalGubun 	= CommonUtil.isNull(paramMap.get("approvalGubun"));
	String strSeq 				= CommonUtil.isNull(paramMap.get("apprSeq"));
	String strDoc_cd 			= CommonUtil.isNull(paramMap.get("doc_cd"));
	String strApprCd			= CommonUtil.isNull(paramMap.get("approval_cd_1"));
	
	String strUser_cd 			= 	"";
	String strUser_id 			= 	"";
	String strUser_nm 			= 	"";
	String strUser_dept 		= 	"";
	String strUser_duty 		= 	"";
	String strUser_tel 			= 	"";
	String strUser_hp 			= 	"";
	String strUser_email 		= 	"";
	String strGroup_line_grp_cd = 	"";
	String strGroup_line_cd		= 	"";
	String strApproval_cd		= 	"";
	String strApproval_seq		= 	"";
	
	//js version 추가하여 캐시 새로고침
	String jsVersion 			= CommonUtil.getMessage("js_version");
%>

<!DOCTYPE html>

<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>EzJOBs 통합배치모니터링 시스템</title>
<link rel="stylesheet" href="<%=sContextPath %>/css/css.css" type="text/css">
<link href="<%=request.getContextPath() %>/css/common.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath() %>/css/custom-theme/jquery-ui.custom.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath() %>/css/custom-theme/jquery-ui.works.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath() %>/css/layout-default.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath() %>/css/ftree/ui.fancytree.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath() %>/js/SlickGrid-2.1.0/slick.grid.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath() %>/js/SlickGrid-2.1.0/css/select2.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath() %>/css/slick-default-theme.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath() %>/js/poshytip-1.2/tip.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="<%=request.getContextPath() %>/js/common.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/cookie.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/popup.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/xhrHandler.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.min.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery-ui.custom.min.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.resizeEnd.js" ></script>
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
<script type="text/javascript" src="<%=request.getContextPath() %>/js/SlickGrid-2.1.0/plugins/select2.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/SlickGrid-2.1.0/slick.dataview.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/SlickGrid-2.1.0/slick.grid.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/SlickGrid-2.1.0/slick.editors.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/poshytip-1.2/jquery.poshytip.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/works_common.js?v=<%=jsVersion %>" ></script>

<style type="text/css">
	.hover { background-color:#e2f4f8; }
</style>
<script type="text/javascript" >
$(document).ready(function(){
	var s_user_cd = "<%=S_USER_CD%>";
	$("#user_nm").unbind("click").click(function(){
		goApprovalUserSearch("1", s_user_cd);
	});
	
	$("#btn_udt").button().unbind("click").click(function(){
		goPrc();
	});

});

function goPrc(){
	
	var frm1 = document.frm1;
	var user_nm = $("#user_nm").val();
	
	if(user_nm == ""){
		alert("결재자를 선택해주세요.");
		return;
	}	

	if( !confirm("["+user_nm+"](으)로 결재자를 변경 하시겠습니까?") ) return;
	
	try{viewProgBar(true);}catch(e){}
	
	frm1.target = "if1";
	frm1.action = "<%=sContextPath%>/tWorks.ez?c=ez032_p";
	frm1.submit();
	window.close();
}
</script>

<script type="text/javascript" >
<!--
	
//-->
</script>

</head>
<body style="background:#fff;">

<form id="frm1" name="frm1" method="post" onsubmit="return false;">
	<input type="hidden" name="popup" 			value="popup"/>
	
	<input type="hidden" 	 name="doc_cd" 	 value="<%=strDoc_cd  %>"		/>
	<input type="hidden"	 name="seq" 	 value="<%=strSeq %>"	/>
	<input type="hidden" 	name="num" 			/>
	<input type="hidden" 	name="gubun" 			/>
	<input type="hidden" 	name="arg" 			/>
	<input type="hidden" 	name="s_dept_cd" 		/>
<% 
	if(strApprCd.equals("01")){	
%>

<div>
	<h4 class="ui-widget-header ui-corner-all" style="text-align:right; padding-right:5px; padding-bottom:5px;" >
			<span>결재자 :</span> 
			<input type='text' name='user_nm' id='user_nm' style='width:15%;height:20px;' readonly/>
			<input type='hidden' name='user_cd' id='user_cd' />&nbsp;<span id='btn_udt'>변경</span>
	</h4>
</div>
<%
	}
%>
<table style='width:100%;height:100%;border:none;'>
	<%for( int i=0; null!=userInfoList && i<userInfoList.size(); i++ ) {
		CommonBean bean = (CommonBean)userInfoList.get(i);
		strUser_cd 			         = CommonUtil.isNull(bean.getUser_cd());
		strUser_id 			         = CommonUtil.isNull(bean.getUser_id());
		strUser_nm 			         = CommonUtil.isNull(bean.getUser_nm());
		strUser_dept 		         = CommonUtil.isNull(bean.getDept_nm());
		strUser_duty 		         = CommonUtil.isNull(bean.getDuty_nm());
		strUser_tel 			     = CommonUtil.isNull(bean.getUser_tel());
		strUser_hp 			         = CommonUtil.isNull(bean.getUser_hp());
		strUser_email 		         = CommonUtil.isNull(bean.getUser_email());
		strGroup_line_grp_cd         = CommonUtil.isNull(bean.getGroup_line_grp_cd());
		strGroup_line_cd		     = CommonUtil.isNull(bean.getGroup_line_cd());
		strApproval_cd		         = CommonUtil.isNull(bean.getApproval_cd());
		strApproval_seq		         = CommonUtil.isNull(bean.getApproval_seq());
	%>
	
	<tr>
		<td colspan="6">
			<div class='cellTitle_kang'>결재자 정보<%=i+1 %></div>
		</td>

	</tr>
	<tr>
		<td valign="top">
			<tr>
				<td style="width:10%">
					<div class='cellTitle_kang2'>사용자 ID</div>
				</td>
				
				<td style="width:25%">
					<div class='cellContent_kang'>
						<%=strUser_id %>
					</div>
				</td>
				
				<td style="width:10%">
					<div class='cellTitle_kang2'>이 름</div>
				</td>
				
				<td style="width:25%">
					<div class='cellContent_kang'>
						<%=strUser_nm %>
					</div>
				</td>
				<td style="width:10%">
					<div class='cellTitle_kang2'>직 책</div>
				</td>
				
				<td style="width:25%">
					<div class='cellContent_kang'>
						<%=strUser_duty %>
					</div>
				</td>
			</tr>
			<tr>
				<td style="width:10%">
					<div class='cellTitle_kang2'>부 서</div>
				</td>
				<td style="width:25%">
					<div class='cellContent_kang'>
						<%=strUser_dept %>
					</div>
				</td>
				
				<td style="width:10%">
					<div class='cellTitle_kang2'>내선번호</div>
				</td>
				
				<td style="width:25%">
					<div class='cellContent_kang'>
						<%=strUser_tel %>
					</div>
				</td>
				<td style="width:10%">
					<div class='cellTitle_kang2'>휴대폰번호</div>
				</td>
				
				<td style="width:25%">
					<div class='cellContent_kang'>
						<%=strUser_hp %>
					</div>
				</td>
			</tr>
			<tr>
				<td style="width:10%">
					<div class='cellTitle_kang2'>이메일</div>
				</td>
				<td style="width:25%" colspan="7">
					<div class='cellContent_kang'>
						<%=strUser_email %>
					</div>
				</td>
			</tr>
		</td>
	</tr>
	<%
	}
	%>	
</table>
</form>
</body>
</html>