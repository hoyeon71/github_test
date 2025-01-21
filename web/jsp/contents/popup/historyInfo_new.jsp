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
	
	JobDefineInfoBean docBean	= (JobDefineInfoBean)request.getAttribute("aJobInfo");
	String strPageGubun			= (String)request.getAttribute("page_gubun");
	String strDataCenter 		= CommonUtil.isNull(paramMap.get("data_center"));
	
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
		strTableName 		= CommonUtil.isNull(docBean.getTable_name());		
		strTconditionsIn	= CommonUtil.isNull(docBean.getT_conditions_in());
		strTconditionsOut	= CommonUtil.isNull(docBean.getT_conditions_out());
		strTset				= CommonUtil.isNull(docBean.getT_set());
		strOdate			= CommonUtil.isNull(docBean.getOdate());
		strCpuId			= CommonUtil.isNull(docBean.getCpu_id());		
		strCalendarNm		= CommonUtil.isNull(docBean.getCalendar_nm());

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
	
	String strServerGb 		= CommonUtil.isNull(CommonUtil.getMessage("SERVER_GB"));

	// 세션값 가져오기.
	String strSessionUserGb	= S_USER_GB;
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
	
<table style='width:98%;height:98%;border:none;padding-left:15px;'>
	<tr style='height:10px;'>
		<td style='vertical-align:top;'>
			<h4 class="ui-widget-header ui-corner-all">
				<div class='title_area' style="width:100%; text-align:left;">
					<span><%=CommonUtil.getMessage("POPUP.HISTORY_JOB_INFO.TITLE") %></span>					
				</div>				
			</h4>
		</td>
	</tr>
	<tr><td height="5px;"></td></tr>
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
						<td><div class='cellContent_popup' style="height:auto;"><%=strJobName%></div></td>
						<th class='cellTitle_ez_right'>작업타입</th>
						<td><div class='cellContent_popup' style="height:auto;"><%=strTaskType%></div></td>
					</tr>
					<tr>
						<th rowspan="2" class='cellTitle_ez_right' style='margin-right:20px;'>작업 설명</th>
						<td rowspan="2" colspan="3"><div class='cellContent_popup' style='width:99%;height:auto;'><%=strDescription%></div></td>
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
								<input type='hidden' id='node_id' name='node_id' value='<%=strNodeId%>' style='width:96%; height:21px;' maxlength='50' />
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
						<th class='cellTitle_ez_right'>최대대기일</th>
						<td>
							<div class='cellContent_popup'>
								<%=strMaxWait%>
								<input type='hidden' id='max_wait' name='max_wait' value='<%=strMaxWait%>' size='4' maxlength='2' style='width:96%; height:21px;' onkeypress='if(event.keyCode==32 || event.keyCode==39) event.returnValue = false;' style='ime-mode:disabled;' readOnly /> 
							</div>
						</td>
					</tr>					
					<tr>
						<th class='cellTitle_ez_right'>시작 및 종료시간</th>
						<td colspan="3">
							<div class='cellContent_popup'>
								<%=strTimeFrom%> to <%=strTimeUntil%>
							</div>
						</td>
					</tr>
					<tr>
						<th class='cellTitle_ez_right'>작업수행명령</th>
						<td colspan="3">
							<div class='cellContent_popup'>
								<%=strCmdLine%>
								<!-- <input type='text' id='command_only' name='command_only' value="<%=strCmdLine%>" style='width:99%; height:21px;' readOnly /> -->
								<input type='hidden' id='command' name='command' value="<%=strCmdLine%>" style='width:99%; height:21px;' readOnly />
							</div>
						</td>
					</tr>
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
			{formatter:gridCellNoneFormatter,field:'COND_NM',id:'COND_NM',name:'선행조건명',width:200,headerCssClass:'cellCenter',cssClass:'cellCenter'}
	   		,{formatter:gridCellNoneFormatter,field:'COND_DT',id:'COND_DT',name:'일자유형',width:70,headerCssClass:'cellCenter',cssClass:'cellCenter'}
	   		,{formatter:gridCellNoneFormatter,field:'COND_GB',id:'COND_GB',name:'구분',width:50,headerCssClass:'cellCenter',cssClass:'cellCenter'}
	   		,{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'번호',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   		
	   	]
		,rows:[]
		,vscroll:false
	};
	
	var gridObj_2 = {
		id : "<%=gridId_2 %>"
		,colModel:[
			{formatter:gridCellNoneFormatter,field:'COND_NM',id:'COND_NM',name:'후행조건명',width:190,headerCssClass:'cellCenter',cssClass:'cellCenter'}
	   		,{formatter:gridCellNoneFormatter,field:'COND_DT',id:'COND_DT',name:'일자유형',width:70,headerCssClass:'cellCenter',cssClass:'cellCenter'}
	   		,{formatter:gridCellNoneFormatter,field:'COND_GB',id:'COND_GB',name:'구분',width:50,headerCssClass:'cellCenter',cssClass:'cellCenter'}
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
		   		,{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'번호',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
		   		,{formatter:gridCellNoneFormatter,field:'CHK_VALUE',id:'CHK_VALUE',name:'CHK_VALUE',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
		   	]
			,rows:[]
			,vscroll:false
		};
	
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
			cond_nm += "<div class='gridInput_area'><input type='text' name='job"+val+"' id='job"+val+"' value='"+job_nm+"' style='width:100%;' readonly></div>";
			
			cond_dt = "";
			cond_dt += "<div class='gridInput_area'>";
			cond_dt += "<input type='text' name='dt"+val+"' id='dt"+val+"' value='"+cond+"' size='6' maxlength='4' readonly>";
			cond_dt += "</div>";
			
			cond_gb = "";
			cond_gb += "<div class='gridInput_area'>";
			cond_gb += "<input type='text' name='gb"+val+"' id='gb"+val+"' value='"+and_or+"' readonly>";
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
			
			rowsObj_job4.push({
				'grid_idx':i
				,'VAR_NAME': v_nm
				,'VALUE': v_val		
				,'CHK_VALUE': nm+""+val
			});
			gridObj_4.rows = rowsObj_job4; 
			setGridRows(gridObj_4);
				
			dlClose("dl_tmp1");
	}

</script>
</html>