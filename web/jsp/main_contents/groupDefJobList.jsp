<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/jsp/common/inc/header.jsp"%>

<%
	Map<String, Object> paramMap = CommonUtil.collectParameters(request);
	String c = CommonUtil.isNull(paramMap.get("c"));
	String gridId = "g_"+c;

	String menu_gb = CommonUtil.getMessage("CATEGORY.GB.02.GB."+CommonUtil.isNull(paramMap.get("menu_gb")));
	String[] arr_menu_gb = menu_gb.split(",");

	String strServerGb = CommonUtil.isNull(CommonUtil.getMessage("SERVER_GB"));

	// 세션값 가져오기.
	String strSessionDcCode 	= S_D_C_CODE;
	String strSessionTab	 	= S_TAB;
	String strSessionApp	 	= S_APP;
	String strSessionGrp	 	= S_GRP;

	String strNowDate = DateUtil.getDay();

	//스크롤 페이징
	String strPagingNum			= CommonUtil.getMessage("PAGING.NUM");

	//관리자 즉시결재 노출 유무
	String strAdminApprovalBtn		= "";

	List adminApprovalBtnList		= (List)request.getAttribute("adminApprovalBtnList");

	if ( adminApprovalBtnList != null ) {
		for ( int i = 0; i < adminApprovalBtnList.size(); i++ ) {
			CommonBean commonBean = (CommonBean) adminApprovalBtnList.get(i);
			strAdminApprovalBtn = CommonUtil.isNull(commonBean.getScode_nm());
		}
	}
%>

<style type="text/css">

	.filebox label{
		display: inline-block;
		padding: .5em .75em
		color: #999
		font-size: inherit;
		line-height: normal;
		vertical-align: middle;
		background-color: #fdfdfd;
		cursor: pointer;
		border: 1px solid #ebebeb;
		border-bottom-color: #e2e2e2;
		border-radius: .25em;
		width:65px;
		height:21px;
	}

	.filebox input[type="file"]{
		position: absolute;
		width:1px;
		height:1px;
		padding: 0;
		margin: -1px;
		overflow: hidden;
		clip:rect(0,0,0,0);
		border: 0;
	}

</style>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/SlickGrid-2.1.0/slick.editors.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/SlickGrid-2.1.0/slick.formatters.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/SlickGrid-2.1.0/plugins/slick.autocolumnsize.js" ></script>

<form id="f_s" name="f_s" method="post" onsubmit="return false;">
	<input type='hidden' 	id='data_center_code' 			name='data_center_code'/>
	<input type='hidden' 	id='data_center'				name='data_center'/>
	<input type='hidden' 	id='active_net_name'			name='active_net_name'		/>
	<input type='hidden'	id='S_USER_NM' 					name='S_USER_NM' 			value="<%=S_USER_NM%>"/>
	<input type='hidden'	id='jobgroup_id' 				name='jobgroup_id' />
	<input type="hidden" 	id='jobgroup_name'				name='jobgroup_name' />
<!-- 	<input type="hidden" 	id="order_date" 				name="order_date"/> -->

	<input type='hidden' 	id='job_name' 					name='job_name'/>
	<input type='hidden' 	id='table_id' 					name='table_id'/>
	<input type='hidden' 	id='job_id' 					name='job_id'/>
	<input type='hidden' 	id='v_sched_table' 				name='v_sched_table'/>
	<input type="hidden" 	id="menu_gb"					name="menu_gb" 				value="${paramMap.menu_gb}" />
	<input type="hidden"	id="p_mcode_nm"					name="p_mcode_nm"  />
	<input type="hidden" 	id="p_scode_nm"					name="p_scode_nm"  />
	<input type="hidden"  	id="post_approval_yn"			name="post_approval_yn"/>

	<input type="hidden" 	id="flag" 						name="flag" />

</form>

<form name="frm2" id="frm2" method="post">
	<input type='hidden' 	name='data_center_code'			id='data_center_code'/>
	<input type='hidden' 	name='data_center'				id='data_center'/>
	<input type='hidden' 	name='active_net_name'			id='active_net_name'/>

	<input type="hidden" 	name="flag" 					id="flag" />
	<input type="hidden" 	name="force_gubun" 				id="force_gubun" 			value="yes"/>
	<input type="hidden" 	name="force_yn" 				id="force_yn" 				value="Y"/>
	<input type="hidden" 	name="hold_gubun" 				id="hold_gubun" 			value="yes"/>
	<input type="hidden" 	name="hold_yn" 					id="hold_yn" 				value="Y"/>
	<input type="hidden" 	name="wait_yn" 					id="wait_yn" />

	<input type="hidden" 	name="table_name" 				id="table_name" />
	<input type="hidden" 	name="application" 				id="application" />
	<input type="hidden" 	name="group_name" 				id="group_name" />
	<input type="hidden" 	name="job_name" 				id="job_name" />
	<input type="hidden" 	name="order_date" 				id="order_date" />
	<input type="hidden" 	name="t_set" 					id="t_set" />
	<input type="hidden" 	name="table_id" 				id="table_id" />
	<input type="hidden" 	name="job_id" 					id="job_id" />
	<input type="hidden" 	name="e_order_date" 			id="e_order_date" 			value="${ODATE}" />
	<input type="hidden" 	name="odate" 					id="odate" 					value="${ODATE}" />
	<!-- <input type="hidden" name="e_order_date" 			id="e_order_date" 		value="" /> -->
	<input type="hidden" 	name="order_cnt" 				id="order_cnt" 				value="0" />
	<input type="hidden" 	name="doc_gb" 					id="doc_gb" />
	<input type="hidden" 	name="post_approval_yn" 		id="post_approval_yn"/>
	<input type="hidden" 	name="title"  					id="title" />

	<input type='hidden'	name='jobgroup_id' 				id='jobgroup_id' />
	<input type="hidden" 	name='jobgroup_name'			id='jobgroup_name' />

	<input type="hidden"	name="check_table_ids" />
	<input type="hidden" 	name="check_job_ids" />
	<input type="hidden" 	name="check_sched_tables" />
	<input type="hidden" 	name="check_job_names" />

	<!-- 그룹결재구성원 결재권/알림수신여부	 -->
	<input type="hidden" 	name="grp_approval_userList"  id="grp_approval_userList" />
	<input type="hidden" 	name="grp_alarm_userList"  	  id="grp_alarm_userList" />

</form>

<form name="frm3" id="frm3" method="post">
	<input type="hidden" 	name="menu_gb" 					id="menu_gb" 				value="${paramMap.menu_gb}" />
	<input type='hidden' 	name='data_center' 				id='data_center'/>
	<input type="hidden" 	name="table_id" 				id="table_id" />
	<input type="hidden" 	name="job_id" 					id="job_id" />
	<input type="hidden" 	name="job_name" 				id="job_name" />
</form>
<form name="f_tmp" id="f_tmp" method="post" onsubmit="return false;">
	<input type="hidden" name="jobgroup_id" 		value=''/>
	<input type="hidden" name="jobgroup_nm" 		value=''/>
	<input type="hidden" name="jobgroup_content" 	value=''/>
	<input type="hidden" name="group_order" 		value='Y'/>
</form>
<table style='width:100%;height:100%;border:none;'>
	<tr style='height:10px;'>
		<td style='vertical-align:top;'>
			<h4 class="ui-widget-header ui-corner-all"  >
				<div id='t_<%=gridId %>' class='title_area' >
					<span><%=CommonUtil.isNull(CommonUtil.getMessage("CATEGORY.GB.02"))%> > <%=CommonUtil.isNull(arr_menu_gb[0]) %></span>
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
<!-- 					<th width='10%'><div class='cellTitle_kang2' style="min-width:120px" >C-M</div></th> -->
					<td width='15%' style="display:none;text-align:left; width:300px;">
						<div class='cellContent_kang' style='width:300px;'>
<!-- 						<select id="data_center_items" name="data_center_items" style="width:120px; height:21px;">							 -->
<!-- 							<option value="">--선택--</option> -->
<%-- 							<c:forEach var="cm" items="${cm}" varStatus="status"> --%>
<%-- 								<option value="${cm.scode_cd},${cm.scode_eng_nm}">${cm.scode_nm}</option> --%>
<%-- 							</c:forEach> --%>
<!-- 						</select> -->
						</div>
					</td>
					<!-- <th><div class='cellTitle_kang2'></div></th>
					<td style="text-align:left"></td> -->
					<c:forEach var="cm" items="${cm}" varStatus="status">
					<input type="hidden" id="data_center_hd" name="data_center_hd" value="${cm.scode_cd},${cm.scode_eng_nm}"/>
					</c:forEach>
					<th width='10%'><div class='cellTitle_kang2' style='min-width:120px;' >그룹명</div></th>
					<td width='85%' style="text-align:left; width:300px;">
						<input type="text" name="search_text" value="" id="search_text" style="width:150px;height:21px;"/>
					</td>
					<td width='5%'>
						<span id='btn_search' style='float:right;'>검색</span>
					</td>
				</tr>
			</table>
			</h4>
			</form>
		</td>
	</tr>
	<tr>
		<td id='ly_<%=gridId %>' style='vertical-align:top;' >
			<div id="<%=gridId %>" class="ui-widget-header ui-corner-all" ></div>
		</td>
	</tr>
	<tr style='height:35px;'>
		<td style='vertical-align:top;'>
			<h4 class="ui-widget-header ui-corner-all" >
				<div align='right' class='btn_area' >
					<div id='ly_total_cnt' style='padding-top:5px;float:left;'></div>

					<span id="btn_draft" style='display:none;'>승인요청</span>
					<span id="btn_admin_approval" style='display:none;'>관리자 즉시결재</span>

				</div>
			</h4>
		</td>
	</tr>
</table>
<div id="dl_p01" style='overflow:hidden;display:none;padding:0;'>
	<iframe id='if_p01' name='if_p01' src='about:blank' width='0px' height='0px' scrolling='no'  frameborder="0"  ></iframe>
</div>
<script>
	var listChk = false;

	function dateFormatter(row,cell,value,columnDef,dataContext){

		var ret = "";
		ret = value.getMonth()+""+value.getDate();

		return ret;

	}

	function gridCellCustomFormatter(row,cell,value,columnDef,dataContext){
		var ret = "";
		var group_id      = getCellValue(gridObj,row,'JOBGROUP_ID');
		var group_nm      = getCellValue(gridObj,row,'JOBGROUP_NAME');
		var group_content = getCellValue(gridObj,row,'CONTENT');

		if(columnDef.id == 'JOBGROUP_NAME') {
			ret = "<a href=\"JavaScript:popupGroupDetail('"+group_id+"', '"+group_nm+"', '"+group_content+"');\" /><font color='red'>"+value+"</font></a>";
		}
		return ret;
	}

	var gridObj = {
		id : "<%=gridId %>"
		,colModel:[
			{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'번호',width:50,minWidth:50,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	   		,{formatter:gridCellCustomFormatter,field:'JOBGROUP_NAME',id:'JOBGROUP_NAME',name:'그룹명',width:200,minWidth:200,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
			,{formatter:gridCellNoneFormatter,field:'COUNT',id:'COUNT',name:'작업건수',width:70,minWidth:70,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'JOBGROUP_UDT_USER_NM',id:'JOBGROUP_UDT_USER_NM',name:'최종수정자',width:100,minWidth:100,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'JOBGROUP_UDT_DATE',id:'JOBGROUP_UDT_DATE',name:'최종수정일',width:100,minWidth:100,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
			,{formatter:gridCellNoneFormatter,field:'CONTENT',id:'CONTENT',name:'비고',width:100,minWidth:100,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}

			,{formatter:gridCellNoneFormatter,field:'JOBGROUP_ID',id:'JOBGROUP_ID',name:'그룹ID',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}

	   	]

		,rows:[]
		,vscroll:false
	};

	$(document).ready(function(){

		var user_gb 			= "<%=S_USER_GB%>";
		var server_gb 			= "<%=strServerGb%>";
		var session_dc_code		= "<%=strSessionDcCode%>";
		var adminApprovalBtn 	= "<%=strAdminApprovalBtn%>";

		if (user_gb == "99"  || adminApprovalBtn == "Y") {
				$("#btn_admin_approval").show();
		} else {
			$("#btn_admin_approval").hide();
		}

		$("#btn_draft").show();

		$("#btn_search").show();
		$("#f_s").find("input[name='data_center']").val($("#data_center_hd").val());

		setTimeout(function(){
			jobGroupList();
		}, 500);

		//체크박스 설정
		viewGrid_1(gridObj,"ly_"+gridObj.id,{enableColumnReorder:true},'AUTO');

		$("#btn_search").button().unbind("click").click(function(){
			jobGroupList();
		});

		$('#search_text').unbind('keypress').keypress(function(e){
			if(e.keyCode==13){

				if($(this).val() == ""){
					alert("검색어를 입력해 주세요.");
					return;
				}

				jobGroupList();
			}
		});

		$("#data_center_items").change(function(){		//C-M
			var data_center_items = $(this).val();
			if($(this).val() != ""){
				$("#f_s").find("input[name='data_center']").val(data_center_items);
			}
		});

		$("#btn_draft").button().unbind("click").click(function(){
			valid_chk ('draft');
		});

		$("#btn_admin_approval").button().unbind("click").click(function(){
			valid_chk ('draft_admin');
		});

	});

	//그룹JOB 조회
	function jobGroupList(){

		$("#f_s").find("input[name='jobgroup_name']").val($("#frm1").find("input[name='search_text']").val());

		try{viewProgBar(true);}catch(e){}

		$('#ly_total_cnt').html('');
		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=jobGroupList';

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

								var choice				= "<input type='radio' name='jobgroup_id' id='jobgroup_id' value='"+$(this).find("JOBGROUP_ID").text()+"'  />";
								var jobgroup_id	 		= $(this).find("JOBGROUP_ID").text();
								var jobgroup_name 		= $(this).find("JOBGROUP_NAME").text();
								var user_nm 			= $(this).find("JOBGROUP_UDT_USER_NM").text();
								var date 				= $(this).find("JOBGROUP_UDT_DATE").text();
								var content 			= $(this).find("CONTENT").text();
								var count	 			= $(this).find("COUNT").text();

								rowsObj.push({
									'grid_idx'				: i+1
									,'JOBGROUP_CHOICE'		: choice
									,'JOBGROUP_NAME'		: jobgroup_name
									,'JOBGROUP_UDT_USER_NM'	: user_nm
									,'JOBGROUP_UDT_DATE'	: date
									,'CONTENT'				: content
									,'COUNT'				: count+"건"
									,'JOBGROUP_ID'			: jobgroup_id
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

	function valid_chk (flag) {

		// 그리드 마지막 값 원복되는 현상 해결
		$('#'+gridObj.id).data('grid').getEditorLock().commitCurrentEdit();

		var jobgroup_id = "";
		var jobgroup_name = "";
		var aSelRow = new Array;
		aSelRow = $('#'+gridObj.id).data('grid').getSelectedRows();

		if(aSelRow.length == 0){
			alert("수행 할 그룹 JOB을 선택해 주세요.");
			return;
		}else if(aSelRow.length > 1){
			alert("수행 할 그룹 JOB은 하나만 선택해주세요.");
			return;
		}else{
			if(aSelRow.length>0) {
				for (var i = 0; i < aSelRow.length; i++) {
					jobgroup_id = getCellValue(gridObj, aSelRow[i], 'JOBGROUP_ID');
					jobgroup_name = getCellValue(gridObj, aSelRow[i], 'JOBGROUP_NAME');
				}
			}
		}

		var frm = document.frm2;
		frm.jobgroup_id.value 			= jobgroup_id;
		frm.jobgroup_name.value 		= jobgroup_name;

		if(flag == 'draft_admin'){
			//관리자 즉시결재
			//goPrc(check_sched_table, check_application, check_group_name, check_job_name, grid_idx, check_table_id, check_job_id, t_set, hold_yn, force_check, flag, cnt, '', '' , group_yn, doc_gb);
			popAdminTitleInput(flag, '05');
		}else {
			getAdminLineGrpCd(flag, '05');
			//setDynamicApproval(check_sched_table, check_application, check_group_name, check_job_name, check_mem_name, check_table_id, check_job_id, t_set, force_check, flag, cnt, admin_line_grp_cd, group_yn, doc_gb);
		}
	}

	function goPrc( flag, grp_approval_userList, grp_alarm_userList, title){

		$("#frm2").find("input[name='data_center_code']").val($("#f_s").find("input[name='data_center_code']").val());
		$("#frm2").find("input[name='data_center']").val($("#f_s").find("input[name='data_center']").val());
		$("#frm2").find("input[name='active_net_name']").val($("#f_s").find("input[name='active_net_name']").val());

		var frm = document.frm2;
		var jobgroup_name = $("#frm2").find("input[name='jobgroup_name']").val();
		// 후결
		var post_approval_yn = "N";

		if ( flag == "draft_admin" ) {
			if( !confirm("그룹["+jobgroup_name + "]을 즉시반영 하시겠습니까?") ) return;
		} else if ( flag == "draft" ) {
			if( !confirm("그룹["+jobgroup_name + "]을 승인 하시겠습니까?") ) return;
		} else if ( flag == "post_draft" ) {
			if( !confirm("그룹["+jobgroup_name + "]을 즉시반영[후결] 하시겠습니까?") ) return;
			post_approval_yn 	= "Y";
		}

		frm.flag.value 					= flag;
		frm.grp_approval_userList.value = grp_approval_userList;
		frm.grp_alarm_userList.value 	= grp_alarm_userList;
		frm.title.value 				= title;
		frm.post_approval_yn.value 		= post_approval_yn;

		try{viewProgBar(true);}catch(e){}

		frm.action = "<%=sContextPath%>/tWorks.ez?c=ez021_jg";
		//frm.action = "<%=sContextPath%>/tWorks.ez?c=ez036";
		frm.target = "if1";
		frm.submit();
	}

	// 그룹JOB 목록
	function popupGroupDetail(group_id, group_nm, group_content){

		var url = "<%=sContextPath %>/tWorks.ez?pop_if=P01&c=ez019";

		if(dlMap.containsKey('dl_p01')) dlClose('dl_p01');

		$('#if_p01').width(850).height(700);

		dlPopIframe01('dl_p01','그룹JOB 목록',$('#if_p01').width(),$('#if_p01').height(),true,true,true);

		dlFrontView('dl_p01');

		setTimeout(function(){
			var f = document.f_tmp;
			f.jobgroup_id.value = group_id;
			f.jobgroup_nm.value = group_nm;
			f.jobgroup_content.value = group_content;
			f.target = "if_p01";
			f.action = url;
			f.submit();
		}, 300);
	}


</script>
