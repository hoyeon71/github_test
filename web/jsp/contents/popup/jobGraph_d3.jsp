<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.ghayoun.ezjobs.m.domain.*" %>

<%@include file="/jsp/common/inc/header.jsp"%>
<%@include file="/jsp/common/inc/sessionChkPopup.jsp"%>
<%@include file="/jsp/common/inc/progBar.jsp"%>

<%
	Map<String, Object> paramMap = CommonUtil.collectParameters(request);

	String odate 				= CommonUtil.isNull(paramMap.get("odate"));
	String data_center_code 	= CommonUtil.isNull(paramMap.get("data_center_code"));
	String data_center 			= CommonUtil.isNull(paramMap.get("data_center"));
	String active_net_name 		= CommonUtil.isNull(paramMap.get("active_net_name"));
	
	String order_id 			= CommonUtil.isNull(paramMap.get("order_id"));
	String table_id 			= CommonUtil.isNull(paramMap.get("table_id"));
	String job_id 				= CommonUtil.isNull(paramMap.get("job_id"));
	
	String jobgroup_id			= CommonUtil.isNull(paramMap.get("jobgroup_id"));
	
	String job_name 			= CommonUtil.isNull(paramMap.get("job_name"));
	String status 				= CommonUtil.isNull(paramMap.get("status"));
	
	String gubun 				= CommonUtil.isNull(request.getAttribute("gubun"));
	String active_gb			= CommonUtil.isNull(paramMap.get("active_gb"));

	response.setHeader("X-UA-Compatible", "IE=Edge");
%>


<!DOCTYPE html>
<html>
<head><title><%=CommonUtil.getMessage("POPUP.JOB_GRAPH.TITLE") %></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>

<link href="<%=request.getContextPath() %>/css/common2.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath() %>/css/custom-theme/jquery-ui.custom.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath() %>/css/custom-theme/jquery-ui.works.css" rel="stylesheet" type="text/css" />
<style>
.ui-tooltip, .arrow:after {
    background: black;
    border: 2px solid white;
  }
  .ui-tooltip {
    padding: 10px 20px;
    color: white;
    border-radius: 20px;
    font: bold 10px "Helvetica Neue", Sans-Serif;
    text-transform: uppercase;
    box-shadow: 0 0 7px black;
  }

text {font-family:'neon';font-size:10px;}
 
.rect_default {stroke:#999; stroke-width:2px;}
.rect_point {stroke:red; stroke-width:3px;}
.rect_sel {stroke:blue; stroke-width:3px;}

.edge_default {stroke:#999; stroke-width:3.5px;}
.edge_dash_default {stroke:#999; stroke-width:3.5px; stroke-dasharray:5,5}
.marker_default {fill:#999;}

.edge_cond {stroke:red; stroke-width:3.9px;}
.edge_dash_cond {stroke:red; stroke-width:3.9px; stroke-dasharray:5,5}
.marker_cond {fill:red;}

.edge_sel {stroke:blue; stroke-width:3.9px;}
.edge_dash_sel {stroke:blue; stroke-width:3.9px; stroke-dasharray:5,5}
.marker_sel {fill:blue;}

</style>


<script type="text/javascript" src="<%=request.getContextPath() %>/js/common.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/popup.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.min.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery-ui.custom.min.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/d3/d3.min.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/d3/graphlib-dot-0.6.1/dist/graphlib-dot.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/d3/dagre-d3-0.4.2/dist/dagre-d3.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/xhrHandler.js" ></script>


</head>

<body>

<form id="f_s" name="f_s" method="post" action="" onsubmit="return false;">
	<input type="hidden" name="odate" 				value="<%=odate %>" />
	<input type="hidden" name="data_center_code" 	value="<%=data_center_code %>" />
	<input type="hidden" name="data_center" 		value="<%=data_center %>" />
	<input type="hidden" name="active_net_name" 	value="${paramMap.active_net_name}" />
	
	<input type="hidden" name="order_id"  			value="<%=order_id %>" />
	<input type="hidden" name="table_id"  			value="<%=table_id %>" />
	<input type="hidden" name="job_id"  			value="<%=job_id %>" />
	
	<input type="hidden" name="jobgroup_id"			value="<%=jobgroup_id %>" />
	
	<input type="hidden" name="job_name"  			value="<%=job_name %>" />
	<input type="hidden" name="status"  			value="<%=status %>" />
	<input type="hidden" name="active_gb"  			value="<%=active_gb %>" />

</form>

<form id="frm4" name="frm4" method="post" action="" onsubmit="return false;">
	<input type="hidden" name="odate" 				value="<%=odate %>" />
	<input type="hidden" name="data_center_code" 	value="<%=data_center_code %>" />
	<input type="hidden" name="data_center" 		value="<%=data_center %>" />
	<input type="hidden" name="active_net_name" 	value="<%=active_net_name %>" />
	
	<input type="hidden" name="order_id"  />
	<input type="hidden" name="order_36_id"  />
	
	<input type="hidden" name="table_id"  />
	<input type="hidden" name="job_id"  />
	
	<input type="hidden" name="job"  />
	
	<input type="hidden" name="job_name"  value="<%=job_name%>"/>
	<input type="hidden" name="memname"  />
	<input type="hidden" name="status"  />
	
	<input type="hidden" name="rerun_count"  />
	<input type="hidden" name="total_rerun_count"  />
	<input type="hidden" name="end_date"  />
	<input type="hidden" name="node_id"  />
	<input type="hidden" name="graph_depth"  />	
	
	<input type="hidden" name="flag"  />
	
</form>

<body style='overflow:hidden;'>

<table border='1' style='width:100%;height:100%;'>
	<tr height="1200px">
		<td style='width:1800px;' valign=top' >
			<div id='ly_svg_wrap' style='width:1800px; height:1200px'>
				<svg id='ly_svg'> 
					<g transform="translate(20,20)"></g>
				</svg>
			</div>
		</td>		
	</tr>
	<!-- 
	<tr>
		<td valign=top' colspan="2">
			<div>
				<iframe id='bFrame' name="bFrame" width='100%'  height='200px'></iframe>
			</div>
		</td>
	</tr>
	-->
</table>

<ul id="ly_ContextMenu_01" style='position:absolute;z-index:2999;display:none;'>
	<li id='contextMenu_01_01' ><a href="#">선후행추적</a></li>
	<li id='contextMenu_01_02' ><a href="#">선행추적</a></li>
	<li id='contextMenu_01_03' ><a href="#">후행추적</a></li>
	<!-- 
	<li id='contextMenu_01_04' ><a href="#"></a></li>
	<li id='contextMenu_01_05' ><a href="#"></a></li>
	-->
	<li id='contextMenu_01_06' ><a href="#">작업 정보 </a></li>
	<!-- 	
	<li id='contextMenu_01_07' ><a href="#">작업정보/이력</a></li>	
	<li id='contextMenu_01_08' ><a href="#">수행시간이력</a></li>
	<li id='contextMenu_01_09' ><a href="#">CMLog</a></li>
	<li id='contextMenu_01_10' ><a href="#">CMWhy</a></li>
	<li id='contextMenu_01_11' ><a href="#">SysOut</a></li>
	<li id='contextMenu_01_12' ><a href="#">상태변경 : HOLD</a></li>
	<li id='contextMenu_01_13' ><a href="#">상태변경 : FREE</a></li>
	-->
</ul>

<!-- 
<ul id="ly_ContextMenu_02" style='position:absolute;z-index:2999;display:none;'>
	<li id='contextMenu_02_01' ><a href="#">선행삭제</a></li>
</ul>
-->

<script>
	function setNodesTagColor(svg){
		var defs = svg.append('svg:defs');
		
		var job_status = [
			{'id':'Ended_OK','c':'#31CE31'}
			,{'id':'Ended_Not_OK','c':'#FF0000'}
			,{'id':'Executing','c':'#CECE00'}
			,{'id':'Wait_Time','c':'#FFCC66'}
			,{'id':'Wait_Condition','c':'#999999'}
			,{'id':'Wait_Resource','c':'#3131CE'}
			,{'id':'Wait_Host','c':'#3131CE'}
			,{'id':'Wait_User','c':'#FF31CE'}
			,{'id':'Wait_Host','c':'#FF31CE'}
			,{'id':'Unknown','c':'#FFFFE6'}
			,{'id':'Not_in_AJF','c':'#CEFFFF'}
			,{'id':'Etc','c':'#CEFFFF'}
			,{'id':'Held','c':'#FF9966'}
			,{'id':'Deleted','c':'#003333'}
			,{'id':'Click_Job','c':'#3131CE'}
			,{'id':'Condition','c':'#F6F6F6'}			
		];
		
		for(var i=0;i<job_status.length;i++){
			defs.append("svg:pattern").attr("id", "tag_"+job_status[i].id).attr("width", '100%').attr("height", '100%').attr("x", 0).attr("y", 0).attr("patternUnits", "objectBoundingBox")
		    .append("svg:rect").attr("fill", job_status[i].c).attr("width", 15).attr("height", 150).attr("x", 0).attr("y", 0);
		}
		
	}
	
	var g = new dagreD3.graphlib.Graph().setGraph({
		nodesep: 10
		,ranksep: 40
		,rankdir: "LR"
		,marginx: 20
		,marginy: 20
	}).setDefaultEdgeLabel(function() { return {}; });
	
	var render = new dagreD3.render();

	var svg = d3.select("svg");	
	var svg_g = svg.select("g");
	
	setNodesTagColor(svg);
	
	var zoom = d3.behavior.zoom().on("zoom", function() {
			svg_g.attr("transform", "translate(" + d3.event.translate + ")"+"scale(" + d3.event.scale + ")");
		});
	svg.call(zoom);
	
	var mNodeInfo = null;
	var mNodeObj = null;
	var mEdgeInfo = null;
	var mEdgeObj = null;
	function initRender(){
		mNodeInfo = new Map();
		mNodeObj = new Map();
		mEdgeInfo = new Map();
		mEdgeObj = new Map();
		
		$('#ly_svg g').empty();
		g.nodes().forEach(function(v) {var node = g.node(v);node.rx = node.ry = 5;});
		render(svg_g, g);
		
// 		var svg_w = 1200;
// 		var svg_h = 700;
		var svg_w = 1800; 
		var svg_h = 1300;
		$('#ly_svg_wrap').width(svg_w).height(svg_h);
		
		if(svg_w<g.graph().width) svg_w = g.graph().width;
		if(svg_h<g.graph().height) svg_h = g.graph().height;
		$('#ly_svg').attr('width',svg_w+'px').attr('height',svg_h+'px');
		
		mNodeInfo = new Map();
		mNodeObj = new Map();
		mEdgeInfo = new Map();
		mEdgeObj = new Map();
		
		$('g.node').each(function(){
			var nodeInfo = $.parseJSON($(this).attr('id'));
			
			mNodeInfo.put(nodeInfo.id,nodeInfo);
			mNodeObj.put(nodeInfo.id,$(this));
			$(this).data('node_id',nodeInfo.id);
			
			$(this).find('rect').css({'fill':'url(#tag_'+nodeInfo.status+')'});
		});
		$('g.edgePath').each(function(){
			var edgeInfo = $.parseJSON($(this).attr('id'));
			
			mEdgeInfo.put(edgeInfo.id,edgeInfo);
			mEdgeObj.put(edgeInfo.id,$(this));
			$(this).data('edge_id',edgeInfo.id);
		});
		
		//event
		$('g.node').unbind('click').bind("click",function(e){
			var node_id = $(this).data('node_id');
			var nodeInfo = mNodeInfo.get(node_id);
			var nodeObj = mNodeObj.get(node_id);
			
			var _node_id = $('#ly_svg').data('_node_id');
			if(_node_id!=null){
				var _nodeObj = mNodeObj.get(_node_id);
				_nodeObj.find('rect').attr('class',$('#ly_svg').data('_c_rect'));
			}
			
			$('#ly_svg').data('_node_id',node_id);
			$('#ly_svg').data('_c_rect',nodeObj.find('rect').attr('class'));
			nodeObj.find('rect').attr('class','rect_sel');
		});
		$('g.node').unbind('contextmenu').bind("contextmenu",function(e){
			e.preventDefault();
			$('#ly_ContextMenu_02').hide(0,function(){_initPreSelEdge();});
			$( "#ly_ContextMenu_01" ).menu().show().position({my: "left top",at: "center",of: e,collision: "fit" });
			
			var node_id = $(this).data('node_id');
			var nodeInfo = mNodeInfo.get(node_id);
			var nodeObj = mNodeObj.get(node_id);
			$( "#contextMenu_01_01" ).data('node_id',node_id);
			$( "#contextMenu_01_02" ).data('node_id',node_id);
			$( "#contextMenu_01_03" ).data('node_id',node_id);
			$( "#contextMenu_01_04" ).data('node_id',node_id);
			$( "#contextMenu_01_05" ).data('node_id',node_id);
			$( "#contextMenu_01_06" ).data('node_id',node_id);
			$( "#contextMenu_01_07" ).data('node_id',node_id);
			$( "#contextMenu_01_08" ).data('node_id',node_id);
			$( "#contextMenu_01_09" ).data('node_id',node_id);
			$( "#contextMenu_01_10" ).data('node_id',node_id);
			$( "#contextMenu_01_11" ).data('node_id',node_id);
			$( "#contextMenu_01_12" ).data('node_id',node_id);
			$( "#contextMenu_01_13" ).data('node_id',node_id);
			
			var _node_id = $('#ly_svg').data('_node_id');
			var _nodeInfo = mNodeInfo.get(_node_id);
			var _nodeObj = mNodeObj.get(_node_id);
			if(_node_id!=null && node_id != _node_id ){
				$('#contextMenu_01_04').removeClass('ui-state-disabled');
				$('#contextMenu_01_04 a').html("[ "+_nodeInfo.job_name+"---->"+nodeInfo.job_name+" ] 연결");
				$('#contextMenu_01_05').removeClass('ui-state-disabled');
				$('#contextMenu_01_05 a').html("[ "+nodeInfo.job_name+"<----"+_nodeInfo.job_name+" ] 연결");
			}else{
				$('#contextMenu_01_04').addClass('ui-state-disabled');
				$('#contextMenu_01_04 a').html("연결");
				$('#contextMenu_01_05').addClass('ui-state-disabled');
				$('#contextMenu_01_05 a').html("연결");
			}
			
		});
		
		$('g.edgePath').unbind('contextmenu').bind("contextmenu",function(e){
			e.preventDefault();
			$('#ly_ContextMenu_01').hide();
			$( "#ly_ContextMenu_02" ).menu().show().position({my: "left top",at: "center",of: e,collision: "fit" });
			
			var edge_id = $(this).data('edge_id');
			var edgeInfo = mEdgeInfo.get(edge_id);
			var edgeObj = mEdgeObj.get(edge_id);
			$( "#contextMenu_02_01" ).data('edge_id',edge_id);
			
			_initPreSelEdge();
			
			$('#ly_svg').data('_edge_id',edge_id);
			$('#ly_svg').data('_c_path',edgeObj.find('path').attr('class'));
			$('#ly_svg').data('_c_marker',edgeObj.find('marker').attr('class'));
			edgeObj.find('path').attr('class','edge_sel');
			edgeObj.find('marker').attr('class','marker_sel');
			if(mNodeInfo.get(edgeInfo.s).status!='Ended_OK'){
				edgeObj.find('path').attr('class','edge_dash_sel');
			}
		});		
	}

	var mJob = new Map();

	var order_id 	= "<%=order_id%>";
	var gubun 		= "<%=gubun%>";

	// 실시간 작업이면 order_id 있고, Define 작업이면 order_id 없음.
	if ( gubun == "group" ) {
		getJobGraphGroup(); 
	} else if ( order_id == "" ) {
		getJobGraphDef();		
	} else {
		getJobGraph();
	}

	// 실시간 작업
	function getJobGraph() {
		
		var url = '<%=sContextPath %>/mPopup.ez?c=ez002_d3_xml&searchType=jobGraphList';

		try{viewProgBar(true);}catch(e){}
		var xhr = new XHRHandler( url, f_s
				,function(){
					var xmlDoc = this.req.responseXML;
					if(xmlDoc==null){
						alert('세션이 만료되었습니다 다시 로그인해 주세요');
						return false;
					}
					
					$(xmlDoc).find('doc').each(function(){
						
						var items = $(this).find('items');
						
						items.find('node').each(function(i){
							var order_id = $(this).find('order_id').text();
							var job_name = $(this).find('job_name').text();
							var status = $(this).find('status').text();
							
							g.setNode(order_id,  { id:'{"id":"'+order_id+'","job_name":"'+job_name+'","status":"'+status+'"}'
								, label: job_name+"\n--------------\n"+status, width:150, height:30 });
						});
						
						items.find('edge').each(function(i){
							var s = $(this).find('s').text();
							var t = $(this).find('t').text();
							var status = $(this).find('status').text();
							
							g.setEdge(s, t, { id:'{"id":"'+s+'-'+t+'","s":"'+s+'","t":"'+t+'"}'
								, label: status }   );
						});
					});
					
					initRender();
					initNodeStyle();
					initEdgeStyle();
					
					try{viewProgBar(false);}catch(e){}
				}
		, null );
		
		xhr.sendRequest();
	}

	// DEF 작업
	function getJobGraphDef() {

		var url = '<%=sContextPath %>/mPopup.ez?c=ez012_d3_xml&searchType=jobGraphList';

		try{viewProgBar(true);}catch(e){}
		
		var xhr = new XHRHandler( url, f_s
				,function(){
					var xmlDoc = this.req.responseXML;
					if(xmlDoc==null){
						alert('세션이 만료되었습니다 다시 로그인해 주세요');
						return false;
					}
					$(xmlDoc).find('doc').each(function(){
						
						var items = $(this).find('items');
						
						items.find('node').each(function(i){
							var order_id	= $(this).find('order_id').text();
							var job_name 	= $(this).find('job_name').text();
							var status 		= $(this).find('status').text();
							
							g.setNode(order_id,  { id:'{"id":"'+order_id+'","job_name":"'+job_name+'","status":"'+status+'"}'
								, label: job_name+"\n--------------\n"+status, width:150, height:30 });
						});
						
						items.find('edge').each(function(i){
							var s = $(this).find('s').text();
							var t = $(this).find('t').text();
							var status = $(this).find('status').text();
							
							g.setEdge(s, t, { id:'{"id":"'+s+'-'+t+'","s":"'+s+'","t":"'+t+'"}'
								, label: status }   );
						});
					});
					
					initRender();
					initNodeStyle();
					initEdgeStyle();
					
					try{viewProgBar(false);}catch(e){}
				}
		, null );
		
		xhr.sendRequest();
	}

	// 그룹 작업
	function getJobGraphGroup() {

		var url = '<%=sContextPath %>/mPopup.ez?c=ez015_d3_xml&searchType=jobGraphList';

		try{viewProgBar(true);}catch(e){}
		
		var xhr = new XHRHandler( url, f_s
				,function(){
					var xmlDoc = this.req.responseXML;
					if(xmlDoc==null){
						alert('세션이 만료되었습니다 다시 로그인해 주세요');
						return false;
					}
					$(xmlDoc).find('doc').each(function(){
						
						var items = $(this).find('items');
						
						items.find('node').each(function(i){
							var order_id = $(this).find('order_id').text();
							var job_name = $(this).find('job_name').text();
							var status = $(this).find('status').text();
							
							g.setNode(order_id,  { id:'{"id":"'+order_id+'","job_name":"'+job_name+'","status":"'+status+'"}'
								, label: job_name+"\n--------------\n"+status, width:150, height:30 });
						});
						
						items.find('edge').each(function(i){
							var s = $(this).find('s').text();
							var t = $(this).find('t').text();
							var status = $(this).find('status').text();
							
							g.setEdge(s, t, { id:'{"id":"'+s+'-'+t+'","s":"'+s+'","t":"'+t+'"}'
								, label: status }   );
						});
					});
					
					initRender();
					initNodeStyle();
					initEdgeStyle();
					
					try{viewProgBar(false);}catch(e){}
				}
		, null );
		
		xhr.sendRequest();
	}
	
	$( document ).click(function(){
		$('#ly_ContextMenu_01').hide();
		$('#ly_ContextMenu_02').hide(0,function(){_initPreSelEdge();});
		$( document ).tooltip( "enable" );
	}).contextmenu(function(){
		$( document ).tooltip( "enable" );
	});
	
	$( document ).tooltip({
		track: true
		,content: function() {
	    	return $(this).attr('title').replace(/\n/g, '<br />');
		}
	});
	
	$('#contextMenu_01_01').click(function(){
		var node_id = $(this).data('node_id');
		var nodeInfo = mNodeInfo.get(node_id);
		var nodeObj = mNodeObj.get(node_id);
		
		initNodeStyle();
		initEdgeStyle();
		viewInOutCondEdge(nodeInfo.id);
		
		nodeObj.find('rect').attr('class','rect_point');
		$('#ly_svg').data('_cond_gb','01');
		$('#ly_svg').data('_cond_node_id',node_id);
	});
	$('#contextMenu_01_02').click(function(){
		var node_id = $(this).data('node_id');
		var nodeInfo = mNodeInfo.get(node_id);
		var nodeObj = mNodeObj.get(node_id);
		
		initNodeStyle();
		initEdgeStyle();
		viewInCondEdge(nodeInfo.id);
		
		nodeObj.find('rect').attr('class','rect_point');
		$('#ly_svg').data('_cond_gb','02');
		$('#ly_svg').data('_cond_node_id',node_id);
	});
	$('#contextMenu_01_03').click(function(){
		var node_id = $(this).data('node_id');
		var nodeInfo = mNodeInfo.get(node_id);
		var nodeObj = mNodeObj.get(node_id);
		
		initNodeStyle();
		initEdgeStyle();
		viewOutCondEdge(nodeInfo.id);
		
		nodeObj.find('rect').attr('class','rect_point');
		$('#ly_svg').data('_cond_gb','03');
		$('#ly_svg').data('_cond_node_id',node_id);
	});
	$('#contextMenu_01_04').addClass('ui-state-disabled');
	$('#contextMenu_01_04 a').html("연결");
	$('#contextMenu_01_04').click(function(){
		var node_id = $(this).data('node_id');
		var nodeInfo = mNodeInfo.get(node_id);
		var nodeObj = mNodeObj.get(node_id);
		
		var _node_id = $('#ly_svg').data('_node_id');
		var _nodeInfo = mNodeInfo.get(_node_id);
		var _nodeObj = mNodeObj.get(_node_id);
		if(_node_id!=null && node_id != _node_id ){
			addEdge(_node_id, node_id);
		}
	});
	$('#contextMenu_01_05').addClass('ui-state-disabled');
	$('#contextMenu_01_05 a').html("연결");
	$('#contextMenu_01_05').click(function(){
		var node_id = $(this).data('node_id');
		var nodeInfo = mNodeInfo.get(node_id);
		var nodeObj = mNodeObj.get(node_id);
		
		var _node_id = $('#ly_svg').data('_node_id');
		var _nodeInfo = mNodeInfo.get(_node_id);
		var _nodeObj = mNodeObj.get(_node_id);
		if(_node_id!=null && node_id != _node_id ){
			addEdge(node_id, _node_id);
		}
	});
	$('#contextMenu_01_06').click(function(){
		
		var node_id 	= $(this).data('node_id');
		
		var nodeInfo 	= mNodeInfo.get(node_id);
		var nodeObj 	= mNodeObj.get(node_id);

		var order_id = "<%=order_id%>";

		// 실시간 작업이면 order_id 있고, Define 작업이면 order_id 없음. 
		if ( order_id == "" ) {
			popupDefJobDetail(node_id, nodeInfo.job_name);
		} else {
			popupAjobInfo(node_id);
		}
		
		
	});
	
	$('#contextMenu_01_07').click(function(){
		var node_id = $(this).data('node_id');
		var nodeInfo = mNodeInfo.get(node_id);
		var nodeObj = mNodeObj.get(node_id);
		
		popupJobDetail(node_id,nodeInfo.job_name);
	});
	
	$('#contextMenu_01_08').click(function(){
		var node_id = $(this).data('node_id');
		var nodeInfo = mNodeInfo.get(node_id);
		var nodeObj = mNodeObj.get(node_id);
		
		popupTimeInfo(nodeInfo.job_name,nodeInfo.job_name);
	});
	$('#contextMenu_01_09').click(function(){
		var node_id = $(this).data('node_id');
		var nodeInfo = mNodeInfo.get(node_id);
		var nodeObj = mNodeObj.get(node_id);
		
		popupCmLog(node_id);
	});
	$('#contextMenu_01_10').click(function(){
		var node_id = $(this).data('node_id');
		var nodeInfo = mNodeInfo.get(node_id);
		var nodeObj = mNodeObj.get(node_id);
		
		popupCtmWhy(node_id);
	});
	$('#contextMenu_01_11').click(function(){
		var node_id = $(this).data('node_id');
		var nodeInfo = mNodeInfo.get(node_id);
		var nodeObj = mNodeObj.get(node_id);
		
		popupSysoutLocal(node_id);
	});
	$('#contextMenu_01_12').click(function(){
		var node_id = $(this).data('node_id');
		var nodeInfo = mNodeInfo.get(node_id);
		var nodeObj = mNodeObj.get(node_id);
		
		actHold(node_id);
	});
	$('#contextMenu_01_13').click(function(){
		var node_id = $(this).data('node_id');
		var nodeInfo = mNodeInfo.get(node_id);
		var nodeObj = mNodeObj.get(node_id);
		
		actFree(node_id);
	});
	
	$('#contextMenu_02_01').click(function(){
		var edge_id = $(this).data('edge_id');
		var edgeInfo = mEdgeInfo.get(edge_id);
		
		removeEdge(edgeInfo.s, edgeInfo.t);
	});
	
	function addEdge(s,t){
		g.setEdge(s, t, { id:'{"id":"'+s+'-'+t+'","s":"'+s+'","t":"'+t+'"}'
			, label: "" } );
		
		initRender();
		initNodeStyle();
		initEdgeStyle();
		_initCond();
	}
	function removeEdge(s,t){
		g.removeEdge(s, t);
		
		initRender();
		initNodeStyle();
		initEdgeStyle();
		_initCond();
	}
	
	function _initPreSelEdge(){
		var _edge_id = $('#ly_svg').data('_edge_id');
		var _edgeObj = mEdgeObj.get(_edge_id);
		var _edgeInfo = mEdgeInfo.get(_edge_id);
		if(_edge_id!=null){
			_edgeObj.find('path').attr('class',$('#ly_svg').data('_c_path'));
			_edgeObj.find('marker').attr('class',$('#ly_svg').data('_c_marker'));
		}
	}
	
	function _initCond(){
		var _cond_gb = $('#ly_svg').data('_cond_gb');
		if(_cond_gb != null){
			var node_id = $('#ly_svg').data('_cond_node_id');
			var nodeInfo = mNodeInfo.get(node_id);
			var nodeObj = mNodeObj.get(node_id);
			
			if(_cond_gb=='01') viewInOutCondEdge(nodeInfo.id);
			else if(_cond_gb=='02') viewInCondEdge(nodeInfo.id);
			else if(_cond_gb=='03') viewOutCondEdge(nodeInfo.id);
			
			nodeObj.find('rect').attr('class','rect_point');
		}
		
	}
	
	function initNodeStyle(){
		$('#ly_svg').data('_node_id',null);
		$('g.node').each(function(i){
			var nodeObj = $(this);
			
			nodeObj.find('rect').attr('class','rect_default');
		});
	}
	function initEdgeStyle(){
		$('#ly_svg').data('_edge_id',null);
		$('g.edgePath').each(function(i){
			var edgeObj = $(this);
			var edge_id = edgeObj.data('edge_id');
			var edgeInfo = mEdgeInfo.get(edge_id);
			
			edgeObj.find('path').attr('class','edge_default');
			edgeObj.find('marker').attr('class','marker_default');
			
			if(mNodeInfo.get(edgeInfo.s).status!='Ended_OK'){
				edgeObj.find('path').attr('class','edge_dash_default');
			}
		});
	}	
	
	function viewInOutCondEdge(id) {
		viewInCondEdge(id);
		viewOutCondEdge(id);
	}
	function viewInCondEdge(id){
		$('g.edgePath').each(function(i){
			var edgeObj = $(this);
			var edge_id = edgeObj.data('edge_id');
			var edgeInfo = mEdgeInfo.get(edge_id);
			
			if( edgeObj.find('marker').attr('class')!='marker_cond' ){
				if( edgeInfo.t==id){
					edgeObj.find('path').attr('class','edge_cond');
					edgeObj.find('marker').attr('class','marker_cond');
					
					if(mNodeInfo.get(edgeInfo.s).status!='Ended_OK'){
						edgeObj.find('path').attr('class','edge_dash_cond');
					}
					viewInCondEdge(edgeInfo.s);
				}
			}
		});
	}
	function viewOutCondEdge(id){
		$('g.edgePath').each(function(i){
			var edgeObj = $(this);
			var edge_id = edgeObj.data('edge_id');
			var edgeInfo = mEdgeInfo.get(edge_id);
			
			if( edgeObj.find('marker').attr('class')!='marker_cond' ){
				if( edgeInfo.s==id){
					edgeObj.find('path').attr('class','edge_cond');
					edgeObj.find('marker').attr('class','marker_cond');
					
					if(mNodeInfo.get(edgeInfo.s).status!='Ended_OK'){
						edgeObj.find('path').attr('class','edge_dash_cond');
					}
					viewOutCondEdge(edgeInfo.t);
				}
			}
		});
	}
	
	
	
	
	
	

	function popupAjobInfo(order_id) {
		
		var frm = document.frm4;

		frm.order_id.value = order_id;

		openPopupCenter("about:blank","popupAjobInfo", 1000, 820);
		
		frm.action = "<%=sContextPath %>/tPopup.ez?c=ez033";
		frm.target = "popupAjobInfo";
		frm.submit();
	}

	function popupDefJobDetail(node_id, job_name) {

		var frm = document.frm4;

		frm.table_id.value 	= node_id.split("/")[0];
		frm.job_id.value 	= node_id.split("/")[1];
		frm.job_name.value 	= job_name;
		
		openPopup("about:blank","popupDefJobDetail", 1200, 800);
		
		frm.action = "<%=sContextPath %>/mPopup.ez?c=ez011&gubun=graph";
		frm.target = "popupDefJobDetail";
		frm.submit();
	}
	

	function popupJobDetail(order_id,job){
		var frm = document.frm4;
		
		frm.order_id.value = order_id;
		frm.job.value = job;
		
		frm.action = "<%=sContextPath %>/mPopup.ez?c=ez004&gb=01";
		frm.target = "mainFrame";
		frm.submit();
	}
	
	function popupTimeInfo(job_name,memname){
		var frm = document.frm4;
		frm.job_name.value = job_name;
		frm.memname.value = memname;
		
		frm.action = "<%=sContextPath %>/mPopup.ez?c=ez003";
		frm.target = "mainFrame";
		frm.submit();
	}
	
	
	function popupCmLog(order_id){
		var frm = document.frm4;
		
		frm.order_id.value = order_id;

		frm.action = "<%=sContextPath %>/mPopup.ez?c=ez006";
		frm.target = "bFrame";
		frm.submit();
	}
	
	function popupCtmWhy(order_id){
		var frm = document.frm4;
		
		frm.order_id.value = order_id;
		
		frm.action = "<%=sContextPath %>/mPopup.ez?c=ez008";
		frm.target = "bFrame";
		frm.submit();
	}
	
	function popupSysoutLocal(order_id) {
		
		var frm = document.frm4;
		
		frm.order_id.value		 	= order_id;
		frm.total_rerun_count.value	= 1;
		
		frm.action = "<%=sContextPath %>/mPopup.ez?c=ez007_local";
		frm.target = "bFrame";
		frm.submit();
	}
	
	function actHold(order_id) {

		var frm = document.frm4;
		
		frm.flag.value = "HOLD";
		frm.order_id.value = order_id;

		if( !confirm("HOLD 상태로 변경하시겠습니까?") ) return;

		try{viewProgBar(true);}catch(e){}
		frm.action = "<%=sContextPath %>/tWorks.ez?c=ez009_p&gb=d3";
		frm.target = "prcFrame1";
		frm.submit();
	}
	function actFree(order_id) {

		var frm = document.frm4;
		
		frm.flag.value = "FREE";
		frm.order_id.value = order_id;

		if( !confirm("FREE 상태로 변경하시겠습니까?") ) return;

		try{viewProgBar(true);}catch(e){}
		frm.action = "<%=sContextPath %>/tWorks.ez?c=ez009_p&gb=d3";
		frm.target = "prcFrame1";
		frm.submit();
	}
	
	function goPage(){
		var frm = document.frm4;
		frm.submit();
	}
</script>

<iframe name="prcFrame1" src="" width="0" height="0" frameborder="0" ></iframe>
</body>
</html>



