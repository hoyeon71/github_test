<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="com.ghayoun.ezjobs.m.domain.*" %>

<%@include file="/jsp/common/inc/header.jsp"%>
<%@include file="/jsp/common/inc/sessionChkPopup.jsp"%>

<%
	Map<String, Object> paramMap = CommonUtil.collectParameters(request);
	
	String forecast			= CommonUtil.isNull(request.getAttribute("forecast"));
	List calYearList		= (List)request.getAttribute("calYearList");
	
	System.out.println("paramMap : " + paramMap);
	
	String data_center		= CommonUtil.isNull(paramMap.get("data_center"));
	String v_sched_table		= CommonUtil.isNull(paramMap.get("v_sched_table"));
	String job_name			= CommonUtil.isNull(paramMap.get("job_name"));
	String month_days		= CommonUtil.isNull(paramMap.get("month_days"));
	String days_cal			= CommonUtil.isNull(paramMap.get("days_cal"));
	String week_days		= CommonUtil.isNull(paramMap.get("week_days"));
	String weeks_cal		= CommonUtil.isNull(paramMap.get("weeks_cal"));
	String month_1			= CommonUtil.isNull(paramMap.get("month_1"));
	String month_2			= CommonUtil.isNull(paramMap.get("month_2"));
	String month_3			= CommonUtil.isNull(paramMap.get("month_3"));
	String month_4			= CommonUtil.isNull(paramMap.get("month_4"));
	String month_5			= CommonUtil.isNull(paramMap.get("month_5"));
	String month_6			= CommonUtil.isNull(paramMap.get("month_6"));
	String month_7			= CommonUtil.isNull(paramMap.get("month_7"));
	String month_8			= CommonUtil.isNull(paramMap.get("month_8"));
	String month_9			= CommonUtil.isNull(paramMap.get("month_9"));
	String month_10			= CommonUtil.isNull(paramMap.get("month_10"));
	String month_11			= CommonUtil.isNull(paramMap.get("month_11"));
	String month_12			= CommonUtil.isNull(paramMap.get("month_12"));
	String schedule_and_or	= CommonUtil.isNull(paramMap.get("schedule_and_or"));
	String schedule_year	= CommonUtil.isNull(paramMap.get("schedule_year"));
	String active_from		= CommonUtil.isNull(paramMap.get("active_from"));
	String active_till		= CommonUtil.isNull(paramMap.get("active_till"));
	
	
	System.out.println("forecast   : "   + forecast);
	System.out.println("forecast.length() : " + forecast.length());
	
	SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
	String sysDate 	= formatter.format(new java.util.Date());
	String sysYear 	= sysDate.substring(0,4);
	
	if ( forecast.indexOf("Year")  > -1 ) {
		forecast  = forecast.substring(forecast.indexOf("Year"), forecast.length());
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Frameset//EN" "http://www.w3.org/TR/html4/frameset.dtd">
<html lang="ko" style="overflow:hidden;">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title><%=CommonUtil.isNull(CommonUtil.getMessage("HOME.TITLE")) %></title>
<link rel="stylesheet" href="<%=sContextPath %>/css/css.css" type="text/css">
<script src="<%=sContextPath %>/js/jquery-1.9.0.min.js"></script>
<link href="<%=request.getContextPath() %>/css/custom-theme/jquery-ui.custom.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery-ui.custom.min.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/works_common.js" ></script>
</head>
<body>

<div class="view_area">
	<form id="frm1" name="frm1" method="post" onsubmit="return false;" enctype="multipart/form-data" >
	<!-- title -->
	<div class="tit_area" >
		<h1 style="margin:10px 0 0 10px;"><span class="icon"><img src="<%=sContextPath %>/images/icon_sgnb3.png" alt="" /></span>작업스케줄</h1>
		
		<h1 style="margin:10px 0 0 10px;"><select id='schedule_year' name='schedule_year' style="width:100px;height:21px;">
			<%
			for(int i=0;i<calYearList.size(); i++){		
				CommonBean yearBean = (CommonBean) calYearList.get(i);
				String strYear = CommonUtil.isNull(yearBean.getYear());
			%>
			<option value='<%=strYear%>' <%=(!schedule_year.equals("") && schedule_year.equals(strYear)) ? "selected" :  (schedule_year.equals("") && strYear.equals(sysYear)) ? "selected" : "" %>><%=strYear%></option>
			
			<%
			}
			%>
		</select><span id="schedule_status" class='tCenter' style="color:blue;vertical-align: text-bottom"></span></h1>
		<div class="btn">
<!-- 			<a href="JavaScript:self.close();" class="btn_close_1" style="margin:10px 15px 0 0;">닫기</a> -->
			<h4 class="ui-widget-header ui-corner-all" style="border:none;" >
					<span id='btn_close' style="display:none;width:60px;height:27px;font-size:12px;margin:7px 15px 0 0;">닫기</span>
			</h4>
		</div>
	</div>
	<!-- //title -->
	
	<input type="hidden" name="data_center" 	id="data_center" 	value="<%=data_center%>"/>
	<input type="hidden" name="v_sched_table" 	id="v_sched_table" 	value="<%=v_sched_table%>"/>
	<input type="hidden" name="job_name" 	id="job_name" 	value="<%=job_name%>"/>
	<input type="hidden" name="month_days" 	id="month_days" 	value="<%=month_days%>"/>
	<input type="hidden" name="days_cal" 	id="days_cal" 		value="<%=days_cal%>"/>
	<input type="hidden" name="week_days" 	id="week_days" 		value="<%=week_days%>"/>
	<input type="hidden" name="weeks_cal" 	id="weeks_cal" 		value="<%=weeks_cal%>"/>
	<input type="hidden" name="month_1" 	id="month_1" 		value="<%=month_1%>"/>
	<input type="hidden" name="month_2" 	id="month_2" 		value="<%=month_2%>"/>
	<input type="hidden" name="month_3" 	id="month_3" 		value="<%=month_3%>"/>
	<input type="hidden" name="month_4" 	id="month_4" 		value="<%=month_4%>"/>
	<input type="hidden" name="month_5" 	id="month_5" 		value="<%=month_5%>"/>
	<input type="hidden" name="month_6" 	id="month_6" 		value="<%=month_6%>"/>
	<input type="hidden" name="month_7" 	id="month_7" 		value="<%=month_7%>"/>
	<input type="hidden" name="month_8" 	id="month_8" 		value="<%=month_8%>"/>
	<input type="hidden" name="month_9" 	id="month_9" 		value="<%=month_9%>"/>
	<input type="hidden" name="month_10" 	id="month_10" 		value="<%=month_10%>"/>
	<input type="hidden" name="month_11" 	id="month_11" 		value="<%=month_11%>"/>
	<input type="hidden" name="month_12" 	id="month_12" 		value="<%=month_12%>"/>
	<input type="hidden" name="schedule_and_or" 	id="schedule_and_or" 		value="<%=schedule_and_or%>"/>
	<input type="hidden" name="active_from" 	id="active_from" 		value="<%=active_from%>"/>
	<input type="hidden" name="active_till" 	id="active_till" 		value="<%=active_till%>"/>
	</form>
	<%
		if ( forecast.indexOf("Year")  > -1 ) {
	%>

	<div class="board_area" style="height:500px;">
	
	<%
		String[] monIndex = {"JAN","FEB","MAR","APR","MAY","JUN","JUL","AUG","SEP","OCT","NOV","DEC"};
		Map<String,ArrayList<String>> mMon = new HashMap<String,ArrayList<String>>();
		for(int k=0; k<monIndex.length; k++){
			ArrayList<String> alTmp = new ArrayList<String>();
			for(int i=forecast.indexOf(monIndex[k]+":")+4;forecast.indexOf(monIndex[k]+":")>-1;i++){
				if( i>-1 && ' '!=forecast.charAt(i) ) alTmp.add(forecast.charAt(i)+"");
				else break;
			}
			mMon.put("mMon"+k,alTmp);
		}
	
		for ( int iMon = 0 ;iMon < 12;iMon++ ) {
			ArrayList<String> alChk = mMon.get("mMon"+iMon);
	%>
	
			<div class="cal_pop_area">
				
				<table class="board_cal2 gray">
				<colgroup>
					<col width="14.3%" />
					<col width="14.3%" />
					<col width="14.3%" />
					<col width="14.3%" />
					<col width="14.3%" />
					<col width="14.3%" />
				</colgroup>
				<thead>
				<tr>
					<th colspan="7"><%=iMon+1%>월</th>
				</tr>
				<tr>
					<th>일</th>
					<th>월</th>
					<th>화</th>
					<th>수</th>
					<th>목</th>
					<th>금</th>
					<th>토</th>
				</tr>
				</thead>
				<tbody>
				
				<tr>
					
					<%
					Calendar cal = Calendar.getInstance();
					cal.set(Calendar.YEAR,Integer.parseInt(!schedule_year.equals("") ? schedule_year : sysYear));
					cal.set(Calendar.MONTH,iMon);
					cal.set(Calendar.DATE,1);
					
					int iYear 		= cal.get(Calendar.YEAR);
					int iMonth 		= cal.get(Calendar.MONTH)+1;
					int iDayOfWeek 	= cal.get(Calendar.DAY_OF_WEEK);
					int iMaxDay 	= cal.getActualMaximum(Calendar.DAY_OF_MONTH);
					
					Vector vDate = new Vector();
					
					//first sunday
					for(int i=0;i<iDayOfWeek-1;i++) vDate.add("");
					
					for(int i=1;i<=42;i++) vDate.add(Integer.toString(i));
				
					String sDay 	= "";
					boolean bLink 	= false;
					String td_class	= "";
					String strDate 	= "";
					int iTdCnt 		= 0;
					for (int i=0;i<=41;i++) {
						sDay = (String)vDate.get(i);
						if ( iMaxDay >= Integer.parseInt(sDay.equals("")?"0":sDay) ){
							bLink 		= true;
							td_class 	= "";
							strDate 	= iYear+"";
							if( iMonth < 10 ){
								strDate += ("0"+iMonth);
							}else{
								strDate += iMonth;
							}
							if( sDay.equals("") ){
								strDate += "00";
							}else{
								if( Integer.parseInt(sDay) < 10 ){
									strDate += ("0"+Integer.parseInt(sDay));
								}else{
									strDate += Integer.parseInt(sDay);
								}
// 								out.println(alChk.get(Integer.parseInt(sDay)-1));
//  								out.println(Integer.parseInt(sDay)-1);
								try
								{
									if ( "*".equals(alChk.get(Integer.parseInt(sDay)-1)) ) {
										td_class 	= "end";
									}									
								}
								catch ( IndexOutOfBoundsException e )
								{
					%>
								<script type="text/javascript" >
										document.getElementById('schedule_status').innerHTML = "<%=forecast%>"
								</script>
					<%
								}
							}							
							
							if( (i%7)==0 ){
					%>
						<%iTdCnt++;%>
						<td class="<%=td_class%>" ><span style="color:red;" ><%=sDay%></span></td>
					<%		}else{
								iTdCnt++;
								if( iTdCnt==7 ){
					%>
								<td class="<%=td_class%>"><span style="color:blue;" ><%=sDay%></span></td>
					<%			}else{
					%>
								<td class="<%=td_class%>"><span style="color:black;" ><%=sDay%></span></td>
					<%			}
							}
							
							if( iMaxDay > Integer.parseInt(sDay.equals("")?"0":sDay) && iTdCnt==7 ){
								iTdCnt = 0;
								out.print("</tr><tr height='20' bgcolor='#ffffff' align='center' >");
							}
						}
						if( iMaxDay < Integer.parseInt(sDay.equals("")?"0":sDay) ){
							if( 0<iTdCnt && iTdCnt<7 ){
								for( int k=iTdCnt;k<7;k++ ) out.print("<td></td>");
							}
							break;
						}
					}
					%>
				
				</tr>			
				</tbody>
				</table>

			</div>
		<%
			}
		%>

	</div>

	<%
	} else {
	%>
	<div class="board_area" style="height:500px;text-align:left;">
		<%=forecast%>
	</div>
	<%
		}
	%>

</div>
<script>
	$(document).ready(function() {

		$("#btn_close").show();

		$("#btn_close").button().unbind("click").click(function(){
			self.close();
		});
		
		$("#schedule_year").change(function(){
			fn_sch_forecast()
		});
	});
	
	function fn_sch_forecast() {

		var frm = document.frm1;

		//openPopupCenter2("about:blank", "fn_sch_forecast", 1000, 500);

		var v_sched_table = '<%=v_sched_table%>';
		var job_name = '<%=job_name%>';
		
		if(job_name != '' && v_sched_table != '' ){
			frm.action = "<%=sContextPath %>/mPopup.ez?c=ez010";
		}else{
			frm.action = "<%=sContextPath %>/tWorks.ez?c=ez033";
		}
		
		frm.target = "_self";
		frm.submit();
	}
</script>
</body>
</html>