<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/jsp/common/inc/header.jsp" %>

<%
    Map<String, Object> paramMap = CommonUtil.collectParameters(request);
    String c = CommonUtil.isNull(paramMap.get("c"));
    String gridId = "g_" + c;

    String menu_gb = CommonUtil.getMessage("CATEGORY.GB.03.GB." + CommonUtil.isNull(paramMap.get("menu_gb")));
    String[] arr_menu_gb = menu_gb.split(",");

    // 세션값 가져오기.
    String strSessionDcCode = S_D_C_CODE;
    String strSessionTab = S_TAB;
    String strSessionApp = S_APP;
    String strSessionGrp = S_GRP;

    //스크롤 페이징
    String strPagingNum = CommonUtil.getMessage("PAGING.NUM");
%>

<style type="text/css">

    .filebox label {
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
        width: 65px;
        height: 21px;
    }

    .filebox input[type="file"] {
        position: absolute;
        width: 1px;
        height: 1px;
        padding: 0;
        margin: -1px;
        overflow: hidden;
        clip: rect(0, 0, 0, 0);
        border: 0;
    }
</style>

<script type="text/javascript" src="<%=request.getContextPath() %>/js/SlickGrid-2.1.0/plugins/slick.autocolumnsize.js" ></script>

<form id="f_s" name="f_s" method="post" onsubmit="return false;">
    <input type='hidden' id='flag' name='flag'/>
    <input type='hidden' id='data_center_code' name='data_center_code'/>
    <input type='hidden' id='data_center' name='data_center'/>
    <input type='hidden' id='active_net_name' name='active_net_name'/>
    <input type='hidden' id='p_sched_table' name='p_sched_table'/>
    <input type='hidden' id='p_application_of_def' name='p_application_of_def'/>
    <input type='hidden' id='p_group_name_of_def' name='p_group_name_of_def'/>
    <input type='hidden' id='p_application_of_def_text' name='p_application_of_def_text'/>
    <input type='hidden' id='p_group_name_of_def_text' name='p_group_name_of_def_text'/>
    <input type='hidden' id='p_search_gubun' name='p_search_gubun'/>
    <input type='hidden' id='p_search_gubun2' name='p_search_gubun2'/>
    <input type='hidden' id='p_search_text' name='p_search_text'/>
    <input type='hidden' id='p_search_text2' name='p_search_text2'/>
    <input type='hidden' id='searchType' name='searchType'/>
    <input type='hidden' id='S_USER_NM' name='S_USER_NM' value="<%=S_USER_NM%>"/>
    <input type='hidden' id='p_cc_count' name='p_cc_count'/>

    <input type='hidden' id='job_name' name='job_name'/>
    <input type='hidden' id='table_id' name='table_id'/>
    <input type='hidden' id='job_id' name='job_id'/>
    <input type='hidden' id='sched_table' name='sched_table'/>
    <input type='hidden' id='v_sched_table' name='v_sched_table'/>

    <input type="hidden" id="menu_gb" name="menu_gb" value="${paramMap.menu_gb}"/>
    <input type="hidden" id="p_mcode_nm" name="p_mcode_nm"/>
    <input type="hidden" id="p_scode_nm" name="p_scode_nm"/>
    <input type='hidden' id='p_moneybatchjob' name='p_moneybatchjob'/>
    <input type='hidden' id='p_critical' name='p_critical'/>
    <input type='hidden' id='p_node_id' name='p_node_id'/>

    <input type="hidden" id="p_scode_cd" name="p_scode_cd"/>
    <input type="hidden" id="p_grp_depth" name="p_grp_depth"/>
    <input type="hidden" id="p_app_nm" name="p_app_nm"/>
    <input type="hidden" id="p_grp_nm" name="p_grp_nm"/>
    <input type="hidden" id="p_app_search_gubun" name="p_app_search_gubun"/>
    <input type="hidden" id="p_chk_app" name="p_chk_app" value="N"/>
    
    <input type="hidden" id="p_cmjob_transfer" name="p_cmjob_transfer"/>

    <input type="hidden" id="startRowNum" name="startRowNum" value="0"/>
    <input type="hidden" id="pagingNum" name="pagingNum" value="<%=strPagingNum%>"/>
</form>

<form id="f_b" name="f_b" method="post" onsubmit="return false;">

    <input type="hidden" name="b_job_id" id="b_job_id"/>
    <input type="hidden" name="b_table_id" id="b_table_id"/>
    <input type="hidden" name="b_job_name" id="b_job_name"/>
    <input type="hidden" name="b_doc_gb" id="b_doc_gb"/>
    <input type="hidden" name="b_data_center" id="b_data_center"/>
</form>

<form id="cmJobMapperInsertForm" name="cmJobMapperInsertForm" method="post" onsubmit="return false;">
    <input type="hidden" name="flag" 				   id="flag"    value="job_insert"/>
    <input type="hidden" name="job_insert_arr" 	   id="job_insert_arr"/>
    <input type="hidden" name="desc_insert_arr" 	   id="desc_insert_arr"/>
    <input type="hidden" name="job_data_center" 	   id="job_data_center"/>
    <input type="hidden" name="late_subs"             id="late_subs"/>
    <input type="hidden" name="late_times"            id="late_times"/>
    <input type="hidden" name="late_execs"            id="late_execs"/>
    <input type="hidden" name="success_sms_yns"       id="success_sms_yns"/>
    <input type="hidden" name="action_gubun" 	   	   id="action_gubun"/>
</form>

<form id="popupDefJobDetailForm" name="popupDefJobDetailForm" method="post" onsubmit="return false;">

	<input type='hidden' name='data_center' 	 id='data_center'/>
    <input type="hidden" name="job_name" 		 id="job_name"/>
    <input type="hidden" name="table_id" 		 id="table_id"/>
    <input type="hidden" name="job_id" 			 id="job_id"/>
    <input type="hidden" name="sched_table" 	 id="sched_table"/>
    <input type="hidden" name="p_sched_table" 	 id="p_sched_table"/>
    <input type="hidden" id="menu_gb" name="menu_gb" value="${paramMap.menu_gb}"/>
</form>

<form id="docApprovalStateView" name="docApprovalStateView" method="post" onsubmit="return false;">

	<input type='hidden' name='data_center' 	 id='data_center'/>
    <input type="hidden" name="job_name" 		 id="job_name"/>
    <input type="hidden" name="state_cd" 		 id="state_cd"/>
</form>
<form id="userFrm" name="userFrm" method="post" onsubmit="return false;"></form>

<table style='width:100%;height:100%;border:none; '>
    <tr style='height:10px;'>
        <td style='vertical-align:top; '>
            <h4 class="ui-widget-header ui-corner-all">
                <div id='t_<%=gridId %>' class='title_area'>
                    <span><%=CommonUtil.isNull(CommonUtil.getMessage("CATEGORY.GB.03"))%> > <%=CommonUtil.isNull(arr_menu_gb[0]) %></span>
                </div>
            </h4>
        </td>
    </tr>
    <tr style='height:10px;'>
        <td style='vertical-align:top;'>
            <form name="frm1" id="frm1" method="post">
                <input type="hidden" id="rows_length" name="rows_length"/>
                <input type="hidden" id="job_names" name="job_names"/>
                <input type="hidden" id="data_center" name="data_center"/>
                <h4 class="ui-widget-header ui-corner-all">
                    <table style='width:100%;'>
                        <tr>
                            <th width='10%'>
                                <div class='cellTitle_kang2' style='min-width:100px;'>C-M</div>
                            </th>
                            <td width='15%' style="text-align:left">
                                <div class='cellContent_kang' style='width:300px;'>
                                    <select id="data_center_items" name="data_center_items"
                                            style="width:120px; height:21px;">
                                        <option value="">선택</option>
                                        <c:forEach var="cm" items="${cm}" varStatus="status">
                                            <option value="${cm.scode_cd},${cm.scode_eng_nm}">${cm.scode_nm}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </td>
                            <th width='10%'>
                                <div class='cellTitle_kang2'>조건</div>
                            </th>
                            <td width='20%' style="text-align:left; min-width:120px;" colspan=3>
                                <div class='cellContent_kang' style='min-width:120px; width:300px;'>
                                    <select name="search_gubun" id="search_gubun"
                                            style="width:120px;height:21px;min-width:120px">
                                        <option value="user_nm">담당자(모두)</option>
                                        <option value="user_nm1">담당자1</option>
                                        <option value="user_nm2">담당자2</option>
                                        <option value="user_nm3">담당자3</option>
                                        <option value="user_nm4">담당자4</option>
                                        <option value="user_nm5">담당자5</option>
                                        <option value="user_nm6">담당자6</option>
                                        <option value="user_nm7">담당자7</option>
                                        <option value="user_nm8">담당자8</option>
                                        <option value="user_nm9">담당자9</option>
                                        <option value="user_nm10">담당자10</option>
                                        <option value="grp_nm1">그룹1</option>
                                        <option value="grp_nm2">그룹2</option>
                                    </select>
							<input type="text" name="search_text" value="" id="search_text" style="width:150px;height:21px;min-width:100px;" />
                                </div>
                            </td>
                            <th width='10%'>
                                <div class='cellTitle_kang2'>조건2</div>
                            </th>
                            <td width='30%' style="text-align:left">
                                <div class='cellContent_kang'>
                                    <select name="search_gubun2" id="search_gubun2" style="width:120px;height:21px;">
                                        <option value="job_name">작업명</option>
                                        <option value="description">작업설명</option>
                                        <option value="cmd_line">작업수행명령</option>
                                    </select>
						            <input type="text" name="search_text2" value="" id="search_text2" style="width:150px;height:21px;"  />
                                </div>
                            </td>
                            <td width='5%'></td>
                        </tr>
                        <tr>
                            <th>
                                <div class='cellTitle_kang2'>폴더</div>
                            </th>
                            <td style="text-align:left">
                                <div class='cellContent_kang'>
                                    <input type="text" name="table_nm" id="table_nm" style="width:115px; height:21px;" onkeydown="return false;" readonly/>&nbsp;
                                    <select name="sub_table_of_def" id="sub_table_of_def" style="width:120px;height:21px;display:none;">
                                    	<option value="">전체</option>
									</select>
                                    <img id="btn_clear1" src="/images/sta2.png" style="width:16px;height:16px;vertical-align:middle;cursor:pointer;"/>
                                    <input type="hidden" name="table_of_def" id="table_of_def"/>
                                </div>
                            </td>
                            <th>
                                <div class='cellTitle_kang2' style='min-width:150px;'>어플리케이션</div>
                            </th>
                            <td width='20%' style="text-align:left; min-width:150px;" colspan=3>
                                <div class='cellContent_kang' style='min-width:100px;'>
                                    <select name="application_of_def" id="application_of_def"
                                            style="width:120px;height:21px;min-width:120px;">
                                        <option value="">--선택--</option>
                                    </select>
                                </div>
                            </td>

                            <th width='10%'>
                                <div class='cellTitle_kang2' style='min-width:100px;'>그룹</div>
                            </th>
                            <td width='15%' style="text-align:left">
                                <div class='cellContent_kang' style='min-width:100px; width:300px;'>
                                    <select id="group_name_of_def" name="group_name_of_def"
                                            style="width:120px; height:21px;">
                                        <option value=''>--선택--</option>
                                    </select>
                                    <input type='text' id='group_name_of_def_text' name='group_name_of_def_text'
                                           style="width:110px; height:21px;display:none"/>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th width="10%">
                                <div class='cellTitle_kang2'>수행서버</div>
                            </th>
                            <td width="20%" style="text-align:left">
                                <div class='cellContent_kang'>
                                    <select id="node_id" name="node_id" style="width:120px; height:21px;">
                                        <option value=''>--선택--</option>
                                    </select>
                                </div>
                            </td>
                            <th>
                                <div class='cellTitle_kang2'>미사용 일수</div>
                            </th>
                            <td colspan="3" style="text-align:left">
                                <div class='cellContent_kang'>
                                    <input type='text' id='cc_count' name='cc_count' maxlength='3'
                                           style="width:50px; height:21px;"/> 일 이상 미수행
                                </div>
                            </td>
                            <th width="10%">
                                <div class='cellTitle_kang2'>이관여부</div>
                            </th>
                            <td width="10%" style="text-align:left">
                                <div class='cellContent_kang'>
                                    <select id="cmjob_transfer" name="cmjob_transfer" style="width:120px; height:21px;">
                                        <option value=''>전체</option>
                                        <option value='Y'>이관완료</option>
                                        <option value='N'>이관필요</option>
                                    </select>
                                    <span id="btn_search" style='float:right;margin:3px;'>검 색</span>
                                </div>
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
                    <span id="btn_cmjob_search">작업이관</span>
                    <span id="btn_user_change">담당자일괄변경</span>
                    <span id="btn_form">엑셀일괄양식</span>
                    <span id="btn_excel_user_change">담당자엑셀일괄변경</span>
                    <span id="btn_down">엑셀다운</span>
                </div>
            </h4>
        </td>
    </tr>
</table>
<!-- </div> -->

<iframe name="if_defJobs" id="if_defJobs" style="width:0px;height:0px;border:none;"></iframe>
<script>
    var listChk = false;
    var defJobsCnt = 0;

    function gridCellCustomFormatter(row, cell, value, columnDef, dataContext) {

        var ret 		   = "";
        var job_id 		   = getCellValue(gridObj, row, 'JOB_ID');
        var sched_table    = getCellValue(gridObj, row, 'SCHED_TABLE');
        var job_name 	   = getCellValue(gridObj, row, 'JOB_NAME');
        var table_id 	   = getCellValue(gridObj, row, 'TABLE_ID');
        var description	   = getCellValue(gridObj, row, 'DESCRIPTION');
        var cmjob_transfer = getCellValue(gridObj, row, 'CMJOB_TRANSFER');
        var when_cond	   = getCellValue(gridObj, row, 'WHEN_COND');
        var shout_time     = getCellValue(gridObj, row, 'SHOUT_TIME');
        var state_cd       = getCellValue(gridObj, row, 'STATE_CD');
        var doc_cd	       = getCellValue(gridObj, row, 'DOC_CD');

        if (columnDef.id == 'FORECAST') {
            ret = "<a href=\"JavaScript:popupForecast('" + sched_table + "','" + encodeURIComponent(job_name) + "');\" /><font color='red'>" + value + "</font></a>";
        }

        if (columnDef.id == 'GRAPH') {
            ret = "<a href=\"JavaScript:popupJobGraph('" + encodeURIComponent(job_name) + "','" + table_id + "','" + job_id + "');\" /><font color='red'>" + value + "</font></a>";
        }

        if (columnDef.id == 'JOB_NAME') {
            ret = "<a href=\"JavaScript:popupDefJobDetail('" + encodeURIComponent(job_name) + "','" + table_id + "','" + job_id + "','" + sched_table + "');\" /><font color='red'>" + value + "</font></a>";
        }

        if (columnDef.id == 'VERSION_COMPARE') {
            ret = "<a href=\"JavaScript:popupVersionCompare('" + encodeURIComponent(job_name) + "');\" /><font color='red'>" + value + "</font></a>";
        }

        if (columnDef.id == 'USER_NM') {
            ret = "<a href=\"JavaScript:jobUserInfo('" + encodeURIComponent(job_name) + "');\" /><font color='blue'>" + value + "</font></a>";
        }

        if (columnDef.id == 'JOB_HISTORY') {
            ret = "<a href=\"JavaScript:jobHistoryInfo('" + encodeURIComponent(job_name) + "','"+ $("select[name='data_center_items']").val()+"');\" /><font color='blue'><b>" + value + "</b></font></a>";
        }

        if (columnDef.id == 'CMJOB_TRANSFER') {
        	if(cmjob_transfer == "이관필요"){
        		ret = "<a href=\"JavaScript:cmJobMapperInsert('" + encodeURIComponent(job_name) + "','" + description + "','" +  '' + "','" + when_cond + "','" +  shout_time + "');\" /><font color='red'>" + value + "</font></a>";
        	}else{
        		ret = "<font>"+ value +"</font>"
        	}
        }
        
        if (columnDef.id == 'STATE_NM') {
            ret = "<a href=\"JavaScript:docApprovalStateView('" + doc_cd + "');\" /><font color='blue'>" + value + "</font></a>";
        }

        return ret;
    }

    var gridObj = {
        id: "<%=gridId %>"
        , colModel: [
	   		{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'번호',width:50,minWidth:50,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'SCHED_TABLE',id:'SCHED_TABLE',name:'폴더',width:120,minWidth:120,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'APPLICATION',id:'APPLICATION',name:'어플리케이션',width:120,minWidth:120,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'GROUP_NAME',id:'GROUP_NAME',name:'그룹',width:120,minWidth:120,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'JOBSCHEDGB',id:'JOBSCHEDGB',name:'작업종류',width:70,minWidth:70,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	   		,{formatter:gridCellCustomFormatter,field:'STATE_NM',id:'STATE_NM',name:'결재상태',width:70,minWidth:70,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	   		,{formatter:gridCellCustomFormatter,field:'JOB_NAME',id:'JOB_NAME',name:'작업명',width:200,minWidth:200,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'DESCRIPTION',id:'DESCRIPTION',name:'작업설명',width:200,minWidth:200,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'TASK_TYPE',id:'TASK_TYPE',name:'작업타입',width:150,minWidth:80,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
	   		,{formatter:gridCellCustomFormatter,field:'USER_NM',id:'USER_NM',name:'담당자',width:100,minWidth:100,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'NODE_GRP',id:'NODE_GRP',name:'수행서버',width:150,minWidth:150,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'CYCLIC',id:'CYCLIC',name:'반복',width:60,minWidth:60,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'FROM_TIME',id:'FROM_TIME',name:'시작시간',width:100,minWidth:100,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'CC_COUNT',id:'CC_COUNT',name:'미사용일수',width:80,minWidth:80,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	   		,{formatter:gridCellCustomFormatter,field:'CMJOB_TRANSFER',id:'CMJOB_TRANSFER',name:'이관여부',width:80,minWidth:80,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'INS_DATE',id:'INS_DATE',name:'등록일',width:140,minWidth:140,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	   		,{formatter:gridCellCustomFormatter,field:'FORECAST',id:'FORECAST',name:'FORECAST',width:70,minWidth:70,headerCssClass:'cellCenter',cssClass:'cellCenter'}
	   		,{formatter:gridCellCustomFormatter,field:'GRAPH',id:'GRAPH',name:'GRAPH',width:70,minWidth:70,headerCssClass:'cellCenter',cssClass:'cellCenter'}
	   		,{formatter:gridCellCustomFormatter,field:'VERSION_COMPARE',id:'VERSION_COMPARE',name:'직전비교',width:70,minWidth:70,headerCssClass:'cellCenter',cssClass:'cellCenter'}
	   		,{formatter:gridCellCustomFormatter,field:'JOB_HISTORY',id:'JOB_HISTORY',name:'전체이력',width:70,minWidth:70,headerCssClass:'cellCenter',cssClass:'cellCenter'}


            ,{formatter:gridCellNoneFormatter,field:'JOB_ID',id:'JOB_ID',name:'JOB_ID',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
            ,{formatter:gridCellNoneFormatter,field:'TABLE_ID',id:'TABLE_ID',name:'TABLE_ID',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
            ,{formatter:gridCellNoneFormatter,field:'WHEN_COND',id:'WHEN_COND',name:'WHEN_COND',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
            ,{formatter:gridCellNoneFormatter,field:'SHOUT_TIME',id:'SHOUT_TIME',name:'SHOUT_TIME',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
            ,{formatter:gridCellNoneFormatter,field:'STATE_CD',id:'STATE_CD',name:'STATE_CD',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
            ,{formatter:gridCellNoneFormatter,field:'DOC_CD',id:'DOC_CD',name:'DOC_CD',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
        ]
        , rows: []
        , vscroll:<%=S_GRID_VSCROLL%>
    };

    $(document).ready(function () {

        var session_dc_code = "<%=strSessionDcCode%>";
        var table_name = "<%=strSessionTab%>";
        var application = "<%=strSessionApp%>";
        var group_name = "<%=strSessionGrp%>";
        var user_gb = "<%=S_USER_GB%>";

        $("#btn_search").show();
        if (user_gb != '99') {
            $("#btn_cmjob_search").hide();
            $("#btn_user_change").hide();
        }

        <c:if test="${USER_GB eq '99'}">
        // 관리자는 담당자 default 검색 조건 제거
        $('#search_text').val("");
        </c:if>

        //초기 검색조건 - C-M, 폴더, 어플리케이션, 그룹
        if (session_dc_code != "") { // 개인정보에 C-M이 등록되어 있을경우
            $("select[name='data_center_items']").val(session_dc_code);
            $("#f_s").find("input[name='data_center']").val(session_dc_code);
        } else { // 개인정보에 C-M이 등록이 되어있지 않을경우 -> C-M 콤보박스에서 첫번째값 선택
            $("#data_center_items option:eq(1)").prop("selected", true);
            $("#f_s").find("input[name='data_center']").val($("select[name='data_center_items']").val());
        }

     	// 개인정보 설정에 폴더 값이 셋팅되어 있을 경우 (2024-11-05 김선중)
        if (table_name != '') {
            $("input[name='table_nm']").val(table_name);

            if(table_name.indexOf(",") == -1) {
				// 폴더에 매핑되어 있는 어플리케이션, 그룹 목록을 조회 후, 설정 값에 따라 검색필터에 세팅 
				getAppGrpCodeList("application_of_def", "2", application, "", table_name);
				setTimeout(function(){
					var selected_app_grp_cd	= $("#application_of_def option:selected").val().split(",")[0]; //그룹 조회 파라미터.
					if (selected_app_grp_cd != "")
						getAppGrpCodeList("group_name_of_def", "3", group_name, selected_app_grp_cd); //어플리케이션 코드로 그룹 조회 및 그룹 선택.
				}, 1000);
			}
            
         	// 작업을 조회할 폴더, 어플리케이션, 그룹 값 세팅
            $("#f_s").find("input[name='p_sched_table']").val(table_name);
            $("#f_s").find("input[name='p_application_of_def']").val(application);
            $("#f_s").find("input[name='p_group_name_of_def']").val(group_name);

            //폴더에 속한 수행서버 조회
            mHostList(session_dc_code, table_name);

        } else {
            //수행서버 전체 조회
            mHostList(session_dc_code, '');
        }

        viewGrid_1(gridObj, "ly_" + gridObj.id, {enableColumnReorder: true}, 'AUTO');

        setTimeout(function () {
            defJobsList2();
        }, 500);

        $("#btn_search").button().unbind("click").click(function () {
            defJobsList2();
        });

        $('#search_text').unbind('keypress').keypress(function (e) {
            if (e.keyCode == 13) {
                defJobsList2();
            }
        });

        //조건2(작업명/작업설명) 분리
        $('#search_text2').unbind('keypress').keypress(function (e) {
            if (e.keyCode == 13) {
                defJobsList2();
            }
        });

        // 어플리케이션 엔터
        $('#application_of_def_text').unbind('keypress').keypress(function (e) {
            if (e.keyCode == 13) {
                defJobsList2();
            }
        });

        // 미사용 일수 엔터
        $('#cc_count').unbind('keypress').keypress(function (e) {
            if (e.keyCode == 13) {
                defJobsList2();
            }
        });

        $("#data_center_items").change(function () {		//C-M

            //초기화
            $("#table_nm").val("");
            $("#table_of_def").val("");

            $("select[name='application_of_def'] option").remove();
            $("select[name='application_of_def']").append("<option value=''>--선택--</option>");

            $("select[name='group_name_of_def'] option").remove();
            $("select[name='group_name_of_def']").append("<option value=''>--선택--</option>");

            var data_center_items = $(this).val();

            if ($(this).val() != "") {
                $("#f_s").find("input[name='data_center']").val(data_center_items);
                mHostList(data_center_items, '');
            }

        });

        $("#btn_cmjob_search").button().unbind("click").click(function () {
            popDefJobExceptMapperForm();
        });

        $("#btn_down").button().unbind("click").click(function () {
            goExcel();
        });

        $("#btn_form").button().unbind("click").click(function () {
            goExcelForm();
        });

        $("#btn_user_change").button().unbind("click").click(function () {
            userChange();
        });

        $("#btn_excel_user_change").button().unbind("click").click(function () {
            popupExcelCode();
        });

        //테이블 클릭 시
        $("#table_nm").click(function () {
            var data_center = $("select[name='data_center_items'] option:selected").val();
            var select_table = $("input[name='table_nm']").val();
            
            if (data_center == "") {
                alert("C-M 을 선택해 주세요.");
                return;
            } else {
            	searchPoeTabForm(select_table);
            }
        });

        $("#application_of_def").change(function () {
            $("#group_name_of_def option").remove();
            $("#group_name_of_def").append("<option value=''>--선택--</option>");

            var grp_info = $(this).val().split(",");

            $("#p_application_of_def").val(grp_info[1]);
            $("#p_group_name_of_def").val("");

            if (grp_info != "")
                getAppGrpCodeList("group_name_of_def", "3", "", grp_info[0]);

            // 세팅된 어플리케이션에 그룹이 하나일 경우 자동 세팅
            if ($("select[name='group_name_of_def'] option").length == 2) {
                $("select[name='group_name_of_def'] option:eq(1)").prop("selected", true);
                grp_info = $("select[name='group_name_of_def']").val().split(",");
                $("#p_group_name_of_def").val(grp_info[1]);
            }
        });

        $("#group_name_of_def").change(function () {
            var grp_info = $(this).val().split(",");
            $("#p_group_name_of_def").val(grp_info[1]);
        });

        $("#btn_clear1").unbind("click").click(function () {
            $("#f_s").find("input[name='p_sched_table']").val("");
            $("#f_s").find("input[name='p_application_of_def']").val("");
            $("#f_s").find("input[name='p_group_name_of_def']").val("");

            $("#frm1").find("input[name='table_nm']").val("");
            $("#frm1").find("input[name='table_of_def']").val("");

            $("#f_s").find("input[name='p_application_of_def_text']").val("");
            $("#f_s").find("input[name='p_group_name_of_def_text']").val("");

            $("#frm1").find("input[name='application_of_def_text']").val("");
            $("#frm1").find("input[name='group_name_of_def_text']").val("");

            $("select[name='application_of_def'] option").remove();
            $("select[name='application_of_def']").append("<option value=''>--선택--</option>");

            $("select[name='group_name_of_def'] option").remove();
            $("select[name='group_name_of_def']").append("<option value=''>--선택--</option>");
            
            $("select[name='sub_table_of_def'] option").remove();
			$("select[name='sub_table_of_def']").append("<option value=''>--선택--</option>");
			
			document.getElementById('sub_table_of_def').style.display = 'none';

            var data_center = $("select[name='data_center_items'] option:selected").val();

            mHostList(data_center, '');

        });

        $("#btn_clear2").unbind("click").click(function () {
            $("#frm1").find("input[name='search_text']").val("");
        });

        $('#application_of_def_text').on('keyup', function (event) {
            var app_text = $(this).val().replace(/ /gi, '');
            $('#p_application_of_def_text').val(app_text);
        });
        $('#group_name_of_def_text').on('keyup', function (event) {
            var app_text = $(this).val().replace(/ /gi, '');
            $('#p_group_name_of_def_text').val(app_text);
        });

        //어플리케이션 제외검색 체크박스(신한캐피탈 23.03.29)
        $('#chk_app').click(function () {
            if ($('#chk_app').is(":checked")) {
                $('#p_chk_app').val("Y");
            } else {
                $('#p_chk_app').val("N");
            }
        });

        //스크롤 페이징
        var grid = $('#' + gridObj.id).data('grid');
        grid.onScroll.subscribe(function (e, args) {
            var elem = $("#g_ez003").children(".slick-viewport");
            if (elem[0].scrollHeight - elem.scrollTop() - elem.css("height").replace("px", "") + 17 < 100) {
                if (listChk) {
                    listChk = false;
                    var startRowNum = parseInt($("#startRowNum").val());
                    startRowNum += parseInt($('#pagingNum').val());
                    defJobsList2(startRowNum);
                }
// 				alert(elem[0].scrollHeight - elem.scrollTop() - elem.css("height").replace("px", "") + 17);
            }
        });
    });

    function defJobsList2(startRowNum) {

        clearGridSelected(gridObj);

        var data_center_items = $("select[name='data_center_items'] option:selected").val();
        var node_id = $("select[name='node_id'] option:selected").val();
        var arr_node_id = node_id.split(",");

        if (data_center_items == "") {
            alert("C-M 을 선택해 주세요.");
            return;
        }

        $("#f_s").find("input[name='p_search_gubun']").val($("#frm1").find("select[name='search_gubun'] option:selected").val());
        $("#f_s").find("input[name='p_search_gubun2']").val($("#frm1").find("select[name='search_gubun2'] option:selected").val());
        $("#f_s").find("input[name='p_search_text']").val($("#frm1").find("input[name='search_text']").val());
        $("#f_s").find("input[name='p_search_text2']").val($("#frm1").find("input[name='search_text2']").val());
        $("#f_s").find("input[name='p_critical']").val($("#frm1").find("select[name='critical'] option:selected").val());
        $("#f_s").find("input[name='p_cc_count']").val($("#frm1").find("input[name='cc_count']").val());
        $("#f_s").find("input[name='p_cmjob_transfer']").val($("#frm1").find("select[name='cmjob_transfer'] option:selected").val());
        $("#f_s").find("input[name='p_node_id']").val(arr_node_id[1]);
        
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

        //페이징 처리
        if (startRowNum != '' && startRowNum != null && startRowNum != undefined) {
            $('#startRowNum').val(startRowNum);
        } else {
            var elem = $("#g_ez003").children(".slick-viewport");
            elem.scrollTop(0);
            startRowNum = 0;
            $('#startRowNum').val(0);
        }

		try{viewProgBar(true);}catch(e){}
        $('#ly_total_cnt').html('');

        var data_center = $("#f_s").find("input[name='data_center']").val();
        var search_gubun = $("#f_s").find("input[name='p_search_gubun']").val();
        var search_gubun2 = $("#f_s").find("input[name='p_search_gubun2']").val();
        var search_text = $("#f_s").find("input[name='p_search_text']").val();
        var search_text2 = $("#f_s").find("input[name='p_search_text2']").val();
        var sched_table = $("#f_s").find("input[name='p_sched_table']").val();
        var application_of_def = $("#f_s").find("input[name='p_application_of_def']").val();
        var group_name_of_def = $("#f_s").find("input[name='p_group_name_of_def']").val();
        var mcode_nm = $("#f_s").find("input[name='p_mcode_nm']").val();
        var scode_nm = $("#f_s").find("input[name='p_scode_nm']").val();
        var moneybatchjob = $("#f_s").find("input[name='p_moneybatchjob']").val();
        var critical = $("#f_s").find("input[name='p_critical']").val();
        var application_of_def_text = $("#f_s").find("input[name='p_application_of_def_text']").val();
        var group_name_of_def_text = $("#f_s").find("input[name='p_group_name_of_def_text']").val();
        var startRowNum = $("#f_s").find("input[name='startRowNum']").val();
        var pagingNum = $("#f_s").find("input[name='pagingNum']").val();
        var cc_count = $("#f_s").find("input[name='p_cc_count']").val();
        var node_id = $("#f_s").find("input[name='p_node_id']").val();
        var chk_app = $("#f_s").find("input[name='p_chk_app']").val();
        var p_cmjob_transfer = $("#f_s").find("input[name='p_cmjob_transfer']").val();

        var formData = new FormData();
        formData.append("c", "cData2");
        formData.append("data_center", data_center);
        formData.append("itemGb", "emDefJobs");
        formData.append("p_search_gubun", search_gubun);
        formData.append("p_search_text", search_text);
        formData.append("p_search_gubun2", search_gubun2);
        formData.append("p_search_text2", search_text2);
        formData.append("p_sched_table", sched_table);
        formData.append("p_application_of_def", application_of_def);
        formData.append("p_group_name_of_def", group_name_of_def);
        formData.append("p_mcode_nm", mcode_nm);
        formData.append("p_scode_nm", scode_nm);
        formData.append("p_moneybatchjob", moneybatchjob);
        formData.append("p_critical", critical);
        formData.append("p_application_of_def_text", application_of_def_text);
        formData.append("p_group_name_of_def_text", group_name_of_def_text);
        formData.append("startRowNum", startRowNum);
        formData.append("pagingNum", pagingNum);
        formData.append("p_cc_count", cc_count);
        formData.append("p_chk_app", chk_app);
        formData.append("p_node_id", node_id);
        formData.append("p_cmjob_transfer", p_cmjob_transfer);

        var i = 0;

        $.ajax({
            url: "<%=sContextPath %>/common.ez",
            type: "POST",
            processData: false,
            contentType: false,
            dataType: "json",
            data: formData,
            success: function (data) {

                var rowsObj = new Array();

                if (startRowNum != 0) {
                    rowsObj = gridObj.rows;
                }

                $.each(data, function (index, item) {

                    var sched_table 	  = data[index].SCHED_TABLE;
                    var application 	  = data[index].APPLICATION;
                    var group_name 		  = data[index].GROUP_NAME;
                    var mem_name 		  = data[index].MEM_NAME;
                    var user_nm 		  = data[index].USER_NM;
                    //var manager_nm 			= data[index].MANAGER_NM;
                    var node_grp 		  = data[index].NODE_GRP;
                    var cyclic 			  = data[index].CYCLIC;
                    var from_time 		  = data[index].FROM_TIME;
                    //var jobschedgb 			= data[index].JOBSCHEDGB;
                    var error_description = data[index].ERROR_DESCRIPTION;
                    var description 	  = data[index].DESCRIPTION;
                    var ins_date 		  = data[index].INS_DATE;
                    var job_id 			  = data[index].JOB_ID;
                    var table_id 		  = data[index].TABLE_ID;
                    var job_name 		  = data[index].JOB_NAME;
                    var user_daily 		  = data[index].USER_DAILY;
                    var cc_count 		  = data[index].CC_COUNT;
                    var task_type         = data[index].TASK_TYPE;
                    var smart_job_yn      = data[index].SMART_JOB_YN;

                    var cmjob_transfer	  = data[index].CMJOB_TRANSFER;
                    var when_cond	      = data[index].WHEN_COND;
                    var shout_time	      = data[index].SHOUT_TIME;
                    
                    var doc_cd	    	  = data[index].DOC_CD;
                    var state_cd	      = data[index].STATE_CD;
                    var state_nm	      = data[index].STATE_NM;
                    
                    var appl_type	      = data[index].APPL_TYPE
                    
                   	defJobsCnt 			  = data[index].DEFJOBCNT;

                    //작업종류(2022.11.03 전북은행)
                    if (user_daily != "") {
                        jobschedgb = "정기";
                    } else if (user_daily == "") {
                        jobschedgb = "비정기";
                    }
                    if(cmjob_transfer == 'Y'){
                    	cmjob_transfer = '이관완료';
                    }else if(cmjob_transfer == 'N'){
                    	cmjob_transfer = '이관필요';
                    }

                    var smart_folder = "";
					if ( smart_job_yn == "Y" ) {
						smart_folder = "<img src='/imgs/smart_folder.png' style='vertical-align:middle;' width='20' height='20'> ";
					}
					
					
					if(task_type == 'Job') task_type = 'Script';
					
					if(appl_type == "KBN062023") task_type = 'Kubernetes';
					if(appl_type == "DATABASE") task_type = 'Database';

                    rowsObj.push({
                        'grid_idx': i + 1 + startRowNum * 1
						,'SCHED_TABLE': smart_folder + sched_table
						,'APPLICATION': application
						,'GROUP_NAME': group_name
						,'JOB_NAME': job_name
						,'MEM_NAME': mem_name
						,'USER_NM': user_nm
                        //,'MANAGER_NM': manager_nm
						,'NODE_GRP': node_grp
						,'CYCLIC': cyclic
						,'FROM_TIME': from_time
						,'JOBSCHEDGB': jobschedgb
						,'ERROR_DESCRIPTION': error_description
						,'DESCRIPTION': description
						,'INS_DATE': ins_date
						,'JOB_ID': job_id
						,'TABLE_ID': table_id
                        ,'WHEN_COND': when_cond
                        ,'SHOUT_TIME': shout_time
						,'FORECAST':"<img src='<%=sContextPath %>/images/icon_lnb52_b.png' border='0' width='20' height='20'>"
						,'GRAPH':"<img src='<%=sContextPath %>/images/icon_lnb65b.png' border='0' width='20' height='20'>"
						,'VERSION_COMPARE': "<img src='<%=sContextPath %>/images/icon_lnb23_b.png' border='0' width='20' height='20'>"
						,'CC_COUNT': cc_count
						,'TASK_TYPE': task_type
						,'CMJOB_TRANSFER': cmjob_transfer
						,'JOB_HISTORY': "<img src='<%=sContextPath %>/images/icon_lnb25_b.png' border='0' width='20' height='20'>"
						,'DOC_CD': doc_cd
						,'STATE_CD': state_cd
						,'STATE_NM': state_nm
                    });
                    ++i;
                });
                gridObj.rows = rowsObj;
                setGridRows(gridObj);

                //컬럼 자동 조정 기능
                $('body').resizeAllColumns();
            },
            error: function (data) {
                alert("Data Reading Error... ");
            },
            complete: function (data) {
                if (gridObj.rows.length == 0) {
                    defJobsCnt = 0;
                }
                $('#ly_total_cnt').html('[ TOTAL : ' + (gridObj.rows.length) + '/' + parseInt(defJobsCnt) + ' ]');
                if (parseInt(gridObj.rows.length) != parseInt(defJobsCnt)) {
                    listChk = true;
                } else {
                    listChk = false;
                }
				try{viewProgBar(false);}catch(e){}
            }
        });
    }

    function popupForecast(sched_table, job_name) {

        var frm = document.f_s;

        frm.v_sched_table.value = sched_table;
        frm.job_name.value = job_name;

        openPopupCenter("about:blank", "popupForecast", 1100, 500);

        frm.action = "<%=sContextPath %>/mPopup.ez?c=ez010";
        frm.target = "popupForecast";
        frm.submit();
    }


    function popupDefJobDetail(job_name, table_id, job_id, sched_table) {

        var frm = document.popupDefJobDetailForm;

		frm.data_center.value = $("#f_s").find("input[name='data_center']").val();
        frm.job_name.value = job_name;
        frm.table_id.value = table_id;
        frm.job_id.value = job_id;
        frm.sched_table.value = sched_table;
        
        // 스마트 폴더를 선택하면 아래 서브 폴더까지 나열해서 검색조건에 셋팅하고 있음
        // sched_table 를 검색조건에 다시 셋팅 하게 수정 (2024.05.03 강명준)
        frm.p_sched_table.value = sched_table;
        
        openPopupCenter1("about:blank", "popupDefJobDetail", 1350, 800);

        frm.action = "<%=sContextPath %>/mPopup.ez?c=ez011";
        frm.target = "popupDefJobDetail";
        frm.submit();
        
    }

    function popupJobGraph(job_name, table_id, job_id) {

        var frm = document.f_s;

        frm.job_name.value = job_name;
        frm.table_id.value = table_id;
        frm.job_id.value = job_id;

        openPopupCenter2("about:blank", "popupJobGraph_d3", 1200, 700);

        frm.action = "<%=sContextPath %>/mPopup.ez?c=ez012_d3";
        frm.target = "popupJobGraph_d3";
        frm.submit();
    }

    function popupVersionCompare(job_name) {

        var frm = document.f_s;

        frm.job_name.value = job_name;

        openPopupCenter("about:blank", "popupJobDefineCompareInfo", 800, 900);

        frm.action = "<%=sContextPath %>/mPopup.ez?c=jobDefineCompareInfo";
        frm.target = "popupJobDefineCompareInfo";
        frm.submit();
    }

    function goExcel() {

        var frm = document.f_s;
        frm.flag.value = "";
		try{viewProgBar(true);}catch(e){}
        frm.action = "<%=sContextPath %>/mEm.ez?c=ez003_excel2";
        frm.target = "if1";
        frm.submit();

		try{viewProgBar(false);}catch(e){}
    }

    function goExcelForm() {

        var frm = document.f_s;

        //alert("너무 많은 양의 데이터 출력시 DB에 부하가 갈 수 있습니다. 조회조건을 넣으세요");
        alert("1000건 당 약 30초가 소요됩니다. \n작업타입이 command, script, dummy 속성인 \n작업만 다운로드 됩니다.");
        frm.flag.value = "";
        frm.action = "<%=sContextPath %>/mEm.ez?c=ez003_excel_doc";
        frm.target = "if1";
        frm.submit();
    }

    function selectTable(eng_nm, desc, user_daily, grp_cd, task_type, table_id) {

        $("#table_nm").val(eng_nm);
        $("#table_of_def").val(eng_nm);

        dlClose("dl_tmp1");

        $("#f_s").find("input[name='p_sched_table']").val(eng_nm);
        $("#f_s").find("input[name='p_application_of_def']").val("");
        $("#f_s").find("input[name='p_group_name_of_def']").val("");

        $("#f_s").find("input[name='p_application_of_def_text']").val("");
        $("#f_s").find("input[name='p_group_name_of_def_text']").val("");

        $("#frm1").find("input[name='application_of_def_text']").val("");
        $("#frm1").find("input[name='group_name_of_def_text']").val("");

        var data_center = $("select[name='data_center_items'] option:selected").val();
        
      	//어플리케이션 초기화
		$("select[name='application_of_def'] option").remove();
		$("select[name='application_of_def']").append("<option value=''>--선택--</option>");

        //그룹초기화
        $("select[name='group_name_of_def'] option").remove();
        $("select[name='group_name_of_def']").append("<option value=''>--선택--</option>");
        
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
    	
    	// 어플리케이션, 그룹 자동 셋팅
        if(eng_nm.indexOf(",") == -1) { // 한개의 폴더 검색일 때
			getAppGrpCodeList("application_of_def", "2", "", grp_cd); // 어플리케이션을 검색
			mHostList(data_center, eng_nm); // 수행서버 검색
			
			// 어플이 하나만 존재하면 자동 세팅
			if($("select[name='application_of_def'] option").length == 2){
				$("select[name='application_of_def'] option:eq(1)").prop("selected", true);
				
				var grp_info = $("select[name='application_of_def']").val().split(",");
				$("#p_application_of_def").val(grp_info[1]);
				
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
				}
			}
		}else {
			mHostList(data_center,'');
		}
    }

    function selectTable2(eng_nm, desc) {

        $("#table_nm").val(eng_nm);
        $("#table_of_def").val(eng_nm);

        dlClose("dl_tmp1");

        $("#f_s").find("input[name='p_sched_table']").val(eng_nm);
        $("#f_s").find("input[name='p_application_of_def']").val("");
        $("#f_s").find("input[name='p_group_name_of_def']").val("");


        getAppGrpCodeList("", "2", "", "application_of_def", eng_nm);

        //그룹초기화
        $("select[name='group_name_of_def'] option").remove();
        $("select[name='group_name_of_def']").append("<option value=''>--선택--</option>");
    }

    function goWritePrc(param, doc_gb) {

        var cd = "99999";
        var tabId = 'tabs-' + cd;
        top.closeTab(tabId);		//기존 열려있는 탭을 닫는다.

        var doc_name = "";

        if (doc_gb == "01") {
            doc_name = "등록요청[참조기안]"
        }
        if (doc_gb == "02") {
            doc_name = "긴급요청[참조기안]"
        }
        if (doc_gb == "04") {
            doc_name = "수정요청[참조기안]"
        }
        if (doc_gb == "03") {
            doc_name = "삭제요청[참조기안]"
        }
        top.addTab('c', doc_name, '02', cd, 'tWorks.ez?c=ez004_w_04&flag=ref&' + param);
    }

    function selectApplication3(scode_nm, desc) {
        var s_nm = $("#scode_nm").val();
        if (s_nm == "") {
            $("#scode_nm").val(desc);
        } else {
            $("#scode_nm").val("");
            $("#scode_nm").val(desc);
        }

        dlClose("dl_tmp1");

        //검색의 애플리케이션에 값을 셋

        if ($("#f_s").find("input[name='p_scode_nm']").val() == "") {
            $("#f_s").find("input[name='p_scode_nm']").val(scode_nm);
        } else {
            $("#f_s").find("input[name='p_scode_nm']").val("");
            $("#f_s").find("input[name='p_scode_nm']").val(scode_nm);
            scode_nm = $("#f_s").find("input[name='p_scode_nm']").val();
        }
    }

    function userChange() {
        var selected_rows = $('#' + gridObj.id).data('grid').getSelectedRows();
        var rows_length = selected_rows.length;
        if (rows_length == 0) {
            alert("담당자를 변경할 작업을 선택해주세요.");
            return;
        }

        //담당자 변경할 작업의 이름들
        var job_names = "";
        for (var i = 0; i < rows_length; i++) {
            job_names += getCellValue(gridObj, selected_rows[i], 'JOB_NAME');
            if (i < rows_length - 1)
                job_names += ",";
        }

        var data_center = $("select[name='data_center_items'] option:selected").val();
        var application_of_def = $("select[name='application_of_def'] option:selected").val();
        var group_name_of_def = $("select[name='group_name_of_def'] option:selected").val();
        var search_gubun = $("select[name='search_gubun'] option:selected").val();
        var search_text = $("#search_text").val();

        var frm = document.frm1;

        openPopupCenter("about:blank", "jobMapperUpdate", 530, 510);

        frm.data_center.value = data_center;
        frm.application_of_def.value = application_of_def;
        frm.group_name_of_def.value = group_name_of_def;
        frm.search_gubun.value = search_gubun;
        frm.search_text.value = search_text;
        frm.job_names.value = job_names;
        frm.rows_length.value = rows_length;

        frm.target = "jobMapperUpdate";
        frm.action = "/tWorks.ez?c=ez012_popup";

        frm.submit();
    }

    //ezjobs에 없는 C-M에서 등록한 작업 이관 기능
    function popDefJobExceptMapperForm() {
    	
    	var session_dc_code = "<%=strSessionDcCode%>";
    	
        var sHtml1 = "<div id='defJobExceptMapper' style='overflow:hidden;display:none;padding:0;border-top:1px solid blue;border-bottom:1px solid blue;border-left:1px solid blue;border-right:1px solid blue;'>";
        sHtml1 += "<form id='defJobExceptMapperForm' name='defJobExceptMapperForm' method='post' onsubmit='return false;'>";
        sHtml1 += "<input type='hidden' name='job_data_center' id='job_data_center'/>";
        sHtml1 += "<input type='hidden' name='job_insert_arr' id='job_insert_arr'/>";
        sHtml1 += "<input type='hidden' name='desc_insert_arr' id='desc_insert_arr'/>";
//         sHtml1 += "<input type='hidden' name='flag' value='job_insert'/>";

        sHtml1 += "<table style='width:100%;height:100%;border:none;'>"; //table 시작

        sHtml1 += "<tr>"; // tr
        sHtml1 += "<td style='vertical-align:top;height:100%;width:500px;text-align:right;' colspan=2>";
        sHtml1 += "<div class='ui-widget-header ui-corner-all'>";
        sHtml1 += "C-M : <select name='job_search_data_center' id='job_search_data_center' >";
        sHtml1 += "<option value=''>--선택--</option>";
        <c:forEach var="cm" items="${cm}" varStatus="status">
        sHtml1 += "<option value='${cm.scode_cd},${cm.scode_eng_nm}'>${cm.scode_nm}</option>"
        </c:forEach>;
        sHtml1 += "</select>";
        sHtml1 += "&nbsp;작업명 : <input type='text' name='p_job_name' id='p_job_name' value='' />";
        sHtml1 += "&nbsp;&nbsp;<span id='btn_job_search' style='margin:3px;'>검 색</span>";
        sHtml1 += "</div>";
        sHtml1 += "</td>";
        sHtml1 += "</tr>"; // /tr
        sHtml1 += "<tr style='height:480px;'>"; // tr
        sHtml1 += "<td id='ly_jobListGrid' style='vertical-align:top;' colspan=2>";
        sHtml1 += "<div id='jobListGrid' class='ui-widget-header ui-corner-all'></div>";
        sHtml1 += "</td>";
        sHtml1 += "</tr>"; // /tr
        sHtml1 += "<tr style='height:5px;'>"; // tr
        sHtml1 += "<td style='vertical-align:top;'>"; // td
        sHtml1 += "<h5 class='ui-corner-all' >";
        sHtml1 += "<div id='ly_jobList_total_cnt' style='padding:5px;float:left;'></div>";
        sHtml1 += "</h5>";
        sHtml1 += "</td>"; // /td
        sHtml1 += "<td style='vertical-align:top;'>"; // td
        sHtml1 += "<div align='right' style='padding:3px;'><span id='btn_job_insert' style='margin:3px;'>작업이관</span></div>";
        sHtml1 += "</td>"; // /tb
        sHtml1 += "</tr>"; //tr 3 끝
        sHtml1 += "</table>"; //table 끝

        sHtml1 += "</form>";
        sHtml1 += "</div>";

        $('#defJobExceptMapper').remove();
        $('body').append(sHtml1);

        dlPop02('defJobExceptMapper', "작업검색 ", 1000, 570, false);

        var gridObj = {
            id: "jobListGrid"
            , colModel: [
		   		{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'번호',width:50,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
		   		,{formatter:gridCellNoneFormatter,field:'SCHED_TABLE',id:'SCHED_TABLE',name:'테이블',width:120,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
		   		,{formatter:gridCellNoneFormatter,field:'APPLICATION',id:'APPLICATION',name:'어플리케이션',width:120,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
		   		,{formatter:gridCellNoneFormatter,field:'GROUP_NAME',id:'GROUP_NAME',name:'그룹',width:120,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
		   		,{formatter:gridCellNoneFormatter,field:'JOB_NAME',id:'JOB_NAME',name:'작업명',width:200,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
                ,{formatter:gridCellNoneFormatter,field:'WHEN_COND',id:'WHEN_COND',name:'임계시간옵션',width:250,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
                ,{formatter:gridCellNoneFormatter,field:'SHOUT_TIME',id:'SHOUT_TIME',name:'임계시간',width:200,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
				,{formatter:gridCellNoneFormatter,field:'DESCRIPTION',id:'DESCRIPTION',name:'작업설명',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
            ]
            , rows: []
            , vscroll: true
        };

        viewGridChk_1(gridObj, "ly_" + gridObj.id);

        $("#defJobExceptMapperForm").find("select[name='job_search_data_center']").val(session_dc_code);

        if (session_dc_code != "") {
        	$("#defJobExceptMapperForm").find("select[name='job_search_data_center']").val(session_dc_code);
        } else {
        	$("#defJobExceptMapperForm").find("select[name='job_search_data_center'] option:eq(1)").prop("selected", true);
        }
        
        defJobExceptMapper();

        $("#btn_job_search").button().unbind("click").click(function () {
            var data_center = $("#defJobExceptMapperForm").find("select[name='job_search_data_center'] option:selected").val();
            if (data_center == "") {
                alert("C-M 을 선택해 주세요.");
                return;
            }
            $("#defJobExceptMapperForm").find("#job_data_center").val(data_center); //job_data_center에 값 입력(insert에 필요)

            defJobExceptMapper();
        });

        $('#p_job_name').unbind('keypress').keypress(function (e) {
            if (e.keyCode == 13) {
                var data_center = $("#defJobExceptMapperForm").find("select[name='job_search_data_center'] option:selected").val();
                if (data_center == "") {
                    alert("C-M 을 선택해 주세요.");
                    return;
                }
                $("#defJobExceptMapperForm").find("#job_data_center").val(data_center); //job_data_center에 값 입력(insert에 필요)

                defJobExceptMapper();
            }
        });

        $("#btn_job_insert").button().unbind("click").click(function () {
            var selectedRows = $('#' + gridObj.id).data('grid').getSelectedRows();
            var rowsLength = selectedRows.length;
            if (rowsLength == 0) {
                alert("이관할 작업을 선택해주세요.");
                return;
            }

            var jobNames = "";
            var descriptions = "";

            var late_subs       = "";
            var late_times      = "";
            var late_execs      = "";
            var success_sms_yns  = "";

            for (var i = 0; i < rowsLength; i++) {

                var validConditions = ['', 'EXECTIME', 'LATETIME', 'LATESUB', 'OK'];
                var checkConditions = "";
                var whenCond = getCellValue(gridObj, selectedRows[i], 'WHEN_COND').split(",");
                var shoutTime = getCellValue(gridObj, selectedRows[i], 'SHOUT_TIME').split(",");

                for (var j = 0; j < whenCond.length; j++) {
                    if (!validConditions.includes(whenCond[j])) {
                        alert(whenCond[j] + "는(은) EZJOBS에서 지원하지않아 해당 작업은 이관 시 제외됩니다.");
                        continue;
                    }

                    if (checkConditions.indexOf(whenCond[j]) > -1 && whenCond[j] != '') {
                        alert("중복된 " + whenCond[j] + "은 EZJOBS에서 지원하지않아 해당 작업은 이관 시 제외됩니다.");
                        continue;
                    } else {
                        checkConditions += whenCond[j] + ",";
                    }

                    if(whenCond[j] == 'OK'){
                        shoutTime[j] = "Y"
                    }

                    if (shoutTime[j].includes('*') || shoutTime[j].includes('<') || shoutTime[j].includes('#')) {
                        alert(shoutTime[j] + "는(은) EZJOBS에서 지원하지않아 해당 작업은 이관 시 제외됩니다.");
                        continue;
                    }

                    if (whenCond[j] == 'LATESUB') {
                        late_subs += shoutTime[j];
                    } else if (whenCond[j] == 'LATETIME') {
                        late_times += shoutTime[j];
                    } else if (whenCond[j] == 'EXECTIME') {
                        late_execs += shoutTime[j];
                    } else if(whenCond[j] == 'OK'){
                        success_sms_yns += shoutTime[j];
                    }
                }


                jobNames += getCellValue(gridObj, selectedRows[i], 'JOB_NAME');
                descriptions += getCellValue(gridObj, selectedRows[i], 'DESCRIPTION');

                if (i < rowsLength - 1) {
                    jobNames += ",";
                    descriptions += ",";
                    late_subs += ",";
                    late_times += ",";
                    late_execs += ",";
                    success_sms_yns += ",";
                }
            }

            var data_center = $("select[name='job_search_data_center']").val();

            cmJobMapperInserts(jobNames, descriptions, data_center, late_subs, late_times, late_execs, success_sms_yns)
            //cmJobMapperInsert(jobNames, descriptions, data_center, whenCond, shoutTime);
        });
    }

    //수행서버내역 가져오기 - 폴더에 권한 매핑(22.08.01 김은희)
    function mHostList(data_center, grp_nm) {

		try{viewProgBar(true);}catch(e){}

        var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=mHostList&itemGubun=2&data_center=' + data_center + '&grp_nm=' + grp_nm;

        var xhr = new XHRHandler(url, null
            , function () {
                var xmlDoc = this.req.responseXML;
                if (xmlDoc == null) {
						try{viewProgBar(false);}catch(e){}
                    alert('세션이 만료되었습니다 다시 로그인해 주세요');
                    return false;
                }
                if ($(xmlDoc).find('doc').length == 0 && $(xmlDoc).find('error').length > 0) {
						try{viewProgBar(false);}catch(e){}
                    alert($(xmlDoc).find('msg_code').text());
                    //goCommonError('<%=sContextPath %>','_self',$(xmlDoc).find('msg_code').text());
                    return false;
                }
                $(xmlDoc).find('doc').each(function () {

                    var items = $(this).find('items');
                    var rowsObj = new Array();

                    if (items.attr('cnt') == '0') {
                        $("select[name='node_id'] option").remove();
                        $("select[name='node_id']").append("<option value=''>--선택--</option>");
                    } else {
                        $("select[name='node_id'] option").remove();
                        $("select[name='node_id']").append("<option value=''>--선택--</option>");

                        items.find('item').each(function (i) {

                            var host_cd = $(this).find("HOST_CD").text();
                            var node_id = $(this).find("NODE_ID").text();
                            var node_nm = $(this).find("NODE_NM").text();

                            var all_cd = host_cd + "," + node_id;
                            var all_nm = node_nm + "(" + node_id + ")";

                            $("select[name='node_id']").append("<option value='" + all_cd + "'>" + all_nm + "</option>");

                        });
                    }

                });
					try{viewProgBar(false);}catch(e){}
            }
            , null);

        xhr.sendRequest();
    }

    function defJobExceptMapper() {
		try{viewProgBar(true);}catch(e){}
        $('#ly_jobList_total_cnt').html('');

        var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=defJobExceptMapper&itemGubun=2';

        var xhr = new XHRHandler(url, defJobExceptMapperForm, function () {
                var xmlDoc = this.req.responseXML;
                if (xmlDoc == null) {
				try{viewProgBar(false);}catch(e){}
                    alert('세션이 만료되었습니다 다시 로그인해 주세요');
                    return false;
                }

                if ($(xmlDoc).find('doc').length == 0 && $(xmlDoc).find('error').length > 0) {
				try{viewProgBar(false);}catch(e){}
                    alert($(xmlDoc).find('msg_code').text());
                    return false;
                }

                $(xmlDoc).find('doc').each(function () {
                    var items = $(this).find('items');
                    var rowObj = new Array();

                    if (items.attr('cnt') == '0') {
                    } else {
                        items.find('item').each(function (i) {
                            var sched_table = $(this).find("sched_table").text();
                            var application = $(this).find("application").text();
                            var group_name = $(this).find("group_name").text();
                            var job_name = $(this).find("job_name").text();
                            var description = $(this).find("description").text();
                            var when_cond       = $(this).find("when_cond").text();
                            var shout_time      = $(this).find("shout_time").text();

                            rowObj.push({
                                'grid_idx': i + 1
                                , 'SCHED_TABLE': sched_table
                                , 'APPLICATION': application
                                , 'GROUP_NAME': group_name
                                , 'JOB_NAME': job_name
                                , 'DESCRIPTION': description
                                , 'WHEN_COND'   : when_cond
                                , 'SHOUT_TIME'  : shout_time
                            });
                        });
                    }

                    var obj = $("#jobListGrid").data('gridObj');
                    obj.rows = rowObj;
                    setGridRows(obj);

                    $('#ly_jobList_total_cnt').html('[ TOTAL : ' + items.attr('cnt') + ' ]');
                });
			try{viewProgBar(false);}catch(e){}
            }
            , null);

        xhr.sendRequest();
    }

    function excel_form_down() {
        var frm = document.f_s;
        frm.flag.value = "user_change";
        frm.action = "<%=sContextPath %>/mEm.ez?c=ez003_excel_doc";
        frm.target = "if1";
        frm.submit();
    }

    function load_excel() {
        var file = $("#frm8 #file_data").val();
        var content = $("#frm8 #content").val();

        if (file == '') {
            alert("첨부 파일을 입력하세요");
            return;
        }

        if (file.indexOf('.xls') == -1) {
            alert('xls형식만 업로드할 수 있습니다.');
            return;
        }

        var data_center = $("#frm8 #data_center").val();
        if (data_center == '') {
            alert('C-M 을 선택 해주세요');
            return;
        }

        var formData = new FormData();
        formData.append("c", "excelUpload");
        formData.append("random", Math.random());
        formData.append("files", $("#frm8 input[name=files]")[0].files[0]);
		try{viewProgBar(true);}catch(e){}

        $.ajax({
            url: "<%=sContextPath %>/tWorks.ez",
            type: "post",
            processData: false,
            contentType: false,
            dataType: "text",
            data: formData,
            cache: false,
            success: completeHandler = function (data) {

                var file_nm = data;
                if (file_nm != "") {

                    $("#if2").show();

                    var frm = document.frm8;
                    frm.c.value = "userChangeExcelLoad";
                    frm.file_nm.value = file_nm;

                    frm.target = "if2";
                    frm.action = "<%=sContextPath%>/tWorks.ez";
                    frm.submit();
                }
            },
            error: function (data2) {
                alert("error:::" + JSON.stringify(data2));
            },
            complete: function () {
				try{viewProgBar(false);}catch(e){}		
            }
        });
    }


    function popupExcelCode() {
        var session_dc_code = "<%=strSessionDcCode%>";

        var sHtml1 = "<div id='dl_tmp2' style='overflow:hidden;display:none;padding:0;border-top:1px solid blue;border-bottom:1px solid blue;border-left:1px solid blue;border-right:1px solid blue;'>";

        sHtml1 += "<form id='frm8' name='frm8' method='post' onsubmit='return false; enctype='multipart/form-data' >";
        sHtml1 += "<input type='hidden' name='c' id='c' />";
        sHtml1 += "<input type='hidden' name='file_nm' id='file_nm' />";
        sHtml1 += "<input type='hidden' id='doc_gb' 		name='doc_gb' 		value='05' />";
        sHtml1 += "<input type='hidden' id='flag'			name='flag' 		value='' />";
        sHtml1 += "<input type='hidden' id='user_cd'		name='user_cd' />";
        sHtml1 += "<input type='hidden' id='days_cal'		name='days_cal' />";
        sHtml1 += "<input type='hidden' id='grp_depth'    name='grp_depth'     value=''/>"
        sHtml1 += "<input type='hidden' id='data_center'  name='data_center'   value=''/>"
// 		sHtml1+="<input type='hidden' name='scode_cd' id='scode_cd' value='"+scode_cd+"' />";
        sHtml1 += "<table style='width:99%;height:99%;border:none;'>";
        sHtml1 += "<tr style='height:10px;'>";
        sHtml1 += "<td style='vertical-align:top;'>";
        sHtml1 += "<h4 class='ui-widget-header ui-corner-all'  >";
        sHtml1 += "<div id='t_<%=gridId %>' class='title_area'>";
        sHtml1 += "<span><%=CommonUtil.isNull(arr_menu_gb[0]) %></span>";
        sHtml1 += "</div>";
        sHtml1 += "</h4>";
        sHtml1 += "</td>";
        sHtml1 += "</tr>";
        sHtml1 += "<tr>";
        sHtml1 += "<td id='ly_<%=gridId %>' style='vertical-align:top;'>";
        sHtml1 += "<div id='<%=gridId %>' class='ui-widget-header_kang ui-corner-all'>";
        sHtml1 += "<table style='width:100%'>";
        sHtml1 += "<tr>";
        sHtml1 += "<td valign='top'>";
        sHtml1 += "<table style='width:100%;'>";
        sHtml1 += "<tr>";
        sHtml1 += "<td width='120px'></td>";
        sHtml1 += "<td width='250px'></td>";
        sHtml1 += "<td width='120px'></td>";
        sHtml1 += "<td width='200px'></td>";
        sHtml1 += "<td width='120px'></td>";
        sHtml1 += "<td width=''></td>";
        sHtml1 += "</tr>";
        sHtml1 += "<tr>";
        sHtml1 += "</tr>";
        sHtml1 += "</table>";
        sHtml1 += "</td>";
        sHtml1 += "</tr>";
        sHtml1 += "</table>";
        sHtml1 += "<table style='width:100%''>";
        sHtml1 += "<tr>";
        sHtml1 += "<td>";
        sHtml1 += "<div class='cellTitle_kang'>작업 정보</div>";
        sHtml1 += "</td>";
        sHtml1 += "</tr>";

        sHtml1 += "<tr>";
        sHtml1 += "<td valign='top'>";
        sHtml1 += "<table style='width:100%;''>";

        sHtml1 += "<tr>";
        sHtml1 += "<td width='120px'></td>";
        sHtml1 += "<td width='250px'></td>";
        sHtml1 += "<td width='120px'></td>";
        sHtml1 += "<td width='200px'></td>";
        sHtml1 += "<td width='120px'></td>";
        sHtml1 += "<td width=''></td>";
        sHtml1 += "</tr>";

        sHtml1 += "<tr>";
        sHtml1 += "<th>";
        sHtml1 += "<div class='cellTitle_kang2'><font color='red'>* </font>첨부파일</div>";
        sHtml1 += "</th>";
        sHtml1 += "<td colspan='5'>";
        sHtml1 += "<div class='cellContent_kang'>";
        sHtml1 += "<div class='filebox'>";
        sHtml1 += "<input type='text' name='file_data' id='file_data' style='width:40%; height:21px;' readOnly />";
        sHtml1 += "<label for='files' style='height:21px;border:1px solid;margin-left:4px;margin-bottom:4px;'>&nbsp;&nbsp;파일선택&nbsp;</label>";
        sHtml1 += "<input type='file' name='files' id='files' />";
        sHtml1 += "<label for='excel_load1' style='height:21px;border:1px solid;margin-left:4px;margin-bottom:4px;' onClick='load_excel()'>&nbsp;&nbsp;엑셀로드&nbsp;</label>";
        sHtml1 += "<input type='hidden' name='excel_load1' id='excel_load1'>";
        sHtml1 += "<label for='excel_form' style='height:21px;border:1px solid;margin-left:4px;margin-bottom:4px;' onClick='excel_form_down()'>&nbsp;&nbsp;양식다운&nbsp;</label>";
        sHtml1 += "<font color='red'>";
        sHtml1 += "※엑셀내용에 ' 를 넣으실 수 없습니다.";
        sHtml1 += "</font>";
        sHtml1 += "</div>";
        sHtml1 += "</div>";
        sHtml1 += "</td>"
        sHtml1 += "</tr>";

        sHtml1 += "<tr>";
        sHtml1 += "<th> <div class='cellTitle_kang2'>C-M</div> </th>";
        sHtml1 += "<td colspan='5'>";
        sHtml1 += "<select id='data_center_items' name='data_center_items' style='width:150px; height:21px;'>"
        sHtml1 += "<option value=''>선택</option>";
        sHtml1 += "<c:forEach var='cm' items='${cm}' varStatus='status'>";
        sHtml1 += "<option value='${cm.scode_cd},${cm.scode_eng_nm}'>${cm.scode_nm}</option>";
        sHtml1 += "</c:forEach>";
        sHtml1 += "</select>"
        sHtml1 += "</td>";
        sHtml1 += "</tr>";

        sHtml1 += "</table>";
        sHtml1 += "</td>";
        sHtml1 += "</tr>";
        sHtml1 += "</table>";
        sHtml1 += "</div>";
        sHtml1 += "</td>";
        sHtml1 += "</tr>";
        sHtml1 += "<tr>";
        sHtml1 += "<td style='height:100%;'>";
        sHtml1 += "<iframe name='if2' id='if2' style='width:100%;height:520px;' scrolling='no' frameborder='0'></iframe>";
        sHtml1 += "</td>";
        sHtml1 += "</tr>";
        sHtml1 += "</table>";
        sHtml1 += "</form>";

        $('#dl_tmp2').remove();
        $('body').append(sHtml1);

        dlPop01('dl_tmp2', "엑셀일괄", 1200, 700, false);

        if (session_dc_code != "") {
            $("select[name='data_center_items']").val(session_dc_code);
            $("#frm8").find("input[name='data_center']").val(session_dc_code);
        } else {
            $("#frm8 #data_center_items option:eq(1)").prop("selected", true);
            $("#frm8").find("input[name='data_center']").val($("select[name='data_center_items']").val());
        }


        $("#frm8 #title").focus();

        $("#if2").hide();


        $("#frm8 #files").change(function () {
            $("#frm8 #file_data").val($(this).val());
        });

        $("#frm8 #data_center_items").change(function () {
            $("#frm8 #data_center").val($("#frm8 select[name='data_center_items'] option:selected").val());

        });

    }

    function cmJobMapperInserts(jobNames, descriptions, data_center, late_subs, late_times, late_execs, success_sms_yns){

    	if(confirm('작업을 이관하시겠습니까?'))

    	 var frm = document.cmJobMapperInsertForm;

    	 if(data_center == undefined) {
   		 	frm.job_data_center.value = $("select[name='data_center_items']").val();
   		 	frm.action_gubun.value = "";
   		}else{
   			frm.job_data_center.value = data_center;
   			frm.action_gubun.value = "popup";
   		}

         frm.job_insert_arr.value = jobNames;
         frm.desc_insert_arr.value = descriptions;
         frm.late_subs.value = late_subs;
         frm.late_times.value = late_times;
         frm.late_execs.value = late_execs;
         frm.success_sms_yns.value = success_sms_yns;

         frm.action = '/tWorks.ez?c=ez012_popup_p';
         frm.target = 'if1';
         frm.submit();

    }

    function cmJobMapperInsert(jobNames, descriptions, data_center, when_cond, shout_time){

        if(confirm('작업을 이관하시겠습니까?'))

        var frm = document.cmJobMapperInsertForm;

        if(data_center == undefined || data_center == '') {
            frm.job_data_center.value = $("select[name='data_center_items']").val();
            frm.action_gubun.value = "";
        }else{
            frm.job_data_center.value = data_center;
            frm.action_gubun.value = "popup";
        }

        var validConditions = ['', 'EXECTIME', 'LATETIME', 'LATESUB', 'OK'];
        var checkConditions = "";
        var late_subs       = "";
        var late_times      = "";
        var late_execs      = "";
        var success_sms_yns  = "";

        var whenCond = when_cond.split(",");
        var shoutTime = shout_time.split(",");

        for (var j = 0; j < whenCond.length; j++) {
            if (!validConditions.includes(whenCond[j])) {
                alert(whenCond[j] + "는(은) EZJOBS에서 지원하지않아 해당 작업은 이관 시 제외됩니다.");
                continue;
            }

            if (checkConditions.indexOf(whenCond[j]) > -1 && whenCond[j] != '') {
                alert("중복된 " + whenCond[j] + "은 EZJOBS에서 지원하지않아 해당 작업은 이관 시 제외됩니다.");
                continue;
            } else {
                checkConditions += whenCond[j] + ",";
            }

            if(whenCond[j] == 'OK'){
                shoutTime[j] = "Y"
            }
            if (shoutTime[j].includes('*') || shoutTime[j].includes('<') || shoutTime[j].includes('#')) {
                alert(shoutTime[j] + "는(은) EZJOBS에서 지원하지않아 해당 작업은 이관 시 제외됩니다");
                continue;
            }

            if (whenCond[j] == 'LATESUB') {
                late_subs += shoutTime[j];
            } else if (whenCond[j] == 'LATETIME') {
                late_times += shoutTime[j];
            } else if (whenCond[j] == 'EXECTIME') {
                late_execs += shoutTime[j];
            } else if(whenCond[j] == 'OK'){
                success_sms_yns += shoutTime[j];
            }
        }

        frm.job_insert_arr.value = jobNames;
        frm.desc_insert_arr.value = descriptions;
        frm.late_subs.value = late_subs;
        frm.late_times.value = late_times;
        frm.late_execs.value = late_execs;
        frm.success_sms_yns.value = success_sms_yns;

        frm.action = '/tWorks.ez?c=ez012_popup_p';
        frm.target = 'if1';
        frm.submit();

    }
    
    function docApprovalStateView(doc_cd) {

		top.closeTab('tabs-0399');
		top.addTab('c', '요청문서함', '04', '0399', 'tWorks.ez?c=ez004&menu_gb=0399&doc_gb=99&itemGb=approvalStateInfo&search_gb=01&search_text='+doc_cd);
	}
</script>
