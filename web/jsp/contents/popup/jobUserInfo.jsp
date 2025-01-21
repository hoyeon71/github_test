<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.ghayoun.ezjobs.t.domain.*" %>

<%@include file="/jsp/common/inc/header.jsp"%>
<%@include file="/jsp/common/inc/sessionChkPopup.jsp"%>

<%
	Map<String, Object> paramMap 	= CommonUtil.collectParameters(request);

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
	
	CommonBean bean					= (CommonBean)request.getAttribute("jobUserInfo");

	String strSeq 					= CommonUtil.isNull(paramMap.get("apprSeq"));
	String strDoc_cd 				= CommonUtil.isNull(paramMap.get("doc_cd"));
	String strApprCd				= CommonUtil.isNull(paramMap.get("approval_cd_1"));

	String strUser_cd_1            = CommonUtil.isNull(bean.getUser_cd_1());
	String strUser_id_1            = CommonUtil.isNull(bean.getUser_id_1());
	String strUser_nm_1            = CommonUtil.isNull(bean.getUser_nm_1());
	String strDuty_nm_1            = CommonUtil.isNull(bean.getDuty_nm_1());
	String strDept_nm_1            = CommonUtil.isNull(bean.getDept_nm_1());
	String strUser_tel_1           = CommonUtil.isNull(bean.getUser_tel_1());
	String strUser_hp_1            = CommonUtil.isNull(bean.getUser_hp_1());
	String strUser_email_1         = CommonUtil.isNull(bean.getUser_email_1());
	String strSms_1                = CommonUtil.isNull(bean.getSms_1());
	String strMail_1               = CommonUtil.isNull(bean.getMail_1());
	if(!strDept_nm_1.equals("")){
		strDept_nm_1 += "["+strDuty_nm_1+"]";
	}
	String strUser_cd_2            = CommonUtil.isNull(bean.getUser_cd_2());
	String strUser_id_2            = CommonUtil.isNull(bean.getUser_id_2());
	String strUser_nm_2            = CommonUtil.isNull(bean.getUser_nm_2());
	String strDuty_nm_2            = CommonUtil.isNull(bean.getDuty_nm_2());
	String strDept_nm_2            = CommonUtil.isNull(bean.getDept_nm_2());
	String strUser_tel_2           = CommonUtil.isNull(bean.getUser_tel_2());
	String strUser_hp_2            = CommonUtil.isNull(bean.getUser_hp_2());
	String strUser_email_2         = CommonUtil.isNull(bean.getUser_email_2());
	String strSms_2                = CommonUtil.isNull(bean.getSms_2());
	String strMail_2               = CommonUtil.isNull(bean.getMail_2());

	String strUser_cd_3            = CommonUtil.isNull(bean.getUser_cd_3());
	String strUser_id_3            = CommonUtil.isNull(bean.getUser_id_3());
	String strUser_nm_3            = CommonUtil.isNull(bean.getUser_nm_3());
	String strDuty_nm_3            = CommonUtil.isNull(bean.getDuty_nm_3());
	String strDept_nm_3            = CommonUtil.isNull(bean.getDept_nm_3());
	String strUser_tel_3           = CommonUtil.isNull(bean.getUser_tel_3());
	String strUser_hp_3            = CommonUtil.isNull(bean.getUser_hp_3());
	String strUser_email_3         = CommonUtil.isNull(bean.getUser_email_3());
	String strSms_3                = CommonUtil.isNull(bean.getSms_3());
	String strMail_3               = CommonUtil.isNull(bean.getMail_3());

	String strUser_cd_4            = CommonUtil.isNull(bean.getUser_cd_4());
	String strUser_id_4            = CommonUtil.isNull(bean.getUser_id_4());
	String strUser_nm_4            = CommonUtil.isNull(bean.getUser_nm_4());
	String strDuty_nm_4            = CommonUtil.isNull(bean.getDuty_nm_4());
	String strDept_nm_4            = CommonUtil.isNull(bean.getDept_nm_4());
	String strUser_tel_4           = CommonUtil.isNull(bean.getUser_tel_4());
	String strUser_hp_4            = CommonUtil.isNull(bean.getUser_hp_4());
	String strUser_email_4         = CommonUtil.isNull(bean.getUser_email_4());
	String strSms_4                = CommonUtil.isNull(bean.getSms_4());
	String strMail_4               = CommonUtil.isNull(bean.getMail_4());

	String strUser_cd_5            = CommonUtil.isNull(bean.getUser_cd_5());
	String strUser_id_5            = CommonUtil.isNull(bean.getUser_id_5());
	String strUser_nm_5            = CommonUtil.isNull(bean.getUser_nm_5());
	String strDuty_nm_5            = CommonUtil.isNull(bean.getDuty_nm_5());
	String strDept_nm_5            = CommonUtil.isNull(bean.getDept_nm_5());
	String strUser_tel_5           = CommonUtil.isNull(bean.getUser_tel_5());
	String strUser_hp_5            = CommonUtil.isNull(bean.getUser_hp_5());
	String strUser_email_5         = CommonUtil.isNull(bean.getUser_email_5());
	String strSms_5                = CommonUtil.isNull(bean.getSms_5());
	String strMail_5               = CommonUtil.isNull(bean.getMail_5());

	String strUser_cd_6            = CommonUtil.isNull(bean.getUser_cd_6());
	String strUser_id_6            = CommonUtil.isNull(bean.getUser_id_6());
	String strUser_nm_6            = CommonUtil.isNull(bean.getUser_nm_6());
	String strDuty_nm_6            = CommonUtil.isNull(bean.getDuty_nm_6());
	String strDept_nm_6            = CommonUtil.isNull(bean.getDept_nm_6());
	String strUser_tel_6           = CommonUtil.isNull(bean.getUser_tel_6());
	String strUser_hp_6            = CommonUtil.isNull(bean.getUser_hp_6());
	String strUser_email_6         = CommonUtil.isNull(bean.getUser_email_6());
	String strSms_6                = CommonUtil.isNull(bean.getSms_6());
	String strMail_6               = CommonUtil.isNull(bean.getMail_6());

	String strUser_cd_7            = CommonUtil.isNull(bean.getUser_cd_7());
	String strUser_id_7            = CommonUtil.isNull(bean.getUser_id_7());
	String strUser_nm_7            = CommonUtil.isNull(bean.getUser_nm_7());
	String strDuty_nm_7            = CommonUtil.isNull(bean.getDuty_nm_7());
	String strDept_nm_7            = CommonUtil.isNull(bean.getDept_nm_7());
	String strUser_tel_7           = CommonUtil.isNull(bean.getUser_tel_7());
	String strUser_hp_7            = CommonUtil.isNull(bean.getUser_hp_7());
	String strUser_email_7         = CommonUtil.isNull(bean.getUser_email_7());
	String strSms_7                = CommonUtil.isNull(bean.getSms_7());
	String strMail_7               = CommonUtil.isNull(bean.getMail_7());

	String strUser_cd_8            = CommonUtil.isNull(bean.getUser_cd_8());
	String strUser_id_8            = CommonUtil.isNull(bean.getUser_id_8());
	String strUser_nm_8            = CommonUtil.isNull(bean.getUser_nm_8());
	String strDuty_nm_8            = CommonUtil.isNull(bean.getDuty_nm_8());
	String strDept_nm_8            = CommonUtil.isNull(bean.getDept_nm_8());
	String strUser_tel_8           = CommonUtil.isNull(bean.getUser_tel_8());
	String strUser_hp_8            = CommonUtil.isNull(bean.getUser_hp_8());
	String strUser_email_8         = CommonUtil.isNull(bean.getUser_email_8());
	String strSms_8                = CommonUtil.isNull(bean.getSms_8());
	String strMail_8               = CommonUtil.isNull(bean.getMail_8());

	String strUser_cd_9            = CommonUtil.isNull(bean.getUser_cd_9());
	String strUser_id_9            = CommonUtil.isNull(bean.getUser_id_9());
	String strUser_nm_9            = CommonUtil.isNull(bean.getUser_nm_9());
	String strDuty_nm_9            = CommonUtil.isNull(bean.getDuty_nm_9());
	String strDept_nm_9            = CommonUtil.isNull(bean.getDept_nm_9());
	String strUser_tel_9           = CommonUtil.isNull(bean.getUser_tel_9());
	String strUser_hp_9            = CommonUtil.isNull(bean.getUser_hp_9());
	String strUser_email_9         = CommonUtil.isNull(bean.getUser_email_9());
	String strSms_9                = CommonUtil.isNull(bean.getSms_9());
	String strMail_9               = CommonUtil.isNull(bean.getMail_9());

	String strUser_cd_10            = CommonUtil.isNull(bean.getUser_cd_10());
	String strUser_id_10            = CommonUtil.isNull(bean.getUser_id_10());
	String strUser_nm_10            = CommonUtil.isNull(bean.getUser_nm_10());
	String strDuty_nm_10            = CommonUtil.isNull(bean.getDuty_nm_10());
	String strDept_nm_10            = CommonUtil.isNull(bean.getDept_nm_10());
	String strUser_tel_10           = CommonUtil.isNull(bean.getUser_tel_10());
	String strUser_hp_10            = CommonUtil.isNull(bean.getUser_hp_10());
	String strUser_email_10         = CommonUtil.isNull(bean.getUser_email_10());
	String strSms_10                = CommonUtil.isNull(bean.getSms_10());
	String strMail_10               = CommonUtil.isNull(bean.getMail_10());

	String strGrp_nm_1				= CommonUtil.isNull(bean.getGrp_nm_1());
	String strGrp_sms_1             = CommonUtil.isNull(bean.getGrp_sms_1());
	String strGrp_mail_1            = CommonUtil.isNull(bean.getGrp_mail_1());

	String strGrp_nm_2				= CommonUtil.isNull(bean.getGrp_nm_2());
	String strGrp_sms_2             = CommonUtil.isNull(bean.getGrp_sms_2());
	String strGrp_mail_2            = CommonUtil.isNull(bean.getGrp_mail_2());

	String strErrorDescription		= CommonUtil.isNull(bean.getError_description());
	
	//js version 추가하여 캐시 새로고침
	String jsVersion 				= CommonUtil.getMessage("js_version");
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
	<input type="hidden" name="popup" 			value="popup"/>

	<input type="hidden" 	 name="doc_cd" 	 value="<%=strDoc_cd  %>"		/>
	<input type="hidden"	 name="seq" 	 value="<%=strSeq %>"	/>
	<input type="hidden" 	name="num" 			/>
	<input type="hidden" 	name="gubun" 			/>
	<input type="hidden" 	name="arg" 			/>
	<table style='width:100%;height:100%;border:none;'>

		<tr>
			<td colspan="6">
				<div class='cellTitle_kang5'>담당자1 정보</div>
			</td>

		</tr>
		<tr>
			<td valign="top">
		<tr>
			<td style="width:10%">
				<div class='cellTitle_ez_right'>사용자 ID</div>
			</td>

			<td style="width:25%">
				<div class='cellContent_kang'>
					<%=strUser_id_1 %>
				</div>
			</td>

			<td style="width:10%">
				<div class='cellTitle_ez_right'>이 름</div>
			</td>

			<td style="width:25%">
				<div class='cellContent_kang'>
					<%=strUser_nm_1 %>
				</div>
			</td>
			<td style="width:10%">
				<div class='cellTitle_ez_right'>부 서[직 책]</div>
			</td>

			<td style="width:25%">
				<div class='cellContent_kang'>
					<%=strDept_nm_1 %>[<%=strDuty_nm_1 %>]
				</div>
			</td>
		</tr>
		<tr>
			<td style="width:10%">
				<div class='cellTitle_ez_right'>내선번호</div>
			</td>

			<td style="width:25%">
				<div class='cellContent_kang'>
					<%=strUser_tel_1 %>
				</div>
			</td>
			<td style="width:10%">
				<div class='cellTitle_ez_right'>휴대폰번호</div>
			</td>

			<td style="width:25%">
				<div class='cellContent_kang'>
					<%=strUser_hp_1 %>
				</div>
			</td>
			<td style="width:10%">
				<div class='cellTitle_ez_right'>이메일</div>
			</td>
			<td style="width:25%" colspan="7">
				<div class='cellContent_kang'>
					<%=strUser_email_1 %>
				</div>
			</td>
		</tr>
		<tr>
			<td style="width:10%">
				<div class='cellTitle_ez_right'><%=strSms%></div>
			</td>
			<td style="width:25%">
				<div class='cellContent_kang'>
					<%=strSms_1 %>
				</div>
			</td>

			<td style="width:10%">
				<div class='cellTitle_ez_right'><%=strMail%></div>
			</td>

			<td style="width:25%">
				<div class='cellContent_kang'>
					<%=strMail_1 %>
				</div>
			</td>
		</tr>
		</td>
		</tr>
		<tr>
			<td colspan="6">
				<div class='cellTitle_kang5'>담당자2 정보</div>
			</td>
		</tr>
		<tr>
			<td valign="top">
		<tr>
			<td style="width:10%">
				<div class='cellTitle_ez_right'>사용자 ID</div>
			</td>

			<td style="width:25%">
				<div class='cellContent_kang'>
					<%=strUser_id_2 %>
				</div>
			</td>

			<td style="width:10%">
				<div class='cellTitle_ez_right'>이 름</div>
			</td>

			<td style="width:25%">
				<div class='cellContent_kang'>
					<%=strUser_nm_2 %>
				</div>
			</td>
			<td style="width:10%">
				<div class='cellTitle_ez_right'>부 서[직 책]</div>
			</td>

			<td style="width:25%">
				<div class='cellContent_kang'>
					<%=strDept_nm_2 %>[<%=strDuty_nm_2 %>]
				</div>
			</td>
		</tr>
		<tr>
			<td style="width:10%">
				<div class='cellTitle_ez_right'>내선번호</div>
			</td>

			<td style="width:25%">
				<div class='cellContent_kang'>
					<%=strUser_tel_2 %>
				</div>
			</td>
			<td style="width:10%">
				<div class='cellTitle_ez_right'>휴대폰번호</div>
			</td>

			<td style="width:25%">
				<div class='cellContent_kang'>
					<%=strUser_hp_2 %>
				</div>
			</td>
			<td style="width:10%">
				<div class='cellTitle_ez_right'>이메일</div>
			</td>
			<td style="width:25%" colspan="7">
				<div class='cellContent_kang'>
					<%=strUser_email_2 %>
				</div>
			</td>
		</tr>
		<tr>
			<td style="width:10%">
				<div class='cellTitle_ez_right'><%=strSms%></div>
			</td>
			<td style="width:25%">
				<div class='cellContent_kang'>
					<%=strSms_2 %>
				</div>
			</td>

			<td style="width:10%">
				<div class='cellTitle_ez_right'><%=strMail%></div>
			</td>

			<td style="width:25%">
				<div class='cellContent_kang'>
					<%=strMail_2 %>
				</div>
			</td>
		</tr>
		</td>
		</tr>
		<tr>
			<td colspan="6">
				<div class='cellTitle_kang5'>담당자3 정보</div>
			</td>

		</tr>
		<tr>
			<td valign="top" >
		<tr>
			<td style="width:10%">
				<div class='cellTitle_ez_right'>사용자 ID</div>
			</td>

			<td style="width:25%">
				<div class='cellContent_kang'>
					<%=strUser_id_3 %>
				</div>
			</td>

			<td style="width:10%">
				<div class='cellTitle_ez_right'>이 름</div>
			</td>

			<td style="width:25%">
				<div class='cellContent_kang'>
					<%=strUser_nm_3 %>
				</div>
			</td>
			<td style="width:10%">
				<div class='cellTitle_ez_right'>부 서[직 책]</div>
			</td>

			<td style="width:25%">
				<div class='cellContent_kang'>
					<%=strDept_nm_3 %>[<%=strDuty_nm_3 %>]
				</div>
			</td>
		</tr>
		<tr>
			<td style="width:10%">
				<div class='cellTitle_ez_right'>내선번호</div>
			</td>

			<td style="width:25%">
				<div class='cellContent_kang'>
					<%=strUser_tel_3 %>
				</div>
			</td>
			<td style="width:10%">
				<div class='cellTitle_ez_right'>휴대폰번호</div>
			</td>

			<td style="width:25%">
				<div class='cellContent_kang'>
					<%=strUser_hp_3 %>
				</div>
			</td>
			<td style="width:10%">
				<div class='cellTitle_ez_right'>이메일</div>
			</td>
			<td style="width:25%" colspan="7">
				<div class='cellContent_kang'>
					<%=strUser_email_3 %>
				</div>
			</td>
		</tr>
		<tr>
			<td style="width:10%">
				<div class='cellTitle_ez_right'><%=strSms%></div>
			</td>
			<td style="width:25%">
				<div class='cellContent_kang'>
					<%=strSms_3 %>
				</div>
			</td>
			<td style="width:10%">
				<div class='cellTitle_ez_right'><%=strMail%></div>
			</td>
			<td style="width:25%">
				<div class='cellContent_kang'>
					<%=strMail_3 %>
				</div>
			</td>
		</tr>
		</td>
		</tr>
		<tr >
			<td colspan="6">
				<div class='cellTitle_kang5'>담당자4 정보</div>
			</td>
		</tr>
		<tr>
			<td valign="top">
		<tr>
			<td style="width:10%">
				<div class='cellTitle_ez_right'>사용자 ID</div>
			</td>

			<td style="width:25%">
				<div class='cellContent_kang'>
					<%=strUser_id_4 %>
				</div>
			</td>

			<td style="width:10%">
				<div class='cellTitle_ez_right'>이 름</div>
			</td>

			<td style="width:25%">
				<div class='cellContent_kang'>
					<%=strUser_nm_4 %>
				</div>
			</td>
			<td style="width:10%">
				<div class='cellTitle_ez_right'>부 서[직 책]</div>
			</td>

			<td style="width:25%">
				<div class='cellContent_kang'>
					<%=strDept_nm_4 %>[<%=strDuty_nm_4 %>]
				</div>
			</td>
		</tr>
		<tr>
			<td style="width:10%">
				<div class='cellTitle_ez_right'>내선번호</div>
			</td>

			<td style="width:25%">
				<div class='cellContent_kang'>
					<%=strUser_tel_4 %>
				</div>
			</td>
			<td style="width:10%">
				<div class='cellTitle_ez_right'>휴대폰번호</div>
			</td>

			<td style="width:25%">
				<div class='cellContent_kang'>
					<%=strUser_hp_4 %>
				</div>
			</td>
			<td style="width:10%">
				<div class='cellTitle_ez_right'>이메일</div>
			</td>
			<td style="width:25%" colspan="7">
				<div class='cellContent_kang'>
					<%=strUser_email_4 %>
				</div>
			</td>
		</tr>
		<tr>
			<td style="width:10%">
				<div class='cellTitle_ez_right'><%=strSms%></div>
			</td>
			<td style="width:25%">
				<div class='cellContent_kang'>
					<%=strSms_4 %>
				</div>
			</td>

			<td style="width:10%">
				<div class='cellTitle_ez_right'><%=strMail%></div>
			</td>

			<td style="width:25%">
				<div class='cellContent_kang'>
					<%=strMail_4 %>
				</div>
			</td>
		</tr>
		</td>
		</tr>
		<tr>
			<td colspan="6">
				<div class='cellTitle_kang5'>담당자5 정보</div>
			</td>
		</tr>
		<tr>
			<td valign="top">
		<tr>
			<td style="width:10%">
				<div class='cellTitle_ez_right'>사용자 ID</div>
			</td>

			<td style="width:25%">
				<div class='cellContent_kang'>
					<%=strUser_id_5 %>
				</div>
			</td>

			<td style="width:10%">
				<div class='cellTitle_ez_right'>이 름</div>
			</td>

			<td style="width:25%">
				<div class='cellContent_kang'>
					<%=strUser_nm_5 %>
				</div>
			</td>
			<td style="width:10%">
				<div class='cellTitle_ez_right'>부 서[직 책]</div>
			</td>

			<td style="width:25%">
				<div class='cellContent_kang'>
					<%=strDept_nm_5 %>[<%=strDuty_nm_5 %>]
				</div>
			</td>
		</tr>
		<tr>
			<td style="width:10%">
				<div class='cellTitle_ez_right'>내선번호</div>
			</td>

			<td style="width:25%">
				<div class='cellContent_kang'>
					<%=strUser_tel_5 %>
				</div>
			</td>
			<td style="width:10%">
				<div class='cellTitle_ez_right'>휴대폰번호</div>
			</td>

			<td style="width:25%">
				<div class='cellContent_kang'>
					<%=strUser_hp_5 %>
				</div>
			</td>
			<td style="width:10%">
				<div class='cellTitle_ez_right'>이메일</div>
			</td>
			<td style="width:25%" colspan="7">
				<div class='cellContent_kang'>
					<%=strUser_email_5 %>
				</div>
			</td>
		</tr>
		<tr>
			<td style="width:10%">
				<div class='cellTitle_ez_right'><%=strSms%></div>
			</td>
			<td style="width:25%">
				<div class='cellContent_kang'>
					<%=strSms_5 %>
				</div>
			</td>

			<td style="width:10%">
				<div class='cellTitle_ez_right'><%=strMail%></div>
			</td>

			<td style="width:25%">
				<div class='cellContent_kang'>
					<%=strMail_5 %>
				</div>
			</td>
		</tr>
		</td>
		</tr>
		<tr>
			<td colspan="6">
				<div class='cellTitle_kang5'>담당자6 정보</div>
			</td>
		</tr>
		<tr>
			<td valign="top">
		<tr>
			<td style="width:10%">
				<div class='cellTitle_ez_right'>사용자 ID</div>
			</td>
			<td style="width:25%">
				<div class='cellContent_kang'>
					<%=strUser_id_6 %>
				</div>
			</td>
			<td style="width:10%">
				<div class='cellTitle_ez_right'>이 름</div>
			</td>
			<td style="width:25%">
				<div class='cellContent_kang'>
					<%=strUser_nm_6 %>
				</div>
			</td>
			<td style="width:10%">
				<div class='cellTitle_ez_right'>부 서[직 책]</div>
			</td>

			<td style="width:25%">
				<div class='cellContent_kang'>
					<%=strDept_nm_6 %>[<%=strDuty_nm_6 %>]
				</div>
			</td>
		</tr>
		<tr>
			<td style="width:10%">
				<div class='cellTitle_ez_right'>내선번호</div>
			</td>

			<td style="width:25%">
				<div class='cellContent_kang'>
					<%=strUser_tel_6 %>
				</div>
			</td>
			<td style="width:10%">
				<div class='cellTitle_ez_right'>휴대폰번호</div>
			</td>

			<td style="width:25%">
				<div class='cellContent_kang'>
					<%=strUser_hp_6 %>
				</div>
			</td>
			<td style="width:10%">
				<div class='cellTitle_ez_right'>이메일</div>
			</td>
			<td style="width:25%" colspan="7">
				<div class='cellContent_kang'>
					<%=strUser_email_6 %>
				</div>
			</td>
		</tr>
		<tr>
			<td style="width:10%">
				<div class='cellTitle_ez_right'><%=strSms%></div>
			</td>
			<td style="width:25%">
				<div class='cellContent_kang'>
					<%=strSms_6 %>
				</div>
			</td>

			<td style="width:10%">
				<div class='cellTitle_ez_right'><%=strMail%></div>
			</td>

			<td style="width:25%">
				<div class='cellContent_kang'>
					<%=strMail_6 %>
				</div>
			</td>
		</tr>
		</td>
		</tr>
		<tr>
			<td colspan="6">
				<div class='cellTitle_kang5'>담당자7 정보</div>
			</td>
		</tr>
		<tr>
			<td valign="top">
		<tr>
			<td style="width:10%">
				<div class='cellTitle_ez_right'>사용자 ID</div>
			</td>

			<td style="width:25%">
				<div class='cellContent_kang'>
					<%=strUser_id_7 %>
				</div>
			</td>

			<td style="width:10%">
				<div class='cellTitle_ez_right'>이 름</div>
			</td>

			<td style="width:25%">
				<div class='cellContent_kang'>
					<%=strUser_nm_7 %>
				</div>
			</td>
			<td style="width:10%">
				<div class='cellTitle_ez_right'>부 서[직 책]</div>
			</td>

			<td style="width:25%">
				<div class='cellContent_kang'>
					<%=strDept_nm_7 %>[<%=strDuty_nm_7 %>]
				</div>
			</td>
		</tr>
		<tr>
			<td style="width:10%">
				<div class='cellTitle_ez_right'>내선번호</div>
			</td>

			<td style="width:25%">
				<div class='cellContent_kang'>
					<%=strUser_tel_7 %>
				</div>
			</td>
			<td style="width:10%">
				<div class='cellTitle_ez_right'>휴대폰번호</div>
			</td>

			<td style="width:25%">
				<div class='cellContent_kang'>
					<%=strUser_hp_7 %>
				</div>
			</td>
			<td style="width:10%">
				<div class='cellTitle_ez_right'>이메일</div>
			</td>
			<td style="width:25%" colspan="7">
				<div class='cellContent_kang'>
					<%=strUser_email_7 %>
				</div>
			</td>
		</tr>
		<tr>
			<td style="width:10%">
				<div class='cellTitle_ez_right'><%=strSms%></div>
			</td>
			<td style="width:25%">
				<div class='cellContent_kang'>
					<%=strSms_7 %>
				</div>
			</td>

			<td style="width:10%">
				<div class='cellTitle_ez_right'><%=strMail%></div>
			</td>

			<td style="width:25%">
				<div class='cellContent_kang'>
					<%=strMail_7 %>
				</div>
			</td>
		</tr>
		</td>
		</tr>
		<tr>
			<td colspan="6">
				<div class='cellTitle_kang5'>담당자8 정보</div>
			</td>
		</tr>
		<tr>
			<td valign="top">
		<tr>
			<td style="width:10%">
				<div class='cellTitle_ez_right'>사용자 ID</div>
			</td>

			<td style="width:25%">
				<div class='cellContent_kang'>
					<%=strUser_id_8 %>
				</div>
			</td>
			<td style="width:10%">
				<div class='cellTitle_ez_right'>이 름</div>
			</td>

			<td style="width:25%">
				<div class='cellContent_kang'>
					<%=strUser_nm_8 %>
				</div>
			</td>
			<td style="width:10%">
				<div class='cellTitle_ez_right'>부 서[직 책]</div>
			</td>

			<td style="width:25%">
				<div class='cellContent_kang'>
					<%=strDept_nm_8 %>[<%=strDuty_nm_8 %>]
				</div>
			</td>
		</tr>
		<tr>
			<td style="width:10%">
				<div class='cellTitle_ez_right'>내선번호</div>
			</td>

			<td style="width:25%">
				<div class='cellContent_kang'>
					<%=strUser_tel_8 %>
				</div>
			</td>
			<td style="width:10%">
				<div class='cellTitle_ez_right'>휴대폰번호</div>
			</td>

			<td style="width:25%">
				<div class='cellContent_kang'>
					<%=strUser_hp_8 %>
				</div>
			</td>
			<td style="width:10%">
				<div class='cellTitle_ez_right'>이메일</div>
			</td>
			<td style="width:25%" colspan="7">
				<div class='cellContent_kang'>
					<%=strUser_email_8 %>
				</div>
			</td>
		</tr>
		<tr>
			<td style="width:10%">
				<div class='cellTitle_ez_right'><%=strSms%></div>
			</td>
			<td style="width:25%">
				<div class='cellContent_kang'>
					<%=strSms_8 %>
				</div>
			</td>

			<td style="width:10%">
				<div class='cellTitle_ez_right'><%=strMail%></div>
			</td>

			<td style="width:25%">
				<div class='cellContent_kang'>
					<%=strMail_8 %>
				</div>
			</td>
		</tr>
		<tr>
			<td colspan="6">
				<div class='cellTitle_kang5'>담당자9 정보</div>
			</td>
		</tr>
		<tr>
			<td valign="top">
		<tr>
			<td style="width:10%">
				<div class='cellTitle_ez_right'>사용자 ID</div>
			</td>
			<td style="width:25%">
				<div class='cellContent_kang'>
					<%=strUser_id_9 %>
				</div>
			</td>
			<td style="width:10%">
				<div class='cellTitle_ez_right'>이 름</div>
			</td>
			<td style="width:25%">
				<div class='cellContent_kang'>
					<%=strUser_nm_9 %>
				</div>
			</td>
			<td style="width:10%">
				<div class='cellTitle_ez_right'>부 서[직 책]</div>
			</td>
			<td style="width:25%">
				<div class='cellContent_kang'>
					<%=strDept_nm_9 %>[<%=strDuty_nm_9 %>]
				</div>
			</td>
		</tr>
		<tr>
			<td style="width:10%">
				<div class='cellTitle_ez_right'>내선번호</div>
			</td>

			<td style="width:25%">
				<div class='cellContent_kang'>
					<%=strUser_tel_9 %>
				</div>
			</td>
			<td style="width:10%">
				<div class='cellTitle_ez_right'>휴대폰번호</div>
			</td>

			<td style="width:25%">
				<div class='cellContent_kang'>
					<%=strUser_hp_9 %>
				</div>
			</td>
			<td style="width:10%">
				<div class='cellTitle_ez_right'>이메일</div>
			</td>
			<td style="width:25%" colspan="7">
				<div class='cellContent_kang'>
					<%=strUser_email_9 %>
				</div>
			</td>
		</tr>
		<tr>
			<td style="width:10%">
				<div class='cellTitle_ez_right'><%=strSms%></div>
			</td>
			<td style="width:25%">
				<div class='cellContent_kang'>
					<%=strSms_9 %>
				</div>
			</td>

			<td style="width:10%">
				<div class='cellTitle_ez_right'><%=strMail%></div>
			</td>

			<td style="width:25%">
				<div class='cellContent_kang'>
					<%=strMail_9 %>
				</div>
			</td>
		</tr>
		<tr>
			<td colspan="6">
				<div class='cellTitle_kang5'>담당자10 정보</div>
			</td>
		</tr>
		<tr>
			<td valign="top">
		<tr>
			<td style="width:10%">
				<div class='cellTitle_ez_right'>사용자 ID</div>
			</td>
			<td style="width:25%">
				<div class='cellContent_kang'>
					<%=strUser_id_10 %>
				</div>
			</td>
			<td style="width:10%">
				<div class='cellTitle_ez_right'>이 름</div>
			</td>
			<td style="width:25%">
				<div class='cellContent_kang'>
					<%=strUser_nm_10 %>
				</div>
			</td>
			<td style="width:10%">
				<div class='cellTitle_ez_right'>부 서[직 책]</div>
			</td>
			<td style="width:25%">
				<div class='cellContent_kang'>
					<%=strDept_nm_10 %>[<%=strDuty_nm_10 %>]
				</div>
			</td>
		</tr>
		<tr>
			<td style="width:10%">
				<div class='cellTitle_ez_right'>내선번호</div>
			</td>

			<td style="width:25%">
				<div class='cellContent_kang'>
					<%=strUser_tel_10 %>
				</div>
			</td>
			<td style="width:10%">
				<div class='cellTitle_ez_right'>휴대폰번호</div>
			</td>

			<td style="width:25%">
				<div class='cellContent_kang'>
					<%=strUser_hp_10 %>
				</div>
			</td>
			<td style="width:10%">
				<div class='cellTitle_ez_right'>이메일</div>
			</td>
			<td style="width:25%" colspan="7">
				<div class='cellContent_kang'>
					<%=strUser_email_10 %>
				</div>
			</td>
		</tr>
		<tr>
			<td style="width:10%">
				<div class='cellTitle_ez_right'><%=strSms%></div>
			</td>
			<td style="width:25%">
				<div class='cellContent_kang'>
					<%=strSms_10 %>
				</div>
			</td>

			<td style="width:10%">
				<div class='cellTitle_ez_right'><%=strMail%></div>
			</td>

			<td style="width:25%">
				<div class='cellContent_kang'>
					<%=strMail_10 %>
				</div>
			</td>
		</tr>
		<tr>
			<td colspan="6">
				<div class='cellTitle_kang5'>그룹1 정보</div>
			</td>
		</tr>
		<tr>
			<td valign="top">
		<tr>
			<td style="width:10%">
				<div class='cellTitle_ez_right'>그룹명</div>
			</td>

			<td style="width:25%">
				<div class='cellContent_kang'>
					<%=strGrp_nm_1 %>
				</div>
			</td>
		<td style="width:10%">
			<div class='cellTitle_ez_right'><%=strSms%></div>
		</td>
		<td style="width:25%">
			<div class='cellContent_kang'>
				<%=strGrp_sms_1 %>
			</div>
		</td>
		<td style="width:10%">
			<div class='cellTitle_ez_right'><%=strMail%></div>
		</td>

		<td style="width:25%">
			<div class='cellContent_kang'>
				<%=strGrp_mail_1 %>
			</div>
		</td>
		</tr>
		<tr>
			<td colspan="6">
				<div class='cellTitle_kang5'>그룹2 정보</div>
			</td>

		</tr>
		<tr>
			<td valign="top">
		<tr>
			<td style="width:10%">
				<div class='cellTitle_ez_right'>그룹명</div>
			</td>

			<td style="width:25%">
				<div class='cellContent_kang'>
					<%=strGrp_nm_2 %>
				</div>
			</td>
		<td style="width:10%">
			<div class='cellTitle_ez_right'><%=strSms%></div>
		</td>
		<td style="width:25%">
			<div class='cellContent_kang'>
				<%=strGrp_sms_2 %>
			</div>
		</td>

		<td style="width:10%">
			<div class='cellTitle_ez_right'><%=strMail%></div>
		</td>

		<td style="width:25%">
			<div class='cellContent_kang'>
				<%=strGrp_mail_2 %>
			</div>
		</td>
	</table>
</form>
</body>
</html>