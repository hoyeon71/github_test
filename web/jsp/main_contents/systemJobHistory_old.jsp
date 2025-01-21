<%@page import="com.ghayoun.ezjobs.t.domain.ApprovalLineBean"%>
<%@page import="com.ghayoun.ezjobs.t.domain.ActiveJobBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/jsp/common/inc/header.jsp"%>

<c:set var="job_action" value="${fn:split(JOB_ACTION,',')}"/>

<%
	Map<String, Object> paramMap = CommonUtil.collectParameters(request);
	String c = CommonUtil.isNull(paramMap.get("c"));
	String gridId 			= "g_"+c;
	String menu_gb = CommonUtil.getMessage("CATEGORY.GB.09.GB."+CommonUtil.isNull(paramMap.get("menu_gb")));
	String[] arr_menu_gb = menu_gb.split(",");
	
	String strServerGb 		= CommonUtil.isNull(CommonUtil.getMessage("SERVER_GB"));
	List approvalLineList			= (List)request.getAttribute("approvalLineList");
	
	// 세션값 가져오기.
	String strSessionDcCode = S_D_C_CODE;
	String session_user_gb 	= S_USER_GB;
	String strSessionTab	= S_TAB;
	String strSessionApp	= S_APP;
	String strSessionGrp	= S_GRP;
	
	String odate = (String)request.getAttribute("ODATE");
	odate = odate.replace("/", "");
	
	String doc_cd 				= "";
%>

<form id="f_s" name="f_s" method="post" onsubmit="return false;">	
	<input type='hidden' id='p_sched_table' name='p_sched_table'/>
	<input type='hidden' id='p_application_of_def' name='p_application_of_def'/>
	<input type='hidden' id='p_group_name_of_def' name='p_group_name_of_def'/>
	
	<input type="hidden" name="data_center" 		id="data_center" />
	<input type="hidden" name="p_scode_cd" 			id="p_scode_cd" />
	<input type="hidden" name="p_grp_depth" 		id="p_grp_depth" />
	<input type="hidden" name="p_app_nm" 			id="p_app_nm" />
	<input type="hidden" name="p_app_search_gubun" 	id="p_app_search_gubun" />
</form>

<form id="frm3" name="frm3" method="post" onsubmit="return false;">	
	<input type="hidden" name="p_data_center" 			id="p_data_center" />
	<input type="hidden" name="flag"	 				id="flag" />
	<input type="hidden" name="doc_gb"	 				id="doc_gb"  		value="13"/>
	<input type="hidden" name="p_content"		 		id="p_content" />
	<input type="hidden" name="p_title"	 				id="p_title" />
	<input type="hidden" name="p_odate"	 				id="p_odate" />
</form>
<form id="userFrm" name="userFrm" method="post" onsubmit="return false;"></form>
<form name="frm1" id="frm1" method="post">
<input type="hidden" name="menu_gb" 			id="menu_gb" value="${paramMap.menu_gb}" />
<table style='width:100%;height:100%;border:none;'>
	<tr style='height:10px;'>
		<td style='vertical-align:top;'>
			<h4 class="ui-widget-header ui-corner-all"  >
				<div id='t_<%=gridId %>' class='title_area'>
					<span><%=CommonUtil.isNull(arr_menu_gb[0]) %></span>
				</div>
			</h4>
		</td>
	</tr>
	<tr style='height:10px;'>
		<td style='vertical-align:top;'>
			<table style='width:100%;border-width:1px; border-color:gray; border-style:double;'>
				<tr>
					<td width="120px"></td>
					<td width="250px"></td>
					<td width="120px"></td>
					<td width="200px"></td>
					<td width="120px"></td>
					<td width=""></td>
				</tr>
				<tr>
					<th width="10%"><div class='cellTitle_kang2'>C-M</div></th>
					<td width="20%" style="text-align:left">
						<div class='cellContent_kang'>
						<select id="data_center_items" name="data_center_items" style="width:98%; height:21px;">
							<option value="">--선택--</option>
							<c:forEach var="cm" items="${cm}" varStatus="status">
								<option value="${cm.scode_cd},${cm.scode_eng_nm}">${cm.scode_nm}</option>
							</c:forEach>
						</select>
						</div>
					</td>
					
					<th width="10%"><div class='cellTitle_kang2'></div></th>
					<td width="20%" style="text-align:left"></td>
					
					<th width="10%"><div class='cellTitle_kang2'></div></th>
					<td width="20%" style="text-align:left"></td>
				</tr>
				<tr>			
					<th><div class='cellTitle_kang2'>테이블</div></th>
					<td style="text-align:left">
						<div class='cellContent_kang'>
							<input type="text" name="table_nm" id="table_nm" style="width:70%; height:21px;" onkeydown="return false;" readonly/>&nbsp;<img id="btn_clear1" src="/images/sta2.png" style="width:16px;height:16px;vertical-align:middle;cursor:pointer;"/>
							<input type="hidden" name="table_of_def" id="table_of_def" />
						</div>
					</td>
						
					<th><div class='cellTitle_kang2'>어플리케이션</div></th>
					<td style="text-align:left">
						<div class='cellContent_kang'>
							<select name="application_of_def" id="application_of_def" style="width:70%;height:21px;">
								<option value="">--선택--</option>
							</select>
						</div>
					</td>
					
					<th><div class='cellTitle_kang2'>그룹</div></th>
					<td style="text-align:left">
						<div class='cellContent_kang'>
						<select id="group_name_of_def" name="group_name_of_def" style="width:70%; height:21px;">
							<option value=''>--선택--</option>
						</select>
						</div>
					</td>		
				</tr>			
				<tr>
					<td colspan="6" style="text-align:right;">
						<span id="btn_search" style='display:none;margin:3px;'>검 색</span>
					</td>
				</tr>					
			</table>
		</td>
	</tr>
	<%-- <tr style='height:10px;'>
		<td valign="top">
			<input type="hidden" name="title" id="title" value="보고시스템별현황"/>
			<table style="width:100%;">
				<tr>
					<td width="120px"></td>
					<td width="250px"></td>
					<td width="120px"></td>
					<td width="200px"></td>
					<td width="120px"></td>
					<td width=""></td>
				</tr>
				<tr>
					<th><div class='cellTitle_kang2'>ODATE</div></th>
					<td style="text-align:left"  colspan="5">
						<div class='cellContent_kang'>
						<input type="text" name="odate" id="odate" value="<%=odate %>" class="input datepick" style="width:10%; height:21px;" maxlength="10" readOnly/>
						</div>
					</td>
					
					<td style="text-align:right;" colspan="6" >
						<!-- <span id="btn_search" style='display:none;'>검색</span>	 -->
						<img id="btn_search" src='<%=sContextPath%>/imgs/btn_SRC.gif' style='border:0;vertical-align:top;cursor:pointer;' />
						<span id="btn_excel" style="display:none;">엑셀다운</span>		
					</td>
				</tr>
			</table>  
		</td>
	</tr> --%>
</table>

</form>

<table style='width:100%;height:60%;border:none;'>
<tr>
	<td id='ly_<%=gridId %>' style='vertical-align:top;' >
		<div id="<%=gridId %>" class="ui-widget-header ui-corner-all" ></div>
	</td>
</tr>
</table>
<table style='width:100%;height:100%;border:none;'>
<tr style='height:10px;'>
	<td style='vertical-align:top;'>
		<h4 class="ui-widget-header ui-corner-all" >
			<div align='right' class='btn_area' >
				<div id='ly_total_cnt' style='padding-top:5px;float:left;'></div>
				<span id="btn_excel" style="display:none;">엑셀다운</span>	
<!-- 				<span id="btn_draft_i">승인</span> -->
			</div>
		</h4>
	</td>
</tr>
</table>

<script type="text/javascript">
	var gridObj = {
		id : "<%=gridId %>"
		,colModel:[
					{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'번호',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid',sortable:true}
					,{formatter:gridCellNoneFormatter,field:'SCODE_NM',id:'SCODE_NM',name:'시스템구분',width:180,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}	   		
					,{formatter:gridCellNoneFormatter,field:'TYPE_GUBUN',id:'TYPE_GUBUN',name:'TYPE_GUBUN',width:180,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}	   		
			   		,{formatter:gridCellNoneFormatter,field:'D_CNT',id:'D_CNT',name:'일별[D]',width:120,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
			   		,{formatter:gridCellNoneFormatter,field:'W_CNT',id:'W_CNT',name:'주별[W]',width:120,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
			   		,{formatter:gridCellNoneFormatter,field:'T_CNT',id:'T_CNT',name:'10일단위[T]',width:120,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
			   		,{formatter:gridCellNoneFormatter,field:'M_CNT',id:'M_CNT',name:'월별[M]',width:120,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
			   		,{formatter:gridCellNoneFormatter,field:'Q_CNT',id:'Q_CNT',name:'분기[Q]',width:120,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
			   		,{formatter:gridCellNoneFormatter,field:'H_CNT',id:'H_CNT',name:'반기[H]',width:120,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
			   		,{formatter:gridCellNoneFormatter,field:'Y_CNT',id:'Y_CNT',name:'년[Y]',width:120,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
			   		,{formatter:gridCellNoneFormatter,field:'O_CNT',id:'O_CNT',name:'오픈(Open)[O]',width:120,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
			   		,{formatter:gridCellNoneFormatter,field:'S_CNT',id:'S_CNT',name:'비정기(Ondemend)[S]',width:120,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}

			   	]
		,rows:[]
		,vscroll:false
	};
	
	$(document).ready(function(){
		$("#btn_search").show();
		var session_user_gb = "<%=session_user_gb%>";
		var session_dc_code	= "<%=strSessionDcCode%>";
		var server_gb 		= "<%=strServerGb%>";
		var table_name		= "<%=strSessionTab%>";
		var application		= "<%=strSessionApp%>";
		var group_name		= "<%=strSessionGrp%>";
		
		$("select[name='data_center_items']").val(session_dc_code);
		$("#f_s").find("input[name='data_center']").val(session_dc_code);
	
		if(table_name != '') {
			$("input[name='table_nm']").val(table_name);
			$("#f_s").find("input[name='p_sched_table']").val("'"+table_name+"'");
		}
		
		getAppGrpCodeList("", "2", "", "application_of_def", "'"+table_name+"'");
		
		setTimeout(function(){
			$("select[name='application_of_def']").val(application);
			$("#f_s").find("input[name='p_application_of_def']").val(application);
		}, 1000);
		
		getAppGrpCodeList("", "3", "", "group_name_of_def", "'"+application+"'");
		
		setTimeout(function(){
			$("select[name='group_name_of_def']").val(group_name);
			$("#f_s").find("input[name='p_group_name_of_def']").val(group_name);
		}, 1000);
		
// 		$("#odate").addClass("ime_readonly").unbind('click').click(function(){
// 			dpCalMin(this.id,'yymmdd');
// 		});
		
		$("#btn_search").button().unbind("click").click(function(){
			
			systemJobHistory();
			
			var row_msg = $("#ly_total_cnt").text();
			
			if(row_msg != "[ TOTAL : 0 ]"){
				$("#btn_excel").show();
			}else{
				$("#btn_excel").hide();
			}
		});
		$("#btn_draft_i").button().unbind("click").click(function(){
			goPrc('draft_i');
		});
		$("#btn_excel").button().unbind("click").click(function(){
			goExcel();
		});
		
		$("#data_center_items").change(function(){
			
			//초기화
			$("#table_nm").val("");
			$("#table_of_def").val("");
					
			$("#f_s").find("input[name='p_sched_table']").val("");
			$("#f_s").find("input[name='p_application_of_def']").val("");
			$("#f_s").find("input[name='p_group_name_of_def']").val("");
			
			$("select[name='application_of_def'] option").remove();
			$("select[name='application_of_def']").append("<option value=''>--선택--</option>");
			
			$("select[name='group_name_of_def'] option").remove();
			$("select[name='group_name_of_def']").append("<option value=''>--선택--</option>");
			
			var data_center_items = $(this).val();
			if($(this).val() != ""){
				$("#f_s").find("input[name='data_center']").val(data_center_items);
			}
					
		});
		
		$("#table_nm").click(function(){
			var data_center = $("select[name='data_center_items'] option:selected").val();
			
			if(data_center == ""){
				alert("C-M 을 선택해 주세요.");
				return;
			}else{
				searchPoeTabForm();
			}		
		});
		
		$("#application_of_def").change(function(){		//GRP
			var application_of_def = $("select[name='application_of_def'] option:selected").val();
			$("#f_s").find("input[name='p_application_of_def']").val(application_of_def);
			$("#f_s").find("input[name='p_group_name_of_def']").val("");
			
			getAppGrpCodeList("", "3", "", "group_name_of_def", "'"+$(this).val()+"'");
		});
		
		$("#btn_clear1").unbind("click").click(function(){
			$("#f_s").find("input[name='p_sched_table']").val("");
			$("#f_s").find("input[name='p_application_of_def']").val("");
			$("#f_s").find("input[name='p_group_name_of_def']").val("");

			$("#frm1").find("input[name='table_nm']").val("");
			$("#frm1").find("input[name='table_of_def']").val("");

			$("select[name='application_of_def'] option").remove();
			$("select[name='application_of_def']").append("<option value=''>--선택--</option>");
			
			$("select[name='group_name_of_def'] option").remove();
			$("select[name='group_name_of_def']").append("<option value=''>--선택--</option>");
			
			$("select[name='node_id'] option").remove();
			$("select[name='node_id']").append("<option value=''>--선택--</option>");
		});
		
		viewGrid_1(gridObj,"ly_"+gridObj.id);
		//try{viewProgBar(true);}catch(e){}
		//systemJobHistory();
		
	});
	
	function systemJobHistory(){
		try{viewProgBar(true);}catch(e){}
		
		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=systemJobHistory';
		
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
								
								var scode_nm 	= $(this).find("SCODE_NM").text();
								var type_gubun 	= $(this).find("TYPE_GUBUN").text();
								var d_cnt 		= $(this).find("D_CNT").text();
								var w_cnt 		= $(this).find("W_CNT").text();
								var t_cnt		= $(this).find("T_CNT").text();
								var m_cnt		= $(this).find("M_CNT").text();
								var q_cnt		= $(this).find("Q_CNT").text();
								var h_cnt		= $(this).find("H_CNT").text();
								var y_cnt 		= $(this).find("Y_CNT").text();
								var o_cnt		= $(this).find("O_CNT").text();
								var s_cnt       = $(this).find("S_CNT").text();
								var v_type_gubun = "";
								if(type_gubun == "B"){
									v_type_gubun = "BatchJob [B]";
								}else if(type_gubun == "I"){
									v_type_gubun = "Interface Job [I]";
								}else if(type_gubun == "F"){
									v_type_gubun = "Filewatch Job [F]";
								}else if(type_gubun == "S"){
									v_type_gubun = "Sorting Job [S]";
								}else if(type_gubun == "D"){
									v_type_gubun = "Dummy Job [D]";
								}
								
								if(type_gubun == "B" || type_gubun == "I" || type_gubun == "F" || type_gubun == "S" || type_gubun == "D"){
									rowsObj.push({
										'grid_idx':i+1
										,'SCODE_NM':scode_nm
										,'TYPE_GUBUN':v_type_gubun
										,'D_CNT':d_cnt
										,'W_CNT':w_cnt
										,'T_CNT':t_cnt
										,'M_CNT':m_cnt
										,'Q_CNT':q_cnt
										,'H_CNT':h_cnt
										,'Y_CNT':y_cnt
										,'O_CNT':o_cnt
										,'S_CNT':s_cnt
									});
								}
							});						
						}
						
						gridObj.rows = rowsObj;
						setGridRows(gridObj);
						
					});
					try{viewProgBar(false);}catch(e){}
				}
		, null );
		
		xhr.sendRequest();
	}
	
	function selectTable(eng_nm, desc){
		
		$("#table_nm").val(eng_nm);
		$("#table_of_def").val(eng_nm);
		
		dlClose("dl_tmp1");
		
		$("#f_s").find("input[name='p_sched_table']").val("'"+eng_nm+"'");
		$("#f_s").find("input[name='p_application_of_def']").val("");
		$("#f_s").find("input[name='p_group_name_of_def']").val("");

		//어플리케이션을 검색		
		getAppGrpCodeList("", "2", "", "application_of_def", "'"+eng_nm+"'");
		
		//그룹초기화
		$("select[name='group_name_of_def'] option").remove();
		$("select[name='group_name_of_def']").append("<option value=''>--선택--</option>");
		
		$("select[name='node_id'] option").remove();
		$("select[name='node_id']").append("<option value=''>--선택--</option>");
	}
	
	function selectTable2(eng_nm, desc){

		$("#table_nm").val(eng_nm);
		$("#table_of_def").val(eng_nm);	
		
		dlClose("dl_tmp1");

		$("#f_s").find("input[name='p_sched_table']").val(eng_nm);
		$("#f_s").find("input[name='p_application_of_def']").val("");
		$("#f_s").find("input[name='p_group_name_of_def']").val("");
		
		getAppGrpCodeList("", "2", "", "application_of_def", eng_nm);
		
		$("select[name='group_name_of_def'] option").remove();
		$("select[name='group_name_of_def']").append("<option value=''>--선택--</option>");
		
		$("select[name='node_id'] option").remove();
		$("select[name='node_id']").append("<option value=''>--선택--</option>");
		
	}
	
	//APP/GRP 가져오기
	function getAppGrpCodeList(scode_cd, depth, grp_cd, val, eng_nm){
		
		try{viewProgBar(true);}catch(e){}
				
		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=searchAppGrpCodeList&itemGubun=2&p_scode_cd='+scode_cd+'&p_app_eng_nm='+encodeURIComponent(eng_nm)+'&p_grp_depth='+depth+'&p_grp_cd='+grp_cd;
						
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
							$("select[name='"+val+"'] option").remove();
							$("select[name='"+val+"']").append("<option value=''>--선택--</option>");							
						}else{
							
							$("select[name='"+val+"'] option").remove();
							$("select[name='"+val+"']").append("<option value=''>--선택--</option>");			
							
							items.find('item').each(function(i){						
								
								var grp_cd = $(this).find("GRP_CD").text();
								var grp_nm = $(this).find("GRP_NM").text();	
								var grp_desc = $(this).find("GRP_DESC").text();	
								var grp_eng_nm = $(this).find("GRP_ENG_NM").text();
								var arr_grp_cd = grp_cd+","+grp_eng_nm;
																																																								
								$("select[name='"+val+"']").append("<option value='"+grp_eng_nm+"'>"+grp_desc+"</option>");
								
							});						
						}									
						
					});
					try{viewProgBar(false);}catch(e){}
				}
		, null );
		
		xhr.sendRequest();
	}
	
	function goExcel() {
		
		var frm = document.frm1;
		
		frm.action = "<%=sContextPath %>/tWorks.ez?c=ez051_excel";
		frm.target = "if1";
		frm.submit();
	}
	
	function goPrc(flag){
		
		var frm = document.frm3;
		
		if($('#title').val() == ""){
			alert("의뢰 사유는 필수 입력사항입니다.");
			$('#title').focus();
			return;
		}
		
		frm.flag.value   					= flag;
		frm.doc_gb.value 					= "14";
		frm.p_content.value 				= $('#content').val();
		frm.p_title.value 					= $('#title').val();
		//frm.p_odate.value 					= document.frm1.odate.value;
		
		if( !confirm("처리하시겠습니까?") ) return;
		
		try{viewProgBar(true);}catch(e){}
		frm.target = "if1";
		frm.action = "<%=sContextPath%>/tWorks.ez?c=ez004_p";
		frm.submit();
	}
	
</script>
