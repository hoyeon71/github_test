<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.ghayoun.ezjobs.a.domain.*" %>
<%@page import="org.springframework.web.context.*"%>

<%@page import="org.apache.poi.xssf.usermodel.XSSFCellStyle"%>

<%@page import="org.apache.poi.xssf.streaming.SXSSFWorkbook" %>
<%@page import="org.apache.poi.xssf.streaming.SXSSFSheet"%>
<%@page import="org.apache.poi.xssf.streaming.SXSSFCell"%>
<%@page import="org.apache.poi.ss.usermodel.DataFormat"%>
<%@page import="org.apache.poi.ss.usermodel.Cell" %>
<%@page import="org.apache.poi.ss.usermodel.Row" %>
<%@page import="org.apache.poi.ss.usermodel.Sheet" %>
<%@page import="org.apache.poi.ss.usermodel.CellStyle"%>

<%@page import="org.apache.poi.hssf.util.HSSFColor"%>

<%@include file="/jsp/common/inc/header.jsp"%>

<%!
	private Sheet sheet;
	private CellStyle style;
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
	
	String fileName = "Alert_Monitor.xlsx"; 
	response.reset() ;
	response.setHeader("Content-Description", "JSP Generated Data");
	response.setHeader("Content-Type", "application/octet-stream; charset=UTF-8");
	response.setHeader("Content-Disposition", "attachment; filename="+java.net.URLEncoder.encode(fileName,"UTF-8").replaceAll("\\+","%20"));
	
	List<AlertBean> alertList	= (List)request.getAttribute("alertList");	
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />

</head>

<body>

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
		int appMaxCellWidth = 0;
		int groupMaxCellWidth = 0;
		int jobNameMaxCellWidth = 0;
		int handledNameMaxCellWidth = 0;
		int changedByMaxCellWidth = 0;
		int messageMaxCellWidth = 0;
		int notesMaxCellWidth = 0;
		int hostTimeMaxCellWidth = 0;
		int updTimeMaxCellWidth = 0;
		int userNmMaxCellWidth = 0;
		
		int cellWidth = 0;
		
		setCellValue(r, ++n, "순번", style);
		cellWidth = "순번".getBytes("UTF-8").length * 256;
		numMaxCellWidth = Math.max(numMaxCellWidth, cellWidth);
        
		setCellValue(r, ++n, "어플리케이션", style);
		cellWidth = "어플리케이션".getBytes("UTF-8").length * 256;
		appMaxCellWidth = Math.max(appMaxCellWidth, cellWidth);
		
		setCellValue(r, ++n, "그룹", style);
		cellWidth = "그룹".getBytes("UTF-8").length * 256;
		groupMaxCellWidth = Math.max(groupMaxCellWidth, cellWidth);
		
		setCellValue(r, ++n, "작업명", style);
		cellWidth = "작업명".getBytes("UTF-8").length * 256;
		jobNameMaxCellWidth = Math.max(jobNameMaxCellWidth, cellWidth);
		
		setCellValue(r, ++n, "HANDLED", style);
		cellWidth = "HANDLED".getBytes("UTF-8").length * 256;
		handledNameMaxCellWidth = Math.max(handledNameMaxCellWidth, cellWidth);
		
		setCellValue(r, ++n, "CHANGED_BY", style);
		cellWidth = "CHANGED_BY".getBytes("UTF-8").length * 256;
		changedByMaxCellWidth = Math.max(changedByMaxCellWidth, cellWidth);
		
		setCellValue(r, ++n, "MESSAGE", style);
		cellWidth = "MESSAGE".getBytes("UTF-8").length * 256;
		messageMaxCellWidth = Math.max(messageMaxCellWidth, cellWidth);
		
		setCellValue(r, ++n, "NOTES", style);
		cellWidth = "NOTES".getBytes("UTF-8").length * 256;
		notesMaxCellWidth = Math.max(notesMaxCellWidth, cellWidth);
		
		setCellValue(r, ++n, "HOST_TIME", style);
		cellWidth = "Host_time".getBytes("UTF-8").length * 256;
		hostTimeMaxCellWidth = Math.max(hostTimeMaxCellWidth, cellWidth);
		
		setCellValue(r, ++n, "UPD_TIME", style);
		cellWidth = "UPD_TIME".getBytes("UTF-8").length * 256;
		updTimeMaxCellWidth = Math.max(updTimeMaxCellWidth, cellWidth);
		
		setCellValue(r, ++n, "담당자", style);
		cellWidth = "담당자".getBytes("UTF-8").length * 256;
		userNmMaxCellWidth = Math.max(userNmMaxCellWidth, cellWidth);
		
	
		format = wb.createDataFormat();
		style = wb.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setBorderRight(XSSFCellStyle.BORDER_THIN);
		style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
		style.setBorderTop(XSSFCellStyle.BORDER_THIN);
		style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
		style.setDataFormat(format.getFormat("@")); // "@"은 텍스트 형식
		
		
		for( int i=0; null!=alertList && i<alertList.size(); i++ ){
			
			AlertBean bean 			= (AlertBean)alertList.get(i);
			
			String app					= CommonUtil.isNull(bean.getApplication());
			String group				= CommonUtil.isNull(bean.getGroup_name());
			String job_name 			= CommonUtil.isNull(bean.getJob_name(),bean.getMemname());
			String handled_name 		= CommonUtil.isNull(bean.getHandled_name());
			String changed_by 			= CommonUtil.isNull(bean.getChanged_by());
			String message 				= CommonUtil.isNull(bean.getMessage());
			String notes 				= CommonUtil.isNull(bean.getNotes());
			String host_time 			= CommonUtil.E2K(bean.getHost_time());
			String upd_time 			= CommonUtil.isNull(bean.getUpd_time());
			String user_nm 				= CommonUtil.isNull(bean.getUser_nm());
			
			r++;
			n = -1;
			
			setCellValue(r, ++n, Integer.toString(i+1), style);
			cellWidth = Integer.toString(i+1).getBytes("UTF-8").length * 256;
			numMaxCellWidth = Math.max(numMaxCellWidth, cellWidth);
	        
			setCellValue(r, ++n, app, style);
			cellWidth = app.getBytes("UTF-8").length * 256;
			appMaxCellWidth = Math.max(appMaxCellWidth, cellWidth);
			
			setCellValue(r, ++n, group, style);
			cellWidth = group.getBytes("UTF-8").length * 256;
			groupMaxCellWidth = Math.max(groupMaxCellWidth, cellWidth);
			
			setCellValue(r, ++n, CommonUtil.replaceStrHtml(job_name), style);
			cellWidth = job_name.getBytes("UTF-8").length * 256;
			jobNameMaxCellWidth = Math.max(jobNameMaxCellWidth, cellWidth);
			
			setCellValue(r, ++n, handled_name, style);
			cellWidth = handled_name.getBytes("UTF-8").length * 256;
			handledNameMaxCellWidth = Math.max(handledNameMaxCellWidth, cellWidth);
			
			setCellValue(r, ++n, changed_by, style);
			cellWidth = changed_by.getBytes("UTF-8").length * 256;
			changedByMaxCellWidth = Math.max(changedByMaxCellWidth, cellWidth);
			
			setCellValue(r, ++n, message, style);
			cellWidth = message.getBytes("UTF-8").length * 256;
			messageMaxCellWidth = Math.max(messageMaxCellWidth, cellWidth);
			
			setCellValue(r, ++n, notes, style);
			cellWidth = notes.getBytes("UTF-8").length * 256;
			notesMaxCellWidth = Math.max(notesMaxCellWidth, cellWidth);
			
			setCellValue(r, ++n, host_time, style);
			cellWidth = host_time.getBytes("UTF-8").length * 256;
			hostTimeMaxCellWidth = Math.max(hostTimeMaxCellWidth, cellWidth);
			
			setCellValue(r, ++n, upd_time, style);
			cellWidth = upd_time.getBytes("UTF-8").length * 256;
			updTimeMaxCellWidth = Math.max(updTimeMaxCellWidth, cellWidth);
			
			setCellValue(r, ++n, user_nm, style);
			cellWidth = user_nm.getBytes("UTF-8").length * 256;
			userNmMaxCellWidth = Math.max(userNmMaxCellWidth, cellWidth);
			
						
			((SXSSFSheet) sheet).flushRows(10000);
		}
			

		n = -1;
		
		CommonUtil.setAutoSizeColumn(sheet, ++n, numMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, appMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, groupMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, jobNameMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, handledNameMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, changedByMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, messageMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, notesMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, hostTimeMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, updTimeMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, userNmMaxCellWidth);
		
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


</body>
</html>
