<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.ghayoun.ezjobs.m.domain.*,com.ghayoun.ezjobs.t.domain.*" %>

<%@include file="/jsp/common/inc/header.jsp"%>
<%@include file="/jsp/common/inc/sessionChkPopup.jsp"%>
<%
	//js version 추가하여 캐시 새로고침
	String jsVersion = CommonUtil.getMessage("js_version");
%>

<html lang="ko" >
<head><title><%=CommonUtil.getMessage("HOME.TITLE") %></title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<link href="<%=request.getContextPath() %>/css/common.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath() %>/css/custom-theme/jquery-ui.custom.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath() %>/css/custom-theme/jquery-ui.works.css" rel="stylesheet" type="text/css" />


<script type="text/javascript" src="<%=request.getContextPath() %>/js/common.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/cookie.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/popup.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.min.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery-ui.custom.min.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/works_common.js?v=<%=jsVersion %>" ></script>
</head>

<%
	Map<String, Object> paramMap = CommonUtil.collectParameters(request);

	JobMapperBean jobMapperBean	= (JobMapperBean)request.getAttribute("jobMapperInfo");

	Doc01Bean jobMapperDocPrevInfo	= (Doc01Bean)request.getAttribute("jobMapperDocPrevInfo");
	Doc01Bean jobMapperDocNowInfo	= (Doc01Bean)request.getAttribute("jobMapperDocNowInfo");
	
	if(jobMapperDocPrevInfo == null){
		out.println("<script type='text/javascript'>");
		out.println("alert('버전비교 할 데이터가 없습니다.');");
		out.println("window.close();");
		out.println("</script>");
		return;
	}
	
	List nowDocCalList 			= (List)request.getAttribute("nowDocCalList");
	List prevDocCalList 		= (List)request.getAttribute("prevDocCalList");
	
	CalCodeBean nowDocCalBean 	= null;
	CalCodeBean prevDocCalBean 	= null;
	
	if ( nowDocCalList != null) {
		nowDocCalBean = (CalCodeBean)nowDocCalList.get(0);
	}
	
	if ( prevDocCalList != null) {
		prevDocCalBean = (CalCodeBean)prevDocCalList.get(0);
	}
	
	String strNowCalNm 		        = "-";
	String strNowDaysCal	        = "-";
	String strNowMonthDays	        = "-";
	String strNowDaysAndOr	        = "-";
	String strNowWeeksCal	        = "-";
	String strNowWeekDay	        = "-";
	
	String strNowMonth1 		        = "-";
	String strNowMonth2 		        = "-";
	String strNowMonth3 		        = "-";
	String strNowMonth4 		        = "-";
	String strNowMonth5 		        = "-";
	String strNowMonth6 		        = "-";
	String strNowMonth7 		        = "-";
	String strNowMonth8 		        = "-";
	String strNowMonth9 		        = "-";
	String strNowMonth10 		        = "-";
	String strNowMonth11 		        = "-";
	String strNowMonth12 		        = "-";
	String strNowInputParam 			= "-";

	String strPrevCalNm 	        = "-";
	String strPrevDaysCal	        = "-";
	String strPrevMonthDays	        = "-";
	String strPrevDaysAndOr	        = "-";
	String strPrevWeeksCal	        = "-";
	String strPrevWeekDay	        = "-";
	String strPrevConfCal	        = "-";
	String strPrevShift	        	= "-";
	String strPrevShiftNum	        = "-";
	
	String strPrevMonth1 		        = "-";
	String strPrevMonth2 		        = "-";
	String strPrevMonth3 		        = "-";
	String strPrevMonth4 		        = "-";
	String strPrevMonth5 		        = "-";
	String strPrevMonth6 		        = "-";
	String strPrevMonth7 		        = "-";
	String strPrevMonth8 		        = "-";
	String strPrevMonth9 		        = "-";
	String strPrevMonth10 		        = "-";
	String strPrevMonth11 		        = "-";
	String strPrevMonth12 		        = "-";
	
	if(nowDocCalBean != null){
		strNowCalNm 		= CommonUtil.isNull(nowDocCalBean.getCal_nm(), "-");
		strNowDaysCal		= CommonUtil.isNull(nowDocCalBean.getDays_cal(), "-");
		strNowMonthDays		= CommonUtil.isNull(nowDocCalBean.getMonth_days(), "-");	
		strNowDaysAndOr		= CommonUtil.isNull(nowDocCalBean.getDays_and_or(), "-");
		strNowWeeksCal		= CommonUtil.isNull(nowDocCalBean.getWeeks_cal(), "-");
		strNowWeekDay		= CommonUtil.isNull(nowDocCalBean.getWeek_days(), "-");
		
		strNowMonth1        = CommonUtil.isNull(nowDocCalBean.getMonth_cal().split(",")[0], "-");
		strNowMonth2        = CommonUtil.isNull(nowDocCalBean.getMonth_cal().split(",")[1], "-");
		strNowMonth3        = CommonUtil.isNull(nowDocCalBean.getMonth_cal().split(",")[2], "-");
		strNowMonth4        = CommonUtil.isNull(nowDocCalBean.getMonth_cal().split(",")[3], "-");
		strNowMonth5        = CommonUtil.isNull(nowDocCalBean.getMonth_cal().split(",")[4], "-");
		strNowMonth6        = CommonUtil.isNull(nowDocCalBean.getMonth_cal().split(",")[5], "-");
		strNowMonth7        = CommonUtil.isNull(nowDocCalBean.getMonth_cal().split(",")[6], "-");
		strNowMonth8        = CommonUtil.isNull(nowDocCalBean.getMonth_cal().split(",")[7], "-");
		strNowMonth9        = CommonUtil.isNull(nowDocCalBean.getMonth_cal().split(",")[8], "-");
		strNowMonth10       = CommonUtil.isNull(nowDocCalBean.getMonth_cal().split(",")[9], "-");
		strNowMonth11       = CommonUtil.isNull(nowDocCalBean.getMonth_cal().split(",")[10], "-");
		strNowMonth12       = CommonUtil.isNull(nowDocCalBean.getMonth_cal().split(",")[11], "-");
	}
	
	if(prevDocCalBean != null){
		strPrevCalNm 		= CommonUtil.isNull(prevDocCalBean.getCal_nm(), "-");
		strPrevDaysCal		= CommonUtil.isNull(prevDocCalBean.getDays_cal(), "-");
		strPrevMonthDays	= CommonUtil.isNull(prevDocCalBean.getMonth_days(), "-");	
		strPrevDaysAndOr	= CommonUtil.isNull(prevDocCalBean.getDays_and_or(), "-");
		strPrevWeeksCal		= CommonUtil.isNull(prevDocCalBean.getWeeks_cal(), "-");
		strPrevWeekDay		= CommonUtil.isNull(prevDocCalBean.getWeek_days(), "-");
		strPrevConfCal		= CommonUtil.isNull(prevDocCalBean.getConf_cal(), "-");
		strPrevShift	   	= CommonUtil.isNull(prevDocCalBean.getShift(), "-");
		strPrevShiftNum		= CommonUtil.isNull(prevDocCalBean.getShift_num(), "-");
		
		strPrevMonth1        = CommonUtil.isNull(prevDocCalBean.getMonth_cal().split(",")[0], "-");
		strPrevMonth2        = CommonUtil.isNull(prevDocCalBean.getMonth_cal().split(",")[1], "-");
		strPrevMonth3        = CommonUtil.isNull(prevDocCalBean.getMonth_cal().split(",")[2], "-");
		strPrevMonth4        = CommonUtil.isNull(prevDocCalBean.getMonth_cal().split(",")[3], "-");
		strPrevMonth5        = CommonUtil.isNull(prevDocCalBean.getMonth_cal().split(",")[4], "-");
		strPrevMonth6        = CommonUtil.isNull(prevDocCalBean.getMonth_cal().split(",")[5], "-");
		strPrevMonth7        = CommonUtil.isNull(prevDocCalBean.getMonth_cal().split(",")[6], "-");
		strPrevMonth8        = CommonUtil.isNull(prevDocCalBean.getMonth_cal().split(",")[7], "-");
		strPrevMonth9        = CommonUtil.isNull(prevDocCalBean.getMonth_cal().split(",")[8], "-");
		strPrevMonth10       = CommonUtil.isNull(prevDocCalBean.getMonth_cal().split(",")[9], "-");
		strPrevMonth11       = CommonUtil.isNull(prevDocCalBean.getMonth_cal().split(",")[10], "-");
		strPrevMonth12       = CommonUtil.isNull(prevDocCalBean.getMonth_cal().split(",")[11], "-");
	}
	
	String strT_setPrev 				= "";
	String strFile_pathPrev				= "";
	String strMonitor_timePrev			= "";
	String strMonitor_intervalPrev		= "";
	String strFilesize_comparisonPrev	= "";
	String strNum_of_iterationsPrev		= "";
	String strStop_timePrev				= "";
	
	if(jobMapperDocNowInfo != null){
		String strNowCmdLine = CommonUtil.isNull(jobMapperDocNowInfo.getCommand(), "-");
		if(!strNowCmdLine.equals("") && strNowCmdLine.contains(" ")){
			strNowInputParam = strNowCmdLine.split(" ")[1];
		}else{
			strNowInputParam = "dummy";
		}
	}
	if(jobMapperDocPrevInfo != null){
		
		strT_setPrev 				= CommonUtil.isNull(jobMapperDocPrevInfo.getT_set());
		// LIBMEMSIM, FileWatch 제거 후 변수 셋팅.
		String strT_set_varPrev = "";
		if ( !strT_setPrev.equals("") ) {
			String arr_t_setPrev[]  = strT_setPrev.split("[|]");		
			for ( int i = 0; i < arr_t_setPrev.length; i++ ) {
				String arr_t_set_detailPrev[]  = arr_t_setPrev[i].split("[,]");
				
				if ( arr_t_set_detailPrev.length > 1 ) {
				
					if ( arr_t_set_detailPrev[0].equals("LIBMEMSYM") || arr_t_set_detailPrev[0].indexOf("FileWatch") > -1  ) {
						
					} else {
						strT_set_varPrev += "|" + arr_t_setPrev[i];
					}
					
					// FileWatch 셋팅
					if (arr_t_set_detailPrev[0].indexOf("FileWatch-FILE_PATH") > -1){
						strFile_pathPrev = arr_t_set_detailPrev[1];
					}
					if ( arr_t_set_detailPrev[0].indexOf("FileWatch-INT_FILE_SEARCHES") > -1 ) {
						strMonitor_intervalPrev = arr_t_set_detailPrev[1];
					}
					if ( arr_t_set_detailPrev[0].indexOf("FileWatch-TIME_LIMIT") > -1 ) {
						strMonitor_timePrev = arr_t_set_detailPrev[1];
					}
					if ( arr_t_set_detailPrev[0].indexOf("FileWatch-INT_FILESIZE_COMPARISON") > -1 ) {
						strFilesize_comparisonPrev = arr_t_set_detailPrev[1];
					}
					if ( arr_t_set_detailPrev[0].indexOf("FileWatch-NUM_OF_ITERATIONS") > -1 ) {
						strNum_of_iterationsPrev = arr_t_set_detailPrev[1];
					}
					if ( arr_t_set_detailPrev[0].indexOf("FileWatch-STOP_TIME") > -1 ) {
						strStop_timePrev = arr_t_set_detailPrev[1];
					}
				}
			}
			
			if ( !strT_set_varPrev.equals("") && strT_set_varPrev.substring(0, 1).equals("|") ) strT_set_varPrev = strT_set_varPrev.substring(1, strT_set_varPrev.length());
		}
		
	}
	
	String strT_setNow = CommonUtil.isNull(jobMapperDocNowInfo.getT_set());
	
	String strFile_pathNow  			= "";
	String strMonitor_timeNow			= "";
	String strMonitor_intervalNow		= "";
	String strFilesize_comparisonNow	= "";
	String strNum_of_iterationsNow		= "";
	String strStop_timeNow				= "";
	
	// LIBMEMSIM, FileWatch 제거 후 변수 셋팅.
	String strT_set_varNow = "";
	if ( !strT_setNow.equals("") ) {
		String arr_t_setNow[]  = strT_setNow.split("[|]");		
		for ( int i = 0; i < arr_t_setNow.length; i++ ) {
			String arr_t_set_detailNow[]  = arr_t_setNow[i].split("[,]");
			
			if ( arr_t_set_detailNow.length > 1 ) {
			
				if ( arr_t_set_detailNow[0].equals("LIBMEMSYM") || arr_t_set_detailNow[0].indexOf("FileWatch") > -1  ) {
					
				} else {
					strT_set_varNow += "|" + arr_t_setNow[i];
				}
				
				// FileWatch 셋팅
				if ( arr_t_set_detailNow[0].indexOf("FileWatch-FILE_PATH") > -1 ) {
					strFile_pathNow = arr_t_set_detailNow[1];
				}
				if ( arr_t_set_detailNow[0].indexOf("FileWatch-INT_FILE_SEARCHES") > -1 ) {
					strMonitor_intervalNow = arr_t_set_detailNow[1];
				}
				if ( arr_t_set_detailNow[0].indexOf("FileWatch-TIME_LIMIT") > -1 ) {
					strMonitor_timeNow = arr_t_set_detailNow[1];
				}
				if ( arr_t_set_detailNow[0].indexOf("FileWatch-INT_FILESIZE_COMPARISON") > -1 ) {
					strFilesize_comparisonNow = arr_t_set_detailNow[1];
				}
				if ( arr_t_set_detailNow[0].indexOf("FileWatch-NUM_OF_ITERATIONS") > -1 ) {
					strNum_of_iterationsNow = arr_t_set_detailNow[1];
				}
				if ( arr_t_set_detailNow[0].indexOf("FileWatch-STOP_TIME") > -1 ) {
					strStop_timeNow = arr_t_set_detailNow[1];
				}
			}
		}
		
		if ( !strT_set_varNow.equals("") && strT_set_varNow.substring(0, 1).equals("|") ) strT_set_varNow = strT_set_varNow.substring(1, strT_set_varNow.length());
	}
	
	String strPrevTime 				= "";
	String strPrevLate 				= "";
	String strPrevFromTime 			= "";
	String strPrevToTime 			= "";
	String strPrevLateSub   		= ""; 
	String strPrevLateTime  		= "";
	String strPrevActiveFrom 		= "";
	String strPrevActiveTill 		= "";
	String strPrevActiveFromTill 	= "-";
	String strPrevT_general_date 	= "-";
	String strPrevMonth 			= "-";
	
	if(jobMapperDocPrevInfo != null ){
		strPrevFromTime 		= CommonUtil.isNull(jobMapperDocPrevInfo.getFrom_time());
		strPrevToTime 			= CommonUtil.isNull(jobMapperDocPrevInfo.getTo_time());  	
		strPrevLateSub 			= CommonUtil.isNull(jobMapperDocPrevInfo.getLate_sub()); 
		strPrevLateTime			= CommonUtil.isNull(jobMapperDocPrevInfo.getLate_time());
		strPrevActiveFrom		= CommonUtil.isNull(jobMapperDocPrevInfo.getActive_from());
		strPrevActiveTill		= CommonUtil.isNull(jobMapperDocPrevInfo.getActive_till());
		strPrevDaysCal			= CommonUtil.isNull(jobMapperDocPrevInfo.getDays_cal());
		strPrevWeeksCal			= CommonUtil.isNull(jobMapperDocPrevInfo.getWeeks_cal());
		strPrevConfCal			= CommonUtil.isNull(jobMapperDocPrevInfo.getConf_cal(), "-");
		strPrevShift	   		= CommonUtil.isNull(jobMapperDocPrevInfo.getShift(), "-");
		strPrevShiftNum			= CommonUtil.isNull(jobMapperDocPrevInfo.getShift_num(), "-");
		strPrevT_general_date 	= CommonUtil.isNull(jobMapperDocPrevInfo.getT_general_date(), "-");
		
		strPrevTime = strPrevFromTime+"~"+strPrevToTime;                   
	 	strPrevLate = strPrevLateSub+"~"+strPrevLateTime;              
		strPrevActiveFromTill = strPrevActiveFrom+"~"+strPrevActiveTill;      
		
		strPrevMonth1       = CommonUtil.isNull(jobMapperDocPrevInfo.getMonth_1());
		strPrevMonth1		= strPrevMonth1.equals("1") ? "1월" : "-";
		strPrevMonth2       = CommonUtil.isNull(jobMapperDocPrevInfo.getMonth_2());
		strPrevMonth2		= strPrevMonth2.equals("1") ? "2월" : "-";
		strPrevMonth3       = CommonUtil.isNull(jobMapperDocPrevInfo.getMonth_3());
		strPrevMonth3		= strPrevMonth3.equals("1") ? "3월" : "-";
		strPrevMonth4       = CommonUtil.isNull(jobMapperDocPrevInfo.getMonth_4());
		strPrevMonth4		= strPrevMonth4.equals("1") ? "4월" : "-";
		strPrevMonth5       = CommonUtil.isNull(jobMapperDocPrevInfo.getMonth_5());
		strPrevMonth5		= strPrevMonth5.equals("1") ? "5월" : "-";
		strPrevMonth6       = CommonUtil.isNull(jobMapperDocPrevInfo.getMonth_6());
		strPrevMonth6		= strPrevMonth6.equals("1") ? "6월" : "-";
		strPrevMonth7       = CommonUtil.isNull(jobMapperDocPrevInfo.getMonth_7());
		strPrevMonth7		= strPrevMonth7.equals("1") ? "7월" : "-";
		strPrevMonth8       = CommonUtil.isNull(jobMapperDocPrevInfo.getMonth_8());
		strPrevMonth8		= strPrevMonth8.equals("1") ? "8월" : "-";
		strPrevMonth9       = CommonUtil.isNull(jobMapperDocPrevInfo.getMonth_9());
		strPrevMonth9		= strPrevMonth9.equals("1") ? "9월" : "-";
		strPrevMonth10      = CommonUtil.isNull(jobMapperDocPrevInfo.getMonth_10());
		strPrevMonth10		= strPrevMonth10.equals("1") ? "10월" : "-";
		strPrevMonth11      = CommonUtil.isNull(jobMapperDocPrevInfo.getMonth_11());
		strPrevMonth11		= strPrevMonth11.equals("1") ? "11월" : "-";
		strPrevMonth12      = CommonUtil.isNull(jobMapperDocPrevInfo.getMonth_12());
		strPrevMonth12		= strPrevMonth12.equals("1") ? "12월" : "-";
		
		strPrevMonth		= strPrevMonth1 + ", " + strPrevMonth2 + ", " + strPrevMonth3 + ", " + strPrevMonth4 + ", " + strPrevMonth5 + ", " + strPrevMonth6
								+ ", " + strPrevMonth7 + ", " + strPrevMonth8 + ", " + strPrevMonth9 + ", " + strPrevMonth10 + ", " + strPrevMonth11 + ", " + strPrevMonth12;
		
		if(!strPrevT_general_date.equals("-")){
			String temp_general_date = "";
			for(int i=4; i<=strPrevT_general_date.length();i+=4){
				temp_general_date += strPrevT_general_date.substring(i-4,i);
				temp_general_date += ", ";
			}
			
			if(!temp_general_date.equals("")) strPrevT_general_date = temp_general_date.substring(0,temp_general_date.length()-2);
	 	}
	}
	
	String strNowTaskType 	= CommonUtil.isNull(jobMapperDocNowInfo.getTask_type());
	
	if(strNowTaskType.equals("job")){
		strNowTaskType = "script";
	}
	
	String strNowTime 		= "-";
	String strNowLate		= "-";
	
// 	String strNowCommand = CommonUtil.replaceStrHtml(jobMapperDocNowInfo.getCommand());
	
	String strNowFromTime 	= CommonUtil.isNull(jobMapperDocNowInfo.getFrom_time());
	String strNowToTime 	= CommonUtil.isNull(jobMapperDocNowInfo.getTo_time());
	
	String strNowLateSub 	= CommonUtil.isNull(jobMapperDocNowInfo.getLate_sub());
	String strNowLateTime 	= CommonUtil.isNull(jobMapperDocNowInfo.getLate_time());
	
	String strNowActiveFrom = CommonUtil.isNull(jobMapperDocNowInfo.getActive_from());
	String strNowActiveTill = CommonUtil.isNull(jobMapperDocNowInfo.getActive_till());

	String strNowActiveFromTill = "-";
	
	strNowActiveFromTill = strNowActiveFrom+"~"+strNowActiveTill;
	strNowTime = strNowFromTime+"~"+strNowToTime;
	strNowLate = strNowLateSub+"~"+strNowLateTime;
	
	String[] aTmpT 					 = null;
	String strNowTConditionIn       = "";
	String strNowTConditionOut       = "";

	if( null!=jobMapperDocNowInfo.getT_conditions_in() && jobMapperDocNowInfo.getT_conditions_in().trim().length()>0 ){
		aTmpT = CommonUtil.E2K(jobMapperDocNowInfo.getT_conditions_in()).split("[|]");
		for(int t=0; null!=aTmpT&&t<aTmpT.length; t++ ){
			String[] aTmpT1 = aTmpT[t].split(",",3);
			strNowTConditionIn += aTmpT1[0]+"</br>";
		}
	}
	
	if( null!=jobMapperDocNowInfo.getT_conditions_out() && jobMapperDocNowInfo.getT_conditions_out().trim().length()>0 ){				
		aTmpT = CommonUtil.E2K(jobMapperDocNowInfo.getT_conditions_out()).split("[|]");
		for(int t=0; null!=aTmpT&&t<aTmpT.length; t++ ){
			String[] aTmpT1 = aTmpT[t].split(",",3);
			strNowTConditionOut += aTmpT1[0]+"</br>";
		}
	}
	
	String strPrevUserNm1 		     = "";
	String strPrevUserNm2 		     = "";
	String strPrevUserNm3 		     = "";
	String strPrevUserNm4 		     = "";
	String strPrevUserNm5 		     = "";
	String strPrevUserNm6 		     = "";
	String strPrevUserNm7 		     = "";
	String strPrevUserNm8 		     = "";
	String strPrevUserNm9 		     = "";
	String strPrevUserNm10 		     = "";
	String strPrevGrpNm1 		     = "";
	String strPrevGrpNm2 		     = "";
	                                 
	String strPrevJobName		     = "";
	String strPrevDescription        = "";
	String strPrevDataCenterName     = "";
	String strPrevTableName			 = "";
	String strPrevApplication		 = "";
	String strPrevGroupName			 = "";
	String strPrevTaskType			 = "";
	String strPrevNodeId			 = "";
	String strPrevOwner				 = "";
	String strPrevMemName  			 = "";
	String strPrevMemLib			 = "";
	String strPrevCmdLine			 = "";
	String strPrevDraftDate			 = "";
	String strPrevLateExec			 = "";
	String strPrevTConditionIn		 = "";
	String strPrevTConditionOut		 = "";
	String strPrevCyclic     		 = "";
	String strPrevRerunMax     		 = "";
	String strPrevConfirmFlag  		 = "";
	String strPrevPriority  		 = "";
	String strPrevSuccessSmsYn  	 = "";
	String strPrevCritical		  	 = "";

	String strPrevCcCount	  		 = "";
	String strPrevT_steps			 = "";
	String strPrevT_resources_q		 = ""; 
	
	if(jobMapperDocPrevInfo != null){
		strPrevUserNm1 		         =  CommonUtil.isNull(jobMapperDocPrevInfo.getUser_nm_1());
		strPrevUserNm2 		         =  CommonUtil.isNull(jobMapperDocPrevInfo.getUser_nm_2());
		strPrevUserNm3 		         =  CommonUtil.isNull(jobMapperDocPrevInfo.getUser_nm_3());
		strPrevUserNm4 		         =	CommonUtil.isNull(jobMapperDocPrevInfo.getUser_nm_4());
		strPrevUserNm5 		         =	CommonUtil.isNull(jobMapperDocPrevInfo.getUser_nm_5());
		strPrevUserNm6 		         =	CommonUtil.isNull(jobMapperDocPrevInfo.getUser_nm_6());
		strPrevUserNm7 		         =	CommonUtil.isNull(jobMapperDocPrevInfo.getUser_nm_7());
		strPrevUserNm8 		         =	CommonUtil.isNull(jobMapperDocPrevInfo.getUser_nm_8());
		strPrevUserNm9 		         =	CommonUtil.isNull(jobMapperDocPrevInfo.getUser_nm_9());
		strPrevUserNm10		         =	CommonUtil.isNull(jobMapperDocPrevInfo.getUser_nm_10());
		strPrevGrpNm1 		         =	CommonUtil.isNull(jobMapperDocPrevInfo.getGrp_nm_1());
		strPrevGrpNm2 		         =	CommonUtil.isNull(jobMapperDocPrevInfo.getGrp_nm_2());
		                             
		strPrevJobName		         =	CommonUtil.isNull(jobMapperDocPrevInfo.getJob_name());
		strPrevDescription           =	CommonUtil.isNull(jobMapperDocPrevInfo.getDescription());
		strPrevDataCenterName        =	CommonUtil.isNull(jobMapperDocPrevInfo.getData_center_name());
		strPrevTableName	         =	CommonUtil.isNull(jobMapperDocPrevInfo.getTable_name());
		strPrevApplication	         =	CommonUtil.isNull(jobMapperDocPrevInfo.getApplication());
		strPrevGroupName		     =	CommonUtil.isNull(jobMapperDocPrevInfo.getGroup_name());
		strPrevTaskType		         =	CommonUtil.isNull(jobMapperDocPrevInfo.getTask_type());
		strPrevNodeId		         =	CommonUtil.isNull(jobMapperDocPrevInfo.getNode_id());
		strPrevOwner			     =	CommonUtil.isNull(jobMapperDocPrevInfo.getOwner());
		strPrevMemName  		     =	CommonUtil.isNull(jobMapperDocPrevInfo.getMem_name());
		strPrevMemLib		         =	CommonUtil.isNull(jobMapperDocPrevInfo.getMem_lib());
		strPrevCmdLine		         =	CommonUtil.isNull(jobMapperDocPrevInfo.getCommand());
		strPrevDraftDate		     =	CommonUtil.isNull(jobMapperDocPrevInfo.getDraft_date());
		strPrevLateExec		         =	CommonUtil.isNull(jobMapperDocPrevInfo.getLate_exec());
		
		if(strPrevTaskType.equals("job")){
			strPrevTaskType = "script";
		
		}
		if( null!=jobMapperDocPrevInfo.getT_conditions_in() && jobMapperDocPrevInfo.getT_conditions_in().trim().length()>0 ){
			aTmpT = CommonUtil.E2K(jobMapperDocPrevInfo.getT_conditions_in()).split("[|]");
			for(int t=0; null!=aTmpT&&t<aTmpT.length; t++ ){
				String[] aTmpT1 = aTmpT[t].split(",",3);
				strPrevTConditionIn += aTmpT1[0]+"</br>";
			}
		}
		
		if( null!=jobMapperDocPrevInfo.getT_conditions_out() && jobMapperDocPrevInfo.getT_conditions_out().trim().length()>0 ){				
			aTmpT = CommonUtil.E2K(jobMapperDocPrevInfo.getT_conditions_out()).split("[|]");
			for(int t=0; null!=aTmpT&&t<aTmpT.length; t++ ){
				String[] aTmpT1 = aTmpT[t].split(",",3);
				strPrevTConditionOut += aTmpT1[0]+"</br>";
			}
		}

		strPrevCyclic     	= CommonUtil.isNull(jobMapperDocPrevInfo.getCyclic(), "-");
		strPrevRerunMax		= CommonUtil.isNull(jobMapperDocPrevInfo.getRerun_max(), "-");
		strPrevConfirmFlag	= CommonUtil.isNull(jobMapperDocPrevInfo.getConfirm_flag(), "-");
		strPrevSuccessSmsYn     = CommonUtil.isNull(jobMapperDocPrevInfo.getSuccess_sms_yn(), "-");
		strPrevCritical			= CommonUtil.isNull(jobMapperDocPrevInfo.getCritical(), "-");
		strPrevT_steps			= CommonUtil.isNull(jobMapperDocPrevInfo.getT_steps(), "-");
		if(strPrevT_steps.contains("SPCYC")) {
			strPrevT_steps = strPrevT_steps.replace("SPCYC", "Stop Cyclic");
		}
		strPrevT_resources_q	= CommonUtil.isNull(jobMapperDocPrevInfo.getT_resources_q(), "-");
		
	}
	
	String strNowMonth				 = ""; 
	
	if(jobMapperDocNowInfo != null){
		strNowMonth1       	= CommonUtil.isNull(jobMapperDocNowInfo.getMonth_1());
		strNowMonth1		= strNowMonth1.equals("1") ? "1월" : "-";
		strNowMonth2      	= CommonUtil.isNull(jobMapperDocNowInfo.getMonth_2());
		strNowMonth2		= strNowMonth2.equals("1") ? "2월" : "-";
		strNowMonth3       	= CommonUtil.isNull(jobMapperDocNowInfo.getMonth_3());
		strNowMonth3		= strNowMonth3.equals("1") ? "3월" : "-";
		strNowMonth4        = CommonUtil.isNull(jobMapperDocNowInfo.getMonth_4());
		strNowMonth4  		= strNowMonth4.equals("1") ? "4월" : "-";
		strNowMonth5        = CommonUtil.isNull(jobMapperDocNowInfo.getMonth_5());
		strNowMonth5  		= strNowMonth5.equals("1") ? "5월" : "-";
		strNowMonth6        = CommonUtil.isNull(jobMapperDocNowInfo.getMonth_6());
		strNowMonth6  		= strNowMonth6.equals("1") ? "6월" : "-";
		strNowMonth7        = CommonUtil.isNull(jobMapperDocNowInfo.getMonth_7());
		strNowMonth7  		= strNowMonth7.equals("1") ? "7월" : "-";
		strNowMonth8        = CommonUtil.isNull(jobMapperDocNowInfo.getMonth_8());
		strNowMonth8 		= strNowMonth8.equals("1") ? "8월" : "-";
		strNowMonth9        = CommonUtil.isNull(jobMapperDocNowInfo.getMonth_9());
		strNowMonth9 		= strNowMonth9.equals("1") ? "9월" : "-";
		strNowMonth10      	= CommonUtil.isNull(jobMapperDocNowInfo.getMonth_10());
		strNowMonth10		= strNowMonth10.equals("1") ? "10월" : "-";
		strNowMonth11      	= CommonUtil.isNull(jobMapperDocNowInfo.getMonth_11());
		strNowMonth11		= strNowMonth11.equals("1") ? "11월" : "-";
		strNowMonth12      	= CommonUtil.isNull(jobMapperDocNowInfo.getMonth_12());
		strNowMonth12		= strNowMonth12.equals("1") ? "12월" : "-";
		
		strNowMonth		= strNowMonth1 + ", " + strNowMonth2 + ", " + strNowMonth3 + ", " + strNowMonth4 + ", " + strNowMonth5 + ", " + strNowMonth6
								+ ", " + strNowMonth7 + ", " + strNowMonth8 + ", " + strNowMonth9 + ", " + strNowMonth10 + ", " + strNowMonth11 + ", " + strNowMonth12;
	}
%>



<body id='body_A01' leftmargin="0" topmargin="0">

<div style="width:100%; height:100%; overflow-x:hidden; overflow-y:scroll;">
	<tr style='height:10px;'>
		<td style='vertical-align:top;'>
			<h4 class="ui-widget-header ui-corner-all"  >
				<div class='title_area'>
					<span>작업정보 비교</span>
				</div>
			</h4>
		</td>
	</tr>
	<div class='cellTitle_kang5' >담당자 정보</div>
	<table style='width:100%;'>
		<colgroup>
			<col width="20%" />
			<col width="40%" />
			<col width="40%" />
		</colgroup>	
		<thead>
			<tr bgcolor="#f1f1f1">
				<th class='cellTitle_ez_center'  style="fond-size=:15px;">항목</th>
				<th class='cellTitle_ez_center' >작업정보</th>
				<th class='cellTitle_ez_center' >이전 작업정보 <%=jobMapperDocPrevInfo == null ? "<데이터 없음>":"" %></th>
			</tr>
		</thead>
		<tbody>
			<tr align="center" class="dataTr">
				<th class='cellTitle_ez_center' >담당자1</th>
				<td class="cellContent_lee"><%=CommonUtil.isNull(jobMapperDocNowInfo.getUser_nm_1(), "-") %></td>
				<td class="cellContent_lee"><%=CommonUtil.isNull(strPrevUserNm1, "-") %></td>
			</tr>
			<tr align="center" class="dataTr">
				<th class='cellTitle_ez_center' >담당자2</th>
				<td class="cellContent_lee"><%=CommonUtil.isNull(jobMapperDocNowInfo.getUser_nm_2(), "-") %></td>
				<td class="cellContent_lee"><%=CommonUtil.isNull(strPrevUserNm2, "-") %></td>
			</tr>
			<tr align="center" class="dataTr">
				<th class='cellTitle_ez_center' >담당자3</th>
				<td class="cellContent_lee"><%=CommonUtil.isNull(jobMapperDocNowInfo.getUser_nm_3(), "-") %></td>
				<td class="cellContent_lee"><%=CommonUtil.isNull(strPrevUserNm3, "-") %></td>
			</tr>
			<tr align="center" class="dataTr">
				<th class='cellTitle_ez_center' >담당자4</th>
				<td class="cellContent_lee"><%=CommonUtil.isNull(jobMapperDocNowInfo.getUser_nm_4(), "-") %></td>
				<td class="cellContent_lee"><%=CommonUtil.isNull(strPrevUserNm4, "-") %></td>
			</tr>
			<tr align="center" class="dataTr">
				<th class='cellTitle_ez_center' >담당자5</th>
				<td class="cellContent_lee"><%=CommonUtil.isNull(jobMapperDocNowInfo.getUser_nm_5(), "-") %></td>
				<td class="cellContent_lee"><%=CommonUtil.isNull(strPrevUserNm5, "-") %></td>
			</tr>
			<tr align="center" class="dataTr">
				<th class='cellTitle_ez_center' >담당자6</th>
				<td class="cellContent_lee"><%=CommonUtil.isNull(jobMapperDocNowInfo.getUser_nm_6(), "-") %></td>
				<td class="cellContent_lee"><%=CommonUtil.isNull(strPrevUserNm6, "-") %></td>
			</tr>
			<tr align="center" class="dataTr">
			<th class='cellTitle_ez_center' >담당자7</th>
				<td class="cellContent_lee"><%=CommonUtil.isNull(jobMapperDocNowInfo.getUser_nm_7(), "-") %></td>
				<td class="cellContent_lee"><%=CommonUtil.isNull(strPrevUserNm7, "-") %></td>
			</tr>
			<tr align="center" class="dataTr">
			<th class='cellTitle_ez_center' >담당자8</th>
				<td class="cellContent_lee"><%=CommonUtil.isNull(jobMapperDocNowInfo.getUser_nm_8(), "-") %></td>
				<td class="cellContent_lee"><%=CommonUtil.isNull(strPrevUserNm8, "-") %></td>
			</tr>
		<tr align="center" class="dataTr">
			<th class='cellTitle_ez_center' >담당자9</th>
			<td class="cellContent_lee"><%=CommonUtil.isNull(jobMapperDocNowInfo.getUser_nm_9(), "-") %></td>
			<td class="cellContent_lee"><%=CommonUtil.isNull(strPrevUserNm9, "-") %></td>
		</tr>
		<tr align="center" class="dataTr">
			<th class='cellTitle_ez_center' >담당자10</th>
			<td class="cellContent_lee"><%=CommonUtil.isNull(jobMapperDocNowInfo.getUser_nm_10(), "-") %></td>
			<td class="cellContent_lee"><%=CommonUtil.isNull(strPrevUserNm10, "-") %></td>
		</tr>
		<tr align="center" class="dataTr">
			<th class='cellTitle_ez_center' >그룹1</th>
			<td class="cellContent_lee"><%=CommonUtil.isNull(jobMapperDocNowInfo.getGrp_nm_1(), "-") %></td>
			<td class="cellContent_lee"><%=CommonUtil.isNull(strPrevGrpNm1, "-") %></td>
		</tr>
		<tr align="center" class="dataTr">
			<th class='cellTitle_ez_center' >그룹2</th>
			<td class="cellContent_lee"><%=CommonUtil.isNull(jobMapperDocNowInfo.getGrp_nm_2(), "-") %></td>
			<td class="cellContent_lee"><%=CommonUtil.isNull(strPrevGrpNm2, "-") %></td>
		</tr>
		</tbody>
	</table>
	<div class='cellTitle_kang5' >작업 정보</div>
	<table style='width:100%;table-layout:fixed; word-break:break-all;'>
		<colgroup>
			<col width="20%" />
			<col width="40%" />
			<col width="40%" />
		</colgroup>	
		<thead>
			<tr bgcolor="#f1f1f1">
				<th class='cellTitle_ez_center'  style="fond-size=:15px;">항목</th>
				<th class='cellTitle_ez_center' >작업정보</th>
				<th class='cellTitle_ez_center' >이전 작업정보</th>
			</tr>
		</thead>
		<tbody>
			<tr align="center" class="dataTr">
				<th class='cellTitle_ez_center' >C-M</th>
				<td class="cellContent_lee"><%=CommonUtil.isNull(jobMapperDocNowInfo.getData_center_name(), "-") %></td>
				<td class="cellContent_lee"><%=CommonUtil.isNull(strPrevDataCenterName, "-") %></td>
			</tr>
			<tr align="center" class="dataTr">
				<th class='cellTitle_ez_center' >작업타입</th>
				<td class="cellContent_lee"><%=CommonUtil.isNull(strNowTaskType, "-") %></td>
				<td class="cellContent_lee"><%=CommonUtil.isNull(strPrevTaskType, "-") %></td>
			</tr>
			<tr align="center" class="dataTr">
				<th class='cellTitle_ez_center' >폴더</th>
				<td class="cellContent_lee"><%=CommonUtil.isNull(jobMapperDocNowInfo.getTable_name(), "-") %></td>
				<td class="cellContent_lee"><%=CommonUtil.isNull(strPrevTableName, "-") %></td>
			</tr>
			<tr align="center" class="dataTr">
				<th class='cellTitle_ez_center' >어플리케이션</th>
				<td class="cellContent_lee"><%=CommonUtil.isNull(jobMapperDocNowInfo.getApplication(), "-") %></td>
				<td class="cellContent_lee"><%=CommonUtil.isNull(strPrevApplication, "-") %></td>
			</tr>
			<tr align="center" class="dataTr">
				<th class='cellTitle_ez_center' >그룹</th>
				<td class="cellContent_lee"><%=CommonUtil.isNull(jobMapperDocNowInfo.getGroup_name(), "-") %></td>
				<td class="cellContent_lee"><%=CommonUtil.isNull(strPrevGroupName, "-") %></td>
			</tr>
			<tr align="center" class="dataTr">
				<th class='cellTitle_ez_center' >수행서버</th>
				<td class="cellContent_lee"><%=CommonUtil.isNull(jobMapperDocNowInfo.getNode_id(), "-") %></td>
				<td class="cellContent_lee"><%=CommonUtil.isNull(strPrevNodeId, "-") %></td>
			</tr>
			<tr align="center" class="dataTr">
				<th class='cellTitle_ez_center' >계정명</th>
				<td class="cellContent_lee"><%=CommonUtil.isNull(jobMapperDocNowInfo.getOwner(), "-") %></td>
				<td class="cellContent_lee"><%=CommonUtil.isNull(strPrevOwner, "-") %></td>
			</tr>
			<tr align="center" class="dataTr">
				<th class='cellTitle_ez_center' >작업명</th>
				<td class="cellContent_lee"><%=CommonUtil.isNull(jobMapperDocNowInfo.getJob_name(), "-") %></td>
				<td class="cellContent_lee"><%=CommonUtil.isNull(strPrevJobName, "-") %></td>
			</tr>
			<tr align="center" class="dataTr">
				<th class='cellTitle_ez_center' >작업설명</th>
				<td class="cellContent_lee"><%=CommonUtil.isNull(jobMapperDocNowInfo.getDescription(), "-") %></td>
				<td class="cellContent_lee"><%=CommonUtil.isNull(strPrevDescription, "-") %></td>
			</tr>
			<tr align="center" class="dataTr">
				<th class='cellTitle_ez_center' >프로그램명</th>
				<td class="cellContent_lee"><%=CommonUtil.isNull(jobMapperDocNowInfo.getMem_name(), "-") %></td>
				<td class="cellContent_lee"><%=CommonUtil.isNull(strPrevMemName, "-") %></td>
			</tr>
			<tr align="center" class="dataTr">
				<th class='cellTitle_ez_center' >프로그램위치</th>
				<td class="cellContent_lee"><%=CommonUtil.isNull(jobMapperDocNowInfo.getMem_lib(), "-") %></td>
				<td class="cellContent_lee"><%=CommonUtil.isNull(strPrevMemLib, "-") %></td>
			</tr>
			<tr align="center" class="dataTr">
				<th class='cellTitle_ez_center' >작업수행명령</th>
				<td class="cellContent_lee"><%=CommonUtil.isNull(jobMapperDocNowInfo.getCommand(), "-") %></td>
				<td class="cellContent_lee"><%=CommonUtil.isNull(strPrevCmdLine, "-") %></td>
			</tr>
			<tr align="center" class="dataTr">
				<th class='cellTitle_ez_center' >시작시간~종료시간</th>
				<td class="cellContent_lee"><%=CommonUtil.isNull(strNowTime, "-") %></td>
				<td class="cellContent_lee"><%=CommonUtil.isNull(strPrevTime, "-") %></td>
			</tr>
			<tr align="center" class="dataTr">
				<th class='cellTitle_ez_center' >임계시간</th>
				<td class="cellContent_lee"><%=CommonUtil.isNull(strNowLate, "-") %></td>
				<td class="cellContent_lee"><%=CommonUtil.isNull(strPrevLate, "-") %></td>
			</tr>
			<tr align="center" class="dataTr">
				<th class='cellTitle_ez_center' >수행임계시간(분)</th>
				<td class="cellContent_lee"><%=CommonUtil.isNull(jobMapperDocNowInfo.getLate_exec(), "-") %></td>
				<td class="cellContent_lee"><%=CommonUtil.isNull(strPrevLateExec, "-") %></td>
			</tr>
			<tr align="center" class="dataTr">
				<th class='cellTitle_ez_center' >반복작업</th>
				<td class="cellContent_lee"><%=CommonUtil.isNull(jobMapperDocNowInfo.getCyclic(), "-").equals("0") ? "N" : "Y" %></td>
				<td class="cellContent_lee"><%=strPrevCyclic.equals("0") ? "N" : (strPrevCyclic.equals("1") ? "Y" : "-") %></td>
			</tr>
			<tr align="center" class="dataTr">
				<th class='cellTitle_ez_center' >최대 반복 횟수</th>
				<td class="cellContent_lee"><%=CommonUtil.isNull(jobMapperDocNowInfo.getRerun_max(), "-") %></td>
				<td class="cellContent_lee"><%=strPrevRerunMax %></td>
			</tr>
			<tr align="center" class="dataTr">
				<th class='cellTitle_ez_center' >Confirm Flag</th>
				<td class="cellContent_lee"><%=CommonUtil.isNull(jobMapperDocNowInfo.getConfirm_flag(), "-").equals("0") ? "N" : "Y" %></td>
				<td class="cellContent_lee"><%=strPrevConfirmFlag.equals("0") ? "N" : (strPrevConfirmFlag.equals("1") ? "Y" : "-") %></td>
			</tr>
			<tr align="center" class="dataTr">
				<th class='cellTitle_ez_center' >성공 시 알람 발송</th>
				<td class="cellContent_lee"><%=CommonUtil.isNull(jobMapperDocNowInfo.getSuccess_sms_yn(), "N") %></td>
				<td class="cellContent_lee"><%=strPrevSuccessSmsYn%></td>
<%-- 				<td class="cellContent_lee"><%=strPrevSuccessSmsYn.equals("0") ? "N" : (strPrevSuccessSmsYn.equals("1") ? "Y" : "N") %></td> --%>
			</tr>
			<tr align="center" class="dataTr">
				<th class='cellTitle_ez_center' >중요작업</th>
				<td class="cellContent_lee"><%=CommonUtil.isNull(jobMapperDocNowInfo.getCritical(), "-").equals("0") ? "N" : "Y" %></td>
				<td class="cellContent_lee"><%=strPrevCritical.equals("0") ? "N" : (strPrevCritical.equals("1") ? "Y" : "-") %></td>
			</tr>
		</tbody>
	</table>
	<div class='cellTitle_kang5' >작업 스케쥴</div>
	<table style='width:100%;'>
		<colgroup>
			<col width="20%" />
			<col width="40%" />
			<col width="40%" />
		</colgroup>	
		<thead>
			<tr bgcolor="#f1f1f1">
				<th class='cellTitle_ez_center'  style="fond-size=:15px;">항목</th>
				<th class='cellTitle_ez_center' >작업정보</th>
				<th class='cellTitle_ez_center' >이전 작업정보</th>
			</tr>
		</thead>
		<tbody>
			<tr align="center" class="dataTr">
				<th class='cellTitle_ez_center' >월 캘린더</th>
				<td class="cellContent_lee"><%=CommonUtil.isNull(jobMapperDocNowInfo.getDays_cal(), "-") %></td>
				<td class="cellContent_lee"><%=CommonUtil.isNull(strPrevDaysCal, "-") %></td>
			</tr>
			<tr align="center" class="dataTr">
				<th class='cellTitle_ez_center' >일 캘린더</th>
				<td class="cellContent_lee"><%=CommonUtil.isNull(jobMapperDocNowInfo.getWeeks_cal(), "-") %></td>
				<td class="cellContent_lee"><%=CommonUtil.isNull(strPrevWeeksCal, "-") %></td>
			</tr>
			<tr align="center" class="dataTr">
				<th class='cellTitle_ez_center' >1월 ~ 12월</th>
				<td class="cellContent_lee"><%=CommonUtil.isNull(strNowMonth, "-") %></td>
				<td class="cellContent_lee"><%=CommonUtil.isNull(strPrevMonth, "-") %></td>
			</tr>
			<tr align="center" class="dataTr">
				<th class='cellTitle_ez_center' >CONF_CAL</th>
				<td class="cellContent_lee"><%=CommonUtil.isNull(jobMapperDocNowInfo.getConf_cal(), "-") %></td>
				<td class="cellContent_lee"><%=CommonUtil.isNull(strPrevConfCal, "-") %></td>
			</tr>
			<tr align="center" class="dataTr">
				<th class='cellTitle_ez_center' >POLICY</th>
				<td class="cellContent_lee"><%=CommonUtil.isNull(jobMapperDocNowInfo.getShift(), "-") %></td>
				<td class="cellContent_lee"><%=CommonUtil.isNull(strPrevShift, "-") %></td>
			</tr>
			<tr align="center" class="dataTr">
				<th class='cellTitle_ez_center' >SHIFT</th>
				<td class="cellContent_lee"><%=CommonUtil.isNull(jobMapperDocNowInfo.getShift_num(), "-") %></td>
				<td class="cellContent_lee"><%=CommonUtil.isNull(strPrevShiftNum, "-") %></td>
			</tr>
			<tr align="center" class="dataTr">
				<th class='cellTitle_ez_center' >수행범위일</th>
				<td class="cellContent_lee"><%=CommonUtil.isNull(strNowActiveFromTill, "-") %></td>
				<td class="cellContent_lee"><%=CommonUtil.isNull(strPrevActiveFromTill, "-") %></td>
			</tr>
			<tr align="center" class="dataTr">
				<th class='cellTitle_ez_center' >특정실행날짜</th>
				<td class="cellContent_lee"><%=CommonUtil.isNull(jobMapperDocNowInfo.getT_general_date(), "-") %></td>
				<td class="cellContent_lee"><%=CommonUtil.isNull(strPrevT_general_date, "-") %></td>
			</tr>
		</tbody>
	</table>
	<div class='cellTitle_kang5' >선행작업조건</div>
	<table style='width:100%;'>
		<colgroup>
			<col width="20%" />
			<col width="40%" />
			<col width="40%" />
		</colgroup>	
		<thead>
			<tr bgcolor="#f1f1f1">
				<th class='cellTitle_ez_center'  style="fond-size=:15px;">항목</th>
				<th class='cellTitle_ez_center' >작업정보</th>
				<th class='cellTitle_ez_center' >이전 작업정보</th>
			</tr>
		</thead>
		<tbody>
			<tr align="center" class="dataTr">
				<th class='cellTitle_ez_center' >선행작업조건</th>
				<td class="cellContent_lee"><%=CommonUtil.isNull(strNowTConditionIn, "-") %></td>
				<td class="cellContent_lee"><%=CommonUtil.isNull(strPrevTConditionIn, "-") %></td>
			</tr>
			
		</tbody>	
	</table>
	<div class='cellTitle_kang5' >후행작업조건</div>
	<table style='width:100%;'>
		<colgroup>
			<col width="20%" />
			<col width="40%" />
			<col width="40%" />
		</colgroup>	
		<thead>
			<tr bgcolor="#f1f1f1">
				<th class='cellTitle_ez_center'  style="fond-size=:15px;">항목</th>
				<th class='cellTitle_ez_center' >작업정보</th>
				<th class='cellTitle_ez_center' >이전 작업정보</th>
			</tr>
		</thead>
		<tbody>
			<tr align="center" class="dataTr">
				<th class='cellTitle_ez_center' >후행작업조건</th>
				<td class="cellContent_lee"><%=CommonUtil.isNull(strNowTConditionOut, "-") %></td>
				<td class="cellContent_lee"><%=CommonUtil.isNull(strPrevTConditionOut, "-") %></td>
			</tr>
			
		</tbody>	
	</table>
	<div class='cellTitle_kang5' >RESOURCE</div>
	<table style='width:100%;'>
		<colgroup>
			<col width="20%" />
			<col width="40%" />
			<col width="40%" />
		</colgroup>	
		<thead>
			<tr bgcolor="#f1f1f1">
				<th class='cellTitle_ez_center'  style="fond-size=:15px;">항목</th>
				<th class='cellTitle_ez_center' >작업정보</th>
				<th class='cellTitle_ez_center' >이전 작업정보</th>
			</tr>
		</thead>
		<tbody>
			<tr align="center" class="dataTr">
				<th class='cellTitle_ez_center' >RESOURCE</th>
				<td class="cellContent_lee"><%=CommonUtil.isNull(jobMapperDocNowInfo.getT_resources_q(), "-") %></td>
				<td class="cellContent_lee"><%=CommonUtil.isNull(strPrevT_resources_q, "-") %></td>
			</tr>
			
		</tbody>	
	</table>
	<div class='cellTitle_kang5' >변수</div>
	<table style='width:100%;'>
		<colgroup>
			<col width="20%" />
			<col width="40%" />
			<col width="40%" />
		</colgroup>	
		<thead>
			<tr bgcolor="#f1f1f1">
				<th class='cellTitle_ez_center'  style="fond-size=:15px;">항목</th>
				<th class='cellTitle_ez_center' >작업정보</th>
				<th class='cellTitle_ez_center' >이전 작업정보</th>
			</tr>
		</thead>
		<tbody>
			<tr align="center" class="dataTr">
				<th class='cellTitle_ez_center' >변수</th>
				<td class="cellContent_lee" style="word-break:break-all;"><%=CommonUtil.isNull(strT_setNow, "-") %></td>
				<td class="cellContent_lee" style="word-break:break-all;"><%=CommonUtil.isNull(strT_setPrev, "-") %></td>
			</tr>
			
		</tbody>	
	</table>
	<div class='cellTitle_kang5' >ON/DO</div>
	<table style='width:100%;'>
		<colgroup>
			<col width="20%" />
			<col width="40%" />
			<col width="40%" />
		</colgroup>	
		<thead>
			<tr bgcolor="#f1f1f1">
				<th class='cellTitle_ez_center'  style="fond-size=:15px;">항목</th>
				<th class='cellTitle_ez_center' >작업정보</th>
				<th class='cellTitle_ez_center' >이전 작업정보</th>
			</tr>
		</thead>
		<tbody>
			<tr align="center" class="dataTr">
				<th class='cellTitle_ez_center' >ON/DO</th>
				<td class="cellContent_lee"><%=CommonUtil.isNull(jobMapperDocNowInfo.getT_steps(), "-") %></td>
				<td class="cellContent_lee"><%=(strPrevT_steps.equals("") ? "-" : strPrevT_steps) %></td>
			</tr>
			
		</tbody>	
	</table>
</div>

<script type="text/javascript">
$(document).ready(function(){
	$('.dataTr').each(function(i){
		var strNowData = $(this).children('td').eq(0).text();
		var strPrevData = $(this).children('td').eq(1).text();
		if(strNowData != strPrevData){
			$(this).children('td').eq(0).css("color","red");
			$(this).children('td').eq(1).css("color","red");
			$(this).children('th').css('color', 'red');
		}
	});
	
	$('.calTr1, .calTr2').each(function(i){
		var strNowCal1 = $('.calTr1').children('td').eq(0).text();
		var strNowCal2 = $('.calTr1').children('td').eq(1).text();
		var strNowCal3 = $('.calTr1').children('td').eq(2).text();
		var strNowCal4 = $('.calTr1').children('td').eq(3).text();
		var strNowCal5 = $('.calTr1').children('td').eq(4).text();
		var strNowCal6 = $('.calTr1').children('td').eq(5).text();
		var strNowCal7 = $('.calTr1').children('td').eq(6).text();
		var strNowCal8 = $('.calTr1').children('td').eq(7).text();
		var strNowCal9 = $('.calTr1').children('td').eq(8).text();
		var strNowCal10 = $('.calTr1').children('td').eq(9).text();
		var strNowCal11 = $('.calTr1').children('td').eq(10).text();
		var strNowCal12 = $('.calTr1').children('td').eq(11).text();
		
		var strPrevCal1 = $('.calTr2').children('td').eq(0).text();
		var strPrevCal2 = $('.calTr2').children('td').eq(1).text();
		var strPrevCal3 = $('.calTr2').children('td').eq(2).text();
		var strPrevCal4 = $('.calTr2').children('td').eq(3).text();
		var strPrevCal5 = $('.calTr2').children('td').eq(4).text();
		var strPrevCal6 = $('.calTr2').children('td').eq(5).text();
		var strPrevCal7 = $('.calTr2').children('td').eq(6).text();
		var strPrevCal8 = $('.calTr2').children('td').eq(7).text();
		var strPrevCal9 = $('.calTr2').children('td').eq(8).text();
		var strPrevCal10 = $('.calTr2').children('td').eq(9).text();
		var strPrevCal11 = $('.calTr2').children('td').eq(10).text();
		var strPrevCal12 = $('.calTr2').children('td').eq(11).text();

		if(strNowCal1 != strPrevCal1){
			$('.calTr2').children('td').eq(0).css("color","red");
		}
		if(strNowCal2 != strPrevCal2){
			$('.calTr2').children('td').eq(1).css("color","red");
		}
		if(strNowCal3 != strPrevCal3){
			$('.calTr2').children('td').eq(2).css("color","red");
		}
		if(strNowCal4 != strPrevCal4){
			$('.calTr2').children('td').eq(3).css("color","red");
		}
		if(strNowCal5 != strPrevCal5){
			$('.calTr2').children('td').eq(4).css("color","red");
		}
		if(strNowCal6 != strPrevCal6){
			$('.calTr2').children('td').eq(5).css("color","red");
		}
		if(strNowCal7 != strPrevCal7){
			$('.calTr2').children('td').eq(6).css("color","red");
		}
		if(strNowCal8 != strPrevCal8){
			$('.calTr2').children('td').eq(7).css("color","red");
		}
		if(strNowCal9 != strPrevCal9){
			$('.calTr2').children('td').eq(8).css("color","red");
		}
		if(strNowCal10 != strPrevCal10){
			$('.calTr2').children('td').eq(9).css("color","red");
		}
		if(strNowCal11 != strPrevCal11){
			$('.calTr2').children('td').eq(10).css("color","red");
		}
		if(strNowCal12 != strPrevCal12){
			$('.calTr2').children('td').eq(11).css("color","red");
		}
	});
	
	
	
});
	
	
</script>

</body>
</html>