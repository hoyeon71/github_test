<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/jsp/common/inc/header.jsp" %>
<%@ page import="java.sql.*,java.util.*,java.io.*,java.text.*,java.net.*" %>
<%@ page import="com.ghayoun.ezjobs.m.domain.*" %>
<%@ page import="com.ghayoun.ezjobs.t.domain.*" %>
<%
	//js version 추가하여 캐시 새로고침
	String jsVersion = CommonUtil.getMessage("js_version");
%>
<!DOCTYPE html>
<html>
<head><title><%=CommonUtil.getMessage("HOME.TITLE") %></title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=Edge">
    <link href="<%=request.getContextPath() %>/css/common.css" rel="stylesheet" type="text/css"/>
    <link href="<%=request.getContextPath() %>/css/custom-theme/jquery-ui.custom.css" rel="stylesheet" type="text/css"/>
    <link href="<%=request.getContextPath() %>/css/custom-theme/jquery-ui.works.css" rel="stylesheet" type="text/css"/>
    <link href="<%=request.getContextPath() %>/css/layout-default.css" rel="stylesheet" type="text/css"/>
    <link href="<%=request.getContextPath() %>/css/ftree/ui.fancytree.css" rel="stylesheet" type="text/css"/>
    <link href="<%=request.getContextPath() %>/js/SlickGrid-2.1.0/slick.grid.css" rel="stylesheet" type="text/css"/>
    <link href="<%=request.getContextPath() %>/css/slick-default-theme.css" rel="stylesheet" type="text/css"/>
    <link href="<%=request.getContextPath() %>/js/poshytip-1.2/tip.css" rel="stylesheet" type="text/css"/>

    <script type="text/javascript" src="<%=request.getContextPath() %>/js/common.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath() %>/js/cookie.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath() %>/js/popup.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath() %>/js/xhrHandler.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.min.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery-ui.custom.min.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.resizeEnd.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.corner.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.cookie.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery-sha256.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.placeholder.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.blockUI.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.event.drag-2.2.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.dialogextend.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.layout.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.layout.slideOff.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.fancytree-all.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath() %>/js/SlickGrid-2.1.0/slick.core.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath() %>/js/SlickGrid-2.1.0/plugins/slick.autotooltips.js" ></script>
    <script type="text/javascript" src="<%=request.getContextPath() %>/js/SlickGrid-2.1.0/plugins/slick.checkboxselectcolumn.js" ></script>
    <script type="text/javascript" src="<%=request.getContextPath() %>/js/SlickGrid-2.1.0/plugins/slick.rowselectionmodel.js" ></script>
    <script type="text/javascript" src="<%=request.getContextPath() %>/js/SlickGrid-2.1.0/slick.dataview.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath() %>/js/SlickGrid-2.1.0/slick.grid.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath() %>/js/SlickGrid-2.1.0/plugins/slick.autocolumnsize.js" ></script>
    <script type="text/javascript" src="<%=request.getContextPath() %>/js/poshytip-1.2/jquery.poshytip.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath() %>/js/works_common.js?v=<%=jsVersion %>" ></script>

    <script type="text/javascript">

    </script>
</head>
<%
    Map<String, Object> paramMap = CommonUtil.collectParameters(request);

    String menu_gb 			= CommonUtil.getMessage("CATEGORY.GB.02.GB."+CommonUtil.isNull(paramMap.get("menu_gb")));
    String[] arr_menu_gb 	= menu_gb.split(",");

    String c 				= CommonUtil.isNull(paramMap.get("c"));
    String gridId 			= "g_"+c;

    String gridId_3         = "g_" + c + "_3";

    // 상태 변경
    String doc_gb 			= "07";

    String s_gb 					= CommonUtil.isNull(paramMap.get("s_gb"));
    String s_text 					= CommonUtil.isNull(paramMap.get("s_text"));
    String s_state_cd 				= CommonUtil.isNull(paramMap.get("s_state_cd"));

    String state_cd 				= CommonUtil.isNull(paramMap.get("state_cd"));
    String approval_cd 				= CommonUtil.isNull(paramMap.get("approval_cd"));
    String doc_cd 					= CommonUtil.isNull(paramMap.get("doc_cd"));
    String rc 						= CommonUtil.isNull(paramMap.get("rc"));

    // 목록 화면 검색 파라미터.
    String search_data_center 		= CommonUtil.isNull(paramMap.get("search_data_center"));
    // 결재목록에서 넘어온 값
    String search_approval_cd 	= CommonUtil.isNull(paramMap.get("search_approval_cd"));
    // 의뢰목록에서 넘어온 값
    String search_state_cd 		= CommonUtil.isNull(paramMap.get("search_state_cd"));
    String search_apply_cd		= CommonUtil.isNull(paramMap.get("search_apply_cd"));
    String search_gb 				= CommonUtil.isNull(paramMap.get("search_gb"));
    String search_text 				= CommonUtil.isNull(paramMap.get("search_text"));
    String search_date_gubun 		= CommonUtil.isNull(paramMap.get("search_date_gubun"));
    String search_s_search_date 	= CommonUtil.isNull(paramMap.get("search_s_search_date"));
    String search_e_search_date 	= CommonUtil.isNull(paramMap.get("search_e_search_date"));
    String search_s_search_date2	= CommonUtil.isNull(paramMap.get("search_s_search_date2"));
    String search_e_search_date2 	= CommonUtil.isNull(paramMap.get("search_e_search_date2"));
    String search_task_nm 			= CommonUtil.isNull(paramMap.get("search_task_nm"));
    String search_critical			= CommonUtil.isNull(paramMap.get("search_critical"));
    String search_approval_state 	= CommonUtil.isNull(paramMap.get("search_approval_state"));
    String search_check_approval_yn	= CommonUtil.isNull(paramMap.get("search_check_approval_yn"));
    String tabId					= CommonUtil.isNull(paramMap.get("tabId"));
    String doc_cnt 					= CommonUtil.isNull(paramMap.get("doc_cnt"), "0");

    String search_param 				= "&search_data_center="+search_data_center+"&search_approval_cd="+search_approval_cd+"&search_state_cd="+search_state_cd+"&search_apply_cd="+search_apply_cd;
    search_param 						+=	"&search_gb="+search_gb+"&search_text="+search_text+"&search_date_gubun="+search_date_gubun+"&search_approval_state="+search_approval_state;
    search_param 						+=	"&search_s_search_date="+search_s_search_date+"&search_e_search_date="+search_e_search_date+"&search_s_search_date2="+search_s_search_date2+"&search_e_search_date2="+search_e_search_date2;
    search_param 						+=	"&search_task_nm="+search_task_nm+"&search_critical="+search_critical+"&tabId="+tabId+"&search_check_approval_yn="+search_check_approval_yn;

    List approvalInfoList			= (List)request.getAttribute("approvalInfoList");
    Doc07Bean docBean				= (Doc07Bean)request.getAttribute("doc07");

    String cur_approval_seq		= CommonUtil.isNull(request.getAttribute("cur_approval_seq"));
    String cur_approval_gb		= CommonUtil.isNull(request.getAttribute("cur_approval_gb"));
    String strDutyNm				= "";
    String strDeptNm				= "";
    String strUserNm				= "";
    String strDocCd					= "";
    String strTitle					= "";
    String strContent				= "";
    String strOrderId				= "";
    String strOdate					= "";
    String strDataCenter			= "";
    String strTableName				= "";
    String strApplication			= "";
    String strGroupName				= "";
    String strJobName				= "";
    String strBeforeStatus			= "";
    String strAfterStatus			= "";

    String strInsUserNm				= "";
    String strInsDutyNm				= "";
    String strInsDeptNm				= "";

    String strDescription			= "";
    String post_approval_yn			= "";

    String strApplyCd				= "";
    String strUserInfo 				= "";
    String strPostUserInfo 			= "";

    String menu_gb_c = "";
    String menu_nm = "";

    if ( docBean != null ) {

        strDutyNm 			= CommonUtil.isNull(CommonUtil.E2K(docBean.getDuty_nm()), "");
        strDeptNm 			= CommonUtil.isNull(CommonUtil.E2K(docBean.getDept_nm()), "");
        strUserNm 			= CommonUtil.isNull(CommonUtil.E2K(docBean.getUser_nm()), "");
        strInsDutyNm 		= CommonUtil.isNull(CommonUtil.E2K(docBean.getIns_duty_nm()), "");
        strInsDeptNm 		= CommonUtil.isNull(CommonUtil.E2K(docBean.getIns_dept_nm()), "");
        strInsUserNm 		= CommonUtil.isNull(CommonUtil.E2K(docBean.getIns_user_nm()), "");
        strDocCd			= CommonUtil.isNull(CommonUtil.E2K(docBean.getDoc_cd()), "");
        strTitle			= CommonUtil.isNull(CommonUtil.E2K(docBean.getTitle()), "");
        strContent			= CommonUtil.isNull(CommonUtil.E2K(docBean.getContent()), "");
        strOrderId			= CommonUtil.isNull(CommonUtil.E2K(docBean.getOrder_id()), "");
        strOdate			= CommonUtil.isNull(CommonUtil.E2K(docBean.getOdate()), "");
        strDataCenter		= CommonUtil.isNull(CommonUtil.E2K(docBean.getData_center()), "");
        strTableName		= CommonUtil.isNull(CommonUtil.E2K(docBean.getTable_name()), "");
        strApplication		= CommonUtil.isNull(CommonUtil.E2K(docBean.getApplication()), "");
        strGroupName		= CommonUtil.isNull(CommonUtil.E2K(docBean.getGroup_name()), "");
        strJobName			= CommonUtil.isNull(CommonUtil.E2K(docBean.getJob_name()), "");
        strBeforeStatus		= CommonUtil.isNull(CommonUtil.E2K(docBean.getBefore_status()), "");
        strAfterStatus		= CommonUtil.isNull(CommonUtil.E2K(docBean.getAfter_status()), "");
        strDescription		= CommonUtil.isNull(CommonUtil.E2K(docBean.getDescription()), "");

        //후결유무
        post_approval_yn 	= CommonUtil.isNull(docBean.getPost_approval_yn());


        // 의뢰자 정보
        strUserInfo = "["+strDeptNm+"] ["+strDutyNm+"] "+strUserNm;

        // 후결 조치자 정보
        strPostUserInfo = "["+strInsDeptNm+"] ["+strInsDutyNm+"] "+strInsUserNm;
        strApplyCd		= CommonUtil.isNull(docBean.getApply_cd());

    }else{

        if(tabId.equals("0390")){
            menu_gb_c = "ez005";
            menu_nm = "결재문서함";
        }else if( (tabId.equals("0399") || tabId.equals("99999")) ){
            menu_gb_c = "ez004";
            menu_nm = "요청문서함";
        }
        out.println("<script type='text/javascript'>");
        out.println("alert('" + CommonUtil.getMessage("DEBUG.06") + "');");
        out.println("top.closeTabsAndAddTab('tabs-" + tabId + "|tabs-" + doc_cd + "', 'c','" + menu_nm + "','01','" + tabId + "','tWorks.ez?c=" + menu_gb_c + "&menu_gb=" + tabId + "&doc_gb=99&"+search_param+"');");
        out.println("</script>");
        return;
    }

    // 세션값 가져오기.
    String strSessionUserId = S_USER_ID;
    String strSessionUserNm = S_USER_NM;

    //로그인한 사용자 상태변경권한
    String sessionActiveAuth	= S_ACTIVE_AUTH;

    List mainDocInfoList = (List) request.getAttribute("mainDocInfoList");

    String grid_view_yn = "N";
    if (mainDocInfoList.size() > 0) {
        grid_view_yn = "Y";
    }

    // 반영실패 갯수 값(재반영 체크박스 활성화 기준값)
    String applyFailCnt = (String)request.getAttribute("applyFailCnt");
%>

<div style="width:100%; height:100%; overflow-x:hidden; overflow-y:scroll;">
    <form id="f_s" name="f_s" method="post" onsubmit="return false;">
        <input type="hidden" id="data_center" 		 name="data_center" 	 value="<%=strDataCenter %>" />
        <input type="hidden" id="doc_cnt"           name="doc_cnt"          value="<%=doc_cnt%>"/>
    </form>
    <form id="userFrm" name="userFrm" method="post" onsubmit="return false;">
        <input type="hidden" name="data_center" 	id="data_center" 	value="<%=strDataCenter %>"/>
        <input type="hidden" name="doc_gb" 			id="doc_gb" 		value="<%=doc_gb %>" />
        <input type="hidden" name="state_cd" 		id="state_cd" 		value="<%=state_cd %>" />
        <input type="hidden" name="job_name" 		id="job_name" 		value="<%=strJobName %>" />
        <!-- 목록 화면 검색 파라미터 -->
        <input type="hidden" name="search_data_center"		id="search_data_center" 	value="<%=search_data_center%>" />
        <input type="hidden" name="search_state_cd"			id="search_state_cd" 		value="<%=search_state_cd%>" />
        <input type="hidden" name="search_apply_cd"			id="search_apply_cd" 		value="<%=search_apply_cd%>" />
        <input type="hidden" name="search_approval_cd"		id="search_approval_cd" 	value="<%=search_approval_cd%>" />
        <input type="hidden" name="search_gb"				id="search_gb" 				value="<%=search_gb%>" />
        <input type="hidden" name="search_text"				id="search_text" 			value="<%=search_text%>" />
        <input type="hidden" name="search_date_gubun"		id="search_date_gubun" 		value="<%=search_date_gubun%>" />
        <input type="hidden" name="search_s_search_date"	id="search_s_search_date" 	value="<%=search_s_search_date%>" />
        <input type="hidden" name="search_e_search_date"	id="search_e_search_date" 	value="<%=search_e_search_date%>" />
        <input type="hidden" name="search_s_search_date2"	id="search_s_search_date2" 	value="<%=search_s_search_date2%>" />
        <input type="hidden" name="search_e_search_date2"	id="search_e_search_date2" 	value="<%=search_e_search_date2%>" />
        <input type="hidden" name="search_task_nm"			id="search_task_nm" 		value="<%=search_task_nm%>" />
        <input type="hidden" name="search_critical"			id="search_critical" 		value="<%=search_critical%>" />
        <input type="hidden" name="search_approval_state"	id="search_approval_state" 	value="<%=search_approval_state%>" />
        <input type="hidden" name="search_check_approval_yn"	id="search_check_approval_yn" 	value="<%=search_check_approval_yn%>" />
        <input type="hidden" name="tabId"					id="tabId"					value="<%=tabId%>" />
    </form>
    <form id="frm1" name="frm1" method="post" onsubmit="return false;" enctype="multipart/form-data" >

        <input type="hidden" id="file_nm"		        name="file_nm" />
        <input type="hidden" id="doc_cd" 		        name="doc_cd" 		                    value="<%=doc_cd %>" />
        <input type="hidden" id="doc_gb" 		        name="doc_gb" 		                    value="<%=doc_gb %>" />
        <input type="hidden" id="data_center" 	        name="data_center" 	                    value="<%=strDataCenter %>" />
        <input type="hidden" id="job_name" 	        name="job_name"		                    value="<%=strJobName%>" />

        <input type="hidden" id="sched_table"	        name="sched_table" />
        <input type="hidden" id="flag"			        name="flag" />
        <input type="hidden" id="user_cd"		        name="user_cd" />
        <input type="hidden" id="days_cal"		        name="days_cal" />
        <input type="hidden" id="job_id"		        name="job_id"                           value="0" />
        <input type="hidden" id="table_id"		        name="table_id"                         value="0" />

        <input type="hidden" id="approval_cd"		    name="approval_cd" />
        <input type="hidden" id="approval_seq"		    name="approval_seq" />
        <input type="hidden" id="approval_comment"	    name="approval_comment" />

        <input type="hidden" id="post_approval_yn" 	    name="post_approval_yn" 		    value="<%=post_approval_yn %>" />
        <input type="hidden" id="doc_cnt"                  name="doc_cnt"						value="<%=doc_cnt%>" />

        <!-- 목록 화면 검색 파라미터 -->
        <input type="hidden" name="search_data_center"		id="search_data_center" 	        value="<%=search_data_center%>" />
        <input type="hidden" name="search_state_cd"		id="search_state_cd" 		        value="<%=search_state_cd%>" />
        <input type="hidden" name="search_apply_cd"		id="search_apply_cd" 		        value="<%=search_apply_cd%>" />
        <input type="hidden" name="search_approval_cd"		id="search_approval_cd" 	        value="<%=search_approval_cd%>" />
        <input type="hidden" name="search_gb"				id="search_gb" 				        value="<%=search_gb%>" />
        <input type="hidden" name="search_text"			id="search_text" 			        value="<%=search_text%>" />
        <input type="hidden" name="search_date_gubun"		id="search_date_gubun" 		        value="<%=search_date_gubun%>" />
        <input type="hidden" name="search_s_search_date"	id="search_s_search_date" 	        value="<%=search_s_search_date%>" />
        <input type="hidden" name="search_e_search_date"	id="search_e_search_date" 	        value="<%=search_e_search_date%>" />
        <input type="hidden" name="search_s_search_date2"	id="search_s_search_date2" 	        value="<%=search_s_search_date2%>" />
        <input type="hidden" name="search_e_search_date2"	id="search_e_search_date2" 	        value="<%=search_e_search_date2%>" />
        <input type="hidden" name="search_task_nm"			id="search_task_nm" 		        value="<%=search_task_nm%>" />
        <input type="hidden" name="search_critical"		id="search_critical" 		        value="<%=search_critical%>" />
        <input type="hidden" name="search_approval_state"	id="search_approval_state" 	        value="<%=search_approval_state%>" />
        <input type="hidden" name="search_check_approval_yn"	id="search_check_approval_yn" 	value="<%=search_check_approval_yn%>" />
        <input type="hidden" name="tabId"					id="tabId"					        value="<%=tabId%>" />


        <input type="hidden" name="check_doc_cd" />
        <input type="hidden" name="check_data_center" />

        <input type="hidden" name="doc_cds" 	id="doc_cds" 		/>
        <input type="hidden" name="doc_gbs"		id="doc_gbs"		/>
        <table id = 'tab_h' style='width:100%;border:none;'>
            <tr style='height:5%;'>
                <td style='vertical-align:top;'>
                    <h4 class="ui-widget-header ui-corner-all">
                        <div id='t_<%=gridId %>' class='title_area'>
                            <span><%=CommonUtil.isNull(arr_menu_gb[0]) %></span>
                        </div>
                    </h4>
                </td>
            </tr>
            <tr style='height:5%;'>
                <td style='vertical-align:top;'>
                  <table style="width:100%">
                        <tr>
                            <td>
                                <div class='cellTitle_kang5'>결재 정보</div>
                            </td>
                        </tr>
                        <tr>
                            <td valign="top">
                                <table style="width:100%;">
                                    <tr>
                                        <%
                                            for (int i = 0; null != approvalInfoList && i < approvalInfoList.size(); i++) {
                                                ApprovalInfoBean bean = (ApprovalInfoBean) approvalInfoList.get(i);

                                                String strLineGb = CommonUtil.isNull(bean.getLine_gb());
                                                String strApprovalGb = CommonUtil.isNull(bean.getApproval_gb());
                                                String strApprovalCd = CommonUtil.isNull(bean.getApproval_cd());
                                                String strApprovalDate = CommonUtil.isNull(bean.getApproval_date());
                                                String strApprovalComment = CommonUtil.isNull(bean.getApproval_comment());
                                                String strGroupLineGrpNm = CommonUtil.isNull(bean.getGroup_line_grp_nm());
                                                String strUpdateUserNm = CommonUtil.isNull(bean.getUpdate_user_nm());
                                                String strApprovalType = CommonUtil.isNull(bean.getApproval_type());

                                                String strApprovalGbMent = "";
                                                String strGroupApprovalUser = "";
                                                String strApprovalTypeNm = "";
                                                if (strApprovalType.equals("03")) strApprovalTypeNm = "[후결]";

                                                if(!strApprovalGb.equals("")) {
            										strApprovalGbMent = CommonUtil.getMessage("USER.APPR.GB."+strApprovalGb);
            									}else {
            										strApprovalGbMent = "즉시 결재자";
            									}

                                                String strApprovalCdMent = CommonUtil.getMessage("DOC.APPROVAL." + strApprovalCd);

                                                String strApprovalCdMent2 = "";
                                                if (!strApprovalCd.equals("00") && !strApprovalCd.equals("01")) {
                                                    strApprovalCdMent2 = strGroupApprovalUser + ":" + strApprovalDate;
                                                }
                                        %>
                                        <td width="200">
                                            <div class='cellTitle_ez_center' style='min-width:30%; min-height:30px;' >
                                                <%=strApprovalGbMent%>
                                                <%
                                                    if (!strApprovalComment.equals("")) {
                                                %>
                                                <img src='<%=sContextPath%>/images/memo_icon.png' alt="<%=strApprovalComment%>" title="<%=strApprovalComment%>" />
                                                <%
                                                    }
                                                %>
                                                [<%=strApprovalCdMent%><%=strApprovalCdMent2%>] <%=strApprovalTypeNm%>
                                            </div>
                                        </td>
                                        <%
                                            }
                                        %>
                                    </tr>
                                    <tr style='vertical-align:top;'>
                                        <%
                                            for (int i = 0; null != approvalInfoList && i < approvalInfoList.size(); i++) {
                                                ApprovalInfoBean bean = (ApprovalInfoBean) approvalInfoList.get(i);

                                                String strApprovalComment = CommonUtil.isNull(bean.getApproval_comment());
                                        %>
                                        <td width="200">
                                            <%
                                                if (!strApprovalComment.equals("")) {
                                            %>
                                            <div class='cellTitle_kang3' style='display:flex;justify-content:center;padding:0 22% 0 22%; word-break: break-all;height:auto;text-align:left;'><%=strApprovalComment%></div>
                                            <%
                                                }
                                            %>
                                        </td>
                                        <%
                                            }
                                        %>
                                    </tr>
                                    <tr>
                                        <%
                                            for (int i = 0; null != approvalInfoList && i < approvalInfoList.size(); i++) {
                                                ApprovalInfoBean bean = (ApprovalInfoBean) approvalInfoList.get(i);

                                                String strApprovalCd = CommonUtil.isNull(bean.getApproval_cd());
                                                String strSeq = CommonUtil.isNull(bean.getSeq());
                                                String strApprovalUserNm = CommonUtil.isNull(CommonUtil.E2K(bean.getUser_nm()));
                                                String strDutyCd = CommonUtil.isNull(bean.getDuty_cd());
                                                String strUserCd = CommonUtil.isNull(bean.getUser_cd());

                                                String strUdtUserCd			= CommonUtil.isNull(bean.getUdt_user_cd());
                                                String strUdtUserNm			= CommonUtil.isNull(bean.getUpdate_user_nm());
            									String strUdtDeptNm			= CommonUtil.isNull(bean.getUpdate_dept_nm());
            									String strUdtDutyNm			= CommonUtil.isNull(bean.getUpdate_duty_nm());

                                                String strAbsenceUserCd = CommonUtil.isNull(bean.getAbsence_user_cd());
                                                String strAbsenceUserNm = CommonUtil.isNull(bean.getAbsence_user_nm());
                                                String strAbsenceDeptNm = CommonUtil.isNull(bean.getAbsence_dept_nm());
                                                String strAbsenceDutyNm = CommonUtil.isNull(bean.getAbsence_duty_nm());

                                                String strGroupLineGrpNm = CommonUtil.isNull(bean.getGroup_line_grp_nm());
                                                String strGroupLineGrpCd = CommonUtil.isNull(bean.getGroup_line_grp_nm());

                                                String strLineGb = CommonUtil.isNull(bean.getLine_gb());
                                                String userInfo = "";
                                                String strAbsenceInfo = "";

                                             	// 결재 시 대결자 정보가 있으면 대결자 셋팅
            									if( strUdtUserCd.equals("") && !strAbsenceUserCd.equals("0") && strGroupLineGrpNm.equals("") ) {
            										strAbsenceInfo = "["+CommonUtil.E2K(bean.getDept_nm())+"]["+CommonUtil.E2K(bean.getDuty_nm())+"]"+CommonUtil.E2K(bean.getUser_nm()) + " (대결자:" + strAbsenceUserNm + ")";
            									}

                                                // 결재사용자코드와 업데이트한 사용자코드가 다르면 대결로 간주
                                                if (!strUserCd.equals(strUdtUserCd) && !strUdtUserCd.equals("") && strGroupLineGrpNm.equals("")) {
// 													strAbsenceInfo = "["+strAbsenceDeptNm+"]["+strAbsenceDutyNm+"]<br>"+strAbsenceUserNm +"(대결)";
// 													strAbsenceInfo = "[" + strAbsenceDeptNm + "][" + strAbsenceDutyNm + "]" + strAbsenceUserNm + "(대결)";
                                                	strAbsenceInfo = "["+strUdtDeptNm+"]["+strUdtDutyNm+"]"+strUdtUserNm +"(대결)";
                                                }

// 												userInfo = "["+CommonUtil.E2K(bean.getDept_nm())+"]["+CommonUtil.E2K(bean.getDuty_nm())+"]<br>"+CommonUtil.E2K(bean.getUser_nm());
                                                userInfo = "[" + CommonUtil.E2K(bean.getDept_nm()) + "][" + CommonUtil.E2K(bean.getDuty_nm()) + "]" + CommonUtil.E2K(bean.getUser_nm());
                                                if (!strGroupLineGrpNm.equals("")) {
                                                    userInfo = "[그룹]" + strGroupLineGrpNm;
                                                    if ( !strUdtUserNm.equals("") ) {
                                                        userInfo += "(" + strUdtUserNm + ")";
                                                    }
                                                }

                                                // 대결
                                                if (!strAbsenceInfo.equals("")) {
                                                    userInfo = strAbsenceInfo;
                                                }
                                        %>
                                        <td width="200">
                                            <div style='min-width:200px' class='cellTitle_kang3'><a href="javascript:dynamicApprovalUserInfo('<%=sContextPath%>','<%=strUserCd%>','<%=strGroupLineGrpNm%>','<%=strLineGb %>','<%=doc_cd%>','<%=strSeq%>','<%=strApprovalCd%>')"><%=userInfo%></a></div>
                                        </td>
                                        <%
                                            }
                                        %>
                                    </tr>
                                </table>
                            </td>
                        </tr>

                            <tr>
                                <td>
                                    <div class='cellTitle_kang5'>요청 정보 [문서정보 : <%=doc_cd %>]</div>
                                </td>
                            </tr>
                            <tr>
                                <td valign="top">
                                    <table style="width:100%;">
                                        <tr>
                                            <td width="10%"></td>
                                            <td width="20%"></td>
                                            <td width="10%"></td>
                                            <td width="20%"></td>
                                            <td width="10%"></td>
                                            <td width="20%"></td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <div class='cellTitle_ez_right'>의 뢰 자</div>
                                            </td>
								            <td>
                                                <div class='cellContent_kang'>
<%-- 										<a href="JavaScript:docUserInfo('<%=doc_cd %>');" style="text-decoration:underline;"><font color="black"><%=strUserInfo %></font></a> --%>
										            <a href="JavaScript:docUserInfo('<%=doc_cd %>');" style="text-decoration:underline;cursor:pointer;"><b><%=strUserInfo %></b></a>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="vertical-align:top;">
                                                <div class='cellTitle_ez_right'>요청 사유</div>
                                            </td>
                                            <td colspan="5" style="vertical-align:top;">
                                                <div class='cellContent_kang' style='height:auto;'><%= CommonUtil.E2K(docBean.getTitle()) %></div>
                                            </td>
                                        </tr>
                                        <%
                                            if ( !CommonUtil.E2K(docBean.getFail_comment()).equals("") ) {
                                        %>
                                        <tr>
                                            <td style="vertical-align:top;">
                                                <div class='cellTitle_ez_right'><font color="red">* </font>반영실패 사유</div>
                                            </td>
                                            <td colspan="5" style="vertical-align:top;">
                                                <div class='cellContent_kang' style='height:auto;font-weight:bold;'><font color="red"><%=CommonUtil.E2K(docBean.getFail_comment()) %></font></div>
                                            </td>
                                        </tr>
                                        <%
                                            }
                                        %>
                                    </table>
                                </td>
                            </tr>
                        </table>
                </td>
            </tr>
            <tr id='ly_<%=gridId_3 %>' style='height:83%;'>
                <td style='vertical-align:top;'>
                    <div id="<%=gridId_3 %>" class="ui-widget-header ui-corner-all"></div>
                </td>
            </tr>
            <tr style='height:10%;'>
                <td style='vertical-align:top;'>
                    <h4 class="ui-widget-header ui-corner-all">
                        <div align='right' class='btn_area'>
                            <%
                                String strCurApprovalSeq = "";
                                String strStateCd = "";
                                String strInsUserCd = "";
                                String strStateCd2 = "";

                                for (int i = 0; null != approvalInfoList && i < approvalInfoList.size(); i++) {
                                    ApprovalInfoBean bean = (ApprovalInfoBean) approvalInfoList.get(i);

                                    String strUserCd = CommonUtil.isNull(bean.getUser_cd());
                                    String strUdtUserCd = CommonUtil.isNull(bean.getUdt_user_cd());

                                    String strAbsenceUserCd = CommonUtil.isNull(bean.getAbsence_user_cd());
                                    String strAbsenceUserNm = CommonUtil.isNull(bean.getAbsence_user_nm());
                                    String strAbsenceDeptNm = CommonUtil.isNull(bean.getAbsence_dept_nm());
                                    String strAbsenceDutyNm = CommonUtil.isNull(bean.getAbsence_duty_nm());

                                    String strSeq = CommonUtil.isNull(bean.getSeq());
                                    strCurApprovalSeq = CommonUtil.isNull(bean.getCur_approval_seq());
                                    strStateCd = CommonUtil.isNull(bean.getState_cd());
                                    strStateCd2 = CommonUtil.isNull(bean.getState_cd());
                                    strInsUserCd = CommonUtil.isNull(bean.getIns_user_cd());

                                    String strAbsenceInfo = "";
                                }

                                if (!cur_approval_seq.equals("")) {
                            %>
                            <input type="hidden" name="seq" id="seq" value="<%=cur_approval_seq%>"/>

                            결재자 의견 : <input type="text" name="app_comment" id="app_comment" maxlength="100" style="width:150px;height:21px;">
                            <span id='btn_approval'>결재</span>

                            <%	// 후결상태변경 및 반영완료는 반려 처리 불가.
                                if ( !post_approval_yn.equals("Y") && !strApplyCd.equals("02")) {
                            %>
                            <%
                                    if (!cur_approval_gb.equals("04")) {
                            %>
                                    <span id='btn_reject'>반려</span>
                            <%
                                    }
                            %>
                            <%
                                }
                            %>
                            <%
                                }

                            %>
                            <!-- <span id='btn_list'>목록</span> -->
                            <span id='btn_del' style="display:none;">삭제</span>

                            <%
                                // 1차결재자 미결이면 기안자 승인취소 가능
                                if (strCurApprovalSeq.equals("1") && strStateCd2.equals("01") && S_USER_CD.equals(strInsUserCd)) {
                            %>
                            <% //작업이 반영완료일 경우 승인취소 불가
                                if (!strApplyCd.equals("02")) {
                            %>
                            <span id='btn_cancel'>승인취소</span>
                            <%
                                    }
                                }
                            %>

							<span id="btn_admin_approval" style='display:none;'>재반영</span>
                            <span id='btn_close'>닫기</span>

                        </div>
                    </h4>
                </td>
            </tr>
        </table>

<iframe name="if2" id="if2" style="width:99%;height:300px;" scrolling="no" frameborder="0"></iframe>

    </form>


    <script>

        function gridCellCustomFormatter(row, cell, value, columnDef, dataContext) {

            var ret = "";
            var doc_cd = getCellValue(gridObj_3, row, 'DOC_CD');
            var doc_gb = getCellValue(gridObj_3, row, 'DOC_GB');
            var task_type = getCellValue(gridObj_3, row, 'TASK_TYPE');
            var title = getCellValue(gridObj_3, row, 'TITLE');
            var job_name = getCellValue(gridObj_3, row, 'JOB_NAME');
            var description = getCellValue(gridObj_3, row, 'DESCRIPTION');
            var state_nm = getCellValue(gridObj_3, row, 'STATE_NM');
            var draft_date = getCellValue(gridObj_3, row, 'DRAFT_DATE');
            var ins_date = getCellValue(gridObj_3, row, 'INS_DATE');
            var job_id = getCellValue(gridObj_3, row, 'JOB_ID');
            var table_id = getCellValue(gridObj_3, row, 'TABLE_ID');


            if (columnDef.id == 'JOB_NAME' || columnDef.id == 'TITLE') {

                ret = "<a href=\"JavaScript:goView('" + doc_cd + "','" + job_name + "','" + job_id + "','" + table_id + "');\" /><font color='red'>" + value + "</font></a>";
            }

            return ret;
        }

        var gridObj_3 = {
            id: "<%=gridId_3 %>"
            , colModel: [
                {formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'번호',width:50,minWidth:50,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
                ,{formatter:gridCellNoneFormatter,field:'DOC_CD',id:'DOC_CD',name:'문서번호',minWidth:120,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
                //,{formatter:gridCellNoneFormatter,field:'DOC_GB',id:'DOC_GB',name:'문서구분',width:130,minWidth:130,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
                //,{formatter:gridCellNoneFormatter,field:'TASK_TYPE',id:'TASK_TYPE',name:'작업구분',width:80,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
                //,{formatter:gridCellCustomFormatter,field:'TITLE',id:'TITLE',name:'의뢰사유',width:200,minWidth:200,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
                ,{formatter:gridCellCustomFormatter,field:'JOB_NAME',id:'JOB_NAME',name:'작업명',minWidth:200,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
                ,{formatter:gridCellNoneFormatter,field:'DESCRIPTION',id:'DESCRIPTION',name:'작업설명',minWidth:250,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
                ,{formatter:gridCellNoneFormatter,field:'BEFORE_STATUS',id:'BEFORE_STATUS',name:'이전 상태',minWidth:90,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
                ,{formatter:gridCellNoneFormatter,field:'AFTER_STATUS',id:'AFTER_STATUS',name:'변경된 상태',minWidth:90,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
                //,{formatter:gridCellNoneFormatter,field:'STATE_NM',id:'STATE_NM',name:'문서상태',width:70,minWidth:70,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
                ,{formatter:gridCellNoneFormatter,field:'APPLY_NM',id:'APPLY_NM',name:'반영상태',minWidth:90,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
                ,{formatter:gridCellNoneFormatter,field:'FAIL_COMMENT',id:'FAIL_COMMENT',name:'리턴메세지',minWidth:90,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
                //,{formatter:gridCellNoneFormatter,field:'STATUS',id:'STATUS',name:'작업상태',minWidth:100,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
                ,{formatter:gridCellNoneFormatter,field:'DRAFT_DATE',id:'DRAFT_DATE',name:'의뢰일자',minWidth:120,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
                ,{formatter:gridCellNoneFormatter,field:'INS_DATE',id:'INS_DATE',name:'등록일자',minWidth:120,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
                ,{formatter:gridCellNoneFormatter,field:'JOB_ID',id:'JOB_ID',name:'JOB_ID',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
                ,{formatter:gridCellNoneFormatter,field:'TABLE_ID',id:'TABLE_ID',name:'TABLE_ID',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
            ]
            , rows: []
            , vscroll:<%=S_GRID_VSCROLL%>
        };

        window.onresize = function() {
            resizeTabsSize();
        }

        $(document).ready(function () {

            resizeTabsSize();

            var doc_cd = '<%=doc_cd%>';
            var session_user_gb = "<%=S_USER_GB%>";

            if (session_user_gb == "99" || session_user_gb == "02") {
                $("#btn_del").show();
            }
            var apply_cd = '<%=strApplyCd%>';

            $("#btn_approval").button().unbind("click").click(function () {
                goPrc('02', $("#seq").val(), '결재');
            });

            $("#btn_reject").button().unbind("click").click(function () {
                goPrc('04', $("#seq").val(), '반려');
            });

            $("#btn_cancel").button().unbind("click").click(function () {
                goCancel();
            });

            $("#btn_close").button().unbind("click").click(function () {
                top.closeTabs('tabs-' + doc_cd);
            });

            $("#btn_del").button().unbind("click").click(function () {
                goPrc2('del');
            });

			//재반영이 있다면 앞에 체크박스 있는 그리드로 그려지도록 조건 추가
            <%if(applyFailCnt.equals("0")){%>
        		viewGrid_1(gridObj_3,"ly_"+gridObj_3.id,{enableColumnReorder:true},'AUTO');
        	<%}else{%>
        	//체크박스
        		viewGridChk_1(gridObj_3,"ly_"+gridObj_3.id,{enableColumnReorder:true},'AUTO');
        	<%}%>

            setTimeout(function () {
                mainDocInfoList("<%=doc_cd%>");
            }, 1000);

          	//재반영 버튼 클릭
        	$("#btn_admin_approval").button().unbind("click").click(function(){
        		UpdateFlag();
        	});
        });

        function mainDocInfoList(doc_cd) {


		try{viewProgBar(true);}catch(e){}
            $('#ly_total_cnt').html('');

            var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=mainDocInfoList&itemGubun=2&doc_cd=' + doc_cd;

            var xhr = new XHRHandler(url, f_s
                , function () {
                    var xmlDoc = this.req.responseXML;
                    if (xmlDoc == null) {
						try{viewProgBar(false);}catch(e){}
                        alert('세션이 만료되었습니다 다시 로그인해 주세요');
                        return false;
                    }
                    if ($(xmlDoc).find('doc').length == 0 && $(xmlDoc).find('error').length > 0) {
						try{viewProgBar(false);}catch(e){}
                        alert($(xmlDoc).find('msg_code').text());
                        //goCommonError('<%=sContextPath %>','_self',$(xmlDoc).find('msg_code').text());
                        return false;
                    }
                    $(xmlDoc).find('doc').each(function () {

                        var items = $(this).find('items');
                        var rowsObj = new Array();

                        if (items.attr('cnt') == '0') {
                        } else {

                            items.find('item').each(function (i) {

                                var task_type 		= $(this).find("TASK_TYPE").text();
                                var main_doc_cd 	= $(this).find("MAIN_DOC_CD").text();
                                var doc_cd 			= $(this).find("DOC_CD").text();
                                var doc_gb 			= $(this).find("DOC_GB").text();
                                var title 			= $(this).find("TITLE").text();
                                var job_name 		= $(this).find("JOB_NAME").text();

                                var state_cd 		= $(this).find("STATE_CD").text();
                                var state_nm 		= $(this).find("STATE_NM").text();
                                var draft_date 		= $(this).find("DRAFT_DATE").text();
                                var ins_date 		= $(this).find("INS_DATE").text();
                                var status 			= $(this).find("STATUS").text();
                                var ajob_status 	= $(this).find("AJOB_STATUS").text();
                                var table_id 		= $(this).find("TABLE_ID").text();
                                var job_id 			= $(this).find("JOB_ID").text();
                                var batch_result 	= $(this).find("BATCH_RESULT").text();
                                var fail_comment 	= $(this).find("FAIL_COMMENT").text();
                                var description 	= $(this).find("DESCRIPTION").text();
                                var apply_cd 		= $(this).find("APPLY_CD").text();
                                var before_status 	= $(this).find("BEFORE_STATUS").text();
                                var after_status 	= $(this).find("AFTER_STATUS").text();

                                // 실시간 작업 정보에 해당 작업의 상태가 존재하면 그걸 뿌려주고, 없다면 DOC 테이블의 status를 뿌려준다.
                                if (ajob_status != "") {
                                    //status = ajob_status;
                                }

                                if (fail_comment != "") {
                                    fail_comment = "<font color='red'>" + fail_comment + "</font>"
                                }

                              	//반영 실패한 작업이 있으면 재반영 버튼 활성화
								if((apply_cd == '04' || apply_cd == '05') && ("<%=S_USER_GB%>" == "99" || "<%=S_USER_GB%>" == "02")){
									$("#btn_admin_approval").show();
								}

								//후결일 경우 버튼 다시 숨김
								if('<%=cur_approval_gb%>' != ''){
									$("#btn_admin_approval").hide();
								}

                                rowsObj.push({
                                    'grid_idx'          : i + 1
                                    , 'TASK_TYPE'       : task_type
                                    , 'MAIN_DOC_CD'     : main_doc_cd
                                    , 'DOC_CD'          : doc_cd
                                    , 'DOC_GB'          : doc_gb
                                    , 'TITLE'           : title
                                    , 'JOB_NAME'        : job_name

                                    , 'STATE_CD'        : state_cd
                                    , 'STATE_NM'        : state_nm
                                    , 'APPLY_NM'        : batch_result
                                    , 'FAIL_COMMENT'    : fail_comment
                                    , 'DRAFT_DATE'      : draft_date
                                    , 'INS_DATE'        : ins_date
                                    //, 'STATUS'          : status
                                    , 'TABLE_ID'        : table_id
                                    , 'JOB_ID'          : job_id
                                    , 'DESCRIPTION'     : description
                                    , 'APPLY_CD'        : apply_cd
                                    , 'BEFORE_STATUS'   : before_status
                                    , 'AFTER_STATUS'    : after_status
                                });

                            });
                        }

                        gridObj_3.rows = rowsObj;
                        setGridRows(gridObj_3);
                        $('body').resizeAllColumns();
                        $('#ly_total_cnt').html('[ TOTAL : ' + items.attr('cnt') + ' ]');

                    });
					try{viewProgBar(false);}catch(e){}
                }
                , null);

            xhr.sendRequest();
        }


        function goView(doc_cd, job_name, job_id, table_id) {
            var frm = document.frm1;
            frm.job_name.value = job_name;
            //frm.job_id.value = job_id;
            //frm.table_id.value = table_id;

            openPopupCenter1("about:blank", "popupDefJobDetail", 1250, 800);

            frm.action = "<%=sContextPath %>/mPopup.ez?c=ez011";
            frm.target = "popupDefJobDetail";
            frm.submit();
        }

        function goPrc(approval_cd, approval_seq, appproval_nm) {

            var frm = document.frm1;

            frm.approval_cd.value = approval_cd;
            frm.approval_seq.value = approval_seq;

            var app_comment = $("#app_comment").val();
            frm.approval_comment.value = app_comment;

            // 반려일 경우 결재자 의견 필수
            if (approval_cd == "04" && app_comment == "") {
                alert("반려는 결재자 의견이 필수입니다.");
                $("#app_comment").focus();
                return;
            }

            if (!confirm("[" + appproval_nm + "] 하시겠습니까?")) return;

            // 직전 진행했던 파라미터가 넘어가는 걸 방지하기 위해 초기화 (2023.05.25 강명준)
            frm.flag.value 	= "";

            var doc_cnt = "<%=doc_cnt%>";

            try{viewProgBar(true);}catch(e){}

            frm.target = "if1";
		    frm.action = "<%=sContextPath%>/tWorks.ez?c=ez006_p";
            frm.submit();
        }

        function goPrc2(flag) {

            var frm = document.frm1;

            frm.flag.value = flag;

            if (!confirm("삭제하시겠습니까?")) return;

            // 직전 진행했던 파라미터가 넘어가는 걸 방지하기 위해 초기화 (2023.05.25 강명준)
            frm.approval_cd.value = "";

		    try{viewProgBar(true);}catch(e){}
            frm.target = "if1";
            frm.action = "<%=sContextPath%>/tWorks.ez?c=ez004_p";
            frm.submit();

        }

        function goCancel() {

            var frm = document.frm1;

            if (!confirm("해당 문서는 삭제됩니다.\n[승인취소]하시겠습니까?")) return;

            // 직전 진행했던 파라미터가 넘어가는 걸 방지하기 위해 초기화 (2023.05.25 강명준)
            frm.approval_cd.value 	= "";

		    try{viewProgBar(true);}catch(e){}

            frm.flag.value = "def_cancel";
            frm.target = "if1";
            frm.action = "<%=sContextPath%>/tWorks.ez?c=ez006_p";

            frm.submit();
        }

      	//재반영 버튼 클릭시
    	function UpdateFlag() {

		var frm = document.frm1;

		frm.doc_cds.value 		= '<%=doc_cd %>';
		frm.doc_gbs.value 		= '<%=doc_gb %>';

    		if( !confirm("재반영을 요청 하시겠습니까?") ) return;

    		try{viewProgBar(true);}catch(e){}

    		frm.target = "if1";
    		frm.action = "<%=sContextPath%>/tWorks.ez?c=ez006_attempt";
    		frm.submit();

    	}

    </script>
    <%@include file="/jsp/common/inc/progBar.jsp" %>
    <iframe name="if1" id="if1" width="0" height="0"></iframe>
    </body>
</div>
</html>