package com.ghayoun.ezjobs.comm.service;

import java.io.Serializable;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;

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

public interface CommonService extends Serializable{

	public List<CommonBean> getCategoryList(Map map, String type);
	public List<CommonBean> dGetSearchItemList(Map map);
	
	public CommonBean dGetCalendarDetail(Map map);
	
	public List<CommonBean> dGetCalendarYearList(Map map);
	
	public Map emLogin(Map map);
	
	public List<CommonBean> dGetsCodeList(Map map);
	
	public CommonBean dGetHostInfo(Map map);
	
	public CommonBean dGetServerInfo(Map map);
	
	public CommonBean dGetSearchHostInfo(Map map); 
	
	public List<CommonBean> dGetUsedJobList(Map map);
	
	public List<CommonBean> dGetResourceList(Map map);
	
	public List<CommonBean> dGetAlarmInfo(Map map);
	
	//procedure
	public Map dPrcHost(Map map) throws Exception;
	
	public Map dPrcDatabase(Map map) throws Exception;
	
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
	
	public CommonBean dGetDefJobCnt(Map map);
	
	public abstract CommonBean dGetSearchItemValue(Map map);
	
	public Map dPrcLog(Map map) throws Exception;

	public List<CommonBean> dGetJobNameList(Map map);
	
	//사용자 게시판
	public List<BoardBean> dGetBoardList(Map<String, Object> map);
	public List<BoardBean> dGetBoardInfo(Map<String, Object> map);
	public Map<String, Object> dPrcBoard(Map<String, Object> map, HttpServletRequest req, BoardBean board) throws Exception;
	public CommonBean dGetBoardListCnt(Map<String, Object> map);
	public List<BoardBean> dGetBoardNoti(Map<String, Object> map);
	
	//휴일관리
	public List<HolidayBean> dGetHolidayList(Map<String, Object> map);
	public CommonBean dGetHolidayListCnt(Map<String, Object> map);
	public Map<String, Object> dPrcHoliday(Map<String, Object> map, HttpServletRequest req) throws Exception;
	public List<HolidayBean> dGetHolidayDayList(Map<String, Object> map);
	
	//내역
	@SuppressWarnings("rawtypes")
	public List dGetItemList(Map map, HttpServletRequest req) throws Exception;
	
	//공통코드
	public String dGetMcodeCd(Map<String, Object> map);
	public String dGetScodeCd(Map<String, Object> map);
	public Map<String, Object> dPrcMcodeInsert(Map<String, Object> map);
	public Map<String, Object> dPrcMcodeUpdate(Map<String, Object> map);
	public Map<String, Object> dPrcScodeInsert(Map<String, Object> map);
	public Map<String, Object> dPrcScodeUpdate(Map<String, Object> map);
	public Map<String, Object> dPrcScodeDelete(Map<String, Object> map);
	public Map<String, Object> dPrcScodeGroupUpdate(Map<String, Object> map);
	public List<CommonBean> dGetScodeList(Map<String, Object> map);
	public List<CommonBean> dGetWorkGroupItemList(Map<String, Object> map);
	
	//App Group 관리
	public List<AppGrpBean> dGetAppGrpList(Map<String, Object> map);
	public List<AppGrpBean> dGetAppGrp2List(Map<String, Object> map);
	public Map<String, Object> dPrcAppGrpExcelInsert(Map<String, Object> map) throws Exception;
	public Map<String, Object> dPrcAppGrpInsert(Map<String, Object> map);
	public Map<String, Object> dPrcAppGrpUpdate(Map<String, Object> map);
	public Map<String, Object> dPrcAppGrpDelete(Map<String, Object> map);
	public List<AppGrpBean> dGetAppGrpCodeList(Map<String, Object> map);
	public List<AppGrpBean> dGetAppGrpCodeList2(Map<String, Object> map);
	public List<AppGrpBean> dGetSearchAppGrpCodeList(Map<String, Object> map);
	
	//잡등록 파일 정보
	public JobMapperBean dGetDocFileInfo(Map<String, Object> map);
	public Doc06Bean dGetDoc06FileInfo(Map<String, Object> map);
	
	//나의수행현황
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
	
	//사용자 결재선
	public List<CommonBean> dGetUserApprovalGroup(Map<String, Object> map);	
	public List<CommonBean> dGetUserApprovalLine(Map<String, Object> map);
	public Map<String, Object> dPrcUserApprovalGroupInsert(Map<String, Object> map) throws Exception;
	public Map<String, Object> dPrcUserApprovalGroupUpdate(Map<String, Object> map) throws Exception;
	public Map<String, Object> dPrcUserApprovalGroupDelete(Map<String, Object> map) throws Exception;
	public Map<String, Object> dPrcUserApprovalGroupTotalUpdate(Map<String, Object> map) throws Exception;
	public Map<String, Object> dPrcUserApprovalLineInsert(Map<String, Object> map) throws Exception;
	public Map<String, Object> dPrcUserApprovalLineUpdate(Map<String, Object> map) throws Exception;
	public Map<String, Object> dPrcUserApprovalLineDelete(Map<String, Object> map) throws Exception;
	public Map<String, Object> dPrcUserApprovalLineGroupUpdate(Map<String, Object> map) throws Exception;
	
	public List<CommonBean> dGetWorkGroupList(Map<String, Object> map);
	public List<CommonBean> dGetAdminApprovalGroup(Map<String, Object> map);
	public List<CommonBean> dGetAdminApprovalLine(Map<String, Object> map);
	public List<CommonBean> dGetAdminApprovalLine_u(Map<String, Object> map);
	public List<CommonBean> dGetApproavlGroupCnt(Map<String, Object> map);
	public Map<String, Object> dPrcAdminApprovalGroupInsert(Map<String, Object> map) throws Exception;
	public Map<String, Object> dPrcAdminApprovalGroupUpdate(Map<String, Object> map) throws Exception;
	public Map<String, Object> dPrcAdminApprovalGroupDelete(Map<String, Object> map) throws Exception;
	public Map<String, Object> dPrcAdminApprovalLineInsert(Map<String, Object> map) throws Exception;
	public Map<String, Object> dPrcAdminApprovalLineUpdate(Map<String, Object> map) throws Exception;
	public Map<String, Object> dPrcAdminApprovalLineDelete(Map<String, Object> map) throws Exception;
	public Map<String, Object> dPrcAdminApprovalLineGroupUpdate(Map<String, Object> map) throws Exception;
	
	public List<CommonBean> dGetGroupApprovalGroup(Map<String, Object> map);
	public List<CommonBean> dGetGroupApprovalLine(Map<String, Object> map);
	public List<CommonBean> dGetGroupUserGroup(Map<String, Object> map);
	public List<CommonBean> dGetGroupUserLine(Map<String, Object> map);
	public List<CommonBean> dGetAdminApprovalLineCd(Map<String, Object> map);
	public List<CommonBean> dGetAdminApprovalLineList(Map<String, Object> map);
	public Map<String, Object> dPrcGroupApprovalGroupInsert(Map<String, Object> map) throws Exception;
	public Map<String, Object> dPrcGroupApprovalGroupUpdate(Map<String, Object> map) throws Exception;
	public Map<String, Object> dPrcGroupApprovalGroupDelete(Map<String, Object> map) throws Exception;
	public Map<String, Object> dPrcGroupApprovalLineInsert(Map<String, Object> map) throws Exception;
	public Map<String, Object> dPrcGroupApprovalLineUpdate(Map<String, Object> map) throws Exception;
	public Map<String, Object> dPrcGroupApprovalLineDelete(Map<String, Object> map) throws Exception;
	public Map<String, Object> dPrcGroupUserGroupInsert(Map<String, Object> map) throws Exception;
	public Map<String, Object> dPrcGroupUserGroupUpdate(Map<String, Object> map) throws Exception;
	public Map<String, Object> dPrcGroupUserGroupDelete(Map<String, Object> map) throws Exception;
	public Map<String, Object> dPrcGroupUserLineInsert(Map<String, Object> map) throws Exception;
	public Map<String, Object> dPrcGroupUserLineUpdate(Map<String, Object> map) throws Exception;
	public Map<String, Object> dPrcGroupUserLineDelete(Map<String, Object> map) throws Exception;
	
	//CTM DEF 테이블 여부
	public int dGetDefTableCnt(Map<String, Object> map);
	
	//CTM Agent Info
	public Map<String, Object> dPrcCtmAgentInfoUpdate(Map<String, Object> map);
	
	//수행서버일괄변경
	public Map<String, Object> dPrcGrpHostInsert(Map<String, Object> map);
	public Map<String, Object> dPrcGrpHostUpdate(Map<String, Object> map);
	public Map<String, Object> dPrcGrpHostsDelete(Map<String, Object> map);
	public Map<String, Object> dPrcGrpHostDelete(Map<String, Object> map);
	public List<CommonBean> dGetMHostList(Map<String, Object> map);
	public List<CommonBean> dGetHostInfoList(Map<String, Object> map);
	public List<CommonBean> dGetArgumentList(Map<String, Object> map);
	
	public List<CommonBean> dGetSrList(Map<String, Object> map);
	
	public List<CommonBean> dGetCmsNodGrpList(Map map);
	
	public List<CommonBean> dGetCmsNodGrpNodeList(Map map);
	
	public List<CommonBean> dGetCheckSmartTableCnt(Map map);
	
	public List<CommonBean> dGetUserDailyNameList(Map map);
	
	public CommonBean dGetHolidayCheck(Map map);
	
	//dblink
	public void dDblinkConnect();
	
	public void dDblinkDisconnect();
	
	public List<CtmInfoBean> dGetJobCondList(Map map);
	
	//smartforder
	public List<CommonBean> dGetsForderList(Map map);
	
	public List<CalCodeBean> dGetCalCodeList2(Map<String, Object> map);
	
	public String dGetNodeInfo(Map<String, Object> map);
	
	/**
	 *  폴더별누적배치현황
	 * @param map
	 * @return
	 */
	public List dGetBatchTotal(Map map);
	
	/**
	 *  월별의뢰결재현황 
	 * @param map
	 * @return
	 */
	public List dGetDocApprovalTotal(Map map);
	
	/**
	 *  상세수행현황
	 * @param map
	 * @return
	 */
	public List dGetJobCondTotal(Map map);
	
	/**
	 *  에러조치내역
	 * @param map
	 * @return
	 */
	public List dGetErrorLogTotal(Map map);
	
	/**
	 * EzJOBs에는 없고 C-M에만 있는 서비스/어플리케이션/그룹을 EzJOBs에 이관한다.
	 * @param paramMap
	 * @return
	 */
	public Map<String, Object> dPrcCmAppGrpInsert(Map<String, Object> paramMap);
	
	public List dGetErrorLogTotalCnt(Map map);
	public List<CommonBean> dGetQuartzList(Map<String, Object> paramMap);
	
	//작업 이력조회 팝업창
	public List<CommonBean> dGetJobHistoryInfo(Map map);
	
	// 스마트 폴더
	public CommonBean dGetSmartTableChk(Map map);
	public List<AppGrpBean> dGetSubTableList(Map<String, Object> map);
	public List<CommonBean> dGetSmartTreeList(Map<String, Object> map);
	public List<CommonBean> dGetSmartTreeInfoList(Map<String, Object> map);
	
	//setvar table 조회
	public List<CommonBean> dGetSetvarList(Map map);
}
	
	
