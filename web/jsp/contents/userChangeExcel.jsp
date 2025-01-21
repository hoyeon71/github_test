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
	String menu_gb = CommonUtil.getMessage("CATEGORY.GB.02.GB."+CommonUtil.isNull(paramMap.get("menu_gb")));
	String[] arr_menu_gb = menu_gb.split(",");
	
	OutputStream os = null;
	sheet = null;
	wb = new SXSSFWorkbook();
	
	List smsDefaultList			= (List)request.getAttribute("smsDefaultList");
	List mailDefaultList		= (List)request.getAttribute("mailDefaultList");
	
	// SMS, MAIL 기본값 및 체크 유무 추가(2024.02.22)
	String strSms					= "";
	String strMail					= "";
	String smsDefault				= "";
	String mailDefault				= "";
	
	if(smsDefaultList != null) {
		for ( int i = 0; i < smsDefaultList.size(); i++ ) {
			CommonBean commonBean = (CommonBean) smsDefaultList.get(i);
			
			strSms		= commonBean.getScode_eng_nm();
			smsDefault  = commonBean.getScode_nm();
		}
	}
	
	if(mailDefaultList != null) {
		for ( int i = 0; i < mailDefaultList.size(); i++ ) {
			CommonBean commonBean = (CommonBean) mailDefaultList.get(i);
				
			strMail		= commonBean.getScode_eng_nm();
			mailDefault = commonBean.getScode_nm();
		}
	}
	

	String fileName = "담당자엑셀일괄양식.xlsx"; 
	response.reset() ;
	response.setHeader("Content-Description", "JSP Generated Data");
	response.setHeader("Content-Type", "application/octet-stream; charset=UTF-8");
	response.setHeader("Content-Disposition", "attachment; filename="+java.net.URLEncoder.encode(fileName,"UTF-8").replaceAll("\\+","%20"));
	
	List<DefJobBean> defJobList							= (List)request.getAttribute("defJobList");
	String data_center 									= (String)request.getAttribute("data_center");
	
	PopupDefJobDetailService popupDefJobDetailService 	= (PopupDefJobDetailService)ContextLoader.getCurrentWebApplicationContext().getBean("mPopupDefJobDetailService");
	
%>

<%
	try {
		sheet = wb.createSheet("정기작업_일괄양식");
		
		style	= wb.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setFillForegroundColor(HSSFColor.GREY_25_PERCENT.index);
		style.setFillPattern(XSSFCellStyle.SOLID_FOREGROUND);
		style.setBorderRight(XSSFCellStyle.BORDER_THIN);
		style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
		style.setBorderTop(XSSFCellStyle.BORDER_THIN);
		style.setBorderBottom(XSSFCellStyle.BORDER_THIN);	
		
		int n = -1;
		
		setCellValue(0, ++n, "*작업명");
		
		setCellValue(0, ++n, "*담당자");
		
		setCellValue(0, ++n, "담당자_"+strSms);
		
		setCellValue(0, ++n, "담당자_"+strMail);
		
		setCellValue(0, ++n, "담당자2");

		setCellValue(0, ++n, "담당자2_"+strSms);

		setCellValue(0, ++n, "담당자2_"+strMail);
		
		setCellValue(0, ++n, "담당자3");

		setCellValue(0, ++n, "담당자3_"+strSms);

		setCellValue(0, ++n, "담당자3_"+strMail);
		
		setCellValue(0, ++n, "담당자4");

		setCellValue(0, ++n, "담당자4_"+strSms);

		setCellValue(0, ++n, "담당자4_"+strMail);
		
		setCellValue(0, ++n, "담당자5");
		
		setCellValue(0, ++n, "담당자5_"+strSms);
		
		setCellValue(0, ++n, "담당자5_"+strMail);
		
		setCellValue(0, ++n, "담당자6");

		setCellValue(0, ++n, "담당자6_"+strSms);

		setCellValue(0, ++n, "담당자6_"+strMail);
		
		setCellValue(0, ++n, "담당자7");

		setCellValue(0, ++n, "담당자7_"+strSms);

		setCellValue(0, ++n, "담당자7_"+strMail);
		
		setCellValue(0, ++n, "담당자8");

		setCellValue(0, ++n, "담당자8_"+strSms);

		setCellValue(0, ++n, "담당자8_"+strMail);
		
		setCellValue(0, ++n, "담당자9");

		setCellValue(0, ++n, "담당자9_"+strSms);

		setCellValue(0, ++n, "담당자9_"+strMail);
		
		setCellValue(0, ++n, "담당자10");

		setCellValue(0, ++n, "담당자10_"+strSms);

		setCellValue(0, ++n, "담당자10_"+strMail);
		
		setCellValue(0, ++n, "그룹1");

		setCellValue(0, ++n, "그룹1_"+strSms);

		setCellValue(0, ++n, "그룹1_"+strMail);
		
		setCellValue(0, ++n, "그룹2");

		setCellValue(0, ++n, "그룹2_"+strSms);

		setCellValue(0, ++n, "그룹2_"+strMail);
		
		
	
		style = wb.createCellStyle();
		style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style.setBorderRight(XSSFCellStyle.BORDER_THIN);
		style.setBorderLeft(XSSFCellStyle.BORDER_THIN);
		style.setBorderTop(XSSFCellStyle.BORDER_THIN);
		style.setBorderBottom(XSSFCellStyle.BORDER_THIN);
		
		int r = 0;
		
		for( int i=0; null!=defJobList && i<defJobList.size(); i++ ){
			
			Map map = new HashMap();
			
			map.put("table_id",				defJobList.get(i).getTable_id());
			map.put("job_id",				defJobList.get(i).getJob_id());
			map.put("job_name",				defJobList.get(i).getJob_name());
			map.put("p_sched_table",		defJobList.get(i).getSched_table());
			map.put("p_application_of_def",	defJobList.get(i).getApplication());
			map.put("p_group_name_of_def",	defJobList.get(i).getGroup_name());
			map.put("SCHEMA", 				CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
			
			JobDefineInfoBean bean = popupDefJobDetailService.dGetJobDefineInfo(map);
			
			String strJob_name			= CommonUtil.E2K(CommonUtil.isNull(bean.getJob_name()));
			
            DefJobBean bean2 				= (DefJobBean)defJobList.get(i);
			
			String strUser_cd_2  		   	= CommonUtil.E2K(CommonUtil.isNull(bean2.getUser_cd_2()));
			String strUser_cd_3  		   	= CommonUtil.E2K(CommonUtil.isNull(bean2.getUser_cd_3()));
			String strUser_cd_4  		   	= CommonUtil.E2K(CommonUtil.isNull(bean2.getUser_cd_4()));
			String strUser_cd_5  		   	= CommonUtil.E2K(CommonUtil.isNull(bean2.getUser_cd_5()));
			String strUser_cd_6  		   	= CommonUtil.E2K(CommonUtil.isNull(bean2.getUser_cd_6()));
			String strUser_cd_7  		   	= CommonUtil.E2K(CommonUtil.isNull(bean2.getUser_cd_7()));
			String strUser_cd_8  		   	= CommonUtil.E2K(CommonUtil.isNull(bean2.getUser_cd_8()));
			String strUser_cd_9  		   	= CommonUtil.E2K(CommonUtil.isNull(bean2.getUser_cd_9()));
			String strUser_cd_10  		   	= CommonUtil.E2K(CommonUtil.isNull(bean2.getUser_cd_10()));
			
			String strUser_id_2  		   	= CommonUtil.E2K(CommonUtil.isNull(bean2.getUser_id_2()));
			String strUser_id_3  		   	= CommonUtil.E2K(CommonUtil.isNull(bean2.getUser_id_3()));
			String strUser_id_4  		   	= CommonUtil.E2K(CommonUtil.isNull(bean2.getUser_id_4()));
			String strUser_id_5  		   	= CommonUtil.E2K(CommonUtil.isNull(bean2.getUser_id_5()));
			String strUser_id_6  		   	= CommonUtil.E2K(CommonUtil.isNull(bean2.getUser_id_6()));
			String strUser_id_7  		   	= CommonUtil.E2K(CommonUtil.isNull(bean2.getUser_id_7()));
			String strUser_id_8  		   	= CommonUtil.E2K(CommonUtil.isNull(bean2.getUser_id_8()));
			String strUser_id_9  		   	= CommonUtil.E2K(CommonUtil.isNull(bean2.getUser_id_9()));
			String strUser_id_10  		   	= CommonUtil.E2K(CommonUtil.isNull(bean2.getUser_id_10()));
			
			String strUserNm  	   			= CommonUtil.E2K(CommonUtil.isNull(bean2.getUser_nm()));
			String strAuthor 	   			= CommonUtil.E2K(CommonUtil.isNull(bean2.getAuthor()));
			
			String strSms_1			= CommonUtil.isNull(CommonUtil.E2K(bean2.getSms_1()), "N");
			String strMail_1		= CommonUtil.isNull(CommonUtil.E2K(bean2.getMail_1()), "N"); 
			String strSms_2			= CommonUtil.isNull(CommonUtil.E2K(bean2.getSms_2()), "N"); 
			String strMail_2		= CommonUtil.isNull(CommonUtil.E2K(bean2.getMail_2()), "N");
			String strSms_3			= CommonUtil.isNull(CommonUtil.E2K(bean2.getSms_3()), "N");
			String strMail_3		= CommonUtil.isNull(CommonUtil.E2K(bean2.getMail_3()), "N");
			String strSms_4			= CommonUtil.isNull(CommonUtil.E2K(bean2.getSms_4()), "N");
			String strMail_4		= CommonUtil.isNull(CommonUtil.E2K(bean2.getMail_4()), "N");
			String strSms_5	 		= CommonUtil.isNull(CommonUtil.E2K(bean2.getSms_5()), "N");
			String strMail_5		= CommonUtil.isNull(CommonUtil.E2K(bean2.getMail_5()), "N"); 
			String strSms_6			= CommonUtil.isNull(CommonUtil.E2K(bean2.getSms_6()), "N"); 
			String strMail_6		= CommonUtil.isNull(CommonUtil.E2K(bean2.getMail_6()), "N");
			String strSms_7			= CommonUtil.isNull(CommonUtil.E2K(bean2.getSms_7()), "N");
			String strMail_7		= CommonUtil.isNull(CommonUtil.E2K(bean2.getMail_7()), "N");
			String strSms_8			= CommonUtil.isNull(CommonUtil.E2K(bean2.getSms_8()), "N");
			String strMail_8		= CommonUtil.isNull(CommonUtil.E2K(bean2.getMail_8()), "N");
			String strSms_9			= CommonUtil.isNull(CommonUtil.E2K(bean2.getSms_9()), "N");
			String strMail_9		= CommonUtil.isNull(CommonUtil.E2K(bean2.getMail_9()), "N");
			String strSms_10		= CommonUtil.isNull(CommonUtil.E2K(bean2.getSms_10()), "N");
			String strMail_10		= CommonUtil.isNull(CommonUtil.E2K(bean2.getMail_10()), "N");
			
			//담당자그룹
			String strGrp_nm1		= CommonUtil.isNull(CommonUtil.E2K(bean2.getGrp_nm_1()), "");
			String strGrp_nm2		= CommonUtil.isNull(CommonUtil.E2K(bean2.getGrp_nm_2()), "");
			String strGrpSms1		= CommonUtil.isNull(CommonUtil.E2K(bean2.getGrp_sms_1()), "N");
			String strGrpSms2		= CommonUtil.isNull(CommonUtil.E2K(bean2.getGrp_sms_2()), "N");
			String strGrpMail1		= CommonUtil.isNull(CommonUtil.E2K(bean2.getGrp_mail_1()), "N");
			String strGrpMail2		= CommonUtil.isNull(CommonUtil.E2K(bean2.getGrp_mail_2()), "N");
			
			
			
			r++;
			n = -1;
			
			setCellValue(r, ++n, strJob_name);
			
			setCellValue(r, ++n, strAuthor);
			
			setCellValue(r, ++n, strSms_1);
	
			setCellValue(r, ++n, strMail_1);
			
			setCellValue(r, ++n, strUser_id_2);
			
			setCellValue(r, ++n, strSms_2);
	
			setCellValue(r, ++n, strMail_2);
			
			setCellValue(r, ++n, strUser_id_3);
			
			setCellValue(r, ++n, strSms_3);
	
			setCellValue(r, ++n, strMail_3);
			
			setCellValue(r, ++n, strUser_id_4);
			
			setCellValue(r, ++n, strSms_4);
	
			setCellValue(r, ++n, strMail_4);
			
			setCellValue(r, ++n, strUser_id_5);
			
			setCellValue(r, ++n, strSms_5);
	
			setCellValue(r, ++n, strMail_5);
			
			setCellValue(r, ++n, strUser_id_6);
			
			setCellValue(r, ++n, strSms_6);
	
			setCellValue(r, ++n, strMail_6);
			
			setCellValue(r, ++n, strUser_id_7);
			
			setCellValue(r, ++n, strSms_7);
	
			setCellValue(r, ++n, strMail_7);
			
			setCellValue(r, ++n, strUser_id_8);
			
			setCellValue(r, ++n, strSms_8);
	
			setCellValue(r, ++n, strMail_8);
			
			setCellValue(r, ++n, strUser_id_9);
			
			setCellValue(r, ++n, strSms_9);
	
			setCellValue(r, ++n, strMail_9);
			
			setCellValue(r, ++n, strUser_id_10);
			
			setCellValue(r, ++n, strSms_10);
	
			setCellValue(r, ++n, strMail_10);
			
			setCellValue(r, ++n, strGrp_nm1);

			setCellValue(r, ++n, strGrpSms1);

			setCellValue(r, ++n, strGrpMail1);

			setCellValue(r, ++n, strGrp_nm2);

			setCellValue(r, ++n, strGrpSms2);

			setCellValue(r, ++n, strGrpMail2);
			
			
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
