<%@page import="org.apache.poi.ss.util.CellRangeAddress"%>
<%@page import="org.apache.poi.util.SystemOutLogger"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.ghayoun.ezjobs.a.domain.*"%>
<%@page import="com.ghayoun.ezjobs.m.service.*"%>
<%@ page import="com.ghayoun.ezjobs.m.domain.*" %>

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
	
	String fileName = "작업수행관리.xlsx"; 
	response.reset() ;
	response.setHeader("Content-Description", "JSP Generated Data");
	response.setHeader("Content-Type", "application/octet-stream; charset=UTF-8");
	response.setHeader("Content-Disposition", "attachment; filename="+java.net.URLEncoder.encode(fileName,"UTF-8").replaceAll("\\+","%20"));
%>
<%	
	List jobLogList		= (List)request.getAttribute("jobLogList");
	
	String data_center 	= CommonUtil.isNull(paramMap.get("data_center"));
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />

</head>

<body>

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
		int numMaxCellWidth					= 0; // 순번
		int odateMaxCellWidth				= 0; // odate
		int startTimeMaxCellWidth			= 0; // 시작일시
		int endTimeMaxCellWidth				= 0; // 종료일시
		int fromTimeMaxCellWidth			= 0; // 시작시간
		int runTimeMaxCellWidth				= 0; // 수행시간
		int rerunCounterMaxlCellWidth		= 0; // 실행횟수
		int jobNameMaxCellWidth				= 0; // 작업명
		int descriptionMaxCellWidth			= 0; // 작업설명
		int stateResultMaxCellWidth			= 0; // 상태
// 		int deptNmMaxCellWidth				= 0; // 부서
		int userNmMaxCellWidth				= 0; // 담당자
		int taskTypeMaxCellWidth			= 0; // 작업타입
		int nodeIdMaxCellWidth				= 0; // 수행서버
// 		int cyclicMaxCellWidth				= 0; // 반복
// 		int memNameMaxCellWidth				= 0; // 파일명
// 		int criticalMaxCellWidth			= 0; // 중요작업
		int tableNmMaxlCellWidth			= 0; // 폴더
		int applicationMaxlCellWidth		= 0; // 어플리케이션
		int groupNmMaxlCellWidth			= 0; // 그룹
		int jobSchedGbMenMaxCellWidth		= 0; // 작업종류
		int avgRunMaxCellWidth				= 0; // 평균수행시간
 		int orderIdMaxCellWidth				= 0; // order Id
 		/* int insNm1MaxCellWidth 				= 0;
		int approvalNm1MaxCellWidth 		= 0;
		int approvalNm2MaxCellWidth 		= 0; */
		
		
		int cellWidth = 0;
		setCellValue(r, ++n, "순번", style);
		cellWidth = "순번".getBytes("UTF-8").length * 256;
		numMaxCellWidth = Math.max(numMaxCellWidth, cellWidth);
		
		setCellValue(r, ++n, "ODATE", style);
		cellWidth = "ODATE".getBytes("UTF-8").length * 256;
		odateMaxCellWidth = Math.max(odateMaxCellWidth, cellWidth);
		
		setCellValue(r, ++n, "시작일시", style);
		cellWidth = "시작시간".getBytes("UTF-8").length * 256;
		startTimeMaxCellWidth = Math.max(startTimeMaxCellWidth, cellWidth);
		
		setCellValue(r, ++n, "종료일시", style);
		cellWidth = "종료일시".getBytes("UTF-8").length * 256;
		endTimeMaxCellWidth = Math.max(endTimeMaxCellWidth, cellWidth);
		
		setCellValue(r, ++n, "시작시간", style);
		cellWidth = "시작시간".getBytes("UTF-8").length * 256;
		fromTimeMaxCellWidth = Math.max(fromTimeMaxCellWidth, cellWidth);
		
		setCellValue(r, ++n, "수행시간", style);
		cellWidth = "수행시간".getBytes("UTF-8").length * 256;
		runTimeMaxCellWidth = Math.max(runTimeMaxCellWidth, cellWidth);
		
		setCellValue(r, ++n, "평균수행시간", style);
		cellWidth = "평균수행시간".getBytes("UTF-8").length * 256;
		avgRunMaxCellWidth = Math.max(avgRunMaxCellWidth, cellWidth);
		
		setCellValue(r, ++n, "실행횟수", style);
		cellWidth = "실행횟수".getBytes("UTF-8").length * 256;
		rerunCounterMaxlCellWidth = Math.max(rerunCounterMaxlCellWidth, cellWidth);
		
		setCellValue(r, ++n, "작업명", style);
		cellWidth = "작업명".getBytes("UTF-8").length * 256;
		jobNameMaxCellWidth = Math.max(jobNameMaxCellWidth, cellWidth);
		
		setCellValue(r, ++n, "작업설명", style);
		cellWidth = "작업설명".getBytes("UTF-8").length * 256;
		descriptionMaxCellWidth = Math.max(descriptionMaxCellWidth, cellWidth);
		
// 		setCellValue(r, ++n, "부서", style);
// 		cellWidth = "부서".getBytes("UTF-8").length * 256;
// 		deptNmMaxCellWidth = Math.max(deptNmMaxCellWidth, cellWidth);

		setCellValue(r, ++n, "상태", style);
		cellWidth = "상태".getBytes("UTF-8").length * 256;
		stateResultMaxCellWidth = Math.max(stateResultMaxCellWidth, cellWidth);
		
		
		setCellValue(r, ++n, "수행서버", style);
		cellWidth = "수행서버".getBytes("UTF-8").length * 256;
		nodeIdMaxCellWidth = Math.max(nodeIdMaxCellWidth, cellWidth);
		
		setCellValue(r, ++n, "담당자", style);
		cellWidth = "담당자".getBytes("UTF-8").length * 256;
		userNmMaxCellWidth = Math.max(userNmMaxCellWidth, cellWidth);
		
// 		setCellValue(r, ++n, "반복", style);
// 		cellWidth = "반복".getBytes("UTF-8").length * 256;
// 		criticalMaxCellWidth = Math.max(criticalMaxCellWidth, cellWidth);
		
		
// 		setCellValue(r, ++n, "파일명", style);
// 		cellWidth = "파일명".getBytes("UTF-8").length * 256;
// 		memNameMaxCellWidth = Math.max(memNameMaxCellWidth, cellWidth);
		
// 		setCellValue(r, ++n, "중요작업", style);
// 		cellWidth = "중요작업".getBytes("UTF-8").length * 256;
// 		criticalMaxCellWidth = Math.max(criticalMaxCellWidth, cellWidth);
		
		setCellValue(r, ++n, "폴더", style);
		cellWidth = "폴더".getBytes("UTF-8").length * 256;
		tableNmMaxlCellWidth = Math.max(tableNmMaxlCellWidth, cellWidth);
		
		setCellValue(r, ++n, "어플리케이션", style);
		cellWidth = "어플리케이션".getBytes("UTF-8").length * 256;
		applicationMaxlCellWidth = Math.max(applicationMaxlCellWidth, cellWidth);
		
		setCellValue(r, ++n, "그룹", style);
		cellWidth = "그룹".getBytes("UTF-8").length * 256;
		groupNmMaxlCellWidth = Math.max(groupNmMaxlCellWidth, cellWidth);
		
		setCellValue(r, ++n, "작업타입", style);
		cellWidth = "작업타입".getBytes("UTF-8").length * 256;
		taskTypeMaxCellWidth = Math.max(taskTypeMaxCellWidth, cellWidth);
		
		setCellValue(r, ++n, "작업종류", style);
		cellWidth = "작업종류".getBytes("UTF-8").length * 256;
		jobSchedGbMenMaxCellWidth = Math.max(jobSchedGbMenMaxCellWidth, cellWidth);
		
		/* setCellValue(r, ++n, "의뢰자", style);
		cellWidth = "INS_NM1".getBytes("UTF-8").length * 256;
		insNm1MaxCellWidth = Math.max(insNm1MaxCellWidth, cellWidth);
		
		setCellValue(r, ++n, "1차결재자", style);
		cellWidth = "APPROVAL_NM1".getBytes("UTF-8").length * 256;
		approvalNm1MaxCellWidth = Math.max(approvalNm1MaxCellWidth, cellWidth);
		
		setCellValue(r, ++n, "2차결재자", style);
		cellWidth = "APPROVAL_NM2".getBytes("UTF-8").length * 256;
		approvalNm2MaxCellWidth = Math.max(approvalNm2MaxCellWidth, cellWidth); */
		
 		setCellValue(r, ++n, "ORDER ID", style);
 		cellWidth = "ORDER ID".getBytes("UTF-8").length * 256;
 		orderIdMaxCellWidth = Math.max(orderIdMaxCellWidth, cellWidth);
				
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
		
		for( int i=0; null!=jobLogList && i<jobLogList.size(); i++ ){
			JobLogBean bean = (JobLogBean)jobLogList.get(i);
			
			String strOdate			= CommonUtil.isNull(bean.getOdate());
			String strStartTime		= CommonUtil.isNull(bean.getStart_time());
			String strEndTime		= CommonUtil.isNull(bean.getEnd_time());
			String strRunTime 		= CommonUtil.getDiffTime(CommonUtil.getDateFormat(1,strStartTime), CommonUtil.getDateFormat(1,strEndTime));
			String strRerunCounter 	= CommonUtil.isNull(bean.getRerun_counter());
			String strUserNm		= CommonUtil.isNull(bean.getUser_nm());
			String strDeptNm		= CommonUtil.isNull(bean.getDept_nm());
			String strTaskType		= CommonUtil.isNull(bean.getTask_type());
			String strTableName		= CommonUtil.isNull(bean.getOrder_table());
			String strApplication	= CommonUtil.isNull(bean.getApplication());
			String strGroupName		= CommonUtil.isNull(bean.getGroup_name());
			String strJobSchedGb	= CommonUtil.isNull(bean.getJobschedgb());
			String strJobName		= CommonUtil.isNull(bean.getJob_name());
			String strDescription	= CommonUtil.isNull(bean.getDescription());
			String strNodeId		= CommonUtil.isNull(bean.getNode_id());
			String strStateResult	= CommonUtil.getMessage("JOB_STATUS."+CommonUtil.isNull(bean.getState_result()).replaceAll(" ","_"));
			String strHoldflag		= CommonUtil.isNull(bean.getHoldflag());
			String strUserDayily	= CommonUtil.isNull(bean.getUser_daily());
			String strMemname		= CommonUtil.isNull(bean.getMemname());
			String strFromTime		= CommonUtil.isNull(bean.getFrom_time());
			String strCritical		= CommonUtil.isNull(bean.getCritical_yn());
			String strOrderId		= CommonUtil.isNull(bean.getOrder_id());
			String strAvgRunTime	= CommonUtil.isNull(bean.getAvg_run_time());
			String strSusiCnt		= CommonUtil.isNull(bean.getSusi_cnt());
			String strInsNm1		= CommonUtil.isNull(bean.getIns_nm1());
			String strApprovalNm1	= CommonUtil.isNull(bean.getApproval_nm1());
			String strApprovalNm2	= CommonUtil.isNull(bean.getApproval_nm2());
// 			String strCyclic		= CommonUtil.isNull(bean.getCyclic());
			
			strOdate				= "20" + strOdate;
			strOdate				= strOdate.substring(0, 4) + "/" + strOdate.substring(4, 6) + "/" + strOdate.substring(6, 8);
	
			strStartTime			= CommonUtil.isNull(CommonUtil.getDateFormat(1, strStartTime),"-");
			strEndTime				= CommonUtil.isNull(CommonUtil.getDateFormat(1, strEndTime),"-");
			
			String strStateResult2 	= "";
			if ( strHoldflag.equals("Y") ) {
				strStateResult2 	= "[" + "HOLD" + "] " + CommonUtil.getMessage("JOB_STATUS."+CommonUtil.isNull(bean.getStatus().replaceAll(" ","_")));
			}
			
			//String jobschedgb_ment		= "";
			//String jobschedgb_config	= CommonUtil.getMessage("JOB_SCHED_GB");
			//String[] jobschedgb_arr 	= jobschedgb_config.split(",");
			
			//if ( strJobSchedGb != "" ) {
			//	for ( int ii = 0; ii < jobschedgb_arr.length; ii++ ) {
			//		if ( jobschedgb_arr[ii].split("[|]")[0].equals(strJobSchedGb) ) {
			//			jobschedgb_ment = jobschedgb_arr[ii].split("[|]")[1];
			//		}
			//	}
			//}
			
			//작업종류
			String jobschedgb_ment		= "";
			if ( !strSusiCnt.equals("0") ) {
				jobschedgb_ment = "수시오더";
			} else {
				if (strUserDayily != "") { 
					jobschedgb_ment = "정기";
				} else if (strUserDayily == "") {
					jobschedgb_ment = "비정기";
				}
			}
			
			if(strTaskType.equals("Job")) {
				strTaskType = "Script";
			}
			
			r++;
			n = -1;
			
			setCellValue(r, ++n, Integer.toString(i+1), style);
			cellWidth = Integer.toString(i+1).getBytes("UTF-8").length * 256;
			numMaxCellWidth = Math.max(numMaxCellWidth, cellWidth);
			
			setCellValue(r, ++n, strOdate, style);
			cellWidth = strOdate.getBytes("UTF-8").length * 256;
			odateMaxCellWidth = Math.max(odateMaxCellWidth, cellWidth);
			
			setCellValue(r, ++n, strStartTime, style);
			cellWidth = strStartTime.getBytes("UTF-8").length * 256;
			startTimeMaxCellWidth = Math.max(startTimeMaxCellWidth, cellWidth);
			
			setCellValue(r, ++n, strEndTime, style);
			cellWidth = strEndTime.getBytes("UTF-8").length * 256;
			endTimeMaxCellWidth = Math.max(endTimeMaxCellWidth, cellWidth);
			
			setCellValue(r, ++n, strFromTime, style);
			cellWidth = strFromTime.getBytes("UTF-8").length * 256;
			fromTimeMaxCellWidth = Math.max(fromTimeMaxCellWidth, cellWidth);
			
			setCellValue(r, ++n, strRunTime, style);
			cellWidth = strRunTime.getBytes("UTF-8").length * 256;
			runTimeMaxCellWidth = Math.max(runTimeMaxCellWidth, cellWidth);
			
			setCellValue(r, ++n, strAvgRunTime, style);
			cellWidth = strAvgRunTime.getBytes("UTF-8").length * 256;
			avgRunMaxCellWidth = Math.max(avgRunMaxCellWidth, cellWidth);
			
			setCellValue(r, ++n, strRerunCounter, style);
			cellWidth = strRerunCounter.getBytes("UTF-8").length * 256;
			rerunCounterMaxlCellWidth = Math.max(rerunCounterMaxlCellWidth, cellWidth);
			
			setCellValue(r, ++n, CommonUtil.replaceStrHtml(strJobName), style2);
			cellWidth = strJobName.getBytes("UTF-8").length * 256;
			jobNameMaxCellWidth = Math.max(jobNameMaxCellWidth, cellWidth);
			
			setCellValue(r, ++n, CommonUtil.replaceStrHtml(strDescription), style2);
			cellWidth = strDescription.getBytes("UTF-8").length * 256;
			descriptionMaxCellWidth = Math.max(descriptionMaxCellWidth, cellWidth);
			
// 			setCellValue(r, ++n, strDeptNm, style);
// 			cellWidth = strDeptNm.getBytes("UTF-8").length * 256;
// 			deptNmMaxCellWidth = Math.max(deptNmMaxCellWidth, cellWidth);
			
			setCellValue(r, ++n, strStateResult + strStateResult2, style);
			cellWidth = (strStateResult + strStateResult2).getBytes("UTF-8").length * 256;
			stateResultMaxCellWidth = Math.max(stateResultMaxCellWidth, cellWidth);
			
			setCellValue(r, ++n, strNodeId, style);
			cellWidth = strNodeId.getBytes("UTF-8").length * 256;
			nodeIdMaxCellWidth = Math.max(nodeIdMaxCellWidth, cellWidth);
			
			setCellValue(r, ++n, strUserNm, style);
			cellWidth = strUserNm.getBytes("UTF-8").length * 256;
			userNmMaxCellWidth = Math.max(userNmMaxCellWidth, cellWidth);
			
// 			setCellValue(r, ++n, strCyclic, style);
// 			cellWidth = strCyclic.getBytes("UTF-8").length * 256;
// 			cyclicMaxCellWidth = Math.max(cyclicMaxCellWidth, cellWidth);
			
// 			setCellValue(r, ++n, strFromTime, style);
// 			cellWidth = strFromTime.getBytes("UTF-8").length * 256;
// 			fromTimeMaxCellWidth = Math.max(fromTimeMaxCellWidth, cellWidth);
			
// 			setCellValue(r, ++n, strMemname, style);
// 			cellWidth = strMemname.getBytes("UTF-8").length * 256;
// 			memNameMaxCellWidth = Math.max(memNameMaxCellWidth, cellWidth);
			
// 			setCellValue(r, ++n, strCritical, style);
// 			cellWidth = strCritical.getBytes("UTF-8").length * 256;
// 			criticalMaxCellWidth = Math.max(criticalMaxCellWidth, cellWidth);
			
			setCellValue(r, ++n, strTableName, style);
			cellWidth = strTableName.getBytes("UTF-8").length * 256;
			tableNmMaxlCellWidth = Math.max(tableNmMaxlCellWidth, cellWidth);
			
			setCellValue(r, ++n, strApplication, style);
			cellWidth = strApplication.getBytes("UTF-8").length * 256;
			applicationMaxlCellWidth = Math.max(applicationMaxlCellWidth, cellWidth);
			
			setCellValue(r, ++n, strGroupName, style);
			cellWidth = strGroupName.getBytes("UTF-8").length * 256;
			groupNmMaxlCellWidth = Math.max(groupNmMaxlCellWidth, cellWidth);
			
			setCellValue(r, ++n, strTaskType, style);
			cellWidth = strTableName.getBytes("UTF-8").length * 256;
			taskTypeMaxCellWidth = Math.max(taskTypeMaxCellWidth, cellWidth);
			
			setCellValue(r, ++n, jobschedgb_ment, style);
			cellWidth = jobschedgb_ment.getBytes("UTF-8").length * 256;
			jobSchedGbMenMaxCellWidth = Math.max(jobSchedGbMenMaxCellWidth, cellWidth);
			
			/* setCellValue(r, ++n, strInsNm1, style);
			cellWidth = strInsNm1.getBytes("UTF-8").length * 256;
			insNm1MaxCellWidth = Math.max(insNm1MaxCellWidth, cellWidth);
			
			setCellValue(r, ++n, strApprovalNm1, style);
			cellWidth = strApprovalNm1.getBytes("UTF-8").length * 256;
			approvalNm1MaxCellWidth = Math.max(approvalNm1MaxCellWidth, cellWidth);
			
			setCellValue(r, ++n, strApprovalNm2, style);
			cellWidth = strApprovalNm2.getBytes("UTF-8").length * 256;
			approvalNm2MaxCellWidth = Math.max(approvalNm2MaxCellWidth, cellWidth); */
			
 			setCellValue(r, ++n, strOrderId, style);
 			cellWidth = strOrderId.getBytes("UTF-8").length * 256;
 			orderIdMaxCellWidth = Math.max(orderIdMaxCellWidth, cellWidth);
		}
		
		n = -1;
		
		CommonUtil.setAutoSizeColumn(sheet, ++n, numMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, odateMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, startTimeMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, endTimeMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, fromTimeMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, runTimeMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, avgRunMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, rerunCounterMaxlCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, jobNameMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, descriptionMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, stateResultMaxCellWidth);
// 		CommonUtil.setAutoSizeColumn(sheet, ++n, deptNmMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, nodeIdMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, userNmMaxCellWidth);
// 		CommonUtil.setAutoSizeColumn(sheet, ++n, cyclicMaxCellWidth);
// 		CommonUtil.setAutoSizeColumn(sheet, ++n, memNameMaxCellWidth);
// 		CommonUtil.setAutoSizeColumn(sheet, ++n, criticalMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, tableNmMaxlCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, applicationMaxlCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, groupNmMaxlCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, taskTypeMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, jobSchedGbMenMaxCellWidth);
		/* CommonUtil.setAutoSizeColumn(sheet, ++n, insNm1MaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, approvalNm1MaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, approvalNm2MaxCellWidth); */
 		CommonUtil.setAutoSizeColumn(sheet, ++n, orderIdMaxCellWidth);
		

		
	    ((SXSSFSheet) sheet).flushRows(1000);
		os = response.getOutputStream();
		wb.write(os);
		os.flush();
	
		out.clear();
		out = pageContext.pushBody();
	}catch (Exception e){
		e.printStackTrace();
		System.err.println(e.getMessage());
	}
	
%>

</body>
</html>
