<%@ page language="java" contentType="application/xml; charset=EUC-KR" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,java.util.*,java.io.*,java.text.*,java.net.*" %>
<%@ page import="com.ghayoun.ezjobs.m.domain.*" %>
<%@ page import="com.ghayoun.ezjobs.common.util.*" %>
<%@ page import="com.ghayoun.ezjobs.comm.domain.*" %>

<%
	Map<String, Object> paramMap = CommonUtil.collectParameters(request);

	List resourceNMList 				= (List)request.getAttribute("resourceNMList");
	List resourceHHList 				= (List)request.getAttribute("resourceHHList");
	List resourceTimeList 			= (List)request.getAttribute("resourceTimeList");	
	List data_center 			= (List)request.getAttribute("data_center");	
	CommonBean commonBean		= (CommonBean)request.getAttribute("commonbean");
	
	String strDataCenterName	= "";
	
	if ( commonBean != null ) {
		strDataCenterName 			= CommonUtil.isNull(commonBean.getData_center_name(), "");		
	}
	System.out.println("strDataCenterName : " + strDataCenterName);
%>

<chart id='<%=strDataCenterName%>' caption='<%=strDataCenterName%>'>
	
	<%
		for( int i = 0; null != resourceNMList && i < resourceNMList.size(); i++ ) {
			CommonBean bean = (CommonBean)resourceNMList.get(i);
			
			int iChartNum = (int)(Math.random()*1000000); 
			String strQresname = CommonUtil.isNull(bean.getQresname());
			String strQrTotal 		= CommonUtil.isNull(bean.getQrtotal(),"0");
	%>	
			<dataset id='<%=strQresname%>(Max : <%=strQrTotal%>)' seriesName='<%=strQresname%>' color='#<%=iChartNum%>' anchorBorderColor='#<%=iChartNum%>'>
			
			<%			
				for( int z = 0; null != resourceTimeList && z < resourceTimeList.size(); z++ ) {
					CommonBean bean2 = (CommonBean)resourceTimeList.get(z);
					
					String strQresTimeName  = CommonUtil.isNull(bean2.getQresname());
					String strQrTimeused 		= CommonUtil.isNull(bean2.getQrused(),"0");
					String strQrTimeTotal 		= CommonUtil.isNull(bean2.getQrtotal(),"0");
					int qrused				= Integer.parseInt(strQrTimeused);
					if ( strQresname.equals(strQresTimeName) ) {
						
						//for ( int j = 0; j < 60; j++ ) {
							if ( qrused > 0 ) {
							
								out.println("<set id='" + strQrTimeused + "' title='" + strQrTimeused +"' />");
								
							} else {
								
								out.println("<set id='0' title='0' />");
							}
						//}
					}
			%>
					
					
					
			<%	
				}
			%>
				
			</dataset>
	<%
			
		}
	
	if( null == resourceHHList || resourceHHList.size() == 0){
		int iChartNum = (int)(Math.random()*1000000); 
		%>	
		<dataset id='noname' seriesName='noname' color='#<%=iChartNum%>' anchorBorderColor='#<%=iChartNum%>'>
		<set id='0' title='0' />
		</dataset>
		<%
	}
	%>
</chart>
