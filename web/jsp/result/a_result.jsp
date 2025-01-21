<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@include file="/jsp/common/inc/header.jsp"%>

<%
  response.setHeader("Cache-Control","no-store"); //HTTP 1.1
  response.setHeader("Pragma","no-cache"); //HTTP 1.0
  response.setDateHeader ("Expires", 0);
%>

<%
	Map<String, Object> paramMap = CommonUtil.collectParameters(request);
	
	String c = CommonUtil.isNull(paramMap.get("c"));
	
	String currentPage = CommonUtil.isNull(paramMap.get("currentPage"));	
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />

<script type="text/javascript" src="<%=sContextPath %>/js/common.js" ></script>

<script type="text/javascript" >
<!--

//-->
</script>
</head>

<body>



<%	
	Map rMap 		= (Map)request.getAttribute("rMap");
	String r_code 	= CommonUtil.isNull(rMap.get("r_code"));
	String r_msg 	= "";
	
	if("-2".equals(r_code)){
		r_msg = CommonUtil.isNull(rMap.get("r_msg"));
		r_msg = r_msg.replaceAll("\"","").replaceAll("'","");
	}else{		
		r_msg = CommonUtil.getMessage(CommonUtil.isNull(rMap.get("r_msg")));		
	}
	
	
	if(c.equals("ez003_p") ){
		out.println("<script type='text/javascript'>");
		out.println("try{parent.viewProgBar(false);}catch(e){}");
		
		if( "1".equals(r_code) ){
			out.println("alert('"+r_msg+"');");
			out.println("parent.dlClose('dl_tmp1');");
			out.println("parent.parent.doErrorCntChk();"); // 메인 상단의 오류건수와 동기화
			out.println("parent.alertErrorList();");
		}else{
			out.println("alert('"+r_msg+"');");
		}
		
		out.println("</script>");
	}
	
	if(c.equals("ez003_p_all") ){
		out.println("<script type='text/javascript'>");
		out.println("try{parent.viewProgBar(false);}catch(e){}");

		if( "1".equals(r_code) ){
			out.println("alert('"+r_msg+"');");
// 			out.println("parent.dlClose('dl_tmp1');");
			out.println("parent.dlClose('popAdminTitleInput');");
			out.println("parent.parent.doErrorCntChk();"); // 메인 상단의 오류건수와 동기화
			out.println("parent.alertErrorList();");
		}else{
			out.println("alert('"+r_msg+"');");
		}
		
		out.println("</script>");
	}
%>
</body>
</html>
