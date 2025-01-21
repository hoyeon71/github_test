<%@page import="org.apache.poi.ss.util.CellRangeAddress"%>
<%@page import="org.apache.poi.util.SystemOutLogger"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.ghayoun.ezjobs.a.domain.*"%>
<%@page import="com.ghayoun.ezjobs.m.service.*"%>

<%@page import="org.springframework.web.context.*"%>

<%@page import="org.apache.poi.xssf.usermodel.XSSFCellStyle"%>

<%@page import="org.apache.poi.xssf.streaming.SXSSFWorkbook" %>
<%@page import="org.apache.poi.xssf.streaming.SXSSFSheet"%>
<%@page import="org.apache.poi.xssf.streaming.SXSSFCell"%>

<%@page import="org.apache.poi.ss.usermodel.Cell" %>
<%@page import="org.apache.poi.ss.usermodel.Row" %>
<%@page import="org.apache.poi.ss.usermodel.Sheet" %>
<%@page import="org.apache.poi.ss.usermodel.CellStyle"%>
<%@page import="org.apache.poi.ss.usermodel.DataFormat"%>
<%@page import="org.apache.poi.hssf.util.HSSFColor"%>

<%@include file="/jsp/common/inc/header.jsp"%>

<%!
	private Sheet sheet;
	private CellStyle style;
	private CellStyle style2;
	private DataFormat format;
	private SXSSFWorkbook wb = null;
	
	public Row getRow(int i) {
		Row r = sheet.getRow(i);
		if (r == null)
			r = sheet.createRow(i);
		return r;
	}
	
	public Cell getCell(int row, int cell) {
		Row r = getRow(row);
		Cell c = r.getCell(cell);
		if (c == null)
			c = r.createCell(cell);
		return c;
	}
	
	public void setCellValue(int row, int cell, String cellvalue, CellStyle cellSstyle) {
		Cell c = getCell(row, cell);
		c.setCellValue(cellvalue);
		c.setCellStyle(cellSstyle);
	}
%>


<%
	response.setHeader("Cache-Control","no-store"); //HTTP 1.1
  	response.setHeader("Pragma","no-cache"); //HTTP 1.0
  	response.setDateHeader ("Expires", 0);
%>


<%
	Map<String, Object> paramMap = CommonUtil.collectParameters(request);
	String menu_gb = CommonUtil.getMessage("CATEGORY.GB.04.GB."+CommonUtil.isNull(paramMap.get("menu_gb")));
	String[] arr_menu_gb = menu_gb.split(",");
	
	OutputStream os = null;
	sheet = null;
	wb = new SXSSFWorkbook();
	
	String fileName = "알람이력.xlsx"; 
	response.reset() ;
	response.setHeader("Content-Description", "JSP Generated Data");
	response.setHeader("Content-Type", "application/octet-stream; charset=UTF-8");
	response.setHeader("Content-Disposition", "attachment; filename="+java.net.URLEncoder.encode(fileName,"UTF-8").replaceAll("\\+","%20"));
	
	List<CommonBean> sendLogList	= (List)request.getAttribute("sendLogList");
	
	
	PopupDefJobDetailService popupDefJobDetailService 	= (PopupDefJobDetailService)ContextLoader.getCurrentWebApplicationContext().getBean("mPopupDefJobDetailService");
	
%>

<%
	try {
		sheet = wb.createSheet("Sheet1");
		
		format = wb.createDataFormat();
		style	= wb.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setFillForegroundColor(HSSFColor.GREY_25_PERCENT.index);
		style.setFillPattern(XSSFCellStyle.SOLID_FOREGROUND);
		style.setBorderRight(XSSFCellStyle.BORDER_THIN);
		style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
		style.setBorderTop(XSSFCellStyle.BORDER_THIN);
		style.setBorderBottom(XSSFCellStyle.BORDER_THIN);	
		style.setDataFormat(format.getFormat("@")); // "@"은 텍스트 형식
		
		int n = -1;
		int r = 0;
		int numMaxCellWidth = 0;
		int sendCdMaxCellWidth = 0;
		int dataCenterNmMaxCellWidth = 0;
		int odateMaxCellWidth = 0;
		int jobNameMaxCellWidth = 0;
		int sendGubunNmMaxCellWidth = 0;
		int sendDescriptionMaxCellWidth = 0;
		int messageMaxCellWidth = 0;
		int userNmMaxCellWidth = 0;
		int sendDateMaxCellWidth = 0;
		int returnCodeMaxCellWidth = 0;
		int returnDateMaxCellWidth = 0;
		int sendInfoMaxCellWidth = 0;
		int jobSchedGbMaxCellWidth = 0;
		
		int cellWidth = 0;
		
		setCellValue(r, ++n, "순번", style);
		cellWidth = "순번".getBytes("UTF-8").length * 256;
		numMaxCellWidth = Math.max(numMaxCellWidth, cellWidth);
		
		setCellValue(r, ++n, "C-M", style);
		cellWidth = "C-M".getBytes("UTF-8").length * 256;
		dataCenterNmMaxCellWidth = Math.max(dataCenterNmMaxCellWidth, cellWidth);
		
// 		setCellValue(r, ++n, "ODATE", style);
// 		cellWidth = "ODATE".getBytes("UTF-8").length * 256;
// 		odateMaxCellWidth = Math.max(odateMaxCellWidth, cellWidth);
		
		setCellValue(r, ++n, "작업명", style);
		cellWidth = "작업명".getBytes("UTF-8").length * 256;
		jobNameMaxCellWidth = Math.max(jobNameMaxCellWidth, cellWidth);
		
		setCellValue(r, ++n, "구분", style);
		cellWidth = "구분".getBytes("UTF-8").length * 256;
		sendGubunNmMaxCellWidth = Math.max(sendGubunNmMaxCellWidth, cellWidth);
		
		setCellValue(r, ++n, "통보 사유", style);
		cellWidth = "동보 사유".getBytes("UTF-8").length * 256;
		sendDescriptionMaxCellWidth = Math.max(sendDescriptionMaxCellWidth, cellWidth);
		
		setCellValue(r, ++n, "메세지내용", style);
		cellWidth = "메세지내용".getBytes("UTF-8").length * 256;
		messageMaxCellWidth = Math.max(messageMaxCellWidth, cellWidth);
		
		setCellValue(r, ++n, "담당자", style);
		cellWidth = "담당자".getBytes("UTF-8").length * 256;
		userNmMaxCellWidth = Math.max(userNmMaxCellWidth, cellWidth);
		
		setCellValue(r, ++n, "발송정보", style);
		cellWidth = "발송정보".getBytes("UTF-8").length * 256;
		sendInfoMaxCellWidth = Math.max(sendInfoMaxCellWidth, cellWidth);
		
		setCellValue(r, ++n, "전송일자", style);
		cellWidth = "전송일자".getBytes("UTF-8").length * 256;
		sendDateMaxCellWidth = Math.max(sendDateMaxCellWidth, cellWidth);
		
 		setCellValue(r, ++n, "회신코드", style);
 		cellWidth = "회신코드".getBytes("UTF-8").length * 256;
 		returnCodeMaxCellWidth = Math.max(returnCodeMaxCellWidth, cellWidth);
		
		setCellValue(r, ++n, "회신일자", style);
		cellWidth = "회신일자".getBytes("UTF-8").length * 256;
		returnDateMaxCellWidth = Math.max(returnDateMaxCellWidth, cellWidth);
		
	
		format = wb.createDataFormat();
		style = wb.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setBorderRight(XSSFCellStyle.BORDER_THIN);
		style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
		style.setBorderTop(XSSFCellStyle.BORDER_THIN);
		style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
		style.setDataFormat(format.getFormat("@")); // "@"은 텍스트 형식
		
		// 왼쪽 정렬 스타일
		style2 = wb.createCellStyle();
		style2.setAlignment(XSSFCellStyle.ALIGN_LEFT);
		style2.setBorderRight(XSSFCellStyle.BORDER_THIN);
		style2.setBorderLeft(XSSFCellStyle.BORDER_THIN);
		style2.setBorderTop(XSSFCellStyle.BORDER_THIN);
		style2.setBorderBottom(XSSFCellStyle.BORDER_THIN);
		style2.setDataFormat(format.getFormat("@")); // "@"은 텍스트 형식
		
		for( int i=0; null!=sendLogList && i<sendLogList.size(); i++ ){
			CommonBean bean			= (CommonBean)sendLogList.get(i);
			
	 		String strSendCd			= CommonUtil.isNull(bean.getSend_cd());
	 		String strDataCenter		= CommonUtil.isNull(bean.getData_center());
	 		String strDataCenterNm		= CommonUtil.isNull(bean.getData_center_name());
	 		String strOdate				= CommonUtil.isNull(bean.getOdate());
	 		String strJobName			= CommonUtil.isNull(bean.getJob_name());
	 		String strOrderId			= CommonUtil.isNull(bean.getOrder_id());
	 		String strSendGubun			= CommonUtil.isNull(bean.getSend_gubun());
	 		String strSendGubunNm		= CommonUtil.isNull(bean.getSend_gubun_nm());
	 		String strMessage			= CommonUtil.isNull(bean.getMessage());
	 		String userNm				= CommonUtil.isNull(bean.getUser_nm());
	 		String strSendDate			= CommonUtil.isNull(bean.getSend_date());
	 		String strReturnCode 		= CommonUtil.isNull(CommonUtil.getMessage("SEND.RETURN."+bean.getReturn_code()));
	 		String strReturnDate 		= CommonUtil.isNull(bean.getReturn_date());
	 		String strSendInfo			= CommonUtil.isNull(bean.getSend_info());
	 		String jobSchedGb			= CommonUtil.isNull(bean.getJobschedgb());
	 		
	 		String sendDescription = "";
	 		
			if(strOrderId.indexOf("결재") > -1) {
				sendDescription = "결재";
			}else if(strOrderId.indexOf("반영완료") > -1){
				sendDescription = "반영완료";
			}else{
				if(strMessage.indexOf("비정상종료") > -1){
					sendDescription = "에러발생";
				}else {
					sendDescription = "기타";
				}
			}
			r++;
			n = -1;
			
			setCellValue(r, ++n, Integer.toString(i+1), style);
			cellWidth = Integer.toString(i+1).getBytes("UTF-8").length * 256;
			numMaxCellWidth = Math.max(numMaxCellWidth, cellWidth);
			
			setCellValue(r, ++n, strDataCenterNm, style);
			cellWidth = strDataCenterNm.getBytes("UTF-8").length * 256;
			dataCenterNmMaxCellWidth = Math.max(dataCenterNmMaxCellWidth, cellWidth);
			
// 			setCellValue(r, ++n, strOdate, style);
// 			cellWidth = strOdate.getBytes("UTF-8").length * 256;
// 			odateMaxCellWidth = Math.max(odateMaxCellWidth, cellWidth);
			
			setCellValue(r, ++n, CommonUtil.replaceStrHtml(strJobName), style2);
			cellWidth = strJobName.getBytes("UTF-8").length * 256;
			jobNameMaxCellWidth = Math.max(jobNameMaxCellWidth, cellWidth);
			
			setCellValue(r, ++n, strSendGubunNm, style);
			cellWidth = strSendGubunNm.getBytes("UTF-8").length * 256;
			sendGubunNmMaxCellWidth = Math.max(sendGubunNmMaxCellWidth, cellWidth);
			
			setCellValue(r, ++n, sendDescription, style);
			cellWidth = sendDescription.getBytes("UTF-8").length * 256;
			sendDescriptionMaxCellWidth = Math.max(sendDescriptionMaxCellWidth, cellWidth);
			
			setCellValue(r, ++n, CommonUtil.replaceStrHtml(strMessage), style);
			cellWidth = strMessage.getBytes("UTF-8").length * 256;
			messageMaxCellWidth = Math.max(messageMaxCellWidth, cellWidth);
			
			setCellValue(r, ++n, userNm, style);
			cellWidth = userNm.getBytes("UTF-8").length * 256;
			userNmMaxCellWidth = Math.max(userNmMaxCellWidth, cellWidth);
			
			setCellValue(r, ++n, strSendInfo, style);
			cellWidth = strSendInfo.getBytes("UTF-8").length * 256;
			sendInfoMaxCellWidth = Math.max(sendInfoMaxCellWidth, cellWidth);
			
			setCellValue(r, ++n, strSendDate, style);
			cellWidth = strSendDate.getBytes("UTF-8").length * 256;
			sendDateMaxCellWidth = Math.max(sendDateMaxCellWidth, cellWidth);
			
			setCellValue(r, ++n, strReturnCode, style);
			cellWidth = strReturnCode.getBytes("UTF-8").length * 256;
			returnCodeMaxCellWidth = Math.max(returnCodeMaxCellWidth, cellWidth);
			
			setCellValue(r, ++n, strReturnDate, style);
			cellWidth = strReturnDate.getBytes("UTF-8").length * 256;
			returnDateMaxCellWidth = Math.max(returnDateMaxCellWidth, cellWidth);
			
			
		}
			
		n = -1;
		
		
		CommonUtil.setAutoSizeColumn(sheet, ++n, numMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, dataCenterNmMaxCellWidth);
// 		CommonUtil.setAutoSizeColumn(sheet, ++n, odateMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, jobNameMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, sendGubunNmMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, sendDescriptionMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, messageMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, userNmMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, sendInfoMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, sendDateMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, returnCodeMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, returnDateMaxCellWidth);
		
		((SXSSFSheet) sheet).flushRows(1000);
		os = response.getOutputStream();
		wb.write(os);
		os.flush();
	
		out.clear();
		out = pageContext.pushBody();
	
		} catch (Exception e) {
			e.printStackTrace();
			System.err.println(e.getMessage());
		}
	
		wb.dispose();
%>
