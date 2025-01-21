package com.ghayoun.ezjobs.common.util;
import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.ConnectException;
import java.net.HttpURLConnection;
import java.net.Socket;
import java.net.URL;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.LinkedHashMap;
import java.util.Map;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

public class KakaoWork {

	public static String sendKakaowork(String strHookId, String strTitle, String strContent) throws Exception {
		
		String strKaKaoWorkUrl 	= CommonUtil.isNull(CommonUtil.getMessage("KAKAOWORK.URL"));
		String strHookUrl 		= CommonUtil.isNull(CommonUtil.getMessage("HOOK.URL"));
		
		System.out.println("strKaKaoWorkUrl : " + strKaKaoWorkUrl);
		System.out.println("strHookUrl : " + strHookUrl);
		
		System.out.println("strHookId : " + strHookId);
		System.out.println("strTitle : " + strTitle);
		System.out.println("strContent : " + strContent);
		
		URL url = new URL(strKaKaoWorkUrl); // 호출할 url

		System.out.println("CALL URL : " + strKaKaoWorkUrl);

		Map<String,Object> params = new LinkedHashMap(); // 파라미터 세팅
		
		params.put("to", 	strHookUrl + strHookId);
		params.put("msg", 	strTitle + "\n\n" + strContent);
		
		System.out.println("params : " + params);

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

			System.out.println("PARAMETER : " + postTempData);
		}

		byte[] postDataBytes = postData.toString().getBytes("UTF-8");

		HttpURLConnection conn = (HttpURLConnection)url.openConnection();
		conn.setRequestMethod("POST");
		conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
		conn.setRequestProperty("Content-Length", String.valueOf(postDataBytes.length));
		conn.setDoOutput(true);
		conn.getOutputStream().write(postDataBytes); // POST 호출

		BufferedReader br = null;

		br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));

		String line 		= "";
		String json_string 	= "";

		while ((line = br.readLine()) != null) {
			json_string = line;
		}

		System.out.println("json_string : " + json_string);

		JsonParser jsonParser 	= new JsonParser();
		JsonObject object 		= (JsonObject) jsonParser.parse(json_string);
		
		String strSendResult = CommonUtil.isNull(object.get("success").getAsString());
		System.out.println("strSendResult : " + strSendResult);
		
		/*
		JsonArray jsonArray = (JsonArray) jsonParser.parse(json_string);
		
		String strSendResult = "";

		for (int i = 0; i < jsonArray.size(); i++) {

			JsonObject object = (JsonObject) jsonArray.get(i);

			strSendResult = CommonUtil.isNull(object.get("success").getAsString());

			System.out.println("strSendResult : " + strSendResult);
		}
		*/
		
		return strSendResult;
	}

	public static String sendEmail(String strToMail, String strTitle, String strContent) throws Exception {
		
		System.out.println("kakao approval mail start.......................");
		System.out.println("strToMail : " + strToMail);
		System.out.println("strTitle : " + strTitle);
		System.out.println("strContent : " + strContent);
		
		String strEmailUrl = CommonUtil.isNull(CommonUtil.getMessage("EMAIL.URL"));
		
		URL url = new URL(strEmailUrl); // 호출할 url

		System.out.println("CALL URL : " + strEmailUrl);

		Map<String,Object> params = new LinkedHashMap(); // 파라미터 세팅
		
		int idx = strToMail.indexOf("@");
		String strToMailadd = strToMail.substring(0, idx);
		
		params.put("to", 	strToMailadd);
		params.put("msg", 	strTitle + "<br><br>" + strContent);

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

			System.out.println("PARAMETER : " + postTempData);
		}

		byte[] postDataBytes = postData.toString().getBytes("UTF-8");

		HttpURLConnection conn = (HttpURLConnection)url.openConnection();
		conn.setRequestMethod("POST");
		conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
		conn.setRequestProperty("Content-Length", String.valueOf(postDataBytes.length));
		conn.setDoOutput(true);
		conn.getOutputStream().write(postDataBytes); // POST 호출

		BufferedReader br = null;

		br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));

		String line 		= "";
		String json_string 	= "";

		while ((line = br.readLine()) != null) {
			json_string = line;
		}

		System.out.println("json_string : " + json_string);

		JsonParser jsonParser 	= new JsonParser();
		JsonObject object 		= (JsonObject) jsonParser.parse(json_string);
		
		String strSendResult = CommonUtil.isNull(object.get("success").getAsString());
		System.out.println("strSendResult : " + strSendResult);
		
		/*
		JsonArray jsonArray = (JsonArray) jsonParser.parse(json_string);
		
		String strSendResult = "";

		for (int i = 0; i < jsonArray.size(); i++) {

			JsonObject object = (JsonObject) jsonArray.get(i);

			strSendResult = CommonUtil.isNull(object.get("success").getAsString());

			System.out.println("strSendResult : " + strSendResult);
		}
		*/
		
		return strSendResult;
	}
}