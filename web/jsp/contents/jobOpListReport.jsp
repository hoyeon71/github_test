<%@page import="org.apache.poi.ss.usermodel.IndexedColors"%>
<%@page import="org.apache.poi.ss.util.CellRangeAddress"%>
<%@page import="org.apache.poi.xssf.usermodel.XSSFCellStyle"%>
<%@page import="org.apache.poi.xssf.usermodel.XSSFCell"%>
<%@page import="org.apache.poi.xssf.usermodel.XSSFFont"%>
<%@page import="org.apache.poi.xssf.usermodel.XSSFRow"%>
<%@page import="org.apache.poi.xssf.usermodel.XSSFSheet"%>
<%@page import="org.apache.poi.xssf.usermodel.XSSFWorkbook"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@page import="org.apache.poi.ss.util.Region"%>
<%@ page import="com.ghayoun.ezjobs.m.domain.*" %>
<%@ page import="org.apache.poi.ss.usermodel.Row"%>

<%@include file="/jsp/common/inc/header.jsp"%>
<%
  response.setHeader("Cache-Control","no-store"); //HTTP 1.1
  response.setHeader("Pragma","no-cache"); //HTTP 1.0
  response.setDateHeader ("Expires", 0);
%>

<%
	OutputStream os = null;

	try{

		response.reset() ;
		response.setHeader("Content-Description", "JSP Generated Data");
		response.setHeader("Content-Type", "application/octet-stream; charset=UTF-8");
		
		Map<String, Object> paramMap = CommonUtil.collectParameters(request);
		
		JobLogBean jobLogBean		= (JobLogBean)request.getAttribute("jobOpReportInfo");
		List jobOpStatsReportList	= (List)request.getAttribute("jobOpStatsReportList");
		List jobOpReportList		= (List)request.getAttribute("jobOpReportList");
		List jobOpReportList2		= (List)request.getAttribute("jobOpReportList2");
		List jobOpReportList3		= (List)request.getAttribute("jobOpReportList3");
		List jobOpReportList4		= (List)request.getAttribute("jobOpReportList4");
		List jobOpReportEdwList		= (List)request.getAttribute("jobOpReportEdwList");
		List jobOpReportEdwList2	= (List)request.getAttribute("jobOpReportEdwList2");
		List jobOpReportEdwList3	= (List)request.getAttribute("jobOpReportEdwList3");
		List jobOpReportEdwList4	= (List)request.getAttribute("jobOpReportEdwList4");
		List jobOpReportIfrsList	= (List)request.getAttribute("jobOpReportIfrsList");
		List jobOpReportIfrsList2	= (List)request.getAttribute("jobOpReportIfrsList2");
		List jobOpReportIfrsList3	= (List)request.getAttribute("jobOpReportIfrsList3");
		List jobOpReportIfrsList4	= (List)request.getAttribute("jobOpReportIfrsList4");
		List jobOpReportAisList		= (List)request.getAttribute("jobOpReportAisList");
		List jobOpReportAisList2	= (List)request.getAttribute("jobOpReportAisList2");
		List jobOpReportAisList3	= (List)request.getAttribute("jobOpReportAisList3");
		List jobOpReportAisList4	= (List)request.getAttribute("jobOpReportAisList4");
		List jobOpReportAlmList		= (List)request.getAttribute("jobOpReportAlmList");
		List jobOpReportAlmList2	= (List)request.getAttribute("jobOpReportAlmList2");
		List jobOpReportAlmList3	= (List)request.getAttribute("jobOpReportAlmList3");
		List jobOpReportAlmList4	= (List)request.getAttribute("jobOpReportAlmList4");
		List jobOpReportNewRdmList	= (List)request.getAttribute("jobOpReportNewRdmList");
		List jobOpReportNewRdmList2	= (List)request.getAttribute("jobOpReportNewRdmList2");
		List jobOpReportNewRdmList3	= (List)request.getAttribute("jobOpReportNewRdmList3");
		List jobOpReportNewRdmList4	= (List)request.getAttribute("jobOpReportNewRdmList4");
		List jobOpReportRbaList		= (List)request.getAttribute("jobOpReportRbaList");
		List jobOpReportRbaList2	= (List)request.getAttribute("jobOpReportRbaList2");
		List jobOpReportRbaList3	= (List)request.getAttribute("jobOpReportRbaList3");
		List jobOpReportRbaList4	= (List)request.getAttribute("jobOpReportRbaList4");
		List jobOpReportCrsList		= (List)request.getAttribute("jobOpReportCrsList");
		List jobOpReportCrsList2	= (List)request.getAttribute("jobOpReportCrsList2");
		List jobOpReportCrsList3	= (List)request.getAttribute("jobOpReportCrsList3");
		List jobOpReportCrsList4	= (List)request.getAttribute("jobOpReportCrsList4");
		
		String s_search_odate 		= CommonUtil.isNull(paramMap.get("p_s_search_odate"));
		String e_search_odate 		= CommonUtil.isNull(paramMap.get("p_e_search_odate"));
		
		String strSodate			= "";
		String strEodate	 		= "";
		
		if ( jobLogBean != null ) {
			
			strSodate	 	= CommonUtil.isNull(jobLogBean.getS_odate());
			strEodate 		= CommonUtil.isNull(jobLogBean.getE_odate());
		}
		
		String file_name = "보고서출력.xlsx";
		response.setHeader("Content-Disposition", "attachment; filename="+java.net.URLEncoder.encode(file_name,"UTF-8").replaceAll("\\+","%20"));
		
		// 엑셀 워크 북 생성
		XSSFWorkbook wb 	= new XSSFWorkbook();
		
		// 시트 생성
		XSSFSheet sheet1 	= wb.createSheet("보고서출력");
		
		// 문서 제목 로우 생성
		XSSFRow nameRow 	= sheet1.createRow((int) 1);
		nameRow.setHeight((short)0x230);
		
		// 폰트 설정
		XSSFFont font 		= wb.createFont();
		font.setFontName("굴림체"	);
		font.setFontHeightInPoints((short)12);
		font.setBoldweight(XSSFFont.BOLDWEIGHT_BOLD);
		
		// 문서 제목 로우에 셀 생성
		XSSFCell nameCell	= nameRow.createCell((int) 1);
		
		// 스타일 객체 생성
		XSSFCellStyle style	= wb.createCellStyle();
		nameCell.setCellValue("배치 작업 처리 현황 " + s_search_odate + " ~  " + e_search_odate);
		
		// 문서 제목 셀에 스타일 적용
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setFont(font);
		nameCell.setCellStyle(style);
		
		// 문서 제목 셀 병합
		sheet1.addMergedRegion(new CellRangeAddress(1,  1, 1,  28));
		
		// 한줄 띄우기
		sheet1.createRow((int) 2);
		
		// 구분 로우 생성
		XSSFRow gubunRow 	= sheet1.createRow((int) 3);		
		gubunRow.setHeight((short)0x200);
		
		// 구분 로우에 셀 생성
		XSSFCell gubunCell	= gubunRow.createCell((int) 2);
		
		gubunCell.setCellValue("전체현황");
		
		// 구분 셀 병합
		sheet1.addMergedRegion(new CellRangeAddress(3,  3, 2,  4));
		
		// 구분 셀에 스타일 적용
		style	= wb.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setFillForegroundColor(IndexedColors.ROYAL_BLUE.index);
		style.setFillPattern(XSSFCellStyle.SOLID_FOREGROUND);
		style.setFont(font);
		gubunCell.setCellStyle(style);
		
		// 구분 로우에 셀 생성
		XSSFCell gubunCell2	= gubunRow.createCell((int) 5);
		
		gubunCell2.setCellValue("계정계");
		
		// 구분 셀 병합
		sheet1.addMergedRegion(new CellRangeAddress(3,  3, 5,  7));
		
		// 구분 셀에 스타일 적용
		style	= wb.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setFillForegroundColor(IndexedColors.LEMON_CHIFFON.index);
		style.setFillPattern(XSSFCellStyle.SOLID_FOREGROUND);
		style.setFont(font);
		gubunCell2.setCellStyle(style);
		
		// 구분 로우에 셀 생성
		XSSFCell gubunCell3	= gubunRow.createCell((int) 8);
		
		gubunCell3.setCellValue("EDW");
		
		// 구분 셀 병합
		sheet1.addMergedRegion(new CellRangeAddress(3,  3, 8,  10));
		
		// 구분 셀에 스타일 적용
		style	= wb.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setFillForegroundColor(IndexedColors.PALE_BLUE.index);
		style.setFillPattern(XSSFCellStyle.SOLID_FOREGROUND);
		style.setFont(font);
		gubunCell3.setCellStyle(style);
		
		// 구분 로우에 셀 생성
		XSSFCell gubunCell4	= gubunRow.createCell((int) 11);
		
		gubunCell4.setCellValue("IFRS");
		
		// 구분 셀 병합
		sheet1.addMergedRegion(new CellRangeAddress(3,  3, 11,  13));
		
		// 구분 셀에 스타일 적용
		style	= wb.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setFillForegroundColor(IndexedColors.BRIGHT_GREEN.index);
		style.setFillPattern(XSSFCellStyle.SOLID_FOREGROUND);
		style.setFont(font);
		gubunCell4.setCellStyle(style);
		
		// 구분 로우에 셀 생성
		XSSFCell gubunCell5	= gubunRow.createCell((int) 14);
		
		gubunCell5.setCellValue("AIS");
		
		// 구분 셀 병합
		sheet1.addMergedRegion(new CellRangeAddress(3,  3, 14,  16));
		
		// 구분 셀에 스타일 적용
		style	= wb.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setFillForegroundColor(IndexedColors.AQUA.index);
		style.setFillPattern(XSSFCellStyle.SOLID_FOREGROUND);
		style.setFont(font);
		gubunCell5.setCellStyle(style);
		
		// 구분 로우에 셀 생성
		XSSFCell gubunCell6	= gubunRow.createCell((int) 17);
		
		gubunCell6.setCellValue("ALM");
		
		// 구분 셀 병합
		sheet1.addMergedRegion(new CellRangeAddress(3,  3, 17,  19));
		
		// 구분 셀에 스타일 적용
		style	= wb.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setFillForegroundColor(IndexedColors.CORAL.index);
		style.setFillPattern(XSSFCellStyle.SOLID_FOREGROUND);
		style.setFont(font);
		gubunCell6.setCellStyle(style);
		
		
		
		
		
		// 구분 로우에 셀 생성
		XSSFCell gubunCell7	= gubunRow.createCell((int) 20);
		
		gubunCell7.setCellValue("NEW_RDM");
		
		// 구분 셀 병합
		sheet1.addMergedRegion(new CellRangeAddress(3,  3, 20,  22));
		
		// 구분 셀에 스타일 적용
		style	= wb.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setFillForegroundColor(IndexedColors.TEAL.index);
		style.setFillPattern(XSSFCellStyle.SOLID_FOREGROUND);
		style.setFont(font);
		gubunCell7.setCellStyle(style);
		
		
		
		// 구분 로우에 셀 생성
		XSSFCell gubunCell8	= gubunRow.createCell((int) 23);
		
		gubunCell8.setCellValue("RBA");
		
		// 구분 셀 병합
		sheet1.addMergedRegion(new CellRangeAddress(3,  3, 23,  25));
		
		// 구분 셀에 스타일 적용
		style	= wb.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setFillForegroundColor(IndexedColors.LEMON_CHIFFON.index);
		style.setFillPattern(XSSFCellStyle.SOLID_FOREGROUND);
		style.setFont(font);
		gubunCell8.setCellStyle(style);
		
		
		
		
		// 구분 로우에 셀 생성
		XSSFCell gubunCell9	= gubunRow.createCell((int) 26);
		
		gubunCell9.setCellValue("CRS");
		
		// 구분 셀 병합
		sheet1.addMergedRegion(new CellRangeAddress(3,  3, 26,  28));
		
		// 구분 셀에 스타일 적용
		style	= wb.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setFillForegroundColor(IndexedColors.PALE_BLUE.index);
		style.setFillPattern(XSSFCellStyle.SOLID_FOREGROUND);
		style.setFont(font);
		gubunCell9.setCellStyle(style);
		
		
		
		// 타이틀 로우 생성
		XSSFRow titleRow 	= sheet1.createRow((int) 4);
		titleRow.setHeight((short)0x200);
		
		// 타이틀 셀에 스타일 적용
		style	= wb.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.index);
		style.setFillPattern(XSSFCellStyle.SOLID_FOREGROUND);
		style.setBorderRight(XSSFCellStyle.BORDER_THIN);
		style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
		style.setBorderTop(XSSFCellStyle.BORDER_THIN);
		style.setBorderBottom(XSSFCellStyle.BORDER_THIN);	
		style.setFont(font);
		
		// 타이틀 로우에 셀 생성 
		XSSFCell titleCell	= titleRow.createCell((int) 1);
		titleCell.setCellValue("구분");
		titleCell.setCellStyle(style);
		
		titleCell			= titleRow.createCell((int) 2);
		titleCell.setCellValue("총건수");
		titleCell.setCellStyle(style);
		
		titleCell			= titleRow.createCell((int) 3);
		titleCell.setCellValue("정규작업");
		titleCell.setCellStyle(style);
		
		titleCell			= titleRow.createCell((int) 4);
		titleCell.setCellValue("작업의뢰");
		titleCell.setCellStyle(style);
		
		titleCell			= titleRow.createCell((int) 5);
		titleCell.setCellValue("총건수");
		titleCell.setCellStyle(style);
		
		titleCell			= titleRow.createCell((int) 6);
		titleCell.setCellValue("정규작업");
		titleCell.setCellStyle(style);
		
		titleCell			= titleRow.createCell((int) 7);
		titleCell.setCellValue("작업의뢰");
		titleCell.setCellStyle(style);
		
		titleCell			= titleRow.createCell((int) 8);
		titleCell.setCellValue("총건수");
		titleCell.setCellStyle(style);
		
		titleCell			= titleRow.createCell((int) 9);
		titleCell.setCellValue("정규작업");
		titleCell.setCellStyle(style);
		
		titleCell			= titleRow.createCell((int) 10);
		titleCell.setCellValue("작업의뢰");
		titleCell.setCellStyle(style);
		
		titleCell			= titleRow.createCell((int) 11);
		titleCell.setCellValue("총건수");
		titleCell.setCellStyle(style);
		
		titleCell			= titleRow.createCell((int) 12);
		titleCell.setCellValue("정규작업");
		titleCell.setCellStyle(style);
		
		titleCell			= titleRow.createCell((int) 13);
		titleCell.setCellValue("작업의뢰");
		titleCell.setCellStyle(style);
		
		titleCell			= titleRow.createCell((int) 14);
		titleCell.setCellValue("총건수");
		titleCell.setCellStyle(style);
		
		titleCell			= titleRow.createCell((int) 15);
		titleCell.setCellValue("정규작업");
		titleCell.setCellStyle(style);
		
		titleCell			= titleRow.createCell((int) 16);
		titleCell.setCellValue("작업의뢰");
		titleCell.setCellStyle(style);
		
		titleCell			= titleRow.createCell((int) 17);
		titleCell.setCellValue("총건수");
		titleCell.setCellStyle(style);
		
		titleCell			= titleRow.createCell((int) 18);
		titleCell.setCellValue("정규작업");
		titleCell.setCellStyle(style);
		
		titleCell			= titleRow.createCell((int) 19);
		titleCell.setCellValue("작업의뢰");
		titleCell.setCellStyle(style);
		
		titleCell			= titleRow.createCell((int) 20);
		titleCell.setCellValue("총건수");
		titleCell.setCellStyle(style);
		
		titleCell			= titleRow.createCell((int) 21);
		titleCell.setCellValue("정규작업");
		titleCell.setCellStyle(style);
		
		titleCell			= titleRow.createCell((int) 22);
		titleCell.setCellValue("작업의뢰");
		titleCell.setCellStyle(style);
		
		titleCell			= titleRow.createCell((int) 23);
		titleCell.setCellValue("총건수");
		titleCell.setCellStyle(style);
		
		titleCell			= titleRow.createCell((int) 24);
		titleCell.setCellValue("정규작업");
		titleCell.setCellStyle(style);
		
		titleCell			= titleRow.createCell((int) 25);
		titleCell.setCellValue("작업의뢰");
		titleCell.setCellStyle(style);
		
		titleCell			= titleRow.createCell((int) 26);
		titleCell.setCellValue("총건수");
		titleCell.setCellStyle(style);
		
		titleCell			= titleRow.createCell((int) 27);
		titleCell.setCellValue("정규작업");
		titleCell.setCellStyle(style);
		
		titleCell			= titleRow.createCell((int) 28);
		titleCell.setCellValue("작업의뢰");
		titleCell.setCellStyle(style);
		
		// 폰트 설정
		font = wb.createFont();
		font.setFontName("굴림체"	);
		font.setFontHeightInPoints((short)12);
		//font.setBoldweight(XSSFFont.BOLDWEIGHT_BOLD);

		for(int i=0; jobOpStatsReportList!=null && i<jobOpStatsReportList.size(); i++){
			JobLogBean bean = (JobLogBean)jobOpStatsReportList.get(i);			
			
			int iTotalCnt 				= Integer.parseInt(CommonUtil.isNull(bean.getTotal_cnt(), "0"));
			int iTotalSusiCnt 			= Integer.parseInt(CommonUtil.isNull(bean.getTotal_susi_cnt(), "0"));
			int iEndedOkCnt				= Integer.parseInt(CommonUtil.isNull(bean.getEnded_ok_cnt(), "0"));
			int iEndedNotOkCnt			= Integer.parseInt(CommonUtil.isNull(bean.getEnded_not_ok_cnt(), "0"));
			int iWaitCnt 				= Integer.parseInt(CommonUtil.isNull(bean.getWait_cnt(), "0"));
			int iEtcCnt 				= Integer.parseInt(CommonUtil.isNull(bean.getEtc_cnt(), "0"));
			int iEndedOkSusiCnt 		= Integer.parseInt(CommonUtil.isNull(bean.getEnded_ok_susi_cnt(), "0"));
			int iEndedNotOkSusiCnt		= Integer.parseInt(CommonUtil.isNull(bean.getEnded_not_ok_susi_cnt(), "0"));
			int iWaitSusiCnt			= Integer.parseInt(CommonUtil.isNull(bean.getWait_susi_cnt(), "0"));
			int iEtcSusiCnt 			= Integer.parseInt(CommonUtil.isNull(bean.getEtc_susi_cnt(), "0"));
			int iBeginMonthCnt			= Integer.parseInt(CommonUtil.isNull(bean.getBegin_month_cnt(), "0"));
			int iEndMonthCnt 			= Integer.parseInt(CommonUtil.isNull(bean.getEnd_month_cnt(), "0"));
			int iBeginMonthSusiCnt		= Integer.parseInt(CommonUtil.isNull(bean.getBegin_month_susi_cnt(), "0"));
			int iEndMonthSusiCnt 		= Integer.parseInt(CommonUtil.isNull(bean.getEnd_month_susi_cnt(), "0"));
			
			int iEdwTotalCnt 			= Integer.parseInt(CommonUtil.isNull(bean.getEdw_total_cnt(), "0"));
			int iEdwTotalSusiCnt 		= Integer.parseInt(CommonUtil.isNull(bean.getEdw_total_susi_cnt(), "0"));
			int iEdwEndedOkCnt			= Integer.parseInt(CommonUtil.isNull(bean.getEdw_ended_ok_cnt(), "0"));
			int iEdwEndedNotOkCnt		= Integer.parseInt(CommonUtil.isNull(bean.getEdw_ended_not_ok_cnt(), "0"));
			int iEdwWaitCnt 			= Integer.parseInt(CommonUtil.isNull(bean.getEdw_wait_cnt(), "0"));
			int iEdwEtcCnt 				= Integer.parseInt(CommonUtil.isNull(bean.getEdw_etc_cnt(), "0"));
			int iEdwEndedOkSusiCnt 		= Integer.parseInt(CommonUtil.isNull(bean.getEdw_ended_ok_susi_cnt(), "0"));
			int iEdwEndedNotOkSusiCnt	= Integer.parseInt(CommonUtil.isNull(bean.getEdw_ended_not_ok_susi_cnt(), "0"));
			int iEdwWaitSusiCnt			= Integer.parseInt(CommonUtil.isNull(bean.getEdw_wait_susi_cnt(), "0"));
			int iEdwEtcSusiCnt 			= Integer.parseInt(CommonUtil.isNull(bean.getEdw_etc_susi_cnt(), "0"));
			int iEdwBeginMonthCnt		= Integer.parseInt(CommonUtil.isNull(bean.getEdw_begin_month_cnt(), "0"));
			int iEdwEndMonthCnt 		= Integer.parseInt(CommonUtil.isNull(bean.getEdw_end_month_cnt(), "0"));
			int iEdwBeginMonthSusiCnt	= Integer.parseInt(CommonUtil.isNull(bean.getEdw_begin_month_susi_cnt(), "0"));
			int iEdwEndMonthSusiCnt 	= Integer.parseInt(CommonUtil.isNull(bean.getEdw_end_month_susi_cnt(), "0"));
			
			int iIfrsTotalCnt 			= Integer.parseInt(CommonUtil.isNull(bean.getIfrs_total_cnt(), "0"));
			int iIfrsTotalSusiCnt 		= Integer.parseInt(CommonUtil.isNull(bean.getIfrs_total_susi_cnt(), "0"));
			int iIfrsEndedOkCnt			= Integer.parseInt(CommonUtil.isNull(bean.getIfrs_ended_ok_cnt(), "0"));
			int iIfrsEndedNotOkCnt		= Integer.parseInt(CommonUtil.isNull(bean.getIfrs_ended_not_ok_cnt(), "0"));
			int iIfrsWaitCnt 			= Integer.parseInt(CommonUtil.isNull(bean.getIfrs_wait_cnt(), "0"));
			int iIfrsEtcCnt 				= Integer.parseInt(CommonUtil.isNull(bean.getIfrs_etc_cnt(), "0"));
			int iIfrsEndedOkSusiCnt 		= Integer.parseInt(CommonUtil.isNull(bean.getIfrs_ended_ok_susi_cnt(), "0"));
			int iIfrsEndedNotOkSusiCnt	= Integer.parseInt(CommonUtil.isNull(bean.getIfrs_ended_not_ok_susi_cnt(), "0"));
			int iIfrsWaitSusiCnt			= Integer.parseInt(CommonUtil.isNull(bean.getIfrs_wait_susi_cnt(), "0"));
			int iIfrsEtcSusiCnt 			= Integer.parseInt(CommonUtil.isNull(bean.getIfrs_etc_susi_cnt(), "0"));
			int iIfrsBeginMonthCnt		= Integer.parseInt(CommonUtil.isNull(bean.getIfrs_begin_month_cnt(), "0"));
			int iIfrsEndMonthCnt 		= Integer.parseInt(CommonUtil.isNull(bean.getIfrs_end_month_cnt(), "0"));
			int iIfrsBeginMonthSusiCnt	= Integer.parseInt(CommonUtil.isNull(bean.getIfrs_begin_month_susi_cnt(), "0"));
			int iIfrsEndMonthSusiCnt 	= Integer.parseInt(CommonUtil.isNull(bean.getIfrs_end_month_susi_cnt(), "0"));
			
			int iAisTotalCnt 			= Integer.parseInt(CommonUtil.isNull(bean.getAis_total_cnt(), "0"));
			int iAisTotalSusiCnt 		= Integer.parseInt(CommonUtil.isNull(bean.getAis_total_susi_cnt(), "0"));
			int iAisEndedOkCnt			= Integer.parseInt(CommonUtil.isNull(bean.getAis_ended_ok_cnt(), "0"));
			int iAisEndedNotOkCnt		= Integer.parseInt(CommonUtil.isNull(bean.getAis_ended_not_ok_cnt(), "0"));
			int iAisWaitCnt 			= Integer.parseInt(CommonUtil.isNull(bean.getAis_wait_cnt(), "0"));
			int iAisEtcCnt 				= Integer.parseInt(CommonUtil.isNull(bean.getAis_etc_cnt(), "0"));
			int iAisEndedOkSusiCnt 		= Integer.parseInt(CommonUtil.isNull(bean.getAis_ended_ok_susi_cnt(), "0"));
			int iAisEndedNotOkSusiCnt	= Integer.parseInt(CommonUtil.isNull(bean.getAis_ended_not_ok_susi_cnt(), "0"));
			int iAisWaitSusiCnt			= Integer.parseInt(CommonUtil.isNull(bean.getAis_wait_susi_cnt(), "0"));
			int iAisEtcSusiCnt 			= Integer.parseInt(CommonUtil.isNull(bean.getAis_etc_susi_cnt(), "0"));
			int iAisBeginMonthCnt		= Integer.parseInt(CommonUtil.isNull(bean.getAis_begin_month_cnt(), "0"));
			int iAisEndMonthCnt 		= Integer.parseInt(CommonUtil.isNull(bean.getAis_end_month_cnt(), "0"));
			int iAisBeginMonthSusiCnt	= Integer.parseInt(CommonUtil.isNull(bean.getAis_begin_month_susi_cnt(), "0"));
			int iAisEndMonthSusiCnt 	= Integer.parseInt(CommonUtil.isNull(bean.getAis_end_month_susi_cnt(), "0"));
			
			int iAlmTotalCnt 			= Integer.parseInt(CommonUtil.isNull(bean.getAlm_total_cnt(), "0"));
			int iAlmTotalSusiCnt 		= Integer.parseInt(CommonUtil.isNull(bean.getAlm_total_susi_cnt(), "0"));
			int iAlmEndedOkCnt			= Integer.parseInt(CommonUtil.isNull(bean.getAlm_ended_ok_cnt(), "0"));
			int iAlmEndedNotOkCnt		= Integer.parseInt(CommonUtil.isNull(bean.getAlm_ended_not_ok_cnt(), "0"));
			int iAlmWaitCnt 			= Integer.parseInt(CommonUtil.isNull(bean.getAlm_wait_cnt(), "0"));
			int iAlmEtcCnt 				= Integer.parseInt(CommonUtil.isNull(bean.getAlm_etc_cnt(), "0"));
			int iAlmEndedOkSusiCnt 		= Integer.parseInt(CommonUtil.isNull(bean.getAlm_ended_ok_susi_cnt(), "0"));
			int iAlmEndedNotOkSusiCnt	= Integer.parseInt(CommonUtil.isNull(bean.getAlm_ended_not_ok_susi_cnt(), "0"));
			int iAlmWaitSusiCnt			= Integer.parseInt(CommonUtil.isNull(bean.getAlm_wait_susi_cnt(), "0"));
			int iAlmEtcSusiCnt 			= Integer.parseInt(CommonUtil.isNull(bean.getAlm_etc_susi_cnt(), "0"));
			int iAlmBeginMonthCnt		= Integer.parseInt(CommonUtil.isNull(bean.getAlm_begin_month_cnt(), "0"));
			int iAlmEndMonthCnt 		= Integer.parseInt(CommonUtil.isNull(bean.getAlm_end_month_cnt(), "0"));
			int iAlmBeginMonthSusiCnt	= Integer.parseInt(CommonUtil.isNull(bean.getAlm_begin_month_susi_cnt(), "0"));
			int iAlmEndMonthSusiCnt 	= Integer.parseInt(CommonUtil.isNull(bean.getAlm_end_month_susi_cnt(), "0"));
			
			int iNewRdmTotalCnt 			= Integer.parseInt(CommonUtil.isNull(bean.getNew_rdm_total_cnt(), "0"));
			int iNewRdmTotalSusiCnt 		= Integer.parseInt(CommonUtil.isNull(bean.getNew_rdm_total_susi_cnt(), "0"));
			int iNewRdmEndedOkCnt			= Integer.parseInt(CommonUtil.isNull(bean.getNew_rdm_ended_ok_cnt(), "0"));
			int iNewRdmEndedNotOkCnt		= Integer.parseInt(CommonUtil.isNull(bean.getNew_rdm_ended_not_ok_cnt(), "0"));
			int iNewRdmWaitCnt 				= Integer.parseInt(CommonUtil.isNull(bean.getNew_rdm_wait_cnt(), "0"));
			int iNewRdmEtcCnt 				= Integer.parseInt(CommonUtil.isNull(bean.getNew_rdm_etc_cnt(), "0"));
			int iNewRdmEndedOkSusiCnt 		= Integer.parseInt(CommonUtil.isNull(bean.getNew_rdm_ended_ok_susi_cnt(), "0"));
			int iNewRdmEndedNotOkSusiCnt	= Integer.parseInt(CommonUtil.isNull(bean.getNew_rdm_ended_not_ok_susi_cnt(), "0"));
			int iNewRdmWaitSusiCnt			= Integer.parseInt(CommonUtil.isNull(bean.getNew_rdm_wait_susi_cnt(), "0"));
			int iNewRdmEtcSusiCnt 			= Integer.parseInt(CommonUtil.isNull(bean.getNew_rdm_etc_susi_cnt(), "0"));
			int iNewRdmBeginMonthCnt		= Integer.parseInt(CommonUtil.isNull(bean.getNew_rdm_begin_month_cnt(), "0"));
			int iNewRdmEndMonthCnt 			= Integer.parseInt(CommonUtil.isNull(bean.getNew_rdm_end_month_cnt(), "0"));
			int iNewRdmBeginMonthSusiCnt	= Integer.parseInt(CommonUtil.isNull(bean.getNew_rdm_begin_month_susi_cnt(), "0"));
			int iNewRdmEndMonthSusiCnt 		= Integer.parseInt(CommonUtil.isNull(bean.getNew_rdm_end_month_susi_cnt(), "0"));
			
			
			int iRbaTotalCnt 			= Integer.parseInt(CommonUtil.isNull(bean.getRba_total_cnt(), "0"));
			int iRbaTotalSusiCnt 		= Integer.parseInt(CommonUtil.isNull(bean.getRba_total_susi_cnt(), "0"));
			int iRbaEndedOkCnt			= Integer.parseInt(CommonUtil.isNull(bean.getRba_ended_ok_cnt(), "0"));
			int iRbaEndedNotOkCnt		= Integer.parseInt(CommonUtil.isNull(bean.getRba_ended_not_ok_cnt(), "0"));
			int iRbaWaitCnt 				= Integer.parseInt(CommonUtil.isNull(bean.getRba_wait_cnt(), "0"));
			int iRbaEtcCnt 				= Integer.parseInt(CommonUtil.isNull(bean.getRba_etc_cnt(), "0"));
			int iRbaEndedOkSusiCnt 		= Integer.parseInt(CommonUtil.isNull(bean.getRba_ended_ok_susi_cnt(), "0"));
			int iRbaEndedNotOkSusiCnt	= Integer.parseInt(CommonUtil.isNull(bean.getRba_ended_not_ok_susi_cnt(), "0"));
			int iRbaWaitSusiCnt			= Integer.parseInt(CommonUtil.isNull(bean.getRba_wait_susi_cnt(), "0"));
			int iRbaEtcSusiCnt 			= Integer.parseInt(CommonUtil.isNull(bean.getRba_etc_susi_cnt(), "0"));
			int iRbaBeginMonthCnt		= Integer.parseInt(CommonUtil.isNull(bean.getRba_begin_month_cnt(), "0"));
			int iRbaEndMonthCnt 			= Integer.parseInt(CommonUtil.isNull(bean.getRba_end_month_cnt(), "0"));
			int iRbaBeginMonthSusiCnt	= Integer.parseInt(CommonUtil.isNull(bean.getRba_begin_month_susi_cnt(), "0"));
			int iRbaEndMonthSusiCnt 		= Integer.parseInt(CommonUtil.isNull(bean.getRba_end_month_susi_cnt(), "0"));
			
			
			int iCrsTotalCnt 			= Integer.parseInt(CommonUtil.isNull(bean.getCrs_total_cnt(), "0"));
			int iCrsTotalSusiCnt 		= Integer.parseInt(CommonUtil.isNull(bean.getCrs_total_susi_cnt(), "0"));
			int iCrsEndedOkCnt			= Integer.parseInt(CommonUtil.isNull(bean.getCrs_ended_ok_cnt(), "0"));
			int iCrsEndedNotOkCnt		= Integer.parseInt(CommonUtil.isNull(bean.getCrs_ended_not_ok_cnt(), "0"));
			int iCrsWaitCnt 				= Integer.parseInt(CommonUtil.isNull(bean.getCrs_wait_cnt(), "0"));
			int iCrsEtcCnt 				= Integer.parseInt(CommonUtil.isNull(bean.getCrs_etc_cnt(), "0"));
			int iCrsEndedOkSusiCnt 		= Integer.parseInt(CommonUtil.isNull(bean.getCrs_ended_ok_susi_cnt(), "0"));
			int iCrsEndedNotOkSusiCnt	= Integer.parseInt(CommonUtil.isNull(bean.getCrs_ended_not_ok_susi_cnt(), "0"));
			int iCrsWaitSusiCnt			= Integer.parseInt(CommonUtil.isNull(bean.getCrs_wait_susi_cnt(), "0"));
			int iCrsEtcSusiCnt 			= Integer.parseInt(CommonUtil.isNull(bean.getCrs_etc_susi_cnt(), "0"));
			int iCrsBeginMonthCnt		= Integer.parseInt(CommonUtil.isNull(bean.getCrs_begin_month_cnt(), "0"));
			int iCrsEndMonthCnt 			= Integer.parseInt(CommonUtil.isNull(bean.getCrs_end_month_cnt(), "0"));
			int iCrsBeginMonthSusiCnt	= Integer.parseInt(CommonUtil.isNull(bean.getCrs_begin_month_susi_cnt(), "0"));
			int iCrsEndMonthSusiCnt 		= Integer.parseInt(CommonUtil.isNull(bean.getCrs_end_month_susi_cnt(), "0"));
			
			int iCnt = 5; 
			
			// 완료 건수 로우 생성
			XSSFRow EndedOkRow 	= sheet1.createRow((int) iCnt);
			EndedOkRow.setHeight((short)0x200);
			
			iCnt++;
			
			// 완료 건수 셀에 스타일 적용
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			style.setFont(font);
			
			// 완료 건수 로우에 셀 생성 
			XSSFCell EndedOkCell = EndedOkRow.createCell((int) 1);
			EndedOkCell.setCellValue("완료 건수");
			EndedOkCell.setCellStyle(style);
			
			EndedOkCell			= EndedOkRow.createCell((int) 2);
			EndedOkCell.setCellValue(iEndedOkCnt + iEndedOkSusiCnt + iEdwEndedOkCnt + iEdwEndedOkSusiCnt + iIfrsEndedOkCnt + iIfrsEndedOkSusiCnt + iAisEndedOkCnt + iAisEndedOkSusiCnt + iAlmEndedOkCnt + iAlmEndedOkSusiCnt + iNewRdmEndedOkCnt + iNewRdmEndedOkSusiCnt + iRbaEndedOkCnt + iRbaEndedOkSusiCnt + iCrsEndedOkCnt + iCrsEndedOkSusiCnt);
			EndedOkCell.setCellStyle(style);
			
			EndedOkCell			= EndedOkRow.createCell((int) 3);
			EndedOkCell.setCellValue(iEndedOkCnt + iEdwEndedOkCnt + iIfrsEndedOkCnt + iAisEndedOkCnt + iAlmEndedOkCnt + iNewRdmEndedOkCnt + iRbaEndedOkCnt + iCrsEndedOkCnt);
			EndedOkCell.setCellStyle(style);
			
			EndedOkCell			= EndedOkRow.createCell((int) 4);
			EndedOkCell.setCellValue(iEndedOkSusiCnt + iEdwEndedOkSusiCnt + iIfrsEndedOkSusiCnt + iAisEndedOkSusiCnt + iAlmEndedOkSusiCnt + iNewRdmEndedOkSusiCnt + iRbaEndedOkSusiCnt + iCrsEndedOkSusiCnt);
			EndedOkCell.setCellStyle(style);
			
			EndedOkCell			= EndedOkRow.createCell((int) 5);
			EndedOkCell.setCellValue(iEndedOkCnt + iEndedOkSusiCnt);
			EndedOkCell.setCellStyle(style);
			
			EndedOkCell			= EndedOkRow.createCell((int) 6);
			EndedOkCell.setCellValue(iEndedOkCnt);
			EndedOkCell.setCellStyle(style);
			
			EndedOkCell			= EndedOkRow.createCell((int) 7);
			EndedOkCell.setCellValue(iEndedOkSusiCnt);
			EndedOkCell.setCellStyle(style);
			
			EndedOkCell			= EndedOkRow.createCell((int) 8);
			EndedOkCell.setCellValue(iEdwEndedOkCnt + iEdwEndedOkSusiCnt);
			EndedOkCell.setCellStyle(style);
			
			EndedOkCell			= EndedOkRow.createCell((int) 9);
			EndedOkCell.setCellValue(iEdwEndedOkCnt);
			EndedOkCell.setCellStyle(style);
			
			EndedOkCell			= EndedOkRow.createCell((int) 10);
			EndedOkCell.setCellValue(iEdwEndedOkSusiCnt);
			EndedOkCell.setCellStyle(style);
			
			EndedOkCell			= EndedOkRow.createCell((int) 11);
			EndedOkCell.setCellValue(iIfrsEndedOkCnt + iIfrsEndedOkSusiCnt);
			EndedOkCell.setCellStyle(style);
			
			EndedOkCell			= EndedOkRow.createCell((int) 12);
			EndedOkCell.setCellValue(iIfrsEndedOkCnt);
			EndedOkCell.setCellStyle(style);
			
			EndedOkCell			= EndedOkRow.createCell((int) 13);
			EndedOkCell.setCellValue(iIfrsEndedOkSusiCnt);
			EndedOkCell.setCellStyle(style);
			
			EndedOkCell			= EndedOkRow.createCell((int) 14);
			EndedOkCell.setCellValue(iAisEndedOkCnt + iAisEndedOkSusiCnt);
			EndedOkCell.setCellStyle(style);
			
			EndedOkCell			= EndedOkRow.createCell((int) 15);
			EndedOkCell.setCellValue(iAisEndedOkCnt);
			EndedOkCell.setCellStyle(style);
			
			EndedOkCell			= EndedOkRow.createCell((int) 16);
			EndedOkCell.setCellValue(iAisEndedOkSusiCnt);
			EndedOkCell.setCellStyle(style);
			
			EndedOkCell			= EndedOkRow.createCell((int) 17);
			EndedOkCell.setCellValue(iAlmEndedOkCnt + iAlmEndedOkSusiCnt);
			EndedOkCell.setCellStyle(style);
			
			EndedOkCell			= EndedOkRow.createCell((int) 18);
			EndedOkCell.setCellValue(iAlmEndedOkCnt);
			EndedOkCell.setCellStyle(style);
			
			EndedOkCell			= EndedOkRow.createCell((int) 19);
			EndedOkCell.setCellValue(iAlmEndedOkSusiCnt);
			EndedOkCell.setCellStyle(style);
			
			EndedOkCell			= EndedOkRow.createCell((int) 20);
			EndedOkCell.setCellValue(iNewRdmEndedOkCnt + iNewRdmEndedOkSusiCnt);
			EndedOkCell.setCellStyle(style);
			
			EndedOkCell			= EndedOkRow.createCell((int) 21);
			EndedOkCell.setCellValue(iNewRdmEndedOkCnt);
			EndedOkCell.setCellStyle(style);
			
			EndedOkCell			= EndedOkRow.createCell((int) 22);
			EndedOkCell.setCellValue(iNewRdmEndedOkSusiCnt);
			EndedOkCell.setCellStyle(style);
			
			
			EndedOkCell			= EndedOkRow.createCell((int) 23);
			EndedOkCell.setCellValue(iRbaEndedOkCnt + iRbaEndedOkSusiCnt);
			EndedOkCell.setCellStyle(style);
			
			EndedOkCell			= EndedOkRow.createCell((int) 24);
			EndedOkCell.setCellValue(iRbaEndedOkCnt);
			EndedOkCell.setCellStyle(style);
			
			EndedOkCell			= EndedOkRow.createCell((int) 25);
			EndedOkCell.setCellValue(iRbaEndedOkSusiCnt);
			EndedOkCell.setCellStyle(style);
			
			
			EndedOkCell			= EndedOkRow.createCell((int) 26);
			EndedOkCell.setCellValue(iCrsEndedOkCnt + iCrsEndedOkSusiCnt);
			EndedOkCell.setCellStyle(style);
			
			EndedOkCell			= EndedOkRow.createCell((int) 27);
			EndedOkCell.setCellValue(iCrsEndedOkCnt);
			EndedOkCell.setCellStyle(style);
			
			EndedOkCell			= EndedOkRow.createCell((int) 28);
			EndedOkCell.setCellValue(iCrsEndedOkSusiCnt);
			EndedOkCell.setCellStyle(style);
			
			
			// 미완료 건수 로우 생성
			XSSFRow WaitRow 	= sheet1.createRow((int) iCnt);
			WaitRow.setHeight((short)0x200);
			
			iCnt++;
			
			// 미완료 건수 셀에 스타일 적용
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			style.setFont(font);
			
			// 미완료 건수 로우에 셀 생성 
			XSSFCell WaitCell = WaitRow.createCell((int) 1);
			WaitCell.setCellValue("미완료 건수");
			WaitCell.setCellStyle(style);
			
			WaitCell			= WaitRow.createCell((int) 2);
			WaitCell.setCellValue(iWaitCnt + iWaitSusiCnt + iEdwWaitCnt + iEdwWaitSusiCnt + iIfrsWaitCnt + iIfrsWaitSusiCnt + iAisWaitCnt + iAisWaitSusiCnt + iAlmWaitCnt + iAlmWaitSusiCnt + iNewRdmWaitCnt + iNewRdmWaitSusiCnt + iRbaWaitCnt + iRbaWaitSusiCnt + iCrsWaitCnt + iCrsWaitSusiCnt);
			WaitCell.setCellStyle(style);
			
			WaitCell			= WaitRow.createCell((int) 3);
			WaitCell.setCellValue(iWaitCnt + iEdwWaitCnt + iIfrsWaitCnt + iAisWaitCnt + iAlmWaitCnt + iNewRdmWaitCnt + iRbaWaitCnt + iCrsWaitCnt);
			WaitCell.setCellStyle(style);
			
			WaitCell			= WaitRow.createCell((int) 4);
			WaitCell.setCellValue(iWaitSusiCnt + iEdwWaitSusiCnt + iIfrsWaitSusiCnt + iAisWaitSusiCnt + iAlmWaitSusiCnt + iNewRdmWaitSusiCnt + iRbaWaitSusiCnt + iCrsWaitSusiCnt);
			WaitCell.setCellStyle(style);
			
			WaitCell			= WaitRow.createCell((int) 5);
			WaitCell.setCellValue(iWaitCnt + iWaitSusiCnt);
			WaitCell.setCellStyle(style);
			
			WaitCell			= WaitRow.createCell((int) 6);
			WaitCell.setCellValue(iWaitCnt);
			WaitCell.setCellStyle(style);
			
			WaitCell			= WaitRow.createCell((int) 7);
			WaitCell.setCellValue(iWaitSusiCnt);
			WaitCell.setCellStyle(style);
			
			WaitCell			= WaitRow.createCell((int) 8);
			WaitCell.setCellValue(iEdwWaitCnt + iEdwWaitSusiCnt);
			WaitCell.setCellStyle(style);
			
			WaitCell			= WaitRow.createCell((int) 9);
			WaitCell.setCellValue(iEdwWaitCnt);
			WaitCell.setCellStyle(style);
			
			WaitCell			= WaitRow.createCell((int) 10);
			WaitCell.setCellValue(iEdwWaitSusiCnt);
			WaitCell.setCellStyle(style);
			
			WaitCell			= WaitRow.createCell((int) 11);
			WaitCell.setCellValue(iIfrsWaitCnt + iIfrsWaitSusiCnt);
			WaitCell.setCellStyle(style);
			
			WaitCell			= WaitRow.createCell((int) 12);
			WaitCell.setCellValue(iIfrsWaitCnt);
			WaitCell.setCellStyle(style);
			
			WaitCell			= WaitRow.createCell((int) 13);
			WaitCell.setCellValue(iIfrsWaitSusiCnt);
			WaitCell.setCellStyle(style);
			
			WaitCell			= WaitRow.createCell((int) 14);
			WaitCell.setCellValue(iAisWaitCnt + iAisWaitSusiCnt);
			WaitCell.setCellStyle(style);
			
			WaitCell			= WaitRow.createCell((int) 15);
			WaitCell.setCellValue(iAisWaitCnt);
			WaitCell.setCellStyle(style);
			
			WaitCell			= WaitRow.createCell((int) 16);
			WaitCell.setCellValue(iAisWaitSusiCnt);
			WaitCell.setCellStyle(style);
			
			WaitCell			= WaitRow.createCell((int) 17);
			WaitCell.setCellValue(iAlmWaitCnt + iAlmWaitSusiCnt);
			WaitCell.setCellStyle(style);
			
			WaitCell			= WaitRow.createCell((int) 18);
			WaitCell.setCellValue(iAlmWaitCnt);
			WaitCell.setCellStyle(style);
			
			WaitCell			= WaitRow.createCell((int) 19);
			WaitCell.setCellValue(iAlmWaitSusiCnt);
			WaitCell.setCellStyle(style);
			
			WaitCell			= WaitRow.createCell((int) 20);
			WaitCell.setCellValue(iNewRdmWaitCnt + iNewRdmWaitSusiCnt);
			WaitCell.setCellStyle(style);
			
			WaitCell			= WaitRow.createCell((int) 21);
			WaitCell.setCellValue(iNewRdmWaitCnt);
			WaitCell.setCellStyle(style);
			
			WaitCell			= WaitRow.createCell((int) 22);
			WaitCell.setCellValue(iNewRdmWaitSusiCnt);
			WaitCell.setCellStyle(style);
			
			
			WaitCell			= WaitRow.createCell((int) 23);
			WaitCell.setCellValue(iRbaWaitCnt + iRbaWaitSusiCnt);
			WaitCell.setCellStyle(style);
			
			WaitCell			= WaitRow.createCell((int) 24);
			WaitCell.setCellValue(iRbaWaitCnt);
			WaitCell.setCellStyle(style);
			
			WaitCell			= WaitRow.createCell((int) 25);
			WaitCell.setCellValue(iRbaWaitSusiCnt);
			WaitCell.setCellStyle(style);
			
			
			WaitCell			= WaitRow.createCell((int) 26);
			WaitCell.setCellValue(iCrsWaitCnt + iCrsWaitSusiCnt);
			WaitCell.setCellStyle(style);
			
			WaitCell			= WaitRow.createCell((int) 27);
			WaitCell.setCellValue(iCrsWaitCnt);
			WaitCell.setCellStyle(style);
			
			WaitCell			= WaitRow.createCell((int) 28);
			WaitCell.setCellValue(iCrsWaitSusiCnt);
			WaitCell.setCellStyle(style);
			
			// 오류 건수 로우 생성
			XSSFRow EndedNotOkRow 	= sheet1.createRow((int) iCnt);
			EndedNotOkRow.setHeight((short)0x200);
			
			iCnt++;
			
			// 오류 건수 셀에 스타일 적용
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			style.setFont(font);
			
			// 오류 건수 로우에 셀 생성 
			XSSFCell EndedNotOkCell = EndedNotOkRow.createCell((int) 1);
			EndedNotOkCell.setCellValue("오류 건수");
			EndedNotOkCell.setCellStyle(style);
			
			EndedNotOkCell			= EndedNotOkRow.createCell((int) 2);
			EndedNotOkCell.setCellValue(iEndedNotOkCnt + iEndedNotOkSusiCnt + iEdwEndedNotOkCnt + iEdwEndedNotOkSusiCnt + iIfrsEndedNotOkCnt + iIfrsEndedNotOkSusiCnt + iAisEndedNotOkCnt + iAisEndedNotOkSusiCnt + iAlmEndedNotOkCnt + iAlmEndedNotOkSusiCnt + iNewRdmEndedNotOkCnt + iNewRdmEndedNotOkSusiCnt + iRbaEndedNotOkCnt + iRbaEndedNotOkSusiCnt + iCrsEndedNotOkCnt + iCrsEndedNotOkSusiCnt);
			EndedNotOkCell.setCellStyle(style);
			
			EndedNotOkCell			= EndedNotOkRow.createCell((int) 3);
			EndedNotOkCell.setCellValue(iEndedNotOkCnt + iEdwEndedNotOkCnt + iIfrsEndedNotOkCnt + iAisEndedNotOkCnt + iAlmEndedNotOkCnt + iNewRdmEndedNotOkCnt + iRbaEndedNotOkCnt + iCrsEndedNotOkCnt);
			EndedNotOkCell.setCellStyle(style);
			
			EndedNotOkCell			= EndedNotOkRow.createCell((int) 4);
			EndedNotOkCell.setCellValue(iEndedNotOkSusiCnt + iEdwEndedNotOkSusiCnt + iIfrsEndedNotOkSusiCnt + iAisEndedNotOkSusiCnt + iAlmEndedNotOkSusiCnt + iNewRdmEndedNotOkSusiCnt + iRbaEndedNotOkSusiCnt + iCrsEndedNotOkSusiCnt);
			EndedNotOkCell.setCellStyle(style);
			
			EndedNotOkCell			= EndedNotOkRow.createCell((int) 5);
			EndedNotOkCell.setCellValue(iEndedNotOkCnt + iEndedNotOkSusiCnt);
			EndedNotOkCell.setCellStyle(style);
			
			EndedNotOkCell			= EndedNotOkRow.createCell((int) 6);
			EndedNotOkCell.setCellValue(iEndedNotOkCnt);
			EndedNotOkCell.setCellStyle(style);
			
			EndedNotOkCell			= EndedNotOkRow.createCell((int) 7);
			EndedNotOkCell.setCellValue(iEndedNotOkSusiCnt);
			EndedNotOkCell.setCellStyle(style);
			
			EndedNotOkCell			= EndedNotOkRow.createCell((int) 8);
			EndedNotOkCell.setCellValue(iEdwEndedNotOkCnt + iEdwEndedNotOkSusiCnt);
			EndedNotOkCell.setCellStyle(style);
			
			EndedNotOkCell			= EndedNotOkRow.createCell((int) 9);
			EndedNotOkCell.setCellValue(iEdwEndedNotOkCnt);
			EndedNotOkCell.setCellStyle(style);
			
			EndedNotOkCell			= EndedNotOkRow.createCell((int) 10);
			EndedNotOkCell.setCellValue(iEdwEndedNotOkSusiCnt);
			EndedNotOkCell.setCellStyle(style);
			
			EndedNotOkCell			= EndedNotOkRow.createCell((int) 11);
			EndedNotOkCell.setCellValue(iIfrsEndedNotOkCnt + iIfrsEndedNotOkSusiCnt);
			EndedNotOkCell.setCellStyle(style);
			
			EndedNotOkCell			= EndedNotOkRow.createCell((int) 12);
			EndedNotOkCell.setCellValue(iIfrsEndedNotOkCnt);
			EndedNotOkCell.setCellStyle(style);
			
			EndedNotOkCell			= EndedNotOkRow.createCell((int) 13);
			EndedNotOkCell.setCellValue(iIfrsEndedNotOkSusiCnt);
			EndedNotOkCell.setCellStyle(style);
			
			EndedNotOkCell			= EndedNotOkRow.createCell((int) 14);
			EndedNotOkCell.setCellValue(iAisEndedNotOkCnt + iAisEndedNotOkSusiCnt);
			EndedNotOkCell.setCellStyle(style);
			
			EndedNotOkCell			= EndedNotOkRow.createCell((int) 15);
			EndedNotOkCell.setCellValue(iAisEndedNotOkCnt);
			EndedNotOkCell.setCellStyle(style);
			
			EndedNotOkCell			= EndedNotOkRow.createCell((int) 16);
			EndedNotOkCell.setCellValue(iAisEndedNotOkSusiCnt);
			EndedNotOkCell.setCellStyle(style);
			
			EndedNotOkCell			= EndedNotOkRow.createCell((int) 17);
			EndedNotOkCell.setCellValue(iAlmEndedNotOkCnt + iAlmEndedNotOkSusiCnt);
			EndedNotOkCell.setCellStyle(style);
			
			EndedNotOkCell			= EndedNotOkRow.createCell((int) 18);
			EndedNotOkCell.setCellValue(iAlmEndedNotOkCnt);
			EndedNotOkCell.setCellStyle(style);
			
			EndedNotOkCell			= EndedNotOkRow.createCell((int) 19);
			EndedNotOkCell.setCellValue(iAlmEndedNotOkSusiCnt);
			EndedNotOkCell.setCellStyle(style);
			
			EndedNotOkCell			= EndedNotOkRow.createCell((int) 20);
			EndedNotOkCell.setCellValue(iNewRdmEndedNotOkCnt + iNewRdmEndedNotOkSusiCnt);
			EndedNotOkCell.setCellStyle(style);
			
			EndedNotOkCell			= EndedNotOkRow.createCell((int) 21);
			EndedNotOkCell.setCellValue(iNewRdmEndedNotOkCnt);
			EndedNotOkCell.setCellStyle(style);
			
			EndedNotOkCell			= EndedNotOkRow.createCell((int) 22);
			EndedNotOkCell.setCellValue(iNewRdmEndedNotOkSusiCnt);
			EndedNotOkCell.setCellStyle(style);
			
			
			EndedNotOkCell			= EndedNotOkRow.createCell((int) 23);
			EndedNotOkCell.setCellValue(iRbaEndedNotOkCnt + iRbaEndedNotOkSusiCnt);
			EndedNotOkCell.setCellStyle(style);
			
			EndedNotOkCell			= EndedNotOkRow.createCell((int) 24);
			EndedNotOkCell.setCellValue(iRbaEndedNotOkCnt);
			EndedNotOkCell.setCellStyle(style);
			
			EndedNotOkCell			= EndedNotOkRow.createCell((int) 25);
			EndedNotOkCell.setCellValue(iRbaEndedNotOkSusiCnt);
			EndedNotOkCell.setCellStyle(style);
			
			
			EndedNotOkCell			= EndedNotOkRow.createCell((int) 26);
			EndedNotOkCell.setCellValue(iCrsEndedNotOkCnt + iCrsEndedNotOkSusiCnt);
			EndedNotOkCell.setCellStyle(style);
			
			EndedNotOkCell			= EndedNotOkRow.createCell((int) 27);
			EndedNotOkCell.setCellValue(iCrsEndedNotOkCnt);
			EndedNotOkCell.setCellStyle(style);
			
			EndedNotOkCell			= EndedNotOkRow.createCell((int) 28);
			EndedNotOkCell.setCellValue(iCrsEndedNotOkSusiCnt);
			EndedNotOkCell.setCellStyle(style);
			
			// 기타 건수 로우 생성
			XSSFRow EtcRow 	= sheet1.createRow((int) iCnt);
			EtcRow.setHeight((short)0x200);
			
			iCnt++;
			
			// 기타 건수 셀에 스타일 적용
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			style.setFont(font);
			
			// 기타 건수 로우에 셀 생성 
			XSSFCell EtcCell = EtcRow.createCell((int) 1);
			EtcCell.setCellValue("기타 건수");
			EtcCell.setCellStyle(style);
			
			EtcCell			= EtcRow.createCell((int) 2);
			EtcCell.setCellValue(iEtcCnt + iEtcSusiCnt + iEdwEtcCnt + iEdwEtcSusiCnt + iIfrsEtcCnt + iIfrsEtcSusiCnt + iAisEtcCnt + iAisEtcSusiCnt + iAlmEtcCnt + iAlmEtcSusiCnt + iNewRdmEtcCnt + iNewRdmEtcSusiCnt + iRbaEtcCnt + iRbaEtcSusiCnt + iCrsEtcCnt + iCrsEtcSusiCnt);
			EtcCell.setCellStyle(style);
			
			EtcCell			= EtcRow.createCell((int) 3);
			EtcCell.setCellValue(iEtcCnt + iEdwEtcCnt + iIfrsEtcCnt + iAisEtcCnt + iAlmEtcCnt + iNewRdmEtcCnt + iRbaEtcCnt + iCrsEtcCnt);
			EtcCell.setCellStyle(style);
			
			EtcCell			= EtcRow.createCell((int) 4);
			EtcCell.setCellValue(iEtcSusiCnt + iEdwEtcSusiCnt + iIfrsEtcSusiCnt + iAisEtcSusiCnt + iAlmEtcSusiCnt + iNewRdmEtcSusiCnt + iRbaEtcSusiCnt + iCrsEtcSusiCnt);
			EtcCell.setCellStyle(style);
			
			EtcCell			= EtcRow.createCell((int) 5);
			EtcCell.setCellValue(iEtcCnt + iEtcSusiCnt);
			EtcCell.setCellStyle(style);
			
			EtcCell			= EtcRow.createCell((int) 6);
			EtcCell.setCellValue(iEtcCnt);
			EtcCell.setCellStyle(style);
			
			EtcCell			= EtcRow.createCell((int) 7);
			EtcCell.setCellValue(iEtcSusiCnt);
			EtcCell.setCellStyle(style);
			
			EtcCell			= EtcRow.createCell((int) 8);
			EtcCell.setCellValue(iEdwEtcCnt + iEdwEtcSusiCnt);
			EtcCell.setCellStyle(style);
			
			EtcCell			= EtcRow.createCell((int) 9);
			EtcCell.setCellValue(iEdwEtcCnt);
			EtcCell.setCellStyle(style);
			
			EtcCell			= EtcRow.createCell((int) 10);
			EtcCell.setCellValue(iEdwEtcSusiCnt);
			EtcCell.setCellStyle(style);
			
			EtcCell			= EtcRow.createCell((int) 11);
			EtcCell.setCellValue(iIfrsEtcCnt + iIfrsEtcSusiCnt);
			EtcCell.setCellStyle(style);
			
			EtcCell			= EtcRow.createCell((int) 12);
			EtcCell.setCellValue(iIfrsEtcCnt);
			EtcCell.setCellStyle(style);
			
			EtcCell			= EtcRow.createCell((int) 13);
			EtcCell.setCellValue(iIfrsEtcSusiCnt);
			EtcCell.setCellStyle(style);
			
			EtcCell			= EtcRow.createCell((int) 14);
			EtcCell.setCellValue(iAisEtcCnt + iAisEtcSusiCnt);
			EtcCell.setCellStyle(style);
			
			EtcCell			= EtcRow.createCell((int) 15);
			EtcCell.setCellValue(iAisEtcCnt);
			EtcCell.setCellStyle(style);
			
			EtcCell			= EtcRow.createCell((int) 16);
			EtcCell.setCellValue(iAisEtcSusiCnt);
			EtcCell.setCellStyle(style);
			
			EtcCell			= EtcRow.createCell((int) 17);
			EtcCell.setCellValue(iAlmEtcCnt + iAlmEtcSusiCnt);
			EtcCell.setCellStyle(style);
			
			EtcCell			= EtcRow.createCell((int) 18);
			EtcCell.setCellValue(iAlmEtcCnt);
			EtcCell.setCellStyle(style);
			
			EtcCell			= EtcRow.createCell((int) 19);
			EtcCell.setCellValue(iAlmEtcSusiCnt);
			EtcCell.setCellStyle(style);
			
			EtcCell			= EtcRow.createCell((int) 20);
			EtcCell.setCellValue(iNewRdmEtcCnt + iNewRdmEtcSusiCnt);
			EtcCell.setCellStyle(style);
			
			EtcCell			= EtcRow.createCell((int) 21);
			EtcCell.setCellValue(iNewRdmEtcCnt);
			EtcCell.setCellStyle(style);
			
			EtcCell			= EtcRow.createCell((int) 22);
			EtcCell.setCellValue(iNewRdmEtcSusiCnt);
			EtcCell.setCellStyle(style);
			
			
			EtcCell			= EtcRow.createCell((int) 23);
			EtcCell.setCellValue(iRbaEtcCnt + iRbaEtcSusiCnt);
			EtcCell.setCellStyle(style);
			
			EtcCell			= EtcRow.createCell((int) 24);
			EtcCell.setCellValue(iRbaEtcCnt);
			EtcCell.setCellStyle(style);
			
			EtcCell			= EtcRow.createCell((int) 25);
			EtcCell.setCellValue(iRbaEtcSusiCnt);
			EtcCell.setCellStyle(style);
			
			
			EtcCell			= EtcRow.createCell((int) 26);
			EtcCell.setCellValue(iCrsEtcCnt + iCrsEtcSusiCnt);
			EtcCell.setCellStyle(style);
			
			EtcCell			= EtcRow.createCell((int) 27);
			EtcCell.setCellValue(iCrsEtcCnt);
			EtcCell.setCellStyle(style);
			
			EtcCell			= EtcRow.createCell((int) 28);
			EtcCell.setCellValue(iCrsEtcSusiCnt);
			EtcCell.setCellStyle(style);
			
			if ( (iBeginMonthCnt + iBeginMonthSusiCnt) > 0 ) {
				
				// 월초 건수 로우 생성
				XSSFRow BeginMonthRow 	= sheet1.createRow((int) iCnt);
				BeginMonthRow.setHeight((short)0x200);
				
				iCnt++;
				
				// 월초 건수 셀에 스타일 적용
				style	= wb.createCellStyle();
				style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
				style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
				style.setBorderRight(XSSFCellStyle.BORDER_THIN);
				style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
				style.setBorderTop(XSSFCellStyle.BORDER_THIN);
				style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
				style.setFont(font);
				
				// 월초 건수 로우에 셀 생성 
				XSSFCell BeginMonthCell = BeginMonthRow.createCell((int) 1);
				BeginMonthCell.setCellValue("월초 건수");
				BeginMonthCell.setCellStyle(style);
				
				BeginMonthCell			= BeginMonthRow.createCell((int) 2);
				BeginMonthCell.setCellValue(iBeginMonthCnt + iBeginMonthSusiCnt + iEdwBeginMonthCnt + iEdwBeginMonthSusiCnt + iIfrsBeginMonthCnt + iIfrsBeginMonthSusiCnt + iAisBeginMonthCnt + iAisBeginMonthSusiCnt + iAlmBeginMonthCnt + iAlmBeginMonthSusiCnt + iNewRdmBeginMonthCnt + iNewRdmBeginMonthSusiCnt + iRbaBeginMonthCnt + iRbaBeginMonthSusiCnt + iCrsBeginMonthCnt + iCrsBeginMonthSusiCnt);
				BeginMonthCell.setCellStyle(style);
				
				BeginMonthCell			= BeginMonthRow.createCell((int) 3);
				BeginMonthCell.setCellValue(iBeginMonthCnt + iEdwBeginMonthCnt + iIfrsBeginMonthCnt + iAisBeginMonthCnt + iAlmBeginMonthCnt + iNewRdmBeginMonthCnt + iRbaBeginMonthCnt + iCrsBeginMonthCnt);
				BeginMonthCell.setCellStyle(style);
				
				BeginMonthCell			= BeginMonthRow.createCell((int) 4);
				BeginMonthCell.setCellValue(iBeginMonthSusiCnt + iEdwBeginMonthSusiCnt + iIfrsBeginMonthSusiCnt + iAisBeginMonthSusiCnt + iAlmBeginMonthSusiCnt + iNewRdmBeginMonthSusiCnt + iRbaBeginMonthSusiCnt + iCrsBeginMonthSusiCnt);
				BeginMonthCell.setCellStyle(style);
				
				BeginMonthCell			= BeginMonthRow.createCell((int) 5);
				BeginMonthCell.setCellValue(iBeginMonthCnt + iBeginMonthSusiCnt);
				BeginMonthCell.setCellStyle(style);
				
				BeginMonthCell			= BeginMonthRow.createCell((int) 6);
				BeginMonthCell.setCellValue(iBeginMonthCnt);
				BeginMonthCell.setCellStyle(style);
				
				BeginMonthCell			= BeginMonthRow.createCell((int) 7);
				BeginMonthCell.setCellValue(iBeginMonthSusiCnt);
				BeginMonthCell.setCellStyle(style);
				
				BeginMonthCell			= BeginMonthRow.createCell((int) 8);
				BeginMonthCell.setCellValue(iEdwBeginMonthCnt + iEdwBeginMonthSusiCnt);
				BeginMonthCell.setCellStyle(style);
				
				BeginMonthCell			= BeginMonthRow.createCell((int) 9);
				BeginMonthCell.setCellValue(iEdwBeginMonthCnt);
				BeginMonthCell.setCellStyle(style);
				
				BeginMonthCell			= BeginMonthRow.createCell((int) 10);
				BeginMonthCell.setCellValue(iEdwBeginMonthSusiCnt);
				BeginMonthCell.setCellStyle(style);	
				
				BeginMonthCell			= BeginMonthRow.createCell((int) 11);
				BeginMonthCell.setCellValue(iIfrsBeginMonthCnt + iIfrsBeginMonthSusiCnt);
				BeginMonthCell.setCellStyle(style);
				
				BeginMonthCell			= BeginMonthRow.createCell((int) 12);
				BeginMonthCell.setCellValue(iIfrsBeginMonthCnt);
				BeginMonthCell.setCellStyle(style);
				
				BeginMonthCell			= BeginMonthRow.createCell((int) 13);
				BeginMonthCell.setCellValue(iIfrsBeginMonthSusiCnt);
				BeginMonthCell.setCellStyle(style);
				
				BeginMonthCell			= BeginMonthRow.createCell((int) 14);
				BeginMonthCell.setCellValue(iAisBeginMonthCnt + iAisBeginMonthSusiCnt);
				BeginMonthCell.setCellStyle(style);
				
				BeginMonthCell			= BeginMonthRow.createCell((int) 15);
				BeginMonthCell.setCellValue(iAisBeginMonthCnt);
				BeginMonthCell.setCellStyle(style);
				
				BeginMonthCell			= BeginMonthRow.createCell((int) 16);
				BeginMonthCell.setCellValue(iAisBeginMonthSusiCnt);
				BeginMonthCell.setCellStyle(style);
				
				BeginMonthCell			= BeginMonthRow.createCell((int) 17);
				BeginMonthCell.setCellValue(iAlmBeginMonthCnt + iAlmBeginMonthSusiCnt);
				BeginMonthCell.setCellStyle(style);
				
				BeginMonthCell			= BeginMonthRow.createCell((int) 18);
				BeginMonthCell.setCellValue(iAlmBeginMonthCnt);
				BeginMonthCell.setCellStyle(style);
				
				BeginMonthCell			= BeginMonthRow.createCell((int) 19);
				BeginMonthCell.setCellValue(iAlmBeginMonthSusiCnt);
				BeginMonthCell.setCellStyle(style);
				
				BeginMonthCell			= BeginMonthRow.createCell((int) 20);
				BeginMonthCell.setCellValue(iNewRdmBeginMonthCnt + iNewRdmBeginMonthSusiCnt);
				BeginMonthCell.setCellStyle(style);
				
				BeginMonthCell			= BeginMonthRow.createCell((int) 21);
				BeginMonthCell.setCellValue(iNewRdmBeginMonthCnt);
				BeginMonthCell.setCellStyle(style);
				
				BeginMonthCell			= BeginMonthRow.createCell((int) 22);
				BeginMonthCell.setCellValue(iNewRdmBeginMonthSusiCnt);
				BeginMonthCell.setCellStyle(style);
				
				BeginMonthCell			= BeginMonthRow.createCell((int) 23);
				BeginMonthCell.setCellValue(iRbaBeginMonthCnt + iRbaBeginMonthSusiCnt);
				BeginMonthCell.setCellStyle(style);
				
				BeginMonthCell			= BeginMonthRow.createCell((int) 24);
				BeginMonthCell.setCellValue(iRbaBeginMonthCnt);
				BeginMonthCell.setCellStyle(style);
				
				BeginMonthCell			= BeginMonthRow.createCell((int) 25);
				BeginMonthCell.setCellValue(iRbaBeginMonthSusiCnt);
				BeginMonthCell.setCellStyle(style);
				
				BeginMonthCell			= BeginMonthRow.createCell((int) 26);
				BeginMonthCell.setCellValue(iCrsBeginMonthCnt + iCrsBeginMonthSusiCnt);
				BeginMonthCell.setCellStyle(style);
				
				BeginMonthCell			= BeginMonthRow.createCell((int) 27);
				BeginMonthCell.setCellValue(iCrsBeginMonthCnt);
				BeginMonthCell.setCellStyle(style);
				
				BeginMonthCell			= BeginMonthRow.createCell((int) 28);
				BeginMonthCell.setCellValue(iCrsBeginMonthSusiCnt);
				BeginMonthCell.setCellStyle(style);
			}
			
			if ( (iEndMonthCnt + iEndMonthSusiCnt) > 0 ) {
				
				// 월말 건수 로우 생성
				XSSFRow EndMonthRow 	= sheet1.createRow((int) iCnt);
				EndMonthRow.setHeight((short)0x200);
				
				iCnt++;
				
				// 월말 건수 셀에 스타일 적용
				style	= wb.createCellStyle();
				style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
				style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
				style.setBorderRight(XSSFCellStyle.BORDER_THIN);
				style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
				style.setBorderTop(XSSFCellStyle.BORDER_THIN);
				style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
				style.setFont(font);
				
				// 월말 건수 로우에 셀 생성 
				XSSFCell EndMonthCell = EndMonthRow.createCell((int) 1);
				EndMonthCell.setCellValue("월말 건수");
				EndMonthCell.setCellStyle(style);
				
				EndMonthCell			= EndMonthRow.createCell((int) 2);
				EndMonthCell.setCellValue(iEndMonthCnt + iEndMonthSusiCnt + iEdwEndMonthCnt + iEdwEndMonthSusiCnt + iIfrsEndMonthCnt + iIfrsEndMonthSusiCnt + iAisEndMonthCnt + iAisEndMonthSusiCnt + iAlmEndMonthCnt + iAlmEndMonthSusiCnt + iNewRdmEndMonthCnt + iNewRdmEndMonthSusiCnt + iRbaEndMonthCnt + iRbaEndMonthSusiCnt + iCrsEndMonthCnt + iCrsEndMonthSusiCnt);
				EndMonthCell.setCellStyle(style);
				
				EndMonthCell			= EndMonthRow.createCell((int) 3);
				EndMonthCell.setCellValue(iEndMonthCnt + iEdwEndMonthCnt + iIfrsEndMonthCnt + iAisEndMonthCnt + iAlmEndMonthCnt + iNewRdmEndMonthCnt + iRbaEndMonthCnt + iCrsEndMonthCnt);
				EndMonthCell.setCellStyle(style);
				
				EndMonthCell			= EndMonthRow.createCell((int) 4);
				EndMonthCell.setCellValue(iEndMonthSusiCnt + iEdwEndMonthSusiCnt + iIfrsEndMonthSusiCnt + iAisEndMonthSusiCnt + iAlmEndMonthSusiCnt + iNewRdmEndMonthSusiCnt + iRbaEndMonthSusiCnt + iCrsEndMonthSusiCnt);
				EndMonthCell.setCellStyle(style);
				
				EndMonthCell			= EndMonthRow.createCell((int) 5);
				EndMonthCell.setCellValue(iEndMonthCnt + iEndMonthSusiCnt);
				EndMonthCell.setCellStyle(style);
				
				EndMonthCell			= EndMonthRow.createCell((int) 6);
				EndMonthCell.setCellValue(iEndMonthCnt);
				EndMonthCell.setCellStyle(style);
				
				EndMonthCell			= EndMonthRow.createCell((int) 7);
				EndMonthCell.setCellValue(iEndMonthSusiCnt);
				EndMonthCell.setCellStyle(style);
				
				EndMonthCell			= EndMonthRow.createCell((int) 8);
				EndMonthCell.setCellValue(iEdwEndMonthCnt + iEdwEndMonthSusiCnt);
				EndMonthCell.setCellStyle(style);
				
				EndMonthCell			= EndMonthRow.createCell((int) 9);
				EndMonthCell.setCellValue(iEdwEndMonthCnt);
				EndMonthCell.setCellStyle(style);
				
				EndMonthCell			= EndMonthRow.createCell((int) 10);
				EndMonthCell.setCellValue(iEdwEndMonthSusiCnt);
				EndMonthCell.setCellStyle(style);
				
				EndMonthCell			= EndMonthRow.createCell((int) 11);
				EndMonthCell.setCellValue(iIfrsEndMonthCnt + iIfrsEndMonthSusiCnt);
				EndMonthCell.setCellStyle(style);
				
				EndMonthCell			= EndMonthRow.createCell((int) 12);
				EndMonthCell.setCellValue(iIfrsEndMonthCnt);
				EndMonthCell.setCellStyle(style);
				
				EndMonthCell			= EndMonthRow.createCell((int) 13);
				EndMonthCell.setCellValue(iIfrsEndMonthSusiCnt);
				EndMonthCell.setCellStyle(style);		
				
				EndMonthCell			= EndMonthRow.createCell((int) 14);
				EndMonthCell.setCellValue(iAisEndMonthCnt + iAisEndMonthSusiCnt);
				EndMonthCell.setCellStyle(style);
				
				EndMonthCell			= EndMonthRow.createCell((int) 15);
				EndMonthCell.setCellValue(iAisEndMonthCnt);
				EndMonthCell.setCellStyle(style);
				
				EndMonthCell			= EndMonthRow.createCell((int) 16);
				EndMonthCell.setCellValue(iAisEndMonthSusiCnt);
				EndMonthCell.setCellStyle(style);
				
				EndMonthCell			= EndMonthRow.createCell((int) 17);
				EndMonthCell.setCellValue(iAlmEndMonthCnt + iAlmEndMonthSusiCnt);
				EndMonthCell.setCellStyle(style);
				
				EndMonthCell			= EndMonthRow.createCell((int) 18);
				EndMonthCell.setCellValue(iAlmEndMonthCnt);
				EndMonthCell.setCellStyle(style);
				
				EndMonthCell			= EndMonthRow.createCell((int) 19);
				EndMonthCell.setCellValue(iAlmEndMonthSusiCnt);
				EndMonthCell.setCellStyle(style);
				
				EndMonthCell			= EndMonthRow.createCell((int) 20);
				EndMonthCell.setCellValue(iNewRdmEndMonthCnt + iNewRdmEndMonthSusiCnt);
				EndMonthCell.setCellStyle(style);
				
				EndMonthCell			= EndMonthRow.createCell((int) 21);
				EndMonthCell.setCellValue(iNewRdmEndMonthCnt);
				EndMonthCell.setCellStyle(style);
				
				EndMonthCell			= EndMonthRow.createCell((int) 22);
				EndMonthCell.setCellValue(iNewRdmEndMonthSusiCnt);
				EndMonthCell.setCellStyle(style);
				
				EndMonthCell			= EndMonthRow.createCell((int) 23);
				EndMonthCell.setCellValue(iRbaEndMonthCnt + iRbaEndMonthSusiCnt);
				EndMonthCell.setCellStyle(style);
				
				EndMonthCell			= EndMonthRow.createCell((int) 24);
				EndMonthCell.setCellValue(iRbaEndMonthCnt);
				EndMonthCell.setCellStyle(style);
				
				EndMonthCell			= EndMonthRow.createCell((int) 25);
				EndMonthCell.setCellValue(iRbaEndMonthSusiCnt);
				EndMonthCell.setCellStyle(style);				
				
				EndMonthCell			= EndMonthRow.createCell((int) 26);
				EndMonthCell.setCellValue(iCrsEndMonthCnt + iCrsEndMonthSusiCnt);
				EndMonthCell.setCellStyle(style);
				
				EndMonthCell			= EndMonthRow.createCell((int) 27);
				EndMonthCell.setCellValue(iCrsEndMonthCnt);
				EndMonthCell.setCellStyle(style);
				
				EndMonthCell			= EndMonthRow.createCell((int) 28);
				EndMonthCell.setCellValue(iCrsEndMonthSusiCnt);
				EndMonthCell.setCellStyle(style);
			}
			
			// 총계 건수 로우 생성
			XSSFRow TotalRow 	= sheet1.createRow((int) iCnt);
			TotalRow.setHeight((short)0x200);
			
			iCnt++;
			
			// 총계 건수 셀에 스타일 적용
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			style.setFont(font);
			
			// 총계 건수 로우에 셀 생성 
			XSSFCell TotalCell = TotalRow.createCell((int) 1);
			TotalCell.setCellValue("총계");
			TotalCell.setCellStyle(style);
			
			TotalCell			= TotalRow.createCell((int) 2);
			TotalCell.setCellValue(iTotalCnt + iTotalSusiCnt + iEdwTotalCnt + iEdwTotalSusiCnt + iIfrsTotalCnt + iIfrsTotalSusiCnt + iAisTotalCnt + iAisTotalSusiCnt + iAlmTotalCnt + iAlmTotalSusiCnt + iNewRdmTotalCnt + iNewRdmTotalSusiCnt + iRbaTotalCnt + iRbaTotalSusiCnt + iCrsTotalCnt + iCrsTotalSusiCnt);
			TotalCell.setCellStyle(style);
			
			TotalCell			= TotalRow.createCell((int) 3);
			TotalCell.setCellValue(iTotalCnt + iEdwTotalCnt + iIfrsTotalCnt + iAisTotalCnt + iAlmTotalCnt + iNewRdmTotalCnt + iRbaTotalCnt + iCrsTotalCnt);
			TotalCell.setCellStyle(style);
			
			TotalCell			= TotalRow.createCell((int) 4);
			TotalCell.setCellValue(iTotalSusiCnt + iEdwTotalSusiCnt + iIfrsTotalSusiCnt + iAisTotalSusiCnt + iAlmTotalSusiCnt + iNewRdmTotalSusiCnt + iRbaTotalSusiCnt + iCrsTotalSusiCnt);
			TotalCell.setCellStyle(style);
			
			TotalCell			= TotalRow.createCell((int) 5);
			TotalCell.setCellValue(iTotalCnt + iTotalSusiCnt);
			TotalCell.setCellStyle(style);
			
			TotalCell			= TotalRow.createCell((int) 6);
			TotalCell.setCellValue(iTotalCnt);
			TotalCell.setCellStyle(style);
			
			TotalCell			= TotalRow.createCell((int) 7);
			TotalCell.setCellValue(iTotalSusiCnt);
			TotalCell.setCellStyle(style);
			
			TotalCell			= TotalRow.createCell((int) 8);
			TotalCell.setCellValue(iEdwTotalCnt + iEdwTotalSusiCnt);
			TotalCell.setCellStyle(style);
			
			TotalCell			= TotalRow.createCell((int) 9);
			TotalCell.setCellValue(iEdwTotalCnt);
			TotalCell.setCellStyle(style);
			
			TotalCell			= TotalRow.createCell((int) 10);
			TotalCell.setCellValue(iEdwTotalSusiCnt);
			TotalCell.setCellStyle(style);	
			
			TotalCell			= TotalRow.createCell((int) 11);
			TotalCell.setCellValue(iIfrsTotalCnt + iIfrsTotalSusiCnt);
			TotalCell.setCellStyle(style);
			
			TotalCell			= TotalRow.createCell((int) 12);
			TotalCell.setCellValue(iIfrsTotalCnt);
			TotalCell.setCellStyle(style);
			
			TotalCell			= TotalRow.createCell((int) 13);
			TotalCell.setCellValue(iIfrsTotalSusiCnt);
			TotalCell.setCellStyle(style);	
			
			TotalCell			= TotalRow.createCell((int) 14);
			TotalCell.setCellValue(iAisTotalCnt + iAisTotalSusiCnt);
			TotalCell.setCellStyle(style);
			
			TotalCell			= TotalRow.createCell((int) 15);
			TotalCell.setCellValue(iAisTotalCnt);
			TotalCell.setCellStyle(style);
			
			TotalCell			= TotalRow.createCell((int) 16);
			TotalCell.setCellValue(iAisTotalSusiCnt);
			TotalCell.setCellStyle(style);	
			
			TotalCell			= TotalRow.createCell((int) 17);
			TotalCell.setCellValue(iAlmTotalCnt + iAlmTotalSusiCnt);
			TotalCell.setCellStyle(style);
			
			TotalCell			= TotalRow.createCell((int) 18);
			TotalCell.setCellValue(iAlmTotalCnt);
			TotalCell.setCellStyle(style);
			
			TotalCell			= TotalRow.createCell((int) 19);
			TotalCell.setCellValue(iAlmTotalSusiCnt);
			TotalCell.setCellStyle(style);	
			
			TotalCell			= TotalRow.createCell((int) 20);
			TotalCell.setCellValue(iNewRdmTotalCnt + iNewRdmTotalSusiCnt);
			TotalCell.setCellStyle(style);
			
			TotalCell			= TotalRow.createCell((int) 21);
			TotalCell.setCellValue(iNewRdmTotalCnt);
			TotalCell.setCellStyle(style);
			
			TotalCell			= TotalRow.createCell((int) 22);
			TotalCell.setCellValue(iNewRdmTotalSusiCnt);
			TotalCell.setCellStyle(style);
			
			TotalCell			= TotalRow.createCell((int) 23);
			TotalCell.setCellValue(iRbaTotalCnt + iRbaTotalSusiCnt);
			TotalCell.setCellStyle(style);
			
			TotalCell			= TotalRow.createCell((int) 24);
			TotalCell.setCellValue(iRbaTotalCnt);
			TotalCell.setCellStyle(style);
			
			TotalCell			= TotalRow.createCell((int) 25);
			TotalCell.setCellValue(iRbaTotalSusiCnt);
			TotalCell.setCellStyle(style);
			
			TotalCell			= TotalRow.createCell((int) 26);
			TotalCell.setCellValue(iCrsTotalCnt + iCrsTotalSusiCnt);
			TotalCell.setCellStyle(style);
			
			TotalCell			= TotalRow.createCell((int) 27);
			TotalCell.setCellValue(iCrsTotalCnt);
			TotalCell.setCellStyle(style);
			
			TotalCell			= TotalRow.createCell((int) 28);
			TotalCell.setCellValue(iCrsTotalSusiCnt);
			TotalCell.setCellStyle(style);
		}
		
		sheet1.setColumnWidth(0, (int)400);
		
		for(int i=1; i<=25; i++){
			sheet1.autoSizeColumn(i);
			sheet1.setColumnWidth(i, sheet1.getColumnWidth(i)+1000 );
		}
		
		
		
		
		
		
		// 시트 생성
		XSSFSheet sheet2 	= wb.createSheet("계정계");
		
		int sheet2_row_count = 0;
		
		// 문서 제목 로우 생성
		XSSFRow sheet2_nameRow 	= sheet2.createRow((int) sheet2_row_count + 1);
		sheet2_row_count++;
		
		// 문서 제목 로우에 셀 생성
		XSSFCell sheet2_cell	= sheet2_nameRow.createCell((int) 1);
		
		sheet2_cell.setCellValue("<계정계 작업 처리 현황 " + s_search_odate + " ~  " + e_search_odate + ">");
		
		font = wb.createFont();
		
		style	= wb.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		//style.setBorderRight(XSSFCellStyle.BORDER_THIN);
		//style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
		//style.setBorderTop(XSSFCellStyle.BORDER_THIN);
		//style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
		
		
		
		// 문서 제목 셀에 스타일 적용
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setFont(font);
		sheet2_cell.setCellStyle(style);
		
		// 문서 제목 셀 병합
		sheet2.addMergedRegion(new CellRangeAddress(1,  1, 1,  9));
		
		// 한줄 띄우기
		sheet2.createRow((int) sheet2_row_count + 1);
		sheet2_row_count++;
		
		// 구분 로우 생성
		XSSFRow sheet2_gubunRow 	= sheet2.createRow((int) sheet2_row_count + 1);
		sheet2_row_count++;
		
		// 구분 로우에 셀 생성
		XSSFCell sheet2_gubunCell	= sheet2_gubunRow.createCell((int) 1);
		
		sheet2_gubunCell.setCellValue("작업 의뢰서 처리 현황");
		
		// 구분 셀 병합
		sheet2.addMergedRegion(new CellRangeAddress(3,  3, 1,  9));
		
		// 구분 셀에 스타일 적용
		style	= wb.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setFillForegroundColor(IndexedColors.LEMON_CHIFFON.index);
		style.setFillPattern(XSSFCellStyle.SOLID_FOREGROUND);
		sheet2_gubunCell.setCellStyle(style);
		
		// 타이틀 로우 생성
		XSSFRow sheet2_titleRow 	= sheet2.createRow((int) sheet2_row_count + 1);
		sheet2_row_count++;
		
		// 타이틀 셀에 스타일 적용
		style	= wb.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.index);
		style.setFillPattern(XSSFCellStyle.SOLID_FOREGROUND);
		style.setBorderRight(XSSFCellStyle.BORDER_THIN);
		style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
		style.setBorderTop(XSSFCellStyle.BORDER_THIN);
		style.setBorderBottom(XSSFCellStyle.BORDER_THIN);		
		
		// 타이틀 로우에 셀 생성 
		XSSFCell sheet2_titleCell	= sheet2_titleRow.createCell((int) 1);
		sheet2_titleCell.setCellValue("No");
		sheet2_titleCell.setCellStyle(style);
		
		sheet2_titleCell			= sheet2_titleRow.createCell((int) 2);
		sheet2_titleCell.setCellValue("ODATE");
		sheet2_titleCell.setCellStyle(style);
		
		sheet2_titleCell			= sheet2_titleRow.createCell((int) 3);
		sheet2_titleCell.setCellValue("수행건수");
		sheet2_titleCell.setCellStyle(style);
		
		sheet2_titleCell			= sheet2_titleRow.createCell((int) 4);
		sheet2_titleCell.setCellValue("처리상태");
		sheet2_titleCell.setCellStyle(style);
		
		sheet2_titleCell			= sheet2_titleRow.createCell((int) 5);
		sheet2_titleCell.setCellValue("작업명");
		sheet2_titleCell.setCellStyle(style);
		
		sheet2_titleCell			= sheet2_titleRow.createCell((int) 6);
		sheet2_titleCell.setCellValue("시작시간");
		sheet2_titleCell.setCellStyle(style);
		
		sheet2_titleCell			= sheet2_titleRow.createCell((int) 7);
		sheet2_titleCell.setCellValue("종료시간");
		sheet2_titleCell.setCellStyle(style);
		
		sheet2_titleCell			= sheet2_titleRow.createCell((int) 8);
		sheet2_titleCell.setCellValue("수행시간");
		sheet2_titleCell.setCellStyle(style);
		
		sheet2_titleCell			= sheet2_titleRow.createCell((int) 9);
		sheet2_titleCell.setCellValue("작업설명");
		sheet2_titleCell.setCellStyle(style);
		
		for( int i=0; null!=jobOpReportList && i<jobOpReportList.size(); i++ ){
			JobLogBean bean = (JobLogBean)jobOpReportList.get(i);
			
			String strOdate 		= CommonUtil.isNull(bean.getOdate());
			String strJobName 		= CommonUtil.isNull(bean.getJob_name());
			String strOrderTable 	= CommonUtil.isNull(bean.getOrder_table());
			String strApplication 	= CommonUtil.isNull(bean.getApplication());
			String strGroupName 	= CommonUtil.isNull(bean.getGroup_name());
			String strStateResult 	= CommonUtil.isNull(bean.getState_result());
			String strStatus 		= CommonUtil.isNull(bean.getStatus());
			String strStartTime 	= CommonUtil.isNull(CommonUtil.getDateFormat(1,bean.getStart_time(),"-"));
			String strEndTime 		= CommonUtil.isNull(CommonUtil.getDateFormat(1,bean.getEnd_time(),"-;"));
			String strRunTime 		= CommonUtil.getDiffTime( CommonUtil.getDateFormat(1,bean.getStart_time()),CommonUtil.getDateFormat(1,bean.getEnd_time()));
			String strDescription	= CommonUtil.isNull(bean.getDescription());
			String strRerunCounter	= CommonUtil.isNull(bean.getRerun_counter());
			
			String strStatusMent = "";
			if ( strStatus.equals("Ended OK") ) {
				strStatusMent = "완료";
			} else if ( strStatus.equals("Ended Not OK") ) {
				strStatusMent = "오류";
			} else if ( strStatus.indexOf("Wait") > -1 ) {
				strStatusMent = "미완료";
			} else if ( !strStatus.equals("Ended OK") && !strStatus.equals("Ended Not OK") && strStatus.indexOf("Wait") == -1 ) {
				strStatusMent = "기타";
			}
			
			XSSFRow sheet2_listRow = sheet2.createRow((int) sheet2_row_count + 1);
			sheet2_row_count++;
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			XSSFCell sheet2_listCell2	= sheet2_listRow.createCell((int) 1);
			sheet2_listCell2.setCellValue((i+1));
			sheet2_listCell2.setCellStyle(style);
			
			sheet2_listCell2	= sheet2_listRow.createCell((int) 2);
			sheet2_listCell2.setCellValue(strOdate);
			sheet2_listCell2.setCellStyle(style);
			
			sheet2_listCell2	= sheet2_listRow.createCell((int) 3);
			sheet2_listCell2.setCellValue(strRerunCounter);
			sheet2_listCell2.setCellStyle(style);
			
			sheet2_listCell2	= sheet2_listRow.createCell((int) 4);
			sheet2_listCell2.setCellValue(strStatusMent);
			sheet2_listCell2.setCellStyle(style);
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			sheet2_listCell2	= sheet2_listRow.createCell((int) 5);
			sheet2_listCell2.setCellValue(" " + strJobName);			
			sheet2_listCell2.setCellStyle(style);
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			sheet2_listCell2	= sheet2_listRow.createCell((int) 6);
			sheet2_listCell2.setCellValue(strStartTime);
			sheet2_listCell2.setCellStyle(style);
			
			sheet2_listCell2	= sheet2_listRow.createCell((int) 7);
			sheet2_listCell2.setCellValue(strEndTime);
			sheet2_listCell2.setCellStyle(style);
			
			sheet2_listCell2	= sheet2_listRow.createCell((int) 8);
			sheet2_listCell2.setCellValue(strRunTime);
			sheet2_listCell2.setCellStyle(style);
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			sheet2_listCell2	= sheet2_listRow.createCell((int) 9);
			sheet2_listCell2.setCellValue(" " + strDescription);			
			sheet2_listCell2.setCellStyle(style);
		}
		
		// 한줄 띄우기
		sheet2.createRow((int) sheet2_row_count + 1);
		sheet2_row_count++;
		
		// 한줄 띄우기
		sheet2.createRow((int) sheet2_row_count + 1);
		sheet2_row_count++;
		
		// 구분 로우 생성
		XSSFRow sheet2_gubunRow2 	= sheet2.createRow((int) sheet2_row_count + 1);
		sheet2_row_count++;
		
		// 구분 로우에 셀 생성
		XSSFCell sheet2_gubunCell2	= sheet2_gubunRow2.createCell((int) 1);
		
		sheet2_gubunCell2.setCellValue("정규 작업 처리 현황");
		
		// 구분 셀 병합
		sheet2.addMergedRegion(new CellRangeAddress(sheet2_row_count,  sheet2_row_count, 1,  9));
		
		// 구분 셀에 스타일 적용
		style	= wb.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setFillForegroundColor(IndexedColors.LEMON_CHIFFON.index);
		style.setFillPattern(XSSFCellStyle.SOLID_FOREGROUND);
		sheet2_gubunCell2.setCellStyle(style);
		
		// 타이틀 로우 생성
		XSSFRow sheet2_titleRow2 	= sheet2.createRow((int) sheet2_row_count + 1);
		sheet2_row_count++;
		
		// 타이틀 셀에 스타일 적용
		style	= wb.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.index);
		style.setFillPattern(XSSFCellStyle.SOLID_FOREGROUND);
		style.setBorderRight(XSSFCellStyle.BORDER_THIN);
		style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
		style.setBorderTop(XSSFCellStyle.BORDER_THIN);
		style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
		
		// 타이틀 로우에 셀 생성 
		XSSFCell sheet2_titleCell2	= sheet2_titleRow2.createCell((int) 1);
		sheet2_titleCell2.setCellValue("No");
		sheet2_titleCell2.setCellStyle(style);
		
		sheet2_titleCell2			= sheet2_titleRow2.createCell((int) 2);
		sheet2_titleCell2.setCellValue("ODATE");
		sheet2_titleCell2.setCellStyle(style);
		
		sheet2_titleCell2			= sheet2_titleRow2.createCell((int) 3);
		sheet2_titleCell2.setCellValue("수행건수");
		sheet2_titleCell2.setCellStyle(style);
		
		sheet2_titleCell2			= sheet2_titleRow2.createCell((int) 4);
		sheet2_titleCell2.setCellValue("처리상태");
		sheet2_titleCell2.setCellStyle(style);
		
		sheet2_titleCell2			= sheet2_titleRow2.createCell((int) 5);
		sheet2_titleCell2.setCellValue("작업명");
		sheet2_titleCell2.setCellStyle(style);
		
		sheet2_titleCell2			= sheet2_titleRow2.createCell((int) 6);
		sheet2_titleCell2.setCellValue("시작시간");
		sheet2_titleCell2.setCellStyle(style);
		
		sheet2_titleCell2			= sheet2_titleRow2.createCell((int) 7);
		sheet2_titleCell2.setCellValue("종료시간");
		sheet2_titleCell2.setCellStyle(style);
		
		sheet2_titleCell2			= sheet2_titleRow2.createCell((int) 8);
		sheet2_titleCell2.setCellValue("수행시간");
		sheet2_titleCell2.setCellStyle(style);
		
		sheet2_titleCell2			= sheet2_titleRow2.createCell((int) 9);
		sheet2_titleCell2.setCellValue("작업설명");
		sheet2_titleCell2.setCellStyle(style);
		
		for( int i=0; null!=jobOpReportList2 && i<jobOpReportList2.size(); i++ ){
			JobLogBean bean = (JobLogBean)jobOpReportList2.get(i);
			
			String strOdate 		= CommonUtil.isNull(bean.getOdate());
			String strJobName 		= CommonUtil.isNull(bean.getJob_name());
			String strOrderTable 	= CommonUtil.isNull(bean.getOrder_table());
			String strApplication 	= CommonUtil.isNull(bean.getApplication());
			String strGroupName 	= CommonUtil.isNull(bean.getGroup_name());
			String strStateResult 	= CommonUtil.isNull(bean.getState_result());
			String strStatus 		= CommonUtil.isNull(bean.getStatus());
			String strStartTime 	= CommonUtil.isNull(CommonUtil.getDateFormat(1,bean.getStart_time(),"-"));
			String strEndTime 		= CommonUtil.isNull(CommonUtil.getDateFormat(1,bean.getEnd_time(),"-"));
			String strRunTime 		= CommonUtil.getDiffTime( CommonUtil.getDateFormat(1,bean.getStart_time()),CommonUtil.getDateFormat(1,bean.getEnd_time()));
			String strDescription	= CommonUtil.isNull(bean.getDescription());
			String strRerunCounter	= CommonUtil.isNull(bean.getRerun_counter());
			
			String strStatusMent = "";
			if ( strStatus.equals("Ended OK") ) {
				strStatusMent = "완료";
			} else if ( strStatus.equals("Ended Not OK") ) {
				strStatusMent = "오류";
			} else if ( strStatus.indexOf("Wait") > -1 ) {
				strStatusMent = "미완료";
			} else if ( !strStatus.equals("Ended OK") && !strStatus.equals("Ended Not OK") && strStatus.indexOf("Wait") == -1 ) {
				strStatusMent = "기타";
			}
			
			XSSFRow sheet2_listRow2 = sheet2.createRow((int) sheet2_row_count + 1);
			sheet2_row_count++;
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			XSSFCell sheet2_listCell2	= sheet2_listRow2.createCell((int) 1);
			sheet2_listCell2.setCellValue((i+1));
			sheet2_listCell2.setCellStyle(style);
			
			sheet2_listCell2	= sheet2_listRow2.createCell((int) 2);
			sheet2_listCell2.setCellValue(strOdate);
			sheet2_listCell2.setCellStyle(style);
			
			sheet2_listCell2	= sheet2_listRow2.createCell((int) 3);
			sheet2_listCell2.setCellValue(strRerunCounter);
			sheet2_listCell2.setCellStyle(style);
			
			sheet2_listCell2	= sheet2_listRow2.createCell((int) 4);
			sheet2_listCell2.setCellValue(strStatusMent);
			sheet2_listCell2.setCellStyle(style);
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			sheet2_listCell2	= sheet2_listRow2.createCell((int) 5);
			sheet2_listCell2.setCellValue(" " + strJobName);			
			sheet2_listCell2.setCellStyle(style);
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			sheet2_listCell2	= sheet2_listRow2.createCell((int) 6);
			sheet2_listCell2.setCellValue(strStartTime);
			sheet2_listCell2.setCellStyle(style);
			
			sheet2_listCell2	= sheet2_listRow2.createCell((int) 7);
			sheet2_listCell2.setCellValue(strEndTime);
			sheet2_listCell2.setCellStyle(style);
			
			sheet2_listCell2	= sheet2_listRow2.createCell((int) 8);
			sheet2_listCell2.setCellValue(strRunTime);
			sheet2_listCell2.setCellStyle(style);
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			sheet2_listCell2	= sheet2_listRow2.createCell((int) 9);
			sheet2_listCell2.setCellValue(" " + strDescription);			
			sheet2_listCell2.setCellStyle(style);
		}
		
		// 한줄 띄우기
		sheet2.createRow((int) sheet2_row_count + 1);
		sheet2_row_count++;
		
		// 한줄 띄우기
		sheet2.createRow((int) sheet2_row_count + 1);
		sheet2_row_count++;
		
		// 구분 로우 생성
		XSSFRow sheet2_gubunRow3 	= sheet2.createRow((int) sheet2_row_count + 1);
		sheet2_row_count++;
		
		// 구분 로우에 셀 생성
		XSSFCell sheet2_gubunCell3	= sheet2_gubunRow3.createCell((int) 1);
		
		sheet2_gubunCell3.setCellValue("월초 작업 처리 현황");
		
		// 구분 셀 병합
		sheet2.addMergedRegion(new CellRangeAddress(sheet2_row_count,  sheet2_row_count, 1,  9));
		
		// 구분 셀에 스타일 적용
		style	= wb.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setFillForegroundColor(IndexedColors.LEMON_CHIFFON.index);
		style.setFillPattern(XSSFCellStyle.SOLID_FOREGROUND);
		sheet2_gubunCell3.setCellStyle(style);
		
		// 타이틀 로우 생성
		XSSFRow sheet2_titleRow3 	= sheet2.createRow((int) sheet2_row_count + 1);
		sheet2_row_count++;
		
		// 타이틀 셀에 스타일 적용
		style	= wb.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.index);
		style.setFillPattern(XSSFCellStyle.SOLID_FOREGROUND);
		style.setBorderRight(XSSFCellStyle.BORDER_THIN);
		style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
		style.setBorderTop(XSSFCellStyle.BORDER_THIN);
		style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
		
		// 타이틀 로우에 셀 생성 
		XSSFCell sheet2_titleCell3	= sheet2_titleRow3.createCell((int) 1);
		sheet2_titleCell3.setCellValue("No");
		sheet2_titleCell3.setCellStyle(style);
		
		sheet2_titleCell3			= sheet2_titleRow3.createCell((int) 2);
		sheet2_titleCell3.setCellValue("ODATE");
		sheet2_titleCell3.setCellStyle(style);
		
		sheet2_titleCell3			= sheet2_titleRow3.createCell((int) 3);
		sheet2_titleCell3.setCellValue("수행건수");
		sheet2_titleCell3.setCellStyle(style);
		
		sheet2_titleCell3			= sheet2_titleRow3.createCell((int) 4);
		sheet2_titleCell3.setCellValue("처리상태");
		sheet2_titleCell3.setCellStyle(style);
		
		sheet2_titleCell3			= sheet2_titleRow3.createCell((int) 5);
		sheet2_titleCell3.setCellValue("작업명");
		sheet2_titleCell3.setCellStyle(style);
		
		sheet2_titleCell3			= sheet2_titleRow3.createCell((int) 6);
		sheet2_titleCell3.setCellValue("시작시간");
		sheet2_titleCell3.setCellStyle(style);
		
		sheet2_titleCell3			= sheet2_titleRow3.createCell((int) 7);
		sheet2_titleCell3.setCellValue("종료시간");
		sheet2_titleCell3.setCellStyle(style);
		
		sheet2_titleCell3			= sheet2_titleRow3.createCell((int) 8);
		sheet2_titleCell3.setCellValue("수행시간");
		sheet2_titleCell3.setCellStyle(style);
		
		sheet2_titleCell3			= sheet2_titleRow3.createCell((int) 9);
		sheet2_titleCell3.setCellValue("작업설명");
		sheet2_titleCell3.setCellStyle(style);
		
		for( int i=0; null!=jobOpReportList3 && i<jobOpReportList3.size(); i++ ){
			JobLogBean bean = (JobLogBean)jobOpReportList3.get(i);
			
			String strOdate 		= CommonUtil.isNull(bean.getOdate());
			String strJobName 		= CommonUtil.isNull(bean.getJob_name());
			String strOrderTable 	= CommonUtil.isNull(bean.getOrder_table());
			String strApplication 	= CommonUtil.isNull(bean.getApplication());
			String strGroupName 	= CommonUtil.isNull(bean.getGroup_name());
			String strStateResult 	= CommonUtil.isNull(bean.getState_result());
			String strStatus 		= CommonUtil.isNull(bean.getStatus());
			String strStartTime 	= CommonUtil.isNull(CommonUtil.getDateFormat(1,bean.getStart_time(),"-"));
			String strEndTime 		= CommonUtil.isNull(CommonUtil.getDateFormat(1,bean.getEnd_time(),"-"));
			String strRunTime 		= CommonUtil.getDiffTime( CommonUtil.getDateFormat(1,bean.getStart_time()),CommonUtil.getDateFormat(1,bean.getEnd_time()));
			String strDescription	= CommonUtil.isNull(bean.getDescription());
			String strRerunCounter	= CommonUtil.isNull(bean.getRerun_counter());
			
			String strStatusMent = "";
			if ( strStatus.equals("Ended OK") ) {
				strStatusMent = "완료";
			} else if ( strStatus.equals("Ended Not OK") ) {
				strStatusMent = "오류";
			} else if ( strStatus.indexOf("Wait") > -1 ) {
				strStatusMent = "미완료";
			} else if ( !strStatus.equals("Ended OK") && !strStatus.equals("Ended Not OK") && strStatus.indexOf("Wait") == -1 ) {
				strStatusMent = "기타";
			}
			
			XSSFRow sheet2_listRow3 = sheet2.createRow((int) sheet2_row_count + 1);
			sheet2_row_count++;
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			XSSFCell sheet2_listCell2	= sheet2_listRow3.createCell((int) 1);
			sheet2_listCell2.setCellValue((i+1));
			sheet2_listCell2.setCellStyle(style);
			
			sheet2_listCell2	= sheet2_listRow3.createCell((int) 2);
			sheet2_listCell2.setCellValue(strOdate);
			sheet2_listCell2.setCellStyle(style);
			
			sheet2_listCell2	= sheet2_listRow3.createCell((int) 3);
			sheet2_listCell2.setCellValue(strRerunCounter);
			sheet2_listCell2.setCellStyle(style);
			
			sheet2_listCell2	= sheet2_listRow3.createCell((int) 4);
			sheet2_listCell2.setCellValue(strStatusMent);
			sheet2_listCell2.setCellStyle(style);
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			sheet2_listCell2	= sheet2_listRow3.createCell((int) 5);
			sheet2_listCell2.setCellValue(" " + strJobName);			
			sheet2_listCell2.setCellStyle(style);
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			sheet2_listCell2	= sheet2_listRow3.createCell((int) 6);
			sheet2_listCell2.setCellValue(strStartTime);
			sheet2_listCell2.setCellStyle(style);
			
			sheet2_listCell2	= sheet2_listRow3.createCell((int) 7);
			sheet2_listCell2.setCellValue(strEndTime);
			sheet2_listCell2.setCellStyle(style);
			
			sheet2_listCell2	= sheet2_listRow3.createCell((int) 8);
			sheet2_listCell2.setCellValue(strRunTime);
			sheet2_listCell2.setCellStyle(style);
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			sheet2_listCell2	= sheet2_listRow3.createCell((int) 9);
			sheet2_listCell2.setCellValue(" " + strDescription);			
			sheet2_listCell2.setCellStyle(style);
		}
		
		// 한줄 띄우기
		sheet2.createRow((int) sheet2_row_count + 1);
		sheet2_row_count++;
		
		// 한줄 띄우기
		sheet2.createRow((int) sheet2_row_count + 1);
		sheet2_row_count++;
		
		// 구분 로우 생성
		XSSFRow sheet2_gubunRow4 	= sheet2.createRow((int) sheet2_row_count + 1);
		sheet2_row_count++;
		
		// 구분 로우에 셀 생성
		XSSFCell sheet2_gubunCell4	= sheet2_gubunRow4.createCell((int) 1);
		
		sheet2_gubunCell4.setCellValue("월말 작업 처리 현황");
		
		// 구분 셀 병합
		sheet2.addMergedRegion(new CellRangeAddress(sheet2_row_count,  sheet2_row_count, 1,  9));
		
		// 구분 셀에 스타일 적용
		style	= wb.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setFillForegroundColor(IndexedColors.LEMON_CHIFFON.index);
		style.setFillPattern(XSSFCellStyle.SOLID_FOREGROUND);
		sheet2_gubunCell4.setCellStyle(style);
		
		// 타이틀 로우 생성
		XSSFRow sheet2_titleRow4 	= sheet2.createRow((int) sheet2_row_count + 1);
		sheet2_row_count++;
		
		// 타이틀 셀에 스타일 적용
		style	= wb.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.index);
		style.setFillPattern(XSSFCellStyle.SOLID_FOREGROUND);
		style.setBorderRight(XSSFCellStyle.BORDER_THIN);
		style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
		style.setBorderTop(XSSFCellStyle.BORDER_THIN);
		style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
		
		// 타이틀 로우에 셀 생성 
		XSSFCell sheet2_titleCell4	= sheet2_titleRow4.createCell((int) 1);
		sheet2_titleCell4.setCellValue("No");
		sheet2_titleCell4.setCellStyle(style);
		
		sheet2_titleCell4			= sheet2_titleRow4.createCell((int) 2);
		sheet2_titleCell4.setCellValue("ODATE");
		sheet2_titleCell4.setCellStyle(style);
		
		sheet2_titleCell4			= sheet2_titleRow4.createCell((int) 3);
		sheet2_titleCell4.setCellValue("수행건수");
		sheet2_titleCell4.setCellStyle(style);
		
		sheet2_titleCell4			= sheet2_titleRow4.createCell((int) 4);
		sheet2_titleCell4.setCellValue("처리상태");
		sheet2_titleCell4.setCellStyle(style);
		
		sheet2_titleCell4			= sheet2_titleRow4.createCell((int) 5);
		sheet2_titleCell4.setCellValue("작업명");
		sheet2_titleCell4.setCellStyle(style);
		
		sheet2_titleCell4			= sheet2_titleRow4.createCell((int) 6);
		sheet2_titleCell4.setCellValue("시작시간");
		sheet2_titleCell4.setCellStyle(style);
		
		sheet2_titleCell4			= sheet2_titleRow4.createCell((int) 7);
		sheet2_titleCell4.setCellValue("종료시간");
		sheet2_titleCell4.setCellStyle(style);
		
		sheet2_titleCell4			= sheet2_titleRow4.createCell((int) 8);
		sheet2_titleCell4.setCellValue("수행시간");
		sheet2_titleCell4.setCellStyle(style);
		
		sheet2_titleCell4			= sheet2_titleRow4.createCell((int) 9);
		sheet2_titleCell4.setCellValue("작업설명");
		sheet2_titleCell4.setCellStyle(style);
		
		for( int i=0; null!=jobOpReportList4 && i<jobOpReportList4.size(); i++ ){
			JobLogBean bean = (JobLogBean)jobOpReportList4.get(i);
			
			String strOdate 		= CommonUtil.isNull(bean.getOdate());
			String strJobName 		= CommonUtil.isNull(bean.getJob_name());
			String strOrderTable 	= CommonUtil.isNull(bean.getOrder_table());
			String strApplication 	= CommonUtil.isNull(bean.getApplication());
			String strGroupName 	= CommonUtil.isNull(bean.getGroup_name());
			String strStateResult 	= CommonUtil.isNull(bean.getState_result());
			String strStatus 		= CommonUtil.isNull(bean.getStatus());
			String strStartTime 	= CommonUtil.isNull(CommonUtil.getDateFormat(1,bean.getStart_time(),"-"));
			String strEndTime 		= CommonUtil.isNull(CommonUtil.getDateFormat(1,bean.getEnd_time(),"-"));
			String strRunTime 		= CommonUtil.getDiffTime( CommonUtil.getDateFormat(1,bean.getStart_time()),CommonUtil.getDateFormat(1,bean.getEnd_time()));
			String strDescription	= CommonUtil.isNull(bean.getDescription());
			String strRerunCounter	= CommonUtil.isNull(bean.getRerun_counter());
			
			String strStatusMent = "";
			if ( strStatus.equals("Ended OK") ) {
				strStatusMent = "완료";
			} else if ( strStatus.equals("Ended Not OK") ) {
				strStatusMent = "오류";
			} else if ( strStatus.indexOf("Wait") > -1 ) {
				strStatusMent = "미완료";
			} else if ( !strStatus.equals("Ended OK") && !strStatus.equals("Ended Not OK") && strStatus.indexOf("Wait") == -1 ) {
				strStatusMent = "기타";
			}
			
			XSSFRow sheet2_listRow3 = sheet2.createRow((int) sheet2_row_count + 1);
			sheet2_row_count++;
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			XSSFCell sheet2_listCell2	= sheet2_listRow3.createCell((int) 1);
			sheet2_listCell2.setCellValue((i+1));
			sheet2_listCell2.setCellStyle(style);
			
			sheet2_listCell2	= sheet2_listRow3.createCell((int) 2);
			sheet2_listCell2.setCellValue(strOdate);
			sheet2_listCell2.setCellStyle(style);
			
			sheet2_listCell2	= sheet2_listRow3.createCell((int) 3);
			sheet2_listCell2.setCellValue(strRerunCounter);
			sheet2_listCell2.setCellStyle(style);
			
			sheet2_listCell2	= sheet2_listRow3.createCell((int) 4);
			sheet2_listCell2.setCellValue(strStatusMent);
			sheet2_listCell2.setCellStyle(style);
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			sheet2_listCell2	= sheet2_listRow3.createCell((int) 5);
			sheet2_listCell2.setCellValue(" " + strJobName);			
			sheet2_listCell2.setCellStyle(style);
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			sheet2_listCell2	= sheet2_listRow3.createCell((int) 6);
			sheet2_listCell2.setCellValue(strStartTime);
			sheet2_listCell2.setCellStyle(style);
			
			sheet2_listCell2	= sheet2_listRow3.createCell((int) 7);
			sheet2_listCell2.setCellValue(strEndTime);
			sheet2_listCell2.setCellStyle(style);
			
			sheet2_listCell2	= sheet2_listRow3.createCell((int) 8);
			sheet2_listCell2.setCellValue(strRunTime);
			sheet2_listCell2.setCellStyle(style);
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			sheet2_listCell2	= sheet2_listRow3.createCell((int) 9);
			sheet2_listCell2.setCellValue(" " + strDescription);			
			sheet2_listCell2.setCellStyle(style);
		}
		
		sheet2.setColumnWidth(0, (int)0x200);
		
		for(int i=1; i<=10; i++){
			sheet2.autoSizeColumn(i);
			sheet2.setColumnWidth(i, sheet2.getColumnWidth(i)+700 );
		}
		
		// 시트 생성
		XSSFSheet sheet3 	= wb.createSheet("EDW");
		
		int sheet3_row_count = 0;
		
		// 문서 제목 로우 생성
		XSSFRow sheet3_nameRow 	= sheet3.createRow((int) sheet3_row_count + 1);
		sheet3_row_count++;
		
		// 문서 제목 로우에 셀 생성
		XSSFCell sheet3_cell	= sheet3_nameRow.createCell((int) 1);
		
		sheet3_cell.setCellValue("<EDW 작업 처리 현황 " + s_search_odate + " ~  " + e_search_odate + ">");
		
		// 문서 제목 셀에 스타일 적용
		style	= wb.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		sheet3_cell.setCellStyle(style);
		
		// 문서 제목 셀 병합
		sheet3.addMergedRegion(new CellRangeAddress(1,  1, 1,  9));
		
		// 한줄 띄우기
		sheet3.createRow((int) sheet3_row_count + 1);
		sheet3_row_count++;
		
		// 구분 로우 생성
		XSSFRow sheet3_gubunRow 	= sheet3.createRow((int) sheet3_row_count + 1);
		sheet3_row_count++;
		
		// 구분 로우에 셀 생성
		XSSFCell sheet3_gubunCell	= sheet3_gubunRow.createCell((int) 1);
		
		sheet3_gubunCell.setCellValue("작업 의뢰서 처리 현황");
		
		// 구분 셀 병합
		sheet3.addMergedRegion(new CellRangeAddress(3,  3, 1,  9));
		
		// 구분 셀에 스타일 적용
		style	= wb.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setFillForegroundColor(IndexedColors.PALE_BLUE.index);
		style.setFillPattern(XSSFCellStyle.SOLID_FOREGROUND);
		sheet3_gubunCell.setCellStyle(style);
		
		// 타이틀 로우 생성
		XSSFRow sheet3_titleRow 	= sheet3.createRow((int) sheet3_row_count + 1);
		sheet3_row_count++;
		
		// 타이틀 셀에 스타일 적용
		style	= wb.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.index);
		style.setFillPattern(XSSFCellStyle.SOLID_FOREGROUND);
		style.setBorderRight(XSSFCellStyle.BORDER_THIN);
		style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
		style.setBorderTop(XSSFCellStyle.BORDER_THIN);
		style.setBorderBottom(XSSFCellStyle.BORDER_THIN);		
		
		// 타이틀 로우에 셀 생성 
		XSSFCell sheet3_titleCell	= sheet3_titleRow.createCell((int) 1);
		sheet3_titleCell.setCellValue("No");
		sheet3_titleCell.setCellStyle(style);
		
		sheet3_titleCell			= sheet3_titleRow.createCell((int) 2);
		sheet3_titleCell.setCellValue("ODATE");
		sheet3_titleCell.setCellStyle(style);
		
		sheet3_titleCell			= sheet3_titleRow.createCell((int) 3);
		sheet3_titleCell.setCellValue("수행건수");
		sheet3_titleCell.setCellStyle(style);
		
		sheet3_titleCell			= sheet3_titleRow.createCell((int) 4);
		sheet3_titleCell.setCellValue("처리상태");
		sheet3_titleCell.setCellStyle(style);
		
		sheet3_titleCell			= sheet3_titleRow.createCell((int) 5);
		sheet3_titleCell.setCellValue("작업명");
		sheet3_titleCell.setCellStyle(style);
		
		sheet3_titleCell			= sheet3_titleRow.createCell((int) 6);
		sheet3_titleCell.setCellValue("시작시간");
		sheet3_titleCell.setCellStyle(style);
		
		sheet3_titleCell			= sheet3_titleRow.createCell((int) 7);
		sheet3_titleCell.setCellValue("종료시간");
		sheet3_titleCell.setCellStyle(style);
		
		sheet3_titleCell			= sheet3_titleRow.createCell((int) 8);
		sheet3_titleCell.setCellValue("수행시간");
		sheet3_titleCell.setCellStyle(style);
		
		sheet3_titleCell			= sheet3_titleRow.createCell((int) 9);
		sheet3_titleCell.setCellValue("작업설명");
		sheet3_titleCell.setCellStyle(style);
		
		
		for( int i=0; null!=jobOpReportEdwList && i<jobOpReportEdwList.size(); i++ ){
			JobLogBean bean = (JobLogBean)jobOpReportEdwList.get(i);
			
			String strOdate 		= CommonUtil.isNull(bean.getOdate());
			String strJobName 		= CommonUtil.isNull(bean.getJob_name());
			String strOrderTable 	= CommonUtil.isNull(bean.getOrder_table());
			String strApplication 	= CommonUtil.isNull(bean.getApplication());
			String strGroupName 	= CommonUtil.isNull(bean.getGroup_name());
			String strStateResult 	= CommonUtil.isNull(bean.getState_result());
			String strStatus 		= CommonUtil.isNull(bean.getStatus());
			String strStartTime 	= CommonUtil.isNull(CommonUtil.getDateFormat(1,bean.getStart_time(),"-"));
			String strEndTime 		= CommonUtil.isNull(CommonUtil.getDateFormat(1,bean.getEnd_time(),"-;"));
			String strRunTime 		= CommonUtil.getDiffTime( CommonUtil.getDateFormat(1,bean.getStart_time()),CommonUtil.getDateFormat(1,bean.getEnd_time()));
			String strDescription	= CommonUtil.isNull(bean.getDescription());
			String strRerunCounter	= CommonUtil.isNull(bean.getRerun_counter());
			
			String strStatusMent = "";
			if ( strStatus.equals("Ended OK") ) {
				strStatusMent = "완료";
			} else if ( strStatus.equals("Ended Not OK") ) {
				strStatusMent = "오류";
			} else if ( strStatus.indexOf("Wait") > -1 ) {
				strStatusMent = "미완료";
			} else if ( !strStatus.equals("Ended OK") && !strStatus.equals("Ended Not OK") && strStatus.indexOf("Wait") == -1 ) {
				strStatusMent = "기타";
			}
			
			XSSFRow sheet3_listRow = sheet3.createRow((int) sheet3_row_count + 1);
			sheet3_row_count++;
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			XSSFCell sheet3_listCell2	= sheet3_listRow.createCell((int) 1);
			sheet3_listCell2.setCellValue((i+1));
			sheet3_listCell2.setCellStyle(style);
			
			sheet3_listCell2	= sheet3_listRow.createCell((int) 2);
			sheet3_listCell2.setCellValue(strOdate);
			sheet3_listCell2.setCellStyle(style);
			
			sheet3_listCell2	= sheet3_listRow.createCell((int) 3);
			sheet3_listCell2.setCellValue(strRerunCounter);
			sheet3_listCell2.setCellStyle(style);
			
			sheet3_listCell2	= sheet3_listRow.createCell((int) 4);
			sheet3_listCell2.setCellValue(strStatusMent);
			sheet3_listCell2.setCellStyle(style);
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			sheet3_listCell2	= sheet3_listRow.createCell((int) 5);
			sheet3_listCell2.setCellValue(" " + strJobName);			
			sheet3_listCell2.setCellStyle(style);
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			sheet3_listCell2	= sheet3_listRow.createCell((int) 6);
			sheet3_listCell2.setCellValue(strStartTime);
			sheet3_listCell2.setCellStyle(style);
			
			sheet3_listCell2	= sheet3_listRow.createCell((int) 7);
			sheet3_listCell2.setCellValue(strEndTime);
			sheet3_listCell2.setCellStyle(style);
			
			sheet3_listCell2	= sheet3_listRow.createCell((int) 8);
			sheet3_listCell2.setCellValue(strRunTime);
			sheet3_listCell2.setCellStyle(style);
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			sheet3_listCell2	= sheet3_listRow.createCell((int) 9);
			sheet3_listCell2.setCellValue(" " + strDescription);			
			sheet3_listCell2.setCellStyle(style);
		}

		// 한줄 띄우기
		sheet3.createRow((int) sheet3_row_count + 1);
		sheet3_row_count++;
		
		// 한줄 띄우기
		sheet3.createRow((int) sheet3_row_count + 1);
		sheet3_row_count++;
		
		// 구분 로우 생성
		XSSFRow sheet3_gubunRow2 	= sheet3.createRow((int) sheet3_row_count + 1);
		sheet3_row_count++;
		
		// 구분 로우에 셀 생성
		XSSFCell sheet3_gubunCell2	= sheet3_gubunRow2.createCell((int) 1);
		
		sheet3_gubunCell2.setCellValue("정규 작업 처리 현황");
		
		// 구분 셀 병합
		sheet3.addMergedRegion(new CellRangeAddress(sheet3_row_count,  sheet3_row_count, 1,  9));
		
		// 구분 셀에 스타일 적용
		style	= wb.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setFillForegroundColor(IndexedColors.PALE_BLUE.index);
		style.setFillPattern(XSSFCellStyle.SOLID_FOREGROUND);
		sheet3_gubunCell2.setCellStyle(style);
		
		// 타이틀 로우 생성
		XSSFRow sheet3_titleRow2 	= sheet3.createRow((int) sheet3_row_count + 1);
		sheet3_row_count++;
		
		// 타이틀 셀에 스타일 적용
		style	= wb.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.index);
		style.setFillPattern(XSSFCellStyle.SOLID_FOREGROUND);
		style.setBorderRight(XSSFCellStyle.BORDER_THIN);
		style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
		style.setBorderTop(XSSFCellStyle.BORDER_THIN);
		style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
		
		// 타이틀 로우에 셀 생성 
		XSSFCell sheet3_titleCell2	= sheet3_titleRow2.createCell((int) 1);
		sheet3_titleCell2.setCellValue("No");
		sheet3_titleCell2.setCellStyle(style);
		
		sheet3_titleCell2			= sheet3_titleRow2.createCell((int) 2);
		sheet3_titleCell2.setCellValue("ODATE");
		sheet3_titleCell2.setCellStyle(style);
		
		sheet3_titleCell2			= sheet3_titleRow2.createCell((int) 3);
		sheet3_titleCell2.setCellValue("수행건수");
		sheet3_titleCell2.setCellStyle(style);
		
		sheet3_titleCell2			= sheet3_titleRow2.createCell((int) 4);
		sheet3_titleCell2.setCellValue("처리상태");
		sheet3_titleCell2.setCellStyle(style);
		
		sheet3_titleCell2			= sheet3_titleRow2.createCell((int) 5);
		sheet3_titleCell2.setCellValue("작업명");
		sheet3_titleCell2.setCellStyle(style);
		
		sheet3_titleCell2			= sheet3_titleRow2.createCell((int) 6);
		sheet3_titleCell2.setCellValue("시작시간");
		sheet3_titleCell2.setCellStyle(style);
		
		sheet3_titleCell2			= sheet3_titleRow2.createCell((int) 7);
		sheet3_titleCell2.setCellValue("종료시간");
		sheet3_titleCell2.setCellStyle(style);
		
		sheet3_titleCell2			= sheet3_titleRow2.createCell((int) 8);
		sheet3_titleCell2.setCellValue("수행시간");
		sheet3_titleCell2.setCellStyle(style);
		
		sheet3_titleCell2			= sheet3_titleRow2.createCell((int) 9);
		sheet3_titleCell2.setCellValue("작업설명");
		sheet3_titleCell2.setCellStyle(style);
		
		for( int i=0; null!=jobOpReportEdwList2 && i<jobOpReportEdwList2.size(); i++ ){
			JobLogBean bean = (JobLogBean)jobOpReportEdwList2.get(i);
			
			String strOdate 		= CommonUtil.isNull(bean.getOdate());
			String strJobName 		= CommonUtil.isNull(bean.getJob_name());
			String strOrderTable 	= CommonUtil.isNull(bean.getOrder_table());
			String strApplication 	= CommonUtil.isNull(bean.getApplication());
			String strGroupName 	= CommonUtil.isNull(bean.getGroup_name());
			String strStateResult 	= CommonUtil.isNull(bean.getState_result());
			String strStatus 		= CommonUtil.isNull(bean.getStatus());
			String strStartTime 	= CommonUtil.isNull(CommonUtil.getDateFormat(1,bean.getStart_time(),"-"));
			String strEndTime 		= CommonUtil.isNull(CommonUtil.getDateFormat(1,bean.getEnd_time(),"-"));
			String strRunTime 		= CommonUtil.getDiffTime( CommonUtil.getDateFormat(1,bean.getStart_time()),CommonUtil.getDateFormat(1,bean.getEnd_time()));
			String strDescription	= CommonUtil.isNull(bean.getDescription());
			String strRerunCounter	= CommonUtil.isNull(bean.getRerun_counter());
			
			String strStatusMent = "";
			if ( strStatus.equals("Ended OK") ) {
				strStatusMent = "완료";
			} else if ( strStatus.equals("Ended Not OK") ) {
				strStatusMent = "오류";
			} else if ( strStatus.indexOf("Wait") > -1 ) {
				strStatusMent = "미완료";
			} else if ( !strStatus.equals("Ended OK") && !strStatus.equals("Ended Not OK") && strStatus.indexOf("Wait") == -1 ) {
				strStatusMent = "기타";
			}
			
			XSSFRow sheet3_listRow2 = sheet3.createRow((int) sheet3_row_count + 1);
			sheet3_row_count++;
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			XSSFCell sheet3_listCell2	= sheet3_listRow2.createCell((int) 1);
			sheet3_listCell2.setCellValue((i+1));
			sheet3_listCell2.setCellStyle(style);
			
			sheet3_listCell2	= sheet3_listRow2.createCell((int) 2);
			sheet3_listCell2.setCellValue(strOdate);
			sheet3_listCell2.setCellStyle(style);
			
			sheet3_listCell2	= sheet3_listRow2.createCell((int) 3);
			sheet3_listCell2.setCellValue(strRerunCounter);
			sheet3_listCell2.setCellStyle(style);
			
			sheet3_listCell2	= sheet3_listRow2.createCell((int) 4);
			sheet3_listCell2.setCellValue(strStatusMent);
			sheet3_listCell2.setCellStyle(style);
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			sheet3_listCell2	= sheet3_listRow2.createCell((int) 5);
			sheet3_listCell2.setCellValue(" " + strJobName);			
			sheet3_listCell2.setCellStyle(style);
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			sheet3_listCell2	= sheet3_listRow2.createCell((int) 6);
			sheet3_listCell2.setCellValue(strStartTime);
			sheet3_listCell2.setCellStyle(style);
			
			sheet3_listCell2	= sheet3_listRow2.createCell((int) 7);
			sheet3_listCell2.setCellValue(strEndTime);
			sheet3_listCell2.setCellStyle(style);
			
			sheet3_listCell2	= sheet3_listRow2.createCell((int) 8);
			sheet3_listCell2.setCellValue(strRunTime);
			sheet3_listCell2.setCellStyle(style);
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			sheet3_listCell2	= sheet3_listRow2.createCell((int) 9);
			sheet3_listCell2.setCellValue(" " + strDescription);			
			sheet3_listCell2.setCellStyle(style);
		}
		
		// 한줄 띄우기
		sheet3.createRow((int) sheet3_row_count + 1);
		sheet3_row_count++;
		
		// 한줄 띄우기
		sheet3.createRow((int) sheet3_row_count + 1);
		sheet3_row_count++;
		
		// 구분 로우 생성
		XSSFRow sheet3_gubunRow3 	= sheet3.createRow((int) sheet3_row_count + 1);
		sheet3_row_count++;
		
		// 구분 로우에 셀 생성
		XSSFCell sheet3_gubunCell3	= sheet3_gubunRow3.createCell((int) 1);
		
		//sheet3_gubunCell3.setCellValue("정규 작업 처리 현황");
		sheet3_gubunCell3.setCellValue("월초 작업 처리 현황");
		
		// 구분 셀 병합
		sheet3.addMergedRegion(new CellRangeAddress(sheet3_row_count,  sheet3_row_count, 1,  9));
		
		// 구분 셀에 스타일 적용
		style	= wb.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setFillForegroundColor(IndexedColors.PALE_BLUE.index);
		style.setFillPattern(XSSFCellStyle.SOLID_FOREGROUND);
		sheet3_gubunCell3.setCellStyle(style);
		
		// 타이틀 로우 생성
		XSSFRow sheet3_titleRow3 	= sheet3.createRow((int) sheet3_row_count + 1);
		sheet3_row_count++;
		
		// 타이틀 셀에 스타일 적용
		style	= wb.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.index);
		style.setFillPattern(XSSFCellStyle.SOLID_FOREGROUND);
		style.setBorderRight(XSSFCellStyle.BORDER_THIN);
		style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
		style.setBorderTop(XSSFCellStyle.BORDER_THIN);
		style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
		
		// 타이틀 로우에 셀 생성 
		XSSFCell sheet3_titleCell3	= sheet3_titleRow3.createCell((int) 1);
		sheet3_titleCell3.setCellValue("No");
		sheet3_titleCell3.setCellStyle(style);
		
		sheet3_titleCell3			= sheet3_titleRow3.createCell((int) 2);
		sheet3_titleCell3.setCellValue("ODATE");
		sheet3_titleCell3.setCellStyle(style);
		
		sheet3_titleCell3			= sheet3_titleRow3.createCell((int) 3);
		sheet3_titleCell3.setCellValue("수행건수");
		sheet3_titleCell3.setCellStyle(style);
		
		sheet3_titleCell3			= sheet3_titleRow3.createCell((int) 4);
		sheet3_titleCell3.setCellValue("처리상태");
		sheet3_titleCell3.setCellStyle(style);
		
		sheet3_titleCell3			= sheet3_titleRow3.createCell((int) 5);
		sheet3_titleCell3.setCellValue("작업명");
		sheet3_titleCell3.setCellStyle(style);
		
		sheet3_titleCell3			= sheet3_titleRow3.createCell((int) 6);
		sheet3_titleCell3.setCellValue("시작시간");
		sheet3_titleCell3.setCellStyle(style);
		
		sheet3_titleCell3			= sheet3_titleRow3.createCell((int) 7);
		sheet3_titleCell3.setCellValue("종료시간");
		sheet3_titleCell3.setCellStyle(style);
		
		sheet3_titleCell3			= sheet3_titleRow3.createCell((int) 8);
		sheet3_titleCell3.setCellValue("수행시간");
		sheet3_titleCell3.setCellStyle(style);
		
		sheet3_titleCell3			= sheet3_titleRow3.createCell((int) 9);
		sheet3_titleCell3.setCellValue("작업설명");
		sheet3_titleCell3.setCellStyle(style);
		
		for( int i=0; null!=jobOpReportEdwList3 && i<jobOpReportEdwList3.size(); i++ ){
			JobLogBean bean = (JobLogBean)jobOpReportEdwList3.get(i);
			
			String strOdate 		= CommonUtil.isNull(bean.getOdate());
			String strJobName 		= CommonUtil.isNull(bean.getJob_name());
			String strOrderTable 	= CommonUtil.isNull(bean.getOrder_table());
			String strApplication 	= CommonUtil.isNull(bean.getApplication());
			String strGroupName 	= CommonUtil.isNull(bean.getGroup_name());
			String strStateResult 	= CommonUtil.isNull(bean.getState_result());
			String strStatus 		= CommonUtil.isNull(bean.getStatus());
			String strStartTime 	= CommonUtil.isNull(CommonUtil.getDateFormat(1,bean.getStart_time(),"-"));
			String strEndTime 		= CommonUtil.isNull(CommonUtil.getDateFormat(1,bean.getEnd_time(),"-"));
			String strRunTime 		= CommonUtil.getDiffTime( CommonUtil.getDateFormat(1,bean.getStart_time()),CommonUtil.getDateFormat(1,bean.getEnd_time()));
			String strDescription	= CommonUtil.isNull(bean.getDescription());
			String strRerunCounter	= CommonUtil.isNull(bean.getRerun_counter());
			
			String strStatusMent = "";
			if ( strStatus.equals("Ended OK") ) {
				strStatusMent = "완료";
			} else if ( strStatus.equals("Ended Not OK") ) {
				strStatusMent = "오류";
			} else if ( strStatus.indexOf("Wait") > -1 ) {
				strStatusMent = "미완료";
			} else if ( !strStatus.equals("Ended OK") && !strStatus.equals("Ended Not OK") && strStatus.indexOf("Wait") == -1 ) {
				strStatusMent = "기타";
			}
			
			XSSFRow sheet3_listRow2 = sheet3.createRow((int) sheet3_row_count + 1);
			sheet3_row_count++;
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			XSSFCell sheet3_listCell2	= sheet3_listRow2.createCell((int) 1);
			sheet3_listCell2.setCellValue((i+1));
			sheet3_listCell2.setCellStyle(style);
			
			sheet3_listCell2	= sheet3_listRow2.createCell((int) 2);
			sheet3_listCell2.setCellValue(strOdate);
			sheet3_listCell2.setCellStyle(style);
			
			sheet3_listCell2	= sheet3_listRow2.createCell((int) 3);
			sheet3_listCell2.setCellValue(strRerunCounter);
			sheet3_listCell2.setCellStyle(style);
			
			sheet3_listCell2	= sheet3_listRow2.createCell((int) 4);
			sheet3_listCell2.setCellValue(strStatusMent);
			sheet3_listCell2.setCellStyle(style);
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			sheet3_listCell2	= sheet3_listRow2.createCell((int) 5);
			sheet3_listCell2.setCellValue(" " + strJobName);			
			sheet3_listCell2.setCellStyle(style);
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			sheet3_listCell2	= sheet3_listRow2.createCell((int) 6);
			sheet3_listCell2.setCellValue(strStartTime);
			sheet3_listCell2.setCellStyle(style);
			
			sheet3_listCell2	= sheet3_listRow2.createCell((int) 7);
			sheet3_listCell2.setCellValue(strEndTime);
			sheet3_listCell2.setCellStyle(style);
			
			sheet3_listCell2	= sheet3_listRow2.createCell((int) 8);
			sheet3_listCell2.setCellValue(strRunTime);
			sheet3_listCell2.setCellStyle(style);
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			sheet3_listCell2	= sheet3_listRow2.createCell((int) 9);
			sheet3_listCell2.setCellValue(" " + strDescription);			
			sheet3_listCell2.setCellStyle(style);
		}
		
		// 한줄 띄우기
		sheet3.createRow((int) sheet3_row_count + 1);
		sheet3_row_count++;
		
		// 한줄 띄우기
		sheet3.createRow((int) sheet3_row_count + 1);
		sheet3_row_count++;
		
		// 구분 로우 생성
		XSSFRow sheet3_gubunRow4 	= sheet3.createRow((int) sheet3_row_count + 1);
		sheet3_row_count++;
		
		// 구분 로우에 셀 생성
		XSSFCell sheet3_gubunCell4	= sheet3_gubunRow4.createCell((int) 1);
		
		//sheet3_gubunCell4.setCellValue("정규 작업 처리 현황");
		sheet3_gubunCell4.setCellValue("월말 작업 처리 현황");
		
		// 구분 셀 병합
		sheet3.addMergedRegion(new CellRangeAddress(sheet3_row_count,  sheet3_row_count, 1,  9));
		
		// 구분 셀에 스타일 적용
		style	= wb.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setFillForegroundColor(IndexedColors.PALE_BLUE.index);
		style.setFillPattern(XSSFCellStyle.SOLID_FOREGROUND);
		sheet3_gubunCell4.setCellStyle(style);
		
		// 타이틀 로우 생성
		XSSFRow sheet3_titleRow4 	= sheet3.createRow((int) sheet3_row_count + 1);
		sheet3_row_count++;
		
		// 타이틀 셀에 스타일 적용
		style	= wb.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.index);
		style.setFillPattern(XSSFCellStyle.SOLID_FOREGROUND);
		style.setBorderRight(XSSFCellStyle.BORDER_THIN);
		style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
		style.setBorderTop(XSSFCellStyle.BORDER_THIN);
		style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
		
		// 타이틀 로우에 셀 생성 
		XSSFCell sheet3_titleCell4	= sheet3_titleRow4.createCell((int) 1);
		sheet3_titleCell4.setCellValue("No");
		sheet3_titleCell4.setCellStyle(style);
		
		sheet3_titleCell4			= sheet3_titleRow4.createCell((int) 2);
		sheet3_titleCell4.setCellValue("ODATE");
		sheet3_titleCell4.setCellStyle(style);
		
		sheet3_titleCell4			= sheet3_titleRow4.createCell((int) 3);
		sheet3_titleCell4.setCellValue("수행건수");
		sheet3_titleCell4.setCellStyle(style);
		
		sheet3_titleCell4			= sheet3_titleRow4.createCell((int) 4);
		sheet3_titleCell4.setCellValue("처리상태");
		sheet3_titleCell4.setCellStyle(style);
		
		sheet3_titleCell4			= sheet3_titleRow4.createCell((int) 5);
		sheet3_titleCell4.setCellValue("작업명");
		sheet3_titleCell4.setCellStyle(style);
		
		sheet3_titleCell4			= sheet3_titleRow4.createCell((int) 6);
		sheet3_titleCell4.setCellValue("시작시간");
		sheet3_titleCell4.setCellStyle(style);
		
		sheet3_titleCell4			= sheet3_titleRow4.createCell((int) 7);
		sheet3_titleCell4.setCellValue("종료시간");
		sheet3_titleCell4.setCellStyle(style);
		
		sheet3_titleCell4			= sheet3_titleRow4.createCell((int) 8);
		sheet3_titleCell4.setCellValue("수행시간");
		sheet3_titleCell4.setCellStyle(style);
		
		sheet3_titleCell4			= sheet3_titleRow4.createCell((int) 9);
		sheet3_titleCell4.setCellValue("작업설명");
		sheet3_titleCell4.setCellStyle(style);
		
		for( int i=0; null!=jobOpReportEdwList4 && i<jobOpReportEdwList4.size(); i++ ){
			JobLogBean bean = (JobLogBean)jobOpReportEdwList4.get(i);
			
			String strOdate 		= CommonUtil.isNull(bean.getOdate());
			String strJobName 		= CommonUtil.isNull(bean.getJob_name());
			String strOrderTable 	= CommonUtil.isNull(bean.getOrder_table());
			String strApplication 	= CommonUtil.isNull(bean.getApplication());
			String strGroupName 	= CommonUtil.isNull(bean.getGroup_name());
			String strStateResult 	= CommonUtil.isNull(bean.getState_result());
			String strStatus 		= CommonUtil.isNull(bean.getStatus());
			String strStartTime 	= CommonUtil.isNull(CommonUtil.getDateFormat(1,bean.getStart_time(),"-"));
			String strEndTime 		= CommonUtil.isNull(CommonUtil.getDateFormat(1,bean.getEnd_time(),"-"));
			String strRunTime 		= CommonUtil.getDiffTime( CommonUtil.getDateFormat(1,bean.getStart_time()),CommonUtil.getDateFormat(1,bean.getEnd_time()));
			String strDescription	= CommonUtil.isNull(bean.getDescription());
			String strRerunCounter	= CommonUtil.isNull(bean.getRerun_counter());
			
			String strStatusMent = "";
			if ( strStatus.equals("Ended OK") ) {
				strStatusMent = "완료";
			} else if ( strStatus.equals("Ended Not OK") ) {
				strStatusMent = "오류";
			} else if ( strStatus.indexOf("Wait") > -1 ) {
				strStatusMent = "미완료";
			} else if ( !strStatus.equals("Ended OK") && !strStatus.equals("Ended Not OK") && strStatus.indexOf("Wait") == -1 ) {
				strStatusMent = "기타";
			}
			
			XSSFRow sheet3_listRow2 = sheet3.createRow((int) sheet3_row_count + 1);
			sheet3_row_count++;
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			XSSFCell sheet3_listCell2	= sheet3_listRow2.createCell((int) 1);
			sheet3_listCell2.setCellValue((i+1));
			sheet3_listCell2.setCellStyle(style);
			
			sheet3_listCell2	= sheet3_listRow2.createCell((int) 2);
			sheet3_listCell2.setCellValue(strOdate);
			sheet3_listCell2.setCellStyle(style);
			
			sheet3_listCell2	= sheet3_listRow2.createCell((int) 3);
			sheet3_listCell2.setCellValue(strRerunCounter);
			sheet3_listCell2.setCellStyle(style);
			
			sheet3_listCell2	= sheet3_listRow2.createCell((int) 4);
			sheet3_listCell2.setCellValue(strStatusMent);
			sheet3_listCell2.setCellStyle(style);
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			sheet3_listCell2	= sheet3_listRow2.createCell((int) 5);
			sheet3_listCell2.setCellValue(" " + strJobName);			
			sheet3_listCell2.setCellStyle(style);
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			sheet3_listCell2	= sheet3_listRow2.createCell((int) 6);
			sheet3_listCell2.setCellValue(strStartTime);
			sheet3_listCell2.setCellStyle(style);
			
			sheet3_listCell2	= sheet3_listRow2.createCell((int) 7);
			sheet3_listCell2.setCellValue(strEndTime);
			sheet3_listCell2.setCellStyle(style);
			
			sheet3_listCell2	= sheet3_listRow2.createCell((int) 8);
			sheet3_listCell2.setCellValue(strRunTime);
			sheet3_listCell2.setCellStyle(style);
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			sheet3_listCell2	= sheet3_listRow2.createCell((int) 9);
			sheet3_listCell2.setCellValue(" " + strDescription);			
			sheet3_listCell2.setCellStyle(style);
		}
		
		sheet3.setColumnWidth(0, (int)0x200);
		
		for(int i=1; i<=10; i++){
			sheet3.autoSizeColumn(i);
			sheet3.setColumnWidth(i, sheet3.getColumnWidth(i)+700 );
		}
		
		// 시트 생성
		XSSFSheet sheet4 	= wb.createSheet("IFRS");
		
		int sheet4_row_count = 0;
		
		// 문서 제목 로우 생성
		XSSFRow sheet4_nameRow 	= sheet4.createRow((int) sheet4_row_count + 1);
		sheet4_row_count++;
		
		// 문서 제목 로우에 셀 생성
		XSSFCell sheet4_cell	= sheet4_nameRow.createCell((int) 1);
		
		sheet4_cell.setCellValue("<IFRS 작업 처리 현황 " + s_search_odate + " ~  " + e_search_odate + ">");
		
		// 문서 제목 셀에 스타일 적용
		style	= wb.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		sheet4_cell.setCellStyle(style);
		
		// 문서 제목 셀 병합
		sheet4.addMergedRegion(new CellRangeAddress(1,  1, 1,  9));
		
		// 한줄 띄우기
		sheet4.createRow((int) sheet4_row_count + 1);
		sheet4_row_count++;
		
		// 구분 로우 생성
		XSSFRow sheet4_gubunRow 	= sheet4.createRow((int) sheet4_row_count + 1);
		sheet4_row_count++;
		
		// 구분 로우에 셀 생성
		XSSFCell sheet4_gubunCell	= sheet4_gubunRow.createCell((int) 1);
		
		sheet4_gubunCell.setCellValue("작업 의뢰서 처리 현황");
		
		// 구분 셀 병합
		sheet4.addMergedRegion(new CellRangeAddress(3,  3, 1,  9));
		
		// 구분 셀에 스타일 적용
		style	= wb.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setFillForegroundColor(IndexedColors.BRIGHT_GREEN.index);
		style.setFillPattern(XSSFCellStyle.SOLID_FOREGROUND);
		sheet4_gubunCell.setCellStyle(style);
		
		// 타이틀 로우 생성
		XSSFRow sheet4_titleRow 	= sheet4.createRow((int) sheet4_row_count + 1);
		sheet4_row_count++;
		
		// 타이틀 셀에 스타일 적용
		style	= wb.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.index);
		style.setFillPattern(XSSFCellStyle.SOLID_FOREGROUND);
		style.setBorderRight(XSSFCellStyle.BORDER_THIN);
		style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
		style.setBorderTop(XSSFCellStyle.BORDER_THIN);
		style.setBorderBottom(XSSFCellStyle.BORDER_THIN);		
		
		// 타이틀 로우에 셀 생성 
		XSSFCell sheet4_titleCell	= sheet4_titleRow.createCell((int) 1);
		sheet4_titleCell.setCellValue("No");
		sheet4_titleCell.setCellStyle(style);
		
		sheet4_titleCell			= sheet4_titleRow.createCell((int) 2);
		sheet4_titleCell.setCellValue("ODATE");
		sheet4_titleCell.setCellStyle(style);
		
		sheet4_titleCell			= sheet4_titleRow.createCell((int) 3);
		sheet4_titleCell.setCellValue("수행건수");
		sheet4_titleCell.setCellStyle(style);
		
		sheet4_titleCell			= sheet4_titleRow.createCell((int) 4);
		sheet4_titleCell.setCellValue("처리상태");
		sheet4_titleCell.setCellStyle(style);
		
		sheet4_titleCell			= sheet4_titleRow.createCell((int) 5);
		sheet4_titleCell.setCellValue("작업명");
		sheet4_titleCell.setCellStyle(style);
		
		sheet4_titleCell			= sheet4_titleRow.createCell((int) 6);
		sheet4_titleCell.setCellValue("시작시간");
		sheet4_titleCell.setCellStyle(style);
		
		sheet4_titleCell			= sheet4_titleRow.createCell((int) 7);
		sheet4_titleCell.setCellValue("종료시간");
		sheet4_titleCell.setCellStyle(style);
		
		sheet4_titleCell			= sheet4_titleRow.createCell((int) 8);
		sheet4_titleCell.setCellValue("수행시간");
		sheet4_titleCell.setCellStyle(style);
		
		sheet4_titleCell			= sheet4_titleRow.createCell((int) 9);
		sheet4_titleCell.setCellValue("작업설명");
		sheet4_titleCell.setCellStyle(style);
		
		
		for( int i=0; null!=jobOpReportIfrsList && i<jobOpReportIfrsList.size(); i++ ){
			JobLogBean bean = (JobLogBean)jobOpReportIfrsList.get(i);
			
			String strOdate 		= CommonUtil.isNull(bean.getOdate());
			String strJobName 		= CommonUtil.isNull(bean.getJob_name());
			String strOrderTable 	= CommonUtil.isNull(bean.getOrder_table());
			String strApplication 	= CommonUtil.isNull(bean.getApplication());
			String strGroupName 	= CommonUtil.isNull(bean.getGroup_name());
			String strStateResult 	= CommonUtil.isNull(bean.getState_result());
			String strStatus 		= CommonUtil.isNull(bean.getStatus());
			String strStartTime 	= CommonUtil.isNull(CommonUtil.getDateFormat(1,bean.getStart_time(),"-"));
			String strEndTime 		= CommonUtil.isNull(CommonUtil.getDateFormat(1,bean.getEnd_time(),"-;"));
			String strRunTime 		= CommonUtil.getDiffTime( CommonUtil.getDateFormat(1,bean.getStart_time()),CommonUtil.getDateFormat(1,bean.getEnd_time()));
			String strDescription	= CommonUtil.isNull(bean.getDescription());
			String strRerunCounter	= CommonUtil.isNull(bean.getRerun_counter());
			
			String strStatusMent = "";
			if ( strStatus.equals("Ended OK") ) {
				strStatusMent = "완료";
			} else if ( strStatus.equals("Ended Not OK") ) {
				strStatusMent = "오류";
			} else if ( strStatus.indexOf("Wait") > -1 ) {
				strStatusMent = "미완료";
			} else if ( !strStatus.equals("Ended OK") && !strStatus.equals("Ended Not OK") && strStatus.indexOf("Wait") == -1 ) {
				strStatusMent = "기타";
			}
			
			XSSFRow sheet4_listRow = sheet4.createRow((int) sheet4_row_count + 1);
			sheet4_row_count++;
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			XSSFCell sheet4_listCell2	= sheet4_listRow.createCell((int) 1);
			sheet4_listCell2.setCellValue((i+1));
			sheet4_listCell2.setCellStyle(style);
			
			sheet4_listCell2	= sheet4_listRow.createCell((int) 2);
			sheet4_listCell2.setCellValue(strOdate);
			sheet4_listCell2.setCellStyle(style);
			
			sheet4_listCell2	= sheet4_listRow.createCell((int) 3);
			sheet4_listCell2.setCellValue(strRerunCounter);
			sheet4_listCell2.setCellStyle(style);
			
			sheet4_listCell2	= sheet4_listRow.createCell((int) 4);
			sheet4_listCell2.setCellValue(strStatusMent);
			sheet4_listCell2.setCellStyle(style);
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			sheet4_listCell2	= sheet4_listRow.createCell((int) 5);
			sheet4_listCell2.setCellValue(" " + strJobName);			
			sheet4_listCell2.setCellStyle(style);
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			sheet4_listCell2	= sheet4_listRow.createCell((int) 6);
			sheet4_listCell2.setCellValue(strStartTime);
			sheet4_listCell2.setCellStyle(style);
			
			sheet4_listCell2	= sheet4_listRow.createCell((int) 7);
			sheet4_listCell2.setCellValue(strEndTime);
			sheet4_listCell2.setCellStyle(style);
			
			sheet4_listCell2	= sheet4_listRow.createCell((int) 8);
			sheet4_listCell2.setCellValue(strRunTime);
			sheet4_listCell2.setCellStyle(style);
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			sheet4_listCell2	= sheet4_listRow.createCell((int) 9);
			sheet4_listCell2.setCellValue(" " + strDescription);			
			sheet4_listCell2.setCellStyle(style);
		}

		// 한줄 띄우기
		sheet4.createRow((int) sheet4_row_count + 1);
		sheet4_row_count++;
		
		// 한줄 띄우기
		sheet4.createRow((int) sheet4_row_count + 1);
		sheet4_row_count++;
		
		// 구분 로우 생성
		XSSFRow sheet4_gubunRow2 	= sheet4.createRow((int) sheet4_row_count + 1);
		sheet4_row_count++;
		
		// 구분 로우에 셀 생성
		XSSFCell sheet4_gubunCell2	= sheet4_gubunRow2.createCell((int) 1);
		
		sheet4_gubunCell2.setCellValue("정규 작업 처리 현황");
		
		// 구분 셀 병합
		sheet4.addMergedRegion(new CellRangeAddress(sheet4_row_count,  sheet4_row_count, 1,  9));
		
		// 구분 셀에 스타일 적용
		style	= wb.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setFillForegroundColor(IndexedColors.BRIGHT_GREEN.index);
		style.setFillPattern(XSSFCellStyle.SOLID_FOREGROUND);
		sheet4_gubunCell2.setCellStyle(style);
		
		// 타이틀 로우 생성
		XSSFRow sheet4_titleRow2 	= sheet4.createRow((int) sheet4_row_count + 1);
		sheet4_row_count++;
		
		// 타이틀 셀에 스타일 적용
		style	= wb.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.index);
		style.setFillPattern(XSSFCellStyle.SOLID_FOREGROUND);
		style.setBorderRight(XSSFCellStyle.BORDER_THIN);
		style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
		style.setBorderTop(XSSFCellStyle.BORDER_THIN);
		style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
		
		// 타이틀 로우에 셀 생성 
		XSSFCell sheet4_titleCell2	= sheet4_titleRow2.createCell((int) 1);
		sheet4_titleCell2.setCellValue("No");
		sheet4_titleCell2.setCellStyle(style);
		
		sheet4_titleCell2			= sheet4_titleRow2.createCell((int) 2);
		sheet4_titleCell2.setCellValue("ODATE");
		sheet4_titleCell2.setCellStyle(style);
		
		sheet4_titleCell2			= sheet4_titleRow2.createCell((int) 3);
		sheet4_titleCell2.setCellValue("수행건수");
		sheet4_titleCell2.setCellStyle(style);
		
		sheet4_titleCell2			= sheet4_titleRow2.createCell((int) 4);
		sheet4_titleCell2.setCellValue("처리상태");
		sheet4_titleCell2.setCellStyle(style);
		
		sheet4_titleCell2			= sheet4_titleRow2.createCell((int) 5);
		sheet4_titleCell2.setCellValue("작업명");
		sheet4_titleCell2.setCellStyle(style);
		
		sheet4_titleCell2			= sheet4_titleRow2.createCell((int) 6);
		sheet4_titleCell2.setCellValue("시작시간");
		sheet4_titleCell2.setCellStyle(style);
		
		sheet4_titleCell2			= sheet4_titleRow2.createCell((int) 7);
		sheet4_titleCell2.setCellValue("종료시간");
		sheet4_titleCell2.setCellStyle(style);
		
		sheet4_titleCell2			= sheet4_titleRow2.createCell((int) 8);
		sheet4_titleCell2.setCellValue("수행시간");
		sheet4_titleCell2.setCellStyle(style);
		
		sheet4_titleCell2			= sheet4_titleRow2.createCell((int) 9);
		sheet4_titleCell2.setCellValue("작업설명");
		sheet4_titleCell2.setCellStyle(style);
		
		for( int i=0; null!=jobOpReportIfrsList2 && i<jobOpReportIfrsList2.size(); i++ ){
			JobLogBean bean = (JobLogBean)jobOpReportIfrsList2.get(i);
			
			String strOdate 		= CommonUtil.isNull(bean.getOdate());
			String strJobName 		= CommonUtil.isNull(bean.getJob_name());
			String strOrderTable 	= CommonUtil.isNull(bean.getOrder_table());
			String strApplication 	= CommonUtil.isNull(bean.getApplication());
			String strGroupName 	= CommonUtil.isNull(bean.getGroup_name());
			String strStateResult 	= CommonUtil.isNull(bean.getState_result());
			String strStatus 		= CommonUtil.isNull(bean.getStatus());
			String strStartTime 	= CommonUtil.isNull(CommonUtil.getDateFormat(1,bean.getStart_time(),"-"));
			String strEndTime 		= CommonUtil.isNull(CommonUtil.getDateFormat(1,bean.getEnd_time(),"-"));
			String strRunTime 		= CommonUtil.getDiffTime( CommonUtil.getDateFormat(1,bean.getStart_time()),CommonUtil.getDateFormat(1,bean.getEnd_time()));
			String strDescription	= CommonUtil.isNull(bean.getDescription());
			String strRerunCounter	= CommonUtil.isNull(bean.getRerun_counter());
			
			String strStatusMent = "";
			if ( strStatus.equals("Ended OK") ) {
				strStatusMent = "완료";
			} else if ( strStatus.equals("Ended Not OK") ) {
				strStatusMent = "오류";
			} else if ( strStatus.indexOf("Wait") > -1 ) {
				strStatusMent = "미완료";
			} else if ( !strStatus.equals("Ended OK") && !strStatus.equals("Ended Not OK") && strStatus.indexOf("Wait") == -1 ) {
				strStatusMent = "기타";
			}
			
			XSSFRow sheet4_listRow2 = sheet4.createRow((int) sheet4_row_count + 1);
			sheet4_row_count++;
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			XSSFCell sheet4_listCell2	= sheet4_listRow2.createCell((int) 1);
			sheet4_listCell2.setCellValue((i+1));
			sheet4_listCell2.setCellStyle(style);
			
			sheet4_listCell2	= sheet4_listRow2.createCell((int) 2);
			sheet4_listCell2.setCellValue(strOdate);
			sheet4_listCell2.setCellStyle(style);
			
			sheet4_listCell2	= sheet4_listRow2.createCell((int) 3);
			sheet4_listCell2.setCellValue(strRerunCounter);
			sheet4_listCell2.setCellStyle(style);
			
			sheet4_listCell2	= sheet4_listRow2.createCell((int) 4);
			sheet4_listCell2.setCellValue(strStatusMent);
			sheet4_listCell2.setCellStyle(style);
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			sheet4_listCell2	= sheet4_listRow2.createCell((int) 5);
			sheet4_listCell2.setCellValue(" " + strJobName);			
			sheet4_listCell2.setCellStyle(style);
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			sheet4_listCell2	= sheet4_listRow2.createCell((int) 6);
			sheet4_listCell2.setCellValue(strStartTime);
			sheet4_listCell2.setCellStyle(style);
			
			sheet4_listCell2	= sheet4_listRow2.createCell((int) 7);
			sheet4_listCell2.setCellValue(strEndTime);
			sheet4_listCell2.setCellStyle(style);
			
			sheet4_listCell2	= sheet4_listRow2.createCell((int) 8);
			sheet4_listCell2.setCellValue(strRunTime);
			sheet4_listCell2.setCellStyle(style);
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			sheet4_listCell2	= sheet4_listRow2.createCell((int) 9);
			sheet4_listCell2.setCellValue(" " + strDescription);			
			sheet4_listCell2.setCellStyle(style);
		}
		
		// 한줄 띄우기
		sheet4.createRow((int) sheet4_row_count + 1);
		sheet4_row_count++;
		
		// 한줄 띄우기
		sheet4.createRow((int) sheet4_row_count + 1);
		sheet4_row_count++;
		
		// 구분 로우 생성
		XSSFRow sheet4_gubunRow3 	= sheet4.createRow((int) sheet4_row_count + 1);
		sheet4_row_count++;
		
		// 구분 로우에 셀 생성
		XSSFCell sheet4_gubunCell3	= sheet4_gubunRow3.createCell((int) 1);
		
		//sheet4_gubunCell3.setCellValue("정규 작업 처리 현황");
		sheet4_gubunCell3.setCellValue("월초 작업 처리 현황");
		
		// 구분 셀 병합
		sheet4.addMergedRegion(new CellRangeAddress(sheet4_row_count,  sheet4_row_count, 1,  9));
		
		// 구분 셀에 스타일 적용
		style	= wb.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setFillForegroundColor(IndexedColors.BRIGHT_GREEN.index);
		style.setFillPattern(XSSFCellStyle.SOLID_FOREGROUND);
		sheet4_gubunCell3.setCellStyle(style);
		
		// 타이틀 로우 생성
		XSSFRow sheet4_titleRow3 	= sheet4.createRow((int) sheet4_row_count + 1);
		sheet4_row_count++;
		
		// 타이틀 셀에 스타일 적용
		style	= wb.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.index);
		style.setFillPattern(XSSFCellStyle.SOLID_FOREGROUND);
		style.setBorderRight(XSSFCellStyle.BORDER_THIN);
		style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
		style.setBorderTop(XSSFCellStyle.BORDER_THIN);
		style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
		
		// 타이틀 로우에 셀 생성 
		XSSFCell sheet4_titleCell3	= sheet4_titleRow3.createCell((int) 1);
		sheet4_titleCell3.setCellValue("No");
		sheet4_titleCell3.setCellStyle(style);
		
		sheet4_titleCell3			= sheet4_titleRow3.createCell((int) 2);
		sheet4_titleCell3.setCellValue("ODATE");
		sheet4_titleCell3.setCellStyle(style);
		
		sheet4_titleCell3			= sheet4_titleRow3.createCell((int) 3);
		sheet4_titleCell3.setCellValue("수행건수");
		sheet4_titleCell3.setCellStyle(style);
		
		sheet4_titleCell3			= sheet4_titleRow3.createCell((int) 4);
		sheet4_titleCell3.setCellValue("처리상태");
		sheet4_titleCell3.setCellStyle(style);
		
		sheet4_titleCell3			= sheet4_titleRow3.createCell((int) 5);
		sheet4_titleCell3.setCellValue("작업명");
		sheet4_titleCell3.setCellStyle(style);
		
		sheet4_titleCell3			= sheet4_titleRow3.createCell((int) 6);
		sheet4_titleCell3.setCellValue("시작시간");
		sheet4_titleCell3.setCellStyle(style);
		
		sheet4_titleCell3			= sheet4_titleRow3.createCell((int) 7);
		sheet4_titleCell3.setCellValue("종료시간");
		sheet4_titleCell3.setCellStyle(style);
		
		sheet4_titleCell3			= sheet4_titleRow3.createCell((int) 8);
		sheet4_titleCell3.setCellValue("수행시간");
		sheet4_titleCell3.setCellStyle(style);
		
		sheet4_titleCell3			= sheet4_titleRow3.createCell((int) 9);
		sheet4_titleCell3.setCellValue("작업설명");
		sheet4_titleCell3.setCellStyle(style);
		
		for( int i=0; null!=jobOpReportIfrsList3 && i<jobOpReportIfrsList3.size(); i++ ){
			JobLogBean bean = (JobLogBean)jobOpReportIfrsList3.get(i);
			
			String strOdate 		= CommonUtil.isNull(bean.getOdate());
			String strJobName 		= CommonUtil.isNull(bean.getJob_name());
			String strOrderTable 	= CommonUtil.isNull(bean.getOrder_table());
			String strApplication 	= CommonUtil.isNull(bean.getApplication());
			String strGroupName 	= CommonUtil.isNull(bean.getGroup_name());
			String strStateResult 	= CommonUtil.isNull(bean.getState_result());
			String strStatus 		= CommonUtil.isNull(bean.getStatus());
			String strStartTime 	= CommonUtil.isNull(CommonUtil.getDateFormat(1,bean.getStart_time(),"-"));
			String strEndTime 		= CommonUtil.isNull(CommonUtil.getDateFormat(1,bean.getEnd_time(),"-"));
			String strRunTime 		= CommonUtil.getDiffTime( CommonUtil.getDateFormat(1,bean.getStart_time()),CommonUtil.getDateFormat(1,bean.getEnd_time()));
			String strDescription	= CommonUtil.isNull(bean.getDescription());
			String strRerunCounter	= CommonUtil.isNull(bean.getRerun_counter());
			
			String strStatusMent = "";
			if ( strStatus.equals("Ended OK") ) {
				strStatusMent = "완료";
			} else if ( strStatus.equals("Ended Not OK") ) {
				strStatusMent = "오류";
			} else if ( strStatus.indexOf("Wait") > -1 ) {
				strStatusMent = "미완료";
			} else if ( !strStatus.equals("Ended OK") && !strStatus.equals("Ended Not OK") && strStatus.indexOf("Wait") == -1 ) {
				strStatusMent = "기타";
			}
			
			XSSFRow sheet4_listRow2 = sheet4.createRow((int) sheet4_row_count + 1);
			sheet4_row_count++;
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			XSSFCell sheet4_listCell2	= sheet4_listRow2.createCell((int) 1);
			sheet4_listCell2.setCellValue((i+1));
			sheet4_listCell2.setCellStyle(style);
			
			sheet4_listCell2	= sheet4_listRow2.createCell((int) 2);
			sheet4_listCell2.setCellValue(strOdate);
			sheet4_listCell2.setCellStyle(style);
			
			sheet4_listCell2	= sheet4_listRow2.createCell((int) 3);
			sheet4_listCell2.setCellValue(strRerunCounter);
			sheet4_listCell2.setCellStyle(style);
			
			sheet4_listCell2	= sheet4_listRow2.createCell((int) 4);
			sheet4_listCell2.setCellValue(strStatusMent);
			sheet4_listCell2.setCellStyle(style);
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			sheet4_listCell2	= sheet4_listRow2.createCell((int) 5);
			sheet4_listCell2.setCellValue(" " + strJobName);			
			sheet4_listCell2.setCellStyle(style);
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			sheet4_listCell2	= sheet4_listRow2.createCell((int) 6);
			sheet4_listCell2.setCellValue(strStartTime);
			sheet4_listCell2.setCellStyle(style);
			
			sheet4_listCell2	= sheet4_listRow2.createCell((int) 7);
			sheet4_listCell2.setCellValue(strEndTime);
			sheet4_listCell2.setCellStyle(style);
			
			sheet4_listCell2	= sheet4_listRow2.createCell((int) 8);
			sheet4_listCell2.setCellValue(strRunTime);
			sheet4_listCell2.setCellStyle(style);
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			sheet4_listCell2	= sheet4_listRow2.createCell((int) 9);
			sheet4_listCell2.setCellValue(" " + strDescription);			
			sheet4_listCell2.setCellStyle(style);
		}
		
		// 한줄 띄우기
		sheet4.createRow((int) sheet4_row_count + 1);
		sheet4_row_count++;
		
		// 한줄 띄우기
		sheet4.createRow((int) sheet4_row_count + 1);
		sheet4_row_count++;
		
		// 구분 로우 생성
		XSSFRow sheet4_gubunRow4 	= sheet4.createRow((int) sheet4_row_count + 1);
		sheet4_row_count++;
		
		// 구분 로우에 셀 생성
		XSSFCell sheet4_gubunCell4	= sheet4_gubunRow4.createCell((int) 1);
		
		//sheet4_gubunCell4.setCellValue("정규 작업 처리 현황");
		sheet4_gubunCell4.setCellValue("월말 작업 처리 현황");
		
		// 구분 셀 병합
		sheet4.addMergedRegion(new CellRangeAddress(sheet4_row_count,  sheet4_row_count, 1,  9));
		
		// 구분 셀에 스타일 적용
		style	= wb.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setFillForegroundColor(IndexedColors.BRIGHT_GREEN.index);
		style.setFillPattern(XSSFCellStyle.SOLID_FOREGROUND);
		sheet4_gubunCell4.setCellStyle(style);
		
		// 타이틀 로우 생성
		XSSFRow sheet4_titleRow4 	= sheet4.createRow((int) sheet4_row_count + 1);
		sheet4_row_count++;
		
		// 타이틀 셀에 스타일 적용
		style	= wb.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.index);
		style.setFillPattern(XSSFCellStyle.SOLID_FOREGROUND);
		style.setBorderRight(XSSFCellStyle.BORDER_THIN);
		style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
		style.setBorderTop(XSSFCellStyle.BORDER_THIN);
		style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
		
		// 타이틀 로우에 셀 생성 
		XSSFCell sheet4_titleCell4	= sheet4_titleRow4.createCell((int) 1);
		sheet4_titleCell4.setCellValue("No");
		sheet4_titleCell4.setCellStyle(style);
		
		sheet4_titleCell4			= sheet4_titleRow4.createCell((int) 2);
		sheet4_titleCell4.setCellValue("ODATE");
		sheet4_titleCell4.setCellStyle(style);
		
		sheet4_titleCell4			= sheet4_titleRow4.createCell((int) 3);
		sheet4_titleCell4.setCellValue("수행건수");
		sheet4_titleCell4.setCellStyle(style);
		
		sheet4_titleCell4			= sheet4_titleRow4.createCell((int) 4);
		sheet4_titleCell4.setCellValue("처리상태");
		sheet4_titleCell4.setCellStyle(style);
		
		sheet4_titleCell4			= sheet4_titleRow4.createCell((int) 5);
		sheet4_titleCell4.setCellValue("작업명");
		sheet4_titleCell4.setCellStyle(style);
		
		sheet4_titleCell4			= sheet4_titleRow4.createCell((int) 6);
		sheet4_titleCell4.setCellValue("시작시간");
		sheet4_titleCell4.setCellStyle(style);
		
		sheet4_titleCell4			= sheet4_titleRow4.createCell((int) 7);
		sheet4_titleCell4.setCellValue("종료시간");
		sheet4_titleCell4.setCellStyle(style);
		
		sheet4_titleCell4			= sheet4_titleRow4.createCell((int) 8);
		sheet4_titleCell4.setCellValue("수행시간");
		sheet4_titleCell4.setCellStyle(style);
		
		sheet4_titleCell4			= sheet4_titleRow4.createCell((int) 9);
		sheet4_titleCell4.setCellValue("작업설명");
		sheet4_titleCell4.setCellStyle(style);
		
		for( int i=0; null!=jobOpReportIfrsList4 && i<jobOpReportIfrsList4.size(); i++ ){
			JobLogBean bean = (JobLogBean)jobOpReportIfrsList4.get(i);
			
			String strOdate 		= CommonUtil.isNull(bean.getOdate());
			String strJobName 		= CommonUtil.isNull(bean.getJob_name());
			String strOrderTable 	= CommonUtil.isNull(bean.getOrder_table());
			String strApplication 	= CommonUtil.isNull(bean.getApplication());
			String strGroupName 	= CommonUtil.isNull(bean.getGroup_name());
			String strStateResult 	= CommonUtil.isNull(bean.getState_result());
			String strStatus 		= CommonUtil.isNull(bean.getStatus());
			String strStartTime 	= CommonUtil.isNull(CommonUtil.getDateFormat(1,bean.getStart_time(),"-"));
			String strEndTime 		= CommonUtil.isNull(CommonUtil.getDateFormat(1,bean.getEnd_time(),"-"));
			String strRunTime 		= CommonUtil.getDiffTime( CommonUtil.getDateFormat(1,bean.getStart_time()),CommonUtil.getDateFormat(1,bean.getEnd_time()));
			String strDescription	= CommonUtil.isNull(bean.getDescription());
			String strRerunCounter	= CommonUtil.isNull(bean.getRerun_counter());
			
			String strStatusMent = "";
			if ( strStatus.equals("Ended OK") ) {
				strStatusMent = "완료";
			} else if ( strStatus.equals("Ended Not OK") ) {
				strStatusMent = "오류";
			} else if ( strStatus.indexOf("Wait") > -1 ) {
				strStatusMent = "미완료";
			} else if ( !strStatus.equals("Ended OK") && !strStatus.equals("Ended Not OK") && strStatus.indexOf("Wait") == -1 ) {
				strStatusMent = "기타";
			}
			
			XSSFRow sheet4_listRow2 = sheet4.createRow((int) sheet4_row_count + 1);
			sheet4_row_count++;
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			XSSFCell sheet4_listCell2	= sheet4_listRow2.createCell((int) 1);
			sheet4_listCell2.setCellValue((i+1));
			sheet4_listCell2.setCellStyle(style);
			
			sheet4_listCell2	= sheet4_listRow2.createCell((int) 2);
			sheet4_listCell2.setCellValue(strOdate);
			sheet4_listCell2.setCellStyle(style);
			
			sheet4_listCell2	= sheet4_listRow2.createCell((int) 3);
			sheet4_listCell2.setCellValue(strRerunCounter);
			sheet4_listCell2.setCellStyle(style);
			
			sheet4_listCell2	= sheet4_listRow2.createCell((int) 4);
			sheet4_listCell2.setCellValue(strStatusMent);
			sheet4_listCell2.setCellStyle(style);
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			sheet4_listCell2	= sheet4_listRow2.createCell((int) 5);
			sheet4_listCell2.setCellValue(" " + strJobName);			
			sheet4_listCell2.setCellStyle(style);
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			sheet4_listCell2	= sheet4_listRow2.createCell((int) 6);
			sheet4_listCell2.setCellValue(strStartTime);
			sheet4_listCell2.setCellStyle(style);
			
			sheet4_listCell2	= sheet4_listRow2.createCell((int) 7);
			sheet4_listCell2.setCellValue(strEndTime);
			sheet4_listCell2.setCellStyle(style);
			
			sheet4_listCell2	= sheet4_listRow2.createCell((int) 8);
			sheet4_listCell2.setCellValue(strRunTime);
			sheet4_listCell2.setCellStyle(style);
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			sheet4_listCell2	= sheet4_listRow2.createCell((int) 9);
			sheet4_listCell2.setCellValue(" " + strDescription);			
			sheet4_listCell2.setCellStyle(style);
		}
		
		sheet4.setColumnWidth(0, (int)0x200);
		
		for(int i=1; i<=10; i++){
			sheet4.autoSizeColumn(i);
			sheet4.setColumnWidth(i, sheet4.getColumnWidth(i)+700 );
		}
		
		
		
		
		
		
		// 시트 생성
		XSSFSheet sheet5 	= wb.createSheet("AIS");
		
		int sheet5_row_count = 0;
		
		// 문서 제목 로우 생성
		XSSFRow sheet5_nameRow 	= sheet5.createRow((int) sheet5_row_count + 1);
		sheet5_row_count++;
		
		// 문서 제목 로우에 셀 생성
		XSSFCell sheet5_cell	= sheet5_nameRow.createCell((int) 1);
		
		sheet5_cell.setCellValue("<AIS 작업 처리 현황 " + s_search_odate + " ~  " + e_search_odate + ">");
		
		// 문서 제목 셀에 스타일 적용
		style	= wb.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		sheet5_cell.setCellStyle(style);
		
		// 문서 제목 셀 병합
		sheet5.addMergedRegion(new CellRangeAddress(1,  1, 1,  9));
		
		// 한줄 띄우기
		sheet5.createRow((int) sheet5_row_count + 1);
		sheet5_row_count++;
		
		// 구분 로우 생성
		XSSFRow sheet5_gubunRow 	= sheet5.createRow((int) sheet5_row_count + 1);
		sheet5_row_count++;
		
		// 구분 로우에 셀 생성
		XSSFCell sheet5_gubunCell	= sheet5_gubunRow.createCell((int) 1);
		
		sheet5_gubunCell.setCellValue("작업 의뢰서 처리 현황");
		
		// 구분 셀 병합
		sheet5.addMergedRegion(new CellRangeAddress(3,  3, 1,  9));
		
		// 구분 셀에 스타일 적용
		style	= wb.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setFillForegroundColor(IndexedColors.AQUA.index);
		style.setFillPattern(XSSFCellStyle.SOLID_FOREGROUND);
		sheet5_gubunCell.setCellStyle(style);
		
		// 타이틀 로우 생성
		XSSFRow sheet5_titleRow 	= sheet5.createRow((int) sheet5_row_count + 1);
		sheet5_row_count++;
		
		// 타이틀 셀에 스타일 적용
		style	= wb.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.index);
		style.setFillPattern(XSSFCellStyle.SOLID_FOREGROUND);
		style.setBorderRight(XSSFCellStyle.BORDER_THIN);
		style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
		style.setBorderTop(XSSFCellStyle.BORDER_THIN);
		style.setBorderBottom(XSSFCellStyle.BORDER_THIN);		
		
		// 타이틀 로우에 셀 생성 
		XSSFCell sheet5_titleCell	= sheet5_titleRow.createCell((int) 1);
		sheet5_titleCell.setCellValue("No");
		sheet5_titleCell.setCellStyle(style);
		
		sheet5_titleCell			= sheet5_titleRow.createCell((int) 2);
		sheet5_titleCell.setCellValue("ODATE");
		sheet5_titleCell.setCellStyle(style);
		
		sheet5_titleCell			= sheet5_titleRow.createCell((int) 3);
		sheet5_titleCell.setCellValue("수행건수");
		sheet5_titleCell.setCellStyle(style);
		
		sheet5_titleCell			= sheet5_titleRow.createCell((int) 4);
		sheet5_titleCell.setCellValue("처리상태");
		sheet5_titleCell.setCellStyle(style);
		
		sheet5_titleCell			= sheet5_titleRow.createCell((int) 5);
		sheet5_titleCell.setCellValue("작업명");
		sheet5_titleCell.setCellStyle(style);
		
		sheet5_titleCell			= sheet5_titleRow.createCell((int) 6);
		sheet5_titleCell.setCellValue("시작시간");
		sheet5_titleCell.setCellStyle(style);
		
		sheet5_titleCell			= sheet5_titleRow.createCell((int) 7);
		sheet5_titleCell.setCellValue("종료시간");
		sheet5_titleCell.setCellStyle(style);
		
		sheet5_titleCell			= sheet5_titleRow.createCell((int) 8);
		sheet5_titleCell.setCellValue("수행시간");
		sheet5_titleCell.setCellStyle(style);
		
		sheet5_titleCell			= sheet5_titleRow.createCell((int) 9);
		sheet5_titleCell.setCellValue("작업설명");
		sheet5_titleCell.setCellStyle(style);
		
		
		for( int i=0; null!=jobOpReportAisList && i<jobOpReportAisList.size(); i++ ){
			JobLogBean bean = (JobLogBean)jobOpReportAisList.get(i);
			
			String strOdate 		= CommonUtil.isNull(bean.getOdate());
			String strJobName 		= CommonUtil.isNull(bean.getJob_name());
			String strOrderTable 	= CommonUtil.isNull(bean.getOrder_table());
			String strApplication 	= CommonUtil.isNull(bean.getApplication());
			String strGroupName 	= CommonUtil.isNull(bean.getGroup_name());
			String strStateResult 	= CommonUtil.isNull(bean.getState_result());
			String strStatus 		= CommonUtil.isNull(bean.getStatus());
			String strStartTime 	= CommonUtil.isNull(CommonUtil.getDateFormat(1,bean.getStart_time(),"-"));
			String strEndTime 		= CommonUtil.isNull(CommonUtil.getDateFormat(1,bean.getEnd_time(),"-;"));
			String strRunTime 		= CommonUtil.getDiffTime( CommonUtil.getDateFormat(1,bean.getStart_time()),CommonUtil.getDateFormat(1,bean.getEnd_time()));
			String strDescription	= CommonUtil.isNull(bean.getDescription());
			String strRerunCounter	= CommonUtil.isNull(bean.getRerun_counter());
			
			String strStatusMent = "";
			if ( strStatus.equals("Ended OK") ) {
				strStatusMent = "완료";
			} else if ( strStatus.equals("Ended Not OK") ) {
				strStatusMent = "오류";
			} else if ( strStatus.indexOf("Wait") > -1 ) {
				strStatusMent = "미완료";
			} else if ( !strStatus.equals("Ended OK") && !strStatus.equals("Ended Not OK") && strStatus.indexOf("Wait") == -1 ) {
				strStatusMent = "기타";
			}
			
			XSSFRow sheet5_listRow = sheet5.createRow((int) sheet5_row_count + 1);
			sheet5_row_count++;
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			XSSFCell sheet5_listCell2	= sheet5_listRow.createCell((int) 1);
			sheet5_listCell2.setCellValue((i+1));
			sheet5_listCell2.setCellStyle(style);
			
			sheet5_listCell2	= sheet5_listRow.createCell((int) 2);
			sheet5_listCell2.setCellValue(strOdate);
			sheet5_listCell2.setCellStyle(style);
			
			sheet5_listCell2	= sheet5_listRow.createCell((int) 3);
			sheet5_listCell2.setCellValue(strRerunCounter);
			sheet5_listCell2.setCellStyle(style);
			
			sheet5_listCell2	= sheet5_listRow.createCell((int) 4);
			sheet5_listCell2.setCellValue(strStatusMent);
			sheet5_listCell2.setCellStyle(style);
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			sheet5_listCell2	= sheet5_listRow.createCell((int) 5);
			sheet5_listCell2.setCellValue(" " + strJobName);			
			sheet5_listCell2.setCellStyle(style);
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			sheet5_listCell2	= sheet5_listRow.createCell((int) 6);
			sheet5_listCell2.setCellValue(strStartTime);
			sheet5_listCell2.setCellStyle(style);
			
			sheet5_listCell2	= sheet5_listRow.createCell((int) 7);
			sheet5_listCell2.setCellValue(strEndTime);
			sheet5_listCell2.setCellStyle(style);
			
			sheet5_listCell2	= sheet5_listRow.createCell((int) 8);
			sheet5_listCell2.setCellValue(strRunTime);
			sheet5_listCell2.setCellStyle(style);
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			sheet5_listCell2	= sheet5_listRow.createCell((int) 9);
			sheet5_listCell2.setCellValue(" " + strDescription);			
			sheet5_listCell2.setCellStyle(style);
		}

		// 한줄 띄우기
		sheet5.createRow((int) sheet5_row_count + 1);
		sheet5_row_count++;
		
		// 한줄 띄우기
		sheet5.createRow((int) sheet5_row_count + 1);
		sheet5_row_count++;
		
		// 구분 로우 생성
		XSSFRow sheet5_gubunRow2 	= sheet5.createRow((int) sheet5_row_count + 1);
		sheet5_row_count++;
		
		// 구분 로우에 셀 생성
		XSSFCell sheet5_gubunCell2	= sheet5_gubunRow2.createCell((int) 1);
		
		sheet5_gubunCell2.setCellValue("정규 작업 처리 현황");
		
		// 구분 셀 병합
		sheet5.addMergedRegion(new CellRangeAddress(sheet5_row_count,  sheet5_row_count, 1,  9));
		
		// 구분 셀에 스타일 적용
		style	= wb.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setFillForegroundColor(IndexedColors.AQUA.index);
		style.setFillPattern(XSSFCellStyle.SOLID_FOREGROUND);
		sheet5_gubunCell2.setCellStyle(style);
		
		// 타이틀 로우 생성
		XSSFRow sheet5_titleRow2 	= sheet5.createRow((int) sheet5_row_count + 1);
		sheet5_row_count++;
		
		// 타이틀 셀에 스타일 적용
		style	= wb.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.index);
		style.setFillPattern(XSSFCellStyle.SOLID_FOREGROUND);
		style.setBorderRight(XSSFCellStyle.BORDER_THIN);
		style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
		style.setBorderTop(XSSFCellStyle.BORDER_THIN);
		style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
		
		// 타이틀 로우에 셀 생성 
		XSSFCell sheet5_titleCell2	= sheet5_titleRow2.createCell((int) 1);
		sheet5_titleCell2.setCellValue("No");
		sheet5_titleCell2.setCellStyle(style);
		
		sheet5_titleCell2			= sheet5_titleRow2.createCell((int) 2);
		sheet5_titleCell2.setCellValue("ODATE");
		sheet5_titleCell2.setCellStyle(style);
		
		sheet5_titleCell2			= sheet5_titleRow2.createCell((int) 3);
		sheet5_titleCell2.setCellValue("수행건수");
		sheet5_titleCell2.setCellStyle(style);
		
		sheet5_titleCell2			= sheet5_titleRow2.createCell((int) 4);
		sheet5_titleCell2.setCellValue("처리상태");
		sheet5_titleCell2.setCellStyle(style);
		
		sheet5_titleCell2			= sheet5_titleRow2.createCell((int) 5);
		sheet5_titleCell2.setCellValue("작업명");
		sheet5_titleCell2.setCellStyle(style);
		
		sheet5_titleCell2			= sheet5_titleRow2.createCell((int) 6);
		sheet5_titleCell2.setCellValue("시작시간");
		sheet5_titleCell2.setCellStyle(style);
		
		sheet5_titleCell2			= sheet5_titleRow2.createCell((int) 7);
		sheet5_titleCell2.setCellValue("종료시간");
		sheet5_titleCell2.setCellStyle(style);
		
		sheet5_titleCell2			= sheet5_titleRow2.createCell((int) 8);
		sheet5_titleCell2.setCellValue("수행시간");
		sheet5_titleCell2.setCellStyle(style);
		
		sheet5_titleCell2			= sheet5_titleRow2.createCell((int) 9);
		sheet5_titleCell2.setCellValue("작업설명");
		sheet5_titleCell2.setCellStyle(style);
		
		for( int i=0; null!=jobOpReportAisList2 && i<jobOpReportAisList2.size(); i++ ){
			JobLogBean bean = (JobLogBean)jobOpReportAisList2.get(i);
			
			String strOdate 		= CommonUtil.isNull(bean.getOdate());
			String strJobName 		= CommonUtil.isNull(bean.getJob_name());
			String strOrderTable 	= CommonUtil.isNull(bean.getOrder_table());
			String strApplication 	= CommonUtil.isNull(bean.getApplication());
			String strGroupName 	= CommonUtil.isNull(bean.getGroup_name());
			String strStateResult 	= CommonUtil.isNull(bean.getState_result());
			String strStatus 		= CommonUtil.isNull(bean.getStatus());
			String strStartTime 	= CommonUtil.isNull(CommonUtil.getDateFormat(1,bean.getStart_time(),"-"));
			String strEndTime 		= CommonUtil.isNull(CommonUtil.getDateFormat(1,bean.getEnd_time(),"-"));
			String strRunTime 		= CommonUtil.getDiffTime( CommonUtil.getDateFormat(1,bean.getStart_time()),CommonUtil.getDateFormat(1,bean.getEnd_time()));
			String strDescription	= CommonUtil.isNull(bean.getDescription());
			String strRerunCounter	= CommonUtil.isNull(bean.getRerun_counter());
			
			String strStatusMent = "";
			if ( strStatus.equals("Ended OK") ) {
				strStatusMent = "완료";
			} else if ( strStatus.equals("Ended Not OK") ) {
				strStatusMent = "오류";
			} else if ( strStatus.indexOf("Wait") > -1 ) {
				strStatusMent = "미완료";
			} else if ( !strStatus.equals("Ended OK") && !strStatus.equals("Ended Not OK") && strStatus.indexOf("Wait") == -1 ) {
				strStatusMent = "기타";
			}
			
			XSSFRow sheet5_listRow2 = sheet5.createRow((int) sheet5_row_count + 1);
			sheet5_row_count++;
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			XSSFCell sheet5_listCell2	= sheet5_listRow2.createCell((int) 1);
			sheet5_listCell2.setCellValue((i+1));
			sheet5_listCell2.setCellStyle(style);
			
			sheet5_listCell2	= sheet5_listRow2.createCell((int) 2);
			sheet5_listCell2.setCellValue(strOdate);
			sheet5_listCell2.setCellStyle(style);
			
			sheet5_listCell2	= sheet5_listRow2.createCell((int) 3);
			sheet5_listCell2.setCellValue(strRerunCounter);
			sheet5_listCell2.setCellStyle(style);
			
			sheet5_listCell2	= sheet5_listRow2.createCell((int) 4);
			sheet5_listCell2.setCellValue(strStatusMent);
			sheet5_listCell2.setCellStyle(style);
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			sheet5_listCell2	= sheet5_listRow2.createCell((int) 5);
			sheet5_listCell2.setCellValue(" " + strJobName);			
			sheet5_listCell2.setCellStyle(style);
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			sheet5_listCell2	= sheet5_listRow2.createCell((int) 6);
			sheet5_listCell2.setCellValue(strStartTime);
			sheet5_listCell2.setCellStyle(style);
			
			sheet5_listCell2	= sheet5_listRow2.createCell((int) 7);
			sheet5_listCell2.setCellValue(strEndTime);
			sheet5_listCell2.setCellStyle(style);
			
			sheet5_listCell2	= sheet5_listRow2.createCell((int) 8);
			sheet5_listCell2.setCellValue(strRunTime);
			sheet5_listCell2.setCellStyle(style);
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			sheet5_listCell2	= sheet5_listRow2.createCell((int) 9);
			sheet5_listCell2.setCellValue(" " + strDescription);			
			sheet5_listCell2.setCellStyle(style);
		}
		
		// 한줄 띄우기
		sheet5.createRow((int) sheet5_row_count + 1);
		sheet5_row_count++;
		
		// 한줄 띄우기
		sheet5.createRow((int) sheet5_row_count + 1);
		sheet5_row_count++;
		
		// 구분 로우 생성
		XSSFRow sheet5_gubunRow3 	= sheet5.createRow((int) sheet5_row_count + 1);
		sheet5_row_count++;
		
		// 구분 로우에 셀 생성
		XSSFCell sheet5_gubunCell3	= sheet5_gubunRow3.createCell((int) 1);
		
		//sheet5_gubunCell3.setCellValue("정규 작업 처리 현황");
		sheet5_gubunCell3.setCellValue("월초 작업 처리 현황");
		
		// 구분 셀 병합
		sheet5.addMergedRegion(new CellRangeAddress(sheet5_row_count,  sheet5_row_count, 1,  9));
		
		// 구분 셀에 스타일 적용
		style	= wb.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setFillForegroundColor(IndexedColors.AQUA.index);
		style.setFillPattern(XSSFCellStyle.SOLID_FOREGROUND);
		sheet5_gubunCell3.setCellStyle(style);
		
		// 타이틀 로우 생성
		XSSFRow sheet5_titleRow3 	= sheet5.createRow((int) sheet5_row_count + 1);
		sheet5_row_count++;
		
		// 타이틀 셀에 스타일 적용
		style	= wb.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.index);
		style.setFillPattern(XSSFCellStyle.SOLID_FOREGROUND);
		style.setBorderRight(XSSFCellStyle.BORDER_THIN);
		style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
		style.setBorderTop(XSSFCellStyle.BORDER_THIN);
		style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
		
		// 타이틀 로우에 셀 생성 
		XSSFCell sheet5_titleCell3	= sheet5_titleRow3.createCell((int) 1);
		sheet5_titleCell3.setCellValue("No");
		sheet5_titleCell3.setCellStyle(style);
		
		sheet5_titleCell3			= sheet5_titleRow3.createCell((int) 2);
		sheet5_titleCell3.setCellValue("ODATE");
		sheet5_titleCell3.setCellStyle(style);
		
		sheet5_titleCell3			= sheet5_titleRow3.createCell((int) 3);
		sheet5_titleCell3.setCellValue("수행건수");
		sheet5_titleCell3.setCellStyle(style);
		
		sheet5_titleCell3			= sheet5_titleRow3.createCell((int) 4);
		sheet5_titleCell3.setCellValue("처리상태");
		sheet5_titleCell3.setCellStyle(style);
		
		sheet5_titleCell3			= sheet5_titleRow3.createCell((int) 5);
		sheet5_titleCell3.setCellValue("작업명");
		sheet5_titleCell3.setCellStyle(style);
		
		sheet5_titleCell3			= sheet5_titleRow3.createCell((int) 6);
		sheet5_titleCell3.setCellValue("시작시간");
		sheet5_titleCell3.setCellStyle(style);
		
		sheet5_titleCell3			= sheet5_titleRow3.createCell((int) 7);
		sheet5_titleCell3.setCellValue("종료시간");
		sheet5_titleCell3.setCellStyle(style);
		
		sheet5_titleCell3			= sheet5_titleRow3.createCell((int) 8);
		sheet5_titleCell3.setCellValue("수행시간");
		sheet5_titleCell3.setCellStyle(style);
		
		sheet5_titleCell3			= sheet5_titleRow3.createCell((int) 9);
		sheet5_titleCell3.setCellValue("작업설명");
		sheet5_titleCell3.setCellStyle(style);
		
		for( int i=0; null!=jobOpReportAisList3 && i<jobOpReportAisList3.size(); i++ ){
			JobLogBean bean = (JobLogBean)jobOpReportAisList3.get(i);
			
			String strOdate 		= CommonUtil.isNull(bean.getOdate());
			String strJobName 		= CommonUtil.isNull(bean.getJob_name());
			String strOrderTable 	= CommonUtil.isNull(bean.getOrder_table());
			String strApplication 	= CommonUtil.isNull(bean.getApplication());
			String strGroupName 	= CommonUtil.isNull(bean.getGroup_name());
			String strStateResult 	= CommonUtil.isNull(bean.getState_result());
			String strStatus 		= CommonUtil.isNull(bean.getStatus());
			String strStartTime 	= CommonUtil.isNull(CommonUtil.getDateFormat(1,bean.getStart_time(),"-"));
			String strEndTime 		= CommonUtil.isNull(CommonUtil.getDateFormat(1,bean.getEnd_time(),"-"));
			String strRunTime 		= CommonUtil.getDiffTime( CommonUtil.getDateFormat(1,bean.getStart_time()),CommonUtil.getDateFormat(1,bean.getEnd_time()));
			String strDescription	= CommonUtil.isNull(bean.getDescription());
			String strRerunCounter	= CommonUtil.isNull(bean.getRerun_counter());
			
			String strStatusMent = "";
			if ( strStatus.equals("Ended OK") ) {
				strStatusMent = "완료";
			} else if ( strStatus.equals("Ended Not OK") ) {
				strStatusMent = "오류";
			} else if ( strStatus.indexOf("Wait") > -1 ) {
				strStatusMent = "미완료";
			} else if ( !strStatus.equals("Ended OK") && !strStatus.equals("Ended Not OK") && strStatus.indexOf("Wait") == -1 ) {
				strStatusMent = "기타";
			}
			
			XSSFRow sheet5_listRow2 = sheet5.createRow((int) sheet5_row_count + 1);
			sheet5_row_count++;
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			XSSFCell sheet5_listCell2	= sheet5_listRow2.createCell((int) 1);
			sheet5_listCell2.setCellValue((i+1));
			sheet5_listCell2.setCellStyle(style);
			
			sheet5_listCell2	= sheet5_listRow2.createCell((int) 2);
			sheet5_listCell2.setCellValue(strOdate);
			sheet5_listCell2.setCellStyle(style);
			
			sheet5_listCell2	= sheet5_listRow2.createCell((int) 3);
			sheet5_listCell2.setCellValue(strRerunCounter);
			sheet5_listCell2.setCellStyle(style);
			
			sheet5_listCell2	= sheet5_listRow2.createCell((int) 4);
			sheet5_listCell2.setCellValue(strStatusMent);
			sheet5_listCell2.setCellStyle(style);
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			sheet5_listCell2	= sheet5_listRow2.createCell((int) 5);
			sheet5_listCell2.setCellValue(" " + strJobName);			
			sheet5_listCell2.setCellStyle(style);
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			sheet5_listCell2	= sheet5_listRow2.createCell((int) 6);
			sheet5_listCell2.setCellValue(strStartTime);
			sheet5_listCell2.setCellStyle(style);
			
			sheet5_listCell2	= sheet5_listRow2.createCell((int) 7);
			sheet5_listCell2.setCellValue(strEndTime);
			sheet5_listCell2.setCellStyle(style);
			
			sheet5_listCell2	= sheet5_listRow2.createCell((int) 8);
			sheet5_listCell2.setCellValue(strRunTime);
			sheet5_listCell2.setCellStyle(style);
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			sheet5_listCell2	= sheet5_listRow2.createCell((int) 9);
			sheet5_listCell2.setCellValue(" " + strDescription);			
			sheet5_listCell2.setCellStyle(style);
		}
		
		// 한줄 띄우기
		sheet5.createRow((int) sheet5_row_count + 1);
		sheet5_row_count++;
		
		// 한줄 띄우기
		sheet5.createRow((int) sheet5_row_count + 1);
		sheet5_row_count++;
		
		// 구분 로우 생성
		XSSFRow sheet5_gubunRow4 	= sheet5.createRow((int) sheet5_row_count + 1);
		sheet5_row_count++;
		
		// 구분 로우에 셀 생성
		XSSFCell sheet5_gubunCell4	= sheet5_gubunRow4.createCell((int) 1);
		
		//sheet5_gubunCell4.setCellValue("정규 작업 처리 현황");
		sheet5_gubunCell4.setCellValue("월말 작업 처리 현황");
		
		// 구분 셀 병합
		sheet5.addMergedRegion(new CellRangeAddress(sheet5_row_count,  sheet5_row_count, 1,  9));
		
		// 구분 셀에 스타일 적용
		style	= wb.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setFillForegroundColor(IndexedColors.AQUA.index);
		style.setFillPattern(XSSFCellStyle.SOLID_FOREGROUND);
		sheet5_gubunCell4.setCellStyle(style);
		
		// 타이틀 로우 생성
		XSSFRow sheet5_titleRow4 	= sheet5.createRow((int) sheet5_row_count + 1);
		sheet5_row_count++;
		
		// 타이틀 셀에 스타일 적용
		style	= wb.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.index);
		style.setFillPattern(XSSFCellStyle.SOLID_FOREGROUND);
		style.setBorderRight(XSSFCellStyle.BORDER_THIN);
		style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
		style.setBorderTop(XSSFCellStyle.BORDER_THIN);
		style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
		
		// 타이틀 로우에 셀 생성 
		XSSFCell sheet5_titleCell4	= sheet5_titleRow4.createCell((int) 1);
		sheet5_titleCell4.setCellValue("No");
		sheet5_titleCell4.setCellStyle(style);
		
		sheet5_titleCell4			= sheet5_titleRow4.createCell((int) 2);
		sheet5_titleCell4.setCellValue("ODATE");
		sheet5_titleCell4.setCellStyle(style);
		
		sheet5_titleCell4			= sheet5_titleRow4.createCell((int) 3);
		sheet5_titleCell4.setCellValue("수행건수");
		sheet5_titleCell4.setCellStyle(style);
		
		sheet5_titleCell4			= sheet5_titleRow4.createCell((int) 4);
		sheet5_titleCell4.setCellValue("처리상태");
		sheet5_titleCell4.setCellStyle(style);
		
		sheet5_titleCell4			= sheet5_titleRow4.createCell((int) 5);
		sheet5_titleCell4.setCellValue("작업명");
		sheet5_titleCell4.setCellStyle(style);
		
		sheet5_titleCell4			= sheet5_titleRow4.createCell((int) 6);
		sheet5_titleCell4.setCellValue("시작시간");
		sheet5_titleCell4.setCellStyle(style);
		
		sheet5_titleCell4			= sheet5_titleRow4.createCell((int) 7);
		sheet5_titleCell4.setCellValue("종료시간");
		sheet5_titleCell4.setCellStyle(style);
		
		sheet5_titleCell4			= sheet5_titleRow4.createCell((int) 8);
		sheet5_titleCell4.setCellValue("수행시간");
		sheet5_titleCell4.setCellStyle(style);
		
		sheet5_titleCell4			= sheet5_titleRow4.createCell((int) 9);
		sheet5_titleCell4.setCellValue("작업설명");
		sheet5_titleCell4.setCellStyle(style);
		
		for( int i=0; null!=jobOpReportAisList4 && i<jobOpReportAisList4.size(); i++ ){
			JobLogBean bean = (JobLogBean)jobOpReportAisList4.get(i);
			
			String strOdate 		= CommonUtil.isNull(bean.getOdate());
			String strJobName 		= CommonUtil.isNull(bean.getJob_name());
			String strOrderTable 	= CommonUtil.isNull(bean.getOrder_table());
			String strApplication 	= CommonUtil.isNull(bean.getApplication());
			String strGroupName 	= CommonUtil.isNull(bean.getGroup_name());
			String strStateResult 	= CommonUtil.isNull(bean.getState_result());
			String strStatus 		= CommonUtil.isNull(bean.getStatus());
			String strStartTime 	= CommonUtil.isNull(CommonUtil.getDateFormat(1,bean.getStart_time(),"-"));
			String strEndTime 		= CommonUtil.isNull(CommonUtil.getDateFormat(1,bean.getEnd_time(),"-"));
			String strRunTime 		= CommonUtil.getDiffTime( CommonUtil.getDateFormat(1,bean.getStart_time()),CommonUtil.getDateFormat(1,bean.getEnd_time()));
			String strDescription	= CommonUtil.isNull(bean.getDescription());
			String strRerunCounter	= CommonUtil.isNull(bean.getRerun_counter());
			
			String strStatusMent = "";
			if ( strStatus.equals("Ended OK") ) {
				strStatusMent = "완료";
			} else if ( strStatus.equals("Ended Not OK") ) {
				strStatusMent = "오류";
			} else if ( strStatus.indexOf("Wait") > -1 ) {
				strStatusMent = "미완료";
			} else if ( !strStatus.equals("Ended OK") && !strStatus.equals("Ended Not OK") && strStatus.indexOf("Wait") == -1 ) {
				strStatusMent = "기타";
			}
			
			XSSFRow sheet5_listRow2 = sheet5.createRow((int) sheet5_row_count + 1);
			sheet5_row_count++;
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			XSSFCell sheet5_listCell2	= sheet5_listRow2.createCell((int) 1);
			sheet5_listCell2.setCellValue((i+1));
			sheet5_listCell2.setCellStyle(style);
			
			sheet5_listCell2	= sheet5_listRow2.createCell((int) 2);
			sheet5_listCell2.setCellValue(strOdate);
			sheet5_listCell2.setCellStyle(style);
			
			sheet5_listCell2	= sheet5_listRow2.createCell((int) 3);
			sheet5_listCell2.setCellValue(strRerunCounter);
			sheet5_listCell2.setCellStyle(style);
			
			sheet5_listCell2	= sheet5_listRow2.createCell((int) 4);
			sheet5_listCell2.setCellValue(strStatusMent);
			sheet5_listCell2.setCellStyle(style);
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			sheet5_listCell2	= sheet5_listRow2.createCell((int) 5);
			sheet5_listCell2.setCellValue(" " + strJobName);			
			sheet5_listCell2.setCellStyle(style);
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			sheet5_listCell2	= sheet5_listRow2.createCell((int) 6);
			sheet5_listCell2.setCellValue(strStartTime);
			sheet5_listCell2.setCellStyle(style);
			
			sheet5_listCell2	= sheet5_listRow2.createCell((int) 7);
			sheet5_listCell2.setCellValue(strEndTime);
			sheet5_listCell2.setCellStyle(style);
			
			sheet5_listCell2	= sheet5_listRow2.createCell((int) 8);
			sheet5_listCell2.setCellValue(strRunTime);
			sheet5_listCell2.setCellStyle(style);
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			sheet5_listCell2	= sheet5_listRow2.createCell((int) 9);
			sheet5_listCell2.setCellValue(" " + strDescription);			
			sheet5_listCell2.setCellStyle(style);
		}
		
		sheet5.setColumnWidth(0, (int)0x200);
		
		for(int i=1; i<=10; i++){
			sheet5.autoSizeColumn(i);
			sheet5.setColumnWidth(i, sheet5.getColumnWidth(i)+700 );
		}
		
		
		
		
		
		
		// 시트 생성
		XSSFSheet sheet6 	= wb.createSheet("ALM");
		
		int sheet6_row_count = 0;
		
		// 문서 제목 로우 생성
		XSSFRow sheet6_nameRow 	= sheet6.createRow((int) sheet6_row_count + 1);
		sheet6_row_count++;
		
		// 문서 제목 로우에 셀 생성
		XSSFCell sheet6_cell	= sheet6_nameRow.createCell((int) 1);
		
		sheet6_cell.setCellValue("<ALM 작업 처리 현황 " + s_search_odate + " ~  " + e_search_odate + ">");
		
		// 문서 제목 셀에 스타일 적용
		style	= wb.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		sheet6_cell.setCellStyle(style);
		
		// 문서 제목 셀 병합
		sheet6.addMergedRegion(new CellRangeAddress(1,  1, 1,  9));
		
		// 한줄 띄우기
		sheet6.createRow((int) sheet6_row_count + 1);
		sheet6_row_count++;
		
		// 구분 로우 생성
		XSSFRow sheet6_gubunRow 	= sheet6.createRow((int) sheet6_row_count + 1);
		sheet6_row_count++;
		
		// 구분 로우에 셀 생성
		XSSFCell sheet6_gubunCell	= sheet6_gubunRow.createCell((int) 1);
		
		sheet6_gubunCell.setCellValue("작업 의뢰서 처리 현황");
		
		// 구분 셀 병합
		sheet6.addMergedRegion(new CellRangeAddress(3,  3, 1,  9));
		
		// 구분 셀에 스타일 적용
		style	= wb.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setFillForegroundColor(IndexedColors.AQUA.index);
		style.setFillPattern(XSSFCellStyle.SOLID_FOREGROUND);
		sheet6_gubunCell.setCellStyle(style);
		
		// 타이틀 로우 생성
		XSSFRow sheet6_titleRow 	= sheet6.createRow((int) sheet6_row_count + 1);
		sheet6_row_count++;
		
		// 타이틀 셀에 스타일 적용
		style	= wb.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.index);
		style.setFillPattern(XSSFCellStyle.SOLID_FOREGROUND);
		style.setBorderRight(XSSFCellStyle.BORDER_THIN);
		style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
		style.setBorderTop(XSSFCellStyle.BORDER_THIN);
		style.setBorderBottom(XSSFCellStyle.BORDER_THIN);		
		
		// 타이틀 로우에 셀 생성 
		XSSFCell sheet6_titleCell	= sheet6_titleRow.createCell((int) 1);
		sheet6_titleCell.setCellValue("No");
		sheet6_titleCell.setCellStyle(style);
		
		sheet6_titleCell			= sheet6_titleRow.createCell((int) 2);
		sheet6_titleCell.setCellValue("ODATE");
		sheet6_titleCell.setCellStyle(style);
		
		sheet6_titleCell			= sheet6_titleRow.createCell((int) 3);
		sheet6_titleCell.setCellValue("수행건수");
		sheet6_titleCell.setCellStyle(style);
		
		sheet6_titleCell			= sheet6_titleRow.createCell((int) 4);
		sheet6_titleCell.setCellValue("처리상태");
		sheet6_titleCell.setCellStyle(style);
		
		sheet6_titleCell			= sheet6_titleRow.createCell((int) 5);
		sheet6_titleCell.setCellValue("작업명");
		sheet6_titleCell.setCellStyle(style);
		
		sheet6_titleCell			= sheet6_titleRow.createCell((int) 6);
		sheet6_titleCell.setCellValue("시작시간");
		sheet6_titleCell.setCellStyle(style);
		
		sheet6_titleCell			= sheet6_titleRow.createCell((int) 7);
		sheet6_titleCell.setCellValue("종료시간");
		sheet6_titleCell.setCellStyle(style);
		
		sheet6_titleCell			= sheet6_titleRow.createCell((int) 8);
		sheet6_titleCell.setCellValue("수행시간");
		sheet6_titleCell.setCellStyle(style);
		
		sheet6_titleCell			= sheet6_titleRow.createCell((int) 9);
		sheet6_titleCell.setCellValue("작업설명");
		sheet6_titleCell.setCellStyle(style);
		
		for( int i=0; null!=jobOpReportAlmList && i<jobOpReportAlmList.size(); i++ ){
			JobLogBean bean = (JobLogBean)jobOpReportAlmList.get(i);
			
			String strOdate 		= CommonUtil.isNull(bean.getOdate());
			String strJobName 		= CommonUtil.isNull(bean.getJob_name());
			String strOrderTable 	= CommonUtil.isNull(bean.getOrder_table());
			String strApplication 	= CommonUtil.isNull(bean.getApplication());
			String strGroupName 	= CommonUtil.isNull(bean.getGroup_name());
			String strStateResult 	= CommonUtil.isNull(bean.getState_result());
			String strStatus 		= CommonUtil.isNull(bean.getStatus());
			String strStartTime 	= CommonUtil.isNull(CommonUtil.getDateFormat(1,bean.getStart_time(),"-"));
			String strEndTime 		= CommonUtil.isNull(CommonUtil.getDateFormat(1,bean.getEnd_time(),"-;"));
			String strRunTime 		= CommonUtil.getDiffTime( CommonUtil.getDateFormat(1,bean.getStart_time()),CommonUtil.getDateFormat(1,bean.getEnd_time()));
			String strDescription	= CommonUtil.isNull(bean.getDescription());
			String strRerunCounter	= CommonUtil.isNull(bean.getRerun_counter());
			
			String strStatusMent = "";
			if ( strStatus.equals("Ended OK") ) {
				strStatusMent = "완료";
			} else if ( strStatus.equals("Ended Not OK") ) {
				strStatusMent = "오류";
			} else if ( strStatus.indexOf("Wait") > -1 ) {
				strStatusMent = "미완료";
			} else if ( !strStatus.equals("Ended OK") && !strStatus.equals("Ended Not OK") && strStatus.indexOf("Wait") == -1 ) {
				strStatusMent = "기타";
			}
			
			XSSFRow sheet6_listRow = sheet6.createRow((int) sheet6_row_count + 1);
			sheet6_row_count++;
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			XSSFCell sheet6_listCell2	= sheet6_listRow.createCell((int) 1);
			sheet6_listCell2.setCellValue((i+1));
			sheet6_listCell2.setCellStyle(style);
			
			sheet6_listCell2	= sheet6_listRow.createCell((int) 2);
			sheet6_listCell2.setCellValue(strOdate);
			sheet6_listCell2.setCellStyle(style);
			
			sheet6_listCell2	= sheet6_listRow.createCell((int) 3);
			sheet6_listCell2.setCellValue(strRerunCounter);
			sheet6_listCell2.setCellStyle(style);
			
			sheet6_listCell2	= sheet6_listRow.createCell((int) 4);
			sheet6_listCell2.setCellValue(strStatusMent);
			sheet6_listCell2.setCellStyle(style);
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			sheet6_listCell2	= sheet6_listRow.createCell((int) 5);
			sheet6_listCell2.setCellValue(" " + strJobName);			
			sheet6_listCell2.setCellStyle(style);
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			sheet6_listCell2	= sheet6_listRow.createCell((int) 6);
			sheet6_listCell2.setCellValue(strStartTime);
			sheet6_listCell2.setCellStyle(style);
			
			sheet6_listCell2	= sheet6_listRow.createCell((int) 7);
			sheet6_listCell2.setCellValue(strEndTime);
			sheet6_listCell2.setCellStyle(style);
			
			sheet6_listCell2	= sheet6_listRow.createCell((int) 8);
			sheet6_listCell2.setCellValue(strRunTime);
			sheet6_listCell2.setCellStyle(style);
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			sheet6_listCell2	= sheet6_listRow.createCell((int) 9);
			sheet6_listCell2.setCellValue(" " + strDescription);			
			sheet6_listCell2.setCellStyle(style);
		}

		// 한줄 띄우기
		sheet6.createRow((int) sheet6_row_count + 1);
		sheet6_row_count++;
		
		// 한줄 띄우기
		sheet6.createRow((int) sheet6_row_count + 1);
		sheet6_row_count++;
		
		// 구분 로우 생성
		XSSFRow sheet6_gubunRow2 	= sheet6.createRow((int) sheet6_row_count + 1);
		sheet6_row_count++;
		
		// 구분 로우에 셀 생성
		XSSFCell sheet6_gubunCell2	= sheet6_gubunRow2.createCell((int) 1);
		
		sheet6_gubunCell2.setCellValue("정규 작업 처리 현황");
		
		// 구분 셀 병합
		sheet6.addMergedRegion(new CellRangeAddress(sheet6_row_count,  sheet6_row_count, 1,  9));
		
		// 구분 셀에 스타일 적용
		style	= wb.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setFillForegroundColor(IndexedColors.AQUA.index);
		style.setFillPattern(XSSFCellStyle.SOLID_FOREGROUND);
		sheet6_gubunCell2.setCellStyle(style);
		
		// 타이틀 로우 생성
		XSSFRow sheet6_titleRow2 	= sheet6.createRow((int) sheet6_row_count + 1);
		sheet6_row_count++;
		
		// 타이틀 셀에 스타일 적용
		style	= wb.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.index);
		style.setFillPattern(XSSFCellStyle.SOLID_FOREGROUND);
		style.setBorderRight(XSSFCellStyle.BORDER_THIN);
		style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
		style.setBorderTop(XSSFCellStyle.BORDER_THIN);
		style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
		
		// 타이틀 로우에 셀 생성 
		XSSFCell sheet6_titleCell2	= sheet6_titleRow2.createCell((int) 1);
		sheet6_titleCell2.setCellValue("No");
		sheet6_titleCell2.setCellStyle(style);
		
		sheet6_titleCell2			= sheet6_titleRow2.createCell((int) 2);
		sheet6_titleCell2.setCellValue("ODATE");
		sheet6_titleCell2.setCellStyle(style);
		
		sheet6_titleCell2			= sheet6_titleRow2.createCell((int) 3);
		sheet6_titleCell2.setCellValue("수행건수");
		sheet6_titleCell2.setCellStyle(style);
		
		sheet6_titleCell2			= sheet6_titleRow2.createCell((int) 4);
		sheet6_titleCell2.setCellValue("처리상태");
		sheet6_titleCell2.setCellStyle(style);
		
		sheet6_titleCell2			= sheet6_titleRow2.createCell((int) 5);
		sheet6_titleCell2.setCellValue("작업명");
		sheet6_titleCell2.setCellStyle(style);
		
		sheet6_titleCell2			= sheet6_titleRow2.createCell((int) 6);
		sheet6_titleCell2.setCellValue("시작시간");
		sheet6_titleCell2.setCellStyle(style);
		
		sheet6_titleCell2			= sheet6_titleRow2.createCell((int) 7);
		sheet6_titleCell2.setCellValue("종료시간");
		sheet6_titleCell2.setCellStyle(style);
		
		sheet6_titleCell2			= sheet6_titleRow2.createCell((int) 8);
		sheet6_titleCell2.setCellValue("수행시간");
		sheet6_titleCell2.setCellStyle(style);
		
		sheet6_titleCell2			= sheet6_titleRow2.createCell((int) 9);
		sheet6_titleCell2.setCellValue("작업설명");
		sheet6_titleCell2.setCellStyle(style);
		
		for( int i=0; null!=jobOpReportAlmList2 && i<jobOpReportAlmList2.size(); i++ ){
			JobLogBean bean = (JobLogBean)jobOpReportAlmList2.get(i);
			
			String strOdate 		= CommonUtil.isNull(bean.getOdate());
			String strJobName 		= CommonUtil.isNull(bean.getJob_name());
			String strOrderTable 	= CommonUtil.isNull(bean.getOrder_table());
			String strApplication 	= CommonUtil.isNull(bean.getApplication());
			String strGroupName 	= CommonUtil.isNull(bean.getGroup_name());
			String strStateResult 	= CommonUtil.isNull(bean.getState_result());
			String strStatus 		= CommonUtil.isNull(bean.getStatus());
			String strStartTime 	= CommonUtil.isNull(CommonUtil.getDateFormat(1,bean.getStart_time(),"-"));
			String strEndTime 		= CommonUtil.isNull(CommonUtil.getDateFormat(1,bean.getEnd_time(),"-"));
			String strRunTime 		= CommonUtil.getDiffTime( CommonUtil.getDateFormat(1,bean.getStart_time()),CommonUtil.getDateFormat(1,bean.getEnd_time()));
			String strDescription	= CommonUtil.isNull(bean.getDescription());
			String strRerunCounter	= CommonUtil.isNull(bean.getRerun_counter());
			
			String strStatusMent = "";
			if ( strStatus.equals("Ended OK") ) {
				strStatusMent = "완료";
			} else if ( strStatus.equals("Ended Not OK") ) {
				strStatusMent = "오류";
			} else if ( strStatus.indexOf("Wait") > -1 ) {
				strStatusMent = "미완료";
			} else if ( !strStatus.equals("Ended OK") && !strStatus.equals("Ended Not OK") && strStatus.indexOf("Wait") == -1 ) {
				strStatusMent = "기타";
			}
			
			XSSFRow sheet6_listRow2 = sheet6.createRow((int) sheet6_row_count + 1);
			sheet6_row_count++;
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			XSSFCell sheet6_listCell2	= sheet6_listRow2.createCell((int) 1);
			sheet6_listCell2.setCellValue((i+1));
			sheet6_listCell2.setCellStyle(style);
			
			sheet6_listCell2	= sheet6_listRow2.createCell((int) 2);
			sheet6_listCell2.setCellValue(strOdate);
			sheet6_listCell2.setCellStyle(style);
			
			sheet6_listCell2	= sheet6_listRow2.createCell((int) 3);
			sheet6_listCell2.setCellValue(strRerunCounter);
			sheet6_listCell2.setCellStyle(style);
			
			sheet6_listCell2	= sheet6_listRow2.createCell((int) 4);
			sheet6_listCell2.setCellValue(strStatusMent);
			sheet6_listCell2.setCellStyle(style);
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			sheet6_listCell2	= sheet6_listRow2.createCell((int) 5);
			sheet6_listCell2.setCellValue(" " + strJobName);			
			sheet6_listCell2.setCellStyle(style);
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			sheet6_listCell2	= sheet6_listRow2.createCell((int) 6);
			sheet6_listCell2.setCellValue(strStartTime);
			sheet6_listCell2.setCellStyle(style);
			
			sheet6_listCell2	= sheet6_listRow2.createCell((int) 7);
			sheet6_listCell2.setCellValue(strEndTime);
			sheet6_listCell2.setCellStyle(style);
			
			sheet6_listCell2	= sheet6_listRow2.createCell((int) 8);
			sheet6_listCell2.setCellValue(strRunTime);
			sheet6_listCell2.setCellStyle(style);
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			sheet6_listCell2	= sheet6_listRow2.createCell((int) 9);
			sheet6_listCell2.setCellValue(" " + strDescription);			
			sheet6_listCell2.setCellStyle(style);
		}
		
		// 한줄 띄우기
		sheet6.createRow((int) sheet6_row_count + 1);
		sheet6_row_count++;
		
		// 한줄 띄우기
		sheet6.createRow((int) sheet6_row_count + 1);
		sheet6_row_count++;
		
		// 구분 로우 생성
		XSSFRow sheet6_gubunRow3 	= sheet6.createRow((int) sheet6_row_count + 1);
		sheet6_row_count++;
		
		// 구분 로우에 셀 생성
		XSSFCell sheet6_gubunCell3	= sheet6_gubunRow3.createCell((int) 1);
		
		//sheet6_gubunCell3.setCellValue("정규 작업 처리 현황");
		sheet6_gubunCell3.setCellValue("월초 작업 처리 현황");
		
		// 구분 셀 병합
		sheet6.addMergedRegion(new CellRangeAddress(sheet6_row_count,  sheet6_row_count, 1,  9));
		
		// 구분 셀에 스타일 적용
		style	= wb.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setFillForegroundColor(IndexedColors.AQUA.index);
		style.setFillPattern(XSSFCellStyle.SOLID_FOREGROUND);
		sheet6_gubunCell3.setCellStyle(style);
		
		// 타이틀 로우 생성
		XSSFRow sheet6_titleRow3 	= sheet6.createRow((int) sheet6_row_count + 1);
		sheet6_row_count++;
		
		// 타이틀 셀에 스타일 적용
		style	= wb.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.index);
		style.setFillPattern(XSSFCellStyle.SOLID_FOREGROUND);
		style.setBorderRight(XSSFCellStyle.BORDER_THIN);
		style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
		style.setBorderTop(XSSFCellStyle.BORDER_THIN);
		style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
		
		// 타이틀 로우에 셀 생성 
		XSSFCell sheet6_titleCell3	= sheet6_titleRow3.createCell((int) 1);
		sheet6_titleCell3.setCellValue("No");
		sheet6_titleCell3.setCellStyle(style);
		
		sheet6_titleCell3			= sheet6_titleRow3.createCell((int) 2);
		sheet6_titleCell3.setCellValue("ODATE");
		sheet6_titleCell3.setCellStyle(style);
		
		sheet6_titleCell3			= sheet6_titleRow3.createCell((int) 3);
		sheet6_titleCell3.setCellValue("수행건수");
		sheet6_titleCell3.setCellStyle(style);
		
		sheet6_titleCell3			= sheet6_titleRow3.createCell((int) 4);
		sheet6_titleCell3.setCellValue("처리상태");
		sheet6_titleCell3.setCellStyle(style);
		
		sheet6_titleCell3			= sheet6_titleRow3.createCell((int) 5);
		sheet6_titleCell3.setCellValue("작업명");
		sheet6_titleCell3.setCellStyle(style);
		
		sheet6_titleCell3			= sheet6_titleRow3.createCell((int) 6);
		sheet6_titleCell3.setCellValue("시작시간");
		sheet6_titleCell3.setCellStyle(style);
		
		sheet6_titleCell3			= sheet6_titleRow3.createCell((int) 7);
		sheet6_titleCell3.setCellValue("종료시간");
		sheet6_titleCell3.setCellStyle(style);
		
		sheet6_titleCell3			= sheet6_titleRow3.createCell((int) 8);
		sheet6_titleCell3.setCellValue("수행시간");
		sheet6_titleCell3.setCellStyle(style);
		
		sheet6_titleCell3			= sheet6_titleRow3.createCell((int) 9);
		sheet6_titleCell3.setCellValue("작업설명");
		sheet6_titleCell3.setCellStyle(style);
		
		for( int i=0; null!=jobOpReportAlmList3 && i<jobOpReportAlmList3.size(); i++ ){
			JobLogBean bean = (JobLogBean)jobOpReportAlmList3.get(i);
			
			String strOdate 		= CommonUtil.isNull(bean.getOdate());
			String strJobName 		= CommonUtil.isNull(bean.getJob_name());
			String strOrderTable 	= CommonUtil.isNull(bean.getOrder_table());
			String strApplication 	= CommonUtil.isNull(bean.getApplication());
			String strGroupName 	= CommonUtil.isNull(bean.getGroup_name());
			String strStateResult 	= CommonUtil.isNull(bean.getState_result());
			String strStatus 		= CommonUtil.isNull(bean.getStatus());
			String strStartTime 	= CommonUtil.isNull(CommonUtil.getDateFormat(1,bean.getStart_time(),"-"));
			String strEndTime 		= CommonUtil.isNull(CommonUtil.getDateFormat(1,bean.getEnd_time(),"-"));
			String strRunTime 		= CommonUtil.getDiffTime( CommonUtil.getDateFormat(1,bean.getStart_time()),CommonUtil.getDateFormat(1,bean.getEnd_time()));
			String strDescription	= CommonUtil.isNull(bean.getDescription());
			String strRerunCounter	= CommonUtil.isNull(bean.getRerun_counter());
			
			String strStatusMent = "";
			if ( strStatus.equals("Ended OK") ) {
				strStatusMent = "완료";
			} else if ( strStatus.equals("Ended Not OK") ) {
				strStatusMent = "오류";
			} else if ( strStatus.indexOf("Wait") > -1 ) {
				strStatusMent = "미완료";
			} else if ( !strStatus.equals("Ended OK") && !strStatus.equals("Ended Not OK") && strStatus.indexOf("Wait") == -1 ) {
				strStatusMent = "기타";
			}
			
			XSSFRow sheet6_listRow2 = sheet6.createRow((int) sheet6_row_count + 1);
			sheet6_row_count++;
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			XSSFCell sheet6_listCell2	= sheet6_listRow2.createCell((int) 1);
			sheet6_listCell2.setCellValue((i+1));
			sheet6_listCell2.setCellStyle(style);
			
			sheet6_listCell2	= sheet6_listRow2.createCell((int) 2);
			sheet6_listCell2.setCellValue(strOdate);
			sheet6_listCell2.setCellStyle(style);
			
			sheet6_listCell2	= sheet6_listRow2.createCell((int) 3);
			sheet6_listCell2.setCellValue(strRerunCounter);
			sheet6_listCell2.setCellStyle(style);
			
			sheet6_listCell2	= sheet6_listRow2.createCell((int) 4);
			sheet6_listCell2.setCellValue(strStatusMent);
			sheet6_listCell2.setCellStyle(style);
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			sheet6_listCell2	= sheet6_listRow2.createCell((int) 5);
			sheet6_listCell2.setCellValue(" " + strJobName);			
			sheet6_listCell2.setCellStyle(style);
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			sheet6_listCell2	= sheet6_listRow2.createCell((int) 6);
			sheet6_listCell2.setCellValue(strStartTime);
			sheet6_listCell2.setCellStyle(style);
			
			sheet6_listCell2	= sheet6_listRow2.createCell((int) 7);
			sheet6_listCell2.setCellValue(strEndTime);
			sheet6_listCell2.setCellStyle(style);
			
			sheet6_listCell2	= sheet6_listRow2.createCell((int) 8);
			sheet6_listCell2.setCellValue(strRunTime);
			sheet6_listCell2.setCellStyle(style);
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			sheet6_listCell2	= sheet6_listRow2.createCell((int) 9);
			sheet6_listCell2.setCellValue(" " + strDescription);			
			sheet6_listCell2.setCellStyle(style);
		}
		
		// 한줄 띄우기
		sheet6.createRow((int) sheet6_row_count + 1);
		sheet6_row_count++;
		
		// 한줄 띄우기
		sheet6.createRow((int) sheet6_row_count + 1);
		sheet6_row_count++;
		
		// 구분 로우 생성
		XSSFRow sheet6_gubunRow4 	= sheet6.createRow((int) sheet6_row_count + 1);
		sheet6_row_count++;
		
		// 구분 로우에 셀 생성
		XSSFCell sheet6_gubunCell4	= sheet6_gubunRow4.createCell((int) 1);
		
		//sheet6_gubunCell4.setCellValue("정규 작업 처리 현황");
		sheet6_gubunCell4.setCellValue("월말 작업 처리 현황");
		
		// 구분 셀 병합
		sheet6.addMergedRegion(new CellRangeAddress(sheet6_row_count,  sheet6_row_count, 1,  9));
		
		// 구분 셀에 스타일 적용
		style	= wb.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setFillForegroundColor(IndexedColors.AQUA.index);
		style.setFillPattern(XSSFCellStyle.SOLID_FOREGROUND);
		sheet6_gubunCell4.setCellStyle(style);
		
		// 타이틀 로우 생성
		XSSFRow sheet6_titleRow4 	= sheet6.createRow((int) sheet6_row_count + 1);
		sheet6_row_count++;
		
		// 타이틀 셀에 스타일 적용
		style	= wb.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.index);
		style.setFillPattern(XSSFCellStyle.SOLID_FOREGROUND);
		style.setBorderRight(XSSFCellStyle.BORDER_THIN);
		style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
		style.setBorderTop(XSSFCellStyle.BORDER_THIN);
		style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
		
		// 타이틀 로우에 셀 생성 
		XSSFCell sheet6_titleCell4	= sheet6_titleRow4.createCell((int) 1);
		sheet6_titleCell4.setCellValue("No");
		sheet6_titleCell4.setCellStyle(style);
		
		sheet6_titleCell4			= sheet6_titleRow4.createCell((int) 2);
		sheet6_titleCell4.setCellValue("ODATE");
		sheet6_titleCell4.setCellStyle(style);
		
		sheet6_titleCell4			= sheet6_titleRow4.createCell((int) 3);
		sheet6_titleCell4.setCellValue("수행건수");
		sheet6_titleCell4.setCellStyle(style);
		
		sheet6_titleCell4			= sheet6_titleRow4.createCell((int) 4);
		sheet6_titleCell4.setCellValue("처리상태");
		sheet6_titleCell4.setCellStyle(style);
		
		sheet6_titleCell4			= sheet6_titleRow4.createCell((int) 5);
		sheet6_titleCell4.setCellValue("작업명");
		sheet6_titleCell4.setCellStyle(style);
		
		sheet6_titleCell4			= sheet6_titleRow4.createCell((int) 6);
		sheet6_titleCell4.setCellValue("시작시간");
		sheet6_titleCell4.setCellStyle(style);
		
		sheet6_titleCell4			= sheet6_titleRow4.createCell((int) 7);
		sheet6_titleCell4.setCellValue("종료시간");
		sheet6_titleCell4.setCellStyle(style);
		
		sheet6_titleCell4			= sheet6_titleRow4.createCell((int) 8);
		sheet6_titleCell4.setCellValue("수행시간");
		sheet6_titleCell4.setCellStyle(style);
		
		sheet6_titleCell4			= sheet6_titleRow4.createCell((int) 9);
		sheet6_titleCell4.setCellValue("작업설명");
		sheet6_titleCell4.setCellStyle(style);
		
		for( int i=0; null!=jobOpReportAlmList4 && i<jobOpReportAlmList4.size(); i++ ){
			JobLogBean bean = (JobLogBean)jobOpReportAlmList4.get(i);
			
			String strOdate 		= CommonUtil.isNull(bean.getOdate());
			String strJobName 		= CommonUtil.isNull(bean.getJob_name());
			String strOrderTable 	= CommonUtil.isNull(bean.getOrder_table());
			String strApplication 	= CommonUtil.isNull(bean.getApplication());
			String strGroupName 	= CommonUtil.isNull(bean.getGroup_name());
			String strStateResult 	= CommonUtil.isNull(bean.getState_result());
			String strStatus 		= CommonUtil.isNull(bean.getStatus());
			String strStartTime 	= CommonUtil.isNull(CommonUtil.getDateFormat(1,bean.getStart_time(),"-"));
			String strEndTime 		= CommonUtil.isNull(CommonUtil.getDateFormat(1,bean.getEnd_time(),"-"));
			String strRunTime 		= CommonUtil.getDiffTime( CommonUtil.getDateFormat(1,bean.getStart_time()),CommonUtil.getDateFormat(1,bean.getEnd_time()));
			String strDescription	= CommonUtil.isNull(bean.getDescription());
			String strRerunCounter	= CommonUtil.isNull(bean.getRerun_counter());
			
			String strStatusMent = "";
			if ( strStatus.equals("Ended OK") ) {
				strStatusMent = "완료";
			} else if ( strStatus.equals("Ended Not OK") ) {
				strStatusMent = "오류";
			} else if ( strStatus.indexOf("Wait") > -1 ) {
				strStatusMent = "미완료";
			} else if ( !strStatus.equals("Ended OK") && !strStatus.equals("Ended Not OK") && strStatus.indexOf("Wait") == -1 ) {
				strStatusMent = "기타";
			}
			
			XSSFRow sheet6_listRow2 = sheet6.createRow((int) sheet6_row_count + 1);
			sheet6_row_count++;
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			XSSFCell sheet6_listCell2	= sheet6_listRow2.createCell((int) 1);
			sheet6_listCell2.setCellValue((i+1));
			sheet6_listCell2.setCellStyle(style);
			
			sheet6_listCell2	= sheet6_listRow2.createCell((int) 2);
			sheet6_listCell2.setCellValue(strOdate);
			sheet6_listCell2.setCellStyle(style);
			
			sheet6_listCell2	= sheet6_listRow2.createCell((int) 3);
			sheet6_listCell2.setCellValue(strRerunCounter);
			sheet6_listCell2.setCellStyle(style);
			
			sheet6_listCell2	= sheet6_listRow2.createCell((int) 4);
			sheet6_listCell2.setCellValue(strStatusMent);
			sheet6_listCell2.setCellStyle(style);
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			sheet6_listCell2	= sheet6_listRow2.createCell((int) 5);
			sheet6_listCell2.setCellValue(" " + strJobName);			
			sheet6_listCell2.setCellStyle(style);
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			sheet6_listCell2	= sheet6_listRow2.createCell((int) 6);
			sheet6_listCell2.setCellValue(strStartTime);
			sheet6_listCell2.setCellStyle(style);
			
			sheet6_listCell2	= sheet6_listRow2.createCell((int) 7);
			sheet6_listCell2.setCellValue(strEndTime);
			sheet6_listCell2.setCellStyle(style);
			
			sheet6_listCell2	= sheet6_listRow2.createCell((int) 8);
			sheet6_listCell2.setCellValue(strRunTime);
			sheet6_listCell2.setCellStyle(style);
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			sheet6_listCell2	= sheet6_listRow2.createCell((int) 9);
			sheet6_listCell2.setCellValue(" " + strDescription);			
			sheet6_listCell2.setCellStyle(style);
		}
		
		sheet6.setColumnWidth(0, (int)0x200);
		
		for(int i=1; i<=10; i++){
			sheet6.autoSizeColumn(i);
			sheet6.setColumnWidth(i, sheet6.getColumnWidth(i)+700 );
		}
		
		
		
		
		// 시트 생성
		XSSFSheet sheet7 	= wb.createSheet("NEW_RDM");
		
		int sheet7_row_count = 0;
		
		// 문서 제목 로우 생성
		XSSFRow sheet7_nameRow 	= sheet7.createRow((int) sheet7_row_count + 1);
		sheet7_row_count++;
		
		// 문서 제목 로우에 셀 생성
		XSSFCell sheet7_cell	= sheet7_nameRow.createCell((int) 1);
		
		sheet7_cell.setCellValue("<NEW_RDM 작업 처리 현황 " + s_search_odate + " ~  " + e_search_odate + ">");
		
		// 문서 제목 셀에 스타일 적용
		style	= wb.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		sheet7_cell.setCellStyle(style);
		
		// 문서 제목 셀 병합
		sheet7.addMergedRegion(new CellRangeAddress(1,  1, 1,  9));
		
		// 한줄 띄우기
		sheet7.createRow((int) sheet7_row_count + 1);
		sheet7_row_count++;
		
		// 구분 로우 생성
		XSSFRow sheet7_gubunRow 	= sheet7.createRow((int) sheet7_row_count + 1);
		sheet7_row_count++;
		
		// 구분 로우에 셀 생성
		XSSFCell sheet7_gubunCell	= sheet7_gubunRow.createCell((int) 1);
		
		sheet7_gubunCell.setCellValue("작업 의뢰서 처리 현황");
		
		// 구분 셀 병합
		sheet7.addMergedRegion(new CellRangeAddress(3,  3, 1,  9));
		
		// 구분 셀에 스타일 적용
		style	= wb.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setFillForegroundColor(IndexedColors.TEAL.index);
		style.setFillPattern(XSSFCellStyle.SOLID_FOREGROUND);
		sheet7_gubunCell.setCellStyle(style);
		
		// 타이틀 로우 생성
		XSSFRow sheet7_titleRow 	= sheet7.createRow((int) sheet7_row_count + 1);
		sheet7_row_count++;
		
		// 타이틀 셀에 스타일 적용
		style	= wb.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.index);
		style.setFillPattern(XSSFCellStyle.SOLID_FOREGROUND);
		style.setBorderRight(XSSFCellStyle.BORDER_THIN);
		style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
		style.setBorderTop(XSSFCellStyle.BORDER_THIN);
		style.setBorderBottom(XSSFCellStyle.BORDER_THIN);		
		
		// 타이틀 로우에 셀 생성 
		XSSFCell sheet7_titleCell	= sheet7_titleRow.createCell((int) 1);
		sheet7_titleCell.setCellValue("No");
		sheet7_titleCell.setCellStyle(style);
		
		sheet7_titleCell			= sheet7_titleRow.createCell((int) 2);
		sheet7_titleCell.setCellValue("ODATE");
		sheet7_titleCell.setCellStyle(style);
		
		sheet7_titleCell			= sheet7_titleRow.createCell((int) 3);
		sheet7_titleCell.setCellValue("수행건수");
		sheet7_titleCell.setCellStyle(style);
		
		sheet7_titleCell			= sheet7_titleRow.createCell((int) 4);
		sheet7_titleCell.setCellValue("처리상태");
		sheet7_titleCell.setCellStyle(style);
		
		sheet7_titleCell			= sheet7_titleRow.createCell((int) 5);
		sheet7_titleCell.setCellValue("작업명");
		sheet7_titleCell.setCellStyle(style);
		
		sheet7_titleCell			= sheet7_titleRow.createCell((int) 6);
		sheet7_titleCell.setCellValue("시작시간");
		sheet7_titleCell.setCellStyle(style);
		
		sheet7_titleCell			= sheet7_titleRow.createCell((int) 7);
		sheet7_titleCell.setCellValue("종료시간");
		sheet7_titleCell.setCellStyle(style);
		
		sheet7_titleCell			= sheet7_titleRow.createCell((int) 8);
		sheet7_titleCell.setCellValue("수행시간");
		sheet7_titleCell.setCellStyle(style);
		
		sheet7_titleCell			= sheet7_titleRow.createCell((int) 9);
		sheet7_titleCell.setCellValue("작업설명");
		sheet7_titleCell.setCellStyle(style);
		
		for( int i=0; null!=jobOpReportNewRdmList && i<jobOpReportNewRdmList.size(); i++ ){
			JobLogBean bean = (JobLogBean)jobOpReportNewRdmList.get(i);
			
			String strOdate 		= CommonUtil.isNull(bean.getOdate());
			String strJobName 		= CommonUtil.isNull(bean.getJob_name());
			String strOrderTable 	= CommonUtil.isNull(bean.getOrder_table());
			String strApplication 	= CommonUtil.isNull(bean.getApplication());
			String strGroupName 	= CommonUtil.isNull(bean.getGroup_name());
			String strStateResult 	= CommonUtil.isNull(bean.getState_result());
			String strStatus 		= CommonUtil.isNull(bean.getStatus());
			String strStartTime 	= CommonUtil.isNull(CommonUtil.getDateFormat(1,bean.getStart_time(),"-"));
			String strEndTime 		= CommonUtil.isNull(CommonUtil.getDateFormat(1,bean.getEnd_time(),"-;"));
			String strRunTime 		= CommonUtil.getDiffTime( CommonUtil.getDateFormat(1,bean.getStart_time()),CommonUtil.getDateFormat(1,bean.getEnd_time()));
			String strDescription	= CommonUtil.isNull(bean.getDescription());
			String strRerunCounter	= CommonUtil.isNull(bean.getRerun_counter());
			
			String strStatusMent = "";
			if ( strStatus.equals("Ended OK") ) {
				strStatusMent = "완료";
			} else if ( strStatus.equals("Ended Not OK") ) {
				strStatusMent = "오류";
			} else if ( strStatus.indexOf("Wait") > -1 ) {
				strStatusMent = "미완료";
			} else if ( !strStatus.equals("Ended OK") && !strStatus.equals("Ended Not OK") && strStatus.indexOf("Wait") == -1 ) {
				strStatusMent = "기타";
			}
			
			XSSFRow sheet7_listRow = sheet7.createRow((int) sheet7_row_count + 1);
			sheet7_row_count++;
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			XSSFCell sheet7_listCell2	= sheet7_listRow.createCell((int) 1);
			sheet7_listCell2.setCellValue((i+1));
			sheet7_listCell2.setCellStyle(style);
			
			sheet7_listCell2	= sheet7_listRow.createCell((int) 2);
			sheet7_listCell2.setCellValue(strOdate);
			sheet7_listCell2.setCellStyle(style);
			
			sheet7_listCell2	= sheet7_listRow.createCell((int) 3);
			sheet7_listCell2.setCellValue(strRerunCounter);
			sheet7_listCell2.setCellStyle(style);
			
			sheet7_listCell2	= sheet7_listRow.createCell((int) 4);
			sheet7_listCell2.setCellValue(strStatusMent);
			sheet7_listCell2.setCellStyle(style);
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			sheet7_listCell2	= sheet7_listRow.createCell((int) 5);
			sheet7_listCell2.setCellValue(" " + strJobName);			
			sheet7_listCell2.setCellStyle(style);
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			sheet7_listCell2	= sheet7_listRow.createCell((int) 6);
			sheet7_listCell2.setCellValue(strStartTime);
			sheet7_listCell2.setCellStyle(style);
			
			sheet7_listCell2	= sheet7_listRow.createCell((int) 7);
			sheet7_listCell2.setCellValue(strEndTime);
			sheet7_listCell2.setCellStyle(style);
			
			sheet7_listCell2	= sheet7_listRow.createCell((int) 8);
			sheet7_listCell2.setCellValue(strRunTime);
			sheet7_listCell2.setCellStyle(style);
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			sheet7_listCell2	= sheet7_listRow.createCell((int) 9);
			sheet7_listCell2.setCellValue(" " + strDescription);			
			sheet7_listCell2.setCellStyle(style);
		}

		// 한줄 띄우기
		sheet7.createRow((int) sheet7_row_count + 1);
		sheet7_row_count++;
		
		// 한줄 띄우기
		sheet7.createRow((int) sheet7_row_count + 1);
		sheet7_row_count++;
		
		// 구분 로우 생성
		XSSFRow sheet7_gubunRow2 	= sheet7.createRow((int) sheet7_row_count + 1);
		sheet7_row_count++;
		
		// 구분 로우에 셀 생성
		XSSFCell sheet7_gubunCell2	= sheet7_gubunRow2.createCell((int) 1);
		
		sheet7_gubunCell2.setCellValue("정규 작업 처리 현황");
		
		// 구분 셀 병합
		sheet7.addMergedRegion(new CellRangeAddress(sheet7_row_count,  sheet7_row_count, 1,  9));
		
		// 구분 셀에 스타일 적용
		style	= wb.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setFillForegroundColor(IndexedColors.TEAL.index);
		style.setFillPattern(XSSFCellStyle.SOLID_FOREGROUND);
		sheet7_gubunCell2.setCellStyle(style);
		
		// 타이틀 로우 생성
		XSSFRow sheet7_titleRow2 	= sheet7.createRow((int) sheet7_row_count + 1);
		sheet7_row_count++;
		
		// 타이틀 셀에 스타일 적용
		style	= wb.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.index);
		style.setFillPattern(XSSFCellStyle.SOLID_FOREGROUND);
		style.setBorderRight(XSSFCellStyle.BORDER_THIN);
		style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
		style.setBorderTop(XSSFCellStyle.BORDER_THIN);
		style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
		
		// 타이틀 로우에 셀 생성 
		XSSFCell sheet7_titleCell2	= sheet7_titleRow2.createCell((int) 1);
		sheet7_titleCell2.setCellValue("No");
		sheet7_titleCell2.setCellStyle(style);
		
		sheet7_titleCell2			= sheet7_titleRow2.createCell((int) 2);
		sheet7_titleCell2.setCellValue("ODATE");
		sheet7_titleCell2.setCellStyle(style);
		
		sheet7_titleCell2			= sheet7_titleRow2.createCell((int) 3);
		sheet7_titleCell2.setCellValue("수행건수");
		sheet7_titleCell2.setCellStyle(style);
		
		sheet7_titleCell2			= sheet7_titleRow2.createCell((int) 4);
		sheet7_titleCell2.setCellValue("처리상태");
		sheet7_titleCell2.setCellStyle(style);
		
		sheet7_titleCell2			= sheet7_titleRow2.createCell((int) 5);
		sheet7_titleCell2.setCellValue("작업명");
		sheet7_titleCell2.setCellStyle(style);
		
		sheet7_titleCell2			= sheet7_titleRow2.createCell((int) 6);
		sheet7_titleCell2.setCellValue("시작시간");
		sheet7_titleCell2.setCellStyle(style);
		
		sheet7_titleCell2			= sheet7_titleRow2.createCell((int) 7);
		sheet7_titleCell2.setCellValue("종료시간");
		sheet7_titleCell2.setCellStyle(style);
		
		sheet7_titleCell2			= sheet7_titleRow2.createCell((int) 8);
		sheet7_titleCell2.setCellValue("수행시간");
		sheet7_titleCell2.setCellStyle(style);
		
		sheet7_titleCell2			= sheet7_titleRow2.createCell((int) 9);
		sheet7_titleCell2.setCellValue("작업설명");
		sheet7_titleCell2.setCellStyle(style);
		
		for( int i=0; null!=jobOpReportNewRdmList2 && i<jobOpReportNewRdmList2.size(); i++ ){
			JobLogBean bean = (JobLogBean)jobOpReportNewRdmList2.get(i);
			
			String strOdate 		= CommonUtil.isNull(bean.getOdate());
			String strJobName 		= CommonUtil.isNull(bean.getJob_name());
			String strOrderTable 	= CommonUtil.isNull(bean.getOrder_table());
			String strApplication 	= CommonUtil.isNull(bean.getApplication());
			String strGroupName 	= CommonUtil.isNull(bean.getGroup_name());
			String strStateResult 	= CommonUtil.isNull(bean.getState_result());
			String strStatus 		= CommonUtil.isNull(bean.getStatus());
			String strStartTime 	= CommonUtil.isNull(CommonUtil.getDateFormat(1,bean.getStart_time(),"-"));
			String strEndTime 		= CommonUtil.isNull(CommonUtil.getDateFormat(1,bean.getEnd_time(),"-"));
			String strRunTime 		= CommonUtil.getDiffTime( CommonUtil.getDateFormat(1,bean.getStart_time()),CommonUtil.getDateFormat(1,bean.getEnd_time()));
			String strDescription	= CommonUtil.isNull(bean.getDescription());
			String strRerunCounter	= CommonUtil.isNull(bean.getRerun_counter());
			
			String strStatusMent = "";
			if ( strStatus.equals("Ended OK") ) {
				strStatusMent = "완료";
			} else if ( strStatus.equals("Ended Not OK") ) {
				strStatusMent = "오류";
			} else if ( strStatus.indexOf("Wait") > -1 ) {
				strStatusMent = "미완료";
			} else if ( !strStatus.equals("Ended OK") && !strStatus.equals("Ended Not OK") && strStatus.indexOf("Wait") == -1 ) {
				strStatusMent = "기타";
			}
			
			XSSFRow sheet7_listRow2 = sheet7.createRow((int) sheet7_row_count + 1);
			sheet7_row_count++;
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			XSSFCell sheet7_listCell2	= sheet7_listRow2.createCell((int) 1);
			sheet7_listCell2.setCellValue((i+1));
			sheet7_listCell2.setCellStyle(style);
			
			sheet7_listCell2	= sheet7_listRow2.createCell((int) 2);
			sheet7_listCell2.setCellValue(strOdate);
			sheet7_listCell2.setCellStyle(style);
			
			sheet7_listCell2	= sheet7_listRow2.createCell((int) 3);
			sheet7_listCell2.setCellValue(strRerunCounter);
			sheet7_listCell2.setCellStyle(style);
			
			sheet7_listCell2	= sheet7_listRow2.createCell((int) 4);
			sheet7_listCell2.setCellValue(strStatusMent);
			sheet7_listCell2.setCellStyle(style);
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			sheet7_listCell2	= sheet7_listRow2.createCell((int) 5);
			sheet7_listCell2.setCellValue(" " + strJobName);			
			sheet7_listCell2.setCellStyle(style);
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			sheet7_listCell2	= sheet7_listRow2.createCell((int) 6);
			sheet7_listCell2.setCellValue(strStartTime);
			sheet7_listCell2.setCellStyle(style);
			
			sheet7_listCell2	= sheet7_listRow2.createCell((int) 7);
			sheet7_listCell2.setCellValue(strEndTime);
			sheet7_listCell2.setCellStyle(style);
			
			sheet7_listCell2	= sheet7_listRow2.createCell((int) 8);
			sheet7_listCell2.setCellValue(strRunTime);
			sheet7_listCell2.setCellStyle(style);
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			sheet7_listCell2	= sheet7_listRow2.createCell((int) 9);
			sheet7_listCell2.setCellValue(" " + strDescription);			
			sheet7_listCell2.setCellStyle(style);
		}
		
		// 한줄 띄우기
		sheet7.createRow((int) sheet7_row_count + 1);
		sheet7_row_count++;
		
		// 한줄 띄우기
		sheet7.createRow((int) sheet7_row_count + 1);
		sheet7_row_count++;
		
		// 구분 로우 생성
		XSSFRow sheet7_gubunRow3 	= sheet7.createRow((int) sheet7_row_count + 1);
		sheet7_row_count++;
		
		// 구분 로우에 셀 생성
		XSSFCell sheet7_gubunCell3	= sheet7_gubunRow3.createCell((int) 1);
		
		//sheet7_gubunCell3.setCellValue("정규 작업 처리 현황");
		sheet7_gubunCell3.setCellValue("월초 작업 처리 현황");
		
		// 구분 셀 병합
		sheet7.addMergedRegion(new CellRangeAddress(sheet7_row_count,  sheet7_row_count, 1,  9));
		
		// 구분 셀에 스타일 적용
		style	= wb.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setFillForegroundColor(IndexedColors.TEAL.index);
		style.setFillPattern(XSSFCellStyle.SOLID_FOREGROUND);
		sheet7_gubunCell3.setCellStyle(style);
		
		// 타이틀 로우 생성
		XSSFRow sheet7_titleRow3 	= sheet7.createRow((int) sheet7_row_count + 1);
		sheet7_row_count++;
		
		// 타이틀 셀에 스타일 적용
		style	= wb.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.index);
		style.setFillPattern(XSSFCellStyle.SOLID_FOREGROUND);
		style.setBorderRight(XSSFCellStyle.BORDER_THIN);
		style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
		style.setBorderTop(XSSFCellStyle.BORDER_THIN);
		style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
		
		// 타이틀 로우에 셀 생성 
		XSSFCell sheet7_titleCell3	= sheet7_titleRow3.createCell((int) 1);
		sheet7_titleCell3.setCellValue("No");
		sheet7_titleCell3.setCellStyle(style);
		
		sheet7_titleCell3			= sheet7_titleRow3.createCell((int) 2);
		sheet7_titleCell3.setCellValue("ODATE");
		sheet7_titleCell3.setCellStyle(style);
		
		sheet7_titleCell3			= sheet7_titleRow3.createCell((int) 3);
		sheet7_titleCell3.setCellValue("수행건수");
		sheet7_titleCell3.setCellStyle(style);
		
		sheet7_titleCell3			= sheet7_titleRow3.createCell((int) 4);
		sheet7_titleCell3.setCellValue("처리상태");
		sheet7_titleCell3.setCellStyle(style);
		
		sheet7_titleCell3			= sheet7_titleRow3.createCell((int) 5);
		sheet7_titleCell3.setCellValue("작업명");
		sheet7_titleCell3.setCellStyle(style);
		
		sheet7_titleCell3			= sheet7_titleRow3.createCell((int) 6);
		sheet7_titleCell3.setCellValue("시작시간");
		sheet7_titleCell3.setCellStyle(style);
		
		sheet7_titleCell3			= sheet7_titleRow3.createCell((int) 7);
		sheet7_titleCell3.setCellValue("종료시간");
		sheet7_titleCell3.setCellStyle(style);
		
		sheet7_titleCell3			= sheet7_titleRow3.createCell((int) 8);
		sheet7_titleCell3.setCellValue("수행시간");
		sheet7_titleCell3.setCellStyle(style);
		
		sheet7_titleCell3			= sheet7_titleRow3.createCell((int) 9);
		sheet7_titleCell3.setCellValue("작업설명");
		sheet7_titleCell3.setCellStyle(style);
		
		for( int i=0; null!=jobOpReportNewRdmList3 && i<jobOpReportNewRdmList3.size(); i++ ){
			JobLogBean bean = (JobLogBean)jobOpReportNewRdmList3.get(i);
			
			String strOdate 		= CommonUtil.isNull(bean.getOdate());
			String strJobName 		= CommonUtil.isNull(bean.getJob_name());
			String strOrderTable 	= CommonUtil.isNull(bean.getOrder_table());
			String strApplication 	= CommonUtil.isNull(bean.getApplication());
			String strGroupName 	= CommonUtil.isNull(bean.getGroup_name());
			String strStateResult 	= CommonUtil.isNull(bean.getState_result());
			String strStatus 		= CommonUtil.isNull(bean.getStatus());
			String strStartTime 	= CommonUtil.isNull(CommonUtil.getDateFormat(1,bean.getStart_time(),"-"));
			String strEndTime 		= CommonUtil.isNull(CommonUtil.getDateFormat(1,bean.getEnd_time(),"-"));
			String strRunTime 		= CommonUtil.getDiffTime( CommonUtil.getDateFormat(1,bean.getStart_time()),CommonUtil.getDateFormat(1,bean.getEnd_time()));
			String strDescription	= CommonUtil.isNull(bean.getDescription());
			String strRerunCounter	= CommonUtil.isNull(bean.getRerun_counter());
			
			String strStatusMent = "";
			if ( strStatus.equals("Ended OK") ) {
				strStatusMent = "완료";
			} else if ( strStatus.equals("Ended Not OK") ) {
				strStatusMent = "오류";
			} else if ( strStatus.indexOf("Wait") > -1 ) {
				strStatusMent = "미완료";
			} else if ( !strStatus.equals("Ended OK") && !strStatus.equals("Ended Not OK") && strStatus.indexOf("Wait") == -1 ) {
				strStatusMent = "기타";
			}
			
			XSSFRow sheet7_listRow2 = sheet7.createRow((int) sheet7_row_count + 1);
			sheet7_row_count++;
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			XSSFCell sheet7_listCell2	= sheet7_listRow2.createCell((int) 1);
			sheet7_listCell2.setCellValue((i+1));
			sheet7_listCell2.setCellStyle(style);
			
			sheet7_listCell2	= sheet7_listRow2.createCell((int) 2);
			sheet7_listCell2.setCellValue(strOdate);
			sheet7_listCell2.setCellStyle(style);
			
			sheet7_listCell2	= sheet7_listRow2.createCell((int) 3);
			sheet7_listCell2.setCellValue(strRerunCounter);
			sheet7_listCell2.setCellStyle(style);
			
			sheet7_listCell2	= sheet7_listRow2.createCell((int) 4);
			sheet7_listCell2.setCellValue(strStatusMent);
			sheet7_listCell2.setCellStyle(style);
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			sheet7_listCell2	= sheet7_listRow2.createCell((int) 5);
			sheet7_listCell2.setCellValue(" " + strJobName);			
			sheet7_listCell2.setCellStyle(style);
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			sheet7_listCell2	= sheet7_listRow2.createCell((int) 6);
			sheet7_listCell2.setCellValue(strStartTime);
			sheet7_listCell2.setCellStyle(style);
			
			sheet7_listCell2	= sheet7_listRow2.createCell((int) 7);
			sheet7_listCell2.setCellValue(strEndTime);
			sheet7_listCell2.setCellStyle(style);
			
			sheet7_listCell2	= sheet7_listRow2.createCell((int) 8);
			sheet7_listCell2.setCellValue(strRunTime);
			sheet7_listCell2.setCellStyle(style);
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			sheet7_listCell2	= sheet7_listRow2.createCell((int) 9);
			sheet7_listCell2.setCellValue(" " + strDescription);			
			sheet7_listCell2.setCellStyle(style);
		}
		
		// 한줄 띄우기
		sheet7.createRow((int) sheet7_row_count + 1);
		sheet7_row_count++;
		
		// 한줄 띄우기
		sheet7.createRow((int) sheet7_row_count + 1);
		sheet7_row_count++;
		
		// 구분 로우 생성
		XSSFRow sheet7_gubunRow4 	= sheet7.createRow((int) sheet7_row_count + 1);
		sheet7_row_count++;
		
		// 구분 로우에 셀 생성
		XSSFCell sheet7_gubunCell4	= sheet7_gubunRow4.createCell((int) 1);
		
		//sheet7_gubunCell4.setCellValue("정규 작업 처리 현황");
		sheet7_gubunCell4.setCellValue("월말 작업 처리 현황");
		
		// 구분 셀 병합
		sheet7.addMergedRegion(new CellRangeAddress(sheet7_row_count,  sheet7_row_count, 1,  9));
		
		// 구분 셀에 스타일 적용
		style	= wb.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setFillForegroundColor(IndexedColors.TEAL.index);
		style.setFillPattern(XSSFCellStyle.SOLID_FOREGROUND);
		sheet7_gubunCell4.setCellStyle(style);
		
		// 타이틀 로우 생성
		XSSFRow sheet7_titleRow4 	= sheet7.createRow((int) sheet7_row_count + 1);
		sheet7_row_count++;
		
		// 타이틀 셀에 스타일 적용
		style	= wb.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.index);
		style.setFillPattern(XSSFCellStyle.SOLID_FOREGROUND);
		style.setBorderRight(XSSFCellStyle.BORDER_THIN);
		style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
		style.setBorderTop(XSSFCellStyle.BORDER_THIN);
		style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
		
		// 타이틀 로우에 셀 생성 
		XSSFCell sheet7_titleCell4	= sheet7_titleRow4.createCell((int) 1);
		sheet7_titleCell4.setCellValue("No");
		sheet7_titleCell4.setCellStyle(style);
		
		sheet7_titleCell4			= sheet7_titleRow4.createCell((int) 2);
		sheet7_titleCell4.setCellValue("ODATE");
		sheet7_titleCell4.setCellStyle(style);
		
		sheet7_titleCell4			= sheet7_titleRow4.createCell((int) 3);
		sheet7_titleCell4.setCellValue("수행건수");
		sheet7_titleCell4.setCellStyle(style);
		
		sheet7_titleCell4			= sheet7_titleRow4.createCell((int) 4);
		sheet7_titleCell4.setCellValue("처리상태");
		sheet7_titleCell4.setCellStyle(style);
		
		sheet7_titleCell4			= sheet7_titleRow4.createCell((int) 5);
		sheet7_titleCell4.setCellValue("작업명");
		sheet7_titleCell4.setCellStyle(style);
		
		sheet7_titleCell4			= sheet7_titleRow4.createCell((int) 6);
		sheet7_titleCell4.setCellValue("시작시간");
		sheet7_titleCell4.setCellStyle(style);
		
		sheet7_titleCell4			= sheet7_titleRow4.createCell((int) 7);
		sheet7_titleCell4.setCellValue("종료시간");
		sheet7_titleCell4.setCellStyle(style);
		
		sheet7_titleCell4			= sheet7_titleRow4.createCell((int) 8);
		sheet7_titleCell4.setCellValue("수행시간");
		sheet7_titleCell4.setCellStyle(style);
		
		sheet7_titleCell4			= sheet7_titleRow4.createCell((int) 9);
		sheet7_titleCell4.setCellValue("작업설명");
		sheet7_titleCell4.setCellStyle(style);
		
		for( int i=0; null!=jobOpReportNewRdmList4 && i<jobOpReportNewRdmList4.size(); i++ ){
			JobLogBean bean = (JobLogBean)jobOpReportNewRdmList4.get(i);
			
			String strOdate 		= CommonUtil.isNull(bean.getOdate());
			String strJobName 		= CommonUtil.isNull(bean.getJob_name());
			String strOrderTable 	= CommonUtil.isNull(bean.getOrder_table());
			String strApplication 	= CommonUtil.isNull(bean.getApplication());
			String strGroupName 	= CommonUtil.isNull(bean.getGroup_name());
			String strStateResult 	= CommonUtil.isNull(bean.getState_result());
			String strStatus 		= CommonUtil.isNull(bean.getStatus());
			String strStartTime 	= CommonUtil.isNull(CommonUtil.getDateFormat(1,bean.getStart_time(),"-"));
			String strEndTime 		= CommonUtil.isNull(CommonUtil.getDateFormat(1,bean.getEnd_time(),"-"));
			String strRunTime 		= CommonUtil.getDiffTime( CommonUtil.getDateFormat(1,bean.getStart_time()),CommonUtil.getDateFormat(1,bean.getEnd_time()));
			String strDescription	= CommonUtil.isNull(bean.getDescription());
			String strRerunCounter	= CommonUtil.isNull(bean.getRerun_counter());
			
			String strStatusMent = "";
			if ( strStatus.equals("Ended OK") ) {
				strStatusMent = "완료";
			} else if ( strStatus.equals("Ended Not OK") ) {
				strStatusMent = "오류";
			} else if ( strStatus.indexOf("Wait") > -1 ) {
				strStatusMent = "미완료";
			} else if ( !strStatus.equals("Ended OK") && !strStatus.equals("Ended Not OK") && strStatus.indexOf("Wait") == -1 ) {
				strStatusMent = "기타";
			}
			
			XSSFRow sheet7_listRow2 = sheet7.createRow((int) sheet7_row_count + 1);
			sheet7_row_count++;
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			XSSFCell sheet7_listCell2	= sheet7_listRow2.createCell((int) 1);
			sheet7_listCell2.setCellValue((i+1));
			sheet7_listCell2.setCellStyle(style);
			
			sheet7_listCell2	= sheet7_listRow2.createCell((int) 2);
			sheet7_listCell2.setCellValue(strOdate);
			sheet7_listCell2.setCellStyle(style);
			
			sheet7_listCell2	= sheet7_listRow2.createCell((int) 3);
			sheet7_listCell2.setCellValue(strRerunCounter);
			sheet7_listCell2.setCellStyle(style);
			
			sheet7_listCell2	= sheet7_listRow2.createCell((int) 4);
			sheet7_listCell2.setCellValue(strStatusMent);
			sheet7_listCell2.setCellStyle(style);
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			sheet7_listCell2	= sheet7_listRow2.createCell((int) 5);
			sheet7_listCell2.setCellValue(" " + strJobName);			
			sheet7_listCell2.setCellStyle(style);
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			sheet7_listCell2	= sheet7_listRow2.createCell((int) 6);
			sheet7_listCell2.setCellValue(strStartTime);
			sheet7_listCell2.setCellStyle(style);
			
			sheet7_listCell2	= sheet7_listRow2.createCell((int) 7);
			sheet7_listCell2.setCellValue(strEndTime);
			sheet7_listCell2.setCellStyle(style);
			
			sheet7_listCell2	= sheet7_listRow2.createCell((int) 8);
			sheet7_listCell2.setCellValue(strRunTime);
			sheet7_listCell2.setCellStyle(style);
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			sheet7_listCell2	= sheet7_listRow2.createCell((int) 9);
			sheet7_listCell2.setCellValue(" " + strDescription);			
			sheet7_listCell2.setCellStyle(style);
		}
		
		sheet7.setColumnWidth(0, (int)0x200);
		
		for(int i=1; i<=10; i++){
			sheet7.autoSizeColumn(i);
			sheet7.setColumnWidth(i, sheet7.getColumnWidth(i)+700 );
		}
		
		
		
		
		
		// 시트 생성
		XSSFSheet sheet8 	= wb.createSheet("RBA");
		
		int sheet8_row_count = 0;
		
		// 문서 제목 로우 생성
		XSSFRow sheet8_nameRow 	= sheet8.createRow((int) sheet8_row_count + 1);
		sheet8_row_count++;
		
		// 문서 제목 로우에 셀 생성
		XSSFCell sheet8_cell	= sheet8_nameRow.createCell((int) 1);
		
		sheet8_cell.setCellValue("<RBA 작업 처리 현황 " + s_search_odate + " ~  " + e_search_odate + ">");
		
		// 문서 제목 셀에 스타일 적용
		style	= wb.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		sheet8_cell.setCellStyle(style);
		
		// 문서 제목 셀 병합
		sheet8.addMergedRegion(new CellRangeAddress(1,  1, 1,  9));
		
		// 한줄 띄우기
		sheet8.createRow((int) sheet8_row_count + 1);
		sheet8_row_count++;
		
		// 구분 로우 생성
		XSSFRow sheet8_gubunRow 	= sheet8.createRow((int) sheet8_row_count + 1);
		sheet8_row_count++;
		
		// 구분 로우에 셀 생성
		XSSFCell sheet8_gubunCell	= sheet8_gubunRow.createCell((int) 1);
		
		sheet8_gubunCell.setCellValue("작업 의뢰서 처리 현황");
		
		// 구분 셀 병합
		sheet8.addMergedRegion(new CellRangeAddress(3,  3, 1,  9));
		
		// 구분 셀에 스타일 적용
		style	= wb.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setFillForegroundColor(IndexedColors.LEMON_CHIFFON.index);
		style.setFillPattern(XSSFCellStyle.SOLID_FOREGROUND);
		sheet8_gubunCell.setCellStyle(style);
		
		// 타이틀 로우 생성
		XSSFRow sheet8_titleRow 	= sheet8.createRow((int) sheet8_row_count + 1);
		sheet8_row_count++;
		
		// 타이틀 셀에 스타일 적용
		style	= wb.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.index);
		style.setFillPattern(XSSFCellStyle.SOLID_FOREGROUND);
		style.setBorderRight(XSSFCellStyle.BORDER_THIN);
		style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
		style.setBorderTop(XSSFCellStyle.BORDER_THIN);
		style.setBorderBottom(XSSFCellStyle.BORDER_THIN);		
		
		// 타이틀 로우에 셀 생성 
		XSSFCell sheet8_titleCell	= sheet8_titleRow.createCell((int) 1);
		sheet8_titleCell.setCellValue("No");
		sheet8_titleCell.setCellStyle(style);
		
		sheet8_titleCell			= sheet8_titleRow.createCell((int) 2);
		sheet8_titleCell.setCellValue("ODATE");
		sheet8_titleCell.setCellStyle(style);
		
		sheet8_titleCell			= sheet8_titleRow.createCell((int) 3);
		sheet8_titleCell.setCellValue("수행건수");
		sheet8_titleCell.setCellStyle(style);
		
		sheet8_titleCell			= sheet8_titleRow.createCell((int) 4);
		sheet8_titleCell.setCellValue("처리상태");
		sheet8_titleCell.setCellStyle(style);
		
		sheet8_titleCell			= sheet8_titleRow.createCell((int) 5);
		sheet8_titleCell.setCellValue("작업명");
		sheet8_titleCell.setCellStyle(style);
		
		sheet8_titleCell			= sheet8_titleRow.createCell((int) 6);
		sheet8_titleCell.setCellValue("시작시간");
		sheet8_titleCell.setCellStyle(style);
		
		sheet8_titleCell			= sheet8_titleRow.createCell((int) 7);
		sheet8_titleCell.setCellValue("종료시간");
		sheet8_titleCell.setCellStyle(style);
		
		sheet8_titleCell			= sheet8_titleRow.createCell((int) 8);
		sheet8_titleCell.setCellValue("수행시간");
		sheet8_titleCell.setCellStyle(style);
		
		sheet8_titleCell			= sheet8_titleRow.createCell((int) 9);
		sheet8_titleCell.setCellValue("작업설명");
		sheet8_titleCell.setCellStyle(style);
		
		for( int i=0; null!=jobOpReportRbaList && i<jobOpReportRbaList.size(); i++ ){
			JobLogBean bean = (JobLogBean)jobOpReportRbaList.get(i);
			
			String strOdate 		= CommonUtil.isNull(bean.getOdate());
			String strJobName 		= CommonUtil.isNull(bean.getJob_name());
			String strOrderTable 	= CommonUtil.isNull(bean.getOrder_table());
			String strApplication 	= CommonUtil.isNull(bean.getApplication());
			String strGroupName 	= CommonUtil.isNull(bean.getGroup_name());
			String strStateResult 	= CommonUtil.isNull(bean.getState_result());
			String strStatus 		= CommonUtil.isNull(bean.getStatus());
			String strStartTime 	= CommonUtil.isNull(CommonUtil.getDateFormat(1,bean.getStart_time(),"-"));
			String strEndTime 		= CommonUtil.isNull(CommonUtil.getDateFormat(1,bean.getEnd_time(),"-;"));
			String strRunTime 		= CommonUtil.getDiffTime( CommonUtil.getDateFormat(1,bean.getStart_time()),CommonUtil.getDateFormat(1,bean.getEnd_time()));
			String strDescription	= CommonUtil.isNull(bean.getDescription());
			String strRerunCounter	= CommonUtil.isNull(bean.getRerun_counter());
			
			String strStatusMent = "";
			if ( strStatus.equals("Ended OK") ) {
				strStatusMent = "완료";
			} else if ( strStatus.equals("Ended Not OK") ) {
				strStatusMent = "오류";
			} else if ( strStatus.indexOf("Wait") > -1 ) {
				strStatusMent = "미완료";
			} else if ( !strStatus.equals("Ended OK") && !strStatus.equals("Ended Not OK") && strStatus.indexOf("Wait") == -1 ) {
				strStatusMent = "기타";
			}
			
			XSSFRow sheet8_listRow = sheet8.createRow((int) sheet8_row_count + 1);
			sheet8_row_count++;
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			XSSFCell sheet8_listCell2	= sheet8_listRow.createCell((int) 1);
			sheet8_listCell2.setCellValue((i+1));
			sheet8_listCell2.setCellStyle(style);
			
			sheet8_listCell2	= sheet8_listRow.createCell((int) 2);
			sheet8_listCell2.setCellValue(strOdate);
			sheet8_listCell2.setCellStyle(style);
			
			sheet8_listCell2	= sheet8_listRow.createCell((int) 3);
			sheet8_listCell2.setCellValue(strRerunCounter);
			sheet8_listCell2.setCellStyle(style);
			
			sheet8_listCell2	= sheet8_listRow.createCell((int) 4);
			sheet8_listCell2.setCellValue(strStatusMent);
			sheet8_listCell2.setCellStyle(style);
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			sheet8_listCell2	= sheet8_listRow.createCell((int) 5);
			sheet8_listCell2.setCellValue(" " + strJobName);			
			sheet8_listCell2.setCellStyle(style);
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			sheet8_listCell2	= sheet8_listRow.createCell((int) 6);
			sheet8_listCell2.setCellValue(strStartTime);
			sheet8_listCell2.setCellStyle(style);
			
			sheet8_listCell2	= sheet8_listRow.createCell((int) 7);
			sheet8_listCell2.setCellValue(strEndTime);
			sheet8_listCell2.setCellStyle(style);
			
			sheet8_listCell2	= sheet8_listRow.createCell((int) 8);
			sheet8_listCell2.setCellValue(strRunTime);
			sheet8_listCell2.setCellStyle(style);
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			sheet8_listCell2	= sheet8_listRow.createCell((int) 9);
			sheet8_listCell2.setCellValue(" " + strDescription);			
			sheet8_listCell2.setCellStyle(style);
		}

		// 한줄 띄우기
		sheet8.createRow((int) sheet8_row_count + 1);
		sheet8_row_count++;
		
		// 한줄 띄우기
		sheet8.createRow((int) sheet8_row_count + 1);
		sheet8_row_count++;
		
		// 구분 로우 생성
		XSSFRow sheet8_gubunRow2 	= sheet8.createRow((int) sheet8_row_count + 1);
		sheet8_row_count++;
		
		// 구분 로우에 셀 생성
		XSSFCell sheet8_gubunCell2	= sheet8_gubunRow2.createCell((int) 1);
		
		sheet8_gubunCell2.setCellValue("정규 작업 처리 현황");
		
		// 구분 셀 병합
		sheet8.addMergedRegion(new CellRangeAddress(sheet8_row_count,  sheet8_row_count, 1,  9));
		
		// 구분 셀에 스타일 적용
		style	= wb.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setFillForegroundColor(IndexedColors.LEMON_CHIFFON.index);
		style.setFillPattern(XSSFCellStyle.SOLID_FOREGROUND);
		sheet8_gubunCell2.setCellStyle(style);
		
		// 타이틀 로우 생성
		XSSFRow sheet8_titleRow2 	= sheet8.createRow((int) sheet8_row_count + 1);
		sheet8_row_count++;
		
		// 타이틀 셀에 스타일 적용
		style	= wb.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.index);
		style.setFillPattern(XSSFCellStyle.SOLID_FOREGROUND);
		style.setBorderRight(XSSFCellStyle.BORDER_THIN);
		style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
		style.setBorderTop(XSSFCellStyle.BORDER_THIN);
		style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
		
		// 타이틀 로우에 셀 생성 
		XSSFCell sheet8_titleCell2	= sheet8_titleRow2.createCell((int) 1);
		sheet8_titleCell2.setCellValue("No");
		sheet8_titleCell2.setCellStyle(style);
		
		sheet8_titleCell2			= sheet8_titleRow2.createCell((int) 2);
		sheet8_titleCell2.setCellValue("ODATE");
		sheet8_titleCell2.setCellStyle(style);
		
		sheet8_titleCell2			= sheet8_titleRow2.createCell((int) 3);
		sheet8_titleCell2.setCellValue("수행건수");
		sheet8_titleCell2.setCellStyle(style);
		
		sheet8_titleCell2			= sheet8_titleRow2.createCell((int) 4);
		sheet8_titleCell2.setCellValue("처리상태");
		sheet8_titleCell2.setCellStyle(style);
		
		sheet8_titleCell2			= sheet8_titleRow2.createCell((int) 5);
		sheet8_titleCell2.setCellValue("작업명");
		sheet8_titleCell2.setCellStyle(style);
		
		sheet8_titleCell2			= sheet8_titleRow2.createCell((int) 6);
		sheet8_titleCell2.setCellValue("시작시간");
		sheet8_titleCell2.setCellStyle(style);
		
		sheet8_titleCell2			= sheet8_titleRow2.createCell((int) 7);
		sheet8_titleCell2.setCellValue("종료시간");
		sheet8_titleCell2.setCellStyle(style);
		
		sheet8_titleCell2			= sheet8_titleRow2.createCell((int) 8);
		sheet8_titleCell2.setCellValue("수행시간");
		sheet8_titleCell2.setCellStyle(style);
		
		sheet8_titleCell2			= sheet8_titleRow2.createCell((int) 9);
		sheet8_titleCell2.setCellValue("작업설명");
		sheet8_titleCell2.setCellStyle(style);
		
		for( int i=0; null!=jobOpReportRbaList2 && i<jobOpReportRbaList2.size(); i++ ){
			JobLogBean bean = (JobLogBean)jobOpReportRbaList2.get(i);
			
			String strOdate 		= CommonUtil.isNull(bean.getOdate());
			String strJobName 		= CommonUtil.isNull(bean.getJob_name());
			String strOrderTable 	= CommonUtil.isNull(bean.getOrder_table());
			String strApplication 	= CommonUtil.isNull(bean.getApplication());
			String strGroupName 	= CommonUtil.isNull(bean.getGroup_name());
			String strStateResult 	= CommonUtil.isNull(bean.getState_result());
			String strStatus 		= CommonUtil.isNull(bean.getStatus());
			String strStartTime 	= CommonUtil.isNull(CommonUtil.getDateFormat(1,bean.getStart_time(),"-"));
			String strEndTime 		= CommonUtil.isNull(CommonUtil.getDateFormat(1,bean.getEnd_time(),"-"));
			String strRunTime 		= CommonUtil.getDiffTime( CommonUtil.getDateFormat(1,bean.getStart_time()),CommonUtil.getDateFormat(1,bean.getEnd_time()));
			String strDescription	= CommonUtil.isNull(bean.getDescription());
			String strRerunCounter	= CommonUtil.isNull(bean.getRerun_counter());
			
			String strStatusMent = "";
			if ( strStatus.equals("Ended OK") ) {
				strStatusMent = "완료";
			} else if ( strStatus.equals("Ended Not OK") ) {
				strStatusMent = "오류";
			} else if ( strStatus.indexOf("Wait") > -1 ) {
				strStatusMent = "미완료";
			} else if ( !strStatus.equals("Ended OK") && !strStatus.equals("Ended Not OK") && strStatus.indexOf("Wait") == -1 ) {
				strStatusMent = "기타";
			}
			
			XSSFRow sheet8_listRow2 = sheet8.createRow((int) sheet8_row_count + 1);
			sheet8_row_count++;
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			XSSFCell sheet8_listCell2	= sheet8_listRow2.createCell((int) 1);
			sheet8_listCell2.setCellValue((i+1));
			sheet8_listCell2.setCellStyle(style);
			
			sheet8_listCell2	= sheet8_listRow2.createCell((int) 2);
			sheet8_listCell2.setCellValue(strOdate);
			sheet8_listCell2.setCellStyle(style);
			
			sheet8_listCell2	= sheet8_listRow2.createCell((int) 3);
			sheet8_listCell2.setCellValue(strRerunCounter);
			sheet8_listCell2.setCellStyle(style);
			
			sheet8_listCell2	= sheet8_listRow2.createCell((int) 4);
			sheet8_listCell2.setCellValue(strStatusMent);
			sheet8_listCell2.setCellStyle(style);
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			sheet8_listCell2	= sheet8_listRow2.createCell((int) 5);
			sheet8_listCell2.setCellValue(" " + strJobName);			
			sheet8_listCell2.setCellStyle(style);
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			sheet8_listCell2	= sheet8_listRow2.createCell((int) 6);
			sheet8_listCell2.setCellValue(strStartTime);
			sheet8_listCell2.setCellStyle(style);
			
			sheet8_listCell2	= sheet8_listRow2.createCell((int) 7);
			sheet8_listCell2.setCellValue(strEndTime);
			sheet8_listCell2.setCellStyle(style);
			
			sheet8_listCell2	= sheet8_listRow2.createCell((int) 8);
			sheet8_listCell2.setCellValue(strRunTime);
			sheet8_listCell2.setCellStyle(style);
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			sheet8_listCell2	= sheet8_listRow2.createCell((int) 9);
			sheet8_listCell2.setCellValue(" " + strDescription);			
			sheet8_listCell2.setCellStyle(style);
		}
		
		// 한줄 띄우기
		sheet8.createRow((int) sheet8_row_count + 1);
		sheet8_row_count++;
		
		// 한줄 띄우기
		sheet8.createRow((int) sheet8_row_count + 1);
		sheet8_row_count++;
		
		// 구분 로우 생성
		XSSFRow sheet8_gubunRow3 	= sheet8.createRow((int) sheet8_row_count + 1);
		sheet8_row_count++;
		
		// 구분 로우에 셀 생성
		XSSFCell sheet8_gubunCell3	= sheet8_gubunRow3.createCell((int) 1);
		
		//sheet8_gubunCell3.setCellValue("정규 작업 처리 현황");
		sheet8_gubunCell3.setCellValue("월초 작업 처리 현황");
		
		// 구분 셀 병합
		sheet8.addMergedRegion(new CellRangeAddress(sheet8_row_count,  sheet8_row_count, 1,  9));
		
		// 구분 셀에 스타일 적용
		style	= wb.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setFillForegroundColor(IndexedColors.LEMON_CHIFFON.index);
		style.setFillPattern(XSSFCellStyle.SOLID_FOREGROUND);
		sheet8_gubunCell3.setCellStyle(style);
		
		// 타이틀 로우 생성
		XSSFRow sheet8_titleRow3 	= sheet8.createRow((int) sheet8_row_count + 1);
		sheet8_row_count++;
		
		// 타이틀 셀에 스타일 적용
		style	= wb.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.index);
		style.setFillPattern(XSSFCellStyle.SOLID_FOREGROUND);
		style.setBorderRight(XSSFCellStyle.BORDER_THIN);
		style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
		style.setBorderTop(XSSFCellStyle.BORDER_THIN);
		style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
		
		// 타이틀 로우에 셀 생성 
		XSSFCell sheet8_titleCell3	= sheet8_titleRow3.createCell((int) 1);
		sheet8_titleCell3.setCellValue("No");
		sheet8_titleCell3.setCellStyle(style);
		
		sheet8_titleCell3			= sheet8_titleRow3.createCell((int) 2);
		sheet8_titleCell3.setCellValue("ODATE");
		sheet8_titleCell3.setCellStyle(style);
		
		sheet8_titleCell3			= sheet8_titleRow3.createCell((int) 3);
		sheet8_titleCell3.setCellValue("수행건수");
		sheet8_titleCell3.setCellStyle(style);
		
		sheet8_titleCell3			= sheet8_titleRow3.createCell((int) 4);
		sheet8_titleCell3.setCellValue("처리상태");
		sheet8_titleCell3.setCellStyle(style);
		
		sheet8_titleCell3			= sheet8_titleRow3.createCell((int) 5);
		sheet8_titleCell3.setCellValue("작업명");
		sheet8_titleCell3.setCellStyle(style);
		
		sheet8_titleCell3			= sheet8_titleRow3.createCell((int) 6);
		sheet8_titleCell3.setCellValue("시작시간");
		sheet8_titleCell3.setCellStyle(style);
		
		sheet8_titleCell3			= sheet8_titleRow3.createCell((int) 7);
		sheet8_titleCell3.setCellValue("종료시간");
		sheet8_titleCell3.setCellStyle(style);
		
		sheet8_titleCell3			= sheet8_titleRow3.createCell((int) 8);
		sheet8_titleCell3.setCellValue("수행시간");
		sheet8_titleCell3.setCellStyle(style);
		
		sheet8_titleCell3			= sheet8_titleRow3.createCell((int) 9);
		sheet8_titleCell3.setCellValue("작업설명");
		sheet8_titleCell3.setCellStyle(style);
		
		for( int i=0; null!=jobOpReportRbaList3 && i<jobOpReportRbaList3.size(); i++ ){
			JobLogBean bean = (JobLogBean)jobOpReportRbaList3.get(i);
			
			String strOdate 		= CommonUtil.isNull(bean.getOdate());
			String strJobName 		= CommonUtil.isNull(bean.getJob_name());
			String strOrderTable 	= CommonUtil.isNull(bean.getOrder_table());
			String strApplication 	= CommonUtil.isNull(bean.getApplication());
			String strGroupName 	= CommonUtil.isNull(bean.getGroup_name());
			String strStateResult 	= CommonUtil.isNull(bean.getState_result());
			String strStatus 		= CommonUtil.isNull(bean.getStatus());
			String strStartTime 	= CommonUtil.isNull(CommonUtil.getDateFormat(1,bean.getStart_time(),"-"));
			String strEndTime 		= CommonUtil.isNull(CommonUtil.getDateFormat(1,bean.getEnd_time(),"-"));
			String strRunTime 		= CommonUtil.getDiffTime( CommonUtil.getDateFormat(1,bean.getStart_time()),CommonUtil.getDateFormat(1,bean.getEnd_time()));
			String strDescription	= CommonUtil.isNull(bean.getDescription());
			String strRerunCounter	= CommonUtil.isNull(bean.getRerun_counter());
			
			String strStatusMent = "";
			if ( strStatus.equals("Ended OK") ) {
				strStatusMent = "완료";
			} else if ( strStatus.equals("Ended Not OK") ) {
				strStatusMent = "오류";
			} else if ( strStatus.indexOf("Wait") > -1 ) {
				strStatusMent = "미완료";
			} else if ( !strStatus.equals("Ended OK") && !strStatus.equals("Ended Not OK") && strStatus.indexOf("Wait") == -1 ) {
				strStatusMent = "기타";
			}
			
			XSSFRow sheet8_listRow2 = sheet8.createRow((int) sheet8_row_count + 1);
			sheet8_row_count++;
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			XSSFCell sheet8_listCell2	= sheet8_listRow2.createCell((int) 1);
			sheet8_listCell2.setCellValue((i+1));
			sheet8_listCell2.setCellStyle(style);
			
			sheet8_listCell2	= sheet8_listRow2.createCell((int) 2);
			sheet8_listCell2.setCellValue(strOdate);
			sheet8_listCell2.setCellStyle(style);
			
			sheet8_listCell2	= sheet8_listRow2.createCell((int) 3);
			sheet8_listCell2.setCellValue(strRerunCounter);
			sheet8_listCell2.setCellStyle(style);
			
			sheet8_listCell2	= sheet8_listRow2.createCell((int) 4);
			sheet8_listCell2.setCellValue(strStatusMent);
			sheet8_listCell2.setCellStyle(style);
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			sheet8_listCell2	= sheet8_listRow2.createCell((int) 5);
			sheet8_listCell2.setCellValue(" " + strJobName);			
			sheet8_listCell2.setCellStyle(style);
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			sheet8_listCell2	= sheet8_listRow2.createCell((int) 6);
			sheet8_listCell2.setCellValue(strStartTime);
			sheet8_listCell2.setCellStyle(style);
			
			sheet8_listCell2	= sheet8_listRow2.createCell((int) 7);
			sheet8_listCell2.setCellValue(strEndTime);
			sheet8_listCell2.setCellStyle(style);
			
			sheet8_listCell2	= sheet8_listRow2.createCell((int) 8);
			sheet8_listCell2.setCellValue(strRunTime);
			sheet8_listCell2.setCellStyle(style);
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			sheet8_listCell2	= sheet8_listRow2.createCell((int) 9);
			sheet8_listCell2.setCellValue(" " + strDescription);			
			sheet8_listCell2.setCellStyle(style);
		}
		
		// 한줄 띄우기
		sheet8.createRow((int) sheet8_row_count + 1);
		sheet8_row_count++;
		
		// 한줄 띄우기
		sheet8.createRow((int) sheet8_row_count + 1);
		sheet8_row_count++;
		
		// 구분 로우 생성
		XSSFRow sheet8_gubunRow4 	= sheet8.createRow((int) sheet8_row_count + 1);
		sheet8_row_count++;
		
		// 구분 로우에 셀 생성
		XSSFCell sheet8_gubunCell4	= sheet8_gubunRow4.createCell((int) 1);
		
		//sheet8_gubunCell4.setCellValue("정규 작업 처리 현황");
		sheet8_gubunCell4.setCellValue("월말 작업 처리 현황");
		
		// 구분 셀 병합
		sheet8.addMergedRegion(new CellRangeAddress(sheet8_row_count,  sheet8_row_count, 1,  9));
		
		// 구분 셀에 스타일 적용
		style	= wb.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setFillForegroundColor(IndexedColors.LEMON_CHIFFON.index);
		style.setFillPattern(XSSFCellStyle.SOLID_FOREGROUND);
		sheet8_gubunCell4.setCellStyle(style);
		
		// 타이틀 로우 생성
		XSSFRow sheet8_titleRow4 	= sheet8.createRow((int) sheet8_row_count + 1);
		sheet8_row_count++;
		
		// 타이틀 셀에 스타일 적용
		style	= wb.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.index);
		style.setFillPattern(XSSFCellStyle.SOLID_FOREGROUND);
		style.setBorderRight(XSSFCellStyle.BORDER_THIN);
		style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
		style.setBorderTop(XSSFCellStyle.BORDER_THIN);
		style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
		
		// 타이틀 로우에 셀 생성 
		XSSFCell sheet8_titleCell4	= sheet8_titleRow4.createCell((int) 1);
		sheet8_titleCell4.setCellValue("No");
		sheet8_titleCell4.setCellStyle(style);
		
		sheet8_titleCell4			= sheet8_titleRow4.createCell((int) 2);
		sheet8_titleCell4.setCellValue("ODATE");
		sheet8_titleCell4.setCellStyle(style);
		
		sheet8_titleCell4			= sheet8_titleRow4.createCell((int) 3);
		sheet8_titleCell4.setCellValue("수행건수");
		sheet8_titleCell4.setCellStyle(style);
		
		sheet8_titleCell4			= sheet8_titleRow4.createCell((int) 4);
		sheet8_titleCell4.setCellValue("처리상태");
		sheet8_titleCell4.setCellStyle(style);
		
		sheet8_titleCell4			= sheet8_titleRow4.createCell((int) 5);
		sheet8_titleCell4.setCellValue("작업명");
		sheet8_titleCell4.setCellStyle(style);
		
		sheet8_titleCell4			= sheet8_titleRow4.createCell((int) 6);
		sheet8_titleCell4.setCellValue("시작시간");
		sheet8_titleCell4.setCellStyle(style);
		
		sheet8_titleCell4			= sheet8_titleRow4.createCell((int) 7);
		sheet8_titleCell4.setCellValue("종료시간");
		sheet8_titleCell4.setCellStyle(style);
		
		sheet8_titleCell4			= sheet8_titleRow4.createCell((int) 8);
		sheet8_titleCell4.setCellValue("수행시간");
		sheet8_titleCell4.setCellStyle(style);
		
		sheet8_titleCell4			= sheet8_titleRow4.createCell((int) 9);
		sheet8_titleCell4.setCellValue("작업설명");
		sheet8_titleCell4.setCellStyle(style);
		
		for( int i=0; null!=jobOpReportRbaList4 && i<jobOpReportRbaList4.size(); i++ ){
			JobLogBean bean = (JobLogBean)jobOpReportRbaList4.get(i);
			
			String strOdate 		= CommonUtil.isNull(bean.getOdate());
			String strJobName 		= CommonUtil.isNull(bean.getJob_name());
			String strOrderTable 	= CommonUtil.isNull(bean.getOrder_table());
			String strApplication 	= CommonUtil.isNull(bean.getApplication());
			String strGroupName 	= CommonUtil.isNull(bean.getGroup_name());
			String strStateResult 	= CommonUtil.isNull(bean.getState_result());
			String strStatus 		= CommonUtil.isNull(bean.getStatus());
			String strStartTime 	= CommonUtil.isNull(CommonUtil.getDateFormat(1,bean.getStart_time(),"-"));
			String strEndTime 		= CommonUtil.isNull(CommonUtil.getDateFormat(1,bean.getEnd_time(),"-"));
			String strRunTime 		= CommonUtil.getDiffTime( CommonUtil.getDateFormat(1,bean.getStart_time()),CommonUtil.getDateFormat(1,bean.getEnd_time()));
			String strDescription	= CommonUtil.isNull(bean.getDescription());
			String strRerunCounter	= CommonUtil.isNull(bean.getRerun_counter());
			
			String strStatusMent = "";
			if ( strStatus.equals("Ended OK") ) {
				strStatusMent = "완료";
			} else if ( strStatus.equals("Ended Not OK") ) {
				strStatusMent = "오류";
			} else if ( strStatus.indexOf("Wait") > -1 ) {
				strStatusMent = "미완료";
			} else if ( !strStatus.equals("Ended OK") && !strStatus.equals("Ended Not OK") && strStatus.indexOf("Wait") == -1 ) {
				strStatusMent = "기타";
			}
			
			XSSFRow sheet8_listRow2 = sheet8.createRow((int) sheet8_row_count + 1);
			sheet8_row_count++;
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			XSSFCell sheet8_listCell2	= sheet8_listRow2.createCell((int) 1);
			sheet8_listCell2.setCellValue((i+1));
			sheet8_listCell2.setCellStyle(style);
			
			sheet8_listCell2	= sheet8_listRow2.createCell((int) 2);
			sheet8_listCell2.setCellValue(strOdate);
			sheet8_listCell2.setCellStyle(style);
			
			sheet8_listCell2	= sheet8_listRow2.createCell((int) 3);
			sheet8_listCell2.setCellValue(strRerunCounter);
			sheet8_listCell2.setCellStyle(style);
			
			sheet8_listCell2	= sheet8_listRow2.createCell((int) 4);
			sheet8_listCell2.setCellValue(strStatusMent);
			sheet8_listCell2.setCellStyle(style);
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			sheet8_listCell2	= sheet8_listRow2.createCell((int) 5);
			sheet8_listCell2.setCellValue(" " + strJobName);			
			sheet8_listCell2.setCellStyle(style);
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			sheet8_listCell2	= sheet8_listRow2.createCell((int) 6);
			sheet8_listCell2.setCellValue(strStartTime);
			sheet8_listCell2.setCellStyle(style);
			
			sheet8_listCell2	= sheet8_listRow2.createCell((int) 7);
			sheet8_listCell2.setCellValue(strEndTime);
			sheet8_listCell2.setCellStyle(style);
			
			sheet8_listCell2	= sheet8_listRow2.createCell((int) 8);
			sheet8_listCell2.setCellValue(strRunTime);
			sheet8_listCell2.setCellStyle(style);
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			sheet8_listCell2	= sheet8_listRow2.createCell((int) 9);
			sheet8_listCell2.setCellValue(" " + strDescription);			
			sheet8_listCell2.setCellStyle(style);
		}
		
		sheet8.setColumnWidth(0, (int)0x200);
		
		for(int i=1; i<=10; i++){
			sheet8.autoSizeColumn(i);
			sheet8.setColumnWidth(i, sheet8.getColumnWidth(i)+700 );
		}
		
		
		
		
		// 시트 생성
		XSSFSheet sheet9 	= wb.createSheet("CRS");
		
		int sheet9_row_count = 0;
		
		// 문서 제목 로우 생성
		XSSFRow sheet9_nameRow 	= sheet9.createRow((int) sheet9_row_count + 1);
		sheet9_row_count++;
		
		// 문서 제목 로우에 셀 생성
		XSSFCell sheet9_cell	= sheet9_nameRow.createCell((int) 1);
		
		sheet9_cell.setCellValue("<CRS 작업 처리 현황 " + s_search_odate + " ~  " + e_search_odate + ">");
		
		// 문서 제목 셀에 스타일 적용
		style	= wb.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		sheet9_cell.setCellStyle(style);
		
		// 문서 제목 셀 병합
		sheet9.addMergedRegion(new CellRangeAddress(1,  1, 1,  9));
		
		// 한줄 띄우기
		sheet9.createRow((int) sheet9_row_count + 1);
		sheet9_row_count++;
		
		// 구분 로우 생성
		XSSFRow sheet9_gubunRow 	= sheet9.createRow((int) sheet9_row_count + 1);
		sheet9_row_count++;
		
		// 구분 로우에 셀 생성
		XSSFCell sheet9_gubunCell	= sheet9_gubunRow.createCell((int) 1);
		
		sheet9_gubunCell.setCellValue("작업 의뢰서 처리 현황");
		
		// 구분 셀 병합
		sheet9.addMergedRegion(new CellRangeAddress(3,  3, 1,  9));
		
		// 구분 셀에 스타일 적용
		style	= wb.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setFillForegroundColor(IndexedColors.PALE_BLUE.index);
		style.setFillPattern(XSSFCellStyle.SOLID_FOREGROUND);
		sheet9_gubunCell.setCellStyle(style);
		
		// 타이틀 로우 생성
		XSSFRow sheet9_titleRow 	= sheet9.createRow((int) sheet9_row_count + 1);
		sheet9_row_count++;
		
		// 타이틀 셀에 스타일 적용
		style	= wb.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.index);
		style.setFillPattern(XSSFCellStyle.SOLID_FOREGROUND);
		style.setBorderRight(XSSFCellStyle.BORDER_THIN);
		style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
		style.setBorderTop(XSSFCellStyle.BORDER_THIN);
		style.setBorderBottom(XSSFCellStyle.BORDER_THIN);		
		
		// 타이틀 로우에 셀 생성 
		XSSFCell sheet9_titleCell	= sheet9_titleRow.createCell((int) 1);
		sheet9_titleCell.setCellValue("No");
		sheet9_titleCell.setCellStyle(style);
		
		sheet9_titleCell			= sheet9_titleRow.createCell((int) 2);
		sheet9_titleCell.setCellValue("ODATE");
		sheet9_titleCell.setCellStyle(style);
		
		sheet9_titleCell			= sheet9_titleRow.createCell((int) 3);
		sheet9_titleCell.setCellValue("수행건수");
		sheet9_titleCell.setCellStyle(style);
		
		sheet9_titleCell			= sheet9_titleRow.createCell((int) 4);
		sheet9_titleCell.setCellValue("처리상태");
		sheet9_titleCell.setCellStyle(style);
		
		sheet9_titleCell			= sheet9_titleRow.createCell((int) 5);
		sheet9_titleCell.setCellValue("작업명");
		sheet9_titleCell.setCellStyle(style);
		
		sheet9_titleCell			= sheet9_titleRow.createCell((int) 6);
		sheet9_titleCell.setCellValue("시작시간");
		sheet9_titleCell.setCellStyle(style);
		
		sheet9_titleCell			= sheet9_titleRow.createCell((int) 7);
		sheet9_titleCell.setCellValue("종료시간");
		sheet9_titleCell.setCellStyle(style);
		
		sheet9_titleCell			= sheet9_titleRow.createCell((int) 8);
		sheet9_titleCell.setCellValue("수행시간");
		sheet9_titleCell.setCellStyle(style);
		
		sheet9_titleCell			= sheet9_titleRow.createCell((int) 9);
		sheet9_titleCell.setCellValue("작업설명");
		sheet9_titleCell.setCellStyle(style);
		
		for( int i=0; null!=jobOpReportCrsList && i<jobOpReportCrsList.size(); i++ ){
			JobLogBean bean = (JobLogBean)jobOpReportCrsList.get(i);
			
			String strOdate 		= CommonUtil.isNull(bean.getOdate());
			String strJobName 		= CommonUtil.isNull(bean.getJob_name());
			String strOrderTable 	= CommonUtil.isNull(bean.getOrder_table());
			String strApplication 	= CommonUtil.isNull(bean.getApplication());
			String strGroupName 	= CommonUtil.isNull(bean.getGroup_name());
			String strStateResult 	= CommonUtil.isNull(bean.getState_result());
			String strStatus 		= CommonUtil.isNull(bean.getStatus());
			String strStartTime 	= CommonUtil.isNull(CommonUtil.getDateFormat(1,bean.getStart_time(),"-"));
			String strEndTime 		= CommonUtil.isNull(CommonUtil.getDateFormat(1,bean.getEnd_time(),"-;"));
			String strRunTime 		= CommonUtil.getDiffTime( CommonUtil.getDateFormat(1,bean.getStart_time()),CommonUtil.getDateFormat(1,bean.getEnd_time()));
			String strDescription	= CommonUtil.isNull(bean.getDescription());
			String strRerunCounter	= CommonUtil.isNull(bean.getRerun_counter());
			
			String strStatusMent = "";
			if ( strStatus.equals("Ended OK") ) {
				strStatusMent = "완료";
			} else if ( strStatus.equals("Ended Not OK") ) {
				strStatusMent = "오류";
			} else if ( strStatus.indexOf("Wait") > -1 ) {
				strStatusMent = "미완료";
			} else if ( !strStatus.equals("Ended OK") && !strStatus.equals("Ended Not OK") && strStatus.indexOf("Wait") == -1 ) {
				strStatusMent = "기타";
			}
			
			XSSFRow sheet9_listRow = sheet9.createRow((int) sheet9_row_count + 1);
			sheet9_row_count++;
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			XSSFCell sheet9_listCell2	= sheet9_listRow.createCell((int) 1);
			sheet9_listCell2.setCellValue((i+1));
			sheet9_listCell2.setCellStyle(style);
			
			sheet9_listCell2	= sheet9_listRow.createCell((int) 2);
			sheet9_listCell2.setCellValue(strOdate);
			sheet9_listCell2.setCellStyle(style);
			
			sheet9_listCell2	= sheet9_listRow.createCell((int) 3);
			sheet9_listCell2.setCellValue(strRerunCounter);
			sheet9_listCell2.setCellStyle(style);
			
			sheet9_listCell2	= sheet9_listRow.createCell((int) 4);
			sheet9_listCell2.setCellValue(strStatusMent);
			sheet9_listCell2.setCellStyle(style);
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			sheet9_listCell2	= sheet9_listRow.createCell((int) 5);
			sheet9_listCell2.setCellValue(" " + strJobName);			
			sheet9_listCell2.setCellStyle(style);
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			sheet9_listCell2	= sheet9_listRow.createCell((int) 6);
			sheet9_listCell2.setCellValue(strStartTime);
			sheet9_listCell2.setCellStyle(style);
			
			sheet9_listCell2	= sheet9_listRow.createCell((int) 7);
			sheet9_listCell2.setCellValue(strEndTime);
			sheet9_listCell2.setCellStyle(style);
			
			sheet9_listCell2	= sheet9_listRow.createCell((int) 8);
			sheet9_listCell2.setCellValue(strRunTime);
			sheet9_listCell2.setCellStyle(style);
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			sheet9_listCell2	= sheet9_listRow.createCell((int) 9);
			sheet9_listCell2.setCellValue(" " + strDescription);			
			sheet9_listCell2.setCellStyle(style);
		}

		// 한줄 띄우기
		sheet9.createRow((int) sheet9_row_count + 1);
		sheet9_row_count++;
		
		// 한줄 띄우기
		sheet9.createRow((int) sheet9_row_count + 1);
		sheet9_row_count++;
		
		// 구분 로우 생성
		XSSFRow sheet9_gubunRow2 	= sheet9.createRow((int) sheet9_row_count + 1);
		sheet9_row_count++;
		
		// 구분 로우에 셀 생성
		XSSFCell sheet9_gubunCell2	= sheet9_gubunRow2.createCell((int) 1);
		
		sheet9_gubunCell2.setCellValue("정규 작업 처리 현황");
		
		// 구분 셀 병합
		sheet9.addMergedRegion(new CellRangeAddress(sheet9_row_count,  sheet9_row_count, 1,  9));
		
		// 구분 셀에 스타일 적용
		style	= wb.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setFillForegroundColor(IndexedColors.PALE_BLUE.index);
		style.setFillPattern(XSSFCellStyle.SOLID_FOREGROUND);
		sheet9_gubunCell2.setCellStyle(style);
		
		// 타이틀 로우 생성
		XSSFRow sheet9_titleRow2 	= sheet9.createRow((int) sheet9_row_count + 1);
		sheet9_row_count++;
		
		// 타이틀 셀에 스타일 적용
		style	= wb.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.index);
		style.setFillPattern(XSSFCellStyle.SOLID_FOREGROUND);
		style.setBorderRight(XSSFCellStyle.BORDER_THIN);
		style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
		style.setBorderTop(XSSFCellStyle.BORDER_THIN);
		style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
		
		// 타이틀 로우에 셀 생성 
		XSSFCell sheet9_titleCell2	= sheet9_titleRow2.createCell((int) 1);
		sheet9_titleCell2.setCellValue("No");
		sheet9_titleCell2.setCellStyle(style);
		
		sheet9_titleCell2			= sheet9_titleRow2.createCell((int) 2);
		sheet9_titleCell2.setCellValue("ODATE");
		sheet9_titleCell2.setCellStyle(style);
		
		sheet9_titleCell2			= sheet9_titleRow2.createCell((int) 3);
		sheet9_titleCell2.setCellValue("수행건수");
		sheet9_titleCell2.setCellStyle(style);
		
		sheet9_titleCell2			= sheet9_titleRow2.createCell((int) 4);
		sheet9_titleCell2.setCellValue("처리상태");
		sheet9_titleCell2.setCellStyle(style);
		
		sheet9_titleCell2			= sheet9_titleRow2.createCell((int) 5);
		sheet9_titleCell2.setCellValue("작업명");
		sheet9_titleCell2.setCellStyle(style);
		
		sheet9_titleCell2			= sheet9_titleRow2.createCell((int) 6);
		sheet9_titleCell2.setCellValue("시작시간");
		sheet9_titleCell2.setCellStyle(style);
		
		sheet9_titleCell2			= sheet9_titleRow2.createCell((int) 7);
		sheet9_titleCell2.setCellValue("종료시간");
		sheet9_titleCell2.setCellStyle(style);
		
		sheet9_titleCell2			= sheet9_titleRow2.createCell((int) 8);
		sheet9_titleCell2.setCellValue("수행시간");
		sheet9_titleCell2.setCellStyle(style);
		
		sheet9_titleCell2			= sheet9_titleRow2.createCell((int) 9);
		sheet9_titleCell2.setCellValue("작업설명");
		sheet9_titleCell2.setCellStyle(style);
		
		for( int i=0; null!=jobOpReportCrsList2 && i<jobOpReportCrsList2.size(); i++ ){
			JobLogBean bean = (JobLogBean)jobOpReportCrsList2.get(i);
			
			String strOdate 		= CommonUtil.isNull(bean.getOdate());
			String strJobName 		= CommonUtil.isNull(bean.getJob_name());
			String strOrderTable 	= CommonUtil.isNull(bean.getOrder_table());
			String strApplication 	= CommonUtil.isNull(bean.getApplication());
			String strGroupName 	= CommonUtil.isNull(bean.getGroup_name());
			String strStateResult 	= CommonUtil.isNull(bean.getState_result());
			String strStatus 		= CommonUtil.isNull(bean.getStatus());
			String strStartTime 	= CommonUtil.isNull(CommonUtil.getDateFormat(1,bean.getStart_time(),"-"));
			String strEndTime 		= CommonUtil.isNull(CommonUtil.getDateFormat(1,bean.getEnd_time(),"-"));
			String strRunTime 		= CommonUtil.getDiffTime( CommonUtil.getDateFormat(1,bean.getStart_time()),CommonUtil.getDateFormat(1,bean.getEnd_time()));
			String strDescription	= CommonUtil.isNull(bean.getDescription());
			String strRerunCounter	= CommonUtil.isNull(bean.getRerun_counter());
			
			String strStatusMent = "";
			if ( strStatus.equals("Ended OK") ) {
				strStatusMent = "완료";
			} else if ( strStatus.equals("Ended Not OK") ) {
				strStatusMent = "오류";
			} else if ( strStatus.indexOf("Wait") > -1 ) {
				strStatusMent = "미완료";
			} else if ( !strStatus.equals("Ended OK") && !strStatus.equals("Ended Not OK") && strStatus.indexOf("Wait") == -1 ) {
				strStatusMent = "기타";
			}
			
			XSSFRow sheet9_listRow2 = sheet9.createRow((int) sheet9_row_count + 1);
			sheet9_row_count++;
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			XSSFCell sheet9_listCell2	= sheet9_listRow2.createCell((int) 1);
			sheet9_listCell2.setCellValue((i+1));
			sheet9_listCell2.setCellStyle(style);
			
			sheet9_listCell2	= sheet9_listRow2.createCell((int) 2);
			sheet9_listCell2.setCellValue(strOdate);
			sheet9_listCell2.setCellStyle(style);
			
			sheet9_listCell2	= sheet9_listRow2.createCell((int) 3);
			sheet9_listCell2.setCellValue(strRerunCounter);
			sheet9_listCell2.setCellStyle(style);
			
			sheet9_listCell2	= sheet9_listRow2.createCell((int) 4);
			sheet9_listCell2.setCellValue(strStatusMent);
			sheet9_listCell2.setCellStyle(style);
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			sheet9_listCell2	= sheet9_listRow2.createCell((int) 5);
			sheet9_listCell2.setCellValue(" " + strJobName);			
			sheet9_listCell2.setCellStyle(style);
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			sheet9_listCell2	= sheet9_listRow2.createCell((int) 6);
			sheet9_listCell2.setCellValue(strStartTime);
			sheet9_listCell2.setCellStyle(style);
			
			sheet9_listCell2	= sheet9_listRow2.createCell((int) 7);
			sheet9_listCell2.setCellValue(strEndTime);
			sheet9_listCell2.setCellStyle(style);
			
			sheet9_listCell2	= sheet9_listRow2.createCell((int) 8);
			sheet9_listCell2.setCellValue(strRunTime);
			sheet9_listCell2.setCellStyle(style);
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			sheet9_listCell2	= sheet9_listRow2.createCell((int) 9);
			sheet9_listCell2.setCellValue(" " + strDescription);			
			sheet9_listCell2.setCellStyle(style);
		}
		
		// 한줄 띄우기
		sheet9.createRow((int) sheet9_row_count + 1);
		sheet9_row_count++;
		
		// 한줄 띄우기
		sheet9.createRow((int) sheet9_row_count + 1);
		sheet9_row_count++;
		
		// 구분 로우 생성
		XSSFRow sheet9_gubunRow3 	= sheet9.createRow((int) sheet9_row_count + 1);
		sheet9_row_count++;
		
		// 구분 로우에 셀 생성
		XSSFCell sheet9_gubunCell3	= sheet9_gubunRow3.createCell((int) 1);
		
		//sheet9_gubunCell3.setCellValue("정규 작업 처리 현황");
		sheet9_gubunCell3.setCellValue("월초 작업 처리 현황");
		
		// 구분 셀 병합
		sheet9.addMergedRegion(new CellRangeAddress(sheet9_row_count,  sheet9_row_count, 1,  9));
		
		// 구분 셀에 스타일 적용
		style	= wb.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setFillForegroundColor(IndexedColors.PALE_BLUE.index);
		style.setFillPattern(XSSFCellStyle.SOLID_FOREGROUND);
		sheet9_gubunCell3.setCellStyle(style);
		
		// 타이틀 로우 생성
		XSSFRow sheet9_titleRow3 	= sheet9.createRow((int) sheet9_row_count + 1);
		sheet9_row_count++;
		
		// 타이틀 셀에 스타일 적용
		style	= wb.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.index);
		style.setFillPattern(XSSFCellStyle.SOLID_FOREGROUND);
		style.setBorderRight(XSSFCellStyle.BORDER_THIN);
		style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
		style.setBorderTop(XSSFCellStyle.BORDER_THIN);
		style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
		
		// 타이틀 로우에 셀 생성 
		XSSFCell sheet9_titleCell3	= sheet9_titleRow3.createCell((int) 1);
		sheet9_titleCell3.setCellValue("No");
		sheet9_titleCell3.setCellStyle(style);
		
		sheet9_titleCell3			= sheet9_titleRow3.createCell((int) 2);
		sheet9_titleCell3.setCellValue("ODATE");
		sheet9_titleCell3.setCellStyle(style);
		
		sheet9_titleCell3			= sheet9_titleRow3.createCell((int) 3);
		sheet9_titleCell3.setCellValue("수행건수");
		sheet9_titleCell3.setCellStyle(style);
		
		sheet9_titleCell3			= sheet9_titleRow3.createCell((int) 4);
		sheet9_titleCell3.setCellValue("처리상태");
		sheet9_titleCell3.setCellStyle(style);
		
		sheet9_titleCell3			= sheet9_titleRow3.createCell((int) 5);
		sheet9_titleCell3.setCellValue("작업명");
		sheet9_titleCell3.setCellStyle(style);
		
		sheet9_titleCell3			= sheet9_titleRow3.createCell((int) 6);
		sheet9_titleCell3.setCellValue("시작시간");
		sheet9_titleCell3.setCellStyle(style);
		
		sheet9_titleCell3			= sheet9_titleRow3.createCell((int) 7);
		sheet9_titleCell3.setCellValue("종료시간");
		sheet9_titleCell3.setCellStyle(style);
		
		sheet9_titleCell3			= sheet9_titleRow3.createCell((int) 8);
		sheet9_titleCell3.setCellValue("수행시간");
		sheet9_titleCell3.setCellStyle(style);
		
		sheet9_titleCell3			= sheet9_titleRow3.createCell((int) 9);
		sheet9_titleCell3.setCellValue("작업설명");
		sheet9_titleCell3.setCellStyle(style);
		
		for( int i=0; null!=jobOpReportCrsList3 && i<jobOpReportCrsList3.size(); i++ ){
			JobLogBean bean = (JobLogBean)jobOpReportCrsList3.get(i);
			
			String strOdate 		= CommonUtil.isNull(bean.getOdate());
			String strJobName 		= CommonUtil.isNull(bean.getJob_name());
			String strOrderTable 	= CommonUtil.isNull(bean.getOrder_table());
			String strApplication 	= CommonUtil.isNull(bean.getApplication());
			String strGroupName 	= CommonUtil.isNull(bean.getGroup_name());
			String strStateResult 	= CommonUtil.isNull(bean.getState_result());
			String strStatus 		= CommonUtil.isNull(bean.getStatus());
			String strStartTime 	= CommonUtil.isNull(CommonUtil.getDateFormat(1,bean.getStart_time(),"-"));
			String strEndTime 		= CommonUtil.isNull(CommonUtil.getDateFormat(1,bean.getEnd_time(),"-"));
			String strRunTime 		= CommonUtil.getDiffTime( CommonUtil.getDateFormat(1,bean.getStart_time()),CommonUtil.getDateFormat(1,bean.getEnd_time()));
			String strDescription	= CommonUtil.isNull(bean.getDescription());
			String strRerunCounter	= CommonUtil.isNull(bean.getRerun_counter());
			
			String strStatusMent = "";
			if ( strStatus.equals("Ended OK") ) {
				strStatusMent = "완료";
			} else if ( strStatus.equals("Ended Not OK") ) {
				strStatusMent = "오류";
			} else if ( strStatus.indexOf("Wait") > -1 ) {
				strStatusMent = "미완료";
			} else if ( !strStatus.equals("Ended OK") && !strStatus.equals("Ended Not OK") && strStatus.indexOf("Wait") == -1 ) {
				strStatusMent = "기타";
			}
			
			XSSFRow sheet9_listRow2 = sheet9.createRow((int) sheet9_row_count + 1);
			sheet9_row_count++;
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			XSSFCell sheet9_listCell2	= sheet9_listRow2.createCell((int) 1);
			sheet9_listCell2.setCellValue((i+1));
			sheet9_listCell2.setCellStyle(style);
			
			sheet9_listCell2	= sheet9_listRow2.createCell((int) 2);
			sheet9_listCell2.setCellValue(strOdate);
			sheet9_listCell2.setCellStyle(style);
			
			sheet9_listCell2	= sheet9_listRow2.createCell((int) 3);
			sheet9_listCell2.setCellValue(strRerunCounter);
			sheet9_listCell2.setCellStyle(style);
			
			sheet9_listCell2	= sheet9_listRow2.createCell((int) 4);
			sheet9_listCell2.setCellValue(strStatusMent);
			sheet9_listCell2.setCellStyle(style);
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			sheet9_listCell2	= sheet9_listRow2.createCell((int) 5);
			sheet9_listCell2.setCellValue(" " + strJobName);			
			sheet9_listCell2.setCellStyle(style);
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			sheet9_listCell2	= sheet9_listRow2.createCell((int) 6);
			sheet9_listCell2.setCellValue(strStartTime);
			sheet9_listCell2.setCellStyle(style);
			
			sheet9_listCell2	= sheet9_listRow2.createCell((int) 7);
			sheet9_listCell2.setCellValue(strEndTime);
			sheet9_listCell2.setCellStyle(style);
			
			sheet9_listCell2	= sheet9_listRow2.createCell((int) 8);
			sheet9_listCell2.setCellValue(strRunTime);
			sheet9_listCell2.setCellStyle(style);
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			sheet9_listCell2	= sheet9_listRow2.createCell((int) 9);
			sheet9_listCell2.setCellValue(" " + strDescription);			
			sheet9_listCell2.setCellStyle(style);
		}
		
		// 한줄 띄우기
		sheet9.createRow((int) sheet9_row_count + 1);
		sheet9_row_count++;
		
		// 한줄 띄우기
		sheet9.createRow((int) sheet9_row_count + 1);
		sheet9_row_count++;
		
		// 구분 로우 생성
		XSSFRow sheet9_gubunRow4 	= sheet9.createRow((int) sheet9_row_count + 1);
		sheet9_row_count++;
		
		// 구분 로우에 셀 생성
		XSSFCell sheet9_gubunCell4	= sheet9_gubunRow4.createCell((int) 1);
		
		//sheet9_gubunCell4.setCellValue("정규 작업 처리 현황");
		sheet9_gubunCell4.setCellValue("월말 작업 처리 현황");
		
		// 구분 셀 병합
		sheet9.addMergedRegion(new CellRangeAddress(sheet9_row_count,  sheet9_row_count, 1,  9));
		
		// 구분 셀에 스타일 적용
		style	= wb.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setFillForegroundColor(IndexedColors.PALE_BLUE.index);
		style.setFillPattern(XSSFCellStyle.SOLID_FOREGROUND);
		sheet9_gubunCell4.setCellStyle(style);
		
		// 타이틀 로우 생성
		XSSFRow sheet9_titleRow4 	= sheet9.createRow((int) sheet9_row_count + 1);
		sheet9_row_count++;
		
		// 타이틀 셀에 스타일 적용
		style	= wb.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.index);
		style.setFillPattern(XSSFCellStyle.SOLID_FOREGROUND);
		style.setBorderRight(XSSFCellStyle.BORDER_THIN);
		style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
		style.setBorderTop(XSSFCellStyle.BORDER_THIN);
		style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
		
		// 타이틀 로우에 셀 생성 
		XSSFCell sheet9_titleCell4	= sheet9_titleRow4.createCell((int) 1);
		sheet9_titleCell4.setCellValue("No");
		sheet9_titleCell4.setCellStyle(style);
		
		sheet9_titleCell4			= sheet9_titleRow4.createCell((int) 2);
		sheet9_titleCell4.setCellValue("ODATE");
		sheet9_titleCell4.setCellStyle(style);
		
		sheet9_titleCell4			= sheet9_titleRow4.createCell((int) 3);
		sheet9_titleCell4.setCellValue("수행건수");
		sheet9_titleCell4.setCellStyle(style);
		
		sheet9_titleCell4			= sheet9_titleRow4.createCell((int) 4);
		sheet9_titleCell4.setCellValue("처리상태");
		sheet9_titleCell4.setCellStyle(style);
		
		sheet9_titleCell4			= sheet9_titleRow4.createCell((int) 5);
		sheet9_titleCell4.setCellValue("작업명");
		sheet9_titleCell4.setCellStyle(style);
		
		sheet9_titleCell4			= sheet9_titleRow4.createCell((int) 6);
		sheet9_titleCell4.setCellValue("시작시간");
		sheet9_titleCell4.setCellStyle(style);
		
		sheet9_titleCell4			= sheet9_titleRow4.createCell((int) 7);
		sheet9_titleCell4.setCellValue("종료시간");
		sheet9_titleCell4.setCellStyle(style);
		
		sheet9_titleCell4			= sheet9_titleRow4.createCell((int) 8);
		sheet9_titleCell4.setCellValue("수행시간");
		sheet9_titleCell4.setCellStyle(style);
		
		sheet9_titleCell4			= sheet9_titleRow4.createCell((int) 9);
		sheet9_titleCell4.setCellValue("작업설명");
		sheet9_titleCell4.setCellStyle(style);
		
		for( int i=0; null!=jobOpReportCrsList4 && i<jobOpReportCrsList4.size(); i++ ){
			JobLogBean bean = (JobLogBean)jobOpReportCrsList4.get(i);
			
			String strOdate 		= CommonUtil.isNull(bean.getOdate());
			String strJobName 		= CommonUtil.isNull(bean.getJob_name());
			String strOrderTable 	= CommonUtil.isNull(bean.getOrder_table());
			String strApplication 	= CommonUtil.isNull(bean.getApplication());
			String strGroupName 	= CommonUtil.isNull(bean.getGroup_name());
			String strStateResult 	= CommonUtil.isNull(bean.getState_result());
			String strStatus 		= CommonUtil.isNull(bean.getStatus());
			String strStartTime 	= CommonUtil.isNull(CommonUtil.getDateFormat(1,bean.getStart_time(),"-"));
			String strEndTime 		= CommonUtil.isNull(CommonUtil.getDateFormat(1,bean.getEnd_time(),"-"));
			String strRunTime 		= CommonUtil.getDiffTime( CommonUtil.getDateFormat(1,bean.getStart_time()),CommonUtil.getDateFormat(1,bean.getEnd_time()));
			String strDescription	= CommonUtil.isNull(bean.getDescription());
			String strRerunCounter	= CommonUtil.isNull(bean.getRerun_counter());
			
			String strStatusMent = "";
			if ( strStatus.equals("Ended OK") ) {
				strStatusMent = "완료";
			} else if ( strStatus.equals("Ended Not OK") ) {
				strStatusMent = "오류";
			} else if ( strStatus.indexOf("Wait") > -1 ) {
				strStatusMent = "미완료";
			} else if ( !strStatus.equals("Ended OK") && !strStatus.equals("Ended Not OK") && strStatus.indexOf("Wait") == -1 ) {
				strStatusMent = "기타";
			}
			
			XSSFRow sheet9_listRow2 = sheet9.createRow((int) sheet9_row_count + 1);
			sheet9_row_count++;
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			XSSFCell sheet9_listCell2	= sheet9_listRow2.createCell((int) 1);
			sheet9_listCell2.setCellValue((i+1));
			sheet9_listCell2.setCellStyle(style);
			
			sheet9_listCell2	= sheet9_listRow2.createCell((int) 2);
			sheet9_listCell2.setCellValue(strOdate);
			sheet9_listCell2.setCellStyle(style);
			
			sheet9_listCell2	= sheet9_listRow2.createCell((int) 3);
			sheet9_listCell2.setCellValue(strRerunCounter);
			sheet9_listCell2.setCellStyle(style);
			
			sheet9_listCell2	= sheet9_listRow2.createCell((int) 4);
			sheet9_listCell2.setCellValue(strStatusMent);
			sheet9_listCell2.setCellStyle(style);
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			sheet9_listCell2	= sheet9_listRow2.createCell((int) 5);
			sheet9_listCell2.setCellValue(" " + strJobName);			
			sheet9_listCell2.setCellStyle(style);
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_CENTER);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			sheet9_listCell2	= sheet9_listRow2.createCell((int) 6);
			sheet9_listCell2.setCellValue(strStartTime);
			sheet9_listCell2.setCellStyle(style);
			
			sheet9_listCell2	= sheet9_listRow2.createCell((int) 7);
			sheet9_listCell2.setCellValue(strEndTime);
			sheet9_listCell2.setCellStyle(style);
			
			sheet9_listCell2	= sheet9_listRow2.createCell((int) 8);
			sheet9_listCell2.setCellValue(strRunTime);
			sheet9_listCell2.setCellStyle(style);
			
			style	= wb.createCellStyle();
			style.setAlignment(XSSFCellStyle.ALIGN_LEFT);	
			style.setBorderRight(XSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
			style.setBorderTop(XSSFCellStyle.BORDER_THIN);
			style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
			
			sheet9_listCell2	= sheet9_listRow2.createCell((int) 9);
			sheet9_listCell2.setCellValue(" " + strDescription);			
			sheet9_listCell2.setCellStyle(style);
		}
		
		sheet9.setColumnWidth(0, (int)0x200);
		
		for(int i=1; i<=10; i++){
			sheet9.autoSizeColumn(i);
			sheet9.setColumnWidth(i, sheet9.getColumnWidth(i)+700 );
		}
		
		
		
		
		
	
		os = response.getOutputStream();
		wb.write(os);
		os.flush();
		
		out.clear();
		out = pageContext.pushBody();
	
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		if(os!=null) os.close();
	}
	 
%>