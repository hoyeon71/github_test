<%@page import="org.apache.poi.util.SystemOutLogger"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.ghayoun.ezjobs.t.domain.*"%>
<%@page import="com.ghayoun.ezjobs.m.service.*"%>

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
// 	String menu_gb = CommonUtil.getMessage("CATEGORY.GB.04.GB."+CommonUtil.isNull(paramMap.get("menu_gb")));
// 	String[] arr_menu_gb = menu_gb.split(",");
	
	OutputStream os = null;
	sheet = null;
	wb = new SXSSFWorkbook();
	
	String fileName = "Forecast.xlsx"; 
	response.reset() ;
	response.setHeader("Content-Description", "JSP Generated Data");
	response.setHeader("Content-Type", "application/octet-stream; charset=UTF-8");
	response.setHeader("Content-Disposition", "attachment; filename="+java.net.URLEncoder.encode(fileName,"UTF-8").replaceAll("\\+","%20"));
	
	List preDateBatchScheduleList = (List)request.getAttribute("preDateBatchScheduleList");
	
	String data_center 	= CommonUtil.isNull(paramMap.get("data_center"));
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
		int dataCenterMaxCellWidth = 0;
		int odateMaxCellWidth = 0;
		int tableMaxCellWidth = 0;
		int appMaxCellWidth = 0;
		int groupMaxCellWidth = 0;
		int jobNmMaxCellWidth = 0;
		int descriptionMaxCellWidth = 0;
		int developerMaxCellWidth = 0;
		int fromTimeMaxCellWidth = 0;
		
		int cellWidth = 0;
		
		setCellValue(r, ++n, "순번", style);
		cellWidth = "순번".getBytes("UTF-8").length * 256;
		numMaxCellWidth = Math.max(numMaxCellWidth, cellWidth);
        
		setCellValue(r, ++n, "C-M", style);
		cellWidth = "C-M".getBytes("UTF-8").length * 256;
		dataCenterMaxCellWidth = Math.max(dataCenterMaxCellWidth, cellWidth);
		
		setCellValue(r, ++n, "ODATE", style);
		cellWidth = "ODATE".getBytes("UTF-8").length * 256;
		odateMaxCellWidth = Math.max(odateMaxCellWidth, cellWidth);
		
		setCellValue(r, ++n, "폴더", style);
		cellWidth = "폴더".getBytes("UTF-8").length * 256;
		tableMaxCellWidth = Math.max(tableMaxCellWidth, cellWidth);
		
		setCellValue(r, ++n, "어플리케이션", style);
		cellWidth = "어플리케이션".getBytes("UTF-8").length * 256;
		appMaxCellWidth = Math.max(appMaxCellWidth, cellWidth);
		
		setCellValue(r, ++n, "그룹", style);
		cellWidth = "그룹".getBytes("UTF-8").length * 256;
		groupMaxCellWidth = Math.max(groupMaxCellWidth, cellWidth);
		
		setCellValue(r, ++n, "작업명", style);
		cellWidth = "작업명".getBytes("UTF-8").length * 256;
		jobNmMaxCellWidth = Math.max(jobNmMaxCellWidth, cellWidth);
		
		setCellValue(r, ++n, "작업설명", style);
		cellWidth = "작업설명".getBytes("UTF-8").length * 256;
		descriptionMaxCellWidth = Math.max(descriptionMaxCellWidth, cellWidth);
		
		setCellValue(r, ++n, "담당자", style);
		cellWidth = "담당자".getBytes("UTF-8").length * 256;
		developerMaxCellWidth = Math.max(developerMaxCellWidth, cellWidth);
		
		setCellValue(r, ++n, "시작시간", style);
		cellWidth = "시작시간".getBytes("UTF-8").length * 256;
		fromTimeMaxCellWidth = Math.max(fromTimeMaxCellWidth, cellWidth);
		
		
		int cellCnt = n + 1;
		
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
		
		for( int i=0; null!=preDateBatchScheduleList && i<preDateBatchScheduleList.size(); i++ ){
			
			PreDateBatchScheduleBean bean = (PreDateBatchScheduleBean)preDateBatchScheduleList.get(i);
			

			String strDataCenterName 	= CommonUtil.isNull(bean.getData_center_name());
			String strOdate 			= CommonUtil.isNull(bean.getOdate());
			String strSchedTable 		= CommonUtil.isNull(bean.getSched_table());
			String strApplication 		= CommonUtil.isNull(bean.getApplication());
			String strGroupName			= CommonUtil.isNull(bean.getGroup_name());
			String strJobName 			= CommonUtil.isNull(bean.getJob_name());
			String strDescription 		= CommonUtil.replaceStrHtml(CommonUtil.isNull(bean.getDescription()));
			String strDeveloper 		= CommonUtil.isNull(bean.getDeveloper());
			String strFromTime 			= CommonUtil.isNull(bean.getFrom_time());
			
			if ( !strFromTime.equals("") ) {
				strFromTime = strFromTime.substring(0, 2) + ":" + strFromTime.substring(2, 4);
			}
			
			r++;
			n = -1;
			
			setCellValue(r, ++n, Integer.toString(i+1), style);
			cellWidth = Integer.toString(i+1).getBytes("UTF-8").length * 256;
			numMaxCellWidth = Math.max(numMaxCellWidth, cellWidth);
	        
			setCellValue(r, ++n, strDataCenterName, style);
			cellWidth = strDataCenterName.getBytes("UTF-8").length * 256;
			dataCenterMaxCellWidth = Math.max(dataCenterMaxCellWidth, cellWidth);
			
			setCellValue(r, ++n, strOdate, style);
			cellWidth = strOdate.getBytes("UTF-8").length * 256;
			odateMaxCellWidth = Math.max(odateMaxCellWidth, cellWidth);
			
			setCellValue(r, ++n, strSchedTable, style);
			cellWidth = strSchedTable.getBytes("UTF-8").length * 256;
			tableMaxCellWidth = Math.max(tableMaxCellWidth, cellWidth);
			
			setCellValue(r, ++n, strApplication, style);
			cellWidth = strApplication.getBytes("UTF-8").length * 256;
			appMaxCellWidth = Math.max(appMaxCellWidth, cellWidth);
			
			setCellValue(r, ++n, strGroupName, style);
			cellWidth = strGroupName.getBytes("UTF-8").length * 256;
			groupMaxCellWidth = Math.max(groupMaxCellWidth, cellWidth);
			
			setCellValue(r, ++n, strJobName, style2);
			cellWidth = strJobName.getBytes("UTF-8").length * 256;
			jobNmMaxCellWidth = Math.max(jobNmMaxCellWidth, cellWidth);
			
			setCellValue(r, ++n, strDescription, style2);
			cellWidth = strDescription.getBytes("UTF-8").length * 256;
			descriptionMaxCellWidth = Math.max(descriptionMaxCellWidth, cellWidth);
			
			setCellValue(r, ++n, strDeveloper, style);
			cellWidth = strDeveloper.getBytes("UTF-8").length * 256;
			developerMaxCellWidth = Math.max(developerMaxCellWidth, cellWidth);
			
			setCellValue(r, ++n, strFromTime, style);
			cellWidth = strFromTime.getBytes("UTF-8").length * 256;
			fromTimeMaxCellWidth = Math.max(fromTimeMaxCellWidth, cellWidth);
		}
			
		n = -1;
		
		CommonUtil.setAutoSizeColumn(sheet, ++n, numMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, dataCenterMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, odateMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, tableMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, appMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, groupMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, jobNmMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, descriptionMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, descriptionMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, developerMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, fromTimeMaxCellWidth);
		
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