<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/jsp/common/inc/header.jsp"%>

<%
	Map<String, Object> paramMap = CommonUtil.collectParameters(request);
	String c = CommonUtil.isNull(paramMap.get("c"));
	String gridId = "g_"+c;
	
	String menu_gb = CommonUtil.getMessage("CATEGORY.GB.03.GB."+CommonUtil.isNull(paramMap.get("menu_gb")));
	String[] arr_menu_gb = menu_gb.split(",");
	
	String s_doc_gb 			= CommonUtil.isNull(paramMap.get("s_doc_gb"));
	String s_gb 				= CommonUtil.isNull(paramMap.get("s_gb"));
	String s_text 				= CommonUtil.isNull(paramMap.get("s_text"));

	// 목록 화면 검색 파라미터.
	String search_data_center 	= CommonUtil.isNull(paramMap.get("search_data_center"));
	String search_approval_cd 	= CommonUtil.isNull(paramMap.get("search_approval_cd"));
	String search_apply_cd 		= CommonUtil.isNull(paramMap.get("search_apply_cd"));
	String search_gb 			= CommonUtil.isNull(paramMap.get("search_gb"));
	String search_text 			= CommonUtil.isNull(paramMap.get("search_text"));
	String search_date_gubun 	= CommonUtil.isNull(paramMap.get("search_date_gubun"));
	String search_s_search_date = CommonUtil.isNull(paramMap.get("search_s_search_date"));
	String search_e_search_date = CommonUtil.isNull(paramMap.get("search_e_search_date"));
	String search_s_search_date2 = CommonUtil.isNull(paramMap.get("search_s_search_date2"));
	String search_e_search_date2 = CommonUtil.isNull(paramMap.get("search_e_search_date2"));
	String search_task_nm 		= CommonUtil.isNull(paramMap.get("search_task_nm"));
	String search_moneybatchjob	= CommonUtil.isNull(paramMap.get("search_moneybatchjob"));
	String search_critical		= CommonUtil.isNull(paramMap.get("search_critical"));
	String search_check_approval_yn	= CommonUtil.isNull(paramMap.get("search_check_approval_yn"));
	
	String strSearchStartDate 	= "";
	String strSearchEndDate 	= ""; 
	String item_gb				= CommonUtil.isNull(paramMap.get("itemGb"));
	
	/* if ( search_s_search_date.equals("") ) {
		strSearchStartDate 	= CommonUtil.getCurDateTo(CommonUtil.getCurDate(""), -8);
	} else {
		strSearchStartDate = search_s_search_date;
	}
	
	if ( search_e_search_date.equals("") ) {
		strSearchEndDate = CommonUtil.getCurDateTo(CommonUtil.getCurDate(""), 0);
	} else {
		strSearchEndDate = search_e_search_date;
	} */
	
	// 세션값 가져오기.
	String strSessionDcCode 	= S_D_C_CODE;
	
	//메인 -> 결재 대상 내역 목록에서 이 페이지를 불러왔을경우 전체일자 조회
	if(item_gb.equals("approvalList")){
		strSearchStartDate 	= "";
		strSearchEndDate 	= "";
	}
	
	//메인 -> 결재 진행 현황 목록에서 이 페이지를 불러왔을경우 C-M 초기화 후 전체 조회
	if(item_gb.equals("approvalList")){
		strSessionDcCode 	= "";
	}

	String aTmp[] = null;
	
	//스크롤 페이징
	String strPagingNum			= CommonUtil.getMessage("PAGING.NUM");
%>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/SlickGrid-2.1.0/plugins/slick.autocolumnsize.js" ></script>
<form id="f_s" name="f_s" method="post" onsubmit="return false;">
	<input type="hidden" name="p_s_gb" 				id="p_s_gb"/>
	<input type="hidden" name="p_s_text" 			id="p_s_text"/>
	<input type="hidden" name="p_state_cd" 			id="p_state_cd"/>
	<input type="hidden" name="p_s_apply_cd" 		id="p_s_apply_cd"/>
	<input type="hidden" name="p_s_approval_cd" 	id="p_s_approval_cd"/>
	<input type="hidden" name="p_date_gubun" 		id="p_date_gubun" 		value="02"/>
	<input type="hidden" name="p_s_search_date" 	id="p_s_search_date"/>
	<input type="hidden" name="p_e_search_date" 	id="p_e_search_date"/>
	<input type="hidden" name="p_s_doc_gb" 			id="p_s_doc_gb" 		value="${paramMap.doc_gb}"/>
	<input type="hidden" name="p_approval_cd" 		id="p_approval_cd" 		value="01"/>
	<input type="hidden" name="menu_gb" 			id="menu_gb" 			value="${paramMap.menu_gb}" />

	<input type="hidden" name="p_date_gubun2" 		id="p_date_gubun2"		value="03"/>
	<input type="hidden" name="p_s_search_date2" 	id="p_s_search_date2"/>
	<input type="hidden" name="p_e_search_date2" 	id="p_e_search_date2"/>

	<input type="hidden" name="state_cd" 			id="state_cd" />	
	<input type='hidden' name='data_center_code'	id='data_center_code' />
	<input type='hidden' name='data_center'			id='data_center' />
	<input type="hidden" name="p_task_nm" 			id="p_task_nm"/>
	
	<input type='hidden' id='p_moneybatchjob' 		name='p_moneybatchjob'/>
	<input type='hidden' id='p_critical' 			name='p_critical'/>
	<input type='hidden' id='p_check_approval_yn' 	name='p_check_approval_yn'/>
	
	<input type="hidden" name="startRowNum"				id="startRowNum" 			 	value="0" />
	<input type="hidden" name="pagingNum"				id="pagingNum" 			 		value="<%=strPagingNum%>" />
</form>

<form id="userFrm" name="userFrm" method="post" onsubmit="return false;"></form>

<table style='width:100%;height:100%;border:none;'>
	<tr style='height:10px;'>
		<td style='vertical-align:top;'>
			<h4 class="ui-widget-header ui-corner-all"  >
				<div id='t_<%=gridId %>' class='title_area' >
					<span><%=CommonUtil.isNull(CommonUtil.getMessage("CATEGORY.GB.03"))%> > <%=CommonUtil.isNull(arr_menu_gb[0]) %></span>
				</div>
			</h4>
		</td>
	</tr>
	<tr style='height:10px;'>
		<td style='vertical-align:top;'>
			<form name="frm1" id="frm1" method="post">   
							
			<input type="hidden" name="state_cd"  />
			<input type="hidden" name="approval_cd"  />
			<input type="hidden" name="doc_cd" />
			<input type="hidden" name="doc_gb" />			
			<input type="hidden" name="flag" />
			<input type="hidden" name="job_name" 		value="" />
			<input type="hidden" name="data_center" 	value="" />
			<input type="hidden" name="doc_group_id" 	value="" />
			<input type="hidden" name="task_type" 		value="" />
			<input type="hidden" name="job_gubun" 		value="" />
			<input type="hidden" name="s_doc_gb" 		value="<%=s_doc_gb %>" />
			
			<input type="hidden" name="check_doc_cd" />
			<input type="hidden" name="check_data_center" />
			<input type="hidden" name="check_approval_seq" />
			<input type="hidden" name="check_doc_cnt" />
			<input type="hidden" name="check_post_approval_yn" />

			<input type="hidden" name="approval_comment" />
			
			<h4 class="ui-widget-header ui-corner-all">
			<table style='width:100%;'>
			<tr>
				<th width="10%"><div class='cellTitle_kang2' style="min-width:120px">C-M</div></th> 
				<td width="35%" style="text-align:left; width:400px;">
					<div class='cellContent_kang' style="width:400px;">
					<select id="data_center_items" name="data_center_items" style="width:150px;height:21px;">
						<option value="">전체</option>
						<c:forEach var="cm" items="${cm}" varStatus="status">
							<option value="${cm.scode_cd},${cm.scode_eng_nm}">${cm.scode_nm}</option>
						</c:forEach>
					</select>
					</div>
				</td>
				<th width="10%"><div class='cellTitle_kang2' style="min-width:120px">결재방법</div></th>
				<td width="35%" style="text-align:left; width:600px;" colspan="3">
					<div class='cellContent_kang' style='width:600px;'>
						<input type='radio' name='check_approval_yn' id='check_approval_yn' value='' style='background:#f1f1f1;' checked/> 전체
						<input type='radio' name='check_approval_yn' id='check_approval_yn' value='Y' style='background:#f1f1f1;width:13px;' /> 후결
						<input type='radio' name='check_approval_yn' id='check_approval_yn' value='N' style='background:#f1f1f1;width:13px;' /> 순차
					</div>
				</td>
			</tr>
			<tr>
				<th><div class='cellTitle_kang2'>의뢰일자</div></th>
				<td style="text-align:left">
					<div class='cellContent_kang'> 
						<input type="text" name="s_search_date" id="s_search_date" value="<%=strSearchStartDate%>" class="input datepick" style="width:60px; height:21px;" maxlength="8" /> ~
						<input type="text" name="e_search_date" id="e_search_date" value="<%=strSearchEndDate%>" class="input datepick" style="width:60px; height:21px;" maxlength="8" />
						<img id="btn_clear3" src="/images/sta2.png" style="width:16px;height:16px;vertical-align:middle;cursor:pointer;"/>
					</div>
				</td>
				<th><div class='cellTitle_kang2'>작업구분</div></th>
				<td style="text-align:left">
					<div class='cellContent_kang'>
					<select id="task_nm" name="task_nm" style="width:120px;height:21px;">							
						<option value=''>전체</option>
							<%
								aTmp = CommonUtil.getMessage("DOC.GB").split(",");
								for(int i=0; i<aTmp.length; i++){
									String aTmp1[] = aTmp[i].split("[|]");
									out.print(" <option value='"+aTmp1[0]+"' >"+aTmp1[1]+"</option>");
								}
							%>
					</select>
					</div>
				</td>
			</tr>
			<tr>
				<th style="display:none;"><div class='cellTitle_kang2' >반영상태</div></th>
				<td style="text-align:left;display:none;">
					<div class='cellContent_kang' style='display:none;'>
						<%
							aTmp = CommonUtil.getMessage("APPLY.STATE").split(",");
							for(int i=0; i<aTmp.length; i++){
								String aTmp1[] = aTmp[i].split("[|]");
								out.print(" <input type='radio' name='s_apply_cd' id='s_apply_cd' value='"+aTmp1[0]+"' style='background:#f1f1f1' /> "+aTmp1[1]+" ");
							}
						%>
					</div>
				</td>
				<th><div class='cellTitle_kang2'>반영일자</div></th>
				<td style="text-align:left">
					<div class='cellContent_kang'>
						<input type="text" name="s_search_date2" id="s_search_date2" value="<%=search_s_search_date2%>" class="input datepick" style="width:60px; height:21px;" maxlength="8" /> ~
						<input type="text" name="e_search_date2" id="e_search_date2" value="<%=search_e_search_date2%>" class="input datepick" style="width:60px; height:21px;" maxlength="8" />
						<img id="btn_clear4" src="/images/sta2.png" style="width:16px;height:16px;vertical-align:middle;cursor:pointer;"/>
					</div>
				</td>
				<th width="10%"><div class='cellTitle_kang2' style="min-width:120px">검색구분</div></th>
				<td width="35%" style="text-align:left" colspan="3">
					<div class='cellContent_kang' style="width:400px;">
						<select id="s_gb" name="s_gb" style="width:120px;height:21px;">
							<option value='03'>작업명</option>
							<option value='05'>작업설명</option>
							<option value='01'>문서번호</option>
							<option value='04'>의뢰자</option>
							<option value='02'>의뢰사유</option>

						</select>
						<input type="text" name="s_text" value="" id="s_text" class="input" style="width:150px; height:21px;"/>
					</div>
				</td>
				<td colspan="2" style="text-align:right;">
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
			<h4 class="ui-widget-header ui-corner-all">
				<div align='right' class='btn_area'>
					<div id='ly_total_cnt' style='padding-top:5px;float:left;'></div>
					결재자 의견 : <input type="text" name="app_comment" id="app_comment" maxlength="100" style="width:150px;height:21px;">
					<span id="btn_group_approval" style="display:none;">일괄결재</span>
					<span id="btn_group_return" style="display:none;">일괄반려</span>
					<span id="btn_excel" style="display:none;">엑셀다운</span>
				</div>
			</h4>
		</td>
	</tr>
</table>
<script>

	var listChk = false;
	
	var menuGb = '<%=CommonUtil.isNull(paramMap.get("menu_gb"))%>';
	function gridCellCustomFormatter(row,cell,value,columnDef,dataContext){
		
		var ret 			= "";
		var doc_cd 			= getCellValue(gridObj,row,'DOC_CD');
		var task_nm 		= getCellValue(gridObj,row,'TASK_NM');
		var state_cd 		= getCellValue(gridObj,row,'STATE_CD');
		var job_name 		= getCellValue(gridObj,row,'JOB_NAME');
		var doc_group_id 	= getCellValue(gridObj,row,'DOC_GROUP_ID');
		var data_center 	= getCellValue(gridObj,row,'DATA_CENTER');
		var doc_gb 			= getCellValue(gridObj,row,'DOC_GB');
		var doc_cnt			= getCellValue(gridObj,row,'DOC_CNT');
		
		if (columnDef.id == 'TITLE' || columnDef.id == 'JOB_NAME') {
			ret = "<a href=\"JavaScript:goInfoList('"+doc_cd+"','"+doc_gb+"','"+job_name+"','"+data_center+"','"+task_nm+"','"+state_cd+"','"+doc_cnt+"','"+doc_group_id+"');\" /><font color='red'>"+value+"</font></a>";
		}
		
		if(columnDef.id == 'USER_INFO'){
			ret = "<a href=\"JavaScript:docUserInfo('"+doc_cd+"');\" /><font color='blue'>"+value+"</font></a>";
		}
		
		return ret;
	}
	
	function checkAll() {
		
		var chk 	= document.getElementsByName("check_idx");
		var chk_all = document.getElementById("checkIdxAll");
		var cnt = 0;		

		if (cnt==0) {
			for(i = 0; i < chk.length; i++) {
				if(chk_all.checked) {				
					chk.item(i).checked ="checked";
				}else {
					chk.item(i).checked = "";					
				}
			}
			cnt++;
		}else {
			for(i = 0; i < chk.length; i++) chk.item(i).checked ="";
			cnt=0;
		}
	}
		
	var gridObj = {
		id : "<%=gridId %>"
		,colModel:[
			{formatter:gridCellNoneFormatter,field:'check_idx',id:'check_idx',name:'<input type="checkbox" name="checkIdxAll" id="checkIdxAll" onClick="checkAll();">',width:30,minWidth:30,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:false}
	   		,{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'번호',width:50,minWidth:50,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'DOC_CD',id:'DOC_CD',name:'문서번호',width:120,minWidth:120,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'DATA_CENTER_NAME',id:'DATA_CENTER_NAME',name:'C-M',width:80,minWidth:80,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'TASK_NM',id:'TASK_NM',name:'작업구분',width:100,minWidth:100,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
			,{formatter:gridCellCustomFormatter,field:'TITLE',id:'TITLE',name:'의뢰사유',width:300,minWidth:300,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
			,{formatter:gridCellCustomFormatter,field:'JOB_NAME',id:'JOB_NAME',name:'작업명',width:200,minWidth:200,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'DESCRIPTION',id:'DESCRIPTION',name:'작업설명',width:250,minWidth:250,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'APPLY_NM',id:'APPLY_NM',name:'반영상태',width:80,minWidth:80,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
			,{formatter:gridCellNoneFormatter,field:'S_APPLY_DATE',id:'S_APPLY_DATE',name:'반영일자',width:80,minWidth:80,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
			,{formatter:gridCellNoneFormatter,field:'APPROVAL_GB',id:'APPROVAL_GB',name:'결재방법',width:80,minWidth:80,headerCssClass:'cellCenter',cssClass:'cellCenter'}
			,{formatter:gridCellNoneFormatter,field:'DRAFT_DATE',id:'DRAFT_DATE',name:'의뢰일자',width:130,minWidth:130,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	   		,{formatter:gridCellCustomFormatter,field:'USER_INFO',id:'USER_INFO',name:'의뢰자',width:180,minWidth:180,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}

// 			,{formatter:gridCellNoneFormatter,field:'APPLY_NM',id:'APPLY_NM',name:'반영상태',width:80,minWidth:80,headerCssClass:'cellHid',cssClass:'cellHid',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'DATA_CENTER',id:'DATA_CENTER',name:'C-M',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   		,{formatter:gridCellNoneFormatter,field:'STATE_CD',id:'STATE_CD',name:'STATE_CD',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   		,{formatter:gridCellNoneFormatter,field:'DEPT_CD',id:'DEPT_CD',name:'DEPT_CD',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   		,{formatter:gridCellNoneFormatter,field:'DUTY_CD',id:'DUTY_CD',name:'DUTY_CD',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   		,{formatter:gridCellNoneFormatter,field:'USER_CD',id:'USER_CD',name:'USER_CD',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   		,{formatter:gridCellNoneFormatter,field:'APPROVAL_SEQ',id:'APPROVAL_SEQ',name:'APPROVAL_SEQ',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
			,{formatter:gridCellNoneFormatter,field:'POST_APPROVAL_YN',id:'POST_APPROVAL_YN',name:'POST_APPROVAL_YN',width:0,headerCssClass:'cellHid',cssClass:'cellHid'}
			,{formatter:gridCellNoneFormatter,field:'DOC_CNT',id:'DOC_CNT',name:'DOC_CNT',width:0,headerCssClass:'cellHid',cssClass:'cellHid'}
			,{formatter:gridCellNoneFormatter,field:'DOC_GROUP_ID',id:'DOC_GROUP_ID',name:'DOC_GROUP_ID',width:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   	]
		,rows:[]
		,vscroll:false
	};
	
	$(document).ready(function(){
		
		var session_dc_code	= "<%=strSessionDcCode%>";

		$("#btn_search").show();

		$("select[name='date_gubun']").val("02");
		
		var data_center_items = $("select[name='data_center_items'] option:selected").val();

		// 검색 조건 파라미터 셋팅.
		var search_data_center 		= "<%=search_data_center%>";
		var search_approval_cd 		= "<%=search_approval_cd%>";
		var search_apply_cd 		= "<%=search_apply_cd%>";
		var search_gb 				= "<%=search_gb%>";
		var search_text 			= "<%=search_text%>";
		var search_date_gubun 		= "<%=search_date_gubun%>";
		var search_s_search_date 	= "<%=search_s_search_date%>";
		var search_e_search_date 	= "<%=search_e_search_date%>";
		var search_s_search_date2 	= "<%=search_s_search_date2%>";
		var search_e_search_date2 	= "<%=search_e_search_date2%>";
		var search_task_nm 			= "<%=search_task_nm%>";
		var search_check_approval_yn = "<%=search_check_approval_yn%>";
		
		if ( search_data_center != "" ) {
			$("#data_center_items").val(search_data_center).prop("selected", true);
		}
		if ( search_s_search_date != "" ) {
			$("#s_search_date").val(search_s_search_date);
		}
		if ( search_e_search_date != "" ) {
			$("#e_search_date").val(search_e_search_date);
		}
		if ( search_approval_cd != "" ) {
			$("input:radio[name='s_approval_cd'][value='"+search_approval_cd+"']").prop("checked", true);
		} else {
			$("input:radio[name='s_approval_cd'][value='01']").prop("checked", true);
		}

		if ( search_apply_cd != "" ) {
			$("input:radio[name='s_apply_cd'][value='"+search_apply_cd+"']").prop("checked", true);
		}
		
		if ( search_gb != "" ) {
			$("#s_gb").val(search_gb).prop("selected", true);
		}
		
		if ( search_text != "" ) {
			$("#s_text").val(search_text);
		}
		
		if ( search_date_gubun != "" ) {
			$("#date_gubun").val(search_date_gubun).prop("selected", true);
		}
		
		if ( search_task_nm != "" ) {
			$("#task_nm").val(search_task_nm).prop("selected", true);
		}

		if ( search_check_approval_yn != "" ) {
			$("input:radio[name='check_approval_yn'][value='"+search_check_approval_yn+"']").prop("checked", true);
		}
		
		if ( search_data_center == "" ) {
			$("select[name='data_center_items']").val(session_dc_code);
			$("#f_s").find("input[name='data_center']").val(session_dc_code);
		} else {
			$("select[name='data_center_items']").val(search_data_center);
			$("#f_s").find("input[name='data_center']").val(search_data_center);
		}
		
		$("#p_s_approval_cd").val("01");
		$("#p_s_gb").val($("select[name='s_gb'] option:selected").val());
		$("#p_s_apply_cd").val($("input:radio[name='s_apply_cd']:checked").val());
		$("#p_s_text").val($("input[name='s_text']").val());
		$("#p_s_search_date").val($("input[name='s_search_date']").val());
		$("#p_e_search_date").val($("input[name='e_search_date']").val());	

		$("#p_s_search_date2").val($("input[name='s_search_date2']").val());
		$("#p_e_search_date2").val($("input[name='e_search_date2']").val());

		$("#p_task_nm").val($("select[name='task_nm'] option:selected").val());
		$("#p_check_approval_yn").val($("input:radio[name='check_approval_yn']:checked").val());

		if(session_dc_code != "") { // 개인정보에 C-M이 등록되어 있을경우
			$("select[name='data_center_items']").val(session_dc_code);
			$("#f_s").find("input[name='data_center']").val(session_dc_code);
		}else { // 개인정보에 C-M이 등록이 되어있지 않을경우 -> C-M 콤보박스에서 첫번째값 선택
			// 결재문서함은 전체 조회가 가능하기 때문에 첫번째 값 선택 로직 제거 (2023.07.10 강명준)
			//$("#data_center_items option:eq(1)").prop("selected", true);
			//$("#f_s").find("input[name='data_center']").val($("select[name='data_center_items']").val());
		}

		viewGrid_1(gridObj,"ly_"+gridObj.id,{enableColumnReorder:true},'AUTO');

		//if($("select[name='data_center_items'] option:selected").val()!=''){
		setTimeout(function(){
			approvalDocInfoList();
		}, 500);
		//}

		setTimeout(function(){	
			var row_msg = $("#ly_total_cnt").text();
			
			if(row_msg != "[ TOTAL : 0 ]"){
				$("#btn_group_approval").show();
				$("#btn_group_return").show();
				$("#btn_excel").show();				
			}else{
				$("#btn_group_approval").hide();
				$("#btn_group_return").hide();
				$("#btn_excel").hide();
			}
		}, 500);
		
		$("#btn_search").button().unbind("click").click(function(){

			approvalDocInfoList();
			
			setTimeout(function(){
				var row_msg = $("#ly_total_cnt").text();
				
				if(row_msg != "[ TOTAL : 0 ]"){
					$("#btn_group_approval").show();
					$("#btn_group_return").show();
					$("#btn_excel").show();
				}else{
					$("#btn_group_approval").hide();
					$("#btn_group_return").hide();
					$("#btn_excel").hide();
				}
			}, 500);
		});
		
		$('#s_text').unbind('keypress').keypress(function(e){			
			if(e.keyCode==13){	
				$("#btn_search").trigger("click");
			}
		});

		$("#btn_group_approval").button().unbind("click").click(function(){
			goPrc('approval');
		});
		
		$("#btn_group_return").button().unbind("click").click(function(){
			goPrc('return');
		});
		
		$("#btn_excel").button().unbind("click").click(function(){
			goExcel();
		});
		
		$("#s_search_date").addClass("text_input").unbind('click').click(function(){
			dpCalMin(this.id,'yymmdd');
		});
		
		$("#e_search_date").addClass("text_input").unbind('click').click(function(){
			dpCalMin(this.id,'yymmdd');
		});

		$("#s_search_date2").addClass("text_input").unbind('click').click(function(){
			dpCalMin(this.id,'yymmdd')
		});

		$("#e_search_date2").addClass("text_input").unbind('click').click(function(){
			dpCalMin(this.id,'yymmdd');
		});

		//의뢰일자 초기화버튼
		$("#btn_clear3").unbind("click").click(function(){
			$("#p_s_search_date").val("");
			$("#s_search_date").val("");
			$("#p_e_search_date").val("");
			$("#e_search_date").val("");
		});

		//반영일자 초기화 버튼
		$("#btn_clear4").unbind("click").click(function(){
			$("#p_s_search_date2").val("");
			$("#p_e_search_date2").val("");
			$("#s_search_date2").val("");
			$("#e_search_date2").val("");
		});

		$("#data_center_items").change(function(){		//C-M
			
			var data_center_items = $(this).val();
			if($(this).val() != ""){
				$("#f_s").find("input[name='data_center']").val(data_center_items);
			}else{
				$("#f_s").find("input[name='data_center']").val("");
			}
			
		});
		
		//스크롤 페이징
		var grid = $('#'+gridObj.id).data('grid');
		grid.onScroll.subscribe(function(e, args){
			var elem = $("#g_ez005").children(".slick-viewport");
			if ( elem[0].scrollHeight - elem.scrollTop() - elem.css("height").replace("px", "") + 17 < 100) {
				if(listChk) {
					listChk = false;
					var startRowNum = parseInt($("#startRowNum").val());
					startRowNum += parseInt($('#pagingNum').val());
					approvalDocInfoList(startRowNum);
				}
			}
		});
	});
		
	function approvalDocInfoList(startRowNum){

		var data_center_items = $("select[name='data_center_items'] option:selected").val();
		var s_apply_cd = $("input:radio[name='s_apply_cd']:checked").val();
		var check_approval_yn = $("input:radio[name='check_approval_yn']:checked").val();
		$("#p_approval_cd").val("01");
		$("#p_s_approval_cd").val("01");
		$("#p_s_apply_cd").val(s_apply_cd);
		$("#p_check_approval_yn").val(check_approval_yn);
		$("#p_s_search_date").val($("input[name='s_search_date']").val());
		$("#p_e_search_date").val($("input[name='e_search_date']").val());

		$("#p_s_search_date2").val($("input[name='s_search_date2']").val());
		$("#p_e_search_date2").val($("input[name='e_search_date2']").val());
		$("#p_date_gubun2").val($("select[name='date_gubun2'] option:selected").val());

		$("#p_task_nm").val($("select[name='task_nm'] option:selected").val());
		$("#p_s_gb").val($("select[name='s_gb'] option:selected").val());
		$("#p_s_text").val($("input[name='s_text']").val());

		if ( $("#p_s_search_date").val() != "" && $("#p_e_search_date").val() != "" ) {
			$("#p_date_gubun").val("02");
			// 날짜 기간 체크
			if ( $("#p_s_search_date").val() > $("#p_e_search_date").val() ) {
				alert("의뢰일자의 FROM ~ TO를 확인해 주세요.");
				return;
			}

			if(!isValidDate($("#p_s_search_date").val()) || !isValidDate($("#p_e_search_date").val())){
				alert("잘못된 날짜입니다.");
				return;
			}
		}

		if ( $("#p_s_search_date2").val() != "" && $("#p_e_search_date2").val() != "" ) {
			$("#p_date_gubun2").val("03");
			// 날짜 기간 체크
			if ( $("#p_s_search_date2").val() > $("#p_e_search_date2").val() ) {
				alert("반영일자의 FROM ~ TO를 확인해 주세요.");
				return;
			}

			if(!isValidDate($("#p_s_search_date2").val()) || !isValidDate($("#p_e_search_date2").val())){
				alert("잘못된 날짜입니다.");
				return;
			}
		}
		
		//페이징 처리
		if(startRowNum != '' && startRowNum != null && startRowNum != undefined) {
			$('#startRowNum').val(startRowNum);
		} else {
			var elem = $("#g_ez005").children(".slick-viewport");
			elem.scrollTop(0);
			startRowNum = 0;
			$('#startRowNum').val(0);
		}

		try{viewProgBar(true);}catch(e){}
		$('#ly_total_cnt').html('');
		
		var search_approval_cd = "<%=search_approval_cd%>";
		
		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=approvalDocInfoList&itemGubun=2';

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
						
						if(startRowNum != '' && startRowNum != null && startRowNum != undefined) {
							rowsObj = gridObj.rows;
						}
						
						if(items.attr('cnt')=='0'){
						}else{
							items.find('item').each(function(i){						
							
								var task_nm				= $(this).find("TASK_NM").text();
								var task_type 			= $(this).find("TASK_TYPE").text();

								var main_doc_cd 		= $(this).find("MAIN_DOC_CD").text();
								var doc_cd 				= $(this).find("DOC_CD").text();
								var doc_gb 				= $(this).find("DOC_GB").text();
								var title 				= $(this).find("TITLE").text();
								var job_name 			= $(this).find("JOB_NAME").text();
								var desc 				= $(this).find("DESCRIPTION").text();

								var s_apply_date 		= $(this).find("S_APPLY_DATE").text();
								var state_cd 			= $(this).find("STATE_CD").text();
								var state_nm 			= $(this).find("STATE_NM").text();
								var draft_date 			= $(this).find("DRAFT_DATE").text();

								var dept_nm 			= $(this).find("DEPT_NM").text();
								var dept_cd 			= $(this).find("DEPT_CD").text();
								var duty_nm 			= $(this).find("DUTY_NM").text();
								var duty_cd 			= $(this).find("DUTY_CD").text();
								var user_nm 			= $(this).find("USER_NM").text();
								var user_cd 			= $(this).find("USER_CD").text();

								var data_center 		= $(this).find("DATA_CENTER").text();
								var data_center_name 	= $(this).find("DATA_CENTER_NAME").text();

								var approval_date 		= $(this).find("APPROVAL_DATE").text();
								var approval_cd 		= $(this).find("APPROVAL_CD").text();

								var approval_seq 		= $(this).find("APPROVAL_SEQ").text();
								var apply_nm 			= $(this).find("APPLY_NM").text();
								var apply_cd 			= $(this).find("APPLY_CD").text();
								var odate 				= $(this).find("ODATE").text();

								var post_approval_yn	= $(this).find("POST_APPROVAL_YN").text();
								var detail_status		= $(this).find("DETAIL_STATUS").text();
								var alarm_user			= $(this).find("ALARM_USER").text();
								var r_cnt 				= $(this).find("R_CNT").text();
								var w_cnt 				= $(this).find("W_CNT").text();
								var e_cnt 				= $(this).find("E_CNT").text();
								var apply_fail_cnt		= $(this).find("APPLY_FAIL_COUNT").text();

								var doc_cnt				= $(this).find("DOC_CNT").text();
								var doc_group_id		= $(this).find("DOC_GROUP_ID").text();

								if ( odate != "" ) {
									odate = odate.substring(0, 4) + "/" + odate.substring(4, 6) + "/" + odate.substring(6, 8);
								}
								
								if ( s_apply_date != "" ) {
									s_apply_date = s_apply_date.substring(0, 4) + "/" + s_apply_date.substring(4, 6) + "/" + s_apply_date.substring(6, 8);
								}
								
								var user_info = "";
								user_info = "["+dept_nm+"] "+"["+duty_nm+"] "+"["+user_nm+"]"										

								
								var v_post_approval = "";
								if(post_approval_yn == "N") {
									v_post_approval = "순차";
								}else if(post_approval_yn == "Y"){
									v_post_approval = "후결";
								}else if(post_approval_yn == "A"){
									v_post_approval = "즉시결재";
								}else{
									v_post_approval = "";
								}

								if(post_approval_yn == ""){
									post_approval_yn = "N";
								}

								var v_check_idx = ""; 
								//if ( state_cd == "01" ) {
								
								// 검색 조건이 미결인 상태만 일괄 체크 박스 존재 
								if ( $("#p_s_approval_cd").val() == "01" ) {
									v_check_idx = 	"<div class='gridInput_area'><input type='checkbox' name='check_idx' value='"+doc_cd+"' ></div>";
									v_check_idx	+= 	"<input type='hidden' name='check_data_center_idx' value='"+data_center+"' >";
									v_check_idx	+= 	"<input type='hidden' name='check_approval_seq_idx' value='"+approval_seq+"' >";
									v_check_idx	+= 	"<input type='hidden' name='check_doc_cnt_idx' value='"+doc_cnt+"' >";
									v_check_idx	+= 	"<input type='hidden' name='check_post_approval_yn_idx' value='"+post_approval_yn+"' >";
									v_check_idx	+= 	"<input type='hidden' name='check_apply_cd_idx' value='"+apply_cd+"' >";
								}

								if(state_nm == "완결") {
									detail_status = "결재완료";
								}else if(state_nm == "저장"){ 
									detail_status = "";
								}else{
									if(detail_status == ""){
										detail_status = " 결재대기 (" + alarm_user + ")";
									}else {
										detail_status =  " 결재대기 (" + detail_status + ")";
									}
								}

								if(e_cnt != "0" || w_cnt != "0" || r_cnt != "0" ){
									apply_nm = "<font color='red'>"+apply_nm+"</font>";
								}

								if(apply_fail_cnt != "0"){
									apply_nm = "<font color='red'>"+apply_nm+"</font>";
								}

								rowsObj.push({
									'check_idx':v_check_idx
									,'grid_idx':i+1+startRowNum
									,'TASK_TYPE': task_type
									,'TASK_NM': task_nm
									,'MAIN_DOC_CD': main_doc_cd
									,'DOC_CD': doc_cd
									,'DOC_GB': doc_gb
									,'TITLE': title
									,'JOB_NAME': job_name
									,'DESCRIPTION': desc
									,'S_APPLY_DATE': s_apply_date
									,'STATE_CD': state_cd
									,'STATE_NM': state_nm
									,'DRAFT_DATE': draft_date
									,'DEPT_NM': dept_nm
									,'DEPT_CD' : dept_cd
									,'DUTY_NM' : duty_nm
									,'DUTY_CD' : duty_cd
									,'USER_CD' : user_cd
									,'USER_NM' : user_nm
									,'APPROVAL_DATE' : approval_date
									,'APPROVAL_SEQ' : approval_seq
									,'DATA_CENTER' : data_center
									,'DATA_CENTER_NAME' : data_center_name
									,'USER_INFO' : user_info
									,'APPLY_NM': apply_nm
									,'APPROVAL_GB' : v_post_approval
									,'POST_APPROVAL_YN' : post_approval_yn
									,'DETAIL_STATUS' : detail_status
									,'DOC_CNT' : doc_cnt
									,'DOC_GROUP_ID' : doc_group_id
								});
								
							});						
						}
						
						gridObj.rows = rowsObj;
						setGridRows(gridObj);
						
						//컬럼 자동 조정 기능
						$('body').resizeAllColumns();
						
						$('#ly_total_cnt').html('[ TOTAL : '+parseInt(gridObj.rows.length)+'/'+items.attr('total')+']');
						if( parseInt(gridObj.rows.length) != items.attr('total') ) {
							listChk = true;
						}else{
							listChk = false;
						}
						
					});
					try{viewProgBar(false);}catch(e){}
				}
		, null );
		
		xhr.sendRequest();
	}
	  
	function goExcel() {
		
		var frm = document.f_s;
		
		frm.action = "<%=sContextPath %>/tWorks.ez?c=ez005_excel";
		frm.target = "if1";
		frm.submit();
	}
	
	function goInfoList(doc_cd, doc_gb, job_name, data_center, task_nm, state_cd, doc_cnt, doc_group_id){

		//var cd 				= "99999";
		var cd 				= doc_cd;
		var tabId 			= 'tabs-'+cd;
		
		var menu_gb			= "<%=CommonUtil.isNull(paramMap.get("menu_gb"))%>";
		var menu_tabId		= 'tabs-'+menu_gb;

		//var doc_name 		= "<%=CommonUtil.getMessage("CATEGORY.GB.03.SB.0300") %>";
		var doc_name 		= "";
		
		doc_name = task_nm + " 상세";
		
		var data_center_items = $("select[name='data_center_items'] option:selected").val();
		var check_approval_yn = $("input:radio[name='check_approval_yn']:checked").val();

		$("#p_s_approval_cd").val("01");
		$("#p_s_gb").val($("select[name='s_gb'] option:selected").val());
		$("#p_s_text").val($("input[name='s_text']").val());
		$("#p_s_search_date").val($("input[name='s_search_date']").val());
		$("#p_e_search_date").val($("input[name='e_search_date']").val());			
		$("#p_date_gubun").val($("select[name='date_gubun'] option:selected").val());
		$("#p_task_nm").val($("select[name='task_nm'] option:selected").val());
		$("#p_critical").val($("select[name='critical'] option:selected").val());
		$("#p_check_approval_yn").val(check_approval_yn);

		
		var search_data_center 		= $("#data_center").val();
		var search_approval_cd 		= $("#p_s_approval_cd").val();
		var search_gb 				= $("#p_s_gb").val();
		var search_text 			= $("#p_s_text").val();
		var search_date_gubun 		= $("#p_date_gubun").val();
		var search_s_search_date 	= $("#p_s_search_date").val();
		var search_e_search_date 	= $("#p_e_search_date").val();
		var search_task_nm	 		= $("#p_task_nm").val();
		var search_critical	 		= $("#p_critical").val();
		var search_check_approval_yn = $("#p_check_approval_yn").val();
		
		var search_param = "&search_data_center="+search_data_center+"&search_approval_cd="+search_approval_cd+
						   "&search_gb="+search_gb+"&search_text="+encodeURI(search_text)+"&search_date_gubun="+search_date_gubun+
						   "&search_s_search_date="+search_s_search_date+"&search_e_search_date="+search_e_search_date+
						   "&search_task_nm="+search_task_nm+"&search_critical="+search_critical+"&tabId="+menu_gb+'&search_check_approval_yn='+search_check_approval_yn;
		
		top.addTab('c', doc_name, doc_cd, cd, 'tWorks.ez?c=ez006&doc_gb='+doc_gb+'&doc_cd='+doc_cd+'&data_center='+data_center+'&state_cd='+state_cd+'&doc_cnt='+doc_cnt+'&doc_group_id='+doc_group_id+'&job_name='+encodeURI(job_name)+search_param);
		
		//top.closeTab(menu_tabId);
	}
	
	function goPrc(flag) {
		
		var frm = document.frm1;
		
		var check_idx 	= document.getElementsByName("check_idx");
		var approval_cd = "";
		
		var doc_cd 					= "";
		var check_doc_cd 			= "";
		var check_cnt				= 0;
		
		var check_data_center_idx	= document.getElementsByName("check_data_center_idx");
		var data_center				= "";
		var check_data_center 		= "";
		
		var check_approval_seq_idx	= document.getElementsByName("check_approval_seq_idx");
		var approval_seq			= "";
		var check_approval_seq 		= "";

		var check_post_approval_yn_idx	= document.getElementsByName("check_post_approval_yn_idx");
		var post_approval_yn			= "";
		var check_post_approval_yn 		= "";
		
		var check_doc_cnt_idx			= document.getElementsByName("check_doc_cnt_idx");
		var doc_cnt						= "";
		var check_doc_cnt 				= "";

		var ckeck_apply_cd_idx			= document.getElementsByName("check_apply_cd_idx");
		var apply_cd					= "";

		for ( var i = 0; i < check_idx.length; i++ ) {
			if(check_idx.item(i).checked) {
				
				doc_cd 				= check_idx.item(i).value;
				check_doc_cd 		= check_doc_cd + "|" + doc_cd;
				
				data_center			= check_data_center_idx.item(i).value;
				check_data_center	= check_data_center + "|" + data_center;
				
				approval_seq		= check_approval_seq_idx.item(i).value;
				check_approval_seq	= check_approval_seq + "|" + approval_seq;
				
				doc_cnt				= check_doc_cnt_idx.item(i).value;
				check_doc_cnt		= check_doc_cnt + "|" + doc_cnt;

				post_approval_yn		= check_post_approval_yn_idx.item(i).value;
				check_post_approval_yn	= check_post_approval_yn + "|" + post_approval_yn;
				
				apply_cd			= ckeck_apply_cd_idx.item(i).value; 
				
				if ( flag == "return" ){
					if(apply_cd == '02') {
						alert("반영완료 건은 반려가 불가합니다.");
						return;
					}
				}
				check_cnt++;
			}
		}
		
		if ( check_cnt == 0 ) {
			alert("작업을 선택해 주세요.");
			return;
		}
		
		check_doc_cd 		= check_doc_cd.substring(1, check_doc_cd.length);
		check_data_center 	= check_data_center.substring(1, check_data_center.length);
		check_approval_seq 	= check_approval_seq.substring(1, check_approval_seq.length);
		check_doc_cnt 		= check_doc_cnt.substring(1, check_doc_cnt.length);
		check_post_approval_yn = check_post_approval_yn.substring(1, check_post_approval_yn.length);

		if ( flag == "approval" ) {
			if( !confirm(check_cnt + " 건을 일괄결재 하시겠습니까?") ) return;
			approval_cd = "02";
			
			var app_comment = $("#app_comment").val();
			frm.approval_comment.value = app_comment;
			
		} else if ( flag == "return" ) {
			
			var app_comment = $("#app_comment").val();
			frm.approval_comment.value = app_comment;
			
			// 반려일 경우 결재자 의견 필수
			if ( app_comment == "" ) {
				alert("반려는 결재자 의견이 필수입니다.");
				$("#app_comment").focus();
				return;
			}
			
			if( !confirm(check_cnt + " 건을 일괄반려 하시겠습니까?") ) return;
			approval_cd = "04";
		}
		
		$("#app_comment").val("");
		frm.check_doc_cd.value 			= check_doc_cd;
		frm.check_data_center.value 	= check_data_center;
		frm.check_approval_seq.value 	= check_approval_seq;
		frm.check_doc_cnt.value 		= check_doc_cnt;
		frm.check_post_approval_yn.value = check_post_approval_yn;
		frm.approval_cd.value 			= approval_cd;
		frm.flag.value 					= flag;

		try{viewProgBar(true);}catch(e){}

		frm.target = "if1";
		//frm.action = "<%=sContextPath%>/tWorks.ez?c=ez016";
		frm.action = "<%=sContextPath%>/tWorks.ez?c=groupApproval";
		frm.submit();		
	}
</script>
