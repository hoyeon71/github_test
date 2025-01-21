<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/jsp/common/inc/header.jsp"%>

<%
	Map<String, Object> paramMap = CommonUtil.collectParameters(request);
	String c = CommonUtil.isNull(paramMap.get("c"));
	String gridId = "g_"+c;
		
	String menu_gb = CommonUtil.getMessage("CATEGORY.GB.06.GB."+CommonUtil.isNull(paramMap.get("menu_gb")));
	String[] arr_menu_gb = menu_gb.split(",");	
%>

<form id="f_s" name="f_s" method="post" onsubmit="return false;">
	<input type='hidden' id='p_data_center' name='p_data_center'/>
</form>
<form name="frm1" id="frm1" method="post" onsubmit="return false;">
	<input type="hidden" name="flag" id="flag" />
	<input type="hidden" name="nodeid" id="nodeid" />
	<input type="hidden" name="agent_nm" id="agent_nm" />
	<input type="hidden" name="agent_info" id="agent_info" />
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
			<form name="frm2" id="frm2" method="post">
			<h4 class="ui-widget-header ui-corner-all">
			<table style='width:100%;'>
				<tr>
					<th width="3%"><div class='cellTitle_kang2'>C-M</div></th>
					<td width="20%" style="text-align:left" colspan="5">
						<div class='cellContent_kang'>
						<select id="data_center_items" name="data_center_items" style="width:20%; height:21px;">
							<option value="">--선택--</option>
							<c:forEach var="cm" items="${DATA_CENTER}" varStatus="status">
								<option value="${cm.scode_cd},${cm.scode_eng_nm}">${cm.scode_nm}</option>
							</c:forEach>
						</select>
						</div>
					</td>
				</tr>
				<tr>				
					<td style="text-align:right" colspan="6">
						<!-- <span id="btn_search" style='display:none;'>검색</span> -->
						<img id="btn_search" src='<%=sContextPath%>/imgs/btn_SRC.gif' style='border:0;vertical-align:top;cursor:pointer;' />
					</td>		
				</tr>				
			</table>
			</h4>
			</form>
		</td>
	</tr>	
	<tr style="height:100%">
		<td id='ly_<%=gridId %>' style='vertical-align:top;'>
			<div id="<%=gridId %>" class="ui-widget-header ui-corner-all"></div>
		</td>
	</tr>	
	<tr style='height:10px;'>
		<td style='vertical-align:top;'>
			<h4 class="ui-widget-header ui-corner-all">
				<div align='right' class='btn_area'>
					<div id='ly_total_cnt' style='padding-top:5px;float:left;'></div>
				</div>
			</h4>
		</td>
	</tr>
</table>
<script>
	
	var gridObj = {
		id : "<%=gridId %>"
		,colModel:[
	   		{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'번호',width:50,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'NODEID',id:'NODEID',name:'AGENT명',width:140,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'AGENT_NM',id:'AGENT_NM',name:'AGENT한글명',width:150,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}	 
	   		,{formatter:gridCellNoneFormatter,field:'AGSTAT',id:'AGSTAT',name:'상태',width:70,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}	 
	   		,{formatter:gridCellNoneFormatter,field:'HOSTNAME',id:'HOSTNAME',name:'호스트명',width:120,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}	   		
	   		,{formatter:gridCellNoneFormatter,field:'VERSION',id:'VERSION',name:'버전',width:80,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}	   		
	   		,{formatter:gridCellNoneFormatter,field:'OS_NAME',id:'OS_NAME',name:'OS명',width:140,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'PLATFORM',id:'PLATFORM',name:'플랫폼',width:70,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
	   		,{formatter:gridCellNoneFormatter,field:'AGENT_INFO',id:'AGENT_INFO',name:'설명',width:200,headerCssClass:'cellCenter',cssClass:'cellLeft'}
	   		,{formatter:gridCellNoneFormatter,field:'PROC',id:'PROC',name:'처리',width:70,headerCssClass:'cellCenter',cssClass:'cellCenter'}
	   	]
		,rows:[]
		,vscroll:<%=S_GRID_VSCROLL%>
	};
		
	
	$(document).ready(function(){
				
		viewGrid_1(gridObj,"ly_"+gridObj.id);
		$("#f_s").find("input[name='p_data_center']").val($("select[name='data_center_items'] option:selected").val());
		//agentList();
		
		$("#btn_search").button().unbind("click").click(function(){
			var data_center_items = $("select[name='data_center_items'] option:selected").val();
			$("#f_s").find("input[name='p_data_center']").val($("select[name='data_center_items'] option:selected").val());
			if(data_center_items == ""){
				alert("C-M 을 선택해 주세요.");
				return;
			} 
			agentList();
		});
		
	});
		
	function agentList(){
	
		try{viewProgBar(true);}catch(e){}
		$('#ly_total_cnt').html('');
		
		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=ctmAgentList&itemGubun=2';
		
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
							
								var nodeid = $(this).find("NODEID").text();
								var agstat = $(this).find("AGSTAT").text();
								var hostname = $(this).find("HOSTNAME").text();
								var version = $(this).find("VERSION").text();
								var os_name = $(this).find("OS_NAME").text();
								var platform = $(this).find("PLATFORM").text();
								var agent_nm = $(this).find("AGENT_NM").text();
								var agent_info = $(this).find("AGENT_INFO").text();
								var v_agstat = "";
								if(agstat == "V"){
									v_agstat = "정상";
								}else if(agstat == "D"){
									v_agstat = "비정상";
								}else{
									v_agstat = "기타(정상X)";
								}
								
								var v_agent_nm = "<div><input type='text' name='agent_nm"+nodeid+"' id='agent_nm"+nodeid+"' value='"+agent_nm+"' style='width:100%;' /></div>";
								var v_agent_info = "<div><input type='text' name='agent_info"+nodeid+"' id='agent_info"+nodeid+"' value='"+agent_info+"' style='width:100%;' /></div>";
								var v_proc = "<div><a href=\"javascript:goAgentPrc('udt','"+nodeid+"');\"><font color='red'>[수정]</font></a></div>";
								
								rowsObj.push({
									'grid_idx':i+1
									,'NODEID': nodeid
									,'AGSTAT': v_agstat
									,'AGENT_NM': v_agent_nm
									,'HOSTNAME': hostname
									,'VERSION': version
									,'OS_NAME': os_name
									,'PLATFORM': platform
									,'AGENT_INFO': v_agent_info
									,'PROC': v_proc
								});
								
							});						
						}
						
						gridObj.rows = rowsObj;
						setGridRows(gridObj);
						$('#ly_total_cnt').html('[ TOTAL : '+items.attr('cnt')+' ]');
						
					});
					try{viewProgBar(false);}catch(e){}
				}
		, null );
		
		xhr.sendRequest();
	}
	
	function goAgentPrc(flag, nodeid){
		
		var f = document.frm1;
		
		f.flag.value = flag;
		f.nodeid.value = nodeid;
		f.agent_nm.value = $("input[name='agent_nm"+nodeid+"']").val();
		f.agent_info.value = $("input[name='agent_info"+nodeid+"']").val();
		f.target = "if1";
		f.action = "<%=sContextPath%>/common.ez?c=ezCtmAgent_p";
		f.submit();
		
	}
</script>
