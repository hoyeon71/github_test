<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/jsp/common/inc/header.jsp"%>
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
<link href="<%=request.getContextPath() %>/css/slick-default-theme.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath() %>/js/poshytip-1.2/tip.css" rel="stylesheet" type="text/css" />

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
<script type="text/javascript" src="<%=request.getContextPath() %>/js/SlickGrid-2.1.0/plugins/slick.checkboxselectcolumn2.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/SlickGrid-2.1.0/plugins/slick.rowselectionmodel.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/SlickGrid-2.1.0/slick.dataview.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/SlickGrid-2.1.0/slick.grid.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/SlickGrid-2.1.0/slick.editors.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/poshytip-1.2/jquery.poshytip.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/works_common.js?v=<%=jsVersion %>" ></script>
</head>
<%
	Map<String, Object> paramMap 	= CommonUtil.collectParameters(request);
	String c = CommonUtil.isNull(paramMap.get("c"));
	String gridId_4 = "g_"+c+"_4";
	
	JobDefineInfoBean docBean	= (JobDefineInfoBean)request.getAttribute("aJobInfo");
	String strPageGubun			= (String)request.getAttribute("page_gubun");
	String strDataCenter 		= CommonUtil.isNull(paramMap.get("data_center"));
	String strJobName	 		= CommonUtil.isNull(paramMap.get("job_name"));
	String strServerGb 			= CommonUtil.isNull(CommonUtil.getMessage("SERVER_GB"));
	
	// 세션값 가져오기.
	String strSessionUserGb		= S_USER_GB;

	//최대 대기일 기본값
	String strDefaultMaxWait	= "7";
%>

<body>
<!-- 버전비교 -->
<form id="f_s" name="f_s" method="post" onsubmit="return false;">	
	<input type="hidden" name="data_center" id="data_center" value="<%=strDataCenter %>"/>
	<input type="hidden" name="job_name" 	id="job_name" 	 value="<%=strJobName %>" />
	<input type="hidden" name="doc_cd" 		id="doc_cd" 	/>
	<input type="hidden" name="doc_cd_old" 	id="doc_cd_old" />
	<input type="hidden" name="doc_gb" 		id="doc_gb" 	/>
	<input type="hidden" name="doc_gb_old" 	id="doc_gb_old" />
</form>
<form id='frm1' name='frm1' method='post' onsubmit='return false;'>
	<input type="hidden" name="data_center" 	value="<%=strDataCenter%>" />
	<input type="hidden" name="job_name"	 	value="<%=strJobName%>" />
<table style='width:98%;height:98%;border:none;padding-left:15px;'>
	<tr style='height:10px;'>
		<td style='vertical-align:top;'>
			<h4 class="ui-widget-header ui-corner-all">
				<div class='title_area' style="width:100%; text-align:left;">
					<span>작업명 : <%=strJobName%></span>
				</div>				
			</h4>
		</td>
	</tr>
	<tr valign="top">
		<h4 class="ui-widget-header ui-corner-all">
			<tr>
				<td colspan="4" valign="top">
					<tr>
						<td id='ly_<%=gridId_4 %>' style='vertical-align:top;width:49%;height:630px;'>
							<div id="<%=gridId_4 %>" class="ui-widget-header ui-corner-all"></div>
						</td>
					</tr>
				</td>
			</tr>					
		</h4>
	</tr>
	<tr valign="top">
		<td style="text-align:right;padding-top:3px;">
			<span id='btn_compare'>문서비교</span>
			<span id="btn_close">닫기</span>
		</td>
	</tr>
</table>
</form>

<%@include file="/jsp/common/inc/progBar.jsp"  %>
</body>

<script>

	function gridCellCustomFormatter(row, cell, value, columnDef, dataContext) {
	    var ret = "";
	    var doc_cd = getCellValue(gridObj, row, 'DOC_CD');
	
	    if (columnDef.id == 'DOC_CD') {
	        ret = "<a href=\"JavaScript:goMyDocInfoList('" + doc_cd + "');\" /><font color='black'><b>" + value + "</b></font></a>";
	    }
	
	    return ret;
	}

	var gridObj = {
		id : "<%=gridId_4 %>"
		,colModel:[
			{formatter:gridCellNoneFormatter,field:'DATA_CENTER_NAME',id:'DATA_CENTER_NAME',name:' C-M',width:100,headerCssClass:'cellCenter',cssClass:'cellCenter',editor:null}
			,{formatter:gridCellCustomFormatter,field:'DOC_CD',id:'DOC_CD',name:'문서번호',width:150,headerCssClass:'cellCenter',cssClass:'cellCenter',editor:null}
			,{formatter:gridCellNoneFormatter,field:'TASK_NM',id:'TASK_NM',name:'문서구분',width:100,headerCssClass:'cellCenter',cssClass:'cellCenter',editor:null}
	   		,{formatter:gridCellNoneFormatter,field:'JOB_NAME',id:'JOB_NAME',name:'작업명',width:180,headerCssClass:'cellCenter',cssClass:'cellCenter',editor:null}
	   		,{formatter:gridCellNoneFormatter,field:'TITLE',id:'TITLE',name:'의뢰사유',width:300,headerCssClass:'cellCenter',cssClass:'cellCenter',editor:null}
	   		,{formatter:gridCellNoneFormatter,field:'APPLY_DATE',id:'APPLY_DATE',name:'반영일',width:170,headerCssClass:'cellCenter',cssClass:'cellCenter',editor:null}
	   	]
		,rows:[]
		,vscroll:false
	};

	$(document).ready(function(){

		window.focus();

		$("#btn_close").button().unbind("click").click(function(){
			self.close();
		});
		
		$("#btn_compare").button().unbind("click").click(function(){
			popupDocVersionCompare();
		});	
		
		viewGrid_1(gridObj,"ly_"+gridObj.id);
		
		jobHistoryInfo();

	});
	
	function jobHistoryInfo(startRowNum){

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
		
		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=jobHistoryInfo';
		
		var xhr = new XHRHandler(url, frm1
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

								var task_nm		 		= $(this).find("TASK_NM").text();
								var task_nm_detail 		= $(this).find("TASK_NM_DETAIL").text();
								var doc_cd 				= $(this).find("DOC_CD").text();
								var doc_gb 				= $(this).find("DOC_GB").text();
								var title 				= $(this).find("TITLE").text();
								var job_name 			= $(this).find("JOB_NAME").text();
								var apply_date			= $(this).find("APPLY_DATE").text();
								var data_center 		= $(this).find("DATA_CENTER").text();
								var data_center_name 	= $(this).find("DATA_CENTER_NAME").text();
								
								rowsObj.push({
									'grid_idx':i+1+startRowNum
									,'TASK_NM': task_nm
									,'TASK_NM_DETAIL': task_nm_detail
									,'DOC_CD': doc_cd
									,'DOC_GB': doc_gb
									,'TITLE': title
									,'JOB_NAME': job_name
									,'APPLY_DATE': apply_date
									,'DATA_CENTER' : data_center
									,'DATA_CENTER_NAME' : data_center_name
								});
								
							});						
						}
						
						gridObj.rows = rowsObj;
						setGridRows(gridObj);
						
						//컬럼 자동 조정 기능
// 						$('body').resizeAllColumns();
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
	
	function goMyDocInfoList(doc_cd) {
        opener.parent.closeTabsAndAddTab('tabs-0399','c', '요청문서함', '01', '0399', 'tWorks.ez?c=ez004&search_text=' + doc_cd + '&search_gb=01&menu_gb=0399&doc_gb=99');
    }
	
	function popupDocVersionCompare() {
		var selected_rows = $('#' + gridObj.id).data('grid').getSelectedRows();
        var rows_length = selected_rows.length;
        
        if (rows_length != 2) {
            alert("비교할 문서를 선택해주세요. \n(2개의 등록&수정&일괄 요청서만 선택)");
            return;
        }
        
        var doc01 = getCellValue(gridObj, selected_rows[0], 'DOC_CD');
        var doc02 = getCellValue(gridObj, selected_rows[1], 'DOC_CD');
        
        // 최신 문서를 구분 짓기 위해 조건문 추가
        if(doc01 > doc02){
	        var doc_cd 				= getCellValue(gridObj, selected_rows[0], 'DOC_CD');
	        var doc_cd_old 			= getCellValue(gridObj, selected_rows[1], 'DOC_CD');
	        var doc_gb 				= getCellValue(gridObj, selected_rows[0], 'DOC_GB');
	        var doc_gb_old			= getCellValue(gridObj, selected_rows[1], 'DOC_GB');
	        var task_nm_detail 		= getCellValue(gridObj, selected_rows[0], 'TASK_NM_DETAIL'); //일괄요청과 일괄수시를 구분짓기 위한 파라미터
	        var task_nm_detail_old	= getCellValue(gridObj, selected_rows[1], 'TASK_NM_DETAIL'); //일괄요청과 일괄수시를 구분짓기 위한 파라미터
        }else{
        	var doc_cd 				= getCellValue(gridObj, selected_rows[1], 'DOC_CD');
	        var doc_cd_old 			= getCellValue(gridObj, selected_rows[0], 'DOC_CD');
	        var doc_gb 				= getCellValue(gridObj, selected_rows[1], 'DOC_GB');
	        var doc_gb_old			= getCellValue(gridObj, selected_rows[0], 'DOC_GB');
	        var task_nm_detail 		= getCellValue(gridObj, selected_rows[1], 'TASK_NM_DETAIL'); //일괄요청과 일괄수시를 구분짓기 위한 파라미터
	        var task_nm_detail_old	= getCellValue(gridObj, selected_rows[0], 'TASK_NM_DETAIL'); //일괄요청과 일괄수시를 구분짓기 위한 파라미터
        }
        
		if(doc_gb == '05' || doc_gb_old == '05' || doc_gb == '07' || doc_gb_old == '07' || doc_gb == '03' || doc_gb_old == '03' || task_nm_detail != '' || task_nm_detail_old != ''){
			alert("비교는 등록,수정에 관한 문서만 가능합니다.");
			return;
		}
		
		var frm = document.f_s;
	
		frm.doc_cd.value 		= doc_cd;
		frm.doc_cd_old.value 	= doc_cd_old;
		frm.doc_gb.value 		= doc_gb;
		frm.doc_gb_old.value 	= doc_gb_old;

		openPopupCenter("about:blank","popupDocCompareInfo",700,900);
		
		frm.action = "<%=sContextPath %>/mPopup.ez?c=docCompareInfo";
		frm.target = "popupDocCompareInfo";
		frm.submit();
	}

</script>
</html>