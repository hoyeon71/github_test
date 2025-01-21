package com.ghayoun.ezjobs.comm.repository;

import java.util.List;
import java.util.Map;

import com.ghayoun.ezjobs.comm.domain.AppGrpBean;
import com.ghayoun.ezjobs.comm.domain.BoardBean;
import com.ghayoun.ezjobs.comm.domain.CalCodeBean;
import com.ghayoun.ezjobs.comm.domain.CommonBean;
import com.ghayoun.ezjobs.comm.domain.DgbFwaBean;
import com.ghayoun.ezjobs.comm.domain.HolidayBean;
import com.ghayoun.ezjobs.m.domain.CtmInfoBean;
import com.ghayoun.ezjobs.t.domain.Doc06Bean;
import com.ghayoun.ezjobs.t.domain.DocInfoBean;
import com.ghayoun.ezjobs.t.domain.JobMapperBean;

public interface CommonDao {
	
	public List<CommonBean> dGetSearchItemList(Map map);
	public List<CommonBean> getCategoryList(Map map, String type);
	
	public CommonBean dGetCalendarDetail(Map map);
	
	public List<CommonBean> dGetCalendarYearList(Map map);
	
	public Map emLogin(Map map);
	
	public List<CommonBean> dGetsCodeList(Map map);
	
	public CommonBean dGetHostInfo(Map map);
	
	public CommonBean dGetServerInfo(Map map);
	
	public CommonBean dGetSearchHostInfo(Map map);
	
	public List<CommonBean> dGetAlarmInfo(Map map);
	
	//procedure
	public Map dPrcHost(Map map);
	
	public Map dPrcDatabase(Map map);
	
	
	//dgb--------------------------------------
	public CommonBean dGetDgbFwaShListCnt(Map map);
	public List<DgbFwaBean> dGetDgbFwaShList(Map map);
	
	public CommonBean dGetDgbFwaListCnt(Map map);
	public List<DgbFwaBean> dGetDgbFwaList(Map map);
	
	public DgbFwaBean dGetDgbJobInfo(Map map);
	
	public DgbFwaBean dGetDgbShellInfo(Map map);
	
	public CommonBean dGetDgbDefJobListCnt(Map map);
	public List<DgbFwaBean> dGetDgbDefJobList(Map map);
	public CommonBean dGetDgbDocJobListCnt(Map map);
	public List<DgbFwaBean> dGetDgbDocJobList(Map map);
	
	public CommonBean dGetDgbHostInfo(Map map);
	
	//procedure
	public Map dPrcDgbDoc(Map map);
	
	public CommonBean dGetDefJobCnt(Map map);
	
	public abstract CommonBean dGetSearchItemValue(Map map);
	
	public Map dPrcLog(Map map);
	
	public List<CommonBean> dGetJobNameList(Map map);
	
	//사용자 게시판
	public List<BoardBean> dGetBoardList(Map<String, Object> map);
	public List<BoardBean> dGetBoardInfo(Map<String, Object> map);
	public Map<String, Object> dPrcBoard(Map<String, Object> map);
	public CommonBean dGetBoardListCnt(Map<String, Object> map);
	public List<BoardBean> dGetBoardNoti(Map<String, Object> map);
	public int dGetBoardCd(Map<String, Object> map);
	public int dPrcBoardInsert(Map<String, Object> map);
	public int dPrcBoardUpdate(Map<String, Object> map);
	public int dPrcBoardDelete(Map<String, Object> map);
	
	//휴일
	public List<HolidayBean> dGetHolidayList(Map<String, Object> map);
	public CommonBean dGetHolidayListCnt(Map<String, Object> map);
	public Map<String, Object> dPrcHoliday(Map<String, Object> map);
	public List<HolidayBean> dGetHolidayDayList(Map<String, Object> map);
	
	//공통코드 관리
	public String dGetMcodeCd(Map<String, Object> map);
	public String dGetScodeCd(Map<String, Object> map);
	public int dGetMcodeDupChk(Map<String, Object> map);
	public int dGetScodeDupChk(Map<String, Object> map);
	public int dPrcMcodeInsert(Map<String, Object> map);
	public int dPrcMcodeUpdate(Map<String, Object> map);
	public int dPrcScodeInsert(Map<String, Object> map);
	public int dPrcScodeUpdate(Map<String, Object> map);
	public int dPrcScodeDelete(Map<String, Object> map);
	public List<CommonBean> dGetScodeList(Map<String, Object> map);
	public List<CommonBean> dGetWorkGroupItemList(Map<String, Object> map);
	
	//App/Group 관리
	public int dGetAppGrpDupChk(Map<String, Object> map);
	public List<AppGrpBean> dGetAppGrpList(Map<String, Object> map);
	public List<AppGrpBean> dGetAppGrp2List(Map<String, Object> map);
	public CommonBean dGetSmartTableChk(Map map);
	public CommonBean dGetSubTableChk(Map map);
	public List<AppGrpBean> dGetSubTableList(Map<String, Object> map);
	public List<CommonBean> dGetSmartTreeList(Map<String, Object> map);
	public List<CommonBean> dGetSmartTreeInfoList(Map<String, Object> map);
	public int dPrcAppGrpInsert(Map<String, Object> map);
	public int dPrcAppGrpUpdate(Map<String, Object> map);
	public int dPrcAppGrpDelete(Map<String, Object> map);
	public int dPrcUserFloderDelete(Map<String, Object> map);
	public List<AppGrpBean> dGetAppGrpCodeList(Map<String, Object> map);
	public List<AppGrpBean> dGetAppGrpCodeList2(Map<String, Object> map);
	public List<AppGrpBean> dGetSearchAppGrpCodeList(Map<String, Object> map);
	public AppGrpBean dGetAppGrpCodeInfo(Map<String, Object> map);
	public int dGetAppGrpCd(Map<String, Object> map);
	public CommonBean dGetHostInfoChk(Map<String, Object> map);
	public int dGetTableMpngHostChk(Map<String, Object> map);
	public AppGrpBean dGetAppParentCd(Map<String, Object> map);
	public AppGrpBean dGetGrpParentCd(Map<String, Object> map);
	
	//스케즐관리 
	public String dGetCalCodeCd(Map<String, Object> map);
	public int dGetCalCodeDupChk(Map<String, Object> map);
	
	//잡등록 파일 다운로드 정보
	public JobMapperBean dGetDocFileInfo(Map<String, Object> map);
	public Doc06Bean dGetDoc06FileInfo(Map<String, Object> map);
	
	//메인 나의수행현황
	public List<CommonBean> dGetMyWorksInfoList(Map<String, Object> map);
	
	public List<CommonBean> dGetMyDocInfoCntList(Map<String, Object> map);
	
	public List<CommonBean> dGetMyAlarmDocInfoCntList(Map<String, Object> map);
	
	public List<CommonBean> dGetMyApprovalDocInfoList(Map<String, Object> map);
	public List<CommonBean> dGetExecDocInfoList(Map<String, Object> map);
	
	public List<CommonBean> dGetMyWorkList(Map<String, Object> map);
	
	//Ctm에서 Active_Net_Name를 가져온다.
	public String dGetCtmActiveNetName(Map<String, Object> map);
	
	//메인페이지 결재요청 건수 및 내역
	public List<DocInfoBean> dGetMainAllDocInfoList(Map<String, Object> map);
	public String dGetMainAllDocInfoCnt(Map<String, Object> map);
	
	//Ctm Log
	public List<CommonBean> dGetCtmLogList(Map<String, Object> map);
	public List<CommonBean> dGetCtmIoalog(Map<String, Object> map);
	public int dPrcCtmIoalogInsert(Map<String, Object> map);
	public int dPrcCtmIoalogPartitionCreate(Map<String, Object> map);
	public int dGetCtmLogPartChk(Map<String, Object> map);
	
	//사용자 결재선
	public List<CommonBean> dGetUserApprovalLine(Map<String, Object> map);
	public List<CommonBean> dGetUserApprovalGroup(Map<String, Object> map);
	public int dPrcUserApprovalLineInsert(Map<String, Object> map);
	public int dPrcUserApprovalLineUpdate(Map<String, Object> map);
	public int dPrcUserApprovalLineDelete(Map<String, Object> map);
	public int dPrcUserApprovalGroupInsert(Map<String, Object> map);
	public int dPrcUserApprovalGroupUpdate(Map<String, Object> map);
	public int dPrcUserApprovalGroupDelete(Map<String, Object> map);
	public int dGetUserApprovalLineSeq(Map<String, Object> map);
	public int dGetUserApprovalGroupSeq(Map<String, Object> map);
	
	public List<CommonBean> dGetAdminApprovalLine(Map<String, Object> map);
	public List<CommonBean> dGetAdminApprovalLine_u(Map<String, Object> map);
	public List<CommonBean> dGetApproavlGroupCnt(Map<String, Object> map);
	public List<CommonBean> dGetWorkGroupList(Map<String, Object> map);
	public List<CommonBean> dGetAdminApprovalGroup(Map<String, Object> map);
	public int dPrcAdminApprovalLineInsert(Map<String, Object> map);
	public int dPrcAdminApprovalLineUpdate(Map<String, Object> map);
	public int dPrcAdminApprovalLineDelete(Map<String, Object> map);
	public int dPrcAdminApprovalGroupInsert(Map<String, Object> map);
	public int dPrcAdminApprovalGroupUpdate(Map<String, Object> map);
	public int dPrcAdminApprovalGroupDelete(Map<String, Object> map);
	public int dGetAdminApprovalLineSeq(Map<String, Object> map);
	public int dGetAdminApprovalGroupSeq(Map<String, Object> map);
	
	public List<CommonBean> dGetGroupApprovalLine(Map<String, Object> map);
	public List<CommonBean> dGetGroupApprovalGroup(Map<String, Object> map);
	public List<CommonBean> dGetGroupUserGroup(Map<String, Object> map);
	public List<CommonBean> dGetGroupUserLine(Map<String, Object> map);
	public List<CommonBean> dGetAdminApprovalLineCd(Map<String, Object> map);
	public List<CommonBean> dGetAdminApprovalLineList(Map<String, Object> map);
	public int dPrcGroupApprovalLineInsert(Map<String, Object> map);
	public int dPrcGroupApprovalLineUpdate(Map<String, Object> map);
	public int dPrcGroupApprovalLineDelete(Map<String, Object> map);
	public int dPrcGroupApprovalGroupInsert(Map<String, Object> map);
	public int dPrcGroupApprovalGroupUpdate(Map<String, Object> map);
	public int dPrcGroupApprovalGroupDelete(Map<String, Object> map);
	public int dGetGroupApprovalLineSeq(Map<String, Object> map);
	public int dGetGroupApprovalGroupSeq(Map<String, Object> map);
	public int dGetGroupUserGroupSeq(Map<String, Object> map);
	public int dGetGroupUserLineSeq(Map<String, Object> map);
	public int dPrcGroupUserGroupInsert(Map<String, Object> map);
	public int dPrcGroupUserGroupUpdate(Map<String, Object> map);
	public int dPrcGroupUserGroupDelete(Map<String, Object> map);
	public int dPrcGroupUserLineInsert(Map<String, Object> map);
	public int dPrcGroupUserLineUpdate(Map<String, Object> map);
	public int dPrcGroupUserLineDelete(Map<String, Object> map);
	
	//CTM DEF 테이블 여부
	public int dGetDefTableCnt(Map<String, Object> map);
	
	public List<CommonBean> dGetCtmAgentList(Map<String, Object> map);	
	public int dPrcCtmAgentInfoUpdate(Map<String, Object> map);	
	
	public int dPrcGrpHostInsert(Map<String, Object> map);
	public int dPrcGrpHostDelete(Map<String, Object> map);
	public int dPrcGrpHostExcelInsert(Map<String, Object> map);
	public List<CommonBean> dGetMHostList(Map<String, Object> map);
	public List<CommonBean> dGetHostInfoList(Map<String, Object> map);
	public List<CommonBean> dGetEzHostList(Map<String, Object> map);
	public List<CommonBean> dGetArgumentList(Map<String, Object> map);
	public List<CommonBean> dGetEmOwnerList(Map<String, Object> map);
	public List<CommonBean> dGetEzOwnerList(Map<String, Object> map);
	
	public List<CommonBean> dGetInCondNameList(Map map);
	
	public CommonBean dGetChkUserApprovalUseCnt(Map map);
	public CommonBean dGetChkAdminApprovalUseCnt(Map map);
	
	public int dGetAdminApprovalGroupChkCnt(Map<String, Object> map);
	public int dGetUserApprovalLineApprovalSeqCnt(Map<String, Object> map);
	public int dGetUserApprovalLineApprovalGbCnt(Map<String, Object> map);
	public int dGetUserApprovalLineApprovalUserCnt(Map<String, Object> map);
	
	public int dGetGroupApprovalLineApprovalSeqCnt(Map<String, Object> map);
	
	public int dGetAdminApprovalLineApprovalSeqCnt(Map<String, Object> map);
	public int dGetAdminApprovalLineApprovalGbCnt(Map<String, Object> map);
	public int dGetAdminApprovalLineApprovalCdCnt(Map<String, Object> map);
	
	public List<CommonBean> dGetCmsNodGrpList(Map map);
	
	public List<CommonBean> dGetCmsNodGrpNodeList(Map map);
	
	public List<CommonBean> dGetCheckSmartTableCnt(Map map);
	
	public List<CommonBean> dGetUserDailyNameList(Map map);
	
	public CommonBean dGetHolidayCheck(Map map);
	
	//dblink
	public void dblinkConnect();
	
	public void dblinkdisConnect();
	
	public List<CtmInfoBean> dGetJobCondList(Map map);
	
	//smartforder
	public List<CommonBean> dGetsForderList(Map map);
	
	public List<CalCodeBean> dGetCalCodeList2(Map<String, Object> map);
	
	public List<CalCodeBean> dGetCalCodeList3(Map<String, Object> map);

	public List<CommonBean> dGetAvgTimeOverJobList(Map map);
	
	public int delSmsUpdate(Map<String, Object> map);
	
	/**
	 * grp_depth : 1 - 삭제할 폴더의 하위 app_grp_code를 모두 조회한다.</br>
	 * grp_depth : 2 - 삭제할 어플리케이션의 하위 app_grp_code를 모두 조회한다.</br>
	 * grp_depth : 3 - 삭제할 그룹의  app_grp_code 조회한다.
	 * @param map
	 * @return
	 */
	public List<AppGrpBean> dGetChildAppGrpCodeList(Map<String, Object> map);
	
	public String dGetNodeInfo(Map<String, Object> map);
	
	/**
	 * 폴더 별 누적 배치 현황
	 * @param map
	 * @return
	 */
	public List dGetBatchTotal(Map map); 
	
	/**
	 * 월 별 의뢰/결재 현황 
	 * @param map
	 * @return
	 */
	public List dGetDocApprovalTotal(Map map);
	
	/**
	 * 네이버 - 상세수행현황
	 * @param map
	 * @return
	 */
	public List dGetJobCondTotal(Map map);
	
	/**
	 * 네이버 - 에러조치내역
	 * @param map
	 * @return
	 */
	public List dGetErrorLogTotal(Map map);
	
	/**
	 * 매퍼테이블(ez_job_mapper)에 없는 원장 테이블(def_job)의 작업 목록을 조회한다.
	 * @param map
	 * @return
	 */
	public List dGetDefJobExceptMapper(Map map);
	
	/**
	 * EzJOBs에 없는 컨트롤엠의 서비스(테이블) 목록을 조회한다. 
	 * @param map
	 * @return
	 */
	public List dGetCmTable(Map map);
	
	/**
	 * EzJOBs에 없는 컨트롤엠의 어플리케이션 목록을 조회한다. 
	 * @param map
	 * @return
	 */
	public List dGetCmApplication(Map map);
	
	/**
	 * EzJOBs에 없는 컨트롤엠의 그룹 목록을 조회한다. 
	 * @param map
	 * @return
	 */
	public List dGetCmGroup(Map map);
	
	/**
	 * EzJOBs배치조회 
	 * @param map
	 * @return
	 */
	public List dGetQuartzList(Map map);
	
	/**
	 * EzJOBs배치조회 팝업
	 * @param map
	 * @return
	 */
	public List dGetPopupQuartzList(Map map);
	
	/* 에러조치내역 전체갯수cnt */
	public List dGetErrorLogTotalCnt(Map map);
	
	//작업 이력조회 팝업창
	public List<CommonBean> dGetJobHistoryInfo(Map map);
	
	//setvar table 조회
	public List<CommonBean> dGetSetvarList(Map map);
	
}