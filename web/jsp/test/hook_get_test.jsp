<%@page import="com.ghayoun.ezjobs.common.util.DateUtil"%>
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

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	String strKaKaoWorkUrl 	= "http://api.noti.daumkakao.io/send/group/kakaowork";
	String strHookUrl 		= "https://kakaowork.com/bots/hook/";
	String strHookId		= "mxwf8r8mchyy";
	String strHookMsg		= "테스트, TEST, 12345";
	
	try {
	
		URL obj = new URL(strKaKaoWorkUrl + "?to=" + strHookUrl + strHookId + "&msg=" + strHookMsg);
		HttpURLConnection conn = (HttpURLConnection) obj.openConnection();
		
		out.println("CALL URL : " + strKaKaoWorkUrl + "?to=" + strHookUrl + strHookId + "&msg=" + strHookMsg);
		out.println("<br>");
		out.println("<br>");
	
		conn.setRequestMethod("GET");
		conn.setDoOutput(true);
	
		BufferedReader br = null;
	
		br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
		
		String line 		= "";
		String json_string 	= "";
		
		while ((line = br.readLine()) != null) {
			json_string = line;
		}
		
		out.println("json_string : " + json_string);
		out.println("<br>");
		out.println("<br>");
		
		JsonParser jsonParser = new JsonParser();
		JsonArray jsonArray = (JsonArray) jsonParser.parse(json_string);
		
		/* for (int i = 0; i < jsonArray.size(); i++) {
			
			JsonObject object = (JsonObject) jsonArray.get(i);
			
			String org_cd 		= CommonUtil.isNull(object.get("org_cd").getAsString());
			String org_nm 		= CommonUtil.isNull(object.get("org_nm").getAsString());
			String org_nm_eng 	= CommonUtil.isNull(object.get("org_nm_eng").getAsString());
			String bos_emp_no 	= CommonUtil.isNull(object.get("boss_emp_no").getAsString());
	
			out.println("org_cd : " + org_cd);
			out.println("<br>");
			out.println("org_nm : " + org_nm);
			out.println("<br>");
			out.println("org_nm_eng : " + org_nm_eng);
			out.println("<br>");
			out.println("bos_emp_no : " + bos_emp_no);
			out.println("<br>");
		} */
		
	} catch (Exception e) {
		out.println(e.getMessage());
	}

%>