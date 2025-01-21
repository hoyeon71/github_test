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
	
	String fileName = "상세수행현황.xlsx"; 
	response.reset() ;
	response.setHeader("Content-Description", "JSP Generated Data");
	response.setHeader("Content-Type", "application/octet-stream; charset=UTF-8");
	response.setHeader("Content-Disposition", "attachment; filename="+java.net.URLEncoder.encode(fileName,"UTF-8").replaceAll("\\+","%20"));
	
	List<JobCondTotalBean> jobCondTotalList		= (List)request.getAttribute("jobCondTotalList");
	
	//검색조건 출력용
	String param_table			= CommonUtil.isNull(paramMap.get("p_sched_table"));
	String param_app			= CommonUtil.isNull(paramMap.get("p_application_of_def"));
	String param_grp			= CommonUtil.isNull(paramMap.get("p_group_name_of_def"));
	
	String odate 				= paramMap.get("p_s_odate")+" ~ "+paramMap.get("p_e_odate");
	String p_sched_table 		= param_table.equals("") ? "전체" : param_table;
	String p_application_of_def = param_app.equals("") ? "전체" : param_app;
	String p_group_name_of_def 	= param_grp.equals("") ? "전체" : param_grp;
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
		sheet.addMergedRegion(new CellRangeAddress(0, 0, 0, 15));
		sheet.addMergedRegion(new CellRangeAddress(1, 1, 1, 15));
		sheet.addMergedRegion(new CellRangeAddress(2, 2, 1, 15));
		sheet.addMergedRegion(new CellRangeAddress(3, 3, 1, 15));
		sheet.addMergedRegion(new CellRangeAddress(4, 4, 1, 15));
		
		setCellValue(0, 0, arr_menu_gb[0], 		title_style);
		setCellValue(1, 0, "ODATE", 			title_style);
		setCellValue(2, 0, "폴더", 				title_style);
		setCellValue(3, 0, "어플리케이션", 			title_style);
		setCellValue(4, 0, "그룹", 				title_style);
		
		// 병합된 셀 테두리 선을 그릴때에는 셀을 하나씩 만들어주고 병합을해야 선이 그려진다.
		for( int i = 1; i <= 15; i++) {
			setCellValue(1, i, "", left_style);
			setCellValue(2, i, "", left_style);
			setCellValue(3, i, "", left_style);
			setCellValue(4, i, "", left_style);
		}
		
		setCellValue(1, 1, odate, 					left_style);
		setCellValue(2, 1, p_sched_table, 			left_style);
		setCellValue(3, 1, p_application_of_def, 	left_style);
		setCellValue(4, 1, p_group_name_of_def, 	left_style);
		// 셀 병합  종료

		int n = -1;
		int r = 6;	// 상단 검색조건만큼 아래부터 시작
		
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
		int MaxCellWidth11 	= 0;
		int MaxCellWidth12 	= 0;
		int MaxCellWidth13 	= 0;
		int MaxCellWidth14 	= 0;
		int MaxCellWidth15 	= 0;
		int MaxCellWidth16 	= 0;
		
		setCellValue(r, ++n, "C-M", title_style);
		cellWidth = "C-M".getBytes("UTF-8").length * 256;
		MaxCellWidth1 = Math.max(MaxCellWidth1, cellWidth);
		
		setCellValue(r, ++n, "폴더", title_style);
		cellWidth = "폴더".getBytes("UTF-8").length * 256;
		MaxCellWidth2 = Math.max(MaxCellWidth2, cellWidth);
		
		setCellValue(r, ++n, "어플리케이션", title_style);
		cellWidth = "어플리케이션".getBytes("UTF-8").length * 256;
		MaxCellWidth3 = Math.max(MaxCellWidth3, cellWidth);
		
		setCellValue(r, ++n, "그룹", title_style);
		cellWidth = "그룹".getBytes("UTF-8").length * 256;
		MaxCellWidth4 = Math.max(MaxCellWidth4, cellWidth);
		
		setCellValue(r, ++n, "정기-Ended Ok", title_style);
		cellWidth = "정기-Ended Ok".getBytes("UTF-8").length * 256;
		MaxCellWidth5 = Math.max(MaxCellWidth5, cellWidth);
		
		setCellValue(r, ++n, "정기-Ended Not Ok", title_style);
		cellWidth = "정기-Ended Not Ok".getBytes("UTF-8").length * 256;
		MaxCellWidth6 = Math.max(MaxCellWidth6, cellWidth);
		
		setCellValue(r, ++n, "정기-Wait", title_style);
		cellWidth = "정기-Wait".getBytes("UTF-8").length * 256;
		MaxCellWidth7 = Math.max(MaxCellWidth7, cellWidth);
		
		setCellValue(r, ++n, "정기-Etc.", title_style);
		cellWidth = "정기-Etc.".getBytes("UTF-8").length * 256;
		MaxCellWidth8 = Math.max(MaxCellWidth8, cellWidth);
		
		setCellValue(r, ++n, "정기-TOTAL", title_style);
		cellWidth = "정기-TOTAL".getBytes("UTF-8").length * 256;
		MaxCellWidth9 = Math.max(MaxCellWidth9, cellWidth);
		
		setCellValue(r, ++n, "정기-에러율", title_style);
		cellWidth = "정기-에러율".getBytes("UTF-8").length * 256;
		MaxCellWidth10 = Math.max(MaxCellWidth10, cellWidth);
		
		setCellValue(r, ++n, "수시-Ended Ok", title_style);
		cellWidth = "수시-Ended Ok".getBytes("UTF-8").length * 256;
		MaxCellWidth11 = Math.max(MaxCellWidth11, cellWidth);
		
		setCellValue(r, ++n, "수시-Ended Not Ok", title_style);
		cellWidth = "수시-Ended Not Ok".getBytes("UTF-8").length * 256;
		MaxCellWidth12 = Math.max(MaxCellWidth12, cellWidth);
		
		setCellValue(r, ++n, "수시-Wait", title_style);
		cellWidth = "수시-Wait".getBytes("UTF-8").length * 256;
		MaxCellWidth13 = Math.max(MaxCellWidth13, cellWidth);
		
		setCellValue(r, ++n, "수시-Etc.", title_style);
		cellWidth = "수시-Etc.".getBytes("UTF-8").length * 256;
		MaxCellWidth14 = Math.max(MaxCellWidth14, cellWidth);
		
		setCellValue(r, ++n, "수시-TOTAL", title_style);
		cellWidth = "수시-TOTAL".getBytes("UTF-8").length * 256;
		MaxCellWidth15 = Math.max(MaxCellWidth15, cellWidth);
		
		setCellValue(r, ++n, "수시-에러율", title_style);
		cellWidth = "수시-에러율".getBytes("UTF-8").length * 256;
		MaxCellWidth16 = Math.max(MaxCellWidth16, cellWidth);

		for( int i=0; null!=jobCondTotalList && i<jobCondTotalList.size(); i++ ){
			
			JobCondTotalBean bean 			= (JobCondTotalBean)jobCondTotalList.get(i);
			
			String strDataCenter 		= CommonUtil.isNull(bean.getData_center());
			String strOrderTable 		= CommonUtil.isNull(bean.getOrder_table());
			String strApplication 		= CommonUtil.isNull(bean.getApplication());
			String strGroupName 		= CommonUtil.isNull(bean.getGroup_name());
			
			String strRegOkCnt			= CommonUtil.isNull(bean.getReg_ok_cnt());
			String strRegFailCnt		= CommonUtil.isNull(bean.getReg_fail_cnt());
			String strRegWaitCnt		= CommonUtil.isNull(bean.getReg_wait_cnt());
			String strRegEtcCnt			= CommonUtil.isNull(bean.getReg_etc_cnt());
			String strRegTotalCnt		= CommonUtil.isNull(bean.getReg_total_cnt());
			String strRegErrorCnt		= "-";
			if (!strRegTotalCnt.equals("0")) {
				strRegErrorCnt = 100 * Integer.parseInt(strRegFailCnt) / Integer.parseInt(strRegTotalCnt) + "%";
			}
			
			String strIrregOkCnt		= CommonUtil.isNull(bean.getIrreg_ok_cnt());
			String strIrregFailCnt		= CommonUtil.isNull(bean.getIrreg_fail_cnt());
			String strIrregWaitCnt		= CommonUtil.isNull(bean.getIrreg_wait_cnt());
			String strIrregEtcCnt		= CommonUtil.isNull(bean.getIrreg_etc_cnt());
			String strIrregTotalCnt		= CommonUtil.isNull(bean.getIrreg_total_cnt());
			String strIrregErrorCnt		= "-";
			if (!strIrregTotalCnt.equals("0")) {
				strIrregErrorCnt = 100 * Integer.parseInt(strIrregFailCnt) / Integer.parseInt(strIrregTotalCnt) + "%";
			}

			r++;
			n = -1;
			
			setCellValue(r, ++n, strDataCenter, center_style);
			cellWidth = strDataCenter.getBytes("UTF-8").length * 256;
			MaxCellWidth1 = Math.max(MaxCellWidth1, cellWidth);
			
			setCellValue(r, ++n, strOrderTable, center_style);
			cellWidth = strOrderTable.getBytes("UTF-8").length * 256;
			MaxCellWidth2 = Math.max(MaxCellWidth2, cellWidth);
			
			setCellValue(r, ++n, strApplication, center_style);
			cellWidth = strApplication.getBytes("UTF-8").length * 256;
			MaxCellWidth3 = Math.max(MaxCellWidth3, cellWidth);
			
			setCellValue(r, ++n, strGroupName, center_style);
			cellWidth = strGroupName.getBytes("UTF-8").length * 256;
			MaxCellWidth4 = Math.max(MaxCellWidth4, cellWidth);
			
			setCellValue(r, ++n, strRegOkCnt, center_style);
			cellWidth = strRegOkCnt.getBytes("UTF-8").length * 256;
			MaxCellWidth5 = Math.max(MaxCellWidth5, cellWidth);
			
			setCellValue(r, ++n, strRegFailCnt, center_style);
			cellWidth = strRegFailCnt.getBytes("UTF-8").length * 256;
			MaxCellWidth6 = Math.max(MaxCellWidth6, cellWidth);
			
			setCellValue(r, ++n, strRegWaitCnt, center_style);
			cellWidth = strRegWaitCnt.getBytes("UTF-8").length * 256;
			MaxCellWidth7 = Math.max(MaxCellWidth7, cellWidth);
			
			setCellValue(r, ++n, strRegEtcCnt, center_style);
			cellWidth = strRegEtcCnt.getBytes("UTF-8").length * 256;
			MaxCellWidth8 = Math.max(MaxCellWidth8, cellWidth);
			
			setCellValue(r, ++n, strRegTotalCnt, center_style);
			cellWidth = strRegTotalCnt.getBytes("UTF-8").length * 256;
			MaxCellWidth9 = Math.max(MaxCellWidth9, cellWidth);
			
			setCellValue(r, ++n, strRegErrorCnt, center_style);
			cellWidth = strRegErrorCnt.getBytes("UTF-8").length * 256;
			MaxCellWidth10 = Math.max(MaxCellWidth10, cellWidth);
			
			setCellValue(r, ++n, strIrregOkCnt, center_style);
			cellWidth = strIrregOkCnt.getBytes("UTF-8").length * 256;
			MaxCellWidth11 = Math.max(MaxCellWidth11, cellWidth);
			
			setCellValue(r, ++n, strIrregFailCnt, center_style);
			cellWidth = strIrregFailCnt.getBytes("UTF-8").length * 256;
			MaxCellWidth12 = Math.max(MaxCellWidth12, cellWidth);
			
			setCellValue(r, ++n, strIrregWaitCnt, center_style);
			cellWidth = strIrregWaitCnt.getBytes("UTF-8").length * 256;
			MaxCellWidth13 = Math.max(MaxCellWidth13, cellWidth);
			
			setCellValue(r, ++n, strIrregEtcCnt, center_style);
			cellWidth = strIrregEtcCnt.getBytes("UTF-8").length * 256;
			MaxCellWidth14 = Math.max(MaxCellWidth14, cellWidth);
			
			setCellValue(r, ++n, strIrregTotalCnt, center_style);
			cellWidth = strIrregTotalCnt.getBytes("UTF-8").length * 256;
			MaxCellWidth15 = Math.max(MaxCellWidth15, cellWidth);
			
			setCellValue(r, ++n, strIrregErrorCnt, center_style);
			cellWidth = strIrregErrorCnt.getBytes("UTF-8").length * 256;
			MaxCellWidth16 = Math.max(MaxCellWidth16, cellWidth);
						
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
		CommonUtil.setAutoSizeColumn(sheet, ++n, MaxCellWidth11);
		CommonUtil.setAutoSizeColumn(sheet, ++n, MaxCellWidth12);
		CommonUtil.setAutoSizeColumn(sheet, ++n, MaxCellWidth13);
		CommonUtil.setAutoSizeColumn(sheet, ++n, MaxCellWidth14);
		CommonUtil.setAutoSizeColumn(sheet, ++n, MaxCellWidth15);
		CommonUtil.setAutoSizeColumn(sheet, ++n, MaxCellWidth16);
		
		// 상단 검색조건 있는 경우 해당 타이틀로 WIDTH 조정
		sheet.setColumnWidth(0, 6000);	
		
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