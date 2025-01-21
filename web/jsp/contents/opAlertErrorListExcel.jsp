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
<%@page import="org.apache.poi.ss.usermodel.DataFormat"%>

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
	String menu_gb = CommonUtil.getMessage("CATEGORY.GB.04.GB."+CommonUtil.isNull(paramMap.get("menu_gb")));
	String[] arr_menu_gb = menu_gb.split(",");
	
	OutputStream os = null;
	sheet = null;
	wb = new SXSSFWorkbook();
	
	String fileName = "오류관리.xlsx"; 
	response.reset() ;
	response.setHeader("Content-Description", "JSP Generated Data");
	response.setHeader("Content-Type", "application/octet-stream; charset=UTF-8");
	response.setHeader("Content-Disposition", "attachment; filename="+java.net.URLEncoder.encode(fileName,"UTF-8").replaceAll("\\+","%20"));
	
	String from_odate 			= CommonUtil.isNull(paramMap.get("p_from_odate"));
	String to_odate				= CommonUtil.isNull(paramMap.get("p_to_odate"));
	List<AlertBean> alertList	= (List)request.getAttribute("alertList");
	
	
	PopupDefJobDetailService popupDefJobDetailService 	= (PopupDefJobDetailService)ContextLoader.getCurrentWebApplicationContext().getBean("mPopupDefJobDetailService");
	
%>

<%
	try {
		sheet = wb.createSheet("Sheet1");
		sheet.addMergedRegion(new CellRangeAddress(0, 0, 0, 3));
		format = wb.createDataFormat();
		style	= wb.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setFillForegroundColor(HSSFColor.WHITE.index); 
		style.setFillPattern(XSSFCellStyle.SOLID_FOREGROUND);
		style.setBorderRight(XSSFCellStyle.BORDER_THIN);
		style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
		style.setBorderTop(XSSFCellStyle.BORDER_THIN);
		style.setBorderBottom(XSSFCellStyle.BORDER_THIN);	
		style.setDataFormat(format.getFormat("@")); // "@"은 텍스트 형식
		setCellValue(0, 0, "오류관리 ("+from_odate + " ~ " + to_odate+")", style);
		
		
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
		int r = 1;
		int numMaxCellWidth					= 0; // 순번
		int schedTableMaxCellWidth			= 0; // 폴더
		int jobSchedGbMentMaxCellWidth		= 0; // 작업종류
		int jobNameMaxCellWidth				= 0; // 작업명
		int runCounterMaxlCellWidth			= 0; // 수행횟수
		int cyclicMaxlCellWidth				= 0; // 반복여부
		int hostTimeMaxlCellWidth			= 0; // 발생시간
		int massageMaxlCellWidth			= 0; // 메세지
		int userNmMaxCellWidth				= 0; // 담당자
		int actionYnMaxCellWidth			= 0; // 처리여부
		int updateUserNmMaxCellWidth		= 0; // 처리자
		int updateTimeMaxCellWidth			= 0; // 처리시간
		int errorDescriptionMaxCellWidth	= 0; // 원인 및 처리내용
		
		int cellWidth = 0;

		setCellValue(r, ++n, "순번", style);
		cellWidth = "순번".getBytes("UTF-8").length * 256;
		numMaxCellWidth = Math.max(numMaxCellWidth, cellWidth);
		
		setCellValue(r, ++n, "작업종류", style);
		cellWidth = "작업종류".getBytes("UTF-8").length * 256;
		jobSchedGbMentMaxCellWidth = Math.max(jobSchedGbMentMaxCellWidth, cellWidth);
		
		setCellValue(r, ++n, "폴더", style);
		cellWidth = "폴더".getBytes("UTF-8").length * 256;
		schedTableMaxCellWidth = Math.max(schedTableMaxCellWidth, cellWidth);
		
		setCellValue(r, ++n, "작업명", style);
		cellWidth = "작업명".getBytes("UTF-8").length * 256;
		jobNameMaxCellWidth = Math.max(jobNameMaxCellWidth, cellWidth);
		
		setCellValue(r, ++n, "수행횟수", style);
		cellWidth = "수행횟수".getBytes("UTF-8").length * 256;
		runCounterMaxlCellWidth = Math.max(runCounterMaxlCellWidth, cellWidth);
		
		setCellValue(r, ++n, "반복여부", style);
		cellWidth = "반복여부".getBytes("UTF-8").length * 256;
		cyclicMaxlCellWidth = Math.max(cyclicMaxlCellWidth, cellWidth);
		
		setCellValue(r, ++n, "발생시간", style);
		cellWidth = "발생시간".getBytes("UTF-8").length * 256;
		hostTimeMaxlCellWidth = Math.max(hostTimeMaxlCellWidth, cellWidth);
		
		setCellValue(r, ++n, "메세지", style);
		cellWidth = "메세지".getBytes("UTF-8").length * 256;
		massageMaxlCellWidth = Math.max(massageMaxlCellWidth, cellWidth);
		
		setCellValue(r, ++n, "담당자", style);
		cellWidth = "담당자".getBytes("UTF-8").length * 256;
		userNmMaxCellWidth = Math.max(userNmMaxCellWidth, cellWidth);
		
		setCellValue(r, ++n, "결재여부", style);
		cellWidth = "처리여부".getBytes("UTF-8").length * 256;
		actionYnMaxCellWidth = Math.max(actionYnMaxCellWidth, cellWidth);
		
		setCellValue(r, ++n, "처리자", style);
		cellWidth = "처리자".getBytes("UTF-8").length * 256;
		updateUserNmMaxCellWidth = Math.max(updateUserNmMaxCellWidth, cellWidth);
		
		setCellValue(r, ++n, "처리시간", style);
		cellWidth = "처리시간".getBytes("UTF-8").length * 256;
		updateTimeMaxCellWidth = Math.max(updateTimeMaxCellWidth, cellWidth);
		
		setCellValue(r, ++n, "오류조치", style);
		cellWidth = "오류조치".getBytes("UTF-8").length * 256;
		errorDescriptionMaxCellWidth = Math.max(errorDescriptionMaxCellWidth, cellWidth);
		
		
	
		format = wb.createDataFormat();
		style = wb.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setBorderRight(XSSFCellStyle.BORDER_THIN);
		style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
		style.setBorderTop(XSSFCellStyle.BORDER_THIN);
		style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
		style.setWrapText(true);
		style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		style.setDataFormat(format.getFormat("@")); // "@"은 텍스트 형식
		
		// 왼쪽 정렬 스타일
		style2 = wb.createCellStyle();
		style2.setAlignment(XSSFCellStyle.ALIGN_LEFT);
		style2.setBorderRight(XSSFCellStyle.BORDER_THIN);
		style2.setBorderLeft(XSSFCellStyle.BORDER_THIN);
		style2.setBorderTop(XSSFCellStyle.BORDER_THIN);
		style2.setBorderBottom(XSSFCellStyle.BORDER_THIN);
		style2.setDataFormat(format.getFormat("@")); // "@"은 텍스트 형식
		
		for( int i=0; null!=alertList && i<alertList.size(); i++ ){
			
			AlertBean bean 			= (AlertBean)alertList.get(i);
			
//	 		String strDataCenter 			= CommonUtil.isNull(CommonUtil.E2K(bean.getData_center()));
//	 		String strApplication 			= CommonUtil.isNull(CommonUtil.E2K(bean.getApplication()));
//	 		String strGroupName 			= CommonUtil.isNull(CommonUtil.E2K(bean.getGroup_name()));
			String strJobSchedGb			= CommonUtil.isNull(bean.getJobschedgb());
			String strJobName 				= CommonUtil.isNull(CommonUtil.E2K(bean.getJob_name()), CommonUtil.E2K(bean.getMemname()));
			String strHostTime 				= CommonUtil.isNull(CommonUtil.E2K(bean.getHost_time()));
			String strUpdateTime			= CommonUtil.isNull(CommonUtil.E2K(bean.getUpdate_time()));
			String strUpdateUserNm			= CommonUtil.isNull(CommonUtil.E2K(bean.getUpdate_user_nm()));
			String strErrorDescription		= CommonUtil.replaceStrHtml(CommonUtil.isNull(CommonUtil.E2K(bean.getError_description())));
			String strMessage				= CommonUtil.isNull(CommonUtil.E2K(bean.getMessage()));
			String strDeptNm 				= CommonUtil.isNull(CommonUtil.E2K(bean.getDept_nm()));
			String strDutyNm				= CommonUtil.isNull(CommonUtil.E2K(bean.getDuty_nm()));
			String strUserNm 				= CommonUtil.isNull(CommonUtil.E2K(bean.getUser_nm()));
			String strUserDailyYn			= CommonUtil.isNull(CommonUtil.E2K(bean.getUser_daily_yn()));
			String strOrderTable			= CommonUtil.isNull(CommonUtil.E2K(bean.getOrder_table()));
			String strActionYn				= CommonUtil.isNull(CommonUtil.E2K(bean.getAction_yn()));
			String strConfirmYn				= CommonUtil.isNull(CommonUtil.E2K(bean.getConfirm_yn()));
			String strConfirmUserNm			= CommonUtil.isNull(CommonUtil.E2K(bean.getConfirm_user_nm()));
			String strConfirmTime			= CommonUtil.isNull(CommonUtil.E2K(bean.getConfirm_time()));
			String strRunCounter			= CommonUtil.isNull(bean.getRun_counter());
			String strTableNm				= CommonUtil.isNull(bean.getOrder_table());
			String strCyclic				= CommonUtil.isNull(bean.getCyclic());
			
			if(!strErrorDescription.equals("")){
				strErrorDescription = strErrorDescription.replaceAll("(\r\n|\r|\n|\n\r)", "\n");
			}
			String jobschedgb_ment		= "";
			String jobschedgb_config	= CommonUtil.getMessage("USER_DAILY.SYSTEM.GB");
			String[] jobschedgb_arr 	= jobschedgb_config.split(",");
			
			if(strActionYn.equals("")) {
				strActionYn = "N";
			}
			//if ( strJobSchedGb != "" ) { 
				for ( int ii = 0; ii < jobschedgb_arr.length; ii++ ) {
					if ( jobschedgb_arr[ii].split("[|]")[0].equals(strUserDailyYn) ) {
						jobschedgb_ment = jobschedgb_arr[ii].split("[|]")[1];
					}
				}
			//}
			
			
			if(strCyclic.equals("0")){
				strCyclic = "N";
			}else {
				strCyclic = "Y";
			}
			r++;
			n = -1;
			
			setCellValue(r, ++n, Integer.toString(i+1), style);
			cellWidth = Integer.toString(i+1).getBytes("UTF-8").length * 256;
			numMaxCellWidth = Math.max(numMaxCellWidth, cellWidth);
			
			setCellValue(r, ++n, jobschedgb_ment, style);
			cellWidth = jobschedgb_ment.getBytes("UTF-8").length * 256;
			jobSchedGbMentMaxCellWidth = Math.max(jobSchedGbMentMaxCellWidth, cellWidth);
			
			setCellValue(r, ++n, strTableNm, style);
			cellWidth = strTableNm.getBytes("UTF-8").length * 256;
			schedTableMaxCellWidth = Math.max(schedTableMaxCellWidth, cellWidth);
			
			setCellValue(r, ++n, CommonUtil.replaceStrHtml(strJobName), style2);
			cellWidth = strJobName.getBytes("UTF-8").length * 256;
			jobNameMaxCellWidth = Math.max(jobNameMaxCellWidth, cellWidth);
			
			setCellValue(r, ++n, strRunCounter, style);
			cellWidth = strRunCounter.getBytes("UTF-8").length * 256;
			runCounterMaxlCellWidth = Math.max(runCounterMaxlCellWidth, cellWidth);
			
			setCellValue(r, ++n, strCyclic, style);
			cellWidth = strRunCounter.getBytes("UTF-8").length * 256;
			cyclicMaxlCellWidth = Math.max(cyclicMaxlCellWidth, cellWidth);
			
			setCellValue(r, ++n, strHostTime, style);
			cellWidth = strHostTime.getBytes("UTF-8").length * 256;
			hostTimeMaxlCellWidth = Math.max(hostTimeMaxlCellWidth, cellWidth);
			
			setCellValue(r, ++n, strMessage, style);
			cellWidth = strMessage.getBytes("UTF-8").length * 256;
			massageMaxlCellWidth = Math.max(massageMaxlCellWidth, cellWidth);
			
			setCellValue(r, ++n, strUserNm, style);
			cellWidth = strUserNm.getBytes("UTF-8").length * 256;
			userNmMaxCellWidth = Math.max(userNmMaxCellWidth, cellWidth);
			
			setCellValue(r, ++n, strActionYn, style);
			cellWidth = strActionYn.getBytes("UTF-8").length * 256;
			actionYnMaxCellWidth = Math.max(actionYnMaxCellWidth, cellWidth);
			
			setCellValue(r, ++n, strUpdateUserNm, style);
			cellWidth = strUpdateUserNm.getBytes("UTF-8").length * 256;
			updateUserNmMaxCellWidth = Math.max(updateUserNmMaxCellWidth, cellWidth);
			
			setCellValue(r, ++n, strUpdateTime, style);
			cellWidth = strUpdateTime.getBytes("UTF-8").length * 256;
			updateTimeMaxCellWidth = Math.max(updateTimeMaxCellWidth, cellWidth);
			
			setCellValue(r, ++n, strErrorDescription, style);
			cellWidth = strErrorDescription.getBytes("UTF-8").length * 256;
			errorDescriptionMaxCellWidth = Math.max(errorDescriptionMaxCellWidth, cellWidth);
			
			
		}
		
		n = -1;
			
		CommonUtil.setAutoSizeColumn(sheet, ++n, numMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, jobSchedGbMentMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, schedTableMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, jobNameMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, runCounterMaxlCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, cyclicMaxlCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, hostTimeMaxlCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, massageMaxlCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, userNmMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, actionYnMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, updateUserNmMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, updateTimeMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, errorDescriptionMaxCellWidth);

		
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
