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

	String fileName = "일별수행.xlsx";
	response.reset() ;
	response.setHeader("Content-Description", "JSP Generated Data");
	response.setHeader("Content-Type", "application/octet-stream; charset=UTF-8");
	response.setHeader("Content-Disposition", "attachment; filename="+java.net.URLEncoder.encode(fileName,"UTF-8").replaceAll("\\+","%20"));

	List<BatchResultTotalBean> batchResultTotalList		= (List)request.getAttribute("batchResultTotalList");

	//검색조건 출력용
	String param_table			= CommonUtil.isNull(paramMap.get("p_sched_table"));
	String param_app			= CommonUtil.isNull(paramMap.get("p_application_of_def"));
	String param_grp			= CommonUtil.isNull(paramMap.get("p_group_name_of_def"));

	String odate 				= paramMap.get("p_s_odate")+" ~ "+paramMap.get("p_e_odate");
	String p_sched_table 		= param_table.equals("") ? "전체" : param_table;
	String p_application_of_def = param_app.equals("") ? "전체" : param_app;
	String p_group_name_of_def 	= param_grp.equals("") ? "전체" : param_grp;


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
		int dataCenterMaxCellWidth = 0;
		int tableNameMaxCellWidth = 0;
		int applicationMaxCellWidth = 0;
		int groupNameMaxCellWidth = 0;
		int odateMaxCellWidth = 0;
		int totalCntMaxCellWidth = 0;
		int okCntMaxCellWidth = 0;
		int notOkCntMaxCellWidth = 0;
		int exceCntMaxCellWidth = 0;
		int waitUserCntMaxCellWidth = 0;
		int waitResourceCntCellWidth = 0;
		int waitHostCntMaxCellWidth = 0;
		int waitConditionCntMaxCellWidth = 0;
		int deleteCntMaxCellWidth = 0;

		int cellWidth = 0;

		setCellValue(r, ++n, "순번", style);
		cellWidth = "순번".getBytes("UTF-8").length * 256;
		numMaxCellWidth = Math.max(numMaxCellWidth, cellWidth);

		setCellValue(r, ++n, "C-M", style);
		cellWidth = "C-M".getBytes("UTF-8").length * 256;
		dataCenterMaxCellWidth = Math.max(dataCenterMaxCellWidth, cellWidth);

		setCellValue(r, ++n, "폴더", style);
		cellWidth = "폴더".getBytes("UTF-8").length * 256;
		tableNameMaxCellWidth = Math.max(tableNameMaxCellWidth, cellWidth);

		setCellValue(r, ++n, "어플리케이션", style);
		cellWidth = "어플리케이션".getBytes("UTF-8").length * 256;
		applicationMaxCellWidth = Math.max(applicationMaxCellWidth, cellWidth);

		setCellValue(r, ++n, "그룹", style);
		cellWidth = "그룹".getBytes("UTF-8").length * 256;
		groupNameMaxCellWidth = Math.max(groupNameMaxCellWidth, cellWidth);

		setCellValue(r, ++n, "ODATE", style);
		cellWidth = "ODATE".getBytes("UTF-8").length * 256;
		odateMaxCellWidth = Math.max(odateMaxCellWidth, cellWidth);

		setCellValue(r, ++n, "성공", style);
		cellWidth = "성공".getBytes("UTF-8").length * 256;
		okCntMaxCellWidth = Math.max(okCntMaxCellWidth, cellWidth);

		setCellValue(r, ++n, "오류", style);
		cellWidth = "오류".getBytes("UTF-8").length * 256;
		notOkCntMaxCellWidth = Math.max(notOkCntMaxCellWidth, cellWidth);

		setCellValue(r, ++n, "수행중", style);
		cellWidth = "수행중".getBytes("UTF-8").length * 256;
		exceCntMaxCellWidth = Math.max(exceCntMaxCellWidth, cellWidth);

		setCellValue(r, ++n, "대기_USER", style);
		cellWidth = "대기_USER".getBytes("UTF-8").length * 256;
		waitUserCntMaxCellWidth = Math.max(waitUserCntMaxCellWidth, cellWidth);

		setCellValue(r, ++n, "대기_RESOURCE", style);
		cellWidth = "대기_RESOURCE".getBytes("UTF-8").length * 256;
		waitResourceCntCellWidth = Math.max(waitResourceCntCellWidth, cellWidth);

		setCellValue(r, ++n, "대기_HOST", style);
		cellWidth = "대기_HOST".getBytes("UTF-8").length * 256;
		waitHostCntMaxCellWidth = Math.max(waitHostCntMaxCellWidth, cellWidth);

		setCellValue(r, ++n, "대기_CONDITION", style);
		cellWidth = "대기_CONDITION".getBytes("UTF-8").length * 256;
		waitConditionCntMaxCellWidth = Math.max(waitConditionCntMaxCellWidth, cellWidth);

		setCellValue(r, ++n, "삭제", style);
		cellWidth = "삭제".getBytes("UTF-8").length * 256;
		deleteCntMaxCellWidth = Math.max(deleteCntMaxCellWidth, cellWidth);

		setCellValue(r, ++n, "전체", style);
		cellWidth = "전체".getBytes("UTF-8").length * 256;
		totalCntMaxCellWidth = Math.max(totalCntMaxCellWidth, cellWidth);

		format = wb.createDataFormat();
		style = wb.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setBorderRight(XSSFCellStyle.BORDER_THIN);
		style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
		style.setBorderTop(XSSFCellStyle.BORDER_THIN);
		style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
		style.setDataFormat(format.getFormat("@")); // "@"은 텍스트 형식

		sheet.autoSizeColumn(0);

		for( int i=0; null!=batchResultTotalList && i<batchResultTotalList.size(); i++ ){

			BatchResultTotalBean bean 			= (BatchResultTotalBean)batchResultTotalList.get(i);

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

			r++;
			n = -1;

			setCellValue(r, ++n, Integer.toString(i+1), style);
			cellWidth = Integer.toString(i+1).getBytes("UTF-8").length * 256;
			numMaxCellWidth = Math.max(numMaxCellWidth, cellWidth);

			setCellValue(r, ++n, strDataCenter, style);
			cellWidth = strDataCenter.getBytes("UTF-8").length * 256;
			dataCenterMaxCellWidth = Math.max(dataCenterMaxCellWidth, cellWidth);

			setCellValue(r, ++n, strTableName, style);
			cellWidth = strTableName.getBytes("UTF-8").length * 256;
			tableNameMaxCellWidth = Math.max(tableNameMaxCellWidth, cellWidth);

			setCellValue(r, ++n, strApplication, style);
			cellWidth = strApplication.getBytes("UTF-8").length * 256;
			applicationMaxCellWidth = Math.max(applicationMaxCellWidth, cellWidth);

			setCellValue(r, ++n, strGroupName, style);
			cellWidth = strGroupName.getBytes("UTF-8").length * 256;
			groupNameMaxCellWidth = Math.max(groupNameMaxCellWidth, cellWidth);

			setCellValue(r, ++n, strOdate, style);
			cellWidth = strOdate.getBytes("UTF-8").length * 256;
			odateMaxCellWidth = Math.max(odateMaxCellWidth, cellWidth);

			setCellValue(r, ++n, strOkCnt, style);
			cellWidth = strOkCnt.getBytes("UTF-8").length * 256;
			okCntMaxCellWidth = Math.max(okCntMaxCellWidth, cellWidth);

			setCellValue(r, ++n, strNotOkCnt, style);
			cellWidth = strNotOkCnt.getBytes("UTF-8").length * 256;
			notOkCntMaxCellWidth = Math.max(notOkCntMaxCellWidth, cellWidth);

			setCellValue(r, ++n, strExceCnt, style);
			cellWidth = strExceCnt.getBytes("UTF-8").length * 256;
			exceCntMaxCellWidth = Math.max(exceCntMaxCellWidth, cellWidth);

			setCellValue(r, ++n, strWaitUserCnt, style);
			cellWidth = strWaitUserCnt.getBytes("UTF-8").length * 256;
			waitUserCntMaxCellWidth = Math.max(waitUserCntMaxCellWidth, cellWidth);

			setCellValue(r, ++n, strWaitResourceCnt, style);
			cellWidth = strWaitResourceCnt.getBytes("UTF-8").length * 256;
			waitResourceCntCellWidth = Math.max(waitResourceCntCellWidth, cellWidth);

			setCellValue(r, ++n, strWaitHostCnt, style);
			cellWidth = strWaitHostCnt.getBytes("UTF-8").length * 256;
			waitHostCntMaxCellWidth = Math.max(waitHostCntMaxCellWidth, cellWidth);

			setCellValue(r, ++n, strWaitConditionCnt, style);
			cellWidth = strWaitConditionCnt.getBytes("UTF-8").length * 256;
			waitConditionCntMaxCellWidth = Math.max(waitConditionCntMaxCellWidth, cellWidth);

			setCellValue(r, ++n, strDeleteCnt, style);
			cellWidth = strDeleteCnt.getBytes("UTF-8").length * 256;
			deleteCntMaxCellWidth = Math.max(deleteCntMaxCellWidth, cellWidth);

			setCellValue(r, ++n, strTotalCnt, style);
			cellWidth = strTotalCnt.getBytes("UTF-8").length * 256;
			totalCntMaxCellWidth = Math.max(totalCntMaxCellWidth, cellWidth);
		}
		n = -1;

		CommonUtil.setAutoSizeColumn(sheet, ++n, numMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, dataCenterMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, tableNameMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, applicationMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, groupNameMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, odateMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, totalCntMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, okCntMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, notOkCntMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, exceCntMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, waitUserCntMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, waitResourceCntCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, waitHostCntMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, waitConditionCntMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, deleteCntMaxCellWidth);

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
