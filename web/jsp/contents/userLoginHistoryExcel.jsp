<%@page import="org.apache.poi.util.SystemOutLogger"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- <%@page import="com.ghayoun.ezjobs.m.domain.*"%> --%>
<%@page import="com.ghayoun.ezjobs.m.service.*"%>
<%@ page import="com.ghayoun.ezjobs.t.domain.*" %>

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

	public void setCellValue(int row, int cell, Object cellvalue) {
		Cell c = getCell(row, cell);
		c.setCellStyle(style);
		if(cellvalue instanceof Integer) {
			cellvalue = cellvalue.toString();
		}
		c.setCellValue((String)cellvalue);
	}
%>


<%
	response.setHeader("Cache-Control","no-store"); //HTTP 1.1
  	response.setHeader("Pragma","no-cache"); //HTTP 1.0
  	response.setDateHeader ("Expires", 0);
%>


<%
	Map<String, Object> paramMap = CommonUtil.collectParameters(request);
	String menu_gb = CommonUtil.getMessage("CATEGORY.GB.06.GB."+CommonUtil.isNull(paramMap.get("menu_gb")));
	String[] arr_menu_gb = menu_gb.split(",");
	
	OutputStream os = null;
	sheet = null;
	wb = new SXSSFWorkbook();
	
	String fileName = "유저_로그인이력.xlsx"; 
	response.reset() ;
	response.setHeader("Content-Description", "JSP Generated Data");
	response.setHeader("Content-Type", "application/octet-stream; charset=UTF-8");
	response.setHeader("Content-Disposition", "attachment; filename="+java.net.URLEncoder.encode(fileName,"UTF-8").replaceAll("\\+","%20"));
	
// 	List<UserBean> userList				= (List)request.getAttribute("userList");
	List<UserBean> userLoginHistoryList		= (List)request.getAttribute("userLoginHistoryList");
	
	
	String user_gb_cd 			= (String)request.getAttribute("USER_GB_CD");
	String user_gb_nm 			= (String)request.getAttribute("USER_GB_NM");
	
	
	PopupDefJobDetailService popupDefJobDetailService 	= (PopupDefJobDetailService)ContextLoader.getCurrentWebApplicationContext().getBean("mPopupDefJobDetailService");
	
%>

<%
	try {
		sheet = wb.createSheet("Sheet1");
		
		style	= wb.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setFillForegroundColor(HSSFColor.GREY_25_PERCENT.index);
		style.setFillPattern(XSSFCellStyle.SOLID_FOREGROUND);
		style.setBorderRight(XSSFCellStyle.BORDER_THIN);
		style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
		style.setBorderTop(XSSFCellStyle.BORDER_THIN);
		style.setBorderBottom(XSSFCellStyle.BORDER_THIN);	
		
		int n = -1;
		
		setCellValue(0, ++n, "순번");
		setCellValue(0, ++n, "아이디");
		setCellValue(0, ++n, "이름");
		setCellValue(0, ++n, "접속일자");
		setCellValue(0, ++n, "유저 아이피");
		
	
		style = wb.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setBorderRight(XSSFCellStyle.BORDER_THIN);
		style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
		style.setBorderTop(XSSFCellStyle.BORDER_THIN);
		style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
		
		int r = 0;
		
		for( int i=0; null!=userLoginHistoryList && i<userLoginHistoryList.size(); i++ ){
			
			UserBean bean 			= (UserBean)userLoginHistoryList.get(i);
			
			String user_id					= CommonUtil.isNull(bean.getUser_id());
			String user_nm	 				= CommonUtil.isNull(bean.getUser_nm());
			String ins_date					= CommonUtil.isNull(bean.getIns_date());
			String ins_user_ip 				= CommonUtil.isNull(bean.getIns_user_ip());
			
			r++;
			n = -1;
			
			setCellValue(r, ++n, i+1);
			
			setCellValue(r, ++n, user_id);
			setCellValue(r, ++n, user_nm);
			setCellValue(r, ++n, ins_date);
			setCellValue(r, ++n, ins_user_ip);
			
						
			((SXSSFSheet) sheet).flushRows(10000);
		}
			
		sheet.setColumnWidth(0, (int) 0x200);

	for (int i = 0; i <= 100; i++) {
		sheet.autoSizeColumn(i);
		
		if ( sheet.getColumnWidth(i) > 60000 ) {
			sheet.setColumnWidth(i, 60000);
		} else {
			sheet.setColumnWidth(i, sheet.getColumnWidth(i) + 700);
		}
	}
	
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
