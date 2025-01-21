<%@page import="org.apache.poi.ss.util.CellRangeAddress"%>
<%@page import="java.util.Date"%>
<%@page import="org.apache.poi.ss.usermodel.DateUtil"%>
<%@page import="org.apache.poi.ss.usermodel.DataFormat"%>
<%@page import="org.apache.poi.xssf.usermodel.XSSFColor"%>
<%@page import="org.apache.poi.ss.usermodel.Font"%>
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
	private CellStyle style;
	private CellStyle style2;
	private CellStyle style3;
	private CellStyle style4;
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

	String fileName = "마감배치보고서.xlsx";
	response.reset() ;
	response.setHeader("Content-Description", "JSP Generated Data");
	response.setHeader("Content-Type", "application/octet-stream; charset=UTF-8");
	response.setHeader("Content-Disposition", "attachment; filename="+java.net.URLEncoder.encode(fileName,"UTF-8").replaceAll("\\+","%20"));

	List<BatchResultTotalBean> batchReportList		= (List)request.getAttribute("batchReport");

	//검색조건 출력용
	String param_table			= CommonUtil.isNull(paramMap.get("p_sched_table"));
	String param_app			= CommonUtil.isNull(paramMap.get("p_application_of_def"));
	String param_grp			= CommonUtil.isNull(paramMap.get("p_group_name_of_def"));

	String odate 				= paramMap.get("p_s_odate")+" ~ "+paramMap.get("p_e_odate");
	String p_sched_table 		= param_table.equals("") ? "전체" : param_table;
	String p_application_of_def = param_app.equals("") ? "전체" : param_app;
	String p_group_name_of_def 	= param_grp.equals("") ? "전체" : param_grp;
	
	String s_odate 				= CommonUtil.isNull(paramMap.get("p_s_odate"));
	String e_odate 				= CommonUtil.isNull(paramMap.get("p_e_odate"));
	String today				= "";
	
	if(s_odate.equals(e_odate)){
		today				= CommonUtil.getDateFormat(3, CommonUtil.isNull(paramMap.get("p_e_odate")));
	}else{
		today				= CommonUtil.getDateFormat(3, s_odate) + " ~ " + CommonUtil.getDateFormat(3, e_odate);
	}

	PopupDefJobDetailService popupDefJobDetailService 	= (PopupDefJobDetailService)ContextLoader.getCurrentWebApplicationContext().getBean("mPopupDefJobDetailService");

%>

<%
	try {
		sheet = wb.createSheet("Sheet1");

		format = wb.createDataFormat();
		
		//우측 최대값(셀병합할때 사용)
		int rightSize = 8;
		
		//검은바탕에 테두리 진하게 가운데 글씨
		style	= wb.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setFillForegroundColor(HSSFColor.GREY_25_PERCENT.index);
		style.setFillPattern(XSSFCellStyle.SOLID_FOREGROUND);
		style.setBorderRight(XSSFCellStyle.BORDER_THIN);
		style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
		style.setBorderTop(XSSFCellStyle.BORDER_THIN);
		style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
		style.setDataFormat(format.getFormat("@")); // "@"은 텍스트 형식
		
		//하얀바탕에 테두리 진하게 가운데 글씨
		style2	= wb.createCellStyle();
		style2.setAlignment(XSSFCellStyle.ALIGN_CENTER);
// 		style2.setFillForegroundColor(HSSFColor.GREY_25_PERCENT.index);
// 		style2.setFillPattern(XSSFCellStyle.SOLID_FOREGROUND);
		style2.setBorderRight(XSSFCellStyle.BORDER_THIN);
		style2.setBorderLeft(XSSFCellStyle.BORDER_THIN);
		style2.setBorderTop(XSSFCellStyle.BORDER_THIN);
		style2.setBorderBottom(XSSFCellStyle.BORDER_THIN);
		style2.setDataFormat(format.getFormat("@")); // "@"은 텍스트 형식
		
		//검은바탕에 테두리 진하게 왼쪽 글씨
		style4	= wb.createCellStyle();
		style4.setAlignment(XSSFCellStyle.ALIGN_LEFT);
		style4.setFillForegroundColor(HSSFColor.GREY_25_PERCENT.index);
		style4.setFillPattern(XSSFCellStyle.SOLID_FOREGROUND);
		style4.setBorderRight(XSSFCellStyle.BORDER_THIN);
		style4.setBorderLeft(XSSFCellStyle.BORDER_THIN);
		style4.setBorderTop(XSSFCellStyle.BORDER_THIN);
		style4.setBorderBottom(XSSFCellStyle.BORDER_THIN);
		style4.setDataFormat(format.getFormat("@")); // "@"은 텍스트 형식
		
		// 문서 제목 로우 생성
		Row title_row = sheet.createRow((short)2);
		
		// 셀 생성
		Cell title_cell = title_row.createCell(1);
		Cell title_cell2 = title_row.createCell(2);
		Cell title_cell3 = title_row.createCell(3);
		Cell title_cell4 = title_row.createCell(4);
		Cell title_cell5 = title_row.createCell(7);
		Cell title_cell6 = title_row.createCell(8);
		
		//생성한 cell에 스타일 적용
	    title_cell.setCellStyle(style);
	    title_cell2.setCellStyle(style);
	    title_cell3.setCellStyle(style);
	    title_cell4.setCellStyle(style);
	    title_cell5.setCellStyle(style2);
	    title_cell6.setCellStyle(style2);
	    
		// 생성한 cell에 데이터 입력
	    title_cell.setCellValue("Control-M 마감리스트");

		//셀 병합 방법 -  cell 생성 후 병합
		sheet.addMergedRegion(new CellRangeAddress(2,2,1,4));
		
		// 당일날짜
		Row todayRow = sheet.createRow((short)3);
		Cell todayCell = todayRow.createCell((short)1);
		Cell todayCell2 = todayRow.createCell((short)2);
		Cell todayCell3 = todayRow.createCell((short)3);
		Cell todayCell4 = todayRow.createCell((short)4);
		Cell todayCell5 = todayRow.createCell((short)7);
		Cell todayCell6 = todayRow.createCell((short)8);
		sheet.addMergedRegion(new CellRangeAddress(3,3,1,4));
		todayCell.setCellValue(today);
		todayCell.setCellStyle(style2);
		todayCell2.setCellStyle(style2);
		todayCell3.setCellStyle(style2);
		todayCell4.setCellStyle(style2);
		todayCell5.setCellStyle(style2);
		todayCell6.setCellStyle(style2);
		
		// 담당
 		Row userRow = sheet.createRow((short)1);
 		Cell userCell = userRow.createCell((short)7);
 		userCell.setCellValue("담당");
 		userCell.setCellStyle(style);
 	   	sheet.addMergedRegion(new CellRangeAddress(2,3,7,7));
	 	    
 		// 팀장
		Cell userCell2 = userRow.createCell((short)8);
		userCell2.setCellValue("팀장");
		userCell2.setCellStyle(style);
	    sheet.addMergedRegion(new CellRangeAddress(2,3,8,8));
	    
	 	// night&daily
		Row nightRow = sheet.createRow((short)5);
		Cell nightCell0 = nightRow.createCell((short)0);
		Cell nightCell1 = nightRow.createCell((short)1);
		Cell nightCell2 = nightRow.createCell((short)2);
		Cell nightCell3 = nightRow.createCell((short)3);
		Cell nightCell4 = nightRow.createCell((short)4);
		Cell nightCell5 = nightRow.createCell((short)5);
		Cell nightCell6 = nightRow.createCell((short)6);
		Cell nightCell7 = nightRow.createCell((short)7);
		Cell nightCell8 = nightRow.createCell((short)8);
		
		nightCell0.setCellValue("NIGHT : ");
		nightCell0.setCellStyle(style2);
		nightCell1.setCellStyle(style2);
		nightCell2.setCellStyle(style2);
		nightCell3.setCellStyle(style2);
		nightCell4.setCellStyle(style2);
		nightCell5.setCellStyle(style2);
		nightCell6.setCellStyle(style2);
		nightCell7.setCellStyle(style2);
		nightCell8.setCellStyle(style2);
	   	sheet.addMergedRegion(new CellRangeAddress(5,5,0,1));
	   	sheet.addMergedRegion(new CellRangeAddress(5,5,2,3));
	   	sheet.addMergedRegion(new CellRangeAddress(5,5,4,rightSize));
	   	
	   	Row DailyRow = sheet.createRow((short)6);
		Cell DailyCell0 = DailyRow.createCell((short)0);
		Cell DailyCell1 = DailyRow.createCell((short)1);
		Cell DailyCell2 = DailyRow.createCell((short)2);
		Cell DailyCell3 = DailyRow.createCell((short)3);
		Cell DailyCell4 = DailyRow.createCell((short)4);
		Cell DailyCell5 = DailyRow.createCell((short)5);
		Cell DailyCell6 = DailyRow.createCell((short)6);
		Cell DailyCell7 = DailyRow.createCell((short)7);
		Cell DailyCell8 = DailyRow.createCell((short)8);
		DailyCell0.setCellValue("DAILY : ");
		DailyCell0.setCellStyle(style2);
		DailyCell1.setCellStyle(style2);
		DailyCell2.setCellStyle(style2);
		DailyCell3.setCellStyle(style2);
		DailyCell4.setCellStyle(style2);
		DailyCell5.setCellStyle(style2);
		DailyCell6.setCellStyle(style2);
		DailyCell7.setCellStyle(style2);
		DailyCell8.setCellStyle(style2);
	   	sheet.addMergedRegion(new CellRangeAddress(6,6,0,1));
		sheet.addMergedRegion(new CellRangeAddress(6,6,2,3));
		sheet.addMergedRegion(new CellRangeAddress(6,6,4,rightSize));

		// 마감 요약 정보
		Row titleRow = sheet.createRow((short)8);
		Cell titleCell0 = titleRow.createCell((short)0);
		Cell titleCell1 = titleRow.createCell((short)1);
		Cell titleCell2 = titleRow.createCell((short)2);
		Cell titleCell3 = titleRow.createCell((short)3);
		Cell titleCell4 = titleRow.createCell((short)4);
		Cell titleCell5 = titleRow.createCell((short)5);
		Cell titleCell6 = titleRow.createCell((short)6);
		Cell titleCell7 = titleRow.createCell((short)7);
		Cell titleCell8 = titleRow.createCell((short)8);
		sheet.addMergedRegion(new CellRangeAddress(8,8,0,rightSize));
		titleCell0.setCellValue("마감 요약 정보");
		titleCell0.setCellStyle(style);
		titleCell1.setCellStyle(style);
		titleCell2.setCellStyle(style);
		titleCell3.setCellStyle(style);
		titleCell4.setCellStyle(style);
		titleCell5.setCellStyle(style);
		titleCell6.setCellStyle(style);
		titleCell7.setCellStyle(style);
		titleCell8.setCellStyle(style);
		
		int n = -1;
		int r = 9;

		int tableNameMaxCellWidth = 0;
		int applicationMaxCellWidth = 0;
		int groupNameMaxCellWidth = 0;
		int odateMaxCellWidth = 100;
		int totalCntMaxCellWidth = 0;
		int okCntMaxCellWidth = 0;
		int notOkCntMaxCellWidth = 0;
		int waitUserCntMaxCellWidth = 0;
		int waitResourceCntCellWidth = 0;
		int waitHostCntMaxCellWidth = 0;
		int waitConditionCntMaxCellWidth = 0;
		int deleteCntMaxCellWidth = 0;
		int endCntMaxCellWidth = 0;
		int statusMaxCellWidth = 0;
		int errorCntMaxCellWidth = 0;
		int waitCntMaxCellWidth = 0;
		int percentMaxCellWidth = 0;

		int cellWidth = 0;

		//셀 오토사이즈 조절을 위해 글자를 조금씩 줄여서 cellWidth 조절
		
		setCellValue(r, ++n, "ODATE", style);
		cellWidth = "어플리".getBytes("UTF-8").length * 256;
		odateMaxCellWidth = Math.max(odateMaxCellWidth, cellWidth);

		setCellValue(r, ++n, "폴더", style);
		cellWidth = "폴더".getBytes("UTF-8").length * 256;
		tableNameMaxCellWidth = Math.max(tableNameMaxCellWidth, cellWidth);

		setCellValue(r, ++n, "어플리케이션", style);
		cellWidth = "어플리케이".getBytes("UTF-8").length * 256;
		applicationMaxCellWidth = Math.max(applicationMaxCellWidth, cellWidth);

// 		setCellValue(r, ++n, "그룹", style);
// 		cellWidth = "그룹".getBytes("UTF-8").length * 256;
// 		groupNameMaxCellWidth = Math.max(groupNameMaxCellWidth, cellWidth);

		setCellValue(r, ++n, "전체", style);
		cellWidth = "전체".getBytes("UTF-8").length * 256;
		totalCntMaxCellWidth = Math.max(totalCntMaxCellWidth, cellWidth);

		setCellValue(r, ++n, "실행중(수행중)", style);
		cellWidth = "실행중(수)".getBytes("UTF-8").length * 256;
		statusMaxCellWidth = Math.max(statusMaxCellWidth, cellWidth);
		
		setCellValue(r, ++n, "정상종료(성공)", style);
		cellWidth = "정상종(성)".getBytes("UTF-8").length * 256;
		okCntMaxCellWidth = Math.max(okCntMaxCellWidth, cellWidth);

		setCellValue(r, ++n, "비정상종료(오류)", style);
		cellWidth = "비정상(오)".getBytes("UTF-8").length * 256;
		errorCntMaxCellWidth = Math.max(errorCntMaxCellWidth, cellWidth);
		
		setCellValue(r, ++n, "대기", style);
		cellWidth = "대기".getBytes("UTF-8").length * 256;
		waitCntMaxCellWidth = Math.max(waitCntMaxCellWidth, cellWidth);
		
		setCellValue(r, ++n, "성공율", style);
		cellWidth = "성공율".getBytes("UTF-8").length * 256;
		percentMaxCellWidth = Math.max(percentMaxCellWidth, cellWidth);

		format = wb.createDataFormat();
		style3 = wb.createCellStyle();
		style3.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style3.setBorderRight(XSSFCellStyle.BORDER_THIN);
		style3.setBorderLeft(XSSFCellStyle.BORDER_THIN);
		style3.setBorderTop(XSSFCellStyle.BORDER_THIN);
		style3.setBorderBottom(XSSFCellStyle.BORDER_THIN);
		style3.setDataFormat(format.getFormat("@")); // "@"은 텍스트 형식

		sheet.autoSizeColumn(0);

		for( int i=0; null!=batchReportList && i<batchReportList.size(); i++ ){

			BatchResultTotalBean bean 			= (BatchResultTotalBean)batchReportList.get(i);

//	 		String strGubun 			= CommonUtil.isNull(bean.getGubun());
			String strDataCenter 		= CommonUtil.isNull(bean.getData_center());
			String strTableName 		= CommonUtil.isNull(bean.getTable_name());
			String strApplication 		= CommonUtil.isNull(bean.getApplication());
			String strGroupName 		= CommonUtil.isNull(bean.getGroup_name());
			String strOdate 			= CommonUtil.isNull(bean.getOdate());
			// 		String strOrderDate 		= CommonUtil.isNull(bean.getOrder_date());
			String strOkCnt 			= CommonUtil.isNull(bean.getOk_cnt());
			String strNotOkCnt 			= CommonUtil.isNull(bean.getNot_ok_cnt());
			String strExceCnt 			= CommonUtil.isNull(bean.getExec_cnt());
			String strWaitUserCnt 		= CommonUtil.isNull(bean.getWait_user_cnt());
			String strWaitResourceCnt 	= CommonUtil.isNull(bean.getWait_resource_cnt());
			String strWaitHostCnt 		= CommonUtil.isNull(bean.getWait_host_cnt());
			String strWaitConditionCnt 	= CommonUtil.isNull(bean.getWait_condition_cnt());
			// 		String strWaitTimeCnt 		= CommonUtil.isNull(bean.getWait_time_cnt());
			String strTotalCnt	 		= CommonUtil.isNull(bean.getTotal_cnt());
			String strDeleteCnt	 		= CommonUtil.isNull(bean.getDelete_cnt());
			
			int wait_total = Integer.parseInt(strWaitUserCnt) + Integer.parseInt(strWaitResourceCnt) + Integer.parseInt(strWaitHostCnt) + Integer.parseInt(strWaitConditionCnt);
			String	percent = String.valueOf(Math.round((Integer.parseInt(strOkCnt)/Double.parseDouble(strTotalCnt)) * 100));
			
			String strStatus			= "";
			
			r++;
			n = -1;

			setCellValue(r, ++n, strOdate, style3);
			cellWidth = strOdate.getBytes("UTF-8").length * 256;
			odateMaxCellWidth = Math.max(odateMaxCellWidth, cellWidth);

			setCellValue(r, ++n, strTableName, style3);
			cellWidth = strTableName.getBytes("UTF-8").length * 256;
			tableNameMaxCellWidth = Math.max(tableNameMaxCellWidth, cellWidth);

			setCellValue(r, ++n, strApplication, style3);
			cellWidth = strApplication.getBytes("UTF-8").length * 256;
			applicationMaxCellWidth = Math.max(applicationMaxCellWidth, cellWidth);

// 			setCellValue(r, ++n, strGroupName, style3);
// 			cellWidth = strGroupName.getBytes("UTF-8").length * 256;
// 			groupNameMaxCellWidth = Math.max(groupNameMaxCellWidth, cellWidth);
			
			setCellValue(r, ++n, strTotalCnt, style3);
			cellWidth = strTotalCnt.getBytes("UTF-8").length * 256;
			totalCntMaxCellWidth = Math.max(totalCntMaxCellWidth, cellWidth);

			setCellValue(r, ++n, strExceCnt, style3);
			cellWidth = strExceCnt.getBytes("UTF-8").length * 256;
			statusMaxCellWidth = Math.max(statusMaxCellWidth, cellWidth);

			setCellValue(r, ++n, strOkCnt, style3);
			cellWidth = strOkCnt.getBytes("UTF-8").length * 256;
			okCntMaxCellWidth = Math.max(okCntMaxCellWidth, cellWidth);
			
			setCellValue(r, ++n, strNotOkCnt, style3);
			cellWidth = strNotOkCnt.getBytes("UTF-8").length * 256;
			errorCntMaxCellWidth = Math.max(errorCntMaxCellWidth, cellWidth);

			setCellValue(r, ++n, Integer.toString(wait_total), style3);
			cellWidth = (Integer.toString(wait_total)).getBytes("UTF-8").length * 256;
			waitCntMaxCellWidth = Math.max(waitCntMaxCellWidth, cellWidth);
			
			setCellValue(r, ++n, percent, style3);
			cellWidth = percent.getBytes("UTF-8").length * 256;
			percentMaxCellWidth = Math.max(percentMaxCellWidth, cellWidth);
			
		}
		r = r+2;
		
		// 계정계 하드코딩
		Row endRow = sheet.createRow((short)r);
		Cell endCell0 = endRow.createCell((short)0);
		Cell endCell1 = endRow.createCell((short)1);
		Cell endCell2 = endRow.createCell((short)2);
		Cell endCell3 = endRow.createCell((short)3);
		Cell endCell4 = endRow.createCell((short)4);
		Cell endCell5 = endRow.createCell((short)5);
		Cell endCell6 = endRow.createCell((short)6);
		Cell endCell7 = endRow.createCell((short)7);
		Cell endCell8 = endRow.createCell((short)8);
		sheet.addMergedRegion(new CellRangeAddress(r,r,0,rightSize));
		endCell0.setCellValue("계정계");
		endCell0.setCellStyle(style);
		endCell1.setCellStyle(style);
		endCell2.setCellStyle(style);
		endCell3.setCellStyle(style);
		endCell4.setCellStyle(style);
		endCell5.setCellStyle(style);
		endCell6.setCellStyle(style);
		endCell7.setCellStyle(style);
		endCell8.setCellStyle(style);
		
		r++;
		
		// 에러 및 비정상 작업 상세내역
		Row detailRow = sheet.createRow((short)r);
		Cell detailCell0 = detailRow.createCell((short)0);
		Cell detailCell1 = detailRow.createCell((short)1);
		Cell detailCell2 = detailRow.createCell((short)2);
		Cell detailCell3 = detailRow.createCell((short)3);
		Cell detailCell4 = detailRow.createCell((short)4);
		Cell detailCell5 = detailRow.createCell((short)5);
		Cell detailCell6 = detailRow.createCell((short)6);
		Cell detailCell7 = detailRow.createCell((short)7);
		Cell detailCell8 = detailRow.createCell((short)8);
		sheet.addMergedRegion(new CellRangeAddress(r,r,0,rightSize));
		detailCell0.setCellValue("에러 및 비정상 작업 상세내역");
		detailCell0.setCellStyle(style);
		detailCell1.setCellStyle(style);
		detailCell2.setCellStyle(style);
		detailCell3.setCellStyle(style);
		detailCell4.setCellStyle(style);
		detailCell5.setCellStyle(style);
		detailCell6.setCellStyle(style);
		detailCell7.setCellStyle(style);
		detailCell8.setCellStyle(style);
		
		r++;
		
		//어플리케이션//그룹//잡이름//조치사항 제목
		Row detailTitleRow = sheet.createRow((short)r);
		Cell detailTitleCell0 = detailTitleRow.createCell((short)0);
		Cell detailTitleCell1 = detailTitleRow.createCell((short)1);
		Cell detailTitleCell2 = detailTitleRow.createCell((short)2);
		Cell detailTitleCell3 = detailTitleRow.createCell((short)3);
		Cell detailTitleCell4 = detailTitleRow.createCell((short)4);
		Cell detailTitleCell5 = detailTitleRow.createCell((short)5);
		Cell detailTitleCell6 = detailTitleRow.createCell((short)6);
		Cell detailTitleCell7 = detailTitleRow.createCell((short)7);
		Cell detailTitleCell8 = detailTitleRow.createCell((short)8);
		sheet.addMergedRegion(new CellRangeAddress(r,r,3,rightSize));
		detailTitleCell0.setCellValue("어플리케이션");
		detailTitleCell1.setCellValue("그룹");
		detailTitleCell2.setCellValue("작업명");
		detailTitleCell3.setCellValue("조치사항");
		detailTitleCell0.setCellStyle(style2);
		detailTitleCell1.setCellStyle(style2);
		detailTitleCell2.setCellStyle(style2);
		detailTitleCell3.setCellStyle(style2);
		detailTitleCell4.setCellStyle(style2);
		detailTitleCell5.setCellStyle(style2);
		detailTitleCell6.setCellStyle(style2);
		detailTitleCell7.setCellStyle(style2);
		detailTitleCell8.setCellStyle(style2);
		
		r++;
		
		//Set to OK Job List
		Row detailSet1Row = sheet.createRow((short)r);
		Cell detailSet1Cell0 = detailSet1Row.createCell((short)0);
		Cell detailSet1Cell1 = detailSet1Row.createCell((short)1);
		Cell detailSet1Cell2 = detailSet1Row.createCell((short)2);
		Cell detailSet1Cell3 = detailSet1Row.createCell((short)3);
		Cell detailSet1Cell4 = detailSet1Row.createCell((short)4);
		Cell detailSet1Cell5 = detailSet1Row.createCell((short)5);
		Cell detailSet1Cell6 = detailSet1Row.createCell((short)6);
		Cell detailSet1Cell7 = detailSet1Row.createCell((short)7);
		Cell detailSet1Cell8 = detailSet1Row.createCell((short)8);
		sheet.addMergedRegion(new CellRangeAddress(r,r,0,rightSize));
		detailSet1Cell0.setCellValue("Set to OK Job List");
		detailSet1Cell0.setCellStyle(style4);
		detailSet1Cell1.setCellStyle(style4);
		detailSet1Cell2.setCellStyle(style4);
		detailSet1Cell3.setCellStyle(style4);
		detailSet1Cell4.setCellStyle(style4);
		detailSet1Cell5.setCellStyle(style4);
		detailSet1Cell6.setCellStyle(style4);
		detailSet1Cell7.setCellStyle(style4);
		detailSet1Cell8.setCellStyle(style4);
		
		r++;
		
		//입력란1
		Row input1Row = sheet.createRow((short)r);
		Cell input1Cell0 = input1Row.createCell((short)0);
		Cell input1Cell1 = input1Row.createCell((short)1);
		Cell input1Cell2 = input1Row.createCell((short)2);
		Cell input1Cell3 = input1Row.createCell((short)3);
		Cell input1Cell4 = input1Row.createCell((short)4);
		Cell input1Cell5 = input1Row.createCell((short)5);
		Cell input1Cell6 = input1Row.createCell((short)6);
		Cell input1Cell7 = input1Row.createCell((short)7);
		Cell input1Cell8 = input1Row.createCell((short)8);
		sheet.addMergedRegion(new CellRangeAddress(r,r,3,rightSize));
		input1Cell0.setCellStyle(style2);
		input1Cell1.setCellStyle(style2);
		input1Cell2.setCellStyle(style2);
		input1Cell3.setCellStyle(style2);
		input1Cell4.setCellStyle(style2);
		input1Cell5.setCellStyle(style2);
		input1Cell6.setCellStyle(style2);
		input1Cell7.setCellStyle(style2);
		input1Cell8.setCellStyle(style2);
		
		r++;
		
		//Error Job List
		Row detailSet2Row = sheet.createRow((short)r);
		Cell detailSet2Cell0 = detailSet2Row.createCell((short)0);
		Cell detailSet2Cell1 = detailSet2Row.createCell((short)1);
		Cell detailSet2Cell2 = detailSet2Row.createCell((short)2);
		Cell detailSet2Cell3 = detailSet2Row.createCell((short)3);
		Cell detailSet2Cell4 = detailSet2Row.createCell((short)4);
		Cell detailSet2Cell5 = detailSet2Row.createCell((short)5);
		Cell detailSet2Cell6 = detailSet2Row.createCell((short)6);
		Cell detailSet2Cell7 = detailSet2Row.createCell((short)7);
		Cell detailSet2Cell8 = detailSet2Row.createCell((short)8);
		sheet.addMergedRegion(new CellRangeAddress(r,r,0,rightSize));
		detailSet2Cell0.setCellValue("Error Job List");
		detailSet2Cell0.setCellStyle(style4);
		detailSet2Cell1.setCellStyle(style4);
		detailSet2Cell2.setCellStyle(style4);
		detailSet2Cell3.setCellStyle(style4);
		detailSet2Cell4.setCellStyle(style4);
		detailSet2Cell5.setCellStyle(style4);
		detailSet2Cell6.setCellStyle(style4);
		detailSet2Cell7.setCellStyle(style4);
		detailSet2Cell8.setCellStyle(style4);
		
		r++;
		
		//입력란2
		Row input2Row = sheet.createRow((short)r);
		Cell input2Cell0 = input2Row.createCell((short)0);
		Cell input2Cell1 = input2Row.createCell((short)1);
		Cell input2Cell2 = input2Row.createCell((short)2);
		Cell input2Cell3 = input2Row.createCell((short)3);
		Cell input2Cell4 = input2Row.createCell((short)4);
		Cell input2Cell5 = input2Row.createCell((short)5);
		Cell input2Cell6 = input2Row.createCell((short)6);
		Cell input2Cell7 = input2Row.createCell((short)7);
		Cell input2Cell8 = input2Row.createCell((short)8);
		sheet.addMergedRegion(new CellRangeAddress(r,r,3,rightSize));
		input2Cell0.setCellStyle(style2);
		input2Cell1.setCellStyle(style2);
		input2Cell2.setCellStyle(style2);
		input2Cell3.setCellStyle(style2);
		input2Cell4.setCellStyle(style2);
		input2Cell5.setCellStyle(style2);
		input2Cell6.setCellStyle(style2);
		input2Cell7.setCellStyle(style2);
		input2Cell8.setCellStyle(style2);
		
		r++;
		
		//Waiting Job List
		Row detailSet3Row = sheet.createRow((short)r);
		Cell detailSet3Cell0 = detailSet3Row.createCell((short)0);
		Cell detailSet3Cell1 = detailSet3Row.createCell((short)1);
		Cell detailSet3Cell2 = detailSet3Row.createCell((short)2);
		Cell detailSet3Cell3 = detailSet3Row.createCell((short)3);
		Cell detailSet3Cell4 = detailSet3Row.createCell((short)4);
		Cell detailSet3Cell5 = detailSet3Row.createCell((short)5);
		Cell detailSet3Cell6 = detailSet3Row.createCell((short)6);
		Cell detailSet3Cell7 = detailSet3Row.createCell((short)7);
		Cell detailSet3Cell8 = detailSet3Row.createCell((short)8);
		sheet.addMergedRegion(new CellRangeAddress(r,r,0,rightSize));
		detailSet3Cell0.setCellValue("Waiting Job List");
		detailSet3Cell0.setCellStyle(style4);
		detailSet3Cell1.setCellStyle(style4);
		detailSet3Cell2.setCellStyle(style4);
		detailSet3Cell3.setCellStyle(style4);
		detailSet3Cell4.setCellStyle(style4);
		detailSet3Cell5.setCellStyle(style4);
		detailSet3Cell6.setCellStyle(style4);
		detailSet3Cell7.setCellStyle(style4);
		detailSet3Cell8.setCellStyle(style4);
		
		r++;
		
		//입력란3
		Row input3Row = sheet.createRow((short)r);
		Cell input3Cell0 = input3Row.createCell((short)0);
		Cell input3Cell1 = input3Row.createCell((short)1);
		Cell input3Cell2 = input3Row.createCell((short)2);
		Cell input3Cell3 = input3Row.createCell((short)3);
		Cell input3Cell4 = input3Row.createCell((short)4);
		Cell input3Cell5 = input3Row.createCell((short)5);
		Cell input3Cell6 = input3Row.createCell((short)6);
		Cell input3Cell7 = input3Row.createCell((short)7);
		Cell input3Cell8 = input3Row.createCell((short)8);
		sheet.addMergedRegion(new CellRangeAddress(r,r,3,rightSize));
		input3Cell0.setCellStyle(style2);
		input3Cell1.setCellStyle(style2);
		input3Cell2.setCellStyle(style2);
		input3Cell3.setCellStyle(style2);
		input3Cell4.setCellStyle(style2);
		input3Cell5.setCellStyle(style2);
		input3Cell6.setCellStyle(style2);
		input3Cell7.setCellStyle(style2);
		input3Cell8.setCellStyle(style2);
		
		r = r+2;
		
		// 분석계 / 정보계 하드코딩
		Row endRow2 = sheet.createRow((short)r);
		Cell endCell10 = endRow2.createCell((short)0);
		Cell endCell11 = endRow2.createCell((short)1);
		Cell endCell12 = endRow2.createCell((short)2);
		Cell endCell13 = endRow2.createCell((short)3);
		Cell endCell14 = endRow2.createCell((short)4);
		Cell endCell15 = endRow2.createCell((short)5);
		Cell endCell16 = endRow2.createCell((short)6);
		Cell endCell17 = endRow2.createCell((short)7);
		Cell endCell18 = endRow2.createCell((short)8);
		sheet.addMergedRegion(new CellRangeAddress(r,r,0,rightSize));
		endCell10.setCellValue("분석계 / 정보계");
		endCell10.setCellStyle(style);
		endCell11.setCellStyle(style);
		endCell12.setCellStyle(style);
		endCell13.setCellStyle(style);
		endCell14.setCellStyle(style);
		endCell15.setCellStyle(style);
		endCell16.setCellStyle(style);
		endCell17.setCellStyle(style);
		endCell18.setCellStyle(style);
		
		r++;

		// 에러 및 비정상 작업 상세내역
		Row detailRow2 = sheet.createRow((short)r);
		Cell detailCell10 = detailRow2.createCell((short)0);
		Cell detailCell11 = detailRow2.createCell((short)1);
		Cell detailCell12 = detailRow2.createCell((short)2);
		Cell detailCell13 = detailRow2.createCell((short)3);
		Cell detailCell14 = detailRow2.createCell((short)4);
		Cell detailCell15 = detailRow2.createCell((short)5);
		Cell detailCell16 = detailRow2.createCell((short)6);
		Cell detailCell17 = detailRow2.createCell((short)7);
		Cell detailCell18 = detailRow2.createCell((short)7);
		sheet.addMergedRegion(new CellRangeAddress(r,r,0,rightSize));
		detailCell10.setCellValue("에러 및 비정상 작업 상세내역");
		detailCell10.setCellStyle(style);
		detailCell11.setCellStyle(style);
		detailCell12.setCellStyle(style);
		detailCell13.setCellStyle(style);
		detailCell14.setCellStyle(style);
		detailCell15.setCellStyle(style);
		detailCell16.setCellStyle(style);
		detailCell17.setCellStyle(style);
		detailCell18.setCellStyle(style);
		
		r++;
		
		//어플리케이션//그룹//잡이름//조치사항 제목
		Row detailTitle2Row = sheet.createRow((short)r);
		Cell detailTitle2Cell0 = detailTitle2Row.createCell((short)0);
		Cell detailTitle2Cell1 = detailTitle2Row.createCell((short)1);
		Cell detailTitle2Cell2 = detailTitle2Row.createCell((short)2);
		Cell detailTitle2Cell3 = detailTitle2Row.createCell((short)3);
		Cell detailTitle2Cell4 = detailTitle2Row.createCell((short)4);
		Cell detailTitle2Cell5 = detailTitle2Row.createCell((short)5);
		Cell detailTitle2Cell6 = detailTitle2Row.createCell((short)6);
		Cell detailTitle2Cell7 = detailTitle2Row.createCell((short)7);
		Cell detailTitle2Cell8 = detailTitle2Row.createCell((short)8);
		sheet.addMergedRegion(new CellRangeAddress(r,r,3,rightSize));
		detailTitle2Cell0.setCellValue("어플리케이션");
		detailTitle2Cell1.setCellValue("그룹");
		detailTitle2Cell2.setCellValue("작업명");
		detailTitle2Cell3.setCellValue("조치사항");
		detailTitle2Cell0.setCellStyle(style2);
		detailTitle2Cell1.setCellStyle(style2);
		detailTitle2Cell2.setCellStyle(style2);
		detailTitle2Cell3.setCellStyle(style2);
		detailTitle2Cell4.setCellStyle(style2);
		detailTitle2Cell5.setCellStyle(style2);
		detailTitle2Cell6.setCellStyle(style2);
		detailTitle2Cell7.setCellStyle(style2);
		detailTitle2Cell8.setCellStyle(style2);
		
		r++;
		
		//Set to OK Job List
		Row detailSet4Row = sheet.createRow((short)r);
		Cell detailSet4Cell0 = detailSet4Row.createCell((short)0);
		Cell detailSet4Cell1 = detailSet4Row.createCell((short)1);
		Cell detailSet4Cell2 = detailSet4Row.createCell((short)2);
		Cell detailSet4Cell3 = detailSet4Row.createCell((short)3);
		Cell detailSet4Cell4 = detailSet4Row.createCell((short)4);
		Cell detailSet4Cell5 = detailSet4Row.createCell((short)5);
		Cell detailSet4Cell6 = detailSet4Row.createCell((short)6);
		Cell detailSet4Cell7 = detailSet4Row.createCell((short)7);
		Cell detailSet4Cell8 = detailSet4Row.createCell((short)8);
		sheet.addMergedRegion(new CellRangeAddress(r,r,0,rightSize));
		detailSet4Cell0.setCellValue("Set to OK Job List");
		detailSet4Cell0.setCellStyle(style4);
		detailSet4Cell1.setCellStyle(style4);
		detailSet4Cell2.setCellStyle(style4);
		detailSet4Cell3.setCellStyle(style4);
		detailSet4Cell4.setCellStyle(style4);
		detailSet4Cell5.setCellStyle(style4);
		detailSet4Cell6.setCellStyle(style4);
		detailSet4Cell7.setCellStyle(style4);
		detailSet4Cell8.setCellStyle(style4);
		
		r++;
		
		//입력란1
		Row input4Row = sheet.createRow((short)r);
		Cell input4Cell0 = input4Row.createCell((short)0);
		Cell input4Cell1 = input4Row.createCell((short)1);
		Cell input4Cell2 = input4Row.createCell((short)2);
		Cell input4Cell3 = input4Row.createCell((short)3);
		Cell input4Cell4 = input4Row.createCell((short)4);
		Cell input4Cell5 = input4Row.createCell((short)5);
		Cell input4Cell6 = input4Row.createCell((short)6);
		Cell input4Cell7 = input4Row.createCell((short)7);
		Cell input4Cell8 = input4Row.createCell((short)8);
		sheet.addMergedRegion(new CellRangeAddress(r,r,3,rightSize));
		input4Cell0.setCellStyle(style2);
		input4Cell1.setCellStyle(style2);
		input4Cell2.setCellStyle(style2);
		input4Cell3.setCellStyle(style2);
		input4Cell4.setCellStyle(style2);
		input4Cell5.setCellStyle(style2);
		input4Cell6.setCellStyle(style2);
		input4Cell7.setCellStyle(style2);
		input4Cell8.setCellStyle(style2);
		
		r++;
		
		//Error Job List
		Row detailSet5Row = sheet.createRow((short)r);
		Cell detailSet5Cell0 = detailSet5Row.createCell((short)0);
		Cell detailSet5Cell1 = detailSet5Row.createCell((short)1);
		Cell detailSet5Cell2 = detailSet5Row.createCell((short)2);
		Cell detailSet5Cell3 = detailSet5Row.createCell((short)3);
		Cell detailSet5Cell4 = detailSet5Row.createCell((short)4);
		Cell detailSet5Cell5 = detailSet5Row.createCell((short)5);
		Cell detailSet5Cell6 = detailSet5Row.createCell((short)6);
		Cell detailSet5Cell7 = detailSet5Row.createCell((short)7);
		Cell detailSet5Cell8 = detailSet5Row.createCell((short)8);
		sheet.addMergedRegion(new CellRangeAddress(r,r,0,rightSize));
		detailSet5Cell0.setCellValue("Error Job List");
		detailSet5Cell0.setCellStyle(style4);
		detailSet5Cell1.setCellStyle(style4);
		detailSet5Cell2.setCellStyle(style4);
		detailSet5Cell3.setCellStyle(style4);
		detailSet5Cell4.setCellStyle(style4);
		detailSet5Cell5.setCellStyle(style4);
		detailSet5Cell6.setCellStyle(style4);
		detailSet5Cell7.setCellStyle(style4);
		detailSet5Cell8.setCellStyle(style4);
		
		r++;
		
		//입력란2
		Row input5Row = sheet.createRow((short)r);
		Cell input5Cell0 = input5Row.createCell((short)0);
		Cell input5Cell1 = input5Row.createCell((short)1);
		Cell input5Cell2 = input5Row.createCell((short)2);
		Cell input5Cell3 = input5Row.createCell((short)3);
		Cell input5Cell4 = input5Row.createCell((short)4);
		Cell input5Cell5 = input5Row.createCell((short)5);
		Cell input5Cell6 = input5Row.createCell((short)6);
		Cell input5Cell7 = input5Row.createCell((short)7);
		Cell input5Cell8 = input5Row.createCell((short)8);
		sheet.addMergedRegion(new CellRangeAddress(r,r,3,rightSize));
		input5Cell0.setCellStyle(style2);
		input5Cell1.setCellStyle(style2);
		input5Cell2.setCellStyle(style2);
		input5Cell3.setCellStyle(style2);
		input5Cell4.setCellStyle(style2);
		input5Cell5.setCellStyle(style2);
		input5Cell6.setCellStyle(style2);
		input5Cell7.setCellStyle(style2);
		input5Cell8.setCellStyle(style2);
		
		r++;
		
		//Waiting Job List
		Row detailSet6Row = sheet.createRow((short)r);
		Cell detailSet6Cell0 = detailSet6Row.createCell((short)0);
		Cell detailSet6Cell1 = detailSet6Row.createCell((short)1);
		Cell detailSet6Cell2 = detailSet6Row.createCell((short)2);
		Cell detailSet6Cell3 = detailSet6Row.createCell((short)3);
		Cell detailSet6Cell4 = detailSet6Row.createCell((short)4);
		Cell detailSet6Cell5 = detailSet6Row.createCell((short)5);
		Cell detailSet6Cell6 = detailSet6Row.createCell((short)6);
		Cell detailSet6Cell7 = detailSet6Row.createCell((short)7);
		Cell detailSet6Cell8 = detailSet6Row.createCell((short)8);
		sheet.addMergedRegion(new CellRangeAddress(r,r,0,rightSize));
		detailSet6Cell0.setCellValue("Waiting Job List");
		detailSet6Cell0.setCellStyle(style4);
		detailSet6Cell1.setCellStyle(style4);
		detailSet6Cell2.setCellStyle(style4);
		detailSet6Cell3.setCellStyle(style4);
		detailSet6Cell4.setCellStyle(style4);
		detailSet6Cell5.setCellStyle(style4);
		detailSet6Cell6.setCellStyle(style4);
		detailSet6Cell7.setCellStyle(style4);
		detailSet6Cell8.setCellStyle(style4);
		
		r++;
		
		//입력란3
		Row input6Row = sheet.createRow((short)r);
		Cell input6Cell0 = input6Row.createCell((short)0);
		Cell input6Cell1 = input6Row.createCell((short)1);
		Cell input6Cell2 = input6Row.createCell((short)2);
		Cell input6Cell3 = input6Row.createCell((short)3);
		Cell input6Cell4 = input6Row.createCell((short)4);
		Cell input6Cell5 = input6Row.createCell((short)5);
		Cell input6Cell6 = input6Row.createCell((short)6);
		Cell input6Cell7 = input6Row.createCell((short)7);
		Cell input6Cell8 = input6Row.createCell((short)8);
		sheet.addMergedRegion(new CellRangeAddress(r,r,3,rightSize));
		input6Cell0.setCellStyle(style2);
		input6Cell1.setCellStyle(style2);
		input6Cell2.setCellStyle(style2);
		input6Cell3.setCellStyle(style2);
		input6Cell4.setCellStyle(style2);
		input6Cell5.setCellStyle(style2);
		input6Cell6.setCellStyle(style2);
		input6Cell7.setCellStyle(style2);
		input6Cell8.setCellStyle(style2);
		
		n = -1;

		CommonUtil.setAutoSizeColumn(sheet, ++n, odateMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, tableNameMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, applicationMaxCellWidth);
// 		CommonUtil.setAutoSizeColumn(sheet, ++n, groupNameMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, totalCntMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, statusMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, okCntMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, errorCntMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, waitCntMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, percentMaxCellWidth);
				
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
