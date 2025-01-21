package com.ghayoun.ezjobs.common.util;

import java.io.*;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.net.ConnectException;
import java.net.HttpURLConnection;
import java.net.InetAddress;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.UnknownHostException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardOpenOption;
import java.security.KeyFactory;
import java.security.KeyPair;
import java.security.KeyPairGenerator;
import java.security.PrivateKey;
import java.security.PublicKey;
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
import java.util.Set;
import java.util.TreeSet;
import java.util.concurrent.Callable;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

import javax.crypto.Cipher;
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
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.poi.ss.usermodel.Sheet;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.web.context.ContextLoader;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;
import com.bmc.ctmem.schema900.ErrorListType;
import com.bmc.ctmem.schema900.FaultOrderForceWithJobsType;
import com.bmc.ctmem.schema900.ResponseUserRegistrationType;
import com.ghayoun.ezjobs.comm.domain.CommonBean;
import com.ghayoun.ezjobs.comm.repository.CommonDao;
import com.ghayoun.ezjobs.comm.repository.CommonDaoImpl;
import com.ghayoun.ezjobs.comm.repository.QuartzDao;
import com.ghayoun.ezjobs.comm.service.CommonService;
import com.ghayoun.ezjobs.comm.service.EzSmsJobServiceImpl;
import com.ghayoun.ezjobs.m.domain.JobGraphBean;
import com.ghayoun.ezjobs.m.service.PopupJobGraphService;
import com.ghayoun.ezjobs.t.domain.ActiveJobBean;
import com.ghayoun.ezjobs.t.domain.CompanyBean;
import com.ghayoun.ezjobs.t.domain.DocInfoBean;
import com.ghayoun.ezjobs.t.domain.JobMapperBean;
import com.ghayoun.ezjobs.t.repository.EmJobDeleteDao;
import com.ghayoun.ezjobs.t.repository.WorksUserDao;
import com.ghayoun.ezjobs.t.service.WorksApprovalDocService;
import com.ghayoun.ezjobs.t.service.WorksCompanyService;
import com.ghayoun.ezjobs.t.service.WorksUserService;
import com.google.gson.JsonObject;
import com.jcraft.jsch.Logger;

import net.sf.json.JSONArray;


@SuppressWarnings({ "unused", "unchecked" })
public class CommonUtil {
		
	private QuartzDao quartzDao;
	private CommonDao commonDao;
	
	private static CommonDao StaticCommonDao;

	private static final Log logger = LogFactory.getLog(CommonUtil.class);

	public static String toJsonList(List beanList) {
		
		String js = "";
		
		if(beanList!=null){
			js = JSONArray.fromObject(beanList).toString(); 
		}else{
			js = JSONArray.fromObject(new ArrayList()).toString();
		}
		
		return js;
	}
	
	public static String getDateFormat(int type, String date){
		
		String sDate = isNull(date);
		try{
			String sTmp = sDate;
			if(type==1){
				if( sTmp.length()==14 ){
					sDate = sTmp.substring(0,4)+"/"+ sTmp.substring(4,6)+"/"+ sTmp.substring(6,8)+" "+ sTmp.substring(8,10)+":"+sTmp.substring(10,12)+":"+ sTmp.substring(12,14);
				}else if( sTmp.length()==8 ){
					sDate = sTmp.substring(0,4)+"/"+ sTmp.substring(4,6)+"/"+ sTmp.substring(6,8);
				}
			}else if(type==2){
				if( sTmp.length()==14 ){
					sDate = sTmp.substring(4,6)+"/"+ sTmp.substring(6,8)+" "+ sTmp.substring(8,10)+":"+sTmp.substring(10,12)+":"+ sTmp.substring(12,14);
				}else if( sTmp.length()==12 ){
					sDate = sTmp.substring(4,6)+"/"+ sTmp.substring(6,8)+" "+ sTmp.substring(8,10)+":"+sTmp.substring(10,12);
				}else if( sTmp.length()==8 ){
					sDate = sTmp.substring(4,6)+"/"+ sTmp.substring(6,8);
				}
			}else if(type==3){
				if( sTmp.length()==14 ){
					sDate = sTmp.substring(0,4)+"년 "+ Integer.parseInt(sTmp.substring(4,6))+"월 "+ Integer.parseInt(sTmp.substring(6,8))+"일 "+ sTmp.substring(8,10)+":"+sTmp.substring(10,12)+":"+ sTmp.substring(12,14);
				}else if( sTmp.length()==12 ){
					sDate = sTmp.substring(0,4)+"년 "+ Integer.parseInt(sTmp.substring(4,6))+"월 "+ Integer.parseInt(sTmp.substring(6,8))+"일 "+ sTmp.substring(8,10)+":"+sTmp.substring(10,12);
				}else if( sTmp.length()==8 ){
					sDate = sTmp.substring(0,4)+"년 "+ Integer.parseInt(sTmp.substring(4,6))+"월 "+ Integer.parseInt(sTmp.substring(6,8))+"일 ";
				}
			}else if(type==4){
				if( sTmp.length()==14 ){
					sDate = sTmp.substring(0,4)+"-"+ sTmp.substring(4,6)+"-"+ sTmp.substring(6,8)+" "+ sTmp.substring(8,10)+":"+sTmp.substring(10,12)+":"+ sTmp.substring(12,14);
				}else if( sTmp.length()==12 ){
					sDate = sTmp.substring(0,4)+"-"+ sTmp.substring(4,6)+"-"+ sTmp.substring(6,8)+" "+ sTmp.substring(8,10)+":"+sTmp.substring(10,12);
				}else if( sTmp.length()==8 ){
					sDate = sTmp.substring(0,4)+"-"+ sTmp.substring(4,6)+"-"+ sTmp.substring(6,8)+" ";
				}
			}
		}catch(Exception e){
			return "";
		}
		return sDate;
	}
	
	public static String getDateFormat(int type, String date, String s){
		
		String sDate = isNull(date);
		if("".equals(sDate)) return s;
		try{
			String sTmp = sDate;
			if(type==1){
				if( sTmp.length()==14 ){
					sDate = sTmp.substring(0,4)+"/"+ sTmp.substring(4,6)+"/"+ sTmp.substring(6,8)+" "+ sTmp.substring(8,10)+":"+sTmp.substring(10,12)+":"+ sTmp.substring(12,14);
				}else if( sTmp.length()==8 ){
					sDate = sTmp.substring(0,4)+"/"+ sTmp.substring(4,6)+"/"+ sTmp.substring(6,8);
				}
			}
		}catch(Exception e){
			return "";
		}
		return sDate;
	}
	
	
	/**
	 * ?쒓??몄퐫??
	 * @param String
	 * @return
	 */
	public static String encode(String str){
		try {
			//return new String(str.getBytes("8859_1"), "UTF-8");
			//return new String(str.getBytes("8859_1"), "KSC5601");
			//return new String(str.getBytes("8859_1"), "euc-kr");
			//return new String(str.getBytes("8859_1"), "iso-8859-1");
			
			//return new String(str.getBytes("iso-8859-1"), "UTF-8");
			//return new String(str.getBytes("iso-8859-1"), "KSC5601");
			//return new String(str.getBytes("iso-8859-1"), "euc-kr");
			
			//return new String(str.getBytes("KSC5601"), "8859_1");
			//return new String(str.getBytes("KSC5601"), "UTF-8");
			//return new String(str.getBytes("KSC5601"), "euc-kr");
			
			//return new String(str.getBytes("UTF-8"), "KSC5601");
			return new String(str.getBytes("UTF-8"), "8859_1");
			//return new String(str.getBytes("UTF-8"), "euc-kr");
			
			//return str;
			
		} catch (Exception e){return null;}

	}
	
	/*
	 * ?곷Ц???쒓?濡?蹂?솚
	 */
	public static String E2K( String english ){
		String korean = null;
	
		if (english == null ) return "";
		
		try {
			korean = new String(english);
		}
		catch( Exception e ){
			korean = new String(english);
		}
		return korean.trim();
	}

	public static String K2E( String o ){
		if(o == null){
			return "";
		}else{
			return o.toString().trim();
		} // end of if}
	}

	/*
	 * ?곷Ц???쒓?濡?蹂?솚
	 */
	public static String E2K( String english, String s ){
		String korean = null;
	
		if("".equals(isNull(english))) return s;
		
		try {
			korean = new String(english);
		}
		catch( Exception e ){
			korean = new String(english);
		}
		return korean.trim();
	}

	public static String K2E( String korean, String s ){
		String english = null;
	
		if("".equals(isNull(korean))) return s;
		
		try { 
			english = new String(new String(korean.getBytes("KSC5601"), "8859_1"));
		}
		catch( Exception e ){
			english = new String(korean);
		}
		return english.trim();
	}


	public static String toKorHex(String s){
		
		try { 
			if("".equals(isNull(s))){
				return "";
			}else{
				byte[] b = s.getBytes("KSC5601");
				StringBuffer sb = new StringBuffer();
				for(int i=0; i<b.length; i++){
					int hexVal = b[i]&0xFF;
					if ( hexVal < 0x10 ){
						sb.append("0"+Integer.toHexString(hexVal));
					}else{
						sb.append(Integer.toHexString(hexVal));
					}
				}
				return sb.toString();
			}
		}
		catch( Exception e ){
			return "";
		}
		
	}
	

	public static String toHexKor(String s){
		
		try { 
			if("".equals(isNull(s))){
				return "";
			}else{
				byte[] b = new byte[s.length() / 2];
				for (int i = 0; i < b.length; i++) {
					b[i] = (byte) Integer.parseInt(s.substring(2 * i, 2 * i + 2), 16);
				}
				return new String( b, "KSC5601");
			}
		}
		catch( Exception e ){
			return "";
		}
		
	}
		
	 /**
	 * 湲덉븸comma
	 * @param String
	 * @return
	 */
	public static String comma(String s)
    {
        try
        {
        	String tmp="";
        	String tmp2="";
        	if(s.indexOf(".",0) > -1 ){
        		tmp = s.substring(0,s.indexOf(".",0));
        		tmp2 =  s.substring(s.indexOf(".",0));
        	} else {
        		tmp = s;
        	}

        	long i = Long.parseLong(tmp);
            DecimalFormat decimalformat = new DecimalFormat("###,###,###,###");
            return decimalformat.format(i) +  tmp2;
        }
        catch(Exception exception)
        {
            return s;
        }
    }
	 /**
	 * 湲덉븸comma
	 * @param long
	 * @return
	 */
	 public static String comma(long i )
	    {
	        try
	        {
	            DecimalFormat decimalformat = new DecimalFormat("###,###,###,###");
	            return decimalformat.format(i);
	        }
	        catch(Exception exception)
	        {
	            return "" + i;
	        }
	    }


	 /**
		 * 臾몄옄??移섑솚
		 *
		 * @param str source String
		 * @param oldStr 諛붽? 臾몄옄??
		 * @param newStr 諛붾? 臾몄옄??
		 * @return String 蹂?꼍??臾몄옄??
		 */
		public static String replace(String str, String oldStr, String newStr){
			StringBuffer sb = new StringBuffer(str);
			int offset = sb.toString().indexOf(oldStr);
			int oldlength = oldStr.length();
			int newlength = newStr.length();

			while(offset >= 0){
			    sb.replace(offset,offset + oldlength, newStr);
			    offset = sb.toString().indexOf(oldStr, offset + newlength);
			}

			return sb.toString();
		}

		/**
		 * 臾몄옄?댁씠 Null?대㈃ ""??由ы꽩?쒕떎.
		 *
		 * @param value 諛붽? 臾몄옄??
		 * @return value null?대㈃ ""由ы꽩
		 */
		public static String isNull(Object o){
			if(o == null){
				return "";
			}else{
				return o.toString().trim();
			} // end of if
		}
		
		public static String isNull(Object o, String s){
			if("".equals(isNull(o))){
				return s;
			}else{
				return o.toString().trim();
			} // end of if
		}

	public static String isNull(Object o, Object s){
		if("".equals(isNull(o))){
			return s.toString().trim();
		}else{
			return o.toString().trim();
		} // end of if
	}
		
		/**
		 * 臾몄옄?댁씠 Null?대㈃ ""??由ы꽩?쒕떎.
		 *
		 * @param value 諛붽? 臾몄옄??
		 * @return value null?대㈃ ""由ы꽩
		 */
		public static String toString(String value){
			if(value == null){
				return "";
			}else{
				return value;
			} // end of if
		}

		/**
		 * 臾몄옄?댁씠 Null?대㈃ ""??由ы꽩?쒕떎.
		 *
		 * @param value 諛붽? 臾몄옄??
		 * @param change ??껜 臾몄옄??
		 * @return value 諛붾? 臾몄옄??
		 */
		public static String toString(String value, String change){
			if(value == null || value.length() < 1){
				return change;
			}else{
				return value;
			} // end of if
		}

		/**
		 * 湲?옄?섏젣??
		 *
		 * @param src 諛붽?臾몄옄??
		 * @param trail 瑗щ━??ex, "...")
		 * @param length ?쒗븳 ??湲몄씠
		 */
		public static String cropString(String value, String trail, int length){
			String temp = value;

			if(value == null)	return "";

			if(value.length() > length){
				temp = value.substring(0, length) + trail;
			}

			return temp;
		}
		
		public static String getDiffTime(String start, String end) throws Exception {
		    if( !"".equals(start) && !"".equals(end)){
				SimpleDateFormat formatter = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
			    Date startDate = formatter.parse(start);
			    Date endDate = formatter.parse(end);
			    
			    String s = getTimeFormat((int)((endDate.getTime() - startDate.getTime()) / 1000 ));
			    
			    return s;
		    }
		    return "";
		}





		
	public static String getMessage(String code){
		String message = (new StringBuilder("\uBA54\uC138\uC9C0 \uCF54\uB4DC[")).append(code).append("]\uAC00 messages.properties\uC5D0 \uC815\uC758\uAC00 \uB418\uC9C0 \uC54A\uC558\uC2B5\uB2C8\uB2E4. ").toString();
		try{
			message = MessageUtil.getMessage(code, null, Locale.getDefault());
		}catch(Exception e){
			return "";
		}
		return message;
	}

	public static String getMessageParam(String code, Object args[]){
		String message = (new StringBuilder("\uBA54\uC138\uC9C0 \uCF54\uB4DC[")).append(code).append("]\uAC00 messages.properties\uC5D0 \uC815\uC758\uAC00 \uB418\uC9C0 \uC54A\uC558\uC2B5\uB2C8\uB2E4. ").toString();
		try{
			if(args == null)
				message = MessageUtil.getMessage(code, null, "", Locale.getDefault());
			else
				message = MessageUtil.getMessage(code, args, "", Locale.getDefault());
		}catch(Exception e){
			return "";
		}
	        return message;
	}
	
	public static String getMessageSplit(String code, String str, String token){
		String message = (new StringBuilder("\uBA54\uC138\uC9C0 \uCF54\uB4DC[")).append(code).append("]\uAC00 messages.properties\uC5D0 \uC815\uC758\uAC00 \uB418\uC9C0 \uC54A\uC558\uC2B5\uB2C8\uB2E4. ").toString();
		try{
			if(str == null){
				message = MessageUtil.getMessage(code, null, "", Locale.getDefault());
			}else{
				String args[] = null;
				if( token != null && token.length()>0){
					args = str.split(token);
				}else{
					args = new String[1];
					args[0] = str;
				}
				message = MessageUtil.getMessage(code, args, "", Locale.getDefault());
			}
		}catch(Exception e){
			return "";
		}
	        return message;
	}
	
	public static Map collectParameters(HttpServletRequest req)
														throws Exception{
		Enumeration paramNames = req.getParameterNames();
		String key = null;
		String values[] = null;
		Map<String, Object> map = new HashMap<String, Object>();
		
		while( paramNames.hasMoreElements() ) {
			key = (String)paramNames.nextElement();
			values = req.getParameterValues(key);
			
			if( values != null && values.length == 1){
				
				map.put(key, CommonUtil.replaceXmlStr(values[0].trim()));
				
			}else{
				map.put(key, values);
			}
		}
		return map;
	}
	
	public static Map collectParametersK2E(HttpServletRequest req)
														throws Exception{
		Enumeration paramNames = req.getParameterNames();
		String key = null;
		String values[] = null;
		Map<String, Object> map = new HashMap<String, Object>();
		while( paramNames.hasMoreElements() ) {
			key = (String)paramNames.nextElement();
			values = req.getParameterValues(key);
			
			if( values != null && values.length == 1){
				map.put(key, K2E(values[0].trim()));
			}else{
				map.put(key, values);
			}
		}
		return map;
	}
	
	public static Map collectParametersForecast(HttpServletRequest req) throws Exception {
		
		Enumeration paramNames = req.getParameterNames();
		String key = null;
		String values[] = null;
		Map<String, Object> map = new HashMap<String, Object>();

		while (paramNames.hasMoreElements()) {
			key = (String) paramNames.nextElement();
			values = req.getParameterValues(key);

			if (values != null && values.length == 1) {
				map.put(key, values[0].trim());
			} else {
				map.put(key, values);
			}
		}
		return map;
	}
	

	public static Map collectParametersMulti(HttpServletRequest req, String file_path) throws Exception{
		
		MultipartHttpServletRequest multi = (MultipartHttpServletRequest) req;
		
		Enumeration paramNames = multi.getParameterNames();
		String key = null;
		String values[] = null;
		Map<String, Object> map = new HashMap<String, Object>();
		
		while( paramNames.hasMoreElements() ) {
			key = (String)paramNames.nextElement();
			values = multi.getParameterValues(key);
			
			if( values != null && values.length == 1){
				map.put(key, values[0].trim());
			}else{
				map.put(key, values);
			}
		}
		
		Iterator fileNameIterator = multi.getFileNames();
		List fileList = new ArrayList();
		int k = 0 ;
		while (fileNameIterator.hasNext()) {
			MultipartFile multiFile = multi.getFile((String) fileNameIterator.next());
			
			if(!multiFile.isEmpty()){
            	String newFileName = multiFile.getOriginalFilename();
            	if(FileUpload.uploadFormFile(multiFile, file_path , newFileName)){
            		fileList.add(newFileName);
            	}
            }
		}
		
		map.put("fileList",fileList);
		
		return map;
		
	}
	
	
	public static String reqXmlDebug(Object o){
		com.bmc.ctm.bpi.ifc.EmApiXmlGenerator test = new com.bmc.ctm.bpi.ifc.EmApiXmlGenerator();
		return test.getRequestXml(o);
	}
	
	public static void dispatch (HttpServletRequest request, 
							HttpServletResponse response, 
							String returnPage) throws javax.servlet.ServletException, java.io.IOException {
		ServletContext sc 		= request.getSession().getServletContext();
		RequestDispatcher rd 	= sc.getRequestDispatcher(returnPage);
		rd.forward(request, response);
	}
    
	public static void redirect (HttpServletRequest request, 
						HttpServletResponse response, 
						String returnPage) throws javax.servlet.ServletException, java.io.IOException {
		response.sendRedirect(returnPage);
	}
	
	public static boolean isLogin(HttpServletRequest req) throws ServletException, IOException, Exception{
		if( "".equals(isNull(req.getSession().getAttribute("USER_ID"))) ){
			return false;
		}
		return true;
	}
	
	public static void emLogin(HttpServletRequest req) throws ServletException, IOException, Exception{  
		
		Map<String, Object> paramMap 	= collectParameters(req);
		Map<String, Object> rMap 		= new HashMap<String, Object>();
		
		JSONObject responseJson = null;
		JsonObject params 		= null;
		String getResonse		= "";
		
		String strEmUserId = CommonUtil.isNull(CommonUtil.getMessage("EM.USER.ID"));
		String strEmUserPw = CommonUtil.isNull(CommonUtil.getMessage("EM.USER.PW"));
		
		params = new JsonObject();
		params.addProperty("username", strEmUserId);
		params.addProperty("password", strEmUserPw);
		
		String AAPI_URL = CommonUtil.isNull(CommonUtil.getMessage("AAPI_URL."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));

		com.ghayoun.ezjobs.common.axis.ConnectionManager cm = new com.ghayoun.ezjobs.common.axis.ConnectionManager();
		
		boolean bTokenChk = false;
		
		//세션에 USER_TOKEN 유무 체크 후 없으면 건너뛰고 있으면 EM API로 토큰 유효성 체크
		if ( !isNull(req.getSession().getAttribute("USER_TOKEN")).equals("") ) {
		    if( cm.chkUserToken(isNull(req.getSession().getAttribute("USER_TOKEN"))) ){
		    	
		        //유효성 체크 후 정상이면 true로 변경
		        bTokenChk = true;
		    }
		}
		
		// 세션에 USER_TOKEN이 없거나 유효성 체크 후 토큰이 정상이 아니라면 로그인처리
		if ( !bTokenChk ) {
			
			// 로그인
		    responseJson = AAPI_Util.restApiRun(AAPI_URL + "/session/login", "POST", params, "");
		    
		    logger.info("responseJson : " + responseJson);
		    
		    //token 정상적으로 구해오지 못할 시 예외처리.
		    if ( responseJson.toString().indexOf("token") <= -1 ) {
		    	
		    	org.json.JSONArray errors = responseJson.getJSONArray("errors");
		    	String loginfail = errors.getJSONObject(0).getString("message");
		    	
		    	Map rMap2 = new HashMap();
				rMap2.put("r_code",	"-2");
				rMap2.put("r_msg",	loginfail);
				
				System.out.println("rMap2 : " + rMap2);
				throw new DefaultServiceException(rMap2);
		    }
		    
		    String token = (String)responseJson.get("token");

		    req.getSession().setAttribute("USER_TOKEN", token);
		}
		
//		기존소스 주석처리 2023-11-06 이상훈.
//		if( !cm.chkUserToken(isNull(req.getSession().getAttribute("USER_TOKEN"))) ){
//
//			com.ghayoun.ezjobs.comm.repository.CommonDao commonDao = new com.ghayoun.ezjobs.comm.repository.CommonDaoImpl();
//			
//			rMap 			= commonDao.emLogin(paramMap);
//		    	
//			String rCode 	= isNull(rMap.get("rCode"));
//			String rMsg 	= isNull(rMap.get("rMsg"));
//			String rObject 	= isNull(rMap.get("rObject"));
//
//			if( "1".equals(rCode) ){
//
//				ResponseUserRegistrationType t = (ResponseUserRegistrationType)rMap.get("rObject");
//				req.getSession().setAttribute("USER_TOKEN",t.getUserToken());
//			
//			} else {
//
//				Map errMap = new HashMap();
//				errMap.put("r_code",	rCode);
//				errMap.put("r_msg",		rMsg);
//
//				throw new DefaultServiceException(errMap);
//			}
//		}
	}
	
	public static String getTimeFormat(int sec){
		String s = "00:00:00";
		if( sec>0 ){
			int iTmp1 = sec%3600;
			int iSec = iTmp1%60;
			int iHour = (sec - iTmp1)/3600;
			int iMin = (iTmp1 - iSec)/60;
			
			s = ((iHour<10)?"0"+iHour:""+iHour)+":"+((iMin<10)?"0"+iMin:""+iMin)+":"+((iSec<10)?"0"+iSec:""+iSec);
		}
		return s;
	}
	
	public static String getCurDate(String s){     
		
		String result = "";
		
		java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyyMMddHHmmssSS"); 
		String today     = formatter.format(new java.util.Date()); 
		String cur_year  = today.substring(0,4);
		String cur_month = today.substring(4,6);
		String cur_day   = today.substring(6,8);
		String cur_hour   = today.substring(8,10);
		String cur_min   = today.substring(10,12);
		String cur_sec   = today.substring(12,14);
		String cur_mil   = today.substring(14,15);
		
		if( "YMDHM".equals(s) ){
			result = cur_year+cur_month+cur_day+cur_hour+cur_min+cur_sec+cur_mil;
		}else if( "YMDH".equals(s) ){
			result = cur_year+cur_month+cur_day+cur_hour+cur_min+cur_sec;
		}else if( "YMD".equals(s) ){
			result = cur_year+cur_month+cur_day;
		}else if( "Y/M/D".equals(s) ){
			result = cur_year + "/" + cur_month + "/" + cur_day;
		}else if( "YM".equals(s) ){
			result = cur_year+cur_month;
		}else if( "MD".equals(s) ){
			result = cur_month+cur_day;
		}else if( "Y".equals(s) ){
			result = cur_year;
		}else if( "M".equals(s) ){
			result = cur_month;
		}else if( "D".equals(s) ){
			result = cur_day;		
		}else{
			result = cur_year+cur_month+cur_day;
		}
		
		return result;
	}	

	/**
	 * 문자열(sql)을 입력받아 해당되는 캐릭터(ch)를 문자열(s)로 대체한 문자열을 리턴한다.
	 * 리턴값('/n')을 &lt;br&gt; 로 바꾼다든지 할때 사용할 수 있다.
	 */
	public static String replace(String sql, char ch, String s) {
		StringBuffer news = new StringBuffer();
		if (!sql.equals("")) {
			char[] c1 = sql.toCharArray();
			char[] c2 = s.toCharArray();
			for (int i=0 ; i<c1.length ; i++ ) {
				if (c1[i] == ch) {
					for (int j=0 ; j<c2.length ; j++ ) {
						news.append(c2[j]);
					}
				} else {
					news.append(c1[i]);
				}
			}
		}
		return news.toString();
	}
	
	/**
	 * 특수문자를 HTML태그로 변환
	 * @param sql
	 * @return
	 */
	public static String replaceHtmlStr(String sql) {
		String Tmp_str = "";
		if (!sql.equals("")) {
			Tmp_str = replace(sql, '\'', "&apos;");
			Tmp_str = replace(Tmp_str, '\"', "&quot;");
			Tmp_str = replace(Tmp_str, '<', "&lt;");
			Tmp_str = replace(Tmp_str, '>', "&gt;");
			Tmp_str = replace(Tmp_str, '\n', "<br>");
		}
		return Tmp_str;
	}
	
	/**
	 * HTML태그를 특수문자로 변환
	 * @param sql
	 * @return
	 */
	public static String replaceStrHtml(String sql) {
		String Tmp_str = "";
		if (!sql.equals("")) {
			Tmp_str = replace(sql, "&apos;", "\'");
			Tmp_str = replace(Tmp_str, "&amp;", "&");
			Tmp_str = replace(Tmp_str, "&quot;", "\"");
			Tmp_str = replace(Tmp_str, "&lt;", "<");
			Tmp_str = replace(Tmp_str, "&gt;", ">");
			Tmp_str = replace(Tmp_str, "<br>", "\n");
		}
		return Tmp_str;
	}
	
	/**
	  * XML 특수 문자 처리
	  * XML에서 특정 문자열을 출력시 파싱 오류가 나는 사전 정의어를 파싱해준다.
	  * throws UtilException
	  */
	 public static String replaceXmlStr(String str) {
	  str = replace(str, "\"", "&quot;");
	  //str = replace(str, "\"", "&amp;quot;");	  
	  str = replace(str, "&", "&amp;");
	  
	  // 검색 조건에 &가 POST 방식으로 넘어오면 %26 으로 넘어온다.
	  // %26을 &amp; 로 치환 해서 테스트 중 (2020.07.29 강명준)
	  str = replace(str, "%26", "&amp;");
	  
	  str = replace(str, "\'", "&apos;");
	  str = replace(str, "<", "&lt;");
	  str = replace(str, ">", "&gt;");
	  str = replace(str, "\"", "&quot;");
	  str = str.trim();
	  return str;
	 }
	 
	 public static String replaceStrXml(String str) {
		  str = replace(str, "&quot;", "\"");
		  str = replace(str, "&amp;", "&");
		  str = replace(str, "&apos;", "\'");
		  str = replace(str, "&lt;", "<");
		  str = replace(str, "&gt;", ">");
		  str = str.trim();
		  return str;
		 }

	 public static Marshaller marshalling(JAXBContext context) throws JAXBException {
		 
		 Marshaller marshaller = context.createMarshaller();
			
		 marshaller.setProperty(Marshaller.JAXB_ENCODING, "ISO-8859-1");
		 marshaller.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT,  Boolean.TRUE); 
		 marshaller.setProperty(Marshaller.JAXB_FRAGMENT,   Boolean.TRUE);	
		 
		 marshaller.setProperty("com.sun.xml.bind.namespacePrefixMapper", new com.sun.xml.bind.marshaller.NamespacePrefixMapper() {
			
			 @Override
			 public String getPreferredPrefix(String arg0, String arg1, boolean arg2) {
				 return "ctmem";
			 }
		 });
		 
		 return marshaller;
	 }
	 
	 public static String marshllingAdd(java.io.StringWriter sw) throws JAXBException {

		 String reqXml = ""; 
		 reqXml+= "<?xml version='1.0' encoding='ISO-8859-1'?>";
		 reqXml+= "<SOAP-ENV:Envelope xmlns:SOAP-ENV='http://schemas.xmlsoap.org/soap/envelope/'>";
		 reqXml+= "<SOAP-ENV:Body>";
		 reqXml+= sw.toString();
		 reqXml+= "</SOAP-ENV:Body>";
		 reqXml+= "</SOAP-ENV:Envelope>";
		 
		 return reqXml;
	 }
	 
	 public static Map apiErrorProcess(String strResData) throws JAXBException {
			
		Map<String, Object> map = new HashMap<String, Object>();
		 
		String strResXml = "";

		// 리턴 XML 값을 언마샬링 할 수 있게 가공.				
		strResXml 		= strResData.substring(strResData.indexOf("error_list")-7);				
		strResXml 		= strResXml.substring(0, 18) + " xmlns:ctmem=\"http://www.bmc.com/ctmem/schema900\" " + strResXml.substring(18, strResXml.length());
		strResXml 		= strResXml.substring(0, strResXml.lastIndexOf("ctmem:error_list>")+17);				
		
		// 언마샬링 해서 값을 담는다.
		ByteArrayInputStream bais 		= new ByteArrayInputStream(strResXml.getBytes());
        JAXBContext context2 			= JAXBContext.newInstance(ErrorListType.class);
        Unmarshaller unMarshaller 		= context2.createUnmarshaller();
        ErrorListType dataRoot 		= (ErrorListType) unMarshaller.unmarshal(bais);
         
        String strErrorMsg = "";
         
        for ( int i = 0; i < dataRoot.getError().size(); i++ ) {	            	
        	strErrorMsg += dataRoot.getError().get(i).getErrorMessage();	            	
        }
        
     	map.put("rCode", "0");
		map.put("r_code", "0");
		map.put("rType", "fault_type");
		map.put("rMsg", strErrorMsg);
		map.put("r_msg", strErrorMsg);
		map.put("rObject", dataRoot);
		 
		return map;
	}
	
	public static Map apiPollErrorProcess(String strResData) throws JAXBException {
		
		Map<String, Object> map = new HashMap<String, Object>();
		 
		String strResXml = ""; 

		// 리턴 XML 값을 언마샬링 할 수 있게 가공.
		strResXml 		= strResData.substring(strResData.indexOf("<ctmem:fault_poll_order_force"), strResData.indexOf("</ctmem:fault_poll_order_force>")+31); 
		strResXml		= CommonUtil.replaceStrXml(strResXml);
		System.out.println("strResXml : " + strResXml);	 
		
		// 언마샬링 해서 값을 담는다.
		ByteArrayInputStream bais 				= new ByteArrayInputStream(strResXml.getBytes());
	    JAXBContext context2 					= JAXBContext.newInstance(FaultOrderForceWithJobsType.class);	    
	    Unmarshaller unMarshaller 				= context2.createUnmarshaller();	    
	    FaultOrderForceWithJobsType dataRoot 	= (FaultOrderForceWithJobsType) unMarshaller.unmarshal(bais);
         
        String strErrorMsg 	= dataRoot.getJobs().getJob().get(0).getErrorList().getError().get(0).getErrorMessage();
        strErrorMsg			= strErrorMsg.replaceAll("'", "").replaceAll("\n", " ");
        
     	map.put("rCode", "0");
		map.put("rType", "fault_type");
		map.put("rMsg", strErrorMsg);
		map.put("rObject", dataRoot);
		 
		return map;
	}
	
	// 첨부파일 등록 시 파일명 랜덤하게 재생성.
	public static Map collectParametersMultiRandomNm(HttpServletRequest req, String file_path) throws Exception{
		
		MultipartHttpServletRequest multi = (MultipartHttpServletRequest) req;
		
		Enumeration paramNames = multi.getParameterNames();
	
		String key = null;
		String values[] = null;
		Map<String, Object> map = new HashMap<String, Object>();
		
		while( paramNames.hasMoreElements() ) {
			key = (String)paramNames.nextElement();
			values = multi.getParameterValues(key);
			
			if( values != null && values.length == 1){
				map.put(key, CommonUtil.replaceXmlStr(values[0].trim()));
				//map.put(key, values[0].trim());
			}else{
				map.put(key, values);
			}
		}
		
		Iterator fileNameIterator = multi.getFileNames();
		List fileList = new ArrayList();
		int k = 0 ;
		
		while (fileNameIterator.hasNext()) {
			
			MultipartFile multiFile = multi.getFile((String) fileNameIterator.next());
			
			if(!multiFile.isEmpty()){
				
            	String newFileName = multiFile.getOriginalFilename();            	
				String saveFileName = Long.toString(System.currentTimeMillis());
				
				System.out.println("newFileName : " + newFileName);
				System.out.println("saveFileName : " + saveFileName);
				
				String[] newFileNms = newFileName.split("\\.");
				
				saveFileName = saveFileName + "." + newFileNms[newFileNms.length-1];
				
            	if(FileUpload.uploadFormFile(multiFile, file_path , saveFileName)){
            		
            		fileList.add(newFileName);
            		fileList.add(saveFileName);
            	}
            }
		}
		
		map.put("fileList",fileList);
		
		return map;
		
	}	
	
	// 자바 숫자 체크.
	public static boolean NumberChk(String str) {
		
		if ( str.equals("") ) {
			return false;			
		}
		
		for ( int i = 0; i < str.length(); i++ ) {
			int check = str.charAt(i);
			if ( check < 48 || check > 57 ) {
				return false;
			}
		}
		
		return true;		
	}
	
	// 문자열 왼쪽에 자릿수 채우기. 
	public static String lpad(String str, int len, String addStr) {
		
        String result = str;        
        int templen   = len - result.length();

        for (int i = 0; i < templen; i++){
              result = addStr + result;
        }
        
        return result;
     }

	// setTimeOut
	public static Boolean setTimeout(int delayTime) {
		
		long now = System.currentTimeMillis();
		long currentTime = 0;

		while( currentTime - now< delayTime){
			currentTime  = System.currentTimeMillis();
		}
		
		return true;
	}
	
	public static Object beanTobean(Object bean1, Object bean2) {
		org.springframework.beans.BeanUtils.copyProperties(bean1,bean2);
		return bean2;
	}

	public static Map<String, Object> checkHost() {
		
		Map<String, Object> map = new HashMap<String, Object>();
		Boolean chkHost = false;
		map.put("mcode_cd", "M2");
		
		//Ezjobs 이중화 체크로직 적용 2024.07.24 이상훈
		List quartzHostList = getComCodeList(map);
			
		CommonBean bean1 = (CommonBean) quartzHostList.get(0);
		
		String strHost 		= "";
		String strHostAddr  = "";
		
		strHost 		= isNull(bean1.getScode_eng_nm());
		strHostAddr  	= isNull(bean1.getScode_nm());
		
	    HttpURLConnection connection;
		try {
				connection = (HttpURLConnection) new URL(strHostAddr).openConnection();
				connection.setRequestMethod("GET");
				connection.connect();
				
				System.out.println("strHostAddr : " + strHostAddr);
				
			    int responseCode = connection.getResponseCode();
			    
			    System.out.println("res code : " + responseCode);

		        if (responseCode == 200) {
		    	    System.out.println("connect success");
		        }else {
		        	System.out.println("strHostAddr : " + strHostAddr);
		    	    System.out.println("connect fail");
		        }
				
				InetAddress addr = null;
				addr = InetAddress.getLocalHost();
				System.out.println("addr : " + addr);
				String strHostName = addr.getHostName();
				
				if(strHostName.equals(strHost)) {
					chkHost = true;
				}
				map.put("scode_host"	, strHost);
				map.put("server_host"	, strHostName);
				map.put("chkHost"		, chkHost);
			
		} catch (java.net.ConnectException e) {
			
			e.printStackTrace();
			
			if(quartzHostList.size() > 1) {
				CommonBean bean2 = (CommonBean) quartzHostList.get(1);
			
				strHost 		= isNull(bean2.getScode_eng_nm());
				strHostAddr  	= isNull(bean2.getScode_nm());
			
				try {
					connection = (HttpURLConnection) new URL(strHostAddr).openConnection();
					connection.setRequestMethod("GET");
					connection.connect();
					
					System.out.println("strHostAddr : " + strHostAddr);
					
				    int responseCode = connection.getResponseCode();
				    
				    System.out.println("res code : " + responseCode);
		
			        if (responseCode == 200) {
			    	    System.out.println("connect success");
			        }else {
			        	System.out.println("strHostAddr : " + strHostAddr);
			    	    System.out.println("connect fail");
			        }
					
					InetAddress addr = null;
					addr = InetAddress.getLocalHost();
					String strHostName = addr.getHostName();
					
					if(strHostName.equals(strHost)) {
						chkHost = true;
					}
					map.put("scode_host"	, strHost);
					map.put("server_host"	, strHostName);
					map.put("chkHost"		, chkHost);
				}catch (Exception e2) {
					e2.printStackTrace();
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} 
		
		return map;
	}


	public static Map<String, Object> ConvertObjectToMap(Object obj) throws IllegalAccessException, IllegalArgumentException, InvocationTargetException {
		
		try {
            //Field[] fields = obj.getClass().getFields(); //private field는 나오지 않음.
            Field[] fields = obj.getClass().getDeclaredFields();
            Map resultMap = new HashMap();
            for(int i=0; i<=fields.length-1;i++){
                fields[i].setAccessible(true);
                resultMap.put(fields[i].getName(), fields[i].get(obj));
            }
            return resultMap;
        } catch (IllegalArgumentException e) {
            e.printStackTrace();
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        }
        return null;
	}
	
	public static Object convertMapToObject(Map map, Object objClass) {
		
        String keyAttribute = null;
        String setMethodString = "set";
        String methodString = null;
        Iterator itr = map.keySet().iterator();
        while(itr.hasNext()){
            keyAttribute = (String) itr.next();
            methodString = setMethodString+keyAttribute.substring(0,1).toUpperCase()+keyAttribute.substring(1);
            try {
                Method[] methods = objClass.getClass().getDeclaredMethods();
                for(int i=0;i<=methods.length-1;i++){
                    if(methodString.equals(methods[i].getName())){
                        System.out.println("invoke : "+methodString);
                        methods[i].invoke(objClass, map.get(keyAttribute));
                    }
                }
            } catch (SecurityException e) {
                e.printStackTrace();
            } catch (IllegalAccessException e) {
                e.printStackTrace();
            } catch (IllegalArgumentException e) {
                e.printStackTrace();
            } catch (InvocationTargetException e) {
                e.printStackTrace();
            }
        }
        return objClass;
    }
	
	// 문자열 중복 제거
	public static String dupStringCheck(String str) {
		
		TreeSet tset 		= new TreeSet();
		StringBuffer news 	= new StringBuffer();
		
		String[] tokens = str.split(",");
	     
		for(int i = 0; i < tokens.length; i++) {
			tset.add(tokens[i]);
		}
	  
		Iterator itor = tset.iterator();
		
	    while(itor.hasNext()) {
	    	news.append(itor.next());
	    	news.append(",");
	    }
	    
	    return news.toString();		
	}
	
	/**
	 * @param resClass
	 * @param strResXml
	 * @return
	 * @throws JAXBException
	 */
	public static <T> JAXBElement<? extends T> unmarshaller (Class<? extends T> resClass, String strResXml) throws JAXBException {
        
		try {
			try {
				//strResXml = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>" + strResXml;
	        	DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
	        	dbFactory.setExpandEntityReferences(false);
//	        	String a = new String(strResXml.getBytes(), "UTF-8");
				Document doc = dbFactory.newDocumentBuilder().parse(new InputSource(new StringReader(strResXml)));
				Unmarshaller unMarshaller = JAXBContext.newInstance(resClass).createUnmarshaller();
				return (JAXBElement<T>) unMarshaller.unmarshal(doc, resClass); 
			} catch (Exception e) {
				e.printStackTrace();
				throw new JAXBException(e.getMessage());
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			throw new JAXBException(e.getMessage());
		}
		
		
	}
	
	public static WebApplicationContext getWebApplicationContext(){
		return ContextLoader.getCurrentWebApplicationContext();
	}
	
	public static String getWebRootPath() {    
		String file_path = getWebApplicationContext().getServletContext().getRealPath("/").replaceAll("\\\\", "/");
		return file_path.substring(0,file_path.length()-1);
	}
	
	public static Object getSpringBean(String beanName) {
		return getWebApplicationContext().getBean(beanName);
	}
	
	
	
	@SuppressWarnings("rawtypes")
	public static List setRowNums(List l, Paging paging) {
		try {
			int row_num = 1;
			if(paging!=null) row_num = paging.getSkipRowSize()+1;
			for(int i=0; l!=null&&i<l.size();i++){
				
				Object obj = l.get(i);
				Class c = obj.getClass();
				
				Method m = c.getMethod("setRow_num", new Class[] {int.class});
				m.invoke(obj, new Object[] {row_num+i});
				l.set(i, obj);
			}
			
		} catch (Exception e) {
			return l;
		}
		return l;
	}
	
	public static String getRemoteIp(HttpServletRequest req) throws UnknownHostException {
		
		String ip = req.getHeader("HTTP_X_FORWARDED_FOR");
		
		if(ip==null) ip = req.getRemoteAddr();
		//if(ip==null) ip = InetAddress.getLocalHost().getHostAddress();
		
		return ip;
	}
	
	public static String getCurDateTo(String ymd, int d){     
		
		String result = "";
		
		String year 	= ymd.substring(0,4);
		String month = ymd.substring(4,6);
		String day 	= ymd.substring(6,8);
		
		Calendar cal = Calendar.getInstance();
		cal.set(Calendar.YEAR,Integer.parseInt(year));
		cal.set(Calendar.MONTH,Integer.parseInt(month)-1);
		cal.set(Calendar.DATE,Integer.parseInt(day));
		
		cal.add(Calendar.DATE,d);
		
		java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyyMMdd"); 
		result = formatter.format(cal.getTime());
		
		return result;
	}
	
	public static String getDateFormat2(String dt) throws ParseException{
		
		if(dt.equals("")) return "";
		if(dt.length() < 14) return dt;
		
		String pattern = "EEE, dd MMM yyyy HH:mm:ss Z";
		SimpleDateFormat format = new SimpleDateFormat(pattern, Locale.ENGLISH);
		Date javaDate = format.parse(dt);
		
		SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd a HH:mm:ss"); 
		String today     = formatter.format(javaDate); 
		
		return today;
	}
	
	public static String toDate(){
		
		String rtn = "";
		
		Date dt = new Date();
		SimpleDateFormat sf = new SimpleDateFormat("yyyyMMdd");
		rtn = sf.format(dt);
		
		return rtn;
	}
	
	public static String toPrevDate(){
		
		String rtn = "";
		
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.DATE,-1);
				
		SimpleDateFormat sf = new SimpleDateFormat("yyyyMMdd");
		rtn = sf.format(cal.getTime());
		
		return rtn;
	}
	
	public static String toNextDate(){
		
		String rtn = "";
		
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.DATE,-1);
				
		SimpleDateFormat sf = new SimpleDateFormat("yyyyMMdd");
		rtn = sf.format(cal.getTime());
		
		return rtn;
	}
	
	//천단위 콤마
	public static String toNumFormat(Long num) {
	  DecimalFormat df = new DecimalFormat("#,###");
	  return df.format(num);
	}
	
	public static String toNumFormat(int num) {
	  DecimalFormat df = new DecimalFormat("#,###");
	  return df.format(num);
	}
	public static String toNumFormat(String num) {
	  DecimalFormat df = new DecimalFormat("#,###");
	  return df.format(Long.parseLong(num));
	}
	
	public static String getUserGbNm(){
		
		String[] gb = null;
		String[] gb_cd = null;
		String gb_nm = "";
		
		try{			
			
			String gb_all = CommonUtil.getMessage("USER.GB");
			gb = gb_all.split(",");
			
			for(int i=0;i<gb.length;i++){
				gb_cd = gb[i].split("[|]");
				
				for(int j=0;j<gb_cd.length;j++){
					if(j == gb_cd.length-1){
						gb_nm += CommonUtil.getMessage("USER.GB."+gb_cd[j]);
					}else{
						gb_nm += CommonUtil.getMessage("USER.GB."+gb_cd[j])+",";
					}
					
				}
			}		
			
		}catch(Exception e){
			e.getMessage();
		}
		
		return gb_nm;	
	}
	
	public static List<CompanyBean> getDeptList() {     
		Map paramMap = new HashMap();
		
		WorksCompanyService worksCompanyService = (WorksCompanyService)getSpringBean("tWorksCompanyService");
		
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		List<CompanyBean> l = worksCompanyService.dGetDeptList(paramMap);
		
		return l;
	}

	public static List<CompanyBean> getDutyList() {     
		
		Map paramMap = new HashMap();
		
		WorksCompanyService worksCompanyService = (WorksCompanyService)getSpringBean("tWorksCompanyService");
		
		paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		List<CompanyBean> l = worksCompanyService.dGetDutyList(paramMap);
		
		return l;
	}
	
	public static List<CommonBean> getDataCenterList(){
		
		Map<String, Object> map = new HashMap<>();
		
		CommonService commonService = (CommonService)getSpringBean("commonService");
		
		map.put("searchType", 	"dataCenterList");
		map.put("SCHEMA", 		CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		map.put("mcode_cd", 	CommonUtil.getMessage("COMCODE.APPGRP.CODE"));
		
		List<CommonBean> l = commonService.dGetSearchItemList(map);
		
		return l;
	}
	
	public static List<CommonBean> getOdateList(){
		
		Map<String, Object> map = new HashMap<>();
		
		CommonService commonService = (CommonService)getSpringBean("commonService");
		
		map.put("searchType", "odateList");
		map.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		List<CommonBean> l = commonService.dGetSearchItemList(map);
		
		return l;
	}
	
	public static List<CommonBean> getCtmOdateList(){
		
		Map<String, Object> map = new HashMap<>();
		
		CommonService commonService = (CommonService)getSpringBean("commonService");
		
		map.put("searchType", "ctmOdateList");
		map.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		List<CommonBean> l = commonService.dGetSearchItemList(map);
		
		return l;
	}
	
	public static List<CommonBean> getHostList(){
		
		Map<String, Object> map = new HashMap<>();
		
		CommonService commonService = (CommonService)getSpringBean("commonService");
		
		map.put("searchType", "hostList");
		map.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		List<CommonBean> l = commonService.dGetSearchItemList(map);
		
		return l;
	}
	
	public static List<CommonBean> getComCodeList(Map<String, Object> map){
		
		map.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		CommonService commonService = (CommonService)getSpringBean("commonService");
		List<CommonBean> l = commonService.dGetsCodeList(map);
		
		return l;
	}
	
	public static List<CommonBean> getComScodeList(Map<String, Object> map){
		
		HttpServletRequest request 	= ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
		HttpSession	session			= request.getSession(true);
		Map<String, Object> map2 = new HashMap<String, Object>();
		// 선행은 글로벌 컨디션을 셋팅할 수 있기 때문에 모든 C-M 표현하기 위한 구분자.
		String strGubun = CommonUtil.isNull(map.get("gubun"));
		
		
		CommonService commonService = (CommonService)getSpringBean("commonService");
		if ( strGubun.equals("") ) {
			List scodeDeptNmList 		= null;
			
			map2.put("mcode_cd", "M67");
			map2.put("SCHEMA", 	CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
			scodeDeptNmList = commonService.dGetsCodeList(map2);
			String dept_nm = "";
			String scode_nm = "";
			String s_dept_nm = CommonUtil.isNull(session.getAttribute("DEPT_NM"));
			map.put("s_dept_nm", 	s_dept_nm);
			for(int i=0; i<scodeDeptNmList.size(); i++){
				CommonBean bean = (CommonBean)scodeDeptNmList.get(i);
				
				scode_nm = CommonUtil.isNull(bean.getScode_nm());
				if(scode_nm.equals(s_dept_nm)){
					map.put("s_dept_nm", "카드ICT개발센터");
					continue;
				}
			}
		} else {
			map.put("s_dept_nm", 	"");
		}
		map.put("SCHEMA", 	CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		map.put("mcode_cd", CommonUtil.getMessage("COMCODE.APPGRP.CODE"));
		List<CommonBean> l = commonService.dGetScodeList(map);
		
		
		return l;
	}
	
	public static List<CommonBean> getWorkGroupItemList(Map<String, Object> map){
		CommonService commonService = (CommonService)getSpringBean("commonService");
		map.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		List<CommonBean> l = commonService.dGetWorkGroupItemList(map);
		return l;
	}
	
	//CTM 월캘린더/일캘린더
	public static List<CommonBean> getCTMcalenderList(Map<String, Object> map){
		
		CommonService commonService = (CommonService)getSpringBean("commonService");
		List<CommonBean> l = commonService.dGetSearchItemList(map);
		
		return l;
	}
	
	public static String getCtmActiveNetName(Map<String, Object> map){
		
		CommonService commonService = (CommonService)getSpringBean("commonService");
		String active_net_name = CommonUtil.isNull(commonService.dGetCtmActiveNetName(map));
		
		if(!active_net_name.equals("")) active_net_name = "A"+active_net_name;
		
		return active_net_name;
	}
	
	public static List<CommonBean> getMcodeList(Map map){
		
		map.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		
		WorksCompanyService worksCompanyService = (WorksCompanyService)getSpringBean("tWorksCompanyService");
		List<CommonBean> l = worksCompanyService.dGetMCodeList(map);
		
		return l;
	}
		
	//결재문서구분
	public static String getApprovalDocGb(){
		
		String[] gb = null;
		String gb_nm = "";
		
		try{			
			
			String gb_cd = CommonUtil.getMessage("APPROVAL.DOC.GB");
			gb = gb_cd.split(",");
			for(int i=0;i<gb.length;i++){
				if(i== gb.length-1){
					gb_nm += CommonUtil.getMessage("APPROVAL.DOC.GB."+gb[i]);
				}else{
					gb_nm += CommonUtil.getMessage("APPROVAL.DOC.GB."+gb[i])+",";
				}
			}		
			
		}catch(Exception e){
			e.getMessage();
		}
		
		return gb_nm;		
	}

	//사용자 결재라인 구분
	public static String getApprovalLineGb(){

		String[] gb = null;
		String gb_nm = "";

		try{

			String gb_cd = CommonUtil.getMessage("APPROVAL.GB");
			gb = gb_cd.split(",");
			for(int i=0;i<gb.length;i++){
				if(i== gb.length-1){
					gb_nm += CommonUtil.getMessage("APPROVAL.GB."+gb[i]);
				}else{
					gb_nm += CommonUtil.getMessage("APPROVAL.GB."+gb[i])+",";
				}
			}

		}catch(Exception e){
			e.getMessage();
		}

		return gb_nm;
	}

	//관리자 결재라인 구분
	public static String getApprovalAdminLineGb(){

		String[] gb = null;
		String gb_nm = "";

		try{

			String gb_cd = CommonUtil.getMessage("APPROVAL.ADMIN.GB");
			gb = gb_cd.split(",");
			for(int i=0;i<gb.length;i++){
				if(i== gb.length-1){
					gb_nm += CommonUtil.getMessage("APPROVAL.ADMIN.GB."+gb[i]);
				}else{
					gb_nm += CommonUtil.getMessage("APPROVAL.ADMIN.GB."+gb[i])+",";
				}
			}

		}catch(Exception e){
			e.getMessage();
		}

		return gb_nm;
	}

	//결재라인 구분
	public static String getApprovalTypeNm(){
		
		String[] gb = null;
		String gb_nm = "";
		
		try{			
			
			String gb_cd = CommonUtil.getMessage("APPROVAL.TYPE");
			gb = gb_cd.split(",");
			for(int i=0;i<gb.length;i++){
				if(i== gb.length-1){
					gb_nm += CommonUtil.getMessage("APPROVAL.TYPE."+gb[i]);
				}else{
					gb_nm += CommonUtil.getMessage("APPROVAL.TYPE."+gb[i])+",";
				}
			}		
			
		}catch(Exception e){
			e.getMessage();
		}
		
		return gb_nm;		
	}
	
	//문서 구분
	public static String getDocGubunNm(){
		
		String[] gb = null;
		String gb_nm = "";
		
		try{			
			
			String gb_cd = CommonUtil.getMessage("DOC_GUBUN");
			gb = gb_cd.split(",");
			for(int i=0;i<gb.length;i++){
				if(i== gb.length-1){
					gb_nm += CommonUtil.getMessage("DOC_GUBUN."+gb[i]);
				}else{
					gb_nm += CommonUtil.getMessage("DOC_GUBUN."+gb[i])+",";
				}
			}		
			
		}catch(Exception e){
			e.getMessage();
		}
		
		return gb_nm;		
	}
	
	//config에 따라 구분 값을 가져옴
	public static String getGbNm(String key) {
		String nm = "";
		String[] gbs = CommonUtil.getMessage(key).split(",");
		
		for (int i = 0; i < gbs.length; i++) {
			nm += CommonUtil.getMessage(key+"."+gbs[i]);
			
			if(i != gbs.length-1)
				nm += ",";
		}
		
		return nm;
	}

	//SHA256 암호화
	public static String toSha256(String s) {
		byte[] temp = s.getBytes();
		String result = null;

		try{
			java.security.MessageDigest sha256 = java.security.MessageDigest.getInstance("SHA-256");
			sha256.update(temp);
			result = toHex(sha256.digest());
			
		} catch(Exception e) {
			return null;
		}
		return result;
	}
	
	//SHA512 암호화
	public static String toSha512(String s) {
		byte[] temp = s.getBytes();
		String result = null;

		try{
			java.security.MessageDigest sha512 = java.security.MessageDigest.getInstance("SHA-512");
			sha512.update(temp);
			result = toHex(sha512.digest());
			
		} catch(Exception e) {
			return null;
		}
		return result;
	}
	
	public static String toHex(byte[] b){
		
		try { 
			StringBuffer buf = new StringBuffer();
			
			for(int i=0;i< b.length;i++){
				int hexVal = b[i]&0xFF;
				if ( hexVal < 0x10 ){
					buf.append("0"+Integer.toHexString(hexVal));
				}else{
					buf.append(Integer.toHexString(hexVal));
				}
			}
	    	
	    	return buf.toString();
		}
		catch( Exception e ){
			return "";
		}
		
	}
	
	public static String toMd5(String s) {
		byte[] temp = s.getBytes();
		String result = null;

		try{
			java.security.MessageDigest md5 = java.security.MessageDigest.getInstance("MD5");
			md5.update(temp);
			result = toHex(md5.digest());
		} catch(Exception e) {
			return null;
		}
		return result;
	}
	
	public static String toCrypEnc(String s) {
		String result = null;

		try{
			Crypto crypto = new Crypto();
			result = crypto.encrypt(s);
		} catch(Exception e) {
			return null;
		}
		return result;
	}
	
	public static String toCrypDec(String s) {
		String result = null;

		try{
			Crypto crypto = new Crypto();
			result = crypto.decrypt(s);
		} catch(Exception e) {
			return null;
		}
		return result;
	}
	
	public static String toHtmlEnc(String s){
		if(s == null){
			return "";
		}else{
			return s.replaceAll("\"", "&quot;").replaceAll("'", "&#39;").replaceAll("<", "&lt;").replaceAll(">", "&gt;");
		} 
	}
	
	public static String toHtmlDec(String s){
		if(s == null){
			return "";
		}else{
			return s.replaceAll("&quot;", "\"").replaceAll("&#39;", "'").replaceAll("&lt;", "<").replaceAll("&gt;",">");
		}
	}
			
	public static String getOnlyNum(String s){
		return (isNull(s).replaceAll("[^0-9]", ""));
	}
	
	public static String getHostIp(){
		
		String host_ip = "";
		
		try{
			
			String hostName = CommonUtil.getMessage("EZJOBS_HOSTNAME");
			InetAddress address = InetAddress.getByName(hostName);
			host_ip = address.getHostAddress();
						
		}catch(Exception e){
			e.getMessage();
		}
		
		return host_ip;
	}
	
	public static int getDefTableCnt(Map<String, Object> map){
		
		CommonService commonService = (CommonService)getSpringBean("commonService");
		int cnt = commonService.dGetDefTableCnt(map);
		
		return cnt;
	}
	
	public static String getQ_Resources(String data_center){
		
		String t_resources_q = "";
		
		if(data_center.indexOf("EXPERT") > -1){
			t_resources_q = "EXPERT@,1|ALLEXPERT,1";
		}else if(data_center.indexOf("CARD") > -1){
			t_resources_q = "CARD@,1|ALLCARD,1";								
		}else{
			t_resources_q = "WINI@,1|ALLWINI,1";
		}
		
		return t_resources_q;
	}
	
	public static String getI_Conditions(String data_center, String t_conditions_in, String job_name){
		
		/*
		
		String strTinConditions = "";
		
		System.out.println("t_conditions_in : " + t_conditions_in);
		
		// OEPN 작업일 경우는 해당 컨디션 셋팅 X.
		if ( !job_name.substring(2, 3).equals("O") ) {
			if(data_center.indexOf("EXPERT") > -1){
				strTinConditions = "EXPERT_BATCH_START,ODAT,and";
			}else if(data_center.indexOf("CARD") > -1){
				strTinConditions = "CARD_BATCH_START,ODAT,and";
			}else{
				strTinConditions = "WINI_BATCH_START,ODAT,and";
			}
		}
		
		System.out.println("strTinConditions : " + strTinConditions);
		
		if ( t_conditions_in.equals("") ) {
			t_conditions_in = strTinConditions;
		} else {
			t_conditions_in = t_conditions_in + "|" + strTinConditions;
		}
		
		System.out.println("t_conditions_in : " + t_conditions_in);
		
		if ( !t_conditions_in.equals("") && t_conditions_in.substring(t_conditions_in.length()-1, t_conditions_in.length()).equals("|") ) {			
			t_conditions_in = t_conditions_in.substring(0, t_conditions_in.length()-1);
		}
		
		System.out.println("t_conditions_in : " + t_conditions_in);
		
		*/
		
		return t_conditions_in;
	}
	
	// 통제 시간 적용 : M49
	public static String checkControlTime() {
	
		CommonService commonService 	= (CommonService)getSpringBean("commonService");
		Map<String, Object> paramMap 	= new HashMap<String, Object>();
		
		String strControlTimeCheckMent	= "";
		
		paramMap.put("mcode_cd", 	"M49");
		paramMap.put("SCHEMA", 		CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		List controlCodeList = commonService.dGetsCodeList(paramMap);		
		
		String strNowDate			= (DateUtil.getDay()+DateUtil.getTime()).substring(0, 12); 
		String strControlStartDate 	= "";
		String strControlEndDate 	= "";
		
		if ( controlCodeList != null && controlCodeList.size() == 2 ) {
			for ( int i = 0; i < controlCodeList.size(); i++ ) {
				CommonBean bean = (CommonBean)controlCodeList.get(i);
				
				if ( i == 0 ) {
					strControlStartDate = CommonUtil.isNull(bean.getScode_eng_nm());
				}
				
				if ( i == 1 ) {
					strControlEndDate = CommonUtil.isNull(bean.getScode_eng_nm());
				}
			}			
			
			if ( Long.parseLong(strControlStartDate) <= Long.parseLong(strNowDate) 
					&& Long.parseLong(strControlEndDate) >= Long.parseLong(strNowDate) ) {
				strControlTimeCheckMent = strControlStartDate + " ~ " + strControlEndDate + "까지 작업 통제 기간입니다.";
			}
		}
		
		return strControlTimeCheckMent;
	}
	
	// 최종 반영 후 JOB_MAPPER에 등록
	public static Map jobMapperInsertPrc(String doc_cd, String job_name) {
	
		Map<String, Object> map 	= new HashMap<>();
		Map<String, Object> rMap 	= new HashMap<>();
		
		// 배치 수행 시 세션을 못 가져오므로 하드코딩 해준다.
		// 수시 반영, 엑셀 반영
		String strUserCd 	= "1";
		String strUserIp 	= "127.0.0.1";
		
		try{
		
			HttpServletRequest request 	= ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
			HttpSession	session			= request.getSession(true);
			
			strUserCd = CommonUtil.isNull(session.getAttribute("USER_CD"), strUserCd);	// 외부에서 호출 할 경우 session 값이 없으므로 하드코딩 값 재 설정
			strUserIp = CommonUtil.isNull(session.getAttribute("USER_IP"), strUserIp);	// 외부에서 호출 할 경우 session 값이 없으므로 하드코딩 값 재 설정
			
		}catch(Exception e){
			e.getMessage();
		}
		
		map.put("doc_cd", 		doc_cd);
		map.put("job", 			job_name);
		map.put("SCHEMA", 		CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		map.put("s_user_cd", 	strUserCd);
		map.put("s_user_ip", 	strUserIp);
		map.put("flag", 		"one_update");
		
		try{
			
			WorksUserService worksUserService = (WorksUserService)getSpringBean("tWorksUserService");
			
			JobMapperBean jobMapperDocInfo = worksUserService.dGetJobMapperDocInfo(map);
			
			if ( jobMapperDocInfo != null ) {
			
				map.put("data_center", 			CommonUtil.isNull(jobMapperDocInfo.getData_center()));
				map.put("job", 					CommonUtil.isNull(jobMapperDocInfo.getJob()));				
				map.put("description", 			CommonUtil.isNull(jobMapperDocInfo.getDescription()));
				map.put("user_cd_1", 			CommonUtil.isNull(jobMapperDocInfo.getUser_cd_1()));
				map.put("user_cd_2", 			CommonUtil.isNull(jobMapperDocInfo.getUser_cd_2()));
				map.put("user_cd_3", 			CommonUtil.isNull(jobMapperDocInfo.getUser_cd_3()));
				map.put("user_cd_4", 			CommonUtil.isNull(jobMapperDocInfo.getUser_cd_4()));
				map.put("user_cd_5", 			CommonUtil.isNull(jobMapperDocInfo.getUser_cd_5()));
				map.put("user_cd_6", 			CommonUtil.isNull(jobMapperDocInfo.getUser_cd_6()));
				map.put("user_cd_7", 			CommonUtil.isNull(jobMapperDocInfo.getUser_cd_7()));
				map.put("user_cd_8", 			CommonUtil.isNull(jobMapperDocInfo.getUser_cd_8()));
				map.put("user_cd_9", 			CommonUtil.isNull(jobMapperDocInfo.getUser_cd_9()));
				map.put("user_cd_10", 			CommonUtil.isNull(jobMapperDocInfo.getUser_cd_10()));

				map.put("sms_1", 				CommonUtil.isNull(jobMapperDocInfo.getSms_1()));
				map.put("sms_2", 				CommonUtil.isNull(jobMapperDocInfo.getSms_2()));
				map.put("sms_3", 				CommonUtil.isNull(jobMapperDocInfo.getSms_3()));
				map.put("sms_4", 				CommonUtil.isNull(jobMapperDocInfo.getSms_4()));
				map.put("sms_5", 				CommonUtil.isNull(jobMapperDocInfo.getSms_5()));
				map.put("sms_6", 				CommonUtil.isNull(jobMapperDocInfo.getSms_6()));
				map.put("sms_7", 				CommonUtil.isNull(jobMapperDocInfo.getSms_7()));
				map.put("sms_8", 				CommonUtil.isNull(jobMapperDocInfo.getSms_8()));
				map.put("sms_9", 				CommonUtil.isNull(jobMapperDocInfo.getSms_9()));
				map.put("sms_10", 				CommonUtil.isNull(jobMapperDocInfo.getSms_10()));
				map.put("mail_1", 				CommonUtil.isNull(jobMapperDocInfo.getMail_1()));
				map.put("mail_2", 				CommonUtil.isNull(jobMapperDocInfo.getMail_2()));
				map.put("mail_3", 				CommonUtil.isNull(jobMapperDocInfo.getMail_3()));
				map.put("mail_4", 				CommonUtil.isNull(jobMapperDocInfo.getMail_4()));
				map.put("mail_5", 				CommonUtil.isNull(jobMapperDocInfo.getMail_5()));
				map.put("mail_6", 				CommonUtil.isNull(jobMapperDocInfo.getMail_6()));
				map.put("mail_7", 				CommonUtil.isNull(jobMapperDocInfo.getMail_7()));
				map.put("mail_8", 				CommonUtil.isNull(jobMapperDocInfo.getMail_8()));
				map.put("mail_9", 				CommonUtil.isNull(jobMapperDocInfo.getMail_9()));
				map.put("mail_10", 				CommonUtil.isNull(jobMapperDocInfo.getMail_10()));

				map.put("grp_cd_1", 			CommonUtil.isNull(jobMapperDocInfo.getGrp_cd_1()));
				map.put("grp_cd_2", 			CommonUtil.isNull(jobMapperDocInfo.getGrp_cd_2()));
				map.put("grp_sms_1", 			CommonUtil.isNull(jobMapperDocInfo.getGrp_sms_1()));
				map.put("grp_sms_2", 			CommonUtil.isNull(jobMapperDocInfo.getGrp_sms_2()));
				map.put("grp_mail_1", 			CommonUtil.isNull(jobMapperDocInfo.getGrp_mail_1()));
				map.put("grp_mail_2", 			CommonUtil.isNull(jobMapperDocInfo.getGrp_mail_2()));

				map.put("calendar_nm", 			CommonUtil.isNull(jobMapperDocInfo.getCalendar_nm()));
				map.put("late_sub", 			CommonUtil.isNull(jobMapperDocInfo.getLate_sub()));
				map.put("late_time", 			CommonUtil.isNull(jobMapperDocInfo.getLate_time()));
				map.put("late_exec", 			CommonUtil.isNull(jobMapperDocInfo.getLate_exec()));
				map.put("batchJobGrade", 		CommonUtil.isNull(jobMapperDocInfo.getBatchJobGrade()));
				map.put("error_description", 	CommonUtil.isNull(jobMapperDocInfo.getError_description()));
				map.put("success_sms_yn", 		CommonUtil.isNull(jobMapperDocInfo.getSuccess_sms_yn()));

				worksUserService.dPrcJobMapper(map);
			}
			
		}catch(Exception e){
			rMap.put("r_code", "-1");
			rMap.put("r_msg","ERROR.01");
		}
	
		return rMap;
	}
	
	// 로컬 서버에서 명령어 수행
	public static String sendLocalCmd(String cmd) throws IOException {
	
		Process proc 					= null;
		InputStream inputStream 		= null;
		BufferedReader bufferedReader 	= null;
		String[] cmd2					= null;
		String osName 					= System.getProperty("os.name");
		
		if(osName.toLowerCase().startsWith("window")) {
			cmd2 = new String[] { "cmd.exe", "/y", "/c", cmd };
		} else {
			cmd2 = new String[] { "/bin/sh", "-c", cmd };
		}
		
		proc = Runtime.getRuntime().exec(cmd2);
		inputStream = proc.getInputStream();
		bufferedReader = new BufferedReader( new InputStreamReader( inputStream, "UTF-8"));
		
		String line 		= "";
		String return_msg	= "";
		
		while (( line = bufferedReader.readLine()) != null ) {
			return_msg += line;			
		}
		
		bufferedReader.close();
		inputStream.close();
		
		return return_msg;
	}
	
	// 후결 시간 체크 : M52
	public static String checkPostApprovalTimeCheck(String strDataCenter) {
	
		CommonService commonService 	= (CommonService)getSpringBean("commonService");
		Map<String, Object> paramMap 	= new HashMap<String, Object>();
		
		String strPostApprovalTimeCheckMent	= "";
		String strHolidayCheck = ""; 
		paramMap.put("mcode_cd", 	"M52");
		paramMap.put("SCHEMA", 		CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		paramMap.put("data_center", strDataCenter);
		List postApprovalTimeList = commonService.dGetsCodeList(paramMap);
		
		CommonBean holidayCheck = commonService.dGetHolidayCheck(paramMap);
		
		String strNowTime				= (DateUtil.getTime().substring(0, 4)); 
		String strPostApprovalStartDate = "";
		String strPostApprovalEndDate 	= "";
		
		//String strHolidayCheck = CommonUtil.isNull(holidayCheck.getHoliday_check());
		
		if ( postApprovalTimeList != null && postApprovalTimeList.size() == 2 ) {
			for ( int i = 0; i < postApprovalTimeList.size(); i++ ) {
				CommonBean bean = (CommonBean)postApprovalTimeList.get(i);
				
				if ( i == 0 ) {
					strPostApprovalStartDate = CommonUtil.isNull(bean.getScode_eng_nm());
				}
				
				if ( i == 1 ) {
					strPostApprovalEndDate = CommonUtil.isNull(bean.getScode_eng_nm());
				}
			}
			
			if ( Long.parseLong(strPostApprovalStartDate) <= Long.parseLong(strNowTime) 
					&& Long.parseLong(strPostApprovalEndDate) >= Long.parseLong(strNowTime) ) {
				if(strHolidayCheck.equals("N")){
					strPostApprovalTimeCheckMent = "Y";
				}else{
					strPostApprovalTimeCheckMent = "N";
				}
			} else {
				strPostApprovalTimeCheckMent = "Y";
			}
		}
		strPostApprovalTimeCheckMent = "Y";
		return strPostApprovalTimeCheckMent;
	}
	
	// 실시간 sysout 조회
	public static String activeSysoutView(String data_center, String order_id, String run_count) throws Exception {
	
		CommonService commonService 	= (CommonService)getSpringBean("commonService");
		Map<String, Object> paramMap 	= new HashMap<String, Object>();
		
		String sysout = "";
		
		paramMap.put("SCHEMA", 			CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		paramMap.put("data_center"	, 	data_center);
		paramMap.put("server_gubun"	, 	"S");
		
		CommonBean bean = commonService.dGetHostInfo(paramMap);
		
		String strHost 				= "";
		String strPort 				= "";
		String strUserId 			= "";
		String strUserPw 			= "";
		String strRemoteFilePath 	= "";
		String strAccessGubun 		= "";
		
		if ( bean != null ) {
		
			strHost 			= bean.getNode_id();
			strPort 			= bean.getAccess_port();
			strUserId 			= bean.getAgent_id();
			strUserPw 			= SeedUtil.decodeStr(CommonUtil.isNull(bean.getAgent_pw()));
			strAccessGubun		= CommonUtil.isNull(bean.getAccess_gubun());
		}
		
		String cmd 			= " ctmpsm -LISTSYSOUT " + order_id + " -OUTPUTNUMBER " + run_count;

		if (!"".equals(strHost)) {
			
			if( "S".equals(strAccessGubun) ){
				Ssh2Util su = new Ssh2Util(strHost, Integer.parseInt(strPort), strUserId, strUserPw, cmd, "UTF-8");
				sysout = su.getOutput();					
			}else{
				TelnetUtil tu = new TelnetUtil(strHost, Integer.parseInt(strPort), strUserId, strUserPw, cmd);
				sysout = tu.getOutput();
			}

		} else {
			sysout = CommonUtil.getMessage("ERROR.09");
		}
		
		System.out.println("sysout 원본 : " + sysout);
		
		String last_sysout = "";
		if ( !sysout.equals("") ) {
			String[] lines 	= sysout.split("\n");
			
			if ( lines.length > 1 ) {
				for ( int i = 1; i > 0; i-- ) {
					last_sysout += lines[lines.length-i] + "\n";
				}
			} else {
				last_sysout = sysout;
			}
			
			System.out.println("last_sysout : " + last_sysout);
			
			sysout = last_sysout;
		}
		
		return sysout;
	}
	
	// 실시간 sysout 조회 - agent 통신
	public static String activeAgentSysoutView(String data_center, String strNodeId, String strJobName, String strOrderId, String strRerunCount) throws Exception {

		CommonService commonService 	= (CommonService)getSpringBean("commonService");
		Map<String, Object> paramMap 	= new HashMap<String, Object>();

		String strSysout		= "";
		String strFileName 			= "*.LOG_" + strOrderId + "_" + strRerunCount;

		paramMap.put("SCHEMA", 			CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		paramMap.put("data_center"	, 	data_center);
		paramMap.put("host"			, 	strNodeId);
		paramMap.put("server_gubun"	, 	"A");

		CommonBean bean = commonService.dGetHostInfo(paramMap);

		String strHost 				= "";
		String strPort 				= "";
		String strUserId 			= "";
		String strUserPw 			= "";
		String strRemoteFilePath 	= "";
		String strAccessGubun 		= "";

		if ( bean != null ) {

			strHost 			= bean.getNode_id();
			strPort 			= bean.getAccess_port();
			strUserId 			= bean.getAgent_id();
			strUserPw 			= SeedUtil.decodeStr(CommonUtil.isNull(bean.getAgent_pw()));
			strAccessGubun		= CommonUtil.isNull(bean.getAccess_gubun());
			strRemoteFilePath	= CommonUtil.isNull(bean.getFile_path());
		}

		String cmd = "tail -3000 " + strRemoteFilePath + strFileName;

		logger.debug("cmd : " + cmd);

		if (!"".equals(strHost)) {

			if( "S".equals(strAccessGubun) ){
				Ssh2Util su = new Ssh2Util(strHost, Integer.parseInt(strPort), strUserId, strUserPw, cmd, "UTF-8");
				strSysout = su.getOutput();
			}else{
				TelnetUtil tu = new TelnetUtil(strHost, Integer.parseInt(strPort), strUserId, strUserPw, cmd);
				strSysout = tu.getOutput();
			}

		} else {
			strSysout = CommonUtil.getMessage("ERROR.09");
		}

		System.out.println("strSysout : " + strSysout);

		return strSysout;
	}

	public static List<CommonBean> getUserDailyNameList(Map<String, Object> map){
		
		HttpServletRequest request 	= ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();		
		CommonService commonService = (CommonService)getSpringBean("commonService");
		
		List<CommonBean> l = commonService.dGetUserDailyNameList(map); 
		
		return l;
	}
	
	public static void dblinkConnect(){
		
		HttpServletRequest request 	= ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();

		CommonService commonService = (CommonService)getSpringBean("commonService");
		
		try {
		
			commonService.dDblinkConnect();
			
		} catch (Exception e) {
			
			commonService.dDblinkDisconnect();
		}
	}
	
	public static void dblinkDisconnect(){
		
		HttpServletRequest request 	= ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
		
		CommonService commonService = (CommonService)getSpringBean("commonService");
		
		try {
		
			commonService.dDblinkDisconnect(); 
			
		} catch (Exception e) {
			
		}
	}
	
	public static void setSessionRsa(HttpServletRequest req) throws Exception {     
		KeyPairGenerator generator = KeyPairGenerator.getInstance("RSA");
		generator.initialize(512);

		KeyPair keyPair = generator.genKeyPair();
		KeyFactory keyFactory = KeyFactory.getInstance("RSA");

		PublicKey pubKey = keyPair.getPublic();
		PrivateKey priKey = keyPair.getPrivate();
		
		RSAPublicKeySpec publicSpec = (RSAPublicKeySpec) keyFactory.getKeySpec(pubKey, RSAPublicKeySpec.class);

		String pubKeyMod = publicSpec.getModulus().toString(16);
		String pubKeyExp = publicSpec.getPublicExponent().toString(16);

		req.getSession().setAttribute("SS_PUBKEY_MOD", pubKeyMod);
		req.getSession().setAttribute("SS_PUBKEY_EXP", pubKeyExp);
		req.getSession().setAttribute("SS_RSA_PRIKEY",priKey);
		
	}
	
	public static boolean isWindows(){
		if(System.getProperty("os.name").startsWith("Windows")){
			return true;
		}
		return false;
	}
	
	public static String toSha256(String s, String _s) {
		byte[] temp = null;
		if(_s!=null && !"".equals(_s)) temp = (_s.substring(0,1)+(_s.length()-1)+s).getBytes();
		else temp = s.getBytes();
		String result = null;

		try{
			java.security.MessageDigest sha256 = java.security.MessageDigest.getInstance("SHA-256");
			sha256.update(temp);
			result = toHex(sha256.digest());
			
		} catch(Exception e) {
			return null;
		}
		return result;
	}
	
	public static byte[] hexToByteArray(String hex) {
        if (hex == null || hex.length() % 2 != 0) {
            return new byte[]{};
        }

        byte[] bytes = new byte[hex.length() / 2];
        for (int i = 0; i < hex.length(); i += 2) {
            byte value = (byte)Integer.parseInt(hex.substring(i, i + 2), 16);
            bytes[(int) Math.floor(i / 2)] = value;
        }
        return bytes;
    }
	
	public static String toRsaDec(HttpServletRequest req, String s) {
		String result = null;

		try{
			Cipher cipher = Cipher.getInstance("RSA");
			PrivateKey p_key = (PrivateKey)req.getSession().getAttribute("SS_RSA_PRIKEY");
			cipher.init(Cipher.DECRYPT_MODE, p_key);
			  
			byte[] inputBytes  = hexToByteArray(s);
			byte[] outputBytes = cipher.doFinal(inputBytes);
		
			result = new String(outputBytes, "UTF8"); 
		}catch(Exception e) {
			return s;
		}
		return result;
	}
	
	public static String getDefaultFilePath() {     
		return  getWebRootPath()+"/WEB-INF/files";
	}

	public static String getDefaultXmlPath() {
		return  getWebRootPath()+"/WEB-INF/classes/properties/";
	}
	
	public static List<String> toArrayList(String[] a){
		return new ArrayList(Arrays.asList(a));
	}
	
/*	public static SecurityDataSourceWorks getDataSourceWorks() {     
		
		SecurityDataSourceWorks ds = (SecurityDataSourceWorks)getSpringBean("dataSource_em");
		
		return ds;
	}*/
	
	public static CryptoDataSource getDataSourceWorks() {     
		
		CryptoDataSource ds = (CryptoDataSource)getSpringBean("dataSource_em");
		
		return ds;
	}

	public static void sleepRun(final long ms){
		ExecutorService es = Executors.newSingleThreadExecutor();
		try{
			es.submit(new Callable<Integer>(){
				public Integer call(){
			    	try{
			    		Thread.sleep(ms);
			    	}catch(Exception e){}
			    	
			    	return 1;
			    }
			}).get();
		}catch(Exception e){}finally{
			es.shutdown();
		}
	}
	
	public static String replaceStr(String str) {
		str = str.replace("\\", "\\\\\\\\");
		str = str.replace("\"", "\\\\\\\"");
		str = str.replace("$", "\\\\\\$");
		str = str.replace("'", "\\\'");
		str = str.replace("[", "\\[");
		str = str.replace("]", "\\]");
		str = str.replace("{", "\\{");
		str = str.replace("}", "\\}");
		str = str.replace("+", "\\+");
		str = str.replace("-", "\\-");
		str = str.replace("&", "\\&");
		str = str.replace("@", "\\@");
		str = str.replace("`", "\\`");
		str = str.replace("~", "\\~");
		str = str.replace("^", "\\^");
		str = str.replace("*", "\\*");
		str = str.replace("(", "\\(");
		str = str.replace(")", "\\)");
		str = str.replace("/", "\\/");
		str = str.replace("<", "\\<");
		str = str.replace(">", "\\>");
		return str;
	}
	
	// 다른 로직에 영향 없기 위해 FullUpdate 할때만 사용
	public static String replaceStrFullUpdate(String str) {
		//str = str.replace("\\", "\\\\\\\\");
		str = str.replace("\\", "\\\\");
		str = str.replace("\"", "\\\"");
		str = str.replace("$", "\\\\\\$");
		str = str.replace("'", "\\\'");
		str = str.replace("[", "\\[");
		str = str.replace("]", "\\]");
		str = str.replace("{", "\\{");
		str = str.replace("}", "\\}");
		str = str.replace("+", "\\+");
		str = str.replace("-", "\\-");
		str = str.replace("&", "\\&");
		str = str.replace("@", "\\@");
		str = str.replace("`", "\\\\\\`");
		str = str.replace("~", "\\~");
		str = str.replace("^", "\\^");
		str = str.replace("*", "\\*");
		str = str.replace("(", "\\(");
		str = str.replace(")", "\\)");
		str = str.replace("/", "\\/");
		str = str.replace("<", "\\<");
		str = str.replace(">", "\\>");
		str = str.replace(";", "\\;");
		str = str.replace("?", "\\?");
		str = str.replace("|", "\\|");
		return str;
	}
	
	// 다른 로직에 영향 없기 위해 FullUpdate 할때만 사용
	// FullUpdate 할 때 실행명령어와 변수는 띄어쓰기가 존재할 수 있고, 그것들을 하나의 VALUE로 인식하기 위해 쌍따옴표로 감싸고 있음.
	// VALUE 안에 쌍따옴표가 있을 경우 정상 저장 하기 위해 치환
	public static String replaceStrDoubleQuote(String str) {
		str = str.replace("\"", "\\\"");
		return str;
	}

	public static List<JobGraphBean> getOutCondList(String data_center, String odate, String order_id) {

		Map paramMap = new HashMap();

		List<CommonBean> dataCenterList = CommonUtil.getDataCenterList();

		for(int i=0;i<dataCenterList.size();i++){
			CommonBean bean = dataCenterList.get(i);

			if ( data_center.equals(bean.getData_center()) ) {

				paramMap.put("active_net_name", bean.getActive_net_name());
				paramMap.put("data_center_code", bean.getData_center_code());

				break;
			}
		}

		PopupJobGraphService popupJobGraphService = (PopupJobGraphService)getSpringBean("mPopupJobGraphService");

		paramMap.put("odate", 		odate);
		paramMap.put("order_id", 	order_id);
		paramMap.put("type1", 		"I");
		paramMap.put("type2", 		"O");
		List jobGraphNextList 	= popupJobGraphService.dGetJobGraphList(paramMap);
		jobGraphNextList 		= toJobGraphList(paramMap, jobGraphNextList, new ArrayList());

		return jobGraphNextList;
	}

	public static List toJobGraphList(Map paramMap, List inList, List outList) {

		PopupJobGraphService popupJobGraphService = (PopupJobGraphService)getSpringBean("mPopupJobGraphService");

		int iGraphDepth = Integer.parseInt(CommonUtil.isNull(paramMap.get("graph_depth"), "0"));
		int iCompareNum = Integer.parseInt(CommonUtil.isNull(paramMap.get("compare_num"), "0"));

		if ( inList != null && inList.size() > 0 ) {
			outList.addAll(inList);
		}

		for ( int i = 0; inList != null && i < inList.size(); i++ ) {

			JobGraphBean bean = (JobGraphBean)inList.get(i);

			if ( iCompareNum == iGraphDepth && iGraphDepth > 0 ) {
				bean.setRef_order_id("");
			}

			int iChk = 0;

			for ( int j = 0; outList != null && j < outList.size(); j++ ) {

				JobGraphBean bean2 = (JobGraphBean)outList.get(j);

				if( bean2.getOrder_id().equals(bean.getRef_order_id()) || CommonUtil.isNull(bean.getRef_order_id()).equals("") ) {
					iChk++;
				}
			}

			if ( iChk > 0 ) continue;

			paramMap.put("order_id", bean.getRef_order_id());

			List l = popupJobGraphService.dGetJobGraphList(paramMap);

			if ( l != null && l.size() > 0 ) {
				iCompareNum++;
				paramMap.put("compare_num", iCompareNum);

				toJobGraphList(paramMap, l, outList);
			}
		}

    	return outList;
	}
	
	// 바이트 수로 자르기
	public static String subStrBytes(String source, int cutLength) throws UnsupportedEncodingException {
		
		if ( !source.equals("") ) {
			
	    	source = source.trim();
	    	
	        if(source.getBytes("EUC-KR").length <= cutLength) {
	        	return source;
	        } else {
	            StringBuffer sb = new StringBuffer(cutLength);
	            int cnt = 0;
	            
	            for(char ch : source.toCharArray()){
	            	cnt += String.valueOf(ch).getBytes("EUC-KR").length;
	            	
	                if(cnt > cutLength) break;
	                
	                sb.append(String.valueOf(ch));
	            }
	            
	            return sb.toString();
	        }
	    } else {
	    	return "";
	    }
	}
	
	// 변경 가능한 상태인 지 체크
	public static String getStatusChangeCheck(Map paramMap) {
	
		WorksApprovalDocService worksApprovalDocService = (WorksApprovalDocService)getSpringBean("tWorksApprovalDocService");
		ActiveJobBean activeJobBean = worksApprovalDocService.dGetAjobStatus(paramMap);
		
		String strErrorMessage 	= "";
		
		if ( activeJobBean != null ) {
		
			String strStatus 		= CommonUtil.isNull(activeJobBean.getStatus());
			String strStatus2 		= CommonUtil.isNull(activeJobBean.getStatus2());
			String strChangeStatus 	= CommonUtil.isNull(paramMap.get("after_status"));
			
			/*HOLD : Running, Deleted 외 모두 가능
			CONFIRM : Wait Confirm 만 가능
			FORCEOK : Running, Job Success 외 모두 가능
			FREE : HOLD 만 가능
			KILL : Running 만 가능
			RUNNOW : Wait 모두 가능, Wait User(Wait Confirm) 작업은 제외
			RERUN : Deleted가 아닌 Job Fail, Job Success 만 가능
			DELETE : Running 외 모두 가능
			UNDELETE : Delete 작업만 가능*/
			
			// HOLD 상태는 FREE 먼저 진행할 수 있게 안내.
			// HOLD 상태에서 DELETE 는 가능해야 함 (2023.11.06 강명준)
			if ( strStatus.equals("HOLD") ) {
				if ( !strChangeStatus.equals("FREE") && !strChangeStatus.equals("DELETE") ) {
					strErrorMessage = CommonUtil.getMessage("ERROR.HOLD.FREE");
				}
				
			} else {
			
				if ( strChangeStatus.equals("HOLD") ) {
					if ( strStatus2.equals("Executing") || strStatus.equals("Deleted") ) {
						strErrorMessage = CommonUtil.getMessage("ERROR.HOLD");
					}
					
				} else if ( strChangeStatus.equals("CONFIRM") ) {
					if ( !strStatus2.equals("Wait User") ) {
						strErrorMessage = CommonUtil.getMessage("ERROR.CONFIRM");
					}
					
				} else if ( strChangeStatus.equals("FORCEOK") ) {
					if ( strStatus2.equals("Executing") || strStatus2.equals("Ended OK") ) {
						strErrorMessage = CommonUtil.getMessage("ERROR.FORCEOK");
					}
				
				} else if ( strChangeStatus.equals("FREE") ) {
					if ( !strStatus.equals("HOLD") ) {
						strErrorMessage = CommonUtil.getMessage("ERROR.FREE");
					}
					
				} else if ( strChangeStatus.equals("KILL") ) {
					if ( !strStatus2.equals("Executing") ) {
						strErrorMessage = CommonUtil.getMessage("ERROR.KILL");
					}
					
				} else if ( strChangeStatus.equals("RUNNOW") ) {
					if ( strStatus2.indexOf("Wait") < 0 || strStatus2.equals("Wait User") ) {
						strErrorMessage = CommonUtil.getMessage("ERROR.RUNNOW");
					}
					
				} else if ( strChangeStatus.equals("RERUN") ) {
	//				if ( !(strStatus2.equals("Job Fail") || strStatus2.equals("Job Success")) ) {
					if(!(strStatus2.equals("Ended Not OK") || strStatus2.equals("Ended OK")) || strStatus.equals("Deleted") ) {
						strErrorMessage = CommonUtil.getMessage("ERROR.RERUN");
					}
				} else if ( strChangeStatus.equals("DELETE") ) {
					if ( strStatus2.equals("Executing") ) {
						strErrorMessage = CommonUtil.getMessage("ERROR.DELETE");
					}
					
				} else if ( strChangeStatus.equals("UNDELETE") ) {
					if ( !strStatus.equals("Deleted") ) {
						strErrorMessage = CommonUtil.getMessage("ERROR.UNDELETE");
					}
				}
			}
			
			System.out.println("strStatus : " + strStatus);
			System.out.println("strStatus2 : " + strStatus2);
			System.out.println("strChangeStatus : " + strChangeStatus);
			System.out.println("strErrorMessage : " + strErrorMessage);
			
		} else {
			strErrorMessage = "작업이 존재 하지 않습니다.";
		}
		
		return strErrorMessage;
		
	}
	
	// 결재, 반려 등을 진행할 수 있는 상태인 지 체크.
	public static String getStatusApprovalCheck(Map paramMap) {
	
		WorksApprovalDocService worksApprovalDocService = (WorksApprovalDocService)getSpringBean("tWorksApprovalDocService");
		DocInfoBean docInfoBean 						= worksApprovalDocService.dGetChkApprovalStatus(paramMap);
		
		String strApprovalMessage = "";
		
		if ( docInfoBean != null ) {
		
			String strChangeStatus 		= CommonUtil.isNull(paramMap.get("approval_cd"));
			String strApprovalSeq 		= CommonUtil.isNull(paramMap.get("approval_seq"));
			String strFlag 				= CommonUtil.isNull(paramMap.get("flag"));
			
			String strStateCd 			= CommonUtil.isNull(docInfoBean.getState_cd());
			String strDelYn				= CommonUtil.isNull(docInfoBean.getDel_yn());
			String strCurApprovalSeq	= CommonUtil.isNull(docInfoBean.getCur_approval_seq());
			String strApplyCd			= CommonUtil.isNull(docInfoBean.getApply_cd());
			
			System.out.println("strChangeStatus : " + strChangeStatus);
			System.out.println("strFlag : " + strFlag);
			System.out.println("strStateCd : " + strStateCd);
			System.out.println("strDelYn : " + strDelYn);
			System.out.println("strCurApprovalSeq : " + strCurApprovalSeq);
			System.out.println("strApprovalSeq : " + strApprovalSeq);
			System.out.println("strApplyCd : " + strApplyCd);
			
			// 삭제
			if ( strFlag.equals("del") ) {
				if ( strDelYn.equals("Y") ) {
					strApprovalMessage = CommonUtil.getMessage("ERROR.APPROVAL.DEL");
					strApprovalMessage += "\\n" + "삭제여부:" + strDelYn;
				}
				
			// 수정
			} else if ( strFlag.equals("udt") ) {
				if ( !strStateCd.equals("00") || strDelYn.equals("Y") ) {
					strApprovalMessage = CommonUtil.getMessage("ERROR.APPROVAL.UDT");
					strApprovalMessage += "\\n" + "문서상태:" + strStateCd + ", 삭제여부:" + strDelYn;
				}
				
			// 승인요청
			} else if ( strFlag.equals("draft") ) {
				if ( !strStateCd.equals("00") || strDelYn.equals("Y") ) {
					strApprovalMessage = CommonUtil.getMessage("ERROR.APPROVAL.DRAFT");
					strApprovalMessage += "\\n" + "문서상태:" + strStateCd + ", 삭제여부:" + strDelYn;
				}
				
			// 즉시결재
			} else if ( strFlag.equals("draft_admin")) {
				if ( !(strStateCd.equals("00") || strStateCd.equals("01")) || strDelYn.equals("Y") ) {
					strApprovalMessage = CommonUtil.getMessage("ERROR.APPROVAL.ADMIN");
					strApprovalMessage += "\\n" + "문서상태:" + strStateCd + ", 삭제여부:" + strDelYn;
				}
			
			// 반려
			} else if ( strChangeStatus.equals("04") ) {
				if ( !strStateCd.equals("01") || strDelYn.equals("Y") || !strCurApprovalSeq.equals(strApprovalSeq) ) {
					strApprovalMessage = CommonUtil.getMessage("ERROR.APPROVAL.04");
					strApprovalMessage += "\\n" + "문서상태:" + strStateCd + ", 삭제여부:" + strDelYn + ", 결재차수:" + strCurApprovalSeq;
				}
				
			// 반영
			} else if ( strFlag.equals("exec") ) {
				if ( strApplyCd.equals("02") || strApplyCd.equals("04") ||strDelYn.equals("Y") ) {
					strApprovalMessage = CommonUtil.getMessage("ERROR.APPROVAL.APPLY");
					strApprovalMessage += "\\n" + "반영상태:" + strApplyCd + ", 삭제여부:" + strDelYn;
				}
			
			// 결재
			} else if ( strChangeStatus.equals("02") ) {
				if ( !strStateCd.equals("01") || strDelYn.equals("Y") || !strCurApprovalSeq.equals(strApprovalSeq) ) {
					strApprovalMessage = CommonUtil.getMessage("ERROR.APPROVAL.02");
					strApprovalMessage += "\\n" + "문서상태:" + strStateCd + ", 삭제여부:" + strDelYn + ", 결재차수:" + strCurApprovalSeq;
				}
				
			// 승인 취소
			} else if ( strFlag.equals("def_cancel") ) {
				if ( !strStateCd.equals("01") || !strCurApprovalSeq.equals("1") || strDelYn.equals("Y")) {
					strApprovalMessage = CommonUtil.getMessage("ERROR.APPROVAL.CANCEL");
					strApprovalMessage += "\\n" + "문서상태:" + strStateCd + ", 삭제여부:" + strDelYn + ", 결재차수:" + strCurApprovalSeq;
				}
			}
			
			System.out.println("strErrorMessage : " + strApprovalMessage);
			
		} else {
			strApprovalMessage = "요청서가 존재 하지 않습니다.";
		}
		
		return strApprovalMessage;
	}
	
	public static void setAutoSizeColumn(Sheet sheet, int n, int maxCellWidth){
		sheet.autoSizeColumn(n);
		sheet.setColumnWidth(n, Math.min(255*256, maxCellWidth + 1000));
	}

	// Forecast 유틸리티 호출
	public static String getForecastUtil(Map paramMap) throws Exception {

		CommonService commonService = (CommonService)getSpringBean("commonService");

		String data_center 	= CommonUtil.isNull(paramMap.get("data_center"));
		String job_name 	= CommonUtil.isNull(paramMap.get("job_name"));
		String schedule_year 	= CommonUtil.isNull(paramMap.get("schedule_year"));
		String sched_table 	= CommonUtil.isNull("SCHED_TEST");
		String hostname 	= CommonUtil.getMessage("EZJOBS_HOSTNAME");

		// Host 정보 가져오는 서비스.
		paramMap.put("data_center"	, data_center);
		paramMap.put("host"			, hostname);
		paramMap.put("server_gubun"	, "S");

		CommonBean bean = commonService.dGetHostInfo(paramMap);

		String strHost 				= "";
		String strAccessGubun		= "";
		int iPort 					= 0;
		String strUserId 			= "";
		String strUserPw 			= "";

		if ( bean != null ) {

			strHost 			= CommonUtil.isNull(bean.getNode_id());
			strAccessGubun		= CommonUtil.isNull(bean.getAccess_gubun());
			iPort 				= Integer.parseInt(CommonUtil.isNull(bean.getAccess_port()));
			strUserId 			= CommonUtil.isNull(bean.getAgent_id());
			strUserPw 			= SeedUtil.decodeStr(CommonUtil.isNull(bean.getAgent_pw()));
		}

		String cmd 		= CommonUtil.getMessage("FORECAST.PATH") + "ctmrpln YJ Y " + sched_table + " '*' " +(schedule_year.equals("") ? CommonUtil.getCurDate("Y") : schedule_year)+ "| sed '1,/Jobname:" + job_name + "$/d' | perl -ne 'print if 22..36'";
		String forecast = "";

		if (!"".equals(strHost)) {
			Ssh2Util su = new Ssh2Util(strHost, iPort, strUserId, strUserPw, cmd, "UTF-8");
			forecast = su.getOutput();
		}else{
			forecast = "-1";
		}

		return forecast;
	}

	// 결재자 알림 발송
	public static int sendApprovalNoti(String doc_cd) throws Exception {

		Map<String, Object> paramMap = new HashMap<String, Object>();

		CommonService commonService 						= (CommonService)getSpringBean("commonService");
		WorksApprovalDocService worksApprovalDocService 	= (WorksApprovalDocService)getSpringBean("tWorksApprovalDocService");
		WorksUserService worksUserService 					= (WorksUserService)getSpringBean("tWorksUserService");

		int iSendResult	= 0;

		// M73 : 알림발송여부 체크
		paramMap.put("mcode_cd", 	"M73");
		paramMap.put("doc_cd", 		doc_cd);
		paramMap.put("SCHEMA", 		CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		List sCodeList = commonService.dGetsCodeList(paramMap);

		String noti_yn = "";
		if ( sCodeList != null ) {
			CommonBean bean = (CommonBean)sCodeList.get(0);
			noti_yn = CommonUtil.isNull(bean.getScode_eng_nm());
		}

		// 알림발송여부 'Y' 일때만 결재요청 알림.
		if ( noti_yn.equals("Y") ) {

			// 문서 정보 조회.
			DocInfoBean docInfoBean = worksApprovalDocService.dGetApprovalNotiInfo(paramMap);

			String strDocGb 			= "";
			String strJobName 			= "";
			String strDataCenter 		= "";
			String strPostApprovalYn	= "";
			String strMainDocCd			= "";
			String strDocCnt			= "";
			String strSendDesc 			= "APPROVAL";

			if ( docInfoBean != null ) {
				strDocGb	 		= CommonUtil.isNull(docInfoBean.getDoc_gb());
				strJobName	 		= CommonUtil.isNull(docInfoBean.getJob_name());
				strDataCenter 		= CommonUtil.isNull(docInfoBean.getData_center());
				strPostApprovalYn 	= CommonUtil.isNull(docInfoBean.getPost_approval_yn());
				strDocCnt		 	= CommonUtil.isNull(docInfoBean.getDoc_cnt());
				strMainDocCd 		= CommonUtil.isNull(docInfoBean.getMain_doc_cd());
			}

			logger.info("doc_cd : " + doc_cd);
			logger.info("strDocCnt : " + strDocCnt);
			logger.info("strMainDocCd : " + strMainDocCd);

			// 그룹안의 작업들은 알림 발송하지 않음
			boolean bJobInGroup = false;
			if ( !strMainDocCd.equals("") && strDocCnt.equals("0") ) {
				bJobInGroup = true;
			}

			if ( !bJobInGroup ) {

				// 결재자 알림 대상 조회.
				CommonBean commonBean = worksApprovalDocService.dGetApprovalUserMail(paramMap);

				String strUserMail 			= "";
				String strUserNm 			= "";
				String strApprovalUserCd 	= "";
				String strApprovalUserNm 	= "";
				String strApprovalUserId 	= "";
				String strApprovalUserHp 	= "";
				String strDeptNm 			= "";
				String strUserCd 			= "";
				String strUserId 			= "";
				String strAbSenceUserCd		= "";
				String strAbSenceUserId		= "";
				String strAbSenceUserNm		= "";
				String strAbSenceUserHp		= "";
				String strAbSenceUserMail	= "";

				if ( commonBean != null ) {
					strUserMail 		= CommonUtil.isNull(commonBean.getUser_email());
					strUserNm 			= CommonUtil.isNull(commonBean.getUser_nm());
					strApprovalUserCd 	= CommonUtil.isNull(commonBean.getApproval_user_cd());
					strApprovalUserNm 	= CommonUtil.isNull(commonBean.getApproval_user_nm());
					strApprovalUserId 	= CommonUtil.isNull(commonBean.getApproval_user_id());
					strApprovalUserHp 	= CommonUtil.isNull(commonBean.getApproval_user_hp());
					strDeptNm			= CommonUtil.isNull(commonBean.getDept_nm());
					strUserCd			= CommonUtil.isNull(commonBean.getUser_cd());
					strUserId			= CommonUtil.isNull(commonBean.getUser_id());
					strAbSenceUserCd	= CommonUtil.isNull(commonBean.getAbsence_user_cd());
					strAbSenceUserId	= CommonUtil.isNull(commonBean.getAbsence_user_id());
					strAbSenceUserNm	= CommonUtil.isNull(commonBean.getAbsence_user_nm());
					strAbSenceUserHp	= CommonUtil.isNull(commonBean.getAbsence_user_hp());
					strAbSenceUserMail	= CommonUtil.isNull(commonBean.getAbsence_user_mail());

					// 그룹 결재일 경우 속해 있는 결재자에게 모두 메일 발송
					if ( strDeptNm.equals("GROUP") ) {

						paramMap.put("group_line_grp_cd", strUserCd);

						// 그룹 조회
						List approvalAdminGroupMailList = worksApprovalDocService.dGetApprovalAdminGroupMailList(paramMap);

						if ( approvalAdminGroupMailList != null ) {

							for ( int j = 0; j < approvalAdminGroupMailList.size(); j++ ) {

								CommonBean commonBean2 = (CommonBean)approvalAdminGroupMailList.get(j);

								strApprovalUserCd 	= CommonUtil.isNull(commonBean2.getApproval_user_cd());
								strApprovalUserNm 	= CommonUtil.isNull(commonBean2.getApproval_user_nm());
								strApprovalUserId 	= CommonUtil.isNull(commonBean2.getApproval_user_id());
								strApprovalUserHp 	= CommonUtil.isNull(commonBean2.getApproval_user_hp());
								strUserMail 		= CommonUtil.isNull(commonBean2.getUser_email());
								strAbSenceUserCd	= CommonUtil.isNull(commonBean2.getAbsence_user_cd());
								strAbSenceUserId	= CommonUtil.isNull(commonBean2.getAbsence_user_id());
								strAbSenceUserNm	= CommonUtil.isNull(commonBean2.getAbsence_user_nm());
								strAbSenceUserHp	= CommonUtil.isNull(commonBean2.getAbsence_user_hp());
								strAbSenceUserMail	= CommonUtil.isNull(commonBean2.getAbsence_user_mail());

								if (!strApprovalUserHp.equals("")) {
									approvalSendNotiForm(doc_cd, strJobName, strDataCenter, strDocGb, strUserCd, strUserId, strUserNm, strApprovalUserCd, strApprovalUserNm, strUserMail, strApprovalUserId, strApprovalUserHp, strPostApprovalYn, strSendDesc);
								}
								
								// 대결자 메일 발송
								if (!strAbSenceUserHp.equals("")) {
									approvalSendNotiForm(doc_cd, strJobName, strDataCenter, strDocGb, strUserCd, strUserId, strUserNm, strAbSenceUserCd, strAbSenceUserNm, strAbSenceUserMail, strAbSenceUserId, strAbSenceUserHp, strPostApprovalYn, strSendDesc);
								}
							}
						}

						// 일반 결재
					} else {
						if (!strApprovalUserHp.equals("")) {
							approvalSendNotiForm(doc_cd, strJobName, strDataCenter, strDocGb, strUserCd, strUserId, strUserNm, strApprovalUserCd, strApprovalUserNm, strUserMail, strApprovalUserId, strApprovalUserHp, strPostApprovalYn, strSendDesc);
						}
						
						// 대결자 메일 발송
						if (!strAbSenceUserHp.equals("")) {
							approvalSendNotiForm(doc_cd, strJobName, strDataCenter, strDocGb, strUserCd, strUserId, strUserNm, strAbSenceUserCd, strAbSenceUserNm, strAbSenceUserMail, strAbSenceUserId, strAbSenceUserHp, strPostApprovalYn, strSendDesc);
						}
					}
				} else {
					logger.debug("[ApprovalNoti Pass] 발송 대상 없음");
				}

			} else {
				logger.debug("[ApprovalNoti Pass] 그룹 안의 작업");
			}

		} else {
			logger.debug("[ApprovalNoti Pass] 알림발송여부 N 설정");
		}

		return iSendResult;
	}

	// 결재자 알림 발송
	public static int approvalSendNotiForm(String doc_cd, String strJobName, String strDataCenter, String strDocGb, String strUserCd, String strUserId, String strUserNm, String strApprovalUserCd, String strApprovalUserNm, String strUserMail, String strApprovalUserId, String strApprovalUserHp, String strPostApprovalYn, String strSendDesc) throws Exception {

		String strContent 			= "";
		String strTitle 			= "";
		String strServerGb 			= CommonUtil.isNull(CommonUtil.getMessage("SERVER_GB"));
		String strDocGbMent 		= CommonUtil.getMessage("DOC.GB." + strDocGb);
		String strServerGbMent		= "";
		String strPostApprovalMent	= "";

		if ( strServerGb.equals("D") ) {
			strServerGbMent = "[작업관리시스템-개발] ";
		} else if ( strServerGb.equals("T") ) {
			strServerGbMent = "[작업관리시스템-테스트] ";
		} else if ( strServerGb.equals("P") ) {
			strServerGbMent = "[작업관리시스템-운영] ";
		}

		if ( strPostApprovalYn.equals("Y") ) {
			strPostApprovalMent = "(후결)";
		}

		strTitle 			= strServerGbMent + "[" + strDocGbMent + "-결재요청"+strPostApprovalMent+"] " + "문서번호 : " + doc_cd;
		strContent 			= strServerGbMent + "[" + strDocGbMent + "-결재요청"+strPostApprovalMent+"] " + "문서번호 : " + doc_cd;
		strContent 			+= "\n";
		strContent 			+= "EZJOBS 운영.관리 담당자 입니다.";
		strContent 			+= "\n";
		strContent 			+= "\n";
		strContent 			+= strUserNm + "(" + strUserId + ")" + "님이 의뢰하신 업무 요청이 " + strApprovalUserNm + "(" + strApprovalUserId + ")" + "님에게 결재 요청 되었음을 안내 통지 드립니다.";
		strContent 			+= "\n";
		strContent 			+= "빠른 시간 내에 승인/반려 처리를 요청 합니다.";
		strContent 			+= "\n";
		strContent 			+= "\n";
		strContent 			+= "자세한 내용은 다음과 같습니다.";
		strContent 			+= "\n";
		strContent 			+= "\n";
		strContent 			+= "> 의뢰자 : " + strUserNm + "(" + strUserId + ")";
		strContent 			+= "\n";
		strContent 			+= "> 문서구분 : " + strDocGbMent;
		strContent 			+= "\n";
		strContent 			+= "> 문서번호 : " + doc_cd;

		int iSendResult		= 0;
		String returnCode	= "";

		//boolean bSendResult	= SendMessenger.sendMessenger(strApprovalUserId, "작업관리시스템", "작업관리시스템", strContent);

		// 사무실에서는 발송 성공 처리
		boolean bSendResult	= true;

		logger.debug(strApprovalUserId + "에게 메신저 발송 성공");
		logger.debug("메신저 내용 : " + strContent);

		if ( bSendResult ) {
			iSendResult 		= 1;
			returnCode 			= "00";
		} else {
			iSendResult			= -1;
			returnCode 			= "01";
		}

		// 이력 저장
		Map<String, Object> sendMap = new HashMap<String, Object>();
		sendMap.put("flag", 		"send");
		sendMap.put("SCHEMA",		CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		sendMap.put("data_center", 	strDataCenter);
		sendMap.put("job_name", 	strJobName);
		sendMap.put("send_gubun", 	"U");
		sendMap.put("message", 		strTitle);
		sendMap.put("send_info", 	strApprovalUserHp);
		sendMap.put("send_user_cd", strApprovalUserCd);
		sendMap.put("return_code", 	returnCode);
		sendMap.put("send_desc", strSendDesc);

		try {

			Map<String, Object> rMap = new HashMap<String, Object>();

			StaticCommonDao = (CommonDao) CommonUtil.getSpringBean("commonDao");
			rMap = StaticCommonDao.dPrcLog(sendMap);

			logger.info("=======approvalSendNotiForm dPrcLog rMap==== " + rMap);

		} catch (Exception e) {

			logger.info("=========dPrcLog Exception========"+e.toString());
			logger.info("=========dPrcLog Exception========"+e.getMessage());
		}

		return iSendResult;
	}

	// 의뢰자 메일 발송
	public static int sendInsUserNoti(String doc_cd) throws Exception {

		Map<String, Object> paramMap = new HashMap<String, Object>();

		CommonService commonService 						= (CommonService)getSpringBean("commonService");
		WorksApprovalDocService worksApprovalDocService 	= (WorksApprovalDocService)getSpringBean("tWorksApprovalDocService");
		WorksUserService worksUserService 					= (WorksUserService)getSpringBean("tWorksUserService");

		int iSendResult	= 0;

		// M73 : 알림발송여부 체크
		paramMap.put("mcode_cd", 	"M73");
		paramMap.put("doc_cd", 		doc_cd);
		paramMap.put("SCHEMA", 		CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		List sCodeList = commonService.dGetsCodeList(paramMap);

		String noti_yn = "";
		if ( sCodeList != null ) {
			CommonBean bean = (CommonBean)sCodeList.get(0);
			noti_yn = CommonUtil.isNull(bean.getScode_eng_nm());
		}

		// 알림발송여부 'Y' 일때만 결재요청 알림.
		if ( noti_yn.equals("Y") ) {

			// 문서 정보 조회.
			DocInfoBean docInfoBean = worksApprovalDocService.dGetApprovalNotiInfo(paramMap);

			String strDocGb 			= "";
			String strJobName 			= "";
			String strDataCenter 		= "";
			String strPostApprovalYn	= "";
			String strDocCnt			= "";
			String strMainDocCd			= "";
			String strStateCd			= "";
			String strApplyFailCnt		= "";
			String strApplySuccessCnt	= "";
			String strSendDesc			= "EXEC";

			if ( docInfoBean != null ) {
				strDocGb	 		= CommonUtil.isNull(docInfoBean.getDoc_gb());
				strJobName	 		= CommonUtil.isNull(docInfoBean.getJob_name());
				strDataCenter 		= CommonUtil.isNull(docInfoBean.getData_center());
				strPostApprovalYn 	= CommonUtil.isNull(docInfoBean.getPost_approval_yn());
				strDocCnt 			= CommonUtil.isNull(docInfoBean.getDoc_cnt());
				strMainDocCd 		= CommonUtil.isNull(docInfoBean.getMain_doc_cd());
				strApplyFailCnt 	= CommonUtil.isNull(docInfoBean.getApply_fail_cnt());
				strApplySuccessCnt 	= CommonUtil.isNull(docInfoBean.getApply_success_cnt());
				//반려인 경우 state_cd 04
				strStateCd 			= CommonUtil.isNull(docInfoBean.getState_cd());
			}

			// 그룹안의 작업들은 알림 발송하지 않음
			boolean bJobInGroup = false;
			if ( !strMainDocCd.equals("") && strDocCnt.equals("0") ) {
				bJobInGroup = true;
			}

			if ( !bJobInGroup ) {

				// 의뢰자 알림 대상 조회.
				CommonBean commonBean = worksApprovalDocService.dGetInsUserMail(paramMap);

				String strUserCd 		= "";
				String strUserId 		= "";
				String strUserNm 		= "";
				String strUserMail 		= "";
				String strUserHp 		= "";

				if ( commonBean != null ) {
					strUserCd			= CommonUtil.isNull(commonBean.getUser_cd());
					strUserId			= CommonUtil.isNull(commonBean.getUser_id());
					strUserNm 			= CommonUtil.isNull(commonBean.getUser_nm());
					strUserMail 		= CommonUtil.isNull(commonBean.getUser_email());
					strUserHp 			= CommonUtil.isNull(commonBean.getUser_hp());

					InsUserNotiForm(doc_cd, strJobName, strDataCenter, strDocGb, strUserCd, strUserId, strUserNm, strUserHp, strPostApprovalYn, strApplyFailCnt, strApplySuccessCnt, strSendDesc, strStateCd);

				} else {
					logger.debug("[InsUserNoti Pass] 발송 대상 없음");
				}

			} else {
				logger.debug("[InsUserNoti Pass] 그룹 안의 작업");
			}

		} else {
			logger.debug("[InsUserNoti Pass] 알림발송여부 N 설정");
		}

		return iSendResult;
	}

	// 의뢰자 메일 발송
	public static int InsUserNotiForm(String doc_cd, String strJobName, String strDataCenter, String strDocGb, String strUserCd, String strUserId, String strUserNm, String strUserHp, String strPostApprovalYn, String strApplyFailCnt, String strApplySuccessCnt, String strSendDesc, String strStateCd) throws Exception {

		String strContent 			= "";
		String strTitle 			= "";
		String strServerGb 			= CommonUtil.isNull(CommonUtil.getMessage("SERVER_GB"));
		String strDocGbMent 		= CommonUtil.getMessage("DOC.GB." + strDocGb);
		String strServerGbMent		= "";
		String strPostApprovalMent	= "";

		if ( strServerGb.equals("D") ) {
			strServerGbMent = "[작업관리시스템-개발] ";
		} else if ( strServerGb.equals("T") ) {
			strServerGbMent = "[작업관리시스템-테스트] ";
		} else if ( strServerGb.equals("P") ) {
			strServerGbMent = "[작업관리시스템-운영] ";
		}

		if ( strPostApprovalYn.equals("Y") ) {
			strPostApprovalMent = "(후결)";
		}

		int iApplyFailCnt 		= Integer.parseInt(strApplyFailCnt);
		int iApplySuccessCnt 	= Integer.parseInt(strApplySuccessCnt);

		String strApplyMent = "";
		if ( iApplyFailCnt > 0 ) {
			strApplyMent = " [성공-" + strApplySuccessCnt + "건, 실패-" + strApplyFailCnt + "건] ";
		}

		String strApplyCdMent = "";
		if ( iApplySuccessCnt == 0 && iApplyFailCnt > 0 ) {
			strApplyCdMent = "반영실패";
		} else if(strStateCd.equals("04")){
			strApplyCdMent = "반려";
		} else {
			strApplyCdMent = "반영완료";
		}

		strTitle 			= strServerGbMent + "[" + strDocGbMent + "-"+strApplyCdMent+strPostApprovalMent+"] " + strApplyMent + "문서번호 : " + doc_cd;
		//strTitle 			= "[" + strServerGbMent + "] [작업관리시스템-" + strApplyCdMent + strPostApprovalMent+"]" + " [" + strDocGbMent + "] " + strApplyMent + doc_cd;
		strContent 			= strServerGbMent + "[" + strDocGbMent + "-"+strApplyCdMent+strPostApprovalMent+"] " + strApplyMent + "문서번호 : " + doc_cd;
		strContent 			+= "EZJOBS 운영.관리 담당자 입니다.";
		strContent 			+= "\n";
		strContent 			+= "\n";
		strContent 			+= strUserNm+"("+strUserId+")"+ "님이 의뢰하신 업무가 "+strApplyCdMent+" 되었음을 안내 통지 드립니다.";
		strContent 			+= "\n";
		strContent 			+= "\n";
		strContent 			+= "자세한 내용은 다음과 같습니다.";
		strContent 			+= "\n";
		strContent 			+= "\n";
		strContent 			+= "> 의뢰자 : " + strUserNm+"("+strUserId+")";
		strContent 			+= "\n";
		strContent 			+= "> 문서구분 : " + strDocGbMent;
		strContent 			+= "\n";
		strContent 			+= "> 문서번호 : " + doc_cd;

		int iSendResult		= 0;
		String returnCode	= "";

		//boolean bSendResult	= SendMessenger.sendMessenger(strUserId, "작업관리시스템", "작업관리시스템", strContent);

		// 사무실에서는 발송 성공 처리
		boolean bSendResult	= true;

		if ( bSendResult ) {
			iSendResult 		= 1;
			returnCode 			= "00";
		} else {
			iSendResult			= -1;
			returnCode 			= "01";
		}

		// 이력 저장
		Map<String, Object> sendMap = new HashMap<String, Object>();
		sendMap.put("flag", 		"send");
		sendMap.put("SCHEMA",		CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		sendMap.put("data_center", 	strDataCenter);
		sendMap.put("job_name", 	strJobName);
		sendMap.put("send_gubun", 	"U");
		sendMap.put("message", 		strTitle);
		sendMap.put("send_info", 	strUserHp);
		sendMap.put("send_user_cd", strUserCd);
		sendMap.put("return_code", 	returnCode);
		sendMap.put("send_desc", 	strSendDesc);

		try {

			Map<String, Object> rMap = new HashMap<String, Object>();

			StaticCommonDao = (CommonDao) CommonUtil.getSpringBean("commonDao");
			rMap = StaticCommonDao.dPrcLog(sendMap);

			logger.info("=======InsUserNotiForm dPrcLog rMap==== " + rMap);

		} catch (Exception e) {

			logger.info("=========dPrcLog Exception========"+e.toString());
			logger.info("=========dPrcLog Exception========"+e.getMessage());
		}

		return iSendResult;
	}
	
	// API 호출 로깅
	public static void ctmApiLogging(String api_message) throws Exception {

		String strQuartzLogPath = CommonUtil.isNull(CommonUtil.getMessage("QUARTZ_LOG.PATH"));
		String strLogPath		= CommonUtil.getWebRootPath() + "/" + strQuartzLogPath + "CtmApiCallLog/";
		
		// 해당 폴더 없으면 생성.
		if ( !new File(strLogPath).exists() ) {
			new File(strLogPath).mkdirs();
		}
		
		TraceLogUtil.TraceLog(api_message, strLogPath, "CtmApiCallLog");
	}
	
	// API 호출 시작 로깅
	public static void ctmApiLoggingStart(Map map, String gubun) throws Exception {

		String strQuartzLogPath = CommonUtil.isNull(CommonUtil.getMessage("QUARTZ_LOG.PATH"));
		String strLogPath		= CommonUtil.getWebRootPath() + "/" + strQuartzLogPath + "CtmApiCallLog/";
		
		// 해당 폴더 없으면 생성.
		if ( !new File(strLogPath).exists() ) {
			new File(strLogPath).mkdirs();
		}
		
		TraceLogUtil.TraceLog("[" + gubun + "] START", strLogPath, "CtmApiCallLog");
		TraceLogUtil.TraceLog("[" + gubun + "] map : " + map, strLogPath, "CtmApiCallLog");
	}
	
	// API 호출 종료 로깅
	public static void ctmApiLoggingEnd(Map map, String gubun) throws Exception {

		String strQuartzLogPath = CommonUtil.isNull(CommonUtil.getMessage("QUARTZ_LOG.PATH"));
		String strLogPath		= CommonUtil.getWebRootPath() + "/" + strQuartzLogPath + "CtmApiCallLog/";
		
		// 해당 폴더 없으면 생성.
		if ( !new File(strLogPath).exists() ) {
			new File(strLogPath).mkdirs();
		}
		
		TraceLogUtil.TraceLog("[" + gubun + "] RESULT map : " + map, strLogPath, "CtmApiCallLog");
		TraceLogUtil.TraceLog("[" + gubun + "] END", strLogPath, "CtmApiCallLog");
	}

	// xml 파일 읽어오기
	public static Document getDocument(String filename) throws Exception {

		// XML 파일을 읽기 위한 DocumentBuilder 생성
		DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();

		// 파서가 공백을 유지하도록 설정
		factory.setIgnoringElementContentWhitespace(false);
		DocumentBuilder builder = factory.newDocumentBuilder();

		// XML 파일을 파싱하여 Document 객체로 읽어옴
		File files = new File(CommonUtil.getDefaultXmlPath()+filename);
		FileInputStream fis = new FileInputStream(files);
		Document document = builder.parse(fis);

		// 파일 스트림 닫기
		fis.close();

		return document;
	}

	// xml 엘리먼트 가져오기
	public static NodeList getNodeList(Document document) throws Exception {

		// 루트 엘리먼트인 <properties>를 가져옴
		Element properties = document.getDocumentElement();

		// <entry> 엘리먼트들을 가져옴
		NodeList entryList = properties.getElementsByTagName("entry");

		return entryList;
	}

	// xml 엘리먼트 수정 후 교체하기
	public static void replaceXmlfile(Document document, String file_name) throws Exception {

		String strQuartzLogPath = CommonUtil.isNull(CommonUtil.getMessage("QUARTZ_LOG.PATH"));
		String strClassName	= "sysadmin";
		String strLogPath	= CommonUtil.getWebRootPath() + "/" + strQuartzLogPath + strClassName + "/";
		String strFilePath 	= CommonUtil.isNull(CommonUtil.getDefaultXmlPath())+file_name;

		try (OutputStream outputStream = new FileOutputStream(strFilePath)) {
			// XML을 파일에 쓰기
			javax.xml.transform.TransformerFactory.newInstance().newTransformer().transform(
					new javax.xml.transform.dom.DOMSource(document),
					new javax.xml.transform.stream.StreamResult(outputStream)
			);
		}

		String filePath = CommonUtil.isNull(strFilePath); // 기존 XML 파일 경로
		String doctype = "<!DOCTYPE properties SYSTEM \"http://java.sun.com/dtd/properties.dtd\">\n";
		System.out.println("::::::::::::::::"+filePath);
		try {
			// 기존 XML 파일 읽기
			String content = new String(Files.readAllBytes(Paths.get(strFilePath)));

			// DOCTYPE 선언 추가
			String newContent = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n" + doctype + content.substring(content.indexOf(">") + 1);

			// 변경된 내용을 새 파일에 저장
			Files.write(Paths.get(filePath), newContent.getBytes(), StandardOpenOption.CREATE);

			//TraceLogUtil.TraceLog("["+CommonUtil.getRemoteIp(request)+"] "+key + " : " + s_key, strLogPath, "jdbc");

		} catch (IOException e) {
			TraceLogUtil.TraceLog(e.toString(), strLogPath, file_name);

			e.printStackTrace();
		}
	}
	
	/* 2024. 05. 21 (이기준)
	 * 패스워드 소스 리펙토링 관련
	 * 사용자 암호 유효성 체크
	 * */
	public static void passwordValid (Map map)  throws Exception {
		
		String strNewPassword 		= CommonUtil.isNull(map.get("new_user_pw"));
		String strUserId 			= CommonUtil.isNull(map.get("user_id"));
		// 신규 패스워드 규칙 체크			
		boolean isLength 		= false;
		boolean isNumber 		= false;
		boolean isSpecialChar 	= false;
		boolean isLowerChar 	= false;
		boolean isPasswordCheck	= false;
		boolean isIdCheck		= true;
		Map rMap = null;
		
		// 8자리 이상 체크
		if ( strNewPassword.length() > 7 ) {
			isLength = true;
		}
		
		char tempChar;
		String validNumber 		= "0123456789";
		String validSpecialChar = "{}[]|\\~`!@#$^:?'*";
		
		for ( int i = 0; i < strNewPassword.length(); i++ ) {

			tempChar = strNewPassword.charAt(i);
		
			// 숫자 체크
			for ( int j = 0; j < validNumber.length(); j++ ) {

				if ( validNumber.charAt(j) == tempChar ) {
					isNumber = true;
				}
			}

			// 특수문자 체크
			for ( int j = 0; j < validSpecialChar.length(); j++ ) {

				if ( validSpecialChar.charAt(j) == tempChar ) {
					isSpecialChar = true;
				}
			}

			// 소문자 체크
			if ( (tempChar >= 'a') && (tempChar <= 'z') ) {
				isLowerChar = true;
			}
		}
		
		// ID 문자열 체크
		/*
		 * if ( strNewPassword.indexOf(strUserId) > -1 ) { isIdCheck = false; }
		 */
		
		if(strUserId.length() >= 4) { 
			for ( int i = 0 ; i < strUserId.length(); i++ ) {
				
				char[] tmp = {strUserId.charAt(i) , strUserId.charAt(i+1) , strUserId.charAt(i+2) , strUserId.charAt(i+3)};
				
				String tmpId = String.valueOf(tmp);
				// 동일 숫자, 문자 체크
				logger.debug("tmp : " + tmp);
				logger.debug("tmp : " + tmpId);
				logger.debug("tmp : " + strNewPassword);
				logger.debug("tmp : " + (strNewPassword.indexOf(tmpId) > -1));
				
				if (strNewPassword.indexOf(tmpId) > -1) {
					isIdCheck = false;
					break;
			  	}else{
			  		isIdCheck = true;
			  		break;
			  	}
			}		
		}
		
		if ( !isLength ) {
			rMap = new HashMap();
			rMap.put("r_code",	"-1");
			rMap.put("r_msg",	"ERROR.59");
			throw new DefaultServiceException(rMap);
		}
		
		if ( !isNumber ) {
			rMap = new HashMap();
			rMap.put("r_code",	"-1");
			rMap.put("r_msg",	"ERROR.60");
			throw new DefaultServiceException(rMap);
		}
		
		if ( !isSpecialChar ) {
			rMap = new HashMap();
			rMap.put("r_code",	"-1");
			rMap.put("r_msg",	"ERROR.61");
			throw new DefaultServiceException(rMap);
		}
		
		if ( !isLowerChar ) {
			rMap = new HashMap();
			rMap.put("r_code",	"-1");
			rMap.put("r_msg",	"ERROR.62");
			throw new DefaultServiceException(rMap);
		}
		
		if ( !isIdCheck ) {
			rMap = new HashMap();
			rMap.put("r_code",	"-1");
			rMap.put("r_msg",	"ERROR.64");
			throw new DefaultServiceException(rMap);
		}

		if ( (isLength && isNumber && isSpecialChar && isLowerChar) ) {
			isPasswordCheck = true;
		}
		
		if ( !isPasswordCheck ) {
			rMap = new HashMap();
			rMap.put("r_code",	"-1");
			rMap.put("r_msg",	"ERROR.35");
			throw new DefaultServiceException(rMap);
		}
		
		boolean bRepeatCheck = true;
		for ( int i = 0 ; i < strNewPassword.length() - 3; i++ ) {
	
			// 동일 숫자, 문자 체크
			if ( (strNewPassword.charAt(i) == strNewPassword.charAt(i+1)) &&
				 (strNewPassword.charAt(i+1) == strNewPassword.charAt(i+2)) && 
				 (strNewPassword.charAt(i+2) == strNewPassword.charAt(i+3)) ) {
				
				bRepeatCheck = false;
		  	}
		}			
		
		if ( !bRepeatCheck ) {
			rMap = new HashMap();
			rMap.put("r_code",	"-1");
			rMap.put("r_msg",	"ERROR.36");
			throw new DefaultServiceException(rMap);
		}
		
		boolean bSameCheck1	= false;
		boolean bSameCheck2 = false;
		int iSameCnt_1 		= 0;
		int iSameCnt_2 		= 0;				
		
		for ( int i = 0 ; i < strNewPassword.length() - 1; i++ ) {
			
			// 연속 숫자, 문자 체크
			if ( (int)strNewPassword.charAt(i) - (int)strNewPassword.charAt(i+1) == 1 ) {
				iSameCnt_1++;
		  	} else {
				iSameCnt_1 = 0;						
		  	}
			
			// 연속 숫자, 문자 체크
			if ( (int)strNewPassword.charAt(i) - (int)strNewPassword.charAt(i+1) == -1 ) {
				iSameCnt_2++;
			} else {
				iSameCnt_2 = 0;						
		  	}					
			
			if ( iSameCnt_1 >= 3 )  {
				bSameCheck1 = true;
			}
			
			if ( iSameCnt_2 >= 3 )  {
				bSameCheck2 = true;
			}					
		}
		
		if ( bSameCheck1 || bSameCheck2 ) {
			rMap = new HashMap();
			rMap.put("r_code",	"-1");
			rMap.put("r_msg",	"ERROR.37");
			throw new DefaultServiceException(rMap);
		}
		
		String strManyUsingCharList = "password|monkey|football|baseball|dragon|master|iloveyou|passw0rd|superman|abcde|love|happy";
		String[] strManyUsingCharArr = strManyUsingCharList.split("[|]");
		
		logger.debug("strNewPassword.toLowerCase() : " + strNewPassword.toLowerCase());
		
		boolean bManyUsingCheck1 = false;
		for(int i=0; i<strManyUsingCharArr.length; i++) {
			System.out.println(strNewPassword.toLowerCase().matches(".*"+strManyUsingCharArr[i]+".*"));
			if(strNewPassword.toLowerCase().matches(".*"+strManyUsingCharArr[i]+".*")) {
				bManyUsingCheck1 = true;
			}
		}
		
		String strKeyArrCharList = "qwer|wert|erty|rtyu|tyui|yuio|uiop|asdf|sdfg|dfgh|fghj|ghjk|hjkl|zxcv|xcvb|cvbn|vbnm|1qaz|2wsx|3edc|4rfv|5tgb|6yhn|7ujm";
		String[] strKeyArrCharArr = strKeyArrCharList.split("[|]");
		
		logger.debug("strNewPassword.toLowerCase() : " + strNewPassword.toLowerCase());
		
		boolean bManyUsingCheck2 = false;
		for(int i=0; i<strKeyArrCharArr.length; i++) {
			
			logger.debug(strNewPassword.toLowerCase().matches(".*"+strKeyArrCharArr[i]+".*"));
			
			if(strNewPassword.toLowerCase().matches(".*"+strKeyArrCharArr[i]+".*")) {
				bManyUsingCheck2 = true;
			}
		}
		
		if(bManyUsingCheck1) {
			rMap = new HashMap();
			rMap.put("r_code",	"-1");
			rMap.put("r_msg",	"ERROR.66");
			throw new DefaultServiceException(rMap);
		}

		if(bManyUsingCheck2) {
			rMap = new HashMap();
			rMap.put("r_code",	"-1");
			rMap.put("r_msg",	"ERROR.67");
			throw new DefaultServiceException(rMap);
		}
	}
	/* 2024. 05. 21 (이기준)
	 * 패스워드 소스 리펙토링 관련
	 * 사용자 패스워드 암호화
	 * */
	public static String passwordEncrypt (Map map, String password)  throws Exception {
		
		String strEncPassword = "";
		strEncPassword = toSha512(password+CommonUtil.isNull(map.get("user_id"))+CommonUtil.getMessage("SERVER_GB"));
		return strEncPassword;
		
	}
	
	
	/* 2024. 05. 30 (이기준)
	 * 패스워드 소스 리펙토링 관련
	 * 사용자 세팅 값 세션에 담기
	 * */
	public static void userSelectSessionSet (Map map){
		
		String s_user_cd = CommonUtil.isNull(map.get("s_user_cd"));
		String udt_user_cd	 = CommonUtil.isNull(map.get("user_cd"));
		
		if(s_user_cd.equals(udt_user_cd)) { // 현재 사용자와 수정하려는 사용자가 일치할 경우
			
			// 폴더, 어플리케이션, 그룹 즐겨찾기 정보는 실시간 session에 담는다.
			String select_data_center_code 	= CommonUtil.isNull(map.get("select_data_center_code"));
			String select_table_name 		= CommonUtil.isNull(map.get("select_table_name"));
			String select_application 		= CommonUtil.isNull(map.get("select_application"));
			String select_group_name 		= CommonUtil.isNull(map.get("select_group_name"));
			
			HttpServletRequest request 	= ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
			
			request.getSession().setAttribute("SELECT_DATA_CENTER_CODE", 	select_data_center_code);
			request.getSession().setAttribute("SELECT_TABLE_NAME", 			select_table_name);
			request.getSession().setAttribute("SELECT_APPLICATION", 		select_application);
			request.getSession().setAttribute("SELECT_GROUP_NAME", 			select_group_name);
			
		}
	}
	
	// MFT 값 가져오기
	public static String getMftValue(String strDocCd) {
	
		CommonService commonService = (CommonService)getSpringBean("commonService");
		Map<String, Object> paramMap 	= new HashMap<String, Object>();
		String mftValue = "";
		
		paramMap.put("doc_cd", 	strDocCd);
		paramMap.put("SCHEMA", 	CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		List<CommonBean> jobMappermftInfolist = commonService.dGetSetvarList(paramMap);
		
		for (int i = 0; i < jobMappermftInfolist.size();i++) {
			CommonBean bean = (CommonBean)jobMappermftInfolist.get(i);
			
			mftValue += bean.getVar_name() + "," + bean.getVar_value() + "|";
		}
				
		System.out.println("mftValue :  " + mftValue);
		
		
		return mftValue;
	}
	
	public static void logger(String s, Exception e){
		if(e!=null) logger.error(s,e);
		else logger.info(s);
	}
	
	 // 재귀적으로 JSON 객체에서 키를 추출하는 메서드
	public static void extractKeys(JSONObject jsonObj, Set<String> keySet) throws JSONException {
	    // Job 키가 있는 경우 맨 앞에 추가
	    if (jsonObj.has("Job")) {
	        keySet.add("Job");
	    }

	    Iterator<String> keys = jsonObj.keys();
	    
	    while (keys.hasNext()) {
	        String key = keys.next();
	        
	        // Job은 이미 추가했으므로 건너뜀
	        if (!key.equals("Job")) {
	            keySet.add(key);
	        }

	        // 중첩된 JSON 객체가 있으면 재귀적으로 처리
	        if (jsonObj.get(key) instanceof JSONObject) {
	            extractKeys(jsonObj.getJSONObject(key), keySet);
	        }
	    }
	}

    
    public static String convertDocumentToString(Document doc) {
        try {
            // TransformerFactory를 사용하여 Transformer 생성
            TransformerFactory tf = TransformerFactory.newInstance();
            Transformer transformer = tf.newTransformer();

            // Document를 변환할 StringWriter 준비
            StringWriter writer = new StringWriter();
            transformer.transform(new DOMSource(doc), new StreamResult(writer));

            // StringWriter에 담긴 내용을 반환
            return writer.getBuffer().toString();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
    
    public static int sendTempPasswordNoti(String user_id) throws Exception {

		Map<String, Object> paramMap = new HashMap<String, Object>();

		CommonService commonService 						= (CommonService)getSpringBean("commonService");
		WorksUserService worksUserService 					= (WorksUserService)getSpringBean("tWorksUserService");

		int iSendResult	= 0;
		paramMap.put("p_search_gubun", "user_id");
		paramMap.put("p_search_gubun", user_id);
		
		

		return iSendResult;
	}
}