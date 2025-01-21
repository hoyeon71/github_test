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
	String r_code = CommonUtil.isNull(rMap.get("r_code"));
	String r_msg = "";
	
	if("-2".equals(r_code)){
		r_msg = CommonUtil.isNull(rMap.get("r_msg"));
		r_msg = r_msg.replaceAll("\"","").replaceAll("'","");
	}else{
		r_msg = CommonUtil.getMessage(CommonUtil.isNull(rMap.get("r_msg")));
	}
	
	String rType = CommonUtil.isNull(rMap.get("rType"));
	/*
	if( "fault_type".equals(rType)){
		Fault_type t = (Fault_type)rMap.get("rObject");
		
		Error_type[] error = t.getError_list();
		String errorMsg = CommonUtil.getMessage("ERROR.01") + " : ";
		if (error != null){
			for (int i=0; i< error.length ; i++){
				errorMsg += ( ("".equals(errorMsg))? error[i].getError_message():" "+error[i].getError_message() );
			}
			r_msg = errorMsg.replaceAll("'","");
		}
	}
	*/
	
	if( c.equals("ez004_p") ){
		String currentPage = CommonUtil.isNull(paramMap.get("currentPage"),"1");
		String flag 	= CommonUtil.isNull(paramMap.get("flag"));
		String gb 		= CommonUtil.isNull(paramMap.get("gb"));
		
		out.println("<script type='text/javascript'>");
		out.println("try{top.viewProgBar(false);}catch(e){}");
		out.println("alert('"+r_msg+"');");
		if( "1".equals(r_code) ){
			out.println("try{top.viewProgBar(false);}catch(e){}");
			if("udt".equals(flag)){
				out.println("top.goPage("+currentPage+");");
			}else{
				out.println("top.goPage(1);");
			}
		}
		out.println("</script>");
		
	} else if( c.equals("ez014_p") ) {
		
		out.println("<script type='text/javascript'>");		
		out.println("alert('"+r_msg+"');");		
		out.println("location.href='"+sContextPath+"/mPopup.ez?c=ez014&order_id="+CommonUtil.isNull(paramMap.get("order_id"))+"&data_center_code="+CommonUtil.isNull(paramMap.get("data_center_code"))+"&active_net_name="+CommonUtil.isNull(paramMap.get("active_net_name"))+"&search_odate="+CommonUtil.isNull(paramMap.get("search_odate"))+"';");		
		out.println("</script>");
	} else if( c.equals("ez008") ) {
		
		out.println("<script type='text/javascript'>");		
		if( "1".equals(r_code) ){
			out.println("alert('처리완료');");
		}else{
			out.println("alert('컨디션 발행 실패');");
		}
		out.println("window.close();");
		out.println("</script>");
	}
%>
</body>
</html>
