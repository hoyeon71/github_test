<%@page import="java.awt.Color"%>
<%@page import="org.apache.poi.xssf.usermodel.XSSFColor"%>
<%@page import="org.apache.poi.ss.usermodel.Font"%>
<%@page import="org.apache.poi.util.SystemOutLogger"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.ghayoun.ezjobs.m.domain.*"%>
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
	String menu_gb = CommonUtil.getMessage("CATEGORY.GB.03.GB."+CommonUtil.isNull(paramMap.get("menu_gb")));
	String[] arr_menu_gb = menu_gb.split(",");
	
	OutputStream os = null;
	sheet = null;
	wb = new SXSSFWorkbook();
	
	String fileName = "작업등록정보.xlsx"; 
	response.reset() ;
	response.setHeader("Content-Description", "JSP Generated Data");
	response.setHeader("Content-Type", "application/octet-stream; charset=UTF-8");
	response.setHeader("Content-Disposition", "attachment; filename="+java.net.URLEncoder.encode(fileName,"UTF-8").replaceAll("\\+","%20"));
	
	List<DefJobBean> defJobList			= (List)request.getAttribute("defJobList");
	
	
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
		style.setWrapText(true);
		
		int n = -1;
		int r = 0;
		int numMaxCellWidth					= 0; // 순번
		int schedTableMaxCellWidth			= 0;
		int applicationMaxCellWidth			= 0;
		int groupNameMaxCellWidth			= 0;
		int jobSchedGbMentMaxCellWidth		= 0;
		int jobNameMaxCellWidth				= 0;
		int userNmMaxCellWidth				= 0;
		int nodeGrpMaxCellWidth				= 0;
		int cyclicMaxCellWidth				= 0;
		int fromTimeMaxCellWidth			= 0;
		int descriptionMaxCellWidth			= 0;
		int ccCountMaxCellWidth				= 0;
		int cmjobTransferMaxCellWidth		= 0;
		int inConditionMaxCellWidth			= 0;
		int outConditionMaxCellWidth		= 0;
		int commandMaxCellWidth				= 0;
		int taskTypeMaxCellWidth			= 0;

		int insDateMaxCellWidth				= 0;

		int cellWidth = 0;

		setCellValue(r, ++n, "순번", style);
		cellWidth = "순번".getBytes("UTF-8").length * 256;
		numMaxCellWidth = Math.max(numMaxCellWidth, cellWidth);

		setCellValue(r, ++n, "폴더", style);
		cellWidth = "폴더".getBytes("UTF-8").length * 256;
		schedTableMaxCellWidth = Math.max(schedTableMaxCellWidth, cellWidth);

		setCellValue(r, ++n, "어플리케이션", style);
		cellWidth = "어플리케이션".getBytes("UTF-8").length * 256;
		applicationMaxCellWidth = Math.max(applicationMaxCellWidth, cellWidth);

		setCellValue(r, ++n, "그룹", style);
		cellWidth = "그룹".getBytes("UTF-8").length * 256;
		groupNameMaxCellWidth = Math.max(groupNameMaxCellWidth, cellWidth);

		setCellValue(r, ++n, "작업종류", style);
		cellWidth = "작업종류".getBytes("UTF-8").length * 256;
		jobSchedGbMentMaxCellWidth = Math.max(jobSchedGbMentMaxCellWidth, cellWidth);

		setCellValue(r, ++n, "작업명", style);
		cellWidth = "작업명".getBytes("UTF-8").length * 256;
		jobNameMaxCellWidth = Math.max(jobNameMaxCellWidth, cellWidth);
		
		setCellValue(r, ++n, "작업설명", style);
 		cellWidth = "작업설명".getBytes("UTF-8").length * 256;
 		descriptionMaxCellWidth = Math.max(descriptionMaxCellWidth, cellWidth);
 		
 		setCellValue(r, ++n, "작업타입", style);
		cellWidth = "작업타입".getBytes("UTF-8").length * 256;
		taskTypeMaxCellWidth = Math.max(taskTypeMaxCellWidth, cellWidth);

		setCellValue(r, ++n, "당담자", style);
		cellWidth = "당담자".getBytes("UTF-8").length * 256;
		userNmMaxCellWidth = Math.max(userNmMaxCellWidth, cellWidth);

		//setCellValue(0, ++n, "책임자");
		setCellValue(r, ++n, "수행서버", style);
		cellWidth = "수행서버".getBytes("UTF-8").length * 256;
		nodeGrpMaxCellWidth = Math.max(nodeGrpMaxCellWidth, cellWidth);

		setCellValue(r, ++n, "반복", style);
		cellWidth = "순번반복".getBytes("UTF-8").length * 256;
		cyclicMaxCellWidth = Math.max(cyclicMaxCellWidth, cellWidth);

		setCellValue(r, ++n, "시작시간", style);
		cellWidth = "시작시간".getBytes("UTF-8").length * 256;
		fromTimeMaxCellWidth = Math.max(fromTimeMaxCellWidth, cellWidth);


 		setCellValue(r, ++n, "미사용일수", style);
 		cellWidth = "미사용일수".getBytes("UTF-8").length * 256;
 		ccCountMaxCellWidth = Math.max(ccCountMaxCellWidth, cellWidth);
 		
 		setCellValue(r, ++n, "이관여부", style);
 		cellWidth = "이관여부".getBytes("UTF-8").length * 256;
 		cmjobTransferMaxCellWidth = Math.max(cmjobTransferMaxCellWidth, cellWidth);

// 		setCellValue(r, ++n, "선행작업조건", style);
// 		cellWidth = "선행작업조건".getBytes("UTF-8").length * 256;
// 		inConditionMaxCellWidth = Math.max(inConditionMaxCellWidth, cellWidth);

// 		setCellValue(r, ++n, "후행작업조건", style);
// 		cellWidth = "후행작업조건".getBytes("UTF-8").length * 256;
// 		outConditionMaxCellWidth = Math.max(outConditionMaxCellWidth, cellWidth);

// 		setCellValue(r, ++n, "실행명령어", style);
// 		cellWidth = "실행명령어".getBytes("UTF-8").length * 256;
// 		commandMaxCellWidth = Math.max(commandMaxCellWidth, cellWidth);

		setCellValue(r, ++n, "등록일", style);
		cellWidth = "등록일".getBytes("UTF-8").length * 256;
		insDateMaxCellWidth = Math.max(insDateMaxCellWidth, cellWidth);

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

		for( int i=0; null!=defJobList && i<defJobList.size(); i++ ){
			DefJobBean bean 			= (DefJobBean)defJobList.get(i);
			String strSchedTable		= CommonUtil.isNull(bean.getSched_table());
			String strApplication		= CommonUtil.isNull(bean.getApplication());
			String strGroupName			= CommonUtil.isNull(bean.getGroup_name());
			String strJobSchedGb		= CommonUtil.isNull(bean.getJobSchedGb());
			String strJobName 			= CommonUtil.isNull(bean.getJob_name());
			String strUserNm			= CommonUtil.isNull(bean.getUser_nm());
			//String strManagerNm			= CommonUtil.isNull(bean.getUser_nm2());
			String strNodeGrp			= CommonUtil.isNull(bean.getNode_grp());
			String strCyclic			= CommonUtil.isNull(bean.getCyclic());
			String strFromTime			= CommonUtil.isNull(bean.getFrom_time());
			String strDescription		= CommonUtil.replaceStrHtml(CommonUtil.isNull(bean.getDescription()));
			String strInsDate			= CommonUtil.isNull(bean.getIns_date());
			String strUserDayily		= CommonUtil.isNull(bean.getUser_daily());
			String strCcCount			= CommonUtil.isNull(bean.getCc_count());
			String strCmjobTransfer		= CommonUtil.isNull(bean.getCmjob_transfer());
			//부산은행 추가요청 컬럼(선후행작업명,실행명령어)
			String strInCondition		= CommonUtil.E2K(CommonUtil.isNull(bean.getIn_condition()));
			String strOutCondition		= CommonUtil.E2K(CommonUtil.isNull(bean.getOut_condition()));
			String strCommand			= CommonUtil.E2K(CommonUtil.isNull(bean.getCmd_line()));
			String strTaskType			= CommonUtil.E2K(CommonUtil.isNull(bean.getTask_type()));

			//작업종류(2022.11.03 전북은행)
			String jobschedgb_ment		= "";

			if (strUserDayily != "") {
				jobschedgb_ment = "정기";
			} else if (strUserDayily == "") {
				jobschedgb_ment = "비정기";
			}
			
			if(strCmjobTransfer.equals("Y")){
				strCmjobTransfer = "이관완료";
			}else if(strCmjobTransfer.equals("N")){
				strCmjobTransfer = "이관필요";
			}

			if(strTaskType.equals("Job")) {
				strTaskType = "Script";
			}

			r++;
			n = -1;

			setCellValue(r, ++n, Integer.toString(i+1), style);
			cellWidth = Integer.toString(i+1).getBytes("UTF-8").length * 256;
			numMaxCellWidth = Math.max(numMaxCellWidth, cellWidth);

			setCellValue(r, ++n, strSchedTable, style);
			cellWidth = strSchedTable.getBytes("UTF-8").length * 256;
			schedTableMaxCellWidth = Math.max(schedTableMaxCellWidth, cellWidth);

			setCellValue(r, ++n, strApplication, style);
			cellWidth = strApplication.getBytes("UTF-8").length * 256;
			applicationMaxCellWidth = Math.max(applicationMaxCellWidth, cellWidth);

			setCellValue(r, ++n, strGroupName, style);
			cellWidth = strGroupName.getBytes("UTF-8").length * 256;
			groupNameMaxCellWidth = Math.max(groupNameMaxCellWidth, cellWidth);

			setCellValue(r, ++n, jobschedgb_ment, style);
			cellWidth = jobschedgb_ment.getBytes("UTF-8").length * 256;
			jobSchedGbMentMaxCellWidth = Math.max(jobSchedGbMentMaxCellWidth, cellWidth);

			setCellValue(r, ++n, CommonUtil.replaceStrHtml(strJobName), style2);
			cellWidth = strJobName.getBytes("UTF-8").length * 256;
			jobNameMaxCellWidth = Math.max(jobNameMaxCellWidth, cellWidth);
			
			setCellValue(r, ++n, CommonUtil.replaceStrHtml(strDescription), style2);
			cellWidth = strDescription.getBytes("UTF-8").length * 256;
			descriptionMaxCellWidth = Math.max(descriptionMaxCellWidth, cellWidth);

			setCellValue(r, ++n, strTaskType, style);
			cellWidth = strTaskType.getBytes("UTF-8").length * 256;
			taskTypeMaxCellWidth = Math.max(taskTypeMaxCellWidth, cellWidth);

			setCellValue(r, ++n, strUserNm, style);
			cellWidth = strUserNm.getBytes("UTF-8").length * 256;
			userNmMaxCellWidth = Math.max(userNmMaxCellWidth, cellWidth);

			//setCellValue(r, ++n, strManagerNm);
			setCellValue(r, ++n, strNodeGrp, style);
			cellWidth = strNodeGrp.getBytes("UTF-8").length * 256;
			nodeGrpMaxCellWidth = Math.max(nodeGrpMaxCellWidth, cellWidth);

			setCellValue(r, ++n, strCyclic, style);
			cellWidth = strCyclic.getBytes("UTF-8").length * 256;
			cyclicMaxCellWidth = Math.max(cyclicMaxCellWidth, cellWidth);

			setCellValue(r, ++n, strFromTime, style);
			cellWidth = strFromTime.getBytes("UTF-8").length * 256;
			fromTimeMaxCellWidth = Math.max(fromTimeMaxCellWidth, cellWidth);

			setCellValue(r, ++n, strCcCount, style);
			cellWidth = strCcCount.getBytes("UTF-8").length * 256;
			ccCountMaxCellWidth = Math.max(ccCountMaxCellWidth, cellWidth);
			
			setCellValue(r, ++n, strCmjobTransfer, style);
			cellWidth = strCmjobTransfer.getBytes("UTF-8").length * 256;
			cmjobTransferMaxCellWidth = Math.max(cmjobTransferMaxCellWidth, cellWidth);

// 			setCellValue(r, ++n, strInCondition, style);
// 			cellWidth = strInCondition.getBytes("UTF-8").length * 256;
// 			inConditionMaxCellWidth = Math.max(inConditionMaxCellWidth, cellWidth);
			//inConditionMaxCellWidth =  Math.min(255*250, inConditionMaxCellWidth);

// 			setCellValue(r, ++n, strOutCondition, style);
// 			cellWidth = strOutCondition.getBytes("UTF-8").length * 256;
// 			outConditionMaxCellWidth = Math.max(outConditionMaxCellWidth, cellWidth);
			//outConditionMaxCellWidth =  Math.min(255*250, outConditionMaxCellWidth);

// 			setCellValue(r, ++n, strCommand, style);
// 			cellWidth = strCommand.getBytes("UTF-8").length * 256;
// 			commandMaxCellWidth = Math.max(commandMaxCellWidth , cellWidth);

			setCellValue(r, ++n, strInsDate, style);
			cellWidth = strInsDate.getBytes("UTF-8").length * 256;
			insDateMaxCellWidth = Math.max(insDateMaxCellWidth, cellWidth);
 
		}
		
	
		n = -1;
		
		CommonUtil.setAutoSizeColumn(sheet, ++n, numMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, schedTableMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, applicationMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, groupNameMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, jobSchedGbMentMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, jobNameMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, descriptionMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, taskTypeMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, userNmMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, nodeGrpMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, cyclicMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, fromTimeMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, ccCountMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, cmjobTransferMaxCellWidth);
// 		CommonUtil.setAutoSizeColumn(sheet, ++n, inConditionMaxCellWidth);
// 		CommonUtil.setAutoSizeColumn(sheet, ++n, outConditionMaxCellWidth);
// 		CommonUtil.setAutoSizeColumn(sheet, ++n, commandMaxCellWidth);
		CommonUtil.setAutoSizeColumn(sheet, ++n, insDateMaxCellWidth);
		
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
