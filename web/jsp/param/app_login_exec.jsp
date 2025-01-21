<%@ page contentType = "text/html; charset=UTF-8" pageEncoding = "UTF-8" %> 
<%@page import="org.json.JSONObject"%>
<%@include file="encrypt.jsp" %>
<%@page import="java.util.Enumeration"%>
<%@include file="/jsp/common/inc/header.jsp"%>

<%
/*******************************************************
**  업무서버에서 선언해야 할 변수- Start
**  필수 전달 Parameter 에 넘겨줘야 할 변수 선언 부
*******************************************************/
	String AP_URL = "http://wjscapp.woorifg.com/tWorks.ez?c=ez001";  // 세션의 SSOID를 이용하여 업무서버의 자체 세션을 생성하는 URL 호출
	String keyValue     = "!wjscapp.woorifg";          // 암호화 Key정보(16자리)
	// 임의의 키를 생성하여 적용 후 포탈에 이 로직이 포함된 URL과 암호화 키를 함께 전달해야 함
	// Examle) keyValue를 "1234567890123456"으로 변경하고 이 페이지의 URL이 http://apptest.example.com/oamsso/param/app_login_exec.jsp 인경우
	// 포탈팀에 암복호화 키이 "1234567890123456" 와 URL인 "http://apptest.example.com/oamsso/param/app_login_exec.jsp"를 전달한다.
/*******************************************************
**  업무서버에서 선언해야 할 변수- End
*******************************************************/

	// 전달 인자(변수)
	// - FINDATA : 암호화된 사용자 정보 - JSON 형태 {"ENT_CODE":"회사코드","USER_ID":"사번","REAL_UNIT_CODE":"점코드","UNIT_CODE":"부서코드"}
	String encryptValue = request.getParameter("FINDATA"); // 암호화된 사용자 정보
	//String encryptValue = "44034e72d5542cc518dddf255e708f62b2d9e8531431c20ecbe9a69a769f16375a7b79e89c2ce41b275a01470fcae884efca70770c7a18939b7cbdebae3693a3fab8363204edf8723b9021dd4954663f4cc26ee6ce6b2b15785d1fa6953017fd"; // 암호화된 사용자 정보
	String decStrAES = decryptAES(encryptValue, keyValue); // 암호화된 사용자정보 복호화 처리  
	JSONObject jsonObj = new JSONObject(decStrAES);

	String userID = jsonObj.get("USER_ID").toString();
	String ENT_CODE = jsonObj.get("ENT_CODE").toString(); // 회사코드
	String UNIT_CODE = jsonObj.get("UNIT_CODE").toString(); // 부서 코드
	
	// 복호화한 SSOID 를 업무 Session에 기록한다.
	session.setAttribute("SSOID", userID);
/*******************************************************
**  업무서버에서 선언해야 할 변수- Start
**  추가적으로 업무서버에서 사용할 세션 선언 부
*******************************************************/
	session.setAttribute("ENT_CODE", ENT_CODE);
	session.setAttribute("UNIT_CODE", UNIT_CODE);
/*******************************************************
**  업무서버에서 선언해야 할 변수- End
*******************************************************/
	
	// session에 SSOID를 기록 후 업무 세션을 시작하기 위한 준비를 한다.
	//response.sendRedirect(AP_URL);
%>

<form name="paramLogin" method="post" target="_self" action="<%=AP_URL%>">	
	<input type="hidden" name="user_id" value="<%=userID%>"	/>	
</form>

<script type="text/javascript">
	document.paramLogin.submit();
</script>