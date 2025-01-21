<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.ghayoun.ezjobs.m.domain.*"%>

<%@include file="/jsp/common/inc/header.jsp"%>
<%@include file="/jsp/common/inc/sessionChk.jsp"%>

<%
	Map<String, Object> paramMap = CommonUtil.collectParameters(request);
	
	List emCommonList = (List)request.getAttribute("emCommonList");
	//List emDbList = (List)request.getAttribute("emDbList");
	List ccmPocessList = (List)request.getAttribute("ccmPocessList");
	List emProcessList = (List)request.getAttribute("emProcessList");
	List emProcessDetailList = (List)request.getAttribute("emProcessDetailList");
	List agentList = (List)request.getAttribute("agentList");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Frameset//EN" "http://www.w3.org/TR/html4/frameset.dtd">

<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>EzJOBs 통합배치모니터링 시스템</title>
<link rel="stylesheet" href="<%=sContextPath %>/css/css.css" type="text/css">

<script type="text/javascript" src="<%=sContextPath %>/js/jquery-1.9.0.min.js"></script>
<script type="text/javascript" src="<%=sContextPath %>/js/common.js" ></script>
<script type="text/javascript" src="<%=sContextPath %>/js/popup.js" ></script>

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
});
</script>

<script type="text/javascript" >


</script>

</head>
<body style="background:#fff;">

<form id="frm1" name="frm1" method="post" onsubmit="return false;">
	
	<div class="write_area">		
		<div class="content">
		
			<div class="detail_write">
				<div class="lst_contents3">
					<%	
						out.println("<div style='font-size:13px;font-weight:bold;padding:5 5 5 5' class='tLeft'>1. CONTROL-M 정보</div>");
						out.println("<table class='board_write gray'>");
						out.println("<tr >");
						
						out.println("<th >CTM명</th>");
						out.println("<th >호스트</th>");
						out.println("<th >CTM버전</th>");
						out.println("<th >TIME ZONE</th>");
						out.println("<th >NEWDAY시간</th>");
						out.println("<th >NEWDAY</th>");
						
						out.println("</tr>");
						
						
						for( int i=0; null!=emCommonList && i<emCommonList.size(); i++ ){
							CtmInfoBean bean = (CtmInfoBean)emCommonList.get(i);
							
							out.println("<tr >");
							
							out.println("<td >"+bean.getData_center()+"</td>");
							out.println("<td >"+bean.getCtm_host_name()+"</td>");
							out.println("<td >"+bean.getControl_m_ver()+"</td>");
							out.println("<td >"+bean.getTime_zone()+"</td>");
							out.println("<td >"+bean.getCtm_daily_time()+"</td>");
							out.println("<td >"+bean.getCtm_odate()+"</td>");
							
							out.println("</tr>");
						}
						if( !(null!=emCommonList && 0<emCommonList.size()) ) out.println("<tr  bgcolor='#ffffff' ><td colspan='50' height='30' style='text-align:center'>"+CommonUtil.getMessage("DEBUG.06")+"</td></tr>");
						
						out.println("</table>");
						
					
						out.println("<div style='font-size:13px;font-weight:bold;padding:5 5 5 5' class='tLeft'>2. CONTROL-M Agent 정보</div>");
						out.println("<table class='board_write gray'>");
						out.println("<tr >");
						
						out.println("<th>AGENT</th>");
						out.println("<th>상태</th>");
						out.println("<th >호스트명</th>");
						out.println("<th >버전</th>");
						out.println("<th >OS명</th>");
						out.println("<th >플랫폼</th>");
						out.println("<th >마지막 업데이트</th>");
						
						out.println("</tr>");
						
						
						for( int i=0; null!=agentList && i<agentList.size(); i++ ){
							CtmInfoBean bean = (CtmInfoBean)agentList.get(i);
							
							String strAgstat 	= CommonUtil.isNull(bean.getAgstat());
							
							String strStatus 	= "";		
							if ( strAgstat.equals("V") ) {
								strStatus = "정상";
							} else if ( strAgstat.equals("D") ) {
								strStatus 	= "비정상";
							} else {
								strStatus = "기타(정상X)";
							}
							
							String strClassName = "";
							if ( !strAgstat.equals("V") ){
				// 				strClassName = "tbl_list_blue";
							out.println("<tr style='background:#F2CB61' >");
										
							}/*  else if ( (i%2) == 0 ) {
								strClassName = "tbl_list";
							} else {
								strClassName = "tbl_list_bg";
							} */
							
							out.println("<td >"+bean.getNodeid()+"</td>");
							out.println("<td >"+strStatus+"</td>");
							out.println("<td >"+bean.getHostname()+"</td>");
							out.println("<td >"+bean.getVersion()+"</td>");
							out.println("<td >"+bean.getOs_name()+"</td>");
							out.println("<td >"+bean.getPlatform()+"</td>");
							out.println("<td >"+bean.getLast_upd()+"</td>");
							
							out.println("</tr>");
						}
						if( !(null!=emProcessList && 0<emProcessList.size()) ) out.println("<tr  bgcolor='#ffffff' ><td colspan='50' height='30' style='text-align:center'>"+CommonUtil.getMessage("DEBUG.06")+"</td></tr>");
						
						out.println("</table>");
						
						/*
						
						out.println("<div >&nbsp;</div>");
						out.println("<div style='font-size:13px;font-weight:bold;padding:5 5 5 5'>2. EM DB 정보</div>");
						out.println("<table width='100%' border='0' cellpadding='1' cellspacing='1' bgcolor='#dcdcdc' >");
						out.println("<tr class='tbl_list_title'  >");
						
						out.println("<td >Tablespace</td>");
						out.println("<td >Size(MB)</td>");
						out.println("<td >Free(MB)</td>");
						out.println("<td >Used(%)</td>");
						
						out.println("</tr>");
						
						for( int i=0; null!=emDbList && i<emDbList.size(); i++ ){
							CtmInfoBean bean = (CtmInfoBean)emDbList.get(i);
							
							out.println("<tr "+( ((i%2)==0)? " class='tbl_list' " : "class='tbl_list_bg'" )+" >");
							
							out.println("<td >"+bean.getTablespace_name()+"</td>");
							out.println("<td >"+bean.getM_bytes()+"</td>");
							out.println("<td >"+bean.getFree()+"</td>");
							out.println("<td >"+bean.getUsed()+"</td>");
							
							out.println("</tr>");
						}
						if( !(null!=emDbList && 0<emDbList.size()) ) out.println("<tr  bgcolor='#ffffff' ><td colspan='50' height='30' align='center'>"+CommonUtil.getMessage("DEBUG.06")+"</td></tr>");
						
						out.println("</table>");	
						*/
						
						out.println("<div style='font-size:13px;font-weight:bold;padding:5 5 5 5' class='tLeft'>3. CONTROL-M/EM Process 정보</div>");
						out.println("<table class='board_write gray'>");
						out.println("<tr >");
						
						out.println("<th>이름</th>");
						out.println("<th >메세지 </th>");
						out.println("<th >Check 시간 </th>");
						out.println("<th >마지막 변경  시간</th>");
						out.println("<th >현재 상태</th>");
						out.println("<th >DESIRED 상태</th>");
						
						out.println("</tr>");
						
						
						for( int i=0; null!=emProcessList && i<emProcessList.size(); i++ ){
							CtmInfoBean bean = (CtmInfoBean)emProcessList.get(i);
							
							out.println("<tr >");
							
							out.println("<td >"+bean.getPname()+"</td>");
							out.println("<td >"+bean.getFree_text()+"</td>");
							out.println("<td >"+bean.getInterval()+"</td>");
							out.println("<td >"+bean.getU_time()+"</td>");
							out.println("<td >"+bean.getPstate()+"</td>");
							out.println("<td >"+bean.getDesired_state()+"</td>");
							
							out.println("</tr>");
						}
						if( !(null!=emProcessList && 0<emProcessList.size()) ) out.println("<tr  bgcolor='#ffffff' ><td colspan='50' height='30' style='text-align:center'>"+CommonUtil.getMessage("DEBUG.06")+"</td></tr>");
						
						out.println("</table>");
						
						
						
						out.println("<div style='font-size:13px;font-weight:bold;padding:5 5 5 5' class='tLeft'>4. CONTROL-M/EM 하위 PROCESS 정보</div>");
						out.println("<table class='board_write gray'>");
						out.println("<tr >");
						
						out.println("<th >CONTROLM/EM</th>");
						out.println("<th >프로세서</th>");
						out.println("<th >분류</th>");
						out.println("<th >PID 정보</th>");
						out.println("<th >PORT 정보</th>");
						
						out.println("</tr>");
						
						
						for( int i=0; null!=emProcessDetailList && i<emProcessDetailList.size(); i++ ){
							CtmInfoBean bean = (CtmInfoBean)emProcessDetailList.get(i);
							
							out.println("<tr >");
							
							out.println("<td >"+bean.getMachine_name()+"</td>");
							out.println("<td >"+bean.getCprocess_name()+"</td>");
							out.println("<td >"+bean.getCprocess_type()+"</td>");
							out.println("<td >"+bean.getPid()+"</td>");
							out.println("<td >"+bean.getCtlport()+"</td>");
							
							out.println("</tr>");
						}
						if( !(null!=emProcessDetailList && 0<emProcessDetailList.size()) ) out.println("<tr  bgcolor='#ffffff' ><td colspan='50' height='30' style='text-align:center'>"+CommonUtil.getMessage("DEBUG.06")+"</td></tr>");
						
						out.println("</table>");
						
						
						
						out.println("<div style='font-size:13px;font-weight:bold;padding:5 5 5 5' class='tLeft'>5. CONTROL-M Configuration PROCESS 정보</div>");
						out.println("<table class='board_write gray'>");
						out.println("<tr >");
						
						out.println("<th >CONTROLM/EM</th>");
						out.println("<th >프로세서</th>");
						out.println("<th >분류</th>");
						out.println("<th >PID 정보</th>");
						out.println("<th >PORT 정보</th>");
						
						out.println("</tr>");
						
						
						for( int i=0; null!=ccmPocessList && i<ccmPocessList.size(); i++ ){
							CtmInfoBean bean = (CtmInfoBean)ccmPocessList.get(i);
							
							String cprocess_type = (String)CommonUtil.isNull(bean.getCprocess_type());
							
							out.println("<tr "+( ((i%2)==0)? " class='tbl_list' " : "class='tbl_list_bg'" )+" >");
							
							out.println("<td >"+bean.getMachine_name()+"</td>");
							if ("CONTROLM Configuration Server".equals(cprocess_type)) {
								out.println("<td >ecs.cms</td>");
							} else if ("CONTROLM Configuration Server GATE".equals(cprocess_type)) {
								out.println("<td >ecs.cmsg</td>");		
							} else if ("CONTROLM/EM Configuration Agent".equals(cprocess_type)) {	
								out.println("<td >ecs.maintag</td>");
							}else{
								out.println("<td >&nbsp;</td>");
							}
							out.println("<td >"+bean.getCprocess_type()+"</td>");
							out.println("<td >"+bean.getPid()+"</td>");
							out.println("<td >"+bean.getCtlport()+"</td>");
							
							out.println("</tr>");
						}
						if( !(null!=ccmPocessList && 0<ccmPocessList.size()) ) out.println("<tr  bgcolor='#ffffff' ><td colspan='50' height='30' style='text-align:center'>"+CommonUtil.getMessage("DEBUG.06")+"</td></tr>");
						
						out.println("</table>");
						
						
						/*
						out.println("<div >&nbsp;</div>");
						out.println("<div style='font-size:13px;font-weight:bold;padding:5 5 5 5'>6. CONTROL-M/AGENT 상태</div>");
						out.println("<table width='100%' border='0' cellpadding='1' cellspacing='1' bgcolor='#dcdcdc' >");
						out.println("<tr class='tbl_list_title'  >");
						
						out.println("<td >HOST</td>");
						out.println("<td >상태</td>");
						out.println("<td >마지막 확인 시간</td>");
						
						out.println("</tr>");
						
						
						for( int i=0; null!=agentList && i<agentList.size(); i++ ){
							CtmInfoBean bean = (CtmInfoBean)agentList.get(i);
							
							out.println("<tr "+( ((i%2)==0)? " class='tbl_list' " : "class='tbl_list_bg'" )+" >");
							
							out.println("<td >"+bean.getAgname()+"</td>");
							out.println("<td >"+bean.getAgvalue()+"</td>");
							out.println("<td >"+bean.getAglastup()+"</td>");
							
							out.println("</tr>");
						}
						if( !(null!=agentList && 0<agentList.size()) ) out.println("<tr  bgcolor='#ffffff' ><td colspan='50' height='30' align='center'>"+CommonUtil.getMessage("DEBUG.06")+"</td></tr>");
						
						out.println("</table>");
						*/
					%>
			</div>
		</div>
	</div>
</div>
</form>

</body>
</html>