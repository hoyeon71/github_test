<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/jsp/common/inc/header.jsp"%>

<%
	Map<String, Object> paramMap = CommonUtil.collectParameters(request);

	String c 		= CommonUtil.isNull(paramMap.get("c"));
	String gridId 	= "g_"+c;
	String gridId_1 = "g_"+c+"_1";
	String gridId_2 = "g_"+c+"_2";
	
	String menu_gb 			= CommonUtil.getMessage("CATEGORY.GB.08.GB.0802");
	String[] arr_menu_gb 	= menu_gb.split(",");
%>

<%-- <c:set var="approval_gb_cd" 	value="${fn:split(APPROVAL_GB_CD,',')}"/> --%>
<%-- <c:set var="" 	value="${fn:split(APPROVAL_GB_NM,',')}"/> --%>
<c:set var="approval_seq_cd" 	value="${fn:split(APPROVAL_ORDER_CD,',')}"/>

<form id="f_s" name="f_s" method="post" onsubmit="return false;">
</form>

<form name="frm1" id="frm1" method="post" onsubmit="return false;">
	<input type="hidden" name="flag" 		id="flag" />
	<input type="hidden" name="line_grp_cd" id="line_grp_cd" />
	<input type="hidden" name="line_grp_nm" id="line_grp_nm" />
	<input type="hidden" name="use_yn" 		id="use_yn" />
</form>

<table style='width:100%;height:100%;border:none;'>
	<tr style='height:10px;'>
		<td style='vertical-align:top;' colspan="2">
			<h4 class="ui-widget-header ui-corner-all"  >
				<div id='t_<%=gridId %>' class='title_area' >
					<span><%=CommonUtil.isNull(arr_menu_gb[0]) %></span>
				</div>
			</h4>
		</td>
	</tr>
	<tr>
		<td style='vertical-align:top; width:35%;'>
			<table style="width:100%;height:100%;">
				<tr>
					<td id='ly_<%=gridId_1 %>' style='vertical-align:top;' >
						<div id="<%=gridId_1 %>" class="ui-widget-header ui-corner-all"></div>
					</td>					
				</tr>
				<tr style='height:10px;'>
					<td style='vertical-align:top;'>
						<h4 class="ui-widget-header ui-corner-all" >
							<div align='right' class='btn_area' >								
								<span id="btn_add">저장</span>		
								<span id="btn_del">삭제</span>			
							</div>
						</h4>
					</td>
				</tr>
			</table>
		</td>
		<td style='vertical-align:top; width:64%;'>
			<table style="width:100%;height:100%;">
				<tr>					
					<td id='ly_<%=gridId_2 %>' style='vertical-align:top;' >
						<form name="frm2" id="frm2" method="post" onsubmit="return false;">
							<input type="hidden" name="flag" 			id="flag"/>
							<input type="hidden" name="line_cd" 		id="line_cd" />
							<input type="hidden" name="line_grp_cd" 	id="line_grp_cd" />
							<input type="hidden" name="approval_cd" 	id="approval_cd" />
							<input type="hidden" name="approval_seq" 	id="approval_seq" />
<!-- 							<input type="hidden" name="approval_gb" 	id="approval_gb" /> -->
							
							<div id="<%=gridId_2 %>" class="ui-widget-header ui-corner-all"></div>
						
						</form>
					</td>
				</tr>
				<tr style='height:10px;'>
					<td style='vertical-align:top;'>
						<h4 class="ui-widget-header ui-corner-all" >
							<div align='right' class='btn_area' >								
								<div id='ly_total_cnt' style='padding-top:5px;float:left;'></div>
								<span id="btn_group_udt">저장</span>		
							</div>
						</h4>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>

<script>

	var arr_approval_seq_cd 	= new Array();
// 	var arr_approval_gb_cd 		= new Array();
// 	var arr_approval_gb_nm 		= new Array();
	
	<c:forEach var="approval_seq_cd" items="${approval_seq_cd}" varStatus="s">
		var map_cd = {"cd":"${approval_seq_cd}"};
		arr_approval_seq_cd.push(map_cd);
	</c:forEach>
	
// 	<c:forEach var="approval_gb_cd" items="${approval_gb_cd}" varStatus="s">
// 		var map_cd = {"cd":"${approval_gb_cd}"};
// 		arr_approval_gb_cd.push(map_cd);
// 	</c:forEach>
// 	<c:forEach var="approval_gb_nm" items="${approval_gb_nm}" varStatus="s">
// 		var map_nm = {"nm":"${approval_gb_nm}"};
// 		arr_approval_gb_nm.push(map_nm);
// 	</c:forEach>

	function gridCellCustomFormatter(row,cell,value,columnDef,dataContext){
		
		var ret = "";
		var line_grp_cd = getCellValue(gridObj_1,row,'LINE_GRP_CD');		
		
		if(columnDef.id == 'SELECT'){
			if(row > 0){
				ret = "<a href=\"JavaScript:userApprovalLineList('"+line_grp_cd+"');\" /><font color='red'>"+value+"</font></a>";	
			}else{
				ret = value;
			}
		}
				
		return ret;
	}

	var gridObj_1 = {
		id : "<%=gridId_1 %>"
		,colModel:[ 
			{formatter:gridCellCustomFormatter,field:'SELECT',id:'SELECT',name:'',width:50,headerCssClass:'cellCenter',cssClass:'cellCenter'}
	   		//,{formatter:gridCellCustomFormatter,field:'LINE_GRP_NM',id:'LINE_GRP_NM',name:'결재그룹명',width:200,headerCssClass:'cellCenter',cssClass:'cellLeft'}
	   		,{formatter:gridCellNoneFormatter,field:'LINE_GRP_NM',id:'LINE_GRP_NM',name:'결재그룹명',width:160,headerCssClass:'cellCenter',cssClass:'cellLeft'}
	   		,{formatter:gridCellNoneFormatter,field:'USE_YN',id:'USE_YN',name:'사용구분',width:80,headerCssClass:'cellCenter',cssClass:'cellCenter'}
	   			   			   		
	   		,{formatter:gridCellNoneFormatter,field:'LINE_GRP_CD',id:'LINE_GRP_CD',name:'LINE_GRP_CD',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   		,{formatter:gridCellNoneFormatter,field:'OWNER_USER_CD',id:'OWNER_USER_CD',name:'OWNER_USER_CD',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   		,{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'grid_idx',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   	]
		,rows:[]
		,vscroll:<%=S_GRID_VSCROLL%>
	};
	
	var gridObj_2 = {
		id : "<%=gridId_2 %>"
		,colModel:[
	   		{formatter:gridCellNoneFormatter,field:'APPROVAL_SEQ',id:'APPROVAL_SEQ',name:'결재순서',width:60,headerCssClass:'cellCenter',cssClass:'cellCenter'}
	   		,{formatter:gridCellNoneFormatter,field:'APPROVAL_NM',id:'APPROVAL_NM',name:'결재자',width:400,headerCssClass:'cellCenter',cssClass:'cellLeft'}
// 	   		,{formatter:gridCellNoneFormatter,field:'APPROVAL_GB',id:'APPROVAL_GB',name:'결재자유형',width:130,headerCssClass:'cellCenter',cssClass:'cellLeft'}
	   		,{formatter:gridCellNoneFormatter,field:'PROC',id:'PROC',name:'처리',width:80,headerCssClass:'cellCenter',cssClass:'cellCenter'}
	   		
	   		,{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'grid_idx',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   		,{formatter:gridCellNoneFormatter,field:'LINE_CD',id:'LINE_CD',name:'LINE_CD',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   		,{formatter:gridCellNoneFormatter,field:'LINE_GRP_CD',id:'LINE_GRP_CD',name:'LINE_GRP_CD',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   		,{formatter:gridCellNoneFormatter,field:'APPROVAL_CD',id:'APPROVAL_CD',name:'APPROVAL_CD',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
			,{formatter:gridCellNoneFormatter,field:'USER_CD',id:'USER_CD',name:'USER_CD',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   	]
		,rows:[]
		,vscroll:<%=S_GRID_VSCROLL%>
	};
	
	$(document).ready(function(){
		
		$("#btn_add").button().unbind("click").click(function(){
		    
		    var strLineGrpCd    = "";
		    var strLineGrpNm    = "";
		    var strUseYn        = "";
		    var strUseYnCnt      = 0; 
		    
		    for(var i = 0; i < gridObj_1.rows.length; i++){
		        if( i == 0 ){
		            if($('input[id=line_grp_nm0]').val() != ""){
		                strLineGrpCd   += ",0";
		                strLineGrpNm   += "," + $('input[id=line_grp_nm0]').val();
		                var use_yn_val = $('select[id=use_yn0] option:selected').val();
		                strUseYn       += "," + use_yn_val;
		                if(use_yn_val == 'Y'){
		                    strUseYnCnt++;
		                }
		            }
		        }else {
		            var line_grp_cd = getCellValue(gridObj_1, i, "LINE_GRP_CD");
		            strLineGrpCd   += "," + line_grp_cd;
		            strLineGrpNm   += "," + $('input[id=line_grp_nm' + line_grp_cd +']').val();
		            var use_yn_val = $('select[id=use_yn' + line_grp_cd +'] option:selected').val();
		            strUseYn       += "," + use_yn_val;
		            if(use_yn_val == 'Y'){
		                strUseYnCnt++;
		            }
		        }
		    }
		    
		    strLineGrpCd    = strLineGrpCd.substr(1);
		    strLineGrpNm    = strLineGrpNm.substr(1);
		    strUseYn        = strUseYn.substr(1);
		    
		    if(gridObj_1.rows.length == 1 && $('input[id=line_grp_nm0]').val() == "") { // 등록된 결재그룹이 없을때
		        alert("결재그룹을 등록해주세요.");
		        return;
		    }
		    
		    if(strUseYnCnt >= 2){
		        alert("결재선 사용은 한개만 가능합니다.");
		        return;
		    }
		    
		    if( !confirm("처리하시겠습니까?") ) return;
		    
		    var frm = document.frm1;
		    frm1.flag.value        = "group_udt";
		    frm1.line_grp_cd.value = strLineGrpCd;
		    frm1.line_grp_nm.value = strLineGrpNm;
		    frm1.use_yn.value      = strUseYn;
		    frm1.target = "if1";
		    frm1.action = "<%=sContextPath%>/tWorks.ez?c=ezUserApprovalGroup_p";
		    frm1.submit();
		    
		});
		
		$("#btn_del").button().unbind("click").click(function(){
			
			var cnt = 0;
			var line_grp_cd = 0;
			
			var aSelRow = new Array;
			aSelRow = $('#'+gridObj_1.id).data('grid').getSelectedRows();
			if(aSelRow.length>0){
				for(var i=0;i<aSelRow.length;i++){					
					line_grp_cd = getCellValue(gridObj_1,aSelRow[i],"LINE_GRP_CD");
					++cnt;
				}				
			}
			
			if(line_grp_cd == '0' || line_grp_cd == ''){
				alert("삭제할 결재선을 선택해 주세요.");
				return;
			}
			
			if(cnt > 1){
				alert("한개의 항목만 선택해 주세요.");
				return;
			}
			
			if( !confirm("관련된 하위 데이터도 모두 삭제됩니다. 진행하시겠습니까?") ) return;
			
			var frm = document.frm1;
			frm1.flag.value = "del";
			frm1.line_grp_cd.value = line_grp_cd;		
			frm1.target = "if1";
			frm1.action = "<%=sContextPath%>/tWorks.ez?c=ezUserApprovalGroup_p";
			frm1.submit();
			
		});
		
		
		$("#btn_group_udt").button().unbind("click").click(function(){
			var flag = 'group_udt'
			var strLineCd 		= "";
			var strApprovalCd 	= "";
			var strApprovalSeq	= "";
			
			for(var i = 0; i < gridObj_2.rows.length; i++){
				if( i == 0 ){
					if($('input[id=approval_cd0]').val() != ""){
						strLineCd 	   += ",0";
						strApprovalCd  += "," + $('input[id=approval_cd0]').val();
						strApprovalSeq += "," + $('select[id=approval_seq0] option:selected').val();
					}
				}else {
					var line_cd = getCellValue(gridObj_2, i, "LINE_CD");
					strLineCd 	   += "," + line_cd;
					strApprovalCd  += "," + $('input[id=approval_cd' + line_cd +']').val();
					strApprovalSeq += "," + $('select[id=approval_seq' + line_cd +'] option:selected').val();
				}
			}
			
			strLineCd 		= strLineCd.substr(1);
			strApprovalCd 	= strApprovalCd.substr(1);
			strApprovalSeq 	= strApprovalSeq.substr(1);
			
			goProc2(flag, strLineCd, strApprovalCd, strApprovalSeq);
		});
		
		
		viewGrid_1(gridObj_1,"ly_"+gridObj_1.id);
		userApprovalGroupList();
		
		viewGrid_1(gridObj_2,"ly_"+gridObj_2.id);
	});
	
	function userApprovalGroupList(){
		
		$("#btn_group_udt").hide();
		
		try{viewProgBar(true);}catch(e){}
		$('#ly_total_cnt').html('');
		
		
		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=userApprovalGroup&itemGubun=2';
		
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
						
						//var cd = "<div><input type='hidden' name='line_grp_cd0' id='line_grp_cd0' value='0' style='width:100%;'/></div>"
						var nm 		= "<div><input type='text' name='line_grp_nm0' id='line_grp_nm0' style='width:100%;'/></div>"

						var v_use_yn = "";
						v_use_yn += "<div class='gridInput_area'><select name='use_yn0' id='use_yn0' style='width:100%;'>";
						v_use_yn += "<option value='Y'>사용</option>";
						v_use_yn += "<option value='N' selected >미사용</option>";
						v_use_yn += "</select></div>";
						
						rowsObj.push({
							'grid_idx': ""
							,'SELECT': ""
							,'LINE_GRP_CD': ""
							,'LINE_GRP_NM': nm
							,'USE_YN': v_use_yn
							,'OWNER_USER_CD':""
						});
						
						if(items.attr('cnt')=='0'){
						}else{
							items.find('item').each(function(i){						
							
								var line_grp_cd 	= $(this).find("LINE_GRP_CD").text();
								var line_grp_nm 	= $(this).find("LINE_GRP_NM").text();
								var use_yn 			= $(this).find("USE_YN").text();
								var owner_user_cd 	= $(this).find("OWNER_USER_CD").text();
								
								
								//var v_line_grp_cd = "<div><input type='hidden' name='line_grp_cd"+line_grp_cd+"' id='line_grp_cd"+line_grp_cd+"' value='"+line_grp_cd+"' /></div>";
								var v_line_grp_nm 	= "<div class='gridInput_area'><input type='text' name='line_grp_nm"+line_grp_cd+"' id='line_grp_nm"+line_grp_cd+"' value='"+line_grp_nm+"' style='width:100%;'/></div>";

								v_use_yn = "";
								v_use_yn += "<div class='gridInput_area'><select name='use_yn"+line_grp_cd+"' id='use_yn"+line_grp_cd+"' style='width:100%;'>";
								
								if(use_yn == "Y"){
									v_use_yn += "<option value='Y' selected>사용</option>";
									v_use_yn += "<option value='N'>미사용</option>";	
								}else{
									v_use_yn += "<option value='Y'>사용</option>";
									v_use_yn += "<option value='N' selected>미사용</option>";	
								}
								
								v_use_yn += "</select></div>";
								
								var v_owner_user_cd = "";
								
								rowsObj.push({
									'grid_idx':i+1
									,'SELECT': "[선택]"
									,'LINE_GRP_CD': line_grp_cd
									,'LINE_GRP_NM': v_line_grp_nm
									,'USE_YN': v_use_yn
									,'OWNER_USER_CD': v_owner_user_cd
								});
								
							});						
						}
						
						gridObj_1.rows = rowsObj;
						setGridRows(gridObj_1);
												
					});
					try{viewProgBar(false);}catch(e){}
				}
		, null );
		
		xhr.sendRequest();
		
		clearSlickGridData(gridObj_2); 
	}
	
	function userApprovalLineList(line_grp_cd){
		
		$('#frm2').find('input[name=line_grp_cd]').val(line_grp_cd) //일괄수정을 위해 line_grp_cd 셋팅
		$("#btn_group_udt").hide();
		
		try{viewProgBar(true);}catch(e){}
		$('#ly_total_cnt').html('');
		
		
		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=userApprovalLine&itemGubun=2&line_grp_cd='+line_grp_cd;
		
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
						
						var tot_cnt = items.attr("cnt");
						var v_approval_seq = parseInt(tot_cnt) + 1;
						
						var inputApproval_seq_no = "";
						inputApproval_seq_no += "<div class='gridInput_area'><select id='approval_seq0' name='approval_seq0' style='width:100%;text-align:center;'>";
						for(var j=0;j<arr_approval_seq_cd.length;j++){							
							inputApproval_seq_no += "<option value='"+arr_approval_seq_cd[j].cd+"'>"+arr_approval_seq_cd[j].cd+"</option>";
						}
						inputApproval_seq_no += "</select></div>";
												
						var inputApproval_user = "";
						inputApproval_user += "<div class='gridInput_area'><input type='hidden' id='approval_cd0' name='approval_cd0'/><input type='text' id='approval_nm0' name='approval_nm0' value='' style='width:100%;'/></div>";
												
						var inputPrc = "";
						inputPrc += "<div><a href=\"javascript:goProc('ins','"+line_grp_cd+"','0');\"><font color='red'>[추가]</font></a></div>";
						
// 						var inputApproval_gb = "";
// 						inputApproval_gb += "<div class='gridInput_area'><select id='approval_gb0' name='approval_gb0' style='width:100%;'>"
// 						for(var j=0;j<arr_approval_gb_cd.length;j++){							
// 							inputApproval_gb += "<option value='"+arr_approval_gb_cd[j].cd+"'>"+arr_approval_gb_nm[j].nm+"</option>";
// 						}
// 						inputApproval_gb += "</select></div>"
						
						rowsObj.push({
							'grid_idx':""
							,'LINE_CD': ""
							,'LINE_GRP_CD': ""
							,'APPROVAL_NM': inputApproval_user
							,'APPROVAL_SEQ': inputApproval_seq_no
// 							,'APPROVAL_GB': inputApproval_gb
							,'PROC':inputPrc
						});
						
						if(items.attr('cnt')=='0'){
						}else{
							items.find('item').each(function(i){						
							
								var line_cd 		= $(this).find("LINE_CD").text();
								var line_grp_cd 	= $(this).find("LINE_GRP_CD").text();
								var approval_cd 	= $(this).find("APPROVAL_CD").text();
								var approval_nm 	= $(this).find("APPROVAL_NM").text();
								var user_id 		= $(this).find("USER_ID").text();
								var duty_nm 		= $(this).find("DUTY_NM").text();
								var dept_nm 		= $(this).find("DEPT_NM").text();
// 								var user_info 		= approval_nm+"["+dept_nm+"]"+"["+duty_nm+"]";
								var user_info 		= approval_nm+"["+user_id+"]["+dept_nm+"]"+"["+duty_nm+"]";
								var approval_seq 	= $(this).find("APPROVAL_SEQ").text();
// 								var approval_gb 	= $(this).find("APPROVAL_GB").text();
								var user_cd 		= $(this).find("APPROVAL_CD").text();

								var v_approval_cd = "";
								v_approval_cd += "<input type='hidden' id='approval_cd"+line_cd+"' name='approval_cd"+line_cd+"' value='"+approval_cd+"' />";								
								
								var v_approval_seq = "";
								v_approval_seq += "<div class='gridInput_area'><select id='approval_seq"+line_cd+"' name='approval_seq"+line_cd+"' style='width:100%;text-align:center;'>";
								
								var v_user_cd = "";
								v_user_cd += "<input type='hidden' id='user_cd"+line_cd+"' name='user_cd"+line_cd+"' value='"+user_cd+"' />";
								

								for(var j=0;j<arr_approval_seq_cd.length;j++){
									
									v_approval_seq_check = "";
									
									if(approval_seq == arr_approval_seq_cd[j].cd){										
										v_approval_seq_check = "selected";
									}
									v_approval_seq += "<option value='"+arr_approval_seq_cd[j].cd+"' "+v_approval_seq_check+">"+arr_approval_seq_cd[j].cd+"</option>";
								}
								v_approval_seq += "</select></div>";
								
								v_user_info = ""; 
								v_user_info += "<div class='gridInput_area'>"+user_info+"<input type='text' id='approval_nm"+line_cd+"' name='approval_nm"+line_cd+"' value='' style='width:100%;'/></div>"; 
								
// 								var v_approval_gb = "";
// 								v_approval_gb += "<div class='gridInput_area'><select name='approval_gb"+line_cd+"' id='approval_gb"+line_cd+"' style='width:100%;'>";								
								
// 								for(var j=0;j<arr_approval_gb_cd.length;j++){
									
// 									v_approval_gb_check = "";
									
// 									if(approval_gb == arr_approval_gb_cd[j].cd){										
// 										v_approval_gb_check = "selected";
// 									}
									
// 									v_approval_gb += "<option value='"+arr_approval_gb_cd[j].cd+"' "+v_approval_gb_check+">"+arr_approval_gb_nm[j].nm+"</option>";									
// 								}
								
// 								v_approval_gb += "</select></div>";
								
								var v_proc 	= "<div>";
								v_proc 		+= "<a href=\"javascript:goProc('udt','"+line_grp_cd+"','"+line_cd+"');\"><font color='red'>[수정]</font></a> ";
								v_proc 		+= "<a href=\"javascript:goProc('del','"+line_grp_cd+"','"+line_cd+"');\"><font color='red'>[삭제]</font></a>";
								v_proc 		+= "</div>";
								
								/*
								var v_approval_gb 	= "";
								for(var j=0;j<arr_approval_gb_cd.length;j++){
									if(approval_gb == arr_approval_gb_cd[j].cd){
										v_approval_gb = arr_approval_gb_nm[j].nm;
									}
								}
								*/

								rowsObj.push({
									'grid_idx':i+1
									,'LINE_CD': line_cd
									,'LINE_GRP_CD': line_grp_cd
									,'APPROVAL_SEQ': v_approval_seq
									,'APPROVAL_NM': v_user_info
									,'APPROVAL_CD': v_approval_cd
// 									,'APPROVAL_GB': v_approval_gb
									,'PROC': v_proc
									,'USER_CD': v_user_cd
								});
								
							});						
						}
						$("#btn_group_udt").show();
						gridObj_2.rows = rowsObj;
						setGridRows(gridObj_2);
						$('#ly_total_cnt').html('[ TOTAL : '+items.attr('cnt')+' ]');
					
						
						// 사용자 자동 검색을 최초 저장 뿐만 아니라 수정도 가능하게 해야 하는 요건.
						// 해당 row의 line_cd를 가져와서 $('#approval_nm' + sel_line_cd) 이런식으로 셋팅을 해놔도 마지막 row의 line_cd로만 인식하는 현상이 있음.
						// 그래서 getUserList 호출할 때 다시 한번 해당 row의 line_cd를 가져와서 파라미터로 넘겨준다.
						// 2018.01.31 강명준 수정
						var aSelRow 	= new Array;
						aSelRow 		= gridObj_2.rows;
						
						//사용자 검색 팝업형식으로 변경
// 						if ( aSelRow.length > 0 ) {
// 							for ( var i = 1; i < aSelRow.length; i++ ) {
// 								var sel_line_cd = "";
// 								sel_line_cd = getCellValue(gridObj_2, i, "LINE_CD");
								
// 								$('#approval_nm' + sel_line_cd).unbind('keypress').keypress(function(e){
// 									//if(e.keyCode==13 && trim($(this).val())!=''){
// 									if(e.keyCode==13){
// 										var aSelRow 	= new Array;
// 										aSelRow = $('#'+gridObj_2.id).data('grid').getSelectedRows();
// 										if(aSelRow.length>0){
// 											for(var i=0;i<aSelRow.length;i++){
// 												line_cd = getCellValue(gridObj_2,aSelRow[i],"LINE_CD");
// 											}
// 										}
										
// 										getUserList($(this).val(), line_cd);
// 									}
// 								}).unbind('keyup').keyup(function(e){
// 									if($('#approval_cd' + sel_line_cd).val()!='' && $(this).data('sel_v') != $(this).val()){
// 										$('#approval_cd' + sel_line_cd).val('');
// 										$(this).removeClass('input_complete');
// 									}
// 								});
// 							}
// 						}
							
						$('input[id^=approval_nm]').unbind('click').click(function(){
							var user_idx = $(this).attr('id').replace("approval_nm","");
							goUserSearch(99,user_idx);
						}).unbind('keyup').keyup(function(e){
							if($(this).val() != '' && (this).data('sel_v') != $(this).val()){
								$('#sel_v').val();
								$(this).removeClass('input_complete');
							}
						});
						
// 						$('#approval_nm0').unbind('keypress').keypress(function(e){
// 							//if(e.keyCode==13 && trim($(this).val())!=''){
// 							if(e.keyCode==13){
// 								getUserList($(this).val(), 0);
// 							}
// 						}).unbind('keyup').keyup(function(e){
// 							if($('#approval_cd0').val()!='' && $(this).data('sel_v') != $(this).val()){
// 								$('#approval_cd0').val('');
// 								$(this).removeClass('input_complete');
// 							}
// 						});
						
						
					});
					try{viewProgBar(false);}catch(e){}
				}
		, null );
		
		xhr.sendRequest();
	}	
					
	//유저 검색 시 팝업형태로 변경하면서 works_common.js 호출하도록 변경
// 	function getUserList(user_id, arg){ 
		
<%-- 		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=userList&p_search_gubun=user_id&p_approval_gubun=Y&p_del_yn=N&p_search_text='+encodeURIComponent(user_id)+'&auto_yn=Y';   --%>
		
// 		var xhr = new XHRHandler(url, null
// 			,function(){
// 				var xmlDoc = this.req.responseXML;
				
// 				$(xmlDoc).find('doc').each(function(){
					
// 					var items = $(this).find('items');
					
// 					var aTags = new Array();
// 					if(items.attr('cnt')=='0'){
// 					}else{						
// 						items.find('item').each(function(i){						
// 							aTags.push({value:$(this).find('USER_NM').text()+'['+$(this).find('USER_ID').text()+']'+'['+$(this).find('DEPT_NM').text()+']'+$(this).find('DUTY_NM').text()+']'
// 										,label:$(this).find('USER_NM').text()+'['+$(this).find('USER_ID').text()+']'+'['+$(this).find('DEPT_NM').text()+']'+$(this).find('DUTY_NM').text()+']'
// 										,user_cd:$(this).find('USER_CD').text()
// 										,dept_nm:$(this).find('DEPT_NM').text()
// 										,dept_cd:$(this).find('DEPT_CD').text()
// 										});
// 						});
// 					}
					
// 					try{ $("#approval_nm"+arg).autocomplete("destroy"); }catch(e){};
					
// 					$("#approval_nm"+arg).autocomplete({
// 						minLength : 0
// 						,source: aTags
// 						,autoFocus: false
// 						,focus: function(event, ui) {
									
// 								}
// 						,select: function(event, ui) {
// 									$(this).val(ui.item.value);
// 									$("#approval_cd"+arg).val(ui.item.user_cd);
									
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
	
	function goProc(flag, line_grp_cd, line_cd) {
		
		var frm = document.frm2;
		var msg = "";
		
		var approval_cd 	= $("#frm2 #approval_cd" + line_cd);
		var approval_seq	= $("#frm2 #approval_seq" + line_cd);
// 		var approval_gb		= $("#frm2 #approval_gb" + line_cd);
		var std_approval_cd 	= $("#approval_cd0").val();
		var std_approval_cd1 	= $("#approval_cd" + line_cd).val();

		if ( flag != "del" ) {			
			//if(isNullInput(approval_cd,'<%=CommonUtil.getMessageSplit("ERROR.PARAM.02","[결재자]","") %>')) return;
			if ( approval_cd.val() == "" ) {
				alert("결재자를 등록해주세요.");
				return;
			}
			
			if(isNullInput(approval_seq,'<%=CommonUtil.getMessageSplit("ERROR.PARAM.02","[결재순서]","") %>')) return;			
		}
		
		if(confirm("처리하시겠습니까?")) {
		
			frm.approval_cd.value	= approval_cd.val();
			frm.approval_seq.value	= approval_seq.val();
// 			frm.approval_gb.value	= approval_gb.val();
			
			frm.flag.value 			= flag;
			frm.line_grp_cd.value 	= line_grp_cd;
			frm.line_cd.value 		= line_cd
			frm.target 				= "if1";
			frm.action 				= "<%=sContextPath%>/tWorks.ez?c=ezUserApprovalLine_p";
			
			frm.submit();		
		}
	}
	
	// 결재자 일괄수정 기능
	function goProc2(flag, line_cd, approval_cd, approval_seq) {
		
		var frm = document.frm2;
		
		if(line_cd == "") {
			alert("수정할 결재자를 등록해주세요.");
			return;
		}

		
		if(confirm("처리하시겠습니까?")) {
		
			frm.flag.value 			= flag;
			frm.line_cd.value 		= line_cd;
			frm.approval_cd.value 	= approval_cd;
			frm.approval_seq.value 	= approval_seq;
			
			frm.target 				= "if1";
			frm.action 				= "<%=sContextPath%>/tWorks.ez?c=ezUserApprovalLine_p";
			
			frm.submit();		
		}
	}
	
	//사용자 검색 팝업형태로 변경
	function goUserSeqSelect(cd, nm, btn, sel_line_cd){
		
		$("#approval_nm"+ sel_line_cd).val(nm);
		$("#approval_cd"+ sel_line_cd).val(cd);;

		dlClose('dl_tmp3');
	}
</script>