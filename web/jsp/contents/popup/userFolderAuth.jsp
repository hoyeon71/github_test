<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.ghayoun.ezjobs.t.domain.*" %>

<%@include file="/jsp/common/inc/header.jsp"%>
<%@include file="/jsp/common/inc/sessionChkPopup.jsp"%>

<%
	Map<String, Object> paramMap = CommonUtil.collectParameters(request);
	
	List userAuthList		= (List)request.getAttribute("userAuthList");
	List schedTableList		= (List)request.getAttribute("schedTableList");
	String ALL_GB			= (String)request.getAttribute("ALL_GB");
	
	//UserBean bean2 = (UserBean)userAuthList.get(0);
	
	String user_cd 		= CommonUtil.isNull(paramMap.get("user_cd"));
	String user_id 		= CommonUtil.isNull(paramMap.get("user_id"));
	String user_nm 		= CommonUtil.isNull(paramMap.get("user_nm"));
	
	String arr_user_cd 		= CommonUtil.isNull(paramMap.get("arr_user_cd"));
	String arr_user_id 		= CommonUtil.isNull(paramMap.get("arr_user_id"));
	
	//js version 추가하여 캐시 새로고침
	String jsVersion 	= CommonUtil.getMessage("js_version");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Frameset//EN" "http://www.w3.org/TR/html4/frameset.dtd">

<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>EzJOBs 통합배치모니터링 시스템</title>
<link rel="stylesheet" href="<%=sContextPath %>/css/css.css" type="text/css">
<link href="<%=request.getContextPath() %>/css/common.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath() %>/css/custom-theme/jquery-ui.custom.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath() %>/css/custom-theme/jquery-ui.works.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="<%=sContextPath %>/js/jquery-1.9.0.min.js"></script>
<script type="text/javascript" src="<%=sContextPath %>/js/jquery-ui.custom.min.js"></script>
<script type="text/javascript" src="<%=sContextPath %>/js/common.js" ></script>
<script type="text/javascript" src="<%=sContextPath %>/js/popup.js" ></script>
<script type="text/javascript" src="<%=sContextPath %>/js/works_common.js?v=<%=jsVersion %>" ></script>

<style type="text/css">
	.hover { background-color:#e2f4f8; }
</style>
<script type="text/javascript" >
$(document).ready(function(){
	$('.trOver tr:lt(1000)').hover(
		function() { $(this).addClass('hover');},
		function() { $(this).removeClass('hover');}
	);

	$(window).resize(function() {
         $('div.lst_header > table > thead > tr:first').children().each(function(i,v){
                    $(this).width($('div.lst_contents > table > tbody > tr > td:eq('+ i +')').width());
         }); 
	}).resize();
	 
	$("#btn_insert").button().unbind("click").click(function(){
		goPrc();
	});
	
	$("#btn_close").button().unbind("click").click(function(){
		self.close();
	});
});
</script>

<script type="text/javascript" >
	function goPrc() {
		
		var frm = document.frm1;
		
		var obj = document.getElementsByName('checkIdx');
		var folder_auth = "";
		for(var i=0; i<obj.length; i++ ){
			if(obj[i].checked){
				if(folder_auth==""){
					folder_auth = obj[i].value;
				}else{
					folder_auth += (","+obj[i].value);
				}
			}
		}
		
		if( !confirm('선택한 Folder의 권한을 등록하시겠습니까?') ) return;

		frm.folder_auth.value = folder_auth;
		//frm.target = "prcFrame";
		frm.action = "<%=sContextPath%>/tWorks.ez?c=ez002_p";
		frm.submit();
	}
</script>

</head>
<body style="background:#fff;">

<form id="frm1" name="frm1" method="post" onsubmit="return false;">
	
	<input type="hidden" name="flag" 			value='folder_auth' />
	<input type="hidden" name="user_cd" 		value='<%=user_cd %>'/>
	<input type="hidden" name="user_id" 		value='<%=user_id%>'/>
	<input type="hidden" name="arr_user_cd" 	value='<%=arr_user_cd %>'/>
	<input type="hidden" name="arr_user_id" 	value='<%=arr_user_id %>'/> 
	<input type="hidden" name="folder_auth" />
	<input type="hidden" name="ALL_GB" 			value='<%=ALL_GB %>'/>

	<div class="view_area">
		<!-- title -->
		<div class="tit_area">
			<h1><span class="icon"><img src="<%=sContextPath %>/images/icon_sgnb6.png" alt="" /></span>Folder 권한 등록</h1>
			<div class="btn">
				<span id="btn_insert">저장</span>
				<span id="btn_close">닫기</span>
			</div>
		</div>
	</div>
	
	<div class="board_area">
		<div class="lst_area">	
		
		<table class='board_lst gray'>
		<colgroup>
			<col width="10px" />
			<col width="100px" />
		</colgroup>
		<tr >
			<%if(!ALL_GB.equals("Y")){%>
				<th colspan='2' ><%=user_nm%>[<%=user_id%>]</th> 	
			<%}%>
		</tr>
		<tr>
			<th width='10px'><input name='checkIdxAll' type='checkbox' onClick="chkAll('checkIdx');"></th>
			<th width='100px'>폴더<font color='red'>(권한 등록할 Folder 선택)</font></th>
		</tr>

		<%
			for ( int i = 0; schedTableList != null && i < schedTableList.size(); i++ ) {
				
				CommonBean commonBean = (CommonBean)schedTableList.get(i);
				
				String strSchedTable 			= CommonUtil.isNull(commonBean.getSched_table()); 
		%>				
				<tr>
					<td class='td2'>
						<input type='checkbox' name='checkIdx' value='<%=strSchedTable%>'
						
						<%
						if(!ALL_GB.equals("Y")){
							System.out.println("userAuthList.size() : " + (null!=userAuthList));
							if(null!=userAuthList){
								
								for(int k=0;userAuthList.size()>k;k++){
									UserBean bean = (UserBean)userAuthList.get(k);
									if(strSchedTable.equals(CommonUtil.isNull(bean.getFolder_auth()))){							
										out.println(" checked ");
										break;
									}
								}
							} 
						} 
						%>
						
						>
					</td>
					<td class='td2'><%=strSchedTable%></td>
				</tr>
		<%
			}
		%>
		
							
		</table>
		
		</div>
	</div>
</form>

</body>
</html>