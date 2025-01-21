<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/jsp/common/inc/header.jsp"%>
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
<link href="<%=request.getContextPath() %>/css/slick-default-theme.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath() %>/js/poshytip-1.2/tip.css" rel="stylesheet" type="text/css" />

<style type="text/css">
<!--
	
//-->
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
<script type="text/javascript" src="<%=request.getContextPath() %>/js/SlickGrid-2.1.0/plugins/slick.checkboxselectcolumn2.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/SlickGrid-2.1.0/plugins/slick.rowselectionmodel.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/SlickGrid-2.1.0/slick.dataview.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/SlickGrid-2.1.0/slick.grid.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/SlickGrid-2.1.0/slick.editors.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/poshytip-1.2/jquery.poshytip.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/works_common.js?v=<%=jsVersion %>" ></script>
</head>
<%
	Map<String, Object> paramMap 	= CommonUtil.collectParameters(request);
	String c = CommonUtil.isNull(paramMap.get("c"));
	String gridId_1 = "g_"+c+"_1";
	String gridId_2 = "g_"+c+"_2";
	String gridId_4 = "g_"+c+"_4";

	String referer = CommonUtil.isNull(request.getHeader("referer"));
	
	List databaseList				= (List)request.getAttribute("databaseList");
	JobDefineInfoBean docBean		= (JobDefineInfoBean)request.getAttribute("aJobInfo");
	String strPageGubun				= (String)request.getAttribute("page_gubun");
	String strDataCenter 			= CommonUtil.isNull(paramMap.get("data_center"));
	
	String strOrderId	 		= "";
	String strTableName 		= "";
	String strApplication 		= "";
	String strGroupName 		= "";
	String strMemName 			= "";
	String strMemLib 			= "";
	String strOwner 			= "";
	String strTaskType 			= "";
	String strJobName			= "";
	String strMaxWait 			= "";
	String strDescription 		= "";
	String strConfirmFlag 		= "";
	String strTimeFrom 			= "";
	String strTimeUntil			= "";
	String strPriority 			= "";
	String strRerunMax 			= "";
	String strCmdLine 			= "";
	String strCritical			= "";	
	String strCyclic 			= "";
	String strRerunInterval		= "";
	String strNodeId	 		= "";
	String strTconditionsIn		= "";
	String strTconditionsOut	= "";
	String strTset				= "";
	String strCyclicType		= "";
	String strIntervalSequence	= "";
	String strConfirmFlagMent 	= "";
	String strCriticalMent		= "";
	String strCyclicMent		= "";
	String strOdate		 		= "";
	String strCpuId		 		= "";
	String strSpecificTimes		= "";
	String strCalendarNm		= "";
	
	String[] aTmp 				= null;
	String[] aTmpT 				= null;
	
	String strCmdLineTemp 		= "";
	String strArgument 			= "";
	
	String strCycleMent			= "";
	String strapplType			= "";
	
	if ( docBean != null ) {
		
		strOrderId	 		= CommonUtil.isNull(docBean.getOrder_id());
		strTableName		= CommonUtil.isNull(docBean.getTable_name());
		strApplication 		= CommonUtil.isNull(docBean.getApplication());
		strGroupName 		= CommonUtil.isNull(docBean.getGroup_name());
		strMemName 			= CommonUtil.isNull(docBean.getMem_name());
		strMemLib 			= CommonUtil.isNull(docBean.getMem_lib());
		strOwner 			= CommonUtil.isNull(docBean.getOwner());
		strTaskType 		= CommonUtil.isNull(docBean.getTask_type());
		strJobName 			= CommonUtil.isNull(docBean.getJob_name());
		strMaxWait 			= CommonUtil.isNull(docBean.getMax_wait());
		strDescription 		= CommonUtil.isNull(docBean.getDescription());
		strConfirmFlag 		= CommonUtil.isNull(docBean.getConfirm_flag());
		strTimeFrom 		= CommonUtil.isNull(docBean.getTime_from());
		strTimeUntil		= CommonUtil.isNull(docBean.getTime_until());
		strPriority 		= CommonUtil.isNull(docBean.getPriority());
		strRerunMax 		= CommonUtil.isNull(docBean.getRerun_max());
		strCmdLine 			= CommonUtil.replaceHtmlStr(CommonUtil.E2K(CommonUtil.isNull(docBean.getCommand())));
		strCritical 		= CommonUtil.isNull(docBean.getCritical());
		strCyclic 			= CommonUtil.isNull(docBean.getCyclic());
		strCyclicType 		= CommonUtil.E2K(docBean.getCyclic_type());
		strIntervalSequence = CommonUtil.E2K(docBean.getInterval_sequence());
		strSpecificTimes 	= CommonUtil.E2K(docBean.getSpecific_times());
		strRerunInterval	= CommonUtil.isNull(docBean.getRerun_interval());
		strNodeId 			= CommonUtil.isNull(docBean.getNode_id());
		strTconditionsIn	= CommonUtil.isNull(docBean.getT_conditions_in());
		strTconditionsOut	= CommonUtil.isNull(docBean.getT_conditions_out());
		strTset				= CommonUtil.isNull(docBean.getT_set());
		strOdate			= CommonUtil.isNull(docBean.getOdate());
		strCpuId			= CommonUtil.isNull(docBean.getCpu_id());		
		strCalendarNm		= CommonUtil.isNull(docBean.getCalendar_nm());
		strapplType			= CommonUtil.isNull(docBean.getAppl_type());

		strTset				=	strTset.replaceAll("\"", "\'");

		if(strTaskType.equals("Job")){
			strTaskType = "script";
		}

		if ( !strCmdLine.equals("") ) {
			strCmdLineTemp = strCmdLine.replaceAll("\"", "\\\\\"");
		}
		
		if ( strConfirmFlag.equals("0") || strConfirmFlag.equals("") ) {
			strConfirmFlagMent = "N";			
		} else {
			strConfirmFlagMent = "Y";
		}
		
		if ( strCritical.equals("0") || strCritical.equals("") ) {
			strCriticalMent = "N";
		} else {
			strCriticalMent = "Y";
		}
		
		if ( strCyclic.equals("0") || strCyclic.equals("") ) {
			strCyclicMent = "N";
		} else {
			strCyclicMent = "Y";
		}
		
		if ( !strRerunInterval.equals("") ) {
			strRerunInterval = strRerunInterval.replaceAll("M", "");
		}
		
		if ( strTimeUntil.equals(">") ) {
			strTimeUntil = "";
		}
		
		if ( !strOdate.equals("") ) {
			strOdate = strOdate.substring(2, 6);
		}
		
		if ( !strCpuId.equals("") ) {
			strNodeId = strCpuId;
		}
		
		if ( !strCmdLine.equals("") && strCmdLine.indexOf(" ") > -1 ) {
			strArgument = strCmdLine.substring(strCmdLine.indexOf(" ")+1, strCmdLine.length());
		}
		
		if ( strCyclicType.equals("C") ) {
			strCycleMent = "반복주기 : " + strRerunInterval + " (분단위) ";
		} else if ( strCyclicType.equals("V") ) {
			strCycleMent = "반복주기(불규칙) : " + strIntervalSequence + " (분단위) ";
		} else if ( strCyclicType.equals("S") ) {
			strCycleMent = "시간지정 : " + strSpecificTimes + " (HHMM) ";
		}	
	}
	
	// 작업명령어 수정 비활성 문자 코드
	List sCommandList = (List)request.getAttribute("sCommandList");
	List sParmList	  = (List)request.getAttribute("sParmList");
	String strInactiveCmd = "";
	String strActiveCmd   = "";
	
	if(strTaskType.equals("Command")) {
		// 비활성화코드 적용
		for( int i = 0; i < sCommandList.size(); i++ ) {
			String scode_command = (String)sCommandList.get(i);
			
			if( strCmdLine.indexOf(scode_command) > -1 && strInactiveCmd.indexOf(scode_command) == -1){
				if(strCmdLine.length() == scode_command.length()){ //실행명령어와 비활성화 명령어의 길이가 같을 때
					strInactiveCmd = scode_command + " ";
					strActiveCmd   = "";
				}else { 
					String temp = strCmdLine.substring(scode_command.length(), scode_command.length()+1);
					if(temp.equals(" ")) {
						strInactiveCmd = scode_command + " ";
						strActiveCmd = strCmdLine.substring(strInactiveCmd.length(), strCmdLine.length());
					}
				}
			}
		}
		
		// 비활성화코드가 적용된게 없고 코드관리에 PARM이라는 데이터가 있을경우
		if( strInactiveCmd.equals("") && sParmList.size() > 0 ) {
			String parm_nm = "";
			
			for(int i = 0; i < sParmList.size(); i++){
				if(parm_nm.equals("")) {
					parm_nm = (String)sParmList.get(i);
				}else {
					String temp = (String)sParmList.get(i);
					String parm_val_1 = parm_nm.substring(4, parm_nm.length());
					String parm_val_2 = temp.substring(4, temp.length());
					
					if(Integer.parseInt(parm_val_1) < Integer.parseInt(parm_val_2)) parm_nm = temp; 
				}
			}
			String parm_number = parm_nm.substring(4, parm_nm.length());
			String[] arrCmdLine = strCmdLine.split(" ");
			
			for(int i = 0; i < arrCmdLine.length; i++) {
				if( i <= Integer.parseInt(parm_number)) {
					strInactiveCmd += arrCmdLine[i] + " ";
				}else {
					strActiveCmd += arrCmdLine[i];
					if( i < arrCmdLine.length -1 ){
						strActiveCmd += " ";
					}
				}
			}
		}
	}
	
	String strServerGb 		= CommonUtil.isNull(CommonUtil.getMessage("SERVER_GB"));
	
	// 세션값 가져오기.
	String strSessionUserGb	= S_USER_GB;	
	
	List setvarList	  = (List)request.getAttribute("setvarList");

	if(strapplType.equals("KBN062023")){
		strTaskType = "Kubernetes";
	}else if(strapplType.equals("FILE_TRANS")){
		strTaskType = "MFT";
	}else if(strapplType.equals("DATABASE")){
		strTaskType = "Database";
	}
	
	//Database 값 세팅
	String var_name			= "";
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
			System.out.println("var_name : " + var_name);
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
			if(var_name.equals("DB-ACCOUNT")){
				db_con_pro = commonBean.getVar_value();
			}else if(var_name.equals("DB-DB_TYPE")){
				database_type = commonBean.getVar_value();
			}else if(var_name.equals("DB-EXEC_TYPE")){
				execution_type = commonBean.getVar_value();
				if(execution_type.equals("Open Query")){
					execution_type = "Q"; 
				}else if(execution_type.equals("Stored Procedure")){
					execution_type = "P"; 
	}
			}else if(var_name.equals("DB-STP_SCHEM")){
				schema = commonBean.getVar_value();
			}else if(var_name.equals("DB-STP_NAME")){
				sp_name = commonBean.getVar_value();
			}else if(var_name.equals("DB-QTXT-N001-SUBQTXT")){
				query = commonBean.getVar_value();
				query = query.replaceAll("&amp;", "&").replaceAll("&lt;", "<").replaceAll("&gt;", ">").replaceAll("%4E", "\n");
				query = query.replaceAll("<br>", "\n");
				query = query.replace("\\n", "\n");
									
				System.out.println("query : " + query);
			/*}else if(var_name.equals("DB-STP_PARAMS-P001-PRM_NAME")){
				
			}else if(var_name.equals("DB-STP_PARAMS-P001-PRM_TYPE")){
				
			}else if(var_name.equals("DB-STP_PARAMS-P001-PRM_DIRECTION")){
				
			}else if(var_name.equals("DB-STP_PARAMS-P001-PRM_SETVAR")){*/
	
			}else if(var_name.equals("DB-AUTOCOMMIT")){
				db_autocommit = commonBean.getVar_value();
			}else if(var_name.equals("DB-APPEND_LOG")){
				append_log = commonBean.getVar_value();
			}else if(var_name.equals("DB-APPEND_OUTPUT")){
				append_output = commonBean.getVar_value();
			}else if(var_name.equals("DB-OUTPUT_FORMAT")){
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
			}else if(var_name.equals("DB-CSV_SEPERATOR")){
				csv_seperator = commonBean.getVar_value();
			}
			
		}
	}
	
%>

<body>

<form id="f_s" name="f_s" method="post" onsubmit="return false;">	
	<input type="hidden" name="p_data_center" id="p_data_center" />
	<input type="hidden" name="p_application" id="p_application" />
	<input type="hidden" name="p_group_name_of_def" id="p_group_name_of_def" />	
	<input type="hidden" name="p_search_gubun" id="p_search_gubun" />
	<input type="hidden" name="p_search_text" id="p_search_text" />
</form>

<form id='frm1' name='frm1' method='post' onsubmit='return false;'>
	<input type="hidden" name="is_valid_flag" id="is_valid_flag"/>
	<input type="hidden" name="order_id" />
	<input type="hidden" name="t_conditions_in" id="t_conditions_in" />
	<input type="hidden" name="t_conditions_out" id="t_conditions_out"  />
	<input type="hidden" name="t_set" id="t_set"  />
	
	<input type="hidden" name="task_type" 		value="<%=strTaskType%>" id="task_type" />
	<input type="hidden" name="data_center" 	value="<%=strDataCenter%>" />
	<input type="hidden" name="job_name"	 	value="<%=strJobName%>" />
		
	<!-- <input type='hidden' id='command' name="command" /> -->
	<input type='hidden' id='command_param' name="command_param" />

	<!-- 선행 검색 시 data_center 비교 위해 필요 -->
	<input type="hidden" name="doc_data_center" 	id="doc_data_center"/>

	<!-- MFT 정보 -->
	<input type='hidden' name='FTP_VALUE' 			id='FTP_VALUE' 		value='' />
	<input type='hidden' name='FTP_LHOST' 			id='FTP_LHOST' 		value='' />
	<input type='hidden' name='FTP_RHOST' 			id='FTP_RHOST' 		value='' />
	<input type='hidden' name='FTP_LOSTYPE' 		id='FTP_LOSTYPE' 	value='' />
	<input type='hidden' name='FTP_ROSTYPE' 		id='FTP_ROSTYPE' 	value='' />
	<input type='hidden' name='FTP_LUSER' 			id='FTP_LUSER' 		value='' />
	<input type='hidden' name='FTP_RUSER' 			id='FTP_RUSER' 		value='' />
	<input type='hidden' name='FTP_CONNTYPE1' 		id='FTP_CONNTYPE1' 	value='' />
	<input type='hidden' name='FTP_CONNTYPE2' 		id='FTP_CONNTYPE2' 	value='' />
	
<table style='width:99%;height:100%;border:none;padding-left:15px; overflow-x:hidden;overflow-y:hidden;'>
	<tr style='height:10px;'>
		<td style='vertical-align:top;'>
			<h4 class="ui-widget-header ui-corner-all">
				<div class='title_area' style="width:100%; text-align:left;">
					<span><%=CommonUtil.getMessage("POPUP.REAL_JOB_INFO.TITLE") %></span>
				</div>				
			</h4>
		</td>
	</tr>
	<tr><td height="5px;"></td></tr>

	<tr valign="top">
		<td valign="top" style="height:100%;">
			<table style="width:100%;">
			<colgroup>
				<col width="20%" />
				<col width="30%" />
				<col width="20%" />
				<col width="30%" />
			</colgroup>
				<tr>
					<th class='cellTitle_ez_right'>작업명</th>
					<td><div class='cellContent_popup' style="height:auto;"><%=strJobName%></div></td>
					<th class='cellTitle_ez_right'>작업타입</th>
					<td><div class='cellContent_popup' style="height:auto;"><%=strTaskType%></div></td>
				</tr>
				<tr>
					<th class='cellTitle_ez_right' style='margin-right:20px;'>작업 설명</th>
					<td rowspan="2" colspan="3"><div class='cellContent_popup' style='height:auto;word-break:break-all;'><%=strDescription%></div></td>
				</tr>				
				<tr></tr>
				<tr>
					<th class='cellTitle_ez_right'>어플리케이션</th>
					<td>
						<div class='cellContent_popup'>
							<%=strApplication%>
							<input type='hidden' id='application' name='application' value='<%=strApplication%>' style='width:96%; height:21px;' maxlength='20' readOnly /> 
						</div>
					</td>
					
					<th class='cellTitle_ez_right'>그룹</th>
					<td>
						<div class='cellContent_popup'>
							<%=strGroupName%>
							<input type='hidden' id='group_name' name='group_name' value='<%=strGroupName%>' style='width:96%; height:21px;' maxlength='64' readOnly />
						</div>
					</td>
				</tr>
				<tr>
					<th class='cellTitle_ez_right'>수행서버</th>
					<td>
						<div class='cellContent_popup'>
							<input type='text' id='node_id' name='node_id' value='<%=strNodeId%>' style='width:96%; height:21px;' maxlength='50' /> 
						</div>
					</td>
					
					<th class='cellTitle_ez_right'>계정명</th>
					<td>
						<div class='cellContent_popup'>
							<%=strOwner%>
							<input type='hidden' id='owner' name='owner' value='<%=strOwner%>' style='width:96%; height:21px;' maxlength='30' readOnly />
						</div>
					</td>
				</tr>
				<tr>
					<th  class='cellTitle_ez_right'>프로그램 명</th>
					<td>
						<div class='cellContent_popup'>
<%-- 							<%=strMemName%> --%>
<%-- 							<input type='hidden' id='mem_name' name='mem_name' value='<%=strMemName%>' style='width:96%; height:21px;' maxlength='64' onkeypress='if(event.keyCode==32) event.returnValue = false;' style='ime-mode:disabled;' readOnly /> --%>
<%-- 							<input type='text' id='mem_name' name='mem_name' value="<%=strMemName%>" style='width:99%; height:21px;' /> --%>
							<div style="width:90%;word-break:break-all;"><%=strMemName%></div> 
						</div>
					</td>
					
					<th class='cellTitle_ez_right'>프로그램 위치</th>
					<td>
						<div class='cellContent_popup' style="height:auto;">
<%-- 							<%=strMemLib%> --%>
<%-- 							<input type='text' id='mem_lib' name='mem_lib' value='<%=strMemLib%>' style='width:96%; height:21px;' maxlength='255' onkeypress='if(event.keyCode==32) event.returnValue = false;' style='ime-mode:disabled;' readOnly /> --%>
<%-- 							<input type='text' id='mem_lib' name='mem_lib' value="<%=strMemLib%>" style='width:99%; height:21px;' /> --%>
							<div style="width:90%;word-break:break-all;"><%=strMemLib%></div>
						</div>
					</td>
				</tr>
				<tr>
					<th  class='cellTitle_ez_right'>최대대기일</th>
					<td>
						<div class='cellContent_popup'>
							<%=strMaxWait%>
							<input type='hidden' id='max_wait' name='max_wait' value='<%=strMaxWait%>' size='4' maxlength='2' style='width:96%; height:21px;' onkeypress='if(event.keyCode==32 || event.keyCode==39) event.returnValue = false;' style='ime-mode:disabled;' readOnly /> 
						</div>
					</td>
				</tr>					
				<tr>
					<th  class='cellTitle_ez_right'>시작 및 종료시간</th>
					<td colspan="3">
						<div class='cellContent_popup'>
							<input type='text' id='time_from' name='time_from' value='<%=strTimeFrom%>' size='6' maxlength='4' style='height:21px;' onkeypress='if(event.keyCode==32 || event.keyCode==39) event.returnValue = false;' style='ime-mode:disabled;' /> to 
							<input type='text' id='time_until' name='time_until' value='<%=strTimeUntil%>' size='6' maxlength='4' style='height:21px;' onkeypress='if(event.keyCode==32 || event.keyCode==39) event.returnValue = false;' style='ime-mode:disabled;' />
							<font color="red" >※ 종료시간은 기본 >로 설정됩니다.</font>
						</div>
					</td>
					
					
				</tr>
				<%-- <tr>
					<th><div class='cellTitle_kang2'>변수</div></th>
					<td colspan="3">
						<div class='cellContent_kang'>
						
						<% 	// 운영, 운영자일 경우 Argument 수정 불가. 
							if ( strSessionUserGb.equals("02") && strServerGb.equals("P") ) {
						%>
								<%=strArgument%>
						<%	
							} else {
						%>							
								<input type='text' id='arg_val' name='arg_val' value="<%=strArgument%>" style='width:70%; height:21px;' />
								<span id='btn_argmt_add'>Argument</span>
						<%
							}
						%>
							
						</div>
					</td>
				</tr> --%>
				<tr>
					<th  class='cellTitle_ez_right'>작업수행명령</th>
					<td colspan="3">
						<div style="display:flex;width:90%;word-break:break-all; padding-left:5px;align-items: center;">
							<%-- <%=strCmdLine%> --%>
							<!-- <input type='text' id='command_only' name='command_only' value="<%=strCmdLine%>" style='width:99%; height:21px;' readOnly /> -->
							<%-- <input type='hidden' id='command' name='command' value="<%=strCmdLine%>" style='width:99%; height:21px;' readOnly /> --%>
							<%
							if(!strInactiveCmd.equals("")) {
							%>
								<span id='inactive_command' name='inactive_command' style='white-space: nowrap;' ><%=strInactiveCmd%></span>&nbsp;
								<input type='text' id='active_command' name='active_command' value="<%=strActiveCmd%>" style='width:100%; height:21px;' />
								<input type='hidden' id='command' name='command' />
							<%
							}else{
							%>
								<input type='text' id='command' name='command' value="<%=strCmdLine%>" style='width:99%; height:21px;' />
							<%
							}
							%>
						</div>
					</td>
				</tr>
				<tr>
					<th  class='cellTitle_ez_right'>반복작업</th>
					<td>
						<%
							String strcyclMent = "";
							strcyclMent = strCyclicMent;
							if(strCyclicMent.equals("Y")){
								strcyclMent = strCyclicMent +" "+strCycleMent;
							}
						
						%>
						<div class='cellContent_popup'  title="<%=strcyclMent%>" style="word-break: break-all;height:auto;overflow-x:hidden;overflow-y:hidden;">
							<%
// 								if(strcyclMent.length() > 30){
// 									if(strCyclicMent.equals("Y")){
// 										out.println(strcyclMent);
// 									}else{
// 										out.println(strCyclicMent);
// 									}
// 								}else{
// 									out.println(strCyclicMent);
// 									if(strCyclicMent.equals("Y")){
// 										out.println(strCycleMent);
// 									}
// 								}
							
							%>
<!-- 							<select id='cyclic' name='cyclic' style="height:21px;display:none;" > -->
							<select id='cyclic' name='cyclic' style="height:21px;" onChange='fn_cyclic_set(this.value);'>
								<%
									aTmp = CommonUtil.getMessage("JOB.CYCLIC").split(",");
									for(int i=0;i<aTmp.length; i++){
										String[] aTmp1 = aTmp[i].split("[|]");	
								%>	
											<option value='<%=aTmp1[0]%>' <%= ( (aTmp1[0].equals(strCyclic))? " selected ":"" ) %> ><%=aTmp1[1]%></option>
								<%
									}	
								%>	
							</select>
						</div>
					</td>
					
					<th  class='cellTitle_ez_right'>최대 반복 횟수</th>
					<td>
						<div class='cellContent_popup'>
<%-- 							<%=strRerunMax%> --%>
							<input type='text' id='rerun_max' name='rerun_max' class='input' value='<%=strRerunMax%>' size='1' maxlength='2' style='  height:21px;' onkeypress='if(event.keyCode==32 || event.keyCode==39) event.returnValue = false;' style='ime-mode:disabled;' />
							<input type='hidden' id='rerun_interval' name='rerun_interval' value="<%=strRerunInterval%>" size='5' maxlength='5' style='width:96%; height:21px;' onkeypress='if(event.keyCode==32 || event.keyCode==39) event.returnValue = false;' style='ime-mode:disabled;' readOnly />
						</div>
					</td>
				</tr>
				<% if(strTaskType.equals("MFT")){ %>
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
										<input class='input' type='text' id='FTP_ACCOUNT'  name='FTP_ACCOUNT' style='width:50%' onClick='accountPopupList();' readonly/>
									</td>
								</tr>
								<tr>
									<td></td>
									<td style='text-align:center;'>
										<label for='FTP_USE_DEF_NUMRETRIES' style='width:50%'>
											<input type='checkbox' name='FTP_USE_DEF_NUMRETRIES' id='FTP_USE_DEF_NUMRETRIES' value='1' disabled/> 
											Use default number of retries&nbsp;&nbsp;&nbsp;&nbsp;
										</label>
										Number of retries :
										<input class='input' type='text' id='FTP_NUM_RETRIES' name='FTP_NUM_RETRIES' value='5' style='background-color: #e2e2e2;' placeholder='(0~99 number)' />
									</td>
									<td style='text-align:center;'>
										<label for='FTP_RPF'>
											<input type='checkbox' name='FTP_RPF' id='FTP_RPF' value='1' /> 
												Rerun from point of failure
										</label>
									</td>
									<td style='text-align:center;'>
										<label for='FTP_CONT_EXE_NOTOK'><input type='checkbox' name='FTP_CONT_EXE_NOTOK' id='FTP_CONT_EXE_NOTOK' value='1' /> 
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
				<% } %>
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
											<input name="con_pro" id="con_pro" style="width:78%;height:21px;ime-mode:disabled;" readonly/>
										</div>
									</td>
									<td>
										<div class='cellTitle_ez_right'>Job Spec Type</div>
									</td>
									<td>
										<div class='cellContent_kang'>
											<input name = "job_spec_type" id='job_spec_type' style="width:50%;height:21px;" value="Local file" readonly/>
										</div>
									</td>
									<td>
										<div class='cellTitle_ez_right'>Job Spec Yaml</div>
									</td>
									<td>	
										<div class='cellContent_kang'>
											<input type="text" name='yaml_file' id='yaml_file' style="width:190px; height:21px;" readonly />
										</div>
									</td>
								</tr>
								<tr>
									<td>
										<div class='cellTitle_ez_right'>Job Spec Parameter</div>
									</td>
									<td colspan="3">
										<div class='cellContent_kang'>
											<input type="text" name="spec_param" id="spec_param" style="width:85%;height:21px;" readonly/>
										</div>
									</td>
									<td>
										<div class='cellTitle_ez_right'>OS Exit Code</div>
									</td>
									<td>	
										<div class='cellContent_kang'>
											<input type="text" id='os_exit_code' name='os_exit_code'  style="width:85%;height:21px;" readonly/>
										</div>
									</td>
								</tr>
								<tr>
									<td>
										<div class='cellTitle_ez_right'>Get Pod Logs</div>
									</td>
									<td>
										<div class='cellContent_kang'>
											<input type="text" name="get_pod_logs" id="get_pod_logs" style="width:85%;height:21px;" readonly/>
										</div>
									</td>
									<td>
										<div class='cellTitle_ez_right'>Job Cleanup</div>
									</td>
									<td>
										<div class='cellContent_kang'>
											<input type="text" name="job_cleanup" id="job_cleanup"  style="width:60%;height:21px;ime-mode:disabled;" readonly/>
										</div>
									</td>
									<td>
										<div class='cellTitle_ez_right'>Polling Interval</div>
									</td>
									<td>
										<div class='cellContent_kang'>
											<input type="text" name="polling_interval" id="polling_interval" style="width:60%;height:21px;ime-mode:disabled;" readonly/>
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
									<td width="20%"></td>
									<td width="15%"></td>
									<td width="15%"></td>
									<td width="15%"></td>
									<td width="15%"></td>
									<td width="25%"></td>
								</tr>
								<tr>
									<td>
										<div class='cellTitle_ez_right'>Connection Profile</div>
									</td>
									<td>
										<div class='cellContent_kang'>
										<input type="hidden" name="db_con_pro" id="db_con_pro" value="<%=db_con_pro %>" />
											<%=db_con_pro %>
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
												
												out.println(!strDatabaseName.equals("") ? strDatabaseName : (!strSid.equals("") ? strSid : strServiceName));
											}
											%>
											<input type='hidden' name='database_type' id="database_type" value="<%=database_type%>"/>
										</div>
									</td>
									<td>
										<div class='cellTitle_ez_right'>Execution Type</div>
									</td>
									<td>
										<div class='cellContent_kang'>
											<select id='execution_type' name='execution_type' style="width:60%;height:21px;">
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
										<input type="hidden" name="schema" id="schema" value="<%=schema %>" style="width:85%;height:21px;" />
											<%=schema %>
										</div>
									</td>
									<td>
										<div class='cellTitle_ez_right'>Name</div>
									</td>
									<td colspan="2">
										<div class='cellContent_kang'>
										<input type="hidden" name="sp_name" id="sp_name" value="<%=sp_name %>" style="width:85%;height:21px;" />
											<%=sp_name %>
										</div>
									</td>
								</tr>
								<tr id="db_q_tr" style="display:none;">
									<td>
										<div class='cellTitle_ez_right' style="display: flex;justify-content: flex-end;align-items: center;height: 150px;text-align: right;">Query</div>
									</td>
									<td colspan="5">
										<div class='cellContent_kang' style="height: 150px">
											<textarea name="query" id="query" style="width:62%;height:150px;" cols="30" rows="5" ><%=query %></textarea>
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
									<td style='text-align:center;'>
										<label for='DB_APPEND_LOG'>
										<input type='checkbox' name='chk_db_append_log' id='chk_db_append_log' <%=append_log.equals("Y") ? "checked" : "" %>/>
											Append execution log to Job Output
										</label>
										<input type='hidden' name='append_log' id="append_log" />
									</td>
									<td style='text-align:center;' colspan="3">
										<label for='DB_APPEND_OUTPUT'><input type='checkbox' name='chk_db_append_output' id='chk_db_append_output' <%=append_output.equals("Y") ? "checked" : "" %>/>
											Append SQL output to Job Output 
										</label>
										<input type='hidden' name='append_output' id="append_output" />
										(Output format : <select id='sel_db_output_format' name='sel_db_output_format' style="width:100px;height:21px;" >
												<option value='T'>TEXT</option>
												<option value='X'>XML</option>
												<option value='C'>CSV</option>
												<option value='H'>HTML</option>
											</select>
											<input type="text" name=csv_seperator id="csv_seperator" value="<%=csv_seperator %>" style="height:21px; display:none; width:45px;" />)
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
				<tr>
					<td colspan="4" valign="top">
						<table style="width:100%">								
							<tr>									
								<th style="width:100%;">
									<div class='cellTitle_kang' style="text-align:right;padding-bottom:5px;">
										<span id="btn_job_add4">추가</span>
										<!-- <span id="btn_job_del4">삭제</span> -->
									</div>
								</th>
							</tr>
							<tr>
								<td id='ly_<%=gridId_4 %>' style='vertical-align:top;width:49%;height:140px;'>
									<div id="<%=gridId_4 %>" class="ui-widget-header ui-corner-all"></div>
								</td>
							</tr>
						</table>
					</td>
				</tr>					
				<tr>
					<td colspan="4" valign="top">
						<table style="width:100%">								
							<tr>
								<th style="width:49%;">
									<div class='cellTitle_kang' style="text-align:right;padding-bottom:5px;">
										<span id="btn_job_add1">추가</span>
										<!-- <span id="btn_job_del1">삭제</span> -->
									</div>
								</th>
								<th style="width:2%"></th>
								<th style="width:49%;">
									<div class='cellTitle_kang' style="text-align:right;padding-bottom:5px;">
										<span id="btn_job_add2">추가</span>
										<!-- <span id="btn_job_del2">삭제</span> -->
									</div>
								</th>
							</tr>
							<tr>
								<td id='ly_<%=gridId_1 %>' style='vertical-align:top;width:53%;height:140px;'>
									<div id="<%=gridId_1 %>" class="ui-widget-header ui-corner-all"></div>
								</td>
								<td width="1%"></td>
								<td id='ly_<%=gridId_2 %>' style='vertical-align:top;width:46%;height:140px;'>
									<div id="<%=gridId_2 %>" class="ui-widget-header ui-corner-all"></div>
								</td>
							</tr>
						</table>
					</td>
				</tr>					
			</table>
		</td>
	</tr>			
	<tr valign="bottom">
		<div align='right' class='btn_area_s'>
			<font color="red" >※ Running 작업은 실시간 작업 변경이 불가능합니다.</font>
			<span id="btn_save" >저장</span>
			<span id="btn_close">닫기</span>
		</div>
	</tr>
	<tr><td height="5px;"></td></tr>
</table>
</form>

<%@include file="/jsp/common/inc/progBar.jsp"  %>
<iframe name="if1" id="if1" width="0" height="0"></iframe>
</body>

<script>

	var rowsObj_job1 = new Array();
	var rowsObj_job2 = new Array();
	var rowsObj_job3 = new Array();
	var rowsObj_job4 = new Array();
	var rowsObj_job5 = new Array();

	var gridObj_1 = {
		id : "<%=gridId_1 %>"
		,colModel:[
			{formatter:gridCellNoneFormatter,field:'COND_PAREN_S',id:'COND_PAREN_S',name:'(',width:38,headerCssClass:'cellCenter',cssClass:'cellCenter'}
			, {formatter:gridCellNoneFormatter,field:'COND_NM',id:'COND_NM',name:'선행조건명',width:160,headerCssClass:'cellCenter',cssClass:'cellCenter'}
			,{formatter:gridCellNoneFormatter,field:'COND_PAREN_E',id:'COND_PAREN_E',name:')',width:38,headerCssClass:'cellCenter',cssClass:'cellCenter'}
			,{formatter:gridCellNoneFormatter,field:'COND_DT',id:'COND_DT',name:'일자유형',width:70,headerCssClass:'cellCenter',cssClass:'cellCenter'}
	   		,{formatter:gridCellNoneFormatter,field:'COND_GB',id:'COND_GB',name:'구분',width:75,headerCssClass:'cellCenter',cssClass:'cellCenter'}
	   		,{formatter:gridCellNoneFormatter,field:'OPTION',id:'OPTION',name:'삭제',width:50,headerCssClass:'cellCenter',cssClass:'cellCenter'}
	   		,{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'번호',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   		
	   	]
		,rows:[]
		,vscroll:false
	};
	
	var gridObj_2 = {
		id : "<%=gridId_2 %>"
		,colModel:[
			{formatter:gridCellNoneFormatter,field:'COND_NM',id:'COND_NM',name:'후행조건명',width:180,headerCssClass:'cellCenter',cssClass:'cellCenter'}
	   		,{formatter:gridCellNoneFormatter,field:'COND_DT',id:'COND_DT',name:'일자유형',width:70,headerCssClass:'cellCenter',cssClass:'cellCenter'}
	   		,{formatter:gridCellNoneFormatter,field:'COND_GB',id:'COND_GB',name:'구분',width:75,headerCssClass:'cellCenter',cssClass:'cellCenter'}
	   		,{formatter:gridCellNoneFormatter,field:'OPTION',id:'OPTION',name:'삭제',width:50,headerCssClass:'cellCenter',cssClass:'cellCenter'}
	   		,{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'번호',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   	]
		,rows:[]
		,vscroll:false
	};
	
	var gridObj_4 = {
			id : "<%=gridId_4 %>"
			,colModel:[
				{formatter:gridCellNoneFormatter,field:'VAR_NAME',id:'VAR_NAME',name:'변수 이름',width:260,headerCssClass:'cellCenter',cssClass:'cellCenter'}
		   		,{formatter:gridCellNoneFormatter,field:'VALUE',id:'VALUE',name:'변수 값',width:460,headerCssClass:'cellCenter',cssClass:'cellCenter'}
		   		,{formatter:gridCellNoneFormatter,field:'OPTION',id:'OPTION',name:'삭제',width:50,headerCssClass:'cellCenter',cssClass:'cellCenter'}
		   		,{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'번호',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
		   		,{formatter:gridCellNoneFormatter,field:'CHK_VALUE',id:'CHK_VALUE',name:'CHK_VALUE',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
		   	]
			,rows:[]
			,vscroll:false
		};
	
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
		
		window.focus();
		
		<%
			if(referer.indexOf("tWorks.ez?c=ez009") == -1){
		%>
			$("#btn_save").hide();	
		
			$("#btn_job_add1").hide();
			$("#btn_job_del1").hide();
			
			$("#btn_job_add2").hide();
			$("#btn_job_del2").hide();
		
			$("#btn_job_add4").hide();
			$("#btn_job_del4").hide();
		<% } %>
		
		var v_task_type = document.getElementById('task_type').value.toLowerCase();

		if(v_task_type == "job"){
			//$("#btn_job_add4").hide();
			//$("#btn_job_del4").hide();
		} else if( v_task_type == "kubernetes" ) {
			$('#kubernetes_yn').show();
		} else if (v_task_type == "mft"){
			$('#mftTable').show();
		}else if( v_task_type == "database" ) {
			$('#database_tb').show();
		}
		$("select[name='execution_type']").val("<%=execution_type%>");
		$("select[name='sel_db_output_format']").val("<%=db_output_format%>");
		
		var execuType = '<%=execution_type%>';
		if(execuType == 'P'){
			$('#db_q_tr').hide();
			$('#db_p_tr').show();
			
		}else if(execuType == 'Q'){
			$('#db_q_tr').show();
			$('#db_p_tr').hide();
		}
		var dbOutputFormat = '<%=db_output_format%>';
		if(dbOutputFormat == 'C'){
			$('#csv_seperator').show();
		}else {
			$('#csv_seperator').hide();
		}		
		
		
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
			}else{
				$('#db_q_tr').hide();
				$('#db_p_tr').hide();
				$('#schema').val('');
				$('#sp_name').val('');
				$('#query').val('');
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
		
		$("#btn_save").button().unbind("click").click(function(){
			goPrc("<%=strOrderId%>");
		});	
		
		$("#btn_close").button().unbind("click").click(function(){
			self.close();
		});	
		
		$("#btn_job_add1").button().unbind("click").click(function(){
			popJobsForm('1');
		});
		$("#btn_job_del1").button().unbind("click").click(function(){
			getPreAfterJobs("1");
		});
		$("#btn_job_add2").button().unbind("click").click(function(){
			popJobsForm('2');
		});
		$("#btn_job_del2").button().unbind("click").click(function(){
			getPreAfterJobs("2");
		});		
		$("#btn_argmt_add").button().unbind("click").click(function(){			
			popArgForm("argmt");
		});
		
		$("#btn_job_add4").button().unbind("click").click(function(){
			//popArgForm("arg");
			
			// 변수 ROW 추가
			addSetGrid();
		});
		$("#btn_job_del4").button().unbind("click").click(function(){
			getPreAfterJobs("arg");
		});
		
		viewGrid_1(gridObj_1,"ly_"+gridObj_1.id);
		viewGrid_1(gridObj_2,"ly_"+gridObj_2.id);
		viewGrid_1(gridObj_4,"ly_"+gridObj_4.id);
	
		//선행 추가
		<%
			if(!strTconditionsIn.equals("")){				
				aTmpT = CommonUtil.E2K(docBean.getT_conditions_in()).split("[|]");
				for(int t=0; null!=aTmpT&&t<aTmpT.length; t++ ){
					String[] aTmpT1 = aTmpT[t].split(",",3);					
		%>		
					setPreAfterJobs("<%=aTmpT1[0]%>", "1", "<%=aTmpT1[1]%>", "<%=aTmpT1[2]%>");		//선행
		<%
				}
			}
		%>
		
		//후행 추가
		<%
			if(!strTconditionsOut.equals("")){
				aTmpT = CommonUtil.E2K(docBean.getT_conditions_out()).split("[|]");
				for(int t=0; null!=aTmpT&&t<aTmpT.length; t++ ){
					String[] aTmpT1 = aTmpT[t].split(",",3);
		%>
			setPreAfterJobs("<%=aTmpT1[0]%>", "2", "<%=aTmpT1[1]%>", "<%=aTmpT1[2]%>");		//후행
		<%
				}
			}
		%>		
		
		
		$("#arg_val").unbind("keyup").keyup(function(e){
			
			var mem_lib 	= $("#mem_lib").val();
			var mem_name 	= $("#mem_name").val();
			var arg_val 	= $("#arg_val").val();
			
			var command 	= mem_lib + mem_name + " " + arg_val;
			
			$("#command").val(command);
			
		});

		
		//변수 추가
		<%
			if(!strTset.equals("") ) {
				aTmpT = CommonUtil.E2K(docBean.getT_set()).split("[|]");
				for(int t=0; null!=aTmpT&&t<aTmpT.length; t++ ) {
					String[] aTmpT1 = aTmpT[t].split(",",2);
					String strVarVal = CommonUtil.isNull(aTmpT1[1]).replaceAll("\\\\", "\\\\\\\\");
		%>
					setArgument("<%=aTmpT1[0] %>", "<%=CommonUtil.replaceHtmlStr(strVarVal) %>", "arg");
		<%
				}
			}
		%>
		
		//MFT 추가
		if( v_task_type == "mft") {
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
	
	function goPrc(order_id) {

		var frm = document.frm1;
		var setvarList = "<%=setvarList%>";
		
		frm.order_id.value = order_id;
	
		// 금칙 문자 체크.
		isValid_C_M();
	
		if ( document.getElementById('is_valid_flag').value == "false" ) {
			document.getElementById('is_valid_flag').value = "";
			return;
		}		
		
		if( isNullInput(document.getElementById('owner'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[계정명]","") %>') ) return;			
		//if( isNullInput(document.getElementById('application'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[어플리케이션]","") %>') ) return;
		//if( isNullInput(document.getElementById('group_name'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[그룹]","") %>') ) return;
		
		var v_task_type = document.getElementById('task_type').value.toLowerCase();

		if (v_task_type=='kubernetes') {
			alert("Kubernetes 작업은 실시간 작업변경이 불가능합니다.");
			return;
		}
		
		//Command 셋
		/*
		if (v_task_type=='command') {
						
			var command_only = $("#command").val();
			var full_command = "";
			var row = rowsObj_job3.length;
			for(var i=1;i<=row;i++){
				var param = "nm_param"+i;
				
				if(i > 1) full_command += " ";
				if(i == 1 && command_only != "") full_command += command_only+" ";
				full_command += $("#"+param).val();
			}
			
			$('#command').val(full_command);
		}else{
			$('#command').val("<%=strCmdLine%>");
		}
		*/
		
		/*
		if(v_task_type=='command'){
			if( isNullInput(document.getElementById('command'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[실행명령어 파라미터]","") %>') ) return;		
		}else if(v_task_type=='job'){
			if( isNullInput(document.getElementById('mem_name'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[실행쉘이름]","") %>') ) return;
			if( isNullInput(document.getElementById('mem_lib'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[실행쉘경로]","") %>') ) return;	
		}
		*/
	
		//if ( v_task_type == "job" || v_task_type == "command" || v_task_type == "dummy" ) {
			if( isNullInput(document.getElementById('node_id'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[수행서버]","") %>') ) return;
		//}
		
		//Argument 셋
		var full_argument = "";
		var row = rowsObj_job4.length;
		
		setGridSelectedRowsAll(gridObj_4);		//중복체크를 위해 전체항목 선택
		var aSelRow4 = new Array;
		aSelRow4 = $('#'+gridObj_4.id).data('grid').getSelectedRows();
		
		
		if(row > 0){
			for(var i=0;i<aSelRow4.length;i++){
				var grid4Chlid = $("#"+gridObj_4.id).find('.grid-canvas').children().eq(i).children().children().find('input');
				var var_nm = grid4Chlid.eq(0).prop('id');
				var var_val =grid4Chlid.eq(1).prop('id');
								
				if ( grid4Chlid.eq(1).val().indexOf("|") > -1 ) {
					alert("변수 값에는 파이프라인(|) 사용 불가 입니다.");
					return;
				}
				
				if(i > 0) full_argument += "|";
				full_argument += grid4Chlid.eq(0).val()+","+grid4Chlid.eq(1).val();
			}
			$("#t_set").val(full_argument);		
		}
		
		//선행 셋
		var all = "";
		var row = gridObj_1.rows.length;
		
		setGridSelectedRowsAll(gridObj_1);		//중복체크를 위해 전체항목 선택
		var aSelRow1 = new Array;
		aSelRow1 = $('#'+gridObj_1.id).data('grid').getSelectedRows();
		for(var i=0;i<aSelRow1.length;i++){
			var grid1ChlidInput = $("#"+gridObj_1.id).find('.grid-canvas').children().eq(i).children().children().find('input');
			var grid1ChlidSelect = $("#"+gridObj_1.id).find('.grid-canvas').children().eq(i).children().children().find('select');
			
			//var nm = grid1ChlidInput.eq(0).prop('id');
			//var dt = grid1ChlidInput.eq(1).prop('id');
			//var gb = grid1ChlidSelect.eq(0).prop('name');
			
			if(i > 0) all += "|";
			all += grid1ChlidSelect.eq(0).val() + grid1ChlidInput.eq(0).val() + grid1ChlidSelect.eq(1).val() + "," + grid1ChlidInput.eq(1).val() + "," + grid1ChlidSelect.eq(2).val();
		}		
		
		frm.t_conditions_in.value = all;
		
		//후행 셋
		all = "";
		var row = rowsObj_job2.length;
		
		setGridSelectedRowsAll(gridObj_2);		//중복체크를 위해 전체항목 선택
		var aSelRow2 = new Array;
		aSelRow2 = $('#'+gridObj_2.id).data('grid').getSelectedRows();
		for(var i=0;i<aSelRow2.length;i++){
			
			var grid2ChlidInput = $("#"+gridObj_2.id).find('.grid-canvas').children().eq(i).children().children().find('input');
			var grid2ChlidSelect = $("#"+gridObj_2.id).find('.grid-canvas').children().eq(i).children().children().find('select');
			
			//var nm = grid2ChlidInput.eq(0).prop('id');
			//var dt = grid2ChlidInput.eq(1).prop('id');
			//var gb = grid2ChlidSelect.eq(0).prop('name');
			
			if(i > 0) all += "|";
			all += grid2ChlidInput.eq(0).val()+","+grid2ChlidInput.eq(1).val()+","+grid2ChlidSelect.eq(0).val();
		}
		
		// ctmpsm -FULLUPDATE는 DELETE가 아닌 DEL로 설정
		all = all.replace(/DELETE/gi, "del");
		frm.t_conditions_out.value = all;
				
		/*
		var cmd_line 	= "<%=strCmdLineTemp%>";
		var cmd_line2 	= "<%=strCmdLineTemp%>";
		cmd_line		= cmd_line.substring(0, cmd_line.indexOf(" "));

		if ( cmd_line == "" ) { 
			cmd_line = cmd_line2;
		}
		
		var command 	= document.getElementById('command').value;
		var command2 	= document.getElementById('command').value;		
		command			= command.substring(0, command.indexOf(" "));
		
		if ( command == "" ) { 
			command = command2;
		}
		*/

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

		// 실행명령어의 경로 및 파일명은 변경 불가능.
		//if ( cmd_line != command ) {
			//alert("실행명령어는 뒤의 파라미터만 변경 가능합니다.");
			//return;
		//}
		
		/* alert("full_argument : " + full_argument);
		alert("frm.t_conditions_in.value : " + frm.t_conditions_in.value);
		alert("frm.t_conditions_out.value : " + frm.t_conditions_out.value); */
		
		
		// 작업수행명령에 비활성화 문자가 있을 경우 command 문자조합
		var inactive_command = $("#inactive_command").text();
		var active_command   = $("#active_command").val();
		if(inactive_command != ""){
			$("#command").val(inactive_command + active_command);
		}
		var mftValue 	= "";
		if(v_task_type == "mft"){
			mftValue 	= "<%=strTset != null ? strTset.replaceAll("\r\n", "\\\\n").replaceAll("\n", "\\\\n").replaceAll("<br>","\n") : "" %>";
		}
		frm.FTP_VALUE.value = mftValue;
		
		if ( confirm("실시간 작업을 수정하시겠습니까?") ) {
			
			try{viewProgBar(true);}catch(e){}
			
			frm.target = "if1";
			frm.action = "<%=sContextPath%>/tPopup.ez?c=ez033_p";
			frm.submit();
		}else{
			clearGridSelected(gridObj_1);
			clearGridSelected(gridObj_2);
			clearGridSelected(gridObj_4);
			
			$('.g_ez033_1_checkbox_selector').prop('checked', false);
			$('.g_ez033_2_checkbox_selector').prop('checked', false);
			$('.g_ez033_4_checkbox_selector').prop('checked', false);
		}
	}
		
	//작업내역 폼
	function popJobsForm(gb){
		
		var data_center = $("#frm1").find("input[name='data_center']").val();

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
		
		dlPop02('dl_tmp1',"컨디션검색 ",570,300,false);
					
		var gridObj = {
			id : "g_tmp1"
			,colModel:[
		   		{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'번호',width:50,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
				,{formatter:gridCellNoneFormatter,field:'FOLDER',id:'FOLDER',name:'폴더',width:100,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
				,{formatter:gridCellNoneFormatter,field:'APPLICATION',id:'APPLICATION',name:'어플리케이션',width:85,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
		   		,{formatter:gridCellNoneFormatter,field:'GROUP_NAME',id:'GROUP_NAME',name:'그룹',width:85,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
		   		,{formatter:gridCellNoneFormatter,field:'JOB_NAME',id:'JOB_NAME',name:'작업명',width:180,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
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
		//popJobsList('',gb);

		var v_data_center = $("select[name='v_data_center'] option:selected").val();
		if(v_data_center != "") {
			popJobsList('', gb, $("#search_gubun").val(), '', v_data_center);
		}

		$('#pre_search_text').placeholder().unbind('keypress').keypress(function(e){
			if(e.keyCode==13){
				
				if($(this).val() == ""){
					//popJobsList($(this).val(), gb);
					//alert("작업명을 입력해주세요.");
					//return;
				}else{
					var v_data_center = $("select[name='v_data_center'] option:selected").val();
					
					if(v_data_center == ""){
						alert("C-M 을 선택해 주세요.");
						return;
					}
					
					//popJobsList($(this).val(), gb);
					popJobsList($(this).val(), gb, $("#search_gubun").val(), $("#pre_search_text").val(), v_data_center);
				}
			}
		});		
		
		$("#btn_pre_search").button().unbind("click").click(function(){
			
			var search_text = $("#form1").find("input[name='pre_search_text']").val().replace(/^\s+|\s+$/g,"");

			if(search_text == ""){
				//alert("작업명을 입력해주세요.");
				//return;
			}else{
				var v_data_center = $("select[name='v_data_center'] option:selected").val();

				if(v_data_center == ""){
					alert("C-M 을 선택해 주세요.");
					return;
				}

				popJobsList(search_text, gb, $("#search_gubun").val(), search_text, v_data_center);
			}

		});
		
	}

	//컨디션내역 가져오기
	function popJobsList(search_text, gb, gubun, text, v_data_center){
		
		try{viewProgBar(true);}catch(e){}
		$('#ly_total_cnt_1').html('');
		
		var data_center 		=  v_data_center;

		if(data_center == ''){
			alert("C-M 을 선택해 주세요.");
			return;
		}

		$("#f_s").find("input[name='p_data_center']").val(data_center);
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
								
								if ( mapper_data_center != "<%=strDataCenter%>" ) {
									set_job_name = "GLOB-" + job_name;
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

		setPreAfterJobs(v_job_name, gb);

		if(flag == "direct"){
			document.getElementById('job_name0').value = "";
		}
	}

	function goSelect(job_nm, gb){
		
		// 접미사 셋팅
		var cond_suffix = "<%=CommonUtil.isNull(CommonUtil.getMessage("COND_SUFFIX"))%>";
		job_nm = job_nm + cond_suffix;
		
		setPreAfterJobs(job_nm, gb, "<%=strOdate%>", "", 'add');
	}
	
	function setPreAfterJobs(job_nm, gb, cond, and_or, add){		

		var cond_nm = "";
		var cond_dt = "";
		var cond_gb = "";		
		var i = 0;
		var val = "";
		var parentheses_s = "";
		var parentheses_e = "";

		if(gb == "1" || gb == "in"){
			i = rowsObj_job1.length+1;
			val = "_in_cond_nm"+i;
		}else if(gb == "2" || gb == "out"){
			i = rowsObj_job2.length+1;
			val = "_outcond_nm"+i;
		}

		// 등록되어 있는 선.후행 뿌려줄 경우 콤마로 구분되어 있음.
		if ( job_nm.split(",", 3) && add=='' ) {
			var cond 	= job_nm.split(",", 3);
			cond_nm 	= cond[0];
			cond 		= cond[1];
			and_or 	= cond[2];
		}

		//추가일 경우 해당 데이터가 undefined로 설정된다.
		//if(typeof odate == "undefined") cond_nm = job_nm+"3213123123123123";
		if(typeof odate == "undefined") cond_nm = "<div class='gridInput_area'><input type='text' name='job"+val+"' id='job"+val+"' value='"+job_nm+"' style='width:100%;' ></div>";
		if(typeof odate == "undefined") cond = "ODAT";
		if(typeof and_or == "undefined") and_or = "and";

		if(job_nm != ""){

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


			cond_nm = "<div class='gridInput_area'><input type='text' name='job"+val+"' id='job"+val+"' value='"+job_nm+"' style='width:100%;' ></div>";

			cond_dt += "<div class='gridInput_area'>";
			cond_dt += "<input type='text' name='dt"+val+"' id='dt"+val+"' value='"+cond+"' size='2' maxlength='4' >";
			cond_dt += "</div>";

			cond_gb = "";
			cond_gb += "<div class='gridInput_area'>";
			cond_gb += "<select name='gb"+val+"' id='gb"+val+"'style='width:65px;height:21px;'>";

			if(gb == "1" || gb == "in"){

				cond_paren_s = "";
				cond_paren_s += "<div class='gridInput_area'>";
				cond_paren_s += "<select name='dt"+val+"' id='dt"+val+"'style='width:30px;height:21px;'>";
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
				cond_paren_e += "<select name='dt"+val+"' id='dt"+val+"'style='width:30px;height:21px;'>";
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
						var v_cond_nm = getCellValue(gridObj_1,aSelRow[j],'CHK_COND_NM');
						
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
						,'COND_PAREN_S': cond_paren_s
						,'COND_PAREN_E': cond_paren_e
						,'COND_NM': cond_nm
						,'COND_DT': cond_dt
						,'COND_GB': cond_gb		
						,'CHK_COND_NM': job_nm
						,'OPTION'  :"<a href=\"\"><font color='red'>[삭제]</font></a>"
					});
					
					gridObj_1.rows = rowsObj_job1;
					
					$('.g_ez033_1_checkbox_selector').prop('checked', false);
					clearGridSelected(gridObj_1);		//선택된 전체항목 해제 */
					
					
					addGridRow(gridObj_1, {
						'grid_idx': (aSelRow.length+1)
						,'COND_PAREN_S': cond_paren_s
						,'COND_PAREN_E': cond_paren_e
						,'COND_NM': cond_nm
						,'COND_DT': cond_dt
						,'COND_GB': cond_gb		
						,'CHK_COND_NM': job_nm
						,'OPTION'  :"<a href=\"javascript:dataDel('gridObj_1', "+(i-1)+", '1')\"><font color='red'>[삭제]</font></a>"
					});

					clearGridSelected(gridObj_1);		//선택된 전체항목 해제 */
					$('.g_ez033_1_checkbox_selector').prop('checked', false);
					
					dlClose("dl_tmp1");
				}
				
			}else if(gb == "2"){
				
				var dup_cnt = 0;				
				setGridSelectedRowsAll(gridObj_2);		//중복체크를 위해 전체항목 선택
				
				var aSelRow = new Array;
				aSelRow = $('#'+gridObj_2.id).data('grid').getSelectedRows();
							
				if(aSelRow.length>0){
					for(var j=0;j<aSelRow.length;j++){						
						var v_cond_nm = getCellValue(gridObj_2,aSelRow[j],'CHK_COND_NM');		
						
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
						,'COND_NM': cond_nm
						,'COND_DT': cond_dt
						,'COND_GB': cond_gb		
						,'CHK_COND_NM': job_nm
						,'OPTION'  :"<a href=\"\"><font color='red'>[삭제]</font></a>"
					});
					
					gridObj_2.rows = rowsObj_job2;
					
					$('.g_ez033_2_checkbox_selector').prop('checked', false);
					clearGridSelected(gridObj_2);		//선택된 전체항목 해제 */
					
					
					addGridRow(gridObj_2, {
						'grid_idx':(aSelRow.length+1)
						,'COND_NM': cond_nm
						,'COND_DT': cond_dt
						,'COND_GB': cond_gb		
						,'CHK_COND_NM': job_nm
						,'OPTION'  :"<a href=\"javascript:dataDel('gridObj_2', "+(i-1)+", '2')\"><font color='red'>[삭제]</font></a>"
					});
					//setGridRows(gridObj_2);
					
					clearGridSelected(gridObj_2);		//선택된 전체항목 해제 */
					$('.g_ez033_2_checkbox_selector').prop('checked', false);
					
					dlClose("dl_tmp1");
				}
			}
			
			//$("select[name='gb"+val+"']").val(and_or);
		}

	}

	function getPreAfterJobs(gb){
		
		if(gb == "1"){			
			
			var aSelRow = new Array;
			aSelRow = $('#'+gridObj_1.id).data('grid').getSelectedRows();
			
			if(aSelRow.length>0){
				if(aSelRow.length>1){
					alert("하나씩 삭제해주세요.");
					clearGridSelected(gridObj_1)		//선택된 전체항목 해제 */
					$('.g_ez033_1_checkbox_selector').prop('checked', false);
					return;
				}
				for(var i=0;i<aSelRow.length;i++){
					delGridRowNoInv(gridObj_1,aSelRow[i]-i);
					
				}
			}
			clearGridSelected(gridObj_1)		//선택된 전체항목 해제 */
			$('.g_ez033_1_checkbox_selector').prop('checked', false);
			
		}else if(gb == "2"){
			
			var aSelRow = new Array;
			aSelRow = $('#'+gridObj_2.id).data('grid').getSelectedRows();
			
			
			if(aSelRow.length>0){
				for(var i=0;i<aSelRow.length;i++){
					delGridRowNoInv(gridObj_2,aSelRow[i]-i);
					
				}
				
			}
			clearGridSelected(gridObj_2)		//선택된 전체항목 해제 */
			$('.g_ez033_2_checkbox_selector').prop('checked', false);
		}else if(gb == "arg"){
			var aSelRow = new Array;
			aSelRow = $('#'+gridObj_4.id).data('grid').getSelectedRows();
			
			if(aSelRow.length>0){
				
				for(var i=0;i<aSelRow.length;i++){
					delGridRowNoInv(gridObj_4,aSelRow[i]-i);
					
				}
			}
			clearGridSelected(gridObj_4)		//선택된 전체항목 해제 */
			$('.g_ez033_4_checkbox_selector').prop('checked', false);
		}
	}
	
	//입력변수 폼
	/*
	function popArgForm(gb){
				
		var sHtml1="<div id='dl_tmp1' style='overflow:hidden;display:none;padding:0;'>";
		sHtml1+="<form id='form1' name='form1' method='post' onsubmit='return false;'>";
		//sHtml1+="<input type='hidden' name='search_gubun' id='search_gubun' value='job_name' />";
		sHtml1+="<table style='width:100%;height:260px;;border:none;'><tr><td style='vertical-align:top;height:100%;width:500px;'>";
		//sHtml1+="<input type='text' name='search_text' id='search_text' value='' />&nbsp;&nbsp;<span id='btn_search'>검색</span>";
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
		
		dlPop01('dl_tmp1',"입력변수내역",570,270,false);
				
		var gridObj = {
			id : "g_tmp1"
			,colModel:[
		   		{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'번호',width:50,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}	   		
		   		,{formatter:gridCellNoneFormatter,field:'SCODE_ENG_NM',id:'SCODE_ENG_NM',name:'변수명',width:150,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
		   		,{formatter:gridCellNoneFormatter,field:'SCODE_DESC',id:'SCODE_DESC',name:'설명',width:200,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}	 
		   		,{formatter:gridCellNoneFormatter,field:'CHOICE',id:'CHOICE',name:'선택',width:50,headerCssClass:'cellCenter',cssClass:'cellCenter'}
		   		
		   		,{formatter:gridCellNoneFormatter,field:'SCODE_CD',id:'SCODE_CD',name:'SCODE_CD',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
		   		,{formatter:gridCellNoneFormatter,field:'SCODE_NM',id:'SCODE_NM',name:'SCODE_NM',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
		   	]
			,rows:[]
			,vscroll:false
		};
		
		viewGrid_1(gridObj,'ly_'+gridObj.id);
		argList(gb);		
	}
	*/
	
	
	//입력변수 폼
	function popArgForm(gb){
				
		var sHtml1="<div id='dl_tmp1' style='overflow:hidden;display:none;padding:0;border-top:1px solid blue;border-bottom:1px solid blue;border-left:1px solid blue;border-right:1px solid blue;'>";
		sHtml1+="<form id='form1' name='form1' method='post' onsubmit='return false;'>";
		//sHtml1+="<input type='hidden' name='search_gubun' id='search_gubun' value='job_name' />";
		sHtml1+="<table style='width:100%;height:260px;;border:none;'><tr><td style='vertical-align:top;height:100%;width:500px;'>";
		sHtml1+="변수명 : <input type='text' name='arg_eng_nm' id='arg_eng_nm' />&nbsp;&nbsp;날짜검색 : <input type='text' name='cur_date' id='cur_date' class='input datepick' onkeydown='return false;' readonly />&nbsp;&nbsp;<span id='btn_arg_search'>검색</span>";
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
			,vscroll:false
		};
		
		viewGrid_1(gridObj,'ly_'+gridObj.id);
		//argList(flag);
		
		var dt = $("#cur_date").val();
		var arg_eng_nm 	= $("#arg_eng_nm").val();
		argumentList(arg_eng_nm, dt, gb);
	
		$("#cur_date").addClass("ime_readonly").unbind('click').click(function(){
			dpCalMinMax(this.id,'yymmdd','-365','1');
		});
		
		$("#btn_arg_search").button().unbind("click").click(function(){
			var dt = $("#cur_date").val();
			var arg_eng_nm 	= $("#arg_eng_nm").val();
			argumentList(arg_eng_nm, dt, gb);
		});
	}
	
	
	//입력변수 가져오기
	function argList(gb){
		
		try{viewProgBar(true);}catch(e){}
		$('#ly_total_cnt').html('');
		
		//var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=sCodeList&mcode_cd=${ARGUMENT_MCODE_CD}&host_eng_nm=N';
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
					$(xmlDoc).find('doc').each(function(){
						
						var items = $(this).find('items');
						var rowsObj = new Array();
						
						if(gb == "arg"){
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
								,'CHOICE':"<div><a href=\"javascript:goSelect4('"+gb+"');\" ><font color='red'>[선택]</font></a></div>"
							});						
						}
						
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
									,'CHOICE':"<div><a href=\"javascript:goSelect2('"+scode_nm+"','"+scode_eng_nm+"','"+gb+"');\" ><font color='red'>[선택]</font></a></div>"
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
	
	function argumentList(arg_eng_nm, dt, gb){
		
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
									//choice = "<div><a href=\"javascript:setArgument('"+scode_nm+"','"+scode_eng_nm+"','"+gb+"');\" ><font color='red'>[선택]</font></a></div>";
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
	
	function goSelectCommand(nm, desc){
		
		var command = $("#command").val();
		var arg_val = $("#arg_val").val();
		
		var lst_command = "";
		var desc2 		= "%%" + desc;
		
		$("#command").val(command);
		lst_command = " " + desc2;
		command += lst_command;
		$("#command").val(command);
		$("#arg_val").val(arg_val + " " + desc2);
		$("#argument").val(arg_val + " " + desc2);
			
		dlClose('dl_tmp1');			
	}
	
	function goSelect2(nm, val, gb){
		
		setArgument(nm, val, gb);		
	}
	
	function goSelect4(gb){
		var scode_eng_nm = $("#scode_eng_nm0").val();
		var scode_desc = $("#scode_desc0").val();	
		
		goSelect2(scode_desc, scode_eng_nm, gb);
		
	}
		
	function setArgument(nm, val, gb){
		
		var v_nm = "";
		var v_val = "";
		var i = 0;
		var v_id = "";
		
		if(gb == "arg"){
			i = rowsObj_job4.length+1;
			v_id = "_argu"+i;
		}
		
		val =  val.replace("º","%");
		if(nm != ""){
			
			v_val = "";
			v_nm = "";
			
			if(gb == "arg"){
				v_nm += "<div class='gridInput_area'><input type='text' name='nm"+v_id+"' id='nm"+v_id+"' value='"+nm+"' style='width:100%;' ></div>";
				v_val += "<div class='gridInput_area'><input type='text' name='val"+v_id+"' id='val"+v_id+"' value='"+val+"' style='width:100%;' ></div>"; 
			}else{
				v_val += "<div class='gridInput_area'><input type='text' name='nm"+v_id+"' id='nm"+v_id+"' value='"+val+"' style='width:100%;' ></div>";
			}
		}
		
		if(gb == "com"){
			
			var dup_cnt = 0;
			setGridSelectedRowsAll(gridObj_5);		//중복체크를 위해 전체항목 선택
			
			var aSelRow = new Array;
			aSelRow = $('#'+gridObj_5.id).data('grid').getSelectedRows();
						
			if(aSelRow.length>0){
				for(var j=0;j<aSelRow.length;j++){						
					var v_dup_nm = getCellValue(gridObj_5,aSelRow[j],'CHK_PARAM');		
							
					//if(v_dup_nm == val){
						//++dup_cnt;
						//break;
					//}
				}
			}
							
			clearGridSelected(gridObj_5)		//선택된 전체항목 해제 */
			
			if(dup_cnt > 0){
				alert("이미 등록된 내용 입니다.");
				return;
			}else{
				rowsObj_job3.push({
					'grid_idx':i
					,'PARAM': v_val
					,'CHK_PARAM': val
				});
				
				gridObj_5.rows = rowsObj_job3;
				setGridRows(gridObj_5);
				
				dlClose("dl_tmp1");
			}
		}else if(gb == "arg"){
			
			var dup_cnt = 0;				
			setGridSelectedRowsAll(gridObj_4);		//중복체크를 위해 전체항목 선택
			
			var aSelRow = new Array;
			aSelRow = $('#'+gridObj_4.id).data('grid').getSelectedRows();
			
			var chk_val = nm+""+val; 
			if(aSelRow.length>0){
				for(var j=0;j<aSelRow.length;j++){						
					var v_dup_nm = getCellValue(gridObj_4,aSelRow[j],'CHK_VALUE');		
								
					if(v_dup_nm == chk_val){
						++dup_cnt;
						break;
					}
				}
			}
							
			clearGridSelected(gridObj_4)		//선택된 전체항목 해제 */
			
			if(dup_cnt > 0){
				alert("이미 등록된 내용 입니다.");
				return;
			}else{
				if(!("<%=strTaskType%>" == 'Kubernetes' && nm.startsWith('UCM'))){
					if(!("<%=strTaskType%>" == 'MFT' && nm.startsWith('FTP'))){
						if(!("<%=strTaskType%>" == 'Database' && nm.startsWith('DB'))){
						rowsObj_job4.push({
							'grid_idx':i
							,'VAR_NAME': v_nm
							,'VALUE': v_val		
							,'CHK_VALUE': nm+""+val
							,'OPTION'  :"<a href=\"javascript:dataDel('gridObj_4', "+i+", 'arg')\"><font color='red'>[삭제]</font></a>"
						});
					}
					}
				}else{
					if(nm == "UCM-ACCOUNT"){
						$("#con_pro").val(val);
					}else if(nm == "UCM-JOB_YAML_FILE_PARAMS"){
						$("#spec_param").val(val);
					}else if(nm == "UCM-GET_LOGS"){
						$("#get_pod_logs").val(val);
					}else if(nm == "UCM-CLEANUP"){
						$("#job_cleanup").val(val);
					}else if(nm == "UCM-JOB_POLL_INTERVAL"){
						$("#polling_interval").val(val);
					}else if(nm == "UCM-JOB_YAML_FILE"){
						$("#yaml_file").val(val);
					}else if(nm == "UCM-JOB_SPEC_TYPE"){
						$("#job_spec_type").val(val);
					}else if(nm == "UCM-OS_EXIT_CODE"){
						$("#os_exit_code").val(val);
					}
				}
				
				gridObj_4.rows = rowsObj_job4;
				setGridRows(gridObj_4);
				
				dlClose("dl_tmp1");
			}
		}
	} 
	
	
	function addSetGrid() {
	
		var var_length = rowsObj_job4.length + 1;
		
		var scode_eng_nm 	= "<div class='gridInput_area'><input type='text' name='nm_argu"+var_length+"' id='nm_argu"+var_length+"' style='width:100%;'/></div>";
		var scode_desc 		= "<div class='gridInput_area'><input type='text' name='val_argu"+var_length+"' id='val_argu"+var_length+"' style='width:100%;'/></div>";
		
		$('.g_ez033_4_checkbox_selector').prop('checked', false);	
		
		setGridSelectedRowsAll(gridObj_4);		//중복체크를 위해 전체항목 선택
		
		var aSelRow = new Array;
		aSelRow = $('#'+gridObj_4.id).data('grid').getSelectedRows();
		
		rowsObj_job4 = [];
		for(var i=0; i<aSelRow.length; i++){
			
			var varName = $("#"+gridObj_4.id).find('.grid-canvas').children().eq(i).children().eq(0).find('input').val();
			var value = $("#"+gridObj_4.id).find('.grid-canvas').children().eq(i).children().eq(1).find('input').val();
			value = replaceStrHtml(value); //추가버튼 누르면 이전 변수값의 특수문자가 html태그로 변환되는 것 방지.			

			rowsObj_job4.push({'grid_idx':i+1
							  ,'VAR_NAME':"<div class='gridInput_area'><input type='text' name='nm_argu"+(i+1)+"' id='nm_argu"+(i+1)+"' value='"+varName+"' style='width:100%;'/></div>"
							  ,'VALUE'	 :"<div class='gridInput_area'><input type='text' name='val_argu"+(i+1)+"' id='val_argu"+(i+1)+"' value='"+value+"' style='width:100%;'/></div>"
							  ,'OPTION'  :"<a href=\"javascript:dataDel('gridObj_4', "+(i+1)+", 'arg')\"><font color='red'>[삭제]</font></a>"
							  });
				
		}
		gridObj_4.rows = rowsObj_job4;
		setGridRows(gridObj_4);
		
		$('.g_ez033_4_checkbox_selector').prop('checked', false);
		clearGridSelected(gridObj_4);
		
		addGridRow(gridObj_4, {'grid_idx':gridObj_4.rows.length+1
							  ,'VAR_NAME':scode_eng_nm
							  ,'VALUE'	 :scode_desc
							  ,'OPTION'  :"<a href=\"javascript:dataDel('gridObj_4', "+(gridObj_4.rows.length+1)+", 'arg')\"><font color='red'>[삭제]</font></a>"
							  });
		
		
	}
	
	function setCondGridRows(obj){
		var dataView = $('#'+obj.id).data('dataView');
		var grid = $('#'+obj.id).data('grid');
		
		if(obj.rows_org !=null ){
			var aTmp = new Array();
			for(var i=0;i<obj.rows.length;i++){
				aTmp.push($.extend(true,{},obj.rows[i]));
			}
			obj.rows_org = aTmp;
		}
		
		dataView.beginUpdate();
		dataView.setItems(obj.rows,'grid_idx');
		dataView.endUpdate();
		dataView.syncGridSelection(grid, true);		//sorting 시 선택된 row 위치 동기화
		
		condInvalidate(grid);
	}

	function condInvalidate(grid) {
		grid.updateRowCount();
		grid.invalidateAllRows();
		grid.render();
	}
	
	function dataDel(obj, row, gb){
		if(gb == '1'){
			var aSelRow = new Array;
			aSelRow = $('#'+gridObj_1.id).data('grid').getSelectedRows();
			
			if(aSelRow.length>0){
				
				for(var i=0;i<aSelRow.length;i++){
					delGridRowNoInv(gridObj_1,aSelRow[i]-i);
				}
				
			}
			clearGridSelected(gridObj_4)		//선택된 전체항목 해제 */
			$('.g_ez033_4_checkbox_selector').prop('checked', false);
		}else if(gb == '2'){
			var aSelRow = new Array;
			aSelRow = $('#'+gridObj_2.id).data('grid').getSelectedRows();
			
			if(aSelRow.length>0){
				
				for(var i=0;i<aSelRow.length;i++){
					delGridRowNoInv(gridObj_2,aSelRow[i]-i);
				}
				
			}
			clearGridSelected(gridObj_4)		//선택된 전체항목 해제 */
			$('.g_ez033_4_checkbox_selector').prop('checked', false);
		}else if(gb == 'arg'){
			var aSelRow = new Array;
			aSelRow = $('#'+gridObj_4.id).data('grid').getSelectedRows();
			
			if(aSelRow.length>0){
				
				for(var i=0;i<aSelRow.length;i++){
					delGridRowNoInv(gridObj_4,aSelRow[i]-i);
				}
				
			}
			clearGridSelected(gridObj_4)		//선택된 전체항목 해제 */
			$('.g_ez033_4_checkbox_selector').prop('checked', false);
		}
		
	}

	function fn_cyclic_set(cyclic_value){

		var form = document.frm1;

		if ( cyclic_value == "1" ) {

			form.max_wait.value = "0";

			document.getElementById('cyclic_ment').style.display = "";

			form.rerun_max.readOnly = "";

		} else {

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

</script>
</html>