<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.ghayoun.ezjobs.m.domain.*" %>

<%@include file="/jsp/common/inc/header.jsp"%>
<%@include file="/jsp/common/inc/sessionChkPopup.jsp"%>

<%
	Map<String, Object> paramMap 	= CommonUtil.collectParameters(request);

	JobDefineInfoBean docBean		= (JobDefineInfoBean)request.getAttribute("aJobInfo");
	String strPageGubun				= (String)request.getAttribute("page_gubun");  
	String strDataCenter 			= CommonUtil.isNull(paramMap.get("data_center"));
	
	String strOrderId	 		= "";
	String strTableName 		= "";
	String strApplication 		= "";
	String strGroupName 		= "";
	String strMemName 		= "";
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
	
	String strConfirmFlagMent 	= "";
	String strCriticalMent		= "";
	String strCyclicMent		= "";
	String strOdate		 		= "";
	
	String[] aTmp 				= null;
	String[] aTmpT 				= null;
	
	String strCmdLineTemp = "";
	
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
		strRerunInterval	= CommonUtil.isNull(docBean.getRerun_interval());
		strNodeId 			= CommonUtil.isNull(docBean.getNode_id());
		strTableName 		= CommonUtil.isNull(docBean.getTable_name());		
		strTconditionsIn	= CommonUtil.isNull(docBean.getT_conditions_in());
		strTconditionsOut	= CommonUtil.isNull(docBean.getT_conditions_out());
		strTset				= CommonUtil.isNull(docBean.getT_set());
		strOdate			= CommonUtil.isNull(docBean.getOdate());
		
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
	}
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

<script type="text/javascript" src="<%=sContextPath %>/js/jquery-1.9.0.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery-ui.custom.min.js" ></script>
<script type="text/javascript" src="<%=sContextPath %>/js/common.js" ></script>
<script type="text/javascript" src="<%=sContextPath %>/js/popup.js" ></script>
<script type="text/javascript" >

	function addSet() {
		
		var obj = document.getElementById('div_set');
		
		var s = "";
		s += "<table class='board_lst blue' ><colgroup><col width='150px' /><col width='*px' /><col width='40px' /></colgroup>";
		s += "<tbody><tr>";
		s += "<tr>";
		s += "<td ><input type='text' class='input' name='m_var_name' style='ime-mode:disabled;width:80%;' maxlength='40'/></td>";
		s += "<td ><input type='text' class='input' name='m_var_value' style='ime-mode:disabled;width:80%;' maxlength='214'/></td>";
		s += "<td><a name='del_button3' onclick=\"delSet(getObjIdx(this, this.name));\" class='btn_white_h24' style='cursor:hand;''>-</a></td>";
		s += "</tr></tbody>";
		s += "</table>";
		
		$(obj).append(s);
	}
	function delSet(idx){
		$('#div_set').children().eq(idx).remove();
	}
	function goPrc(order_id) {

		var frm = document.frm1;
		
		frm.order_id.value = order_id;
	
		// 금칙 문자 체크.
		isValid_C_M();
	
		if ( document.getElementById('is_valid_flag').value == "false" ) {
			document.getElementById('is_valid_flag').value = "";
			return;
		}		
		
		if( isNullInput(document.getElementById('owner'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[계정명]","") %>') ) return;			
		if( isNullInput(document.getElementById('application'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[APP]","") %>') ) return;		
		if( isNullInput(document.getElementById('group_name'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[GRP]","") %>') ) return;
		
		var v_task_type = document.getElementById('task_type').value.toLowerCase();
		
		if (v_task_type=='command') {
			var full_command = $('#command_only').val();
			var paramList = $('#cmdLineTable > tbody > tr');
			var count = paramList.length;
			for (var i = 0; i < count; i++) {
				var param = paramList.eq(i).find('#command_param').val();
				if (param.length > 0)  {
					full_command += (" " + param);
				}
			}
			$('#command').val(full_command);
		}
		
		if(v_task_type=='command'){
			if( isNullInput(document.getElementById('command'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[실행명령어]","") %>') ) return;		
		}else if(v_task_type=='job'){
			if( isNullInput(document.getElementById('mem_name'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[실행쉘이름]","") %>') ) return;
			if( isNullInput(document.getElementById('mem_lib'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[실행쉘경로]","") %>') ) return;	
		}
	
		if ( v_task_type == "job" || v_task_type == "command" || v_task_type == "dummy" ) {
			if( isNullInput(document.getElementById('node_id'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[수행서버]","") %>') ) return;
		}
		
		var s = "";
		obj = document.getElementsByName('m_var_name');
		if( obj!=null && obj.length>0 ){
			for( var i=0; i<obj.length; i++ ){
				if( trim(obj[i].value) != "" ){
					var sTmp = obj[i].value;					
					sTmp += (","+document.getElementsByName('m_var_value')[i].value);
	
					if ( document.getElementsByName('m_var_value')[i].value == "" ) {
						alert("[변수]의 Value를 확인해 주세요.");
						return;
					}
					
					s += (s=="")? sTmp:("|"+sTmp);
				}
			}
			frm.t_set.value = s;
		}
		
	
		s = "";
		obj = document.getElementsByName('m_in_condition_name');
		if( obj!=null && obj.length>0 ){
			for( var i=0; i<obj.length; i++ ){
				if( trim(obj[i].value) != "" ){
					var sTmp = obj[i].value;
					sTmp += (","+document.getElementsByName('m_in_condition_date')[i].value);
					sTmp += (","+document.getElementsByName('m_in_condition_and_or')[i].value);
					s += (s=="")? sTmp:("|"+sTmp);
				}
			}
			frm.t_conditions_in.value = s;
		}
		
		s = "";
		obj = document.getElementsByName('m_out_condition_name');
		if( obj!=null && obj.length>0 ){
			for( var i=0; i<obj.length; i++ ){
				if( trim(obj[i].value) != "" ){
					var sTmp = obj[i].value;
					sTmp += (","+document.getElementsByName('m_out_condition_date')[i].value);
					sTmp += (","+document.getElementsByName('m_out_condition_effect')[i].value);
					s += (s=="")? sTmp:("|"+sTmp);
				}
			}
			frm.t_conditions_out.value = s;
		}
	
		

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

		// 실행명령어의 경로 및 파일명은 변경 불가능.
		if ( cmd_line != command ) {
			alert("실행명령어는 뒤의 파라미터만 변경 가능합니다.");
			return;
		}
	
		if ( confirm("실시간 작업을 수정하시겠습니까?") ) {
		
			//try{top.mainFrame.viewProgBar(true);}catch(e){}
			try{viewProgBar(true);}catch(e){}
			//frm.target = "prcFrame";
			frm.action = "<%=sContextPath%>/tPopup.ez?c=ez033_p";
			frm.submit();	
		}
	}
	
	function addConditionsIn(){
		var obj = document.getElementById('div_conditions_in');
		
		
		var s = "";
		s += "<table class='board_lst blue' ><colgroup><col width='*px' /><col width='100px' /><col width='100px' /><col width='40px' /></colgroup>";
		s += "<tbody><tr>";
		s += "<td class='tLeft'><input type='text' name='m_in_condition_name' onkeypress='if(event.keyCode==32 || event.keyCode==39) event.returnValue = false;' maxlength='255' class='input' style='ime-mode:disabled;width:70%;' />";
		s += "<a href=\"Javascript:popupDefJob('"+m_in_condition_name+"','"+getObjIdx(this,this.name)+"');\" name='img_in_condition_name' onclick= class='btn_white_h24'>검색</a></td>";
		s += "<td><select name='m_in_condition_date' >";
		<%
		aTmp = CommonUtil.getMessage("JOB.IN_CONDITION_DATE").split(",");
		for(int i=0;i<aTmp.length; i++){
		%>
			s += "<option value='<%=aTmp[i] %>'><%=aTmp[i] %></option>";
		<%}%>
		s += "</select></td>";
		s += "<td><select name='m_in_condition_and_or' >";
		<%
		aTmp = CommonUtil.getMessage("JOB.IN_CONDITION_AND_OR").split(",");
		for(int i=0;i<aTmp.length; i++){
			String[] aTmp1 = aTmp[i].split("[|]");
		%>
			s += "<option value='<%=aTmp1[0] %>'><%=aTmp1[1] %></option>";
		<%}%>
		s += "</select></td>";
		s += "<td><a name='del_button' onclick=\"delConditionsIn(getObjIdx(this, this.name));\" class='btn_white_h24' style='cursor:hand;''>-</a></td>";
		s += "</tr></tbody>";
		s += "</table>";
		
		$(obj).append(s);
	}
	function delConditionsIn(idx) {
		$('#div_conditions_in').children().eq(idx).remove();
	}

	function addConditionsOut(){
		var obj = document.getElementById('div_conditions_out');
		
		var s = "";
		s += "<table class='board_lst blue' ><colgroup><col width='*px' /><col width='100px' /><col width='100px' /><col width='40px' /></colgroup>";
		s += "<tbody><tr>";
		s += "<td class='tLeft'><input type='text' name='m_out_condition_name' onkeypress='if(event.keyCode==32 || event.keyCode==39) event.returnValue = false;' maxlength='255' class='input' style='ime-mode:disabled;width:70%;' />";
		s += "<a href=\"Javascript:popupDefJob('"+m_in_condition_name+"','"+getObjIdx(this,this.name)+"');\" name='img_out_condition_name' class='btn_white_h24'>검색</a></td>";
		s += "<td><select name='m_out_condition_date' >";
		<%
		aTmp = CommonUtil.getMessage("JOB.OUT_CONDITION_DATE").split(",");
		for(int i=0;i<aTmp.length; i++){
		%>
			s += "<option value='<%=aTmp[i] %>'><%=aTmp[i] %></option>";
		<%}%>
		s += "</select></td>";
		s += "<td><select name='m_out_condition_effect' >";
		<%
		aTmp = CommonUtil.getMessage("JOB.OUT_CONDITION_EFFECT").split(",");
		for(int i=0;i<aTmp.length; i++){
			String[] aTmp1 = aTmp[i].split("[|]");
		%>
			s += "<option value='<%=aTmp1[0] %>'><%=aTmp1[1] %></option>";
		<%}%>
		s += "</select></td>";
		s += "<td><a name='del_button2' onclick=\"delConditionsOut(getObjIdx(this, this.name));\" class='btn_white_h24' style='cursor:hand;''>-</a></td>";	
		s += "</tr></tbody>";
		s += "</table>";
		
		$(obj).append(s);
	}
	function delConditionsOut(idx) {
		$('#div_conditions_out').children().eq(idx).remove();
	}

	function popupDefJob(name,idx){
		var vUrl = "<%=sContextPath%>/tPopup.ez?c=ez001&type=02&name="+name+"&idx="+idx;
		openPopupCenter1(vUrl,"popupDefJob",980,500);
	}
	
	function addParam() {
		var tableBody = $('#cmdLineTable').find('tbody');
		var count = tableBody.find('tr').length - 1;
		var tr = tableBody.find('tr:eq(0)').clone();
		tr.show();
		tr.find('td:eq(0)').text(++count);
		tr.find('td:eq(1)').find('#command_param').val('');
		tableBody.append(tr);
	}

	function delParam(obj) {
		$(obj).parent().parent().remove();
		
	}
	
	$(document).ready(function(){
	// 작업상태변경 메뉴에서만 실시간 작업 변경 가능.
	<% if (strPageGubun.equals("") ) { %>
		$('.btn_white_h24').hide();		
	<%}%>
	});
//-->
</script>
</head>

<body style="background:#fff;">

<form id='frm1' name='frm1' method='post' onsubmit='return false;'>
	<input type="hidden" name="is_valid_flag" id="is_valid_flag"/>
	<input type="hidden" name="order_id" />
	<input type="hidden" name="t_conditions_in" id="t_conditions_in" />
	<input type="hidden" name="t_conditions_out" id="t_conditions_out"  />
	<input type="hidden" name="t_set" id="t_set"  />
	
	<input type="hidden" name="task_type" 		value="<%=strTaskType%>" id="task_type" />
	<input type="hidden" name="data_center" 	value="<%=strDataCenter%>" />
	<input type="hidden" name="job_name"	 	value="<%=strJobName%>" />
	
	
<table style='width:98%;height:99%;border:none;'>
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
	<tr>
		<td style="text-align:right;">			
			<%
				// 작업상태변경 메뉴에서만 실시간 작업 변경 가능.
				if ( !strPageGubun.equals("") ) {
			%>
					<span id="btn_save">저장</span>
			<%
				}
			%>
			<span id="btn_close">닫기</span>			
		</td>
	</tr>
	<tr><td height="5px;"></td></tr>
	<tr style='height:10px;'>
		<td style='vertical-align:top;'>			
				<h4 class="ui-widget-header ui-corner-all">
				<table style="width:100%">
					<colgroup>
						<col width="25%" />
						<col width="75%" />
					</colgroup>
									
					<tr>
						<th><div class='cellTitle_3'>작업명</div></th>
						<td><div class='cellContent_3'>&nbsp;<%=strJobName%></div></td>
					</tr>
					<tr>
						<th><div class='cellTitle_3'>작업설명</div></th>
						<td><div class='cellContent_3'>&nbsp;<%=strDescription%></div></td>
					</tr>
					<tr>
						<th><div class='cellTitle_3'>작업타입</div></th>
						<td><div class='cellContent_3'>&nbsp;<%=strTaskType%></div></td>
					</tr>
					<tr>
						<th><div class='cellTitle_3'>TAB</div></th>
						<td><div class='cellContent_3'>&nbsp;<%=strTableName%></div></td>
					</tr>
					<tr>
						<th><div class='cellTitle_3'>APP</div></th>
						<%
							if ( !strPageGubun.equals("") ) {
						%>
								<td>
									<div class='cellContent_3'>&nbsp;
									<input type='text' id='application' name='application' class='input' value='<%=strApplication%>' style='width:60%' maxlength='20' onkeypress='if(event.keyCode==32 || event.keyCode==39) event.returnValue = false;' /> 
									</div>
								</td>
						<%
							} else {
						%>
								<td><div class='cellContent_3'>&nbsp;<%=strApplication%></div></td>
						<%
							}
						%>						
					</tr>
					<tr>
						<th><div class='cellTitle_3'>GRP</div></th>
						<%
							if ( !strPageGubun.equals("") ) {
						%>
								<td>
									<div class='cellContent_3'>
									<input type='text' id='group_name' name='group_name' class='input' value='<%=strGroupName%>' style='width:60%' maxlength='64' onkeypress='if(event.keyCode==32 || event.keyCode==39) event.returnValue = false;' /> 
									</div>
								</td>
						<%
							} else {
						%>
								<td><div class='cellContent_3'>&nbsp;<%=strGroupName%></div></td>
						<%
							}
						%>
					</tr>
					<tr>
						<th><div class='cellTitle_3'>실행쉘이름</div></th>
						<%
							if ( !strPageGubun.equals("") ) {
						%>
								<td>
									<div class='cellContent_3'>&nbsp;
									<input type='text' id='mem_name' name='mem_name' class='input' value='<%=strMemName%>' style='width:90%' maxlength='64' onkeypress='if(event.keyCode==32) event.returnValue = false;' style='ime-mode:disabled;'/> 
									</div>
								</td>
						<%
							} else {
						%>
								<td><div class='cellContent_3'>&nbsp;<%=strMemName%></div></td>
						<%
							}
						%>
					</tr>
					<tr>
						<th><div class='cellTitle_3'>실행쉘경로</div></th>
						<%
							if ( !strPageGubun.equals("") ) {
						%>
								<td>
									<div class='cellContent_3'>&nbsp;
									<input type='text' id='mem_lib' name='mem_lib' class='input' value='<%=strMemLib%>' style='width:90%' maxlength='255' onkeypress='if(event.keyCode==32) event.returnValue = false;' style='ime-mode:disabled;' /> 
									</div>
								</td>
						<%
							} else {
						%>
								<td><div class='cellContent_3'>&nbsp;<%=strMemLib%></div></td>
						<%
							}
						%>
					</tr>
					<tr>
						<th><div class='cellTitle_3'>실행계정</div></th>
						<%
							if ( !strPageGubun.equals("") ) {
						%>
								<td>
									<div class='cellContent_3'>&nbsp;
									<input type='text' id='owner' name='owner' class='input' value='<%=strOwner%>' style='width:100' maxlength='30' />
									</div>
								</td>
						<%
							} else {
						%>
								<td><div class='cellContent_3'>&nbsp;<%=strOwner%></div></td>
						<%
							}
						%>
					</tr>
					<tr>
						<th><div class='cellTitle_3'>최대대기일</div></th>
						<%
							if ( !strPageGubun.equals("") ) {
						%>
								<td>
									<div class='cellContent_3'>&nbsp;
									<input type='text' id='max_wait' name='max_wait' class='input' value='<%=strMaxWait%>' size='4' maxlength='2' onkeypress='if(event.keyCode==32 || event.keyCode==39) event.returnValue = false;' style='ime-mode:disabled;' /> 
									</div>
								</td>
						<%
							} else {
						%>
								<td><div class='cellContent_3'>&nbsp;<%=strMaxWait%></div></td>
						<%
							}
						%>
					</tr>
					<tr>
						<th><div class='cellTitle_3'>시작 및 종료시간</div></th>
						<%
							if ( !strPageGubun.equals("") ) {
						%>
								<td>
									<div class='cellContent_3'>&nbsp;
									<input type='text' id='time_from' name='time_from' class='input' value='<%=strTimeFrom%>' size='6' maxlength='4' onkeypress='if(event.keyCode==32 || event.keyCode==39) event.returnValue = false;' style='ime-mode:disabled;' /> to 
									<input type='text' id='time_until' name='time_until' class='input' value='<%=strTimeUntil%>' size='6' maxlength='4' onkeypress='if(event.keyCode==32 || event.keyCode==39) event.returnValue = false;' style='ime-mode:disabled;' /> 
									</div>
								</td>
						<%
							} else {
						%>
								<td><div class='cellContent_3'>&nbsp;<%=strTimeFrom%> to <%=strTimeUntil%></div></td>
						<%
							}
						%>
					</tr>
					<tr>
						<th><div class='cellTitle_3'>최대반복횟수</div></th>
						<%
							if ( !strPageGubun.equals("") ) {
						%>
								<td>
									<div class='cellContent_3'>&nbsp;
									<input type='text' id='rerun_max' name='rerun_max' class='input' value='<%=strRerunMax%>' size='4' maxlength='2' onkeypress='if(event.keyCode==32 || event.keyCode==39) event.returnValue = false;' style='ime-mode:disabled;' /> 
									</div>
								</td>
						<%
							} else {
						%>
								<td><div class='cellContent_3'>&nbsp;<%=strRerunMax%></div></td>
						<%
							}
						%>
					</tr>
					<tr>
						<th><div class='cellTitle_3'>실행명령어</div></th>
						<%
							if ( !strPageGubun.equals("") ) {
								
								if (strTaskType.equals("Command")) {
									String[] cmdLine = strCmdLine.split(" ");
									
									%>
								<td>
									<div class='cellContent_3'>&nbsp;
									<input type="hidden" id='command' name='command' value="<%=strCmdLine%>" />
									<input type='text' id='command_only' class='input' value="<%=cmdLine[0]%>" style='width:90%' maxlength='512' />
									<table id="cmdLineTable" class="board_lst orange" style="width: 90%">
										<colgroup>
											<col width="50px" />
											<col width="*px" />
											<col width="40px" />
										</colgroup>
										<thead>
											<tr>
												<th>순서</th>
												<th>파라메타</th>
												<th>
													<a onclick='addParam()' class="btn_white_h24" style="cursor:hand;">+</a>
												</th>
											</tr>
										</thead>
										<tbody>
											<%
												for (int i = 1; i < cmdLine.length; i++) {
											%>
											<tr style="display: none;">
												<td>0</td>
												<td>
													<input type='text' id='command_param' class='input' value="" style='width:90%' />
												</td>
												<td><a onclick="delParam(this)" class='btn_white_h24' style='cursor:hand;'>-</a></td>
											</tr>
											<tr>
												<td><%=i%></td>
												<td>
													<input type='text' id='command_param' class='input' value="<%=cmdLine[i]%>" style='width:90%' />
												</td>
												<td><a onclick="delParam(this)" class='btn_white_h24' style='cursor:hand;'>-</a></td>
											</tr>
											<%
												}
											%>
										</tbody>
									</table>
									</div>
								</td>
									<%
								} else {
									%>
								<td>
									<div class='cellContent_3'>&nbsp;
									<input type='text' id='command' name='command' class='input' value="<%=strCmdLine%>" style='width:90%' maxlength='512' />
									</div>
								</td>
						<%
								}
						%>
						<%
							} else {
						%>
								<td><div class='cellContent_3'>&nbsp;<%=strCmdLine%></div></td>
						<%
							}																																																																																																																																																																																																																																																																																				
						%>
					</tr>
					<tr>
						<th><div class='cellTitle_3'>반복작업</div></th>
						<%
							if ( !strPageGubun.equals("") ) {
						%>
								<td>
									<div class='cellContent_3'>&nbsp;
									<select id='cyclic' name='cyclic' style="height:21px;">
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
						<%
							} else {
						%>
								<td><div class='cellContent_3'>&nbsp;<%=strCyclicMent%></div></td>
						<%
							}																																																																																																																																																																																																																																																																																				
						%>	
					</tr>
					<tr>
						<th><div class='cellTitle_3'>반복주기(분)</div></th>
						<%
							if ( !strPageGubun.equals("") ) {
						%>
								<td>
									<div class='cellContent_3'>&nbsp;
									<input type='text' id='rerun_interval' name='rerun_interval' class='input' value="<%=strRerunInterval%>" size='5' maxlength='5' onkeypress='if(event.keyCode==32 || event.keyCode==39) event.returnValue = false;' style='ime-mode:disabled;' />
									</div>
								</td>
						<%
							} else {
						%>
								<td><div class='cellContent_3'>&nbsp;<%=strRerunMax%></div></td>
						<%
							}
						%>
					</tr>
					<tr>
						<th><div class='cellTitle_3'>수행서버</div></th>
						<%
							if ( !strPageGubun.equals("") ) {
						%>
								<td>
									<div class='cellContent_3'>&nbsp;
									<input type='text' id='node_id' name='node_id' class='input' value='<%=strNodeId%>' style='width:90%' maxlength='50' onkeypress='if(event.keyCode==32 || event.keyCode==39) event.returnValue = false;' style='ime-mode:disabled;' /> 
									</div>
								</td>
						<%
							} else {
						%>
								<td><div class='cellContent_3'>&nbsp;<%=strNodeId%></div></td>
						<%
							}
						%>	
					</tr>
				</table>
					
				<table style="width:100%;">
					<caption>변수</caption>
					<colgroup>
						<col width="25%" />
						<col width="75%" />						
					</colgroup>
					<tbody>
					<tr>
						<th colspan="2"><div class='cellTitle'>변수</div></th>
						<!--th>
							<a onclick='addSet();' class="btn_white_h24" style="cursor:hand;">+</a>
						</th-->
					</tr>						
					<tr>
						<th><div class='cellTitle_3'>Var Name</div></th>
						<th><div class='cellTitle'>Value</div></th>						
					</tr>
					</tbody>
				</table>
					
					<div id='div_set'>
				
					<%
						if( null!=docBean.getT_set() && docBean.getT_set().trim().length()>0 ) {
							aTmpT = CommonUtil.E2K(docBean.getT_set()).split("[|]");
							for(int t=0; null!=aTmpT&&t<aTmpT.length; t++ ) {
								String[] aTmpT1 = aTmpT[t].split(",",2);
					%>
								<table style="width:100%">
									<colgroup>
										<col width="25%" />
										<col width="75%" />										
									</colgroup>
									<tbody>
									<tr>
										<td>
											<div class='cellContent_3'>&nbsp;
											&nbsp;<input type='text' name='m_var_name' value='<%=aTmpT1[0] %>' style='ime-mode:disabled;width:80%;' maxlength='40' />									
											</div>
										</td>
										<td>
											<div class='cellContent_3'>&nbsp;
											&nbsp;<input type='text' name='m_var_value' value='<%=aTmpT1[1] %>' style='ime-mode:disabled;width:80%;' maxlength='214'/>		
											</div>
										</td>										
									</tr>
									</tbody>
								</table>
					<%
							}
						}
					%>
						
					</div>
		
			<table style="width:100%;">
				<caption>선후행작업 리스트</caption>
				<colgroup>
					<col width="60%" />
					<col width="20%" />
					<col width="20%" />					
				</colgroup>
				<tbody>
				<tr>
					<th colspan="3"><div class='cellTitle'>선행작업조건</div></th>					
				</tr>						
				<tr>
					<th><div class='cellTitle_3'>선행작업조건명</div></th>
					<th><div class='cellTitle_3'>일자유형</div></th>
					<th><div class='cellTitle'>구분</div></th>				
				</tr>
				</tbody>
			</table>
				
			
				
			<%
				if( null!=docBean.getT_conditions_in() && docBean.getT_conditions_in().trim().length()>0 ){
					aTmpT = CommonUtil.E2K(docBean.getT_conditions_in()).split("[|]");
					for(int t=0; null!=aTmpT&&t<aTmpT.length; t++ ){
						String[] aTmpT1 = aTmpT[t].split(",",3);
			%>
			<table style="width:100%;">
				<colgroup>
					<col width="60%" />
					<col width="20%" />
					<col width="20%" />	
				</colgroup>
				<tbody>
				<tr>
					<td class='tLeft'><div class='cellContent_3'>
						<input type="text" name='m_in_condition_name' value="<%=aTmpT1[0] %>" onkeypress='if(event.keyCode==32 || event.keyCode==39) event.returnValue = false;' maxlength='255' style="ime-mode:disabled;width:70%;" />
						<a href="Javascript:popupDefJob('m_in_condition_name',getObjIdx(this,this.name));" name='img_in_condition_name' class="btn_white_h24">검색</a>
						</div>
					</td>
					<td>
						<div class='cellContent_3'>
						<select name='m_in_condition_date' >
						<%
							aTmp = CommonUtil.getMessage("JOB.IN_CONDITION_DATE").split(",");
							for(int i=0;i<aTmp.length; i++){
								out.println("<option value='"+aTmp[i]+"' "+( (aTmp[i].equals(aTmpT1[1]))? " selected ":"" )+" >"+aTmp[i]+"</option>");
							}
						%>
						</select>	
						</div>					
					</td>
					<td>
						<div class='cellContent_3'>
						<select name='m_in_condition_and_or'>
						<%
							aTmp = CommonUtil.getMessage("JOB.IN_CONDITION_AND_OR").split(",");
							for(int i=0;i<aTmp.length; i++){
								String[] aTmp1 = aTmp[i].split("[|]");
								out.println("<option value='"+aTmp1[0]+"' "+( (aTmp1[0].equals(aTmpT1[2]))? " selected ":"" )+" >"+aTmp1[1]+"</option>");
							}
						%>
						</select>	
						</div>					
					</td>					
				</tr>
				</tbody>
			</table>
			<%
					}
				}
			%>
			
			<table style="width:100%;">
				<caption>선후행작업 리스트</caption>
				<colgroup>
					<col width="60%" />
					<col width="20%" />
					<col width="20%" />	
				</colgroup>
				<tbody>
				<tr>
					<th colspan="3"><div class='cellTitle'>후행작업조건</div></th>					
				</tr>						
				<tr>
					<th><div class='cellTitle_3'>후행작업조건명</div></th>
					<th><div class='cellTitle_3'>일자유형</div></th>
					<th><div class='cellTitle'>구분</div></th>					
				</tr>
				</tbody>
			</table>
					
								
			<%
				if( null!=docBean.getT_conditions_out() && docBean.getT_conditions_out().trim().length()>0 ){
					aTmpT = CommonUtil.E2K(docBean.getT_conditions_out()).split("[|]");
					for(int t=0; null!=aTmpT&&t<aTmpT.length; t++ ){
						String[] aTmpT1 = aTmpT[t].split(",",3);
			%>
						<table style="width:100%">
							<colgroup>
								<col width="60%" />
								<col width="20%" />
								<col width="20%" />	
							</colgroup>
							<tbody>
							<tr>
								<td class='tLeft'>
									<div class='cellContent_3'>
									<input type="text" name='m_out_condition_name' maxlength='255' value='<%=aTmpT1[0]%>' onkeypress='if(event.keyCode==32 || event.keyCode==39) event.returnValue = false;' style='ime-mode:disabled;width:70%;'  />
									<a href="JavaScript:popupDefJob('m_out_condition_name',getObjIdx(this,this.name));" name='img_out_condition_name' class="btn_white_h24">검색</a></td>
									</div>
								<td>
									<div class='cellContent_3'>
									<select name='m_out_condition_date' >
									<%
										aTmp = CommonUtil.getMessage("JOB.OUT_CONDITION_DATE").split(",");
										for(int i=0;i<aTmp.length; i++){
											out.println("<option value='"+aTmp[i]+"' "+( (aTmp[i].equals(aTmpT1[1]))? " selected ":"" )+" >"+aTmp[i]+"</option>");
										}
									%>
									</select>		
									</div>				
								</td>
								<td>
									<div class='cellContent_3'>
									<select name='m_out_condition_effect' >
									<%
										aTmp = CommonUtil.getMessage("JOB.OUT_CONDITION_EFFECT").split(",");
										for(int i=0;i<aTmp.length; i++){
											String[] aTmp1 = aTmp[i].split("[|]");
											out.println("<option value='"+aTmp1[0]+"' "+( (aTmp1[0].equals(aTmpT1[2]))? " selected ":"" )+" >"+aTmp1[1]+"</option>");
										}
									%>
									</select>
									</div>						
								</td>
								
							</tr>					
							</tbody>
						</table>
			<%
					}
				}
			%>
					
		
			</h4>
		</td>
	</tr>
</table>
				
	</form>

</body>
<script>
	$(document).ready(function(){
		
		$("#btn_close").button().unbind("click").click(function(){
			self.close();
		});
		
		$("#btn_save").button().unbind("click").click(function(){
			goPrc('<%=strOrderId%>');
		});
	});
</script>
</html>