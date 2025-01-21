<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/jsp/common/inc/header.jsp"%>
<%@ page import="com.ghayoun.ezjobs.t.domain.*" %>

<%
	Map<String, Object> paramMap = CommonUtil.collectParameters(request);
	
	String c = CommonUtil.isNull(paramMap.get("c"));
	String gridId = "g_"+c;	
	
	String menu_gb = CommonUtil.getMessage("CATEGORY.GB.06.GB.0619");
	String[] arr_menu_gb = menu_gb.split(",");
	
	String strSessionDcCode 	= S_D_C_CODE;
	
	ConfirmBean confirmBean	= (ConfirmBean)request.getAttribute("ConfirmBean");
	
	String strServerGb 			= CommonUtil.isNull(CommonUtil.getMessage("SERVER_GUBUN"));
	String strDataCenter = CommonUtil.isNull(paramMap.get("data_center"));
	String strDataCenterCode = CommonUtil.isNull(paramMap.get("data_center_code"));
	String strCmSchema 		= CommonUtil.isNull(CommonUtil.getMessage("CM_SCHEMA"));
	System.out.println("strCmSchema : " + strCmSchema);
	String aTmp[] = strCmSchema.split("[|]");
	for(int p=0; p<aTmp.length; p++) {
		String aTmp1[] = aTmp[p].split(",");
		String cm_schema_code = aTmp1[0];
		String cm_schema = aTmp1[1];
		
		if(strDataCenterCode.equals(cm_schema_code)) {
			paramMap.put("ctmuser", cm_schema);
		}
	}
	
%>

<form id="f_s" name="f_s" method="post" onsubmit="return false;">	
	<input type="hidden" name="flag"				id="flag" />
	
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
				<h4 class="ui-widget-header ui-corner-all">
					<table style='width:100%;'>
						<tr>
							<th width='10%'><div class='cellTitle_kang2'>C-M</div></th>
							<td width='35%'>
								<div class='cellContent_kang'>
									<select id="data_center_items" name="data_center_items" style="width:120px; height:21px;">
										<option value="">--선택--</option>
										<c:forEach var="cm" items="${cm}" varStatus="status">
											<option value="${cm.scode_cd},${cm.scode_eng_nm}">${cm.scode_nm}</option>
										</c:forEach> 
									</select>
								</div>
							</td>
							<td style="text-align:right">
								<span id="btn_search" style='display:none;'>검색</span>
							</td>
						</tr>
						<tr>
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
</table>

<form id="frm4" name="frm4" method="post" action="" onsubmit="return false;">
	<input type="hidden" name="qresname"  />
	<input type="hidden" name="ctmuser"  value=""/>
	<input type="hidden" name="data_center"  value="<%=CommonUtil.isNull(paramMap.get("data_center")) %>"/>
</form>

<script>
	
	var gridObj = {
			id : "<%=gridId %>"
			,colModel:[
			{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'번호',width:50,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
			,{formatter:gridCellNoneFormatter,field:'QRSNAME',id:'QRSNAME',name:'리소스명',width:100,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
			,{formatter:gridCellNoneFormatter,field:'TOTAL',id:'TOTAL',name:'TOTAL',width:100,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
			,{formatter:gridCellNoneFormatter,field:'USED',id:'USED',name:'USED',width:80,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}

			,{formatter:gridCellNoneFormatter,field:'USER_GB',id:'USER_GB',name:'USER_GB',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
			,{formatter:gridCellNoneFormatter,field:'NO_AUTH',id:'NO_AUTH',name:'NO_AUTH',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
		]
		,rows:[]
		,vscroll: <%=S_GRID_VSCROLL%>
	};

	$(document).ready(function(){
		
		
		
		$("#btn_search").show();
		
		var session_dc_code	= "<%=strSessionDcCode%>";
		
		if(session_dc_code != "") { // 개인정보에 C-M이 등록되어 있을경우
			$("select[name='data_center_items']").val(session_dc_code);
			$("#f_s").find("input[name='data_center']").val(session_dc_code);
		}else { // 개인정보에 C-M이 등록이 되어있지 않을경우 -> C-M 콤보박스에서 첫번째값 선택
			$("#data_center_items option:eq(1)").prop("selected", true);
			$("#f_s").find("input[name='data_center']").val($("select[name='data_center_items']").val());
		}
		
		var data_center_items = $("select[name='data_center_items'] option:selected").val();
		var arr_dt = data_center_items.split(",");
		var ctm_schema = '';
		ctm_schema = arr_dt[1];    
		
		viewGrid_1(gridObj,'ly_'+gridObj.id,{enableColumnReorder:true},'AUTO');

		$("#btn_search").button().unbind("click").click(function(){
			
			data_center_items = $("select[name='data_center_items'] option:selected").val();
			arr_dt = data_center_items.split(",");
			
			ctm_schema = arr_dt[1]; 
			
			//$("#f_s").find("input[name='data_center']").val(arr_dt[1]);
			$("#f_s").find("input[name='data_center']").val(data_center_items);
						
			getResourceList(ctm_schema);  
		}); 
		
		setTimeout(function(){ 
			getResourceList(ctm_schema);
		}, 1000);   
		     
	});
	
	function popupUsedJobList(qresname, ctm_schema){
		
		var frm = document.frm4;
		frm.qresname.value = qresname;
		frm.ctmuser.value = ctm_schema;
		
		var server_gubun = '<%=strServerGb%>';
		var data_center = frm.data_center.value;
		
		openPopupCenter1("about:blank","popupUsedJobList",700,600);  
		
		frm.action = "<%=sContextPath %>/mPopup.ez?c=popupUsedJobList";
		frm.target = "popupUsedJobList";
		frm.submit();
	}
	
	function getResourceList(ctm_schema){
		
		try{viewProgBar(true);}catch(e){}
		
		$('#ly_total_cnt').html('');

		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=resourceList&ctmuser='+ctm_schema;  

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

								var qrsname 			= $(this).find("QRSNAME").text(); 
								var total 				= $(this).find("TOTAL").text();
								var used 				= $(this).find("USED").text();
									
								rowsObj.push({
									'grid_idx':i+1
									,'QRSNAME'	: qrsname
									,'TOTAL'	: total
									,'USED'		: "<span onclick=popupUsedJobList('"+qrsname+"','"+ctm_schema+"'); style=cursor:pointer;>"+used+"</span>"                
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
	
	
</script>

