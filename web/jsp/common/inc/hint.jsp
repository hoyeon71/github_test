<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,java.util.*,java.text.*" %>
<%@ page import="com.ghayoun.ezjobs.common.util.*" %>
<body>
	
	<div id="job_div" style="position:absolute; width:470px; height:300px; left:100px;top:250px; z-index:99; border:3px solid #807e7a; background-color:#ffffff; display:none; overflow:auto; ">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td style="padding:5px 5px 5px 5px; line-height:20px;" class="txt_title3">
					<div  style="overflow:auto;">
						<b>[작업 정보 도움말]</b><br>
						- C-M : Control-M 서버<font color="red"> *필수</font><br>
						- 작업 타입 : command/dummy/script<font color="red"> *필수</font><br>
						<p style="text-indent:2em">① command : 작업수행명령 필수</p>
						<p style="text-indent:2em">② dummy : Dummy 작업</p>
						<p style="text-indent:2em">③ script : 프로그램명/프로그램위치 필수</p>
						- 폴더 : 업무 대그룹<font color="red"> *필수</font><br>
						- 어플리케이션 : 업무 중그룹<font color="red"> *필수</font><br>
						- 그룹 : 업무 소그룹<font color="red"> *필수</font><br>
						- 수행 서버 : 배치 작업을 수행 할 서버<font color="red"> *필수</font><br>
						- 계정명 : 배치 작업을 수행 할 계정<font color="red"> *필수</font><br>
						- 최대대기일 : 해당 작업의 최대 대기일수(최대대기일은 99까지 입력가능) <font color="red"> *필수</font><br>
						- 작업명 : 작업의 ID로 중복 허용 불가<font color="red"> *필수</font><br>
						<p style="text-indent:2em">① 확인 버튼을 클릭해서 중복 체크 및 Out Condition 설정</p>
						- 작업 설명 : 작업 ID 한글 설명<font color="red"> *필수</font><br>
						- 프로그램 명 : 실행할 프로그램 명 <font color="red"> *작업 타입 script 선택시 필수</font><br>
						- 프로그램 위치 : 실행할 프로그램명이 있는 위치 <font color="red"> *작업 타입 script	 선택시 필수</font><br>
						- 작업수행명령 : command 명령어 한 줄<font color="red"> *작업 타입 command 선택시 필수</font><br>
						- 작업시작시간 : 배치 작업의 시작 시간<br>
						- 작업종료시간 : 배치 작업의 종료 시간<br>
						- 시작임계시간 : 작업 시작 한계 시간 설정<br>
						- 종료임계시간 : 작업 종료 한계 시간 설정<br>
						- 수행임계시간 : 작업 수행 한계 시간 설정<br>
						- 반복작업 : 반복 작업 설정<br>
						<p style="text-indent:2em">end: 끝나고나서부터의 시간</p>
						<p style="text-indent:2em">(2시에 끝남, 반복주기가 end 10분이면 2시 10분이 스타트)</p>
						<p style="text-indent:2em">start: 직전의 스타트 시간</p>
						<p style="text-indent:2em">(2시에 수행, 2시에시작해서 2시5분에 끝났다면 2시부터 10분이 지난 2시 10분에 수행됨)</p>
						<p style="text-indent:2em">target: 시간보정</p>
						<p style="text-indent:2em">(평상시 10분주기로 수행하는데 1분마다 작업이 끝나서 문제가 없었는데,</p>
						<p style="text-indent:2em">갑자기 20분 걸려 반복주기가 틀어지면 보정할 시간을 입력함)</p>
						- 최대 반복 횟수 : 반복 작업일 경우 최대 횟수 지정<br>
						- Confirm Flag : Y/N (Y:작업의 상태를 Confirm 해줘야 수행)<br>
						- 우선순위 : 작업이 동일한 서버에서 동시에 SUB 될 경우의 우선 순위 지정 <br>
						<p style="text-indent:2em">(AA:낮음 ~ 99:높음)</p>
						- 성공 시 알람 발송 : 수행 성공일 경우 SMS 발송 여부 선택<br>
						- 중요작업 : RESOURCE 통제 시 최우선 <br>
					</div>
				</td>
			</tr>
		</table>
	</div>

	<div id="month_days_div" style="position:absolute; width:500px;left:300px;top:250px; z-index:99; border:3px solid #807e7a; background-color:#ffffff; display:none;">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<!-- 
		<tr>
			<td style="border-bottom:1px solid #cccccc" colspan="2">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td height="30" class="txt_title3">&nbsp;&nbsp;<strong>실행 날짜 설명</strong></td>
					<td width="27">
						<img src="/imgs/btn_layerclose02.gif" alt="닫기" width="20" height="20" onClick="month_days_div.style.display='none'" style="cursor:pointer;" />
					</td>
				</tr>
				</table>
			</td>
		</tr>
		-->
		<tr>
			<td style="padding:5px 5px 5px 5px; line-height:25px;" class="txt_title3">
			
				<b>[실행 날짜 도움말]</b><br>
				<font color="red">* 날짜, +, -, <, >, D, -D, L, -L 옵션 등을 입력</font><br>
				1. +n : Calendar의 영업일 에 해당일자를 +<br>
				2. -n : Calendar의 영업일 에 해당일자를 -<br>
				3. >n : Calendar에서 해당 영업일자의 익일만 수행(당일포함)<br>
				4. &#60;n : Calendar에서 해당 영업일자의 전일만 수행(당일포함)<br>
				5. Dn : Calendar에서 영업일 중 n번째 영업일만 수행<br>
				6. -Dn : Calendar에서 영업일 중 n번째 영업일만 빼고 수행<br>
				7. Ln : Calendar에서 마지막 영업일 중 n번째 영업일만 수행<br>
				8. -Ln : Calendar에서 마지막 영업일 중 n번째 영업일만 빼고 수행<br>
				9. ALL : Calendar 상관없이 모든 날짜 셋팅
					
			</td>
		</tr>
		</table>
	</div>
	
		<div id="week_days_div" style="position:absolute; width:500px;left:300px;top:250px; z-index:99; border:3px solid #807e7a; background-color:#ffffff; display:none;">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td style="padding:5px 5px 5px 5px; line-height:25px;" class="txt_title3">
			
				<b>[실행 요일 도움말]</b><br>
				<font color="red">* 0~6 사이의 값 또는  +, -, <, >, D, L, D숫자W숫자 옵션 등을 입력</font><br>
				※ 0:일요일 ~ 6:토요일<br>
				1. +n : Calendar의 영업일 중 해당 요일을 +<br>
				2. -n : Calendar의 영업일 중 해당 요일을 -<br>
				3. >n : Calendar에서 해당 요일보다 큰 숫자의 요일 수행(당일포함)<br>
				4. &#60;n : Calendar에서 해당 요일보다 작은 숫자의 요일 수행(당일포함)<br>
				5. Dn : Calendar에서 영업일 중 n번째 영업일만 수행<br>
				6. Ln : Calendar에서 마지막 영업일 중 n번째 영업일만 수행<br>
				7. D숫자W숫자 : Calendar의 영업일 중 D에 해당하는 요일과 W에 해당하는 주차에 수행<br>
				8. ALL : Calendar 상관없이 모든 날짜 셋팅
					
			</td>
		</tr>
		</table>
	</div>
	
	<div id="inc_div" style="position:absolute; width:500px;left:300px;top:250px; z-index:99; border:3px solid #807e7a; background-color:#ffffff; display:none;">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td style="padding:5px 5px 5px 5px; line-height:25px;" class="txt_title3">
									
					<b>[선행작업조건 도움말]</b><br>
					- 선행작업조건 : 선행 작업 조건 정의, +, - 를 사용해서 다 건의 조건 설정 가능<br>
					- 일자유형 : ODAT/STAT/PREV/NEXT<br>
				    	<p style="text-indent:2em">ODAT : 작업의 Original Scheduling Date</p>
						<p style="text-indent:2em">STAT : 작업의 일자 무시</p>
						<p style="text-indent:2em">PREV : 작업의 Original Scheduling Date 바로 전 날</p>
						<p style="text-indent:2em">NEXT : 작업의 Original Scheduling Date 바로 다음 날</p>
					- 구분 : 선행 작업 조건을 논리적으로 연결 (AND/OR)<br>
						
				</td>
			</tr>
		</table>
	</div>
	
	<div id="oc_div" style="position:absolute; width:465px;left:300px;top:250px; z-index:99; border:3px solid #807e7a; background-color:#ffffff; display:none;">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td style="padding:5px 5px 5px 5px; line-height:25px;" class="txt_title3">
									
					<b>[후행작업조건 (자기작업 CONDITION) 도움말]</b><br>
					- OUT CONDITION : 후행 작업 조건 정의, +, - 를 사용해서 다 건의 조건 설정 가능<br>
					- 일자유형 : ODAT/STAT/PREV/NEXT<br>
						<p style="text-indent:2em">ODAT : 작업의 Original Scheduling Date</p>
						<p style="text-indent:2em">STAT : 작업의 일자 무시</p>
						<p style="text-indent:2em">PREV : 작업의 Original Scheduling Date 바로 전 날</p>
						<p style="text-indent:2em">NEXT : 작업의 Original Scheduling Date 바로 다음 날</p>
					- 구분 : 선행 작업 조건을 추가하거나 삭제 (ADD/DELETE)<br>
						
				</td>
			</tr>
		</table>
	</div>
	
	<div id="resource_div" style="position:absolute; width:300px;left:300px;top:250px; z-index:99; border:3px solid #807e7a; background-color:#ffffff; display:none;">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td style="padding:5px 5px 5px 5px; line-height:25px;" class="txt_title3">
									
					<b>[RESOURCE 도움말]</b><br>
					Name : 리소스 명 입력<br>
					Required Usage : 작업의 비중을 갯수로 입력<br>	
				</td>
			</tr>
		</table>
	</div>
	
	<div id="var_div" style="position:absolute; width:300px;left:300px;top:250px; z-index:99; border:3px solid #807e7a; background-color:#ffffff; display:none;">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td style="padding:5px 5px 5px 5px; line-height:25px;" class="txt_title3">
									
					<b>[변수 도움말]</b><br>
					변수 : 작업의 변수 설정<br>
						
				</td>
			</tr>
		</table>
	</div>
	
	<div id="ondo_div" style="position:absolute; width:300px;left:300px;top:250px; z-index:99; border:3px solid #807e7a; background-color:#ffffff; display:none;">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td style="padding:5px 5px 5px 5px; line-height:25px;" class="txt_title3">
									
					<b>[ON/DO 도움말]</b><br>
					- ON : 작업 실행 결과와 타입을 비교<br>
					- DO : 일치하면 특정 기능 수행<br>
					<p style="text-indent:2em">(정상처리, 비정상처리, 재수행, 반복 멈춤 등)</p>
						
				</td>
			</tr>
		</table>
	</div>
	
	<div id="job_execel_div" style="position:absolute; width:500px; height:120px; left:100px;top:350px; z-index:99; border:3px solid #807e7a; background-color:#ffffff; display:none; overflow:auto; ">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td style="padding:5px 5px 5px 5px; line-height:20px;" class="txt_title3">
					<div style="overflow:auto;">
						<b>[작업 정보 도움말]</b><br>
<!-- 						<font color="red"> -->
							- 엑셀내용에 ' 를 넣으실 수 없습니다.<br>
							- 조회 > 배치등록정보 > 엑셀일괄양식으로 일괄 수정/삭제가 가능합니다.<br>
							- 해당 메뉴는 개발서버에서만 사용 가능하며, 운영서버에서는 관리자에게 문의 바랍니다.<br>
							- 엑셀문서는 DRM 해제 후 사용 바랍니다.
<!-- 						</font> -->
					</div>
				</td>
			</tr>
		</table>
	</div>
</body>
