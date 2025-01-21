<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@include file="/jsp/common/inc/header.jsp"%>
<%@include file="/jsp/common/inc/sessionChkPopup.jsp"%>
<%@include file="/jsp/common/inc/progBar.jsp"%>

<%
	Map<String, Object> paramMap = CommonUtil.collectParameters(request);
	
	CommonBean calendarDetail		= (CommonBean)request.getAttribute("calendarDetail");
	
	String calendar 		= CommonUtil.isNull(paramMap.get("calendar"));
	String year 			= CommonUtil.isNull(paramMap.get("year"));
	String strDescription	= "";
	
	if( calendarDetail != null ){
		strDescription = CommonUtil.isNull(calendarDetail.getDescription());
	}
%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head><title><%=calendar%></title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link href="<%=sContextPath %>/css/common.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="<%=sContextPath %>/js/common.js" ></script>
<script type="text/javascript" >
<!--
	
//-->
</script>

</head>

<style type="text/css">
<!--
	body {
	font-family: "돋움";
	font-size: 8pt;
	color: #336666;
	
	}
	
	td {
		font-family: "돋움";
		font-size: 8pt;
		color: #336666;
	}
//-->
</style>
<script type="text/javascript">
<!--

//-->
</script>

</head>

<body style='padding-left:10;padding-right:10;padding-top:20;padding-bottom:20;'>

<form name="calForm" action="" method="post" onSubmit="return false;" >


<table width='100%' border='0' >
	<tr >
		<td width='80'>
			<img src="<%=sContextPath %>/imgs/popup/pop_title_icon.gif" />
		</td>
		<td style='font-size:16px;font-weight:bold;'>
			<%=calendar %> - <%=strDescription %> ( <%=year %>년 )
		</td>
	</tr>
</table>	

<table width='100%' height='98%' border='0'  >
<tr bgcolor='#f9fafd' >
<td valign='top' style='padding:10 10 10 10'>
<%
	String days_1 = "";
	String days_2 = "";
	if( calendarDetail == null ){
		out.println("<pre>"+CommonUtil.getMessage("DEBUG.06")+"</pre>");
	}else{
		days_1 = CommonUtil.isNull(calendarDetail.getDays_1());
		days_2 = CommonUtil.isNull(calendarDetail.getDays_2());
	}
	if(!"".equals(days_1) && !"".equals(days_2)){
		String days = days_1.trim() + days_2.trim();
		
		int minIdx = 0;
		int maxIdx = 0;
		ArrayList monIndex = new ArrayList();
		for(int iMon=0;iMon<12;iMon++){
			Calendar cal = Calendar.getInstance();
			cal.set(Calendar.YEAR,Integer.parseInt(year));
			cal.set(Calendar.MONTH,iMon);
			cal.set(Calendar.DATE,1);
			int iMaxDay 	= cal.getActualMaximum(Calendar.DAY_OF_MONTH);
			
			maxIdx += iMaxDay ;
			
			monIndex.add(maxIdx+"");
			
		}
		Map<String,ArrayList<String>> mMon = new HashMap<String,ArrayList<String>>();
		for(int k=0; k<monIndex.size(); k++){
			ArrayList<String> alTmp = new ArrayList<String>();
			minIdx = 0;
			maxIdx = 0;
			if(k>0) minIdx = Integer.parseInt((String)monIndex.get(k-1));
			maxIdx = Integer.parseInt((String)monIndex.get(k));
			for(int i=minIdx;i<maxIdx;i++){
				if( 'Y' ==days.charAt(i) ) alTmp.add("*");
				else alTmp.add(" ");
			}
			mMon.put("mMon"+k,alTmp);
		}
		
%>


<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<%for(int iMon=0;iMon<12;iMon++){ 
	if(iMon==0) out.println("<tr>");
	if(iMon==6) out.println("</tr><tr height='15px'><td></td></tr><tr>");
	if(iMon==12) out.println("</tr>");
	
	ArrayList<String> alChk = mMon.get("mMon"+iMon);
	%>
		<td valign="top">
		
<%
	Calendar cal = Calendar.getInstance();
	cal.set(Calendar.YEAR,Integer.parseInt(year));
	cal.set(Calendar.MONTH,iMon);
	cal.set(Calendar.DATE,1);
	
	int iYear 		= cal.get(Calendar.YEAR);
	int iMonth 		= cal.get(Calendar.MONTH)+1;
	int iDayOfWeek 	= cal.get(Calendar.DAY_OF_WEEK);
	int iMaxDay 	= cal.getActualMaximum(Calendar.DAY_OF_MONTH);
	
	Vector vDate = new Vector();
	
	//first monday
	//if(iDayOfWeek==Calendar.SUNDAY) for(int i=0;i<6;i++) vDate.add("");
	//else for(int i=0;i<iDayOfWeek-2;i++) vDate.add("");
	
	//first sunday
	for(int i=0;i<iDayOfWeek-1;i++) vDate.add("");
	
	
	for(int i=1;i<=42;i++) vDate.add(Integer.toString(i));
%>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td valign="top">
			<%=iMonth %>월
		</td>
	</tr>
	<tr>
		<td valign="top" style='padding:2px'>
			<table width="100%" border="0" cellspacing="1" cellpadding="1" bgcolor="#dcdcdc" >
				<tr height="25" align="center" bgcolor="#f1f1f1">
					<td style="color:red;">일</td>
					<td >월</td>
					<td >화</td>
					<td >수</td>
					<td >목</td>
					<td >금</td>
					<td style="color:blue;">토</td>
				</tr>
				<tr height="20" bgcolor="#ffffff" align='center' >
				<%
				String sDay 	= "";
				boolean bLink 	= false;
				String bgcolor 	= "";
				String strDate 	= "";
				int iTdCnt 		= 0;
				for (int i=0;i<=41;i++) {
					sDay = (String)vDate.get(i);
					if ( iMaxDay >= Integer.parseInt(sDay.equals("")?"0":sDay) ){
						bLink 		= true;
						bgcolor 	= "";
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
							
							if( "*".equals(alChk.get(Integer.parseInt(sDay)-1)) ) bgcolor 	= " bgcolor='#ffdab9' ";
						}
						
						
						if( (i%7)==0 ){
				%>
					<%iTdCnt++;%>
					<td <%=bgcolor %> >
						<span style="color:red;" ><%=sDay%></span>
					</td>
				<%		}else{
							iTdCnt++;
							if( iTdCnt==7 ){
				%>
							<td <%=bgcolor %>>
								<span style="color:blue;" ><%=sDay%></span>
							</td>
				<%			}else{
				%>
							<td <%=bgcolor %>>
								<span style="color:black;" ><%=sDay%></span>
							</td>
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
				
			</table>
		</td>
	</tr>
</table>
		
		
		</td>
	<%} %>
</table>

<%} //else %>
</td></tr></table>
 
</form>

</body>
</html>
