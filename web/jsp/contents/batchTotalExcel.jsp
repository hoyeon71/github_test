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

	Map<String, Object> paramMap = CommonUtil.collectParameters(request);
	String menu_gb = CommonUtil.getMessage("CATEGORY.GB.09.GB."+CommonUtil.isNull(paramMap.get("menu_gb")));
	String[] arr_menu_gb = menu_gb.split(",");
	
	OutputStream os = null;
	sheet = null;
	wb = new SXSSFWorkbook();
	
	String fileName = "폴더별누적배치.xlsx"; 
	response.reset() ;
	response.setHeader("Content-Description", "JSP Generated Data");
	response.setHeader("Content-Type", "application/octet-stream; charset=UTF-8");
	response.setHeader("Content-Disposition", "attachment; filename="+java.net.URLEncoder.encode(fileName,"UTF-8").replaceAll("\\+","%20"));
	
	List<BatchTotalBean> batchTotalList		= (List)request.getAttribute("batchTotalList");
	
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
		sheet.addMergedRegion(new CellRangeAddress(0, 0, 0, 14));
		sheet.addMergedRegion(new CellRangeAddress(1, 1, 1, 14));
		sheet.addMergedRegion(new CellRangeAddress(2, 2, 1, 14));
		sheet.addMergedRegion(new CellRangeAddress(3, 3, 1, 14));
		sheet.addMergedRegion(new CellRangeAddress(4, 4, 1, 14));
		
		setCellValue(0, 0, arr_menu_gb[0], 		title_style);
		setCellValue(1, 0, "ODATE", 			title_style);
		setCellValue(2, 0, "폴더", 				title_style);
		setCellValue(3, 0, "어플리케이션", 			title_style);
		setCellValue(4, 0, "그룹", 				title_style);
		
		// 병합된 셀 테두리 선을 그릴때에는 셀을 하나씩 만들어주고 병합을해야 선이 그려진다.
		for( int i = 1; i <= 14; i++) {
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
		
		setCellValue(r, ++n, "정기-신규", title_style);
		cellWidth = "정기-신규".getBytes("UTF-8").length * 256;
		MaxCellWidth5 = Math.max(MaxCellWidth5, cellWidth);
		
		setCellValue(r, ++n, "정기-수정", title_style);
		cellWidth = "정기-수정".getBytes("UTF-8").length * 256;
		MaxCellWidth6 = Math.max(MaxCellWidth6, cellWidth);
		
		setCellValue(r, ++n, "정기-삭제", title_style);
		cellWidth = "정기-삭제".getBytes("UTF-8").length * 256;
		MaxCellWidth7 = Math.max(MaxCellWidth7, cellWidth);
		
		setCellValue(r, ++n, "정기-수행", title_style);
		cellWidth = "정기-수행".getBytes("UTF-8").length * 256;
		MaxCellWidth8 = Math.max(MaxCellWidth8, cellWidth);
		
		setCellValue(r, ++n, "정기-상태변경", title_style);
		cellWidth = "정기-상태변경".getBytes("UTF-8").length * 256;
		MaxCellWidth9 = Math.max(MaxCellWidth9, cellWidth);
		
		setCellValue(r, ++n, "수시-신규", title_style);
		cellWidth = "수시-신규".getBytes("UTF-8").length * 256;
		MaxCellWidth10 = Math.max(MaxCellWidth10, cellWidth);
		
		setCellValue(r, ++n, "수시-수정", title_style);
		cellWidth = "수시-수정".getBytes("UTF-8").length * 256;
		MaxCellWidth11 = Math.max(MaxCellWidth11, cellWidth);
		
		setCellValue(r, ++n, "수시-삭제", title_style);
		cellWidth = "수시-삭제".getBytes("UTF-8").length * 256;
		MaxCellWidth12 = Math.max(MaxCellWidth12, cellWidth);
		
		setCellValue(r, ++n, "수시-수행", title_style);
		cellWidth = "수시-수행".getBytes("UTF-8").length * 256;
		MaxCellWidth13 = Math.max(MaxCellWidth13, cellWidth);
		
		setCellValue(r, ++n, "수시-상태변경", title_style);
		cellWidth = "수시-상태변경".getBytes("UTF-8").length * 256;
		MaxCellWidth14 = Math.max(MaxCellWidth14, cellWidth);
		
		setCellValue(r, ++n, "TOTAL", title_style);
		cellWidth = "TOTAL".getBytes("UTF-8").length * 256;
		MaxCellWidth15 = Math.max(MaxCellWidth15, cellWidth);

		for( int i=0; null!=batchTotalList && i<batchTotalList.size(); i++ ){
			
			BatchTotalBean bean 			= (BatchTotalBean)batchTotalList.get(i);
			
			String strDataCenter 		= CommonUtil.isNull(bean.getData_center());
			String strTableName 		= CommonUtil.isNull(bean.getTable_name());
			String strApplication 		= CommonUtil.isNull(bean.getApplication());
			String strGroupName 		= CommonUtil.isNull(bean.getGroup_name());
			String strRegNewCnt			= CommonUtil.isNull(bean.getReg_new_cnt());
			String strRegModCnt			= CommonUtil.isNull(bean.getReg_mod_cnt());
			String strRegDelCnt			= CommonUtil.isNull(bean.getReg_del_cnt());
			String strRegOrdCnt			= CommonUtil.isNull(bean.getReg_ord_cnt());
			String strRegChgCondCnt		= CommonUtil.isNull(bean.getReg_chg_cond_cnt());
			String strIrregNewCnt		= CommonUtil.isNull(bean.getIrreg_new_cnt());
			String strIrregModCnt		= CommonUtil.isNull(bean.getIrreg_mod_cnt());
			String strIrregDelCnt		= CommonUtil.isNull(bean.getIrreg_del_cnt());
			String strIrregOrdCnt		= CommonUtil.isNull(bean.getIrreg_ord_cnt());
			String strIrregChgCondCnt	= CommonUtil.isNull(bean.getIrreg_chg_cond_cnt());
			String strTotalCnt			= CommonUtil.isNull(bean.getTotal_cnt());
			
			r++;
			n = -1;
			
			setCellValue(r, ++n, strDataCenter, center_style);
			cellWidth = strDataCenter.getBytes("UTF-8").length * 256;
			MaxCellWidth1 = Math.max(MaxCellWidth1, cellWidth);
			
			setCellValue(r, ++n, strTableName, center_style);
			cellWidth = strTableName.getBytes("UTF-8").length * 256;
			MaxCellWidth2 = Math.max(MaxCellWidth2, cellWidth);
			
			setCellValue(r, ++n, strApplication, center_style);
			cellWidth = strApplication.getBytes("UTF-8").length * 256;
			MaxCellWidth3 = Math.max(MaxCellWidth3, cellWidth);
			
			setCellValue(r, ++n, strGroupName, center_style);
			cellWidth = strGroupName.getBytes("UTF-8").length * 256;
			MaxCellWidth4 = Math.max(MaxCellWidth4, cellWidth);
			
			setCellValue(r, ++n, strRegNewCnt, center_style);
			cellWidth = strRegNewCnt.getBytes("UTF-8").length * 256;
			MaxCellWidth5 = Math.max(MaxCellWidth5, cellWidth);
			
			setCellValue(r, ++n, strRegModCnt, center_style);
			cellWidth = strRegModCnt.getBytes("UTF-8").length * 256;
			MaxCellWidth6 = Math.max(MaxCellWidth6, cellWidth);
			
			setCellValue(r, ++n, strRegDelCnt, center_style);
			cellWidth = strRegDelCnt.getBytes("UTF-8").length * 256;
			MaxCellWidth7 = Math.max(MaxCellWidth7, cellWidth);
			
			setCellValue(r, ++n, strRegOrdCnt, center_style);
			cellWidth = strRegOrdCnt.getBytes("UTF-8").length * 256;
			MaxCellWidth8 = Math.max(MaxCellWidth8, cellWidth);
			
			setCellValue(r, ++n, strRegChgCondCnt, center_style);
			cellWidth = strRegChgCondCnt.getBytes("UTF-8").length * 256;
			MaxCellWidth9 = Math.max(MaxCellWidth9, cellWidth);
			
			setCellValue(r, ++n, strIrregNewCnt, center_style);
			cellWidth = strIrregNewCnt.getBytes("UTF-8").length * 256;
			MaxCellWidth10 = Math.max(MaxCellWidth10, cellWidth);
			
			setCellValue(r, ++n, strIrregModCnt, center_style);
			cellWidth = strIrregModCnt.getBytes("UTF-8").length * 256;
			MaxCellWidth11 = Math.max(MaxCellWidth11, cellWidth);
			
			setCellValue(r, ++n, strIrregDelCnt, center_style);
			cellWidth = strIrregDelCnt.getBytes("UTF-8").length * 256;
			MaxCellWidth12 = Math.max(MaxCellWidth12, cellWidth);
			
			setCellValue(r, ++n, strIrregOrdCnt, center_style);
			cellWidth = strIrregOrdCnt.getBytes("UTF-8").length * 256;
			MaxCellWidth13 = Math.max(MaxCellWidth13, cellWidth);
			
			setCellValue(r, ++n, strIrregChgCondCnt, center_style);
			cellWidth = strIrregChgCondCnt.getBytes("UTF-8").length * 256;
			MaxCellWidth14 = Math.max(MaxCellWidth14, cellWidth);
			
			setCellValue(r, ++n, strTotalCnt, center_style);
			cellWidth = strTotalCnt.getBytes("UTF-8").length * 256;
			MaxCellWidth15 = Math.max(MaxCellWidth15, cellWidth);
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
