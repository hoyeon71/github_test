<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@include file="/jsp/common/inc/header.jsp"%>

<%
	Map<String, Object> paramMap 	= CommonUtil.collectParameters(request); 
	
	List<Map<String,String>> srList	= (List<Map<String,String>>)request.getAttribute("srList");
	
	String currentPage 		= CommonUtil.isNull(paramMap.get("currentPage"), "1");
	
	String strSearchText 	= CommonUtil.isNull(paramMap.get("search_text"));	
	String strSearchGubun 	= CommonUtil.isNull(paramMap.get("search_gubun"));	
	
	String s_search_date 	= CommonUtil.isNull(paramMap.get("s_search_date"));
	String e_search_date 	= CommonUtil.isNull(paramMap.get("e_search_date"));
	
	int totalCount 			= Integer.parseInt(CommonUtil.isNull(request.getAttribute("totalCount"),"0"));
	int rowSize 			= Integer.parseInt(CommonUtil.isNull(request.getAttribute("rowSize")));
	
	//js version 추가하여 캐시 새로고침
	String jsVersion 		= CommonUtil.getMessage("js_version");
%>

<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>EzRA</title>
<link href="<%=sContextPath %>/css/common.css" rel="stylesheet" type="text/css" />
<link href="<%=sContextPath %>/css/custom-theme/jquery-ui.custom.css" rel="stylesheet" type="text/css" />
<link href="<%=sContextPath %>/css/custom-theme/jquery-ui.works.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="<%=sContextPath %>/css/css.css" type="text/css">

<script type="text/javascript" src="<%=sContextPath %>/js/jquery.min.js"></script>
<script type="text/javascript" src="<%=sContextPath %>/js/jquery-ui.custom.min.js" ></script>
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
	
	$('#s_search_date').on('keypress', function(event) {
    	
        var code = event.keyCode;
        
        if ((code >= 48 && code <= 57) || (code === 9 || code === 36 || code === 35 || code === 37 || code === 39 || code === 8 || code === 46)) {
                return true;
            } else {
                return false;
            }
	}).on('keyup', function(event) {
 	
        var s_search_date = $('#s_search_date').val();
        
        s_search_date = s_search_date.replace(/[^0-9]/g, '');
        var reSsearchDate = replaceAll(s_search_date,'/','');
        if(reSsearchDate.length <= 4) {
        } else if(reSsearchDate.length == 6) {
              //  $('#s_search_date').val(reSsearchDate.substr(0,4) + "/" + reSsearchDate.substr(4));
        } else if(reSsearchDate.length == 8) {
     	   if (!(event.keyCode >= 37 && event.keyCode <= 40)){
                $('#s_search_date').val(reSsearchDate.substr(0,4) + "/" + reSsearchDate.substr(4,2) + "/" + reSsearchDate.substr(6,2));
     	   }
        }
        if (reSsearchDate.length == 8 && event.keyCode == 13) {
        	goSearch();
        }
	});
	
	$('#e_search_date').on('keypress', function(event) {
 	
     var code = event.keyCode;
     
     if ((code >= 48 && code <= 57) || (code === 9 || code === 36 || code === 35 || code === 37 || code === 39 || code === 8 || code === 46)) {
             return true;
         } else {
             return false;
         }
	}).on('keyup', function(event) {
	
     var e_search_date = $('#e_search_date').val();
     
     e_search_date = e_search_date.replace(/[^0-9]/g, '');
     var reEsearchDate = replaceAll(e_search_date,'/','');
     if(reEsearchDate.length <= 4) {
     } else if(reEsearchDate.length == 6) {
           //  $('#e_search_date').val(reEsearchDate.substr(0,4) + "/" + reEsearchDate.substr(4));
     } else if(reEsearchDate.length == 8) {
     	if (!(event.keyCode >= 37 && event.keyCode <= 40)){
             $('#e_search_date').val(reEsearchDate.substr(0,4) + "/" + reEsearchDate.substr(4,2) + "/" + reEsearchDate.substr(6,2));
     	}
     }
     if (reEsearchDate.length == 8 && event.keyCode == 13) {
    	 goSearch();
     }
	});
	$("#s_search_date").val('<%=s_search_date%>').unbind('click').click(function() {
		dpCal(this.id,'yymmdd','');
	});
	$("#e_search_date").val('<%=e_search_date%>').unbind('click').click(function() {
		dpCal(this.id,'yymmdd','');
	});
});
</script>

<script type="text/javascript" >

function goPage(currentPage) {
	
	var frm = document.frm1;
	
	frm.currentPage.value = currentPage;
	frm.action = "<%=sContextPath %>/tPopup.ez?c=popSr";
	frm.target = "_self";
	
	frm.submit();
}

function fn_changeRowCnt() {
	
	var frm = document.frm1;

	// 검색 버튼을 클릭 시에도 RowCnt를 따라가기 위해.
	//top.topFrame.document.frm1.rowCnt.value = frm.rowCnt.value;

	frm.action = "<%=sContextPath %>/tPopup.ez?c=popSr";
	frm.target = "_self";
	frm.submit();
}

function fn_sr_click(sr_id){
	if(sr_id=='미존재'){
		alert('SR제목을 입력하세요.')
		return;
	}
	
	opener.document.getElementById('sr_id').value = sr_id;
	top.close();
}

function goSearch(){

	var form = document.frm1;
	
	form.action = "<%=sContextPath%>/tPopup.ez?c=popSr";
	form.target = "_self";
	form.submit();	
}

function popupCalender(type, name, idx) {
	var vUrl = "<%=sContextPath %>/common.ez?c=ez000&a=common.popup.calender&type="+type+"&name="+name+"&idx="+idx;
	openPopupCenter(vUrl,"popupCalender",600,400);
	
}


</script>

</head>

<body style='background:#fff;overflow: hidden;'>

	<form id="frm1" name="frm1" method="post" onsubmit="return false;">
			<input type="hidden" id="currentPage" name="currentPage" />
			<div class="search_area">
				<h1><span class="icon"><img src="<%=sContextPath%>/imgs/icon_sgnb3.png" alt="" /></span>SR 목록</h1>
				<span class="fRight"><a href="JavaScript:goSearch();" class="btn_white_h24">검색</a></span>
				<table class="board_lst_sch blue" summary="검색">
					<caption>검색</caption>
					<colgroup>
						<col width="50px" />
						<col width="200px" />
						<col width="50px" />
						<col width="200px" />
					</colgroup>
					<tbody>
						<tr>
							<th>조건</th>
							<td>
							<!-- 
							m.put("cam_tag", CommonUtil.isNull(rs.getString("cam_tag")));
							m.put("tas_id", CommonUtil.isNull(rs.getString("tas_id")));
							m.put("tas_name", CommonUtil.isNull(rs.getString("tas_name")));
							m.put("cam_req_dttm", CommonUtil.isNull(rs.getString("cam_req_dttm")));
							m.put("req_title", CommonUtil.isNull(rs.getString("req_title")));
							m.put("cam_req_emp_id", CommonUtil.isNull(rs.getString("cam_req_emp_id")));
							m.put("cam_req_dpt_id", CommonUtil.isNull(rs.getString("cam_req_dpt_id")));
							m.put("cla_cd", CommonUtil.isNull(rs.getString("cla_cd")));
							m.put("cla_name", CommonUtil.isNull(rs.getString("cla_name")));
							m.put("bf_agree_dt", CommonUtil.isNull(rs.getString("bf_agree_dt")));
							m.put("at_agree_dt", CommonUtil.isNull(rs.getString("at_agree_dt")));
							 -->
								<select id='search_gubun' name='search_gubun'  >
									<option value='cam_tag' 		<%= strSearchGubun.equals("cam_tag") ? "selected" : "" %> >SR번호</option>
									<option value='req_title' 	<%= strSearchGubun.equals("req_title") ? "selected" : "" %> >SR제목</option>
									<option value='cam_req_emp_id' 	<%= strSearchGubun.equals("cam_req_emp_id") ? "selected" : "" %> >SR요청자사번</option>
								</select>
								<input type='text' class='input' name='search_text' value='<%=strSearchText%>' maxlength="10" size='20' onKeyPress="if(event.keyCode==13) goSearch();" />
							</td>
							<th>SR요청일자</th>
							<td>
								<input type="text" name="s_search_date" id="s_search_date" value="<%=s_search_date %>" class="ime_readonly" style="width:75px;" maxlength="10" /> ~
								<input type="text" name="e_search_date" id="e_search_date" value="<%=e_search_date %>" class="ime_readonly" style="width:75px;" maxlength="10" />
							
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		
<div class="board_area">
		<div class="lst_area">		
		<%
			if( totalCount>0 ) out.println("<div align='left' style='padding-top:5;padding-left:10;' >[등록현황 : "+totalCount+"]</div>");
		%>
		
<div class="lst_contents" style="overflow-y: auto; height: 650px;">
	<table class="board_lst blue">
		<colgroup>
			<col width="40px" />
			<col width="100px" />
			<col width="%" />
			<col width="80px" />
			<col width="150px" />
			<col width="120px" />
		</colgroup>
		<thead>
			<tr>
				<th>순번</th>
				<th>SR번호</th>
				<th>SR제목</th>
				<th>SR요청자사번</th>
				<th>SR유형</th>
				<th>SR요청일자</th>
			</tr>
		</thead>
		<tbody class="trOver">
		<%
		/*
		m.put("cam_tag", CommonUtil.isNull(rs.getString("cam_tag")));
		m.put("tas_id", CommonUtil.isNull(rs.getString("tas_id")));
		m.put("tas_name", CommonUtil.isNull(rs.getString("tas_name")));
		m.put("cam_req_dttm", CommonUtil.isNull(rs.getString("cam_req_dttm")));
		m.put("req_title", CommonUtil.isNull(rs.getString("req_title")));
		m.put("cam_req_emp_id", CommonUtil.isNull(rs.getString("cam_req_emp_id")));
		m.put("cam_req_dpt_id", CommonUtil.isNull(rs.getString("cam_req_dpt_id")));
		m.put("cla_cd", CommonUtil.isNull(rs.getString("cla_cd")));
		m.put("cla_name", CommonUtil.isNull(rs.getString("cla_name")));
		m.put("bf_agree_dt", CommonUtil.isNull(rs.getString("bf_agree_dt")));
		m.put("at_agree_dt", CommonUtil.isNull(rs.getString("at_agree_dt")));
		*/
		
		out.print("<tr style='cursor:pointer;'  >");
		
		out.println("<td style='text-align:center;'>&nbsp;</td>");
		out.println("<td style='text-align:center;'>미존재</td>");
		out.println("<td style='text-align:center;'><select id='c_title' style='width:40%' onchange=\"document.getElementById('i_title').value=this.value\">");
		out.println("<option value=''>직접입력</option>");
		out.println("</select><input type='text' id='i_title' class='input' style='width:59%;' /></td>");
		out.println("<td style='text-align:center;'><a href=\"JavaScript:fn_sr_click('미존재');\" class='btn_white_h24'>적용</a></td>");
		out.println("<td style='text-align:center;'>&nbsp;</td>");
		out.println("<td style='text-align:center;'>&nbsp;</td>");
		
		out.println("</tr>");
		
		for( int i=0; null!=srList && i<srList.size(); i++ ){
			Map<String,String> m = srList.get(i);
			
			// 게시판 순번 계산.
			int row_num = i + ((Integer.parseInt(currentPage)-1) * rowSize) +1;
			
			out.print("<tr onclick=\"fn_sr_click('"+m.get("sr_id")+"');\" style='cursor:pointer;'  >");
			
			out.println("<td style='text-align:center;'>"+(row_num)+"</td>");
			out.println("<td style='text-align:center;'>"+m.get("sr_id")+"</td>");
			out.println("<td style='text-align:center;'>"+m.get("title")+"</td>");
			out.println("<td style='text-align:center;'>"+m.get("req_user_id")+"</td>");
			out.println("<td style='text-align:center;'>"+m.get("req_type")+"</td>");
			out.println("<td style='text-align:center;'>"+CommonUtil.getDateFormat(1,m.get("req_dt"))+"</td>");
			
			out.println("</tr>");
		}
		if( totalCount<1 ) out.println("<tr bgcolor='#ffffff' ><td colspan='6' height='30' align='center'>"+CommonUtil.getMessage("DEBUG.06")+"</td></tr>");
		%>
						
		</tbody>
		</table>
		
</div>
<%@include file="/jsp/common/inc/progBar.jsp"  %>
</div>
</div>

</form>

</body>
</html>
