<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/jsp/common/inc/header.jsp"%>
<%@include file="/jsp/common/inc/hint.jsp"%>
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
	<script type="text/javascript" src="<%=request.getContextPath() %>/js/calendar.js" ></script>
	<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery-ui.multidatespicker.js" ></script>

</head>


<%

	Map<String, Object> paramMap = CommonUtil.collectParameters(request);
	String c 		= CommonUtil.isNull(paramMap.get("c"));
	String gridId 	= "g_"+c;
	String gridId_1 = "g_"+c+"_1";
	String gridId_2 = "g_"+c+"_2";
	String gridId_3 = "g_"+c+"_3";
	String gridId_4 = "g_"+c+"_4";

	// admin_udt=Y : 관리자 수정
	String admin_udt 	= CommonUtil.isNull(paramMap.get("admin_udt"));

	String s_doc_gb 	= CommonUtil.isNull(paramMap.get("s_doc_gb"));
	String s_gb 		= CommonUtil.isNull(paramMap.get("s_gb"));
	String s_text 		= CommonUtil.isNull(paramMap.get("s_text"));
	String s_state_cd 	= CommonUtil.isNull(paramMap.get("s_state_cd"));

	String state_cd 	= CommonUtil.isNull(paramMap.get("state_cd"));
	String approval_cd 	= CommonUtil.isNull(paramMap.get("approval_cd"));

	String doc_cd 		= CommonUtil.isNull(paramMap.get("doc_cd"));
	String max_doc_cd	= CommonUtil.isNull(paramMap.get("max_doc_cd"));
	String doc_gb 		= CommonUtil.isNull(paramMap.get("doc_gb"));

	String table_id 	= CommonUtil.isNull(paramMap.get("table_id"));
	String job_id 		= CommonUtil.isNull(paramMap.get("job_id"));


	String job_name 	= CommonUtil.isNull(paramMap.get("job_name"));

	String sched_table 	= CommonUtil.isNull(paramMap.get("sched_table"));
	String rc 			= CommonUtil.isNull(paramMap.get("rc"));
	String flag			= CommonUtil.isNull(paramMap.get("flag"));
	
	String grpJobChk	= (String)request.getAttribute("grpJobChk");

	// 목록 화면 검색 파라미터.
	String search_data_center 		= CommonUtil.isNull(paramMap.get("search_data_center"));
	// 결재목록에서 넘어온 값
	String search_approval_cd 		= CommonUtil.isNull(paramMap.get("search_approval_cd"));
	// 의뢰목록에서 넘어온 값
	String search_state_cd 			= CommonUtil.isNull(paramMap.get("search_state_cd"));
	String search_apply_cd			= CommonUtil.isNull(paramMap.get("search_apply_cd"));
	String search_gb 				= CommonUtil.isNull(paramMap.get("search_gb"));
	String search_text 				= CommonUtil.isNull(paramMap.get("search_text"));
	String search_date_gubun 		= CommonUtil.isNull(paramMap.get("search_date_gubun"));
	String search_s_search_date 	= CommonUtil.isNull(paramMap.get("search_s_search_date"));
	String search_e_search_date 	= CommonUtil.isNull(paramMap.get("search_e_search_date"));
	String search_task_nm 			= CommonUtil.isNull(paramMap.get("search_task_nm"));
	String search_moneybatchjob		= CommonUtil.isNull(paramMap.get("search_moneybatchjob"));
	String search_critical			= CommonUtil.isNull(paramMap.get("search_critical"));
	String search_approval_state 	= CommonUtil.isNull(paramMap.get("search_approval_state"));
	String search_check_approval_yn	= CommonUtil.isNull(paramMap.get("search_check_approval_yn"));

	String tabId					= CommonUtil.isNull(paramMap.get("tabId"));
	String doc_cnt					= CommonUtil.isNull(paramMap.get("doc_cnt"),"0");

	if ( !max_doc_cd.equals("") ) {
		doc_cd = max_doc_cd;
	}

	if ( tabId.equals("")) {
		//tabId = doc_cd;
	}

	List approvalInfoList		= (List)request.getAttribute("approvalInfoList");
	List approvalLineList		= (List)request.getAttribute("approvalLineList");
	List dataCenterList			= (List)request.getAttribute("dataCenterList");
	List sCodeList				= (List)request.getAttribute("sCodeList");
	List jobTypeGbList			= (List)request.getAttribute("jobTypeGb");
// 	List systemGbList			= (List)request.getAttribute("systemGb");
	List sBatchGradeList		= (List)request.getAttribute("sBatchGradeList");
	List resourceDefaultList 	= (List)request.getAttribute("resourceDefaultList");
	List variableDefaultList 	= (List)request.getAttribute("variableDefaultList");
	List adminApprovalBtnList 	= (List)request.getAttribute("adminApprovalBtnList");
	List smsDefaultList			= (List)request.getAttribute("smsDefaultList");
	List mailDefaultList		= (List)request.getAttribute("mailDefaultList");
	List setvarList				= (List)request.getAttribute("setvarList");
	List databaseList				= (List)request.getAttribute("databaseList");
	
	List<CommonBean> inOutList 		= new ArrayList<CommonBean>();
	
	String smart_yn				= (String)request.getAttribute("smart_yn");

	JobMapperBean jobMapperBean	= (JobMapperBean)request.getAttribute("jobMapperInfo");
	Doc01Bean docBean			= (Doc01Bean)request.getAttribute("doc04");

	// 참조기안시 작업명을 가지고 매퍼를 찾기 때문에 필요.
	String strJobName 			= CommonUtil.E2K(docBean.getJob_name());
	
	String strTableNm		= CommonUtil.E2K(docBean.getTable_name());
	String strSubTableNm	= strTableNm;
	if(strTableNm.indexOf("/") > -1 ) {
		strSubTableNm = strTableNm;
		strTableNm 	  = strTableNm.substring(0, strTableNm.indexOf("/"));
	}

	String strMonth_days 		= CommonUtil.E2K(docBean.getMonth_days());
	String strSchedule_and_or 	= CommonUtil.E2K(docBean.getSchedule_and_or());
	String strWeek_days 		= CommonUtil.E2K(docBean.getWeek_days());
	String strDays_cal 			= CommonUtil.E2K(docBean.getDays_cal());
	String strWeeks_cal 		= CommonUtil.E2K(docBean.getWeeks_cal());
	String strMemLib			= CommonUtil.E2K(docBean.getMem_lib());
	String strTaskType			= CommonUtil.E2K(docBean.getTask_type());
	String strActiveFrom		= CommonUtil.E2K(docBean.getActive_from());
	String strActiveTill		= CommonUtil.E2K(docBean.getActive_till());


	if(strMemLib.length() > 3 && strMemLib.substring(2, 3).equals("\\") && !strMemLib.substring(3, 4).equals("\\")){
		strMemLib = strMemLib.replaceAll("\\\\", "\\\\\\\\");
	}

	String strT_set = CommonUtil.isNull(docBean.getT_set());
	String strT_res 					= CommonUtil.isNull(docBean.getT_resources_q());
	String strServerGb 		= CommonUtil.isNull(CommonUtil.getMessage("SERVER_GB"));
	String strAdminApprovalBtn			= "";
	String[] strTsetnv 					= null;
	String strTsetName 					= "";
	String[] strTresnv					= null;
	String strTresName					= "";
	
	String strResourceDefaultValue 		= "";
	String strResourceDefaultName		= "";
	String strResourceDefaultNameList 	= "";
	
	String strVariableDefaultValue 		= "";
	String strVariableDefaultName		= "";
	String strVariableDefaultNameList 	= "";
	
	if ( adminApprovalBtnList != null ) {		
		for ( int i = 0; i < adminApprovalBtnList.size(); i++ ) {			
			CommonBean commonBean = (CommonBean) adminApprovalBtnList.get(i);			
			strAdminApprovalBtn = CommonUtil.isNull(commonBean.getScode_nm());
		}
	}

	if ( resourceDefaultList != null ) {
		for ( int i = 0; i < resourceDefaultList.size(); i++ ) {
			CommonBean commonBean = (CommonBean) resourceDefaultList.get(i);
			strResourceDefaultValue = CommonUtil.isNull(commonBean.getScode_nm());
			strResourceDefaultName 	= CommonUtil.isNull(commonBean.getScode_eng_nm());
			
			strResourceDefaultNameList += strResourceDefaultName;
			strResourceDefaultNameList += ",";
		}
	}
	
	if( !strT_res.equals("") ){
		strTresnv = strT_res.split("[|]");
		for(int t=0; null!=strTresnv&&t<strTresnv.length; t++ ){
			String[] aTmpT1 = strTresnv[t].split(",",2);
			strTresName += aTmpT1[0];
			strTresName += ",";
		}
		strTresName = strTresName.substring(0,strTresName.length()-1);
	}
	
	if ( variableDefaultList != null ) {
		for ( int i = 0; i < variableDefaultList.size(); i++ ) {
			CommonBean commonBean = (CommonBean) variableDefaultList.get(i);
			strVariableDefaultValue = CommonUtil.isNull(commonBean.getScode_nm());
			strVariableDefaultName 	= CommonUtil.isNull(commonBean.getScode_eng_nm());
			
			strVariableDefaultNameList += strVariableDefaultName;
			strVariableDefaultNameList += ",";
		}
	}
	
	if( !strT_set.equals("") ){
		strTsetnv = strT_set.split("[|]");
		for(int t=0; null!=strTsetnv&&t<strTsetnv.length; t++ ){
			String[] aTmpT1 = strTsetnv[t].split(",",2);
			strTsetName += aTmpT1[0];
			strTsetName += ",";
		}
		strTsetName = strTsetName.substring(0,strTsetName.length()-1);
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
				file_content 		= commonBean.getVar_value();
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
				query = query.replaceAll("&amp;", "&").replaceAll("&lt;", "<").replaceAll("&gt;", ">");
				query = query.replaceAll("<br>", "\n");
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
	
	String FTP_ACCOUNT				= "";
	String FTP_RPF					= "";
	String FTP_CONT_EXE_NOTOK 		= "";
	String FTP_USE_DEF_NUMRETRIES 	= "";
	boolean RPF_CHK					= false;
	boolean CONT_EXE_NOTOK_CHK  	= false;
	boolean USE_DEF_NUMRETRIES_CHK  = false;
	
	if(setvarList != null){
		for ( int i = 0; i < setvarList.size(); i++ ) {
			CommonBean commonBean = (CommonBean) setvarList.get(i);
			var_name	= commonBean.getVar_name();
			if(var_name.equals("FTP_ACCOUNT")){
				FTP_ACCOUNT = commonBean.getVar_value();
			}
			if(var_name.equals("FTP_RPF")){
				FTP_RPF = commonBean.getVar_value();
			}
			if(var_name.equals("FTP_CONT_EXE_NOTOK")){
				FTP_CONT_EXE_NOTOK = commonBean.getVar_value();
				
			}
			if(var_name.equals("FTP_USE_DEF_NUMRETRIES")){
				FTP_USE_DEF_NUMRETRIES = commonBean.getVar_value();
			}
		}		
	}
	
	if(FTP_RPF.equals("1")) 				RPF_CHK = true;
	if(FTP_CONT_EXE_NOTOK.equals("1")) 		CONT_EXE_NOTOK_CHK = true;
	if(FTP_USE_DEF_NUMRETRIES.equals("1")) 	USE_DEF_NUMRETRIES_CHK = true;
	

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
	String strUserNm9			= "";
	String strUserNm10 			= "";

	String strDescription		= "";
	String strErrorDescription	= "";

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
	String strMail9				= "";
	String strMail10			= "";

	String strGrpCd1 			= "";
	String strGrpCd2 			= "";
	String strGrpNm1			= "";
	String strGrpNm2			= "";
	String strGrpSms1			= "";
	String strGrpSms2			= "";
	String strGrpMail1			= "";
	String strGrpMail2			= "";

	String strLateSub			= "";
	String strLateTime			= "";
	String strLateExec			= "";

	String strCcCount 			= "";
	String batchJobGrade			= "";

	String strJobTypeGb           	= "";
	String jobTypeGb             	= "";

	String strUserCd1 				= "";
	String strUserCd2 				= "";
	String strUserCd3 				= "";
	String strUserCd4 				= "";
	String strUserCd5 				= "";
	String strUserCd6 				= "";
	String strUserCd7 				= "";
	String strUserCd8 				= "";
	String strUserCd9				= "";
	String strUserCd10 				= "";

	String	strDataCenter		= "";
	String	strDataCenterName	= "";

	String	strSuccessSmsYn		= "";

	if ( jobMapperBean != null ) {

		strUserCd1 			= CommonUtil.isNull(jobMapperBean.getUser_cd_1());
		strUserCd2 			= CommonUtil.isNull(jobMapperBean.getUser_cd_2());
		strUserCd3 			= CommonUtil.isNull(jobMapperBean.getUser_cd_3());
		strUserCd4 			= CommonUtil.isNull(jobMapperBean.getUser_cd_4());
		strUserCd5 			= CommonUtil.isNull(jobMapperBean.getUser_cd_5());
		strUserCd6 			= CommonUtil.isNull(jobMapperBean.getUser_cd_6());
		strUserCd7 			= CommonUtil.isNull(jobMapperBean.getUser_cd_7());
		strUserCd8 			= CommonUtil.isNull(jobMapperBean.getUser_cd_8());
		strUserCd9 			= CommonUtil.isNull(jobMapperBean.getUser_cd_9());
		strUserCd10 		= CommonUtil.isNull(jobMapperBean.getUser_cd_10());
		strUserNm1 			= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getUser_nm_1()), "");
		strUserNm2 			= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getUser_nm_2()), "");
		strUserNm3 			= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getUser_nm_3()), "");
		strUserNm4 			= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getUser_nm_4()), "");
		strUserNm5 			= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getUser_nm_5()), "");
		strUserNm6 			= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getUser_nm_6()), "");
		strUserNm7 			= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getUser_nm_7()), "");
		strUserNm8 			= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getUser_nm_8()), "");
		strUserNm9 			= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getUser_nm_9()), "");
		strUserNm10 		= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getUser_nm_10()), "");

		strDescription 		= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getDescription()), "");
		strErrorDescription = CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getError_description()), "");

		strSms1 			= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getSms_1()), "");
		strSms2 			= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getSms_2()), "");
		strSms3 			= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getSms_3()), "");
		strSms4 			= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getSms_4()), "");
		strSms5 			= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getSms_5()), "");
		strSms6 			= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getSms_6()), "");
		strSms7 			= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getSms_7()), "");
		strSms8 			= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getSms_8()), "");
		strSms9 			= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getSms_9()), "");
		strSms10 			= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getSms_10()), "");
		strMail1 			= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getMail_1()), "");
		strMail2 			= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getMail_2()), "");
		strMail3 			= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getMail_3()), "");
		strMail4 			= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getMail_4()), "");
		strMail5 			= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getMail_5()), "");
		strMail6 			= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getMail_6()), "");
		strMail7 			= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getMail_7()), "");
		strMail8 			= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getMail_8()), "");
		strMail9 			= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getMail_9()), "");
		strMail10 			= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getMail_10()), "");

		strGrpCd1			= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getGrp_cd_1()), "");
		strGrpCd2			= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getGrp_cd_2()), "");
		strGrpNm1			= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getGrp_nm_1()), "");
		strGrpNm2			= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getGrp_nm_2()), "");
		strGrpSms1			= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getGrp_sms_1()), "");
		strGrpSms2			= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getGrp_sms_2()), "");
		strGrpMail1			= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getGrp_mail_1()), "");
		strGrpMail2			= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getGrp_mail_2()), "");

		strLateSub 			= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getLate_sub()), "");
		strLateTime			= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getLate_time()), "");
		strLateExec 		= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getLate_exec()), "");

		strDataCenter		= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getData_center()), "");
		strDataCenterName	= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getData_center_name()), "");

		strCcCount			= CommonUtil.isNull(CommonUtil.E2K(jobMapperBean.getCc_count()), "");
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
	if(strCommand.length() > 3 && strCommand.substring(2, 3).equals("\\") && !strCommand.substring(3, 4).equals("\\")){
		strCommand = strCommand.replaceAll("\\\\", "\\\\\\\\");
	}

	ApprovalInfoBean bean2 = (ApprovalInfoBean)request.getAttribute("bean2");

	String strApprovalMent = "";

	if ( bean2 != null ) {
		strApprovalMent = CommonUtil.isNull(CommonUtil.E2K(bean2.getApproval_ment()), "");
	}

	String strRerunInterval 	= CommonUtil.E2K(docBean.getRerun_interval());
	String strCyclicType 		= CommonUtil.E2K(docBean.getCyclic_type());
	String strCountCyclicFrom 	= CommonUtil.E2K(docBean.getCount_cyclic_from());
	String strIntervalSequence 	= CommonUtil.E2K(docBean.getInterval_sequence());
	String strTolerance 		= CommonUtil.E2K(docBean.getTolerance());
	String strSpecificTimes 	= CommonUtil.E2K(docBean.getSpecific_times());

	String strMaxWait 		= CommonUtil.isNull(docBean.getMax_wait());

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

	String strConfirmFlag 	= CommonUtil.isNull(docBean.getConfirm_flag());
	String strPriority 		= CommonUtil.isNull(docBean.getPriority());

	// 의뢰자 정보
	String strInsUserNm = CommonUtil.isNull(docBean.getUser_nm());
	String strInsDeptNm = CommonUtil.isNull(docBean.getDept_nm());
	String strInsDutyNm = CommonUtil.isNull(docBean.getDuty_nm());
	//반영일
	String strApplyDate = CommonUtil.isNull(docBean.getApply_date());

	String strUserInfo = "["+S_DEPT_NM+"] ["+S_DUTY_NM+"] "+S_USER_NM;
	if ( !strInsUserNm.equals("") ) {
		strUserInfo = "["+strInsDeptNm+"] ["+strInsDutyNm+"] "+strInsUserNm;
	}

	Map<String,String> mStepHid = new HashMap<String,String>();
	mStepHid.put("statement","<input type='hidden' name='m_step_statement_stmt' /><input type='hidden' name='m_step_statement_code' />");
	mStepHid.put("set-var","<input type='hidden' name='m_step_set-var_name'  /><input type='hidden' name='m_step_set-var_value' />");
	mStepHid.put("shout","<input type='hidden' name='m_step_shout_to' /><input type='hidden' name='m_step_shout_urgn' /><input type='hidden' name='m_step_shout_msg' />");
	mStepHid.put("force-job","<input type='hidden' name='m_step_force-job_table' /><input type='hidden' name='m_step_force-job_job_name' /><input type='hidden' name='m_step_force-job_date' /><input type='hidden' name='img_step_force-job_date' />");
	mStepHid.put("sysout","<input type='hidden' name='m_step_sysout_option' /><input type='hidden' name='m_step_sysout_parm' />");
	mStepHid.put("condition","<input type='hidden' name='m_step_condition_name' /><input type='hidden' name='m_step_condition_date' /><input type='hidden' name='img_step_condition_date' /><input type='hidden' name='m_step_condition_sign' />");
	mStepHid.put("mail","<input type='hidden' name='m_step_mail_to' /><input type='hidden' name='m_step_mail_cc' /><input type='hidden' name='m_step_mail_subject' /><input type='hidden' name='m_step_mail_urgn' /><input type='hidden' name='m_step_mail_msg' />");

	String strDefaultMaxWait	= "7";

	// 실행 요일 로직 시작.
	String strWeekDays 		= CommonUtil.E2K(docBean.getWeek_days());
	String[] arrWeekDays 	= null;
	String strTotalWeekDays	= "";
	String strTempWeekDays 		= "";
	String strTempWeekDaysComma	= "";
	String strTempWeekDays2		= "";

	if ( !strWeekDays.equals("") ) {
		arrWeekDays = strWeekDays.split(",");
		for ( int i = 0; i < arrWeekDays.length; i++ ) {
			strTempWeekDays 		= "'" + arrWeekDays[i] + "'";
			strTempWeekDaysComma 	= "'" + arrWeekDays[i] + "',";
			strTotalWeekDays = strTotalWeekDays + strTempWeekDaysComma;

			if ( !(strTempWeekDays.equals("'0'") || strTempWeekDays.equals("'1'") || strTempWeekDays.equals("'2'") || strTempWeekDays.equals("'3'") || strTempWeekDays.equals("'4'") || strTempWeekDays.equals("'5'") || strTempWeekDays.equals("'6'")) ) {
				strTempWeekDays2 = strTempWeekDays2 + strTempWeekDays + ",";
			}
		}

		strTotalWeekDays = strTotalWeekDays.substring(0, strTotalWeekDays.length()-1);

		if ( !strTempWeekDays2.equals("") ) {
			strTempWeekDays2 = strTotalWeekDays.replaceAll("'", "");
		}
	}
	// 실행 요일 로직 종료.
	
	//특정실행날짜
	String t_general_date 	= CommonUtil.isNull(docBean.getT_general_date());
	
// 	if(!t_general_date.equals("")){
// 		String temp_general_date = "";
// 		for(int i=4; i<=t_general_date.length();i+=4){
// 			temp_general_date += t_general_date.substring(i-4,i);
// 			temp_general_date += ", ";
// 		}
		
// 		if(!temp_general_date.equals("")) t_general_date = temp_general_date.substring(0,temp_general_date.length()-2);
// 	}
	
	String strConfCal 	= CommonUtil.isNull(docBean.getConf_cal());
	String strShift 	= CommonUtil.isNull(docBean.getShift());
	String strShiftNum 	= CommonUtil.isNull(docBean.getShift_num());
	Integer intShiftNum = null;
	if (!"".equals(strShiftNum)) intShiftNum = Integer.parseInt(strShiftNum);
	
	request.setAttribute("strTaskType", strTaskType);
%>

<body id='body_A01' leftmargin="0" topmargin="0">

<div style="width:100%; height:100%; overflow-x:hidden; overflow-y:scroll;">
	<form id="f_s" name="f_s" method="post" onsubmit="return false;">
		<input type="hidden" name="p_data_center" 		id="p_data_center"	value="<%=CommonUtil.E2K(docBean.getData_center()) %>"/>
		<input type="hidden" name="p_application" 		id="p_application" />
		<input type="hidden" name="p_group_name_of_def" id="p_group_name_of_def" />
		<input type="hidden" name="p_search_gubun" 		id="p_search_gubun" />
		<input type="hidden" name="p_search_text" 		id="p_search_text" />
		
		<input type="hidden" name="job" 				id="job" />
		<input type="hidden" name="doc_cd" 				id="doc_cd" />
		<input type='hidden' name='table_id'			id='table_id' 			/>
		<input type='hidden' name='job_id'				id='job_id' 			 />
		<input type='hidden' name='sched_table'			id='sched_table'	value="<%=sched_table %>" />

		<input type="hidden" name="p_grp_depth" 		id="p_grp_depth" />
		<input type="hidden" name="p_app_nm" 			id="p_app_nm" />
		<input type="hidden" name="p_app_search_gubun" 	id="p_app_search_gubun" />
	</form>
	<form id="userFrm" name="userFrm" method="post" onsubmit="return false;">
	</form>
	<form name="frm_down" id="frm_down" method="post" onsubmit="return false;">
		<input type="hidden" name="flag" 		id="flag" />
		<input type="hidden" name="file_gb" 	id="file_gb" />
		<input type="hidden" name="data_center" id="data_center" value="<%=strDataCenter%>" />
		<input type="hidden" name="job_nm" 		id="job_nm" />
		<input type="hidden" name="doc_cd" 		id="doc_cd" />
	</form>
	<form id="frm1" name="frm1" method="post" onsubmit="return false;" enctype="multipart/form-data" >

		<input type="hidden" name="flag" id="flag"/>
		<input type="hidden" name="title" id="title"/>
		<input type="hidden" name="is_valid_flag" id="is_valid_flag" />

		<input type="hidden" name="t_conditions_in" id="t_conditions_in" />
		<input type="hidden" name="t_conditions_out" id="t_conditions_out" />
		<input type="hidden" name="t_resources_q" id="t_resources_q" />
		<input type="hidden" name="t_resources_c" id="t_resources_c" />
		<input type="hidden" name="t_steps" id="t_steps" />
		<input type="hidden" name="t_postproc" id="t_postproc" />
		<input type="hidden" name="t_tag_name" id="t_tag_name"/>

		<input type="hidden" name="t_set" id="t_set"/>

		<input type='hidden' id='p_apply_date' name='p_apply_date'/>
		<input type='hidden' id='apply_cd' name='apply_cd'/>

		<input type='hidden' id='table_id' 			name='table_id'				value="<%=table_id %>" />
		<input type='hidden' id='job_id' 			name='job_id' 				value="<%=job_id %>" />
		<input type='hidden' id='sched_table' 		name='sched_table' 			value="<%=sched_table %>" />
		<input type='hidden' id='before_table_name' name='before_table_name' 	value="<%=CommonUtil.E2K(docBean.getBefore_table_name()) %>" />

		<input type="hidden" name="doc_cd" id="doc_cd" value="<%=doc_cd%>" />
		<input type="hidden" name="doc_gb" id="doc_gb" value="<%=doc_gb%>" />
		<input type="hidden" name="retro" id="retro"	value="0" />

		<!-- Cyclic 작업 셋팅 파라미터. -->
		<input type="hidden" name="rerun_interval" 		id="rerun_interval"			value="<%=strRerunInterval%>" />
		<input type="hidden" name="rerun_interval_time" id="rerun_interval_time"	value="M" />
		<input type="hidden" name="cyclic_type" 		id="cyclic_type" 			value="<%=strCyclicType%>" />
		<input type="hidden" name="count_cyclic_from" 	id="count_cyclic_from" 		value="<%=strCountCyclicFrom%>" />
		<input type="hidden" name="interval_sequence" 	id="interval_sequence" 		value="<%=strIntervalSequence%>" />
		<input type="hidden" name="tolerance" 			id="tolerance" 				value="<%=strTolerance%>" />
		<input type="hidden" name="specific_times" 		id="specific_times" 		value="<%=strSpecificTimes%>" />

		<input type="hidden" name="user_cd" id="user_cd"/>

		<input type="hidden" name="host_cd" id="host_cd" />

		<!-- 인터페이스 체크 결과 -->
		<input type="hidden" name="if_return" id="if_return"/>

		<!-- 스마트테이블 체크 결과 -->
		<input type="hidden" name="smart_cnt" 			id="smart_cnt"/>

		<!-- 선행 검색 시 data_center 비교 위해 필요 -->
		<input type="hidden" name="doc_data_center" 	id="doc_data_center"/>

		<!-- 정기, 수시 설정 위해 필요 -->
		<input type="hidden" name="jobSchedGb" 			id="jobSchedGb"/>

		<!-- 미사용 일수 유지 위해 필요 -->
		<input type="hidden" name="cc_count" 			id="cc_count" 		value="<%=strCcCount%>" />

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
		<input type="hidden" name="search_task_nm"			id="search_task_nm" 		value="<%=search_task_nm%>" />
		<input type="hidden" name="search_moneybatchjob"	id="search_moneybatchjob" 	value="<%=search_moneybatchjob%>" />
		<input type="hidden" name="search_critical"			id="search_critical" 		value="<%=search_critical%>" />
		<input type="hidden" name="search_approval_state"	id="search_approval_state" 	value="<%=search_approval_state%>" />
		<input type="hidden" name="search_check_approval_yn"	id="search_check_approval_yn" 	value="<%=search_check_approval_yn%>" />

		<input type="hidden" name="tabId"					id="tabId"					value="<%=tabId%>" />
		<input type="hidden" name="doc_cnt"					id="doc_cnt"				value="<%=doc_cnt%>" />
		<!-- 그룹결재구성원 결재권/알림권 설정 -->
		<input type="hidden" name="grp_approval_userList" 		id="grp_approval_userList"/>
		<input type="hidden" name="grp_alarm_userList" 			id="grp_alarm_userList"/>
				
		<!-- MFT 정보 -->
		<input type='hidden' name='FTP_LHOST' 				id='FTP_LHOST' 				value=""/>
		<input type='hidden' name='FTP_RHOST' 				id='FTP_RHOST' 				value=""/>
		<input type='hidden' name='FTP_LUSER' 				id='FTP_LUSER' 				value=""/>
		<input type='hidden' name='FTP_RUSER' 				id='FTP_RUSER' 				value=""/>
		<input type='hidden' name='FTP_CONNTYPE1' 			id='FTP_CONNTYPE1' 			value=""/>
		<input type='hidden' name='FTP_CONNTYPE2' 			id='FTP_CONNTYPE2' 			value=""/>
		<input type='hidden' name='FTP_USE_DEF_NUMRETRIES' 	id='FTP_USE_DEF_NUMRETRIES' value=""/>
		<input type='hidden' name='FTP_RPF' 				id='FTP_RPF' 				value=""/>
		<input type='hidden' name='FTP_CONT_EXE_NOTOK' 		id='FTP_CONT_EXE_NOTOK' 	value=""/>
		<input type='hidden' name='FTP_LOSTYPE' 			id='FTP_LOSTYPE' 			value=""/>
		<input type='hidden' name='FTP_ROSTYPE' 			id='FTP_ROSTYPE' 			value=""/>

		
		<table style='width:100%;height:100%;border:none;'>
			<tr style='height:10px;'>
				<td style='vertical-align:top;'>
					<h4 class="ui-widget-header ui-corner-all"  >
						<div id='t_<%=gridId %>' class='title_area'>
							<span><%=CommonUtil.getMessage("CATEGORY.GB.02")%> > <%=CommonUtil.getMessage("CATEGORY.GB.03.SB.0304") %></span>
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
												<div class='cellTitle_ez_right' style='min-width:120px' ><font color="red">* </font>반영 예정일</div>
											</td>
											<td colspan="2">
												<input type="text" name="apply_date" id="apply_date" class="input datepick" value="<%=strApplyDate%>" style="width:75px; height:21px;" maxlength="8" autocomplete="off" />
											</td>
										</tr>
									</table>
								</td>
							</tr>

						</table>
						<table style="width:100%">
							<tr>
								<td>
									<div class='cellTitle_kang5'>
										작업 정보 [문서정보 : <%=doc_cd %>]
										<img src="/images/icon_lst23b.png" width="20" height="20" onClick="showHint(job_div,this);" style="cursor:pointer;vertical-align:text-top;" />
									</div>
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
												<div class='cellTitle_ez_right' style='min-width:120px'><font color="red">* </font>C-M</div>
											</td>
											<td>
												<div class='cellContent_kang' style='min-width:250px'>
													<%=CommonUtil.E2K(docBean.getData_center_name()) %>
													<input type="hidden" name="data_center" id="data_center" value="<%=strDataCenter%>"/>
													<input type="hidden" name="data_center_items" id="data_center_items" value="<%=strDataCenter%>"/>
												</div>

											</td>
											<td>
												<div class='cellTitle_ez_right' style='min-width:120px'><font color="red">* </font>작업타입</div>
											</td>
											<td>
												<div class='cellContent_kang'>
													<select id="task_type" name="task_type" style="width:50%;height:21px;">
														<option value="">--선택--</option>
														<%
															for ( int i = 0; i < jobTypeGbList.size(); i++ ) {
																CommonBean bean = (CommonBean)jobTypeGbList.get(i);

														%>
														<option value="<%=CommonUtil.E2K(bean.getScode_eng_nm())%>"><%=bean.getScode_nm()%></option>
														<%
															}
														%>
													</select>
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<div class='cellTitle_ez_right'><font color="red">* </font>폴더</div>
											</td>
											<td>
												<div class='cellContent_kang'>
													<input type="text" name="table_nm" id="table_nm" value="<%=strTableNm%>" style="width:50%; height:21px;" onkeydown="return false;" readonly/>
													<select name="sub_table_of_def" id="sub_table_of_def" style="width:48%;height:21px;display:none;">
														<%if(smart_yn.equals("Y")) { %>
															<option value="sub_table_all">--선택--</option>
														<%}else {%>
															<option value="">--선택--</option>
														<%}%>
														<c:forEach var="subTableList" items="${subTableList}" varStatus="status">
															<option value="${subTableList.sub_table_nm}">${subTableList.sub_table_nm}</option>
														</c:forEach>
													</select>
													<input type="hidden" name="table_of_def" id="table_of_def" />

													<input type="hidden" name="user_daily" id="user_daily" />
													<input type="hidden" name="table_name" id="table_name" value="<%=CommonUtil.isNull(docBean.getTable_name()) %>"/>
												</div>
											</td>
											<td>
												<div class='cellTitle_ez_right'><font color="red">* </font>어플리케이션</div>
											</td>

											<td>
												<div class='cellContent_kang'>
													<select name="application_of_def" id="application_of_def" style="width:50%;height:21px;">
														<option value="">--선택--</option>
													</select>
													<input type="hidden" name="application" id="application" value="<%=CommonUtil.isNull(docBean.getApplication()) %>"/>
												</div>
											</td>
											<td>
												<div class='cellTitle_ez_right' style='min-width:120px'><font color="red">* </font>그룹</div>
											</td>
											<td>
												<div class='cellContent_kang' style='min-width:250px'>
													<select name="group_name_of_def" id="group_name_of_def" style="width:50%;height:21px;">
														<option value="">--선택--</option>
													</select>
													<input type="text" id="group_names" name="group_names" style="width:25%;height:21px;" onblur="fn_group_add(this.id);"/>
													<input type="hidden" name="group_name" id="group_name" value="<%=CommonUtil.isNull(docBean.getGroup_name()) %>"/>
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<div class='cellTitle_ez_right'><font color="red">* </font>수행서버</div>
											</td>
											<td>
												<div class='cellContent_kang'>
													<select name="host_id" id="host_id" style="width:50%;height:21px;">
														<option value="">--선택--</option>
													</select>
													<input type="hidden" name="node_id" id="node_id" value="<%=CommonUtil.E2K(docBean.getNode_id()) %>"/>
												</div>
											</td>
											<td>
												<div class='cellTitle_ez_right'><font color="red">* </font>계정명</div>
											</td>
											<td>
												<div class='cellContent_kang'>
													<select name="owner" id="owner" style="width:50%;height:21px;">
														<option value="">--선택--</option>
													</select>
												</div>
												<input type=hidden name="v_owner" id="v_owner" value= "<%=CommonUtil.E2K(docBean.getOwner()) %>"/>
											</td>
											<td>
												<div class='cellTitle_ez_right'><font color="red">* </font>최대대기일</div>
											</td>
											<td>
												<div class='cellContent_kang'>
													<input type="text" name="max_wait" id="max_wait" maxlength="2" size="2" value="<%= strMaxWait%>" style="height:21px;"/>
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<div class='cellTitle_ez_right'><font color="red">* </font>작업명</div>
											</td>
											<td>
												<div class='cellContent_kang'>
													<%=job_name%>
													<input type="hidden" id="job_nameChk" name="job_nameChk" value="0"/>
													<input type="hidden" id="job_name" name="job_name" value="<%=strJobName %>" />

												</div>
											</td>
											<td>
												<div class='cellTitle_ez_right'><font color="red">* </font>작업 설명</div>
											</td>
											<td colspan="3">
												<div class='cellContent_kang'>
													<input type="text" name="description" id="description" value= "<%=CommonUtil.E2K(docBean.getDescription()) %>"  style="width:80%;height:21px;"/>

												</div>
											</td>
										</tr>
										<tr>
											<td>
												<div class='cellTitle_ez_right'><span class='job_val' style="color:red;"></span>프로그램 명</div>
											</td>
											<td>
												<div class='cellContent_kang'>
													<input type="text" name="mem_name" id="mem_name" value= "<%=CommonUtil.E2K(docBean.getMem_name()) %>"  style= "width:80%;height:21px;ime-mode:disabled;" onkeyup="noSpaceBar(this)"/>
												</div>
											</td>
											<td>
												<div class='cellTitle_ez_right'><span class='job_val' style="color:red;"></span>프로그램 위치</div>
											</td>
											<td colspan="3">
												<div class='cellContent_kang'>
													<input type="text" name="mem_lib" id="mem_lib" value= "<%=strMemLib %>"  style= "width:80%;height:21px;ime-mode:disabled;" onkeyup="noSpaceBar(this)" onblur="fn_slash(this.id);"/>
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<div class='cellTitle_ez_right'><span class='command_val' style="color:red;"></span>작업수행명령</div>
											</td>
											<td colspan="5">
												<div class='cellContent_kang'>
													<input type="text" name="command" id="command" value="<%=strCommand%>"  style="width:87.5%;height:21px;" />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<div class='cellTitle_ez_right'><font id="from_tiem_ondemand" color="red"></font>작업시작시간</div>
											</td>
											<td>
												<div class='cellContent_kang'>

													<select id='sHour' name='sHour' style="width:24%;height:21px;">
														<option value="">--선택--</option>
														<c:forEach var="sHour" begin="0" end="23" step="1">
															<c:choose>
																<c:when test="${sHour < 10}">
																	<option value="0${sHour}">0${sHour}</option></c:when>
																<c:otherwise><option value="${sHour}">${sHour}</option></c:otherwise>
															</c:choose>
														</c:forEach>
													</select>
													<select id='sMin' name = 'sMin' style="width:24%;height:21px;">
														<option value="">--선택--</option>
														<c:forEach var="sMin" begin="0" end="59" step="1">
															<c:choose>
																<c:when test="${sMin < 10}">
																	<option value="0${sMin}">0${sMin}</option></c:when>
																<c:otherwise><option value="${sMin}">${sMin}</option></c:otherwise>
															</c:choose>
														</c:forEach>
													</select>

												</div>

												<input type="hidden" name="time_group" id="time_group" value="<%=vh_fromTime %>" />
												<input type="hidden" name="time_from" id="time_from" value="<%=fromTime %>" />

											</td>
											<td>
												<div class='cellTitle_ez_right'>작업종료시간</div>
											</td>
											<td>
												<div class='cellContent_kang'>

													<select id='eHour' name='eHour' style="width:24%;height:21px;">
														<option value="">--선택--</option>
														<c:forEach var="eHour" begin="0" end="23" step="1">
															<c:choose>
																<c:when test="${eHour < 10}">
																	<option value="0${eHour}">0${eHour}</option></c:when>
																<c:otherwise><option value="${eHour}">${eHour}</option></c:otherwise>
															</c:choose>
														</c:forEach>
													</select>
													<select id='eMin' name = 'eMin' style="width:24%;height:21px;">
														<option value="">--선택--</option>
														<c:forEach var="eMin" begin="0" end="59" step="1">
															<c:choose>
																<c:when test="${eMin < 10}">
																	<option value="0${eMin}">0${eMin}</option></c:when>
																<c:otherwise><option value="${eMin}">${eMin}</option></c:otherwise>
															</c:choose>
														</c:forEach>
													</select>
												</div>

												<input type="hidden" name="time_until" id="time_until" value="<%=timeUntil %>"/>
											</td>
											<td>
												<div class='cellTitle_ez_right'>과거 ODATE 시간 무시</div>
											</td>
											<td>
												<div class='cellContent_kang'>
													<span style='vertical-align:middle'><input type='checkbox' id='ignore_time_until' name='ignore_time_until' style='vertical-align:middle'/></span>
													<span style='vertical-align:middle'> > (체크시, 과거 ODATE의 작업은 시간 설정 무시하고 수행)</span>
												</div>
											</td>
											<!-- <td colspan="2">
												<div class='cellTitle_ez_right' style='text-align:left'>
													<input type='checkbox' id='ignore_time_until' name='ignore_time_until' style='vertical-align:middle'/>
													<span style='vertical-align:middle'> > (체크시, 과거 ODATE의 작업은 시간 설정 무시하고 수행)</span>
												</div>
											</td> -->
										</tr>

										<tr>
											<td>
												<div class='cellTitle_ez_right'>시작임계시간</div>
											</td>
											<td>

												<div class='cellContent_kang'>

													<select name='slate_sub_h' id='slate_sub_h' style="width:24%;height:21px;">
														<option value="">--선택--</option>
														<c:forEach var="slate_sub_h" begin="0" end="23" step="1">
															<c:choose>
																<c:when test="${slate_sub_h < 10}">
																	<option value="0${slate_sub_h}">0${slate_sub_h}</option></c:when>
																<c:otherwise><option value="${slate_sub_h}">${slate_sub_h}</option></c:otherwise>
															</c:choose>
														</c:forEach>
													</select>

													<select name='slate_sub_m' id='slate_sub_m' style="width:24%;height:21px;">
														<option value="">--선택--</option>
														<c:forEach var="slate_sub_m" begin="0" end="59" step="1">
															<c:choose>
																<c:when test="${slate_sub_m < 10}">
																	<option value="0${slate_sub_m}">0${slate_sub_m}</option></c:when>
																<c:otherwise><option value="${slate_sub_m}">${slate_sub_m}</option></c:otherwise>
															</c:choose>
														</c:forEach>
													</select>
													<input type="hidden" name="late_sub_h" id="late_sub_h" value= "<%=vh_lateSub %>" maxlength="2" style= "width:20%;height:21px;"/>
													<input type="hidden" name="late_sub_m" id="late_sub_m" value= "<%=vm_lateSub %>" maxlength="2" style= "width:20%;height:21px;"/>
													<input type="hidden" name="late_sub" id="late_sub" value= "<%=strLateSub %>" maxlength="2" style= "width:20%;height:21px;"/>
												</div>
											</td>
											<td>
												<div class='cellTitle_ez_right'>종료임계시간</div>
											</td>
											<td>

												<div class='cellContent_kang'>

													<select name='slate_time_h' id='slate_time_h' style="width:24%;height:21px;">
														<option value="">--선택--</option>
														<c:forEach var="slate_time_h" begin="0" end="23" step="1">
															<c:choose>
																<c:when test="${slate_time_h < 10}">
																	<option value="0${slate_time_h}">0${slate_time_h}</option></c:when>
																<c:otherwise><option value="${slate_time_h}">${slate_time_h}</option></c:otherwise>
															</c:choose>
														</c:forEach>
													</select>
													<select name='slate_time_m' id='slate_time_m' style="width:24%;height:21px;">
														<option value="">--선택--</option>
														<c:forEach var="slate_time_m" begin="0" end="59" step="1">
															<c:choose>
																<c:when test="${slate_time_m < 10}">
																	<option value="0${slate_time_m}">0${slate_time_m}</option></c:when>
																<c:otherwise><option value="${slate_time_m}">${slate_time_m}</option></c:otherwise>
															</c:choose>
														</c:forEach>
													</select>
													<input type="hidden" name="late_time_h" id="late_time_h" value= "<%=vh_lateTime %>"  maxlength="2" style= "width:20%;height:21px;"/>
													<input type="hidden" name="late_time_m" id="late_time_m" value= "<%=vm_lateTime %>"   maxlength="2" style= "width:20%;height:21px;"/>
													<input type="hidden" name="late_time" id="late_time" value= "<%=strLateTime %>"   maxlength="4" style= "width:20%;height:21px;"/>

												</div>
											</td>
											<td>
												<div class='cellTitle_ez_right'>수행임계시간</div>
											</td>
											<td>
												<div class='cellContent_kang'>
													<input type="text" name="late_exec" id="late_exec" value= "<%=strLateExec.replaceAll(">", "") %>"  maxlength="3" size="3" style="height:21px;" /> 분
												</div>
											</td>
										</tr>

										<tr>
											<td>
												<div class='cellTitle_ez_right'>반복작업</div>
											</td>
											<td colspan='3'>
												<div class='cellContent_kang'>

													<select id='cyclic' name='cyclic' style="width:5%;height:21px;" onChange='fn_cyclic_set(this.value);'>
														<%
															aTmp = CommonUtil.getMessage("JOB.CYCLIC").split(",");
															String[] arr_nm = {"N","Y"};

															for(int i=0;i<aTmp.length; i++){
																String[] aTmp1 = aTmp[i].split("[|]");
																String select = aTmp1[0].equals(docBean.getCyclic()) ? "selected" : "";
																String nm = arr_nm[i];
																out.println("<option value='"+aTmp1[0]+"' "+select+" >"+nm+"</option>");
															}
														%>
													</select>&nbsp;&nbsp;

													<span id='cyclic_ment'>
											<%
												if ( CommonUtil.getMessage("JOB.CYCLIC."+docBean.getCyclic()).equals("yes") ) {
													out.println(strCycleMent);
												}
											%>
											</span>
													<input type='button' name='btn_cyclic' value='반복옵션' onClick="fn_cyclic_popup();" class='btn_white_h24'>
												</div>
											</td>

											<td>
												<div class='cellTitle_ez_right'>최대 반복 횟수</div>
											</td>
											<td>
												<div class='cellContent_kang'>
													<input type='text' class='input' id='rerun_max' name='rerun_max' value="<%=CommonUtil.E2K(docBean.getRerun_max()) %>" size='2' maxlength='2' onkeypress='if(event.keyCode==32 || event.keyCode==39) event.returnValue = false;' style='height:21px;ime-mode:disabled;' <% if (CommonUtil.isNull(docBean.getCyclic()).equals("0")) { %> readOnly <%}%> />
												</div>
											</td>
										</tr>

										<tr>
											<td>
												<div class='cellTitle_ez_right'>Confirm Flag</div>
											</td>
											<td>
												<div class='cellContent_kang'>
													<select id='confirm_flag' name='confirm_flag' style="width:12%;height:21px;">
														<option value="0">N</option>
														<option value="1">Y</option>
													</select>
												</div>
											</td>
											<td>
												<div class='cellTitle_ez_right'>우선순위</div>
											</td>
											<td>
												<div class='cellContent_kang'>
													<input type="text" id="priority" name="priority" style="height:21px;" maxlength="2" size="2" onkeyup="this.value = this.value.toUpperCase();" value="<%= strPriority%>"/>
												</div>
											</td>
											<td>
												<div class='cellTitle_ez_right'>성공 시 알람 발송</div>
											</td>
											<td colspan="3">
												<div class='cellContent_kang'>
													<select id='success_sms_yn' name='success_sms_yn' style="width:12%;height:21px;">
														<option value="N">N</option>
														<option value="Y">Y</option>
													</select>
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<div class='cellTitle_ez_right'><!-- <font color="red">* </font> -->중요작업</div>
											</td>
											<td>
												<div class='cellContent_kang'>
													<select id="critical_yn" name="critical_yn" title="중요작업여부" style="width:width:98%;height:21px;">
														<option value="1">Y</option>
														<option value="0">N</option>
													</select>
													<input type="hidden" name="critical" id="critical" value= "<%=CommonUtil.isNull(docBean.getCritical())%>"  style= "width:98%;height:21px;"/>
												</div>
											</td>
										</tr>

									</table>
								</td>
							</tr>
						</table>
						
						<table style="width:100%;display:none;" id="mftTable">
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
												<input class='input' type='text' id='FTP_ACCOUNT'  name='FTP_ACCOUNT' style='width:50%' onClick='accountPopupList();' readonly/>
												&nbsp;&nbsp;<span onclick='accountPopupList();' style='padding:0px;margin:0px;cursor:pointer;'>[조회]</span>
												&nbsp;&nbsp;<span onclick='clearMft();' style='padding:0px;margin:0px;color:red;cursor:pointer;'>[삭제]</span>
											</td>
										</tr>
										<tr>
											<td>
												<div class='cellTitle_ez_right'>추가옵션</div>
											</td>
											<td style='text-align:center;'>
												<label for='FTP_USE_DEF_NUMRETRIES_YN' style='width:50%'>
												<input type='checkbox' name='FTP_USE_DEF_NUMRETRIES_YN' id='FTP_USE_DEF_NUMRETRIES_YN' onclick='ftp_use_def_numretries_check()'/> 
													Use default number of retries&nbsp;&nbsp;&nbsp;&nbsp;
												</label>
													Number of retries :
												<input class='input' type='text' id='FTP_NUM_RETRIES' name='FTP_NUM_RETRIES' value='5' style='background-color: #e2e2e2;' placeholder='(0~99 number)' />
											</td>
											<td style='text-align:center;'>
												<label for='FTP_RPF_YN'>
												<input type='checkbox'  name='FTP_RPF_YN' id='FTP_RPF_YN'/>
													Rerun from point of failure
												</label>
											</td>
											<td style='text-align:center;'>
												<label for='FTP_CONT_EXE_NOTOK_YN'>
													<input type='checkbox' name='FTP_CONT_EXE_NOTOK_YN' id='FTP_CONT_EXE_NOTOK_YN'/>
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
													<input type="text" name="con_pro" id="con_pro" value="<%=con_pro%>"  style="width:78%;height:21px;ime-mode:disabled;" readonly/>
													<input type='button' name='btn_con_pro' value='보기' onClick="fn_con_pro_popup();" class='btn_white_h24'>
												</div>
											</td>
											<td>
												<div class='cellTitle_ez_right'>Job Spec Type</div>
											</td>
											<td>
												<div class='cellContent_kang'>
												<!-- 추후 선택지 늘어나면 select 박스로 변경 필요 -->
		<!-- 													<select id='job_spec_type' name='job_spec_type' style="width:24%;height:21px;"> -->
		<!-- 														<option value="">--선택--</option> -->
		<!-- 														<option value="Get Logs">Get Logs</option> -->
		<!-- 														<option value="Do Not Get">Do Not Get</option> -->
		<!-- 													</select> -->
													<input type="text" name = "job_spec_type" id='job_spec_type' style="width:50%;height:21px;" value="Local file" readonly/>
												</div>
											</td>
											<td>
												<div class='cellTitle_ez_right'>Job Spec Yaml</div>
											</td>
											<td>	
												<div class='cellContent_kang'>
													<label for="file_name" style="height:21px;border:1px solid">&nbsp;&nbsp;파일선택&nbsp;</label>
													<input type="file" name="file_name" id="file_name" style="display:none;"/>
													<input type='text' name='yaml_file' id='yaml_file' style="width:190px; height:21px;" readonly value="<%=yaml_file%>"/>
													<% if(!yaml_file.equals("")){ %>
														<input type='button' value='다운로드' onClick='download("<%=doc_cd%>");'>
													<% } %>
													<input type='hidden' name='file_content' id="file_content" value="<%=file_content%>"/>
													<input type='hidden' name='cont_encode_yn' id="cont_encode_yn" value="Y"/>
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<div class='cellTitle_ez_right'>Job Spec Parameter</div>
											</td>
											<td colspan="3">
												<div class='cellContent_kang'>
													<input type="text" name="spec_param" id="spec_param" value="<%=spec_param%>" style="width:85%;height:21px;" />
												</div>
											</td>
											<td>
												<div class='cellTitle_ez_right'>OS Exit Code</div>
											</td>
											<td>	
												<div class='cellContent_kang'>
													<select id='os_exit_code' name='os_exit_code' style="width:50%;height:21px;">
														<option value="">--선택--</option>
														<option value="No print">No print</option>
														<option value="Print code of single pod">Print code of single pod</option>
													</select>
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<div class='cellTitle_ez_right'>Get Pod Logs</div>
											</td>
											<td>
												<div class='cellContent_kang'>
													<select id='get_pod_logs' name='get_pod_logs' style="width:50%;height:21px;">
														<option value="">--선택--</option>
														<option value="Get Logs">Get Logs</option>
														<option value="Do Not Get">Do Not Get</option>
													</select>
												</div>
											</td>
											<td>
												<div class='cellTitle_ez_right'>Job Cleanup</div>
											</td>
											<td>
												<div class='cellContent_kang'>
													<select id='job_cleanup' name='job_cleanup' style="width:50%;height:21px;">
														<option value="">--선택--</option>
														<option value="Delete Job">Delete Job</option>
														<option value="Keep">Keep</option>
													</select>
												</div>
											</td>
											<td>
												<div class='cellTitle_ez_right'>Polling Interval</div>
											</td>
											<td>
												<div class='cellContent_kang'>
													<input type="text" name="polling_interval" id="polling_interval"  value="<%=polling_interval%>" style="width:60%;height:21px;ime-mode:disabled;"/>
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
													<input type="text" name="db_con_pro" id="db_con_pro" value="<%=db_con_pro %>" style="width:85%;height:21px;ime-mode:disabled;" readonly/>
													<input type='button' name='btn_db_con_pro' value='보기' onClick="fn_db_con_pro_popup();" class='btn_white_h24'>
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
													<input type='text'   name='database' id='database' value="<%=!strDatabaseName.equals("") ? strDatabaseName : (!strSid.equals("") ? strSid : strServiceName) %>" style="width:85%;height:21px;ime-mode:disabled;" readonly/>
													<input type='hidden' name='db_user' id="db_user"  value="<%=databaseBean.getUser_nm()%>"/>
													<input type='hidden' name='db_host' id="db_host" value="<%=databaseBean.getHost_nm()%>"/>
													<input type='hidden' name='db_port' id="db_port" value="<%=databaseBean.getAccess_port()%>"/>
													<input type='hidden' name='sid' id="sid" value="<%=strSid%>"/>
													<input type='hidden' name='service_name' id="service_name" value="<%=strServiceName%>"/>
													
													<%} %>
													<!-- 
													<input type='hidden' name='target_agent' id="target_agent" />
													<input type='hidden' name='target_ctm' id="target_ctm" /> 
													<input type='hidden' name='db_password' id="db_password" value="rkdus1!"/>
													-->
													<input type='hidden' name='database_type' id="database_type" value="<%=database_type%>"/>
												</div>
											</td>
											<td>
												<div class='cellTitle_ez_right'>Execution Type</div>
											</td>
											<td>
												<div class='cellContent_kang'>
													<select id='execution_type' name='execution_type' style="width:30%;height:21px;">
														<option value="">--선택--</option>
														<option value="P">Stored Procedure</option>
														<option value="Q">Embedded Query</option>
													</select>
												</div>
											</td>
										</tr>
										<tr id="db_p_tr" style="display:none;">
											<td>
												<div class='cellTitle_ez_right'>Schema</div>
											</td>
											<td>
												<div class='cellContent_kang'>
													<input type="text" name="schema" id="schema" value="<%=schema %>" style="width:85%;height:21px;" readonly/>
													<input type='button' name='btn_schema' value='보기' onClick="fn_schema_popup();" class='btn_white_h24'>
												</div>
											</td>
											<td>
												<div class='cellTitle_ez_right'>Name</div>
											</td>
											<td>
												<div class='cellContent_kang'>
													<input type="text" name="sp_name" id="sp_name" value="<%=sp_name %>" style="width:85%;height:21px;" readonly/>
													<input type='button' name='btn_sp' value='보기' onClick="fn_sp_popup();" class='btn_white_h24'>													
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
												s += "<input type='hidden' name='idxHidParam' id='idxHidParam' value='"+tagIdx+"'/>";
												s += "</div>";
												s += "</td>";
												s += "<div id='div_param"+tagIdx+"'></div>";
												s += "<td width='10%' style='text-align:center;'><div class='cellContent_kang_center'>"+prmType+"</div></td>";
												s += "<td width='20%' style='text-align:center;'><div class='cellContent_kang_center'>"+prmDirection+"</div></td>";
												s += "<td width='10%' style='text-align:center;'></td>";
												s += "<td width='20%' style='text-align:center;'><div class='cellContent_kang_center'><input type='text' class='input' name='ret_variable"+tagIdx+"' id='ret_variable"+tagIdx+"' style='width:88%;height:21px;' maxlength='214' value='"+prmSetVar+"'/></div></td>";
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
												s += "<input type='hidden' name='idxHidParam' id='idxHidParam' value='"+tagIdx+"'/>";
												s += "</div>";
												s += "</td>";
												s += "<div id='div_param"+tagIdx+"'></div>";
												s += "<td width='10%' style='text-align:center;'><div class='cellContent_kang_center'>"+prmType+"</div></td>";
												s += "<td width='20%' style='text-align:center;'><div class='cellContent_kang_center'>"+prmDirection+"</div></td>";
												s += "<td width='10%' style='text-align:center;'><div class='cellContent_kang_center'><input type='text' class='input' name='in_value"+tagIdx+"' id='in_value"+tagIdx+"' style='width:88%;height:21px;' maxlength='214' value='"+prmValue+"'/></div></td>";
												s += "<td width='20%' style='text-align:center;'></td>";
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
													<textarea name="query" id="query" style="width:62%;height:150px;" cols="30" rows="5"><%=query %></textarea>
												</div>
											</td>
										</tr>
										
										<tr id="db_o_tr">
											<td>
												<div class='cellTitle_ez_right'>추가옵션</div>
											</td>
											<td style='text-align:center;'>
												<label for='DB_AUTOCOMMIT' style='width:50%'>
												<input type='checkbox' name='chk_db_autocommit' id='chk_db_autocommit' <%=db_autocommit.equals("Y") ? "checked" : "" %>/>
													Enable Auto Commit&nbsp;&nbsp;&nbsp;&nbsp;
												</label>
												<input type='hidden' name='db_autocommit' id="db_autocommit" />
											</td>
											<td style='text-align:center;' colspan="2">
												<label for='DB_APPEND_LOG'>
												<input type='checkbox' name='chk_db_append_log' id='chk_db_append_log' <%=append_log.equals("Y") ? "checked" : "" %>/>
													Append execution log to Job Output
												</label>
												<input type='hidden' name='append_log' id="append_log" />
											</td>
											<td style='text-align:center;' colspan="2">
												<label for='DB_APPEND_OUTPUT'><input type='checkbox' name='chk_db_append_output' id='chk_db_append_output' <%=append_output.equals("Y") ? "checked" : "" %>/>
													Append SQL output to Job Output 
												</label>
												<input type='hidden' name='append_output' id="append_output" />
												(Output format : <select id='sel_db_output_format' name='sel_db_output_format' style="width:100px;height:21px;" <%=append_output.equals("N") ? "disabled" : "" %>>
														<option value='T'>TEXT</option>
														<option value='X'>XML</option>
														<option value='C'>CSV</option>
														<option value='H'>HTML</option>
													</select>
													<input type="text" name=csv_seperator id="csv_seperator" value="<%=csv_seperator %>" style="height:21px; display:none; width:45px;" <%=append_output.equals("N") ? "disabled" : "" %>/>)
											</td>
									</table>
								</td>
							</tr>
						</table>

						<table style="width:100%">
							<tr>
								<td>
									<div class='cellTitle_kang5'>스케쥴 정보
										<input type='button' name='btn_CalDetail' value='미리보기' onClick="CalDetail();" class='btn_white_h24'>
										<!-- <span style='color:red;'>＊스케줄 설정: 정기 / 스케줄 미설정: 수시(일회성)</span> -->
									</div>
								</td>
							</tr>
							<tr>
								<td valign="top">
									<table style="width:100%;">
										<tr>
											<td width="11%"></td>
											<td width="22%"></td>
											<td width="11%"></td>
											<td width="11%"></td>
											<td width="11%"></td>
											<td width="22%"></td>
										</tr>
										<tbody id="t_general_date_yn">
										<tr>
											<td>
												<div class='cellTitle_ez_right'>
												<img src="/images/icon_lst23b.png" width="16" height="16" onClick="showHint(month_days_div,this);" style="cursor:pointer;vertical-align:text-top;" />
												실행날짜
												</div>
											</td>
											<td>
												<div class='cellContent_kang'>
													<input type="text" name="month_days" id="month_days" value="<%=strMonth_days%>" style="width:100px; height:21px;" />
												</div>
											</td>
											<td>
												<div class='cellTitle_ez_right'>조건</div>
											</td>
											<td>
												<div class='cellContent_kang'>
													<select id='schedule_and_or' name='schedule_and_or' style="width:100px;height:21px;">
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
												<div class='cellTitle_ez_right'>
												<img src="/images/icon_lst23b.png" width="17" height="17" onClick="showHint(week_days_div,this);" style="cursor:pointer;vertical-align:text-top;" />
												실행요일
												</div>
											</td>
											<td>
												<div class='cellContent_kang'>
													<input type="hidden" name="week_days" id="week_days" />
													<input type='checkbox' id='chk_week_days_0' value='0' <%= ((strTotalWeekDays.indexOf("'0'")>-1)?" checked ":"") %> /><span style='color:red;'>일</span>
													<input type='checkbox' id='chk_week_days_1' value='1' <%= ((strTotalWeekDays.indexOf("'1'")>-1)?" checked ":"") %> />월
													<input type='checkbox' id='chk_week_days_2' value='2' <%= ((strTotalWeekDays.indexOf("'2'")>-1)?" checked ":"") %> />화
													<input type='checkbox' id='chk_week_days_3' value='3' <%= ((strTotalWeekDays.indexOf("'3'")>-1)?" checked ":"") %> />수
													<input type='checkbox' id='chk_week_days_4' value='4' <%= ((strTotalWeekDays.indexOf("'4'")>-1)?" checked ":"") %> />목
													<input type='checkbox' id='chk_week_days_5' value='5' <%= ((strTotalWeekDays.indexOf("'5'")>-1)?" checked ":"") %> />금
													<input type='checkbox' id='chk_week_days_6' value='6' <%= ((strTotalWeekDays.indexOf("'6'")>-1)?" checked ":"") %> /><span style='color:blue;'>토</span>
													<input type='text' id='week_days_text' name='week_days_text' value='<%=strTempWeekDays2%>' style="width:100px;height:21px;" maxlength='30' onkeypress='if(event.keyCode==32 || event.keyCode==39) event.returnValue = false;' style='ime-mode:disabled;' />
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<div class='cellTitle_ez_right'>월 캘린더</div>
											</td>
											<td>
												<div class='cellContent_kang'>
													<select id='days_cal' name='days_cal' style="width:100px;height:21px;">
														<option value=''>--</option>
													</select>
													<a href="javascript:popupCalendarDetail(document.getElementById('days_cal').value);">[보기]</a>
												</div>
											</td>
											<td></td>
											<td></td>
											<td>
												<div class='cellTitle_ez_right'>일 캘린더</div>
											</td>
											<td>
												<div class='cellContent_kang'>
													<select id='weeks_cal' name='weeks_cal' style="width:100px;height:21px;">
														<option value=''>--</option>
													</select>
													<a href="javascript:popupCalendarDetail(document.getElementById('weeks_cal').value);">[보기]</a>
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<div class='cellTitle_ez_right'>CONF_CAL</div>
											</td>
											<td>
												<div class='cellContent_kang'>
													<select id='conf_cal' name='conf_cal' style="width:100px;height:21px;">
														<option value=''>--선택--</option>
													</select>
												</div>
											</td>
											<td>
												<div class='cellTitle_ez_right'>POLICY</div>
											</td>
											<td>
												<div class='cellContent_kang'>
													<select id='shift' name='shift' style="width:100px;height:21px;">
														<option value=''>--선택--</option>
														<%
															aTmp = CommonUtil.getMessage("JOB.CONF_CAL").split(",");
															for ( int i = 0; i < aTmp.length; i++ ) {
																String aTmp1 = aTmp[i];
														%>
																<option value='<%=aTmp1%>'><%=aTmp1%></option>
														<% 
															}
														%>
													</select>
												</div>
											</td>
											<td>
												<div class='cellTitle_ez_right'>SHIFT</div>
											</td>
											<td>
												<div class='cellContent_kang'>
													<select id='shift_num' name='shift_num' style="width:100px;height:21px;">
														<option value=''>--선택--</option>
														<%
															for ( int i = -10; i < 11; i++ ) {
														%>
																<option value='<%=i%>'><%=i%></option>
														<% 
															}
														%>
													</select>
												</div>
											</td>
										</tr>
										<tr>
											<td ><div class='cellTitle_ez_right'>1월~6월</div></td>
											<td>
												<div class='cellContent_kang' style="display:flex;justify-content:space-between;width:83%;">
													<%
														for ( int i = 0; i < 6; i++ ) {
															out.println("<select id='month_"+(i+1)+"' name='month_"+(i+1)+"' style='width:15%;height:21px;'>");
															aTmp = CommonUtil.getMessage("JOB.CAL_OPT").split(",");
															for(int j=0;j<aTmp.length; j++){
																String[] aTmp1 = aTmp[j].split("[|]");
																out.println("<option value='"+aTmp1[0]+"' "+( (aTmp1[0].equals(docBean.getMonth(i+1)))? " selected ":"" )+" >"+aTmp1[1]+"</option>");
															}
															out.println("</select>");
														}
													%>
												</div>
											</td>
											<td>
												<div class='cellTitle_ez_right'>수행 범위일</div>
											</td>
											<td colspan='5' >
												<input type="text" name="active_from" id="active_from" value="<%=strActiveFrom %>" class="input datepick" style="width:75px; height:21px;" maxlength="8" autocomplete="off" /> ~
												<input type="text" name="active_till" id="active_till" value="<%=strActiveTill %>" class="input datepick" style="width:75px; height:21px;" maxlength="8" autocomplete="off" />
											</td>
										</tr>
										<tr>
											<td ><div class='cellTitle_ez_right'>7월~12월</div></td>
											<td>
												<div class='cellContent_kang' style="display:flex;justify-content:space-between;width:83%;">
													<%
														for ( int i = 6; i < 12; i++ ) {
															out.println("<select id='month_"+(i+1)+"' name='month_"+(i+1)+"' style='width:15%;height:21px;'>");
															aTmp = CommonUtil.getMessage("JOB.CAL_OPT").split(",");
															for(int j=0;j<aTmp.length; j++){
																String[] aTmp1 = aTmp[j].split("[|]");
																out.println("<option value='"+aTmp1[0]+"' "+( (aTmp1[0].equals(docBean.getMonth(i+1)))? " selected ":"" )+" >"+aTmp1[1]+"</option>");
															}
															out.println("</select>");
														}
													%>
												</div>
											</td>
										</tr>
										</tbody>
										<tr>
											<td ><div class='cellTitle_ez_right'>특정실행날짜</div></td>
											<td>
												<div class='cellContent_kang'>
													<input type="text" name="t_general_date" id="t_general_date" class="input datepick" value="<%=t_general_date%>" style="width:83%; height:21px;" autocomplete="off" onblur="fn_change(this.id);"/>
												</div>
											</td>
											<td><img name="btn_del_date" id="btn_del_date" src="/images/sta2.png" onClick="fn_clear(this.id);" style="width:16px;height:16px;vertical-align:middle;cursor:pointer;"/></td>
										</tr>
									</table>

									<table style="width:100%">
										<tr>
											<td style="width:50%;">
												<table style="width:100%;">
													<tr>
														<td style="width:76%;height:21px;">
															<div class='cellTitle_kang5'>
																<img src="/images/icon_lst23b.png" width="20" height="20" onClick="showHint(inc_div,this);" style="cursor:pointer;vertical-align:text-top;" />
																선행작업조건
																<input type='button' name='btn_addConditionsIn' value=' + ' onClick="popJobsForm(1);" class='btn_white_h24'>
																<!-- <input type='button' name='btn_addConditionsIn' value=' + ' onClick="addConditions('in', '');" class='btn_white_h24'> -->
																<input type='button' name='btn_delConditionsIn' value=' - ' onClick="delConditionsIn();" class='btn_white_h24'>
															</div>
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
															<div class='cellTitle_kang5'>
																<font color="red">* </font>
																<img src="/images/icon_lst23b.png" width="20" height="20" onClick="showHint(oc_div,this);" style="cursor:pointer;vertical-align:text-top;" />
																후행작업조건 (자기작업 CONDITION)
																<input type='button' name='btn_addConditionsOut' value=' + ' onClick="addConditionsOut();" class='btn_white_h24'>
																<!-- <input type='button' name='btn_addConditionsOut' value=' + ' onClick="addConditions('out', '');" class='btn_white_h24'> -->
																<input type='button' name='btn_delConditionsOut' value=' - ' onClick="delConditionsOut();" class='btn_white_h24'>
															</div>
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
																<input class='input' type='text' id='user_nm_1_0' value= "<%=strUserNm1 %>" style='width:80%;height:21px;' readOnly />
																<input class='input' type='hidden' id='author' name='author' value='<%=S_USER_ID %>'/>
															</div>
														</td>
														<td>
															<div class='cellContent_kang'>
																<%=strSms%><input type='checkbox' name='sms_1_0' id='sms_1_0' value='Y' />
																<%=strMail%><input type='checkbox' name='mail_1_0' id='mail_1_0' value='Y'/>
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
																<input class='input' type='text' id='user_nm_2_0' value= "<%=strUserNm2 %>" style='width:80%;height:21px;' readOnly />
																<img name="btn_del2" src="/images/sta2.png" style="width:16px;height:16px;vertical-align:middle;cursor:pointer;"/>
															</div>
														</td>
														<td>
															<div class='cellContent_kang'>
																<%=strSms%><input type='checkbox' name='sms_2_0' id='sms_2_0' value='Y' />
																<%=strMail%><input type='checkbox' name='mail_2_0' id='mail_2_0' value='Y'/>
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
																<input class='input' type='text' id='user_nm_3_0' value= "<%=strUserNm3 %>" style='width:80%;height:21px;' readOnly />
																<img name="btn_del3" src="/images/sta2.png" style="width:16px;height:16px;vertical-align:middle;cursor:pointer;"/>
															</div>
														</td>
														<td>
															<div class='cellContent_kang'>
																<%=strSms%><input type='checkbox' name='sms_3_0' id='sms_3_0' value='Y' />
																<%=strMail%><input type='checkbox' name='mail_3_0' id='mail_3_0' value='Y'/>
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
																<input class='input' type='text' id='user_nm_4_0' value= "<%=strUserNm4 %>" style='width:80%;height:21px;' readOnly />
																<img name="btn_del4" src="/images/sta2.png" style="width:16px;height:16px;vertical-align:middle;cursor:pointer;"/>
															</div>
														</td>
														<td>
															<div class='cellContent_kang'>
																<%=strSms%><input type='checkbox' name='sms_4_0' id='sms_4_0' value='Y' />
																<%=strMail%><input type='checkbox' name='mail_4_0' id='mail_4_0' value='Y'/>
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
																<input class='input' type='text' id='user_nm_5_0' value="<%=strUserNm5 %>" style='width:80%;height:21px;' readOnly />
																<img name="btn_del5" src="/images/sta2.png" style="width:16px;height:16px;vertical-align:middle;cursor:pointer;"/>
															</div>
														</td>
														<td>
															<div class='cellContent_kang'>
																<%=strSms%><input type='checkbox' name='sms_5_0' id='sms_5_0' value='Y' />
																<%=strMail%><input type='checkbox' name='mail_5_0' id='mail_5_0' value='Y'/>
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
																<input class='input' type='text' id='user_nm_6_0' value="<%=strUserNm6 %>" style='width:80%;height:21px;' readOnly />
																<img name="btn_del6" src="/images/sta2.png" style="width:16px;height:16px;vertical-align:middle;cursor:pointer;"/>
															</div>
														</td>
														<td>
															<div class='cellContent_kang'>
																<%=strSms%><input type='checkbox' name='sms_6_0' id='sms_6_0' value='Y' />
																<%=strMail%><input type='checkbox' name='mail_6_0' id='mail_6_0' value='Y'/>
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
													<input class='input' type='text' id='user_nm_7_0' value= "<%=strUserNm7 %>" style='width:80%;height:21px;' readOnly />
																<img name="btn_del7" src="/images/sta2.png" style="width:16px;height:16px;vertical-align:middle;cursor:pointer;"/>
															</div>
														</td>
														<td>
															<div class='cellContent_kang'>
																<%=strSms%><input type='checkbox' name='sms_7_0' id='sms_7_0' value='Y' />
																<%=strMail%><input type='checkbox' name='mail_7_0' id='mail_7_0' value='Y'/>
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
													<input class='input' type='text' id='user_nm_8_0' value= "<%=strUserNm8 %>" style='width:80%;height:21px;' readOnly />
																<img name="btn_del8" src="/images/sta2.png" style="width:16px;height:16px;vertical-align:middle;cursor:pointer;"/>
															</div>
														</td>
														<td>
															<div class='cellContent_kang'>
																<%=strSms%><input type='checkbox' name='sms_8_0' id='sms_8_0' value='Y' />
																<%=strMail%><input type='checkbox' name='mail_8_0' id='mail_8_0' value='Y' />
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
											<input class='input' type='text' id='user_nm_9_0' value= "<%=strUserNm9 %>" style='width:80%;height:21px;' readOnly />
											<img name="btn_del9" src="/images/sta2.png" style="width:16px;height:16px;vertical-align:middle;cursor:pointer;"/>
										</div>
									</td>
									<td>
										<div class='cellContent_kang'>
											<%=strSms%><input type='checkbox' name='sms_9_0' id='sms_9_0' value='Y' />
											<%=strMail%><input type='checkbox' name='mail_9_0' id='mail_9_0' value='Y' />
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
											<input class='input' type='text' id='user_nm_10_0' value= "<%=strUserNm10 %>" style='width:80%;height:21px;' readOnly />
											<img name="btn_del10" src="/images/sta2.png" style="width:16px;height:16px;vertical-align:middle;cursor:pointer;"/>
										</div>
									</td>
									<td>
										<div class='cellContent_kang'>
											<%=strSms%><input type='checkbox' name='sms_10_0' id='sms_10_0' value='Y' />
											<%=strMail%><input type='checkbox' name='mail_10_0' id='mail_10_0' value='Y' />
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
											<input class='input' placeholder='' type='text' id='grp_nm_1_0' value='<%=strGrpNm1%>' style='width:80%;height:21px;' readOnly/>
											<img name="btn_grp_del1" src="/images/sta2.png" style="width:16px;height:16px;vertical-align:middle;cursor:pointer;"/>
										</div>
									</td>
									<td>
										<div class='cellContent_kang'>
											<%=strSms%><input type='checkbox' name='grp_sms_1_0' id='grp_sms_1_0' value='Y' />
											<%=strMail%><input type='checkbox' name='grp_mail_1_0' id='grp_mail_1_0' value='Y' />
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
													<input class='input' placeholder='' type='text' id='grp_nm_2_0' value='<%=strGrpNm2%>' style='width:80%;height:21px;' readOnly/>
													<img name="btn_grp_del2" src="/images/sta2.png" style="width:16px;height:16px;vertical-align:middle;cursor:pointer;"/>
									</div>
								</td>
								<td>
									<div class='cellContent_kang'>
													<%=strSms%><input type='checkbox' name='grp_sms_2_0' id='grp_sms_2_0' value='Y'  />
													<%=strMail%><input type='checkbox' name='grp_mail_2_0' id='grp_mail_2_0' value='Y'  />
															</div>
														</td>
														<td>
															<div class='cellContent_kang'>
																<!-- <input type='button' name='btn_del8' value='삭제' class='btn_white_h24'> -->
															</div>
														</td>
													</tr>
												</table>

												<table style="width:100%;">
													<tr>
														<td colspan="6">
															<table style="width:100%;">
																<tr>
																	<td colspan="5">
																	<div class='cellTitle_kang5'>
																			<img src="/images/icon_lst23b.png" width="20" height="20" onClick="showHint(resource_div,this);" style="cursor:pointer;vertical-align:text-top;" />
																			RESOURCE
																			<input type='button' name='btn_addResourcesQ' value=' + ' onClick='addResourcesQ();' class='btn_white_h24'>
																			<input type='button' name='btn_delResourcesQ' value=' - ' onClick='delResourcesQ();' class='btn_white_h24'>
																		</div>
																	</td>
																</tr>
															</table>
														</td>
													</tr>
													<tr>
														<td style="width:5%;height:21px;">
														<div class='cellTitle_ez_center'><input type='checkbox' name="checkIdxAllResQ" id="checkIdxAllResQ" onClick="checkAll3();"/></div>
														</td>
													<td style='width:8%;'><div class='cellTitle_ez_center'>Name</div></td>
													<td style='width:86%;'><div class='cellTitle_ez_left'>Required Usage</div></td>
													</tr>
												</table>

												<table style="width:100%;height:100%;border:none;" id="resQTable">
													<%
														if( null!=docBean.getT_resources_q() && docBean.getT_resources_q().trim().length()>0 ){
															aTmpT = CommonUtil.E2K(docBean.getT_resources_q()).split("[|]");
	
															//코드관리 -> 리소스기본값(M81)에 등록된 항목 수정불가처리.
															boolean chk;
																for(int t=0; null!=aTmpT&&t<aTmpT.length; t++ ){
															chk = false;
															String[] aTmpT1 = aTmpT[t].split(",",2);
															String resVal = aTmpT[t].substring(0, aTmpT[t].indexOf(","));
															if( strResourceDefaultNameList != null ) {
																strResourceDefaultNameList = strResourceDefaultNameList.substring(0, strResourceDefaultNameList.length());
																String[] arrResourceDefaultNameList = strResourceDefaultNameList.split(",");
	
																for(int j=0; j<arrResourceDefaultNameList.length; j++ ){
																	if(arrResourceDefaultNameList[j].equals(resVal)){
																		chk = true;
																	}
																}
															}
													%>
													<tr>
														<td style='width:5%;height:21px;text-align:center;'>
														<%if(chk) { %>
															<input type='checkbox' name='idx_check_resq' disabled>
														</td>
<!-- 														<td style='width:1px;height:21px;'><div class='cellTitle_kang2'></div></td> -->
														<td style='width:8%;'>
															<input type='text' class='input' name='m_quantitative_res_name' value='<%=aTmpT1[0] %>' style='width:98%;height:21px;' maxlength='40' readonly/>
														</td>
														<td style='width:86%;'>
															<input type='text' class='input' name='m_quantitative_required_usage' value='<%=aTmpT1[1] %>' style='width:88%;height:21px;' maxlength='214' readonly/>
														</td>
														</tr>
														<%} else { %>
															<input type='checkbox' name='idx_check_resq'>
														</td>
<!-- 														<td style='width:1px;height:21px;'><div class='cellTitle_kang2'></div></td> -->
														<td style='width:8%;'>
															<input type='text' class='input' name='m_quantitative_res_name' value='<%=aTmpT1[0] %>' style='width:98%;height:21px;' maxlength='40' />
														</td>
														<td style='width:86%;'>
															<input type='text' class='input' name='m_quantitative_required_usage' value='<%=aTmpT1[1] %>' style='width:88%;height:21px;' maxlength='214'/>
														</td>
														<%}%>
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
																	<td colspan="5">
																	<div class='cellTitle_kang5'>
																			<img src="/images/icon_lst23b.png" width="20" height="20" onClick="showHint(var_div,this);" style="cursor:pointer;vertical-align:text-top;" />
																			변수
																			<input type='button' name='btn_addUserVar' value=' + ' onClick='addUserVars();' class='btn_white_h24'>
																			<input type='button' name='btn_delUserVar' value=' - ' onClick='delUserVars();' class='btn_white_h24'>
																		</div>
																	</td>
																</tr>
															</table>
														</td>
													</tr>
													<tr>
														<td style="width:5%;height:21px;">
														<div class='cellTitle_ez_center'><input type='checkbox' name="idxCheckAll" id="idxCheckAll" onClick="checkAll2();"/></div>
														</td>
													<td style='width:8%;'><div class='cellTitle_ez_center'>변수 이름</div></td>
													<td style='width:86%;'><div class='cellTitle_ez_left'>변수 값</div></td>
													</tr>
												</table>

												<table style="width:100%;height:100%;border:none;" id="userVar">
												<%
													if( null!=docBean.getT_set() && docBean.getT_set().trim().length()>0 ){
														aTmpT = CommonUtil.E2K(docBean.getT_set()).split("[|]");
	
														//코드관리 -> 변수 기본값(m82)에 등록된 항목 수정불가처리.
														boolean chk;
														for(int t=0; null!=aTmpT&&t<aTmpT.length; t++ ){
															chk = false;
															String[] aTmpT1 = aTmpT[t].split(",",2);
															String varVal 	= aTmpT[t].substring(0, aTmpT[t].indexOf(","));
															if( strVariableDefaultNameList != null ) {
																strVariableDefaultNameList = strVariableDefaultNameList.substring(0, strVariableDefaultNameList.length());
																String[] arrVariableDefaultNameList = strVariableDefaultNameList.split(",");
		
																for(int j=0; j<arrVariableDefaultNameList.length; j++ ){
																	if(arrVariableDefaultNameList[j].equals(varVal)){
																		chk = true;
																	}
																}
															}
												%>
													<tr>
														<td style='width:5%;height:21px;text-align:center;'>
														<%if(chk) { %>
														<input type='checkbox' name='idx_check' disabled/>
														<input type='hidden' name='idxHid' id='idxHid' value='<%=t%>'/>
															</td>
															<td style='display:none;width:1px;height:21px;'><div class='cellTitle_kang2' id='div_user_val<%=t %>'></div></td>
															<td style='width:8%;'><input type='text' class='input' name='m_var_name' value='<%=aTmpT1[0] %>' style='width:98%;height:21px;' maxlength='40' readonly/></td>
															<td style='width:86%;'>
																<input type='text' class='input' name='m_var_value' value='<%=CommonUtil.replaceHtmlStr(aTmpT1[1]) %>' style='width:88%;height:21px;' maxlength='214' readonly/>
															</td>
														</tr>
														<%} else { 
																if(!(strTaskType.equals("MFT") || aTmpT1[0].startsWith("FTP"))){
																	if(!(strTaskType.equals("Database") || aTmpT1[0].startsWith("DB"))){
														%>
															<input type='checkbox' name='idx_check'>
															<input type='hidden' name='idxHid' id='idxHid' value='<%=t %>'/>
														</td>
															<td style='display:none;width:1px;height:21px;'><div class='cellTitle_kang2' id='div_user_val<%=t %>'></div></td>
															<td style='width:8%;'><input type='text' class='input' name='m_var_name' value='<%=aTmpT1[0] %>' style='width:98%;height:21px;' maxlength='40'/></td>
															<td style='width:86%;'>
																<input type='text' class='input' name='m_var_value' value='<%=CommonUtil.replaceHtmlStr(aTmpT1[1]) %>' style='width:88%;height:21px;' maxlength='214'/>
														</td>
														<% 
																	}
																}
															} 
														
														%>
													</tr>
													<%
															}
														}
													%>
												</table>

												<table style="width:100%;">
													<tr>
														<td colspan = "4">
														<div class='cellTitle_kang5'>
																<img src="/images/icon_lst23b.png" width="20" height="20" onClick="showHint(ondo_div,this);" style="cursor:pointer;vertical-align:text-top;" />
																ON/DO
																<input type='button' name='btn_addStep' value=' + ' onClick='addSteps();' class='btn_white_h24'>
																<input type='button' name='btn_delStep' value=' - ' onClick='delSteps();' class='btn_white_h24'>
															</div>
														</td>
													</tr>
												</table>
												<table style="width:100%;">
													<tr>
													<td style="width:4%;height:21px;">
														<div class='cellTitle_ez_center'><input type='checkbox' name="checkIdxAll" id="checkIdxAll" onClick="checkAll();"/></div>
														</td>
													<td style="width:6%;height:21px;">
														<div class='cellTitle_ez_center'>ON/DO</div>
														</td>
													<td style="width:6%;height:21px;">
														<div class='cellTitle_ez_center'>TYPE</div>
														</td>
													<td style="width:60%;height:21px;">
														<div class='cellTitle_ez_center'>PARAMETERS</div>
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
															out.println("<td style='width:4%;height:21px;text-align:center;'>");
																out.println("<input type='checkbox' name='check_idx'>");
																out.println("</td>");
															out.println("<td style='width:6%;height:21px;text-align:center;'>");
															out.println("<select name='m_step_opt' onchange='setStepType(this.value,getObjIdx(this,this.name));' style='width:95%;height:21px;'>");
																out.println("<option value=''>--</option>");
																aTmp = CommonUtil.getMessage("JOB.STEP_OPT").split(",");
																for(int i=0;i<aTmp.length; i++){
																	String[] aTmp1 = aTmp[i].split("[|]");

																	out.println("<option value='"+aTmp1[0]+"' "+( (aTmp1[0].equals(aTmpT1[0]))? " selected ":"" )+" >"+aTmp1[1]+"</option>");
																}
																out.println("</select>");
																out.println("</td>");
															out.println("<td style='width:6%;height:21px;text-align:center;'>");
																out.println("<div id='div_step_type"+t+"'>");
																String aTmpT2[] = aTmpT[t].split(",");
																if( "O".equals(aTmpT1[0]) ){
																out.println("<select name='m_step_type' onchange='setStepOnParameters(this.value,"+t+");' style='width:95%;height:21px;'>");
																	out.println("<option value=''>--선택--</option>");
																	aTmp = CommonUtil.getMessage("TABLE.STEP_ON_TYPE").split(",");
																	String aTmpt3[] = aTmpT2[3].split(" ");
														if(aTmpT1[3].split(" ").length > 1){
																	for(int i=0;i<aTmp.length; i++){
																		String[] aTmp1 = aTmp[i].split("[|]");
																		out.println("<option value='"+aTmp1[1]+"' "+( (aTmp1[1].equals(aTmpt3[0]))? " selected ":"" )+" >"+aTmp1[0]+"</option>");
																	}
														}else if(aTmpT1[3].equals("OK") || aTmpT1[3].equals("NOTOK")){
															for(int i=0;i<aTmp.length; i++){
																String[] aTmp1 = aTmp[i].split("[|]");
																out.println("<option value='"+aTmp1[1]+"' "+( (aTmp1[1].equals(aTmpT2[3]))? " selected ":"" )+" >"+aTmp1[0]+"</option>");
															}	
														}else{
															for(int i=0;i<aTmp.length; i++){
																String[] aTmp1 = aTmp[i].split("[|]");
																out.println("<option value='"+aTmp1[1]+"' "+( (aTmp1[1].equals(aTmpT1[1]))? " selected ":"" )+" >"+aTmp1[0]+"</option>");
															}
														}
																	out.println("</select>");
																}else if( "A".equals(aTmpT1[0]) ){
																out.println("<select name='m_step_type' onchange='setStepParameters(this.value,"+t+");' style='width:95%;height:21px;'>");
																	out.println("<option value=''>--선택--</option>");
																	aTmp = CommonUtil.getMessage("TABLE.STEP_DO_TYPE").split(",");
																	for(int i=0;i<aTmp.length; i++){
															if(aTmpT2[1].equals("SPCYC")){
																aTmp = CommonUtil.getMessage("TABLE.STEP_DO_TYPE").split(",");
																String[] aTmp1 = aTmp[i].split("[|]");
																out.println("<option value='"+aTmp1[1]+"' "+( (aTmp1[1].equals("Stop Cyclic"))? " selected ":"" )+" >"+aTmp1[0]+"</option>");
															}else{
																		String[] aTmp1 = aTmp[i].split("[|]");
																		out.println("<option value='"+aTmp1[1]+"' "+( (aTmp1[1].equals(aTmpT1[1]))? " selected ":"" )+" >"+aTmp1[0]+"</option>");
																	}
														}
																	out.println("</select>");
																}
																out.println("");

																out.println("</div></td>");
															out.println("<td style='width:60%;height:21px;text-align:left;'>");
																out.println("<div id='div_step_parameters"+t+"'>&nbsp;");
																if(aTmpT2[0].equals("O")){
																	String aTmpt4[] = aTmpT2[3].split(" ");
																	if(aTmpt4[0].equals("FAILCOUNT")){
																		String aTmpt3[] = aTmpT2[3].split(" ");
																		out.println(" Code=<input class='input' type='text' name='m_step_statement_code"+t+"' id='m_step_statement_code"+t+"' maxlength='132' value='"+aTmpt3[2]+"'/>");
																	}else{
																		if(aTmpt4[0].equals("OK") || aTmpt4[0].equals("NOTOK") || aTmpt4[0].equals("COMPSTAT") || aTmpt4[0].equals("RUNCOUNT")){
																			aTmp = CommonUtil.getMessage("TABLE.STEP_ON_PARAMETERS").split(",");
																			String aTmpt3[] = aTmpT2[3].split(" ");
																			System.out.println("aTmpt3 : " + aTmpt3.length);
																			if(aTmpt3.length > 1){
																				out.println("Stmt=<select name='m_step_statement_stmt"+t+"' id='m_step_statement_stmt"+t+"' onchange='setStepOnStmt(this.value,"+t+");' style='width:95px;'> ");
	
																				out.println("<option value=''>--선택--</option>");
	
																				if(aTmpt3[2].equals("EVEN") || aTmpt3[2].equals("ODD")){
																					for(int i=0;i<aTmp.length; i++){
																						String[] aTmp1 = aTmp[i].split("[|]");
																						out.println("<option value='"+aTmp1[1]+"' "+( (aTmp1[1].equals(aTmpt3[2]))? " selected ":"" )+" >"+aTmp1[0]+"</option>");
																					}
	
																					out.println("</select>");
																				}else{
																					for(int i=0;i<aTmp.length; i++){
																						String[] aTmp1 = aTmp[i].split("[|]");
																						out.println("<option value='"+aTmp1[1]+"' "+( (aTmp1[1].equals(aTmpt3[1]))? " selected ":"" )+" >"+aTmp1[0]+"</option>");
																					}
																					out.println("</select>");
																					out.println(" Code=<input class='input' type='text' name='m_step_statement_code"+t+"' id='m_step_statement_code"+t+"' maxlength='132' value='"+aTmpt3[2]+"'/>");
																				}
																			}
																		}else{
																			out.println(" Stmt=<input class='input' type='text' name='m_step_statement_stmt"+t+"' id='m_step_statement_stmt"+t+"' maxlength='132' value='"+aTmpT2[2]+"'/>");
																			out.println(" Code=<input class='input' type='text' name='m_step_statement_code"+t+"' id='m_step_statement_code"+t+"' maxlength='132' value='"+aTmpT2[3]+"'/>");
																		}
																	}
																}else if(aTmpT2[0].equals("A")){

																	if(aTmpT2.length > 2){
																		if(aTmpT2[1].equals("Condition")){
																			out.println("Name=<input class='input' type='text' name='m_step_condition_name"+t+"' id='m_step_condition_name"+t+"' maxlength='255' value='"+aTmpT2[2]+"'/>");
																			out.println("Date=<input class='input datepick ime_readonly' type='text' name='m_step_condition_date"+t+"' id='m_step_condition_date"+t+"' maxlength='4' size='4' value='"+aTmpT2[3]+"' onclick=\"dpCalMinMax(this.id,'mmdd')\"  onDblClick=\"this.value='ODAT';\" />");
																			out.println("Sign=<select name='m_step_condition_sign"+t+"' id='m_step_condition_sign"+t+"' style='width:55px;'>");
																			aTmp = CommonUtil.getMessage("JOB.STEP_SIGN").split(",");
																			for(int i=0;i<aTmp.length; i++){
																				String[] aTmp1 = aTmp[i].split("[|]");
																				out.println("<option value='"+aTmp1[0]+"' "+( (aTmp1[0].equals(aTmpT2[4]))? " selected ":"" )+" >"+aTmp1[1]+"</option>");
																			}
																			out.println("</select>");

																		}else if( aTmpT2[1].equals("Shout") ){
																			out.println("Dest=<input class='input' type='text' name='m_step_dest"+t+"' id='m_step_dest"+t+"' value='"+aTmpT2[2]+"'/>");
																			out.println("Message=<input class='input' type='text' name='m_step_message"+t+"' id='m_step_message"+t+"' style='width:400px;'  value='"+aTmpT2[4]+"'/>");
																		}else if( "Mail".equals(aTmpT2[1]) ){
																			aTmpT1 = aTmpT[t].split(",",7);

																			out.println(" To=<input class='input' type='text' name='m_step_mail_to"+t+"' id='m_step_mail_to"+t+"' value='"+aTmpT1[2]+"' size='13' />");
																			out.println(" Cc=<input class='input' type='text' name='m_step_mail_cc"+t+"' id='m_step_mail_cc"+t+"' value='"+aTmpT1[3]+"' size='13' />");
																			out.println(" Subject=<input class='input' type='text' name='m_step_mail_subject"+t+"' id='m_step_mail_subject"+t+"' value='"+aTmpT1[4]+"' />");
																			out.println(" Urgn=<select name='m_step_mail_urgn"+t+"' id='m_step_mail_urgn"+t+"' >");
																			aTmp = CommonUtil.getMessage("JOB.STEP_URGENCY").split(",");
																			for(int i=0;i<aTmp.length; i++){
																				String[] aTmp1 = aTmp[i].split("[|]");
																				out.println("<option value='"+aTmp1[0]+"' "+( (aTmp1[0].equals(aTmpT1[5]))? " selected ":"" )+" >"+aTmp1[1]+"</option>");
																			}
																			out.println("</select>");
																			out.println(" Msg=<textarea name='m_step_mail_msg"+t+"' id='m_step_mail_msg"+t+"' style='vertical-align:middle;width:300;height:21;'>"+aTmpT1[6]+"</textarea>");

																			//////////////////////
																			out.println(mStepHid.get("statement"));
																			out.println(mStepHid.get("set-var"));
																			out.println(mStepHid.get("shout"));
																			out.println(mStepHid.get("force-job"));
																			out.println(mStepHid.get("sysout"));
																			out.println(mStepHid.get("condition"));
																			//out.println(mStepHid.get("mail"));

																		}else if(aTmpT2[1].equals("Force-Job")){
																			 out.println("폴더=<input class='input' type='text' value='"+aTmpT2[2]+"' name='m_step_force-job_table"+t+"' id='m_step_force-job_table"+t+"' />");
																			 out.println("작업명=<input class='input' type='text' value='"+aTmpT2[3]+"' name='m_step_force-job_job_name"+t+"' id='m_step_force-job_job_name"+t+"' />");
																			 out.println("ORDER DATE=ODAT:<input type='checkbox' "+ (aTmpT2[4].equals("ODAT") ? "checked" : "") +" id='m_step_force-job_date_chk"+t+"' name='m_step_force-job_date_chk"+t+"' onClick='chkForceOdate(this, "+t+")'/> <input class='input datepick' type='text' value='"+aTmpT2[4]+"' name='m_step_force-job_date"+t+"' id='m_step_force-job_date"+t+"' onClick=\"this.value='';$('#m_step_force-job_date_chk"+t+"').prop('checked', false);dpCalMin(this.id,'ymmdd');\" maxlength='6' size='6' />");
																			 
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
						<div align='right' class='btn_area'>
							<span id='btn_compare' style="display:none;">버전비교</span>
							<span id='btn_udt' style="display:none;">수정</span>
							<span id='btn_del' style="display:none;">삭제</span>
							<span id='btn_draft' style="display:none;">승인요청</span>
<!-- 							<span id='btn_post_draft_u' style="display:none;">후결승인요청</span> -->
							<span id='btn_draft_admin' style="display:none;">관리자 즉시결재</span>
							<!-- <span id='btn_list' style="display:none;">목록</span> -->
							<span id='btn_close' style="display:none;">닫기</span>
						</div>
					</h4>
				</td>
			</tr>

			<!--
	<tr>
		<td>
			<%
					for( int i=0; null!=approvalInfoList && i<approvalInfoList.size(); i++ ) {
						ApprovalInfoBean bean = (ApprovalInfoBean)approvalInfoList.get(i);

						String strUserCd		= CommonUtil.isNull(bean.getUser_cd());
						String strUdtUserCd		= CommonUtil.isNull(bean.getUdt_user_cd());

						String strAbsenceUserCd	= CommonUtil.isNull(bean.getAbsence_user_cd());
						String strAbsenceUserNm	= CommonUtil.isNull(bean.getAbsence_user_nm());
						String strAbsenceDeptNm	= CommonUtil.isNull(bean.getAbsence_dept_nm());
						String strAbsenceDutyNm	= CommonUtil.isNull(bean.getAbsence_duty_nm());

						String strSeq	= CommonUtil.isNull(bean.getSeq());

						String strAbsenceInfo	= "";

						%>
							<input type="hidden" name="seq" id="seq" value="<%= strSeq%>"/>
						<%
						if( (S_USER_CD.equals(bean.getUser_cd()) || S_USER_CD.equals(strAbsenceUserCd)) && !"02".equals(bean.getApproval_cd()) && !"04".equals(bean.getApproval_cd()) && bean.getSeq().equals(bean.getCur_approval_seq()) ){
							if( "01".equals(bean.getApproval_cd()) ){
								%>
									<span id='btn_approval'>결재</span>
									<span id='btn_wait'>보류</span>
									<span id='btn_reject'>반려</span>
									<span id='btn_cancel'>승인취소</span>
								<%


							}else if( "03".equals(bean.getApproval_cd()) ){

								%>
									<span id='btn_approval'>결재</span>
									<span id='btn_reject'>반려</span>
								<%
							}
							%>
								<span id='btn_list'>목록</span>
							<%
								if( ("02".equals(CommonUtil.isNull(docBean.getState_cd())) || "04".equals(CommonUtil.isNull(docBean.getState_cd())) ) && S_USER_CD.equals(CommonUtil.isNull(docBean.getUser_cd())) ) { %>
							&nbsp;
		 						<span id='btn_capy'>복사</span>

							<%} %>

							<%if( ("02".equals(CommonUtil.isNull(docBean.getState_cd()))||"04".equals(CommonUtil.isNull(docBean.getState_cd())) ) && ( S_USER_CD.equals(CommonUtil.isNull(docBean.getUser_cd()))||"99".equals(S_USER_GB) ) ) { %>
							&nbsp;
								<span id='btn_del'>삭제</span>
							<%} %>
						<%} %>
					<%} %>
		</td>
	</tr>
	-->


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
				{formatter:gridCellNoneFormatter,field:'cond_paren_s',id:'cond_paren_s',name:'(',width:60,headerCssClass:'cellCenter',cssClass:'cellCenter'}
				,{formatter:gridCellNoneFormatter,field:'cond_nm',id:'cond_nm',name:'선행조건명',width:350,headerCssClass:'cellCenter',cssClass:'cellLeft'}
				,{formatter:gridCellNoneFormatter,field:'cond_paren_e',id:'cond_paren_e',name:')',width:60,headerCssClass:'cellCenter',cssClass:'cellCenter'}
				,{formatter:gridCellNoneFormatter,field:'cond_dt',id:'cond_dt',name:'일자유형',width:80,headerCssClass:'cellCenter',cssClass:'cellCenter'}
				,{formatter:gridCellNoneFormatter,field:'cond_gb',id:'cond_gb',name:'구분',width:75,headerCssClass:'cellCenter',cssClass:'cellCenter'}
				,{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'번호',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}

			]
			,rows:[]
			,vscroll:false
		};

		var gridObj_2 = {
			id : "<%=gridId_2 %>"
			,colModel:[
				{formatter:gridCellNoneFormatter,field:'cond_nm',id:'cond_nm',name:'후행조건명',width:350,headerCssClass:'cellCenter',cssClass:'cellLeft'}
				,{formatter:gridCellNoneFormatter,field:'cond_dt',id:'cond_dt',name:'일자유형',width:80,headerCssClass:'cellCenter',cssClass:'cellCenter'}
				,{formatter:gridCellNoneFormatter,field:'cond_gb',id:'cond_gb',name:'구분',width:75,headerCssClass:'cellCenter',cssClass:'cellCenter'}
				,{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'번호',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
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
				, "FTP_NUM_RETRIES");

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

			fn_verification_chng();

			var days_cal			= "<%=strDays_cal%>";
			var weeks_cal			= "<%=strWeeks_cal%>";

			var server_gb			= "<%=strServerGb%>";
			var admin_udt			= "<%=admin_udt%>";
			var session_user_gb		= "<%=S_USER_GB%>";
			var doc_cd 				= '<%=doc_cd%>';

			var adminApprovalBtn = "<%=strAdminApprovalBtn %>";


			// 관리자 수정은 나머지 버튼 제거
			if ( admin_udt == "Y" ) {
				$("#btn_udt").show();
			} else {
				$("#btn_udt").show();
				$("#btn_draft").show();
				$("#btn_close").show();
				$("#btn_del").show();
			}

			$('#btn_compare').show();

			if (session_user_gb == "99"  || adminApprovalBtn == "Y") {
				$("#btn_draft_admin").show();
			} else {
				$("#btn_draft_admin").hide();
			}

			//운영자일 경우 삭제 버튼 활성화
			if ( session_user_gb == "99" || session_user_gb == "02" ) {
				$("#btn_del").show();
			}

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

				$("#mem_lib").val("");
				$("#mem_lib").attr("disabled", true);

				$("#mem_name").val("");
				$("#mem_name").attr("disabled", true);

				$("#command").val("DUMMY");
				$("#command").attr("disabled", true);

				$('.job_val').html('');
				$('.command_val').html('');
				
				$('#kubernetes_yn').hide();
				$('#mftTable').hide();
				$('#database_tb').hide();

			} else if( task_type == "command" ) {

				$("#mem_lib").attr("disabled", true);
				$("#mem_name").attr("disabled", true);
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
				$('#query').val('');
				$("#param_header_tr").show();
				$('#param_header_tr').nextUntil('#db_q_tr').show();
			}else if(execuType == 'Q'){
				$('#db_q_tr').show();
				$('#db_p_tr').hide();
				$('#schema').val('');
				$('#sp_name').val('');
				$("#param_tr").hide();
				$("#param_header_tr").hide();
				$('#param_header_tr').nextUntil('#db_q_tr').remove();
			}else{
				$('#db_q_tr').hide();
				$('#db_p_tr').hide();
				$('#schema').val('');
				$('#sp_name').val('');
				$('#query').val('');
				$("#param_tr").hide();
				$("#param_header_tr").hide();
				$('#param_header_tr').nextUntil('#db_q_tr').remove();
			}

			var data_center 	= $("#frm1").find("input[name='data_center']").val();
			var node_id 		= $("#node_id").val();
			var group_name 		= $("#group_name").val();
			var table_name 		= $("#table_name").val();
			var application 	= $("#application").val();
			var owner 			= $("#v_owner").val();
			var critical_yn 	= $("#critical").val();
			var	jobTypeGb		= $("#jobTypeGb").val();

			var confirm_flag	= "<%=strConfirmFlag%>";
			var success_sms_yn	= "<%=strSuccessSmsYn%>";
			var sub_table_name	= "<%=strSubTableNm%>";
			var cal_count		= 0;
			
			if(table_name.indexOf("/") > -1){
				table_name = table_name.substr(0, table_name.indexOf("/"));
			}

			mHostList(table_name);

			//어플리케이션 세팅. 그룹명은 setTimeoutValueSet()에서 세팅함(어플리케이션 선택까지 시간차).
			getAppGrpCodeList("application_of_def", "2", application, "", table_name);

			sCodeList(data_center, node_id);

			// 캘린더 가져오기.
			calList();

			// 콤보 박스 셋팅
			setTimeoutValueSet();
			
			//특정실행날짜 값이 있으면 나머지 스케쥴 정보 숨김처리
			if($("input[name='t_general_date']").val() != ''){
				var con = document.getElementById("t_general_date_yn");
				con.style.display = 'none';
			}
			
			$("#t_general_date").addClass("text_input").unbind('click').click(function(){
				cal_count ++;
				dpCalMinMulti(this.id,'mmdd',cal_count);
			});

			$("#btn_clear1").unbind("click").click(function(){
				$("#frm1").find("input[name='scode_nm']").val("");
			});
			$("#btn_clear2").unbind("click").click(function(){
				$("#frm1").find("input[name='active_from']").val("");
			});

			$("#btn_clear3").unbind("click").click(function(){
				$("#frm1").find("input[name='active_till']").val("");
			});

			$("#application_of_def").change(function(){ //어플리케이션 변경시

				var grp_info = $(this).val().split(",");

				$("#application").val(grp_info[1]);
				getAppGrpCodeList("group_name_of_def", "3", "", grp_info[0]);
				$("select[name='group_name_of_def']").append("<option value='direct'>직접입력</option>");
				$("#group_names").hide();

				// 그룹이 하나만 존재하면 자동 세팅
				if($("select[name='group_name_of_def'] option").length == 2 || $("select[name='group_name_of_def'] option").length == 3){
					$("select[name='group_name_of_def'] option:eq(1)").prop("selected", true);

					var group_name = $("select[name='group_name_of_def']").val();
					if(group_name == "direct"){
						$("#group_names").show();
					}else{
						$("#group_names").hide();
					}
					grp_info = $("select[name='group_name_of_def']").val().split(",");
					$("#group_name").val(grp_info[1]);
				}
			});

			$("#task_type").change(function(){ //작업타입 변경시

				var task_type = $("select[name='task_type'] option:selected").val();

				// 작업유형구분에 따라 작업타입 변경.
				if ( task_type == "job" ) {

					$("#mem_lib").val("");
					$("#mem_lib").attr("disabled", false);

					$("#mem_name").val("");
					$("#mem_name").attr("disabled", false);

					$("#command").val("");
					$("#command").attr("disabled", true);

					$('.job_val').html('* ');
					$('.command_val').html('');
					
					$('#kubernetes_yn').hide();
					$('#mftTable').hide();
					$('#database_tb').hide();

				} else if( task_type == "dummy" ) {

					$("#mem_lib").val("");
					$("#mem_lib").attr("disabled", true);

					$("#mem_name").val("");
					$("#mem_name").attr("disabled", true);

					$("#command").val("DUMMY");
					$("#command").attr("disabled", true);
					
					$('#kubernetes_yn').hide();
					$('#mftTable').hide();
					$('#database_tb').hide();

				} else if( task_type == "command" ) {

					$("#mem_lib").val("");
					$("#mem_lib").attr("disabled", true);

					$("#mem_name").val("");
					$("#mem_name").attr("disabled", true);

					$("#command").val("");
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
				}else if( task_type == "Database" ) {
					
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
			});
			
			$('#execution_type').change(function(){ 
				var exeType = $(this).val();
				
				if(exeType == 'P'){
					$('#db_q_tr').hide();
					$('#db_p_tr').show();
					$('#query').val('');
					
				}else if(exeType == 'Q'){
					$('#db_q_tr').show();
					$('#db_p_tr').hide();
					$('#schema').val('');
					$('#sp_name').val('');
					$("#param_tr").hide();
					$("#param_header_tr").hide();
					$('#param_header_tr').nextUntil('#db_q_tr').remove();
				}else{
					$('#db_q_tr').hide();
					$('#db_p_tr').hide();
					$('#schema').val('');
					$('#sp_name').val('');
					$('#query').val('');
					$("#param_tr").hide();
					$("#param_header_tr").hide();
					$('#param_header_tr').nextUntil('#db_q_tr').remove();
				}
			});
			$('#sel_db_output_format').change(function(){ 
				var dbOutputFormat = $(this).val();
				
				if(dbOutputFormat == 'C'){
					$('#csv_seperator').show();
				}else {
					$('#csv_seperator').hide();
				}
			});
			
			//파일 선택 후 파일명만 보이도록 
			$("#file_name").change(function(){
				var fullPath = event.target.value;
			    var fileName = fullPath.split('\\').pop().split('/').pop();
			    document.getElementById('yaml_file').value = fileName;
			});
			
			//폴더 클릭 시
			$("#table_nm").click(function(){
				
				var data_center = $("#data_center_items").val(); 
				 
				if(data_center == ""){
					alert("C-M 을 선택해 주세요.");
					return;
				}else{
					$("#p_app_eng_nm").val("");
					poeTabForm();
				}		
			});

			$("#group_name_of_def").change(function(){ //그룹 변경시

				if($(this).val() == "direct") {
					$("#group_names").show();
				} else {
					var aTmp = $(this).val().split(",");
					$("#group_name").val(aTmp[1]);
					$("#group_names").hide();
				}

			});
			
			if('<%=smart_yn%>' == 'Y') {
				document.getElementById('sub_table_of_def').style.display = 'inline';
				$("select[name='sub_table_of_def']").val(sub_table_name);
			}

			$("#host_id").change(function(){

				$("select[name='owner'] option").remove();
				$("select[name='owner']").append("<option value=''>--선택--</option>");
				$("#v_owner").val("");

				var data_center = $("#frm1").find("input[name='data_center']").val();
				var host_id = $("select[name='host_id'] option:selected").val();
				$("#node_id").val(host_id);

				sCodeList(data_center, host_id);
				
				// 계정명 목록이 1개일때 자동 셋팅
				if($("select[name='owner'] option").length == 2 ){
					$("select[name='owner'] option:eq(1)").prop("selected", true);
				}
			});

			//Critical_yn 0 or 1 저장
			$("#critical_yn").change(function(){
				$("#critical").val($(this).val());
			});
			
			var RPF_CHK 				= "<%=RPF_CHK%>";
			var CONT_EXE_NOTOK_CHK 		= "<%=CONT_EXE_NOTOK_CHK%>";
			var USE_DEF_NUMRETRIES_CHK 	= "<%=USE_DEF_NUMRETRIES_CHK%>";
			
			$("#FTP_RPF_YN").prop("checked", (RPF_CHK === "true"));
			$("#FTP_CONT_EXE_NOTOK_YN").prop("checked", (CONT_EXE_NOTOK_CHK === "true"));
			$("#FTP_USE_DEF_NUMRETRIES_YN").prop("checked", (USE_DEF_NUMRETRIES_CHK === "true"));
			
			$("#FTP_RPF_YN").change(function(){
				var FTP_RPF_YN = $(this).prop("checked");
				
				if(FTP_RPF_YN){
					$("#FTP_RPF").val("1");
				}else{
					$("#FTP_RPF").val("0");
				}
			});
			
			$("#FTP_CONT_EXE_NOTOK_YN").change(function(){
				var FTP_CONT_EXE_NOTOK_YN = $(this).prop("checked");
				
				if(FTP_CONT_EXE_NOTOK_YN){
					$("#FTP_CONT_EXE_NOTOK").val("1");
				}else{
					$("#FTP_CONT_EXE_NOTOK").val("0");
				}
			});
			
			$("#FTP_USE_DEF_NUMRETRIES_YN").change(function(){
				var FTP_USE_DEF_NUMRETRIES_YN = $(this).prop("checked");
				
				if(FTP_USE_DEF_NUMRETRIES_YN){
					$("#FTP_USE_DEF_NUMRETRIES").val("1");
				}else{
					$("#FTP_USE_DEF_NUMRETRIES").val("0");
				}
			});

			$("#btn_argmt_add").button().unbind("click").click(function(){

				popArgForm("argmt");
			});
			$("#btn_parm_add").button().unbind("click").click(function(){

				if($("#task_type").val() != "job"){
					alert("작업 타입이 job 일때만 입력 가능 합니다.");
					return;
				}

				popArgForm("parm");
			});

			//작업시작시간을 받아서 시간그룹을 SET 해준다.
			$("#sHour").change(function(){

				$("#time_group").val("");

				$("#time_from").val("");

				var sHour = $("select[name='sHour'] option:selected").val();
				var sMin = $("select[name='sMin'] option:selected").val();

				if(sHour == ''){
					$("#time_from").val('');
					$("select[name='sHour']").val("");
					$("select[name='sMin']").val("");
					return;
				}
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
					$("#time_from").val('');
					$("select[name='sHour']").val("");
					$("select[name='sMin']").val("");
					return;
				}

				if(sMin == ''){
					$("#time_from").val('');
					$("select[name='sHour']").val("");
					$("select[name='sMin']").val("");
					return;

				}

				$("#time_from").val(sHour+sMin);

			});

			$("#eHour").change(function(){

				$("#time_until").val("");
				$("#ignore_time_until").prop("checked", false);

				var eHour = $("select[name='eHour'] option:selected").val();
				var eMin = $("select[name='eMin'] option:selected").val();

				if(eHour == ''){
					$("#time_until").val('');
					$("select[name='eHour']").val("");
					$("select[name='eMin']").val("");
					return;
				}

				$("#time_until").val(eHour+eMin);

			});

			//작업종료시간의 시간, 분을 받아서 from_time을 SET 해준다.
			$("#eMin").change(function(){

				$("#time_until").val("");
				$("#ignore_time_until").prop("checked", false);

				var eHour =  $("select[name='eHour'] option:selected").val();
				var eMin = $("select[name='eMin'] option:selected").val();

				if(eHour == ''){
					alert("작업종료시간의 '시' 항목을 '분' 보다 먼저 입력해 주세요");
					$("#time_until").val('');
					$("select[name='eHour']").val("");
					$("select[name='eMin']").val("");
					return;
				}

				if(eMin == ''){
					$("#time_until").val('');
					$("select[name='eHour']").val("");
					$("select[name='eMin']").val("");
					return;
				}

				$("#time_until").val(eHour+eMin);

			});


			//시작임계시간의 시간, 분을 받아서 late_sub을 SET 해준다.
			$("#slate_sub_h").change(function(){

				$("#late_sub").val("");

				var slate_sub_h =  $("select[name='slate_sub_h'] option:selected").val();
				var slate_sub_m = $("select[name='slate_sub_m'] option:selected").val();

				if(slate_sub_h == ''){
					alert("시작임계시간의 '시' 항목을 '분' 보다 먼저 입력해 주세요");

					$("select[name='slate_sub_h']").val("");
					$("select[name='slate_sub_m']").val("");
					$("#late_sub").val('');
					return;
				}

				$("#late_sub").val(slate_sub_h+slate_sub_m);

			});

			//시작임계시간의 시간, 분을 받아서 late_sub을 SET 해준다.
			$("#slate_sub_m").change(function(){

				$("#late_sub").val("");

				var slate_sub_h =  $("select[name='slate_sub_h'] option:selected").val();
				var slate_sub_m = $("select[name='slate_sub_m'] option:selected").val();

				if(slate_sub_h == ''){
					alert("시작임계시간의 '시' 항목을 '분' 보다 먼저 입력해 주세요");

					$("select[name='slate_sub_h']").val("");
					$("select[name='slate_sub_m']").val("");
					$("#late_sub").val('');
					return;
				}

				if(slate_sub_m == ''){

					$("select[name='slate_sub_h']").val("");
					$("select[name='slate_sub_m']").val("");
					$("#late_sub").val('');
					return;
				}

				$("#late_sub").val(slate_sub_h+slate_sub_m);

			});

			//종료임계시간의 시간, 분을 받아서 late_sub을 SET 해준다.
			$("#slate_time_h").change(function(){

				var slate_time_h =  $("select[name='slate_time_h'] option:selected").val();

				if(slate_time_h == ''){
					$("select[name='slate_time_h']").val("");
					$("select[name='slate_time_m']").val("");
					$("#late_time").val("");
					return;
				}
				$("#late_time").val(slate_time_h+slate_time_m);
			});

			$("#slate_time_m").change(function(){

				$("#late_time").val("");

				var slate_time_h =  $("select[name='slate_time_h'] option:selected").val();
				var slate_time_m = $("select[name='slate_time_m'] option:selected").val();

				if(slate_time_h == ''){
					alert("시작임계시간의 '시' 항목을 '분' 보다 먼저 입력해 주세요");
					$("select[name='slate_time_h']").val("");
					$("select[name='slate_time_m']").val("");
					$("#late_time").val("");
					return;

				}

				if(slate_time_m == ''){
					$("select[name='slate_time_h']").val("");
					$("select[name='slate_time_m']").val("");
					$("#late_time").val("");
					return;
				}

				$("#late_time").val(slate_time_h+slate_time_m);

			});
			$("#slate_time_h").change(function(){

				var slate_time_h =  $("select[name='slate_time_h'] option:selected").val();

				if(slate_time_h == ''){
					$("select[name='slate_time_h']").val("");
					$("select[name='slate_time_m']").val("");
					$("#late_time").val("");
					return;
				}
				$("#late_time").val(slate_time_h+slate_time_m);
			});

			$("#slate_time_m").change(function(){

				$("#late_time").val("");

				var slate_time_h =  $("select[name='slate_time_h'] option:selected").val();
				var slate_time_m = $("select[name='slate_time_m'] option:selected").val();

				if(slate_time_h == ''){
					alert("시작임계시간의 '시' 항목을 '분' 보다 먼저 입력해 주세요");
					$("select[name='slate_time_h']").val("");
					$("select[name='slate_time_m']").val("");
					$("#late_time").val("");
					return;

				}

				if(slate_time_m == ''){
					$("select[name='slate_time_h']").val("");
					$("select[name='slate_time_m']").val("");
					$("#late_time").val("");
					return;
				}

				$("#late_time").val(slate_time_h+slate_time_m);

			});

			//종료임계시간의 시간, 분을 받아서 late_sub을 SET 해준다.
			$("#slate_exec_m").change(function(){

				$("#late_exec").val("");

				var slate_exec_h =  $("select[name='slate_exec_h'] option:selected").val();
				var slate_exec_m = $(this).val();

				//수행임계시간의 문법 때문에 작성

				var slate_exec_h_sub = parseInt(slate_exec_h);
				var slate_exec_m_sub = parseInt(slate_exec_m);

				var late_exec_sum = (slate_exec_h_sub*60)+slate_exec_m_sub;


				if(slate_exec_h == ''){
					alert("시작임계시간의 '시' 항목을 '분' 보다 먼저 입력해 주세요");
					$("select[name='slate_exec_m']").val("");
					return;

				}

				$("#late_exec").val(late_exec_sum);

			});

			$("#btn_udt").button().unbind("click").click(function(){
				valid_chk('udt');
			});
			$("#btn_draft").button().unbind("click").click(function(){
				valid_chk('draft');
			});
			$("#btn_draft_admin").button().unbind("click").click(function(){
				valid_chk('draft_admin');
			});
			$("#btn_close").button().unbind("click").click(function(){
				top.closeTab('tabs-'+doc_cd);
			});

			$("#btn_compare").button().unbind("click").click(function(){
				popupDocVersionCompare();
			});

			$("#active_from").addClass("ime_readonly").unbind('click').click(function(){
				dpCalMinMax(this.id,'yymmdd','0','90');
			});

			$("#active_till").addClass("ime_readonly").unbind('click').click(function(){
				dpCalMinMax(this.id,'yymmdd','0','90');
			});

			$("#btn_del").button().unbind("click").click(function(){
				goPrc('del','','');
			});

			// 캘린더
			$("#btn_sched").button().unbind("click").click(function(){
				popSchedForm();
			});
			

			$("#btn_con_pro").button().unbind("click").click(function(){
				fn_con_pro_popup();
			});

			
			$("#btn_db_con_pro").button().unbind("click").click(function(){
				fn_db_con_pro_popup();
			});
			$("#btn_schema_pro").button().unbind("click").click(function(){
				fn_schema_popup();
			});
			
			$("#btn_sp_pro").button().unbind("click").click(function(){
				fn_sp_popup();
			});
			
			$('#chk_db_append_output').change(function () {
	             if ($(this).is(':checked')) {
	            	 $('#sel_db_output_format').prop("disabled",false);
	            	 $('#csv_seperator').prop("disabled",false);
	             } else {
	            	 $('#sel_db_output_format').prop("disabled",true);
	            	 $('#csv_seperator').prop("disabled",true);
	             }
	        });
			
			// 캘린더 제거
			$("#btn_schedDel").button().unbind("click").click(function(){
				$("#cal_cd").val("");
				$("#cal_nm").val("");
				$("#days_cal").val("");
				$("#days_and_or").val("");
				$("#weeks_cal").val("");
				$("#week_days").val("");
				$("#use_gb").val("");
				$("#use_yn").val("");
				$("#month_cal").val("");
				$("#month_days").val("");
				$("#conf_cal").val("");
				$("#shift").val("");
				$("#shift_num").val("");
			});

			//form value set
			$("#critical_yn").val("<%=CommonUtil.isNull(docBean.getCritical())%>");
			$("#sBatchJobGrade").val("<%=batchJobGrade%>");
			$("select[name='sHour']").val("<%=vh_fromTime%>");
			$("select[name='sMin']").val("<%=vm_fromTime%>");
			$("select[name='slate_time_h']").val("<%=vh_lateTime%>");
			$("select[name='slate_time_m']").val("<%=vm_lateTime%>");
			$("select[name='slate_sub_h']").val("<%=vh_lateSub%>");
			$("select[name='slate_sub_m']").val("<%=vm_lateSub%>");
			$("select[name='eHour']").val("<%=vh_timeUntil%>");
			$("select[name='eMin']").val("<%=vm_timeUntil%>");
			$("select[name='get_pod_logs']").val("<%=get_pod_logs%>");
			$("select[name='job_cleanup']").val("<%=job_cleanup%>");
			$("select[name='os_exit_code']").val("<%=os_exit_code%>");
			
			$("select[name='execution_type']").val("<%=execution_type%>");
			$("select[name='sel_db_output_format']").val("<%=db_output_format%>");
			
			var dbOutputFormat = document.getElementById('sel_db_output_format').value;
			
			if(dbOutputFormat == 'C'){
				$('#csv_seperator').show();
			}else {
				$('#csv_seperator').hide();
			}

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
				 	setPreAfterJobs("<%=aTmpT1[0]%>", "1", "<%=aTmpT1[1]%>","<%=aTmpT1[2]%>", "");
			<%--addConditions("1", "<%=aTmpT1[0]%>", "<%=aTmpT1[1]%>","<%=aTmpT1[2]%>", "");  --%>
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
       				setPreAfterJobs("<%=aTmpT1[0]%>", "2", "<%=aTmpT1[1]%>","<%=aTmpT1[2]%>", "");
			<%--	addConditions("out", "<%=aTmpT1[0]%>", "<%=aTmpT1[1]%>","<%=aTmpT1[2]%>", "");--%>
		<%
				}
			}
		%>

			var docActive_from = '<%=CommonUtil.isNull(docBean.getActive_from())%>';
			var docActive_till = '<%=CommonUtil.isNull(docBean.getActive_till())%>';

			if(docActive_from != "" && docActive_till != ""){
				if(docActive_from > docActive_till){
					$("select[name='active_yn']").val("N");
					$("#active_from").val(docActive_till);
					$("#active_till").val(docActive_from);
				}else{
					$("select[name='active_yn']").val("Y");
					$("#active_from").val(docActive_from);
					$("#active_till").val(docActive_till);
				}

			}

			if(docActive_from == "" || docActive_till == ""){
				$("select[name='active_yn']").val("Y");
				$("#active_from").val(docActive_from);
				$("#active_till").val(docActive_till);
			}

			$("#verification_yn").change(function(){
				fn_verification_chng();
			});

			//시간 무시 체크 박스 추가 TO_TIME(time_until컬럼)
			var ignoreTimeUntil	= <%=ignoreTimeUntil%>;
			$("#ignore_time_until").prop("checked", ignoreTimeUntil);

			$("#ignore_time_until").change(function(){
				var ignore_time_until = $(this).prop("checked");
				if (ignore_time_until) {
					$("#eHour").val("");
					$("#eMin").val("");
					$("#time_until").val('>');
				}else {
					$("#time_until").val('');
				}
			});
			
		if( task_type == "MFT" ) {
				
				var input = null;
				var tempvalue = null;
				var frm = document.frm1;
				
				<c:if test="${strTaskType eq 'MFT'}">
					for(var key in accountlist) {
						input = '#' + accountlist[key];
						<c:forEach var="account" items="${setvarList}" varStatus="vs">
						if($(input).attr("name") == "${account.var_name}") {
							tempvalue = "${account.var_value}";
							$(input).attr("value", tempvalue);
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
						}
					}
	
					var host1 = 'HOST1 = ' + frm.FTP_LHOST.value; 
					var host2 = 'HOST2 = ' + frm.FTP_RHOST.value;
					
					document.getElementById("host11").innerText = host1 + '  TYPE = ' + frm.FTP_CONNTYPE1.value + ' USER = ' + frm.FTP_LUSER.value;
					document.getElementById("host21").innerText = host2 + '  TYPE = ' + frm.FTP_CONNTYPE2.value + ' USER = ' + frm.FTP_RUSER.value;
					
					ftp_use_def_numretries_check();
				</c:if>
				
			}
		});

		//특정실행날짜 초기화
		function fn_clear(arg){
			if ( arg == "btn_del_date" ) {
				$("input[name='t_general_date']").val('');
				$("input[name='t_general_date']").multiDatesPicker( "destroy" );
				
				//스케쥴정보 보여주기
				var con = document.getElementById("t_general_date_yn");	
				con.style.display = '';
			}
		}
		//특정실행날짜 안의 값에 따라 스케쥴정보 보여주기
		function fn_change(arg){
			var con = document.getElementById("t_general_date_yn");	
			if($("input[name='t_general_date']").val() == ''){
				con.style.display = '';
			}else{
				con.style.display = 'none';
				$("#days_cal").val("");
				$("#active_from").val("");
				$("#active_until").val("");
			}
		}
		function fn_verification_chng(){
			var verification_yn = $('#verification_yn').val();

			if(verification_yn == "Y"){
				$('#sysout_font').show();
				$('#standard_sysout').attr("disabled", false);
			}else{
				$('#sysout_font').hide();
				$('#standard_sysout').attr("disabled", true);
			}
		}

		function checkAll() {

			var chk 	= document.getElementsByName("check_idx");
			var chk_all = document.getElementById("checkIdxAll");
			var cnt = 0;

			if (cnt==0) {
				for(i = 0; i < chk.length; i++) {
					if(chk_all.checked) {
						chk.item(i).checked ="checked";
					}else {
						chk.item(i).checked = "";
					}
				}
				cnt++;
			}else {
				for(i = 0; i < chk.length; i++) chk.item(i).checked ="";
				cnt=0;
			}
		}
		function checkAll2() {

			var chk 	= document.getElementsByName("idx_check");
			var chk_all = document.getElementById("idxCheckAll");
			var cnt = 0;

// 			if (cnt==0) {
// 				for(i = 0; i < chk.length; i++) {
// 					if(chk_all.checked) {
// 						chk.item(i).checked ="checked";
// 					}else {
// 						chk.item(i).checked = "";
// 					}
// 				}
// 				cnt++;
// 			}else {
// 				for(i = 0; i < chk.length; i++) chk.item(i).checked ="";
// 				cnt=0;
// 			}
			
					if(chk_all.checked) {
				$("input:checkbox[name=idx_check]:not(:disabled)").prop("checked", "checked");
			}else {
				$("input:checkbox[name=idx_check]:not(:disabled)").prop("checked", "");  
			}
		}

		function checkAll3() {

			var chk 	= document.getElementsByName("idx_check_resq");
			var chk_all = document.getElementById("checkIdxAllResQ");
			var cnt = 0;

			if(chk_all.checked) {
				$("input:checkbox[name=idx_check_resq]:not(:disabled)").prop("checked", "checked");
			}else {
				$("input:checkbox[name=idx_check_resq]:not(:disabled)").prop("checked", "");
			}
		}

		function goUserSeqSelect(cd, nm, btn){

			var frm1 		= document.frm1;
			var smsDefault	= "<%=smsDefault%>";
			var mailDefault	= "<%=mailDefault%>";
			
			if(smsDefault == "Y"){
				$("input:checkbox[name=sms_"+btn+"_0]:not(:disabled)").prop("checked", true);
			}
			if(mailDefault == "Y"){
				$("input:checkbox[name=mail_"+btn+"_0]:not(:disabled)").prop("checked", true);
			}

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
			}else if(btn == "9"){
				frm1.user_nm_9_0.value = nm;
				frm1.user_cd_9_0.value = cd;
			}else if(btn == "10"){
				frm1.user_nm_10_0.value = nm;
				frm1.user_cd_10_0.value = cd;
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

				//form.max_wait.value 		= "<%=strDefaultMaxWait%>";
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

			openPopupCenter1("about:blank","popupCyclic",900,300);

			frm.action = "<%=sContextPath %>/tPopup.ez?c=ez005";
			frm.target = "popupCyclic";
			frm.submit();
		}

		 //Kubernetes profile name 선택 팝업
		  function fn_con_pro_popup() {

		      var frm = document.frm1;

		      openPopupCenter1("popupConPro","popupConPro",600,300);

		      frm.action = "<%=sContextPath %>/tPopup.ez?c=ez006";
		      frm.target = "popupConPro";
		      frm.submit();
		  }
		  
		  //Database profile name 선택 팝업
		  function fn_db_con_pro_popup() {
			  var node_id 		= document.getElementById('node_id').value;
			  var data_center 	= document.getElementById('data_center').value;
			
			  /* if ( node_id == "" ) {
				  alert("수행서버를 먼저 선택해 주세요.");
				  return;
			  } */
			
			  var frm = document.frm1;

			  openPopupCenter1("popupDbConPro","popupDbConPro",900,340);

			  frm.action = "<%=sContextPath %>/tPopup.ez?c=ez008";
			  frm.target = "popupDbConPro";
			  frm.submit();
		  }
			//Database 스키마 선택 팝업
			function fn_schema_popup() {
				var db_con_pro 		= document.getElementById('db_con_pro').value;
				
				if ( db_con_pro == "" ) {
					alert("Connection Profile을 선택해주세요.");
					return;
				}
				
				var frm = document.frm1;
			
				openPopupCenter1("popupDbConPro","popupDbSchema",600,340);
			
				frm.action = "<%=sContextPath %>/tPopup.ez?c=ez008_1";
				frm.target = "popupDbSchema";
				frm.submit();
			}

			//Database 프로시져 선택 팝업
			function fn_sp_popup() {
				var schema 		= document.getElementById('schema').value;
				
				if ( schema == "" ) {
					alert("schema를 선택해 주세요.");
					return;
				}
				
				var frm = document.frm1;
			
				openPopupCenter1("popupDbConPro","popupSpList",485,340);
			
				frm.action = "<%=sContextPath %>/tPopup.ez?c=ez008_2";
				frm.target = "popupSpList";
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

		//컨디션검색
		function popJobsForm(gb){

			var data_center = $("#data_center").val();
			var application = $("#application").val();
			var group_name = $("#group_name").val();

			if(data_center == ""){
				alert("C-M 을 선택해 주세요.");
				return;
			}

			var sHtml1="<div id='dl_tmp1' style='overflow:hidden;display:none;padding:0;border-top:1px solid blue;border-bottom:1px solid blue;border-left:1px solid blue;border-right:1px solid blue;'>";
			sHtml1+="<form id='form1' name='form1' method='post' onsubmit='return false;'>";
			sHtml1+="<input type='hidden' name='search_gubun' id='search_gubun' value='job_name' />";
			sHtml1+="<table style='width:100%;height:260px;;border:none;'><tr><td style='vertical-align:top;height:100%;width:500px;text-align:right;'>";
			sHtml1+="<div class='ui-widget-header ui-corner-all'>C-M : <select name='v_data_center' id='v_data_center' style='height:21px;'>";
			sHtml1+="<option value=''>--선택--</option>";
			<c:forEach var="cm" items="${cm}" varStatus="status">
			sHtml1+="<option value='${cm.scode_cd},${cm.scode_eng_nm}'>${cm.scode_nm}</option>"
			</c:forEach>;
			sHtml1+="</select>&nbsp;";
			sHtml1+="작업명 : <input type='text' name='pre_search_text' id='pre_search_text' value='' />&nbsp;&nbsp;<span id='btn_pre_search' style='margin:3px;'>검색</span></div>";
			sHtml1+="<table style='width:100%;height:100%;border:none;'>";
			sHtml1+="<tr><td id='ly_g_tmp1' style='vertical-align:top;' >";
			sHtml1+="<div id='g_tmp1' class='ui-widget-header ui-corner-all'></div>";
			sHtml1+="</td></tr>";
			sHtml1+="<tr style='height:10px;'><td style='vertical-align:top;'><h5 class='ui-widget-header ui-corner-all' >";
			sHtml1+="<div align='right' class='btn_area_s'>";
			sHtml1+="<div id='ly_total_cnt_1' style='padding-top:5px;float:left;'></div>";
			sHtml1+="</div>";
			sHtml1+="</h5></td></tr></table>";

			sHtml1+="</td></tr></table>";

			sHtml1+="</form>";

			$('#dl_tmp1').remove();
			$('body').append(sHtml1);

			dlPop02('dl_tmp1',"컨디션검색 ",700,300,false);

			var gridObj = {
				id : "g_tmp1"
				,colModel:[
					{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'번호',width:50,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
					,{formatter:gridCellNoneFormatter,field:'FOLDER',id:'FOLDER',name:'폴더',width:120,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
					,{formatter:gridCellNoneFormatter,field:'APPLICATION',id:'APPLICATION',name:'애플리케이션',width:120,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
					,{formatter:gridCellNoneFormatter,field:'GROUP_NAME',id:'GROUP_NAME',name:'그룹',width:120,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
					,{formatter:gridCellNoneFormatter,field:'JOB_NAME',id:'JOB_NAME',name:'작업명',width:200,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
					,{formatter:gridCellNoneFormatter,field:'CHOICE',id:'CHOICE',name:'선택',width:50,headerCssClass:'cellCenter',cssClass:'cellCenter'}

					,{formatter:gridCellNoneFormatter,field:'JOB_ID',id:'JOB_ID',name:'JOB_ID',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
					,{formatter:gridCellNoneFormatter,field:'TABLE_ID',id:'TABLE_ID',name:'TABLE_ID',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
				]
				,rows:[]
				,vscroll:<%=S_GRID_VSCROLL%>
			};
			$("#v_data_center").val(data_center);
			$("#doc_data_center").val(data_center);
			$("#pre_search_text").focus();

			viewGrid_1(gridObj,'ly_'+gridObj.id);

			popJobsList("최초에는 직접입력만 노출하기 위한 임시 검색조건", gb, $("#search_gubun").val(), "최초에는 직접입력만 노출하기 위한 임시 검색조건", data_center);

			$('#pre_search_text').placeholder().unbind('keypress').keypress(function(e){
				if(e.keyCode==13){

					if($(this).val() == ""){
						alert("작업명을 입력해주세요.");
						return;
					}else{
						var v_data_center = $("select[name='v_data_center'] option:selected").val();

						if(v_data_center == ""){
							alert("C-M 을 선택해 주세요.");
							return;
						}

						popJobsList($(this).val(), gb, $("#search_gubun").val(), $("#pre_search_text").val(), v_data_center);
					}
				}
			});

			$("#btn_pre_search").button().unbind("click").click(function(){

				var search_text = $("#form1").find("input[name='pre_search_text']").val();

				if(search_text == ""){
					alert("작업명을 입력해주세요.");
					return;
				}else{
					var v_data_center = $("select[name='v_data_center'] option:selected").val();

					if(v_data_center == ""){
						alert("C-M 을 선택해 주세요.");
						return;
					}
					popJobsList(search_text, gb, $("#search_gubun").val(), $("#pre_search_text").val(), v_data_center);
				}
			});

		}

		//컨디션내역 가져오기
		function popJobsList(search_text, gb, gubun, text, v_data_center){

			try{viewProgBar(true);}catch(e){}
			$('#ly_total_cnt_1').html('');

			var data_center 		=  v_data_center;
			var application_of_def 	= $("#application").val();
			var group_name_of_def 	= $("#group_name").val();

			if(data_center == ''){
				alert("C-M 을 선택해 주세요.");
				return;
			}

			$("#f_s").find("input[name='p_data_center']").val(data_center);
			//$("#f_s").find("input[name='p_application']").val("'"+app+"'");
			//$("#f_s").find("input[name='p_group_name_of_def']").val(group_name_of_def);
			$("#f_s").find("input[name='p_search_gubun']").val(gubun);
			$("#f_s").find("input[name='p_search_text']").val(text);

			var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=popDefJobList&itemGubun=2';

			var xhr = new XHRHandler(url, f_s
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

							var job_name0 = "<div class='gridInput_area'><input type='text' name='job_name0' id='job_name0' style='width:100%;ime-mode:disabled;' placeholder='직접입력' /></div>";

							rowsObj.push({
								'grid_idx':''
								,'FOLDER': ''
								,'APPLICATION': ''
								,'GROUP_NAME': ''
								,'JOB_NAME': job_name0
								,'JOB_ID': ''
								,'TABLE_ID': ''
								,'CHOICE':"<div><a href=\"javascript:goPreJobSelect('','"+gb+"','direct');\" ><font color='red'>[선택]</font></a></div>"
							});

							if(items.attr('cnt')=='0'){
							}else{
								items.find('item').each(function(i){

									var table_name			= $(this).find("SCHED_TABLE").text();
									var application			= $(this).find("APPLICATION").text();
									var group_name 			= $(this).find("GROUP_NAME").text();
									var job_name 			= $(this).find("JOB_NAME").text();
									var job_id 				= $(this).find("JOB_ID").text();
									var table_id 			= $(this).find("TABLE_ID").text();
									var mapper_data_center 	= $(this).find("MAPPER_DATA_CENTER").text();
									var set_job_name		= job_name;

									if ( $("#data_center").val() != data_center ) {
										var gcond_prefix = "<%=CommonUtil.isNull(CommonUtil.getMessage("GCOND_PREFIX"))%>";
										set_job_name = gcond_prefix + job_name;
									}

									rowsObj.push({
										'grid_idx':i+1
										,'FOLDER': table_name
										,'APPLICATION': application
										,'GROUP_NAME': group_name
										,'JOB_NAME': job_name
										,'JOB_ID': job_id
										,'TABLE_ID': table_id

										,'CHOICE':"<div><a href=\"javascript:goSelect('"+set_job_name+"','"+gb+"');\" ><font color='red'>[선택]</font></a></div>"
									});
								});
							}

							var obj = $("#g_tmp1").data('gridObj');
							obj.rows = rowsObj;
							setGridRows(obj);

							$('#ly_total_cnt_1').html('[ TOTAL : '+items.attr('cnt')+' ]');

						});
						try{viewProgBar(false);}catch(e){}
					}
					, null );

			xhr.sendRequest();
		}

		function goPreJobSelect(job_nm, gb, flag){

			// 접미사 셋팅
			var cond_suffix = "<%=CommonUtil.isNull(CommonUtil.getMessage("COND_SUFFIX"))%>";
			var v_job_name = "";

			if(flag == "direct"){
				v_job_name = document.getElementById('job_name0').value;
				if(v_job_name == ""){
					alert("직접입력에 작업명을 입력해 주세요.");
					return;
				}
			}else{
				v_job_name = job_nm;
			}

			v_job_name = v_job_name.replace(/^\s+|\s+$/g,"");
			v_job_name = v_job_name + cond_suffix;

			setPreAfterJobs(v_job_name, gb, "ODAT", "", 'add');

			if(flag == "direct"){
				document.getElementById('job_name0').value = "";
			}
		}

		function goSelect(job_nm, gb){
			// 접미사 셋팅
			var cond_suffix = "<%=CommonUtil.isNull(CommonUtil.getMessage("COND_SUFFIX"))%>";
			job_nm = job_nm + cond_suffix;

			setPreAfterJobs(job_nm, gb, 'ODAT', "", 'add');
		}

		function setPreAfterJobs(job_nm, gb, cond, and_or, add){

			var cond_nm = "";
			var cond_dt = "";
			var cond_gb = "";
			var i = 0;
			var val = "";
		    var parentheses_s = "";
			var parentheses_e = "";

			if (gb == "1" || gb == "in") {
				i = rowsObj_job1.length+1;
			   val = "_in_cond_nm"+i;
			} else if (gb == "2" || gb == "out") {
				i = rowsObj_job2.length+1;
				val = "_outcond_nm"+i;
			}

			if (job_nm != "") {
			  if (gb == "1") {
				  if (job_nm.indexOf("(") != -1) {
					  job_nm = job_nm.replace("(", "");
					  parentheses_s = "(";
				  } else {
					  parentheses_s = "";
				  }

				  if (job_nm.indexOf(")") != -1) {
					  job_nm = job_nm.replace(")", "");
					  parentheses_e = ")";
				  } else {
					  parentheses_e = "";
				  }
			  }
		  }

		//추가일 경우 해당 데이터가 undefined로 설정된다.
		if(add=='add'){
			if(typeof odate == "undefined") cond_nm = "<div class='gridInput_area'><input type='text' name='job"+val+"' id='job"+val+"' value='"+job_nm+"' style='width:100%;' ></div>";
			if(typeof odate == "undefined") cond = "ODAT";
			if(typeof and_or == "undefined") and_or = "and";
		}else{
			cond_nm = "<div class='gridInput_area'><input type='text' name='job"+val+"' id='job"+val+"' value='"+job_nm+"' style='width:100%;' ></div>";
		}

		  if(gb == "1" || gb == "in"){
			  cond_paren_s = "";
			  cond_paren_s += "<div class='gridInput_area'>";
			  cond_paren_s += "<select name='dt"+val+"' id='dt"+val+"'style='width:40px;height:21px;'>";
			  cond_paren_s += "<option value=''></option>";
			  <c:forTokens var="in_cond_paren_s" items="${IN_COND_PAREN_S}" delims=",">
			  if(parentheses_s == '${in_cond_paren_s}'){
				  cond_paren_s += "<option value='${in_cond_paren_s}' selected>${in_cond_paren_s}</option>";
			  } else {
				  cond_paren_s += "<option value='${in_cond_paren_s}'>${in_cond_paren_s}</option>";
			  }
			  </c:forTokens>

			  cond_paren_s += "</select>";
			  cond_paren_s += "</div>";

			  cond_paren_e = "";
			  cond_paren_e += "<div class='gridInput_area'>";
			  cond_paren_e += "<select name='dt"+val+"' id='dt"+val+"'style='width:40px;height:21px;'>";
			  cond_paren_e += "<option value=''></option>";

			  <c:forTokens var="in_cond_paren_e" items="${IN_COND_PAREN_E}" delims=",">
			  if(parentheses_e == '${in_cond_paren_e}'){
				  cond_paren_e += "<option value='${in_cond_paren_e}' selected>${in_cond_paren_e}</option>";
			  } else {
				  cond_paren_e += "<option value='${in_cond_paren_e}'>${in_cond_paren_e}</option>";
			  }
			  </c:forTokens>

			  cond_paren_e += "</select>";
			  cond_paren_e += "</div>";
		  }

		cond_dt = "";
		cond_dt += "<div class='gridInput_area'>";
		cond_dt += "<select name='dt"+val+"' id='dt"+val+"'style='width:70px;height:21px;'>";
		if(gb == "1"){
			<c:forTokens var="in_cond_dt" items="${IN_COND_DT}" delims=",">
			if(cond == "${in_cond_dt}"){
				cond_dt += "<option value='${in_cond_dt}' selected>${fn:toUpperCase(in_cond_dt)}</option>";
			} else {
				cond_dt += "<option value='${in_cond_dt}'>${fn:toUpperCase(in_cond_dt)}</option>";
			}
			</c:forTokens>
		}else if(gb == "2"){
			<c:forTokens var="out_cond_dt" items="${OUT_COND_DT}" delims=",">
			if(cond == "${out_cond_dt}"){
				cond_dt += "<option value='${out_cond_dt}' selected>${fn:toUpperCase(out_cond_dt)}</option>";
			} else {
				cond_dt += "<option value='${out_cond_dt}'>${fn:toUpperCase(out_cond_dt)}</option>";
			}
			</c:forTokens>
		}

		cond_dt += "</select>";
		cond_dt += "</div>";

		cond_gb = "";
		cond_gb += "<div class='gridInput_area'>";
		cond_gb += "<select name='gb"+val+"' id='gb"+val+"'style='width:65px;height:21px;'>";

		if(gb == "1"){
			<c:forTokens var="in_cond_and_or" items="${IN_COND_AND_OR}" delims=",">
			if(and_or == "${in_cond_and_or}"){
				cond_gb += "<option value='${in_cond_and_or}' selected>${fn:toUpperCase(in_cond_and_or)}</option>";
			} else {
				cond_gb += "<option value='${in_cond_and_or}'>${fn:toUpperCase(in_cond_and_or)}</option>";
			}
			</c:forTokens>
		}else if(gb == "2"){
			<c:forTokens var="out_cond_effect" items="${OUT_COND_EFFECT}" delims=",">
			if(and_or == "${out_cond_effect}"){
				cond_gb += "<option value='${out_cond_effect}' selected>${fn:toUpperCase(out_cond_effect)}</option>";
			} else {
				cond_gb += "<option value='${out_cond_effect}'>${fn:toUpperCase(out_cond_effect)}</option>";
			}
			</c:forTokens>
		}

		cond_gb += "</select>";
		cond_gb += "</div>";

				if(gb == "1"){

					var dup_cnt = 0;
					setGridSelectedRowsAll(gridObj_1);		//중복체크를 위해 전체항목 선택

					var aSelRow = new Array;
					aSelRow = $('#'+gridObj_1.id).data('grid').getSelectedRows();

					if(aSelRow.length>0){
						for(var j=0;j<aSelRow.length;j++){
							var v_cond_nm = getCellValue(gridObj_1,aSelRow[j],'chk_cond_nm');

							if(v_cond_nm == job_nm){
								++dup_cnt;
								break;
							}
						}
					}

					clearGridSelected(gridObj_1)		//선택된 전체항목 해제 */

					if(dup_cnt > 0){	//중복된 내용이 있다면 (잡명)
						alert("이미 등록된 내용 입니다.");
						return;
					}else{				//중복된 내용이 없다면 (잡명)
						rowsObj_job1 = [];
						rowsObj_job1.push({
							'grid_idx':i
						    ,'cond_paren_s': cond_paren_s
						    ,'cond_paren_e': cond_paren_e
							,'cond_nm': cond_nm
							,'cond_dt': cond_dt
							,'cond_gb': cond_gb
							,'chk_cond_nm': job_nm
						});

						gridObj_1.rows = rowsObj_job1;

						clearGridSelected(gridObj_1);		//선택된 전체항목 해제 */

						addGridRow(gridObj_1, {
							'grid_idx': (aSelRow.length+1)
							,'cond_paren_s': cond_paren_s
							,'cond_paren_e': cond_paren_e
							,'cond_nm': cond_nm
							,'cond_dt': cond_dt
							,'cond_gb': cond_gb
							,'chk_cond_nm': job_nm
						});
					}

				}else if(gb == "2"){

					var dup_cnt = 0;
					setGridSelectedRowsAll(gridObj_2);		//중복체크를 위해 전체항목 선택

					var aSelRow = new Array;
					aSelRow = $('#'+gridObj_2.id).data('grid').getSelectedRows();

					if(aSelRow.length>0){
						for(var j=0;j<aSelRow.length;j++){
							var v_cond_nm = getCellValue(gridObj_2,aSelRow[j],'chk_cond_nm');

							if(v_cond_nm == job_nm){
								++dup_cnt;
								break;
							}
						}
					}

					clearGridSelected(gridObj_2);		//선택된 전체항목 해제 */

					if(dup_cnt > 0){	//중복된 내용이 있다면 (잡명)
						alert("이미 등록된 내용 입니다.");
						return;
					}else{
						rowsObj_job2 = [];
						rowsObj_job2.push({
							'grid_idx':i
							,'cond_nm': cond_nm
							,'cond_dt': cond_dt
							,'cond_gb': cond_gb
							,'chk_cond_nm': job_nm
						});

						gridObj_2.rows = rowsObj_job2;

						clearGridSelected(gridObj_2);		//선택된 전체항목 해제 */
						
						if ( aSelRow.length == 0 ) {
							cond_nm = cond_nm.replace("<input ", "<input readOnly style='background-color:#efefef;width:100%;'");
							cond_dt = replaceAll(cond_dt, "<select ", "<select style='background-color:#efefef;width:70px;height:21px;' onFocus='this.initialSelect=this.selectedIndex;' onChange='this.selectedIndex=this.initialSelect;' ");
							cond_gb = replaceAll(cond_gb, "<select ", "<select style='background-color:#efefef;width:60px;height:21px;' onFocus='this.initialSelect=this.selectedIndex;' onChange='this.selectedIndex=this.initialSelect;' ");
						}

						addGridRow(gridObj_2, {
							'grid_idx':(aSelRow.length+1)
							,'cond_nm': cond_nm
							,'cond_dt': cond_dt
							,'cond_gb': cond_gb
							,'chk_cond_nm': job_nm
						});
					}
				}
		}

		//후행컨디션삭제
		function addConditionsOut() {
			popJobsForm('2');
		}
		function delConditionsOut() {

			var cnt = 0;
			var row_idx = 0;
			var aSelRow = new Array;
			aSelRow = $('#'+gridObj_2.id).data('grid').getSelectedRows();

			if(aSelRow.length>0){
				for(var i=0;i<aSelRow.length;i++){
					row_idx = getCellValue(gridObj_2,aSelRow[i],'grid_idx');

					++cnt;
				}
			}else{
				alert("삭제하려는 항목을 선택해 주세요.");
				return;
			}

			if(cnt > 1){
				alert("한개의 항목만 선택해 주세요.");
				return;
			}

			if (row_idx == 1) {
				alert("자기작업 CONDITION은 삭제할 수 없습니다.");
				return;
			}

			if(cnt == 1){
				if(confirm("선택한 항목을 삭제하시겠습니까?")){
					dataDel('gridObj_2', row_idx-1 , '2');
				}
			}
		}

		//선행컨디션삭제
		function delConditionsIn() {

			var cnt = 0;
			var row_idx = 0;
			var aSelRow = new Array;
			aSelRow = $('#'+gridObj_1.id).data('grid').getSelectedRows();

			if(aSelRow.length>0){
				for(var i=0;i<aSelRow.length;i++){
					row_idx = getCellValue(gridObj_1,aSelRow[i],'grid_idx');

					++cnt;
				}
			}else{
				alert("삭제하려는 항목을 선택해 주세요.");
				return;
			}

			if(cnt > 1){
				alert("한개의 항목만 선택해 주세요.");
				return;
			}

			if(cnt == 1){
				if(confirm("선택한 항목을 삭제하시겠습니까?")){
					dataDel('gridObj_1', row_idx-1, '1');
				}
			}
		}

		//선후행작업 삭제
		function dataDel(obj, row, gb){
			if(gb == '1'){
				var aSelRow = new Array;
				aSelRow = $('#'+gridObj_1.id).data('grid').getSelectedRows();

				if(aSelRow.length>0){
					for(var i=0;i<aSelRow.length;i++){
						delGridRowNoInv(gridObj_1,aSelRow[i]-i);
					}
				}
				clearGridSelected(gridObj_1)		//선택된 전체항목 해제 */
			}else if(gb == '2'){
				var aSelRow = new Array;
				aSelRow = $('#'+gridObj_2.id).data('grid').getSelectedRows();

				if(aSelRow.length>0){
					for(var i=0;i<aSelRow.length;i++){
						delGridRowNoInv(gridObj_2,aSelRow[i]-i);
					}
				}
				clearGridSelected(gridObj_2)		//선택된 전체항목 해제 */
			}
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

			xhr.sendRequestSync();
		}

		//입력변수 폼
		function popArgForm(flag){

			var sHtml1="<div id='dl_tmp1' style='overflow:hidden;display:none;padding:0;border-top:1px solid blue;border-bottom:1px solid blue;border-left:1px solid blue;border-right:1px solid blue;'>";
			sHtml1+="<form id='form1' name='form1' method='post' onsubmit='return false;'>";
			//sHtml1+="<input type='hidden' name='search_gubun' id='search_gubun' value='job_name' />";
			sHtml1+="<table style='width:100%;height:560px;;border:none;'><tr><td style='vertical-align:top;height:100%;width:500px;'>";
			//sHtml1+="날짜검색 : <input type='text' name='cur_date' id='cur_date' class='input datepick' onkeydown='return false;' readonly />&nbsp;&nbsp;<span id='btn_arg_search'>검색</span>";
			sHtml1+="변수명 <input type='text' name='arg_eng_nm' id='arg_eng_nm' />&nbsp;&nbsp;<span id='btn_arg_search'>검색</span>";

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

			dlPop01('dl_tmp1',"입력변수내역",570,600,false);

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
			var arg_eng_nm 	= $("#arg_eng_nm").val();
			argumentList(arg_eng_nm, dt, flag);

			$("#cur_date").addClass("ime_readonly").unbind('click').click(function(){
				dpCalMinMax(this.id,'yymmdd','-365','1');
			});

			$("#btn_arg_search").button().unbind("click").click(function(){
				var dt = $("#cur_date").val();
				var arg_eng_nm 	= $("#arg_eng_nm").val();
				argumentList(arg_eng_nm, dt, flag);
			});
		}

		function argumentList(arg_eng_nm, dt){

			try{viewProgBar(true);}catch(e){}
			$('#ly_total_cnt').html('');

			var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=argumentList&itemGubun=2&mcode_cd=${ARGUMENT_MCODE_CD}&cur_date='+dt+'&arg_eng_nm='+arg_eng_nm;

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
			lst_command = " " + desc2;;
			command += lst_command;
			$("#command").val(command);
			$("#arg_val").val(arg_val + " " + desc2);

			dlClose('dl_tmp1');

		}

		$("#btn_MonthDays_Desc").button().unbind("click").click(function(){
			month_days_div.style.display='block';
		});

		function fn_sch_forecast() {

			var frm = document.frm1;

			var obj = null;
			var s = "";
			var week_days_text = frm.week_days_text.value;

			s = "";
			for(var i=0;i<7;i++){
				obj = document.getElementById('chk_week_days_'+i);
				if(obj.checked){
					s += (s=="")? obj.value:(","+obj.value);
				}
			}

			if ( s == "" ) {
				s = week_days_text;
			} else {
				s = s + "," + week_days_text;
			}

			// 중복된 실행요일은 빼기 위해.
			if ( s != "" && s.indexOf(",")>-1 ) {

				var arrS = s.split(",");
				arrS.sort();

				var i = -1, j = arrS.length;

				while (++i < j-1) {
					if (arrS[i] == arrS[i+1]) {
						arrS[i] = '';
					}
				}

				s = arrS.toString();
				
				// - 옵션이 두개 이상이면 제거가 되는 현상때문에 정규식 제거 (2023.5.7 강명준)
				// 아래 정규식 왜 사용했는지 아시는 분 설명 좀 부탁..
				// 정규식 설명: 알파벳, 숫자, 언더스코어(_)에 대해서만 매칭을 수행
				//s = s.match(/\w+/g);
				
				// 체크박스와 텍스트박스 입력이 섞이면 ,, 로 되는 케이스가 있어서 ,, 를 하나로 변경 (2023.5.7 강명준)
				s = replaceAll(s, ",,", ",");
			}

			frm.week_days.value = s;

			//-- 작업스케줄 체크 Start. --//
			var month_days 	= document.getElementById('month_days');
			var days_cal 	= document.getElementById('days_cal');

			// 실행날짜 및 월캘린더 체크.(calendar.js)
			if ( fn_check_days(month_days, days_cal) == false ) {
				return;
			}

			var week_days 	= frm.week_days;
			var weeks_cal 	= document.getElementById('weeks_cal');

			// 실행요일 및 일캘린더 체크.(calendar.js)
			if ( fn_check_weeks(week_days, weeks_cal) == false ) {
				return;
			}
			//-- 작업스케줄 체크 End. --//

			openPopupCenter2("about:blank", "fn_sch_forecast", 1000, 500);

			frm.action = "<%=sContextPath %>/tWorks.ez?c=ez033";
			frm.target = "fn_sch_forecast";
			frm.submit();
		}

		function btnShow(doc_cd){

			$("#doc_cd").val(doc_cd);
			$("#btn_ins").hide();
			$("#btn_draft").hide();
			$("#btn_post_draft_u").hide();
			$("#btn_draft_admin").show();
		}

		//서버내역 가져오기
		function mHostList(grp_nm){

			try{viewProgBar(true);}catch(e){}

			var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=mHostList&itemGubun=2&grp_nm='+encodeURIComponent(grp_nm);

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

			xhr.sendRequestSync();
		}
		
		function valid_chk(flag){
			
			var frm = document.frm1;

			// 그리드 마지막 값 원복되는 현상 해결
			$('#'+gridObj_2.id).data('grid').getEditorLock().commitCurrentEdit();

			frm.flag.value = flag;
			frm.grp_approval_userList.value = grp_approval_userList;
			frm.grp_alarm_userList.value 	= grp_alarm_userList;

			var serverGb = '<%=strServerGb%>';
			var doc_gb = "04";

			var table_id 	= frm.table_id.value;
			var job_id 		= frm.job_id.value;
			var data_center = frm.data_center.value;
			var sched_table = frm.sched_table.value;

			if(flag!="del") {

				// 담당자 체크
				// SMS, 오토콜 중 한개는 필수
// 				checkUserInfo();	//2024.02.26 최호연 담당자 SMS,MAIL 체크로직 제거

				isValid_C_M();

				if ( document.getElementById('is_valid_flag').value == "false" ) {
					document.getElementById('is_valid_flag').value = ""
					return;
				}

				if( isNullInput(document.getElementById('host_id'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[수행서버]","") %>') ) return;
				if( isNullInput(document.getElementById('owner'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[계정명]","") %>') ) return;
				if( isNullInput(document.getElementById('task_type'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[작업타입]","") %>') ) return;
				if( isNullInput(document.getElementById('application'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[어플리케이션]","") %>') ) return;
				if( isNullInput(document.getElementById('group_name'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[그룹]","") %>') ) return;
				<%-- 			if( isNullInput(document.getElementById('sBatchJobGrade'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[작업등급]","") %>') ) return; --%>
				<%--
			if( isNullInput(document.getElementById('mem_lib'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[프로그램 위치]","") %>') ) return;
			if( isNullInput(document.getElementById('command'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[작업수행명령]","") %>') ) return;
			 --%>
				if (document.getElementById('task_type').value == 'command') {
					if( isNullInput(document.getElementById('command'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[작업수행명령]","") %>') ) return;
				} else if(document.getElementById('task_type').value == 'job') {
					if( isNullInput(document.getElementById('mem_name'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[프로그램 명]","") %>') ) return;
					if( isNullInput(document.getElementById('mem_lib'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[프로그램 위치]","") %>') ) return;
				}

				if( isNullInput(document.getElementById('max_wait'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[최대대기일]","") %>') ) return;
				var max_wait = Number($("#max_wait").val());
				if (max_wait < 0 || max_wait > 99 || max_wait !== max_wait) {
					alert("최대대기일 값이 올바르지 않습니다.");
					$("#max_wait").focus();
					return;
				}
				
				if($('#sub_table_of_def').val() != "") {
					if($('#sub_table_of_def').val() == 'sub_table_all') {
						alert("스마트폴더를 선택하였습니다. \n서브폴더를 선택해주세요.");
						return;
					}else {
						$('#table_name').val($('#sub_table_of_def').val());
					}
				}

				if ($("#priority").val() != "" && $("#priority").val().length != 2) {
					alert('<%=CommonUtil.getMessageSplit("ERROR.PARAM.03","[우선순위]","") %>');
					$("#priority").focus();
					return;
				}
				if(document.getElementById('task_type').value == 'job') {
					var mem_lib_val = $("#mem_lib").val();
					var mem_lib_f_chk = false;
					var mem_lib_l_chk = false;

					if ( mem_lib_val != "" ) {
						if ( mem_lib_val.substring(0, 1) == "/" ) {
							mem_lib_f_chk = true;
						}
						if ( mem_lib_val.length > 3 && mem_lib_val.substring(3, 2) == "\\" ) {
							mem_lib_f_chk = true;
						}
					}

					if ( mem_lib_val != "" ) {
						if ( mem_lib_val.substring(mem_lib_val.length-1, mem_lib_val.length) == "/" ) {
							mem_lib_l_chk = true;
						}
						if ( mem_lib_val.length > 3 && mem_lib_val.substring(mem_lib_val.length-2, mem_lib_val.length) == "\\\\" ) {
							mem_lib_l_chk = true;
						}
					}

					/*
				if(!mem_lib_f_chk) {
					alert("프로그램 위치는 절대 경로로 입력 해야 합니다. 시작글자(/,C:\\\\)");
					return;
				}

				if(!mem_lib_l_chk) {
					alert("프로그램 위치의 마지막은 / 혹은 \\\\ 로 끝나야 합니다.");
					return;
				}
				*/

					if( isNullInput(document.getElementById('mem_name'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[프로그램 명]","") %>') ) return;
				}

				//task_type이 kubernetes일때 필수값 체크
				if(document.getElementById('task_type').value == 'Kubernetes') {
					if (frm.get_pod_logs.value == ""){
						alert("Get Pod Logs 값을 선택해 주세요.");
						return;
					}
					
					if (frm.job_cleanup.value == ""){
						alert("Job Cleanup 값을 선택해 주세요.");
						return;
					}
					
					if (frm.yaml_file.value == ""){
						alert("Job Spec Yaml 파일을 선택해 주세요.");
						return;
					}
					
					if (frm.con_pro.value == ""){
						alert("Connection Profile 값을 선택해 주세요.");
						return;
					}
				}
				
				if(document.getElementById('task_type').value == 'Database') {
					var exeType = document.getElementById('execution_type').value;
					if(exeType == 'P'){
						if (frm.schema.value == ""){
							alert("Schema 값을 선택해 주세요.");
							return;
						}
						if (frm.sp_name.value == ""){
							alert("Name 값을 선택해 주세요.");
							return;
						}
					}else if(exeType == 'Q'){
						if (frm.query.value == ""){
							alert("Query 값을 선택해 주세요.");
							return;
						}
					}
					
					var chk_db_autocommit 		= $("#chk_db_autocommit").prop("checked");
					var chk_db_append_log 		= $("#chk_db_append_log").prop("checked");
					var chk_db_append_output 	= $("#chk_db_append_output").prop("checked");
					
					if(chk_db_autocommit){
						$('#db_autocommit').val("Y");
					}else{
						$('#db_autocommit').val("N");
					}
					if(chk_db_append_log){
						$('#append_log').val("Y");
					}else{
						$('#append_log').val("N");
					}if(chk_db_append_output){
						$('#append_output').val("Y");
					}else{
						$('#append_output').val("N");
					}
					
					var dbOutputFormat = document.getElementById('sel_db_output_format').value;
					
					if(dbOutputFormat == "C"){
						if( isNullInput(document.getElementById('csv_seperator'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[csv seperator]","") %>') ) return;
					}
				}

				if( isNullInput(document.getElementById('job_name'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[작업명]","") %>') ) return;
				if( isNullInput(document.getElementById('description'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[작업 설명]","") %>') ) return;

				if($("#cyclic").val() == "1"){

// 				if ( $("#frm1").find("select[name='eHour']").val() == "" && $("#frm1").find("select[name='eMin']").val() == "" ) {
// 					alert("반복작업은 종료시간을 입력해 주세요.");
// 					return;
// 				}

					// 반복작업이면 1분 이상.
					if ( frm.rerun_interval.value == "" && frm.interval_sequence.value == "" && frm.specific_times.value == "" ) {
						alert("반복옵션을 설정해 주세요.");
						return;
					}

					if ( frm.cyclic_type.value == "C" && frm.rerun_interval.value != "" ) {
						if ( replaceAll(frm.rerun_interval.value, "0", "") == "" ) {	// 반복주기가 0이면 무한 반복
							if ( replaceAll($("#rerun_max").val(), "0", "") == "" ) {	// 최대반복횟수를 지정해놓으면 체크 로직 예외 처리
								alert("반복주기를 확인해 주세요.");
								return;
							}
						}
					}

				} else if($("#cyclic").val() == "0" && ($("#frm1").find("select[name='eHour']").val() == "" && $("#frm1").find("select[name='eMin']").val() == "") ) {

// 				$("#time_until").val(">");
				}

				if( $("#late_exec").val() == "0" ) {
					alert("수행 임계시간은 1분 이상이어야 합니다.");
					return;
				}

				if($("#time_from").val() != ''){
					if($("#time_from").val().length < 4){
						alert("작업시작시간의 시, 분을 확인해주세요.");
						return;
					}
				}


				if($("#time_until").val() != '' && $("#time_until").val() != ">"){
					if($("#time_until").val().length < 4){
						alert("작업종료시간의 시, 분을 확인해주세요.");
						return;
					}
				}

				if($("#late_sub").val() != ''){
					if($("#late_sub").val().length < 4){
						alert("시작임계시간의 시, 분을 확인해주세요..");
						return;
					}
				}

				if($("#late_time").val() != ''){
					if($("#late_time").val().length < 4){
						alert("종료임계시간의 시, 분을 확인해주세요.");
						return;
					}
				}

				var time_from_t = parseInt($("#time_from").val());
				var late_time_t = parseInt($("#late_time").val());
				var late_sub_t = parseInt($("#late_sub").val());

				//if($("#time_group").val() == "00"){
				//alert("시작시간을 입력하세요");
				//}

				if( $("#late_sub").val() != "" ){
					if(time_from_t > late_sub_t){
						alert("시작 임계시간은 시작시간보다 큰 값을 입력 해야 합니다.");
						return;
					}
				}

				if( $("#late_time").val() != ""){
					if(time_from_t > late_time_t){
						alert("종료 임계시간은 시작시간보다 큰 값을 입력 해야 합니다.");
						return;
					}
				}

				if($("#late_sub").val() != "" && $("#late_time").val() != ""){
					if($("#late_sub").val() > $("#late_time").val()){
						alert("종료 임계시간은 시작임계시간보다 큰 값을 입력 해야 합니다.");
						return;
					}
				}
				
				//수행 범위일 정상입력 체크
				if($("#active_from").val() != "" && $("#active_till").val() != ""){
					if($("#active_from").val() > $("#active_till").val()){
						alert("수행 범위일의 시작날짜와 종료날짜를 확인해주세요.");
						return;
					}
				}

				if( isNullInput(document.getElementById('user_cd_1_0'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[담당자]","") %>') ) return;

				if( isNullInput(document.getElementById('critical_yn'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[중요작업]","") %>') ) return;
				
				// 후행 컨디션 1개이상 필수체크
				setGridSelectedRowsAll(gridObj_2);
				var aSelRow2 = new Array;
				aSelRow2 = $('#'+gridObj_2.id).data('grid').getSelectedRows();
				
				if ( aSelRow2.length == 0 ) {
					alert("후행작업조건의 CONDITION을 추가해주세요.");
					return;
				}
				clearGridSelected(gridObj_2);

				//선행 셋팅
				var all_data = "";
				var job_nm = "";
				var cond_dt = "";
				var cond_gb = "";
				var parentheses_s = "";
				var parentheses_e = "";

				setGridSelectedRowsAll(gridObj_1);
				var aSelRow = new Array;
				aSelRow = $('#'+gridObj_1.id).data('grid').getSelectedRows();

				if(aSelRow.length > 0){
					for(var i=0;i<aSelRow.length;i++){

						var grid1ChlidInput 	= $("#"+gridObj_1.id).find('.grid-canvas').children().eq(i).children().children().find('input');
						var grid1ChlidSelect 	= $("#"+gridObj_1.id).find('.grid-canvas').children().eq(i).children().children().find('select');
						
						parentheses_s		+= grid1ChlidSelect.eq(0).val();
						parentheses_e		+= grid1ChlidSelect.eq(1).val();

						//grid_idx = getCellValue(gridObj_1,aSelRow[i],"grid_idx");
						//job_nm = getCellValue(gridObj_1,aSelRow[i],"cond_nm");

						//if(grid_idx == 1) first_job_name = job_nm;

						//cond_dt = grid1ChlidSelect.eq(0).prop('name');
						//cond_gb = grid1ChlidSelect.eq(1).prop('name');

						if ( grid1ChlidInput.eq(0).val() != "" ) {
							all_data += grid1ChlidSelect.eq(0).val() + grid1ChlidInput.eq(0).val()+grid1ChlidSelect.eq(1).val() +"," + grid1ChlidSelect.eq(2).val() +","+ grid1ChlidSelect.eq(3).val() + "|";
						}
					}
				}
				if(parentheses_s == '('){
					if(parentheses_e != ')'){
						alert("선행조건명에 포함 된 '(' & ')'를 확인해주세요.");
						return;
						}
					}
					
				if(parentheses_e == ')'){
					if(parentheses_s != '('){
						alert("선행조건명에 포함 된 '(' & ')'를 확인해주세요.");
						return;
					}
				}

				clearGridSelected(gridObj_1);
				frm.t_conditions_in.value = all_data;

				//후행 세팅
				var first_job_name = "";
				all_data = "";
				setGridSelectedRowsAll(gridObj_2);
				var aSelRow = new Array;
				aSelRow = $('#'+gridObj_2.id).data('grid').getSelectedRows();

				if(aSelRow.length > 0){
					for(var i=0;i<aSelRow.length;i++){

						var grid2ChlidInput 	= $("#"+gridObj_2.id).find('.grid-canvas').children().eq(i).children().children().find('input');
						var grid2ChlidSelect 	= $("#"+gridObj_2.id).find('.grid-canvas').children().eq(i).children().children().find('select');

// 						grid_idx = getCellValue(gridObj_2,aSelRow[i],"grid_idx");
// 						job_nm = getCellValue(gridObj_2,aSelRow[i],"cond_nm");

// 						if(grid_idx == 1) first_job_name = job_nm;

// 						cond_dt = grid2ChlidSelect.eq(0).prop('name');
// 						cond_gb = grid2ChlidSelect.eq(1).prop('name');

						if ( grid2ChlidInput.eq(0).val() != "" ) {
							all_data += grid2ChlidInput.eq(0).val() +","+ grid2ChlidSelect.eq(0).val() +","+ grid2ChlidSelect.eq(1).val() + "|";
						}
					}
					
					if ( all_data != "" ) {
						all_data = all_data.substring(0, all_data.length - 1);
					}
				}

				clearGridSelected(gridObj_2);
				frm.t_conditions_out.value = all_data;
				
				s = "";

				var task_type 	= $("#task_type").val();
				var mem_name 	= $("#mem_name").val();
				var mem_lib 	= $("#mem_lib").val();

				var file_nm 	= mem_lib + mem_name;
				obj = document.getElementsByName('m_quantitative_res_name');

				if( obj!=null && obj.length>0 ){
					for( var i=0; i<obj.length; i++ ){
						if( trim(obj[i].value) != "" ){
							var sTmp = obj[i].value;
							if(document.getElementsByName('m_quantitative_required_usage')[i].value == ''){
								alert("[Required Usage]의 값을 입력해주세요");
								return;
							}
							sTmp += (","+document.getElementsByName('m_quantitative_required_usage')[i].value);
							s += (s=="")? sTmp:("|"+sTmp);
						} else {
							alert("RESOURCE의 [NAME]값을 입력해주세요");
							return;
						}
					}
					frm.t_resources_q.value = s;
				}
				s = "";
				obj = document.getElementsByName('m_var_name');
				if( obj!=null && obj.length>0 ){
					for( var i=0; i<obj.length; i++ ){
						if( trim(obj[i].value) != "" ){
							var sTmp = obj[i].value;
							sTmp += (","+document.getElementsByName('m_var_value')[i].value);

							if ( document.getElementsByName('m_var_value')[i].value == "" ) {
								//alert("[변수]의 Value를 확인해 주세요.");
								//return;
							}

							s += (s=="")? sTmp:("|"+sTmp);
						}
					}
					frm.t_set.value = s;
				}
				var t_set_var 	= $("#t_set").val();

				s = "";
				var v = 0;
				var sTmpChk = "";
				obj = document.getElementsByName('m_step_opt');
				if( obj!=null && obj.length>0 ){
					for( var i=0; i<obj.length; i++ ){
						if( trim(obj[i].value) != "" ){
							var sTmp = obj[i].value;
							
							if(i < obj.length -1 ){
								sTmpChk = obj[i+1].value;
							}

							if(obj[0].value == 'A' || obj[obj.length - 1].value == 'O'){
								alert("ON이 첫번째, DO가 마지막이어야합니다"); 
								return;
							}
							
							if(sTmp == sTmpChk && sTmp == 'O'){
								alert("ON 연속적으로 사용할 수 없습니다.");
								return;
							}
							
							if(sTmp == 'O'){
								sTmp = sTmp+',Statement'+',*';
							}

							sTmp += (","+document.getElementsByName('m_step_type')[i].value);

							var step_type = document.getElementsByName('m_step_type')[i].value;

							if(step_type == '' || step_type == null){
								alert('ON/DO TYPE을 선택해 주세요.');
								return;
							}

							if(step_type == 'COMPSTAT' || step_type == 'RUNCOUNT' || step_type == 'FAILCOUNT'){
								v = $('div[id^=div_step_parameters]').eq(i).prop('id').replace('div_step_parameters','');

								if(step_type != 'FAILCOUNT'){
									if( isNullInput(document.getElementById('m_step_statement_stmt'+v),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[Stmt]","") %>') ) return;
									var statement_stmt = document.getElementById('m_step_statement_stmt'+v).value;
								}

								if(statement_stmt == 'EVEN' || statement_stmt == 'ODD'){
									sTmp += (" EQ "+document.getElementById('m_step_statement_stmt'+v).value);
								}else{

									if( isNullInput(document.getElementById('m_step_statement_code'+v),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[Code]","") %>') ) return;
									if(step_type == 'COMPSTAT'){
										sTmp += (" "+document.getElementById('m_step_statement_stmt'+v).value+" "+document.getElementById('m_step_statement_code'+v).value);
									}else if(step_type == 'RUNCOUNT'){
										sTmp += (" "+document.getElementById('m_step_statement_stmt'+v).value+" "+document.getElementById('m_step_statement_code'+v).value);
									}else if(step_type == 'FAILCOUNT'){
										sTmp += (" EQ "+document.getElementById('m_step_statement_code'+v).value);
									}
								}

							}else if( step_type == "Statement" ){
								v = $('div[id^=div_step_parameters]').eq(i).prop('id').replace('div_step_parameters','');
								if( isNullInput(document.getElementById('m_step_statement_stmt'+v),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[Stmt]","") %>') ) return;
								if( isNullInput(document.getElementById('m_step_statement_code'+v),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[Code]","") %>') ) return;
								
								sTmp = obj[i].value+(","+step_type+","+document.getElementById('m_step_statement_stmt'+v).value);
								sTmp += (","+document.getElementById('m_step_statement_code'+v).value);
							}

							if( step_type == 'Condition' ){
								i = $('div[id^=div_step_parameters]').eq(i).prop('id').replace('div_step_parameters','');

								sTmp += (","+document.getElementById('m_step_condition_name'+i).value);
								sTmp += (","+document.getElementById('m_step_condition_date'+i).value);
								sTmp += (","+document.getElementById('m_step_condition_sign'+i).value);
							}else if( step_type == 'Shout' ){
								i = $('div[id^=div_step_parameters]').eq(i).prop('id').replace('div_step_parameters','');

								sTmp += (","+document.getElementById('m_step_dest'+i).value);
								sTmp += (",regular");
								sTmp += (","+document.getElementById('m_step_message'+i).value);
							}else if( step_type == "Mail" ){
								sTmp += (","+document.getElementById('m_step_mail_to'+i).value);
								sTmp += (","+document.getElementById('m_step_mail_cc'+i).value);
								sTmp += (","+document.getElementById('m_step_mail_subject'+i).value);
								sTmp += (","+document.getElementById('m_step_mail_urgn'+i).value);
								sTmp += (","+document.getElementById('m_step_mail_msg'+i).value);
							}else if( step_type == "Force-Job" ){
								sTmp += (","+document.getElementById('m_step_force-job_table'+i).value);
								sTmp += (","+document.getElementById('m_step_force-job_job_name'+i).value);
								sTmp += (","+document.getElementById('m_step_force-job_date'+i).value);
							}

							s += (s=="")? sTmp:("|"+sTmp);
						}
					}

					frm.t_steps.value = s;
				}

				if(frm.t_steps.value.indexOf("A,RERUN") > -1){
					if(confirm("ON/DO의 DO-재수행을 선택하면 최대 반복 횟수:99 권장입니다.\n설정하시겠습니까?\n\n(이후 최대 반복 횟수는 수동 설정해야 합니다.)")){
						$("#rerun_max").val("99");
					}
				}

				var doc_gb = '04';

				// 스마트테이블 여부 체크
				checkSmartTableCnt();

				// 실행 요일 로직 시작.
				var obj = null;
				var s = "";
				var week_days_text = frm.week_days_text.value;

				s = "";
				for(var i=0;i<7;i++){
					obj = document.getElementById('chk_week_days_'+i);
					if(obj.checked){
						s += (s=="")? obj.value:(","+obj.value);
					}
				}

				if ( s == "" ) {
					s = week_days_text;
				} else {
					s = s + "," + week_days_text;
				}

				// 중복된 실행요일은 빼기 위해.
				if ( s != "" && s.indexOf(",")>-1 ) {

					var arrS = s.split(",");
					arrS.sort();

					var i = -1, j = arrS.length;

					while (++i < j-1) {
						if (arrS[i] == arrS[i+1]) {
							arrS[i] = '';
						}
					}

					s = arrS.toString();
					
					// - 옵션이 두개 이상이면 제거가 되는 현상때문에 정규식 제거 (2023.5.7 강명준)
					// 아래 정규식 왜 사용했는지 아시는 분 설명 좀 부탁..
					// 정규식 설명: 알파벳, 숫자, 언더스코어(_)에 대해서만 매칭을 수행
					//s = s.match(/\w+/g);
					
					// 체크박스와 텍스트박스 입력이 섞이면 ,, 로 되는 케이스가 있어서 ,, 를 하나로 변경 (2023.5.7 강명준)
					s = replaceAll(s, ",,", ",");
				}

				frm.week_days.value = s;
				// 실행 요일 로직 종료.

				//-- 작업스케줄 체크 Start. --//
				var month_days 	= document.getElementById('month_days');
				var days_cal 	= document.getElementById('days_cal');

				// 실행날짜 및 월캘린더 체크.(calendar.js)
				if ( fn_check_days(month_days, days_cal) == false ) {
					return;
				}

				var week_days 	= frm.week_days;
				var weeks_cal 	= document.getElementById('weeks_cal');

				// 실행요일 및 일캘린더 체크.(calendar.js)
				if ( fn_check_weeks(week_days, weeks_cal) == false ) {
					return;
				}
				//-- 작업스케줄 체크 End. --//

				if ( document.getElementById('smart_cnt').value > 0 ) {
					if( !confirm("스마트 테이블 작업입니다.\n\n해당 작업은 스마트 테이블의 작업주기구분을 상속받습니다.") ) return;
				}

				// 정기, 수시 체크
				// 스케줄 정보가 입력 안되면 수시로 간주 (2020.07.20. 강명준)
				if ( month_days.value == "" && days_cal.value == "" && week_days.value == "" && weeks_cal.value == "" ) {
					document.getElementById('jobSchedGb').value = "2";
				} else {
					document.getElementById('jobSchedGb').value = "1";
				}

				var tasktype = document.getElementById('task_type').value;

				if(tasktype == "MFT"){
					var FTP_USE_DEF_NUMRETRIES_YN = $("#FTP_USE_DEF_NUMRETRIES_YN").prop("checked");
					var FTP_CONT_EXE_NOTOK_YN = $("#FTP_CONT_EXE_NOTOK_YN").prop("checked");
					var FTP_RPF_YN = $("#FTP_RPF_YN").prop("checked");

					if(FTP_USE_DEF_NUMRETRIES_YN){
						frm.FTP_USE_DEF_NUMRETRIES.value = 1;
					}else{
						frm.FTP_USE_DEF_NUMRETRIES.value = 0;
					}

					if(FTP_RPF_YN){
						frm.FTP_RPF.value = 1;
					}else{
						frm.FTP_RPF.value = 0;
					}

					if(FTP_CONT_EXE_NOTOK_YN){
						frm.FTP_CONT_EXE_NOTOK.value = 1;
					}else{
						frm.FTP_CONT_EXE_NOTOK.value = 0;
					}
				}else{

					var inputIds = [
						'FTP_LHOST', 'FTP_RHOST', 'FTP_LUSER', 'FTP_RUSER',
						'FTP_CONNTYPE1', 'FTP_CONNTYPE2', 'FTP_USE_DEF_NUMRETRIES',
						'FTP_RPF', 'FTP_CONT_EXE_NOTOK'
					];

					for (var i = 0; i < inputIds.length; i++) {
						var inputField = document.getElementById(inputIds[i]);
						if (inputField) {
							frm.removeChild(inputField);
						}
					}
				}
			}

			$("#frm1").find("input[name='p_apply_date']").val($("input[name='apply_date']").val());

			if(flag == 'draft_admin'){
				goPrc(flag,'','','');
			}else if(flag == 'udt'){
				goPrc(flag,'','','');
			}else if(flag == 'draft'){
				getAdminLineGrpCd(flag, '01');
			}
		}

		function goPrc(flag, grp_approval_userList, grp_alarm_userList, title){
			
			var frm = document.frm1;
			var grpJobChk = "<%=grpJobChk%>";
			
			frm.flag.value = flag;
			frm.title.value = title;
			frm.grp_approval_userList.value = grp_approval_userList;
			frm.grp_alarm_userList.value 	= grp_alarm_userList;

			if ( flag == "draft_admin" ) {
				if(grpJobChk == "Y"){
					if( !confirm("그룹에 등록되어 있는 작업입니다.\n즉시반영[관리자결재] 하시겠습니까?") ) return;
				}else{
					if( !confirm("즉시반영[관리자결재] 하시겠습니까?") ) return;
				}
			} else if ( flag == "draft" ) {
				if(grpJobChk == "Y") {
					if( !confirm("그룹에 등록되어 있는 작업입니다.\n승인요청 하시겠습니까?") ) return;
				}else{
					if (!confirm("승인요청 하시겠습니까?")) return;
				}
			} else if ( flag == "post_draft" ) {
				if(grpJobChk == "Y") {
					if( !confirm("그룹에 등록되어 있는 작업입니다.\n[후결]승인요청 하시겠습니까?") ) return;
				}else{
					if( !confirm("[후결]승인요청 하시겠습니까?") ) return;
				}
			}
			
			try{viewProgBar(true);}catch(e){}
			frm.target = "if1";
			frm.action = "<%=sContextPath%>/tWorks.ez?c=ez004_p";
			frm.submit();
		}

		function calList(){

			try{viewProgBar(true);}catch(e){}

			var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=searchItemList&itemGubun=2&searchType=days_calList';

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
								$("select[name='days_cal'] option").remove();
								$("select[name='days_cal']").append("<option value=''>--선택--</option>");

								$("select[name='weeks_cal'] option").remove();
								$("select[name='weeks_cal']").append("<option value=''>--선택--</option>");

								$("select[name='conf_cal'] option").remove();
								$("select[name='conf_cal']").append("<option value=''>--선택--</option>");
							}else{
								$("select[name='days_cal'] option").remove();
								$("select[name='days_cal']").append("<option value=''>--선택--</option>");

								$("select[name='weeks_cal'] option").remove();
								$("select[name='weeks_cal']").append("<option value=''>--선택--</option>");

								$("select[name='conf_cal'] option").remove();
								$("select[name='conf_cal']").append("<option value=''>--선택--</option>");

								items.find('item').each(function(i){

									var calendar = $(this).find("CALENDAR").text();

									$("select[name='days_cal']").append("<option value='"+calendar+"'>"+calendar+"</option>");
									$("select[name='weeks_cal']").append("<option value='"+calendar+"'>"+calendar+"</option>");
									$("select[name='conf_cal']").append("<option value='"+calendar+"'>"+calendar+"</option>");

								});
							}

						});
						try{viewProgBar(false);}catch(e){}
					}
					, null );

			xhr.sendRequest();
		}

		function addResourcesQ(){
			var obj = document.getElementById('resQTable');
			var idx=0;

			var lastDiv = $('div[id^=div_resq]:last').prop('id');

			if(lastDiv !== undefined){
				idx = Number(lastDiv.replace('div_resq',''))+1;
			}

			var s = "";
			s += "<tr>";
			s += "<td style='width:5%;height:21px;text-align:center;'>";
			s += "<input type='checkbox' name='idx_check_resq'>";
			s += "<input type='hidden' name='idxHidResQ' id='idxHidResQ' value='"+idx+"'/>"
			s += "</td>";
			s += "<td style='display:none;width:1px;height:21px;'><div class='cellTitle_kang2' id='div_resq"+idx+"'></div></td>"
			s += "<td style='width:8%;'><input type='text' class='input' name='m_quantitative_res_name' style='width:98%;height:21px;' maxlength='40'/></td>";
			s += "<td style='width:86%;'><input type='text' class='input' name='m_quantitative_required_usage' style='width:88%;height:21px;' maxlength='214'/>";
			s += "</tr>";

			$(obj).append(s);
		}


		function delResourcesQ(){

			if ( !$("input:checkbox[name='idx_check_resq']").is(':checked') ) {
				alert("삭제하려는 항목을 선택해 주세요.");
			}
			
			$("input:checkbox[name='idx_check_resq']").each(function(i){
				if($(this).prop('checked')){
					$(this).parent().parent().remove();
				}
			});

			$("input:checkbox[name='checkIdxAllResQ']").prop('checked', false);

		}

		function addUserVars(){
			var obj = document.getElementById('userVar');
			var idx=0;

			var lastDiv = $('div[id^=div_user_val]:last').prop('id');

			if(lastDiv !== undefined){
				idx = Number(lastDiv.replace('div_user_val',''))+1;
			}

			var s = "";
			s += "<tr>";
			s += "<td style='width:5%;height:21px;text-align:center;'>";
			s += "<input type='checkbox' name='idx_check'>";
			s += "<input type='hidden' name='idxHid' id='idxHid' value='"+idx+"'/>"
			s += "</td>";
			s += "<td style='display:none;width:1px;height:21px;'><div class='cellTitle_kang2' id='div_user_val"+idx+"'></div></td>"
			s += "<td style='width:8%;'><input type='text' class='input' name='m_var_name' style='width:98%;height:21px;' maxlength='40'/></td>";
			s += "<td style='width:86%;'><input type='text' class='input' name='m_var_value' style='width:88%;height:21px;' maxlength='214'/>";
			s += "</tr>";

			$(obj).append(s);
		}

		/* function delUserVars(idx){
		$('#userVar tr:nth-child(' + (idx+1) + ')').remove();
	} */

		function delUserVars(){

			if ( !$("input:checkbox[name='idx_check']").is(':checked') ) {
				alert("삭제하려는 항목을 선택해 주세요.");
			}
		
			$("input:checkbox[name='idx_check']").each(function(i){
				if($(this).prop('checked')){
					$(this).parent().parent().remove();
				}
			});

			$("input:checkbox[name='idxCheckAll']").prop('checked', false);

		}

		//담당자 조회 기능
		$('input[id^=user_nm_]').click(function(){
			var user_idx = $(this).attr('id').replace("user_nm_","").replace("_0","");
			goUserSearch(user_idx);
		}).unbind('keyup').keyup(function(e){
			if($(this).val() != '' && (this).data('sel_v') != $(this).val()){
				$('#sel_v').val();
				$(this).removeClass('input_complete');
			}
		});

		//담당자그룹 autocomplete 클릭 시 조회
		$('input[id^=grp_nm_]').click(function(){
			var user_idx = $(this).attr('id').replace("grp_nm_","");
			var smsDefault	= "<%=smsDefault%>";
			var mailDefault	= "<%=mailDefault%>";
			groupUserGroup("", user_idx, smsDefault, mailDefault);
		}).unbind('keyup').keyup(function(e){
			if($(this).val() != '' && (this).data('sel_v') != $(this).val()){
				$('#sel_v').val();
				$(this).removeClass('input_complete');
			}
		});

		//담당자그룹 autocomplete keypress 조회
		$('input[id^=grp_nm_]').unbind('keypress').keypress(function(e){
			var user_idx = $(this).attr('id').replace("grp_nm_","");
			if($(this).val() != '') {
				groupUserGroup($(this).val(), user_idx);
			}
		}).unbind('keyup').keyup(function(e){
			if($(this).val() != '' && (this).data('sel_v') != $(this).val()){
				$('#sel_v').val();
				$(this).removeClass('input_complete');
			}
		});

		//담당자삭제아이콘
		$('img[name^=btn_del]').unbind('click').click(function(){
			var del_idx = $(this).attr('name').replace("btn_del","")
			$("#user_nm_" + del_idx + "_0").val("");
			$("#user_cd_" + del_idx + "_0").val("");
			$("input:checkbox[name=sms_" + del_idx +"_0]:not(:disabled)").prop("checked", false);
			$("input:checkbox[name=mail_" + del_idx +"_0]:not(:disabled)").prop("checked", false);
		})

		//담당자그룹 삭제 버튼 시 비활성화 해제 및 배경색 변경
		$('img[name^=btn_grp_del]').unbind('click').click(function(){
			var del_idx = $(this).attr('name').replace("btn_grp_del","")
			$("#grp_nm_" + del_idx + "_0").val("");
			$("#grp_cd_" + del_idx + "_0").val("");
			$("#grp_nm_" + del_idx + "_0").attr('disabled', false);
			$("#grp_nm_" + del_idx + "_0").removeClass('input_complete');
			$("input:checkbox[name=grp_sms_" + del_idx +"_0]:not(:disabled)").prop("checked", false);
			$("input:checkbox[name=grp_mail_" + del_idx +"_0]:not(:disabled)").prop("checked", false);
		})

		function addSteps(){
			var obj = document.getElementById('onDoTable');
			var idx=0;

			var lastDiv = $('div[id^=div_step_type]:last').prop('id');

			if(lastDiv !== undefined){
				idx = Number(lastDiv.replace('div_step_type',''))+1;
			}

			var s = "";
			s += "<tr>";
			s += "<td style='width:4%;height:21px;text-align:center;'>";
			s += "<input type='checkbox' name='check_idx'>";
			s += "<input type='hidden' name='hidIdx' id='hidIdx' value='"+idx+"'/>"
			s += "</td>";
			s += "<td style='width:6%;height:21px;text-align:center;'>";
			s += "<select name='m_step_opt' onchange='setStepType(this.value,"+idx+");' style='width:98%;height:21px;'>";
			s += "<option value=''>--</option>";
			<%
		aTmp = CommonUtil.getMessage("JOB.STEP_OPT").split(",");
		for(int i=0;i<aTmp.length; i++){
			String[] aTmp1 = aTmp[i].split("[|]");
		%>
			s += "<option value='<%=aTmp1[0] %>'><%=aTmp1[1] %></option>";
			<%}%>
			s += "</select>";
			s += "</td>";

			s += "<td style='width:6%;height:21px;text-align:center;'><div id='div_step_type"+idx+"'>&nbsp;<input type='hidden' name='m_step_type' onchange='setStepOnParameters(this.value,"+idx+");' /></div></td>";
			s += "<td style='width:60%;height:21px;text-align:left;'><div id='div_step_parameters"+idx+"'>&nbsp;</div></td>";
			s += "</tr>";

			$(obj).append(s);
		}

		function delSteps(){

			if ( !$("input:checkbox[name='check_idx']").is(':checked') ) {
				alert("삭제하려는 항목을 선택해 주세요.");
			}
			
			$("input:checkbox[name='check_idx']").each(function(i){
				if($(this).prop('checked')){
					$(this).parent().parent().remove();
				}
			});

			$("input:checkbox[name='checkIdxAll']").prop('checked', false);

		}
		function setStepType(v,idx){
			var obj1 = document.getElementById('div_step_type'+idx);
			var obj2 = document.getElementById('div_step_parameters'+idx);

			var s1 = "";
			var s2 = "";
			if( v=="O" ){
				s1 += "<select name='m_step_type' onchange='setStepOnParameters(this.value,"+idx+");' style='width:95%;height:21px;'>";
				s1 += "<option value=''>--선택--</option>";
				<%
			aTmp = CommonUtil.getMessage("TABLE.STEP_ON_TYPE").split(",");
			for(int i=0;i<aTmp.length; i++){
				String[] aTmp1 = aTmp[i].split("[|]");
			%>
				s1 += "<option value='<%=aTmp1[1] %>'><%=aTmp1[0] %></option>";
				<%}%>
				s1 += "</select>";

				/* s2 += " Stmt=<input class='input' type='text' name='m_step_statement_stmt' maxlength='132' />";
			s2 += " Code=<input class='input' type='text' name='m_step_statement_code' maxlength='132' />"; */
			}else if( v=="A" ){
				s1 += "<select name='m_step_type' onchange='setStepParameters(this.value,"+idx+");' style='width:95%;height:21px;'>";
				s1 += "<option value=''>--선택--</option>";
				<%
			aTmp = CommonUtil.getMessage("TABLE.STEP_DO_TYPE").split(",");
			for(int i=0;i<aTmp.length; i++){
				String[] aTmp1 = aTmp[i].split("[|]");
			%>
				s1 += "<option value='<%=aTmp1[1] %>'><%=aTmp1[0] %></option>";
				<%}%>
				s1 += "</select>";
				s2 += "&nbsp;";
			}else{
				s1 += "&nbsp;<input type='hidden' name='m_step_type'  />";
				s2 += "&nbsp;";
			}

			obj1.innerHTML = s1;
			obj2.innerHTML = s2;
		}

		function setStepParameters(v,idx){
			var obj = document.getElementById('div_step_parameters'+idx);

			var s = "";
			if(v == 'Condition'){
				s += "&nbsp; Name=<input class='input' type='text' name='m_step_condition_name"+idx+"' id='m_step_condition_name"+idx+"' maxlength='255' />";
				s += " Date=<input class='input datepick' type='text' name='m_step_condition_date"+idx+"' id='m_step_condition_date"+idx+"' maxlength='4' size='4' onClick=\"this.value='';\" onDblClick=\"this.value='ODAT';\" />";
				s += " Sign=<select name='m_step_condition_sign"+idx+"' id='m_step_condition_sign"+idx+"' style='width:55px;'>";
				<%
			aTmp = CommonUtil.getMessage("JOB.STEP_SIGN").split(",");
			for(int i=0;i<aTmp.length; i++){
				String[] aTmp1 = aTmp[i].split("[|]");
			%>
				s += "<option value='<%=aTmp1[0] %>'><%=aTmp1[1] %></option>";
				<%}%>
				s += "</select>";


			}else if(v == 'Shout'){
				s += "&nbsp; Dest=<input class='input' type='text' name='m_step_dest"+idx+"' id='m_step_dest"+idx+"'/>";
				s += " Message=<input class='input' type='text' name='m_step_message"+idx+"' id='m_step_message"+idx+"' style='width:400px;'/>";

			}else if(v == 'Mail'){
				//s += " Dest=<input class='input' type='text' name='m_step_dest"+idx+"' id='m_step_dest"+idx+"'/>";
				//s += " Message=<input class='input' type='text' name='m_step_message"+idx+"' id='m_step_message"+idx+"' style='width:400px;'/>";

				s += "&nbsp; To=<input class='input' type='text' name='m_step_mail_to"+idx+"' id='m_step_mail_to"+idx+"' size='13' />";
				s += " Cc=<input class='input' type='text' name='m_step_mail_cc"+idx+"' id='m_step_mail_cc"+idx+"' size='13' />";
				s += " Subject=<input class='input' type='text' name='m_step_mail_subject"+idx+"' id='m_step_mail_subject"+idx+"'  />";
				s += " Urgn=<select name='m_step_mail_urgn"+idx+"' id='m_step_mail_urgn"+idx+"' style='height:21;'>";
				<%
			aTmp = CommonUtil.getMessage("JOB.STEP_URGENCY").split(",");
			for(int i=0;i<aTmp.length; i++){
				String[] aTmp1 = aTmp[i].split("[|]");
			%>
				s += "<option value='<%=aTmp1[0] %>'><%=aTmp1[1] %></option>";
				<%}%>
				s += "</select>";
				s += " Msg=<textarea name='m_step_mail_msg"+idx+"' id='m_step_mail_msg"+idx+"' style='vertical-align:middle;width:300;height:21;'></textarea>";


			}else if(v == 'Force-Job'){
				s += "&nbsp; 폴더=<input class='input' type='text' name='m_step_force-job_table"+idx+"' id='m_step_force-job_table"+idx+"' />";
				s += " 작업명=<input class='input' type='text' name='m_step_force-job_job_name"+idx+"' id='m_step_force-job_job_name"+idx+"' />";
				s += " ORDER DATE=ODAT:<input type='checkbox' id='m_step_force-job_date_chk"+idx+"' name='m_step_force-job_date_chk"+idx+"' onClick='chkForceOdate(this, "+idx+")'/> <input class='input datepick' type='text' name='m_step_force-job_date"+idx+"' id='m_step_force-job_date"+idx+"' onClick=\"this.value='';$('#m_step_force-job_date_chk"+idx+"').prop('checked', false);dpCalMin(this.id,'ymmdd');\" maxlength='6' size='6' />";
			}

			$(obj).html(s);

			/* $("#m_step_condition_date"+idx).addClass("ime_readonly").unbind('click').click(function(){
			dpCalMinMax(this.id,'mmdd');
		});	 */

		}

		function setStepOnParameters(v,idx){

			var obj = document.getElementById('div_step_parameters'+idx);

			var s = "";
			if(v == 'COMPSTAT' || v == 'RUNCOUNT'){

				s += " Stmt=<select name='m_step_statement_stmt"+idx+"' id='m_step_statement_stmt"+idx+"' onchange='setStepOnStmt(this.value,"+idx+");' style='width:95px;'> ";

				s += "<option value=''>--선택--</option>";
				<%
			aTmp = CommonUtil.getMessage("TABLE.STEP_ON_PARAMETERS").split(",");
			for(int i=0;i<aTmp.length; i++){
				String[] aTmp1 = aTmp[i].split("[|]");
			%>
				s += "<option value='<%=aTmp1[1] %>'><%=aTmp1[0] %></option>";
				<%}%>

				s += "</select>";
				s += " Code=<input class='input' type='text' name='m_step_statement_code"+idx+"' id='m_step_statement_code"+idx+"' maxlength='132' />";

			}else if(v == 'FAILCOUNT'){
				s += " Code=<input class='input' type='text' name='m_step_statement_code"+idx+"' id='m_step_statement_code"+idx+"' maxlength='132' />";
			}else if(v == 'Statement'){
				s += " Stmt=<input class='input' type='text' name='m_step_statement_stmt"+idx+"' id='m_step_statement_stmt"+idx+"' maxlength='132' />";
				s += " Code=<input class='input' type='text' name='m_step_statement_code"+idx+"' id='m_step_statement_code"+idx+"' maxlength='132' />";
			}

			$(obj).html(s);
		}

		function setStepOnStmt(v,idx){

			var obj = document.getElementById('div_step_parameters'+idx);
			if(v == 'EVEN' || v == 'ODD'){
				$(obj).find('select[name=m_step_statement_stmt'+idx+']').next('input').remove();
				$(obj).html($(obj).html().replace(' Code=', ' '));
				$(obj).find('select[name=m_step_statement_stmt'+idx+']').val(v);
			}else{
				var s = "";

				$(obj).find('select[name=m_step_statement_stmt'+idx+']').next('input').remove();
				$(obj).html($(obj).html().replace(' Code=', ' '));

				var objHtml  = $(obj).html();
				$(obj).html("");
				s = " Code=<input class='input' type='text' name='m_step_statement_code"+idx+"' id='m_step_statement_code"+idx+"' maxlength='132' />";
				$(obj).html(objHtml+s);

				$(obj).find('select[name=m_step_statement_stmt'+idx+']').val(v);


			}

		}

		function popupDocVersionCompare(job_name) {

			var frm = document.f_s;

			var doc_cd = '<%=doc_cd %>';
			job_name = '<%=job_name%>';
			var table_id = '<%=table_id%>';
			var job_id 	 = '<%=job_id%>';
			frm.job.value 	= job_name;
			frm.doc_cd.value 	= doc_cd;
			frm.table_id.value 	= table_id;
			frm.job_id.value 	= job_id;

			openPopupCenter("about:blank","popupJobDocCompareInfo",800,900);

			frm.action = "<%=sContextPath %>/mPopup.ez?c=jobDocCompareInfo";
			frm.target = "popupJobDocCompareInfo";
			frm.submit();
		}

		function popupCalendarDetail(calendar){

			if(calendar==''){
				alert("<%=CommonUtil.getMessageSplit("ERROR.PARAM.02","[캘린더]","") %>");
				return;
			}

			var frm = document.frm1;

			var data_center = frm.data_center.value;
			var year = "<%=CommonUtil.getCurDate("Y") %>";

			var vUrl = "<%=sContextPath %>/common.ez?c=ez101&data_center="+data_center+"&calendar="+encodeURIComponent(calendar)+"&year="+year;

			openPopupCenter1(vUrl,"popupCalendarDetail",900,500);
		}

		function CalDetail() {

			var data_center = $("#data_center").val();
			if(data_center == ""){
				alert("C-M 을 선택해 주세요.");
				return;
			}

			fn_sch_forecast();
		}

		function setTimeoutValueSet() {
			var group_name 		= $("#group_name").val();
			var node_id 		= $("#node_id").val();
			var owner 			= $("#v_owner").val();
			var task_type 		= "<%=strTaskType%>";
			var confirm_flag	= "<%=strConfirmFlag%>";
			var success_sms_yn	= "<%=strSuccessSmsYn%>";
			var days_cal		= "<%=strDays_cal%>";
			var weeks_cal		= "<%=strWeeks_cal%>";
			var priority		= "<%=strPriority%>";
			var conf_cal		= "<%=strConfCal%>";
			var shift			= "<%=strShift%>";
			var shift_num		= "<%=intShiftNum%>";
			
			//alert("정상 조회되었습니다.");

			setTimeout(function(){
				var selected_app_grp_cd	= $("#application_of_def option:selected").val().split(",")[0]; //그룹 조회 파라미터.
				if (selected_app_grp_cd != "")
					getAppGrpCodeList("group_name_of_def", "3", group_name, selected_app_grp_cd); //어플리케이션 코드로 그룹 조회 및 그룹 선택.
					$("select[name='group_name_of_def']").append("<option value='direct'>직접입력</option>");
					$("#group_names").hide();
				$("select[name='task_type']").val(task_type);
				$("select[name='priority']").val(priority);
				$("select[name='confirm_flag']").val(confirm_flag);
				$("select[name='success_sms_yn']").val(success_sms_yn);
				$("select[name='days_cal']").val(days_cal);
				$("select[name='weeks_cal']").val(weeks_cal);
				$("select[name='host_id']").val(node_id);
				$("select[name='owner']").val(owner);

				if($("#grp_nm_1_0").val() != ""){
					$("#grp_nm_1_0").removeClass('input_complete').addClass('input_complete');
					$("#grp_nm_1_0").attr("disabled", true);
				}
				if($("#grp_nm_2_0").val() != ""){
					$("#grp_nm_2_0").removeClass('input_complete').addClass('input_complete');
					$("#grp_nm_2_0").attr("disabled", true);
				}
				$("#conf_cal").val(conf_cal);
				$("#shift").val(shift);
				$("#shift_num").val(shift_num);
			}, 1000);
		}
		
		function selectTable(eng_nm, desc, user_daily, grp_cd, task_type, table_id){ 

			$("#table_nm").val(eng_nm);
			$("#table_of_def").val(eng_nm);
			$("#table_name").val(eng_nm);
			$("#user_daily").val(user_daily);
			
			$("input[name='application']").val("");
			$("input[name='group_name']").val("");
			
			dlClose("dl_tmp1"); 

			//수행서버 검색
			mHostList(eng_nm);
			
			//어플리케이션을 검색	
			getAppGrpCodeList("application_of_def", "2", "", grp_cd);
			
			//그룹초기화
			$("select[name='group_name_of_def'] option").remove();
			$("select[name='group_name_of_def']").append("<option value=''>--선택--</option>");
			
			//스마트폴더 초기화
			$("select[name='sub_table_of_def'] option").remove();
			$("select[name='sub_table_of_def']").append("<option value=''>--선택--</option>");
			
			//스마트폴더 일 경우
			document.getElementById('sub_table_of_def').style.display = 'none';
			if(task_type == "SMART Table") {
				document.getElementById('sub_table_of_def').style.display = 'inline';
				getSubTableList("sub_table_of_def", table_id, eng_nm);
			}
			
			// 어플이 하나만 존재하면 자동 세팅
			if($("select[name='application_of_def'] option").length == 2){
				$("select[name='application_of_def'] option:eq(1)").prop("selected", true);
				
				var grp_info = $("select[name='application_of_def']").val().split(",");
				$("#application").val(grp_info[1]);
				
				if (grp_info != "") {
					getAppGrpCodeList("group_name_of_def", "3", "", grp_info[0]);
				} else {
					getAppGrpCodeList("group_name_of_def", "3", "", "");
				}

				$("select[name='group_name_of_def']").append("<option value='direct'>직접입력</option>");
				$("#group_names").hide();
				// 그룹이 하나만 존재하면 자동 세팅
				if($("select[name='group_name_of_def'] option").length == 2 || $("select[name='group_name_of_def'] option").length == 3){
					$("select[name='group_name_of_def'] option:eq(1)").prop("selected", true);


					var group_name = $("select[name='group_name_of_def']").val();
					if(	group_name == "direct"){
						$("#group_names").show();
					}else{
						$("#group_names").hide();
					}

					grp_info = $("select[name='group_name_of_def']").val().split(",");
					$("#group_name").val(grp_info[1]);
			}
		}

			//수행서버 초기화
			$("#node_id").val("");
			
			//계정명 초기화
			$("select[name='owner'] option").remove();
			$("select[name='owner']").append("<option value=''>--선택--</option>");
			
			// 수행서버 데이터 목록이 1개일때 자동 셋팅 
			if($("select[name='host_id'] option").length == 2){
				$("select[name='host_id'] option:eq(1)").prop("selected", true);
				$("#v_owner").val("");
				
				var data_center = $("#frm1").find("input[name='data_center']").val();
				var host_id = $("select[name='host_id'] option:selected").val();
				$("#node_id").val(host_id);
				
				sCodeList(data_center, host_id);
				
				// 계정명 목록이 1개일때 자동 셋팅
				if($("select[name='owner'] option").length == 2 ){
					$("select[name='owner'] option:eq(1)").prop("selected", true);
				}
			}
			
		}

		// 선후행 조건을 직접 입력할 수 있게 변경 (2023.04.09 강명준)
		// 안쓰는 로직으로 주석처리(2024.09.24 김은희)
		/*function addConditions(gb, job_nm, cond, and_or, add) {

			var cond_nm = "";
			var cond_dt = "";
			var cond_gb = "";
			var i 		= 0;
			var val 	= "";
			
			if(gb == "in"){
				i = rowsObj_job1.length+1;
				val = "_in_cond_nm"+i;
			}else if(gb == "out"){
				i = rowsObj_job2.length+1;
				val = "_outcond_nm"+i;
			}

			if ( cond == "" ) {
				cond 	= "ODAT";
			}
			if ( and_or == "" ) {
				and_or 	= "and";
			}
			if ( add == "" ) {
				add 	= "add";
			}
			
			cond_nm = "";
			cond_nm += "<div class='gridInput_area'><input type='text' name='job"+val+"' id='job"+val+"' value='"+job_nm+"' style='width:100%;' ></div>";

			cond_dt = "";
			cond_dt += "<div class='gridInput_area'>";
			cond_dt += "<select name='dt"+val+"' id='dt"+val+"'style='width:80px;height:21px;'>";
			if(gb == "in"){
				<c:forTokens var="in_cond_dt" items="${IN_COND_DT}" delims=",">
				if(cond == "${in_cond_dt}"){
					cond_dt += "<option value='${in_cond_dt}' selected>${fn:toUpperCase(in_cond_dt)}</option>";
				} else {
					cond_dt += "<option value='${in_cond_dt}'>${fn:toUpperCase(in_cond_dt)}</option>";
				}
				</c:forTokens>
			}else if(gb == "out"){
				<c:forTokens var="out_cond_dt" items="${OUT_COND_DT}" delims=",">
				if(cond == "${out_cond_dt}"){
					cond_dt += "<option value='${out_cond_dt}' selected>${fn:toUpperCase(out_cond_dt)}</option>";
				} else {
					cond_dt += "<option value='${out_cond_dt}'>${fn:toUpperCase(out_cond_dt)}</option>";
				}
				</c:forTokens>
			}

			cond_dt += "</select>";
			cond_dt += "</div>";

			cond_gb = "";
			cond_gb += "<div class='gridInput_area'>";
			cond_gb += "<select name='gb"+val+"' id='gb"+val+"'style='width:65px;height:21px;'>";

			if(gb == "in"){
				<c:forTokens var="in_cond_and_or" items="${IN_COND_AND_OR}" delims=",">
				if(and_or == "${in_cond_and_or}"){
					cond_gb += "<option value='${in_cond_and_or}' selected>${fn:toUpperCase(in_cond_and_or)}</option>";
				} else {
					cond_gb += "<option value='${in_cond_and_or}'>${fn:toUpperCase(in_cond_and_or)}</option>";
				}
				</c:forTokens>
			}else if(gb == "out"){
				<c:forTokens var="out_cond_effect" items="${OUT_COND_EFFECT}" delims=",">
				if(and_or == "${out_cond_effect}"){
					cond_gb += "<option value='${out_cond_effect}' selected>${fn:toUpperCase(out_cond_effect)}</option>";
				} else {
					cond_gb += "<option value='${out_cond_effect}'>${fn:toUpperCase(out_cond_effect)}</option>";
				}
				</c:forTokens>
			}

			cond_gb += "</select>";
			cond_gb += "</div>";
			
			if(gb == "in"){
			
				setGridSelectedRowsAll(gridObj_1);
				aSelRow = $('#'+gridObj_1.id).data('grid').getSelectedRows();
				clearGridSelected(gridObj_1)
		
				addGridRow(gridObj_1, {
					'grid_idx': (aSelRow.length+1)
					,'cond_nm': cond_nm
					,'cond_dt': cond_dt
					,'cond_gb': cond_gb
					/!* ,'chk_cond_nm': job_nm *!/
				});
				
			}else if(gb == "out"){
				
				setGridSelectedRowsAll(gridObj_2);
				aSelRow = $('#'+gridObj_2.id).data('grid').getSelectedRows();
				clearGridSelected(gridObj_2)
		
				addGridRow(gridObj_2, {
					'grid_idx': (aSelRow.length+1)
					,'cond_nm': cond_nm
					,'cond_dt': cond_dt
					,'cond_gb': cond_gb
					/!* ,'chk_cond_nm': job_nm *!/
				});
			}
		}*/
		
		function accountPopupList() {
			
			var node_id 		= document.getElementById('node_id').value;
			var data_center 	= document.getElementById('data_center').value;
			
// 	 		if ( node_id == "" ) {
// 	 			alert("수행서버를 먼저 선택해 주세요.");
// 	 			return;
// 	 		}
			
			
			ftp_use_def_numretries_check();

			var frm = document.frm1;
			
			openPopupCenter1("popupConPro","popupConPro",1200,300);
			
			frm.action = "<%=sContextPath %>/tPopup.ez?c=ez007";
			frm.target = "popupConPro";
			frm.submit();
		}
		
		function clearMft() {
			
			document.getElementById('FTP_ACCOUNT').value = "";
			document.getElementById("host11").innerText = 'HOST1 :   TYPE :   User : ';
			document.getElementById("host21").innerText = 'HOST2 :   TYPE :   User : ';
			
			$("#FTP_RPF_YN").prop("checked", false);
			$("#FTP_CONT_EXE_NOTOK_YN").prop("checked", false);
			$("#FTP_USE_DEF_NUMRETRIES_YN").prop("checked", true);
			
			var input = null;
			for(var key in accountlist) {
				input = '#' + accountlist[key];
				$(input).val('');
				if($(input).attr("type") == 'checkbox') {
					$(input).attr("checked", false);
				}
			}
			for(var i=1; i <= 5; i++) {
				for(var key in pathlist) {
					input = '#' + pathlist[key] + i;
					$(input).val('');
				}

				for(var key in advancedlist) {
					input = '#' + advancedlist[key] + i;
					$(input).remove();
				} 
			}
			$("#FTP_USE_DEF_NUMRETRIES").val("1");
			document.frm1.FTP_USE_DEF_NUMRETRIES.checked = true;
			ftp_use_def_numretries_check();
		}
		
		function ftp_use_def_numretries_check() {
			var frm = document.frm1;
			if(frm.FTP_USE_DEF_NUMRETRIES_YN.checked == true) {
				frm.FTP_NUM_RETRIES.readOnly = true;
				frm.FTP_NUM_RETRIES.style.backgroundColor = '#e2e2e2';
				frm.FTP_NUM_RETRIES.value = 5;
			} else {
				frm.FTP_NUM_RETRIES.readOnly = false;
				frm.FTP_NUM_RETRIES.style.backgroundColor = 'white';
			}
		}
		
		//kubernetes 파일 선택 후 파일 내용 읽어서 file_content에 저장
		document.getElementById('file_name').addEventListener('change', function(event) {
		    var file = event.target.files[0];
		    if (file) {
		        var reader = new FileReader();
		        reader.onload = function(e) {
		            var content = e.target.result;
		            document.getElementById('file_content').value = content;
		            document.getElementById('cont_encode_yn').value = 'N';
		        };
		        reader.onerror = function(e) {
		            alert("File could not be read! Code " + e.target.error.code);
		        };
		        reader.readAsText(file); // 파일을 텍스트 형식으로 읽기
		    } else {
		    	alert("No file selected");
		    }
		});
		function sp_parameter(return_value, in_parameters){
			
			$('#param_header_tr').nextUntil('#db_q_tr').remove();
			$("#param_tr").show();
			$("#param_header_tr").show();
			
			
			var obj = document.getElementById('param_header_tr');
			var ret_name, ret_data, ret_param;
			var in_name, in_data, in_param;
			
			var idx=0;
			var lastDiv = $('div[id^=div_param]:last').prop('id');
			var s = "";
			
			if(return_value != ""){
				var ret_arr = return_value.split(",");
				for(var i=0; i<ret_arr.length; i++){
					var ret_arr2 = ret_arr[i].trim().split(" ");
					
					ret_param 	= ret_arr2[0];
					ret_name 	= ret_arr2[1];
					ret_data 	= ret_arr2[2];
					
					if(ret_data == "integer"){
						ret_data = "int4";
					}
					
					if(ret_param == 'OUT'){
						ret_param = "Out";
					}
					
					
					s += "<tr>";
					s += "<td colspan='2' width='30%' style='text-align:center;'>";
					s += "<div class='cellContent_kang_center'>";
					s += ret_name;
					s += "<input type='hidden' name='ret_data"+idx+"' id='ret_data"+idx+"'   value='"+ret_data+"'>";
					s += "<input type='hidden' name='ret_name"+idx+"' id='ret_name"+idx+"'   value='"+ret_name+"'>";
					s += "<input type='hidden' name='ret_param"+idx+"' id='ret_param"+idx+"' value='"+ret_param+"'>";
					s += "<input type='hidden' name='idxHidParam' id='idxHidParam' value='"+idx+"'/>"
					s += "</div>";
					s += "</td>";
					s += "<div id='div_param"+idx+"'></div>"
					s += "<td width='10%' style='text-align:center;'><div class='cellContent_kang_center'>"+ret_param+"</div></td>";
					s += "<td width='20%' style='text-align:center;'><div class='cellContent_kang_center'>"+ret_data+"</div></td>";
					s += "<td width='10%' style='text-align:center;'></td>";
					s += "<td width='20%' style='text-align:center;'><div class='cellContent_kang_center'><input type='text' class='input' name='ret_variable"+idx+"' id='ret_variable"+idx+"' style='width:88%;height:21px;' maxlength='214' /></div></td>";
					s += "</tr>";
					
					idx++;
				}
			}else{
				ret_param 	= "void";
				ret_name 	= "returnValue";
				ret_data 	= "Return";
				
				s += "<tr>";
				s += "<td colspan='2' width='30%' style='text-align:center;'>";
				s += "<div class='cellContent_kang_center'>";
				s += ret_name;
				s += "<input type='hidden' name='ret_data"+idx+"' id='ret_data"+idx+"'   value='"+ret_data+"'>";
				s += "<input type='hidden' name='ret_name"+idx+"' id='ret_name"+idx+"'   value='"+ret_name+"'>";
				s += "<input type='hidden' name='ret_param"+idx+"' id='ret_param"+idx+"' value='"+ret_param+"'>";
				s += "<input type='hidden' name='idxHidParam' id='idxHidParam' value='"+idx+"'/>"
				s += "</div>";
				s += "</td>";
				s += "<div id='div_param"+idx+"'></div>"
				s += "<td width='10%' style='text-align:center;'><div class='cellContent_kang_center'>"+ret_param+"</div></td>";
				s += "<td width='20%' style='text-align:center;'><div class='cellContent_kang_center'>"+ret_data+"</div></td>";
				s += "<td width='10%' style='text-align:center;'></td>";
				s += "<td width='20%' style='text-align:center;'><div class='cellContent_kang_center'><input type='text' class='input' name='ret_variable"+idx+"' id='ret_variable"+idx+"' style='width:88%;height:21px;' maxlength='214' /></div></td>";
				s += "</tr>";
				idx++;
			}
			if(in_parameters != ""){
				var in_arr = in_parameters.split(",");
				for(var i=0; i<in_arr.length; i++){
					
					var in_arr2 = in_arr[i].trim().split(" ");
					
					in_param 	= in_arr2[0];
					in_name 	= in_arr2[1];
					in_data 	= in_arr2[2];
					if(in_data == "integer"){
						in_data = "int4";
					}
					if(in_param == 'IN'){
						in_param = "In";
					}
									
					s += "<tr>";
					s += "<td colspan='2' width='30%' style='text-align:center;'>";
					s += "<div class='cellContent_kang_center'>";
					s += in_name;
					s += "<input type='hidden' name='in_data"+idx+"' id='in_data"+idx+"'   value='"+in_data+"'>";
					s += "<input type='hidden' name='in_name"+idx+"' id='in_name"+idx+"'   value='"+in_name+"'>";
					s += "<input type='hidden' name='in_param"+idx+"' id='in_param"+idx+"' value='"+in_param+"'>";
					s += "<input type='hidden' name='idxHidParam' id='idxHidParam' value='"+idx+"'/>"
					s += "</div>";
					s += "</td>";
					s += "<div id='div_param"+idx+"'></div>"
					s += "<td width='10%' style='text-align:center;'><div class='cellContent_kang_center'>"+in_param+"</div></td>";
					s += "<td width='20%' style='text-align:center;'><div class='cellContent_kang_center'>"+in_data+"</div></td>";
					s += "<td width='10%' style='text-align:center;'><div class='cellContent_kang_center'><input type='text' class='input' name='in_value"+idx+"' id='in_value"+idx+"' style='width:88%;height:21px;' maxlength='214' /></div></td>";
					s += "<td width='20%' style='text-align:center;'></td>";
					s += "</tr>";
					idx++;
				}
			}
			
			$(obj).after(s);
		}
		

		function download(doc_cd){
			
			var f = document.frm1;		
			
			f.target = "if1";			
			f.action = "<%=sContextPath %>/common.ez?c=yamlFileDownload"; 
			f.submit();
		
		}
		
</script>
<%@include file="/jsp/common/inc/progBar.jsp"  %>
<iframe name="if1" id="if1" width="0" height="0"></iframe>
</div>
</body>
</html>