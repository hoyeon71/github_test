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
	URL obj = new URL("https://nhrlove-api.navercorp.com/api/hrcommon/dept/ITGC_BATCH?baseYmd=20200601");
	HttpURLConnection conn = (HttpURLConnection) obj.openConnection();
	
	conn.setRequestMethod("GET");			
	conn.setDoOutput(true);
	
	//OutputStream out 	= conn.getOutputStream();
	BufferedReader br 	= null;
	
	//out.write("INTFID=" + ("UTMMR0040054").getBytes());
	
	br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
	
	String line 		= "";
	String json_string 	= "";
	
	while ((line = br.readLine()) != null) {
		//System.out.println("line :::::" + line);
		
		json_string = line;
	}
	
	System.out.println("json_string : " + json_string);
	
	JsonParser jsonParser = new JsonParser();
	JsonArray jsonArray = (JsonArray) jsonParser.parse(json_string);
	
	for (int i = 0; i < jsonArray.size(); i++) {
		
		JsonObject object = (JsonObject) jsonArray.get(i);
		
		String org_cd 		= CommonUtil.isNull(object.get("org_cd").getAsString());
		String org_nm 		= CommonUtil.isNull(object.get("org_nm").getAsString());
		String org_nm_eng 	= CommonUtil.isNull(object.get("org_nm_eng").getAsString());
		String bos_emp_no 	= CommonUtil.isNull(object.get("boss_emp_no").getAsString());

		System.out.println("org_cd : " + org_cd);
		System.out.println("org_nm : " + org_nm);
		System.out.println("org_nm_eng : " + org_nm_eng);
		System.out.println("bos_emp_no : " + bos_emp_no);
	}

%>