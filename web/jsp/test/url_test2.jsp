<%@page import="java.io.OutputStreamWriter"%>
<%@page import="java.security.KeyManagementException"%>
<%@page import="java.security.cert.X509Certificate"%>
<%@page import="javax.net.ssl.X509TrustManager"%>
<%@page import="javax.net.ssl.TrustManager"%>
<%@page import="javax.net.ssl.SSLSession"%>
<%@page import="javax.net.ssl.HostnameVerifier"%>
<%@page import="javax.net.ssl.HttpsURLConnection"%>
<%@page import="javax.net.ssl.SSLContext"%>
<%@page import="java.security.NoSuchAlgorithmException"%>
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

<%!
	private static void disableSslVerification() {
		
		try {
			
			TrustManager[] trustAllCerts = new TrustManager[] {new X509TrustManager() {
                public java.security.cert.X509Certificate[] getAcceptedIssuers() {
                    return null;
                }
                public void checkClientTrusted(X509Certificate[] certs, String authType) {
                }
                public void checkServerTrusted(X509Certificate[] certs, String authType) {
                }
            }
       	 	};
 
			// Install the all-trusting trust manager
	        SSLContext sc = SSLContext.getInstance("SSL");
	        sc.init(null, trustAllCerts, new java.security.SecureRandom());
	        HttpsURLConnection.setDefaultSSLSocketFactory(sc.getSocketFactory());
 
	        // Create all-trusting host name verifier
	        HostnameVerifier allHostsValid = new HostnameVerifier() {
	            public boolean verify(String hostname, SSLSession session) {
	                return true;
	            }
	        };
        
	     	// Install the all-trusting host verifier
	        HttpsURLConnection.setDefaultHostnameVerifier(allHostsValid);
     	
		} catch (NoSuchAlgorithmException e) {
			
		} catch (KeyManagementException e) {
			
		}
	
	}


%>

<%
	disableSslVerification();

	URL obj = new URL("https://ctmsvr9:8443/automation-api/session/login");
	HttpURLConnection conn = (HttpURLConnection) obj.openConnection();
	
	conn.setRequestProperty("Content-Type", "application/json");
	conn.setRequestMethod("POST");
	conn.setDoOutput(true);
	
	String params = "username=emuser&password=empass";
	
	//OutputStream out2 	= conn.getOutputStream();
	//out2.write(params);
	
	OutputStream op = conn.getOutputStream();
	op.write(params.getBytes());
	op.flush();
	
    int responseCode = conn.getResponseCode();
    System.out.println("Post parameters : " + params);
    System.out.println("Response Code : " + responseCode);
	
	BufferedReader br 	= null;
	
	br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
	
	String line 		= "";
	String json_string 	= "";
	
	while ((line = br.readLine()) != null) {
		//System.out.println("line :::::" + line);
		
		json_string = line;
	}
	
	//System.out.println("json_string : " + json_string);
	
	/*
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
	*/

%>