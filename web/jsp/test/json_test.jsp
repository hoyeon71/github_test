<%@page import="java.net.URLEncoder"%>
<%@page import="java.util.LinkedHashMap"%>
<%@page import="java.util.Map"%>
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

	String json_string = "{\"success\":true,\"code\":\"0000\",\"message\":\"OK\",\"response\":null}";

	out.println("json_string : " + json_string);
	out.println("<br>");
	out.println("<br>");

	JsonParser jsonParser = new JsonParser();
	JsonObject object = (JsonObject) jsonParser.parse(json_string);
	
	String success = CommonUtil.isNull(object.get("success").getAsString());

	out.println("success : " + success);
	out.println("<br>");
	
	
	/*
	JsonArray jsonArray = (JsonArray) jsonParser.parse(json_string);

	for (int i = 0; i < jsonArray.size(); i++) {

		JsonObject object = (JsonObject) jsonArray.get(i);

		String success = CommonUtil.isNull(object.get("success").getAsString());

		out.println("success : " + success);
		out.println("<br>");
	}
	*/
%>
