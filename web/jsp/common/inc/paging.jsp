<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.ghayoun.ezjobs.common.util.*" %>

<input type="hidden" id="currentPage" 	name="currentPage" />

<%
	Paging paging = (Paging)request.getAttribute("Paging");
	
	if ( paging !=null && paging.getTotalRowSize()>0 ) {
%>
		<!-- paging -->
		<div class="paginate">
			<p>
				<img src="<%=request.getContextPath() %>/images/first.gif" alt="처음" 	<% if( paging.getFirstPage()!=paging.getCurrentPage() ){ %> onclick="goPage(<%=paging.getFirstPage() %>);" style="cursor:pointer;margin:0;border:1px solid #ccc;" <%} %> border='0' 	style="margin:0;border:1px solid #ccc;" />
			    <img src="<%=request.getContextPath() %>/images/prev.gif" alt="이전" 	<% if( paging.getViewStartPage()!=paging.getFirstPage() ){ %> onclick="goPage(<%=paging.getPrePage() %>);" style="cursor:pointer;margin:0;border:1px solid #ccc;" <%} %> border='0' 	style="margin:0;border:1px solid #ccc;" />
			    
			    <%
			    	for ( int i=paging.getViewStartPage(); i<=paging.getViewEndPage(); i++ ) {
						if (i==paging.getCurrentPage()) {
				%>
							<a href="#" class="num"><strong><%=i%></strong></a>
				<%
						} else {
				%>
							<a href="JavaScript:goPage(<%=i%>);" class="num"><%=i%></a>
				<%
						}
			    	}
				%>
				
			    <img src="<%=request.getContextPath() %>/images/next.gif" alt="다음" 	<% if( paging.getViewEndPage()!=paging.getLastPage() ){ %>  onclick="goPage(<%=paging.getNextPage() %>);" style="cursor:pointer;margin:0 0 0 1px;border:1px solid #ccc;" <%} %> border='0' 	style="margin:0 0 0 1px;border:1px solid #ccc;"/>
			    <img src="<%=request.getContextPath() %>/images/last.gif" alt="마지막" 	<% if( paging.getLastPage()!=paging.getCurrentPage() ){ %>  onclick="goPage(<%=paging.getLastPage() %>);" style="cursor:pointer;margin:0 0 0 1px;border:1px solid #ccc;"  <%} %> border='0' 	style="margin:0 0 0 1px;border:1px solid #ccc;"/>
			</p>
			
			<select name="rowCnt" onChange="fn_changeRowCnt();">
				<option value="5" 	<%= Integer.toString(paging.getRowSize()).equals("5") ? "selected" : "" %>>5 ROWS</option>
				<option value="10" 	<%= Integer.toString(paging.getRowSize()).equals("10") ? "selected" : "" %>>10 ROWS</option>
				<option value="20" 	<%= Integer.toString(paging.getRowSize()).equals("20") ? "selected" : "" %>>20 ROWS</option>
				<option value="50" 	<%= Integer.toString(paging.getRowSize()).equals("50") ? "selected" : "" %>>50 ROWS</option>
				<option value="100" <%= Integer.toString(paging.getRowSize()).equals("100") ? "selected" : "" %>>100 ROWS</option>
				<option value="200" <%= Integer.toString(paging.getRowSize()).equals("200") ? "selected" : "" %>>200 ROWS</option>
			</select>
			
		</div>
		<!-- //paging -->
		
<%	
	} 
%>

