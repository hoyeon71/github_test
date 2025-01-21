<%@page import="org.apache.axis.encoding.Base64"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="com.ghayoun.ezjobs.m.domain.*" %>

<%@include file="/jsp/common/inc/header.jsp"%>
<%@include file="/jsp/common/inc/sessionChkPopup.jsp"%>
<%@include file="/jsp/common/inc/progBar.jsp"%>

<%
	Map<String, Object> paramMap = CommonUtil.collectParameters(request);
	
	String server_lang			= CommonUtil.isNull((String)request.getAttribute("server_lang"));
	String sysout				= CommonUtil.isNull((String)request.getAttribute("sysout"));
	
	// 이 로직 왜 있는지 모르겠어서 그냥 주석처리 (2024.6.20 강명준)
	/* if (sysout != null && !sysout.equals("") ) {
		if ( sysout.indexOf("+") > -1 ) {
			sysout = sysout.substring(sysout.indexOf("+"), sysout.length());
		} else if ( sysout.indexOf("[1]") > -1 ) {
			sysout = sysout.substring(sysout.indexOf("[1]"), sysout.length());
		}
	} */
	
	String b = null;
	if (sysout != null) {
		b = Base64Coder.encodeString(sysout);
	}
	
	String strCmd				= CommonUtil.replaceStrXml(CommonUtil.isNull(paramMap.get("cmd"), "tail -3000"));
	String strRealCmd			= CommonUtil.replaceStrXml(CommonUtil.isNull((String)request.getAttribute("real_cmd")));
	String strTotalRerunCount 	= CommonUtil.isNull(paramMap.get("total_rerun_count"), "0");
	String strOrderId 			= CommonUtil.isNull(paramMap.get("order_id"));
	String strMemName 			= CommonUtil.isNull(paramMap.get("memname"));
	String strNodeId 			= CommonUtil.isNull(paramMap.get("node_id"));
	String strEndDate 			= CommonUtil.isNull(paramMap.get("end_date"));
	String strDataCenter		= CommonUtil.isNull(paramMap.get("data_center"));
	String strRerunCount		= CommonUtil.isNull(paramMap.get("rerun_count"));
	String strNowRerunCount		= CommonUtil.isNull(paramMap.get("now_rerun_count"));
	String strJobName			= CommonUtil.isNull(paramMap.get("job_name"));
	String strOdate				= CommonUtil.isNull(paramMap.get("odate"));
	String strFlag				= CommonUtil.isNull(paramMap.get("flag"));
	String strRunCount			= CommonUtil.isNull(paramMap.get("now_rerun_count"));	
	String strApplType			= CommonUtil.isNull(paramMap.get("appl_type"));	
	
	String strLogFromLine		= CommonUtil.isNull(request.getAttribute("strLogFromLine"));
	String strLogToLine			= CommonUtil.isNull(request.getAttribute("strLogToLine"));
	String strLogMaxLine		= CommonUtil.isNull(request.getAttribute("strLogMaxLine"));
	
	//js version 추가하여 캐시 새로고침
	String jsVersion 			= CommonUtil.getMessage("js_version");
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

<script src="<%=sContextPath %>/js/jquery-1.9.0.min.js"></script>
<script type="text/javascript" src="<%=sContextPath %>/js/common.js" ></script>
<script type="text/javascript" src="<%=sContextPath %>/js/works_common.js?v=<%=jsVersion %>" ></script>
<script type="text/javascript" src="<%=sContextPath %>/js/popup.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery-ui.custom.min.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.blockUI.js" ></script>
<script type="text/javascript" >

	function btn_download() {
		var frm = document.f_s;
		try {viewProgBar(true);} catch (e) {}
		frm.action = "<%=sContextPath %>/mPopup.ez?c=ez007_local_down";
		frm.target = "prcFrame";
		frm.submit();
	}
	
	function btn_download_a() {
		var frm = document.f_s;
		try {viewProgBar(true);} catch (e) {}
		frm.action = "<%=sContextPath %>/mPopup.ez?c=ez007_local_down2";
		frm.target = "prcFrame";
		frm.submit();
	}
	
	function btn_exec_cmd () {
		var rerunCnt = $("#select_rerun_count option:selected").val();
		
		if (rerunCnt == undefined) {
			exec_cmd(1);
		} else {
			exec_cmd(rerunCnt);
		}
		
	}
	
	function exec_cmd(rerun_count) {
		
		var frm = document.f_s;
		
		var server_lang = "<%=server_lang%>";
		
		if ( server_lang == "UTF-8" ) {
		
			var log_from_line 	= frm.from_line.value;
			var log_to_line 	= frm.to_line.value;
			
			//읽어올 라인의 범위가 양수가 아니거나 제한 범위를 초과시 진행하지 않음.
			if(Number(log_to_line) - Number(log_from_line) < 0 || Number(log_to_line) - Number(log_from_line) > <%=Integer.parseInt(strLogMaxLine)-1 %>) {
				alert('해당 로그의 조회범위를 초과하였습니다.');
				return;
			}
		}
		
		try {viewProgBar(true);} catch (e) {}

		try {viewProgBar(true);} catch (e) {}

		frm.rerun_count.value 		= rerun_count
		frm.now_rerun_count.value	= rerun_count;
		
		openPopupCenter3("about:blank","popupSysoutTelnet",800,600);
	
		frm.action = "<%=sContextPath %>/mPopup.ez?c=ez007_local";
		frm.target = "popupSysoutTelnet";
		frm.submit();
	}
	
</script>

</head>

<body>

<form id="f_s" name="f_s" method="post" onsubmit="return false;">
	<input type="hidden" name="data_center" 		value='<%=strDataCenter%>' />
	<input type="hidden" name="order_id"  			value='<%=strOrderId%>' />
	<input type="hidden" name="node_id"  			value='<%=strNodeId%>' />
	<input type="hidden" name="job_name"  			value='<%=strJobName%>' />
	<input type="hidden" name="rerun_count"  		value='<%=strRerunCount%>' />
	<input type="hidden" name="total_rerun_count"  	value='<%=strTotalRerunCount%>' />
	<input type="hidden" name="now_rerun_count"  	value='<%=strRunCount%>'/>
	<input type="hidden" name="flag" 				value='<%=strFlag%>'/>
	<input type="hidden" name="odate" 				value='<%=strOdate%>'/>
	<input type="hidden" name="end_date" 			value='<%=strEndDate%>'/>
	<input type="hidden" name="memname" 			value='<%=strMemName%>'/>
	<input type="hidden" name="appl_type" 			value='<%=strApplType%>'/>


<table style='width:100%; height:99%; border:none;'> 
	<tr style='height:10px;'>   
		<td style='vertical-align:top;'>
			<h4 class="ui-widget-header ui-corner-all">
				<div class='title_area' style="width:100%; text-align:left;">
					<span><%=CommonUtil.getMessage("POPUP.SYSOUT.TITLE") %></span>	
					<%if(strApplType.equals("KBN062023")){%>
					<input type='button' name='btn_execution' value='<%=CommonUtil.getMessage("POPUP.KUBERNETES.TITLE") %>' onClick="fn_execution_log_popup();">
					<%}%>
				</div>
			</h4>
		</td>
	</tr>
	
	<%
		// agent 서버가 UTF-8 일 경우만 다양하게 조회할 수 있는 UI 제공
		if ( server_lang.equals("UTF-8") ) {
	%>	
			<tr><td height="5px;"></td></tr>
			<tr style='height:10px;'>
				<td style="text-align:left;">
					<span>
						<input type="text" style="width:40px;height:14px;text-align:center;" maxlength="5" name="from_line" value="<%=strLogFromLine %>" />줄 ~ 
						<input type="text" style="width:40px;height:14px;text-align:center;" maxlength="5" name="to_line" value="<%=strLogToLine %>" />줄
					</span>
					<a href="Javascript:exec_cmd(select_rerun_count.value);" class="btn_white_h20" style="height:18px;line-height:18px;" >조회</a>
					<span style="font-weight:bold; margin:10px;">(최대 열람 가능: <%=strLogMaxLine %>줄)</span>
					
					<span id="btn_sysout_a" style="display:none">전체 다운로드</span>
					<span id="btn_sysout">다운</span>
					<span id="btn_close">닫기</span>
				</td>
			</tr>
	<%
		}
	%>
			
	<tr><td height="5px;"></td></tr>
	<tr style='height:100%;'>
		<td valign="top">
			<h4 class="ui-widget-header ui-corner-all">			
			<table style="width:100%; height:100%;">  
				<colgroup>
					<col width="*">
				</colgroup>
				<tbody>
					<tr height="30px">
						<td>
							<% if (!strTotalRerunCount.equals("0")) { %>
							<select id="select_rerun_count" name="select_rerun_count" onChange="exec_cmd(this.value);">
							<% 
								for ( int i = Integer.parseInt(strTotalRerunCount); i > 0; i-- ) {
							%>
									<option value=<%=i%> <%=strNowRerunCount.equals(Integer.toString(i))? "selected" : "" %>>RERUN COUNT : <%=i%></option>
							<%
								}
							%>
							</select>
							<% }%>
						</td>
						<td>
							<%-- <div align="left" class="btn">
								<span>
									<input type="text" style="width:40px;height:14px;text-align:center;" maxlength="5" name="from_line" value="<%=strLogFromLine %>" />줄 ~ 
									<input type="text" style="width:40px;height:14px;text-align:center;" maxlength="5" name="to_line" value="<%=strLogToLine %>" />줄
								</span>
								<a href="Javascript:exec_cmd(select_rerun_count.value);" class="btn_white_h20" style="height:18px;line-height:18px;" >조회</a>
								<span style="font-weight:bold; margin:10px;">(최대 열람 가능: <%=strLogMaxLine %>줄)</span>
							</div> --%>
						</td>
					</tr>
					<tr>
						<td style="vertical-align: top;" colspan="2">
							<div align="left" style='overflow-y:auto;overflow-x:auto;'>
								<pre><c:out value='${sysout != null ? sysout: ""}'/></pre>
							</div>
						</td>
					</tr>
				</tbody>
			</table>
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
		
		$("#btn_sysout").button().unbind("click").click(function(){
			btn_download();
		});
		
		$("#btn_sysout_a").button().unbind("click").click(function(){
			btn_download_a();
		});
		
		$("#btn_search").button().unbind("click").click(function(){
			btn_exec_cmd();
		});
		
	});	
	
	//Kubernetes execution log
	function fn_execution_log_popup() {

		var frm = document.f_s;

		openPopupCenter1("popupExecutionLog","popupExecutionLog",1000,500);

		frm.action = "<%=sContextPath %>/mPopup.ez?c=executionLog";
		frm.target = "popupExecutionLog";
		frm.submit();
	}
</script>
<%@include file="/jsp/common/inc/progBar.jsp"  %>
</html>