<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/jsp/common/inc/header.jsp"%>
<%@ page import="java.sql.*,java.util.*,java.io.*,java.text.*,java.net.*" %>
<%@ page import="com.ghayoun.ezjobs.t.domain.*" %>
<c:set var="caluse_gb_cd" value="${fn:split(CALUSE_GB_CD,',')}"/>
<c:set var="caluse_gb_nm" value="${fn:split(CALUSE_GB_NM,',')}"/>

<c:set var="prio_gb_cd" value="${fn:split(PRIORITY_GB_CD,',')}"/>
<c:set var="prio_gb_nm" value="${fn:split(PRIORITY_GB_NM,',')}"/>
<%
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
<link href="<%=request.getContextPath() %>/js/SlickGrid-2.1.0/css/select2.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath() %>/css/slick-default-theme.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath() %>/js/poshytip-1.2/tip.css" rel="stylesheet" type="text/css" />
<style type="text/css">
	.select2-container {
		top: -3px;
		left: -6px;
	}
    .select2-container .select2-selection--single {
		height: 26px;
	}  
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
<script type="text/javascript" src="<%=request.getContextPath() %>/js/SlickGrid-2.1.0/plugins/select2.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/SlickGrid-2.1.0/slick.dataview.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/SlickGrid-2.1.0/slick.grid.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/SlickGrid-2.1.0/slick.editors.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/poshytip-1.2/jquery.poshytip.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/works_common.js?v=<%=jsVersion %>" ></script>

</head>


<%
	
	Map<String, Object> paramMap = CommonUtil.collectParameters(request);
	String c = CommonUtil.isNull(paramMap.get("c"));
	String gridId 	= "g_"+c;		
	String gridId_1 = "g_"+c+"_1";
	String gridId_2 = "g_"+c+"_2";
	String gridId_3 = "g_"+c+"_3";
	String gridId_4 = "g_"+c+"_4";	
	
	String s_doc_gb 			= CommonUtil.isNull(paramMap.get("s_doc_gb"));
	String s_gb 				= CommonUtil.isNull(paramMap.get("s_gb"));
	String s_text 				= CommonUtil.isNull(paramMap.get("s_text"));
	String s_state_cd 			= CommonUtil.isNull(paramMap.get("s_state_cd"));
	
	String state_cd 			= CommonUtil.isNull(paramMap.get("state_cd"));
	String approval_cd 			= CommonUtil.isNull(paramMap.get("approval_cd"));
	
	String doc_cd 				= CommonUtil.isNull(paramMap.get("doc_cd"));
	String max_doc_cd			= CommonUtil.isNull(paramMap.get("max_doc_cd"));
	String doc_gb 				= CommonUtil.isNull(paramMap.get("doc_gb"));
	String rc 					= CommonUtil.isNull(paramMap.get("rc"));
	
	// 목록 화면 검색 파라미터.
	String search_data_center 	= CommonUtil.isNull(paramMap.get("search_data_center"));
	// 결재목록에서 넘어온 값
	String search_approval_cd 	= CommonUtil.isNull(paramMap.get("search_approval_cd"));
	// 의뢰목록에서 넘어온 값
	String search_state_cd 		= CommonUtil.isNull(paramMap.get("search_state_cd"));
	String search_apply_cd		= CommonUtil.isNull(paramMap.get("search_apply_cd"));
	String search_gb 			= CommonUtil.isNull(paramMap.get("search_gb"));
	String search_text 			= CommonUtil.isNull(paramMap.get("search_text"));
	String search_date_gubun 	= CommonUtil.isNull(paramMap.get("search_date_gubun"));
	String search_s_search_date = CommonUtil.isNull(paramMap.get("search_s_search_date"));
	String search_e_search_date = CommonUtil.isNull(paramMap.get("search_e_search_date"));
	String search_s_search_date2 = CommonUtil.isNull(paramMap.get("search_s_search_date2"));
	String search_e_search_date2 = CommonUtil.isNull(paramMap.get("search_e_search_date2"));
	String search_task_nm 		= CommonUtil.isNull(paramMap.get("search_task_nm"));
	String search_moneybatchjob	= CommonUtil.isNull(paramMap.get("search_moneybatchjob"));
	String search_critical		= CommonUtil.isNull(paramMap.get("search_critical"));
	String search_approval_state 	= CommonUtil.isNull(paramMap.get("search_approval_state"));
	String search_check_approval_yn	= CommonUtil.isNull(paramMap.get("search_check_approval_yn"));

	String tabId					= CommonUtil.isNull(paramMap.get("tabId"));
	String doc_cnt					= CommonUtil.isNull(paramMap.get("doc_cnt"),"0");

	String search_param 				= "&search_data_center="+search_data_center+"&search_approval_cd="+search_approval_cd+"&search_state_cd="+search_state_cd+"&search_apply_cd="+search_apply_cd;
	search_param 						+=	"&search_gb="+search_gb+"&search_text="+search_text+"&search_date_gubun="+search_date_gubun+"&search_approval_state="+search_approval_state;
	search_param 						+=	"&search_s_search_date="+search_s_search_date+"&search_e_search_date="+search_e_search_date+"&search_s_search_date2="+search_s_search_date2+"&search_e_search_date2="+search_e_search_date2;
	search_param 						+=	"&search_task_nm="+search_task_nm+"&search_moneybatchjob="+search_moneybatchjob+"&search_critical="+search_critical+"&tabId="+tabId+"&search_check_approval_yn="+search_check_approval_yn;

	if ( !max_doc_cd.equals("") ) {
		doc_cd = max_doc_cd;
	}
	
	String currentPage 			= CommonUtil.isNull(paramMap.get("currentPage"));
	
	List approvalInfoList		= (List)request.getAttribute("approvalInfoList");
	List dataCenterList		    = (List)request.getAttribute("dataCenterList");	
	List mainDocInfoList 		= (List)request.getAttribute("mainDocInfoList");	
	List sCodeList				= (List)request.getAttribute("sCodeList");
	List sBatchGradeList		= (List)request.getAttribute("sBatchGradeList");
	List smsDefaultList			= (List)request.getAttribute("smsDefaultList");
	List mailDefaultList		= (List)request.getAttribute("mailDefaultList");
	List setvarList				= (List)request.getAttribute("setvarList");
	List databaseList			= (List)request.getAttribute("databaseList");
	
	List<CommonBean> inOutList 		= new ArrayList<CommonBean>();
	JobMapperBean jobMapperBean	= (JobMapperBean)request.getAttribute("jobMapperInfo");	
	Doc01Bean docBean			= (Doc01Bean)request.getAttribute("doc02");
	String cur_approval_seq		= CommonUtil.isNull(request.getAttribute("cur_approval_seq"));
	String cur_approval_gb		= CommonUtil.isNull(request.getAttribute("cur_approval_gb"));
	
	String menu_gb_c = "";
	String menu_nm = "";

	if ( docBean == null ) {
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

	// 참조기안시 작업명을 가지고 매퍼를 찾기 때문에 필요.
	String strJobName 		= CommonUtil.E2K(docBean.getJob_name());
	
	String strMonth_days 		= CommonUtil.E2K(docBean.getMonth_days());
	String strSchedule_and_or 	= CommonUtil.E2K(docBean.getSchedule_and_or());
	String strWeek_days 		= CommonUtil.E2K(docBean.getWeek_days());
	String strDays_cal 			= CommonUtil.E2K(docBean.getDays_cal());
	String strWeeks_cal 		= CommonUtil.E2K(docBean.getWeeks_cal());
	String strTitle 			= CommonUtil.E2K(docBean.getTitle());
	String strTaskType			= CommonUtil.E2K(docBean.getTask_type());	
	
	String strT_set 				= CommonUtil.isNull(docBean.getT_set());
	String strMonitor_time			= "";
	String strMonitor_interval		= "";
	String strFilesize_comparison	= "";
	String strNum_of_iterations		= "";
	String strStop_time				= "";	
	
	// LIBMEMSIM, FileWatch 제거 후 변수 셋팅.
	String strT_set_var = "";
	if ( !strT_set.equals("") ) {
		String arr_t_set[]  = strT_set.split("[|]");		
		for ( int i = 0; i < arr_t_set.length; i++ ) {
			String arr_t_set_detail[]  = arr_t_set[i].split("[,]");
			
			if ( arr_t_set_detail.length > 1 ) {
			
				if ( arr_t_set_detail[0].equals("LIBMEMSYM") || arr_t_set_detail[0].indexOf("FileWatch") > -1  ) {
					
				} else {
					strT_set_var += "|" + arr_t_set[i];
				}
			}
		}
		
		if ( !strT_set_var.equals("") && strT_set_var.substring(0, 1).equals("|") ) strT_set_var = strT_set_var.substring(1, strT_set_var.length());
	}

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
	
	//kubernetes 값 세팅
	String var_name			= "";
	String con_pro			= "";
	String spec_param		= "";
	String get_pod_logs		= "";
	String job_cleanup		= "";
	String polling_interval	= "";
	String yaml_file		= "";
	String file_content		= "";
	String job_spec_type	= "";
	String os_exit_code		= "";
	
	//Database 값 세팅
	String db_con_pro		= "";
	String database			= "";
	String database_type	= "";
	String execution_type	= "";
	String schema			= "";
	String sp_name			= "";
	String query			= "";
	String db_autocommit	= "";
	String append_log		= "";
	String append_output	= "";
	String db_output_format	= "";
	String csv_seperator	= "";
	
	if(setvarList != null) {
		for ( int i = 0; i < setvarList.size(); i++ ) {
			CommonBean commonBean = (CommonBean) setvarList.get(i);
			var_name	= commonBean.getVar_name();
			
			if(var_name.equals("UCM-ACCOUNT")){
				con_pro 			= commonBean.getVar_value();
			}else if(var_name.equals("UCM-JOB_YAML_FILE_PARAMS")){
				spec_param 			= commonBean.getVar_value();
			}else if(var_name.equals("UCM-GET_LOGS")){
				get_pod_logs 		= commonBean.getVar_value();
			}else if(var_name.equals("UCM-CLEANUP")){
				job_cleanup 		= commonBean.getVar_value();
			}else if(var_name.equals("UCM-JOB_POLL_INTERVAL")){
				polling_interval 	= commonBean.getVar_value();
			}else if(var_name.equals("UCM-JOB_YAML_FILE")){
				yaml_file 			= commonBean.getVar_value();
			}else if(var_name.equals("UCM-JOB_YAML_FILE_N002_element")){
				file_content 			= commonBean.getVar_value();
			}else if(var_name.equals("UCM-JOB_SPEC_TYPE")){
				job_spec_type		= commonBean.getVar_value();
			}else if(var_name.equals("UCM-OS_EXIT_CODE")){
				os_exit_code 		= commonBean.getVar_value();
			}
			


			
			//%%DB-ACCOUNT
			//%%DB-DB_TYPE
			//%%DB-EXEC_TYPE
			//%%DB-STP_SCHEM
			//%%DB-STP_NAME
			//%%DB-QTXT-N001-SUBQTXT
			//%%DB-QTXT-N001-SUBQLENGTH
			//%%DB-STP_PARAMS-P001-PRM_NAME
			//%%DB-STP_PARAMS-P001-PRM_TYPE
			//%%DB-STP_PARAMS-P001-PRM_DIRECTION
			//%%DB-STP_PARAMS-P001-PRM_SETVAR
			//%%DB-AUTOCOMMIT
			//%%DB-APPEND_LOG
			//%%DB-APPEND_OUTPUT
			//%%DB-OUTPUT_FORMAT
			
			//Database
			if(var_name.equals("%%DB-ACCOUNT")){
				db_con_pro = commonBean.getVar_value();
			}else if(var_name.equals("%%DB-DB_TYPE")){
				database_type = commonBean.getVar_value();
			}else if(var_name.equals("%%DB-EXEC_TYPE")){
				execution_type = commonBean.getVar_value();
				if(execution_type.equals("Open Query")){
					execution_type = "Q"; 
				}else if(execution_type.equals("Stored Procedure")){
					execution_type = "P"; 
				}
			}else if(var_name.equals("%%DB-STP_SCHEM")){
				schema = commonBean.getVar_value();
			}else if(var_name.equals("%%DB-STP_NAME")){
				sp_name = commonBean.getVar_value();
			}else if(var_name.equals("%%DB-QTXT-N001-SUBQTXT")){
				query = commonBean.getVar_value();
			}else if(var_name.equals("%%DB-AUTOCOMMIT")){
				db_autocommit = commonBean.getVar_value();
			}else if(var_name.equals("%%DB-APPEND_LOG")){
				append_log = commonBean.getVar_value();
			}else if(var_name.equals("%%DB-APPEND_OUTPUT")){
				append_output = commonBean.getVar_value();
			}else if(var_name.equals("%%DB-OUTPUT_FORMAT")){
				db_output_format = commonBean.getVar_value();
				
				if(db_output_format.equals("Text")){
					db_output_format = "T";
				}else if(db_output_format.equals("CSV")){
					db_output_format = "C";
				}else if(db_output_format.equals("XML")){
					db_output_format = "X";
				}else if(db_output_format.equals("HTML")){
					db_output_format = "H";
				}
			}else if(var_name.equals("%%DB-CSV_SEPERATOR")){
				csv_seperator = commonBean.getVar_value();
			}
			if(var_name.startsWith("%%DB-STP_PARAMS-")){
				CommonBean newBean = new CommonBean();
				newBean.setVar_name(var_name);
				newBean.setVar_value(commonBean.getVar_value());
			  	inOutList.add(newBean);
			}
		}
	}
	
	String FTP_ACCOUNT		= "";
	if(setvarList != null){
		for ( int i = 0; i < setvarList.size(); i++ ) {
			CommonBean commonBean = (CommonBean) setvarList.get(i);
			var_name	= commonBean.getVar_name();
			
			if(var_name.equals("FTP_ACCOUNT")){
				FTP_ACCOUNT = commonBean.getVar_value();
			}
			
		}
	}
	
	String[] aTmp 	= null;
	String[] aTmpT 	= null;
	
	String strUserNm1			= "";
	String strUserNm2			= "";
	String strUserNm3			= "";
	String strUserNm4 			= "";
	String strUserNm5			= "";
	String strUserNm6			= "";
	String strUserNm7			= "";
	String strUserNm8 			= "";
	String strUserNm9				= "";
	String strUserNm10 				= "";

	String strDescription		= "";
	String strErrorDescription		= "";

	String strSms1 				= "";
	String strSms2 				= "";
	String strSms3 				= "";
	String strSms4 				= "";
	String strSms5 				= "";
	String strSms6 				= "";
	String strSms7 				= "";
	String strSms8 				= "";
	String strSms9				= "";
	String strSms10				= "";
	String strMail1 			= "";
	String strMail2 			= "";
	String strMail3 			= "";
	String strMail4 			= "";
	String strMail5 			= "";
	String strMail6 			= "";
	String strMail7 			= "";
	String strMail8 			= "";
	String strMail9					= "";
	String strMail10				= "";

	String strGrpCd1 				= "";
	String strGrpCd2 				= "";
	String strGrpNm1				= "";
	String strGrpNm2				= "";
	String strGrpSms1				= "";
	String strGrpSms2				= "";
	String strGrpMail1				= "";
	String strGrpMail2				= "";

	String strLateSub			= "";
	String strLateTime			= "";
	String strLateExec			= "";

	String batchJobGrade			= "";

	String strJobTypeGb           = "";
	
	String jobTypeGb             = "";

	String strUserCd1 = "";
	String strUserCd2 = "";
	String strUserCd3 = "";
	String strUserCd4 = "";
	String strUserCd5 = "";
	String strUserCd6 = "";
	String strUserCd7 = "";
	String strUserCd8 = "";
	String strUserCd9				= "";
	String strUserCd10 				= "";

	String	strSuccessSmsYn			= "";
		
	if ( jobMapperBean != null ) {
		
		strUserCd1 			= CommonUtil.isNull(jobMapperBean.getUser_cd_1());
		strUserCd2 			= CommonUtil.isNull(jobMapperBean.getUser_cd_2());
		strUserCd3 			= CommonUtil.isNull(jobMapperBean.getUser_cd_3());
		strUserCd4 			= CommonUtil.isNull(jobMapperBean.getUser_cd_4());
		strUserCd5 			= CommonUtil.isNull(jobMapperBean.getUser_cd_5());
		strUserCd6 			= CommonUtil.isNull(jobMapperBean.getUser_cd_6());
		strUserCd7 			= CommonUtil.isNull(jobMapperBean.getUser_cd_7());
		strUserCd8 			= CommonUtil.isNull(jobMapperBean.getUser_cd_8());
		strUserCd9 				= CommonUtil.isNull(jobMapperBean.getUser_cd_9());
		strUserCd10 			= CommonUtil.isNull(jobMapperBean.getUser_cd_10());
		strUserNm1 			= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getUser_nm_1()), "");
		strUserNm2 			= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getUser_nm_2()), "");
		strUserNm3 			= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getUser_nm_3()), "");
		strUserNm4 			= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getUser_nm_4()), "");
		strUserNm5 			= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getUser_nm_5()), "");
		strUserNm6 			= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getUser_nm_6()), "");
		strUserNm7 			= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getUser_nm_7()), "");
		strUserNm8 			= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getUser_nm_8()), "");
		strUserNm9 				= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getUser_nm_9()), "");
		strUserNm10 			= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getUser_nm_10()), "");

		strDescription 		= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getDescription()), "");
		strErrorDescription 	= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getError_description()), "");

		strSms1 			= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getSms_1()), "");
		strSms2 			= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getSms_2()), "");
		strSms3 			= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getSms_3()), "");
		strSms4 			= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getSms_4()), "");
		strSms5 			= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getSms_5()), "");
		strSms6 			= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getSms_6()), "");
		strSms7 			= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getSms_7()), "");
		strSms8 			= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getSms_8()), "");
		strSms9 				= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getSms_9()), "");
		strSms10 				= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getSms_10()), "");
		strMail1 			= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getMail_1()), "");
		strMail2 			= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getMail_2()), "");
		strMail3 			= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getMail_3()), "");
		strMail4 			= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getMail_4()), "");
		strMail5 			= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getMail_5()), "");
		strMail6 			= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getMail_6()), "");
		strMail7 			= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getMail_7()), "");
		strMail8 			= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getMail_8()), "");
		strMail9 				= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getMail_9()), "");
		strMail10 				= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getMail_10()), "");

		strGrpCd1				= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getGrp_cd_1()), "");
		strGrpCd2				= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getGrp_cd_2()), "");
		strGrpNm1				= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getGrp_nm_1()), "");
		strGrpNm2				= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getGrp_nm_2()), "");
		strGrpSms1				= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getGrp_sms_1()), "");
		strGrpSms2				= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getGrp_sms_2()), "");
		strGrpMail1				= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getGrp_mail_1()), "");
		strGrpMail2				= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getGrp_mail_2()), "");

		strLateSub 			= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getLate_sub()), "");
		strLateTime			= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getLate_time()), "");
		strLateExec 		= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getLate_exec()), "");
		
		strSuccessSmsYn		= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getSuccess_sms_yn()), "N");

		if(strUserNm2.equals("")){
			strSms2 = "";
			strMail2 = "";
		}
		
		if(strUserNm3.equals("")){
			strSms3 = "";
			strMail3 = "";
		}
		
		if(strUserNm4.equals("")){
			strSms4 = "";
			strMail4 = "";
		}
		
		if(strUserNm5.equals("")){
			strSms5 = "";
			strMail5 = "";
		}
		
		if(strUserNm6.equals("")){
			strSms6 = "";
			strMail6 = "";
		}
		
		if(strUserNm7.equals("")){
			strSms7 = "";
			strMail7 = "";
		}
		
		if(strUserNm8.equals("")){
			strSms8 = "";
			strMail8 = "";
		}

		if(strUserNm9.equals("")){
			strSms9 = "";
			strMail9 = "";
		}

		if(strUserNm10.equals("")){
			strSms10 = "";
			strMail10 = "";
		}

		if(strGrpNm1.equals("")){
			strGrpSms1 = "";
			strGrpMail1 = "";
		}

		if(strGrpNm2.equals("")){
			strGrpSms2 = "";
			strGrpMail2 = "";
		}
	}
	
	// Argument가 동기화가 안될 수 있어서 CommandLine의 파라미터를 기준으로 셋팅해준다.
	String strCommand = CommonUtil.replaceHtmlStr(CommonUtil.isNull(docBean.getCommand()));

	ApprovalInfoBean bean2 = (ApprovalInfoBean)request.getAttribute("bean2");
	
	String strApprovalMent = "";
	
	if ( bean2 != null ) {
		strApprovalMent = CommonUtil.isNull(CommonUtil.E2K(bean2.getApproval_ment()), "");
	}
	
	String strCyclic			= CommonUtil.E2K(docBean.getCyclic());
	String strRerunInterval 	= CommonUtil.E2K(docBean.getRerun_interval());
	String strCyclicType 		= CommonUtil.E2K(docBean.getCyclic_type());
	String strCountCyclicFrom 	= CommonUtil.E2K(docBean.getCount_cyclic_from());
	String strIntervalSequence 	= CommonUtil.E2K(docBean.getInterval_sequence());
	String strTolerance 		= CommonUtil.E2K(docBean.getTolerance());
	String strSpecificTimes 	= CommonUtil.E2K(docBean.getSpecific_times());
	
	String strMaxWait 			= CommonUtil.isNull(docBean.getMax_wait());
	
	String strCycleMent = "";
	if ( strCyclicType.equals("C") ) {
		strCycleMent = "반복주기 : " + strRerunInterval + " (분단위) ";
	} else if ( strCyclicType.equals("V") ) {
		strCycleMent = "반복주기(불규칙) : " + strIntervalSequence + " (분단위) ";
	} else if ( strCyclicType.equals("S") ) {
		strCycleMent = "시간지정 : " + strSpecificTimes + " (HHMM) ";
	}
	
	// 반복주기(불규칙)의 필요없는 문자 제거
	if ( !strIntervalSequence.equals("") ) {
		strIntervalSequence = strIntervalSequence.replaceAll("[+]", "").replaceAll("M", "");
	}
	
	String strJobGubun	= CommonUtil.isNull(paramMap.get("job_gubun"));
	
	// 세션값 가져오기.
	String strSessionUserId = S_USER_ID;
	String strSessionUserNm = S_USER_NM;

	String argument_tmp  = "";
	
	String fromTime = CommonUtil.isNull(docBean.getTime_from()); 
	String h_fromTime = "";
	String m_fromTime = "";
	String vh_fromTime = "";
	String vm_fromTime = "";
	if ( fromTime.length() == 4 ) {
		h_fromTime = fromTime.substring(0,2);
		m_fromTime = fromTime.substring(2,4);
		vh_fromTime = fromTime.substring(0,2);
		vm_fromTime = fromTime.substring(2,4);
		
	}else{
		h_fromTime = "--선택--";
		m_fromTime = "--선택--";
		vh_fromTime = "";
		vm_fromTime = "";
	}

	String timeUntil = CommonUtil.isNull(docBean.getTime_until());
	boolean ignoreTimeUntil = false;
	if (timeUntil.equals(">"))
		ignoreTimeUntil = true;

	String h_timeUntil = "";
	String m_timeUntil = "";
	String vh_timeUntil = "";
	String vm_timeUntil = "";
	
	if ( timeUntil.length() == 4 ) {
		h_timeUntil = timeUntil.substring(0,2);
		m_timeUntil = timeUntil.substring(2,4);
		vh_timeUntil = timeUntil.substring(0,2);
		vm_timeUntil = timeUntil.substring(2,4);
		
	}else{
		h_timeUntil = "--선택--";
		m_timeUntil = "--선택--";
		vh_timeUntil = "";
		vm_timeUntil = "";
	}
	
	String h_lateSub = "";
	String m_lateSub = "";
	String vh_lateSub = "";
	String vm_lateSub = "";

	if ( strLateSub.length() == 4 ) {
		h_lateSub = strLateSub.substring(0,2);
		m_lateSub = strLateSub.substring(2,4);
		vh_lateSub = strLateSub.substring(0,2);
	    vm_lateSub = strLateSub.substring(2,4);
		
	}else{
		h_lateSub = "--선택--";
		m_lateSub = "--선택--";
		
		vh_lateSub = "";
	    vm_lateSub = "";
		
	}

	String h_lateTime = "";
	String m_lateTime = "";
	String vh_lateTime = "";
	String vm_lateTime = "";

	if ( strLateTime.length() == 4 ) {
		h_lateTime = strLateTime.substring(0,2);
		m_lateTime = strLateTime.substring(2,4);
		vh_lateTime = strLateTime.substring(0,2);
	    vm_lateTime = strLateTime.substring(2,4);
		
	}else{
		h_lateTime = "--선택--";
		m_lateTime = "--선택--";
		
		vh_lateTime = "";
	    vm_lateTime = "";
		
	}

	String strConfirmFlag 	= CommonUtil.isNull(docBean.getConfirm_flag());
	String strPriority 		= CommonUtil.isNull(docBean.getPriority());
	String strApplyCd		= CommonUtil.isNull(docBean.getApply_cd());
	
	String strDataCenter    = CommonUtil.isNull(docBean.getData_center());
	
	// 의뢰자 정보
	String strInsUserNm = CommonUtil.isNull(docBean.getUser_nm());
	String strInsDeptNm = CommonUtil.isNull(docBean.getDept_nm());
	String strInsDutyNm = CommonUtil.isNull(docBean.getDuty_nm());
	
	String strUserInfo = "["+S_DEPT_NM+"] ["+S_DUTY_NM+"] "+S_USER_NM;
	if ( !strInsUserNm.equals("") ) {
		strUserInfo = "["+strInsDeptNm+"] ["+strInsDutyNm+"] "+strInsUserNm;
	}

	//반영일
	String strApplyDate = CommonUtil.isNull(docBean.getApply_date());

	//후결유무
	String post_approval_yn = CommonUtil.isNull(docBean.getPost_approval_yn());

%>

<body id='body_A01' leftmargin="0" topmargin="0">

<div style="width:100%; height:100%; overflow-x:hidden; overflow-y:scroll;">
<form id="f_s" name="f_s" method="post" onsubmit="return false;">	
	<input type="hidden" name="p_data_center" 		id="p_data_center" />
	<input type="hidden" name="p_application" 		id="p_application" />
	<input type="hidden" name="p_group_name_of_def" id="p_group_name_of_def" />
	<input type="hidden" name="p_search_gubun" 		id="p_search_gubun" />
	<input type="hidden" name="p_search_text" 		id="p_search_text" />
	
	<input type="hidden" name="p_scode_cd" 			id="p_scode_cd" />
	<input type="hidden" name="p_grp_depth" 		id="p_grp_depth" />
	<input type="hidden" name="p_app_nm" 			id="p_app_nm" />
	<input type="hidden" name="p_app_search_gubun" 	id="p_app_search_gubun" />
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
	<input type="hidden" name="search_moneybatchjob"	id="search_moneybatchjob" 	value="<%=search_moneybatchjob%>" />
	<input type="hidden" name="search_critical"			id="search_critical" 		value="<%=search_critical%>" />
	<input type="hidden" name="search_approval_state"	id="search_approval_state" 	value="<%=search_approval_state%>" />
	<input type="hidden" name="search_check_approval_yn"	id="search_check_approval_yn" 	value="<%=search_check_approval_yn%>" />
	<input type="hidden" name="tabId"					id="tabId"						value="<%=tabId%>" />
</form>
<form name="frm_down" id="frm_down" method="post" onsubmit="return false;">
	<input type="hidden" name="flag" 			id="flag"/>
	<input type="hidden" name="file_gb" 		id="file_gb" />
	<input type="hidden" name="data_center" 	id="data_center" value="<%=strDataCenter %>"/>
	<input type="hidden" name="job_nm" 			id="job_nm" />
	<input type="hidden" name="doc_cd" 			id="doc_cd" />
</form>

<!-- 스케줄 미리보기용 form -->
<form name="frm_sch" id="frm_sch" method="post" onsubmit="return false;">
	<input type="hidden" name="data_center" 	id="data_center" 		value="<%=strDataCenter %>"/>
	<input type="hidden" name="month_days" 		id="month_days"			value="<%=CommonUtil.E2K(docBean.getMonth_days()) %>"/>
	<input type="hidden" name="week_days" 		id="week_days" 			value="<%=CommonUtil.E2K(docBean.getWeek_days()) %>"/>
	<input type="hidden" name="days_cal" 		id="days_cal" 			value="<%=CommonUtil.E2K(docBean.getDays_cal()) %>"/>
	<input type="hidden" name="weeks_cal" 		id="weeks_cal" 			value="<%=CommonUtil.E2K(docBean.getWeeks_cal()) %>"/>
	<input type="hidden" name="schedule_and_or"	id="schedule_and_or" 	value="<%=CommonUtil.E2K(docBean.getSchedule_and_or()) %>"/>
	<input type="hidden" name="month_1" 		id="month_1" 			value="<%=CommonUtil.E2K(docBean.getMonth_1()) %>"/>
	<input type="hidden" name="month_2" 		id="month_2" 			value="<%=CommonUtil.E2K(docBean.getMonth_2()) %>"/>
	<input type="hidden" name="month_3" 		id="month_3" 			value="<%=CommonUtil.E2K(docBean.getMonth_3()) %>"/>
	<input type="hidden" name="month_4" 		id="month_4"			value="<%=CommonUtil.E2K(docBean.getMonth_4()) %>"/>
	<input type="hidden" name="month_5" 		id="month_5" 			value="<%=CommonUtil.E2K(docBean.getMonth_5()) %>"/>
	<input type="hidden" name="month_6" 		id="month_6" 			value="<%=CommonUtil.E2K(docBean.getMonth_6()) %>"/>
	<input type="hidden" name="month_7" 		id="month_7" 			value="<%=CommonUtil.E2K(docBean.getMonth_7()) %>"/>
	<input type="hidden" name="month_8" 		id="month_8" 			value="<%=CommonUtil.E2K(docBean.getMonth_8()) %>"/>
	<input type="hidden" name="month_9" 		id="month_9" 			value="<%=CommonUtil.E2K(docBean.getMonth_9()) %>"/>
	<input type="hidden" name="month_10" 		id="month_10" 			value="<%=CommonUtil.E2K(docBean.getMonth_10()) %>"/>
	<input type="hidden" name="month_11" 		id="month_11" 			value="<%=CommonUtil.E2K(docBean.getMonth_11()) %>"/>
	<input type="hidden" name="month_12" 		id="month_12" 			value="<%=CommonUtil.E2K(docBean.getMonth_12()) %>"/>
	<input type="hidden" name="active_from" 	id="active_from" 		value="<%=CommonUtil.E2K(docBean.getActive_from()) %>"/>
	<input type="hidden" name="active_till" 	id="active_till" 		value="<%=CommonUtil.E2K(docBean.getActive_till()) %>"/>
	<input type="hidden" name="conf_cal" 		id="conf_cal" 			value="<%=CommonUtil.E2K(docBean.getConf_cal()) %>"/>
	<input type="hidden" name="shift_num" 		id="shift_num" 			value="<%=CommonUtil.E2K(docBean.getShift_num()) %>"/>
	<input type="hidden" name="shift" 			id="shift" 				value="<%=CommonUtil.E2K(docBean.getShift()) %>"/>
</form>

<form id="frm1" name="frm1" method="post" onsubmit="return false;" enctype="multipart/form-data" >

	<input type="hidden" name="flag" 				id="flag"/>
	<input type="hidden" name="is_valid_flag" 		id="is_valid_flag" />
	
	<input type="hidden" name="t_general_date" 		id="t_general_date" />
	<input type="hidden" name="t_conditions_in" 	id="t_conditions_in" />
	<input type="hidden" name="t_conditions_out" 	id="t_conditions_out" />
	<input type="hidden" name="t_resources_q" 		id="t_resources_q" />
	<input type="hidden" name="t_resources_c" 		id="t_resources_c" />
	<input type="hidden" name="t_set" 				id="t_set" />
	<input type="hidden" name="t_steps" 			id="t_steps" />
	<input type="hidden" name="t_postproc" 			id="t_postproc" />
	<input type="hidden" name="t_tag_name" 			id="t_tag_name"/>
	
	<input type='hidden' name='p_apply_date'		id='p_apply_date' />
	<input type='hidden' name='apply_cd'			id='apply_cd' />
	
	<input type="hidden" name="doc_gb" 				id="doc_gb" value="<%=doc_gb %>" />
	<input type="hidden" name="post_approval_yn" 	id="post_approval_yn" 		value="<%=post_approval_yn %>" />
	<input type="hidden" name="retro" 				id="retro"	value="0" />
	
	<!-- Cyclic 작업 셋팅 파라미터. -->
	<input type="hidden" name="rerun_interval" 		id="rerun_interval"			value="<%=strRerunInterval%>" />
	<input type="hidden" name="rerun_interval_time" id="rerun_interval_time"	value="M" />
	<input type="hidden" name="cyclic_type" 		id="cyclic_type" 			value="<%=strCyclicType%>" />
	<input type="hidden" name="count_cyclic_from" 	id="count_cyclic_from" 		value="<%=strCountCyclicFrom%>" />
	<input type="hidden" name="interval_sequence" 	id="interval_sequence" 		value="<%=strIntervalSequence%>" />
	<input type="hidden" name="tolerance" 			id="tolerance" 				value="<%=strTolerance%>" />
	<input type="hidden" name="specific_times" 		id="specific_times" 		value="<%=strSpecificTimes%>" />
	<input type="hidden" name="max_wait" 			id="max_wait"				value="<%=strMaxWait%>" />
	
	<input type="hidden" name="user_cd" 			id="user_cd"/>	
	
	<input type="hidden" name="host_cd" 			id="host_cd" />
	<input type="hidden" name="doc_cd" 				id="doc_cd" 				value="<%=doc_cd%>"/>
	<input type="hidden" name="doc_cnt"				id="doc_cnt"				value="<%=doc_cnt%>" />

	<input type="hidden" name="approval_cd"			id="approval_cd" />
	<input type="hidden" name="approval_seq"		id="approval_seq" />
	<input type="hidden" name="approval_comment"	id="approval_comment" />
	
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
	<input type="hidden" name="search_moneybatchjob"	id="search_moneybatchjob" 	value="<%=search_moneybatchjob%>" />
	<input type="hidden" name="search_critical"			id="search_critical" 		value="<%=search_critical%>" />
	<input type="hidden" name="search_approval_state"	id="search_approval_state" 	value="<%=search_approval_state%>" />
	<input type="hidden" name="search_check_approval_yn"	id="search_check_approval_yn" 	value="<%=search_check_approval_yn%>" />
	<input type="hidden" name="tabId"						id="tabId"						value="<%=tabId%>" />
	
	<input type="hidden" name="check_doc_cd" />
	<input type="hidden" name="check_data_center" />
	
	<input type="hidden" name="doc_cds" 	id="doc_cds" 		/>
	<input type="hidden" name="doc_gbs"		id="doc_gbs"		/>
	
	<!-- MFT 정보 -->
	<input type='hidden' name='advanced_num' 		id='advanced_num' 	value='' />
	<input type='hidden' name='advanced' 			id='advanced' 		value='' />
	<input type='hidden' name='FTP_LHOST' 			id='FTP_LHOST' 		value='' />
	<input type='hidden' name='FTP_RHOST' 			id='FTP_RHOST' 		value='' />
	<input type='hidden' name='FTP_LOSTYPE' 		id='FTP_LOSTYPE' 	value='' />
	<input type='hidden' name='FTP_ROSTYPE' 		id='FTP_ROSTYPE' 	value='' />
	<input type='hidden' name='FTP_LUSER' 			id='FTP_LUSER' 		value='' />
	<input type='hidden' name='FTP_RUSER' 			id='FTP_RUSER' 		value='' />
	<input type='hidden' name='FTP_CONNTYPE1' 		id='FTP_CONNTYPE1' 	value='' />
	<input type='hidden' name='FTP_CONNTYPE2' 		id='FTP_CONNTYPE2' 	value='' />
	
	<!-- kubernetes 변수 -->
	<input type='hidden' name='con_pro' 			id='con_pro' 			value="<%=con_pro%>"/>
	<input type='hidden' name='job_spec_type' 		id='job_spec_type' 		value="<%=job_spec_type%>"/>
	<input type='hidden' name='yaml_file' 			id='yaml_file' 			value="<%=yaml_file%>"/>
	<input type='hidden' name='spec_param' 			id='spec_param' 		value="<%=spec_param%>"/>
	<input type='hidden' name='os_exit_code' 		id='os_exit_code' 		value="<%=os_exit_code%>"/>
	<input type='hidden' name='get_pod_logs' 		id='get_pod_logs' 		value="<%=get_pod_logs%>"/>
	<input type='hidden' name='job_cleanup' 		id='job_cleanup' 		value="<%=job_cleanup%>"/>
	<input type='hidden' name='polling_interval' 	id='polling_interval' 	value="<%=polling_interval%>"/>
	
<table style='width:100%;height:100%;border:none;'>
	<tr style='height:10px;'>
		<td style='vertical-align:top;'>
			<h4 class="ui-widget-header ui-corner-all"  >
				<div id='t_<%=gridId %>' class='title_area'>
					<span><%=CommonUtil.getMessage("CATEGORY.GB.03.SB.0302") %></span>
				</div>
			</h4>
		</td>
	</tr>
	<tr>
		<td id='ly_<%=gridId %>' style='vertical-align:top;'>			
			<div id="<%=gridId %>" class="ui-widget-header_kang ui-corner-all">
			
				<table style="width:100%">
					
					<tr>
						<td>
							<div class='cellTitle_kang5'>결재 정보</div>
						</td>
					</tr>
					<tr>
						<td valign="top">
							<table style="width:100%">
							<tr>
							<%
								for( int i=0; null!=approvalInfoList && i<approvalInfoList.size(); i++ ) {
									ApprovalInfoBean bean = (ApprovalInfoBean)approvalInfoList.get(i);
									
									String strLineGb			= CommonUtil.isNull(bean.getLine_gb());
									String strApprovalGb		= CommonUtil.isNull(bean.getApproval_gb());
									String strApprovalCd		= CommonUtil.isNull(bean.getApproval_cd());
									String strApprovalDate		= CommonUtil.isNull(bean.getApproval_date());
									String strApprovalComment	= CommonUtil.isNull(bean.getApproval_comment());
									String strGroupLineGrpNm	= CommonUtil.isNull(bean.getGroup_line_grp_nm());
									String strUpdateUserNm		= CommonUtil.isNull(bean.getUpdate_user_nm());
									String strApprovalType		= CommonUtil.isNull(bean.getApproval_type());
									
									String strApprovalGbMent 	= "";
									String strGroupApprovalUser = "";
									String strApprovalTypeNm	= "";
									if(strApprovalType.equals("03")) strApprovalTypeNm = "[후결]";
									
									if(!strApprovalGb.equals("")) {
										strApprovalGbMent = CommonUtil.getMessage("USER.APPR.GB."+strApprovalGb);
									}else {
										strApprovalGbMent = "즉시 결재자";
									}

									String strApprovalCdMent 	= CommonUtil.getMessage("DOC.APPROVAL."+strApprovalCd);
									
									String strApprovalCdMent2	= "";
									if ( !strApprovalCd.equals("00") && !strApprovalCd.equals("01") ) {
										strApprovalCdMent2 = strGroupApprovalUser + ":" + strApprovalDate;
									}									
							%>
									<td width="200"> 
										<div class='cellTitle_ez_center' style='min-width:30%; min-height:30px;' >
											<%=strApprovalGbMent%>
											<%
												if ( !strApprovalComment.equals("") ) { 
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
								for( int i=0; null!=approvalInfoList && i<approvalInfoList.size(); i++ ) {
									ApprovalInfoBean bean = (ApprovalInfoBean)approvalInfoList.get(i);
									
									String strApprovalComment	= CommonUtil.isNull(bean.getApproval_comment());
							%>
									<td width="200"> 
											<%
											if( !strApprovalComment.equals("") ){
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
								for( int i=0; null!=approvalInfoList && i<approvalInfoList.size(); i++ ) {
									ApprovalInfoBean bean = (ApprovalInfoBean)approvalInfoList.get(i);
									
									String strApprovalCd 		= CommonUtil.isNull(bean.getApproval_cd());
									String strSeq 				= CommonUtil.isNull(bean.getSeq());
									String strApprovalUserNm	= CommonUtil.isNull(CommonUtil.E2K(bean.getUser_nm()));
									String strDutyCd			= CommonUtil.isNull(bean.getDuty_cd());
									String strUserCd			= CommonUtil.isNull(bean.getUser_cd());
									
									String strUdtUserCd			= CommonUtil.isNull(bean.getUdt_user_cd());
									String strUdtUserNm			= CommonUtil.isNull(bean.getUpdate_user_nm());
									String strUdtDeptNm			= CommonUtil.isNull(bean.getUpdate_dept_nm());
									String strUdtDutyNm			= CommonUtil.isNull(bean.getUpdate_duty_nm());
									
									String strAbsenceUserCd		= CommonUtil.isNull(bean.getAbsence_user_cd());
									String strAbsenceUserNm		= CommonUtil.isNull(bean.getAbsence_user_nm());
									String strAbsenceDeptNm		= CommonUtil.isNull(bean.getAbsence_dept_nm());
									String strAbsenceDutyNm		= CommonUtil.isNull(bean.getAbsence_duty_nm());
									String strLineGb			= CommonUtil.isNull(bean.getLine_gb());
									String strGroupLineGrpNm	= CommonUtil.isNull(bean.getGroup_line_grp_nm());
									
									String userInfo				= "";
									String strAbsenceInfo		= "";
									
									// 결재 시 대결자 정보가 있으면 대결자 셋팅
									if( strUdtUserCd.equals("") && !strAbsenceUserCd.equals("0") && strGroupLineGrpNm.equals("") ) {
										strAbsenceInfo = "["+CommonUtil.E2K(bean.getDept_nm())+"]["+CommonUtil.E2K(bean.getDuty_nm())+"]"+CommonUtil.E2K(bean.getUser_nm()) + " (대결자:" + strAbsenceUserNm + ")";
									}
									
									// 결재사용자코드와 업데이트한 사용자코드가 다르면 대결로 간주
									if ( !strUserCd.equals(strUdtUserCd) && !strUdtUserCd.equals("") && strGroupLineGrpNm.equals("") ) {
										strAbsenceInfo = "["+strUdtDeptNm+"]["+strUdtDutyNm+"]"+strUdtUserNm +"(대결)";
									}
									
									//userInfo = "["+CommonUtil.E2K(bean.getDept_nm())+"]["+CommonUtil.E2K(bean.getDuty_nm())+"]<br>"+CommonUtil.E2K(bean.getUser_nm());
									userInfo = "["+CommonUtil.E2K(bean.getDept_nm())+"]["+CommonUtil.E2K(bean.getDuty_nm())+"]"+CommonUtil.E2K(bean.getUser_nm());
									
									if ( !strGroupLineGrpNm.equals("") ) {
										userInfo = "[그룹]" + strGroupLineGrpNm;
										if ( !strUdtUserNm.equals("") ) {
											userInfo += "(" + strUdtUserNm + ")";
										}
									}
									
									// 대결
									if ( !strAbsenceInfo.equals("") ) {
										userInfo = strAbsenceInfo; 
									}
							%>
									<td width="200"> 
										<div class='cellTitle_kang3' ><a href="javascript:dynamicApprovalUserInfo('<%=sContextPath%>','<%=strUserCd%>','<%=strGroupLineGrpNm%>','<%=strLineGb %>','<%=doc_cd%>','<%=strSeq%>','<%=strApprovalCd%>')"><%=userInfo%></a></div>
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
							<div class='cellTitle_kang5'>요청 정보</div>
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
											<a href="JavaScript:docUserInfo('<%=doc_cd %>');" style="text-decoration:underline;"><font color="black"><%=strUserInfo %></font></a>
										</div>
									</td>
									<td>
										<div class='cellTitle_ez_right' style='min-width:120px' ><font color="red">* </font>반 영 일</div>
									</td>
									<td colspan="2">
										<%=strApplyDate%>
									</td>
								</tr>
								<tr>
									<td style="vertical-align:top;">
										<div class='cellTitle_ez_right'><font color="red">* </font>요청 사유</div>
									</td>
									<td colspan="5" style="vertical-align:top;">
										<div class='cellContent_kang' style='height:auto;'><%=CommonUtil.E2K(docBean.getTitle()) %></div>
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
				<table style="width:100%">
					<tr>
						<td>
							<div class='cellTitle_kang5'>작업 정보 [문서정보 : <%=doc_cd %>]</div>
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
										<div class='cellTitle_ez_right'><font color="red">* </font>C-M</div>
									</td>									
									<td> 										
										<div class='cellContent_kang'>
											<select style="display:none;" name="data_center_items" id="data_center_items" style="width:70%;height:21px;">
												<option value="">--선택--</option>
												<option selected value="<%=strDataCenter %>"><%=CommonUtil.E2K(docBean.getData_center()) %></option>
											</select>
											<%=CommonUtil.E2K(docBean.getData_center_name()) %>
											<input type="hidden" name="data_center" id="data_center" value="<%=CommonUtil.E2K(docBean.getData_center()) %>" style="width:70%;height:21px;"/>
											<input type="hidden" name="data_center2" id="data_center2" value="<%=CommonUtil.E2K(docBean.getData_center()) %>" style="width:70%;height:21px;"/>
										</div>
									</td>
									<td> 
										<div class='cellTitle_ez_right' style='min-width:150px'><font color="red">* </font>작업타입</div>
									</td>  
									<td>
										<div class='cellContent_kang'>
											<%=strTaskType%>
										</div>
									</td>
								</tr>	
								
								<tr>
									<td>  
										<div class='cellTitle_ez_right'><font color="red">* </font>폴더</div>
									</td>  
									<td>
										<div class='cellContent_kang'>
											<%=CommonUtil.isNull(docBean.getTable_name()) %>
										</div>
									</td>
									
									<td>
										<div class='cellTitle_ez_right'><font color="red">* </font>어플리케이션</div>
									</td>
									
									<td>
										<div class='cellContent_kang'>
											<%=CommonUtil.isNull(docBean.getApplication()) %>
										</div>    
									</td>
									
									
									<td>
										<div class='cellTitle_ez_right'><font color="red">* </font>그룹</div>
									</td>
									<td> 
										<div class='cellContent_kang'>
									 		<%=CommonUtil.isNull(docBean.getGroup_name()) %>
										</div>
									</td>
								<tr>							
									<td>
										<div class='cellTitle_ez_right'><font color="red">* </font>수행서버</div>
									</td>
									<td> 
										<div class='cellContent_kang'>
											<%=CommonUtil.E2K(docBean.getNode_id()) %>
										</div>
									</td>
									<td>								
										<div class='cellTitle_ez_right'><font color="red">* </font>계정명</div>
									</td>
									<td> 
										<div class='cellContent_kang'>
											<%=CommonUtil.E2K(docBean.getOwner()) %>
										</div>
									</td>
									<td>
										<div class='cellTitle_ez_right'><font color="red">* </font>최대대기일</div>
									</td>
									<td> 
										<div class='cellContent_kang'>
											<%=CommonUtil.E2K(docBean.getMax_wait()) %>
										</div>
									</td>
								</tr>	
								<tr>
									<td>
										<div class='cellTitle_ez_right'><font color="red">* </font>작업명</div>
									</td>
									<td>
										<div class='cellContent_kang'>
											<%=strJobName%>											
										</div>
									</td>
									<td>
										<div class='cellTitle_ez_right'><font color="red">* </font>작업 설명</div>
									</td>
	        						<td colspan="3">
	        							<div class='cellContent_kang' style='height:auto;'>
	        								<%=CommonUtil.E2K(docBean.getDescription()) %>
	        							</div>        			
	        					   </td>
								</tr>
								
								<tr>
									<td>
										<div class='cellTitle_ez_right'><span class='job_val' style="color:red;"></span>프로그램 명</div>
									</td>
									<td>
										<div class='cellContent_kang'>
											<%=CommonUtil.E2K(docBean.getMem_name()) %>
										</div>
									</td>
									<td>
										<div class='cellTitle_ez_right'><span class='job_val' style="color:red;"></span>프로그램 위치</div>
									</td>
									
									<td colspan="3">
										<div class='cellContent_kang'>
											<%=CommonUtil.E2K(docBean.getMem_lib()) %>
										</div>
									</td>
								</tr>
								
								<tr>  
									<td>
										<div class='cellTitle_ez_right'><span class='command_val' style="color:red;"></span>작업수행명령</div>
									</td>
									<td colspan="5">
										<div class='cellContent_kang'>
											<%=strCommand%>										
										</div>
									</td>
								</tr>
								<tr>
									<td>
										<div class='cellTitle_ez_right'><font id="from_tiem_ondemand" color="red"></font>작업시작시간</div>
									</td> 								
									<td>
										<div class='cellContent_kang'>
											<%=fromTime %>																						
										</div>											
									</td>
									<td>
										<div class='cellTitle_ez_right'>작업종료시간</div>	
									</td> 								
									<td>
										<div class='cellContent_kang'>
											<%=timeUntil %>
										</div>											
									</td>
									<td>
										<div class='cellTitle_ez_right'>과거 ODATE 시간 무시</div>
									</td>
									<td>
										<div class='cellContent_kang'>
											<span style='vertical-align:middle'><input type='checkbox' id='ignore_time_until' name='ignore_time_until' style='vertical-align:middle' disabled/></span>
											<span style='vertical-align:middle'> > (체크시, 과거 ODATE의 작업은 시간 설정 무시하고 수행)</span>
										</div>
									</td>
								</tr>    
								
								<tr>
						        	<td>
										<div class='cellTitle_ez_right'>시작임계시간</div>	
									</td>  
						        	<td>							        	
						        		<div class='cellContent_kang'>
						        			<%=strLateSub %>
										</div>
									</td>
						        	<td>
										<div class='cellTitle_ez_right'>종료임계시간</div>	
									</td>  
						        	<td>							        									        
						        		<div class='cellContent_kang'>
						        			<%=strLateTime %>
										</div>
									</td>
						        	<td>
										<div class='cellTitle_ez_right'>수행임계시간</div>	
									</td>  
						        	<td>
						        		<div class='cellContent_kang'>
						        			<%=strLateExec.replaceAll(">", "") %>분
										</div>
									</td>
					        	</tr>
					        
		        				<tr>
		        					<td>
								 		<div class='cellTitle_ez_right'>반복작업</div>
						        	</td>
									<td colspan='3'>
						        		<div class='cellContent_kang' style='height:auto;'>							        			
											<%=strCyclic.equals("0") ? "N" : "Y" %>
											
											<span id='cyclic_ment'>
											<%
												if ( CommonUtil.getMessage("JOB.CYCLIC."+docBean.getCyclic()).equals("yes") ) {											
													out.println(strCycleMent);
												}
											%>
											</span>
										</div>												
									</td>
									<td>
								 		<div class='cellTitle_ez_right'>최대 반복 횟수</div>
						        	</td>								
									<td>
										<div class='cellContent_kang'>
											<%=CommonUtil.E2K(docBean.getRerun_max()) %>
										</div>
									</td>																		
		        				</tr>			        				
			        			<tr>
		        					<td>
								 		<div class='cellTitle_ez_right'>Confirm Flag</div>
						        	</td>
									<td>
						        		<div class='cellContent_kang'>
											<%=strConfirmFlag.equals("0") ? "N" : "Y" %>
										</div>
									</td>
									<td>
									 	<div class='cellTitle_ez_right'>우선순위</div>
							        </td>
									<td>
										<div class='cellContent_kang'>
											<%=strPriority%>
										</div>
									</td>
									<td>
								 		<div class='cellTitle_ez_right'>성공 시 알람 발송</div>
						        	</td>
						        	<td colspan="3">
						        		<div class='cellContent_kang'>
											<%=strSuccessSmsYn %>
										</div>
									</td>
		        				</tr>
			        				<tr>
				        				<td>
											<div class='cellTitle_ez_right'><!-- <font color="red">* </font> -->중요작업</div>
										</td>
										<td colspan="3">
											<div class='cellContent_kang'>
												<%=CommonUtil.isNull(docBean.getCritical()).equals("0") ? "N" : "Y" %>
								     		</div>
										</td>
			        				</tr>
							</table>
						</td>
					</tr>
				</table>
				
				<table style="width:100%;" id="mftTable">
						<tr>
							<td style='width:100%'>
								<div class='cellTitle_kang5'>MFT 정보</div>									
							</td>
						</tr>
						<tr>
							<td valign="top">
								<table style="width:100%">
									<tr>
										<td width="10%"></td>
										<td width="30%"></td>
										<td width="10%"></td>
										<td width="30%"></td>
									</tr>
									<tr>
										<td><div class='cellTitle_ez_right'>Connection Profile</div></td>
										<td>
											<input class='input' type='text' id='FTP_ACCOUNT'  name='FTP_ACCOUNT' style='width:50%' readonly/>
										</td>
									</tr>
									<tr>
										<td>
											<div class='cellTitle_ez_right'>추가옵션</div>
										</td>
										<td style='text-align:center;'>
											<label for='FTP_USE_DEF_NUMRETRIES' style='width:50%'>
												<input type='checkbox' name='FTP_USE_DEF_NUMRETRIES' id='FTP_USE_DEF_NUMRETRIES' value='1' onclick='ftp_use_def_numretries_check()' checked='checked'/> 
												Use default number of retries&nbsp;&nbsp;&nbsp;&nbsp;
											</label>
											Number of retries :
											<input class='input' type='text' id='FTP_NUM_RETRIES' name='FTP_NUM_RETRIES' value='5' style='background-color: #e2e2e2;' placeholder='(0~99 number)' />
										</td>
										<td style='text-align:center;' colspan="2">
											<label for='FTP_RPF'>
												<input type='checkbox' name='FTP_RPF' id='FTP_RPF' value='1' onclick='checkBoxValue(this)'/> 
													Rerun from point of failure
											</label>
										</td>
										<td style='text-align:center;' colspan="2">
											<label for='FTP_CONT_EXE_NOTOK'><input type='checkbox' name='FTP_CONT_EXE_NOTOK' id='FTP_CONT_EXE_NOTOK' value='1' onclick='checkBoxValue(this)'/> 
												End job NOTOK when 'Continue on failure' option is selected
											</label>
										</td>
									</tr>
									<tr>
										<th id='host11' colspan='2' style='text-align: center;'>HOST1 :   TYPE :   User : </th>
										<th id='host21' colspan='2' style='text-align: center;'>HOST2 :   TYPE :   User : </th>
									</tr>
									<tr>
										<td>
											<div class='cellTitle_ez_center'>Type</div>
										</td>
										<td>
											<div class='cellTitle_ez_center'>출발지</div>
										</td>
										<td>
											<div class='cellTitle_ez_center'>전송타입</div>
										</td>
										<td>
											<div class='cellTitle_ez_center'>도착지</div>
										</td>
									</tr>
									<%
										for(int i=1; i < 6; i++){
											out.println("<tr>");
											out.println("<td>");
											out.println("<div style='text-align:center'>");
											out.println("<select name='FTP_TYPE"+i+"' id='FTP_TYPE"+i+"' style='width:70%;height:21px;'>");
											out.println("<option value='I'>Binary</option>");
											out.println("<option value='A'>Ascii</option>");
											out.println("</select>");
											out.println("</div>");
											out.println("</td>");
											out.println("<td><input type='text' id='FTP_LPATH"+i+"' name='FTP_LPATH"+i+"' style='width:100%'/></td>");
											out.println("<td>");
											out.println("<div style='text-align:center'>");
											out.println("<select name='FTP_UPLOAD"+i+"' id='FTP_UPLOAD"+i+"' >");
											out.println("<option value='1'>--></option>");
											out.println("<option value='0'><--</option>");
											out.println("<option value='2'><-O</option>");
											out.println("<option value='3'>O-></option>");
											out.println("<option value='4'>-O-</option>");
											out.println("</select>&nbsp;");
											out.println("</div>");
											out.println("</td>");
											out.println("<td><input type='text' id='FTP_RPATH"+i+"' name='FTP_RPATH"+i+"' style='width:100%'/></td>");
											out.println("</tr>");
										}
									%>
								</table>
							</td>
						</tr>
					</table>
				
				
				<table style="width:100%;display:none;" id="kubernetes_yn">
					<tr>
						<td>
							<div class='cellTitle_kang5'> Kubernetes </div>
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
										<div class='cellTitle_ez_right'>Connection Profile</div>
									</td>
									<td>
										<div class='cellContent_kang'>
											<%=con_pro%>
										</div>
									</td>
									<td>
										<div class='cellTitle_ez_right'>Job Spec Type</div>
									</td>
									<td>
										<div class='cellContent_kang'>
											<%=job_spec_type%>
										</div>
									</td>
									<td>
										<div class='cellTitle_ez_right'>Job Spec Yaml</div>
									</td>
									<td>	
										<div class='cellContent_kang'>
											<%=yaml_file%>
											<input type='hidden' name='file_content' id="file_content" value="<%=file_content%>"/>
										</div>
									</td>
								</tr>
								<tr>
									<td>
										<div class='cellTitle_ez_right'>Job Spec Parameter</div>
									</td>
									<td colspan="3">
										<div class='cellContent_kang'>
											<%=spec_param%>
										</div>
									</td>
									<td>
										<div class='cellTitle_ez_right'>OS Exit Code</div>
									</td>
									<td>	
										<div class='cellContent_kang'>
											<%=os_exit_code%>
										</div>
									</td>
								</tr>
								<tr>
									<td>
										<div class='cellTitle_ez_right'>Get Pod Logs</div>
									</td>
									<td>
										<div class='cellContent_kang'>
											<%=get_pod_logs%>
										</div>
									</td>
									<td>
										<div class='cellTitle_ez_right'>Job Cleanup</div>
									</td>
									<td>
										<div class='cellContent_kang'>
											<%=job_cleanup%>
										</div>
									</td>
									<td>
										<div class='cellTitle_ez_right'>Polling Interval</div>
									</td>
									<td>
										<div class='cellContent_kang'>
											<%=polling_interval%>
										</div>
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
				
				<table style="width:100%;display:none;" id="database_tb">
					<tr>
						<td>
							<div class='cellTitle_kang5'> Database </div>
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
										<div class='cellTitle_ez_right'>Connection Profile</div>
									</td>
									<td>
										<div class='cellContent_kang'>
											<%=db_con_pro %>
											<input type="hidden" name="db_con_pro" id="db_con_pro" value="<%=db_con_pro %>"/>
										</div>
									</td>
									<td>
										<div class='cellTitle_ez_right'>Database</div>
									</td>
									<td>	
										<div class='cellContent_kang'>
											<%for(int i=0;i<databaseList.size();i++){ 
												CommonBean databaseBean = (CommonBean) databaseList.get(i);
												String strDatabaseName = CommonUtil.isNull(databaseBean.getDatabase_name());
												String strSid = CommonUtil.isNull(databaseBean.getAccess_sid());
												String strServiceName = CommonUtil.isNull(databaseBean.getAccess_service_name());
												
											%>
											<%=!strDatabaseName.equals("") ? strDatabaseName : (!strSid.equals("") ? strSid : strServiceName) %>
											<input type='hidden'   name='database' id='database' value="<%=!strDatabaseName.equals("") ? strDatabaseName : (!strSid.equals("") ? strSid : strServiceName) %>" style="width:85%;height:21px;ime-mode:disabled;" readonly/>
											<input type='hidden' name='db_user' id="db_user"  value="<%=databaseBean.getUser_nm()%>"/>
											<input type='hidden' name='db_host' id="db_host" value="<%=databaseBean.getHost_nm()%>"/>
											<input type='hidden' name='db_port' id="db_port" value="<%=databaseBean.getAccess_port()%>"/>
											<input type='hidden' name='sid' id="sid" value="<%=strSid%>"/>
											<input type='hidden' name='service_name' id="service_name" value="<%=strServiceName%>"/>
											<%} %>
											<input type='hidden' name='database_type' id="database_type" value="<%=database_type%>"/>
										</div>
									</td>
									<td>
										<div class='cellTitle_ez_right'>Execution Type</div>
									</td>
									<td>
										<div class='cellContent_kang'>
										<%=execution_type.equals("P") ? "Stored Procedure" :
                                  		   execution_type.equals("Q") ? "Embedded Query" : "Unknown"%>
											<input type="hidden" name="execution_type" id="execution_type"  />
										</div>
									</td>
								</tr>
								<tr id="db_p_tr" style="display:none;">
									<td>
										<div class='cellTitle_ez_right'>Schema</div>
									</td>
									<td>
										<div class='cellContent_kang'>
											<%=schema %>
											<input type="hidden" name="schema" id="schema" value="<%=schema %>" />
										</div>
									</td>
									<td>
										<div class='cellTitle_ez_right'>Name</div>
									</td>
									<td colspan="2">
										<div class='cellContent_kang'>
											<%=sp_name %>
											<input type="hidden" name="sp_name" id="sp_name" value="<%=sp_name %>"/>
										</div>
									</td>
								</tr>
								<tr id="param_tr" style="display:none;" >
									<td colspan="6">
										<div class='cellTitle_kang6'> Parameter </div>
									</td>
								</tr>
								<tr id="param_header_tr" style="display:none;">
									<td colspan="2" width="30%"><div class='cellTitle_ez_center'>Name</div></td>
									<td  width="10%"><div class='cellTitle_ez_center'>Data Type</div></td>
									<td  width="20%"><div class='cellTitle_ez_center'>Parameter Type</div></td>
									<td  width="10%"><div class='cellTitle_ez_center'>Value</div></td>
									<td  width="20%"><div class='cellTitle_ez_center'>Variable</div></td>
								</tr>
								<%
							  		// 데이터를 그룹화하기 위해 Map 사용
								    Map<String, Map<String, String>> groupedData = new LinkedHashMap<>();
									String s = "";
									int tagIdx = 0;
									for(int i=0;i<inOutList.size(); i++){ 
										 CommonBean commonBean = inOutList.get(i);
								        String varName = commonBean.getVar_name();
								        String varValue = commonBean.getVar_value();

								        // 키 추출 (P001, P002 등)
								        String key = varName.substring("%%DB-STP_PARAMS-".length(), varName.indexOf("-PRM"));

								        // 그룹이 존재하지 않으면 초기화
								        if (!groupedData.containsKey(key)) {
								            groupedData.put(key, new HashMap<String, String>()); // 명시적으로 타입 지정
								        }

								        // 그룹에 데이터 삽입 (PRM_NAME, PRM_TYPE, PRM_DIRECTION 등)
								        String fieldType = varName.substring(varName.indexOf("-PRM_") + 1); // PRM_NAME, PRM_TYPE 등
								        groupedData.get(key).put(fieldType, varValue);
									}
									
									// HTML 테이블 생성
								    for (Map.Entry<String, Map<String, String>> entry : groupedData.entrySet()) {
								        String key = entry.getKey();
								        Map<String, String> fields = entry.getValue();

								        // 필요한 필드 가져오기
								        String prmName = fields.getOrDefault("PRM_NAME", "");
								        String prmType = fields.getOrDefault("PRM_TYPE", "");
								        String prmDirection = fields.getOrDefault("PRM_DIRECTION", "");
								        String prmSetVar = fields.getOrDefault("PRM_SETVAR", ""); // 없으면 빈 문자열
								        String prmValue = fields.getOrDefault("PRM_VALUE", ""); // 없으면 빈 문자열
										
								        if( (prmDirection.equals("Out") || prmDirection.equals("void")) || prmType.equals("Return") ){
								        	s += "<tr>";
											s += "<td colspan='2' width='30%' style='text-align:center;'>";
											s += "<div class='cellContent_kang_center'>";
											s += prmName;
											s += "<input type='hidden' name='ret_data"+tagIdx+"' id='ret_data"+tagIdx+"'   value='"+prmType+"'>";
											s += "<input type='hidden' name='ret_name"+tagIdx+"' id='ret_name"+tagIdx+"'   value='"+prmName+"'>";
											s += "<input type='hidden' name='ret_param"+tagIdx+"' id='ret_param"+tagIdx+"' value='"+prmDirection+"'>";
											s += "</div>";
											s += "</td>";
											s += "<div id='div_param"+tagIdx+"'></div>";
											s += "<td width='10%' style='text-align:center;'><div class='cellContent_kang_center'>"+prmDirection+"</div></td>";
											s += "<td width='20%' style='text-align:center;'><div class='cellContent_kang_center'>"+prmType+"</div></td>";
											s += "<td width='10%' style='text-align:center;'><input type='hidden' class='input' name='ret_variable"+tagIdx+"' id='ret_variable"+tagIdx+"' value='"+prmSetVar+"'/></td>";
											s += "<td width='20%' style='text-align:center;'><div class='cellContent_kang_center'>"+prmSetVar+"</div></td>";
											s += "</tr>";
									        tagIdx++;
								        }else{
								        	s += "<tr>";
											s += "<td colspan='2' width='30%' style='text-align:center;'>";
											s += "<div class='cellContent_kang_center'>";
											s += prmName;
											s += "<input type='hidden' name='in_data"+tagIdx+"' id='in_data"+tagIdx+"'   value='"+prmType+"'>";
											s += "<input type='hidden' name='in_name"+tagIdx+"' id='in_name"+tagIdx+"'   value='"+prmName+"'>";
											s += "<input type='hidden' name='in_param"+tagIdx+"' id='in_param"+tagIdx+"' value='"+prmDirection+"'>";
											s += "</div>";
											s += "</td>";
											s += "<div id='div_param"+tagIdx+"'></div>";
											s += "<td width='10%' style='text-align:center;'><div class='cellContent_kang_center'>"+prmDirection+"</div></td>";
											s += "<td width='20%' style='text-align:center;'><div class='cellContent_kang_center'>"+prmType+"</div></td>";
											s += "<td width='10%' style='text-align:center;'><div class='cellContent_kang_center'>"+prmValue+"</div></td>";
											s += "<td width='20%' style='text-align:center;'><input type='hidden' class='input' name='in_value"+tagIdx+"' id='in_value"+tagIdx+"' value='"+prmValue+"'/></td>";
											s += "</tr>";
									        tagIdx++;
								        }
								    }
									out.println(s);
								%>
								<tr id="db_q_tr" style="display:none;">
									<td>
										<div class='cellTitle_ez_right' style="display: flex;justify-content: flex-end;align-items: center;height: 150px;text-align: right;">Query</div>
									</td>
									<td colspan="5">
										<div class='cellContent_kang' style="height: 150px">
											<textarea name="query" id="query" style="width:62%;height:150px;" cols="30" rows="5" readonly><%=query %></textarea>
										</div>
									</td>
								</tr>
								
								<tr id="db_o_tr">
									<td>
										<div class='cellTitle_ez_right'>추가옵션</div>
									</td>
									<td style='text-align:center;'>
										<label for='DB_AUTOCOMMIT' style='width:50%'>
										<input type='checkbox' name='chk_db_autocommit' id='chk_db_autocommit' <%=db_autocommit.equals("Y") ? "checked" : "" %> disabled/>
											Enable Auto Commit&nbsp;&nbsp;&nbsp;&nbsp;
										</label>
										<input type='hidden' name='db_autocommit' id="db_autocommit" value='<%=db_autocommit.equals("Y") ? "Y" : "" %>'/>
									</td>
									<td style='text-align:center;' colspan="2">
										<label for='DB_APPEND_LOG'>
										<input type='checkbox' name='chk_db_append_log' id='chk_db_append_log' <%=append_log.equals("Y") ? "checked" : "" %> disabled/>
											Append execution log to Job Output
										</label>
										<input type='hidden' name='append_log' id="append_log" value='<%=append_log.equals("Y") ? "Y" : "" %>'/>
									</td>
									<td style='text-align:center;'  colspan="2">
										<label for='DB_APPEND_OUTPUT'><input type='checkbox' name='chk_db_append_output' id='chk_db_append_output' <%=append_output.equals("Y") ? "checked" : "" %> disabled/>
											Append SQL output to Job Output 
										</label>
										<input type='hidden' name='append_output' id="append_output" value='<%=append_output.equals("Y") ? "Y" : "" %>'/>
										(Output format : <%=db_output_format.equals("T") ? "Text" :
							                   db_output_format.equals("C") ? "CSV" :
							                       db_output_format.equals("X") ? "XML" :
							                       db_output_format.equals("H") ? "HTML" : db_output_format  %> <%=db_output_format.equals("C") ? "["+csv_seperator+"]" : "" %>
											<input type="hidden" name=sel_db_output_format id="sel_db_output_format" value="<%=db_output_format %>"/>)
											<input type="hidden" name=csv_seperator id="csv_seperator" value="<%=csv_seperator %>" />)
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
				
				<table style="width:100%">
					<tr style="width:100%;display:none;">
						<td>
							<div class='cellTitle_kang'>스케쥴 정보
								<input type='button' name='btn_CalDetail' value='미리보기' onClick="CalDetail();" class='btn_white_h24'>
							</div>
						</td>	
					</tr>
					<tr>
						<td valign="top">
								<table style="width:100%;display:none;">
									<tr>
										<td width="120px"></td>
										<td width="250px"></td>
										<td width="120px"></td>
										<td width="200px"></td>
										<td width="120px"></td>
										<td width=""></td>
									</tr>
									<tr>
										<td>
											<div class='cellTitle_ez_right'>실행날짜</div>
										</td>
										<td>
											<div class='cellContent_kang'>
												<%=strMonth_days%>
											</div>
										</td>
										<td>
											<div class='cellTitle_ez_right'>조건</div>
										</td>
										<td>
											<div class='cellContent_kang'>
												<select id='schedule_and_or' name='schedule_and_or' style="width:100px;height:21px;" disabled>
												<%
													aTmp = CommonUtil.getMessage("JOB.AND_OR").split(",");
													for ( int i = 0; i < aTmp.length; i++ ) {
														String[] aTmp1 = aTmp[i].split("[|]");
												%>
														<option value='<%=aTmp1[0]%>' <%= ( (aTmp1[0].equals(strSchedule_and_or))? " selected ":"" ) %> ><%=aTmp1[1]%></option>
												<% 
													}
												%>
												</select>
											</div>
										</td>
										<td>
											<div class='cellTitle_ez_right'>실행요일</div>
										</td>
										<td>
											<div class='cellContent_kang'>
												<%-- <%=strWeek_days%> --%>
												<%=CommonUtil.E2K(docBean.getWeek_days()).replaceAll("0","<span style='color:red;'>일</span>").replaceAll("1","월").replaceAll("2","화").replaceAll("3","수").replaceAll("4","목").replaceAll("5","금").replaceAll("6","<span style='color:blue;'>토</span>").replaceAll("W월","<span style='color:#686667;'>W1</span>").replaceAll("W화","<span style='color:#686667;'>W2</span>").replaceAll("W수","<span style='color:#686667;'>W3</span>").replaceAll("W목","<span style='color:#686667;'>W4</span>").replaceAll("W금","<span style='color:#686667;'>W5</span>").replaceAll("W토","<span style='color:#686667;'>W6</span>").replaceAll("W일","<span style='color:#686667;'>W0</span>")%>
											</div>
										</td>
									</tr>
									<tr>
										<td>
											<div class='cellTitle_ez_right'>월 캘린더</div>
										</td>
										<td>
											<div class='cellContent_kang'>
												<%=strDays_cal%>
											</div>
										</td>
										<td></td>
										<td></td>
										<td>
											<div class='cellTitle_ez_right'>일 캘린더</div>
										</td>
										<td>
											<div class='cellContent_kang'>
												<%=strWeeks_cal%>
											</div>
										</td>
									</tr>
									
									<tr>
										<td ><div class='cellTitle_ez_right'>1월~6월</div></td>
										<td colspan="6"><div class='cellContent_kang'>
										<%
											for ( int i = 0; i < 6; i++ ) {
												out.println("<select id='month_"+(i+1)+"' name='month_"+(i+1)+"' style='width:100px;height:21px;' disabled>");
												aTmp = CommonUtil.getMessage("JOB.CAL_OPT").split(",");
												for(int j=0;j<aTmp.length; j++){
													String[] aTmp1 = aTmp[j].split("[|]");
													out.println("<option value='"+aTmp1[0]+"' "+( (aTmp1[0].equals(docBean.getMonth(i+1)))? " selected ":"" )+" >"+aTmp1[1]+"</option>");
												}
												out.println("</select>");
											}
										%>
										</div></td>
									</tr>
									<tr>
										<td ><div class='cellTitle_ez_right'>7월~12월</div></td>
										<td colspan="6"><div class='cellContent_kang'>
										<%
											for ( int i = 6; i < 12; i++ ) {
												out.println("<select id='month_"+(i+1)+"' name='month_"+(i+1)+"' style='width:100px;height:21px;' disabled>");
												aTmp = CommonUtil.getMessage("JOB.CAL_OPT").split(",");
												for(int j=0;j<aTmp.length; j++){
													String[] aTmp1 = aTmp[j].split("[|]");
													out.println("<option value='"+aTmp1[0]+"' "+( (aTmp1[0].equals(docBean.getMonth(i+1)))? " selected ":"" )+" >"+aTmp1[1]+"</option>");
												}
												out.println("</select>");
											}
										%>
										</div></td>
									</tr>
								</table>
							</td>
						</tr>
					</table>
							
					<table style="width:100%">
					<tr>
						<td style="width:50%;">
							<table style="width:100%;">
								<tr>								  
									<td style="width:76%;height:21px;">
										<div class='cellTitle_kang5'>선행작업조건</div>
									</td>
								</tr>   
							</table> 
							<table style="width:100%;height:100%;border:none;"> 
							
								<tr>					
									<td id='ly_<%=gridId_1 %>' style='vertical-align:top;height:150px;'>
										<div id="<%=gridId_1 %>" class="ui-widget-header ui-corner-all"></div>
									</td>					
								</tr>
							</table>					
						</td>
						
						<td style="width:50%;">
							<table style="width:100%;">
								<tr>								
									<td style="width:76%;height:21px;">
										<div class='cellTitle_kang5'><font color="red">* </font>후행작업조건 (자기작업 CONDITION)</div>
									</td>
								</tr>
							</table> 
							<table style="width:100%;height:100%;border:none;">
								<tr>					
									<td id='ly_<%=gridId_2 %>' style='vertical-align:top;height:150px;'>
										<div id="<%=gridId_2%>" class="ui-widget-header ui-corner-all"></div>
									</td>					
								</tr>											
							</table>
						</td>
					</tr>
					</table>
					<table style="width:100%">
					<tr>
						<td>
							<div class='cellTitle_kang5'>담당자 정보</div>
						</td>
					</tr>
					<tr>
						<td valign="top">
						
							<input type='hidden' id='user_cd_1_0' name='user_cd_1_0' value='<%=strUserCd1%>' />
							<input type='hidden' id='user_cd_2_0' name='user_cd_2_0' value='<%=strUserCd2%>' />
							<input type='hidden' id='user_cd_3_0' name='user_cd_3_0' value='<%=strUserCd3%>' />
							<input type='hidden' id='user_cd_4_0' name='user_cd_4_0' value='<%=strUserCd4%>' />
							<input type='hidden' id='user_cd_5_0' name='user_cd_5_0' value='<%=strUserCd5%>' />
							<input type='hidden' id='user_cd_6_0' name='user_cd_6_0' value='<%=strUserCd6%>' />
							<input type='hidden' id='user_cd_7_0' name='user_cd_7_0' value='<%=strUserCd7%>' />
							<input type='hidden' id='user_cd_8_0' name='user_cd_8_0' value='<%=strUserCd8%>' />
							<input type='hidden' id='user_cd_9_0' name='user_cd_9_0' value='<%=strUserCd9%>' />
							<input type='hidden' id='user_cd_10_0' name='user_cd_10_0' value='<%=strUserCd10%>' />

							<input type='hidden' id='grp_cd_1_0' name='grp_cd_1_0' value='<%=strGrpCd1%>' />
							<input type='hidden' id='grp_cd_2_0' name='grp_cd_2_0' value='<%=strGrpCd2%>' />

							<table style="width:100%;">	
								<tr>
									<td width="120px"></td>
									<td width="120px"></td>
									<td width="180px"></td>
									<td width="120px"></td>
									<td width="120px"></td>
									<td width="120px"></td>
									<td width="180px"></td>
									<td width="120px"></td>
								</tr>												
								<tr>
									<td>
										<div class='cellTitle_ez_right'><font color="red">* </font>담당자1</div>
									</td>
									
									<td>
										<div class='cellContent_kang'>
											<%=strUserNm1 %>
										</div>
									</td>
									<td>
										<div class='cellContent_kang'>
											<%=strSms%><input type='checkbox' name='sms_1_0' id='sms_1_0' value='Y' disabled />
											<%=strMail%><input type='checkbox' name='mail_1_0' id='mail_1_0' value='Y' disabled />
										</div>
									</td>
									<td>
										<div class='cellContent_kang'>
											
										</div>
									</td>
								   
									<td>
										<div class='cellTitle_ez_right'>담당자2</div>
									</td>
									<td>
										<div class='cellContent_kang'>
											<%=strUserNm2 %>
										</div>
									</td>
									<td>
										<div class='cellContent_kang'>
											<%=strSms%><input type='checkbox' name='sms_2_0' id='sms_2_0' value='Y' disabled />
											<%=strMail%><input type='checkbox' name='mail_2_0' id='mail_2_0' value='Y' disabled />
										</div>
									</td>
									<td>
										<div class='cellContent_kang'>
											
										</div>
									</td> 
										
								</tr>
								
								<tr>
									<td>
										<div class='cellTitle_ez_right'>담당자3</div>
									</td>
									<td>
										<div class='cellContent_kang'>
											<%=strUserNm3 %>
										</div>
									</td>
									<td>
										<div class='cellContent_kang'>
											<%=strSms%><input type='checkbox' name='sms_3_0' id='sms_3_0' value='Y' disabled />
											<%=strMail%><input type='checkbox' name='mail_3_0' id='mail_3_0' value='Y' disabled />
										</div>
									</td>
									<td>
										<div class='cellContent_kang'>
										
										</div>
									</td>
								
									<td>
										<div class='cellTitle_ez_right'>담당자4</div>
									</td>
									
									<td>
										<div class='cellContent_kang'>
											<%=strUserNm4 %>
										</div>
									</td>
									<td>
										<div class='cellContent_kang'>
											<%=strSms%><input type='checkbox' name='sms_4_0' id='sms_4_0' value='Y' disabled />
											<%=strMail%><input type='checkbox' name='mail_4_0' id='mail_4_0' value='Y'disabled  />										
										</div>
									</td>
									<td>
										<div class='cellContent_kang'>
											
										</div>
									</td>
								</tr>
								<tr>
									<td>
										<div class='cellTitle_ez_right'>담당자5</div>
									</td>
									<td>
										<div class='cellContent_kang'>
											<%=strUserNm5 %>
										</div>
									</td>
									<td>
										<div class='cellContent_kang'>
											<%=strSms%><input type='checkbox' name='sms_5_0' id='sms_5_0' value='Y' disabled />
											<%=strMail%><input type='checkbox' name='mail_5_0' id='mail_5_0' value='Y' disabled />
										</div>
									</td>
									<td>
										<div class='cellContent_kang'>
										
										</div>
									</td>
								
									<td>
										<div class='cellTitle_ez_right'>담당자6</div>
									</td>
									
									<td>
										<div class='cellContent_kang'>
											<%=strUserNm6 %>
										</div>
									</td>
									<td>
										<div class='cellContent_kang'>
											<%=strSms%><input type='checkbox' name='sms_6_0' id='sms_6_0' value='Y' disabled />
											<%=strMail%><input type='checkbox' name='mail_6_0' id='mail_6_0' value='Y'disabled  />										
										</div>
									</td>
									<td>
										<div class='cellContent_kang'>
											
										</div>
									</td>
								</tr>
								<tr>
									<td>
										<div class='cellTitle_ez_right'>담당자7</div>
									</td>
									<td>
										<div class='cellContent_kang'>
											<%=strUserNm7 %>
										</div>
									</td>
									<td>
										<div class='cellContent_kang'>
											<%=strSms%><input type='checkbox' name='sms_7_0' id='sms_7_0' value='Y' disabled />
											<%=strMail%><input type='checkbox' name='mail_7_0' id='mail_7_0' value='Y' disabled />
										</div>
									</td>
									<td>
										<div class='cellContent_kang'>
										
										</div>
									</td>
								
									<td>
										<div class='cellTitle_ez_right'>담당자8</div>
									</td>
									
									<td>
										<div class='cellContent_kang'>
											<%=strUserNm8 %>
										</div>
									</td>
									<td>
										<div class='cellContent_kang'>
											<%=strSms%><input type='checkbox' name='sms_8_0' id='sms_8_0' value='Y' disabled />
											<%=strMail%><input type='checkbox' name='mail_8_0' id='mail_8_0' value='Y'disabled  />										
										</div>
									</td>
									<td>
										<div class='cellContent_kang'>
											
										</div>
									</td>
								</tr>
								<tr>
									<td>
										<div class='cellTitle_ez_right'>담당자9</div>
									</td>
									<td>
										<div class='cellContent_kang'>
											<%=strUserNm9 %>
										</div>
									</td>
									<td>
										<div class='cellContent_kang'>
											<%=strSms%><input type='checkbox' name='sms_9_0' id='sms_9_0' value='Y' disabled />
											<%=strMail%><input type='checkbox' name='mail_9_0' id='mail_9_0' value='Y' disabled />
										</div>
									</td>
									<td>
										<div class='cellContent_kang'>

										</div>
									</td>

									<td>
										<div class='cellTitle_ez_right'>담당자10</div>
									</td>

									<td>
										<div class='cellContent_kang'>
											<%=strUserNm10 %>
										</div>
									</td>
									<td>
										<div class='cellContent_kang'>
											<%=strSms%><input type='checkbox' name='sms_10_0' id='sms_10_0' value='Y' disabled />
											<%=strMail%><input type='checkbox' name='mail_10_0' id='mail_10_0' value='Y' disabled  />
										</div>
									</td>
									<td>
										<div class='cellContent_kang'>

										</div>
									</td>
								</tr>
								<tr>
									<td>
										<div class='cellTitle_ez_right'>그룹1</div>
									</td>
									<td>
										<div class='cellContent_kang'>
											<%=strGrpNm1 %>
										</div>
									</td>
									<td>
										<div class='cellContent_kang'>
											<%=strSms%><input type='checkbox' name='grp_sms_1_0' id='grp_sms_1_0' value='Y' disabled />
											<%=strMail%><input type='checkbox' name='grp_mail_1_0' id='grp_mail_1_0' value='Y' disabled />
										</div>
									</td>
									<td>
										<div class='cellContent_kang'>

										</div>
									</td>

									<td>
										<div class='cellTitle_ez_right'>그룹2</div>
									</td>

									<td>
										<div class='cellContent_kang'>
											<%=strGrpNm2 %>
										</div>
									</td>
									<td>
										<div class='cellContent_kang'>
											<%=strSms%><input type='checkbox' name='grp_sms_2_0' id='grp_sms_2_0' value='Y' disabled />
											<%=strMail%><input type='checkbox' name='grp_mail_2_0' id='grp_mail_2_0' value='Y' disabled  />
										</div>
									</td>
									<td>
										<div class='cellContent_kang'>

										</div>
									</td>
								</tr>
							</table>
						<table style="width:100%;">
		 					<tr>
								<td colspan="6"> 
									<table style="width:100%;">
		  								<tr>
											<td colspan = "5">
												<div class='cellTitle_kang5'>RESOURCE</div>
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td style='width:8%'><div class='cellTitle_ez_center'>Name</div></td>
								<td style='width:86%'><div class='cellTitle_ez_left'>Required Usage</div></td>
							</tr>
						</table>
						
						<table style="width:100%;height:100%;border:none;" id="resQTable"> 
						<%
						if( null!=docBean.getT_resources_q() && docBean.getT_resources_q().trim().length()>0 ){
							aTmpT = CommonUtil.E2K(docBean.getT_resources_q()).split("[|]");
							for(int t=0; null!=aTmpT&&t<aTmpT.length; t++ ){
								String[] aTmpT1 = aTmpT[t].split(",",2);
								
						%>
							<tr>
								<td style='width:8%; text-align:center;word-break: break-all;'><%=aTmpT1[0] %></td>
								<td style='width:86%; text-align:left; padding-left:10px;'>
									<%=aTmpT1[1] %>
								</td>
							</tr>
						<%
							}
						}
						%>
						</table>	
						<table style="width:100%;">
		 					<tr>
								<td colspan="6"> 
									<table style="width:100%;">
		  								<tr>
											<td colspan = "5">
												<div class='cellTitle_kang5'>변수</div>
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td style='width:8%;'><div class='cellTitle_ez_center'>변수 이름</div></td>
								<td style='width:86%;'><div class='cellTitle_ez_left'>변수 값</div></td>
							</tr>
						</table>
						
						<table style="width:100%;height:100%;border:none;" id="userVar"> 
						<%
						if( null!=docBean.getT_set() && docBean.getT_set().trim().length()>0 ){
							aTmpT = CommonUtil.E2K(docBean.getT_set()).split("[|]");
							for(int t=0; null!=aTmpT&&t<aTmpT.length; t++ ){
								String[] aTmpT1 = aTmpT[t].split(",",2);
								if ( aTmpT1[0].equals("LIBMEMSYM")) {
									continue;
								}
						%>
							<tr>
								<td style='width:8%;text-align:center; word-break: break-all;'><%=aTmpT1[0] %></td>
								<td style='width:86%; text-align:left; padding-left:10px; word-break: break-all;'>
									<%=CommonUtil.replaceHtmlStr(aTmpT1[1]) %>
								</td>
							</tr>
						<%
							}
						}
						%>
						</table>
							
						<table style="width:100%;">
  								<tr>
  									
								<td colspan = "4">
									<div class='cellTitle_kang5'>ON/DO</div>
								</td>
							</tr>
						</table>
  						<table style="width:100%;">
						<tr>	
							<td style="width:6%;height:21px;">
								<div class='cellTitle_ez_center'>ON/DO</div>
							</td> 
							<td style="width:6%;height:21px;">
								<div class='cellTitle_ez_center'>TYPE</div>
							</td>
							<td style="width:60%;height:21px;">
								<div class='cellTitle_ez_left'>PARAMETERS</div>
							</td>								
						</tr>    
						</table>
						<table style="width:100%;height:100%;border:none;" id="onDoTable"> 
						<%
						if( null!=docBean.getT_steps() && docBean.getT_steps().trim().length()>0 ){
							aTmpT = CommonUtil.E2K(docBean.getT_steps()).split("[|]");
							for(int t=0; null!=aTmpT&&t<aTmpT.length; t++ ){
								String[] aTmpT1 = aTmpT[t].split(",");
								out.println("<tr>");
								out.println("<td style='width:6%;height:21px;text-align:center;'>");
								aTmp = CommonUtil.getMessage("JOB.STEP_OPT").split(",");
								for(int i=0;i<aTmp.length; i++){
									String[] aTmp1 = aTmp[i].split("[|]");
									out.println(( (aTmp1[0].equals(aTmpT1[0]))? aTmp1[1]:"" ));
								}
								out.println("</td>");
								out.println("<td style='width:6%;height:21px;text-align:center;'>");
								out.println("<div id='div_step_type"+t+"'>");
								String aTmpT2[] = aTmpT[t].split(",");
								if( "O".equals(aTmpT1[0]) ){
									aTmp = CommonUtil.getMessage("TABLE.STEP_ON_TYPE").split(",");
									String aTmpt3[] = aTmpT2[3].split(" ");
									if(aTmpT1[3].split(" ").length > 1){
									for(int i=0;i<aTmp.length; i++){
										String[] aTmp1 = aTmp[i].split("[|]");
										out.println(( (aTmp1[1].equals(aTmpt3[0]))? aTmp1[0]:"" ));
									}
									}else if(aTmpT1[3].equals("OK") || aTmpT1[3].equals("NOTOK")){
										for(int i=0;i<aTmp.length; i++){
											String[] aTmp1 = aTmp[i].split("[|]");
											out.println(( (aTmp1[1].equals(aTmpT2[3]))? aTmp1[0]:"" ));
										}	
									}else{
										for(int i=0;i<aTmp.length; i++){
											String[] aTmp1 = aTmp[i].split("[|]");
											out.println(( (aTmp1[1].equals(aTmpT1[1]))? aTmpT1[1]:""));
										}
									}
								}else if( "A".equals(aTmpT1[0]) ){
									
									aTmp = CommonUtil.getMessage("TABLE.STEP_DO_TYPE").split(",");
									for(int i=0;i<aTmp.length; i++){
										if(aTmpT2[1].equals("SPCYC")){
										 	aTmp = CommonUtil.getMessage("TABLE.STEP_DO_TYPE").split(",");
											String[] aTmp1 = aTmp[i].split("[|]");
											out.println(( (aTmp1[1].equals("Stop Cyclic"))? aTmp1[0]:"" ));
										}else{
											String[] aTmp1 = aTmp[i].split("[|]");
											out.println(( (aTmp1[1].equals(aTmpT1[1]))? aTmp1[0]:"" ));
										}
									}
								}
								out.println("");
								
								out.println("</div></td>");
								out.println("<td style='width:60%;height:21px;text-align:left;padding-left:10px;'>");
								out.println("<div id='div_step_parameters"+t+"'>");
								if(aTmpT2[0].equals("O")){
									String aTmpt4[] = aTmpT2[3].split(" ");
									if(aTmpt4[0].equals("FAILCOUNT")){
										String aTmpt3[] = aTmpT2[3].split(" ");
										out.println(" Code : "+aTmpt3[2]);
									}else{
										if(aTmpt4[0].equals("OK") || aTmpt4[0].equals("NOTOK") || aTmpt4[0].equals("COMPSTAT") || aTmpt4[0].equals("RUNCOUNT")){
										aTmp = CommonUtil.getMessage("TABLE.STEP_ON_PARAMETERS").split(",");
										String aTmpt3[] = aTmpT2[3].split(" ");
										if(aTmpt3.length > 1){
											if(aTmpt3[2].equals("EVEN") || aTmpt3[2].equals("ODD")){
												for(int i=0;i<aTmp.length; i++){
													String[] aTmp1 = aTmp[i].split("[|]");
													if(aTmp1[1].equals(aTmpt3[2])){
														out.println("Stmt : "+aTmp1[0]);
													}
													
												}
											
											}else{
												for(int i=0;i<aTmp.length; i++){
													String[] aTmp1 = aTmp[i].split("[|]");
													if(aTmp1[1].equals(aTmpt3[1])){
														out.println("Stmt : "+aTmp1[0]);
													}
												}
											
												out.println(" Code : "+aTmpt3[2]);
											}
										}
										}else{
											out.println("Stmt : "+aTmpT2[2]);
											out.println("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Code : "+aTmpT2[3]);
										}
										
									}
								}else if(aTmpT2[0].equals("A")){
									 if(aTmpT2.length > 2){	 
										 if(aTmpT2[1].equals("Condition")){
											 out.println("Name : "+aTmpT2[2]);
											 out.println(" Date : "+aTmpT2[3]);
											 aTmp = CommonUtil.getMessage("JOB.STEP_SIGN").split(",");
											 for(int i=0;i<aTmp.length; i++){
												String[] aTmp1 = aTmp[i].split("[|]");
												if(aTmp1[0].equals(aTmpT2[4])){
													out.println(" Sign : "+aTmp1[1]);
												}
											 }
											 
										 }else if( aTmpT2[1].equals("Shout") ){
											 out.println("Dest : "+aTmpT2[2]);
											 out.println(" Message : "+aTmpT2[4]);
										 }else if( aTmpT2[1].equals("Mail") ){
												aTmpT1 = aTmpT[t].split(",",7);
												
												out.println(" To="+aTmpT1[2]+"<br/>");
												out.println(" Cc="+aTmpT1[3]+"<br/>");
												out.println(" Subject="+aTmpT1[4]+",");
												out.println(" Urgn="+CommonUtil.getMessage("JOB.STEP_URGENCY."+aTmpT1[5])+"<br/>");
												
												out.println(" Msg="+aTmpT1[6].replaceAll("\r\n","<br/>")+"");
										 }else if( aTmpT2[1].equals("Force-Job") ){
												aTmpT1 = aTmpT[t].split(",");
												
												out.println(" 폴더="+aTmpT1[2]+" ");
												out.println(" 작업명="+aTmpT1[3]+" ");
												out.println(" ORDER DATE="+aTmpT1[4]);
										 }
									 }
										 
								}
								out.println("</div></td>");
								
							}
						}
						%>
						</table>
					</td>
				</tr>
			</table>
				

			</div>			
		</td>
	</tr>
	
	<tr style='height:10px;'>
		<td style='vertical-align:top;'>
			<h4 class="ui-widget-header ui-corner-all" >
				<div align='right' class='btn_area' >		
				<%
					String strCurApprovalSeq	= "";
					String strStateCd			= "";
					String strInsUserCd			= "";
					String strApprovalGb		= "";
					for( int i=0; null!=approvalInfoList && i<approvalInfoList.size(); i++ ) {
						ApprovalInfoBean bean = (ApprovalInfoBean)approvalInfoList.get(i);
					
						String strUserCd			= CommonUtil.isNull(bean.getUser_cd());
						String strUdtUserCd			= CommonUtil.isNull(bean.getUdt_user_cd());
						
						String strAbsenceUserCd		= CommonUtil.isNull(bean.getAbsence_user_cd());
						String strAbsenceUserNm		= CommonUtil.isNull(bean.getAbsence_user_nm());
						String strAbsenceDeptNm		= CommonUtil.isNull(bean.getAbsence_dept_nm());
						String strAbsenceDutyNm		= CommonUtil.isNull(bean.getAbsence_duty_nm());
						
						strApprovalGb        = CommonUtil.isNull(bean.getApproval_gb());
						String strSeq				= CommonUtil.isNull(bean.getSeq());
						strCurApprovalSeq			= CommonUtil.isNull(bean.getCur_approval_seq());
						strStateCd					= CommonUtil.isNull(bean.getState_cd());
						strInsUserCd				= CommonUtil.isNull(bean.getIns_user_cd());
						
						String strAbsenceInfo		= "";
					}

					if ( !cur_approval_seq.equals("") ) {
				%>
						<input type="hidden" name="seq" id="seq" value="<%=cur_approval_seq%>"/>
								
						결재자 의견 : <input type="text" name="app_comment" id="app_comment" maxlength="100" style="width:150px;height:21px;">
						<span id='btn_approval'>결재</span>
						<%	// 반영완료는 반려처리 불가.
						if ( !strApplyCd.equals("02")) {
						%>
							<%
							System.out.println("cur_approval_gb.equals(04) : " + cur_approval_gb);
							if(!cur_approval_gb.equals("04")){
							%>
							<span id='btn_reject'>반려</span>
							<%
							}
							%>
						<%
						}
						%>
						
						<!-- <span id='btn_admin_udt'>결재자 수정</span> -->
				<%
					}
						
					// 1차결재자 미결이면 기안자 승인취소 가능
					if ( strCurApprovalSeq.equals("1") && strStateCd.equals("01") && S_USER_CD.equals(strInsUserCd) ) {
				%>
						<span id='btn_cancel'>승인취소</span>
				<%
					}
				%>				
				
					<!-- <span id='btn_list'>목록</span> -->
					<span id='btn_copy'>복사</span>
					<span id='btn_del' style="display:none;">삭제</span>
					
					<%if (CommonUtil.E2K(docBean.getApply_cd()).equals("04") || CommonUtil.E2K(docBean.getApply_cd()).equals("05") ) {%>
						<span id="btn_admin_approval">재반영</span>
					<%}%>
								
					<span id='btn_close'>닫기</span>
				
				</div>
			</h4>
		</td>
	</tr>
	
</table>
<div id="<%=gridId_3 %>" class="ui-widget-header ui-corner-all" style="display:none;"></div>
<div id="<%=gridId_4 %>" class="ui-widget-header ui-corner-all" style="display:none;"></div>
</form>


<script type="text/javascript">

	var rowsObj_job1 = new Array();
	var rowsObj_job2 = new Array();
	
	var arr_caluse_gb_cd = new Array();
	var arr_caluse_gb_nm = new Array();
	
	<c:forEach var="caluse_gb_cd" items="${caluse_gb_cd}" varStatus="s">
		var map_cd = {"cd":"${caluse_gb_cd}"};
		arr_caluse_gb_cd.push(map_cd);
	</c:forEach>
	<c:forEach var="caluse_gb_nm" items="${caluse_gb_nm}" varStatus="s">
		var map_nm = {"nm":"${caluse_gb_nm}"};
		arr_caluse_gb_nm.push(map_nm);
	</c:forEach>
	
	var arr_prio_gb_cd = new Array();
	var arr_prio_gb_nm = new Array();
	
	<c:forEach var="prio_gb_cd" items="${prio_gb_cd}" varStatus="s">
		var map_cd = {"cd":"${prio_gb_cd}"};
		arr_prio_gb_cd.push(map_cd);
	</c:forEach>
	<c:forEach var="prio_gb_nm" items="${prio_gb_nm}" varStatus="s">
		var map_nm = {"nm":"${prio_gb_nm}"};
		arr_prio_gb_nm.push(map_nm);
	</c:forEach>
	
	var gridObj_1 = {
		id : "<%=gridId_1 %>"
		,colModel:[
			{formatter:gridCellNoneFormatter,field:'m_in_condition_parentheses_s',id:'m_in_condition_parentheses_s',name:'(',width:60,headerCssClass:'cellCenter',cssClass:'cellCenter'}
			,{formatter:gridCellNoneFormatter,field:'m_in_condition_name',id:'m_in_condition_name',name:'선행조건명',width:350,headerCssClass:'cellCenter',cssClass:'cellLeft'}
			,{formatter:gridCellNoneFormatter,field:'m_in_condition_parentheses_e',id:'m_in_condition_parentheses_e',name:')',width:60,headerCssClass:'cellCenter',cssClass:'cellCenter'}
	   		,{formatter:gridCellNoneFormatter,field:'m_in_condition_date',id:'m_in_condition_date',name:'일자유형',width:80,headerCssClass:'cellCenter',cssClass:'cellCenter'}
	   		,{formatter:gridCellNoneFormatter,field:'m_in_condition_and_or',id:'m_in_condition_and_or',name:'구분',width:70,headerCssClass:'cellCenter',cssClass:'cellCenter'}
			,{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'grid_idx',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}	   		
	   		
	   	]
		,rows:[]  
		,vscroll:false
	};
	
	var gridObj_2 = {
		id : "<%=gridId_2 %>"
		,colModel:[
	   		{formatter:gridCellNoneFormatter,field:'m_out_condition_name',id:'m_out_condition_name',name:'자기작업 CONDITION',width:350,headerCssClass:'cellCenter',cssClass:'cellLeft'}
	   		,{formatter:gridCellNoneFormatter,field:'m_out_condition_date',id:'m_out_condition_date',name:'일자유형',width:80,headerCssClass:'cellCenter',cssClass:'cellCenter'}
	   		,{formatter:gridCellNoneFormatter,field:'m_out_condition_effect',id:'m_out_condition_effect',name:'구분',width:70,headerCssClass:'cellCenter',cssClass:'cellCenter'}
			,{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'grid_idx',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}  		
	   	]
		,rows:[]
		,vscroll:false
	};
	
	var gridObj_3 = {
		id : "<%=gridId_3 %>"
		,colModel:[
	   		{formatter:gridCellNoneFormatter,field:'m_in_condition_name',id:'m_in_condition_name',name:'선행조건명',width:320,headerCssClass:'cellCenter',cssClass:'cellLeft'}	 
	   		,{formatter:gridCellNoneFormatter,field:'m_in_condition_date',id:'m_in_condition_date',name:'일자유형',width:80,headerCssClass:'cellCenter',cssClass:'cellLeft'}	   		
	   		,{formatter:gridCellNoneFormatter,field:'m_in_condition_and_or',id:'m_in_condition_and_or',name:'구분',width:80,headerCssClass:'cellCenter',cssClass:'cellLeft'}
			,{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'grid_idx',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   		   		
	   	]
		,rows:[]  
		,vscroll:false
	};
	
	var gridObj_4 = {
		id : "<%=gridId_4 %>"
		,colModel:[
	   		{formatter:gridCellNoneFormatter,field:'m_out_condition_name',id:'m_out_condition_name',name:'자기작업 CONDITION',width:320,headerCssClass:'cellCenter',cssClass:'cellLeft'}	 
	   		,{formatter:gridCellNoneFormatter,field:'m_out_condition_date',id:'m_out_condition_date',name:'일자유형',width:75,headerCssClass:'cellCenter',cssClass:'cellLeft'}	   		
	   		,{formatter:gridCellNoneFormatter,field:'m_out_condition_effect',id:'m_out_condition_effect',name:'구분',width:75,headerCssClass:'cellCenter',cssClass:'cellLeft'}
			,{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'grid_idx',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}  		
	   		
	   	]
		,rows:[]
		,vscroll:false
	};
	
	function PopulateSelect(select, dataSource, addBlank) {
	  var index, len, newOption;
	  if (addBlank) { select.appendChild(new Option('', '')); }
	  $.each(dataSource, function (value, text) {
	       newOption = new Option(text, value);
	      select.appendChild(newOption);
	 });
	}
	
	var accountlist = new Array("FTP_ACCOUNT"
			, "FTP_LHOST", "FTP_LOSTYPE", "FTP_LUSER", "FTP_CONNTYPE1"
			, "FTP_RHOST", "FTP_ROSTYPE", "FTP_RUSER", "FTP_CONNTYPE2"
			, "FTP_USE_DEF_NUMRETRIES", "FTP_NUM_RETRIES", "FTP_RPF", "FTP_CONT_EXE_NOTOK");

	var pathlist = new Array("FTP_LPATH", "FTP_UPLOAD", "FTP_RPATH", "FTP_TYPE");

	var advancedlist = new Array("FTP_SRCOPT", "FTP_NEWNAME", "FTP_SRC_ACT_FAIL", "FTP_IF_EXIST",
			"FTP_DSTOPT", "FTP_DEST_NEWNAME", "FTP_EMPTY_DEST_FILE_NAME",
			"FTP_FILE_PFX", "FTP_CONT_EXE", "FTP_DEL_DEST_ON_FAILURE",
			"FTP_POSTCMD_ON_FAILURE", "FTP_RECURSIVE", "FTP_ENCRYPTION1", "FTP_COMPRESSION1", "FTP_ENCRYPTION2", "FTP_COMPRESSION2",
			"FTP_PRESERVE_ATTR", "FTP_PRECOMM1", "FTP_PREPARAM11", "FTP_PREPARAM12", "FTP_POSTCOMM1",
			"FTP_POSTPARAM11", "FTP_POSTPARAM12", "FTP_PRECOMM2", "FTP_PREPARAM21", "FTP_PREPARAM22",
			"FTP_POSTCOMM2", "FTP_POSTPARAM21", "FTP_POSTPARAM22", "FTP_PGP_ENABLE", "FTP_PGP_TEMPLATE_NAME",
			"FTP_PGP_KEEP_FILES", "FTP_EXCLUDE_WILDCARD");
			
	$(document).ready(function(){
		
		var state_cd 	= '<%=state_cd%>';
		var doc_cd 		= '<%=doc_cd%>';
		var session_user_gb	= "<%=S_USER_GB%>";

		$("#btn_udt").show();
		$("#btn_list").show();
		
		if(state_cd == '00'){
			$("#btn_udt").show();
			$("#btn_list").show();
		}else if(state_cd == '01'){
			$("#btn_udt").hide();
			$("#btn_list").show();
		}else{
			$("#btn_udt").hide();
			$("#btn_list").show();
		}
		//운영자일 경우 삭제 버튼 활성화
		if ( session_user_gb == "99" || session_user_gb == "02" ) {
			$("#btn_del").show();
		}
		var apply_cd = '<%=strApplyCd%>';
		var task_type = "<%=strTaskType%>";
		
		// 작업유형구분에 따라 작업타입 변경.
		if ( task_type == "job" ) {
			
			$("#mem_lib").attr("disabled", false);
			$("#mem_name").attr("disabled", false);
			$("#command").attr("disabled", true);
			
			$('.job_val').html('* ');
			$('.command_val').html('');
			
			$('#kubernetes_yn').hide();
			$('#mftTable').hide();
			$('#database_tb').hide();
			
		} else if( task_type == "dummy" ) {
			
// 			$("#mem_lib").val("DUMMY");
// 			$("#mem_lib").attr("disabled", true);
			
// 			$("#mem_name").val("DUMMY");
// 			$("#mem_name").attr("disabled", true);
			
			$("#command").val("DUMMY");
			$("#command").attr("disabled", true);
			
			$('.job_val').html('');
			$('.command_val').html('');
			
			$('#kubernetes_yn').hide();
			$('#mftTable').hide();
			$('#database_tb').hide();
			
		} else if( task_type == "command" ) {
			
// 			$("#mem_lib").attr("disabled", true);			
// 			$("#mem_name").attr("disabled", true);
			$("#command").attr("disabled", false);
			
			$('.command_val').html('* ');
			$('.job_val').html('');
			
			$('#kubernetes_yn').hide();
			$('#mftTable').hide();
			$('#database_tb').hide();
			
		} else if( task_type == "Kubernetes" ) {
			
			$("#mem_lib").attr("disabled", true);
			$("#mem_name").attr("disabled", true);
			$("#command").attr("disabled", true);
			
			$("#mem_lib").val("");
			$("#mem_name").val("");
			$("#command").val("");
			
			$('.job_val').html('');
			$('.command_val').html('');
			
			$('#kubernetes_yn').show();
			$('#mftTable').hide();
			$('#database_tb').hide();
			
		} else if (task_type == "MFT") {
			
			$("#mem_lib").val("");
			$("#mem_lib").attr("disabled", true);

			$("#mem_name").val("");
			$("#mem_name").attr("disabled", true);

			$("#command").val("");
			$("#command").attr("disabled", true);

			$('.job_val').html('');
			$('.command_val').html('');
							
			$('#kubernetes_yn').hide();
			$('#mftTable').show();
			$('#database_tb').hide();
			
		}else if (task_type == "Database") {
			
			$("#mem_lib").val("");
			$("#mem_lib").attr("disabled", true);

			$("#mem_name").val("");
			$("#mem_name").attr("disabled", true);

			$("#command").val("");
			$("#command").attr("disabled", true);

			$('.job_val').html('');
			$('.command_val').html('');
							
			$('#kubernetes_yn').hide();
			$('#mftTable').hide();
			$('#database_tb').show();
			
		}
		
		var execuType = '<%=execution_type%>';
		
		if(execuType == 'P'){
			$('#db_q_tr').hide();
			$('#db_p_tr').show();
			$("#param_tr").show();
			$("#param_header_tr").show();
			$('#param_header_tr').nextUntil('#db_q_tr').show();
		}else if(execuType == 'Q'){
			$('#db_q_tr').show();
			$('#db_p_tr').hide();
			$("#param_tr").hide();
			$("#param_header_tr").hide();
			$('#param_header_tr').nextUntil('#db_q_tr').remove();
		}
		var dbOutputFormat = '<%=db_output_format%>';
		
		if(dbOutputFormat == 'C'){
			$('#csv_seperator').show();
		}else {
			$('#csv_seperator').hide();
		}
		
		var data_center = $("#data_center").val();
		
		var data_center = $("#frm1").find("input[name='data_center']").val();

		var node_id = $("#node_id").val();
		var group_name = $("#group_name").val();
		var application = $("#application").val();
		var owner = $("#v_owner").val();
		var online_impect = $("#online_impect_yn").val();		
		var time_group = $("#time_group").val();
		var globalCond_yn = $("#globalCond").val();
		var critical_yn = $("#critical").val();
		var mcode_nm = $("#hMcode_nm").val();
		var	jobTypeGb	= $("#jobTypeGb").val();
// 		var systemGb	= $("#systemGb").val();

		var confirm_flag	= "<%=strConfirmFlag%>";
		
		//getCodeList(application, "2", "", "group_name_of_def");
		//그룹을 내역		
		getAppGrpCodeList("", "2", "", "group_name_of_def", application);
<%-- 		$("#active_yn").val('<%=strActiveMent %>'); --%>
		setTimeout(function(){
			$("select[name='group_name_of_def']").val(group_name);
		}, 1000);
		
		setTimeout(function(){
			$("select[name='mcode_nm']").val(mcode_nm);
		}, 1000);
								
		mHostList(group_name);
		setTimeout(function(){		
			$("select[name='host_id']").val(node_id);
		}, 1000);
				
		sCodeList(data_center, node_id);
		setTimeout(function(){
			$("select[name='owner']").val(owner);
		}, 1000);
		
		setTimeout(function(){
			$("select[name='sJobTypeGb']").val(jobTypeGb);
		}, 1000);

// 		setTimeout(function(){
// 			$("select[name='sSystemGb']").val(systemGb);
// 		}, 1000);
		
		setTimeout(function(){
			$("select[name='confirm_flag']").val(confirm_flag);
		}, 1000);
		
		$("#btn_clear1").unbind("click").click(function(){
			$("#frm1").find("input[name='scode_nm']").val("");
		});
		
		$("#group_name_of_def").change(function(){
			
			$("#group_name").val($(this).val());

			$("select[name='host_id'] option").remove();
			$("select[name='host_id']").append("<option value=''>--선택--</option>");
			$("#node_id").val("");
			
			$("select[name='owner'] option").remove();
			$("select[name='owner']").append("<option value=''>--선택--</option>");
						
			mHostList($(this).val());

		});
		
		
		$("#app_nm").click(function(){
			var data_center = $("#data_center2").val();
			
			if(data_center == ""){
				alert("C-M 을 선택해 주세요.");
				return;
			}else{
				poeAppForm();
			}		
		});
		
		$("#mcode_nm").change(function(){
			$("#scode_nm").val("");	
		});
		
		$("#scode_nm").click(function(){
			
			var mcode_nm = $("select[name='mcode_nm'] option:selected").val();
			var arr_mcode_nm = mcode_nm.split(",");
			if(mcode_nm == ""){
				alert("대그룹을 선택해 주세요.");
				return;
			}
			
			popScodeForm(arr_mcode_nm[0]);
		});
				
		$("#host_id").change(function(){ 
			
			$("select[name='owner'] option").remove();
			$("select[name='owner']").append("<option value=''>--선택--</option>");
			$("#v_owner").val("");
						
			var data_center = $("#frm1").find("input[name='data_center']").val();
			var host_id = $("select[name='host_id'] option:selected").val();
			$("#node_id").val(host_id);
			
			sCodeList(data_center, host_id);
		});
		
		//Critical_yn 0 or 1 저장
		$("#critical_yn").change(function(){ 			
			$("#critical").val($(this).val());			
		});
		
		//사용자 영향 배치여부 1 or 0 저장
		$("#user_impect").change(function(){ 			
			$("#user_impect_yn").val($(this).val());			
		});		
		
		//작업시작시간을 받아서 시간그룹을 SET 해준다.		
		$("#sHour").change(function(){
			
			$("#time_group").val("");
			
			$("#time_from").val("");
			
			var sHour = $("select[name='sHour'] option:selected").val();
			var sMin = $("select[name='sMin'] option:selected").val();
			
			$("#time_group").val(sHour);
			
			$("#time_from").val(sHour+sMin);
					
		});
		
		//작업시작시간의 시간, 분을 받아서 from_time을 SET 해준다.		
		$("#sMin").change(function(){
			
			$("#time_from").val("");
			
			var sHour =  $("#sHour").val();
			var sMin = $("#sMin").val();
			
			if(sHour == ''){
				alert("작업시작시간의 '시'항목을 '분' 보다 먼저 입력해 주세요");
				
				$("#sMin").val("");
				return;
				
			}
			
			$("#time_from").val(sHour+sMin);
					
		});		
		
		
		
		$("#eHour").change(function(){
			
			$("#time_until").val("");
			
			var eHour = $("select[name='eHour'] option:selected").val();
			var eMin = $("select[name='eMin'] option:selected").val();
			
			$("#time_until").val(eHour+eMin);
					
		});
		
		//작업종료시간의 시간, 분을 받아서 from_time을 SET 해준다.
		
		$("#eMin").change(function(){
			
			var eHour =  $("select[name='eHour'] option:selected").val();
			var eMin = $("select[name='eMin'] option:selected").val();
			
			if(eHour == ''){
				alert("작업종료시간의 '시' 항목을 '분' 보다 먼저 입력해 주세요");
				
				$("select[name='eMin']").val("");
				return;
				
			}
			
			$("#time_until").val(eHour+eMin);
					
		});
		
		//시작임계시간의 시간, 분을 받아서 late_sub을 SET 해준다.		
		$("#slate_sub_h, #slate_sub_m").change(function(){
			
			$("#late_sub").val("");
			
			var slate_sub_h =  $("select[name='slate_sub_h'] option:selected").val();
			var slate_sub_m = $("select[name='slate_sub_m'] option:selected").val();
			
			if(slate_sub_h == ''){
				alert("시작임계시간의 '시' 항목을 '분' 보다 먼저 입력해 주세요");
				
				$("select[name='slate_sub_m']").val("");
				return;
				
			}
			
			$("#late_sub").val(slate_sub_h+slate_sub_m);
					
		});		
		
		//종료임계시간의 시간, 분을 받아서 late_sub을 SET 해준다.		
		$("#slate_time_m").change(function(){
			
			$("#late_time").val("");
			
			var slate_time_h =  $("select[name='slate_time_h'] option:selected").val();
			var slate_time_m = $("select[name='slate_time_m'] option:selected").val();
			
			if(slate_time_h == ''){
				alert("시작임계시간의 '시' 항목을 '분' 보다 먼저 입력해 주세요");
				$("select[name='slate_time_m']").val("");
				return;
				
			}
			
			$("#late_time").val(slate_time_h+slate_time_m);
					
		});

		
		$("#btn_ins").button().unbind("click").click(function(){
			goPrc('ins');
		});	
		$("#btn_udt").button().unbind("click").click(function(){
			goPrc('udt');
		});	
		$("#btn_draft").button().unbind("click").click(function(){
			goPrc('draft');
		});	
		$("#btn_draft_admin").button().unbind("click").click(function(){
			if(state_cd == '00' || state_cd == "01"){
				goPrc('draft_admin');
			}
		});	

		$("#btn_cyclic").button().unbind("click").click(function(){
			fn_cyclic_popup();
		});
		
		$("#mem_lib").unbind("keyup").keyup(function(){
			
			var mem_name = $("#mem_name").val();
			var arg_val = $("#arg_val").val();
			var command = $(this).val() + mem_name + " "+ arg_val;
			
			$("#command").val(command);			
		});
		
		$("#mem_name").unbind("keyup").keyup(function(e){
			
			var mem_lib = $("#mem_lib").val();
			var arg_val = $("#arg_val").val();
			var command =  mem_lib + $(this).val() + " "+ arg_val;
			
			$("#command").val(command);		
		});
		
		$("#arg_val").unbind("keyup").keyup(function(e){
			
			var mem_lib = $("#mem_lib").val();
			var mem_name = $("#mem_name").val();
			var command =  mem_lib + mem_name + " "+ $(this).val();
			
			$("#command").val(command);		
		});		

		$("#f_s").find("input[name='p_apply_date']").val("${ODATE}");
		
		$("#apply_date").addClass("ime_readonly").unbind('click').click(function(){
			dpCalMinMax(this.id,'yymmdd','1','90');
		});		
		
		$("#btn_approval").button().unbind("click").click(function(){		
			goPrc('02', $("#seq").val(), '결재');
		});
		
		$("#btn_reject").button().unbind("click").click(function(){
			goPrc('04', $("#seq").val(), '반려');
		});
		
		$("#btn_admin_udt").button().unbind("click").click(function(){
			goAdminUdt();
		});
		
		$("#btn_cancel").button().unbind("click").click(function(){
			goCancel();
		});
		
		$("#btn_close").button().unbind("click").click(function(){
			top.closeTabs('tabs-'+doc_cd);
		});
		
		$("#btn_list").button().unbind("click").click(function(){
			
			var search_data_center 		= "<%=search_data_center%>";
			var search_state_cd 		= "<%=search_state_cd%>";
			var search_approval_cd 		= "<%=search_approval_cd%>";
			var search_gb 				= "<%=search_gb%>";
			var search_text 			= "<%=search_text%>";
			var search_date_gubun 		= "<%=search_date_gubun%>";
			var search_s_search_date 	= "<%=search_s_search_date%>";
			var search_e_search_date 	= "<%=search_e_search_date%>";
			var search_task_nm	 		= "<%=search_task_nm%>";
			var search_moneybatchjob	= "<%=search_moneybatchjob%>";
			var search_critical 		= "<%=search_critical%>";
			var search_approval_state 	= "<%=search_approval_state%>";
			var search_check_approval_yn = "<%=search_check_approval_yn%>";

			var search_param = "&search_data_center="+search_data_center+"&search_state_cd="+search_state_cd+"&search_approval_cd="+search_approval_cd+
							   "&search_gb="+search_gb+"&search_text="+encodeURI(search_text)+"&search_date_gubun="+search_date_gubun+
							   "&search_s_search_date="+search_s_search_date+"&search_e_search_date="+search_e_search_date+
							   "&search_task_nm="+search_task_nm+"&search_moneybatchjob="+search_moneybatchjob+"&search_critical="+search_critical+
							   "&search_approval_state="+search_approval_state+"+&search_check_approval_yn="+search_check_approval_yn;
			
			// search_state_cd가 없으면 결재목록에서 조회
			// search_approval_cd가 없으면 의뫼목록에서 조회
			if ( search_state_cd == "" ) {
				top.addTab('c', '정기작업의뢰결재', '01', '0101', 'tWorks.ez?c=ez005&menu_gb=0101&doc_gb=01'+search_param);
			} else {
				top.addTab('c', '정기작업의뢰조회', '03', '0301', 'tWorks.ez?c=ez004&menu_gb=0301&doc_gb=01'+search_param);
			}
			
			top.closeTab('tabs-99999');			
		});
		
		$("#btn_copy").button().unbind("click").click(function(){
			goRefDocWrite();
		});
		$("#btn_del").button().unbind("click").click(function(){
			goPrc2('del');
		});
		
		$("#mem_lib").click(function(){
			alert("NT 수행서버의 구분자  '\\\\'를 입력 하셔야 합니다 \n'"+" EX : (c:\\\\test\\\\) \n"+"  NT 수행 서버가 아닌 경우 구분자는 '/' 로 입력 하셔야 합니다 \n"+"  EX: (/test/ )'");			
		});

		//form value set
		$("#critical_yn").val("<%=CommonUtil.isNull(docBean.getCritical())%>");
		$("select[name='sHour']").val("<%=vh_fromTime%>");
		$("select[name='sMin']").val("<%=vm_fromTime%>");
		$("select[name='eHour']").val("<%=vh_timeUntil%>");
		$("select[name='eMin']").val("<%=vm_timeUntil%>");
		$("select[name='slate_sub_h']").val("<%=vh_lateSub%>");
		$("select[name='slate_sub_m']").val("<%=vm_lateSub%>");
		$("select[name='slate_time_h']").val("<%=vh_lateTime%>");
		$("select[name='slate_time_m']").val("<%=vm_lateTime%>");
		

		$("#execution_type").val("<%=execution_type%>");
		$("#sel_db_output_format").val("<%=db_output_format%>");
		
		//SMS MAIL 유무 체크박스 세팅
		if("<%=strSms1%>" == "Y") $("input:checkbox[name='sms_1_0']").attr("checked", true);
		if("<%=strMail1%>" == "Y") $("input:checkbox[name='mail_1_0']").attr("checked", true);
		
		if("<%=strSms2%>" == "Y") $("input:checkbox[name='sms_2_0']").attr("checked", true);
		if("<%=strMail2%>" == "Y") $("input:checkbox[name='mail_2_0']").attr("checked", true);
		
		if("<%=strSms3%>" == "Y") $("input:checkbox[name='sms_3_0']").attr("checked", true);
		if("<%=strMail3%>" == "Y") $("input:checkbox[name='mail_3_0']").attr("checked", true);
		
		if("<%=strSms4%>" == "Y") $("input:checkbox[name='sms_4_0']").attr("checked", true);
		if("<%=strMail4%>" == "Y") $("input:checkbox[name='mail_4_0']").attr("checked", true);
		
		if("<%=strSms5%>" == "Y") $("input:checkbox[name='sms_5_0']").attr("checked", true);
		if("<%=strMail5%>" == "Y") $("input:checkbox[name='mail_5_0']").attr("checked", true);
		
		if("<%=strSms6%>" == "Y") $("input:checkbox[name='sms_6_0']").attr("checked", true);
		if("<%=strMail6%>" == "Y") $("input:checkbox[name='mail_6_0']").attr("checked", true);
		
		if("<%=strSms7%>" == "Y") $("input:checkbox[name='sms_7_0']").attr("checked", true);
		if("<%=strMail7%>" == "Y") $("input:checkbox[name='mail_7_0']").attr("checked", true);
		
		if("<%=strSms8%>" == "Y") $("input:checkbox[name='sms_8_0']").attr("checked", true);
		if("<%=strMail8%>" == "Y") $("input:checkbox[name='mail_8_0']").attr("checked", true);
				
		if("<%=strSms9%>" == "Y") $("input:checkbox[name='sms_9_0']").attr("checked", true);
		if("<%=strMail9%>" == "Y") $("input:checkbox[name='mail_9_0']").attr("checked", true);

		if("<%=strSms10%>" == "Y") $("input:checkbox[name='sms_10_0']").attr("checked", true);
		if("<%=strMail10%>" == "Y") $("input:checkbox[name='mail_10_0']").attr("checked", true);

		if("<%=strGrpSms1%>" == "Y") $("input:checkbox[name='grp_sms_1_0']").attr("checked", true);
		if("<%=strGrpMail1%>" == "Y") $("input:checkbox[name='grp_mail_1_0']").attr("checked", true);

		if("<%=strGrpSms2%>" == "Y") $("input:checkbox[name='grp_sms_2_0']").attr("checked", true);
		if("<%=strGrpMail2%>" == "Y") $("input:checkbox[name='grp_mail_2_0']").attr("checked", true);

		viewGrid_2(gridObj_1,"ly_"+gridObj_1.id);
		viewGrid_2(gridObj_2,"ly_"+gridObj_2.id);
		
		viewGrid_1(gridObj_3,"ly_"+gridObj_3.id);
		viewGrid_1(gridObj_4,"ly_"+gridObj_4.id);
		
		//선행 추가
		<%
			if( null!=docBean.getT_conditions_in() && docBean.getT_conditions_in().trim().length()>0 ){				
				aTmpT = CommonUtil.E2K(docBean.getT_conditions_in()).split("[|]");
				for(int t=0; null!=aTmpT&&t<aTmpT.length; t++ ){
					String[] aTmpT1 = aTmpT[t].split(",",3);
		%>		
			//setPreAfterJobs("<%=aTmpT1[0]%>", "1", "M");
			setPreAfterJobs("<%=aTmpT[t]%>", "1", "M");
		<%
				}
			}
		%>
		
		//후행 추가
		<%
			if( null!=docBean.getT_conditions_out() && docBean.getT_conditions_out().trim().length()>0 ){
				aTmpT = CommonUtil.E2K(docBean.getT_conditions_out()).split("[|]");
				for(int t=0; null!=aTmpT&&t<aTmpT.length; t++ ){
					String[] aTmpT1 = aTmpT[t].split(",",3);
				
		%>
			//setPreAfterJobs("<%=aTmpT1[0]%>", "2", "");
			setPreAfterJobs("<%=aTmpT[t]%>", "2", "");
		<%
				}
			}
		%>

			//시간 무시 체크 박스 추가 TO_TIME(time_until컬럼)
		var ignoreTimeUntil	= <%=ignoreTimeUntil%>;
		$("#ignore_time_until").prop("checked", ignoreTimeUntil);
		var ignore_time_until = $(this).prop("checked");
		if (ignore_time_until) {
			$("#eHour").val("");
			$("#eMin").val("");
			$("#time_until").val('>');
		}else {
			$("#time_until").val('');
		}

		//재반영 버튼 클릭
    	$("#btn_admin_approval").button().unbind("click").click(function(){			
    		UpdateFlag();		
    	});
		
		if( task_type == "MFT" ) {
			var input = null;
			var tempvalue = null;
			var frm = document.frm1;
			<c:if test="strTaskType eq 'MFT'">
			for(var key in accountlist) {
				input = '#' + accountlist[key];

				<c:forEach var="account" items="${setvarList}" varStatus="vs">
				if($(input).attr("name") == "${account.var_name}") {
					tempvalue = "${account.var_value}";
					
					if($(input).attr("type") == 'checkbox') {
						if(tempvalue == 1) {
							$(input).attr("checked", true);
						} else {
							$(input).attr("checked", false);
						}
					} else {
						$(input).attr("value", tempvalue);
					}
					
					$(input).attr("disabled", true);
				}
				</c:forEach>
			}
			for(var i=0; i <= 5; i++) {
				for(var key in pathlist) {
					input = '#' + pathlist[key] + i;

					<c:forEach var="account" items="${setvarList}" varStatus="vs">
					if($(input).attr("name") == "${account.var_name}") {
						tempvalue = "${account.var_value}";
						$(input).val(tempvalue);
					}
					</c:forEach>
					$(input).attr("disabled", true);
				}

				for(var key in advancedlist) {
			
					var flag = false;
					<c:forEach var="account" items="${setvarList}" varStatus="vs">
					if(flag == false) {
						input = advancedlist[key] + i;
						if("${account.var_name}" == input) {
							input = document.createElement("input");
							$(input).attr("type","hidden");
							$(input).attr('name',advancedlist[key] + i);
							$(input).attr('id',advancedlist[key] + i);
							tempvalue = "${account.var_value}";
							$(input).attr("value", tempvalue);
							frm.appendChild(input);
							flag = true;
						}
					}
					$(input).attr("disabled", true);
					</c:forEach>
				} 
			}

			var host1 = 'HOST1 = ' + frm.FTP_LHOST.value; 
			var host2 = 'HOST2 = ' + frm.FTP_RHOST.value;
			
			document.getElementById("host11").innerText = host1 + '  TYPE = ' + frm.FTP_CONNTYPE1.value + ' USER = ' + frm.FTP_LUSER.value;
			document.getElementById("host21").innerText = host2 + '  TYPE = ' + frm.FTP_CONNTYPE2.value + ' USER = ' + frm.FTP_RUSER.value;
			</c:if>
		}
	});
		
	function goUserSeqSelect(cd, nm, btn){
	
		var frm1 = document.frm1;
		
		if(btn == "1"){
			frm1.user_nm_1_0.value = nm;
			frm1.user_cd_1_0.value = cd;
			
		}else if(btn == "2"){
			frm1.user_nm_2_0.value = nm;
			frm1.user_cd_2_0.value = cd;
			
		}else if(btn == "3"){
			frm1.user_nm_3_0.value = nm;
			frm1.user_cd_3_0.value = cd;
			
		}else if(btn == "4"){
			frm1.user_nm_4_0.value = nm;
			frm1.user_cd_4_0.value = cd;
			
		}else if(btn == "5"){
			frm1.user_nm_5_0.value = nm;
			frm1.user_cd_5_0.value = cd;
			
		}else if(btn == "6"){
			frm1.user_nm_6_0.value = nm;
			frm1.user_cd_6_0.value = cd;
			
		}else if(btn == "7"){
			frm1.user_nm_7_0.value = nm;
			frm1.user_cd_7_0.value = cd;
			
		}else if(btn == "8"){
			frm1.user_nm_8_0.value = nm;
			frm1.user_cd_8_0.value = cd;
			
		}
	
		dlClose('dl_tmp3');
	}
	
	function fn_cyclic_set(cyclic_value){

		var form = document.frm1;

		if ( cyclic_value == "1" ) {
						
			form.max_wait.value = "0";

			document.getElementById('cyclic_ment').style.display = "";

			form.rerun_max.readOnly = "";

		} else {
			
			form.max_wait.value 		= "3";
			form.rerun_interval.value 	= "false";

			form.rerun_interval.value 		= "";
			form.rerun_interval_time.value 	= "";
			form.cyclic_type.value 			= "";
			form.count_cyclic_from.value 	= "";
			form.interval_sequence.value 	= "";
			form.tolerance.value 			= "";
			form.specific_times.value 		= "";

			document.getElementById('cyclic_ment').innerHTML		= "";
			document.getElementById('cyclic_ment').style.display 	= "none";

			form.rerun_max.value 		= "0";
			form.rerun_max.readOnly 	= "true";
		}
	}



	function fn_cyclic_popup() {

		var frm = document.frm1;

		var cyclic = document.getElementById('cyclic').value;

		if ( cyclic == "0" ) {
			if( !confirm('반복작업이 아닙니다.\n반복작업으로 설정 하시겠습니까?') ) return;
		}

		document.getElementById('cyclic').value = "1";
		fn_cyclic_set('1');		

		openPopupCenter1("about:blank","popupCyclic",450,400);
		
		frm.action = "<%=sContextPath %>/tPopup.ez?c=ez005";
		frm.target = "popupCyclic";    
		frm.submit();
	}
	
		//Step
	function getCodeList(scode_cd, grp_depth, grp_cd, val){
		
		try{viewProgBar(true);}catch(e){}
				
		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=appGrpCodeList&itemGubun=2&scode_cd='+scode_cd+'&grp_depth='+grp_depth+'&grp_cd='+grp_cd;
		
		var xhr = new XHRHandler(url, null
				,function(){
					var xmlDoc = this.req.responseXML;
					if(xmlDoc==null){
						try{viewProgBar(false);}catch(e){}
						alert('세션이 만료되었습니다 다시 로그인해 주세요');
						return false;
					}
					if($(xmlDoc).find('doc').length == 0 && $(xmlDoc).find('error').length > 0){
						try{viewProgBar(false);}catch(e){}
						alert($(xmlDoc).find('msg_code').text());
						//goCommonError('<%=sContextPath %>','_self',$(xmlDoc).find('msg_code').text());
						return false;
					}
					$(xmlDoc).find('doc').each(function(){
						
						var items = $(this).find('items');
						var rowsObj = new Array();
												
						if(items.attr('cnt')=='0'){
							$("select[name='"+val+"'] option").remove();
							$("select[name='"+val+"']").append("<option value=''>--선택--</option>");							
						}else{
							
							$("select[name='"+val+"'] option").remove();
							$("select[name='"+val+"']").append("<option value=''>--선택--</option>");			
							
							items.find('item').each(function(i){						
							
								var grp_cd = $(this).find("GRP_CD").text();
								var grp_nm = $(this).find("GRP_NM").text();								
								var grp_eng_nm = $(this).find("GRP_ENG_NM").text();
								var grp_desc = $(this).find("GRP_DESC").text();
								var grp_all_cd = grp_cd+","+grp_eng_nm;
																																																								
								$("select[name='"+val+"']").append("<option value='"+grp_all_cd+"'>"+grp_desc+"</option>");
								
							});						
						}									
						
					});
					try{viewProgBar(false);}catch(e){}
				}
		, null );
		
		xhr.sendRequest();
	}
		
	
	
	//서버내역 가져오기
	function hostList(host_cd){		
		
		try{viewProgBar(true);}catch(e){}
				
		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=hostList&host_cd='+host_cd;
		
		var xhr = new XHRHandler(url, null
				,function(){
					var xmlDoc = this.req.responseXML;
					if(xmlDoc==null){
						try{viewProgBar(false);}catch(e){}
						alert('세션이 만료되었습니다 다시 로그인해 주세요');
						return false;
					}
					if($(xmlDoc).find('doc').length == 0 && $(xmlDoc).find('error').length > 0){
						try{viewProgBar(false);}catch(e){}
						alert($(xmlDoc).find('msg_code').text());
						//goCommonError('<%=sContextPath %>','_self',$(xmlDoc).find('msg_code').text());
						return false;
					}
					$(xmlDoc).find('doc').each(function(){
						
						var items = $(this).find('items');
						var rowsObj = new Array();
						
						if(items.attr('cnt')=='0'){
							$("select[name='host_id'] option").remove();
							$("select[name='host_id']").append("<option value=''>--선택--</option>");	
						}else{
							$("select[name='host_id'] option").remove();
							$("select[name='host_id']").append("<option value=''>--선택--</option>");			
							
							items.find('item').each(function(i){						
							
								var host_cd = $(this).find("HOST_CD").text();								
								var node_id = $(this).find("NODE_ID").text();
								var node_nm = $(this).find("NODE_NM").text();
								var all_cd = host_cd+","+node_id;
								var all_nm = node_nm+"("+node_id+")";
																
								$("select[name='host_id']").append("<option value='"+all_cd+"'>"+all_nm+"</option>");
								
							});						
						}
												
					});
					try{viewProgBar(false);}catch(e){}
				}
		, null );
		
		xhr.sendRequest();
	}

	//서버계정가져오기
	function sCodeList(data_center, node_id){
		
		try{viewProgBar(true);}catch(e){}
					
		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=sCodeList&user_gb=<%=S_USER_GB %>&mcode_cd=${SERVER_MCODE_CD}&data_center='+data_center+'&agent='+node_id;
		
		var xhr = new XHRHandler(url, null
				,function(){
					var xmlDoc = this.req.responseXML;
					if(xmlDoc==null){
						try{viewProgBar(false);}catch(e){}
						alert('세션이 만료되었습니다 다시 로그인해 주세요');
						return false;
					}
					if($(xmlDoc).find('doc').length == 0 && $(xmlDoc).find('error').length > 0){
						try{viewProgBar(false);}catch(e){}
						alert($(xmlDoc).find('msg_code').text());
						//goCommonError('<%=sContextPath %>','_self',$(xmlDoc).find('msg_code').text());
						return false;
					}
					$(xmlDoc).find('doc').each(function(){
						
						var items = $(this).find('items');
						var rowsObj = new Array();
											
						if(items.attr('cnt')=='0'){
							$("select[name='owner'] option").remove();
							$("select[name='owner']").append("<option value=''>--선택--</option>");	
						}else{
							
							$("select[name='owner'] option").remove();
							$("select[name='owner']").append("<option value=''>--선택--</option>");	
							
							items.find('item').each(function(i){						
							
								var scode_cd = $(this).find("SCODE_CD").text();
								var scode_nm = $(this).find("SCODE_NM").text();								
								var scode_eng_nm = $(this).find("SCODE_ENG_NM").text();							
								var host_cd = $(this).find("HOST_CD").text();
															
								$("select[name='owner']").append("<option value='"+scode_eng_nm+"'>"+scode_nm+"</option>");
							});						
						}						
					
					});
					try{viewProgBar(false);}catch(e){}
				}
		, null );
		
		xhr.sendRequest();
	}
	
	function setPreAfterJobs(job_nm, gb, flag){
		
		var m_in_condition_name 	= "";
		var m_in_condition_date 	= "";
		var m_in_condition_and_or 	= "";
		
		var m_out_condition_name 	= "";
		var m_out_condition_date 	= "";
		var m_out_condition_effect 	= "";
		
		var i 	= 0;
		var val = "";
		
		if(gb == "1"){
			i = rowsObj_job1.length+1;
			val = "_in_cond_nm"+i;
		}else if(gb == "2"){
			i = rowsObj_job2.length+1;
			val = "_out_cond_nm"+i;
		}
		
		var job_name 	= "";
		var odate 		= "";
		var gubun 		= "";
		var parentheses_s	= "";
		var parentheses_e	= "";

		// 등록되어 있는 선.후행 뿌려줄 경우 콤마로 구분되어 있음.
		if ( job_nm.split(",", 3) ) {
			var cond = job_nm.split(",", 3);
			job_name 	= cond[0];
			odate 		= cond[1];
			gubun 		= cond[2];
		}
		
		if(job_nm != ""){
			//INCONDITION  설정
			if(gb == "1"){
												
				if(job_name.indexOf("(") == 0) {
					job_name	= job_name.replace("(", "");
					parentheses_s = "(";
				}

				if(job_name.indexOf(")") == job_name.length-1) {
					job_name	= job_name.replace(")", "");
					parentheses_e = ")";
				}

				var dup_cnt = 0;
				setGridSelectedRowsAll(gridObj_1);		//중복체크를 위해 전체항목 선택
				
				var aSelRow = new Array;
				aSelRow = $('#'+gridObj_1.id).data('grid').getSelectedRows();
							
				if(aSelRow.length>0){
					for(var j=0;j<aSelRow.length;j++){						
						var v_cond_nm = getCellValue(gridObj_1,aSelRow[j],'chk_condition_name');		
						
						if(v_cond_nm == job_nm){
							++dup_cnt;
							break;
						}
					}
				}
								
				clearGridSelected(gridObj_1)		//선택된 전체항목 해제 */
				
				if(typeof odate == "undefined") odate = "ODAT";
				if(typeof gubun == "undefined") gubun = "and";
				
				if(dup_cnt > 0){	//중복된 내용이 있다면 (잡명)
					alert("이미 등록된 내용 입니다.");
					return;
				}else{
										
					rowsObj_job1.push({
						'grid_idx':i
						,'m_in_condition_parentheses_s'	: parentheses_s
						,'m_in_condition_name': job_name
						,'m_in_condition_parentheses_e'	: parentheses_e
						,'m_in_condition_date': odate
						,'m_in_condition_and_or': gubun	
						,'chk_condition_name': job_name
					});
				
					gridObj_1.rows = rowsObj_job1;
					setGridRows(gridObj_1);
					
					if(flag != "M"){
						alert("선택 항목이 추가 되었습니다.");
					}
				}

			}else if(gb == "2"){
								
				var dup_cnt = 0;				
				setGridSelectedRowsAll(gridObj_2);		//중복체크를 위해 전체항목 선택
				
				var aSelRow = new Array;
				aSelRow = $('#'+gridObj_2.id).data('grid').getSelectedRows();
							
				if(aSelRow.length>0){
					for(var j=0;j<aSelRow.length;j++){						
						var v_cond_nm = getCellValue(gridObj_2,aSelRow[j],'chk_condition_name');		
						
						if(v_cond_nm == job_nm){
							++dup_cnt;
							break;
						}
					}
				}
								
				clearGridSelected(gridObj_2)		//선택된 전체항목 해제 */
								
				if(typeof odate == "undefined") odate = "ODAT";
				if(typeof gubun == "undefined") gubun = "add";
				
				if(dup_cnt > 0){	//중복된 내용이 있다면 (잡명)
					alert("이미 등록된 내용 입니다.");
					return;
				}else{	
									
					rowsObj_job2.push({
						'grid_idx':i
						,'m_out_condition_name': job_name
						,'m_out_condition_date': odate
						,'m_out_condition_effect': gubun		
						,'chk_condition_name': job_name
					});
					
					gridObj_2.rows = rowsObj_job2;
					setGridRows(gridObj_2);
				}
			}
		}
	}
	
	function getPreAfterJobs(gb){
		
		if(gb == "1"){			
			var cnt = 0;
			var row_idx = rowsObj_job1.length;
						
			if(row_idx > 0){
				delGridRow(gridObj_1, row_idx-1);
			}			
			
		}else if(gb == "2"){
			var cnt = 0;
			var row_idx = rowsObj_job2.length;
						
			if (row_idx == 1) {
				alert("자기작업 CONDITION은 삭제할 수 없습니다.");
			} else if (row_idx > 1) {				
				delGridRow(gridObj_2, row_idx-1);
			}
		}
	}

	//입력변수 폼
	function popArgForm(flag){
				
		var sHtml1="<div id='dl_tmp1' style='overflow:hidden;display:none;padding:0;border-top:1px solid blue;border-bottom:1px solid blue;border-left:1px solid blue;border-right:1px solid blue;'>";
		sHtml1+="<form id='form1' name='form1' method='post' onsubmit='return false;'>";
		//sHtml1+="<input type='hidden' name='search_gubun' id='search_gubun' value='job_name' />";
		sHtml1+="<table style='width:100%;height:260px;;border:none;'><tr><td style='vertical-align:top;height:100%;width:500px;'>";
		sHtml1+="날짜검색 : <input type='text' name='cur_date' id='cur_date' class='input datepick' onkeydown='return false;' readonly />&nbsp;&nbsp;<span id='btn_arg_search'>검색</span>";
		sHtml1+="<table style='width:100%;height:100%;border:none;'>";
		sHtml1+="<tr><td id='ly_g_tmp1' style='vertical-align:top;' >";
		sHtml1+="<div id='g_tmp1' class='ui-widget-header ui-corner-all'></div>";
		sHtml1+="</td></tr>";
		sHtml1+="<tr style='height:10px;'><td style='vertical-align:top;'><h5 class='ui-widget-header ui-corner-all' >";
		sHtml1+="<div align='right' class='btn_area_s'>";
		sHtml1+="<div id='ly_total_cnt' style='padding-top:5px;float:left;'></div>";
		sHtml1+="</div>";
		sHtml1+="</h5></td></tr></table>";
		
		sHtml1+="</td></tr></table>";
		
		sHtml1+="</form>";
		
		$('#dl_tmp1').remove();
		$('body').append(sHtml1);
		
		dlPop01('dl_tmp1',"입력변수내역",570,300,false);
				
		var gridObj = {
			id : "g_tmp1"
			,colModel:[
		   		{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'번호',width:50,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}	   		
		   		,{formatter:gridCellNoneFormatter,field:'SCODE_ENG_NM',id:'SCODE_ENG_NM',name:'변수명',width:120,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
		   		,{formatter:gridCellNoneFormatter,field:'SCODE_DESC',id:'SCODE_DESC',name:'설명',width:160,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}	
		   		,{formatter:gridCellNoneFormatter,field:'ARG_VALUE',id:'ARG_VALUE',name:'변환데이터',width:150,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}	 
		   		,{formatter:gridCellNoneFormatter,field:'CHOICE',id:'CHOICE',name:'선택',width:50,headerCssClass:'cellCenter',cssClass:'cellCenter'}
		   		
		   		,{formatter:gridCellNoneFormatter,field:'SCODE_CD',id:'SCODE_CD',name:'SCODE_CD',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
		   		,{formatter:gridCellNoneFormatter,field:'SCODE_NM',id:'SCODE_NM',name:'SCODE_NM',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
		   	]
			,rows:[]
			,vscroll:<%=S_GRID_VSCROLL%>
		};
		
		viewGrid_1(gridObj,'ly_'+gridObj.id);
		//argList(flag);	
		
		var dt = $("#cur_date").val();
		argumentList(dt);
		
		$("#cur_date").addClass("ime_readonly").unbind('click').click(function(){
			dpCalMinMax(this.id,'yymmdd','-365','1');
		});
		
		$("#btn_arg_search").button().unbind("click").click(function(){
			var dt = $("#cur_date").val();
			argumentList(dt);
		});
	}
	
	function argumentList(dt){
		
		try{viewProgBar(true);}catch(e){}
		$('#ly_total_cnt').html('');
		
		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=argumentList&itemGubun=2&mcode_cd=${ARGUMENT_MCODE_CD}&cur_date='+dt;
		
		var xhr = new XHRHandler(url, null
				,function(){
					var xmlDoc = this.req.responseXML;
					if(xmlDoc==null){
						try{viewProgBar(false);}catch(e){}
						alert('세션이 만료되었습니다 다시 로그인해 주세요');
						return false;
					}
					if($(xmlDoc).find('doc').length == 0 && $(xmlDoc).find('error').length > 0){
						try{viewProgBar(false);}catch(e){}
						alert($(xmlDoc).find('msg_code').text());
						//goCommonError('<%=sContextPath %>','_self',$(xmlDoc).find('msg_code').text());
						return false;
					}
					
					$(xmlDoc).find('doc').each(function(){
						
						var items = $(this).find('items');
						var rowsObj = new Array();
											
						if(items.attr('cnt')=='0'){						
						}else{							
							items.find('item').each(function(i){						
								
								var scode_cd = $(this).find("SCODE_CD").text();
								var scode_nm = $(this).find("SCODE_NM").text();								
								var scode_eng_nm = $(this).find("SCODE_ENG_NM").text();	
								var scode_desc = $(this).find("SCODE_DESC").text();
								var arg_value = $(this).find("ARG_VALUE").text();
								var use_yn = $(this).find("USE_YN").text();
								var choice = "";
								
								scode_eng_nm = scode_eng_nm.substring(2, scode_eng_nm.length);
								
								if(use_yn == "Y"){
									choice = "<div><a href=\"javascript:goSelectCommand('"+scode_nm+"','"+scode_eng_nm+"');\" ><font color='red'>[선택]</font></a></div>";
								}else{
									choice = "";
								}
								
								rowsObj.push({
									'grid_idx':i+1									
									,'SCODE_CD': scode_cd
									,'SCODE_NM': scode_nm
									,'SCODE_ENG_NM': scode_eng_nm
									,'SCODE_DESC': scode_desc	
									,'ARG_VALUE': arg_value
									,'CHOICE': choice
								});
								
							});		
						}						
					
						var obj = $("#g_tmp1").data('gridObj');
						obj.rows = rowsObj;
						setGridRows(obj);
						
						$('#ly_total_cnt').html('[ TOTAL : '+items.attr('cnt')+' ]');
						
					});
					try{viewProgBar(false);}catch(e){}
				}
		
		, null );
		
		xhr.sendRequest();
	}	
	
	//입력변수 가져오기
	function argList(flag){
		
		try{viewProgBar(true);}catch(e){}
		$('#ly_total_cnt').html('');
		
		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=sCodeList&mcode_cd=${ARGUMENT_MCODE_CD}&host_eng_nm=N';
		
		var xhr = new XHRHandler(url, null
				,function(){
					var xmlDoc = this.req.responseXML;
					if(xmlDoc==null){
						try{viewProgBar(false);}catch(e){}
						alert('세션이 만료되었습니다 다시 로그인해 주세요');
						return false;
					}
					if($(xmlDoc).find('doc').length == 0 && $(xmlDoc).find('error').length > 0){
						try{viewProgBar(false);}catch(e){}
						alert($(xmlDoc).find('msg_code').text());
						//goCommonError('<%=sContextPath %>','_self',$(xmlDoc).find('msg_code').text());
						return false;
					}
					//변수 값 세팅 -- set
					
					if(flag == "parm"){
						$(xmlDoc).find('doc').each(function(){
							
						var items = $(this).find('items');
						var rowsObj = new Array();
						
						var scode_eng_nm0 = "<div class='gridInput_area'><input type='text' name='scode_eng_nm0' id='scode_eng_nm0' style='width:100%;'/></div>";
						var scode_desc0 = "<div class='gridInput_area'><input type='text' name='scode_desc0' id='scode_desc0' style='width:100%;'/></div>";
						var v_scode_eng_nm = $("#scode_eng_nm0").val();
						var v_scode_desc = $("#scode_desc0").val();
							
						rowsObj.push({
							'grid_idx':""							
							,'SCODE_CD': ""
							,'SCODE_NM': ""
							,'SCODE_ENG_NM': scode_eng_nm0
							,'SCODE_DESC': scode_desc0
							,'CHOICE':"<div><a href=\"javascript:goSelect4();\" ><font color='red'>[선택]</font></a></div>"
						});
							
						if(items.attr('cnt')=='0'){						
						}else{							
							items.find('item').each(function(i){						
								
								var scode_cd = $(this).find("SCODE_CD").text();
								var scode_nm = $(this).find("SCODE_NM").text();								
								var scode_eng_nm = $(this).find("SCODE_ENG_NM").text();	
								var scode_desc = $(this).find("SCODE_DESC").text();
								
								rowsObj.push({
									'grid_idx':i+1									
									,'SCODE_CD': scode_cd
									,'SCODE_NM': scode_nm
									,'SCODE_ENG_NM': scode_eng_nm
									,'SCODE_DESC': scode_desc	
									,'CHOICE':"<div><a href=\"javascript:goSelect2('"+scode_nm+"','"+scode_eng_nm+"');\" ><font color='red'>[선택]</font></a></div>"
								});
								
							});		
						}
					
						
						var obj = $("#g_tmp1").data('gridObj');
						obj.rows = rowsObj;
						setGridRows(obj);
						
						$('#ly_total_cnt').html('[ TOTAL : '+items.attr('cnt')+' ]');
						
					});
					try{viewProgBar(false);}catch(e){}
					
				//Argument 값 세팅 -- command
				}else if(flag == "argmt"){
					
					$(xmlDoc).find('doc').each(function(){
						
						var items = $(this).find('items');
						var rowsObj = new Array();
											
						if(items.attr('cnt')=='0'){						
						}else{							
							items.find('item').each(function(i){						
								
								var scode_cd = $(this).find("SCODE_CD").text();
								var scode_nm = $(this).find("SCODE_NM").text();								
								var scode_eng_nm = $(this).find("SCODE_ENG_NM").text();	
								var scode_desc = $(this).find("SCODE_DESC").text();
								
								scode_eng_nm = scode_eng_nm.substring(2, scode_eng_nm.length);
								
								rowsObj.push({
									'grid_idx':i+1									
									,'SCODE_CD': scode_cd
									,'SCODE_NM': scode_nm
									,'SCODE_ENG_NM': scode_eng_nm
									,'SCODE_DESC': scode_desc	
									,'CHOICE':"<div><a href=\"javascript:goSelectCommand('"+scode_nm+"','"+scode_eng_nm+"');\" ><font color='red'>[선택]</font></a></div>"
								});
								
							});		
						}						
					
						var obj = $("#g_tmp1").data('gridObj');
						obj.rows = rowsObj;
						setGridRows(obj);
						
						$('#ly_total_cnt').html('[ TOTAL : '+items.attr('cnt')+' ]');
						
					});
					try{viewProgBar(false);}catch(e){}
				}
			}
		, null );
		
		xhr.sendRequest();
	}
	
	
	//변수 입력 받는 TEXT select 박스
	function goSelect4(){
		var scode_eng_nm = $("#scode_eng_nm0").val();
		var scode_desc = $("#scode_desc0").val();	
		
		if(scode_eng_nm != "" && scode_desc != ""){
			goSelect2(scode_eng_nm, scode_desc);
			
			//선택버튼 클릭 후 값 초기화
			$("#scode_eng_nm0").val("");
			$("#scode_desc0").val("");
						
			dlClose('dl_tmp1');
		}else{
			alert("변수명 또는 설명을 입력하세요.");
			
			//선택버튼 클릭 후 값 초기화
			$("#scode_eng_nm0").val("");
			$("#scode_desc0").val("");			
						
			return;
		}
				
	}	
		
	function goSelect2(nm, desc){
				
		var arg_var = $("#arg_var").val();
		var arg_val = $("#arg_val").val();	
		var arg_code = $("#arg_code").val();
		
		var dup_cnt = 0;
		var lst_arg_val = "";
		var desc2 = desc.replace("º","%");
		
		if(arg_var == ""){
			arg_var += desc2;	
			arg_code += nm;
			
			$("#arg_var").val(arg_var);
			$("#arg_code").val(arg_code);
			
			lst_arg_val = nm+","+desc2;
			arg_val += lst_arg_val;
			$("#arg_val").val(arg_val);
			
		}else{			
			var arr_arg_code = arg_code.split(",");
						
			for(var i in arr_arg_code){
				if(nm == arr_arg_code[i]){
					++dup_cnt;
				}
			}
						
			if(dup_cnt == 0){
				arg_var += ","+desc2;
				arg_code += ","+nm;
				
				$("#arg_var").val(arg_var);
				$("#arg_code").val(arg_code);
				
				lst_arg_val = nm+","+desc2;
				
				if(arg_val == ""){
					arg_val += lst_arg_val;
				}else{
					arg_val += "|"+lst_arg_val;
				}				
			
				$("#arg_val").val(arg_val);
			}else{
				alert("이미 추가된 항목 입니다.");
				return;
			}
		}				
	}
	
	
	function goSelectCommand(nm, desc){
		
		var command = $("#command").val();
		var arg_val = $("#arg_val").val();
		 
		
		var lst_command = "";
		//var desc2 = desc.replace("º","%");
		var desc2 = "%%" + desc;
			$("#command").val(command);
			lst_command = " " + desc2;
			command += lst_command;
			$("#command").val(command);
			$("#arg_val").val(arg_val + " " + desc2);
			
		dlClose('dl_tmp1');
			
	}

	
	

	function getArgDel(){
		$("#arg_var").val("");
		$("#arg_val").val("");
		$("#arg_code").val("");
	}
	
	//APP/GRP 가져오기
	function getAppGrpCodeList(scode_cd, depth, grp_cd, val, eng_nm){
		
		try{viewProgBar(true);}catch(e){}
		
		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=appGrpCodeList&itemGubun=2&p_scode_cd='+scode_cd+'&p_app_eng_nm='+encodeURIComponent(eng_nm)+'&p_grp_depth='+depth+'&p_grp_cd='+grp_cd;
						
		var xhr = new XHRHandler(url, null
				,function(){
					var xmlDoc = this.req.responseXML;
					if(xmlDoc==null){
						try{viewProgBar(false);}catch(e){}
						alert('세션이 만료되었습니다 다시 로그인해 주세요');
						return false;
					}
					if($(xmlDoc).find('doc').length == 0 && $(xmlDoc).find('error').length > 0){
						try{viewProgBar(false);}catch(e){}
						alert($(xmlDoc).find('msg_code').text());
						//goCommonError('<%=sContextPath %>','_self',$(xmlDoc).find('msg_code').text());
						return false;
					}
					$(xmlDoc).find('doc').each(function(){
						
						var items = $(this).find('items');
						var rowsObj = new Array();
												
						if(items.attr('cnt')=='0'){
							$("select[name='"+val+"'] option").remove();
							$("select[name='"+val+"']").append("<option value=''>--선택--</option>");							
						}else{
							
							$("select[name='"+val+"'] option").remove();
							$("select[name='"+val+"']").append("<option value=''>--선택--</option>");			
							
							items.find('item').each(function(i){						
							
								var grp_cd = $(this).find("GRP_CD").text();
								var grp_nm = $(this).find("GRP_NM").text();	
								var grp_desc = $(this).find("GRP_DESC").text();	
								var grp_eng_nm = $(this).find("GRP_ENG_NM").text();
								var arr_grp_cd = grp_cd+","+grp_eng_nm;
																																																								
								$("select[name='"+val+"']").append("<option value='"+grp_eng_nm+"'>"+grp_eng_nm+"</option>");
								
							});						
						}									
						
					});
					try{viewProgBar(false);}catch(e){}
				}
		, null );
		
		xhr.sendRequest();
	}

	function btnShow(doc_cd){
		//alert(doc_cd);
		$("#doc_cd").val(doc_cd);
		
		$("#btn_ins").hide();
		$("#btn_draft").hide();
		$("#btn_draft_admin").show();
	}
	
	//서버내역 가져오기
	function mHostList(grp_nm){		
	
		try{viewProgBar(true);}catch(e){}
				
		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=mHostList&itemGubun=2&grp_nm='+grp_nm;
		
		var xhr = new XHRHandler(url, null
				,function(){
					var xmlDoc = this.req.responseXML;
					if(xmlDoc==null){
						try{viewProgBar(false);}catch(e){}
						alert('세션이 만료되었습니다 다시 로그인해 주세요');
						return false;
					}
					if($(xmlDoc).find('doc').length == 0 && $(xmlDoc).find('error').length > 0){
						try{viewProgBar(false);}catch(e){}
						alert($(xmlDoc).find('msg_code').text());
						//goCommonError('<%=sContextPath %>','_self',$(xmlDoc).find('msg_code').text());
						return false;
					}
					$(xmlDoc).find('doc').each(function(){
						
						var items = $(this).find('items');
						var rowsObj = new Array();
						
						if(items.attr('cnt')=='0'){
							$("select[name='host_id'] option").remove();
							$("select[name='host_id']").append("<option value=''>--선택--</option>");	
						}else{
							$("select[name='host_id'] option").remove();
							$("select[name='host_id']").append("<option value=''>--선택--</option>");	
							
							items.find('item').each(function(i){						
							
								var host_cd = $(this).find("HOST_CD").text();								
								var node_id = $(this).find("NODE_ID").text();
								var node_nm = $(this).find("NODE_NM").text();
								
								var all_cd = host_cd+","+node_id;
								var all_nm = node_nm+"("+node_id+")";
																
								$("select[name='host_id']").append("<option value='"+node_id+"'>"+all_nm+"</option>");
																
							});						
						}
												
					});
					try{viewProgBar(false);}catch(e){}
				}
		, null );
		
		xhr.sendRequest();
	}
	
	// 대그룹 가져오기
	function changeMcodeNmList(system_gb){
	
		try{viewProgBar(true);}catch(e){}
		
		// 코드값이 한자리면 인식을 못하는 현상이 있어서 두자리로 설정해 줌.
		var mcode_gubun = "";
		if ( system_gb == "A" ) {
			mcode_gubun = "AA";
		} else if ( system_gb == "R" ) {
			mcode_gubun = "RR";
		}
			
		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=mCodeList&mcode_gubun='+mcode_gubun;
		
		var xhr = new XHRHandler(url, null
				,function(){
					var xmlDoc = this.req.responseXML;
					if(xmlDoc==null){
						try{viewProgBar(false);}catch(e){}
						alert('세션이 만료되었습니다 다시 로그인해 주세요');
						return false;
					}
					if($(xmlDoc).find('doc').length == 0 && $(xmlDoc).find('error').length > 0){
						try{viewProgBar(false);}catch(e){}
						alert($(xmlDoc).find('msg_code').text());
						//goCommonError('<%=sContextPath %>','_self',$(xmlDoc).find('msg_code').text());
						return false;
					}
					$(xmlDoc).find('doc').each(function(){
						
						var items = $(this).find('items');
						var rowsObj = new Array();
						
						if(items.attr('cnt')=='0'){
							$("select[name='mcode_nm'] option").remove();
							$("select[name='mcode_nm']").append("<option value=''>--선택--</option>");	
						}else{
							
							$("select[name='mcode_nm'] option").remove();
							
							$("select[name='mcode_nm']").append("<option value=''>--선택--</option>");
							
							items.find('item').each(function(i){
							
								var mcode_eng_nm 	= $(this).find("MCODE_ENG_NM").text();								
								var mcode_nm 		= $(this).find("MCODE_NM").text();
												
								$("select[name='mcode_nm']").append("<option value='"+mcode_nm+"'>"+mcode_nm+"</option>");
																
							});						
						}
												
					});
					try{viewProgBar(false);}catch(e){}
				}
		, null );
		
		xhr.sendRequest();
	}
	
	function goPrc(approval_cd, approval_seq, appproval_nm) {
		
		var frm = document.frm1;
		
		frm.approval_cd.value 	= approval_cd;
		frm.approval_seq.value 	= approval_seq;
		
		var app_comment = $("#app_comment").val();
		frm.approval_comment.value = app_comment;
		
		// 반려일 경우 결재자 의견 필수
		if ( approval_cd == "04" && app_comment == "" ) {
			alert("반려는 결재자 의견이 필수입니다.");
			$("#app_comment").focus();
			return;
		}
		
		if( !confirm("["+appproval_nm+"] 하시겠습니까?") ) return;
		
		// 직전 진행했던 파라미터가 넘어가는 걸 방지하기 위해 초기화 (2023.05.25 강명준)
		frm.flag.value 	= "";

		try{viewProgBar(true);}catch(e){}
		
		frm.target = "if1";
		frm.action = "<%=sContextPath%>/tWorks.ez?c=ez006_p";
		frm.submit();
	}

	function goPrc2(flag){

		var frm = document.frm1;

		frm.flag.value 			= flag;

		if( !confirm("삭제하시겠습니까?") ) return;

		// 직전 진행했던 파라미터가 넘어가는 걸 방지하기 위해 초기화 (2023.05.25 강명준)
		frm.approval_cd.value 	= "";

		try{viewProgBar(true);}catch(e){}
		frm.target = "if1";
		frm.action = "<%=sContextPath%>/tWorks.ez?c=ez004_p";
		frm.submit();
	}

	function download(dt, job, file_gb, doc_cd, file_nm) {
		
		var f = document.frm_down;		
		
		f.flag.value 		= "job_doc01";
		f.file_gb.value 	= file_gb;
		f.data_center.value =  dt;
		f.job_nm.value		= job;
		f.doc_cd.value 		= doc_cd;
		
		f.target = "if1";				
		f.action = "<%=sContextPath %>/common.ez?c=fileDownload&file_nm=" + file_nm; 
		f.submit();	
	}
	
	function dataDelete(row, flag){
		
		try{viewProgBar(true);}catch(e){}
		
		if(flag == "1"){
			setGridSelectedRowsAll(gridObj_1);		
			var row_idx = row-1;		
			var aSelRow = new Array;
			aSelRow = $('#'+gridObj_1.id).data('grid').getSelectedRows();	
			
			var rowsObj_2 = new Array();
			for(var i=0;i<aSelRow.length;i++){
				rowsObj_2.push({
					'grid_idx':rowsObj_2.length+1	
					,'m_in_condition_name': getCellValue(gridObj_1,aSelRow[i],"m_in_condition_name")
					,'m_in_condition_date': getCellValue(gridObj_1,aSelRow[i],"m_in_condition_date")
					,'m_in_condition_and_or': getCellValue(gridObj_1,aSelRow[i],"m_in_condition_and_or")
				});	
			}
					
			gridObj_3.rows = rowsObj_2;					
			setGridRows(gridObj_3);		
		
			aSelRow = new Array;
			setGridSelectedRowsAll(gridObj_3);
			aSelRow = $('#'+gridObj_3.id).data('grid').getSelectedRows();
			
			rowsObj_job1 = [];		
			for(var i=0;i<aSelRow.length;i++){			
				if(i == row_idx) continue;			
				rowsObj_job1.push({
					'grid_idx':rowsObj_job1.length+1								
					,'m_in_condition_name': getCellValue(gridObj_3,aSelRow[i],"m_in_condition_name")
					,'m_in_condition_date': getCellValue(gridObj_3,aSelRow[i],"m_in_condition_date")
					,'m_in_condition_and_or': getCellValue(gridObj_3,aSelRow[i],"m_in_condition_and_or")
				});	
			}
			
			gridObj_1.rows = rowsObj_job1;					
			setGridRows(gridObj_1);		
			clearGridSelected(gridObj_1);
		}else if(flag == "2"){
			
			var outCondName = getCellValue(gridObj_2,aSelRow[i],"m_out_condition_name");
			outCondName = outCondName.split("-");
			
			setGridSelectedRowsAll(gridObj_2);		
			var row_idx = row-1;		
			var aSelRow = new Array;
			aSelRow = $('#'+gridObj_2.id).data('grid').getSelectedRows();	
			
			var rowsObj_2 = new Array();
			for(var i=0;i<aSelRow.length;i++){
				rowsObj_2.push({
					'grid_idx':rowsObj_2.length+1	
					,'m_out_condition_name': getCellValue(gridObj_2,aSelRow[i],"m_out_condition_name")
					,'m_out_condition_date': getCellValue(gridObj_2,aSelRow[i],"m_out_condition_date")
					,'m_out_condition_effect': getCellValue(gridObj_2,aSelRow[i],"m_out_condition_effect")
				});	
				
				if(outCondName[0] == 'GLOB'){
					$("select[name='globalCond_yn']").val('N');
				}	
			}
			
			gridObj_4.rows = rowsObj_2;					
			setGridRows(gridObj_4);		
		
			aSelRow = new Array;
			setGridSelectedRowsAll(gridObj_4);
			aSelRow = $('#'+gridObj_4.id).data('grid').getSelectedRows();
			
			rowsObj_job2 = [];		
			for(var i=0;i<aSelRow.length;i++){			
				if(i == row_idx) continue;			
				rowsObj_job2.push({
					'grid_idx':rowsObj_job2.length+1								
					,'m_out_condition_name': getCellValue(gridObj_4,aSelRow[i],"m_out_condition_name")
					,'m_out_condition_date': getCellValue(gridObj_4,aSelRow[i],"m_out_condition_date")
					,'m_out_condition_effect': getCellValue(gridObj_4,aSelRow[i],"m_out_condition_effect")
				});	
			}
			
			gridObj_2.rows = rowsObj_job2;
			setGridRows(gridObj_2);
			clearGridSelected(gridObj_2);
		}
		
		try{viewProgBar(false);}catch(e){}
	}
	
	function goAdminUdt() {
		
		var doc_cd 		= "<%=doc_cd%>";
		var doc_gb 		= "<%=doc_gb%>";
		var state_cd	= "<%=state_cd%>";
		var job_name 	= "<%=strJobName%>";
		var data_center = "<%=strDataCenter%>";

		// admin_udt=Y : 관리자 수정
		location.href = 'tWorks.ez?c=ez004_m&admin_udt=Y&doc_gb='+doc_gb+'&doc_cd='+doc_cd+'&state_cd='+state_cd+'&job_name='+encodeURI(job_name)+'&data_center='+data_center;
	}
	
	function goCancel() {		
		
		var frm = document.frm1;
		
		if( !confirm("[승인취소] 하시겠습니까?") ) return;
		
		try{viewProgBar(true);}catch(e){}		

		frm.flag.value 	= "def_cancel";

		// 직전 진행했던 파라미터가 넘어가는 걸 방지하기 위해 초기화 (2023.05.25 강명준)
		frm.approval_cd.value 	= "";

		frm.target 		= "if1";
		frm.action 		= "<%=sContextPath%>/tWorks.ez?c=ez006_p";
		frm.submit();
	}
	
	function goRefDocWrite() {

		var frm = document.frm1;
		
		var job_name	= "<%=strJobName%>";

		frm.flag.value 	= 'ref';
		frm.tabId.value = "<%=doc_cd%>";
		frm.action 		= "<%=sContextPath%>/tWorks.ez?c=ez004_m&job_name="+job_name;
		
		frm.submit();
			
	}
	
	function CalDetail() {
		
		fn_sch_forecast();
	}
	
	// 입력창이 아닌 조회창에서의 스케줄 미리보기
	function fn_sch_forecast() {

		var frm = document.frm_sch;

		openPopupCenter2("about:blank", "fn_sch_forecast", 1000, 500);

		frm.action = "<%=sContextPath %>/tWorks.ez?c=ez033";
		frm.target = "fn_sch_forecast";
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
	
	function fn_mft_advanced(num) {
		var frm = document.frm1;
		
		if(frm.FTP_ACCOUNT.value == "" || frm.FTP_ACCOUNT.value == null){
			alert("ACCOUNTS를 조회하세요");
			return;
		}
		
		frm.advanced_num.value = num;
		
		openPopupCenter1("about:blank", "fn_mft_advanced", 550, 730);
		
		frm.action = "<%=sContextPath %>/tPopup.ez?c=ez049";
		frm.target = "fn_mft_advanced";
		frm.submit();
	}
	
</script>
<%@include file="/jsp/common/inc/progBar.jsp"  %>
<iframe name="if1" id="if1" width="0" height="0"></iframe>
</div>
</body>
</html>