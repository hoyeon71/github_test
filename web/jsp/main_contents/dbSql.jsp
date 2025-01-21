<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/jsp/common/inc/header.jsp"%>
<%@include file="/jsp/common/inc/sessionChk.jsp"%>

<%
	Map<String, Object> paramMap = CommonUtil.collectParameters(request);
	String c = CommonUtil.isNull(paramMap.get("c"));
	String gridId = "g_"+c;
	
	String aGb[] = null;
	
// 	String s_db_cd = CommonUtil.isNull(paramMap.get("s_db_cd"));
// 	MetaDbBean metaDbBean = CommonUtil.getMetaDbDetail(s_db_cd);
%>

<form id="f_s" name="f_s" method="post" onsubmit="return false;">
<%-- 	<input type='hidden' id='s_db_cd' name='s_db_cd' value='<%=s_db_cd %>' /> --%>
	
</form>

<table style='width:100%;height:30%;border:none;'>
	<tr>
		<td style='vertical-align:top;width:5px;height:100%;' ></td>
		<td style='vertical-align:top;height:100%;' >
			<table style='width:100%;height:100%;border:none;'>
				<tr style='height:10px;'>
					<td style='vertical-align:top;'>
						<h4  class="ui-widget-header ui-corner-all"  >
							<div  class='title_area' >
								<span>DB</span>
							</div>
						</h4>
					</td>
				</tr>
				<tr>
					<td id='ly_g_sql' style='vertical-align:top;height:200px;' >
						<div id="g_sql" class="ui-widget-header ui-corner-all" >
							<div style="overflow: hidden; position: relative;" class="slick-header ui-state-default">
								<div class="ui-state-default slick-header-column cellCenter" style='width:100%;height:15px;'>
									<span class="slick-column-name">SQL</span>
								</div>
							</div>
							<div style="overflow: auto; position: relative;" class="slick-headerrow">
								<div  class="slick-headerrow-columns">
									<div class="ui-widget-content slick-header-column cellLeft" style='width:100%;height:500px;' >
										<form id="f_1" name="f_1" method="post" onsubmit="return false;">
											<%-- 								<input type='hidden' id='db_cd' name='db_cd' value='<%=s_db_cd %>' /> --%>
											<input type='hidden' id='run_sql' name='run_sql' value='' />

											<textarea id='sql_text' name='sql_text' wrap='off' style='width:100%;height:500px;'></textarea>
											<div style='padding:2px 0px 0px 5px;'> Limit <input type='text' id='limit_cnt' name='limit_cnt' value='100' style='width:30px;' class='ime_disabled_num' maxlength='4' /></div>
										</form>
									</div>
								</div>
							</div>
						</div>
					</td>
				</tr>
				<tr style='height:10px;'>
					<td style='vertical-align:top;width:100px;'>
						<h4 class="ui-widget-header ui-corner-all" >
							<div align='right' class='btn_area' >
								<span id='btn_sql_run' style='display:none'>결과조회</span>
								<!-- span id='btn_sqlexp_run' style='display:none'>EXPLAIN</span-->
							</div>
						</h4>
					</td>
				</tr>
			</table>

			<table style='width:100%;height:80%;border:none;'>
				<tr style='height:10px;'>
					<td style='vertical-align:top;'>
						<h4  class="ui-widget-header ui-corner-all"  >
							<div  class='title_area' >
								<span>쿼리결과</span>
							</div>
						</h4>
					</td>
				</tr>
				<tr>
					<td id='ly_g_ret' style='vertical-align:top;width:100%;height:450px;' ></td>
				</tr>
				<tr style='height:10px;'>
					<td style='vertical-align:top;'>
						<!-- div id='ly_g_ret_c' style='height:80px;overflow-y:hidden;display:none;' ></div-->
						<h4 class="ui-widget-header ui-corner-all" >
							<div align='right' class='btn_area' >
								<div id='ly_total_cnt' style='padding-top:5px;float:left;'></div>

								<span id='btn_excel' style='display:none'>엑셀다운</span>
							</div>
						</h4>
					</td>
				</tr>
			</table>
		
		</td>
	</tr>
</table>


<script>
	
	$(document).ready(function(){
		
		var resizeBody = function(){
			$('#g_sql').width(0);
			$('#g_sql').height(0);
			setTimeout(function(){
				$('#g_sql').width($('#ly_g_sql').width());
				$('#g_sql').height($('#ly_g_sql').height());
				
				$('.slick-headerrow-columns:eq(0) > .slick-header-column').height(
					$('#g_sql').height()-10
					-$('.slick-header').height()
				);
				
				$('#sql_text').height($('.slick-headerrow-columns:eq(0) > .slick-header-column').height()-30);
				
			}, 350);
		};
		$(window).bind('resizestop',resizeBody);
		resizeBody.call();
		
		$( "#btn_sql_run" ).show().button().unbind('click').click(function(){
			if( isNullInput($('#sql_text'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[SQL]","") %>') ) return false;
			if( isNullInput($('#limit_cnt'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[Limit]","") %>') ) return false;
			getSqlRun();
		});
		
		$( "#btn_sqlexp_run" ).show().button().unbind('click').click(function(){
			if( isNullInput($('#sql_text'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[SQL]","") %>') ) return false;
			
			$('#sql_text').val($('#sql_text').val().replace(/:[0-9a-zA-Z-_]+/g,"?").replace(/: [0-9a-zA-Z-_]+/g,"?"));
			getSqlExpRun();
		});
		
	});
	
	function goSearch(){
		var f_s = document.f_s;
		
		f_s.target = "_self";
		f_s.action = "<%=sContextPath %>/works.do?c=<%=c %>"; 
		f_s.submit();
	}
	
	function downExcelSql(){
		var f = document.f_1;
		try{viewProgBar(true);}catch(e){}
		f.target = 'if1';
		f.action = "<%=sContextPath %>/tWorks.ez?c=a1201_excel";
		f.submit();
		try{viewProgBar(false);}catch(e){}
	}
	
	function getSqlRun(){
		$('#ly_g_ret_c').hide();
		
		$('#btn_excel').hide();
		$('#ly_total_cnt').html('');
		$('#ly_g_ret').empty();
		$('#ly_g_ret').append("<div id='g_ret' class='ui-widget-header ui-corner-all' ></div>");
		
		try{viewProgBar(true);}catch(e){}
		
		var url = '<%=sContextPath %>/common.ez?c=sqlRun';
		
		var xhr = new XHRHandler( url, f_1
				,function(){
					var xmlDoc = this.req.responseXML;
					if(xmlDoc==null){
						try{viewProgBar(false);}catch(e){}
						//alert('접속에러');
						return false;
					}
					if($(xmlDoc).find('doc').length == 0 && $(xmlDoc).find('error').length > 0){
						goCommonError('<%=sContextPath %>','_self',$(xmlDoc).find('msg_code').text());
						return false;
					}
					$(xmlDoc).find('doc').each(function(){
						
						var items = $(this).find('items');
						
						if(items.find('error').length > 0){
							$('#g_ret').width($('#ly_g_ret').width());
							$('#g_ret').height($('#ly_g_ret').height());
							$('#g_ret').css({'overflow':'auto'});
							$('#g_ret').html($(this).text());
							return false;
						}
						
						var colsObj = new Array();
						var gridObj = {
							id : "g_ret"
							,colModel:[]
							,rows:[]
						};
						colsObj.push({formatter:gridCellNoneFormatter,field:'row_num',id:'row_num',name:'순번',width:80,headerCssClass:'cellCenter',cssClass:'cellCenter'});
						items.find('item').each(function(i){
							colsObj.push({formatter:gridCellNoneFormatter,field:'col'+(i+1),id:'col'+(i+1),name:$(this).text(),width:100,headerCssClass:'cellCenter',cssClass:'cellLeft'});
						});
						colsObj.push({formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'grid_idx',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'});
						
						gridObj.colModel = colsObj; 
						viewGrid_1(gridObj,"ly_"+gridObj.id);
						
						var rowsObj = $.parseJSON(items.find('json').text());
						gridObj.rows = rowsObj;
						setGridRows(gridObj);
						$('#ly_total_cnt').html('[ TOTAL : '+toComma(items.find('cnt').text())+' ]');
						
						$('#run_sql').val(items.find('sql').text());
						if(items.find('cnt').text()!='0'){
							$( "#btn_excel" ).show().button().unbind('click').click(function(){
								downExcelSql();
							});	
						}
						
					});
					try{viewProgBar(false);}catch(e){}
				}
		, null );
		
		xhr.sendRequest();
	}
	
	function toComma(v) {

		var num_str = v+'';
		num_str = num_str.replace(/,/gi, "");
		var result = "";

		var num_rep = Number(num_str);
		if(num_rep < 0 ){
			num_str=num_str.substring(1,num_str.length);
		}

		for(var i=0; i<num_str.length; i++) {
			var tmp = num_str.length-(i+1);

			if(i%3==0 && i!=0){
				result = "," + result;
			}
		    result = num_str.charAt(tmp) + result;
		}
		if(num_rep < 0 ){
			result = '-'+result;
		}
		
		return result;
	}
	
	function getSqlExpRun(){
		
		$('#btn_excel').hide();
		$('#ly_total_cnt').html('');
		$('#ly_g_ret').empty();
		$('#ly_g_ret').append("<div id='g_ret' class='ui-widget-header ui-corner-all' ></div>");
		
		$('#ly_g_ret_c').empty();
		$('#ly_g_ret_c').show();
		$('#ly_g_ret_c').append("<div id='g_ret_c' class='ui-widget-header ui-corner-all' ></div>");
		
		try{viewProgBar(true);}catch(e){}
		
		var url = '<%=sContextPath %>/common.do?c=cData&itemGb=sqlExpRun';
		
		var xhr = new XHRHandler( url, f_1
				,function(){
					var xmlDoc = this.req.responseXML;
					if(xmlDoc==null){
						try{viewProgBar(false);}catch(e){}
						//alert('접속에러');
						return false;
					}
					if($(xmlDoc).find('doc').length == 0 && $(xmlDoc).find('error').length > 0){
						goCommonError('<%=sContextPath %>','_self',$(xmlDoc).find('msg_code').text());
						return false;
					}
					$(xmlDoc).find('doc').each(function(){
						
						var items = $(this).find('items');
						
						if(items.find('error').length > 0){
							$('#g_ret').width($('#ly_g_ret').width());
							$('#g_ret').height($('#ly_g_ret').height());
							$('#g_ret').css({'overflow':'auto'});
							$('#g_ret').html($(this).text());
							return false;
						}
						
						var colsObj = new Array();
						var gridObj = {
							id : "g_ret"
							,colModel:[]
							,rows:[]
						};
						colsObj.push({formatter:gridCellNoneFormatter,field:'qblockno',id:'qblockno',name:'QNO',width:50,headerCssClass:'cellCenter',cssClass:'cellCenter'});
						colsObj.push({formatter:gridCellNoneFormatter,field:'planno',id:'planno',name:'PNO',width:50,headerCssClass:'cellCenter',cssClass:'cellCenter'});
						colsObj.push({formatter:gridCellNoneFormatter,field:'path',id:'path',name:'PLAN PATH',width:350,headerCssClass:'cellCenter',cssClass:'cellLeft'});
						colsObj.push({formatter:gridCellNoneFormatter,field:'tname_text',id:'tname_text',name:'TNAME(ALIAS)',width:120,headerCssClass:'cellCenter',cssClass:'cellLeft'});
						colsObj.push({formatter:gridCellNoneFormatter,field:'tslockmode',id:'tslockmode',name:'LC',width:60,headerCssClass:'cellCenter',cssClass:'cellCenter'});
						
						colsObj.push({formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'grid_idx',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'});
						
						gridObj.colModel = colsObj; 
						viewGrid_1(gridObj,"ly_"+gridObj.id);
						
						var items = $(this).find('items');
						
						var rowsObj = new Array();
						
						var procms = '';
						var procsu = '';
						var cost_category = '';
						var reason = '';
						
						items.find('item').each(function(i){
							var planseq = $(this).find('planseq').text();
							
							procms = $(this).find('procms').text();
							procsu = $(this).find('procsu').text();
							cost_category = $(this).find('cost_category').text();
							reason = $(this).find('reason').text();
							
							var qblockno = $(this).find('qblockno').text();
							var planno = $(this).find('planno').text();
							var path = $(this).find('path').text();
							var creator = $(this).find('creator').text();
							var tname = $(this).find('tname').text();
							var remarks = $(this).find('remarks').text();
							var tname_text = $(this).find('tname_text').text();
							var tslockmode = $(this).find('tslockmode').text();
							
							if(planseq!='0') path = "<span style='padding-left:"+planseq+"0px;'>↖"+path+"</span>"; 
							
							if(creator!='' && tname != ''){
<%-- 								tname_text = "<a href=\"javascript:top.popTbInfo('<%=s_db_cd %>', '"+creator+"', '"+tname+"');\" >"+tname_text+"</a>"; --%>
							}
							
							rowsObj.push({
								'grid_idx':i
									
								,'qblockno':qblockno
								,'planno':planno
								,'path':path
								,'tname_text':tname_text
								,'tslockmode':tslockmode
								
							});
						});
							
						gridObj.rows = rowsObj;
						setGridRows(gridObj);
						
						//_c
						var gridObj_c = {
							id : "g_ret_c"
							,colModel:[
								{formatter:gridCellNoneFormatter,field:'procms',id:'procms',name:'PROCMS(milliseconds)',width:80,headerCssClass:'cellCenter',cssClass:'cellCenter'}
								,{formatter:gridCellNoneFormatter,field:'procsu',id:'procsu',name:'PROCSU(service units)',width:80,headerCssClass:'cellCenter',cssClass:'cellCenter'}
								,{formatter:gridCellNoneFormatter,field:'cost_category',id:'cost_category',name:'COST CATEGORY',width:150,headerCssClass:'cellCenter',cssClass:'cellLeft'}
								,{formatter:gridCellNoneFormatter,field:'reason',id:'reason',name:'REASON',width:250,headerCssClass:'cellCenter',cssClass:'cellLeft'}
								
								,{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'grid_idx',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
							]
							,rows:[
								{
									'procms':procms
									,'procsu':procsu
									,'cost_category':cost_category
									,'reason':reason
									
									,'grid_idx':0	
								}
							]
						};
						
						viewGrid_1(gridObj_c,"ly_"+gridObj_c.id);
						setGridRows(gridObj_c);
						
					});
					
					try{viewProgBar(false);}catch(e){}
				}
		, null );
		
		xhr.sendRequest();
	}
	
</script>

