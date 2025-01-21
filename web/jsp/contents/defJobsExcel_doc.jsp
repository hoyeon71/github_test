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
	
	OutputStream os = null;
	sheet = null;
	wb = new SXSSFWorkbook();
	
// 	String fileName = "엑셀일괄양식";
// 	response.setHeader("Content-Type", "application/vnd.ms-xls;charset=UTF-8");
// 	response.setHeader("Content-Disposition", "attachment;filename="+URLEncoder.encode(fileName,"UTF-8")+".xls");   
// 	response.setHeader("Content-Description", "JSP Generated Data");

	String fileName = "엑셀일괄양식.xlsx"; 
	response.reset() ;
	response.setHeader("Content-Description", "JSP Generated Data");
	response.setHeader("Content-Type", "application/octet-stream; charset=UTF-8");
	response.setHeader("Content-Disposition", "attachment; filename="+java.net.URLEncoder.encode(fileName,"UTF-8").replaceAll("\\+","%20"));
	
	List<DefJobBean> defJobList							= (List)request.getAttribute("defJobList");
	
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
		
		//setCellValue(0, ++n, "*시스템구분");
	
		//setCellValue(0, ++n, "*작업유형구분");
	
// 		setCellValue(0, ++n, "*테이블");
		setCellValue(0, ++n, "*작업타입");
		
		setCellValue(0, ++n, "*폴더");
		
		setCellValue(0, ++n, "*어플리케이션");
	
		setCellValue(0, ++n, "*그룹");
		
		setCellValue(0, ++n, "*수행서버");
		
		setCellValue(0, ++n, "*계정명");
		
		setCellValue(0, ++n, "*최대대기일");
	
		setCellValue(0, ++n, "*작업명");
	
		setCellValue(0, ++n, "*작업 설명");
		
		setCellValue(0, ++n, "*프로그램 위치");
		
 		setCellValue(0, ++n, "*프로그램 명");
		
		setCellValue(0, ++n, "*작업수행명령");
		
		setCellValue(0, ++n, "작업시작시간");
		
		setCellValue(0, ++n, "작업종료시간");
		
		setCellValue(0, ++n, "시작임계시간");
		
		setCellValue(0, ++n, "종료임계시간");
	
		setCellValue(0, ++n, "수행임계시간");
		
		setCellValue(0, ++n, "반복작업");
		
		setCellValue(0, ++n, "반복구분");
		
		setCellValue(0, ++n, "반복주기");
		
		setCellValue(0, ++n, "반복주기(불규칙)");
	
		setCellValue(0, ++n, "반복주기(시간지정)");

		setCellValue(0, ++n, "반복기준");
		
		setCellValue(0, ++n, "허용오차(분)");
	
		setCellValue(0, ++n, "최대반복횟수");
		
		//setCellValue(0, ++n, "count_cyclic_from");
		
		setCellValue(0, ++n, "Confirm Flag");
		
		setCellValue(0, ++n, "우선순위");
		
		setCellValue(0, ++n, "성공 시 알람 발송");
		
		setCellValue(0, ++n, "*중요작업");
		
		setCellValue(0, ++n, "실행날짜");
		
		setCellValue(0, ++n, "월캘린더");
		
		setCellValue(0, ++n, "CONF_CAL");
		
		setCellValue(0, ++n, "POLICY");
		
		setCellValue(0, ++n, "SHIFT_NUM");
		
		setCellValue(0, ++n, "수행 범위일");
		
		setCellValue(0, ++n, "1월");
		
		setCellValue(0, ++n, "2월");
		
		setCellValue(0, ++n, "3월");
		
		setCellValue(0, ++n, "4월");
		
		setCellValue(0, ++n, "5월");
		
		setCellValue(0, ++n, "6월");
		
		setCellValue(0, ++n, "7월");
		
		setCellValue(0, ++n, "8월");
		
		setCellValue(0, ++n, "9월");
		
		setCellValue(0, ++n, "10월");
		
		setCellValue(0, ++n, "11월");
		
		setCellValue(0, ++n, "12월");
		
		setCellValue(0, ++n, "schedule_and_or");
		
		setCellValue(0, ++n, "실행요일");
		
		setCellValue(0, ++n, "일캘린더");
		
		setCellValue(0, ++n, "특정실행날짜");
		
		setCellValue(0, ++n, "IN_CONDITION");
		
		setCellValue(0, ++n, "*OUT_CONDITION");
	
		setCellValue(0, ++n, "*담당자1_사번");

		setCellValue(0, ++n, "담당자1_"+strSms);

		setCellValue(0, ++n, "담당자1_"+strMail);

		setCellValue(0, ++n, "담당자2_사번");

		setCellValue(0, ++n, "담당자2_"+strSms);

		setCellValue(0, ++n, "담당자2_"+strMail);

		setCellValue(0, ++n, "담당자3_사번");

		setCellValue(0, ++n, "담당자3_"+strSms);

		setCellValue(0, ++n, "담당자3_"+strMail);

		setCellValue(0, ++n, "담당자4_사번");

		setCellValue(0, ++n, "담당자4_"+strSms);
		
		setCellValue(0, ++n, "담당자4_"+strMail);

		setCellValue(0, ++n, "담당자5_사번");
		
		setCellValue(0, ++n, "담당자5_"+strSms);
		
		setCellValue(0, ++n, "담당자5_"+strMail);

		setCellValue(0, ++n, "담당자6_사번");
		
		setCellValue(0, ++n, "담당자6_"+strSms);
		
		setCellValue(0, ++n, "담당자6_"+strMail);

		setCellValue(0, ++n, "담당자7_사번");

		setCellValue(0, ++n, "담당자7_"+strSms);

		setCellValue(0, ++n, "담당자7_"+strMail);

		setCellValue(0, ++n, "담당자8_사번");

		setCellValue(0, ++n, "담당자8_"+strSms);

		setCellValue(0, ++n, "담당자8_"+strMail);

		setCellValue(0, ++n, "담당자9_사번");

		setCellValue(0, ++n, "담당자9_"+strSms);

		setCellValue(0, ++n, "담당자9_"+strMail);

		setCellValue(0, ++n, "담당자10_사번");

		setCellValue(0, ++n, "담당자10_"+strSms);

		setCellValue(0, ++n, "담당자10_"+strMail);
		
		setCellValue(0, ++n, "그룹1");

		setCellValue(0, ++n, "그룹1_"+strSms);

		setCellValue(0, ++n, "그룹1_"+strMail);
		
		setCellValue(0, ++n, "그룹2");

		setCellValue(0, ++n, "그룹2_"+strSms);

		setCellValue(0, ++n, "그룹2_"+strMail);

		setCellValue(0, ++n, "RESOURCE");
		
		setCellValue(0, ++n, "변수");
		
		setCellValue(0, ++n, "ON/DO");

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
			
			String strTableName			= CommonUtil.E2K(CommonUtil.isNull(bean.getTable_name()));
			String strApplication		= CommonUtil.E2K(CommonUtil.isNull(bean.getApplication()));
			String strGroup_name		= CommonUtil.E2K(CommonUtil.isNull(bean.getGroup_name()));
			String strJob_name			= CommonUtil.E2K(CommonUtil.isNull(bean.getJob_name()));
			String strDescription		= CommonUtil.E2K(CommonUtil.isNull(bean.getDescription()));
			String strMem_name			= CommonUtil.E2K(CommonUtil.isNull(bean.getMem_name()));
			String strMem_lib			= CommonUtil.E2K(CommonUtil.isNull(bean.getMem_lib()));
			
			if(strMem_lib.length() > 3 && strMem_lib.substring(2, 3).equals("\\") && !strMem_lib.substring(3, 4).equals("\\")){
				strMem_lib = strMem_lib.replaceAll("\\\\", "\\\\\\\\");
			}
			
			String strOwner				= CommonUtil.E2K(CommonUtil.isNull(bean.getOwner()));		
			String strTask_type			= CommonUtil.isNull(bean.getTask_type());	
			
			
			String strNode_id				= CommonUtil.E2K(CommonUtil.isNull(bean.getNode_id()));	
			String strPriority				= CommonUtil.isNull(bean.getPriority());      				
			String strCritical				= CommonUtil.isNull(bean.getCritical());						
			String strCyclic				= CommonUtil.isNull(bean.getCyclic());			
			String strCyclicType			= CommonUtil.isNull(bean.getCyclic_type());			
			String strIntervalSequence		= CommonUtil.isNull(bean.getInterval_sequence());			
			String strSpecificTimes			= CommonUtil.isNull(bean.getSpecific_times());			
			String strRerun_interval		= CommonUtil.isNull(bean.getRerun_interval());
			String strRerun_interval_time	= CommonUtil.isNull(bean.getRerun_interval_time());	
			String strRerun_max				= CommonUtil.isNull(bean.getRerun_max());						
			String strCount_cyclic_from_org = CommonUtil.isNull(bean.getCount_cyclic_from());
			
			if(strRerun_interval_time.equals("H")){
				int maxRerunIntervalSize = 5;
				strRerun_interval = CommonUtil.isNull((Integer.parseInt(strRerun_interval) * 60));
				
				if(strRerun_interval.length() < maxRerunIntervalSize) {
					String temp = "";
					for(int j = 0; j < maxRerunIntervalSize - strRerun_interval.length(); j++ ){
						temp += "0"; 
					}
					strRerun_interval = temp + strRerun_interval;
				}
				
			}
			
			if ( !strIntervalSequence.equals("") ) {
				strIntervalSequence = strIntervalSequence.replaceAll("[+]", "").replaceAll("M", "");
			}
			
			String strT_resources_q 	= CommonUtil.isNull(bean.getT_resources_q());
			String strT_resources_c 	= CommonUtil.isNull(bean.getT_resources_c());
			String strT_set				= CommonUtil.isNull(bean.getT_set());
			
			// LIBMEMSIM 제거 후 변수 셋팅.
			String strT_set_var = "";
			if ( !strT_set.equals("") ) {
				String arr_t_set[]  = strT_set.split("[|]");		
				for ( int j = 0; j < arr_t_set.length; j++ ) {
					String arr_t_set_detail[]  = arr_t_set[j].split("[,]");
					
					if ( arr_t_set_detail.length > 1 ) {
					
						if ( arr_t_set_detail[0].equals("LIBMEMSYM") ) {
							
						} else {
							strT_set_var += "|" + arr_t_set[j];
						}
					}
				}
				
				if ( !strT_set_var.equals("") && strT_set_var.substring(0, 1).equals("|") ) strT_set_var = strT_set_var.substring(1, strT_set_var.length());
			}
			
			String strT_steps				= CommonUtil.isNull(bean.getT_steps());
			String strT_postproc			= CommonUtil.isNull(bean.getT_postproc());
			
			String strTconditionsIn			= CommonUtil.isNull(bean.getT_conditions_in());
			String strTconditionsOut		= CommonUtil.isNull(bean.getT_conditions_out());		
			
//	 		String strActiveFrom			= CommonUtil.isNull(bean.getActive_from());
//	 		String strActiveTill			= CommonUtil.isNull(bean.getActive_till());
			
			DefJobBean bean2 				= (DefJobBean)defJobList.get(i);
			
			String strIn_odate 				= CommonUtil.isNull(bean2.getIn_strOdate());
			String strOut_odate 			= CommonUtil.isNull(bean2.getOut_strOdate());
			String strIn_sign 				= CommonUtil.isNull(bean2.getIn_sign());
			String strOut_sign 				= CommonUtil.isNull(bean2.getOut_sign());
			
			String strCount_cyclic_from = "";
			if("E".equals(strCount_cyclic_from_org)){
				strCount_cyclic_from = "end";
			}else if("S".equals(strCount_cyclic_from_org)){
				strCount_cyclic_from = " ";
		
			}else{
				strCount_cyclic_from = " ";
			}
		
		
		if("+".equals(strOut_sign)){
			strOut_sign = "add";
		}else if("-".equals(strOut_sign)){
			strOut_sign = "del";
		}else{
			strOut_sign = "";
		}
		
		if("A".equals(strIn_sign)){
			strIn_sign = "and";
		}else if("O".equals(strIn_sign)){
			strIn_sign = "or";
		}else{
			strIn_sign = "";
		}
		String strCommand = CommonUtil.E2K(CommonUtil.isNull(bean2.getCmd_line()));	
		if(strCommand.length() > 3 && strCommand.substring(2, 3).equals("\\") && !strCommand.substring(3, 4).equals("\\")){
			strCommand = strCommand.replaceAll("\\\\", "\\\\\\\\");
		}
		if(CommonUtil.replaceStrHtml(strMem_lib).equals("MFT") || CommonUtil.replaceStrHtml(strMem_lib).equals("Kubernetes")) continue;
		
		if(strTask_type.equals("job")){
			strTask_type = "script";
			strCommand = "";
		}else if(strTask_type.equals("command")){
			strMem_lib = "";
			strMem_name = "";
		}else{
			strMem_lib = "";
			strMem_name = "";
			strCommand = "";
		}
		
		
		
		/* if ( !strCommand.equals("") ) { 
			if ( strCommand.indexOf(" ") > -1 ) {
				strArgument = strCommand.substring(strCommand.indexOf(" ")+1, strCommand.length());
			}
		} */
		
		String strConfirm_flag			= CommonUtil.E2K(CommonUtil.isNull(bean.getConfirm_flag()));
		String strMax_wait				= CommonUtil.E2K(CommonUtil.isNull(bean.getMax_wait()));						
		String strTime_from				= CommonUtil.E2K(CommonUtil.isNull(bean2.getFrom_time()));				
		String strTime_until			= CommonUtil.E2K(CommonUtil.isNull(bean2.getTo_time()));					

		/* String strInCondition_tmp	= CommonUtil.E2K(CommonUtil.isNull(bean2.getIn_condition()));
		String strInCondition_org	= strInCondition_tmp.replace(",",",ODAT,and|");
		if("".equals(strInCondition_org)){
			strInCondition	    = "";
		}else{
			strInCondition	    = strInCondition_org+",ODAT,and";
		}
		
		strOutCondition_tmp = CommonUtil.E2K(CommonUtil.isNull(bean2.getOut_condition()));
		strOutCondition_org	= strOutCondition_tmp.replace(",",",ODAT,add|");
		if("".equals(strOutCondition_org)){
			strOutCondition	    = "";
		}else{
			strOutCondition	= strOutCondition_org+",ODAT,add";
		} */
		
		// 위의 로직이 왜 있는 지 모르겠음 (2018.01.03 강명준)
		String strInCondition = strTconditionsIn;
		String strOutCondition = strTconditionsOut;
		
		String strLate_sub 		   	= CommonUtil.E2K(CommonUtil.isNull(bean2.getLate_sub()));
		String strLate_time  		   	= CommonUtil.E2K(CommonUtil.isNull(bean2.getLate_time()));
		String strLate_exec  		   	= CommonUtil.E2K(CommonUtil.isNull(bean2.getLate_exec()));
		String strBatchjobGrade  	   	= CommonUtil.E2K(CommonUtil.isNull(bean2.getBatchjobGrade()));
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
		String strSuccessSmsYn			= CommonUtil.isNull(bean2.getSuccess_sms_yn(), "N");
		
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
		String strGrpSms2		= CommonUtil.isNull(CommonUtil.E2K(bean2.getGrp_sms_1()), "N");
		String strGrpMail1		= CommonUtil.isNull(CommonUtil.E2K(bean2.getGrp_mail_1()), "N");
		String strGrpMail2		= CommonUtil.isNull(CommonUtil.E2K(bean2.getGrp_mail_1()), "N");
		
		String strError_description		= CommonUtil.isNull(CommonUtil.E2K(bean2.getError_description()), "");
		
		String strIndCyclic		= CommonUtil.isNull(CommonUtil.E2K(bean2.getInd_cyclic()), "");
		String strTolerance		= CommonUtil.isNull(CommonUtil.E2K(bean2.getTolerance()), "");

		String strCalendar_nm 	  		= CommonUtil.E2K(CommonUtil.isNull(bean2.getCalendar_nm()));
		
		String strMonth_days            = CommonUtil.E2K(CommonUtil.isNull(bean2.getMonth_days()));
		String strDays_cal 		        = CommonUtil.E2K(CommonUtil.isNull(bean2.getDays_cal()));
		String strConfCal				= CommonUtil.E2K(CommonUtil.isNull(bean2.getConf_cal()));
		String strShift					= CommonUtil.E2K(CommonUtil.isNull(bean2.getShift()));
		String strShiftNum				= CommonUtil.E2K(CommonUtil.isNull(bean2.getShift_num()));
		String strMonth_1 		        = CommonUtil.E2K(CommonUtil.isNull(bean2.getMonth_1()));
		String strMonth_2 		        = CommonUtil.E2K(CommonUtil.isNull(bean2.getMonth_2()));
		String strMonth_3 		        = CommonUtil.E2K(CommonUtil.isNull(bean2.getMonth_3()));
		String strMonth_4 		        = CommonUtil.E2K(CommonUtil.isNull(bean2.getMonth_4()));
		String strMonth_5 		        = CommonUtil.E2K(CommonUtil.isNull(bean2.getMonth_5()));
		String strMonth_6 		        = CommonUtil.E2K(CommonUtil.isNull(bean2.getMonth_6()));
		String strMonth_7 		        = CommonUtil.E2K(CommonUtil.isNull(bean2.getMonth_7()));
		String strMonth_8 		        = CommonUtil.E2K(CommonUtil.isNull(bean2.getMonth_8()));
		String strMonth_9 		        = CommonUtil.E2K(CommonUtil.isNull(bean2.getMonth_9()));
		String strMonth_10 		        = CommonUtil.E2K(CommonUtil.isNull(bean2.getMonth_10()));
		String strMonth_11 		        = CommonUtil.E2K(CommonUtil.isNull(bean2.getMonth_11()));
		String strMonth_12 		        = CommonUtil.E2K(CommonUtil.isNull(bean2.getMonth_12()));
		String strSchedule_and_or       = CommonUtil.E2K(CommonUtil.isNull(bean2.getSchedule_and_or()));
		String strWeek_days 		    = CommonUtil.E2K(CommonUtil.isNull(bean2.getWeek_days()));
		String strWeeks_cal 		    = CommonUtil.E2K(CommonUtil.isNull(bean2.getWeeks_cal()));
		String strActiveFrom			= CommonUtil.E2K(CommonUtil.isNull(bean2.getActive_from()));
		String strActiveTill			= CommonUtil.E2K(CommonUtil.isNull(bean2.getActive_till()));
		String strActiveDay				= "";
		if(!strActiveFrom.equals("") && !strActiveTill.equals("")) {
			strActiveDay				= strActiveFrom + "~" + strActiveTill;
		}
		
		//String strArgument			  = CommonUtil.E2K(CommonUtil.isNull(bean2.getArgument()));		
		String strJobTypeGb				= CommonUtil.E2K(CommonUtil.isNull(bean2.getJobTypeGb()));		
		String strJobSchedGb			= CommonUtil.E2K(CommonUtil.isNull(bean2.getJobSchedGb()));		
		String strSystemGb				= CommonUtil.E2K(CommonUtil.isNull(bean2.getSystemGb()));
		String strGeneralDate			= CommonUtil.E2K(CommonUtil.isNull(bean2.getDates_str()));
		
		if(!strGeneralDate.equals("")){
			String temp_general_date = "";
			for(int ii=4; ii<=strGeneralDate.length();ii+=4){
				temp_general_date += strGeneralDate.substring(ii-4,ii);
				temp_general_date += ", ";
			}
			
			if(!temp_general_date.equals("")) strGeneralDate = temp_general_date.substring(0,temp_general_date.length()-2);
		}
		
		if("E".equals(strCount_cyclic_from_org)){
			strIndCyclic = "E";
		}else if("S".equals(strCount_cyclic_from_org)){
			strIndCyclic = "S";
		}else{
			strIndCyclic = "T";
		}
		
		r++;
		n = -1;
		
		//setCellValue(r, ++n, strSystemGb);
		
		//setCellValue(r, ++n, strJobTypeGb);

// 		setCellValue(r, ++n, strTableName);

		setCellValue(r, ++n, strTask_type);
		
		setCellValue(r, ++n, strTableName);
		
		setCellValue(r, ++n, strApplication);

		setCellValue(r, ++n, strGroup_name);
		
		setCellValue(r, ++n, strNode_id);
		
		setCellValue(r, ++n, strOwner);
		
		setCellValue(r, ++n, strMax_wait);
		
		setCellValue(r, ++n, CommonUtil.replaceStrHtml(strJob_name));

		setCellValue(r, ++n, CommonUtil.replaceStrHtml(strDescription));
		
		setCellValue(r, ++n, CommonUtil.replaceStrHtml(strMem_lib));

 		setCellValue(r, ++n, CommonUtil.replaceStrHtml(strMem_name));
		
		setCellValue(r, ++n, CommonUtil.replaceStrHtml(strCommand));
		
		setCellValue(r, ++n, strTime_from);

		setCellValue(r, ++n, strTime_until);

		setCellValue(r, ++n, strLate_sub);

		setCellValue(r, ++n, strLate_time);

		setCellValue(r, ++n, strLate_exec);
		
		setCellValue(r, ++n, strCyclic);
		
		setCellValue(r, ++n, strCyclicType);
		
		setCellValue(r, ++n, strRerun_interval);
		
		setCellValue(r, ++n, strIntervalSequence);
		
		setCellValue(r, ++n, strSpecificTimes);
		
		setCellValue(r, ++n, strIndCyclic);
		
		setCellValue(r, ++n, strTolerance);
		
		setCellValue(r, ++n, strRerun_max);
		
		//setCellValue(r, ++n, strCount_cyclic_from);

		setCellValue(r, ++n, strConfirm_flag);
		
		setCellValue(r, ++n, strPriority);
		
		setCellValue(r, ++n, strSuccessSmsYn);
		
		setCellValue(r, ++n, strCritical);
		
		//setCellValue(r, ++n, strCalendar_nm);
		
		setCellValue(r, ++n, strMonth_days);
		setCellValue(r, ++n, strDays_cal);
		setCellValue(r, ++n, strConfCal);
		setCellValue(r, ++n, strShift);
		setCellValue(r, ++n, strShiftNum);
		setCellValue(r, ++n, strActiveDay);
		
		setCellValue(r, ++n, strMonth_1);
		setCellValue(r, ++n, strMonth_2);
		setCellValue(r, ++n, strMonth_3);
		setCellValue(r, ++n, strMonth_4);
		setCellValue(r, ++n, strMonth_5);
		setCellValue(r, ++n, strMonth_6);
		setCellValue(r, ++n, strMonth_7);
		setCellValue(r, ++n, strMonth_8);
		setCellValue(r, ++n, strMonth_9);
		setCellValue(r, ++n, strMonth_10);
		setCellValue(r, ++n, strMonth_11);
		setCellValue(r, ++n, strMonth_12);
		setCellValue(r, ++n, strSchedule_and_or);
		setCellValue(r, ++n, strWeek_days);
		setCellValue(r, ++n, strWeeks_cal);
		
		setCellValue(r, ++n, strGeneralDate);
		
		setCellValue(r, ++n, strInCondition);

		setCellValue(r, ++n, strOutCondition);
		
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

		setCellValue(r, ++n, CommonUtil.replaceStrHtml(strT_resources_q));
		
		setCellValue(r, ++n, CommonUtil.replaceStrHtml(strT_set_var));
		
		setCellValue(r, ++n, CommonUtil.replaceStrHtml(strT_steps));
		
// 		setCellValue(r, ++n, strBatchjobGrade);

		//setCellValue(r, ++n, strPriority);

		//setCellValue(r, ++n, strCritical);

		//setCellValue(r, ++n, strGlobalcond_yn);
		
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
