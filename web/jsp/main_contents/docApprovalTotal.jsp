<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/jsp/common/inc/header.jsp"%>
    
<%
	Map<String, Object> paramMap = CommonUtil.collectParameters(request);
	String c = CommonUtil.isNull(paramMap.get("c"));
	String gridId = "g_"+c;

	String strMenuGb = CommonUtil.isNull(paramMap.get("menu_gb"));
	String menu_gb = CommonUtil.getMessage("CATEGORY.GB.09.GB."+strMenuGb);
	String[] arr_menu_gb = menu_gb.split(",");
	
	String odate = (String)request.getAttribute("ODATE");
	odate = odate.replace("/", "");
%>

<form id="f_s" name="f_s" method="post" onsubmit="return false;">
	<input type="hidden" id="menu_gb" 			name="menu_gb" value="<%= strMenuGb%>" />
	
	<input type='hidden' id='p_s_pdate' 		name='p_s_pdate'/>
	<input type='hidden' id='p_e_pdate' 		name='p_e_pdate'/>
	 
	<input type='hidden' id='data_center' 		name='data_center'/>
	<input type='hidden' id='p_dept_nm' 		name='p_dept_nm'/>
	<input type='hidden' id='p_sched_table' 	name='p_sched_table'/>
	
	<input type="hidden" id="p_scode_cd" 			name="p_scode_cd" />
	<input type="hidden" id="p_grp_depth" 			name="p_grp_depth" />
	<input type="hidden" id="p_app_search_gubun"	name="p_app_search_gubun" />
	<input type="hidden" id="p_app_nm"				name="p_app_nm" />
</form>

<table style='width:100%;height:100%;border:none;'>
	<tr style='height:10px;'>
		<td style='vertical-align:top;'>
			<h4 class="ui-widget-header ui-corner-all"  >
				<div id='t_<%=gridId %>' class='title_area' >
					<span><%=CommonUtil.isNull(CommonUtil.getMessage("CATEGORY.GB.09"))%> > <%=CommonUtil.isNull(CommonUtil.getMessage("CATEGORY.GB.09.SB.0900"))%></span>
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
					<th width="10%"><div class='cellTitle_kang2' style='min-width:120px;'>C-M</div></th>
					<td width="20%" style="text-align:left">
						<div class='cellContent_kang'>
						<select id="data_center_items" name="data_center_items" style="width:120px; height:21px;">							
								<option value="">선택</option>
								<c:forEach var="cm" items="${cm}" varStatus="status">
									<option value="${cm.scode_cd},${cm.scode_eng_nm}">${cm.scode_nm}</option>
								</c:forEach>
							</select>
						</div>
					</td>
									
					<th width="10%"><div class='cellTitle_kang2' style='min-width:120px;'>등록일자</div></th>
					
					<td width="20%" style="text-align:left">
						<div class='cellContent_kang' style='width:200px;'>
						<input type="text" name="s_pdate" id="s_pdate" value="<%=odate %>" class="input datepick" style="width:70px; height:21px;" maxlength="8" onclick="dpCalMin('s_pdate','yymmdd');" />
						 ~ <input type="text" name="e_pdate" id="e_pdate" value="<%=odate %>" class="input datepick" style="width:70px; height:21px;" maxlength="8" onclick="dpCalMin('e_pdate','yymmdd');" />
						</div>
					</td> 
					<th width="10%"><div class='cellTitle_kang2'></div></th>
					<td width="20%" style="text-align:left"></td>
					<td width="10%"></td>
				    </tr>
				    <tr>			
					<th><div class='cellTitle_kang2'>부서</div></th>
					<td style="text-align:left">
						<div class='cellContent_kang'>
							<input type="text" name="dept_nm" id="dept_nm" style="width:150px; height:21px;"/>
						</div>
					</td>
					
					<th><div class='cellTitle_kang2'>폴더</div></th>
					<td style="text-align:left">
						<div class='cellContent_kang'>
							<input type="text" name="table_nm" id="table_nm" style="width:120px; height:21px;" onkeydown="return false;" readonly/>&nbsp;
							<select name="sub_table_of_def" id="sub_table_of_def" style="width:120px;height:21px;display:none;">
								<option value="">전체</option>
							</select>
							<img id="btn_clear1" src="/images/sta2.png" style="width:16px;height:16px;vertical-align:middle;cursor:pointer;"/>
						</div>
					</td>
					
					<th width="10%"><div class='cellTitle_kang2'></div></th>
					<td width="20%" style="text-align:left"></td>
					
					<td style="text-align:right;">
						<span id="btn_search" style='margin:3px;'>검 색</span>
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
					{formatter:gridCellNoneFormatter,field:'data_center',id:'data_center',name:'C-M',width:120,minWidth:120,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
					,{formatter:gridCellNoneFormatter,field:'dept_nm',id:'dept_nm',name:'부서',width:120,minWidth:120,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
					,{formatter:gridCellNoneFormatter,field:'table_name',id:'table_name',name:'폴더',width:120,minWidth:120,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
			   		,{formatter:gridCellNoneFormatter,field:'doc_new_cnt',id:'doc_new_cnt',name:'등록',width:60,minWidth:60,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
			   		,{formatter:gridCellNoneFormatter,field:'doc_urg_cnt',id:'doc_urg_cnt',name:'긴급',width:60,minWidth:60,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
			   		,{formatter:gridCellNoneFormatter,field:'doc_mod_cnt',id:'doc_mod_cnt',name:'수정',width:60,minWidth:60,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
			   		,{formatter:gridCellNoneFormatter,field:'doc_del_cnt',id:'doc_del_cnt',name:'삭제',width:60,minWidth:60,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
			   		,{formatter:gridCellNoneFormatter,field:'doc_ord_cnt',id:'doc_ord_cnt',name:'수시',width:60,minWidth:60,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
			   		,{formatter:gridCellNoneFormatter,field:'doc_excel_cnt',id:'doc_excel_cnt',name:'엑셀등록',width:60,minWidth:60,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
			   		,{formatter:gridCellNoneFormatter,field:'doc_chg_cond_cnt',id:'doc_chg_cond_cnt',name:'상태변경',width:60,minWidth:60,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
			   		,{formatter:gridCellNoneFormatter,field:'total_cnt',id:'total_cnt',name:'TOTAL',width:60,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
			   		,{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'번호',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid',sortable:true}
			   	]
		,rows:[]
		,vscroll:false
	};

	$(document).ready(function(){
		
		viewGrid_1(gridObj,"ly_"+gridObj.id,{enableColumnReorder:true},'AUTO');
		/* setYears("yearbox");
		setYears("yearbox2");
		setMonths($("#monthbox"));
		setMonths($("#monthbox2"));  */
		
		//버튼
		$("#btn_search").button().unbind("click").click(function(){
			var data_center = $("#data_center_items").val();
			if (data_center == "") {
				alert("C-M 을 선택해 주세요.");
				return;
			}
			
			/* $("#p_year").val($("#yearbox").val());
			var month = $("#monthbox").val();
			//파라미터 자릿수를 맞춰줌.
			if (month.length == 1)
				month = "0"+month;
			$("#p_month").val(month);
			$("#p_dept_nm").val($("#dept_nm").val());
			
			$("#p_year2").val($("#yearbox2").val());
			var month = $("#monthbox2").val();
			//파라미터 자릿수를 맞춰줌.
			if (month.length == 1)
				month = "0"+month;
			$("#p_month2").val(month);
			$("#p_dept_nm").val($("#dept_nm").val());
			 
			if($("#p_year").val()+$("#p_month").val() > $("#p_year2").val()+$("#p_month2").val()) {
				alert("등록일자를 확인해주세요.");
				return;
			} */
			
			$("#p_dept_nm").val($("#dept_nm").val());

			$("#p_s_pdate").val($("#s_pdate").val());
			$("#p_e_pdate").val($("#e_pdate").val());
			
// 			if($("#p_s_pdate").val() > $("#p_e_pdate").val()) {
// 				alert("등록일자를 확인해주세요.");
// 				return;
// 			} 
			
			if ( $("#p_s_pdate").val() != "" && $("#p_e_pdate").val() != "" ) {
				
				// 날짜 기간 체크
				if ( $("#p_s_pdate").val() > $("#p_e_pdate").val() ) {
					alert("일자의 FROM ~ TO를 확인해 주세요.");
					return;
				}
				
				// 날짜 정합성 체크
				if(!isValidDate($("#p_s_pdate").val()) || !isValidDate($("#p_e_pdate").val())){ 
					alert("잘못된 날짜입니다."); 
					return;
				}
			}
		 
			setTimeout(function(){
				docApprovalTotal();
			}, 500);
		});
		
		// 부서 엔터
		$('#dept_nm').unbind('keypress').keypress(function(e) {
			if(e.keyCode==13){
				$("#btn_search").trigger("click");
			}
		});
		
		$("#btn_excel").button().unbind("click").click(function(){
			var data_center = $("#data_center_items").val();
			if (data_center == "") {
				alert("C-M 을 선택해 주세요.");
				return;
			}
			
			goExcel();
		});
		
		var S_TAB 			= "<%=S_TAB%>";
		var session_dc_code	= "<%=S_D_C_CODE%>";
		//C-M
		if(session_dc_code != "") { // 개인정보에 C-M이 등록되어 있을경우
			$("#data_center_items").val(session_dc_code);
			$("#data_center").val(session_dc_code);
		}else { // 개인정보에 C-M이 등록이 되어있지 않을경우 -> C-M 콤보박스에서 첫번째값 선택
			$("#data_center_items option:eq(1)").prop("selected", true);
			$("#data_center").val($("select[name='data_center_items']").val());
		}
		
		$("#data_center_items").change(function(){
			//폴더 초기화
			$("#table_nm").val("");
			$("#p_sched_table").val("");
			
			$("#data_center").val($(this).val());
		});
		
		//폴더
		if(S_TAB != '') {
			$("#table_nm").val(S_TAB);
			$("#p_sched_table").val(S_TAB);
		}
		
		$("#table_nm").click(function(){
			var data_center = $("#data_center_items").val();
			var select_table = $("input[name='table_nm']").val();
			if (data_center == "") {
				alert("C-M 을 선택해 주세요.");
				return;
			} else {
				searchPoeTabForm(select_table);
			}
		});
		
		//폴더 삭제 아이콘
		$("#btn_clear1").unbind("click").click(function(){
			$("#p_sched_table").val("");
			$("#table_nm").val("");
			
			$("select[name='sub_table_of_def'] option").remove();
			$("select[name='sub_table_of_def']").append("<option value=''>--선택--</option>");
			
			document.getElementById('sub_table_of_def').style.display = 'none';
		});
		
		
	});

/* 	function setYears(yearbox) {
		var today = new Date();
		var curY = today.getFullYear();

		$("#"+yearbox).children("option").remove();
		for(var y = curY-4; y <= curY; y++) {
			$("#"+yearbox).append("<option value="+y+">"+y+"년"+"</option>");
		}
		
		$("#"+yearbox).val(curY).prop("selected", true);
	}

	function setMonths(monthbox) {
		var today = new Date();
		var curM = today.getMonth()+1;
		
		monthbox.children("option").remove();
		for (var m = 1 ; m <= 12; m++) {
			monthbox.append("<option value="+m+">"+m+"월"+"</option>");
		}
		
		monthbox.val(curM).prop("selected", true);
	}
	 */
	
	
	function docApprovalTotal() {
		 
		// 스마트폴더의 서브테이블 검색 셋팅
        if( $("select[name='sub_table_of_def']").val() != "") {
        	var sched_table = $("input[name='p_sched_table']").val();
			var sub_table   = $("select[name='sub_table_of_def']").val();
			
			if(sub_table == 'search_all'){
				sub_table = "";
				var sub_table_options = document.getElementById("sub_table_of_def").options;
				for(var i = 1; i < sub_table_options.length; i++) {
					sub_table += "," + sub_table_options[i].value;
				}
				if(!sched_table.includes(sub_table)){
					$("#f_s").find("input[name='p_sched_table']").val(sched_table + sub_table);
				}
			}else {
				$("#f_s").find("input[name='p_sched_table']").val(sub_table);
			}
		}

		try{viewProgBar(true);}catch(e){}
		
		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=docApprovalTotal&itemGubun=2';
		
		var xhr = new XHRHandler(url, f_s, function(){
			
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
						
						var data_center			= $(this).find("data_center").text();
						var dept_nm 			= $(this).find("dept_nm").text();
						var table_name 			= $(this).find("table_name").text();
						var doc_new_cnt 		= $(this).find("doc_new_cnt").text();
						var doc_mod_cnt 		= $(this).find("doc_mod_cnt").text();
						var doc_del_cnt 		= $(this).find("doc_del_cnt").text();
						var doc_ord_cnt 		= $(this).find("doc_ord_cnt").text();
						var doc_excel_cnt 		= $(this).find("doc_excel_cnt").text();
						var doc_chg_cond_cnt	= $(this).find("doc_chg_cond_cnt").text();
						var doc_urg_cnt			= $(this).find("doc_urg_cnt").text();
						var total_cnt			= $(this).find("total_cnt").text();
						var smart_job_yn		= $(this).find("smart_job_yn").text();
						
						var smart_folder = "";
						if ( smart_job_yn == "Y" ) {
							smart_folder = "<img src='/imgs/smart_folder.png' style='vertical-align:middle;' width='20' height='20'> ";
						}
						
						rowsObj.push({
							'grid_idx':i+1
							,'data_center': data_center
							,'dept_nm' : dept_nm
							,'table_name': smart_folder + table_name
							,'doc_new_cnt': doc_new_cnt
							,'doc_mod_cnt': doc_mod_cnt
							,'doc_del_cnt': doc_del_cnt
							,'doc_ord_cnt': doc_ord_cnt
							,'doc_excel_cnt': doc_excel_cnt
							,'doc_chg_cond_cnt': doc_chg_cond_cnt
							,'doc_urg_cnt': doc_urg_cnt
							,'total_cnt': total_cnt
							,'smart_job_yn': smart_job_yn
						});
					});						
				}
				
				gridObj.rows = rowsObj;
				setGridRows(gridObj);

				//컬럼 자동 조정 기능
				$('body').resizeAllColumns();
			});
			
			try{viewProgBar(false);}catch(e){}
		}
		, null );
		
		xhr.sendRequest();
	}
	
	function selectTable(eng_nm, desc, user_daily, grp_cd, task_type, table_id){
		$("#table_nm").val(eng_nm);
		
		dlClose("dl_tmp1");
		
		$("#p_sched_table").val(eng_nm);
		
		//스마트폴더 초기화
		$("select[name='sub_table_of_def'] option").remove();
		$("select[name='sub_table_of_def']").append("<option value=''>--선택--</option>");
        
		//서브폴더 조회
		document.getElementById('sub_table_of_def').style.display = 'none';
		
    	var arr_task_type = task_type.split(",");
    	var arr_table_id  = table_id.split(",");
    	var smart_table_id = new Array(0);
    	
    	for(var i = 0; i < arr_task_type.length; i++) {
    		if(arr_task_type[i] == "SMART Table"){
    			smart_table_id.push(arr_table_id[i]);
    		}
    	}
    	if(!eng_nm.includes(",") && smart_table_id.length == 1){ // 조회할 폴더가 스마트폴더 한개일때 서브폴더 조회 필터 활성화
    		document.getElementById('sub_table_of_def').style.display = 'inline';
			getSubTableList("sub_table_of_def", smart_table_id);
    	}else if(eng_nm.includes(",") && smart_table_id.length > 0 ){ // 조회할 폴더가 스마트폴더를 포함하고 있을때 서브폴더 조회 필터 비활성화
    		getSubTableList("sub_table_of_def", smart_table_id);
    	}
	}
	
	function goExcel() {
		var frm = document.f_s;
		
		try{viewProgBar(true);}catch(e){}
		
		frm.action = "<%=sContextPath %>/tWorks.ez?c=docApprovalTotalExcel";
		frm.target = "if1";
		frm.submit();
		
		try{viewProgBar(false);}catch(e){}
	}
</script>