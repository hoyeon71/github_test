<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.ghayoun.ezjobs.t.domain.*" %>

<%@include file="/jsp/common/inc/header.jsp"%>
<%
  response.setHeader("Cache-Control","no-store"); //HTTP 1.1
  response.setHeader("Pragma","no-cache"); //HTTP 1.0
  response.setDateHeader ("Expires", 0);
%>

<%
	Map<String, Object> paramMap = CommonUtil.collectParameters(request);
	
	String fileName = "전체결재현황";
	
	response.setHeader("Content-Type", "application/vnd.ms-xls;charset=UTF-8");
	response.setHeader("Content-Disposition", "attachment;filename="+URLEncoder.encode(fileName,"UTF-8")+".xls");   
	response.setHeader("Content-Description", "JSP Generated Data");
	
	List allDocInfoList	= (List)request.getAttribute("allDocInfoList");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />


</head>

<body>

	<table border='1' >
		<tr align='center'>
			<td>순번</td>
			<td>문서번호</td>
			<td>문서구분</td>
			<td>의뢰사유</td>
			<td>작업명</td>
			<td>작업설명</td>
			<td width="180">의뢰일자</td>
			<td width="180">의뢰자</td>
		</tr>
		<%	
			for( int i=0; null!=allDocInfoList && i<allDocInfoList.size(); i++ ){
				
				DocInfoBean bean = (DocInfoBean)allDocInfoList.get(i);
				
				String strDocCd 		= CommonUtil.isNull(bean.getDoc_cd(), "");
				String strDocGb 		= CommonUtil.getMessage("DOC.GB."+bean.getDoc_gb());
				String strTitle 		= CommonUtil.E2K(bean.getTitle(), "");
				String strJobName 		= CommonUtil.E2K(bean.getJob_name(), "");
				String strDescription 	= CommonUtil.E2K(bean.getDescription(), "");
				String strStateCd 		= CommonUtil.getMessage("DOC.STATE."+bean.getState_cd());
				String strApprovalDate 	= CommonUtil.getDateFormat(1,bean.getApproval_date(),"&nbsp;");
				String strDraftDate 	= CommonUtil.getDateFormat(1,bean.getDraft_date());
				String userInfo 		= "["+CommonUtil.E2K(bean.getDept_nm())+"] ["+CommonUtil.E2K(bean.getDuty_nm())+"] "+CommonUtil.E2K(bean.getUser_nm());
		%>
				<tr align='center' >
					<td style='mso-number-format:\\@;' ><%=(i+1)%></td>
					<td style='mso-number-format:\\@;' ><%=strDocCd%></td>
					<td style='mso-number-format:\\@;' ><%=strDocGb%></td>
					<td style='mso-number-format:\\@;' ><%=strTitle%></td>
					<td style='mso-number-format:\\@;' ><%=strJobName%></td>
					<td style='mso-number-format:\\@;' ><%=strDescription%></td>
					<td style='mso-number-format:\\@;' ><%=strDraftDate%></td>
					<td style='mso-number-format:\\@;' ><%=userInfo%></td>
				</tr>
		<%		
				out.flush();
			}
		%>
	</table>
</body>
</html>
