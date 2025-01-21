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
	
	String fileName = "유저이력관리.xlsx"; 
	response.reset() ;
	response.setHeader("Content-Description", "JSP Generated Data");
	response.setHeader("Content-Type", "application/octet-stream; charset=UTF-8");
	response.setHeader("Content-Disposition", "attachment; filename="+java.net.URLEncoder.encode(fileName,"UTF-8").replaceAll("\\+","%20"));
	
// 	List<UserBean> userList				= (List)request.getAttribute("userList");
	List<UserBean> userHistoryList		= (List)request.getAttribute("userHistoryList");
	
	
	String user_gb_cd 			= (String)request.getAttribute("USER_GB_CD");
	String user_gb_nm 			= (String)request.getAttribute("USER_GB_NM");
	String user_appr_gb_cd		= (String)request.getAttribute("USER_APPR_GB_CD");
	String user_appr_gb_nm		= (String)request.getAttribute("USER_APPR_GB_NM");
	
	
	String[] arr_user_gb_cd			= user_gb_cd.split(",");
	String[] arr_user_gb_nm			= user_gb_nm.split(",");
	String[] arr_user_appr_gb_cd	= user_appr_gb_cd.split(",");
	String[] arr_user_appr_gb_nm	= user_appr_gb_nm.split(",");
	
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
		setCellValue(0, ++n, "타입");
		setCellValue(0, ++n, "구분");
		setCellValue(0, ++n, "메일");
		setCellValue(0, ++n, "휴대폰번호");
		setCellValue(0, ++n, "내선번호");
		setCellValue(0, ++n, "부서");
		setCellValue(0, ++n, "직책");
		setCellValue(0, ++n, "IP");
 		setCellValue(0, ++n, "폴더");
 		setCellValue(0, ++n, "어플리케이션");
		setCellValue(0, ++n, "그룹");
		setCellValue(0, ++n, "상태변경권한");
		setCellValue(0, ++n, "사용여부");
		setCellValue(0, ++n, "잠금관리");
		setCellValue(0, ++n, "등록일");
		setCellValue(0, ++n, "등록자");
		setCellValue(0, ++n, "등록자IP");
		setCellValue(0, ++n, "수정일");
		setCellValue(0, ++n, "수정자");
		setCellValue(0, ++n, "수정자IP");
		setCellValue(0, ++n, "사용자이력");
		
	
		style = wb.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setBorderRight(XSSFCellStyle.BORDER_THIN);
		style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
		style.setBorderTop(XSSFCellStyle.BORDER_THIN);
		style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
		
		int r = 0;
		
		for( int i=0; null!=userHistoryList && i<userHistoryList.size(); i++ ){
			
			UserBean bean 			= (UserBean)userHistoryList.get(i);
			
			String user_id					= CommonUtil.isNull(bean.getUser_id());
			String user_nm					= CommonUtil.isNull(bean.getUser_nm());
			String flag						= CommonUtil.isNull(bean.getFlag());
			String user_gb 					= CommonUtil.isNull(bean.getUser_gb());
			String user_email 				= CommonUtil.isNull(bean.getUser_email());
			String user_hp 					= CommonUtil.isNull(bean.getUser_hp());
			String user_tel 				= CommonUtil.isNull(bean.getUser_tel());
			String dept_nm 					= CommonUtil.isNull(bean.getDept_nm());
			String duty_nm 					= CommonUtil.isNull(bean.getDuty_nm());
			String user_ip					= CommonUtil.isNull(bean.getUser_ip());
			String select_table_nm 			= CommonUtil.isNull(bean.getSelect_table_name());
			String application_nm 			= CommonUtil.isNull(bean.getSelect_application());
			String group_nm					= CommonUtil.isNull(bean.getSelect_group_name());
			String user_appr_gb 			= CommonUtil.isNull(bean.getUser_appr_gb());
			String del_yn 					= CommonUtil.isNull(bean.getDel_yn());
			String account_lock 			= CommonUtil.isNull(bean.getAccount_lock());
			
			String ins_date					= CommonUtil.isNull(bean.getIns_date());
			String ins_user_cd				= CommonUtil.isNull(bean.getIns_user_cd());
			String ins_user_ip				= CommonUtil.isNull(bean.getIns_user_ip());
			
			String udt_date					= CommonUtil.isNull(bean.getUdt_date());
			String udt_user_cd				= CommonUtil.isNull(bean.getUdt_user_cd());
			String udt_user_ip				= CommonUtil.isNull(bean.getUdt_user_ip());
			
			String reg_date 				= CommonUtil.isNull(bean.getReg_date());
			
			
			if(del_yn.equals("N")) {
				del_yn = "Y";
			}else if(del_yn.equals("Y")) {
				del_yn = "N";
			}
			
			for(int j = 0; j < arr_user_gb_cd.length; j++) {
				if( arr_user_gb_cd[j].equals(user_gb) ) {
					user_gb = arr_user_gb_nm[j];
				}
			}
			/*
			for(int j = 0; j < arr_user_appr_gb_cd.length; j++) {
				if( user_appr_gb.equals(arr_user_appr_gb_cd[j])) {
					user_appr_gb = arr_user_appr_gb_nm[j];
				}
			}*/
			
			if(flag.equals("ins")) {
				flag = "추가";
			}else if(flag.equals("del")) {
				flag = "삭제";
			}else if(flag.equals("udt")) {
				flag = "수정";
			}else if(flag.equals("user_udt")) {
				flag = "사용자 수정";
			}else if(flag.equals("pw_change")) {
				flag = "패스워드 변경";
			}else if(flag.equals("account_lock")) {
				flag = "계정잠김";
			}
			
			r++;
			n = -1;
			
			setCellValue(r, ++n, i+1);
			
			setCellValue(r, ++n, user_id);
			setCellValue(r, ++n, user_nm);
			setCellValue(r, ++n, flag);
			setCellValue(r, ++n, user_gb);
			setCellValue(r, ++n, user_email);
			setCellValue(r, ++n, user_hp);
			setCellValue(r, ++n, user_tel);
			setCellValue(r, ++n, dept_nm);
			setCellValue(r, ++n, duty_nm);
			setCellValue(r, ++n, user_ip);
			setCellValue(r, ++n, select_table_nm);
			setCellValue(r, ++n, application_nm);
			setCellValue(r, ++n, group_nm);
			setCellValue(r, ++n, user_appr_gb);
			setCellValue(r, ++n, del_yn);
			setCellValue(r, ++n, account_lock);
			setCellValue(r, ++n, ins_date);
			setCellValue(r, ++n, ins_user_cd);
			setCellValue(r, ++n, ins_user_ip);
			setCellValue(r, ++n, udt_date);
			setCellValue(r, ++n, udt_user_cd);
			setCellValue(r, ++n, udt_user_ip);
			setCellValue(r, ++n, reg_date);
			
						
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
