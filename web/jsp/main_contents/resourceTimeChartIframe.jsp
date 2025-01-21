<%@page import="java.util.Map"%>
<%@page import="com.ghayoun.ezjobs.comm.domain.CommonBean"%>
<%@page import="java.util.List"%>
<%@page import="com.ghayoun.ezjobs.common.util.CommonUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.ghayoun.ezjobs.t.domain.*" %>

<%
	Map<String, Object> paramMap 	= CommonUtil.collectParameters(request);
	String sContextPath = request.getContextPath();
	String search_start_date 		= CommonUtil.isNull(paramMap.get("search_start_date"));
	String search_end_date 			= CommonUtil.isNull(paramMap.get("search_end_date"));
	String search_start_time 		= CommonUtil.isNull(paramMap.get("search_start_time"));
	String search_end_time 			= CommonUtil.isNull(paramMap.get("search_end_time"));
	String search_text 				= CommonUtil.isNull(paramMap.get("search_text"));
	String data_center 				= CommonUtil.isNull(paramMap.get("data_center"));
	List dataCenterList				= (List)request.getAttribute("dataCenterList");
	List resourceNMList 			= (List)request.getAttribute("resourceNMList");
	List resourceHHList 			= (List)request.getAttribute("resourceHHList");
	List resourceTimeList 			= (List)request.getAttribute("resourceTimeList");
	
%>

<form id="frm2" name="frm2" method="post" action="" onsubmit="return false;">
	<div class="board_area"  style="overflow-y:scroll;">
		<div class="lst_area">
			<%for(int i=0; i<resourceNMList.size();i++){
				CommonBean bean3 = (CommonBean)resourceHHList.get(i);
				String strQresname = CommonUtil.isNull(bean3.getQresname());
			%>
			<TABLE width='100%' border='0' cellspacing='0' cellpadding='0' align='left' id='resourceTimeChartTable<%=i%>'>
					<TR>
						<TD>
							<TABLE width='100%' style='height:500px;' border='0' cellspacing='0' cellpadding='0' >
							<TR	>
								<TD align='center' >
									<div id='chartContainer<%=i%>' style="height:100%;width:100%;resize:both;"></div> 
								</TD>
							</TR>
							</TABLE>
						</TD>
					</TR>
			</TABLE>
			<%} %>
			<%
			if(resourceNMList.size() == 0){
			%>
			<TABLE width='100%' border='0' cellspacing='0' cellpadding='0' align='left' id='resourceTimeChartTable'>
					<TR>
						<TD>
							<TABLE width='100%' style='height:500px;' border='0' cellspacing='0' cellpadding='0' style='table-layout:fixed;' >
							<TR	>
								<TD align='center' >
									<div id='chartContainer' style="height:100%;width:100%;resize:both;"></div> 
								</TD>
							</TR>
							</TABLE>
						</TD>
					</TR>
			</TABLE>
			<%} %>
		</div>
	</div>
</form>

<script type="text/javascript" >
	$(document).ready(function(){
		resourceTimeChartXml('', '');
	});
	function fn_refresh() {
		try{
			var frm = parent.search.document.frm1;
		
			if ( frm.refresh_time.value != "" ) {
				timer = setInterval(parent.search.fn_search, (1000*frm.refresh_time.value));
			}
		}catch(e){}
	}
	
	function callBackSearchItemListXML() {
		var xmlDoc = this.req.responseText;
		
		var parser = new DOMParser();
		xmlDoc = parser.parseFromString(xmlDoc, 'text/html');
		console.log(JSON.stringify(xmlDoc));
		var chart 	= xmlDoc.getElementsByTagName('chart');
		var dataset = xmlDoc.getElementsByTagName('dataset');
		
		var node_nm			= '';
		var seriesName 		= '';
		var series_json 	= '';
		var search_time = '<%=search_start_time%>';
		var i_search_time = parseInt(search_time);
		var timeData = []; 
		
		var today = new Date();   
		var preHours = ('0' + (i_search_time-1)).slice(-2); 
		var hours = ('0' + i_search_time).slice(-2); 
		var minutes = ('0' + today.getMinutes()).slice(-2);
		var qrTotal = '';
		var timeString = hours + ':' + minutes;
		<%
		System.out.println("resourceNMList.size() : " + resourceNMList.size());
		if(resourceNMList.size() > 0){
			//for( int j = 0; null != resourceList && j < resourceList.size(); j++ ) {
			CommonBean bean = (CommonBean)resourceNMList.get(0);
			String strQresname = CommonUtil.isNull(bean.getQresname());
			for(int i=0; i<resourceTimeList.size(); i++){
				CommonBean bean2 = (CommonBean)resourceTimeList.get(i);
			    String strInsDate = CommonUtil.isNull(bean2.getIns_date());
			    String strInsDateHH = CommonUtil.isNull(bean2.getIns_date_hh());
				String strQresTimeName  = CommonUtil.isNull(bean2.getQresname());
				String strQrTotal  = CommonUtil.isNull(bean2.getQrtotal());
			    if(strQresname.equals(strQresTimeName)){
		%>
					timeData.push('<%=strInsDateHH%>');
					qrTotal = '<%=strQrTotal%>';
		<%
				}
	    	}
		}
		%>
		
		chart = " [" + chart[0].getAttribute("id") + "]";
		var channelsArray = [];
		var seriesList = [];
		
		if (node_nm != "" ) {
			node_nm = node_nm.substring(0, node_nm.length-1);
		}
		<%
		for(int j=0; j<resourceNMList.size(); j++){
			CommonBean bean4 = (CommonBean)resourceNMList.get(j);
			String strQresname = CommonUtil.isNull(bean4.getQresname());
			System.out.println("strQresname : " + strQresname);
		%>
		
			channelsArray = [];
			var set = dataset['<%=j%>'].getElementsByTagName('set');
			node_nm += dataset['<%=j%>'].getAttribute("id") + ",";
			channelsArray.push(dataset['<%=j%>'].getAttribute("id"));
			dash01 = echarts.init(document.getElementById('chartContainer<%=j%>'));
			dash01_opt = {
			    title: {
			    	text: '시간대별리소스 (1분 단위)'
			    },
			    tooltip: {
			        trigger: 'axis'
			    },
			    legend: {
			        data: channelsArray
			    },
			    grid: {
			        left: '3%',
			        right: '4%',
			        bottom: '3%',
			        containLabel: true
			    },
			    toolbox: {
			        feature: {
			            saveAsImage: {}
			        }
			    },
			    xAxis: {
			        type: 'category',
			        boundaryGap: false,
			        data: timeData
			    },
			    yAxis: {
			        type: 'value'
			    }
			};
			
			dash01.setOption(dash01_opt);
			;
			seriesList = [];
			var set2 = dataset['<%=j%>'].getElementsByTagName('set');
			var set2Data = [];
			seriesName = dataset['<%=j%>'].getAttribute("seriesName");
			
				
				if ( set2.length > 0 ) { 
					for(var j=0; j<set2.length; j++){
						set2Data.push(set2[j].getAttribute("id"));
					}
					
					seriesList.push(
										{
		                            	name : dataset['<%=j%>'].getAttribute("id"),
		                                type :'line',
		                                stack : false,
		                                data : set2Data
		                         		}
									);
				} else {
					
					seriesList.push(
							{
	                    	name : dataset['<%=j%>'].getAttribute("id"),
	                        type :'line',
	                        stack : false,
	                        data : [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
		                        	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
		                        	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
		                        	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
		                        	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
		                        	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
		                        	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
		                        	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
		                        	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
		                        	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
		                        	0]
	                 		}
						);
				}
			
	        if(dataset.length <= 0)    {
	        	seriesList.push(
						{
	                	name : dataset['<%=j%>'].getAttribute("id"),
	                    type :'line',
	                    stack : false,
	                    data : [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
	                        	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
	                        	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
	                        	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
	                        	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
	                        	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
	                        	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
	                        	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
	                        	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
	                        	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
	                        	0]
                 		}
					);
	        }
			dash01.setSeries(seriesList);
			
		 	window.onresize = function() {
		 		dash01.resize();
			};
		<%}%>
		
		<%
		if(resourceNMList.size() == 0){
		%>
		dash01 = echarts.init(document.getElementById('chartContainer'));
		dash01_opt = {
		    title: {
		    	text: '시간대별리소스 (1분 단위)'
		    },
		    tooltip: {
		        trigger: 'axis'
		    },
		    legend: {
		        data: channelsArray
		    },
		    grid: {
		        left: '3%',
		        right: '4%',
		        bottom: '3%',
		        containLabel: true
		    },
		    toolbox: {
		        feature: {
		            saveAsImage: {}
		        }
		    },
		    xAxis: {
		        type: 'category',
		        boundaryGap: false,
		        data: timeData
		    },
		    yAxis: {
		        type: 'value'
		    }
		};
		
		dash01.setOption(dash01_opt);
		;
		var seriesList = [];
		for ( var i = 0; i < dataset.length; i++ ) {
			var set2 = dataset[i].getElementsByTagName('set');
			var set2Data = [];
			
			if ( set2.length > 0 ) { 
				for(var j=0; j<set2.length; j++){
					set2Data.push(set2[j].getAttribute("id"));
				}
				
				seriesList.push(
									{
	                            	name : dataset[i].getAttribute("id"),
	                                type :'line',
	                                stack : false,
	                                data : set2Data
	                         		}
								);
			} else {
				
				seriesList.push(
						{
                    	name : dataset[i].getAttribute("id"),
                        type :'line',
                        stack : false,
                        data : [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
	                        	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
	                        	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
	                        	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
	                        	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
	                        	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
	                        	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
	                        	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
	                        	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
	                        	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
	                        	0]
                 		}
					);
			}

		}
        if(dataset.length <= 0)    {
        	seriesList.push(
					{
                	name : dataset[i].getAttribute("id"),
                    type :'line',
                    stack : false,
                    data : [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
                        	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
                        	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
                        	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
                        	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
                        	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
                        	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
                        	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
                        	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
                        	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
                        	0]
             		}
				);
        }
		dash01.setSeries(seriesList);
		
	 	window.onresize = function() {
	 		dash01.resize();
		};
		<%}%>
		$('#td_body').css("overflow-y", "scroll");
	}
	
	function lpad(str, padLen, padStr) {
	    if (padStr.length > padLen) {
	        console.log("오류 : 채우고자 하는 문자열이 요청 길이보다 큽니다");
	        return str;
	    }
	    str += ""; // 문자로
	    padStr += ""; // 문자로
	    while (str.length < padLen)
	        str = padStr + str;
	    str = str.length >= padLen ? str.substring(0, padLen) : str;
	    return str;
	}
	function resourceTimeChartXml(cnt, strQresname){
		var search_text = '<%=search_text%>';
		if(search_text == ''){
			search_text = strQresname;
		}
		var get_param = '&search_start_date=<%=search_start_date%>&search_end_date=<%=search_end_date%>&search_start_time=<%=search_start_time%>&search_end_time=<%=search_end_time%>&search_text='+search_text+'&data_center=<%=data_center%>';
		var dataUrl="<%=sContextPath %>/mEm.ez?c=ez013_xml"+get_param;
		
		var url 	= dataUrl;
		
		var xhr 	= new XHRHandler( url, null, callBackSearchItemListXML, null );
		console.log('XML 데이터를 성공적으로 받았습니다:', xhr);
		xhr.sendRequest();
	}
	<%-- async function resourceTimeChartXml(cnt, strQresname){
		
		try{
			var xhrHandler = new XHRHandler();
			var search_text = '<%=search_text%>';
			if(search_text == ''){
				search_text = strQresname;
			}
			var get_param = '&search_start_date=<%=search_start_date%>&search_end_date=<%=search_end_date%>&search_start_time=<%=search_start_time%>&search_end_time=<%=search_end_time%>&search_text='+search_text+'&data_center=<%=data_center%>';
			var dataUrl="<%=sContextPath%>/mEm.ez?c=ez013_xml"+get_param;
			
			var url 	= dataUrl;
		
			var xmlData = await new XHRHandler( url, null, callBackSearchItemListXML, null );
			
			console.log('XML 데이터를 성공적으로 받았습니다:', xmlData);
		}catch (error){
			console.error(error.message);
		}
	} --%>
	
</script>

