<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/jsp/common/inc/header.jsp"%>
<%@ page import="com.ghayoun.ezjobs.t.domain.*" %>

<%
	Map<String, Object> paramMap = CommonUtil.collectParameters(request);
	
	String c = CommonUtil.isNull(paramMap.get("c"));
	
	String menu_gb = CommonUtil.getMessage("CATEGORY.GB.06.GB.0621");
	String[] arr_menu_gb = menu_gb.split(",");
	
	String strSessionDcCode 	= S_D_C_CODE;
	
	
	String strServerGb 			= CommonUtil.isNull(CommonUtil.getMessage("SERVER_GUBUN"));
	String strDataCenter = CommonUtil.isNull(paramMap.get("data_center"));
	String strDataCenterCode = CommonUtil.isNull(paramMap.get("data_center_code"));
	
%>

<table style='width:100%;height:5%;border:none;'>
	<tr style='height:10px;'>
		<td style='vertical-align:top;'>
			<h4 class="ui-widget-header ui-corner-all"  >
				<div class='title_area' >
					<span><%=CommonUtil.isNull(arr_menu_gb[0]) %></span>
				</div> 
			</h4>
		</td>
	</tr>
	<tr style='height:10px;'>
		<td style='vertical-align:top;'>
			<form name="frm1" id="frm1" method="post">
			<input type="hidden" name="data_center"  />
				<h4 class="ui-widget-header ui-corner-all">
					<table style='width:100%;'>
						<tr>
							<th><div class='cellTitle_kang2'>C-M</div></th>
							<td>
								<div class='cellContent_kang'>
									<select id="data_center_items" name="data_center_items" style="width:120px; height:21px;">
										<option value="">--선택--</option>
										<c:forEach var="cm" items="${cm}" varStatus="status">
											<option value="${cm.scode_cd},${cm.scode_eng_nm}">${cm.scode_nm}</option>
										</c:forEach> 
									</select>
								</div>
							</td>
							<th><div class='cellTitle_kang2'>ODATE</div></th>
							<td style="text-align:left" >
								<div class='cellContent_kang'>
									<input type="text" maxlength="8" name="search_start_date" id="search_start_date" value="${ODATE}" class="input datepick" style="width:75px; height:21px;" />
									<select id="search_start_time" name="search_start_time" style="width:50px;height:21px;" >
										  <c:forEach var="i" begin="0" end="23">
										  <c:choose>
										      <c:when test="${i lt 10 }">
										          <option value="0${i}">0${i}</option>
										      </c:when>
										      <c:otherwise>
										          <option value="${i}">${i}</option>
										      </c:otherwise>
										  </c:choose>
										  </c:forEach>
									</select> ~
									<select id="search_end_time" name="search_end_time" style="width:50px;height:21px;" >
										  <c:forEach var="i" begin="0" end="23">
										  <c:choose>
										      <c:when test="${i lt 10 }">
										          <option value="0${i}">0${i}</option>
										      </c:when>
										      <c:otherwise>
										          <option value="${i}">${i}</option>
										      </c:otherwise>
										  </c:choose>
										  </c:forEach>
									</select>
								</div>
							</td>
							<th><div class='cellTitle_kang2'>리소스명</div></th>
							<td style="text-align:left">
								<div class='cellContent_kang'>
								<input type="text" name="search_text" value="" id="search_text" style="width:150px; height:21px;"/>
								</div>
							</td>
							<td style="text-align:right">
								<span id="btn_search" style='display:none;'>검색</span>
							</td>
						</tr>
						<tr>
						</tr>
					</table>
				</h4>
			</form>
		</td>
	</tr>
	<tr>
	</tr>
</table>
<iframe name="if1" id="if1" width="100%" height="95%" frameborder="0" scrolling="yes"></iframe>

<script>
	

	$(document).ready(function(){
		
		$("#btn_search").show();
		
		var session_dc_code	= "<%=strSessionDcCode%>";
		
		if(session_dc_code != "") { // 개인정보에 C-M이 등록되어 있을경우
			$("select[name='data_center_items']").val(session_dc_code);
			$("#frm1").find("input[name='data_center']").val(session_dc_code);
		}else { // 개인정보에 C-M이 등록이 되어있지 않을경우 -> C-M 콤보박스에서 첫번째값 선택
			$("#data_center_items option:eq(1)").prop("selected", true);
			$("#frm1").find("input[name='data_center']").val($("select[name='data_center_items']").val());
		}
		
		var data_center_items = $("select[name='data_center_items'] option:selected").val();

		$("#btn_search").button().unbind("click").click(function(){
			
			data_center_items = $("select[name='data_center_items'] option:selected").val();
			$("#frm1").find("input[name='data_center']").val(data_center_items);
			resourceTimeChartIframe();	
		}); 
		
		$("#search_start_date").addClass("text_input").unbind('click').click(function(){
			dpCalMin(this.id,'yymmdd');
		});
		
		setTimeout(function(){ 
			resourceTimeChartIframe();	
		}, 1000);   
		
	});
	
	
	function resourceTimeChartIframe(){
		var frm = document.frm1;
		frm.target = "if1";
		frm.action = "<%=sContextPath%>/mEm.ez?c=ez013_iFrame";
		frm.submit();
	}
	
</script>

