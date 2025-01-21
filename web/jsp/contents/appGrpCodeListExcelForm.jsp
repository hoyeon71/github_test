<%@page import="java.util.Date"%>
<%@page import="org.apache.poi.ss.usermodel.DateUtil"%>
<%@page import="org.apache.poi.ss.usermodel.DataFormat"%>
<%@page import="org.apache.poi.xssf.usermodel.XSSFColor"%>
<%@page import="org.apache.poi.ss.usermodel.Font"%>
<%@page import="org.apache.poi.util.SystemOutLogger"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.ghayoun.ezjobs.t.domain.*"%>
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
	
	OutputStream os = null;
	sheet = null;
	wb = new SXSSFWorkbook();
	String grp_depth	= CommonUtil.isNull(paramMap.get("grp_depth"));
	System.out.println("grp_depth"   + grp_depth);
	String fileName = ""; 
	if(grp_depth.equals("1")) { // folder
		fileName 	= "Folder.xlsx";
	}
	
	response.reset() ;
	response.setHeader("Content-Description", "JSP Generated Data");
	response.setHeader("Content-Type", "application/octet-stream; charset=UTF-8");
	response.setHeader("Content-Disposition", "attachment; filename="+java.net.URLEncoder.encode(fileName,"UTF-8").replaceAll("\\+","%20"));
	
%>

<%
	try {
		String[] arr_folder_nm		= new String[]{"폴더명1"			,"폴더명2"};
		String[] arr_host_nm		= new String[]{"수행서버1"			,"수행서버1,수행서버2"};
		String[] arr_user_daily		= new String[]{"SYSTEM"			,""};
		String[] arr_folder_desc	= new String[]{"폴더_설명1"		,"폴더_설명2"};
		String[] arr_app_nm			= new String[]{"어플리케이션명1"	,"어플리케이션명2"};
		String[] arr_app_desc		= new String[]{"어플리케이션_설명1"	,"어플리케이션_설명2"};
		String[] arr_grp_nm			= new String[]{"그룹명1"			,"그룹명2"};
		String[] arr_grp_desc		= new String[]{"그룹_설명1"		,"그룹_설명2"};
		
		sheet = wb.createSheet("Sheet1");
		
		style	= wb.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setFillForegroundColor(HSSFColor.GREY_25_PERCENT.index);
		style.setFillPattern(XSSFCellStyle.SOLID_FOREGROUND);
		style.setBorderRight(XSSFCellStyle.BORDER_THIN);
		style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
		style.setBorderTop(XSSFCellStyle.BORDER_THIN);
		style.setBorderBottom(XSSFCellStyle.BORDER_THIN);	
		
		
		int n = -1;
		int r = 0;
		
		int folderNmMaxCellWidth 	= 0;
		int hostMaxCellWidth 		= 0;
		int userDailyMaxCellWidth 	= 0;
		int folderDescMaxCellWidth 	= 0;
		int appNmMaxCellWidth 		= 0;
		int appDescMaxCellWidth 	= 0;
		int grpNmMaxCellWidth 		= 0;
		int grpDescMaxCellWidth 	= 0;
		
		int cellWidth = 0;
		
// 		setCellValue(0, ++header_column, "폴더명");
// 		setCellValue(0, ++header_column, "수행서버");
// 		setCellValue(0, ++header_column, "USER DAILY");
// 		setCellValue(0, ++header_column, "설명");
// 		setCellValue(0, ++header_column, "어플리케이션명");
// 		setCellValue(0, ++header_column, "설명");
// 		setCellValue(0, ++header_column, "그룹");
// 		setCellValue(0, ++header_column, "설명");
		
		setCellValue(r, ++n, "폴더명", style);
		cellWidth = "폴더명".getBytes("UTF-8").length * 256;
		folderNmMaxCellWidth = Math.max(folderNmMaxCellWidth, cellWidth);
		
		setCellValue(r, ++n, "수행서버", style);
		cellWidth = "수행서버".getBytes("UTF-8").length * 256;
		hostMaxCellWidth = Math.max(hostMaxCellWidth, cellWidth);
		
		setCellValue(r, ++n, "USER DAILY", style);
		cellWidth = "USER DAILY".getBytes("UTF-8").length * 256;
		userDailyMaxCellWidth = Math.max(userDailyMaxCellWidth, cellWidth);
		
		setCellValue(r, ++n, "설명", style);
		cellWidth = "설명".getBytes("UTF-8").length * 256;
		folderDescMaxCellWidth = Math.max(folderDescMaxCellWidth, cellWidth);
		
		setCellValue(r, ++n, "어플리케이션명", style);
		cellWidth = "어플리케이션명".getBytes("UTF-8").length * 256;
		appNmMaxCellWidth = Math.max(appNmMaxCellWidth, cellWidth);
		
		setCellValue(r, ++n, "설명", style);
		cellWidth = "설명".getBytes("UTF-8").length * 256;
		appDescMaxCellWidth = Math.max(appDescMaxCellWidth, cellWidth);
		
		setCellValue(r, ++n, "그룹", style);
		cellWidth = "그룹".getBytes("UTF-8").length * 256;
		grpNmMaxCellWidth = Math.max(grpNmMaxCellWidth, cellWidth);
		
		setCellValue(r, ++n, "설명", style);
		cellWidth = "설명".getBytes("UTF-8").length * 256;
		grpDescMaxCellWidth = Math.max(grpDescMaxCellWidth, cellWidth);
		
	
		style = wb.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
		style.setBorderRight(XSSFCellStyle.BORDER_THIN);
		style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
		style.setBorderTop(XSSFCellStyle.BORDER_THIN);
		style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
		for( int i=0; i<arr_folder_nm.length; i++ ){
			
			r++;
			n = -1;
			
			setCellValue(r, ++n, arr_folder_nm[i], style);
			cellWidth = arr_folder_nm[i].getBytes("UTF-8").length * 256;
			folderNmMaxCellWidth = Math.max(folderNmMaxCellWidth, cellWidth);
			
			setCellValue(r, ++n, arr_host_nm[i], style);
			cellWidth = arr_host_nm[i].getBytes("UTF-8").length * 256;
			hostMaxCellWidth = Math.max(hostMaxCellWidth, cellWidth);
			
			setCellValue(r, ++n, arr_user_daily[i], style);
			cellWidth = arr_user_daily[i].getBytes("UTF-8").length * 256;
			userDailyMaxCellWidth = Math.max(userDailyMaxCellWidth, cellWidth);
			
			setCellValue(r, ++n, arr_folder_desc[i], style);
			cellWidth = arr_folder_desc[i].getBytes("UTF-8").length * 256;
			folderDescMaxCellWidth = Math.max(folderDescMaxCellWidth, cellWidth);
			
			setCellValue(r, ++n, arr_app_nm[i], style);
			cellWidth = arr_app_nm[i].getBytes("UTF-8").length * 256;
			appNmMaxCellWidth = Math.max(appNmMaxCellWidth, cellWidth);
			
			setCellValue(r, ++n, arr_app_desc[i], style);
			cellWidth = arr_app_desc[i].getBytes("UTF-8").length * 256;
			appDescMaxCellWidth = Math.max(appDescMaxCellWidth, cellWidth);
			
			setCellValue(r, ++n, arr_grp_nm[i], style);
			cellWidth = arr_grp_nm[i].getBytes("UTF-8").length * 256;
			grpNmMaxCellWidth = Math.max(grpNmMaxCellWidth, cellWidth);
			
			setCellValue(r, ++n, arr_grp_desc[i], style);
			cellWidth = arr_grp_desc[i].getBytes("UTF-8").length * 256;
			grpDescMaxCellWidth = Math.max(grpDescMaxCellWidth, cellWidth);
			
		}
			
		n = -1;
		
		CommonUtil.setAutoSizeColumn(sheet, ++n, folderNmMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, hostMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, userDailyMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, folderDescMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, appNmMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, appDescMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, grpNmMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, grpDescMaxCellWidth);
		
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
