<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.ghayoun.ezjobs.t.domain.*"%>

<%@include file="/jsp/common/inc/header.jsp"%>
<%
	response.setHeader("Cache-Control","no-store"); //HTTP 1.1
  	response.setHeader("Pragma","no-cache"); //HTTP 1.0
  	response.setDateHeader ("Expires", 0);
	
%>

<%
	Map<String, Object> paramMap = CommonUtil.collectParameters(request);

	String menu_gb = CommonUtil.getMessage("CATEGORY.GB.02.GB."+CommonUtil.isNull(paramMap.get("menu_gb")));
	String[] arr_menu_gb = menu_gb.split(",");
	
	String fileName = CommonUtil.isNull(arr_menu_gb[0]);
	response.setHeader("Content-Type", "application/vnd.ms-xls;charset=UTF-8");
	response.setHeader("Content-Disposition", "attachment;filename="+URLEncoder.encode(fileName,"UTF-8")+".xls");   
	response.setHeader("Content-Description", "JSP Generated Data");
	
	List defJobList				= (List)request.getAttribute("defJobList");
	List ctmOdateList			= (List)request.getAttribute("ctmOdateList");
	
	String strCtmOdate = "";
	if ( ctmOdateList != null ) {
		for( int i=0; null!=ctmOdateList && i<ctmOdateList.size(); i++ ){
			CommonBean bean = (CommonBean)ctmOdateList.get(i);
	
			strCtmOdate = CommonUtil.E2K(bean.getCtm_odate());
		}
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />

</head>

<body>

<%	
	out.println("<table border='1' >");
	out.println("<tr align='center' >");
	out.println("<td >순번</td>");
	out.println("<td >APP</td>");
	out.println("<td >GRP</td>");
	out.println("<td >작업명</td>");
	out.println("<td >작업설명</td>");
	out.println("<td >작업 Order</td>");
	out.println("</tr>");
	
	for( int i=0; null!=defJobList && i<defJobList.size(); i++ ){
		com.ghayoun.ezjobs.t.domain.DefJobBean bean = (com.ghayoun.ezjobs.t.domain.DefJobBean)defJobList.get(i);
		
		String strTableId		= CommonUtil.isNull(bean.getTable_id());
		String strJobId			= CommonUtil.isNull(bean.getJob_id());
		String strSchedTable	= CommonUtil.isNull(bean.getSched_table());
		String strJobName		= CommonUtil.isNull(bean.getJob_name());


		out.println("<tr align='center' >");	
		
		out.println("<td >"+(i+1)+"</td>");
		out.println("<td style='mso-number-format:\\@;'>"+CommonUtil.isNull(bean.getApplication()+"</td>"));
		out.println("<td style='mso-number-format:\\@;'>"+CommonUtil.isNull(bean.getGroup_name()+"</td>"));
		out.println("<td style='mso-number-format:\\@;'>"+CommonUtil.E2K(bean.getJob_name(),bean.getMemname())+"</td>");
		out.println("<td style='mso-number-format:\\@;'>"+CommonUtil.isNull(bean.getDescription()+"</td>"));
		out.println("<td style='mso-number-format:\\@;'>"+CommonUtil.getDateFormat(1, strCtmOdate)+" ~ "+CommonUtil.getDateFormat(1, strCtmOdate)+"</td>");
		
		out.println("</tr>");
		
		out.flush();
	}
	out.println("</table>");
	
%>

</body>
</html>
