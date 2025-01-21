<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.ghayoun.ezjobs.t.domain.*" %>

<%@include file="/jsp/common/inc/header.jsp"%>
<%@include file="/jsp/common/inc/sessionChkPopup.jsp"%>

<%
	Map<String, Object> paramMap = CommonUtil.collectParameters(request);
	
	CommonBean bean				= (CommonBean)request.getAttribute("docUserInfo");	
	
	String strUser_cd_1         = CommonUtil.isNull(bean.getUser_cd_1());
	String strUser_id_1         = CommonUtil.isNull(bean.getUser_id_1());
	String strUser_nm_1         = CommonUtil.isNull(bean.getUser_nm_1());
	String strDuty_nm_1         = CommonUtil.isNull(bean.getDuty_nm_1());
	String strDept_nm_1         = CommonUtil.isNull(bean.getDept_nm_1());
	String strUser_tel_1        = CommonUtil.isNull(bean.getUser_tel_1());
	String strUser_hp_1         = CommonUtil.isNull(bean.getUser_hp_1());
	String strUser_email_1      = CommonUtil.isNull(bean.getUser_email_1());
	
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
</head>

<body style="background:#fff;">

<form id="frm1" name="frm1" method="post" onsubmit="return false;">

<table style='width:100%;height:100%;border:none;'>

	<tr>
		<td colspan="6">
			<div class='cellTitle_kang'>의뢰자 정보</div>
		</td>
	</tr>
	<tr>
		<td valign="top">
			<tr>
				<td style="width:10%">
					<div class='cellTitle_kang2'>아이디</div>
				</td>
				
				<td style="width:25%">
					<div class='cellContent_kang'>
						<%=strUser_id_1 %>
					</div>
				</td>
				
				<td style="width:10%">
					<div class='cellTitle_kang2'>이 름</div>
				</td>
				
				<td style="width:25%">
					<div class='cellContent_kang'>
						<%=strUser_nm_1 %>
					</div>
				</td>
				<td style="width:10%">
					<div class='cellTitle_kang2'>직 책</div>
				</td>
				
				<td style="width:25%">
					<div class='cellContent_kang'>
						<%=strDuty_nm_1 %>
					</div>
				</td>
			</tr>
			<tr>
				<td style="width:10%">
					<div class='cellTitle_kang2'>부 서</div>
				</td>
				<td style="width:25%">
					<div class='cellContent_kang'>
						<%=strDept_nm_1 %>
					</div>
				</td>
				
				<td style="width:10%">
					<div class='cellTitle_kang2'>내선번호</div>
				</td>
				
				<td style="width:25%">
					<div class='cellContent_kang'>
						<%=strUser_tel_1 %>
					</div>
				</td>
				<td style="width:10%">
					<div class='cellTitle_kang2'>휴대폰번호</div>
				</td>
				
				<td style="width:25%">
					<div class='cellContent_kang'>
						<%=strUser_hp_1 %>
					</div>
				</td>
			</tr>
			<tr>
				<td style="width:10%">
					<div class='cellTitle_kang2'>이메일</div>
				</td>
				<td style="width:25%" colspan="7">
					<div class='cellContent_kang'>
						<%=strUser_email_1 %>
					</div>
				</td>
			</tr>
		</td>
	</tr>
</table>
</form>
</body>
</html>