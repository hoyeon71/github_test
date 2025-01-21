<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.ghayoun.ezjobs.common.util.CommonUtil"%>
<%@page import="java.io.File"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@page import="com.ghayoun.ezjobs.common.util.DateUtil"%>
<%@page import="com.ghayoun.ezjobs.common.util.SeedUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%


	String strLog4jLogPath		= CommonUtil.isNull(CommonUtil.getMessage("LOG4J.LOG.PATH"));
	String strLog4jLogDelCnt	= CommonUtil.isNull(CommonUtil.getMessage("LOG4J.LOG.DEL.CNT"));

	String strDeleteDate		= DateUtil.addDate(DateUtil.getDay(0), -3);
	strDeleteDate				= strDeleteDate.substring(0, 4) + "-" + strDeleteDate.substring(4, 6) + "-" + strDeleteDate.substring(6, 8);
	
	Calendar fileCal 	= Calendar.getInstance();
	Date fileDate		= null;
	
	Calendar nowCal 	= Calendar.getInstance();
	long todayTimeMil	= nowCal.getTimeInMillis();
	
	long oneDayMil 		= 24 * 60 * 60 * 1000;
	
	File path = new File(strLog4jLogPath);
	File[] list = path.listFiles();	// 파일 리스트 가져오기
	
	if ( list != null ) {
	
		for ( int i = 0; i < list.length; i++ ) {
			
			if ( list[i].isFile() ) {	// 파일 일 때
				
				// 파일의 마지막 수정시간 가져오기
				fileDate	= new Date(list[i].lastModified());
				fileCal.setTime(fileDate);
				
				long fileTimeMil = fileCal.getTimeInMillis();
				
				long diffTimeMil = todayTimeMil - fileTimeMil;
				int diffDayCnt 	= (int) (diffTimeMil / oneDayMil);
				
				if ( Integer.parseInt(strLog4jLogDelCnt) < diffDayCnt ) {
				    //list[i].delete();
				    out.println("file delete => " + list[i].getName());
				    out.println("<BR>");
				}
			}
		}
		
	} else {
		
		out.println("file is null.");
	}
%>

