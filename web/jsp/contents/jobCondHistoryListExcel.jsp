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
	String menu_gb = CommonUtil.getMessage("CATEGORY.GB.04.GB."+CommonUtil.isNull(paramMap.get("menu_gb")));
	String[] arr_menu_gb = menu_gb.split(",");
	
	OutputStream os = null;
	sheet = null;
	wb = new SXSSFWorkbook();
	
	String fileName = "발행컨디션_이력.xlsx"; 
	response.reset() ;
	response.setHeader("Content-Description", "JSP Generated Data");
	response.setHeader("Content-Type", "application/octet-stream; charset=UTF-8");
	response.setHeader("Content-Disposition", "attachment; filename="+java.net.URLEncoder.encode(fileName,"UTF-8").replaceAll("\\+","%20"));
	
	List jobCondHistoryList = (List)request.getAttribute("jobCondHistoryList");
	
	
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
		
		int numMaxCellWidth 			= 0;
		int condNameMaxCellWidth 		= 0;
		int condDateMaxCellWidth 		= 0;
		int userIdMaxCellWidth 			= 0;
		int userNmMaxCellWidth 			= 0;
		int insDateMaxCellWidth 		= 0;
		
		
		int cellWidth = 0;
		
		setCellValue(r, ++n, "순번", style);
		cellWidth = "순번".getBytes("UTF-8").length * 256;
		numMaxCellWidth = Math.max(numMaxCellWidth, cellWidth);
        
		setCellValue(r, ++n, "컨디션명", style);
		cellWidth = "컨디션명".getBytes("UTF-8").length * 256;
		condNameMaxCellWidth = Math.max(condNameMaxCellWidth, cellWidth);
        
		setCellValue(r, ++n, "날짜", style);
		cellWidth = "날짜".getBytes("UTF-8").length * 256;
		condDateMaxCellWidth = Math.max(condDateMaxCellWidth, cellWidth);
		
		setCellValue(r, ++n, "아이디", style);
		cellWidth = "아이디".getBytes("UTF-8").length * 256;
		userIdMaxCellWidth = Math.max(userIdMaxCellWidth, cellWidth);
		
		setCellValue(r, ++n, "이름", style);
		cellWidth = "이름".getBytes("UTF-8").length * 256;
		userNmMaxCellWidth = Math.max(userNmMaxCellWidth, cellWidth);
		
		setCellValue(r, ++n, "삭제일자", style);
		cellWidth = "삭제일자".getBytes("UTF-8").length * 256;
		insDateMaxCellWidth = Math.max(insDateMaxCellWidth, cellWidth);
		
		
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
		
		
		for( int i=0; null!=jobCondHistoryList && i<jobCondHistoryList.size(); i++ ){
			
			CtmInfoBean bean = (CtmInfoBean)jobCondHistoryList.get(i);

			String strCondName		= CommonUtil.isNull(bean.getCondname());
			String strCondDate		= CommonUtil.isNull(bean.getConddate());
			String strUserId		= CommonUtil.isNull(bean.getUser_id());
			String strUserNm		= CommonUtil.isNull(bean.getUser_nm());
			String strInsDate		= CommonUtil.isNull(bean.getIns_date());
			
			
			r++;
			n = -1;
			
			setCellValue(r, ++n, Integer.toString(i+1), style);
			cellWidth = Integer.toString(i+1).getBytes("UTF-8").length * 256;
			numMaxCellWidth = Math.max(numMaxCellWidth, cellWidth);
	        
			setCellValue(r, ++n, strCondName, style);
			cellWidth = strCondName.getBytes("UTF-8").length * 256;
			condNameMaxCellWidth = Math.max(condNameMaxCellWidth, cellWidth);
	        
			setCellValue(r, ++n, strCondDate, style);
			cellWidth = strCondDate.getBytes("UTF-8").length * 256;
			condDateMaxCellWidth = Math.max(condDateMaxCellWidth, cellWidth);
			
			setCellValue(r, ++n, strUserId, style);
			cellWidth = strUserId.getBytes("UTF-8").length * 256;
			userIdMaxCellWidth = Math.max(userIdMaxCellWidth, cellWidth);
			
			setCellValue(r, ++n, strUserNm, style);
			cellWidth = strUserNm.getBytes("UTF-8").length * 256;
			userNmMaxCellWidth = Math.max(userNmMaxCellWidth, cellWidth);
			
			setCellValue(r, ++n, strInsDate, style);
			cellWidth = strInsDate.getBytes("UTF-8").length * 256;
			insDateMaxCellWidth = Math.max(insDateMaxCellWidth, cellWidth);
			
			
		}
		
		n = -1;
		
		CommonUtil.setAutoSizeColumn(sheet, ++n, numMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, condNameMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, condDateMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, userIdMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, userNmMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, insDateMaxCellWidth);
		
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
