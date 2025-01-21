<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/jsp/common/inc/header.jsp"%>

<c:set var="user_gb_cd" value="${fn:split(USER_GB_CD,',')}"/>
<c:set var="user_gb_nm" value="${fn:split(USER_GB_NM,',')}"/>
<c:set var="duty_gb_cd" value="${fn:split(DUTY_GB_CD,',')}"/>
<c:set var="duty_gb_nm" value="${fn:split(DUTY_GB_NM,',')}"/>
<c:set var="dept_gb_cd" value="${fn:split(DEPT_GB_CD,',')}"/>
<c:set var="dept_gb_nm" value="${fn:split(DEPT_GB_NM,',')}"/>

<%
	Map<String, Object> paramMap = CommonUtil.collectParameters(request);
	String c = CommonUtil.isNull(paramMap.get("c"));
	String gridId = "g_"+c;
	
	String menu_gb = CommonUtil.getMessage("CATEGORY.GB.04.GB."+CommonUtil.isNull(paramMap.get("menu_gb")));
	String[] arr_menu_gb = menu_gb.split(",");
	
	String strSearchStartDate 	= CommonUtil.getCurDateTo(CommonUtil.getCurDate(""), 0);			
	String strSearchEndDate 	= CommonUtil.getCurDateTo(CommonUtil.getCurDate(""), 0);	
	
	// 세션값 가져오기.
	String strSessionUserCd 	= S_USER_CD;
	String strSessionDcCode 	= S_D_C_CODE;

	String aTmp[] = null;
%>

<form id="f_s" name="f_s" method="post" onsubmit="return false;">	
	<input type="hidden" name="p_search_gubun"  id="p_search_gubun"/>
	<input type="hidden" name="p_search_text" 	id="p_search_text"/>
	<input type="hidden" name="p_send_gubun" 	id="p_send_gubun"/>
	<input type="hidden" name="p_s_send_date" 	id="p_s_send_date"/>
	<input type="hidden" name="p_e_send_date" 	id="p_e_send_date"/>
	<input type="hidden" name="p_send_description" 	id="p_send_description"/>
	<input type="hidden" name="p_data_center" 	id="p_data_center"/>
</form>

<form name="form3" id="form3" method="post" onsubmit="return false;">
	<input type="hidden" name="user_cd" id="user_cd"/>
</form>

<table style='width:100%;height:100%;border:none;'>
	<tr style='height:10px;'>
		<td style='vertical-align:top;'>
			<h4 class="ui-widget-header ui-corner-all"  >
				<div id='t_<%=gridId %>' class='title_area' >
					<span><%=CommonUtil.isNull(CommonUtil.getMessage("CATEGORY.GB.04"))%> > <%=CommonUtil.isNull(arr_menu_gb[0]) %></span>
				</div>
			</h4>
		</td>
	</tr>
	<tr style='height:10px;'>
		<td style='vertical-align:top;'>
			<form name="frm1" id="frm1" method="post">
			<h4 class="ui-widget-header ui-corner-all">
			<table style='width:100%;'>
				<tr>
					<th width='10%'><div class='cellTitle_kang2' style='min-width:120px;'>C-M</div></th> 
					<td width='35%'>
						<div class='cellContent_kang' style='width:300px;'>
							<select id="data_center_items" name="data_center_items" style="width:120px; height:21px;">						
								<option value="">선택</option>
								<c:forEach var="cm" items="${cm}" varStatus="status">
									<option value="${cm.scode_cd},${cm.scode_eng_nm}">${cm.scode_nm}</option>
								</c:forEach>
							</select>
						</div>						
					</td>
					<th width='10%'><div class='cellTitle_kang2' style='min-width:120px;'>전송일자</div></th>
					<td width='35%'>
						<div class='cellContent_kang' style='width:300px;'>
						<input type="text" name="s_send_date" id="s_send_date" value="<%=strSearchStartDate%>" class="input datepick" style="width:75px; height:21px;" maxlength="8" /> ~
						<input type="text" name="e_send_date" id="e_send_date" value="<%=strSearchEndDate%>" class="input datepick" style="width:75px; height:21px;" maxlength="8" />
						</div>						
					</td>
					<td></td>
				</tr>
				<tr>
					<th><div class='cellTitle_kang2'>통보사유</div></th>
					<td>
						<div class='cellContent_kang'>
							<select name="send_description" id="send_description" style="width:120px;height:21px;">
								<option value=''>전체</option>
								<%
									aTmp = CommonUtil.getMessage("JOB_SEND_STATUS").split(",");
									for(int i=0; i<aTmp.length; i++){
										String aTmp1[] = aTmp[i].split("[|]");
										out.print(" <option value='"+aTmp1[0]+"' >"+aTmp1[1]+"</option>");
									}
								%>
							</select>
						</div>
					</td>

					<th><div class='cellTitle_kang2'>발송구분</div></th>
					<td>
						<div class='cellContent_kang'>
						<select name="send_gubun" id="send_gubun" style="width:120px;height:21px;">
							<option value="">--전체--</option>
							<c:forEach var="sendGb" items="${sendGb}" varStatus="status">
								<option value="${sendGb.scode_cd}">${sendGb.scode_nm}</option>
							</c:forEach>
						</select>
						</div>						
					</td>
				</tr>
				
				<tr>
					<th><div class='cellTitle_kang2'>검색구분</div></th>
					<td>
						<div class='cellContent_kang'>
							<select name="search_gubun" id="search_gubun" style="width:120px;height:21px;">
								<option value="job_name">작업명</option>
								<option value="user_nm">담당자</option>
								<option value="message">메세지내용</option>
							</select>&nbsp;
							<input type="text" name="search_text" value="" id="search_text" style="width:150px; height:21px;" />
						</div>
					</td>
					<td></td>
					<td style="text-align:right" colspan="2">
						<span id='btn_search' style='float:right;'>검색</span>
					</td>
				</tr>
			</table>
			</h4>
			</form>
		</td>
	</tr>
	<tr>
		<td id='ly_<%=gridId %>' style='vertical-align:top;'>
			<div id="<%=gridId %>" class="ui-widget-header ui-corner-all"></div>
		</td>
	</tr>
	<tr style='height:10px;'>
		<td style='vertical-align:top;'>
			<h4 class="ui-widget-header ui-corner-all" >
				<div align='right' class='btn_area' >
					<div id='ly_total_cnt' style='padding-top:5px;float:left;'></div>	
					<span id="btn_excel">엑셀다운</span>
				</div>
			</h4>
		</td>
	</tr>
</table>
<script>
	
	var gridObj = {
		id : "<%=gridId %>"
		,colModel:[
	   		{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'번호',width:50,minWidth:50,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'DATA_CENTER_NAME',id:'DATA_CENTER_NAME',name:'C-M',width:100,minWidth:100,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'JOB_NAME',id:'JOB_NAME',name:'작업명',width:200,minWidth:200,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
	   		//,{formatter:gridCellNoneFormatter,field:'ORDER_ID',id:'ORDER_ID',name:'ORDER_ID',width:80,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'SEND_GUBUN_NM',id:'SEND_GUBUN_NM',name:'구분',width:100,minWidth:100,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'SEND_DESCRIPTION',id:'SEND_DESCRIPTION',name:'통보사유',width:100,minWidth:100,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'MESSAGE',id:'MESSAGE',name:'메세지내용',width:450,minWidth:450,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'USER_NM',id:'USER_NM',name:'담당자',width:100,minWidth:100,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'SEND_INFO',id:'SEND_INFO',name:'발송정보',width:160,minWidth:160,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'SEND_DATE',id:'SEND_DATE',name:'전송일자',width:130,minWidth:130,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}	   		
	   		,{formatter:gridCellNoneFormatter,field:'RETURN_CODE',id:'RETURN_CODE',name:'회신코드',width:80,minWidth:80,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'RETURN_DATE',id:'RETURN_DATE',name:'회신일자',width:130,minWidth:130,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'DATA_CENTER',id:'DATA_CENTER',name:'C-M',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   		,{formatter:gridCellNoneFormatter,field:'SEND_CD',id:'SEND_CD',name:'SEND_CD',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   		
	   	]
		,rows:[]
		,vscroll: <%=S_GRID_VSCROLL%>
	};
	
	$(document).ready(function(){
		
		var session_dc_code	= "<%=strSessionDcCode%>";
		$("#btn_search").show();
		$("#btn_excel").show();
		
		viewGrid_1(gridObj,"ly_"+gridObj.id,{enableColumnReorder:true},'AUTO');
		//sendLogList();		//초기 전체사용자 로드
		
		if(session_dc_code != "") { // 개인정보에 C-M이 등록되어 있을경우
			$("select[name='data_center_items']").val(session_dc_code);
			$("#f_s").find("input[name='data_center']").val(session_dc_code);
		}else { // 개인정보에 C-M이 등록이 되어있지 않을경우 -> C-M 콤보박스에서 첫번째값 선택
			$("#data_center_items option:eq(1)").prop("selected", true);
			$("#f_s").find("input[name='data_center']").val($("select[name='data_center_items']").val());
		}
		
		$("#btn_search").button().unbind("click").click(function(){
			setTimeout(function(){
				sendLogList();
			}, 1000);
		});

		$('#search_text').unbind('keypress').keypress(function(e){
			if(e.keyCode==13 && trim($(this).val())!=''){
				sendLogList();
			}
		});

		$("#p_s_send_date").val($("input[name='s_send_date']").val());
		$("#p_e_send_date").val($("input[name='e_send_date']").val());


		$("#s_send_date").addClass("text_input").unbind('click').click(function(){
			dpCalMin(this.id,'yymmdd');
		});

		$("#e_send_date").addClass("text_input").unbind('click').click(function(){
			dpCalMin(this.id,'yymmdd');
		});
		
		$("#btn_excel").button().unbind("click").click(function(){
			goExcel();
		});


	});

	function sendLogList(){

			$("#f_s").find("input[name='p_search_gubun']").val($("#frm1").find("select[name='search_gubun'] option:selected").val());
			$("#f_s").find("input[name='p_search_text']").val($("#frm1").find("input[name='search_text']").val());
			$("#f_s").find("input[name='p_send_gubun']").val($("#frm1").find("select[name='send_gubun'] option:selected").val());
			$("#f_s").find("input[name='p_s_send_date']").val($("#frm1").find("input[name='s_send_date']").val());
			$("#f_s").find("input[name='p_e_send_date']").val($("#frm1").find("input[name='e_send_date']").val());
			$("#f_s").find("input[name='p_send_description']").val($("#frm1").find("select[name='send_description'] option:selected").val());
			$("#f_s").find("input[name='p_data_center']").val($("#frm1").find("select[name='data_center_items'] option:selected").val());
			
			var data_center_items = $("select[name='data_center_items'] option:selected").val();
			
			if(data_center_items == ""){
				alert("C-M 을 선택해 주세요.");
				return;
			}
			
			if ( $("#s_send_date").val() != "" && $("#e_send_date").val() != "" ) {
				
				// 날짜 기간 체크
				if ( $("#s_send_date").val() > $("#e_send_date").val() ) {
					alert("일자의 FROM ~ TO를 확인해 주세요.");
					return;
				}
				
				// 날짜 정합성 체크
				if(!isValidDate($("#s_send_date").val()) || !isValidDate($("#e_send_date").val())){ 
					alert("잘못된 날짜입니다."); 
					return;
				}
			}

		try{viewProgBar(true);}catch(e){}
		$('#ly_total_cnt').html('');
		
		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=sendLogList';
		
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
						
						if(items.attr('cnt')=='0'){
						}else{
							items.find('item').each(function(i){						
								var data_center 		= $(this).find("DATA_CENTER").text();
								var data_center_name 	= $(this).find("DATA_CENTER_NAME").text();
								var send_cd 			= $(this).find("SEND_CD").text();
								var data_center 		= $(this).find("DATA_CENTER").text();
								var job_name 			= $(this).find("JOB_NAME").text();
								var order_id 			= $(this).find("ORDER_ID").text();
								var send_gubun_nm 		= $(this).find("SEND_GUBUN_NM").text();
								var message 			= $(this).find("MESSAGE").text();
								var user_nm 			= $(this).find("USER_NM").text();
								var send_date 			= $(this).find("SEND_DATE").text();
								var return_code 		= $(this).find("RETURN_CODE").text();
								var return_date 		= $(this).find("RETURN_DATE").text();
								var send_info 			= $(this).find("SEND_INFO").text();
								var jobschedgb 			= $(this).find("JOBSCHEDGB").text();
								var send_description	= $(this).find("SEND_DESCRIPTION").text();

								rowsObj.push({
									'grid_idx':i+1
									,'DATA_CENTER': data_center
									,'DATA_CENTER_NAME': data_center_name
									,'SEND_CD': send_cd
									,'DATA_CENTER': data_center
									,'JOB_NAME': job_name
									,'ORDER_ID': order_id
									,'SEND_GUBUN': send_gubun
									,'SEND_GUBUN_NM': send_gubun_nm
									,'SEND_DESCRIPTION': send_description
									,'MESSAGE': message
									,'USER_NM': user_nm
									,'SEND_DATE': send_date
									,'RETURN_CODE': return_code
									,'RETURN_DATE': return_date
									,'SEND_INFO': send_info
								});
								
							});						
						}
						
						gridObj.rows = rowsObj;
						setGridRows(gridObj);
						
						//컬럼 자동 조정 기능
						$('body').resizeAllColumns();
						$('#ly_total_cnt').html('[ TOTAL : '+items.attr('cnt')+' ]');
						
					});
					try{viewProgBar(false);}catch(e){}
				}
		, null );
		
		xhr.sendRequest();
	}
	
	function goExcel() {
		
		var frm = document.f_s;
		
		frm.action = "<%=sContextPath %>/tWorks.ez?c=ezSendLogList_excel";
		frm.target = "if1";
		frm.submit();
	}
	
</script>
