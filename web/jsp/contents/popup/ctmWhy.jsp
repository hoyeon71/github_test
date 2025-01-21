<%@page import="java.util.regex.Matcher"%>
<%@page import="java.util.regex.Pattern"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="com.ghayoun.ezjobs.m.domain.*" %>

<%@include file="/jsp/common/inc/header.jsp"%>
<%@include file="/jsp/common/inc/sessionChkPopup.jsp"%>

<%
	Map<String, Object> paramMap = CommonUtil.collectParameters(request);

	String strDataCenter	= CommonUtil.isNull(paramMap.get("data_center"));
	String strAddAuth		= CommonUtil.isNull(paramMap.get("add_auth"));
	
	String ctmWhy			= (String)request.getAttribute("ctmWhy");
	String ctmWhy2			= "";
	String conditionAddYn	= "N";
	StringBuilder inCondName = new StringBuilder();
    StringBuilder inCondDate = new StringBuilder();
	
	if ( !ctmWhy.equals("") && !strAddAuth.equals("no") ) {
		
		String[] arrCtmWhy = ctmWhy.split("\n");
		
		for ( int i = 0; i < arrCtmWhy.length; i++ ) {
			
			if ( arrCtmWhy[i].indexOf("Missing condition") > -1 ) {
				
				String strInCondName = arrCtmWhy[i].split("[']")[1];
				String strInCondDate = arrCtmWhy[i].split("[']")[3];
				
				ctmWhy2 += "<a href=\"JavaScript:fn_in_cond_view('"+strInCondName+"', '"+strInCondDate+"');\">" + arrCtmWhy[i] + "</a>";
				
			} else {
				
				ctmWhy2 += arrCtmWhy[i];
			}
		}
		
	} else {
		ctmWhy2 = ctmWhy;
	}
	
	if(ctmWhy2.contains("Missing condition")){
		conditionAddYn = "Y";
		
		// 정규 표현식 패턴 정의
        Pattern pattern = Pattern.compile("Missing condition '(.*?)' with dateref '(.*?)'");
        Matcher matcher = pattern.matcher(ctmWhy2);

        // 매칭되는 부분을 찾으면 변수에 할당
        while (matcher.find()) {
                if (inCondName.length() > 0) {
                    inCondName.append("||");
                    inCondDate.append("||");
                }
                inCondName.append(matcher.group(1));
                inCondDate.append(matcher.group(2));
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

<script src="<%=sContextPath %>/js/jquery-1.9.0.min.js"></script>
<script type="text/javascript" src="<%=sContextPath %>/js/common.js" ></script>
<script type="text/javascript" src="<%=sContextPath %>/js/popup.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery-ui.custom.min.js" ></script>
<script type="text/javascript" >
function fn_in_cond_view (in_cond_name, in_cond_date) {

	var frm = document.frm1;
	
	frm.in_cond_name.value 		= in_cond_name;
	frm.in_cond_date.value		= in_cond_date;
}

function fn_in_cond_add () {
	
	var frm = document.frm1;
	
	/* var in_cond_name = frm.in_cond_name.value; */
	var in_cond_name = "<%=inCondName%>";
	
	if ( in_cond_name == "" ) {
		
		alert("발행할 컨디션을 선택해 주세요.");
		return;
		
	} else {
		
		if( !confirm("Missing condition 된 모든 선행작업조건을 발행하시겠습니까?") ) return;
	}
	
	frm.action = "<%=sContextPath %>/mPopup.ez?c=ez008&gubun=in_cond_add";
	frm.target = "popupCtmWhy";
	frm.submit();
	
}
</script>
</head>

<body>

<form id="frm1" name="frm1" method="post" onsubmit="return false;">
<input type="hidden" name="data_center" 	value='<%=strDataCenter%>' />
<input type="hidden" name="in_cond_name" 	value='<%=inCondName%>' />
<input type="hidden" name="in_cond_date" 	value='<%=inCondDate%>' />

<table style='width:100%; height:99%; border:none;'>
	<tr style='height:10px;'>
		<td style='vertical-align:top;'>
			<h4 class="ui-widget-header ui-corner-all">
				<div class='title_area' style="width:100%; text-align:left;">
					<span><%=CommonUtil.getMessage("POPUP.CTM_WHY.TITLE") %></span>					
				</div>				
			</h4>
		</td>
	</tr>
	<tr><td height="5px;"></td></tr>
	<tr>
		<td style="text-align:right;">
			<span id="btn_cond_add" style="margin-right:5px;display:none;">컨디션 발행</span>
			<span id="btn_close" style="margin-right:5px;">닫기</span>
		</td>
	</tr>
	<tr><td height="5px;"></td></tr>
	<tr>
		<td valign="top">
			<h4 class="ui-widget-header ui-corner-all">
			<pre><%=ctmWhy2%></pre>
			</h4>
		</td>
	</tr>
	<tr>
		<td valign="top">
			<%-- <%
				if ( !strAddAuth.equals("no") ) {
				/* if(conditionAddYn.equals("Y")){ */
			%>	
					<h4 class="ui-widget-header ui-corner-all">
					<table style="width:100%;">
					<tr>
						<td width="40%">선행작업조건
							<input class='input' type='text' name='in_cond_name' size='20' readOnly />
						</td>
						<td width="40%">일자유형
							<input class='input' type='text' name='in_cond_date' size='6' readOnly />
						</td>
						<td width="20%">
							<div class="btn">								
								<span id="btn_cond_add">발행</span>
							</div>
						</td>
					</tr>
					</table>
					</h4>
			<%
				}
			%> --%>
		</td>
	</tr>
</table>	
</form>

</body>
<script>
	$(document).ready(function(){		
		var conditionAddYn			= "<%=conditionAddYn %>";
		
		$("#btn_close").button().unbind("click").click(function(){
			self.close();
		});	
		
		$("#btn_cond_add").button().unbind("click").click(function(){
			fn_in_cond_add();
		});
		
		if(conditionAddYn == "Y"){
			$("#btn_cond_add").show();
		}
	});	
</script>
</html>