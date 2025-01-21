<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@include file="/jsp/common/inc/header.jsp"%>
<%@include file="/jsp/common/inc/sessionChkPopup.jsp"%>

<%
	Map<String, Object> paramMap = CommonUtil.collectParameters(request);
	String c = CommonUtil.isNull(paramMap.get("c"));
	String aGb[] = null;
	
	String trace_log_file = CommonUtil.isNull(paramMap.get("trace_log_file"));
	String trace_log_path = CommonUtil.isNull(paramMap.get("trace_log_path"));
%>

<form id="f_s" name="f_s" method="post" onsubmit="return false;">

	
</form>


<table style='width:100%;height:100%;border:none;' >
	<tr>
		<td style='vertical-align:top;'>
			<div style='width:100%;height:100%;vertical-align:top;overflow-y:scroll;'>
			<%
				if(new File(trace_log_path).exists() ){
					String file = trace_log_path + trace_log_file + ".log";
					try {
						BufferedReader reader = new BufferedReader(new FileReader(file));
						String line = null;
						while ((line = reader.readLine()) != null){
		    %>
		    				 <%=line%></br>
		    <%
		            	}
					}catch(IOException e){
						e.printStackTrace();
		 	%>			
						<span>파일이 존재하지 않습니다.</span>
			<%
					}
				}
			%>
			</div>
		</td>
	</tr>
</table>

<script>
	
	$(document).ready(function(){
		
	});
	
	
</script>

