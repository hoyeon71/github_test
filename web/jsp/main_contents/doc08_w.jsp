<%@page import="com.ghayoun.ezjobs.t.domain.ApprovalLineBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/jsp/common/inc/header.jsp"%>
<%@ page import="java.sql.*,java.util.*,java.io.*,java.text.*,java.net.*" %>
<%@ page import="com.ghayoun.ezjobs.m.domain.*" %>
<c:set var="caluse_gb_cd" value="${fn:split(CALUSE_GB_CD,',')}"/>
<c:set var="caluse_gb_nm" value="${fn:split(CALUSE_GB_NM,',')}"/>

<c:set var="prio_gb_cd" value="${fn:split(PRIORITY_GB_CD,',')}"/>
<c:set var="prio_gb_nm" value="${fn:split(PRIORITY_GB_NM,',')}"/>
<%
	//js version 추가하여 캐시 새로고침
	String jsVersion = CommonUtil.getMessage("js_version");
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
<link href="<%=request.getContextPath() %>/js/SlickGrid-2.1.0/css/select2.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath() %>/css/slick-default-theme.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath() %>/js/poshytip-1.2/tip.css" rel="stylesheet" type="text/css" />
<style type="text/css">
	.select2-container {
		top: -3px;
		left: -6px;
	}
    .select2-container .select2-selection--single {
		height: 26px;
	}  
</style>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/common.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/cookie.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/popup.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/xhrHandler.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.min.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery-ui.custom.min.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.resizeEnd.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.corner.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.cookie.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery-sha256.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.placeholder.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.blockUI.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.event.drag-2.2.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.dialogextend.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.layout.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.layout.slideOff.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.fancytree-all.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/SlickGrid-2.1.0/slick.core.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/SlickGrid-2.1.0/plugins/slick.autotooltips.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/SlickGrid-2.1.0/plugins/slick.checkboxselectcolumn.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/SlickGrid-2.1.0/plugins/slick.rowselectionmodel.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/SlickGrid-2.1.0/slick.editors.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/SlickGrid-2.1.0/plugins/select2.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/SlickGrid-2.1.0/slick.dataview.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/SlickGrid-2.1.0/slick.grid.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/poshytip-1.2/jquery.poshytip.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/works_common.js?v=<%=jsVersion %>" ></script>

</head>
<%
	Map<String, Object> paramMap = CommonUtil.collectParameters(request);
	
	String c 				= CommonUtil.isNull(paramMap.get("c"));
	String gridId 			= "g_"+c;	
	
	String menu_gb 			= CommonUtil.getMessage("CATEGORY.GB.02.GB."+CommonUtil.isNull(paramMap.get("menu_gb")));
	String[] arr_menu_gb 	= menu_gb.split(",");
	
	String gridId_1 = "g_"+c+"_1";
	String gridId_2 = "g_"+c+"_2";
	String gridId_3 = "g_"+c+"_3";
	String gridId_4 = "g_"+c+"_4";

	//정기작업등록 
	String doc_gb = CommonUtil.isNull(paramMap.get("doc_gb"));
	
	String[] aTmp = null;
	
// 	List approvalLineList			= (List)request.getAttribute("approvalLineList");
	List dataCenterList		    	= (List)request.getAttribute("dataCenterList");
	List jobTypeGbList				= (List)request.getAttribute("jobTypeGb");
	List systemGbList				= (List)request.getAttribute("systemGb");	
	
	String strJobGubun			= CommonUtil.isNull(paramMap.get("job_gubun"));
	
	// 세션값 가져오기.
	String strSessionUserId 	= S_USER_ID;
	String strSessionUserNm 	= S_USER_NM;
	String strSessionDcCode 	= S_D_C_CODE;
	
	String strServerGb 			= CommonUtil.isNull(CommonUtil.getMessage("SERVER_GB"));
	String doc_cd 				= "";
	String strScodeNm 			= "";
	String strDefaultMaxWait	= "";
	if ( strServerGb.equals("P") ) {
		strDefaultMaxWait = "1";
	} else {
		strDefaultMaxWait = "3";
	}
	
%>

<body id='body_A01' leftmargin="0" topmargin="0">
 
<div style="width:100%; height:100%; overflow-x:hidden; overflow-y:scroll;">
<form id="f_s" name="f_s" method="post" onsubmit="return false;">	
	<input type="hidden" name="p_data_center" 		id="p_data_center" />
	<input type="hidden" name="p_application" 		id="p_application" />
	<input type="hidden" name="p_group_name_of_def" id="p_group_name_of_def" />
	<input type="hidden" name="p_search_gubun" 		id="p_search_gubun" />
	<input type="hidden" name="p_search_text" 		id="p_search_text" />
	
	<input type="hidden" name="p_scode_cd" 			id="p_scode_cd" />
	<input type="hidden" name="p_grp_depth" 		id="p_grp_depth" />
	<input type="hidden" name="p_app_nm" 			id="p_app_nm" />
	<input type="hidden" name="p_app_search_gubun" 	id="p_app_search_gubun" />
</form>

<!-- 결재자 정보에서 사용하는 폼 -->
<form id="userFrm" name="userFrm" method="post" onsubmit="return false;"></form>

<form id="frm1" name="frm1" method="post" onsubmit="return false;" enctype="multipart/form-data" >

	<input type="hidden" name="flag" 				id="flag"/>
	<input type="hidden" name="is_valid_flag" 		id="is_valid_flag" />	
	<input type="hidden" name="t_general_date" 		id="t_general_date" />
	<input type="hidden" name="t_conditions_in" 	id="t_conditions_in" />
	<input type="hidden" name="t_conditions_out" 	id="t_conditions_out" />
	<input type="hidden" name="t_resources_q" 		id="t_resources_q" />
	<input type="hidden" name="t_resources_c" 		id="t_resources_c" />
	<input type="hidden" name="t_set" 				id="t_set" />
	<input type="hidden" name="t_steps" 			id="t_steps" />
	<input type="hidden" name="t_postproc" 			id="t_postproc" />
	<input type="hidden" name="t_tag_name" 			id="t_tag_name"/>
	<input type="hidden" name="month_1" 			id="month_1"/>
	<input type="hidden" name="month_2" 			id="month_2"/>
	<input type="hidden" name="month_3" 			id="month_3"/>
	<input type="hidden" name="month_4" 			id="month_4"/>
	<input type="hidden" name="month_5" 			id="month_5"/>
	<input type="hidden" name="month_6" 			id="month_6"/>
	<input type="hidden" name="month_7" 			id="month_7"/>
	<input type="hidden" name="month_8" 			id="month_8"/>
	<input type="hidden" name="month_9" 			id="month_9"/>
	<input type="hidden" name="month_10" 			id="month_10"/>
	<input type="hidden" name="month_11" 			id="month_11"/>
	<input type="hidden" name="month_12" 			id="month_12"/>	
	<input type='hidden' name='p_apply_date'		id='p_apply_date' />
	<input type='hidden' name='apply_cd'			id='apply_cd' />
	
	<input type="hidden" name="doc_gb" 				id="doc_gb" value="<%=doc_gb %>" />	
	<input type="hidden" name="retro" 				id="retro"	value="0" />
	
	<!-- Cyclic 작업 셋팅 파라미터. -->
	<input type="hidden" name="rerun_interval" 		id="rerun_interval"/>
	<input type="hidden" name="rerun_interval_time" id="rerun_interval_time" value="M" />
	<input type="hidden" name="cyclic_type" 		id="cyclic_type"/>
	<input type="hidden" name="count_cyclic_from" 	id="count_cyclic_from"/>
	<input type="hidden" name="interval_sequence" 	id="interval_sequence"/>
	<input type="hidden" name="tolerance" 			id="tolerance"/>
	<input type="hidden" name="specific_times" 		id="specific_times"/>
		
	<input type="hidden" name="max_wait" 			id="max_wait"	value="<%=strDefaultMaxWait%>" />
	
	<input type="hidden" name="user_cd" 			id="user_cd"/>
	
	<!-- 저장 후 관리자 즉시 결재 버튼이 노출되면 doc_cd가 필요 -->
	<input type="hidden" name="doc_cd" 				id="doc_cd"/>
	
	<!-- 인터페이스 체크 결과 -->
	<input type="hidden" name="if_return" 			id="if_return"/>
	
	<!-- 스마트테이블 체크 결과 -->
	<input type="hidden" name="smart_cnt" 			id="smart_cnt"/>
	
	<!-- 선행 검색 시 data_center 비교 위해 필요 -->
	<input type="hidden" name="doc_data_center" 	id="doc_data_center"/>
	
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
		<td id='ly_<%=gridId %>' style='vertical-align:top;'>			
			<div id="<%=gridId %>" class="ui-widget-header_kang ui-corner-all">
				<input type="hidden" name="title" id="title" value="스마트폴더등록"/>
				<input type="hidden" name="description" id="description" value="" />
				<table style="width:100%">
					<tr>
						<td>
							<div class='cellTitle_kang'>작업 정보</div>
						</td>	
					</tr>
					<tr>
						<td valign="top">
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
									<td>
										<div class='cellTitle_kang2'><font color="red">* </font>C-M</div>
									</td>									
									<td> 
										<div class='cellContent_kang'>
											<select name="data_center_items" id="data_center_items" style="width:70%;height:21px;">
												<option value="">--선택--</option>
												<c:forEach var="cm" items="${cm}" varStatus="status">
													<option value="${cm.scode_cd},${cm.scode_eng_nm}">${cm.scode_nm}</option>
												</c:forEach>
											</select>
											<input type="hidden" name="data_center" id="data_center" />
										</div>
									</td>
									
									
									<td>
										<div class='cellTitle_kang2'><font color="red">* </font>시스템구분</div>  
									</td>
									<td>  
										<div class='cellContent_kang'>
											<select id="sSystemGb" name="sSystemGb" style="width:70%;height:21px;">																				
												<option value="">--선택--</option>
												<%
													for ( int i = 0; i < systemGbList.size(); i++ ) {
													CommonBean bean = (CommonBean)systemGbList.get(i);
													 
												%>											
													<option value="<%=CommonUtil.E2K(bean.getScode_eng_nm())%>"><%=bean.getScode_nm()%></option>
												<%
													}
												%>
											</select>
											<input type="hidden" name="systemGb" id="systemGb" />
										</div>	
									</td>
									
									<td>
										<div class='cellTitle_kang2'><font color="red">* </font>작업유형구분</div>
									</td>  
									<td>
										<div class='cellContent_kang'>
											<select id="sJobTypeGb" name="sJobTypeGb" style="width:70%;height:21px;">																				
												<option value="">--선택--</option>
												<%
													for ( int i = 0; i < jobTypeGbList.size(); i++ ) {
													CommonBean bean = (CommonBean)jobTypeGbList.get(i);
													 
												%>											
													<option value="<%=CommonUtil.E2K(bean.getScode_eng_nm())%>"><%=bean.getScode_nm()%></option>
												<%
													}
												%>
											</select>
											
											<input type="hidden" name="jobTypeGb" id="jobTypeGb" />
										</div>
									</td>
								</tr>
								
								<tr>
									<td>  
										<div class='cellTitle_kang2'><font color="red">* </font>테이블</div>
									</td> 
									<td>
										<div class='cellContent_kang'>
<!-- 											<input type="text" name="table_nm" id="table_nm" style="width:98%; height:21px;" onkeydown="return false;" readonly/> -->
<!-- 											<input type="hidden" name="table_of_def" id="table_of_def" /> -->
											
											<input type="text" name="table_name" id="table_name" style="width:70%; height:21px;" />
											<input type='hidden' id='application' name='application' value='' />
											<input type='hidden' id='group_name' name='group_name' value='' />
										</div> 
									</td>
									<!-- <td>
										<div class='cellTitle_kang2'><font color="red">* </font>어플리케이션</div>
									</td>
									<td>
										<div class='cellContent_kang'>
									 		<select name="application_of_def" id="application_of_def" style="width:70%;height:21px;">
												<option value="">--선택--</option>
											</select>
											<input type='hidden' id='application' name='application' value='' />
										</div>
									</td>
									<td>
										<div class='cellTitle_kang2'><font color="red">* </font>그룹</div>
									</td>
									<td> 
										<div class='cellContent_kang'>
									 		<select name="group_name_of_def" id="group_name_of_def" style="width:70%;height:21px;">
												<option value="">--선택--</option>
											</select>
											<input type='hidden' id='group_name' name='group_name' value='' />
										</div>
									</td> -->
									<td>
										<div class='cellTitle_kang2'><font color="red"></font>user_daily</div>  
									</td>
									<td>
										<div class='cellContent_kang'>
											<input type="text" name="user_daily" id="user_daily" style="width:70%;height:21px;"/>
										</div>
									</td>
									<td>
										<div class='cellTitle_kang2'><font color="red">* </font>수행서버</div>
									</td>
									<td> 
										<div class='cellContent_kang'>
<!-- 											<input type="text" name="node_id" id="node_id" style="width:70%;height:21px;" /> -->
											<select name="host_id" id="host_id" style="width:70%;height:21px;">
												<option value="">--선택--</option>
											</select>
											<input type="hidden" name="node_id" id="node_id" />
										</div>
									</td>
									
								</tr>
									
								<tr>
									<td>
										<div class='cellTitle_kang2'><font color="red">* </font>작업명</div>  
									</td>
									<td>
										<div class='cellContent_kang'>
											<input type="text" id="job_name" name="job_name" style="width:70%;height:21px;" readonly="readonly" />
											<span id='btn_nameDupChk'>확인</span>
											<input type="hidden" id="job_nameChk" name="job_nameChk" value="0"/>
										</div>
									</td>
									
									<td>								
										<div class='cellTitle_kang2'><font color="red">* </font>계정명</div>
									</td>
									<td> 
										<div class='cellContent_kang'>
<!-- 											<input type="text" name="owner" id="owner" style="width:70%;height:21px;" /> -->
											<select name="owner" id="owner" style="width:70%;height:21px;">
												<option value="">--선택--</option>
											</select>
										</div>
									</td>
									
									<td>   
										<div class='cellTitle_kang2'>작업타입</div>
									</td>
									<td>
										<div class='cellContent_kang'>			
											<input type="text" name="task_type" id="task_type" value="SMART Table" style="width:98%; height:21px;" onkeydown="return false;" readonly />
										</div>
									</td>
								</tr>
								
								<tr>
									<!-- <td>
										<div class='cellTitle_kang2'><font color="red">* </font>작업명</div>  
									</td>
									
									<td>
										<div class='cellContent_kang'>
										<input type="text" id="job_name" name="job_name" style="width:70%;height:21px;" readonly="readonly" />
										<span id='btn_nameDupChk'>확인</span>
										<input type="hidden" id="job_nameChk" name="job_nameChk" value="0"/>
											
										</div>
									</td> -->
									<!-- <td>
										<div class='cellTitle_kang2'><font color="red">* </font>작업명</div>  
									</td>
									
									<td>
										<div class='cellContent_kang'>
										<input type="text" id="job_name" name="job_name" style="width:70%;height:21px;" />
										<span id='btn_nameDupChk'>확인</span>
										<input type="hidden" id="job_nameChk" name="job_nameChk" value="0"/>
											
										</div>
									</td>
									<td>
										<div class='cellTitle_kang2'><font color="red">* </font>작업 설명</div>
									</td>
	        						<td colspan="3">
	        							<div class='cellContent_kang'>
	        								<input type="text" name="description" id="description" style="width:98.5%;height:21px;" />
	        								<textarea name="description" id="description" style="width:100%; ime-mode:active;"> </textarea>
	        							</div>        			
	        					   </td> -->
								</tr>	
								
								<tr>
									<td>
										<div class='cellTitle_kang2'><font color="red">* </font>프로그램 위치</div>
									</td>
									
									<td colspan="3">
										<div class='cellContent_kang'>
											<input type="text" name="mem_lib" id="mem_lib" style="width:98%;height:21px;ime-mode:disabled;" onkeyup="noSpaceBar(this)"/>
										</div>
									</td>	
									
									<td>
										<div class='cellTitle_kang2'><font color="red">* </font>프로그램 명</div>
									</td>
									<td>
										<div class='cellContent_kang'>
											<input type="text" name="mem_name" id="mem_name" style="width:98%;height:21px;ime-mode:disabled;" onkeyup="noSpaceBar(this)"/>
											<!-- >span id='btn_parm_add'>변수추가</span-->
										</div>
									</td>									
								</tr>
									
								<tr>
									<td colspan="6">									
										<div id='ctmfw' style="display:none">																	
											<table style="width:100%">
												<tr>
													<td>
														<div class='cellTitle_kang2'>모니터링 시간</div>
													</td>										
													
													<td>
														<div class='cellContent_kang'>
															<input type="text" id="monitor_time" name="monitor_time" value="180" style="height:21px;"> 분
														</div>
													</td>
													<td>
														<div class='cellTitle_kang2'>모니터링 주기</div>
													</td>	
													 
													<td>
														<div class='cellContent_kang'>
															<input type="text" id="monitor_interval" name="monitor_interval" value="120" style="height:21px;"> 초
														</div>
													</td>
													<td>
														<div class='cellTitle_kang2'>파일증감 체크주기</div>
													</td>	
													 
													<td>
														<div class='cellContent_kang'>
															<input type="text" id="filesize_comparison" name="filesize_comparison" value="60" style="height:21px;width:50px;"> 
														</div>
													</td>
													<td>
														<div class='cellTitle_kang2'>파일멈춤 체크횟수</div>
													</td>	
													 
													<td>
														<div class='cellContent_kang'>
															<input type="text" id="num_of_iterations" name="num_of_iterations" value="3" style="height:21px;width:50px;"> 회
														</div>
													</td>
													<td>
														<div class='cellTitle_kang2'>모니터링 종료시간</div>
													</td>	
													 
													<td>
														<div class='cellContent_kang'>
															<input type="text" id="stop_time" name="stop_time" value="0" style="height:21px;width:50px;"> 
														</div>
													</td>														
												</tr>
											</table>
										</div>
									</td>
								</tr>
								<tr>  
									<td>
										<div class='cellTitle_kang2'>작업수행명령</div>
									</td>
									
									<td colspan="5">
										<div class='cellContent_kang'>
											<input type="text" name="command" id="command" style="width:99%;height:21px;background-color:#EBEBE4;" readonly />
										</div>
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
				
				<table style="width:100%;">
 					<tr>
						<td colspan="6"> 
							<table style="width:100%;">
  								<tr>
									<td colspan = "5">
										<div class='cellTitle_kang2'>변수</div>
									</td>
									<td style="width:120px;">
										<div class='cellTitle_kang'>
											<span id='btn_addUserVar' style='vertical-align:right;'>추가</span>
										</div>
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td style='width:120px;'><div class='cellTitle_kang2'>순번</div></td>
						<td style='width:400px;'><div class='cellTitle_kang2'>Var Name</div></td>
						<td style='width:%;'><div class='cellTitle_kang2'>Value</div></td>
						<td style='width:120px;'><div class='cellTitle_kang2'>삭제란</div></td>
					</tr>
				</table>
				
				<table style="width:100%;height:100%;border:none;" id="userVar"> 
		
				</table>
			
				<table style="width:100%">
					<tr>
						<td>
							<div class='cellTitle_kang'>스케쥴 정보</div>
						</td>	
					</tr>
					<tr>
						<td valign="top">
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
									<td>
										<div class='cellTitle_kang2'><font id="cal_nm_ondemand" color="red">* </font>작업주기/시기</div>
									</td>
									<td>
										<div class='cellContent_kang'>
											<input type="text" id="cal_nm" name="cal_nm" style="width:280px; height:21px;" onkeydown="return false;" readonly   title="작업주기/시기"/>
											<input type="hidden" id="tab_yn" name="tab_yn" value="0"/>																										
										
										</div>
									</td>
									<td colspan="4">
										<div class='cellContent_kang'>
											<span id='btn_sched'>추가</span>
											<span id='btn_schedDel'>삭제</span>
											<span id='btn_CalDetail'>미리보기</span>
											<span id='btn_schedInfo'>스케쥴상세</span>											
										</div>
									</td>
								</tr>  
							</table>
						    
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
									<td>
										<div class='cellTitle_kang2'><font id="from_tiem_ondemand" color="red"></font>작업시작시간</div>	
									</td> 								
									<td>
										<div class='cellContent_kang'>
											<select id='sHour' name='sHour' style="width:40%;height:21px;">
												<option value="">--선택--</option>
										   			<c:forEach var="sHour" begin="0" end="23" step="1">    
										   			<c:choose>
										    		<c:when test="${sHour < 10}">
										     	<option value="0${sHour}">0${sHour}</option></c:when>
										        <c:otherwise><option value="${sHour}">${sHour}</option></c:otherwise>
										        </c:choose>    
			  								   </c:forEach>
											</select>
											<select id='sMin' name = 'sMin' style="width:40%;height:21px;">
												<option value="">--선택--</option>
											   <c:forEach var="sMin" begin="0" end="59" step="1">    
											    <c:choose>
											     <c:when test="${sMin < 10}">
											     <option value="0${sMin}">0${sMin}</option></c:when>
											     <c:otherwise><option value="${sMin}">${sMin}</option></c:otherwise>
											    </c:choose>    
											   </c:forEach>
											</select>	
										</div>
										
										<input type="hidden" name="time_from" id="time_from"/>
										<input type="hidden" name="time_group" id="time_group"/>
									</td>
									<td>
										<div class='cellTitle_kang2'>작업종료시간</div>	
									</td> 								
									<td>
										<div class='cellContent_kang'>
											<select id='eHour' name='eHour' style="width:40%;height:21px;">
												<option value="">--선택--</option>
										   			<c:forEach var="eHour" begin="0" end="23" step="1">    
										   			<c:choose>
										    		<c:when test="${eHour < 10}">
										     	<option value="0${eHour}">0${eHour}</option></c:when>
										        <c:otherwise><option value="${eHour}">${eHour}</option></c:otherwise>
										        </c:choose>    
			  								   </c:forEach>
											</select>
											<select id='eMin' name = 'eMin' style="width:40%;height:21px;">
												<option value="">--선택--</option>
											   <c:forEach var="eMin" begin="0" end="59" step="1">    
											    <c:choose>
											     <c:when test="${eMin < 10}">
											     <option value="0${eMin}">0${eMin}</option></c:when>
											     <c:otherwise><option value="${eMin}">${eMin}</option></c:otherwise>
											    </c:choose>    
											   </c:forEach>
											</select>	
										</div>
										
										<input type="hidden" name="time_until" id="time_until"/>
									</td>
								</tr>  
								
								<tr>
						        	<td>
										<div class='cellTitle_kang2'>시작임계시간</div>	
									</td>  
						        	<td>
						        		<div class='cellContent_kang'>
											<select name='slate_sub_h' id='slate_sub_h' style="width:40%;height:21px;">
												<option value="">--선택--</option>
										  		 <c:forEach var="slate_sub_h" begin="0" end="23" step="1">    
										   		 	<c:choose>
											  	     <c:when test="${slate_sub_h < 10}">
											  	    	 <option value="0${slate_sub_h}">0${slate_sub_h}</option></c:when>
											  		 <c:otherwise><option value="${slate_sub_h}">${slate_sub_h}</option></c:otherwise>
										 	     	</c:choose>    
										 	     </c:forEach>
											  </select>
											 
					        	    		<select name='slate_sub_m' id='slate_sub_m' style="width:40%;height:21px;">
												<option value="">--선택--</option>
										  		 <c:forEach var="slate_sub_m" begin="0" end="59" step="1">    
											   		 <c:choose>
												  	     <c:when test="${slate_sub_m < 10}">
												  	     	<option value="0${slate_sub_m}">0${slate_sub_m}</option></c:when>
												  		 <c:otherwise><option value="${slate_sub_m}">${slate_sub_m}</option></c:otherwise>
											 	     </c:choose>    
										 	     </c:forEach>
											  </select>
											  
											  <input type="hidden" name="late_sub" id="late_sub"/>
										</div>
									</td>
						        	<td>
										<div class='cellTitle_kang2'>종료임계시간</div>	
									</td>  
						        	<td>
						        		<div class='cellContent_kang'>
						        			<select name='slate_time_h' id='slate_time_h' style="width:40%;height:21px;">
												<option value="">--선택--</option>
										  		 <c:forEach var="slate_time_h" begin="0" end="23" step="1">    
											   		 <c:choose>
												  	     <c:when test="${slate_time_h < 10}">
												  	     	<option value="0${slate_time_h}">0${slate_time_h}</option></c:when>
												  		 <c:otherwise><option value="${slate_time_h}">${slate_time_h}</option></c:otherwise>
											 	     </c:choose>    
										 	     </c:forEach>
											  </select>
					        	    		<select name='slate_time_m' id='slate_time_m' style="width:40%;height:21px;">
												<option value="">--선택--</option>
										  		 <c:forEach var="slate_time_m" begin="0" end="59" step="1">    
											   		 <c:choose>
												  	     <c:when test="${slate_time_m < 10}">
												  	     	<option value="0${slate_time_m}">0${slate_time_m}</option></c:when>
												  		 <c:otherwise><option value="${slate_time_m}">${slate_time_m}</option></c:otherwise>
											 	     </c:choose>    
										 	     </c:forEach>
											  </select>
											  
											  <input type="hidden" name="late_time" id="late_time"/>
										</div>
									</td>
						        	<td>
										<div class='cellTitle_kang2'>수행임계시간</div>	
									</td>  
						        	<td>
						        		<div class='cellContent_kang'>							        		      
											  <input type="text" name="late_exec" id="late_exec" value="" size="3" style="height:21px;" /> 분
										</div>
									</td>
					        	</tr>
					        	
					        	<tr>
					        		<td valign="top" colspan="6">
					        			<table style="width:100%">
					        				<tr>
												<td width="118px"></td>
												<td width="250px"></td>
												<td width="120px"></td>
												<td width="200px"></td>
												<td width="120px"></td>
												<td width=""></td>
											</tr>
					        				
					        				<tr>
					        					<td>
											 		<div class='cellTitle_kang2'>반복작업</div>
									        	</td>
									        	<td colspan="3">
									        		<div class='cellContent_kang'>
														<select id='cyclic' name='cyclic' style="height:21px;" onChange='fn_cyclic_set(this.value);'>
															<option value="0">N</option>
												        	<option value="1">Y</option>
														</select>&nbsp;&nbsp;
														<span id='cyclic_ment'></span>
														<span id='btn_cyclic'>반복옵션</span>	
													</div>												
												</td>
											
												<td>
											 		<div class='cellTitle_kang2'>최대 반복 횟수</div>
									        	</td>								
												<td>
													<div class='cellContent_kang'>
														<input type='text' class='input' id='rerun_max' name='rerun_max' style='width:98%;height:21px;" size='4' maxlength='2'  />
													</div>
												</td>
					        				</tr>
					        				
					        				<tr>
					        					<td>
											 		<div class='cellTitle_kang2'>Confirm Flag</div>
									        	</td>
									        	<td colspan="3">
									        		<div class='cellContent_kang'>
														<select id='confirm_flag' name='confirm_flag' style="height:21px;">
															<option value="0">N</option>
												        	<option value="1">Y</option>
												        </select>
													</div>
												</td>
												<td>
											 		<div class='cellTitle_kang2'>우선순위</div> 
									        	</td>
												<td>
													<div class='cellContent_kang'>
														<input type='text' class='input' id='priority' name='priority' value="" size='4' maxlength='2' onkeypress='if(event.keyCode==32 || event.keyCode==39) event.returnValue = false;' style='width:20%;height:21px;ime-mode:disabled;' />
													</div>
												</td>
					        				</tr>
					        				<tr>
					        					<td>
											 		<div class='cellTitle_kang2'>성공 시 알람 발송</div>
									        	</td>
									        	<td colspan="3">
									        		<div class='cellContent_kang'>
														<select id='success_sms_yn' name='success_sms_yn' style="height:21px;">
															<option value="N">N</option>
												        	<option value="Y">Y</option>
												        </select>
													</div>
												</td>
												<td>
									           		<div class='cellTitle_kang2'>Global 컨디션</div>
												</td>
				                    			<td colspan="3">
													<div class='cellContent_kang'>
														<select id='globalCond_yn' name='globalCond_yn' style="height:21px;">
															<option value="0">N</option>
												        	<option value="1">Y</option>
														</select>&nbsp;&nbsp;
														<font color="red">※ 후속작업이 다른 C-M 작업일 경우 Y 설정</font>
													</div>
												</td>												
					        				</tr>
					        				
					        			</table>
					        		</td>
					        	</tr>					
							</table>
						</td>
					</tr>
				</table>
							
				<table style="width:100%">
					<tr>
						<td style="width:50%;">
							<table style="width:100%;">
								<tr>								  
									<td style="width:76%;height:21px;">
										<div class='cellTitle_kang2'>선행작업조건</div>
									</td> 
									<td style="width:12%;height:21px;">
										<div class='cellTitle_kang2'>
											<span id='btn_addConditionsIn' style='vertical-align:right;'>추가</span></th>
										</div>
									</td>
									<td style="width:12%;height:21px;">
										<div class='cellTitle_kang2'>
											<span id='btn_delConditionsIn' style='vertical-align:right;'>삭제</span></th>
										</div>
									</td>
								</tr>   
							</table> 
							<table style="width:100%;height:100%;border:none;"> 
							
								<tr>					
									<td id='ly_<%=gridId_1 %>' style='vertical-align:top;height:150px;'>
										<div id="<%=gridId_1 %>" class="ui-widget-header ui-corner-all"></div>
									</td>					
								</tr>
							</table>					
						</td>
						
						<td style="width:50%;">
							<table style="width:100%;">
								<tr>								
									<td style="width:76%;height:21px;">
										<div class='cellTitle_kang2'><font color="red">* </font>후행작업조건 (자기작업 CONDITION)</div>
									</td> 
									<td style="width:12%;height:21px;">
										<div class='cellTitle_kang2'>
											<span id='btn_addConditionsOut'style='vertical-align:right;'>추가</span></th>
										</div>
									</td>
									<td style="width:12%;height:21px;">
										<div class='cellTitle_kang2'>
											<span id='btn_delConditionsOut' style='vertical-align:right;'>삭제</span></th>
										</div>
									</td>
								</tr>
							</table> 
							<table style="width:100%;height:100%;border:none;">
								<tr>					
									<td id='ly_<%=gridId_2 %>' style='vertical-align:top;height:150px;'>
										<div id="<%=gridId_2%>" class="ui-widget-header ui-corner-all"></div>
									</td>					
								</tr>											
							</table>
						</td>
					</tr>
				</table>
				
				
				<table style="width:100%">					
					<tr>
						<td>
							<div class='cellTitle_kang'>부가 정보</div>
						</td>
					</tr>
					<tr>
						<td valign="top">
			
							<input type='hidden' id='user_cd_1_0' name='user_cd_1_0' value='<%=S_USER_CD%>' />
							<input type='hidden' id='user_cd_2_0' name='user_cd_2_0' value='' />
							<input type='hidden' id='user_cd_3_0' name='user_cd_3_0' value='' />
							<input type='hidden' id='user_cd_4_0' name='user_cd_4_0' value='' />
					
							<table style="width:100%;">	
								<tr>
									<td width="120px"></td>
									<td width="120px"></td>
									<td width="180px"></td>
									<td width="120px"></td>
									<td width="120px"></td>
									<td width="120px"></td>
									<td width="180px"></td>
									<td width="120px"></td>
								</tr>
								<tr>
									<td>
										<div class='cellTitle_kang2'><font color="red">* </font>담당자</div>
									</td>
									
									<td>
										<div class='cellContent_kang'>
											<input class='input' type='text' id='user_nm_1_0' value='<%=S_USER_NM %>' style='width:50%;height:21px;' onkeydown="return false;" readonly />
											<input class='input' type='hidden' id='author' name='author' value='<%=S_USER_ID %>'/>
										</div>
									</td>
									<td>
										<div class='cellContent_kang'>
											SMS<input type='checkbox' name='sms_1_0' id='sms_1_0' value='Y' checked />
											MAIL<input type='checkbox' name='mail_1_0' id='mail_1_0' value='Y' checked />
											
											<!-- 메신저<input type='checkbox' name='msg_1_0' id='msg_1_0' value='Y' checked /> -->
										</div>
									</td>
									<td>
										<div class='cellContent_kang'>
											<span id='btn_search1'>검색</span>
											<!-- <span id='btn_del1'>삭제</span> -->
										</div>
									</td>
								   
									<td>
										<div class='cellTitle_kang2'>담당자2</div>
									</td>
									<td>
										<div class='cellContent_kang'>
											<input class='input' type='text' id='user_nm_2_0' value='' style='width:50%;height:21px;' onkeydown="return false;" readonly />
										</div>
									</td>
									<td>
										<div class='cellContent_kang'>
											SMS<input type='checkbox' name='sms_2_0' id='sms_2_0' value='Y' checked />
											MAIL<input type='checkbox' name='mail_2_0' id='mail_2_0' value='Y' checked />
										
											<!-- 메신저<input type='checkbox' name='msg_2_0' id='msg_2_0' value='Y' checked /> -->
										</div>
									</td>
									<td>
										<div class='cellContent_kang'>
											<span id='btn_search2'>검색</span>
											<span id='btn_del2'>삭제</span>
										</div>
									</td>
										
								</tr>
								
								<tr>
									<td>
										<div class='cellTitle_kang2'>담당자3</div>
									</td>
									<td>
										<div class='cellContent_kang'>
											<input class='input' type='text' id='user_nm_3_0' value='' style='width:50%;height:21px;' onkeydown="return false;" readonly />
										</div>
									</td>
									<td>
										<div class='cellContent_kang'>
											SMS<input type='checkbox' name='sms_3_0' id='sms_3_0' value='Y' checked />
											MAIL<input type='checkbox' name='mail_3_0' id='mail_3_0' value='Y' checked />
											
											<!-- 메신저<input type='checkbox' name='msg_3_0' id='msg_3_0' value='Y' checked /> -->
										</div>
									</td>
									<td>
										<div class='cellContent_kang'>
											<span id='btn_search3'>검색</span>
											<span id='btn_del3'>삭제</span>
										</div>
									</td>
								
									<td>
										<div class='cellTitle_kang2'>담당자4</div>
									</td>
									
									<td>
										<div class='cellContent_kang'>
											<input class='input' type='text' id='user_nm_4_0' value='' style='width:50%;height:21px;' onkeydown="return false;" readonly />
										</div>
									</td>
									<td>
										<div class='cellContent_kang'>
											SMS<input type='checkbox' name='sms_4_0' id='sms_4_0' value='Y' checked />
											MAIL<input type='checkbox' name='mail_4_0' id='mail_4_0' value='Y' checked />
										
											<!-- 메신저<input type='checkbox' name='msg_4_0' id='msg_4_0' value='Y' checked /> -->
										</div>
									</td>
									<td>
										<div class='cellContent_kang'>
											<span id='btn_search4'>검색</span>
											<span id='btn_del4'>삭제</span>
										</div>
									</td>
								</tr>
								
        						<tr>						
									<td>
										<div class='cellTitle_kang2'><!-- <font color="red">* </font> -->중요작업</div>
									</td>									
									<td>
										<div class='cellContent_kang'>
							     			<select id="critical_yn" name="critical_yn" title="중요작업여부" style="width:width:98%;height:21px;">
							     				<!-- <option value="">--선택--</option> -->
								       		 	<option value="1">Y</option>
								       		 	<option value="0">N</option>
							     			</select>
							     			<input type="hidden" name="critical" id="critical" style="width:98%;height:21px;"/>
							     		</div>
									</td>
								</tr>
								<!-- <tr>
									<td>
										<div class='cellTitle_kang2'>파일 첨부</div>
									</td>
        						    <td colspan="5">
        								<div class='cellContent_kang'>									
											<input type='file' id='files' name='files' style='width:98%;' />
										</div>        			
        						    </td>
        						</tr> -->
								
 								
   							</table>
   							<table style="width:100%;">
   								<tr>
   									
									<td colspan = "4">
										<div class='cellTitle_kang'>ON/DO</div>
									</td>
									<td style="width:8%;height:21px;">
										<div class='cellTitle_kang'>
											<span id='btn_addStep' style='vertical-align:right;'>추가</span>
										</div>
									</td>
									<td style="width:8%;height:21px;">
										<div class='cellTitle_kang'>
											<span id='btn_delStep' style='vertical-align:right;'>삭제</span>
										</div>
									</td>	
								</tr>
							</table>
   							<table style="width:100%;">
	   							
								<tr>	
									<td style="width:5%;height:21px;">
										<div class='cellTitle_kang2'><input type='checkbox' name="checkIdxAll" id="checkIdxAll" onClick="checkAll();"/></div>
									</td>							  
									<td style="width:7%;height:21px;">
										<div class='cellTitle_kang2'>ON/DO</div>
									</td> 
									<td style="width:13%;height:21px;">
										<div class='cellTitle_kang2'>TYPE</div>
									</td>
									<td style="width:80%;height:21px;">
										<div class='cellTitle_kang2'>PARAMETERS</div>
									</td>
									
								</tr>   
							</table> 
							<table style="width:100%;height:100%;border:none;" id="onDoTable"> 
								
							</table>	
   						
						</td>
						</tr>
				</table>
				
			</div>			
		</td>
	</tr>
	<tr style='height:10px;'>
		<td style='vertical-align:top;'>
			<h4 class="ui-widget-header ui-corner-all" >
				<div align='right' class='btn_area'>
<!-- 					<span id='btn_ins' style="display:none;">저장</span> -->
<!-- 					<span id='btn_draft_i' style="display:none;">승인</span> -->
					<span id='btn_draft_admin'>즉시결재</span>
				</div>
			</h4>
		</td>
	</tr>
</table>
<div id="<%=gridId_3 %>" class="ui-widget-header ui-corner-all" style="display:none;"></div>
<div id="<%=gridId_4 %>" class="ui-widget-header ui-corner-all" style="display:none;"></div>
</form>
</div>

<script type="text/javascript">
	
	var rowsObj_job1 = new Array();
	var rowsObj_job2 = new Array();
	
	var arr_caluse_gb_cd = new Array();
	var arr_caluse_gb_nm = new Array();
	
	<c:forEach var="caluse_gb_cd" items="${caluse_gb_cd}" varStatus="s">
		var map_cd = {"cd":"${caluse_gb_cd}"};
		arr_caluse_gb_cd.push(map_cd);
	</c:forEach>
	<c:forEach var="caluse_gb_nm" items="${caluse_gb_nm}" varStatus="s">
		var map_nm = {"nm":"${caluse_gb_nm}"};
		arr_caluse_gb_nm.push(map_nm);
	</c:forEach>
	
	var arr_prio_gb_cd = new Array();
	var arr_prio_gb_nm = new Array();
	
	<c:forEach var="prio_gb_cd" items="${prio_gb_cd}" varStatus="s">
		var map_cd = {"cd":"${prio_gb_cd}"};
		arr_prio_gb_cd.push(map_cd);
	</c:forEach>
	<c:forEach var="prio_gb_nm" items="${prio_gb_nm}" varStatus="s">
		var map_nm = {"nm":"${prio_gb_nm}"};
		arr_prio_gb_nm.push(map_nm);
	</c:forEach>
	
	var gridObj_1 = {
		id : "<%=gridId_1 %>"
		,colModel:[
			{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'grid_idx',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   		,{formatter:gridCellNoneFormatter,field:'m_in_condition_name',id:'m_in_condition_name',name:'선행조건명',width:320,headerCssClass:'cellCenter',cssClass:'cellLeft'}	 
	   		,{formatter:Select2Formatter,field:'m_in_condition_date',id:'m_in_condition_date',name:'일자유형',width:80,headerCssClass:'cellCenter',cssClass:'cellLeft', editor: Select2Editor, dataSource: in_select_type}	   		
	   		,{formatter:Select2Formatter,field:'m_in_condition_and_or',id:'m_in_condition_and_or',name:'구분',width:80,headerCssClass:'cellCenter',cssClass:'cellLeft', editor: Select2Editor, dataSource: in_select_gb}
	   			   		
	   		
	   	]
		,rows:[]  
		,vscroll:false
	};
	
	var gridObj_2 = {
		id : "<%=gridId_2 %>"
		,colModel:[
			{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'grid_idx',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   		,{formatter:gridCellNoneFormatter,field:'m_out_condition_name',id:'m_out_condition_name',name:'자기작업 CONDITION',width:320,headerCssClass:'cellCenter',cssClass:'cellLeft'}	 
	   		,{formatter:Select2Formatter,field:'m_out_condition_date',id:'m_out_condition_date',name:'일자유형',width:75,headerCssClass:'cellCenter',cssClass:'cellLeft', editor: Select2Editor, dataSource: out_select_type}	   		
	   		,{formatter:Select2Formatter,field:'m_out_condition_effect',id:'m_out_condition_effect',name:'구분',width:75,headerCssClass:'cellCenter',cssClass:'cellLeft', editor: Select2Editor, dataSource: out_select_gb}  		
	   		
	   	]
		,rows:[]
		,vscroll:false
	};
	
	var gridObj_3 = {
		id : "<%=gridId_3 %>"
		,colModel:[
			{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'grid_idx',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   		,{formatter:gridCellNoneFormatter,field:'m_in_condition_name',id:'m_in_condition_name',name:'선행조건명',width:320,headerCssClass:'cellCenter',cssClass:'cellLeft'}	 
	   		,{formatter:gridCellNoneFormatter,field:'m_in_condition_date',id:'m_in_condition_date',name:'일자유형',width:80,headerCssClass:'cellCenter',cssClass:'cellLeft'}	   		
	   		,{formatter:gridCellNoneFormatter,field:'m_in_condition_and_or',id:'m_in_condition_and_or',name:'구분',width:80,headerCssClass:'cellCenter',cssClass:'cellLeft'}
	   		   		
	   	]
		,rows:[]  
		,vscroll:false
	};
	
	var gridObj_4 = {
		id : "<%=gridId_4 %>"
		,colModel:[
			{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'grid_idx',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   		,{formatter:gridCellNoneFormatter,field:'m_out_condition_name',id:'m_out_condition_name',name:'자기작업 CONDITION',width:320,headerCssClass:'cellCenter',cssClass:'cellLeft'}	 
	   		,{formatter:gridCellNoneFormatter,field:'m_out_condition_date',id:'m_out_condition_date',name:'일자유형',width:75,headerCssClass:'cellCenter',cssClass:'cellLeft'}	   		
	   		,{formatter:gridCellNoneFormatter,field:'m_out_condition_effect',id:'m_out_condition_effect',name:'구분',width:75,headerCssClass:'cellCenter',cssClass:'cellLeft'}  		
	   		
	   	]
		,rows:[]
		,vscroll:false
	};
	
	function PopulateSelect(select, dataSource, addBlank) {
	  var index, len, newOption;
	  if (addBlank) { select.appendChild(new Option('', '')); }
	  $.each(dataSource, function (value, text) {
	       newOption = new Option(text, value);
	      select.appendChild(newOption);
	 });
	}
		
	$(document).ready(function(){
		fn_verification_chng();
		var server_gb		= "<%=strServerGb%>";
		var session_dc_code	= "<%=strSessionDcCode%>";
		var session_user_gb	= "<%=S_USER_GB%>";
		
		$("#btn_ins").show();

		if ( server_gb == "P" ) {
			$("#btn_draft").show();
		}
		
		$("#btn_draft_admin").show();
		
		$("#data_center").val("");
		$("#application").val("");
		$("#group_name").val("");
		$("#node_id").val("");
		
		$("select[name='data_center_items']").val(session_dc_code);
		$("#data_center").val(session_dc_code);
		
		mHostList();
		
		var dataCenterText = $("select[name='data_center_items'] option:selected").text();
		var systemOption = "";
		if ( dataCenterText.indexOf("WINI") > -1) {
			systemOption = '<option value="">--선택--</option>';
			<%
			
			for ( int i = 0; i < systemGbList.size(); i++ ) {
				CommonBean bean = (CommonBean)systemGbList.get(i);
				strScodeNm = CommonUtil.E2K(bean.getScode_eng_nm());
				if(!strScodeNm.equals("U") && !strScodeNm.equals("P")){
			%>											
			systemOption += '<option value="<%=CommonUtil.E2K(bean.getScode_eng_nm())%>"><%=bean.getScode_nm()%></option>';
			<%
				}
			}
			%>
			$('#sSystemGb').find('option').remove();
			$('#sSystemGb').append(systemOption);
		} else if ( dataCenterText.indexOf("EXPERT") > -1) {
			systemOption = '<option value="">--선택--</option>';
			<%
			for ( int i = 0; i < systemGbList.size(); i++ ) {
				CommonBean bean = (CommonBean)systemGbList.get(i);
				strScodeNm = CommonUtil.E2K(bean.getScode_eng_nm());
				if(strScodeNm.equals("U")){
			%>											
			systemOption += '<option value="<%=CommonUtil.E2K(bean.getScode_eng_nm())%>"><%=bean.getScode_nm()%></option>';
			<%
				}
			}
			%>
			$('#sSystemGb').find('option').remove();
			$('#sSystemGb').append(systemOption);
		} else if ( dataCenterText.indexOf("CARD") > -1) {
			systemOption = '<option value="">--선택--</option>';
			<%
			for ( int i = 0; i < systemGbList.size(); i++ ) {
				CommonBean bean = (CommonBean)systemGbList.get(i);
				strScodeNm = CommonUtil.E2K(bean.getScode_eng_nm());
				if(strScodeNm.equals("P")){
			%>											
			systemOption += '<option value="<%=CommonUtil.E2K(bean.getScode_eng_nm())%>"><%=bean.getScode_nm()%></option>';
			<%
				}
			}
			%>
			$('#sSystemGb').find('option').remove();
			$('#sSystemGb').append(systemOption);
		}
		
		$("#data_center_items").change(function(){
			
			//초기화
			$("#table_nm").val("");
			$("#table_of_def").val("");
			
			$("select[name='application_of_def'] option").remove();
			$("select[name='application_of_def']").append("<option value=''>--선택--</option>");	
			
			$("select[name='group_name_of_def'] option").remove();
			$("select[name='group_name_of_def']").append("<option value=''>--선택--</option>");	
												
			if($(this).val() != ""){

				var scode_cd = $("select[name='data_center_items'] option:selected").val();
				$("#data_center").val(scode_cd);		//data_center 에 값 셋
				$("#application").val("");
				$("#group_name").val("");
				$("#node_id").val("");
			}
			
			$("#sSystemGb").val("");
			$("#sJobTypeGb").val("");
			
			$("#host_id").val("");
			$("#owner").val("");
			
			//CONDITION
			var obj1Cnt = gridObj_1.rows.length;
			var obj2Cnt = gridObj_2.rows.length;
			
			if(obj1Cnt > 0){
				for(var i=0; i<obj1Cnt; i++){
					dataDelete(1, "1");
				}
			}
			
			if(obj2Cnt > 0){
				for(var i=0; i<obj2Cnt; i++){
					dataDelete(1, "2");
				}
			}
			
			// 시스템 구분 동적 변경
// 			fnSystemGbSet($("select[name='data_center_items'] option:selected").text()); 
			
		});
		
		$("#application_of_def").change(function(){
						
			var aTmp = $(this).val().split(",");
			
			$("#application").val(aTmp[1]);
			getAppGrpCodeList("", "3", "", "group_name_of_def", aTmp[1]);
			
		});
		
		$("#group_name_of_def").change(function(){
			
			$("select[name='host_id'] option").remove();
			$("select[name='host_id']").append("<option value=''>--선택--</option>");
			$("#node_id").val("");
			
			$("select[name='owner'] option").remove();
			$("select[name='owner']").append("<option value=''>--선택--</option>");
						
			var aTmp = $(this).val().split(",");
			
			$("#group_name").val(aTmp[1]);
			
			//서버내역 가져오기
			mHostList(aTmp[1]);
	
		});
// 		$("#btn_clear1").unbind("click").click(function(){
// 			$("#frm1").find("input[name='scode_nm']").val("");
// 		});
// 		$("#btn_clear2").unbind("click").click(function(){
// 			$("#frm1").find("input[name='active_from']").val("");
// 		});
		
// 		$("#btn_clear3").unbind("click").click(function(){
// 			$("#frm1").find("input[name='active_till']").val("");
// 		});
		
		
		$("#host_id").change(function(){ 
			
			$("select[name='owner'] option").remove();
			$("select[name='owner']").append("<option value=''>--선택--</option>");
						
			var aTmp = $(this).val().split(",");
			
			$("#node_id").val(aTmp[1]);
			
			sCodeList();
		});
		
		//Critical_yn 0 or 1 저장
		$("#critical_yn").change(function(){ 			
			$("#critical").val($(this).val());			
		});
		
		$("#btn_addConditionsIn").button().unbind("click").click(function(){
			popJobsForm('1');
		});
		
		$("#btn_addStep").button().unbind("click").click(function(){
			addSteps();
		});
		
		$("#btn_delStep").button().unbind("click").click(function(){
			delSteps();
		});
		
		$("#btn_delConditionsIn").button().unbind("click").click(function(){
			
			var cnt = 0;
			var row_idx = 0;
			var aSelRow = new Array;
			aSelRow = $('#'+gridObj_1.id).data('grid').getSelectedRows();		
			
			if(aSelRow.length>0){
				for(var i=0;i<aSelRow.length;i++){				
					row_idx = getCellValue(gridObj_1,aSelRow[i],'grid_idx');
					
					++cnt;
				}
			}else{
				alert("삭제하려는 항목을 선택해 주세요.");
				return;
			}
			
			if(cnt > 1){
				alert("한개의 항목만 선택해 주세요.");
				return;
			}
			
			if(cnt == 1){
				if(confirm("선택한 항목을 삭제하시겠습니까?")){
					dataDelete(row_idx, "1");
				}
			}
			
		});	
		
		$("#btn_addConditionsOut").button().unbind("click").click(function(){
			
			if ( rowsObj_job2.length > 0 ) {			
				popJobsForm('2');
			} else {
				alert("OUT_CONDITION 추가 전 작업명 확인을 클릭하세요");
				return;
			}
		});
		
		$("#btn_delConditionsOut").button().unbind("click").click(function(){
			
			var cnt = 0;
			var row_idx = 0;
			var aSelRow = new Array;
			aSelRow = $('#'+gridObj_2.id).data('grid').getSelectedRows();		
			
			if(aSelRow.length>0){
				for(var i=0;i<aSelRow.length;i++){				
					row_idx = getCellValue(gridObj_2,aSelRow[i],'grid_idx');
					
					++cnt;
				}
			}else{
				alert("삭제하려는 항목을 선택해 주세요.");
				return;
			}
			
			if(cnt > 1){
				alert("한개의 항목만 선택해 주세요.");
				return;
			}
			
			if (row_idx == 1) {
				alert("자기작업 CONDITION은 삭제할 수 없습니다.");
				return;
			}
			
			if(cnt == 1){
				if(confirm("선택한 항목을 삭제하시겠습니까?")){
					dataDelete(row_idx, "2");
				}
			}
		});
		
		$("#btn_argmt_add").button().unbind("click").click(function(){
			
			popArgForm("argmt");
		});
		$("#btn_parm_add").button().unbind("click").click(function(){
			
			popArgForm("parm");
		});
		
		$("#btn_argmt_del").button().unbind("click").click(function(){
			getArgDel();
		});
		
		
		//작업명 후행 등록
		$("#btn_nameDupChk").button().unbind("click").click(function(){
			
			
			var job_nm = $("#job_name").val();
			var data_center = $("#data_center").val();

			if(job_nm == ''){
				alert("작업명을 입력 하세요.");
				return;
			}
			
			var formData = new FormData();
			formData.append("c", "JobNameDupCheck");
			formData.append("job_name", job_nm);
			formData.append("data_center", data_center);
			
			$.ajax({
				url: "<%=sContextPath %>/tWorks.ez",
				type: "post",
				processData: false,
				contentType: false,
				dataType: "text",
				data: formData,
				success: completeHandler = function(data){
					
					var result = data;
					
					// 앞뒤 공백 제거.
	    			result = result.replace(/^\s+|\s+$/g,"");
				
					if(result == "Y") {						
						alert("중복된 작업명이 있습니다.\n" + job_nm );
						return;
					}else{
						alert("[" + job_nm + "] 사용할 수 있는 작업명 입니다.\n자기작업 CONDITION에 추가한 CONDITION목록은 초기화됩니다.");
						
						//getPreAfterJobs("2");
						$("#job_nameChk").val("1");
						
						// 이미 자기작업 CONDITION이 존재하면.
						if ( rowsObj_job2.length > 0 ) {
							
							var nm = "job_out_cond_nm1";
							
							$("#"+nm).val(job_nm);
							
							var obj2Cnt = gridObj_2.rows.length;
							var globYn = $("select[name='globalCond_yn']").val();
							if(obj2Cnt > 0){
								for(var i=0; i<obj2Cnt; i++){
									dataDelete(1, "2");
								}
							}else{
								dataDelete(1, "2");
							}
							
							setPreAfterJobs(job_nm, "2");
							
							if(globYn == '1'){
								setPreAfterJobs("GLOB-"+job_nm, "2");
								$("select[name='globalCond_yn']").val("1");
							}
						} else {
							setPreAfterJobs(job_nm, "2");
						}
					}
				},
				error: function(data2){
					alert("error:::"+data2);
				}
			});			
		
		});
		
		//작업종료시간을 받아서 시간그룹을 SET 해준다.
		
	
		
		
		//작업시작시간을 받아서 시간그룹을 SET 해준다.
		
		$("#sHour").change(function(){
			
			$("#time_group").val("");
			
			$("#time_from").val("");
			
			var sHour = $("select[name='sHour'] option:selected").val();
			var sMin = $("select[name='sMin'] option:selected").val();
			
			if(sHour == ''){
				$("#time_from").val('');
				$("select[name='sHour']").val("");
				$("select[name='sMin']").val("");
				return;
			}
			$("#time_group").val(sHour);
			
			$("#time_from").val(sHour+sMin);
					
		});
		
		//작업시작시간의 시간, 분을 받아서 from_time을 SET 해준다.
		
		$("#sMin").change(function(){
			
			$("#time_from").val("");
			
			var sHour =  $("#sHour").val();
			var sMin = $("#sMin").val();
			
			if(sHour == ''){
				alert("작업시작시간의 '시'항목을 '분' 보다 먼저 입력해 주세요");
				$("#time_from").val('');
				$("select[name='sHour']").val("");
				$("select[name='sMin']").val("");
				return;
			}
			
			if(sMin == ''){
				$("#time_from").val('');
				$("select[name='sHour']").val("");
				$("select[name='sMin']").val("");
				return;
				
			}
			
			$("#time_from").val(sHour+sMin);
					
		});	
		
		
		$("#eHour").change(function(){
			
			$("#time_until").val("");
			
			var eHour = $("select[name='eHour'] option:selected").val();
			var eMin = $("select[name='eMin'] option:selected").val();
			
			if(eHour == ''){
				$("#time_until").val('');
				$("select[name='eHour']").val("");
				$("select[name='eMin']").val("");
				return;
			}
			
			$("#time_until").val(eHour+eMin);
					
		});
		
		//작업종료시간의 시간, 분을 받아서 from_time을 SET 해준다.
		
		$("#eMin").change(function(){
			
			$("#time_until").val("");
			
			var eHour =  $("select[name='eHour'] option:selected").val();
			var eMin = $("select[name='eMin'] option:selected").val();
			
			if(eHour == ''){
				alert("작업종료시간의 '시' 항목을 '분' 보다 먼저 입력해 주세요");
				$("#time_until").val('');
				$("select[name='eHour']").val("");
				$("select[name='eMin']").val("");
				return;				
			}
			
			if(eMin == ''){
				$("#time_until").val('');
				$("select[name='eHour']").val("");
				$("select[name='eMin']").val("");
				return;
			}
			
			$("#time_until").val(eHour+eMin);
					
		});
		
		
		
		//시작임계시간의 시간, 분을 받아서 late_sub을 SET 해준다.
		
		$("#slate_sub_h").change(function(){
			
			$("#late_sub").val("");
			
			var slate_sub_h =  $("select[name='slate_sub_h'] option:selected").val();
			var slate_sub_m = $("select[name='slate_sub_m'] option:selected").val();
			
			if(slate_sub_h == ''){
				alert("시작임계시간의 '시' 항목을 '분' 보다 먼저 입력해 주세요");
				
				$("select[name='slate_sub_h']").val("");
				$("select[name='slate_sub_m']").val("");
				$("#late_sub").val('');
				return;
			}
			
			$("#late_sub").val(slate_sub_h+slate_sub_m);
					
		});		
		
		//시작임계시간의 시간, 분을 받아서 late_sub을 SET 해준다.		
		$("#slate_sub_m").change(function(){
			
			$("#late_sub").val("");
			
			var slate_sub_h =  $("select[name='slate_sub_h'] option:selected").val();
			var slate_sub_m = $("select[name='slate_sub_m'] option:selected").val();
			
			if(slate_sub_h == ''){
				alert("시작임계시간의 '시' 항목을 '분' 보다 먼저 입력해 주세요");
				
				$("select[name='slate_sub_h']").val("");
				$("select[name='slate_sub_m']").val("");
				$("#late_sub").val('');
				return;
			}
			
			if(slate_sub_m == ''){
				
				$("select[name='slate_sub_h']").val("");
				$("select[name='slate_sub_m']").val("");
				$("#late_sub").val('');
				return;
			}
			
			$("#late_sub").val(slate_sub_h+slate_sub_m);
					
		});	
		
		
		//종료임계시간의 시간, 분을 받아서 late_sub을 SET 해준다.
		
		$("#slate_time_h").change(function(){
			
			var slate_time_h =  $("select[name='slate_time_h'] option:selected").val();
			
			if(slate_time_h == ''){
				$("select[name='slate_time_h']").val("");
				$("select[name='slate_time_m']").val("");
				$("#late_time").val("");
				return;
			}
			$("#late_time").val(slate_time_h+slate_time_m);
		});
		
		$("#slate_time_m").change(function(){
			
			$("#late_time").val("");
			
			var slate_time_h =  $("select[name='slate_time_h'] option:selected").val();
			var slate_time_m = $("select[name='slate_time_m'] option:selected").val();
			
			if(slate_time_h == ''){
				alert("시작임계시간의 '시' 항목을 '분' 보다 먼저 입력해 주세요");
				$("select[name='slate_time_h']").val("");
				$("select[name='slate_time_m']").val("");
				$("#late_time").val("");
				return;
				
			}
			
			if(slate_time_m == ''){
				$("select[name='slate_time_h']").val("");
				$("select[name='slate_time_m']").val("");
				$("#late_time").val("");
				return;
			}
			
			$("#late_time").val(slate_time_h+slate_time_m);
					
		});		
		
		// 글로벌 컨디션 발행이 'Y' 이면 후행 조건에 GLOBAL 컨디션을 입력 한다.
		
		$("#globalCond_yn").change(function(){
			
			var job_nm = $("#job_name").val();
			var globalCond_yn = $("select[name='globalCond_yn'] option:selected").val();
			
			if($("#job_name").val() == ''){
				alert("작업명을 입력 하세요.");
				$("select[name='globalCond_yn']").val("N");
				
				return;
			}
			
			if(globalCond_yn == "0"){
				getPreAfterJobs("2");	
			}else{
				setPreAfterJobs("GLOB-"+job_nm, "2");	
			}
		});
		
		$("#sJobTypeGb").change(function(){
			
			var jobTypeGb = $("select[name='sJobTypeGb'] option:selected").val();
			
			// 작업유형구분에 따라 작업타입 변경.
			if ( $("#jobTypeGb").val() == "F" ) {
				
// 				$("#task_type").val("job");
				$("#ctmfw").show();
				
				$("#mem_lib").val("");
				$("#mem_lib").attr("disabled", false);
				
				$("#mem_name").val("");
				$("#mem_name").attr("disabled", false);
				
			} else if( $("#jobTypeGb").val() == "D" ) {
				
// 				$("#task_type").val("dummy");
				
				$("#ctmfw").hide();
				
				$("#mem_lib").val("/");
				$("#mem_lib").attr("disabled", true);
				
				$("#mem_name").val("DUMMY");
				$("#mem_name").attr("disabled", true);
				
				$("#command").val("DUMMY");
				
			} else {
				
				$("#task_type").val("SMART Table");
				$("#ctmfw").hide();
				
				$("#mem_lib").val("");
				$("#mem_lib").attr("disabled", false);
				
				$("#mem_name").val("");
				$("#mem_name").attr("disabled", false);
			}
								
		});
		
		$("#btn_ins").button().unbind("click").click(function(){
			goPrc('ins');
		});	
		$("#btn_draft").button().unbind("click").click(function(){
			goPrc('draft');
		});	
		$("#btn_draft_admin").button().unbind("click").click(function(){
			goPrc('draft_admin');
		});	


		$("#btn_srSearch").button().unbind("click").click(function(){
			popupSrForm();
		});
		
		$("#btn_srClear").button().unbind("click").click(function(){
			srClear();
		});
		
		$("#btn_search1").button().unbind("click").click(function(){
			goUserSearch("1");
		});
		$("#btn_search2").button().unbind("click").click(function(){
			goUserSearch("2");
		});
		$("#btn_search3").button().unbind("click").click(function(){
			goUserSearch("3");
		});
		$("#btn_search4").button().unbind("click").click(function(){
			goUserSearch("4");
		});
		
		$("#btn_cyclic").button().unbind("click").click(function(){
			fn_cyclic_popup();
		});
		
		$("#btn_del1").button().unbind("click").click(function(){
		
			alert("담당자 값이 없을시 기안자가 담당자가 됩니다.");
			
		});
		$("#btn_del2").button().unbind("click").click(function(){
			if($("#user_nm_2_0").val("") == ""){
				alert("담당자2 값이 없습니다.");
				return ;
			}
			$("#user_nm_2_0").val("");
			$("#user_cd_2_0").val("");
		});

		$("#btn_del3").button().unbind("click").click(function(){
			if($("#user_nm_3_0").val("") == ""){
				alert("담당자3 값이 없습니다.");
				return ;
			}
			
			$("#user_nm_3_0").val("");
			$("#user_cd_3_0").val("");
		});

		$("#btn_del4").button().unbind("click").click(function(){
			if($("#user_nm_4_0").val("") == ""){
				alert("담당자4 값이 없습니다.");
				return ;
			}
			$("#user_nm_4_0").val("");
			$("#user_cd_4_0").val("");
		});
		
		$("#table_name").unbind("keyup").keyup(function(){

			$("#job_name").val($(this).val());	
		});
	
		$("#mem_lib").unbind("keyup").keyup(function(){
			
			var mem_name = $("#mem_name").val();
// 			var arg_val = $("#arg_val").val();
// 			var command = $(this).val() + mem_name + " "+ arg_val;
			var command = $(this).val() + mem_name;
			
			$("#command").val(command);			
		});
		
		$("#mem_name").unbind("keyup").keyup(function(e){
			
			var mem_lib = $("#mem_lib").val();
// 			var arg_val = $("#arg_val").val();
//			var command =  mem_lib + $(this).val() + " "+ arg_val;
			var command =  mem_lib + $(this).val();
			
			$("#command").val(command);		
		});
		
		/* $("#arg_val").unbind("keyup").keyup(function(e){
			
			var mem_lib = $("#mem_lib").val();
			var mem_name = $("#mem_name").val();
			var command =  mem_lib + mem_name + " "+ $(this).val();
			
			$("#command").val(command);		
		}); */
		
		
	

		$("#f_s").find("input[name='p_apply_date']").val("${NEXT_ODATE}");
		
// 		$("#active_from").addClass("ime_readonly").unbind('click').click(function(){
// 			dpCalMinMax(this.id,'yymmdd','0','90');
// 		});	
		
// 		$("#active_till").addClass("ime_readonly").unbind('click').click(function(){
// 			dpCalMinMax(this.id,'yymmdd','0','90');
// 		});
		
		/* $("#m_step_condition_date").addClass("ime_readonly").unbind('click').click(function(){
			dpCalMinMax(this.id,'yymmdd','1','90');
		}); */
		
		//테이블 클릭 시
		$("#table_nm").click(function(){
			var data_center = $("select[name='data_center_items'] option:selected").val();
			
			if(data_center == ""){
				alert("C-M 을 선택해 주세요.");
				return;
			}else{
				$("#p_app_eng_nm").val("");
				poeTabForm();
			}		
		});
		
		// 어플리케이션 클릭시
		/* $("#app_nm").click(function(){
			var data_center = $("select[name='data_center_items'] option:selected").val();
			
			if(data_center == ""){
				alert("C-M 을 선택해 주세요.");
				return;
			}else{
				poeAppForm();
			}		
		}); */
		
		$("#mem_lib").click(function(){
			alert("NT 수행서버의 구분자  '\\\\'를 입력 하셔야 합니다 \n'"+" EX : (c:\\\\test\\\\) \n"+"  NT 수행 서버가 아닌 경우 구분자는 '/' 로 입력 하셔야 합니다 \n"+"  EX: (/test/ )'");			
		});
		
		// 캘린더		
		$("#btn_sched").button().unbind("click").click(function(){
			
			/*
			if($("#job_nameChk").val() == "0"){
				alert("작업명 확인을 클릭하세요");
				return;				
			}
			var data_center = $("#data_center").val();
			if(data_center == ""){
				alert("C-M 을 선택해 주세요.");
				return;
			}
			*/
			
			popSchedForm();
		});
		// 캘린더 제거
		$("#btn_schedDel").button().unbind("click").click(function(){
			$("#cal_cd").val("");
			$("#cal_nm").val("");
			$("#days_cal").val("");
			$("#days_and_or").val("");
			$("#weeks_cal").val("");
			$("#week_days").val("");
			$("#use_gb").val("");
			$("#use_yn").val("");
			$("#month_cal").val("");
			$("#month_days").val("");
			$("#conf_cal").val("");
			$("#shift").val("");
			$("#shift_num").val("");
		});
		
		$("#btn_CalDetail").button().unbind("click").click(function(){			
			
			var data_center = $("#data_center").val();
			if(data_center == ""){
				alert("C-M 을 선택해 주세요.");
				return;
			}			
			
			fn_sch_forecast();
		});
		
		$("#btn_schedInfo").button().unbind("click").click(function(){
			
			if($("#tab_yn").val() == "0"){
				
				if($("#cal_nm").val() == ""){
					alert("캘린더명을 입력하세요.");
					return;
				}			
				//$("#schedInfo").show();
				$("#tab_yn").val("1");
			}else{
				//$("#schedInfo").hide();
				$("#tab_yn").val("0");
			}
		});
		
		$("#btn_addUserVar").button().unbind("click").click(function(){
			addUserVars();
		});

		/*
		$("#description").unbind("keyup").keyup(function(){
			if($("#job_nameChk").val() == "0"){
				alert("작업명 확인을 클릭하세요");
				return;				
			}
			
		});
		$("#error_description").unbind("keyup").keyup(function(){				
			if($("#job_nameChk").val() == "0"){
				alert("작업명 확인을 클릭하세요");
				return;				
			}
		});
		*/
		
		viewGrid_2(gridObj_1,"ly_"+gridObj_1.id);
		viewGrid_2(gridObj_2,"ly_"+gridObj_2.id);
		
		viewGrid_1(gridObj_3,"ly_"+gridObj_3.id);
		viewGrid_1(gridObj_4,"ly_"+gridObj_4.id);
		
		$("#verification_yn").change(function(){
			fn_verification_chng();
		});
		
	});
	function fn_verification_chng(){
		var verification_yn = $('#verification_yn').val();
		
		if(verification_yn == "Y"){
			$('#sysout_font').show();
			$('#standard_sysout').attr("disabled", false); 
		}else{
			$('#sysout_font').hide();
			$('#standard_sysout').attr("disabled", true); 
		}
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
	
	function goUserSeqSelect(cd, nm, btn){
	
		var frm1 = document.frm1;
		
		if(btn == "1"){
			frm1.user_nm_1_0.value = nm;
			frm1.user_cd_1_0.value = cd;
			
		}else if(btn == "2"){
			frm1.user_nm_2_0.value = nm;
			frm1.user_cd_2_0.value = cd;
			
		}else if(btn == "3"){
			frm1.user_nm_3_0.value = nm;
			frm1.user_cd_3_0.value = cd;
			
		}else if(btn == "4"){
			frm1.user_nm_4_0.value = nm;
			frm1.user_cd_4_0.value = cd;
			
		}
	
		dlClose('dl_tmp3');
	}
	
	function fn_cyclic_set(cyclic_value){

		var form = document.frm1;

		if ( cyclic_value == "1" ) {
						
			form.max_wait.value = "0";

			document.getElementById('cyclic_ment').style.display = "";

			form.rerun_max.readOnly = "";

		} else {
			
			form.max_wait.value 		= "<%=strDefaultMaxWait%>";
			form.rerun_interval.value 	= "false";

			form.rerun_interval.value 		= "";
			form.rerun_interval_time.value 	= "";
			form.cyclic_type.value 			= "";
			form.count_cyclic_from.value 	= "";
			form.interval_sequence.value 	= "";
			form.tolerance.value 			= "";
			form.specific_times.value 		= "";

			document.getElementById('cyclic_ment').innerHTML		= "";
			document.getElementById('cyclic_ment').style.display 	= "none";

			form.rerun_max.value 		= "0";
			form.rerun_max.readOnly 	= "true";
		}
	}



	function fn_cyclic_popup() {

		var frm = document.frm1;

		var cyclic = document.getElementById('cyclic').value;

		if ( cyclic == "0" ) {
			if( !confirm('반복작업이 아닙니다.\n반복작업으로 설정 하시겠습니까?') ) return;
		}

		document.getElementById('cyclic').value = "1";
		fn_cyclic_set('1');		

		openPopupCenter1("about:blank","popupCyclic",450,400);
		
		frm.action = "<%=sContextPath %>/tPopup.ez?c=ez005";
		frm.target = "popupCyclic";    
		frm.submit();
	}
	
	
	//Step
	function getCodeList(scode_cd, grp_depth, grp_cd, val){
		
		try{viewProgBar(true);}catch(e){}
				
		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=appGrpCodeList&itemGubun=2&scode_cd='+scode_cd+'&grp_depth='+grp_depth+'&grp_cd='+grp_cd;
		
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
								var grp_eng_nm = $(this).find("GRP_ENG_NM").text();
								var grp_desc = $(this).find("GRP_DESC").text();
								var grp_all_cd = grp_cd+","+grp_eng_nm;
																																																								
								$("select[name='"+val+"']").append("<option value='"+grp_all_cd+"'>"+grp_desc+"</option>");
								
							});						
						}									
						
					});
					try{viewProgBar(false);}catch(e){}
				}
		, null );
		
		xhr.sendRequest();
	}
	
	//선/후행 폼
	function popJobsForm(gb){
		
		var data_center = $("#data_center").val();	
		var application = $("#application").val();
		var group_name = $("#group_name").val();
	
		if(data_center == ""){
			alert("C-M 을 선택해 주세요.");
			return;
		}
		
		/* if(application == ""){
			alert("어플리케이션(L3)을 선택해 주세요.");
			return;
		}
		
		if(group_name == ""){
			alert("어플리케이션(L4)을 선택해 주세요.");
			return;
		} */
		
		var sHtml1="<div id='dl_tmp1' style='overflow:hidden;display:none;padding:0;border-top:1px solid blue;border-bottom:1px solid blue;border-left:1px solid blue;border-right:1px solid blue;'>";
		sHtml1+="<form id='form1' name='form1' method='post' onsubmit='return false;'>";
		sHtml1+="<input type='hidden' name='search_gubun' id='search_gubun' value='job_name' />";
		sHtml1+="<table style='width:100%;height:260px;;border:none;'><tr><td style='vertical-align:top;height:100%;width:500px;text-align:right;'>";
		sHtml1+="<div class='ui-widget-header ui-corner-all'>C-M : <select name='v_data_center' id='v_data_center' style='height:21px;'>";
		sHtml1+="<option value=''>--선택--</option>";
		<c:forEach var="inCond_cm" items="${inCond_cm}" varStatus="status">
			sHtml1+="<option value='${inCond_cm.scode_cd},${inCond_cm.scode_eng_nm}'>${inCond_cm.scode_nm}</option>"
		</c:forEach>;
		sHtml1+="</select>&nbsp;";
		sHtml1+="작업명 : <input type='text' name='pre_search_text' id='pre_search_text' value='' />&nbsp;&nbsp;<span id='btn_pre_search' style='margin:3px;'>검색</span></div>";
		sHtml1+="<table style='width:100%;height:100%;border:none;'>";
		sHtml1+="<tr><td id='ly_g_tmp1' style='vertical-align:top;' >";
		sHtml1+="<div id='g_tmp1' class='ui-widget-header ui-corner-all'></div>";
		sHtml1+="</td></tr>";
		sHtml1+="<tr style='height:10px;'><td style='vertical-align:top;'><h5 class='ui-widget-header ui-corner-all' >";
		sHtml1+="<div align='right' class='btn_area_s'>";
		sHtml1+="<div id='ly_total_cnt_1' style='padding-top:5px;float:left;'></div>";
		sHtml1+="</div>";
		sHtml1+="</h5></td></tr></table>";
		
		sHtml1+="</td></tr></table>";
		
		sHtml1+="</form>";
		
		$('#dl_tmp1').remove();
		$('body').append(sHtml1);
		
		dlPop02('dl_tmp1',"컨디션검색 ",570,300,false);
					
		var gridObj = {
			id : "g_tmp1"
			,colModel:[
		   		{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'번호',width:50,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}	   		
		   		,{formatter:gridCellNoneFormatter,field:'APPLICATION',id:'APPLICATION',name:'어플리케이션',width:120,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}	 
		   		,{formatter:gridCellNoneFormatter,field:'GROUP_NAME',id:'GROUP_NAME',name:'그룹',width:120,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}	   		
		   		,{formatter:gridCellNoneFormatter,field:'JOB_NAME',id:'JOB_NAME',name:'작업명',width:200,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
		   		,{formatter:gridCellNoneFormatter,field:'CHOICE',id:'CHOICE',name:'선택',width:50,headerCssClass:'cellCenter',cssClass:'cellCenter'}
		   		
		   		,{formatter:gridCellNoneFormatter,field:'JOB_ID',id:'JOB_ID',name:'JOB_ID',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
		   		,{formatter:gridCellNoneFormatter,field:'TABLE_ID',id:'TABLE_ID',name:'TABLE_ID',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
		   	]
			,rows:[]
			,vscroll:<%=S_GRID_VSCROLL%>
		};
		
		$("#v_data_center").val(data_center);
		$("#doc_data_center").val(data_center);
		$("#pre_search_text").focus();
		
		viewGrid_1(gridObj,'ly_'+gridObj.id);
		//popJobsList('',gb);
		
		$('#pre_search_text').placeholder().unbind('keypress').keypress(function(e){
			if(e.keyCode==13){
				
				if($(this).val() == ""){
					//popJobsList($(this).val(), gb);
					alert("작업명을 입력해주세요.");
					return;
				}else{
					var v_data_center = $("select[name='v_data_center'] option:selected").val();
					
					if(v_data_center == ""){
						alert("C-M 을 선택해 주세요.");
						return;
					}
					
					popJobsList($(this).val(), gb);
				}
			}
		});		
		
		$("#btn_pre_search").button().unbind("click").click(function(){
			
			var search_text = $("#form1").find("input[name='pre_search_text']").val();
			
			if(search_text == ""){
				//popJobsList(search_text, gb);
				alert("작업명을 입력해주세요.");
				return;
			}else{
				var v_data_center = $("select[name='v_data_center'] option:selected").val();
				
				if(v_data_center == ""){
					alert("C-M 을 선택해 주세요.");
					return;
				}
				
				popJobsList(search_text, gb);
			}
		});
		
	}
	
	function goPreJobSelect(job_nm, gb, flag){
		
		var v_job_name = "";
		
		if(flag == "direct"){
			v_job_name = document.getElementById('job_name0').value;
			if(v_job_name == ""){
				alert("직접입력에 작업명을 입력해 주세요.");
				return;
			}
		}else{
			v_job_name = job_nm;
		}
		
		setPreAfterJobs(v_job_name, gb);
		
		if(flag == "direct"){
			document.getElementById('job_name0').value = "";
		}
	}		
	
	//서버내역 가져오기
	function hostList(host_cd){		
		
		try{viewProgBar(true);}catch(e){}
				
		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=hostList&host_cd='+host_cd;
		
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
							$("select[name='host_id'] option").remove();
							$("select[name='host_id']").append("<option value=''>--선택--</option>");	
						}else{
							$("select[name='host_id'] option").remove();
							$("select[name='host_id']").append("<option value=''>--선택--</option>");			
							
							items.find('item').each(function(i){						
							
								var host_cd = $(this).find("HOST_CD").text();								
								var node_id = $(this).find("NODE_ID").text();
								var node_nm = $(this).find("NODE_NM").text();
								var all_cd = host_cd+","+node_id;
								var all_nm = node_nm+"("+node_id+")";
																
								$("select[name='host_id']").append("<option value='"+all_cd+"'>"+all_nm+"</option>");
								
							});						
						}
												
					});
					try{viewProgBar(false);}catch(e){}
				}
		, null );
		
		xhr.sendRequest();
	}

//서버계정가져오기
	function sCodeList(){
		
		try{viewProgBar(true);}catch(e){}
		
		var host_id = $("select[name='host_id'] option:selected").val();	
		var host_cdnm = host_id.split(",");
		var host_cd = host_cdnm[0];
				
		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=sCodeList&user_gb=<%=S_USER_GB %>&host_cd='+host_cd+'&mcode_cd=${SERVER_MCODE_CD}';
		
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
							$("select[name='owner'] option").remove();
							$("select[name='owner']").append("<option value=''>--선택--</option>");	
						}else{
							
							$("select[name='owner'] option").remove();
							$("select[name='owner']").append("<option value=''>--선택--</option>");	
							
							items.find('item').each(function(i){						
							
								var scode_cd = $(this).find("SCODE_CD").text();
								var scode_nm = $(this).find("SCODE_NM").text();								
								var scode_eng_nm = $(this).find("SCODE_ENG_NM").text();							
								var host_cd = $(this).find("HOST_CD").text();
															
								$("select[name='owner']").append("<option value='"+scode_eng_nm+"'>"+scode_nm+"</option>");
							});						
						}						
					
					});
					try{viewProgBar(false);}catch(e){}
				}
		, null );
		
		xhr.sendRequest();
	}
	
	function setPreAfterJobs(job_nm, gb){
		
		var m_in_condition_name = "";
		var m_in_condition_date = "";
		var m_in_condition_and_or = "";		
		
		var m_out_condition_name = "";
		var m_out_condition_date = "";
		var m_out_condition_effect = "";
		
		
		var i = 0;
		var val = "";
		
		if(gb == "1"){
			i = rowsObj_job1.length+1;
			val = "_in_cond_nm"+i;
		}else if(gb == "2"){
			i = rowsObj_job2.length+1;
			val = "_out_cond_nm"+i;
		}
		
		if(job_nm != ""){
			//INCONDITION  설정
			if(gb == "1"){
				
				var dup_cnt = 0;				
				setGridSelectedRowsAll(gridObj_1);		//중복체크를 위해 전체항목 선택
				
				var aSelRow = new Array;
				aSelRow = $('#'+gridObj_1.id).data('grid').getSelectedRows();
							
				if(aSelRow.length>0){
					for(var j=0;j<aSelRow.length;j++){						
						var v_cond_nm = getCellValue(gridObj_1,aSelRow[j],'chk_condition_name');		
						
						if(v_cond_nm == job_nm){
							++dup_cnt;
							break;
						}
					}
				}
								
				clearGridSelected(gridObj_1)		//선택된 전체항목 해제 */
				
				if(dup_cnt > 0){	//중복된 내용이 있다면 (잡명)
					alert("이미 등록된 내용 입니다.");
					return;
				}else{
							
					rowsObj_job1.push({
						'grid_idx':i
						,'m_in_condition_name': job_nm
						,'m_in_condition_date': 'ODAT'
						,'m_in_condition_and_or': 'and'		
						,'chk_condition_name': job_nm
					});
				
					gridObj_1.rows = rowsObj_job1;
					setGridRows(gridObj_1);
					
					alert("선택 항목이 추가 되었습니다.");
				}
							
			
			
			}else if(gb == "2"){
								
				var dup_cnt = 0;				
				setGridSelectedRowsAll(gridObj_2);		//중복체크를 위해 전체항목 선택
				
				var aSelRow = new Array;
				aSelRow = $('#'+gridObj_2.id).data('grid').getSelectedRows();
							
				if(aSelRow.length>0){
					for(var j=0;j<aSelRow.length;j++){						
						var v_cond_nm = getCellValue(gridObj_2,aSelRow[j],'m_out_condition_name');		
						
						if(v_cond_nm == job_nm){
							++dup_cnt;
							break;
						}
					}
				}
								
				clearGridSelected(gridObj_2)		//선택된 전체항목 해제 */
				
				if(dup_cnt > 0){	//중복된 내용이 있다면 (잡명)
					alert("이미 등록된 내용 입니다.");
					return;
				}else{	
				
					rowsObj_job2.push({
						'grid_idx':i
						,'m_out_condition_name': job_nm
						,'m_out_condition_date': 'ODAT'
						,'m_out_condition_effect': 'add'		
						,'chk_condition_name': job_nm
					});
					
					gridObj_2.rows = rowsObj_job2;
					setGridRows(gridObj_2);
					
					//alert("선택 항목이 추가 되었습니다.");
				}
			}
						
					
		}
	
	}
	
	function getPreAfterJobs(gb){
		
		if(gb == "1"){			
			var cnt = 0;
			var row_idx = rowsObj_job1.length;
						
			if(row_idx > 0){
				delGridRow(gridObj_1, row_idx-1);
			}			
			
		}else if(gb == "2"){
			var cnt = 0;
			var row_idx = rowsObj_job2.length;
						
			if (row_idx == 1) {
				alert("자기작업 CONDITION은 삭제할 수 없습니다.");
			} else if (row_idx > 1) {	
				for(var i=0; i<row_idx; i++){
					var outCondName = getCellValue(gridObj_2, i, "m_out_condition_name");
					if(outCondName.substring(0, 4) == "GLOB"){
						row_idx = i+1;
						dataDelete(row_idx, '2');
					}
				}
			}
		}
	}

	//입력변수 폼
	function popArgForm(flag){
				
		var sHtml1="<div id='dl_tmp1' style='overflow:hidden;display:none;padding:0;border-top:1px solid blue;border-bottom:1px solid blue;border-left:1px solid blue;border-right:1px solid blue;'>";
		sHtml1+="<form id='form1' name='form1' method='post' onsubmit='return false;'>";
		//sHtml1+="<input type='hidden' name='search_gubun' id='search_gubun' value='job_name' />";
		sHtml1+="<table style='width:100%;height:560px;;border:none;'><tr><td style='vertical-align:top;height:100%;width:500px;'>";
		//sHtml1+="날짜검색 : <input type='text' name='cur_date' id='cur_date' class='input datepick' onkeydown='return false;' readonly />&nbsp;&nbsp;<span id='btn_arg_search'>검색</span>";
		sHtml1+="변수명 : <input type='text' name='arg_eng_nm' id='arg_eng_nm' />&nbsp;&nbsp;날짜검색 : <input type='text' name='cur_date' id='cur_date' class='input datepick' onkeydown='return false;' readonly />&nbsp;&nbsp;<span id='btn_arg_search'>검색</span>";
		
		sHtml1+="<table style='width:100%;height:100%;border:none;'>";
		sHtml1+="<tr><td id='ly_g_tmp1' style='vertical-align:top;' >";
		sHtml1+="<div id='g_tmp1' class='ui-widget-header ui-corner-all'></div>";
		sHtml1+="</td></tr>";
		sHtml1+="<tr style='height:10px;'><td style='vertical-align:top;'><h5 class='ui-widget-header ui-corner-all' >";
		sHtml1+="<div align='right' class='btn_area_s'>";
		sHtml1+="<div id='ly_total_cnt' style='padding-top:5px;float:left;'></div>";
		sHtml1+="</div>";
		sHtml1+="</h5></td></tr></table>";
		
		sHtml1+="</td></tr></table>";
		
		sHtml1+="</form>";
		
		$('#dl_tmp1').remove();
		$('body').append(sHtml1);
		
		dlPop01('dl_tmp1',"입력변수내역",570,600,false);
				
		var gridObj = {
			id : "g_tmp1"
			,colModel:[
		   		{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'번호',width:50,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}	   		
		   		,{formatter:gridCellNoneFormatter,field:'SCODE_ENG_NM',id:'SCODE_ENG_NM',name:'변수명',width:120,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
		   		,{formatter:gridCellNoneFormatter,field:'SCODE_DESC',id:'SCODE_DESC',name:'설명',width:160,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}	
		   		,{formatter:gridCellNoneFormatter,field:'ARG_VALUE',id:'ARG_VALUE',name:'변환데이터',width:150,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}	 
		   		,{formatter:gridCellNoneFormatter,field:'CHOICE',id:'CHOICE',name:'선택',width:50,headerCssClass:'cellCenter',cssClass:'cellCenter'}
		   		
		   		,{formatter:gridCellNoneFormatter,field:'SCODE_CD',id:'SCODE_CD',name:'SCODE_CD',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
		   		,{formatter:gridCellNoneFormatter,field:'SCODE_NM',id:'SCODE_NM',name:'SCODE_NM',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
		   	]
			,rows:[]
			,vscroll:<%=S_GRID_VSCROLL%>
		};
		
		viewGrid_1(gridObj,'ly_'+gridObj.id);
		//argList(flag);
		
		var dt = $("#cur_date").val();
		var arg_eng_nm 	= $("#arg_eng_nm").val();
		argumentList(arg_eng_nm, dt, flag);
		
		$("#cur_date").addClass("ime_readonly").unbind('click').click(function(){
			dpCalMinMax(this.id,'yymmdd','-365','1');
		});
		
		$("#btn_arg_search").button().unbind("click").click(function(){
			var dt = $("#cur_date").val();
			var arg_eng_nm 	= $("#arg_eng_nm").val();
			argumentList(arg_eng_nm, dt, flag);
		});
	}
	
	//입력변수 가져오기
	function argList(flag){
		
		try{viewProgBar(true);}catch(e){}
		$('#ly_total_cnt').html('');
		
		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=sCodeList&mcode_cd=${ARGUMENT_MCODE_CD}&host_eng_nm=N';
		
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
					//변수 값 세팅 -- set
					
					if(flag == "parm"){
						$(xmlDoc).find('doc').each(function(){
							
						var items = $(this).find('items');
						var rowsObj = new Array();
						
						var scode_eng_nm0 = "<div class='gridInput_area'><input type='text' name='scode_eng_nm0' id='scode_eng_nm0' style='width:100%;'/></div>";
						var scode_desc0 = "<div class='gridInput_area'><input type='text' name='scode_desc0' id='scode_desc0' style='width:100%;'/></div>";
						var v_scode_eng_nm = $("#scode_eng_nm0").val();
						var v_scode_desc = $("#scode_desc0").val();
							
						rowsObj.push({
							'grid_idx':""							
							,'SCODE_CD': ""
							,'SCODE_NM': ""
							,'SCODE_ENG_NM': scode_eng_nm0
							,'SCODE_DESC': scode_desc0
							,'CHOICE':"<div><a href=\"javascript:goSelect4();\" ><font color='red'>[선택]</font></a></div>"
						});
							
						if(items.attr('cnt')=='0'){						
						}else{							
							items.find('item').each(function(i){						
								
								var scode_cd = $(this).find("SCODE_CD").text();
								var scode_nm = $(this).find("SCODE_NM").text();								
								var scode_eng_nm = $(this).find("SCODE_ENG_NM").text();	
								var scode_desc = $(this).find("SCODE_DESC").text();
								
								rowsObj.push({
									'grid_idx':i+1									
									,'SCODE_CD': scode_cd
									,'SCODE_NM': scode_nm
									,'SCODE_ENG_NM': scode_eng_nm
									,'SCODE_DESC': scode_desc	
									,'CHOICE':"<div><a href=\"javascript:goSelect2('"+scode_nm+"','"+scode_eng_nm+"');\" ><font color='red'>[선택]</font></a></div>"
								});
								
							});		
						}
					
						
						var obj = $("#g_tmp1").data('gridObj');
						obj.rows = rowsObj;
						setGridRows(obj);
						
						$('#ly_total_cnt').html('[ TOTAL : '+items.attr('cnt')+' ]');
						
					});
					try{viewProgBar(false);}catch(e){}
					
				//Argument 값 세팅 -- command
				}else if(flag == "argmt"){
					
					$(xmlDoc).find('doc').each(function(){
						
						var items = $(this).find('items');
						var rowsObj = new Array();
											
						if(items.attr('cnt')=='0'){						
						}else{							
							items.find('item').each(function(i){						
								
								var scode_cd = $(this).find("SCODE_CD").text();
								var scode_nm = $(this).find("SCODE_NM").text();								
								var scode_eng_nm = $(this).find("SCODE_ENG_NM").text();	
								var scode_desc = $(this).find("SCODE_DESC").text();
								
								scode_eng_nm = scode_eng_nm.substring(2, scode_eng_nm.length);
								
								rowsObj.push({
									'grid_idx':i+1									
									,'SCODE_CD': scode_cd
									,'SCODE_NM': scode_nm
									,'SCODE_ENG_NM': scode_eng_nm
									,'SCODE_DESC': scode_desc	
									,'CHOICE':"<div><a href=\"javascript:goSelectCommand('"+scode_nm+"','"+scode_eng_nm+"');\" ><font color='red'>[선택]</font></a></div>"
								});
								
							});		
						}						
					
						var obj = $("#g_tmp1").data('gridObj');
						obj.rows = rowsObj;
						setGridRows(obj);
						
						$('#ly_total_cnt').html('[ TOTAL : '+items.attr('cnt')+' ]');
						
					});
					try{viewProgBar(false);}catch(e){}
				}
			}
		, null );
		
		xhr.sendRequest();
	}
	
	function argumentList(arg_eng_nm, dt){
		
		try{viewProgBar(true);}catch(e){}
		$('#ly_total_cnt').html('');
		
		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=argumentList&itemGubun=2&mcode_cd=${ARGUMENT_MCODE_CD}&cur_date='+dt+'&arg_eng_nm='+arg_eng_nm;
		
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
						}else{							
							items.find('item').each(function(i){						
								
								var scode_cd = $(this).find("SCODE_CD").text();
								var scode_nm = $(this).find("SCODE_NM").text();								
								var scode_eng_nm = $(this).find("SCODE_ENG_NM").text();	
								var scode_desc = $(this).find("SCODE_DESC").text();
								var arg_value = $(this).find("ARG_VALUE").text();
								var use_yn = $(this).find("USE_YN").text();
								var choice = "";
								
								scode_eng_nm = scode_eng_nm.substring(2, scode_eng_nm.length);
								
								if(use_yn == "Y"){
									choice = "<div><a href=\"javascript:goSelectCommand('"+scode_nm+"','"+scode_eng_nm+"');\" ><font color='red'>[선택]</font></a></div>";
								}else{
									choice = "";
								}
								
								rowsObj.push({
									'grid_idx':i+1									
									,'SCODE_CD': scode_cd
									,'SCODE_NM': scode_nm
									,'SCODE_ENG_NM': scode_eng_nm
									,'SCODE_DESC': scode_desc	
									,'ARG_VALUE': arg_value
									,'CHOICE': choice
								});
								
							});		
						}						
					
						var obj = $("#g_tmp1").data('gridObj');
						obj.rows = rowsObj;
						setGridRows(obj);
						
						$('#ly_total_cnt').html('[ TOTAL : '+items.attr('cnt')+' ]');
						
					});
					try{viewProgBar(false);}catch(e){}
				}
		
		, null );
		
		xhr.sendRequest();
	}	
	
	//변수 입력 받는 TEXT select 박스
	function goSelect4(){
		var scode_eng_nm = $("#scode_eng_nm0").val();
		var scode_desc = $("#scode_desc0").val();	
		
		if(scode_eng_nm != "" && scode_desc != ""){
			goSelect2(scode_eng_nm, scode_desc);
			
			//선택버튼 클릭 후 값 초기화
			$("#scode_eng_nm0").val("");
			$("#scode_desc0").val("");
						
			dlClose('dl_tmp1');
		}else{
			alert("변수명 또는 설명을 입력하세요.");
			
			//선택버튼 클릭 후 값 초기화
			$("#scode_eng_nm0").val("");
			$("#scode_desc0").val("");			
						
			return;
		}
				
	}	
		
	function goSelect2(nm, desc){
				
		var arg_var = $("#arg_var").val();
		var arg_val = $("#arg_val").val();	
		var arg_code = $("#arg_code").val();
		
		var dup_cnt = 0;
		var lst_arg_val = "";
		var desc2 = desc.replace("º","%");
		
		if(arg_var == ""){
			arg_var += desc2;	
			arg_code += nm;
			
			$("#arg_var").val(arg_var);
			$("#arg_code").val(arg_code);
			
			lst_arg_val = nm+","+desc2;
			arg_val += lst_arg_val;
			$("#arg_val").val(arg_val);
			
		}else{			
			var arr_arg_code = arg_code.split(",");
						
			for(var i in arr_arg_code){
				if(nm == arr_arg_code[i]){
					++dup_cnt;
				}
			}
						
			if(dup_cnt == 0){
				arg_var += ","+desc2;
				arg_code += ","+nm;
				
				$("#arg_var").val(arg_var);
				$("#arg_code").val(arg_code);
				
				lst_arg_val = nm+","+desc2;
				
				if(arg_val == ""){
					arg_val += lst_arg_val;
				}else{
					arg_val += "|"+lst_arg_val;
				}				
			
				$("#arg_val").val(arg_val);
			}else{
				alert("이미 추가된 항목 입니다.");
				return;
			}
		}				
	}
	
	
	function goSelectCommand(nm, desc){
		
		var command = $("#command").val();
		var arg_val = $("#arg_val").val();		 
		
		var lst_command = "";
		//var desc2 = desc.replace("º","%");
		var desc2 = "%%" + desc;
			$("#command").val(command);
			lst_command = " " + desc2;
			command += lst_command;
			$("#command").val(command);
			$("#arg_val").val(arg_val + " " + desc2);
			$("#argument").val(arg_val + " " + desc2);
			
		dlClose('dl_tmp1');
			
	}

	
	

	function getArgDel(){
		$("#arg_var").val("");
		$("#arg_val").val("");
		$("#arg_code").val("");
	}
	
	
	//캘린더 팝업	
	function popSchedForm(){
		
		var sHtml1="<div id='dl_tmp1' style='overflow:hidden;display:none;padding:0;'>";
		sHtml1+="<form id='form1' name='form1' method='post' onsubmit='return false;'>";
		sHtml1+="<input type='hidden' name='search_gubun' id='search_gubun' value='job_name' />";
		sHtml1+="<table style='width:100%;height:320px;;border:none;'><tr><td style='vertical-align:top;height:100%;width:500px;'>";
		sHtml1+="<table style='width:100%'><tr><td style='text-align:right;'>";
		sHtml1+="<b>캘린더명</b>&nbsp;:&nbsp;<input type='text' name='cal_text' id='cal_text' style='height:21px;' />&nbsp;&nbsp;<span id='btn_cal_search'>검색</span>";
		sHtml1+="</td></tr></table>";
		sHtml1+="<table style='width:100%;height:100%;border:none;'>";
		sHtml1+="<tr><td id='ly_g_tmp1' style='vertical-align:top;' >";
		sHtml1+="<div id='g_tmp1' class='ui-widget-header ui-corner-all'></div>";
		sHtml1+="</td></tr>";
		sHtml1+="<tr style='height:10px;'><td style='vertical-align:top;'><h5 class='ui-widget-header ui-corner-all' >";
		sHtml1+="<div align='right' class='btn_area_s'>";
		sHtml1+="<div id='ly_total_cnt_1' style='padding-top:5px;float:left;'></div>";
		sHtml1+="</div>";
		sHtml1+="</h5></td></tr></table>";
		
		sHtml1+="</td></tr></table>";
		
		sHtml1+="</form>";
		
		$('#dl_tmp1').remove();
		$('body').append(sHtml1);
		
		dlPop01('dl_tmp1',"캘린더",900,360,false);
				
		var gridObj = {
			id : "g_tmp1"
			,colModel:[
		   		{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'번호',width:50,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
		   		,{formatter:gridCellNoneFormatter,field:'CHOICE',id:'CHOICE',name:'선택',width:60,headerCssClass:'cellCenter',cssClass:'cellCenter'}
		   		,{formatter:gridCellNoneFormatter,field:'CAL_NM',id:'CAL_NM',name:'캘린더명',width:150,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}	 
		   		,{formatter:gridCellNoneFormatter,field:'DAYS_CAL',id:'DAYS_CAL',name:'월달력',width:100,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}	 	 
		   		,{formatter:gridCellNoneFormatter,field:'DAYS_AND_OR',id:'DAYS_AND_OR',name:'조건',width:60,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}	   		
		   		,{formatter:gridCellNoneFormatter,field:'WEEKS_CAL',id:'WEEKS_CAL',name:'주간달력',width:100,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
		   		,{formatter:gridCellNoneFormatter,field:'USE_GB',id:'USE_GB',name:'구분',width:60,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
		   		,{formatter:gridCellNoneFormatter,field:'USE_YN',id:'USE_YN',name:'사용여부',width:60,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
		   		,{formatter:gridCellNoneFormatter,field:'CONF_CAL',id:'CONF_CAL',name:'승인달력',width:100,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
		   		,{formatter:gridCellNoneFormatter,field:'SHIFT',id:'SHIFT',name:'이동형태',width:80,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
		   		,{formatter:gridCellNoneFormatter,field:'SHIFT_NUM',id:'SHIFT_NUM',name:'이동수치',width:60,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
		   				   		   		
		   		,{formatter:gridCellNoneFormatter,field:'CAL_CD',id:'CAL_CD',name:'CAL_CD',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
		   	]
			,rows:[]
			,vscroll:<%=S_GRID_VSCROLL%>
		};
		
		viewGrid_1(gridObj,'ly_'+gridObj.id);
		popSchedList('');
		
		$('#cal_text').placeholder().unbind('keypress').keypress(function(e){
			if(e.keyCode==13){
				popSchedList($(this).val());
			}
		});		
		
		$("#btn_cal_search").button().unbind("click").click(function(){
			
			var search_text = $("#form1").find("input[name='cal_text']").val();
			popSchedList(search_text);
		});
		
	}
	
	function popSchedList(search_text){
		
		try{viewProgBar(true);}catch(e){}
		$('#ly_total_cnt_1').html('');
		
		var data_center = $("#data_center").val();
		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=calCodeList2&itemGubun=2&data_center='+data_center+'&cal_text='+encodeURIComponent(search_text);
		
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
						}else{
							items.find('item').each(function(i){						
															
								var cal_cd = $(this).find("CAL_CD").text();
								var cal_nm = $(this).find("CAL_NM").text();
								var days_cal = $(this).find("DAYS_CAL").text();
								var days_and_or = $(this).find("DAYS_AND_OR").text();
								var weeks_cal = $(this).find("WEEKS_CAL").text();
								var week_days = $(this).find("WEEK_DAYS").text();
								var use_gb = $(this).find("USE_GB").text();
								var use_yn = $(this).find("USE_YN").text();
								var month_cal = $(this).find("MONTH_CAL").text();
								var month_days = $(this).find("MONTH_DAYS").text();
								var conf_cal = $(this).find("CONF_CAL").text();						
								var shift = $(this).find("SHIFT").text();
								var shift_num = $(this).find("SHIFT_NUM").text();
								
								var v_days_and_or = "";
								var v_use_yn = "";
								var v_use_gb = "";
								
								if(days_and_or == "A"){
									v_days_and_or = "AND";
								}else if(days_and_or == "O"){
									v_days_and_or = "OR";
								}
								
								if(use_yn == "Y"){
									v_use_yn = "사용";
								}else if(use_yn = "N"){
									v_use_yn = "미사용";
								}
								
								for(var j=0;j<arr_caluse_gb_cd.length;j++){
									if(use_gb == arr_caluse_gb_cd[j].cd){
										v_use_gb = arr_caluse_gb_nm[j].nm;
									}
								}
								rowsObj.push({
									'grid_idx':i+1
									,'CAL_CD': cal_cd
									,'CAL_NM': cal_nm
									,'DAYS_CAL': days_cal
									,'DAYS_AND_OR': v_days_and_or
									,'WEEKS_CAL': weeks_cal
									,'USE_GB': v_use_gb
									,'CONF_CAL': conf_cal
									,'SHIFT': shift
									,'SHIFT_NUM': shift_num								
									,'CHOICE':"<div><a href=\"javascript:goSelect3('"+cal_nm+"','"+days_cal+"','"+days_and_or+"','"+weeks_cal+"','"+month_cal+"','"+week_days+"','"+month_days+"','"+conf_cal+"','"+shift+"','"+shift_num+"');\" ><font color='red'>[선택]</font></a></div>"
								});
							});						
						}
						
						var obj = $("#g_tmp1").data('gridObj');
						obj.rows = rowsObj;
						setGridRows(obj);
						
						$('#ly_total_cnt_1').html('[ TOTAL : '+items.attr('cnt')+' ]');
						
					});
					try{viewProgBar(false);}catch(e){}
				}
		, null );
		
		xhr.sendRequest();
	}
	
	function goSelect3(cal_nm, days_cal, days_and_or, weeks_cal, month_cal, week_days, month_days,conf_cal,shift,shift_num){
		
		$("#cal_nm").val(cal_nm);
		$("#days_cal").val(days_cal);
		$("#days_and_or").val(days_and_or);
		$("#month_days").val(month_days);
		
		if(days_and_or != null){
			if(days_and_or == 'A'){
				$("#schedule_and_or").val("1");				 
			}else{
				$("#schedule_and_or").val("0");
			}
		}
		
		$("#weeks_cal").val(weeks_cal);
		$("#month_cal").val(month_cal);
	
		
		$("#week_days").val(week_days);
		$("#shift").val(shift);
		$("#shift_num").val(shift_num);
		$("#conf_cal").val(conf_cal);
		
		
		if(month_cal != null){
			
			sTmp = month_cal.split(",");
			$("#month_1").val(sTmp[0]);
			$("#month_2").val(sTmp[1]);
			$("#month_3").val(sTmp[2]);
			$("#month_4").val(sTmp[3]);
			$("#month_5").val(sTmp[4]);
			$("#month_6").val(sTmp[5]);
			$("#month_7").val(sTmp[6]);
			$("#month_8").val(sTmp[7]);
			$("#month_9").val(sTmp[8]);
			$("#month_10").val(sTmp[9]);
			$("#month_11").val(sTmp[10]);
			$("#month_12").val(sTmp[11]);
			
			
			var monthTemp = "";
			var month_data = "";
			for(var i=0; i<sTmp.length; i++){
				
				if(i>0) monthTemp += ",";
				if(sTmp[i] == "1"){
					monthTemp += (i+1);
				}
				
			}		
			$("#month_data").val(monthTemp);
		}
		
		
		
		
		dlClose('dl_tmp1');
	}
	
	function fn_sch_forecast() {

		var frm = document.frm1;
		
		/*
		var data_center = $("#data_center").val();
		
		if(data_center == ""){
			alert("C-M 을 입력하세요"); return;
		}
		*/
		
		var obj = null;
		var s = "";

		var week_days = $("#week_days").val();
			
		s += week_days;
		
		frm.week_days.value = s;

		//-- 작업스케줄 체크 Start. --//
		
		var month_days = $("#month_days").val();
		var days_cal   = $("#days_cal").val();
		var week_days  = $("#week_days").val();
		var weeks_cal  = $("#weeks_cal").val();		
		
		var shift  	   = $("#shift").val();
		var shift_num  = $("#shift_num").val();
		var conf_cal   = $("#conf_cal").val();
		
		
		//-- 작업스케줄 체크 End. --//
				
		openPopupCenter2("about:blank", "fn_sch_forecast", 1000, 500);
		
		frm.action = "<%=sContextPath %>/tWorks.ez?c=ez033";
		frm.target = "fn_sch_forecast";
		frm.submit();
	}

	function selectTable(eng_nm, desc, user_daily){

		$("#table_nm").val(eng_nm);
		$("#table_of_def").val(eng_nm);
		$("#table_name").val(eng_nm);
		$("#user_daily").val(user_daily);
		
		$("input[name='application']").val("");
		$("input[name='group_name']").val("");
		
		dlClose("dl_tmp1");
		

		//어플리케이션을 검색		
		getAppGrpCodeList("", "2", "", "application_of_def", eng_nm);
		
		//그룹초기화
		$("select[name='group_name_of_def'] option").remove();
		$("select[name='group_name_of_def']").append("<option value=''>--선택--</option>");
	}
		
// 	function selectApplication(eng_nm, desc){
	
// 		$("#app_nm").val(desc);
// 		$("#application_of_def").val(eng_nm);
// 		$("#application").val(eng_nm);

// 		$("select[name='group_name']").val("");
		
// 		dlClose("dl_tmp1");
	
// 		//그룹을 검색		
// 		getAppGrpCodeList("", "2", "", "group_name_of_def",eng_nm);
		
// 	}
	
	//APP/GRP 가져오기
	function getAppGrpCodeList(scode_cd, depth, grp_cd, val, eng_nm){
		
		try{viewProgBar(true);}catch(e){}
		
		if(eng_nm == "") {
			eng_nm = '_';
		}
		
		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=appGrpCodeList&itemGubun=2&p_scode_cd='+scode_cd+'&p_app_eng_nm='+encodeURIComponent(eng_nm)+'&p_grp_depth='+depth+'&p_grp_cd='+grp_cd;
						
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
								var host_cd = $(this).find("HOST_CD").text();
								var arr_grp_cd = host_cd+","+grp_eng_nm;
																																																								
								$("select[name='"+val+"']").append("<option value='"+arr_grp_cd+"'>"+grp_desc+"</option>");
								
							});						
						}									
						
					});
					try{viewProgBar(false);}catch(e){}
				}
		, null );
		
		xhr.sendRequest();
	}

	function btnShow(doc_cd){
		
		$("#frm1").find("input[name='doc_cd']").val(doc_cd);
		
		$("#btn_ins").hide();
		$("#btn_draft").hide();
		$("#btn_draft_admin").show();
	}
	
	//서버내역 가져오기
	function mHostList(grp_nm){
	
		try{viewProgBar(true);}catch(e){}
		
<%-- 		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=mHostList&itemGubun=2&grp_nm='+grp_nm; --%>
		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=mHostList&itemGubun=2';
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
							$("select[name='host_id'] option").remove();
							$("select[name='host_id']").append("<option value=''>--선택--</option>");	
						}else{
							$("select[name='host_id'] option").remove();
							$("select[name='host_id']").append("<option value=''>--선택--</option>");	
							
							items.find('item').each(function(i){						
							
								var host_cd = $(this).find("HOST_CD").text();								
								var node_id = $(this).find("NODE_ID").text();
								var node_nm = $(this).find("NODE_NM").text();
								
								var all_cd = host_cd+","+node_id;
								var all_nm = node_nm+"("+node_id+")";
																
								$("select[name='host_id']").append("<option value='"+all_cd+"'>"+all_nm+"</option>");
																
							});						
						}
												
					});
					try{viewProgBar(false);}catch(e){}
				}
		, null );
		
		xhr.sendRequest();
	}
	
	function goPrc(flag){
		
		var frm = document.frm1;
		
		frm.flag.value 			= flag;
		frm.systemGb.value 		= frm.sSystemGb.value;
		frm.jobTypeGb.value 	= frm.sJobTypeGb.value;
		frm.application.value 	= frm.table_name.value;
		frm.group_name.value 	= frm.table_name.value;
		
		// 담당자 체크 
		// SMS, 오토콜 중 한개는 필수
// 		checkUserInfo();	//2024.02.26 최호연 담당자 SMS,MAIL 체크로직 제거
		
		isValid_C_M();
		
		if ( document.getElementById('is_valid_flag').value == "false" ) {
			document.getElementById('is_valid_flag').value = "" 
			return;
		}
		
		if( isNullInput(document.getElementById('title'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[의뢰사유]","") %>') ) return;		
		if( isNullInput(document.getElementById('data_center_items'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[C-M]","") %>') ) return;
		if( isNullInput(document.getElementById('sSystemGb'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[시스템구분]","") %>') ) return;
		if( isNullInput(document.getElementById('sJobTypeGb'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[작업유형구분]","") %>') ) return;
		if( isNullInput(document.getElementById('table_name'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[테이블]","") %>') ) return;
<%-- 		if( isNullInput(document.getElementById('application'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[어플리케이션]","") %>') ) return;		 --%>
<%-- 		if( isNullInput(document.getElementById('group_name_of_def'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[그룹]","") %>') ) return; --%>
		if( isNullInput(document.getElementById('host_id'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[수행서버]","") %>') ) return;
		if( isNullInput(document.getElementById('owner'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[계정명]","") %>') ) return;
		if( isNullInput(document.getElementById('task_type'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[작업타입]","") %>') ) return;
		
		if( isNullInput(document.getElementById('mem_lib'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[프로그램 위치]","") %>') ) return;
		if( isNullInput(document.getElementById('command'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[작업수행명령]","") %>') ) return;
		
		var mem_lib_val = $("#mem_lib").val();
		var mem_lib_f_chk = false;
		var mem_lib_l_chk = false;
		
		if ( mem_lib_val != "" ) {
			if ( mem_lib_val.substring(0, 1) == "/" ) {
				mem_lib_f_chk = true;
			}
			if ( mem_lib_val.length > 3 && mem_lib_val.substring(3, 2) == "\\" ) {
				mem_lib_f_chk = true;				
			}
		}
		
		if ( mem_lib_val != "" ) {
			if ( mem_lib_val.substring(mem_lib_val.length-1, mem_lib_val.length) == "/" ) {
				mem_lib_l_chk = true;
			}
			if ( mem_lib_val.length > 3 && mem_lib_val.substring(mem_lib_val.length-2, mem_lib_val.length) == "\\\\" ) {
				mem_lib_l_chk = true;				
			}
		}
		
		if(!mem_lib_f_chk) {
			alert("프로그램 위치는 절대 경로로 입력 해야 합니다. 시작글자(/,C:\\)");
			return;
		}
		
		if(!mem_lib_l_chk) {
			alert("프로그램 위치의 마지막은 / 혹은 \\\\ 로 끝나야 합니다.");
			return;
		}
		
		if( isNullInput(document.getElementById('mem_name'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[프로그램 명]","") %>') ) return;		
		if( isNullInput(document.getElementById('job_name'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[작업명]","") %>') ) return;
<%-- 		if( isNullInput(document.getElementById('description'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[작업 설명]","") %>') ) return; --%>
		
		if($("#cyclic").val() == "1"){
			
			if ( $("#frm1").find("select[name='eHour']").val() == "" && $("#frm1").find("select[name='eMin']").val() == "" ) {
				alert("반복작업은 종료시간을 입력해 주세요.");
				return;
			}
			
			// 반복작업이면 1분 이상.
			if ( frm.rerun_interval.value == "" && frm.interval_sequence.value == "" && frm.specific_times.value == "" ) {
				alert("반복옵션을 설정해 주세요.");
				return;
			}
		
			if ( frm.cyclic_type.value == "C" && frm.rerun_interval.value != "" ) {
				if ( replaceAll(frm.rerun_interval.value, "0", "") == "" ) {
					alert("반복주기를 확인해 주세요.");
					return;
				}
			}
			
		} else if($("#cyclic").val() == "0" && ($("#frm1").find("select[name='eHour']").val() == "" && $("#frm1").find("select[name='eMin']").val() == "") ) {
		
			$("#time_until").val(">");
		}
		
		if( $("#late_exec").val() == "0" ) {
			alert("수행 임계시간은 1분 이상이어야 합니다.");
			return;
		}
		
		if($("#time_from").val() != ''){
			if($("#time_from").val().length < 4){
				alert("작업시작시간의 시, 분을 확인해주세요.");
				return;
			}
		}
		
		
		if($("#time_until").val() != '' && $("#time_until").val() != ">"){
			if($("#time_until").val().length < 4){
				alert("작업종료시간의 시, 분을 확인해주세요.");
				return;	
			}
		}
		
		if($("#late_sub").val() != ''){
			if($("#late_sub").val().length < 4){
				alert("시작임계시간의 시, 분을 확인해주세요..");
				return;
			}
		}
		
		if($("#late_time").val() != ''){
			if($("#late_time").val().length < 4){
				alert("종료임계시간의 시, 분을 확인해주세요.");
				return;
			}
		}
		
		var time_from_t = parseInt($("#time_from").val());
		var late_time_t = parseInt($("#late_time").val());
		var late_sub_t 	= parseInt($("#late_sub").val());	
		
		//if($("#time_group").val() == "00"){
			//alert("시작시간을 입력하세요");
		//}
		
		if( $("#late_sub").val() != "" ){
			if(time_from_t > late_sub_t){
				alert("시작 임계시간은 시작시간보다 큰 값을 입력 해야 합니다.");
				return;
			}
		}
	
		if( $("#late_time").val() != ""){
			if(time_from_t > late_time_t){
				alert("종료 임계시간은 시작시간보다 큰 값을 입력 해야 합니다.");
				return;
			}
		}
		
		if($("#late_sub").val() != "" && $("#late_time").val() != ""){
			if($("#late_sub").val() > $("#late_time").val()){
				alert("종료 임계시간은 시작임계시간보다 큰 값을 입력 해야 합니다.");
				return;
			}
		}
		
		if( isNullInput(document.getElementById('author'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[담당자]","") %>') ) return;
		if( isNullInput(document.getElementById('critical_yn'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[중요작업]","") %>') ) return;		
		
		if($("#job_nameChk").val() == "0"){
			alert("작업명의 확인을 눌러 주세요 [중복체크 , 후행컨디션 세팅]");
			return;
		}
		
		var grid_idx = "";
		var all_data = "";
		var job_nm = "";
		var cond_dt = "";
		var cond_gb = "";
		setGridSelectedRowsAll(gridObj_1);			
		var aSelRow = new Array;
		aSelRow = $('#'+gridObj_1.id).data('grid').getSelectedRows();
		
		if(aSelRow.length > 0){
			for(var i=0;i<aSelRow.length;i++){
				
				job_nm = getCellValue(gridObj_1,aSelRow[i],"m_in_condition_name");
				cond_dt = getCellValue(gridObj_1,aSelRow[i],"m_in_condition_date");
				cond_gb = getCellValue(gridObj_1,aSelRow[i],"m_in_condition_and_or");
				
				if(i>0) all_data += "|";				
				all_data += job_nm +","+ cond_dt +","+ cond_gb;			
			}
		}
		
		clearGridSelected(gridObj_1);		
		frm.t_conditions_in.value = all_data;
		
		
		var first_job_name = "";
		all_data = "";
		setGridSelectedRowsAll(gridObj_2);			
		var aSelRow = new Array;
		aSelRow = $('#'+gridObj_2.id).data('grid').getSelectedRows();
		
		if(aSelRow.length > 0){
			for(var i=0;i<aSelRow.length;i++){
				
				grid_idx = getCellValue(gridObj_2,aSelRow[i],"grid_idx");
				job_nm = getCellValue(gridObj_2,aSelRow[i],"m_out_condition_name");
				
				if(grid_idx == 1) first_job_name = job_nm;
				
				cond_dt = getCellValue(gridObj_2,aSelRow[i],"m_out_condition_date");
				cond_gb = getCellValue(gridObj_2,aSelRow[i],"m_out_condition_effect");
				
				if(i>0) all_data += "|";				
				all_data += job_nm +","+ cond_dt +","+ cond_gb;			
			}
		}
		
		clearGridSelected(gridObj_2);		
		frm.t_conditions_out.value = all_data;
		
		// 작업명 수정 후 확인 버튼을 클릭 하지 않으면 후행 조건이 동기화 안됨
		if($("#job_name").val() != first_job_name){
			alert("작업명의 확인버튼을 다시 클릭하세요.");
			return;
		}
		
		s = "";
		
		var task_type 	= $("#task_type").val();  
		var mem_name 	= $("#mem_name").val();
		var mem_lib 	= $("#mem_lib").val();
		
		var file_nm 	= mem_lib + mem_name;
		
// 		var t_set_var 	= $("#t_set_var").val();
		
// 		if ( t_set_var != "" ) {
			 
// 			var arrTsets = t_set_var.split("|");

// 			for( var i = 0; i < arrTsets.length; i++ ) {
				
// 				var arrTset	= arrTsets[i].split(",");

// 				if ( arrTset.length != "2" ) {

// 					alert("사용자변수를 정확히 작성해 주세요.");
// 					document.getElementById('t_set_var').focus();
// 					return;
// 				}
// 			}
// 		}

		obj = document.getElementsByName('m_var_name');
		if( obj!=null && obj.length>0 ){
			for( var i=0; i<obj.length; i++ ){
				if( trim(obj[i].value) != "" ){
					var sTmp = obj[i].value;					
					sTmp += (","+document.getElementsByName('m_var_value')[i].value);

					if ( document.getElementsByName('m_var_value')[i].value == "" ) {
						//alert("[변수]의 Value를 확인해 주세요.");
						//return;
					}
					
					s += (s=="")? sTmp:("|"+sTmp);
				}
			}
			frm.t_set.value = s;
		}
		var t_set_var 	= $("#t_set").val();

		s = "";
		obj = document.getElementsByName('m_step_opt');
		
		
		if( obj!=null && obj.length>0 ){
			for( var i=0; i<obj.length; i++ ){
				
				
				if( trim(obj[i].value) != "" ){
					var sTmp = obj[i].value;
					
					if(sTmp == 'O'){
						sTmp = sTmp+',Statement'+',*';
					}
					
					sTmp += (","+document.getElementsByName('m_step_type')[i].value);
					var step_type = document.getElementsByName('m_step_type')[i].value;
					
					
					if(step_type == 'COMPSTAT' || step_type == 'RUNCOUNT' || step_type == 'FAILCOUNT'){
						v = $('div[id^=div_step_parameters]').eq(i).prop('id').replace('div_step_parameters','');
						
						if(step_type != 'FAILCOUNT'){
							if( isNullInput(document.getElementById('m_step_statement_stmt'+v),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[Stmt]","") %>') ) return;
							var statement_stmt = document.getElementById('m_step_statement_stmt'+v).value;
						}
						
						if(statement_stmt == 'EVEN' || statement_stmt == 'ODD'){
							sTmp += (" EQ "+document.getElementById('m_step_statement_stmt'+v).value);
						}else{
							
							if( isNullInput(document.getElementById('m_step_statement_code'+v),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[Code]","") %>') ) return;
							if(step_type == 'COMPSTAT'){
								sTmp += (" "+document.getElementById('m_step_statement_stmt'+v).value+" "+document.getElementById('m_step_statement_code'+v).value);	
							}else if(step_type == 'RUNCOUNT'){
								sTmp += (" "+document.getElementById('m_step_statement_stmt'+v).value+" "+document.getElementById('m_step_statement_code'+v).value);
							}else if(step_type == 'FAILCOUNT'){
								sTmp += (" EQ "+document.getElementById('m_step_statement_code'+v).value);
							}
						}
						
					}
					
					if( step_type == 'Condition' ){
						i = $('div[id^=div_step_parameters]').eq(i).prop('id').replace('div_step_parameters','');
						
						sTmp += (","+document.getElementById('m_step_condition_name'+i).value);
						sTmp += (","+document.getElementById('m_step_condition_date'+i).value);
						sTmp += (","+document.getElementById('m_step_condition_sign'+i).value);
					}else if( step_type == 'Shout' ){
						i = $('div[id^=div_step_parameters]').eq(i).prop('id').replace('div_step_parameters','');
						
						sTmp += (","+document.getElementById('m_step_dest'+i).value);
						sTmp += (",regular");
						sTmp += (","+document.getElementById('m_step_message'+i).value);
					}

					s += (s=="")? sTmp:("|"+sTmp);
				}
			}
			frm.t_steps.value = s;
		}
		
		if(frm.t_steps.value.indexOf("A,RERUN") > -1){
			if(confirm("ON/DO의 DO-재수행을 선택하면 최대 반복 횟수:99 권장입니다.\n설정하시겠습니까?\n\n(이후 최대 반복 횟수는 수동 설정해야 합니다.)")){
				$("#rerun_max").val("99");
			}
		}
		
		if(task_type == "job") {
			
			var monitor_time 		= $("#monitor_time").val();
			var monitor_interval 	= $("#monitor_interval").val();
			var filesize_comparison = $("#filesize_comparison").val();
			var num_of_iterations 	= $("#num_of_iterations").val();
			var stop_time 			= $("#stop_time").val();
			
			if( isNullInput(document.getElementById('monitor_time'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[모니터링 시간]","") %>') ) return;
			if( isNullInput(document.getElementById('monitor_interval'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[모니터링 주기]","") %>') ) return;
			if( isNullInput(document.getElementById('filesize_comparison'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[파일증감 체크주기]","") %>') ) return;
			if( isNullInput(document.getElementById('num_of_iterations'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[파일멈춤 체크횟수]","") %>') ) return;
			if( isNullInput(document.getElementById('stop_time'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[모니터링 종료시간]","") %>') ) return;
			
			if ( t_set_var != "" ) {
				t_set_var = t_set_var + "|";
			}
			
			t_set_var += 	"%%FileWatch-FILE_PATH,"+file_nm+"|%%FileWatch-MODE,CREATE|%%FileWatch-MIN_DET_SIZE,0B|%%FileWatch-INT_FILE_SEARCHES,"+monitor_interval+
							"|%%FileWatch-INT_FILESIZE_COMPARISON,"+filesize_comparison+"|%%FileWatch-NUM_OF_ITERATIONS,"+num_of_iterations+"|%%FileWatch-FILESIZE_WILDCARD,N|%%FileWatch-TIME_LIMIT,"+monitor_time+	
							"|%%FileWatch-START_TIME,NOW|%%FileWatch-STOP_TIME,"+stop_time+"|%%FileWatch-MIN_AGE,NO_MIN_AGE|%%FileWatch-MAX_AGE,NO_MAX_AGE";
			
			frm.t_set.value = t_set_var;				
		}
// 		else{			
// 			frm.t_set.value = t_set_var;
// 		}

// 		document.getElementById('table_name').value =  document.getElementById('application').value + "_" + document.getElementById('time_group').value;
		
// 		var jobSchedGb = $("select[name='sJobSchedGb'] option:selected").val();		
		
		// argument에 변수에 입력된 내용 셋팅
// 		$("#argument").val($("#arg_val").val());
		
		
		// 인터페이스 작업에 대한 유효성 검증기능
		var serverGb = '<%=strServerGb%>';
		if(serverGb == "P"){
			checkIfName();
		}
		
		// 스마트테이블 여부 체크
		checkSmartTableCnt();
		
		//alert("CMDLINE -->" + document.getElementById('command').value + "로 작업이 만들어 집니다.\n확인 바랍니다.");		
		//if( !confirm('처리하시겠습니까?' + document.getElementById('command').value) ) return;
		//if( !confirm(document.getElementById('command').value + "로 작업이 만들어 집니다.\n처리하시겠습니까?") ) return;
		if( !confirm("처리하시겠습니까?") ) return;
		if(flag == "draft" || flag == "draft_admin"){
			if(serverGb == "P"){
				if ( document.getElementById('if_return').value != "" ) {
					alert("인터페이스 검증 에러 발생하였습니다.\n\n"+ document.getElementById('if_return').value);
					return;
				}
			}
		}
		if ( document.getElementById('smart_cnt').value > 0 ) {
			if( !confirm("스마트 테이블 작업입니다.\n\n해당 작업은 스마트 테이블의 작업주기구분을 상속받습니다.") ) return;
		}
		
		$("#max_wait").val("<%=strDefaultMaxWait%>");
		
// 		frm.job_name.value = frm.table_name.value;

		if ( flag == "draft_admin" || flag == "draft_admin" ) {
			if( !confirm("즉시반영[관리자결재] 하시겠습니까?") ) return;
		}else{
			if( !confirm("처리하시겠습니까?") ) return;
		}
		
		try{viewProgBar(true);}catch(e){}
		frm.target = "if1";
		frm.action = "<%=sContextPath%>/tWorks.ez?c=ez004_p";
		frm.submit();
	}
	
	function calList(){		
		
		var data_center = $("input[name='data_center']").val();
					
		try{viewProgBar(true);}catch(e){}
				
		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=searchItemList&itemGubun=2&searchType=days_calList&data_center='+data_center;
		
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
							$("select[name='days_cal'] option").remove();
							$("select[name='days_cal']").append("<option value=''>--선택--</option>");	
							
							$("select[name='weeks_cal'] option").remove();
							$("select[name='weeks_cal']").append("<option value=''>--선택--</option>");	
							
							$("select[name='conf_cal'] option").remove();
							$("select[name='conf_cal']").append("<option value=''>--선택--</option>");	
						}else{
							$("select[name='days_cal'] option").remove();
							$("select[name='days_cal']").append("<option value=''>--선택--</option>");	
							
							$("select[name='weeks_cal'] option").remove();
							$("select[name='weeks_cal']").append("<option value=''>--선택--</option>");	
							
							$("select[name='conf_cal'] option").remove();
							$("select[name='conf_cal']").append("<option value=''>--선택--</option>");	
							
							items.find('item').each(function(i){						
							
								var calendar = $(this).find("CALENDAR").text();	
							
								$("select[name='days_cal']").append("<option value='"+calendar+"'>"+calendar+"</option>");
								$("select[name='weeks_cal']").append("<option value='"+calendar+"'>"+calendar+"</option>");
								$("select[name='conf_cal']").append("<option value='"+calendar+"'>"+calendar+"</option>");
								
							});						
						}
												
					});
					try{viewProgBar(false);}catch(e){}
				}
		, null );
		
		xhr.sendRequest();
	}	
	
	function dataDelete(row, flag){
		
		try{viewProgBar(true);}catch(e){}
		
		if(flag == "1"){
			setGridSelectedRowsAll(gridObj_1);		
			var row_idx = row-1;		
			var aSelRow = new Array;
			aSelRow = $('#'+gridObj_1.id).data('grid').getSelectedRows();	
			
			var rowsObj_2 = new Array();
			for(var i=0;i<aSelRow.length;i++){
				rowsObj_2.push({
					'grid_idx':rowsObj_2.length+1	
					,'m_in_condition_name': getCellValue(gridObj_1,aSelRow[i],"m_in_condition_name")
					,'m_in_condition_date': getCellValue(gridObj_1,aSelRow[i],"m_in_condition_date")
					,'m_in_condition_and_or': getCellValue(gridObj_1,aSelRow[i],"m_in_condition_and_or")
				});	
			}
					
			gridObj_3.rows = rowsObj_2;					
			setGridRows(gridObj_3);		
		
			aSelRow = new Array;
			setGridSelectedRowsAll(gridObj_3);
			aSelRow = $('#'+gridObj_3.id).data('grid').getSelectedRows();
			
			rowsObj_job1 = [];		
			for(var i=0;i<aSelRow.length;i++){			
				if(i == row_idx) continue;			
				rowsObj_job1.push({
					'grid_idx':rowsObj_job1.length+1								
					,'m_in_condition_name': getCellValue(gridObj_3,aSelRow[i],"m_in_condition_name")
					,'m_in_condition_date': getCellValue(gridObj_3,aSelRow[i],"m_in_condition_date")
					,'m_in_condition_and_or': getCellValue(gridObj_3,aSelRow[i],"m_in_condition_and_or")
				});	
			}
			
			gridObj_1.rows = rowsObj_job1;					
			setGridRows(gridObj_1);		
			clearGridSelected(gridObj_1);
			
		}else if(flag == "2"){		
		
			if ( $('#'+gridObj_2.id).data('grid').getSelectedRows() != "" ) {
				
				var outCondName = getCellValue(gridObj_2,$('#'+gridObj_2.id).data('grid').getSelectedRows(),"m_out_condition_name");
				outCondName = outCondName.split("-");
				
				if(outCondName[0] == 'GLOB'){
					$("select[name='globalCond_yn']").val('N');
				}
			} else {
				$("select[name='globalCond_yn']").val('N');
			}
			
			setGridSelectedRowsAll(gridObj_2);
			
			var row_idx = row-1;		
			var aSelRow = new Array;
			aSelRow = $('#'+gridObj_2.id).data('grid').getSelectedRows();	
			
			var rowsObj_2 = new Array();
			for(var i=0;i<aSelRow.length;i++){
				rowsObj_2.push({
					'grid_idx':rowsObj_2.length+1	
					,'m_out_condition_name': getCellValue(gridObj_2,aSelRow[i],"m_out_condition_name")
					,'m_out_condition_date': getCellValue(gridObj_2,aSelRow[i],"m_out_condition_date")
					,'m_out_condition_effect': getCellValue(gridObj_2,aSelRow[i],"m_out_condition_effect")
				});				
			}
			
			gridObj_4.rows = rowsObj_2;					
			setGridRows(gridObj_4);		
		
			aSelRow = new Array;
			setGridSelectedRowsAll(gridObj_4);
			aSelRow = $('#'+gridObj_4.id).data('grid').getSelectedRows();
			
			rowsObj_job2 = [];		
			for(var i=0;i<aSelRow.length;i++){			
				if(i == row_idx) continue;			
				rowsObj_job2.push({
					'grid_idx':rowsObj_job2.length+1								
					,'m_out_condition_name': getCellValue(gridObj_4,aSelRow[i],"m_out_condition_name")
					,'m_out_condition_date': getCellValue(gridObj_4,aSelRow[i],"m_out_condition_date")
					,'m_out_condition_effect': getCellValue(gridObj_4,aSelRow[i],"m_out_condition_effect")
				});	
			}
			
			gridObj_2.rows = rowsObj_job2;					
			setGridRows(gridObj_2);		
			clearGridSelected(gridObj_2);
		}
		
		try{viewProgBar(false);}catch(e){}		
	}
	
	function selectSrCode(sreq_code, sreq_title, pm_nm, sreq_planmh) {
		
		$("#srNo").val(sreq_code);
		$("#chargePmNm").val(pm_nm);
		$("#projectManMonth").val(sreq_planmh);
		$("#projectNm").val(sreq_title);	

		dlClose("dl_sr_tmp1");
	}
	
	function srClear() {
		
		$("#srNo").val("");
		$("#chargePmNm").val("");
		$("#projectManMonth").val("");
		$("#projectNm").val("");
	}
	
	function addUserVars(){
		var obj = document.getElementById('userVar');
		var idx=0;
		
		var lastDiv = $('div[id^=div_user_val]:last').prop('id');
		
		if(lastDiv !== undefined){
			idx = Number(lastDiv.replace('div_user_val',''))+1;
		}
		
		var s = "";
		s += "<tr>";
		s += "<td style='width:120px;height:21px;'><div class='cellTitle_kang2' id='div_user_val"+idx+"'>변수" + (idx+1) + "</div></td>"
		s += "<td style='width:400px;'><input type='text' class='input' name='m_var_name' style='width:98%;height:21px;' maxlength='40'/></td>";
		s += "<td ><input type='text' class='input' name='m_var_value' style='width:98%;height:21px;' maxlength='214'/></td>";
		s += "<td class='td2_1' width='120px'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type='button' name='del_set_button' value=' - ' onClick=\"delUserVars( getObjIdx(this, this.name))\" class=\"btn_white_h24\"></td>";
// 		s += "<td colspan='5'><div class='cellContent_kang' id='div_user_val"+idx+"'><input type='text' name='t_set_var' style='width:98%;height:21px;ime-mode:disabled;' /></div></td>";
		s += "</tr>";
		
		$(obj).append(s);
	}
	
	function delUserVars(idx){
		$('#userVar tr:nth-child(' + (idx+1) + ')').remove();
	}
	
	function addSteps(){
		var obj = document.getElementById('onDoTable');
		var idx=0;
		
		var lastDiv = $('div[id^=div_step_type]:last').prop('id');
		
		if(lastDiv !== undefined){
			idx = Number(lastDiv.replace('div_step_type',''))+1;
		}
		
		var s = "";
		s += "<tr>";
		s += "<td style='width:5%;height:21px;'>";
		s += "<div class='cellContent_6'><input type='checkbox' name='check_idx'></div>";
		s += "<input type='hidden' name='hidIdx' id='hidIdx' value='"+idx+"'/>"
		s += "</td>";
		s += "<td style='width:7%;height:21px;'>";
		s += "<div class='cellContent_6'>";
		s += "<select name='m_step_opt' onchange='setStepType(this.value,"+idx+");' style='width:80%;'>";
		s += "<option value=''>--</option>";
		<%
		aTmp = CommonUtil.getMessage("JOB.STEP_OPT").split(",");
		for(int i=0;i<aTmp.length; i++){
			String[] aTmp1 = aTmp[i].split("[|]");
		%>	
			s += "<option value='<%=aTmp1[0] %>'><%=aTmp1[1] %></option>";
		<%}%>
		s += "</select>";
		s += "</div>";
		s += "</td>";
		
		s += "<td style='width:13%;height:21px;'><div class='cellContent_6' id='div_step_type"+idx+"'>&nbsp;<input type='hidden' name='m_step_type'  /></div></td>";
		s += "<td style='width:80%;height:21px;'><div class='cellContent_7' id='div_step_parameters"+idx+"'>&nbsp;</div></td>";	
		s += "</tr>";
		
		$(obj).append(s);
	}

	function delSteps(){
		
		$("input:checkbox[name='check_idx']").each(function(i){
			if($(this).prop('checked')){
				$(this).parent().parent().parent().remove();
			}
		});
		
		$("input:checkbox[name='checkIdxAll']").prop('checked', false);
		
	}
	function setStepType(v,idx){
		var obj1 = document.getElementById('div_step_type'+idx);
		var obj2 = document.getElementById('div_step_parameters'+idx);
		
		var s1 = "";
		var s2 = "";
		if( v=="O" ){
			s1 += "<select name='m_step_type' onchange='setStepOnParameters(this.value,"+idx+");' style='width:115px;'>";
			<%
			aTmp = CommonUtil.getMessage("TABLE.STEP_ON_TYPE").split(",");
			for(int i=0;i<aTmp.length; i++){
				String[] aTmp1 = aTmp[i].split("[|]");
			%>	
				s1 += "<option value='<%=aTmp1[1] %>'><%=aTmp1[0] %></option>";
			<%}%>
			s1 += "</select>";
			
			
		}else if( v=="A" ){
			s1 += "<select name='m_step_type' onchange='setStepParameters(this.value,"+idx+");' style='width:115px;'>";
			<%
			aTmp = CommonUtil.getMessage("TABLE.STEP_DO_TYPE").split(",");
			for(int i=0;i<aTmp.length; i++){
				String[] aTmp1 = aTmp[i].split("[|]");
			%>	
				s1 += "<option value='<%=aTmp1[1] %>'><%=aTmp1[0] %></option>";
			<%}%>
			s1 += "</select>";
			s2 += "&nbsp;";
		}else{
			s1 += "&nbsp;<input type='hidden' name='m_step_type'  />";
			s2 += "&nbsp;";
		}
		
		obj1.innerHTML = s1;
		obj2.innerHTML = s2;
	}	
	
	function setStepParameters(v,idx){
		var obj = document.getElementById('div_step_parameters'+idx);
		
		var s = "";
		if(v == 'Condition'){
			s += " Name=<input class='input' type='text' name='m_step_condition_name"+idx+"' id='m_step_condition_name"+idx+"' maxlength='255' />";
			s += " Date=<input class='input datepick' type='text' name='m_step_condition_date"+idx+"' id='m_step_condition_date"+idx+"' maxlength='4' size='4'  onClick=\"this.value='';\" onDblClick=\"this.value='ODAT';\" />";
			s += " Sign=<select name='m_step_condition_sign"+idx+"' id='m_step_condition_sign"+idx+"' style='width:55px;'>";
			<%
			aTmp = CommonUtil.getMessage("JOB.STEP_SIGN").split(",");
			for(int i=0;i<aTmp.length; i++){
				String[] aTmp1 = aTmp[i].split("[|]");
			%>	
				s += "<option value='<%=aTmp1[0] %>'><%=aTmp1[1] %></option>";
			<%}%>
			s += "</select>";
			
			
		}else if(v == 'Shout'){
			s += " Dest=<input class='input' type='text' name='m_step_dest"+idx+"' id='m_step_dest"+idx+"'/>";
			s += " Message=<input class='input' type='text' name='m_step_message"+idx+"' id='m_step_message"+idx+"' style='width:400px;'/>";
			
		}
		
		$(obj).html(s);
		
		/* $("#m_step_condition_date"+idx).addClass("ime_readonly").unbind('click').click(function(){
			dpCalMinMax(this.id,'mmdd');
		});	 */
		
	}
	
	
	
	function setStepOnParameters(v,idx){
		var obj = document.getElementById('div_step_parameters'+idx);
		
		var s = "";
		if(v == 'COMPSTAT' || v == 'RUNCOUNT'){

			s += " Stmt=<select name='m_step_statement_stmt"+idx+"' id='m_step_statement_stmt"+idx+"' onchange='setStepOnStmt(this.value,"+idx+");' style='width:95px;'> ";
			
			s += "<option value=''>--선택--</option>";
			<%
			aTmp = CommonUtil.getMessage("TABLE.STEP_ON_PARAMETERS").split(",");
			for(int i=0;i<aTmp.length; i++){
				String[] aTmp1 = aTmp[i].split("[|]");
			%>	
				s += "<option value='<%=aTmp1[1] %>'><%=aTmp1[0] %></option>";
			<%}%>
	
			s += "</select>";
			s += " Code=<input class='input' type='text' name='m_step_statement_code"+idx+"' id='m_step_statement_code"+idx+"' maxlength='132' />";
			
		}else if(v == 'FAILCOUNT'){
			s += " Code=<input class='input' type='text' name='m_step_statement_code"+idx+"' id='m_step_statement_code"+idx+"' maxlength='132' />";
		}
		
		$(obj).html(s);
	}
	
	function setStepOnStmt(v,idx){
		
		var obj = document.getElementById('div_step_parameters'+idx);
		if(v == 'EVEN' || v == 'ODD'){
			$(obj).find('select[name=m_step_statement_stmt'+idx+']').next('input').remove();
			$(obj).html($(obj).html().replace(' Code=', ' '));
			$(obj).find('select[name=m_step_statement_stmt'+idx+']').val(v);
		}else{
			var s = "";
			
			$(obj).find('select[name=m_step_statement_stmt'+idx+']').next('input').remove();
			$(obj).html($(obj).html().replace(' Code=', ' '));
			
			var objHtml  = $(obj).html();
			$(obj).html("");
			s = " Code=<input class='input' type='text' name='m_step_statement_code"+idx+"' id='m_step_statement_code"+idx+"' maxlength='132' />";
			$(obj).html(objHtml+s);
			
			$(obj).find('select[name=m_step_statement_stmt'+idx+']').val(v);			
		}
	}
	
</script>
<%@include file="/jsp/common/inc/progBar.jsp"  %>
<iframe name="if1" id="if1" width="0" height="0"></iframe>
</body>
</html>