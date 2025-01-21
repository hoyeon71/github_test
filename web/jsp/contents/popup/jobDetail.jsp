<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.ghayoun.ezjobs.m.domain.*" %>

<%@include file="/jsp/common/inc/header.jsp"%>
<%@include file="/jsp/common/inc/sessionChkPopup.jsp"%>
<%@include file="/jsp/common/inc/progBar.jsp"%>

<%
	Map<String, Object> paramMap = CommonUtil.collectParameters(request);

	String odate 				= CommonUtil.isNull(paramMap.get("odate"));
	String data_center_code 	= CommonUtil.isNull(paramMap.get("data_center_code"));
	String data_center 			= CommonUtil.isNull(paramMap.get("data_center"));
	String active_net_name 		= CommonUtil.isNull(paramMap.get("active_net_name"));
	
	String order_id 			= CommonUtil.isNull(paramMap.get("order_id"));
	String job 					= CommonUtil.isNull(paramMap.get("job"));

	String gb 					= CommonUtil.isNull(paramMap.get("gb"));
	
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

<link rel="stylesheet" href="<%=sContextPath %>/css/css.css" type="text/css">

<script type="text/javascript" src="<%=sContextPath %>/js/jquery-1.9.0.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery-ui.custom.min.js" ></script>
<script type="text/javascript" src="<%=sContextPath %>/js/common.js" ></script>

<style type="text/css">
	.hover { background-color:#f9f0e1; }
</style>
<script type="text/javascript" >

</script>

<script type="text/javascript" >
<!--
	function goPage(currentPage){
		var frm = document.frm1;
		frm.currentPage.value = currentPage;
		frm.action = "<%=sContextPath %>/mPopup.ez?c=ez004";
		frm.target = "_self";
		frm.submit();
	}

	function fn_changeRowCnt() {
		
		var frm = document.frm1;
	
		// 검색 버튼을 클릭 시에도 RowCnt를 따라가기 위해.
		top.topFrame.document.frm1.rowCnt.value = frm.rowCnt.value;
	
		frm.action = "<%=sContextPath %>/mEm.ez?c=ez007";
		frm.target = "_self";
		frm.submit();
	}
	
	function goJobDetail(gb){
		var frm = document.frm1;
		
		frm.gb.value = gb;
		
		frm.action = "<%=sContextPath %>/mPopup.ez?c=ez004";
		frm.target = "_self";
		frm.submit();
	}
	
	function goPrc(flag,idx) {
		
		var frm = document.frm2;
		
<%-- 	drdog	frm.currentPage.value = "<%=currentPage%>"; --%>
		
		frm.flag.value = flag;
		
		if( flag=='del'){
			frm.seq.value = document.getElementById('seq'+idx).value;
		
			if( !confirm('<%=CommonUtil.getMessage("DEBUG.07") %>') ) return;
		}else{
			if( flag=='ins' || flag=='udt' ){
				if( isNullInput(document.getElementById('memo'+idx),'<%=CommonUtil.getMessageSplit("ERROR.PARAM.01","[내용]","") %>') ) return;
			}
			frm.memo.value = document.getElementById('memo'+idx).value;
			
			if( flag=='udt' ){
				frm.seq.value = document.getElementById('seq'+idx).value;
			}
		}

		frm.target = "if1";
		frm.action = "<%=sContextPath%>/mPopup.ez?c=ez004_p";
		frm.submit();
		
	}
	
	function onOffUdt(idx){
		if( document.getElementById('span_udt'+idx).style.display == 'none' ){
			document.getElementById('span_udt'+idx).style.display = 'inline';
			document.getElementById('span'+idx).style.display = 'none';
		}else{
			document.getElementById('span_udt'+idx).style.display = 'none';
			document.getElementById('span'+idx).style.display = 'inline';
		}
		
	}
//-->
</script>

</head>

<body style='background:#fff;'>

<form id="frm2" name="frm2" method="post" onsubmit="return false;">
	<input type="hidden" name="gb"  value='<%=gb %>' />

	<input type="hidden" name="flag"   />
	
	<input type="hidden" name="data_center"  value='<%=data_center %>' />
	<input type="hidden" name="job"  value='<%=job %>' />
		
	<input type="hidden" name="seq"   />
	<input type="hidden" name="memo"   />
</form>


<form id='frm1' name='frm1' method='post' onsubmit='return false;'>
	<input type="hidden" name="odate" value="<%=odate %>" />
	<input type="hidden" name="data_center_code" value="<%=data_center_code %>" />
	<input type="hidden" name="data_center" value="<%=data_center %>" />
	<input type="hidden" name="active_net_name" value="<%=active_net_name %>" />

	<input type="hidden" name="order_id" value='<%=order_id %>' />
	<input type="hidden" name="job"  value='<%=job %>' />
	
	<input type="hidden" name="gb"  value='<%=gb %>' />

<table style='width:98%;height:99%;border:none;'>
	<tr style='height:10px;'>
		<td style='vertical-align:top;'>
			<h4 class="ui-widget-header ui-corner-all">
				<div class='title_area' style="width:100%; text-align:left;">
					<span><%=CommonUtil.getMessage("POPUP.JOB_MEPPER.TITLE") %>&nbsp;[<%=job%>]</span>					
				</div>				
			</h4>
		</td>
	</tr>
	<tr><td height="5px;"></td></tr>
	<tr>
		<td style="text-align:right;">			
			<span id="btn_close">닫기</span>		
		</td>
	</tr>
	<tr><td height="5px;"></td></tr>
	<tr>
		<td valign="top">	
		<h4 class="ui-widget-header ui-corner-all">		
<%
	JobDetailBean bean		= (JobDetailBean)request.getAttribute("jobDetail");
	if( null != bean && !"".equals(CommonUtil.isNull(bean.getJob())))
	{
		if( !"".equals(CommonUtil.isNull(bean.getUser_cd_1())) 
				|| !"".equals(CommonUtil.isNull(bean.getUser_cd_2())) 
				|| !"".equals(CommonUtil.isNull(bean.getUser_cd_3())) 
				|| !"".equals(CommonUtil.isNull(bean.getUser_cd_4())) )
		{
%>			
			
			<table style="width:100%;">
				<tr>
					<th colspan="6"><div class='cellTitle'>담당자정보</div></th>
				</tr>
				<tr>
					<td width="25%"><div class='cellTitle_3'>부서</div></td>
					<td width="15%"><div class='cellTitle_3'>직책</div></td>
					<td width="15%"><div class='cellTitle_3'>이름</div></td>
					<td width="15%"><div class='cellTitle_3'>Hp</div></td>
					<td width="15%"><div class='cellTitle_3'>Tel</div></td>
					<td width="15%"><div class='cellTitle'>Email</div></td>
				</tr>
<%
			if( !"".equals(CommonUtil.isNull(bean.getUser_cd_1())) ){
%>				
				<tr align="center">
					<td><div class='cellContent'><%=CommonUtil.E2K(bean.getDept_nm_1())%></div></td>
					<td><div class='cellContent'><%=CommonUtil.E2K(bean.getDuty_nm_1())%></div></td>
					<td><div class='cellContent'><%=CommonUtil.E2K(bean.getUser_nm_1())%></div></td>
					<td><div class='cellContent'><%=CommonUtil.E2K(bean.getUser_hp_1())%></div></td>
					<td><div class='cellContent'><%=CommonUtil.E2K(bean.getUser_tel_1())%></div></td>
					<td><div class='cellContent'><%=CommonUtil.E2K(bean.getUser_email_1())%></div></td>
				</tr>
<%
			}
			if( !"".equals(CommonUtil.isNull(bean.getUser_cd_2())) ){
%>	
				<tr align="center">
					<td><div class='cellContent'><%=CommonUtil.E2K(bean.getDept_nm_2())%></div></td>
					<td><div class='cellContent'><%=CommonUtil.E2K(bean.getDuty_nm_2())%></div></td>
					<td><div class='cellContent'><%=CommonUtil.E2K(bean.getUser_nm_2())%></div></td>
					<td><div class='cellContent'><%=CommonUtil.E2K(bean.getUser_hp_2())%></div></td>
					<td><div class='cellContent'><%=CommonUtil.E2K(bean.getUser_tel_2())%></div></td>
					<td><div class='cellContent'><%=CommonUtil.E2K(bean.getUser_email_2())%></div></td>
				</tr>
<%
			}
			if( !"".equals(CommonUtil.isNull(bean.getUser_cd_3())) ){
%>
				<tr align="center">
					<td><div class='cellContent'><%=CommonUtil.E2K(bean.getDept_nm_3())%></div></td>
					<td><div class='cellContent'><%=CommonUtil.E2K(bean.getDuty_nm_3())%></div></td>
					<td><div class='cellContent'><%=CommonUtil.E2K(bean.getUser_nm_3())%></div></td>
					<td><div class='cellContent'><%=CommonUtil.E2K(bean.getUser_hp_3())%></div></td>
					<td><div class='cellContent'><%=CommonUtil.E2K(bean.getUser_tel_3())%></div></td>
					<td><div class='cellContent'><%=CommonUtil.E2K(bean.getUser_email_3())%></div></td>
				</tr>
<%
			}
			if( !"".equals(CommonUtil.isNull(bean.getUser_cd_4())) ){
%>	
				<tr align="center">
					<td><div class='cellContent'><%=CommonUtil.E2K(bean.getDept_nm_4())%></div></td>
					<td><div class='cellContent'><%=CommonUtil.E2K(bean.getDuty_nm_4())%></div></td>
					<td><div class='cellContent'><%=CommonUtil.E2K(bean.getUser_nm_4())%></div></td>
					<td><div class='cellContent'><%=CommonUtil.E2K(bean.getUser_hp_4())%></div></td>
					<td><div class='cellContent'><%=CommonUtil.E2K(bean.getUser_tel_4())%></div></td>
					<td><div class='cellContent'><%=CommonUtil.E2K(bean.getUser_email_4())%></div></td>
				</tr>
<%
			}

		}else{
%>
				<tr>
					<td colspan="6" align="center">
						<%=CommonUtil.getMessage("DEBUG.06")%>
					</td>
				</tr>
<%
		}
%>				
				<tr><td height="5px;"></td></tr>
				<tr>
					<th colspan="6"><div class='cellTitle'>작업설명</div></th>
				</tr>
				<tr>
					<td colspan="6" align="left">
						<%=CommonUtil.E2K(bean.getDescription(),"&nbsp;").replaceAll("\n","<br/>")%>
					</td>
				</tr>
				<tr><td height="5px;"></td></tr>
				<tr>
					<th colspan="6"><div class='cellTitle'>오류 발생시 조치방법</div></th>
				</tr>
				<tr>
					<td colspan="6" align="left">
						<%=CommonUtil.E2K(bean.getError_description(),"&nbsp;").replaceAll("\n","<br/>")%>
					</td>
				</tr>
			</table>
		
<%	
	}
%>		</h4>	
		</td>
	</tr>
	<tr><td height="10px;"></td></tr>
	<tr style='height:10px;'>
		<td style='vertical-align:top;'>
			<h4 class="ui-widget-header ui-corner-all">
				<div class='title_area' style="width:100%; text-align:left;">
					<span><%=CommonUtil.getMessage("POPUP.MEMO.TITLE") %>&nbsp;[<%=job%>]</span>					
				</div>				
			</h4>
		</td>
	</tr>
	<tr>
		<td>
			<h4 class="ui-widget-header ui-corner-all">
			
<%
	int totalCount 		= Integer.parseInt(CommonUtil.isNull(request.getAttribute("totalCount"),"0"));
	List jobMemoList		= (List)request.getAttribute("jobMemoList");
	
	out.println("<table width='100%'>");
	out.println("<tr><td style='height:5px;'></td></tr>");
	out.println("<tr>");
	out.println("<td width='90%'><textarea rows='4' id='memo0' name='memo0' style='width:100%'></textarea></td>");
	out.println("<td >");
	out.println("<img src='"+sContextPath+"/images/btn_04.gif' style='cursor:pointer;' onclick=\"goPrc('ins','0');\" />");
	out.println("</td>");
	out.println("</tr><tr><td style='height:5px;'></td></tr>");
	for( int i=0; null!=jobMemoList && i<jobMemoList.size(); i++ ){
		JobMemoBean jobMemoBean = (JobMemoBean)jobMemoList.get(i);
		
		String userInfo = "["+CommonUtil.E2K(jobMemoBean.getDept_nm())+"] ["+CommonUtil.E2K(jobMemoBean.getDuty_nm())+"] "+CommonUtil.E2K(jobMemoBean.getUser_nm());
		
		out.println("<input type='hidden' id='seq"+(i+1)+"' name='seq"+(i+1)+"' value='"+jobMemoBean.getSeq()+"'>");
		
		out.println("<tr  bgcolor='#dcdcdc'>");
		out.println("<td align='left' style='width:80%;padding-left:5px'>"+userInfo+"</td>");
		out.println("<td align='center' style='width:20%;' >"+CommonUtil.getDateFormat(1,jobMemoBean.getIns_date())+"</td>");
		out.println("</tr>");
		out.println("<tr  >");
		out.println("<td align='left' style='padding:5px' colspan='50' >");
		if( S_USER_CD.equals(jobMemoBean.getUser_cd()) || "99".equals(S_USER_GB) ){
			out.println("<div align='right'>");
			%>
			<a href="javascript:onOffUdt('<%=(i+1)%>');" class="btn_blue_h20">수정</a>
			<a href="javascript:goPrc('del', '<%=(i+1)%>');" class="btn_red_h20">삭제</a>					
			<%
			out.println("</div>");
		}
		out.println("<span id='span"+(i+1)+"'>"+CommonUtil.E2K(jobMemoBean.getMemo(),"&nbsp;").replaceAll("\n","<br/>")+"</span>");
		out.println("<span id='span_udt"+(i+1)+"' style='display:none;'>");
		out.println("<textarea id='memo"+(i+1)+"' name='memo"+(i+1)+"' rows='4' style='width:90%;'>"+CommonUtil.E2K(jobMemoBean.getMemo())+"</textarea>");
		out.println(" <img src='"+sContextPath+"/images/btn_04.gif' align='absmiddle' style='cursor:pointer;' onclick=\"goPrc('udt','"+(i+1)+"');\" />");
		out.println("</span>");
		out.println("</td>");
		out.println("</tr>");
	}
	if( totalCount<1 ) out.println("<tr  bgcolor='#ffffff' ><td colspan='50' height='30' align='center'>"+CommonUtil.getMessage("DEBUG.06")+"</td></tr>");
	
	out.println("</table>");
	if( totalCount>0 ) out.println("<div align='right' style='padding-top:5;padding-right:10;' > [TOTAL : "+totalCount+"]</div>");
//}
%>

	
<%@include file="/jsp/common/inc/paging.jsp"%>

			</h4>	
		</td>
	</tr>
</table>


</form>

<iframe name="if1" id="if1" width="0" height="0"></iframe>
</body>
<script>
	$(document).ready(function(){		
		$("#btn_close").button().unbind("click").click(function(){
			self.close();
		});	
		
	});	
</script>
</html>
