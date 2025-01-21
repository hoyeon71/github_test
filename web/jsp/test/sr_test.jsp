<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@page import="java.io.FileReader"%>
<%@page import="java.io.File"%>
<%@page import="com.ghayoun.ezjobs.common.util.CommonUtil"%>
<%@page import="com.google.gson.JsonObject"%>
<%@page import="com.google.gson.JsonArray"%>
<%@page import="com.google.gson.JsonParser"%>
<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URL"%>
<%
	/*
	String strHrDeptUrl = CommonUtil.isNull(CommonUtil.getMessage("HR_DEPT_URL"));
	
	URL obj = new URL(strHrDeptUrl + "?baseYmd=" + DateUtil.getDay(0));
	HttpURLConnection conn = (HttpURLConnection) obj.openConnection();
	
	conn.setRequestMethod("GET");
	conn.setDoOutput(true);
	
	BufferedReader br 	= null;
	
	br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
	
	String line 		= "";
	
	while ((line = br.readLine()) != null) {				
		json_string = line;
	}
	*/

	int iCnt	 		= 0;
	String json_string 	= "";

	File file 				= new File("D:\\project\\EZJOBS\\workspace\\EZJOBS_TOSS\\web\\sr.txt");
	FileReader filereader 	= new FileReader(file);
	
	while((iCnt = filereader.read()) != -1){
	    json_string += (char)iCnt;
	}
	
	
	JsonParser jsonParser 	= new JsonParser();
	JsonObject jsonObject 	= (JsonObject) jsonParser.parse(json_string);
	JsonArray jsonArray 	= jsonObject.getAsJsonArray("srItem");
	
	for (int i = 0; i < jsonArray.size(); i++) {
		
		JsonObject object = (JsonObject) jsonArray.get(i);
		
		String prco_state 	= CommonUtil.isNull(object.get("prco_state").getAsString());
		String req_dt 		= CommonUtil.isNull(object.get("req_dt").getAsString());
		String req_type 	= CommonUtil.isNull(object.get("req_type").getAsString());
		String req_user_nm 	= CommonUtil.isNull(object.get("req_user_nm").getAsString());
		String req_user_id 	= CommonUtil.isNull(object.get("req_user_id").getAsString());
		String sr_id 		= CommonUtil.isNull(object.get("sr_id").getAsString());
		String title 		= CommonUtil.isNull(object.get("title").getAsString());
		String work_state 	= CommonUtil.isNull(object.get("work_state").getAsString());

		out.println("prco_state : " + prco_state);
		out.println("<br>"); 
		out.println("req_dt : " + req_dt);
		out.println("<br>");
		out.println("req_type : " + req_type);
		out.println("<br>");
		out.println("req_user_nm : " + req_user_nm);
		out.println("<br>");
		out.println("req_user_id : " + req_user_id);
		out.println("<br>");
		out.println("sr_id : " + sr_id);
		out.println("<br>");
		out.println("title : " + title);
		out.println("<br>");
		out.println("work_state : " + work_state);
		out.println("<br>");
		out.println("<br>");
	}

%>