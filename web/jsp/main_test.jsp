<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/jsp/common/inc/header.jsp"%>
<%
	String user_id = CommonUtil.isNull(S_USER_ID);
	String user_ip = CommonUtil.isNull(S_USER_IP);
	out.println("로그인 ID: "+user_id+", IP: "+user_ip);
	
%>
<br><br><br>
<b><font size="2">작업등록정보</font></b><br>
<br>
-<a href="<%=sContextPath%>/mEm.ez?c=ez003">1.작업등록정보>배치등록정보</a>(내역만 완료, 작업상세정보 미작업(CRUD))<br>
-<a href="<%=sContextPath %>/tWorks.ez?c=ez012">2.작업등록정보>작업담당자이력</a>(내역/등록/수정/삭제 완료, 작업상세정보 미작업(CRUD))<br>
-<a href="<%=sContextPath%>/mEm.ez?c=ez004">3.작업등록정보>선행작업불일치</a><font color="red">(완료)</font><br><br>

<br>
<b><font size="2">작업수행관리</font></b><br>
<br>
-<a href="<%=sContextPath%>/mEm.ez?c=ez007">4.작업수행관리>수행결과현황</a><font color="red">(내역 완료, 팝업 부분은 기존파일 사용)</font><br>
-<a href="<%=sContextPath%>/tWorks.ez?c=ez009">5.작업수행관리>작업상태변경</a>(내역 완료, 팝업 부분은 기존파일 사용, 실시간 작업정보 미작업(CRUD))<br>
-<a href="<%=sContextPath%>/tWorks.ez?c=ez040">6.작업수행관리>작업상태변경이력</a><font color="red">(완료)</font><br>
-<a href="<%=sContextPath%>/mEm.ez?c=ez019">7.작업수행관리>발행컨디션조회</a><font color="red">(완료)</font><br>
-<a href="">8.작업수행관리>시간대별수행이력(퓨전차트)</a>(차트부분 작업해야 함)<br>
-<a href="<%=sContextPath %>/mEm.ez?c=ez018">9.작업수행관리>배치수행현황보고</a><font color="red">(완료, 기존 파일 사용)</font><br><br>

<br>
<b><font size="2">작업등록/결재</font></b><br>
<br>
-<a href="<%=sContextPath%>/tWorks.ez?c=ez004_w_new">10.작업등록결재>작업등록/변경요청</a>(CRUD)<br>
-<a href="<%=sContextPath%>/tWorks.ez?c=ez010">11.작업등록결재>비정기작업의뢰</a>(CRUD)<br>
-<a href="">12.작업등록결재>일괄작업등록</a>(CRUD)<br>
-<a href="<%=sContextPath%>/tWorks.ez?c=ez004">13.작업등록결재>요청서류함</a>(내역 완료, 작업상세정보, 일괄요청서 생성/해제 미작업(CRUD))<br>
-<a href="<%=sContextPath%>/tWorks.ez?c=ez005">14.작업등록결재>결재서류함</a>(내역부분만 작업함, 작업상세정보 미작업(CRUD))<br>
-<a href="<%=sContextPath%>/tWorks.ez?c=ez007">15.작업등록결재>전체결재현황</a>(내역부분만 작업함, 작업상세정보 미작업(CRUD))<br><br>

<br>
<b><font size="2">오류관리</font></b><br>
<br>
-<a href="<%=sContextPath %>/aEm.ez?c=ez001">16.오류관리>Alert Monitor</a>(내역만 완료, 작업상세정보 미작업(CRUD))<br>
-<a href="<%=sContextPath %>/aEm.ez?c=ez003">17.오류관리>일배치오류관리</a><font color="red">(완료)</font><br><br>

<br>
<b><font size="2">통계/리포트</font></b><br>
<br>
-<a href="<%=sContextPath %>/mEm.ez?c=ez005">18.통계/리포트>일총괄표</a><font color="red">(완료)</font><br>
-<a href="<%=sContextPath %>/mEm.ez?c=ez011">19.통계/리포트>월총괄표</a><font color="red">(완료, 기존 파일 사용)</font><br><br>

<br>
<b><font size="2">관리자</font></b><br>
<br>
-<a href="<%=sContextPath%>/tWorks.ez?c=ez008">20.관리자>부서관리/직책관리</a><font color="red">(완료)(CRUD)</font><br>
-<a href="<%=sContextPath%>/tWorks.ez?c=ez002">21.관리자>사용자관리</a><font color="red">(완료)(CRUD)</font><br>
-<a href="<%=sContextPath %>/mEm.ez?c=ez010">22.관리자>C-M관리</a>()<br>
-<a href="<%=sContextPath%>/tWorks.ez?c=ez013">23.관리자>호스트관리</a><font color="red">(완료)(CRUD)</font><br>
-<a href="<%=sContextPath%>/tWorks.ez?c=ez014">24.관리자>코드관리</a><font color="red">(완료)(CRUD)</font><br>
-<a href="<%=sContextPath%>/tWorks.ez?c=ez022">25.관리자>결재라인관리</a><font color="red">(완료)(CRUD)</font><br>
-<a href="">26.관리자>APP관리</a><font color="red">미사용</font><br>

<br>
<b><font size="2">공통</font></b><br>
<br>
-<a href="<%=sContextPath%>/tWorks.ez?c=ez002_info">27.사용자정보수정</a><font color="red">(완료)(CRUD)</font><br>
-<a href="">28.메인</a><br>
-<a href="<%=sContextPath%>/common.ez?c=ezComCode">공통코드관리(신규)</a><br>
-<a href="<%=sContextPath%>/tWorks.ez?c=ez002_edit">사용자정보수정(신규)</a><br>
-<a href="<%=sContextPath%>/common.ez?c=ezAppGrp">App/Group관리</a><br>
-<a href="<%=sContextPath%>/common.ez?c=ezCalCode">스케즐관리</a><br>
-<a href="<%=sContextPath%>/common.ez?c=ezBoardList">공지사항관리</a><br>
-<a href="<%=sContextPath%>/tWorks.ez?c=test">테스트</a><br>




