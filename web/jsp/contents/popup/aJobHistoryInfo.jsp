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
	JobDefineInfoBean docBean	= (JobDefineInfoBean)request.getAttribute("aJobInfo");
	String strPageGubun			= (String)request.getAttribute("page_gubun");
	String strDataCenter 		= CommonUtil.isNull(paramMap.get("data_center"));
	List<CommonBean> inOutList 		= new ArrayList<CommonBean>();
	List setvarList				= (List)request.getAttribute("setvarList");
	
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
	String strapplType			= "";
	
	String[] aTmp 				= null;
	String[] aTmpT 				= null;
	
	String strCmdLineTemp 	= "";
	String strArgument 		= "";
	
	String strCycleMent		= "";
	
	if ( docBean != null ) {
		
		strOrderId	 		= CommonUtil.isNull(docBean.getOrder_id());
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
		
		if(strapplType.equals("FILE_TRANS")){
			strTaskType = "MFT";
		}else if(strapplType.equals("KBN062023")){
			strTaskType = "kubernetes";
		}else if(strapplType.equals("DATABASE")){
			strTaskType = "Database";
		}
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
	System.out.println("setvarList : " + setvarList);
	if(setvarList != null) {
		for ( int i = 0; i < setvarList.size(); i++ ) {
			CommonBean commonBean = (CommonBean) setvarList.get(i);
			var_name	= commonBean.getVar_name();
			
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
			if(var_name.startsWith("DB-STP_PARAMS-")){
				CommonBean newBean = new CommonBean();
				
				newBean.setVar_name(var_name);
				newBean.setVar_value(commonBean.getVar_value());
			  	inOutList.add(newBean);
			}
		}
	}
	
	String strServerGb 		= CommonUtil.isNull(CommonUtil.getMessage("SERVER_GB"));
	
	// 세션값 가져오기.
	String strSessionUserGb	= S_USER_GB;

	//최대 대기일 기본값
	String strDefaultMaxWait		= "7";
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
	
	<!-- MFT 정보 -->
	<input type='hidden' name='FTP_LHOST' 			id='FTP_LHOST' 		value='' />
	<input type='hidden' name='FTP_RHOST' 			id='FTP_RHOST' 		value='' />
	<input type='hidden' name='FTP_LOSTYPE' 		id='FTP_LOSTYPE' 	value='' />
	<input type='hidden' name='FTP_ROSTYPE' 		id='FTP_ROSTYPE' 	value='' />
	<input type='hidden' name='FTP_LUSER' 			id='FTP_LUSER' 		value='' />
	<input type='hidden' name='FTP_RUSER' 			id='FTP_RUSER' 		value='' />
	<input type='hidden' name='FTP_CONNTYPE1' 		id='FTP_CONNTYPE1' 	value='' />
	<input type='hidden' name='FTP_CONNTYPE2' 		id='FTP_CONNTYPE2' 	value='' />
	
<table style='width:98%;height:98%;border:none;padding-left:15px;'>
	<tr style='height:10px;'>
		<td style='vertical-align:top;'>
			<h4 class="ui-widget-header ui-corner-all">
				<div class='title_area' style="width:100%; text-align:left;">
					<span><%=CommonUtil.getMessage("POPUP.REAL_HISTORY_JOB_INFO.TITLE") %></span>
				</div>				
			</h4>
		</td>
	</tr>
	<tr><td height="5px;"></td></tr>

	<tr valign="top">
		<td valign="top" style="height:100%;">
			<h4 class="ui-widget-header ui-corner-all">
				<table style="width:100%;">
				<colgroup>
					<col width="20%" />
					<col width="30%" />
					<col width="20%" />
					<col width="30%" />
				</colgroup>
					<tr>
						<th class='cellTitle_ez_right'>작업명</th>
						<td><div class='cellContent_popup'><%=strJobName%></div></td>
						<th class='cellTitle_ez_right'>작업타입</th>
						<td><div class='cellContent_popup'><%=strTaskType%></div></td>
					</tr>
					<tr>
						<th rowspan='2' class='cellTitle_ez_right'>작업설명</th>
						<td colspan='3' rowspan='2'><div class='cellContent_popup' style='width:98%;height:auto;word-break:break-all;'><%=strDescription%></div></td>
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
								<%=strNodeId%>
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
						<th class='cellTitle_ez_right'>시작 및 종료시간</th>
						<td>
							<div class='cellContent_popup'>
								<%=strTimeFrom%> to <%=strTimeUntil%>
							</div>
						</td>
						<th class='cellTitle_ez_right'>최대대기일</th>
						<td>
							<div class='cellContent_popup'>
								<%=strMaxWait%>
								<input type='hidden' id='max_wait' name='max_wait' value='<%=strMaxWait%>' size='4' maxlength='2' style='width:96%; height:21px;' onkeypress='if(event.keyCode==32 || event.keyCode==39) event.returnValue = false;' style='ime-mode:disabled;' readOnly />
							</div>
						</td>
					</tr>
					<tr>
						<th rowspan='2' class='cellTitle_ez_right'>작업수행명령</th>
						<td colspan='3' rowspan='2'><div class='cellContent_popup' style='width:98%;height:auto;word-break:break-all;'>
								<%=strCmdLine%>
							</div>
						</td>
					</tr>
					<tr></tr>
					<tr>
						<th class='cellTitle_ez_right'>반복작업</th>
						<td>
							<div class='cellContent_popup' style='height:auto;'>
								<%
									out.println(strCyclicMent);
									if(strCyclicMent.equals("Y")){
										out.println(strCycleMent);
									}

								%>
								<select id='cyclic' name='cyclic' style="height:21px;display:none;" >
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

						<th class='cellTitle_ez_right'>최대반복횟수</th>
						<td>
							<div class='cellContent_popup'>
								<%=strRerunMax%>
								<input type='hidden' id='rerun_max' name='rerun_max' class='input' value='<%=strRerunMax%>' size='4' maxlength='2' style='width:96%; height:21px;' onkeypress='if(event.keyCode==32 || event.keyCode==39) event.returnValue = false;' style='ime-mode:disabled;' readOnly />
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
											<input type='hidden' name='database_type' id="database_type" />
										</div>
									</td>
									<td>
										<div class='cellTitle_ez_right'>Execution Type</div>
									</td>
									<td>
										<div class='cellContent_kang'>
											<select id='execution_type' name='execution_type' style="width:60%;height:21px;" disabled>
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
											<%=schema %>
										</div>
									</td>
									<td>
										<div class='cellTitle_ez_right'>Name</div>
									</td>
									<td colspan="2">
										<div class='cellContent_kang'>
											<%=sp_name %>
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
										
								        if(prmDirection.equals("Out") || prmDirection.equals("void")){
								        	s += "<tr>";
											s += "<td colspan='2' width='30%' style='text-align:center;'>";
											s += prmName;
											s += "<input type='hidden' name='ret_data"+tagIdx+"' id='ret_data"+tagIdx+"'   value='"+prmType+"'>";
											s += "<input type='hidden' name='ret_name"+tagIdx+"' id='ret_name"+tagIdx+"'   value='"+prmName+"'>";
											s += "<input type='hidden' name='ret_param"+tagIdx+"' id='ret_param"+tagIdx+"' value='"+prmDirection+"'>";
											s += "</td>";
											s += "<div id='div_param"+tagIdx+"'></div>";
											s += "<td width='10%' style='text-align:center;'>"+prmDirection+"</td>";
											s += "<td width='20%' style='text-align:center;'>"+prmType+"</td>";
											s += "<td width='10%' style='text-align:center;'><input type='hidden' class='input' name='ret_variable"+tagIdx+"' id='ret_variable"+tagIdx+"' value='"+prmSetVar+"'/></td>";
											s += "<td width='20%' style='text-align:center;'>"+prmSetVar+"</td>";
											s += "</tr>";
									        tagIdx++;
								        }else{
								        	s += "<tr>";
											s += "<td colspan='2' width='30%' style='text-align:center;'>";
											s += prmName;
											s += "<input type='hidden' name='in_data"+tagIdx+"' id='in_data"+tagIdx+"'   value='"+prmType+"'>";
											s += "<input type='hidden' name='in_name"+tagIdx+"' id='in_name"+tagIdx+"'   value='"+prmName+"'>";
											s += "<input type='hidden' name='in_param"+tagIdx+"' id='in_param"+tagIdx+"' value='"+prmDirection+"'>";
											s += "</td>";
											s += "<div id='div_param"+tagIdx+"'></div>";
											s += "<td width='10%' style='text-align:center;'>"+prmDirection+"</td>";
											s += "<td width='20%' style='text-align:center;'>"+prmType+"</td>";
											s += "<td width='10%' style='text-align:center;'>"+prmValue+"</td>";
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
										(Output format : <select id='sel_db_output_format' name='sel_db_output_format' style="width:100px;height:21px;" disabled>
												<option value='T'>TEXT</option>
												<option value='X'>XML</option>
												<option value='C'>CSV</option>
												<option value='H'>HTML</option>
											</select>
											<input type="text" name=csv_seperator id="csv_seperator" value="<%=csv_seperator %>" style="height:21px; display:none; width:45px;" disabled/>)
									</td>
								</tr>	
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
					<tr>
						<td colspan="4" valign="top">
							<table style="width:100%">								
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
									<td id='ly_<%=gridId_1 %>' style='vertical-align:top;width:49%%;height:140px;'>
										<div id="<%=gridId_1 %>" class="ui-widget-header ui-corner-all"></div>
									</td>
									<td width="2%"></td>
									<td id='ly_<%=gridId_2 %>' style='vertical-align:top;width:49%;height:140px;'>
										<div id="<%=gridId_2 %>" class="ui-widget-header ui-corner-all"></div>
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</h4>
		</td>
	</tr>
	<tr valign="top">
		<td style="text-align:right;padding-top:3px;">
			<span id="btn_close">닫기</span>
		</td>
	</tr>
</table>
</form>

<%@include file="/jsp/common/inc/progBar.jsp"  %>
<iframe name="if1" id="if1" width="0" height="0"></iframe>
</body>

<script>

	var rowsObj_job1 = new Array();
	var rowsObj_job2 = new Array();
	var rowsObj_job4 = new Array();

	var gridObj_1 = {
		id : "<%=gridId_1 %>"
		,colModel:[
			{formatter:gridCellNoneFormatter,field:'COND_NM',id:'COND_NM',name:'선행조건명',width:200,headerCssClass:'cellCenter',cssClass:'cellCenter',editor:null}
	   		,{formatter:gridCellNoneFormatter,field:'COND_DT',id:'COND_DT',name:'일자유형',width:70,headerCssClass:'cellCenter',cssClass:'cellCenter',editor:null}
	   		,{formatter:gridCellNoneFormatter,field:'COND_GB',id:'COND_GB',name:'구분',width:50,headerCssClass:'cellCenter',cssClass:'cellCenter',editor:null}
	   		,{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'번호',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   		
	   	]
		,rows:[]
		,vscroll:false
	};
	
	var gridObj_2 = {
		id : "<%=gridId_2 %>"
		,colModel:[
			{formatter:gridCellNoneFormatter,field:'COND_NM',id:'COND_NM',name:'후행조건명',width:190,headerCssClass:'cellCenter',cssClass:'cellCenter',editor:null}
	   		,{formatter:gridCellNoneFormatter,field:'COND_DT',id:'COND_DT',name:'일자유형',width:70,headerCssClass:'cellCenter',cssClass:'cellCenter',editor:null}
	   		,{formatter:gridCellNoneFormatter,field:'COND_GB',id:'COND_GB',name:'구분',width:50,headerCssClass:'cellCenter',cssClass:'cellCenter',editor:null}
	   		,{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'번호',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   	]
		,rows:[]
		,vscroll:false
	};
	
	var gridObj_4 = {
			id : "<%=gridId_4 %>"
			,colModel:[
				{formatter:gridCellNoneFormatter,field:'VAR_NAME',id:'VAR_NAME',name:'변수 이름',width:260,headerCssClass:'cellCenter',cssClass:'cellCenter',editor:null}
		   		,{formatter:gridCellNoneFormatter,field:'VALUE',id:'VALUE',name:'변수 값',width:460,headerCssClass:'cellCenter',cssClass:'cellCenter',editor:null}
		   		,{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'번호',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid',editor:null}
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

	$(document).ready(function(){

		window.focus();

		$("#btn_close").button().unbind("click").click(function(){
			self.close();
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
			setPreAfterJobs("<%=aTmpT1[0]%>", "1", "<%=aTmpT1[1]%>", "<%=aTmpT1[2]%>");
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
			setPreAfterJobs("<%=aTmpT1[0]%>", "2", "<%=aTmpT1[1]%>", "<%=aTmpT1[2]%>");
		<%
				}
			}
		%>		
		
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
		
		var task_type = "<%=strTaskType%>";
		
		if (task_type == "MFT"){
			$('#mftTable').show();
		}else if( task_type == "kubernetes" ) {
			$('#kubernetes_yn').show();
		}else if( task_type == "Database" ) {
			$('#database_tb').show();
		}
		$("select[name='execution_type']").val("<%=execution_type%>");
		$("select[name='sel_db_output_format']").val("<%=db_output_format%>");
		
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
		//MFT 추가
		if( task_type == "MFT") {
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
					}
						$(input).attr("disabled", true);
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
	
	function setPreAfterJobs(job_nm, gb, cond, and_or, add){		
			
		var cond_nm = "";
		var cond_dt = "";
		var cond_gb = "";		
		var i = 0;
		var val = "";
				
		if(gb == "1"){
			i = rowsObj_job1.length+1;
			val = "_incond_nm"+i;
		}else if(gb == "2"){
			i = rowsObj_job2.length+1;
			val = "_outcond_nm"+i;
		}
		
		if(job_nm != ""){
						
			cond_nm = "";
			cond_nm += "<div class='gridInput_area'><input type='text' name='job"+val+"' id='job"+val+"' value='"+job_nm+"' style='width:100%;' readonly /></div>";
			
			cond_dt = "";
			cond_dt += "<div class='gridInput_area'>";
			cond_dt += "<input type='text' name='dt"+val+"' id='dt"+val+"' value='"+cond+"' size='6' maxlength='4' readonly />";
			cond_dt += "</div>";
			
			cond_gb = "";
			cond_gb += "<div class='gridInput_area'>";
			cond_gb += "<input type='text' name='gb"+val+"' id='gb"+val+"' value='"+and_or+"' readonly />";
			cond_gb += "</div>";
						
			if(gb == "1"){
				addGridRow(gridObj_1, {
					'grid_idx': i
					,'COND_NM': cond_nm
					,'COND_DT': cond_dt
					,'COND_GB': cond_gb		
					,'CHK_COND_NM': job_nm
				});
				
			}else if(gb == "2"){
				addGridRow(gridObj_2, {
					'grid_idx':i
					,'COND_NM': cond_nm
					,'COND_DT': cond_dt
					,'COND_GB': cond_gb		
					,'CHK_COND_NM': job_nm
				});
			}
		}
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
				
				v_nm += "<div class='gridInput_area'><input type='text' name='nm"+v_id+"' id='nm"+v_id+"' value='"+nm+"' style='width:100%;' readonly></div>";
				v_val += "<div class='gridInput_area'><input type='text' name='val"+v_id+"' id='val"+v_id+"' value='"+val+"' style='width:100%;' readonly></div>"; 
			}
			if(!("<%=strTaskType%>" == 'Database' && nm.startsWith('DB'))){
				if(!("<%=strTaskType%>" == 'MFT' && nm.startsWith('FTP'))){
					if(!("<%=strTaskType%>" == 'kubernetes' && nm.startsWith('UCM'))){
						rowsObj_job4.push({
							'grid_idx':i
							,'VAR_NAME': v_nm
							,'VALUE': v_val		
							,'CHK_VALUE': nm+""+val
						});
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
				}
			}
			gridObj_4.rows = rowsObj_job4; 
			setGridRows(gridObj_4);
				
			dlClose("dl_tmp1");
	}
</script>
</html>