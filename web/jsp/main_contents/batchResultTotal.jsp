<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/jsp/common/inc/header.jsp"%>

<%
	Map<String, Object> paramMap = CommonUtil.collectParameters(request);
	String c = CommonUtil.isNull(paramMap.get("c"));
	String gridId = "g_"+c;
	List dataCenterList = (List)request.getAttribute("dataCenterList");
	
	String menu_gb = CommonUtil.getMessage("CATEGORY.GB.04.GB."+CommonUtil.isNull(paramMap.get("menu_gb")));
	String[] arr_menu_gb = menu_gb.split(",");
	
	// 세션값 가져오기.
	String strSessionDcCode 	= S_D_C_CODE;	
	String strSessionApp        = S_APP;
	String strSessionGrp        = S_GRP;
	
%>

<form id="f_s" name="f_s" method="post" onsubmit="return false;">	
	<input type='hidden' id='data_center_code' name='data_center_code'/>
	<input type='hidden' id='data_center' name='data_center'/>
	<input type='hidden' id='active_net_name' name='active_net_name' value="${active_net_name}" />
	<input type='hidden' id='p_application_of_def' name='p_application_of_def'/>
	<input type='hidden' id='p_group_name_of_def' name='p_group_name_of_def'/>
	<input type='hidden' id='p_search_gubun' name='p_search_gubun'/>
	<input type='hidden' id='p_search_text' name='p_search_text'/>
	<input type='hidden' id='searchType' name='searchType'/>
	<input type='hidden' id='p_s_odate' name='p_s_odate'/>
	<input type='hidden' id='p_e_odate' name='p_e_odate'/>
	<input type='hidden' id='p_status' name='p_status'/>
	<input type='hidden' id='p_search_node_id' name='p_search_node_id'/>
	<input type='hidden' id='p_node_id' name='p_node_id'/>
	
	<input type="hidden" name="odate" id="odate"/>
	<input type="hidden" name="order_id" id="order_id"/>
	<input type="hidden" name="job_name" id="job_name"/>
	<input type="hidden" name="status" id="status"/>
	<input type="hidden" name="job" id="job"/>
	<input type="hidden" name="graph_depth" id="graph_depth"/>
	<input type="hidden" name="order_36_id" id="order_36_id"/>
	<input type="hidden" name="end_date" id="end_date"/>
	<input type="hidden" name="rerun_count" id="rerun_count"/>
	<input type="hidden" name="memname" id="memname"/>
	<input type="hidden" name="total_rerun_count" id="total_rerun_count"/>
	<input type="hidden" name="node_id" id="node_id"/>
	<input type="hidden" name="active_gb" id="active_gb"/>
	<input type="hidden" name="page_gubun" id="page_gubun" value="active_job_list" />	<!-- 이 항목이 있어야 수정화면이 열림 -->
	<input type="hidden" name="menu_gb" id="menu_gb" value="${paramMap.menu_gb}" />
	<input type="hidden" name="p_mcode_nm" id="p_mcode_nm" />
	<input type="hidden" name="p_scode_nm" id="p_scode_nm" />
	
	<input type="hidden" name="p_scode_cd" id="p_scode_cd" />
	<input type="hidden" name="p_grp_depth" id="p_grp_depth" />
	<input type="hidden" name="p_app_nm" id="p_app_nm" />
	<input type="hidden" name="p_app_search_gubun" id="p_app_search_gubun" />
</form>

<table style='width:100%;height:100%;border:none;'>
	<tr style='height:10px;'>
		<td style='vertical-align:top;'>
			<h4 class="ui-widget-header ui-corner-all"  >
				<div id='t_<%=gridId %>' class='title_area' >
					<span><%=CommonUtil.isNull(arr_menu_gb[0]) %></span>
				</div>
			</h4>
		</td>
	</tr>
	<tr style='height:10px;'>
		<td style='vertical-align:top;'>
			<form name="frm1" id="frm1" method="post">
			<table style='width:100%;border-width:1px; border-color:gray; border-style:double;'>
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
									
					<th width="10%"><div class='cellTitle_kang2'>어플리케이션(L3)</div></th>
					<td width="20%" style="text-align:left">
						<div class='cellContent_kang'>
							<input type="text" name="app_nm" id="app_nm" style="width:80%; height:21px;" readOnly/>&nbsp;<img id="btn_clear1" src="/images/sta2.png" style="width:16px;height:16px;vertical-align:middle;cursor:pointer;"/>
							<input type="hidden" name="application_of_def" id="application_of_def" />
						</div>
					</td>
					
					<th width="10%"><div class='cellTitle_kang2'>어플리케이션(L4)</div></th>
					<td width="20%" style="text-align:left">
						<div class='cellContent_kang'>
						<select id="group_name_of_def" name="group_name_of_def" style="width:98%; height:21px;">
							<option value=''>--선택--</option>
						</select>
						</div>
					</td>
				</tr>				
				<tr>
					
					<th width="10%"><div class='cellTitle_kang2'>ODATE</div></th>
					<td width="20%" style="text-align:left">
						<div class='cellContent_kang'>
						<input type="text" name="s_odate" id="s_odate" value="${ODATE}" class="input datepick" style="width:96%; height:21px;" maxlength="10" readOnly/>
						<!--input type="text" name="e_odate" id="e_odate" value="${ODATE}" class="input datepick" style="width:75px; height:21px;" maxlength="10" readOnly/ -->
						</div>
					</td>
					
					<th width="10%"><div class='cellTitle_kang2'>대그룹</div></th>
					<td width="20%" style="text-align:left">
						<div class='cellContent_kang'>
						<select id="mcode_nm" name="mcode_nm" style="width:98%; height:21px;">
							<option value=''>--선택--</option>	
							<c:forEach var="mcode" items="${mcodeList}" varStatus="s">
								<option value="${mcode.mcode_nm}">${mcode.mcode_desc}</option>
							</c:forEach>						
						</select>
						</div>
					</td>
					
					<th width="10%"><div class='cellTitle_kang2'>소그룹</div></th>
					<td width="20%" style="text-align:left">
						<div class='cellContent_kang'>
							<input type="text" name="scode_nm" id="scode_nm" style="width:85%; height:21px;" readOnly/>
							&nbsp;<img id="btn_clear3" src="/images/sta2.png" style="width:16px;height:16px;vertical-align:middle;cursor:pointer;"/>
						</div>
					</td>					
				</tr>
				<tr>
					<td colspan="6" style="text-align:right;">
						<span id="btn_search" style='display:none;margin:3px;'>검 색</span>
					</td>
				</tr>					
			</table>
			</form>
		</td>
	</tr>
	<tr>
		<td id='ly_<%=gridId %>' style='vertical-align:top;' >
			<div id="<%=gridId %>" class="ui-widget-header ui-corner-all" ></div>
		</td>
	</tr>
	<!-- <tr style='height:10px;'>
		<td style='vertical-align:top;'>
			<h4 class="ui-widget-header ui-corner-all" >
				<div align='right' class='btn_area' >
					<div id='ly_total_cnt' style='padding-top:5px;float:left;'></div>
					<span id="btn_down">엑셀</span>
				</div>
			</h4>
		</td>
	</tr> -->
</table>
<script>
		
	var gridObj = {
		id : "<%=gridId %>"
		,colModel:[
					
					{formatter:gridCellNoneFormatter,field:'SYSTEM_GB',id:'SYSTEM_GB',name:'대그룹',width:100,headerCssClass:'cellCenter',cssClass:'cellCenter'}	   		
			   		,{formatter:gridCellNoneFormatter,field:'MCODE_NM',id:'MCODE_NM',name:'중그룹',width:130,headerCssClass:'cellCenter',cssClass:'cellCenter'}
			   		,{formatter:gridCellNoneFormatter,field:'TOTAL_CNT',id:'TOTAL_CNT',name:'전체작업수',width:100,headerCssClass:'cellCenter',cssClass:'cellCenter'}
			   		,{formatter:gridCellNoneFormatter,field:'RUNNING_CNT',id:'RUNNING_CNT',name:'실행중',width:100,headerCssClass:'cellCenter',cssClass:'cellCenter'}
			   		,{formatter:gridCellNoneFormatter,field:'SUCCESS_CNT',id:'SUCCESS_CNT',name:'성공',width:100,headerCssClass:'cellCenter',cssClass:'cellCenter'}
			   		,{formatter:gridCellNoneFormatter,field:'FAIL_CNT',id:'FAIL_CNT',name:'오류',width:100,headerCssClass:'cellCenter',cssClass:'cellCenter'}
			   		,{formatter:gridCellNoneFormatter,field:'WAIT_CNT',id:'WAIT_CNT',name:'대기',width:100,headerCssClass:'cellCenter',cssClass:'cellCenter'}
			   		,{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'번호',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid',sortable:true}			   			   

			   	]
		,rows:[]
		,vscroll:false
	};
	
	$(document).ready(function(){
		
		var session_dc_code	= "<%=strSessionDcCode%>";
		var session_app	= "<%=strSessionApp%>";
		var session_grp	= "<%=strSessionGrp%>";
		
		$("#btn_search").show();
						
		var frm = document.frm1;
		var data_center = "";
		if( null != document.getElementById('data_center_items') ){
			var sTmp = document.getElementById('data_center_items').value ;
			var aTmp = sTmp.split(",");
						
			$("#f_s").find("input[name='data_center_code']").val(aTmp[0]);
			$("#f_s").find("input[name='data_center']").val(aTmp[1]);
			$("#f_s").find("input[name='active_net_name']").val(aTmp[2]);
			
			data_center = aTmp[1];
		}
		
		$("#f_s").find("input[name='p_application_of_def']").val($("#frm1").find("select[name='application_of_def'] option:selected").val());
		$("#f_s").find("input[name='p_group_name_of_def']").val($("#frm1").find("select[name='group_name_of_def'] option:selected").val());	
		$("#f_s").find("input[name='p_odate']").val($("#frm1").find("input[name='odate']").val());
		
		//TAB
		//setSelectItemList('<%=sContextPath %>/common.ez?c=cData&itemType=select&itemGb=searchItemList&searchType=application_of_defList&data_center='+data_center);
		
		viewGrid_1(gridObj,"ly_"+gridObj.id);
		//batchResultTotal();		
		
		$("select[name='data_center_items']").val(session_dc_code);
		$("#f_s").find("input[name='data_center']").val(session_dc_code);
		$("input[name='app_nm']").val(session_app);
		$("#f_s").find("input[name='application_of_def']").val(session_app);
		selectApplication(session_app,session_app);
		setTimeout(function(){
			$("select[name='group_name_of_def']").val(session_grp).prop("seleted", true);	
		}, 500);
		
		$("#data_center_items").change(function(){
			
			//초기화
			$("#app_nm").val("");
			$("#application_of_def").val("");
			
			$("select[name='group_name_of_def'] option").remove();
			$("select[name='group_name_of_def']").append("<option value=''>--선택--</option>");	
			
			$("select[name='node_id'] option").remove();
			$("select[name='node_id']").append("<option value=''>--선택--</option>");
			
			var data_center_items = $(this).val();
			var arr_dt = data_center_items.split(",");
			if($(this).val() != ""){
				$("#f_s").find("input[name='data_center']").val(arr_dt[1]);				
				//getAppGrpCodeList(arr_dt[0], "1", "", "application_of_def","");	
			}
		});
		
		$("#btn_search").button().unbind("click").click(function(){
			
			var data_center_items = $("select[name='data_center_items'] option:selected").val();
			var application_of_def = $("input[name='application_of_def']").val();
			var group_name_of_def = $("select[name='group_name_of_def'] option:selected").val();
						
			if(data_center_items == ""){
				alert("C-M 을 선택해 주세요.");
				return;
			}
						
			/*if(application_of_def == ""){
				alert("애플리케이션을 선택해 주세요.");
				return;
			}
			
			if(group_name_of_def == ""){
				alert("그룹을 선택해 주세요.");
				return;
			}*/
						
			//$("#f_s").find("input[name='p_search_gubun']").val($("#frm1").find("select[name='search_gubun'] option:selected").val());
			//$("#f_s").find("input[name='p_search_text']").val($("#frm1").find("input[name='search_text']").val());			
			//$("#f_s").find("input[name='p_status']").val($("#frm1").find("select[name='status'] option:selected").val());
			$("#f_s").find("input[name='p_s_odate']").val($("#frm1").find("input[name='s_odate']").val());
			$("#f_s").find("input[name='p_e_odate']").val($("#frm1").find("input[name='e_odate']").val());
			//$("#f_s").find("input[name='p_node_id']").val(arr_node_id[1]);
			$("#f_s").find("input[name='order_id']").val("");
			
			var mcode_nm = $("#frm1").find("select[name='mcode_nm'] option:selected").val();
			
			//var arr_mcode_nm = mcode_nm.split(",");
			$("#f_s").find("input[name='p_mcode_nm']").val(mcode_nm);
			//$("#f_s").find("input[name='p_scode_nm']").val($("#frm1").find("input[name='scode_nm']").val());
			batchResultTotal();
		});
		
		$("#mcode_nm").change(function(){
			$("#scode_nm").val("");	
			$("#f_s").find("input[name='p_scode_nm']").val("");
		});
		
		$("#scode_nm").click(function(){
			
			var mcode_nm = $("select[name='mcode_nm'] option:selected").val();
			//var arr_mcode_nm = mcode_nm.split(",");
			if(mcode_nm == ""){
				alert("대그룹을 선택해 주세요.");
				return;
			}
			
			popScodeSearchForm(mcode_nm);
		});
		
		$("#s_odate").addClass("ime_readonly").unbind('click').click(function(){
			dpCalMin(this.id,'yymmdd');
		});
		$("#app_nm").click(function(){
			var data_center = $("select[name='data_center_items'] option:selected").val();
			
			if(data_center == ""){
				alert("C-M 을 선택해 주세요.");
				return;
			}else{
				searchPoeAppForm();
			}		
		});
		
		$("#data_center_items").change(function(){		//C-M
			setSearchItemList('sched_tableList', 'data_center_items');	
		});
				
		$("#application_of_def").change(function(){		//GRP
					
			setSearchItemList('group_name_of_defList', 'application_of_def');
		});
		
		$("#btn_down").button().unbind("click").click(function(){
			goExcel();
		});
		
		$("#odate").addClass("ime_readonly").unbind('click').click(function(){
			dpCalMin(this.id,'yymmdd');
		});
		$("#group_name_of_def").change(function(){
			
			$("select[name='node_id'] option").remove();
			$("select[name='node_id']").append("<option value=''>--선택--</option>");
			
			var group_name_of_def = $("select[name='group_name_of_def'] option:selected").val();	
			
			var arr_group_name_of_def = group_name_of_def.split(",");
			$("#f_s").find("input[name='p_group_name_of_def']").val(arr_group_name_of_def[1]);
									
			mHostList(arr_group_name_of_def[1]);
		});			
		
		$("#btn_clear1").unbind("click").click(function(){
			$("#f_s").find("input[name='p_application_of_def']").val("");
			$("#f_s").find("input[name='p_group_name_of_def']").val("");
			
			$("#frm1").find("input[name='app_nm']").val("");
			$("#frm1").find("input[name='application_of_def']").val("");
					
			$("select[name='group_name_of_def'] option").remove();
			$("select[name='group_name_of_def']").append("<option value=''>--선택--</option>");
			
			$("select[name='node_id'] option").remove();
			$("select[name='node_id']").append("<option value=''>--선택--</option>");
		});
		
		$("#btn_clear2").unbind("click").click(function(){
			$("#frm1").find("input[name='search_text']").val("");
		});
		$("#btn_clear3").unbind("click").click(function(){
			$("#frm1").find("input[name='scode_nm']").val("");
			$("#f_s").find("input[name='p_scode_nm']").val("");
		});
	});
	
	function selectApplication(eng_nm, desc){
		
		$("#app_nm").val(desc);
		$("#application_of_def").val(eng_nm);	
		
		dlClose("dl_tmp1");
		
		//검색의 애플리케이션에 값을 셋
				$("#f_s").find("input[name='p_application_of_def']").val("'"+eng_nm+"'");
		$("#f_s").find("input[name='p_group_name_of_def']").val("");
		
		//그룹을 검색		
		getAppGrpCodeList("", "2", "", "group_name_of_def","'"+eng_nm+"'");
		
	}
	
	function selectApplication2(eng_nm, desc){
		var app_nm = $("#app_nm").val();
		if($("#application_of_def").val() == ""){
			$("#app_nm").val(desc);
			$("#application_of_def").val(eng_nm);	
		}else{
			if(app_nm.indexOf("[") != -1){
				$("#app_nm").val(desc);
				$("#application_of_def").val(eng_nm);	
			}else{
				$("#app_nm").val($("#app_nm").val()+", "+desc);
				$("#application_of_def").val($("#application_of_def").val()+", "+eng_nm);	
			}
			
		}
		
		
		dlClose("dl_tmp1");
		
		//검색의 애플리케이션에 값을 셋
		
		if($("#f_s").find("input[name='p_application_of_def']").val() == ""){
			$("#f_s").find("input[name='p_application_of_def']").val(eng_nm);
			$("#f_s").find("input[name='p_group_name_of_def']").val("");
		}else{
			if(app_nm.indexOf("[") != -1){
				$("#f_s").find("input[name='p_application_of_def']").val(eng_nm);
				$("#f_s").find("input[name='p_group_name_of_def']").val("");
			}else{
				$("#f_s").find("input[name='p_application_of_def']").val($("#f_s").find("input[name='p_application_of_def']").val()+", "+eng_nm);
				$("#f_s").find("input[name='p_group_name_of_def']").val("");
				eng_nm = $("#f_s").find("input[name='p_application_of_def']").val();
			}
			
		}
		
		//그룹을 검색		
		getAppGrpCodeList("", "2", "", "group_name_of_def",eng_nm);
		
	}
	
	function setSearchItemList(type, nm) {

		var frm = document.frm1;
		var data_center = "";
		var item_id = "";
		
		if( null != document.getElementById('data_center_items') ) {
			var sTmp = document.getElementById('data_center_items').value ;
			var aTmp = sTmp.split(",");
			
			$("#f_s").find("input[name='data_center_code']").val(aTmp[0]);
			$("#f_s").find("input[name='data_center']").val(aTmp[1]);
			$("#f_s").find("input[name='active_net_name']").val(aTmp[2]);
			
			data_center = aTmp[1];
		}

		$("#f_s").find("input[name='searchType']").val(type);
	
		//TAB
		var sched_table = $("#frm1").find("select[name='sched_table'] option:selected").val();
		var application_of_def = $("#frm1").find("select[name='application_of_def'] option:selected").val();
		
		//alert(nm);
		if(nm == "application_of_def"){
			setSelectItemList('<%=sContextPath %>/common.ez?c=cData&itemType=select&itemGb=searchItemList&searchType='+type+'&application_of_def='+application_of_def+'&data_center='+data_center);
		}else{
			setSelectItemList('<%=sContextPath %>/common.ez?c=cData&itemType=select&itemGb=searchItemList&searchType='+type+'&data_center='+data_center);
		}
	}
	
	function fn_app_set(table_name) {

		
		var frm = document.frm1;

		// 해당 테이블이 스마트테이블인지 확인.
		var xhr 		= "";
	 	var result_text = "";
	 	
	 	var url = "<%=sContextPath%>/tWorks.ez?c=ez029&table_name="+table_name;
	 	var application_of_def = $("#frm1").find("select[name='application_of_def'] option:selected").val();
	 	
	 	if (window.ActiveXObject) {
	  		xhr = new ActiveXObject("Microsoft.XMLHTTP");
	 	} else if (window.XMLHttpRequest) {
	  		xhr = new XMLHttpRequest();
	 	}

	 	xhr.open("GET", url, true); // POST or GET. true : 비동기 처리용 == Ajax 스타일, false : 동기 처리용 = 일반적인 스타일

	 	xhr.onreadystatechange = function() // 비동기 처리용 callback 함수 : 서버에서 처리가 끝나면 불리는 함수
	 	{
	  		if(xhr.readyState == 4) {
	  			
	   			if(xhr.status == 200) {

	    			result_text = xhr.responseText; // 임의의 문자열이 전송되어 온다.

	    			// 앞뒤 공백 제거.
	    			result_text = result_text.replace(/^\s+|\s+$/g,"");

	    			var arrS, table_type, app, grp;
	    			
	    			// 스마트 테이블일 경우.
	    			if ( result_text != "" ) {
	    				arrS = result_text.split(",");
	    				table_type 	= arrS[0];
	    				app 		= arrS[1];
	    				grp 		= arrS[2];

	    				if ( table_type == 2 ) {

	    					// 서브 테이블 조회.
	    					var type = "sub_table_of_defList";
	    					var data_center = $("#f_s").find("input[name='data_center']").val();
	    					setSelectItemList('<%=sContextPath %>/common.ez?c=cData&itemType=select&itemGb=searchItemList&searchType='+type+'&data_center='+data_center);

	    					var application_select 	= document.getElementById("application_of_def");
	    					var group_name_select 	= document.getElementById("group_name_of_def");

	    					application_select.innerHTML 	= "";
	    					application_select.options[0] 	= new Option("--전체--", "");
	    					application_select.options[1] 	= new Option(app, app);

	    					group_name_select.innerHTML 	= "";
	    					group_name_select.options[0] 	= new Option("--전체--", "");
	    					group_name_select.options[1] 	= new Option(grp, grp);		
	    				}
	    				
	    			} else {

	    				// 어플리케이션 조회.						
						var type = "application_of_defList";
    					var data_center = $("#f_s").find("input[name='data_center']").val();
    					setSelectItemList('<%=sContextPath %>/common.ez?c=cData&itemType=select&itemGb=searchItemList&searchType='+type+'&application_of_def='+application_of_def+'&data_center='+data_center);
	    			}
	   			}
	  		}
	 	};
	 	     
	 	xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded;charset=EUC-KR"); // UTF-8	
	 	xhr.send("");
	}
	
	function batchResultTotal(){
		
		try{viewProgBar(true);}catch(e){}
		
		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=activeJobCntList';
		
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
								
								var system_gb = $(this).find("SYSTEM_GB").text();
								var mcode_nm = $(this).find("MCODE_NM").text();
								var total_cnt = $(this).find("TOTAL_CNT").text();
								var running_cnt = $(this).find("RUNNING_CNT").text();
								var wait_cnt = $(this).find("WAIT_CNT").text();
								var success_cnt = $(this).find("SUCCESS_CNT").text();
								var fail_cnt = $(this).find("FAIL_CNT").text();
								
								rowsObj.push({
									'grid_idx':i+1
									,'SYSTEM_GB': system_gb
									,'MCODE_NM': mcode_nm
									,'TOTAL_CNT': total_cnt
									,'RUNNING_CNT': running_cnt									
									,'WAIT_CNT': wait_cnt
									,'SUCCESS_CNT': success_cnt
									,'FAIL_CNT': fail_cnt
								});
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

	function goExcel(){
		
		var frm = document.f_s;
		
		try{viewProgBar(true);}catch(e){}
		
		frm.action = "<%=sContextPath %>/mEm.ez?c=ez005_excel";
		frm.target = "if1";
		frm.submit();
		
		try{viewProgBar(false);}catch(e){}
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
	
	//서버내역 가져오기
	function mHostList(grp_nm){		
	
		try{viewProgBar(true);}catch(e){}
				
		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=mHostList&itemGubun=2&grp_nm='+grp_nm;
		
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
							$("select[name='node_id'] option").remove();
							$("select[name='node_id']").append("<option value=''>--선택--</option>");	
						}else{
							$("select[name='node_id'] option").remove();
							$("select[name='node_id']").append("<option value=''>--선택--</option>");			
							
							items.find('item').each(function(i){						
							
								var host_cd = $(this).find("HOST_CD").text();								
								var node_id = $(this).find("NODE_ID").text();
								var node_nm = $(this).find("NODE_NM").text();
								
								var all_cd = host_cd+","+node_id;
								var all_nm = node_nm+"("+node_id+")";
																
								$("select[name='node_id']").append("<option value='"+all_cd+"'>"+all_nm+"</option>");
								
							});						
						}
												
					});
					try{viewProgBar(false);}catch(e){}
				}
		, null );
		
		xhr.sendRequest();
	}
	
	function selectApplication3(scode_nm, desc){
		var s_nm = $("#scode_nm").val();
		if(s_nm == ""){
			$("#scode_nm").val(desc);	
		}else{
			$("#scode_nm").val("");
			$("#scode_nm").val(desc);
		}
		
		
		dlClose("dl_tmp1");
		
		//검색의 애플리케이션에 값을 셋

		if($("#f_s").find("input[name='p_scode_nm']").val() == ""){
			$("#f_s").find("input[name='p_scode_nm']").val(scode_nm);
		}else{
			$("#f_s").find("input[name='p_scode_nm']").val("");
			$("#f_s").find("input[name='p_scode_nm']").val(scode_nm);
			scode_nm = $("#f_s").find("input[name='p_scode_nm']").val();
		}
		
	}

</script>
