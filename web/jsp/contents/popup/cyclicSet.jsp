<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/jsp/common/inc/header.jsp"%>
<%
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
<script type="text/javascript" src="<%=request.getContextPath() %>/js/SlickGrid-2.1.0/plugins/slick.checkboxselectcolumn.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/SlickGrid-2.1.0/plugins/slick.rowselectionmodel.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/SlickGrid-2.1.0/slick.dataview.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/SlickGrid-2.1.0/slick.grid.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/SlickGrid-2.1.0/slick.editors.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/poshytip-1.2/jquery.poshytip.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/works_common.js?v=<%=jsVersion %>" ></script>
</head>

<%
	Map<String, Object> paramMap = CommonUtil.collectParameters(request);
	
	String strCyclicType 		= CommonUtil.isNull(paramMap.get("cyclic_type"));
	String strRerunInterval 	= CommonUtil.isNull(paramMap.get("rerun_interval"));
	String strCountCyclicFrom 	= CommonUtil.isNull(paramMap.get("count_cyclic_from"));
	String strIntervalSequence 	= CommonUtil.isNull(paramMap.get("interval_sequence"));
	String strTolerance			= CommonUtil.isNull(paramMap.get("tolerance"), "0");
	String strSpecificTimes 	= CommonUtil.isNull(paramMap.get("specific_times"));
	String strFlag				= CommonUtil.isNull(paramMap.get("flag"));
	
	// 반복주기(불규칙)의 필요없는 문자 제거
	if ( !strIntervalSequence.equals("") ) {
		strIntervalSequence = strIntervalSequence.replaceAll("[+]", "").replaceAll("M", "");
	}
%>

<script type="text/javascript" >
	$(document).ready(function() {
	
		var cyclic_type = "<%=strCyclicType%>";
		var flag 		= "<%=strFlag%>";
	
		fn_cyclic_type(cyclic_type);
	
		if ( flag == "approval" || flag == "view" ) {
	
			$("input:checkbox").attr("disabled", true);
			$("input:text").attr("readonly", true);
			$("select").attr("disabled",true);
		}
		
	});
</script>

<script type="text/javascript" >

	var c_type = 0;
	var b_type = 0;
	
	function goPrc() {
	
		var frm = document.frm1;
	
		var rerun_interval 	= document.getElementById('rerun_interval').value;
		var tolerance 		= document.getElementById('tolerance').value;
	
		// Cyclic Job 항목 금칙 문자 체크.
		isValid_C_M_blank(rerun_interval, "[반복주기]반복주기");
		isValid_C_M_single(rerun_interval, "[반복주기]반복주기");
		isValid_C_M_speacial(rerun_interval, "[반복주기]반복주기");
		isValid_C_M_character(rerun_interval, "[반복주기]반복주기");
	
		isValid_C_M_blank(tolerance, "[시간지정 ]허용오차");
		isValid_C_M_single(tolerance, "[시간지정 ]허용오차");
		isValid_C_M_speacial(tolerance, "[시간지정 ]허용오차");
		isValid_C_M_character(tolerance, "[시간지정 ]허용오차");
	
		obj = document.getElementsByName('interval_sequence');	
		if( obj!=null && obj.length>0 ){
			for( var i=0; i<obj.length; i++ ){
				if( trim(obj[i].value) != "" ){
					var sTmp = obj[i].value;
					
					if (sTmp) {
						isValid_C_M_blank(sTmp, "[반복주기(불규칙)]반복주기");
						isValid_C_M_single(sTmp, "[반복주기(불규칙)]반복주기");
						isValid_C_M_speacial(sTmp, "[반복주기(불규칙)]반복주기");
						isValid_C_M_character(sTmp, "[반복주기(불규칙)]반복주기");
					}
				}
			}
		}
	
		obj = document.getElementsByName('specific_times');	
		if( obj!=null && obj.length>0 ){
			for( var i=0; i<obj.length; i++ ){
				if( trim(obj[i].value) != "" ){
					var sTmp = obj[i].value;
					
					if (sTmp) {
						isValid_C_M_blank(sTmp, "[시간지정 ]시간");
						isValid_C_M_single(sTmp, "[시간지정 ]시간");
						isValid_C_M_speacial(sTmp, "[시간지정 ]시간");
						isValid_C_M_character(sTmp, "[시간지정 ]시간");
					}
				}
			}
		}
	
		if ( document.getElementById('is_valid_flag').value == "false" ) {
			document.getElementById('is_valid_flag').value = ""; 
			return;
		}
		
		opener.document.getElementById('rerun_interval').value 		= rerun_interval;
		opener.document.getElementById('tolerance').value 			= tolerance;
	
		var num = document.all.cyclic_type.length;   // 라디오 버튼 갯수 
	    for (i = 0; i < num; i++) {
	    	if ( document.all.cyclic_type[i].checked ) {
	    		opener.document.getElementById('cyclic_type').value = document.all.cyclic_type[i].value;
	        }
	    }
	
		// 반복기준이 두가지 타입에 둘다 있다.
	    if ( opener.document.getElementById('cyclic_type').value == "C" ) {
	    	opener.document.getElementById('count_cyclic_from').value = document.getElementById('count_cyclic_from1').value;
	    } else if ( opener.document.getElementById('cyclic_type').value == "V" ) {
	    	opener.document.getElementById('count_cyclic_from').value = document.getElementById('count_cyclic_from2').value;
	    }            
	
		s = "";
		obj = document.getElementsByName('interval_sequence');
		if( obj!=null && obj.length>0 ){
			for( var i=0; i<obj.length; i++ ){
				if( trim(obj[i].value) != "" ){
					var sTmp = obj[i].value;
					s += (s=="")? sTmp:(","+sTmp);
				}
			}
			opener.document.getElementById('interval_sequence').value = s;
		}
	
		s = "";
		obj = document.getElementsByName('specific_times');
		if( obj!=null && obj.length>0 ){
			for( var i=0; i<obj.length; i++ ){
				if( trim(obj[i].value) != "" ){
					var sTmp = obj[i].value;
					s += (s=="")? sTmp:(","+sTmp);
				}
			}
			opener.document.getElementById('specific_times').value = s;
		}
	
		if ( rerun_every_div.style.display == "" && rerun_interval != "" ) {
			opener.document.getElementById('cyclic_ment').innerHTML = "반복주기 : " + rerun_interval + " (분) ";
		} else if ( rerun_interval_sequence_div.style.display == "" && opener.document.getElementById('interval_sequence').value != "" ) {
			opener.document.getElementById('cyclic_ment').innerHTML = "반복주기(불규칙) : " + opener.document.getElementById('interval_sequence').value + " (분) ";
		} else if ( specific_times_div.style.display == "" && opener.document.getElementById('specific_times').value != "" ) {
			opener.document.getElementById('cyclic_ment').innerHTML = "시간지정 : " + opener.document.getElementById('specific_times').value + " ";
		} else {
			opener.document.getElementById('cyclic_ment').innerHTML = "";
		}
	
		window.close();	
	}
	
	function fn_cyclic_type(arg) {
	
		if ( arg == "C" || arg == "" ) {
			rerun_every_div.style.display 				= "";
			rerun_interval_sequence_div.style.display 	= "none";
			specific_times_div.style.display 			= "none";			
		} else if ( arg == "V" ) {
			rerun_every_div.style.display 				= "none";
			rerun_interval_sequence_div.style.display 	= "";
			specific_times_div.style.display 			= "none";
		} else if ( arg == "S" ) {
			rerun_every_div.style.display 				= "none";
			rerun_interval_sequence_div.style.display 	= "none";
			specific_times_div.style.display 			= "";
		}
	}
	
	function addAmount() {
		
		var obj = document.getElementById('div_amount');
		var s 	= "";
		
		s += "<span>";
		s += "<table width='100%' border='0' cellpadding='1' cellspacing='1' bgcolor='#dcdcdc' >";
		s += "<tr height='25' >";
		s += "<td width='100' bgcolor='white' align='center' ><input type='text' name='interval_sequence' id='interval_sequence' size='6' maxlength='4' onkeypress='if(event.keyCode==32 || event.keyCode==39) event.returnValue = false;' style='ime-mode:disabled;height:19px;' /></td>";
		s += "<td bgcolor='white' align='left' >&nbsp;&nbsp;예) 한시간에 한번씩 -> 60</td>";
		s += "</tr>";
		s += "</table>";
		s += "</span>";
	
		$("#div_amount").append(s);
		
		++c_type;
	}
	function delAmount() {
		
		var obj = document.getElementById('div_amount');
		
		try{obj.removeChild(obj.lastChild)}catch(e){};
		
		--c_type;
	}
	
	function addTime() {
		
		var obj = document.getElementById('div_time');
		var s 	= "";
		
		s += "<span>";
		s += "<table width='100%' border='0' cellpadding='1' cellspacing='1' bgcolor='#dcdcdc' >";
		s += "<tr height='25' >";
		s += "<td width='100' bgcolor='white' align='center' ><input type='text' name='specific_times' size='6' maxlength='4' onkeyup='if(!cylic_chk(this.value)) cyclic_clear(this);' onkeypress='if(event.keyCode==32 || event.keyCode==39) event.returnValue = false;' style='ime-mode:disabled;height:19px;' /></td>";
		s += "<td bgcolor='white' align='left' >&nbsp;&nbsp;예) 오후3시마다 -> 1500</td>";
		s += "</tr>";
		s += "</table>";
		s += "</span>";
	
		$("#div_time").append(s);
		
		++b_type;
	}
	function delTime() {
		
		var obj = document.getElementById('div_time');
		
		try{obj.removeChild(obj.lastChild)}catch(e){};
		
		--b_type;
	}
	
	function cylic_chk(obj){
		
		var chk_time = "";
		if(obj != "" && obj.length > 1){
			chk_time = obj.substring(0,2);
		}
			
		if(chk_time > 24){
			alert("입력한 시간을 확인해 주세요.");		
			return false;
		}else{
			return true;
		}
	}
	
	function cyclic_clear(target){
		target.value = "";
	}
</script>

<body>
<form id="frm1" name="frm1" method="post" onsubmit="return false;">
	<input type="hidden" id="is_valid_flag" name="is_valid_flag" />

	<table style='width:98%;height:100%;border:none;'>
		<tr style='height:10px;'>
			<td style='vertical-align:top;'>
				<h1 style="float:left;font-weight:bold;color:#222;font-size:16px;line-height:33px;text-indent:10px;">
						<%=CommonUtil.getMessage("CATEGORY.POP.04") %>					
				</h1>
			</td>
		</tr>
		<tr><td height="5px;"></td></tr>
		<tr>
			<td style="text-align:right;">
				<%
					if ( !strFlag.equals("approval") && !strFlag.equals("view") ) {
				%>				
						<span id="btn_modify">적용</span>				
				<%		
					}
				%>	
				<span id="btn_close">닫기</span>		
			</td>
		</tr>
		<tr><td height="5px;"></td></tr>			
	</table>
	<div class="view_area" style="overflow:visible;">
		<h4 class="ui-widget-header ui-corner-all">		
			<div style="overflow:visible;height:auto;padding:5px">
	
				<table style="width:100%;">
				<tr>
					<td width='100px'> 
						<div class='cellTitle_kang2'>구분</div>
					</td>	
					<td>
						<div class='cellContent_kang'>
								<input type='radio' name='cyclic_type' id='cyclic_type' value='C' <%=  strCyclicType.equals("C")? " checked ":""  %> onclick="fn_cyclic_type(this.value);" style='background:#f1f1f1' checked />반복주기 
								<input type='radio' name='cyclic_type' id='cyclic_type' value='V' <%=  strCyclicType.equals("V")? " checked ":""  %> onclick="fn_cyclic_type(this.value);" style='background:#f1f1f1' />반복주기(불규칙) 
								<input type='radio' name='cyclic_type' id='cyclic_type' value='S' <%=  strCyclicType.equals("S")? " checked ":""  %> onclick="fn_cyclic_type(this.value);" style='background:#f1f1f1' />시간지정							
						</div>
					</td>
				</tr>
				</table>
		
				<div id="rerun_every_div" style="display:none">
					<table style="width:100%;">
						<tr>
							<td width='100px'>
								<div class='cellTitle_kang2'> 반복주기</div>
							</td>
							<td width='300px'>
								<div class='cellContent_kang'>
									<input type='text' id='rerun_interval' name='rerun_interval' value="<%=strRerunInterval%>" size='5' maxlength='5' onkeypress='if(event.keyCode==32 || event.keyCode==39) event.returnValue = false;' style='ime-mode:disabled;height:19px;' />분
								</div>
							</td>
							<td width='100px'>
								<div class='cellTitle_kang2'> 반복기준</div>
							</td>
							<td>
								<div class='cellContent_kang'>
									<select id='count_cyclic_from1' name='count_cyclic_from1' style="height:23px;">
									<%
										String[] aTmp = CommonUtil.getMessage("JOB.COUNT_CYCLIC_FROM").split(",");
									
										for(int i=0;i<aTmp.length; i++){
									%>
											<option value='<%=aTmp[i]%>' <%=  strCountCyclicFrom.equals(aTmp[i])? " selected ":""  %> ><%=aTmp[i]%></option>
									<%
										}
									%>				
									</select>
								</div>
							</td>
						</tr>
						<tr>
							<td>
								<div class='cellTitle_kang2'>
									Tip  
								</div>
							</td>
							<td colspan="3">
								<div class='cellContent_kang'>
									입력된 분단위의 반복 주기를 가지고 반복기준(시작,종료,Target시간)을 가지고 반복 수행됩니다.	
								</div>							
							</td>
						</tr>
				</table>
			</div>
			
			<div id="rerun_interval_sequence_div" style="display:none">
			
				<table style="width:100%;">
					<tr>
						<td width='100px'>
							<div class='cellTitle_kang2'> 
								반복주기(분)
							</div>
						</td>
						<td width='300px'>
							<div class='cellContent_kang'>
							<%
								if ( !strFlag.equals("approval") && !strFlag.equals("view") ) {
							%>
									
									<input type='button' value=' + ' class='btn_white_h24'  onclick='addAmount();' /> <input type='button' value=' - ' class='btn_white_h24' onclick='delAmount()' />
							<%		
								}
							%>	
							</div>		
						</td>
						<td width='100px'>
							<div class='cellTitle_kang2'> 반복기준</div>
						</td>
						<td>
							<div class='cellContent_kang'>
								<select id='count_cyclic_from2' name='count_cyclic_from2' style="height:21px;">
								<%
									aTmp = CommonUtil.getMessage("JOB.COUNT_CYCLIC_FROM").split(",");
								
									for(int i=0;i<aTmp.length; i++){
										if ( !aTmp[i].equals("target") ) {
								%>
											<option value='<%=aTmp[i]%>' <%=  strCountCyclicFrom.equals(aTmp[i])? " selected ":""  %> ><%=aTmp[i]%></option>
								<%
										}
									}
								%>				
								</select>
							</div>
						</td>		
					</tr>
					
					<tr>
						<td>
							<div class='cellTitle_kang2'>
								Tip  
							</div>
						</td>
						<td colspan="3">
							<div class='cellContent_kang'>
								입력된 시간단위의 반복 주기를 가지고(불규칙) 반복기준(시작,종료,Target시간)을 가지고 반복 수행됩니다.	
							</div>							
						</td>
					</tr>
				</table>
				<div id='div_amount'>
				<%
					if ( !strIntervalSequence.equals("") ) {
						String[] aTmpT = strIntervalSequence.split("[,]");
						for (int t = 0; null != aTmpT && t < aTmpT.length; t++ ) {
							String[] aTmpT1 = aTmpT[t].split(",",1);
				%>
							<span>
								<table>
								<tr  >
									<td width="100" bgcolor='white' align="center" >
										<input type='text' id='interval_sequence' name='interval_sequence' value="<%=aTmpT1[0]%>" size='6' maxlength='4' onkeypress='if(event.keyCode==32 || event.keyCode==39) event.returnValue = false;' style='ime-mode:disabled;' />
									</td>
									<td bgcolor='white' align="left" >&nbsp;&nbsp;예) 한시간에 한번씩 -> 60</td>
								</tr>
								</table>
							</span><script>++c_type;</script>
				<%	
						}
					}
				%>	
				</div>
			</div>
			
			<div id="specific_times_div" style="display:none">
			
				<table style="width:100%;">
				<tr>
					<td width='100px'>
						<div class='cellTitle_kang2'>시간</div>
					</td>
					<td width='300px'>
						<div class='cellContent_kang'>
							<%
								if ( !strFlag.equals("approval") && !strFlag.equals("view") ) {
							%>
									<input type='button' value=' + ' class='btn_white_h24' onclick='addTime();'/> <input type='button' value=' - ' class='btn_white_h24' onclick='delTime()' />
							<%		
								}
							%>	
						</div>		
					</td>
					<td width='100px'>
						<div class='cellTitle_kang2'>허용오차</div>
					</td>
					<td>
						<div class='cellContent_kang'>
							<input type='text' id='tolerance' name='tolerance' value="<%=strTolerance%>" size='5' maxlength='5' onkeypress='if(event.keyCode==32 || event.keyCode==39) event.returnValue = false;' style='ime-mode:disabled;height:19px;' />분
						</div>
					</td>		
				</tr>
				<tr>
					<td>
						<div class='cellTitle_kang2'>
								Tip  
						</div>
					</td>
					<td colspan="3">
						<div class='cellContent_kang'>
								입력된 특정 시간 기준으로 오차범위 입력 값을 가지고 반복 수행됩니다.	
						</div>							
					</td>
				</tr>
			</table>
				
				<div id='div_time'>
				<%
					if ( !strSpecificTimes.equals("") ) {
						String[] aTmpT = strSpecificTimes.split("[,]");
						for (int t = 0; null != aTmpT && t < aTmpT.length; t++ ) {
							String[] aTmpT1 = aTmpT[t].split(",",1);
				%>
							<span>
								<table width='100%' border='0' cellpadding='1' cellspacing='1' bgcolor='#dcdcdc' >
								<tr  >
									<td width="100" bgcolor='white' align="center" ><input type='text' id = 'specific_times' name='specific_times' value="<%=aTmpT1[0]%>" onkeyup='if(!cylic_chk(this.value)) cyclic_clear(this);' size='6' maxlength='4' onkeypress='if(event.keyCode==32 || event.keyCode==39) event.returnValue = false;' style='ime-mode:disabled;height:19px;' /></td>
							<td bgcolor='white' align="left" >&nbsp;&nbsp;예) 오후3시마다 -> 1500</td>
								</tr>
								</table>
							</span><script>++b_type;</script>
				<%	
						}
					}
				%>
				</div>
				
			</div>
	
		</div>
		</h4>
	</div>
</form>
<script>
	$(document).ready(function(){
		$("#btn_modify").button().unbind("click").click(function(){
			
			var interval = "Y";
			var specific = "Y";
			var cyclic_type = $("input:radio[name='cyclic_type']:checked").val();
			
			if(cyclic_type == "C"){
				if($("#rerun_interval").val() == ""){
					 alert("반복주기에 반드시 분을 입력 해야 합니다.");
					 return;
				}
			}
			
			if(cyclic_type == "V"){
				if(c_type == 0){
					alert("반복주기에 반드시 분을 입력 해야 합니다.");
					return;
				}else{
					$("input[name='interval_sequence']").each(function(){						
						if($(this).val() == ""){
							alert("반복주기에 반드시 분을 입력 해야 합니다.");
							interval = "N";
							return;
						}					
					});	
					
					if(interval == "N") return;
				}
			}
			
			if(cyclic_type == "S"){
				if(b_type == 0){
					alert("시간에 값을 반드시 입력 해야 합니다.");
					return;
				}else{
					$("input[name='specific_times']").each(function(){						
						if($(this).val() == ""){
							alert("시간에 값을 반드시 입력 해야 합니다.");
							specific = "N";
							return;
						}						
					});	
					
					if(specific == "N") return;
				}
			}
						
			goPrc();
			
		});
		
		$("#btn_close").button().unbind("click").click(function(){
			self.close();
		});
	});
</script>
</body>
</html>
