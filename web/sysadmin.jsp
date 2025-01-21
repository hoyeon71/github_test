<%@page import="com.bmc.ctmem.schema900.RequestUserRegistrationType"%>
<%@page import="com.bmc.ctmem.schema900.ResponseUserRegistrationType"%>
<%@page import="com.bmc.ctmem.emapi.InvokeException"%>
<%@page import="com.bmc.ctmem.emapi.EMXMLInvoker"%>
<%@page import="javax.xml.bind.JAXBException"%>
<%@page import="com.bmc.ctmem.schema900.ResponseCheckUserTokenType"%>
<%@page import="javax.xml.bind.Unmarshaller"%>
<%@page import="javax.xml.bind.Marshaller"%>
<%@page import="com.bmc.ctmem.schema900.RequestCheckUserTokenType"%>
<%@page import="javax.xml.bind.JAXBContext"%>
<%@page import="org.json.JSONObject"%>
<%@page import="com.google.gson.JsonObject"%>
<%@ page import="javax.xml.parsers.DocumentBuilderFactory" %>
<%@ page import="javax.xml.parsers.DocumentBuilder" %>
<%@ page import="org.w3c.dom.Document" %>
<%@ page import="org.w3c.dom.Element" %>
<%@ page import="org.w3c.dom.Node" %>
<%@ page import="org.w3c.dom.NodeList" %>
<%@ page import="javax.xml.transform.TransformerFactory" %>
<%@ page import="javax.xml.transform.Transformer" %>
<%@ page import="javax.xml.transform.OutputKeys" %>
<%@ page import="javax.xml.transform.dom.DOMSource" %>
<%@ page import="javax.xml.transform.stream.StreamResult" %>
<%@ page import="java.nio.file.Paths" %>
<%@ page import="java.nio.file.Files" %>
<%@ page import="java.nio.file.StandardOpenOption" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@include file="/jsp/common/inc/header.jsp"%>

<%
	response.setHeader("Cache-Control","no-store"); //HTTP 1.1
	response.setHeader("Pragma","no-cache"); //HTTP 1.0
	response.setDateHeader ("Expires", 0);

	String host_name = "";
	if(CommonUtil.isWindows()){
		host_name = CommonUtil.isNull(System.getenv("COMPUTERNAME")).toUpperCase();
	}else{
		host_name = CommonUtil.isNull(System.getenv("HOSTNAME")).toUpperCase();
	}
	if("".equals(host_name)) host_name = CommonUtil.isNull(InetAddress.getLocalHost().getHostName());

	out.println("Host Name : "+host_name+"<br/>");

	//System.out.println(org.apache.commons.lang.StringEscapeUtils.escapeXml("한글"));

	//System.out.println(Long.valueOf("1344u", 36).toString());
	//System.out.println(Long.toString(4545,36));

	//System.out.println("20151112".substring(4));

	//System.out.println("1%1".indexOf("%"));
	//System.out.println("1%1".replaceAll("%",""));

	//(new com.ghayoun.quartz.ctm.JobCtmSyncAvgForecast()).executeMain() ;
	//(new com.ghayoun.quartz.ctm.JobCtmSyncLog()).executeMain() ;
	//(new com.ghayoun.quartz.ctm.JobCtmSyncDoc()).executeMain() ;
	//(new com.ghayoun.quartz.ctm.JobCtmSyncSysout()).executeMain() ;
	//System.out.println(com.ghayoun.ctm.CtmExe.getInstance().prcAddCond("postsvr01","aaaaaa1","20190418"));

%>

<%

	try{
		Map<String, Object> paramMap = CommonUtil.collectParameters(request);

		Map<String,Object> jdbcMap= new HashMap<String,Object>();

		String gb = CommonUtil.isNull(paramMap.get("gb"));

		if(gb.equals("login")){

			String user_id = CommonUtil.isNull(paramMap.get("user_id"));
			String user_pw = CommonUtil.isNull(paramMap.get("user_pw"));

			if(user_id.equals(CommonUtil.getMessage("SYSADMIN.ID")) && user_pw.equals(CommonUtil.getMessage("SYSADMIN.PW")) ){
				request.getSession().setAttribute("SS_SYSADMIN_ID",user_id);

				CommonUtil.setSessionRsa(request);
				SS_PUBKEY_MOD 		= CommonUtil.isNull(request.getSession().getAttribute("SS_PUBKEY_MOD"));
				SS_PUBKEY_EXP 		= CommonUtil.isNull(request.getSession().getAttribute("SS_PUBKEY_EXP"));
			}else{
				out.println("<div>로그인 실패</div>");
			}
		}else if(gb.equals("logout")){
			request.getSession().setAttribute("SS_SYSADMIN_ID",null);
		}


	String SS_SYSADMIN_ID 		= CommonUtil.isNull(request.getSession().getAttribute("SS_SYSADMIN_ID"));

	String SS_SERVER_GB 		= CommonUtil.isNull(CommonUtil.getMessage("SERVER_GB"));
	String SS_DB_GUBUN	 		= CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"));

	String SS_EMUSER_ID			= CommonUtil.isNull(CommonUtil.getMessage("EM.USER.ID"));
	String SS_EMUSER_PW			= CommonUtil.isNull(CommonUtil.getMessage("EM.USER.PW"));

	String SS_DB_SCHEMA			= CommonUtil.isNull(CommonUtil.getMessage("DB.SCHEMA."+SS_DB_GUBUN+"."+SS_SERVER_GB));
	String SS_GSR_NM			= CommonUtil.isNull(CommonUtil.getMessage("CTM_NM."+SS_DB_GUBUN+"."+SS_SERVER_GB));
	String SS_GSR_URL			= CommonUtil.isNull(CommonUtil.getMessage("CTM_URL."+SS_DB_GUBUN+"."+SS_SERVER_GB));
	String SS_AAPI_URL			= CommonUtil.isNull(CommonUtil.getMessage("AAPI_URL."+SS_DB_GUBUN+"."+SS_SERVER_GB));

	//js version 추가하여 캐시 새로고침
	String jsVersion 			= CommonUtil.getMessage("js_version");

	String strQuartzLogPath 	= CommonUtil.isNull(CommonUtil.getMessage("QUARTZ_LOG.PATH"));
	String strClassName			= "sysadmin";
	String strLogPath			= CommonUtil.getWebRootPath() + "/" + strQuartzLogPath + strClassName + "/";

	// 해당 폴더 없으면 생성.
	if ( !new File(strLogPath).exists() ) {
		new File(strLogPath).mkdirs();
	}
%>

<!DOCTYPE html>
<html>
<head><title></title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=Edge">

	<link href="<%=request.getContextPath() %>/css/common.css" rel="stylesheet" type="text/css" />
	<link href="<%=request.getContextPath() %>/css/custom-theme/jquery-ui.custom.css" rel="stylesheet" type="text/css" />
	<link href="<%=request.getContextPath() %>/css/custom-theme/jquery-ui.works.css" rel="stylesheet" type="text/css" />

	<script type="text/javascript" src="<%=request.getContextPath() %>/js/common.js" ></script>
	<script type="text/javascript" src="<%=request.getContextPath() %>/js/cookie.js" ></script>
	<script type="text/javascript" src="<%=request.getContextPath() %>/js/popup.js" ></script>
	<script type="text/javascript" src="<%=request.getContextPath() %>/js/xhrHandler.js" ></script>
	<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.min.js" ></script>
	<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery-ui.custom.min.js" ></script>
	<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.dialogextend.js" ></script>
	<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.corner.js" ></script>
	<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery-sha256.js" ></script>
	<script type="text/javascript" src="<%=request.getContextPath() %>/js/sha512.min.js" ></script>
	<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.placeholder.js" ></script>
	<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.blockUI.js" ></script>
	<script type="text/javascript" src="<%=request.getContextPath() %>/js/works_common.js?v=<%=jsVersion %>" ></script>

	<script type="text/javascript" src="<%=request.getContextPath()%>/js/jsbn/jsbn.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/jsbn/rsa.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/jsbn/prng4.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/jsbn/rng.js"></script>
	<style type="text/css">
		table, th, td {
			border: 1px solid grey;
		}
	</style>
	<script type="text/javascript" >

		function login(){
			var f = document.f_1;

			if( isNullInput(f.user_id,"[아이디]를 입력하세요.") ) return;
			if( isNullInput(f.user_pw,"[비밀번호]를 입력하세요.") ) return;

			var user_pw_sha512 = hex_sha512($('#user_pw').val());
			user_pw_sha512 = user_pw_sha512.toUpperCase();

			$('#user_pw').val(user_pw_sha512);

			f.target = "_self";
			f.action = "<%=sContextPath %>/sysadmin.jsp?gb=login";
			f.submit();
		}

		function logout(){
			var f = document.f_1;

			f.target = "_self";
			f.action = "<%=sContextPath %>/sysadmin.jsp?gb=logout";
			f.submit();
		}

		function refresh(){
			var f = document.f_1;

			f.target = "_self";
			f.action = "<%=sContextPath %>/sysadmin.jsp";
			f.submit();
		}

		function refresh2(){
			var f = document.f_1;

			f.target = "_self";
			f.action = "<%=sContextPath %>/sysadmin.jsp";
			f.submit();
		}

		function goPrc(gb){
			var f = document.f_1;

			if(gb=='s_rsa'){
				var rsa = new RSAKey();
				rsa.setPublic("<%=SS_PUBKEY_MOD %>", "<%=SS_PUBKEY_EXP %>");

				$('#s_rsa').val(rsa.encrypt($('#s_rsa').val()));
			}

			f.target = "_self";
			f.action = "<%=sContextPath %>/sysadmin.jsp?gb="+gb;
			f.submit();
		}

		//sysconfig 수정
		function goPrc2(){

			if ( !confirm("WEB-INF 하단의 sysconfig_ko_KR.xml만 수정됩니다. \n진행 하시겠습니까?")) return;

			var f = document.f_2;

			f.target = "_self";
			f.action = "<%=sContextPath %>/sysadmin.jsp";
			f.submit();

		}

		//jdbc 수정
		function goPrc3(){

			if ( !confirm("WEB-INF 하단의 JDBC.xml만 수정됩니다. \n진행 하시겠습니까?")) return;

			var f = document.f_3;

			f.target = "_self";
			f.action = "<%=sContextPath %>/sysadmin.jsp";
			f.submit();

		}

		function goPrc4(){

			if ( !confirm("WEB-INF 하단의 JDBC_"+"<%=SS_DB_GUBUN %>"+".xml만 수정됩니다.")) return;

			var f = document.f_4;

			f.target = "_self";
			f.action = "<%=sContextPath %>/sysadmin.jsp";
			f.submit();

		}

		$(document).ready(function(){

			$(':input').live('focus',function(){
				$(this).attr('autocomplete', 'off');
			});
			$("#span_ddl_schema").hide();

			$("#ddl_gb").change(function(){
				if($("#ddl_gb").val() != 'C') {
					$("#span_ddl_schema").show();
				} else {
					$("#span_ddl_schema").hide();
				}
			});
			$("#btn_logout").button().unbind("click").click(function(){
				logout();
			});
			$("#btn_refresh").button().unbind("click").click(function(){
				refresh();
			});
		});
	</script>
</head>

<body topmargin="0" leftmargin="0"  style='padding:50px;'>
<%if("".equals(SS_SYSADMIN_ID)){ %>
<form id="f_1" name="f_1" method="post" onsubmit="return false;">
	<div style='padding:5px;'>
		<input type="text" name="user_id" id="user_id" tabindex='1'   onkeypress="if(event.keyCode==13) login();" class='ime_disabled' style='width:200px' autofocus />
	</div>
	<div style='padding:5px;'>
		<input type="password" name='user_pw' id="user_pw" tabindex='2' onkeypress="if(event.keyCode==13) login();"  style='width:200px'  />
	</div>
	<div style='padding:5px;'>
		<input type="button" tabindex='3' value='login' onclick='login();' />
	</div>
</form>
<%}else{ %>

<form id="f_1" name="f_1" method="post" onsubmit="return false;">
	<font color='blue' size='3'><b>
	login : <%=SS_SYSADMIN_ID %> <br>
	SERVER_GB : <%=SS_SERVER_GB %> <br>
	DB_GUBUN : <%=SS_DB_GUBUN %> <br></b></font>
	<div class='btn_area'  style='padding:5px;'>
		<span id='btn_logout' onclick='logout();'>logout</span>
		<span id='btn_refresh' onclick='refresh();'>refresh</span>
	</div>
	<table border="2" style='width:100%;'>
		<col style='width:10%;'/>
		<col style='width:25%;' />
		<col style='width:5%;' />
		<col style='width:65%;' />
		<tr style='text-align:center;' >
			<td><div class='cellTitle_ez_center'>구분</div></td>
			<td><div class='cellTitle_ez_center'>입력</div></td>
			<td><div class='cellTitle_ez_center'>처리</div></td>
			<td><div class='cellTitle_ez_center'>결과</div></td>
		</tr>
		<tr style='text-align:center;' >
			<td><div class='cellTitle_ez_right2'>Sha512</div></td>
			<td><input type='text' id='s_sha512' name='s_sha512' style='width:95%;' /></td>
			<td><input type='button' value='보기' onclick="goPrc('s_sha512');" /></td>
			<td style='padding:10px;text-align:left'>
				<%
					String s_sha512 = CommonUtil.isNull(paramMap.get("s_sha512"));
					if("s_sha512".equals(gb)){
						out.println("<div>"+s_sha512+"</div>");
					out.println("<div class='cellContent_kang'>"+CommonUtil.toSha512(s_sha512)+"</div>");
					}
				%>
			</td>
		</tr>


		<tr style='text-align:center;' >
			<td><div class='cellTitle_ez_right2'>cypo Enc</div></td>
			<td><input type='text' id='s_cypo_enc' name='s_cypo_enc' style='width:95%;' /></td>
			<td><input type="button" value='보기' onclick="goPrc('s_cypo_enc');" /></td>
			<td style='padding:10px;text-align:left'>
				<%
					String s_cypo_enc = CommonUtil.isNull(paramMap.get("s_cypo_enc"));
					if("s_cypo_enc".equals(gb)){
						out.println("<div>"+s_cypo_enc+"</div>");
						out.println("<div>"+SeedUtil.encodeStr(s_cypo_enc)+"</div>");
					}
				%>
			</td>
		</tr>
		<tr style='text-align:center;' >
			<td><div class='cellTitle_ez_right2'>cypo Dec</div></td>
			<td><input type='text' id='s_cypo_dec' name='s_cypo_dec' style='width:95%;' /></td>
			<td><input type="button" value='보기' onclick="goPrc('s_cypo_dec');" /></td>
			<td style='padding:10px;text-align:left'>
				<%
					String s_cypo_dec = CommonUtil.isNull(paramMap.get("s_cypo_dec"));
					if("s_cypo_dec".equals(gb)){
						out.println("<div>"+s_cypo_dec+"</div>");
						out.println("<div>"+SeedUtil.decodeStr(s_cypo_dec)+"</div>");
					}
				%>
			</td>
		</tr>

		<%-- <tr style='text-align:center;' >
			<td>rsa test</td>
			<td><input type='text' id='s_rsa' name='s_rsa' style='width:95%;' /></td>
			<td><input type="button" value='보기' onclick="goPrc('s_rsa');" /></td>
			<td style='padding:10px;text-align:left'>
				<%
				String s_rsa = CommonUtil.isNull(paramMap.get("s_rsa"));
				if("s_rsa".equals(gb)){
					out.println("<div>"+s_rsa+"</div>");
					out.println("<div>"+CommonUtil.toRsaDec(request,s_rsa)+"</div>");
				}
				%>
			</td>
		</tr> --%>


		<tr style='text-align:center;' >
			<td><div class='cellTitle_ez_right2'>방화벽확인</div></td>
			<td>
				host : <input type='text' id='socket_ip' name='socket_ip' /> <br>
				port : <input type='text' id='socket_port' name='socket_port' />
			</td>
			<td><input type="button" value='확인' onclick="goPrc('s_socket');" /></td>
			<td style='padding:10px;text-align:left'>
				<%
					String socket_ip = CommonUtil.isNull(paramMap.get("socket_ip"));
					String socket_port = CommonUtil.isNull(paramMap.get("socket_port"));
					if("s_socket".equals(gb)){
						Socket conn = null;
						try{
							out.println("<div>"+socket_ip+":"+socket_port+"</div>");

							conn = new Socket(socket_ip,Integer.parseInt(socket_port));

							out.println("<div>"+conn.isConnected()+"</div>");
						}catch(Exception e){
							out.println("<div>"+e+"</div>");
						}finally{
							try{if(conn!=null) conn.close();conn=null;}catch(Exception e){}
						}
					}
				%>
			</td>
		</tr>
		<tr style='text-align:center;' >
			<td><div class='cellTitle_ez_right2'>REST API 테스트</div></td>
			<td>
				AAPI_URL : <input type='text' id='aapi_url' name='aapi_url' value='<%=CommonUtil.isNull(paramMap.get("aapi_url"))%>'/> <br>
				EM ID : <input type='text' id='em_id' name='em_id2' value='<%=CommonUtil.isNull(paramMap.get("em_id2"))%>'/> <br>
				EM PW : <input type='text' id='em_pw' name='em_pw2' value='<%=CommonUtil.isNull(paramMap.get("em_pw2"))%>'/> <br>
			</td>
			<td><input type="button" value='확인' onclick="goPrc('rest_api');" /></td>
			<td style='padding:10px;text-align:left'>
				<%

					if("rest_api".equals(gb)){
						request.getSession().setAttribute("USER_TOKEN", "");
						String aapi_url = CommonUtil.isNull(paramMap.get("aapi_url"));
						String em_id = CommonUtil.isNull(paramMap.get("em_id2"));
						String em_pw = CommonUtil.isNull(paramMap.get("em_pw2"));


						out.println("<div>aapi_url : "+aapi_url+"</div>");
						out.println("<div>em_id : "+em_id+"</div>");
						out.println("<div>em_pw : "+em_pw+"</div>");

						JSONObject responseJson = null;
						JsonObject params 		= null;

						params = new JsonObject();
						params.addProperty("username", em_id);
						params.addProperty("password", em_pw);

						System.out.println("로그인api 시작");

						// 로그인
						responseJson = AAPI_Util.restApiRun(aapi_url + "/session/login", "POST", params, "");


						//token 정상적으로 구해오지 못할 시 예외처리.
						if ( responseJson.toString().indexOf("token") <= -1 ) {

							org.json.JSONArray errors = responseJson.getJSONArray("errors");
							String loginfail = errors.getJSONObject(0).getString("message");

							Map rMap2 = new HashMap();
							rMap2.put("r_code",	"-2");
							rMap2.put("r_msg",	loginfail);
							out.println("<div>"+CommonUtil.isNull(rMap2.get("r_msg"))+"</div>");
							out.println("<div>REST API 테스트 실패</div>");
							System.out.println("rMap2 : " + rMap2);
						}else{
							String token = (String)responseJson.get("token");

							request.getSession().setAttribute("USER_TOKEN", token);
							out.println("<div>USER_TOKEN : "+token+"</div>");
							out.println("<div>REST API 테스트 성공</div>");
						}
					}
				%>
			</td>
		</tr>
		<tr style='text-align:center;' >
			<td><div class='cellTitle_ez_right2'>EM API 테스트</div>
				<span style="text-align:right;color:red;">※ 토큰 유효성 체크로 API 테스트를 하므로 토큰 발행이 선행되어야 함.<br/>(* REST API 테스트부터 진행해주세요.)</span>
			</td>
			<td>
				CTM NM : <input type='text' id='ctm_nm' name='ctm_nm' style='width:70%;' value='<%=CommonUtil.isNull(paramMap.get("ctm_nm")) %>'/> <br>
				CTM URL : <input type='text' id='ctm_url' name='ctm_url' style='width:70%;' value='<%=CommonUtil.isNull(paramMap.get("ctm_url")) %>'/> <br>
				EM ID : <input type='text' id='em_id1' name='em_id1' style='width:70%;' value='<%=CommonUtil.isNull(paramMap.get("em_id1")) %>'/> <br>
				EM PW : <input type='text' id='em_pw1' name='em_pw1' style='width:70%;'  value='<%=CommonUtil.isNull(paramMap.get("em_pw1")) %>'/>
			</td>
			<td>
				<input type="button" value='확인' onclick="goPrc('em_api');" />
				<!-- <input type="button" value='토큰삭제' onclick="goPrc('token_del');" /> -->
			</td>
			<td style='padding:10px;text-align:left'>
				<%
					if("token_del".equals(gb)){
						request.getSession().setAttribute("USER_TOKEN", "");
						out.println("<div>TOKEN 삭제 완료</div>");
					}

					if("em_api".equals(gb)){
						
						String ctm_nm = CommonUtil.isNull(paramMap.get("ctm_nm"));
						String ctm_url = CommonUtil.isNull(paramMap.get("ctm_url"));
						String em_id = CommonUtil.isNull(paramMap.get("em_id1"));
						String em_pw = CommonUtil.isNull(paramMap.get("em_pw1"));

						out.println("<div>ctm_nm : "+ctm_nm+"</div>");
						out.println("<div>ctm_url : "+ctm_url+"</div>");
						out.println("<div>em_id : "+em_id+"</div>");
						out.println("<div>em_pw : "+em_pw+"</div>");
						//세션에 USER_TOKEN 유무 체크 후 없으면 건너뛰고 있으면 EM API로 토큰 유효성 체크
						Map<String, Object> map = new HashMap<String, Object>();
						com.ghayoun.ezjobs.common.axis.ConnectionManager cm = new com.ghayoun.ezjobs.common.axis.ConnectionManager();

						try {

							JAXBContext context 				= JAXBContext.newInstance(RequestCheckUserTokenType.class);
							RequestCheckUserTokenType reqType 	= new RequestCheckUserTokenType();
							java.io.StringWriter sw 			= new java.io.StringWriter();

							reqType.setUserToken(CommonUtil.isNull(request.getSession().getAttribute("USER_TOKEN")));

							// 해당 타입을 토대로 1차적으로 마샬링.
							Marshaller marshaller = CommonUtil.marshalling(context);
							marshaller.marshal(reqType, sw);

							// 마샬링 한 데이터에 API를 호출하기 위한 명세 추가.
							String strReqXml = CommonUtil.marshllingAdd(sw);

							String strResData 	= invokeRequest(strReqXml, ctm_url);
							String strResXml 	= "";

							// 에러 처리.
							if ( strResData.indexOf("ctmem:error") > 0 ) {

								map = CommonUtil.apiErrorProcess(strResData);
								System.out.println("map : " + map);
								out.println("<div>"+CommonUtil.isNull(map.get("r_msg"))+"</div>");
								out.println("<div>EM API 테스트 성공</div>");
								// Exception.
							}else if ( strResData.indexOf("Exception") > 0 ) {

								out.println("<div>"+CommonUtil.isNull(strResData)+"</div>");
								out.println("<div>EM API 테스트 실패</div>");
								// 성공 처리.
							} else {

								strResXml 			= strResData.substring(strResData.indexOf("ctmem")-1);
								String strResTitle 	= strResXml.substring(strResXml.indexOf("ctmem")+6, strResXml.indexOf("xmlns")-1);
								strResXml 			= strResXml.substring(0, strResXml.lastIndexOf("ctmem")+6) + strResTitle + ">";

								ByteArrayInputStream bais 				= new ByteArrayInputStream(strResXml.getBytes());
								JAXBContext context2 					= JAXBContext.newInstance(ResponseCheckUserTokenType.class);
								Unmarshaller unMarshaller 				= context2.createUnmarshaller();
								ResponseCheckUserTokenType dataRoot 	= (ResponseCheckUserTokenType) unMarshaller.unmarshal(bais);

								if ( dataRoot.getStatus().equals("OK") ) {
									out.println("<div>EM API 테스트 성공</div>");
								}
							}

						} catch (JAXBException e) {
							e.printStackTrace();
							out.println("<div>"+e.getMessage()+"</div>");
							out.println("<div>EM API 테스트 실패</div>");
						}

					}
				%>
			</td>
		</tr>
		<tr style='text-align:center;'>
			<td><div class='cellTitle_ez_right2'>스키마 생성</div></td>
			<td>
				생성할 스키마명 : <input type='text' id='schema_nm' name='schema_nm' style="width:50%;"/> <br>
				생성계정 : <input type='text' id='user_nm' name='user_nm' style="width:50%;" value = '<%=SS_EMUSER_ID%>'/>
			</td>
			<td><input type="button" value='생성' onclick="goPrc('schema');" /></td>
			<td style='padding:10px;text-align:left'>
				<%
					String schema_nm 	= CommonUtil.isNull(paramMap.get("schema_nm"));
					String user_nm 		= CommonUtil.isNull(paramMap.get("user_nm"));
					if("schema".equals(gb)){
						String sql_schema = "";
						PreparedStatement ps_1 = null;
						Connection conn_1 = null;

						com.ghayoun.ezjobs.common.util.CryptoDataSource ds_1 = CommonUtil.getDataSourceWorks();
						conn_1 = DbUtil.getConnection(ds_1);

						//if("PG".equals(ddl_db)) sql_schema = "create"+ schema_nm + "authorization" + user_nm;
						sql_schema = "create schema "+ schema_nm + " authorization " + user_nm;

						if(!"".equals(sql_schema)){
							//out.println("<div>"+sql_schema);

							ps_1 	= conn_1.prepareStatement(sql_schema);
							int cnt = ps_1.executeUpdate();
							String cnt2 = "";
							if(cnt == 0){
								cnt2 = "스키마 생성 완료";
							}else{
								cnt2 = "스키마 생성 실패";
							}
							out.println("<div>"+cnt2+"</div>");
						}
					}
				%>
			</td>
		</tr>
		<tr style='text-align:center;' >
			<td><div class='cellTitle_ez_right2'>DDL<br>설정DB : <%=SS_DB_GUBUN%></div></td>
			<td>
				<input type='hidden' id='ddl_db' name='ddl_db' style='width:70px;' value='<%=SS_DB_GUBUN%>' >
				<select id='ddl_gb' name='ddl_gb' style=''>
					<option value='C' >접속확인</option>
					<option value='T' >테이블 생성</option>
					<option value='D' >초기데이터 생성</option>
					<option value='P' >프로시져 생성 </option>
					<option value='S' >시퀀스 생성 </option>
					<option value='TC' >기존데이터 초기화 </option>
				</select>
				<span id = "span_ddl_schema">
				<br>변경 전 schema :
				<input type='text' id='ddl_before_schema' name='ddl_before_schema' style='width:80px;' value=''>
				<br>변경 할 schema :
				<input type='text' id='ddl_after_schema' name='ddl_after_schema' style='width:80px;' value='<%=SS_DB_SCHEMA%>'>
				</span>
			</td>
			<td><input type="button" value='실행' onclick="goPrc('s_ddl');" /></td>
			<td style='padding:10px;text-align:left'>
				<%
					String ddl_db 				= CommonUtil.isNull(paramMap.get("ddl_db"));
					String ddl_gb 				= CommonUtil.isNull(paramMap.get("ddl_gb"));
					String ddl_before_schema	= CommonUtil.isNull(paramMap.get("ddl_before_schema"));
					String ddl_after_schema		= CommonUtil.isNull(paramMap.get("ddl_after_schema"));

					if("s_ddl".equals(gb)){
						int fail_cnt = 0;

						Connection conn = null;
						PreparedStatement ps = null;

						try{
							List<String> ddlList = new ArrayList<String>();

							String sql_path = CommonUtil.getDefaultFilePath()+"/sql";
							if("ORACLE".equals(ddl_db)) sql_path = sql_path+"/oracle" ;
							if("POSTGRE".equals(ddl_db)) sql_path = sql_path+"/pgsql" ;
							System.out.println("sql_path : " + sql_path);

							if("T".equals(ddl_gb)){
								String sTmp = FileUtil.readFile(new File(sql_path,"create.sql"));

								ddlList.addAll(CommonUtil.toArrayList(sTmp.split(";")));
								String sType = "TEXT";
								if("ORACLE".equals(ddl_db)) sType = "CLOB" ;
								for(int i=0;i<ddlList.size();i++){
									ddlList.set(i,ddlList.get(i).replaceAll("TEXT-CLOB",sType));
								}
							}else if("D".equals(ddl_gb)){
								String sTmp = FileUtil.readFile(new File(sql_path,"createData.sql"));

								ddlList.addAll(CommonUtil.toArrayList(sTmp.split(";")));
								String sType = "TEXT";
								if("ORACLE".equals(ddl_db)) sType = "CLOB" ;
								for(int i=0;i<ddlList.size();i++){
									ddlList.set(i,ddlList.get(i).replaceAll("TEXT-CLOB",sType));
								}
							}else if("P".equals(ddl_gb)){
								System.out.println("sql_path : " + sql_path);
								sql_path += "/prc";
								File[] files = new File(sql_path).listFiles();
								for(int i=0;i<files.length;i++){
									ddlList.add(FileUtil.readFile(files[i]));
								}
							}else if("S".equals(ddl_gb)){
								String sTmp = FileUtil.readFile(new File(sql_path,"create_sequences.sql"));

								ddlList.addAll(CommonUtil.toArrayList(sTmp.split(";")));
								String sType = "TEXT";
								if("ORACLE".equals(ddl_db)) sType = "CLOB" ;
								for(int i=0;i<ddlList.size();i++){
									ddlList.set(i,ddlList.get(i).replaceAll("TEXT-CLOB",sType));
								}
							}else if("TC".equals(ddl_gb)){
								String sTmp = FileUtil.readFile(new File(sql_path,"truncateData.sql"));

								ddlList.addAll(CommonUtil.toArrayList(sTmp.split(";")));
								String sType = "TEXT";
								if("ORACLE".equals(ddl_db)) sType = "CLOB" ;
								for(int i=0;i<ddlList.size();i++){
									ddlList.set(i,ddlList.get(i).replaceAll("TEXT-CLOB",sType));
								}
							}

							com.ghayoun.ezjobs.common.util.CryptoDataSource ds = CommonUtil.getDataSourceWorks();

							if("C".equals(ddl_gb)){
								out.println("<div>Driver : "+ds.getDriverClassName()+"</div>");
								out.println("<div>Url : "+ds.getUrl()+"</div>");
								out.println("<div>User : "+ds.getUsername()+"</div>");
								out.println("<div>접속확인");
							}
							conn = DbUtil.getConnection(ds);

							if("C".equals(ddl_gb)){
								out.println(" : 정상</div>");

							} else{
								for(int i=0;i<ddlList.size();i++){
									String sql = ddlList.get(i).trim();
									if("".equals(sql)) continue;
									if(!ddl_before_schema.equals("") && !ddl_after_schema.equals("")) {
										sql = sql.replaceAll("(?i)" + ddl_before_schema, ddl_after_schema);
									}
									int idx = sql.indexOf("(");
									if(idx<0) idx = sql.indexOf("\n");
									//out.println("<div>"+sql.substring(0,idx));

									ps = conn.prepareStatement(sql);

									try{
										int cnt = ps.executeUpdate();
										//out.println(" 성공 : "+cnt+"</div>");
									}catch(Exception e){
										fail_cnt++;
										out.println(" 실패 : "+e+"</div><br>");
									}

									ps.close();
								}
							}

						}catch(Exception e){
						out.println(" : "+e+"</div>");

						}finally{
							if(fail_cnt == 0){
								out.println(" 생성 완료 ");
							}else{
								out.println(fail_cnt + "건 외 생성 완료 ");
							}
							try{if(ps!=null) ps.close();ps=null;}catch(Exception e){}
							try{if(conn!=null) conn.close();conn=null;}catch(Exception e){}
						}
					}
				%>
			</td>
		</tr>
		<tr style='text-align:center;' >
			<td><div class='cellTitle_ez_right2'>DDL 프로시져</div></td>
			<td>
				<input type='text' id='ddl_db_prc' name='ddl_db_prc' value='<%=SS_GSR_NM%>' placeholder='프로시저 이름'>
				<input type='text' id='ddl_prc_name' name='ddl_prc_name' value='' placeholder='프로시저 이름'>
				<input type='text' id='ddl_schema_name' name='ddl_schema_name' value='' placeholder='스키마 이름'>
			</td>
			<td><input type="button" value='실행' onclick="goPrc('s_ddl_prc');" /></td>
			<td style='padding:10px;text-align:left'>
				<%
					if("s_ddl_prc".equals(gb)){
						String ddl_db_prc 		= CommonUtil.isNull(paramMap.get("ddl_db_prc"));
						String ddl_prc_name 	= CommonUtil.isNull(paramMap.get("ddl_prc_name"));
						String ddl_schema_name 	= CommonUtil.isNull(paramMap.get("ddl_schema_name"));

						Connection conn = null;
						PreparedStatement ps = null;
						try{
							List<String> ddlList = new ArrayList<String>();

							String sql_path = CommonUtil.getDefaultFilePath()+"/sql";
							if("OR".equals(ddl_db_prc)) sql_path = sql_path+"/oracle/"+ddl_prc_name ;
							else sql_path = sql_path+"/pgsql/"+ddl_prc_name ;
							String sql_name = sql_path + ".sql";
							File file = new File(sql_name);
							ddlList.add(FileUtil.readFile(file));

							com.ghayoun.ezjobs.common.util.CryptoDataSource ds = CommonUtil.getDataSourceWorks();
							conn = DbUtil.getConnection(ds);
							if(true){
								for(int i=0;i<ddlList.size();i++){
									String sql = ddlList.get(i).trim();
									if("".equals(sql)) continue;
									if(!ddl_schema_name.equals("")) {
										String replaceName = "";
										if("OR".equals(ddl_db_prc)) replaceName = sql.substring(sql.indexOf("PROCEDURE")+"PROCEDURE".length(), sql.indexOf("."));
										else replaceName = sql.substring(sql.indexOf("FUNCTION")+"FUNCTION".length(), sql.indexOf("."));

										sql = sql.replaceAll("(?i)" + replaceName.trim(), ddl_schema_name);
									}
									int idx = sql.indexOf("(");
									if(idx<0) idx = sql.indexOf("\n");
									out.println("<div>"+sql.substring(0,idx));

									ps = conn.prepareStatement(sql);

									try{
										int cnt = ps.executeUpdate();
										out.println(" : "+cnt+"</div>");
									}catch(Exception e){
										out.println(" : "+e+"</div>");
									}

									ps.close();
								}
							}

						}catch(Exception e){
							out.println(" : "+e+"</div>");

						}finally{
							try{if(ps!=null) ps.close();ps=null;}catch(Exception e){}
							try{if(conn!=null) conn.close();conn=null;}catch(Exception e){}
						}
					}
				%>
			</td>
		</tr>

		<tr style='text-align:center;' >
			<td><div class='cellTitle_ez_right2'>DB백업</div></td>
			<td>
				<div>
					<select id='db_backup_gb' name='db_backup_gb' >
						<option value='PG' <%=( ("PG".equals(CommonUtil.isNull(paramMap.get("db_backup_gb"))))?" selected ":"" ) %> >PGSQL</option>
						<%-- 					<option value='OR' <%=( ("OR".equals(CommonUtil.isNull(paramMap.get("db_backup_gb"))))?" selected ":"" ) %> >ORACLE</option> --%>
					</select>
					<select id='db_backup_option' name='db_backup_option' >
						<option value='DB' <%=( ("DB".equals(CommonUtil.isNull(paramMap.get("db_backup_option"))))?" selected ":"" ) %> >데이터베이스백업</option>
						<option value='SC' <%=( ("SC".equals(CommonUtil.isNull(paramMap.get("db_backup_option"))))?" selected ":"" ) %> >스키마백업</option>
						<option value='TA' <%=( ("TA".equals(CommonUtil.isNull(paramMap.get("db_backup_option"))))?" selected ":"" ) %> >특정테이블만 백업</option>
					</select>

					<select id='db_backup_option2' name='db_backup_option2' >
						<option value='ALL' <%=( ("ALL".equals(CommonUtil.isNull(paramMap.get("db_backup_option"))))?" selected ":"" ) %> >백업</option>
						<option value='DA'  <%=( ("DA".equals(CommonUtil.isNull(paramMap.get("db_backup_option"))))?" selected ":"" )  %> >데이터만 백업</option>
						<option value='NDA' <%=( ("NDA".equals(CommonUtil.isNull(paramMap.get("db_backup_option"))))?" selected ":"" ) %> >데이터백업안함</option>
					</select>
				</div>
				<div>
					<input type='text' id='db_backup_user' 		name='db_backup_user' 	value='' placeholder='os em 계정 id/pw'>
					<input type='text' id='db_backup_db' 		name='db_backup_db' 	value='' placeholder='데이터베이스 이름'><br>
					<input type='text' id='db_backup_schema' 	name='db_backup_schema' value='' placeholder='스키마 이름'>
					<input type='text' id='db_backup_table' 	name='db_backup_table' 	value='' placeholder='테이블 이름'>
				</div>
			</td>
			<td><input type="button" value='실행' onclick="goPrc('db_backup');" /></td>
			<td style='padding:10px;text-align:left'>
				<%
					if("db_backup".equals(gb)){
						String db_backup_gb		= CommonUtil.isNull(paramMap.get("db_backup_gb"));
						String db_backup_option = CommonUtil.isNull(paramMap.get("db_backup_option"));
						String db_backup_option2= CommonUtil.isNull(paramMap.get("db_backup_option2"));

						String db_backup_user 	= CommonUtil.isNull(paramMap.get("db_backup_user"));
						String db_backup_db 	= CommonUtil.isNull(paramMap.get("db_backup_db"));
						String db_backup_schema = CommonUtil.isNull(paramMap.get("db_backup_schema"));
						String db_backup_table 	= CommonUtil.isNull(paramMap.get("db_backup_table"));

						String strurl			= CommonUtil.getMessage("jdbc_em.url");
						String strHost			= "";
						String strPort			= "22";
						String strUserId		= db_backup_user.split("/")[0];
						String strUserPw		= db_backup_user.split("/")[1];
						String strDbId 			= CommonUtil.getMessage("jdbc_em.username");
						String strDbPw 			= SeedUtil.decodeStr(CommonUtil.getMessage("jdbc_em.password"));

						String result 			= "";

						try{

							if(!strurl.equals("")) {

								strHost = strurl.split(":", 4)[2].replace("//", "");

								String sql = "";
								if("PG".equals(db_backup_gb)) {
									sql = "em pg_dump ";
									sql += " -U " + strDbId;
// 								sql += " -P " + strUserPw;
									sql += " -d " + db_backup_db;
									if( !db_backup_option.equals("DB") && !db_backup_schema.equals("") ) {
										sql += " -n " + db_backup_schema;
									}

									if( db_backup_option2.equals("DA") ) {
										sql += " -a";
									} else if( db_backup_option2.equals("NDA") ) {
										sql += " -s";
									}

									if( db_backup_option.equals("TA") ) {
										sql += " -t " + db_backup_table;
									}

									sql += " -f ezj_db_backup_" + CommonUtil.getCurDate("YMD") + ".sql";
									sql += "," + strDbPw;
								} else {
								}
								Ssh2Util su = new Ssh2Util(strHost, Integer.parseInt(strPort), strUserId, strUserPw, sql, "UTF-8");
								result = su.getOutput();
							}
						}catch(Exception e){
							out.println(" : "+e+"</div>");
						}finally{
						}
					}
				%>
			</td>
		</tr>
	</form>
	<form id="f_2" name="f_2" method="post" onsubmit="return false;">
	<input type='hidden' id='gb' name='gb' value="sysconfig">
	<table border="2" style='width:100%;'>
		<tr>
			<div class='cellTitle_kang5'>
				sysconfig_ko_KR  <input type="button" value='일괄 수정' onclick="goPrc2();" />
				<span style="text-align:right;color:red;">※ WEB-INF 아래 output 파일만 수정이 됩니다.</span>
			</div>
		</tr>
		<col style='width:15%;'/>
		<col style='width:85%;' />
		<tr style='text-align:center;' >
			<td><div class='cellTitle_ez_center'>구분</div></td>
			<td><div class='cellTitle_ez_center'>데이터</div></td>
			<%--<td><div class='cellTitle_ez_center'>결과</div></td>--%>
		</tr>
		<tr>
		<%
			Document sysdocument = CommonUtil.getDocument("sysconfig_ko_KR.xml");

			NodeList sysEntryList = CommonUtil.getNodeList(sysdocument);

			// 각 entry의 key와 값을 읽어와서 Map에 저장
			for (int i = 0; i < sysEntryList.getLength(); i++) {
				Node entryNode = sysEntryList.item(i);
				if (entryNode.getNodeType() == Node.ELEMENT_NODE) {
					Element sysEntryElement = (Element) entryNode;
					String key = sysEntryElement.getAttribute("key");
					String value = sysEntryElement.getTextContent();

		%>
			<td><div class='cellTitle_ez_right2'><%=key%></div></td>
			<td> <input type='text' id='<%=key%>' name='<%=key%>' style='width:80%;' value=<%=value%>></td>
		</tr>
		<%
				}
			}

			if ("sysconfig".equals(gb)) {
				for (int i = 0; i < sysEntryList.getLength(); i++) {
					Node sys = sysEntryList.item(i);
					if (sys.getNodeType() == Node.ELEMENT_NODE) {
						Element sysElement = (Element) sys;
						String key = sysElement.getAttribute("key");
						if (key != null && !key.isEmpty() && paramMap.containsKey(key)) {
							Object mapValue = paramMap.get(key);
							String nodeValue = sysElement.getTextContent();

							// Map의 값과 비교
							if (!mapValue.toString().equals(nodeValue)) {
								System.out.println("키 '" + key + "'의 값이 다릅니다. NodeList: " + nodeValue + ", Map: " + mapValue);
								sysElement.setTextContent(mapValue.toString());

								out.println("<script type='text/javascript'>");
								out.println("document.getElementById('" + key + "_result').textContent = '수정완료';");
								//out.println("refresh();");
								out.println("</script>");

								TraceLogUtil.TraceLog("[" + CommonUtil.getRemoteIp(request) + "] " + key + " : " + mapValue.toString(), strLogPath, "sysconfig_ko_KR");
							}
						}
					}
				}

				try {
					CommonUtil.replaceXmlfile(sysdocument, "sysconfig_ko_KR.xml");
					out.println("<script type='text/javascript'>");
					out.println("alert('수정완료');");
					out.println("refresh();");
					out.println("</script>");
				} catch (IOException e) {
					TraceLogUtil.TraceLog(e.toString(), strLogPath, "sysconfig_ko_KR");
					e.printStackTrace();
				}
			}

		%>
	</table>
	</form>
	<form id="f_3" name="f_3" method="post" onsubmit="return false;">
	<input type='hidden' id='gb' name='gb' value="jdbc">
		<table border="2" style='width:100%;'>
			<tr>
				<div class='cellTitle_kang5'>
					JDBC  <input type="button" value='일괄 수정' onclick="goPrc3();" />
					<span style="text-align:right;color:red;">※ WEB-INF 아래 output 파일만 수정이 됩니다.</span>
				</div>
			</tr>
			<col style='width:15%;'/>
			<col style='width:85%;' />
			<tr style='text-align:center;' >
				<td><div class='cellTitle_ez_center'>구분</div></td>
				<td><div class='cellTitle_ez_center'>데이터</div></td>
				<%--<td><div class='cellTitle_ez_center'>결과</div></td>--%>
			</tr>
			<tr>
			<%
				Document jdbcDocument = CommonUtil.getDocument("jdbc.xml");

				NodeList jdbNodeList = CommonUtil.getNodeList(jdbcDocument);

				// 각 entry의 key와 값을 읽어와서 Map에 저장
				for (int i = 0; i < jdbNodeList.getLength(); i++) {
					Node jdbNode = jdbNodeList.item(i);
					if (jdbNode.getNodeType() == Node.ELEMENT_NODE) {
						Element jdbElement = (Element) jdbNode;
						String key = jdbElement.getAttribute("key");
						String value = jdbElement.getTextContent();

						value = "'"+value+"'";
			%>
				<td><div class='cellTitle_ez_right2'><%=key%></div></td>
				<td> <input type='text' id='<%=key%>' name='<%=key%>' style='width:80%;' value=<%=value%>></td>
				<%--<td id ='<%=key%>_result' style='padding:10px;text-align:left'></td>--%>
			</tr>
			<%
				}
			}
			if ("jdbc".equals(gb)) {
				for (int i = 0; i < jdbNodeList.getLength(); i++) {
					Node jdb = jdbNodeList.item(i);
					if (jdb.getNodeType() == Node.ELEMENT_NODE) {
						Element jdbElement = (Element) jdb;
						String key = jdbElement.getAttribute("key");
						if (key != null && !key.isEmpty() && paramMap.containsKey(key)) {
							Object mapValue = paramMap.get(key);
							String nodeValue = jdbElement.getTextContent();

							// Map의 값과 비교
							if (!mapValue.toString().equals(nodeValue)) {
								System.out.println("키 '" + key + "'의 값이 다릅니다. NodeList: " + nodeValue + ", Map: " + mapValue);
								jdbElement.setTextContent(mapValue.toString());
								Thread.sleep(1000);
								out.println("<script type='text/javascript'>");
								out.println("document.getElementById('" + key + "_result').textContent = '수정완료';");
								//out.println("refresh();");
								out.println("</script>");

								TraceLogUtil.TraceLog("[" + CommonUtil.getRemoteIp(request) + "] " + key + " : " + mapValue.toString(), strLogPath, "jdbc");
							}
						}
					}
				}

				try {
					CommonUtil.replaceXmlfile(jdbcDocument, "jdbc.xml");
					Thread.sleep(500);
					out.println("<script type='text/javascript'>");
					out.println("alert('수정완료');");
					out.println("refresh();");
					out.println("</script>");
				} catch (IOException e) {
					TraceLogUtil.TraceLog(e.toString(), strLogPath, "jdbc");
					e.printStackTrace();
				}
			}
			%>
		</table>
	</form>
	<form id="f_4" name="f_4" method="post" onsubmit="return false;">
		<input type='hidden' id='gb' name='gb' value="jdbc_gb">
		<table border="2" style='width:100%;'>
			<tr>
				<div class='cellTitle_kang5'>
					<%=SS_DB_GUBUN%> 환경설정(개발:D/테스트:T/운영:P) <input type="button" value='일괄 수정' onclick="goPrc4();" />
					<span style="text-align:right;color:red;">※ WEB-INF 아래 output 파일만 수정이 됩니다.</span>
				</div>
			</tr>
			<col style='width:15%;'/>
			<col style='width:85%;' />
			<%--<col style='width:10%;' />--%>
			<tr style='text-align:center;' >
				<td><div class='cellTitle_ez_center'>구분</div></td>
				<td><div class='cellTitle_ez_center'>데이터</div></td>
				<%--<td><div class='cellTitle_ez_center'>결과</div></td>--%>
			</tr>
			<tr>
			<%
				Document jdbc_db = CommonUtil.getDocument("jdbc_"+SS_DB_GUBUN+".xml");

				NodeList jdbList = CommonUtil.getNodeList(jdbc_db);

				// 각 entry의 key와 값을 읽어와서 Map에 저장
				for (int i = 0; i < jdbList.getLength(); i++) {
					Node entryNode = jdbList.item(i);
					if (entryNode.getNodeType() == Node.ELEMENT_NODE) {
						Element entryElement2 = (Element) entryNode;
						String key = entryElement2.getAttribute("key");
						String value = entryElement2.getTextContent();

						value = "'"+value+"'";
			%>
				<td><div class='cellTitle_ez_right2'><%=key%></div></td>
				<td> <input type='text' id='<%=key%>' name='<%=key%>' style='width:95%;' value=<%=value%>></td>
				<%--<td id ='<%=key%>_result' style='padding:10px;text-align:left'></td>--%>
			</tr>
			<%
					}
				}

				if ("jdbc_gb".equals(gb)) {
					for (int i = 0; i < jdbList.getLength(); i++) {
						Node jdb = jdbList.item(i);
						if (jdb.getNodeType() == Node.ELEMENT_NODE) {
							Element jdbElement = (Element) jdb;
							String key = jdbElement.getAttribute("key");
							if (key != null && !key.isEmpty() && paramMap.containsKey(key)) {
								Object mapValue = paramMap.get(key);
								String nodeValue = jdbElement.getTextContent();

								// Map의 값과 비교
								if (!mapValue.toString().equals(nodeValue.replace("'",""))) {
									System.out.println("키 '" + key + "'의 값이 다릅니다. NodeList: " + nodeValue + ", Map: " + mapValue);
									jdbElement.setTextContent(mapValue.toString());

									Thread.sleep(1000);
									out.println("<script type='text/javascript'>");
									out.println("document.getElementById('" + key + "_result').textContent = '수정완료';");
									//out.println("refresh();");
									out.println("</script>");

									TraceLogUtil.TraceLog("[" + CommonUtil.getRemoteIp(request) + "] " + key + " : " + mapValue.toString(), strLogPath, "jdbc");
								}
							}
						}
					}

					try {
						CommonUtil.replaceXmlfile(jdbc_db, "jdbc_"+SS_DB_GUBUN+".xml");
						out.println("<script type='text/javascript'>");
						out.println("alert('수정완료');");
						out.println("refresh();");
						out.println("</script>");
					} catch (IOException e) {
						TraceLogUtil.TraceLog(e.toString(), strLogPath, "jdbc");
						e.printStackTrace();
					}
				}
			%>
		</table>
	</form>
<%} %>
</body>
</html>

<%
	//com.ghayoun.mina.AgentHandler ah = new com.ghayoun.mina.AgentHandler("127.0.0.1",17080);
	//System.out.println(ah.sendMsg("테스트"));

	}catch(Exception e){
		e.printStackTrace();
		out.println(e.getMessage());
	}
%>
<%!
	public static String invokeRequest(String request, String ctm_url) {

		Collection requests = new LinkedList();

		String password 		= "";
		String encoded_passwd 	= "";

		if (request.length() > 0) {
			requests.add(request.trim());
		}

		Iterator iter = requests.iterator();

		String response = "INVALID REQUEST !!";

		while (iter.hasNext()) {

			request = (String) iter.next();

//    	EMXMLInvoker invoker = new EMXMLInvoker(new GSRComponent(CommonUtil.isNull(CommonUtil.getMessage("ctm_nm"))));
			com.ghayoun.ezjobs.common.axis.ConnectionManager cm = new com.ghayoun.ezjobs.common.axis.ConnectionManager();
			Properties props = new Properties();
			props.setProperty("ServerURL", 	ctm_url);
			props.setProperty("ConfigDir", 	CommonUtil.isNull(CommonUtil.getDefaultFilePath()));
			props.setProperty("ConfigFile", "communication");


			EMXMLInvoker invoker = new EMXMLInvoker();
			String[] args = null;
			invoker.init(args, props);

			try {

				password = cm.GetValFromXml(request,"password");

				if (password.length() > 0 && request.indexOf("request_register") > 0) {

					encoded_passwd 	= invoker.BuildPasswordString(password);
					request 		= request.replaceFirst(password,encoded_passwd);
				}

				response = invoker.invoke(request);
			}
			catch (InvokeException ex) {

				System.out.println("getMajorCode() : " + ex.getMajorCode() );
				System.out.println("getMinorCode() : " + ex.getMinorCode());
				System.out.println("getMessage() : " + ex.getMessage() );
				System.out.println("getReason() : " + ex.getReason() );
				return CommonUtil.isNull(ex.getMessage());
			}
			catch (Exception ex) {
				return CommonUtil.isNull(ex.getMessage());
			}
		}

		return response;
	}
%>