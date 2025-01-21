<%@page import="com.ghayoun.ezjobs.t.domain.DocInfoBean"%>
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
	
	String fileName = "보고서_기간별의뢰결재현황.xlsx";
	response.reset() ;
	response.setHeader("Content-Description", "JSP Generated Data");
	response.setHeader("Content-Type", "application/octet-stream; charset=UTF-8");
	response.setHeader("Content-Disposition", "attachment; filename="+java.net.URLEncoder.encode(fileName,"UTF-8").replaceAll("\\+","%20"));
	
	List<DocApprovalTotalBean> docApprovalTotalList = (List)request.getAttribute("docApprovalTotalList");
	
	//검색조건 출력용
	String param_s_pdate	= CommonUtil.isNull(paramMap.get("p_s_pdate"));
	String param_e_pdate	= CommonUtil.isNull(paramMap.get("p_e_pdate"));
	String param_dept		= CommonUtil.isNull(paramMap.get("p_dept_nm"));
	String param_table		= CommonUtil.isNull(paramMap.get("p_sched_table"));
	
	String ins_date 			= param_s_pdate+" ~ "+param_e_pdate;
	String p_dept_nm 			= param_dept.equals("") ? "전체" : param_dept;
	String p_sched_table 		= param_table.equals("") ? "전체" : param_table;
%>

<%
	try {
		
		sheet = wb.createSheet("기간별의뢰결재현황");
		
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
		sheet.addMergedRegion(new CellRangeAddress(0, 0, 0, 10));
		sheet.addMergedRegion(new CellRangeAddress(1, 1, 1, 10));
		sheet.addMergedRegion(new CellRangeAddress(2, 2, 1, 10));
		sheet.addMergedRegion(new CellRangeAddress(3, 3, 1, 10));
		
		setCellValue(0, 0, arr_menu_gb[0], 	title_style);
		setCellValue(1, 0, "등록일자", 		title_style);
		setCellValue(2, 0, "부서", 			title_style);
		setCellValue(3, 0, "폴더", 			title_style);
		
		// 병합된 셀 테두리 선을 그릴때에는 셀을 하나씩 만들어주고 병합을해야 선이 그려진다.
		for( int i = 1; i <= 10; i++) {
			setCellValue(1, i, "", left_style);
			setCellValue(2, i, "", left_style);
			setCellValue(3, i, "", left_style);
		}
		
		setCellValue(1, 1, ins_date, 		left_style);
		setCellValue(2, 1, p_dept_nm, 		left_style);
		setCellValue(3, 1, p_sched_table, 	left_style);
		// 셀 병합  종료
		
		int n = -1;
		int r = 5;	// 상단 검색조건만큼 아래부터 시작
		
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
		int MaxCellWidth11	= 0;
		
		setCellValue(r, ++n, "C-M", title_style);
		cellWidth = "C-M".getBytes("UTF-8").length * 256;
		MaxCellWidth1 = Math.max(MaxCellWidth1, cellWidth);
		
		setCellValue(r, ++n, "부서", title_style);
		cellWidth = "부서".getBytes("UTF-8").length * 256;
		MaxCellWidth2 = Math.max(MaxCellWidth2, cellWidth);
		
		setCellValue(r, ++n, "폴더", title_style);
		cellWidth = "폴더".getBytes("UTF-8").length * 256;
		MaxCellWidth3 = Math.max(MaxCellWidth3, cellWidth);
		
		setCellValue(r, ++n, "등록", title_style);
		cellWidth = "등록".getBytes("UTF-8").length * 256;
		MaxCellWidth4 = Math.max(MaxCellWidth4, cellWidth);
		
		setCellValue(r, ++n, "긴급", title_style);
		cellWidth = "긴급".getBytes("UTF-8").length * 256;
		MaxCellWidth5 = Math.max(MaxCellWidth5, cellWidth);
		
		setCellValue(r, ++n, "수정", title_style);
		cellWidth = "수정".getBytes("UTF-8").length * 256;
		MaxCellWidth6 = Math.max(MaxCellWidth6, cellWidth);
		
		setCellValue(r, ++n, "삭제", title_style);
		cellWidth = "삭제".getBytes("UTF-8").length * 256;
		MaxCellWidth7 = Math.max(MaxCellWidth7, cellWidth);
		
		setCellValue(r, ++n, "수행", title_style);
		cellWidth = "수행".getBytes("UTF-8").length * 256;
		MaxCellWidth8 = Math.max(MaxCellWidth8, cellWidth);
		
		setCellValue(r, ++n, "엑셀등록", title_style);
		cellWidth = "엑셀등록".getBytes("UTF-8").length * 256;
		MaxCellWidth9 = Math.max(MaxCellWidth9, cellWidth);
		
		setCellValue(r, ++n, "상태변경", title_style);
		cellWidth = "상태변경".getBytes("UTF-8").length * 256;
		MaxCellWidth10 = Math.max(MaxCellWidth10, cellWidth);
		
		setCellValue(r, ++n, "TOTAL", title_style);
		cellWidth = "TOTAL".getBytes("UTF-8").length * 256;
		MaxCellWidth11 = Math.max(MaxCellWidth11, cellWidth);
		
		for( int i=0; null!=docApprovalTotalList && i<docApprovalTotalList.size(); i++ ){
			
			DocApprovalTotalBean bean 	= (DocApprovalTotalBean)docApprovalTotalList.get(i);
			
			String strDataCenter 		= CommonUtil.isNull(bean.getData_center());
			String strDeptNm 			= CommonUtil.isNull(bean.getDept_nm());
			String strTableName 		= CommonUtil.isNull(bean.getTable_name());

			String strDocNewCnt			= CommonUtil.isNull(bean.getDoc_new_cnt());
			String strDocModCnt			= CommonUtil.isNull(bean.getDoc_mod_cnt());
			String strDocDelCnt			= CommonUtil.isNull(bean.getDoc_del_cnt());
			String strDocOrdCnt			= CommonUtil.isNull(bean.getDoc_ord_cnt());
			String strDocExcelCnt		= CommonUtil.isNull(bean.getDoc_excel_cnt());
			String strDocChgCondCnt		= CommonUtil.isNull(bean.getDoc_chg_cond_cnt());
			String strDocUrgCnt			= CommonUtil.isNull(bean.getDoc_urg_cnt());
			String strTotalCnt			= CommonUtil.isNull(bean.getTotal_cnt());
			
			r++;
			n = -1;
			
			setCellValue(r, ++n, strDataCenter, center_style);
			cellWidth = strDataCenter.getBytes("UTF-8").length * 256;
			MaxCellWidth1 = Math.max(MaxCellWidth1, cellWidth);
			
			setCellValue(r, ++n, strDeptNm, center_style);
			cellWidth = strDeptNm.getBytes("UTF-8").length * 256;
			MaxCellWidth2 = Math.max(MaxCellWidth2, cellWidth);
			
			setCellValue(r, ++n, strTableName, center_style);
			cellWidth = strTableName.getBytes("UTF-8").length * 256;
			MaxCellWidth3 = Math.max(MaxCellWidth3, cellWidth);
			
			setCellValue(r, ++n, strDocNewCnt, center_style);
			cellWidth = strDocNewCnt.getBytes("UTF-8").length * 256;
			MaxCellWidth4 = Math.max(MaxCellWidth4, cellWidth);
			
			setCellValue(r, ++n, strDocUrgCnt, center_style);
			cellWidth = strDocUrgCnt.getBytes("UTF-8").length * 256;
			MaxCellWidth5 = Math.max(MaxCellWidth5, cellWidth);
			
			setCellValue(r, ++n, strDocModCnt, center_style);
			cellWidth = strDocModCnt.getBytes("UTF-8").length * 256;
			MaxCellWidth6 = Math.max(MaxCellWidth6, cellWidth);
			
			setCellValue(r, ++n, strDocDelCnt, center_style);
			cellWidth = strDocDelCnt.getBytes("UTF-8").length * 256;
			MaxCellWidth7 = Math.max(MaxCellWidth7, cellWidth);
			
			setCellValue(r, ++n, strDocOrdCnt, center_style);
			cellWidth = strDocOrdCnt.getBytes("UTF-8").length * 256;
			MaxCellWidth8 = Math.max(MaxCellWidth8, cellWidth);
			
			setCellValue(r, ++n, strDocExcelCnt, center_style);
			cellWidth = strDocExcelCnt.getBytes("UTF-8").length * 256;
			MaxCellWidth9 = Math.max(MaxCellWidth9, cellWidth);
			
			setCellValue(r, ++n, strDocChgCondCnt, center_style);
			cellWidth = strDocChgCondCnt.getBytes("UTF-8").length * 256;
			MaxCellWidth10 = Math.max(MaxCellWidth10, cellWidth);
			
			setCellValue(r, ++n, strTotalCnt, center_style);
			cellWidth = strTotalCnt.getBytes("UTF-8").length * 256;
			MaxCellWidth11 = Math.max(MaxCellWidth11, cellWidth);
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
		
		// 상단 검색조건 있는 경우 해당 타이틀로 WIDTH 조정
		sheet.setColumnWidth(0, 3000);
		
		
		// ####### 두번 째 시트 생성 #######
		List<DocInfoBean> docList = (List)request.getAttribute("docList");
		
		sheet = wb.createSheet("기간별의뢰결재현황-요청문서함");
		
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
		
		n = -1;
		r = 1;	// 상단 검색조건만큼 아래부터 시작
		
		cellWidth 			= 0;
		MaxCellWidth1 		= 0;
		MaxCellWidth2 		= 0;
		MaxCellWidth3 		= 0;
		MaxCellWidth4 		= 0;
		MaxCellWidth5 		= 0;
		MaxCellWidth6 		= 0;
		MaxCellWidth7 		= 0;
		MaxCellWidth8 		= 0;
		MaxCellWidth9 		= 0;
		MaxCellWidth10		= 0;
		MaxCellWidth11		= 0;
		int MaxCellWidth12	= 0;
		int MaxCellWidth13	= 0;
		int MaxCellWidth14	= 0;
		int MaxCellWidth15	= 0;
		
		setCellValue(r, ++n, "문서번호", title_style);
		cellWidth = "문서번호".getBytes("UTF-8").length * 256;
		MaxCellWidth1 = Math.max(MaxCellWidth1, cellWidth);
		
		setCellValue(r, ++n, "C-M", title_style);
		cellWidth = "C-M".getBytes("UTF-8").length * 256;
		MaxCellWidth2 = Math.max(MaxCellWidth2, cellWidth);
		
		setCellValue(r, ++n, "작업구분", title_style);
		cellWidth = "작업구분".getBytes("UTF-8").length * 256;
		MaxCellWidth3 = Math.max(MaxCellWidth3, cellWidth);
		
		setCellValue(r, ++n, "의뢰사유", title_style);
		cellWidth = "의뢰사유".getBytes("UTF-8").length * 256;
		MaxCellWidth4 = Math.max(MaxCellWidth4, cellWidth);
		
		setCellValue(r, ++n, "작업명", title_style);
		cellWidth = "작업명".getBytes("UTF-8").length * 256;
		MaxCellWidth5 = Math.max(MaxCellWidth5, cellWidth);
		
		setCellValue(r, ++n, "작업설명", title_style);
		cellWidth = "작업설명".getBytes("UTF-8").length * 256;
		MaxCellWidth6 = Math.max(MaxCellWidth6, cellWidth);
		
		setCellValue(r, ++n, "결재상태", title_style);
		cellWidth = "결재상태".getBytes("UTF-8").length * 256;
		MaxCellWidth7 = Math.max(MaxCellWidth7, cellWidth);
		
		setCellValue(r, ++n, "결재자", title_style);
		cellWidth = "결재자".getBytes("UTF-8").length * 256;
		MaxCellWidth8 = Math.max(MaxCellWidth8, cellWidth);
		
		setCellValue(r, ++n, "결재일자", title_style);
		cellWidth = "결재일자".getBytes("UTF-8").length * 256;
		MaxCellWidth9 = Math.max(MaxCellWidth9, cellWidth);
		
		setCellValue(r, ++n, "반려자", title_style);
		cellWidth = "반려자".getBytes("UTF-8").length * 256;
		MaxCellWidth10 = Math.max(MaxCellWidth10, cellWidth);
		
		setCellValue(r, ++n, "반려일자", title_style);
		cellWidth = "반려일자".getBytes("UTF-8").length * 256;
		MaxCellWidth11 = Math.max(MaxCellWidth11, cellWidth);
		
		setCellValue(r, ++n, "의뢰자", title_style);
		cellWidth = "의뢰자".getBytes("UTF-8").length * 256;
		MaxCellWidth12 = Math.max(MaxCellWidth12, cellWidth);
		
		setCellValue(r, ++n, "부서", title_style);
		cellWidth = "부서".getBytes("UTF-8").length * 256;
		MaxCellWidth13 = Math.max(MaxCellWidth13, cellWidth);
		
		setCellValue(r, ++n, "의뢰일자", title_style);
		cellWidth = "의뢰일자".getBytes("UTF-8").length * 256;
		MaxCellWidth14 = Math.max(MaxCellWidth14, cellWidth);
		
		setCellValue(r, ++n, "등록일자", title_style);
		cellWidth = "등록일자".getBytes("UTF-8").length * 256;
		MaxCellWidth15 = Math.max(MaxCellWidth15, cellWidth);
		
		for( int i=0; null!=docList && i<docList.size(); i++ ){
			
			DocInfoBean bean = (DocInfoBean)docList.get(i);
			
			String strDocCd		 		= CommonUtil.isNull(bean.getDoc_cd());
			String strDocGb		 		= CommonUtil.isNull(bean.getDoc_gb());
			String strDataCenter 		= CommonUtil.isNull(bean.getData_center_name());
			String strTitle 			= CommonUtil.isNull(bean.getTitle());
			String strJobName			= CommonUtil.isNull(bean.getJob_name());
			String strDescription		= CommonUtil.isNull(bean.getDescription());
			String strStateCd			= CommonUtil.isNull(bean.getState_cd());
			String strApprovalUserNm	= CommonUtil.isNull(bean.getApproval_user_nm());
			String strApprovalDate		= CommonUtil.isNull(bean.getApproval_date());
			String strRejectUserNm		= CommonUtil.isNull(bean.getReject_user_nm());
			String strRejectDate		= CommonUtil.isNull(bean.getReject_date());
			String strUserNm			= CommonUtil.isNull(bean.getUser_nm());
			String strDeptNm			= CommonUtil.isNull(bean.getDept_nm());
			String strDraftDate			= CommonUtil.isNull(bean.getDraft_date());
			String strInsDate			= CommonUtil.isNull(bean.getIns_date());
			
			strStateCd 		= CommonUtil.isNull(CommonUtil.getMessage("DOC.STATE."+strStateCd));
			strDocGb 		= CommonUtil.getMessage("DOC.GB."+strDocGb);
			
			if (strStateCd.equals("04")) { //반려상태이면 결재자,결재일자 공백
				strApprovalUserNm 	= "";
				strApprovalDate 	= "";
			}
			
			r++;
			n = -1;
			
			setCellValue(r, ++n, strDocCd, center_style);
			cellWidth = strDocCd.getBytes("UTF-8").length * 256;
			MaxCellWidth1 = Math.max(MaxCellWidth1, cellWidth);
			
			setCellValue(r, ++n, strDataCenter, center_style);
			cellWidth = strDataCenter.getBytes("UTF-8").length * 256;
			MaxCellWidth2 = Math.max(MaxCellWidth2, cellWidth);
			
			setCellValue(r, ++n, strDocGb, center_style);
			cellWidth = strDocGb.getBytes("UTF-8").length * 256;
			MaxCellWidth3 = Math.max(MaxCellWidth3, cellWidth);
			
			setCellValue(r, ++n, strTitle, center_style);
			cellWidth = strTitle.getBytes("UTF-8").length * 256;
			MaxCellWidth4 = Math.max(MaxCellWidth4, cellWidth);
			
			setCellValue(r, ++n, strJobName, center_style);
			cellWidth = strJobName.getBytes("UTF-8").length * 256;
			MaxCellWidth5 = Math.max(MaxCellWidth5, cellWidth);
			
			setCellValue(r, ++n, strDescription, center_style);
			cellWidth = strDescription.getBytes("UTF-8").length * 256;
			MaxCellWidth6 = Math.max(MaxCellWidth6, cellWidth);
			
			setCellValue(r, ++n, strStateCd, center_style);
			cellWidth = strStateCd.getBytes("UTF-8").length * 256;
			MaxCellWidth7 = Math.max(MaxCellWidth7, cellWidth);
			
			setCellValue(r, ++n, strApprovalUserNm, center_style);
			cellWidth = strApprovalUserNm.getBytes("UTF-8").length * 256;
			MaxCellWidth8 = Math.max(MaxCellWidth8, cellWidth);
			
			setCellValue(r, ++n, strApprovalDate, center_style);
			cellWidth = strApprovalDate.getBytes("UTF-8").length * 256;
			MaxCellWidth9 = Math.max(MaxCellWidth9, cellWidth);
			
			setCellValue(r, ++n, strRejectUserNm, center_style);
			cellWidth = strRejectUserNm.getBytes("UTF-8").length * 256;
			MaxCellWidth10 = Math.max(MaxCellWidth10, cellWidth);
			
			setCellValue(r, ++n, strRejectDate, center_style);
			cellWidth = strRejectDate.getBytes("UTF-8").length * 256;
			MaxCellWidth11 = Math.max(MaxCellWidth11, cellWidth);
			
			setCellValue(r, ++n, strUserNm, center_style);
			cellWidth = strUserNm.getBytes("UTF-8").length * 256;
			MaxCellWidth12 = Math.max(MaxCellWidth12, cellWidth);
			
			setCellValue(r, ++n, strDeptNm, center_style);
			cellWidth = strDeptNm.getBytes("UTF-8").length * 256;
			MaxCellWidth13 = Math.max(MaxCellWidth13, cellWidth);
			
			setCellValue(r, ++n, strDraftDate, center_style);
			cellWidth = strDraftDate.getBytes("UTF-8").length * 256;
			MaxCellWidth14 = Math.max(MaxCellWidth14, cellWidth);
			
			setCellValue(r, ++n, strInsDate, center_style);
			cellWidth = strInsDate.getBytes("UTF-8").length * 256;
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
		//sheet.setColumnWidth(0, 3000);
		
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