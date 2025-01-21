<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/jsp/common/inc/header.jsp"%>

<%
	Map<String, Object> paramMap = CommonUtil.collectParameters(request);
	String c = CommonUtil.isNull(paramMap.get("c"));
	String gridId = "g_"+c;
	
	String menu_gb = CommonUtil.getMessage("CATEGORY.GB.03.GB."+CommonUtil.isNull(paramMap.get("menu_gb")));
	String[] arr_menu_gb = menu_gb.split(",");

	List adminApprovalBtnList		= (List)request.getAttribute("adminApprovalBtnList");
	String strAdminApprovalBtn		= "";

	if ( adminApprovalBtnList != null ) {
		for ( int i = 0; i < adminApprovalBtnList.size(); i++ ) {
			CommonBean commonBean = (CommonBean) adminApprovalBtnList.get(i);
			strAdminApprovalBtn = CommonUtil.isNull(commonBean.getScode_nm());
		}
	}

	String s_doc_gb 		= CommonUtil.isNull(paramMap.get("s_doc_gb"));
	String s_gb 			= CommonUtil.isNull(paramMap.get("s_gb"));
	String s_text 			= CommonUtil.isNull(paramMap.get("s_text"));


	// 목록 화면 검색 파라미터.
	String search_data_center 	= CommonUtil.isNull(paramMap.get("search_data_center"));
	String search_state_cd 		= CommonUtil.isNull(paramMap.get("search_state_cd"));
	String search_apply_cd 		= CommonUtil.isNull(paramMap.get("search_apply_cd"));
	String search_gb 			= CommonUtil.isNull(paramMap.get("search_gb"));
	String search_text 			= CommonUtil.isNull(paramMap.get("search_text"));
	String search_date_gubun 	= CommonUtil.isNull(paramMap.get("search_date_gubun"));
	String search_s_search_date = CommonUtil.isNull(paramMap.get("search_s_search_date"));
	String search_e_search_date = CommonUtil.isNull(paramMap.get("search_e_search_date"));
	String search_s_search_date2 = CommonUtil.isNull(paramMap.get("search_s_search_date2"));
	String search_e_search_date2 = CommonUtil.isNull(paramMap.get("search_e_search_date2"));
	String search_task_nm 		= CommonUtil.isNull(paramMap.get("search_task_nm"));
	String search_approval_state = CommonUtil.isNull(paramMap.get("search_approval_state"));
	String search_check_approval_yn	= CommonUtil.isNull(paramMap.get("search_check_approval_yn"));

	String strFromDate			= CommonUtil.isNull(paramMap.get("from_date"));
	String strToDate			= CommonUtil.isNull(paramMap.get("to_date"));

	String strSearchStartDate 	= "";
	String strSearchEndDate 	= ""; 
	
	String item_gb 				= CommonUtil.isNull(paramMap.get("itemGb"));
	
	if ( search_s_search_date.equals("") ) {
			strSearchStartDate 	= CommonUtil.getCurDateTo(CommonUtil.getCurDate(""), -6);
	} else {
		strSearchStartDate = search_s_search_date;
	}
	
	if ( search_e_search_date.equals("") ) {	
		strSearchEndDate = CommonUtil.getCurDateTo(CommonUtil.getCurDate(""), 0);
	} else {
		strSearchEndDate = search_e_search_date;
	}
	
	// 세션값 가져오기.
	String strSessionUserCd 	= S_USER_CD;
	String strSessionDcCode 	= S_D_C_CODE;
	
	//메인 -> 반영 대기 내역 목록에서 이 페이지를 불러왔을경우 전체일자 조회
	if(item_gb.equals("execList") || item_gb.equals("approvalStateInfo")){
		strSearchStartDate 	= "";
		strSearchEndDate	= "";
	}
	
	//메인 -> 결재 진행 현황 목록에서 이 페이지를 불러왔을경우 C-M 초기화 후 전체 조회
	if(item_gb.equals("myDocList")){
		strSessionDcCode 	= "";
	}
	
	String aTmp[] = null;

	//스크롤 페이징
	String strPagingNum			= CommonUtil.getMessage("PAGING.NUM");

%>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/SlickGrid-2.1.0/plugins/slick.autocolumnsize.js" ></script>
<form id="f_s" name="f_s" method="post" onsubmit="return false;">
	<input type="hidden" name="p_s_gb" 					id="p_s_gb"/>
	<input type="hidden" name="p_s_text" 				id="p_s_text"/>
	<input type="hidden" name="p_s_state_cd" 			id="p_s_state_cd"/>
	<input type="hidden" name="p_s_apply_cd" 			id="p_s_apply_cd"/>
	<input type="hidden" name="p_date_gubun" 			id="p_date_gubun"		value="02"/>
	<input type="hidden" name="p_s_search_date" 		id="p_s_search_date"/>
	<input type="hidden" name="p_e_search_date" 		id="p_e_search_date"/>

	<input type="hidden" name="p_date_gubun2" 			id="p_date_gubun2"		value="03"/>
	<input type="hidden" name="p_s_search_date2" 		id="p_s_search_date2"/>
	<input type="hidden" name="p_e_search_date2" 		id="p_e_search_date2"/>

	<input type="hidden" name="p_task_nm" 				id="p_task_nm"/>
	<input type="hidden" name="p_susitype" 				id="p_susitype"/>
	<input type='hidden' name='data_center_code' 		id='data_center_code' />
	<input type='hidden' name='data_center'				id='data_center' />

	<input type="hidden" name="p_s_doc_gb" 				id="p_s_doc_gb" 				value="${paramMap.doc_gb}" />
	<input type="hidden" name="menu_gb" 				id="menu_gb" 					value="${paramMap.menu_gb}" />

	<input type="hidden" name="p_check_approval_yn" 	id="p_check_approval_yn"/>
	<input type="hidden" name="p_approval_state" 		id="p_approval_state"/>

	<input type="hidden" name="startRowNum"				id="startRowNum" 			 	value="0" />
	<input type="hidden" name="pagingNum"				id="pagingNum" 			 		value="<%=strPagingNum%>" />
</form>

<form id="userFrm" name="userFrm" method="post" onsubmit="return false;"></form>

<table style='width:100%;height:100%;border:none;'>
	<tr style='height:10px;'>
		<td style='vertical-align:top;'>
			<h4 class="ui-widget-header ui-corner-all"  >
				<div id='t_<%=gridId %>' class='title_area'>
					<span><%=CommonUtil.isNull(CommonUtil.getMessage("CATEGORY.GB.03"))%> > <%=CommonUtil.isNull(arr_menu_gb[0]) %></span>
				</div>
			</h4>
		</td>
	</tr>
	<tr style='height:10px;'>
		<td style='vertical-align:top;'>
			<form name="frm2" id="frm2" method="post">
				<input type='hidden' 	name='data_center'				id='data_center'/>

				<input type="hidden" 	name="flag" 					id="flag" />
				<input type="hidden" 	name="doc_cd" 					id="doc_cd" />
				<input type="hidden" 	name="table_name" 				id="table_name" />
				<input type="hidden" 	name="application" 				id="application" />
				<input type="hidden" 	name="group_name" 				id="group_name" />
				<input type="hidden" 	name="job_name" 				id="job_name" />
				<input type="hidden" 	name="grp_doc_gb" 				id="grp_doc_gb" 			value="01"/>
				<input type="hidden" 	name="doc_gb" 					id="doc_gb"/>
				<input type="hidden" 	name="post_approval_yn" 		id="post_approval_yn"/>
				<input type="hidden" 	name="title"  					id="title" />
				<input type="hidden" 	name="p_apply_date"  			id="p_apply_date" />

				<!-- 그룹결재구성원 결재권/알림수신여부	 -->
				<input type="hidden" 	name="grp_approval_userList"  id="grp_approval_userList" />
				<input type="hidden" 	name="grp_alarm_userList"  	  id="grp_alarm_userList" />

				<input type="hidden" 	name="approval_cd"  />
				<input type="hidden" 	name="doc_cnt"				  id="doc_cnt"	  			value="0" />
				<input type="hidden" 	name="group_yn"				  id="group_yn"	  			value="Y" />
			</form>
			<form name="frm1" id="frm1" method="post">
					
			<input type="hidden" name="state_cd"  />
			<input type="hidden" name="flag"  />
			
			<input type="hidden" name="doc_cd" />
			<input type="hidden" name="doc_gb" />
			
			<input type="hidden" name="s_doc_gb" 		value="<%=s_doc_gb %>" />
			
			<input type="hidden" name="job_name" 		value="" />
			<input type="hidden" name="data_center" 	value="" />
			<input type="hidden" name="doc_group_id" 	value="" />
			<input type="hidden" name="task_type" 		value="" />
			<input type="hidden" name="job_gubun" 		value="" />

			<h4 class="ui-widget-header ui-corner-all">
			<table style='width:100%;'>

				<tr>
					<th width="10%"><div class='cellTitle_kang2' style='min-width:120px;'>C-M</div></th>
					<td width="15%" style="text-align:left; width:380px;">
						<div class='cellContent_kang' style='width:400px'>
						<select id="data_center_items" name="data_center_items" style="width:145px;height:21px;">
							<option value="">전체</option>
							<c:forEach var="cm" items="${cm}" varStatus="status">
								<option value="${cm.scode_cd},${cm.scode_eng_nm}">${cm.scode_nm}</option>
							</c:forEach>
						</select>
						</div>
					</td>
					<th width="10%"><div class='cellTitle_kang2' style='min-width:120px;'>결재방법</div></th>
					<td width="30%" style="text-align:left; width:250px;">
						<div class='cellContent_kang' style='width:250px;'>
							<input type='radio' name='check_approval_yn' id='check_approval_yn' value='' style='background:#f1f1f1' checked/> 전체
							<input type='radio' name='check_approval_yn' id='check_approval_yn' value='Y' style='background:#f1f1f1' /> 후결
							<input type='radio' name='check_approval_yn' id='check_approval_yn' value='N' style='background:#f1f1f1' /> 순차
							<input type='radio' name='check_approval_yn' id='check_approval_yn' value='A' style='background:#f1f1f1' /> 즉시결재
						</div>
					</td>
					<th width="10%"><div class='cellTitle_kang2' style='min-width:120px;'>반영상태</div></th>
					<td width="30%" style="text-align:left; width:250px;">
						<div class='cellContent_kang' style='width:300px;'>
							<%
								aTmp = CommonUtil.getMessage("APPLY.STATE").split(",");
								for(int i=0; i<aTmp.length; i++){
									String aTmp1[] = aTmp[i].split("[|]");
									out.print(" <input type='radio' name='s_apply_cd' id='s_apply_cd' value='"+aTmp1[0]+"' style='background:#f1f1f1' /> "+aTmp1[1]+" ");
								}
							%>
						</div>
					</td>
					<td width='5%'></td>
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
					<th><div class='cellTitle_kang2' style='min-width:120px;'>결재상태</div></th>
					<td style="text-align:left; width:400px;">
						<div class='cellContent_kang' style='width:300px;'>
							<%
								aTmp = CommonUtil.getMessage("DOC.STATE").split(",");
								for(int i=0; i<aTmp.length; i++){
									String aTmp1[] = aTmp[i].split("[|]");
									out.print(" <input type='radio' name='s_state_cd' id='s_state_cd' value='"+aTmp1[0]+"' style='background:#f1f1f1' /> "+aTmp1[1]+" ");
								}
							%>
						</div>
					</td>
					<th><div class='cellTitle_kang2' style='min-width:120px;'>작업구분</div></th>
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
					<th><div class='cellTitle_kang2'>반영일자</div></th>
					<td style="text-align:left">
						<div class='cellContent_kang'>
							<input type="text" name="s_search_date2" id="s_search_date2" value="<%=search_s_search_date2%>" class="input datepick" style="width:60px; height:21px;" maxlength="8" onClick="fn_clear(this.id);" /> ~
							<input type="text" name="e_search_date2" id="e_search_date2" value="<%=search_e_search_date2%>" class="input datepick" style="width:60px; height:21px;" maxlength="8" onClick="fn_clear(this.id);" />
							<img id="btn_clear4" src="/images/sta2.png" style="width:16px;height:16px;vertical-align:middle;cursor:pointer;"/>
						</div>
					</td>
					<th><div class='cellTitle_kang2'>결재상세상태</div></th>
					<td width="35%" style="text-align:left; width:250px;">
						<div class='cellContent_kang' style='width:250px;'>
							<input type='radio' name='approval_state' id='approval_state' value='' style='background:#f1f1f1' checked/> 전체
							<input type='radio' name='approval_state' id='approval_state' value='02' style='background:#f1f1f1;width:13px;' /> 결재완료
							<input type='radio' name='approval_state' id='approval_state' value='01' style='background:#f1f1f1;width:13px;' /> 결재대기
						</div>
					</td>
					<th><div class='cellTitle_kang2'>검색구분</div></th>
					<td style="text-align:left;">
						<div class='cellContent_kang'>
							<select id="s_gb" name="s_gb" style="width:120px;height:21px;">
								<option value='06'>작업명</option>
								<option value='05'>작업설명</option>
								<option value='01'>문서번호</option>
								<option value='04'>의뢰자</option>
								<option value='02'>의뢰사유</option>

							</select>
							<input type="text" name="s_text" value="" id="s_text" class="input" style="width:150px; height:21px;"/>
						</div>
					</td>
					<td style="text-align:right;">
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
					<span id="btn_draft" >일괄승인요청</span>
					<span id="btn_draft_admin" >일괄관리자즉시결재</span>
					<%--<span id="btn_exec_cancel" >일괄요청서 해제</span>--%>
					<span id="btn_excel" style="display:none;">엑셀다운</span>
				</div>
			</h4>
		</td>
	</tr>
</table>
<script>

	var listChk = false;

	function gridCellCustomFormatter(row,cell,value,columnDef,dataContext){
		
		var ret = "";
		var doc_cd 			= getCellValue(gridObj,row,'DOC_CD');
		var doc_gb			= getCellValue(gridObj,row,'DOC_GB');
		var task_type 		= getCellValue(gridObj,row,'TASK_TYPE');
		var doc_group_id 	= getCellValue(gridObj,row,'DOC_GROUP_ID');
		var state_cd 		= getCellValue(gridObj,row,'STATE_CD');
		var job_name 		= getCellValue(gridObj,row,'JOB_NAME');
		var data_center 	= getCellValue(gridObj,row,'DATA_CENTER');
		var doc_gb_org 		= getCellValue(gridObj,row,'DOC_GB_ORG');
		var application 	= getCellValue(gridObj,row,'APPLICATION');
		var table_id 		= getCellValue(gridObj,row,'TABLE_ID');
		var job_id 			= getCellValue(gridObj,row,'JOB_ID');
		var sched_table 	= getCellValue(gridObj,row,'SCHED_TABLE');
		var user_cd 		= getCellValue(gridObj,row,'USER_CD');
		var apply_fail_cnt	= getCellValue(gridObj,row,'APPLY_FAIL_CNT');
		
		if (columnDef.id == 'TITLE' || columnDef.id == 'JOB_NAME') {
			//ret = "<a href=\"JavaScript:goPage('"+doc_cd+"', '"+doc_gb+"');\" /><font color='red'>"+value+"</font></a>";
			ret = "<a href=\"JavaScript:goPage('"+doc_cd+"', '"+doc_gb+"', '"+apply_fail_cnt+"');\" /><font color='red'>"+value+"</font></a>";
		}
		
		if(columnDef.id == 'USER_NM'){
			ret = "<a href=\"JavaScript:docUserInfo('"+doc_cd+"');\" /><font color='blue'>"+value+"</font></a>";
		}
		
		return ret;
	}
	function checkAll() {
		
		var chk 		= document.getElementsByName("check_idx");
		var chk_all 	= document.getElementById("checkIdxAll");
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
			{formatter:gridCellNoneFormatter,field:'check_idx',id:'check_idx',name:'<input type="checkbox" name="checkIdxAll" id="checkIdxAll" onClick="checkAll();">',width:30,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:false}
			,{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'번호',minWidth:50,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'DOC_CD',id:'DOC_CD',name:'문서번호',minWidth:120,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'DATA_CENTER_NAME',id:'DATA_CENTER_NAME',name:'C-M',minWidth:80,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'TASK_NM',id:'TASK_NM',name:'작업구분',minWidth:100,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	   		,{formatter:gridCellCustomFormatter,field:'TITLE',id:'TITLE',name:'의뢰사유',minWidth:300,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
	   		,{formatter:gridCellCustomFormatter,field:'JOB_NAME',id:'JOB_NAME',name:'작업명',minWidth:200,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'DESCRIPTION',id:'DESCRIPTION',name:'작업설명',minWidth:200,maxWidth:450,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
			,{formatter:gridCellNoneFormatter,field:'APPLY_EXE_DATE',id:'APPLY_EXE_DATE',name:'반영예정일',minWidth:100,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
			,{formatter:gridCellNoneFormatter,field:'APPLY_NM',id:'APPLY_NM',name:'반영상태',minWidth:80,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'S_APPLY_DATE',id:'S_APPLY_DATE',name:'반영일',minWidth:80,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
			,{formatter:gridCellNoneFormatter,field:'POST_APPROVAL_YN',id:'POST_APPROVAL_YN',name:'결재방법',minWidth:80,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
			,{formatter:gridCellNoneFormatter,field:'STATE_NM',id:'STATE_NM',name:'결재상태',minWidth:80,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
			,{formatter:gridCellNoneFormatter,field:'DETAIL_STATUS',id:'DETAIL_STATUS',name:'결재상세상태',minWidth:200,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'APPROVAL_USER_NM',id:'APPROVAL_USER_NM',name:'결재자',minWidth:80,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'APPROVAL_DATE',id:'APPROVAL_DATE',name:'결재일자',minWidth:130,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'REJECT_USER_NM',id:'REJECT_USER_NM',name:'반려자',minWidth:100,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'REJECT_COMMENT',id:'REJECT_COMMENT',name:'반려사유',minWidth:100,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'REJECT_DATE',id:'REJECT_DATE',name:'반려일자',minWidth:130,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	   		,{formatter:gridCellCustomFormatter,field:'USER_NM',id:'USER_NM',name:'의뢰자',minWidth:100,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'DEPT_NM',id:'DEPT_NM',name:'부서',minWidth:100,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'DRAFT_DATE',id:'DRAFT_DATE',name:'의뢰일자',minWidth:130,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'INS_DATE',id:'INS_DATE',name:'등록일자',minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   			   		
	   		,{formatter:gridCellNoneFormatter,field:'DATA_CENTER',id:'DATA_CENTER',name:'C-M',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   		,{formatter:gridCellNoneFormatter,field:'STATE_CD',id:'STATE_CD',name:'STATE_CD',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   		,{formatter:gridCellNoneFormatter,field:'DEPT_CD',id:'DEPT_CD',name:'DEPT_CD',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   		,{formatter:gridCellNoneFormatter,field:'DUTY_CD',id:'DUTY_CD',name:'DUTY_CD',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   		,{formatter:gridCellNoneFormatter,field:'USER_CD',id:'USER_CD',name:'USER_CD',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   		,{formatter:gridCellNoneFormatter,field:'TASK_TYPE',id:'TASK_TYPE',name:'TASK_TYPE',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   		,{formatter:gridCellNoneFormatter,field:'DOC_GB',id:'DOC_GB',name:'DOC_GB',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   		,{formatter:gridCellNoneFormatter,field:'TABLE_ID',id:'TABLE_ID',name:'TABLE_ID',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   		,{formatter:gridCellNoneFormatter,field:'JOB_ID',id:'JOB_ID',name:'JOB_ID',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   		,{formatter:gridCellNoneFormatter,field:'APPLICATION',id:'APPLICATION',name:'APPLICATION',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   		,{formatter:gridCellNoneFormatter,field:'SCHED_TABLE',id:'SCHED_TABLE',name:'SCHED_TABLE',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
			,{formatter:gridCellNoneFormatter,field:'DOC_CNT',id:'DOC_CNT',name:'DOC_CNT',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
			,{formatter:gridCellNoneFormatter,field:'MAIN_DOC_CD',id:'MAIN_DOC_CD',name:'MAIN_DOC_CD',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
			,{formatter:gridCellNoneFormatter,field:'ORI_DOC_GB',id:'ORI_DOC_GB',name:'ORI_DOC_GB',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}

	   	]
		,rows:[]
		,vscroll:false
	};
	
	$(document).ready(function(){

		var session_dc_code		= "<%=strSessionDcCode%>";
		var from_odate			= "<%=strFromDate%>";
		var to_odate			= "<%=strToDate%>";
		var user_gb				= "<%=S_USER_GB%>";
		var session_user_gb		= "<%=S_USER_GB%>";
		var adminApprovalBtn 	= "<%=strAdminApprovalBtn%>";

		if (session_user_gb == "99"  || adminApprovalBtn == "Y") {
			$("#btn_draft_admin").show();
		} else {
			$("#btn_draft_admin").hide();
		}


		$("#btn_search").show();

		$("#date_gubun").val("02");			//등록일자 select
		
		document.getElementsByName('s_state_cd')[0].checked=true;
		document.getElementsByName('s_apply_cd')[0].checked=true;

		// 검색 조건 파라미터 셋팅.
		var search_data_center 		= "<%=search_data_center%>";
		var search_state_cd 		= "<%=search_state_cd%>";
		var search_apply_cd 		= "<%=search_apply_cd%>";
		var search_gb 				= "<%=search_gb%>";
		var search_text 			= "<%=search_text%>";
		var search_date_gubun 		= "<%=search_date_gubun%>";
		var search_s_search_date 	= "<%=search_s_search_date%>";
		var search_e_search_date 	= "<%=search_e_search_date%>";
		var search_s_search_date2 	= "<%=search_s_search_date2%>";
		var search_e_search_date2 	= "<%=search_e_search_date2%>";
		var search_task_nm 			= "<%=search_task_nm%>";
		var search_approval_state 	= "<%=search_approval_state%>";
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
		if ( search_state_cd != "" ) {
			$("input:radio[name='s_state_cd'][value='"+search_state_cd+"']").prop("checked", true);
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
		
		if(search_gb != "" && search_text != ""){
			$("#s_search_date").val('');
			$("#e_search_date").val('');
		}
		
		if ( search_date_gubun != "" ) {
			//$("#date_gubun").val(search_date_gubun).prop("selected", true);
			$("#date_gubun").val("02");
		}
		
		if ( search_task_nm != "" ) {
			$("#task_nm").val(search_task_nm).prop("selected", true);
		}

		if ( search_approval_state != "" ) {
			$("input:radio[name='approval_state'][value='"+search_approval_state+"']").prop("checked", true);
		}

		if ( search_check_approval_yn != "" ) {
			$("input:radio[name='check_approval_yn'][value='"+search_check_approval_yn+"']").prop("checked", true);
		}
		
		$("#p_s_state_cd").val($("input:radio[name='s_state_cd']:checked").val());
		$("#p_s_apply_cd").val($("input:radio[name='s_apply_cd']:checked").val());
		$("#p_s_gb").val($("select[name='s_gb'] option:selected").val());
		$("#p_s_text").val($("input[name='s_text']").val());
		$("#p_s_search_date").val($("input[name='s_search_date']").val());
		$("#p_e_search_date").val($("input[name='e_search_date']").val());
		
		//$("#p_date_gubun").val($("select[name='date_gubun'] option:selected").val());
		$("#p_date_gubun").val("02");
		
		$("#p_s_search_date2").val($("input[name='s_search_date2']").val());
		$("#p_e_search_date2").val($("input[name='e_search_date2']").val());
		
		//$("#p_date_gubun2").val($("select[name='date_gubun2'] option:selected").val());
		$("#p_date_gubun2").val("03");
		
		$("#p_task_nm").val($("select[name='task_nm'] option:selected").val());

		$("#p_check_approval_yn").val($("input:radio[name='check_approval_yn']:checked").val());
		$("#p_approval_state").val($("input:radio[name='approval_state']:checked").val());

		//메인화면의 오류 현황 ODATE 적용
		if(to_odate != '' && from_odate != '') {
			$("#p_s_search_date").val($("input[name='s_search_date']").val(from_odate));
			$("#p_e_search_date").val($("input[name='e_search_date']").val(to_odate));
		}
		
		if(session_dc_code != "") { // 개인정보에 C-M이 등록되어 있을경우
			$("select[name='data_center_items']").val(session_dc_code);
			$("#f_s").find("input[name='data_center']").val(session_dc_code);
			setTimeout(function(){
				myDocInfoList();
			}, 500);
		}else { // 개인정보에 C-M이 등록이 되어있지 않을경우 -> C-M 콤보박스에서 첫번째값 선택
			// 요청문서함은 전체 조회가 가능하기 때문에 첫번째 값 선택 로직 제거 (2023.07.10 강명준)
			//$("#data_center_items option:eq(1)").prop("selected", true);
			//$("#f_s").find("input[name='data_center']").val($("select[name='data_center_items']").val());
			setTimeout(function(){
				myDocInfoList();
			}, 500);
		}

		viewGrid_1(gridObj,"ly_"+gridObj.id,{enableColumnReorder:true},'AUTO');
		
		// 자동 검색 제거

		<c:if test="${paramMap.doc_gb ne '06'}">
		</c:if>
		setTimeout(function(){	
			var row_msg = $("#ly_total_cnt").text();
			
			if(row_msg != "[ TOTAL : 0 ]"){
				$("#btn_excel").show();
			}else{
				$("#btn_excel").hide();
			}
		}, 500);
		
		$("#btn_search").button().unbind("click").click(function(){

			var data_center_items = $("select[name='data_center_items'] option:selected").val();

			var s_state_cd = $("input:radio[name='s_state_cd']:checked").val();
			var s_apply_cd = $("input:radio[name='s_apply_cd']:checked").val();
			var check_approval_yn = $("input:radio[name='check_approval_yn']:checked").val();

			$("#p_s_state_cd").val(s_state_cd);
			$("#p_s_apply_cd").val(s_apply_cd);
			$("#p_check_approval_yn").val(check_approval_yn);
			$("#p_approval_state").val($("input:radio[name='approval_state']:checked").val());
			$("#p_s_gb").val($("select[name='s_gb'] option:selected").val());
			$("#p_s_text").val($("input[name='s_text']").val());
			$("#p_s_search_date").val($("input[name='s_search_date']").val());
			$("#p_e_search_date").val($("input[name='e_search_date']").val());
			
			//$("#p_date_gubun").val($("select[name='date_gubun'] option:selected").val());
			$("#p_date_gubun").val("02");
			
			$("#p_s_search_date2").val($("input[name='s_search_date2']").val());
			$("#p_e_search_date2").val($("input[name='e_search_date2']").val());
			
			//$("#p_date_gubun2").val($("select[name='date_gubun2'] option:selected").val());
			$("#p_date_gubun2").val("03");
			
			$("#p_task_nm").val($("select[name='task_nm'] option:selected").val());
			
			if ( $("#p_s_search_date").val() != "" && $("#p_e_search_date").val() != "" ) {
				
				// 날짜 기간 체크
				if ( $("#p_s_search_date").val() > $("#p_e_search_date").val() ) {
					alert("일자의 FROM ~ TO를 확인해 주세요.");
					return;
				}

				if(!isValidDate($("#p_s_search_date").val()) || !isValidDate($("#p_e_search_date").val())){ 
					alert("잘못된 날짜입니다."); 
					return;
				}
			}
			
			if ( $("#p_s_search_date2").val() != "" && $("#p_e_search_date2").val() != "" ) {
				
				// 날짜 기간 체크
				if ( $("#p_s_search_date2").val() > $("#p_e_search_date2").val() ) {
					alert("일자2의 FROM ~ TO를 확인해 주세요.");
					return;
				}
				
				if(!isValidDate($("#p_s_search_date2").val()) || !isValidDate($("#p_e_search_date2").val())){ 
					alert("잘못된 날짜입니다."); 
					return;
				}
			}
			
			/* if(data_center_items == ""){
				alert("C-M 을 선택해 주세요.");
				return;
			} */
			
			var menu_gb = "<%=CommonUtil.isNull(paramMap.get("menu_gb"))%>";
			
			// 수시 작업 검색 중 작업명, 작업설명은 작업 구분(수시, 재작업, 상태변경)을 선택 후 진행
			if ( menu_gb == "0302" ) {
				if ( $("#p_s_text").val() != "" && ($("#p_s_gb").val() == "05" || $("#p_s_gb").val() == "06") ) {
					if ( $("#p_task_nm").val() == "" ) {
						alert("작업명, 작업설명을 검색할 경우 작업구분을 필수 선택해 주세요.");
						return;
					}
				}
			}
			
			myDocInfoList();
			
			setTimeout(function(){	
				var row_msg = $("#ly_total_cnt").text();
				
				if(row_msg != "[ TOTAL : 0 ]"){
					$("#btn_excel").show();
				}else{
					$("#btn_excel").hide();
				}
			}, 500);
		});
		
		$("#data_center_items").change(function(){		//C-M
			
			var data_center_items = $(this).val();
			//var arr_dt = data_center_items.split(",");
			if($(this).val() != ""){
				//$("#f_s").find("input[name='data_center']").val(arr_dt[1]);
				$("#f_s").find("input[name='data_center']").val(data_center_items);
				
				//getAppGrpCodeList(arr_dt[0], "1", "", "application_of_def","");	
			}else{
				$("#f_s").find("input[name='data_center']").val("");
			}
			
		});
		
		$('#s_text').unbind('keypress').keypress(function(e){			
			if(e.keyCode==13){
				$("#btn_search").trigger("click");
			}
		});
		
		$("#btn_excel").button().unbind("click").click(function(){
			goExcel();
		});

		//승인요청
		$("#btn_draft").button().unbind("click").click(function(){
			valid_chk('draft');
		});
		//관리자즉시결재
		$("#btn_draft_admin").button().unbind("click").click(function(){
			valid_chk('draft_admin');
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

		//스크롤 페이징
		var grid = $('#'+gridObj.id).data('grid');
		grid.onScroll.subscribe(function(e, args){
			var elem = $("#g_ez004").children(".slick-viewport");
			if ( elem[0].scrollHeight - elem.scrollTop() - elem.css("height").replace("px", "") + 17 < 100) {
				if(listChk) {
					listChk = false;
					var startRowNum = parseInt($("#startRowNum").val());
					startRowNum += parseInt($('#pagingNum').val());
					myDocInfoList(startRowNum);
				}
			}
		});
	});
	
	function goPage(sel_doc_cd, sel_doc_gb, apply_fail_cnt) {
		
		var cnt 		= 0;
		var table_id 	= "";
		var job_id 		= "";
		var job_name 	= "";
		var author 		= "";
		var task_type 	= "";
		var doc_cd 		= "";
		var doc_gb 		= "";
		var state_cd	= "";
		var apply_cd	= "";
		var data_center	= "";
		var doc_group_id = "";
		var main_doc_cd	= "";
		var doc_cnt		= "";
		var task_nm 	= "";
		var ori_doc_gb	= "";
		var user_cd 	= "";

		var aSelRow = new Array;
		aSelRow = $('#'+gridObj.id).data('grid').getSelectedRows();
		if(aSelRow.length>0){
			for(var i=0;i<aSelRow.length;i++){
				
				table_id 	= getCellValue(gridObj,aSelRow[i],'TABLE_ID');
				job_id 		= getCellValue(gridObj,aSelRow[i],'JOB_ID');
				job_name 	= getCellValue(gridObj,aSelRow[i],'JOB_NAME');
				author 		= getCellValue(gridObj,aSelRow[i],'AUTHOR');
				task_type 	= getCellValue(gridObj,aSelRow[i],'TASK_TYPE');
				doc_cd 		= getCellValue(gridObj,aSelRow[i],'DOC_CD');
				doc_gb 		= getCellValue(gridObj,aSelRow[i],'DOC_GB');
				state_cd	= getCellValue(gridObj,aSelRow[i],'STATE_CD');
				apply_cd	= getCellValue(gridObj,aSelRow[i],'APPLY_CD');
				data_center = getCellValue(gridObj,aSelRow[i],'DATA_CENTER');
				doc_group_id = getCellValue(gridObj,aSelRow[i],'DOC_GROUP_ID');
				task_nm 	= getCellValue(gridObj,aSelRow[i],'TASK_NM');
				doc_cnt   	= getCellValue(gridObj,aSelRow[i],'DOC_CNT');
				main_doc_cd = getCellValue(gridObj,aSelRow[i],'MAIN_DOC_CD');
				ori_doc_gb 	= getCellValue(gridObj,aSelRow[i],'ORI_DOC_GB');
				user_cd		= getCellValue(gridObj,aSelRow[i],'USER_CD');

				++cnt;
			}

			if(cnt > 1){
				alert("한개의 항목만 선택해 주세요.");
				return;
			}
		}else{
			alert("내역을 선택해 주세요.");
			return;
		}
		
		job_id 		= job_id == 0 ? "" : job_id;
		table_id 	= table_id = 0 ? "" : table_id;
		
		//var cd 				= "99999";
		var cd				= sel_doc_cd;
		var tabId 			= 'tabs-'+cd;
		
		var menu_gb			= "<%=CommonUtil.isNull(paramMap.get("menu_gb"))%>";
		var menu_tabId		= 'tabs-'+menu_gb;
		
		var session_user_cd = "<%=strSessionUserCd%>";
		//var doc_name 		= "<%=CommonUtil.getMessage("CATEGORY.GB.03.SB.0300") %>";
		var doc_name 		= task_nm + "_상세";
		
		$("#p_s_state_cd").val($("input:radio[name='s_state_cd']:checked").val());
		$("#p_s_apply_cd").val($("input:radio[name='s_apply_cd']:checked").val());
		$("#p_check_approval_yn").val($("input:radio[name='check_approval_yn']:checked").val());
		$("#p_approval_state").val($("input:radio[name='approval_state']:checked").val());
		$("#p_s_gb").val($("select[name='s_gb'] option:selected").val());
		$("#p_s_text").val($("input[name='s_text']").val());
		$("#p_s_search_date").val($("input[name='s_search_date']").val());
		$("#p_e_search_date").val($("input[name='e_search_date']").val());
		
		//$("#p_date_gubun").val($("select[name='date_gubun'] option:selected").val());
		$("#p_date_gubun").val("02");
		
		$("#p_s_search_date2").val($("input[name='s_search_date2']").val());
		$("#p_e_search_date2").val($("input[name='e_search_date2']").val());
		
		//$("#p_date_gubun2").val($("select[name='date_gubun2'] option:selected").val());
		$("#p_date_gubun2").val("03");
		
		$("#p_task_nm").val($("select[name='task_nm'] option:selected").val());
		
		var search_data_center 		= $("#data_center").val();
		var search_state_cd 		= $("#p_s_state_cd").val();
		var search_apply_cd 		= $("#p_s_apply_cd").val();
		var search_gb 				= $("#p_s_gb").val();
		var search_text 			= $("#p_s_text").val();
		var search_date_gubun 		= $("#p_date_gubun").val();
		var search_s_search_date 	= $("#p_s_search_date").val();
		var search_e_search_date 	= $("#p_e_search_date").val();
		var search_s_search_date2 	= $("#p_s_search_date2").val();
		var search_e_search_date2 	= $("#p_e_search_date2").val();
		var search_task_nm	 		= $("#p_task_nm").val();

		var search_approval_state 	= $("#p_approval_state").val();
		var search_check_approval_yn = $("#p_check_approval_yn").val();

		var search_param = "&search_data_center="+search_data_center+"&search_state_cd="+search_state_cd+"&search_apply_cd="+search_apply_cd+
						   "&search_gb="+search_gb+"&search_text="+encodeURI(search_text)+"&search_date_gubun="+search_date_gubun+
						   "&search_s_search_date="+search_s_search_date+"&search_e_search_date="+search_e_search_date+
						   "&search_s_search_date2="+search_s_search_date2+"&search_e_search_date2="+search_e_search_date2+
						   "&search_task_nm="+search_task_nm+"&tabId="+menu_gb+
		                   "&search_approval_state="+search_approval_state+"+&search_check_approval_yn="+search_check_approval_yn+"&doc_cnt="+doc_cnt+"&ori_doc_gb="+ori_doc_gb;

		top.closeTab("tabs-"+doc_cd);
		
// 		console.log("user_cd : " + user_cd);
// 		console.log("session_user_cd : " + session_user_cd);

		if ( state_cd == '00' && user_cd == session_user_cd && doc_gb != '06' && doc_gb != '09') {
			top.addTab('c', doc_name, doc_cd, cd, 'tWorks.ez?c=ez004_m&doc_gb='+doc_gb+'&doc_cd='+doc_cd+'&data_center='+data_center+'&state_cd='+state_cd+'&apply_cd='+apply_cd+'&task_type='+task_type+'&doc_group_id='+doc_group_id+'&main_doc_cd='+main_doc_cd+search_param+'&job_name='+encodeURI(job_name));
		} else {
			top.addTab('c', doc_name, doc_cd, cd, 'tWorks.ez?c=ez006&doc_gb='+doc_gb+'&doc_cd='+doc_cd+'&apply_fail_cnt='+apply_fail_cnt+'&data_center='+data_center+'&state_cd='+state_cd+'&apply_cd='+apply_cd+'&task_type='+task_type+'&doc_group_id='+doc_group_id+'&main_doc_cd='+main_doc_cd+search_param+'&job_name='+encodeURI(job_name));
		}
		
		//top.closeTab(menu_tabId);
	}
	
	function myDocInfoList(startRowNum){

		$("#p_s_state_cd").val($("input:radio[name='s_state_cd']:checked").val());
		$("#p_s_apply_cd").val($("input:radio[name='s_apply_cd']:checked").val());
		$("#p_check_approval_yn").val($("input:radio[name='check_approval_yn']:checked").val());
		$("#p_approval_state").val($("input:radio[name='approval_state']:checked").val());
		$("#p_s_gb").val($("select[name='s_gb'] option:selected").val());
		$("#p_s_text").val($("input[name='s_text']").val());
		$("#p_s_search_date").val($("input[name='s_search_date']").val());
		$("#p_e_search_date").val($("input[name='e_search_date']").val());
		
		//$("#p_date_gubun").val($("select[name='date_gubun'] option:selected").val());
		$("#p_date_gubun").val("02");
		
		$("#p_s_search_date2").val($("input[name='s_search_date2']").val());
		$("#p_e_search_date2").val($("input[name='e_search_date2']").val());
		
		//$("#p_date_gubun2").val($("select[name='date_gubun2'] option:selected").val());
		$("#p_date_gubun2").val("03");
		
		$("#p_task_nm").val($("select[name='task_nm'] option:selected").val());
		
		//페이징 처리
		if(startRowNum != '' && startRowNum != null && startRowNum != undefined) {
			$('#startRowNum').val(startRowNum);
		} else {
			var elem = $("#g_ez004").children(".slick-viewport");
			elem.scrollTop(0);
			startRowNum = 0;
			$('#startRowNum').val(0);
		}

		try{viewProgBar(true);}catch(e){}
		$('#ly_total_cnt').html('');
		
		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=myDocInfoList';
		
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

								var doc_group_id 		= $(this).find("DOC_GROUP_ID").text();
								var task_nm		 		= $(this).find("TASK_NM").text();
								var task_nm_detail 		= $(this).find("TASK_NM_DETAIL").text();

								var main_doc_cd 		= $(this).find("MAIN_DOC_CD").text();
								var doc_cd 				= $(this).find("DOC_CD").text();
								var doc_gb 				= $(this).find("DOC_GB").text();
								var title 				= $(this).find("TITLE").text();
								var job_name 			= $(this).find("JOB_NAME").text();
								var desc 				= $(this).find("DESCRIPTION").text();

								var state_cd 			= $(this).find("STATE_CD").text();
								var state_nm 			= $(this).find("STATE_NM").text();
								var draft_date 			= $(this).find("DRAFT_DATE").text();
								var ins_date 			= $(this).find("INS_DATE").text();
								var s_apply_date		= $(this).find("S_APPLY_DATE").text();

								var dept_nm 			= $(this).find("DEPT_NM").text();
								var dept_cd 			= $(this).find("DEPT_CD").text();
								var duty_nm 			= $(this).find("DUTY_NM").text();
								var duty_cd 			= $(this).find("DUTY_CD").text();
								var user_nm 			= $(this).find("USER_NM").text();
								var user_cd 			= $(this).find("USER_CD").text();

								var data_center 		= $(this).find("DATA_CENTER").text();
								var data_center_name 	= $(this).find("DATA_CENTER_NAME").text();
								var job_id 				= $(this).find("JOB_ID").text();
								var table_id 			= $(this).find("TABLE_ID").text();
								
								var s_cnt 				= $(this).find("S_CNT").text();
								var r_cnt 				= $(this).find("R_CNT").text();
								var w_cnt 				= $(this).find("W_CNT").text();
								var e_cnt 				= $(this).find("E_CNT").text();
								var total_cnt 			= $(this).find("TOTAL_CNT").text();
								var fail_cnt 			= $(this).find("FAIL_CNT").text();
								
								var apply_fail_cnt		= $(this).find("APPLY_FAIL_COUNT").text();
								var application 		= $(this).find("APPLICATION").text();
								var sched_table 		= $(this).find("SCHED_TABLE").text();

								var apply_exe_date		= $(this).find("APPLY_EXE_DATE").text();
								var apply_nm 			= $(this).find("APPLY_NM").text();
								var apply_cd 			= $(this).find("APPLY_CD").text();
								var line_approval 		= $(this).find("LINE_APPROVAL").text();
								var return_line_approval= $(this).find("RETURN_LINE_APPROVAL").text();

								var odate 				= $(this).find("ODATE").text();
								
								var approval_user_nm	= $(this).find("APPROVAL_USER_NM").text();
								var approval_date		= $(this).find("APPROVAL_DATE").text();
								var reject_user_nm		= $(this).find("REJECT_USER_NM").text();
								var reject_comment		= $(this).find("REJECT_COMMENT").text();
								var reject_date			= $(this).find("REJECT_DATE").text();
								var post_approval_yn	= $(this).find("POST_APPROVAL_YN").text();
								var detail_status		= $(this).find("DETAIL_STATUS").text();
								var alarm_user			= $(this).find("ALARM_USER").text();
								var doc_cnt				= $(this).find("DOC_CNT").text();
								var ori_doc_gb			= $(this).find("ORI_DOC_GB").text();
								var task_type			= $(this).find("TASK_TYPE").text();


								if (state_cd == "04") { //반려상태이면 결재자/일자 미표기
									approval_user_nm = "";
									approval_date = "";
								}
								
								if ( odate != "" ) {
									odate = odate.substring(0, 4) + "/" + odate.substring(4, 6) + "/" + odate.substring(6, 8);
								}
								
								if ( s_apply_date != "" ) {
									s_apply_date = s_apply_date.substring(0, 4) + "/" + s_apply_date.substring(4, 6) + "/" + s_apply_date.substring(6, 8);
								}
								
								var v_line_approval = "";
								var approval_gb = line_approval.split(",")[1];
								if(state_cd == '04'){ //반려상태는 쿼리에서 결재구분을 따로 받아옴
									approval_gb = return_line_approval.split(",")[1];
								}
								var arr_user_appr_gb_nm= '<%= CommonUtil.getGbNm("USER.APPR.GB") %>'.split(",");
								for (var a = 0; a < arr_user_appr_gb_nm.length; a++) {
									if (approval_gb == ("0"+(a+1))) {
										v_line_approval = '['+arr_user_appr_gb_nm[a]+']';
									}
								}

								var v_check_idx = ""; 
								//if ( state_cd == "01" ) {
								
								// 검색 조건이 미결인 상태만 일괄 체크 박스 존재 
								if ( state_cd == "00" && <%=S_USER_CD%> == user_cd && doc_gb != "02" && doc_gb != "06")  {
									v_check_idx = 	"<div class='gridInput_area'><input type='checkbox' name='check_idx' value='"+doc_cd+"' ></div>";
									v_check_idx += 	"<div class='gridInput_area'><input type='checkbox' name='check_doc_gb_idx' value='"+doc_gb+"' ></div>";
									v_check_idx += 	"<div class='gridInput_area'><input type='checkbox' name='check_job_name_idx' value='"+job_name+"' ></div>";
									v_check_idx += 	"<div class='gridInput_area'><input type='checkbox' name='check_data_center_idx' value='"+data_center+"' ></div>";
									v_check_idx += 	"<div class='gridInput_area'><input type='checkbox' name='check_apply_date' value='"+apply_exe_date+"' ></div>";
								}
								
								if(post_approval_yn == "N"){
									post_approval_yn = "순차";
								}else if(post_approval_yn == "Y") {
									post_approval_yn = "후결";
								}else if(post_approval_yn == 	 "A"){
									post_approval_yn = "즉시결재";
								}else{
									post_approval_yn = "";
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

								//엑셀일괄 반영상태 체크
								if(e_cnt != "0" || w_cnt != "0" || r_cnt != "0" ){
									apply_nm = "<font color='red'>"+apply_nm+"</font>";
								}

								//요청서 반영상태 체크
								if(apply_fail_cnt != "0"){
									if(total_cnt <= fail_cnt) apply_nm = "반영실패";
									
									apply_nm = "<font color='red'>"+apply_nm+"</font>";
								}

								rowsObj.push({
									'check_idx':v_check_idx
									,'grid_idx':i+1+startRowNum
									,'DOC_GROUP_ID': doc_group_id
									,'TASK_NM': task_nm
									,'MAIN_DOC_CD': main_doc_cd
									,'DOC_CD': doc_cd
									,'DOC_GB': doc_gb
									,'TITLE': title
									,'JOB_NAME': job_name
									,'DESCRIPTION': desc
									,'STATE_CD': state_cd
									,'STATE_NM': state_nm + v_line_approval
									,'DRAFT_DATE': draft_date
									,'DEPT_NM': dept_nm
									,'DEPT_CD' : dept_cd
									,'DUTY_NM' : duty_nm
									,'DUTY_CD' : duty_cd
									,'USER_CD' : user_cd
									,'USER_NM' : user_nm
									,'INS_DATE' : ins_date
									,'DATA_CENTER' : data_center
									,'DATA_CENTER_NAME' : data_center_name
									,'JOB_ID': job_id
									,'TABLE_ID': table_id
									,'S_APPLY_DATE': s_apply_date
									,'S_CNT': s_cnt
									,'E_CNT': e_cnt
									,'W_CNT': w_cnt
									,'R_CNT': r_cnt
									,'DOC_CNT': doc_cnt
									,'APPLICATION': application
									,'SCHED_TABLE':sched_table
									,'APPLY_NM': apply_nm
									,'ODATE': odate
									,'APPROVAL_USER_NM' : approval_user_nm
									,'APPROVAL_DATE' : approval_date
									,'REJECT_USER_NM' : reject_user_nm
									,'REJECT_COMMENT' : reject_comment
									,'REJECT_DATE' : reject_date
									,'POST_APPROVAL_YN' : post_approval_yn
									,'DETAIL_STATUS' : detail_status
									,'ORI_DOC_GB' : ori_doc_gb
									,'APPLY_EXE_DATE' : apply_exe_date
									,'APPLY_FAIL_CNT' : apply_fail_cnt
									,'TASK_TYPE' : task_type
								});
								
							});						
						}
						
						gridObj.rows = rowsObj;
						setGridRows(gridObj);
						
						//컬럼 자동 조정 기능
						$('body').resizeAllColumns();
// 						$('#ly_total_cnt').html('[ TOTAL : '+items.attr('cnt')+' ]');

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
		
		frm.action = "<%=sContextPath %>/tWorks.ez?c=ez004_excel";
		frm.target = "if1";
		frm.submit();
	}

	function fn_clear(arg) {
		
		if ( arg == "s_search_date2" ) {
			
			$("input[name='s_search_date2']").val('');
			$("input[name='p_s_search_date2']").val('');
			
		} else if ( arg == "e_search_date2" ) {
			$("input[name='e_search_date2']").val('');
			$("input[name='p_e_search_date2']").val('');
		}
	}

	//일괄요청서 생성
	function valid_chk(flag) {

		var frm = document.frm2;

		var check_idx 				= document.getElementsByName("check_idx");
		var doc_cd 					= "";
		var check_doc_cd 			= "";

		var check_job_name_idx		= document.getElementsByName("check_job_name_idx");
		var job_name				= "";
		var check_job_name 			= "";

		var check_data_center_idx	= document.getElementsByName("check_data_center_idx");
		var data_center				= "";
		var check_data_center 		= "";

		var check_doc_gb_idx		= document.getElementsByName("check_doc_gb_idx");
		var doc_gb					= "";
		var check_doc_gb			= "";

		var check_apply_date_idx = document.getElementsByName("check_apply_date");
		var apply_dates = new Set(); // 중복 방지를 위해 Set 사용

		var check_cnt			= 0;
		var check_doc_cnt		= 0;

		for ( var i = 0; i < check_idx.length; i++ ) {
			if(check_idx.item(i).checked) {

				doc_cd 				= check_idx.item(i).value;
				check_doc_cd 		= check_doc_cd + "|" + doc_cd;

				job_name			= check_job_name_idx.item(i).value;
				check_job_name		= check_job_name + "|" + job_name;

				data_center			= check_data_center_idx.item(i).value;
				check_data_center	= check_data_center + "|" + data_center;

				doc_gb				= check_doc_gb_idx.item(i).value;
				check_doc_gb		= check_doc_gb + "|" + doc_gb;

				var apply_date = check_apply_date_idx.item(i).value;
				if (apply_dates.size > 0 && !apply_dates.has(apply_date)) {
					alert("동일한 반영예정일에 대해서만 일괄요청 가능합니다");
					return;
				}
				apply_dates.add(apply_date); // Set에 추가
				check_cnt++;
			}
		}

		if ( check_cnt == 0 ) {
			alert("일괄 요청할 문서들을 선택해주세요.");
			return;
		}

		check_doc_cd 			= check_doc_cd.substring(1, check_doc_cd.length);
		check_job_name 			= check_job_name.substring(1, check_job_name.length);
		check_data_center 		= check_data_center.substring(1, check_data_center.length);
		check_doc_gb 			= check_doc_gb.substring(1, check_doc_gb.length);

		frm.doc_cd.value 		= check_doc_cd;
		frm.job_name.value 		= check_job_name;
		frm.data_center.value 	= check_data_center;
		frm.doc_gb.value 		= check_doc_gb;
		frm.doc_cnt.value 		= check_doc_cnt;
		frm.p_apply_date.value 	= apply_date;

		if(flag == 'draft_admin'){
			goPrc(flag,'','','');
		}else {
			getAdminLineGrpCd(flag, '01');
		}
 	}

	function goPrc(flag, grp_approval_userList, grp_alarm_userList, title){

		var frm			 = document.frm2;
		var check_cnt			= 0;

		var check_idx 				= document.getElementsByName("check_idx");

		for ( var i = 0; i < check_idx.length; i++ ) {
			if(check_idx.item(i).checked) {
				check_cnt++;
			}
		}

		var post_approval_yn 	= "N";

		if ( flag == "draft_admin" ) {
			if( !confirm(check_cnt+"건의 문서를 일괄 즉시반영[관리자결재] 하시겠습니까?") ) return;
		} else if ( flag == "draft" ) {
			if( !confirm(check_cnt+"건의 문서를 일괄 승인요청 하시겠습니까?") ) return;
		} else if ( flag == "post_draft" ) {
			if( !confirm(check_cnt+"건의 문서를 일괄 [후결]승인요청 하시겠습니까?") ) return;
			post_approval_yn 	= "Y";
		}

		frm.flag.value = flag;
		frm.title.value = title;
		frm.grp_approval_userList.value = grp_approval_userList;
		frm.grp_alarm_userList.value 	= grp_alarm_userList;
		frm.post_approval_yn.value = post_approval_yn;

		//$("#frm2").find("input[name='data_center']").val($("#f_s").find("input[name='data_center']").val());
		$("#p_s_state_cd").val($("input:radio[name='s_state_cd']:checked").val());
		$("#p_s_apply_cd").val($("input:radio[name='s_apply_cd']:checked").val());
		$("#p_check_approval_yn").val($("input:radio[name='check_approval_yn']:checked").val());
		$("#p_approval_state").val($("input:radio[name='approval_state']:checked").val());
		$("#p_s_gb").val($("select[name='s_gb'] option:selected").val());
		$("#p_s_text").val($("input[name='s_text']").val());
		$("#p_s_search_date").val($("input[name='s_search_date']").val());
		$("#p_e_search_date").val($("input[name='e_search_date']").val());
		
		//$("#p_date_gubun").val($("select[name='date_gubun'] option:selected").val());
		$("#p_date_gubun").val("02");

		$("#p_s_search_date2").val($("input[name='s_search_date2']").val());
		$("#p_e_search_date2").val($("input[name='e_search_date2']").val());
		
		//$("#p_date_gubun2").val($("select[name='date_gubun2'] option:selected").val());
		$("#p_date_gubun2").val("03");

		$("#p_task_nm").val($("select[name='task_nm'] option:selected").val());

		var search_data_center 		= $("#data_center").val();
		var search_state_cd 		= $("#p_s_state_cd").val();
		var search_apply_cd 		= $("#p_s_apply_cd").val();
		var search_gb 				= $("#p_s_gb").val();
		var search_text 			= $("#p_s_text").val();
		var search_date_gubun 		= $("#p_date_gubun").val();
		var search_s_search_date 	= $("#p_s_search_date").val();
		var search_e_search_date 	= $("#p_e_search_date").val();
		var search_s_search_date2 	= $("#p_s_search_date2").val();
		var search_e_search_date2 	= $("#p_e_search_date2").val();
		var search_task_nm	 		= $("#p_task_nm").val();

		var search_approval_state 	= $("#p_approval_state").val();
		var search_check_approval_yn = $("#p_check_approval_yn").val();

		var search_param = "&search_data_center="+search_data_center+"&search_state_cd="+search_state_cd+"&search_apply_cd="+search_apply_cd+
				"&search_gb="+search_gb+"&search_text="+encodeURI(search_text)+"&search_date_gubun="+search_date_gubun+
				"&search_s_search_date="+search_s_search_date+"&search_e_search_date="+search_e_search_date+
				"&search_s_search_date2="+search_s_search_date2+"&search_e_search_date2="+search_e_search_date2+
				"&search_task_nm="+search_task_nm+"&search_approval_state="+search_approval_state+"&search_check_approval_yn="+search_check_approval_yn;

		// 요청 사유 초기화
		$("#title_input").val("");

		try{viewProgBar(true);}catch(e){}

		frm.target = "if1";
		frm.action = "<%=sContextPath%>/tWorks.ez?c=ez036";
		frm.submit();
	}
</script>
