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
	String menu_gb = CommonUtil.getMessage("CATEGORY.GB.02.GB."+CommonUtil.isNull(paramMap.get("menu_gb")));
	String[] arr_menu_gb = menu_gb.split(",");
	
	OutputStream os = null;
	sheet = null;
	wb = new SXSSFWorkbook();
	
	String fileName = "";
	String strDoc_gb = CommonUtil.isNull(paramMap.get("p_s_doc_gb"));
	fileName = "결재문서함.xlsx";
	
	response.reset() ;
	response.setHeader("Content-Description", "JSP Generated Data");
	response.setHeader("Content-Type", "application/octet-stream; charset=UTF-8");
	response.setHeader("Content-Disposition", "attachment; filename="+java.net.URLEncoder.encode(fileName,"UTF-8").replaceAll("\\+","%20"));
	
	List approvalDocInfoList	= (List)request.getAttribute("approvalDocInfoList");
	String p_s_doc_gb 			= CommonUtil.isNull(paramMap.get("p_s_doc_gb"));
	
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
		int docCdMaxCellWidth = 0;
		int dataCenterMaxCellWidth = 0;
		int taskTypeMaxCellWidth = 0;
		int taskNmDetailMaxCellWidth = 0;
		int titleMaxCellWidth = 0;
		int jobNameMaxCellWidth = 0;
		int descriptionMaxCellWidth = 0;
		int applyCdMaxCellWidth = 0;
		int postApprovalYnMaxCellWidth = 0;
		int sApplyDateMaxCellWidth = 0;
		int darftDateMaxCellWidth = 0;
		int userInfoMaxCellWidth = 0;
		
		int cellWidth = 0;
		
		setCellValue(r, ++n, "순번", style);
		cellWidth = "순번".getBytes("UTF-8").length * 256;
		numMaxCellWidth = Math.max(numMaxCellWidth, cellWidth);
        
		setCellValue(r, ++n, "문서번호", style);
		cellWidth = "문서번호".getBytes("UTF-8").length * 256;
		docCdMaxCellWidth = Math.max(docCdMaxCellWidth, cellWidth);
        
		setCellValue(r, ++n, "C-M", style);
		cellWidth = "C-M".getBytes("UTF-8").length * 256;
		dataCenterMaxCellWidth = Math.max(dataCenterMaxCellWidth, cellWidth);
        
		setCellValue(r, ++n, "작업구분", style);
		cellWidth = "작업구분".getBytes("UTF-8").length * 256;
		taskTypeMaxCellWidth = Math.max(taskTypeMaxCellWidth, cellWidth);
        
		setCellValue(r, ++n, "의뢰사유", style);
		cellWidth = "의뢰사유".getBytes("UTF-8").length * 256;
		titleMaxCellWidth = Math.max(titleMaxCellWidth, cellWidth);
		
		setCellValue(r, ++n, "작업명", style);
		cellWidth = "작업명".getBytes("UTF-8").length * 256;
		jobNameMaxCellWidth = Math.max(jobNameMaxCellWidth, cellWidth);
        
		setCellValue(r, ++n, "작업설명", style);
		cellWidth = "작업설명".getBytes("UTF-8").length * 256;
		descriptionMaxCellWidth = Math.max(descriptionMaxCellWidth, cellWidth);
        
		setCellValue(r, ++n, "반영상태", style);
		cellWidth = "반영상태".getBytes("UTF-8").length * 256;
		applyCdMaxCellWidth = Math.max(applyCdMaxCellWidth, cellWidth);

		setCellValue(r, ++n, "반영일", style);
		cellWidth = "반영일".getBytes("UTF-8").length * 256;
		sApplyDateMaxCellWidth = Math.max(sApplyDateMaxCellWidth, cellWidth);

		setCellValue(r, ++n, "결재방법", style);
		cellWidth = "결재방법".getBytes("UTF-8").length * 256;
		postApprovalYnMaxCellWidth = Math.max(postApprovalYnMaxCellWidth, cellWidth);

// 		setCellValue(r, ++n, "결재상태", style);
// 		cellWidth = "결재상태".getBytes("UTF-8").length * 256;
// 		sApplyDateMaxCellWidth = Math.max(sApplyDateMaxCellWidth, cellWidth);
        
		setCellValue(r, ++n, "의뢰일자", style);
		cellWidth = "의뢰일자".getBytes("UTF-8").length * 256;
		darftDateMaxCellWidth = Math.max(darftDateMaxCellWidth, cellWidth);
        
		setCellValue(r, ++n, "의뢰자", style);
		cellWidth = "의뢰자".getBytes("UTF-8").length * 256;
		userInfoMaxCellWidth = Math.max(userInfoMaxCellWidth, cellWidth);
        
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
		
		
		for( int i=0; null!=approvalDocInfoList && i<approvalDocInfoList.size(); i++ ){
			
			DocInfoBean bean = (DocInfoBean)approvalDocInfoList.get(i);
			
			String v_task_type 			= "";
			String strDocCd 			= CommonUtil.isNull(bean.getDoc_cd());
			String doc_gb_org 			= CommonUtil.isNull(bean.getDoc_gb());
			String task_nm_detail 		= CommonUtil.E2K(bean.getTask_nm_detail());
			String task_type 			= CommonUtil.E2K(bean.getTask_type());
			String strTitle 			= CommonUtil.E2K(bean.getTitle());
			String strJobName 			= CommonUtil.E2K(bean.getJob_name());
			String strDescription 		= CommonUtil.E2K(bean.getDescription());
			String strStateNm 			= CommonUtil.getMessage("DOC.STATE."+bean.getState_cd());
			String strApprovalDate	 	= CommonUtil.getDateFormat(1,bean.getApproval_date());
			String strDraftDate 		= CommonUtil.getDateFormat(1,bean.getDraft_date());
			String userInfo 			= "["+CommonUtil.E2K(bean.getDept_nm())+"] ["+CommonUtil.E2K(bean.getDuty_nm())+"] "+CommonUtil.E2K(bean.getUser_nm());
			String post_approval_yn		= CommonUtil.isNull(bean.getPost_approval_yn());
			String strDataCenterName	= CommonUtil.isNull(bean.getData_center_name());
			String strDocGroupId		= CommonUtil.isNull(bean.getDoc_group_id());
			
			//docGb에 따라서 출력 필드가 다름
			String strSApplyDate 	= CommonUtil.isNull(bean.getS_apply_date());
			String strOdate			= CommonUtil.isNull(bean.getOdate());
			
			if (doc_gb_org.equals("01")){
				v_task_type 	= "등록의뢰";
				task_nm_detail 	= "신규";
			} else if (doc_gb_org.equals("02")){
				v_task_type 	= "수행";
				task_nm_detail 	= "일회성";
			} else if (doc_gb_org.equals("03")){
				v_task_type = "삭제의뢰";
			} else if (doc_gb_org.equals("04")){
				v_task_type = "수정의뢰";
			} else if (doc_gb_org.equals("05") && strDocGroupId.equals("") ){
				v_task_type = "수행";
				task_nm_detail = "";
			} else if (doc_gb_org.equals("05") && !strDocGroupId.equals("") ){
				v_task_type = "수행";
				task_nm_detail = "그룹";
			} else if (doc_gb_org.equals("06") ) {
				v_task_type = "엑셀의뢰";
				if ( task_type.equals("C") ) {
					task_nm_detail = "신규";
				} else if ( task_type.equals("U") ) {
					task_nm_detail = "수정";
				} else if ( task_type.equals("D") ) {
					task_nm_detail = "삭제";
				}
			} else if (doc_gb_org.equals("07")){
				v_task_type = "상태변경";
			} else if (doc_gb_org.equals("08")){
				v_task_type = "예약상태변경";
			}
			
			if(post_approval_yn.equals("N")) {
				post_approval_yn = "순차";
			}else if(post_approval_yn.equals("Y")){
				post_approval_yn = "후결";
			}else if(post_approval_yn.equals("A")){
				post_approval_yn = "즉시결재";
			}else{
				post_approval_yn = "";
			}
			
			r++;
			n = -1;
			
			
			String doc_gb = CommonUtil.isNull(bean.getDoc_gb());
			String task_detail = "";
			String task_nm = "";

			if(CommonUtil.isNull(bean.getDoc_gb()).equals("05") && !CommonUtil.isNull(bean.getDoc_group_id()).equals("")){
				doc_gb 		= doc_gb + "G";
				task_nm    	= CommonUtil.getMessage("DOC.GB."+doc_gb);
			}else if(CommonUtil.isNull(bean.getDoc_gb()).equals("06") || CommonUtil.isNull(bean.getDoc_gb()).equals("09")){
				task_nm    	= CommonUtil.getMessage("DOC.GB." + doc_gb + CommonUtil.isNull(bean.getTask_nm_detail()));
			}else {
				task_nm 	= CommonUtil.getMessage("DOC.GB."+doc_gb);
			}

			String title = CommonUtil.isNull(bean.getTitle());
			if(CommonUtil.isNull(bean.getDoc_gb()).equals("07") && !CommonUtil.isNull(bean.getPost_approval_yn()).equals("A")) {
				task_detail   = "[" + CommonUtil.isNull(bean.getTask_nm_detail()) + "]";
				title = task_detail + title;
			}
			
			setCellValue(r, ++n, Integer.toString(i+1), style);
			cellWidth = Integer.toString(i+1).getBytes("UTF-8").length * 256;
			numMaxCellWidth = Math.max(numMaxCellWidth, cellWidth);
	        
			setCellValue(r, ++n, bean.getDoc_cd(), style);
			cellWidth = bean.getDoc_cd().getBytes("UTF-8").length * 256;
			docCdMaxCellWidth = Math.max(docCdMaxCellWidth, cellWidth);
	        
			setCellValue(r, ++n, strDataCenterName, style);
			cellWidth = strDataCenterName.getBytes("UTF-8").length * 256;
			dataCenterMaxCellWidth = Math.max(dataCenterMaxCellWidth, cellWidth);
	        
			setCellValue(r, ++n, task_nm, style);
			cellWidth = task_nm.getBytes("UTF-8").length * 256;
			taskTypeMaxCellWidth = Math.max(taskTypeMaxCellWidth, cellWidth);
	        
			setCellValue(r, ++n, CommonUtil.replaceStrHtml(title), style2);
			cellWidth = title.getBytes("UTF-8").length * 256;
			titleMaxCellWidth = Math.max(titleMaxCellWidth, cellWidth);
	        
			setCellValue(r, ++n, CommonUtil.replaceStrHtml(CommonUtil.E2K(bean.getJob_name())), style2);
			cellWidth = CommonUtil.E2K(bean.getJob_name()).getBytes("UTF-8").length * 256;
			jobNameMaxCellWidth = Math.max(jobNameMaxCellWidth, cellWidth);
	        
			setCellValue(r, ++n, CommonUtil.replaceStrHtml(CommonUtil.E2K(bean.getDescription())), style2);
			cellWidth = CommonUtil.E2K(bean.getDescription()).getBytes("UTF-8").length * 256;
			descriptionMaxCellWidth = Math.max(descriptionMaxCellWidth, cellWidth);
	        
			setCellValue(r, ++n, CommonUtil.getMessage("APPLY.STATE."+CommonUtil.isNull(bean.getApply_cd())), style);
			cellWidth = CommonUtil.getMessage("APPLY.STATE."+CommonUtil.isNull(bean.getApply_cd())).getBytes("UTF-8").length * 256;
			applyCdMaxCellWidth = Math.max(applyCdMaxCellWidth, cellWidth);

			setCellValue(r, ++n, CommonUtil.getDateFormat(1,bean.getS_apply_date()), style);
			cellWidth = CommonUtil.getDateFormat(1,bean.getS_apply_date()).getBytes("UTF-8").length * 256;
			sApplyDateMaxCellWidth = Math.max(sApplyDateMaxCellWidth, cellWidth);

			setCellValue(r, ++n, post_approval_yn, style);
			cellWidth = post_approval_yn.getBytes("UTF-8").length * 256;
			postApprovalYnMaxCellWidth = Math.max(postApprovalYnMaxCellWidth, cellWidth);

			setCellValue(r, ++n, strDraftDate, style);
			cellWidth = strDraftDate.getBytes("UTF-8").length * 256;
			darftDateMaxCellWidth = Math.max(darftDateMaxCellWidth, cellWidth);
			
			setCellValue(r, ++n, userInfo, style);
			cellWidth = userInfo.getBytes("UTF-8").length * 256;
			userInfoMaxCellWidth = Math.max(userInfoMaxCellWidth, cellWidth);
			
	        
	        
						
			((SXSSFSheet) sheet).flushRows(10000);
		}
			
		n = -1;
		
		CommonUtil.setAutoSizeColumn(sheet, ++n, numMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, docCdMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, dataCenterMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, taskTypeMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, titleMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, jobNameMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, descriptionMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, applyCdMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, sApplyDateMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, postApprovalYnMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, darftDateMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, userInfoMaxCellWidth);
		
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
