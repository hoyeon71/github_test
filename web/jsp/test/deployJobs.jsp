
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.util.LinkedHashMap"%>
<%@page import="java.util.Iterator"%>
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONArray"%>
<%@page import="com.ghayoun.ezjobs.common.util.AAPI_Util"%>
<%@page import="com.ghayoun.ezjobs.common.util.CommonUtil"%>
<%@page import="java.util.Hashtable"%>
<%@page import="javax.naming.Context"%>
<%@page import="javax.naming.NamingException"%>
<%@page import="javax.naming.directory.Attributes"%>
<%@page import="javax.naming.directory.SearchResult"%>
<%@page import="javax.naming.NamingEnumeration"%>
<%@page import="javax.naming.directory.SearchControls"%>
<%@page import="javax.naming.directory.InitialDirContext"%>
<%@page import="javax.naming.directory.DirContext"%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	String AAPI_URL 	= CommonUtil.isNull(CommonUtil.getMessage("AAPI_URL."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
	
	String strCtm		= "ctm921";						// CTM
	String strFolder	= "SGI_ASIS_GBIDMDUMDN001";		// FOLDER
	String strJob		= "SGI_ASIS_BIMBCSTART001";		// JOBNAME
	
	String REST_URL		= AAPI_URL + "/deploy/jobs?format=json&folder=" + strFolder + "&job=" + strJob + "&server=" + strCtm;

	String deployGetJson = AAPI_Util.restApiDeployGet(AAPI_URL, REST_URL, "GET", strFolder);
	
	

	// 예시 JSON 배열 (동적으로 키가 추가되는 상황을 가정)
    String jsonArrayStr = "[{\"Job\": \"EZ_EXCEL_TEST_0926_001\", \"Type\": \"Job:Script\", \"DaysKeepActive\": \"7\", \"SubApplication\": \"D\", \"Priority\": \"Very Low\", \"FileName\": \"EZ_EXCEL_TEST_0926_001\", \"Host\": \"ctm921\", \"FilePath\": \"EZ_EXCEL_TEST_0926_001/\", \"CreatedBy\": \"admin\", \"Description\": \"EZ_EXCEL_TEST_0926_001\", \"RunAs\": \"emuser\", \"Application\": \"COM\", \"RerunLimit\": {\"Units\": \"Minutes\", \"Every\": \"0\"}, \"When\": {\"WeekDays\": [\"NONE\"], \"MonthDays\": [\"NONE\"], \"DaysRelation\": \"OR\", \"RuleBasedCalendars\": {}}, \"PathElement\": {\"Folder\": \"06_06H\", \"Server\": \"ctm921\"}, \"eventsToWaitFor\": {\"Type\": \"WaitForEvents\", \"Events\": [{\"Event\": \"EZ_EXCEL_TEST_9010_002-OK\"}]}, \"eventsToAdd\": {\"Type\": \"AddEvents\", \"Events\": [{\"Event\": \"EZ_EXCEL_TEST_0926_001-OK\"}]}}]";

    // JSONArray로 변환
    JSONArray jsonArray = new JSONArray(jsonArrayStr);

    // 첫 번째 JSONObject 가져오기
    JSONObject jsonObject = jsonArray.getJSONObject(0);

    //키를 동적으로 추출하여 순서를 유지하는 List 생성
    List<String> keyList = new ArrayList<>();
    Iterator<String> keys = jsonObject.keys();
    
    while (keys.hasNext()) {
        String key = keys.next();
        keyList.add(key);  // 키를 순서대로 리스트에 추가
    }

    // 추출된 키를 출력
    for (String key : keyList) {
        out.println("Key: " + key + "<br/>");
    }
	
%>