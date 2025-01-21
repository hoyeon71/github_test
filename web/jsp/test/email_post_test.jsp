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
	String strEmailUrl 		= "http://api.noti.daumkakao.io/send/group/email";
	String strMailFrom 		= "munch.kim";
	String strMailTo		= "re.team";
	String strMailMsg		= "테스트, TEST, 12345";
	
	URL url = new URL(strEmailUrl); // 호출할 url
	
	out.println("CALL URL : " + strEmailUrl);
    out.println("<br>");
    out.println("<br>");
	
	Map<String,Object> params = new LinkedHashMap<>(); // 파라미터 세팅
	
	params.put("from", 	strMailFrom);
   	params.put("to", 	strMailTo);
    params.put("msg", 	strMailMsg);

    StringBuilder postData = new StringBuilder();
    
    for(Map.Entry<String,Object> param : params.entrySet()) {
        if(postData.length() != 0) postData.append('&');
        
        StringBuilder postTempData = new StringBuilder();
        
        postData.append(URLEncoder.encode(param.getKey(), "UTF-8"));
        postData.append('=');
        postData.append(URLEncoder.encode(String.valueOf(param.getValue()), "UTF-8"));
        
        
        postTempData.append(URLEncoder.encode(param.getKey(), "UTF-8"));
        postTempData.append('=');
        postTempData.append(URLEncoder.encode(String.valueOf(param.getValue()), "UTF-8"));
        
        out.println("PARAMETER : " + postTempData);
    	out.println("<br>");
    }
    
    byte[] postDataBytes = postData.toString().getBytes("UTF-8");
    
    
    
    
    
	
   /*  HttpURLConnection conn = (HttpURLConnection)url.openConnection();
    conn.setRequestMethod("POST");
    conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
    conn.setRequestProperty("Content-Length", String.valueOf(postDataBytes.length));
    conn.setDoOutput(true);
    conn.getOutputStream().write(postDataBytes); // POST 호출

	conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
	conn.setRequestMethod("POST");
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
	JsonArray jsonArray = (JsonArray) jsonParser.parse(json_string); */
	
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

%>