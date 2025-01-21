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
<%@page import="org.apache.poi.ss.usermodel.DataFormat"%>

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
	String menu_gb = CommonUtil.getMessage("CATEGORY.GB.06.GB."+CommonUtil.isNull(paramMap.get("menu_gb")));
	String[] arr_menu_gb = menu_gb.split(",");
	
	OutputStream os = null;
	sheet = null;
	wb = new SXSSFWorkbook();
	
	String fileName = "유저관리.xlsx"; 
	response.reset() ;
	response.setHeader("Content-Description", "JSP Generated Data");
	response.setHeader("Content-Type", "application/octet-stream; charset=UTF-8");
	response.setHeader("Content-Disposition", "attachment; filename="+java.net.URLEncoder.encode(fileName,"UTF-8").replaceAll("\\+","%20"));
	
	List<UserBean> userList		= (List)request.getAttribute("userList");
	String user_gb_cd 			= (String)request.getAttribute("USER_GB_CD");
	String user_gb_nm 			= (String)request.getAttribute("USER_GB_NM");
	String user_appr_gb_cd		= (String)request.getAttribute("USER_APPR_GB_CD");
	String user_appr_gb_nm		= (String)request.getAttribute("USER_APPR_GB_NM");
	
	
	String[] arr_user_gb_cd			= user_gb_cd.split(",");
	String[] arr_user_gb_nm			= user_gb_nm.split(",");
	String[] arr_user_appr_gb_cd	= user_appr_gb_cd.split(",");
	String[] arr_user_appr_gb_nm	= user_appr_gb_nm.split(",");
	
	
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
		
		int MaxCellWidth1 = 0;
		int MaxCellWidth2 = 0;
		int MaxCellWidth3 = 0;
		int MaxCellWidth4 = 0;
		int MaxCellWidth5 = 0;
		int MaxCellWidth6 = 0;
		int MaxCellWidth7 = 0;
		int MaxCellWidth8 = 0;
		int MaxCellWidth9 = 0;
		int MaxCellWidth10 = 0;
		int MaxCellWidth11 = 0;
		int MaxCellWidth12 = 0;
		int MaxCellWidth13 = 0;
		int MaxCellWidth14 = 0;
		int MaxCellWidth15 = 0;
		int MaxCellWidth16 = 0;
		int MaxCellWidth17 = 0;
		
		int cellWidth = 0;
		
		setCellValue(r, ++n, "순번", style);
		cellWidth = "순번".getBytes("UTF-8").length * 256;
		MaxCellWidth1 = Math.max(MaxCellWidth1, cellWidth);
		
		setCellValue(r, ++n, "아이디", style);
		cellWidth = "아이디".getBytes("UTF-8").length * 256;
		MaxCellWidth2 = Math.max(MaxCellWidth2, cellWidth);
		
		setCellValue(r, ++n, "이름", style);
		cellWidth = "이름".getBytes("UTF-8").length * 256;
		MaxCellWidth3 = Math.max(MaxCellWidth3, cellWidth);
		
		setCellValue(r, ++n, "구분", style);
		cellWidth = "구분".getBytes("UTF-8").length * 256;
		MaxCellWidth4 = Math.max(MaxCellWidth4, cellWidth);
		
		setCellValue(r, ++n, "메일", style);
		cellWidth = "메일".getBytes("UTF-8").length * 256;
		MaxCellWidth5 = Math.max(MaxCellWidth5, cellWidth);
		
		setCellValue(r, ++n, "휴대폰번호", style);
		cellWidth = "휴대폰번호".getBytes("UTF-8").length * 256;
		MaxCellWidth6 = Math.max(MaxCellWidth6, cellWidth);
		
		setCellValue(r, ++n, "내선번호", style);
		cellWidth = "내선번호".getBytes("UTF-8").length * 256;
		MaxCellWidth7 = Math.max(MaxCellWidth7, cellWidth);
		
		setCellValue(r, ++n, "부서", style);
		cellWidth = "부서".getBytes("UTF-8").length * 256;
		MaxCellWidth8 = Math.max(MaxCellWidth8, cellWidth);
		
		setCellValue(r, ++n, "직책", style);
		cellWidth = "직책".getBytes("UTF-8").length * 256;
		MaxCellWidth9 = Math.max(MaxCellWidth9, cellWidth);
		
		setCellValue(r, ++n, "기본 C-M", style);
		cellWidth = "기본 C-M".getBytes("UTF-8").length * 256;
		MaxCellWidth10 = Math.max(MaxCellWidth10, cellWidth);
		
		setCellValue(r, ++n, "폴더", style);
		cellWidth = "폴더".getBytes("UTF-8").length * 256;
		MaxCellWidth11 = Math.max(MaxCellWidth11, cellWidth);
		
		setCellValue(r, ++n, "결재구분", style);
		cellWidth = "결재구분".getBytes("UTF-8").length * 256;
		MaxCellWidth12 = Math.max(MaxCellWidth12, cellWidth);
		
		setCellValue(r, ++n, "사용여부", style);
		cellWidth = "사용여부".getBytes("UTF-8").length * 256;
		MaxCellWidth13 = Math.max(MaxCellWidth13, cellWidth);
		
		setCellValue(r, ++n, "잠금관리", style);
		cellWidth = "잠금관리".getBytes("UTF-8").length * 256;
		MaxCellWidth14 = Math.max(MaxCellWidth14, cellWidth);
		
		setCellValue(r, ++n, "아이피", style);
		cellWidth = "아이피".getBytes("UTF-8").length * 256;
		MaxCellWidth15 = Math.max(MaxCellWidth15, cellWidth);
		
		setCellValue(r, ++n, "최종 접속일", style);
		cellWidth = "최종 접속일".getBytes("UTF-8").length * 256;
		MaxCellWidth16 = Math.max(MaxCellWidth16, cellWidth);
		
		setCellValue(r, ++n, "등록일", style);
		cellWidth = "등록일".getBytes("UTF-8").length * 256;
		MaxCellWidth17 = Math.max(MaxCellWidth17, cellWidth);
		
	
		format = wb.createDataFormat();
		style = wb.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setBorderRight(XSSFCellStyle.BORDER_THIN);
		style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
		style.setBorderTop(XSSFCellStyle.BORDER_THIN);
		style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
		style.setDataFormat(format.getFormat("@")); // "@"은 텍스트 형식
		
// 		int r = 0;
		
		for( int i=0; null!=userList && i<userList.size(); i++ ){
			
			UserBean bean 			= (UserBean)userList.get(i);
			
			String user_id				= CommonUtil.isNull(bean.getUser_id());
			String user_nm				= CommonUtil.isNull(bean.getUser_nm());
			String user_gb 				= CommonUtil.isNull(bean.getUser_gb());
			String user_email 			= CommonUtil.isNull(bean.getUser_email());
			String user_hp 				= CommonUtil.isNull(bean.getUser_hp());
			String user_tel 			= CommonUtil.isNull(bean.getUser_tel());
			String dept_nm 				= CommonUtil.isNull(bean.getDept_nm());
			String duty_nm 				= CommonUtil.E2K(bean.getDuty_nm());
			String select_table_nm 		= CommonUtil.isNull(bean.getSelect_table_name());
			String user_appr_gb 		= CommonUtil.isNull(bean.getUser_appr_gb());
			String del_yn 				= CommonUtil.isNull(bean.getDel_yn());
			String account_lock 		= CommonUtil.isNull(bean.getAccount_lock());
			String user_ip				= CommonUtil.isNull(bean.getUser_ip());
			String ins_date				= CommonUtil.isNull(bean.getIns_date());
			String max_login_date		= CommonUtil.isNull(bean.getMax_login_date());
			String select_ddc			= CommonUtil.isNull(bean.getSelect_data_center_code());
			
			if(del_yn.equals("N")) {
				del_yn = CommonUtil.getMessage("USER_STATUS.Y");
// 				del_yn = "Y";
			}else if(del_yn.equals("Y")) {
				del_yn = CommonUtil.getMessage("USER_STATUS.N");
// 				del_yn = "N";
			}
			
			if(account_lock.equals("")){
				account_lock = "N";
			}
			
			if(account_lock.equals("Y")){
				account_lock = CommonUtil.getMessage("ACCOUNT_STATUS.Y");
			}else if(account_lock.equals("N")){
				account_lock = CommonUtil.getMessage("ACCOUNT_STATUS.N");
			}else if(account_lock.equals("M")){
				account_lock = CommonUtil.getMessage("ACCOUNT_STATUS.M");
			}else if(account_lock.equals("U")){
				account_lock = CommonUtil.getMessage("ACCOUNT_STATUS.U");
			}
			
			for(int j = 0; j < arr_user_gb_cd.length; j++) {
				if( arr_user_gb_cd[j].equals(user_gb) ) {
					user_gb = arr_user_gb_nm[j];
				}
			}
			
			for(int j = 0; j < arr_user_appr_gb_cd.length; j++) {
				if( user_appr_gb.equals(arr_user_appr_gb_cd[j])) {
					user_appr_gb = arr_user_appr_gb_nm[j];
				}
			}
			
			r++;
			n = -1;
			
			setCellValue(r, ++n, Integer.toString(i+1), style);
			cellWidth = Integer.toString(i+1).getBytes("UTF-8").length * 256;
			MaxCellWidth1 = Math.max(MaxCellWidth1, cellWidth);
			
			setCellValue(r, ++n, user_id, style);
			cellWidth = user_id.getBytes("UTF-8").length * 256;
			MaxCellWidth2 = Math.max(MaxCellWidth2, cellWidth);
			
			setCellValue(r, ++n, user_nm, style);
			cellWidth = user_nm.getBytes("UTF-8").length * 256;
			MaxCellWidth3 = Math.max(MaxCellWidth3, cellWidth);
			
			setCellValue(r, ++n, user_gb, style);
			cellWidth = user_gb.getBytes("UTF-8").length * 256;
			MaxCellWidth4 = Math.max(MaxCellWidth4, cellWidth);
			
			setCellValue(r, ++n, user_email, style);
			cellWidth = user_email.getBytes("UTF-8").length * 256;
			MaxCellWidth5 = Math.max(MaxCellWidth5, cellWidth);
			
			setCellValue(r, ++n, user_hp, style);
			cellWidth = user_hp.getBytes("UTF-8").length * 256;
			MaxCellWidth6 = Math.max(MaxCellWidth6, cellWidth);
			
			setCellValue(r, ++n, user_tel, style);
			cellWidth = user_tel.getBytes("UTF-8").length * 256;
			MaxCellWidth7 = Math.max(MaxCellWidth7, cellWidth);
			
			setCellValue(r, ++n, dept_nm, style);
			cellWidth = dept_nm.getBytes("UTF-8").length * 256;
			MaxCellWidth8 = Math.max(MaxCellWidth8, cellWidth);
			
			setCellValue(r, ++n, duty_nm, style);
			cellWidth = duty_nm.getBytes("UTF-8").length * 256;
			MaxCellWidth9 = Math.max(MaxCellWidth9, cellWidth);
			
			setCellValue(r, ++n, select_ddc, style);
			cellWidth = select_ddc.getBytes("UTF-8").length * 256;
			MaxCellWidth10 = Math.max(MaxCellWidth10, cellWidth);
			
			setCellValue(r, ++n, select_table_nm, style);
			cellWidth = select_table_nm.getBytes("UTF-8").length * 256;
			MaxCellWidth11 = Math.max(MaxCellWidth11, cellWidth);
			
			setCellValue(r, ++n, user_appr_gb, style);
			cellWidth = user_appr_gb.getBytes("UTF-8").length * 256;
			MaxCellWidth12 = Math.max(MaxCellWidth12, cellWidth);
			
			setCellValue(r, ++n, del_yn, style);
			cellWidth = del_yn.getBytes("UTF-8").length * 256;
			MaxCellWidth13 = Math.max(MaxCellWidth13, cellWidth);
			
			setCellValue(r, ++n, account_lock, style);
			cellWidth = account_lock.getBytes("UTF-8").length * 256;
			MaxCellWidth14 = Math.max(MaxCellWidth14, cellWidth);
			
			setCellValue(r, ++n, user_ip, style);
			cellWidth = user_ip.getBytes("UTF-8").length * 256;
			MaxCellWidth15 = Math.max(MaxCellWidth15, cellWidth);
			
			setCellValue(r, ++n, max_login_date, style);
			cellWidth = max_login_date.getBytes("UTF-8").length * 256;
			MaxCellWidth16 = Math.max(MaxCellWidth16, cellWidth);
			
			setCellValue(r, ++n, ins_date, style);
			cellWidth = ins_date.getBytes("UTF-8").length * 256;
			MaxCellWidth17 = Math.max(MaxCellWidth17, cellWidth);
						
			((SXSSFSheet) sheet).flushRows(10000);
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
		CommonUtil.setAutoSizeColumn(sheet, ++n, MaxCellWidth16);
		CommonUtil.setAutoSizeColumn(sheet, ++n, MaxCellWidth17);
// 		CommonUtil.setAutoSizeColumn(sheet, ++n, MaxCellWidth18);
		
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
