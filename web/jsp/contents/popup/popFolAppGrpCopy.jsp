<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@include file="/jsp/common/inc/header.jsp"%>
<%@include file="/jsp/common/inc/sessionChkPopup.jsp"%>

<%
	Map<String, Object> paramMap = CommonUtil.collectParameters(request);
	String c = CommonUtil.isNull(paramMap.get("c"));
	
	String aGb[] = null;
	
	String order_ymd 	= CommonUtil.isNull(paramMap.get("s_order_ymd"));
	String job_id 		= CommonUtil.isNull(paramMap.get("s_job_id"));
	
   String strSessionDcCode 	= S_D_C_CODE;
   
%>

<form id="f_s" name="f_s" method="post" onsubmit="return false;">
	<input type='hidden' id='user_nm' name='user_nm' />
	<input type='hidden' id='user_cd' name='user_cd' />
   <input type='hidden' name='data_center' id='data_center' />
</form>

<form id="f_out" name="f_out" method="post" onsubmit="return false;">
	<input type='hidden' id='user_nm' name='user_nm' />
	<input type='hidden' id='user_cd' name='user_cd' />
   <input type='hidden' name='data_center' id='data_center' />
</form>

<form id='folAppGrpForm' name='folAppGrpForm' method='post' onsubmit='return false;'>
	<input type='hidden' name='flag' id='flag' value='' />	
	<input type='hidden' name='user_cd' id='user_cd' />
	<input type='hidden' name='scode_cd' id='scode_cd' />
	<input type='hidden' name='folder_auth' id='folder_auth' />
	<input type='hidden' name='data_center' id='data_center' />
</form>

<table style='width:100%;height:100%;border:none;' >
	<tr style='height:10px;'>
      <td style='vertical-align:top;'  colspan=2>
         <h4  class="ui-widget-header ui-corner-all">
            <div class='title_area' style='padding-left:10px;'>
               C-M
               <select id="data_center_items" name="data_center_items" style="width:150px; height:19px;" onChange="resetFolderAppGrpList()">
                  <option value="">선택</option>
                     <c:forEach var="cm" items="${cm}" varStatus="status">
                         <option value="${cm.scode_cd},${cm.scode_eng_nm}">${cm.scode_nm}</option>
                     </c:forEach>
               </select>
            </div>
         </h4>
      </td>
   </tr>
   <tr style='height:10px;'>
		<td style='vertical-align:top;' >
			<h4  class="ui-widget-header ui-corner-all"  >
				<div class='title_area' >
					From 사용자
					<input type='text' id='user_nm1' name='user_nm1' value='' class="input" style="width:200px" onKeyPress="if(event.keyCode==13) goUserSearch('1');" onclick="goUserSearch('1');" readonly="readonly" />
					<input type='button' class='btn_blue_h20' value='조회' onclick="goUserSearch('1');" />
				</div>
			</h4>
		</td>
		<td style='vertical-align:top;' >
			<h4  class="ui-widget-header ui-corner-all"  >
				<div class='title_area' >
					To 사용자
					<input type='text' id='user_nm2' name='user_nm2' value='' class="input" style="width:200px" onKeyPress="if(event.keyCode==13) goUserSearch('2');" onclick="goUserSearch('2');" readonly="readonly" />
					<input type='button' class='btn_blue_h20' value='조회' onclick="goUserSearch('2');" />
				</div>
			</h4>
		</td>
	</tr>
	<tr>
		<td style='vertical-align:top;width:50%;' >
			<table class='sub_table' style='width:100%;border:none;'>
				<tr style='height:10px;'>
					<td style='vertical-align:top;' >
						<h4  class="ui-widget-header ui-corner-all"  >
							<div id='t_in' class='title_area' >
								FROM 폴더
							</div>
						</h4>
					</td>
				</tr>
				<tr>
					<td id='ly_g_in' style='vertical-align:top;' >	
						<div id="g_in" class="ui-widget-header ui-corner-all" ></div>
					</td>
				</tr>
				<tr style='height:10px;'>
					<td colspan='2' style='vertical-align:top;'>
						<h4  class="ui-widget-header ui-corner-all" >
							<div align='right' class='btn_area' >
								<span id='btn_ins'>추가</span>
							</div>
						</h4>
					</td>
				</tr>
			</table>
		</td>
		
		<td style='vertical-align:top;width:50%;' >
			<table class='sub_table' style='width:100%;border:none;'>
				<tr style='height:10px;'>
					<td style='vertical-align:top;' >
						<h4  class="ui-widget-header ui-corner-all"  >
							<div id='t_out' class='title_area' >
								TO 폴더
							</div>
						</h4>
					</td>
				</tr>
				<tr>
					<td id='ly_g_out' style='vertical-align:top;' >
						<div id='g_out' class='ui-widget-header ui-corner-all'  ></div>
					</td>
				</tr>
				<tr style='height:10px;'>
					<td colspan='2' style='vertical-align:top;'>
						<h4  class="ui-widget-header ui-corner-all" >
							<div align='right' class='btn_area' >
								<span id='btn_del'>삭제</span>
							</div>
						</h4>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	
	<tr style='height:2px;'><td colspan='2'></td></tr>
</table>

<script>
	var g_in = {
		id : 'g_in'
		,colModel:[
			{formatter:gridCellNoneFormatter,field:'SCODE_NM',id:'SCODE_NM',name:'C-M',width:100,headerCssClass:'cellCenter',cssClass:'cellCenter'}
			,{formatter:gridCellNoneFormatter,field:'FOLDER',id:'FOLDER',name:'폴   더',width:250,headerCssClass:'cellCenter',cssClass:'cellLeft'}
	   		,{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'grid_idx',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   		,{formatter:gridCellNoneFormatter,field:'TAB_CODE',id:'TAB_CODE',name:'TAB_CODE',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   		,{formatter:gridCellNoneFormatter,field:'DATA_CENTER',id:'DATA_CENTER',name:'DATA_CENTER',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
	   	]
		,rows:[]
	};
	
	var g_out = {
			id : 'g_out'
			,colModel:[
				{formatter:gridCellNoneFormatter,field:'SCODE_NM',id:'SCODE_NM',name:'C-M',width:100,headerCssClass:'cellCenter',cssClass:'cellCenter'}
				,{formatter:gridCellNoneFormatter,field:'FOLDER',id:'FOLDER',name:'폴   더',width:250,headerCssClass:'cellCenter',cssClass:'cellLeft'}
		   		,{formatter:gridCellNoneFormatter,field:'grid_idx',id:'grid_idx',name:'grid_idx',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
		   		,{formatter:gridCellNoneFormatter,field:'TAB_CODE',id:'TAB_CODE',name:'TAB_CODE',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
		   		,{formatter:gridCellNoneFormatter,field:'DATA_CENTER',id:'DATA_CENTER',name:'DATA_CENTER',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
		   	]
			,rows:[]
		};
	
	$(document).ready(function(){
		viewGridChk_1(g_in,'ly_'+g_in.id);
		viewGridChk_1(g_out,'ly_'+g_out.id);
// 		$("#btn_ins").hide();
// 		$("#btn_del").hide();
		var icons = null;
      var session_dc_code		= "<%=strSessionDcCode%>";
		
      //초기 검색조건 - C-M, 폴더, 어플리케이션, 그룹
  	  if(session_dc_code != "") { // 개인정보에 C-M이 등록되어 있을경우
  	  	 $("select[name='data_center_items']").val(session_dc_code);
  	  }else { // 개인정보에 C-M이 등록이 되어있지 않을경우 -> C-M 콤보박스에서 첫번째값 선택
  		 $("#data_center_items option:eq(1)").prop("selected", true);
  	  }
      
		$( document ).click(function(e){
			$('#ly_ContextMenu_01').hide();
			
			if(!$(e.target).is('#ly_searchMenu_01 *,#icon_searchMenu_01 *')) $('#ly_searchMenu_01').hide();
		}).contextmenu(function(e){
			
		});
		
		initIme();
		
		$("#btn_ins").button().unbind("click").click(function(){
			goPrc("ins_copy");
		});
		
		$("#btn_del").button().unbind("click").click(function(){
			goPrc("del_copy");
		});
		
	});
	
	function goUserSearch(btn, sel_line_cd){
	
		var data_center = $("select[name='data_center_items']").val();
	    if(data_center == ""){
		    alert("C-M 을 선택해 주세요.");
		    return;
	    }
		
		var sHtml2="<div id='dl_tmp3' style='overflow:hidden;display:none;padding:0;border-top:1px solid blue;border-bottom:1px solid blue;border-left:1px solid blue;border-right:1px solid blue;'>";
		sHtml2+="<form id='form3' name='form3' method='post' onsubmit='return false;'>";
		sHtml2+="<table style='width:100%;height:260px;;border:none;'><tr><td style='vertical-align:top;height:100%;width:500px;'>";
		sHtml2+="<select name='ser_gubun' id='ser_gubun' style='height:21px;'>";
		sHtml2+="<option value='all'>전체</option>";
		sHtml2+="<option value='user_nm'>사용자명</option>";
		sHtml2+="<option value='user_id'>아이디</option>";
		sHtml2+="<option value='dept_nm'>부서명</option>";
		sHtml2+="</select>";
		sHtml2+="<input type='text' name='ser_user_nm' id='ser_user_nm' />&nbsp;&nbsp;<span id='btn_usersearch'>검색</span>";
		sHtml2+="<table style='width:100%;height:100%;border:none;'>";
		sHtml2+="<tr><td id='ly_g_tmp3' style='vertical-align:top;' >";
		sHtml2+="<div id='g_tmp3' class='ui-widget-header ui-corner-all'></div>";
		sHtml2+="</td></tr>";
		sHtml2+="<tr style='height:10px;'><td style='vertical-align:top;'><h5 class='ui-widget-header ui-corner-all' >";
		sHtml2+="<div align='right' class='btn_area_s'>";
		sHtml2+="<div id='ly_total_cnt3' style='padding-top:5px;float:left;'></div>";
		if(btn == '2') { // 유저관리 > 폴더권한복사 기능의 To 사용자 조회 버튼을 클릭했을 경우 노출(2024-09-05 김선중)
			sHtml2+="<span id='btn_user_select'>선택</span>";
		}
		sHtml2+="</div>";
		sHtml2+="</h5></td></tr></table>";
		
		sHtml2+="</td></tr></table>";
		
		sHtml2+="</form>";
		
		$('#dl_tmp3').remove();
		$('body').append(sHtml2);
		
		dlPop01('dl_tmp3',"사용자내역",400,295,false);
		
		var gridObj3 = null;
		if(btn == '2'){
			gridObj3 = {
				id : "g_tmp3"
				,colModel:[
					{formatter:gridCellNoneFormatter,field:'check_idx',id:'check_idx',name:'<input type="checkbox" name="checkIdxAll" id="checkIdxAll" onClick="checkAll();">',width:30,minWidth:30,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:false}
					,{formatter:gridCellNoneFormatter,field:'dept_nm',id:'dept_nm',name:'부서명',width:100,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
					,{formatter:gridCellNoneFormatter,field:'duty_nm',id:'duty_nm',name:'직책',width:60,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
					,{formatter:gridCellNoneFormatter,field:'user_nm',id:'user_nm',name:'사용자명',width:80,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
					,{formatter:gridCellNoneFormatter,field:'user_id',id:'user_id',name:'아이디',width:80,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
			   		,{formatter:gridCellNoneFormatter,field:'user_cd',id:'user_cd',name:'user_cd',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
			   	]
				,rows:[]
				,vscroll:false
			};
		} else {
			gridObj3 = {
				id : "g_tmp3"
				,colModel:[
					{formatter:gridCellNoneFormatter,field:'dept_nm',id:'dept_nm',name:'부서명',width:100,headerCssClass:'cellCenter',cssClass:'cellLeft',sortable:true}
					,{formatter:gridCellNoneFormatter,field:'duty_nm',id:'duty_nm',name:'직책',width:60,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
					,{formatter:gridCellNoneFormatter,field:'user_nm',id:'user_nm',name:'사용자명',width:80,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
					,{formatter:gridCellNoneFormatter,field:'user_id',id:'user_id',name:'아이디',width:80,headerCssClass:'cellCenter',cssClass:'cellCenter',sortable:true}
					,{formatter:gridCellNoneFormatter,field:'CHOICE',id:'CHOICE',name:'선택',width:50,headerCssClass:'cellCenter',cssClass:'cellCenter'}
			   		,{formatter:gridCellNoneFormatter,field:'user_cd',id:'user_cd',name:'user_cd',width:0,minWidth:0,headerCssClass:'cellHid',cssClass:'cellHid'}
			   	]
				,rows:[]
				,vscroll:false
			};
		}
		
		viewGrid_1(gridObj3,'ly_'+gridObj3.id);
		
		var ser_gubun = $("select[name='ser_gubun'] option:selected").val();
		var ser_user_nm = $("#ser_user_nm").val();
			
		getUserList(ser_gubun,ser_user_nm,btn, sel_line_cd); 
		
		
		setTimeout(function() {
			$("#ser_user_nm").focus();
		}, 100);
		
		$('#ser_user_nm').placeholder().unbind('keypress').keypress(function(e){
			if(e.keyCode==13 && trim($('#ser_user_nm').val())!=''){				
				var ser_gubun = $("select[name='ser_gubun'] option:selected").val();	
								
				getUserList(ser_gubun,$(this).val(),btn, sel_line_cd);
			} else if (e.keyCode==13 && trim($('#ser_user_nm').val())=='') {
				getUserList(ser_gubun,$(this).val(),btn, sel_line_cd);
			}
		});
		
		
		$("#btn_usersearch").button().unbind("click").click(function(){
			var ser_gubun = $("select[name='ser_gubun'] option:selected").val();
			var ser_user_nm = $("#ser_user_nm").val();
			
			getUserList(ser_gubun,ser_user_nm,btn, sel_line_cd);
		});		
		
		$("#btn_user_select").button().unbind("click").click(function(){
			var check_idx = document.getElementsByName("check_idx");
			var check_val = 0;

			for (var i = 0; i < check_idx.length; i++) {
				if (check_idx.item(i).checked) {
					check_val++;
				}
			}

			if (check_val == 0) {
				alert("폴더권한을 설정할 사용자를 선택해주세요.");
				return;
			}
			
			var arr_user_cd = "";
			var arr_user_nm = "";
			var check_cnt	= 0;
			
			var check_user_cd_idx	= document.getElementsByName("check_user_cd_idx");
			var user_cd				= "";
			var check_user_cd	 	= "";

			var check_user_nm_idx	= document.getElementsByName("check_user_nm_idx");
			var user_nm				= "";
			var check_user_nm	 	= "";

			var check_btn_idx		= document.getElementsByName("check_btn_idx");
			var btn					= "";
			var check_btn 			= "";
			
			for ( var i = 0; i < check_idx.length; i++ ) {
				if(check_idx.item(i).checked) {

					user_cd 			= check_user_cd_idx.item(i).value;
					check_user_cd		= user_cd + "," + check_user_cd;

					user_nm				= check_user_nm_idx.item(i).value;
					check_user_nm		= user_nm + "," + check_user_nm;

					btn					= check_btn_idx.item(i).value;
					check_btn			= btn + "," + check_btn;

					check_cnt++;
				}
			}
			
			check_user_cd 		= check_user_cd.substring(0, check_user_cd.length-1);
			check_user_nm 		= check_user_nm.substring(0, check_user_nm.length-1);
			check_btn 			= check_btn.substring(0, check_btn.length-1);
			
			if(check_cnt > 1){
				alert("사용자를 다중 조회할 경우 TO 폴더의 목록은 초기화됩니다.");
			}
			
			arr_user_cd = check_user_cd
			arr_user_nm = check_user_nm
			
			goUserSeqSelect(arr_user_cd, arr_user_nm, btn);
		});
	}
	
	//담당자 조회
	function getUserList(gubun, text, btn, sel_line_cd){
		try{viewProgBar(true);}catch(e){}
		$('#ly_total_cnt3').html('');
		
		var url = "";
		if(btn == 99){
			url = '/common.ez?c=cData&itemGb=userList&p_search_gubun='+gubun+'&p_search_text='+encodeURIComponent(text)+'&p_del_yn=N'+'&p_approval_gubun=Y';
		}else{
			url = '/common.ez?c=cData&itemGb=userList&p_search_gubun='+gubun+'&p_search_text='+encodeURIComponent(text)+'&p_del_yn=N';
		}

		var xhr = new XHRHandler( url, null
				,function(){
					var xmlDoc = this.req.responseXML;
					if(xmlDoc==null){
						try{viewProgBar(false);}catch(e){}
						alert('세션이 만료되었습니다 다시 로그인해 주세요');
						return false;
					}

					if($(xmlDoc).find('doc').length == 0 && $(xmlDoc).find('error').length > 0){
						goCommonError('','_self',$(xmlDoc).find('msg_code').text());
						return false;
					}
					$(xmlDoc).find('doc').each(function(){

						var items = $(this).find('items');
						var rowsObj = new Array();

						if(items.attr('cnt')=='0'){
						}else{
							items.find('item').each(function(i){

								var dept_nm = $(this).find("DEPT_NM").text();
								var duty_nm = $(this).find("DUTY_NM").text();
								var user_nm = $(this).find("USER_NM").text();
								var user_cd = $(this).find("USER_CD").text();
								var user_id = $(this).find("USER_ID").text();
								
								var v_check_idx = "";
								
								v_check_idx = 	"<div class='gridInput_area'><input type='checkbox' name='check_idx' value='"+i+1+"' ></div>";
								v_check_idx	+= 	"<input type='hidden' name='check_user_cd_idx' value='"+user_cd+"' >";
								v_check_idx	+= 	"<input type='hidden' name='check_user_nm_idx' value='"+user_nm+"' >";
								v_check_idx	+= 	"<input type='hidden' name='check_btn_idx' value='"+btn+"' >";

								rowsObj.push({
									'check_idx':v_check_idx
									,'grid_idx':i+1
									,'dept_nm':dept_nm
									,'duty_nm':duty_nm
									,'user_nm':user_nm
									,'user_id':user_id
									,'CHOICE':"<div><a href=\"javascript:goUserSeqSelect('"+user_cd+"', '"+user_nm+"', '"+btn+"', '"+sel_line_cd+"');\" ><font color='red'>[선택]</font></a></div>"
									,'user_cd':user_cd
								});

							});

						}
						var obj = $("#g_tmp3").data('gridObj');
						obj.rows = rowsObj;
						setGridRows(obj);

						$('#ly_total_cnt3').html('[ TOTAL : '+items.attr('cnt')+' ]');
					});
					try{viewProgBar(false);}catch(e){}
				}
		, null );

		xhr.sendRequest();
		
		$("#approval_cd"+sel_line_cd).val("");      
		$("#approval_nm"+sel_line_cd).val("");
		
		$("#group_line_grp_cd"+sel_line_cd).val("");      
		$("#group_line_grp_nm"+sel_line_cd).val("");
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
	
	function goSearch(){
		var f_s = document.f_s;
		
		f_s.target = "_self";
		f_s.action = "<%=sContextPath %>/works.do?c=<%=c %>"; 
		f_s.submit();
	}
	
	function folderAppGrpList(in_out){
		try{viewProgBar(false);}catch(e){console.error(e);}		
		$('#ly_total_cnt_auth').html('');
		  			
		var url = '<%=sContextPath %>/common.ez?c=cData&itemGb=folderAppGrpList';
		var frm = null;
		if(in_out == 1) {
			frm = document.f_s;
		} else {
			frm = document.f_out;
		}
		var xhr = new XHRHandler(url, frm
				,function(){
					var xmlDoc = this.req.responseXML;
					if(xmlDoc==null){
						try{viewProgBar(false);}catch(e){console.error(e);}
						alert('세션이 만료되었습니다 다시 로그인해 주세요');
						return false;
					}
					if($(xmlDoc).find('doc').length == 0 && $(xmlDoc).find('error').length > 0){
						//goCommonError('','_self',$(xmlDoc).find('msg_code').text());
						return false;
					}
					$(xmlDoc).find('doc').each(function(){
						var items = $(this).find('items');
						var rowsObj = new Array();
						var authIdxSum 	= ''; 
						if(items.attr('cnt')=='0'){
							//return;
						}else{
							if(in_out == 1) {
								$("#btn_ins").show();
							} else {
								$("#btn_del").show();
							}
							items.find('item').each(function(i){
								var folder 			= $(this).find("FOLDER").text();
								var tab_nm			= $(this).find("TAB_NM").text();
								var data_center		= $(this).find("DATA_CENTER").text();
								var scode_nm		= $(this).find("SCODE_NM").text();
								var authIdx 		= $(this).find("AUTHIDX").text();
								if(authIdx != '') {
									rowsObj.push({
										'grid_idx'		: i+1
										,'FOLDER'		: tab_nm + "(" + folder + ")"
										,'TAB_CODE'		: folder
										,'SCODE_NM'		: scode_nm
										,'DATA_CENTER'	: data_center
									});
								}
								
							});
						}
						var obj = null;
						if(in_out == 1) {
							obj = $("#g_in").data('gridObj');
						} else {
							obj = $("#g_out").data('gridObj');
						}
						obj.rows = rowsObj;
						setGridRows(obj);
						clearGridSelected(obj);
						
					});
					try{viewProgBar(false);}catch(e){console.error(e);}
				}
		, null );
		
		xhr.sendRequest();
	}
	
	function goUserSeqSelect(cd, nm, btn){
	   var data_center = $("select[name='data_center_items']").val();
		
		if(btn == "1"){
			$('#user_nm1').val(nm);
			document.f_s.user_nm.value = nm;
			document.f_s.user_cd.value = cd;
         document.f_s.data_center.value = data_center;
			folderAppGrpList(1);
			
		}else if(btn == "2"){
			$('#user_nm2').val(nm);
			document.f_out.user_nm.value = nm;
			document.f_out.user_cd.value = cd;
         document.f_out.data_center.value = data_center;
			folderAppGrpList(2);
		}
	
		dlClose('dl_tmp3');
	}
	
	function goPrc(flag){
		
		var frm = document.folAppGrpForm;
		var gridObj = null;
		var aSelRow = null;
      	var data_center = $("select[name='data_center_items']").val();
      
		if(flag=='ins_copy') {
			if(isNullInput($('#f_s #user_cd'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[FROM 사용자]","") %>')) return false;
			if(isNullInput($('#f_out #user_cd'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[TO 사용자]","") %>')) return false;
			gridObj	= $('#g_in').data('gridObj');
			aSelRow	= $('#g_in').data('grid').getSelectedRows();
			if(aSelRow.length == 0) {
				alert("추가할 항목을 선택해주세요.");
				return;
			}
			if(!confirm("해당 내용을 추가 하시겠습니까?")) return;
		} else {
			if(isNullInput($('#f_out #user_cd'),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[TO 사용자]","") %>')) return false;
			gridObj	= $('#g_out').data('gridObj');
			aSelRow	= $('#g_out').data('grid').getSelectedRows();
			if(aSelRow.length == 0) {
				alert("삭제할 항목을 선택해주세요.");
				return;
			}
			if(!confirm("해당 내용을 삭제 하시겠습니까?")) return;
		}
		try{viewProgBar(false);}catch(e){console.error(e);}
		
		var strFolSum 				= "";
		var strDataCenterSum 		= "";
		
		if(aSelRow.length>0){
			for(var i=0;i<aSelRow.length;i++){
				var strFol	 		= getCellValue(gridObj,aSelRow[i],'TAB_CODE');
				if(strFolSum != "") strFolSum += ",";
				strFolSum 		+= strFol;
			}
		}
		
		frm.flag.value			= flag;
		frm.folder_auth.value 	= strFolSum;
      	frm.data_center.value    = data_center;
		frm.user_cd.value 		= document.f_out.user_cd.value;
		frm.target				= prcFrameId;
		
		//frm.action	= "<%=sContextPath%>/tWorks.ez?c=ez002_folappgrp_p";
		frm.action		= "<%=sContextPath%>/tWorks.ez?c=ez002_p";
		frm.submit();
		
		try{viewProgBar(false);}catch(e){console.error(e);}
	}
	
   function resetFolderAppGrpList(){
		// 조회한 폴더 목록 초기화 (2024-09-12 김선중)
		
	   goUserSeqSelect('0', '', '1');
	   goUserSeqSelect('0', '', '2');
   }
</script>