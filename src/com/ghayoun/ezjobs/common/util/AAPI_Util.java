package com.ghayoun.ezjobs.common.util;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.StringReader;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.net.InetAddress;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.UnknownHostException;
import java.security.KeyFactory;
import java.security.KeyManagementException;
import java.security.KeyPair;
import java.security.KeyPairGenerator;
import java.security.NoSuchAlgorithmException;
import java.security.PrivateKey;
import java.security.PublicKey;
import java.security.cert.CertificateException;
import java.security.spec.RSAPublicKeySpec;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.TreeSet;
import java.util.concurrent.Callable;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

import javax.crypto.Cipher;
import javax.net.ssl.HostnameVerifier;
import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLContext;
import javax.net.ssl.SSLSession;
import javax.net.ssl.TrustManager;
import javax.net.ssl.X509TrustManager;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBElement;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Marshaller;
import javax.xml.bind.Unmarshaller;
import javax.xml.parsers.DocumentBuilderFactory;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.web.context.ContextLoader;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.w3c.dom.Document;
import org.xml.sax.InputSource;
import com.bmc.ctmem.schema900.ErrorListType;
import com.bmc.ctmem.schema900.FaultOrderForceWithJobsType;
import com.bmc.ctmem.schema900.ResponseUserRegistrationType;
import com.ghayoun.ezjobs.comm.domain.CommonBean;
import com.ghayoun.ezjobs.comm.service.CommonService;
import com.ghayoun.ezjobs.t.domain.CompanyBean;
import com.ghayoun.ezjobs.t.domain.Doc01Bean;
import com.ghayoun.ezjobs.t.domain.DocInfoBean;
import com.ghayoun.ezjobs.t.domain.JobMapperBean;
import com.ghayoun.ezjobs.t.repository.WorksUserDao;
import com.ghayoun.ezjobs.t.service.WorksApprovalDocService;
import com.ghayoun.ezjobs.t.service.WorksCompanyService;
import com.ghayoun.ezjobs.t.service.WorksUserService;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.jcraft.jsch.Logger;

import net.sf.json.JSONArray;

@SuppressWarnings({ "unused", "unchecked" })
public class AAPI_Util {
	
	private static final Log logger = LogFactory.getLog(AAPI_Util.class);
	
	//선행조건(order)
	public static JsonObject getTconditionIn(String strTconditionIn) {
		
		JsonArray subInArray 		= new JsonArray();
		JsonObject eventsToWaitFor 	= new JsonObject();
		
		String[] aTmpT = strTconditionIn.split("[|]");
		
		eventsToWaitFor.addProperty("Type", "WaitForEvents");
		
		for ( int t = 0; null != aTmpT && t < aTmpT.length; t++ ) {
			
			JsonObject subIn = new JsonObject();
			String[] aTmpT1 = aTmpT[t].split(",",3);
			
			subIn.addProperty("Event", aTmpT1[0]);
			subIn.addProperty("Date", aTmpT1[1]);
			
			subInArray.add(subIn);
			
			// AND, OR값도 추가
			subInArray.add(aTmpT1[2].toUpperCase());
		}
		
		eventsToWaitFor.add("Events",subInArray);
		
		return eventsToWaitFor;
	}
	
	//후행조건
	public static JsonArray getTconditionOut(String strTconditionOut) {
		
		JsonArray subAddArray 		= new JsonArray();
		JsonArray subDeleteArray 	= new JsonArray();
		JsonArray subConditionOut 	= new JsonArray();
		
		String[] aTmpT = strTconditionOut.split("[|]");
		
		for ( int t = 0; null != aTmpT && t < aTmpT.length; t++ ) {
			String[] aTmpT1 = aTmpT[t].split(",",3);
			JsonObject subAdd = new JsonObject();
			JsonObject subDelete = new JsonObject();
			if(aTmpT1[2].equals("add")){
				subAdd.addProperty("Event", aTmpT1[0]);
				subAdd.addProperty("Date", aTmpT1[1]);
				
				subAddArray.add(subAdd);
			}else {
				subDelete.addProperty("Event", aTmpT1[0]);
				subDelete.addProperty("Date", aTmpT1[1]);
				
				subDeleteArray.add(subDelete);
			}
		}
		
		JsonObject eventsToAdd = new JsonObject();
		JsonObject eventsToDelete = new JsonObject();
		
		if(!subAddArray.toString().equals("[]"))		eventsToAdd.addProperty("Type", "AddEvents");
		if(!subAddArray.toString().equals("[]"))		eventsToAdd.add("Events",subAddArray);

		if(!subDeleteArray.toString().equals("[]"))		eventsToDelete.addProperty("Type", "DeleteEvents");
		if(!subDeleteArray.toString().equals("[]"))		eventsToDelete.add("Events",subDeleteArray);
		
		// JsonArray 에 2개를 담는다.
		subConditionOut.add(eventsToAdd);
		subConditionOut.add(eventsToDelete);
		
		return subConditionOut;
	}
	
	//변수(modify)
	public static JsonArray getTset(String strTset) {
		
		JsonArray  variables_array 	= new JsonArray ();
		
		String[] t_set 				= strTset.split("[|]");
		
		if ( !strTset.equals("") && t_set.length > 0 ) {
			for(int t = 0; t< t_set.length; t++ ) {
				JsonObject variable 	= new JsonObject();
				variable.addProperty( t_set[t].split(",")[0], t_set[t].split(",")[1]);
				variables_array.add(variable);
			}
		}
		return variables_array;
	}
	
	//변수(order)
	public static JsonArray getTsetOrder(String strTset) {

		JsonArray  variables_array 	= new JsonArray ();
		JsonObject variable 		= new JsonObject();
		String[] t_set 				= strTset.split("[|]");
		
		if ( !strTset.equals("/") && t_set.length > 0 ) {
			for(int i = 0; i< t_set.length; i++ ) {
				variable.addProperty( t_set[i].split("!")[0], t_set[i].split("!")[1]);
				variables_array.add(variable);
				variable = new JsonObject();
			}
		}
		return variables_array;
	}
	
	//변수(deploy)   
	public static org.json.simple.JSONArray getTsetDeploy(String strTset) {
		
		org.json.simple.JSONArray variable_array 	= new org.json.simple.JSONArray();
		
		String[] t_set 				= strTset.split("[|]");
		try {
			if ( !strTset.equals("") && t_set.length > 0 ) {
				for(int t = 0; t< t_set.length; t++ ) {
					JSONObject variable 		= new JSONObject();
					variable.put( t_set[t].split(",")[0], t_set[t].split(",")[1]);
					variable_array.add(variable);
				}
			}
		} catch (JSONException e) {
			e.printStackTrace();
		}
		return variable_array;
	}
	
	//resource(deploy)
	public static JSONObject getTresourceQ(String strTresourceQ) {

		JSONObject resource 		= new JSONObject();
		
		try {
			resource.put("Type", "Resource:Pool");
			resource.put("Quantity", strTresourceQ.split(",")[1]);
			
		} catch (JSONException e) {
			e.printStackTrace();
		}
		return resource;
	}
	
	//When(deploy)
	public static org.json.simple.JSONObject getTschedule(Map map) {

		Doc01Bean docBean			= (Doc01Bean)map.get("doc01");

		org.json.simple.JSONArray weekDay			= new org.json.simple.JSONArray();
		org.json.simple.JSONArray month				= new org.json.simple.JSONArray();
		org.json.simple.JSONArray monthDay			= new org.json.simple.JSONArray();
		org.json.simple.JSONObject when 			= new org.json.simple.JSONObject();
		
		String strMonth_1			= CommonUtil.isNull(docBean.getMonth_1(), "1");
		String strMonth_2			= CommonUtil.isNull(docBean.getMonth_2(), "1");
		String strMonth_3			= CommonUtil.isNull(docBean.getMonth_3(), "1");
		String strMonth_4			= CommonUtil.isNull(docBean.getMonth_4(), "1");
		String strMonth_5			= CommonUtil.isNull(docBean.getMonth_5(), "1");
		String strMonth_6			= CommonUtil.isNull(docBean.getMonth_6(), "1");
		String strMonth_7			= CommonUtil.isNull(docBean.getMonth_7(), "1");
		String strMonth_8			= CommonUtil.isNull(docBean.getMonth_8(), "1");
		String strMonth_9			= CommonUtil.isNull(docBean.getMonth_9(), "1");
		String strMonth_10			= CommonUtil.isNull(docBean.getMonth_10(), "1");
		String strMonth_11			= CommonUtil.isNull(docBean.getMonth_11(), "1");
		String strMonth_12			= CommonUtil.isNull(docBean.getMonth_12(), "1");
		String strWeekDays			= CommonUtil.isNull(docBean.getWeek_days());
		String strDaysCal			= CommonUtil.isNull(docBean.getDays_cal());
		String strWeeksCal			= CommonUtil.isNull(docBean.getWeeks_cal());
		String strTimeFrom			= CommonUtil.isNull(docBean.getTime_from());
		String strTimeUntil			= CommonUtil.replaceStrXml(CommonUtil.isNull(docBean.getTime_until()));
		String strMonthDays			= CommonUtil.isNull(docBean.getMonth_days());
		String strScheduleAndOr		= CommonUtil.isNull(docBean.getSchedule_and_or());

		//실행요일 체크
		if(!strWeekDays.equals("")) {
			for(int i=0;i<strWeekDays.split(",").length;i++) {
				if(strWeekDays.split(",")[i].equals("0")) weekDay.add("SUN");
				if(strWeekDays.split(",")[i].equals("1")) weekDay.add("MON");
				if(strWeekDays.split(",")[i].equals("2")) weekDay.add("TUE"); 
				if(strWeekDays.split(",")[i].equals("3")) weekDay.add("WED"); 
				if(strWeekDays.split(",")[i].equals("4")) weekDay.add("THU");
				if(strWeekDays.split(",")[i].equals("5")) weekDay.add("FRI"); 
				if(strWeekDays.split(",")[i].equals("6")) weekDay.add("SAT");
			}
			if(weekDay.size() > 0 && !weekDay.get(0).equals(""))	when.put("WeekDays", weekDay);
		}else {
			weekDay.add("NONE");
			when.put("WeekDays", weekDay);
		}

		//실행 월 체크
		if(strMonth_1.equals("1"))		month.add("JAN");
		if(strMonth_2.equals("1"))		month.add("FEB");
		if(strMonth_3.equals("1"))		month.add("MAR");
		if(strMonth_4.equals("1"))		month.add("APR");
		if(strMonth_5.equals("1"))		month.add("MAY");
		if(strMonth_6.equals("1"))		month.add("JUN");
		if(strMonth_7.equals("1"))		month.add("JUL");
		if(strMonth_8.equals("1"))		month.add("AUG");
		if(strMonth_9.equals("1"))		month.add("SEP");
		if(strMonth_10.equals("1"))		month.add("OCT");
		if(strMonth_11.equals("1"))		month.add("NOV");
		if(strMonth_12.equals("1"))		month.add("DEC");
		
		if(month.size() > 0 &&!month.get(0).equals(""))	when.put("Months", month);

		//실행 일 체크
		if(!strMonthDays.equals("") && !strMonthDays.equals("ALL")) {
			for(int i=0;i<strMonthDays.split(",").length;i++) {
				monthDay.add(strMonthDays.split(",")[i]);
			}

			if(monthDay.size() > 0 &&!monthDay.get(0).equals(""))	when.put("MonthDays", monthDay);
		}else if(strMonthDays.equals("ALL")) {
			monthDay.add(strMonthDays);
			when.put("MonthDays", monthDay);
		}else {
			monthDay.add("NONE");
			when.put("MonthDays", monthDay);
		}

		//그 외
		if(!strDaysCal.equals(""))  		when.put("MonthDaysCalendar", strDaysCal);
		if(!strWeeksCal.equals(""))  		when.put("WeekDaysCalendar", strWeeksCal);
		if(!strTimeUntil.equals(">"))  		when.put("ToTime", strTimeUntil);
		if(!strTimeFrom.equals(""))  		when.put("FromTime", strTimeFrom);
		if(strScheduleAndOr.equals("0")) 	when.put("DaysRelation", "OR");
		if(strScheduleAndOr.equals("1"))	when.put("DaysRelation", "AND");
		
		return when;
	}
	
	//선행조건(Deploy)
	public static org.json.simple.JSONObject getTconditionInDeploy(String strTconditionIn) {
		
		org.json.simple.JSONArray subInArray 		= new org.json.simple.JSONArray();
		org.json.simple.JSONObject eventsToWaitFor 	= new org.json.simple.JSONObject();
		
		String[] aTmpT = strTconditionIn.split("[|]");
		
		eventsToWaitFor.put("Type", "WaitForEvents");
		
		for ( int t = 0; null != aTmpT && t < aTmpT.length; t++ ) {
			
			org.json.simple.JSONObject subIn = new org.json.simple.JSONObject();
			String[] aTmpT1 = aTmpT[t].split(",",3);
			
			subIn.put("Event", aTmpT1[0]);
			
			// 일자유형 ODAT일 경우 제외
			if(!aTmpT1[1].equals("ODAT")) subIn.put("Date", aTmpT1[1]);
			
			subInArray.add(subIn);
			
			// OR값만 추가
			if(aTmpT1[2].equals("or")) subInArray.add(aTmpT1[2].toUpperCase());
		}
		
		eventsToWaitFor.put("Events",subInArray);
		
		return eventsToWaitFor;
	}
	
	//후행조건(Deploy)
	public static org.json.simple.JSONArray getTconditionOutDeploy(String strTconditionOut) {
		
		org.json.simple.JSONArray subAddArray 		= new org.json.simple.JSONArray();
		org.json.simple.JSONArray subDeleteArray 	= new org.json.simple.JSONArray();
		org.json.simple.JSONArray subConditionOut 	= new org.json.simple.JSONArray();
		
		String[] aTmpT = strTconditionOut.split("[|]");
		
		for ( int t = 0; null != aTmpT && t < aTmpT.length; t++ ) {
			String[] aTmpT1 = aTmpT[t].split(",",3);
			org.json.simple.JSONObject subAdd = new org.json.simple.JSONObject();
			org.json.simple.JSONObject subDelete = new org.json.simple.JSONObject();
			if(aTmpT1[2].equals("add")){
				subAdd.put("Event", aTmpT1[0]);
				
				// 일자유형 ODAT일 경우 제외
				if(!aTmpT1[1].equals("ODAT")) subAdd.put("Date", aTmpT1[1]);
				
				subAddArray.add(subAdd);
			}else {
				subDelete.put("Event", aTmpT1[0]);
				
				// 일자유형 ODAT일 경우 제외
				if(!aTmpT1[1].equals("ODAT")) subDelete.put("Date", aTmpT1[1]);
				
				subDeleteArray.add(subDelete);
			}
		}
		
		org.json.simple.JSONObject eventsToAdd = new org.json.simple.JSONObject();
		org.json.simple.JSONObject eventsToDelete = new org.json.simple.JSONObject();
		
		if(!subAddArray.toString().equals("[]"))		eventsToAdd.put("Type", "AddEvents");
		if(!subAddArray.toString().equals("[]"))		eventsToAdd.put("Events",subAddArray);

		if(!subDeleteArray.toString().equals("[]"))		eventsToDelete.put("Type", "DeleteEvents");
		if(!subDeleteArray.toString().equals("[]"))		eventsToDelete.put("Events",subDeleteArray);
		
		// JsonArray 에 2개를 담는다.
		subConditionOut.add(eventsToAdd);
		subConditionOut.add(eventsToDelete);
		
		return subConditionOut;
	}
	
	//OnDo(deploy)   
	public static org.json.simple.JSONObject getOnDoDeploy(String strTset, int onDoCnt) {
		
		int Cnt = 0;
		org.json.simple.JSONObject onDo 		= new org.json.simple.JSONObject();
		
		String[] t_set 				= strTset.split("[|]");
		
		for(int i=0;i<t_set.length;i++) {
			org.json.simple.JSONObject action 		= new org.json.simple.JSONObject();
			org.json.simple.JSONObject doNotify 	= new org.json.simple.JSONObject();

			if(t_set[i].split(",")[0].equals("O")) Cnt += 1;
			
			if(Cnt == onDoCnt && t_set[i].split(",")[0].equals("O")) {
				if(t_set[i].split(",")[3].equals("NOTOK")) {
					onDo.put("CompletionStatus", "NOTOK");
				}else if(t_set[i].split(",")[3].equals("OK")) {
					onDo.put("CompletionStatus", "OK");
				}else if(t_set[i].split(",")[3].toUpperCase().indexOf("COMPSTAT") > -1) {
					if(t_set[i].split(",")[3].split(" ")[1].equals("EQ")) {
						onDo.put("CompletionStatus", t_set[i].split(",")[3].split(" ")[2]);
					}else if(t_set[i].split(",")[3].split(" ")[1].equals("NE")){
						onDo.put("CompletionStatus", "!=" + t_set[i].split(",")[3].split(" ")[2]);
					}else if(t_set[i].split(",")[3].split(" ")[1].equals("LE")){
						onDo.put("CompletionStatus", "<=" + t_set[i].split(",")[3].split(" ")[2]);
					}else if(t_set[i].split(",")[3].split(" ")[1].equals("LT")){
						onDo.put("CompletionStatus", "<" + t_set[i].split(",")[3].split(" ")[2]);
					}else if(t_set[i].split(",")[3].split(" ")[1].equals("GE")){
						onDo.put("CompletionStatus", ">=" + t_set[i].split(",")[3].split(" ")[2]);
					}else if(t_set[i].split(",")[3].split(" ")[1].equals("GT")){
						onDo.put("CompletionStatus", ">" + t_set[i].split(",")[3].split(" ")[2]);
					}
				}else if(t_set[i].split(",")[3].toUpperCase().indexOf("RUNCOUNT") > -1) {
					if(t_set[i].split(",")[3].split(" ")[1].equals("EQ")) {
						onDo.put("NumberOfExecutions", t_set[i].split(",")[3].split(" ")[2]);
					}else if(t_set[i].split(",")[3].split(" ")[1].equals("NE")){
						onDo.put("NumberOfExecutions", "!=" + t_set[i].split(",")[3].split(" ")[2]);
					}else if(t_set[i].split(",")[3].split(" ")[1].equals("LE")){
						onDo.put("NumberOfExecutions", "<=" + t_set[i].split(",")[3].split(" ")[2]);
					}else if(t_set[i].split(",")[3].split(" ")[1].equals("LT")){
						onDo.put("NumberOfExecutions", "<" + t_set[i].split(",")[3].split(" ")[2]);
					}else if(t_set[i].split(",")[3].split(" ")[1].equals("GE")){
						onDo.put("NumberOfExecutions", ">=" + t_set[i].split(",")[3].split(" ")[2]);
					}else if(t_set[i].split(",")[3].split(" ")[1].equals("GT")){
						onDo.put("NumberOfExecutions", ">" + t_set[i].split(",")[3].split(" ")[2]);
					}
				}
			}
			
			if(t_set[i].split(",")[0].equals("A") && Cnt == onDoCnt) {
				if(t_set[i].split(",")[1].equals("RERUN")) {
					action.put("Type", "Action:Rerun");
					onDo.put("Action:Rerun", action);
				}else if(t_set[i].split(",")[1].equals("Shout")) {
					if(t_set[i].split(",")[2].equals("EM")); doNotify.put("Type", "Action:Notify");
					if(t_set[i].split(",")[2].equals("EM")); doNotify.put("Message", t_set[i].split(",")[4]);
					onDo.put("DoNotify", doNotify);
				}else if(t_set[i].split(",")[1].equals("OK")) {
					action.put("Type", "Action:SetToOK");
					onDo.put("Action:SetToOK", action);
				}else if(t_set[i].split(",")[1].equals("Stop")) {
					action.put("Type", "Action:StopCyclicRun");
					onDo.put("Action:StopCyclicRun", action);
				}
			}
		}
		return onDo;
	}
	
	//반복작업(deploy)
	public static org.json.simple.JSONObject getRerunDeploy(Map map) {

		Doc01Bean docBean			= (Doc01Bean)map.get("doc01");

		org.json.simple.JSONArray weekDay					= new org.json.simple.JSONArray();
		org.json.simple.JSONArray month						= new org.json.simple.JSONArray();
		org.json.simple.JSONArray reRunSpecific				= new org.json.simple.JSONArray();
		org.json.simple.JSONObject reRunSpecificTime		= new org.json.simple.JSONObject();
		org.json.simple.JSONObject reRun 					= new org.json.simple.JSONObject();
		
		String strCyclicType		= CommonUtil.isNull(docBean.getCyclic_type());
		String strIntervalSequence	= CommonUtil.isNull(docBean.getInterval_sequence());
		String strTolerance			= CommonUtil.isNull(docBean.getTolerance());
		String strSpecificTimes		= CommonUtil.isNull(docBean.getSpecific_times());
		String strRerunInterval		= CommonUtil.isNull(docBean.getRerun_interval());
		String strRerunIntervalTime	= CommonUtil.isNull(docBean.getRerun_interval_time());
		String strCountCyclicFrom	= CommonUtil.isNull(docBean.getCount_cyclic_from());
		
		if(strCyclicType.equals("S")) {										//반복옵션 - 시간지정
			for(int i = 0; i<strSpecificTimes.split(",").length; i++) {
				reRunSpecific.add(strSpecificTimes.split(",")[i]);
			}
			reRun.put("At", reRunSpecific);
			reRun.put("Times", "10");
			reRun.put("Tolerance", strTolerance);
		}else if(strCyclicType.equals("C")) {								//반복옵션 - 반복주기
			reRun.put("Times", "10");
			if(strRerunIntervalTime.equals("M")); reRun.put("Units", "Minutes");
			reRun.put("Every", strRerunInterval);
			if(strCountCyclicFrom.equals("end")); reRun.put("From", "End");
			if(strCountCyclicFrom.equals("target")); reRun.put("From", "Target");
		}else if(strCyclicType.equals("V")) {								//반복옵션 - 반복주기(불규칙)
			for(int i = 0; i<strIntervalSequence.split(",").length; i++) {
				reRunSpecific.add(strIntervalSequence.split(",")[i]+strRerunIntervalTime);
			}
			reRun.put("Intervals", reRunSpecific);
			reRun.put("Times", "10");
			if(strCountCyclicFrom.equals("end")); reRun.put("From", "End");
		}
		return reRun;
	}
	
	
	
	
	
	
	public static void disableSslVerification() {
		
		try {
	        TrustManager[] trustAllCerts = new TrustManager[] {
	        	new X509TrustManager() {
					@Override
					public java.security.cert.X509Certificate[] getAcceptedIssuers() {
						return null;
					}
					@Override
					public void checkServerTrusted(java.security.cert.X509Certificate[] chain, String authType)
							throws CertificateException {
					}
					@Override
					public void checkClientTrusted(java.security.cert.X509Certificate[] chain, String authType)
							throws CertificateException {
					}
        		}
			};
	
	        SSLContext sc = SSLContext.getInstance("SSL");
	        sc.init(null, trustAllCerts, new java.security.SecureRandom());
	        HttpsURLConnection.setDefaultSSLSocketFactory(sc.getSocketFactory());
	
	        HostnameVerifier allHostsValid = new HostnameVerifier() {
	            public boolean verify(String hostname, SSLSession session){
	                return true;
	            }
	        };
			
	        HttpsURLConnection.setDefaultHostnameVerifier(allHostsValid);
			
	    } catch (NoSuchAlgorithmException e) {
	        e.printStackTrace();
	    } catch (KeyManagementException e) {
	        e.printStackTrace();
	    }
	}
	
	//작업 오더 AAPI (수시)
	public static JSONObject restApiCall_order(String AAPI_URL, String REST_URL, String type, Map map) throws JSONException, IOException {
		
		String strEmUserId 	= CommonUtil.isNull(CommonUtil.getMessage("EM.USER.ID"));
		String strEmUserPw 	= CommonUtil.isNull(CommonUtil.getMessage("EM.USER.PW"));
		
		JSONObject responseJson = null;
		JsonObject params 		= null;
		
		params = new JsonObject();
		params.addProperty("username", strEmUserId);
		params.addProperty("password", strEmUserPw);
		
		logger.debug("로그인api 시작");
		
		// 로그인
		responseJson = restApiRun(AAPI_URL + "/session/login", "POST", params, "");
		String token = (String)responseJson.get("token");
		
		logger.debug("로그인api 종료");
		
		params = new JsonObject();

		String ctm	 				= CommonUtil.isNull(map.get("data_center"));
		String jobs 				= CommonUtil.isNull(map.get("job_name"));
		String orderDate 			= CommonUtil.isNull(map.get("order_date"));
		String folder 				= CommonUtil.isNull(map.get("table_name"));
		String strTaskType			= CommonUtil.isNull(map.get("task_type"));
		String orderIntoFolder		= CommonUtil.isNull(map.get("order_into_folder"));
		Boolean hold 				= false;
		Boolean wait 				= false;
		Boolean ignoreCriteria 		= false;
		String strTset 				= CommonUtil.isNull(map.get("t_set"));
//		String[] t_set 				= strTset.split("[|]");

		if ( !ctm.equals("") && ctm.indexOf(",") > -1 ) {
			ctm = ctm.split(",")[1];
		}
		if(CommonUtil.isNull(map.get("hold_yn")).equals("Y")) {
			hold 	= true;
		}
		if(CommonUtil.isNull(map.get("force_yn")).equals("Y")) {
			ignoreCriteria 	= true;
		}
		
		if(CommonUtil.isNull(map.get("wait_gubun")).equals("yes")) {
			wait 	= true;
		}
		
		params.addProperty("ctm", ctm);
		params.addProperty("folder", folder);
		params.addProperty("jobs", jobs);
		params.addProperty("createDuplicate", true);
		params.addProperty("hold", hold);
		params.addProperty("waitForOrderDate", wait);
		params.addProperty("ignoreCriteria", ignoreCriteria);
//			params.addProperty("independentFlow", "");
		params.addProperty("orderDate", orderDate);
		
		if(!orderIntoFolder.equals("")) {
			params.addProperty("orderIntoFolder", orderIntoFolder);
		}

		if ( !strTset.equals("/") && !strTset.equals("")) params.add("variables", AAPI_Util.getTsetOrder(strTset));
		
		logger.debug("restApiRun시작");
		
		// 수행
		responseJson = restApiRun(REST_URL, type, params, token);
		
		logger.debug("restApiRun종료 ::::: " + responseJson);
		
		return responseJson;
	}
	
	//상태변경 AAPI
	public static JSONObject restApiCall(String AAPI_URL, String REST_URL, String type) throws JSONException, IOException {
		
		String strEmUserId 	= CommonUtil.isNull(CommonUtil.getMessage("EM.USER.ID"));
		String strEmUserPw 	= CommonUtil.isNull(CommonUtil.getMessage("EM.USER.PW"));
		
		JSONObject responseJson = null;
		JsonObject params 		= null;
		
		params = new JsonObject();
		params.addProperty("username", strEmUserId);
		params.addProperty("password", strEmUserPw);
		
		// 로그인
		responseJson = restApiRun(AAPI_URL + "/session/login", "POST", params, "");
		String token = (String)responseJson.get("token");

		// 세션에 토큰 저장 (재사용을 위해)
//		HttpServletRequest request 	= ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
//		request.getSession().setAttribute("USER_TOKEN", token);
		
		params = new JsonObject();

		// 수행
		responseJson = restApiRun(REST_URL, type, params, token);
		
		logger.debug("상태 변경 : " + responseJson);
		
		return responseJson;
	}
	
	// connection progile AAPI
	public static JSONObject restApi_connection_profile(String AAPI_URL, String REST_URL, String type) throws JSONException, IOException {
		
		String strEmUserId 	= CommonUtil.isNull(CommonUtil.getMessage("EM.USER.ID"));
		String strEmUserPw 	= CommonUtil.isNull(CommonUtil.getMessage("EM.USER.PW"));
		
		JSONObject responseJson = null;
		JsonObject params 		= null;
		
		params = new JsonObject();
		params.addProperty("username", strEmUserId);
		params.addProperty("password", strEmUserPw);

		// 로그인
		responseJson = restApiRun(AAPI_URL + "/session/login", "POST", params, "");
		String token = (String)responseJson.get("token");

		params = new JsonObject();

		// 수행
		responseJson = restApiRun(REST_URL, type, params, token);
		
		logger.debug("Get Connection Profile 결과 ::::: " + responseJson);
		
		return responseJson;
	}
	
	//신규등록(deploy)전 get
	public static String restApiDeployGet(String AAPI_URL, String REST_URL, String type, String strTableName) throws JSONException, IOException {
		
		String strEmUserId 	= CommonUtil.isNull(CommonUtil.getMessage("EM.USER.ID"));
		String strEmUserPw 	= CommonUtil.isNull(CommonUtil.getMessage("EM.USER.PW"));
		
		JSONObject responseJson = null;
		JsonObject params 		= null;
		String getResonse		= "";
		
		params = new JsonObject();
		params.addProperty("username", strEmUserId);
		params.addProperty("password", strEmUserPw);
		
		// 로그인
		responseJson = restApiRun(AAPI_URL + "/session/login", "POST", params, "");
		String token = (String)responseJson.get("token");
		logger.debug("token : " + token);
		params = new JsonObject();
		
		// 수행
		getResonse = restApiGetDeploy(REST_URL, type, params, token, strTableName);
		
		return getResonse;
	}
	
	//order 진행수 orderId를 구하기 위한 run/status/runId get
	public static JSONObject restApiStatusRunId(String AAPI_URL, String REST_URL, String type, String runId) throws JSONException, IOException {
		
		String strEmUserId 	= CommonUtil.isNull(CommonUtil.getMessage("EM.USER.ID"));
		String strEmUserPw 	= CommonUtil.isNull(CommonUtil.getMessage("EM.USER.PW"));
		
		JSONObject responseJson = null;
		JsonObject params 		= null;
		String getResonse		= "";
		
		params = new JsonObject();
		params.addProperty("username", strEmUserId);
		params.addProperty("password", strEmUserPw);
		
		// 로그인
		responseJson = restApiRun(AAPI_URL + "/session/login", "POST", params, "");
		String token = (String)responseJson.get("token");
		
		params = new JsonObject();
		params.addProperty("runId", runId);
		
		// 수행
		responseJson = restApiRun(REST_URL, type, params, token);
		
		return responseJson;
	}
	
	//신규등록(deploy)전 json 파일 생성
	public static String restApiDeployFile(String jsonFile) throws JSONException {
		
		String strEmUserId 	= CommonUtil.isNull(CommonUtil.getMessage("EM.USER.ID"));
		String strEmUserPw 	= CommonUtil.isNull(CommonUtil.getMessage("EM.USER.PW"));
		
		String filePath = CommonUtil.isNull(CommonUtil.getMessage("DEPLOY.API.PATH"));
		try {
			FileWriter file = new FileWriter(filePath);
			file.write(jsonFile);
			file.flush();
			file.close();
		}catch(IOException e) {
			e.printStackTrace();
		}
		
		return filePath;
	}
	
	//작업등록(deploy)
	public static String restApiDeploy(String AAPI_URL, String REST_URL, String type, String filePath) throws JSONException, IOException {
		
		String strEmUserId 	= CommonUtil.isNull(CommonUtil.getMessage("EM.USER.ID"));
		String strEmUserPw 	= CommonUtil.isNull(CommonUtil.getMessage("EM.USER.PW"));
		String deploy 		= "";
		
		JSONObject responseJson = null;
		JsonObject params 		= null;
		
		params = new JsonObject();
		params.addProperty("username", strEmUserId);
		params.addProperty("password", strEmUserPw);
		
		// 로그인
		responseJson = restApiRun(AAPI_URL + "/session/login", "POST", params, "");
		String token = (String)responseJson.get("token");
		
		params = new JsonObject();

		// 수행
		deploy = restApiDeployFileRun(REST_URL, type, params, token, filePath);
		
		return deploy;
	}
	
	//속성변경(modify)전 get → 할 필요가 없어서 안씀
//	public static JSONObject restApiGet(String AAPI_URL, String REST_URL, String type) throws JSONException {
//		
//		String strEmUserId 	= CommonUtil.isNull(CommonUtil.getMessage("EM.USER.ID"));
//		String strEmUserPw 	= CommonUtil.isNull(CommonUtil.getMessage("EM.USER.PW"));
//		
//		JSONObject responseJson = null;
//		JsonObject params 		= null;
//		
//		params = new JsonObject();
//		params.addProperty("username", strEmUserId);
//		params.addProperty("password", strEmUserPw);
//		
//		
//		// 로그인
//		responseJson = restApiRun(AAPI_URL + "/session/login", "POST", params, "");
//		String token = (String)responseJson.get("token");
//		
//		params = new JsonObject();
//
//		// 수행
//		responseJson = restApiRun(REST_URL, type, params, token);
//		
//		return responseJson;
//	}
	
	//속성변경(modify)전 json 파일 생성
	public static String restApiFile(JsonObject jsonFile) throws JSONException {
		
		String strEmUserId 	= CommonUtil.isNull(CommonUtil.getMessage("EM.USER.ID"));
		String strEmUserPw 	= CommonUtil.isNull(CommonUtil.getMessage("EM.USER.PW"));
		
		String filePath = CommonUtil.isNull(CommonUtil.getMessage("MODIFY.API.PATH"));
		try {
			FileWriter file = new FileWriter(filePath);
			file.write(jsonFile.toString());
			file.flush();
			file.close();
		}catch(IOException e) {
			e.printStackTrace();
		}
		
		return filePath;
	}
	
	//속성변경(modify)
	public static JSONObject restApiModify(String AAPI_URL, String REST_URL, String type, String filePath, String jobId) throws JSONException, IOException {
		
		String strEmUserId 	= CommonUtil.isNull(CommonUtil.getMessage("EM.USER.ID"));
		String strEmUserPw 	= CommonUtil.isNull(CommonUtil.getMessage("EM.USER.PW"));
		
		JSONObject responseJson = null;
		JsonObject params 		= null;
		
		params = new JsonObject();
		params.addProperty("username", strEmUserId);
		params.addProperty("password", strEmUserPw);
		
		// 로그인
		responseJson = restApiRun(AAPI_URL + "/session/login", "POST", params, "");
		String token = (String)responseJson.get("token");
		
		params = new JsonObject();
		params.addProperty("jobId ", jobId);

		// 수행
		responseJson = restApiFileRun(REST_URL, type, params, token, filePath);
		
		return responseJson;
	}
	
	public static JSONObject restApiRun(String REST_URL, String type, JsonObject params, String token) throws JSONException, IOException  {
		
		HttpsURLConnection conn = null;
		JSONObject responseJson = null;
		BufferedWriter bw 		= null;
		BufferedReader br		= null;
		
		try {
			
		    //URL 설정
		    URL url = new URL(REST_URL);

		    disableSslVerification();
		    conn = (HttpsURLConnection) url.openConnection();
		    
		    conn.setRequestMethod(type);
		    conn.setRequestProperty("Content-Type", 		"application/json");
		    conn.setRequestProperty("Transfer-Encoding", 	"chunked");
		    conn.setRequestProperty("Connection", 			"keep-alive");
		    
		    if(token != null) {
		    	conn.setRequestProperty("Authorization", 	"Bearer " + token);	
		    }

		    if(type.equals("POST")){
		    	conn.setDoOutput(true);
		    	
			    bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream(),"UTF-8"));
			    
//			    System.out.println("paramsparams : " + params.toString());

			    bw.write(params.toString());
			    bw.flush();
			    bw.close();
		    }else{
		    	conn.setDoOutput(false);
		    }
		    
		    int responseCode	= conn.getResponseCode();
		    String data			= conn.getResponseMessage();
		    
		    if (responseCode == 200) {
		    	br = new BufferedReader(new InputStreamReader(conn.getInputStream(),"UTF-8"));
		        StringBuilder sb = new StringBuilder();
		        String line = "";
		        while ((line = br.readLine()) != null) {
		            sb.append(line);
		        }
		        responseJson = new JSONObject(sb.toString());
		        
		        // RESPONSE CODE 200 이면 API 호출 성공으로 간주
		        responseJson.put("message", "SUCCESS");
		        logger.info("responseCode : " + responseCode);
		    } else {
		    	br = new BufferedReader(new InputStreamReader(conn.getErrorStream(),"UTF-8"));
		    	StringBuilder sb = new StringBuilder();
		        String line = "";
		        while ((line = br.readLine()) != null) {
		        	sb.append(line);
		        }
		        responseJson = new JSONObject(sb.toString());
		        logger.info("responseCode : " + responseCode);
		    }
		} catch (MalformedURLException e) {
			logger.debug("e : " + e.toString());
			e.printStackTrace();
		} catch (JSONException e) {
			logger.info("not JSON Format response");
		    e.printStackTrace();
		} finally {
			try{ if(conn != null) conn.disconnect(); } catch(Exception e){}
			try{ if(bw != null) bw.close(); } catch(Exception e){}
			try{ if(br != null) br.close(); } catch(Exception e){}
		}

		return responseJson;
	}
	
	//deploy
	public static String restApiGetDeploy(String REST_URL, String type, JsonObject params, String token, String strTableName) {
		
		HttpsURLConnection conn = null;
		JSONObject responseJson = null;
		StringBuilder sb 		= new StringBuilder();
		BufferedWriter bw 		= null;
		BufferedReader br		= null;
		
		try {
			
		    //URL 설정
		    URL url = new URL(REST_URL);

		    disableSslVerification();
		    conn = (HttpsURLConnection) url.openConnection();
		    
		    conn.setRequestMethod(type);
		    conn.setRequestProperty("Content-Type", 		"application/json");
		    conn.setRequestProperty("Transfer-Encoding", 	"chunked");
		    conn.setRequestProperty("Connection", 			"keep-alive");
		    
		    if(token != null) {
		    	conn.setRequestProperty("Authorization", 	"Bearer " + token);	
		    }
		    
		    logger.debug("REST_URL ::: " + REST_URL);

		    if(type.equals("POST")){
		    	conn.setDoOutput(true);
		    	
			    bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream(),"UTF-8"));
			    
//			    logger.debug("deploy params : " + params.toString());

			    bw.write(params.toString());
			    bw.flush();
			    bw.close();
		    }else{
		    	conn.setDoOutput(false);
		    }
		    
		    int responseCode	= conn.getResponseCode();
		    String data			= conn.getResponseMessage();
		    
		    logger.debug("responseCode ::: " + responseCode);
		    
		    if (responseCode == 200) {
		    	br 	= new BufferedReader(new InputStreamReader(conn.getInputStream(),"UTF-8"));
//		        StringBuilder sb 	= new StringBuilder();
		        
		        String line 	= "";
		        int line_cnt 	= 0;
		        
		        while ((line = br.readLine()) != null) {
		            sb.append(line);
		        }
		        logger.debug("sb.toString() : " + sb.toString());
//		        responseJson = new JSONObject(sb.toString());
		        
		    } else {
		    	br = new BufferedReader(new InputStreamReader(conn.getErrorStream(),"UTF-8"));
//		    	StringBuilder sb = new StringBuilder();
		        String line = "";
		        while ((line = br.readLine()) != null) {
		        	sb.append(line);
		        }
//		        responseJson = new JSONObject(sb.toString());
		    }
		} catch (MalformedURLException e) {
		    e.printStackTrace();
		} catch (IOException e) {
		    e.printStackTrace();
		} finally {
			try{ if(conn != null) conn.disconnect(); } catch(Exception e){}
			try{ if(bw != null) bw.close(); } catch(Exception e){}
			try{ if(br != null) br.close(); } catch(Exception e){}
		}

		return sb.toString();
	}
	
	//modify 파일 전송 api
	public static JSONObject restApiFileRun(String REST_URL, String type, JsonObject params, String token, String filePath) {
		
		HttpsURLConnection conn = null;
		JSONObject responseJson = null;
		BufferedWriter bw 		= null;
		BufferedReader br		= null;

		try {
			
		    //URL 설정
		    URL url = new URL(REST_URL);

		    disableSslVerification();
		    conn = (HttpsURLConnection) url.openConnection();
		    
		    conn.setRequestMethod(type);
		    
		    if(type.equals("POST")){
		    	conn.setDoOutput(true);
		    }else{
		    	conn.setDoOutput(false);
		    }

		    if(token != null) {
		    	conn.setRequestProperty("Authorization", "Bearer "+token);
		    	ArrayList list = new ArrayList(10);
		    	addFile(list, "jobDefinitionsFile", new File(filePath));
		    	sendMultipartPost(conn, list);

		    } else {
			    conn.setRequestProperty("Content-Type", "application/json");
			    conn.setRequestProperty("Transfer-Encoding", "chunked");
			    conn.setRequestProperty("Connection", "keep-alive");
			    
			    bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream(),"UTF-8"));

			    bw.write(params.toString());
			    bw.flush();
			    bw.close();
		    }
		    
		    int responseCode	= conn.getResponseCode();
		    String data			= conn.getResponseMessage();
		    
		    if (responseCode == 200) {
		    	br = new BufferedReader(new InputStreamReader(conn.getInputStream(),"UTF-8"));
		        StringBuilder sb = new StringBuilder();
		        String line = "";
		        while ((line = br.readLine()) != null) {
		            sb.append(line);
		        }
		        responseJson = new JSONObject(sb.toString());
		        
		        // RESPONSE CODE 200 이면 API 호출 성공으로 간주
		        responseJson.put("message", "SUCCESS");
		        logger.debug("responseCode : " + responseCode);
		    } else {
		    	br = new BufferedReader(new InputStreamReader(conn.getErrorStream(),"UTF-8"));
		    	StringBuilder sb = new StringBuilder();
		        String line = "";
		        while ((line = br.readLine()) != null) {
		        	sb.append(line);
		        }
		        responseJson = new JSONObject(sb.toString());
		        logger.debug("responseCode : " + responseCode);
		    }
		} catch (MalformedURLException e) {
		    e.printStackTrace();
		} catch (IOException e) {
		    e.printStackTrace();
		} catch (JSONException e) {
			logger.debug("not JSON Format response");
		    e.printStackTrace();
		} finally {
			try{ if(conn != null) conn.disconnect(); } catch(Exception e){}
			try{ if(bw != null) bw.close(); } catch(Exception e){}
			try{ if(br != null) br.close(); } catch(Exception e){}
		}
		
		return responseJson;

	}

	//deploy 파일 전송 api
	public static String restApiDeployFileRun(String REST_URL, String type, JsonObject params, String token, String filePath) {
		
		HttpsURLConnection conn = null;
		JSONObject responseJson = null;
		StringBuilder sb	 	= new StringBuilder();
		BufferedWriter bw 		= null;
		BufferedReader br		= null;

		try {
			
		    //URL 설정
		    URL url = new URL(REST_URL);

		    disableSslVerification();
		    conn = (HttpsURLConnection) url.openConnection();
		    
		    conn.setRequestMethod(type);
		    
		    if(type.equals("POST")){
		    	conn.setDoOutput(true);
		    }else{
		    	conn.setDoOutput(false);
		    }

		    if(token != null) {
		    	conn.setRequestProperty("Authorization", "Bearer "+token);
		    	ArrayList list = new ArrayList(10);
		    	addFile(list, "definitionsFile ", new File(filePath));
		    	sendMultipartPost(conn, list);

		    } else {
			    conn.setRequestProperty("Content-Type", "application/json");
			    conn.setRequestProperty("Transfer-Encoding", "chunked");
			    conn.setRequestProperty("Connection", "keep-alive");
			    
			    bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream(),"UTF-8"));

			    bw.write(params.toString());
			    bw.flush();
			    bw.close();
		    }
		    
		    int responseCode	= conn.getResponseCode();
		    String data			= conn.getResponseMessage();
		    
		    if (responseCode == 200) {
		    	br = new BufferedReader(new InputStreamReader(conn.getInputStream(),"UTF-8"));
//		        StringBuilder sb = new StringBuilder();
		        String line = "";
		        int count = 0;
		        while ((line = br.readLine()) != null) {
		            sb.append(line);
		            count ++;
		        }
		        logger.debug("(responseCode : 200) : " + sb.toString());
		        
//		        responseJson = new JSONObject(sb.toString().substring(1,count-1));
		    } else {
		    	br = new BufferedReader(new InputStreamReader(conn.getErrorStream(),"UTF-8"));
//		    	StringBuilder sb = new StringBuilder();
		        String line = "";
		        while ((line = br.readLine()) != null) {
		        	sb.append(line);
		        }
		        logger.debug("(responseCode : else) : " + sb.toString());
		    }
		} catch (MalformedURLException e) {
		    e.printStackTrace();
		} catch (IOException e) {
		    e.printStackTrace();
		} finally {
			try{ if(conn != null) conn.disconnect(); } catch(Exception e){}
			try{ if(bw != null) bw.close(); } catch(Exception e){}
			try{ if(br != null) br.close(); } catch(Exception e){}
		}
		
		return sb.toString();

	}
	
	public static void addFile(ArrayList list, String parameterName, File parameterValue) {
        // paramterValue가 null일 경우 NullFile을 삽입한다.
        if (parameterValue == null) {
//             list.add(parameterName);
//             list.add(new NullFile());
        } else {
            list.add(parameterName);
            list.add(parameterValue);
        }
    }
	
	public static final String CRLF = "\r\n";
	
	private static String makeDelimeter() {
        return "---------------------------7d115d2a20060c";
    }
	
	public static void sendMultipartPost(HttpsURLConnection conn, ArrayList list) throws IOException { 
        
        String delimeter = makeDelimeter();        
        byte[] newLineBytes = CRLF.getBytes();
        byte[] delimeterBytes = delimeter.getBytes();
        byte[] dispositionBytes = "Content-Disposition: form-data; name=".getBytes();
        byte[] quotationBytes = "\"".getBytes();
        byte[] contentTypeBytes = "Content-Type: application/octet-stream".getBytes();
        byte[] fileNameBytes = "; filename=".getBytes();
        byte[] twoDashBytes = "--".getBytes();
        
        conn.setRequestProperty("Content-Type", "multipart/form-data; boundary="+delimeter);
        conn.setDoInput(true);
        conn.setUseCaches(false);
        
        BufferedOutputStream out 	= null;
        BufferedInputStream is 		= null;
        
        try {
            out = new BufferedOutputStream(conn.getOutputStream());
            
            Object[] obj = new Object[list.size()];
            list.toArray(obj);
            
            for (int i = 0 ; i < obj.length ; i += 2) {
                out.write(twoDashBytes);
                out.write(delimeterBytes);
                out.write(newLineBytes);
                
                out.write(dispositionBytes);
                out.write(quotationBytes);
                out.write( ((String)obj[i]).getBytes() );
                out.write(quotationBytes);
                if ( obj[i+1] instanceof String) {
                    // String 이라면
                    out.write(newLineBytes);
                    out.write(newLineBytes);
                    // 값 출력
                    out.write( ((String)obj[i+1]).getBytes() );
                    out.write(newLineBytes);
                } else {
                    // 파라미터의 값이 File 이나 NullFile인 경우
                    if ( obj[i+1] instanceof File) {
                        File file = (File)obj[i+1];
                        // File이 존재하는 지 검사한다.
                        out.write(fileNameBytes);
                        out.write(quotationBytes);
                        out.write(file.getAbsolutePath().getBytes() );
                        out.write(quotationBytes);
                    } else {
                        // NullFile 인 경우
                        out.write(fileNameBytes);
                        out.write(quotationBytes);
                        out.write(quotationBytes);
                    }
                    out.write(newLineBytes);
                    out.write(contentTypeBytes);
                    out.write(newLineBytes);
                    out.write(newLineBytes);
                    // File 데이터를 전송한다.
                    if (obj[i+1] instanceof File) {
                        File file = (File)obj[i+1];
                        // file에 있는 내용을 전송한다.
                        try {
                            is = new BufferedInputStream(new FileInputStream(file));
                            byte[] fileBuffer = new byte[1024 * 8]; // 8k
                            int len = -1;
                            while ( (len = is.read(fileBuffer)) != -1) {
                                out.write(fileBuffer, 0, len);
                            }
                        } finally {
                            if (is != null) try { is.close(); } catch(IOException ex) {}
                        }
                    }
                    out.write(newLineBytes);
                }
                if ( i + 2 == obj.length ) {
                    out.write(twoDashBytes);
                    out.write(delimeterBytes);
                    out.write(twoDashBytes);
                    out.write(newLineBytes);
                }
            } // for 루프의 끝
            
            out.flush();
        } finally {
            if (out != null) out.close();
            if (is != null) is.close();
        }
    }
}