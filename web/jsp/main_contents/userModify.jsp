<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/jsp/common/inc/header.jsp"%>

<c:set var="duty_gb_cd" 			value="${fn:split(DUTY_GB_CD,',')}"/>
<c:set var="duty_gb_nm" 			value="${fn:split(DUTY_GB_NM,',')}"/>
<c:set var="dept_gb_cd" 			value="${fn:split(DEPT_GB_CD,',')}"/>
<c:set var="dept_gb_nm" 			value="${fn:split(DEPT_GB_NM,',')}"/>
<c:set var="user_gb_cd" 			value="${fn:split(USER_GB_CD,',')}"/>
<c:set var="user_gb_nm" 			value="${fn:split(USER_GB_NM,',')}"/>
<c:set var="user_appr_gb_cd" 		value="${fn:split(USER_APPR_GB_CD,',')}"/>
<c:set var="user_appr_gb_nm" 		value="${fn:split(USER_APPR_GB_NM,',')}"/>

<%
	Map<String, Object> paramMap = CommonUtil.collectParameters(request);
	
	String c = CommonUtil.isNull(paramMap.get("c"));
	String gridId = "g_"+c;	
	
	String menu_gb = CommonUtil.getMessage("CATEGORY.GB.08.GB.0801");
	String[] arr_menu_gb = menu_gb.split(",");
	
%>

<form id="f_s" name="f_s" method="post" onsubmit="return false;">	
	<input type='hidden' id='data_center_code' name='data_center_code'/>
	<input type='hidden' id='data_center' name='data_center'/>
	
	<input type="hidden" name="p_scode_cd" id="p_scode_cd" />
	<input type="hidden" name="p_message" id="p_message" />
	<input type="hidden" name="p_grp_depth" id="p_grp_depth" />
	<input type="hidden" name="p_app_nm" id="p_app_nm" />
	<input type="hidden" name="p_app_search_gubun" id="p_app_search_gubun" />
	<input type="hidden" name="p_modify" id="p_modify" value = 'Y' />
</form>

<form id="frm2" name="frm2" method="post" onsubmit="return false;">	
	<input type="hidden" name="user_cd" id="user_cd">
</form>

<form id="frm3" name="frm3" method="post" onsubmit="return false;">
	<input type="hidden" name="screenStatus" id="screenStatus">	
	<input type="hidden" name="user_cd" id="user_cd">
	<input type="hidden" name="user_id" id="user_id">
	<input type="hidden" name="pw_chk" 	id="pw_chk">
</form>

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
	<tr>
		<td style='vertical-align:top;'>
			<form id="frm1" name="frm1" method="post" onsubmit="return false;" >
				<input type="hidden" name="flag" value='user_udt' />
				<input type="hidden" name="user_cd" id="user_cd"/>
				<input type="hidden" name="user_id" id="user_id"/>
				<input type="hidden" name="user_nm" id="user_nm"/>
				<input type="hidden" name="dept_cd" id="dept_cd"/>
				<input type="hidden" name="duty_cd" id="duty_cd"/>
				<input type="hidden" name="user_appr_gb" id="user_appr_gb"/>
				<input type="hidden" name="del_yn" id="del_yn"/>
				<input type="hidden" name="retire_yn" value="N"/>
				<!-- 어플리케이션,그룹명을 코드 기반 조회로 변경하면서 이름 값 저장필요. -->
				<input type='hidden' id='application' name='application'/>
				<input type='hidden' id='group_name' name='group_name'/>
				
				<div class='ui-widget-header ui-corner-all'>
					<table style='width:100%;'>
						<tr>
							<td width="150px"></td>							
							<td width=""></td>
						</tr>
						<tr>
							<td>
								<div class='cellTitle_ez_right'>아이디</div>
							</td>
							<td>
								<div class='cellContent_kang'><span id='v_user_id'></span></div>								
							</td>							
						</tr>	
						<tr>
							<td>
								<div class='cellTitle_ez_right'>이 름</div>
							</td>
							<td>
								<div class='cellContent_kang'><span id="v_user_nm"></span></div>								
							</td>							
						</tr>	
						<tr>
							<td>
								<div class='cellTitle_ez_right'>이메일</div>
							</td>
							<td>
								<div class='cellContent_kang'><input type='text' name='user_email' id='user_email' style='width:160px;height:21px;'></div>
							</td>							
						</tr>
						<tr>
							<td>
								<div class='cellTitle_ez_right'>휴대폰번호</div>
							</td>
							<td>
								<div class='cellContent_kang'><input type='text' name='user_hp' id='user_hp' style='width:160px;height:21px;'></div>
							</td>							
						</tr>
						<tr>
							<td>
								<div class='cellTitle_ez_right'>내선번호</div>
							</td>
							<td>
								<div class='cellContent_kang'><input type='text' name='user_tel' id='user_tel' style='width:160px;height:21px;'></div>
							</td>							
						</tr>
						<tr>
							<td>
								<div class='cellTitle_ez_right'>구분</div>
							</td>
							<td>
								<div class='cellContent_kang'>
									<span id="user_gb"></span>
								</div>
							</td>
						</tr>
						<tr>
							<td>
								<div class='cellTitle_ez_right'>부서</div>
							</td>
							<td>
								<div class='cellContent_kang'>
									<span id="v_dept_nm"></span>
								</div>								
							</td>							
						</tr>
						<tr>
							<td>
								<div class='cellTitle_ez_right'>직책</div>
							</td>
							<td>
								<div class='cellContent_kang'>
									<span id="v_duty_nm"></span>
								</div>								
							</td>							
						</tr>
						<tr>
							<td>
								<div class='cellTitle_ez_right'>결재구분</div>
							</td>
							<td>
								<div class='cellContent_kang'>
									<span id="v_user_appr_gb"></span>
								</div>								
							</td>							
						</tr>
						<tr>
							<td>
								<div class='cellTitle_ez_right'>등록일</div>
							</td>
							<td>
								<div class='cellContent_kang'>
									<span id="v_ins_date"></span>
								</div>								
							</td>							
						</tr>		
						<!--tr>
							<td>
								<div class='cellTitle_kang2'>결재선관리</div>
							</td>
							<td>
								<div class='cellContent_kang'>
									<span id='btn_approval'>설정</span>
								</div>								
							</td>							
						</tr>		 -->
						<tr>
							<td>
								<div class='cellTitle_ez_right'>기본 C-M</div>
							</td>
							<td>
								<div class='cellContent_kang'>
									<select name='select_data_center_code' id='select_data_center_code' style='width:165px;height:27px;'>
										<option value="">--선택--</option>
										<c:forEach var="cm" items="${cm}" varStatus="status">
											<option value="${cm.scode_cd},${cm.scode_eng_nm}">${cm.scode_nm}</option>					
										</c:forEach>
									</select>
								</div>								
							</td>							
						</tr>
						<tr>
							<td>
								<div class='cellTitle_ez_right'>폴더</div>
							</td>
							<td>
								<div class='cellContent_kang'>
									<input type="text" name="table_nm" id="table_nm" style="width:160px; height:21px;" onkeydown="return false;" readonly/>&nbsp; <font color="red"></font>
									<img id="btn_clear1" src="/images/sta2.png" style="width:16px;height:16px;vertical-align:middle;cursor:pointer;"/>
									<input type="hidden" name="table_of_def" id="table_of_def" />
								</div> 
							</td>						
						</tr>
						<tr>
							<td>
								<div class='cellTitle_ez_right'>어플리케이션</div>
							</td>
							<td>
								<div class='cellContent_kang'>
							 		<select name="application_of_def" id="application_of_def" style="width:165px; height:21px;">
										<option value="">--선택--</option>
									</select>
								</div>
							</td>
						</tr>		
						<tr>
							<td>
								<div class='cellTitle_ez_right'>그룹</div>
							</td>
							<td>
								<div class='cellContent_kang'>
									<select id="group_name_of_def" name="group_name_of_def" style="width:165px; height:21px;">
										<option value=''>--선택--</option>
									</select> 
								</div>								
							</td>							
						</tr>				

						<tr>
							<td>
								<div class='cellTitle_ez_right'>대리결재자</div>
							</td>
							<td>
								<div class='cellContent_kang'>
									<input type='text' name='absence_user_nm' id='absence_user_nm' style='width:160px;height:21px;'>
									<input type='hidden' name='absence_user_cd' id='absence_user_cd'>&nbsp;<span id='btn_absence_del'>삭제</span>
								</div>								
							</td>							
						</tr>
						<tr>
							<td>
								<div class='cellTitle_ez_right'>대리결재사유</div>
							</td>
							<td>
								<div class='cellContent_kang'>
									<input type='text' name='absence_reason' id='absence_reason' style='width:160px;height:21px;'>
								</div>								
							</td>							
						</tr>	
						<tr>
							<td>
								<div class='cellTitle_ez_right'>대리결재기간</div>
							</td>
							<td>
								<div class='cellContent_kang'>
									<input type='text' name='absence_start_date' id='absence_start_date' class='input datepick' style='width:60px;height:21px;' readOnly>&nbsp;&nbsp;&nbsp;~&nbsp;&nbsp;
									<input type='text' name='absence_end_date' id='absence_end_date' class='input datepick' style='width:60px;height:21px;' readOnly>
								</div>								
							</td>							
						</tr>	

					</table>
				</div>
			</form>
		</td>
	</tr>
	<tr style='height:10px;'>
		<td style='vertical-align:top;'>
			<h4 class="ui-widget-header ui-corner-all" >
				<div align='right' class='btn_area'>
					<span id='pw_change'>비밀번호 변경</span>
					<span id='btn_ins'>저장</span>
				</div>
			</h4>
		</td>
	</tr>
</table>
<script>
	
	var arr_duty_gb_cd 		= new Array();
	var arr_duty_gb_nm 		= new Array();
	var arr_dept_gb_cd 		= new Array();
	var arr_dept_gb_nm 		= new Array();
	var arr_user_gb_cd		= new Array();
	var arr_user_gb_nm		= new Array();
	var arr_user_appr_gb_cd = new Array();
	var arr_user_appr_gb_nm = new Array();
	
	<c:forEach var="duty_gb_cd" items="${duty_gb_cd}" varStatus="s">
		var map_cd = {"cd":"${duty_gb_cd}"};
		arr_duty_gb_cd.push(map_cd);
	</c:forEach>
	<c:forEach var="duty_gb_nm" items="${duty_gb_nm}" varStatus="s">
		var map_nm = {"nm":"${duty_gb_nm}"};
		arr_duty_gb_nm.push(map_nm);
	</c:forEach>
	/////
	<c:forEach var="user_gb_cd" items="${user_gb_cd}" varStatus="s">
		var map_cd = {"cd":"${user_gb_cd}"};
		arr_user_gb_cd.push(map_cd);
	</c:forEach>
	<c:forEach var="user_gb_nm" items="${user_gb_nm}" varStatus="s">
		var map_nm = {"nm":"${user_gb_nm}"};
		arr_user_gb_nm.push(map_nm);
	</c:forEach>
	////
	<c:forEach var="dept_gb_cd" items="${dept_gb_cd}" varStatus="s">
		var map_cd = {"cd":"${dept_gb_cd}"};
		arr_dept_gb_cd.push(map_cd);
	</c:forEach>
	<c:forEach var="dept_gb_nm" items="${dept_gb_nm}" varStatus="s">
		var map_nm = {"nm":"${dept_gb_nm}"};
		arr_dept_gb_nm.push(map_nm);
	</c:forEach>
	
	<c:forEach var="user_appr_gb_cd" items="${user_appr_gb_cd}" varStatus="s">
		var map_cd = {"cd":"${user_appr_gb_cd}"};
		arr_user_appr_gb_cd.push(map_cd);
	</c:forEach>
	<c:forEach var="user_appr_gb_nm" items="${user_appr_gb_nm}" varStatus="s">
		var map_nm = {"nm":"${user_appr_gb_nm}"};
		arr_user_appr_gb_nm.push(map_nm);
	</c:forEach>

	var gridObj = {
		id : "<%=gridId %>"
		,colModel:[
	   		{formatter:gridCellNoneFormatter,field:'c_1',id:'c_1',name:'구분',width:120,headerCssClass:'cellCenter',cssClass:'cellCenter'}
	   		,{formatter:gridCellNoneFormatter,field:'c_2',id:'c_2',name:'내용',width:300,headerCssClass:'cellCenter',cssClass:'cellCenter'}
	   		
	   		,{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'grid_idx',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   	]
		,rows:[]
		,vscroll : <%=S_GRID_VSCROLL%>
		,rowHeight: 32
	};
	
	$(document).ready(function(){
		<c:forEach var="cm" items="${cm}" varStatus="status">
			var session_dc_code = "${cm.scode_cd},${cm.scode_eng_nm}";
		</c:forEach>
		$("select[name='select_data_center_code']").val(session_dc_code);
		
		//viewGrid_1(gridObj,"ly_"+gridObj.id);
		userInsertInfo("<%=S_USER_CD%>");		
		
		$("#pw_change").button().unbind("click").click(function(){
			userPassWordChagne("<%=S_USER_CD%>");
		});
		$("#btn_ins").button().unbind("click").click(function(){
			 goProc();
		});
		
		$("#btn_approval").button().unbind("click").click(function(){
			
			popupApprovalLine("<%=S_USER_CD%>");
		});
		
		$("#absence_start_date").addClass("ime_readonly").unbind('click').click(function(){
			//dpCalMin(this.id,'yymmdd');
			dpCalMinMax(this.id,'yymmdd','0');
		});
		
		$("#absence_end_date").addClass("ime_readonly").unbind('click').click(function(){
			//dpCalMin(this.id,'yymmdd');
			dpCalMinMax(this.id,'yymmdd','0');
		});	
		
		$("#btn_absence_del").button().unbind("click").click(function(){
			
			var frm = document.frm1;
			frm.absence_user_nm.value = "";
			frm.absence_user_cd.value = "";
			$("#frm1").find("input[name='absence_start_date']").val("");
			$("#frm1").find("input[name='absence_end_date']").val("");			
			$("#frm1").find("input[name='absence_reason']").val("");
		});
		
		//유저 검색시 팝업형태로 변경
// 		$('#absence_user_nm').unbind('keypress').keypress(function(e){
// 				getUserList($(this).val());
// 		}).unbind('keyup').keyup(function(e){
// 			if($('#absence_user_cd').val()!='' && $(this).data('sel_v') != $(this).val()){
// 				$('#absence_user_cd').val('');
// 				$(this).removeClass('input_complete');
// 			}
// 		});
		
		$('input[id^=absence_user_nm]').click(function(){
			goUserSearch(0);
		}).unbind('keyup').keyup(function(e){
			if($(this).val() != '' && (this).data('sel_v') != $(this).val()){
				$('#sel_v').val();
				$(this).removeClass('input_complete');
			}
		});

		//테이블 클릭 시
		$("#absence_user_nm").click(function(){
			getUserList($(this).val());
		});
		
		//테이블 클릭 시
		$("#table_nm").click(function(){
			var data_center = $("select[name='select_data_center_code'] option:selected").val();
			var select_table = $("input[name='table_nm']").val();

			if(data_center == ""){
				alert("C-M 을 선택해 주세요.");
				return;
			}else{
// 				poeTabForm(select_table);
				searchPoeTabForm(select_table);
// 				$("#p_app_eng_nm").val("");
// 				$("#application").val("");
// 				$("#group_name").val("");
// 				poeTabForm();
			}
		});
		
		//애플리케이션 클릭시
		/* $("#app_nm").click(function(){
			var data_center = $("select[name='select_data_center_code'] option:selected").val();
			
			if(data_center == ""){
				alert("C-M 을 선택해 주세요.");
				return;
			}else{
				searchUserPoeAppForm();
			}		
		}); */
		
		$("#btn_clear1").unbind("click").click(function(){
			$("#f_s").find("input[name='p_application_of_def']").val("");
			$("#f_s").find("input[name='p_group_name_of_def']").val("");
			
			$("#frm1").find("input[name='table_nm']").val("");
			$("#frm1").find("input[name='application']").val("");
			$("#frm1").find("input[name='group_name']").val("");

			$("select[name='application_of_def'] option").remove();
			$("select[name='application_of_def']").append("<option value=''>--선택--</option>");
					
			$("select[name='group_name_of_def'] option").remove();
			$("select[name='group_name_of_def']").append("<option value=''>--선택--</option>");
		});
		
		$("#select_data_center_code").change(function(){
			$("#btn_clear1").trigger("click");
		});
		$("#application_of_def").change(function(){
			
			$("#group_name_of_def option").remove();
			$("#group_name_of_def").append("<option value=''>--선택--</option>");
			
			var grp_info = $(this).val().split(",");
			
			$("#application").val(grp_info[1]);
			$("#group_name").val("");
			
			if (grp_info != "")
				getAppGrpCodeList("group_name_of_def", "3", "", grp_info[0]);
			
			if($("select[name='group_name_of_def'] option").length == 2){
				$("select[name='group_name_of_def'] option:eq(1)").prop("selected", true);
				grp_info = $("select[name='group_name_of_def']").val().split(",");
				$("#p_group_name_of_def").val(grp_info[1]);
			}
		});
		
		$("#group_name_of_def").change(function() {
			var grp_info = $(this).val().split(",");
			$("#group_name").val(grp_info[1]);
		})
		
	});
	
	function userInsertInfo(user_cd){
		
		try{viewProgBar(true);}catch(e){}
		
		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=userList&user_cd='+user_cd;
		
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
						
						var user_id 			= "";
						var user_nm 			= "";
						var user_email 			= "";
						var user_hp 			= "";
						var user_tel 			= "";
						var user_gb_cd			= "";
						var dept_cd 			= "";
						var duty_cd 			= "";
						var user_appr_gb		= "";
						var del_yn 				= "";
						var no_auth 			= "";
						var account_lock 		= "";
						var user_pw 			= "";
						var select_dcc 			= "";
						var select_tab 			= "";
						var select_app 			= "";
						var select_grp 			= "";
						var absence_user_cd 	= "";
						var absence_user_nm 	= "";
						var absence_reason 		= "";
						var absence_start_date 	= "";
						var absence_end_date 	= "";
						var ins_date 			= "";
						
						var items = $(this).find('items');
						var rowsObj = new Array();
						
						if(items.attr('cnt')=='0'){
						}else{
							items.find('item').each(function(i){						
							
								user_id 			= $(this).find("USER_ID").text();
								user_pw 			= $(this).find("USER_PW").text();
								user_nm 			= $(this).find("USER_NM").text();
								user_email 			= $(this).find("USER_EMAIL").text();
								user_hp 			= $(this).find("USER_HP").text();
								user_tel 			= $(this).find("USER_TEL").text();
								user_gb_cd			= $(this).find("USER_GB").text();
								dept_cd 			= $(this).find("DEPT_CD").text();
								duty_cd 			= $(this).find("DUTY_CD").text();
								user_appr_gb		= $(this).find("USER_APPR_GB").text();
								del_yn 				= $(this).find("DEL_YN").text();
								no_auth 			= $(this).find("NO_AUTH").text();
								ins_date 			= $(this).find("INS_DATE").text();	
								select_dcc 			= $(this).find("SELECT_DCC").text();
								select_tab 			= $(this).find("SELECT_TAB").text();
								select_app 			= $(this).find("SELECT_APP").text();
								select_grp 			= $(this).find("SELECT_GRP").text();
								absence_user_cd 	= $(this).find("ABSENCE_USER_CD").text();
								absence_user_nm 	= $(this).find("ABSENCE_USER_NM").text();
								absence_reason 		= $(this).find("ABSENCE_REASON").text();
								absence_start_date 	= $(this).find("ABSENCE_START_DATE").text();
								absence_end_date 	= $(this).find("ABSENCE_END_DATE").text();
							});						
						}
						//어플리케이션,그룹명 세팅. 그룹명은 어플리케이션 선택 후 조회되도록 시간차를 둠.
						if (select_tab != "") {
							getAppGrpCodeList("application_of_def", "2", select_app, "", select_tab);
							setTimeout(function(){
								var selected_app_grp_cd	= $("#application_of_def option:selected").val().split(",")[0]; //그룹 조회 파라미터.
								if (selected_app_grp_cd != "")
									getAppGrpCodeList("group_name_of_def", "3", select_grp, selected_app_grp_cd); //어플리케이션 코드로 그룹 조회 및 그룹 선택.
							} ,500);
						}
						
						$("#user_cd").val(user_cd);
						$("#user_id").val(user_id);
						$("#user_nm").val(user_nm);
						$("#user_gb").val(user_gb_cd);
						$("#dept_cd").val(dept_cd);
						$("#duty_cd").val(duty_cd);
						$("#user_appr_gb").val(user_appr_gb);
						$("#del_yn").val(del_yn);
						$("#user_email").val(user_email);
						$("#user_hp").val(user_hp);
						$("#user_tel").val(user_tel);
						$("#select_data_center_code").val(select_dcc);
						$("#table_nm").val(select_tab);
// 						$("#table_of_def").val(select_tab);
						//어플리케이션,그룹명을 코드 기반 조회로 변경하면서 이름 값 저장필요.
						$("#application").val(select_app);
						$("#group_name").val(select_grp);
						
						$("#absence_user_cd").val(absence_user_cd);
						$("#absence_user_nm").val(absence_user_nm);
						$("#absence_reason").val(absence_reason);
						$("#absence_start_date").val(absence_start_date);
						$("#absence_end_date").val(absence_end_date);
						$("#v_user_nm").text(user_nm);
						$("#v_user_id").text(user_id);
						$("#user_pw").val("");
						$("#new_user_pw").val("");
						$("#re_new_user_pw").val("");
						
						$("#v_ins_date").text(ins_date);
						
						for(var j=0;j<arr_user_gb_cd.length;j++){
							if(user_gb_cd == arr_user_gb_cd[j].cd){
								$("#user_gb").text(arr_user_gb_nm[j].nm);
							}
						}

						for(var j=0;j<arr_dept_gb_cd.length;j++){
							if(dept_cd == arr_dept_gb_cd[j].cd){
								$("#v_dept_nm").text(arr_dept_gb_nm[j].nm);
							}
						}
						
						for(var j=0;j<arr_duty_gb_cd.length;j++){
							if(duty_cd == arr_duty_gb_cd[j].cd){
								$("#v_duty_nm").text(arr_duty_gb_nm[j].nm);
							}
						}
						
						for(var j=0;j<arr_user_appr_gb_cd.length;j++){
							if(user_appr_gb == arr_user_appr_gb_cd[j].cd){
								$("#v_user_appr_gb").text(arr_user_appr_gb_nm[j].nm);
							}
						}
					});
					
					try{viewProgBar(false);}catch(e){}
				}
		, null );
		
		xhr.sendRequest();	
	}
	
	//유저 검색 시 팝업형태로 변경하면서 works_common.js 호출하도록 변경
// 	function getUserList(absence_user_nm){
		
<%-- 		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=userList&popup=1&p_search_gubun=user_nm&p_approval_gubun=Y&p_search_text='+encodeURIComponent(absence_user_nm); --%>
		
// 		var xhr = new XHRHandler(url, null
// 			,function(){
// 				var xmlDoc = this.req.responseXML;
				
// 				$(xmlDoc).find('doc').each(function(){
					
// 					var items = $(this).find('items');
					
// 					var aTags = new Array();
// 					if(items.attr('cnt')=='0'){
// 					}else{						
// 						items.find('item').each(function(i){						
// 							aTags.push({value:$(this).find('USER_NM').text()
// 										,label:'['+$(this).find('DEPT_NM').text()+']'+'['+$(this).find('DUTY_NM').text()+']'+$(this).find('USER_NM').text()
// 										,user_cd:$(this).find('USER_CD').text()
// 										,dept_nm:$(this).find('DEPT_NM').text()
// 										,dept_cd:$(this).find('DEPT_CD').text()
// 										});
// 						});
// 					}
					
// 					try{ $("#absence_user_nm").autocomplete("destroy"); }catch(e){};
					
// 					$("#absence_user_nm").autocomplete({
// 						minLength: 0
// 						,source: aTags
// 						,autoFocus: false
// 						,focus: function(event, ui) {
									
// 								}
// 						,select: function(event, ui) {
// 									$(this).val(ui.item.value);
// 									$("#absence_user_cd").val(ui.item.user_cd);
									
// 									$(this).data('sel_v',$(this).val());
// 									$(this).removeClass('input_complete').addClass('input_complete');
// 								}
// 						,disabled: false
// 						,create: function(event, ui) {
// 									$(this).autocomplete('search',$(this).val()); 
// 								}
// 						,close: function(event, ui) {
// 									$(this).autocomplete("destroy");
// 								}
// 						,open: function(){
// 					        setTimeout(function () {
// 					            $('.ui-autocomplete').css('z-index', 3000);
// 					        }, 10);
// 					    }
						
// 					}).data("autocomplete")._renderItem = function(ul, item) {
// 																return $("<li></li>" )
// 																	.data("item.autocomplete", item)
// 																	.append("<a>" + item.label + "</a>")
// 																	.appendTo(ul);
// 															};
					
// 				});
				
// 			}
// 		, null );
		
// 		xhr.sendRequest();
// 	}
	
	function popupApprovalLine(user_cd){
		
		var frm = document.frm2;
		
		frm.user_cd.value = user_cd;	
		openPopupCenter("about:blank","popupApprovalLine",640, 310);	
		frm.target = "popupApprovalLine";		
		frm.action = "<%=sContextPath%>/tWorks.ez?c=ez002_approval_line";
	
		frm.submit();
	}
	
	function goProc(){
		
		var frm = document.frm1;

		if(frm.absence_user_cd.value != "" && frm.absence_user_cd.value != '0' ){
			if(frm.absence_start_date.value == "" || frm.absence_end_date.value == ""){
				alert("대리결재 기간을 입력해 주세요.");
				return;
			} else {
				
				// 날짜 기간 체크
				if ( frm.absence_start_date.value > frm.absence_end_date.value ) {
					alert("대리결재 기간의 FROM ~ TO를 확인해 주세요.");
					return;
				}
			}
		}

		if( !confirm("처리하시겠습니까?") ) return;
		
		frm.user_cd.value = "<%=S_USER_CD%>";
		frm.target = "if1";
		frm.action = "<%=sContextPath%>/tWorks.ez?c=ez002_info_p";
		frm.submit();
	}
	
	function selectTable(eng_nm, desc, user_daily, grp_cd){
		
		$("#table_nm").val(eng_nm);
		$("#table_of_def").val(eng_nm);
		
		dlClose("dl_tmp1");
		
		$("#f_s").find("input[name='p_sched_table']").val(eng_nm);
		$("#f_s").find("input[name='p_application_of_def']").val("");
		$("#f_s").find("input[name='p_group_name_of_def']").val("");

		//어플리케이션 초기화
		$("select[name='application_of_def'] option").remove();
		$("select[name='application_of_def']").append("<option value=''>--선택--</option>");
		$("#application").val("");
		
		//그룹 초기화
		$("select[name='group_name_of_def'] option").remove();
		$("select[name='group_name_of_def']").append("<option value=''>--선택--</option>");
		$("#group_name").val("");
		
		if(eng_nm.indexOf(",") == -1) {
			//어플리케이션을 검색		
			getAppGrpCodeList("application_of_def", "2", "", grp_cd);
			
			// 어플이 하나만 존재하면 자동 세팅
			if($("select[name='application_of_def'] option").length == 2){
				$("select[name='application_of_def'] option:eq(1)").prop("selected", true);
				
				var grp_info = $("select[name='application_of_def']").val().split(",");
				$("#p_application_of_def").val(grp_info[1]);
				$("#application").val(grp_info[1]);
	
				if (grp_info != "") {
					getAppGrpCodeList("group_name_of_def", "3", "", grp_info[0]);
				} else {
					getAppGrpCodeList("group_name_of_def", "3", "", "");
				}
				
				// 그룹이 하나만 존재하면 자동 세팅
				if($("select[name='group_name_of_def'] option").length == 2){
					$("select[name='group_name_of_def'] option:eq(1)").prop("selected", true);
					grp_info = $("select[name='group_name_of_def']").val().split(",");
					$("#p_group_name_of_def").val(grp_info[1]);
					$("#group_name").val(grp_info[1]);
				}
			}
		}

	}

	//APP/GRP 가져오기
	function getUserAppGrpCodeList(scode_cd, depth, grp_cd, val, eng_nm, grp_nm){
		
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
																																																								
								$("select[name='"+val+"']").append("<option value='"+arr_grp_cd+"'>"+grp_eng_nm+"</option>");
								
							});	
							
							$("select[name='"+val+"']").val(grp_nm); 
						}									
						
					});
					try{viewProgBar(false);}catch(e){}
				}
		, null );
		
		xhr.sendRequest();
	}
	
	function userPassWordChagne(user_cd) {
		var frm = document.frm3;
		
		openPopupCenter4("about:blank","userPassWordChagne",780,500);
		
		frm.pw_chk.value = "Y";
		frm.screenStatus.value = "popup";
		frm.user_cd.value = user_cd;
		frm.user_id.value = $("#user_id").val();
		frm.target = "userPassWordChagne";
		frm.action = "<%=sContextPath%>/tWorks.ez?c=ez002_pw_change_ui";
		frm.submit();
	}
	
	//대결자 검색 팝업형태로 변경
	function goUserSeqSelect(cd, nm, btn){

		var frm1 = document.frm1;

		frm1.absence_user_nm.value = nm;
		frm1.absence_user_cd.value = cd;

		dlClose('dl_tmp3');
	}
</script>

