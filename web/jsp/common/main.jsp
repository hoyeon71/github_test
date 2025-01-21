<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/jsp/common/inc/header.jsp"%>
<%
	Map<String, Object> paramMap = CommonUtil.collectParameters(request);
	String aGb[] = null;

	String c = CommonUtil.isNull(paramMap.get("c"));

	String gridId_1 = "g_"+c+"_1";
	String gridId_2 = "g_"+c+"_2";
	String gridId_3 = "g_"+c+"_3";
	String gridId_4 = "g_"+c+"_4";
	String gridId_5 = "g_"+c+"_5";
	String gridId_6 = "g_"+c+"_6";
	String gridId_7 = "g_"+c+"_7";

	String strServerGb 		= CommonUtil.isNull(CommonUtil.getMessage("SERVER_GB"));
	String strBoardCd		= "";

	if ( strServerGb.equals("D") ) {
		strBoardCd = "7";
	} else if( strServerGb.equals("T")) {
		strBoardCd = "14";
	}else if( strServerGb.equals("P")) {
		strBoardCd = "6";
	}

	request.getSession().setAttribute("ALERT_CLOSE", "Y");

	String strAlarmChk1 = CommonUtil.isNull(request.getSession().getAttribute("alarm_chk1"));
	String strAlarmChk2 = CommonUtil.isNull(request.getSession().getAttribute("alarm_chk2"));
	String strAlarmChk3 = CommonUtil.isNull(request.getSession().getAttribute("alarm_chk3"));

	session.removeAttribute("alarm_chk1");
	session.removeAttribute("alarm_chk2");
	session.removeAttribute("alarm_chk3");

	String odate = CommonUtil.isNull(paramMap.get("odate"));
	String strSessionDcCode = S_D_C_CODE;
	String s_login_chk = S_LOGIN_CHK;

%>

<c:set var="gb01" value="${fn:split(paramMap.gb_01,',')}"/>
<c:set var="gb02" value="${fn:split(paramMap.gb_02,',')}"/>
<c:set var="gb03" value="${fn:split(paramMap.gb_03,',')}"/>
<c:set var="gb04" value="${fn:split(paramMap.gb_04,',')}"/>

<script type="text/javascript" src="<%=request.getContextPath() %>/js/SlickGrid-2.1.0/slick.editors.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/SlickGrid-2.1.0/slick.formatters.js" ></script>

<form id="f_s" name="f_s" method="post" action="" onsubmit="return false;">
	<input type="hidden" name="odate" value="${ODATE}" />
	<input type="hidden" name="data_center_code"  />
	<input type="hidden" name="data_center"  />
	<input type="hidden" name="active_net_name"  />
	<input type="hidden" name="status"  />
	<input type="hidden" name="user_cd"  />
</form>
<form name="f_tmp" id="f_tmp" method="post" onsubmit="return false;">
	<input type="hidden" name="ori_con" 		id="ori_con"/>
	<input type="hidden" name="new_con" 		id="new_con"/>
</form>
<div id="tabs" style='widht:100%;height:100%;'>
	<div id='ly_t-tabs' >
		<ul id='t-tabs'>
			<li id='t-tabs-M' onclick="javascript:resizeTabContent();"><a href='#tabs-M'  style='color:black !important;' >메인</a></li>
		</ul>
	</div>
	<div id="tabs-M" style='margin:0px;padding:0px;width:100%;height:100%;'>
		<table style="width:100%;height:99%;">
			<tr style="height:50%;">
				<td style="width:50%; height:50%;" align="center">
					<table style="width:100%;height:40%;" class="ui-widget-header ui-corner-all">
						<tr style="height:10px;">
							<td>
								<h4 class="ui-widget-header ui-corner-all">
									<img src="/imgs/btn/btn_in.gif" width="21" height="21" align="absmiddle" />실시간작업 현황
								</h4>
							</td>
						</tr>
						<tr>
							<td id='ly_<%=gridId_4%>' style='vertical-align:top;'>
								<div id="<%=gridId_4%>"></div>
							</td>
						</tr>
					</table>

					<table style="width:100%;height:30%;" class="ui-widget-header ui-corner-all">
						<tr style="height:10px;">
							<td>
								<h4 class="ui-widget-header ui-corner-all">
									<img src="/imgs/btn/btn_in.gif" width="21" height="21" align="absmiddle" />결재 진행 현황 [일주일 내]
								</h4>
							</td>
						</tr>
						<tr>
							<td id='ly_<%=gridId_5%>' style='vertical-align:top;'>
								<div id="<%=gridId_5%>"></div>
							</td>
						</tr>
					</table>

					<table style="width:100%;height:30%;" class="ui-widget-header ui-corner-all">
						<tr style="height:10px;">
							<td>
								<h4 class="ui-widget-header ui-corner-all">
									<img src="/imgs/btn/btn_in.gif" width="21" height="21" align="absmiddle" />반영 진행 현황 [일주일 내]
								</h4>
							</td>
						</tr>
						<tr>
							<td id='ly_<%=gridId_7%>' style='vertical-align:top;'>
								<div id="<%=gridId_7%>"></div>
							</td>
						</tr>
					</table>

				</td>
				<td style="width:50%; height:20%;" align="center">
					<table style="width:100%;height:70%;" class="ui-widget-header ui-corner-all">
						<tr style="height:10px;">
							<td>
								<h4 class="ui-widget-header ui-corner-all">
									<img src="/imgs/btn/btn_in.gif" width="21" height="21" align="absmiddle" />공지 사항
								</h4>
							</td>
						</tr>
						<tr>
							<td id='ly_<%=gridId_1 %>' style='vertical-align:top;'>
								<div id="<%=gridId_1 %>"></div>
							</td>
						</tr>
					</table>
					<table style="width:100%;height:30%;" class="ui-widget-header ui-corner-all">
						<tr style="height:10px;">
							<td>
								<h4 class="ui-widget-header ui-corner-all">
									<img src="/imgs/btn/btn_in.gif" width="21" height="21" align="absmiddle" />오류 현황 [일주일 내]
								</h4>
							</td>
						</tr>
						<tr>
							<td id='ly_<%=gridId_6%>' style='vertical-align:top;'>
								<div id="<%=gridId_6%>"></div>
							</td>
						</tr>
					</table>
				</td>

			</tr>
			<tr style="height:50%;">
				<td style="width:50%; height:50%;" align="center">
					<table style="width:100%;height:100%;" class="ui-widget-header ui-corner-all">
						<tr>
							<td valign="top">
								<table style="width:100%;height:100%;" class="ui-widget-header ui-corner-all">
									<tr style="height:10px;">
										<td>
											<h4 class="ui-widget-header ui-corner-all">
												<img src="/imgs/btn/btn_in.gif" width="21" height="21" align="absmiddle" />결재 대상 내역
											</h4>
										</td>
									</tr>
									<tr>
										<td id='ly_<%=gridId_3 %>' style='vertical-align:top;'>
											<div id="<%=gridId_3 %>"></div>
										</td>
									</tr>
								</table>
							</td>
						</tr>
					</table>
				</td>
				<td style="width:50%; height:50%;" align="center">
					<table style="width:100%;height:100%;" class="ui-widget-header ui-corner-all">
						<tr style="height:10px;">
							<!-- 							<td><h4 class="ui-widget-header ui-corner-all"><img src="/imgs/btn/btn_in.gif" width="21" height="21" align="absmiddle" />반영 대기 내역</h4></td> -->
							<td><h4 class="ui-widget-header ui-corner-all"><img src="/imgs/btn/btn_in.gif" width="21" height="21" align="absmiddle" />To Do List</h4></td>
						</tr>
						<tr>
							<td id='ly_<%=gridId_2 %>' style='vertical-align:top;'>

								<form name="work_form" id="work_form" method="post" onsubmit="return false;">
									<input type="hidden" name="flag" 			id="flag"/>
									<input type="hidden" name="work_cd" 		id="work_cd" />
									<input type="hidden" name="work_date" 		id="work_date" />
									<input type="hidden" name="content" 		id="content" />

									<div id="<%=gridId_2 %>"></div>
								</form>

							</td>
						</tr>
					</table>
				</td>



			</tr>
		</table>
	</div>
</div>

`<script>

	function gridCellCustomFormatter_active(row,cell,value,columnDef,dataContext){

		var ret 		= "";
		var status 		= "";
		
		var odate 		= getCellValue(gridObj_4,row, 'ODATE');
		var dataCenter 	= getCellValue(gridObj_4,row, 'DATA_CENTER');
		var userDaily 	= getCellValue(gridObj_4,row, 'USER_DAILY');

		if(columnDef.id == 'TOTAL_COUNT'){
			ret = "<a href=\"JavaScript:myActiveList('"+odate+"', '"+status+"', '"+dataCenter+"', '"+userDaily+"');\" /><font color='blue'>"+value+"</font></a>"
		}
		if(columnDef.id == 'OK'){
			status = "Ended_OK";
			ret = "<a href=\"JavaScript:myActiveList('"+odate+"', '"+status+"', '"+dataCenter+"', '"+userDaily+"');\" /><font color='blue'>"+value+"</font></a>"
		}
		if(columnDef.id == 'NOTOK'){
			status = "Ended_Not_OK";
			ret = "<a href=\"JavaScript:myActiveList('"+odate+"', '"+status+"', '"+dataCenter+"', '"+userDaily+"');\" /><font color='blue'>"+value+"</font></a>"
		}
		if(columnDef.id == 'WAIT'){
			status = "Wait";
			ret = "<a href=\"JavaScript:myActiveList('"+odate+"', '"+status+"', '"+dataCenter+"', '"+userDaily+"');\" /><font color='blue'>"+value+"</font></a>"
		}
		if(columnDef.id == 'RUNNING'){
			status = "Executing";
			ret = "<a href=\"JavaScript:myActiveList('"+odate+"', '"+status+"', '"+dataCenter+"', '"+userDaily+"');\" /><font color='blue'>"+value+"</font></a>"
		}
		if(columnDef.id == 'DEL_COUNT'){
			status = "Deleted";
			ret = "<a href=\"JavaScript:myActiveList('"+odate+"', '"+status+"', '"+dataCenter+"', '"+userDaily+"');\" /><font color='blue'>"+value+"</font></a>"
		}

		return ret;
	}

	//결재 진행 현황
	function gridCellCustomFormatter_progress(row, cell, value, columnDef, dataContext) {

		var ret = "";
		var state_cd = "";
		var apply_cd = "";

		//결재 문서 전체 건수
		if(columnDef.id == 'APPROVAL_TOTAL_COUNT'){
			state_cd = "05";
			apply_cd = "99";
			ret = "<a href=\"JavaScript:myDocInfoList('"+state_cd+"', '"+apply_cd+"');\" /><font color='blue'>"+value+"</font></a>"
		}
		//완결
		if(columnDef.id == 'APPROVAL_OK'){
			state_cd = "02";
			apply_cd = "99";
			ret = "<a href=\"JavaScript:myDocInfoList('"+state_cd+"', '"+apply_cd+"');\" /><font color='blue'>"+value+"</font></a>"
		}
		//미결
		if(columnDef.id == 'APPROVAL_ING'){
			state_cd = "01";
			apply_cd = "99";
			ret = "<a href=\"JavaScript:myDocInfoList('"+state_cd+"', '"+apply_cd+"');\" /><font color='blue'>"+value+"</font></a>"
		}
		//저장
		if(columnDef.id == 'DOC_SAVE'){
			state_cd = "00";
			apply_cd = "99";
			ret = "<a href=\"JavaScript:myDocInfoList('"+state_cd+"', '"+apply_cd+"');\" /><font color='blue'>"+value+"</font></a>"
		}
		//반려
		if(columnDef.id == 'APPROVAL_CANCEL'){
			state_cd = "04";
			apply_cd = "99";
			ret = "<a href=\"JavaScript:myDocInfoList('"+state_cd+"', '"+apply_cd+"');\" /><font color='blue'>"+value+"</font></a>"
		}
		//반영 진행 전체 건 수
		if(columnDef.id == 'APPLY_TOTAL_COUNT'){
			state_cd = "05";
			apply_cd = "05";
			ret = "<a href=\"JavaScript:myDocInfoList('"+state_cd+"', '"+apply_cd+"');\" /><font color='blue'>"+value+"</font></a>"
		}
		if(columnDef.id == 'APPLY_OK'){
			state_cd = "05";
			apply_cd = "02";
			ret = "<a href=\"JavaScript:myDocInfoList('"+state_cd+"', '"+apply_cd+"');\" /><font color='blue'>"+value+"</font></a>"
		}
		if(columnDef.id == 'APPLY_WAIT'){
			state_cd = "05";
			apply_cd = "01";
			ret = "<a href=\"JavaScript:myDocInfoList('"+state_cd+"', '"+apply_cd+"');\" /><font color='blue'>"+value+"</font></a>"
		}
		//반영취소
		if(columnDef.id == 'APPLY_CANCEL'){
			state_cd = "05";
			apply_cd = "03";
			ret = "<a href=\"JavaScript:myDocInfoList('"+state_cd+"', '"+apply_cd+"');\" /><font color='blue'>"+value+"</font></a>"
		}
		//반영실패
		if(columnDef.id == 'APPLY_FAIL'){
			state_cd = "05";
			apply_cd = "04";
			ret = "<a href=\"JavaScript:myDocInfoList('"+state_cd+"', '"+apply_cd+"');\" /><font color='blue'>"+value+"</font></a>"
		}
		return ret;
	}

	//공지 사항
	function gridCellCustomFormatter(row,cell,value,columnDef,dataContext){

		var ret = "";
		var board_cd = getCellValue(gridObj_1,row,'BOARD_CD');

		if(columnDef.id == 'TITLE'){
			//ret = "<a href=\"JavaScript:noticeDetail('"+board_cd+"');\" /><font color='red'>"+value+"</font></a>";
			ret = "<a href=\"JavaScript:noticeDetail('"+board_cd+"');\" /><font color='blue'>"+value+"</font></a>";
		}

		return ret;
	}

	//오류 현황
	function gridCellCustomFormatter_error(row,cell,value,columnDef,dataContext){

		var ret = "";
		var message = "";
		//var total_count = getCellValue(gridId_6,row,'TOTAL_COUNT');

		if(columnDef.id == 'TOTAL_COUNT' ){
			ret = "<a href=\"JavaScript:opAlertErrorList('"+message+"');\" /><font color='blue'>"+value+"</font></a>";
		}
		if(columnDef.id == 'NOT_OK_CNT'){
			message = "ended not ok";
			ret = "<a href=\"JavaScript:opAlertErrorList('"+message+"');\" /><font color='blue'>"+value+"</font></a>";
		}
		if(columnDef.id == 'LATE_SUB_CNT'){
			message = "late_sub";
			ret = "<a href=\"JavaScript:opAlertErrorList('"+message+"');\" /><font color='blue'>"+value+"</font></a>";
		}
		if(columnDef.id == 'LATE_TIME_CNT'){
			message = "late_time";
			ret = "<a href=\"JavaScript:opAlertErrorList('"+message+"');\" /><font color='blue'>"+value+"</font></a>";
		}
		if(columnDef.id == 'LATE_EXEC_CNT'){
			message = "late_exec";
			ret = "<a href=\"JavaScript:opAlertErrorList('"+message+"');\" /><font color='blue'>"+value+"</font></a>";
		}

		return ret;
	}

	//결재 대상 내역
	function gridCellCustomFormatter_approval(row, cell, value, columnDef, dataContext) {

		var ret = "";

		if(columnDef.id == 'JOB_NAME'){
			ret = "<a href=\"JavaScript:approvalList();\" /><font color='blue'>"+value+"</font></a>";
		}

		if(columnDef.id == 'TITLE'){
			ret = "<a href=\"JavaScript:approvalList();\" /><font color='blue'><b>"+value+"</b></font></a>";
		}

		return ret;
	}

	//반영 대기 내역
	function gridCellCustomFormatter_exec(row, cell, value, columnDef, dataContext) {

		var ret = "";
		var state_cd = "05";
		var apply_cd = "01";

		if(columnDef.id == 'JOB_NAME'){
			ret = "<a href=\"JavaScript:execList('"+state_cd+"', '"+apply_cd+"');\" /><font color='blue'>"+value+"</font></a>";
		}

		return ret;
	}

	var gridObj_4 = {
		id : "<%=gridId_4 %>"
		,colModel:[

			{formatter:gridCellNoneFormatter,field:'DATA_CENTER_NAME',id:'DATA_CENTER_NAME',name:'C-M',width:80,headerCssClass:'cellCenter',cssClass:'cellCenter'}
			,{formatter:gridCellNoneFormatter,field:'ODATE',id:'ODATE',name:'ODATE',width:80,headerCssClass:'cellCenter',cssClass:'cellCenter'}
			,{formatter:gridCellNoneFormatter,field:'USER_DAILY',id:'USER_DAILY',name:'작업종류',width:80,headerCssClass:'cellCenter',cssClass:'cellCenter'}
			,{formatter:gridCellCustomFormatter_active,field:'TOTAL_COUNT',id:'TOTAL_COUNT',name:'전체',width:80,headerCssClass:'cellCenter',cssClass:'cellCenter'}
			,{formatter:gridCellCustomFormatter_active,field:'OK',id:'OK',name:'정상',width:80,headerCssClass:'cellCenter',cssClass:'cellCenter'}
			,{formatter:gridCellCustomFormatter_active,field:'RUNNING',id:'RUNNING',name:'수행중',width:80,headerCssClass:'cellCenter',cssClass:'cellCenter'}
			,{formatter:gridCellCustomFormatter_active,field:'WAIT',id:'WAIT',name:'대기',width:80,headerCssClass:'cellCenter',cssClass:'cellCenter'}
			,{formatter:gridCellCustomFormatter_active,field:'NOTOK',id:'NOTOK',name:'오류',width:80,headerCssClass:'cellCenter',cssClass:'cellCenter'}
			,{formatter:gridCellCustomFormatter_active,field:'DEL_COUNT',id:'DEL_COUNT',name:'삭제',width:80,headerCssClass:'cellCenter',cssClass:'cellCenter'}

			//,{formatter:gridCellNoneFormatter,field:'LATE',id:'LATE',name:'임계위반',width:80,headerCssClass:'cellCenter',cssClass:'cellCenter'}

			,{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'grid_idx',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
			,{formatter:gridCellNoneFormatter,field:'DATA_CENTER',id:'DATA_CENTER',name:'DATA_CENTER',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
		]
		,rows:[]
		,vscroll: <%=S_GRID_VSCROLL%>
	};

	var gridObj_5 = {
		id : "<%=gridId_5 %>"
		,colModel:[
			{formatter:gridCellCustomFormatter_progress,field:'APPROVAL_TOTAL_COUNT',id:'APPROVAL_TOTAL_COUNT',name:'전체',width:80,headerCssClass:'cellCenter',cssClass:'cellCenter'}
			,{formatter:gridCellCustomFormatter_progress,field:'APPROVAL_OK',id:'APPROVAL_OK',name:'완결',width:80,headerCssClass:'cellCenter',cssClass:'cellCenter'}
			,{formatter:gridCellCustomFormatter_progress,field:'APPROVAL_ING',id:'APPROVAL_ING',name:'미결',width:80,headerCssClass:'cellCenter',cssClass:'cellCenter'}
			,{formatter:gridCellCustomFormatter_progress,field:'APPROVAL_CANCEL',id:'APPROVAL_CANCEL',name:'반려',width:80,headerCssClass:'cellCenter',cssClass:'cellCenter'}
			,{formatter:gridCellCustomFormatter_progress,field:'DOC_SAVE',id:'DOC_SAVE',name:'저장',width:80,headerCssClass:'cellCenter',cssClass:'cellCenter'}

			,{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'grid_idx',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
		]
		,rows:[]
		,vscroll: <%=S_GRID_VSCROLL%>
	};

	var gridObj_7 = {
		id : "<%=gridId_7 %>"
		,colModel:[
			{formatter:gridCellCustomFormatter_progress,field:'APPLY_TOTAL_COUNT',id:'APPLY_TOTAL_COUNT',name:'전체',width:80,headerCssClass:'cellCenter',cssClass:'cellCenter'}
			,{formatter:gridCellCustomFormatter_progress,field:'APPLY_OK',id:'APPLY_OK',name:'반영완료',width:100,headerCssClass:'cellCenter',cssClass:'cellCenter'}
// 			,{formatter:gridCellCustomFormatter_progress,field:'APPLY_WAIT',id:'APPLY_WAIT',name:'반영대기',width:100,headerCssClass:'cellCenter',cssClass:'cellCenter'}
// 			,{formatter:gridCellCustomFormatter_progress,field:'APPLY_CANCEL',id:'APPLY_CANCEL',name:'반영취소',width:80,headerCssClass:'cellCenter',cssClass:'cellCenter'}
			,{formatter:gridCellCustomFormatter_progress,field:'APPLY_FAIL',id:'APPLY_FAIL',name:'반영실패',width:80,headerCssClass:'cellCenter',cssClass:'cellCenter'}

			,{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'grid_idx',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
		]
		,rows:[]
		,vscroll: <%=S_GRID_VSCROLL%>
	};

	var gridObj_6 = {
		id : "<%=gridId_6 %>"
		,colModel:[

			{formatter:gridCellNoneFormatter,field:'DATA_CENTER_NAME',id:'DATA_CENTER_NAME',name:'C-M',width:100,headerCssClass:'cellCenter',cssClass:'cellCenter'}
			,{formatter:gridCellCustomFormatter_error,field:'NOT_OK_CNT',id:'NOT_OK_CNT',name:'실패',width:80,headerCssClass:'cellCenter',cssClass:'cellCenter'}
			,{formatter:gridCellCustomFormatter_error,field:'LATE_SUB_CNT',id:'LATE_SUB_CNT',name:'시작임계위반',width:100,headerCssClass:'cellCenter',cssClass:'cellCenter'}
			,{formatter:gridCellCustomFormatter_error,field:'LATE_TIME_CNT',id:'LATE_TIME_CNT',name:'종료임계위반',width:100,headerCssClass:'cellCenter',cssClass:'cellCenter'}
			,{formatter:gridCellCustomFormatter_error,field:'LATE_EXEC_CNT',id:'LATE_EXEC_CNT',name:'수행임계위반',width:100,headerCssClass:'cellCenter',cssClass:'cellCenter'}
			,{formatter:gridCellCustomFormatter_error,field:'TOTAL_COUNT',id:'TOTAL_COUNT',name:'전체',width:80,headerCssClass:'cellCenter',cssClass:'cellCenter'}
			,{formatter:gridCellCustomFormatter_error,field:'grid_idx',id:'grid_idx',name:'grid_idx',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
		]
		,rows:[]
		,vscroll: <%=S_GRID_VSCROLL%>
	};

	var gridObj_1 = {
		id : "<%=gridId_1 %>"
		,colModel:[

			{formatter:gridCellCustomFormatter,field:'TITLE',id:'TITLE',name:'제목',width:370,headerCssClass:'cellCenter',cssClass:'cellLeft'}
			,{formatter:gridCellNoneFormatter,field:'INS_DATE',id:'INS_DATE',name:'등록일',width:100,headerCssClass:'cellCenter',cssClass:'cellCenter'}

			,{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'grid_idx',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
			,{formatter:gridCellNoneFormatter,field:'BOARD_CD',id:'BOARD_CD',name:'BOARD_CD',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
		]
		,rows:[]
		,vscroll: <%=S_GRID_VSCROLL%>
	};

	var gridObj_2 = {
		id : "<%=gridId_2 %>"
		,colModel:[

			{formatter:gridCellNoneFormatter,field:'WORK_DATE',id:'WORK_DATE',name:'일자',width:75,headerCssClass:'cellCenter',cssClass:'cellCenter'}
			,{formatter:gridCellNoneFormatter,field:'CONTENT',id:'CONTENT',name:'To Do List',width:330,headerCssClass:'cellCenter',cssClass:'cellLeft'}
			,{formatter:gridCellNoneFormatter,field:'PROC',id:'PROC',name:'처리',width:80,headerCssClass:'cellCenter',cssClass:'cellCenter'}

			,{formatter:gridCellNoneFormatter,field:'WORK_CD',id:'WORK_CD',name:'WORK_CD',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
		]
		,rows:[]
		,vscroll: <%=S_GRID_VSCROLL%>
	};

	//반영대기
	// 	var gridObj_2 = {
	<%-- 		id : "<%=gridId_2 %>" --%>
	// 		,colModel:[
	// 			{formatter:gridCellNoneFormatter,field:'DOC_GB',id:'DOC_GB',name:'작업구분',width:100,headerCssClass:'cellCenter',cssClass:'cellCenter'}
	// 	   		,{formatter:gridCellCustomFormatter_exec,field:'JOB_NAME',id:'JOB_NAME',name:'의뢰사유',width:250,headerCssClass:'cellCenter',cssClass:'cellLeft'}
	// 	   		,{formatter:gridCellNoneFormatter,field:'USER_INFO',id:'USER_INFO',name:'의뢰자',width:130,headerCssClass:'cellCenter',cssClass:'cellCenter'}
	// 	   		,{formatter:gridCellNoneFormatter,field:'DRAFT_DATE',id:'DRAFT_DATE',name:'의뢰일',width:125,headerCssClass:'cellCenter',cssClass:'cellCenter'}

	// 	   		,{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'grid_idx',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	// 	   		,{formatter:gridCellNoneFormatter,field:'DOC_GB_CODE',id:'DOC_GB_CODE',name:'DOC_GB_CODE',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	// 	   		,{formatter:gridCellNoneFormatter,field:'DATA_CENTER',id:'DATA_CENTER',name:'DATA_CENTER',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	// 	   	]
	// 		,rows:[]
	<%-- 		,vscroll: <%=S_GRID_VSCROLL%> --%>
	// 	};

	var gridObj_3 = {
		id : "<%=gridId_3 %>"
		,colModel:[
			{formatter:gridCellNoneFormatter,field:'DOC_GB',id:'DOC_GB',name:'작업구분',width:90,headerCssClass:'cellCenter',cssClass:'cellCenter'}
			,{formatter:gridCellCustomFormatter_approval,field:'TITLE',id:'TITLE',name:'의뢰사유',width:235,headerCssClass:'cellCenter',cssClass:'cellLeft'}
			,{formatter:gridCellCustomFormatter_approval,field:'JOB_NAME',id:'JOB_NAME',name:'작업명',width:180,headerCssClass:'cellCenter',cssClass:'cellLeft'}
			,{formatter:gridCellNoneFormatter,field:'USER_INFO',id:'USER_INFO',name:'의뢰자',width:100,headerCssClass:'cellCenter',cssClass:'cellCenter'}
			,{formatter:gridCellNoneFormatter,field:'DRAFT_DATE',id:'DRAFT_DATE',name:'의뢰일',width:125,headerCssClass:'cellCenter',cssClass:'cellCenter'}

			,{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'grid_idx',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
			,{formatter:gridCellNoneFormatter,field:'DOC_GB_CODE',id:'DOC_GB_CODE',name:'DOC_GB_CODE',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
			,{formatter:gridCellNoneFormatter,field:'DATA_CENTER',id:'DATA_CENTER',name:'DATA_CENTER',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
		]
		,rows:[]
		,vscroll: <%=S_GRID_VSCROLL%>
	};

	$(document).ready(function(){
		var session_dc_code = "";
		$( "#tabs" ).tabs({
			activate: function( event, ui ) {

			// 노드 아이디를 가져오기 위한 과정
				var tab_id 	= ui.newTab[0].id;
				tab_id 		= tab_id.split("-")[2];

				var navLinks = document.querySelectorAll('.sub-menu li');
				// 모든 li에서 'clicked' 클래스를 제거
				navLinks.forEach(function(otherLink) {
					otherLink.classList.remove('clicked');
				});
				resizeTabContent();
			}
		});

		<c:forEach var="cm" items="${cm}" varStatus="status">
		session_dc_code = "${cm.scode_cd},${cm.scode_eng_nm}";
		</c:forEach>

		viewGrid_1(gridObj_4,"ly_"+gridObj_4.id);
		myWorksInfoList();
		
		viewGrid_1(gridObj_5,"ly_"+gridObj_5.id);
		myDocInfoCntList();

		viewGrid_1(gridObj_7,"ly_"+gridObj_7.id);
		myDocInfoCntList();

		viewGrid_1(gridObj_6,"ly_"+gridObj_6.id);
		myAlarmDocInfoCntList();

		viewGrid_1(gridObj_1,"ly_"+gridObj_1.id);
		noticeList();

		viewGrid_1(gridObj_2,"ly_"+gridObj_2.id);
		//반영대기 		execDocInfoList(session_dc_code);
		myWorkList();


		viewGrid_1(gridObj_3,"ly_"+gridObj_3.id);
		myApprovalDocInfoList();

		// 공지 사항 팝업 노출 목록 조회
		noticePopupYList();

		// 통제 여부 셋팅
		batchControlSet();

		//tmp_p();

		$("#work_date0").addClass("ime_readonly").unbind('click').click(function(){
			alert(this.id);
			dpCalMin(this.id,'yymmdd');
		});

		$("#c_odate").addClass("ime_readonly").unbind('click').click(function(){

		});

		setTimeout(function(){
			// 오류 미조치 건 확인 후 페이지 이동
			//fn_alert_check();
		}, 500);

		if("<%=s_login_chk%>" == "Y"){
			doApprovalCntChk();
		}
	});

	function myWorksInfoList(){

		try{viewProgBar(true);}catch(e){}

		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=myWorksInfoList&itemGubun=2';

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

								var data_center_name	= $(this).find("DATA_CENTER_NAME").text();
								var odate 				= $(this).find("ODATE").text();
								var total_count 		= $(this).find("TOTAL_COUNT").text();
								var ok 					= $(this).find("OK").text();
								var notok 				= $(this).find("NOTOK").text();
								var wait 				= $(this).find("WAIT").text();
								var late 				= $(this).find("LATE").text();
								var running 			= $(this).find("RUNNING").text();
								var del_count 			= $(this).find("DEL_COUNT").text();
								var data_center			= $(this).find("DATA_CENTER").text();
								var user_daily			= $(this).find("USER_DAILY").text();

								odate = "20"+odate.substring(0,2) + "/" + odate.substring(2,4) + "/" + odate.substring(4);

								if(user_daily == "SYSTEM") {
									user_daily = "정기";
								} else if(user_daily == "SUSI") {
									user_daily = "수시오더";
								} else {
									user_daily = "비정기";
								}

								rowsObj.push({
									'grid_idx':i+1
									,'DATA_CENTER_NAME': data_center_name
									,'ODATE': odate
									,'TOTAL_COUNT': total_count
									,'OK': ok
									,'NOTOK': notok
									,'WAIT': wait
									,'LATE': late
									,'RUNNING': running
									,'DEL_COUNT': del_count
									,'DATA_CENTER': data_center
									,'USER_DAILY': user_daily
								});
							});
						}

						gridObj_4.rows = rowsObj;
						setGridRows(gridObj_4);
					});
					try{viewProgBar(false);}catch(e){}

				}
				, null );

		xhr.sendRequest();
	}

	function myDocInfoCntList(){

		try{viewProgBar(true);}catch(e){}

		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=myDocInfoCntList&itemGubun=2';

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

								var apply_total_count 		= $(this).find("APPLY_TOTAL_COUNT").text();
								var approval_total_count 	= $(this).find("APPROVAL_TOTAL_COUNT").text();
								var apply_ok 				= $(this).find("APPLY_OK").text();
								var apply_wait 				= $(this).find("APPLY_WAIT").text();
								var apply_cancel 			= $(this).find("APPLY_CANCEL").text();
								var apply_fail	 			= $(this).find("APPLY_FAIL").text();
								var approval_ok 			= $(this).find("APPROVAL_OK").text();
								var approval_ing 			= $(this).find("APPROVAL_ING").text();
								var approval_cancel			= $(this).find("APPROVAL_CANCEL").text();
								var doc_save 				= $(this).find("DOC_SAVE").text();

								rowsObj.push({
									'grid_idx':i+1
									,'APPLY_TOTAL_COUNT': apply_total_count
									,'APPROVAL_TOTAL_COUNT': approval_total_count
									,'APPLY_OK': apply_ok
									,'APPLY_WAIT': apply_wait
									,'APPLY_CANCEL': apply_cancel
									,'APPLY_FAIL': apply_fail
									,'APPROVAL_OK': approval_ok
									,'APPROVAL_ING': approval_ing
									,'APPROVAL_CANCEL': approval_cancel
									,'DOC_SAVE': doc_save

								});
							});
						}

						gridObj_5.rows = rowsObj;
						setGridRows(gridObj_5);

						gridObj_7.rows = rowsObj;
						setGridRows(gridObj_7);
					});
					try{viewProgBar(false);}catch(e){}

				}
				, null );

		xhr.sendRequest();
	}

	function myAlarmDocInfoCntList(){

		try{viewProgBar(true);}catch(e){}

		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=myAlarmDocInfoCntList&itemGubun=2';

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

								var total_count 		= $(this).find("TOTAL_COUNT").text();
								var not_ok_cnt 			= $(this).find("NOT_OK_CNT").text();
								var late_sub_cnt		= $(this).find("LATE_SUB_CNT").text();
								var late_time_cnt 		= $(this).find("LATE_TIME_CNT").text();
								var late_exec_cnt		= $(this).find("LATE_EXEC_CNT").text();
								var data_center_name	= $(this).find("DATA_CENTER_NAME").text();

								rowsObj.push({
									'grid_idx':i+1
									,'TOTAL_COUNT': total_count
									,'NOT_OK_CNT': not_ok_cnt
									,'LATE_SUB_CNT': late_sub_cnt
									,'LATE_TIME_CNT': late_time_cnt
									,'LATE_EXEC_CNT': late_exec_cnt
									,'DATA_CENTER_NAME': data_center_name
								});
							});
						}

						gridObj_6.rows = rowsObj;
						setGridRows(gridObj_6);
					});
					try{viewProgBar(false);}catch(e){}

				}
				, null );

		xhr.sendRequest();
	}

	function noticeList(){

		try{viewProgBar(true);}catch(e){}

		var noti_count = "20";

		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=noticeList&itemGubun=2&orderby=Y&count='+noti_count+'&front=Y';

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

								var board_cd = $(this).find("BOARD_CD").text();
								var title = $(this).find("TITLE").text();
								var ins_date = $(this).find("INS_DATE").text();

								rowsObj.push({
									'grid_idx':i+1
									,'BOARD_CD': board_cd
									,'TITLE': "&nbsp;"+title
									,'INS_DATE': ins_date
								});
							});
						}

						gridObj_1.rows = rowsObj;
						setGridRows(gridObj_1);
					});
					try{viewProgBar(false);}catch(e){}

				}
				, null );

		xhr.sendRequest();
	}

	function noticePopupYList() {

		try{viewProgBar(true);}catch(e){}

		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=noticeList&itemGubun=2&orderby=Y&front=Y&popup=Y';

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

								var board_cd = $(this).find("BOARD_CD").text();

								if(getCookie("cookie_dl_tmp_" + board_cd) != "Y") {
									noticePopupYDetail(board_cd);
								}
							});
						}
					});
					try{viewProgBar(false);}catch(e){}

				}
				, null );

		xhr.sendRequest();
	}

	function batchControlSet() {

		try{viewProgBar(true);}catch(e){}

		var url = '<%=sContextPath %>/common.ez?c=batchControlSet';

		var xhr = new XHRHandler(url, null
				,function(){
					var xmlDoc = this.req.responseXML;

					try{viewProgBar(false);}catch(e){}

				}
				, null );

		xhr.sendRequest();
	}

	function noticeDetail(board_cd){

		try{viewProgBar(true);}catch(e){}

		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=noticeDetail&itemGubun=2&board_gb=01&board_cd='+board_cd;

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

						var title = "";
						var content = "";
						var status = "";
						var file_nm = "";
						var h = 0;
						var h2 = 0;

						if(items.attr('cnt')=='0'){
						}else{
							items.find('item').each(function(i){

								title = $(this).find("TITLE").text();
								content = $(this).find("CONTENT").text();
								status = $(this).find("STATUS").text();
								file_nm = $(this).find("FILE_NM").text();

							});
						}

						h = 480;
						h2 = 600;

						var sHtml="<div id='dl_tmp1' style='overflow:hidden;display:none;padding:0;border-top:1px solid blue;border-bottom:1px solid blue;border-left:1px solid blue;border-right:1px solid blue;'>";
						sHtml+="<form id='form1' name='form1' method='post' onsubmit='return false;' enctype='multipart/form-data'>";
						sHtml+="<input type='hidden' name='flag' id='flag'/>";
						sHtml+="<input type='hidden' name='board_gb' id='board_gb' value='01' />";
						sHtml+="<input type='hidden' name='board_cd' id='board_cd' value='"+board_cd+"' />";
						sHtml+="<table style='width:100%;height:"+h2+"px;border:none;'>";
						sHtml+="<tr><td style='vertical-align:top;height:90%;width:600px;' >";

						sHtml+="<table style='width:100%;height:80%;border:none;'>";
						sHtml+="<tr><td id='ly_g_tmp1' style='vertical-align:top;'>";
						sHtml+="<div id='g_tmp1' class='ui-widget-header ui-corner-all'></div>";
						sHtml+="</td></tr>";
						//sHtml+="<tr style='height:5px;'><td style='vertical-align:top;'><h5 class='ui-widget-header ui-corner-all' >";
						//sHtml+="<div align='right' class='btn_area_s'>";
						//sHtml+="</div>";
						sHtml+="</h5></td></tr></table>";

						sHtml+="</td></tr></table>";

						sHtml+="</form>";

						$('#dl_tmp1').remove();
						$('body').append(sHtml);

						var headerObj = new Array();
						var hTmp1 = "";
						var hTmp2 = "";
						hTmp1 += "<div class='cellTitle_1'>제목</div>";
						hTmp2 += "<div class='cellContent_1'>"+title+"</div>";
						hTmp1 += "<div class='cellTitle_1' style='height:380px;'>내용</div>";
						hTmp2 += "<div class='cellContent_1' style='height:380px;'><textarea name='content' id='content' style='width:99%; height:370px;'>"+content+"</textarea></div>";

						if(file_nm != ""){
							hTmp1 += "<div class='cellTitle_1'>첨부파일</div>";
							hTmp2 += "<div class='cellContent_1'><a href='javascript:download("+board_cd+");'>"+file_nm+"</a></div>";
						}else{
							hTmp1 += "<div class='cellTitle_1'>첨부파일</div>";
							hTmp2 += "<div class='cellContent_1'>없음</div>";
						}

						headerObj.push({name:hTmp1,id_s:'c_1',id_e:'c_1'});
						headerObj.push({name:hTmp2,id_s:'c_2',id_e:'c_2'});
						var gridObj_s = {
							id : "g_tmp1"
							,colModel:[
								{formatter:gridCellNoneFormatter,field:'c_1',id:'c_1',name:'구 분',width:80,headerCssClass:'cellCenter',cssClass:'cellCenter'}
								,{formatter:gridCellNoneFormatter,field:'c_2',id:'c_2',name:'내 용',width:512,headerCssClass:'cellCenter',cssClass:'cellLeft'}

								,{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'grid_idx',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
							]
							,rows:[]
							,headerRowHeight:450
							,colspan:headerObj
							,vscroll:<%=S_GRID_VSCROLL%>
						};

						viewGrid_1(gridObj_s,'ly_'+gridObj_s.id);

						dlPop01('dl_tmp1',"공지사항상세",600, h, false);

					});
					try{viewProgBar(false);}catch(e){}
				}
				, null );

		xhr.sendRequest();
	}

	function noticePopupYDetail(board_cd){

		try{viewProgBar(true);}catch(e){}

		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=noticeDetail&itemGubun=2&board_gb=01&board_cd='+board_cd;

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

						var title 	= "";
						var content = "";
						var status 	= "";
						var file_nm = "";

						var h 		= 0;
						var h2 		= 0;

						if(items.attr('cnt')=='0'){
						}else{
							items.find('item').each(function(i){

								title 	= $(this).find("TITLE").text();
								content = $(this).find("CONTENT").text();
								status 	= $(this).find("STATUS").text();
								file_nm = $(this).find("FILE_NM").text();
							});
						}

						h 	= 520;
						h2 	= 620;

						var sHtml="<div id='dl_tmp_"+board_cd+"' style='overflow:hidden;display:none;padding:0;border-top:1px solid blue;border-bottom:1px solid blue;border-left:1px solid blue;border-right:1px solid blue;'>";
						sHtml+="<form id='form1' name='form1' method='post' onsubmit='return false;' enctype='multipart/form-data'>";
						sHtml+="<input type='hidden' name='flag' id='flag'/>";
						sHtml+="<input type='hidden' name='board_gb' id='board_gb' value='01' />";
						sHtml+="<input type='hidden' name='board_cd' id='board_cd' value='"+board_cd+"' />";
						sHtml+="<table style='width:100%;height:"+h2+"px;border:none;'>";

						// 익스플로러에서 깨짐 현상이 있어서 분기 처리 (2020.11.13 강명준)
						var header = "<%=request.getHeader("User-Agent")%>";
						if ( header.indexOf("MSIE") > -1 || header.indexOf("Trident") > -1 ) {
							sHtml+="<tr><td style='vertical-align:bottom;height:90%;width:600px;' >";
						} else {
							sHtml+="<tr><td style='vertical-align:top;height:90%;width:600px;' >";
						}

						sHtml+="<table style='width:100%;height:80%;border:none;'>";
						sHtml+="<tr><td id='ly_g_tmp_"+board_cd+"' style='vertical-align:top;'>";
						sHtml+="<div id='g_tmp_"+board_cd+"' class='ui-widget-header ui-corner-all'></div>";
						sHtml+="</td></tr>";
						sHtml+="<tr style='height:15px'><td align='right'>";
						sHtml+="<input type='checkbox' id='chk_notice_close_"+board_cd+"_1' value='Y' /><b>하루동안 그만 보기</b>";
						sHtml+="<input type='checkbox' id='chk_notice_close_"+board_cd+"_7' value='Y' /><b>일주일 그만 보기</b>";
						sHtml+="<a href='#' onclick='javascript:closeWin("+board_cd+");'>&nbsp;&nbsp;<b>[닫기]</b></a>";
						sHtml+="</td></tr>";
						sHtml+="</table>";
						sHtml+="</td></tr>";

						//sHtml+="<tr><td>aaa</td></tr>";
						sHtml+="</table>";

						sHtml+="</form>";

						$('#dl_tmp_'+board_cd).remove();
						$('body').append(sHtml);

						var headerObj = new Array();
						var hTmp1 = "";
						var hTmp2 = "";
						hTmp1 += "<div class='cellTitle_1'>제목</div>";
						hTmp2 += "<div class='cellContent_1'>"+title+"</div>";
						hTmp1 += "<div class='cellTitle_1' style='height:380px;'>내용</div>";
						hTmp2 += "<div class='cellContent_1' style='height:380px;'><textarea name='content' id='content' style='width:99%; height:370px;'>"+content+"</textarea></div>";

						if(file_nm != ""){
							hTmp1 += "<div class='cellTitle_1'>첨부파일</div>";
							hTmp2 += "<div class='cellContent_1'><a href='javascript:download("+board_cd+");'>"+file_nm+"</a></div>";
						}else{
							hTmp1 += "<div class='cellTitle_1'>첨부파일</div>";
							hTmp2 += "<div class='cellContent_1'>없음</div>";
						}

						headerObj.push({name:hTmp1,id_s:'c_1',id_e:'c_1'});
						headerObj.push({name:hTmp2,id_s:'c_2',id_e:'c_2'});

						var gridObj_s = {
							id : "g_tmp_"+board_cd
							,colModel:[
								{formatter:gridCellNoneFormatter,field:'c_1',id:'c_1',name:'구 분',width:80,headerCssClass:'cellCenter',cssClass:'cellCenter'}
								,{formatter:gridCellNoneFormatter,field:'c_2',id:'c_2',name:'내 용',width:512,headerCssClass:'cellCenter',cssClass:'cellLeft'}

								,{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'grid_idx',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
							]
							,rows:[]
							,headerRowHeight:470
							,colspan:headerObj
							,vscroll:<%=S_GRID_VSCROLL%>
						};

						viewGrid_1(gridObj_s,'ly_'+gridObj_s.id);

						dlPop01('dl_tmp_'+board_cd,"공지 사항",600, h, false);

					});
					try{viewProgBar(false);}catch(e){}
				}
				, null );

		xhr.sendRequest();
	}

	function errorList(){

		try{viewProgBar(true);}catch(e){}

		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=mainErrorList';

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

								var job_name = $(this).find("JOB_NAME").text();
								var status = $(this).find("STATUS").text();
								var user_nm = $(this).find("USER_NM").text();
								var cnt = $(this).find("CNT	").text();
								var desc = $(this).find("DESC").text();

								rowsObj.push({
									'grid_idx':i+1
									,'JOB_NAME': job_name
									,'STATUS': status
									,'USER_NM': user_nm
									,'CNT': cnt
									,'DESC': desc
								});
							});
						}

						gridObj_2.rows = rowsObj;
						setGridRows(gridObj_2);

					});
					try{viewProgBar(false);}catch(e){}
				}
				, null );

		xhr.sendRequest();
	}

	function myWorkList(){

		try{viewProgBar(true);}catch(e){}

		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=myWorkList&itemGubun=2';

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

						var input_work_date	= "";
						input_work_date		+= "<div class='gridInput_area'><input type='text' id='work_date0' name='work_date0' style='width:100%;' readOnly onClick=\"dpCalMin(this.id,'yymmdd');\" /></div>";

						var input_content 	= "";
						input_content 		+= "<div class='gridInput_area'><input type='text' id='content0' name='content0' style='width:100%;'/></div>";

						var input_prc = "";
						input_prc += "<div><a href=\"javascript:goProc('ins', '0');\"><font color='red'>[추가]</font></a></div>";

						rowsObj.push({
							'grid_idx':""
							,'WORK_CD': ""
							,'WORK_DATE': input_work_date
							,'CONTENT': input_content
							,'PROC':input_prc
						});

						if(items.attr('cnt')=='0'){
						}else{
							items.find('item').each(function(i){

								var work_cd 	= $(this).find("WORK_CD").text();
								var work_date	= $(this).find("WORK_DATE").text();
								var content 	= $(this).find("CONTENT").text();

								var v_proc 	= "<div>";
								v_proc 		+= "<a href=\"javascript:goProc('del', '"+work_cd+"');\"><font color='red'>[삭제]</font></a>";
								v_proc 		+= "</div>";

								rowsObj.push({
									'grid_idx':i+1
									,'WORK_CD': work_cd
									,'WORK_DATE': work_date
									,'CONTENT': content
									,'PROC': v_proc
								});
							});
						}

						gridObj_2.rows = rowsObj;
						setGridRows(gridObj_2);

					});
					try{viewProgBar(false);}catch(e){}
				}
				, null );

		xhr.sendRequest();
	}

	function allDocInfoList(){

		try{viewProgBar(true);}catch(e){}

		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=mainAllDocInfoList';

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

								var doc_cd = $(this).find("DOC_CD").text();
								var job_name = $(this).find("JOB_NAME").text();
								var doc_gb = $(this).find("DOC_GB").text();
								var user_nm = $(this).find("USER_NM").text();
								var dept_nm = $(this).find("DEPT_NM").text();
								var duty_nm = $(this).find("DUTY_NM").text();
								var draft_date = $(this).find("DRAFT_DATE").text();
								var doc_gb_nm = "";
								var all_user_nm = "";

								if(doc_gb == "01"){
									doc_gb_nm = "정기";
								}else if(doc_gb == "02"){
									doc_gb_nm = "수시";
								}else if(doc_gb == "05"){
									doc_gb_nm = "비정기";
								}else if(doc_gb == "06"){
									doc_gb_nm = "일괄";
								}

								all_user_nm = user_nm+"["+dept_nm+"]";

								rowsObj.push({
									'grid_idx':i+1
									,'DOC_CD': doc_cd
									,'JOB_NAME': job_name
									,'USER_NM': all_user_nm
									,'DOC_GB_NM': doc_gb_nm
									,'DRAFT_DATE': draft_date
								});
							});
						}

						gridObj_3.rows = rowsObj;
						setGridRows(gridObj_3);

					});
					try{viewProgBar(false);}catch(e){}
				}
				, null );

		xhr.sendRequest();
	}
	//결재 대상 내역
	function myApprovalDocInfoList(){

		try{viewProgBar(true);}catch(e){}

		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=myApprovalDocInfoList&itemGubun=2';

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

								var doc_gb_code	= $(this).find("DOC_GB_CODE").text();
								var doc_gb 		= $(this).find("DOC_GB").text();
								var job_name 	= $(this).find("JOB_NAME").text();
								var title	 	= $(this).find("TITLE").text();
								var user_info 	= $(this).find("USER_INFO").text();
								var draft_date 	= $(this).find("DRAFT_DATE").text();
								var data_center	= $(this).find("DATA_CENTER").text();

								rowsObj.push({
									'grid_idx':i+1
									,'DOC_GB_CODE': doc_gb_code
									,'DOC_GB': doc_gb
									,'JOB_NAME': job_name
									,'TITLE': title
									,'USER_INFO': user_info
									,'DRAFT_DATE': draft_date
									,'DATA_CENTER': data_center
								});
							});
						}

						gridObj_3.rows = rowsObj;
						setGridRows(gridObj_3);

					});
					try{viewProgBar(false);}catch(e){}
				}
				, null );

		xhr.sendRequest();
	}

	function execDocInfoList(session_dc_code){
		try{viewProgBar(true);}catch(e){}

		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=execDocInfoList&itemGubun=2&data_center_item='+session_dc_code;

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

								var doc_gb_code	= $(this).find("DOC_GB_CODE").text();
								var doc_gb 		= $(this).find("DOC_GB").text();
								var job_name 	= $(this).find("JOB_NAME").text();
								var user_info 	= $(this).find("USER_INFO").text();
								var draft_date 	= $(this).find("DRAFT_DATE").text();
								var data_center	= $(this).find("DATA_CENTER").text();

								rowsObj.push({
									'grid_idx':i+1
									,'DOC_GB_CODE': doc_gb_code
									,'DOC_GB': doc_gb
									,'JOB_NAME': job_name
									,'USER_INFO': user_info
									,'DRAFT_DATE': draft_date
									,'DATA_CENTER': data_center
								});
							});
						}

						gridObj_2.rows = rowsObj;
						setGridRows(gridObj_2);

					});
					try{viewProgBar(false);}catch(e){}
				}
				, null );

		xhr.sendRequest();
	}

	function download(board_cd){

		var f = document.form1;

		f.flag.value = "board";
		f.target = "if1";
		f.action = "<%=sContextPath %>/common.ez?c=fileDownload";
		f.submit();

	}

	function addTab(c,nm,gb,cd,act){
		var tabs = $( "#tabs" ).tabs();

		var tabId = 'tabs-'+cd;
		if($('#'+tabId).length>0){
			tabs.tabs('select', '#'+tabId);
			return false;
		}

		var sHtml = "<li id='t-"+tabId+"' ><a href='#"+tabId+"' style='color:black !important;'>"+nm+"</a>&nbsp;&nbsp;&nbsp;<span id='"+tabId+"-close' >Close</span></li>";
		$('#t-tabs').append(sHtml);

		var url = "<%=sContextPath %>/"+act;

		var sHtml = "<div id='"+tabId+"' style='margin:2px;padding:0px;' >";
		sHtml += "<iframe id='if-"+tabId+"' name='if-"+tabId+"' src='"+url+"' width='100%' height='10px' scrolling='no'  frameborder='0'></iframe>";
		sHtml += "</div>";
		$('#tabs').append(sHtml);

		$("#"+tabId+"-close").button({icons:{primary:'ui-icon-close'},text:false})
				.css({'margin':'0','border':'none','background':'transparent'})
				.unbind('click').click(function(e){
			closeTab(tabId);
		});

		tabs.tabs('refresh');
		tabs.tabs('select', '#'+tabId);

	}

	function closeTab(tabId){

		var tabs = $( "#tabs" ).tabs();

		$("#if-"+tabId).attr('src','about:blank');
		$("#"+tabId).empty();
		$("#t-"+tabId).remove();
		$("#"+tabId).remove();

		tabs.tabs('refresh');
	}

	function closeTabs(tabIds){

		var tabs = $( "#tabs" ).tabs();

		var arrTabId = tabIds.split("|");

		for ( var i = 0; i < arrTabId.length; i++ ) {

			tabId = arrTabId[i];

			$("#if-"+tabId).attr('src','about:blank');
			$("#"+tabId).empty();
			$("#t-"+tabId).remove();
			$("#"+tabId).remove();
		}

		tabs.tabs('refresh');
	}

	// 탭 닫고 동시에 탭을 새로 띄어서 리프레쉬 효과 준다.
	// Ex. 상세에서 처리 후 목록을 띄울 때 화면 갱신
	function closeTabsAndAddTab(tabIds, c, nm, gb, cd, act) {

		var tabs = $( "#tabs" ).tabs();

		var arrTabId = tabIds.split("|");

		for ( var i = 0; i < arrTabId.length; i++ ) {

			tabId = arrTabId[i];

			$("#if-"+tabId).attr('src','about:blank');
			$("#"+tabId).empty();
			$("#t-"+tabId).remove();
			$("#"+tabId).remove();
		}

		if ( c != "" ) {
			addTab(c, nm, gb, cd, act);
		}

		tabs.tabs('refresh');
	}

	function resizeTabContent(){

		var tabs = $( "#tabs" ).tabs();

		var tabId = $('#tabs ul .ui-tabs-active').attr("id").substring(2);

		var h = $('#tabs').height()-$('#ly_t-tabs').height();
		var t_tabs_h = $('#ly_t-tabs').height();

		$('tabs-'+tabId).height(h-5);
		$('#'+tabId).height(h-5);
		$('#if-'+tabId).height(h-5);

		// 메인 화면 노출 시 자동 리프레쉬
		if ( tabId == "tabs-M" ) {
			viewGrid_1(gridObj_4,"ly_"+gridObj_4.id);
			myWorksInfoList();

			viewGrid_1(gridObj_5,"ly_"+gridObj_5.id);
			myDocInfoCntList();

			viewGrid_1(gridObj_7,"ly_"+gridObj_7.id);
			myDocInfoCntList();

			viewGrid_1(gridObj_6,"ly_"+gridObj_6.id);
			myAlarmDocInfoCntList();

			viewGrid_1(gridObj_1,"ly_"+gridObj_1.id);
			noticeList();

			viewGrid_1(gridObj_2,"ly_"+gridObj_2.id);
			myWorkList();

			viewGrid_1(gridObj_3,"ly_"+gridObj_3.id);
			myApprovalDocInfoList();
		}
	}

	function goProc(flag, work_cd) {

		var frm = document.work_form;
		var msg = "";

		var work_date 	= $("#work_form #work_date" + work_cd);
		var content		= $("#work_form #content" + work_cd);

		if ( flag != "del" ) {
			if(isNullInput(work_date,'<%=CommonUtil.getMessageSplit("ERROR.PARAM.02","[일자]","") %>')) return;
			if(isNullInput(content,'<%=CommonUtil.getMessageSplit("ERROR.PARAM.02","[To Do List]","") %>')) return;
		}

		if(confirm("처리하시겠습니까?")) {

			frm.work_date.value	= work_date.val();
			frm.content.value	= content.val();

			frm.flag.value 			= flag;
			frm.work_cd.value 		= work_cd;
			frm.target 				= "if1";
			frm.action 				= "<%=sContextPath%>/tWorks.ez?c=myWork_p";

			frm.submit();
		}
	}

	//작업상태변경 바로가기
	function myActiveList(odate, status, dataCenter, userDaily) {
		
		odate = odate.replace("/", "");

		if (userDaily == "정기"){
			userDaily = "Y";
		} else if (userDaily == "수시오더"){
			userDaily = "S";
		} else{
			userDaily = "N";
		}

		top.closeTab('tabs-0401');
		addTab('c', '작업상태변경', '04', '0401', 'tWorks.ez?c=ez009&menu_gb=0401&status='+status+'&odate='+odate+'&dataCenter='+dataCenter+'&user_daily='+userDaily);
	}

	//결재 진행 현황 바로가기
	function myDocInfoList(state_cd,apply_cd) {

		var to_day = new Date();
		var to_date = to_day.getFullYear() + ('0' + (to_day.getMonth() + 1)).slice(-2) + ('0' + to_day.getDate()).slice(-2);

		var from_day = new Date(to_day.setDate(to_day.getDate() - 6));
		var from_date = from_day.getFullYear() + ('0' + (from_day.getMonth() + 1)).slice(-2) + ('0' + from_day.getDate()).slice(-2);

		top.closeTab('tabs-0399');
		addTab('c', '요청문서함', '04', '0399', 'tWorks.ez?c=ez004&menu_gb=0399&doc_gb=99&itemGb=myDocList&to_date='+to_date+'&from_date='+from_date+'&search_state_cd='+state_cd+'&search_apply_cd='+apply_cd);

	}

	//오류 현황 바로가기
	function opAlertErrorList(message) {

		var to_day = new Date();
		var to_date = to_day.getFullYear() + ('0' + (to_day.getMonth() + 1)).slice(-2) + ('0' + to_day.getDate()).slice(-2);

		var from_day = new Date(to_day.setDate(to_day.getDate() - 6));
		var from_date = from_day.getFullYear() + ('0' + (from_day.getMonth() + 1)).slice(-2) + ('0' + from_day.getDate()).slice(-2);

		top.closeTab('tabs-0402');
		addTab('c', '오류관리', '04', '0402', 'aEm.ez?c=ez003_op&menu_gb=0402&message='+message+'&to_date='+to_date+'&from_date='+from_date);
	}

	function approvalList() {
		top.closeTab('tabs-0390');
		top.addTab('c', '결재문서함', '01', '0390', 'tWorks.ez?c=ez005&menu_gb=0390&doc_gb=99&itemGb=approvalList');
	}

	function execList(state_cd, apply_cd) {
		top.closeTab('tabs-0399');
		top.addTab('c', '요청문서함', '03', '0399', 'tWorks.ez?c=ez004&menu_gb=0399&doc_gb=00&itemGb=execList&search_state_cd='+state_cd+'&search_apply_cd='+apply_cd);
	}
	function closeWin(board_cd) {

		if($("#chk_notice_close_"+board_cd+"_1").prop("checked")) {
			setCookie('cookie_dl_tmp_' + board_cd, 'Y' , 1 );
		} else if($("#chk_notice_close_"+board_cd+"_7").prop("checked")) {
			setCookie('cookie_dl_tmp_' + board_cd, 'Y' , 7 );
		}

		$('#dl_tmp_'+board_cd).remove();
	}

	//쿠키설정
	function setCookie( name, value, expiredays ) {

		var todayDate = new Date();

		todayDate.setDate( todayDate.getDate() + expiredays );
		document.cookie = name + '=' + escape( value ) + '; path=/; expires=' + todayDate.toGMTString() + ';'
	}

	//쿠키 불러오기
	function getCookie(name) {

		var obj = name + "=";
		var x 	= 0;

		while ( x <= document.cookie.length ) {

			var y = (x+obj.length);

			if ( document.cookie.substring( x, y ) == obj ) {

				if ((endOfCookie=document.cookie.indexOf( ";", y )) == -1 )

					endOfCookie = document.cookie.length;

				return unescape( document.cookie.substring( y, endOfCookie ) );

			}

			x = document.cookie.indexOf( " ", x ) + 1;

			if ( x == 0 )
				break;
		}

		return "";
	}

	function fn_alert_check() {

		var alarm_chk1 	= "<%=strAlarmChk1%>";
		var alarm_chk2 	= "<%=strAlarmChk2%>";
		var alarm_chk3 	= "<%=strAlarmChk3%>";

		if ( alarm_chk1 > 0 || alarm_chk2 > 0) {
			if ( !confirm('미 처리 or 미 확인 오류작업이 존재합니다.\n오류 관리를 진행해 주세요.') ) return;

			alarm_chk3 = replaceAll(alarm_chk3, "-", "");
			alarm_chk3 = alarm_chk3.substring(0, 8);

			addTab('c', '오류관리', '04', '0402', 'aEm.ez?c=ez003_op&menu_gb=0402&old_odate='+alarm_chk3);
		}
	}
	
	function contentsCompare(ori_con, new_con){
		
		var url = '<%=sContextPath %>/tWorks.ez?pop_if=P01&c=deployJobCompare';
		
		if(dlMap.containsKey('dl_p01')) dlClose('dl_p01');
		$('#if_p01').width(1200).height(600);
		dlPopIframe01('dl_p01','엑셀 작업 검증',$('#if_p01').width(),$('#if_p01').height(),true,true,true);
		
		setTimeout(function(){
			var f = document.f_tmp;
			f.ori_con.value = ori_con;
			f.new_con.value = new_con;
			f.target = "if_p01";
			f.action = url; 
			f.submit();
			
		}, 300);
	}

	document.addEventListener('DOMContentLoaded', function() {
		var navLinks = document.querySelectorAll('.sub-menu li');

		navLinks.forEach(function(link) {
			link.addEventListener('click', function() {
			// 모든 li에서 'clicked' 클래스를 제거
			navLinks.forEach(function(otherLink) {
				otherLink.classList.remove('clicked');
			});

				// 현재 클릭된 li에만 'clicked' 클래스를 추가
				this.classList.add('clicked');
			});
		});
	});
</script>
<iframe id="if1" name="if1" style='width:0px;height:0px;border:none;' ></iframe>
<div id="dl_p01" style='overflow:hidden;display:none;padding:0;'>
	<iframe id='if_p01' name='if_p01' src='about:blank' width='0px' height='0px' scrolling='no'  frameborder="0"  ></iframe>
</div>