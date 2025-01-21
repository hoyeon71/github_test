<%@page import="org.apache.poi.ss.usermodel.DataFormat"%>
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

<%@page import="org.apache.poi.hssf.util.HSSFColor"%>

<%@include file="/jsp/common/inc/header.jsp"%>

<%!
private Sheet sheet;
private CellStyle title_style;
private CellStyle left_style;
private CellStyle center_style;
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
	String menu_gb = CommonUtil.getMessage("CATEGORY.GB.09.GB."+CommonUtil.isNull(paramMap.get("menu_gb")));
	String[] arr_menu_gb = menu_gb.split(",");
	
	OutputStream os = null;
	sheet = null;
	wb = new SXSSFWorkbook();
	
	String fileName = "에러조치내역.xlsx"; 
	response.reset() ;
	response.setHeader("Content-Description", "JSP Generated Data");
	response.setHeader("Content-Type", "application/octet-stream; charset=UTF-8");
	response.setHeader("Content-Disposition", "attachment; filename="+java.net.URLEncoder.encode(fileName,"UTF-8").replaceAll("\\+","%20"));
	
	List<ErrorLogTotalBean> errorLogTotalList		= (List)request.getAttribute("errorLogTotalList");
	
	//검색조건 출력용
	String param_dept			= CommonUtil.isNull(paramMap.get("p_dept_nm"));
	String host_time 			= paramMap.get("p_s_odate")+" ~ "+paramMap.get("p_e_odate");
	String p_dept_nm 			= param_dept.equals("") ? "전체" : param_dept;
%>

<%
	try {
		
		sheet = wb.createSheet("Sheet1");
		
		format = wb.createDataFormat();
		
		// 타이틀 용 스타일
		title_style	= wb.createCellStyle();
		title_style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		title_style.setFillForegroundColor(HSSFColor.GREY_25_PERCENT.index);
		title_style.setFillPattern(XSSFCellStyle.SOLID_FOREGROUND);
		title_style.setBorderRight(XSSFCellStyle.BORDER_THIN);
		title_style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
		title_style.setBorderTop(XSSFCellStyle.BORDER_THIN);
		title_style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
		title_style.setDataFormat(format.getFormat("@")); // "@"은 텍스트 형식
		
		// LEFT 용 스타일
		left_style	= wb.createCellStyle();
		left_style.setAlignment(XSSFCellStyle.ALIGN_LEFT);
		left_style.setFillForegroundColor(HSSFColor.WHITE.index);
		left_style.setFillPattern(XSSFCellStyle.SOLID_FOREGROUND);
		left_style.setBorderRight(XSSFCellStyle.BORDER_THIN);
		left_style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
		left_style.setBorderTop(XSSFCellStyle.BORDER_THIN);
		left_style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
		left_style.setDataFormat(format.getFormat("@")); // "@"은 텍스트 형식
		
		// CENTER 용 스타일
		center_style	= wb.createCellStyle();
		center_style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		center_style.setFillForegroundColor(HSSFColor.WHITE.index);
		center_style.setFillPattern(XSSFCellStyle.SOLID_FOREGROUND);
		center_style.setBorderRight(XSSFCellStyle.BORDER_THIN);
		center_style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
		center_style.setBorderTop(XSSFCellStyle.BORDER_THIN);
		center_style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
		center_style.setDataFormat(format.getFormat("@")); // "@"은 텍스트 형식
		
		// 셀 병합  시작 (시작행, 종료행, 시작열, 종료열)
		sheet.addMergedRegion(new CellRangeAddress(0, 0, 0, 9));
		sheet.addMergedRegion(new CellRangeAddress(1, 1, 1, 9));
		sheet.addMergedRegion(new CellRangeAddress(2, 2, 1, 9));
		
		setCellValue(0, 0, arr_menu_gb[0], 	title_style);
		setCellValue(1, 0, "발생일자", 		title_style);
		setCellValue(2, 0, "부서", 			title_style);
		
		// 병합된 셀 테두리 선을 그릴때에는 셀을 하나씩 만들어주고 병합을해야 선이 그려진다.
		for( int i = 1; i <= 9; i++) {
			setCellValue(1, i, "", left_style);
			setCellValue(2, i, "", left_style);
		}
		
		setCellValue(1, 1, host_time, 	left_style);
		setCellValue(2, 1, p_dept_nm, 	left_style);
		// 셀 병합  종료
		
		int n = -1;
		int r = 4;	// 상단 검색조건만큼 아래부터 시작
		
		int cellWidth 		= 0;
		int MaxCellWidth1 	= 0;
		int MaxCellWidth2 	= 0;
		int MaxCellWidth3 	= 0;
		int MaxCellWidth4 	= 0;
		int MaxCellWidth5 	= 0;
		int MaxCellWidth6 	= 0;
		int MaxCellWidth7 	= 0;
		int MaxCellWidth8 	= 0;
		int MaxCellWidth9 	= 0;
		int MaxCellWidth10	= 0;
		
		setCellValue(r, ++n, "작업종류", title_style);
		cellWidth = "작업종류".getBytes("UTF-8").length * 256;
		MaxCellWidth1 = Math.max(MaxCellWidth1, cellWidth);
		
		setCellValue(r, ++n, "작업명", title_style);
		cellWidth = "작업명".getBytes("UTF-8").length * 256;
		MaxCellWidth2 = Math.max(MaxCellWidth2, cellWidth);
		
		setCellValue(r, ++n, "발생시간", title_style);
		cellWidth = "발생시간".getBytes("UTF-8").length * 256;
		MaxCellWidth3 = Math.max(MaxCellWidth3, cellWidth);
		
		setCellValue(r, ++n, "조치시간", title_style);
		cellWidth = "조치시간".getBytes("UTF-8").length * 256;
		MaxCellWidth4 = Math.max(MaxCellWidth4, cellWidth);
		
		setCellValue(r, ++n, "조치자", title_style);
		cellWidth = "조치자".getBytes("UTF-8").length * 256;
		MaxCellWidth5 = Math.max(MaxCellWidth5, cellWidth);
		
		setCellValue(r, ++n, "원인 및 조치내용", title_style);
		cellWidth = "원인 및 조치내용".getBytes("UTF-8").length * 256;
		MaxCellWidth6 = Math.max(MaxCellWidth6, cellWidth);
		
		setCellValue(r, ++n, "메시지", title_style);
		cellWidth = "메시지".getBytes("UTF-8").length * 256;
		MaxCellWidth7 = Math.max(MaxCellWidth7, cellWidth);
		
		setCellValue(r, ++n, "부서", title_style);
		cellWidth = "부서".getBytes("UTF-8").length * 256;
		MaxCellWidth8 = Math.max(MaxCellWidth8, cellWidth);
		
		setCellValue(r, ++n, "직급", title_style);
		cellWidth = "직급".getBytes("UTF-8").length * 256;
		MaxCellWidth9 = Math.max(MaxCellWidth9, cellWidth);
		
		setCellValue(r, ++n, "담당자", title_style);
		cellWidth = "담당자".getBytes("UTF-8").length * 256;
		MaxCellWidth10 = Math.max(MaxCellWidth10, cellWidth);
		
		for( int i=0; null!=errorLogTotalList && i<errorLogTotalList.size(); i++ ){
			
			ErrorLogTotalBean bean 			= (ErrorLogTotalBean)errorLogTotalList.get(i);
			
			String strJobschedgb		= CommonUtil.isNull(bean.getJobschedgb());
			String strJobName	 		= CommonUtil.isNull(bean.getJob_name());
			String strHostTime	 		= CommonUtil.isNull(bean.getHost_time());
			String strActionDate 		= CommonUtil.isNull(bean.getAction_date());
			String strUdtUserNm			= CommonUtil.isNull(bean.getUdt_user_nm());
			String strErrorDescription	= CommonUtil.isNull(bean.getError_description());
			String strMessage	 		= CommonUtil.isNull(bean.getMessage());
			String strDeptNm	 		= CommonUtil.isNull(bean.getDept_nm());
			String strDutyNm			= CommonUtil.isNull(bean.getDuty_nm());
			String strUserNm	 		= CommonUtil.isNull(bean.getUser_nm());
			
			r++;
			n = -1;
			
			setCellValue(r, ++n, strJobschedgb, center_style);
			cellWidth = strJobschedgb.getBytes("UTF-8").length * 256;
			MaxCellWidth1 = Math.max(MaxCellWidth1, cellWidth);
			
			setCellValue(r, ++n, strJobName, left_style);
			cellWidth = strJobName.getBytes("UTF-8").length * 256;
			MaxCellWidth2 = Math.max(MaxCellWidth2, cellWidth);
			
			setCellValue(r, ++n, strHostTime, center_style);
			cellWidth = strHostTime.getBytes("UTF-8").length * 256;
			MaxCellWidth3 = Math.max(MaxCellWidth3, cellWidth);
			
			setCellValue(r, ++n, strActionDate, center_style);
			cellWidth = strActionDate.getBytes("UTF-8").length * 256;
			MaxCellWidth4 = Math.max(MaxCellWidth4, cellWidth);
			
			setCellValue(r, ++n, strUdtUserNm, center_style);
			cellWidth = strUdtUserNm.getBytes("UTF-8").length * 256;
			MaxCellWidth5 = Math.max(MaxCellWidth5, cellWidth);
			
			setCellValue(r, ++n, CommonUtil.replaceStrHtml(strErrorDescription), center_style);
			cellWidth = strErrorDescription.getBytes("UTF-8").length * 256;
			MaxCellWidth6 = Math.max(MaxCellWidth6, cellWidth);
			
			setCellValue(r, ++n, strMessage, center_style);
			cellWidth = strMessage.getBytes("UTF-8").length * 256;
			MaxCellWidth7 = Math.max(MaxCellWidth7, cellWidth);
			
			setCellValue(r, ++n, strDeptNm, center_style);
			cellWidth = strDeptNm.getBytes("UTF-8").length * 256;
			MaxCellWidth8 = Math.max(MaxCellWidth8, cellWidth);
			
			setCellValue(r, ++n, strDutyNm, center_style);
			cellWidth = strDutyNm.getBytes("UTF-8").length * 256;
			MaxCellWidth9 = Math.max(MaxCellWidth9, cellWidth);
			
			setCellValue(r, ++n, strUserNm, center_style);
			cellWidth = strUserNm.getBytes("UTF-8").length * 256;
			MaxCellWidth10 = Math.max(MaxCellWidth10, cellWidth);
		}
			
		n = -1;
		
		CommonUtil.setAutoSizeColumn(sheet, ++n, MaxCellWidth1);
		CommonUtil.setAutoSizeColumn(sheet, ++n, MaxCellWidth2);
		CommonUtil.setAutoSizeColumn(sheet, ++n, MaxCellWidth3);
		CommonUtil.setAutoSizeColumn(sheet, ++n, MaxCellWidth4);
		CommonUtil.setAutoSizeColumn(sheet, ++n, MaxCellWidth5);
		CommonUtil.setAutoSizeColumn(sheet, ++n, MaxCellWidth6);
		CommonUtil.setAutoSizeColumn(sheet, ++n, MaxCellWidth7);
		CommonUtil.setAutoSizeColumn(sheet, ++n, MaxCellWidth8);
		CommonUtil.setAutoSizeColumn(sheet, ++n, MaxCellWidth9);
		CommonUtil.setAutoSizeColumn(sheet, ++n, MaxCellWidth10);
		
		// 상단 검색조건 있는 경우 해당 타이틀로 WIDTH 조정
		sheet.setColumnWidth(0, 3000);
		
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