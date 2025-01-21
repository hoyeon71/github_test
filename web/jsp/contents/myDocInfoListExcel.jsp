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
	
	if(strDoc_gb.equals("00")) {
		fileName = "조회_반영대기목록.xlsx";
	}else if(strDoc_gb.equals("01")) {
		fileName = "조회_작업등록.xlsx";
	}else if(strDoc_gb.equals("02")) {
		fileName = "조회_수행/상태변경.xlsx";
	}else if(strDoc_gb.equals("06")) {
		fileName = "조회_엑셀일괄.xlsx";
	}else{
		fileName = "요청문서함.xlsx";
	}
	response.reset();
	response.setHeader("Content-Description", "JSP Generated Data");
	response.setHeader("Content-Type", "application/octet-stream; charset=UTF-8");
	response.setHeader("Content-Disposition", "attachment; filename="+java.net.URLEncoder.encode(fileName,"UTF-8").replaceAll("\\+","%20"));
	
// 	List<JobLogBean> endConfirmList			= (List)request.getAttribute("endConfirmList");
	List<DocInfoBean> myDocInfoList			= (List)request.getAttribute("myDocInfoList");
	
	
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
		int docCdMaxCellWidth = 0;
		int dataCenterMaxCellWidth = 0;
		int taskTypeMaxCellWidth = 0;
		int taskNmDetailMaxCellWidth = 0;
		int titleMaxCellWidth = 0;
		int jobNameMaxCellWidth = 0;
		int descriptionMaxCellWidth = 0;
		int applyCdMaxCellWidth = 0;
		int sApplyDateMaxCellWidth = 0;
		int postApprovalYnMaxCellWidth = 0;
		int stateMaxCellWidth = 0;
		int detailStatusMaxCellWidth = 0;
		int approvalUserNmMaxCellWidth = 0;
		int approvalDateMaxCellWidth = 0;
		int rejectUserNmMaxCellWidth = 0;
		int rejectCommentMaxCellWidth = 0;
		int rejectDateMaxCellWidth = 0;
		int UserNmMaxCellWidth = 0;
		int deptNmMaxCellWidth = 0;
		int draftDateMaxCellWidth = 0;
		
	
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
        
// 		setCellValue(r, ++n, "작업구분상세", style);
// 		cellWidth = "작업구분상세".getBytes("UTF-8").length * 256;
// 		taskNmDetailMaxCellWidth = Math.max(taskNmDetailMaxCellWidth, cellWidth);
        
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
        
		setCellValue(r, ++n, "결재상태", style);
		cellWidth = "결재상태".getBytes("UTF-8").length * 256;
		stateMaxCellWidth = Math.max(stateMaxCellWidth, cellWidth);
        
		setCellValue(r, ++n, "결재상세상태", style);
		cellWidth = "결재상세상태".getBytes("UTF-8").length * 256;
		detailStatusMaxCellWidth = Math.max(detailStatusMaxCellWidth, cellWidth);
        
		setCellValue(r, ++n, "결재자", style);
		cellWidth = "결재자".getBytes("UTF-8").length * 256;
		approvalUserNmMaxCellWidth = Math.max(approvalUserNmMaxCellWidth, cellWidth);
        
		setCellValue(r, ++n, "결재일자", style);
		cellWidth = "결재일자".getBytes("UTF-8").length * 256;
		approvalDateMaxCellWidth = Math.max(approvalDateMaxCellWidth, cellWidth);
        
		setCellValue(r, ++n, "반려자", style);
		cellWidth = "반려자".getBytes("UTF-8").length * 256;
		rejectUserNmMaxCellWidth = Math.max(rejectUserNmMaxCellWidth, cellWidth);
        
 		setCellValue(r, ++n, "반려사유", style);
 		cellWidth = "반려사유".getBytes("UTF-8").length * 256;
 		rejectCommentMaxCellWidth = Math.max(rejectCommentMaxCellWidth, cellWidth);
        
		setCellValue(r, ++n, "반려일자", style);
		cellWidth = "반려일자".getBytes("UTF-8").length * 256;
		rejectDateMaxCellWidth = Math.max(rejectDateMaxCellWidth, cellWidth);
		
		setCellValue(r, ++n, "의뢰자", style);
		cellWidth = "의뢰자".getBytes("UTF-8").length * 256;
		UserNmMaxCellWidth = Math.max(UserNmMaxCellWidth, cellWidth);
		
		setCellValue(r, ++n, "부서", style);
		cellWidth = "부서".getBytes("UTF-8").length * 256;
		deptNmMaxCellWidth = Math.max(deptNmMaxCellWidth, cellWidth);
		
		setCellValue(r, ++n, "의뢰일자", style);
		cellWidth = "의뢰일자".getBytes("UTF-8").length * 256;
		draftDateMaxCellWidth = Math.max(draftDateMaxCellWidth, cellWidth);
		
		// 가운데 정렬 스타일
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
		
		
		for( int i=0; null!=myDocInfoList && i<myDocInfoList.size(); i++ ){
			
			DocInfoBean bean 			= (DocInfoBean)myDocInfoList.get(i);
			
			String v_task_type = "";
			String task_nm_detail 			= CommonUtil.E2K(bean.getTask_nm_detail());
			String task_type 				= CommonUtil.E2K(bean.getTask_type());
			String doc_gb_org 				= CommonUtil.E2K(bean.getDoc_gb());
			String critical 				= CommonUtil.E2K(bean.getCritical());
			String line_approval 			= CommonUtil.E2K(bean.getLine_approval());
			String return_line_approval		= CommonUtil.E2K(bean.getReturn_line_approval());
			String state_cd					= CommonUtil.isNull(bean.getState_cd());
			String state_nm					= CommonUtil.getMessage("DOC.STATE."+bean.getState_cd());
			String dept_nm					= CommonUtil.isNull(bean.getDept_nm());
			String odate					= CommonUtil.isNull(bean.getOdate());
			String approval_user_nm			= CommonUtil.isNull(bean.getApproval_user_nm());
			String approval_date			= CommonUtil.isNull(bean.getApproval_date());
			String reject_user_nm			= CommonUtil.isNull(bean.getReject_user_nm());
			String reject_comment			= CommonUtil.isNull(bean.getReject_comment());
			String reject_date				= CommonUtil.isNull(bean.getReject_date());
			String post_approval_yn			= CommonUtil.isNull(bean.getPost_approval_yn()); //결재방법
			String detail_status			= CommonUtil.isNull(bean.getDetail_status()); //결재상세상태
			String alarm_user				= CommonUtil.isNull(bean.getAlarm_user());
			String strDataCenterName		= CommonUtil.isNull(bean.getData_center_name());
			String strDocGroupId			= CommonUtil.isNull(bean.getDoc_group_id());
			
			if (state_cd.equals("04")) {
				approval_user_nm = "";
				approval_date = "";
			}
			
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
			
			if(post_approval_yn.equals("N")){
				post_approval_yn = "순차";
			}else if(post_approval_yn.equals("Y")) {
				post_approval_yn = "후결";
			}else if(post_approval_yn.equals("A")){
				post_approval_yn = "즉시결재";
			}else{
				post_approval_yn = "";
			}
			
			if(state_nm.equals("완결")) {
				detail_status = "결재완료";
			}else if(state_nm.equals("저장")){ 
				detail_status = "";
			}else{
				if(detail_status.equals("")){
					detail_status = " 결재대기 (" + alarm_user + ")";
				}else {
					detail_status =  " 결재대기 (" + detail_status + ")";
				}
			}
			
			//결재선
			String v_line_approval				= "";
			String[] line_approval_arr			= line_approval.split(",");
			String approval_gb 					= "";
			String[] return_line_approval_arr	= null;
			
			if (line_approval_arr.length > 1) {
				approval_gb = line_approval_arr[1];
				if(state_cd.equals("04")){ //반려상태는 쿼리에서 결재구분을 따로 받아옴
					return_line_approval_arr = return_line_approval.split(",");
					if(return_line_approval_arr.length > 1){
						approval_gb = return_line_approval_arr[1];
					}
				}
			}
			
			String[] arr_user_appr_gb_nm = CommonUtil.getGbNm("USER.APPR.GB").split(",");
			for (int a = 0; a < arr_user_appr_gb_nm.length; a++) {
				if (approval_gb.equals("0"+(a+1))) {
					v_line_approval = "["+arr_user_appr_gb_nm[a]+"]";
				}
			}
			
			r++;
			n = -1;
			
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
	        
			setCellValue(r, ++n, (state_nm+v_line_approval), style);
			cellWidth = (state_nm+v_line_approval).getBytes("UTF-8").length * 256;
			stateMaxCellWidth = Math.max(stateMaxCellWidth, cellWidth);
	        
			setCellValue(r, ++n, detail_status, style);
			cellWidth = detail_status.getBytes("UTF-8").length * 256;
			detailStatusMaxCellWidth = Math.max(detailStatusMaxCellWidth, cellWidth);
	        
			setCellValue(r, ++n, approval_user_nm, style);
			cellWidth = approval_user_nm.getBytes("UTF-8").length * 256;
			approvalUserNmMaxCellWidth = Math.max(approvalUserNmMaxCellWidth, cellWidth);
	        
			setCellValue(r, ++n, approval_date, style);
			cellWidth = approval_date.getBytes("UTF-8").length * 256;
			approvalDateMaxCellWidth = Math.max(approvalDateMaxCellWidth, cellWidth);
	        
			setCellValue(r, ++n, reject_user_nm, style);
			cellWidth = reject_user_nm.getBytes("UTF-8").length * 256;
			rejectUserNmMaxCellWidth = Math.max(rejectUserNmMaxCellWidth, cellWidth);
	        
			setCellValue(r, ++n, reject_comment, style);
			cellWidth = reject_comment.getBytes("UTF-8").length * 256;
			rejectCommentMaxCellWidth = Math.max(rejectCommentMaxCellWidth, cellWidth);
			
			setCellValue(r, ++n, reject_date, style);
			cellWidth = reject_date.getBytes("UTF-8").length * 256;
			rejectDateMaxCellWidth = Math.max(rejectDateMaxCellWidth, cellWidth);
			
			setCellValue(r, ++n, CommonUtil.E2K(bean.getUser_nm()), style);
			cellWidth = CommonUtil.E2K(bean.getUser_nm()).getBytes("UTF-8").length * 256;
			UserNmMaxCellWidth = Math.max(UserNmMaxCellWidth, cellWidth);
			
			setCellValue(r, ++n, dept_nm, style);
			cellWidth = dept_nm.getBytes("UTF-8").length * 256;
			deptNmMaxCellWidth = Math.max(deptNmMaxCellWidth, cellWidth);
			
			setCellValue(r, ++n, CommonUtil.getDateFormat(1,bean.getDraft_date()), style);
			cellWidth = CommonUtil.getDateFormat(1,bean.getDraft_date()).getBytes("UTF-8").length * 256;
			draftDateMaxCellWidth = Math.max(draftDateMaxCellWidth, cellWidth);
			
		}
			
		n = -1;
		
		CommonUtil.setAutoSizeColumn(sheet, ++n, numMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, docCdMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, dataCenterMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, taskTypeMaxCellWidth);
// 		CommonUtil.setAutoSizeColumn(sheet, ++n, taskNmDetailMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, titleMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, jobNameMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, descriptionMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, applyCdMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, sApplyDateMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, postApprovalYnMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, stateMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, detailStatusMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, approvalUserNmMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, approvalDateMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, rejectUserNmMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, rejectCommentMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, rejectDateMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, UserNmMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, deptNmMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, draftDateMaxCellWidth);
		
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
