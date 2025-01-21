<%@page import="org.apache.poi.util.SystemOutLogger"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- <%@page import="com.ghayoun.ezjobs.m.domain.*"%> --%>
<%@page import="com.ghayoun.ezjobs.m.service.*"%>
<%@ page import="com.ghayoun.ezjobs.t.domain.*" %>

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

	public void setCellValue(int row, int cell, Object cellvalue) {
		Cell c = getCell(row, cell);
		c.setCellStyle(style);
		if(cellvalue instanceof Integer) {
			cellvalue = cellvalue.toString();
		}
		c.setCellValue((String)cellvalue);
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
	
	String fileName = "유저등록_샘플.xlsx"; 
	response.reset() ;
	response.setHeader("Content-Description", "JSP Generated Data");
	response.setHeader("Content-Type", "application/octet-stream; charset=UTF-8");
	response.setHeader("Content-Disposition", "attachment; filename="+java.net.URLEncoder.encode(fileName,"UTF-8").replaceAll("\\+","%20"));
	
	String user_gb_cd 			= (String)request.getAttribute("USER_GB_CD");
	String user_gb_nm 			= (String)request.getAttribute("USER_GB_NM");
	
	
%>

<%
	try {
		String[] arr_user_id 	= {"user_id1"		, "user_id2"		, "user_id3"};
		String[] arr_user_nm 	= {"홍길동1"			, "홍길동2"			, "홍길동3"};
		String[] arr_dept_nm	= {"부서1"			, "부서2"				, "부서3"};
		String[] arr_duty_nm 	= {"직책1"			, "직책2"				, "직책3"};
		String[] arr_user_email = {"1@naver.com"	, "2@naver.com"		, "3@naver.com"};
		String[] arr_user_tel 	= {"010-1111-2222"	, "010-1111-2223"	, "010-1111-2224"};
		
		sheet = wb.createSheet("Sheet1");
		
		style	= wb.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setFillForegroundColor(HSSFColor.GREY_25_PERCENT.index);
		style.setFillPattern(XSSFCellStyle.SOLID_FOREGROUND);
		style.setBorderRight(XSSFCellStyle.BORDER_THIN);
		style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
		style.setBorderTop(XSSFCellStyle.BORDER_THIN);
		style.setBorderBottom(XSSFCellStyle.BORDER_THIN);	
		
		
		
		int header_column = -1;
		
		setCellValue(0, ++header_column, "아이디");
		setCellValue(0, ++header_column, "이름");
		setCellValue(0, ++header_column, "부서");
		setCellValue(0, ++header_column, "직책");
		setCellValue(0, ++header_column, "이메일");
		setCellValue(0, ++header_column, "휴대폰번호");
		
	
		style = wb.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
		style.setBorderRight(XSSFCellStyle.BORDER_THIN);
		style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
		style.setBorderTop(XSSFCellStyle.BORDER_THIN);
		style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
		int r = 0;
		for( int i=0; i<arr_user_id.length; i++ ){
			
			int n = -1;
			r++;
			setCellValue(r, ++n, arr_user_id[i]);
			setCellValue(r, ++n, arr_user_nm[i]);
			setCellValue(r, ++n, arr_dept_nm[i]);
			setCellValue(r, ++n, arr_duty_nm[i]);
			setCellValue(r, ++n, arr_user_email[i]);
			setCellValue(r, ++n, arr_user_tel[i]);
			
			((SXSSFSheet) sheet).flushRows(10000);
		}
			
	sheet.setColumnWidth(0, (int) 0x200);

	for (int i = 0; i <= header_column; i++) {
		sheet.autoSizeColumn(i);
		
		if ( sheet.getColumnWidth(i) > 60000 ) {
			sheet.setColumnWidth(i, 60000);
		} else {
			sheet.setColumnWidth(i, sheet.getColumnWidth(i) + 700);
		}
	}
	
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
