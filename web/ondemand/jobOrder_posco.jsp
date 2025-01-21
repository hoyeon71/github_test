<%@page import="java.util.concurrent.TimeUnit"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.InputStream"%>
<%@page import="com.ghayoun.ezjobs.common.util.TelnetUtil"%>
<%@page import="com.ghayoun.ezjobs.common.util.Ssh2Util"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.ghayoun.ezjobs.comm.domain.CommonBean"%>
<%@page import="java.util.List"%>
<%@page import="org.springframework.web.context.request.RequestContextHolder"%>
<%@page import="org.springframework.web.context.request.ServletRequestAttributes"%>
<%@page import="com.ghayoun.ezjobs.t.axis.T_Manager4"%>
<%@page import="com.ghayoun.ezjobs.common.util.CommonUtil"%>
<%@page import="com.ghayoun.ezjobs.t.repository.EmJobOrderDao"%>
<%@page import="com.ghayoun.ezjobs.common.axis.ConnectionManager"%>
<%@page import="com.ghayoun.ezjobs.common.util.SeedUtil"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%
	/*
		* 작성자 : 강명준
		* 소유자 : 가연아이앤씨 (http://ghayoun.com)
		* 해당 소스에 대한 저작권은 가연아이앤씨에 있습니다.
		* 해당 소스를 이용하여 상업적인 목적의 사이트에 이용할 수 없습니다.
		* 단, 소유자의 허락을 득한 후 이용을 할 수 있습니다.
	*/
	
%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.util.Properties"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.bmc.ctmem.schema900.*"%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	//HttpServletRequest req = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
	String conIp = request.getRemoteAddr();
	//System.out.println("conIp : " + conIp); 
	/**
	* C-M API를 사용하기 위해 클래스 선언.
	**/
	T_Manager4 t4 								= new T_Manager4();
	ConnectionManager cacm 						= new ConnectionManager();
	Map map 									= new HashMap();
	Map<String, Object> tokenResultMap			= new HashMap<String, Object>();
	Map resultMap 								= new HashMap();
	Map<String, Object> uploadResultMap			= new HashMap<String, Object>();
	Map codeMap 								= new HashMap();
	List sCodeList                              = null;
	
	String tokenReturnCode 		= CommonUtil.isNull(tokenResultMap.get("rCode"));
	String tokenReturnMsg 		= CommonUtil.isNull(tokenResultMap.get("rMsg"));
	String strTokenResult 			= "";
	String strDataCenter			= "";
	String strUserToken 			= "";
	String strResult 				= "";
	String strSCodeNm				= "";
	int iJobCnt		 				= 0;
	int ipBool  					= 0;
	
// 	out.println("tokenReturnCode : " + tokenReturnCode);
	
	if( "1".equals(tokenReturnCode) ){
		ResponseUserRegistrationType t = (ResponseUserRegistrationType)tokenResultMap.get("rObject");
		strUserToken = t.getUserToken();
		strTokenResult = "인증 성공";
		
	} else {
		
		strTokenResult = tokenReturnMsg;
		
		//예외처리 
		//System.out.println("인증 실패입니다. -> " + tokenReturnMsg);
	}

	String strJobName				= CommonUtil.isNull(request.getParameter("JOB_NAME")); 
	String strTableName			= CommonUtil.isNull(request.getParameter("FOLDER_NAME"), "ONLINE");
	String strOrderDate			= CommonUtil.isNull(request.getParameter("ORDER_DATE"), "ODAT");
	String strForceYn				= CommonUtil.isNull(request.getParameter("FORCE_YN"), "Y");
	String strHoldYn				= CommonUtil.isNull(request.getParameter("HOLD_YN"), "N");
	String strTset					= CommonUtil.isNull(request.getParameter("T_SET"));
	
	//strTset = "PARM1,'123;:45'|PARM2,12345";
	
	//strTset = "PARM1, '12345', [12345], {12345}, %%$ODATE +1 -1 %%ODATE ~!@#%^&*() -_=+/<>:: '12345', [12345], {12345}, %%$ODATE +1 -1 %%ODATE ~!@#%^&*() -_=+/<>:: '12345', [12345], {12345}, %%$ODATE +1 -1 %%ODATE";
	
// 	String strDbUrl			= "jdbc:oracle:thin:@TLPBAJOD1:1529:TPCM";
// 	String strDbUrl			= "jdbc:oracle:thin:@TLPBAJOD1:1531:TPNCM";
// 	String strDbUserNm		= "emadm";
// 	String strDbPassword	= "orange1";

	javax.sql.DataSource ds = (javax.sql.DataSource)org.springframework.web.context.ContextLoader.getCurrentWebApplicationContext().getBean("dataSource_em");
	
	Connection con 			= null;
	PreparedStatement pstmt = null;
	ResultSet rs 			= null;
	String sql 				= "";
	try {
		
// 		Class.forName("oracle.jdbc.driver.OracleDriver");

// 		con = DriverManager.getConnection(strDbUrl, strDbUserNm, strDbPassword);

		con = ds.getConnection();

		sql = "SELECT COUNT(*), DATA_CENTER FROM POSEM.DEF_JOB tb1, POSEM.DEF_TABLES tb2 WHERE tb1.table_id = tb2.table_id AND sched_table = '" + strTableName + "' AND job_name = '" + strJobName + "' GROUP BY data_center";
		System.out.println("sql : " + sql);
		pstmt 	= con.prepareStatement(sql);
		rs 	= pstmt.executeQuery();
		
		//out.println("strSql : " + sql + "<BR>");
		System.out.println("rs : " + rs);
		while ( rs.next() ) {
			//out.println("JOB_COUNT = " + rs.getString(1));
			iJobCnt = Integer.parseInt(rs.getString(1));
			strDataCenter = CommonUtil.isNull(rs.getString(2));
		}
		//out.println("<BR>");
		
		con.close();
		
	} catch (Exception e) {
		//out.println(e.getMessage());
	}
	if ( iJobCnt > 0 ) {
		
		
		/*String strHost 				= "";
		String strAccessGubun		= "S";
		int iPort 					= 0;
		String strUserId 			= "";
		String strUserPw 			= "";
		
		//호스트 관리 테이블에서 가져옴
	 	Map<String, Object> paramMap = new HashMap();
	 	paramMap.put("data_center"	, strDataCenter);
	 	paramMap.put("host"			, strDataCenter);
	 	paramMap.put("server_gubun"	, "S");
	 	
	 	CommonService commonService = (CommonService) CommonUtil.getSpringBean("commonService"); 
	 	CommonBean bean = commonService.dGetHostInfo(paramMap);
	 	
	 	if ( bean != null ) {
 			strHost 			= CommonUtil.isNull(bean.getNode_id());
 			strAccessGubun		= CommonUtil.isNull(bean.getAccess_gubun());
 			iPort 				= Integer.parseInt(CommonUtil.isNull(bean.getAccess_port()));
 			strUserId 			= CommonUtil.isNull(bean.getAgent_id());
 			strUserPw 			= SeedUtil.decodeStr(CommonUtil.isNull(bean.getAgent_pw()));
	 	}*/
		
		
	 	String cmd 		= "";
	 	String result 	= "";
	 	//cmd += "export CONTROLM=/TMSVR/ctm_agent/ctm" + "\n";
	 	//cmd += "export PATH=$PATH:$CONTROLM/exe:$CONTROLM/scripts" + "\n";
	 	//cmd += "export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$CONTROLM/exe" + "\n";
	 			
	 	cmd += "echo ctmorder -FOLDER " + strTableName + " -NAME " + strJobName + " -FORCE " + strForceYn + " -ODATE " + strOrderDate + " -HOLD " + strHoldYn;
	 	//cmd = "ctmorder -FOLDER " + strTableName + " -NAME " + strJobName + " -FORCE " + strForceYn + " -ODATE " + strOrderDate + " -HOLD " + strHoldYn;
		
		if(!strTset.equals("")) {
			
			//getVariableAssignments(strTset); 함수 참조
	    	Map<String, Object> tSetMap = new HashMap();
			String[] t_set = strTset.split("[|]");
			
		    if ( t_set != null && t_set.length > 0 ) {
		    	for ( int i = 0; i < t_set.length; i++ ) {
					String[] aTmp = t_set[i].split(",",2);
			    	if ( !"".equals(CommonUtil.isNull(aTmp[0])) ) {
			    		tSetMap.put(aTmp[0], aTmp[1]);
			    	}
		    	}
		    }
		    
		    String strValue = "";
		    for(Map.Entry<String,Object> entry : tSetMap.entrySet()){
		    	
		    	strValue = CommonUtil.isNull(entry.getValue()).replace("$", "\\\\\\$"); 
		    	strValue = strValue.replace("'", "\\'");
		    	strValue = strValue.replace(";", "\\;");
		    	strValue = strValue.replace("?", "\\?");
		    	strValue = strValue.replace("[", "\\[");
		    	strValue = strValue.replace("]", "\\]");
		    	strValue = strValue.replace("{", "\\{");
		    	strValue = strValue.replace("}", "\\}");
		    	strValue = strValue.replace("+", "\\+");
		    	strValue = strValue.replace("-", "\\-");
		    	strValue = strValue.replace("&", "\\&");
		    	strValue = strValue.replace("@", "\\@");
		    	strValue = strValue.replace("`", "\\`");
		    	strValue = strValue.replace("~", "\\~");
		    	strValue = strValue.replace("*", "\\*");
		   		strValue = strValue.replace("(", "\\(");
		   		strValue = strValue.replace(")", "\\)");
		   		strValue = strValue.replace("/", "\\/");
		   		strValue = strValue.replace("<", "\\<");
		   		strValue = strValue.replace(">", "\\>");
		    	
		    	cmd += " -VARIABLE %%" + entry.getKey() +  " \\\"" + strValue + "\\\"";
		    }
		}
		
		cmd += " | sh";
		
		System.out.println("cmd : " + cmd);	
		Process proc 					= null;
		InputStream inputStream 		= null;
		BufferedReader bufferedReader 	= null;
		String[] cmd2					= null;
		String osName 					= System.getProperty("os.name");
		int timeoutInSeconds 			= 15;
		//cmd = "echo $LD_LIBRARY_PATH";
		if(osName.toLowerCase().startsWith("window")) {
			cmd2 = new String[] { "cmd.exe", "/y", "/c", cmd };
		} else {
			cmd2 = new String[] { "/bin/sh", "-c", cmd };
		}
		//System.out.println("cmd2 : " + cmd2);
		proc = Runtime.getRuntime().exec(cmd2);	
		if(!proc.waitFor(timeoutInSeconds, TimeUnit.SECONDS)){
			proc.destroy();
			response.setStatus(500);
		}
		inputStream = proc.getInputStream();
		bufferedReader = new BufferedReader( new InputStreamReader( inputStream, "UTF-8"));
		
		String line 		= "";
		
		while (( line = bufferedReader.readLine()) != null ) {
			result += line;
			//strReturnMsg += (line + "<br>");
		}
		System.out.println("null : " + (bufferedReader.readLine() != null));
		System.out.println("result : " + result);
		
		bufferedReader.close();
		inputStream.close();
			
		/*if(!"".equals(strHost)){
			
			
			if( "S".equals(strAccessGubun) ){
				Ssh2Util su = new Ssh2Util(strHost, iPort, strUserId, strUserPw, cmd, "UTF-8");
				result = su.getOutput();
			}else{
				TelnetUtil tu = new TelnetUtil(strHost, iPort, strUserId, strUserPw, cmd);
				result = tu.getOutput();
			}
		}else{
//	 		sysout = CommonUtil.getMessage("ERROR.09");
		}*/
		
		//out.println(cmd);
		//out.println("<br>");
		//out.println(result);
		//out.println("<br>");
		
		
		
		//map.put("userToken", 		strUserToken);
		//map.put("data_center", 		strDataCenter);
		//map.put("job_name", 		strJobName);
		//map.put("table_name", 		strTableName);
		//map.put("order_date", 		strOrderDate);
		//map.put("force_gubun", 		strForceYn);
		//map.put("hold_yn", 			strHoldYn);
		//map.put("t_set", 			strTset);
		
		/**
		* 2. 작업오더 호출.
		**/
		//resultMap = cam.jobsOrder(cab);
		
		//resultMap = t4.jobsOrder(map);
		//System.out.println("resultMap : " + resultMap);
		//String returnCode 		= CommonUtil.isNull(resultMap.get("rCode"));
		//String returnMsg		= CommonUtil.isNull(resultMap.get("rMsg"));
		
	
		if( result.indexOf("orderno") > -1 ) {
			strResult = "작업 오더 성공";
		} else {
			strResult = result;
			response.setStatus(500);
		}
		
	} else {
		strResult = "작업이 존재하지 않습니다.";
	}
	
	if(strResult.indexOf("FORCE SESSION CLOSE") > -1){
		response.setStatus(700);
	}
	//out.println(strTokenResult);
	//out.println("<br>");
	out.println(strResult);
%>